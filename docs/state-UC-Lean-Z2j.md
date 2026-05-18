# UC-Lean-Z2j-SpectralObjectRecordClosure — state (cat-mg-e0a0, ticket mg-e0a0, Lean-Session 47)

**Verdict.** AMBER (minimal substantive landing — only `isPullback_top_mono` helper + import + 1 non-vacuous eval). The Z2j Phase B-closure SES upgrade **persisted as AMBER under the same Z2i TC-diamond** (`Abelian (HomologicalComplex (HomologicalComplex C c₂) (ComplexShape.up ℤ))` chain), despite multiple workaround attempts. The full `K.spectralObject_op` record + `EIntᵒᵖ ≃ EInt` transport + `IsFirstQuadrant` instance + totalised non-vacuous eval are also deferred to a **Z2k** named follow-on per the pre-authorised sub-split contingency (the **eleventh** Z2 sub-split).

**Daniel-coordinated structural review of Z3-Z10 pre-splitting is now strongly warranted** given the empirical 10-sub-split-and-still-AMBER pattern in Z2 + the persistent TC-diamond blocker.

Z2j is the **tenth sub-split** of Z2 (Z2 → Z2a → Z2b → Z2c → Z2d → Z2e → Z2f → Z2g → Z2h → Z2i → Z2j). The structural-review caveat (mg-b823, 5+ sub-splits) is now exceeded **six times**.

## What landed (substantive, but minimal vs original Z2j scope)

### `isPullback_top_mono` (private helper)

```
private lemma isPullback_top_mono {D : Type*} [Category* D] {X Y Z : D}
    (f : X ⟶ Y) (g : Y ⟶ Z) [Mono g] :
    IsPullback f (𝟙 X) g (f ≫ g)
```

The trivial pullback square `(f, 𝟙_X, g, f ≫ g)` is a pullback when `g` is mono — the orientation needed for `Abelian.mono_cokernel_map_of_isPullback` to produce `Mono (cokernel.map f (f ≫ g) (𝟙) g _) : cokernel f ⟶ cokernel (f ≫ g)`. Built via `PullbackCone.IsLimit.mk` with lift = `s.snd` and uniqueness from `cancel_mono g`.

This is the bicomplex-ambient analogue of `IsKernelPair.id_of_mono` extended to the non-symmetric square. The naming convention reflects the orientation: `top` corresponds to the position of `f` (top horizontal of the square), and the mono is on `g` (right vertical of the square).

### Import addition

* `Mathlib.CategoryTheory.Abelian.CommSq` (for `Abelian.mono_cokernel_map_of_isPullback`).

### Non-vacuous evaluation (1 new on `trivialColumnZeroFirstQuadrant`)

The `isPullback_top_mono` helper applies concretely to the bicomplex-level filtration inclusions at the non-trivial filtration triple `⊥ ≤ (0 : EInt) ≤ ⊤`.

## What FAILED to land — Phase B-closure SES upgrade

The full bundled `spectralObjectSlice_tripleShortComplex_shortExact` was **attempted but failed**. The Phase B-closure SES would have combined:
1. `Mono (spectralObjectSlice_first)` via factor lemma + `mono_LES_cokernel_map_first` (using `Abelian.mono_cokernel_map_of_isPullback` on the new `isPullback_top_mono` helper)
2. `Exact` (middle exactness) via factor lemmas + `kernelCokernelCompSequence_exact.sc' 3 4 5` transported via the bridging iso
3. `Epi` from Z2h `spectralObjectSlice_second_epi`

The blocker is the **same Z2i TC-diamond**: `Abelian (HomologicalComplex (HomologicalComplex C c₂) (ComplexShape.up ℤ))` fails to synthesize because of a diamond conflict between `HomologicalComplex.instHasZeroMorphisms` (the direct mathlib instance) and `preadditiveHasZeroMorphisms` (derived from Preadditive). The TC error consistently reports:
```
synthesized HomologicalComplex.instHasZeroMorphisms
inferred    preadditiveHasZeroMorphisms
```

### Workarounds attempted (all failed)

1. **Section-variable `[Abelian C]` discipline** (matches Z2e's `ShortExactUpgrade` pattern): forces inner Abelian into normal form but the bicomplex Abelian chain still fails.
2. **Two-step `letI` chain** (`letI hAb1 : Abelian (HomologicalComplex C c₂) := inferInstance; letI hAb2 : Abelian (HomologicalComplex (HomologicalComplex C c₂) (ComplexShape.up ℤ)) := inferInstance`): hAb1 succeeded but hAb2 still failed with the diamond.
3. **`set_option maxHeartbeats 1600000`**: did not resolve diamond.
4. **`set_option synthInstance.maxHeartbeats 800000`**: did not resolve diamond.
5. **Bicomplex variable expanded with full TC chain `[Category* C] [Preadditive C] [HasZeroObject C] [Abelian C]`**: did not resolve diamond.

### Root cause analysis

The diamond is at the inner level: `HasZeroMorphisms (HomologicalComplex C c₂)` has two non-defeq instances:
* `HomologicalComplex.instHasZeroMorphisms` (direct, from the Preadditive structure on HomologicalComplex)
* `preadditiveHasZeroMorphisms` (derived from `Preadditive (HomologicalComplex C c₂)` via the generic chain)

When `Abelian` requires `HasZeroMorphisms`, Lean's TC search picks one but the inferred-from-typing-rules picks the other. The chain fails.

This is a **mathlib-side issue** that requires upstream resolution (typeclass priority adjustment, `@[reducible]` annotation on one of the instances, or instance unification). Z2e was unaffected because it never invokes the two-levels-deep `Abelian (HomologicalComplex₂ ...)` chain — Z2e applies `shortExact_of_degreewise_shortExact` at the bicomplex level which only needs the inner `Abelian (HomologicalComplex C c₂)`, plus inside the reduction it works in C directly.

### Path forward for Z2k

Z2k must adopt **variant (b) cell-level reduction**: apply `HomologicalComplex.shortExact_of_degreewise_shortExact` TWICE to reduce to cell-level in C (where the diamond does not apply, since `Abelian C` is given), then apply `kernelCokernelCompSequence_exact` in C. This requires:
* A cell-level analog of Z2i's `tripleCokerBridge` (bridging cell-level cokernels with cell-level slices)
* Cell-level analogs of the factor lemmas
* Cell-level analog of `isPullback_top_mono` applied to cell-level inclusion morphisms

Substantial work (~200-300 lines) but tractable in a single Z2k focused session if scoped to ONLY Phase B-closure (i.e., Z2k may need further sub-splits for Phases A/C/D/E).

## What was deferred to Z2k

The full **`K.spectralObject_op : SpectralObject (HomologicalComplex C c₂) EIntᵒᵖ` record assembly** (Phase A), **`EIntᵒᵖ ≃ EInt` transport** (Phase C), **`IsFirstQuadrant` instance composition** (Phase D), **totalised non-vacuous evaluation** (Phase E), AND **the Phase B-closure SES upgrade itself** (which Z2j attempted but failed due to TC-diamond).

## Acceptance bars (12 per ticket §0)

1. **lake build GREEN** — post-Z2i baseline 1609 jobs → 1616 jobs (+7 from the new `CommSq.lean` import dependency chain). ✓
2. **Non-vacuous (Phase E)** — DEFERRED to Z2k (no totalised eval landed).
3. **Mathlib-PR-clean naming + Joël-Riou-style docstrings.** ✓
4. **Zero new sorrys.** ✓
5. **Zero new axioms.** ✓
6. **No fake mathlib API.** ✓ (`isPullback_top_mono` is a direct construction via `PullbackCone.IsLimit.mk`).
7. **No defeq bypass on transport / ShortExact closure.** ✓
8. **No False.elim.** ✓
9. **Type-correct.** ✓
10. **MATHLIB-FOLDER scope respected.** ✓ (only `Bicomplex.lean` modified + 1 new import).
11. **Feeds-into-Z3 readiness.** ✗ DEFERRED to Z2k (Z2j ShortExact attempt failed).
12. **No L+X+Y dependencies.** ✓

## Sub-split history note

This is the **10th Z2 sub-split** (Z2 → Z2a → Z2b → Z2c → Z2d → Z2e → Z2f → Z2g → Z2h → Z2i → Z2j), triggering the "5+ sub-splits warrants structural review" caveat for the **sixth time**. Z2j landed substantively LESS than the prior Z2g/Z2h/Z2i pattern (only one new helper vs each of those landing 4-7 substantive primitives) due to the TC-diamond persisting through all workaround attempts.

Daniel-coordinated structural review of Z3-Z10 pre-splitting is now **strongly warranted** given:
* Empirical 10-sub-split-and-still-AMBER pattern in Z2
* Persistent TC-diamond as a mathlib-side blocker
* Z2k likely to need further sub-splits

## Forward operational step

* **Option A (recommended)**: File a mathlib-side issue/PR to resolve the `HomologicalComplex.instHasZeroMorphisms` / `preadditiveHasZeroMorphisms` diamond. Once upstream-resolved, Z2j-deferred work + Z2k can both close in one focused session each.
* **Option B (next polecat)**: File Z2k (UC-Lean-Z2k-SpectralObjectRecordCompletion) as the next sequential sub-ticket, scoped to ONLY the Phase B-closure SES upgrade via cell-level reduction (workaround b). Phases A/C/D/E would then need Z2k₁/Z2k₂ further sub-splits.
* **Option C (escalate)**: Mail Daniel to surface the persistent TC-diamond + propose Z3-Z10 pre-splitting strategic-audit conversation.

## Build status

* **`lake build` GREEN** — additions extend Z2i's existing `Bicomplex.lean` file (~3450 lines → ~3577 lines).
* One new import: `Mathlib.CategoryTheory.Abelian.CommSq` (brought in `Abelian.mono_cokernel_map_of_isPullback`).
* Zero new sorrys / axioms / fake mathlib API / defeq tricks / False.elim / decide shortcuts.
* Non-tautology preserved via the genuine `PullbackCone.IsLimit.mk` construction with substantive `cancel_mono g` invocation (not `rfl` bypass).

## Files modified

* `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/Bicomplex.lean` — extends with Z2j `isPullback_top_mono` helper section + 1 non-vacuous evaluation + updated deferred-to-Z2k writeup honestly reflecting the TC-diamond persistence.

## Files created

* `docs/state-UC-Lean-Z2j.md` (this file).
