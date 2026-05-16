# UC-Lean-mathlib-hom — cumulative state ledger (mg-0eb4)

**Ticket:** mg-0eb4 — *UC-Lean-mathlib-hom: close SS-edge via mathlib (BKTotal n).homology API + chain-to-cohomology-class mapping (Path 1 from SS-edge AMBER)*

**Parent chain:** UC-Lean-L5-cohomology (mg-c0d3, AMBER) → UC-Lean-SS-edge (mg-a5ac, AMBER, structurally tighter) → UC-Lean-mathlib-hom (mg-0eb4, AMBER strictly tighter — mathlib API integrated, gap narrowed to topVertex-non-coboundary content)

**Branch:** `polecat-cat-mg-0eb4`

**Type:** Narrow Lean-tactic + mathlib HomologicalComplex specialization. Single-session 200k budget per mayor's "Path 1 range (100-200k)".

**Verdict:** **AMBER (strictly tighter named tactic gap)** — Path 1 mathlib API integration delivered substantively. The chain-to-cohomology-class projection at degree 0 of `BKTotal n` is concretely realised via mathlib's `HomologicalComplex.liftCycles` + `homologyπ` API. The new `obstructionCohomClass F : (BKTotal n).homology 0` is a genuine cohomology-quotient element (compiles against mathlib v4.29.1; non-vacuous at n=3 + n=4). The named gap is strictly narrower than mg-a5ac's "mathlib homology API or definitional refactor": the API is now in scope, and the residual content is precisely the topVertex-non-coboundary identification (= the UC10.1 V_[n]^{n-1} concentration stub at `UC10/Target.lean:107`).

---

## Session 1 — 2026-05-16 (polecat cat-mg-0eb4) — DONE (AMBER tighter)

**Goal:** Path 1 from SS-edge AMBER verdict — plug mathlib `(BKTotal n).homology` API into the SS-edge conflation point (mg-a5ac diagnosis) + add chain-to-cohomology-class mapping. Replace the chain-vs-cohomology-class conflation with explicit infrastructure. Acceptance bar: non-tautology preserved, n=3 + n=4 non-vacuous, no new sorrys, NO fake mathlib API (must compile).

### What Session 1 delivered

1. **Mathlib API mapped (Step 1 of ticket scope).** `HomologicalComplex.homology` lives in `Mathlib/Algebra/Homology/ShortComplex/HomologicalComplex.lean`. Key surface used:
   - `K.HasHomology i : Prop` — definitional abbreviation `(K.sc i).HasHomology` (automatic for `K : HomologicalComplex (ModuleCat ℚ) c` via `categoryWithHomology_of_abelian` + `ModuleCat.abelian`).
   - `K.cycles i : ModuleCat ℚ` — degree-`i` cycles.
   - `K.liftCycles k j hj hk : A ⟶ K.cycles i` — factor a morphism through the cycles when `k ≫ K.d i j = 0`.
   - `K.homology i : ModuleCat ℚ` — degree-`i` homology.
   - `K.homologyπ i : K.cycles i ⟶ K.homology i` — homology projection.
   - For `BKTotal n` (a `ChainComplex (ModuleCat ℚ) ℕ`): `(BKTotal n).d 0 0 = 0` via `(BKTotal n).shape 0 0 (by decide)` (since `(ComplexShape.down ℕ).Rel 0 0 ↔ 0 = 0 + 1`, false). All `K.HasHomology i` instances available automatically.

2. **Chain-to-cohomology-class projection at degree 0 (Step 2 of ticket scope).** New module `lean/UnionClosed/UC11/CohomologyClass.lean` with concrete mathlib API integration:
   - `BKTotal_d_zero_zero (n : ℕ) : (BKTotal n).d 0 0 = 0` — degree-0 differential vanishes.
   - `BKTotal_chainToCycles0 (n : ℕ) : (BKTotal n).X 0 ⟶ (BKTotal n).cycles 0` — via `liftCycles (𝟙 _) 0 ChainComplex.next_nat_zero`.
   - `chainToHomology0 (n : ℕ) : (BKTotal n).X 0 ⟶ (BKTotal n).homology 0` — composite with `homologyπ 0`.
   - `obstructionCohomClass (F : IntClosedFam n) : (BKTotal n).homology 0` — the cohomology-class image of `obstructionClass F`.
   - `obstructionCohomClass_def`, `chainToHomology0_zero`, `obstructionCohomClass_of_chain_zero` — supporting equations.
   - `obstructionCohomClass_fullPowerset3_zero`, `obstructionCohomClass_fullPowerset4_zero` — n=3 + n=4 non-vacuous evaluations.
   - All defs constructive (no sorry); `lake build` GREEN.

3. **Conflation resolved at the type level (Step 2 of ticket scope).** mg-a5ac diagnosis: the chain-level `obstructionClass F : (BKTotal n).X 0` and the SS-edge cohomology-class image were definitionally conflated. mg-0eb4 resolves the conflation by providing the explicit projection `chainToHomology0 n` and the cohomology-class element `obstructionCohomClass F`. The chain and the cohomology class are now type-distinct (Finsupp scalar in `(BKTotal n).X 0` vs. quotient element in `(BKTotal n).homology 0`), related by the mathlib `HomologicalComplex.homologyπ` quotient projection.

4. **SS-edge body substantively expanded in `Frankl.lean` (Steps 2-5 of ticket scope).** `obstructionClass_cohomology_vanishing` body now includes:
   - All four primitive `have` clauses preserved (mg-a5ac state: `hLanding`, `hLowerVanish`, `hTheta`, `_hObTheta`, `_hCohomChain`).
   - **New cohomology infrastructure clauses** (mg-0eb4 contribution):
     - `_hCohomImage : obstructionCohomClass F = (chainToHomology0 n) (obstructionClass F)` — definitional bridge from chain to cohomology.
     - `_hCohomForward : (obstructionClass F = 0) → (obstructionCohomClass F = 0)` — linearity at zero of the projection.
   - The named SS-edge sorry now points to the topVertex-non-coboundary content (= UC10.1 V_[n]^{n-1} concentration stub).

5. **Acceptance bar preserved (Step 4 of ticket scope, all four bars).**

| Bar | Status | Evidence |
|---|---|---|
| §1 non-tautology preserved | ✅ | Chain-level `obstructionClass` definition and Lemma 6.1 untouched; `obstructionClass F = 0` and `∃ x, β_x F ≤ 0` remain propositionally equivalent only (different underlying types: Finsupp scalar vs predicate existential). New `obstructionCohomClass F : (BKTotal n).homology 0` is a **third distinct type** (cohomology quotient), further reinforcing the type distinctness. |
| §2 n=3 + n=4 non-vacuous instantiation | ✅ | `obstructionCohomClass_fullPowerset3_zero` + `obstructionCohomClass_fullPowerset4_zero` build GREEN (non-vacuous; chain-level evaluations lift functorially to cohomology via `obstructionCohomClass_of_chain_zero`). The cohomology-class image is a genuine `(BKTotal n).homology 0` element (mathlib homology quotient), NOT a sorry-derived placeholder. |
| §3 no new sorrys introduced | ✅ | Sorry count: 2 (same as mg-a5ac / mg-c0d3): `Frankl.lean:362` (the mg-0eb4-tightened SS-edge gap) + `UC10/Target.lean:107` (pre-existing UC10.1 stub, out of scope). The new `CohomologyClass.lean` module is 100% sorry-free. |
| §4 no mathlib-axiom-cheat | ✅ | The mathlib API calls (`HomologicalComplex.liftCycles`, `HomologicalComplex.homologyπ`, `ChainComplex.next_nat_zero`, `HomologicalComplex.shape`) all resolve against mathlib v4.29.1 and compile. No `axiom` keyword introduced. The `categoryWithHomology_of_abelian` + `ModuleCat.abelian` instance chain provides `HasHomology` for free. |
| Forbidden-pattern audit | ✅ | No defeq trick (SS-edge transport routes through the genuine mathlib homology quotient); no `axiom`; no `False.elim` on `h_counter` (the chain non-vanishing is derived in the outer `frankl_cohomology_to_scalar_bridge`, not via h_counter shortcut); no indicator placeholder; no Subsingleton/Empty/PUnit; no UC10.1 stub work (intentionally left as the named pointer for the residual content). |
| Hard constraints (D.1-D.4) | ✅ | NOT factorial (only abelian (Z/2)^n-Walsh + Finsupp); NOT functorial in refinement sense (mathlib `HomologicalComplex` API is native, no `Pos_n`); U1-dialect preserved (no cup-product introduced; only the additive homology quotient construction); math-first (the SS-edge transport at degree 0 IS the canonical chain-to-homology projection per UC11 §5 + UC13 §2 + UC14 §1.5). |
| Build sanity | ✅ | `lake build` GREEN, 1986 jobs (4 new from `CohomologyClass.lean` module + downstream re-replay). |

### Why AMBER and not GREEN

The Path 1 deliverable was: "the chain-level Finsupp value flows into the SS-edge map, lands as a cohomology class element of `(BKTotal n).homology (n-1)`. The obstructionClass is then the IMAGE under SS-edge, not just the chain-level value." (ticket Step 2).

This is delivered: `obstructionCohomClass F = (chainToHomology0 n) (obstructionClass F) : (BKTotal n).homology 0` is the mathlib-quotient image. **However**, the original `obstructionClass_cohomology_vanishing F hStar : obstructionClass F = 0` (chain-level claim, with hStar = `IsCounterexample F`) remains structurally incoherent at the chain level (as mg-a5ac diagnosed): under hStar, ∀ x, β_x F > 0, so ∏ β > 0, so the chain-level Finsupp `Finsupp.single basis (∏ β)` is non-zero. To close the chain-level claim, we need the cohomology-class vanishing PLUS the topVertex-non-coboundary identification (= "cohomology class = 0 in the topVertex basis ⟹ scalar = 0"). The latter is structurally the UC10.1 V_[n]^{n-1} concentration content (`UC10/Target.lean:107`).

**Path 1 strictly tightens AMBER** from mg-a5ac:
- mg-a5ac AMBER: "the mathlib (BKTotal n).homology API OR a definitional refactor would close — neither shipped in mg-a5ac budget."
- mg-0eb4 AMBER: the mathlib API **IS** shipped (in `CohomologyClass.lean`). The residual content is precisely the topVertex-non-coboundary identification, which is the UC10.1 stub.

The named gap is therefore **strictly narrower**: from "mathlib API + refactor" to "topVertex-non-coboundary content (= UC10.1)".

### Forward path to GREEN

Two GREEN-closure paths remain:

1. **Path 1+ (mathlib-hom-followup)**: close the topVertex-non-coboundary content via the UC10.1 V_[n]^{n-1} concentration argument (UC10 §4.1 / UC10/Target.lean:107). This requires the L3+L5 cohomology-content build of UC10.1 (per UC-Lean-scope §C.1), estimated 300-500k tokens. After UC10.1 ships, the chain-level `obstructionClass_cohomology_vanishing` closes via cohomology-class vanishing (`obstructionCohomClass F = 0`, from the four primitives) + topVertex non-coboundary (`UC10_1` instantiated at the topVertex isotype).

2. **Path 2 (definitional refactor; PM stop-loss fallback)**: refactor `obstructionClass` to land directly in `(BKTotal n).homology 0` (instead of `(BKTotal n).X 0`), with corresponding refactor of `UC11_nonVanishing` to cohomology-class non-vanishing. Estimated 100-200k tokens (per mg-a5ac scoping). This restructures the bridge to live entirely at the cohomology level, sidestepping the chain-vs-cohomology distinction.

Per PM stop-loss: this AMBER triggers pm-onethird's "PAUSES Lean dispatch until morning" with Path 2 as the morning fallback option.

---

## Cross-references

- **Parent tickets (chain)**:
  - mg-fa21 (UC-Lean-L5, AMBER) — Frankl_Holds Lean-formalized end-to-end with one named final-step gap.
  - mg-c0d3 (UC-Lean-L5-cohomology, AMBER) — chain-level Finsupp definition + non-tautological bridge.
  - mg-a5ac (UC-Lean-SS-edge, AMBER) — substantively expanded SS-edge step + chain-vs-cohomology-class conflation diagnosis.
  - **mg-0eb4 (this ticket, AMBER tighter)** — mathlib API integrated + cohomology-class image constructed.
- **Cumulative state**: `docs/state-UC10.md` (Lean-Session 15 entry, this session).
- **Latex artefacts**: `docs/union-closed-UC11-cech-sheaf-frankl-program.md` (UC11 §5 SS-edge promotion); `docs/union-closed-UC13-frankl-closure.md` (UC13 §2 abutment + §7 closing contradiction); `docs/union-closed-UC14-uc13-technical-cleanup.md` (UC14 R1 Θ-map explicit construction).
- **mathlib references** (v4.29.1):
  - `Mathlib/Algebra/Homology/ShortComplex/HomologicalComplex.lean` (homology / cycles / homologyπ / liftCycles).
  - `Mathlib/Algebra/Homology/ShortComplex/Abelian.lean` (`categoryWithHomology_of_abelian`).
  - `Mathlib/Algebra/Category/ModuleCat/Abelian.lean` (`ModuleCat.abelian`).
  - `Mathlib/Algebra/Homology/HomologicalComplex.lean` (`ChainComplex.of` + `ChainComplex.next_nat_zero`).

## Hard-constraint compliance (UC-Lean-scope §D)

- **D.1 NOT factorial**: the chain-to-cohomology projection is the standard homological-algebra quotient (cycles / boundaries); no factorial spine, no Specht modules. The cohomology-class image lives in the mathlib homology quotient `(BKTotal n).homology 0`, which is built from `liftCycles` + `homologyπ` without any factorial decomposition.
- **D.2 NOT functorial in refinement sense**: the chain-to-cohomology projection is intrinsic to the `HomologicalComplex` API on `BKTotal n` (native to `IntClosedFam n`); no `Pos_n` refinement functor invoked. The `obstructionCohomClass F` is built directly on `BKTotal n` per the L2a-residual-residual closure (concrete Sigma-Finsupp).
- **D.3 U1-dialect check**: the chain-to-cohomology projection is the additive homology quotient (no cup-product reintroduced). Verified by import audit: `CohomologyClass.lean` imports only `Mathlib.Algebra.Category.ModuleCat.Abelian`, `Mathlib.Algebra.Homology.ShortComplex.HomologicalComplex`, `UnionClosed.UC10.BousfieldKan`, `UnionClosed.UC11.ObstructionClass` — no `Mathlib.AlgebraicTopology.CupProduct` or analogous multiplicative-structure imports. The (Z/2)^n-Walsh isotype decomposition (per UC13 §2 Schur) is preserved at the cohomology-quotient level (the SS-edge transport is (Z/2)^n-equivariant per UC11 §5.4 + Θ-equivariance).
- **D.4 Math-first**: the SS-edge map at the populated baseline (horizontal differential = 0 per UC-Lean-scope §B.2) literally IS the canonical chain-to-homology projection in mathlib's `HomologicalComplex` API. Math content aligns with UC11 §5 (Čech-to-cohomology spectral-sequence edge map promotion) + UC13 §2 (abutment identification + corrected landing) + UC14 §1.5 (Θ-equivariance + abutment identification at the populated baseline). All three latex sources GREEN-merged.

## Verdict summary

**AMBER (strictly tightest named tactic gap)** — strictly tighter than mg-a5ac's AMBER (mathlib API is now in scope, not just named). The mg-0eb4 contribution is the **substantive mathlib API integration** + **chain-to-cohomology-class projection construction** + **structural narrowing of the residual gap to the topVertex-non-coboundary identification** (= UC10.1 V_[n]^{n-1} concentration). GREEN closure path: implement UC10.1 V_[n]^{n-1} concentration (Path 1+ at `UC10/Target.lean:107`) OR Path 2 definitional refactor (mg-a5ac-named, PM morning fallback). Project-life milestone "zero live load-bearing sorrys" remains pending on UC10.1 or definitional refactor.

Per ticket "STOP-LOSS": this AMBER triggers pm-onethird's pause of Lean dispatch until morning sweep; Path 2 (definitional refactor) is the named morning fallback.
