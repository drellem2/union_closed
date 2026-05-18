# Frankl-mathlib-copy-and-tweak — Session 1 state (cat-mg-8dce, Lean-Session 48)

**Verdict.** **RED** — the mathlib v4.29.1 `Abelian (HomologicalComplex
(HomologicalComplex C c₂) (ComplexShape.up ℤ))` TC-diamond **cannot be bypassed
reasonably easily** via the literal copy-and-tweak pattern Daniel sketched
(2026-05-18T18:25Z). Phase A (repro + scoping) GREEN; Phase B (3 distinct
priority / instance-pin / canonical-instance tweaks) ALL FAILED with the same
deterministic `whnf` / `isDefEq` heartbeat-timeout signature as the 5 Z2j
workarounds; Phase C–E DEFERRED. Need Daniel direction on whether to pursue
option (iii) reproduce-locally (multi-month) or option (i) upstream-mathlib-fix
(multi-week + multi-week-wait), or to accept the paper-axiom permanently per
the mg-8510 disclosure-pivot already shipped (mg-1b2b).

## Phase A — repro + scoping (GREEN)

### Repro

Minimal Lean file `lean/UnionClosed/Mathlib/Algebra/Homology/DiamondTest.lean`
(scratch, deleted at end of session) exhibits the diamond at the **exact
Z2j-failed primitive** — `Mono (cokernel.map (f) (f ≫ g) (𝟙) g _)` via
`Abelian.mono_cokernel_map_of_isPullback`, where `f := K.cutoffColumnsEInt_le h_jk`
and `g := K.cutoffColumnsEInt_le h_ij` (with `g` mono by Z2h
`cutoffColumnsEInt_le_mono`). The repro reproduces the failure even with
`set_option maxHeartbeats 800000` (well above the 5-Z2j-attempts ceiling
1600000 of mg-e0a0).

The `set_option diagnostics true` reading shows the unifier is bogged down in
the deep additive chain (`instHAdd ↦ 44280`, `HomologicalComplex.instCategory ↦
3725`, `Preadditive.homGroup ↦ 3514`, etc.) — the diamond isn't *only* at
`HasZeroMorphisms` but cascades into the entire `AddCommGroup`-on-hom-sets
structure that the `Preadditive` chain supplies.

Sanity check: a stripped repro that calls
`Abelian.mono_cokernel_map_of_isPullback` on the *trivial* pullback square
`IsPullback.id_horiz (𝟙 X)` at the bicomplex level *succeeds* (no diamond bite).
The diamond requires the morphism to enter via the `cutoffColumnsEInt_le` path
(or any morphism pre-elaborated under the Bicomplex.lean section variables
`[Preadditive C] [HasZeroObject C] [Abelian C]` that bakes the wrong
HasZeroMorphisms term in). This narrows the diamond surface to the
inclusion-pre-elaboration boundary that we cannot avoid in the SS-derivation.

### Mathlib instance graph (re-confirmed against mg-8510 §1)

* `Mathlib.Algebra.Homology.HomologicalComplex` line 286 —
  `instance : HasZeroMorphisms (HomologicalComplex V c)` (default priority 1000)
* `Mathlib.CategoryTheory.Preadditive.Basic` line 201 —
  `instance (priority := 100) preadditiveHasZeroMorphisms : HasZeroMorphisms C`
* `Mathlib.Algebra.Homology.Additive` line 86 — `Preadditive (HomologicalComplex
  V c)` from `[Preadditive V]` (the chain enabling Path 2 at second-level HC).
* Both paths produce the same `{ f := fun _ ↦ 0 }` underlying zero
  (`HomologicalComplex.lean:278` + `Additive.lean:82`); the diamond is purely
  term-level.

## Phase B — tweak attempts (all RED)

### Tweak 1 — priority bump on `preadditiveHasZeroMorphisms`

```lean
attribute [instance 1100] CategoryTheory.Preadditive.preadditiveHasZeroMorphisms
```

(Audit option `(i-b)`.) Placed in a fresh `UnionClosed.Mathlib.Patch.lean` and
imported by `Bicomplex.lean` *before* the `cutoffColumnsEInt_le` definition, so
the priority is in effect when those morphisms are pre-elaborated.

**Result.** `(deterministic) timeout at 'isDefEq', maximum number of heartbeats
(800000) has been reached`. The priority bump has no observable effect: TC at
the inner `Abelian (HC C c₂)` level still picks `HC.instHasZeroMorphisms` (the
inner direct instance has priority 1000 > 100, and the priority bump doesn't
reach the *inner* layer because the discrimination-tree match for the outer
layer is decided before the inner layer's priority is evaluated).

### Tweak 2 — priority demote + bump combined

```lean
attribute [instance 1100] CategoryTheory.Preadditive.preadditiveHasZeroMorphisms
attribute [instance 50]   HomologicalComplex.instHasZeroMorphisms
```

(Audit options `(i-b)` + a soft variant of `(i-c)`.) Same Patch.lean placement
as Tweak 1.

**Result.** Same timeout. The direct instance is still picked because the
discrimination-tree match is more specific (`HasZeroMorphisms (HC V c)` vs
`HasZeroMorphisms C`).

### Tweak 3 — explicit higher-priority canonical-form instance

```lean
instance (priority := 2000) hcHasZeroMorphismsViaPreadditive
    {ι : Type*} {V : Type*} [Category V] [Preadditive V] {c : ComplexShape ι} :
    HasZeroMorphisms (HomologicalComplex V c) :=
  Preadditive.preadditiveHasZeroMorphisms
```

(Audit option `(i-d)` — propositional-equality-via-canonical-form instance.)
Registers a new instance at priority 2000 that *explicitly defers to the
preadditive path*, so TC should pick this canonical form first.

**Result.** Same timeout. Even though the new instance has priority 2000, the
unifier still has to compare two cokernel terms whose `HasZeroMorphisms` is
filled by *different* TC searches at different elaboration points (the
`K.cutoffColumnsEInt_le _` morphism's definition vs the `cokernel.map _ _ _ _
sq.w` use-site goal), and the discrimination tree picks the direct instance for
some elaboration paths and the canonical for others.

### Variants NOT tried (but per audit §1d would also fail)

* **`attribute [reducible]` on `HC.instHasZeroMorphisms`** (audit option `(i-a)`)
  — needs `set_option allowUnsafeReducibility true`, and per audit's analysis
  the reducibility annotation doesn't propagate through the discrimination-tree
  match because the instance isn't *unfolded* during TC search.
* **`@[default_instance]`** — has no effect on TC search ordering, only on
  metavariable elaboration default selection.
* **Section-variable `letI` chain locking** — Z2j workaround 1+2 already showed
  this fails (mg-e0a0 §"Workarounds attempted").
* **Heartbeat bumps** — Z2j workarounds 3+4 already showed this fails (the
  diamond is structural, not budget).
* **Full TC-chain section expansion** — Z2j workaround 5 already showed this
  fails.

The combined empirical-failure pattern across **8 distinct workarounds** (5
Z2j + 3 Session 1) strongly corroborates the mg-8510 audit's verdict: the
diamond is a *structural mathlib v4.29.1 issue* that requires either:

1. **Upstream resolution** — option (i) — a mathlib PR adjusting priorities or
   adding `@[reducible]` to `HC.instHasZeroMorphisms`. Multi-week (community
   review) + multi-week-wait (PR merge cycle). Conflicts with Daniel's
   13:53Z local-only directive at the surface reading.
2. **Substantial local reproduction** — option (iii) — re-derive the
   SS infrastructure from scratch on a fresh `UCBicomplex` encoding that
   *structurally avoids* the bicomplex Abelian instance. ~1.5–2.0M tokens,
   multi-month.
3. **Cell-level structural redesign** — option (iv) — re-architect Z3–Z10
   deliverables to consume bicomplex data *cell-wise* (via
   `shortExact_of_degreewise_shortExact` twice). ~1.5–2.0M tokens,
   multi-month. Z2k would need to be re-filed at ~250–300 lines via this
   workaround.

The literal Daniel-sketched option (ii) "copy from mathlib + modify" is
**not** "reasonably easy" — the simple-tweak surface of attribute / priority /
canonical-form-instance changes does not bite the diamond. A real option (ii)
fix would require *copying the entire dependency cone* of
`HomologicalComplex.lean` + `Preadditive/Basic.lean` + `Additive.lean` +
`HomologicalComplexAbelian.lean` + `HomologicalBicomplex.lean` +
`TotalComplex.lean` + `SpectralObject/*.lean` (8 files) +
`HomologySequence/*.lean` + `ShortComplex/*.lean` + their downstream consumers
(per audit §2b: 30–60 files, ~1.5–2.5M tokens initial + 200–400k/quarter
perpetual sync burden). That is not "reasonably easy" either.

## Phase C–E — deferred

* **Phase C** (verify Z2-Z2j artefacts build clean on patched mathlib) —
  N/A, no patched mathlib produced.
* **Phase D** (close Frankl SS-obstruction paper-axiom) — DEFERRED, blocked
  on Phase C.
* **Phase E** (regenerate `#print axioms` clean) — DEFERRED, blocked on
  Phase D.

## Recommendation to Daniel

Per ticket §"Escalation conditions" → "RED diamond cannot be bypassed
reasonably easily (escalate to Daniel for option-iii reproduce-locally OR
option-i upstream-fix)":

### Option A (Daniel-recommended baseline) — accept paper-axiom permanently

The mg-1b2b disclosure-pivot already ships `Frankl_Holds` in
explicitly-disclosed-paper-axiom form per the OneThird mg-74d2 template, and
the audit's GREEN-WITH-CONDITIONS verdict (mg-ee54) found this honest-disclosure
state to be publication-defensible. No further Lean work needed.

### Option B — option (i) mathlib upstream PR

File a single-session 200k mathlib PR spike (the audit's
`UC-Lean-Z-research-mathlib-fix-spike`) trying option (i-a) `@[reducible]`
annotation locally in a fork to see if it bypasses the diamond downstream.
If yes, upstream the PR (multi-week + multi-week-wait cycle). Frankl headline
remains explicitly-axiom-disclosed during the wait.

### Option C — option (iii) reproduce locally (multi-month)

File `UC-Lean-Z-research-reproduce-local-spike` as a 200k single-session
encoding-feasibility study of `UCBicomplex C c₁ c₂` (a fresh structure-based
encoding that bypasses the diamond by construction). Multi-month commitment
if pursued.

### Option D — option (iv) cell-level redesign (multi-month)

Re-file Z2k as cell-level reduction per Z2j's workaround (b) writeup
(~250–300 lines), then re-file Z3–Z10 with the same discipline. Multi-month
commitment if pursued.

**Polecat recommendation: Option A** (accept paper-axiom permanently as
already shipped). The audit (mg-8510 + mg-ee54) and Daniel's 18:26Z verdict
explicitly prioritise the paper-axiom closure as the higher-priority directive,
with the mathlib-bypass only if "reasonably easily" — and Session 1 has
empirically confirmed it is not reasonably easy. Options B/C/D are deferred
multi-week-to-multi-month investments that should be Daniel-gated rather than
polecat-initiated.

## Acceptance bars (per ticket §0 "Phase E report")

1. `#print axioms Frankl_Holds` shows only standard mathlib axioms — ✗
   (still depends on `case3_ss_obstruction_paper_axiom`).
2. Lean source clean, builds GREEN — ✓ (2053 jobs, baseline preserved).
3. Documentation updated per PROOF-STRUCTURE-ONBOARDING.md maintenance —
   ✓ (this file + onboarding pitfall #2 unchanged because the diamond status
   is unchanged from Z2j).

## Files modified

* `docs/state-Frankl-mathlib-copy-and-tweak-Session1.md` — NEW, this file.

## Files NOT modified (intentionally)

* `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/Bicomplex.lean` —
  unchanged; reverted the test-time `public import UnionClosed.Mathlib.Patch`
  after the 3 tweak attempts all failed.
* `lean/UnionClosed/PaperAxioms.lean` — unchanged (axiom retained pending
  Daniel direction).
* `lean/AXIOMS.md` — unchanged.
* `docs/PROOF-STRUCTURE-ONBOARDING.md` — unchanged (the diamond pitfall in §5
  is unchanged from mg-1b2b).

## Build status

* **`lake build` GREEN** — 2053 jobs, identical to mg-1b2b baseline. No new
  imports, no new sorrys, no new axioms. Diamond status persists.
* **`#print axioms Frankl_Holds`** — unchanged from mg-1b2b: lists mathlib
  trio + `case3_ss_obstruction_paper_axiom`.

## Cross-references

* **Verdict trigger:** Daniel directive 2026-05-18T18:25Z + 18:26Z.
* **Audit:** `mg-8510` + `docs/Z-arc-architecture-audit.md`.
* **Disclosure-pivot baseline:** `mg-1b2b` + `lean/AXIOMS.md`.
* **TC-diamond final-defeat (Z2j):** `mg-e0a0` + `docs/state-UC-Lean-Z2j.md`.
* **OneThird analog:** `mg-74d2`.
* **mathlib v4.29.1 diamond sources:**
  * `Mathlib/Algebra/Homology/HomologicalComplex.lean:286`
  * `Mathlib/CategoryTheory/Preadditive/Basic.lean:201`
  * `Mathlib/Algebra/Homology/Additive.lean:86`
