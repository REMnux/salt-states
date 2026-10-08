#!/bin/bash
# Runs inside the test container: apply the whole remnux.addon bundle, then list failed states.
# Writes /out/result.json (Salt's JSON output), /out/failed.txt, and /out/full.result ending in
# "VERDICT: PASS|FAIL <reason>". Exits 0 only on PASS.
res=/out/full.result; : > "$res"
# Salt writes its log as root with mode 0640; make every result readable by the runner's user.
trap 'chmod -R a+rX /out 2>/dev/null' EXIT
echo "start $(date -u +%FT%TZ)" >> "$res"
salt-call --local --file-root=/srv/salt --log-file=/out/salt.log --log-file-level=warning \
  --out=json --out-file=/out/result.json state.sls remnux.addon > /out/stdout.txt 2> /out/stderr.txt
rc=$?; echo "salt rc=$rc end $(date -u +%FT%TZ)" >> "$res"
SALT_RC=$rc /opt/saltstack/salt/bin/python3 - >> "$res" 2>&1 <<'PY'
import json, os, sys
try:
    d = json.load(open('/out/result.json'))['local']
except Exception as e:
    print(f'VERDICT: FAIL could not read Salt results ({e})'); sys.exit(1)
if isinstance(d, dict) and not d:
    print('VERDICT: FAIL Salt ran no states'); sys.exit(1)
if isinstance(d, list):
    open('/out/failed.txt', 'w').write('\n'.join(map(str, d)) + '\n')
    print('VERDICT: FAIL the bundle did not render (see failed.txt)'); sys.exit(1)
failed = []
for k, v in d.items():
    if v.get('result') is True: continue
    parts = k.split('_|-')
    comment = ' '.join(str(v.get('comment', '')).split())
    failed.append((v.get('__sls__', '?'), parts[1], parts[2] if len(parts) > 2 else '', comment))
failed.sort()
root = [f for f in failed if not f[3].startswith('One or more requisite failed')]
with open('/out/failed.txt', 'w') as fh:
    for sls, sid, name, comment in failed: fh.write(f'{sls} | {sid} | {name} | {comment[:300]}\n')
print(f'states={len(d)} failed={len(root)} blocked_by_failed_requisite={len(failed) - len(root)}')
for sls, sid, name, comment in root: print(f'failed: {sls} | {sid} | {name} | {comment[:200]}')
salt_rc = int(os.environ.get('SALT_RC', '1'))
if not failed and salt_rc != 0:
    print(f'VERDICT: FAIL every state succeeded, but Salt exited {salt_rc}'); sys.exit(1)
print('VERDICT: PASS every state succeeded' if not failed else
      f'VERDICT: FAIL {len(root)} state(s) failed, {len(failed) - len(root)} more skipped because a requisite failed')
sys.exit(1 if failed else 0)
PY
