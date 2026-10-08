#!/bin/bash
# Runs inside a fresh ubuntu:24.04 container: install REMnux the way users do, with
# remnux-installer.sh and Cast, then list failed states from Cast's results.yaml.
# Usage: run_remnux_install.sh <mode> <installer-sha256> [version]
#   mode              cloud, dedicated, or addon
#   installer-sha256  expected SHA-256 of remnux-installer.sh (run.sh reads it from
#                     remnux/tools/remnux-installer.sls in the tested tree)
#   version           release to install, e.g. v2026.41.5 (default: the latest release)
# Writes /out/install.log, /out/results.yaml, /out/failed.txt, and /out/install.result ending in
# "VERDICT: PASS|FAIL <reason>". Exits 0 only on PASS.
mode=$1; sha=$2; version=${3:-}
res=/out/install.result; : > "$res"
trap 'chmod -R a+rX /out 2>/dev/null' EXIT
fail() { echo "VERDICT: FAIL $1" >> "$res"; exit 1; }
export DEBIAN_FRONTEND=noninteractive
echo "start $(date -u +%FT%TZ)" >> "$res"
{ apt-get update && apt-get install -y curl ca-certificates sudo python3 python3-yaml; } > /out/setup.log 2>&1 \
  || fail "could not install the installer's prerequisites"
id remnux > /dev/null 2>&1 || useradd -m -s /bin/bash remnux
curl -fsSL -o /tmp/remnux-installer.sh https://github.com/REMnux/distro/raw/refs/heads/master/files/remnux-installer.sh \
  || fail "could not download remnux-installer.sh"
echo "$sha  /tmp/remnux-installer.sh" | sha256sum -c - >> "$res" 2>&1 || fail "remnux-installer.sh does not match its pinned checksum"
args=(install "--mode=$mode" --user=remnux); [ -n "$version" ] && args+=("--version=$version")
echo "running: remnux-installer.sh ${args[*]}" >> "$res"
bash /tmp/remnux-installer.sh "${args[@]}" > /out/install.log 2>&1; rc=$?
echo "installer rc=$rc end $(date -u +%FT%TZ)" >> "$res"
cp /var/cache/cast/installer/logs/results.yaml /out/results.yaml 2>/dev/null || fail "no results.yaml (installer rc=$rc)"
cp /var/cache/cast/installer/logs/saltstack.log /out/saltstack.log 2>/dev/null
INSTALLER_RC=$rc python3 - >> "$res" 2>&1 <<'PY'
import os, sys, yaml
try:
    d = yaml.safe_load(open('/out/results.yaml'))
    d = d.get('local', d) if isinstance(d, dict) else d
except Exception as e:
    print(f'VERDICT: FAIL could not read results.yaml ({e})'); sys.exit(1)
if not isinstance(d, dict) or not d:
    print('VERDICT: FAIL results.yaml lists no states'); sys.exit(1)
failed, malformed = [], []
for k, v in d.items():
    # Every entry must be a state result with an explicit true or false; anything else (an error
    # list, a null, a missing result) means the run didn't report cleanly, so it fails.
    if not isinstance(v, dict) or not isinstance(v.get('result'), bool) or '_|-' not in str(k):
        malformed.append(str(k)[:120]); continue
    if v['result'] is True: continue
    parts = str(k).split('_|-')
    comment = ' '.join(str(v.get('comment', '')).split())
    failed.append((v.get('__sls__', '?'), parts[1] if len(parts) > 1 else k, comment))
failed.sort()
root = [f for f in failed if not f[2].startswith('One or more requisite failed')]
with open('/out/failed.txt', 'w') as fh:
    for sls, sid, comment in failed: fh.write(f'{sls} | {sid} | {comment[:300]}\n')
print(f'states={len(d)} failed={len(root)} blocked_by_failed_requisite={len(failed) - len(root)} malformed={len(malformed)}')
for k in malformed: print(f'malformed: {k}')
if malformed:
    print(f'VERDICT: FAIL {len(malformed)} result entries are not state results'); sys.exit(1)
for sls, sid, comment in root: print(f'failed: {sls} | {sid} | {comment[:200]}')
rc = int(os.environ.get('INSTALLER_RC', '1'))
if failed:
    print(f'VERDICT: FAIL {len(root)} state(s) failed, {len(failed) - len(root)} more skipped because a requisite failed'); sys.exit(1)
if rc != 0:
    print(f'VERDICT: FAIL every state succeeded, but the installer exited {rc}'); sys.exit(1)
print('VERDICT: PASS remnux install succeeded and every state succeeded')
PY
