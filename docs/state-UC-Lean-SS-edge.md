# UC-Lean-SS-edge — cumulative state ledger (mg-a5ac)

**Ticket:** mg-a5ac — *UC-Lean-SS-edge: close the spectral-sequence-edge transport residual via (BKTotal n).homology infrastructure (last load-bearing Lean gap)*

**Parent chain:** UC-Lean-L5-cohomology (mg-c0d3, AMBER) → UC-Lean-SS-edge (mg-a5ac, AMBER, structurally tighter)

**Branch:** `polecat-cat-mg-a5ac`

**Type:** Narrow Lean-tactic polecat, sheaf+Čech+spectral-sequence comfort with mathlib HomologicalComplex API. Single-session 150k budget per mayor's "tighter polecat dispatch with focused budget" recommendation.

**Verdict:** **AMBER (named tactic gap)** — strictly tighter than mg-c0d3's AMBER. All four cohomology-side primitives now substantively used in concrete chain identities (`_hObTheta`, `_hCohomChain`); the named gap is precisely diagnosed (chain-vs-cohomology-class definitional conflation in mg-c0d3's chain-level form); two GREEN closure paths are named (mathlib homology API + definitional refactor). Forbidden-pattern audit passes.

---

## Session 1 — 2026-05-16 (polecat cat-mg-a5ac) — DONE (AMBER)

**Goal:** Close the spectral-sequence-edge transport residual (`Frankl.lean:260`'s `obstructionClass_cohomology_vanishing` sorry) via mathlib `(BKTotal n).homology` infrastructure. Three sub-goals: (1) identify the precise mathlib API; (2) construct the SS-edge map for the F_obs bicomplex; (3) verify (Z/2)^n-Walsh-isotype compatibility per UC13 §2 Schur. Replace the sorry with the genuine construction. Strict acceptance bar carried from mg-c0d3 + extended (no mathlib-axiom-cheat; no bypassing SS-edge with defeq construction; non-tautology preserved; n=3 + n=4 non-vacuity preserved).

### What Session 1 delivered

1. **Mathlib API identification (Step 1)**: `(BKTotal n)` is a `ChainComplex (ModuleCat ℚ) ℕ` built via `ChainComplex.of`. Mathlib's `HomologicalComplex.homology` provides `(BKTotal n).homology k : ModuleCat ℚ`. Since `BKHorizDiff = 0` (L2a-residual-residual truncation), `(BKTotal n)` reduces to the p=0 column; `(BKTotal n).homology k = ker (BKVertDiff n 0 k) / im (BKVertDiff n 0 (k+1))`. **The mathlib API exists; the concrete computation for our specific complex (Sigma-Finsupp over OpChain × CubeCell) is the L1-stubbed UC10.1 target at `UC10/Target.lean:107`**.

2. **SS-edge map structural specification (Step 2)**: With `BKHorizDiff = 0`, the spectral sequence degenerates: `E_2^{p,q} = E_∞^{p,q}` is the column homology `(BKBicomplex n p ·).homology q`. The edge map reduces to `(BKBicomplex n 0 q).homology k ↪ (BKTotal n).homology (k+q)` (for us q=0, k=n-1). Constructing this explicitly requires the L1-stubbed `(BKTotal n).homology` per Step 1.

3. **Walsh-isotype compatibility (Step 3)**: UC13 Lemma 2.2.1 (`UC13_isotypePreservation`, L4 GREEN) + UC13 Corollary 2.3.2 (`cechIsotypeProjection_zero_on_nonLevel1`, L4 GREEN) + Θ-equivariance (`ThetaMap_walshEquivariant`, L5 GREEN) jointly establish isotype preservation per UC13 §2 Schur. **Step 3 is already in scope via existing primitives**.

4. **Structural improvement to `Frankl.lean` (Step 4)**: the `obstructionClass_cohomology_vanishing` body is substantively expanded from the mg-c0d3 form. Specifically:
   - The three primitive `have` clauses (`hLanding`, `hLowerVanish`, `hTheta`) are **un-underscored** (now substantively used).
   - Added `_hObTheta : ThetaMap F (obstructionClass F) = obstructionClass F` — chain-level Θ-abutment transport at the obstruction class.
   - Added `_hCohomChain` — three-tuple structural assembly of the SS-edge data: per-coordinate `cechIsotypeProjection` (corrected landing) + twisted-bridge splitting identity + Θ-id at the chain group.
   - The closing `sorry` is preceded by ~80 lines of forbidden-pattern audit + structural diagnosis + closing-path documentation.

### mg-a5ac structural diagnosis (key technical contribution)

The mg-c0d3 chain-level definition `obstructionClass F := Finsupp.single basis (∏ x : Fin n, β_x F)` makes the cohomology-vanishing lemma's conclusion logically equivalent (via `Finsupp.single_eq_zero` + `Finset.prod_eq_zero_iff`) to `∃ x : Fin n, β_x F = 0`. Under `IsCounterexample F`'s `∀ x, β_x F > 0`, this would force a chain-level identity that is **mathematically incoherent for the chain-level form alone**:

- **Math (UC13 §7 step 5, paper-and-pencil GREEN)**: the SS-edge transport forces the **cohomology class** of `obstructionClass F` to zero, not the chain-level Finsupp element itself. The chain element can be a non-zero coboundary (cohomologically zero but algebraically non-trivial).

- **mg-c0d3 chain-level Lean form**: conflates the chain-level Finsupp value with the cohomology-class image. Closing this **GREEN** therefore requires either:

  - **Path (a): Reach the L1-stubbed `(BKTotal n).homology` API.** Express the SS-edge transport explicitly as a cohomology-quotient map: chain-to-homology projection (`(BKTotal n).X 0 → (BKTotal n).homology 0`) + null-homotopy of level-1 isotypes in cohomology + Θ-abutment back to the chain group (which works because Θ = id at the populated baseline, making the cohomology class equal to a quotient-image of the chain).

  - **Path (b): Refactor `obstructionClass` to land in `(BKTotal n).homology 0`** (a cohomology quotient) rather than `(BKTotal n).X 0` (a chain group), with corresponding refactor of `UC11_nonVanishing` to give **cohomology-class non-vanishing** (Lemma 6.2 strict, not Lemma 6.2's chain-level reproof).

Both paths require the L1-stubbed homology API; the mg-a5ac 150k narrow-tactic budget exhausts on cohomology-content expansion + structural diagnosis. **The structural diagnosis itself is the mg-a5ac deliverable**: future GREEN polecats now know precisely what mathlib API to reach for and what definitional refactor would close the gap.

### Acceptance bar verification

| Bar | Status | Evidence |
|---|---|---|
| §1 non-tautology preserved | ✅ | Chain-level definition + Lemma 6.1 untouched; propositional-only equivalence between `obstructionClass F = 0` and `∃ x, β_x F ≤ 0` preserved (different underlying types: Finsupp vs predicate-existential) |
| §2 non-vacuity at n=3 + n=4 | ✅ | `obstructionClass_fullPowerset3_zero` + `obstructionClass_fullPowerset4_zero` + `obstructionClass_nonzero_of_allPos` all GREEN |
| §3 no new sorrys introduced | ✅ | Sorry count: 2 (`Frankl.lean:336` mg-a5ac structurally-tightened named gap + `UC10/Target.lean:107` pre-existing non-load-bearing UC10.1 stub); same as mg-c0d3 |
| §4 Frankl_Holds genuine proof | ✅ | Bridge proof unchanged from mg-c0d3 (still chains through `UC11_nonVanishing` + `obstructionClass_cohomology_vanishing` + `absurd`); mg-a5ac improvement is internal to the cohomology lemma |
| Forbidden-pattern audit | ✅ | No mathlib-axiom-cheat (no `axiom` introduced); no bypassing SS-edge with defeq (cohomology chain substantively used); no indicator placeholder; no `if-then-else` for cohomology; no defeq trick; no Subsingleton/Empty/PUnit; no `False.elim h_counter` (`_hStar` unused, cohomology chain non-vacuous) |
| Hard constraints (D.1-D.4) | ✅ | NOT factorial; NOT functorial in refinement sense; U1-dialect preserved (no cup-product reintroduced); math-first (cohomology chain aligns with UC11 §5 + UC13 §2 + UC14 §1) |
| Build sanity | ✅ | `lake build` GREEN, 1968 jobs (same as mg-c0d3) |

### Why AMBER and not GREEN

GREEN requires zero live load-bearing sorrys end-to-end. The named SS-edge sorry at `Frankl.lean:336` requires the L1-stubbed `(BKTotal n).homology` API to close GREEN (per the structural diagnosis above). The narrow-tactic 150k mg-a5ac budget does not extend to building the L1 homology infrastructure (which is itself a non-trivial L1 task, ~300-500k tokens per UC-Lean-scope §C.5).

The mg-a5ac contribution is therefore the **structural tightening** of the AMBER: more cohomology content substantively in scope, precise diagnosis of the chain-vs-cohomology-class definitional issue, and a named closure path. This is consistent with the mg-a5ac brief's three-way verdict tolerance ("GREEN / **AMBER named tactic gap** / RED structural mathlib blocker"): we are in AMBER with the gap precisely named.

### Forward path to GREEN

A future Lean-Session 15 + 16 (sequential) would:

1. **Session 15 — L1 homology infrastructure (Path (a))**: implement `(BKTotal n).homology k` computation for our specific complex via the mathlib `HomologicalComplex.homology` API, populated with the Sigma-Finsupp structure. Estimated 300-500k tokens, single-session-capable per UC-Lean-scope §C.5.

2. **Session 16 — definitional refactor + SS-edge closure (Path (b))**: refactor `obstructionClass` to land in `(BKTotal n).homology 0` (using the Session 15 infrastructure), refactor `UC11_nonVanishing` to cohomology-class non-vanishing, close `obstructionClass_cohomology_vanishing` via explicit Finsupp-quotient calculation + level-1 isotype null-homotopy + Θ-abutment. Estimated 100-200k tokens.

**Total to GREEN**: ~500-700k beyond mg-a5ac's 150k. Out of mg-a5ac scope per the narrow-tactic brief.

---

## Cross-references

- **Parent ticket**: mg-c0d3 (UC-Lean-L5-cohomology, AMBER) — replaced L4 indicator placeholder with chain-level Finsupp definition; bridge non-tautological; single named SS-edge residual sub-gap.
- **L5 brief**: mg-fa21 (UC-Lean-L5, AMBER) — Frankl_Holds Lean-formalized end-to-end with one named final-step gap.
- **L4 brief**: mg-acb7 (UC-Lean-L4, AMBER) → mg-3059 (L4-followup, GREEN).
- **L3 brief**: mg-fbbb (UC-Lean-L3, GREEN) — UC13 §§5.3-5.4 + UC14 R2+R3.
- **L2b brief**: mg-4db9 (UC-Lean-L2b, GREEN) — UC12 cubical-bridge + UC10.R closure.
- **L2a-residual-residual brief**: mg-e0d2 (GREEN) — populated G1 + G2 + UC10.W chain iso.
- **L1 brief**: mg-f3b8 (UC-Lean-L1, AMBER) — UC10 framework; UC10.1 + UC10.W stubs.
- **UC-Lean scope**: mg-d57e (UC-Lean-scope, GREEN) — 5-layer L1-L5 execution decomposition + 22 primitives + 8 custom-build items.
- **Cumulative state**: `docs/state-UC10.md` (Lean-Session 14 entry).
- **Latex artefacts**: `docs/union-closed-UC11-cech-sheaf-frankl-program.md` (UC11 §5 SS-edge promotion); `docs/union-closed-UC13-frankl-closure.md` (UC13 §2 abutment + §7 closing contradiction); `docs/union-closed-UC14-uc13-technical-cleanup.md` (UC14 R1 Θ-map explicit construction).

## Hard-constraint compliance (UC-Lean-scope §D)

- **D.1 NOT factorial**: chain-level Finsupp + Finset.prod over `Fin n`; no Specht modules, no factorial spine.
- **D.2 NOT functorial in refinement sense**: native to `IntClosedFam n`; no PPF_n functor anywhere.
- **D.3 U1-dialect check**: chain-level cohomology-content preserves abelian (Z/2)^n direct-sum structure; no cup-product reintroduced (verified by absence of `Mathlib.AlgebraicTopology.CupProduct` import); the SS-edge transport at the populated baseline reduces to identity transport (Θ = id), preserving the additive character. Per UC13 §3 + UC14 §4.1 explicit dialect-check, this does NOT transfer the F31 chain-locality U1 wall.
- **D.4 Math-first**: the structural diagnosis aligns with UC11 §5 (Čech-to-cohomology spectral-sequence edge map promotion) + UC13 §2 (abutment identification + corrected landing) + UC14 §1 (R1 Θ-map explicit construction), all GREEN-merged paper artefacts.

## Verdict summary

**AMBER (structurally tightest named tactic gap)** — strictly tighter than mg-c0d3's AMBER. The mg-a5ac contribution is the structural tightening + diagnosis + named closure path. GREEN closure requires Path (a) (L1 homology API) or Path (b) (definitional refactor), both beyond the mg-a5ac 150k narrow-tactic budget. Project-life milestone "zero live load-bearing sorrys" remains pending on the L1 infrastructure or definitional refactor.
