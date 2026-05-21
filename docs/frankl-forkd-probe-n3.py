#!/usr/bin/env python3
"""
Frankl-ForkD-Probe : bounded n=3 probe of the Moore-family-lattice cohomology.

Work item mg-565a.  Per the mg-6edc Frankl-Vision-Check verdict (Fork D).

QUESTION.  Is the category of intersection-closed families on a 3-element
ground set, ordered by INCLUSION (the Moore-family lattice), genuinely
   (a) non-trivial, and
   (b) family-sensitive
in its own nerve / order-complex cohomology?

This script computes, from scratch and reproducibly:
  PART A  the Moore-family lattice on [3] and the cohomology of its
          order complex (whole lattice, and proper part), with the
          S_3-action decomposed into irreducibles;
  PART B  the per-family poset cohomology (the "sphere natively present"
          object of the vision-check), for every Moore family;
  PART C  the lattice intervals (0^,F) and (F,1^) for every family F;
  PART D  the Frankl data (biases, rare coordinates, the rare-coordinate
          cover {U_x}) and the obstruction mechanism.

All homology is reduced, over Q, computed via sparse modular rank at two
independent primes (cross-checked).  No external dependencies.
"""

from itertools import combinations

# --------------------------------------------------------------------------
# 0.  Ground set and subsets
# --------------------------------------------------------------------------
N = 3
GROUND = frozenset(range(N))
SUBSETS = [frozenset(c) for k in range(N + 1) for c in combinations(range(N), k)]
# 8 subsets of [3]


def show_set(s):
    return "{" + ",".join(str(i + 1) for i in sorted(s)) + "}" if s else "0"


def show_fam(F):
    return "[" + " ".join(show_set(s) for s in sorted(F, key=lambda x: (len(x), sorted(x)))) + "]"


# --------------------------------------------------------------------------
# 1.  Enumerate Moore families (intersection-closed, contain [n])
# --------------------------------------------------------------------------
def is_int_closed(F):
    Fs = set(F)
    for a in Fs:
        for b in Fs:
            if (a & b) not in Fs:
                return False
    return True


OTHERS = [s for s in SUBSETS if s != GROUND]  # 7 proper subsets
MOORE = []
for r in range(len(OTHERS) + 1):
    for combo in combinations(OTHERS, r):
        F = frozenset(combo) | {GROUND}
        if is_int_closed(F):
            MOORE.append(F)
MOORE.sort(key=lambda F: (len(F), sorted(sorted(s) for s in F)))
print(f"PART 0 -- Moore families on [{N}] (intersection-closed, contain [n])")
print(f"  count = {len(MOORE)}   (expected 61 for n=3)")
# every Moore family has union = [n] automatically since [n] in F
assert all(frozenset().union(*F) == GROUND for F in MOORE)
print(f"  all 61 have union = [n]  : OK")

IDX = {F: i for i, F in enumerate(MOORE)}
M = len(MOORE)


# --------------------------------------------------------------------------
# 2.  The lattice : order = family-inclusion  F <= G  iff  F subset of G
# --------------------------------------------------------------------------
def leq(F, G):
    return F <= G  # frozenset subset


BOTTOM = min(MOORE, key=len)
TOP = max(MOORE, key=len)
print()
print("PART A -- the Moore-family lattice (Poset B)")
print(f"  bottom 0^ = {show_fam(BOTTOM)}   (the trivial family, excluded by Frankl_Holds)")
print(f"  top    1^ = {show_fam(TOP)}   (= 2^[n], the full powerset)")
assert all(leq(BOTTOM, F) and leq(F, TOP) for F in MOORE)
print("  every family lies between 0^ and 1^  : OK  ->  bounded lattice")

# verify it is a lattice : meet = intersection of families (always Moore);
# join = closure of union.  (meet of two Moore families is intersection-closed
# and contains [n], so is Moore -> a meet-semilattice with top -> a lattice.)
ok_meet = True
for i in range(M):
    for j in range(i + 1, M):
        mt = MOORE[i] & MOORE[j]
        if mt not in IDX:
            ok_meet = False
print(f"  pairwise meets (family intersection) all Moore : {ok_meet}  -> genuine lattice")


# --------------------------------------------------------------------------
# Generic order-complex homology machinery
# --------------------------------------------------------------------------
def chains_of(elements, leq_fn):
    """All non-empty chains (totally ordered subsets) of a poset, as tuples
    sorted by the order.  Returns dict: dim -> list of chains."""
    elems = list(elements)
    # comparability: strict <
    lt = {e: [] for e in elems}
    for a in elems:
        for b in elems:
            if a is not b and leq_fn(a, b) and a != b:
                lt[a].append(b)
    chains = {}
    # DFS extending chains upward
    stack = [(e,) for e in elems]
    while stack:
        ch = stack.pop()
        d = len(ch) - 1
        chains.setdefault(d, []).append(ch)
        last = ch[-1]
        for nxt in lt[last]:
            stack.append(ch + (nxt,))
    return chains


def reduced_betti(chains, primes=(2147483647, 2147483629)):
    """Reduced simplicial homology Betti numbers over Q of the order complex,
    via sparse modular rank at two primes (cross-checked)."""
    if not chains:
        return {}  # empty complex
    maxd = max(chains)
    # index simplices
    simp_index = []
    for d in range(maxd + 1):
        simp_index.append({c: i for i, c in enumerate(chains.get(d, []))})

    def boundary_rank(d, p):
        """rank mod p of boundary  C_d -> C_{d-1}  (d>=1), or augmentation d=0."""
        cols = chains.get(d, [])
        if not cols:
            return 0
        # build sparse columns: list of dict{row: coeff}
        sparse = []
        if d == 0:
            for _ in cols:
                sparse.append({0: 1})  # augmentation to the (-1) empty simplex
        else:
            for c in cols:
                col = {}
                for k in range(len(c)):
                    face = c[:k] + c[k + 1:]
                    col[simp_index[d - 1][face]] = (-1) ** k
                sparse.append(col)
        return sparse_rank(sparse, p)

    betti = {}
    for primecheck in range(2):
        p = primes[primecheck]
        ranks = {}
        for d in range(0, maxd + 2):
            ranks[d] = boundary_rank(d, p)
        b = {}
        # reduced: C_{-1}=Q.  betti_{-1} = 1 - rank d0   (should be 0)
        for d in range(0, maxd + 1):
            dimCd = len(chains.get(d, []))
            b[d] = dimCd - ranks.get(d, 0) - ranks.get(d + 1, 0)
        bm1 = 1 - ranks.get(0, 0)
        b[-1] = bm1
        if primecheck == 0:
            betti = b
        else:
            assert b == betti, f"prime cross-check FAILED: {betti} vs {b}"
    return betti


def sparse_rank(columns, p):
    """Rank mod p of a sparse matrix given as list of columns (dict row->val)."""
    cols = [dict(c) for c in columns if c]
    rank = 0
    pivot_row_to_col = {}
    for col in cols:
        col = {r: v % p for r, v in col.items()}
        col = {r: v for r, v in col.items() if v != 0}
        while col:
            r = max(col)  # pivot on largest row index present
            if r in pivot_row_to_col:
                pv = pivot_row_to_col[r]
                factor = (col[r] * pow(pv[r], p - 2, p)) % p
                for rr, vv in pv.items():
                    col[rr] = (col.get(rr, 0) - factor * vv) % p
                col = {rr: vv for rr, vv in col.items() if vv != 0}
            else:
                pivot_row_to_col[r] = col
                rank += 1
                break
    return rank


def euler_reduced(chains):
    """Reduced Euler characteristic of the order complex."""
    chi = -1  # the empty simplex
    for d, lst in chains.items():
        chi += (-1) ** d * len(lst)
    return chi


# --------------------------------------------------------------------------
# A1.  Whole lattice -- order complex is a cone (has 0^ and 1^) : contractible
# --------------------------------------------------------------------------
ch_whole = chains_of(MOORE, leq)
b_whole = reduced_betti(ch_whole)
nz_whole = {d: r for d, r in b_whole.items() if r != 0}
print()
print("A1.  Order complex of the WHOLE lattice (61 elements):")
print(f"     reduced Betti numbers : {nz_whole if nz_whole else 'ALL ZERO'}")
print(f"     -> contractible (cone on 0^ or 1^), as expected.  The naive")
print(f"        'cohomology of the category' is TRIVIAL.  Must puncture.")

# --------------------------------------------------------------------------
# A2.  Proper part  P-bar = lattice minus {0^, 1^}  (59 elements)
# --------------------------------------------------------------------------
PBAR = [F for F in MOORE if F != BOTTOM and F != TOP]
ch_pbar = chains_of(PBAR, leq)
b_pbar = reduced_betti(ch_pbar)
nz_pbar = {d: r for d, r in b_pbar.items() if r != 0}
print()
print(f"A2.  Order complex of the PROPER PART P-bar ({len(PBAR)} elements):")
maxd = max(ch_pbar)
print(f"     simplex counts by dim : "
      + ", ".join(f"d{d}:{len(ch_pbar.get(d,[]))}" for d in range(maxd + 1)))
print(f"     reduced Betti numbers : {nz_pbar if nz_pbar else 'ALL ZERO'}")
print(f"     reduced Euler char    : {euler_reduced(ch_pbar)}  "
      f"(= Mobius mu(0^,1^) of the lattice)")
total_rank = sum(nz_pbar.values())
if len(nz_pbar) == 1 and total_rank == 1:
    d0 = list(nz_pbar)[0]
    print(f"     => SPHERICAL : homology of a single sphere S^{d0}")
elif len(nz_pbar) == 1:
    d0 = list(nz_pbar)[0]
    print(f"     => wedge of {total_rank} spheres S^{d0} (concentrated, rank>1)")
elif not nz_pbar:
    print(f"     => CONTRACTIBLE proper part : the U1 wall realised.")
else:
    print(f"     => NOT concentrated : homology spread over degrees.")

# --------------------------------------------------------------------------
# A3.  S_3 action on H~(P-bar) : virtual character via fixed subposets
# --------------------------------------------------------------------------
def perm_apply(g, F):
    return frozenset(frozenset(g[i] for i in A) for A in F)


# representatives of the 3 conjugacy classes of S_3
PERMS = {
    "e         (identity)": {0: 0, 1: 1, 2: 2},
    "(12)      (transposition)": {0: 1, 1: 0, 2: 2},
    "(123)     (3-cycle)": {0: 1, 1: 2, 2: 0},
}
print()
print("A3.  S_3-action on the proper part  (S_3 permutes the ground set [3]):")
virt = {}
for name, g in PERMS.items():
    fixed = [F for F in PBAR if perm_apply(g, F) == F]
    chf = chains_of(fixed, leq)
    chi = euler_reduced(chf) if chf else -1
    virt[name] = chi
    print(f"     g = {name:30s}: |P-bar^g| = {len(fixed):2d}, "
          f"chi~(Delta(P-bar^g)) = {chi}")

Ve = virt["e         (identity)"]
Vt = virt["(12)      (transposition)"]
Vc = virt["(123)     (3-cycle)"]
# virtual character V(g) = sum (-1)^k tr(g|H~_k)  =  chi~(P-bar^g)   (Hopf trace)
# S_3 character table on (e, transp, 3cyc):  triv=(1,1,1) sign=(1,-1,1) std=(2,0,-1)
a_triv = (Ve * 1 + 3 * Vt * 1 + 2 * Vc * 1) / 6
a_sign = (Ve * 1 + 3 * Vt * (-1) + 2 * Vc * 1) / 6
a_std = (Ve * 2 + 3 * Vt * 0 + 2 * Vc * (-1)) / 6
print(f"     virtual character V = sum_k (-1)^k [H~_k]  =  ({Ve}, {Vt}, {Vc})  "
      f"on (e,(12),(123))")
print(f"     decomposes as  {a_triv:+g}*triv  {a_sign:+g}*sign  {a_std:+g}*std")
if nz_pbar and len(nz_pbar) == 1:
    d0 = list(nz_pbar)[0]
    sgn = (-1) ** d0
    print(f"     homology concentrated in degree {d0}; actual H~_{d0} character "
          f"= {sgn}*V")
    print(f"     => H~_{d0}(Delta(P-bar)) decomposes as "
          f"{sgn*a_triv:+g}*triv {sgn*a_sign:+g}*sign {sgn*a_std:+g}*std")

# --------------------------------------------------------------------------
# PART D.  Frankl data : biases, rare coordinates, the cover {U_x}
# --------------------------------------------------------------------------
def beta(x, F):
    inc = sum(1 for A in F if x in A)
    exc = sum(1 for A in F if x not in A)
    return inc - exc  # rare  iff  beta <= 0


print()
print("PART D -- Frankl data on the 61 Moore families")
rare_count = 0
no_rare = []
for F in MOORE:
    if F == BOTTOM:
        continue  # trivial family excluded
    rares = [x for x in range(N) if beta(x, F) <= 0]
    if rares:
        rare_count += 1
    else:
        no_rare.append(F)
print(f"  non-trivial families                       : {M-1}")
print(f"  ... with at least one rare coord (beta<=0)  : {rare_count}")
print(f"  ... with NO rare coordinate (counterexample): {len(no_rare)}")
print(f"  => Frankl holds at n=3 : {len(no_rare)==0}")

# the rare-coordinate cover  U_x = { F : beta_x(F) <= 0 }
print()
print("  rare-coordinate cover  U_x = {F : beta_x(F) <= 0}  of the lattice:")
for x in range(N):
    Ux = [F for F in MOORE if F != BOTTOM and beta(x, F) <= 0]
    print(f"     |U_{x+1}| = {len(Ux)}")
covered = set()
for x in range(N):
    for F in MOORE:
        if F != BOTTOM and beta(x, F) <= 0:
            covered.add(F)
allnt = set(F for F in MOORE if F != BOTTOM)
print(f"  U_1 u U_2 u U_3 covers all {len(allnt)} non-trivial families : "
      f"{covered == allnt}")

# --------------------------------------------------------------------------
# PART B.  Per-family poset cohomology  (Poset A : a family as poset of its
#          own member sets) -- the "sphere natively present" object.
# --------------------------------------------------------------------------
print()
print("PART B -- per-family cohomology (family viewed as poset of member sets)")
print("  For each Moore family F, the punctured poset (F minus {0,[n]}, subseteq):")
profile = {}
for F in MOORE:
    inner = [A for A in F if A != GROUND and len(A) > 0]
    chB = chains_of(inner, lambda a, b: a <= b)
    bB = reduced_betti(chB) if chB else {-1: 1}
    nz = tuple(sorted((d, r) for d, r in bB.items() if r != 0))
    profile.setdefault(nz, []).append(F)
for nz, fams in sorted(profile.items(), key=lambda kv: -len(kv[1])):
    desc = "contractible/acyclic" if not nz else " ".join(f"H~{d}={r}" for d, r in nz)
    print(f"     {desc:32s}: {len(fams)} families")
print("  -> the per-family homotopy type VARIES across families:")
print(f"     {len(profile)} distinct reduced-homology profiles among 61 families.")

# does the per-family profile correlate with the bias vector?
print()
print("  family-sensitivity check : per-family homology vs rare-coordinate set")
sens = {}
for F in MOORE:
    if F == BOTTOM:
        continue
    inner = [A for A in F if A != GROUND and len(A) > 0]
    chB = chains_of(inner, lambda a, b: a <= b)
    bB = reduced_betti(chB) if chB else {-1: 1}
    homrank = sum(r for d, r in bB.items() if r != 0)
    nrares = sum(1 for x in range(N) if beta(x, F) <= 0)
    sens.setdefault(nrares, []).append(homrank)
for nr in sorted(sens):
    rs = sens[nr]
    print(f"     families with {nr} rare coord(s): per-family reduced-homology "
          f"rank ranges {min(rs)}..{max(rs)}  (n={len(rs)})")

# --------------------------------------------------------------------------
# PART C.  Lattice intervals (0^,F) and (F,1^) -- where an obstruction class
#          for family F would live in the Fork-D / lattice picture.
# --------------------------------------------------------------------------
print()
print("PART C -- lattice open intervals (0^,F) : the Fork-D obstruction home")
int_profile = {}
for F in MOORE:
    below = [G for G in MOORE if G != BOTTOM and G != F and leq(G, F)]
    chI = chains_of(below, leq)
    bI = reduced_betti(chI) if chI else {-1: 1}
    nz = tuple(sorted((d, r) for d, r in bI.items() if r != 0))
    int_profile.setdefault(nz, []).append((F, len(below)))
for nz, fams in sorted(int_profile.items(), key=lambda kv: -len(kv[1])):
    desc = "contractible/acyclic" if not nz else " ".join(f"H~{d}={r}" for d, r in nz)
    sizes = sorted(set(s for _, s in fams))
    print(f"     (0^,F) {desc:28s}: {len(fams)} families  "
          f"(interval sizes {sizes[:6]}{'...' if len(sizes)>6 else ''})")
print(f"  -> {len(int_profile)} distinct interval-homology profiles among 61 families.")

print()
print("=" * 68)
print("ROBUSTNESS SUITE -- self-test, n=2 control, convention variants")
print("=" * 68)

# --- self-test : the punctured Boolean cube 2^[m] \ {0,[m]} must be S^{m-2}
print()
print("R1.  self-test : order complex of punctured Boolean cube 2^[m]\\{0,[m]}")
for m in (3, 4):
    cube = [frozenset(c) for k in range(m + 1) for c in combinations(range(m), k)]
    punct = [s for s in cube if 0 < len(s) < m]
    chC = chains_of(punct, lambda a, b: a <= b)
    bC = reduced_betti(chC)
    nz = {d: r for d, r in bC.items() if r != 0}
    exp = {m - 2: 1}
    print(f"     m={m}: reduced Betti {nz}   expected S^{m-2} i.e. {exp}   "
          f"{'OK' if nz == exp else 'FAIL'}")

# the n=3 punctured Boolean cube is the per-family poset of the full powerset
# F = 2^[3] (the lattice TOP) -- confirm its sphere carries sgn_{S_3}.
cube3 = [frozenset(c) for k in range(4) for c in combinations(range(3), k)]
punct3 = [s for s in cube3 if 0 < len(s) < 3]
vBC = {}
for name, g in PERMS.items():
    fx = [s for s in punct3 if frozenset(g[i] for i in s) == s]
    chx = chains_of(fx, lambda a, b: a <= b)
    vBC[name] = euler_reduced(chx) if chx else -1
ve, vt, vc = (vBC["e         (identity)"], vBC["(12)      (transposition)"],
              vBC["(123)     (3-cycle)"])
# concentrated in degree 1 -> actual character = -1 * virtual character
ce, ct, cc = -ve, -vt, -vc
s_tr = (ce + 3 * ct + 2 * cc) // 6
s_sg = (ce - 3 * ct + 2 * cc) // 6
s_st = (2 * ce - 2 * cc) // 6
print(f"     per-family sphere of F=2^[3]: H~1 character ({ce},{ct},{cc}) "
      f"= {s_tr}*triv {s_sg:+d}*sign {s_st:+d}*std   "
      f"{'(= sgn_S3, as UC9 D-4)' if (s_tr,s_sg,s_st)==(0,1,0) else ''}")


def moore_lattice(m, require_empty=False):
    g = frozenset(range(m))
    subs = [frozenset(c) for k in range(m + 1) for c in combinations(range(m), k)]
    oth = [s for s in subs if s != g]
    fams = []
    for r in range(len(oth) + 1):
        for combo in combinations(oth, r):
            F = frozenset(combo) | {g}
            if require_empty and frozenset() not in F:
                continue
            if is_int_closed(F):
                fams.append(F)
    return fams


def probe_lattice(label, fams):
    bot = min(fams, key=len)
    top = max(fams, key=len)
    pbar = [F for F in fams if F != bot and F != top]
    ch = chains_of(pbar, lambda a, b: a <= b)
    b = reduced_betti(ch) if ch else {-1: 1}
    nz = {d: r for d, r in b.items() if r != 0}
    chi = euler_reduced(ch) if ch else -1
    print(f"     {label}")
    print(f"        |lattice| = {len(fams)}, |proper part| = {len(pbar)}")
    print(f"        reduced Betti of proper-part order complex : "
          f"{nz if nz else 'ALL ZERO  -> Q-ACYCLIC'}")
    print(f"        reduced Euler char / Mobius mu(0^,1^)      : {chi}")
    return nz


print()
print("R2.  n=2 control : Moore-family lattice on [2]")
probe_lattice("n=2, UC10 convention (contain [n])", moore_lattice(2))

print()
print("R3.  convention variants at n=3")
probe_lattice("n=3, UC10 convention (contain [n] only)      ", moore_lattice(3))
probe_lattice("n=3, variant: also require 0 in F (contain 0,[n])",
              moore_lattice(3, require_empty=True))

print()
print("Note on rigour: Q-Betti(k) <= mod-p-Betti(k) for every prime p, so a")
print("single prime returning 0 already PROVES Q-acyclicity; the script")
print("cross-checks two independent ~2^31 primes, and they agree.")
print()
print("=== END OF PROBE COMPUTATION ===")
