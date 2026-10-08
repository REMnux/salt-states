#!/usr/bin/env python3
"""Copy test results out of a directory the code under test could write to.

Usage: collect.py SRC DST REPORT

Salt states run as root in the test container and can write anything into its output directory,
including symlinks that point at files on the host. run.sh therefore removes the container first,
then calls this to copy only regular files, never following a symlink, into DST, a new directory
that no container ever mounts. Nothing else (symlinks, devices, FIFOs, oversized files) is copied,
and each skip is noted in REPORT, which lives outside DST. Any error exits non-zero, and run.sh
then fails the test instead of trusting a partial copy.
"""
import os, stat, sys

MAX_FILE = 50 * 1024 * 1024
MAX_TOTAL = 500 * 1024 * 1024


def main(src, dst, report):
    os.makedirs(dst)  # must be new, so nothing in it predates this copy
    skipped, total = [], 0
    for root, dirs, files in os.walk(src, followlinks=False):
        rel = os.path.relpath(root, src)
        for name in sorted(dirs):  # os.walk doesn't descend into symlinked directories; record them
            if os.path.islink(os.path.join(root, name)):
                skipped.append(f'{os.path.join(rel, name)}: symlink')
        for name in sorted(files):
            path = os.path.join(root, name); relpath = os.path.normpath(os.path.join(rel, name))
            try:
                fd = os.open(path, os.O_RDONLY | os.O_NOFOLLOW | getattr(os, 'O_NONBLOCK', 0))
            except OSError as e:
                skipped.append(f'{relpath}: {e.strerror}'); continue
            with os.fdopen(fd, 'rb') as f:
                st = os.fstat(f.fileno())
                if not stat.S_ISREG(st.st_mode):
                    skipped.append(f'{relpath}: not a regular file'); continue
                if st.st_size > MAX_FILE or total + st.st_size > MAX_TOTAL:
                    skipped.append(f'{relpath}: too large ({st.st_size} bytes)'); continue
                out = os.path.join(dst, relpath)
                os.makedirs(os.path.dirname(out), exist_ok=True)
                with open(out, 'wb') as g:
                    g.write(f.read(MAX_FILE + 1)[:MAX_FILE])
                total += st.st_size
    if skipped:
        with open(report, 'w') as g:
            g.write('\n'.join(skipped) + '\n')


if __name__ == '__main__':
    if len(sys.argv) != 4:
        sys.exit(__doc__)
    main(sys.argv[1], sys.argv[2], sys.argv[3])
