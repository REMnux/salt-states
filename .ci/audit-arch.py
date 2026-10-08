#!/usr/bin/env python3
"""
Check each documented tool's architecture metadata against what its state installs.

For every state file with a Category, this script renders the state twice in the
REMnux saltstack-tester container, once as amd64 and once as arm64 (by setting the
osarch grain), and compares the renders with the Architecture field in the
frontmatter (omitted means both). It is a consistency check of the Salt code, not
proof that a tool runs: packaging-level gaps (a Debian package built without a
feature) and runtime failures don't show up in a render, so the Amd64/Arm64 notes
stay human-written.

Per architecture, a state is:
  skipped    its own states are only a "Skipped on <arch>" notification
  available  it renders states that install something
  silent     it installs nothing on one architecture but something on the other,
             with no notification (error: add a "Skipped on <arch>" notification)
  stub       it installs nothing on either architecture, e.g. a docs-only state or a
             Jinja macro library. Needs an entry in arch-acks.json that names the
             state providing the tool ("provider") or asserts its architectures.

Errors:
  - a render fails
  - the frontmatter claim differs from the render
  - a silent skip
  - the two renders install different states (including included states) and
    arch-acks.json has no entry listing exactly those differences. An Amd64/Arm64
    note doesn't count as an acknowledgment, so a later, unrelated difference
    can't pass under an old note.
  - an arch-acks.json entry that no longer matches the renders

Warnings:
  - a download on one architecture whose file name suggests the other

Usage:
    # Render and audit every documented state (about 7 minutes)
    python3 .ci/audit-arch.py

    # Audit specific states
    python3 .ci/audit-arch.py remnux.tools.trid remnux.packages.radare2

    # Reuse renders from an earlier run (written with --keep)
    python3 .ci/audit-arch.py --keep /tmp/renders
    python3 .ci/audit-arch.py --renders /tmp/renders
"""

import argparse
import json
import re
import subprocess
import sys
import tempfile
from pathlib import Path

from frontmatter import ARCHES, parse_architectures, parse_header

DEFAULT_IMAGE = "remnux/saltstack-tester:noble3006"
ACKS_FILE = Path(__file__).parent / "arch-acks.json"
FOREIGN_ARTIFACT = {
    "arm64": re.compile(r"x86[_-]64|amd64|[-_.]x64\b|linux64|i386|win32|\.exe\b", re.I),
    "amd64": re.compile(r"aarch64|arm64", re.I),
}


def gitignored(salt_states: Path, files: list) -> set:
    """Return the files git ignores (local drafts), or an empty set outside a git tree."""
    try:
        result = subprocess.run(
            ["git", "-C", str(salt_states), "check-ignore", "--stdin", "-z"],
            input=b"\x00".join(str(f).encode() for f in files),
            stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, check=False,
        )
    except OSError:
        return set()
    if result.returncode > 1:  # 0 = some ignored, 1 = none ignored
        return set()
    return {Path(p) for p in result.stdout.decode().split("\x00") if p}


def documented_states(salt_states: Path) -> dict:
    """Return {state name: frontmatter fields} for state files with a Category.

    Gitignored drafts are skipped, as update-docs.py skips them. An init.sls with a
    Category documents its directory's state (remnux/config/objects/init.sls is
    remnux.config.objects).
    """
    states = {}
    files = sorted((salt_states / "remnux").rglob("*.sls"))
    ignored = gitignored(salt_states, files)
    for sls in files:
        if sls.parent == salt_states / "remnux" or sls in ignored:
            continue  # bundles (addon.sls, cloud.sls, ...) and local drafts
        fields = parse_header(sls.read_text(errors="replace")).fields
        if fields.get("category"):
            rel = sls.relative_to(salt_states / "remnux").with_suffix("")
            parts = rel.parts[:-1] if rel.name == "init" else rel.parts
            states["remnux." + ".".join(parts)] = fields
    return states


def render(salt_states: Path, states: list, out_dir: Path, image: str) -> None:
    """Render each state for both architectures into out_dir/<arch>/<state>.json."""
    (out_dir / "states.txt").write_text("\n".join(states) + "\n")
    script = (
        "for a in " + " ".join(ARCHES) + "; do echo \"osarch: $a\" > /etc/salt/grains; mkdir -p /out/$a; "
        "while read s; do [ -n \"$s\" ] || continue; "
        "salt-call --local --out=json state.show_sls $s > /out/$a/$s.json 2> /out/$a/$s.err; "
        "done < /out/states.txt; done"
    )
    print(f"Rendering {len(states)} states for {', '.join(ARCHES)} in {image}...", file=sys.stderr)
    subprocess.run(
        ["docker", "run", "--rm",
         "-v", f"{salt_states / 'remnux'}:/srv/salt/remnux:ro",
         "-v", f"{out_dir}:/out",
         image, "bash", "-c", script],
        check=True, stdin=subprocess.DEVNULL, timeout=3600,
    )


def load_render(out_dir: Path, arch: str, state: str):
    """Return the rendered state dict, or None if the render failed."""
    try:
        data = json.loads((out_dir / arch / f"{state}.json").read_text())["local"]
    except (OSError, ValueError, KeyError, TypeError):
        return None
    return data if isinstance(data, dict) else None  # a failed render returns a list


def functions(state_data: dict) -> list:
    """Return [(module, function, args)] for one rendered state ID."""
    result = []
    for module, args in state_data.items():
        if module.startswith("__") or not isinstance(args, list):
            continue
        fn = next((a for a in args if isinstance(a, str)), "")
        result.append((module, fn, args))
    return result


def classify(rendered: dict, state: str, arch: str) -> str:
    """Classify one architecture's render of a state: skipped, available, or empty."""
    own = [v for v in rendered.values() if isinstance(v, dict) and v.get("__sls__") == state]
    calls = [c for v in own for c in functions(v)]
    if not calls:
        return "empty"
    skip_text = f"Skipped on {arch}"
    def is_skip(call):
        module, fn, args = call
        return module == "test" and fn == "show_notification" and any(
            isinstance(a, dict) and str(a.get("text", "")).startswith(skip_text) for a in args)
    if all(is_skip(c) for c in calls):
        return "skipped"
    if all(module == "test" for module, _, _ in calls):
        return "empty"  # placeholders such as test.nop install nothing
    return "available"


def state_ids(rendered: dict) -> set:
    return {k for k, v in rendered.items() if not k.startswith("__") and isinstance(v, dict)}


def foreign_downloads(rendered: dict, arch: str) -> list:
    found = []
    for state_id, data in rendered.items():
        if state_id.startswith("__") or not isinstance(data, dict):
            continue
        for _, _, args in functions(data):
            for a in args:
                source = a.get("source") if isinstance(a, dict) else None
                if isinstance(source, str) and FOREIGN_ARTIFACT[arch].search(source):
                    found.append(f"{state_id}: {source}")
    return found


ACK_KEYS = {"reason", "provider", "asserted", "missing_on_amd64", "missing_on_arm64"}


def validate_acks(acks) -> list:
    """Check the shape of arch-acks.json before trusting any entry."""
    if not isinstance(acks, dict):
        return ["arch-acks.json must contain a JSON object"]
    errors = []
    for state, ack in acks.items():
        if not isinstance(ack, dict):
            errors.append(f"{state}: arch-acks.json entry must be an object")
            continue
        if not isinstance(ack.get("reason"), str) or not ack["reason"].strip():
            errors.append(f"{state}: arch-acks.json entry needs a non-empty \"reason\"")
        unknown = sorted(set(ack) - ACK_KEYS)
        if unknown:
            errors.append(f"{state}: unknown arch-acks.json keys: {', '.join(unknown)}")
        stub_keys = [k for k in ("provider", "asserted") if k in ack]
        diff_keys = [k for k in ack if k.startswith("missing_on_")]
        if len(stub_keys) > 1 or (stub_keys and diff_keys):
            errors.append(f"{state}: use one of provider, asserted, or missing_on_* lists")
        if "provider" in ack and not (isinstance(ack["provider"], str) and ack["provider"].startswith("remnux.")):
            errors.append(f"{state}: \"provider\" must be a state name such as remnux.packages.example")
        if "asserted" in ack:
            value = ack["asserted"]
            if not (isinstance(value, list) and value and all(a in ARCHES for a in value)):
                errors.append(f"{state}: \"asserted\" must be a non-empty list drawn from {', '.join(ARCHES)}")
        for key in diff_keys:
            if not (isinstance(ack[key], list) and all(isinstance(i, str) for i in ack[key])):
                errors.append(f"{state}: \"{key}\" must be a list of state IDs")
    return errors


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("states", nargs="*", help="States to audit (default: every state with a Category)")
    parser.add_argument("--renders", help="Use renders in this directory instead of running the container")
    parser.add_argument("--keep", help="Write renders to this directory and keep them")
    parser.add_argument("--image", default=DEFAULT_IMAGE, help=f"Tester image (default: {DEFAULT_IMAGE})")
    args = parser.parse_args()

    salt_states = Path(__file__).resolve().parent.parent
    documented = documented_states(salt_states)
    targets = args.states or list(documented)
    unknown = [s for s in targets if s not in documented]
    if unknown:
        parser.error(f"Not a state with a Category: {', '.join(unknown)}")

    try:
        acks = json.loads(ACKS_FILE.read_text())
    except (OSError, ValueError) as e:
        print(f"ERROR: can't read {ACKS_FILE}: {e}")
        sys.exit(1)
    ack_errors = validate_acks(acks)
    if ack_errors:
        for e in ack_errors:
            print(f"ERROR: {e}")
        sys.exit(1)
    providers = sorted({a["provider"] for s, a in acks.items() if s in targets and "provider" in a})

    # Absolute paths, because docker treats a relative -v source as a volume name
    if args.renders:
        out_dir = Path(args.renders).resolve()
    else:
        out_dir = Path(args.keep).resolve() if args.keep else Path(tempfile.mkdtemp(prefix="audit-arch-"))
        out_dir.mkdir(parents=True, exist_ok=True)
        render(salt_states, targets + [p for p in providers if p not in targets], out_dir, args.image)

    errors, warnings = [], []

    def availability(state):
        renders = {a: load_render(out_dir, a, state) for a in ARCHES}
        failed = [a for a, r in renders.items() if r is None]
        if failed:
            errors.append(f"{state}: render failed on {', '.join(failed)} (see {out_dir}/<arch>/{state}.err)")
            return None, renders
        return {a: classify(renders[a], state, a) for a in ARCHES}, renders

    for state in targets:
        fields = documented[state]
        claimed, _ = parse_architectures(fields)  # invalid values are the lint's to report
        status, renders = availability(state)
        if status is None:
            continue
        ack = acks.get(state, {})

        if all(s == "empty" for s in status.values()):
            if "provider" in ack:
                pstatus, _ = availability(ack["provider"])
                if pstatus is None:
                    continue
                actual = tuple(a for a in ARCHES if pstatus[a] == "available")
            elif "asserted" in ack:
                actual = tuple(a for a in ARCHES if a in ack["asserted"])
            else:
                errors.append(f"{state}: installs nothing on either architecture. Add an arch-acks.json "
                              f"entry naming the provider state or asserting its architectures")
                continue
        else:
            for a in ARCHES:
                other = [b for b in ARCHES if b != a][0]
                if status[a] == "empty" and status[other] == "available":
                    errors.append(f"{state}: installs nothing on {a} and shows no notice. "
                                  f"Add a \"Skipped on {a}: ...\" test.show_notification state")
            actual = tuple(a for a in ARCHES if status[a] == "available")
            if "provider" in ack or "asserted" in ack:
                errors.append(f"{state}: arch-acks.json treats it as a stub, but it installs states")

        if set(actual) != set(claimed):
            errors.append(f"{state}: frontmatter says {', '.join(claimed)}, but the state installs on "
                          f"{', '.join(actual) or 'neither architecture'}")

        # Differences between the two renders, including included states
        if all(status[a] == "available" for a in ARCHES):
            ids = {a: state_ids(renders[a]) for a in ARCHES}
            diff = {f"missing_on_{a}": sorted(ids[b] - ids[a]) for a in ARCHES for b in ARCHES if a != b}
            if any(diff.values()):
                if not ack:
                    errors.append(f"{state}: installs different states per architecture with no arch-acks.json "
                                  f"entry. Differences: {json.dumps(diff)}")
                elif {k: sorted(ack.get(k, [])) for k in diff} != diff:
                    errors.append(f"{state}: arch-acks.json entry no longer matches. Now: {json.dumps(diff)}")
            elif ack:
                errors.append(f"{state}: arch-acks.json entry is stale; the renders no longer differ")
        elif any(k.startswith("missing_on_") for k in ack):
            errors.append(f"{state}: arch-acks.json lists differences, but the state no longer installs "
                          f"on both architectures. Remove the entry")

        for a in ARCHES:
            if status[a] == "available":
                for item in foreign_downloads(renders[a], a):
                    warnings.append(f"{state}: {a} download looks like another architecture's: {item}")

    for ack_state in acks:
        if ack_state not in documented:
            errors.append(f"{ack_state}: arch-acks.json entry for a state that has no Category or doesn't exist")

    for w in warnings:
        print(f"WARNING: {w}")
    for e in errors:
        print(f"ERROR: {e}")
    print(f"\nAudited {len(targets)} states: {len(errors)} error(s), {len(warnings)} warning(s)")
    sys.exit(1 if errors else 0)


if __name__ == "__main__":
    main()
