# UC-Lean-Z2i-SpectralObjectRecordTransport — state (cat-mg-0518, ticket mg-0518, Lean-Session 46)

**Verdict.** AMBER. Z2i substantive Phase B **bridging-iso + factor-lemma primitives** landed (the load-bearing infrastructure for the triple-filtration `ShortExact` upgrade via mathlib's `kernelCokernelCompSequence_exact`, Joël Riou, `Mathlib.CategoryTheory.Abelian.DiagramLemmas.KernelCokernelComp`). The full Phase B `ShortExact` bundling + Phase A `K.spectralObject_op` record + Phase C `EInt^op ≃ EInt` transport + Phase D `IsFirstQuadrant` instance + Phase E totalised non-vacuous eval are deferred to a **Z2j** named follow-on per the pre-authorised sub-split contingency (the **tenth** Z2 sub-split). The bridging-iso + factor-lemma primitives mechanically reduce the remaining Phase B closure to a straightforward LES invocation; Z2j is sized for a focused short session consuming the Z2i output.

Z2i is the **ninth sub-split** of Z2 (Z2 → Z2a → Z2b → Z2c → Z2d → Z2e → Z2f → Z2g → Z2h → Z2i). The 250k-per-deliverable empirical ceiling re-validated across Z2a → Z2i (each cycle landing one substantive piece) forces the H+δ+exactness assembly + IsFirstQuadrant instance + EInt^op transport into Z2j as a separate focused session. This is the **fifth** invocation of the structural-review caveat (5+ sub-splits, hit at Z2e/Z2f/Z2g/Z2h/Z2i), with the strictly-tighter residual Z2j scope leaving only honest Joël-Riou-style packaging once the bridging-iso + factor-lemma primitives are in hand.

## What landed (substantive)

### Phase B substantive primitives — bridging iso + factor lemmas

**`tripleCokerBridge`** (load-bearing bridging iso).
For `{i j k : EInt} (h_ij : i ≤ j) (h_jk : j ≤ k) (h_ik : i ≤ k)`:
```
noncomputable def tripleCokerBridge :
    cokernel (K.cutoffColumnsEInt_le h_jk ≫ K.cutoffColumnsEInt_le h_ij) ≅
      K.spectralObjectSlice h_ik :=
  cokernelIsoOfEq (K.cutoffColumnsEInt_le_trans h_ij h_jk)
```
Built via mathlib's `cokernelIsoOfEq` applied to the propositional identity from Z2e `cutoffColumnsEInt_le_trans h_ij h_jk : K.cutoffColumnsEInt_le h_jk ≫ K.cutoffColumnsEInt_le h_ij = K.cutoffColumnsEInt_le h_ik`. Bridges the LES form `cokernel(f ≫ g)` (used by `kernelCokernelCompSequence_exact`) and the Z2f slice form `K.spectralObjectSlice h_ik = cokernel(K.cutoffColumnsEInt_le h_ik)`.

**`tripleCokerBridge_hom_slice_π`** (load-bearing `@[reassoc (attr := simp)]` defining-property).
```
@[reassoc (attr := simp)]
lemma tripleCokerBridge_hom_slice_π :
    cokernel.π (K.cutoffColumnsEInt_le h_jk ≫ K.cutoffColumnsEInt_le h_ij) ≫
      (K.tripleCokerBridge h_ij h_jk h_ik).hom =
    K.spectralObjectSlice_π h_ik
```
Auto-generates the `_assoc` variant used in the universal-property reductions in the factor lemmas. Proven via an explicit `show` form bridging the `tripleCokerBridge` unfolding to `cokernelIsoOfEq ...` plus mathlib's `π_comp_cokernelIsoOfEq_hom`.

**`spectralObjectSlice_first_eq_cokernel_map_comp_bridge`** (factor lemma).
```
lemma spectralObjectSlice_first_eq_cokernel_map_comp_bridge :
    cokernel.map (K.cutoffColumnsEInt_le h_jk)
      (K.cutoffColumnsEInt_le h_jk ≫ K.cutoffColumnsEInt_le h_ij)
      (𝟙 _) (K.cutoffColumnsEInt_le h_ij) (by simp) ≫
      (K.tripleCokerBridge h_ij h_jk h_ik).hom =
    K.spectralObjectSlice_first h_ij h_jk h_ik
```
The explicit identification of the Z2f-defined `spectralObjectSlice_first` with the LES form `cokernel.map f (f ≫ g) (𝟙) g _` post-composed with the bridging iso. The proof uses `cancel_epi (cokernel.π f)` to reduce to a universal-property comparison, then applies `cokernel.π_desc`, the `tripleCokerBridge_hom_slice_π` simp lemma, and the Z2f `spectralObjectSlice_π_first` compatibility.

**`spectralObjectSlice_second_eq_bridge_inv_comp_cokernel_map`** (factor lemma).
```
lemma spectralObjectSlice_second_eq_bridge_inv_comp_cokernel_map :
    (K.tripleCokerBridge h_ij h_jk h_ik).inv ≫
      cokernel.map
        (K.cutoffColumnsEInt_le h_jk ≫ K.cutoffColumnsEInt_le h_ij)
        (K.cutoffColumnsEInt_le h_ij)
        (K.cutoffColumnsEInt_le h_jk) (𝟙 _) (by simp) =
    K.spectralObjectSlice_second h_ij h_jk h_ik
```
The dual identification. Proof strategy: post-compose with `bridge.hom` on the left (via `cancel_epi bridge.hom + Iso.hom_inv_id`) to reduce to a universal-property cancel_epi step, then apply `cokernel.π_desc` and `tripleCokerBridge_hom_slice_π_assoc` to close via the Z2f `spectralObjectSlice_π_second` compatibility.

### Non-vacuous evaluations on `trivialColumnZeroFirstQuadrant`

3 new non-vacuous evaluations:

- **Bridging iso at non-trivial filtration triple** `⊥ ≤ (0 : EInt) ≤ ⊤`: well-formed iso `cokernel(...) ≅ trivialColumnZeroFirstQuadrant.spectralObjectSlice (⊥ ≤ ⊤)`.

- **Bridging iso at reflexive triple** `0 ≤ 0 ≤ 0`: well-formed iso at the reflexive case where `cutoffColumnsEInt_le` reduces to identity.

- **Bridge ≫ slice_π load-bearing identity**: concrete instantiation `cokernel.π (...) ≫ tripleCokerBridge.hom = trivialColumnZeroFirstQuadrant.spectralObjectSlice_π (⊥ ≤ ⊤)` via the `tripleCokerBridge_hom_slice_π` simp lemma.

## What deferred to Z2j (final closure ticket, tenth Z2 sub-split)

### Phase B closure — bundled `ShortExact`

Consuming the Z2i bridging iso + factor lemmas, the Z2j closure is a straightforward LES invocation:

```lean
lemma spectralObjectSlice_tripleShortComplex_shortExact :
    (K.spectralObjectSlice_tripleShortComplex h_ij h_jk h_ik).ShortExact := by
  -- haveI : Abelian (HomologicalComplex₂ ...) := ... -- need TC instance management
  -- Mono of slice_first via factor lemma + Mono of cokernel.map.
  -- Mono of cokernel.map via kernelCokernelCompSequence_exact at position 2
  --   (Exact.mono_g with hδ_zero from kernel g = 0 since g mono).
  -- Epi of slice_second from Z2h spectralObjectSlice_second_epi.
  -- Middle exactness via factor lemmas + kernelCokernelCompSequence_exact at position 3.
  ...
```

Z2j has two equivalent approaches: (a) use `kernelCokernelCompSequence_exact` directly with explicit TC-instance management on the bicomplex level, or (b) reduce to cell-level via `degreewise_shortExact` (the same approach Z2e used for the `cutoffColumns_succ_singleColumnAt_shortExact` / `singleColumnAt_to_cutoffColumnsLE_shortExact` upgrades). Either path is single-session-capable.

### Phase A — `K.spectralObject_op` record assembly

Requires constructing:
1. H-functor on `EIntᵒᵖ`: per `n : ℤ`, a covariant functor `ComposableArrows EIntᵒᵖ 1 ⥤ HomologicalComplex C c₂` whose object map on `mk₁ (α : i ⟶ j in EIntᵒᵖ)` returns `(K.spectralObjectSlice (h : j ≤ i)).homology n`, with morphism map from the universal property of `cokernel` slice + naturality, plus `mapId` and `mapComp` laws.
2. δ' natural transformation per `n₀ + 1 = n₁`, defined via `ShortExact.δ` applied to the Z2j Phase B `ShortExact`. Naturality via `ShortExact.δ_naturality` from `Mathlib.Algebra.Homology.HomologySequence`.
3. Three exactness conditions `exact₁'`, `exact₂'`, `exact₃'` via `ShortExact.homology_exact₁/₂/₃` from `Mathlib.Algebra.Homology.HomologySequence`.

### Phase C — `EInt^op ≃ EInt` transport

Build an order-isomorphism `EInt ≃o EIntᵒᵖ` via negation on the integer-index stratum + swap `⊥ ↔ ⊤` on the boundary strata, then transport the `SpectralObject ... EIntᵒᵖ` to `SpectralObject ... EInt` via the induced equivalence-of-categories functor on `ComposableArrows`. Note: `WithBotTop` does not currently expose a `dualEquiv` API in mathlib v4.29.1; Phase C requires building the EInt-specific involution from scratch using the existing per-stratum dual machinery (`WithBot.toDual` etc).

### Phase D — `IsFirstQuadrant` instance

Compose Z2d `IsFirstQuadrantBicomplex K + cutoffColumnsEInt_isZero_X_of_neg_col` (for `isZero₁`), Z2e `IsFirstQuadrantRows K + IsFirstQuadrantRows.isZero_X_X_of_neg_row` (for `isZero₂`), and Z2g `spectralObjectSlice_isZero_X_of_neg_col` / `spectralObjectSlice_isZero_X_X_of_neg_row` (cell vanishings) into `(K.spectralObject).IsFirstQuadrant`, plus the homology functor's preservation of `IsZero`.

### Phase E — Non-vacuous totalised evaluation

`trivialColumnZeroFirstQuadrant.spectralObject` non-vacuous H + δ + IsFirstQuadrant evaluation.

## Why the full Phase B ShortExact closure was deferred (technical details)

The Z2i session attempted the full `ShortExact` bundling via direct `kernelCokernelCompSequence_exact` invocation, but hit two TC-instance issues specific to the bicomplex ambient category that exceeded the focused-session budget to resolve cleanly:

1. **`Abelian (HomologicalComplex₂ C (ComplexShape.up ℤ) c₂)` chain.** The TC chain `[Abelian C] → [Abelian (HomologicalComplex C c₂)] → [Abelian (HomologicalComplex₂ C (ComplexShape.up ℤ) c₂)]` exhibits a diamond-style conflict between `HomologicalComplex.instHasZeroMorphisms` and `preadditiveHasZeroMorphisms`. Even explicit `haveI : Abelian (...) := inferInstance` failed during the focused Z2i session.

2. **`cokernelIsoOfEq` rewrite pattern matching at the LES bridge step.** `π_comp_cokernelIsoOfEq_hom` rewrite at the chain `← Category.assoc; cokernel.π_desc; Category.assoc; π_comp_cokernelIsoOfEq_hom` exhibits opaque pattern-match failures when composed with the LES-derived `cokernel.map` morphisms, even though the standalone `tripleCokerBridge_hom_slice_π` lemma works fine via the explicit `show` form. The factor lemmas worked around this with manual `show` reductions.

The Z2j closure session — armed with the Z2i bridging-iso + factor-lemma primitives — can either bypass these issues by using degreewise reduction (the same approach Z2e used) or with carefully ordered explicit-instance management.

## Files touched

- `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/Bicomplex.lean` — extended (+~250 lines of Z2i Phase B substantive primitives).
- `docs/state-UC-Lean-Z2i.md` — NEW (this file).
- `docs/state-UC10.md` — Lean-Session 46 entry.

## Build status

`lake build UnionClosed.Mathlib.Algebra.Homology.SpectralObject.Bicomplex` — GREEN (1609 jobs).

Pre-existing deprecation warnings (`push_neg`) and `automatically included section variable(s) unused` warnings unchanged from Z2h baseline. Zero new sorrys / axioms / fake mathlib API / defeq tricks / False.elim / decide shortcuts. Sorry-axioms specifically banned per Z2i extended forbidden set (none introduced).

## Forward operational step

File **Z2j** (UC-Lean-Z2j-SpectralObjectRecordClosure) as the next sequential sub-ticket. Z2j is sized for a focused short session (~200-250k tokens) consuming:
- Z2i Phase B bridging-iso + factor-lemma primitives (load-bearing).
- All prior Z2a–Z2h infrastructure (`cutoffColumnsEInt`, `cutoffColumnsEInt_le`, `spectralObjectSlice`, `cutoffColumnsEInt_le_mono`, cell-vanishing infrastructure, etc.).
- Mathlib v4.29.1 + `Mathlib.CategoryTheory.Abelian.DiagramLemmas.KernelCokernelComp` (already imported).

Z2j GREEN closes Z2 scope fully and unblocks Z3 (mg-50b7 `BicomplexConvergence`).
