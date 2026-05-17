# UC-Lean-Z2g-SpectralObjectRecordCompletion — state (cat-mg-5e1a, ticket mg-5e1a, Lean-Session 44)

**Verdict.** AMBER. Z2g substantive Phase B cell-vanishing infrastructure landed for the spectral-object slice (column-side + row-side `IsZero` lemmas powering the `SpectralObject.IsFirstQuadrant` instance composition). The full `K.spectralObject` record assembly (H + δ + three exactness conditions) + the `IsFirstQuadrant` instance itself + triple-filtration `ShortExact` upgrade are deferred to a **Z2h** named follow-on per the pre-authorised sub-split contingency, with the additional **convention-reconciliation** decision identified during this session as a new sub-split rationale: the Z2 cohomological filtration setup (`F^i / F^j` slice for `i ≤ j` in EInt) is naturally **contravariant** as a functor on `ComposableArrows EInt 1`, but Joël Riou's `SpectralObject` framework expects a **covariant** H-functor, so Z2h needs to pick one of three resolution paths (use `EInt^op`, reinterpret via SES boundary direction, or accept reindexing).

Z2g is the **seventh sub-split** of Z2 (Z2 → Z2a → Z2b → Z2c → Z2d → Z2e → Z2f → Z2g). Z2h (eighth) is the strictly-tighter named follow-on closing Z2 scope.

## What landed (substantive)

### Phase B.2 — Spectral-object slice cell-vanishing from first-quadrant typeclasses

**Column-side vanishing** (`spectralObjectSlice_isZero_X_of_neg_col`).
For `[K.IsFirstQuadrantBicomplex]` and any EInt slice `h : i ≤ j` with `p < 0`:
`IsZero ((K.spectralObjectSlice h).X p)`.

Argument: the slice is `cokernel(K.cutoffColumnsEInt_le h)` in the bicomplex category. The bicomplex projection `K.spectralObjectSlice_π h` is `cokernel.π _`, hence `Epi` (via `coequalizer.π_epi`). By mathlib's auto-derived `Epi (φ.f n)` instance for `HomologicalComplex` morphisms (`HomologicalComplexLimits.lean:184`), the cell-level slice projection `(K.spectralObjectSlice_π h).f p` is also `Epi`. With target cell `(K.cutoffColumnsEInt i).X p` `IsZero` by Z2d's `cutoffColumnsEInt_isZero_X_of_neg_col`, `cancel_epi` on the slice cell projection reduces `id = 0` on the slice column to the source-zero fact — hence `IsZero` the slice column.

**Row-side EInt cutoff cell vanishing** (`cutoffColumnsEInt_isZero_X_X_of_neg_row`).
For `[K.IsFirstQuadrantRows]` with `K : HomologicalComplex₂ C (.up ℤ) (.up ℤ)` and `i : EInt`, `q < 0`:
`IsZero (((K.cutoffColumnsEInt i).X p).X q)` for every column `p`.

Argument: three-case `WithBotTop.rec` on `i`. At `⊥` the cutoff is `K`, so the cell IsZero comes directly from `IsFirstQuadrantRows.isZero_X_X_of_neg_row`. At integer index `p₀`, sub-case-split on `p₀ ≤ p` (the column is iso to `K.X p` via `cutoffColumns_XIso_of_le`, so cell IsZero transports) vs `p < p₀` (the column is itself IsZero by `cutoffColumns_isZero_X_of_lt`). At `⊤` the cutoff is `HomologicalComplex.zero`, so every cell is IsZero.

**Row-side spectral-object slice cell vanishing** (`spectralObjectSlice_isZero_X_X_of_neg_row`).
For `[K.IsFirstQuadrantRows]` and any EInt slice `h : i ≤ j`, with `q < 0`:
`IsZero (((K.spectralObjectSlice h).X p).X q)` for every column `p`.

Argument: target cell `(((K.cutoffColumnsEInt i).X p).X q)` is `IsZero` by the row-side cutoff vanishing above. The bicomplex slice projection is epi at the bicomplex level, hence at the column-level cell (via mathlib's auto-derived `HomologicalComplex` `Epi (φ.f n)`) AND at the row-level cell (second application of the same instance to the column-level morphism). With cell-level epi, `cancel_epi` on the slice cell projection reduces `id = 0` on the slice cell to the source-zero fact.

### Auxiliary helper

`isZero_cokernel_of_isZero_target_aux` (private). For any abelian category `C` and `f : X → Y` with `[HasCokernel f]` and `IsZero Y`: `IsZero (cokernel f)`. Proven via `cancel_epi (cokernel.π f)` and the source-zero argument forcing `id = 0` on the cokernel. (This is the abstract version of the argument used in both substantive lemmas; the substantive lemmas use the equivalent argument directly on the bicomplex slice projection rather than going through the cokernel comparison iso, to avoid `cokernelComparison` typeclass synthesis issues.)

### Non-vacuous evaluations (Z2g, NEW)

Four new evaluations on `trivialColumnZeroFirstQuadrant`:

1. `spectralObjectSlice_isZero_X_of_neg_col` at `(0 ≤ 0)` slice, column `p = -1`.
2. `spectralObjectSlice_isZero_X_of_neg_col` at non-reflexive `⊥ ≤ (0 : ℤ)` slice, column `p = -3`.
3. `spectralObjectSlice_isZero_X_X_of_neg_row` at `⊥ ≤ (0 : ℤ)` slice, cell `(0, -2)`.
4. `spectralObjectSlice_isZero_X_X_of_neg_row` at `⊥ ≤ (1 : ℤ)` slice, cell `(5, -7)` — verifies row-side vanishing at non-zero column too.

### Documentation

Substantial new docstring sections at the end of the file:

1. **"Deferred to Z2h (final follow-on)"** — describes:
   - **Z2h-A**: triple-filtration `ShortExact` upgrade plan using cell-level Splitting case analysis (4 cases A/B/C/D on the EInt triple vs the cell column).
   - **Z2h-B**: H-functor + δ + exactness assembly plan using `homologyFunctor n` + `ShortExact.δ` + `ShortExact.homology_exact₁/₂/₃`.
   - **Z2h-C**: `IsFirstQuadrant` instance composition plan using the Z2g-supplied slice cell-vanishing.
   - **Z2h-D**: convention reconciliation — the new finding from Z2g: Z2f's `spectralObjectSlice` is naturally **contravariant** as a `ComposableArrows EInt 1` functor (a morphism `mk₁(h) → mk₁(h')` gives `slice(h') → slice(h)`, not `slice(h) → slice(h')`), but Joël Riou's `SpectralObject` H-functor is **covariant**. Three resolution paths offered: (a) use `EInt^op` with transport, (b) reinterpret via SES boundary direction (the Z2f triple SES is the **transpose** of Joël's expected SES), or (c) accept reindexing in the record assembly.

## Build status

`lake build` GREEN (2043 jobs unchanged from Z2f baseline; the Z2g additions extend `Bicomplex.lean` from ~2544 to 2842 lines, +298 lines of substantive Z2g content). Sorry count stays at 1 (pre-existing Y6 chain-map-extension residual at `UnionClosed/UC11/SSConvergence.lean:563` unchanged from Lean-Sessions 34–43). Pre-existing `push_neg` deprecation warnings in `Frankl.lean` unchanged. Zero new sorrys / axioms / fake mathlib API / defeq tricks / `False.elim` / `decide` shortcuts in `Bicomplex.lean`.

## Files touched

* MODIFIED `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/Bicomplex.lean` (~2544 → 2842 lines; extends Z2f's existing file by +298 lines of substantive Z2g content; no new imports).
* NEW `docs/state-UC-Lean-Z2g.md` (this file).
* MODIFIED `docs/state-UC10.md` (Lean-Session 44 entry).

## Acceptance bar status (12 bars per scoping doc §0)

| # | Bar | Z2g status |
|---|-----|----------|
| 1 | lake build GREEN | ✅ PASS (2043 jobs unchanged) |
| 2 | Non-vacuous on `trivialColumnZeroFirstQuadrant` | ⚠ PARTIAL — slice cell-vanishing evaluates non-vacuously (4 examples); H + δ + IsFirstQuadrant evaluations deferred to Z2h |
| 3 | Mathlib-PR-clean naming + Joël-Riou-style docstrings | ✅ PASS (all new lemmas in Joël-Riou style with full docstrings; convention discussion in module-level docstring) |
| 4 | Zero new sorrys | ✅ PASS |
| 5 | Zero new axioms | ✅ PASS |
| 6 | No fake mathlib API | ✅ PASS (uses only mathlib `coequalizer.π_epi`, `HomologicalComplex` `Epi (φ.f n)` instance, `WithBotTop.rec`) |
| 7 | No defeq bypass | ✅ PASS |
| 8 | No `False.elim` | ✅ PASS |
| 9 | Type-correct | ✅ PASS |
| 10 | MATHLIB-FOLDER scope respected | ✅ PASS (only `Bicomplex.lean` modified) |
| 11 | Feeds-into-Z3 readiness | ❌ DEFERRED — full `K.spectralObject` record deferred to Z2h; the Z2g slice cell-vanishing IS a prerequisite for the Z2h `IsFirstQuadrant` instance |
| 12 | No L+X+Y dependencies | ✅ PASS |

## Strictly tighter than mg-165d (Z2f AMBER)

mg-165d landed Z2f Phase A.1 spectral-object slice infrastructure (cokernel + triple-filtration `ShortComplex` + 8 non-vacuous evaluations). This Z2g session strictly tightens the residual scope from "ShortExact upgrade + H + δ + exactness + IsFirstQuadrant" to:

* "**triple-filtration `ShortExact` upgrade** + **H + δ + exactness assembly** + **IsFirstQuadrant composition** + **convention reconciliation choice**" with:
  - Slice cell-vanishing infrastructure **landed** (the Z2h-C prerequisite).
  - Convention reconciliation analysis **landed** (the Z2h-D decision-input).
  - The remaining Z2h scope is strictly narrower: only the ShortExact upgrade + H/δ/exactness assembly + IsFirstQuadrant instance + a convention-choice decision.

The Z2g cell-vanishing lemmas are the load-bearing primitives for `IsFirstQuadrant`: once Z2h-A/B land the `K.spectralObject` record, the `IsFirstQuadrant.isZero₁` axiom follows from `spectralObjectSlice_isZero_X_of_neg_col` (plus totalisation/shift preservation of IsZero), and `isZero₂` follows from `spectralObjectSlice_isZero_X_X_of_neg_row`.

## What's the "convention reconciliation" issue?

(New finding from Z2g — adds context for Z2h scoping.)

Joël Riou's `SpectralObject C ι` (in `Mathlib.Algebra.Homology.SpectralObject.Basic`) has `H : ℤ → ComposableArrows ι 1 ⥤ C` (a **covariant** functor). For a triple `i ≤ j ≤ k` in `ι` (as `mk₂ f g : ComposableArrows ι 2`), the structure's `exact₂'` axiom requires the SES `H n(f) → H n(fg) → H n(g)` to be exact in the middle. This is the standard "kernel ↪ middle ↠ cokernel" pattern from a SES of objects.

For Joël's mapping-cone example (`HomotopyCategory.spectralObjectMappingCone`), this works out naturally when `H n(mk₁ f) = cone(f)` and the triangle is `cone(f) → cone(fg) → cone(g) [+1]` (the standard distinguished triangle of a composition). With **HOMOLOGICAL** filtration convention (`F^i ⊆ F^j` for `i ≤ j`), `cone(f : i → j)` ≅ `F^j / F^i`, and the SES `F^j/F^i ↪ F^k/F^i ↠ F^k/F^j` is the third iso theorem in the direction matching Joël's `exact₂'`.

For **COHOMOLOGICAL** filtration convention (`F^i ⊇ F^j` for `i ≤ j`, which is Z2's setup), `spectralObjectSlice(h : i ≤ j) = F^i / F^j` realises the cohomological-style slice. The natural third iso theorem direction is `F^j/F^k ↪ F^i/F^k ↠ F^i/F^j` (= `slice(j,k) ↪ slice(i,k) ↠ slice(i,j)`, which is what Z2f set up). This is the **transpose** of Joël's expected SES direction.

Equivalently: for a morphism `α : mk₁(h : i ≤ j) → mk₁(h' : i' ≤ j')` in `ComposableArrows EInt 1` (with `i ≤ i'` and `j ≤ j'`), the natural map between cohomological slices goes `slice(h') → slice(h)` (the cokernel functoriality on the EInt naturality square), NOT `slice(h) → slice(h')`. So `K.spectralObjectSlice` is naturally **contravariant** as a functor on `ComposableArrows EInt 1` — incompatible with Joël's covariant H-functor.

This is **not** a Lean error; it's a mathematical convention mismatch that Z2 has been silently building towards. Z2h needs to pick one of three resolutions:

**(a)** Define `K.spectralObject : SpectralObject (HomologicalComplex C c₂) EIntᵒᵖ` and provide a transport-via-`Equivalence` to `EInt`-indexed for Z3 compatibility. Pros: mathematically clean — the EInt^op indexing accurately reflects that cohomological filtration is the opposite of the homological direction. Cons: requires building or finding the SpectralObject opposite-category equivalence.

**(b)** Reinterpret the H-functor via the **SES boundary direction**. Joël's `exact₂'` requires the SES `H(f) → H(fg) → H(g)` is exact; Z2f's actual SES is `slice(g) → slice(fg) → slice(f)` (the transpose). One could define `H n(mk₁ f)` to be the **second** cell of the SES rather than the **first**, formally identifying f in Joël's framework with g in Z2f's setup. Pros: stays in `EInt`-indexed land. Cons: requires careful re-indexing of every Joël-side construction and a potentially confusing relabeling.

**(c)** Accept the cohomological-direction H-functor and provide an explicit `EInt → EInt^op` reindexing in the record assembly itself. Pros: most pragmatic. Cons: introduces a "reindexing morphism" that may complicate Z3 consumer code.

The Z2h ticket will pick one path after either a short Daniel-coordinated Zulip RFC or a local-only decision.

## What's left for Z2h

* **Z2h-A**: triple-filtration `ShortExact` upgrade (cell-level Splitting via 4-case analysis).
* **Z2h-B**: `K.spectralObject` H + δ + three exactness assembly (using Z2h-D convention choice).
* **Z2h-C**: `IsFirstQuadrant` instance composition (using Z2g slice cell-vanishing).
* **Z2h-D**: convention reconciliation choice (a/b/c above).

After Z2h GREEN, Z2 scope FULLY closed and Z3 dispatches.

## Forward operational step

Daniel reviews Z2g AMBER + Z2h-D convention reconciliation analysis, then either (1) files Z2h (UC-Lean-Z2h-Z2ScopeClosure) as next sequential sub-ticket, or (2) opens a strategic-audit conversation on whether to continue the Z2 sub-split pattern or pause for the Z-arc strategic review per the ticket's "After Z2g AMBER" provision and the pattern-flag note ("structural-review caveat exceeded twice").

The Z2g substantive cell-vanishing infrastructure is in place for Z2h-C; the Z2h-D convention choice is a Daniel decision-input that ideally happens before Z2h-A/B work begins.
