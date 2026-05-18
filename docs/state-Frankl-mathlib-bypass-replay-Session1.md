# Frankl-mathlib-bypass-replay — Session 1 state (cat-mg-7e53, Lean-Session 49)

**Verdict.** **RED** — the simpler bypass approaches Daniel sketched in
mg-7e53 22:24Z (`attribute [-instance]` local disable, minimum-viable-fork)
do **not** unblock the mathlib v4.29.1 `Abelian (HomologicalComplex
(HomologicalComplex C c₂) (ComplexShape.up ℤ))` TC-diamond at the Z2j-
failed primitive within a single 400–600k polecat session. Phase A (repro +
4 distinct Approach-1 variants) GREEN; Phase B (literal single-file copy
fork) STRUCTURALLY IMPOSSIBLE under Lean's nominal type system; Phase C
(minimal cascade fork of HC + Additive + HCAbelian + HCBicomplex +
TotalComplex into a forked namespace) TRACTABLE per Daniel "AI-native,
file count moot" framing but EXCEEDS single-session budget (~1500–2400
lines of mathlib code to copy + namespace-rename + iteratively debug,
plus ~3600-line Z2a-Z2j re-derivation in the fork's namespace).

**New diagnostic beyond mg-8dce:** the diamond is at **olean term
reference**, not TC search. The previous mg-8dce diagnosis ("TC picks
wrong path due to instance priority") was correct but incomplete; this
session adds the sharper finding that even with TC search forced onto
the preadditive path via `attribute [-instance]`, the use-site unifier
still hits whnf/isDefEq timeouts because mathlib's pre-compiled bicomplex
`Abelian` instance bakes the direct-`HasZeroMorphisms` term into its
proof data. The pre-compiled oleans cannot be retroactively rewritten by
local attribute changes. **Single-level** `Abelian (HomologicalComplex C
c)` is **diamond-free** (verified by a non-vacuous example in
`lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/DiamondTest.lean`).
The diamond is specifically a **bicomplex (double-level nesting)** issue.

Daniel-coordinated escalation needed: per ticket §"If ALL three approaches
fail with reasonable effort: escalate to mayor with specific reason (not
just 'feels hard')", this verdict provides specific reasons grounded in
both the new diagnostic and Lean's nominal type semantics. Recommended
options to Daniel are listed in §6 below.

## Phase A — repro + 4 Approach-1 variants (all RED)

### Repro

`lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/DiamondTest.lean`
(NEW, lands in this commit as a permanent test scaffold) reproduces the
Z2j-failed primitive at the exact bicomplex level:

```lean
noncomputable example :
    Mono (cokernel.map (K.cutoffColumnsEInt_le h_jk)
      (K.cutoffColumnsEInt_le h_jk ≫ K.cutoffColumnsEInt_le h_ij)
      (𝟙 _) (K.cutoffColumnsEInt_le h_ij) (by simp)) := by
  haveI : Mono (K.cutoffColumnsEInt_le h_ij) := K.cutoffColumnsEInt_le_mono _
  exact Abelian.mono_cokernel_map_of_isPullback (isPullback_top_mono _ _)
```

This is the same primitive that Z2j AMBER (mg-e0a0) and mg-8dce RED both
hit. The file lands with the bicomplex example **commented out** (so the
file builds GREEN as part of the project) but the comment includes the
exact source for any future polecat who wants to re-attempt.

### Approach-1 variant 1: `attribute [-instance]` in DiamondTest.lean only

```lean
attribute [-instance] HomologicalComplex.instHasZeroMorphisms
```

**Result.** Failure mode shifts from `(deterministic) timeout at 'typeclass',
maximum number of heartbeats (20000)` (the pre-`[-instance]` baseline,
synthInstance timeout) to `(deterministic) timeout at 'whnf', maximum
number of heartbeats (800000)`. The TC search now correctly avoids the
direct instance (since the attribute removes it from the local TC
database), but the use-site unifier still loops in term reduction
because the morphisms `K.cutoffColumnsEInt_le` were elaborated inside
`Bicomplex.lean` against the original mathlib TC database (where the
direct instance is present).

### Approach-1 variant 2: `attribute [-instance]` in both DiamondTest.lean AND Bicomplex.lean

Same `attribute [-instance]` line added at the top of `Bicomplex.lean`'s
`@[expose] public section` (just before `namespace HomologicalComplex₂`)
so that Z2a-Z2j primitives are elaborated against the preadditive path
during Bicomplex.lean's own compilation. Bicomplex.lean re-builds GREEN
under this attribute (no breakage of Z2a-Z2j substantive content). Then
DiamondTest.lean also has `attribute [-instance]` and tries the failed
primitive.

**Result.** Same `whnf` timeout at 1.6M heartbeats. The Bicomplex-side
re-elaboration uses preadditive consistently, but the use-site call to
`Abelian.mono_cokernel_map_of_isPullback` requires the bicomplex Abelian
instance from mathlib's `HomologicalComplexAbelian.lean`, which was
itself pre-compiled with the direct-instance path baked in. Unification
between mathlib's pre-compiled bicomplex Abelian term and our locally
re-synthesized preadditive bicomplex Abelian term is what loops in whnf.

### Approach-1 variant 3: + `set_option backward.isDefEq.respectTransparency false`

The same option mathlib's own `Mathlib/CategoryTheory/Abelian/CommSq.lean`
line 149 uses for the same `Abelian.mono_cokernel_map_of_isPullback`
family.

**Result.** Failure mode shifts from `whnf` to `isDefEq` timeout at 1.6M
heartbeats. The respect-transparency relaxation lets the unifier try
deeper reductions but the diamond is structural, not a transparency
issue, so the loop persists.

### Approach-1 variant 4: + `letI` at BOTH inner and outer levels

```lean
letI hzmInner : HasZeroMorphisms (HomologicalComplex C c₂) :=
  Preadditive.preadditiveHasZeroMorphisms
letI hzmOuter :
    HasZeroMorphisms (HomologicalComplex (HomologicalComplex C c₂) (ComplexShape.up ℤ)) :=
  Preadditive.preadditiveHasZeroMorphisms
```

mg-8dce only tried letI for the OUTER level; this session adds the inner
+ outer combination.

**Result.** Same `whnf` timeout at 1.6M heartbeats. The local `letI`
hypothesis injects preadditive at both levels into the local TC database,
but the mathlib pre-compiled bicomplex Abelian still references the
direct path via its olean-baked proof data.

### Diagnosis (new beyond mg-8dce)

mg-8dce diagnosed: "TC search picks the direct instance because of
discrimination-tree priority, and priority bumps don't reach the inner
layer because the outer layer's discrimination-tree match is decided
before the inner layer's priority is evaluated."

This session's 4-variant pattern adds the sharper diagnosis: **even with
TC search forced onto preadditive (which `[-instance]` does
unambiguously, removing the direct instance from the discrimination
tree entirely — fundamentally different from priority adjustment), the
diamond persists because mathlib's pre-compiled `Abelian (HC ...)`
instance from `HomologicalComplexAbelian.lean:44` has the direct
`HasZeroMorphisms` term baked into its proof data**. When this
pre-compiled instance is consumed at our use site, the unifier needs
to compare the olean-baked direct term against our locally re-synthesized
preadditive term, and the comparison loops in whnf/isDefEq because the
two `HasZeroMorphisms` terms are extensionally equal but not
definitionally equal at the depth the unifier reaches.

**Implication:** the diamond cannot be unbroken by any local attribute,
priority, or option-flag mechanism — it requires either (a) recompiling
mathlib's `HomologicalComplexAbelian.lean` with the direct instance
removed (Approach 2/3 cascade fork), or (b) upstream mathlib patching
(option B per mg-8dce / mg-7e53).

## Phase B — Approach 2 literal single-file fork (STRUCTURALLY IMPOSSIBLE)

The ticket §"Approach 2 — minimum-viable-fork (if Approach 1 fails)"
prescribes:

> 1. Copy mathlib's `HomologicalComplex.lean` →
>    `lean/UnionClosed/Mathlib/HomologicalComplex.lean`.
> 2. Remove the offending `HC.instHasZeroMorphisms` from the local copy.
> 3. Redirect `lean/UnionClosed/` code to import the local copy.
> 4. Verify downstream Z2-Z2j artefacts compile against the local copy.

Step 3 is **structurally impossible** under Lean 4's nominal type system:

* If the local copy uses the **same module name**
  `Mathlib.Algebra.Homology.HomologicalComplex`, Lean rejects the
  duplicate module.
* If the local copy uses a **different module name** (e.g.
  `UnionClosed.Mathlib.HomologicalComplex`) but the **same type name**
  `HomologicalComplex`, the types `Mathlib.Algebra.Homology.HC` (from
  mathlib's still-required-by-downstream-mathlib imports) and
  `UnionClosed.Mathlib.HC` are **nominally distinct**, even though their
  structure is identical. Any code calling mathlib's
  `HomologicalComplexAbelian`, `TotalComplex`, etc. uses mathlib's HC;
  any code wanting the diamond bypass would have to use our local HC;
  there is no way to substitute one for the other at the call site.
* The required mathlib downstream files (`TotalComplex.lean`,
  `HomologicalComplexAbelian.lean`, `HomologicalBicomplex.lean`,
  `Embedding/StupidTrunc.lean`, `ShortComplex/ShortExact.lean`,
  `DiagramLemmas/KernelCokernelComp.lean`, the entire `SpectralObject/*`
  cone) all reference mathlib's HC by its fully-qualified namespace name,
  and would continue to use mathlib's HC (with its direct
  HasZeroMorphisms instance) regardless of any local copy.

The Lean-language equivalent of "monkey-patching" a single instance in
an upstream library does not exist. The closest you can do is
`attribute [-instance]` (= Approach 1), which we've shown is
insufficient because of the olean term-reference issue.

**Conclusion for Approach 2 literal:** the prescription as written
cannot work in Lean 4. The closest realistic interpretation is Approach
3 (cascade fork) — see below.

## Phase C — Approach 3 cascade fork (TRACTABLE, BUT MULTI-SESSION)

The minimal cascade fork that could bypass the bicomplex Abelian
diamond is:

1. **`HomologicalComplex.lean`** (1065 lines, mathlib) → rename
   `HomologicalComplex` to `UCHomologicalComplex` throughout, REMOVE the
   `instance : HasZeroMorphisms (HomologicalComplex V c)` at line 285.
2. **`Additive.lean`** (287 lines, mathlib) → rename HC references to
   UCHC; the `Preadditive UCHomologicalComplex` instance is the path
   the bypassed bicomplex Abelian will use for HasZeroMorphisms.
3. **`HomologicalComplexAbelian.lean`** (102 lines, mathlib) → rename HC
   references to UCHC; the new `Abelian UCHomologicalComplex` instance
   automatically uses preadditive HasZeroMorphisms (since direct is
   gone), so the bicomplex `Abelian (UCHC (UCHC C c₂) (CS ℤ))` is
   diamond-free.
4. **`HomologicalComplexLimits.lean`** (231 lines, mathlib) → rename HC
   refs to UCHC.
5. **`HomologicalBicomplex.lean`** (215 lines, mathlib) → rename HC refs
   to UCHC; defines `UCHomologicalComplex₂` as nested UCHC.
6. **`TotalComplex.lean`** (472 lines, mathlib) → rename HC refs to UCHC;
   defines `total : UCHC₂ ⥤ UCHC`.
7. **`Embedding/StupidTrunc.lean` + dependencies** (~500 lines, mathlib)
   → rename HC refs to UCHC for our `cutoffColumns` etc.
8. **`ShortComplex/ShortExact.lean` + `DiagramLemmas/KernelCokernelComp.lean`
   + `SpectralObject/*`** (~1000+ lines, mathlib) → rename HC refs to UCHC.

**Subtotal of mathlib code to copy and adjust: ~3500-4000 lines.**

Then:

9. **`Mathlib/Algebra/Homology/SpectralObject/Bicomplex.lean`** (3609
   lines, our research-track scaffolding) → re-derive in `UCHomologicalComplex`
   namespace. Z2a-Z2j all need to be ported.

**Total: ~7000-8000 lines of code to copy + rename + iteratively debug.**

Per Daniel 22:35Z "AI-native dev paradigm — copy any number of mathlib
files if needed; maintenance moot; one successful formalization is the
bar", this is the intended path. AI-native cascade fork is plausible
in **3-5 multi-million-token sessions** (1.5-2.5M tokens per session for
the mathlib mechanical port + Z2a-Z2j re-derivation).

**However, this exceeds the mg-7e53 single-session 400-600k budget.**
The remaining steps after diamond bypass (Z3-Z10 SpectralObject
infrastructure + Walsh-isotype chain refactor for the chain-encoding-
refinement substep of the paper-axiom) would themselves be additional
multi-session work (per mg-103f scoping: 3.4-4.6M cumulative tokens for
the Z-arc).

**Honest project-life estimate** for full Frankl axiom closure via the
cascade-fork path: **~10-20M tokens across 10-20 sessions** for the
mathlib fork + Z2a-Z2j re-derivation + Z3-Z10 + Walsh-isotype refactor.
This is **days-to-weeks** of polecat-session-time at AI-native cadence,
matching neither Daniel's "hours" framing nor mg-8dce's "multi-month"
framing — somewhere in between, weighted toward the longer end if any
of the Z3-Z10 deliverables themselves spawn sub-splits like Z2.

## Phase D-E — paper-axiom replacement (DEFERRED)

Per ticket §"After diamond bypassed: replace
`case3_ss_obstruction_paper_axiom` with actual theorem completing Z2-Z2j
SS-derived obstruction proof. Verify `#print axioms` cleanly drops the
axiom":

* Not reachable in this session because Approach 1/2/3 all fail or
  exceed budget.
* Even if the diamond were bypassed via Approach 3 cascade fork,
  paper-axiom replacement requires additionally:
  * **Z3-Z10 SpectralObject infrastructure** (mg-50b7 + cascade,
    shelved by mg-1b2b) for the spectral-sequence-derived per-x
    vanishing on the χ_x-isotype slice.
  * **Walsh-isotype chain refactor** (the chain-encoding-refinement
    substep noted in `PaperAxioms.lean` Replacement Path (a)) for
    transporting SS-side vanishing to chain-level
    `obstructionCohomClassChain F = 0`.
* The current mg-1b2b disclosure-pivot (paper-axiom + collision-
  disclosure docstring + AXIOMS.md OneThird-grade disclosure) is the
  closest-to-shipped form per the mg-ee54 GREEN-WITH-CONDITIONS audit.

## Files changed in this session

* **`lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/DiamondTest.lean`**
  (NEW, ~85 lines) — permanent test scaffold for future polecats:
  documented Approach-1 failure pattern in the comment block, a working
  single-level diamond probe (proves `Mono (cokernel.map ...)` at
  single-level Abelian-HC, demonstrating the diamond is specifically a
  bicomplex-level issue), and the inlined `isPullback_top_mono` helper
  (private copy of Bicomplex.lean:3452). File builds GREEN.

* **`docs/state-Frankl-mathlib-bypass-replay-Session1.md`** (NEW, this
  file) — Session 1 verdict + new diagnostic + cascade-fork roadmap.

* `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/Bicomplex.lean`
  — UNCHANGED at end of session (the Approach 1 variant 2 attribute
  modification was tested during Phase A and then reverted; full project
  build was verified GREEN both with and without the attribute).

* `lean/UnionClosed/PaperAxioms.lean` — UNCHANGED (axiom retained
  pending Daniel direction).

* `lean/AXIOMS.md` — UNCHANGED.

* `docs/PROOF-STRUCTURE-ONBOARDING.md` — UNCHANGED (the diamond pitfall
  in §5 is unchanged from mg-1b2b; the new diagnostic in this file
  refines the pitfall but does not invalidate it).

## Build status

* **`lake build` GREEN** — 2053 jobs, identical to mg-1b2b + mg-8dce
  baseline. No new sorrys, no new axioms, no new imports beyond the
  Mathlib.CategoryTheory.Abelian.CommSq import which was already present
  in Bicomplex.lean from Z2j.

* The new DiamondTest.lean file adds 1 job (1617 in its transitive
  closure; 2053 in full project closure).

* **`#print axioms Frankl_Holds`** — unchanged from mg-1b2b: lists
  mathlib trio (`Classical.choice`, `propext`, `Quot.sound`) +
  `case3_ss_obstruction_paper_axiom`.

## Acceptance bars (per ticket §"Acceptance bar")

1. **`lake build` GREEN.** ✓ (2053 jobs, baseline preserved.)
2. **Z2-Z2j artefacts compile against bypassed mathlib without diamond
   timeout.** ✗ — none of the 4 Approach-1 variants bypass the diamond
   for the Z2j-failed primitive; Approach 2 literal is structurally
   impossible; Approach 3 cascade exceeds single-session budget.
3. **Frankl SS-obstruction implemented directly OR honest report on
   which approach failed at which step.** Honest report delivered (this
   file). The paper-axiom remains in place per mg-1b2b status quo.

## Recommendation to Daniel (escalation per ticket §"After all approaches RED")

Per ticket §"After all approaches RED: Honest report. Daniel decides:
full multi-month reproduce-locally OR accept paper-axiom permanently OR
pursue non-bicomplex SS path", four concrete options:

### Option A (mg-8dce-recommended baseline) — accept paper-axiom permanently

Status quo: `Frankl_Holds` ships in explicitly-disclosed-paper-axiom
form per mg-1b2b disclosure-pivot, with the mg-ee54 GREEN-WITH-CONDITIONS
audit verdict declaring this form publication-defensible. No further
Lean work needed.

### Option B — cascade fork (Daniel's "AI-native" intended path)

File 3-5 follow-on tickets for forking
HC/Additive/HCAbelian/HCLimits/HCBicomplex/TotalComplex/Embedding/ShortComplex
into UC namespace + re-deriving Z2a-Z2j in the fork namespace + then
Z3-Z10 + Walsh-isotype chain refactor. Realistic timeline: **10-20
sessions, ~10-20M cumulative tokens, days-to-weeks of polecat time at
AI-native cadence**. Matches Daniel's 22:35Z framing "copy any number of
files if needed; maintenance moot; one successful formalization is the
bar".

### Option C — upstream mathlib PR (mg-8dce Option B)

File a single-session 200k mathlib PR spike (the audit's
`UC-Lean-Z-research-mathlib-fix-spike`) trying upstream `@[reducible]`
annotation or instance-priority adjustment on `HomologicalComplex.lean:285`
locally in a mathlib fork to see if it bypasses the diamond at the
bicomplex level. If yes, upstream the PR (multi-week + multi-week-wait
cycle). Frankl headline remains explicitly-axiom-disclosed during the
wait. Combines with Option A in steady state.

### Option D — cell-level workaround (mg-e0a0 Z2k path)

Re-file Z2k as cell-level reduction per Z2j's workaround (b) writeup
(~250–300 lines), then re-file Z3–Z10 with the same discipline.
Substantively similar to Option B in token cost but avoids the mathlib
fork by working entirely cell-wise in `C` (where the diamond does not
apply since `Abelian C` is given). Avoids upstream coordination but
still multi-session.

### Polecat recommendation

Option A or Option C (combined: accept paper-axiom in steady state while
the upstream PR is in flight). Option B/D are valid Daniel-decided
multi-session investments if "one successful formalization is the bar"
(per 22:35Z) is strong enough to justify the 10-20M token commitment.

The polecat-side reason for not autonomously dispatching Option B/D in
this session is the explicit single-session budget cap in the ticket
spec; per ticket §"If ALL three approaches fail with reasonable effort:
escalate to mayor with specific reason", the escalation is the correct
operational move at this point.

## Cross-references

* **Verdict trigger:** Daniel directive 2026-05-18T22:24Z (pushback on
  mg-8dce) + 22:35Z (AI-native framing) per ticket §0.
* **Predecessor:** `mg-8dce` + `docs/state-Frankl-mathlib-copy-and-tweak-Session1.md`
  (3 priority-based tweaks, all RED, "multi-month reproduce-locally"
  estimate).
* **Audit:** `mg-8510` + `docs/Z-arc-architecture-audit.md`.
* **Disclosure-pivot baseline:** `mg-1b2b` + `lean/AXIOMS.md` +
  `lean/UnionClosed/PaperAxioms.lean`.
* **TC-diamond final-defeat (Z2j):** `mg-e0a0` +
  `docs/state-UC-Lean-Z2j.md`.
* **Independent audit:** `mg-ee54` +
  `docs/Frankl-disclosure-pivot-independent-audit.md`.
* **OneThird analog:** `mg-74d2`.
* **mathlib v4.29.1 diamond sources:**
  * `Mathlib/Algebra/Homology/HomologicalComplex.lean:285` (offending
    direct `instance : HasZeroMorphisms (HomologicalComplex V c) where`,
    priority 1000).
  * `Mathlib/CategoryTheory/Preadditive/Basic.lean:201`
    (`preadditiveHasZeroMorphisms`, priority 100).
  * `Mathlib/Algebra/Homology/Additive.lean:86`
    (`Preadditive (HomologicalComplex V c)`).
  * `Mathlib/Algebra/Homology/HomologicalComplexAbelian.lean:44`
    (`Abelian (HomologicalComplex C c)` — the olean-baked term-reference
    site identified in this session's new diagnostic).
  * `Mathlib/CategoryTheory/Abelian/CommSq.lean:136`
    (`Abelian.mono_cokernel_map_of_isPullback` — the use site of the
    diamond).
