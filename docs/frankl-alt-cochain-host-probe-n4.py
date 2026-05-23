#!/usr/bin/env python3
"""n=4 sanity check for the sgn-twisted cochains identified in
docs/frankl-alt-cochain-host-probe.py.  We confirm the SGN-MOB-TOP /
SGN-DEFICIT / SGN-COUNT constructions still give non-zero sgn class on
a SAMPLE of CE-shape F at n=4.  Full enumeration of 582 CE-shape F's is
unnecessary for the verdict; the structural argument predicts
non-zero, and we verify a non-trivial subset.
"""

from itertools import combinations, permutations
from functools import reduce
import sys
import importlib.util

spec = importlib.util.spec_from_file_location("probe", "docs/frankl-alt-cochain-host-probe.py")
P = importlib.util.module_from_spec(spec)
spec.loader.exec_module(P)

n = 4
ground = frozenset(range(n))

# Sample CE-shape F's at n=4 -- pick a few of varying sizes
print(f"n={n}: enumerating union-closed...")
uc = P.enumerate_union_closed(n)
print(f"  total union-closed (size >= 1): {len(uc)}")
ce_shape = [F for F in uc if P.is_ce_shape(F, ground)]
print(f"  CE-shape F-stars: {len(ce_shape)}")

# Sort by size for a representative sample
ce_shape_sorted = sorted(ce_shape, key=lambda F: (len(F), len(min(F, key=len))))
# Pick 10: smallest few, fully-symmetric ones, largest
sample = ce_shape_sorted[:5] + ce_shape_sorted[-3:] + [ce_shape_sorted[len(ce_shape_sorted) // 2]]

chains_top = P.proper_boolean_chains(n)
_, cob_cols = P.coboundary_columns_punctured_boolean(n)
print(f"  punctured-Boolean top-dim chains at n=4: {len(chains_top)} (= n!)")
print(f"  coboundary columns: {len(cob_cols)}")

cochain_names = ['C-SGN-MOB-TOP', 'C-SGN-DEFICIT', 'C-SGN-COUNT', 'C-SGN-MOB-BOT', 'C-SGN-MOB-PROD']

results = []
for F in sample:
    coch = P.build_cochains(F, n, chains_top)
    row = {'F': P.show_fam(F), 'size': len(F)}
    for name in cochain_names:
        c = coch[name]
        sgn_proj = P.sgn_project_cochain(c, chains_top, n)
        nz, _ = P.class_nonzero(sgn_proj, chains_top, cob_cols)
        row[name] = nz
    results.append(row)

print(f"\n  Sample CE-shape F's at n={n}: sgn-class non-zero per cochain")
print(f"  {'F':<60s} {'sz':>3s}", end='')
for name in cochain_names:
    short = name.replace('C-SGN-', 'S-').replace('MOB-', 'M').replace('DEFICIT', 'DEF').replace('COUNT', 'CNT').replace('PROD', 'P')
    print(f" {short:>6s}", end='')
print()
for r in results:
    print(f"  {r['F']:<60s} {r['size']:>3d}", end='')
    for name in cochain_names:
        print(f" {('1' if r[name] else '0'):>6s}", end='')
    print()

# Aggregate over all 582 CE-shape F's at n=4 -- the structural prediction:
# SGN-DEFICIT and SGN-COUNT should be non-zero for ALL of them.
print(f"\n  -- Full aggregate over all {len(ce_shape)} CE-shape F's at n=4 --")
counts = {name: 0 for name in cochain_names}
import time
t0 = time.time()
for i, F in enumerate(ce_shape):
    coch = P.build_cochains(F, n, chains_top)
    for name in cochain_names:
        c = coch[name]
        sgn_proj = P.sgn_project_cochain(c, chains_top, n)
        nz, _ = P.class_nonzero(sgn_proj, chains_top, cob_cols)
        if nz:
            counts[name] += 1
    if (i + 1) % 50 == 0:
        print(f"   [{i+1}/{len(ce_shape)}, {time.time()-t0:.1f}s]")
for name in cochain_names:
    print(f"  {name:<18s} : non-zero sgn-class {counts[name]:3d}/{len(ce_shape)} CE-shape F's")
