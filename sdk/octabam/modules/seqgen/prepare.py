#!/usr/bin/env python3
"""Regenerate SEQGEN's control.s from its authored C and hooks.s.
Run the compiler in the isolated toolchain; firmware is not an input. The
CONTROL node copy stays a zero placeholder (StockCopy fills it at build time).
"""
from pathlib import Path
import argparse
import re
import subprocess
import tempfile

FLAGS = ['-mcpu=5475', '-msoft-float', '-O2', '-ffreestanding', '-fno-builtin',
         '-fno-common', '-fno-jump-tables', '-fno-asynchronous-unwind-tables',
         '-fno-ident', '-fomit-frame-pointer', '-fno-zero-initialized-in-bss',
         '-fno-tree-loop-distribute-patterns', '-fno-ivopts', '-Wall', '-Wextra', '-Werror',
         '-Wno-maybe-uninitialized']  # engine arrays are filled for i < L before use; ASan covers it


def autoinc_overlap(line):
    """`move.b (%a0)+,(%a0,%d1.l)`: the destination sees the incremented a0."""
    parts = re.match(r'\s*[a-z][a-z0-9.]*\s+(.*)$', line)
    if not parts:
        return False
    operands = re.split(r',(?![^(]*\))', parts.group(1))
    if len(operands) != 2:
        return False
    for i, operand in enumerate(operands):
        for reg in re.findall(r'\((%a\d)\)\+|-\((%a\d)\)', operand):
            reg = reg[0] or reg[1]
            if reg in operands[1 - i]:
                return True
    return False


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    here = Path(__file__).resolve().parent
    if args.output.exists():
        parser.error('Output exists; use a fresh private build directory.')
    with tempfile.TemporaryDirectory(prefix='seqgen-cf.') as directory:
        work = Path(directory)
        unity = work / 'seqgen.c'
        unity.write_text('#include "engine.c"\n#include "native.c"\n')
        assembly = work / 'seqgen.s'
        subprocess.run(['m68k-elf-gcc', *FLAGS, '-I', str(here), '-S', str(unity), '-o', str(assembly)], check=True)
        text = assembly.read_text()
        for helper in ('memcpy', 'memset', '__mulsi3', '__divsi3', '__udivsi3', '__modsi3', '__umodsi3'):
            if helper in text:
                raise SystemExit('Compiled SEQGEN calls ' + helper + '; the DRAM unit has no runtime library')
        for number, line in enumerate(text.splitlines(), 1):
            if autoinc_overlap(line):
                raise SystemExit('Compiled SEQGEN line %d reuses an auto-incremented register in its other operand: %s' % (number, line.strip()))
        args.output.write_text(text + '\n#APP\n' + (here / 'hooks.s').read_text())
    print('Prepared authored SEQGEN ColdFire source with a zero stock placeholder.')


if __name__ == '__main__':
    main()
