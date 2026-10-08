#!/bin/bash
# Test REMnux salt states in a fresh Ubuntu 24.04 container that has the Salt onedir bundle
# the REMnux installer uses. .github/workflows/test-states.yml calls this on GitHub's amd64 and
# arm64 runners; it also runs on any Docker host.
#
# Usage:
#   run.sh states "<state> [state ...]" [scenarios] [base-ref] [allow-changes] [verify]
#   run.sh full
#     scenarios      fresh,upgrade (default). upgrade applies the state from base-ref first.
#     base-ref       git ref holding the previous version (default: the latest v* tag)
#     allow-changes  comma-separated state IDs allowed to change on the second run
#                    (default: remnux-repo; pass "" to allow none)
#     verify         command run in the container after each state (default: true)
# Environment:
#   TARGET  checkout whose remnux/ tree is tested (default: the repo holding this script). The
#           workflow runs this script from master and points TARGET at the code under test, so
#           the code under test can't change how it is tested.
#   OUT     results directory (default: ./state-test-out)
#   ARCH    amd64 or arm64 (default: this host)
#   DEADLINE_SECONDS  total time allowed for all tests (default: 19800, 5.5 hours, which leaves
#           room under the workflow's 345-minute job limit for collecting and uploading results)
# Writes OUT/summary.md and per-test files. Exits 0 when nothing failed (INCONCLUSIVE doesn't fail).
# Containers write only to a scratch directory. After a container is gone, collect.py copies its
# regular files into OUT, so nothing the tested code writes (a symlink, say) reaches the host's
# own files or the uploaded results.
set -u
mode=${1:-}; here=$(cd "$(dirname "$0")" && pwd)
target=$(cd "${TARGET:-$here/../..}" && pwd)
out=${OUT:-$target/state-test-out}
# Never mix results with an earlier run: an existing, non-empty OUT gets a new subdirectory.
if [ -d "$out" ] && [ -n "$(ls -A "$out")" ]; then out=$out/run-$(date +%Y%m%d-%H%M%S)-$$; fi
mkdir -p "$out"; summary=$out/summary.md; echo "Results: $out"
arch=${ARCH:-$(uname -m)}
case $arch in x86_64|amd64) arch=amd64 ;; aarch64|arm64) arch=arm64 ;; *) echo "unsupported architecture $arch" >&2; exit 2 ;; esac
image=remnux-state-test:$arch
start=$(date +%s); deadline=$((start + ${DEADLINE_SECONDS:-19800}))
clean() { LC_ALL=C tr -d '\000-\010\013-\037\177'; }  # drop control characters from container text

# Containers write as root into the scratch directory, so remove its contents from inside a
# container, then the directory itself. Any running test container is removed first.
scratch=$(mktemp -d); active=""
cleanup() {
  [ -n "$active" ] && docker rm -f "$active" > /dev/null 2>&1
  docker run --rm --platform "linux/$arch" -v "$scratch:/s" "$image" find /s -mindepth 1 -delete > /dev/null 2>&1
  rm -rf "$scratch"
}
trap cleanup EXIT
trap 'exit 130' INT TERM

# A tree mounted into a container must be a real directory inside its parent. A symlink there
# (remnux -> /, say) would make Docker mount the host's own files, Docker socket included.
safe_tree() {  # $1 = directory to mount, $2 = the directory it must stay inside
  [ -d "$1" ] && [ ! -L "$1" ] || return 1
  local real parent; real=$(cd "$1" && pwd -P); parent=$(cd "$2" && pwd -P)
  case "$real" in "$parent"/*) return 0 ;; *) return 1 ;; esac
}
safe_tree "$target/remnux" "$target" || { echo "$target/remnux is not a plain directory inside $target" >&2; exit 2; }

# Run one test container with a deadline. A timeout stops the docker client, not the container,
# so the container gets a name and is removed explicitly. --init makes signals reach Salt.
run_container() {  # $1 = seconds, rest = docker run arguments
  local secs=$1; shift
  [ "$secs" -gt 0 ] || { echo "no time left to run a container" >&2; return 124; }
  active="state-test-$$-$RANDOM"
  timeout -k 30 "$secs" docker run --rm --init --name "$active" --platform "linux/$arch" "$@"; local rc=$?
  docker rm -f "$active" > /dev/null 2>&1; active=""
  return $rc
}
# Seconds left for the next container: at most $1, keeping 10 minutes to collect and upload.
budget() { local left=$((deadline - $(date +%s) - 600)); [ "$left" -lt "$1" ] && echo "$left" || echo "$1"; }

# Copy a container's results into a fresh directory no container mounts (see collect.py).
collect() {  # $1 = scratch dir, $2 = destination (must not exist), $3 = skip report
  # Files written as root may be unreadable to this user (Salt's log is 0640), even when the
  # container was killed before it could fix that; make them readable from a container first.
  docker run --rm --platform "linux/$arch" -v "$1:/s" "$image" chmod -R a+rX /s > /dev/null 2>&1
  python3 "$here/collect.py" "$1" "$2" "$3"
}

docker build -q --platform "linux/$arch" -t "$image" "$here" > /dev/null || { echo "image build failed" >&2; exit 2; }
echo "Salt in the test image: $(docker run --rm --platform "linux/$arch" "$image" salt-call --version)"
echo "Tested code: $(git -C "$target" rev-parse HEAD 2>/dev/null || echo unknown)"

if [ "$mode" = full ]; then
  echo "## Full install of remnux.addon on $arch" > "$summary"
  raw=$scratch/full; mkdir -p "$raw"
  secs=$(budget 19800)
  [ "$secs" -ge 300 ] || { echo "VERDICT: FAIL not run: the time budget ran out" >> "$summary"; cat "$summary"; exit 1; }
  run_container "$secs" -v "$target/remnux:/srv/salt/remnux:ro" -v "$raw:/out" \
    -v "$here/full_install.sh:/full.sh:ro" "$image" bash /full.sh > "$out/full.docker.txt" 2>&1; rc=$?
  collect "$raw" "$out/full" "$out/full-collect-skipped.txt"; crc=$?
  res=$out/full/full.result
  { echo '```'; clean 2>/dev/null < "$res" || echo "no result file (container rc=$rc)"
    [ "$rc" -eq 124 ] && echo "VERDICT: FAIL the full install ran out of time"
    [ "$crc" -eq 0 ] || echo "VERDICT: FAIL collecting the results failed"
    echo '```'; } >> "$summary"
  cat "$summary"
  [ "$rc" -eq 0 ] && [ "$crc" -eq 0 ] && [ "$(grep '^VERDICT: ' "$res" | tail -1 | cut -d' ' -f2)" = PASS ]; exit $?
fi

[ "$mode" = states ] || { echo "usage: run.sh states \"<state ...>\" [...] | run.sh full" >&2; exit 2; }
states=${2:-}; scenarios=${3:-fresh,upgrade}; base=${4:-}; allow=${5-remnux-repo}; verify=${6:-true}
[ -n "$states" ] || { echo "no states given" >&2; exit 2; }

# Resolve the upgrade base to a commit. An explicitly requested base that doesn't resolve is a
# setup error; with no base given, the latest v* tag is used.
explicit_base=$base
[ -n "$base" ] || base=$(git -C "$target" tag --list 'v*' --sort=-v:refname | head -1)
base_sha=""
if [ -n "$base" ]; then
  for cand in "$base" "origin/$base"; do
    base_sha=$(git -C "$target" rev-parse --verify --quiet "$cand^{commit}") && break
  done
fi
if [ -n "$explicit_base" ] && [ -z "$base_sha" ]; then
  echo "base ref '$explicit_base' does not resolve to a commit in $target" >&2; exit 2
fi
basedir=$scratch/base; emptydir=$scratch/empty; mkdir -p "$basedir/remnux" "$emptydir"; have_base=no
if [ -n "$base_sha" ] && (set -o pipefail; git -C "$target" archive "$base_sha" remnux | tar -x -C "$basedir") \
   && safe_tree "$basedir/remnux" "$basedir"; then have_base=yes; fi

{ echo "## State tests on $arch"; echo; echo "Base for upgrade: ${base:-none} ${base_sha:0:12} (available: $have_base)"; echo
  echo "| State | Scenario | Verdict | Reason |"; echo "|---|---|---|---|"; } > "$summary"
failed=0
for state in $states; do
  for scen in ${scenarios//,/ }; do
    d=$out/$state/$scen; raw=$scratch/$state/$scen; mkdir -p "$d" "$raw"
    if [ "$scen" = upgrade ] && [ "$have_base" = no ]; then
      echo "| $state | $scen | INCONCLUSIVE | no upgrade base available |" >> "$summary"; continue
    fi
    secs=$(budget 5400)
    if [ "$secs" -lt 300 ]; then
      echo "| $state | $scen | FAIL | not run: the time budget ran out |" >> "$summary"; failed=1; continue
    fi
    # Only the upgrade scenario gets the base tree; fresh gets an empty directory.
    src=$emptydir; [ "$scen" = upgrade ] && src=$basedir/remnux
    run_container "$secs" -v "$target/remnux:/srv/salt/remnux:ro" -v "$src:/srv/base/remnux:ro" \
      -v "$raw:/out" -v "$here/state_test_in_container.sh:/t.sh:ro" \
      "$image" bash /t.sh "$scen" "$state" "$state" "$verify" "" "$allow" > "$d/docker.txt" 2>&1
    rc=$?
    collect "$raw" "$d/files" "$d/collect-skipped.txt"; crc=$?
    line=$(grep '^VERDICT: ' "$d/files/$arch-$scen.result" 2>/dev/null | tail -1 | clean)
    v=$(echo "$line" | cut -d' ' -f2); reason=$(echo "$line" | cut -d' ' -f3- | tr '|' '/')
    [ -n "$v" ] || { v=FAIL; reason="no verdict (container rc=$rc)"; }
    [ "$rc" -eq 124 ] && { v=FAIL; reason="ran out of time"; }
    [ "$v" = PASS ] && [ "$rc" -ne 0 ] && { v=FAIL; reason="container rc=$rc"; }
    [ "$crc" -ne 0 ] && { v=FAIL; reason="collecting the results failed"; }
    [ "$v" = FAIL ] && failed=1
    echo "| $state | $scen | $v | $reason |" >> "$summary"
  done
done
cat "$summary"
exit $failed
