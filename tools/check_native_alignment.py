#!/usr/bin/env python3
"""Reports whether the app's native libraries support 16 KB memory pages.

Google Play requires apps targeting Android 15+ to work on devices with
16 KB pages. For 64-bit libraries that means every loadable segment in the
ELF file must be aligned to at least 16384 bytes (0x4000).

Reads the libraries Gradle merged for the app (no APK is built) and prints
one line per library. Findings are also written as GitHub Actions
annotations so they can be read without log access.

Usage: check_native_alignment.py <build-dir>
Exit code is always 0: this is an informational check.
"""
import struct
import sys
from pathlib import Path

REQUIRED = 16384
CHECKED_ABIS = {"arm64-v8a", "x86_64"}  # the 64-bit ABIs 16 KB pages apply to
PT_LOAD = 1


def min_load_alignment(path: Path):
    """Smallest p_align over the PT_LOAD segments of a 64-bit ELF, or None."""
    with path.open("rb") as f:
        header = f.read(64)
        if len(header) < 64 or header[:4] != b"\x7fELF" or header[4] != 2:
            return None  # not a 64-bit ELF
        little = header[5] == 1
        endian = "<" if little else ">"
        e_phoff = struct.unpack(endian + "Q", header[0x20:0x28])[0]
        e_phentsize, e_phnum = struct.unpack(endian + "HH", header[0x36:0x3A])
        alignments = []
        for i in range(e_phnum):
            f.seek(e_phoff + i * e_phentsize)
            entry = f.read(e_phentsize)
            p_type = struct.unpack(endian + "I", entry[0:4])[0]
            if p_type == PT_LOAD:
                alignments.append(struct.unpack(endian + "Q", entry[0x30:0x38])[0])
        return min(alignments) if alignments else None


def main() -> int:
    build_dir = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(".")
    roots = [p for p in build_dir.rglob("merged_native_libs") if p.is_dir()]
    if not roots:
        print(f"::warning title=16KB check::no merged_native_libs found under {build_dir}")
        return 0

    libs = sorted({p for root in roots for p in root.rglob("*.so")})
    bad, good = [], []
    for lib in libs:
        abi = lib.parent.name
        if abi not in CHECKED_ABIS:
            continue
        align = min_load_alignment(lib)
        if align is None:
            continue
        (good if align >= REQUIRED else bad).append((abi, lib.name, align))

    for abi, name, align in good + bad:
        status = "ok " if align >= REQUIRED else "BAD"
        print(f"{status} {abi:10} {name:40} min LOAD align = {align}")

    summary = (
        f"{len(good)} of {len(good) + len(bad)} 64-bit libraries are 16 KB aligned"
    )
    if bad:
        names = "%0A".join(f"{abi}/{name} (align {align})" for abi, name, align in bad)
        print(f"::warning title=16KB alignment::{summary}. NOT aligned:%0A{names}")
    else:
        names = "%0A".join(sorted({f"{abi}/{name}" for abi, name, _ in good}))
        print(f"::notice title=16KB alignment::{summary}.%0A{names}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
