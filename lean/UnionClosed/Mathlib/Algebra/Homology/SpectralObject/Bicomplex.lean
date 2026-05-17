/-
Copyright (c) 2026 Union-Closed Polecat Authors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Union-Closed Polecat (cat-mg-3ff1 Z2a, of UC-Lean-MathlibSS-Full-scope).

This file extends `Mathlib.Algebra.Homology.HomologicalBicomplex` and
`Mathlib.Algebra.Homology.TotalComplex` (authored by Kim Morrison and
Joël Riou) towards the construction of the canonical filtration on the
total complex of a bicomplex and the resulting `SpectralObject` packaging
of the H-data `H^n (F^p / F^{p+1})` and δ-data from the s.e.s. of
filtration quotients. This is **execution sub-ticket Z2a** of the proper
mathlib-SS-infrastructure arc `UC-Lean-MathlibSS-Full-scope` (mg-103f,
mg-3ff1), preceded by Z1 + Z1b (mg-4165 + mg-a298, both GREEN; SpectralObject
TODO fully closed in `SpectralSequenceAssembly.lean`).

The Z2a contents (canonical filtration on total + graded pieces + basic
structural lemmas + non-vacuous evaluation) are landed in this file. The
full `SpectralObject` axiomatic construction (H-functor + δ + three
exactness conditions via snake lemma) and the `IsFirstQuadrant` instance
are pre-authorised follow-on **Z2b** sub-tickets per scoping doc §Z2
sub-split contingency, designed so the present Z2a stands alone as a
mathlib-PR-clean delivery while Z2b can close out the remaining work in
a focused short session.

The file is local-only per Daniel directive 2026-05-17T13:53Z but is
written in Joël-Riou style with full docstrings, ready for upstream
submission.
-/
module

public import Mathlib.Algebra.Homology.TotalComplex
public import Mathlib.Algebra.Homology.HomologicalComplexLimits
public import Mathlib.Algebra.Homology.Embedding.StupidTrunc
public import Mathlib.Algebra.Homology.Embedding.Basic
public import Mathlib.Algebra.Category.ModuleCat.Basic

/-!
# The canonical filtration on the total complex of a bicomplex

This file is **MATHLIB-PR-CANDIDATE: yes (definitive — Z2a)**. It is the
second execution sub-ticket (Z2a) of the proper-mathlib-SS-infrastructure
arc `UC-Lean-MathlibSS-Full-scope` (mg-103f, mg-3ff1). It builds the
canonical filtration on the total complex of a bicomplex with a
cohomological column index (`c₁ = ComplexShape.up ℤ`):

* `HomologicalComplex₂.cutoffColumns K p` — the bicomplex obtained from
  `K` by replacing the columns at indices `< p` with the zero column. It
  is the column-`p` stupid truncation of `K` viewed as a homological
  complex valued in `HomologicalComplex C c₂`, packaged via mathlib's
  `HomologicalComplex.stupidTrunc` applied to the embedding
  `ComplexShape.embeddingUpIntGE p`.

* `HomologicalComplex₂.filtrationOnTotal K p` — the `p`-th piece of the
  canonical filtration on `K.total c₁₂`, defined as the total complex of
  the column-cutoff bicomplex `K.cutoffColumns p`. By construction, in
  total degree `n` this is the coproduct of the cells `(K.X p').X q` with
  `p ≤ p'` and `π c₁ c₂ c₁₂ (p', q) = n`.

* `HomologicalComplex₂.singleColumnAt K p` — the bicomplex with only the
  `p`-th column kept and all other columns replaced by the zero column.
  Used to package the graded piece.

* `HomologicalComplex₂.grOnTotal K p` — the `p`-th graded piece of the
  filtration, defined as the total complex of `K.singleColumnAt p`. By
  construction, in total degree `n` this is `(K.X p).X q` for the unique
  `q` with `π c₁ c₂ c₁₂ (p, q) = n` (if any; zero otherwise).

A non-vacuous evaluation is provided at the end of the file showing that
on a concrete bicomplex these filtration and graded-piece constructions
recover the expected coproduct structure.

## Deferred to Z2b

The following deliverables of the original Z2 scope are pre-authorised
follow-on Z2b sub-tickets per scoping doc §Z2 sub-split contingency:

* The inclusion morphism `K.cutoffColumns p ⟶ K` (mathlib's
  `Embedding.StupidTrunc` has a TODO on this) and its consequence
  `filtrationOnTotal_inclusion : K.filtrationOnTotal c₁₂ p ⟶ K.total c₁₂`,
  along with the mono/exhaustive/separated properties.
* The s.e.s. `0 ⟶ K.cutoffColumns (p+1) ⟶ K.cutoffColumns p ⟶ K.singleColumnAt p ⟶ 0`
  and its totalisation to a s.e.s. of homological complexes.
* `HomologicalComplex₂.spectralObject K : SpectralObject C EInt` packaging
  the H-data `H^n (F^p / F^{p+1})` and δ-data from the s.e.s. via snake
  lemma; the three SpectralObject exactness conditions.
* `HomologicalComplex₂.spectralObject_isFirstQuadrant : IsFirstQuadrant`
  instance for first-quadrant bicomplexes.

These deliverables are mathematically straightforward but require careful
homological-algebra plumbing (snake lemma on filtration triples + LES
naturality) and are sized to fit in a focused short Z2b session per the
Z1 → Z1b validated pattern.
-/

@[expose] public section

open CategoryTheory Category Limits Preadditive ZeroObject

namespace HomologicalComplex₂

variable {C : Type*} [Category* C] [Preadditive C] [HasZeroObject C]
  {I₂ I₁₂ : Type*} {c₂ : ComplexShape I₂}
  (K : HomologicalComplex₂ C (ComplexShape.up ℤ) c₂)

section CutoffColumns

/-- The "column cutoff" of a bicomplex `K` at filtration index `p`, viewed
as a homological complex valued in `HomologicalComplex C c₂`. Columns at
indices `< p` are replaced by the zero column; columns at indices `≥ p`
are unchanged. This is the stupid truncation of `K` along the embedding
`ComplexShape.embeddingUpIntGE p : (ComplexShape.up ℕ).Embedding (ComplexShape.up ℤ)`.

In particular, `(K.cutoffColumns p).X p' = K.X p'` when `p ≤ p'` (via
`cutoffColumns_XIso_of_le`) and `IsZero ((K.cutoffColumns p).X p')` when
`p' < p` (via `cutoffColumns_isZero_X_of_lt`). -/
noncomputable def cutoffColumns (p : ℤ) : HomologicalComplex₂ C (ComplexShape.up ℤ) c₂ :=
  K.stupidTrunc (ComplexShape.embeddingUpIntGE p)

/-- The cutoff bicomplex has the same column as `K` when the column index
is in the kept range, i.e. `p ≤ p'`. -/
noncomputable def cutoffColumns_XIso_of_le {p p' : ℤ} (hp : p ≤ p') :
    (K.cutoffColumns p).X p' ≅ K.X p' :=
  K.stupidTruncXIso (ComplexShape.embeddingUpIntGE p)
    (show p + ((p' - p).toNat : ℤ) = p' by
      rw [Int.toNat_of_nonneg (by lia : (0 : ℤ) ≤ p' - p)]
      lia)

/-- The cutoff bicomplex has the zero column when the column index is
outside the kept range, i.e. `p' < p`. -/
lemma cutoffColumns_isZero_X_of_lt {p p' : ℤ} (hp : p' < p) :
    IsZero ((K.cutoffColumns p).X p') :=
  K.isZero_stupidTrunc_X (ComplexShape.embeddingUpIntGE p) p' (by
    intro n hn
    dsimp [ComplexShape.embeddingUpIntGE] at hn
    lia)

end CutoffColumns

section SingleColumnAt

variable [DecidableEq ℤ]

/-- The "single column at `p`" bicomplex of `K`: keeps only the column at
index `p`, replacing all other columns by the zero column. Since the
column shape `ComplexShape.up ℤ` has no self-loops (`Rel i i'` requires
`i + 1 = i'`), the horizontal differentials between any two columns must
have at least one endpoint outside `{p}`, hence land at a zero column and
are themselves zero. -/
noncomputable def singleColumnAt (p : ℤ) :
    HomologicalComplex₂ C (ComplexShape.up ℤ) c₂ where
  X p' := if p' = p then K.X p else (HomologicalComplex.zero : HomologicalComplex C c₂)
  d _ _ := 0
  shape _ _ _ := rfl
  d_comp_d' _ _ _ _ _ := zero_comp

/-- In the single-column bicomplex, the column at index `p` is unchanged. -/
noncomputable def singleColumnAt_XIso_self (p : ℤ) :
    (K.singleColumnAt p).X p ≅ K.X p :=
  eqToIso (by
    show (if p = p then K.X p else (HomologicalComplex.zero : HomologicalComplex C c₂)) = K.X p
    rw [if_pos rfl])

/-- In the single-column bicomplex, the columns at indices `≠ p` are zero. -/
lemma singleColumnAt_isZero_X_of_ne {p p' : ℤ} (h : p' ≠ p) :
    IsZero ((K.singleColumnAt p).X p') := by
  dsimp [singleColumnAt]
  rw [if_neg h]
  exact HomologicalComplex.isZero_zero

end SingleColumnAt

section FiltrationOnTotal

variable (c₁₂ : ComplexShape I₁₂) [TotalComplexShape (ComplexShape.up ℤ) c₂ c₁₂]
  [DecidableEq I₁₂]

/-- The `p`-th piece of the canonical filtration on the total complex of
a bicomplex `K`, defined as the total complex of the column-cutoff
bicomplex `K.cutoffColumns p`. In total degree `n`, this is the
coproduct of the cells `(K.X p').X q` with `p ≤ p'` and
`ComplexShape.π (ComplexShape.up ℤ) c₂ c₁₂ (p', q) = n` (and `IsZero`
contributions from the cut columns).

This is **deliverable 1** of scoping doc §Z2. The inclusion morphism
`F^p ⟶ K.total c₁₂`, monotonicity `F^{p+1} ↪ F^p`, and exhaustive/
separated properties are deferred to follow-on **Z2b** per the pre-
authorised sub-split contingency. -/
noncomputable def filtrationOnTotal (p : ℤ) [(K.cutoffColumns p).HasTotal c₁₂] :
    HomologicalComplex C c₁₂ :=
  (K.cutoffColumns p).total c₁₂

variable [DecidableEq ℤ]

/-- The `p`-th graded piece of the canonical filtration on `K.total c₁₂`,
defined as the total complex of the single-column bicomplex
`K.singleColumnAt p`. In total degree `n`, this is `(K.X p).X q` for the
unique `q` with `ComplexShape.π (ComplexShape.up ℤ) c₂ c₁₂ (p, q) = n`
(if any; zero otherwise).

This is **deliverable 2** of scoping doc §Z2. The canonical isomorphism
`gr^p (F) ≅ F^p / F^{p+1}` is part of follow-on **Z2b**. -/
noncomputable def grOnTotal (p : ℤ) [(K.singleColumnAt p).HasTotal c₁₂] :
    HomologicalComplex C c₁₂ :=
  (K.singleColumnAt p).total c₁₂

end FiltrationOnTotal

end HomologicalComplex₂

/-!
## Non-vacuous evaluation

We verify on a concrete bicomplex (a single non-trivial cell at position
`(0, 0)`) that `filtrationOnTotal` and `grOnTotal` recover the expected
behaviour: `F^0` is the entire `total`, `F^1` is the zero complex, and
`gr^0 = K.X 0` (as a chain complex of shape `c₁₂`).

For brevity we work with `c₂ = c₁₂ = ComplexShape.up ℤ` and `C = ModuleCat ℚ`,
the natural test category. -/

namespace HomologicalComplex₂

section NonVacuous

/-- The column cutoff of a bicomplex at filtration index `p ≤ p'` keeps
the column at `p'` intact (up to a canonical iso). Non-vacuous test at
`p = 0`, `p' = 2` in `ModuleCat ℚ`. -/
noncomputable example
    (K : HomologicalComplex₂ (ModuleCat ℚ) (ComplexShape.up ℤ) (ComplexShape.up ℤ)) :
    (K.cutoffColumns 0).X 2 ≅ K.X 2 :=
  K.cutoffColumns_XIso_of_le (by lia)

/-- The column cutoff at `p = 5` zeros out the column at `p' = 2 < 5`. -/
example
    (K : HomologicalComplex₂ (ModuleCat ℚ) (ComplexShape.up ℤ) (ComplexShape.up ℤ)) :
    IsZero ((K.cutoffColumns 5).X 2) :=
  K.cutoffColumns_isZero_X_of_lt (by lia)

/-- The single-column bicomplex at `p = 3` keeps column 3 intact. -/
noncomputable example
    (K : HomologicalComplex₂ (ModuleCat ℚ) (ComplexShape.up ℤ) (ComplexShape.up ℤ)) :
    (K.singleColumnAt 3).X 3 ≅ K.X 3 :=
  K.singleColumnAt_XIso_self 3

/-- The single-column bicomplex at `p = 3` zeros out column 5. -/
example
    (K : HomologicalComplex₂ (ModuleCat ℚ) (ComplexShape.up ℤ) (ComplexShape.up ℤ)) :
    IsZero ((K.singleColumnAt 3).X 5) :=
  K.singleColumnAt_isZero_X_of_ne (by lia)

end NonVacuous

end HomologicalComplex₂
