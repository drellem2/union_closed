# UC-Lean-Z2h-SpectralObjectRecordFinal — state (cat-mg-1543, ticket mg-1543, Lean-Session 45)

**Verdict.** AMBER. Z2h substantive Phase B Mono infrastructure landed for the GE-side filtration inclusions (cell-wise via `HomologicalComplex.mono_of_mono_f` to either cell-iso or zero-from-IsZero-source), promoted to a load-bearing `cutoffColumnsEInt_le_mono` instance lemma via 9-case EInt induction. The slice projection `spectralObjectSlice_π_epi` is exposed as a named epi lemma, and the `spectralObjectSlice_second_epi` (one of the three triple-filtration `ShortExact` conditions) is closed by factoring through the `cokernel.π` epi. The full `K.spectralObject` record assembly (H + δ + three exactness conditions) + `IsFirstQuadrant` instance + the remaining two `ShortExact` conditions (`Mono` of slice_first + middle exactness) are deferred to a **Z2i** named follow-on per the pre-authorised sub-split contingency, with the convention-reconciliation analysis now refined: a cell-by-cell map between cohomological slices fails at the differential boundary (`slice(h).d (j-1) j = 0` vs `slice(h').d (j-1) j = K.d (j-1) j` — naturality requires `0 = K.d (j-1) j` which is not generally true), so the resolution path (a) `EInt^op` via `WithBotTop.dualEquiv` is favored.

Z2h is the **eighth sub-split** of Z2 (Z2 → Z2a → Z2b → Z2c → Z2d → Z2e → Z2f → Z2g → Z2h). Z2i (ninth) is the strictly-tighter named follow-on closing Z2 scope.

## What landed (substantive)

### Phase B.1 — Mono lemmas for the GE-side filtration inclusions

**Cell-wise mono via `mono_of_isZero_src` helper.** A private `mono_of_isZero_src` helper proves that any morphism from an `IsZero` source is automatically mono (right-cancellation forced by `IsZero.eq_of_tgt`). Used to dispatch the IsZero-cell cases of the bicomplex mono proofs.

**`cutoffColumns_inclusion_mono`** (`K.cutoffColumns p ⟶ K`).
Cell-wise via `HomologicalComplex.mono_of_mono_f`. At column `p'`:
- `p ≤ p'`: cell is `(K.cutoffColumns_XIso_of_le hp).hom`, an iso, mono via `IsIso.mono_of_iso`.
- `p' < p`: cell is `0`, mono via `mono_of_isZero_src` applied to `K.cutoffColumns_isZero_X_of_lt`.

**`cutoffColumns_inclusion_le_mono`** (`K.cutoffColumns q ⟶ K.cutoffColumns p` for `p ≤ q`).
Same cell-wise structure: at `q ≤ p'` the cell is a composition of two cell-isos (mono via `mono_comp`); at `p' < q` the cell is `0` from an `IsZero` source.

**`cutoffColumnsEInt_le_mono` (load-bearing)** (`K.cutoffColumnsEInt j ⟶ K.cutoffColumnsEInt i` for `i ≤ j` in EInt).
Via 9-case `WithBotTop.rec` induction on `(i, j)`. Three impossible orderings (`(coe _, ⊥)`, `(⊤, coe _)`, `(⊤, ⊥)`) are discharged via `simp at h`. Six compatible orderings reduce to:
- `(⊥, ⊥)`, `(⊤, ⊤)`: identity (`instMonoId`).
- `(⊥, coe q)`: `cutoffColumns_inclusion q` mono via `cutoffColumns_inclusion_mono`.
- `(⊥, ⊤)`, `(coe _, ⊤)`: zero from `isZero_cutoffColumnsEInt_top` via `mono_of_isZero_src`.
- `(coe p, coe q)` with `p ≤ q`: `cutoffColumns_inclusion_le hpq` mono via `cutoffColumns_inclusion_le_mono`.

This is the load-bearing EInt-indexed mono that the Z2i SpectralObject δ assembly will use via mathlib's `kernelCokernelCompSequence_exact` (Joël Riou, `Mathlib.CategoryTheory.Abelian.DiagramLemmas.KernelCokernelComp`).

### Phase B.2 — Slice projection epi and triple-filtration epi-second

**`spectralObjectSlice_π_epi`**. The Z2f `K.spectralObjectSlice_π h` is by definition `cokernel.π (K.cutoffColumnsEInt_le h)`, hence `Epi` via mathlib's `coequalizer.π_epi`. Exposed as a named lemma for use in the Z2i triple-filtration `ShortExact` proof and the H-functor epi-mono factorisation.

**`spectralObjectSlice_second_epi`** (one of three triple-filtration `ShortExact` conditions). The Z2f `spectralObjectSlice_second h_ij h_jk h_ik` is shown `Epi` by factoring through the `cokernel.π` epi: the Z2f compatibility lemma `spectralObjectSlice_π_second` gives `spectralObjectSlice_π h_ik ≫ spectralObjectSlice_second h_ij h_jk h_ik = spectralObjectSlice_π h_ij`, the RHS is `Epi` (via `spectralObjectSlice_π_epi h_ij`), and `epi_of_epi (spectralObjectSlice_π h_ik)` lifts the composition's `Epi` back to `spectralObjectSlice_second`.

### Non-vacuous evaluations

4 new non-vacuous evaluations on `trivialColumnZeroFirstQuadrant` (Z2d test bicomplex):
- `Mono` at `⊥ ≤ (0 : ℤ)` (the non-trivial filtration-inclusion case).
- `Mono` at the reflexive case `(0 : EInt) ≤ (0 : EInt)` (identity case).
- `Mono` at the zero-target case `(0 : EInt) ≤ ⊤` (mono from IsZero target degenerating to zero map).
- `Epi` of the spectral-object slice projection at `⊥ ≤ (0 : ℤ)`.

## What did NOT land

### Phase B remainder — Triple-filtration `ShortExact` upgrade (Mono of slice_first + middle exactness)

The substantive prerequisites (all three Mono instances + Epi of slice_second) are landed; the remaining two conditions of `ShortExact` (`Mono` of `spectralObjectSlice_first` + `Exact` at the middle position) should be derivable via mathlib's `kernelCokernelCompSequence_exact` (Joël Riou, `Mathlib.CategoryTheory.Abelian.DiagramLemmas.KernelCokernelComp`) applied to the composition of the Z2h-proven monos.

The Z2h session attempted this via `cokernel.mapIso`-based iso transport from the cokernel.map ShortComplex to our `spectralObjectSlice_tripleShortComplex` (using `ShortComplex.shortExact_iff_of_iso`), but hit motive-detection issues at the `cokernel.mapIso` ext step where the bicomplex-level Abelian instance for `HomologicalComplex₂` was not being auto-derived from `[Abelian C]` (likely needs explicit `haveI : Abelian (HomologicalComplex C c₂)` at the relevant scope). An alternative implementation path: use a fresh `ShortComplex.SnakeInput` directly on the inclusion-of-inclusions diagram, which avoids the `cokernel.mapIso` iso-transport overhead.

### Phase A — `SpectralObject` H-functor + δ + three exactness conditions

Deferred to Z2i. The convention obstacle is now precisely characterised:

**Convention obstacle (technical refinement during Z2h).** The Z2f `spectralObjectSlice (h : i ≤ j) = cokernel (cutoffColumnsEInt_le h)` realising `F^{≥i}/F^{≥j}` is naturally **contravariant** as a functor on `ComposableArrows EInt 1`. A cell-by-cell map attempt fails at the **differential boundary**:

- Source `slice(h:i≤j)` at column `p ∈ [i, j-1]`: cell `K.X p` with differential to col `p+1` (in slice) being `K.d p p+1` if `p+1 ∈ [i, j-1]`, else `0` (target cell zero).
- Target `slice(h':i'≤j')` with `i ≤ i'`, `j ≤ j'`: cells overlap at `[i', j-1]`, with target's range possibly extending beyond at both ends.
- At `p = j-1` boundary (where `j ≤ j'` strict): source slice `d (j-1) j = 0` (target col `j` is zero in source), but target slice `d (j-1) j = K.d (j-1) j` (target col `j` is kept in target).
- Naturality square: `source_d (j-1) j ≫ map_j = map_(j-1) ≫ target_d (j-1) j`, i.e., `0 ≫ ... = identity ≫ K.d (j-1) j` = `0 = K.d (j-1) j` — generally false.

So **no natural covariant bicomplex map of slices exists** in the cohomological convention. Joël Riou's `SpectralObject EInt` framework expects covariance.

**Z2i resolution paths** (refined three options):

- **(a) Use `EIntᵒᵖ` indexing + transport**: Build `K.spectralObject_op : SpectralObject (HomologicalComplex C c₂) EIntᵒᵖ` using the existing Z2a–Z2h cohomological infrastructure (slice contravariant in EInt = covariant in EIntᵒᵖ). Provide an explicit transport via the `Equivalence.SpectralObject_opposite`-style construction adapted to `WithBotTop.dualEquiv` (or via `orderDualEquivalence : Xᵒᵈ ≌ Xᵒᵖ` from `Mathlib.CategoryTheory.Category.Preorder`) to obtain `K.spectralObject : SpectralObject (HomologicalComplex C c₂) EInt`.
  **Recommended path** (reuses all Z2a–Z2h infrastructure, single-session-capable since the transport is essentially currying through a preorder equivalence).

- **(b) LE-side EInt extension** (homological convention): Build a parallel EInt extension `cutoffColumnsLEEInt`, `cutoffColumnsLEEInt_le`, `spectralObjectSlice_LE`, etc., on the LE-side cutoff (which is COVARIANT in `p` direction since `cutoffColumnsLE(p) ⊆ cutoffColumnsLE(q)` for `p ≤ q`). The LE-side slice `cutoffColumnsLE(j)/cutoffColumnsLE(i)` for `i ≤ j` gives a directly-covariant `SpectralObject (HomologicalComplex C c₂) EInt`.
  Conservative fallback. Sized similarly to Z2d–Z2h combined (~1.5M tokens, 5–6 sub-sessions). Avoid unless path (a) blocks.

- **(c) Cohomological + reindexing**: Accept the cohomological-direction H-functor with an explicit `EInt → EIntᵒᵖ` reindexing in the record assembly. Z3 then needs to adapt to consume `SpectralObject ... EIntᵒᵖ` or provide its own transport.
  Pushes the problem downstream; less clean than (a).

### Phase C — `IsFirstQuadrant` instance composition

Deferred to Z2i. Once `K.spectralObject : SpectralObject (HomologicalComplex C c₂) EInt` is in hand (via path (a) of Phase A), the `IsFirstQuadrant` instance composes from:
- Z2d's `IsFirstQuadrantBicomplex K → cutoffColumnsEInt_isZero_X_of_neg_col` for the `isZero₁` condition (slice vanishing when `j ≤ 0` cohomologically).
- Z2e's `IsFirstQuadrantRows K → IsFirstQuadrantRows.isZero_X_X_of_neg_row` for the `isZero₂` condition (slice vanishing when `n < i`).
- Z2g's `spectralObjectSlice_isZero_X_of_neg_col` and `spectralObjectSlice_isZero_X_X_of_neg_row` to lift the cell vanishings through the slice's `cokernel` construction (these are the load-bearing Z2g primitives that the Z2i `IsFirstQuadrant` instance will directly consume).
- Plus totalisation preservation of `IsZero` (`HomologicalComplex.total_isZero_of_isZero` or equivalent) and shift preservation by `n : ℤ`.

## Engineering choices

**`mono_of_isZero_src` helper inline.** A 1-line private helper proving `Mono f` from `IsZero source f`. This is genuinely missing from mathlib (only the converse `IsZero.of_mono` is provided). Could be PR'd upstream as a standalone `Mono.of_isZero_src` instance/lemma in `Mathlib.CategoryTheory.Limits.Shapes.ZeroMorphisms`.

**9-case `WithBotTop.rec` for `cutoffColumnsEInt_le_mono`.** Matches the established pattern from Z2d's `cutoffColumnsEInt_le` definition and Z2e's `cutoffColumnsEInt_le_trans`. Three impossible orderings discharged via `simp at h`; six compatible orderings hand off to the integer-index mono lemmas (`cutoffColumns_inclusion_mono`, `cutoffColumns_inclusion_le_mono`) or trivial identity / zero-from-IsZero.

**Lemma (not instance) for the Mono primitives.** Declared as `lemma` rather than `instance` to avoid TC search loop ambiguities at use sites where the instance would need to match against a specific `K` (a section variable, explicit). At use sites, the mono is obtained via explicit invocation `K.cutoffColumnsEInt_le_mono h` or via `haveI`-binding.

**`epi_of_epi` for `spectralObjectSlice_second_epi`.** Mathlib's `epi_of_epi (f : X ⟶ Y) (g : Y ⟶ Z) [Epi (f ≫ g)] : Epi g` takes the first factor `f` as the explicit argument and infers the `Epi (f ≫ g)` via TC. The proof composes `spectralObjectSlice_π h_ik` (epi by `spectralObjectSlice_π_epi`) with `spectralObjectSlice_second` to obtain `spectralObjectSlice_π h_ij` (epi by same), then peels back to epi of `spectralObjectSlice_second`.

**Triple-filtration `ShortExact` deferred to Z2i** (not Z2h's failed iso-transport attempt). The cleaner Z2i implementation path is a direct `ShortComplex.SnakeInput` construction from the inclusion-of-inclusions SES diagram, which avoids the `cokernel.mapIso` motive-detection issues encountered in the Z2h iso-transport attempt.

## Lake build

GREEN. 1609 jobs (baseline 1604 + 5 new from `Mathlib.CategoryTheory.Abelian.DiagramLemmas.KernelCokernelComp` dependency chain). No new `sorry`/axiom/fake mathlib API/defeq tricks/False.elim/decide shortcuts. Two `[Abelian C]` unused-section-variable lints inherited from existing file pattern (matches pre-existing `push_neg` deprecation warning style; could be cleaned up in a future mathlib-PR-pass).

## Convention reconciliation: precise mathematical analysis (NEW in Z2h)

The Z2g session identified the convention obstacle but did not analyse the EXACT failure point. The Z2h session refined the analysis to the differential-boundary level:

For `slice(h:i≤j) = cokernel(cutoffColumnsEInt(j) → cutoffColumnsEInt(i))` realising `F^{≥i}/F^{≥j}` in the cohomological convention, the slice has cells:
- `(slice(h)).X p = K.X p` if `i ≤ p < j`, else `0`.
- Differential `slice(h).d p p+1`: induced from `cutoffColumnsEInt(i).d`, which is `K.d` on kept cells. The cokernel collapse forces the differential at the boundary `p = j-1, p+1 = j` to be `0` (target cell zero in slice).

For a putative covariant map `slice(h:i≤j) → slice(h':i'≤j')` with `i ≤ i'`, `j ≤ j'`, the natural cell-wise candidate:
- `p ∈ [i, i'-1]`: source `K.X p`, target `0` → cell map `0` (forced).
- `p ∈ [i', j-1]` (assuming `i' ≤ j`): source `K.X p`, target `K.X p` → cell map `identity`.
- `p ∈ [j, j'-1]`: source `0`, target `K.X p` → cell map `0` (forced).

Differential compatibility at `p = j-1` boundary (the failure point):
- Source `slice(h).d (j-1) j = 0` (target cell `j` is `0` in source slice).
- Target `slice(h').d (j-1) j = K.d (j-1) j` (target cell `j` is `K.X j` in target slice, since `j < j'`).
- Cell map at `j-1`: `identity` (per cases above, assuming `i' ≤ j-1`).
- Cell map at `j`: `0 → K.X j` is the zero map (source is `0`).
- Naturality: `source.d ≫ map_{p+1} = map_p ≫ target.d`, i.e., `0 ≫ 0 = identity ≫ K.d (j-1) j` → `0 = K.d (j-1) j` — generally FALSE.

So no covariant cell-by-cell bicomplex map exists. The natural direction is `slice(h') → slice(h)` (mirroring the cohomological filtration's natural restriction-then-project), and this is COVARIANT in `mk₁(h') → mk₁(h)`, i.e., contravariant in the EInt direction.

This is why the resolution requires either `EIntᵒᵖ` indexing or the LE-side homological cutoff (where the natural slice IS covariant in EInt). The Z2g session's three resolution options remain valid; the Z2h analysis pins down the precise reason path (b) — direct cell-by-cell map in cohomological convention — does NOT work.

## Z2 cumulative status

The Z2h session lands the load-bearing Mono infrastructure + Epi-of-slice-second (one of three `ShortExact` conditions), strictly tightening the residual from "triple-filtration ShortExact upgrade + H+δ+exactness assembly + IsFirstQuadrant composition + convention reconciliation choice" (Z2g end state) to "Mono of slice_first + middle exactness + H+δ+exactness assembly + IsFirstQuadrant composition + convention reconciliation choice (path (a) recommended)" (Z2h end state).

The 8th Z2 sub-split fires the structural-review caveat for the FOURTH time (5+ sub-splits warning exceeded at Z2e, 6th, 7th, and now 8th). Each Z2 sub-split has landed one substantive piece on the cumulative Z2 infrastructure tower:
- Z2a: object filtration (`cutoffColumns`, `singleColumnAt`, `filtrationOnTotal`, `grOnTotal` via mathlib's `stupidTrunc`)
- Z2b: GE-side SES (`cutoffColumns_inclusion`, `cutoffColumns_succ`, `cutoffColumns_succ_singleColumnAt_shortComplex` + Joël Riou's `stupidTruncInclusion` mathlib-TODO closure)
- Z2c: LE-side SES (`cutoffColumnsLE_projection`, `cutoffColumnsLE_succ`, `singleColumnAt_to_cutoffColumnsLE_shortComplex` + Joël Riou's `stupidTruncProjection` mathlib-TODO closure)
- Z2d: EInt extension + `IsFirstQuadrantBicomplex` typeclass + cell-vanishing + `trivialColumnZeroFirstQuadrant` test bicomplex
- Z2e: ShortExact upgrade for both GE/LE pair-level SESes + `IsFirstQuadrantRows` typeclass + full 9-case EInt transitivity + reflexivity at integer indices
- Z2f: spectralObjectSlice cokernel + triple-filtration ShortComplex (composition-zero) + 8 non-vacuous evaluations
- Z2g: spectralObjectSlice cell vanishings (column-side + row-side) + convention-reconciliation analysis identification
- **Z2h** (this session): EInt-indexed Mono lemmas for filtration inclusions + slice-projection-epi helpers + spectralObjectSlice_second_epi (1 of 3 ShortExact conditions) + convention-reconciliation analysis refinement (differential-boundary failure point)

The Z2i target is the closure: convention-reconciliation choice + record assembly + `IsFirstQuadrant` instance via path (a) `EIntᵒᵖ` transport. With every needed building block in place from Z2a–Z2h, Z2i should fit a focused single session via path (a).

## Forward operational step

File Z2i (`UC-Lean-Z2i-SpectralObjectRecordTransport`) as next sequential sub-ticket. The scope:

- **Z2i.A**: Build `K.spectralObject_op : SpectralObject (HomologicalComplex C c₂) EIntᵒᵖ` using existing cohomological infrastructure (slice contravariant in EInt = covariant in EIntᵒᵖ).
- **Z2i.B**: Complete the triple-filtration `ShortExact` upgrade (the remaining `Mono` of `slice_first` + middle exactness, via `ShortComplex.SnakeInput` from the inclusion SES diagram OR direct `kernelCokernelCompSequence_exact` invocation now that Mono prerequisites are landed).
- **Z2i.C**: Transport `K.spectralObject_op` across `EIntᵒᵖ ≃ EInt` via `orderDualEquivalence` (or a custom `WithBotTop.dualEquiv` if simpler) to obtain `K.spectralObject : SpectralObject (HomologicalComplex C c₂) EInt`.
- **Z2i.D**: Compose Z2d/Z2e/Z2g cell-vanishing primitives into `(K.spectralObject).IsFirstQuadrant`.
- **Z2i.E**: Non-vacuous evaluation on `trivialColumnZeroFirstQuadrant`.

Z3 (mg-50b7) auto-dispatches per pre-filed depends-chain (after Z2i merge, with edit to add Z2i dependency).

Per `feedback_mathlib_pr_grade_250k_per_deliverable_ceiling`: 250k-per-deliverable ceiling now empirically confirmed across 8 cycles (Z2a → Z2b → Z2c → Z2d → Z2e → Z2f → Z2g → Z2h). The Z2 8-sub-ticket decomposition matches the cumulative substantive-content-per-session pattern observed throughout the Z arc. The 5+ sub-splits warning has been exceeded 4 times — Daniel-coordinated structural review is warranted before Z3-Z10 dispatch to determine whether to pre-split Z3-Z10 proactively given the Z2 empirical pattern.
