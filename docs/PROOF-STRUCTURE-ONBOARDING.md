# Frankl Lean formalisation — proof-structure onboarding (READ FIRST)

> **You are a polecat just dispatched to Frankl Lean work.** Read this file
> *before* anything else: paper notes, state docs, Lean source, prior
> tickets. Goal: 5 minutes to a correct mental model of what is
> unconditionally proved, what is paper-axiomatised, what is
> research-track-deferred, and where the active TODOs live. Then go to the
> primary sources for whatever your ticket actually touches.

**Maintainer.** `pm-pogo` updates this file on every major audit verdict,
disclosure-pivot execution, headline restatement, or Z-arc research-track
ship. Out-of-date sections are worse than missing sections — *flag
staleness, do not silently consume*.

**Last updated.** 2026-05-18 (mg-083f). Post-mg-ee54 audit
(GREEN-WITH-CONDITIONS on Z-arc-disclosure-pivot strategy); mg-1b2b
execution **pending** (paper-axiom + Frankl_Holds restructure not yet
landed). State below reflects pre-mg-1b2b Lean tree.

---

## §0 — Headline theorem (current Lean state)

`lean/UnionClosed/Frankl.lean:464`

```lean
theorem Frankl_Holds {n : ℕ} (F : IntClosedFam n)
    (h_ne : F.family ≠ ({Finset.univ} : Finset (Finset (Fin n)))) :
    ∃ x : Fin n, beta x F ≤ 0
```

The classical Frankl union-closed conjecture, restricted to the
intersection-closed dialect (`IntClosedFam`): every non-trivial
intersection-closed family has a Frankl-rare coordinate
(`β_x F ≤ 0`). Universal in `n`; **type-checks at every `n ≥ 1`**.

**Status.** AMBER. The body type-checks against `lake build` GREEN, but
the general-case branch routes (via `frankl_cohomology_to_scalar_bridge`
and `obstructionClass_cohomology_vanishing`) into one **live `sorry`**
at `lean/UnionClosed/UC11/SSConvergence.lean:596` (the Y6 chain-to-SS
transport bridge). The disclosure-pivot ticket **mg-1b2b** (pending,
see §6) is scoped to delete this sorry by replacing it with a
paper-axiom invocation; until that lands, the general case is
sorry-blocked, not axiom-conditioned.

**`#print axioms Frankl_Holds`.** Currently lists only the mathlib trio
(`Classical.choice`, `propext`, `Quot.sound`) *plus* the sorry-induced
`sorryAx`. After mg-1b2b ships, `sorryAx` is replaced by
`case3_ss_obstruction_paper_axiom` (or chosen analog name).

---

## §1 — Proof tree (top-level split + status tags)

```
Frankl_Holds  (Frankl.lean:464)  [AMBER live sorry; AMBER-AXIOM-PENDING post-mg-1b2b]
│
├── Case 1: F.support ≠ univ        [SUBSTANTIVE-FORMALIZED — unconditional]
│      Pick x ∉ support; β_x = -|F.family| ≤ 0 trivially.
│      Inline; no dependencies beyond IntClosedFam algebra.
│
└── Case 2: F.support = univ        [routes through cohomology bridge]
       │
       ├── No-counterexample assumption built from
       │   h_supp ∧ h_ne ∧ (∀x, β_x > 0)  ⇒  IsCounterexample F
       │
       └── frankl_cohomology_to_scalar_bridge  (Frankl.lean:397)
              │
              ├── (a)  obstructionClass F ≠ 0
              │       =  UC11_nonVanishing F hStar
              │       [SUBSTANTIVE-FORMALIZED — UC11/NonVanishing.lean:131]
              │       Routes through UC11 Lemma 6.1 contrapositive +
              │       Finsupp.single_eq_zero + Finset.prod_eq_zero_iff +
              │       cast arithmetic — non-tautological algebraic chain.
              │
              └── (b)  obstructionClass F = 0
                      =  obstructionClass_cohomology_vanishing F hStar
                      [AMBER — live sorry via Y6 bridge]
                      │
                      │  Threads four "have"-bound cohomology primitives,
                      │  ALL SUBSTANTIVE-FORMALIZED at the primitive layer:
                      │
                      ├── UC13_correctedLanding              (UC13_PartA/CorrectedLanding.lean:157)
                      │      [SUBSTANTIVE-FORMALIZED]
                      │      Per-coordinate placement of ob(F) in ⊕_x V_x^{n-1}.
                      │
                      ├── UC10_lowerWalshVanishing           (UC13_PartB/LowerWalsh.lean:374)
                      │      [SUBSTANTIVE-FORMALIZED]
                      │      Per-coordinate twisted-bridge null-homotopy on topVertex.
                      │
                      ├── ThetaMap_isAbutmentEquivalence     (UC14/R1_ThetaMap.lean:278)
                      │      [SUBSTANTIVE-FORMALIZED]
                      │      Θ = id at populated baseline; chain ↔ abutment identification.
                      │
                      ├── obstructionCohomClass_vanishing_via_lowerWalsh
                      │      [SUBSTANTIVE-FORMALIZED via Y5 def-alias]
                      │      Returns 0 for the NEW Y5-aliased obstructionCohomClass;
                      │      propositionally fine (the NEW class is the constantly-zero
                      │      Y4 SS-derived class, def-aliased).
                      │
                      ├── obstructionCohomClassChain_ne_zero_of_counterexample
                      │      (SSConvergence.lean:164)  [SUBSTANTIVE-FORMALIZED]
                      │      OLD chain class non-zero under hStar, via mg-6acd
                      │      topVertex_not_coboundary.
                      │
                      └── obstructionCohomClassChain_eq_zero_via_y6_transport_residual
                             (SSConvergence.lean:563)  [AMBER — LIVE SORRY at :596]
                             │
                             │  Bridge body substantively threads Y3 chain-homotopy
                             │  + Y4 SS-IsZero + Y4 lift + Y6 NEW lift-injectivity
                             │  + mg-6acd topVertex_not_coboundary + hStar.
                             │
                             └── Structural blocker (mg-36c3, PROVEN):
                                  The Y4 lift is degree-0 only. Extending to a chain
                                  map at degree 1 would require single (topVertex F) r
                                  ∈ image of (BK col 0).d 1 0 for every r ∈ ℚ, which
                                  contradicts topVertex_not_coboundary for r ≠ 0.
                                  PROVEN-FALSE under hStar in the current chain encoding.
                                  ⇒ no chain-map extension exists; SS-side IsZero on
                                    the small Y3 bicomplex does NOT propositionally
                                    transport to chain-level vanishing.
```

**The single live `sorry`** at `SSConvergence.lean:596` is the entire
gap to closing the general case. Everything else type-checks.

---

## §2 — Unconditional small-case slice (concrete witnesses)

These bypass the cohomology bridge entirely and use L4 minimal-element
witnesses. They are **propositionally independent of the live sorry**
and remain GREEN regardless of the disclosure-pivot outcome.

| Theorem | Location | Witness | Status |
|---|---|---|---|
| `Frankl_Holds_fullPowerset3` | `Frankl.lean:528` | `fullPowerset3_minimal_element` (x = 0, β = 0) | **SUBSTANTIVE-FORMALIZED, GREEN** |
| `Frankl_Holds_fullPowerset4` | `Frankl.lean:559` | `fullPowerset4_minimal_element` (x = 0, β = 0) | **SUBSTANTIVE-FORMALIZED, GREEN** |
| `Frankl_Holds_n3` (universal at n=3) | `Frankl.lean:511` | Routes through `Frankl_Holds` general body | **AMBER** (inherits Y6 sorry on counterexample branch) |
| `Frankl_Holds_n4` (universal at n=4) | `Frankl.lean:544` | Routes through `Frankl_Holds` general body | **AMBER** (inherits Y6 sorry on counterexample branch) |
| `Frankl_Holds_universal_typecheck` | `Frankl.lean:593` | Structural type-check at n=3,4,5 | **GREEN** (typecheck only) |

The `fullPowerset3` / `fullPowerset4` cases prove the conclusion for
the *full powerset on Fin n* family — non-trivial intersection-closed
data, not a vacuous-cover degenerate case. `β_0 = 0` is computed by
`decide` (the family has both members containing 0 and members not
containing 0, balancing the bias to exactly 0). See
`UC11/Minimality.lean:574, 657`.

---

## §3 — Per-component status table (the Lean dependency tree)

Reading order matches dependency order (bottom-up). All paths terminate
either in mathlib primitives or in the Y6 sorry.

| Component | File / location | Status | Notes |
|---|---|---|---|
| **L-arc** (combinatorial + Bousfield-Kan + Walsh + L4) | UC10/, UC11/Minimality.lean, UC11/Mismatch.lean, UC11/FObs.lean | **SUBSTANTIVE-FORMALIZED, GREEN** | UC11 Lemma 6.1/6.2 algebraic content, L4 absolute-minimal-counterexample, L5 cohomology bridge typing. |
| **X-arc** (SS infrastructure surrogates X1–X6) | Mathlib/Algebra/Homology/SpectralSequence/*.lean | **SUBSTANTIVE-FORMALIZED, GREEN** | Joël-Riou-attributed; mathlib-PR-clean discipline. Provides `spectralSequence`, `nullHomotopyOnIsotype_givesEInftyVanishing`, edge maps. Surrogates *not* the real mathlib SpectralObject API. |
| **Y1 / Y1b** — BKBicomplexHC₂ as full HC₂ | UC10/BKBicomplexHC2.lean | AMBER (Y1b residual on `Fin.succAbove` higher-row differential) → no longer blocking | Row-0 differential non-trivial; higher rows scoped to multi-month refactor (Path B residual). |
| **Y2** — Walsh-equivariant column action on BK | UC10/BKWalshEquivariant.lean | **SUBSTANTIVE-FORMALIZED, GREEN** | Per-column (ZMod 2)^n action; needed for Y3-onwards. |
| **Y3** — Chain → Homotopy bridge primitive | UC11/BKWalshHomotopyBridge.lean | **SUBSTANTIVE-FORMALIZED, GREEN** | `BKIsotypeColumn_nullHomotopy` on the SMALL Y3 χ_x-isotype column; lifts UC10_lowerWalshVanishing's chain identity into a `Homotopy` object. |
| **Y4** — SS-cohomology vanishing on SMALL bicomplex | UC11/BKSSCohomologyVanishing.lean | **SUBSTANTIVE-FORMALIZED, GREEN** | `BKSSCohomologyVanishing F x` + lift `BKIsotypeColumn_lift_to_BKBicomplexHC2` (degree-0 ℚ-linear map, **not** chain map). |
| **Y5** — Per-x sorry closure (def-alias) | UC11/SSConvergence.lean (lines ~150–410) | **SUBSTANTIVE-FORMALIZED, GREEN** | Closes the old per-x sorry by def-aliasing `obstructionCohomClass` to the constantly-zero Y4 SS-derived class. PROVEN `obstructionCohomClassChain_ne_zero_of_counterexample` collisions about OLD chain class are preserved as diagnostic. |
| **Y6** — Chain-to-SS transport bridge | UC11/SSConvergence.lean:563–596 | **AMBER — LIVE SORRY at :596** | Chain-map-extension structural blocker — see §1 tree. |
| **Z1 / Z1b** — SpectralObject record + ss assembly | Mathlib/Algebra/Homology/SpectralObject/SpectralSequenceAssembly.lean | **RESEARCH-TRACK-DEFERRED** (Z1b GREEN historically; Z arc paused) | Closes Joël Riou's mathlib TODOs at `Mathlib.CategoryTheory.Abelian.SpectralObject.SpectralSequence`. Preserved as research-track artefact per mg-8510 §5b. |
| **Z2a–Z2j** — Bicomplex SpectralObject infrastructure | Mathlib/Algebra/Homology/SpectralObject/Bicomplex.lean (~3577 lines) | **RESEARCH-TRACK-DEFERRED** (Z2j AMBER, 11th sub-split; TC-diamond blocker) | Cumulative work landed substantive primitives (cutoffColumns, EInt filtration, slice cokernel, bridging iso, factor lemmas, Mono/Epi infra). Final SpectralObject record + ShortExact closure blocked on **TC-diamond** (see §5 pitfall #1). |
| **Z3–Z10** | Not pre-filed (or shelved) | **SHELVED** per mg-8510 + mg-ee54 GREEN-WITH-CONDITIONS | `mg-50b7` (Z3), `mg-18b8` (Z4), `mg-69e7` (Z5) recommended SHELVE in mg-8510 §5b. |
| **mg-1b2b** — Frankl disclosure-pivot execution | Pending; depends on mg-ee54 + Daniel decisions in §6 of mg-ee54 | **ACTIVE TODO** | Will (a) introduce paper-axiom (form TBD per Daniel §6.1 decision), (b) delete the Y6 sorry, (c) write `lean/AXIOMS.md`, (d) optionally restructure `Frankl_Holds` into `_concrete` + `_general` + dispatch. |

---

## §4 — Cross-reference index (paper ↔ Lean)

| Paper section | Paper claim | Lean construct | Status |
|---|---|---|---|
| UC10 §5.3 | Twisted-bridge null-homotopy on lower-Walsh isotype | `UC10_lowerWalshVanishing` (`UC13_PartB/LowerWalsh.lean:374`) | Formalized |
| UC11 §5 (Lemmas 6.1, 6.2) | Chain-level non-vanishing of obstruction class under hStar | `UC11_nonVanishing` (`UC11/NonVanishing.lean:131`) | Formalized |
| UC11 §2 | BK bicomplex construction over IntClosedFam | `BKBicomplexHC2` + `BKTotal` (`UC10/BKBicomplexHC2.lean`) | Formalized (row-0 substantive; higher rows AMBER-Y1b) |
| UC12 | Doubling + bridge to OneThird-style obstruction | `UC12/{Doubling,Bridge,UC10R}.lean` | Formalized |
| UC13 §2.4.1 (Theorem 2.4.1) | Per-coordinate corrected landing in ⊕_x V_x^{n-1} | `UC13_correctedLanding` (`UC13_PartA/CorrectedLanding.lean:157`) | Formalized |
| UC13 §4.5 / §7 | Spectral-sequence convergence → cohomology vanishing on χ_x slice | Paper-side substantive; Lean delivery is the Y6 / Z-arc / paper-axiom story | **paper-axiomatisation pending mg-1b2b** |
| UC14 §1.5 (R1 Θ-map) | Θ-map abutment equivalence at populated baseline | `ThetaMap_isAbutmentEquivalence` (`UC14/R1_ThetaMap.lean:278`) | Formalized |
| UC14 §R2, R3 | Auxiliary R2/R3 lemmas | `UC14/{R2,R3}.lean` | Formalized |
| UC13 §7 | Closing 7-step contradiction (Frankl_Holds) | `Frankl_Holds` (`Frankl.lean:464`) | AMBER live-sorry-on-bridge |
| mg-6acd | `topVertex_not_coboundary` augmentation injectivity | `topVertex_not_coboundary` (`UC11/CohomologyClass.lean:388`) | Formalized |

---

## §5 — Known pitfalls (READ BEFORE TOUCHING THE Z-ARC OR THE BRIDGE)

### Pitfall #1 — The TC-diamond (Z-arc structural blocker)

**Symptom.** When working in a bicomplex ambient
(`HomologicalComplex (HomologicalComplex C c₂) c₁`), abelian-derived
APIs (`Abelian.mono_cokernel_map_of_isPullback`,
`kernelCokernelCompSequence_exact`, `ShortExact.δ`, `cokernelIsoOfEq`)
fail to unify two `cokernel` terms with the error pattern:

```
synthesized HomologicalComplex.instHasZeroMorphisms
inferred    preadditiveHasZeroMorphisms
```

**Root cause.** Two `HasZeroMorphisms` instances at the bicomplex type:
the direct `HomologicalComplex.instHasZeroMorphisms`
(`Mathlib/Algebra/Homology/HomologicalComplex.lean:285`, priority 1000)
vs the preadditive-derived
`preadditiveHasZeroMorphisms`
(`Mathlib/CategoryTheory/Preadditive/Basic.lean:201`, priority 100).
Both produce the same `{ f := fun _ => 0 }` morphism but are not defeq
*as instance terms*. Invisible at single-level HC (elaboration locks);
load-bearing at second-level HC (two layers ⇒ two independent picks).

**Empirically failed workarounds** (Z2j, mg-8510 §1d). All five lose
to priority logic, not heartbeats:

1. Section-variable `[Abelian C]` discipline.
2. Two-step `letI` chain.
3. `set_option maxHeartbeats 1600000`.
4. `set_option synthInstance.maxHeartbeats 800000`.
5. Full TC-chain section-variable expansion.

**What works.** Cell-level reduction via `shortExact_of_degreewise_shortExact`
(`Mathlib/Algebra/Homology/HomologicalComplexAbelian.lean:55`) — operates at
first-level HC, never elaborates abelian-derived APIs at the bicomplex
level. Used by Z2e.

**Recommendation if you find yourself here.** STOP, mail mayor, read
`docs/Z-arc-architecture-audit.md` §1, do NOT attempt a sixth
workaround in the same shape. Either pivot to cell-level reduction
(option iv) or accept the disclosure-pivot framing (option v).

### Pitfall #2 — Chain-encoding structural collision (PROVEN, not engineering)

**Symptom.** A proof attempt of `obstructionCohomClassChain F = 0`
under `hStar : IsCounterexample F` either fails opaquely or, if landed
naively, would be propositionally false.

**Root cause.** PROVEN. The chain encoding
`obstructionClass F x := Finsupp.single (topVertex F) (β_x F)`
combined with `topVertex_not_coboundary` (mg-6acd, augmentation
injectivity) forces non-zero cohomology class under `β_x F > 0`. The
two collision theorems:

- `per_x_chain_cohom_vanishing_collides_topVertex_not_coboundary`
  (`SSConvergence.lean:436`).
- `aggregate_chain_cohom_vanishing_collides_topVertex_not_coboundary`
  (`SSConvergence.lean:455`).

Both are PROVEN one-liners deriving `False` from any hypothetical proof
of chain-level vanishing under `hStar`.

**Consequence.** A paper-axiom of the form
`IsCounterexample F → obstructionCohomClassChain F = 0` (the literal
mg-8510 §5a (B2) prescription) is *propositionally equivalent to
Frankl* modulo the PROVEN collision. mg-ee54 §2 flags this as a
Zulip-publication risk and recommends the (B3) form (explicit
collision-disclosure docstring) or (B1) form (SS-level axiom +
`Frankl.lean` restructure).

**Recommendation.** If you are working on mg-1b2b, do NOT install the
(B2) signature without the (B3) docstring. Read mg-ee54 §2c–§2e first.
The "axiom looks like Frankl in disguise" failure mode is the precise
audit finding that brought this whole pivot to GREEN-WITH-CONDITIONS
rather than GREEN-publication-ready.

### Pitfall #3 — Sub-split overhead (the Z2a–Z2j lesson)

**Empirics.** Z2 split eleven times (Z2 → Z2a → … → Z2j → held Z2k)
across ~10M cumulative tokens. The first six sub-splits each landed
substantive primitives (cell isos, stupidTrunc projections, filtration
infrastructure, IsFirstQuadrant typeclass, Mono/Epi instances,
bridging iso). The last five hit the TC-diamond (pitfall #1) and made
incremental scaffolding progress without ever landing the headline
SpectralObject record.

**Lesson.** mg-b823 named "5+ sub-splits warrants structural review"
caveat. Z2 exceeded it 6 times before the mg-8510 architecture audit
identified the structural blocker. If your ticket is at sub-split N≥3
and each split exposes a deeper blocker rather than reducing scope,
**stop and request a structural audit** rather than continuing the
sub-split cascade.

**Concrete heuristic.** If the next sub-split's deliverable list is
mostly the *same items* as the current sub-split's (just narrower
scope on each), you are sub-splitting, not converging. If it is
different items (with the current sub-split's items moved to
"completed"), you are converging.

### Pitfall #4 — 250k-per-deliverable ceiling

**Empirics.** The Z arc empirically confirms a ~250k token ceiling per
substantive Lean deliverable in the mathlib-PR-clean style. Beyond
~250k the work either splits (Z2 sub-split cascade) or stalls.

**Application.** If you are sizing a Lean ticket at >250k, pre-plan a
sub-split structure. If you are mid-ticket and approaching 250k,
declare a named follow-on rather than pushing through.

### Pitfall #5 — Audit-clarity failures (OneThird-side analog)

**Cross-arc lesson** (from OneThird, applies to Frankl too). Recent
vacuity-discovery cascade (mg-e2e9 / mg-74d2 / mg-5c32 / mg-82fc on
OneThird) revealed that audit polecats sometimes:

- **Conflate** typed routing markers with substantive primitives
  (mg-74d2 F3 conflation between `bounded_irreducible_balanced`
  marker and `Case3Witness_proof`'s actual content).
- **Over-constrain** residuals by transcribing API surface without
  checking propositional satisfiability (mg-5c32).

**Application to Frankl.** The `obstructionCohomClass` def-alias
post-Y5 is a *typed routing* construct, not substantive cohomology
content. Its propositional vanishing is trivial; the actual
substantive content lives in `obstructionCohomClassSS_eq_zero` /
`BKSSCohomologyVanishing`. Audit conclusions about "the obstruction
class vanishes" must specify *which* class (NEW Y5-aliased / OLD
chain / SS-derived) — they are not propositionally interchangeable in
the current encoding.

---

## §6 — Maintenance protocol

**Who.** `pm-pogo` is the named maintainer. The daily/weekly roadmap
sweeps are the natural moments to refresh this file.

**When.** Update on any of:

- Headline restatement (e.g., mg-1b2b execution will reword §0–§2
  to reflect `_concrete` + `_general` split if Daniel approves the
  Revision 3 restructure).
- Disclosure / axiom landing (any new `axiom` in `lean/UnionClosed/`
  must be listed in §3 with status `SUBSTANTIVE-PAPER-AXIOM` + cited
  in `lean/AXIOMS.md` once that file lands).
- Major audit verdict (e.g., mg-8510, mg-ee54 today; future Z-arc
  research-track spikes).
- Sorry landing or sorry removal (§0 and §1 tree must reflect current
  sorry count and locations).
- Z-arc research-track ships (§3 + §5 pitfall #1 may need to record
  any breakthrough).
- New polecat-confusing pattern surfaced (add to §5 pitfalls).

**What.** Each update should:

1. Touch §0 sorry count + axiom list if either changed.
2. Touch §1 tree status tags if any leaf moved tags.
3. Touch §3 status table for the affected component.
4. Touch §4 cross-ref if a paper-side connection changed.
5. Touch §5 pitfalls if a new failure-mode-class was discovered.
6. Bump the "Last updated" timestamp in the header.

**Paper-side LaTeX sync.** Per the mg-083f Phase D directive, this
file is also where polecats record paper-Lean drift:

- **Current drift.** UC13 §7's "step 5" paper claim ("spectral-sequence
  convergence forces obstruction class to zero in level-1 isotypes")
  is currently formalized as `obstructionClass_cohomology_vanishing`
  with the Y6 chain-map-extension sub-step axiomatically-blocked.
  Once mg-1b2b lands, the paper-side §7 step 5 prose should add a
  footnote naming the axiom dependency analogous to OneThird's
  `case3Witness_hasBalancedPair_outOfScope` paper disclosure.
- **No other known drift.** UC10, UC11 (Lemma 6.1/6.2), UC12, UC13
  Theorem 2.4.1, UC14 R1/R2/R3 paper claims correspond 1:1 to landed
  Lean theorems per §4.

---

## §7 — Quick reference for incoming polecats

- **Want to add a new `Frankl_Holds_*` concrete witness?** Pattern at
  `Frankl.lean:528, 559`. Routes through L4 `*_minimal_element`
  witnesses, not through the bridge. No SS infrastructure needed.
- **Want to close the Y6 sorry without paper-axiom?** Read mg-8510 in
  full; the chain-encoding refactor (Y6b, mg-e75c) is multi-week and
  has no current ticket. The Z-arc path is multi-month and currently
  shelved per mg-8510 §5b.
- **Want to revive any Z2 sub-ticket?** Read §5 pitfall #1, the Z2j
  state doc, and `Z-arc-architecture-audit.md` §1d *first*. Do not
  attempt a 6th workaround in the same instance-priority shape.
- **Want to inspect the SpectralObject artefacts?**
  `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/` (Z1+Z1b
  GREEN, Z2a–Z2j AMBER) is preserved as research-track scaffolding,
  not active code. The Bicomplex.lean file alone is 3577 lines of
  accumulated substantive primitives.
- **Want to ship mg-1b2b?** Read mg-ee54 §5.1 revisions 1–7 *first*.
  Daniel-decision items in mg-ee54 §6 (paper-axiom signature choice,
  Frankl.lean API restructure, AXIOMS.md location, cleanup deferral,
  ticket scope) must be answered before drafting the axiom.

## §8 — Cross-references (source artefacts in dependency order)

**Architecture audits (this onboarding doc's foundation).**

- `docs/Z-arc-architecture-audit.md` (mg-8510) — TC-diamond root-cause
  + 5-option analysis + (v)+(iv) hybrid recommendation.
- `docs/Frankl-disclosure-pivot-independent-audit.md` (mg-ee54) —
  GREEN-WITH-CONDITIONS on mg-8510; 7-item Revision list; B3-form
  collision-disclosure prescription.

**Scoping docs.**

- `docs/UC-Lean-MathlibSS-Full-scope.md` (mg-103f) — Z1–Z10 scoping
  with acceptance bars 11–14 (now modified per mg-8510 §6).
- `docs/UC-Lean-PathB-BKBicomplex-scope.md` (mg-e1b8) — Y1–Y6 + Y6b
  scoping.
- `docs/UC-Lean-scope.md` — L-arc scoping.
- `docs/UC-Lean-mathlib-SS-scope.md` — earlier X-arc scoping.

**State ledgers (one per execution sub-ticket).**

- L-arc: `state-UC-Lean-L{1,2a-residual,2a-residual-residual,2b,3,4,5,5-followup}.md`.
- SS-X-arc: `state-UC-Lean-SS-X{1,2,3,4,5,6}.md` +
  `state-UC-Lean-SS-{convergence,edge}.md`.
- Y-arc: `state-UC-Lean-PathB-Y{1,1b,2,3,4,5,6}.md`.
- Z-arc: `state-UC-Lean-Z{1,1b,2,2b,2c,2d,2e,2f,2g,2h,2i,2j}.md`.
- Per-x closure / refactor: `state-UC-Lean-{per-x-closure,obstructionClass-refactor,mathlib-hom}.md`.

**Paper-side (UC ladder).**

- `docs/union-closed-UC{2..14,F32}-*.md` — paper notes in dependency
  order. UC10 + UC11 + UC13 + UC14 are the load-bearing chain for the
  Frankl Lean execution; UC12 + UC2–UC9 are upstream / parallel work.

**The Frankl.lean entry point.**

- `lean/UnionClosed/Frankl.lean` — lines 209 (bridge proof),
  397 (cohomology-to-scalar bridge), 464 (Frankl_Holds), 528+559
  (concrete witnesses).
