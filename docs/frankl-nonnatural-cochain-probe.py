#!/usr/bin/env python3
"""
Frankl-NonNatural-Cochain-Probe -- mg-e1e2.

Tests Daniel's 2026-05-23T05:37Z reminder: "now that we have a specific
frankl obstruction let us try out a few different things and see if any
help."  Specifically, the bypass angle that mg-e466 flagged in §4.2 of
docs/Frankl-IE-Induction-Probe.md:

  > A NON-F-natural construction.  A cochain whose dependence on F is
  > *not* through a function of F's Aut(F)-orbit type might evade the
  > symmetry-vanishing argument.  Examples of such non-natural data: a
  > choice of total ordering on [n], a marking of one element as "the
  > rare witness candidate," a generic basis chosen relative to F.

CONTEXT.  mg-e466 found that ANY F-natural cochain c_F (depending on F
only through Aut(F)-orbit data) has zero sgn-class on the 12 CE-shape
families at n=3 (100%) and 86% at n=4.  Reason: CE-shape families have
nontrivial aut(F) containing some transposition tau; if c_F is
aut(F)-equivariant, c_F is tau-symmetric, and Sigma_sigma sgn(sigma)
c_F(sigma . chain) vanishes when restricted to the tau-coset.

This probe tests the natural bypass: non-F-natural cochains parametrized
by extra data d (marked element x, ordering pi, external family F_0)
that explicitly BREAKS the F-symmetry.

For each family F and each non-natural construction, compute the
sgn-class of c_F^d in H^{n-2}(2^[n] \ {0, [n]}; Q) ~ sgn_{S_n}.  At n=3
the host is S^1 with H^1 = sgn_{S_3}; the sgn-class of any 1-cochain c
equals its cycle integral around the hexagonal 1-cycle of the punctured
Boolean lattice.

Outcome gate (per ticket mg-e1e2):
  - NON-NATURAL WORKS: at least one non-natural construction gives
    nonzero sgn-class on at least one CE-shape family F-star at n=3.
  - NON-NATURAL FAILS: every tested non-natural construction gives zero
    sgn-class on every CE-shape family.

The probe also reports which CE-shape families admit non-natural escape
(classified by aut(F)) and gives the structural reason for the rest.

All computations exact over Q (no modular arithmetic needed since the
cycle integral lives in Z at n=3).  Self-contained.
"""

from itertools import combinations, permutations, product
from fractions import Fraction


# ==========================================================================
# 0. Combinatorial helpers
# ==========================================================================
def all_subsets(n):
    return [frozenset(c) for k in range(n + 1) for c in combinations(range(n), k)]


def is_union_closed(F):
    Fs = set(F)
    return all((a | b) in Fs for a in Fs for b in Fs)


def rare_witnesses(F, ground):
    out = []
    for x in ground:
        cnt = sum(1 for A in F if x in A)
        if 2 * cnt <= len(F):
            out.append(x)
    return out


def is_ce_shape(F, ground):
    """Union-closed, |F| >= 2, no rare element."""
    if len(F) < 2:
        return False
    if not is_union_closed(F):
        return False
    return not rare_witnesses(F, ground)


def enumerate_union_closed(n):
    """All non-empty union-closed sub-collections of 2^[n]."""
    subs = all_subsets(n)
    M = len(subs)
    res = []
    for mask in range(1, 2 ** M):
        F = frozenset(subs[i] for i in range(M) if (mask >> i) & 1)
        if is_union_closed(F):
            res.append(F)
    return res


def aut_F(F, n):
    """Permutations sigma in S_n with sigma . F = F."""
    out = []
    for perm in permutations(range(n)):
        sF = frozenset(frozenset(perm[x] for x in A) for A in F)
        if sF == F:
            out.append(perm)
    return out


def parity(perm):
    n = len(perm)
    p = 0
    for i in range(n):
        for j in range(i + 1, n):
            if perm[i] > perm[j]:
                p += 1
    return p % 2


# ==========================================================================
# 1. Mobius transform of chi_F
# ==========================================================================
def moebius(F, n):
    m = {}
    for T in all_subsets(n):
        v = 0
        for k in range(len(T) + 1):
            for S in (frozenset(c) for c in combinations(T, k)):
                v += (-1) ** (len(T) - len(S)) * (1 if S in F else 0)
        m[T] = v
    return m


# ==========================================================================
# 2. Hexagonal cycle integral at n=3
# ==========================================================================
# Edges of the punctured Boolean lattice 2^[3] \ {empty, [3]} along the
# hex S^1: edges (singleton, doubleton), oriented around the hex.
# Hex cycle: {0}->{0,1}->{1}->{1,2}->{2}->{0,2}->{0} (using 0-indexed)
# Signed sum:  c(e1) - c(e2) + c(e3) - c(e4) + c(e5) - c(e6)
HEX_EDGES = [
    (frozenset({0}), frozenset({0, 1})),  # e1
    (frozenset({1}), frozenset({0, 1})),  # e2
    (frozenset({1}), frozenset({1, 2})),  # e3
    (frozenset({2}), frozenset({1, 2})),  # e4
    (frozenset({2}), frozenset({0, 2})),  # e5
    (frozenset({0}), frozenset({0, 2})),  # e6
]
HEX_SIGNS = [1, -1, 1, -1, 1, -1]


def cycle_integral(cochain):
    """At n=3: integral of a 1-cochain around the hexagonal 1-cycle.
       For n=3, H^1(punctured Boolean) = Z (~ sgn_{S_3}), and any
       1-cochain's class equals this integral (up to scale)."""
    return sum(s * cochain.get(e, 0) for s, e in zip(HEX_SIGNS, HEX_EDGES))


def all_edges_n3():
    return list(HEX_EDGES)


# ==========================================================================
# 3. Sgn-projection at n=3 (explicit check matching mg-e466 methodology)
# ==========================================================================
def sgn_project(cochain, n=3):
    """sgn_proj(c)(chain) = sum_sigma sgn(sigma) * c(sigma . chain)."""
    edges = all_edges_n3()
    out = {e: 0 for e in edges}
    for perm in permutations(range(n)):
        s = 1 if parity(perm) == 0 else -1
        for e in edges:
            (s0, s1) = e
            s0_post = frozenset(perm[x] for x in s0)
            s1_post = frozenset(perm[x] for x in s1)
            e_post = (s0_post, s1_post)
            out[e] += s * cochain.get(e_post, 0)
    return out


def sgn_class_nonzero(cochain, n=3):
    """At n=3 the sgn-class of c equals (up to scaling) the cycle integral
       of the sgn-projection of c.  Returns whether non-zero."""
    sp = sgn_project(cochain, n)
    return cycle_integral(sp) != 0


# ==========================================================================
# 4. Non-natural cochain candidates at n=3
# ==========================================================================
# A "non-natural" cochain depends on F PLUS extra data d (not derived
# from F's Aut(F)-orbit structure).
#
# Naming convention:  c_F^d(sigma_0 < sigma_1) where d is the
# non-natural choice (marked element, ordering, external family).

def cochain_natural_LIFT4_prod(F, n):
    """The F-natural LIFT-4-prod baseline (mg-e466).  Included as a
       control: should give zero sgn-class on CE-shape F's."""
    m = moebius(F, n)
    c = {}
    for e in HEX_EDGES:
        c[e] = m[e[0]] * m[e[1]]
    return c


# --- (a) marked element x in [n] ---
def cochain_mark_top(F, x, n):
    """c(sigma_0, sigma_1) = m_F(sigma_0) * m_F(sigma_1) * [x in sigma_1]."""
    m = moebius(F, n)
    c = {}
    for e in HEX_EDGES:
        s0, s1 = e
        c[e] = m[s0] * m[s1] * (1 if x in s1 else 0)
    return c


def cochain_mark_added(F, x, n):
    """c(sigma_0, sigma_1) = m_F(sigma_0) * m_F(sigma_1) * [x = added]."""
    m = moebius(F, n)
    c = {}
    for e in HEX_EDGES:
        s0, s1 = e
        added = (s1 - s0)
        c[e] = m[s0] * m[s1] * (1 if x in added else 0)
    return c


def cochain_mark_bottom(F, x, n):
    """c(sigma_0, sigma_1) = m_F(sigma_0) * m_F(sigma_1) * [x in sigma_0]."""
    m = moebius(F, n)
    c = {}
    for e in HEX_EDGES:
        s0, s1 = e
        c[e] = m[s0] * m[s1] * (1 if x in s0 else 0)
    return c


def cochain_mark_chiF(F, x, n):
    """c(sigma_0, sigma_1) = chi_F(sigma_0 cup {x}) - chi_F(sigma_1 cup {x})."""
    c = {}
    for e in HEX_EDGES:
        s0, s1 = e
        ext0 = s0 | frozenset({x})
        ext1 = s1 | frozenset({x})
        c[e] = (1 if ext0 in F else 0) - (1 if ext1 in F else 0)
    return c


def cochain_mark_extension(F, x, n):
    """c(sigma_0, sigma_1) = m_F(sigma_0 cup {x}) * m_F(sigma_1)."""
    m = moebius(F, n)
    c = {}
    for e in HEX_EDGES:
        s0, s1 = e
        ext0 = s0 | frozenset({x})
        c[e] = m.get(ext0, 0) * m[s1]
    return c


def cochain_mark_top_only(F, x, n):
    """c(sigma_0, sigma_1) = m_F(sigma_1) * [x in sigma_0].

       Does NOT multiply by m_F(sigma_0).  Aimed at F whose m_F vanishes
       on singletons (e.g., the size-4 fully S_3-symmetric CE-shape).
    """
    m = moebius(F, n)
    c = {}
    for e in HEX_EDGES:
        s0, s1 = e
        c[e] = m[s1] * (1 if x in s0 else 0)
    return c


def cochain_mark_chiF_top(F, x, n):
    """c(sigma_0, sigma_1) = chi_F(sigma_1 cup {x}) - chi_F(sigma_0 cup {x})."""
    c = {}
    for e in HEX_EDGES:
        s0, s1 = e
        c[e] = ((1 if (s1 | frozenset({x})) in F else 0)
                - (1 if (s0 | frozenset({x})) in F else 0))
    return c


# --- (b) ordering pi of [n] ---
def cochain_order_min_added(F, pi, n):
    """c(sigma_0, sigma_1) = m_F(sigma_0)*m_F(sigma_1)
                             * [pi-min of sigma_1 in sigma_0].
       pi is a tuple (a permutation of [n]) defining the ordering;
       pi-min(S) = element of S with smallest pi-index.
    """
    pi_rank = {pi[i]: i for i in range(n)}
    m = moebius(F, n)
    c = {}
    for e in HEX_EDGES:
        s0, s1 = e
        if not s1:
            c[e] = 0
            continue
        pi_min = min(s1, key=lambda x: pi_rank[x])
        c[e] = m[s0] * m[s1] * (1 if pi_min in s0 else 0)
    return c


def cochain_order_added_min(F, pi, n):
    """c(sigma_0, sigma_1) = m_F(sigma_0)*m_F(sigma_1)
                             * [added element is the pi-min of sigma_1]."""
    pi_rank = {pi[i]: i for i in range(n)}
    m = moebius(F, n)
    c = {}
    for e in HEX_EDGES:
        s0, s1 = e
        if not s1:
            c[e] = 0
            continue
        pi_min = min(s1, key=lambda x: pi_rank[x])
        added = s1 - s0
        c[e] = m[s0] * m[s1] * (1 if pi_min in added else 0)
    return c


def cochain_order_sgn_perm(F, pi, n):
    """c(sigma_0, sigma_1) = m_F(sigma_0)*m_F(sigma_1)
                             * sgn(perm sending sigma_1 list under id to pi).
       For |sigma_1|=2 with elements a<b (numerical), pi-order is
       (pi^{-1}(a), pi^{-1}(b)); sgn = +1 if increasing, -1 if dec.
    """
    pi_rank = {pi[i]: i for i in range(n)}
    m = moebius(F, n)
    c = {}
    for e in HEX_EDGES:
        s0, s1 = e
        if len(s1) == 2:
            a, b = sorted(s1)  # numerical order
            sgn = 1 if pi_rank[a] < pi_rank[b] else -1
        else:
            sgn = 1
        c[e] = m[s0] * m[s1] * sgn
    return c


def cochain_order_sgn_pair(F, pi, n):
    """c(sigma_0, sigma_1) = m_F(sigma_1) * sgn(pi-rank(added) - pi-rank(min(sigma_0))).

       Encodes the ORDERED PAIR (sigma_0 element, added element) via pi.
       Does NOT multiply by m_F(sigma_0), so it can escape F's whose m_F
       vanishes on singletons (e.g., the size-4 fully S_3-symmetric F).
    """
    pi_rank = {pi[i]: i for i in range(n)}
    m = moebius(F, n)
    c = {}
    for e in HEX_EDGES:
        s0, s1 = e
        if not s0 or len(s1 - s0) != 1:
            c[e] = 0
            continue
        added_x = next(iter(s1 - s0))
        s0_elem = next(iter(s0))  # singleton bottom for n=3
        sgn_pair = 1 if pi_rank[added_x] > pi_rank[s0_elem] else -1
        c[e] = m[s1] * sgn_pair
    return c


def cochain_order_chiF_pair(F, pi, n):
    """c(sigma_0, sigma_1) = chi_F(sigma_1) * sgn(pi-rank(added) - pi-rank(sigma_0)).

       Same shape as order_sgn_pair, but built from chi_F (not m_F).
    """
    pi_rank = {pi[i]: i for i in range(n)}
    c = {}
    for e in HEX_EDGES:
        s0, s1 = e
        if not s0 or len(s1 - s0) != 1:
            c[e] = 0
            continue
        added_x = next(iter(s1 - s0))
        s0_elem = next(iter(s0))
        sgn_pair = 1 if pi_rank[added_x] > pi_rank[s0_elem] else -1
        c[e] = (1 if s1 in F else 0) * sgn_pair
    return c


# --- (c) external reference family F_0 ---
def cochain_ext_F0_prod(F, F_0, n):
    """c(sigma_0, sigma_1) = m_F(sigma_0) * m_{F_0}(sigma_1).
       Uses F's data on the bottom of the chain and F_0's data on the top.
    """
    m_F = moebius(F, n)
    m_F0 = moebius(F_0, n)
    c = {}
    for e in HEX_EDGES:
        s0, s1 = e
        c[e] = m_F[s0] * m_F0[s1]
    return c


def cochain_ext_F0_symdiff(F, F_0, n):
    """c = LIFT-4-prod of (F sym-diff F_0).  Twists F by an external F_0
       via symmetric-difference in 2^{2^[n]}."""
    F_sd = frozenset(F.symmetric_difference(F_0))
    return cochain_natural_LIFT4_prod(F_sd, n)


def cochain_ext_F0_quot(F, F_0, n):
    """c(sigma_0, sigma_1) = m_F(sigma_0) * (m_F(sigma_1) - m_{F_0}(sigma_1))."""
    m_F = moebius(F, n)
    m_F0 = moebius(F_0, n)
    c = {}
    for e in HEX_EDGES:
        s0, s1 = e
        c[e] = m_F[s0] * (m_F[s1] - m_F0[s1])
    return c


# ==========================================================================
# 5. The 12 CE-shape families at n=3 (collected from mg-e466)
# ==========================================================================
def the_12_CE_n3():
    n = 3
    ground = frozenset(range(n))
    all_uc = [F for F in enumerate_union_closed(n) if is_ce_shape(F, ground)]
    return all_uc


def show_family(F):
    """Pretty-print a family using 1-indexed element labels (matching
       mg-e466's convention)."""
    def show(s):
        return "{" + ",".join(str(i + 1) for i in sorted(s)) + "}" if s else "0"
    return "[" + " ".join(show(s) for s in sorted(F, key=lambda x: (len(x), sorted(x)))) + "]"


# ==========================================================================
# 6. Probe
# ==========================================================================
def main():
    n = 3
    ground = frozenset(range(n))

    print("=" * 78)
    print(f"Frankl-NonNatural-Cochain-Probe  mg-e1e2  (n={n})")
    print("=" * 78)
    print()
    print("Testing non-F-natural IE cochain candidates on the 12 CE-shape")
    print("families at n=3.  Per mg-e466 each is RED for every F-natural")
    print("construction; this probe tests whether the structurally identified")
    print("escape (non-natural data d breaks F's symmetry) actually fires.")
    print()

    families = the_12_CE_n3()
    assert len(families) == 12, f"expected 12 CE-shape families, found {len(families)}"

    # Aut-class of each family
    print("=" * 78)
    print("Aut(F)-classification of the 12 CE-shape families:")
    print("=" * 78)
    for F in families:
        auts = aut_F(F, n)
        transpositions = [a for a in auts if parity(a) == 1]
        ts = []
        for t in transpositions:
            # find which elements t swaps
            swapped = [i for i in range(n) if t[i] != i]
            ts.append(f"({swapped[0]+1} {swapped[1]+1})")
        if len(transpositions) == 3:
            aut_str = "S_3 (full sym)"
        elif len(transpositions) == 1:
            aut_str = f"Z_2 = <{ts[0]}>"
        else:
            aut_str = f"|aut|={len(auts)}"
        print(f"  size {len(F):2d}  |aut(F)|={len(auts)}  {aut_str:25s}  {show_family(F)}")
    print()

    # Control: F-natural LIFT-4-prod (should give zero on all 12)
    print("=" * 78)
    print("CONTROL: F-natural LIFT-4-prod (mg-e466 baseline)")
    print("=" * 78)
    print("For each F, check cycle_integral of LIFT-4-prod and of its sgn-projection:")
    print()
    nat_zero_count = 0
    for F in families:
        c = cochain_natural_LIFT4_prod(F, n)
        ci = cycle_integral(c)
        spci = cycle_integral(sgn_project(c, n))
        sym = "ZERO" if spci == 0 else f"NON-ZERO ({spci})"
        if spci == 0:
            nat_zero_count += 1
        print(f"  {show_family(F):42s}  cycle_int={ci:3d}  sgn_class={sym}")
    print(f"\n  F-natural baseline: {nat_zero_count}/12 CE-shape give zero sgn-class")
    print(f"  (mg-e466 reports 12/12; this should match)")
    print()

    # Probe each non-natural construction
    print("=" * 78)
    print("NON-NATURAL CONSTRUCTIONS")
    print("=" * 78)

    # (a) Marked element
    print()
    print("--- (a) Marked element x in [n] ---")
    print()

    mark_constructions = [
        ("mark_top",         "c = m_F(s0)*m_F(s1)*[x in s1]",              cochain_mark_top),
        ("mark_bot",         "c = m_F(s0)*m_F(s1)*[x in s0]",              cochain_mark_bottom),
        ("mark_added",       "c = m_F(s0)*m_F(s1)*[x = added]",            cochain_mark_added),
        ("mark_chiF",        "c = chi_F(s0 u {x}) - chi_F(s1 u {x})",      cochain_mark_chiF),
        ("mark_extension",   "c = m_F(s0 u {x})*m_F(s1)",                  cochain_mark_extension),
        ("mark_top_only",    "c = m_F(s1)*[x in s0]   (no m_F(s0) factor)", cochain_mark_top_only),
        ("mark_chiF_top",    "c = chi_F(s1 u {x}) - chi_F(s0 u {x})",      cochain_mark_chiF_top),
    ]

    for label, descr, fn in mark_constructions:
        print(f"  Construction {label}: {descr}")
        nz_count = 0
        details = []
        for F in families:
            results_for_F = []
            for x in range(n):
                c = fn(F, x, n)
                spci = cycle_integral(sgn_project(c, n))
                if spci != 0:
                    results_for_F.append((x + 1, spci))
            if results_for_F:
                nz_count += 1
                details.append((F, results_for_F))
        print(f"    -> non-zero sgn-class on {nz_count}/12 CE-shape families")
        if nz_count > 0 and nz_count <= 12:
            for F, res in details[:6]:
                txt = ", ".join(f"x={x}: cls={cl}" for x, cl in res)
                print(f"       {show_family(F):42s} ({txt})")
            if len(details) > 6:
                print(f"       ... ({len(details)-6} more)")
        print()

    # (b) Ordering pi
    print("--- (b) Ordering pi of [n] ---")
    print()

    ord_constructions = [
        ("order_min_added",  "c = m_F(s0)*m_F(s1)*[pi-min(s1) in s0]",        cochain_order_min_added),
        ("order_added_min",  "c = m_F(s0)*m_F(s1)*[added = pi-min(s1)]",      cochain_order_added_min),
        ("order_sgn_perm",   "c = m_F(s0)*m_F(s1)*sgn(s1-numerical-vs-pi)",   cochain_order_sgn_perm),
        ("order_sgn_pair",   "c = m_F(s1)*sgn(pi-rank(added)-pi-rank(s0))",   cochain_order_sgn_pair),
        ("order_chiF_pair",  "c = chi_F(s1)*sgn(pi-rank(added)-pi-rank(s0))", cochain_order_chiF_pair),
    ]

    for label, descr, fn in ord_constructions:
        print(f"  Construction {label}: {descr}")
        nz_count = 0
        details = []
        for F in families:
            results_for_F = []
            for pi in permutations(range(n)):
                c = fn(F, pi, n)
                spci = cycle_integral(sgn_project(c, n))
                if spci != 0:
                    results_for_F.append((pi, spci))
            if results_for_F:
                nz_count += 1
                details.append((F, results_for_F))
        print(f"    -> non-zero sgn-class on {nz_count}/12 CE-shape families")
        if nz_count > 0:
            for F, res in details[:4]:
                # show one example
                pi, cl = res[0]
                txt = f"pi={tuple(p+1 for p in pi)}, cls={cl} (and {len(res)-1} other pi's)"
                print(f"       {show_family(F):42s} ({txt})")
            if len(details) > 4:
                print(f"       ... ({len(details)-4} more)")
        print()

    # (c) External F_0
    print("--- (c) External reference family F_0 (not equal to F) ---")
    print()

    # Test against a fixed set of F_0 candidates
    F0_candidates = [
        # F_0 with non-trivial aut (S_2):
        ("F0={{1}}",                  frozenset({frozenset({0})})),
        ("F0={{1},{1,2,3}}",          frozenset({frozenset({0}), frozenset({0, 1, 2})})),
        ("F0={{2}}",                  frozenset({frozenset({1})})),
        ("F0=principal-1",            frozenset({frozenset({0}), frozenset({0, 1}),
                                                  frozenset({0, 2}), frozenset({0, 1, 2})})),
        # F_0 with full S_3 aut (controls; cannot escape S_3-sym F's via ext):
        ("F0={all-2-subs}",           frozenset({frozenset({0, 1}), frozenset({0, 2}),
                                                  frozenset({1, 2}), frozenset({0, 1, 2})})),
        # F_0 with TRIVIAL aut -- aimed at S_3-symmetric F:
        ("F0={{1},{2}}",              frozenset({frozenset({0}), frozenset({1})})),
        ("F0={{1},{1,2}}",            frozenset({frozenset({0}), frozenset({0, 1})})),
        ("F0={{1},{2},{1,2,3}}",      frozenset({frozenset({0}), frozenset({1}),
                                                  frozenset({0, 1, 2})})),
        ("F0={{1},{1,2},{1,2,3}}",    frozenset({frozenset({0}), frozenset({0, 1}),
                                                  frozenset({0, 1, 2})})),
    ]

    ext_constructions = [
        ("ext_prod",        "c = m_F(s0)*m_F0(s1)",                          cochain_ext_F0_prod),
        ("ext_symdiff",     "c = LIFT-4-prod of (F symdiff F0)",             cochain_ext_F0_symdiff),
        ("ext_quot",        "c = m_F(s0)*(m_F(s1) - m_F0(s1))",              cochain_ext_F0_quot),
    ]

    for label, descr, fn in ext_constructions:
        print(f"  Construction {label}: {descr}")
        nz_count = 0
        details = []
        for F in families:
            results_for_F = []
            for F0_label, F_0 in F0_candidates:
                if F_0 == F:
                    continue  # require F_0 != F
                c = fn(F, F_0, n)
                spci = cycle_integral(sgn_project(c, n))
                if spci != 0:
                    results_for_F.append((F0_label, spci))
            if results_for_F:
                nz_count += 1
                details.append((F, results_for_F))
        print(f"    -> non-zero sgn-class on {nz_count}/12 CE-shape families")
        if nz_count > 0:
            for F, res in details[:6]:
                txt = ", ".join(f"{lbl}: cls={cl}" for lbl, cl in res[:3])
                if len(res) > 3:
                    txt += ", ..."
                print(f"       {show_family(F):42s} ({txt})")
            if len(details) > 6:
                print(f"       ... ({len(details)-6} more)")
        print()

    # ----- Final summary -----
    print("=" * 78)
    print("AGGREGATE SUMMARY")
    print("=" * 78)
    print()
    print("Across ALL tested non-natural constructions, the count of CE-shape")
    print("families F for which SOME non-natural construction (with SOME choice")
    print("of d) gives non-zero sgn-class:")
    print()

    overall_works = {}  # F -> list of (construction, d) that work
    for F in families:
        overall_works[F] = []

    all_test_specs = []
    for label, descr, fn in mark_constructions:
        for x in range(n):
            all_test_specs.append((label, f"x={x+1}", lambda F, fn=fn, x=x: fn(F, x, n)))
    for label, descr, fn in ord_constructions:
        for pi in permutations(range(n)):
            all_test_specs.append((label, f"pi={tuple(p+1 for p in pi)}", lambda F, fn=fn, pi=pi: fn(F, pi, n)))
    for label, descr, fn in ext_constructions:
        for F0_label, F_0 in F0_candidates:
            all_test_specs.append((label, F0_label, lambda F, fn=fn, F_0=F_0: fn(F, F_0, n) if F != F_0 else cochain_natural_LIFT4_prod(F, n)))

    for label, d_label, fn in all_test_specs:
        for F in families:
            c = fn(F)
            spci = cycle_integral(sgn_project(c, n))
            if spci != 0:
                overall_works[F].append((label, d_label, spci))

    works_count = 0
    aut_class = {}
    for F in families:
        auts = aut_F(F, n)
        transpositions = [a for a in auts if parity(a) == 1]
        if len(transpositions) == 3:
            cls = "S_3"
        elif len(transpositions) == 1:
            swapped = [i for i in range(n) if transpositions[0][i] != i]
            cls = f"Z_2=(<{swapped[0]+1},{swapped[1]+1}>)"
        else:
            cls = f"trivial-or-other(|aut|={len(auts)})"
        aut_class[F] = cls

        n_works = len(overall_works[F])
        if n_works:
            works_count += 1
        verdict = "ESCAPED" if n_works else "STUCK"
        print(f"  {show_family(F):42s}  aut={cls:25s}  {verdict}"
              f"  ({n_works} non-natural escapes found)")

    print()
    print(f"  TOTAL: {works_count}/12 CE-shape families admit a non-natural escape.")
    print()

    # ----- Verdict against ticket scope -----
    print("=" * 78)
    print("VERDICT (per ticket mg-e1e2 §SCOPE)")
    print("=" * 78)
    if works_count == 0:
        print("NON-NATURAL FAILS uniformly: every CE-shape family at n=3 has zero")
        print("sgn-class under every tested non-natural construction.  The obstruction")
        print("is deeper than F-symmetry alone.")
    elif works_count == 12:
        print("NON-NATURAL WORKS on ALL 12 CE-shape families: every CE-shape F admits")
        print("at least one non-natural construction giving non-zero sgn-class.")
    else:
        print(f"NON-NATURAL WORKS PARTIALLY: {works_count}/12 CE-shape families admit")
        print(f"non-natural escape; {12 - works_count}/12 remain stuck under all tested")
        print("non-natural constructions.")
        print()
        print("Stuck families:")
        for F in families:
            if not overall_works[F]:
                print(f"   {show_family(F):42s}  aut={aut_class[F]}")
        print()
        print("Escaped families (sample):")
        for F in families:
            if overall_works[F]:
                print(f"   {show_family(F):42s}  aut={aut_class[F]}")
                # show one working escape
                construction, d, cl = overall_works[F][0]
                print(f"      example: {construction}({d}) -> sgn-class={cl}")
    print()


if __name__ == "__main__":
    main()
