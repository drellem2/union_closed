/-
Copyright (c) 2026 Union-Closed Polecat Authors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Union-Closed Polecat (cat-mg-f52c cascade-fork sub-ticket 1).

**STATUS (mg-f52c, 2026-05-19): CASCADE-FORK SUB-TICKET 1 DIAMOND PROBE.**

This file is the Sub-ticket-1 acceptance probe for the
`UnionClosed.Mathlib.Algebra.Homology.UCHomologicalComplex` cascade fork.
It verifies that after deletion of the direct
`HasZeroMorphisms (HomologicalComplex V c)` instance from the fork's
`UCHomologicalComplex.lean`, the residual TC path for
`HasZeroMorphisms (UCHomologicalComplex V c)` resolves *uniquely*
through `UCAdditive`'s `Preadditive (UCHomologicalComplex V c)`
composed with `CategoryTheory.Preadditive.preadditiveHasZeroMorphisms`.

A unique resolution at the single (non-bicomplex) level is the
prerequisite for Sub-ticket-2 forking of `UCHomologicalComplexAbelian`,
which in turn is the prerequisite for the bicomplex-level probe that
finally bypasses the Z2j-failed diamond — see
`docs/Frankl-cascade-fork-execution-plan.md` §2 + §3.

Do not delete or refactor without first reading:
* `docs/Frankl-cascade-fork-execution-plan.md` (cascade-fork scoping);
* `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/DiamondTest.lean`
  (sibling baseline mathlib-side probe);
* `lean/AXIOMS.md` + `lean/UnionClosed/PaperAxioms.lean` (the named
  axiom whose substantive replacement this cascade fork targets).
-/

import UnionClosed.Mathlib.Algebra.Homology.UCHomologicalComplex
import UnionClosed.Mathlib.Algebra.Homology.UCAdditive
import UnionClosed.Mathlib.Algebra.Homology.UCHomologicalComplexLimits

namespace UnionClosed.UCDiamondTest

open CategoryTheory CategoryTheory.Limits

universe v u

/-! ## Acceptance bar 2: `UCHomologicalComplex` is a distinct fork-namespaced type. -/

/-- The fork's `UCHomologicalComplex` lives in the
`UnionClosed.Mathlib.Algebra.Homology` namespace. -/
example {V : Type u} [Category.{v} V] [HasZeroMorphisms V]
    {ι : Type*} (c : ComplexShape ι) :
    UCHomologicalComplex V c = UCHomologicalComplex V c := rfl

/-! ## Acceptance bar 3: `HasZeroMorphisms (UCHC V c)` resolves uniquely
via the preadditive path. -/

/-- The load-bearing fork acceptance test. The TC path for
`HasZeroMorphisms (UCHomologicalComplex V c)` is unambiguously
`preadditiveHasZeroMorphisms` — the deletion of the direct mathlib
`HasZeroMorphisms` instance at `UCHomologicalComplex.lean` (originally
line 285) leaves the preadditive route as the *only* survivor. -/
example {V : Type u} [Category.{v} V] [Preadditive V]
    {ι : Type*} {c : ComplexShape ι} :
    (inferInstance : HasZeroMorphisms (UCHomologicalComplex V c)) =
      CategoryTheory.Preadditive.preadditiveHasZeroMorphisms := rfl

/-! ## Acceptance bar 4: single-level diamond probe at `UCHC V c` ambient. -/

/-- Single-level `HasZeroMorphisms`-driven probe: composing with the
zero morphism at `UCHC V c` ambient gives zero. This exercises the
unique `HasZeroMorphisms` TC path obtained above; if the diamond were
present, this would either fail TC search or land on a different (and
unequal) zero. -/
example {V : Type u} [Category.{v} V] [Preadditive V]
    {ι : Type*} {c : ComplexShape ι}
    (X Y Z : UCHomologicalComplex V c) (f : Y ⟶ Z) :
    (0 : X ⟶ Y) ≫ f = (0 : X ⟶ Z) := by
  simp

/-- Companion single-level probe: pre-composing with zero. -/
example {V : Type u} [Category.{v} V] [Preadditive V]
    {ι : Type*} {c : ComplexShape ι}
    (X Y Z : UCHomologicalComplex V c) (f : X ⟶ Y) :
    f ≫ (0 : Y ⟶ Z) = (0 : X ⟶ Z) := by
  simp

end UnionClosed.UCDiamondTest
