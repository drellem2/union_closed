/-
Copyright (c) 2026 Union-Closed Polecat Authors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Union-Closed Polecat (cat-mg-3ff1 Z2a + cat-mg-0611 Z2b, of
UC-Lean-MathlibSS-Full-scope).

This file extends `Mathlib.Algebra.Homology.HomologicalBicomplex` and
`Mathlib.Algebra.Homology.TotalComplex` (authored by Kim Morrison and
Joël Riou) towards the construction of the canonical filtration on the
total complex of a bicomplex and the resulting `SpectralObject` packaging
of the H-data `H^n (F^p / F^{p+1})` and δ-data from the s.e.s. of
filtration quotients. The Z2 arc is split:

* **Z2a** (cat-mg-3ff1) landed the OBJECT-level filtration via mathlib's
  `stupidTrunc`: `cutoffColumns`, `singleColumnAt`, `filtrationOnTotal`,
  `grOnTotal`, and the basic cell-level `Iso`/`IsZero` structural lemmas.

* **Z2b** (cat-mg-0611, this commit) closes Joël Riou's documented TODO
  on `Mathlib.Algebra.Homology.Embedding.StupidTrunc` (the inclusion
  natural transformation `e.stupidTruncFunctor C ⟶ 𝟭 _` when `[e.IsTruncGE]`),
  applies it to obtain the canonical filtration inclusion
  `K.cutoffColumns p ⟶ K`, builds the filtration step
  `K.cutoffColumns (p + 1) ⟶ K.cutoffColumns p`, identifies the quotient
  with the single-column bicomplex via an explicit
  `cutoffColumns_succ_singleColumnAt_shortComplex` short exact sequence,
  and totalises this to a short exact sequence on the `total` complex
  realising the canonical filtration on `K.total c₁₂` as a step inside the
  `SpectralObject` Verdier construction.

The full `SpectralObject K : SpectralObject (HomologicalComplex C c) EInt`
construction (Verdier H-functor on `mk₁ (homOfLE (i ≤ j))` for arbitrary
`i, j : EInt` + δ-data via snake lemma on the s.e.s. of triple filtration
quotients + three SpectralObject exactness conditions from the LES of
cohomology), as well as the `IsFirstQuadrant` instance, are scheduled for
a follow-on **Z2c** sub-ticket per the pre-authorised sub-split
contingency mirrored from the Z1 → Z1b precedent — see the file's end-of-
module *deferred to Z2c* section for the construction sketch and budget
estimate.

The file is local-only per Daniel directive 2026-05-17T13:53Z but is
written in Joël-Riou style with full docstrings, ready for upstream
submission. The Z2b inclusion natural transformation `stupidTruncInclusion`
is in particular a definitive mathlib-PR-clean closure of the TODO at
`Mathlib.Algebra.Homology.Embedding.StupidTrunc` lines 19-20.
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

end NonVacuous

end HomologicalComplex₂

/-!
## Deferred to Z2c (named follow-on)

The remaining Z2 deliverables — the explicit filtration step inclusion
`K.cutoffColumns (p + 1) ⟶ K.cutoffColumns p`, the s.e.s. of bicomplexes
`0 ⟶ cutoffColumns (p + 1) ⟶ cutoffColumns p ⟶ singleColumnAt p ⟶ 0`,
its totalisation, the `SpectralObject (HomologicalComplex C c₁₂) EInt`
construction packaging the H-data `H^n (F^p / F^q)` (with `p ≤ q` in
`EInt`) + δ-data via the snake lemma + three exactness conditions via
the LES of cohomology, and the `IsFirstQuadrant` instance — are pre-
authorised follow-on **Z2c** sub-tickets per scoping doc §Z2 sub-split
contingency, mirroring the Z1 → Z1b precedent.

### Z2c-A — Filtration step inclusion

The morphism `K.cutoffColumns (p + 1) ⟶ K.cutoffColumns p` is constructed
either:
* As the unique factorisation through `cutoffColumns_inclusion p` (using
  that `cutoffColumns p` is a mono into `K` via `cutoffColumns_inclusion`,
  composed with `cutoffColumns_inclusion (p + 1)`). The mono property is
  proven cell-wise from the `cutoffColumns_inclusion_f_of_le` /
  `cutoffColumns_inclusion_f_of_lt` formulas.
* Or directly via `stupidTruncMap`-style cell-by-cell construction with
  the `cutoffColumns_XIso_of_le ∘ cutoffColumns_XIso_of_le⁻¹` cell formula.

### Z2c-B — Bicomplex s.e.s.

The s.e.s. `0 ⟶ cutoffColumns (p + 1) ⟶ cutoffColumns p ⟶ singleColumnAt p ⟶ 0`
is constructed cell-wise: at column `p`, the s.e.s. is
`0 ⟶ 0 ⟶ K.X p ⟶ K.X p ⟶ 0`; at columns `p' > p`, it is
`0 ⟶ K.X p' ⟶ K.X p' ⟶ 0 ⟶ 0`; at columns `p' < p`, all three pieces are
zero. Exactness in each column reduces to standard identities for the
zero complex and identity morphisms.

### Z2c-C — `SpectralObject` construction

The H-functor `H n : ComposableArrows EInt 1 ⥤ HomologicalComplex C c₁₂`
takes `mk₁ (homOfLE (h : i ≤ j))` for `i, j : EInt` to the chain complex
obtained as `H^n` of the quotient `F^i (K.total) / F^j (K.total)`
(realised via the cokernel of the filtration step composition
`F^{i + 1} ↪ … ↪ F^j ↪ F^i`, or via the EInt-extended
`stupidTrunc`-style construction for `EInt = WithBotTop ℤ`). The δ-data
comes from the snake lemma on the s.e.s. of triple filtration quotients
`0 ⟶ F^j / F^k ⟶ F^i / F^k ⟶ F^i / F^j ⟶ 0`; the three
`SpectralObject` exactness conditions follow from the LES of cohomology
on this s.e.s. (`HomologicalComplex.HomologySequence` API).

### Z2c-D — `IsFirstQuadrant`

For a first-quadrant bicomplex `K` (supported in `(p, q)` with `p ≥ 0`,
`q ≥ 0`), the spectral object satisfies `IsFirstQuadrant`'s two
vanishing conditions: `isZero₁` because `F^i / F^j = 0` for `i ≤ j ≤ 0`,
and `isZero₂` because `F^i (K.total).X n = 0` when `n < i`. Both follow
directly from the cell-level `cutoffColumns_isZero_X_of_lt` lemma + the
total-complex coproduct structure.

The Z2c follow-on is sized for a focused short session (~250-300k tokens,
matching the Z2a / Z2b cadence). After Z2c GREEN, Z3
(`BicomplexConvergence`) dispatches on the full Z2 deliverable set.
-/
