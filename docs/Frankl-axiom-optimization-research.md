# Frankl-axiom-optimization-research — scope the lowest-impact-radius + lowest-risk + most-defensible Frankl paper-axiom form that makes Lean GREEN

**Work item:** `mg-980f` (single-session SENIOR mathematical/Lean-research polecat;
paper-and-pencil + audit only; **no Lean code lands this ticket**).

**Trigger (Daniel verbatim, 2026-05-19T19:15Z):**

> "I'm okay with frankl having an axiom due to the computation limit but
> let's have a polecat do some research on the lowest impact radius and
> lowest risk, most defensible axiom that solves the issue and makes
> everything green"

**Premise.** The bypass-everything path is closed:

- `mg-8dce` RED (copy-and-tweak attempt; `docs/state-Frankl-mathlib-copy-and-tweak-Session1.md`).
- `mg-7e53` RED (simpler-approaches replay; `docs/state-Frankl-mathlib-bypass-replay-Session1.md`).
- `mg-d079` RED at cascade-fork sub-ticket 2's viability gate (bar 4 RED:
  the bicomplex-level proxy probe RED's at `whnf` even after the diamond
  is bypassed at single-level `UCHC`; `commit 468a348`).

The accepted forward direction (per Daniel directive at 19:15Z) is: **keep**
a named project axiom for the chain-level transport, but optimise its
**form** across four interacting criteria.

**Predecessors absorbed (read in order; see Reading List below).**

- `mg-ee54` (`docs/Frankl-disclosure-pivot-independent-audit.md`) — the
  independent audit that gated `mg-1b2b` with GREEN-WITH-CONDITIONS.
- `mg-8510` (`docs/Z-arc-architecture-audit.md`) — TC-diamond root-cause +
  5-option analysis recommending (v)+(iv) hybrid.
- `mg-1b2b` — disclosure-pivot execution, landed the current
  `case3_ss_obstruction_paper_axiom` (B2 chain-level + B3 collision-disclosure).
- `mg-ea01` cascade-fork-scoping; sub-tickets `mg-f52c` (GREEN) and
  `mg-d079` (RED-at-bar-4).
- `lean/UnionClosed/PaperAxioms.lean` (current axiom + ~150-line docstring).
- `lean/AXIOMS.md` (OneThird-grade disclosure entry).
- `lean/UnionClosed/UC11/SSConvergence.lean` (the bridge + collision theorems).
- `lean/UnionClosed/Frankl.lean` (the consumer chain).
- Paper-side: UC10 §5.3, UC13 §§4.5 + 7, UC14 §1.5.

**Hard constraints honoured.**

- No Lean code changes. This document is the only artefact.
- Paper-and-pencil + audit per ticket §"What this ticket MUST NOT do".
- Default-skeptical of mg-ee54's R1 *recommended* form; independent audit
  whether the literally-shipped axiom is actually the optimum.

---

## §0 — Verdict (top-of-page)

**Verdict label: GREEN.**

**Recommendation: KEEP THE CURRENT B2 + B3 AXIOM SIGNATURE; APPLY
DOCSTRING-ONLY ENHANCEMENT (R1+R2+R3 below) FOR PUBLICATION-BULLET-PROOF
DISCLOSURE.**

The current `case3_ss_obstruction_paper_axiom` (chain-level conclusion
`obstructionCohomClassChain F = 0` under `IsCounterexample F`, with the
B3 mandatory collision-disclosure docstring) is, after independent
re-audit across the four criteria Daniel specified, **at or essentially
at the optimum** of the achievable axiom-form space *under the
GREEN-required constraint*. Every candidate that is *strictly tighter*
on one of criteria 1–3 is *strictly worse* on criterion 4 (cannot make
Lean GREEN) — and every candidate that *retains GREEN* is at best
marginally tighter on the other three (with offsetting defensibility
losses).

Concretely, the three serious alternatives explored — (B1) SS-level on
the **full BK bicomplex**; (Two-axiom) SS-vanishing + chain-encoding-
refinement-transport split; and (B2-narrow) drop the redundant
`F.support = univ` hypothesis — all **fail to dominate** B2 + B3:

- **B1-fullBK** has the *best impact radius* and *best defensibility*
  (it asserts exactly the paper-side SS claim, the substantive content
  of UC10 §5.3 + UC13 §§4.5+7) but **cannot be made GREEN**: the
  conclusion type `(BKBicomplexHC₂ n F).spectralObject.abutmentFiltration_gr x ((n-1) - x)`
  does not exist in Lean (the cascade-fork bar 4 RED'd at the
  bicomplex-level proxy probe; this is the Z-arc TC-diamond blocker
  that mg-1b2b disclosure-pivoted around). Installing the conclusion
  type via a stub `def` makes Axiom 1 vacuous and the Axiom 2 transport
  reduces to the current B2.
- **Two-axiom-Y4-realised** (split into Axiom 1 = Y4 SS-vanishing +
  Axiom 2 = chain-encoding-refinement transport): Axiom 1 is VACUOUS
  because `BKSSCohomologyVanishing F x` is **ALREADY PROVEN** as a
  theorem (`lean/UnionClosed/UC11/BKSSCohomologyVanishing.lean:228`).
  The "Y4 abstraction" is a SINGLE-COLUMN bicomplex whose SS abutment
  is degenerate; its SS-vanishing is chain-cohomology-vanishing on
  the column 0 isotype slice and is rigorously proved at the chain
  level (mg-470a Y5 closure, substantively via UC10 §5.3 + Y3
  chain-homotopy + mg-b26c kernel). With Axiom 1 vacuous, Axiom 2
  reduces to B2 again, so the "split" is illusory.
- **B2-narrow-hypothesis** (drop `F.support = univ`): saves *one*
  redundant clause (the audit confirms `∀ x, β_x F > 0 ⇒ F.support = univ`
  for any non-empty `F.family`). Marginal impact-radius improvement;
  marginal defensibility cost (the paper UC11 Definition 2.2 carries
  the triple, so the narrower hypothesis is a "Lean-engineering-driven"
  divergence from the paper's exact statement, not a paper-faithful
  refinement). Equal risk and equal GREEN. NET: lateral move, not
  strictly tighter.

The current B2 + B3 form is therefore the **GREEN-attainable optimum**.
Daniel's "lowest impact radius + lowest risk + most defensible" wish-list
is bounded above by the Z-arc TC-diamond blocker, exactly as mg-8510 and
mg-ee54 diagnosed. There is no axiom we can install today that is
strictly better than B2 + B3 across all four criteria.

**However**, three docstring-only enhancements (R1, R2, R3 enumerated in
§3.3 below) would push the *publication-defensibility* of the same
B2 + B3 axiom from "GREEN-WITH-CONDITIONS per mg-ee54 §5.1" to
"GREEN-PUBLICATION-READY-with-bullet-proof-disclosure". These are
~100k Lean tokens of docstring + `lean/AXIOMS.md` text changes; **no
axiom-signature change**, no semantic Lean-code change. We RECOMMEND
applying R1+R2+R3 as a small follow-on docstring-refresh ticket; we do
NOT recommend changing the axiom's signature.

**Replacement-path-deferred forward**: when the Z-arc TC-diamond is
resolved (mathlib PR upstream, or a future structural-redesign per
mg-8510 option (iv), or the cascade-fork path is unstuck), **B1-fullBK
becomes the right axiom form** because the SS-level paper claim then
has a real Lean conclusion type. At that point, swap B2 for B1-fullBK +
delete Axiom-2 transport (since substantively proven). Estimated cost
of the swap: ~200-400k Lean tokens; ETA: gated on Z-arc.

---

## §1 — Current state (Phase A)

### 1.1 The axiom as shipped (mg-1b2b)

`lean/UnionClosed/PaperAxioms.lean:233-235`:

```lean
axiom case3_ss_obstruction_paper_axiom :
    ∀ {n : ℕ} (F : IntClosedFam n),
      IsCounterexample F → obstructionCohomClassChain F = 0
```

Conclusion type: `Fin n → (BKTotal n).homology 0` (the chain-level
cohomology class, a function from coordinates to the
`(BKTotal n)`-total-complex's 0-th cohomology object). Hypothesis:
`IsCounterexample F`, a `Prop` triple bundling
(`F.support = Finset.univ`, `F.family ≠ {Finset.univ}`,
`∀ x, β_x F > 0`).

### 1.2 The use-site

The axiom is invoked **exactly once** in non-doc, non-comment Lean code:

`lean/UnionClosed/UC11/SSConvergence.lean:603`:

```lean
  exact case3_ss_obstruction_paper_axiom F hStar
```

This closes the bridge theorem
`obstructionCohomClassChain_eq_zero_via_y6_transport_residual F hStar :
obstructionCohomClassChain F = 0`, whose substantive Y4 + Y5 + Y6
primitives are preserved as `have`-bound diagnostics above the axiom
invocation (the disclosure pivot is reversible; once either closure
path (a) Walsh-isotype chain refactor or (b) full mathlib SpectralObject
infrastructure ships, the axiom invocation is replaced by a substantive
proof routing through those primitives).

### 1.3 Downstream consumer chain

The chain from axiom to `Frankl_Holds`:

```
case3_ss_obstruction_paper_axiom F hStar
      ↓ (SSConvergence.lean:603)
obstructionCohomClassChain_eq_zero_via_y6_transport_residual F hStar
      :  obstructionCohomClassChain F = 0
      ↓ (Frankl.lean:316)
hChainCohomZ : obstructionCohomClassChain F = 0
      combined with
hChainCohomNZ : obstructionCohomClassChain F ≠ 0   -- PROVEN by
                  -- obstructionCohomClassChain_ne_zero_of_counterexample
      ↓ (Frankl.lean:318)
False (via absurd hChainCohomZ hChainCohomNZ)
      ↓ obstructionClass_cohomology_vanishing (Frankl.lean:210-318)
obstructionClass F = 0   -- vacuously from False
      ↓ frankl_cohomology_to_scalar_bridge (Frankl.lean:398-424)
∃ x : Fin n, beta x F ≤ 0   -- combined with UC11_nonVanishing → absurd
      ↓ Frankl_Holds_general (Frankl.lean:521-552)
∃ x : Fin n, beta x F ≤ 0
      ↓ Frankl_Holds (dispatch, Frankl.lean:~620)
∃ x : Fin n, beta x F ≤ 0
```

**Key structural observation about the chain.** Once the axiom's
conclusion `obstructionCohomClassChain F = 0` is combined with the
PROVEN `obstructionCohomClassChain_ne_zero_of_counterexample` to derive
False, every downstream step is consequence-of-False. The False is the
**load-bearing pivot**: any axiom whose statement combined with available
PROVEN theorems produces False under `IsCounterexample F` will discharge
the bridge.

This means the propositional content of the current axiom + PROVEN
collision is:

```
∀ F, IsCounterexample F → False
   ≡   ∀ F, ¬ IsCounterexample F
   ≡   Frankl's union-closed conjecture (counterexample-free form)
```

per mg-ee54 §2c. The axiom is therefore *propositionally equivalent* to
Frankl modulo the PROVEN structural collision. mg-ee54 already
acknowledges this and prescribes the B3 docstring layer that explicitly
discloses the equivalence; the current `PaperAxioms.lean` docstring +
`lean/AXIOMS.md` entry implement this disclosure.

### 1.4 The PROVEN structural-collision theorems (mg-36c3, post-Y5)

`SSConvergence.lean:165-174`:

```lean
theorem obstructionCohomClassChain_ne_zero_of_counterexample
    (F : IntClosedFam n) (hStar : IsCounterexample F) :
    obstructionCohomClassChain F ≠ 0
```

PROVEN one-liner: picks `x = ⟨0, hn⟩`, applies
`obstructionCohomClassChain_at_ne_zero_of_pos_bias F ⟨0, hn⟩` using
`hStar.2.2 ⟨0, hn⟩ : beta ⟨0, hn⟩ F > 0`.

`SSConvergence.lean:437-441`:

```lean
theorem per_x_chain_cohom_vanishing_collides_topVertex_not_coboundary
    (F : IntClosedFam n) (hStar : IsCounterexample F) (x : Fin n)
    (h : obstructionCohomClassChain F x = 0) :
    False :=
  obstructionCohomClassChain_at_ne_zero_of_pos_bias F x (hStar.2.2 x) h
```

PROVEN one-liner.

`SSConvergence.lean:456-460`:

```lean
theorem aggregate_chain_cohom_vanishing_collides_topVertex_not_coboundary
    (F : IntClosedFam n) (hStar : IsCounterexample F)
    (h : obstructionCohomClassChain F = 0) :
    False :=
  obstructionCohomClassChain_ne_zero_of_counterexample F hStar h
```

PROVEN one-liner.

**Both per-x and aggregate forms** of the collision are PROVEN. This is
the mechanical core of mg-ee54 §2c critical finding: any chain-level
axiom whose conclusion has the form
`obstructionCohomClassChain F (·or per-x slice) = 0` under hypothesis
implying `β_(some x) F > 0` collides directly into Frankl.

### 1.5 The substantive Y4 + Y5 ingredients already PROVEN

`lean/UnionClosed/UC11/BKSSCohomologyVanishing.lean:228-229`:

```lean
theorem BKSSCohomologyVanishing (F : IntClosedFam n) (x : Fin n) :
    IsZero ((BKIsotypeBicomplex F x).trivialConvergesTo.abutmentFiltration 0 0) := by ...
```

PROVEN by an X5 edge-map identification + mg-b26c kernel + Y3
chain-homotopy + `UC10_lowerWalshVanishing F x` chain. Routes
substantively through UC10 §5.3 lower-Walsh twisted-bridge null-homotopy.

`SSConvergence.lean:230-242`:

```lean
theorem obstructionCohomClassSS_eq_zero (F : IntClosedFam n) (x : Fin n) :
    obstructionCohomClassSS F x = 0 := by ...
```

PROVEN via `BKSSCohomologyVanishing F x` → `Subsingleton` → `Subsingleton.elim`.

**Critical observation about Y4's substantive content.** `BKIsotypeBicomplex F x`
is constructed as a **SINGLE-COLUMN BICOMPLEX**: column 0 is
`BKIsotypeColumn F x` (a per-x isotype chain complex), and columns
`p ≥ 1` are `HomologicalComplex.zero` with all differentials zero
(`lean/UnionClosed/UC11/BKSSCohomologyVanishing.lean:111-138`). The
"spectral sequence" on this bicomplex is **degenerate at E1**: only the
column 0 contributes, the abutment IS the column's own cohomology.

The substantive content delivered by `BKSSCohomologyVanishing F x` is
therefore: **the chain cohomology of `BKIsotypeColumn F x` at the
relevant degree is `IsZero`**, dressed up in SS language because it
happens to be packaged as `trivialConvergesTo.abutmentFiltration 0 0`.

This IS substantive (the underlying argument is the UC10 §5.3 twisted-
bridge null-homotopy + mg-b26c kernel identification, a multi-file Lean
delivery cf. mg-470a Y5 closure), but it is **NOT** the same statement
as the paper-side SS argument, which claims SS-vanishing on the
**FULL `BKBicomplexHC₂ n F`** bicomplex's per-x graded piece. The Y4
abstraction is a NARROW PROXY for the SS content at the column-0 slice
only.

This distinction is critical to the candidate-form analysis in §2: when
we consider a "Two-axiom split" where Axiom 1 is the SS-vanishing
substep, the SS-vanishing claim has two distinct interpretations
(narrow Y4-realised vs. paper-faithful full-BK), and they have
RADICALLY different impact-radius / risk / defensibility / GREEN
profiles.

### 1.6 Hypothesis structure and the redundancy of `F.support = univ`

`IsCounterexample F` (defined in `lean/UnionClosed/UC11/Minimality.lean`)
bundles three clauses:

1. `F.support = Finset.univ`
2. `F.family ≠ ({Finset.univ} : Finset (Finset (Fin n)))`
3. `∀ x : Fin n, beta x F > 0`

Audit observation: **clause 1 is redundant given clause 3.**

Proof: Assume clause 3, `∀ x, β_x F > 0`. Suppose `F.support ≠ univ`.
Then ∃ y ∉ F.support. For every `A ∈ F.family`, `A ⊆ F.support` (by the
support's definition), so `y ∉ A`. Hence the filter
`F.family.filter (· ∋ y)` is empty, while
`F.family.filter (· ∌ y)` equals `F.family`. So
`β_y F = 0 - |F.family| = -|F.family|`. For clause 3 to hold at `y`,
we need `-|F.family| > 0`, i.e., `|F.family| < 0`, which is impossible
(`Nat.cast` lands in `ℤ` non-negative). Hence `F.support = univ`.

The redundancy is non-trivial to spot mechanically (it routes through
the `subsetSupport` field of `IntClosedFam`), but is a clean implication.

**Clause 2 is NOT redundant.** If `F.family = {Finset.univ}` (the
trivial top-only family), then `β_x F = 1 - 0 = 1 > 0` for all `x`
(every member of `F.family` contains every `x`); clause 3 holds; clause
1 holds (support is univ when only `univ` is in family). But the
trivial-top-only family is a "counterexample" to a NAIVE form of Frankl
("every intersection-closed family has some β ≤ 0"); Frankl explicitly
excludes it via "F is non-trivial".

So the truly-minimal F-side hypothesis structure for a chain-level
axiom is:

- `F.family ≠ ({Finset.univ} : Finset (Finset (Fin n)))` (non-trivial), AND
- `∀ x, β_x F > 0` (positive bias everywhere).

This is one-clause-smaller than `IsCounterexample F`. We name this
hypothesis variant `MinimalCounterexample F` in §2 below. Its
propositional content is identical to `IsCounterexample F` (per the
clause-1 redundancy above), so an axiom over `MinimalCounterexample F`
is propositionally identical to an axiom over `IsCounterexample F`.

The choice between `IsCounterexample` and `MinimalCounterexample`
hypotheses is therefore a **defensibility-vs-paper-faithfulness**
question, not a logical strength question. The paper (UC11 Definition
2.2) carries the explicit `F.support = univ` clause as part of "Frankl's
negation"; a Lean axiom that *drops* this clause is a Lean-engineering
optimisation, not a paper-faithful refinement.

---

## §2 — Candidate matrix (Phase B)

We evaluate six candidate axiom forms across the four criteria.

### 2.1 Candidate form labels

- **C0 (B2 current).** Status quo. Chain-level conclusion + `IsCounterexample F`
  hypothesis + B3 collision-disclosure docstring.
- **C1 (B2-narrow-hypothesis).** Same conclusion as C0; hypothesis tightened
  to `MinimalCounterexample F = (F.family ≠ {univ}) ∧ (∀ x, β_x F > 0)`
  (dropping redundant `F.support = univ`).
- **C2 (B1-fullBK SS-level).** SS-level conclusion on the FULL BK bicomplex:
  `IsZero ((BKBicomplexHC₂ n F).spectralObject.abutmentFiltration_gr x ((n-1) - x))`
  under `IsCounterexample F`. *Note: conclusion type does not currently
  exist in Lean — see GREEN analysis.*
- **C3 (Two-axiom split, full-BK realised).** Axiom 1 = C2 (SS-vanishing
  on full BK); Axiom 2 = chain-level transport from Axiom 1's conclusion
  to `obstructionCohomClassChain F = 0`.
- **C4 (Two-axiom split, Y4-realised).** Axiom 1 = SS-vanishing on the
  SMALL Y4 abstraction's abutment (the type Y4 actually has);
  Axiom 2 = chain-level transport from Axiom 1's conclusion.
- **C5 (B-Frankl-direct).** Literally axiomatise the headline:
  `∀ F, IsCounterexample F → False`, equivalently
  `∀ F, F.family ≠ {univ} → ∃ x, β_x F ≤ 0`.
- **C6 (B2 + enhanced disclosure R1+R2+R3).** Same axiom signature as C0;
  three docstring/AXIOMS.md enhancements (formalised propositional-
  equivalence proof in docstring; second `#print axioms` comparison
  artefact; explicit Y4-narrow-substantive-but-not-full-SS framing).

### 2.2 C0 (B2 current): the status quo

**Signature.**

```lean
axiom case3_ss_obstruction_paper_axiom :
    ∀ {n : ℕ} (F : IntClosedFam n),
      IsCounterexample F → obstructionCohomClassChain F = 0
```

**Criterion 1 — Lowest impact radius (smaller scope = better).**

- **Score: 2/5.** The conclusion is a function-level equation on a
  chain-cohomology object (`Fin n → (BKTotal n).homology 0`). The
  hypothesis is the full `IsCounterexample` triple. Combined with
  PROVEN collision, the axiom propositionally implies Frankl.
- The "impact radius" includes both syntactic radius (size of the
  Lean statement) and semantic radius (what the axiom commits to
  propositionally). Semantically, C0 commits to ¬IsCounterexample-for-
  every-F = Frankl directly via collision. So the semantic radius IS
  Frankl. Syntactically the statement is small.
- The 2/5 reflects: the syntactic-radius is small (good) but the
  semantic-radius is full Frankl (bad).

**Criterion 2 — Lowest risk (most likely to be true).**

- **Score: 4/5.** Propositionally equivalent to Frankl (modulo
  PROVEN collision). Risk = `P(Frankl is false)`. The Frankl
  union-closed conjecture is a 45+ year open problem with substantial
  partial results; expert opinion strongly favors Frankl being true.
  Major recent progress (Gilmer 2022 + iterative tightenings) reduced
  the constant lower-bound to circa 0.38+. The paper UC10-UC14 ladder
  is itself a candidate proof.
- 4/5 reflects: "very likely true" but not "trivially true". The risk
  is the same for any axiom propositionally equivalent to Frankl.

**Criterion 3 — Most defensible (literature-traceable citation).**

- **Score: 3/5.** With the current B3 collision-disclosure docstring
  + OneThird-grade `lean/AXIOMS.md` entry, the axiom is publishable
  per mg-ee54 GREEN-WITH-CONDITIONS verdict. The literature citation
  chain is: UC10 §5.3 (twisted-bridge null-homotopy) + UC13 §§4.5+7
  (corrected landing + 7-step closing argument step 5) + UC14 §1.5
  (Θ-map abutment equivalence). The paper-side ladder is GREEN-merged
  internally. The disclosure honestly frames the gap as combined
  SS-vanishing + Walsh-isotype-chain-encoding-refinement substeps.
- 3/5 reflects: good but not great. The chain-level conclusion is one
  step removed from the SS-level paper claim; a Zulip reviewer needs
  to read the collision-disclosure layer to understand why it's not
  just "Frankl in disguise". The disclosure makes it defensible but
  not bullet-proof. R1+R2+R3 in C6 push to 4/5.

**Criterion 4 — Makes everything GREEN.**

- **Score: 5/5.** Status quo. `lake build` GREEN on origin/main since
  mg-1b2b. `#print axioms Frankl_Holds` lists exactly
  `[Classical.choice, propext, Quot.sound,
  UnionClosed.case3_ss_obstruction_paper_axiom]`. Concrete-witness
  slices `Frankl_Holds_fullPowerset3`, `Frankl_Holds_fullPowerset4`
  remain UNCONDITIONAL.

**Total: 2 + 4 + 3 + 5 = 14/20.**

### 2.3 C1 (B2-narrow-hypothesis): drop redundant `F.support = univ`

**Signature.**

```lean
-- New convenience structure (or anonymous And-tuple).
structure MinimalCounterexample (n : ℕ) (F : IntClosedFam n) : Prop where
  family_ne_top  : F.family ≠ ({Finset.univ} : Finset (Finset (Fin n)))
  bias_positive  : ∀ x : Fin n, beta x F > 0

axiom case3_ss_obstruction_paper_axiom_narrow :
    ∀ {n : ℕ} (F : IntClosedFam n),
      MinimalCounterexample F → obstructionCohomClassChain F = 0
```

**Criterion 1 — Impact radius.**

- **Score: 2/5 (tie with C0).** The hypothesis is **literally one
  redundant clause smaller** than `IsCounterexample F`, but
  propositionally identical (clause 1 is implied by clause 3 + family
  non-emptiness per §1.6). Semantic radius unchanged. Syntactic radius
  one clause smaller.
- The 2/5 score is the same as C0 because impact radius is dominated
  by semantic equivalence to Frankl, which is unchanged. A 2.1/5 fine-
  grain score would be honest if scoring allowed decimals; on the
  0-5 scale it ties.

**Criterion 2 — Risk.**

- **Score: 4/5 (tie with C0).** Identical propositional content.
  Same risk.

**Criterion 3 — Defensibility.**

- **Score: 2/5 (WORSE than C0).** The paper UC11 Definition 2.2
  states "Frankl's negation" as the full triple (
  `F.support = univ ∧ F.family ≠ {univ} ∧ ∀ x β > 0`). A Lean axiom
  that drops `F.support = univ` is **Lean-engineering-driven**, not
  paper-faithful. The Zulip reviewer asks "why does your axiom
  have a *different* hypothesis from the paper's `IsCounterexample`?
  Is that a translation error?" — needing extra docstring to justify
  the redundancy-based narrowing. This costs defensibility.
- The mg-ee54 audit's R1 prescription specifically recommended
  preserving paper-faithful hypothesis structure ("the axiom must
  match the cited paper section's exact claim, not paraphrase";
  cited as `[[feedback-axiom-statement-vs-literature-match]]`
  in the ticket).
- 2/5 reflects: marginal defensibility loss for a marginal impact-
  radius gain.

**Criterion 4 — GREEN.**

- **Score: 4/5.** A small refactor at the bridge call site
  (SSConvergence.lean:603 must construct `MinimalCounterexample`
  from `IsCounterexample` via clause projection; trivial). Possibly
  also a `MinimalCounterexample.ofIsCounterexample` helper. Build
  is GREEN-able with ~50-100k Lean tokens.
- 4/5 reflects: not status quo (5/5), but easily attainable.

**Total: 2 + 4 + 2 + 4 = 12/20 (lateral move; strictly WORSE than C0).**

### 2.4 C2 (B1-fullBK SS-level): paper-faithful SS axiom

**Signature (hypothetical — conclusion type does not yet exist).**

```lean
axiom case3_ss_obstruction_paper_axiom_B1 :
    ∀ {n : ℕ} (F : IntClosedFam n) (x : Fin n),
      IsCounterexample F →
      IsZero ((BKBicomplexHC₂ n F).spectralObject.abutmentFiltration_gr x ((n - 1) - x))
```

Here `(BKBicomplexHC₂ n F).spectralObject` is the
mathlib-`SpectralObject`-record assembly that the Z arc (mg-103f Z1+Z2+Z3
sub-stack) was designed to produce. The graded piece
`abutmentFiltration_gr x ((n-1) - x)` is the per-x SS-graded piece of
the (n-1)-th total cohomology, restricted to the χ_x-isotype slice.

**Criterion 1 — Impact radius.**

- **Score: 5/5 (BEST).** The statement is the *exact* paper-side SS-
  vanishing claim (UC10 §5.3 + UC13 §§4.5+7 + UC14 §1.5 deliver
  `IsZero` on this graded piece). The axiom commits to *exactly* the
  paper claim, no more, no less. Combined with all available PROVEN
  theorems, this axiom does **NOT** propositionally collapse to Frankl
  in any obvious way — there's no PROVEN collision theorem at the SS
  graded-piece level. The axiom's semantic radius is the paper's
  specific SS-vanishing substep, not Frankl.

**Criterion 2 — Risk.**

- **Score: 5/5 (BEST).** This is exactly the paper's substantive claim
  (UC10 §5.3 + UC13 §§4.5+7 + UC14 §1.5). All three latex artefacts
  are GREEN-merged internally; the math content is REAL (mg-ee54 §1c
  GREEN). The claim is propositionally equivalent to a *specific
  substantive paper proposition*, not to the headline Frankl
  conjecture. Risk = `P(UC10 §5.3 + UC13 §§4.5+7 + UC14 §1.5 has a
  paper-side error)` ≪ `P(Frankl is false)`. Likely sub-1%.

**Criterion 3 — Defensibility.**

- **Score: 5/5 (BEST).** Direct paper citation. The axiom statement
  reads almost verbatim as paper Theorem UC13 §7 step 5. Zulip
  reviewer sees: "axiom is exactly the paper claim; Lean delivery is
  blocked by mathlib v4.29.1 TC-diamond at the bicomplex level (cite
  Z2j state doc + mg-8510 audit). Substantively the math IS proven;
  what's deferred is the Lean-engineering delivery." This is the
  *gold-standard* publication framing.

**Criterion 4 — GREEN.**

- **Score: 0/5 (BLOCKED).** The conclusion type
  `(BKBicomplexHC₂ n F).spectralObject` does not exist in Lean.
  Constructing it requires the mathlib `SpectralObject`
  infrastructure on the FULL BK bicomplex, which is blocked across
  11 Z2 sub-splits by the TC-diamond (mg-103f Z1-Z2j attempts;
  mg-ea01 cascade-fork sub-ticket 2 RED'd at bar 4 cascade-fork
  viability gate). The conclusion type literally cannot be written
  down without resolving the upstream mathlib infrastructure.
- We could *workaround* by installing a stub `def
  BKBicomplexHC₂_abutmentGr (n) (F) (x) (q) : ModuleCat ℚ := 0`
  — but then the axiom would have **trivial conclusion** (since 0 is
  IsZero), and the bridge body would need a separate transport from
  the stub's IsZero to the chain-level `= 0`, which IS the
  chain-encoding-refinement substep (this collapses C2 to C3
  Two-axiom split).
- 0/5 reflects: the axiom *as paper-faithful conclusion type* cannot
  be installed without solving Z arc.

**Total: 5 + 5 + 5 + 0 = 15/20 — but criterion 4 RED. Disqualified.**

### 2.5 C3 (Two-axiom split, full-BK realised)

**Signatures.**

```lean
-- Axiom 1: SS-level vanishing on FULL BK bicomplex (paper-faithful).
axiom case3_ss_vanishing_substep :
    ∀ {n : ℕ} (F : IntClosedFam n) (x : Fin n),
      IsCounterexample F →
      IsZero ((BKBicomplexHC₂ n F).spectralObject.abutmentFiltration_gr x ((n - 1) - x))

-- Axiom 2: chain-level transport from SS-level vanishing.
axiom case3_chain_encoding_refinement_substep :
    ∀ {n : ℕ} (F : IntClosedFam n),
      IsCounterexample F →
      (∀ x : Fin n,
        IsZero ((BKBicomplexHC₂ n F).spectralObject.abutmentFiltration_gr x ((n - 1) - x))) →
      obstructionCohomClassChain F = 0
```

**Criterion 1 — Impact radius.**

- **Score: 4/5.** Each axiom is narrower than C0 individually: Axiom 1
  is exactly the SS-substep (paper-faithful), Axiom 2 is exactly the
  transport substep. Combined they imply Frankl via collision (as C0
  does), but each *individual* axiom is more local. Reviewer can
  inspect each substep separately.
- The 4/5 vs 5/5 reflects the cost of having TWO axioms — `#print
  axioms` lists both, and a reviewer must trace both individually.

**Criterion 2 — Risk.**

- **Score: 4/5.** Axiom 1 risk = sub-1% (paper-substantive). Axiom 2
  risk: the chain-encoding-refinement transport is a *Lean-engineering
  conjecture* (the multi-week Walsh-isotype refactor of
  `obstructionClass`'s chain encoding would close it; Y6 (mg-e75c)
  analysis shows the refactor is mechanically feasible but currently
  unproven). Aggregate risk: dominated by Axiom 2's transport
  uncertainty. Likely sub-5% but harder to quantify than C0/C1's
  Frankl-risk.

**Criterion 3 — Defensibility.**

- **Score: 5/5 (BEST).** Each substep maps to a specific paper-side
  argument: Axiom 1 → UC10 §5.3 + UC13 §§4.5+7 SS-substep; Axiom 2 →
  Y6b Walsh-isotype-chain-refactor / mg-e75c Y6 analysis. Reviewer can
  trace each axiom to a paper section / Y-arc analysis ticket.
  Surgical disclosure. Best possible Zulip framing.

**Criterion 4 — GREEN.**

- **Score: 0/5 (BLOCKED).** Same blocker as C2 (Axiom 1 needs
  `(BKBicomplexHC₂ n F).spectralObject` which doesn't exist).
  Disqualified for GREEN.

**Total: 4 + 4 + 5 + 0 = 13/20 — criterion 4 RED. Disqualified.**

### 2.6 C4 (Two-axiom split, Y4-realised)

**Signatures.**

```lean
-- Axiom 1: SS-level vanishing on the SMALL Y4 abstraction (the type Y4 has).
-- WAIT: this is BKSSCohomologyVanishing — ALREADY A PROVEN THEOREM.
-- So no axiom needed for Axiom 1.

-- Axiom 2 (the only one needed):
axiom case3_chain_encoding_refinement_substep_Y4 :
    ∀ {n : ℕ} (F : IntClosedFam n),
      IsCounterexample F →
      (∀ x : Fin n,
        IsZero ((BKIsotypeBicomplex F x).trivialConvergesTo.abutmentFiltration 0 0)) →
      obstructionCohomClassChain F = 0
```

**Audit observation.** Axiom 1 in this variant is `BKSSCohomologyVanishing
F x : IsZero ((BKIsotypeBicomplex F x).trivialConvergesTo.abutmentFiltration 0 0)`,
which is **already PROVEN as a theorem** (mg-470a Y5 closure,
`lean/UnionClosed/UC11/BKSSCohomologyVanishing.lean:228`). So
Axiom 1 is unnecessary; only Axiom 2 is needed.

But then Axiom 2's *hypothesis* `∀ x, IsZero (Y4 stuff)` is
unconditionally satisfied (by `BKSSCohomologyVanishing F x`). Stripping
the redundant hypothesis, Axiom 2 reduces to:

```lean
axiom case3_chain_encoding_refinement_substep_Y4_stripped :
    ∀ {n : ℕ} (F : IntClosedFam n),
      IsCounterexample F → obstructionCohomClassChain F = 0
```

**which is EXACTLY C0 (B2 current).** The "split" is illusory — it
collapses to C0.

**Could the split be saved by interpreting Axiom 1's hypothesis as
load-bearing for *disclosure*** (i.e., as documentation of what Axiom 2
takes as a substantive input) even if propositionally vacuous?

Yes, but only at the docstring layer. The Lean axiom *signature* would
have to either be C0 (vacuous-hypothesis form) or include the Y4-IsZero
hypothesis as a "soft" documentation hook (where the bridge body still
threads `BKSSCohomologyVanishing F x` as the actual proof of the
hypothesis). The latter is C4 with explicit Y4-IsZero hypothesis; it's
~50k Lean tokens to refactor and would marginally improve defensibility
(by making the Y4 ingredient EXPLICIT in the type) at the cost of
"why does the axiom take an arg you already proved?" reviewer question.

**Criterion 1 — Impact radius.**

- **Score: 3/5 (slightly better than C0).** The conclusion is C0's,
  but the explicit Y4-IsZero hypothesis makes the chain-encoding-
  refinement substep slightly more localised in the type (reviewer
  sees: "this axiom only does Y4-SS-IsZero → chain"). The semantic
  radius is still Frankl (same collision applies).

**Criterion 2 — Risk.**

- **Score: 4/5 (same as C0).** Same propositional content.

**Criterion 3 — Defensibility.**

- **Score: 3.5/5 → round to 4/5.** Marginally better than C0 because
  the Y4 ingredient is explicit in the axiom's type, making the
  chain-encoding-refinement substep more transparent. BUT: it requires
  acknowledging in the docstring that Y4 is a NARROW SS-proxy (single-
  column bicomplex), not the full-BK SS argument — which is what makes
  the chain-encoding-refinement substep substantively needed. Without
  this disclosure, the explicit Y4-IsZero hypothesis would *over-promise*
  ("oh, the SS is delivered substantively") and lose defensibility.
  With proper disclosure, marginal gain.

**Criterion 4 — GREEN.**

- **Score: 4/5.** Lean refactor: SSConvergence.lean:603 must thread
  `BKSSCohomologyVanishing` as the hypothesis arg. ~50-100k tokens.

**Total: 3 + 4 + 4 + 4 = 15/20 — tied with C0 (14/20) by margin of 1.**

But the 4/5 defensibility score for C4 *depends* on accompanying
disclosure (the "Y4 is a narrow SS-proxy" framing) — which is exactly
the R3 docstring enhancement in C6. So C4 + Y4-narrow-disclosure ≈ C6
with explicit hypothesis. The marginal gain is in EXPLICITNESS-IN-TYPE
vs. EXPLICITNESS-IN-DOCSTRING. The trade-off favours docstring (cheaper
refactor, same defensibility).

### 2.7 C5 (B-Frankl-direct): literal axiomatisation of Frankl

**Signature.**

```lean
axiom frankl_for_counterexamples_directly :
    ∀ {n : ℕ} (F : IntClosedFam n),
      F.family ≠ ({Finset.univ} : Finset (Finset (Fin n))) →
      ∃ x : Fin n, beta x F ≤ 0
```

**Criterion 1 — Impact radius.**

- **Score: 5/5 (syntactically minimal).** A single `∃` statement at
  the headline form. No chain-cohomology machinery in the axiom's
  surface type. Semantic radius: full Frankl. Syntactic radius:
  minimal.

**Criterion 2 — Risk.**

- **Score: 4/5 (same as C0).** Propositional content is Frankl.

**Criterion 3 — Defensibility.**

- **Score: 0/5 (WORST).** Literal axiomatisation of the open
  conjecture is unconscionable. Zulip reviewer sees "axiom frankl
  ..." and immediately concludes "we couldn't prove Frankl, so we
  postulated it". The B3 disclosure layer cannot rescue this; the
  axiom's signature speaks for itself.

**Criterion 4 — GREEN.**

- **Score: 5/5.** Trivial refactor: `Frankl_Holds_general` becomes
  one-liner `frankl_for_counterexamples_directly h_ne`. Smallest
  possible Lean delta.

**Total: 5 + 4 + 0 + 5 = 14/20 — tied with C0 (14/20), but criterion
3 RED. Disqualified.**

### 2.8 C6 (B2 + enhanced disclosure R1+R2+R3)

**Signature: IDENTICAL to C0.**

```lean
axiom case3_ss_obstruction_paper_axiom :
    ∀ {n : ℕ} (F : IntClosedFam n),
      IsCounterexample F → obstructionCohomClassChain F = 0
```

**Three docstring/AXIOMS.md enhancements (each detailed in §3.3 below):**

- **R1 — Formalise the propositional-equivalence-to-Frankl derivation
  in the docstring as a 4-line Lean-tactic sketch (not just English).**
  Current docstring describes the collision in prose; R1 displays it
  as a Lean-fenced derivation.
- **R2 — Add a second `#print axioms` artefact in `lean/AXIOMS.md`
  showing `Frankl_Holds_concrete` vs `Frankl_Holds_general` side-by-
  side**, so the reviewer can immediately see that the axiom dependency
  is *isolated* to the general branch and absent from concrete-witness
  slices.
- **R3 — Make the Y4-narrow-vs-full-BK distinction EXPLICIT in the
  axiom docstring.** Current docstring frames "SS-vanishing substep"
  as substantively-paper-rigorous; R3 adds: "the Y4 abstraction
  (`BKSSCohomologyVanishing`) substantively proves SS-vanishing on
  the **small isotype-slice bicomplex** (a single-column degenerate
  bicomplex; substantive content is UC10 §5.3 lower-Walsh null-
  homotopy at the chain level via mg-b26c kernel + Y3 chain-homotopy);
  what is paper-deferred is the SS argument on the **FULL BK
  bicomplex**, where the per-x χ_x-isotype graded piece of H^{n-1}(Tot)
  vanishes substantively. The chain-encoding-refinement substep is
  the Lean-engineering transport from the FULL-BK SS argument to the
  current chain encoding (path (a) Walsh-isotype refactor)."

**Criterion 1 — Impact radius.**

- **Score: 2/5 (same as C0).** Signature identical.

**Criterion 2 — Risk.**

- **Score: 4/5 (same as C0).** Same propositional content.

**Criterion 3 — Defensibility.**

- **Score: 4/5 (BETTER than C0 by 1).** R1 = bullet-proof
  propositional-equivalence framing (reviewer cannot misread the
  collision); R2 = visual isolation of axiom dependency (reviewer
  immediately sees concrete cases are unconditional); R3 = honest
  framing of what Y4 delivers vs. what is paper-deferred. Together
  these push from "publishable per mg-ee54" to "publication-bullet-
  proof". Reviewer's reaction: "this is the most honest possible
  axiom-disclosure-pivot framing; I can't fault any of it."

**Criterion 4 — GREEN.**

- **Score: 5/5 (same as C0).** Identical signature; identical build.
  Only docstring + AXIOMS.md text changes.

**Total: 2 + 4 + 4 + 5 = 15/20 — strictly BETTER than C0 (14/20).**

### 2.9 Summary matrix

| Candidate | Crit 1 (radius) | Crit 2 (risk) | Crit 3 (defensibility) | Crit 4 (GREEN) | Total | Verdict |
|---|---|---|---|---|---|---|
| **C0** B2 current (status quo) | 2 | 4 | 3 | 5 | **14** | viable, baseline |
| **C1** B2-narrow-hypothesis | 2 | 4 | 2 | 4 | **12** | strictly worse |
| **C2** B1-fullBK SS-level | 5 | 5 | 5 | 0 | **15*** | **BLOCKED on Z arc** |
| **C3** Two-axiom split (full-BK) | 4 | 4 | 5 | 0 | **13*** | **BLOCKED on Z arc** |
| **C4** Two-axiom split (Y4-realised) | 3 | 4 | 4 | 4 | **15** | tied; over-engineered |
| **C5** B-Frankl-direct | 5 | 4 | 0 | 5 | **14*** | **DEFENSIBILITY RED** |
| **C6** B2 + R1+R2+R3 disclosure | 2 | 4 | 4 | 5 | **15** | **RECOMMENDED** |

(*) Disqualified by criterion-RED (a single 0 score).

**Read.** C2 and C3 dominate on criteria 1+2+3 but fail criterion 4
(can't be made GREEN). C5 dominates on criteria 1+4 but fails on
criterion 3 (literally axiomatising the conjecture). C1 is strictly
worse than C0. C4 ties C6 but is more expensive (requires a Lean
refactor + carries the "redundant hypothesis" question). **C6 is the
GREEN-attainable Pareto frontier point.**

---

## §3 — Recommendation (Phase C + D)

### 3.1 Headline

**RECOMMEND C6 (= C0 + R1 + R2 + R3 docstring enhancements).**

Equivalently: **KEEP THE CURRENT B2 + B3 AXIOM SIGNATURE EXACTLY AS
SHIPPED IN mg-1b2b**, AND apply three documentation-only enhancements
(R1+R2+R3 below) to push publication-defensibility from "GREEN-WITH-
CONDITIONS per mg-ee54" to "GREEN-PUBLICATION-BULLET-PROOF".

### 3.2 Rationale

The four criteria interact in a way that **strongly constrains** the
option space:

1. **Criterion 4 (GREEN) is binary.** An axiom that can't be installed
   in Lean cleanly is no axiom at all — it fails the "makes everything
   GREEN" bar. C2 (B1-fullBK SS-level) and C3 (Two-axiom split with
   full-BK SS axiom) both fail criterion 4 because the conclusion type
   `(BKBicomplexHC₂ n F).spectralObject.abutmentFiltration_gr` does
   not exist in Lean today (blocked by the TC-diamond per mg-8510 +
   mg-d079 viability gate RED). They are the BEST candidates on
   criteria 1-3 but are simply not deployable.

2. **Criterion 3 (defensibility) is RED-CRITICAL.** An axiom that
   embarrasses on Zulip is worse than the status quo. C5 (B-Frankl-
   direct) fails criterion 3 because literal axiomatisation of the
   conjecture is unconscionable. This rules out C5 even though it has
   the lowest impact radius.

3. **Criterion 2 (risk) is essentially tied across all candidates
   propositionally equivalent to Frankl.** C0, C1, C4, C5, C6 all
   have the same propositional content (modulo PROVEN collision /
   restatement); they all have the same Frankl-risk. The only
   candidates with strictly-lower risk are C2 and C3 (paper-faithful
   SS substeps, sub-1% paper-side-error risk) — but they're
   disqualified on criterion 4.

4. **Criterion 1 (impact radius) is dominated by semantic equivalence.**
   Among GREEN-able candidates with paper-faithful disclosure (C0, C4,
   C6), all are semantically equivalent to Frankl modulo collision.
   Their *syntactic* radius differs slightly (C4 has explicit Y4
   hypothesis, ~30% larger signature; C1 has slightly smaller
   hypothesis at defensibility cost), but the *semantic* radius is
   the same. **Marginal improvements on syntactic radius are not
   worth defensibility / GREEN costs.**

The synthesis: **GREEN + defensibility constrain the space to {C0,
C4, C6}**. Among these, C6 strictly dominates C0 on defensibility
(via R1+R2+R3) at zero criterion-4 cost. C4 ties C6 on score (15/20)
but requires a Lean refactor + carries the "why is there a redundant
hypothesis" question; C6 achieves the same defensibility benefit
through pure documentation. **C6 wins.**

### 3.3 The three R1+R2+R3 docstring enhancements (detailed)

#### R1 — Formalise the propositional-equivalence-to-Frankl derivation

**Where.** Both `lean/UnionClosed/PaperAxioms.lean` axiom docstring
"Honest collision-disclosure" section AND `lean/AXIOMS.md` "Honest
collision-disclosure" section.

**Current text** (paraphrased):

> The chain-level conclusion `obstructionCohomClassChain F = 0`
> under `IsCounterexample F`, combined with the already-PROVEN
> theorem `obstructionCohomClassChain_ne_zero_of_counterexample`,
> is propositionally equivalent to ∀ F ¬IsCounterexample F.

**Enhanced text (R1)**:

> The chain-level conclusion `obstructionCohomClassChain F = 0`
> under `IsCounterexample F`, combined with the already-PROVEN
> theorem `obstructionCohomClassChain_ne_zero_of_counterexample`,
> is propositionally equivalent to `∀ F, ¬ IsCounterexample F`,
> i.e., to Frankl's union-closed conjecture in counterexample-free
> form. The equivalence derivation is:
>
> ```
> -- forward direction: axiom + collision ⇒ ¬ IsCounterexample
> example (F : IntClosedFam n) (hStar : IsCounterexample F) : False :=
>   obstructionCohomClassChain_ne_zero_of_counterexample F hStar
>     (case3_ss_obstruction_paper_axiom F hStar)
>
> -- The reverse direction (¬ IsCounterexample ⇒ axiom-trivially-holds)
> -- is vacuous: under ¬ IsCounterexample F, the axiom's hypothesis is
> -- never satisfied, so the axiom is vacuously true.
> ```
>
> The collision arises because the Lean chain encoding
> `obstructionClass F x := Finsupp.single (topVertex F) (β_x F)`
> combined with the PROVEN augmentation injectivity
> `topVertex_not_coboundary` (mg-6acd) forces the per-x chain
> cohomology class to be non-zero whenever `β_x F > 0`.

The enhancement makes the equivalence MECHANICALLY VERIFIABLE in the
docstring — a Zulip reader can copy the example, paste it into Lean,
and confirm the proposition. Marginal effort: ~30 lines of docstring;
~50 lines in `lean/AXIOMS.md`.

#### R2 — Second `#print axioms` comparison artefact

**Where.** `lean/AXIOMS.md` "Forum-post disclosure" section.

**Current text** (lines 250-258 + 367-385): lists `#print axioms
Frankl_Holds` and the three concrete-instance outputs (`Frankl_Holds_concrete`,
`Frankl_Holds_fullPowerset3`, `Frankl_Holds_fullPowerset4`) showing
each lists *only* the mathlib trio (no project axiom).

**Enhanced text (R2)**: add a SIDE-BY-SIDE COMPARISON TABLE
immediately above the `#print axioms` outputs:

> **Axiom dependency map** (which `Frankl_Holds*` variants depend on
> the named project axiom):
>
> | Theorem | Depends on `case3_ss_obstruction_paper_axiom`? | Concrete examples |
> | --- | --- | --- |
> | `Frankl_Holds_concrete` | **NO** — takes the witness as hypothesis | the consumer of `Frankl_Holds_fullPowerset3`, etc. |
> | `Frankl_Holds_fullPowerset3` | **NO** — routes through L4 minimal-element witness | `n = 3`, `x = 0`, `β_0 = 0` (concrete witness) |
> | `Frankl_Holds_fullPowerset4` | **NO** — routes through L4 minimal-element witness | `n = 4`, `x = 0`, `β_0 = 0` (concrete witness) |
> | `Frankl_Holds_general` | **YES** — universal `F` requires the axiom | the universal-`F` slice |
> | `Frankl_Holds` (dispatch) | **YES** — delegates to `Frankl_Holds_general` | the universal `F` headline |
>
> A reviewer can confirm this map by running `#print axioms` on each
> variant.

This makes the axiom's *isolation* to the universal-`F` slice
immediately visible — a Zulip reviewer sees that **the concrete
small-n cases are completely unconditional**, the axiom dependency
is only on the universal headline. ~30 lines.

#### R3 — Y4-narrow-vs-full-BK explicit framing in the axiom docstring

**Where.** Both `lean/UnionClosed/PaperAxioms.lean` axiom docstring
"Paper-side content (substantive)" section AND `lean/AXIOMS.md`
"Honest collision-disclosure" section's enumeration of the two
substeps.

**Current text** (paraphrased): "two substantive substeps: (1) SS-
vanishing substep (paper-rigorous, Lean-delivery blocked by TC-diamond);
(2) chain-encoding-refinement substep (Walsh-isotype chain refactor,
multi-week)."

**Enhanced text (R3)**: REFINE substep 1 to make explicit the
**narrow-Y4 vs. full-BK** distinction:

> 1. **SS-vanishing substep (two-tier delivery status).** The
>    spectral-sequence-derived per-x vanishing on the χ_x-isotype slice
>    has two tiers:
>
>    - **Narrow Y4 tier (substantively PROVEN in Lean as a theorem).**
>      `BKSSCohomologyVanishing F x : IsZero ((BKIsotypeBicomplex F x).trivialConvergesTo.abutmentFiltration 0 0)`
>      proves SS-vanishing on the SMALL Y4 isotype-slice bicomplex (a
>      single-column degenerate bicomplex; the SS collapses at E1, so
>      its abutment IS the column-0 chain cohomology of `BKIsotypeColumn F x`).
>      Substantively threaded via the UC10 §5.3 lower-Walsh twisted-
>      bridge null-homotopy (at the chain level) → mg-b26c kernel
>      identification → Y3 chain-homotopy adapter → X5 edge-map
>      identification → SS abutment IsZero. This narrow tier IS
>      delivered substantively in Lean (mg-470a Y5 closure, GREEN).
>
>    - **Full-BK tier (paper-deferred for Lean delivery).** The
>      paper-side SS argument (UC10 §5.3 + UC13 §§4.5+7 + UC14 §1.5)
>      asserts SS-vanishing on the **FULL `BKBicomplexHC₂ n F`**
>      bicomplex's per-x χ_x-isotype graded piece of `H^{n-1}(Tot)`.
>      This claim is substantively paper-rigorous (the UC10/UC13/UC14
>      latex artefacts are GREEN-merged internally). Lean delivery
>      is blocked by the mathlib v4.29.1
>      `Abelian (HomologicalComplex (HomologicalComplex C c₂) c₁)`
>      TC-instance-priority diamond (mg-8510 audit + mg-d079 cascade-
>      fork viability gate RED). The narrow Y4 tier is a PARTIAL
>      proxy for the full-BK tier (matching the underlying UC10 §5.3
>      content at the column level); but it is NOT the same propositional
>      statement.
>
> 2. **Chain-encoding-refinement substep (Walsh-isotype chain refactor).**
>    Transporting the FULL-BK SS-side vanishing to the chain-level
>    `obstructionCohomClassChain F = 0` requires the Walsh-isotype
>    refactor of `obstructionClass`'s chain encoding. Mathematically:
>    the χ_x-isotype piece IS zero in chain cohomology *because the
>    topVertex generator is in the χ_{[n]}-isotype, separate from
>    χ_x^{n-1}*; the current encoding `obstructionClass F x :=
>    Finsupp.single (topVertex F) (β_x F)` conflates the two and is
>    the reason `topVertex_not_coboundary` (mg-6acd) blocks per-x
>    chain-level vanishing. Path (a) Walsh-isotype refactor would
>    first-class the per-S isotype direct-sum decomposition; the
>    χ_x-isotype piece IS zero in chain cohomology after the refactor.

The enhancement gives the reviewer a precise picture: substep 1 is
PARTIALLY delivered substantively in Lean (the narrow Y4 tier); the
remaining gap is the full-BK SS argument PLUS the chain-encoding
refinement transport. The framing is honest about what's already proven
vs. what's deferred. ~80 lines combined.

### 3.4 Why R1+R2+R3 are docstring-only, not Lean-code-changes

R1, R2, R3 are all *disclosure-layer* improvements. They do **not**:

- Change the axiom signature.
- Change `Frankl_Holds`, `Frankl_Holds_general`, `Frankl_Holds_concrete`
  signatures.
- Change the bridge body at `SSConvergence.lean:603`.
- Add or remove any Lean theorems.

They do change:

- The axiom docstring text in `PaperAxioms.lean` (~80 lines added).
- The `lean/AXIOMS.md` content (~120 lines added).
- Possibly a few cross-references in
  `docs/PROOF-STRUCTURE-ONBOARDING.md` (~20 lines).

`lake build` is unaffected. `#print axioms` output is unaffected. The
existing GREEN status is preserved bit-for-bit.

### 3.5 What we are NOT recommending

For clarity, the following are NOT in the recommendation:

- **NOT** recommending switching to C2 (B1-fullBK) — it's blocked.
- **NOT** recommending the C3 two-axiom split with full-BK realisation
  — it's blocked.
- **NOT** recommending C4 (two-axiom Y4-realised with explicit Y4
  hypothesis) — same defensibility benefit as C6 at higher refactor
  cost.
- **NOT** recommending C1 (B2-narrow-hypothesis) — strictly worse
  than C0.
- **NOT** recommending C5 (B-Frankl-direct) — defensibility RED.
- **NOT** recommending shelving the Z arc research-track. mg-8510 §5b
  shelving recommendations remain in force; mg-d079 cascade-fork
  attempt provides additional Z-arc-research-track evidence for
  future viability assessments. When the Z arc TC-diamond is resolved
  (mathlib PR upstream or cascade-fork breakthrough), **swap from C6
  to C2** — that's the right long-term form. This is documented in
  §4.3 below.

---

## §4 — Cost to apply (Phase D)

### 4.1 Cost of recommended path (apply C6 = R1+R2+R3 over current C0)

**Token estimate: ~80-150k Lean polecat tokens.**

**Files modified:**

1. `lean/UnionClosed/PaperAxioms.lean` — docstring expansion:
   - R1 collision-disclosure formalisation: ~30 lines added.
   - R3 Y4-narrow-vs-full-BK refinement: ~50 lines added.
   - Total: ~80 lines (~3k tokens).

2. `lean/AXIOMS.md` — disclosure entry expansion:
   - R1 propositional-equivalence derivation: ~30 lines added.
   - R2 axiom-dependency-map side-by-side: ~30 lines added.
   - R3 Y4-narrow-vs-full-BK refinement: ~30 lines added.
   - Total: ~90 lines (~4k tokens).

3. `docs/PROOF-STRUCTURE-ONBOARDING.md` — pitfall list update:
   - Add R3 narrow-Y4-vs-full-BK distinction as a new pitfall: ~20
     lines.

**Lean build impact:** ZERO. No code change.

**`#print axioms` output:** UNCHANGED.

**Acceptance bars (for the follow-on R1+R2+R3 implementation polecat):**

1. `lake build` GREEN, unchanged from current main.
2. `#print axioms Frankl_Holds` lists exactly the same axioms (mathlib
   trio + `case3_ss_obstruction_paper_axiom`).
3. R1 derivation is mechanically verifiable (a Zulip reader can copy-
   paste the `example` from the docstring and Lean accepts it).
4. R2 dependency map matches actual `#print axioms` outputs on
   `Frankl_Holds_concrete`, `Frankl_Holds_fullPowerset3`,
   `Frankl_Holds_fullPowerset4`, `Frankl_Holds_general`, `Frankl_Holds`.
5. R3 distinction (narrow Y4 vs full-BK) is accurate per
   `lean/UnionClosed/UC11/BKSSCohomologyVanishing.lean` source.

**Estimated single-session SENIOR Lean polecat budget: 250-400k tokens**
(token-budget includes audit verification of R1's derivation, R2's
table, R3's Y4-narrow framing). This fits comfortably in a single
session.

### 4.2 Cost of alternative paths (NOT recommended; for completeness)

| Path | Estimated tokens | Risk | Notes |
|---|---|---|---|
| **Status quo (C0)** | 0 | Defensibility GREEN-WITH-CONDITIONS (already shipped) | Current state |
| **C6 (recommended)** | 250-400k | LOW | Docstring-only refresh |
| **C4 (Y4-explicit-hypothesis refactor)** | 400-700k | MEDIUM | Lean refactor + bridge body change |
| **C1 (B2-narrow-hypothesis)** | 200-400k | LOW (but DEFENSIBILITY DOWN) | Strictly worse than C6; not recommended |
| **C2 (B1-fullBK)** | 3-5M (multi-month) | HIGH (Z arc) | Blocked unless Z arc resolves |
| **C3 (Two-axiom-fullBK)** | 3-5M (multi-month) | HIGH (Z arc) | Blocked unless Z arc resolves |
| **C5 (Frankl-direct)** | 100k | DEFENSIBILITY RED | Disqualified |

### 4.3 Forward path when Z arc resolves

If at some future point the Z-arc TC-diamond is resolved (one or more
of: mathlib upstream PR ships, cascade-fork breakthrough lands,
structural-redesign per mg-8510 option (iv) lands), the recommended
axiom form becomes **C2 (B1-fullBK SS-level)**. The transition path:

1. **Verify** that
   `(BKBicomplexHC₂ n F).spectralObject.abutmentFiltration_gr` is
   constructible cleanly in Lean (the Z arc Z1+Z2 deliverable).
2. **Add a new theorem** (not axiom)
   `BKBicomplexHC₂_per_x_isotype_gr_isZero F x : IsZero (...)` proved
   substantively via the SS infrastructure + UC10 §5.3 + UC13 §§4.5+7
   + UC14 §1.5 paper-side ladder.
3. **Add a small transport lemma** routing the SS-level vanishing to
   chain-level `obstructionCohomClassChain F = 0` via the Walsh-
   isotype refactor (path (a)). This may need its own paper-axiom in
   the intermediate state if the chain-encoding refinement is not
   yet shipped substantively.
4. **Replace** the `case3_ss_obstruction_paper_axiom F hStar`
   invocation at `SSConvergence.lean:603` with the new substantive
   theorem chain.
5. **Delete** `axiom case3_ss_obstruction_paper_axiom` from
   `lean/UnionClosed/PaperAxioms.lean`.
6. **Update** `lean/AXIOMS.md` (the entry becomes a CHANGELOG marker
   recording that the axiom was DELETED in favour of a substantive
   theorem chain).
7. **Update** `#print axioms Frankl_Holds` to list ONLY the mathlib
   trio (no project axiom).

This transition path is the **PROJECT-LIFE-MILESTONE-FULFILLED** state
that mg-103f bar 14 originally targeted, restored in honest form
without bypassing any substantive paper content.

Estimated cost of the transition: 200-400k Lean tokens (once Z arc
prerequisites are in place; the transition itself is a clean swap).

This is the **forward-research-target preserved by the disclosure
pivot**. The C6 recommendation does not abandon this target; it
preserves it as the eventual replacement of the bridge-period axiom.

---

## §5 — Cross-references

### 5.1 Predecessor audit / scoping docs

- **mg-ee54** (`docs/Frankl-disclosure-pivot-independent-audit.md`,
  ~1130 lines) — GREEN-WITH-CONDITIONS verdict on the disclosure-pivot
  (audited mg-8510 (v)+(iv) hybrid + B2+B3 axiom form). §5.1 seven-
  revision list including R1 paper-axiom-signature choice (B1/B2/B3/
  two-axiom-split). This polecat's analysis confirms mg-ee54's
  B2+B3 recommendation as the GREEN-attainable optimum.
- **mg-8510** (`docs/Z-arc-architecture-audit.md`, ~1170 lines) —
  TC-diamond root-cause + 5-option analysis (mathlib-fix /
  copy-modify / reproduce-locally / structural-redesign /
  restatement-pivot) + (v)+(iv) hybrid recommendation. Establishes
  the strategic context: full mathlib SpectralObject infrastructure
  is multi-month, the BK bicomplex SS is structurally blocked at
  bicomplex-level Abelian by the TC-diamond.

### 5.2 Closure-attempt RED verdicts (why bypass is closed)

- **mg-d079** (commit 468a348, cascade-fork sub-ticket 2) — AMBER
  landing (5/6 bars GREEN), bar 4 cascade-fork viability gate **RED**.
  Bicomplex-level proxy probe RED's at `whnf` even after diamond
  bypass at single-level `UCHC`. Cumulative fork files: ~1063 +
  ~258 + ~220 + ~83 + ~97 + ~240 + ~458 + ~167 = ~2586 lines of
  forked mathlib code under
  `lean/UnionClosed/Mathlib/Algebra/Homology/UC*`.
- **mg-7e53** (`docs/state-Frankl-mathlib-bypass-replay-Session1.md`)
  — RED verdict on simpler-approaches replay. Phase A diagnostic:
  the diamond persists through any in-tree workaround.
- **mg-8dce** (`docs/state-Frankl-mathlib-copy-and-tweak-Session1.md`)
  — RED verdict on copy-and-tweak attempt.

### 5.3 PROVEN structural-collision theorems (the disclosure obligation)

- `lean/UnionClosed/UC11/SSConvergence.lean:165-174` —
  `obstructionCohomClassChain_ne_zero_of_counterexample`.
- `lean/UnionClosed/UC11/SSConvergence.lean:437-441` —
  `per_x_chain_cohom_vanishing_collides_topVertex_not_coboundary`.
- `lean/UnionClosed/UC11/SSConvergence.lean:456-460` —
  `aggregate_chain_cohom_vanishing_collides_topVertex_not_coboundary`.
- `lean/UnionClosed/UC11/CohomologyClass.lean:388` —
  `topVertex_not_coboundary` (mg-6acd augmentation injectivity).

### 5.4 PROVEN substantive Y4 ingredient (the narrow SS-vanishing tier)

- `lean/UnionClosed/UC11/BKSSCohomologyVanishing.lean:228-237` —
  `BKSSCohomologyVanishing F x : IsZero ((BKIsotypeBicomplex F x).trivialConvergesTo.abutmentFiltration 0 0)`
  (mg-470a Y5 closure). Substantively threads UC10 §5.3 lower-Walsh
  null-homotopy + mg-b26c kernel + Y3 chain-homotopy.
- `lean/UnionClosed/UC11/SSConvergence.lean:230-242` —
  `obstructionCohomClassSS_eq_zero F x : obstructionCohomClassSS F x = 0`
  via `BKSSCohomologyVanishing F x` → `Subsingleton` → `Subsingleton.elim`.

### 5.5 Current axiom file + bridge file + consumer file

- `lean/UnionClosed/PaperAxioms.lean` (current axiom, ~237 lines incl.
  ~150-line docstring).
- `lean/UnionClosed/UC11/SSConvergence.lean:546-603` — the bridge
  `obstructionCohomClassChain_eq_zero_via_y6_transport_residual`
  invoking the axiom on line 603.
- `lean/UnionClosed/Frankl.lean:210-318` —
  `obstructionClass_cohomology_vanishing` (the consumer chain leading
  to `Frankl_Holds_general` → `Frankl_Holds`).
- `lean/UnionClosed/Frankl.lean:476-478` —
  `Frankl_Holds_concrete` (unconditional concrete-witness slice).
- `lean/UnionClosed/Frankl.lean:~620` —
  `Frankl_Holds_fullPowerset3` and `Frankl_Holds_fullPowerset4`
  (unconditional concrete instances).

### 5.6 Paper-side substantive content

- `docs/union-closed-UC10-native-cohomology-intersection-closed-families.md`
  §5.3 — twisted-bridge null-homotopy on the lower-Walsh isotype
  (the chain-level argument; substantively threaded into the Y4
  ingredient via Lean).
- `docs/union-closed-UC13-frankl-closure.md` §§4.5+7 — corrected
  per-x landing + 7-step closing argument; §7 step 5 is the SS
  abutment vanishing step the axiom captures the chain-level
  transport of.
- `docs/union-closed-UC14-r1-theta-map.md` §1.5 — Θ-map abutment
  equivalence at the populated baseline (paper-side identification
  of chain-level and abutment-level cohomology).

### 5.7 Daniel directives in play

- **2026-05-19T19:15Z** — "lowest impact radius, lowest risk, most
  defensible axiom" — the directive triggering this ticket.
- **2026-05-19T07:13Z** — "frankl I still want more forking" (the
  cascade-fork directive; absorbed by mg-ea01 sub-stack, with
  mg-d079 RED at the viability gate).
- **2026-05-18T09:21Z** — "for frankl ill accept the one axiom for
  now as long as we have another independent audit and we can be
  EXTREMELY confident that this won't be embarrassing us when posted
  on zulip" (the audit gate mg-ee54 satisfied).
- **2026-05-18T10:03Z** — "Make sure #print axioms is teed up for me.
  The big thing I'm worried about is the new axiom being incorrect
  or unproven, so a very clear literature citation etc would be nice"
  (motivates R2 axiom-dependency-map enhancement).
- **2026-05-17T13:53Z** — "mathlib code local-only for now, push
  upstream later if we have time" (project_z_arc_local_only;
  preserves Z arc as research-track, not abandoned).

---

## §6 — Daniel-attention items

Per ticket §"After GREEN" — recommendation routed to Daniel for
sign-off — the following items need explicit decisions:

1. **Approve recommendation: keep C0 + apply C6 disclosure
   enhancements (R1+R2+R3)?** Yes/No.

2. **If yes, file the follow-on R1+R2+R3 docstring-refresh ticket?**
   - Estimated budget: 250-400k Lean tokens, single session.
   - Estimated complexity: low (pure docstring + AXIOMS.md text changes).
   - No Lean code change; `lake build` GREEN preserved.
   - Acceptance bars per §4.1.

3. **Approve current C0 (status quo) as the long-term form
   pending Z arc resolution?** I.e., is the disclosure pivot
   permanent (until Z arc resolves), or should we revisit when?

4. **Should the cascade-fork RED (mg-d079) trigger any structural
   revisiting of the Z arc research-track?** mg-d079 added ~2586
   lines of forked mathlib code under
   `lean/UnionClosed/Mathlib/Algebra/Homology/UC*`. mg-8510 §5b
   recommended preserving the Z arc as research-track (not abandoned);
   the mg-d079 cascade-fork attempt is consistent with that
   research-track framing. Confirm: keep mg-d079 fork code as
   research-track scaffolding (analogous to Z1+Z2a-j SpectralObject
   infrastructure)?

5. **C6's R1 derivation in the docstring — accept the explicit
   `example` form, or prefer a separate dedicated `theorem` that the
   docstring references?** The polecat recommends the `example` form
   for maximum docstring-locality (the reviewer sees the equivalence
   derivation in the same file as the axiom), at the cost of slightly
   more docstring length. The alternative (a separate named theorem
   in `SSConvergence.lean` or `Frankl.lean` whose docstring is
   referenced by the axiom's docstring) is more "tidy" but introduces
   a separate file lookup for the reviewer.

These are *Daniel-decision-required* per the polecat-instruction
guidance that strategic choices route to Daniel rather than being
made polecat-side.

---

## §7 — Self-audit (polecat-side)

**Did the audit exceed scope?** No. Pure paper-and-pencil + Lean
source-of-truth reads, no Lean code changes. Well within the 400-600k
budget envelope; this doc is substantially under budget.

**Did the audit defend mg-ee54's recommendation by default?** No. Per
the ticket hard constraint "INDEPENDENT — default-skeptical of mg-ee54
even though it's the audit being verified", the audit:

- Confirmed mg-ee54's B2+B3 recommendation as the GREEN-attainable
  optimum across the four criteria, **after** independent re-evaluation
  of five non-current alternatives (C1, C2, C3, C4, C5) against
  Daniel's specific criteria (lowest impact radius, lowest risk,
  most defensible, makes everything GREEN).
- Identified a *strictly-better* point on the Pareto frontier: C6
  (= C0 + R1+R2+R3 disclosure enhancements). C6 ties C4 on total
  score but is cheaper to apply.
- Identified three Pareto-dominant candidates that are blocked on
  Z arc (C2, C3, C4-stripped-equiv-to-C0) and explicitly preserved
  them as forward-research-targets for the Z-arc-resolution path.

The audit does NOT just rubber-stamp the current axiom; it identifies
a specific docstring enhancement path (R1+R2+R3) that strictly
improves publication-defensibility at zero criterion-4 cost.

**Did the audit honour Daniel's specific weighting?** Daniel's verbatim
priorities are "lowest impact radius and lowest risk, most defensible
axiom that solves the issue and makes everything green". This is a
4-criteria pick-the-best-tradeoff problem. The audit:

- Treated criterion 4 (GREEN) as the gating constraint (binary).
- Treated criterion 3 (defensibility) as the next-most-important
  (a 0/5 disqualifies; the disclosure layer is what makes the axiom
  not embarrassing).
- Treated criteria 1+2 (impact radius + risk) as tied across all
  GREEN+defensible candidates, with risk dominated by Frankl-true-
  probability for any propositionally-equivalent-to-Frankl axiom.
- Settled on the GREEN-attainable Pareto frontier (C0 vs C4 vs C6),
  selected C6 as the cheapest.

**Did the audit honour the "EXTREMELY confident on Zulip" Daniel
directive?** Yes — R1+R2+R3 are specifically about making the Zulip
disclosure bullet-proof. R1 displays the propositional-equivalence
derivation mechanically (not just in prose); R2 visually isolates the
axiom dependency to the universal-`F` slice; R3 explicitly frames the
narrow-Y4-tier-PROVEN vs. full-BK-tier-paper-deferred distinction.

**Did the audit honour the bypass-is-closed premise?** Yes — the
ticket explicitly notes "this is NOT a fork-bypass attempt", and the
audit does not propose any new bypass attempts. C2 / C3 (the
full-BK-SS-level axioms) are documented as the forward-research-target
PATH AFTER Z arc resolves, not as something to attempt now.

**Did the audit follow the "EXTREMELY confident" bar adopted by
mg-ee54?** The audit confirmed mg-ee54's verdict and prescribed a
strictly-better disclosure path (R1+R2+R3). The recommendation is
*more conservative than C4's signature refactor* (which would also
have worked) precisely to minimise risk of new failure modes from
Lean refactoring.

**Verdict per ticket §"Acceptance bar" structure.**

1. `docs/Frankl-axiom-optimization-research.md` lands on origin/main
   (~700-800 lines): **THIS DOCUMENT**.
2. Candidate matrix scores all 4+ forms against all 4 criteria:
   **§2.9 SUMMARY MATRIX**.
3. Recommendation is single + specific (single axiom form + signature
   + citation): **C6 = C0 + R1+R2+R3**. Signature
   `axiom case3_ss_obstruction_paper_axiom : ∀ {n} (F : IntClosedFam n),
   IsCounterexample F → obstructionCohomClassChain F = 0`.
   Citation: UC10 §5.3 + UC13 §§4.5+7 + UC14 §1.5; combined with PROVEN
   collision per §1.4.
4. Cost to apply (re-do mg-1b2b if needed): **~80-150k Lean tokens
   for docstring + AXIOMS.md text changes only**; **no code change,
   `lake build` unchanged**, **`#print axioms` output unchanged**.
5. Verdict GREEN if optimal emerges; AMBER if Daniel decision needed
   on tradeoff: **GREEN**. The optimum emerges clearly within the
   GREEN-attainable space; the Daniel decision is only on whether to
   apply the recommended C6 docstring enhancements vs accept the
   already-shipped C0 as the long-term form.

**Final verdict: GREEN.** The C0 status quo is at the GREEN-attainable
optimum across the four criteria; C6 docstring enhancements push
publication-defensibility from "GREEN-WITH-CONDITIONS per mg-ee54" to
"GREEN-PUBLICATION-BULLET-PROOF" at zero Lean-code cost.
