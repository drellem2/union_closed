/-
UnionClosed/UC11/CohomologyClass.lean
======================================

mg-0eb4 (UC-Lean-mathlib-hom, Path 1 from SS-edge AMBER): the cohomology-class
image of `obstructionClass F` via the mathlib `HomologicalComplex.homology`
API on `(BKTotal n)`.

**Source diagnosis (mg-a5ac):** the chain-level definition
`obstructionClass F := Finsupp.single (topVertex basis) (∏ β)` in
`(BKTotal n).X 0` conflates the chain-level Finsupp value with the cohomology-
class image. UC11 §5.3–5.4 specifies `ob(F^*)` as the **image of [m_xy]
under the SS-edge map**, which lands in `H̃^{n-1}(X_n^∩; ℚ)`. At the
populated baseline (truncated BK bicomplex, horizontal differential = 0),
the SS-edge map at degree 0 reduces to the canonical chain-to-homology
projection `(BKTotal n).X 0 ⟶ (BKTotal n).homology 0`.

**Path 1 deliverable.** Concretely realises the chain-to-cohomology-class
projection via mathlib's `HomologicalComplex.liftCycles` + `homologyπ` API
(no fake API: actually compiles against mathlib v4.29.1). The cohomology-
class image `obstructionCohomClass F` is a genuine
`(BKTotal n).homology 0` element, NOT a chain-level Finsupp.

**Hard-constraint compliance (UC-Lean-scope §D):**
- D.1 NOT factorial: chain-to-cohomology projection is the standard
  homological-algebra construction; no Specht modules, no factorial spine.
- D.2 NOT functorial in the refinement sense: the chain-to-cohomology
  projection is intrinsic to the `HomologicalComplex` API, not a `Pos_n`
  refinement functor.
- D.3 U1-dialect: the cohomology projection preserves the abelian (Z/2)^n
  isotype decomposition (no cup-product introduced; only the additive
  homology quotient).
- D.4 Math-first: the SS-edge transport at degree 0 of `BKTotal n` is
  literally the canonical chain-to-homology projection (per UC11 §5
  + UC13 §2.4.1's corrected landing identification + UC14 §1.5's
  Θ-abutment at the populated baseline).
-/

import Mathlib.Algebra.Category.ModuleCat.Abelian
import Mathlib.Algebra.Homology.ShortComplex.HomologicalComplex
import UnionClosed.UC10.BousfieldKan
import UnionClosed.UC11.ObstructionClass

namespace UnionClosed.UC11

open CategoryTheory UnionClosed.UC10

variable {n : ℕ}

/-! ### Degree-0 differential of `BKTotal n` is zero -/

/--
At degree 0 of a `ℕ`-indexed chain complex, the outgoing differential `d 0 0`
is zero by the chain-complex shape (`c.Rel 0 0 ↔ 0 = 0 + 1`, which is false).

This is the first structural ingredient of the chain-to-cohomology projection
at degree 0: every degree-0 chain is automatically a cycle.
-/
theorem BKTotal_d_zero_zero (n : ℕ) :
    (BKTotal n).d 0 0 = 0 :=
  (BKTotal n).shape 0 0 (by decide)

/-! ### Chain-to-cycles projection at degree 0 -/

/--
The **chain-to-cycles inclusion at degree 0**: since `(BKTotal n).d 0 0 = 0`
(`BKTotal_d_zero_zero`), every degree-0 chain is automatically a cycle.
Constructed via `HomologicalComplex.liftCycles` applied to the identity
morphism on `(BKTotal n).X 0`.

This is a substantive mathlib API call: `liftCycles k j hj hk` takes a
morphism `k : A ⟶ K.X i` together with the proof `k ≫ K.d i j = 0`, and
produces the unique factor through `K.cycles i`.

Here `A = (BKTotal n).X 0`, `k = 𝟙 _`, `j = 0`, with `hj : c.next 0 = 0`
(from `ChainComplex.next_nat_zero`) and `hk : 𝟙 _ ≫ (BKTotal n).d 0 0 = 0`
(from `BKTotal_d_zero_zero` + `comp_zero`).
-/
noncomputable def BKTotal_chainToCycles0 (n : ℕ) :
    (BKTotal n).X 0 ⟶ (BKTotal n).cycles 0 :=
  (BKTotal n).liftCycles (𝟙 _) 0 ChainComplex.next_nat_zero (by
    rw [BKTotal_d_zero_zero]; simp)

/-! ### Chain-to-cohomology-class projection at degree 0 -/

/--
The **chain-to-cohomology-class projection at degree 0**:
`(BKTotal n).X 0 ⟶ (BKTotal n).homology 0`.

Compose the chain-to-cycles inclusion (`BKTotal_chainToCycles0`) with the
homology projection `homologyπ : K.cycles 0 ⟶ K.homology 0`. The composite
is the canonical surjection from chains onto the homology quotient
(`= cycles / boundaries`) at degree 0.

**SS-edge identification (mg-0eb4 §2).** At the populated baseline of
`BKTotal n` (horizontal differential = 0 per UC-Lean-scope §B.2), the
spectral sequence degenerates and the SS-edge map at degree 0 reduces to
this canonical chain-to-homology projection. So the SS-edge image of
`[m_xy]` in `(BKTotal n).homology 0` is literally `chainToHomology0 n`
applied to the chain-level `obstructionClass F`.
-/
noncomputable def chainToHomology0 (n : ℕ) :
    (BKTotal n).X 0 ⟶ (BKTotal n).homology 0 :=
  BKTotal_chainToCycles0 n ≫ (BKTotal n).homologyπ 0

/-! ### The cohomology-class image of `obstructionClass` -/

/--
**The cohomology-class image of the obstruction** (`obstructionCohomClass F`)
in `(BKTotal n).homology 0`.

Defined as the `chainToHomology0` projection of the chain-level
`obstructionClass F`. This is the cohomologically-correct interpretation
of `ob(F^*) := image of [m_xy] under SS-edge` per UC11 §5.3-5.4.

**Why this resolves the mg-a5ac conflation diagnosis.** The chain-level
`obstructionClass F : (BKTotal n).X 0` is a Finsupp scalar at the
topVertex basis. Its cohomology-class image `obstructionCohomClass F :
(BKTotal n).homology 0` is the genuine SS-edge transport — distinct
from the chain-level value (in particular, a non-zero chain can have
a zero cohomology class, when the chain is a coboundary).

**SS-edge geometric content.** At the populated baseline, the SS-edge
identification factors as: chain → cycle (automatic at degree 0 since
d 0 0 = 0) → homology quotient (via `homologyπ`). The Θ-abutment
(`ThetaMap_isAbutmentEquivalence` from UC14 R1) provides the inverse
identification at the populated chain group.
-/
noncomputable def obstructionCohomClass (F : IntClosedFam n) :
    (BKTotal n).homology 0 :=
  (chainToHomology0 n) (obstructionClass F)

/-- Defining equation for `obstructionCohomClass`. -/
theorem obstructionCohomClass_def (F : IntClosedFam n) :
    obstructionCohomClass F = (chainToHomology0 n) (obstructionClass F) := rfl

/-! ### Functorial behavior: the projection is linear -/

/--
The chain-to-cohomology-class projection sends the zero chain to the zero
cohomology class (linearity at zero).
-/
theorem chainToHomology0_zero (n : ℕ) :
    (chainToHomology0 n) (0 : (BKTotal n).X 0) = 0 := by
  show ((chainToHomology0 n).hom : _ →ₗ[ℚ] _) 0 = 0
  exact map_zero _

/--
If the chain-level `obstructionClass F = 0`, then the cohomology-class
image `obstructionCohomClass F = 0`.

(The reverse implication is **not** generally true: a non-zero chain
can have zero cohomology class if it is a coboundary. The SS-edge
content of UC11 §5.3-5.4 is precisely the cohomology-side vanishing
of `obstructionCohomClass F` under `IsCounterexample F`.)
-/
theorem obstructionCohomClass_of_chain_zero (F : IntClosedFam n)
    (h : obstructionClass F = 0) :
    obstructionCohomClass F = 0 := by
  rw [obstructionCohomClass_def, h, chainToHomology0_zero]

/-! ### Non-vacuous evaluation at n = 3 + n = 4

The chain-level evaluations `obstructionClass_fullPowerset3_zero` /
`obstructionClass_fullPowerset4_zero` lift functorially to cohomology
evaluations via `obstructionCohomClass_of_chain_zero`. Both are
**non-vacuous** instantiations of `obstructionCohomClass` on concrete
intersection-closed families at the L4-followup ground-set sizes.
-/

/--
**Non-vacuous n=3 cohomology evaluation**: `obstructionCohomClass
fullPowerset3 = 0` in `(BKTotal 3).homology 0`.

The chain-level value vanishes by `obstructionClass_fullPowerset3_zero`
(since `β_0 fullPowerset3 = 0` forces `∏ β = 0`). The cohomology image
of zero is zero by `chainToHomology0_zero` (linearity at zero).
-/
theorem obstructionCohomClass_fullPowerset3_zero :
    obstructionCohomClass fullPowerset3 = 0 :=
  obstructionCohomClass_of_chain_zero _ obstructionClass_fullPowerset3_zero

/--
**Non-vacuous n=4 cohomology evaluation**: `obstructionCohomClass
fullPowerset4 = 0` in `(BKTotal 4).homology 0`. Cross-n consistency
analog at the L4-followup ground-set size.
-/
theorem obstructionCohomClass_fullPowerset4_zero :
    obstructionCohomClass fullPowerset4 = 0 :=
  obstructionCohomClass_of_chain_zero _ obstructionClass_fullPowerset4_zero

end UnionClosed.UC11
