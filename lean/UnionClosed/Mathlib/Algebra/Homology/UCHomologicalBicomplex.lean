/-
Copyright (c) 2021 Kim Morrison. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Kim Morrison, Joël Riou
-/
module

public import UnionClosed.Mathlib.Algebra.Homology.UCAdditive

/-!
# UC Bicomplexes (UnionClosed cascade-fork copy).

This file is a textual fork of `Mathlib/Algebra/Homology/HomologicalBicomplex.lean`
(mathlib `v4.29.1`, commit `5e932f97`), namespace-renamed to `UCHomologicalComplex`.
This is sub-ticket 2 of the cascade-fork plan (mg-d079, depends on mg-f52c).

Given a preadditive category `C` and two complex shapes
`c₁ : ComplexShape I₁` and `c₂ : ComplexShape I₂`, we define
the type of UC bicomplexes `UCHomologicalComplex₂ C c₁ c₂` as an
abbreviation for `UCHomologicalComplex (UCHomologicalComplex C c₂) c₁`.

**KEY:** unlike mathlib's `HomologicalComplex₂`, which uses ambient
`[HasZeroMorphisms C]`, the UC variant uses `[Preadditive C]`. This is
forced by the cascade-fork's deletion of the direct
`HasZeroMorphisms (UCHomologicalComplex V c)` instance: the inner
`UCHomologicalComplex C c₂` only obtains `HasZeroMorphisms` via
`Preadditive (UCHomologicalComplex C c₂)` (provided by `UCAdditive`),
which itself requires `[Preadditive C]`. The chain is:

  `[Preadditive C]`
    ⇝ `[HasZeroMorphisms C]` (mathlib `preadditiveHasZeroMorphisms`)
    ⇝ `[Preadditive (UCHC C c₂)]` (UC fork `UCAdditive` Preadditive instance)
    ⇝ `[HasZeroMorphisms (UCHC C c₂)]` (mathlib `preadditiveHasZeroMorphisms`)
    ⇝ `UCHomologicalComplex (UCHC C c₂) c₁` typechecks
    ⇝ `[Preadditive (UCHC (UCHC C c₂) c₁)]` (UC fork `UCAdditive`, recursively)
    ⇝ `[HasZeroMorphisms (UCHC₂ C c₁ c₂)]` UNIQUELY via preadditiveHasZeroMorphisms.

The diamond bypass: at every layer there is **no competing direct
`HasZeroMorphisms` instance** (the bare instance was deleted from
`UCHomologicalComplex.lean` in sub-ticket 1), so the TC resolution
chain above is the **only** path. This is the precondition for the
sub-ticket 2 cascade-fork viability gate probe in `UCDiamondTest.lean`.

Local-only fork per Daniel directive 2026-05-17T13:53Z. Not for upstream PR.

In particular, if `K : UCHomologicalComplex₂ C c₁ c₂`, then
for each `i₁ : I₁`, `K.X i₁` is a column of `K`.

In this file, we obtain the equivalence of categories
`UCHomologicalComplex₂.flipEquivalence`
which is obtained by exchanging the horizontal and vertical directions.

-/

@[expose] public section


open CategoryTheory Limits

variable (C : Type*) [Category* C] [Preadditive C]
  {I₁ I₂ : Type*} (c₁ : ComplexShape I₁) (c₂ : ComplexShape I₂)

/-- Given a preadditive category `C` and two complex shapes `c₁` and `c₂` on types `I₁` and `I₂`,
the associated type of UC bicomplexes `UCHomologicalComplex₂ C c₁ c₂` is
`K : UCHomologicalComplex (UCHomologicalComplex C c₂) c₁`. Then, the object in
position `⟨i₁, i₂⟩` can be obtained as `(K.X i₁).X i₂`. -/
abbrev UCHomologicalComplex₂ :=
  UCHomologicalComplex (UCHomologicalComplex C c₂) c₁

namespace UCHomologicalComplex₂

open UCHomologicalComplex

variable {C c₁ c₂}

/-- The graded object indexed by `I₁ × I₂` induced by a UC bicomplex. -/
def toGradedObject (K : UCHomologicalComplex₂ C c₁ c₂) :
    GradedObject (I₁ × I₂) C :=
  fun ⟨i₁, i₂⟩ => (K.X i₁).X i₂

/-- The morphism of graded objects induced by a morphism of UC bicomplexes. -/
def toGradedObjectMap {K L : UCHomologicalComplex₂ C c₁ c₂} (φ : K ⟶ L) :
    K.toGradedObject ⟶ L.toGradedObject :=
  fun ⟨i₁, i₂⟩ => (φ.f i₁).f i₂

@[simp]
lemma toGradedObjectMap_apply {K L : UCHomologicalComplex₂ C c₁ c₂}
    (φ : K ⟶ L) (i₁ : I₁) (i₂ : I₂) :
    toGradedObjectMap φ ⟨i₁, i₂⟩ = (φ.f i₁).f i₂ := rfl

variable (C c₁ c₂) in
/-- The functor which sends a UC bicomplex to its associated graded object. -/
@[simps]
def toGradedObjectFunctor : UCHomologicalComplex₂ C c₁ c₂ ⥤ GradedObject (I₁ × I₂) C where
  obj K := K.toGradedObject
  map φ := toGradedObjectMap φ

instance : (toGradedObjectFunctor C c₁ c₂).Faithful where
  map_injective {_ _ φ₁ φ₂} h := by
    ext i₁ i₂
    exact congr_fun h ⟨i₁, i₂⟩

section OfGradedObject

variable (c₁ c₂)
variable (X : GradedObject (I₁ × I₂) C)
    (d₁ : ∀ (i₁ i₁' : I₁) (i₂ : I₂), X ⟨i₁, i₂⟩ ⟶ X ⟨i₁', i₂⟩)
    (d₂ : ∀ (i₁ : I₁) (i₂ i₂' : I₂), X ⟨i₁, i₂⟩ ⟶ X ⟨i₁, i₂'⟩)
    (shape₁ : ∀ (i₁ i₁' : I₁) (_ : ¬c₁.Rel i₁ i₁') (i₂ : I₂), d₁ i₁ i₁' i₂ = 0)
    (shape₂ : ∀ (i₁ : I₁) (i₂ i₂' : I₂) (_ : ¬c₂.Rel i₂ i₂'), d₂ i₁ i₂ i₂' = 0)
    (d₁_comp_d₁ : ∀ (i₁ i₁' i₁'' : I₁) (i₂ : I₂), d₁ i₁ i₁' i₂ ≫ d₁ i₁' i₁'' i₂ = 0)
    (d₂_comp_d₂ : ∀ (i₁ : I₁) (i₂ i₂' i₂'' : I₂), d₂ i₁ i₂ i₂' ≫ d₂ i₁ i₂' i₂'' = 0)
    (comm : ∀ (i₁ i₁' : I₁) (i₂ i₂' : I₂), d₁ i₁ i₁' i₂ ≫ d₂ i₁' i₂ i₂' =
      d₂ i₁ i₂ i₂' ≫ d₁ i₁ i₁' i₂')

/-- Constructor for UC bicomplexes taking as inputs a graded object, horizontal differentials
and vertical differentials satisfying suitable relations. -/
@[simps]
def ofGradedObject :
    UCHomologicalComplex₂ C c₁ c₂ where
  X i₁ :=
    { X := fun i₂ => X ⟨i₁, i₂⟩
      d := fun i₂ i₂' => d₂ i₁ i₂ i₂'
      shape := shape₂ i₁
      d_comp_d' := by intros; apply d₂_comp_d₂ }
  d i₁ i₁' :=
    { f := fun i₂ => d₁ i₁ i₁' i₂
      comm' := by intros; apply comm }
  shape i₁ i₁' h := by
    ext i₂
    exact shape₁ i₁ i₁' h i₂
  d_comp_d' i₁ i₁' i₁'' _ _ := by ext i₂; apply d₁_comp_d₁

@[simp]
lemma ofGradedObject_toGradedObject :
    (ofGradedObject c₁ c₂ X d₁ d₂ shape₁ shape₂ d₁_comp_d₁ d₂_comp_d₂ comm).toGradedObject = X :=
  rfl

end OfGradedObject

/-- Constructor for a morphism `K ⟶ L` in the category `UCHomologicalComplex₂ C c₁ c₂` which
takes as inputs a morphism `f : K.toGradedObject ⟶ L.toGradedObject` and
the compatibilities with both horizontal and vertical differentials. -/
@[simps!]
def homMk {K L : UCHomologicalComplex₂ C c₁ c₂}
    (f : K.toGradedObject ⟶ L.toGradedObject)
    (comm₁ : ∀ i₁ i₁' i₂, c₁.Rel i₁ i₁' →
      f ⟨i₁, i₂⟩ ≫ (L.d i₁ i₁').f i₂ = (K.d i₁ i₁').f i₂ ≫ f ⟨i₁', i₂⟩)
    (comm₂ : ∀ i₁ i₂ i₂', c₂.Rel i₂ i₂' →
      f ⟨i₁, i₂⟩ ≫ (L.X i₁).d i₂ i₂' = (K.X i₁).d i₂ i₂' ≫ f ⟨i₁, i₂'⟩) : K ⟶ L where
  f i₁ :=
    { f := fun i₂ => f ⟨i₁, i₂⟩
      comm' := comm₂ i₁ }
  comm' i₁ i₁' h₁ := by
    ext i₂
    exact comm₁ i₁ i₁' i₂ h₁

lemma shape_f (K : UCHomologicalComplex₂ C c₁ c₂) (i₁ i₁' : I₁)
    (h : ¬ c₁.Rel i₁ i₁') (i₂ : I₂) :
    (K.d i₁ i₁').f i₂ = 0 := by
  rw [K.shape _ _ h, zero_f]

@[reassoc (attr := simp)]
lemma d_f_comp_d_f (K : UCHomologicalComplex₂ C c₁ c₂)
    (i₁ i₁' i₁'' : I₁) (i₂ : I₂) :
    (K.d i₁ i₁').f i₂ ≫ (K.d i₁' i₁'').f i₂ = 0 := by
  rw [← comp_f, d_comp_d, zero_f]

@[reassoc]
lemma d_comm (K : UCHomologicalComplex₂ C c₁ c₂) (i₁ i₁' : I₁) (i₂ i₂' : I₂) :
    (K.d i₁ i₁').f i₂ ≫ (K.X i₁').d i₂ i₂' = (K.X i₁).d i₂ i₂' ≫ (K.d i₁ i₁').f i₂' := by
  simp

@[reassoc (attr := simp)]
lemma comm_f {K L : UCHomologicalComplex₂ C c₁ c₂} (f : K ⟶ L) (i₁ i₁' : I₁) (i₂ : I₂) :
    (f.f i₁).f i₂ ≫ (L.d i₁ i₁').f i₂ = (K.d i₁ i₁').f i₂ ≫ (f.f i₁').f i₂ :=
  congr_hom (f.comm i₁ i₁') i₂

/-- Flip a UC complex of complexes over the diagonal,
exchanging the horizontal and vertical directions.
-/
@[simps]
def flip (K : UCHomologicalComplex₂ C c₁ c₂) : UCHomologicalComplex₂ C c₂ c₁ where
  X i :=
    { X := fun j => (K.X j).X i
      d := fun j j' => (K.d j j').f i
      shape := fun _ _ w => K.shape_f _ _ w i }
  d i i' := { f := fun j => (K.X j).d i i' }
  shape i i' w := by
    ext j
    exact (K.X j).shape i i' w

@[simp]
lemma flip_flip (K : UCHomologicalComplex₂ C c₁ c₂) : K.flip.flip = K := rfl

variable (C c₁ c₂)

/-- Flipping a UC complex of complexes over the diagonal, as a functor. -/
@[simps]
def flipFunctor :
    UCHomologicalComplex₂ C c₁ c₂ ⥤ UCHomologicalComplex₂ C c₂ c₁ where
  obj K := K.flip
  map {K L} f :=
    { f := fun i =>
        { f := fun j => (f.f j).f i
          comm' := by intros; simp }
      comm' := by intros; ext; simp }

/-- Auxiliary definition for `UCHomologicalComplex₂.flipEquivalence`. -/
@[simps!]
def flipEquivalenceUnitIso :
    𝟭 (UCHomologicalComplex₂ C c₁ c₂) ≅ flipFunctor C c₁ c₂ ⋙ flipFunctor C c₂ c₁ :=
  NatIso.ofComponents (fun K => UCHomologicalComplex.Hom.isoOfComponents (fun i₁ =>
    UCHomologicalComplex.Hom.isoOfComponents (fun _ => Iso.refl _)
    (by simp)) (by cat_disch)) (by cat_disch)

/-- Auxiliary definition for `UCHomologicalComplex₂.flipEquivalence`. -/
@[simps!]
def flipEquivalenceCounitIso :
    flipFunctor C c₂ c₁ ⋙ flipFunctor C c₁ c₂ ≅ 𝟭 (UCHomologicalComplex₂ C c₂ c₁) :=
  NatIso.ofComponents (fun K => UCHomologicalComplex.Hom.isoOfComponents (fun i₂ =>
    UCHomologicalComplex.Hom.isoOfComponents (fun _ => Iso.refl _)
    (by simp)) (by cat_disch)) (by cat_disch)

/-- Flipping a UC complex of complexes over the diagonal, as an equivalence of categories. -/
@[simps]
def flipEquivalence :
    UCHomologicalComplex₂ C c₁ c₂ ≌ UCHomologicalComplex₂ C c₂ c₁ where
  functor := flipFunctor C c₁ c₂
  inverse := flipFunctor C c₂ c₁
  unitIso := flipEquivalenceUnitIso C c₁ c₂
  counitIso := flipEquivalenceCounitIso C c₁ c₂

variable (K : UCHomologicalComplex₂ C c₁ c₂)

/-- The obvious isomorphism `(K.X x₁).X x₂ ≅ (K.X y₁).X y₂` when `x₁ = y₁` and `x₂ = y₂`. -/
def XXIsoOfEq {x₁ y₁ : I₁} (h₁ : x₁ = y₁) {x₂ y₂ : I₂} (h₂ : x₂ = y₂) :
    (K.X x₁).X x₂ ≅ (K.X y₁).X y₂ :=
  eqToIso (by subst h₁ h₂; rfl)

@[simp]
lemma XXIsoOfEq_rfl (i₁ : I₁) (i₂ : I₂) :
    K.XXIsoOfEq _ _ _ (rfl : i₁ = i₁) (rfl : i₂ = i₂) = Iso.refl _ := rfl


end UCHomologicalComplex₂
