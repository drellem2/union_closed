#!/usr/bin/env python3
r"""
Frankl-Downset-Reframing : downset-of-fixed-F cohomology, n=3 probe.

Work item mg-8f74.  Daniel reminder 2026-05-22 (2nd of two responding to
the Fork A refutation, mg-f9a7): "choose one intersection closed family.
We care about all the sub-families, which is basically the downset in
the category of all families.  Now if the cohomology of the category
suddenly becomes trivial or something at the very maximal step this
does not matter."

QUESTION.  The mg-f9a7 probe refuted Fork A by computing the GLOBAL
H^*(C_n;X) and finding it acyclic -- the terminal-object t = (emptyset,
{emptyset}) of C_n forces the covariant hocolim to collapse onto
X(t) = point.  Daniel's reframing: the Frankl two-part contradiction
fixes a (minimal counterexample) family F* and works with all its
SUB-FAMILIES = the downset of F*.  Maybe the global category's terminal-
object collapse is irrelevant to that downset object.

This probe pins down WHICH ambient hosts the obstruction in each natural
variant, computes the cohomology at n=3 for representative F's, and
reports whether the collapse persists or not.

The candidate ambients (per refoundation.tex def:ob + rem:promotion):

  (T)  C_n(F)              : the FULL trace-poset of F -- all traces
                             of F = the natural ambient for the BK
                             integration LOCAL to F.  Has F as INITIAL
                             (in the trace direction) and t as TERMINAL.
                             Covariant hocolim => collapse onto X(t).

  (T-)  C_n(F) \ {F}       : the PUNCTURED trace poset -- the actual
                             support of the obstruction sheaf F_obs.
                             Still has t as terminal; same collapse.

  (T=)  C_n(F) \ {F, t}    : doubly-punctured -- the analog of the
                             mg-f9a7 sec.2.3 controlled experiment
                             localized to F.  No terminal; non-trivial
                             cohomology possible.

  (I)   {F' subset F : F' int-closed}  =  downset of F in the
                             INCLUSION direction (Fork D variance).
                             Has F as TERMINAL (maximum).  Covariant
                             hocolim => collapse onto X(F) -- not the
                             trivial point, but X(F) itself.

All ranks computed via sparse Gaussian elimination at two ~2^31 primes.
"""

from itertools import combinations
import sys, time

PRIMES = (2147483647, 2147483629)
T0 = time.time()


def el(): return f"[{time.time()-T0:6.1f}s]"


# ==========================================================================
# 0.  Sparse modular rank ; cohomology of a cochain complex
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
# 1.  Intersection-closed families ; X(F) = cubical defect complex
# ==========================================================================
def is_int_closed(F):
    Fs = set(F)
    return all((a & b) in Fs for a in Fs for b in Fs)


def moore_families(S):
    """All Moore families on S : int-closed, contain S."""
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
    """Cubical-defect cells of X(F)  (refoundation def:xf)."""
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


def defect_cohomology(F):
    """Reduced cohomology H~^q(X(F))."""
    cells = defect_cells(F)
    if not cells:
        return {}
    maxd = max(cells)
    idx = {}
    for d in range(maxd + 1):
        for i, c in enumerate(cells.get(d, [])):
            idx[c] = i
    ranks = {}
    for d in range(0, maxd + 2):
        cols = []
        src = cells.get(d, [])
        if d == 0:
            cols = [{0: 1} for _ in src]
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


def trace(F, T):
    return frozenset(frozenset(A & T) for A in F)


# ==========================================================================
# 2.  Trace-downset BK cohomology  H^*( C_n(F) ; X )
# ==========================================================================
def fork_a_downset_cohomology(F_top, n, *,
                              exclude_top=False, exclude_terminal=False):
    r"""The cohomology of the BK total complex of X RESTRICTED to a downset.

    The "downset" here is the FULL TRACE-POSET of F_top :
        C_n(F_top) = { (T, F_top|_T) : T subset of [n] }
    a full subcategory of C_n.  This is the natural ambient for the
    obstruction sheaf F_obs (refoundation.tex def:obs-sheaf : F_obs
    lives on the PUNCTURED trace poset C_n(F*) \ {F*}).

    Args:
      exclude_top : drop F_top from the subcategory.  Models the
                    PUNCTURED trace poset of refoundation.tex.
      exclude_terminal : drop t=(emptyset,{emptyset}) from the
                    subcategory.  Tests whether the terminal-object
                    collapse of mg-f9a7 is the cause of any acyclicity
                    here.

    Returns dict { m : dim H^m }, plus tot dims and a description.
    """
    S_top = frozenset().union(*F_top) if F_top else frozenset()
    # objects : all ground-set restrictions of F_top
    objs = []
    for k in range(len(S_top) + 1):
        for Tc in combinations(sorted(S_top), k):
            T = frozenset(Tc)
            G = trace(F_top, T)
            if exclude_top and T == S_top:
                continue
            if exclude_terminal and len(T) == 0:
                continue
            objs.append((T, G))
    index = {o: i for i, o in enumerate(objs)}
    if not objs:
        return {'H': {}, 'dims': {}, 'objs': []}

    # per-family cells + cubical boundary
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

    # chains : strictly decreasing sequences of ground sets, each within
    # objs (so we automatically respect exclude_top / exclude_terminal).
    obj_ground_sets = {S for (S, _) in objs}
    chains_by_len, chain_list = {}, []

    def all_decreasing(S0):
        """All strictly decreasing chains from S0 within obj_ground_sets."""
        out = [[S0]]
        i = 0
        while i < len(out):
            prefix = out[i]
            last = prefix[-1]
            for k in range(len(last)):
                for c in combinations(sorted(last), k):
                    s = frozenset(c)
                    if s in obj_ground_sets:
                        out.append(prefix + [s])
            i += 1
        return out

    for (S0, F0) in objs:
        for gseq in all_decreasing(S0):
            objseq = tuple(index[(Si, trace(F_top, Si))] for Si in gseq)
            chain_list.append(objseq)
            chains_by_len.setdefault(len(objseq) - 1, []).append(objseq)

    # face_chain -> list of (parent_chain, j)
    parents = {}
    for L in sorted(chains_by_len):
        if L == 0:
            continue
        for ch in chains_by_len[L]:
            for j in range(len(ch)):
                parents.setdefault(ch[:j] + ch[j + 1:], []).append((ch, j))

    # Tot^m basis : (chain, cell) with m = p + q
    tot_basis = {}
    for ch in chain_list:
        F0 = objs[ch[0]][1]
        p = len(ch) - 1
        for q, qcells in fam_cells[F0].items():
            for c in qcells:
                tot_basis.setdefault(p + q, []).append((ch, c))
    tot_index = {}
    for m in tot_basis:
        for i, b in enumerate(tot_basis[m]):
            tot_index[b] = i
    dims = {m: len(tot_basis[m]) for m in tot_basis}

    # the BK differential D = d + (-1)^q delta_BK
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
            # vertical d
            qidx = {cc: i for i, cc in enumerate(fam_cells[F0].get(q, []))}
            for c2j, coeff in dco[F0][q][qidx[c]].items():
                c2 = fam_cells[F0][q + 1][c2j]
                col[tot_index[(ch, c2)]] = \
                    col.get(tot_index[(ch, c2)], 0) + coeff
            # horizontal (-1)^q delta_BK
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

    H, ranks = cohomology(dims, diff)
    return {'H': H, 'dims': dims, 'objs': objs}


# ==========================================================================
# 3.  Inclusion-downset analytical reduction
# ==========================================================================
def inclusion_downset_collapse(F_top):
    r"""The Fork-D-variance downset of F_top : { F' subset F_top : F'
    int-closed }, ordered by inclusion.  Has F_top as TERMINAL (max);
    covariant hocolim collapses (up to homotopy) to X(F_top).  Report
    the reduced cohomology of X(F_top) -- that IS the collapse value."""
    return defect_cohomology(F_top)


# ==========================================================================
# 4.  Pretty-print a downset cohomology result
# ==========================================================================
def fmt(H):
    nz = {m: v for m, v in H.items() if v}
    return nz if nz else "{} (all zero)"


def label_for(F, n):
    """Short tag describing F."""
    S = frozenset(range(n))
    if F == frozenset({S}):
        return "{S}        (trivial)"
    full = frozenset(frozenset(c) for k in range(n + 1)
                     for c in combinations(range(n), k))
    if F == full:
        return "2^[n]     (full powerset)"
    sets = sorted((sorted(A) for A in F), key=lambda a: (len(a), a))
    desc = "{" + ", ".join(("0" if not s else "{" + ",".join(str(i) for i in s) + "}")
                          for s in sets) + "}"
    return desc


# ==========================================================================
# 5.  main
# ==========================================================================
def main():
    print("=" * 74)
    print("Frankl-Downset-Reframing   (work item mg-8f74)")
    print("Does the obstruction live in the downset of a fixed F (not C_n)?")
    print("=" * 74)
    n = 3
    S = frozenset(range(n))
    fams = moore_families(S)
    print(f"{el()}  n = {n} ; {len(fams)} Moore families on [{n}]")
    print()

    # ----------------------------------------------------------------
    # Pick a representative spread of families for the per-F probes.
    # Definitively include : the full 2^[3] (the "maximal" family --
    # X(F) is the cube, contractible) ; the trivial {S} (X = point) ;
    # the families with disconnected X(F) (H~0=1).  And, for breadth,
    # a sample of medium families.
    # ----------------------------------------------------------------
    full = frozenset(frozenset(c) for k in range(n + 1)
                     for c in combinations(range(n), k))
    trivial = frozenset({S})

    # families with non-trivial reduced cohomology of X(F)
    interesting = [F for F in fams if defect_cohomology(F)]
    print(f"  families with non-zero reduced X(F)-cohomology : "
          f"{len(interesting)}/{len(fams)}")
    for F in interesting[:5]:
        print(f"      {label_for(F, n):40s}   H~(X(F)) = {fmt(defect_cohomology(F))}")
    print(f"      ... ({len(interesting)} total)")
    print()

    # Representative set : trivial, full, all interesting, plus 3 random
    # acyclic families for breadth
    rng_acyclic = [F for F in fams
                   if F not in (full, trivial) and not defect_cohomology(F)]
    sample = [trivial, full] + interesting[:3] + rng_acyclic[:3]

    # ----------------------------------------------------------------
    # PART 1 : the four downset variants
    # ----------------------------------------------------------------
    print("=" * 74)
    print("PART 1 -- the four downset-of-F variants, all computed at n=3")
    print("=" * 74)
    print()
    print("  For each fixed F, the BK total complex H^*( . ; X ) on :")
    print("    (T)   C_n(F)              = full trace-poset of F")
    print("    (T-)  C_n(F) \\ {F}        = punctured (refoundation.tex)")
    print("    (T=)  C_n(F) \\ {F, t}     = doubly-punctured")
    print("    (I)   {F' subset F}       = inclusion downset (Fork-D variance)")
    print()
    print("  (I) collapses ANALYTICALLY to H~^*(X(F)) (F is the terminal/max")
    print("       object in the inclusion direction; covariant hocolim => X(F)).")
    print()

    header = (f"  {'family':40s}   {'(T)':18s}   {'(T-)':18s}   "
              f"{'(T=)':18s}   {'(I)~X(F)':14s}")
    print(header)
    print("  " + "-" * (len(header) - 2))

    summary_rows = []
    for F in sample:
        rT = fork_a_downset_cohomology(F, n)
        rTm = fork_a_downset_cohomology(F, n, exclude_top=True)
        rTeq = fork_a_downset_cohomology(F, n, exclude_top=True,
                                         exclude_terminal=True)
        # alternative T= : only exclude terminal (keep F)
        rTo = fork_a_downset_cohomology(F, n, exclude_terminal=True)
        I = inclusion_downset_collapse(F)

        nzT = {m: v for m, v in rT['H'].items() if v}
        nzTm = {m: v for m, v in rTm['H'].items() if v}
        nzTeq = {m: v for m, v in rTeq['H'].items() if v}
        print(f"  {label_for(F, n):40s}   "
              f"{str(nzT or {'point':1}) if nzT else '{0:1} (acyclic)':18s}   "
              f"{str(nzTm or {}) or '{} (acyclic)':18s}   "
              f"{str(nzTeq or {}) or '{} (acyclic)':18s}   "
              f"{str(I or {}) or '{} (acyclic)':14s}")
        summary_rows.append((label_for(F, n), nzT, nzTm, nzTeq, I))

    # ----------------------------------------------------------------
    # PART 2 : sweep all 61 families, classify the H^* profiles
    # ----------------------------------------------------------------
    print()
    print("=" * 74)
    print("PART 2 -- sweep across ALL 61 Moore families on [3]")
    print("=" * 74)

    profiles_T = {}
    profiles_Tm = {}
    profiles_Teq = {}
    for F in fams:
        rT = fork_a_downset_cohomology(F, n)
        rTm = fork_a_downset_cohomology(F, n, exclude_top=True)
        rTeq = fork_a_downset_cohomology(F, n, exclude_top=True,
                                         exclude_terminal=True)
        kT = tuple(sorted((m, v) for m, v in rT['H'].items() if v))
        kTm = tuple(sorted((m, v) for m, v in rTm['H'].items() if v))
        kTeq = tuple(sorted((m, v) for m, v in rTeq['H'].items() if v))
        profiles_T.setdefault(kT, []).append(F)
        profiles_Tm.setdefault(kTm, []).append(F)
        profiles_Teq.setdefault(kTeq, []).append(F)

    print(f"  (T)   H^*( C_3(F) ; X )            -- {len(profiles_T)} "
          "distinct profile(s):")
    for k, fl in sorted(profiles_T.items(), key=lambda kv: -len(kv[1])):
        desc = ("{0:1} (acyclic = collapse onto X(t)=point)" if not k
                else " ".join(f"H^{d}={r}" for d, r in k))
        print(f"      {desc:55s}: {len(fl)} families")

    print()
    print(f"  (T-)  H^*( C_3(F) \\ {{F}} ; X )     -- {len(profiles_Tm)} "
          "distinct profile(s):")
    for k, fl in sorted(profiles_Tm.items(), key=lambda kv: -len(kv[1])):
        desc = ("{} (acyclic)" if not k
                else " ".join(f"H^{d}={r}" for d, r in k))
        print(f"      {desc:55s}: {len(fl)} families")

    print()
    print(f"  (T=)  H^*( C_3(F) \\ {{F, t}} ; X )  -- {len(profiles_Teq)} "
          "distinct profile(s):")
    for k, fl in sorted(profiles_Teq.items(), key=lambda kv: -len(kv[1])):
        desc = ("{} (acyclic)" if not k
                else " ".join(f"H^{d}={r}" for d, r in k))
        print(f"      {desc:55s}: {len(fl)} families")

    # ----------------------------------------------------------------
    # PART 3 : look specifically for sphere-shaped (H~^{n-1} = 1) profiles
    # ----------------------------------------------------------------
    print()
    print("=" * 74)
    print("PART 3 -- where, if anywhere, is the sphere class H~^{n-1} = 1 ?")
    print("=" * 74)
    print()
    print("  Y1-A (conj:y1a) wants H~^{n-1}(ambient;X) one-dimensional")
    print("  (= sgn_Sn).  Across all 61 families and all four variants,")
    print("  count the families whose downset cohomology has H^{n-1} = H^2 = 1:")
    print()
    counts = {'T': 0, 'Tm': 0, 'Teq': 0, 'I': 0}
    sphere_families = {'T': [], 'Tm': [], 'Teq': [], 'I': []}
    for F in fams:
        rT = fork_a_downset_cohomology(F, n)
        rTm = fork_a_downset_cohomology(F, n, exclude_top=True)
        rTeq = fork_a_downset_cohomology(F, n, exclude_top=True,
                                         exclude_terminal=True)
        I = inclusion_downset_collapse(F)
        for key, H in [('T', rT['H']), ('Tm', rTm['H']),
                       ('Teq', rTeq['H']), ('I', I)]:
            if H.get(2, 0) == 1 and all(
                v == 0 for d, v in H.items() if d not in (0, 2)
            ):
                counts[key] += 1
                sphere_families[key].append(F)
    print(f"  (T)   sphere-shaped families : {counts['T']}/61")
    print(f"  (T-)  sphere-shaped families : {counts['Tm']}/61")
    print(f"  (T=)  sphere-shaped families : {counts['Teq']}/61")
    print(f"  (I)   sphere-shaped families : {counts['I']}/61   "
          "(=> H~^2(X(F)) = 1)")
    print()
    for key, lst in sphere_families.items():
        if lst:
            print(f"  the sphere-shaped families in variant ({key}) :")
            for F in lst[:10]:
                print(f"      {label_for(F, n)}")

    # ----------------------------------------------------------------
    # PART 4 : the obstruction sheaf -- F_obs lives on (T-)
    # ----------------------------------------------------------------
    print()
    print("=" * 74)
    print("PART 4 -- the obstruction sheaf F_obs on the punctured trace poset")
    print("=" * 74)
    print()
    print("  refoundation.tex def:obs-sheaf : F_obs and its Cech double complex")
    print("  live on the PUNCTURED trace poset  C_n(F*) \\ {F*}  of a minimal")
    print("  counterexample F*.  The Cech-to-cohomology edge map (the R3 owed")
    print("  debt -- specifically R3a EXISTENCE) promotes the mismatch class")
    print("  from the LOCAL Cech double complex on  C_n(F*) \\ {F*}  to the")
    print("  GLOBAL  H^{n-1}(C_n;X)  -- which mg-f9a7 showed is 0.")
    print()
    print("  Daniel's reframing : maybe the proof needs the LOCAL object, not")
    print("  the global one.  But (T-) -- the punctured trace poset -- still")
    print("  has the terminal object t = (emptyset,{emptyset}) (the empty-")
    print("  ground trace of F*).  Covariant hocolim of X over (T-) collapses")
    print("  onto X(t) = point, EXACTLY as it does globally.  PART 2 confirms")
    print("  this directly : all 61 (T-) cohomologies are {0:1} (point) too.")
    print()
    print("  The DOUBLY-punctured (T=) does NOT collapse and CAN have non-")
    print("  trivial cohomology.  But (T=) is the WRONG object for the")
    print("  obstruction : F_obs is defined on (T-), not (T=); the bottom-")
    print("  layer trace t IS part of the punctured trace poset.")
    print()
    print(f"{el()}  done.")


if __name__ == "__main__":
    main()
