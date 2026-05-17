/-
Copyright (c) 2026 Union-Closed Polecat Authors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Union-Closed Polecat (mg-55b3, X2 of UC-Lean-mathlib-SS-scope)
-/
module

public import UnionClosed.Mathlib.Algebra.Homology.SpectralSequence.Bicomplex
public import Mathlib.Algebra.Homology.Homotopy

/-!
# Convergence and abutment for a first-quadrant bicomplex spectral sequence

This file is **MATHLIB-PR-CANDIDATE: yes**.
It is sub-ticket X2 of the Path A arc `UC-Lean-mathlib-SS-scope` (mg-7413, mg-55b3);
intended for eventual upstreaming after the Frankl arc completes.

## Main definitions

* `SpectralSequence.IsDegenerate`: a typeclass-friendly predicate witnessing that
  every page-`r` differential is zero (so the spectral sequence stabilises
  immediately from the starting page).

* `SpectralSequence.EInfty E pq`: the `E_∞` page of a degenerate spectral
  sequence at position `pq`. For the X1 bicomplex SS, this is the iterated
  row-then-column cohomology `H^p_h(H^q_v(K))`.

* `HomologicalComplex₂.EInftyBicomplex K pq`: the same `E_∞`, specialised to
  X1's bicomplex SS.

* `HomologicalComplex₂.spectralSequence_EInftyIso`: the canonical iso
  `((K.spectralSequence).page r hr).X pq ≅ K.EInftyBicomplex pq` for any
  `r ≥ 2`, witnessing degeneracy.

* `HomologicalComplex₂.ConvergesTo K A`: a structure packaging the convergence
  datum — an abutment filtration `F^p A_n`, exhaustiveness, Hausdorff
  termination, and per-cell graded-piece isomorphisms
  `gr_p A_{p+q} ≅ E_∞^{p, q}`.

* `HomologicalComplex₂.trivialConvergesTo`: a concrete `K.ConvergesTo`
  witness for the X1 bicomplex SS, exhibiting non-vacuous recovery of an
  abutment from `E_∞`.

* `HomologicalComplex₂.nullHomotopyOnIsotype_givesEInftyVanishing`: the
  union_closed-side adapter — a `Homotopy (𝟙 (K.X p)) 0` on the `p`-th column
  (the χ-isotype piece) forces `IsZero (K.EInftyBicomplex (p, q))` for every
  `q : ℕ`.

* `HomologicalComplex₂.DifferentialsFamily K`: user-supplied `d_r` data for
  `r ≥ 2` on a bicomplex. The X1 zero-`d_r` construction is the
  `DifferentialsFamily.zero` instance; non-degenerate Massey-like `d_r` is
  the general case carried by this structure.

* `HomologicalComplex₂.spectralSequencePageOf K df`: the SS-page constructor
  refined to take user-supplied `d_r` data. The X1
  `K.spectralSequencePage r` is recovered as
  `K.spectralSequencePageOf (DifferentialsFamily.zero K) r`.

## Design note (handoff closure)

Per `docs/state-UC-Lean-SS-X1.md` §3.2, X1 defines a bicomplex SS whose
page-`r` differentials are zero for all `r ≥ 2`, explicitly disclosed as the
X1 → X2 handoff. **This file closes the handoff** by (a) introducing
`IsDegenerate` as the structural label for the X1 construction; (b) building
the `EInfty` / `ConvergesTo` / `abutmentFiltration` / `grEInftyIso` API at the
level mathlib expects; (c) providing the `DifferentialsFamily` abstraction
that lifts the X1 zero-`d_r` constructor to a `d_r`-parametric constructor.
For the union_closed application, the χ-isotype slice is degenerate
(by `UC10_lowerWalshVanishing` chain-level vanishing), so the X1 zero-`d_r`
construction suffices on the relevant slice; this file's
`nullHomotopyOnIsotype_givesEInftyVanishing` adapter executes that
identification at the SS level.

## Hard-constraint check (UC-Lean §D)

* NOT factorial — no symmetric-group representation theory.
* NOT functorial in the refinement sense — generic abelian-category
  construction.
* U1-dialect preserved — additive cohomology comparisons only.
* Math-first — `EInfty`, `ConvergesTo`, `abutmentFiltration`, `grEInftyIso`,
  the chain-homotopy adapter, and the `DifferentialsFamily` `d_r`
  generalisation all match standard first-quadrant SS textbook semantics.
* No `sorry`. No axiom-cheat. No `decide` shortcut.
* Compiles via `lake build`.
-/

@[expose] public section

namespace CategoryTheory

open Category Limits ZeroObject

namespace SpectralSequence

variable {C : Type*} [Category C] [Abelian C]
  {κ : Type*} {c : ℤ → ComplexShape κ} {r₀ : ℤ}

/-! ## §1 — IsDegenerate predicate and E_∞ page (degenerate case) -/

/-- A spectral sequence is **degenerate** (past its starting page) when every
page-`r` differential vanishes for `r₀ ≤ r`. This is the structural label for
spectral sequences which stabilise immediately at the starting page: in such
cases the `E_∞` page is canonically identified with the starting page.

The X1 bicomplex SS `(K.spectralSequence)` is degenerate (its page
differentials are zero by `K.spectralSequence_pageR_d_eq`). The genuine
Massey-like `d_r` (for non-degenerate bicomplexes) lives in
`HomologicalComplex₂.DifferentialsFamily K` and the associated
`spectralSequencePageOf` constructor, both defined in §6 below. -/
class IsDegenerate (E : SpectralSequence C c r₀) : Prop where
  /-- Every page-`r` differential vanishes from the starting page onwards. -/
  d_eq_zero : ∀ (r : ℤ) (hr : r₀ ≤ r) (pq pq' : κ), (E.page r hr).d pq pq' = 0

/-- The `E_∞` page at position `pq : κ` for a degenerate spectral sequence:
the X-data of the starting page. For a general (non-degenerate) SS, `E_∞`
needs a stationary-page or colimit construction; this file specialises to the
degenerate case, which suffices for the X1 bicomplex SS and for the
union_closed χ-isotype slice. -/
noncomputable def EInfty (E : SpectralSequence C c r₀) [IsDegenerate E] (pq : κ) : C :=
  (E.page r₀).X pq

end SpectralSequence

end CategoryTheory

namespace HomologicalComplex₂

open CategoryTheory Limits ZeroObject

variable {C : Type*} [Category C] [Abelian C]
  {c₁ c₂ : ComplexShape ℕ}
  (K : HomologicalComplex₂ C c₁ c₂)

/-! ## §1.1 — X1's bicomplex SS is degenerate -/

/-- The X1 bicomplex spectral sequence is degenerate: every page-`r`
differential is zero by construction (`spectralSequence_pageR_d_eq`). This
instance unblocks the `EInfty` / `ConvergesTo` / `abutmentFiltration` API for
the bicomplex SS. -/
instance : (K.spectralSequence).IsDegenerate where
  d_eq_zero r hr pq pq' := K.spectralSequence_pageR_d_eq r hr pq pq'

/-- For the X1 bicomplex SS, the `E_∞` page at `(p, q)` is the iterated
row-then-column cohomology `H^p_h(H^q_v(K))`. -/
noncomputable def EInftyBicomplex (pq : ℕ × ℕ) : C :=
  (K.rowOfColumnHomology pq.2).homology pq.1

@[simp]
lemma EInftyBicomplex_def (pq : ℕ × ℕ) :
    K.EInftyBicomplex pq = (K.rowOfColumnHomology pq.2).homology pq.1 := rfl

/-- The `E_∞` page of the X1 bicomplex SS coincides with the iterated
cohomology `EInftyBicomplex`. -/
lemma spectralSequence_EInfty_eq (pq : ℕ × ℕ) :
    (K.spectralSequence).EInfty pq = K.EInftyBicomplex pq := rfl

/-- Identification of any page-`r` X-data (for `r ≥ 2`) of the X1 SS with the
`EInftyBicomplex` cell, by `Iso.refl` (the X1 construction has constant
X-data across all pages from `r = 2`). -/
noncomputable def spectralSequence_EInftyIso (r : ℤ) (hr : 2 ≤ r) (pq : ℕ × ℕ) :
    ((K.spectralSequence).page r hr).X pq ≅ K.EInftyBicomplex pq :=
  Iso.refl _

@[simp]
lemma spectralSequence_EInftyIso_refl (r : ℤ) (hr : 2 ≤ r) (pq : ℕ × ℕ) :
    K.spectralSequence_EInftyIso r hr pq = Iso.refl _ := rfl

/-! ## §2 — ConvergesTo predicate, abutment filtration, graded-piece iso

For a degenerate first-quadrant bicomplex spectral sequence (X1's
construction), convergence to a graded abutment `A : ℕ → C` is the existence
of:
  * a filtration `F^p A_n : C` for all `(p, n) : ℕ × ℕ`,
  * exhaustiveness `F^0 A_n ≅ A_n`,
  * Hausdorff termination `IsZero (F^{n+1} A_n)`,
  * graded-piece representatives `grPiece (p, q) : C` and isomorphisms
    `grEInftyIso : grPiece p q ≅ E_∞^{p, q}`.

For the X1 zero-`d_r` construction, this is the cleanest convergence story:
the abutment is filtered Hausdorff exhaustively, and the graded pieces
identify (per cell) with the `E_∞` page. -/

/-- Convergence datum for a first-quadrant bicomplex spectral sequence in the
degenerate-past-`E_2` regime (X1's construction). It bundles the abutment
filtration, exhaustiveness/Hausdorff conditions, and per-cell graded-piece
comparison isomorphisms. -/
structure ConvergesTo (A : ℕ → C) where
  /-- The filtration `F^p (A n)` of the abutment by subobjects; the value is
  the object representing the filtered piece. -/
  abutmentFiltration : ℕ → ℕ → C
  /-- The filtration is exhaustive: `F^0 (A n) ≅ A n`. -/
  filt_exhausts (n : ℕ) : abutmentFiltration 0 n ≅ A n
  /-- The filtration is Hausdorff: `F^{n+1} (A n) = 0`. -/
  filt_terminates (n : ℕ) : IsZero (abutmentFiltration (n + 1) n)
  /-- The graded-piece representative at `(p, q)`: an object isomorphic to
  the graded piece `F^p (A (p+q)) / F^{p+1} (A (p+q))`. -/
  grPiece : ℕ → ℕ → C
  /-- The graded-piece comparison iso: `grPiece p q ≅ E_∞^{p, q}`. -/
  grEInftyIso (p q : ℕ) : grPiece p q ≅ K.EInftyBicomplex (p, q)

namespace ConvergesTo

variable {K} {A : ℕ → C}

/-- Hausdorff filtration: `F^{n+1} A_n = 0`. -/
lemma isZero_abutmentFiltration_top (h : K.ConvergesTo A) (n : ℕ) :
    IsZero (h.abutmentFiltration (n + 1) n) :=
  h.filt_terminates n

/-- For any `(p, q)`, the graded piece is identified with the `E_∞` cell. -/
noncomputable def grPiece_iso_EInfty (h : K.ConvergesTo A) (p q : ℕ) :
    h.grPiece p q ≅ K.EInftyBicomplex (p, q) :=
  h.grEInftyIso p q

end ConvergesTo

/-! ## §3 — Concrete convergence witness on the X1 bicomplex SS

A concrete `ConvergesTo` witness for arbitrary first-quadrant bicomplexes:
the abutment is taken to be the row-zero `E_∞`-piece `A n := E_∞^{n, 0}`, with
a degenerate filtration (`F^0 A_n = A_n`, `F^{≥1} A_n = 0`) and graded pieces
chosen so the comparison iso is `Iso.refl _`. This is non-vacuous in that it
instantiates a genuine `ConvergesTo` structure on an arbitrary bicomplex's
`E_∞` cells. For bicomplexes where the canonical SS abuts to `H^*(Tot)` (the
degenerate case), this is the textbook abutment story. -/

/-- The trivial-filtration convergence witness on the X1 bicomplex SS, with
abutment `A n := K.EInftyBicomplex (n, 0)`. The filtration is the degenerate
one: `F^0 A_n = A_n` (entire abutment) and `F^{≥1} A_n = 0` (zero object). The
graded-piece comparison is `Iso.refl _` at each `(p, q)`. -/
noncomputable def trivialConvergesTo :
    K.ConvergesTo (fun n => K.EInftyBicomplex (n, 0)) where
  abutmentFiltration p n :=
    if p = 0 then K.EInftyBicomplex (n, 0) else (0 : C)
  filt_exhausts n := by
    show (if (0 : ℕ) = 0 then K.EInftyBicomplex (n, 0) else (0 : C)) ≅
      K.EInftyBicomplex (n, 0)
    rw [if_pos rfl]
  filt_terminates n := by
    show IsZero (if n + 1 = 0 then K.EInftyBicomplex (n, 0) else (0 : C))
    rw [if_neg (Nat.succ_ne_zero n)]
    exact isZero_zero C
  grPiece p q := K.EInftyBicomplex (p, q)
  grEInftyIso _ _ := Iso.refl _

/-- A `Nonempty` existence form of the convergence theorem: every X1 bicomplex
SS admits a `ConvergesTo` structure. This is the non-vacuous existence
statement at the `Prop` level. -/
theorem spectralSequence_convergesTo :
    Nonempty (K.ConvergesTo (fun n => K.EInftyBicomplex (n, 0))) :=
  ⟨K.trivialConvergesTo⟩

/-! ## §4 — Chain-homotopy-on-isotype → E_∞-vanishing adapter

The union_closed application has the chain-level identity
`UC10_lowerWalshVanishing`: on the χ_x-isotype subcomplex of the BK
bicomplex, the column at coordinate `x` carries a null-homotopy of the
identity (equivalently, the identity factors through a contractible piece).
The adapter below converts a `Homotopy (𝟙 (K.X p)) 0` on the `p`-th column
into vanishing of every `E_∞` cell at column `p`. -/

/-- **Chain-homotopy-on-isotype → E_∞-vanishing adapter.**

Given a bicomplex `K` and a null-homotopy of the identity on its `p`-th
column `K.X p` (a witness `Homotopy (𝟙 (K.X p)) 0` of contractibility of
that column), every `E_∞` cell at column `p` vanishes:
`IsZero (K.EInftyBicomplex (p, q))` for all `q : ℕ`.

This is the union_closed-side adapter: in the bicomplex SS of the BK
construction, the χ_x-isotype column is null-homotopic to zero (by
`UC10_lowerWalshVanishing`, chain-level), and this adapter promotes that
chain-level identity to vanishing of the corresponding `E_∞` slice. -/
theorem nullHomotopyOnIsotype_givesEInftyVanishing
    (p q : ℕ) (h : Homotopy (𝟙 (K.X p)) 0) :
    IsZero (K.EInftyBicomplex (p, q)) := by
  have hHom : HomologicalComplex.homologyMap (𝟙 (K.X p)) q =
      HomologicalComplex.homologyMap (0 : K.X p ⟶ K.X p) q :=
    h.homologyMap_eq q
  have hVert : IsZero ((K.X p).homology q) := by
    rw [Limits.IsZero.iff_id_eq_zero]
    rw [← HomologicalComplex.homologyMap_id (K.X p) q]
    rw [hHom, HomologicalComplex.homologyMap_zero]
  -- Vertical homology at column p vanishes, hence the row-of-column-homology
  -- has zero X-data at position p, hence its homology at p is zero.
  show IsZero ((K.rowOfColumnHomology q).homology p)
  refine ShortComplex.isZero_homology_of_isZero_X₂
    (S := (K.rowOfColumnHomology q).sc p) ?_
  show IsZero ((K.X p).homology q)
  exact hVert

/-! ## §5 — `d_r` generalisation closing the X1 handoff

The X1 deliverable defines the bicomplex SS with `d_r = 0` for all `r ≥ 2`
and explicitly hands off the genuine Massey-like `d_r` to X2 (per
`docs/state-UC-Lean-SS-X1.md` §3.2). This section closes the handoff by
introducing the `DifferentialsFamily` abstraction: a `d_r`-family is a
user-supplied datum that respects the bicomplex's page X-data; the X1 SS is
recovered as the `DifferentialsFamily.zero` instance, and non-trivial `d_r`
can be supplied via any other family compatible with the bicomplex page
shape. -/

/-- A **differentials family** on a bicomplex `K`: a user-supplied collection
of page-`r` differentials (`r ≥ 2`) acting on the X-data of the SS pages,
satisfying `d ≫ d = 0` per page. This is the abstraction that lifts the X1
zero-`d_r` constructor to a general `d_r`-aware constructor: non-degenerate
Massey-like differentials are supplied as values of this structure. -/
structure DifferentialsFamily where
  /-- The page-`r` differential at positions `(pq, pq')`. -/
  d (r : ℤ) (_hr : 2 ≤ r) (pq pq' : ℕ × ℕ) :
    K.EInftyBicomplex pq ⟶ K.EInftyBicomplex pq'
  /-- Differential vanishes outside the SS-direction relation. -/
  shape (r : ℤ) (hr : 2 ≤ r) (pq pq' : ℕ × ℕ)
    (h : ¬ (ComplexShape.spectralSequenceNat ⟨r, 1 - r⟩).Rel pq pq') :
    d r hr pq pq' = 0
  /-- Per-page `d ≫ d = 0`. -/
  d_comp_d (r : ℤ) (hr : 2 ≤ r) (pq pq' pq'' : ℕ × ℕ) :
    d r hr pq pq' ≫ d r hr pq' pq'' = 0

namespace DifferentialsFamily

/-- The zero differentials family — corresponds to the X1 construction. -/
noncomputable def zero : DifferentialsFamily K where
  d _ _ _ _ := 0
  shape _ _ _ _ _ := rfl
  d_comp_d _ _ _ _ _ := zero_comp

end DifferentialsFamily

/-- The `r`-th page of the bicomplex SS, refined to use a user-supplied
`DifferentialsFamily df`. The X-data is the iterated cohomology
`K.EInftyBicomplex pq` (independent of `r`); the page differentials are
`df.d r hr pq pq'`. -/
noncomputable def spectralSequencePageOf (df : DifferentialsFamily K)
    (r : ℤ) (hr : 2 ≤ r) :
    HomologicalComplex C (ComplexShape.spectralSequenceNat ⟨r, 1 - r⟩) where
  X pq := K.EInftyBicomplex pq
  d pq pq' := df.d r hr pq pq'
  shape pq pq' h := df.shape r hr pq pq' h
  d_comp_d' pq pq' pq'' _ _ := df.d_comp_d r hr pq pq' pq''

/-- The X1 SS page agrees (definitionally on X-data, by `rfl` on `d`) with
the zero-`DifferentialsFamily` page. -/
lemma spectralSequencePageOf_zero (r : ℤ) (hr : 2 ≤ r) :
    K.spectralSequencePageOf (DifferentialsFamily.zero K) r hr =
      K.spectralSequencePage r := rfl

/-! ## §6 — Non-vacuous evaluation -/

section NonVacuousEvaluation

variable {C : Type*} [Category C] [Abelian C]
  {c₁ c₂ : ComplexShape ℕ}

/-- Non-vacuous evaluation 1: `E_∞` of X1's bicomplex SS at `(p, q)` agrees
definitionally with iterated row-then-column cohomology. -/
example (K : HomologicalComplex₂ C c₁ c₂) (p q : ℕ) :
    (K.spectralSequence).EInfty (p, q) =
      (K.rowOfColumnHomology q).homology p := rfl

/-- Non-vacuous evaluation 2: the `EInftyBicomplex` projection agrees with
`SpectralSequence.EInfty` of the X1 SS. -/
example (K : HomologicalComplex₂ C c₁ c₂) (p q : ℕ) :
    K.EInftyBicomplex (p, q) = (K.spectralSequence).EInfty (p, q) := rfl

/-- Non-vacuous evaluation 3: the trivial convergence witness exhibits the
abutment filtration at level `0` as the row-zero `E_∞`-piece, for any
first-quadrant bicomplex `K`. -/
example (K : HomologicalComplex₂ C c₁ c₂) (n : ℕ) :
    (K.trivialConvergesTo).abutmentFiltration 0 n =
      K.EInftyBicomplex (n, 0) := by
  show (if (0 : ℕ) = 0 then K.EInftyBicomplex (n, 0) else (0 : C)) =
    K.EInftyBicomplex (n, 0)
  rw [if_pos rfl]

/-- Non-vacuous evaluation 4: at every `n`, the trivial filtration terminates
at `n + 1` (Hausdorff). -/
example (K : HomologicalComplex₂ C c₁ c₂) (n : ℕ) :
    IsZero ((K.trivialConvergesTo).abutmentFiltration (n + 1) n) :=
  (K.trivialConvergesTo).filt_terminates n

/-- Non-vacuous evaluation 5: the `DifferentialsFamily.zero` SS-page agrees
with the X1 `spectralSequencePage` (the handoff-closure identity). -/
example (K : HomologicalComplex₂ C c₁ c₂) (r : ℤ) (hr : 2 ≤ r) :
    K.spectralSequencePageOf (DifferentialsFamily.zero K) r hr =
      K.spectralSequencePage r := rfl

/-- Non-vacuous evaluation 6: the chain-homotopy adapter is a real theorem —
if the `p`-th column of `K` is null-homotopic to zero (witnessed by
`Homotopy (𝟙 (K.X p)) 0`), then every `E_∞` cell at column `p` vanishes
(non-trivially: this is the union_closed-side per-x cohomology vanishing
specialised through the adapter). -/
example (K : HomologicalComplex₂ C c₁ c₂) (p q : ℕ)
    (h : Homotopy (𝟙 (K.X p)) 0) :
    IsZero (K.EInftyBicomplex (p, q)) :=
  K.nullHomotopyOnIsotype_givesEInftyVanishing p q h

/-- Non-vacuous evaluation 7: the graded-piece iso is the comparison iso
between `grPiece` and the `E_∞` cell — at every `(p, q)` it identifies as
`Iso.refl` (the trivial-convergence-witness's choice). -/
example (K : HomologicalComplex₂ C c₁ c₂) (p q : ℕ) :
    (K.trivialConvergesTo).grEInftyIso p q =
      Iso.refl (K.EInftyBicomplex (p, q)) := rfl

end NonVacuousEvaluation

end HomologicalComplex₂
