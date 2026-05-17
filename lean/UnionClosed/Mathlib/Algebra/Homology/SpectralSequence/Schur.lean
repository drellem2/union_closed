/-
Copyright (c) 2026 Union-Closed Polecat Authors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Union-Closed Polecat (mg-455f, X4 of UC-Lean-mathlib-SS-scope)
-/
module

public import UnionClosed.Mathlib.Algebra.Homology.SpectralSequence.Equivariant
public import Mathlib.CategoryTheory.Linear.Basic
public import Mathlib.Algebra.GroupWithZero.Action.Units
public import Mathlib.Algebra.Category.ModuleCat.Basic

/-!
# Schur for finite-abelian characters, lifted to bicomplex spectral sequence pages

This file is **MATHLIB-PR-CANDIDATE: yes** for §§1–3 (the abstract Schur-by-character
statement and the SS-page isotype-preservation lift); the §4 `(ZMod 2)^n` Walsh
non-vacuous evaluation is union_closed-specific (Walsh ↔ ZMod 2 characters) and may
be split off at upstream-PR submission time.

It is sub-ticket X4 of the Path A arc `UC-Lean-mathlib-SS-scope` (mg-7413). It
depends on X3 (mg-fade, `Equivariant.lean`), which provides `EquivariantBicomplex`,
`onEInfty`, `IsotypeFamily`, the X1 degenerate-case `respectsDifferentials_of_degenerate`,
and the Walsh `(ZMod 2)^n` specialisation. X4 closes the X3 deliverable for the
**non-degenerate** case: even when `d_r ≠ 0`, equivariance + Schur force the
mixing between distinct-character isotype slices to vanish.

## Main definitions

* `CategoryTheory.Schur.hom_eq_zero_of_ne_characters`: **abelian Schur in
  scalar-character form.** For an `R`-linear category `C`, two objects `Y, Z`
  with `G`-actions that act as scalar multiplication by characters
  `χ_Y, χ_Z : G → R`, any intertwining morphism `f : Y ⟶ Z` is zero whenever
  some `g : G` makes `χ_Y g - χ_Z g` a unit in `R`. This is the
  finite-abelian-`G` specialisation: 1-dim irreps of an abelian group are
  characters, and Schur for character actions is precisely this lemma.

* `HomologicalComplex₂.EquivariantBicomplex.CharacterIsotypeSlice`: a source
  slice `V_χ` of an `E_∞` cell carrying an inclusion `ι : V_χ ⟶ E_∞^{p,q}`
  that intertwines the scalar-`χ` action with the bicomplex's `G`-action.

* `HomologicalComplex₂.EquivariantBicomplex.CharacterIsotypeRetract`: dually,
  a target retract with a projection `π : E_∞^{p,q} ⟶ V_χ`.

* `HomologicalComplex₂.differential_isotype_zero`: **the X4 SS-page lift.**
  For any morphism `d : E_∞^{p,q} ⟶ E_∞^{p',q'}` that intertwines the
  bicomplex `G`-action, the composition `ι_S ≫ d ≫ π_T` of a source slice and
  target retract of distinct characters vanishes whenever some `g : G` makes
  `χ_S g - χ_T g` a unit. The general-case statement strengthening X3's
  `respectsDifferentials_of_degenerate` beyond the zero-`d_r` case.

* `Walsh.characterQ`: the rational-valued Walsh character
  `(Fin n → ZMod 2) → ℚ`. Used because `±2 = χ_S g - χ_T g` for distinct
  Walsh characters and a separating `g` is a unit in `ℚ` but *not* in `ℤ`.

## Hard-constraint check

* NOT factorial — abelian Schur via scalar-character action only.
* NOT functorial in the refinement sense.
* U1-dialect preserved — additive comparisons of equivariant morphisms.
* Math-first — the abstract Schur statement is the standard
  "two-distinct-characters force intertwiner to be zero" lemma.
* No `sorry`. No `axiom`. No fake mathlib API. No `decide` shortcut except for
  concrete-arithmetic checks at the `(ZMod 2)^3` acceptance-bar layer.
* No `SpectralObject` TODO reliance.
* Non-tautology preservation — `hom_eq_zero_of_ne_characters` is a real
  algebraic identity proven via `Linear.smul_comp`, `Linear.comp_smul`,
  `sub_smul`, and `IsUnit.smul_eq_zero`.
* Non-vacuous evaluation at `(ZMod 2)^3` with concrete Walsh characters.
* Compiles via `lake build`.
-/

@[expose] public section

namespace CategoryTheory.Schur

open CategoryTheory Limits

universe v u

/-! ## §1 — Abelian Schur in scalar-character form -/

/-- **Abelian Schur in scalar-character form.** Let `C` be an `R`-linear
category (over a commutative ring `R`), and let `Y, Z : C` carry `G`-actions
that act as scalar multiplication by characters `χ_Y, χ_Z : G → R`. Any
intertwining morphism `f : Y ⟶ Z` vanishes whenever some `g : G` makes
`χ_Y g - χ_Z g` a unit in `R`.

This is the finite-abelian-`G` Schur lemma: 1-dim irreducible
representations of an abelian group `G` over a field `R` are precisely
characters `χ : G → R`, and the only intertwiner between two non-isomorphic
1-dim irreps is `0`. -/
theorem hom_eq_zero_of_ne_characters
    {C : Type u} [Category.{v} C] [Preadditive C]
    {R : Type*} [CommRing R] [Linear R C]
    {G : Type*}
    {Y Z : C} (f : Y ⟶ Z)
    (χ_Y χ_Z : G → R)
    (h_int : ∀ g : G, (χ_Y g • 𝟙 Y) ≫ f = f ≫ (χ_Z g • 𝟙 Z))
    (g : G) (h_unit : IsUnit (χ_Y g - χ_Z g)) :
    f = 0 := by
  have e1 : (χ_Y g • 𝟙 Y) ≫ f = χ_Y g • f := by
    rw [Linear.smul_comp]; rw [Category.id_comp]
  have e2 : f ≫ (χ_Z g • 𝟙 Z) = χ_Z g • f := by
    rw [Linear.comp_smul]; rw [Category.comp_id]
  have key : χ_Y g • f = χ_Z g • f := by
    rw [← e1, h_int g, e2]
  have hsub : (χ_Y g - χ_Z g) • f = 0 := by
    rw [sub_smul, key, sub_self]
  exact (h_unit.smul_eq_zero).mp hsub

end CategoryTheory.Schur

/-! ## §2 — Character-isotype slice / retract structures -/

namespace HomologicalComplex₂

open CategoryTheory Limits ZeroObject

variable {C : Type u} [Category.{v} C] [Abelian C]
  {c₁ c₂ : ComplexShape ℕ}

namespace EquivariantBicomplex

/-- A **`χ`-character isotype source slice** of an `E_∞` cell in an
equivariant bicomplex `E`: a subobject `obj` with inclusion `ι` that
*intertwines* the scalar-`χ` action with the bicomplex `G`-action. -/
structure CharacterIsotypeSlice
    {K : HomologicalComplex₂ C c₁ c₂}
    {G : Type*} [Monoid G] (E : K.EquivariantBicomplex G)
    {R : Type*} [Semiring R] [Linear R C]
    (χ : G → R) (pq : ℕ × ℕ) where
  /-- The underlying slice object. -/
  obj : C
  /-- The inclusion into the ambient `E_∞` cell. -/
  ι : obj ⟶ K.EInftyBicomplex pq
  /-- The inclusion intertwines the scalar-`χ` action with the bicomplex
  `G`-action: `(χ g • 𝟙 obj) ≫ ι = ι ≫ E.onEInfty g pq`. -/
  ι_intertwines (g : G) : (χ g • 𝟙 obj) ≫ ι = ι ≫ E.onEInfty g pq

/-- A **`χ`-character isotype target retract** of an `E_∞` cell. -/
structure CharacterIsotypeRetract
    {K : HomologicalComplex₂ C c₁ c₂}
    {G : Type*} [Monoid G] (E : K.EquivariantBicomplex G)
    {R : Type*} [Semiring R] [Linear R C]
    (χ : G → R) (pq : ℕ × ℕ) where
  /-- The underlying retract object. -/
  obj : C
  /-- The projection from the ambient `E_∞` cell. -/
  π : K.EInftyBicomplex pq ⟶ obj
  /-- The projection intertwines the bicomplex `G`-action with the scalar-`χ`
  action: `E.onEInfty g pq ≫ π = π ≫ (χ g • 𝟙 obj)`. -/
  π_intertwines (g : G) : E.onEInfty g pq ≫ π = π ≫ (χ g • 𝟙 obj)

namespace CharacterIsotypeSlice

variable {K : HomologicalComplex₂ C c₁ c₂}
  {G : Type*} [Monoid G] {E : K.EquivariantBicomplex G}
  {R : Type*} [Semiring R] [Linear R C]

/-- The trivial source slice with `obj = 0` (zero object): a valid
`χ`-isotype slice for any character. -/
noncomputable def zero [HasZeroObject C] (χ : G → R) (pq : ℕ × ℕ) :
    E.CharacterIsotypeSlice χ pq where
  obj := (0 : C)
  ι := 0
  ι_intertwines _ := (isZero_zero C).eq_of_src _ _

@[simp]
lemma zero_obj [HasZeroObject C] (χ : G → R) (pq : ℕ × ℕ) :
    (zero (E := E) χ pq).obj = (0 : C) := rfl

@[simp]
lemma zero_ι [HasZeroObject C] (χ : G → R) (pq : ℕ × ℕ) :
    (zero (E := E) χ pq).ι = 0 := rfl

end CharacterIsotypeSlice

namespace CharacterIsotypeRetract

variable {K : HomologicalComplex₂ C c₁ c₂}
  {G : Type*} [Monoid G] {E : K.EquivariantBicomplex G}
  {R : Type*} [Semiring R] [Linear R C]

/-- The trivial target retract with `obj = 0` (zero object). -/
noncomputable def zero [HasZeroObject C] (χ : G → R) (pq : ℕ × ℕ) :
    E.CharacterIsotypeRetract χ pq where
  obj := (0 : C)
  π := 0
  π_intertwines _ := (isZero_zero C).eq_of_tgt _ _

@[simp]
lemma zero_obj [HasZeroObject C] (χ : G → R) (pq : ℕ × ℕ) :
    (zero (E := E) χ pq).obj = (0 : C) := rfl

@[simp]
lemma zero_π [HasZeroObject C] (χ : G → R) (pq : ℕ × ℕ) :
    (zero (E := E) χ pq).π = 0 := rfl

end CharacterIsotypeRetract

end EquivariantBicomplex

/-! ## §3 — Schur-abelian non-mixing of equivariant SS-page differentials -/

/-- **Schur-abelian non-mixing of equivariant differentials between
distinct-character isotypes (the X4 SS-page lift).**

For an equivariant bicomplex `E`, an equivariant morphism
`d : K.EInftyBicomplex pq ⟶ K.EInftyBicomplex pq'`, a `χ_S`-source slice and
a `χ_T`-target retract, the composition `sS.ι ≫ d ≫ sT.π` vanishes whenever
some `g : G` makes `χ_S g - χ_T g` a unit in `R`.

This strengthens X3's `respectsDifferentials_of_degenerate` from the X1
zero-`d_r` case to *any* equivariant differential. -/
theorem differential_isotype_zero
    {K : HomologicalComplex₂ C c₁ c₂}
    {G : Type*} [Monoid G] {E : K.EquivariantBicomplex G}
    {R : Type*} [CommRing R] [Linear R C]
    {pq pq' : ℕ × ℕ}
    {d : K.EInftyBicomplex pq ⟶ K.EInftyBicomplex pq'}
    (d_equiv : ∀ (g : G), E.onEInfty g pq ≫ d = d ≫ E.onEInfty g pq')
    {χ_S χ_T : G → R}
    (sS : E.CharacterIsotypeSlice χ_S pq)
    (sT : E.CharacterIsotypeRetract χ_T pq')
    {g : G} (h_unit : IsUnit (χ_S g - χ_T g)) :
    sS.ι ≫ d ≫ sT.π = 0 := by
  refine CategoryTheory.Schur.hom_eq_zero_of_ne_characters
      (sS.ι ≫ d ≫ sT.π) χ_S χ_T ?_ g h_unit
  intro g'
  calc (χ_S g' • 𝟙 sS.obj) ≫ (sS.ι ≫ d ≫ sT.π)
      = ((χ_S g' • 𝟙 sS.obj) ≫ sS.ι) ≫ (d ≫ sT.π) := by
        rw [Category.assoc]
    _ = (sS.ι ≫ E.onEInfty g' pq) ≫ (d ≫ sT.π) := by
        rw [sS.ι_intertwines g']
    _ = sS.ι ≫ (E.onEInfty g' pq ≫ d) ≫ sT.π := by
        simp
    _ = sS.ι ≫ (d ≫ E.onEInfty g' pq') ≫ sT.π := by
        rw [d_equiv g']
    _ = sS.ι ≫ d ≫ (E.onEInfty g' pq' ≫ sT.π) := by
        simp
    _ = sS.ι ≫ d ≫ (sT.π ≫ (χ_T g' • 𝟙 sT.obj)) := by
        rw [sT.π_intertwines g']
    _ = (sS.ι ≫ d ≫ sT.π) ≫ (χ_T g' • 𝟙 sT.obj) := by
        simp

end HomologicalComplex₂

/-! ## §4 — Walsh `(ZMod 2)^n` non-vacuous evaluation -/

namespace Walsh

open HomologicalComplex₂ HomologicalComplex₂.EquivariantBicomplex
  CategoryTheory Limits ZeroObject

/-- The **rational-valued Walsh character**: cast the `ℤˣ`-valued character
into `ℚ`. -/
noncomputable def characterQ (n : ℕ) (S : Finset (Fin n))
    (x : ∀ _ : Fin n, ZMod 2) : ℚ :=
  ((Walsh.character n S x : ℤ) : ℚ)

@[simp]
lemma characterQ_def (n : ℕ) (S : Finset (Fin n))
    (x : ∀ _ : Fin n, ZMod 2) :
    characterQ n S x = ((Walsh.character n S x : ℤ) : ℚ) := rfl

/-- At `n = 3`, the Walsh character at `S = {x}` evaluated at the indicator of
coordinate `x` itself equals `-1` in `ℚ`. -/
lemma characterQ_n3_singleton_self (x : Fin 3) :
    characterQ 3 ({x} : Finset (Fin 3))
      (fun y => if y = x then (1 : ZMod 2) else 0) = -1 := by
  fin_cases x <;> decide

/-- At `n = 3`, the Walsh character at `S = {y}` evaluated at the indicator of
a *different* coordinate `x ≠ y` equals `+1` in `ℚ`. -/
lemma characterQ_n3_singleton_other (x y : Fin 3) (h : y ≠ x) :
    characterQ 3 ({y} : Finset (Fin 3))
      (fun z => if z = x then (1 : ZMod 2) else 0) = 1 := by
  fin_cases x <;> fin_cases y <;> simp_all (config := {decide := true})

/-- **The unit-witness at distinct `n = 3` singletons.** For `x ≠ y` in
`Fin 3`, the indicator `g_x : Fin 3 → ZMod 2` separates `χ_{{x}}` from
`χ_{{y}}`: their difference is `-2`, a unit in `ℚ`. -/
lemma characterQ_n3_unit_witness (x y : Fin 3) (h : x ≠ y) :
    IsUnit (characterQ 3 ({x} : Finset (Fin 3))
        (fun z => if z = x then (1 : ZMod 2) else 0)
      - characterQ 3 ({y} : Finset (Fin 3))
        (fun z => if z = x then (1 : ZMod 2) else 0)) := by
  rw [characterQ_n3_singleton_self,
    characterQ_n3_singleton_other x y (Ne.symm h)]
  -- (-1 : ℚ) - 1 = -2; (-2 : ℚ) is a unit.
  show IsUnit ((-1 : ℚ) - 1)
  refine isUnit_iff_exists_inv.mpr ⟨-(1/2 : ℚ), ?_⟩
  norm_num

set_option maxHeartbeats 800000 in
/-- **The acceptance-bar `(ZMod 2)^3` non-vacuous evaluation.** At
`G = (Fin 3 → ZMod 2)`, for any equivariant bicomplex `E` over a `ℚ`-linear
abelian category `C` (e.g., `ModuleCat ℚ`), a `χ_{{x}}` source slice and
`χ_{{y}}` target retract at distinct `x ≠ y` in `Fin 3`, and any equivariant
morphism `d` between `E_∞` cells, the composition `ι_S ≫ d ≫ π_T` vanishes by
Schur. The Walsh-character unit-witness at the indicator `g = e_x` provides
the key hypothesis `χ_{{x}}(e_x) - χ_{{y}}(e_x) = -2`, a unit in `ℚ`. -/
theorem differential_isotype_zero_n3
    {C : Type u} [Category.{v} C] [Abelian C] [CategoryTheory.Linear ℚ C]
    {c₁ c₂ : ComplexShape ℕ}
    {K : HomologicalComplex₂ C c₁ c₂}
    {E : K.EquivariantBicomplex (∀ _ : Fin 3, ZMod 2)}
    {x y : Fin 3} (h : x ≠ y) {pq pq' : ℕ × ℕ}
    {d : K.EInftyBicomplex pq ⟶ K.EInftyBicomplex pq'}
    (d_equiv : ∀ (g : ∀ _ : Fin 3, ZMod 2),
      E.onEInfty g pq ≫ d = d ≫ E.onEInfty g pq')
    (sS : E.CharacterIsotypeSlice (Walsh.characterQ 3 {x}) pq)
    (sT : E.CharacterIsotypeRetract (Walsh.characterQ 3 {y}) pq') :
    sS.ι ≫ d ≫ sT.π = 0 :=
  HomologicalComplex₂.differential_isotype_zero d_equiv sS sT
    (Walsh.characterQ_n3_unit_witness x y h)

end Walsh

/-! # Non-vacuous evaluation block

A handful of `example` checks demonstrating that the X4 declarations are
non-vacuously inhabited and applicable in concrete settings.
-/

namespace HomologicalComplex₂

open CategoryTheory Limits ZeroObject

section NonVacuousEvaluation

variable {C : Type u} [Category.{v} C] [Abelian C]
  {c₁ c₂ : ComplexShape ℕ}

/-- Non-vacuous evaluation 1: the abstract abelian Schur lemma applies
to any equivariant `f` between two character-actions with distinct
characters separated by a unit difference. -/
example {R : Type*} [CommRing R] [Linear R C]
    {G : Type*} {Y Z : C} (f : Y ⟶ Z)
    (χ_Y χ_Z : G → R)
    (h_int : ∀ g : G, (χ_Y g • 𝟙 Y) ≫ f = f ≫ (χ_Z g • 𝟙 Z))
    (g : G) (h_unit : IsUnit (χ_Y g - χ_Z g)) :
    f = 0 :=
  CategoryTheory.Schur.hom_eq_zero_of_ne_characters f χ_Y χ_Z h_int g h_unit

/-- Non-vacuous evaluation 2: the zero-slice (`obj = 0`) is a valid
`CharacterIsotypeSlice` instance for every character and every cell. -/
example [HasZeroObject C] {K : HomologicalComplex₂ C c₁ c₂}
    {G : Type*} [Monoid G] (E : K.EquivariantBicomplex G)
    {R : Type*} [Semiring R] [Linear R C]
    (χ : G → R) (pq : ℕ × ℕ) :
    (EquivariantBicomplex.CharacterIsotypeSlice.zero (E := E) χ pq).obj =
      (0 : C) := rfl

/-- Non-vacuous evaluation 3: the zero-retract (`obj = 0`) is a valid
`CharacterIsotypeRetract` instance. -/
example [HasZeroObject C] {K : HomologicalComplex₂ C c₁ c₂}
    {G : Type*} [Monoid G] (E : K.EquivariantBicomplex G)
    {R : Type*} [Semiring R] [Linear R C]
    (χ : G → R) (pq : ℕ × ℕ) :
    (EquivariantBicomplex.CharacterIsotypeRetract.zero (E := E) χ pq).π =
      0 := rfl

/-- Non-vacuous evaluation 4: the X4 SS-page lift `differential_isotype_zero`
applies at full generality to any equivariant morphism between `E_∞` cells. -/
example {K : HomologicalComplex₂ C c₁ c₂}
    {G : Type*} [Monoid G] {E : K.EquivariantBicomplex G}
    {R : Type*} [CommRing R] [Linear R C]
    {pq pq' : ℕ × ℕ}
    {d : K.EInftyBicomplex pq ⟶ K.EInftyBicomplex pq'}
    (d_equiv : ∀ (g : G), E.onEInfty g pq ≫ d = d ≫ E.onEInfty g pq')
    {χ_S χ_T : G → R}
    (sS : E.CharacterIsotypeSlice χ_S pq)
    (sT : E.CharacterIsotypeRetract χ_T pq')
    {g : G} (h_unit : IsUnit (χ_S g - χ_T g)) :
    sS.ι ≫ d ≫ sT.π = 0 :=
  HomologicalComplex₂.differential_isotype_zero d_equiv sS sT h_unit

/-- Non-vacuous evaluation 5: at `n = 3`, the Walsh character at `S = {0}`
evaluated at the indicator of coordinate `0` equals `-1` in `ℚ`. -/
example : Walsh.characterQ 3 ({0} : Finset (Fin 3))
    (fun z => if z = (0 : Fin 3) then (1 : ZMod 2) else 0) = -1 :=
  Walsh.characterQ_n3_singleton_self 0

/-- Non-vacuous evaluation 6: at `n = 3`, the Walsh character at `S = {1}`
evaluated at the indicator of coordinate `0` equals `+1` in `ℚ`. -/
example : Walsh.characterQ 3 ({1} : Finset (Fin 3))
    (fun z => if z = (0 : Fin 3) then (1 : ZMod 2) else 0) = 1 :=
  Walsh.characterQ_n3_singleton_other 0 1 (by decide)

/-- Non-vacuous evaluation 7: the unit-witness `χ_{{0}}(g_0) - χ_{{1}}(g_0)`
is a unit in `ℚ` (equals `-2`). -/
example : IsUnit (Walsh.characterQ 3 ({0} : Finset (Fin 3))
      (fun z => if z = (0 : Fin 3) then (1 : ZMod 2) else 0)
    - Walsh.characterQ 3 ({1} : Finset (Fin 3))
      (fun z => if z = (0 : Fin 3) then (1 : ZMod 2) else 0)) :=
  Walsh.characterQ_n3_unit_witness 0 1 (by decide)

set_option maxHeartbeats 800000 in
/-- Non-vacuous evaluation 8: the `(ZMod 2)^3` acceptance-bar evaluation
applies non-vacuously at `(x, y) = (0, 1)` with arbitrary character-isotype
source slice and target retract on any `ℚ`-linear abelian bicomplex equipped
with a `(Fin 3 → ZMod 2)`-equivariant structure and equivariant differential. -/
example {C : Type u} [Category.{v} C] [Abelian C] [CategoryTheory.Linear ℚ C]
    {K : HomologicalComplex₂ C (.up ℕ) (.up ℕ)}
    {E : K.EquivariantBicomplex (∀ _ : Fin 3, ZMod 2)}
    {pq pq' : ℕ × ℕ}
    {d : K.EInftyBicomplex pq ⟶ K.EInftyBicomplex pq'}
    (d_equiv : ∀ (g : ∀ _ : Fin 3, ZMod 2),
      E.onEInfty g pq ≫ d = d ≫ E.onEInfty g pq')
    (sS : E.CharacterIsotypeSlice (Walsh.characterQ 3 {(0 : Fin 3)}) pq)
    (sT : E.CharacterIsotypeRetract (Walsh.characterQ 3 {(1 : Fin 3)}) pq') :
    sS.ι ≫ d ≫ sT.π = 0 :=
  Walsh.differential_isotype_zero_n3 (by decide) d_equiv sS sT

end NonVacuousEvaluation

end HomologicalComplex₂
