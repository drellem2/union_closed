#!/usr/bin/env python3
"""
Frankl-Numerical-Coincidence-Sharpening  (mg-3978)
==================================================

Sharpens the numerical coincidence flagged by mg-e466:

    "Frankl truth iff LIFT-4-prod sgn-class vanishes for CE-shape F-star"
    holds 100% at n=3 (12/12) and 86% at n=4 (498/582).

The 14% non-vanish at n=4 (84 families) is data.  This probe:

  (a) Characterises the 84 non-vanishing CE-shape families on [4]:
      |F|, |Aut(F)| (S_4-stabilizer), generators, element-count
      profile, transposition-symmetry, etc.  Cross-tabs the
      structural invariants against the vanish/non-vanish label.

  (b) Tests the coincidence on a structurally-bounded subclass of
      n=5 CE-shape UC families (size <= K), to see whether the
      vanish/non-vanish pattern persists or breaks.

  (c) Reports, with honest framing: data only.  No proof claims.

All ranks via sparse Gaussian elimination at two ~2^31 primes,
cross-checked.  Reproducible.  No external dependencies.

Reused primitives from docs/frankl-ie-induction-probe.py:
  - sparse_rank, rank2     (cross-checked modular rank)
  - all_subsets            (powerset enumeration)
  - is_union_closed        (predicate)
  - rare_witnesses         (rare-element predicate)
"""

from itertools import combinations, permutations
import functools
import time
from collections import Counter, defaultdict

PRIMES = (2147483647, 2147483629)
T0 = time.time()
def el(): return f"[{time.time()-T0:7.1f}s]"


# ============================================================================
# 0. Linear algebra (cross-checked at two primes; mirrors mg-e466 probe)
# ============================================================================
def sparse_rank(columns, p):
    pivots = {}
    rank = 0
    for col in columns:
        col = {r: v % p for r, v in col.items()}
        col = {r: v for r, v in col.items() if v}
        while col:
            r = max(col)
            if r in pivots:
                pv = pivots[r]
                f = (col[r] * pow(pv[r], p - 2, p)) % p
                for rr, vv in pv.items():
                    nv = (col.get(rr, 0) - f * vv) % p
                    if nv:
                        col[rr] = nv
                    elif rr in col:
                        del col[rr]
            else:
                pivots[r] = col
                rank += 1
                break
    return rank


def rank2(columns):
    if not columns:
        return 0
    r0 = sparse_rank(columns, PRIMES[0])
    r1 = sparse_rank(columns, PRIMES[1])
    assert r0 == r1, f"prime cross-check FAILED: {r0} vs {r1}"
    return r0


# ============================================================================
# 1. Sets / families / CE-shape
# ============================================================================
def all_subsets(n):
    return [frozenset(c) for k in range(n + 1) for c in combinations(range(n), k)]


def is_union_closed(F):
    Fs = set(F)
    return all((a | b) in Fs for a in Fs for b in Fs)


def closure_under_union(seed):
    F = set(seed)
    while True:
        addn = set()
        for a in F:
            for b in F:
                u = a | b
                if u not in F:
                    addn.add(u)
        if not addn:
            return frozenset(F)
        F |= addn


def rare_witnesses(F, ground):
    out = []
    for x in ground:
        cnt = sum(1 for A in F if x in A)
        if 2 * cnt <= len(F):
            out.append(x)
    return out


def is_ce_shape(F, ground):
    """Union-closed, |F|>=2, every element in >|F|/2 members."""
    if len(F) < 2:
        return False
    if not is_union_closed(F):
        return False
    return not rare_witnesses(F, ground)


def element_count_vector(F, ground):
    """a_F: x -> |{A in F : x in A}|, as a tuple over x in sorted ground."""
    return tuple(sum(1 for A in F if x in A) for x in sorted(ground))


# ============================================================================
# 2. Aut(F) under S_n action on [n]
# ============================================================================
def apply_perm_to_family(F, perm):
    """perm is a tuple where perm[i] = image of i.  Returns sigma(F)."""
    return frozenset(frozenset(perm[x] for x in A) for A in F)


def stabilizer(F, n):
    """The subgroup of S_n that fixes F (Aut(F) as a permutation subgroup)."""
    stab = []
    for perm in permutations(range(n)):
        if apply_perm_to_family(F, perm) == F:
            stab.append(perm)
    return stab


def has_transposition_symmetry(F, n):
    """Does Aut(F) contain at least one transposition?"""
    for i, j in combinations(range(n), 2):
        # build the swap (i j) as a permutation
        perm = list(range(n))
        perm[i], perm[j] = perm[j], perm[i]
        if apply_perm_to_family(F, tuple(perm)) == F:
            return True
    return False


def transposition_list(F, n):
    """All transpositions (i,j) that fix F."""
    out = []
    for i, j in combinations(range(n), 2):
        perm = list(range(n))
        perm[i], perm[j] = perm[j], perm[i]
        if apply_perm_to_family(F, tuple(perm)) == F:
            out.append((i, j))
    return out


def perm_parity(perm):
    """Parity of a permutation given as a tuple."""
    n = len(perm)
    parity = 0
    for i in range(n):
        for j in range(i + 1, n):
            if perm[i] > perm[j]:
                parity += 1
    return parity & 1


def has_odd_stabilizer(F, n):
    """Does Aut(F) contain any odd-parity permutation?

    By the sgn-projection identity (Sec 2.4 of mg-e466), an odd element
    in Aut(F) forces c^sgn = -c^sgn for any F-natural cochain, hence
    c^sgn = 0.  So this predicate is the SHARP form of the symmetry
    obstruction: |Aut|=2 from a TRANSPOSITION kills sgn (odd), but
    |Aut|=2 from a DOUBLE-TRANSPOSITION (even) does NOT.
    """
    for perm in permutations(range(n)):
        if perm_parity(perm) == 1 and apply_perm_to_family(F, perm) == F:
            return True
    return False


def odd_stabilizer_list(F, n):
    """All odd-parity perms in Aut(F)."""
    out = []
    for perm in permutations(range(n)):
        if perm_parity(perm) == 1 and apply_perm_to_family(F, perm) == F:
            out.append(perm)
    return out


def join_irreducibles(F):
    """Generators of F under union: members not expressible as union of strictly
    smaller members of F."""
    out = []
    Fs = set(F)
    for A in F:
        smaller = [B for B in Fs if B < A]
        # try all subsets of smaller for union = A
        is_join = False
        for r in range(2, len(smaller) + 1):
            for combo in combinations(smaller, r):
                u = frozenset()
                for x in combo:
                    u |= x
                if u == A:
                    is_join = True
                    break
            if is_join:
                break
        if not is_join:
            out.append(A)
    return frozenset(out)


# ============================================================================
# 3. The punctured Boolean order complex and the LIFT-4-prod sgn class
# ============================================================================
def punctured_boolean_simplices(n):
    """All simplices of order-complex of (2^[n] \\ {empty, [n]}, subset).

    Returns {dim: list of chains} where each chain is a tuple of strictly
    increasing proper non-empty subsets.
    """
    verts = [s for s in all_subsets(n) if 0 < len(s) < n]
    simp = defaultdict(list)
    # chains of length k+1 (= k-simplices)
    def extend(prefix):
        d = len(prefix) - 1
        simp[d].append(prefix)
        last = prefix[-1]
        for v in verts:
            if last < v and len(v) > len(last):
                extend(prefix + (v,))
    for v in verts:
        extend((v,))
    return dict(simp)


def coboundary_columns(simp, top_dim):
    """Coboundary d^{top-1}: image columns indexed by (top-1)-simplices,
    expressed as sparse vectors over top-simplices."""
    chains_top = simp.get(top_dim, [])
    chains_below = simp.get(top_dim - 1, [])
    index_top = {tuple(c): i for i, c in enumerate(chains_top)}

    cols = []
    for tau in chains_below:
        col = {}
        for sigma_tup in chains_top:
            # tau is a face of sigma iff dropping one vertex from sigma gives tau
            for i in range(len(sigma_tup)):
                if sigma_tup[:i] + sigma_tup[i + 1:] == tau:
                    j = index_top[sigma_tup]
                    col[j] = col.get(j, 0) + ((-1) ** i)
                    break
        if col:
            cols.append(col)
    return cols, index_top, chains_top


def mobius_transform(F, subs):
    """m_F(T) := sum_{S <= T} (-1)^{|T\\S|} chi_F(S)."""
    Fs = set(F)
    m = {}
    for T in subs:
        v = 0
        Tlist = list(T)
        for k in range(len(Tlist) + 1):
            for combo in combinations(Tlist, k):
                S = frozenset(combo)
                v += (-1) ** (len(T) - len(S)) * (1 if S in Fs else 0)
        m[T] = v
    return m


def lift4_prod_cochain(m_F, chains_top):
    """LIFT-4-prod: c(sigma_0 < ... < sigma_{n-2}) := prod_i m_F(sigma_i)."""
    c = {}
    for chain in chains_top:
        prod = 1
        for s in chain:
            prod *= m_F[s]
            if prod == 0:
                break
        c[chain] = prod
    return c


def sgn_project(cochain, chains_top, n):
    """c^sgn(x) := (1/n!) sum_{sigma in S_n} sgn(sigma) c(sigma . x).

    We work over Q with the n!-scaling absorbed (rank is unchanged).
    """
    proj = {ch: 0 for ch in chains_top}
    for perm in permutations(range(n)):
        # parity
        parity = 0
        for i in range(n):
            for j in range(i + 1, n):
                if perm[i] > perm[j]:
                    parity += 1
        sign = -1 if (parity & 1) else 1
        for ch in chains_top:
            ch_post = tuple(frozenset(perm[x] for x in s) for s in ch)
            proj[ch] += sign * cochain.get(ch_post, 0)
    return proj


def class_nonzero(cochain, cob_cols, index_top, chains_top):
    """Return True iff cochain is NOT in the image of the coboundary."""
    vec = {index_top[ch]: cochain[ch] for ch in chains_top if cochain[ch]}
    if not vec:
        return False
    rk_with = rank2(cob_cols + [vec])
    rk_without = rank2(cob_cols)
    return rk_with > rk_without


# ============================================================================
# 4. UC family enumeration
# ============================================================================
def enumerate_uc_with_top(n, size_cap):
    """All UC families F on [n] with [n] in F and |F| <= size_cap.

    BFS by adding one set at a time, then taking closure.  Dedup via set
    membership.
    """
    ground = frozenset(range(n))
    subs = [s for s in all_subsets(n) if s != ground]

    seen = set()
    start = frozenset({ground})
    seen.add(start)
    frontier = [start]

    while frontier:
        new_frontier = []
        for F in frontier:
            if len(F) >= size_cap:
                continue
            for S in subs:
                if S in F:
                    continue
                F_new = closure_under_union(F | {S})
                if len(F_new) > size_cap:
                    continue
                if F_new in seen:
                    continue
                seen.add(F_new)
                new_frontier.append(F_new)
        frontier = new_frontier
    return list(seen)


def enumerate_uc_exhaustive(n):
    """Exhaustive UC enumeration via 2^(2^n) bitmask.  Only feasible n<=4."""
    subs = all_subsets(n)
    M = len(subs)
    out = []
    for mask in range(2 ** M):
        F = frozenset(subs[i] for i in range(M) if (mask >> i) & 1)
        if not F:
            continue
        if is_union_closed(F):
            out.append(F)
    return out


# ============================================================================
# 5. Probe driver
# ============================================================================
def show_family(F):
    def show(s):
        return "{" + ",".join(str(i + 1) for i in sorted(s)) + "}" if s else "0"
    return "[" + " ".join(show(s) for s in sorted(F, key=lambda x: (len(x), sorted(x)))) + "]"


def characterize_family(F, n, ground, cob_cols, index_top, chains_top, subs):
    """Compute all structural invariants + the LIFT-4-prod sgn-class label."""
    # cohomology label
    m_F = mobius_transform(F, subs)
    cochain = lift4_prod_cochain(m_F, chains_top)
    sgn = sgn_project(cochain, chains_top, n)
    sgn_nz = class_nonzero(sgn, cob_cols, index_top, chains_top)

    # structural invariants
    transps = transposition_list(F, n)
    aut = stabilizer(F, n)
    odd_stab = odd_stabilizer_list(F, n)
    ecv = element_count_vector(F, ground)
    gens = join_irreducibles(F)
    has_empty = frozenset() in F

    return {
        'F': F,
        'size': len(F),
        'sgn_nz': sgn_nz,
        'aut_order': len(aut),
        'n_transp': len(transps),
        'transp_list': transps,
        'has_trans_sym': len(transps) > 0,
        'n_odd_stab': len(odd_stab),
        'has_odd_stab': len(odd_stab) > 0,
        'elt_count_sorted': tuple(sorted(ecv)),
        'elt_count_min': min(ecv),
        'elt_count_max': max(ecv),
        'elt_count_balance': max(ecv) - min(ecv),
        'n_gens': len(gens),
        'gens': gens,
        'gen_sizes': tuple(sorted(len(g) for g in gens)),
        'has_empty': has_empty,
        'has_singleton': any(len(A) == 1 for A in F),
        'n_singletons_in_F': sum(1 for A in F if len(A) == 1),
        'n_pairs_in_F': sum(1 for A in F if len(A) == 2),
    }


def n4_sharpening():
    """Phase 1: characterize the 84 non-vanishing CE-shape families on [4]."""
    n = 4
    ground = frozenset(range(n))
    subs = all_subsets(n)

    print(f"\n{'=' * 78}")
    print(f"PHASE 1  n=4 sharpening  {el()}")
    print(f"{'=' * 78}")

    # build punctured-Boolean infrastructure (cached)
    simp = punctured_boolean_simplices(n)
    top_dim = n - 2
    print(f"  Punctured Boolean simplices at n={n}: "
          f"{ {d: len(v) for d, v in simp.items()} }  {el()}")
    cob_cols, index_top, chains_top = coboundary_columns(simp, top_dim)
    print(f"  Coboundary basis: {len(cob_cols)} columns -> "
          f"{len(chains_top)} top-dim chains  {el()}")

    # enumerate UC families and filter CE-shape
    print(f"  Enumerating UC families on [{n}] exhaustively...  {el()}")
    uc = enumerate_uc_exhaustive(n)
    print(f"  Non-empty UC families: {len(uc)}  {el()}")
    ce = [F for F in uc if is_ce_shape(F, ground)]
    print(f"  CE-shape UC families (|F|>=2, no rare elt): {len(ce)}  {el()}")

    # characterize all
    print(f"  Characterizing all {len(ce)} CE-shape families...  {el()}")
    rows = []
    for i, F in enumerate(ce):
        if i and i % 100 == 0:
            print(f"    ... {i}/{len(ce)}  {el()}")
        row = characterize_family(F, n, ground, cob_cols, index_top, chains_top, subs)
        rows.append(row)
    print(f"  Done.  {el()}")

    # summarize
    sgn_nz_rows = [r for r in rows if r['sgn_nz']]
    sgn_z_rows = [r for r in rows if not r['sgn_nz']]
    print(f"\n  CE-shape sgn-non-vanishing: {len(sgn_nz_rows)} / {len(rows)} "
          f"({100*len(sgn_nz_rows)/len(rows):.1f}%)")
    print(f"  CE-shape sgn-vanishing:     {len(sgn_z_rows)} / {len(rows)} "
          f"({100*len(sgn_z_rows)/len(rows):.1f}%)")

    # --- Aut(F) cross-tab ---
    print(f"\n  --- |Aut(F)| in S_{n} (= |S_n-stabilizer|) cross-tab ---")
    aut_x_nz = Counter()
    aut_x_z = Counter()
    for r in rows:
        if r['sgn_nz']:
            aut_x_nz[r['aut_order']] += 1
        else:
            aut_x_z[r['aut_order']] += 1
    all_orders = sorted(set(aut_x_nz) | set(aut_x_z))
    print(f"    |Aut| | sgn=nonzero | sgn=zero | total")
    for o in all_orders:
        nz, z = aut_x_nz[o], aut_x_z[o]
        print(f"    {o:5d} | {nz:11d} | {z:8d} | {nz+z:5d}")

    # --- has-transposition cross-tab ---
    print(f"\n  --- has-transposition-symmetry cross-tab ---")
    trans_x_nz = Counter()
    trans_x_z = Counter()
    for r in rows:
        if r['sgn_nz']:
            trans_x_nz[r['has_trans_sym']] += 1
        else:
            trans_x_z[r['has_trans_sym']] += 1
    for tval in (False, True):
        print(f"    has_trans={tval}: sgn_nz={trans_x_nz[tval]}, "
              f"sgn_z={trans_x_z[tval]}")

    # CRITICAL: does sgn_nz <=> no transposition symmetry?
    no_trans_no_nz = sum(1 for r in rows if not r['has_trans_sym'] and not r['sgn_nz'])
    no_trans_yes_nz = sum(1 for r in rows if not r['has_trans_sym'] and r['sgn_nz'])
    yes_trans_no_nz = sum(1 for r in rows if r['has_trans_sym'] and not r['sgn_nz'])
    yes_trans_yes_nz = sum(1 for r in rows if r['has_trans_sym'] and r['sgn_nz'])
    print(f"\n  --- Hypothesis A: sgn_nz <=> no-transposition-symmetry? ---")
    print(f"    no transp + sgn_z  : {no_trans_no_nz}  (false-pos for hypothesis)")
    print(f"    no transp + sgn_nz : {no_trans_yes_nz} (consistent)")
    print(f"    has transp + sgn_z : {yes_trans_no_nz} (consistent / sym kills)")
    print(f"    has transp + sgn_nz: {yes_trans_yes_nz} (sym present but class non-zero)")

    # SHARPENED hypothesis: sgn_nz <=> no ODD-parity stabilizer.
    # (Transposition-symmetry is a special case of odd-stabilizer;
    #  a (12)(34)-type double-transposition has EVEN parity and does NOT
    #  kill the sgn-isotype.  This is the sharper structural form.)
    no_odd_z = sum(1 for r in rows if not r['has_odd_stab'] and not r['sgn_nz'])
    no_odd_nz = sum(1 for r in rows if not r['has_odd_stab'] and r['sgn_nz'])
    yes_odd_z = sum(1 for r in rows if r['has_odd_stab'] and not r['sgn_nz'])
    yes_odd_nz = sum(1 for r in rows if r['has_odd_stab'] and r['sgn_nz'])
    print(f"\n  --- Hypothesis B (sharpened): sgn_nz <=> Aut(F) has no ODD element? ---")
    print(f"    no odd-stab + sgn_z  : {no_odd_z}  (false-pos for hypothesis)")
    print(f"    no odd-stab + sgn_nz : {no_odd_nz} (consistent)")
    print(f"    has odd-stab + sgn_z : {yes_odd_z} (consistent / odd elt kills)")
    print(f"    has odd-stab + sgn_nz: {yes_odd_nz} (odd elt present but class non-zero)")
    print(f"    -> If 'has odd-stab + sgn_nz' = 0 and 'no odd-stab + sgn_z' is small,")
    print(f"       hypothesis B refines hypothesis A and gives the cleanest characterisation.")

    # --- size cross-tab ---
    print(f"\n  --- |F| cross-tab ---")
    sz_nz = Counter()
    sz_z = Counter()
    for r in rows:
        if r['sgn_nz']:
            sz_nz[r['size']] += 1
        else:
            sz_z[r['size']] += 1
    sizes = sorted(set(sz_nz) | set(sz_z))
    print(f"    |F| | sgn_nz | sgn_z | total | %nz")
    for s in sizes:
        n_nz, n_z = sz_nz[s], sz_z[s]
        tot = n_nz + n_z
        pct = (100 * n_nz / tot) if tot else 0
        print(f"    {s:3d} | {n_nz:6d} | {n_z:5d} | {tot:5d} | {pct:5.1f}%")

    # --- generator-count cross-tab ---
    print(f"\n  --- #generators (= #join-irreducibles) cross-tab ---")
    g_nz = Counter()
    g_z = Counter()
    for r in rows:
        if r['sgn_nz']:
            g_nz[r['n_gens']] += 1
        else:
            g_z[r['n_gens']] += 1
    for g in sorted(set(g_nz) | set(g_z)):
        print(f"    #gens={g}: sgn_nz={g_nz[g]}, sgn_z={g_z[g]}")

    # --- element-count balance cross-tab ---
    print(f"\n  --- element-count balance (max a_F(x) - min a_F(x)) cross-tab ---")
    b_nz = Counter()
    b_z = Counter()
    for r in rows:
        if r['sgn_nz']:
            b_nz[r['elt_count_balance']] += 1
        else:
            b_z[r['elt_count_balance']] += 1
    for b in sorted(set(b_nz) | set(b_z)):
        print(f"    balance={b}: sgn_nz={b_nz[b]}, sgn_z={b_z[b]}")

    # --- generator-size profile of the 84 non-vanishing ---
    print(f"\n  --- gen-size profile of the {len(sgn_nz_rows)} non-vanishing CE-shape ---")
    gp_nz = Counter(r['gen_sizes'] for r in sgn_nz_rows)
    print(f"    distinct profiles: {len(gp_nz)}")
    for prof, cnt in sorted(gp_nz.items(), key=lambda kv: (-kv[1], kv[0])):
        print(f"      {str(prof):50s} : {cnt}")

    # --- element-count sorted profile ---
    print(f"\n  --- element-count sorted profile cross-tab ---")
    ec_nz = Counter(r['elt_count_sorted'] for r in sgn_nz_rows)
    ec_z = Counter(r['elt_count_sorted'] for r in sgn_z_rows)
    all_ec = sorted(set(ec_nz) | set(ec_z))
    print(f"    sorted (a_F(x_1) <= ... <= a_F(x_n)): sgn_nz / sgn_z")
    for ec in all_ec:
        print(f"      {str(ec):30s} : {ec_nz[ec]:3d} / {ec_z[ec]:3d}")

    # --- S_n orbits of CE-shape families: are 84 = orbits under S_4? ---
    print(f"\n  --- S_{n}-orbit structure of CE-shape families ---")
    seen_orbit = {}
    for r in rows:
        F = r['F']
        # find canonical representative under S_n
        orbit = frozenset(apply_perm_to_family(F, p) for p in permutations(range(n)))
        rep = min(orbit, key=lambda Q: sorted(sorted(s) for s in Q))
        seen_orbit.setdefault(rep, []).append(r)
    n_orbits = len(seen_orbit)
    print(f"    S_{n}-orbits of CE-shape: {n_orbits}")
    orb_nz = 0
    orb_z = 0
    orb_split = 0
    for rep, members in seen_orbit.items():
        ms = set(m['sgn_nz'] for m in members)
        if ms == {True}:
            orb_nz += 1
        elif ms == {False}:
            orb_z += 1
        else:
            orb_split += 1
            print(f"    [SPLIT orbit] rep size {len(rep)}; members: ", end='')
            for m in members:
                print(f"({m['sgn_nz']},|Aut|={m['aut_order']}) ", end='')
            print()
    print(f"    orbits all-non-zero: {orb_nz}")
    print(f"    orbits all-zero:     {orb_z}")
    print(f"    orbits mixed:        {orb_split}")

    # --- print the 84 non-vanishing CE-shape (one per orbit) ---
    print(f"\n  --- {len(sgn_nz_rows)} non-vanishing CE-shape: one representative per orbit ---")
    nz_orbits = {}
    for r in sgn_nz_rows:
        F = r['F']
        orbit = frozenset(apply_perm_to_family(F, p) for p in permutations(range(n)))
        rep = min(orbit, key=lambda Q: sorted(sorted(s) for s in Q))
        nz_orbits.setdefault(rep, []).append(r)
    print(f"    distinct orbits: {len(nz_orbits)}")
    for rep, members in sorted(nz_orbits.items(), key=lambda kv: (len(kv[1][0]['F']),)):
        r = members[0]
        print(f"    orbit (size {r['size']}, |Aut|={r['aut_order']}, "
              f"#in-orbit={len(members)}, ec={r['elt_count_sorted']}, "
              f"transps={r['transp_list']}):")
        print(f"      {show_family(r['F'])}")

    # --- HONEST: also report the orbits-of-CE-shape SUMMARY by Aut-order ---
    print(f"\n  --- CE-shape orbits split by |Aut| ---")
    orbit_by_aut = Counter()
    for rep, members in seen_orbit.items():
        orbit_by_aut[members[0]['aut_order']] += 1
    for o, cnt in sorted(orbit_by_aut.items()):
        print(f"    |Aut|={o}: {cnt} orbits")

    return rows


def n5_sharpening(size_caps=(6, 7, 8)):
    """Phase 2: test the coincidence on a structurally-bounded n=5 subclass."""
    n = 5
    ground = frozenset(range(n))
    subs = all_subsets(n)

    print(f"\n{'=' * 78}")
    print(f"PHASE 2  n=5 sharpening (bounded enumeration)  {el()}")
    print(f"{'=' * 78}")

    # build infra
    simp = punctured_boolean_simplices(n)
    top_dim = n - 2
    print(f"  Punctured Boolean simplices at n={n}: "
          f"{ {d: len(v) for d, v in simp.items()} }  {el()}")
    cob_cols, index_top, chains_top = coboundary_columns(simp, top_dim)
    print(f"  Coboundary basis: {len(cob_cols)} columns -> "
          f"{len(chains_top)} top-dim chains  {el()}")

    # precompute (and cache) the rank of cob_cols alone -- this is
    # constant across all F, and it's the dominant cost per F
    rk_without = rank2(cob_cols)
    print(f"  Coboundary rank (cached): {rk_without}  {el()}")

    def class_nonzero_cached(cochain):
        vec = {index_top[ch]: cochain[ch] for ch in chains_top if cochain[ch]}
        if not vec:
            return False
        rk_with = rank2(cob_cols + [vec])
        return rk_with > rk_without

    all_rows = []
    for cap in size_caps:
        print(f"\n  --- size cap |F| <= {cap}  {el()} ---")
        uc = enumerate_uc_with_top(n, cap)
        print(f"    UC families on [{n}] with [n] in F, |F|<={cap}: {len(uc)}  {el()}")
        ce = [F for F in uc if is_ce_shape(F, ground)]
        print(f"    of which CE-shape: {len(ce)}  {el()}")

        if not ce:
            print(f"    (none -- size cap too small)")
            continue

        rows = []
        for i, F in enumerate(ce):
            if i and i % 200 == 0:
                print(f"      ... {i}/{len(ce)}  {el()}")
            m_F = mobius_transform(F, subs)
            cochain = lift4_prod_cochain(m_F, chains_top)
            sgn = sgn_project(cochain, chains_top, n)
            sgn_nz = class_nonzero_cached(sgn)

            transps = transposition_list(F, n)
            aut = stabilizer(F, n)
            odd_stab = odd_stabilizer_list(F, n)
            ecv = element_count_vector(F, ground)
            gens = join_irreducibles(F)
            rows.append({
                'F': F,
                'size': len(F),
                'sgn_nz': sgn_nz,
                'aut_order': len(aut),
                'has_trans_sym': len(transps) > 0,
                'transp_list': transps,
                'has_odd_stab': len(odd_stab) > 0,
                'n_odd_stab': len(odd_stab),
                'elt_count_sorted': tuple(sorted(ecv)),
                'n_gens': len(gens),
                'gen_sizes': tuple(sorted(len(g) for g in gens)),
            })
        print(f"    done.  {el()}")

        all_rows.extend(rows)

        # local summary for this cap
        sgn_nz_rows = [r for r in rows if r['sgn_nz']]
        print(f"    CE-shape sgn-nonzero: {len(sgn_nz_rows)} / {len(rows)} "
              f"({(100*len(sgn_nz_rows)/len(rows)) if rows else 0:.1f}%)")
        # cross-tab with transposition symmetry
        no_trans_z = sum(1 for r in rows if not r['has_trans_sym'] and not r['sgn_nz'])
        no_trans_nz = sum(1 for r in rows if not r['has_trans_sym'] and r['sgn_nz'])
        ts_z = sum(1 for r in rows if r['has_trans_sym'] and not r['sgn_nz'])
        ts_nz = sum(1 for r in rows if r['has_trans_sym'] and r['sgn_nz'])
        print(f"    cross-tab (transp_sym x sgn_nz):")
        print(f"      no_trans + sgn_z  : {no_trans_z}")
        print(f"      no_trans + sgn_nz : {no_trans_nz}")
        print(f"      has_trans + sgn_z : {ts_z}")
        print(f"      has_trans + sgn_nz: {ts_nz}")

    # accumulated summary across all caps
    if not all_rows:
        print("\n  (no n=5 CE-shape families found within size cap)")
        return all_rows

    # de-dup across caps (a family of size 4 appears in cap=6,7,8 -- keep only once)
    seen = set()
    uniq = []
    for r in all_rows:
        if r['F'] not in seen:
            seen.add(r['F'])
            uniq.append(r)
    print(f"\n  Unique CE-shape families across all caps: {len(uniq)}")
    sgn_nz_uniq = sum(1 for r in uniq if r['sgn_nz'])
    print(f"    sgn-nonzero: {sgn_nz_uniq} / {len(uniq)} "
          f"({100*sgn_nz_uniq/len(uniq):.1f}%)")

    # final transposition cross-tab
    no_trans_z = sum(1 for r in uniq if not r['has_trans_sym'] and not r['sgn_nz'])
    no_trans_nz = sum(1 for r in uniq if not r['has_trans_sym'] and r['sgn_nz'])
    ts_z = sum(1 for r in uniq if r['has_trans_sym'] and not r['sgn_nz'])
    ts_nz = sum(1 for r in uniq if r['has_trans_sym'] and r['sgn_nz'])
    print(f"\n  --- ACCUMULATED (de-duped) cross-tab (transp_sym x sgn_nz) at n=5 ---")
    print(f"    no_trans + sgn_z  : {no_trans_z}")
    print(f"    no_trans + sgn_nz : {no_trans_nz}")
    print(f"    has_trans + sgn_z : {ts_z}")
    print(f"    has_trans + sgn_nz: {ts_nz}")

    # sharper: odd-stabilizer cross-tab
    no_odd_z = sum(1 for r in uniq if not r['has_odd_stab'] and not r['sgn_nz'])
    no_odd_nz = sum(1 for r in uniq if not r['has_odd_stab'] and r['sgn_nz'])
    yes_odd_z = sum(1 for r in uniq if r['has_odd_stab'] and not r['sgn_nz'])
    yes_odd_nz = sum(1 for r in uniq if r['has_odd_stab'] and r['sgn_nz'])
    print(f"\n  --- ACCUMULATED (de-duped) SHARP cross-tab (odd-stab x sgn_nz) at n=5 ---")
    print(f"    no odd-stab + sgn_z  : {no_odd_z}  (false-pos for hyp B)")
    print(f"    no odd-stab + sgn_nz : {no_odd_nz} (consistent)")
    print(f"    has odd-stab + sgn_z : {yes_odd_z} (consistent / odd elt kills)")
    print(f"    has odd-stab + sgn_nz: {yes_odd_nz} (odd elt + class non-zero)")

    # sample non-vanishing
    nz_rows = [r for r in uniq if r['sgn_nz']]
    if nz_rows:
        print(f"\n  --- sample n=5 CE-shape non-vanishing (up to 20) ---")
        for r in nz_rows[:20]:
            print(f"    |F|={r['size']}, |Aut|={r['aut_order']}, "
                  f"#transp={len(r['transp_list'])}, ec={r['elt_count_sorted']}: "
                  f"{show_family(r['F'])}")

    # |Aut| profile at n=5
    print(f"\n  --- |Aut(F)| cross-tab at n=5 (de-duped CE-shape) ---")
    aut_x_nz = Counter()
    aut_x_z = Counter()
    for r in uniq:
        if r['sgn_nz']:
            aut_x_nz[r['aut_order']] += 1
        else:
            aut_x_z[r['aut_order']] += 1
    for o in sorted(set(aut_x_nz) | set(aut_x_z)):
        print(f"    |Aut|={o}: sgn_nz={aut_x_nz[o]}, sgn_z={aut_x_z[o]}")

    return uniq


# ============================================================================
# Run
# ============================================================================
if __name__ == '__main__':
    print("=" * 78)
    print("Frankl-Numerical-Coincidence-Sharpening  mg-3978")
    print("=" * 78)
    print("Per mg-e466: 'Frankl truth iff LIFT-4-prod sgn vanishes for CE-shape F-star'")
    print("holds 100% at n=3 (12/12) and 86% at n=4 (498/582).  This probe sharpens")
    print("the 14% non-vanish at n=4 (84 families) and tests at n=5.")
    print()

    rows4 = n4_sharpening()
    # n=5: cap=7 is the practical ceiling per-polecat-session.  cap=8 is
    # tractable in principle (UC count ~150k, CE-shape ~20k) but takes
    # tens of minutes and the additional data only refines the regime
    # the cap=7 enumeration already characterises.
    rows5 = n5_sharpening(size_caps=(6, 7))

    print(f"\n{'=' * 78}")
    print(f"TOTAL TIME  {el()}")
    print(f"{'=' * 78}")
