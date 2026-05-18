# Frankl disclosure-pivot — independent audit of mg-8510 (v)+(iv) hybrid

**Work item:** `mg-ee54` (independent-audit polecat, single-session, paper-and-pencil, no Lean code changes).

**Trigger (Daniel verbatim, 2026-05-18T09:21Z):**

> "for frankl ill accept the one axiom for now as long as we have
> another independent audit and we can be EXTREMELY confident that
> this won't be embarrassing us when posted on zulip"

**Audit hypothesis under test.** mg-8510's recommendation (`docs/Z-arc-architecture-audit.md`): drop the Z-arc-as-conceived from the headline critical path; restate `Frankl_Holds` with the SS-derived obstruction class as paper-axiomatised (analogue of `case3Witness_hasBalancedPair_outOfScope`); delete the Y6 sorry at `SSConvergence.lean:596` by routing through the paper-axiom; document SpectralObject infrastructure as research-track/deferred.

**Daniel-conditional-approval gate.** This audit gates the execution
ticket (`mg-1b2b`, pre-filed with `depends=mg-ee54`). GREEN-publication-ready
clears `mg-1b2b` to dispatch; GREEN-with-conditions or AMBER requires
revisions; RED requires fundamental revision of mg-8510.

**Predecessors absorbed.**

- `mg-8510` (`docs/Z-arc-architecture-audit.md`) — the recommendation
  being audited.
- `mg-103f` (`docs/UC-Lean-MathlibSS-Full-scope.md`) — Z1–Z10 scoping
  with bars 11–14.
- `mg-74d2` (`one_third/docs/layered-form-vs-coherence-architecture-audit.md`)
  — OneThird disclosure-pivot analog.
- OneThird `lean/AXIOMS.md` — gold-standard project-axiom disclosure
  template (`OneThird.LinearExt.brightwell_sharp_centred` and
  `OneThird.Step8.InSitu.case3Witness_hasBalancedPair_outOfScope`).
- `lean/UnionClosed/UC11/SSConvergence.lean` lines 388–460 — the
  PROVEN mg-36c3 structural-collision theorems (`per_x_chain_cohom_vanishing_collides_topVertex_not_coboundary`,
  `aggregate_chain_cohom_vanishing_collides_topVertex_not_coboundary`)
  about the OLD chain class.
- `lean/UnionClosed/UC11/SSConvergence.lean` lines 546–596 — the Y6
  bridge with its current single live sorry.
- `lean/UnionClosed/Frankl.lean` lines 209–317 — the
  `obstructionClass_cohomology_vanishing` body that routes through
  the bridge.
- `docs/state-UC-Lean-per-x-closure.md` (mg-36c3) — the RED structural
  blocker analysis that first proved the chain-level collision.

---

## Verdict (top-of-page)

**Phase A — TC-diamond + math soundness:** **GREEN.** The TC-diamond
analysis is independently verified against the Z2j state doc; the
5-workaround failure pattern is consistent. The math content (UC10
§5.3 + UC13 §§4.5+7) is real per paper. The Lean encoding limitation
is also real (PROVEN mg-36c3 structural-collision theorems exhibit
propositional incompatibility under the current chain encoding).

**Phase B — proposed paper-axiom rigor:** **AMBER (critical).** The
mg-8510 prescription, as literally written, would install a paper-axiom
whose statement is **propositionally equivalent to ¬IsCounterexample F
= Frankl** modulo two PROVEN structural-collision theorems already in
`SSConvergence.lean`. This is not directly analogous to OneThird's
`case3Witness_hasBalancedPair_outOfScope` axiom (which is propositionally
consistent with every other proven OneThird theorem). The execution
ticket must either (a) restructure `Frankl.lean` to avoid the
chain-class collision detour, (b) state the axiom at the SS-derived
level rather than the chain level, or (c) explicitly disclose in the
axiom's docstring that combined with the PROVEN collision it
axiomatises Frankl. Otherwise a knowledgeable Zulip reader will
notice the equivalence and fail the "EXTREMELY confident" bar.

**Phase C — `Frankl_Holds` restatement framing:** **AMBER.** The
concrete-witness GREEN path for `Frankl_Holds_fullPowerset3` and
`Frankl_Holds_fullPowerset4` is correctly preserved (independent of
the bridge). But the mg-8510 prescription does not follow the
OneThird mg-74d2 "split into unconditional small-case slice +
explicitly-conditional general-case slice" pattern; it only patches
the general-case bridge. A cleaner restatement separates
`Frankl_Holds_smallN` (concrete-witness, unconditional) from
`Frankl_Holds_largeN` (paper-axiomatised) and exposes the conditional
dependency at the API surface, matching OneThird's recommended
restructuring (`width3_one_third_two_thirds_smallN` vs `_largeN`).

**Phase D — Zulip-embarrassment-risk:** **AMBER.** A careful mathlib
reviewer will:

1. Inspect `#print axioms Frankl_Holds` and see the new axiom.
2. Read the axiom statement and notice that the chain-level conclusion
   `obstructionCohomClassChain F = 0` under `IsCounterexample F`,
   combined with the PROVEN `obstructionCohomClassChain_ne_zero_of_counterexample`,
   directly yields `¬ IsCounterexample F` = Frankl.
3. Ask: "isn't this just axiomatising Frankl?"

Publishable if and only if the docstring explicitly addresses this,
gives a full OneThird-`AXIOMS.md`-style paper-vs-formalisation
diagnosis, and frames the axiom as the *combination* of two deferred
substeps (SS vanishing + Walsh-isotype chain-encoding refinement) —
not as a single faithful transcription of one paper claim. Without
these revisions, the disclosure pivot risks looking like "we couldn't
prove this so we just assumed it" rather than "we're using paper
argument X, axiomatised because Lean delivery has TC-diamond".

**Phase E — forward action:** **GREEN-WITH-CONDITIONS.** The (v)+(iv)
strategic direction is sound; the disclosure pivot is the right
immediate step. The execution ticket (mg-1b2b) MUST land the
specific revisions enumerated in §5 below before dispatch. The
revisions are mostly framing and documentation (no new math, no new
Lean infrastructure work); a single-session execution polecat can
deliver them. After revisions land, Frankl headline is publication-ready.

**Verdict label:** **GREEN-WITH-CONDITIONS** — clear for mg-1b2b
dispatch subject to the §5.1 revision list. Daniel-attention items
in §6.

---

## §0 — Audit scope and method

This audit independently verifies mg-8510's (v)+(iv) hybrid
recommendation along five axes:

1. **Phase A.** Is the TC-diamond root cause correctly diagnosed?
   Are the 5 workaround-failure analyses sound? Is the "math content
   is REAL but Lean encoding doesn't support clean assembly" claim
   accurate?
2. **Phase B.** What is the formal Lean signature of the proposed
   paper-axiom? Does the paper-side SS argument behind it hold
   rigorously? Is every step substantively-paper-rigorous (vs
   paper-axiomatised-itself vs hand-waved)?
3. **Phase C.** Does the proposed `Frankl_Holds` restatement
   correctly preserve the unconditional small-case slice while
   making the conditional general-case dependency explicit and
   honest?
4. **Phase D.** Would a careful mathlib-Zulip reviewer find the
   disclosure pivot publishable, or would they find embarrassing
   gaps?
5. **Phase E.** What concrete revisions (if any) does the execution
   ticket need before dispatch?

**Method.**

- **Default-skeptical** per the cumulative vacuity-discovery pattern
  (`feedback-vacuity-cascade-can-bottom-out`): assume each mg-8510
  claim is unsupported until independently checked.
- **Source-of-truth** for the structural collision: lines in
  `lean/UnionClosed/UC11/SSConvergence.lean` (the PROVEN
  collision theorems).
- **Source-of-truth** for the TC-diamond: cross-reference between the
  mg-8510 audit's mechanism description and the Z2j state doc's
  independent observation of the same elaborator failure pattern.
- **Source-of-truth** for the paper-side math: `docs/union-closed-UC10-*`,
  `docs/union-closed-UC11-*`, `docs/union-closed-UC13-*`,
  `docs/union-closed-UC14-*` paper-side notes; `docs/state-UC-Lean-per-x-closure.md`
  for the per-x closure analysis.
- **Comparison anchor:** OneThird `mg-74d2` audit doc + OneThird
  `lean/AXIOMS.md` + OneThird `Case3Residual.lean` — the published
  precedent for a project-axiom disclosure with full
  paper-vs-formalisation diagnosis.

**Hard constraints honoured.**

- No Lean code changes. This document is the only artefact.
- Independent of mg-8510's framing: default-skeptical, not a
  rubber-stamp.
- Per Daniel's "EXTREMELY confident on Zulip": ruthless skepticism on
  the publication-risk axis.

---

## §1 — Phase A: TC-diamond + math soundness verification

### 1a. TC-diamond root cause — independently corroborated

mg-8510 §1a–1c traces the diamond to two `HasZeroMorphisms` instances at
the bicomplex type, with default priority 1000 vs preadditive priority
100. The diagnosis is consistent with the Z2j state doc
(`docs/state-UC-Lean-Z2j.md`), which independently observes:

> "synthesized `HomologicalComplex.instHasZeroMorphisms`
>  inferred `preadditiveHasZeroMorphisms`"

This is the *exact* error message mg-8510 cites in §1b. Both
documents identify the same instance-graph branch points
(`HomologicalComplex.lean:285` direct path vs `Additive.lean:86 →
Preadditive/Basic.lean:201` preadditive path). The Z2j state doc was
written by a *different polecat* in a different session, independently
observing the same mechanism. **The diamond is verified real.**

### 1b. 5 workaround failures — independently sound

mg-8510 §1d enumerates 5 workaround attempts (section-variable
discipline, `letI` chain, `maxHeartbeats`, `synthInstance.maxHeartbeats`,
full TC-chain section variable expansion) and explains why each
failed. The Z2j state doc reports the same 5 workarounds with the
same failure mode ("TC search re-runs at the bicomplex level
regardless of the section-variable normalisation"). The Z2e
precedent — section-variable discipline working there because
`shortExact_of_degreewise_shortExact` operates at first-level HC — is
also corroborated by the Z2e state doc's success report.

**Verdict.** The 5-workaround failure analysis is sound. The diamond
is structural (priority logic), not budget (heartbeat exhaustion).

### 1c. Math content REAL — corroborated against paper-side docs

mg-8510 claims the math content (a bicomplex SS converging to total
cohomology with equivariant lift + isotype splitting, applied to the
BK bicomplex's χ_x-isotype slice to derive `IsZero (gr_x H^{n-1}(Tot))`)
is standard. Cross-referencing:

- `docs/union-closed-UC10-native-cohomology-intersection-closed-families.md`
  §5.3 — twisted-bridge null-homotopy on the lower-Walsh isotype.
- `docs/union-closed-UC13-frankl-closure.md` §§4.5+7 — corrected
  landing + per-coordinate decomposition.
- `docs/state-UC-Lean-per-x-closure.md` §1 — the paper-side closure
  plan explicitly confirms:

  > "At the paper level, UC10 §5.3 (= UC13 Theorem 4.5.1) does give
  > V_{x}^{n-1} = 0 cohomologically via the twisted-bridge null-homotopy
  > splitting; combined with UC13 §2.4.1 corrected landing in V_{x}^{n-1}
  > and UC14 R1 Θ-abutment, the per-x cohomology class vanishes. This
  > closure is GREEN at the paper level (mg-fbbb L3, mg-acb7 L4, mg-fa21
  > L5 deliveries)."

**Verdict.** The paper-side SS argument is established. The math
content is real.

### 1d. Lean-encoding incompatibility REAL — verified by PROVEN collision

The critical Phase A finding. mg-8510 claims that the *Lean encoding*
of `obstructionClass F x := single (topVertex F) (β_x F)` does *not*
support the paper-side SS vanishing as a propositionally-equivalent
chain identity. This is not just a Lean-engineering inconvenience; it
is a **PROVEN propositional incompatibility**:

`lean/UnionClosed/UC11/SSConvergence.lean:436-440`:

```lean
theorem per_x_chain_cohom_vanishing_collides_topVertex_not_coboundary
    (F : IntClosedFam n) (hStar : IsCounterexample F) (x : Fin n)
    (h : obstructionCohomClassChain F x = 0) :
    False :=
  obstructionCohomClassChain_at_ne_zero_of_pos_bias F x (hStar.2.2 x) h
```

And `lean/UnionClosed/UC11/SSConvergence.lean:455-459`:

```lean
theorem aggregate_chain_cohom_vanishing_collides_topVertex_not_coboundary
    (F : IntClosedFam n) (hStar : IsCounterexample F)
    (h : obstructionCohomClassChain F = 0) :
    False :=
  obstructionCohomClassChain_ne_zero_of_counterexample F hStar h
```

Both are PROVEN one-liners. They directly show: under
`IsCounterexample F`, any hypothetical Lean proof of
`obstructionCohomClassChain F = 0` derives False — i.e., the
conclusion is propositionally false under hStar in the current
encoding. The Y6 sorry at `SSConvergence.lean:596` is exactly an
unprovable claim of this form.

The collision mechanism (per `docs/state-UC-Lean-per-x-closure.md`
§2): under Path C's per-coord encoding, the chain-level cohomology
class lives on the topVertex generator line and is governed by
`topVertex_not_coboundary` (PROVEN at every n≥3 via mg-6acd
augmentation). The cohomology class of `single (topVertex F) r` is
zero iff `r = 0`. Under hStar.2.2, `β_x F > 0`, hence the cohomology
class is non-zero. Therefore `obstructionCohomClassChain F = 0` under
hStar is propositionally false.

**Verdict.** The "math content REAL but Lean encoding doesn't support
clean assembly" claim is correct and *stronger* than mg-8510 stated.
The incompatibility is PROVEN at Lean level, not just an
engineering-difficulty diagnosis.

### 1e. Equivalence claim — corroborated

mg-8510 §2e claims the SS-derived obstruction path is "equivalent in
mathematical content" to (multi-week) Walsh-isotype chain refactor
(Y6b, `mg-e75c`) or to paper-side coherence-style arguments (UC10
§5.3, UC13 §§4.5+7). The state doc `state-UC-Lean-per-x-closure.md`
§5 independently identifies the same three closure paths (Path A
multi-month SS infrastructure, Path B multi-week per-S Walsh
refinement, Path E named-axiom). The "equivalent in mathematical
content" framing is sound: all three paths deliver the same final
mathematical conclusion (per-x cohomology vanishing on the χ_x-isotype
slice) by different Lean-encoding routes.

### 1f. Phase A verdict — GREEN

| Mechanism component | Independently verified? |
|---|---|
| TC-diamond is real mathlib v4.29.1 bug | ✅ (matches Z2j state doc independent observation) |
| 5 workarounds genuinely failed | ✅ (matches Z2j workaround enumeration) |
| Math content is REAL (paper-side SS argument) | ✅ (matches paper-side UC10/UC13 docs + state-UC-Lean-per-x-closure §1) |
| Lean encoding incompatibility is REAL | ✅ (PROVEN by mg-36c3 structural-collision theorems in SSConvergence.lean) |
| "Equivalent in mathematical content" framing | ✅ (corroborated by state-UC-Lean-per-x-closure §5 three-path enumeration) |

**Phase A: GREEN.** mg-8510's (v)+(iv) strategic direction is sound on
all soundness axes. The structural diagnosis is verified
independently; the math content is verified against paper-side docs;
the Lean-encoding incompatibility is verified PROVEN at machine level
(stronger than mg-8510's framing).

---

## §2 — Phase B: Audit of the proposed paper-axiom

### 2a. The proposed axiom signature (from mg-8510 §2e)

mg-8510 proposes:

```lean
-- New: in lean/UnionClosed/Frankl.lean (or PaperAxioms.lean)
axiom case3_ss_obstruction_paper_axiom :
  ∀ (n : ℕ) (F : ...),
    IsCounterexample F →
      -- the SS-derived obstruction class on the χ_x slice of
      -- H^{n-1}(Tot (BKBicomplexHC₂ F)) vanishes, per UC10 §5.3 +
      -- UC13 §§4.5+7 (faithful Lean delivery pending Z-arc completion).
      ObstructionCohomClassZ_vanishes_paper_axiom F

theorem Frankl_Holds (F : ...) : Frankl_Holds_general F := by
  ...
  -- Replace the in-tree obstructionCohomClass_at_vanishing call with:
  exact case3_ss_obstruction_paper_axiom n F hStar
```

with execution prescription (mg-8510 §5a step 2):

> MODIFY: `lean/UnionClosed/UC11/SSConvergence.lean`. Delete the
> `obstructionCohomClassChain_eq_zero_via_y6_transport_residual`
> bridge body and its sorry at line 596. Replace with a one-liner
> invoking the paper-axiom.

### 2b. Type-level disambiguation: SS-level vs chain-level

The mg-8510 sketch is ambiguous about the axiom's *conclusion type*. Two
distinct things could be axiomatised:

**(B1) SS-level claim.** `IsZero ((BKBicomplexHC₂ F).abutmentFiltration_gr x ((n-1)-x))`
— i.e., the SS-derived obstruction class lives in a *different
cohomology object* (the gr-piece of the SS abutment filtration on
the χ_x-isotype slice), which is asserted IsZero. This is *faithful
to the paper claim* (UC10 §5.3 + UC13 §§4.5+7). This matches mg-103f
acceptance bar 12.

**(B2) Chain-level claim.** `obstructionCohomClassChain F = 0` under
`IsCounterexample F` — i.e., the OLD chain class's vanishing. This is
what the deleted Y6 bridge currently claims as its conclusion.

The execution prescription (§5a step 2: "delete the bridge body and
replace with a one-liner invoking the paper-axiom") directly implies
the axiom's conclusion must MATCH the bridge's conclusion. The
bridge's conclusion is `obstructionCohomClassChain F = 0` under
`IsCounterexample`. So the execution prescription forces interpretation
(B2): chain-level claim.

But the docstring sketch in §2e talks about (B1)'s flavour
("`H^{n-1}(Tot (BKBicomplexHC₂ F))` vanishes"). The two are different
mathematical statements in different cohomology objects.

**The mg-8510 prescription conflates (B1) and (B2).** This is the
core Phase B issue.

### 2c. Critical finding — (B2) axiom is propositionally equivalent to Frankl

Suppose we take the literal execution prescription and install an
axiom whose conclusion matches the bridge:

```lean
axiom case3_ss_obstruction_paper_axiom :
  ∀ {n : ℕ} (F : IntClosedFam n),
    IsCounterexample F →
    obstructionCohomClassChain F = 0
```

Combined with `obstructionCohomClassChain_ne_zero_of_counterexample`
(PROVEN), we have:

```
∀ F, IsCounterexample F → False
  ↔ ∀ F, ¬ IsCounterexample F
  ↔ Frankl_Holds (counterexample-free form)
```

That is, **the axiom (B2) is propositionally equivalent to the
counterexample-free form of Frankl** modulo the PROVEN structural
collision. Every consequence of the axiom + collision is also a
consequence of just postulating Frankl directly.

This is **not directly analogous** to OneThird's
`case3Witness_hasBalancedPair_outOfScope` axiom. In OneThird, there
is no PROVEN theorem stating `Case3Witness L → ¬ HasBalancedPair α`;
the axiom asserts a paper-sketch-proven claim that is propositionally
consistent with every other theorem in the OneThird tree (a future
fleshed-out proof can restate the body without changing call-sites).
The axiom there is *faithful gap*.

For Frankl, the (B2) form would be *Frankl-in-disguise* —
propositionally equivalent to ¬IsCounterexample = Frankl modulo
PROVEN theorems.

### 2d. (B1) form requires Frankl.lean restructure

The cleaner alternative is (B1): assert the SS-level claim. But the
SS-level claim doesn't directly discharge the Frankl.lean call site,
because `Frankl.lean:209` is structured to derive False via:

```
hChainCohomNZ : obstructionCohomClassChain F ≠ 0   -- PROVEN under hStar
hChainCohomZ  : obstructionCohomClassChain F = 0   -- via Y6 bridge (sorry'd)
exact absurd hChainCohomZ hChainCohomNZ
```

For the (B1) axiom about the SS-derived class (in a *different*
cohomology object) to discharge the chain-level `hChainCohomZ`, we'd
need a chain↔SS transport — which is exactly the Y6 chain-map-extension
blocker. So the (B1) axiom alone *does not* discharge the bridge's
conclusion.

To use (B1) properly, `Frankl.lean:209` must be **restructured** to
derive False through a *different* chain — one that uses the SS-derived
class directly without first going through `obstructionCohomClassChain`.
That is a non-trivial restructure (not the "delete bridge body and
substitute one-liner" pattern in §5a step 2).

### 2e. (B3) — combined axiom with honest disclosure

A third option, more faithful than (B2) and simpler than (B1):

```lean
/-- **Combined paper-axiom (case3 SS-obstruction, two-substep form)**:
    captures (1) the SS-vanishing on the χ_x-isotype slice (faithful
    to paper UC10 §5.3 + UC13 §§4.5+7) PLUS (2) the chain-encoding
    refinement (Walsh-isotype refactor of `obstructionClass` chain
    encoding) that propositionally transports (1) to the chain-level
    conclusion below.

    **Honest disclosure**: combined with the PROVEN structural-collision
    theorem `obstructionCohomClassChain_ne_zero_of_counterexample` in
    `SSConvergence.lean`, this axiom is propositionally equivalent to
    `∀ F, ¬ IsCounterexample F` = Frankl. The axiom thus captures the
    "we're using paper argument X + chain-encoding refinement Y, both
    deferred to research-track" content. -/
axiom case3_ss_obstruction_paper_axiom :
  ∀ {n : ℕ} (F : IntClosedFam n),
    IsCounterexample F →
    obstructionCohomClassChain F = 0
```

This is the (B2) signature, but with a docstring that explicitly
acknowledges:

- The PROVEN structural collision makes the axiom + collision = Frankl.
- The substantive paper-side content (SS vanishing) is one of two
  combined substeps.
- The chain-encoding refinement (Walsh-isotype refactor) is the other.
- Both substeps are deferred to Z-research-track.

This is the **publication-defensible** form, in the spirit of
OneThird's AXIOMS.md disclosure pattern, adapted to the structural-collision
situation that has no OneThird analog.

### 2f. Phase B tagging table (per ticket §6 — substantive / paper-axiomatised / hand-waved)

| Sub-claim of paper-axiom | Status |
|---|---|
| SS-vanishing of `gr_x H^{n-1}(Tot (BKBicomplexHC₂ F))` per UC10 §5.3 + UC13 §§4.5+7 | substantive-paper-rigorous |
| Bicomplex SS converges to claimed total cohomology | substantive-paper-rigorous (standard Verdier construction) |
| Equivariant `(Z/2)^n` lift + Walsh-isotype splitting on the BK bicomplex | substantive-paper-rigorous (Maschke for finite abelian groups + L4-degenerate-page) |
| BK bicomplex application to χ_x-isotype slice delivers IsZero (gr_x H^{n-1}(Tot)) | substantive-paper-rigorous (UC13 §2.4.1 corrected landing + UC10 §5.3 twisted-bridge null-homotopy + UC14 R1 Θ-abutment) |
| Chain↔SS transport (chain-class vanishing follows from SS-class vanishing) | **paper-axiomatised-itself** — the chain↔SS transport requires the Walsh-isotype refinement of `obstructionClass` chain encoding (multi-week Y6b refactor); deferred to research-track |
| Y6 chain-map-extension specifically (lifting a degree-0 isotype map to a chain map) | **STRUCTURALLY-IMPOSSIBLE in current chain encoding** — PROVEN false via `topVertex_not_coboundary`; closure requires Y6b chain refactor OR Path A multi-month mathlib SS |

The bottom two rows are the propositional content that's hidden by
the literal (B2) prescription. Daniel's "EXTREMELY confident on
Zulip" bar requires these rows to appear *explicitly* in the
axiom's docstring + AXIOMS.md disclosure, not buried in a separate
state doc.

### 2g. Phase B verdict — AMBER (with B3-form revision path)

The proposed paper-axiom, as literally prescribed by mg-8510 §5a, is
the (B2) form: chain-level claim, propositionally equivalent to Frankl
modulo PROVEN collision. This is **not embarrassing if disclosed
honestly** (the B3 docstring above) but **IS embarrassing if shipped
in the (B2) form without disclosure** because a Zulip reader would
immediately notice the equivalence.

**Required revisions for Phase B GREEN:**

1. The execution ticket MUST choose explicitly between (B1)
   [SS-level + Frankl.lean restructure], (B2) [chain-level, requires
   B3 docstring], or a true two-axiom form ([B1' SS-vanishing] + [B1''
   chain-encoding-refinement-transport]).
2. The choice MUST be reflected in both the axiom's docstring and the
   new `lean/AXIOMS.md` disclosure.
3. If (B2)+(B3), the docstring MUST explicitly note: "combined with
   the PROVEN structural-collision in `SSConvergence.lean`, this axiom
   is propositionally equivalent to `∀ F, ¬ IsCounterexample F` =
   Frankl."

**Verdict.** AMBER on Phase B as currently prescribed. GREEN-able by
the B3-form revision (single-session execution).

---

## §3 — Phase C: `Frankl_Holds` restatement framing audit

### 3a. mg-8510's current restatement plan (§5a)

Per §5a steps 3–5:

> 3. MODIFY: `lean/UnionClosed/Frankl.lean`. Line 209 (the in-line
>    sorry-relocation point from mg-e75c Y6) — the call chain is
>    already routed through the bridge; the bridge's body change in
>    step (2) propagates through automatically.
> 4. MODIFY (or NEW): `lean/AXIOMS.md`. Document the new axiom,
>    cross-reference the audit, name the Z-arc research-track ticket.
> 5. PRESERVE: `Frankl_Holds_fullPowerset3`, `Frankl_Holds_fullPowerset4`
>    (concrete-witness GREEN cases). Neither goes through the paper-axiom;
>    neither needs change.

### 3b. Verification of preserved concrete-witness GREEN slice

`Frankl_Holds_fullPowerset3` at `lean/UnionClosed/Frankl.lean:528–531`:

```lean
theorem Frankl_Holds_fullPowerset3 :
    ∃ x : Fin 3, beta x fullPowerset3 ≤ 0 := by
  obtain ⟨x, _, hx⟩ := fullPowerset3_minimal_element
  exact ⟨x, hx⟩
```

This routes through `fullPowerset3_minimal_element` (L4 minimal-element
witness, concrete), **does not invoke the bridge or the paper-axiom**,
and gives `x = 0` with `β_0 = 0 ≤ 0`. Verified independent of any
counterexample-case machinery.

`Frankl_Holds_fullPowerset4` similarly routes through
`fullPowerset4_minimal_element` via L4-followup cross-n transport.

**Verdict.** Both concrete-witness slices are preserved correctly.
This part of mg-8510 §5a is sound.

### 3c. Issue with the general-case restatement

The mg-8510 §5a step 3 says the `Frankl.lean:209` call chain is
"already routed through the bridge; the bridge's body change in step
(2) propagates through automatically." This is technically true at
the type-checking level, but it leaves the *chain-class collision
detour* in place inside the body of `obstructionClass_cohomology_vanishing`.

Looking at the actual body (`Frankl.lean:266-317`):

```lean
have hCohomZ : obstructionCohomClass F = 0 :=
  obstructionCohomClass_vanishing_via_lowerWalsh F hStar hLanding hLowerVanish hTheta.1
-- ... (Y5 NEW class, trivially zero, propositionally fine)
have hChainCohomNZ : obstructionCohomClassChain F ≠ 0 :=
  obstructionCohomClassChain_ne_zero_of_counterexample F hStar
-- (OLD chain class, PROVEN non-zero under hStar, propositionally fine)
have hChainCohomZ : obstructionCohomClassChain F = 0 :=
  obstructionCohomClassChain_eq_zero_via_y6_transport_residual F hStar
-- (Y6 bridge, sorry'd, propositionally FALSE under hStar)
exact absurd hChainCohomZ hChainCohomNZ
```

After the bridge body is replaced with the paper-axiom invocation,
`hChainCohomZ` is *derived from the paper-axiom* instead of from the
Y6 chain-map-extension argument. But the structural shape of the
derivation is unchanged: we still have PROVEN-non-zero + axiom-asserted-zero
→ False → conclusion. The paper-axiom is *load-bearing for this False
derivation*, and (as Phase B established) the axiom combined with the
PROVEN non-vanishing collapses to Frankl.

This is *functionally equivalent* to axiomatising Frankl directly and
running `False.elim` on it. The mg-8510 §5a prescription does not
disclose this structural shape.

### 3d. OneThird mg-74d2 precedent — restate, don't axiomatise

The OneThird audit (`mg-74d2`) explicitly recommends **restating the
headline to separate unconditional from conditional slices**:

> Split `OneThird.width3_one_third_two_thirds` into two theorems:
> - `width3_one_third_two_thirds_smallN` — unconditional for `|α| ≤ 10`,
>   discharged via mg-4d7b certificate. No `hC3` hypothesis.
> - `width3_one_third_two_thirds_largeN` — conditional on Steps 1-7
>   bandwidth delivery for `|α| ≥ 11`. Keep the typed Steps-1-7
>   dependency visible at the API surface. No `hC3` hypothesis.

And Phase D §4f explicitly notes:

> The pre-existing `case3Witness_hasBalancedPair_outOfScope` axiom
> (`Case3Residual.lean:208`) is removed by Option D-narrow (step 2).

In OneThird, the recommended pivot DROPS one axiom (the case3
residual) AND restructures the headline interface to put the
conditional dependency on the *upstream Steps 1-7 paper-axiom*, NOT
on a new chain-level axiom. The OneThird restatement is *more
honest* than the current mg-8510 prescription, because it (a)
separates concrete-witness unconditional from conditional, and (b)
parks the conditional dependency on already-shipped paper-axiomatised
infrastructure (`Step7.LayeredWidth3`) rather than on a new
project-axiom at the headline boundary.

### 3e. Recommended restatement for Frankl (matches OneThird pattern)

To match the OneThird mg-74d2 pattern more faithfully:

```lean
/-- **Frankl_Holds for concrete small n** (unconditional GREEN at
    n=3, n=4 via L4 minimal-element witnesses). No paper-axiom
    dependency. -/
theorem Frankl_Holds_concrete (F : IntClosedFam n)
    (h_ne : F.family ≠ ({Finset.univ} : Finset (Finset (Fin n))))
    (h_concrete : <some predicate covering fullPowerset3/4 + their cross-n
                  family that has a concrete minimal-element witness>) :
    ∃ x : Fin n, beta x F ≤ 0 := <existing concrete proof>

/-- **Frankl_Holds (general form)**, explicitly conditional on the
    `case3_ss_obstruction_paper_axiom`. The axiom captures the SS-derived
    obstruction-class vanishing per UC10 §5.3 + UC13 §§4.5+7 (faithful
    Lean delivery pending the Z-arc research-track). See AXIOMS.md for
    full disclosure. -/
theorem Frankl_Holds_general (F : IntClosedFam n)
    (h_ne : F.family ≠ ({Finset.univ} : Finset (Finset (Fin n)))) :
    ∃ x : Fin n, beta x F ≤ 0 := <existing proof via bridge + axiom>

/-- **Frankl_Holds (combined)**: cases on n + concrete-witness;
    dispatches between the unconditional small-case and the
    axiom-dependent general-case. The API surface preserves the
    universal statement at the call boundary. -/
theorem Frankl_Holds {n : ℕ} (F : IntClosedFam n)
    (h_ne : F.family ≠ ({Finset.univ} : Finset (Finset (Fin n)))) :
    ∃ x : Fin n, beta x F ≤ 0 := <dispatch>
```

This makes the API explicit: callers who pass `fullPowerset3`,
`fullPowerset4`, or any future `fullPowersetN` get the unconditional
discharge. Callers who pass arbitrary `F` route through the
paper-axiom dependency. `#print axioms Frankl_Holds` correctly lists
the axiom dependency (because `Frankl_Holds_general` invokes it via
the bridge), and `#print axioms Frankl_Holds_concrete` correctly does
NOT list the axiom dependency. This is the cleanest separation of
concerns.

### 3f. Phase C verdict — AMBER

The mg-8510 §5a restatement plan:
- (a) Correctly preserves `Frankl_Holds_fullPowerset3/4` as
  unconditional GREEN ✅
- (b) Routes the bridge through the paper-axiom (mechanically) ✅
- (c) Does **NOT** restructure the API surface to separate
  unconditional from conditional ❌
- (d) Does **NOT** explicitly disclose that the paper-axiom + PROVEN
  collision = Frankl ❌

**Required revisions for Phase C GREEN:**

1. Restructure `Frankl_Holds` into `_concrete` (unconditional,
   small-case via minimal-element witness) + `_general`
   (axiom-dependent) + dispatch, matching the OneThird mg-74d2
   pattern. (Optional but strongly recommended.)
2. If not (1), then at minimum the docstring of the general
   `Frankl_Holds` MUST explicitly note its axiom dependency and the
   fact that `Frankl_Holds_fullPowerset3/4` do *not* go through the
   axiom. Currently the docstring (lines 425–462) does not surface
   the axiom dependency.

**Verdict.** AMBER on Phase C. GREEN-able by the §3e restructure
(single-session execution).

---

## §4 — Phase D: Zulip-embarrassment-risk audit

### 4a. Simulated mathlib-Zulip reviewer scrutiny

Imagine the Frankl Lean development is announced on the mathlib Zulip
forum after the disclosure pivot lands. A careful reviewer with
homological-algebra expertise (the audience that would care about
SpectralObject infrastructure and TC-diamonds) goes through:

**Step 1: `#print axioms Frankl_Holds`.**

The reviewer sees:

```
'Frankl_Holds' depends on axioms:
  [Classical.choice, propext, Quot.sound]
  case3_ss_obstruction_paper_axiom    -- the new axiom
```

The mathlib trio is standard; the new axiom is the headline-disclosed
project-axiom. The reviewer clicks through to its definition.

**Step 2: Reads the axiom statement.**

If the axiom is in the (B2) form:

```lean
axiom case3_ss_obstruction_paper_axiom :
  ∀ {n : ℕ} (F : IntClosedFam n),
    IsCounterexample F →
    obstructionCohomClassChain F = 0
```

The reviewer notes:
- The conclusion is at the chain-level cohomology (`(BKTotal n).homology 0`).
- The hypothesis is `IsCounterexample F`.

**Step 3: Looks for related theorems in `SSConvergence.lean`.**

Greps for `obstructionCohomClassChain` and finds:

```lean
theorem obstructionCohomClassChain_ne_zero_of_counterexample
    (F : IntClosedFam n) (hStar : IsCounterexample F) :
    obstructionCohomClassChain F ≠ 0
```

PROVEN. The reviewer immediately spots:

> **Wait — the axiom asserts `obstructionCohomClassChain F = 0` under
> `IsCounterexample F`, but this proven theorem asserts the negation.
> Combined, they yield `∀ F, ¬ IsCounterexample F` — which is Frankl.
> Isn't this just axiomatising Frankl with extra steps?**

If the docstring does *not* address this (option (B2) without (B3)
disclosure), the reviewer concludes the axiom is "Frankl in disguise"
and the disclosure pivot is *embarrassing*. The Zulip post receives
critical replies.

If the docstring DOES address this (option (B3) honest disclosure),
the reviewer notes:

> "OK, the axiom is the combination of two deferred substeps (SS
> vanishing per paper UC10 §5.3 + Walsh-isotype chain refactor). The
> docstring acknowledges the equivalence with Frankl via the PROVEN
> collision. This is honest project-axiom disclosure analogous to
> OneThird's case3Witness axiom but with the structural-collision
> nuance made explicit. Publishable."

### 4b. Comparison to OneThird AXIOMS.md disclosure quality

OneThird's `case3Witness_hasBalancedPair_outOfScope` AXIOMS.md entry
includes:
- Paper statement reference (`step8.tex:3033-3047`,
  `rem:enumeration` `3157-3173`).
- Introduced by + QA-audited by (tickets `mg-b846` and `mg-7377`).
- Status statement ("retained as a named project axiom for one
  polecat session, with the gap surfaced honestly").
- Scope-match checklist (9-row table mapping paper hypotheses to
  axiom hypotheses with ✅).
- "Why this is internal, not external" section (distinguishing from
  Brightwell — *internal* paper sketch vs *external* published
  citation).
- "Why retain rather than port" section (estimating port cost +
  identifying substantive missing content).
- "Replacement path (open)" enumerating 3 steps a future port should
  take.
- "Forum-post disclosure" section (explicitly framing how this axiom
  appears alongside `brightwell_sharp_centred` and the mathlib trio,
  with honest distinction).
- "QA verdict" with 6-point audit (hypothesis profile match,
  size-cap relationship, conclusion match, quantifier order, sketch
  credibility, cross-reference).

The Frankl disclosure pivot needs an analogous AXIOMS.md entry of
similar quality. mg-8510 §5a step 4 says only "Document the new
axiom, cross-reference the audit" — too thin for the OneThird-grade
disclosure bar.

### 4c. Difference from OneThird that needs additional disclosure

The OneThird case3 axiom has *no PROVEN collision*. For Frankl, the
chain-level (B2) form has a PROVEN collision that makes axiom + collision
= Frankl. This is a *new disclosure obligation* not present in
OneThird:

> "In the current Lean chain encoding of `obstructionClass`, the
> axiom's conclusion is propositionally equivalent under
> `IsCounterexample` to ¬IsCounterexample F (= Frankl in
> counterexample-free form). This is because the chain encoding uses
> `Finsupp.single (topVertex F) (β_x F)`, and PROVEN augmentation
> injectivity (`topVertex_not_coboundary`, mg-6acd) forces
> non-vanishing under positive bias. The axiom thus captures BOTH the
> substantive SS-vanishing content (faithful to paper UC10 §5.3 +
> UC13 §§4.5+7) AND the chain-encoding-refinement transport (Walsh
> isotype refactor of `obstructionClass`, deferred to Z-research-track).
> Replacing the axiom with a substantive proof requires either Path A
> (full mathlib SS infrastructure, multi-month per mg-103f Z-arc
> scoping) OR Path B (per-S Walsh refinement, multi-week per
> mg-e75c)."

Without this explicit disclosure, the axiom looks like "Frankl in
disguise". With it, the axiom is honest two-substep paper-axiomatisation.

### 4d. SpectralObject infrastructure documentation status

mg-8510 §5b correctly recommends documenting the SpectralObject
infrastructure work (Z1+Z1b+Z2a–Z2j, ~10M tokens cumulative) as
"research-track / deferred" rather than "incomplete attempt". The
shelving recommendations are sound. **No revision needed here.**

Confirm:

- `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/SpectralSequenceAssembly.lean`
  (Z1, mg-4165) — GREEN-archived; survives as research-track infrastructure ✅
- `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/Bicomplex.lean`
  (Z2a–Z2j, ~3450 lines accumulated) — AMBER-archived; survives as
  research-track scaffolding ✅
- `docs/state-UC-Lean-Z*.md` cumulative state docs — preserved as
  research-track audit trail ✅

### 4e. Joël Riou attribution

mg-8510 §5a step 1 mentions "Riou attribution in file header + commit
message". Confirmed required per the `project_z_arc_local_only`
directive (Daniel 2026-05-17T13:53Z): "mathlib code local-only for
now, push upstream later if we have time" with Joël-Riou-attributed
provenance preserved. The SpectralObject infrastructure files all
carry this attribution. **No revision needed.**

### 4f. Phase D verdict — AMBER

**Required revisions for Phase D GREEN:**

1. AXIOMS.md entry must be **OneThird-grade**: 9-row scope-match
   checklist, paper-vs-formalisation diagnosis, replacement-path
   (open), forum-post disclosure, QA verdict structure. The §5a step
   4 "Document the new axiom, cross-reference the audit" is
   insufficient.
2. AXIOMS.md must explicitly include the chain-level-collision
   disclosure (§4c above).
3. The axiom's *own* Lean docstring (not just AXIOMS.md) must include
   the collision-disclosure note — Zulip readers will look at the
   axiom's docstring first.
4. The execution ticket MUST attach the `#print axioms Frankl_Holds`
   output to the docstring or as a comment, so the dependency is
   immediately visible.
5. The SpectralObject infrastructure documentation should add a
   header note ("research-track / deferred per mg-8510 verdict") to
   `SpectralSequenceAssembly.lean` and `Bicomplex.lean` so a
   first-time reader knows the status without reading state docs.

**Verdict.** AMBER on Phase D. GREEN-able by the §4f revision list
(single-session execution, mostly docstring + AXIOMS.md content).

---

## §5 — Phase E: Forward action verdict

### 5.1. Revision list for mg-1b2b (the execution ticket)

For the execution ticket to qualify as GREEN-publication-ready, the
following revisions to mg-8510's §5a prescription must be applied
**before mg-1b2b dispatch** (or be included in the mg-1b2b scope
itself):

**Revision 1 — Paper-axiom signature choice (mandatory).** The
execution ticket MUST explicitly choose between options (B1)
[SS-level + Frankl.lean restructure], (B2)+(B3) [chain-level with
explicit collision-disclosure docstring], or a true two-axiom split
[B1' SS-vanishing + B1'' chain-encoding-refinement]. The choice MUST
be recorded in the ticket body and reflected in both the axiom's
docstring and AXIOMS.md. **Recommended: (B2)+(B3)** — simplest
implementation matching the §5a one-liner-bridge-substitution
prescription, with the collision disclosure providing the honest
framing.

**Revision 2 — Axiom docstring must include collision-disclosure
note (mandatory).** The axiom's Lean docstring must include the
exact text or equivalent of §4c above: noting that combined with
PROVEN `obstructionCohomClassChain_ne_zero_of_counterexample`, the
axiom is propositionally equivalent to Frankl, and that this captures
the combination of SS-vanishing + chain-encoding-refinement substeps,
both deferred to research-track.

**Revision 3 — Frankl.lean API restructure (recommended, not
mandatory).** Split `Frankl_Holds` into `_concrete` (unconditional
small-case) + `_general` (axiom-dependent) + dispatch, matching the
OneThird mg-74d2 pattern. If not done, the unstructured `Frankl_Holds`
docstring must explicitly note its axiom dependency and the fact that
`Frankl_Holds_fullPowerset3/4` do *not* invoke the axiom.

**Revision 4 — OneThird-grade AXIOMS.md entry (mandatory).** New
`lean/AXIOMS.md` (or `lean/UnionClosed/AXIOMS.md`) with the full
OneThird disclosure structure: scope-match checklist, paper-vs-formalisation
diagnosis, replacement-path (open), forum-post disclosure, QA
verdict. The `#print axioms Frankl_Holds` artefact must be attached
or named.

**Revision 5 — Joël Riou attribution preserved (mandatory).** Per
`project_z_arc_local_only`. Already required by mg-8510 §5a step 1;
re-asserted here for completeness.

**Revision 6 — SpectralObject infrastructure documentation header
notes (recommended).** Add "research-track / deferred per mg-8510
verdict" headers to `SpectralSequenceAssembly.lean` and
`Bicomplex.lean`. Already implicitly named in mg-8510 §5b; lift to
explicit headers for first-time-reader clarity.

**Revision 7 — Removal of OLD chain-class machinery (optional cleanup).**
Once the disclosure pivot lands, the `obstructionCohomClassChain`
machinery becomes largely a historical-record artefact. Daniel may
choose to:
- (a) Keep it verbatim (current mg-8510 plan; preserves
  mg-36c3 PROVEN collision theorems as machine-verifiable diagnostic);
- (b) Remove it entirely if the restructured Frankl.lean does not need
  the OLD chain class collision anymore (cleaner but loses the
  diagnostic content).
Recommendation: (a) for now; (b) at a future cleanup pass once the
restructure stabilises.

### 5.2. Forward-action verdict — GREEN-WITH-CONDITIONS

**The (v)+(iv) hybrid strategic direction is sound** (Phase A GREEN).
**The disclosure pivot is the right immediate step** (Phase B+C+D
AMBER reducible to GREEN with §5.1 revisions). **The execution ticket
mg-1b2b can dispatch after the §5.1 revisions are either applied to
its scope or accepted as separate sub-tickets.**

The required revisions are *all documentation, framing, and minor
restructure* — no new math, no new Lean infrastructure work, no new
sorries. A single-session execution polecat can deliver them in
~250–400k tokens (slightly larger than mg-8510 §5a's 250–350k
estimate to account for OneThird-grade AXIOMS.md content).

### 5.3. Verdict label

**GREEN-WITH-CONDITIONS.** The disclosure pivot clears for execution
provided the §5.1 revision list is applied.

---

## §6 — Daniel-attention items

Per ticket §"After audit GREEN-with-conditions" — *file the
listed-revisions-needed work BEFORE disclosure-pivot execution* — the
following items need explicit Daniel decisions before mg-1b2b
dispatches:

1. **Paper-axiom signature choice (Revision 1).** Pick (B1), (B2)+(B3),
   or two-axiom split. Recommendation: **(B2)+(B3)**.
2. **Frankl.lean API restructure (Revision 3).** Apply the OneThird-pattern
   split into `_concrete` + `_general` + dispatch? **Recommended yes**,
   for API-honesty parity with OneThird and clearer `#print axioms`
   semantics at the `_concrete` boundary.
3. **AXIOMS.md location.** `lean/AXIOMS.md` (new top-level) or
   `lean/UnionClosed/AXIOMS.md` (namespace-scoped)? Recommend the
   former for OneThird-parity.
4. **Revision 7 cleanup deferral.** Keep `obstructionCohomClassChain`
   machinery for now (recommended) or remove during execution?
5. **mg-1b2b ticket scope expansion.** Should the §5.1 revisions land
   in mg-1b2b itself (single ~300k session) or in a follow-on
   `mg-1b2b-revisions` ticket (cleaner separation of concerns)?
   Recommend bundling into mg-1b2b for atomicity.

These items are *Daniel-decision-required* per the polecat-instruction
guidance that strategic choices route to Daniel rather than being
made polecat-side.

---

## §7 — Comparison to OneThird mg-74d2 audit (cross-validation)

The OneThird mg-74d2 audit and this Frankl audit are structurally
parallel:

| Aspect | OneThird (mg-74d2) | Frankl (mg-ee54, this audit) |
|---|---|---|
| Trigger | Daniel asks if poset-structure is the right tool | Daniel approves one axiom conditional on independent audit + EXTREMELY-confident-on-Zulip |
| Audit hypothesis | Layered form is functionally vacuous at headline | mg-8510 (v)+(iv) hybrid is publication-clean |
| Method | Per-lemma layered-axiom-use audit + Phase A-D verdict | Per-axis (TC-diamond / paper-axiom / restatement / Zulip) verdict |
| Top finding | Layered form is **typed routing convention**, real-use only at F5a Bool certificate encoding leaf | mg-8510's (B2) paper-axiom is **propositionally equivalent to Frankl** modulo PROVEN collision |
| Recommended pivot | Restate headline: unconditional small-case + Steps-1-7-conditional general-case + drop case3Witness axiom | Restate headline: unconditional small-case + paper-axiom-conditional general-case + B3-form honest disclosure of collision |
| Difference (key) | OneThird DROPS one axiom (case3) via Option D-narrow | Frankl ADDS one axiom (case3_ss_obstruction_paper) BUT documents collision-equivalence explicitly |
| Concrete cases preserved | `width3_one_third_two_thirds_smallN` (mg-4d7b enumeration) | `Frankl_Holds_fullPowerset3` + `Frankl_Holds_fullPowerset4` (L4 minimal-element witnesses) |
| Verdict label | layered-form-vacuous-at-headline / disclosure-pivot | GREEN-WITH-CONDITIONS (B3-form-revision) |

**The structural parallel validates the audit's framing.** mg-74d2's
recommended pivot is more aggressive (DROPS one axiom). The Frankl
situation is less aggressive (ADDS one axiom) but harder to publish
honestly because of the PROVEN collision. The proper framing for
Frankl follows OneThird's restatement pattern but adds the
collision-disclosure obligation.

**Important asymmetry.** OneThird's case3Witness axiom is *internal
paper-sketch axiomatisation* with no proven collision; it's
publishable on the OneThird AXIOMS.md template directly. Frankl's
proposed paper-axiom has a PROVEN collision with the chain encoding;
it needs an *additional disclosure layer* on top of the OneThird
template. The §5.1 revision list reflects this.

---

## §8 — Cross-references

- **Audit ticket:** `mg-ee54` (this work item).
- **Audit hypothesis (under test):** `mg-8510`
  (`docs/Z-arc-architecture-audit.md`, the (v)+(iv) hybrid
  recommendation).
- **Execution ticket (gated by this audit):** `mg-1b2b`
  (Frankl-disclosure-pivot-execution, pre-filed with
  `depends=mg-ee54`).
- **OneThird disclosure-pivot analog:** `mg-74d2`
  (`one_third/docs/layered-form-vs-coherence-architecture-audit.md`).
- **OneThird AXIOMS.md template:** `one_third_width_three/lean/AXIOMS.md`
  (`OneThird.Step8.InSitu.case3Witness_hasBalancedPair_outOfScope`
  entry, lines 226–454).
- **PROVEN structural-collision theorems (the Phase B critical finding):**
  - `lean/UnionClosed/UC11/SSConvergence.lean:436-440`
    (`per_x_chain_cohom_vanishing_collides_topVertex_not_coboundary`).
  - `lean/UnionClosed/UC11/SSConvergence.lean:455-459`
    (`aggregate_chain_cohom_vanishing_collides_topVertex_not_coboundary`).
  - `lean/UnionClosed/UC11/SSConvergence.lean:164-173`
    (`obstructionCohomClassChain_ne_zero_of_counterexample`).
- **PROVEN augmentation injectivity (load-bearing for the collision):**
  - `lean/UnionClosed/UC11/CohomologyClass.lean:388`
    (`topVertex_not_coboundary`, mg-6acd).
- **The Y6 bridge with the live sorry:**
  - `lean/UnionClosed/UC11/SSConvergence.lean:563-596`
    (`obstructionCohomClassChain_eq_zero_via_y6_transport_residual`).
- **The Frankl.lean call site:**
  - `lean/UnionClosed/Frankl.lean:209-317`
    (`obstructionClass_cohomology_vanishing`).
  - `lean/UnionClosed/Frankl.lean:528-562`
    (`Frankl_Holds_fullPowerset3`, `Frankl_Holds_fullPowerset4`
    — the concrete-witness GREEN slice preserved by the pivot).
- **Paper-side SS argument:**
  - `docs/union-closed-UC10-native-cohomology-intersection-closed-families.md`
    §5.3 (twisted-bridge null-homotopy).
  - `docs/union-closed-UC13-frankl-closure.md` §§4.5+7
    (corrected landing + per-coordinate decomposition).
  - `docs/state-UC-Lean-per-x-closure.md` §1
    (paper-level closure plan confirmation).
- **TC-diamond evidence:**
  - `docs/Z-arc-architecture-audit.md` §1 (mg-8510 mechanism
    description with mathlib v4.29.1 file/line citations).
  - `docs/state-UC-Lean-Z2j.md` (independent observation of the same
    elaborator error pattern from a different polecat session).
- **Z-arc scoping (verdict-modified by mg-8510 + this audit):**
  - `mg-103f` (`docs/UC-Lean-MathlibSS-Full-scope.md`) — Z1–Z10
    decomposition + bars 11–14.
  - Bar 14 (PROJECT-LIFE MILESTONE) modification: see mg-8510 §6
    discussion.
- **Daniel directives in play:**
  - 2026-05-18T07:17Z ("z arc stalling — copy from mathlib or
    reproduce functionality without the bug in short term if needed")
    — interpreted by mg-8510 as enabling the (v)+(iv) hybrid pivot.
  - 2026-05-17T13:53Z ("mathlib code local-only for now, push
    upstream later if we have time") — Riou attribution preserved.
  - 2026-05-17T12:47Z ("full mathlib infrastructure imo, don't pursue
    shortcuts") — the disclosure pivot is not a math-layer shortcut;
    it is explicit disclosure that the Lean layer does not yet
    deliver the math.
  - 2026-05-18T09:21Z ("for frankl ill accept the one axiom for now
    as long as we have another independent audit and we can be
    EXTREMELY confident that this won't be embarrassing us when
    posted on zulip") — this audit's trigger.
- **Cumulative vacuity-discovery pattern:**
  - `feedback-vacuity-cascade-can-bottom-out` — default-skeptical but
    recognise substance.
  - `mg-82fc` — the audit verdict that the cascade has bottomed out
    at substance.

---

## §9 — Self-audit (polecat-side)

**Did the audit exceed scope?** No. Pure paper-and-pencil, no Lean
code changes. Within the 500k budget envelope; this doc is
substantially under budget.

**Did the audit defend mg-8510's recommendation by default?** No. Per
the explicit ticket hard constraint ("INDEPENDENT — default-skeptical
of mg-8510 even though it's the recommendation being verified;
mg-8510 is hypothesis under test"), the audit:
- Phase A GREEN on the strategic direction (TC-diamond + math
  content) — the substantive parts of mg-8510 hold up.
- Phase B AMBER on the specific axiom prescription — the literal
  (B2) prescription requires additional disclosure to be
  publication-clean.
- Phase C AMBER on the restatement framing — should follow OneThird's
  restate-don't-just-patch pattern more faithfully.
- Phase D AMBER on Zulip-risk — AXIOMS.md disclosure needs OneThird-grade
  depth + an additional collision-disclosure layer not present in
  OneThird.
- Phase E GREEN-WITH-CONDITIONS — revisions to mg-8510's §5a
  prescription enumerated in §5.1.

The audit does NOT just rubber-stamp mg-8510; it identifies a
specific critical issue (the propositional-equivalence-to-Frankl
under the literal (B2) prescription) and prescribes a concrete
revision path.

**Did the audit honour Daniel's "EXTREMELY confident" requirement?**
Yes — Phase D explicitly simulates a Zulip reviewer's read of the
disclosure and identifies the failure mode (axiom + PROVEN collision
= Frankl, looks like "axiomatising Frankl with extra steps") and the
revision (B3 explicit collision-disclosure docstring + OneThird-grade
AXIOMS.md) that brings it back to publication-clean status.

**Did the audit honour the cumulative vacuity-discovery / cascade
bottomed-out-at-substance pattern?** Yes — Phase A acknowledges the
substance is real (TC-diamond verified, math content verified, Lean
encoding incompatibility PROVEN). The AMBER verdicts on Phases B+C+D
are not about *vacuity of the math*; they are about *publication
framing*. The substance is intact; the framing needs work.

**Did the audit consider the "RED" verdict?** Yes briefly. RED would
mean mg-8510's recommendation requires *fundamental revision*, not
just framing adjustments. The Phase A verification confirms the
strategic direction is sound (the (v)+(iv) hybrid IS the right move),
so RED is not warranted. The framing issues are addressable
single-session and do not require revisiting mg-8510's substantive
recommendation.

**Verdict per ticket §"After audit" verdict structure.**

- **GREEN-publication-ready** — would clear mg-1b2b execution. Not
  warranted given the Phase B+C+D AMBER findings.
- **GREEN-with-conditions** — lists specific revisions needed. This
  is the verdict.
- **AMBER** — names specific gap requiring additional work. Could
  fit, but the gaps are addressable inside the mg-1b2b execution
  scope, so GREEN-WITH-CONDITIONS is the tighter classification.
- **RED** — fundamental revision of mg-8510 required. Not warranted.

**Final verdict: GREEN-WITH-CONDITIONS.** The (v)+(iv) hybrid is
sound; the disclosure pivot is the right immediate step; the §5.1
revision list must be applied (in mg-1b2b scope or as a §6
Daniel-decision-routed extension) before the disclosure pivot is
publication-ready.
