/-
Copyright (c) 2023 Joël Riou. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Joël Riou
-/
module

public import UnionClosed.Mathlib.Algebra.Homology.UCAdditive
public import UnionClosed.Mathlib.Algebra.Homology.UCHomologicalComplexLimits
public import Mathlib.Algebra.Homology.ShortComplex.ShortExact

/-! # The category of UC homological complexes is abelian (UnionClosed cascade-fork copy).

This file is a textual fork of `Mathlib/Algebra/Homology/HomologicalComplexAbelian.lean`
(mathlib `v4.29.1`, commit `5e932f97`), namespace-renamed to `UCHomologicalComplex`.
This is sub-ticket 2 of the cascade-fork plan (mg-d079, depends on mg-f52c).

The key declaration is the Abelian instance for `UCHomologicalComplex C c`. After
sub-ticket 1's deletion of the direct `HasZeroMorphisms (UCHomologicalComplex V c)`
instance from `UCHomologicalComplex.lean`, this Abelian instance unambiguously
routes through the preadditive path — no priority ambiguity between the abelian
preadditive route and a competing direct route, because the direct route was
deleted.

The `single`-dependent material from mathlib's `HomologicalComplexAbelian.lean`
(originally lines 80-100, providing `Injective`/`Projective` instances on
`(single C c i).obj X .X j`) is **not forked** here, mirroring the choice made
in `UCAdditive.lean` (sub-ticket 1) to skip mathlib's `single`-dependent material.
See `docs/Frankl-cascade-fork-execution-plan.md` §3 for rationale.

Local-only fork per Daniel directive 2026-05-17T13:53Z. Not for upstream PR.

If `C` is an abelian category, then `UCHomologicalComplex C c` is an abelian
category for any complex shape `c : ComplexShape ι`. We also obtain that a
short complex in `UCHomologicalComplex C c` is exact (resp. short exact) iff
degreewise it is so.

-/

@[expose] public section

open CategoryTheory Category Limits

namespace UCHomologicalComplex

variable {C ι : Type*} {c : ComplexShape ι} [Category* C]

section

variable [Abelian C]

noncomputable instance : IsNormalEpiCategory (UCHomologicalComplex C c) := ⟨fun p _ =>
  ⟨NormalEpi.mk _ (kernel.ι p) (kernel.condition _)
    (isColimitOfEval _ _ (fun _ =>
      Abelian.isColimitMapCoconeOfCokernelCoforkOfπ _ _))⟩⟩

noncomputable instance : IsNormalMonoCategory (UCHomologicalComplex C c) := ⟨fun p _ =>
  ⟨NormalMono.mk _ (cokernel.π p) (cokernel.condition _)
    (isLimitOfEval _ _ (fun _ =>
      Abelian.isLimitMapConeOfKernelForkOfι _ _))⟩⟩

noncomputable instance : Abelian (UCHomologicalComplex C c) where

variable (S : ShortComplex (UCHomologicalComplex C c))

lemma exact_of_degreewise_exact (hS : ∀ (i : ι), (S.map (eval C c i)).Exact) :
    S.Exact := by
  simp only [ShortComplex.exact_iff_isZero_homology] at hS ⊢
  rw [IsZero.iff_id_eq_zero]
  ext i
  apply (IsZero.of_iso (hS i) (S.mapHomologyIso (eval C c i)).symm).eq_of_src

lemma shortExact_of_degreewise_shortExact
    (hS : ∀ (i : ι), (S.map (eval C c i)).ShortExact) :
    S.ShortExact where
  mono_f := mono_of_mono_f _ (fun i => (hS i).mono_f)
  epi_g := epi_of_epi_f _ (fun i => (hS i).epi_g)
  exact := exact_of_degreewise_exact S (fun i => (hS i).exact)

lemma exact_iff_degreewise_exact :
    S.Exact ↔ ∀ (i : ι), (S.map (eval C c i)).Exact := by
  constructor
  · intro hS i
    exact hS.map (eval C c i)
  · exact exact_of_degreewise_exact S

lemma shortExact_iff_degreewise_shortExact :
    S.ShortExact ↔ ∀ (i : ι), (S.map (eval C c i)).ShortExact := by
  constructor
  · intro hS i
    have := hS.mono_f
    have := hS.epi_g
    exact hS.map (eval C c i)
  · exact shortExact_of_degreewise_shortExact S

end

end UCHomologicalComplex
