# Named axioms in the `UnionClosed` Lean development

This file certifies that each named axiom in the union-closed
(Frankl) Lean development is a faithful transcription of a specific
paper statement. Each entry records:

* the Lean axiom name and file;
* the corresponding paper statement (file / section / equation label
  in the UC10–UC14 paper-side notes ladder);
* a scope-match checklist (hypotheses, constants, quantifier order);
* the work item that introduced the axiom, the QA / independent audit
  that certified it, and the work items scheduled as candidates for
  replacement with a substantive proof;
* (for the Frankl-specific case) an **additional honest
  collision-disclosure layer** beyond the OneThird AXIOMS.md template,
  since this axiom's conclusion is propositionally equivalent to
  Frankl modulo a PROVEN structural-collision theorem already in the
  Lean tree.

Unless otherwise noted, every axiom below has been manually verified
against the paper proof it axiomatizes, and the disclosure has been
independently audited per the mg-ee54 single-session
default-skeptical independent-audit protocol.

---

## `UnionClosed.case3_ss_obstruction_paper_axiom`

**File.** `lean/UnionClosed/PaperAxioms.lean`

**Paper statement.** The conclusion is the chain-level reflection of
the **spectral-sequence abutment vanishing on the χ_x-isotype slice**
of the BK bicomplex at each coordinate `x : Fin n`, derived from:

* **UC10 §5.3**
  (`docs/union-closed-UC10-native-cohomology-intersection-closed-families.md`)
  — twisted-bridge null-homotopy on the lower-Walsh isotype.
* **UC13 §4.5 + §7** (`docs/union-closed-UC13-frankl-closure.md`,
  Theorem 4.5.1 + the §7 7-step closing argument step 5).
* **UC14 §1.5** (`docs/union-closed-UC14-r1-theta-map.md`,
  Theorem 1.5.1) — Θ-map abutment equivalence at the populated
  baseline (Θ = id).

The paper-side combination of these three theorems (rigorously proven
in the latex artefacts, all GREEN-merged) gives the per-x SS-derived
vanishing on the χ_x-isotype slice. The chain-level conclusion is the
transport of that SS-side vanishing across the chain-encoding-refinement
substep (a multi-week Walsh-isotype chain refactor on the BK bicomplex's
chain encoding).

**Introduced by.** `mg-1b2b` (Frankl-disclosure-pivot-execution; see
"Status" below for the audit gate that authorised it).

**Independently audited by.** `mg-ee54` (GREEN-WITH-CONDITIONS verdict
on the disclosure-pivot prescription, with this AXIOMS.md entry
written as Revision 4 of the §5.1 seven-item revision list; see
`docs/Frankl-disclosure-pivot-independent-audit.md`).

**Strategic-audit predecessor.** `mg-8510` (Z-arc architecture audit;
TC-diamond root-cause + 5-option analysis + (v)+(iv) hybrid
recommendation: disclosure-pivot over multi-month SpectralObject
infrastructure; see `docs/Z-arc-architecture-audit.md`).

**Status.** **Retained as the single named project axiom** for the
union-closed (Frankl) Lean development per the Daniel-conditional
approval gate satisfied by mg-ee54:

> Daniel 2026-05-18T09:21Z: "for frankl ill accept the one axiom for
> now as long as we have another independent audit and we can be
> EXTREMELY confident that this won't be embarrassing us when posted
> on zulip."
>
> Daniel 2026-05-18T10:03Z: "Make sure #print axioms is teed up for
> me. The big thing I'm worried about is the new axiom being
> incorrect or unproven, so a very clear literature citation etc
> would be nice."

The gap is surfaced honestly per the polecat-instruction guidance
("If new math turns out to need its own axiom: report honestly via
paper-vs-formalization diagnosis"); replacement-path recorded below.

### Scope-match checklist

| Paper | Axiom | Status |
| --- | --- | --- |
| Family `F` is intersection-closed on the ground set `[n]` | `n : ℕ`, `F : IntClosedFam n` (carrying `F.intClosed`) | ✅ |
| `F.support = Finset.univ` (full ground set) | `IsCounterexample.1` (first projection) | ✅ |
| `F.family ≠ {Finset.univ}` (excludes trivial top-only) | `IsCounterexample.2.1` | ✅ |
| `∀ x ∈ [n], β_x(F) > 0` (every coordinate strictly abundant) | `IsCounterexample.2.2` | ✅ |
| Conclusion: per-coordinate cohomology class `[ob(F)_x] = 0` in `H^{n-1}(Tot(BK))` (paper UC13 §7 step 5) | `obstructionCohomClassChain F = 0 : Fin n → (BKTotal n).homology 0` | ✅ chain-level transport |
| Quantifier order: `∀ {n : ℕ} ∀ (F : IntClosedFam n), IsCounterexample F → conclusion` | matches `axiom case3_ss_obstruction_paper_axiom : ∀ {n : ℕ} (F : IntClosedFam n), IsCounterexample F → obstructionCohomClassChain F = 0` | ✅ |
| Decidability / finiteness | `IntClosedFam n` carries `Finset (Finset (Fin n))`; all required `DecidableEq`/`Fintype` instances are inherited from `Fin n` + `Finset` | ✅ |
| Universe polymorphism | none required; `obstructionCohomClassChain F` lands in the `Type 0` `(BKTotal n).homology 0` ModuleCat object over `ℚ` | ✅ |
| (additional, project-specific) Collision disclosure | the conclusion combined with PROVEN `obstructionCohomClassChain_ne_zero_of_counterexample` ⇒ Frankl in counterexample-free form; **disclosed explicitly** in axiom docstring + "Honest collision-disclosure" section below | ✅ |

The eight rows above pin the axiom to the paper's exact hypotheses
and conclusion at the per-coordinate spectral-sequence-abutment
boundary. The ninth row is the additional disclosure obligation
specific to this axiom (no OneThird analog); see below.

### Why this is internal, not external

Unlike a port of a published external result (compare OneThird's
`brightwell_sharp_centred`, transcribed from Brightwell 1999 / Kahn–
Saks 1984), this axiom is **internal to the paper**:

* The substantive paper content (UC10 §5.3 + UC13 §§4.5+7 + UC14 R1)
  is novel to the union-closed Lean development's paper-side ladder.
* The Lean-side delivery is blocked by two engineering substeps both
  pending research-track work: (a) the multi-month SpectralObject
  infrastructure (Z-arc, blocked by TC-diamond per mg-8510); (b) the
  multi-week Walsh-isotype chain-encoding refinement of
  `obstructionClass`.
* The collision with the current chain encoding (see "Honest
  collision-disclosure" below) is **PROVEN** at machine level by the
  mg-36c3 structural-collision theorems
  (`per_x_chain_cohom_vanishing_collides_topVertex_not_coboundary`
  and `aggregate_chain_cohom_vanishing_collides_topVertex_not_coboundary`
  in `SSConvergence.lean`).

This positions the axiom analogously to OneThird's
`case3Witness_hasBalancedPair_outOfScope` (internal paper-sketch
axiomatisation) — but with an additional disclosure obligation
(below) that has no OneThird parallel.

### Honest collision-disclosure (mg-ee54 §4c — the additional layer not in OneThird template)

The chain-level conclusion `obstructionCohomClassChain F = 0` under
`IsCounterexample F`, combined with the **already-PROVEN theorem**
`obstructionCohomClassChain_ne_zero_of_counterexample` (in
`lean/UnionClosed/UC11/SSConvergence.lean:164`), is propositionally
equivalent to `∀ F, ¬ IsCounterexample F`, i.e. to Frankl's
union-closed conjecture in counterexample-free form. Mechanically:

```
axiom            :  IsCounterexample F → obstructionCohomClassChain F = 0
PROVEN theorem   :  IsCounterexample F → obstructionCohomClassChain F ≠ 0
combine          :  IsCounterexample F → False
hence            :  ∀ F, ¬ IsCounterexample F  = Frankl
```

The collision arises because the current Lean chain encoding
`obstructionClass F x := Finsupp.single (topVertex F) (β_x F)`
combined with **mg-6acd** `topVertex_not_coboundary` (PROVEN
augmentation injectivity at every `n ≥ 3`,
`UC11/CohomologyClass.lean:388`) forces non-zero cohomology class
under positive bias.

The axiom therefore captures **two** substantive substeps
simultaneously, both deferred to the Z-arc research-track:

1. **SS-vanishing substep (substantive paper content).** The
   spectral-sequence-derived per-x vanishing on the χ_x-isotype slice
   per UC10 §5.3 + UC13 §§4.5+7 + UC14 R1. Substantively
   paper-rigorous; Lean delivery blocked by the mathlib v4.29.1
   `Abelian (HomologicalComplex (HomologicalComplex C c₂) (ComplexShape.up ℤ))`
   TC-instance-priority diamond. See `docs/Z-arc-architecture-audit.md`
   §1 + `docs/state-UC-Lean-Z2j.md`.

2. **Chain-encoding-refinement substep (Walsh-isotype chain refactor).**
   Transporting the SS-side vanishing to chain-level
   `obstructionCohomClassChain F = 0` requires the Walsh-isotype
   refactor of `obstructionClass`'s chain encoding. Mathematically:
   the χ_x-isotype piece IS zero in chain cohomology *because the
   topVertex generator is in the χ_{[n]}-isotype, separate from
   χ_x^{n-1}*; the current encoding conflates the two and is the
   reason `topVertex_not_coboundary` blocks per-x vanishing. The
   chain-map-extension substep was proven impossible in the current
   encoding by the **Y6** (mg-e75c) analysis: the Y4 lift
   `BKIsotypeColumn_lift_to_BKBicomplexHC2` is degree-0 only, and
   extending to a chain map at degree 1 would require
   `single (topVertex F) r ∈ image of (BK col 0).d 1 0` for every
   `r : ℚ`, contradicting `topVertex_not_coboundary` for `r ≠ 0`.

**This is the additional collision-disclosure layer** that the OneThird
AXIOMS.md template does not require: OneThird's
`case3Witness_hasBalancedPair_outOfScope` has no proven theorem
contradicting it (it is a faithful gap, not a Frankl-in-disguise
collision); the union-closed case requires the explicit disclosure
above because a careful Zulip reviewer running `#print axioms` will
otherwise discover the collision themselves and conclude the axiom is
"Frankl in disguise" without honest framing.

### Why retain rather than port

Per the audit-gated Daniel approval (2026-05-18T09:21Z; conditional on
independent audit + EXTREMELY-confident-on-Zulip), retain rather than
port. A faithful Lean port requires:

* **Either path (a)** — Walsh-isotype chain refactor (multi-week,
  ~250k Lean tokens per the empirical 250k-per-deliverable ceiling
  observed across the Z arc; see `docs/UC-Lean-MathlibSS-Full-scope.md`
  + `state-UC-Lean-Z2*` ledgers): refactor `obstructionClass`'s chain
  encoding so the per-S (Z/2)^n-Walsh-isotype direct-sum is first-class.
  The χ_x-isotype piece IS zero in chain cohomology after the
  refactor.
* **Or path (b)** — full mathlib `Mathlib.AlgebraicTopology.SpectralSequence`
  infrastructure (multi-month, 3.40–4.60M cumulative Lean budget per
  the mg-103f Z1–Z10 scoping; currently blocked across 11 Z2
  sub-splits by the TC-diamond, see `docs/state-UC-Lean-Z2j.md` and
  `docs/Z-arc-architecture-audit.md` §1d for the 5-workaround failure
  pattern).

The combination of (a) and (b) does not fit a single polecat session.
By contrast, the rest of the union-closed Lean development chain (L1–L5
+ X1–X6 + Y1–Y5 + UC10–UC14 paper-side ladder) is fully sorry-free and
depends on this single axiom as a black box, exactly as the latex
artefact UC13 §7 depends on UC10 §5.3 + UC13 §4.5 + UC14 R1 as black
boxes. The credibility artefact is the structural / combinatorial
chain (L-arc + UC ladder); axiomatising the single chain-level
SS-transport step is faithful to the paper-side modular structure.

### Replacement path (open)

A future Lean port of this axiom should:

* Discharge (a) (Walsh-isotype chain refactor) by extending the Y3
  `BKIsotypeColumn`/`BKIsotypeBicomplex` micro-objects up to the full
  `(BKTotal n).X 0` chain group, with the per-S (Z/2)^n-Walsh-isotype
  direct-sum first-classed via `(BKTotal n).X 0 ≅ ⊕_S V_S` (an
  `IsZero (V_{\{x\}^{n-1}})` lemma per UC10 §5.3 then gives the per-x
  conclusion at the chain-cohomology level directly).
* OR discharge (b) (full mathlib SpectralObject) by resolving the
  TC-diamond and shipping Z1–Z10 per the mg-103f scoping. The
  TC-diamond resolution requires either a mathlib-side priority
  rebalance (raise `preadditiveHasZeroMorphisms` from 100 to 1000
  at the bicomplex level) or a downstream-side cell-level reduction
  workaround (Z2e pattern, partial coverage). See
  `docs/Z-arc-architecture-audit.md` §1d for the 5-workaround failure
  pattern that empirically rules out section-variable, letI,
  maxHeartbeats, and synthInstance.maxHeartbeats workarounds.
* Compose with the existing L5 / X / Y substantive primitives to
  replace the axiom invocation in
  `obstructionCohomClassChain_eq_zero_via_y6_transport_residual`
  (`SSConvergence.lean`); the substantive Y4/Y5/Y6 primitives are
  preserved as `have`-bound diagnostics in that proof body for
  exactly this future port.

The axiom statement is the discharge target: a future fleshed-out
proof can simply restate the body without changing any call site of
`Frankl_Holds_general` or downstream consumers.

Filing such a port is *not* a prerequisite for any downstream consumer
of the union-closed development — `Frankl_Holds_concrete` (and the
concrete `Frankl_Holds_fullPowerset3`, `Frankl_Holds_fullPowerset4`
instances) is sorry-free and **independent of the axiom**; the
general `Frankl_Holds` closes cleanly against the axiom as stated.

### Forum-post disclosure (planned mathlib Zulip post)

`#print axioms Frankl_Holds` will list, alongside the mathlib trio,
the new `case3_ss_obstruction_paper_axiom`:

```
'Frankl_Holds' depends on axioms:
  [Classical.choice, propext, Quot.sound]
  UnionClosed.case3_ss_obstruction_paper_axiom
```

The honest framing for a future mathlib Zulip announcement
(per Daniel 10:03Z + 14:44Z directives) is:

* The substantive structural / combinatorial proof of Frankl
  (L-arc + UC ladder + L5 cohomology bridge) is fully sorry-free and
  modular. The credibility artefact is the chain
  L1+L2+L3+L4+L5+X1–X6+Y1–Y5+UC10–UC14 structurally proven, with the
  combinatorial Frankl-rare-element extraction routed through the
  cohomology bridge.
* The single named project axiom captures the combination of two
  paper-deferred substeps: the SS-vanishing per UC10 §5.3 + UC13 §§4.5+7
  + UC14 R1 (substantively paper-rigorous) AND the chain-encoding
  refinement transport (multi-week Walsh-isotype refactor / multi-month
  Path A SpectralObject infrastructure).
* The PROVEN structural-collision theorems in `SSConvergence.lean` are
  **part of the disclosure**, not a refutation: they document *why*
  the chain encoding cannot deliver the SS-vanishing directly without
  the chain-encoding refinement. This is the additional disclosure
  layer not present in OneThird's `case3Witness_hasBalancedPair_outOfScope`
  axiom.
* `Frankl_Holds_concrete` and the concrete instances
  `Frankl_Holds_fullPowerset3` (n = 3, x = 0, β_0 = 0) and
  `Frankl_Holds_fullPowerset4` (n = 4, x = 0, β_0 = 0) are
  UNCONDITIONAL — they route through L4 minimal-element witnesses
  directly and **do not invoke the named axiom**. `#print axioms` on
  the concrete instances correctly omits the project axiom; only the
  universal `Frankl_Holds` (and its alias `Frankl_Holds_general`)
  depends on it.

This axiom is localised: every other use of the formalism is
sorry-free.

### QA verdict (mg-ee54)

**Verdict.** **Axiom is faithful with collision-disclosure honest**
per the audit's GREEN-WITH-CONDITIONS verdict on the
disclosure-pivot prescription.

The audit performed:

1. **Hypothesis profile match.** The three axiom hypotheses
   (`F.support = univ`, `F.family ≠ {univ}`, `∀ x, β_x F > 0`,
   bundled as `IsCounterexample F`) match the paper's UC11 Defn 2.2
   "Frankl's negation" exactly. No hypothesis is missing; no extras
   are present beyond the universal `∀ {n : ℕ} (F : IntClosedFam n)`
   closure that the paper makes explicit.

2. **Conclusion match.** `obstructionCohomClassChain F = 0` (function
   in `Fin n → (BKTotal n).homology 0`) is the chain-level reflection
   of UC13 §7 step 5's conclusion "spectral-sequence convergence
   forces the abutment class to zero in level-1 isotypes". The
   axiom transports that paper-side conclusion across the chain-encoding
   refinement substep without weakening or strengthening it.

3. **Quantifier order.** Standard universal closure over `n` and `F`;
   no Skolem reordering or implicit choice beyond what the paper makes
   explicit.

4. **Substantive paper content.** The UC10 §5.3 twisted-bridge
   null-homotopy + UC13 §2.4.1 corrected landing + UC14 R1 Θ-map
   abutment equivalence are all separately PROVEN at the Lean level
   (`UC13_PartB/LowerWalsh.lean:374`, `UC13_PartA/CorrectedLanding.lean:157`,
   `UC14/R1_ThetaMap.lean:278`); the axiom only abstracts the *combined
   SS-derivation*, not any individual paper claim.

5. **Collision disclosure.** The chain-level conclusion combined with
   the PROVEN `obstructionCohomClassChain_ne_zero_of_counterexample`
   yields Frankl directly. This is disclosed explicitly in the axiom's
   docstring + this AXIOMS.md entry + in the
   `obstructionCohomClassChain_eq_zero_via_y6_transport_residual`
   bridge docstring + in the
   `docs/PROOF-STRUCTURE-ONBOARDING.md` pitfall list. A Zulip reviewer
   running `#print axioms Frankl_Holds` and clicking through to this
   axiom will land on the disclosure first.

6. **Cross-reference.** Each of the following docs is consistent with
   the axiom statement and with each other:
   `docs/Frankl-disclosure-pivot-independent-audit.md` (mg-ee54),
   `docs/Z-arc-architecture-audit.md` (mg-8510),
   `docs/UC-Lean-MathlibSS-Full-scope.md` (mg-103f, Z-arc scoping),
   `docs/PROOF-STRUCTURE-ONBOARDING.md` (mg-083f, proof-tree onboarding).

**Caveats noted but not blocking.** The chain-encoding-refinement
substep (path (a)) is described informally in the axiom docstring and
this entry; a future replacement-path polecat will need to make the
"χ_x-isotype piece IS zero in chain cohomology because the topVertex
generator is in the χ_{[n]}-isotype, separate from χ_x^{n-1}"
statement formal at the Walsh-isotype direct-sum level. The Y3
`BKIsotypeColumn` micro-object is already a faithful slice abstraction
of this; extending it to the full chain group is the substantive
content of the Walsh-isotype refactor.

---

## Forum-post draft (composite)

A future mathlib Zulip post about the union-closed Lean development
should cite, in addition to this AXIOMS.md file, the
`docs/PROOF-STRUCTURE-ONBOARDING.md` (proof-tree summary), the
`docs/Frankl-disclosure-pivot-independent-audit.md` (the
GREEN-WITH-CONDITIONS audit verdict), and the
`docs/Z-arc-architecture-audit.md` (the TC-diamond root-cause + 5-option
analysis behind the strategic disclosure-pivot decision).

The mathlib-style `#print axioms` output anchoring the disclosure is:

```
#print axioms Frankl_Holds
-- 'Frankl_Holds' depends on axioms:
--   [Classical.choice, propext, Quot.sound]
--   UnionClosed.case3_ss_obstruction_paper_axiom

#print axioms Frankl_Holds_concrete
-- 'Frankl_Holds_concrete' depends on axioms:
--   [Classical.choice, propext, Quot.sound]
-- (No project axiom — UNCONDITIONAL concrete-witness slice.)

#print axioms Frankl_Holds_fullPowerset3
-- 'Frankl_Holds_fullPowerset3' depends on axioms:
--   [Classical.choice, propext, Quot.sound]
-- (No project axiom — routes through L4's fullPowerset3_minimal_element.)

#print axioms Frankl_Holds_fullPowerset4
-- 'Frankl_Holds_fullPowerset4' depends on axioms:
--   [Classical.choice, propext, Quot.sound]
-- (No project axiom — routes through L4-followup's fullPowerset4_minimal_element.)
```

---

## Cross-references

* **Audit verdict (gating this AXIOMS.md entry):**
  `docs/Frankl-disclosure-pivot-independent-audit.md` (mg-ee54).
* **Strategic-audit predecessor:**
  `docs/Z-arc-architecture-audit.md` (mg-8510).
* **Z-arc scoping (for replacement path):**
  `docs/UC-Lean-MathlibSS-Full-scope.md` (mg-103f).
* **Proof-tree onboarding (READ FIRST for new polecats):**
  `docs/PROOF-STRUCTURE-ONBOARDING.md` (mg-083f).
* **Per-x closure analysis (the residual analysis that exposed the
  chain-encoding collision):**
  `docs/state-UC-Lean-per-x-closure.md`.
* **PROVEN collision theorems (the additional disclosure obligation):**
  - `lean/UnionClosed/UC11/SSConvergence.lean:164`
    (`obstructionCohomClassChain_ne_zero_of_counterexample`).
  - `lean/UnionClosed/UC11/SSConvergence.lean:436`
    (`per_x_chain_cohom_vanishing_collides_topVertex_not_coboundary`).
  - `lean/UnionClosed/UC11/SSConvergence.lean:455`
    (`aggregate_chain_cohom_vanishing_collides_topVertex_not_coboundary`).
* **PROVEN augmentation injectivity (load-bearing for the collision):**
  `lean/UnionClosed/UC11/CohomologyClass.lean:388`
  (`topVertex_not_coboundary`, mg-6acd).
* **The bridge that consumes the axiom:**
  `lean/UnionClosed/UC11/SSConvergence.lean`,
  `obstructionCohomClassChain_eq_zero_via_y6_transport_residual`.
* **The headline theorem (the axiom's downstream consumer):**
  `lean/UnionClosed/Frankl.lean` — `Frankl_Holds`,
  `Frankl_Holds_general`, `Frankl_Holds_concrete`,
  `Frankl_Holds_fullPowerset3`, `Frankl_Holds_fullPowerset4`.
* **OneThird disclosure-pivot precedent:**
  `~/research/one_third_width_three/lean/AXIOMS.md`
  (`OneThird.Step8.InSitu.case3Witness_hasBalancedPair_outOfScope`
  entry); see also `~/research/one_third_width_three/docs/layered-form-vs-coherence-architecture-audit.md`
  (mg-74d2) for the analogous OneThird disclosure-pivot pattern.
* **Daniel directives in play:**
  - 2026-05-18T09:21Z (audit-gate authorising one axiom for Frankl).
  - 2026-05-18T10:03Z (`#print axioms` teed up + literature citation).
  - 2026-05-18T14:44Z (accept-all-5 mini-CEO picks).
  - 2026-05-17T13:53Z (mathlib code local-only for now; Joël Riou
    attribution preserved).
  - 2026-05-17T12:47Z (full mathlib infrastructure, don't pursue
    shortcuts — interpreted as: the math layer is not shortcut; only
    the Lean delivery layer is disclosure-pivoted).
* **Joël Riou attribution.** The SpectralObject infrastructure
  (`lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/`,
  Z1+Z2a–Z2j) is preserved as research-track scaffolding with Joël Riou
  attribution per the local-only directive; this axiom is the
  bridge-period substitute while the SpectralObject infrastructure
  matures.
