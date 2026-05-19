/-
Copyright (c) 2021 Kim Morrison. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Kim Morrison
-/
module

public import Mathlib.Algebra.Group.Pi.Basic
public import UnionClosed.Mathlib.Algebra.Homology.UCHomologicalComplex
public import Mathlib.CategoryTheory.Preadditive.AdditiveFunctor

/-!
# Homology is an additive functor (UnionClosed cascade-fork copy).

This file is a textual fork of `Mathlib/Algebra/Homology/Additive.lean`
(mathlib `v4.29.1`, commit `5e932f97`), namespace-renamed to
`UCHomologicalComplex`. The load-bearing declaration is the
`instance : Preadditive (UCHomologicalComplex V c) where` (originally at
mathlib line 86), which — together with the deletion of the direct
`HasZeroMorphisms` instance in `UCHomologicalComplex.lean` — gives the
cascade fork a unique, diamond-free TC path for `HasZeroMorphisms` via
`preadditiveHasZeroMorphisms`.

The `single`-dependent material from mathlib's `Additive.lean`
(originally lines 222-287) is **not forked** here, because the cascade
fork does not need a `UCHomologicalComplex.single` functor for the
Sub-ticket-1 acceptance bars. See
`docs/Frankl-cascade-fork-execution-plan.md` §2 for rationale.

Local-only fork per Daniel directive 2026-05-17T13:53Z. Not for upstream PR.

When `V` is preadditive, `UCHomologicalComplex V c` is also preadditive,
and `homologyFunctor` is additive.

-/

@[expose] public section


universe v u

open CategoryTheory CategoryTheory.Category CategoryTheory.Limits UCHomologicalComplex

variable {ι : Type*}
variable {V : Type u} [Category.{v} V] [Preadditive V]
variable {W : Type*} [Category* W] [Preadditive W]
-- Strengthened from mathlib's original `[HasZeroMorphisms W₁] [HasZeroMorphisms W₂]`
-- to `[Preadditive W₁] [Preadditive W₂]` as part of the UnionClosed cascade fork
-- (mg-f52c): after deletion of the direct `HasZeroMorphisms (UCHomologicalComplex V c)`
-- instance, the fork's `UCHomologicalComplex W c` only has `HasZeroMorphisms`
-- under `[Preadditive W]` (via `preadditiveHasZeroMorphisms`), so the
-- `Functor.mapUCHomologicalComplex` machinery below must run under the
-- preadditive ambient. See `docs/Frankl-cascade-fork-execution-plan.md` §2d.
variable {W₁ W₂ : Type*} [Category* W₁] [Category* W₂] [Preadditive W₁] [Preadditive W₂]
variable {c : ComplexShape ι} {C D : UCHomologicalComplex V c}
variable (f : C ⟶ D) (i : ι)

namespace UCHomologicalComplex

instance : Zero (C ⟶ D) :=
  ⟨{ f := fun _ => 0 }⟩

instance : Add (C ⟶ D) :=
  ⟨fun f g => { f := fun i => f.f i + g.f i }⟩

instance : Neg (C ⟶ D) :=
  ⟨fun f => { f := fun i => -f.f i }⟩

instance : Sub (C ⟶ D) :=
  ⟨fun f g => { f := fun i => f.f i - g.f i }⟩

instance hasNatScalar : SMul ℕ (C ⟶ D) :=
  ⟨fun n f =>
    { f := fun i => n • f.f i
      comm' := fun i j _ => by simp [Preadditive.nsmul_comp, Preadditive.comp_nsmul] }⟩

instance hasIntScalar : SMul ℤ (C ⟶ D) :=
  ⟨fun n f =>
    { f := fun i => n • f.f i
      comm' := fun i j _ => by simp [Preadditive.zsmul_comp, Preadditive.comp_zsmul] }⟩

@[simp]
theorem zero_f_apply (i : ι) : (0 : C ⟶ D).f i = 0 :=
  rfl

@[simp]
theorem add_f_apply (f g : C ⟶ D) (i : ι) : (f + g).f i = f.f i + g.f i :=
  rfl

@[simp]
theorem neg_f_apply (f : C ⟶ D) (i : ι) : (-f).f i = -f.f i :=
  rfl

@[simp]
theorem sub_f_apply (f g : C ⟶ D) (i : ι) : (f - g).f i = f.f i - g.f i :=
  rfl

@[simp]
theorem nsmul_f_apply (n : ℕ) (f : C ⟶ D) (i : ι) : (n • f).f i = n • f.f i :=
  rfl

@[simp]
theorem zsmul_f_apply (n : ℤ) (f : C ⟶ D) (i : ι) : (n • f).f i = n • f.f i :=
  rfl

instance : AddCommGroup (C ⟶ D) :=
  Function.Injective.addCommGroup Hom.f UCHomologicalComplex.hom_f_injective
    (by cat_disch) (by cat_disch) (by cat_disch) (by cat_disch) (by cat_disch) (by cat_disch)

instance : Preadditive (UCHomologicalComplex V c) where

/--
`eval V c i` preserves zero morphisms.

Originally an instance in mathlib's `HomologicalComplex.lean` at line 335;
moved to this file as part of the UnionClosed cascade fork (mg-f52c)
because after deletion of the direct `HasZeroMorphisms (UCHomologicalComplex V c)`
instance, `HasZeroMorphisms (UCHomologicalComplex V c)` is only available
under `[Preadditive V]` (via `preadditiveHasZeroMorphisms`), which is the
ambient established here.
-/
instance eval_preservesZeroMorphisms (i : ι) :
    (eval V c i).PreservesZeroMorphisms where

/-- The `i`-th component of a chain map, as an additive map from chain maps to morphisms. -/
@[simps!]
def Hom.fAddMonoidHom {C₁ C₂ : UCHomologicalComplex V c} (i : ι) : (C₁ ⟶ C₂) →+ (C₁.X i ⟶ C₂.X i) :=
  AddMonoidHom.mk' (fun f => Hom.f f i) fun _ _ => rfl

instance eval_additive (i : ι) : (eval V c i).Additive where

end UCHomologicalComplex

namespace CategoryTheory

/-- An additive functor induces a functor between homological complexes.
This is sometimes called the "prolongation".
-/
@[simps]
def Functor.mapUCHomologicalComplex (F : W₁ ⥤ W₂) [F.PreservesZeroMorphisms] (c : ComplexShape ι) :
    UCHomologicalComplex W₁ c ⥤ UCHomologicalComplex W₂ c where
  obj C :=
    { X := fun i => F.obj (C.X i)
      d := fun i j => F.map (C.d i j)
      shape := fun i j w => by
        rw [C.shape _ _ w, F.map_zero]
      d_comp_d' := fun i j k _ _ => by rw [← F.map_comp, C.d_comp_d, F.map_zero] }
  map f :=
    { f := fun i => F.map (f.f i)
      comm' := fun i j _ => by
        dsimp
        rw [← F.map_comp, ← F.map_comp, f.comm] }

instance (F : W₁ ⥤ W₂) [F.PreservesZeroMorphisms] (c : ComplexShape ι) :
    (F.mapUCHomologicalComplex c).PreservesZeroMorphisms where

instance Functor.map_uc_homological_complex_additive
    (F : V ⥤ W) [F.Additive] (c : ComplexShape ι) :
    (F.mapUCHomologicalComplex c).Additive where

variable (W₁)

/-- The functor on homological complexes induced by the identity functor is
isomorphic to the identity functor. -/
@[simps!]
def Functor.mapUCHomologicalComplexIdIso (c : ComplexShape ι) :
    (𝟭 W₁).mapUCHomologicalComplex c ≅ 𝟭 _ :=
  NatIso.ofComponents fun K => Hom.isoOfComponents fun _ => Iso.refl _

instance Functor.mapUCHomologicalComplex_reflects_iso (F : W₁ ⥤ W₂) [F.PreservesZeroMorphisms]
    [ReflectsIsomorphisms F] (c : ComplexShape ι) :
    ReflectsIsomorphisms (F.mapUCHomologicalComplex c) :=
  ⟨fun f => by
    intro
    haveI : ∀ n : ι, IsIso (F.map (f.f n)) := fun n =>
        ((UCHomologicalComplex.eval W₂ c n).mapIso
          (asIso ((F.mapUCHomologicalComplex c).map f))).isIso_hom
    haveI := fun n => isIso_of_reflects_iso (f.f n) F
    exact UCHomologicalComplex.Hom.isIso_of_components f⟩

variable {W₁}

/-- A natural transformation between functors induces a natural transformation
between those functors applied to homological complexes.
-/
@[simps]
def NatTrans.mapUCHomologicalComplex {F G : W₁ ⥤ W₂}
    [F.PreservesZeroMorphisms] [G.PreservesZeroMorphisms] (α : F ⟶ G)
    (c : ComplexShape ι) : F.mapUCHomologicalComplex c ⟶ G.mapUCHomologicalComplex c where
  app C := { f := fun _ => α.app _ }

@[simp]
theorem NatTrans.mapUCHomologicalComplex_id
    (c : ComplexShape ι) (F : W₁ ⥤ W₂) [F.PreservesZeroMorphisms] :
    NatTrans.mapUCHomologicalComplex (𝟙 F) c = 𝟙 (F.mapUCHomologicalComplex c) := by cat_disch

@[simp]
theorem NatTrans.mapUCHomologicalComplex_comp (c : ComplexShape ι) {F G H : W₁ ⥤ W₂}
    [F.PreservesZeroMorphisms] [G.PreservesZeroMorphisms] [H.PreservesZeroMorphisms]
    (α : F ⟶ G) (β : G ⟶ H) :
    NatTrans.mapUCHomologicalComplex (α ≫ β) c =
      NatTrans.mapUCHomologicalComplex α c ≫ NatTrans.mapUCHomologicalComplex β c := by
  cat_disch

@[reassoc]
theorem NatTrans.mapUCHomologicalComplex_naturality {c : ComplexShape ι} {F G : W₁ ⥤ W₂}
    [F.PreservesZeroMorphisms] [G.PreservesZeroMorphisms]
    (α : F ⟶ G) {C D : UCHomologicalComplex W₁ c} (f : C ⟶ D) :
    (F.mapUCHomologicalComplex c).map f ≫ (NatTrans.mapUCHomologicalComplex α c).app D =
      (NatTrans.mapUCHomologicalComplex α c).app C ≫ (G.mapUCHomologicalComplex c).map f := by
  simp

/-- A natural isomorphism between functors induces a natural isomorphism
between those functors applied to homological complexes.
-/
@[simps!]
def NatIso.mapUCHomologicalComplex {F G : W₁ ⥤ W₂} [F.PreservesZeroMorphisms]
    [G.PreservesZeroMorphisms] (α : F ≅ G) (c : ComplexShape ι) :
    F.mapUCHomologicalComplex c ≅ G.mapUCHomologicalComplex c where
  hom := NatTrans.mapUCHomologicalComplex α.hom c
  inv := NatTrans.mapUCHomologicalComplex α.inv c
  hom_inv_id := by simp only [← NatTrans.mapUCHomologicalComplex_comp, α.hom_inv_id,
    NatTrans.mapUCHomologicalComplex_id]
  inv_hom_id := by simp only [← NatTrans.mapUCHomologicalComplex_comp, α.inv_hom_id,
    NatTrans.mapUCHomologicalComplex_id]

/-- An equivalence of categories induces an equivalences between the respective categories
of homological complex.
-/
@[simps]
def Equivalence.mapUCHomologicalComplex (e : W₁ ≌ W₂) [e.functor.PreservesZeroMorphisms]
    (c : ComplexShape ι) :
    UCHomologicalComplex W₁ c ≌ UCHomologicalComplex W₂ c where
  functor := e.functor.mapUCHomologicalComplex c
  inverse := e.inverse.mapUCHomologicalComplex c
  unitIso :=
    (Functor.mapUCHomologicalComplexIdIso W₁ c).symm ≪≫ NatIso.mapUCHomologicalComplex e.unitIso c
  counitIso := NatIso.mapUCHomologicalComplex e.counitIso c ≪≫
  Functor.mapUCHomologicalComplexIdIso W₂ c

end CategoryTheory

namespace UCChainComplex

variable {α : Type*} [AddRightCancelSemigroup α] [One α] [DecidableEq α]

set_option backward.isDefEq.respectTransparency false in
theorem map_chain_complex_of (F : W₁ ⥤ W₂) [F.PreservesZeroMorphisms] (X : α → W₁)
    (d : ∀ n, X (n + 1) ⟶ X n) (sq : ∀ n, d (n + 1) ≫ d n = 0) :
    (F.mapUCHomologicalComplex _).obj (UCChainComplex.of X d sq) =
      UCChainComplex.of (fun n => F.obj (X n)) (fun n => F.map (d n)) fun n => by
        rw [← F.map_comp, sq n, Functor.map_zero] := by
  refine UCHomologicalComplex.ext rfl ?_
  rintro i j (rfl : j + 1 = i)
  simp only [CategoryTheory.Functor.mapUCHomologicalComplex_obj_d, of_d, eqToHom_refl, comp_id,
    id_comp]

end UCChainComplex


