# Frankl-Cohomology-Synthesis — the consolidated answer

**Work item:** `mg-5cc6` (Frankl-Cohomology-Synthesis). Per Daniel's
reminder of 2026-05-22:

> *"spherical or not I need a clear answer: what is the cohomology of
> all sub-intersection families of a given family? Which I assume we
> should start with looking at the whole category? Then can that be
> useful in the proof and if not why."*

This document is the **single consolidated synthesis** of every
cohomology computation the Frankl arc has performed. It draws only on
the five Phase-0 probe results already in hand (no new computations);
its job is to put them on one page so the answer to Daniel's question
can be read directly.

**READ-FIRST consumed:** `docs/Frankl-ForkD-Probe-n3.md` (`mg-565a`);
`docs/Frankl-ForkA-Phase0-FaithfulnessProbe.md` (`mg-f9a7`);
`docs/Frankl-ForkA-Fobs-SS-Pinning.md` (`mg-02b5`);
`docs/Frankl-Downset-Reframing.md` (`mg-8f74`);
`docs/Frankl-Spherical-Reconcile.md` (`mg-7bf3`);
`paper/forkA/refoundation.tex` (`thm:contradiction` at L1661,
`conj:y1a` at L1361, `def:bk` at L709, `def:ob` at L1122,
`prop:fact-one` at L1181, `debt:faithful-localized`,
`rem:hocolim-flag` at L800, `rem:wrapper`).

**Scope.** Synthesis only. No new computations. Deliverable: this
document.

---

## §0 — The clear answer, in two paragraphs

> **What IS the cohomology of all sub-intersection families of a given
> family?** Eleven natural realisations of the question have been
> computed at `n = 3`. They split cleanly into two regimes. (A) Every
> realisation that **integrates over the whole category** — bare nerve
> of the Moore lattice, covariant hocolim of `X` over the trace
> category `C_n`, every variant of the trace-downset `C_n(F)`, the
> inclusion-direction downset, the homotopy *limit*, the
> terminal-excluded subcategory at both flavours, the
> Moore-lattice-with-`π_0(X)`-coefficients — is either rationally
> acyclic or non-trivial in the **wrong** degree / dimension /
> isotype. **Zero of the eleven category-integrated realisations
> carries a one-dimensional `sgn_{S_n}` class in degree `n - 1`.** (B)
> Per-family content **does** carry the F-series sphere — `X(F)` (the
> cubical-defect complex) is family-sensitive across all 61 Moore
> families on `[3]`; and the maximal family `2^[3]` viewed as the
> inclusion poset of its own member sets is `≃ S^1` with `H̃^1 ≅
> sgn_{S_3}` exactly. The sphere class the Frankl programme wants
> lives **per-family**, never as an invariant of the category.
>
> **Can any of these cohomologies be useful for the Frankl two-part
> contradiction?** **No** — not in the form `refoundation.tex`'s
> `thm:contradiction` requires. The contradiction needs an obstruction
> class `ob(F⋆) ∈ H̃^{n-1}(C_n; X)` that is (1) **non-zero** and (2)
> the unique `sgn_{S_n}` class of a one-dimensional ambient. Every
> category-integrated cohomology computed fails gate (1) (the ambient
> is the zero group, or has no degree-`(n-1)` class) and a fortiori
> gate (2). The per-family sphere `X(2^[n])` clears (1) and (2) but is
> attached to **one** element of the category, not to the category, so
> it cannot host a class that depends on a *minimal counterexample
> F⋆* — the contradiction's logical subject. Daniel's spirit-of-the-
> question (can the per-family X(F) sphericality drive a contradiction
> *without* integrating over a category?) is answered: it is the right
> place for content but the wrong place for the obstruction class —
> the obstruction is a *gluing-type* (`rem:hocolim-flag`) invariant
> across the strata `{U_x}` of a fixed F⋆, not a per-family invariant
> of one F. The route is dead at the category level and incomplete at
> the per-family level; no rearrangement of the existing cohomology
> computations produces a Frankl proof.

The rest of this document expands these two paragraphs into the table
and the explicit gate-by-gate diagnosis Daniel asked for.

---

## §1 — Deliverable 1: the consolidated table

### 1.1 The two regimes, kept rigorously apart

The arc has historically conflated two posets / categories which must
be kept apart (`mg-565a` §1.2 / `mg-7bf3` §1.2):

- **Per-family object** — for one fixed family `F`, the inclusion
  poset of its own member sets `(F, ⊆)`, or its cubical-defect
  complex `X(F)` (`def:xf`). There are **61** of these on `[3]`.
- **Category-level object** — a cohomology of the *category* of
  intersection-closed families (or of a sub-category, or a localized
  variant). One of these per choice of variance / morphism class /
  coefficient diagram / sub-poset.

The probe arc computed objects in both regimes. The table below lists
every one, in the form "what cohomology, what `n=3` result, what
isotype, is it non-trivial / family-sensitive / spherical / `sgn`-
bearing." Gate columns use the four properties from the ticket:

- **NT** — *non-trivial* (`H̃^k ≠ 0` for some `k`);
- **FS** — *family-sensitive* (varies across the 61 Moore families);
- **Sph** — *spherical* (`H̃^k = 1` concentrated in a single degree);
- **`sgn`** — that single class carries `sgn_{S_n}`.

The contradiction `thm:contradiction` needs **all four gates** to land
on a single object, with the spherical degree equal to `n - 1` and the
ambient one-dimensional (so that the unique class is forced).

### 1.2 Category-level cohomologies (the "whole category" regime)

| # | Construction | `n=3` result | `S_3` isotype | NT | FS | Sph | `sgn` | `n-1` | Source |
|---|---|---|---|---|---|---|---|---|---|
| C1 | Bare nerve `Δ(MOORE_3)` proper part | `H̃^* = 0` (acyclic; `μ(0̂,1̂) = 0`) | zero virtual char | ✗ | ✗ | ✗ | ✗ | ✗ | `mg-565a` §3 |
| C2 | Fork A covariant hocolim `H^*(C_3; X) = H^*(hocolim_{C_3} X)` (`def:bk`) | `{0: 1}` (a homology point) | `triv` in degree 0 only | ✗ (in `>0`) | ✗ | ✗ | ✗ | ✗ | `mg-f9a7` §2.1 |
| C3 | Cell-level `F_obs` Čech double complex `H^*(Tot Č)` on the punctured trace poset of any F⋆ | `≅ ⊕_{(T,G)∈P} H^*(X(G))` (cell-level direct sum; SS degenerates) | direct sum of per-family characters; carries `sgn` only inside the maximal-family summand | ✗ in the *bicomplex's* own Čech direction (`Č H^{>0} = 0`) | ✓ (depends on F⋆ via the punctured poset) | ✗ as a whole — not concentrated | ✗ | only in pieces, not after promotion | `mg-02b5` §3 |
| C4 | Trace-downset `H^*(C_3(F); X)`, every F | `{0: 1}` for all 61 F | `triv` | ✗ (in `>0`) | ✗ — *same* profile for all 61 | ✗ | ✗ | ✗ | `mg-8f74` §2.1 |
| C5 | Punctured trace-downset `H^*(C_3(F) ∖ {F}; X)` — the **actual** `def:obs-sheaf` ambient | `{0: 1}` for all 61 F | `triv` | ✗ (in `>0`) | ✗ | ✗ | ✗ | ✗ | `mg-8f74` §2.2 |
| C6 | Doubly-punctured `H^*(C_3(F) ∖ {F, t}; X)` (remove top *and* bottom terminal) | 3 profiles: `{0:1, 1:1}` (48 F), `{0:1, 1:2}` (12 F), `{0:1, 1:4}` (1 F) | varies; non-zero in `H^1` | ✓ in `H^1` | ✓ (3 profiles) | ✗ — `H^{n-1} = H^2 = 0` always | ✗ in `H^{n-1}` | ✗ — content is in degree 1, contradiction needs degree 2 | `mg-8f74` §2.3 |
| C7 | Inclusion-direction downset `↓F = {F' ⊆ F}` with covariant hocolim → `X(F)` | `{}` for 44 F; `{0: 1}` for 17 F | per-family `triv` | ✓ only by 17 F | ✓ (2 profiles) | ✗ — `H^{n-1} = 0` always | ✗ | ✗ | `mg-8f74` §2.4 |
| C8 | Homotopy *limit* `H^*(C_3; π_0(X)) = H^*(holim_{C_3} X)` (`mg-f9a7`'s lead candidate per `rem:hocolim-flag`) | `{0: 6}` | `4·triv + 1·std` (**no `sgn`**) | ✓ in degree 0 | ✓ (the `6` is family-sensitive global sections) | ✗ — degree 0, 6-dim | ✗ — zero `sgn` component | ✗ — wrong degree | `mg-7bf3` §3.1 |
| C9 | Terminal-excluded hocolim `hocolim_{C_3^{|S|≥1}} X` | `{0:1, 2:59}` | non-trivial | ✓ | ✓ | ✗ — 59-dim, not 1 | undetermined / not `sgn` | ✓ degree, but ✗ dim | `mg-f9a7` §2.3, `mg-7bf3` §3.2 |
| C10 | Terminal-excluded holim `H^*(C_3^{|S|≥1}; π_0(X))` | `{0:6, 2:45}` | non-trivial | ✓ | ✓ | ✗ — 45-dim | ✗ | ✓ degree, ✗ dim | `mg-7bf3` §3.2 |
| C11 | Moore-lattice + coefficients `H^*(MOORE_3 proper part; π_0(X))` (drift A undone, drift B kept) | `{0:1, 1:2}` | `H^1 = 1·std` (**no `sgn`**) | ✓ in `H^1` | ✓ | ✗ — 2-dim, wrong degree | ✗ — `std`, not `sgn` | ✗ — degree 1, not 2 | `mg-7bf3` §3.3 |

### 1.3 Per-family cohomologies (the "given family" regime)

| # | Construction | `n=3` result | `S_3` isotype (per family) | NT | FS | Sph | `sgn` | `n-1` | Source |
|---|---|---|---|---|---|---|---|---|---|
| P1 | Per-family poset `Δ(F ∖ {∅, [n]})` (`Poset A`); inclusion poset of one family's own member sets | 5 distinct reduced-homology profiles among 61 F: 42 acyclic; 15 `H̃^0=1`; 2 `H̃^{-1}=1`; 1 `H̃^0=2`; 1 `H̃^1=1` (the maximal family) | the maximal family carries `(1,−1,1) = sgn_{S_3}` in `H̃^1` (the UC9 §D-4 punctured Boolean cube) | ✓ for 19/61 F | ✓ (5 profiles, correlated with rare-coord count) | ✓ for exactly **1** of 61 F — the maximal family | ✓ only for the maximal family | ✓ only for the maximal family | `mg-565a` §4 / self-test |
| P2 | Cubical-defect complex `X(F)` (`def:xf`) — Fork A's per-family coefficient at F | 2 profiles at `n=3`: 44 acyclic, 17 with `H̃^0 = 1`; 4 profiles at `n=4` | trivial in degree 0 only — **homotopy-discrete** at `n ≤ 4` | ✓ for 17/61 F (in `H̃^0`) | ✓ (the `π_0` count varies) | ✗ — only ever `H̃^0` content, no higher degree, never the F-series sphere | ✗ — `triv` only | ✗ — wrong degree (`H̃^0`, not `H̃^{n-1}`) | `mg-f9a7` §4.1 |
| P3 | Lattice interval `(0̂, F)` in the Moore lattice | 4 distinct profiles at `n=3`, mostly contractible (35/61) | small / mostly trivial | ✓ for some F | ✓ | ✗ in general | ✗ in general | depends on F | `mg-565a` §4 |
| P4 | Obstruction-machinery raw material on the punctured trace poset of F (cover `{U_x}`, strata, mismatch) | rare-coordinate cover-nerve has 7 profiles at `n=3`, 20 at `n=4`; mismatch is a Čech 1-cocycle, **δ-exact** in `F_obs`-internal direction by `mg-02b5` §3 | n/a (cocycle, not isotype) | ✓ (the cover nerve is non-trivial) | ✓ (covers vary across F) | ✗ as a class — the `F_obs`-internal class is **zero** (δ-exact) | ✗ — class is zero | n/a — class is zero in the local Čech cohomology | `mg-f9a7` §4.2, `mg-02b5` §3 |

### 1.4 The two regimes side by side, summarised

- **Category-level (C1–C11):** **zero** realisations carry a
  one-dimensional `sgn_{S_3}` class in degree `n - 1 = 2`. The
  best-shaped category-level result is C11 (Moore-lattice + `π_0(X)`)
  with `H^1 = 2` in the `std` isotype — wrong degree, wrong
  dimension, wrong isotype. The next-best is C8 (the holim, the
  re-foundation's own flagged candidate) with `H^0 = 6` in `4·triv +
  1·std` — wrong degree, no `sgn`.
- **Per-family (P1–P4):** the sphere exists but only on **one** of
  61 families (the maximal family `2^[3]`, where the punctured
  Boolean cube `≃ S^1` carries `sgn_{S_3}`). The cubical-defect `X(F)`
  is family-sensitive but homotopy-discrete (`H̃^0` only). The
  obstruction-machinery raw material is family-sensitive but its
  mismatch class is `δ`-exact in the local Čech cohomology of
  `F_obs` (`mg-02b5` §3).
- **The conclusion** is structural and forced: the family-sensitive
  spherical content provably **lives in the coefficient diagram**
  (`mg-565a` §4 / `mg-565a` §6.2 — vindicated), and **integrating
  that diagram over the category — by any natural variance —
  destroys the sphericality** (`mg-f9a7` §4.3 / `mg-7bf3` §4).

---

## §2 — Deliverable 2: the usefulness assessment

The Fork-A two-part contradiction `thm:contradiction`
(`paper/forkA/refoundation.tex` L1661) requires a class

> `ob(F⋆) ∈ H̃^{n-1}(C_n; X)`

to be simultaneously **non-zero** (Fact One, `prop:fact-one`) and
**`sgn`-free** (input (iv), R2) inside a **one-dimensional `sgn_{S_n}`
ambient** (input (v), `conj:y1a` — `Y_1`-A). These three together
contradict, hence Frankl. Each input is a *gate* on the cohomology of
whatever object hosts the class:

| Gate | What it asks of the host cohomology `H` |
|---|---|
| **G1 — non-trivial** | `H̃^{n-1}(H) ≠ 0` — there is a class for `ob` to be |
| **G2 — family-sensitive** | the class actually *depends on `F⋆`* (else it cannot detect a counterexample — the wrapper-risk, `rem:wrapper`) |
| **G3 — sphere-shaped** | `H̃^{n-1}` is one-dimensional, concentrated in degree `n-1` (the F-series sphere) |
| **G4 — `sgn`-bearing** | that one class is `sgn_{S_n}` (so that R2's "no `sgn` component" forces `ob = 0`) |

Below: each computed cohomology, scored against the four gates, with
the precise reason it fails.

### 2.1 Why each category-level cohomology cannot host `ob(F⋆)`

| Object | G1 | G2 | G3 | G4 | Precise failure mode |
|---|---|---|---|---|---|
| **C1 — Moore-lattice bare nerve** | ✗ | ✗ | ✗ | ✗ | Acyclic. There is no class at all in any degree. Family-blind in the strongest possible sense — the same zero object regardless of input. (Fork-D refutation, `mg-565a`.) |
| **C2 — Fork A covariant hocolim `H^*(C_n;X)`** (the actual object the proof builds) | ✗ in `>0` | ✗ in `>0` | ✗ | ✗ | Terminal-object collapse: `(∅,{∅})` is terminal in `C_n`; covariant hocolim drains onto `X(∅,{∅}) = point`; `H̃^*(C_n;X) = 0`. **`ob(F⋆)` is forced to 0 for want of a non-zero home.** This is the wrapper-risk realised, *one step upstream* of the edge map R3c. (`mg-f9a7`.) |
| **C3 — `F_obs` cell-level SS / local Čech double complex** | ✓ in pieces | ✓ | ✗ | ✗ | The trace cover is cell-level acyclic (every local nerve is a full simplex; `mg-02b5` §3): `Č H^{>0} = 0`. The mismatch class `{m_xy}` is **δ-exact in `F_obs`**: `{m_xy} = −δ{b̂_x}`. Its `F_obs`-internal cohomology class is **zero**. Non-triviality, if any, is carried *entirely* by the edge map into `H^*(C_n;X)` — i.e. by R3 — which lands in C2's zero group. (`mg-02b5` §3.) |
| **C4 — trace-downset `H^*(C_n(F); X)`** | ✗ | ✗ — same profile for all 61 F | ✗ | ✗ | Same terminal-object collapse: `(∅,{∅})` is in every trace-downset (the empty-ground trace of every family is the trivial family `{∅}`). Hocolim drains onto it identically. (`mg-8f74` §2.1.) |
| **C5 — punctured trace-downset `H^*(C_n(F) ∖ {F}; X)`** (the **actual** `def:obs-sheaf` ambient — directly addresses Daniel's reframing) | ✗ | ✗ | ✗ | ✗ | Removing F at the top does not remove `(∅,{∅})` at the bottom. Identical collapse. (`mg-8f74` §2.2.) |
| **C6 — doubly-punctured `H^*(C_n(F) ∖ {F, t}; X)`** | ✓ in `H^1` | ✓ (3 profiles) | ✗ — wrong degree | ✗ | Breaks the collapse but lands in `H^1`, never `H^{n-1} = H^2`. Family-sensitivity is real but not in the degree the contradiction needs. (`mg-8f74` §2.3.) |
| **C7 — inclusion downset `↓F` → `X(F)`** | ✓ for 17/61 F | ✓ | ✗ | ✗ | Collapses to `X(F)` itself (F is the inclusion-maximum). `X(F)` is homotopy-discrete (P2): only ever `H̃^0`, never `H̃^{n-1}`. (`mg-8f74` §2.4.) |
| **C8 — homotopy *limit* `H^*(C_3; π_0(X))`** (the `rem:hocolim-flag` lead candidate) | ✓ in degree 0 | ✓ | ✗ — degree 0, 6-dim | ✗ — `4·triv + 1·std`, no `sgn` | The holim does evade the terminal-object collapse, but produces 6-dim degree-0 cohomology — global sections of the components functor — not the F-series sphere. (`mg-7bf3` §3.1.) |
| **C9 / C10 — terminal-excluded** | ✓ | ✓ | ✗ — 59 / 45-dim | not the sphere isotype | Breaking the collapse by deleting `t` produces 59-dim `H^2` (hocolim) or 45-dim `H^2` (holim) — non-trivial in the right degree but vastly too big to be a sphere class. (`mg-f9a7` §2.3, `mg-7bf3` §3.2.) |
| **C11 — Moore-lattice + `π_0(X)` coefficients** (drift A undone, drift B kept — the most "F-series-shaped" candidate) | ✓ in `H^1` | ✓ | ✗ — 2-dim, wrong degree | ✗ — `std`, no `sgn` | The only candidate that puts non-trivial cohomology in the F-series degree `n−2 = 1` at `n=3`, but the isotype is `std` (the 2-dim irrep), not `sgn`. (`mg-7bf3` §3.3.) |

**The pattern is uniform.** Every category-level integration fails
**at least G3 (sphere shape) and at least G4 (`sgn` isotype)**. The
two failures the contradiction cannot survive are different:

- C1, C2, C4, C5 fail G1 (the object is acyclic) — and a *fortiori*
  G3 and G4. These four are the **collapse-class** failures; they
  share the same root cause: **the Moore-family lattice / trace
  category has the trivial family `(∅, {∅})` as a structural extremum
  that any colimit-flavoured construction drains onto**.
- C6, C7, C8, C9, C10, C11 fail G3 or G4 — they evade collapse but
  produce non-trivial cohomology in the wrong **shape**. These are
  the **shape-class** failures; their root cause is that **the
  Moore-family lattice (unlike `Δ(PPF_n)`) is a "fat" lattice
  without F-series-style extremal geometry, and adding the natural
  coefficient diagram does not manufacture that geometry** (`mg-7bf3`
  §5 rec 2).
- C3 is a special case: it fails G1 *internally*, but the proof can
  in principle source non-triviality from the comparison map into
  C2 — except that C2 is the zero group, so this avenue is also
  closed (`mg-02b5` §3).

### 2.2 Why each per-family cohomology cannot host `ob(F⋆)` either

Daniel's spirit-of-the-question — *can the per-family X(F) drive a
contradiction WITHOUT integrating over a category?* — has to be
addressed on its own merits. Here is the per-family scorecard:

| Object | G1 | G2 | G3 | G4 | Precise failure mode |
|---|---|---|---|---|---|
| **P1 — `Δ(F ∖ {∅,[n]})` for `F = 2^[n]`** (the UC9 §D-4 punctured Boolean cube) | ✓ | n/a (one family) | ✓ — `H̃^1 = 1` | ✓ — `sgn_{S_3}` | Clears all four gates **on a single family**. Fails to address Frankl because there is exactly **one** of these — at the maximal family `2^[n]`, which is *not* a minimal counterexample candidate (the maximal family has all-rare coords, `β_x = 0`; Frankl is trivially satisfied there). The sphere exists, but as an invariant of the *maximal* family, where there is nothing to contradict. |
| **P1 — `Δ(F ∖ {∅,[n]})` for `F ≠ 2^[n]`** | ✓ for 18/60 F | ✓ (4 profiles, correlated with rare-coord count) | ✗ for 18/18 of those F | ✗ | The other 60 families do not give `≃ S^1`. The map `F ↦ H̃^*(Δ(F ∖ {∅,[n]}))` is family-sensitive but only the maximal family lands on the sphere. |
| **P2 — `X(F)`** (the per-family Fork A coefficient) | ✓ for 17/61 F (in `H̃^0`) | ✓ (`π_0` varies) | ✗ — only `H̃^0` content | ✗ — `triv` | Homotopy-discrete at `n ≤ 4` — `X(F)` is a disjoint union of contractible pieces. Its only invariant is its component count `π_0(X(F))`. No `H̃^{n-1}`, no sphere. (`mg-f9a7` §4.1.) |
| **P3 — Moore-lattice intervals `(0̂, F)`** | ✓ for some F | ✓ | ✗ in general | ✗ in general | Mostly contractible (35/61); small non-trivial profiles for the rest. No systematic sphere structure. |
| **P4 — obstruction-machinery raw material on the punctured trace poset of F⋆** | ✓ as a *cochain* (the cover nerve is non-trivial) | ✓ | n/a as a class | n/a as a class | The mismatch `{m_xy}` *is* a Čech 1-cocycle natively, exactly as `def:ob` and `rem:promotion` say honestly. But its `F_obs`-internal class is **zero** (δ-exact, `mg-02b5` §3). Its non-trivial life depends on promotion to C2 — and that promotion's target is the zero group. |

**Why the per-family route does not produce a contradiction without
integration.** The Frankl programme needs more than "a sphere with
`sgn`" — it needs that sphere to be **attached to a candidate minimal
counterexample F⋆**, so that the obstruction *forced* by F⋆'s
existence has a non-trivial home. The per-family content available is:

- **The maximal-family sphere (P1).** Attached to `F = 2^[n]`, not to
  `F⋆`. `2^[n]` is not a counterexample candidate. There is no
  per-family rearrangement that attaches a sphere to a minimal
  counterexample, because:
  - by `prop:minimality` an F⋆ must have all-non-rare coordinates,
    and `mg-f9a7` §4.2 confirmed that **no such F⋆ exists at `n = 3`
    or `n = 4`** among the 61 / 2 480 Moore families — so there is
    no F⋆ to attach anything to in any small case;
  - the cohomological route's logic was always: *assume an
    F⋆ exists, derive a class forced by its existence, derive a
    contradiction from the class's properties*. The "class forced by
    its existence" cannot be a per-family invariant of F⋆ alone —
    `X(F⋆)` is homotopy-discrete (P2), so its only invariant is `π_0`
    and that is not sphere-shaped.
- **The local Čech mismatch (P4).** This *is* family-sensitive, and
  it *is* the genuine obstruction the cohomological route was built
  on. But its `F_obs`-internal class is zero (`mg-02b5` §3, an
  honest finding which is **not** a defect — it is exactly what
  `rem:promotion` and `lem:cocycle` already say). The mismatch's
  non-triviality is conditional on promotion to `H^*(C_n;X)` — and
  the cohomology there is zero.

The conceptual obstacle is named cleanly by `rem:hocolim-flag`: the
obstruction is a **gluing-type (limit-flavoured) invariant** — it
asks "do the local sections `b̂_x` glue across the strata `{U_x}` to a
global section." This is intrinsically a question about an
**integration** of the per-family data across the strata of a fixed
F⋆ — it cannot be reduced to a single per-family invariant. The
per-family X(F) sphericality (when present, only at `F = 2^[n]`)
records that one family's *internal* cubical structure is rich; it
records nothing about gluing of strata for a hypothetical F⋆. So:

> **The per-family X(F) is the right place for the spherical content
> (`mg-565a` §6.2), but the wrong place for the obstruction class.
> The obstruction is intrinsically a strata-gluing question on a
> fixed F⋆, which is the kind of thing only an integration over the
> indexing category can express. Daniel's "without integrating"
> rephrasing would change the meaning of the obstruction, not just
> its location.**

### 2.3 The exact gates each route fails

Concise gate-failure summary (mapped to the proof inputs):

| Route | Object | Fails which input of `thm:contradiction` |
|---|---|---|
| Fork A as written | C2: `H^*(C_n; X)` | Input (v) `conj:y1a`: `H̃^{n-1}(C_n;X) ≅ sgn_{S_n}` is **false** — it is `0`. Input (iii) R3c moot (target is zero). Input (i)–(iv) all become moot. |
| Fork D | C1: bare nerve of Moore lattice | The object is acyclic; cannot host `ob(F⋆)` at all. |
| Trace-downset rephrasings (Daniel's reframing) | C4 / C5 / C6 / C7 | C4, C5: same terminal-object collapse. C6: non-trivial but wrong degree (1 not n−1). C7: collapses to `X(F)`, no `H^{n-1}`. |
| The `rem:hocolim-flag` holim alternative | C8 / C10 | C8: wrong degree (0 not n−1), no `sgn` isotype. C10: wrong dimension (45 not 1). |
| Terminal-excluded variants | C9 | Right degree, but 59-dim, not the F-series sphere. |
| Lattice + `π_0(X)` coefficients (drift A undone) | C11 | Right degree-region (1 at n=3, which is `n−2` not `n−1`), wrong dimension (2 not 1), wrong isotype (`std` not `sgn`). |
| Per-family (P1 maximal) | UC9 §D-4 sphere | Right *shape*, but attached to `F = 2^[n]` not to a counterexample F⋆. **There is no minimal counterexample candidate to attach the obstruction to** (no F has all-non-rare coords at `n ≤ 4`). |
| Per-family (P2, X(F⋆)) | `X(F⋆)` itself | Homotopy-discrete: only ever `H̃^0`, no sphere of any kind, regardless of F. |
| Per-family (P4, local Čech mismatch) | local `Č H^1(𝔘; F_obs)` of F⋆ | The class is δ-exact in `F_obs` (`mg-02b5` §3); its only non-trivial home is C2's zero group via the R3 promotion. |

### 2.4 The Daniel-spirit answer, distilled

> **No.** None of these cohomologies — category-integrated or
> per-family — is useful for the Frankl two-part contradiction in any
> rearrangement. The category-integrated objects fail at the
> structural level (terminal-object collapse, or fat-lattice
> non-spherical geometry). The per-family object that *does* carry
> the F-series sphere (P1 at the maximal family) is the wrong subject
> — the contradiction's subject is a *minimal counterexample* F⋆, and
> the per-family X(F⋆) is homotopy-discrete, not spherical. The local
> Čech mismatch on the punctured trace poset of F⋆ *is* a genuine
> family-sensitive cocycle, but its only non-trivial class lives in
> the (zero) target of the comparison map into `H^*(C_n;X)`. **The
> existing cohomology computations exhaustively rule out the
> cohomological route to Frankl in the Fork A / Fork D / Moore-lattice
> family of formulations.** A genuinely different route would require
> a different indexing object (not a localization or variance of
> `C_n`), a different coefficient diagram (not `X`), or a different
> proof structure (not "obstruction-class-in-cohomology"). Whether
> such a programme is worth attempting is a strategic call beyond
> this synthesis.

---

## §3 — The structural why, in one paragraph

The cohomological route presupposes that *some* cohomology — of *some*
category-shaped object built from intersection-closed families, with
*some* coefficient diagram — concentrates spherically in degree `n-1`
on the `sgn_{S_n}` isotype, in the way `Δ(PPF_n)` does for the sister
F-series category of posets. The eleven computations summarised in §1
together show this fails for a **structural** reason which is now
clean to state: the Moore-family lattice (and equivalently the trace
category `C_n`) has an extremum — the trivial family `(∅, {∅})` — onto
which colimit-flavoured constructions drain (terminal-object collapse,
C1/C2/C4/C5); and once that drain is removed by puncturing or by
switching to a limit-flavoured construction, what remains is a "fat"
lattice (every pair has a meet, abundant comparabilities, `μ(0̂,1̂) =
0`) whose intrinsic geometry is **not** the F-series cofiber-Morse
geometry that makes `Δ(PPF_n)` spherical (C6–C11). The per-family
content `X(F)` *does* carry the F-series sphere — but only at one
family (the maximal one, P1), and only via its own member-set
inclusion poset, not via the construction's coefficient `X(F)` (which
is homotopy-discrete, P2). And the gluing-type obstruction
(`rem:hocolim-flag`) the proof actually needs is not a per-family
invariant at all — it is a question about strata of a fixed F⋆, which
requires *some* integration to express, and every natural integration
either collapses or is non-spherical. There is no rearrangement that
fixes this — the obstacle is in the underlying combinatorics of
intersection-closed families, not in any particular Fork A / Fork D
modelling choice.

---

## §4 — What the synthesis does NOT claim

For honesty, and to keep the synthesis bounded:

- It does **not** claim Frankl is false. Frankl holds unconditionally
  at `n = 3` and `n = 4` (every Moore family has a rare coordinate;
  `mg-f9a7` §4.2 / `mg-8f74` §2). The cohomological route's failure
  is a failure of one proof *strategy*, not a refutation of the
  theorem.
- It does **not** claim every conceivable cohomology of every
  conceivable indexing object on every conceivable coefficient is
  non-spherical. It claims that the eleven natural realisations
  computed cover the natural variants suggested by the
  Fork-A / Fork-D / `rem:hocolim-flag` / Daniel-reframing /
  Daniel-tweak menus, and they are uniformly non-viable.
- It does **not** rule out a new proof strategy on a *different*
  indexing object (e.g., a presentation-complex-of-Frankl-instances,
  or a parameter category of weighted intersection-closed families,
  or a non-combinatorial object entirely). Such a programme would be
  genuine new work; this synthesis's role is to record exactly why
  the existing programme cannot close, so a new programme can avoid
  re-running the same five RED's.
- It does **not** edit `refoundation.tex`, the Lean source, or any
  axiom. `Frankl_Holds`'s dependence on
  `case3_ss_obstruction_paper_axiom` is unaffected. The Zulip post
  stays held. This is a synthesis report only.

---

## §5 — Cross-references

- **Brief:** `mg-5cc6` (Frankl-Cohomology-Synthesis). **Routes to:**
  Daniel, via `pm-onethird`.
- **The five Phase-0 probe results synthesised here:**
  - `docs/Frankl-ForkD-Probe-n3.md` (`mg-565a`) — Moore-lattice bare
    nerve.
  - `docs/Frankl-ForkA-Phase0-FaithfulnessProbe.md` (`mg-f9a7`) —
    Fork A covariant hocolim.
  - `docs/Frankl-ForkA-Fobs-SS-Pinning.md` (`mg-02b5`) — `F_obs`
    cell-level spectral sequence.
  - `docs/Frankl-Downset-Reframing.md` (`mg-8f74`) — trace-downset
    and inclusion-downset variants per Daniel's reframing.
  - `docs/Frankl-Spherical-Reconcile.md` (`mg-7bf3`) — homotopy
    limit, terminal-excluded, lattice + `π_0(X)` variants per
    Daniel's tweak hypothesis.
- **The conditional theorem the cohomology must feed into:**
  `paper/forkA/refoundation.tex` `thm:contradiction` (L1661);
  inputs (i)–(v) `def:ob` (L1122), `prop:fact-one` (L1181),
  `conj:y1a` (L1361); structural context `def:bk` (L709),
  `rem:hocolim-flag` (L800), `rem:wrapper`,
  `debt:faithful-localized`.
- **The probe scripts** (self-contained, reproducible — referenced
  for completeness, not re-run in this synthesis):
  `docs/frankl-forkd-probe-n3.py`,
  `docs/frankl-forkA-faithfulness-probe.py`,
  `docs/frankl-forkA-downset-reframing.py`,
  `docs/frankl-spherical-reconcile-probe.py`.
- **Onboarding:** `docs/PROOF-STRUCTURE-ONBOARDING.md`.

---

*Synthesis by polecat `cat-mg-5cc6`. Deliverable on `main`: this
document. Verdict: **Daniel asked for a clear answer; the answer is
no.** Eleven natural cohomologies of "the category of intersection-
closed families" have been computed at `n = 3`; zero carry a
one-dimensional `sgn_{S_n}` class in degree `n - 1`. Four per-family
cohomologies have been computed; the one (P1, the maximal family
viewed as the inclusion poset of its own member sets) that does carry
the F-series sphere is attached to `F = 2^[n]`, which is not a
counterexample candidate, and the per-family X(F) the Fork A
construction actually uses is homotopy-discrete on every Moore family
at `n ≤ 4`. The local Čech mismatch on the punctured trace poset of a
hypothetical F⋆ is the genuine obstruction natively — it is a Čech
1-cocycle as `def:ob` and `rem:promotion` already state honestly — but
its `F_obs`-internal class is δ-exact (`mg-02b5` §3), so its only
non-trivial life is via the comparison map into `H^*(C_n;X)`, which
is the zero group. None of the cohomologies computed can host
`ob(F⋆)` in the form `thm:contradiction` requires. The category-level
collapses (C1, C2, C4, C5) share a single structural cause — the
trivial family `(∅, {∅})` is an extremum of every natural integration;
the non-collapsing variants (C6–C11) all fail the F-series sphere
shape because the Moore-family lattice does not share `Δ(PPF_n)`'s
extremal geometry; and the per-family sphere is attached to the wrong
F. The route is dead at the category level and incomplete at the
per-family level. Whether to attempt a structurally different
programme on a different indexing object is a strategic call for
Daniel — this synthesis identifies, decisively, that no rearrangement
of the existing cohomology computations is the path.*
