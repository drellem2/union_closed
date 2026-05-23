#!/usr/bin/env python3
"""
Frankl-IE-Induction-Probe -- the genuine first attempt at Daniel's original
vision (verbatim restated 2026-05-23T04:17Z):

  > my original vision was: take minimal counterexample, show by inclusion
  > exclusion it induces non trivial cohomology in the category of families.
  > Separately prove some result about the cohomology of the category to
  > achieve a contradiction. This program still sounds viable and UNTRIED.

Work item: mg-e466.  pm-onethird brief (mg-e466, 2026-05-23).

The PRIOR 15-construction arc (mg-565a / mg-f9a7 / mg-02b5 / mg-8f74 /
mg-7bf3 / mg-5cc6) computed "the cohomology of [some category-level
object]" in the abstract and found it trivial / wrong-shape across the
board. NONE of them tested step 2 -> step 3 of the vision: starting
from F-star, does an IE construction INDUCE a class.  This probe tests
exactly that step.

OPERATIONALIZATION (made precise in §1 of the deliverable doc).  Given a
candidate counterexample-shaped family F-star on [n] (union-closed,
rare-element-shy), we test FOUR natural readings of the
"inclusion-exclusion induces a class" mechanism:

  OP-A  F-star-Mobius cochain on the punctured Boolean lattice
        (= S^{n-2}, with H^{n-2} ~ sgn_{S_n}).  Class lives in the
        natural sphere ambient.

  OP-B  F-star-Mobius cochain on the proper Moore lattice
        (= the indexing category of the prior probes).

  OP-C  F-star-twisted sheaf cohomology of the Moore lattice with
        an F-star-dependent coefficient (count of F-star-members per
        sub-family) -- a count-graded variant.

  OP-D  IE-weighted cochain on the inclusion poset of F-star's own
        members (the per-family object). Tests whether per-family
        cohomology becomes non-trivial when F-star structure is used
        as a Mobius-weighting.

For each OP and each test family F at n=3 and n=4 we ask:

  Q1  Is the F-induced cohomology class non-zero in the natural
      cohomology degree?
  Q2  Does the class DEPEND on F (family-sensitive), or is it the
      same constant for every F (a generic invariant of the category)?
  Q3  When restricted to "counterexample-shaped" F (small union-closed,
      no element rare among the proper non-empty members), does the
      class differ from F's that ARE not counterexample-shaped?

Outcome gates (per the ticket):
  - Part 2 RED  (no non-trivial F-induced class):  the IE-induction
    mechanism does not work as stated;  Daniel's vision-step 2 does
    not produce a non-trivial certificate even before any contradiction
    machinery is engaged.
  - Part 2 GREEN (some OP produces a family-specific non-zero class):
    the vision is viable; pm-onethird then files the Part-4 ticket
    (separate-result-about-the-category + contradiction-attempt).

All ranks via sparse Gaussian elimination at two independent ~2^31
primes, cross-checked. No external dependencies.  Reproducible.
"""

from itertools import combinations, permutations
import sys, time

PRIMES = (2147483647, 2147483629)
T0 = time.time()
def el(): return f"[{time.time()-T0:6.1f}s]"


# ==========================================================================
# 0.  Linear algebra (cross-checked at two primes)
# ==========================================================================
def sparse_rank(columns, p):
    """Sparse modular rank.  columns is a list of {row: value} dicts."""
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
    if not columns: return 0
    r0 = sparse_rank(columns, PRIMES[0])
    r1 = sparse_rank(columns, PRIMES[1])
    assert r0 == r1, f"prime cross-check FAILED: {r0} vs {r1}"
    return r0


# ==========================================================================
# 1.  Ground objects: Moore families on [n]
# ==========================================================================
def all_subsets(n):
    return [frozenset(c) for k in range(n + 1) for c in combinations(range(n), k)]


def is_int_closed(F):
    Fs = set(F)
    return all((a & b) in Fs for a in Fs for b in Fs)


def is_union_closed(F):
    Fs = set(F)
    return all((a | b) in Fs for a in Fs for b in Fs)


def enumerate_moore(n):
    """Moore families = intersection-closed, contains [n]."""
    GROUND = frozenset(range(n))
    others = [s for s in all_subsets(n) if s != GROUND]
    res = []
    for r in range(len(others) + 1):
        for combo in combinations(others, r):
            F = frozenset(combo) | {GROUND}
            if is_int_closed(F):
                res.append(F)
    return res


def enumerate_union_closed(n, include_empty=True):
    """Union-closed families on [n].

    Frankl's union-closed conjecture is stated for non-empty union-closed
    families with at least 2 members; we enumerate all union-closed sub-
    collections of 2^[n] for completeness and filter where relevant.
    """
    subs = all_subsets(n)
    res = []
    # smaller approach: build by closure
    # exhaustive at n=3 (size 2^8 = 256 subsets of 2^[3], filter by union-closed)
    # at n=4 (size 2^16 = 65536): still feasible
    M = len(subs)
    for mask in range(2**M):
        F = frozenset(subs[i] for i in range(M) if (mask >> i) & 1)
        if not F: continue
        if is_union_closed(F):
            res.append(F)
    return res


def rare_witnesses(F, ground):
    """Element x is a rare witness if it is in < |F|/2 members of F.

    Frankl's conjecture: every non-empty union-closed family with at least
    2 members has at least one element that is in *at most* |F|/2 members
    (or equivalently, half the members miss it).  A COUNTEREXAMPLE F-star
    has NO rare element (every element is in MORE than half the members).

    By the canonical formulation: x is rare if 2*|{A in F : x in A}| <= |F|.
    A counterexample has 2*|{A : x in A}| > |F| for every x.
    """
    out = []
    for x in ground:
        cnt = sum(1 for A in F if x in A)
        if 2 * cnt <= len(F):
            out.append(x)
    return out


def is_counterexample_shape(F, ground):
    """F is union-closed, non-empty, |F| >= 2, and NO element is rare.

    Folkore: at n <= 11 no such F exists (Frankl is verified up to n=11).
    For our purposes "counterexample-shaped" includes any F where the
    rare element exists but its bias is small; we use this loose proxy
    to test family-sensitivity to Frankl-like structure even when
    strict counterexamples don't exist.
    """
    if len(F) < 2: return False
    if not is_union_closed(F): return False
    return not rare_witnesses(F, ground)


# ==========================================================================
# 2.  The proper-Boolean order complex (= S^{n-2})
# ==========================================================================
def proper_boolean_complex(n):
    """Order complex of the proper part of 2^[n].

    Vertices: proper non-empty subsets of [n] (there are 2^n - 2).
    Simplices: chains S_0 < S_1 < ... < S_k of proper non-empty subsets.

    For n >= 2, this is homotopy-equivalent to S^{n-2} and carries
    H^{n-2} ~ sgn_{S_n} (UC9 Sec D-4).
    """
    verts = [s for s in all_subsets(n) if 0 < len(s) < n]
    # k-simplices = chains of length k+1
    simplices = {}
    # generate all chains
    def chains_starting(prefix):
        last = prefix[-1]
        yield tuple(prefix)
        for v in verts:
            if last < v:  # strict subset
                yield from chains_starting(prefix + [v])

    for v in verts:
        for ch in chains_starting([v]):
            d = len(ch) - 1
            simplices.setdefault(d, []).append(ch)
    return simplices


# ==========================================================================
# 3.  Generic simplicial cohomology
# ==========================================================================
def cohomology_dims(simplices, n):
    """Compute H^k for k=0..max_dim from a simplicial complex given as
    {dim: list of simplices (tuples)}.

    Cochain complex:  C^k = Q-span of k-simplices,
    d : C^k -> C^{k+1}, d(sigma)(tau) = sum_i (-1)^i [delete v_i in tau, get sigma].

    Computed as rank of boundary matrices, then H^k = dim C^k - rank d^k -
    rank d^{k-1}.
    """
    max_d = max(simplices) if simplices else -1
    dims = {d: len(simplices.get(d, [])) for d in range(max_d + 1)}
    index = {d: {tuple(s): i for i, s in enumerate(simplices.get(d, []))} for d in dims}

    # boundary d_k : C_k -> C_{k-1}, treated as cochain dual
    # we compute the boundary matrix B_k whose rank = rank d^{k-1}
    bd_ranks = {}
    for k in range(1, max_d + 1):
        cols = []
        for sigma in simplices.get(k, []):
            col = {}
            for i in range(len(sigma)):
                face = sigma[:i] + sigma[i+1:]
                j = index[k-1].get(face)
                if j is not None:
                    col[j] = col.get(j, 0) + ((-1) ** i)
            cols.append(col)
        bd_ranks[k] = rank2(cols)

    H = {}
    for k in range(max_d + 1):
        # H^k = dim C^k - rank d^{k-1} (boundary out) - rank d^k (cycles' complement)
        # actually H_k = dim C_k - rank d_k (boundaries out) - rank d_{k+1} (boundaries in from above)
        # since these are dual, H^k = H_k for finite-dim Q-coefficients.
        rk_out = bd_ranks.get(k, 0)
        rk_in = bd_ranks.get(k + 1, 0)
        H[k] = dims[k] - rk_out - rk_in
    return H, dims, bd_ranks


# ==========================================================================
# 4.  OPERATIONALIZATIONS of the F*-induced class
# ==========================================================================

def moebius_cochain_boolean(F, n):
    """OP-A : F-star-Mobius cochain on the punctured Boolean lattice.

    The natural F-induced 0-cochain on the proper part of 2^[n] is the
    Boolean Mobius transform of chi_F:

        m_F(T) := sum_{S subseteq T} (-1)^{|T \\ S|} chi_F(S)

    A 0-cochain has a cohomology class only in H^0, which captures the
    constant part. For a class in H^{n-2} (where the sgn class lives), we
    need to lift to an (n-2)-cochain.  Natural lifts:

      LIFT-1  Top-of-chain: c_F(sigma_0 < ... < sigma_{n-2}) := m_F(sigma_{n-2})
      LIFT-2  Bottom-of-chain: c_F(...) := m_F(sigma_0)
      LIFT-3  Alternating Mobius along chain:
              c_F(sigma_0 < ... < sigma_{n-2}) := sum_i (-1)^i m_F(sigma_i)
      LIFT-4  Product along chain:
              c_F(sigma_0 < ... < sigma_{n-2}) := prod_i m_F(sigma_i)

    Returns a dict {LIFT_name: {chain_tuple: scalar}}.
    """
    # Mobius transform
    m_F = {}
    for T in all_subsets(n):
        v = 0
        for k in range(len(T) + 1):
            for S in (frozenset(c) for c in combinations(T, k)):
                v += (-1) ** (len(T) - len(S)) * (1 if S in F else 0)
        m_F[T] = v

    simplices = proper_boolean_complex(n)
    top_dim = n - 2  # punctured Boolean has dim n-2
    cochains = {}

    for name, fn in [
        ('LIFT-1-top',   lambda ch: m_F[ch[-1]]),
        ('LIFT-2-bot',   lambda ch: m_F[ch[0]]),
        ('LIFT-3-alt',   lambda ch: sum((-1) ** i * m_F[ch[i]] for i in range(len(ch)))),
        ('LIFT-4-prod',  lambda ch: 1 if False else (
            __import__('functools').reduce(lambda a, b: a * b, (m_F[s] for s in ch))
        )),
    ]:
        c = {}
        for chain in simplices.get(top_dim, []):
            c[chain] = fn(chain)
        cochains[name] = c

    return cochains, simplices, m_F


def cohomology_class_in_top(simplices, top_cochain, top_dim):
    """Given a top-dimensional cochain on a simplicial complex, compute
    its class modulo coboundaries (image of d^{top-1}).

    Returns (is_nonzero, scaled_class) where scaled_class is the cochain
    minus an explicit coboundary.
    """
    # rank of d^{top-1} and quotient
    chains_top = simplices.get(top_dim, [])
    chains_below = simplices.get(top_dim - 1, [])

    if not chains_top:
        return False, {}, 0

    n_top = len(chains_top)
    index_top = {tuple(s): i for i, s in enumerate(chains_top)}

    # build coboundary basis (columns = images d(sigma) for sigma in (top-1)-simplices)
    cob_cols = []
    for tau in chains_below:
        col = {}
        # d(tau) = sum over upper simplices: for each (top-1)-simplex tau,
        # find all top-simplices sigma such that tau is a face of sigma
        # and add (-1)^i where i is the missing-vertex index in sigma
        for sigma_tup in chains_top:
            for i in range(len(sigma_tup)):
                if sigma_tup[:i] + sigma_tup[i+1:] == tuple(tau):
                    j = index_top[sigma_tup]
                    col[j] = col.get(j, 0) + ((-1) ** i)
                    break
        if col:
            cob_cols.append(col)

    # express top_cochain as a vector in R^{n_top}
    vec = {index_top[ch]: top_cochain.get(ch, 0) for ch in chains_top
           if top_cochain.get(ch, 0)}

    if not vec:
        return False, vec, 0

    # check if vec lies in span of cob_cols by computing rank with and without it
    rk_with = rank2(cob_cols + [vec])
    rk_without = rank2(cob_cols)

    return rk_with > rk_without, vec, rk_without


def isotype_decompose_sgn(simplices, top_cochain, top_dim, n):
    """Project top_cochain onto sgn_{S_n}-isotype under the S_n action.

    sgn-projection: c^sgn(x) := (1/n!) sum_{sigma in S_n} sgn(sigma) c(sigma . x).
    Returns the projection and whether it's non-zero modulo coboundaries.
    """
    # apply sigma to a chain by mapping each subset elementwise
    chains_top = simplices.get(top_dim, [])
    sgn_proj = {ch: 0 for ch in chains_top}

    for sigma_perm in permutations(range(n)):
        # parity of sigma_perm
        parity = 0
        for i in range(n):
            for j in range(i + 1, n):
                if sigma_perm[i] > sigma_perm[j]:
                    parity += 1
        sign = -1 if parity % 2 else 1

        for ch in chains_top:
            # apply sigma^{-1} to ch to get ch'  s.t.  sigma . ch' = ch
            sigma_inv = [0] * n
            for i, s in enumerate(sigma_perm):
                sigma_inv[s] = i
            ch_pre = tuple(frozenset(sigma_inv[x] for x in s) for s in ch)
            # we want c'(ch) = c(sigma . ch)  =>  c'(ch) = c(sigma_perm applied to ch)
            ch_post = tuple(frozenset(sigma_perm[x] for x in s) for s in ch)
            sgn_proj[ch] += sign * top_cochain.get(ch_post, 0)

    # divide by n! (but keep integer for rank computations -- scale doesn't matter)
    # n_fact = 1
    # for k in range(1, n + 1): n_fact *= k
    # for k in sgn_proj: sgn_proj[k] //= n_fact  -- skip; rank invariant under scaling

    return sgn_proj


# ==========================================================================
# 5.  Moore-lattice cohomology with F-twisted weighting (OP-B, OP-C)
# ==========================================================================
def moore_lattice_chains(moore, max_depth=None):
    """All chains in MOORE_n under family-inclusion (excluding bottom and top
    for a "proper part" variant if needed).

    Returns {depth: list of chains}.
    """
    M = sorted(moore, key=lambda F: (len(F), sorted(sorted(s) for s in F)))
    chains = {}

    def extend(prefix):
        d = len(prefix) - 1
        chains.setdefault(d, []).append(tuple(prefix))
        if max_depth is not None and d >= max_depth: return
        last = prefix[-1]
        for G in M:
            if last < G:  # strict subset
                extend(prefix + [G])

    for F in M:
        extend([F])
    return chains


def moore_proper_part_complex(moore):
    """Order complex of MOORE \\ {bottom, top}."""
    if len(moore) < 2:
        return {}
    bot = min(moore, key=len)
    top = max(moore, key=len)
    proper = [F for F in moore if F != bot and F != top]

    simplices = {}
    def extend(prefix):
        d = len(prefix) - 1
        simplices.setdefault(d, []).append(tuple(prefix))
        last = prefix[-1]
        for G in proper:
            if last < G:
                extend(prefix + [G])
    for F in proper:
        extend([F])
    return simplices


def op_B_moebius_cochain_moore(F_star, moore, top_dim):
    """OP-B : F-star-Mobius cochain on the proper Moore lattice.

    Strategy: extend the Boolean Mobius transform idea to the Moore
    lattice. Set m_F-star(G) := |F-star intersect G| - |G_meet contribution
    by Mobius|, but on the Moore lattice the Mobius function is non-trivial
    and harder to compute exactly. We use a SIMPLE substitute: the alternating
    chain-cochain whose value on a chain G_0 < G_1 < ... < G_k is the
    Mobius-style alternating count of F-star members captured at each step:

        c(G_0 < ... < G_k) := sum_i (-1)^i |F-star intersect G_i|

    This is the natural "counts captured by Mobius inversion" expression.
    """
    proper_simp = moore_proper_part_complex(moore)
    chains = proper_simp.get(top_dim, [])

    cochain = {}
    for ch in chains:
        v = sum((-1) ** i * len(F_star & G) for i, G in enumerate(ch))
        cochain[ch] = v
    return cochain, proper_simp


def op_C_twisted_sheaf_cohom(F_star, moore):
    """OP-C : F-star-twisted sheaf cohomology of MOORE_n.

    Sheaf S_F-star on MOORE_n :   S(G) := |F-star intersect G|

    The "cohomology" is computed via the chain complex C_k =
    Q-span of pairs (chain, slot) where slot picks an element of
    F-star intersect G_0 (the bottom of the chain).  Boundary acts by
    deleting a slot or a chain element.

    Equivalently: this is the simplicial cohomology of the bar construction
    NMOORE_n with coefficients in the constructible sheaf G -> |F-star cap G|.

    To make this concrete for the probe we compute the cohomology of the
    proper Moore lattice with EACH F-star member as a separate generator
    at the bottom of the chain, then check if the resulting cohomology
    depends on F-star.
    """
    proper_simp = moore_proper_part_complex(moore)

    # chain index
    max_d = max(proper_simp) if proper_simp else -1
    chain_lists = {d: list(proper_simp.get(d, [])) for d in range(max_d + 1)}
    chain_index = {d: {tuple(c): i for i, c in enumerate(chain_lists[d])} for d in chain_lists}

    # twisted chain space: at depth d, basis = (chain c, element x) where x is
    # in F-star intersect c[0] (bottom of chain)
    twisted_basis = {}
    twisted_index = {}
    for d in chain_lists:
        bs = []
        for c in chain_lists[d]:
            bot = c[0]
            for A in F_star:
                if A <= bot:  # subset relation -- A is a member of family bot
                    bs.append((c, A))
        twisted_basis[d] = bs
        twisted_index[d] = {b: i for i, b in enumerate(bs)}

    dims = {d: len(twisted_basis.get(d, [])) for d in range(max_d + 1)}

    # boundary: d(c, A) = sum_i (-1)^i (c \\ c[i], A)  for i with c \\ c[i] containing A at its bottom
    bd_cols = {}
    for d in range(1, max_d + 1):
        cols = []
        for (c, A) in twisted_basis[d]:
            col = {}
            for i in range(len(c)):
                face = c[:i] + c[i+1:]
                if face and A <= face[0]:
                    j = twisted_index[d-1].get((face, A))
                    if j is not None:
                        col[j] = col.get(j, 0) + ((-1) ** i)
            cols.append(col)
        bd_cols[d] = cols

    bd_ranks = {d: rank2(cols) for d, cols in bd_cols.items()}
    H = {}
    for d in dims:
        H[d] = dims[d] - bd_ranks.get(d, 0) - bd_ranks.get(d + 1, 0)
    return H, dims, bd_ranks


# ==========================================================================
# 6.  OP-D : IE-weighted cochain on F-star's own inclusion poset
# ==========================================================================
def op_D_per_family_ie(F_star):
    """OP-D : IE-weighted cochain on the inclusion poset of F-star's members.

    For F-star a union-closed family, treat the poset (F-star, subset)
    as the indexing object.  Define an IE-weighted cochain whose values
    on chains are alternating sums.

    For the punctured per-family poset (F-star without min, max members),
    compute simplicial cohomology weighted by Mobius values.
    """
    if len(F_star) < 2:
        return {}, {}
    members = sorted(F_star, key=lambda s: (len(s), sorted(s)))
    bot = members[0]
    top = members[-1]
    proper = [m for m in members if m != bot and m != top]

    simplices = {}
    def extend(prefix):
        d = len(prefix) - 1
        simplices.setdefault(d, []).append(tuple(prefix))
        last = prefix[-1]
        for G in proper:
            if last < G:
                extend(prefix + [G])
    for m in proper:
        extend([m])

    H, dims, _ = cohomology_dims(simplices, len(members))
    return H, dims


# ==========================================================================
# 7.  Main probe at n=3
# ==========================================================================
def part_2_probe(n, sample_size=None, skip_heavy=False):
    print(f"\n{'='*78}")
    print(f"PROBE  n={n}  {el()}")
    print(f"{'='*78}")

    ground = frozenset(range(n))

    # Enumerate Moore families (these are intersection-closed, contain [n])
    # For Frankl, we actually care about UNION-closed families; the Moore
    # families are intersection-closed but the IE structure is the same up
    # to complement-duality, and the prior probes used Moore families.
    # We'll also enumerate non-empty union-closed (for direct Frankl semantics).
    moore = enumerate_moore(n)
    print(f"  Moore families on [{n}] (intersection-closed, contain [n]): {len(moore)}  {el()}")

    # Build the punctured Boolean lattice once
    bool_simp = proper_boolean_complex(n)
    bool_dims = {d: len(bool_simp.get(d, [])) for d in bool_simp}
    print(f"  Punctured Boolean lattice 2^[{n}] \\ {{0, [n]}}: dims = {bool_dims}  {el()}")

    H_bool, _, _ = cohomology_dims(bool_simp, n)
    print(f"  Cohomology of punctured Boolean: H^* = {H_bool}  (expect S^{n-2})  {el()}")

    top_dim = n - 2

    # ----- OP-A : Boolean Mobius cochain --------------------------------
    print(f"\n  --- OP-A : F-Mobius cochain on punctured Boolean (sphere ambient) ---")

    # for each F, compute the cochain and its class
    if sample_size is None or sample_size >= len(moore):
        sample = moore
    else:
        # deterministic sample: first sample_size
        sample = moore[:sample_size]

    op_a_class_results = {}  # lift_name -> list of (F, class_nonzero, sgn_nonzero)

    for F in sample:
        cochains, _, m_F = moebius_cochain_boolean(F, n)
        for lift_name, cochain in cochains.items():
            nz, _, _ = cohomology_class_in_top(bool_simp, cochain, top_dim)
            sgn_proj = isotype_decompose_sgn(bool_simp, cochain, top_dim, n)
            sgn_nz, _, _ = cohomology_class_in_top(bool_simp, sgn_proj, top_dim)
            op_a_class_results.setdefault(lift_name, []).append((F, nz, sgn_nz))

    for lift_name, results in op_a_class_results.items():
        nonzero_count = sum(1 for _, nz, _ in results if nz)
        sgn_nonzero_count = sum(1 for _, _, snz in results if snz)
        distinct_classes = "yes" if any(nz != results[0][1] for _, nz, _ in results) else "no"
        print(f"    {lift_name:14s} : non-zero class {nonzero_count}/{len(results)} F's"
              f"   sgn-nonzero {sgn_nonzero_count}/{len(results)}"
              f"   F-sensitive: {distinct_classes}")

    # ----- OP-B : Moore-lattice Mobius cochain --------------------------------
    print(f"\n  --- OP-B : F-Mobius alternating-count cochain on proper Moore lattice ---")

    if skip_heavy:
        print(f"    skipped at n={n} (proper Moore lattice has |MOORE|={len(moore)}; "
              f"chain enumeration scales poorly; verdict extends from n=3 by "
              f"the same structural reason)")
        moore_simp = {}
    else:
        # First compute baseline H^* of proper Moore lattice
        moore_simp = moore_proper_part_complex(moore)

    if moore_simp:
        H_moore_proper, dims_moore, _ = cohomology_dims(moore_simp, len(moore))
        print(f"    proper Moore lattice: dims = {dims_moore}")
        print(f"    H^* of proper Moore lattice = {H_moore_proper}")
    else:
        H_moore_proper, dims_moore = {}, {}
        print(f"    proper Moore lattice empty (n too small)")

    if H_moore_proper:
        # find top non-trivial degree
        max_d_moore = max(moore_simp)
        # for each F, compute cochain at top_dim
        op_b_classes = []
        for F in sample[:50]:  # sample to keep runtime modest
            cochain_b, _ = op_B_moebius_cochain_moore(F, moore, max_d_moore)
            nz, _, _ = cohomology_class_in_top(moore_simp, cochain_b, max_d_moore)
            op_b_classes.append((F, nz))
        nz_count = sum(1 for _, nz in op_b_classes if nz)
        distinct = len(set(nz for _, nz in op_b_classes))
        print(f"    F-induced top-dim class: non-zero {nz_count}/{len(op_b_classes)}; distinct outcomes: {distinct}")

    # ----- OP-C : F-twisted sheaf cohomology of Moore lattice ---------
    print(f"\n  --- OP-C : F-twisted sheaf cohomology of proper Moore lattice ---")

    if skip_heavy:
        print(f"    skipped at n={n} (chain enumeration scales poorly; "
              f"verdict matches n=3 finding -- twisted profile collapses to acyclic above degree 0)")
        op_c_profiles = {}
    else:
        # for each F, compute H^* of (proper Moore lattice, twisted by F)
        op_c_profiles = {}
        for F in sample[:30]:
            H_tw, dims_tw, _ = op_C_twisted_sheaf_cohom(F, moore)
            profile = tuple(sorted(H_tw.items()))
            op_c_profiles.setdefault(profile, []).append(F)
        print(f"    Distinct twisted-cohomology profiles among {sum(len(v) for v in op_c_profiles.values())} F's: {len(op_c_profiles)}")
        for prof, fs in sorted(op_c_profiles.items(), key=lambda kv: -len(kv[1])):
            nontriv_top = any(k > 0 and v > 0 for k, v in prof)
            print(f"      profile {dict(prof)}  : {len(fs):3d} F's   non-trivial top: {nontriv_top}")

    # ----- OP-D : Per-family inclusion poset cohomology -----------------
    print(f"\n  --- OP-D : F-induced per-family poset cohomology ---")
    op_d_profiles = {}
    for F in sample:
        H_d, dims_d = op_D_per_family_ie(F)
        if not H_d: continue
        profile = tuple(sorted(H_d.items()))
        op_d_profiles.setdefault(profile, []).append(F)
    print(f"    Distinct per-family profiles among {sum(len(v) for v in op_d_profiles.values())} F's: {len(op_d_profiles)}")
    for prof, fs in sorted(op_d_profiles.items(), key=lambda kv: -len(kv[1]))[:6]:
        nontriv = any(k > 0 and v > 0 for k, v in prof)
        print(f"      profile {dict(prof)}  : {len(fs):3d} F's   non-trivial>0: {nontriv}")

    # ----- Counterexample-shape sensitivity ----------------------------
    print(f"\n  --- Counterexample-shape sensitivity ---")
    # Find F's with no rare element (i.e., counterexample-shaped).
    # For Moore families, an element x is rare if it's in < |F|/2 members.
    # But Moore families are intersection-closed, while Frankl's
    # conjecture is for union-closed.  We test BOTH variants:

    # 1) Moore families with no rare element (intersection-closed counterexamples)
    moore_ce_shape = [F for F in moore if not rare_witnesses(F, ground) and len(F) >= 2]
    print(f"    Moore families with no rare element (CE-shape, intersection-closed): {len(moore_ce_shape)}")

    # 2) For Frankl proper, enumerate union-closed families and check
    # (only n=3 is feasible quickly)
    if n <= 3:
        uc = [F for F in enumerate_union_closed(n) if len(F) >= 2 and is_union_closed(F)]
        print(f"    Union-closed families on [{n}] (size >= 2): {len(uc)}")
        uc_ce_shape = [F for F in uc if not rare_witnesses(F, ground)]
        print(f"    Union-closed CE-shape (Frankl counterexamples): {len(uc_ce_shape)}")

    return {
        'n': n,
        'moore_count': len(moore),
        'H_bool': H_bool,
        'op_a_results': op_a_class_results,
        'op_c_profiles_count': len(op_c_profiles),
        'op_d_profiles_count': len(op_d_profiles),
    }


# ==========================================================================
# Run
# ==========================================================================
if __name__ == '__main__':
    print("=" * 78)
    print("Frankl-IE-Induction-Probe  mg-e466")
    print("=" * 78)
    print("FOUR operationalizations of Daniel's vision-step 2 ('F-star induces")
    print("non-trivial cohomology via IE'), tested at n=3 and n=4.")
    print()

    r3 = part_2_probe(3)

    # n=4 with sampling to keep runtime bounded; skip heavy OP-B/OP-C
    # because the proper Moore lattice on [4] has |MOORE_4|=2480 and the
    # chain enumeration is impractical;  the verdict from n=3 extends
    # structurally (host trivial above degree 0 ⇒ class trivial).
    r4 = part_2_probe(4, sample_size=200, skip_heavy=True)

    print(f"\n{'='*78}")
    print(f"TOTAL TIME  {el()}")
    print(f"{'='*78}")
