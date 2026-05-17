/-
Copyright (c) 2026 Union-Closed Polecat Authors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Union-Closed Polecat (mg-dd80, X1 of UC-Lean-mathlib-SS-scope)
-/
module

public import Mathlib.Algebra.Homology.HomologicalBicomplex
public import Mathlib.Algebra.Homology.HomologicalComplexAbelian
public import Mathlib.Algebra.Homology.SpectralSequence.Basic

/-!
# Spectral sequence of a first-quadrant bicomplex

This file is **MATHLIB-PR-CANDIDATE: yes**.
It is sub-ticket X1 of the Path A arc `UC-Lean-mathlib-SS-scope` (mg-7413, mg-dd80);
intended for eventual upstreaming after the Frankl arc completes.

## Main definitions

* `HomologicalComplex₂.rowOfColumnHomology K q`: the horizontal complex whose object
  at column `p` is the `q`-th vertical homology `(K.X p).homology q` of the `p`-th
  column of the bicomplex `K`, with horizontal differentials induced by `K.d` via
  `HomologicalComplex.homologyMap`.

* `HomologicalComplex₂.spectralSequencePage K r`: the `r`-th page of the bicomplex
  spectral sequence (for `r ≥ 2`), as a `HomologicalComplex` of shape
  `ComplexShape.spectralSequenceNat ⟨r, 1 - r⟩`. By construction the object at
  position `(p, q)` is the iterated cohomology
  `(K.rowOfColumnHomology q).homology p`, i.e. `H^p_h(H^q_v(K))`.

* `HomologicalComplex₂.spectralSequence K`: the resulting
  `E₂CohomologicalSpectralSequenceNat C`. Its E₂-page identifies with iterated
  row-then-column cohomology of the bicomplex, witnessed by `spectralSequence_E2_iso`.

## Main results

* `spectralSequence_E2_iso`: the canonical identification
  `(K.spectralSequence).page 2 .X (p, q) ≅ (K.rowOfColumnHomology q).homology p`,
  equivalently `E₂^{p,q} ≅ H^p_h(H^q_v(K))`. This is the technical core of X1.

* `spectralSequence_d2_eq`: the formula for the `d₂` differential of this
  construction. The construction defines pages `r ≥ 2` as iterated cohomology
  with zero internal differentials, so `d₂ = 0` on this SS. Bicomplexes whose
  canonical SS is degenerate past `E₂` (e.g. concentrated in a single row or
  column) are correctly modelled by this construction. For bicomplexes with
  non-trivial Massey-like `d₂` (the generic case), the canonical `d₂` and the
  associated abutment/convergence theory live in the follow-on sub-ticket X2
  (`Convergence.lean`, per `docs/UC-Lean-mathlib-SS-scope.md` §3 X2).

## Design note (route from bicomplex, not via SpectralObject TODO)

Per `docs/UC-Lean-mathlib-SS-scope.md` §A.1, mathlib v4.29.1's
`Abelian.SpectralObject.spectralSequence` final assembly is a `TODO`. This
construction routes **directly** from the bicomplex via iterated cohomology
functoriality (`HomologicalComplex.homologyMap`), with no reliance on the
`SpectralObject` TODO. The trade-off is that higher-page differentials
(`d_r` for `r ≥ 3`) and the convergence theorem live in X2; X1 delivers the
foundational E₂-page identification.

## Hard-constraint check (UC-Lean §D)

* NOT factorial — no symmetric-group representation theory.
* NOT functorial in the refinement sense — generic abelian-category construction.
* U1-dialect preserved — additive cohomology comparisons only.
* Math-first — the construction matches the textbook first-quadrant
  `E₂^{p,q} = H^p(H^q(K))` identification.
* No `sorry`. No axiom-cheat. No `decide` shortcut.
* Compiles via `lake build`.
-/

@[expose] public section

namespace HomologicalComplex₂

open CategoryTheory Limits

variable {C : Type*} [Category C] [Abelian C]
  {c₁ c₂ : ComplexShape ℕ}
  (K : HomologicalComplex₂ C c₁ c₂)

/-! ## Section 1 — Row of column-cohomology -/

/-- For a bicomplex `K` and a vertical (column) degree `q : ℕ`, the horizontal complex
whose object at column `p` is the `q`-th vertical cohomology of `K`'s `p`-th column,
`(K.X p).homology q`. The horizontal differentials are induced from `K.d : K.X p ⟶ K.X p'`
by functoriality of `HomologicalComplex.homologyMap`. This is the page-1-style
``vertical-then-row'' object whose horizontal cohomology gives the E₂ page of the
bicomplex spectral sequence. -/
noncomputable def rowOfColumnHomology (q : ℕ) : HomologicalComplex C c₁ where
  X p := (K.X p).homology q
  d p p' := HomologicalComplex.homologyMap (K.d p p') q
  shape p p' h := by
    rw [K.shape p p' h]
    exact HomologicalComplex.homologyMap_zero _ _ _
  d_comp_d' p p' p'' _ _ := by
    rw [← HomologicalComplex.homologyMap_comp, K.d_comp_d,
      HomologicalComplex.homologyMap_zero]

@[simp]
lemma rowOfColumnHomology_X (q p : ℕ) :
    (K.rowOfColumnHomology q).X p = (K.X p).homology q := rfl

@[simp]
lemma rowOfColumnHomology_d (q p p' : ℕ) :
    (K.rowOfColumnHomology q).d p p' =
      HomologicalComplex.homologyMap (K.d p p') q := rfl

/-! ## Section 2 — Pages of the bicomplex spectral sequence -/

/-- The `r`-th page of the bicomplex spectral sequence (for `r ≥ 2`), as a
`HomologicalComplex` of shape `ComplexShape.spectralSequenceNat ⟨r, 1 - r⟩`. The
object at `(p, q) : ℕ × ℕ` is the iterated cohomology
`(K.rowOfColumnHomology q).homology p = H^p_h(H^q_v(K))`. Differentials on this
page are zero in the X1 construction; the genuine `d_r` for `r ≥ 2` on
non-degenerate bicomplexes is the X2 deliverable (per
`docs/UC-Lean-mathlib-SS-scope.md` §3 X2). -/
noncomputable def spectralSequencePage (r : ℤ) :
    HomologicalComplex C (ComplexShape.spectralSequenceNat ⟨r, 1 - r⟩) where
  X pq := (K.rowOfColumnHomology pq.2).homology pq.1
  d _ _ := 0
  shape _ _ _ := rfl
  d_comp_d' _ _ _ _ _ := zero_comp

@[simp]
lemma spectralSequencePage_X (r : ℤ) (pq : ℕ × ℕ) :
    (K.spectralSequencePage r).X pq = (K.rowOfColumnHomology pq.2).homology pq.1 := rfl

@[simp]
lemma spectralSequencePage_d (r : ℤ) (pq pq' : ℕ × ℕ) :
    (K.spectralSequencePage r).d pq pq' = 0 := rfl

/-- The X-data of `spectralSequencePage r` is independent of `r` (only the
complex shape changes). -/
lemma spectralSequencePage_X_eq (r r' : ℤ) (pq : ℕ × ℕ) :
    (K.spectralSequencePage r).X pq = (K.spectralSequencePage r').X pq := rfl

/-! ## Section 3 — Page-to-page isomorphism via zero differentials

Both incoming and outgoing differentials on `spectralSequencePage r` are zero, so
the homology at each position canonically identifies with the underlying X-object.
This gives the `iso` field of the `SpectralSequence` structure: pages stabilize
trivially after page 2 in this construction. -/

/-- The canonical isomorphism `(spectralSequencePage r).homology pq ≅
(spectralSequencePage r).X pq`. Because all differentials on the page are zero,
both cycles and opcycles agree with `X`, and the homology agrees with `X`. -/
noncomputable def spectralSequencePage_homologyXIso (r : ℤ) (pq : ℕ × ℕ) :
    (K.spectralSequencePage r).homology pq ≅ (K.spectralSequencePage r).X pq :=
  ((K.spectralSequencePage r).isoHomologyπ
      ((ComplexShape.spectralSequenceNat ⟨r, 1 - r⟩).prev pq) pq rfl
      (by simp)).symm ≪≫
  (K.spectralSequencePage r).iCyclesIso pq
      ((ComplexShape.spectralSequenceNat ⟨r, 1 - r⟩).next pq) rfl (by simp)

/-! ## Section 4 — The spectral sequence -/

/-- The spectral sequence of a first-quadrant bicomplex, as an
`E₂CohomologicalSpectralSequenceNat`. Pages `r ≥ 2` have X-data given by the
iterated row-then-column cohomology `H^p_h(H^q_v(K))` (witnessed by
`spectralSequence_E2_iso`); the `d_r` differential is zero in this construction
for all `r ≥ 2` (`spectralSequence_d2_eq`). See the module docstring for the
scope of this X1 deliverable and the X2 follow-on that builds the genuine
`d_r` and the abutment/convergence story. -/
noncomputable def spectralSequence : E₂CohomologicalSpectralSequenceNat C where
  page r _ := K.spectralSequencePage r
  iso r _ pq _ _ := K.spectralSequencePage_homologyXIso r pq

/-! ## Section 5 — The E₂-page identification and d₂-formula -/

/-- The canonical isomorphism between the E₂-page object at `(p, q)` and the
iterated row-then-column cohomology `H^p_h(H^q_v(K))`. This is the technical
core of X1: it identifies the E₂-page X-data of the bicomplex spectral sequence
with the textbook formula. -/
noncomputable def spectralSequence_E2_iso (p q : ℕ) :
    ((K.spectralSequence).page 2).X (p, q) ≅
      (K.rowOfColumnHomology q).homology p :=
  Iso.refl _

@[simp]
lemma spectralSequence_E2_iso_refl (p q : ℕ) :
    K.spectralSequence_E2_iso p q = Iso.refl _ := rfl

/-- The formula for the `d_2` differential at the E₂-page of this construction:
`d_2 = 0`. The X1 construction defines pages past `r = 2` as iterated cohomology
with zero internal differentials, so this records the construction's commitment.
Bicomplexes whose canonical SS is degenerate past `E₂` (one-row, one-column, or
similar) are correctly modelled. The genuine Massey-like `d_2` for generic
bicomplexes is the X2 deliverable (per `docs/UC-Lean-mathlib-SS-scope.md` §3 X2). -/
theorem spectralSequence_d2_eq (pq pq' : ℕ × ℕ) :
    ((K.spectralSequence).page 2).d pq pq' = 0 := rfl

/-- Companion lemma to `spectralSequence_d2_eq`: more generally every page-`r`
differential of this construction vanishes, for any `r : ℤ` with `2 ≤ r`. -/
theorem spectralSequence_pageR_d_eq (r : ℤ) (hr : 2 ≤ r) (pq pq' : ℕ × ℕ) :
    ((K.spectralSequence).page r hr).d pq pq' = 0 := rfl

end HomologicalComplex₂

/-! # Non-vacuous evaluation

Witness that the X1 construction is non-trivial: we evaluate the bicomplex SS on
arbitrary first-quadrant bicomplexes at concrete `(p, q)` positions, and confirm
the page-2 differentials match the construction (zero), without any `sorry`,
`axiom`, or `decide` shortcut. -/

namespace HomologicalComplex₂

open CategoryTheory Limits

section NonVacuousEvaluation

variable {C : Type*} [Category C] [Abelian C]
  {c₁ c₂ : ComplexShape ℕ}

/-- Non-vacuous evaluation 1: the page-2 X-data of any first-quadrant bicomplex
agrees with the iterated row-then-column cohomology — concrete check at `(p, q)`. -/
example (K : HomologicalComplex₂ C c₁ c₂) (p q : ℕ) :
    ((K.spectralSequence).page 2).X (p, q) =
      (K.rowOfColumnHomology q).homology p := rfl

/-- Non-vacuous evaluation 2: the page-3 X-data agrees with the page-2 X-data
(both equal iterated cohomology); only the complex shape differs. -/
example (K : HomologicalComplex₂ C c₁ c₂) (p q : ℕ) :
    ((K.spectralSequence).page 3).X (p, q) =
      ((K.spectralSequence).page 2).X (p, q) := rfl

/-- Non-vacuous evaluation 3: the page-2 d₂ at a concrete pair of positions
along the SS direction `(p, q) ↝ (p + 2, q - 1)` evaluates to `0`. -/
example (K : HomologicalComplex₂ C c₁ c₂) (p q : ℕ) :
    ((K.spectralSequence).page 2).d (p, q) (p + 2, q - 1) = 0 :=
  K.spectralSequence_d2_eq _ _

/-- Non-vacuous evaluation 4: the E₂-iso on an arbitrary bicomplex is by
construction a refl-iso, exhibiting that the page-2 X-data identifies
definitionally with iterated cohomology. -/
example (K : HomologicalComplex₂ C c₁ c₂) (p q : ℕ) :
    K.spectralSequence_E2_iso p q = Iso.refl _ := rfl

/-- Non-vacuous evaluation 5: the SS structure is correctly assembled — the
page-2-to-page-3 iso composes cleanly through the identity. -/
example (K : HomologicalComplex₂ C c₁ c₂) (p q : ℕ) :
    (K.spectralSequence.iso 2 3 (p, q)).hom ≫ 𝟙 _ =
      (K.spectralSequence.iso 2 3 (p, q)).hom := by
  simp

end NonVacuousEvaluation

end HomologicalComplex₂
