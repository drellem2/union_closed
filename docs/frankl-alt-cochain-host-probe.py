#!/usr/bin/env python3
"""
Frankl-Alt-Cochain-Host-Probe -- mg-1b24

Second of three Frankl bypass angles per Daniel reminder 2026-05-23T05:37Z.
Test alternative F-natural cochains and alternative hosts to see if any
evade the CE-shape symmetry-vanishing obstruction established in mg-e466.

PRIOR ART (mg-e466, RED). LIFT-1 / LIFT-2 / LIFT-3 / LIFT-4-prod on the
punctured-Boolean host (= S^{n-2}, H^{n-2} ≅ sgn_{S_n}) yielded non-zero
sgn-class for 24/61 Moore families at n=3 BUT zero for all 12 CE-shape
F's. The structural reason: CE-shape F⋆ has at least one transposition
σ in Stab(F⋆); any strictly F-natural cochain c satisfies
σ.c = c, hence sgn-projects to 0.

This probe tests two classes of alternatives explicitly opened by the
ticket: (A) "F-natural cochains equivariant (rather than invariant)
in non-trivial ways" and (B) "hosts that may carry a non-trivial
sgn-isotype even after the projection."

(A) ALTERNATIVE COCHAINS.
    Strictly F-natural (control -- should fail per mg-e466 reasoning):
      C-ENT-prod    entropy-weighted product over chain
      C-LOG-prod    log-Möbius product over chain
      C-PAIR-DIFF   product of Möbius differences along chain
      C-COUNT-prod  product of |F ∩ σ_i| over chain
      C-CUMUL       cross-cumulant of m_F values along chain
    Sgn-twisted F-natural (the equivariant relaxation):
      C-SGN-MOB-TOP   sgn(π_chain) . m_F(top)
      C-SGN-MOB-BOT   sgn(π_chain) . m_F(bot)
      C-SGN-MOB-PROD  sgn(π_chain) . prod m_F(σ_i)
      C-SGN-DEFICIT   sgn(π_chain) . (2 a_F(x_new) - |F|), x_new = top \\ bot
      C-SGN-COUNT     sgn(π_chain) . |F ∩ top|
    Inversion-weighted (S_n-equivariant in a non-character way):
      C-INV-MOB-TOP   inv(π_chain) . m_F(top)

(B) ALTERNATIVE HOSTS.
    HOST-PB-DEG-N    cochain of degree n-1 on punctured Boolean -- vacuous
                     (host has top dim n-2, so degree n-1 cochains = 0)
    HOST-SUSP-PB     simplicial suspension of punctured Boolean.
                     H^{n-1}(susp) ≅ H^{n-2}(PB) ≅ sgn.
    HOST-OPC-SGN     F-count-graded sheaf cohomology of Moore lattice
                     with the canonical sgn-twist on the coefficient.
    HOST-COUNT-GRD   count-graded variant of the punctured Boolean,
                     coefficient sheaf S(T) = ℚ[F ∩ T].

For each alternative we ask: does the sgn-class survive on CE-shape F⋆
at n=3?

OUTPUT.
  Per-cochain, per-F report: sgn-class scalar and non-zero flag.
  Per-host, per-cochain: same with the alternative host.
  Aggregate verdict: ANY ALTERNATIVE WORKS -> file n=4 follow-on;
                     NONE WORK -> symmetry obstruction is robust.

All ranks via sparse Gaussian elimination at two independent ~2^31 primes.
"""

from itertools import combinations, permutations
import math
import sys
import time
from functools import reduce

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
# 1.  Ground objects
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
    return len(F) >= 2 and is_union_closed(F) and not rare_witnesses(F, ground)


def enumerate_union_closed(n):
    subs = all_subsets(n)
    M = len(subs)
    res = []
    for mask in range(2**M):
        F = frozenset(subs[i] for i in range(M) if (mask >> i) & 1)
        if not F: continue
        if is_union_closed(F):
            res.append(F)
    return res


def show_fam(F):
    def show(s):
        return "{" + ",".join(str(i + 1) for i in sorted(s)) + "}" if s else "0"
    return "[" + " ".join(show(s) for s in sorted(F, key=lambda x: (len(x), sorted(x)))) + "]"


# ==========================================================================
# 2.  Punctured Boolean order complex and its top-dim cochains
# ==========================================================================
def proper_boolean_chains(n):
    """Top-dim chains in the order complex of 2^[n] \\ {∅, [n]}.
    A top-dim chain is σ_0 ⊊ σ_1 ⊊ ... ⊊ σ_{n-2} with σ_i a proper
    non-empty subset.  Such chains correspond bijectively to permutations
    of [n] (the order in which elements are added going from ∅ through
    σ_0, ..., σ_{n-2} to [n]).
    """
    verts = [s for s in all_subsets(n) if 0 < len(s) < n]
    chains = []
    def extend(prefix):
        if len(prefix) == n - 1:
            chains.append(tuple(prefix))
            return
        last = prefix[-1]
        for v in verts:
            if last < v:
                extend(prefix + [v])
    for v in verts:
        extend([v])
    return chains


def chain_permutation(chain, n):
    """Permutation of [n] determined by a top-dim chain.
    chain = (σ_0, σ_1, ..., σ_{n-2}) with |σ_i| = i+1.
    Returns the tuple (x_1, x_2, ..., x_n) where x_i is the element
    added at step i (so σ_0 = {x_1}, σ_1 = {x_1, x_2}, ..., [n] = {x_1, ..., x_n}).
    """
    perm = []
    prev = frozenset()
    for s in chain:
        new = list(s - prev)
        assert len(new) == 1, f"chain step not unit: {prev} -> {s}"
        perm.append(new[0])
        prev = s
    last = list(frozenset(range(n)) - prev)
    assert len(last) == 1
    perm.append(last[0])
    return tuple(perm)


def perm_sign(perm):
    n = len(perm)
    inv = 0
    for i in range(n):
        for j in range(i + 1, n):
            if perm[i] > perm[j]:
                inv += 1
    return -1 if inv % 2 else 1


def perm_inv(perm):
    n = len(perm)
    inv = 0
    for i in range(n):
        for j in range(i + 1, n):
            if perm[i] > perm[j]:
                inv += 1
    return inv


def coboundary_columns_punctured_boolean(n):
    """Coboundary columns at top dim (n-2) of the order complex of the
    proper part of 2^[n].  Each column is the coboundary of a (n-3)-simplex.
    For n=3 (top dim 1, sub dim 0), each vertex v has δ(v) = sum over
    edges with v at one end of ±1.
    """
    top_dim = n - 2
    chains_top = proper_boolean_chains(n)
    if top_dim <= 0:
        # for n=2 the complex is 6 isolated vertices? no, n=2: subsets {1},{2}, top_dim=0
        # for n=3: chains are edges, top_dim=1
        # if top_dim == 0, no coboundary
        return chains_top, []
    index_top = {tuple(c): i for i, c in enumerate(chains_top)}

    # generate (n-3)-simplices: chains σ_0 ⊊ ... ⊊ σ_{n-3}
    verts = [s for s in all_subsets(n) if 0 < len(s) < n]
    sub_chains = []
    def extend(prefix):
        if len(prefix) == n - 2:
            sub_chains.append(tuple(prefix))
            return
        last = prefix[-1]
        for v in verts:
            if last < v:
                extend(prefix + [v])
    for v in verts:
        extend([v])

    cols = []
    for sub in sub_chains:
        col = {}
        for sigma in chains_top:
            for i in range(len(sigma)):
                face = sigma[:i] + sigma[i+1:]
                if face == sub:
                    j = index_top[sigma]
                    col[j] = col.get(j, 0) + ((-1) ** i)
                    break
        if col:
            cols.append(col)
    return chains_top, cols


def class_nonzero(cochain_dict, chains_top, cob_cols):
    """Test whether the dict cochain has non-zero class modulo coboundaries.
    """
    index_top = {tuple(c): i for i, c in enumerate(chains_top)}
    vec = {}
    for ch, v in cochain_dict.items():
        if v:
            vec[index_top[ch]] = v
    if not vec:
        return False, 0
    rk_without = rank2(cob_cols)
    rk_with = rank2(cob_cols + [vec])
    return rk_with > rk_without, len(vec)


def sgn_project_cochain(cochain_dict, chains_top, n):
    """Sgn-project the top-dim cochain under the S_n action on subsets.

    (P_sgn c)(chain) := (1/n!) sum_{σ in S_n} sgn(σ) c(σ^{-1}.chain)
    """
    proj = {ch: 0 for ch in chains_top}
    for sigma_perm in permutations(range(n)):
        # parity & inverse
        sgn = perm_sign(sigma_perm)
        sigma_inv = [0] * n
        for i, s in enumerate(sigma_perm):
            sigma_inv[s] = i
        for ch in chains_top:
            ch_pre = tuple(frozenset(sigma_inv[x] for x in sset) for sset in ch)
            proj[ch] += sgn * cochain_dict.get(ch_pre, 0)
    # don't divide by n! -- rank computation invariant under scalar
    return proj


# ==========================================================================
# 3.  Mobius transform of chi_F
# ==========================================================================
def moebius_transform(F, n):
    """m_F(T) = sum_{S subseteq T} (-1)^{|T \\ S|} chi_F(S)."""
    m = {}
    for T in all_subsets(n):
        v = 0
        Tl = list(T)
        for k in range(len(Tl) + 1):
            for combo in combinations(Tl, k):
                S = frozenset(combo)
                v += (-1) ** (len(T) - len(S)) * (1 if S in F else 0)
        m[T] = v
    return m


def member_count(F, T):
    """|{A in F : A subseteq T}| -- "members captured at T"."""
    return sum(1 for A in F if A <= T)


def element_count(F, x):
    """a_F(x) = |{A in F : x in A}|."""
    return sum(1 for A in F if x in A)


def entropy(probs):
    """Shannon entropy of a list of non-negative reals (treated as probs after norm).
    Integer-flavored variant: return 1000 * H(p) rounded so we can keep integer arithmetic.
    Here we just return an integer functional that depends on F's element distribution.
    """
    s = sum(probs)
    if s == 0: return 0
    out = 0.0
    for p in probs:
        if p > 0:
            q = p / s
            out -= q * math.log(q)
    return int(round(out * 1000))


# ==========================================================================
# 4.  Cochain candidates
# ==========================================================================
def build_cochains(F, n, chains_top):
    """Build all cochain candidates listed in the docstring.  Each entry is
    {chain: integer value}.  Integer arithmetic throughout (entropy is
    integerized).
    """
    m_F = moebius_transform(F, n)
    cards = list(F)
    ground = frozenset(range(n))

    coch = {}

    # ---- strictly F-natural candidates (controls) ----
    # entropy product
    def ent_T(T):
        return entropy([element_count(F, x) for x in T]) if T else 0

    def log_T(T):
        # log-deficit style: log(1 + |m_F(T)|) scaled
        return int(round(math.log(1 + abs(m_F[T])) * 1000))

    def deficit_pair(prev, cur):
        new = list(cur - prev)
        if not new: return 0
        x = new[0]
        return 2 * element_count(F, x) - len(F)

    coch['C-ENT-prod'] = {ch: reduce(lambda a, b: a * b, (ent_T(s) for s in ch), 1)
                          for ch in chains_top}

    coch['C-LOG-prod'] = {ch: reduce(lambda a, b: a * b, (log_T(s) for s in ch), 1)
                          for ch in chains_top}

    coch['C-PAIR-DIFF'] = {
        ch: reduce(lambda a, b: a * b,
                   (m_F[ch[i+1]] - m_F[ch[i]] for i in range(len(ch)-1)), 1) if len(ch) > 1 else 0
        for ch in chains_top
    }

    coch['C-COUNT-prod'] = {ch: reduce(lambda a, b: a * b, (member_count(F, s) for s in ch), 1)
                            for ch in chains_top}

    # Cross-cumulant: c(σ_•) := sum_S subseteq chain (-1)^|chain \ S| * prod_{i in S} m_F(σ_i)
    # (a Mobius-style cumulant of the m_F values along the chain)
    def cumul(ch):
        out = 0
        L = len(ch)
        for k in range(L + 1):
            for combo in combinations(range(L), k):
                sgn = (-1) ** (L - k)
                p = reduce(lambda a, b: a * b, (m_F[ch[i]] for i in combo), 1)
                out += sgn * p
        return out
    coch['C-CUMUL'] = {ch: cumul(ch) for ch in chains_top}

    # ---- sgn-twisted F-natural candidates ----
    def sgn_chain(ch):
        return perm_sign(chain_permutation(ch, n))

    def inv_chain(ch):
        return perm_inv(chain_permutation(ch, n))

    coch['C-SGN-MOB-TOP']  = {ch: sgn_chain(ch) * m_F[ch[-1]] for ch in chains_top}
    coch['C-SGN-MOB-BOT']  = {ch: sgn_chain(ch) * m_F[ch[0]]  for ch in chains_top}
    coch['C-SGN-MOB-PROD'] = {ch: sgn_chain(ch) * reduce(lambda a, b: a * b, (m_F[s] for s in ch), 1)
                              for ch in chains_top}

    def sgn_def(ch):
        # value: sgn * (2 a_F(x_new) - |F|) where x_new is the FINAL element added
        # i.e., x_new = chain_permutation(ch, n)[n-2]
        # (this is the next-to-last element in the permutation, the one added
        # right before [n] gets formed; equivalently the new element in top \\ bot
        # along the last step from σ_{n-3} to σ_{n-2}, except for n=3 it's σ_0 -> σ_1)
        perm = chain_permutation(ch, n)
        # x_new = element added in last step = perm[n-2]
        x_new = perm[n - 2]
        return sgn_chain(ch) * (2 * element_count(F, x_new) - len(F))
    coch['C-SGN-DEFICIT'] = {ch: sgn_def(ch) for ch in chains_top}

    coch['C-SGN-COUNT'] = {ch: sgn_chain(ch) * member_count(F, ch[-1]) for ch in chains_top}

    coch['C-INV-MOB-TOP'] = {ch: inv_chain(ch) * m_F[ch[-1]] for ch in chains_top}

    return coch


# ==========================================================================
# 5.  Alternative hosts
# ==========================================================================
def suspended_punctured_boolean_chains(n):
    """Simplicial suspension Σ X of X = order-complex of punctured Boolean.
    Add two new vertices N (north pole), S (south pole) and join everything
    to each. The top-dim simplices are (P, c_0, ..., c_{n-2}) where P in
    {N, S} and (c_0, ..., c_{n-2}) is a top-dim chain of X. So top_dim = n-1.

    The suspension shifts cohomology: H^{n-1}(Σ X) ≅ H^{n-2}(X) ≅ sgn_{S_n}.
    """
    base_top = proper_boolean_chains(n)
    out = []
    for pole in ('N', 'S'):
        for ch in base_top:
            out.append((pole,) + ch)
    return out


def suspension_cob_columns(n):
    """Coboundary columns at top dim (n-1) of the suspension."""
    top = suspended_punctured_boolean_chains(n)
    idx_top = {tuple(c): i for i, c in enumerate(top)}

    # sub-dim = n-2 simplices: either a top chain (c_0, ..., c_{n-2}) of the
    # base (which is part of a top simplex via faces deleting the pole), or
    # a chain (P, c_0, ..., c_{n-3}) of length n-1 with a pole P.
    base_top = proper_boolean_chains(n)
    sub = list(base_top)  # face = top-chain without pole
    # also: (pole, sub-chain-of-base) where sub-chain is a (n-2)-chain
    verts = [s for s in all_subsets(n) if 0 < len(s) < n]
    base_sub = []
    def extend(prefix):
        if len(prefix) == n - 2:
            base_sub.append(tuple(prefix))
            return
        last = prefix[-1]
        for v in verts:
            if last < v:
                extend(prefix + [v])
    for v in verts:
        extend([v])
    for pole in ('N', 'S'):
        for sc in base_sub:
            sub.append((pole,) + sc)

    cols = []
    for s in sub:
        col = {}
        # find every top simplex sigma whose face deletion gives s
        for sigma in top:
            for i in range(len(sigma)):
                face = sigma[:i] + sigma[i+1:]
                if face == tuple(s):
                    col[idx_top[sigma]] = col.get(idx_top[sigma], 0) + ((-1) ** i)
        if col:
            cols.append(col)
    return top, cols


def build_cochains_suspension(F, n, top):
    """Lift the punctured-Boolean cochain candidates to the suspension by
    putting each base cochain on each pole-cone.
    """
    m_F = moebius_transform(F, n)

    def sgn_chain_full(ch):
        # the pole doesn't permute; just take sgn of the base chain
        base = ch[1:]
        return perm_sign(chain_permutation(base, n))

    out = {}
    out['C-SGN-MOB-TOP'] = {ch: sgn_chain_full(ch) * m_F[ch[-1]] for ch in top}
    out['C-SGN-MOB-PROD'] = {ch: sgn_chain_full(ch) * reduce(lambda a, b: a * b, (m_F[s] for s in ch[1:]), 1) for ch in top}
    out['C-MOB-TOP'] = {ch: m_F[ch[-1]] for ch in top}
    out['C-MOB-PROD'] = {ch: reduce(lambda a, b: a * b, (m_F[s] for s in ch[1:]), 1) for ch in top}
    return out


def sgn_project_cochain_suspension(cochain_dict, top, n):
    """Sgn-project the top-dim cochain on the suspension.  S_n acts on the
    base (subsets) and fixes the poles.
    """
    proj = {ch: 0 for ch in top}
    for sigma_perm in permutations(range(n)):
        sgn = perm_sign(sigma_perm)
        sigma_inv = [0] * n
        for i, s in enumerate(sigma_perm):
            sigma_inv[s] = i
        for ch in top:
            pole = ch[0]
            base = ch[1:]
            base_pre = tuple(frozenset(sigma_inv[x] for x in sset) for sset in base)
            ch_pre = (pole,) + base_pre
            proj[ch] += sgn * cochain_dict.get(ch_pre, 0)
    return proj


def count_graded_classes(F_star, n, chains_top):
    """HOST-COUNT-GRD: count-graded version where the coefficient at chain
    σ_• is the vector space ℚ[F_star ∩ σ_0] (members captured at bottom).

    For F_star a union-closed family, compute the bottom-twisted cochain
    complex.  We turn this into a "scalar" probe by picking the canonical
    sum-over-members cochain: c(σ_•) := sum_{A in F_star, A subseteq σ_0} 1
    = |F_star ∩ {S : S ⊆ σ_0}| = member_count(F_star, σ_0).

    This is the same scalar invariant as C-COUNT-BOT (which we test).
    But we ALSO test the "count-weighted product with sgn" which IS the
    sgn-twisted variant living in the count-graded host.
    """
    out = {}
    out['HOST-COUNT-GRD-bot'] = {ch: member_count(F_star, ch[0]) for ch in chains_top}
    out['HOST-COUNT-GRD-sgn-bot'] = {
        ch: perm_sign(chain_permutation(ch, n)) * member_count(F_star, ch[0]) for ch in chains_top
    }
    return out


# ==========================================================================
# 6.  Isotype tests under subgroups (A_n, S_{n-1})
# ==========================================================================
def isotype_project_subgroup(cochain_dict, chains_top, n, subgroup_perms, character):
    """Project onto the χ-isotype under a subgroup of S_n.

    (P c)(chain) = (1/|G|) sum_{σ in G} χ(σ) c(σ^{-1}.chain).
    character(σ) is ±1 (1-dim character of G).
    """
    proj = {ch: 0 for ch in chains_top}
    for sigma_perm in subgroup_perms:
        chi = character(sigma_perm)
        sigma_inv = [0] * n
        for i, s in enumerate(sigma_perm):
            sigma_inv[s] = i
        for ch in chains_top:
            ch_pre = tuple(frozenset(sigma_inv[x] for x in sset) for sset in ch)
            proj[ch] += chi * cochain_dict.get(ch_pre, 0)
    return proj


def alternating_group(n):
    return [p for p in permutations(range(n)) if perm_sign(p) == 1]


def stabilizer_of_n_minus_1(n):
    """S_{n-1} as the stabilizer of element n-1 in [n] = {0, ..., n-1}."""
    return [p for p in permutations(range(n)) if p[n - 1] == n - 1]


# ==========================================================================
# 7.  Main probe at n=3
# ==========================================================================
def probe_n(n):
    print(f"\n{'='*78}")
    print(f"PROBE n={n}  {el()}")
    print(f"{'='*78}")

    ground = frozenset(range(n))

    # Enumerate all union-closed families and pick out CE-shape
    uc = enumerate_union_closed(n)
    ce_shape_F = [F for F in uc if is_ce_shape(F, ground)]
    print(f"  union-closed families on [{n}] (size >= 2): {sum(1 for F in uc if len(F) >= 2)}")
    print(f"  CE-shape F-star candidates: {len(ce_shape_F)}")

    chains_top, cob_cols = coboundary_columns_punctured_boolean(n)
    print(f"  punctured-Boolean top-dim chains: {len(chains_top)}")
    print(f"  coboundary columns: {len(cob_cols)} (image rank in C^{n-2})")
    print(f"  rank(δ_{n-3}) = {rank2(cob_cols)} -> H^{n-2}(PB) ≅ Q (sgn_{{S_{n}}})")

    print(f"\n  -- Per-CE-shape-F cochain class table  (sgn_nz = 1 means cochain has non-zero sgn-class)")
    print(f"  {'F (CE-shape)':<50s}", end='')
    cochain_names = ['C-ENT-prod', 'C-LOG-prod', 'C-PAIR-DIFF', 'C-COUNT-prod', 'C-CUMUL',
                     'C-SGN-MOB-TOP', 'C-SGN-MOB-BOT', 'C-SGN-MOB-PROD',
                     'C-SGN-DEFICIT', 'C-SGN-COUNT', 'C-INV-MOB-TOP']
    short_names = {'C-ENT-prod': 'ENT', 'C-LOG-prod': 'LOG', 'C-PAIR-DIFF': 'PAIR',
                   'C-COUNT-prod': 'CNT', 'C-CUMUL': 'CML',
                   'C-SGN-MOB-TOP': 'S-MT', 'C-SGN-MOB-BOT': 'S-MB', 'C-SGN-MOB-PROD': 'S-MP',
                   'C-SGN-DEFICIT': 'S-D', 'C-SGN-COUNT': 'S-C', 'C-INV-MOB-TOP': 'I-MT'}
    for name in cochain_names:
        print(f" {short_names[name]:>4s}", end='')
    print()

    per_cochain_count = {name: 0 for name in cochain_names}
    per_cochain_sgn_count = {name: 0 for name in cochain_names}

    for F in ce_shape_F:
        coch = build_cochains(F, n, chains_top)
        print(f"  {show_fam(F):<50s}", end='')
        for name in cochain_names:
            c = coch[name]
            nz, _ = class_nonzero(c, chains_top, cob_cols)
            sgn_proj = sgn_project_cochain(c, chains_top, n)
            sgn_nz, _ = class_nonzero(sgn_proj, chains_top, cob_cols)
            print(f" {('1' if sgn_nz else '0')+('!' if nz and not sgn_nz else ''):>4s}", end='')
            if nz: per_cochain_count[name] += 1
            if sgn_nz: per_cochain_sgn_count[name] += 1
        print()

    print(f"\n  --- Aggregate (sgn-class non-zero count on CE-shape F⋆, n={n}) ---")
    for name in cochain_names:
        c = per_cochain_count[name]
        s = per_cochain_sgn_count[name]
        flavor = 'sgn-TWIST' if name.startswith('C-SGN') or name.startswith('C-INV') else 'strict   '
        verdict = 'WORKS' if s > 0 else 'fails'
        print(f"    {name:<18s} ({flavor}) : raw {c:2d}/{len(ce_shape_F)}, sgn-proj {s:2d}/{len(ce_shape_F)}  -> {verdict}")

    # ---- HOST-SUSP : suspension ----
    print(f"\n  --- HOST-SUSP-PB : simplicial suspension of punctured Boolean ---")
    susp_top, susp_cob = suspension_cob_columns(n)
    print(f"    suspension top-dim chains: {len(susp_top)}")
    print(f"    coboundary columns: {len(susp_cob)}")
    rk_susp = rank2(susp_cob)
    print(f"    rank(δ_{n-2}^susp) = {rk_susp}; H^{n-1}(susp) dim = {len(susp_top) - rk_susp}")

    susp_per_F = {}
    for F in ce_shape_F:
        cochains_susp = build_cochains_suspension(F, n, susp_top)
        susp_per_F[F] = {}
        for name, c in cochains_susp.items():
            nz, _ = class_nonzero(c, susp_top, susp_cob)
            sgn_proj = sgn_project_cochain_suspension(c, susp_top, n)
            sgn_nz, _ = class_nonzero(sgn_proj, susp_top, susp_cob)
            susp_per_F[F][name] = (nz, sgn_nz)

    print(f"    Per-F summary (raw / sgn-projection class non-zero):")
    susp_names = ['C-MOB-TOP', 'C-MOB-PROD', 'C-SGN-MOB-TOP', 'C-SGN-MOB-PROD']
    print(f"    {'F':<50s}", end='')
    for name in susp_names:
        print(f" {name[2:]:>14s}", end='')
    print()
    for F in ce_shape_F:
        print(f"    {show_fam(F):<50s}", end='')
        for name in susp_names:
            nz, sgn_nz = susp_per_F[F][name]
            print(f"   raw={('1' if nz else '0')} sgn={('1' if sgn_nz else '0')}", end='')
        print()

    # ---- HOST-COUNT-GRD : count-graded ----
    print(f"\n  --- HOST-COUNT-GRD : count-graded cochain on punctured Boolean ---")
    for F in ce_shape_F:
        co = count_graded_classes(F, n, chains_top)
        cg = co['HOST-COUNT-GRD-bot']
        cg_sgn = co['HOST-COUNT-GRD-sgn-bot']
        nz_raw, _ = class_nonzero(cg, chains_top, cob_cols)
        sgn_proj = sgn_project_cochain(cg, chains_top, n)
        sgn_raw_nz, _ = class_nonzero(sgn_proj, chains_top, cob_cols)
        nz_sgn, _ = class_nonzero(cg_sgn, chains_top, cob_cols)
        sgn_proj2 = sgn_project_cochain(cg_sgn, chains_top, n)
        sgn_twist_nz, _ = class_nonzero(sgn_proj2, chains_top, cob_cols)
        print(f"    {show_fam(F):<50s}   raw raw_nz={nz_raw} sgn={sgn_raw_nz}   "
              f"sgn-twist raw_nz={nz_sgn} sgn={sgn_twist_nz}")

    # ---- A_n equivariance ----
    print(f"\n  --- HOST-A_{n}-EQUIV : A_n-equivariant projection (alternating group) ---")
    A_n = alternating_group(n)
    print(f"    |A_{n}| = {len(A_n)}")
    # For A_n, sgn|_{A_n} = trivial.  But the natural character is trivial,
    # so the "alternating" isotype is the trivial isotype on A_n, which
    # IS a 1-dim invariant under A_n.  Use trivial character for projection.
    triv_char = lambda p: 1
    print(f"    Projecting LIFT-4-prod-style cochain c_F(chain) = ∏ m_F(σ_i) onto trivial-A_n isotype")
    for F in ce_shape_F:
        m_F = moebius_transform(F, n)
        c = {ch: reduce(lambda a, b: a * b, (m_F[s] for s in ch), 1) for ch in chains_top}
        # A_n trivial isotype projection: average over A_n
        proj = isotype_project_subgroup(c, chains_top, n, A_n, triv_char)
        nz, _ = class_nonzero(proj, chains_top, cob_cols)
        # also: is the A_n-trivial isotype class S_n-equivalent to a non-zero sgn class?
        # sgn-project A_n-projection
        sgn_after = sgn_project_cochain(proj, chains_top, n)
        sgn_nz, _ = class_nonzero(sgn_after, chains_top, cob_cols)
        print(f"    {show_fam(F):<50s}  A_n-triv raw={('1' if nz else '0')}  sgn after={('1' if sgn_nz else '0')}")

    # ---- structural diagnostic: compute the explicit scalar g_F for sgn-twist ----
    print(f"\n  --- Structural diagnostic: orbit-averaged Möbius (the underlying scalar) ---")
    for F in ce_shape_F:
        m_F = moebius_transform(F, n)
        # orbit-average over (n-1)-element subsets (top of chain)
        top_sets = [T for T in all_subsets(n) if len(T) == n - 1]
        g_top = sum(m_F[T] for T in top_sets)  # un-normalized
        bot_sets = [T for T in all_subsets(n) if len(T) == 1]
        g_bot = sum(m_F[T] for T in bot_sets)
        # avg-mid
        mid_sets = [T for T in all_subsets(n) if 1 < len(T) < n - 1]
        g_mid = sum(m_F[T] for T in mid_sets) if mid_sets else 0
        print(f"    {show_fam(F):<50s}  Σ_top m_F = {g_top:+d}  "
              f"Σ_bot m_F = {g_bot:+d}  Σ_mid m_F = {g_mid:+d}")


# ==========================================================================
# 8.  Run
# ==========================================================================
if __name__ == '__main__':
    print("=" * 78)
    print("Frankl-Alt-Cochain-Host-Probe  mg-1b24")
    print("=" * 78)

    probe_n(3)
    # n=4 deferred to a follow-on; per ticket gate, an n=3 working alternative
    # warrants an explicit n=4 follow-on filing.

    print(f"\n{'='*78}")
    print(f"TOTAL  {el()}")
    print(f"{'='*78}")
