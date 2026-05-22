#!/usr/bin/env python3
"""
Frankl-Spherical-Reconcile : bounded n=3 probe for tweaked category-level
cohomology of the category of intersection-closed families.

Work item mg-7bf3.  Per a Daniel reminder 2026-05-22 ("I thought we already
proved that the cohomology of the category of intersection-closed families
on n elements was spherical.  If not perhaps there was a slight tweak in
the definition.").  This probe tests Daniel's instinct DIRECTLY.

CONTEXT.  Three structural collapses have refuted the Frankl cohomological
route as built:
  * UC10 / Phase 1.5  -- the against-trace structure map of the
    contravariant hocolim does not exist (mg-0405).
  * Fork D (mg-565a)  -- the Moore-family lattice's bare nerve cohomology
    is rationally acyclic at n=2, n=3 (under both empty-set conventions).
  * Fork A (mg-f9a7)  -- the covariant hocolim over C_n collapses onto the
    terminal object (emptyset, {emptyset}), again ACYCLIC.
The PER-FAMILY object 2^[n] \ {0,[n]} IS spherical (= S^{n-2}, UC9 D-4),
and Delta(PPF_n) IS spherical (= S^{n-2}, F17/F18) -- but neither is the
category of intersection-closed families.

THE TWEAK probed here :  the homotopy LIMIT  holim_{C_n} X  -- flagged
by mg-f9a7 (rec 4) and rem:holim-prereq of refoundation.tex as the
candidate that does NOT suffer the terminal-object collapse (the
inclusion {t} -> C_n is homotopy FINAL, not homotopy INITIAL, so
holim is NOT forced onto X(t)).  Other tweaks tested for completeness :
  (B) hocolim restricted to the terminal-excluded subcategory |S|>=1, |S|>=2
      -- mg-f9a7 noted H^2 = 59 (|S|>=1) and H^1 = 133 (|S|>=2) ;
  (C) holim on the same terminal-excluded subcategories.

For each candidate the probe answers : is the cohomology SPHERICAL
(one-dimensional, concentrated in the n-2 = 1 or n-1 = 2 degree, sgn_S3
isotype), or NON-TRIVIAL but non-spherical, or ACYCLIC ?

All ranks via sparse modular Gaussian elimination, cross-checked at two
~2^31 primes ; no dependencies ; D^2 = 0 verified explicitly on every
holim total complex computed.  Reproducible.
"""

from itertools import combinations
import sys, time

PRIMES = (2147483647, 2147483629)
T0 = time.time()
def el(): return f"[{time.time()-T0:6.1f}s]"


# ==========================================================================
# 0.  Linear algebra
# ==========================================================================
def sparse_rank(columns, p):
    rank = 0
    pivots = {}
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


def cohomology(dims, diff):
    ranks = {m: rank2(cols) for m, cols in diff.items()}
    H = {}
    for m in dims:
        H[m] = dims[m] - ranks.get(m, 0) - ranks.get(m - 1, 0)
    return H, ranks


# ==========================================================================
# 1.  The Fork A objects (def:category, def:xf) -- ported from mg-f9a7
# ==========================================================================
def is_int_closed(F):
    Fs = set(F)
    return all((a & b) in Fs for a in Fs for b in Fs)


def moore_families(S):
    subs = [frozenset(c) for k in range(len(S) + 1) for c in combinations(sorted(S), k)]
    others = [s for s in subs if s != S]
    res = []
    for r in range(len(others) + 1):
        for combo in combinations(others, r):
            F = frozenset(combo) | {S}
            if is_int_closed(F):
                res.append(F)
    return res


def defect_cells(F):
    Fs = set(F)
    S = frozenset().union(*F) if F else frozenset()
    cells = {}
    for A in F:
        rest = sorted(S - A)
        for k in range(len(rest) + 1):
            for Tp in combinations(rest, k):
                Tp = frozenset(Tp)
                ok = all((A | frozenset(tt)) in Fs
                         for j in range(len(Tp) + 1)
                         for tt in combinations(sorted(Tp), j))
                if ok:
                    cells.setdefault(k, []).append((A, Tp))
    return cells


def cubical_boundary(cell):
    A, Tp = cell
    ts = sorted(Tp)
    out = []
    for i, t in enumerate(ts):
        rest = frozenset(Tp - {t})
        out.append(((A | {t}, rest), (-1) ** i))
        out.append(((A, rest), -((-1) ** i)))
    return out


def trace(F, T):
    return frozenset(frozenset(A & T) for A in F)


def build_category(n, min_ground=0):
    objs = []
    for k in range(min_ground, n + 1):
        for Sc in combinations(range(n), k):
            S = frozenset(Sc)
            for F in moore_families(S):
                objs.append((S, F))
    index = {o: i for i, o in enumerate(objs)}
    return objs, index


def decreasing_chains(S):
    out = []
    def rec(prefix):
        out.append(tuple(prefix))
        last = prefix[-1]
        smaller = [frozenset(c) for k in range(len(last))
                   for c in combinations(sorted(last), k)]
        for s in smaller:
            rec(prefix + [s])
    rec([S])
    return out


# --------------------------------------------------------------------------
# per-family cubical d^q (coboundary on X(F))
# --------------------------------------------------------------------------
def per_family_coboundary(fam_cells):
    """Given fam_cells[F][q] = list of q-cells, return
    dco[F][q] = list (per q-cell) of {(q+1)-cell-index: coeff}, the
    columns of d^q : C^q(X(F)) -> C^{q+1}(X(F))."""
    dco = {}
    for F, cells in fam_cells.items():
        maxq = max(cells) if cells else -1
        per = {}
        for q in range(maxq + 1):
            cols = [dict() for _ in cells.get(q, [])]
            qidx = {c: i for i, c in enumerate(cells.get(q, []))}
            for j, c2 in enumerate(cells.get(q + 1, [])):
                for face, coeff in cubical_boundary(c2):
                    if face in qidx:
                        fi = qidx[face]
                        cols[fi][j] = cols[fi].get(j, 0) + coeff
            per[q] = {i: {k: v for k, v in cols[i].items() if v}
                      for i in range(len(cols))}
        dco[F] = per
    return dco


# ==========================================================================
# 2.  The TWEAK : holim_{C_n} X -- the homotopy limit.
#
#  The cosimplicial replacement of the COVARIANT functor X over C_n is
#     Pi^p   =   prod_{c_0 -> c_1 -> ... -> c_p}  X(c_p),
#  i.e. value at the LAST object of each chain.  Codifferential
#     (delta phi)(c_0 -> ... -> c_{p+1})
#        = sum_{i=0}^{p+1}  (-1)^i  (delta^i phi)(c_0 -> ...) ,
#  where for 0 <= i <= p the i-th coface drops c_i (last unchanged) and
#  for i = p+1 it drops c_{p+1} and pushes the value via the structure
#  map X(c_p -> c_{p+1}) : X(c_p) -> X(c_{p+1}).  The structure map of
#  Fork A is the trace projection pi_T : X(F) -> X(F|_T) (def:bk
#  /  thm:projection of refoundation.tex), which on cells acts as
#     C(A, T')  |-->  C(A cap T, T')   if T' subset T,   else 0.
#
#  Total complex :   Tot^m = +/+_{p+q=m, chains}  C^q(X(F_last)) ,
#  total differential   D = d_vert + (-1)^q delta_horiz ;   D^2 = 0
#  because both d_vert (cubical coboundary on X(F_last)) and delta_horiz
#  (cosimplicial codifferential) square to zero, and they commute since
#  pi is a chain map.
# ==========================================================================
# ==========================================================================
# 2'.  The clean object : H^*(C_n; M) where M = pi_0(X) is the
#      connected-components functor F |-> Q^{pi_0 X(F)}.
#
# X(F) is homotopy-discrete at n<=4 (mg-f9a7 PART 1: H~^* of X(F) lives
# entirely in H~^0).  So the Bousfield-Kan spectral sequence computing
# cohomology of holim_{C_n} X collapses onto the q=0 row:
#         H^p(holim_{C_n} X)  =  lim^p_{C_n} (H_0 X)  =  H^p(C_n; M)
# where M(F) = pi_0(X(F)) is the components functor on C_n (covariant
# via pi_T).  This is THE clean category-level cohomology of the
# category of intersection-closed families with non-trivial coefficients.
#
# Compute it directly from the cobar complex
#        C^p(C_n; M)  =  +/+_{p-chains F_0 > ... > F_p}  M(F_p)
# with codifferential
#        (delta phi)(F_0 > ... > F_{p+1})  =  sum_{i=0}^{p+1} (-1)^i [...]
# where for i = p+1 (last face) we push via pi : M(F_p) -> M(F_{p+1}),
# and for i < p+1 (identity faces) the value is unchanged.
# ==========================================================================
def components_of(F):
    """Connected components of family F under the graph A ~ A xor {t} if both
    A and A xor {t} in F.  Returns dict A -> component_id (int, 0-based)."""
    Fl = list(F)
    parent = {A: A for A in Fl}

    def find(A):
        while parent[A] != A:
            parent[A] = parent[parent[A]]
            A = parent[A]
        return A

    def union(A, B):
        ra, rb = find(A), find(B)
        if ra != rb:
            parent[ra] = rb

    Fs = set(Fl)
    S = frozenset().union(*F) if F else frozenset()
    for A in Fl:
        for t in S:
            B = A ^ frozenset({t})
            if B in Fs:
                union(A, B)
    reps = {}
    cid = {}
    for A in Fl:
        r = find(A)
        if r not in reps:
            reps[r] = len(reps)
        cid[A] = reps[r]
    return cid, len(reps)


def H_star_C_n_M_cohomology(n, verbose=True, min_ground=0):
    """H^*(C_n; M) where M = pi_0(X) is the components functor.
    Computed directly from the cobar complex value-at-LAST."""
    objs, index = build_category(n, min_ground)
    if verbose:
        tag = f" (|S|>={min_ground})" if min_ground else ""
        print(f"{el()}  H^*(C_{n}{tag}; pi_0(X)) -- {len(objs)} objects")

    # per-family components
    fam_components = {}    # F -> (cid_map A->idx, n_components)
    for (S, F) in objs:
        if F not in fam_components:
            fam_components[F] = components_of(F)

    # per-family component dim
    fam_dim = {F: c[1] for F, c in fam_components.items()}

    # strict chains
    chains_by_len, chain_list = {}, []
    for (S0, F0) in objs:
        for gseq in decreasing_chains(S0):
            if len(gseq[-1]) < min_ground:
                continue
            objseq = tuple(index[(Si, trace(F0, Si))] for Si in gseq)
            chain_list.append(objseq)
            chains_by_len.setdefault(len(objseq) - 1, []).append(objseq)
    if verbose:
        print(f"{el()}  chains: " +
              ", ".join(f"len{L}:{len(chains_by_len.get(L,[]))}"
                        for L in sorted(chains_by_len)))

    # parents
    parents = {}
    for L in sorted(chains_by_len):
        if L == 0:
            continue
        for ch in chains_by_len[L]:
            for j in range(len(ch)):
                parents.setdefault(ch[:j] + ch[j + 1:], []).append((ch, j))

    # cobar basis : (chain, component k of F_last)
    cb_basis, cb_index = {}, {}
    for ch in chain_list:
        Flast = objs[ch[-1]][1]
        p = len(ch) - 1
        for k in range(fam_dim[Flast]):
            cb_basis.setdefault(p, []).append((ch, k))
    for p in cb_basis:
        for i, b in enumerate(cb_basis[p]):
            cb_index[b] = i
    dims = {p: len(cb_basis[p]) for p in cb_basis}
    if verbose:
        print(f"{el()}  cobar dims: " +
              ", ".join(f"C^{p}:{dims[p]}" for p in sorted(dims)) +
              f"   (total {sum(dims.values())})")

    # codifferential delta
    diff = {}
    for p in sorted(dims):
        cols = []
        for (ch, k) in cb_basis[p]:
            Flast = objs[ch[-1]][1]
            cid_last, _ = fam_components[Flast]
            col = {}
            for (par, j) in parents.get(ch, []):
                js = (-1) ** j
                if j == len(par) - 1:
                    # push pi : M(F_p) -> M(F_{p+1})
                    Snew = objs[par[-1]][0]
                    Fnew = objs[par[-1]][1]
                    cid_new, _ = fam_components[Fnew]
                    # component k of F_last is represented by any A with
                    # cid_last[A] = k ;  pi sends A to A cap Snew which
                    # lies in F_new, whose component is cid_new[A cap Snew].
                    rep_A = None
                    for A, kid in cid_last.items():
                        if kid == k:
                            rep_A = A
                            break
                    image_A = frozenset(rep_A & Snew)
                    k_new = cid_new[image_A]
                    r = cb_index[(par, k_new)]
                    col[r] = col.get(r, 0) + js
                else:
                    # identity face : component k stays
                    r = cb_index[(par, k)]
                    col[r] = col.get(r, 0) + js
            cols.append({r: v for r, v in col.items() if v})
        diff[p] = cols

    # delta^2 = 0 self-test
    for p in sorted(dims):
        if (p + 1) not in diff:
            continue
        for col in diff[p]:
            acc = {}
            for r, v in col.items():
                for r2, v2 in diff[p + 1][r].items():
                    acc[r2] = acc.get(r2, 0) + v * v2
            assert all(v == 0 for v in acc.values()), \
                f"H^*(C_n; M) delta^2 != 0 at p={p} -- bug"

    H, ranks = cohomology(dims, diff)
    if verbose:
        print(f"{el()}  delta^2 = 0 verified on the cobar complex.")
    return {'H': H, 'dims': dims, 'diff': diff,
            'objs': objs, 'index': index, 'chain_list': chain_list,
            'cb_basis': cb_basis, 'cb_index': cb_index,
            'fam_components': fam_components, 'fam_dim': fam_dim}


# ==========================================================================
# 2''.  Tweak (D): H^*(Moore-family lattice ; pi_0(X))
#       i.e. UNDO drift A (inclusion morphisms instead of traces),
#       KEEP the coefficient diagram pi_0(X) that mg-565a vindicated.
# ==========================================================================
def hopf_trace_lattice_M(g, fams, fam_components, cb_basis):
    """Hopf trace for the Moore-lattice cobar of M=pi_0(X)."""
    def gF(F):
        return frozenset(frozenset(g[i] for i in A) for A in F)
    gfam = {F: gF(F) for F in fams}
    V = 0
    for p, basis in cb_basis.items():
        tr = 0
        for (ch, k) in basis:
            if all(gfam[F] == F for F in ch):
                Flast = ch[-1]
                cid, _ = fam_components[Flast]
                rep_A = next(A for A, kid in cid.items() if kid == k)
                gA = frozenset(g[i] for i in rep_A)
                if cid.get(gA, -1) == k:
                    tr += 1
        V += ((-1) ** p) * tr
    return V


def H_star_Moore_lattice_M_cohomology(n, verbose=True, drop_top=False, drop_bot=False,
                                        return_basis=False):
    """H^*(Moore-lattice on [n] ; M) with M = pi_0(X) covariant via inclusion
    F subset G  =>  pi_0(X(F)) -> pi_0(X(G)) (surjective : components merge).

    drop_top/drop_bot : optionally exclude top {2^[n]} and/or bottom {[n]}
    elements to get the puncture/proper-part variants (the mg-565a analog
    for the lattice's nerve)."""
    S = frozenset(range(n))
    fams = moore_families(S)
    bot = min(fams, key=len)
    top = max(fams, key=len)
    fams = [F for F in fams
            if not (drop_top and F == top) and not (drop_bot and F == bot)]
    if verbose:
        suffix = ""
        if drop_top and drop_bot:
            suffix = " (proper part: top and bot dropped)"
        elif drop_top:
            suffix = " (top dropped)"
        elif drop_bot:
            suffix = " (bot dropped)"
        print(f"{el()}  H^*(Moore-lattice [{n}]{suffix} ; pi_0(X)) -- {len(fams)} objects")

    # per-family components
    fam_components = {}
    for F in fams:
        if F not in fam_components:
            fam_components[F] = components_of(F)
    fam_dim = {F: c[1] for F, c in fam_components.items()}

    # strict inclusion chains (F_0 subset F_1 subset ... subset F_p strict)
    # Enumerate as ascending chains.  Use DFS.
    fams_set = set(fams)
    chain_list = []
    def rec(prefix):
        chain_list.append(tuple(prefix))
        last = prefix[-1]
        for G in fams:
            if last < G and G != last:
                # ensure strict ascending and avoid duplicates by requiring G
                # comes "after" in the canonical enumeration
                if all(prefix[i] != G for i in range(len(prefix))):
                    rec(prefix + [G])
    for F in fams:
        rec([F])
    chains_by_len = {}
    for ch in chain_list:
        chains_by_len.setdefault(len(ch) - 1, []).append(ch)
    if verbose:
        print(f"{el()}  chains: " +
              ", ".join(f"len{L}:{len(chains_by_len.get(L,[]))}"
                        for L in sorted(chains_by_len)))

    # parents
    parents = {}
    for L in sorted(chains_by_len):
        if L == 0:
            continue
        for ch in chains_by_len[L]:
            for j in range(len(ch)):
                parents.setdefault(ch[:j] + ch[j + 1:], []).append((ch, j))

    # cobar basis : (chain, component k of F_last)
    cb_basis, cb_index = {}, {}
    for ch in chain_list:
        Flast = ch[-1]
        p = len(ch) - 1
        for k in range(fam_dim[Flast]):
            cb_basis.setdefault(p, []).append((ch, k))
    for p in cb_basis:
        for i, b in enumerate(cb_basis[p]):
            cb_index[b] = i
    dims = {p: len(cb_basis[p]) for p in cb_basis}
    if verbose:
        print(f"{el()}  cobar dims: " +
              ", ".join(f"C^{p}:{dims[p]}" for p in sorted(dims)) +
              f"   (total {sum(dims.values())})")

    # codifferential : push via inclusion pi : F_p subset F_{p+1} surj on pi_0
    diff = {}
    for p in sorted(dims):
        cols = []
        for (ch, k) in cb_basis[p]:
            Flast = ch[-1]
            cid_last, _ = fam_components[Flast]
            col = {}
            for (par, j) in parents.get(ch, []):
                js = (-1) ** j
                if j == len(par) - 1:
                    # push pi : M(Flast) -> M(Fnew) via F_last subset F_new
                    Fnew = par[-1]
                    cid_new, _ = fam_components[Fnew]
                    rep_A = next(A for A, kid in cid_last.items() if kid == k)
                    # rep_A in Flast, also in Fnew (since Flast subset Fnew)
                    k_new = cid_new[rep_A]
                    r = cb_index[(par, k_new)]
                    col[r] = col.get(r, 0) + js
                else:
                    r = cb_index[(par, k)]
                    col[r] = col.get(r, 0) + js
            cols.append({r: v for r, v in col.items() if v})
        diff[p] = cols

    # delta^2 = 0
    for p in sorted(dims):
        if (p + 1) not in diff:
            continue
        for col in diff[p]:
            acc = {}
            for r, v in col.items():
                for r2, v2 in diff[p + 1][r].items():
                    acc[r2] = acc.get(r2, 0) + v * v2
            assert all(v == 0 for v in acc.values()), \
                f"Moore lattice cobar delta^2 != 0 at p={p}"

    H, _ = cohomology(dims, diff)
    if verbose:
        print(f"{el()}  delta^2 = 0 verified.")
    if return_basis:
        return {'H': H, 'dims': dims, 'cb_basis': cb_basis,
                'fams': fams, 'fam_components': fam_components}
    return {'H': H, 'dims': dims}


def hopf_trace_M(g, objs, index, cb_basis, fam_components):
    """V(g) = sum_p (-1)^p tr(g | C^p) for the cobar of M=pi_0(X).
    g acts on components by permuting the underlying ground set."""
    def gSF(SF):
        S, F = SF
        return (frozenset(g[i] for i in S),
                frozenset(frozenset(g[i] for i in A) for A in F))

    gobj = {}
    for o in objs:
        go = gSF(o)
        gobj[index[o]] = index.get(go, -1)

    V = 0
    for p, basis in cb_basis.items():
        tr = 0
        for (ch, k) in basis:
            if all(gobj[oid] == oid for oid in ch):
                Flast = objs[ch[-1]][1]
                cid, _ = fam_components[Flast]
                # find a rep A of component k in Flast
                rep_A = None
                for A, kid in cid.items():
                    if kid == k:
                        rep_A = A
                        break
                gA = frozenset(g[i] for i in rep_A)
                # g preserves the component k iff cid[gA] = k
                if cid.get(gA, -1) == k:
                    tr += 1
        V += ((-1) ** p) * tr
    return V


def _disabled_chain_bicomplex_holim_cohomology(n, verbose=True, dim_cap=None, min_ground=0, variant="C_n"):
    """Cohomology of  holim_{C_n} X  via the cosimplicial BK replacement.

    variant = "C_n"     : the full trace category as in mg-f9a7,
              "puncture": full subcategory on objects with |S| >= min_ground."""
    objs, index = build_category(n, min_ground)
    if verbose:
        tag = f" (|S|>={min_ground})" if min_ground else ""
        print(f"{el()}  holim probe on C_{n}{tag}: {len(objs)} objects")

    # per-family cells and cubical coboundary d
    fam_cells = {}
    for (S, F) in objs:
        if F not in fam_cells:
            fam_cells[F] = defect_cells(F)
    dco = per_family_coboundary(fam_cells)

    # all strict chains
    chains_by_len, chain_list = {}, []
    for (S0, F0) in objs:
        for gseq in decreasing_chains(S0):
            if len(gseq[-1]) < min_ground:
                continue
            objseq = tuple(index[(Si, trace(F0, Si))] for Si in gseq)
            chain_list.append(objseq)
            chains_by_len.setdefault(len(objseq) - 1, []).append(objseq)
    if verbose:
        print(f"{el()}  chains: " +
              ", ".join(f"len{L}:{len(chains_by_len.get(L,[]))}"
                        for L in sorted(chains_by_len)))

    # parents[face_chain] = list of (parent_chain, j)  with d_j(parent) = face
    parents = {}
    for L in sorted(chains_by_len):
        if L == 0:
            continue
        for ch in chains_by_len[L]:
            for j in range(len(ch)):
                parents.setdefault(ch[:j] + ch[j + 1:], []).append((ch, j))

    # ------ Tot basis : (chain, cell), cell in X(F_last) ----------------
    tot_basis, tot_index = {}, {}
    for ch in chain_list:
        Flast = objs[ch[-1]][1]
        p = len(ch) - 1
        for q, qcells in fam_cells[Flast].items():
            for c in qcells:
                tot_basis.setdefault(p + q, []).append((ch, c))
    for m in tot_basis:
        for i, b in enumerate(tot_basis[m]):
            tot_index[b] = i
    dims = {m: len(tot_basis[m]) for m in tot_basis}
    total = sum(dims.values())
    if verbose:
        print(f"{el()}  Tot dims: " +
              ", ".join(f"m{m}:{dims[m]}" for m in sorted(dims)) +
              f"   (total {total})")
    if dim_cap is not None and total > dim_cap:
        return {'skipped': True, 'total': total}

    # ------ total differential D = d_vert + (-1)^q delta_horiz -----------
    def pullback_cell(c, T):
        A, Tp = c
        return (frozenset(A & T), Tp) if Tp <= T else None

    diff = {}
    for m in sorted(dims):
        cols = []
        for (ch, c) in tot_basis[m]:
            Flast = objs[ch[-1]][1]
            q = len(c[1])
            p = len(ch) - 1
            col = {}

            # (1) vertical d : same chain, cubical d on X(F_last)
            qidx = {cc: i for i, cc in enumerate(fam_cells[Flast].get(q, []))}
            for c2j, coeff in dco[Flast][q][qidx[c]].items():
                c2 = fam_cells[Flast][q + 1][c2j]
                key = tot_index[(ch, c2)]
                col[key] = col.get(key, 0) + coeff

            # (2) horizontal (-1)^q delta : the cosimplicial codifferential
            sgn = (-1) ** q
            for (par, j) in parents.get(ch, []):
                js = (-1) ** j
                if j == len(par) - 1:
                    # delta^{p+1}: ch = par[:-1], push c via pi to X(par[-1])
                    Slast_par = objs[par[-1]][0]
                    pc = pullback_cell(c, Slast_par)
                    if pc is not None:
                        r = tot_index[(par, pc)]
                        col[r] = col.get(r, 0) + sgn * js
                else:
                    # delta^i with i < p+1 : last object unchanged, cell stays
                    r = tot_index[(par, c)]
                    col[r] = col.get(r, 0) + sgn * js

            cols.append({r: v for r, v in col.items() if v})
        diff[m] = cols

    # D^2 = 0 self-test
    for m in sorted(dims):
        if (m + 1) not in diff:
            continue
        for ic, col in enumerate(diff[m]):
            acc = {}
            for r, v in col.items():
                for r2, v2 in diff[m + 1][r].items():
                    acc[r2] = acc.get(r2, 0) + v * v2
            bad = {r: v for r, v in acc.items() if v}
            if bad:
                b = tot_basis[m][ic]
                ch_b, c_b = b
                ch_human = [objs[oid] for oid in ch_b]
                ch_str = " > ".join(
                    f"({sorted(S)},|F|={len(F)})" for (S, F) in ch_human)
                A, Tp = c_b
                print(f"D^2 != 0 source: chain[{ch_str}], cell=(A={sorted(A)},T'={sorted(Tp)})")
                for r, v in list(bad.items())[:5]:
                    b2 = tot_basis[m + 2][r]
                    ch2, c2 = b2
                    ch2h = [objs[oid] for oid in ch2]
                    ch2_str = " > ".join(
                        f"({sorted(S)},|F|={len(F)})" for (S, F) in ch2h)
                    print(f"   target chain[{ch2_str}], cell=({sorted(c2[0])},{sorted(c2[1])}): coeff {v}")
                assert False, f"holim D^2 != 0 at degree {m}, basis {ic}: bad={bad}"

    H, ranks = cohomology(dims, diff)
    return {'skipped': False, 'H': H, 'dims': dims, 'diff': diff,
            'objs': objs, 'index': index, 'chain_list': chain_list,
            'tot_basis': tot_basis, 'tot_index': tot_index,
            'fam_cells': fam_cells}


# ==========================================================================
# 3.  hocolim_{C_n} X  (mg-f9a7 reproduction, for the controlled
#     terminal-excluded experiment B)
# ==========================================================================
def hocolim_cohomology(n, verbose=True, min_ground=0):
    """Same as mg-f9a7 fork_a_cohomology -- ported for self-containment.
    BK^{p,q} = +/+_chains C^q(X(F_0)), value at FIRST object, d_0 face
    pulling back along pi_T."""
    objs, index = build_category(n, min_ground)
    if verbose:
        tag = f" (|S|>={min_ground})" if min_ground else ""
        print(f"{el()}  hocolim probe on C_{n}{tag}: {len(objs)} objects")
    fam_cells = {}
    for (S, F) in objs:
        if F not in fam_cells:
            fam_cells[F] = defect_cells(F)
    dco = per_family_coboundary(fam_cells)

    chains_by_len, chain_list = {}, []
    for (S0, F0) in objs:
        for gseq in decreasing_chains(S0):
            if len(gseq[-1]) < min_ground:
                continue
            objseq = tuple(index[(Si, trace(F0, Si))] for Si in gseq)
            chain_list.append(objseq)
            chains_by_len.setdefault(len(objseq) - 1, []).append(objseq)
    parents = {}
    for L in sorted(chains_by_len):
        if L == 0:
            continue
        for ch in chains_by_len[L]:
            for j in range(len(ch)):
                parents.setdefault(ch[:j] + ch[j + 1:], []).append((ch, j))

    tot_basis, tot_index = {}, {}
    for ch in chain_list:
        F0 = objs[ch[0]][1]
        p = len(ch) - 1
        for q, qcells in fam_cells[F0].items():
            for c in qcells:
                tot_basis.setdefault(p + q, []).append((ch, c))
    for m in tot_basis:
        for i, b in enumerate(tot_basis[m]):
            tot_index[b] = i
    dims = {m: len(tot_basis[m]) for m in tot_basis}

    def pullback_cell(c, T):
        A, Tp = c
        return (frozenset(A & T), Tp) if Tp <= T else None

    diff = {}
    for m in sorted(dims):
        cols = []
        for (ch, c) in tot_basis[m]:
            F0 = objs[ch[0]][1]
            q = len(c[1])
            col = {}
            qidx = {cc: i for i, cc in enumerate(fam_cells[F0].get(q, []))}
            for c2j, coeff in dco[F0][q][qidx[c]].items():
                c2 = fam_cells[F0][q + 1][c2j]
                key = tot_index[(ch, c2)]
                col[key] = col.get(key, 0) + coeff
            sgn = (-1) ** q
            for (par, j) in parents.get(ch, []):
                js = (-1) ** j
                if j == 0:
                    Fabove = objs[par[0]][1]
                    Sbelow = objs[par[1]][0]
                    for c2 in fam_cells[Fabove].get(q, []):
                        if pullback_cell(c2, Sbelow) == c:
                            r = tot_index[(par, c2)]
                            col[r] = col.get(r, 0) + sgn * js
                else:
                    r = tot_index[(par, c)]
                    col[r] = col.get(r, 0) + sgn * js
            cols.append({r: v for r, v in col.items() if v})
        diff[m] = cols
    H, _ = cohomology(dims, diff)
    return {'H': H, 'dims': dims, 'objs': objs, 'chain_list': chain_list,
            'tot_basis': tot_basis, 'tot_index': tot_index,
            'fam_cells': fam_cells}


# ==========================================================================
# 4.  S_n action -- Hopf trace on the total complex
# ==========================================================================
def perm_sign_on(g, T):
    seen, cycles = set(), 0
    for t in T:
        if t in seen:
            continue
        cycles += 1
        u = t
        while u not in seen:
            seen.add(u)
            u = g[u]
    return (-1) ** (len(T) - cycles)


def hopf_trace(g, objs, index, tot_basis):
    def gSF(SF):
        S, F = SF
        return (frozenset(g[i] for i in S),
                frozenset(frozenset(g[i] for i in A) for A in F))

    gobj = {}
    for o in objs:
        go = gSF(o)
        gobj[index[o]] = index.get(go, -1)

    V = 0
    for m, basis in tot_basis.items():
        tr = 0
        for (ch, c) in basis:
            if all(gobj[oid] == oid for oid in ch):
                A, Tp = c
                gA = frozenset(g[i] for i in A)
                gT = frozenset(g[i] for i in Tp)
                if gA == A and gT == Tp:
                    tr += perm_sign_on(g, Tp)
        V += ((-1) ** m) * tr
    return V


def s3_isotypes(Ve, Vt, Vc):
    """Decompose a virtual S_3-character given on (e,(12),(123))."""
    a_tr = (Ve + 3 * Vt + 2 * Vc) / 6
    a_sg = (Ve - 3 * Vt + 2 * Vc) / 6
    a_st = (2 * Ve - 2 * Vc) / 6
    return a_tr, a_sg, a_st


# ==========================================================================
# 5.  Self-tests
# ==========================================================================
def order_complex_chains(elements, leq_fn):
    """All strict chains x_0 < x_1 < ... < x_d in a poset, returned as
    dict d -> list of tuples."""
    elems = list(elements)
    lt = {e: [b for b in elems if e != b and leq_fn(e, b)] for e in elems}
    chains = {}
    def rec(ch):
        chains.setdefault(len(ch) - 1, []).append(tuple(ch))
        for nxt in lt[ch[-1]]:
            rec(ch + [nxt])
    for e in elems:
        rec([e])
    return chains


def reduced_betti_of_order_complex(chains):
    """Reduced Betti numbers over Q of a simplicial complex given by its
    chain (simplex) lists.  chains[d] = list of d-simplices (tuples)."""
    if not chains:
        return {-1: 1}
    maxd = max(chains)
    cid = {}
    for d in range(maxd + 1):
        for i, ch in enumerate(chains.get(d, [])):
            cid[ch] = i
    ranks = {}
    for d in range(maxd + 2):
        cols = chains.get(d, [])
        if not cols:
            ranks[d] = 0
            continue
        if d == 0:
            sparse = [{0: 1} for _ in cols]   # augmentation
        else:
            sparse = []
            for ch in cols:
                col = {}
                for k in range(len(ch)):
                    face = ch[:k] + ch[k + 1:]
                    col[cid[face]] = (-1) ** k
                sparse.append(col)
        ranks[d] = rank2(sparse)
    Hred = {}
    for d in range(maxd + 1):
        Hred[d] = len(chains.get(d, [])) - ranks.get(d, 0) - ranks.get(d + 1, 0)
    Hred[-1] = 1 - ranks.get(0, 0)
    return {d: r for d, r in Hred.items() if r}


def _selftests():
    # punctured Boolean cube 2^[3] \ {0,[3]} : per-family object,
    # order complex ~ S^1 (UC9 D-4, mg-565a self-test).
    cube3 = [frozenset(c) for k in range(4) for c in combinations(range(3), k)]
    punct = [s for s in cube3 if 0 < len(s) < 3]
    chains = order_complex_chains(punct, lambda a, b: a < b)
    Hred = reduced_betti_of_order_complex(chains)
    assert Hred == {1: 1}, f"punctured Boolean cube 2^[3]\\{{0,[3]}}: {Hred}"
    print(f"{el()}  self-test: punctured Boolean cube 2^[3]\\{{0,[3]}} -> H~^1 = 1 (= S^1)  OK")

    # Moore-family lattice proper part on [3]: must be Q-acyclic
    # (mg-565a Fork D probe).
    moore = moore_families(frozenset(range(3)))
    bot = min(moore, key=len)
    top = max(moore, key=len)
    pbar = [F for F in moore if F != bot and F != top]
    assert len(pbar) == 59, f"Moore proper part size {len(pbar)} != 59"
    ch_m = order_complex_chains(pbar, lambda a, b: a < b)
    Hred_m = reduced_betti_of_order_complex(ch_m)
    assert not Hred_m, f"Moore lattice proper part should be acyclic: got {Hred_m}"
    print(f"{el()}  self-test: Moore-family lattice [3] proper part (59 elts) "
          f"-> Q-ACYCLIC  OK  (mg-565a confirmed)")


# ==========================================================================
# 6.  Main
# ==========================================================================
def print_h(label, H):
    nz = {m: r for m, r in H.items() if r}
    print(f"      {label}: H^* = {H}    nonzero = {nz if nz else 'ALL ZERO (acyclic)'}")


def isotype_report(name, ch, objs, index, tot_basis):
    perms = {"e": {0: 0, 1: 1, 2: 2},
             "(12)": {0: 1, 1: 0, 2: 2},
             "(123)": {0: 1, 1: 2, 2: 0}}
    V = {nm: hopf_trace(g, objs, index, tot_basis) for nm, g in perms.items()}
    a_tr, a_sg, a_st = s3_isotypes(V["e"], V["(12)"], V["(123)"])
    Ve, Vt, Vc = V["e"], V["(12)"], V["(123)"]
    print(f"      virtual char V = sum_m (-1)^m [H^m] = "
          f"({Ve}, {Vt}, {Vc}) on (e,(12),(123))  "
          f"= {a_tr:+g}*triv {a_sg:+g}*sgn {a_st:+g}*std")
    return a_tr, a_sg, a_st


def main():
    print("=" * 74)
    print("Frankl-Spherical-Reconcile   (work item mg-7bf3)")
    print("=" * 74)
    print(__doc__)
    _selftests()

    # ----------------------------------------------------------------
    # PART 1 -- the reconciliation table : where the spherical content lives
    # ----------------------------------------------------------------
    print()
    print("=" * 74)
    print("PART 1 -- RECONCILIATION TABLE")
    print("=" * 74)
    print("""
  Every proven spherical result in the union-closed / F-series corpus,
  classified by what its OBJECT is :

  (A) F-series                Delta(PPF_n)  =  order complex of the
      Delta_n ~ S^{n-2}        CATEGORY OF POSETS on [n], ordered by
      H~^{n-2}(Delta_n) = sgn  refinement.  THIS IS A DIFFERENT CATEGORY ;
                              not the category of intersection-closed
                              families.  F17 (mg-4d3a) + F18 (mg-d039).

  (B) UC9 D-4                 PER-FAMILY object : the maximal family
      Delta(2^[n] \\ {0,[n]})    F = 2^[n] viewed as the inclusion poset
      ~ S^{n-2}               of its own member sets, with top {0,[n]}
      H~^{n-2} = sgn_Sn        removed.  ONE object of the lattice/
                              category of int-closed families ; NOT the
                              cohomology of the lattice/category itself.
                              Self-test below reproduces this at n=3.

  (C) Fork D probe (mg-565a)  CATEGORY-LEVEL object : the Moore-family
      Moore lattice [3]         lattice on [n], ordered by family-
      proper part            inclusion.  Reduced Betti numbers = 0 in
                              EVERY degree.  Q-ACYCLIC.  Not spherical.

  (D) Fork A probe (mg-f9a7)  CATEGORY-LEVEL object : H^*(C_n;X) =
      hocolim_{C_n} X         cohomology of the covariant homotopy
                              colimit of the per-family cubical-defect
                              diagram over the trace category.  Q-ACYCLIC
                              for every n (terminal-object collapse).

  Verdict on RECONCILIATION : every proven SPHERICAL result is about a
  PER-FAMILY object (Delta(PPF_n) is the SISTER category of posets, not
  the category of int-closed families ; the punctured Boolean cube is
  ONE family viewed as its own poset).  Every proven category-level
  result on the category of INTERSECTION-CLOSED families -- the Moore-
  family lattice (C) and the trace-category hocolim (D) -- is ACYCLIC.
  Daniel's recollection of a "category-level spherical result" matches
  the per-family object (B), conflating it with the lattice/category :
  exactly the conflation mg-565a S5 flagged in vision-check S6.5.""")

    # ----------------------------------------------------------------
    # PART 2 -- the DEFINITION-TWEAK probe : holim_{C_3} X
    # ----------------------------------------------------------------
    print()
    print("=" * 74)
    print("PART 2 -- DEFINITION-TWEAK PROBE : holim_{C_3} X (LEAD CANDIDATE)")
    print("=" * 74)
    print("""
  THE TWEAK.  Replace the covariant hocolim (Fork A def:bk) by the
  covariant homotopy LIMIT.  The Fork A collapse mechanism is :
      {t} -> C_n  is homotopy FINAL  (t = (emptyset,{emptyset}) terminal)
  => hocolim_{C_n} X  ~  X(t)  = point.
  For holim, what matters is homotopy INITIALITY, not finality :
      {t} -> C_n  is NOT homotopy initial  (the comma (t \\ c) is empty
      for c != t, not contractible)
  => holim does NOT suffer the terminal-object collapse.
  And C_n has no initial object, so holim does not collapse onto any
  other single value either.

  Per refoundation.tex rem:hocolim-flag / rem:holim-prereq, the
  obstruction is a "gluing-type (limit-flavoured) invariant" -- so
  holim is the variance the structural intuition wants.

  COMPUTATION.  The cosimplicial replacement
      Pi^p = prod_{p-chains c_0 -> ... -> c_p}  X(c_p)
  with codifferential delta + value-at-last + structure-map face = the
  trace projection  pi : X(F) -> X(F|_T).  Total complex with
  D = d_vert + (-1)^q delta_horiz ; D^2 = 0 verified explicitly.""")

    print()
    print(f"{el()}  computing H^*(C_3; pi_0(X)) ...")
    print(f"     [the homotopy-discrete X(F) of mg-f9a7 PART 1 collapses the BK")
    print(f"      spectral sequence for holim_{{C_3}} X onto its q=0 row, so")
    print(f"      H^p(holim X) = H^p(C_3; M) for M = pi_0(X(-)) ; see S2'.]")
    res = H_star_C_n_M_cohomology(3, verbose=True)
    H, dims = res['H'], res['dims']
    print()
    print("  H^*(C_3; M) :")
    for p in sorted(dims):
        tag = "   <- degree n-1 = 2 : the F-series 'sphere' degree" if p == 2 else \
              ("   <- degree n-2 = 1 : the alternative 'sphere' degree" if p == 1 else "")
        print(f"      H^{p} = {H[p]}    (dim C^{p} = {dims[p]}){tag}")
    nz = {p: r for p, r in H.items() if r}
    print(f"  nonzero cohomology : {nz}")

    print()
    print("  S_3-isotype structure (Hopf trace on the cobar):")
    perms = {"e": {0: 0, 1: 1, 2: 2},
             "(12)": {0: 1, 1: 0, 2: 2},
             "(123)": {0: 1, 1: 2, 2: 0}}
    Vh = {nm: hopf_trace_M(g, res['objs'], res['index'],
                           res['cb_basis'], res['fam_components'])
          for nm, g in perms.items()}
    a_tr, a_sg, a_st = s3_isotypes(Vh["e"], Vh["(12)"], Vh["(123)"])
    print(f"      virtual char on (e,(12),(123)) = "
          f"({Vh['e']}, {Vh['(12)']}, {Vh['(123)']})"
          f"   = {a_tr:+g}*triv {a_sg:+g}*sgn {a_st:+g}*std")

    if len(nz) == 1:
        d0 = list(nz)[0]
        s = (-1) ** d0
        print(f"      H^* concentrated in degree {d0}, so the H^{d0}")
        print(f"      character is {s}*V :")
        print(f"      H^{d0}(C_3;M) = {s*a_tr:+g}*triv {s*a_sg:+g}*sgn {s*a_st:+g}*std")

    # spherical-test : is H^* concentrated in one degree, dim 1, sgn_S3?
    sphereable_1d = (len(nz) == 1 and list(nz.values())[0] == 1)
    print()
    if sphereable_1d:
        d0 = list(nz)[0]
        print(f"  >>> SPHERICAL (one-dimensional, concentrated in degree {d0}) :")
        print(f"      definition-tweak candidate ALIVE ! <<<")
    else:
        if not nz:
            print("  >>> Q-ACYCLIC : holim also collapses.  Definition-tweak FAILS. <<<")
        else:
            print(f"  >>> NON-TRIVIAL but NOT SPHERICAL : H^* = {nz}.")
            top_deg = max(nz) if nz else -1
            print(f"      Top non-zero degree : {top_deg}, dim {nz.get(top_deg)}.")
            print(f"      Spherical needs dim 1 in a single degree.  This is")
            print(f"      family-sensitive non-trivial category-level cohomology,")
            print(f"      but NOT the one-class sphere Daniel's recollection wants. <<<")

    # ----------------------------------------------------------------
    # PART 3 -- the controlled experiments
    # ----------------------------------------------------------------
    print()
    print("=" * 74)
    print("PART 3 -- TERMINAL-OBJECT-EXCLUDED SUBCATEGORY TWEAKS")
    print("=" * 74)
    print("""
  Drop the terminal object t = (emptyset, {emptyset}) (and, in the
  stronger variant, the entire |S|=1 layer of singleton ground sets).
  mg-f9a7 S2.3 noted the hocolim result on |S|>=1 :  H^2 = 59  (not 1).
  Here we (a) confirm or refute that finding ; (b) report the holim
  result on the same subcategory ; (c) record the verdict.""")

    print()
    print("  --- ADDITIONAL TWEAK : Moore-lattice with inclusion morphisms, M=pi_0(X) ---")
    print()
    print("  Undo drift A (inclusion morphisms instead of traces), keep the")
    print("  coefficient diagram pi_0(X) the Fork-D probe (mg-565a) vindicated:")
    print()
    for variant in [(False, False, "whole lattice"),
                    (True,  False, "without top {2^[3]}"),
                    (True,  True,  "proper part (no top, no bot)")]:
        drop_top, drop_bot, label = variant
        Rm = H_star_Moore_lattice_M_cohomology(3, verbose=True,
                                                drop_top=drop_top,
                                                drop_bot=drop_bot,
                                                return_basis=True)
        nzm = {p: r for p, r in Rm['H'].items() if r}
        print(f"    H^*(Moore-lattice [3] {label}; pi_0(X)) = {Rm['H']}    nonzero = {nzm}")
        # S_3 isotype via Hopf trace
        perms = {"e": {0: 0, 1: 1, 2: 2},
                 "(12)": {0: 1, 1: 0, 2: 2},
                 "(123)": {0: 1, 1: 2, 2: 0}}
        Vh = {nm: hopf_trace_lattice_M(g, Rm['fams'], Rm['fam_components'],
                                       Rm['cb_basis'])
              for nm, g in perms.items()}
        a_tr, a_sg, a_st = s3_isotypes(Vh["e"], Vh["(12)"], Vh["(123)"])
        print(f"      virtual char on (e,(12),(123)) = "
              f"({Vh['e']}, {Vh['(12)']}, {Vh['(123)']})"
              f"   = {a_tr:+g}*triv {a_sg:+g}*sgn {a_st:+g}*std")
        if len(nzm) == 1:
            d0 = list(nzm)[0]
            s = (-1) ** d0
            print(f"      H^{d0} = {s*a_tr:+g}*triv {s*a_sg:+g}*sgn {s*a_st:+g}*std")
        print()

    print()
    print("  --- ORIGINAL TWEAKS : C_3 minus the terminal object (mg-f9a7 S2.3) ---")
    for k in (1, 2):
        print()
        print(f"  --- subcategory C_3^{{|S|>={k}}} ---")
        print()
        print(f"  hocolim (Fork A object, mg-f9a7 S2.3):")
        Rho = hocolim_cohomology(3, verbose=True, min_ground=k)
        nzh = {m: r for m, r in Rho['H'].items() if r}
        print(f"    H^*(hocolim, |S|>={k}) = {Rho['H']}    nonzero = {nzh}")

        print()
        print(f"  H^*(.; pi_0(X)) (the tweak applied to the same subcategory):")
        Rhl = H_star_C_n_M_cohomology(3, verbose=True, min_ground=k)
        nzl = {p: r for p, r in Rhl['H'].items() if r}
        print(f"    H^*(C_3^{{|S|>={k}}}; pi_0(X)) = {Rhl['H']}    nonzero = {nzl}")

    # ----------------------------------------------------------------
    # PART 4 -- verdict
    # ----------------------------------------------------------------
    print()
    print("=" * 74)
    print("PART 4 -- GATE VERDICT")
    print("=" * 74)
    print(__doc__.split("THE TWEAK")[0])
    print(f"  See docs/Frankl-Spherical-Reconcile.md for the full report.")
    print(f"{el()}  done.")


if __name__ == "__main__":
    main()
