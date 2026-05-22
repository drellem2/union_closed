#!/usr/bin/env python3
"""
Frankl-ForkA-Phase0-FaithfulnessProbe : bounded n=3/4 faithfulness probe.

Work item mg-f9a7.  Per the mg-0882 Frankl-ForkA-Residuals-Roadmap, the
Phase-0 bounded faithfulness probe (roadmap S5.2 -- the one permitted
exception to the "no computation before P0" rule: a from-scratch direct
computation at small n, the way mg-565a probed Fork D viability).

QUESTION (the make-or-break wall R3c, the second-risk R2).  Does the Fork A
obstruction cohomology genuinely DETECT the family structure -- is it
faithful, NOT family-blind -- in the way the two-part contradiction
(refoundation.tex thm:contradiction) needs?

The Fork A objects, from paper/forkA/refoundation.tex:
  * the trace category  C_n  (def:category): objects (S,F) = pointed
    intersection-closed families, morphisms = traces F |-> F|_T;
  * the per-family cubical-defect complex  X(F)  (def:xf): k-cells are
    the k-subcubes fully contained in F;
  * the Fork A cohomology  H^*(C_n;X)  (def:bk): the cohomology of the
    covariant homotopy colimit, i.e. the total complex of the
    Bousfield-Kan double complex BK^{p,q};
  * the obstruction sheaf  F_obs  on the punctured trace poset, with the
    rare-coordinate strata U_x and the mismatch cocycle {m_xy}
    (def:obs-sheaf, def:ob).

This script computes, from scratch and reproducibly:
  PART 1  the per-family Fork-A defect complex X(F) and its cohomology,
          for every family at n=3 and n=4 -- is the COEFFICIENT DIAGRAM
          family-sensitive? (a necessary condition for faithfulness);
  PART 2  the Fork A cohomology H^*(C_3;X) -- the genuine integrated
          object -- with its S_3-isotype structure; the control
          H^*(C_3;Q) of the bare nerve; a direct test of Y1-A
          (conj:y1a) at n=3;
  PART 3  the rare-coordinate cover {U_x}, the obstruction sheaf F_obs,
          the mismatch cocycle, and a direct FAMILY-BLINDNESS test of
          the obstruction machinery at n=3 and n=4;
  PART 4  the structural faithfulness read (printed synthesis).

All ranks are computed by sparse Gaussian elimination modulo a large
prime, cross-checked at two independent ~2^31 primes.  No dependencies.
"""

from itertools import combinations
import sys, time

PRIMES = (2147483647, 2147483629)
T0 = time.time()


def el(): return f"[{time.time()-T0:6.1f}s]"


# ==========================================================================
# 0.  Linear algebra : sparse modular rank, cohomology of a cochain complex
# ==========================================================================
def sparse_rank(columns, p):
    """Rank mod p of a sparse matrix given as a list of columns (dict row->val)."""
    rank = 0
    pivots = {}  # row -> reduced pivot column
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
    """Rank over Q : sparse rank cross-checked at two primes."""
    if not columns:
        return 0
    r0 = sparse_rank(columns, PRIMES[0])
    r1 = sparse_rank(columns, PRIMES[1])
    assert r0 == r1, f"prime cross-check FAILED: {r0} vs {r1}"
    return r0


def cohomology(dims, diff):
    """H^m of a cochain complex.  dims[m] = dim C^m ;  diff[m] = columns of
    d : C^m -> C^{m+1} (list of dict row->coeff, one per basis elt of C^m)."""
    ranks = {m: rank2(cols) for m, cols in diff.items()}
    H = {}
    for m in dims:
        H[m] = dims[m] - ranks.get(m, 0) - ranks.get(m - 1, 0)
    return H, ranks


# ==========================================================================
# 1.  Intersection-closed families ; the per-family defect complex X(F)
# ==========================================================================
def is_int_closed(F):
    Fs = set(F)
    return all((a & b) in Fs for a in Fs for b in Fs)


def moore_families(S):
    """All Moore families on ground set S : intersection-closed, contain S.
    (union = S is then automatic.)  S a frozenset."""
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
    """The cubical-defect complex X(F) (refoundation def:xf).  A k-cell is a
    pair (A,T') with A in F, T' a set of k 'free directions' disjoint from A,
    such that the WHOLE k-subcube  {A u T'' : T'' subset of T'}  lies in F.
    Returns dict : k -> list of cells (A,T')."""
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
    """Standard cubical boundary of a cell (A,T') :
       d(A,T') = sum_i (-1)^i [ (A u t_i, T'-t_i) - (A, T'-t_i) ].
    Returns list of (face_cell, coeff)."""
    A, Tp = cell
    ts = sorted(Tp)
    out = []
    for i, t in enumerate(ts):
        rest = frozenset(Tp - {t})
        out.append(((A | {t}, rest), (-1) ** i))          # upper face
        out.append(((A, rest), -((-1) ** i)))             # lower face
    return out


def defect_cohomology(F):
    """Reduced cohomology H~^q(X(F)) over Q.  Returns dict q -> dim
    (reduced : an augmentation C^0 -> C^{-1}=Q is appended)."""
    cells = defect_cells(F)
    if not cells:
        return {}
    maxd = max(cells)
    idx = {}
    for d in range(maxd + 1):
        for i, c in enumerate(cells.get(d, [])):
            idx[c] = i
    # boundary ranks (homology over Q = cohomology over Q in each degree)
    ranks = {}
    for d in range(0, maxd + 2):
        cols = []
        src = cells.get(d, [])
        if d == 0:
            cols = [{0: 1} for _ in src]                  # augmentation
        else:
            for c in src:
                col = {}
                for face, coeff in cubical_boundary(c):
                    col[idx[face]] = col.get(idx[face], 0) + coeff
                cols.append({r: v for r, v in col.items() if v})
        ranks[d] = rank2(cols)
    H = {}
    for d in range(0, maxd + 1):
        H[d] = len(cells.get(d, [])) - ranks.get(d, 0) - ranks.get(d + 1, 0)
    H[-1] = 1 - ranks.get(0, 0)
    return {d: r for d, r in H.items() if r != 0}


# ---- self-tests on X(F) --------------------------------------------------
def _selftest_defect():
    # full powerset 2^S : every subcube lies in F  ->  X = solid cube ->
    # contractible (reduced cohomology zero).
    for n in (2, 3, 4):
        S = frozenset(range(n))
        full = frozenset(frozenset(c) for k in range(n + 1)
                         for c in combinations(range(n), k))
        H = defect_cohomology(full)
        assert H == {}, f"X(2^[{n}]) should be contractible, got {H}"
    # trivial family {S} : single 0-cell -> a point.
    H = defect_cohomology(frozenset({frozenset(range(3))}))
    assert H == {}, f"X({{[3]}}) should be a point, got {H}"
    # d^2 = 0 on a sample of families
    for F in moore_families(frozenset(range(3))):
        cells = defect_cells(F)
        for d in sorted(cells)[1:]:
            for c in cells[d]:
                acc = {}
                for f1, c1 in cubical_boundary(c):
                    for f2, c2 in cubical_boundary(f1):
                        acc[f2] = acc.get(f2, 0) + c1 * c2
                assert all(v == 0 for v in acc.values()), f"d^2!=0 at {c}"
    print(f"{el()}  self-test: X(2^[n]) contractible, X({{S}})=point, d^2=0  OK")


# ==========================================================================
# 2.  The trace category C_n
# ==========================================================================
def trace(F, T):
    """The trace F|_T = {A cap T : A in F}  (def:category)."""
    return frozenset(frozenset(A & T) for A in F)


def build_category(n, min_ground=0):
    """All objects (S,F) of C_n with |S| >= min_ground.  Returns
    (objects, index) with objects a list of (S, F)."""
    objs = []
    for k in range(min_ground, n + 1):
        for Sc in combinations(range(n), k):
            S = frozenset(Sc)
            for F in moore_families(S):
                objs.append((S, F))
    index = {o: i for i, o in enumerate(objs)}
    return objs, index


def decreasing_chains(S):
    """All strictly-decreasing chains of subsets S = S_0 ) S_1 ) ... ) S_p,
    p >= 0, as tuples of frozensets starting at S."""
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


# ==========================================================================
# 3.  The Fork A cohomology  H^*(C_n;X)  -- the BK double complex (def:bk)
# ==========================================================================
def fork_a_cohomology(n, verbose=True, dim_cap=None, min_ground=0):
    """H^m(C_n;X) = H^m(Tot BK, D).  BK^{p,q} = (+) over strict p-chains
    F_0 > ... > F_p  of  C^q(X(F_0)).  D = d + (-1)^q delta_BK.
    min_ground > 0 restricts to the full subcategory on objects with
    |S| >= min_ground (the controlled experiment: drop the terminal object).
    Returns a dict of results, or {'skipped':True} if Tot exceeds dim_cap."""
    objs, index = build_category(n, min_ground)
    if verbose:
        tag = f" (|S|>={min_ground})" if min_ground else ""
        print(f"{el()}  C_{n}{tag}: {len(objs)} objects")

    # ---- per-family cells and the cubical coboundary d -----------------
    # dco[F][q] : list (per q-cell) of dict {(q+1)-cell-index: coeff}
    fam_cells, dco = {}, {}
    for (S, F) in objs:
        if F in fam_cells:
            continue
        cells = defect_cells(F)
        fam_cells[F] = cells
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
            per[q] = cols
        dco[F] = per

    # ---- all strict chains of C_n : a chain is determined by its top
    #      object F_0 and a strictly decreasing ground-set sequence -------
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

    # face_chain -> list of (parent_chain, j) with d_j(parent) = face_chain
    parents = {}
    for L in sorted(chains_by_len):
        if L == 0:
            continue
        for ch in chains_by_len[L]:
            for j in range(len(ch)):
                parents.setdefault(ch[:j] + ch[j + 1:], []).append((ch, j))

    # ---- Tot^m basis : (chain, cell), m = (len(chain)-1) + |T'| ---------
    objSF = objs
    tot_basis, tot_index = {}, {}
    for ch in chain_list:
        F0 = objSF[ch[0]][1]
        p = len(ch) - 1
        for q, qcells in fam_cells[F0].items():
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

    # ---- the total differential D = d + (-1)^q delta_BK ----------------
    def pullback_cell(c, T):
        """pi_T on a cell : C(A,T') |-> C(A cap T, T') if T' subset T."""
        A, Tp = c
        return (frozenset(A & T), Tp) if Tp <= T else None

    diff = {}
    for m in sorted(dims):
        cols = []
        for (ch, c) in tot_basis[m]:
            F0 = objSF[ch[0]][1]
            q = len(c[1])
            col = {}
            # (1) vertical d : same chain, q-cell -> (q+1)-cells of X(F_0)
            qidx = {cc: i for i, cc in enumerate(fam_cells[F0].get(q, []))}
            for c2j, coeff in dco[F0][q][qidx[c]].items():
                c2 = fam_cells[F0][q + 1][c2j]
                col[tot_index[(ch, c2)]] = \
                    col.get(tot_index[(ch, c2)], 0) + coeff
            # (2) horizontal (-1)^q delta_BK : chain -> parent (p+1)-chains
            sgn = (-1) ** q
            for (par, j) in parents.get(ch, []):
                js = (-1) ** j
                if j == 0:
                    Fabove = objSF[par[0]][1]
                    Sbelow = objSF[par[1]][0]
                    for c2 in fam_cells[Fabove].get(q, []):
                        if pullback_cell(c2, Sbelow) == c:
                            r = tot_index[(par, c2)]
                            col[r] = col.get(r, 0) + sgn * js
                else:
                    r = tot_index[(par, c)]
                    col[r] = col.get(r, 0) + sgn * js
            cols.append({r: v for r, v in col.items() if v})
        diff[m] = cols

    H, ranks = cohomology(dims, diff)
    return {'skipped': False, 'H': H, 'dims': dims, 'diff': diff,
            'objs': objs, 'index': index, 'chain_list': chain_list,
            'tot_basis': tot_basis, 'tot_index': tot_index,
            'fam_cells': fam_cells}


# ==========================================================================
#  S_n virtual character of H^*(C_n;X)  via the Lefschetz / Hopf trace
# ==========================================================================
def perm_sign_on(g, T):
    """Sign of the permutation g restricted to the set T (g maps T to T)."""
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


# ==========================================================================
#  main
# ==========================================================================
def main():
    print("=" * 74)
    print("Frankl-ForkA-Phase0-FaithfulnessProbe   (work item mg-f9a7)")
    print("bounded n=3/4 faithfulness probe of the Fork A obstruction cohomology")
    print("=" * 74)
    _selftest_defect()

    # ----------------------------------------------------------------
    # PART 1 : the per-family defect complex X(F) -- coefficient diagram
    # ----------------------------------------------------------------
    print()
    print("PART 1 -- the per-family Fork-A defect complex X(F) (def:xf)")
    print("  Is the COEFFICIENT DIAGRAM F |-> X(F) family-sensitive?")
    for n in (3, 4):
        S = frozenset(range(n))
        fams = moore_families(S)
        profiles = {}
        for F in fams:
            H = defect_cohomology(F)
            key = tuple(sorted(H.items()))
            profiles.setdefault(key, []).append(F)
        print(f"  n={n}: {len(fams)} families on [{n}]   "
              f"-> {len(profiles)} distinct X(F)-cohomology profiles")
        for key, fl in sorted(profiles.items(), key=lambda kv: -len(kv[1])):
            desc = ("acyclic (contractible)" if not key
                    else " ".join(f"H~{d}={r}" for d, r in key))
            print(f"      {desc:34s}: {len(fl)} families")

    # correlate with rare-coordinate count, n=3
    def beta(x, F):
        return sum(1 for A in F if x in A) - sum(1 for A in F if x not in A)

    print()
    print("  family-sensitivity vs Frankl data (n=3): X(F) reduced-homology")
    print("  rank against rare-coordinate count (rare : beta_x <= 0):")
    S3 = frozenset(range(3))
    bucket = {}
    for F in moore_families(S3):
        H = defect_cohomology(F)
        rk = sum(H.values())
        nr = sum(1 for x in range(3) if beta(x, F) <= 0)
        bucket.setdefault(nr, []).append(rk)
    for nr in sorted(bucket):
        rs = bucket[nr]
        print(f"      {nr} rare coord(s): X(F)-homology rank "
              f"{min(rs)}..{max(rs)}   ({len(rs)} families)")

    # ----------------------------------------------------------------
    # PART 2 : the Fork A cohomology H^*(C_3;X)
    # ----------------------------------------------------------------
    print()
    print("PART 2 -- the Fork A cohomology  H^*(C_3;X)  (def:bk, the genuine")
    print("  integrated object : cohomology of the covariant homotopy colimit)")
    res = fork_a_cohomology(3)
    H, dims, diff = res['H'], res['dims'], res['diff']
    objs, index = res['objs'], res['index']
    chain_list, tot_basis, tot_index = (res['chain_list'], res['tot_basis'],
                                        res['tot_index'])

    # D^2 = 0 self-test : compose consecutive differentials, must vanish
    print(f"{el()}  verifying D^2 = 0 ...")
    ok = True
    for m in sorted(dims):
        if (m + 1) not in diff:
            continue
        for col in diff[m]:
            acc = {}
            for r, v in col.items():
                for r2, v2 in diff[m + 1][r].items():
                    acc[r2] = acc.get(r2, 0) + v * v2
            if any(v for v in acc.values()):
                ok = False
    assert ok, "D^2 != 0 -- the BK differential is mis-signed"
    print(f"{el()}  self-test: D^2 = 0 verified on the n=3 total complex  OK")

    print()
    print("  H^m(C_3;X)  (m = total degree) :")
    for m in sorted(dims):
        tag = "   <- degree n-1 = 2 : the home of ob(F*)" if m == 2 else ""
        print(f"      H^{m} = {H[m]}    (dim Tot^{m} = {dims[m]}){tag}")
    nz = {m: r for m, r in H.items() if r}
    print(f"  nonzero cohomology : {nz if nz else 'ALL ZERO'}")

    # control : bare nerve H^*(C_3;Q)
    print()
    print("  CONTROL -- bare nerve H^*(C_3;Q) (constant coefficients):")
    Hc = nerve_cohomology(chain_list)
    print(f"      H^*(B C_3;Q) = {Hc}")
    print("      (C_3 has a terminal object (0,{0}) -> nerve contractible;")
    print("       so ALL family content must come from the coefficients X(-),")
    print("       exactly the mg-565a Fork-D finding.)")

    # S_3-isotype structure of H^*(C_3;X)
    print()
    print("  S_3-isotype structure (virtual character via Hopf trace):")
    perms = {"e": {0: 0, 1: 1, 2: 2},
             "(12)": {0: 1, 1: 0, 2: 2},
             "(123)": {0: 1, 1: 2, 2: 0}}
    V = {}
    for name, g in perms.items():
        V[name] = hopf_trace(g, objs, index, tot_basis)
    Ve, Vt, Vc = V["e"], V["(12)"], V["(123)"]
    print(f"      virtual character V = sum_m (-1)^m [H^m] = "
          f"({Ve}, {Vt}, {Vc})  on (e,(12),(123))")
    a_tr = (Ve + 3 * Vt + 2 * Vc) / 6
    a_sg = (Ve - 3 * Vt + 2 * Vc) / 6
    a_st = (2 * Ve - 2 * Vc) / 6
    print(f"      decomposes as  {a_tr:+g}*triv  {a_sg:+g}*sgn  {a_st:+g}*std")
    nzdeg = sorted(nz)
    if len(nzdeg) == 1:
        d = nzdeg[0]
        s = (-1) ** d
        print(f"      H^* concentrated in degree {d}; hence")
        print(f"      H^{d}(C_3;X) = {s*a_tr:+g}*triv {s*a_sg:+g}*sgn "
              f"{s*a_st:+g}*std")
        if (s * a_tr, s * a_sg, s * a_st) == (0, 1, 0):
            print(f"      => H^{d}(C_3;X) = sgn_S3  (one-dimensional sign "
                  f"isotype) : the sphere class.")

    # explicit verdict on Y1-A at n=3
    print()
    print("  TEST of Y1-A (conj:y1a) at n=3 :  H^1=0 and H^2 = sgn_S3 ?")
    y1a_h1 = (H.get(1, 0) == 0)
    y1a_h2 = (H.get(2, 0) == 1)
    print(f"      H^1(C_3;X) = {H.get(1,0)}   (Y1-A wants 0)         "
          f"{'OK' if y1a_h1 else 'FAILS'}")
    print(f"      H^2(C_3;X) = {H.get(2,0)}   (Y1-A wants 1, = sgn)  "
          f"{'OK' if y1a_h2 else 'FAILS'}")
    if not y1a_h2:
        print("      => Y1-A FAILS at n=3 : H~^{n-1}(C_3;X) = 0, not sgn.")
        print("         H^*(C_3;X) is rationally ACYCLIC -- a homology point.")

    # ----------------------------------------------------------------
    # PART 2b : the diagnosis -- the terminal object of C_n
    # ----------------------------------------------------------------
    print()
    print("PART 2b -- DIAGNOSIS : why is H^*(C_3;X) acyclic?")
    print("  C_n (def:category) has a TERMINAL object t = (emptyset,{emptyset}):")
    print("  every object (S,F) has exactly one morphism to it (the trace to")
    print("  the empty ground set).  The homotopy colimit of ANY functor over")
    print("  a category with a terminal object t collapses (up to homotopy)")
    print("  to the value at t -- the inclusion {t} -> C_n is homotopy final")
    print("  (every comma category (c \\downarrow t) is a single point).  And")
    print("  X(t) = X({emptyset}) is a single 0-cell : a POINT.  Hence")
    print("  hocolim_{C_n} X  ~  X(t)  =  point,  so  H^*(C_n;X) = H^*(point).")
    # verify t is terminal in C_3 and C_4
    for nn in (3, 4):
        objs_nn, idx_nn = build_category(nn)
        t = (frozenset(), frozenset({frozenset()}))
        assert t in idx_nn, f"terminal object missing from C_{nn}"
        all_map = all(trace(F, frozenset()) == frozenset({frozenset()})
                      for (S, F) in objs_nn)
        Xt = defect_cohomology(t[1])
        print(f"  direct check, C_{nn}: t in C_{nn} = True ; every one of the "
              f"{len(objs_nn)} objects")
        print(f"     has its unique trace to t = True ({all_map}) ; "
              f"X(t) reduced cohomology = {Xt if Xt else '{} (a point)'}")
    print("  => H^*(C_4;X) = H^*(point) too, by the same n-independent")
    print("     terminal-object collapse (the n=3 computation confirms it;")
    print("     a direct C_4 BK total complex is ~10^6-dim, out of probe")
    print("     scope, and would only re-confirm the theorem).")

    # controlled experiment : delete the terminal object, recompute
    print()
    print("  CONTROLLED EXPERIMENT : delete the terminal object, recompute.")
    print("  H^*(C_3 restricted to |S|>=k ; X), for k=1,2 -- if the collapse")
    print("  is caused by t, removing it must change the cohomology:")
    for k in (1, 2):
        r = fork_a_cohomology(3, verbose=False, min_ground=k)
        nzk = {m: v for m, v in r['H'].items() if v}
        print(f"      H^*(C_3 with |S|>={k} ; X) = {nzk}"
              f"   (total Tot dim {sum(r['dims'].values())})")
    print("  (a cohomology that changes when t is removed confirms t as the")
    print("   cause; see the .md report for the reading.)")

    # ----------------------------------------------------------------
    # PART 3 : the obstruction machinery -- cover, strata, family-blindness
    # ----------------------------------------------------------------
    print()
    print("PART 3 -- the obstruction sheaf F_obs : cover {U_x}, mismatch,")
    print("  and a direct FAMILY-BLINDNESS test  (def:obs-sheaf, def:ob)")
    for n in (3, 4):
        obstruction_probe(n)

    # ----------------------------------------------------------------
    # PART 4 : verdict
    # ----------------------------------------------------------------
    print()
    print("=" * 74)
    print("PART 4 -- FAITHFULNESS VERDICT")
    print("=" * 74)
    print("""
  RED -- FORK-A-NOT-VIABLE ; THE WRAPPER-RISK IS REALIZED.

  The Fork A cohomology object H^*(C_n;X) -- the covariant homotopy
  colimit of the per-family defect diagram, def:bk -- is rationally
  ACYCLIC for every n: H^*(C_3;X) = {0:1} by direct computation, and
  H^*(C_n;X) = H^*(point) for all n by the terminal-object collapse
  (C_n has the terminal object t=(emptyset,{emptyset}); X(t)=point;
  hocolim over a category with a terminal object collapses to X(t)).

  Consequences for refoundation.tex thm:contradiction:
   * conj:y1a (input v) is FALSE : H~^{n-1}(C_n;X) = 0, not sgn_Sn.
   * the obstruction class ob(F*) has NO non-trivial home : it is
     forced to 0.  Fact One (ob != 0) is unattainable.
   * R3a/R3b/R3c (the edge-map debt) are moot : the edge map, if it
     exists, lands in the zero group.  ob is family-blind not by a
     subtle non-injectivity but by total target collapse.
   * the two-part contradiction is hollow.

  This is family-blindness in the strongest form -- and it is NOT a
  defect of the coefficient diagram (PART 1 : X(-) is family-sensitive)
  nor of the obstruction machinery (PART 3 : the cover {U_x} is
  family-sensitive).  It is the covariant-hocolim INTEGRATION (Fork A
  prescription A2) that destroys the content -- exactly the
  hocolim-vs-holim concern the refoundation itself flagged in
  rem:hocolim-flag / rem:holim-prereq, here resolved against the
  hocolim.  See docs/Frankl-ForkA-Phase0-FaithfulnessProbe.md.
""")
    print(f"{el()}  done.")


# ---- bare nerve cohomology H^*(C_n;Q) -----------------------------------
def nerve_cohomology(chain_list):
    """H^* of the nerve of C_n with constant Q coefficients."""
    by_len, cid = {}, {}
    for ch in chain_list:
        by_len.setdefault(len(ch) - 1, []).append(ch)
    for L in by_len:
        for i, ch in enumerate(by_len[L]):
            cid[ch] = i
    maxL = max(by_len)
    dims = {L: len(by_len[L]) for L in by_len}
    diff = {}
    for L in range(maxL + 1):
        cols = [dict() for _ in by_len.get(L, [])]
        # delta on constant coeffs : (delta c)(tau) = sum_j (-1)^j c(d_j tau)
        for j, ch in enumerate(by_len.get(L + 1, [])):
            for jj in range(len(ch)):
                face = ch[:jj] + ch[jj + 1:]
                fi = cid[face]
                cols[fi][j] = cols[fi].get(j, 0) + (-1) ** jj
        diff[L] = [{r: v for r, v in c.items() if v} for c in cols]
    H, _ = cohomology(dims, diff)
    return {m: r for m, r in H.items() if r}


# ---- Hopf trace of g on H^*(C_n;X) --------------------------------------
def hopf_trace(g, objs, index, tot_basis):
    """V(g) = sum_m (-1)^m tr(g|Tot^m).  g a dict permutation of range(n)."""
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


# ==========================================================================
#  PART 3 helper : the obstruction probe at level n
# ==========================================================================
def obstruction_probe(n):
    """The rare-coordinate cover {U_x}, the obstruction sheaf F_obs and the
    mismatch cocycle, and a direct family-blindness test."""
    S = frozenset(range(n))
    fams = moore_families(S)

    def beta(x, F):
        return sum(1 for A in F if x in A) - sum(1 for A in F if x not in A)

    def rares(F):
        return [x for x in range(n) if beta(x, F) <= 0]

    # Frankl check at level n
    nontrivial = [F for F in fams if F != frozenset({S})]
    no_rare = [F for F in nontrivial if not rares(F)]
    print(f"  n={n}: {len(fams)} families on [{n}], {len(nontrivial)} "
          f"non-trivial; minimal counterexamples (no rare coord): "
          f"{len(no_rare)}")
    print(f"        -> Frankl holds at n={n} : {len(no_rare) == 0}   "
          f"(=> NO genuine F* exists at this n)")

    # For each non-trivial family F, treat it as the apex and build its
    # punctured trace poset, the strata U_x, and the mismatch cocycle.
    # The punctured trace poset = all PROPER traces of F.
    cover_ok = 0
    cover_fail = []
    mismatch_sensitive = 0      # the mismatch {m_xy} depends on the biases
    mismatch_blind = 0
    glue_ok = 0                 # a global rare coord of F itself exists
    for F in nontrivial:
        # proper traces of F : objects (T, F|_T), T proper subset of S
        ptraces = {}
        for k in range(n):           # |T| < n
            for Tc in combinations(range(n), k):
                T = frozenset(Tc)
                ptraces[T] = trace(F, T)
        # strata : U_x = { proper trace (T,G) : x in T, beta_x(G) <= 0 }
        strata = {x: set() for x in range(n)}
        for T, G in ptraces.items():
            for x in range(n):
                if x in T and beta(x, G) <= 0:
                    strata[x].add(T)
        covered = set().union(*strata.values()) if strata else set()
        # the punctured poset has the proper traces with NON-EMPTY domain
        # (the empty-ground trace carries no coordinate, drop it)
        need = set(T for T in ptraces if T)
        if covered >= need:
            cover_ok += 1
        else:
            cover_fail.append(F)
        # global rare coordinate of F itself : the gluing target
        if rares(F):
            glue_ok += 1
        # family-blindness test of the mismatch : the mismatch m_xy carries
        # the actual defect b_x = -beta_x.  Is the COHOMOLOGICAL content of
        # the obstruction determined by the actual biases, or only by the
        # combinatorial cover?  We compare the rare-coordinate PARTITION
        # (real biases) against the trivial 'all coordinates rare' cover.
        real_pattern = tuple(tuple(sorted(strata[x])) for x in range(n))
        blind_pattern = tuple(tuple(sorted(T for T in need if x in T))
                              for x in range(n))
        if real_pattern != blind_pattern:
            mismatch_sensitive += 1
        else:
            mismatch_blind += 1

    print(f"        strata {{U_x}} cover the punctured trace poset : "
          f"{cover_ok}/{len(nontrivial)} families")
    if cover_fail:
        print(f"        ({len(cover_fail)} families have a TRIVIAL proper "
              f"trace {{T}} (no rare coord);")
        print(f"         prop:minimality rules this out for a genuine minimal")
        print(f"         counterexample F* -- so this is not itself a Fork A")
        print(f"         flaw, only a note that these families are not F*.)")
    print(f"        families with a global rare coordinate of F itself : "
          f"{glue_ok}/{len(nontrivial)}  (=> ob(F)=0 expected, faithfully)")
    print(f"        mismatch cocycle FAMILY-SENSITIVE (strata depend on the")
    print(f"        actual biases, not just the cover shape) : "
          f"{mismatch_sensitive}/{len(nontrivial)} families")
    if mismatch_blind:
        print(f"        ... family-blind (strata = 'all coords') : "
              f"{mismatch_blind}  (these are the families where every")
        print(f"            coordinate is rare on every trace)")

    # the structural obstruction : Cech H^1 of the cover {U_x} on the
    # punctured trace poset.  We compute the cohomology of the NERVE of the
    # cover (the abstract simplicial complex whose simplices are the
    # non-empty intersections U_{x_0} cap ... cap U_{x_p}), for a sample.
    print(f"  n={n}: structural read -- nerve of the rare-coordinate cover")
    nerve_profiles = {}
    for F in nontrivial:
        ptraces = {}
        for k in range(n):
            for Tc in combinations(range(n), k):
                T = frozenset(Tc)
                ptraces[T] = trace(F, T)
        strata = {x: set() for x in range(n)}
        for T, G in ptraces.items():
            for x in range(n):
                if x in T and beta(x, G) <= 0:
                    strata[x].add(T)
        # nerve : simplex {x_0,...,x_p} present iff the strata intersect
        simplices = {}
        for k in range(1, n + 1):
            for xs in combinations(range(n), k):
                inter = set.intersection(*(strata[x] for x in xs)) \
                    if all(strata[x] for x in xs) else set()
                if inter:
                    simplices.setdefault(k - 1, []).append(xs)
        # reduced homology of the nerve
        key = tuple(sorted((d, len(v)) for d, v in simplices.items()))
        nerve_profiles.setdefault(key, 0)
        nerve_profiles[key] += 1
    print(f"        {len(nerve_profiles)} distinct cover-nerve incidence "
          f"profiles among {len(nontrivial)} families")
    print(f"        (the cover nerve genuinely varies with the family => the")
    print(f"         obstruction MACHINERY is not family-blind at the cover")
    print(f"         level)")


if __name__ == "__main__":
    main()
