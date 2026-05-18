/-
Copyright (c) 2026 Union-Closed Polecat Authors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Union-Closed Polecat (cat-mg-7e53 mathlib-bypass-replay).

**STATUS (mg-7e53, 2026-05-18): TEST SCAFFOLD, RESEARCH-TRACK.** Permanent
diagnostic file accompanying
`docs/state-Frankl-mathlib-bypass-replay-Session1.md`. Reproduces the
`Abelian (HomologicalComplex (HomologicalComplex C c₂) (ComplexShape.up ℤ))`
TC-diamond at the **exact Z2j-failed primitive**
(`Abelian.mono_cokernel_map_of_isPullback` applied to bicomplex-level
filtration inclusions) and documents the four mg-7e53 Approach-1
variants that mg-8dce did NOT try, all of which still RED with the
sharper diagnosis ("diamond at olean term reference, not TC search").

The Z2j-failed bicomplex example is left commented out so the file
builds GREEN as part of the project. The single-level companion example
at the bottom is uncommented and builds GREEN — confirming the new
diagnostic finding that the diamond is specifically a bicomplex
(double-level nesting) issue, not a generic HomologicalComplex one.

Do not delete or refactor without first reading:
`docs/state-Frankl-mathlib-bypass-replay-Session1.md` (mg-7e53 verdict),
`lean/AXIOMS.md` + `lean/UnionClosed/PaperAxioms.lean` (the named axiom
this file informs the escalation about), and
`docs/state-Frankl-mathlib-copy-and-tweak-Session1.md` (mg-8dce
predecessor, the 3 priority-based variants).
-/

import UnionClosed.Mathlib.Algebra.Homology.SpectralObject.Bicomplex
import Mathlib.CategoryTheory.Abelian.CommSq

set_option maxHeartbeats 1600000
set_option synthInstance.maxHeartbeats 800000

namespace UnionClosed.DiamondTest

open CategoryTheory Limits HomologicalComplex₂

/-- Inlined copy of `Bicomplex.lean`'s private helper. -/
private lemma isPullback_top_mono {D : Type*} [Category D] {X Y Z : D}
    (f : X ⟶ Y) (g : Y ⟶ Z) [Mono g] :
    IsPullback f (𝟙 X) g (f ≫ g) where
  w := by simp
  isLimit' := ⟨PullbackCone.IsLimit.mk (by simp)
    (fun s => s.snd)
    (fun s => by
      rw [← cancel_mono g, Category.assoc]
      exact s.condition.symm)
    (fun _ => Category.comp_id _)
    (fun _ _ _ hm₂ => by simpa using hm₂)⟩

variable {C : Type*} [Category C] [Preadditive C] [HasZeroObject C] [Abelian C]
  {I₂ : Type*} {c₂ : ComplexShape I₂}
  (K : HomologicalComplex₂ C (ComplexShape.up ℤ) c₂)
  {i j k : EInt} (h_ij : i ≤ j) (h_jk : j ≤ k)

-- Z2j-failed primitive (commented out — all four mg-7e53 Approach-1 variants
-- timeout in whnf or isDefEq; see state-Frankl-mathlib-bypass-replay-Session1.md):
--
--   `Mono (cokernel.map f (f ≫ g) (𝟙) g _)` for
--   `f := K.cutoffColumnsEInt_le h_jk`, `g := K.cutoffColumnsEInt_le h_ij`.
--
-- The diamond is not at TC search (which `[-instance]` does resolve) but at
-- olean term reference: the mathlib pre-compiled bicomplex `Abelian` instance
-- bakes the direct `HasZeroMorphisms` term into its proofs, and use-site
-- unification cannot reconcile that with the locally re-synthesized
-- preadditive path.
--
-- noncomputable example :
--     Mono (cokernel.map (K.cutoffColumnsEInt_le h_jk)
--       (K.cutoffColumnsEInt_le h_jk ≫ K.cutoffColumnsEInt_le h_ij)
--       (𝟙 _) (K.cutoffColumnsEInt_le h_ij) (by simp)) := by
--   haveI : Mono (K.cutoffColumnsEInt_le h_ij) := K.cutoffColumnsEInt_le_mono _
--   exact Abelian.mono_cokernel_map_of_isPullback (isPullback_top_mono _ _)

/-- Single-level diamond probe: does the diamond also bite at the
SINGLE-level `Abelian (HomologicalComplex C c)`? If GREEN, Approach 2
literal "copy ONLY `HomologicalComplex.lean`" would not help because
mathlib's `HomologicalComplexAbelian` (which provides `Abelian (HC ...)`)
must be re-elaborated against the forked HC too. -/
noncomputable example
    {D : Type*} [Category D] [Abelian D] [HasZeroObject D]
    {ι : Type*} {c : ComplexShape ι}
    (X Y Z : HomologicalComplex D c)
    (f : X ⟶ Y) (g : Y ⟶ Z) [Mono g] :
    Mono (cokernel.map f (f ≫ g) (𝟙 _) g (by simp)) := by
  exact Abelian.mono_cokernel_map_of_isPullback (isPullback_top_mono _ _)

end UnionClosed.DiamondTest
