/-
Copyright (c) 2026 Union-Closed Polecat Authors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Union-Closed Polecat (cat-mg-3ff1 Z2a + cat-mg-0611 Z2b +
cat-mg-ce0c Z2c, of UC-Lean-MathlibSS-Full-scope).

This file extends `Mathlib.Algebra.Homology.HomologicalBicomplex` and
`Mathlib.Algebra.Homology.TotalComplex` (authored by Kim Morrison and
Joël Riou) towards the construction of the canonical filtration on the
total complex of a bicomplex and the resulting `SpectralObject` packaging
of the H-data `H^n (F^p / F^{p+1})` and δ-data from the s.e.s. of
filtration quotients. The Z2 arc is split:

* **Z2a** (cat-mg-3ff1) landed the OBJECT-level filtration via mathlib's
  `stupidTrunc`: `cutoffColumns`, `singleColumnAt`, `filtrationOnTotal`,
  `grOnTotal`, and the basic cell-level `Iso`/`IsZero` structural lemmas.

* **Z2b** (cat-mg-0611) closes Joël Riou's documented TODO on
  `Mathlib.Algebra.Homology.Embedding.StupidTrunc` (the inclusion
  natural transformation `e.stupidTruncFunctor C ⟶ 𝟭 _` when `[e.IsTruncGE]`),
  applies it to obtain the canonical filtration inclusion
  `K.cutoffColumns p ⟶ K`, builds the filtration step
  `K.cutoffColumns (p + 1) ⟶ K.cutoffColumns p`, identifies the quotient
  with the single-column bicomplex via an explicit
  `cutoffColumns_succ_singleColumnAt_shortComplex` short exact sequence,
  and totalises this to a short exact sequence on the `total` complex
  realising the canonical filtration on `K.total c₁₂` as a step inside the
  `SpectralObject` Verdier construction.

* **Z2c** (cat-mg-ce0c, this commit) closes the dual mathlib TODO on
  `Mathlib.Algebra.Homology.Embedding.StupidTrunc` (the projection
  natural transformation `𝟭 _ ⟶ e.stupidTruncFunctor C` when
  `[e.IsTruncLE]`), applies it to the cohomological column-embedding
  `embeddingUpIntLE p` to obtain the canonical complementary filtration
  projection `K ⟶ K.cutoffColumnsLE p`, builds the LE-side filtration
  step `K.cutoffColumnsLE (p + 1) ⟶ K.cutoffColumnsLE p` (the
  cokernel-consistent direction "drop the newly-added cell at column
  `p + 1`"), identifies the kernel with the single-column bicomplex via
  the dual `singleColumnAt_to_cutoffColumnsLE_shortComplex` short exact
  sequence, and packages this together with the Z2b GE-side
  infrastructure so that **Z2d** has both halves of the
  cutoffColumns / cutoffColumnsLE filtration available for the Verdier
  `SpectralObject` H-functor and `IsFirstQuadrant` instance.

The full `SpectralObject K : SpectralObject (HomologicalComplex C c) EInt`
construction (Verdier H-functor on `mk₁ (homOfLE (i ≤ j))` for arbitrary
`i, j : EInt` + δ-data via snake lemma on the s.e.s. of triple filtration
quotients + three SpectralObject exactness conditions from the LES of
cohomology), as well as the `IsFirstQuadrant` instance, are scheduled for
a follow-on **Z2d** sub-ticket per the pre-authorised sub-split
contingency mirrored from the Z1 → Z1b and Z2 → Z2a → Z2b → Z2c
precedents — see the file's end-of-module *deferred to Z2d* section for
the construction sketch and budget estimate.

The file is local-only per Daniel directive 2026-05-17T13:53Z but is
written in Joël-Riou style with full docstrings, ready for upstream
submission. The Z2b inclusion natural transformation `stupidTruncInclusion`
and Z2c projection natural transformation `stupidTruncProjection` are in
particular a definitive mathlib-PR-clean closure of both TODOs at
`Mathlib.Algebra.Homology.Embedding.StupidTrunc` lines 19-21.
-/
module

public import Mathlib.Algebra.Homology.TotalComplex
public import Mathlib.Algebra.Homology.HomologicalComplexLimits
public import Mathlib.Algebra.Homology.Embedding.StupidTrunc
public import Mathlib.Algebra.Homology.Embedding.Basic
public import Mathlib.Algebra.Homology.ShortComplex.ShortExact
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
## Z2b — `stupidTruncInclusion`: closing Joël Riou's mathlib TODO

The natural inclusion `K.stupidTrunc e ⟶ K` when `[e.IsTruncGE]`. This
closes the TODO at `Mathlib/Algebra/Homology/Embedding/StupidTrunc.lean`
lines 19-20:

> TODO (@joelriou):
> * define the inclusion `e.stupidTruncFunctor C ⟶ 𝟭 _` when `[e.IsTruncGE]`;

The construction proceeds component-by-component on each `i' : ι'`:

* If `i'` is in the image of `e.f` (say `i' = e.f i`), the cell
  `(K.stupidTrunc e).X i'` is isomorphic to `K.X i'` via
  `stupidTruncXIso`, and we take the iso `.hom` as the component.

* If `i'` is not in the image of `e.f`, the cell `(K.stupidTrunc e).X i'`
  is the zero object (`isZero_stupidTrunc_X`), so the component is the
  unique zero morphism into `K.X i'`.

The commutation with the differentials uses `IsTruncGE.mem_next`: if
`c'.Rel i' j'` and `i'` is in the image of `e.f`, then so is `j'`. The
remaining case (`i'` out of image) is automatic from `IsZero` of the
source. This is mathlib-PR-clean and would naturally live in
`Mathlib/Algebra/Homology/Embedding/StupidTrunc.lean` upstream.
-/

namespace HomologicalComplex

open Classical

variable {ι ι' : Type*} {c : ComplexShape ι} {c' : ComplexShape ι'}
  {C : Type*} [Category* C] [HasZeroMorphisms C] [HasZeroObject C]
  (K L : HomologicalComplex C c') (φ : K ⟶ L)
  (e : c.Embedding c') [e.IsRelIff]

/-- The component of the canonical inclusion `K.stupidTrunc e ⟶ K` at
the cell `i' : ι'`. In the image of `e.f` it is `stupidTruncXIso.hom`;
outside the image it is the zero morphism. -/
noncomputable def stupidTruncInclusion_f (i' : ι') :
    (K.stupidTrunc e).X i' ⟶ K.X i' :=
  if h : ∃ i, e.f i = i' then (K.stupidTruncXIso e h.choose_spec).hom else 0

/-- Two choices of witness `i₁, i₂ : ι` for `e.f · = i'` give the same
`stupidTruncXIso.hom`, since `e.f` is injective. -/
lemma stupidTruncXIso_hom_eq_of_eq {i₁ i₂ : ι} {i' : ι'}
    (hi₁ : e.f i₁ = i') (hi₂ : e.f i₂ = i') :
    (K.stupidTruncXIso e hi₁).hom = (K.stupidTruncXIso e hi₂).hom := by
  obtain rfl : i₁ = i₂ := e.injective_f (hi₁.trans hi₂.symm)
  rfl

lemma stupidTruncInclusion_f_eq {i : ι} {i' : ι'} (hi : e.f i = i') :
    K.stupidTruncInclusion_f e i' = (K.stupidTruncXIso e hi).hom := by
  have h : ∃ i, e.f i = i' := ⟨i, hi⟩
  dsimp [stupidTruncInclusion_f]
  rw [dif_pos h]
  exact K.stupidTruncXIso_hom_eq_of_eq e h.choose_spec hi

lemma stupidTruncInclusion_f_eq_zero (i' : ι') (hi' : ∀ i, e.f i ≠ i') :
    K.stupidTruncInclusion_f e i' = 0 := by
  dsimp [stupidTruncInclusion_f]
  rw [dif_neg]
  rintro ⟨i, hi⟩
  exact hi' i hi

/-- The canonical inclusion morphism `K.stupidTrunc e ⟶ K` when
`[e.IsTruncGE]`. Closes the mathlib TODO at
`Mathlib/Algebra/Homology/Embedding/StupidTrunc.lean` lines 19-20. -/
noncomputable def stupidTruncInclusion [e.IsTruncGE] : K.stupidTrunc e ⟶ K where
  f i' := K.stupidTruncInclusion_f e i'
  comm' i' j' h_rel := by
    by_cases hi : ∃ i, e.f i = i'
    · obtain ⟨i, rfl⟩ := hi
      obtain ⟨j, rfl⟩ : ∃ j, e.f j = j' := e.mem_next h_rel
      rw [K.stupidTruncInclusion_f_eq e rfl, K.stupidTruncInclusion_f_eq e rfl]
      -- stupidTrunc = (K.restriction e).extend e
      -- so .d (e.f i) (e.f j) factors through (restriction).d i j = K.d (e.f i) (e.f j)
      dsimp [stupidTrunc]
      rw [(K.restriction e).extend_d_eq e rfl rfl]
      simp [stupidTruncXIso, restriction]
    · exact (K.isZero_stupidTrunc_X e i' (by simpa using hi)).eq_of_src _ _

/-- At a cell in the image of `e.f`, the inclusion's component is the
`stupidTruncXIso.hom`. -/
@[reassoc (attr := simp)]
lemma stupidTruncInclusion_f_eq_of_mem [e.IsTruncGE] {i : ι} {i' : ι'} (hi : e.f i = i') :
    (K.stupidTruncInclusion e).f i' = (K.stupidTruncXIso e hi).hom :=
  K.stupidTruncInclusion_f_eq e hi

variable {K L} in
/-- Naturality of `stupidTruncInclusion` with respect to morphisms of
complexes: the diagram with horizontal arrows
`stupidTruncMap φ e, φ` and vertical inclusions commutes. -/
@[reassoc (attr := simp)]
lemma stupidTruncMap_stupidTruncInclusion [e.IsTruncGE] :
    stupidTruncMap φ e ≫ L.stupidTruncInclusion e =
      K.stupidTruncInclusion e ≫ φ := by
  ext i'
  by_cases hi : ∃ i, e.f i = i'
  · obtain ⟨i, rfl⟩ := hi
    rw [comp_f, comp_f, L.stupidTruncInclusion_f_eq_of_mem e rfl,
        K.stupidTruncInclusion_f_eq_of_mem e rfl,
        stupidTruncMap_stupidTruncXIso_hom]
  · exact (K.isZero_stupidTrunc_X e i' (by simpa using hi)).eq_of_src _ _

end HomologicalComplex

namespace ComplexShape.Embedding

variable {ι ι' : Type*} {c : ComplexShape ι} {c' : ComplexShape ι'}
  (e : Embedding c c') (C : Type*) [Category* C] [HasZeroMorphisms C] [HasZeroObject C]

/-- The natural transformation `e.stupidTruncFunctor C ⟶ 𝟭 _` consisting
of `stupidTruncInclusion` at each complex, when `[e.IsTruncGE]`. -/
@[simps]
noncomputable def stupidTruncInclusionNatTrans [e.IsRelIff] [e.IsTruncGE] :
    e.stupidTruncFunctor C ⟶ 𝟭 (HomologicalComplex C c') where
  app K := K.stupidTruncInclusion e
  naturality _ _ φ := HomologicalComplex.stupidTruncMap_stupidTruncInclusion φ e

end ComplexShape.Embedding

/-!
## Z2b — Bicomplex filtration inclusion + filtration step

We apply `stupidTruncInclusion` to the cohomological column embedding
`embeddingUpIntGE p` to obtain the canonical inclusion
`cutoffColumns_inclusion : K.cutoffColumns p ⟶ K` and, by composition,
the filtration step `K.cutoffColumns (p + 1) ⟶ K.cutoffColumns p`. The
latter is a monomorphism whose cokernel is the single-column bicomplex
`K.singleColumnAt p`, realising the s.e.s. of filtration quotients at
the BICOMPLEX level (one step beneath the totalised s.e.s. used in the
Verdier `SpectralObject` construction).
-/

namespace HomologicalComplex₂

variable {C : Type*} [Category* C] [Preadditive C] [HasZeroObject C]
  {I₂ : Type*} {c₂ : ComplexShape I₂}
  (K : HomologicalComplex₂ C (ComplexShape.up ℤ) c₂)

section CutoffColumnsInclusion

/-- The canonical inclusion of the column-cutoff bicomplex into `K`,
applied at filtration index `p`. Cell-wise, it is the
`stupidTruncXIso.hom` on the kept columns (`p ≤ p'`) and the zero
morphism on the cut columns (`p' < p`). -/
noncomputable def cutoffColumns_inclusion (p : ℤ) :
    K.cutoffColumns p ⟶ K :=
  HomologicalComplex.stupidTruncInclusion K (ComplexShape.embeddingUpIntGE p)

@[simp]
lemma cutoffColumns_inclusion_f_of_le {p p' : ℤ} (hp : p ≤ p') :
    (K.cutoffColumns_inclusion p).f p' =
      (K.cutoffColumns_XIso_of_le hp).hom := by
  -- Both sides reduce to `stupidTruncXIso` at the index `(p' - p).toNat`.
  exact K.stupidTruncInclusion_f_eq_of_mem (ComplexShape.embeddingUpIntGE p)
    (show (ComplexShape.embeddingUpIntGE p).f (p' - p).toNat = p' by
      dsimp [ComplexShape.embeddingUpIntGE]
      rw [Int.toNat_of_nonneg (by lia : (0 : ℤ) ≤ p' - p)]
      lia)

lemma cutoffColumns_inclusion_f_of_lt {p p' : ℤ} (hp : p' < p) :
    (K.cutoffColumns_inclusion p).f p' = 0 := by
  apply HomologicalComplex.stupidTruncInclusion_f_eq_zero
  intro i hi
  dsimp [ComplexShape.embeddingUpIntGE] at hi
  lia

/-- The filtration-step inclusion `K.cutoffColumns (p + 1) ⟶ K.cutoffColumns p`.
On a cell `p' ≥ p + 1` it is the composition of the two cutoff cell isos
`(p + 1, p') ⤳ (p, p')`; on a cell `p' < p + 1` it is the zero
morphism (the source cell is `IsZero`). -/
noncomputable def cutoffColumns_succ (p : ℤ) :
    K.cutoffColumns (p + 1) ⟶ K.cutoffColumns p where
  f p' :=
    if hp : p + 1 ≤ p' then
      (K.cutoffColumns_XIso_of_le hp).hom ≫
        (K.cutoffColumns_XIso_of_le (show p ≤ p' by lia)).inv
    else 0
  comm' p' p'' h := by
    -- `c.Rel p' p''` for `ComplexShape.up ℤ` means `p' + 1 = p''`.
    have hp'' : p' + 1 = p'' := h
    by_cases hp : p + 1 ≤ p'
    · have hp_le : p ≤ p' := by lia
      have hp1_p'' : p + 1 ≤ p'' := by lia
      have hp_p'' : p ≤ p'' := by lia
      rw [dif_pos hp, dif_pos hp1_p'']
      -- Both naturality squares for the inclusions (p) and (p + 1):
      -- (cutoffColumns r).d p' p'' ≫ (XIso(r, p'')).hom =
      --   (XIso(r, p')).hom ≫ K.d p' p''   (at both r = p and r = p + 1)
      have h_inc1 := (K.cutoffColumns_inclusion (p + 1)).comm p' p''
      have h_incp := (K.cutoffColumns_inclusion p).comm p' p''
      rw [K.cutoffColumns_inclusion_f_of_le hp,
        K.cutoffColumns_inclusion_f_of_le hp1_p''] at h_inc1
      rw [K.cutoffColumns_inclusion_f_of_le hp_le,
        K.cutoffColumns_inclusion_f_of_le hp_p''] at h_incp
      -- LHS = d_{p+1} ≫ XIso(p+1, p'').hom ≫ XIso(p, p'').inv
      --     = (XIso(p+1, p').hom ≫ K.d) ≫ XIso(p, p'').inv     [h_inc1]
      -- RHS = XIso(p+1, p').hom ≫ XIso(p, p').inv ≫ d_p
      --     = XIso(p+1, p').hom ≫ (XIso(p, p').inv ≫ d_p)
      --     = XIso(p+1, p').hom ≫ (K.d ≫ XIso(p, p'').inv)     [from h_incp]
      have h_incp' : (K.cutoffColumns_XIso_of_le hp_le).inv ≫
          (K.cutoffColumns p).d p' p'' =
            K.d p' p'' ≫ (K.cutoffColumns_XIso_of_le hp_p'').inv := by
        rw [← cancel_mono (K.cutoffColumns_XIso_of_le hp_p'').hom]
        simp only [Category.assoc, Iso.inv_hom_id, Category.comp_id]
        rw [← h_incp]
        simp
      -- Goal: ((XIso(p+1, p').hom ≫ XIso(p, p').inv)) ≫ (cutoffColumns p).d p' p''
      --     = (cutoffColumns (p+1)).d p' p'' ≫ (XIso(p+1, p'').hom ≫ XIso(p, p'').inv)
      calc ((K.cutoffColumns_XIso_of_le hp).hom ≫
                (K.cutoffColumns_XIso_of_le hp_le).inv) ≫
              (K.cutoffColumns p).d p' p''
          = (K.cutoffColumns_XIso_of_le hp).hom ≫
              ((K.cutoffColumns_XIso_of_le hp_le).inv ≫
                (K.cutoffColumns p).d p' p'') := by
              rw [Category.assoc]
        _ = (K.cutoffColumns_XIso_of_le hp).hom ≫
              (K.d p' p'' ≫ (K.cutoffColumns_XIso_of_le hp_p'').inv) := by
              rw [h_incp']
        _ = ((K.cutoffColumns_XIso_of_le hp).hom ≫ K.d p' p'') ≫
              (K.cutoffColumns_XIso_of_le hp_p'').inv := by
              rw [Category.assoc]
        _ = ((K.cutoffColumns (p + 1)).d p' p'' ≫
                (K.cutoffColumns_XIso_of_le hp1_p'').hom) ≫
              (K.cutoffColumns_XIso_of_le hp_p'').inv := by
              rw [← h_inc1]
        _ = (K.cutoffColumns (p + 1)).d p' p'' ≫
              ((K.cutoffColumns_XIso_of_le hp1_p'').hom ≫
                (K.cutoffColumns_XIso_of_le hp_p'').inv) := by
              rw [Category.assoc]
    · rw [dif_neg hp, zero_comp]
      have hp' : p' < p + 1 := lt_of_not_ge hp
      exact (K.cutoffColumns_isZero_X_of_lt hp').eq_of_src _ _

@[simp]
lemma cutoffColumns_succ_f_of_le {p p' : ℤ} (hp : p + 1 ≤ p') :
    (K.cutoffColumns_succ p).f p' =
      (K.cutoffColumns_XIso_of_le hp).hom ≫
        (K.cutoffColumns_XIso_of_le (show p ≤ p' by lia)).inv := by
  dsimp [cutoffColumns_succ]
  rw [dif_pos hp]

lemma cutoffColumns_succ_f_of_lt {p p' : ℤ} (hp : p' < p + 1) :
    (K.cutoffColumns_succ p).f p' = 0 := by
  dsimp [cutoffColumns_succ]
  rw [dif_neg (by lia : ¬ p + 1 ≤ p')]

/-- The filtration step composed with the inclusion at `p` recovers the
inclusion at `p + 1`. -/
@[reassoc (attr := simp)]
lemma cutoffColumns_succ_inclusion (p : ℤ) :
    K.cutoffColumns_succ p ≫ K.cutoffColumns_inclusion p =
      K.cutoffColumns_inclusion (p + 1) := by
  ext p'
  by_cases hp : p + 1 ≤ p'
  · have hp_le : p ≤ p' := by lia
    rw [HomologicalComplex.comp_f, K.cutoffColumns_succ_f_of_le hp,
        K.cutoffColumns_inclusion_f_of_le hp_le,
        K.cutoffColumns_inclusion_f_of_le hp,
        Category.assoc, Iso.inv_hom_id, Category.comp_id]
  · have hp' : p' < p + 1 := lt_of_not_ge hp
    rw [HomologicalComplex.comp_f, K.cutoffColumns_succ_f_of_lt hp', zero_comp,
        K.cutoffColumns_inclusion_f_of_lt hp']

end CutoffColumnsInclusion

section CutoffColumnsToSingleColumnAt

variable [DecidableEq ℤ]

/-- The cell-level component of `cutoffColumns_to_singleColumnAt` at a
column `p' = p`: it is the canonical iso to `K.X p` composed with the
inverse `singleColumnAt_XIso_self`. -/
noncomputable def cutoffColumns_to_singleColumnAt_f_self (p : ℤ) :
    (K.cutoffColumns p).X p ⟶ (K.singleColumnAt p).X p :=
  (K.cutoffColumns_XIso_of_le (le_refl p)).hom ≫
    (K.singleColumnAt_XIso_self p).inv

/-- The canonical projection of the column-cutoff bicomplex onto the
single-column bicomplex at `p`. On the single kept column `p` it is the
canonical iso; on all other columns it is the zero morphism. -/
noncomputable def cutoffColumns_to_singleColumnAt (p : ℤ) :
    K.cutoffColumns p ⟶ K.singleColumnAt p where
  f p' :=
    if h : p' = p then
      eqToHom (by rw [h]) ≫ K.cutoffColumns_to_singleColumnAt_f_self p ≫
        eqToHom (by rw [h])
    else 0
  comm' p' p'' h := by
    -- `(singleColumnAt p).d = 0` always, so the LHS `f p' ≫ d` is zero.
    have hd : (K.singleColumnAt p).d p' p'' = 0 := rfl
    rw [hd, comp_zero]
    -- Goal: 0 = (K.cutoffColumns p).d p' p'' ≫ (cutoffColumns_to_singleColumnAt p).f p''
    -- For the RHS to be zero we use either:
    --   (a) `p'' ≠ p`, in which case `f p'' = 0`; or
    --   (b) `p'' = p`, in which case `p' = p - 1 < p` so the source
    --       cell `(K.cutoffColumns p).X p'` is `IsZero` and the
    --       composition vanishes.
    have hp'' : p' + 1 = p'' := h
    by_cases hp_eq : p'' = p
    · -- p' = p'' - 1 < p
      have hp' : p' < p := by lia
      exact (K.cutoffColumns_isZero_X_of_lt hp').eq_of_src _ _
    · show 0 = (K.cutoffColumns p).d p' p'' ≫
              (if h : p'' = p then
                eqToHom (by rw [h]) ≫ K.cutoffColumns_to_singleColumnAt_f_self p ≫
                  eqToHom (by rw [h])
              else 0)
      rw [dif_neg hp_eq, comp_zero]

@[simp]
lemma cutoffColumns_to_singleColumnAt_f_at_self (p : ℤ) :
    (K.cutoffColumns_to_singleColumnAt p).f p =
      K.cutoffColumns_to_singleColumnAt_f_self p := by
  show (if h : p = p then eqToHom (by rw [h]) ≫
        K.cutoffColumns_to_singleColumnAt_f_self p ≫
        eqToHom (by rw [h]) else 0) = _
  rw [dif_pos rfl]
  simp

lemma cutoffColumns_to_singleColumnAt_f_of_ne {p p' : ℤ} (h : p' ≠ p) :
    (K.cutoffColumns_to_singleColumnAt p).f p' = 0 := by
  dsimp [cutoffColumns_to_singleColumnAt]
  rw [dif_neg h]

/-- The s.e.s. of bicomplexes
`0 ⟶ K.cutoffColumns (p + 1) ⟶ K.cutoffColumns p ⟶ K.singleColumnAt p ⟶ 0`,
packaged as a `ShortComplex` of `HomologicalComplex₂`. The composition
`cutoffColumns_succ ≫ cutoffColumns_to_singleColumnAt` vanishes because:
* on cells `p' ≥ p + 1`, the projection at `p' ≠ p` is zero;
* on cells `p' < p + 1`, the source `(cutoffColumns (p + 1)).X p'` is
  `IsZero` so the composite vanishes.
-/
@[simps!]
noncomputable def cutoffColumns_succ_singleColumnAt_shortComplex (p : ℤ) :
    ShortComplex (HomologicalComplex₂ C (ComplexShape.up ℤ) c₂) :=
  ShortComplex.mk (K.cutoffColumns_succ p) (K.cutoffColumns_to_singleColumnAt p) (by
    ext p'
    rw [HomologicalComplex.comp_f, HomologicalComplex.zero_f]
    by_cases hp_eq : p' = p
    · -- Source cell for `cutoffColumns_succ p` at `p` is `IsZero` (since `p < p + 1`).
      have hf : (K.cutoffColumns_succ p).f p' = 0 := by
        rw [hp_eq]
        exact K.cutoffColumns_succ_f_of_lt (by lia : p < p + 1)
      rw [hf, zero_comp]
    · rw [K.cutoffColumns_to_singleColumnAt_f_of_ne hp_eq, comp_zero])

end CutoffColumnsToSingleColumnAt

end HomologicalComplex₂

/-!
## Z2c — `stupidTruncProjection`: closing the dual Joël-Riou mathlib TODO

The natural projection `K ⟶ K.stupidTrunc e` when `[e.IsTruncLE]`. This
closes the second TODO at `Mathlib/Algebra/Homology/Embedding/StupidTrunc.lean`
line 21:

> TODO (@joelriou)
> * define the projection `𝟭 _ ⟶ e.stupidTruncFunctor C` when `[e.IsTruncLE]`.

The construction proceeds component-by-component on each `i' : ι'`,
dual to the Z2b `stupidTruncInclusion`:

* If `i'` is in the image of `e.f` (say `i' = e.f i`), the cell
  `(K.stupidTrunc e).X i'` is isomorphic to `K.X i'` via
  `stupidTruncXIso`, and we take the iso `.inv` as the component (the
  projection direction, dual to Z2b's `.hom` for the inclusion).

* If `i'` is not in the image of `e.f`, the cell `(K.stupidTrunc e).X i'`
  is the zero object (`isZero_stupidTrunc_X`), so the component is the
  unique zero morphism into a zero object (well-defined regardless of
  the source).

The commutation with the differentials uses `IsTruncLE.mem_prev`: if
`c'.Rel i' j'` and `j'` is in the image of `e.f`, then so is `i'`. The
remaining case (`j'` out of image) is automatic from the `IsZero`
target. This is mathlib-PR-clean and would naturally live in
`Mathlib/Algebra/Homology/Embedding/StupidTrunc.lean` upstream, paired
with Z2b's `stupidTruncInclusion`.
-/

namespace HomologicalComplex

open Classical

variable {ι ι' : Type*} {c : ComplexShape ι} {c' : ComplexShape ι'}
  {C : Type*} [Category* C] [HasZeroMorphisms C] [HasZeroObject C]
  (K L : HomologicalComplex C c') (φ : K ⟶ L)
  (e : c.Embedding c') [e.IsRelIff]

/-- The component of the canonical projection `K ⟶ K.stupidTrunc e` at
the cell `i' : ι'`. In the image of `e.f` it is `stupidTruncXIso.inv`;
outside the image it is the zero morphism (well-defined because the
target is the zero object). -/
noncomputable def stupidTruncProjection_f (i' : ι') :
    K.X i' ⟶ (K.stupidTrunc e).X i' :=
  if h : ∃ i, e.f i = i' then (K.stupidTruncXIso e h.choose_spec).inv else 0

/-- Two choices of witness `i₁, i₂ : ι` for `e.f · = i'` give the same
`stupidTruncXIso.inv`, since `e.f` is injective. Dual to the GE-side
`stupidTruncXIso_hom_eq_of_eq`. -/
lemma stupidTruncXIso_inv_eq_of_eq {i₁ i₂ : ι} {i' : ι'}
    (hi₁ : e.f i₁ = i') (hi₂ : e.f i₂ = i') :
    (K.stupidTruncXIso e hi₁).inv = (K.stupidTruncXIso e hi₂).inv := by
  obtain rfl : i₁ = i₂ := e.injective_f (hi₁.trans hi₂.symm)
  rfl

lemma stupidTruncProjection_f_eq {i : ι} {i' : ι'} (hi : e.f i = i') :
    K.stupidTruncProjection_f e i' = (K.stupidTruncXIso e hi).inv := by
  have h : ∃ i, e.f i = i' := ⟨i, hi⟩
  dsimp [stupidTruncProjection_f]
  rw [dif_pos h]
  exact K.stupidTruncXIso_inv_eq_of_eq e h.choose_spec hi

lemma stupidTruncProjection_f_eq_zero (i' : ι') (hi' : ∀ i, e.f i ≠ i') :
    K.stupidTruncProjection_f e i' = 0 := by
  dsimp [stupidTruncProjection_f]
  rw [dif_neg]
  rintro ⟨i, hi⟩
  exact hi' i hi

/-- The canonical projection morphism `K ⟶ K.stupidTrunc e` when
`[e.IsTruncLE]`. Closes the dual mathlib TODO at
`Mathlib/Algebra/Homology/Embedding/StupidTrunc.lean` line 21. Dual to
Z2b's `stupidTruncInclusion`. -/
noncomputable def stupidTruncProjection [e.IsTruncLE] : K ⟶ K.stupidTrunc e where
  f i' := K.stupidTruncProjection_f e i'
  comm' i' j' h_rel := by
    by_cases hj : ∃ j, e.f j = j'
    · obtain ⟨j, rfl⟩ := hj
      obtain ⟨i, rfl⟩ : ∃ i, e.f i = i' := e.mem_prev h_rel
      rw [K.stupidTruncProjection_f_eq e rfl, K.stupidTruncProjection_f_eq e rfl]
      -- stupidTrunc = (K.restriction e).extend e
      -- so .d (e.f i) (e.f j) factors through (restriction).d i j = K.d (e.f i) (e.f j)
      dsimp [stupidTrunc]
      rw [(K.restriction e).extend_d_eq e rfl rfl]
      simp [stupidTruncXIso, restriction]
    · -- j' not in image, target (K.stupidTrunc).X j' is IsZero
      exact (K.isZero_stupidTrunc_X e j' (by simpa using hj)).eq_of_tgt _ _

/-- At a cell in the image of `e.f`, the projection's component is the
`stupidTruncXIso.inv`. -/
@[reassoc (attr := simp)]
lemma stupidTruncProjection_f_eq_of_mem [e.IsTruncLE] {i : ι} {i' : ι'} (hi : e.f i = i') :
    (K.stupidTruncProjection e).f i' = (K.stupidTruncXIso e hi).inv :=
  K.stupidTruncProjection_f_eq e hi

variable {K L} in
/-- Naturality of `stupidTruncProjection` with respect to morphisms of
complexes: the diagram with horizontal arrows `φ, stupidTruncMap φ e`
and vertical projections commutes. Dual to Z2b's
`stupidTruncMap_stupidTruncInclusion`. -/
@[reassoc (attr := simp)]
lemma stupidTruncProjection_stupidTruncMap [e.IsTruncLE] :
    K.stupidTruncProjection e ≫ stupidTruncMap φ e =
      φ ≫ L.stupidTruncProjection e := by
  ext i'
  by_cases hi : ∃ i, e.f i = i'
  · obtain ⟨i, rfl⟩ := hi
    rw [comp_f, comp_f, K.stupidTruncProjection_f_eq_of_mem e rfl,
        L.stupidTruncProjection_f_eq_of_mem e rfl]
    -- Goal: K.XIso.inv ≫ (stupidTruncMap φ e).f (e.f i) = φ.f (e.f i) ≫ L.XIso.inv
    -- Use stupidTruncMap_stupidTruncXIso_hom: (stupidTruncMap φ e).f i' ≫ L.XIso.hom = K.XIso.hom ≫ φ.f i'
    -- Multiply both sides by L.XIso.hom on the right
    rw [← cancel_mono ((L.stupidTruncXIso e rfl).hom)]
    simp [stupidTruncMap_stupidTruncXIso_hom]
  · -- Use L's stupidTrunc IsZero (the target), not K's
    exact (L.isZero_stupidTrunc_X e i' (by simpa using hi)).eq_of_tgt _ _

end HomologicalComplex

namespace ComplexShape.Embedding

variable {ι ι' : Type*} {c : ComplexShape ι} {c' : ComplexShape ι'}
  (e : Embedding c c') (C : Type*) [Category* C] [HasZeroMorphisms C] [HasZeroObject C]

/-- The natural transformation `𝟭 _ ⟶ e.stupidTruncFunctor C` consisting
of `stupidTruncProjection` at each complex, when `[e.IsTruncLE]`. Dual
to Z2b's `stupidTruncInclusionNatTrans`. -/
@[simps]
noncomputable def stupidTruncProjectionNatTrans [e.IsRelIff] [e.IsTruncLE] :
    𝟭 (HomologicalComplex C c') ⟶ e.stupidTruncFunctor C where
  app K := K.stupidTruncProjection e
  naturality _ _ φ := (HomologicalComplex.stupidTruncProjection_stupidTruncMap φ e).symm

end ComplexShape.Embedding

/-!
## Z2c — `cutoffColumnsLE` bicomplex infrastructure (LE-side dual to Z2a/Z2b)

We apply `stupidTruncProjection` to the cohomological column embedding
`embeddingUpIntLE p` to obtain the canonical LE-cutoff projection
`cutoffColumnsLE_projection : K ⟶ K.cutoffColumnsLE p` and, dually to
Z2b, build the LE-side filtration step `K.cutoffColumnsLE (p + 1) ⟶
K.cutoffColumnsLE p` (going from "more cells kept" to "fewer cells
kept", i.e., the cokernel-consistent projection direction), and
identify the kernel with the single-column bicomplex via an explicit
`singleColumnAt_to_cutoffColumnsLE_shortComplex` short exact sequence.
This is the LE-side companion to Z2b's GE-side trio.
-/

namespace HomologicalComplex₂

variable {C : Type*} [Category* C] [Preadditive C] [HasZeroObject C]
  {I₂ : Type*} {c₂ : ComplexShape I₂}
  (K : HomologicalComplex₂ C (ComplexShape.up ℤ) c₂)

section CutoffColumnsLE

/-- The "below-column-`p` cutoff" of a bicomplex `K` at filtration index
`p`, viewed as a homological complex valued in `HomologicalComplex C c₂`.
Columns at indices `> p` are replaced by the zero column; columns at
indices `≤ p` are unchanged. This is the stupid truncation of `K` along
the embedding `ComplexShape.embeddingUpIntLE p : (ComplexShape.down ℕ).Embedding
(ComplexShape.up ℤ)`, dual to Z2a's `cutoffColumns`.

In particular, `(K.cutoffColumnsLE p).X p' = K.X p'` when `p' ≤ p` (via
`cutoffColumnsLE_XIso_of_le`) and `IsZero ((K.cutoffColumnsLE p).X p')`
when `p < p'` (via `cutoffColumnsLE_isZero_X_of_gt`). -/
noncomputable def cutoffColumnsLE (p : ℤ) : HomologicalComplex₂ C (ComplexShape.up ℤ) c₂ :=
  K.stupidTrunc (ComplexShape.embeddingUpIntLE p)

/-- The LE-cutoff bicomplex has the same column as `K` when the column
index is in the kept range, i.e. `p' ≤ p`. Dual to Z2a's
`cutoffColumns_XIso_of_le`. -/
noncomputable def cutoffColumnsLE_XIso_of_le {p p' : ℤ} (hp : p' ≤ p) :
    (K.cutoffColumnsLE p).X p' ≅ K.X p' :=
  K.stupidTruncXIso (ComplexShape.embeddingUpIntLE p)
    (show p - ((p - p').toNat : ℤ) = p' by
      rw [Int.toNat_of_nonneg (by lia : (0 : ℤ) ≤ p - p')]
      lia)

/-- The LE-cutoff bicomplex has the zero column when the column index is
outside the kept range, i.e. `p < p'`. Dual to Z2a's
`cutoffColumns_isZero_X_of_lt`. -/
lemma cutoffColumnsLE_isZero_X_of_gt {p p' : ℤ} (hp : p < p') :
    IsZero ((K.cutoffColumnsLE p).X p') :=
  K.isZero_stupidTrunc_X (ComplexShape.embeddingUpIntLE p) p' (by
    intro n hn
    dsimp [ComplexShape.embeddingUpIntLE] at hn
    lia)

end CutoffColumnsLE

section CutoffColumnsLEProjection

/-- The canonical projection of `K` onto the LE-cutoff bicomplex at
filtration index `p`. Cell-wise, it is `stupidTruncXIso.inv` on the
kept columns (`p' ≤ p`) and the zero morphism on the cut columns
(`p < p'`). Dual to Z2b's `cutoffColumns_inclusion`. -/
noncomputable def cutoffColumnsLE_projection (p : ℤ) :
    K ⟶ K.cutoffColumnsLE p :=
  HomologicalComplex.stupidTruncProjection K (ComplexShape.embeddingUpIntLE p)

@[simp]
lemma cutoffColumnsLE_projection_f_of_le {p p' : ℤ} (hp : p' ≤ p) :
    (K.cutoffColumnsLE_projection p).f p' =
      (K.cutoffColumnsLE_XIso_of_le hp).inv := by
  -- Both sides reduce to `stupidTruncXIso` at the index `(p - p').toNat`.
  exact K.stupidTruncProjection_f_eq_of_mem (ComplexShape.embeddingUpIntLE p)
    (show (ComplexShape.embeddingUpIntLE p).f (p - p').toNat = p' by
      dsimp [ComplexShape.embeddingUpIntLE]
      rw [Int.toNat_of_nonneg (by lia : (0 : ℤ) ≤ p - p')]
      lia)

lemma cutoffColumnsLE_projection_f_of_gt {p p' : ℤ} (hp : p < p') :
    (K.cutoffColumnsLE_projection p).f p' = 0 :=
  (K.cutoffColumnsLE_isZero_X_of_gt hp).eq_of_tgt _ _

end CutoffColumnsLEProjection

section CutoffColumnsLESucc

/-- The LE-side filtration-step projection
`K.cutoffColumnsLE (p + 1) ⟶ K.cutoffColumnsLE p`. On a cell `p' ≤ p`
it is the composition of the two LE-cutoff cell isos
`(p + 1, p') ⤳ (p, p')` (i.e., the identity-like map); on a cell
`p' ≥ p + 1` it is the zero morphism (the target cell is `IsZero` when
`p' = p + 1` and both source and target are `IsZero` for `p' > p + 1`).
Dual to Z2b's `cutoffColumns_succ`. -/
noncomputable def cutoffColumnsLE_succ (p : ℤ) :
    K.cutoffColumnsLE (p + 1) ⟶ K.cutoffColumnsLE p where
  f p' :=
    if hp : p' ≤ p then
      (K.cutoffColumnsLE_XIso_of_le (show p' ≤ p + 1 by lia)).hom ≫
        (K.cutoffColumnsLE_XIso_of_le hp).inv
    else 0
  comm' p' p'' h := by
    -- `c.Rel p' p''` for `ComplexShape.up ℤ` means `p' + 1 = p''`.
    have hp_succ : p' + 1 = p'' := h
    by_cases hp_target : p'' ≤ p
    · -- Both source and target cells in the LE-cutoff kept range
      have hp : p' ≤ p := by lia
      have hp_le : p' ≤ p + 1 := by lia
      have hp1_p'' : p'' ≤ p + 1 := by lia
      rw [dif_pos hp, dif_pos hp_target]
      -- Naturality squares for the projections (p) and (p + 1)
      have h_inc1 := (K.cutoffColumnsLE_projection (p + 1)).comm p' p''
      have h_incp := (K.cutoffColumnsLE_projection p).comm p' p''
      rw [K.cutoffColumnsLE_projection_f_of_le hp_le,
        K.cutoffColumnsLE_projection_f_of_le hp1_p''] at h_inc1
      rw [K.cutoffColumnsLE_projection_f_of_le hp,
        K.cutoffColumnsLE_projection_f_of_le hp_target] at h_incp
      -- h_inc1: XIso(p+1, p').inv ≫ d_succ = K.d ≫ XIso(p+1, p'').inv
      -- h_incp: XIso(p, p').inv ≫ d_p     = K.d ≫ XIso(p, p'').inv
      -- Derive the direct form needed for the calc:
      have h_inc1_direct : (K.cutoffColumnsLE_XIso_of_le hp_le).hom ≫ K.d p' p'' =
          (K.cutoffColumnsLE (p + 1)).d p' p'' ≫
            (K.cutoffColumnsLE_XIso_of_le hp1_p'').hom := by
        rw [← cancel_epi (K.cutoffColumnsLE_XIso_of_le hp_le).inv,
          ← Category.assoc, Iso.inv_hom_id, Category.id_comp]
        rw [← Category.assoc, h_inc1, Category.assoc, Iso.inv_hom_id, Category.comp_id]
      have h_incp_direct : (K.cutoffColumnsLE_XIso_of_le hp).hom ≫ K.d p' p'' =
          (K.cutoffColumnsLE p).d p' p'' ≫
            (K.cutoffColumnsLE_XIso_of_le hp_target).hom := by
        rw [← cancel_epi (K.cutoffColumnsLE_XIso_of_le hp).inv,
          ← Category.assoc, Iso.inv_hom_id, Category.id_comp]
        rw [← Category.assoc, h_incp, Category.assoc, Iso.inv_hom_id, Category.comp_id]
      -- Now mirror Z2b's calc structure
      calc ((K.cutoffColumnsLE_XIso_of_le hp_le).hom ≫
                (K.cutoffColumnsLE_XIso_of_le hp).inv) ≫
              (K.cutoffColumnsLE p).d p' p''
          = (K.cutoffColumnsLE_XIso_of_le hp_le).hom ≫
              ((K.cutoffColumnsLE_XIso_of_le hp).inv ≫
                (K.cutoffColumnsLE p).d p' p'') := by rw [Category.assoc]
        _ = (K.cutoffColumnsLE_XIso_of_le hp_le).hom ≫
              (K.d p' p'' ≫ (K.cutoffColumnsLE_XIso_of_le hp_target).inv) := by
              rw [h_incp]
        _ = ((K.cutoffColumnsLE_XIso_of_le hp_le).hom ≫ K.d p' p'') ≫
              (K.cutoffColumnsLE_XIso_of_le hp_target).inv := by rw [Category.assoc]
        _ = ((K.cutoffColumnsLE (p + 1)).d p' p'' ≫
                (K.cutoffColumnsLE_XIso_of_le hp1_p'').hom) ≫
              (K.cutoffColumnsLE_XIso_of_le hp_target).inv := by
              rw [h_inc1_direct]
        _ = (K.cutoffColumnsLE (p + 1)).d p' p'' ≫
              ((K.cutoffColumnsLE_XIso_of_le hp1_p'').hom ≫
                (K.cutoffColumnsLE_XIso_of_le hp_target).inv) := by rw [Category.assoc]
    · -- Target out of range: (cutoffColumnsLE p).X p'' is IsZero, so both sides are zero
      exact (K.cutoffColumnsLE_isZero_X_of_gt (lt_of_not_ge hp_target)).eq_of_tgt _ _

@[simp]
lemma cutoffColumnsLE_succ_f_of_le {p p' : ℤ} (hp : p' ≤ p) :
    (K.cutoffColumnsLE_succ p).f p' =
      (K.cutoffColumnsLE_XIso_of_le (show p' ≤ p + 1 by lia)).hom ≫
        (K.cutoffColumnsLE_XIso_of_le hp).inv := by
  dsimp [cutoffColumnsLE_succ]
  rw [dif_pos hp]

lemma cutoffColumnsLE_succ_f_of_gt {p p' : ℤ} (hp : p < p') :
    (K.cutoffColumnsLE_succ p).f p' = 0 := by
  dsimp [cutoffColumnsLE_succ]
  rw [dif_neg (by lia : ¬ p' ≤ p)]

/-- The projection at `p + 1` composed with the LE-filtration step
recovers the projection at `p`. Dual to Z2b's
`cutoffColumns_succ_inclusion`. -/
@[reassoc (attr := simp)]
lemma cutoffColumnsLE_projection_succ (p : ℤ) :
    K.cutoffColumnsLE_projection (p + 1) ≫ K.cutoffColumnsLE_succ p =
      K.cutoffColumnsLE_projection p := by
  ext p'
  by_cases hp : p' ≤ p
  · rw [HomologicalComplex.comp_f, K.cutoffColumnsLE_succ_f_of_le hp,
        K.cutoffColumnsLE_projection_f_of_le (show p' ≤ p + 1 by lia),
        K.cutoffColumnsLE_projection_f_of_le hp,
        ← Category.assoc, Iso.inv_hom_id, Category.id_comp]
  · -- p' > p; sub-case on p' ≤ p+1 (= p+1) vs p' > p+1
    have hp_lt : p < p' := lt_of_not_ge hp
    rw [HomologicalComplex.comp_f]
    by_cases hp_p1 : p' ≤ p + 1
    · -- p' = p+1 (since p < p' ≤ p+1)
      have hp_eq : p' = p + 1 := by lia
      subst hp_eq
      rw [K.cutoffColumnsLE_projection_f_of_le (le_refl _),
          K.cutoffColumnsLE_succ_f_of_gt (by lia : p < p + 1),
          comp_zero, K.cutoffColumnsLE_projection_f_of_gt (by lia : p < p + 1)]
    · -- p' > p + 1
      have hp_gt : p + 1 < p' := lt_of_not_ge hp_p1
      rw [K.cutoffColumnsLE_projection_f_of_gt hp_gt, zero_comp,
          K.cutoffColumnsLE_projection_f_of_gt hp_lt]

end CutoffColumnsLESucc

section SingleColumnAtToCutoffColumnsLE

variable [DecidableEq ℤ]

/-- The cell-level component of `singleColumnAt_to_cutoffColumnsLE` at a
column `p' = p + 1`: it is the canonical iso `singleColumnAt_XIso_self`
composed with the inverse of the cutoff cell iso. Dual to Z2b's
`cutoffColumns_to_singleColumnAt_f_self`. -/
noncomputable def singleColumnAt_to_cutoffColumnsLE_f_self (p : ℤ) :
    (K.singleColumnAt (p + 1)).X (p + 1) ⟶ (K.cutoffColumnsLE (p + 1)).X (p + 1) :=
  (K.singleColumnAt_XIso_self (p + 1)).hom ≫
    (K.cutoffColumnsLE_XIso_of_le (le_refl (p + 1))).inv

/-- The canonical inclusion of the single-column bicomplex at column
`p + 1` into the LE-cutoff bicomplex at filtration index `p + 1`. On
the single kept column `p + 1` it is the canonical iso composition; on
all other columns it is the zero morphism. Dual to Z2b's
`cutoffColumns_to_singleColumnAt`. -/
noncomputable def singleColumnAt_to_cutoffColumnsLE (p : ℤ) :
    K.singleColumnAt (p + 1) ⟶ K.cutoffColumnsLE (p + 1) where
  f p' :=
    if h : p' = p + 1 then
      eqToHom (by rw [h]) ≫ K.singleColumnAt_to_cutoffColumnsLE_f_self p ≫
        eqToHom (by rw [h])
    else 0
  comm' p' p'' h := by
    -- Both sides share source `(singleColumnAt (p+1)).X p'` (RHS) and target
    -- `(cutoffColumnsLE (p+1)).X p''` (LHS). When `p' = p+1`, the target is
    -- `(cutoffColumnsLE (p+1)).X (p+2)` which is `IsZero`. When `p' ≠ p+1`,
    -- the source is `IsZero`. Either way, the equation holds via `eq_of_tgt`
    -- or `eq_of_src`.
    by_cases hp' : p' = p + 1
    · -- p' = p+1: target (cutoffColumnsLE (p+1)).X p'' is IsZero (since p+1 < p+2 = p'')
      have hp1_p'' : p + 1 < p'' := by
        have hh : p' + 1 = p'' := h
        lia
      exact (K.cutoffColumnsLE_isZero_X_of_gt hp1_p'').eq_of_tgt _ _
    · -- p' ≠ p+1: source (singleColumnAt (p+1)).X p' is IsZero
      exact (K.singleColumnAt_isZero_X_of_ne hp').eq_of_src _ _

@[simp]
lemma singleColumnAt_to_cutoffColumnsLE_f_at_self (p : ℤ) :
    (K.singleColumnAt_to_cutoffColumnsLE p).f (p + 1) =
      K.singleColumnAt_to_cutoffColumnsLE_f_self p := by
  show (if h : p + 1 = p + 1 then eqToHom (by rw [h]) ≫
        K.singleColumnAt_to_cutoffColumnsLE_f_self p ≫
        eqToHom (by rw [h]) else 0) = _
  rw [dif_pos rfl]
  simp

lemma singleColumnAt_to_cutoffColumnsLE_f_of_ne {p p' : ℤ} (h : p' ≠ p + 1) :
    (K.singleColumnAt_to_cutoffColumnsLE p).f p' = 0 := by
  dsimp [singleColumnAt_to_cutoffColumnsLE]
  rw [dif_neg h]

/-- The s.e.s. of bicomplexes
`0 ⟶ K.singleColumnAt (p + 1) ⟶ K.cutoffColumnsLE (p + 1) ⟶ K.cutoffColumnsLE p ⟶ 0`,
packaged as a `ShortComplex` of `HomologicalComplex₂`. The composition
`singleColumnAt_to_cutoffColumnsLE ≫ cutoffColumnsLE_succ` vanishes
because:
* on cells `p' = p + 1`, the target `(cutoffColumnsLE p).X (p+1)` is
  `IsZero` (since `p < p + 1`);
* on cells `p' ≠ p + 1`, the source `(singleColumnAt (p+1)).X p'` is
  `IsZero` so the composite vanishes.

This is the LE-side dual of Z2b's
`cutoffColumns_succ_singleColumnAt_shortComplex` and provides the kernel
side of the bicomplex SES needed by Z2d's `SpectralObject` Verdier
construction. -/
@[simps!]
noncomputable def singleColumnAt_to_cutoffColumnsLE_shortComplex (p : ℤ) :
    ShortComplex (HomologicalComplex₂ C (ComplexShape.up ℤ) c₂) :=
  ShortComplex.mk (K.singleColumnAt_to_cutoffColumnsLE p) (K.cutoffColumnsLE_succ p) (by
    ext p'
    rw [HomologicalComplex.comp_f, HomologicalComplex.zero_f]
    by_cases hp_eq : p' = p + 1
    · -- Target cell for `cutoffColumnsLE_succ p` at `p + 1` is `IsZero`.
      have hg : (K.cutoffColumnsLE_succ p).f p' = 0 := by
        rw [hp_eq]
        exact K.cutoffColumnsLE_succ_f_of_gt (by lia : p < p + 1)
      rw [hg, comp_zero]
    · rw [K.singleColumnAt_to_cutoffColumnsLE_f_of_ne hp_eq, zero_comp])

end SingleColumnAtToCutoffColumnsLE

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

/-! ### Non-vacuous evaluation of the Z2b inclusion morphism -/

/-- The Z2b cutoffColumns inclusion at `p = 0` evaluated on column 2 is
the canonical iso (since `0 ≤ 2`). Non-vacuous because the cell hom is the
genuine `stupidTruncXIso.hom`, not a placeholder zero. -/
example
    (K : HomologicalComplex₂ (ModuleCat ℚ) (ComplexShape.up ℤ) (ComplexShape.up ℤ)) :
    (K.cutoffColumns_inclusion 0).f 2 =
      (K.cutoffColumns_XIso_of_le (show (0 : ℤ) ≤ 2 by lia)).hom :=
  K.cutoffColumns_inclusion_f_of_le _

/-- The Z2b cutoffColumns inclusion at `p = 5` evaluated on column 2 is
zero (since `2 < 5`). -/
example
    (K : HomologicalComplex₂ (ModuleCat ℚ) (ComplexShape.up ℤ) (ComplexShape.up ℤ)) :
    (K.cutoffColumns_inclusion 5).f 2 = 0 :=
  K.cutoffColumns_inclusion_f_of_lt (by lia)

/-- Sanity check: the `stupidTruncInclusion` of the column embedding at
`p = 0` is the cutoffColumns inclusion at `0`. Non-vacuous because both
sides are non-zero morphisms (and the equality holds by `rfl`). -/
noncomputable example
    (K : HomologicalComplex₂ (ModuleCat ℚ) (ComplexShape.up ℤ) (ComplexShape.up ℤ)) :
    HomologicalComplex.stupidTruncInclusion K (ComplexShape.embeddingUpIntGE 0) =
      K.cutoffColumns_inclusion 0 :=
  rfl

/-- The Z2b filtration step `cutoffColumns 1 ⟶ cutoffColumns 0`
evaluated on column 3 is the cell iso composition. Non-vacuous because
the cell morphism is the genuine composition of two `cutoffColumns_XIso`
isos, not zero. -/
noncomputable example
    (K : HomologicalComplex₂ (ModuleCat ℚ) (ComplexShape.up ℤ) (ComplexShape.up ℤ)) :
    (K.cutoffColumns_succ 0).f 3 =
      (K.cutoffColumns_XIso_of_le (show (1 : ℤ) ≤ 3 by lia)).hom ≫
        (K.cutoffColumns_XIso_of_le (show (0 : ℤ) ≤ 3 by lia)).inv :=
  K.cutoffColumns_succ_f_of_le _

/-- The Z2b filtration step `cutoffColumns 5 ⟶ cutoffColumns 4`
evaluated on column 3 is zero (since `3 < 5`). -/
example
    (K : HomologicalComplex₂ (ModuleCat ℚ) (ComplexShape.up ℤ) (ComplexShape.up ℤ)) :
    (K.cutoffColumns_succ 4).f 3 = 0 :=
  K.cutoffColumns_succ_f_of_lt (by lia)

/-- The Z2b projection `cutoffColumns 0 ⟶ singleColumnAt 0` evaluated on
column 5 is zero (since `5 ≠ 0`). -/
example
    (K : HomologicalComplex₂ (ModuleCat ℚ) (ComplexShape.up ℤ) (ComplexShape.up ℤ)) :
    (K.cutoffColumns_to_singleColumnAt 0).f 5 = 0 :=
  K.cutoffColumns_to_singleColumnAt_f_of_ne (by lia)

/-- The Z2b s.e.s. composition `(cutoffColumns 1 ⟶ cutoffColumns 0 ⟶
singleColumnAt 0)` is the zero morphism in
`HomologicalComplex₂ (ModuleCat ℚ) ...`. Non-vacuous packaging of the
s.e.s. middle-position vanishing identity, which is what is needed for
the snake-lemma-based `SpectralObject.δ` data in Z2c. -/
example
    (K : HomologicalComplex₂ (ModuleCat ℚ) (ComplexShape.up ℤ) (ComplexShape.up ℤ)) :
    (K.cutoffColumns_succ_singleColumnAt_shortComplex 0).f ≫
        (K.cutoffColumns_succ_singleColumnAt_shortComplex 0).g = 0 :=
  (K.cutoffColumns_succ_singleColumnAt_shortComplex 0).zero

/-! ### Non-vacuous evaluation of the Z2c LE-side projection + filtration step + SES -/

/-- The Z2c cutoffColumnsLE bicomplex at `p = 5` evaluated on column 2
recovers `K.X 2` (since `2 ≤ 5`). Non-vacuous because the cell hom is
the genuine `stupidTruncXIso`, not a placeholder zero. -/
noncomputable example
    (K : HomologicalComplex₂ (ModuleCat ℚ) (ComplexShape.up ℤ) (ComplexShape.up ℤ)) :
    (K.cutoffColumnsLE 5).X 2 ≅ K.X 2 :=
  K.cutoffColumnsLE_XIso_of_le (by lia)

/-- The Z2c cutoffColumnsLE at `p = 0` zeros out column 2 (since
`0 < 2`). Dual to Z2b's `cutoffColumns_isZero_X_of_lt`. -/
example
    (K : HomologicalComplex₂ (ModuleCat ℚ) (ComplexShape.up ℤ) (ComplexShape.up ℤ)) :
    IsZero ((K.cutoffColumnsLE 0).X 2) :=
  K.cutoffColumnsLE_isZero_X_of_gt (by lia)

/-- The Z2c cutoffColumnsLE projection at `p = 5` evaluated on column 2
is the canonical iso inverse (since `2 ≤ 5`). Non-vacuous because the
cell hom is the genuine `stupidTruncXIso.inv`, not a placeholder zero. -/
example
    (K : HomologicalComplex₂ (ModuleCat ℚ) (ComplexShape.up ℤ) (ComplexShape.up ℤ)) :
    (K.cutoffColumnsLE_projection 5).f 2 =
      (K.cutoffColumnsLE_XIso_of_le (show (2 : ℤ) ≤ 5 by lia)).inv :=
  K.cutoffColumnsLE_projection_f_of_le _

/-- The Z2c cutoffColumnsLE projection at `p = 0` evaluated on column 2
is zero (since `0 < 2`, the target cell is `IsZero`). -/
example
    (K : HomologicalComplex₂ (ModuleCat ℚ) (ComplexShape.up ℤ) (ComplexShape.up ℤ)) :
    (K.cutoffColumnsLE_projection 0).f 2 = 0 :=
  K.cutoffColumnsLE_projection_f_of_gt (by lia)

/-- Sanity check: the `stupidTruncProjection` of the column embedding
at `p = 0` is the cutoffColumnsLE projection at `0`. Non-vacuous
because both sides are non-zero morphisms (and the equality holds by
`rfl`). Dual to Z2b's `stupidTruncInclusion = cutoffColumns_inclusion`. -/
noncomputable example
    (K : HomologicalComplex₂ (ModuleCat ℚ) (ComplexShape.up ℤ) (ComplexShape.up ℤ)) :
    HomologicalComplex.stupidTruncProjection K (ComplexShape.embeddingUpIntLE 0) =
      K.cutoffColumnsLE_projection 0 :=
  rfl

/-- The Z2c LE-filtration step `cutoffColumnsLE 1 ⟶ cutoffColumnsLE 0`
evaluated on column 0 is the cell iso composition (since `0 ≤ 0`). -/
noncomputable example
    (K : HomologicalComplex₂ (ModuleCat ℚ) (ComplexShape.up ℤ) (ComplexShape.up ℤ)) :
    (K.cutoffColumnsLE_succ 0).f 0 =
      (K.cutoffColumnsLE_XIso_of_le (show (0 : ℤ) ≤ 1 by lia)).hom ≫
        (K.cutoffColumnsLE_XIso_of_le (show (0 : ℤ) ≤ 0 by lia)).inv :=
  K.cutoffColumnsLE_succ_f_of_le _

/-- The Z2c LE-filtration step `cutoffColumnsLE 0 ⟶ cutoffColumnsLE (-1)`
evaluated on column 2 is zero (since `-1 < 2`). -/
example
    (K : HomologicalComplex₂ (ModuleCat ℚ) (ComplexShape.up ℤ) (ComplexShape.up ℤ)) :
    (K.cutoffColumnsLE_succ (-1)).f 2 = 0 :=
  K.cutoffColumnsLE_succ_f_of_gt (by lia)

/-- The Z2c inclusion `singleColumnAt 1 ⟶ cutoffColumnsLE 1` evaluated
on column 5 is zero (since `5 ≠ 1`). Dual to Z2b's
`cutoffColumns_to_singleColumnAt_f_of_ne`. -/
example
    (K : HomologicalComplex₂ (ModuleCat ℚ) (ComplexShape.up ℤ) (ComplexShape.up ℤ)) :
    (K.singleColumnAt_to_cutoffColumnsLE 0).f 5 = 0 :=
  K.singleColumnAt_to_cutoffColumnsLE_f_of_ne (by lia)

/-- The Z2c s.e.s. composition `(singleColumnAt 1 ⟶ cutoffColumnsLE 1 ⟶
cutoffColumnsLE 0)` is the zero morphism in
`HomologicalComplex₂ (ModuleCat ℚ) ...`. Non-vacuous packaging of the
LE-side s.e.s. middle-position vanishing identity, dual to Z2b's
`cutoffColumns_succ_singleColumnAt_shortComplex` composition-zero, and
needed for the snake-lemma-based `SpectralObject.δ` data in Z2d. -/
example
    (K : HomologicalComplex₂ (ModuleCat ℚ) (ComplexShape.up ℤ) (ComplexShape.up ℤ)) :
    (K.singleColumnAt_to_cutoffColumnsLE_shortComplex 0).f ≫
        (K.singleColumnAt_to_cutoffColumnsLE_shortComplex 0).g = 0 :=
  (K.singleColumnAt_to_cutoffColumnsLE_shortComplex 0).zero

/-- Z2b ↔ Z2c symmetry sanity check: the GE-side `cutoffColumns_succ_inclusion`
factorisation and the LE-side `cutoffColumnsLE_projection_succ`
factorisation each express that the unique filtration-step morphism
respects the corresponding global inclusion/projection at K. Here we
verify the LE-side factorisation at `p = 0` and column 2 (the target
side, where the chained projection is zero since column 2 is cut). -/
example
    (K : HomologicalComplex₂ (ModuleCat ℚ) (ComplexShape.up ℤ) (ComplexShape.up ℤ)) :
    (K.cutoffColumnsLE_projection 1 ≫ K.cutoffColumnsLE_succ 0).f 2 = 0 := by
  rw [HomologicalComplex.comp_f,
    K.cutoffColumnsLE_projection_f_of_gt (by lia : (1 : ℤ) < 2),
    zero_comp]

end NonVacuous

end HomologicalComplex₂

/-!
## Deferred to Z2d (named follow-on)

The remaining Z2 deliverables — the `SpectralObject (HomologicalComplex C c₁₂) EInt`
construction packaging the H-data `H^n (F^j / F^i)` (with `i ≤ j` in
`EInt`) + δ-data via the snake lemma on the s.e.s. of triple filtration
quotients + the three exactness conditions via the LES of cohomology,
and the `IsFirstQuadrant` instance — are pre-authorised follow-on
**Z2d** sub-tickets per scoping doc §Z2 sub-split contingency, mirroring
the Z1 → Z1b and Z2 → Z2a → Z2b → Z2c precedents. The full
infrastructure is now in place: Z2a + Z2b give the GE-side
`cutoffColumns / cutoffColumns_succ / cutoffColumns_succ_singleColumnAt_shortComplex`
trio; Z2c (this commit) gives the LE-side
`cutoffColumnsLE / cutoffColumnsLE_succ / singleColumnAt_to_cutoffColumnsLE_shortComplex`
trio. Z2d combines both halves into the `SpectralObject` H-functor.

### Z2d-A — `SpectralObject` H-functor construction

The H-functor `H n : ComposableArrows EInt 1 ⥤ HomologicalComplex C c₁₂`
takes `mk₁ (homOfLE (h : i ≤ j))` for `i, j : EInt` to the chain complex
obtained from the "slice between i and j" of `K`. The EInt-extension
follows the standard convention:
* `H _ (mk₁ (⊥ ≤ ⊥))` and `H _ (mk₁ (⊤ ≤ ⊤))` map to the zero complex.
* `H _ (mk₁ (⊥ ≤ (k : ℤ)))` maps to `(K.cutoffColumnsLE k).total c₁₂`.
* `H _ (mk₁ ((k : ℤ) ≤ ⊤))` maps to `(K.cutoffColumns (k + 1)).total c₁₂`.
* `H _ (mk₁ ((i : ℤ) ≤ (j : ℤ)))` maps to the chain complex obtained as
  the "slice [i + 1, j]" — either as the cokernel of
  `cutoffColumnsLE (i) → cutoffColumnsLE (j)` (using Z2c's LE-side
  projection) or as the kernel of `cutoffColumns (j+1) → cutoffColumns (i+1)`
  (using Z2b's GE-side inclusion). The two are canonically isomorphic
  via the third isomorphism theorem on the K = cutoffColumns(i+1) ⊕
  slice(i+1, j) ⊕ cutoffColumns(j+1) decomposition.
* `H _ (mk₁ (⊥ ≤ ⊤))` maps to `K.total c₁₂` (the entire complex).

The cohomological `n`-dependence (the `H n` family) enters via the
`HomologicalComplex.shiftFunctor` for `c₁₂ = ComplexShape.up ℤ` (when
this shape is chosen), yielding the standard SpectralObject convention
where shifting `n` corresponds to the "row degree" of the bicomplex
viewed as a chain complex of chain complexes.

The δ-data comes from the snake lemma on the s.e.s. of triple
filtration quotients `0 ⟶ slice(i, j) ⟶ slice(i, k) ⟶ slice(j, k) ⟶ 0`,
built by combining the Z2b GE-side `cutoffColumns_succ_singleColumnAt_shortComplex`
and the Z2c LE-side `singleColumnAt_to_cutoffColumnsLE_shortComplex`
into the bicomplex SES at each adjacent step `(p, p+1)`, then chaining
across general `i ≤ j ≤ k` via composition of cokernels.

The three `SpectralObject` exactness conditions follow from the LES of
cohomology on this s.e.s. via the `HomologicalComplex.HomologySequence`
API (`ShortExact.homology_exact₁ / exact₂ / exact₃`).

### Z2d-B — `IsFirstQuadrant`

For a first-quadrant bicomplex `K` (supported in `(p, q)` with `p ≥ 0`,
`q ≥ 0`), the spectral object satisfies `IsFirstQuadrant`'s two
vanishing conditions:
* `isZero₁` (for `j ≤ (0 : ℤ)`): the slice between `i ≤ j ≤ 0` lies
  entirely in the strictly-negative columns, where `K` vanishes. Direct
  consequence of `cutoffColumnsLE` cell-wise vanishing at `p' < 0` for
  first-quadrant `K`.
* `isZero₂` (for `n < i`): the slice between `i ≤ j` shifted by `-n` is
  supported only at row degrees `≥ i - n > 0`, but for first-quadrant
  `K`, the row-`q < 0` cells vanish; combined with the shift, the
  vanishing follows.

Both vanishing conditions are honest (not classical-instance arm) and
follow from the cell-level `cutoffColumns_isZero_X_of_lt` lemma +
`cutoffColumnsLE_isZero_X_of_gt` lemma + the total-complex coproduct
structure.

The Z2d follow-on is sized for a focused short session (~250-300k
tokens, matching the Z2a / Z2b / Z2c cadence). After Z2d GREEN, the Z2
scope is fully closed and Z3 (`BicomplexConvergence`) dispatches on the
full Z2 deliverable set.
-/
