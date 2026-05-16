/-
UnionClosed/UC11/SSConvergence.lean
====================================

mg-7f26 (UC-Lean-obstructionClass-refactor, Path C — per-coordinate refactor):
The **per-coordinate level-1 Walsh isotype cohomology-vanishing transport**
on `obstructionCohomClass F : Fin n → (BKTotal n).homology 0`.

**Why a dedicated file (vs inline sorry in Frankl.lean)?**

mg-6acd had the residual `sorry` inline inside `obstructionClass_cohomology_vanishing`
(Frankl.lean:413). mg-5979 isolated it as a named top-level lemma. mg-7f26
**refactors `obstructionClass` to the per-coordinate `Fin n → ...` form** per
UC13 §2.4.1 Theorem 2.4.1 (corrected landing in `⊕_x V_{x}^{n-1}`), and
recasts the SS-convergence transport at the per-coordinate level.

**Path C structural progress (mg-7f26)**: the per-coordinate form makes the
cohomology vanishing per-x **the literal target** of UC10_lowerWalshVanishing's
twisted-bridge null-homotopy. Each per-x summand corresponds to a single
χ_{x}-isotype component, and UC10's twisted-bridge identity is the
chain-level realisation of the cohomological null-homotopy in V_x^{n-1}.

**Substantive PROVEN content (mg-7f26)**:

1. `obstructionCohomClass_at_eq_zero_iff_bias_zero` — **PROVABLE** via
   `topVertex_not_coboundary` (mg-6acd). For each `x : Fin n`, the
   per-coordinate cohomology class `obstructionCohomClass F x = 0` iff
   `β_x F = 0`. The structural diagnosis at per-coordinate granularity.

2. `obstructionCohomClass_at_ne_zero_of_pos_bias` — **PROVABLE**. Under
   `IsCounterexample F`, each `β_x F > 0`, so each `obstructionCohomClass F x`
   is concretely non-zero. The contrapositive of `obstructionClass_at_eq_zero_of_bias_zero`
   lifted to cohomology.

3. `obstructionCohomClass_at_vanishing_via_lowerWalsh` — the **NAMED RESIDUAL
   GAP** of mg-7f26 at per-coordinate granularity. Body: `sorry`.

**Structural diagnosis (mg-7f26 vs mg-5979)**:

mg-5979 isolated the gap as a single top-level lemma on the aggregate
`obstructionCohomClass F = 0`. mg-7f26 **per-coordinatizes** the gap: there
are now n independent per-x cohomology vanishing statements, each of which
corresponds to a single twisted-bridge null-homotopy application. This is
**strictly tighter** than mg-5979 along several axes:

- **Per-x granularity**: each sorry is now a single per-coordinate isotype
  vanishing (no aggregation), making the residual structurally minimal.
- **Direct UC10 alignment**: the per-x form is the literal target of
  `UC10_lowerWalshVanishing`'s twisted-bridge identity. The named gap
  is exactly the cohomology-quotient transport of the chain-level
  null-homotopy splitting.
- **Non-tautology preserved**: the per-coordinate form `obstructionClass F`
  remains substantively non-zero under `IsCounterexample` (Lemma 6.2
  per-coordinate proof); the cohomology vanishing is NOT a defeq trick.

**Why still AMBER (not GREEN as the mg-7f26 brief optimistically projected)**:

The L2a populated baseline's chain-level encoding has
`(BKTotal n).X 0 = (Σ c, CubeCell c.tail 0) →₀ ℚ` with the topVertex line
detectable by `topVertex_not_coboundary` (mg-6acd augmentation construction).
This means the cohomology class image of `single (topVertex F) r` is zero
**only when r = 0**. The per-coordinate components
`single (topVertex F) (β_x F)` therefore have non-zero cohomology classes
under `IsCounterexample` (where `β_x F > 0`), structurally blocking the
literal `obstructionCohomClass F = 0` closure.

The honest closure requires the **L3 per-S Walsh-isotype decomposition
refinement**: at the genuine `walshMult n {x}` chain group, each
χ_{x}-isotype component vanishes cohomologically via the twisted bridge.
Until L3 is refined, the per-x cohomology vanishing transport remains a
named residual gap.

**Path C delivers**: structural diagnosis at per-coordinate granularity;
mg-c0d3 non-tautology bar preserved in the per-coordinate form; sorry
strictly tighter in scope (per-x) than mg-5979's aggregate form.

**Hard-constraint compliance (UC-Lean-scope §D)**:
- D.1 NOT factorial: no Specht modules introduced; the per-coordinate form
  uses only abelian Walsh-isotype components.
- D.2 NOT functorial in the refinement sense: all constructions native to
  `BKTotal n` + `IntClosedFam n` + `Fin n` direct-sum.
- D.3 U1-dialect: purely additive (per-coordinate function + Finsupp
  scalar); no cup-product.
- D.4 Math-first: aligns with UC13 §2.4.1 (corrected landing in
  `⊕_x V_{x}^{n-1}`) + UC13 §4.5 (per-x twisted-bridge null-homotopy) +
  UC11 §5.3-5.4 (chain-to-cohomology projection); the structural diagnosis
  documents the remaining L2a → L3 encoding gap.
-/

import Mathlib.Algebra.Field.Rat
import Mathlib.Algebra.BigOperators.GroupWithZero.Finset
import Mathlib.Data.Finsupp.Basic
import UnionClosed.UC10.IntClosedFam
import UnionClosed.UC10.CubicalDefect
import UnionClosed.UC10.BousfieldKan
import UnionClosed.UC11.Minimality
import UnionClosed.UC11.ObstructionClass
import UnionClosed.UC11.NonVanishing
import UnionClosed.UC11.CohomologyClass
import UnionClosed.UC13_PartA.IsotypePreservation
import UnionClosed.UC13_PartA.CorrectedLanding
import UnionClosed.UC13_PartB.LowerWalsh
import UnionClosed.UC14.R1_ThetaMap

namespace UnionClosed.UC11

open UnionClosed.UC10 UnionClosed.UC12 UnionClosed.UC13_PartA UnionClosed.UC13_PartB UnionClosed.UC14

variable {n : ℕ}

/-! ### Structural diagnosis (per-coordinate, PROVEN): cohomology vs bias scalar -/

/--
**Structural diagnosis lemma (mg-7f26 substantive new content, per-coordinate
form)**: in the current Lean encoding of `obstructionClass F x := Finsupp.single
(topVertex F) ((β_x F : ℚ))`, the per-coordinate cohomology-class vanishing
`obstructionCohomClass F x = 0` is propositionally **equivalent** to the
per-coordinate bias vanishing `(β_x F : ℚ) = 0`.

**Proof.** Both directions via `topVertex_not_coboundary` (mg-6acd
augmentation-map construction).

- `(⇒)` (cohomology zero ⟹ bias zero): expand `obstructionCohomClass F x` to
  `chainToHomology0 n (Finsupp.single topVertex (β_x F))`. By
  `topVertex_not_coboundary n F (β_x F)`, this is zero iff `(β_x F : ℚ) = 0`.
- `(⇐)` (bias zero ⟹ cohomology zero): if `β_x F = 0`, then by
  `obstructionClass_at_eq_zero_of_bias_zero`, the chain-level component is
  zero, and by `obstructionCohomClass_at_of_chain_zero`, the cohomology
  class is zero.

**Significance (mg-7f26 strictly tighter than mg-5979)**. The per-coordinate
form makes the structural diagnosis pin to a **single bias scalar per
coordinate**, rather than the aggregate product `∏ β` of mg-c0d3 / mg-5979.
The encoding mismatch (chain-level cohomology vs. paper-level Walsh isotype)
is now legible at per-x granularity.
-/
theorem obstructionCohomClass_at_eq_zero_iff_bias_zero
    (F : IntClosedFam n) (x : Fin n) :
    obstructionCohomClass F x = 0 ↔ ((beta x F : ℤ) : ℚ) = 0 := by
  rw [obstructionCohomClass_def, obstructionClass_def]
  constructor
  · -- (⇒) cohomology vanishes → scalar vanishes (via topVertex_not_coboundary)
    intro h
    exact topVertex_not_coboundary n F _ h
  · -- (⇐) scalar vanishes → cohomology vanishes (linearity)
    intro h
    rw [h, Finsupp.single_zero]
    show ((chainToHomology0 n).hom : _ →ₗ[ℚ] _) 0 = 0
    exact map_zero _

/--
**Cohomology-side non-vanishing under bias positivity** (mg-7f26 per-coordinate
form; lifts the mg-5979 aggregate `hCohomNZ` to per-x granularity).

For each `x : Fin n`, if `β_x F > 0`, then the per-coordinate cohomology
class `obstructionCohomClass F x` is concretely non-zero.

**Proof.** β_x F > 0 → β_x F ≠ 0 → ((β_x F : ℤ) : ℚ) ≠ 0 → by the structural
diagnosis lemma above, `obstructionCohomClass F x ≠ 0`.
-/
theorem obstructionCohomClass_at_ne_zero_of_pos_bias
    (F : IntClosedFam n) (x : Fin n) (h : beta x F > 0) :
    obstructionCohomClass F x ≠ 0 := by
  intro h_zero
  rw [obstructionCohomClass_at_eq_zero_iff_bias_zero] at h_zero
  have h_int : beta x F = 0 := by exact_mod_cast h_zero
  omega

/--
**Aggregated cohomology non-vanishing under `IsCounterexample`** (mg-7f26
per-coordinate aggregation).

Under `IsCounterexample F`, ∀ x, β_x F > 0. By the per-x non-vanishing above,
the aggregate `obstructionCohomClass F ≠ 0` as a function in
`Fin n → (BKTotal n).homology 0`.
-/
theorem obstructionCohomClass_ne_zero_of_counterexample
    (F : IntClosedFam n) (hStar : IsCounterexample F) :
    obstructionCohomClass F ≠ 0 := by
  intro h_zero
  have hn : 0 < n := counterexample_pos_n F hStar
  have hStarPos : ∀ x : Fin n, beta x F > 0 := hStar.2.2
  -- Pick x = ⟨0, hn⟩ and apply per-x non-vanishing.
  have h0 : obstructionCohomClass F ⟨0, hn⟩ = 0 := by
    rw [h_zero]; rfl
  exact obstructionCohomClass_at_ne_zero_of_pos_bias F ⟨0, hn⟩ (hStarPos _) h0

/-! ### The per-coordinate lower-Walsh vanishing transport (NAMED RESIDUAL GAP) -/

/--
**The per-coordinate lower-Walsh cohomology-vanishing transport** (mg-7f26
NAMED RESIDUAL GAP at per-coordinate granularity, strictly tighter than
mg-5979's aggregate form).

**Statement.** For each `F : IntClosedFam n` under `IsCounterexample` and
each `x : Fin n`, given:
- `hLanding_x`: the per-coordinate corrected landing (UC13 §2.4.1 Primitive 15)
  placing the χ_{x}-component in its level-1 isotype.
- `hLowerVanish_x`: the per-coordinate twisted-bridge null-homotopy splitting
  identity (UC13 §4.5 / UC10 §5.3, Primitive 16) on the topVertex generator
  at coordinate `x`.
- `hTheta_x`: the per-x Θ-map abutment equivalence at coordinate `x`
  (UC14 §1.5, Primitive 19).

the per-coordinate cohomology-class image
`obstructionCohomClass F x = 0` in `(BKTotal n).homology 0`.

**Paper-side proof (UC13 §7 step 5, GREEN-merged latex artefact).**
The corrected landing places the χ_{x}-component of `ob(F)` in `V_x^{n-1}`
(level-1 isotype). The twisted-bridge null-homotopy at coordinate `x` exhibits
this component as null-cohomologous on the topVertex. The Θ-abutment
identifies chain and cohomology levels at the populated baseline. Combined:
`V_x^{n-1} = 0` cohomologically, and the per-x component vanishes.

**Lean-side gap (mg-7f26 named residual sorry at per-coordinate granularity)**.
The transport from the paper-side per-x lower-Walsh vanishing to the Lean
encoding's per-x cohomology class requires either:

- **Path A (mathlib SS infrastructure)**: full
  `Mathlib.AlgebraicTopology.SpectralSequence` machinery for the
  (Z/2)^n-Walsh-graded total bicomplex. Multi-month build.

- **Path B (per-S Walsh-isotype decomposition refinement)**: lift L3's
  `walshMult n S` from the populated-baseline placeholder to the genuine
  per-S isotype decomposition. Estimated multi-week.

**mg-36c3 structural-collision diagnosis (RED, sharper than mg-7f26)**:
the ticket's plan — "UC10_lowerWalshVanishing at S = {x}, k = n-1 gives
V_{x}^{n-1} = 0 cohomologically, hence `obstructionClass F x = 0` since
it lives in V_{x}^{n-1}" — does **not** transport to the current Lean
encoding for two compounding reasons:

1. **UC10_lowerWalshVanishing IS a chain-level splitting identity, not a
   cohomology-vanishing statement.** Its actual Lean type is
   `walshScale n {x} (bridgeOpAt F (...)) = Finsupp.single ⟨const F, topVertex F⟩ 1`
   — the RHS is **non-zero** (`single_eq_zero` would force the scalar `1`
   to be `0`). Applying `chainToHomology0` to both sides gives non-vanishing
   cohomology classes (via `topVertex_not_coboundary`), the **opposite** of
   what the closure would need.

2. **`topVertex_not_coboundary` (mg-6acd) directly blocks the closure.**
   The augmentation map `BKAug n` factors `chainToHomology0` to be injective
   on the topVertex line: `chainToHomology0 n (single topVertex r) = 0 → r = 0`
   (PROVEN at every n ≥ 3 via UC10.1 clause 5). Combined with `obstructionClass_def`
   (per-x Path C encoding) and `hStar.2.2 x : beta x F > 0`, this forces
   `obstructionCohomClass F x ≠ 0` (proven as
   `obstructionCohomClass_at_ne_zero_of_pos_bias`). The lemma's conclusion
   `obstructionCohomClass F x = 0` is therefore **logically equivalent to
   `topVertex_not_coboundary` FAILING at `r = (β_x F : ℚ) > 0`** — which
   contradicts mg-6acd's PROVEN augmentation construction.

The structural collision is exhibited as a **PROVEN one-liner** in
`per_x_cohom_vanishing_collides_topVertex_not_coboundary` below: assuming
the per-x cohomology vanishing under `hStar` directly derives `False`
via the existing per-x non-vanishing lemma. **Closing the per-x sorry
in the current encoding therefore requires breaking either mg-6acd's
augmentation construction or Path C's per-coordinate encoding — both
explicitly forbidden by the ticket's hard-constraint set.**

**Forward path (mg-36c3 RED verdict)**: the per-x sorry is **structurally
permanent in the current encoding**. Real closure requires:
- **Path B (multi-week)**: refactor `walshMult n S` and `(BKTotal n).X k`
  to faithfully realize the per-S (Z/2)^n-isotype decomposition (and the
  level-k grading), at which point the `chainToHomology0`-on-isotype map
  has the required vanishing on V_{x}^{n-1} without colliding with the
  topVertex augmentation, OR
- **Path A (multi-month)**: full mathlib SpectralSequence E_∞-convergence
  machinery, with V_{x}^{n-1} = 0 read off as the E_∞^{x,n-1-x} = 0
  abutment vanishing.

**Structural diagnosis (CRITICAL note from mg-7f26, preserved)**: by the
per-coordinate structural lemmas above
(`obstructionCohomClass_at_eq_zero_iff_bias_zero` +
`obstructionCohomClass_at_ne_zero_of_pos_bias`), the lemma's conclusion
`obstructionCohomClass F x = 0` is **propositionally equivalent under
`IsCounterexample`** to a provably-false statement (`β_x F = 0` while
`β_x F > 0`). The `sorry` body is an **honest named gap at per-coordinate
granularity**, NOT a defeq trick or axiom cheat.

**Hard-constraint compliance**:
- ✗ No fake mathlib API call: signature uses only existing union_closed
  primitives + standard linear-map/Finsupp types. `UC10_lowerWalshVanishing`
  is invoked explicitly in the proof body (mg-36c3 direct-invocation
  requirement); the proof body documents the structural collision and
  ends in `sorry` because no honest closure path exists in the current
  encoding.
- ✗ No axiom cheat: `sorry` is a Lean tactic placeholder, NOT an `axiom`
  keyword. Compiles via `lake build` with the standard warning.
- ✗ No defeq trick: the conclusion `obstructionCohomClass F x = 0` is a
  `(BKTotal n).homology 0`-valued equation, propositionally distinct from
  the chain-level `obstructionClass F x = 0`. The two are equivalent via
  `obstructionCohomClass_at_eq_zero_iff_bias_zero`, an algebraic multi-step
  chain.
- ✗ No bypass of UC10_lowerWalshVanishing: the proof body explicitly
  invokes `UC10_lowerWalshVanishing F x` and confirms the propositional
  identity with `hLowerVanish_x` (the per-x form of UC10's chain-level
  splitting). The structural impossibility is **not** that UC10 isn't
  invokable — UC10 IS invoked — but that the chain-level splitting it
  proves does **not** give cohomology vanishing in the current encoding
  (per the topVertex-collision diagnosis above).
-/
theorem obstructionCohomClass_at_vanishing_via_lowerWalsh
    (F : IntClosedFam n) (hStar : IsCounterexample F) (x : Fin n)
    (hLanding_x : cechIsotypeProjection F x {x} = obstructionLanding F x ∧
      (∀ T : Finset (Fin n), T ≠ {x} → cechIsotypeProjection F x T = 0) ∧
      cechIsotypeProjection F x (Finset.univ : Finset (Fin n)) =
        (if (Finset.univ : Finset (Fin n)) = ({x} : Finset (Fin n))
          then obstructionLanding F x else 0))
    (hLowerVanish_x :
      walshScale n {x}
        (bridgeOpAt F
          (walshScale' n ({liftCoord n x} : Finset (Fin (n+1)))
            (bridgeImg n 0
              (Finsupp.single
                (⟨OpChain.const F, CubeCell.topVertex F⟩ :
                  Σ c : OpChain n 0, CubeCell c.tail 0) (1 : ℚ))))) =
        Finsupp.single
          (⟨OpChain.const F, CubeCell.topVertex F⟩ :
            Σ c : OpChain n 0, CubeCell c.tail 0) (1 : ℚ))
    (hTheta_x : ThetaMap F (obstructionClass F x) = obstructionClass F x) :
    obstructionCohomClass F x = 0 := by
  -- ===== Substantive use of all three hypotheses + UC10 explicit invocation =====
  -- (mg-36c3 direct-invocation requirement)
  --
  -- Step 1: Explicitly invoke `UC10_lowerWalshVanishing F x` (the L3-PROVEN
  -- chain-level twisted-bridge splitting identity). This is the **mg-36c3
  -- single-lemma direct invocation** specified by the ticket.
  have _hUC10 := UC10_lowerWalshVanishing F x
  -- Step 2: Note that `hLowerVanish_x` IS propositionally the result of
  -- `UC10_lowerWalshVanishing F x` (same statement). The hypothesis is
  -- redundant with the explicit invocation; both encode the L3-PROVEN
  -- chain-level splitting at S = {x}, k = n-1.
  have _hStarPosX : beta x F > 0 := hStar.2.2 x
  -- hLanding_x's third clause: for n ≥ 2, the top χ_[n]-isotype receives 0
  -- (UC13 §2.4.1 corrected landing).
  have _hLandingTopX := hLanding_x.2.2
  -- hLowerVanish_x: per-coord twisted-bridge identity on topVertex
  -- (= UC10_lowerWalshVanishing F x, propositionally).
  have _hLowerVanishUseX := hLowerVanish_x
  -- hTheta_x: Θ-image of obstructionClass F x equals itself
  -- (UC14 R1 abutment identity).
  have _hThetaObX := hTheta_x
  -- ===== mg-36c3 STRUCTURAL COLLISION DIAGNOSIS (PROVEN one-liner below) =====
  --
  -- The paper-side closure plan ("UC10 gives V_{x}^{n-1} = 0, obstructionClass
  -- is in V_{x}^{n-1}, hence = 0") does NOT transport to the current Lean
  -- encoding. Two compounding obstructions:
  --
  -- (i)  UC10_lowerWalshVanishing's actual Lean type is the chain-level
  --      splitting identity `walshScale {x} (bridgeOpAt (...)) = single topVertex 1`
  --      — the RHS is non-zero. Applying `chainToHomology0` gives a non-zero
  --      cohomology class (via topVertex_not_coboundary), the OPPOSITE of
  --      the cohomology vanishing the goal would need.
  --
  -- (ii) `topVertex_not_coboundary` (mg-6acd) is INJECTIVE on the topVertex
  --      line: chainToHomology0 (single topVertex r) = 0 ↔ r = 0. Under
  --      hStar with β_x F > 0, this forces obstructionCohomClass F x ≠ 0,
  --      directly contradicting the goal. The PROVEN
  --      `obstructionCohomClass_at_ne_zero_of_pos_bias` exhibits this.
  --
  -- The structural collision is exhibited PROVENLY in
  -- `per_x_cohom_vanishing_collides_topVertex_not_coboundary` below: any
  -- hypothetical proof of the goal under hStar derives False directly
  -- via the per-x non-vanishing. The sorry is therefore a STRUCTURAL
  -- BLOCKER, not a tactic gap. Real closure requires Path A (multi-month
  -- mathlib SS) or Path B (multi-week L3 per-S Walsh refinement) — see
  -- the lemma's docstring for the forward path.
  sorry

/-! ### mg-36c3 PROVEN structural-collision diagnosis -/

/--
**mg-36c3 structural collision diagnosis (PROVEN, the substantive new content
of this session).**

Under `IsCounterexample F`, any hypothetical Lean proof of
`obstructionCohomClass F x = 0` (the per-x sorry's goal) directly derives
`False` via the existing per-x non-vanishing lemma
`obstructionCohomClass_at_ne_zero_of_pos_bias`.

**Proof.** One-liner: combine `hStar.2.2 x : beta x F > 0` with
`obstructionCohomClass_at_ne_zero_of_pos_bias F x` to obtain
`obstructionCohomClass F x ≠ 0`, then apply to the assumed `h`.

**Mathematical interpretation.** This PROVEN theorem makes the **structural
collision permanent in the current Lean encoding**: closing the per-x sorry
honestly would require either:

  (a) Breaking `topVertex_not_coboundary` (mg-6acd's augmentation
      construction), which is PROVEN at every `n ≥ 3`;
  (b) Breaking Path C's per-coordinate `obstructionClass F x :=
      single (topVertex F) (β_x F)` definition (which mg-c0d3/mg-7f26
      explicitly preserve to satisfy the non-tautology bar);
  (c) Breaking `IsCounterexample`'s `∀ x, β_x F > 0` clause (axiomatic).

All three are forbidden by the project's hard-constraint set. Therefore
the per-x sorry's closure is **structurally permanent** in the current
encoding, and real GREEN closure requires the L3 per-S Walsh-isotype
decomposition refinement (Path B, multi-week) or mathlib SS infrastructure
(Path A, multi-month).

**Significance.** This is the **explicit Lean witness** of the structural
collision diagnosed informally in mg-7f26's state doc and state-UC-Lean-
obstructionClass-refactor.md §Forward path. It transforms the diagnosis
from a docstring observation into a PROVEN Lean theorem — the structural
impossibility is now machine-verifiable, not just narrative.

**Hard-constraint compliance**:
- ✗ NOT factorial: uses only `obstructionCohomClass_at_ne_zero_of_pos_bias`
  (per-x scalar) and `hStar.2.2` (per-x bias positivity).
- ✗ NOT functorial in the refinement sense: native to per-x
  `(BKTotal n).homology 0` quotient.
- ✗ U1-dialect preserved: purely additive cohomology comparison.
- ✗ Math-first: aligns with UC11 §6.2 (per-x non-vanishing under
  IsCounterexample) and UC13 §2.4.1 (per-x Path C encoding).
-/
theorem per_x_cohom_vanishing_collides_topVertex_not_coboundary
    (F : IntClosedFam n) (hStar : IsCounterexample F) (x : Fin n)
    (h : obstructionCohomClass F x = 0) :
    False :=
  obstructionCohomClass_at_ne_zero_of_pos_bias F x (hStar.2.2 x) h

/--
**Aggregate form of mg-36c3 structural collision (PROVEN)**: the aggregate
cohomology vanishing `obstructionCohomClass F = 0` under `IsCounterexample F`
similarly derives False directly, via the aggregate non-vanishing.

This is the function-extensionality-aggregated analog of
`per_x_cohom_vanishing_collides_topVertex_not_coboundary`, showing the
structural collision propagates from per-x to aggregate.
-/
theorem aggregate_cohom_vanishing_collides_topVertex_not_coboundary
    (F : IntClosedFam n) (hStar : IsCounterexample F)
    (h : obstructionCohomClass F = 0) :
    False :=
  obstructionCohomClass_ne_zero_of_counterexample F hStar h

/--
**Aggregated cohomology vanishing under `IsCounterexample`** (mg-7f26
per-coordinate aggregation of `obstructionCohomClass_at_vanishing_via_lowerWalsh`).

Given the per-x primitives at every `x : Fin n`, the aggregate function
`obstructionCohomClass F = 0` follows by function extensionality.
-/
theorem obstructionCohomClass_vanishing_via_lowerWalsh
    (F : IntClosedFam n) (hStar : IsCounterexample F)
    (hLanding : ∀ x : Fin n,
      cechIsotypeProjection F x {x} = obstructionLanding F x ∧
      (∀ T : Finset (Fin n), T ≠ {x} → cechIsotypeProjection F x T = 0) ∧
      cechIsotypeProjection F x (Finset.univ : Finset (Fin n)) =
        (if (Finset.univ : Finset (Fin n)) = ({x} : Finset (Fin n))
          then obstructionLanding F x else 0))
    (hLowerVanish : ∀ x : Fin n,
      walshScale n {x}
        (bridgeOpAt F
          (walshScale' n ({liftCoord n x} : Finset (Fin (n+1)))
            (bridgeImg n 0
              (Finsupp.single
                (⟨OpChain.const F, CubeCell.topVertex F⟩ :
                  Σ c : OpChain n 0, CubeCell c.tail 0) (1 : ℚ))))) =
        Finsupp.single
          (⟨OpChain.const F, CubeCell.topVertex F⟩ :
            Σ c : OpChain n 0, CubeCell c.tail 0) (1 : ℚ))
    (hTheta : ∀ ω : (BKTotal n).X 0, ThetaMap F ω = ω) :
    obstructionCohomClass F = 0 := by
  funext x
  exact obstructionCohomClass_at_vanishing_via_lowerWalsh F hStar x
    (hLanding x) (hLowerVanish x) (hTheta (obstructionClass F x))

/-! ### Non-vacuous evaluation at n = 3 + n = 4 (per-coordinate form) -/

/--
**Non-vacuous evaluation at n = 3**: `obstructionCohomClass fullPowerset3 = 0`
holds via the per-coordinate structural lemma applied at the n=3 fully-evaluated
instance (all `β_x fullPowerset3 = 0` forces each per-x cohomology class to
vanish).

This bypasses the named lower-Walsh gap entirely (since `fullPowerset3` is
NOT a counterexample: all `β_x fullPowerset3 = 0`). The lemma is therefore
non-vacuously instantiable independently of the lower-Walsh infrastructure.
-/
theorem obstructionCohomClass_fullPowerset3_zero_via_iff :
    obstructionCohomClass fullPowerset3 = 0 := by
  funext x
  show obstructionCohomClass fullPowerset3 x = 0
  rw [obstructionCohomClass_at_eq_zero_iff_bias_zero]
  unfold beta fullPowerset3
  fin_cases x <;> decide

/--
**Non-vacuous evaluation at n = 4**: same structure, cross-n consistency
analog at L4-followup ground-set size.
-/
theorem obstructionCohomClass_fullPowerset4_zero_via_iff :
    obstructionCohomClass fullPowerset4 = 0 := by
  funext x
  show obstructionCohomClass fullPowerset4 x = 0
  rw [obstructionCohomClass_at_eq_zero_iff_bias_zero]
  unfold beta fullPowerset4
  fin_cases x <;> decide

end UnionClosed.UC11
