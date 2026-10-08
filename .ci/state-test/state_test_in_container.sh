#!/bin/bash
# Runs inside a test container. Do not call directly; run_state_tests.py mounts a frozen copy.
# Usage: state_test_in_container.sh <scenario> <new_state> <old_state> <verify_command> <block_hosts> <allow_changes>
#   fresh     apply <new_state> from /srv/salt, run verify, apply again to check idempotency
#   upgrade   apply <old_state> from /srv/base (the base ref) first; it must succeed. Then as fresh.
#   failsafe  apply <old_state> from /srv/base and verify it, block <block_hosts> in /etc/hosts,
#             apply <new_state>: it must FAIL, and its output must show a network error. Then verify
#             again: the output must match the pre-change verify output exactly.
# <allow_changes>: comma-separated state IDs allowed to report changes on the second run (for
# example remnux-repo, which re-registers the PPA on every run). Any other change fails the test.
# The verify command runs with `bash -e -o pipefail`, so every command in it must succeed.
# $EXPECT_FILE_ARCH holds what `file` prints for this architecture's ELF binaries
# ("x86-64" or "ARM aarch64"); assert with: file -L "$(command -v TOOL)" | grep -q "$EXPECT_FILE_ARCH"
# Writes /out/<arch>-<scenario>.result ending in "VERDICT: PASS|FAIL|INCONCLUSIVE <reason>",
# plus .log (salt output). Exits 0 only on PASS.
scenario=$1; new=$2; old=$3; verify=$4; block=${5:-}; allow=${6:-}
arch=$(dpkg --print-architecture); res=/out/$arch-$scenario.result; log=/out/$arch-$scenario.log
case $(uname -m) in aarch64) export EXPECT_FILE_ARCH="ARM aarch64" ;; x86_64) export EXPECT_FILE_ARCH="x86-64" ;; esac
SC="salt-call --local --retcode-passthrough --state-output=terse"
PY=/opt/saltstack/salt/bin/python3; [ -x "$PY" ] || PY=python3
: > "$res"; : > "$log"
verdict() { echo "VERDICT: $1 $2" >> "$res"; [ "$1" = PASS ]; exit $?; }
# run_verify <label> <capture file>: output goes to the result file and to the capture file.
run_verify() { echo "--- verify ($1): $verify" >> "$res"; bash -e -o pipefail -c "$verify" > "$2" 2>&1; local rc=$?
  cat "$2" >> "$res"; echo "verify rc=$rc" >> "$res"; return $rc; }

case "$scenario" in fresh|upgrade|failsafe) ;; *) verdict FAIL "unknown scenario '$scenario'" ;; esac

if [ "$scenario" != fresh ]; then
  $SC --file-root=/srv/base state.sls "$old" >> "$log" 2>&1; orc=$?; echo "old state rc=$orc" >> "$res"
  [ "$orc" -eq 0 ] || verdict INCONCLUSIVE "the old state failed (rc=$orc), so there was no working install to start from; run fresh instead"
  # A state can succeed without installing anything (an arm64 skip notification, for example),
  # and then "upgrade" would only exercise a fresh install.
  run_verify "old install, before the change" /tmp/verify_before || verdict INCONCLUSIVE "the old state installed nothing that passes verify, so this would only test a fresh install"
fi
if [ "$scenario" = failsafe ]; then
  [ -n "$block" ] || verdict INCONCLUSIVE "no hosts to block"
  for h in $block; do echo "127.0.0.1 $h" >> /etc/hosts; done
  echo "blocked: $block" >> "$res"
fi
mark=$(wc -l < "$log")
$SC --file-root=/srv/salt state.sls "$new" >> "$log" 2>&1; nrc=$?; echo "new state rc=$nrc" >> "$res"
if [ "$scenario" = failsafe ]; then
  [ "$nrc" -ne 0 ] || verdict INCONCLUSIVE "the new state succeeded with hosts blocked, so the failure path was never exercised"
  # Evidence the failure came from the network: a standard network error. A blocked hostname
  # alone is not enough, because a state can print a URL and fail for an unrelated reason.
  net=$(tail -n +"$((mark + 1))" "$log" | grep -m1 -oE 'NewConnectionError|Failed to establish a new connection|Connection refused|Temporary failure in name resolution|Could not resolve host|Network is unreachable|from versions: none|Failed to cache' | head -1)
  [ -n "$net" ] || verdict INCONCLUSIVE "the new state failed, but its output shows no network error, so it may have failed for another reason"
  echo "network failure evidence: \"$net\"" >> "$res"
  run_verify "after the failed change" /tmp/verify_after || verdict FAIL "the failed change broke the old install"
  cmp -s /tmp/verify_before /tmp/verify_after || verdict FAIL "verify output changed, so the old install did not survive intact"
  verdict PASS "the old install survived a failed change unchanged"
fi
[ "$nrc" -eq 0 ] || verdict FAIL "the new state failed (rc=$nrc)"
salt-call --local --retcode-passthrough --file-root=/srv/salt --out=json state.sls "$new" > /tmp/second.json 2>/dev/null; src=$?
idem=$(ALLOW="$allow" $PY - <<'PY' 2>&1
import json, os
allow = {x for x in os.environ.get('ALLOW', '').split(',') if x}
try:
    d = json.load(open('/tmp/second.json'))['local']
    assert isinstance(d, dict) and d, 'empty result'
    assert all(isinstance(v, dict) and 'result' in v for v in d.values()), 'entries without a result'
except Exception as e:
    print('ERROR', e); raise SystemExit
ids = {k: k.split('_|-')[1] for k in d}
bad = [ids[k] for k, v in d.items() if v.get('result') is not True]
changed = [ids[k] for k, v in d.items() if v.get('changes')]
unexpected = [c for c in changed if c not in allow]
print(f'states={len(d)} not_ok={",".join(bad) or "-"} changed={",".join(changed) or "-"} '
      f'unexpected_changes={",".join(unexpected) or "-"}')
raise SystemExit(3 if bad else 4 if unexpected else 0)
PY
); irc=$?
echo "second run (rc=$src): $idem" >> "$res"
case "$idem" in ERROR*) verdict FAIL "could not read the second run's results ($idem)" ;; esac
[ "$src" -eq 0 ] || verdict FAIL "the second run exited $src"
[ "$irc" -ne 3 ] || verdict FAIL "the second run had states that did not succeed"
[ "$irc" -ne 4 ] || verdict FAIL "not idempotent: the second run changed states not in --allow-changes"
[ "$irc" -eq 0 ] || verdict FAIL "the second-run checker exited $irc"
run_verify "after the change" /tmp/verify_after || verdict FAIL "verify failed"
verdict PASS "installed, verified, idempotent"
