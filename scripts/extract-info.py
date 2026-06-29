#!/usr/bin/env python3
"""
extract-info.py

Mengambil nilai \newcommand{KEY}{VALUE} dari berkas konfigurasi LaTeX
(src/config/information.tex). Dipakai oleh Makefile untuk membangun
nama PDF secara otomatis.

Pemakaian:
    python3 scripts/extract-info.py KEY [FILE]
"""
import re
import sys
import os


def extract(key: str, filename: str) -> str:
    if not os.path.exists(filename):
        return ""
    with open(filename, encoding="utf-8") as f:
        content = f.read()
    # \newcommand{\KEY}{VALUE}  --> ambil VALUE
    pattern = re.compile(
        r"\\newcommand\{\\" + re.escape(key) + r"\}\{(.+?)\}",
        re.MULTILINE,
    )
    m = pattern.search(content)
    return m.group(1) if m else ""


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: extract-info.py KEY [FILE]", file=sys.stderr)
        sys.exit(1)
    key = sys.argv[1]
    filename = sys.argv[2] if len(sys.argv) > 2 else "src/config/information.tex"
    print(extract(key, filename))
