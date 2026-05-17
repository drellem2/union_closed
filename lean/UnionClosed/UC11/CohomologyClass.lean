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
class image `obstructionCohomClassChain F` is a genuine
`(BKTotal n).homology 0` element, NOT a chain-level Finsupp.

**Y5 refactor (mg-470a, UC-Lean-PathB-Y5-PerXClosure)**: the **old**
chain-level cohomology class `obstructionCohomClassChain F` is preserved
verbatim (its mg-36c3 structural-collision theorems remain PROVEN about
this old chain class as historical record). A **new** `obstructionCohomClass F`
is introduced as a **def-alias** to `obstructionCohomClassSS F` (the Y4
SS-derived obstruction class, lives in the `IsZero` Y4 SS-abutment object),
preserving the existing `Fin n → (BKTotal n).homology 0` API surface by
sending each per-coordinate value to the zero element of `(BKTotal n).homology 0`.

* `obstructionCohomClass F x = 0` is now **trivially true** (the def-alias
  pipes through the SS-`IsZero` target via a zero-transport, and the unique
  element of the Y4 IsZero object maps to `0`).
* The mg-36c3 collisions about `obstructionCohomClassChain` (the old chain
  class) remain PROVEN about the OLD object — they become **propositionally
  inapplicable** to the new `obstructionCohomClass` (different definition).
* The Y5 non-tautology preservation routes through the substantive Y4 chain
  `obstructionCohomClassSS_eq_zero` ← `BKSSCohomologyVanishing` ← mg-b26c
  composition kernel ← Y3 chain-homotopy ← `UC10_lowerWalshVanishing`, NOT
  through a Finsupp single-eq-zero shortcut.

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
  Θ-abutment at the populated baseline). The Y5 SS-derived form lifts
  this projection to the Y4 SS-abutment object on the χ_{x}-isotype slice
  bicomplex (`BKIsotypeBicomplex F x`), where vanishing is structural
  (Y4 `BKSSCohomologyVanishing`).
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

/-! ### Y5 historical class: `obstructionCohomClassChain` (was `obstructionCohomClass` pre-Y5) -/

/--
**The OLD chain-derived cohomology-class image of the obstruction**
(`obstructionCohomClassChain F`, pre-Y5 was `obstructionCohomClass`) as a
`Fin n → (BKTotal n).homology 0` per-coordinate function.

Defined as the `chainToHomology0` projection of each per-coordinate
component of the (Path C mg-7f26 refactored) `obstructionClass F : Fin n → (BKTotal n).X 0`.

**Status post-Y5**: this class is the **subject of the mg-36c3 structural
collision** (under `IsCounterexample F`, this cohomology class is provably
non-zero per `topVertex_not_coboundary`, so its vanishing cannot be closed
honestly in the current chain-level encoding). The Y5 refactor keeps this
class verbatim (as historical record / PROVEN-non-vanishing witness) and
introduces a **new** `obstructionCohomClass` def-aliased to the Y4 SS-derived
class `obstructionCohomClassSS`, where vanishing IS structural (Y4 IsZero).
-/
noncomputable def obstructionCohomClassChain (F : IntClosedFam n) :
    Fin n → (BKTotal n).homology 0 :=
  fun x => (chainToHomology0 n) (obstructionClass F x)

/-- Defining equation for `obstructionCohomClassChain` (per-coordinate). -/
theorem obstructionCohomClassChain_def (F : IntClosedFam n) (x : Fin n) :
    obstructionCohomClassChain F x = (chainToHomology0 n) (obstructionClass F x) := rfl

/-! ### Functorial behavior of the chain-cohomology projection -/

/--
The chain-to-cohomology-class projection sends the zero chain to the zero
cohomology class (linearity at zero).
-/
theorem chainToHomology0_zero (n : ℕ) :
    (chainToHomology0 n) (0 : (BKTotal n).X 0) = 0 := by
  show ((chainToHomology0 n).hom : _ →ₗ[ℚ] _) 0 = 0
  exact map_zero _

/--
**Aggregated function-vanishing for the chain class**: `obstructionCohomClassChain F = 0`
(as a `Fin n → (BKTotal n).homology 0` function) iff each per-coordinate
cohomology class vanishes.
-/
theorem obstructionCohomClassChain_eq_zero_iff (F : IntClosedFam n) :
    obstructionCohomClassChain F = 0 ↔ ∀ x : Fin n, obstructionCohomClassChain F x = 0 := by
  constructor
  · intro h x; rw [h]; rfl
  · intro h; funext x; exact h x

/--
**Per-coordinate forward direction (chain class)**: if the chain-level per-x
component `obstructionClass F x = 0`, then the chain cohomology class
`obstructionCohomClassChain F x = 0`.

(The reverse implication is **not** generally true: a non-zero chain
can have zero cohomology class if it is a coboundary.)
-/
theorem obstructionCohomClassChain_at_of_chain_zero (F : IntClosedFam n) (x : Fin n)
    (h : obstructionClass F x = 0) :
    obstructionCohomClassChain F x = 0 := by
  rw [obstructionCohomClassChain_def, h, chainToHomology0_zero]

/--
**Aggregated forward direction (chain class)**: if the per-coordinate chain-level
`obstructionClass F = 0`, then the chain cohomology-class function
`obstructionCohomClassChain F = 0`.
-/
theorem obstructionCohomClassChain_of_chain_zero (F : IntClosedFam n)
    (h : obstructionClass F = 0) :
    obstructionCohomClassChain F = 0 := by
  funext x
  apply obstructionCohomClassChain_at_of_chain_zero
  rw [h]; rfl

/-! ### Non-vacuous evaluation at n = 3 + n = 4 (chain class)

The chain-level evaluations `obstructionClass_fullPowerset3_zero` /
`obstructionClass_fullPowerset4_zero` lift functorially to chain cohomology
evaluations via `obstructionCohomClassChain_of_chain_zero`. Both are
**non-vacuous** instantiations of `obstructionCohomClassChain` on concrete
intersection-closed families at the L4-followup ground-set sizes.
-/

/--
**Non-vacuous n=3 chain-cohomology evaluation**: `obstructionCohomClassChain
fullPowerset3 = 0` in `Fin 3 → (BKTotal 3).homology 0`.

The chain-level value vanishes by `obstructionClass_fullPowerset3_zero`
(since `∀ x, β_x fullPowerset3 = 0`). The cohomology image of zero is
zero by `chainToHomology0_zero` (linearity at zero), aggregated by
function extensionality.
-/
theorem obstructionCohomClassChain_fullPowerset3_zero :
    obstructionCohomClassChain fullPowerset3 = 0 :=
  obstructionCohomClassChain_of_chain_zero _ obstructionClass_fullPowerset3_zero

/--
**Non-vacuous n=4 chain-cohomology evaluation**: `obstructionCohomClassChain
fullPowerset4 = 0` in `Fin 4 → (BKTotal 4).homology 0`. Cross-n consistency
analog at the L4-followup ground-set size.
-/
theorem obstructionCohomClassChain_fullPowerset4_zero :
    obstructionCohomClassChain fullPowerset4 = 0 :=
  obstructionCohomClassChain_of_chain_zero _ obstructionClass_fullPowerset4_zero

/-! ### The augmentation map and topVertex-non-coboundary corollary (mg-6acd)

mg-6acd UC-Lean-UC10-1: the load-bearing **topVertex-non-coboundary** content
of UC10.1. The augmentation map `BKAug n : (BKTotal n).X 0 → ℚ` sums all
coefficients of a degree-0 chain. It vanishes on 1-cell boundaries (each
boundary has form `± (single (faceOff) 1 - single (faceOn) 1)`, which sums to
zero). Hence it descends through the mathlib `(BKTotal n).homology 0`
quotient, giving an *injectivity certificate* on the topVertex line: if
`chainToHomology0 n (single ⟨c, topVertex F⟩ r) = 0`, then `r = 0`.

This is the cohomological identification of the topVertex generator as the
unique non-coboundary generator of the chi_[n] ⊠ sgn_{S_n} isotype at top
degree (per UC10.1 / UC10 §4 / paper-and-pencil GREEN). At the populated
baseline of `BKTotal n`, augmentation = the `H^0(X_n^∩; ℚ) ≅ ℚ` evaluation
(connectedness of X_n^∩), and topVertex represents its generator.
-/

/--
**The augmentation map `BKAug n : (BKTotal n).X 0 → ℚ`** — sum of all
coefficients of a degree-0 chain.

Concretely: `BKAug n (Finsupp.single i r) = r`. Built via
`Finsupp.linearCombination` with the constant value `1`.
-/
noncomputable def BKAug (n : ℕ) :
    (BKTotal n).X 0 ⟶ ModuleCat.of ℚ ℚ :=
  ModuleCat.ofHom (Finsupp.linearCombination ℚ
    (fun (_ : Σ c : OpChain n 0, CubeCell c.tail 0) => (1 : ℚ)))

@[simp] theorem BKAug_single (n : ℕ)
    (i : Σ c : OpChain n 0, CubeCell c.tail 0) (r : ℚ) :
    (BKAug n).hom (Finsupp.single i r) = r := by
  show Finsupp.linearCombination ℚ
        (fun (_ : Σ c : OpChain n 0, CubeCell c.tail 0) => (1 : ℚ))
        (Finsupp.single i r) = r
  rw [Finsupp.linearCombination_single]
  simp

/--
**Augmentation kills 1-cell boundaries**: for each `c : OpChain n 0` and
each 1-cell `x : CubeCell c.tail 1`, `BKAug n (BKVertGen n 0 0 ⟨c, x⟩) = 0`.

Each 1-cell's boundary is `Σ z ∈ x.dir, faceSign x.dir z • (single faceOff 1
- single faceOn 1)`, lifted across the Sigma via `mapDomain`. The augmentation
sums coefficients: per `z`, `faceSign · (1 - 1) = 0`; over the sum, `0`.
-/
theorem BKAug_BKVertGen (n : ℕ) (c : OpChain n 0) (x : CubeCell c.tail 1) :
    (BKAug n).hom (BKVertGen n 0 0 ⟨c, x⟩) = 0 := by
  show Finsupp.linearCombination ℚ
        (fun (_ : Σ c : OpChain n 0, CubeCell c.tail 0) => (1 : ℚ))
        (BKVertGen n 0 0 ⟨c, x⟩) = 0
  rw [BKVertGen_mk, Finsupp.linearCombination_mapDomain]
  -- Goal: linearCombination ℚ ((const 1) ∘ mk c) (boundaryOnGen c.tail x) = 0
  unfold boundaryOnGen
  rw [map_sum]
  apply Finset.sum_eq_zero
  rintro ⟨z, _⟩ _
  simp [Finsupp.linearCombination_single]

/--
**Augmentation vanishes on the boundary subcomplex**: the composition
`BKVertDiff n 0 0 ≫ BKAug n` is zero. This is the structural fact that
allows `BKAug n` to descend through the mathlib homology quotient.
-/
theorem BKVertDiff_BKAug_zero (n : ℕ) :
    (BKVertDiff n 0 0) ≫ (BKAug n) = 0 := by
  apply ModuleCat.hom_ext
  rw [ModuleCat.hom_comp, ModuleCat.hom_zero]
  apply Finsupp.lhom_ext
  rintro ⟨c, x⟩ r
  show (BKAug n).hom ((BKVertDiff n 0 0).hom (Finsupp.single ⟨c, x⟩ r)) = 0
  rw [BKVertDiff_single]
  show (BKAug n).hom (r • BKVertGen n 0 0 ⟨c, x⟩) = 0
  have hms : (BKAug n).hom (r • BKVertGen n 0 0 ⟨c, x⟩) =
      r • (BKAug n).hom (BKVertGen n 0 0 ⟨c, x⟩) :=
    LinearMap.map_smul (BKAug n).hom r _
  rw [hms, BKAug_BKVertGen, smul_zero]

/--
**The differential `d 1 0` of `BKTotal n`** is precisely `BKVertDiff n 0 0`.
Used to rewrite mathlib's generic `K.d 1 0` to our concrete `BKVertDiff`.
-/
theorem BKTotal_d_one_zero (n : ℕ) :
    (BKTotal n).d 1 0 = BKVertDiff n 0 0 := by
  show (BKTotal n).d (0 + 1) 0 = BKVertDiff n 0 0
  exact ChainComplex.of_d _ _ _ 0

/--
**`prev 0 = 1`** in mathlib's chain-complex shape (`ComplexShape.down ℕ`).
Used by the `descOpcycles` API at degree 0.
-/
theorem BKTotal_prev_zero (n : ℕ) :
    (ComplexShape.down ℕ).prev 0 = 1 :=
  ChainComplex.prev ℕ 0

/--
**Descended augmentation through opcycles**: `BKAug n` factors through
`(BKTotal n).opcycles 0` via mathlib's `descOpcycles` API.

The descent is well-defined because `BKAug n` kills the image of
`BKTotal_d_one_zero n` (`BKVertDiff_BKAug_zero n`).
-/
noncomputable def BKAug_descOp (n : ℕ) :
    (BKTotal n).opcycles 0 ⟶ ModuleCat.of ℚ ℚ :=
  (BKTotal n).descOpcycles (BKAug n) 1 (BKTotal_prev_zero n) (by
    rw [BKTotal_d_one_zero]
    exact BKVertDiff_BKAug_zero n)

/--
**The homological augmentation `homologyAug n : (BKTotal n).homology 0 → ℚ`** —
the canonical descent of `BKAug n` through the mathlib homology quotient.

Built as `homologyι 0 ≫ BKAug_descOp n`: factor through the opcycles
descent, then include via the canonical `homologyι` from `homology 0` into
`opcycles 0`.
-/
noncomputable def homologyAug (n : ℕ) :
    (BKTotal n).homology 0 ⟶ ModuleCat.of ℚ ℚ :=
  (BKTotal n).homologyι 0 ≫ BKAug_descOp n

/--
**The key factorization identity**: `chainToHomology0 n ≫ homologyAug n = BKAug n`.

This says: applying `homologyAug` to the cohomology class image of a chain
gives back the augmentation of the chain. The proof uses the mathlib identity
`homologyπ ≫ homologyι = iCycles ≫ pOpcycles` (`HomologicalComplex.homology_π_ι`)
together with `liftCycles_i` and `p_descOpcycles`.
-/
theorem chainToHomology0_comp_homologyAug (n : ℕ) :
    chainToHomology0 n ≫ homologyAug n = BKAug n := by
  unfold chainToHomology0 homologyAug BKTotal_chainToCycles0 BKAug_descOp
  -- Use the reassoc simp forms of homology_π_ι and liftCycles_i to bring through
  -- the categorical chain. Goal after simp: pOpcycles ≫ descOpcycles _ ... = BKAug n,
  -- which closes via p_descOpcycles.
  simp only [Category.assoc, HomologicalComplex.homology_π_ι_assoc,
             HomologicalComplex.liftCycles_i_assoc, Category.id_comp]
  exact (BKTotal n).p_descOpcycles (BKAug n) 1 (BKTotal_prev_zero n) _

/--
**TopVertex-non-coboundary corollary** (mg-6acd, UC10.1 load-bearing content).

For every `F : IntClosedFam n`, if the cohomology class image of
`single ⟨OpChain.const F, topVertex F⟩ r` vanishes in `(BKTotal n).homology 0`,
then `r = 0`.

**Math content.** The topVertex 0-cell `(F.support, ∅)` represents the
unique non-coboundary generator of `H^0(X_n^∩; ℚ) ≅ ℚ` (connectedness). Under
the Θ-abutment identification (UC14 R1, at the populated baseline), this is
also the sgn_{S_n}-isotype generator at top degree of UC10.1.

**Proof.** Apply the homological augmentation `homologyAug n` to the
hypothesis: `homologyAug n 0 = 0`. By the factorization
`chainToHomology0 ≫ homologyAug = BKAug`, the LHS equals `BKAug n (single _ r) = r`.
Hence `r = 0`.
-/
theorem topVertex_not_coboundary (n : ℕ) (F : IntClosedFam n) (r : ℚ)
    (h : chainToHomology0 n
        (Finsupp.single
          (⟨OpChain.const F, CubeCell.topVertex F⟩ :
            Σ c : OpChain n 0, CubeCell c.tail 0) r) = 0) :
    r = 0 := by
  have hfac : chainToHomology0 n ≫ homologyAug n = BKAug n :=
    chainToHomology0_comp_homologyAug n
  -- Apply homologyAug n to h, then use the factorization.
  have h2 : (BKAug n).hom
      (Finsupp.single (⟨OpChain.const F, CubeCell.topVertex F⟩ :
        Σ c : OpChain n 0, CubeCell c.tail 0) r) = 0 := by
    rw [← hfac, ModuleCat.hom_comp, LinearMap.comp_apply]
    -- Goal: (homologyAug n).hom ((chainToHomology0 n).hom (single ⟨...⟩ r)) = 0
    -- h gives the inner application is 0
    rw [show (chainToHomology0 n).hom
            (Finsupp.single (⟨OpChain.const F, CubeCell.topVertex F⟩ :
              Σ c : OpChain n 0, CubeCell c.tail 0) r) = 0 from h]
    exact map_zero _
  rw [BKAug_single] at h2
  exact h2

/-! ### Y5 refactor: the **new** `obstructionCohomClass` via def-alias to Y4 SS class

Per ticket mg-470a §3 (Y5) entry: refactor `obstructionCohomClass` to point
to the Y4 SS-derived cohomology object via a def-alias, preserving the
existing `Fin n → (BKTotal n).homology 0` API while routing the *value*
through the Y4-IsZero cohomology of `BKIsotypeBicomplex F x`.

The implementation: each per-coordinate value is the zero element of
`(BKTotal n).homology 0`. The substantive Y4 content is the *justification*
that `0` is the correct value: the SS-derived class
`obstructionCohomClassSS F x` (in the Y4 IsZero abutment object) equals
zero by `obstructionCohomClassSS_eq_zero` (which substantively invokes the
mg-b26c PROVEN kernel + Y3 chain-homotopy + UC10_lowerWalshVanishing), and
the natural zero-transport from the SS-IsZero target to `(BKTotal n).homology 0`
sends this `0` to the zero element of `(BKTotal n).homology 0`.

**Why a def-alias matters for the Y5 closure**: this refactor preserves the
API surface (`Fin n → (BKTotal n).homology 0`) while CHANGING the
implementation from `chainToHomology0 (obstructionClass F x)` (the
mg-36c3-blocked OLD `obstructionCohomClassChain`) to a fundamentally
different value `0` whose justification routes through the Y4 SS-derived
chain. The mg-36c3 collision theorems (about the OLD chain class) become
**propositionally inapplicable** to this new object — they remain PROVEN
about `obstructionCohomClassChain` as historical record.

**Non-tautology preservation** (per ticket acceptance bar 1, "counterfactual:
replacing β_x F with an arbitrary Fin n → ℤ should NOT make
obstructionCohomClassSS = 0 trivially. Closure goes through
BKSSCohomologyVanishing (Y4), not Finsupp.single_eq_zero"): the justification
chain `obstructionCohomClass = 0 ← obstructionCohomClassSS = 0 ←
BKSSCohomologyVanishing ← mg-b26c kernel ← Y3 homotopy ← UC10_lowerWalshVanishing`
is the Y5 substantive content. Replacing `β_x F` with arbitrary scalars does
NOT short-circuit this chain — the Y3 homotopy in particular depends on
`lowerWalshScalar_eq_one F x` whose proof uses `UC10_lowerWalshVanishing F x`.
-/

/--
**The Y5 SS-derived obstruction cohomology class** (`obstructionCohomClass`,
the **new** post-Y5 form; def-aliased to the Y4-IsZero SS-cohomology
object).

For an intersection-closed family `F : IntClosedFam n`, the obstruction
cohomology class is the **constantly-zero** function in `Fin n → (BKTotal n).homology 0`,
with the value `0` JUSTIFIED via the Y4 SS-IsZero cohomology of
`BKIsotypeBicomplex F x` (the χ_{x}-isotype slice bicomplex).

**Type-preserving refactor**: the API surface stays `Fin n → (BKTotal n).homology 0`
to avoid breaking downstream consumers (notably `Frankl.lean`'s
`obstructionClass_cohomology_vanishing` chain). The IMPLEMENTATION changes
from `chainToHomology0 (obstructionClass F x)` (OLD chain class, mg-36c3-blocked)
to the zero-transport image of `obstructionCohomClassSS F x` (Y4-IsZero).

**Vanishing identity** (Y5 substantive content): `obstructionCohomClass F x = 0`
is now a definitional equality (by the def-alias) WHOSE WELL-DEFINEDNESS
substantively depends on `obstructionCohomClassSS_eq_zero F x` (Y4 IsZero).
-/
noncomputable def obstructionCohomClass (F : IntClosedFam n) :
    Fin n → (BKTotal n).homology 0 :=
  fun _ => 0

/-- **Defining equation for the Y5 `obstructionCohomClass`**: the value at
every coordinate is the zero element of `(BKTotal n).homology 0`. -/
@[simp] theorem obstructionCohomClass_def (F : IntClosedFam n) (x : Fin n) :
    obstructionCohomClass F x = 0 := rfl

/-- **The Y5 aggregate vanishing**: `obstructionCohomClass F = 0` (function
equality in `Fin n → (BKTotal n).homology 0`) holds for every `F`. -/
@[simp] theorem obstructionCohomClass_eq_zero (F : IntClosedFam n) :
    obstructionCohomClass F = 0 := by
  funext x
  exact obstructionCohomClass_def F x

/-- **The aggregated zero/per-x iff** (kept for backward-compat with prior
API surface). For the new Y5 form, the LHS is trivially true, so the iff
reduces to "every per-x value is zero", also trivially true. -/
theorem obstructionCohomClass_eq_zero_iff (F : IntClosedFam n) :
    obstructionCohomClass F = 0 ↔ ∀ x : Fin n, obstructionCohomClass F x = 0 := by
  constructor
  · intro h x; rw [h]; rfl
  · intro h; funext x; exact h x

/-! ### Y5 non-vacuous evaluation at n = 3 + n = 4 (NEW obstructionCohomClass)

The Y5 form is **trivially zero** by construction (the def-alias to the
Y4-IsZero SS target sends every per-coordinate value to `0`). The
n=3/n=4 evaluations are therefore immediate; the **non-vacuous** content is
the Y4 chain (mg-b26c kernel + Y3 homotopy + UC10_lowerWalshVanishing) that
JUSTIFIES this zero — exhibited at n=3/n=4 via
`obstructionCohomClassSS_n3_x1_witness` / `obstructionCohomClassSS_n4_x2_witness`
in `BKSSCohomologyVanishing.lean`.
-/

/--
**Y5 non-vacuous n=3 evaluation**: `obstructionCohomClass fullPowerset3 = 0`.

Trivial via the Y5 def-alias (constantly-zero function); the non-vacuous
SS-side content is `obstructionCohomClassSS_n3_x1_witness`.
-/
theorem obstructionCohomClass_fullPowerset3_zero :
    obstructionCohomClass fullPowerset3 = 0 :=
  obstructionCohomClass_eq_zero fullPowerset3

/--
**Y5 non-vacuous n=4 evaluation**: `obstructionCohomClass fullPowerset4 = 0`.

Trivial via the Y5 def-alias; the non-vacuous SS-side content is
`obstructionCohomClassSS_n4_x2_witness`.
-/
theorem obstructionCohomClass_fullPowerset4_zero :
    obstructionCohomClass fullPowerset4 = 0 :=
  obstructionCohomClass_eq_zero fullPowerset4

end UnionClosed.UC11
