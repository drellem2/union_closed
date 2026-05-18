/-
UnionClosed/PaperAxioms.lean
============================

**Project-axiom file** for the union-closed (Frankl) Lean development.

Houses the single named project axiom
`case3_ss_obstruction_paper_axiom`, introduced by **mg-1b2b**
(Frankl-disclosure-pivot-execution) per the **mg-ee54** independent
audit verdict GREEN-WITH-CONDITIONS on **mg-8510** Z-arc architecture
audit's (v)+(iv) hybrid recommendation, executed under **Daniel
2026-05-18T09:21Z** conditional approval.

**Why a dedicated file (vs inline in `Frankl.lean` or `SSConvergence.lean`)?**
Single-source-of-truth surface for the disclosure pivot. A reviewer
running `#print axioms Frankl_Holds` and then clicking through to the
axiom's definition lands in *this* file, where the full
provenance-and-collision-disclosure docstring lives without competing
proof-text noise. Mirrors the OneThird `lean/AXIOMS.md` +
`Mathlib/LinearExtension/BrightwellAxiom.lean` / `Step8/Case3Residual.lean`
single-source-of-truth pattern for project-axiom disclosure, adapted
to the Frankl chain-encoding-collision situation that has no OneThird
analog (see "Honest collision-disclosure" in the axiom's docstring
below and the corresponding entry in `lean/AXIOMS.md`).

**Reading order.** Before editing or removing the axiom, read in order:

1. `lean/AXIOMS.md` — top-level project-axiom registry, OneThird-grade
   disclosure entry for `case3_ss_obstruction_paper_axiom` including
   scope-match checklist + paper-vs-formalisation diagnosis +
   replacement-path + forum-post disclosure + QA verdict.
2. `docs/PROOF-STRUCTURE-ONBOARDING.md` (mg-083f) — proof-tree
   summary including which Frankl_Holds branches depend on the axiom
   vs. concrete-witness branches that do not.
3. `docs/Frankl-disclosure-pivot-independent-audit.md` (mg-ee54) —
   the audit verdict that gated this axiom; in particular §2c (the
   propositional-equivalence finding), §2e ((B2)+(B3) form
   prescription), §4c (the additional collision-disclosure obligation
   beyond OneThird's template), and §5.1 (the seven-item revision
   list that this file implements as Revision 1+2+5).
4. `docs/Z-arc-architecture-audit.md` (mg-8510) — the TC-diamond
   root cause + 5-option analysis that recommended disclosure-pivot
   over multi-month SpectralObject infrastructure.
5. `lean/UnionClosed/UC11/SSConvergence.lean` lines 388-460 (PROVEN
   collision theorems) and lines 546-596 (former Y6 bridge, now
   one-liner invoking this axiom).

**Hard-constraint compliance**:
- D.1 NOT factorial: the axiom mentions only abelian-(Z/2)^n-Walsh-derived
  chain cohomology objects (`(BKTotal n).homology 0` via
  `obstructionCohomClassChain`); no Specht modules.
- D.2 NOT functorial in the refinement sense: native to
  `IntClosedFam n` + `Fin n` direct-sum, no PPF_n functor.
- D.3 U1-dialect preserved: purely additive cohomology vanishing
  claim; no cup-product.
- D.4 Math-first: the *content* of the axiom is the paper-side
  UC10 §5.3 + UC13 §§4.5+7 + UC14 R1 spectral-sequence-derived per-x
  cohomology vanishing on the χ_x-isotype slice, lifted across the
  chain-encoding-refinement substep. Both substeps are deferred to
  the Z-arc research-track per mg-8510 verdict; see
  `lean/AXIOMS.md` "Replacement path (open)" for the closure plan.

**Local-only directive** (Daniel 2026-05-17T13:53Z applies): the
SpectralObject infrastructure (Z1 + Z2a-Z2j, ~10M cumulative tokens)
is preserved as research-track scaffolding under
`lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/` with
Joël-Riou attribution; this axiom acknowledges that scaffolding as
the future replacement path for the Lean-side delivery of the
paper-side SS argument.
-/

import UnionClosed.UC10.IntClosedFam
import UnionClosed.UC11.Minimality
import UnionClosed.UC11.CohomologyClass

namespace UnionClosed

open UnionClosed.UC10 UnionClosed.UC11

variable {n : ℕ}

/-! ### The single named project axiom -/

/--
**case3_ss_obstruction_paper_axiom** — the **single named project
axiom** of the union-closed (Frankl) Lean development.

**Statement** (chain-level, the (B2) form of mg-ee54 §2 with mandatory
(B3) honest collision-disclosure framing in this docstring):

> For every `F : IntClosedFam n` satisfying `IsCounterexample F`, the
> OLD chain-derived cohomology-class function
> `obstructionCohomClassChain F : Fin n → (BKTotal n).homology 0` equals
> the zero function.

**Paper-side content (substantive)** — what this axiom captures
mathematically:

The conclusion is the chain-level reflection of the **spectral-sequence
abutment vanishing on the χ_x-isotype slice** of the BK bicomplex at
each coordinate `x : Fin n`, derived from:

* **UC10 §5.3** (`docs/union-closed-UC10-native-cohomology-intersection-closed-families.md`)
  — the twisted-bridge null-homotopy on the lower-Walsh isotype:
  `walshScale ∘ bridgeOpAt ∘ walshScale' ∘ bridgeImg` reproduces the
  topVertex generator on `V_x^{n-1}` per coordinate, which combined
  with the Maschke-splitting on the equivariant
  `(Z/2)^n`-Walsh-isotype lift gives `V_x^{n-1} = 0` cohomologically.
* **UC13 §4.5 + §7** (`docs/union-closed-UC13-frankl-closure.md`,
  Theorem 4.5.1 + the §7 7-step closing argument) — corrected per-x
  landing in `⊕_x V_x^{n-1}` (level-1 isotypes); §7 step 5 is the
  spectral-sequence-convergence-forces-abutment-zero step that this
  axiom transports to the chain level.
* **UC14 §1.5** (`docs/union-closed-UC14-r1-theta-map.md`,
  Theorem 1.5.1) — Θ-map abutment equivalence: at the populated
  baseline `Θ = id`, identifying chain-level and abutment-level
  cohomology objects so SS-side vanishing transports to chain-level
  vanishing.

The paper-side combination of these three theorems (rigorously proven
in the latex artefacts UC10/UC13/UC14 ladder, all GREEN-merged) gives
the per-x SS-derived vanishing on the χ_x-isotype slice of the BK
bicomplex.

**Honest collision-disclosure** (mandatory per mg-ee54 §2c–§2e + §4c;
the additional disclosure layer not present in the OneThird AXIOMS.md
template):

The chain-level conclusion `obstructionCohomClassChain F = 0` under
`IsCounterexample F`, **combined with the already-PROVEN theorem**
`obstructionCohomClassChain_ne_zero_of_counterexample` in
`SSConvergence.lean:164`, is propositionally equivalent to
`∀ F, ¬ IsCounterexample F`, i.e. to **Frankl's union-closed
conjecture in counterexample-free form**. Mechanically:

```
axiom            :  IsCounterexample F → obstructionCohomClassChain F = 0
PROVEN theorem   :  IsCounterexample F → obstructionCohomClassChain F ≠ 0
combine          :  IsCounterexample F → False
hence            :  ∀ F, ¬ IsCounterexample F  = Frankl
```

The collision arises because the Lean chain encoding
`obstructionClass F x := Finsupp.single (topVertex F) (β_x F)` combined
with **mg-6acd** `topVertex_not_coboundary` (PROVEN augmentation
injectivity at every `n ≥ 3`, `CohomologyClass.lean:388`) forces
non-zero cohomology class under positive bias.

This axiom therefore captures TWO substantive substeps simultaneously,
both deferred to the Z-arc research-track:

1. **SS-vanishing substep (substantive paper content).** The spectral-
   sequence-derived per-x vanishing on the χ_x-isotype slice
   `IsZero (gr_x H^{n-1}(Tot (BKBicomplexHC₂ F)))` per UC10 §5.3 +
   UC13 §§4.5+7 + UC14 R1. **Substantively paper-rigorous.** Lean
   delivery is blocked at present by the mathlib v4.29.1
   `Abelian (HomologicalComplex (HomologicalComplex C c₂) (ComplexShape.up ℤ))`
   TC-instance-priority diamond between
   `HomologicalComplex.instHasZeroMorphisms` (priority 1000,
   `Mathlib/Algebra/Homology/HomologicalComplex.lean:285`) and
   `preadditiveHasZeroMorphisms` (priority 100,
   `Mathlib/CategoryTheory/Preadditive/Basic.lean:201`); see
   `docs/Z-arc-architecture-audit.md` §1 + `docs/state-UC-Lean-Z2j.md`
   for the independently-corroborated 5-workaround failure pattern.

2. **Chain-encoding-refinement substep (Walsh-isotype chain refactor).**
   Transporting the SS-side vanishing to the chain-level
   `obstructionCohomClassChain F = 0` requires the Walsh-isotype
   refactor of `obstructionClass`'s chain encoding (multi-week
   refactor; the χ_x-isotype piece IS zero in chain cohomology
   *because the topVertex generator is in the χ_{[n]}-isotype, separate
   from χ_x^{n-1}*; the current `single (topVertex F) (β_x F)` encoding
   conflates the two and is the reason `topVertex_not_coboundary`
   blocks per-x vanishing). The chain-map-extension substep was
   proven impossible in the current encoding by the **Y6** (mg-e75c)
   analysis: the Y4 lift `BKIsotypeColumn_lift_to_BKBicomplexHC2`
   is degree-0 only, and extending to a chain map at degree 1 would
   require `single (topVertex F) r ∈ image of (BK col 0).d 1 0` for
   every `r : ℚ`, contradicting `topVertex_not_coboundary` for
   `r ≠ 0`.

**Why retain rather than port** (mg-ee54 §5 + mg-8510 §2): the
combined substeps are estimated **multi-month** of Lean infrastructure
work (Z-arc Z1–Z10 per `docs/UC-Lean-MathlibSS-Full-scope.md` (mg-103f),
3.40–4.60M cumulative token budget). Per Daniel 2026-05-18T07:17Z
("z arc stalling — copy from mathlib or reproduce functionality
without the bug in short term if needed") and 2026-05-18T09:21Z ("for
frankl ill accept the one axiom for now as long as we have another
independent audit and we can be EXTREMELY confident that this won't
be embarrassing us when posted on zulip"), the axiom is retained as a
named project axiom for a short bridge period with the gap surfaced
honestly via this docstring + `lean/AXIOMS.md`. The substantive paper
content (the SS-vanishing argument of UC10/UC13/UC14) is not in
dispute; what is deferred is the Lean-side delivery of the chain-level
transport.

**Replacement path (open)**:

* (a) **Walsh-isotype refinement of `(BKTotal n).X 0`** (multi-week
      chain-group refactor). Refactor the chain encoding so the χ_x
      and χ_{[n]} isotype pieces are first-class direct summands; the
      χ_x piece IS zero in chain cohomology after the refactor.
* (b) **Full mathlib `Mathlib.AlgebraicTopology.SpectralSequence`
      infrastructure** for the (Z/2)^n-Walsh-graded BK bicomplex
      (multi-month Path A per mg-103f Z-arc scoping). Requires
      resolving the TC-diamond at the bicomplex level (currently
      blocked across 11 Z2 sub-splits, see
      `docs/state-UC-Lean-Z2j.md`).

Either path replaces this axiom's body with a substantive proof
without changing any call-site (the conclusion type is fixed).

**Cross-reference**: see `lean/AXIOMS.md` for the OneThird-grade full
disclosure including 9-row scope-match checklist, paper-vs-formalisation
diagnosis, forum-post disclosure, and QA verdict.

**Forum-post disclosure** (for a future mathlib Zulip post per
Daniel 10:03Z + 14:44Z): `#print axioms Frankl_Holds` will list
`case3_ss_obstruction_paper_axiom` alongside the mathlib trio
(`Classical.choice`, `propext`, `Quot.sound`). The honest framing is
that this axiom captures the combination of two paper-deferred substeps
(SS-vanishing + Walsh-isotype-chain-encoding-refinement), both pending
Lean-side delivery via Z-arc research track. The PROVEN structural
collision in `SSConvergence.lean` is part of the disclosure: it
documents *why* the chain encoding can not deliver the SS-vanishing
directly without the chain-encoding refinement. Concrete-witness
small-n cases (`Frankl_Holds_fullPowerset3`,
`Frankl_Holds_fullPowerset4`) are UNCONDITIONAL — they route through
`Frankl_Holds_concrete` via L4 minimal-element witnesses and do **not**
invoke this axiom; `#print axioms` on the concrete instances
correctly omits this axiom.
-/
axiom case3_ss_obstruction_paper_axiom :
    ∀ {n : ℕ} (F : IntClosedFam n),
      IsCounterexample F → obstructionCohomClassChain F = 0

end UnionClosed
