#!/usr/bin/env python3
"""
Frankl-IE-Induction-Probe : DIAGNOSTIC follow-up.

Now that the LIFT-4-prod operationalization produced 24/61 non-zero
sgn-isotype classes in H^{n-2}(punctured Boolean) at n=3, characterize:

  (a) Which 24 F's give non-zero?  Are they all the union-closed ones?
      The intersection-closed ones?  Counterexample-shape ones?
  (b) Is LIFT-4-prod a coboundary in disguise, or genuinely non-trivial?
  (c) What is the explicit class for each F?
  (d) Does the class distinguish counterexample-shaped F-star from
      generic union-closed F (the Frankl-relevant test)?
"""

from itertools import combinations, permutations
import sys, time

PRIMES = (2147483647, 2147483629)
sys.path.insert(0, '/tmp')

# Reuse probe code
import importlib.util
spec = importlib.util.spec_from_file_location("probe", "/tmp/probe.py")
P = importlib.util.module_from_spec(spec)
spec.loader.exec_module(P)


def diagnose_n(n):
    print(f"\n{'='*78}")
    print(f"DIAGNOSTIC  n={n}")
    print(f"{'='*78}")

    ground = frozenset(range(n))
    moore = P.enumerate_moore(n)
    bool_simp = P.proper_boolean_complex(n)
    top_dim = n - 2

    # for each F, compute LIFT-4-prod class and detailed info
    rows = []
    for F in moore:
        cochains, _, m_F = P.moebius_cochain_boolean(F, n)
        c = cochains['LIFT-4-prod']
        nz, _, _ = P.cohomology_class_in_top(bool_simp, c, top_dim)
        sgn_proj = P.isotype_decompose_sgn(bool_simp, c, top_dim, n)
        sgn_nz, _, _ = P.cohomology_class_in_top(bool_simp, sgn_proj, top_dim)

        # also test: is F union-closed? counterexample-shape?
        uc = P.is_union_closed(F)
        ic = P.is_int_closed(F)
        rares = P.rare_witnesses(F, ground)
        ce_shape = (len(F) >= 2) and uc and not rares

        # |F| and other stats
        rows.append({
            'F': F, 'size': len(F),
            'uc': uc, 'ic': ic, 'ce_shape': ce_shape,
            'class_nz': nz, 'sgn_nz': sgn_nz,
            'cochain_sum': sum(c.values()),
            'rare_count': len(rares),
        })

    # summary
    print(f"  Moore families: {len(rows)}")
    print(f"  with non-zero LIFT-4-prod class:  {sum(1 for r in rows if r['class_nz'])}")
    print(f"  with non-zero sgn-projection:    {sum(1 for r in rows if r['sgn_nz'])}")
    print(f"  union-closed (besides Moore=ic): {sum(1 for r in rows if r['uc'])}")
    print(f"  counterexample-shape (uc + no rare): {sum(1 for r in rows if r['ce_shape'])}")

    print(f"\n  Cross-tab: class_nz x ce_shape")
    for cnz in (True, False):
        for ces in (True, False):
            cnt = sum(1 for r in rows if r['class_nz'] == cnz and r['ce_shape'] == ces)
            print(f"    class_nz={cnz}, ce_shape={ces}: {cnt}")

    # examples of non-zero F's
    print(f"\n  Sample non-zero F's (up to 10):")
    nz_rows = [r for r in rows if r['sgn_nz']]
    for r in nz_rows[:10]:
        print(f"    F (size {r['size']}, uc={r['uc']}, ic={r['ic']}, "
              f"ce_shape={r['ce_shape']}, rare={r['rare_count']}): "
              f"{P_show_fam(r['F'])}")

    # examples of ZERO F's
    print(f"\n  Sample zero F's (up to 10):")
    z_rows = [r for r in rows if not r['sgn_nz']]
    for r in z_rows[:10]:
        print(f"    F (size {r['size']}, uc={r['uc']}, ic={r['ic']}, "
              f"ce_shape={r['ce_shape']}, rare={r['rare_count']}): "
              f"{P_show_fam(r['F'])}")

    # Specific test: are the counterexample-shape F's distinguished?
    print(f"\n  Counterexample-shape (uc + no rare) families:")
    ce_rows = [r for r in rows if r['ce_shape']]
    for r in ce_rows:
        print(f"    F (size {r['size']}, class_nz={r['class_nz']}, "
              f"sgn_nz={r['sgn_nz']}): {P_show_fam(r['F'])}")

    # Now also check union-closed-only (not just Moore=intersection-closed).
    # Frankl's conjecture is about UNION-closed families on [n].
    # Enumerate all union-closed (size >= 2) and check the analogous question.
    print(f"\n  ----- Switch lattice: UNION-CLOSED families on [{n}] -----")
    uc_families = [F for F in P.enumerate_union_closed(n) if len(F) >= 2]
    print(f"  Union-closed families (size >= 2): {len(uc_families)}")

    uc_rows = []
    for F in uc_families:
        cochains, _, m_F = P.moebius_cochain_boolean(F, n)
        c = cochains['LIFT-4-prod']
        nz, _, _ = P.cohomology_class_in_top(bool_simp, c, top_dim)
        sgn_proj = P.isotype_decompose_sgn(bool_simp, c, top_dim, n)
        sgn_nz, _, _ = P.cohomology_class_in_top(bool_simp, sgn_proj, top_dim)
        rares = P.rare_witnesses(F, ground)
        ce_shape = not rares
        uc_rows.append({
            'F': F, 'class_nz': nz, 'sgn_nz': sgn_nz,
            'ce_shape': ce_shape, 'size': len(F),
        })

    print(f"  with non-zero LIFT-4-prod sgn class: {sum(1 for r in uc_rows if r['sgn_nz'])}")

    # cross-tab for union-closed
    print(f"\n  Cross-tab for union-closed: sgn_nz x ce_shape")
    for snz in (True, False):
        for ces in (True, False):
            cnt = sum(1 for r in uc_rows if r['sgn_nz'] == snz and r['ce_shape'] == ces)
            print(f"    sgn_nz={snz}, ce_shape={ces}: {cnt}")

    # CRITICAL FRANKL TEST: do the counterexample-shape union-closed F's
    # produce a SYSTEMATICALLY non-zero sgn class?  Or do CE-shape and
    # non-CE-shape behave the same?
    ce_uc = [r for r in uc_rows if r['ce_shape']]
    print(f"\n  Counterexample-shape union-closed (n={n}): {len(ce_uc)}")
    for r in ce_uc:
        print(f"    F (size {r['size']}, sgn_nz={r['sgn_nz']}): {P_show_fam(r['F'])}")

    # ALSO test: non-CE-shape union-closed of same size
    non_ce_uc = [r for r in uc_rows if not r['ce_shape']]
    print(f"\n  Non-counterexample-shape union-closed: {len(non_ce_uc)}")
    # show fraction with non-zero class by size
    from collections import Counter
    by_size = Counter()
    nz_by_size = Counter()
    for r in non_ce_uc:
        by_size[r['size']] += 1
        if r['sgn_nz']: nz_by_size[r['size']] += 1
    for s in sorted(by_size):
        print(f"    size {s}: {nz_by_size[s]}/{by_size[s]} non-zero sgn")

    # by size for CE shape
    by_size_ce = Counter()
    nz_by_size_ce = Counter()
    for r in ce_uc:
        by_size_ce[r['size']] += 1
        if r['sgn_nz']: nz_by_size_ce[r['size']] += 1
    print(f"\n  By size (CE-shape):")
    for s in sorted(by_size_ce):
        print(f"    size {s}: {nz_by_size_ce[s]}/{by_size_ce[s]} non-zero sgn")

    return rows, uc_rows


def P_show_fam(F):
    def show(s):
        return "{" + ",".join(str(i + 1) for i in sorted(s)) + "}" if s else "0"
    return "[" + " ".join(show(s) for s in sorted(F, key=lambda x: (len(x), sorted(x)))) + "]"


if __name__ == '__main__':
    rows3, uc_rows3 = diagnose_n(3)
    print(f"\n\n>>> Now n=4 (sample over a subset due to size) ...")
    rows4, uc_rows4 = diagnose_n(4)
