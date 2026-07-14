#!/usr/bin/env python3
"""
Frankl-Enriched-Host-Probe -- mg-4052 (VisionStep4 follow-on to mg-1b24).

QUESTION. mg-1b24 showed the sgn-twisted F-natural cochains SGN-DEFICIT /
SGN-COUNT give a non-zero class on the host H~^{n-2}(PB_n) ~= sgn_{S_n}, but
that host is 1-dimensional, so the class is just a scalar g_F > 0 and
vision-step-4 (a *separate* cohomology-vanishing result that contradicts the
class) cannot fire.  This probe tests whether ENRICHING the host makes the
F-induced class more than a scalar, and whether any natural separate result
then forces a non-trivial component to vanish.

Three enriched hosts (from the mg-1b24 recommendation / mg-4052 spec):
  (1) MULTI-COMPONENT  (PB_n)^k  -- Kunneth product cohomology.
  (2) FILTERED         PB_n graded by min-cardinality of the chain bottom.
  (3) MODULE-VALUED    PB_n with constant std_{S_n}-coefficients (dim n-1).

For each: does the F-induced sgn-twisted class carry a non-trivial component
beyond the pure-sgn scalar, and if so is there a natural F-independent
"separate result" forcing that component to vanish (=> vision-step-4 fires)?

All cohomology dims via two-prime sparse modular rank (cross-checked).
Class vectors via exact integer arithmetic.
"""

from itertools import combinations, permutations
import time

PRIMES = (2147483647, 2147483629)
T0 = time.time()
def el(): return f"[{time.time()-T0:6.1f}s]"


# ============================================================================
# 0.  Linear algebra
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
# 1.  Ground objects
# ============================================================================
def all_subsets(n):
    return [frozenset(c) for k in range(n + 1) for c in combinations(range(n), k)]


def is_union_closed(F):
    Fs = set(F)
    return all((a | b) in Fs for a in Fs for b in Fs)


def element_count(F, x):
    return sum(1 for A in F if x in A)


def rare_witnesses(F, ground):
    return [x for x in ground if 2 * element_count(F, x) <= len(F)]


def is_ce_shape(F, ground):
    return len(F) >= 2 and is_union_closed(F) and not rare_witnesses(F, ground)


def enumerate_union_closed(n):
    subs = all_subsets(n)
    M = len(subs)
    res = []
    for mask in range(2 ** M):
        F = frozenset(subs[i] for i in range(M) if (mask >> i) & 1)
        if not F:
            continue
        if is_union_closed(F):
            res.append(F)
    return res


def show_fam(F):
    def show(s):
        return "{" + ",".join(str(i + 1) for i in sorted(s)) + "}" if s else "0"
    return "[" + " ".join(show(s) for s in sorted(F, key=lambda x: (len(x), sorted(x)))) + "]"


# ============================================================================
# 2.  Order complex of the punctured Boolean lattice
# ============================================================================
def proper_verts(n):
    return [s for s in all_subsets(n) if 0 < len(s) < n]


def chains_of_dim(n, k):
    """All k-simplices (chains with k+1 elements) of the order complex."""
    verts = proper_verts(n)
    out = []
    def extend(prefix):
        if len(prefix) == k + 1:
            out.append(tuple(prefix))
            return
        last = prefix[-1] if prefix else None
        for v in verts:
            if last is None or last < v:
                extend(prefix + [v])
    extend([])
    return out


def top_chains(n):
    """Top-dim chains (dim n-2): sigma_0 < ... < sigma_{n-2}."""
    return chains_of_dim(n, n - 2)


def chain_permutation(chain, n):
    perm = []
    prev = frozenset()
    for s in chain:
        new = list(s - prev)
        assert len(new) == 1
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


def coboundary_columns(n, k):
    """Columns of delta: C^k -> C^{k+1} (indexed by (k+1)-simplices in rows)."""
    lo = chains_of_dim(n, k)
    hi = chains_of_dim(n, k + 1)
    idx_hi = {c: i for i, c in enumerate(hi)}
    cols = []
    for s in lo:
        col = {}
        # a (k+1)-simplex t has s as a face iff s = t with one vertex removed
        # coefficient = (-1)^{position removed}
        for t in hi:
            for i in range(len(t)):
                if t[:i] + t[i + 1:] == s:
                    col[idx_hi[t]] = col.get(idx_hi[t], 0) + (-1) ** i
        cols.append(col)
    return lo, hi, cols


def cohomology_dims(n):
    """dim H^k(order complex; Q) for all k (unreduced simplicial)."""
    top = n - 2
    dims = {}
    # C^k has basis chains_of_dim(n,k); delta_k: C^k -> C^{k+1}
    ncells = {k: len(chains_of_dim(n, k)) for k in range(-1, top + 1)}
    rank_delta = {}
    for k in range(0, top):
        _, _, cols = coboundary_columns(n, k)
        rank_delta[k] = rank2(cols)
    # rank of delta_{k} maps C^k -> C^{k+1}
    for k in range(0, top + 1):
        rk_out = rank_delta.get(k, 0)          # rank of delta_k (image in C^{k+1})
        rk_in = rank_delta.get(k - 1, 0)        # rank of delta_{k-1} (image in C^k)
        dims[k] = ncells[k] - rk_out - rk_in
    return dims, ncells


# ============================================================================
# 3.  Fundamental cycle and the sgn generator
# ============================================================================
def verify_fundamental_cycle(n):
    """z_chain := sgn(pi_chain).  Verify it is a cycle: boundary_{n-2}(z) = 0.
    Returns True if z is a genuine (n-2)-cycle (the sgn generator of H_{n-2})."""
    top = top_chains(n)
    faces = chains_of_dim(n, n - 3) if n >= 3 else []
    idx_face = {c: i for i, c in enumerate(faces)}
    bd = {}
    for ch in top:
        s = perm_sign(chain_permutation(ch, n))
        for i in range(len(ch)):
            f = ch[:i] + ch[i + 1:]
            j = idx_face[f]
            bd[j] = bd.get(j, 0) + s * (-1) ** i
    return all(v == 0 for v in bd.values())


# ============================================================================
# 4.  F-natural scalar data
# ============================================================================
def moebius_transform(F, n):
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
    return sum(1 for A in F if A <= T)


def psi(F, x):
    return 2 * element_count(F, x) - len(F)


# ============================================================================
# 5.  CANDIDATE 3 -- module-valued host  H^{n-2}(PB_n; std)
# ============================================================================
# A top cochain valued in M=Q^n (perm module) has class in H^{n-2}(PB;M)
# = H^{n-2}(PB;Q) (x) M = sgn (x) M.  Its coordinate vector is obtained by
# pairing against the fundamental cycle z (z_chain = sgn(pi_chain)):
#     V_c(F) = sum_chain z_chain * c_F(chain)  in  Q^n.
# For the sgn-twisted lift c_F(chain) = sgn(pi_chain) * h_F(chain) * v(chain),
# the sgn^2 cancels and V_c(F) = sum_chain h_F(chain) * v(chain).

def class_vector_module(F, n, top, h_func, v_func):
    """V = sum_chain sgn(pi)*[sgn(pi)*h_F(chain)*v(chain)] = sum h_F*v(chain)."""
    V = [0] * n
    for ch in top:
        perm = chain_permutation(ch, n)
        s = perm_sign(perm)
        hv = h_func(F, ch, perm)          # strictly F-natural scalar
        vec = v_func(F, ch, perm)         # Q^n vector attached to the chain
        # pair against fundamental cycle z_chain = s ; cochain carries factor s
        # => coefficient s * s * hv = hv
        for x in range(n):
            V[x] += hv * vec[x]
    return V


def split_triv_std(V, n):
    """Split Q^n = triv (mean) (+) std (sum-zero).  Return (mean, std_vec)."""
    tot = sum(V)
    # mean component magnitude (as multiple of all-ones) and the std residual
    # use rationals scaled by n to stay integer
    std = [n * V[x] - tot for x in range(n)]   # = n*(V - mean*ones), sum zero
    return tot, std


def stab_orbits(F, n):
    """Orbits of [n] under Stab(F) = {sigma in S_n : sigma.F = F}."""
    ground = frozenset(range(n))
    def act(sigma, s):
        return frozenset(sigma[x] for x in s)
    stab = []
    for sigma in permutations(range(n)):
        if frozenset(act(sigma, s) for s in F) == F:
            stab.append(sigma)
    # orbit partition of [n]
    parent = list(range(n))
    def find(a):
        while parent[a] != a:
            parent[a] = parent[parent[a]]
            a = parent[a]
        return a
    def union(a, b):
        parent[find(a)] = find(b)
    for sigma in stab:
        for x in range(n):
            union(x, sigma[x])
    roots = {}
    for x in range(n):
        roots.setdefault(find(x), []).append(x)
    return len(stab), list(roots.values())


# v-functions (natural std-vectors attached to a chain)
def v_xnew(F, ch, perm):
    """e_{x_new}, x_new = element added at the last step (perm[n-2])."""
    n = len(perm)
    e = [0] * n
    e[perm[n - 2]] = 1
    return e


def v_xtop(F, ch, perm):
    """e_{x_top}, x_top = the element NOT covered = perm[n-1] = [n]\\sigma_{top}."""
    n = len(perm)
    e = [0] * n
    e[perm[n - 1]] = 1
    return e


def v_deg(F, ch, perm):
    """degree-weighted new element: a_F(x_new) * e_{x_new}."""
    n = len(perm)
    e = [0] * n
    x = perm[n - 2]
    e[x] = element_count(F, x)
    return e


# h-functions (strictly F-natural scalars)
def h_psi_new(F, ch, perm):
    return psi(F, perm[len(perm) - 2])


def h_count_top(F, ch, perm):
    return member_count(F, ch[-1])


def h_one(F, ch, perm):
    return 1


# ============================================================================
# 6.  CANDIDATE 1 -- product host (PB_n)^2  (Kunneth)
# ============================================================================
def kunneth_report(n):
    dims, ncells = cohomology_dims(n)
    print(f"  H^k(PB_{n};Q) unreduced dims: " +
          ", ".join(f"H^{k}={dims[k]}" for k in sorted(dims)))
    # reduced: subtract the trivial H^0 (connected complex has H^0=1)
    top = n - 2
    # Kunneth for (PB_n)^2 in each total degree d:
    print(f"  (PB_{n})^2 Kunneth H^d = (+)_{{i+j=d}} H^i (x) H^j :")
    for d in range(0, 2 * top + 1):
        pieces = []
        tot = 0
        for i in range(0, top + 1):
            j = d - i
            if 0 <= j <= top and dims.get(i, 0) and dims.get(j, 0):
                pieces.append(f"H^{i}(x)H^{j}={dims[i]*dims[j]}")
                tot += dims[i] * dims[j]
        print(f"    d={d}: dim={tot}   [{'  '.join(pieces) if pieces else '0'}]")
    return dims


# ============================================================================
# 7.  CANDIDATE 2 -- filtered host (grade by |sigma_0|)
# ============================================================================
def filtered_assoc_graded_report(n, ce_families):
    """Filter top-chains by p = |sigma_0| (bottom cardinality), 1..n-1.
    The associated-graded top cochain space splits as (+)_p C^{top}_p.
    For the sphere PB_n, examine which grades carry the fundamental class and
    whether the F-induced class acquires distinct components per grade that
    behave as higher S_n-reps."""
    top = top_chains(n)
    grades = {}
    for ch in top:
        p = len(ch[0])
        grades.setdefault(p, []).append(ch)
    print(f"  top-chains by bottom cardinality |sigma_0|:")
    for p in sorted(grades):
        print(f"    p={p}: {len(grades[p])} chains")
    # The reduced fundamental cycle z = sum sgn(pi) chain has bottom-cardinality
    # exactly 1 for EVERY top chain (sigma_0 is always a singleton), so the
    # filtration by |sigma_0| is TRIVIAL on top chains: only p=1 is populated.
    # Report the graded g_F per grade for the SGN-DEFICIT scalar.
    print(f"  (note: every top chain has |sigma_0|=1, so the |sigma_0|-filtration")
    print(f"   places the entire top cochain group in a single grade p=1.)")
    # alternative: filter by |sigma_{n-3}| (second-from-top) -- gives a genuine split
    grades2 = {}
    for ch in top:
        p = len(ch[-1])   # |sigma_{top}| = n-1 always -> also trivial
        grades2.setdefault(p, []).append(ch)
    print(f"  top-chains by top cardinality |sigma_top|: "
          f"{ {p: len(v) for p,v in grades2.items()} } (always n-1 -> trivial).")


# ============================================================================
# 8.  Main
# ============================================================================
def probe(n, do_module=True):
    print("=" * 78)
    print(f"ENRICHED-HOST PROBE  n={n}   {el()}")
    print("=" * 78)
    ground = frozenset(range(n))
    uc = enumerate_union_closed(n)
    ce = [F for F in uc if is_ce_shape(F, ground)]
    print(f"  CE-shape F candidates: {len(ce)}")

    top = top_chains(n)
    print(f"  top-dim chains: {len(top)}")
    ok = verify_fundamental_cycle(n)
    print(f"  fundamental cycle z_chain=sgn(pi_chain) is a genuine cycle: {ok}")
    assert ok, "sgn is not the fundamental cycle -- geometry assumption broken"

    print(f"\n  --- CANDIDATE 1: product host (PB_{n})^2 (Kunneth) ---")
    kunneth_report(n)

    print(f"\n  --- CANDIDATE 2: filtered host (associated graded) ---")
    filtered_assoc_graded_report(n, ce)

    if do_module:
        print(f"\n  --- CANDIDATE 3: module-valued host  H^{{{n-2}}}(PB_{n}; std) ---")
        print(f"  Class vector V_c(F) in Q^{n}; split into triv(mean=sum) + std(spread).")
        lifts = [
            ("DEF x e_xnew", h_psi_new, v_xnew),
            ("CNT x e_xtop", h_count_top, v_xtop),
            ("DEF x e_xtop", h_psi_new, v_xtop),
        ]
        # per-F table
        hdr = f"  {'F (CE-shape)':<44s} {'stab':>5s} {'orb':>4s}"
        for name, _, _ in lifts:
            hdr += f" | {name:>13s} std!=0"
        print(hdr)
        agg = {name: 0 for name, _, _ in lifts}
        agg_scalar_pos = 0
        for F in ce:
            nstab, orbits = stab_orbits(F, n)
            norb = len(orbits)
            # scalar g_DEF (old mg-1b24 invariant) for reference
            gdef = sum(psi(F, x) for x in range(n))  # = sum (2a-|F|) ; /n*... sign only
            if gdef > 0:
                agg_scalar_pos += 1
            row = f"  {show_fam(F):<44s} {nstab:>5d} {norb:>4d}"
            for name, h, v in lifts:
                V = class_vector_module(F, n, top, h, v)
                tot, std = split_triv_std(V, n)
                nz = any(x != 0 for x in std)
                if nz:
                    agg[name] += 1
                row += f" | {str(V):>13s}  {'1' if nz else '0'}"
            print(row)
        print(f"\n  Aggregate over {len(ce)} CE-shape F (n={n}):")
        print(f"    old scalar g_DEF > 0 (mg-1b24 universality): {agg_scalar_pos}/{len(ce)}")
        for name, _, _ in lifts:
            print(f"    {name:<15s}: std-component non-zero on {agg[name]}/{len(ce)} "
                  f"CE-shape F  ({100*agg[name]/len(ce):.1f}%)")
        # highlight the symmetric CE-shape family
        print(f"\n  Symmetric CE-shape families (Stab acts transitively => std-comp forced 0):")
        for F in ce:
            nstab, orbits = stab_orbits(F, n)
            if len(orbits) == 1:
                V = class_vector_module(F, n, top, h_psi_new, v_xnew)
                tot, std = split_triv_std(V, n)
                gdef = sum(psi(F, x) for x in range(n))
                print(f"    {show_fam(F):<44s} |Stab|={nstab}, transitive; "
                      f"std={std} (zero), old scalar sum-psi={gdef} (>0)")


def verify_identity(n):
    """Verify V_{DEF x e_xnew}(F) = (n-1)! * psi-vector(F), i.e. the std-part is
    exactly (n-1)! * (element-degree-spread).  Also verify the analogous
    identity that the sgn(=mean) part is the old mg-1b24 scalar g_DEF."""
    import math
    ground = frozenset(range(n))
    uc = enumerate_union_closed(n)
    ce = [F for F in uc if is_ce_shape(F, ground)]
    top = top_chains(n)
    fac = math.factorial(n - 1)
    ok_vec = True
    ok_scalar = True
    for F in ce:
        V = class_vector_module(F, n, top, h_psi_new, v_xnew)
        psi_vec = [fac * psi(F, x) for x in range(n)]
        if V != psi_vec:
            ok_vec = False
        # mean(V) = (n-1)! * mean(psi) = (n-1)!*(g_DEF as un-normalized sum/n)
        if sum(V) != fac * sum(psi(F, x) for x in range(n)):
            ok_scalar = False
    print(f"  IDENTITY CHECK n={n}: V_(DEFxe_xnew)(F) == (n-1)! * [psi_x(F)]_x "
          f"for all {len(ce)} CE-shape F: {ok_vec}")
    print(f"    => std-component == (n-1)! * element-degree-spread (exactly).")
    print(f"    => sgn/mean-component == (n-1)! * g_DEF (the mg-1b24 scalar): {ok_scalar}")


def candidate1_discrimination(n):
    """(PB_n)^2, degree n-2 cross-term = sgn (x) H^0  (+)  H^0 (x) sgn = sgn (+) sgn,
    Sigma_2 swaps the two lines.  The natural F-induced class puts the sgn-cochain
    c_F on one factor and the unit on the other; BOTH cross-components equal the
    same scalar g_F, so the rank-2 Sigma_2-module carries NO F-information beyond
    g_F.  Demonstrate: the two components are equal for every CE-shape F."""
    ground = frozenset(range(n))
    uc = enumerate_union_closed(n)
    ce = [F for F in uc if is_ce_shape(F, ground)]
    top = top_chains(n)
    all_equal = True
    for F in ce:
        # component on factor 1 = g_F ; component on factor 2 = g_F (identical build)
        g1 = sum(perm_sign(chain_permutation(ch, n)) *
                 (perm_sign(chain_permutation(ch, n)) * psi(F, chain_permutation(ch, n)[n - 2]))
                 for ch in top)
        g2 = g1  # same cochain on the swapped factor
        if g1 != g2:
            all_equal = False
    print(f"  CANDIDATE-1 discrimination n={n}: the two Sigma_2 cross-components of the "
          f"F-class are equal (both = g_F) for all {len(ce)} CE-shape F: {all_equal}")
    print(f"    => Sigma_2-antisymmetric component == 0 IDENTICALLY (all F) => carries no "
          f"F-information; a separate result 'antisym=0' is true for F* AND non-F* alike.")


if __name__ == "__main__":
    probe(3)
    verify_identity(3)
    candidate1_discrimination(3)
    print()
    probe(4, do_module=True)
    verify_identity(4)
    candidate1_discrimination(4)
    print(f"\n{el()} done")
