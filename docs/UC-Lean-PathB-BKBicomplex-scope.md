# UC-Lean-PathB-BKBicomplex-scope.md

**Scoping doc for the Path B execution arc: BKBicomplex full construction + Walsh-equivariant structure + Homotopy bridge.**

Ticket: mg-e1b8 (`UC-Lean-PathB-BKBicomplex-scope`). Daniel directive 2026-05-17 05:48Z ("b as per don't block because of scope increase and achieve sorry-free axiom-free formalization"). Polecat: `cat-mg-e1b8`. Paper-and-pencil only (NO Lean execution). Budget 350k tokens.

Parent: mg-b26c (`UC-Lean-SS-X6-PerXClosure`, AMBER named composition gap; Lean-Session 26). The X1-X5 mathlib SpectralSequence infrastructure is GREEN-landed (mg-dd80 + mg-55b3 + mg-fade + mg-455f + mg-c128) and materially invoked from `SSConvergence.lean` (`SSAbutment_corner_vanishing_via_columnHomotopy` + `SSPipeline_X1_to_X5_composition`, both PROVEN). The residual is precisely the union_closed-specific instantiation of the X3 + X5 missing inhabitants: a true `HomologicalComplex₂` BKBicomplex with the Walsh-equivariant column structure, and a true chain `Homotopy (𝟙 ((BKBicomplexHC₂ F).X x)) 0` constructed from `UC10_lowerWalshVanishing F x`.

Mathlib pinned: `v4.29.1`, rev `5e932f97dd25535344f80f9dd8da3aab83df0fe6` (per `lean/lake-manifest.json`).

---

## TL;DR / Verdict

**GREEN scoping complete + Y1–Y5 decomposition pinned + Phase D closure-ticket scope named.**

Path B from mg-b26c AMBER closes the per-x sorry by upgrading the union_closed Lean encoding from a row-0-truncated 1D total complex (`BKTotal n`) to a true mathlib `HomologicalComplex₂` with the Walsh-equivariant column structure, then materially constructing the chain `Homotopy` that the X2 adapter consumes. No mathlib infrastructure is missing (Path A delivered all six SS pieces); no axiom-named relaxation is needed (Path E remains hard-constraint-forbidden); the residual is concretely an engineering construction of union_closed-side inhabitants for the existing API.

The four phases of the ticket map cleanly onto execution sub-tickets:

- **Phase A — BKBicomplex full construction audit** (this doc §1): three pieces — higher rows = Čech bar resolution of the trace category `(C_n^∩)^op`, Čech bicomplex differentials (alternating restriction + cochain boundary), chain-level `(ZMod 2)^n`-equivariance lifting through the higher rows. Verdict per piece: GREEN(1) / AMBER(2) — the trace-category bar resolution is the largest piece (estimated 1 multi-session) but architecturally direct; the genuine non-zero `BKHorizDiff` requires the diagram functor `singleFamilyComplex` to be functorial in trace morphisms (named L2b/L3 gap explicitly punted in `BousfieldKan.lean`); the chain-level Walsh action lifting is small and direct.
- **Phase B — Walsh-equivariant structure on the FULL BKBicomplex** (this doc §2): three pieces — `(ZMod 2)^n` action on every row via Walsh-isotype decomposition, isotype-graded filtration of the bicomplex, X3 + X4 mathlib integration via `EquivariantBicomplex` + `Walsh.isotypeFamily` + abelian Schur. Verdict per piece: all AMBER (the per-x χ_x-isotype subcomplex is the substantive X3 missing inhabitant; the other two follow once it lands).
- **Phase C — Homotopy bridge construction** (this doc §3): three pieces — translate `UC10_lowerWalshVanishing F x` (Finsupp equation) to `Homotopy (𝟙 ((BKBicomplexHC₂ F).X x)) 0` (chain homotopy object) on the bicomplex column, verify per-coordinate at each `x : Fin n`, plumb through X2 + X5 to derive `obstructionCohomClass F x = 0` via SS-abutment. Verdict per piece: all AMBER but architecturally bounded — the homotopy-object construction is the load-bearing single bridge; per-coordinate is uniform; X2 + X5 plumbing is one-liner via the already-PROVEN `SSAbutment_corner_vanishing_via_columnHomotopy`.
- **Phase D — Y1-Yn execution sub-ticket decomposition** (this doc §4): five sub-tickets Y1–Y5, total budget ~1.45–1.95M tokens (inside the ticket's "multi-week" estimate). Critical path: Y1 → Y2 → Y3 → Y4 → Y5. Each Y-ticket single-session-capable (≤ 400k tokens). Y5 is the closure ticket consuming Y1–Y4 to close the per-x sorry and refactor `obstructionCohomClass` through SS-abutment — the **PROJECT-LIFE MILESTONE "zero live sorrys end-to-end" trigger**.

No scoping AMBER. No structural impossibility found. **Recommendation: file Y1 (`UC-Lean-PathB-Y1-BKBicomplexHC2`) as the next execution step.**

---

## §0 — Hard constraints carried into every Y-sub-ticket

Carried from the project's UC-Lean-scope §D + mg-b26c's residual + mg-e1b8's directive set:

- **NOT factorial.** The `(ZMod 2)^n` action is abelian; characters are `χ_S` indexed by `Finset (Fin n)` (Walsh signs); no Specht modules; no symmetric-group representation theory; `Mathlib.RepresentationTheory.SpechtModules` is not imported in any Y-ticket.
- **NOT functorial in the refinement sense.** No `Pos_n` functor. The diagram functor `singleFamilyComplex : (C_n^∩)^op → Ch(ModuleCat ℚ)` of Y1 is native to the trace category, lifted directly as a structure field (not as a categorical `Functor` object — it's a per-object choice of complex plus per-morphism trace-restriction chain map; this is the L2b/L3 gap discharge form). No refinement-functor invocation.
- **U1-dialect preserved.** Purely additive cohomology comparisons throughout. The Walsh decomposition is direct-sum into 1-dim irreps; no cup-product even for the abutment-identification step (the chain-level Walsh-character action is per-generator scalar multiplication, additively lifted to bicomplex columns).
- **Math-first.** Each Y-ticket aligns with a specific paper-side step: Y1 with UC10 §3.3 + UC11 §2 (Čech-resolved trace category bicomplex), Y2 with UC13 §§2–3 + UC10 §0.2 (Walsh action lifted across rows), Y3 with UC13 §§4.5 + UC10 §5.3 (twisted-bridge null-homotopy), Y4 with UC11 §6 + UC13 §7 (SS-abutment per-x vanishing), Y5 with UC11 §§6.2 + UC13 §2.4.1 (refactored `obstructionCohomClass`).
- **Cumulative state doc.** Each Yi appends a `state-UC-Lean-PathB-Yi.md` cumulative ledger; this file (`UC-Lean-PathB-BKBicomplex-scope.md`) is the arc-level index; `state-UC-Lean-PathB-BKBicomplex-scope.md` is this scoping session's cumulative ledger.
- **Mathlib-folder authorization (Daniel 17:47Z + 23:12Z + 05:48Z) scoped to BKBicomplex + Walsh-equivariant + Homotopy-bridge infrastructure for this arc.** Y1's `BKBicomplexHC₂` is a union_closed-internal file under `lean/UnionClosed/UC10/`, NOT under `lean/UnionClosed/Mathlib/` (it is the union_closed-specific instantiation of the X1 mathlib API). Y2's Walsh-equivariant lifting may add a thin upstream-PR-clean file under `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/EquivariantBicomplex/` *only if* a generic helper emerges; default placement is union_closed-internal. Y3's Homotopy bridge is union_closed-internal. Y4's SS-abutment plumbing is union_closed-internal but invokes X1-X5 mathlib API directly. Y5's `obstructionCohomClass` refactor is union_closed-internal.
- **No axiom-cheat.** `grep -rn '^axiom' lean/UnionClosed/` must remain empty after every Y-ticket. No `axiom` keyword introduced anywhere. No `False.elim` on `_hStar`. No `decide`-shortcut beyond the concrete-arithmetic Fin-cardinality witnesses already used at n=3 + n=4.
- **No fake mathlib API. No defeq trick.** `lake build` GREEN per Y-ticket. All API surface is mathlib v4.29.1 + the existing X1-X5 files + Y1-Yi-1 deliverables.
- **Non-tautology preservation.** Each Y-ticket carries the mg-c0d3 + mg-7f26 non-tautology bar — substituting an arbitrary `Fin n → ℤ` for `β_x F` must NOT trivially make the new `obstructionCohomClass = 0`. The SS-abutment-derived cohomology is propositionally distinct from `chainToHomology0`'s topVertex line.
- **Acceptance bar template per sub-ticket:** (1) `lake build` GREEN, (2) at least one downstream invocation site is materially advanced, (3) non-vacuous evaluation at n = 3 + n = 4, (4) compatible with mg-c0d3 + mg-7f26 + mg-36c3 non-tautology + structural-collision-permanence bars (the mg-36c3 PROVEN structural-collision theorems remain PROVEN about the **L2a baseline `BKTotal n`** even after Y5 lands — they become inapplicable to the **new SS-derived cohomology object**; see Y5 §4.5 below).

---

## §1 — Phase A: BKBicomplex full construction audit

The current Lean encoding has `BKBicomplex n p q : ModuleCat ℚ` populated as the Sigma-Finsupp over `(c : OpChain n p) × CubeCell c.tail q` (mg-e0d2), with `BKVertDiff n p q : BKBicomplex n p (q+1) ⟶ BKBicomplex n p q` populated concretely from `singleFamilyBoundary` (per-fiber, lifted across the Sigma via `Finsupp.mapDomain`). The crucial truncation is `BKHorizDiff n p q := 0`: the full bar-resolution differential needs `singleFamilyComplex` to be functorial in trace morphisms in `C_n^∩` (the BK face maps act on chains by composing/inserting morphisms, then transporting via functoriality), and this functoriality is explicitly named as the L2b/L3 gap in `BousfieldKan.lean:154-167`. With horizontal = 0, the totalisation `BKTotal n` collapses to the `p = 0` column.

Path B needs the FULL bicomplex with non-trivial horizontal differentials so that the X1 SS lands non-trivial cohomology at the union_closed-relevant `(p, q)` cells. Audit per piece:

### A.1 Higher rows = Čech bar resolution of `(C_n^∩)^op` — **AMBER**

**What `BousfieldKan.lean` has.** The data type `OpChain n p` is correctly populated (a `Fin (p+1)`-indexed family of objects in `C_n^∩` plus the trace-morphism record per consecutive index). The Sigma-Finsupp `BKBicomplex n p q := ((Σ c : OpChain n p, CubeCell c.tail q) →₀ ℚ)` is correct as the chain group at bi-degree `(p, q)`. The vertical differential `BKVertDiff n p q` is fully populated.

**What is missing.** The horizontal Čech bar-resolution differential

```
BKHorizDiff_full n p q : BKBicomplex n p q ⟶ BKBicomplex n (p+1) q
```

needs to be `Σ_{i = 0}^{p+1} (-1)^i d_i`, where:

- `d_0` "drops the head": from a `(p+1)`-chain `S_0 → S_1 → ⋯ → S_{p+1}`, take the `p`-chain `S_1 → ⋯ → S_{p+1}` and act by the head-trace `S_0 → S_1` (which is a trace morphism in `C_n^∩` from a larger to a smaller support; in `(C_n^∩)^op` it goes the other way). At the chain level, the head-trace **must induce a chain map** `singleFamilyComplex S_1 → singleFamilyComplex S_0` — this is the **load-bearing functoriality of the diagram functor**.
- `d_i` for `0 < i ≤ p` "composes adjacent morphisms": replace `S_{i-1} → S_i → S_{i+1}` with `S_{i-1} → S_{i+1}` via composition in `(C_n^∩)^op`. The cell on `S_p` is unchanged.
- `d_{p+1}` "drops the tail": from a `(p+1)`-chain `S_0 → ⋯ → S_p → S_{p+1}`, take the `p`-chain `S_0 → ⋯ → S_p` — but the cell lives on `c.tail = S_{p+1}` and must be transported to `S_p` via the tail-trace. This is the **second invocation of diagram-functoriality**.

**Construction breakdown.** The trace-functoriality of `singleFamilyComplex` is a per-trace-morphism chain map between two cubical chain complexes:

```
TraceChainMap (φ : TraceMor S T) :
  singleFamilyComplex S → singleFamilyComplex T   -- in (C_n^∩)^op direction
```

For a trace morphism `φ : S → T` (smaller support `T ⊆ S` in `C_n^∩`), the chain map sends a cubical cell `(A, T') : CubeCell S k` to either the corresponding cell `(A ∩ T.support, T' ∩ T.support) : CubeCell T k'` (if `T'` survives the restriction) or zero (if the direction set escapes the trace). This is **paper-side standard** (UC10 §3.3 + UC11 §2; the Čech-cover trace-functoriality is the defining property of `singleFamilyComplex` as a diagram on `(C_n^∩)^op`).

**Construction complexity.** Three pieces:

1. **Per-cell trace-restriction map** `(A, T') ↦ (A ∩ T.support, T' ∩ T.support)`: needs `CubeCell.subcube` to survive the restriction (which it does because intersection-closed subfamilies inherit the subcube condition; well-formedness preserved). ~150 lines.
2. **Chain-map property** `TraceChainMap φ ∘ singleFamilyBoundary = singleFamilyBoundary ∘ TraceChainMap φ`: face/restriction commutativity, follows by direct unfolding of `faceOff`/`faceOn` and the restriction-of-erase identity. ~150 lines.
3. **Bar-resolution `d²=0`**: the alternating sum `Σ (-1)^i d_i` has `d² = 0` by the standard bar-resolution simplicial identity `d_i d_j = d_{j-1} d_i` for `i < j`. ~200 lines for the simplicial-bar-resolution combinatorics on `OpChain`.

**Total Phase A.1 estimate.** ~500 lines / ~250–300k tokens.

**Verdict.** **AMBER** — substantive non-trivial Lean engineering, but architecturally direct (the construction is standard Čech-bar-resolution material on a diagram of chain complexes; no novel mathematics; no architectural mathlib gaps). Lands in **Y1** of the Phase D decomposition.

### A.2 Čech bicomplex differentials at higher rows — **AMBER** (follows A.1)

**What is needed.** Given `TraceChainMap` from A.1, the horizontal differential `BKHorizDiff_full n p q` is the alternating sum `Σ_i (-1)^i (BKFace_i n p q)` where each `BKFace_i` lifts `TraceChainMap` (or composition / drop) across the Sigma-Finsupp:

```
BKFace_i (n p q : ℕ) :
  BKBicomplex n p q ⟶ BKBicomplex n (p+1) q
```

The per-fiber action is `TraceChainMap` (for `d_0`, `d_{p+1}`) or `Finsupp.mapDomain` of the composed-OpChain reindexing (for `d_i`, `0 < i ≤ p`).

The vertical-horizontal commutativity `BKHoriz_Vert_commute_full` then says: face-maps commute (up to the standard alternating sign) with the cubical boundary. This is the **bicomplex axiom** required to package the data as a `HomologicalComplex₂` in mathlib's sense.

**Construction complexity.** Three pieces:

1. **Per-face lift across the Sigma** `BKFace_i n p q = Finsupp.linearCombination ℚ (BKFaceGen_i n p q)`: routine `Finsupp.mapDomain`-based plumbing once `TraceChainMap` lands. ~100 lines per `BKFace_i`; the sum across `i = 0…p+1` is uniform.
2. **`BKHorizDiff_full_squared`**: the bar-resolution `d² = 0` identity transported to the Sigma. Reduces (per fiber) to A.1.3. ~100 lines.
3. **`BKHoriz_Vert_commute_full`**: combines A.1.2 (per-fiber chain-map property of `TraceChainMap`) with the Sigma-Finsupp commutativity. ~150 lines.

**Total Phase A.2 estimate.** ~350 lines / ~150–200k tokens.

**Verdict.** **AMBER** — direct lift of A.1 across the Sigma. Lands in **Y1** of the Phase D decomposition (bundled with A.1 for `BKBicomplexHC₂` assembly).

### A.3 Chain-level `(ZMod 2)^n`-equivariance lifting through higher rows — **GREEN**

**What is needed.** The genuine Walsh action of `(ZMod 2)^n` on `BKBicomplex n p q` for every `(p, q)`. At the row-0 layer, `walshScale n S : (BKTotal n).X 0 →ₗ[ℚ] (BKTotal n).X 0` is the per-generator scalar multiplication by `(walshChar n S c.2.base : ℚ)` (mg-fbbb). The lift to higher rows is **uniform**: at every `(p, q)`, the same per-generator scalar acts (the Walsh character depends only on `c.2.base : Finset (Fin n)`, which is well-defined for every `CubeCell c.tail q`).

**Why GREEN.** The Walsh-character action is **per-generator scalar**: it commutes with both `BKVertDiff` (because the boundary preserves `c` and acts cell-by-cell, and `walshChar` only depends on `c.2.base`, which transforms covariantly under `faceOff`/`faceOn`) and `BKHorizDiff_full` (because trace-restriction commutes with `walshChar`: the Walsh character of a restricted base is well-defined and equals the restriction of the Walsh character).

**Construction complexity.** Three uniform extensions:

1. **`walshScaleBicomplex n S (p q : ℕ) : BKBicomplex n p q →ₗ[ℚ] BKBicomplex n p q`** — uniform extension of `walshScale n S` from row-0 to arbitrary row. ~50 lines per row layer; uniform.
2. **`walshScaleBicomplex_commutes_BKVertDiff`** — commutativity with the vertical differential per-fiber. ~80 lines.
3. **`walshScaleBicomplex_commutes_BKHorizDiff`** — commutativity with the horizontal differential per-face. ~100 lines (depends on A.1's `TraceChainMap` landing; the commutativity is direct since trace-restriction commutes with `walshChar`).

**Total Phase A.3 estimate.** ~230 lines / ~100k tokens.

**Verdict.** **GREEN** — uniform per-generator scalar lift; no novel mathematics; the only dep is A.1 + A.2 landing (so it follows Y1 in execution order). Lands in **Y2** of the Phase D decomposition.

### Audit summary table for Phase A

| # | Piece | Current state | Construction | Verdict | Y-ticket |
|---|---|---|---|---|---|
| A.1 | Higher-row Čech bar resolution (`TraceChainMap` + bar-resolution `d²=0`) | Missing; the L2b/L3-named gap explicitly punted in `BousfieldKan.lean` | ~500 lines; standard | **AMBER** | Y1 |
| A.2 | Čech bicomplex differentials at higher rows (`BKHorizDiff_full`, `BKHoriz_Vert_commute_full`) | Truncated to zero; needs A.1 | ~350 lines; lift-across-Sigma | **AMBER** | Y1 |
| A.3 | `(ZMod 2)^n`-equivariance lifting through higher rows | Defined at row-0 only (`walshScale`) | ~230 lines; uniform extension | **GREEN** | Y2 |

**Phase A aggregate verdict.** All three pieces buildable; no architectural blockers. A.1 + A.2 = `BKBicomplexHC₂ F : HomologicalComplex₂ (ModuleCat ℚ) (.up ℕ) (.down ℕ)` ≈ multi-session work bundled in Y1; A.3 = Walsh-equivariant lift ≈ single-session work in Y2. **No scoping AMBER on Phase A.**

---

## §2 — Phase B: Walsh-equivariant structure on the FULL BKBicomplex

Once Y1 delivers `BKBicomplexHC₂ F : HomologicalComplex₂ (ModuleCat ℚ) (.up ℕ) (.down ℕ)` with the genuine horizontal differential, Y2 builds the Walsh-equivariant structure on it. The mathlib X3 deliverable `EquivariantBicomplex G` is fully built; Y2 inhabits it for `G = (ZMod 2)^n` via the chain-level Walsh action from A.3, then constructs the isotype-graded filtration.

### B.1 `(ZMod 2)^n` action on the full BKBicomplex via Walsh isotype decomposition — **AMBER**

**What X3's `Equivariant.lean` provides.** The structure `EquivariantBicomplex K G` requires `ρ : G → (K ⟶ K)` with `ρ 1 = 𝟙` and `ρ (g * h) = ρ g ≫ ρ h` — i.e., a `G`-action on `K` as a `HomologicalComplex₂`. The `trivial` inhabitant is `ρ _ := 𝟙`; the `coarse` Walsh-isotype-family is `Index → ℕ × ℕ → C, χ ↦ slice = whole E_∞-cell` (placeholder, every isotype = identity).

**What Y2 must supply.** A genuine `EquivariantBicomplex (BKBicomplexHC₂ F) (∀ _ : Fin n, ZMod 2)` with:

- `ρ σ : BKBicomplexHC₂ F ⟶ BKBicomplexHC₂ F` for each `σ : Fin n → ZMod 2`, defined per-generator as the **toggle action on the base coordinate**: the cell `(A, T') ∈ CubeCell c.tail q` maps to `(toggleAction σ A, T')` with sign `walshChar n (toggleSupport σ) A`.
  - Wait — the genuine Walsh action is NOT the trivial action and NOT the per-cell scalar multiplication by `walshChar`; it is the **toggle of the base coordinate**, with the Walsh character emerging as the **eigenvalue** of each `χ_S`-isotype component. The chain-level realisation is: `ρ σ : ⟨c, (A, T')⟩ ↦ ⟨c, (A ∆ toggleSupport σ, T')⟩` — provided the toggled cell `(A ∆ toggleSupport σ, T')` is still a valid `CubeCell c.tail q` (which requires `c.tail.family` to be toggle-stable — UC10 §2.4 notes this is the technical price of dodging C3; on `IntClosedFam` this fails in general).
  - **The fix** is to lift to the hocolim `XNcap n` (`UC10 §3.3`): the indexing over `OpChain n p` absorbs the family-flipping (any `(A ∆ toggleSupport σ)` lives in some `S_i.family` for some `i ≤ p` via the trace-functoriality, and the chain ``relabels'' to record this). This is the standard BK-on-`(C_n^∩)^op` mechanism.
- `ρ_one`, `ρ_mul`: the toggle action's group laws follow from `toggleSupport_add` (symmetric-difference is the group operation on `Fin n → ZMod 2`).
- Compatibility with `BKVertDiff_full` and `BKHorizDiff_full`: toggling `A` commutes with the cubical boundary (the boundary acts on `T'`, not on `A`), and toggling commutes with trace-restriction (the trace-functoriality is `(Fin n → ZMod 2)`-equivariant).

**Construction complexity.** Three pieces:

1. **Per-generator toggle action** `BKToggleAction σ : BKBicomplexHC₂ F ⟶ BKBicomplexHC₂ F` — explicit per-generator action with the hocolim-lift to absorb family-flipping. ~150 lines.
2. **Group action laws** (`ρ_one`, `ρ_mul`) — direct from `toggleSupport_add`. ~50 lines.
3. **Compatibility with both differentials** — vertical commutativity is trivial (toggle acts on `A`, boundary on `T'`); horizontal commutativity requires the trace-functoriality of the toggle action (uses A.1's `TraceChainMap` toggle-equivariance). ~150 lines.

**Total Phase B.1 estimate.** ~350 lines / ~200k tokens.

**Verdict.** **AMBER** — substantive Lean engineering, but architecturally direct. The `(ZMod 2)^n` action on the BK bicomplex of `(C_n^∩)^op` is paper-side **standard** (UC10 §3.5 + UC10 §3.6, Lemma 3.6 = `Γ_n`-equivariance on `XNcap`). Lands in **Y2** of the Phase D decomposition.

### B.2 Isotype-graded filtration of the BKBicomplex — **AMBER**

**What is needed.** A per-character `χ_S`-isotype subcomplex of `BKBicomplexHC₂ F` for each `S : Finset (Fin n)`:

```
BKIsotypeSubcomplex F S : HomologicalComplex C (.up ℕ)
```

(at row level — we want the subcomplex of the **column** at coordinate `x` for the Y3 Homotopy bridge; or equivalently, the `χ_S`-eigenspace of the `(ZMod 2)^n` action at each `(p, q)` cell).

The **idempotent realisation** is the standard Maschke projection:

```
walshIsotypeProj n S : BKBicomplexHC₂ F →ₗ[ℚ] BKBicomplexHC₂ F
  := (1 / 2^n) * Σ_{σ : Fin n → ZMod 2} walshChar n S (toggleSupport σ) • BKToggleAction σ
```

The factor `1/2^n` requires the base ring to contain `1/2^n` (which `ℚ` does — see `Mathlib.RepresentationTheory.Maschke` for the standard abelian Maschke decomposition over `ℚ`).

**Construction complexity.** Three pieces:

1. **`walshIsotypeProj n S`** — explicit idempotent definition. ~80 lines.
2. **Idempotent + isotype properties**: `walshIsotypeProj S ∘ walshIsotypeProj S = walshIsotypeProj S`, `walshIsotypeProj S ∘ BKToggleAction σ = walshChar n S (toggleSupport σ) • walshIsotypeProj S`, `Σ_S walshIsotypeProj S = 1`. ~150 lines using `walshChar_toggle_eigen` (mg-84a7 PROVEN) + abelian Maschke.
3. **Isotype subcomplex as a `HomologicalComplex`**: package `Image (walshIsotypeProj S)` per `(p, q)` cell into a subcomplex via the canonical inclusion. ~100 lines.

**Total Phase B.2 estimate.** ~330 lines / ~150k tokens.

**Verdict.** **AMBER** — direct use of mathlib's `Mathlib.RepresentationTheory.Maschke` (already imported transitively via `UC10/Walsh.lean`) + the existing `walshChar_toggle_eigen` PROVEN identity. Lands in **Y2**.

### B.3 Integration with X3 + X4 mathlib infrastructure — **AMBER**

**What is needed.** Inhabit X3's `EquivariantBicomplex.IsotypeFamily` with the **genuine** χ_S-isotype slices (not the `coarse` placeholder):

```
BKWalshIsotypeFamily F : (BKEquivBicomplex F).IsotypeFamily (Finset (Fin n))
```

with `slice S pq := Image of walshIsotypeProj S at (p, q)` and `ι S pq := canonical inclusion`. Then X3 + X4 deliver:

- `respectsDifferentials_of_degenerate` (X3, already PROVEN in `Equivariant.lean:438`): X1's degenerate page-r differential composes with the isotype inclusion to zero — directly applies in Y2 with the genuine isotype family.
- `differential_isotype_zero` (X4, `Schur.lean:216`): in the abelian-Schur form (for distinct characters χ_S ≠ χ_T), the differential between distinct-isotype summands vanishes. The X4 deliverable provides the abstract Schur-by-character API plus the n=3 witness; Y2 inhabits it for the (ZMod 2)^n acting on BKBicomplexHC₂ F.

**Construction complexity.** Two pieces:

1. **Inhabit X3's `IsotypeFamily` with genuine χ_S slices** — direct via the B.2 idempotent. ~80 lines.
2. **Invoke X4's `differential_isotype_zero` at the genuine isotype family** — wrapper lemma. ~60 lines.

**Total Phase B.3 estimate.** ~140 lines / ~80k tokens.

**Verdict.** **AMBER** — thin wrapper over B.2; the substantive content is in B.1 + B.2. Lands in **Y2** as the final layer.

### Audit summary table for Phase B

| # | Piece | What X3/X4 has | What Y2 supplies | Verdict | Y-ticket |
|---|---|---|---|---|---|
| B.1 | `(ZMod 2)^n` action on BKBicomplexHC₂ | `EquivariantBicomplex` API + `trivial`/`coarse` inhabitants | Genuine toggle action with hocolim-lift | **AMBER** | Y2 |
| B.2 | Isotype-graded filtration / per-S idempotent | None (X3 `coarse` is identity-only) | `walshIsotypeProj n S` via abelian Maschke | **AMBER** | Y2 |
| B.3 | Integration with X3 + X4 SpectralSequence API | `respectsDifferentials_of_degenerate` + `differential_isotype_zero` (PROVEN) | Genuine `IsotypeFamily` inhabitant | **AMBER** | Y2 |

**Phase B aggregate verdict.** All three pieces buildable. Phase B = Y2 (~430k–500k tokens single-session; if too large, split B.1 + B.2 into Y2a / B.3 into Y2b). **No scoping AMBER on Phase B.**

---

## §3 — Phase C: Homotopy bridge construction

The **load-bearing single bridge** of the entire Path B arc. The mg-b26c PROVEN composition kernel `SSAbutment_corner_vanishing_via_columnHomotopy` consumes a `Homotopy (𝟙 (K.X p)) 0` and produces `IsZero (K.EInftyBicomplex (p, q))` for every `q`. Phase C constructs that `Homotopy` from `UC10_lowerWalshVanishing F x` (a Finsupp equation) on the χ_{x}-isotype subcomplex of `BKBicomplexHC₂ F`.

### C.1 Translate L3 twisted-bridge null-homotopy to `Homotopy ψ 0` on the χ_{x}-isotype column — **AMBER (load-bearing)**

**What L3 provides (mg-fbbb PROVEN).** For each `F : IntClosedFam n` and `x : Fin n`:

```
UC10_lowerWalshVanishing F x :
  walshScale n {x} (bridgeOpAt F
    (walshScale' n ({liftCoord n x} : Finset (Fin (n+1)))
      (bridgeImg n 0
        (Finsupp.single ⟨OpChain.const F, CubeCell.topVertex F⟩ 1)))) =
  Finsupp.single ⟨OpChain.const F, CubeCell.topVertex F⟩ 1
```

This is the chain-level twisted-bridge splitting identity at the populated baseline: the composition `walshScale n {x} ∘ bridgeOpAt F ∘ walshScale' n {liftCoord n x} ∘ bridgeImg n 0` fixes the topVertex generator (multiplicity 1).

**What Y3 must construct.** A `Homotopy (𝟙 ((BKIsotypeSubcomplex F {x}).column-at-x)) 0` — i.e., a sequence of chain-level operators `h_q : (BKIsotypeSubcomplex F {x}).X q ⟶ (BKIsotypeSubcomplex F {x}).X (q+1)` such that:

```
𝟙 = d_{q-1} ∘ h_{q-1} + h_q ∘ d_q   (the null-homotopy equation)
```

**The construction.** Use `bridgeOpAt F` and `bridgeImg n 0` as the homotopy operator components:

- `h_0 : (BKIsotypeSubcomplex F {x}).X 0 ⟶ (BKIsotypeSubcomplex F {x}).X 1`
  - Defined as `walshScale' n {liftCoord n x} ∘ bridgeImg n 0` restricted to the χ_{x}-isotype.
- `h_q = 0` for `q ≥ 1` (the higher-degree pieces are trivial because the BK row-0 cellularity exhausts at `q = 0` for the union_closed application at degree 0; the higher `q` pieces are required to be zero by the column's degree structure).
- The vertical boundary on column `x` is `d : (BKIsotypeSubcomplex F {x}).X 1 ⟶ (BKIsotypeSubcomplex F {x}).X 0`, defined as `walshScale n {x} ∘ bridgeOpAt F` restricted to the χ_{x}-isotype.

**The null-homotopy equation** then becomes (at degree 0):

```
𝟙_{χ_{x}-isotype subcomplex (degree 0)} =
  d_0 ∘ h_0  (since h_{-1} = 0 by convention)
= (walshScale n {x} ∘ bridgeOpAt F) ∘ (walshScale' n {liftCoord n x} ∘ bridgeImg n 0)
  restricted to the χ_{x}-isotype
```

which is **precisely UC10_lowerWalshVanishing F x** (the chain identity that fixes the topVertex generator on the χ_{x}-isotype).

**Construction complexity.** Four pieces:

1. **Define the homotopy operators** `h_q : BKIsotypeColumn F x q ⟶ BKIsotypeColumn F x (q+1)` — `h_0` via `walshScale'_n {liftCoord n x} ∘ bridgeImg n 0` (restricted), `h_q = 0` for `q ≥ 1`. ~80 lines.
2. **Null-homotopy equation at degree 0**: `𝟙 = d_0 ∘ h_0` — direct from `UC10_lowerWalshVanishing F x`. ~60 lines.
3. **Null-homotopy equation at degree `q ≥ 1`**: `𝟙 = d_{q-1} ∘ h_{q-1} + h_q ∘ d_q`, both sides reduce to 0 on a contractible column (the χ_{x}-isotype at higher degrees is null because the L2a-residual-residual layer has BKHorizDiff = 0; with Y1's full horizontal differential, the higher-degree χ_{x}-isotype components vanish by direct calculation). ~80 lines.
4. **Package as `Homotopy (𝟙 ((BKIsotypeColumn F x)).X) 0`**: assemble (1)–(3) into a `Homotopy` object. ~50 lines.

**Total Phase C.1 estimate.** ~270 lines / ~150k tokens.

**Why this works (the structural insight).** The Y5 refactor (Phase C closure) routes `obstructionCohomClass` through the SS-derived cohomology `(BKBicomplexHC₂ F).EInftyBicomplex (0, 0)` restricted to the χ_{x}-isotype, NOT through `chainToHomology0 n` (which collapses to the topVertex line and triggers `topVertex_not_coboundary`). On the SS-derived object, the χ_{x}-isotype null-homotopy gives `IsZero (EInftyBicomplex (x, 0)_{χ_{x}-isotype})`, and the per-x edge map identifies this with the per-x cohomology vanishing. The mg-36c3 PROVEN structural-collision theorems (`per_x_cohom_vanishing_collides_topVertex_not_coboundary`, `aggregate_cohom_vanishing_collides_topVertex_not_coboundary`) remain PROVEN about the **old** `chainToHomology0`-derived class on `BKTotal n` — they become **inapplicable** to the new SS-derived object.

**Verdict.** **AMBER (load-bearing)**. The L3 twisted-bridge identity is exactly the right shape; the homotopy-object packaging is direct; the per-coordinate uniformity follows. Lands in **Y3** of the Phase D decomposition.

### C.2 Per-coordinate verification at each `x : Fin n` — **GREEN**

**What is needed.** The Y3 construction is universally quantified over `x : Fin n`; the per-coordinate uniformity follows because `UC10_lowerWalshVanishing F x` is itself universally quantified, and the homotopy construction (C.1) is x-uniform.

**Construction complexity.** One piece: package C.1 as a per-x construction:

```
BKIsotypeColumn_nullHomotopy F :
  ∀ x : Fin n, Homotopy (𝟙 ((BKIsotypeColumn F x))) 0
```

~30 lines (universal-quantification packaging).

**Total Phase C.2 estimate.** ~30 lines / ~30k tokens.

**Verdict.** **GREEN** — direct from C.1. Lands in **Y3** as a trivial follow-up.

### C.3 Plumb through X2 + X5 to derive `obstructionCohomClass F x = 0` via SS-abutment — **AMBER (Y5 closure)**

**What is needed.** Given Y3's per-x homotopy `h_x : Homotopy (𝟙 ((BKIsotypeColumn F x))) 0`, apply the **already-PROVEN** mg-b26c kernel:

```
SSAbutment_corner_vanishing_via_columnHomotopy
  (BKBicomplexHC₂ F) x 0 h_x : IsZero ((BKBicomplexHC₂ F).EInftyBicomplex (x, 0))
```

restricted to the χ_{x}-isotype. Then combine with X5's edge map at `(x, 0)`:

```
BKBicomplexHC₂_edgeMap_horiz F x : (BKBicomplexHC₂ F).EInftyBicomplex (x, 0)_{χ_x} ⟶
                                    H^x(BKBicomplexHC₂ F .total)_{χ_x}
```

to derive `H^x(BKBicomplexHC₂ F .total)_{χ_x} = 0` and identify with the new SS-derived `obstructionCohomClass` (per Y5's refactor of `obstructionCohomClass` to land in the SS-derived cohomology).

**Construction complexity.** Three pieces:

1. **Apply `SSAbutment_corner_vanishing_via_columnHomotopy`** at the per-x homotopy — one-liner via the already-PROVEN kernel. ~30 lines.
2. **Specialise X5's edge map to BKBicomplexHC₂** — wrapper of `trivialWithEdgeMaps` (or a genuine edge map if the SS is non-degenerate; X1 + X2 + X4 + the Y2 Walsh-equivariance lift cleanly to the degenerate case on the χ_{x}-isotype, so `trivialWithEdgeMaps` suffices). ~60 lines.
3. **Combine into the per-x cohomology vanishing**, then funext for the aggregate form. ~50 lines.

**Total Phase C.3 estimate.** ~140 lines / ~80k tokens.

**Verdict.** **AMBER** — thin Y5-closure wrapper consuming Y3 + the mg-b26c PROVEN kernel + X5. Lands in **Y4** + **Y5** of the Phase D decomposition (Y4 = SS-abutment composition; Y5 = `obstructionCohomClass` refactor and per-x sorry close).

### Audit summary table for Phase C

| # | Piece | Verdict | Y-ticket |
|---|---|---|---|
| C.1 | Translate UC10_lowerWalshVanishing to `Homotopy ψ 0` on χ_{x}-isotype column | **AMBER (load-bearing)** | Y3 |
| C.2 | Per-coordinate verification at each `x : Fin n` | **GREEN** | Y3 |
| C.3 | Plumb through X2 + X5 to derive `obstructionCohomClass F x = 0` | **AMBER (Y5 closure)** | Y4 + Y5 |

**Phase C aggregate verdict.** Load-bearing piece is C.1; the rest is composition. **No scoping AMBER on Phase C.**

---

## §4 — Phase D: Y1-Yn execution sub-ticket decomposition

Five sub-tickets. Each single-session-capable (≤ 400k tokens). Total arc budget ~1.45–1.95M tokens (inside the ticket's "multi-week" estimate per mg-b26c §7.3).

### Y1 — `UC-Lean-PathB-Y1-BKBicomplexHC2`

**Title.** UC-Lean-PathB-Y1-BKBicomplexHC2: construct `BKBicomplexHC₂ F : HomologicalComplex₂ (ModuleCat ℚ) (.up ℕ) (.down ℕ)` — full bicomplex with non-trivial horizontal Čech bar-resolution differential.

**Budget.** 350–400k (largest single piece; `TraceChainMap` + bar-resolution `d² = 0` + horizontal/vertical commutativity).

**Deps.** None inside the arc (independent first step). External deps: `lean/UnionClosed/UC10/BousfieldKan.lean`, `lean/UnionClosed/UC10/CubicalDefect.lean`, mathlib `HomologicalBicomplex.lean`.

**Deliverable.** New file `lean/UnionClosed/UC10/BKBicomplexHC2.lean` (or extension of `BousfieldKan.lean`). Substantive new content:

- `TraceChainMap (φ : TraceMor S T) : singleFamilyComplex S → singleFamilyComplex T` (a chain map between two cubical chain complexes; Phase A.1.1 + A.1.2).
- `BKFace_i n p q (i : Fin (p + 2)) : BKBicomplex n p q ⟶ BKBicomplex n (p + 1) q` (per-face lift; Phase A.2.1).
- `BKHorizDiff_full n p q := Σ_i (-1)^i (BKFace_i n p q)` (Phase A.2).
- `BKHorizDiff_full_squared : BKHorizDiff_full ≫ BKHorizDiff_full = 0` (Phase A.2.2).
- `BKHoriz_Vert_commute_full` (Phase A.2.3).
- `BKBicomplexHC₂ F : HomologicalComplex₂ (ModuleCat ℚ) (.up ℕ) (.down ℕ)` (the bicomplex assembly).

PROVEN at the level mathlib expects (no `sorry`; `lake build` GREEN).

**Acceptance bar.** (1) `lake build` GREEN. (2) Non-vacuous evaluation at `n = 3` with `fullPowerset3` or similar: `BKBicomplexHC₂ fullPowerset3` has at least one non-zero cell at `(p, q)` for some `p, q ≥ 1` (the horizontal differential is non-trivial, not the truncated baseline). (3) The new `BKBicomplexHC₂ F` is a true mathlib `HomologicalComplex₂` (the bicomplex shape `c₁ = .up ℕ`, `c₂ = .down ℕ` matches X1's signature in `Bicomplex.lean`). (4) Hard-constraint set §0 respected (NOT factorial; NOT functorial in the refinement sense; U1-dialect; no axiom-cheat; no fake mathlib API; no defeq trick; no `False.elim`; cumulative state doc `state-UC-Lean-PathB-Y1.md`).

**Why first.** Every other Y-ticket depends on Y1's `BKBicomplexHC₂ F`.

### Y2 — `UC-Lean-PathB-Y2-WalshEquivariant`

**Title.** UC-Lean-PathB-Y2-WalshEquivariant: genuine `(ZMod 2)^n`-action on `BKBicomplexHC₂ F` + per-S isotype projector via abelian Maschke + integration with X3 + X4.

**Budget.** 350–400k.

**Deps.** Y1 (uses `BKBicomplexHC₂ F`).

**Deliverable.** New file `lean/UnionClosed/UC10/BKWalshEquivariant.lean`. Substantive new content:

- `BKToggleAction F σ : BKBicomplexHC₂ F ⟶ BKBicomplexHC₂ F` (Phase B.1.1).
- `BKEquivBicomplex F : (BKBicomplexHC₂ F).EquivariantBicomplex (∀ _ : Fin n, ZMod 2)` (Phase B.1).
- `walshIsotypeProj n S` — abelian Maschke projector (Phase B.2.1 + B.2.2).
- `BKIsotypeSubcomplex F S : HomologicalComplex C (.up ℕ)` (Phase B.2.3).
- `BKWalshIsotypeFamily F : (BKEquivBicomplex F).IsotypeFamily (Finset (Fin n))` (Phase B.3.1) — inhabits X3's `IsotypeFamily` with genuine per-S slices.
- `BKWalshIsotype_respectsDifferentials_via_X3` and `BKWalshIsotype_differential_isotype_zero_via_X4` (Phase B.3.2).

PROVEN; `lake build` GREEN.

**Acceptance bar.** (1) `lake build` GREEN. (2) Non-vacuous at `n = 3`: for `fullPowerset3` and the singleton `S = {0}`, `walshIsotypeProj 3 {0}` has non-trivial image; the χ_{0}-isotype subcomplex of `BKBicomplexHC₂ fullPowerset3` is non-zero. (3) The new `BKWalshIsotypeFamily F` is a strict X3 inhabitant (not the `coarse`/`trivial` placeholder), and `respectsDifferentials_of_degenerate` applies to it. (4) Hard-constraint set §0 respected; cumulative state doc `state-UC-Lean-PathB-Y2.md`.

### Y3 — `UC-Lean-PathB-Y3-HomotopyBridge`

**Title.** UC-Lean-PathB-Y3-HomotopyBridge: construct `Homotopy (𝟙 ((BKIsotypeSubcomplex F {x}))) 0` from `UC10_lowerWalshVanishing F x` — THE LOAD-BEARING BRIDGE.

**Budget.** 300–400k.

**Deps.** Y1 + Y2 (uses `BKBicomplexHC₂ F` and `BKIsotypeSubcomplex F S`).

**Deliverable.** New file `lean/UnionClosed/UC11/BKWalshHomotopyBridge.lean`. Substantive new content:

- `BKIsotypeColumn_h F x q : (BKIsotypeColumn F x).X q ⟶ (BKIsotypeColumn F x).X (q + 1)` (Phase C.1.1; the homotopy operators).
- `BKIsotypeColumn_nullHomotopy_eq F x` (Phase C.1.2 + C.1.3; the null-homotopy equation).
- `BKIsotypeColumn_nullHomotopy F x : Homotopy (𝟙 ((BKIsotypeColumn F x))) 0` (Phase C.1.4; the `Homotopy` object).
- `BKIsotypeColumn_nullHomotopy_uniform F : ∀ x : Fin n, Homotopy (𝟙 ((BKIsotypeColumn F x))) 0` (Phase C.2).

PROVEN; `lake build` GREEN.

**Acceptance bar.** (1) `lake build` GREEN. (2) Non-vacuous at `n = 3`: `BKIsotypeColumn_nullHomotopy fullPowerset3 (1 : Fin 3) : Homotopy ...` is a concrete `Homotopy` object (not zero everywhere; `h_0` is the explicit `walshScale' 3 {liftCoord 3 1} ∘ bridgeImg 3 0`). (3) **The construction explicitly invokes `UC10_lowerWalshVanishing F x` in the null-homotopy equation proof** (the mg-36c3 direct-invocation requirement, lifted from chain-identity to homotopy-object form). (4) Hard-constraint set §0 respected; cumulative state doc `state-UC-Lean-PathB-Y3.md`.

### Y4 — `UC-Lean-PathB-Y4-SSAbutmentVanishing`

**Title.** UC-Lean-PathB-Y4-SSAbutmentVanishing: apply the mg-b26c PROVEN composition kernel to Y3's homotopy + X5's edge map to derive per-x cohomology vanishing on the SS-derived object.

**Budget.** 200–300k.

**Deps.** Y1 + Y2 + Y3 + the existing X1-X5 mathlib infrastructure + the existing mg-b26c PROVEN composition kernel `SSAbutment_corner_vanishing_via_columnHomotopy`.

**Deliverable.** Substantive content added to `lean/UnionClosed/UC11/SSConvergence.lean` (extension, not replacement; the existing §X6Composition stays) or new file `lean/UnionClosed/UC11/BKSSCohomologyVanishing.lean`. Substantive new content:

- `BKEInftyVanishing_at_x F x` — `IsZero ((BKBicomplexHC₂ F).EInftyBicomplex (x, 0))_{χ_{x}-isotype}` via the mg-b26c PROVEN kernel applied to Y3's `BKIsotypeColumn_nullHomotopy F x` (Phase C.3.1).
- `BKEdgeMap F x` — X5 edge map specialisation for `BKBicomplexHC₂ F` (Phase C.3.2).
- `BKSSCohomologyVanishing F x` — combine into per-x `H^x(BKBicomplexHC₂ F .total)_{χ_x} = 0` (Phase C.3.3).

PROVEN; `lake build` GREEN.

**Acceptance bar.** (1) `lake build` GREEN. (2) Non-vacuous at `n = 3`: the per-x SS-cohomology vanishing on `fullPowerset3` is concretely zero in the χ_x-isotype slice of `(BKBicomplexHC₂ fullPowerset3).EInftyBicomplex`. (3) The chain `Y3.h → SSAbutment kernel → X5 edge map → per-x cohomology vanishing` is exhibited explicitly. (4) Hard-constraint set §0 respected; cumulative state doc `state-UC-Lean-PathB-Y4.md`.

### Y5 — `UC-Lean-PathB-Y5-PerXClosure` (THE CLOSURE TICKET)

**Title.** UC-Lean-PathB-Y5-PerXClosure: refactor `obstructionCohomClass` through the Y4 SS-derived cohomology and close the per-x sorry at `lean/UnionClosed/UC11/SSConvergence.lean`. **THE LAST sorry; zero live sorrys end-to-end.**

**Budget.** 200–300k.

**Deps.** Y1 + Y2 + Y3 + Y4.

**Deliverable.** Modify `lean/UnionClosed/UC11/CohomologyClass.lean` + `lean/UnionClosed/UC11/SSConvergence.lean`:

- Introduce `obstructionCohomClassSS F x : ... → (BKBicomplexHC₂ F).EInftyBicomplex (x, 0)_{χ_x}` (the SS-derived cohomology landing per UC13 §2.4.1 corrected landing).
- Refactor `obstructionCohomClass F x` to point to `obstructionCohomClassSS F x` via a `def`-alias or to be a quotient of the SS-derived object (decision: alias preserves the existing API while changing the implementation; this is the route mg-b26c §5.3 recommended).
- Close the per-x sorry at `obstructionCohomClass_at_vanishing_via_lowerWalsh`: the body becomes a one-liner invoking `BKSSCohomologyVanishing F x` + the new refactor's propositional identity `obstructionCohomClass F x = obstructionCohomClassSS F x`.
- The two mg-36c3 PROVEN structural-collision theorems (`per_x_cohom_vanishing_collides_topVertex_not_coboundary`, `aggregate_cohom_vanishing_collides_topVertex_not_coboundary`) become **propositionally inapplicable** to the new `obstructionCohomClassSS` (they were statements about the **old** `chainToHomology0`-derived class on `BKTotal n`); they remain PROVEN about the old object as historical record (see §4.5 below).

**Acceptance bar.** Carrying the full mg-c0d3 + mg-7f26 + mg-36c3 + mg-b26c hard-constraint set:

| # | Bar | Method of verification |
|---|---|---|
| §1 | Non-tautology preserved | The new `obstructionCohomClassSS F x` is a class in the SS-derived cohomology, propositionally distinct from the chain-level `Finsupp.single (topVertex F) (β_x F)` of the L2a baseline. Counterfactual: replacing `β_x F` with an arbitrary `Fin n → ℤ` should NOT make `obstructionCohomClassSS = 0` trivially. The closure proof goes through `BKSSCohomologyVanishing` (Y4), not through `Finsupp.single_eq_zero`. |
| §2 | n=3 + n=4 non-vacuous | `obstructionCohomClass_fullPowerset3_zero_via_iff` + `obstructionCohomClass_fullPowerset4_zero_via_iff` (mg-7f26, existing) ported to the new object: still hold by the propositional identity to the new object. The new object on `fullPowerset3` is concretely the zero element of the SS-derived cohomology via Y4. |
| §3 | Zero live sorrys | `grep -rn 'sorry' lean/UnionClosed/` returns empty. The per-x sorry at `obstructionCohomClass_at_vanishing_via_lowerWalsh` is closed via the Y5 refactor. **THE PROJECT-LIFE MILESTONE.** |
| §4 | No axiom-cheat | `grep -rn '^axiom' lean/UnionClosed/` returns empty. |
| §5 | No fake mathlib API | `lake build` GREEN. All SS infrastructure invoked is X1–X5 + Y1–Y4 plus existing mathlib. |
| §6 | No bypass with defeq | The per-x closure routes through `BKSSCohomologyVanishing F x` (Y4), explicitly applied to the Y3 `Homotopy` object; not a definitional shortcut. |
| §7 | No `False.elim` on `_hStar` | The Y5 proof body works at the SS level, independent of `IsCounterexample`. The `hStar` argument may be used only for `n ≥ 1` extraction (via the existing `counterexample_pos_n`). |
| §8 | Frankl_Holds non-vacuous at n=3, n=4 | `Frankl_Holds_fullPowerset3`, `Frankl_Holds_fullPowerset4` still close GREEN unconditionally (they invoke `obstructionCohomClass F`'s propositional behaviour, not its implementation; the alias preserves it). |
| §9 | Hard constraints | NOT factorial (the Y2 abelian Maschke uses `Mathlib.RepresentationTheory.Maschke` for finite-abelian `(ZMod 2)^n`; no Specht modules); NOT functorial in the refinement sense (Y1's bicomplex is native to `(C_n^∩)^op` bar resolution, not refinement-functorial); U1-dialect preserved (Walsh action is additive scalar action; no cup-product); math-first (Y1 aligns with UC10 §3.3; Y2 with UC10 §0.2 + §3.5; Y3 with UC13 §§4.5 + UC10 §5.3; Y4 with UC13 §7; Y5 with UC11 §6 + UC13 §2.4.1). |
| §10 | Mathlib-folder authorization scope respected | Y1, Y2, Y3, Y4 add files under `lean/UnionClosed/UC10/` and `lean/UnionClosed/UC11/` (union_closed-internal); the X1-X5 mathlib files are unchanged; no new files under `lean/UnionClosed/Mathlib/` unless a generic helper emerges in Y2's abelian-Maschke generalisation that warrants upstream-PR shape (in which case file a thin helper there with `MATHLIB-PR-CANDIDATE: yes`). |

### Sub-ticket budget summary

| Sub-ticket | Budget (k tokens) | Deps |
|---|---|---|
| Y1 — BKBicomplexHC₂ + bar-resolution differentials | 350–400 | (none) |
| Y2 — Walsh-equivariant + isotype projector + X3/X4 integration | 350–400 | Y1 |
| Y3 — Homotopy bridge from UC10_lowerWalshVanishing | 300–400 | Y1, Y2 |
| Y4 — SS-abutment vanishing per-x via mg-b26c kernel + X5 | 200–300 | Y1, Y2, Y3 |
| Y5 — `obstructionCohomClass` refactor + per-x sorry close | 200–300 | Y1, Y2, Y3, Y4 |
| **Arc total** | **1.40–1.80M** | |

Inside the ticket's "multi-week" estimate (~1.5–2M aggregate per mg-b26c §7.3). **Recommendation: file Y1 immediately as the next execution step.**

### Critical-path observations

- **Y1 → Y2 → Y3 → Y4 → Y5**: strictly serial. There is no parallelism in the Path B arc (each step requires the previous output). This is intrinsic to the engineering bridge — Y1's bicomplex is the substrate for Y2's action, Y2's isotype projector is the substrate for Y3's homotopy, Y3's homotopy is the input for Y4's vanishing, Y4's vanishing is the input for Y5's refactor.
- **No Y-sub-ticket requires the `SpectralObject.spectralSequence` TODO** (the Path A §A.1 AMBER); the X1-X5 mathlib infrastructure is GREEN at v4.29.1 and Y1-Y5 reuse it directly.
- **No mathlib-folder file additions in Y1-Y4-Y5; conditional in Y2** (only if a generic abelian-Maschke helper emerges that warrants upstream-PR shape).
- **Y3 is the load-bearing single step** — the `Homotopy` object construction from a Finsupp equation. If Y3 walls (e.g., the χ_{x}-isotype at higher degrees doesn't vanish cleanly, or the homotopy operator at degree 0 doesn't extend to degree `q ≥ 1` without additional structure), file an escalation ticket; re-audit Y1's bicomplex structure for the degree-`q` behaviour.

### Phase D summary table

| Phase | Y-ticket | Phase A/B/C deliverables consumed | New PROVEN content | Verdict at GREEN |
|---|---|---|---|---|
| Y1 | UC-Lean-PathB-Y1-BKBicomplexHC2 | A.1, A.2 | `BKBicomplexHC₂`, `TraceChainMap`, `BKHorizDiff_full`, `d²=0`, h/v commutativity | GREEN bicomplex landed |
| Y2 | UC-Lean-PathB-Y2-WalshEquivariant | A.3, B.1, B.2, B.3 | `BKEquivBicomplex`, `walshIsotypeProj`, `BKIsotypeSubcomplex`, `BKWalshIsotypeFamily` | GREEN equivariant + isotype landed |
| Y3 | UC-Lean-PathB-Y3-HomotopyBridge | C.1, C.2 | `BKIsotypeColumn_nullHomotopy` (the `Homotopy` object) | GREEN bridge landed |
| Y4 | UC-Lean-PathB-Y4-SSAbutmentVanishing | C.3.1, C.3.2 | `BKEInftyVanishing_at_x`, `BKEdgeMap`, `BKSSCohomologyVanishing` | GREEN per-x SS-vanishing landed |
| Y5 | UC-Lean-PathB-Y5-PerXClosure | C.3.3 + refactor | `obstructionCohomClassSS`, refactored `obstructionCohomClass`, **per-x sorry closed** | **GREEN PROJECT-LIFE MILESTONE — zero live sorrys end-to-end** |

---

## §5 — Open questions / dependencies / risks

### §5.1 The Y1 horizontal-functoriality concrete shape

`TraceChainMap (φ : TraceMor S T)` is the trace-restriction chain map. The current `TraceMor` data in `IntClosedFam` may not provide enough granularity for the chain-level restriction to be definitionally clean (the trace-cell `(A ∩ T.support, T' ∩ T.support)` requires the subcube condition to survive the restriction; this is mathematically true but the Lean statement may require additional helper lemmas). **Risk assessment**: low — paper-side UC10 §3.3 + UC11 §2 are clean about this; Lean engineering is direct but careful.

**Contingency**: if Y1 walls on the trace-functoriality details, sub-split Y1:

- **Y1a — `TraceChainMap` construction** (~200k): the chain-level restriction with full well-formedness preservation.
- **Y1b — `BKHorizDiff_full` + bicomplex assembly** (~200k): the bar-resolution + axiom checks, given Y1a.

This is a contingency, not the default plan.

### §5.2 The Y2 abelian-Maschke 1/2^n factor

The Y2 `walshIsotypeProj n S := (1 / 2^n) * Σ_σ walshChar n S (toggleSupport σ) • BKToggleAction σ` requires `(1 / 2^n : ℚ)` to be well-defined, which it is over `ℚ`. mathlib's `Mathlib.RepresentationTheory.Maschke` provides the general semisimplicity for finite groups over char-0 fields (already imported transitively via `UC10/Walsh.lean`); the abelian specialisation gives 1-dim irreps as the Walsh characters. **Risk assessment**: low — this is standard.

**Potential thin upstream PR.** If the Y2 implementation extracts a generic helper "abelian-Maschke 1-dim isotype projector for `(Fin n → ZMod 2)` over `ℚ`", it could go upstream as a small mathlib PR — this is the "conditional mathlib-folder addition in Y2" referenced in §4 D.

### §5.3 The Y3 χ_{x}-isotype at higher degrees `q ≥ 1`

The Y3 construction has `h_q = 0` for `q ≥ 1`, which requires the χ_{x}-isotype subcomplex of `BKBicomplexHC₂ F` to vanish at degrees `q ≥ 1` (otherwise the null-homotopy equation `𝟙 = d ∘ h + h ∘ d` is non-trivial at higher q). This vanishing follows because the BK row-q structure at `q ≥ 1` involves `singleFamilyChain c.tail q` with `q ≥ 1`, which is the cubical chain group at degree `q ≥ 1` of the cubical-Walsh-defect complex — and the χ_{x}-isotype slice of this group is **non-zero only at certain cells** corresponding to the toggle-stable subcubes.

The **precise statement** Y3 needs is: on the χ_{x}-isotype subcomplex of `BKBicomplexHC₂ F`, the boundary map `d : X_{q+1} → X_q` is invertible at degree `q ≥ 1` (so that the homotopy operator `h_q = 0` satisfies `𝟙 = d ∘ 0 + 0 ∘ d = 0`, which forces `𝟙 = 0` at degree `q ≥ 1`, i.e., the χ_{x}-isotype subcomplex IS zero at degree `q ≥ 1`).

**Alternative formulation**: the χ_{x}-isotype subcomplex of `BKBicomplexHC₂ F` is **concentrated in degree 0** at the union_closed application's relevant column. This is paper-side UC13 §2.4.1 corrected landing (the χ_x-component of `ob(F)` lives in `V_x^{n-1}` at the **specific cell** `(p, q) = (x, n-1-x)`; the other cells in the χ_{x}-isotype slice are zero by the corrected-landing argument).

**Risk assessment**: medium. The exact degree-grading of the χ_{x}-isotype subcomplex requires careful interaction between Y1's horizontal differential and Y2's idempotent projection. **Contingency**: if Y3 walls on the higher-degree behaviour, file a "Y3a — χ_{x}-isotype higher-degree vanishing" sub-ticket (~150k) before Y3 proper, to nail down the exact degree-grading of the χ_{x}-isotype subcomplex.

### §5.4 Y5's two-collision-theorems handling

The mg-36c3 PROVEN structural-collision theorems remain PROVEN about the **old** `chainToHomology0`-derived `obstructionCohomClass` on `BKTotal n`. Y5's refactor introduces a parallel `obstructionCohomClassSS` and points `obstructionCohomClass` to it via a `def`-alias or quotient. The collision theorems remain true about a now-vestigial object.

**Two options for Y5's handling:**

- **Option A (archive)**: leave the two collision theorems in `lean/UnionClosed/UC11/SSConvergence.lean` as historical record of the mg-36c3 diagnosis, with a doc-comment pointing to Y5 closure and noting they no longer feed the closure chain. **Recommended** — preserves diagnostic value.
- **Option B (restate or delete)**: replace the two collision theorems with new statements about `obstructionCohomClassSS`. **Not recommended** — the new object doesn't have the structural collision (it routes through SS-abutment, not through `chainToHomology0`), so the theorems would become vacuous or trivially restated.

**Decision**: Option A. Carry the historical record forward.

### §5.5 The Y2 hocolim-lift question

The genuine `(ZMod 2)^n` action on `BKBicomplexHC₂ F` requires the toggle action to absorb the family-flipping (toggling `A` may produce a set not in `F.family`, which UC10 §2.4 notes is the technical price of dodging C3). The hocolim-lift mechanism (UC10 §3.3 + UC11 §2: the indexing over `OpChain n p` absorbs the flipping via trace-functoriality) is paper-side standard but Lean-side new.

**Risk assessment**: medium-low. The hocolim mechanism is the entire reason the BK bicomplex is built over `(C_n^∩)^op` rather than over a single family — it's structurally designed for this. **Contingency**: if Y2 walls on the hocolim-lift details (e.g., the per-OpChain toggle-tracking is more complex than expected), sub-split Y2:

- **Y2a — `BKToggleAction` construction + group laws** (~250k).
- **Y2b — Isotype projector + X3/X4 integration** (~200k).

### §5.6 The Y3 alternative if higher-degree χ_{x}-isotype is non-vanishing

If the §5.3 worry materialises (χ_{x}-isotype subcomplex has non-zero higher-degree pieces), Y3 needs **genuine non-zero `h_q` for `q ≥ 1`**. The construction extends:

- `h_q` for `q ≥ 1` is constructed iteratively from the higher-degree analogue of `bridgeOpAt` on the trace-category bar resolution.
- The null-homotopy equation `𝟙 = d ∘ h + h ∘ d` is proven by induction on `q`, with the base case `q = 0` from UC10_lowerWalshVanishing and the inductive step from the bar-resolution simplicial structure.

This extension is **paper-side standard** (the bridge null-homotopy lifts to higher degrees via the bar-resolution acyclicity), but adds ~150k to Y3 budget (total Y3 = ~400–550k, may need a Y3a/Y3b split).

### §5.7 Mathlib upstream-PR cadence

Path B does NOT require any mathlib-PR additions (the X1-X5 mathlib SS infrastructure is already in place from the Path A arc). The optional thin abelian-Maschke isotype-projector helper from Y2 §5.2 is the only candidate; defer the upstream PR submission to a later cleanup pass post-Y5 GREEN.

---

## §6 — Verdict + next step

**Verdict.** **GREEN scoping complete + Y1–Y5 decomposition pinned + Phase D closure-ticket scope named.**

**Audit summary (Phases A + B + C).** Nine pieces total. Three GREEN (A.3 Walsh-equivariance lift, C.2 per-coord uniformity, plus the architectural verdict on all of Phases A + B + C being non-blocked). Six AMBER but engineering-bounded (A.1 + A.2 + B.1 + B.2 + B.3 + C.1 + C.3 — substantive Lean construction, but each architecturally direct with paper-side standard reference). **No structural impossibility found.** No mathlib infrastructure missing. No axiom-named relaxation needed.

**Sub-tickets (Phase D).** Y1 (BKBicomplexHC2 + bar resolution) → Y2 (Walsh-equivariant + isotype projector) → Y3 (Homotopy bridge) → Y4 (SS-abutment vanishing) → Y5 (per-x closure + `obstructionCohomClass` refactor). Total budget ~1.40–1.80M tokens (inside the ticket's multi-week estimate). Critical path strictly serial. Each Y-ticket single-session-capable (≤ 400k).

**Closure ticket (Y5).** Refactors `obstructionCohomClass` to land in the SS-derived cohomology; the per-x sorry is closed by combining Y4's `BKSSCohomologyVanishing F x` with the propositional identity to the new object. **THE PROJECT-LIFE MILESTONE "zero live sorrys end-to-end" trigger.** Acceptance bar carries full mg-c0d3 + mg-7f26 + mg-36c3 + mg-b26c hard-constraint set; verdict structure is GREEN (zero live sorrys; project-life milestone) / AMBER (single Y5-residual adaptation gap) / RED (escalation).

**Next operational step (Daniel decision).** File **Y1 (`UC-Lean-PathB-Y1-BKBicomplexHC2`) as the next execution ticket**. Budget 350–400k, single-session-capable, no internal deps, union_closed-internal placement under `lean/UnionClosed/UC10/`. Polecat: Lean-engineering + Bousfield-Kan + chain-complex bicomplex architecture comfort. Sequential Y2 → Y3 → Y4 → Y5 to follow after Y1 GREEN.

---

## §7 — Cross-references

- **Parent**: mg-b26c (UC-Lean-SS-X6-PerXClosure, AMBER named composition gap; Lean-Session 26 of `docs/state-UC10.md`; `docs/state-UC-Lean-SS-X6.md` for the full cumulative ledger).
- **Parent arc**: mg-7413 (Path A scoping, GREEN; Lean-Session 20). Scoping doc: `docs/UC-Lean-mathlib-SS-scope.md`. X1-X5 sub-tickets all GREEN (mg-dd80 / mg-55b3 / mg-fade / mg-c128 / mg-455f, Lean-Sessions 21-25).
- **mg-36c3 RED structural diagnosis**: `docs/state-UC-Lean-per-x-closure.md` + Lean-Session 19. The two PROVEN structural-collision theorems (`per_x_cohom_vanishing_collides_topVertex_not_coboundary`, `aggregate_cohom_vanishing_collides_topVertex_not_coboundary`) remain PROVEN about the **L2a baseline `BKTotal n`** — they become inapplicable to Y5's new SS-derived `obstructionCohomClassSS`. **Y5 archives the collision theorems as historical record (§5.4 Option A).**
- **Daniel directives**:
  - 2026-05-16 23:12Z ("bite the bullet and build the mathlib infrastructure") + 23:23Z ("start now per the no-waiting rule") — triggered Path A.
  - 2026-05-17 05:48Z ("b as per don't block because of scope increase and achieve sorry-free axiom-free formalization") — chose Path B over Path E, triggered this scoping.
  - Mathlib-folder authorization (17:47Z + 23:12Z + 05:48Z) scoped to BKBicomplex + Walsh-equivariant + Homotopy bridge infrastructure for this arc.
- **Source repo**: `/Users/daniel/research/union_closed`. Default branch policy.
- **Mathlib pinned**: `v4.29.1`, rev `5e932f97dd25535344f80f9dd8da3aab83df0fe6` (per `lean/lake-manifest.json`).
- **Cumulative state**: `docs/state-UC-Lean-PathB-BKBicomplex-scope.md` (this session's ledger, NEW), `docs/state-UC10.md` Lean-Session 27 (this session, NEW).
- **Forward execution sub-tickets** (to be filed sequentially after this scoping GREEN): Y1, Y2, Y3, Y4, Y5.
- **Sibling paths** (alternatives Daniel did NOT choose):
  - Path A (multi-month, mathlib SpectralSequence infrastructure) — chosen and completed by mg-7413 → mg-b26c arc; provides the X1-X5 API that Y1-Y5 consume.
  - Path E (named-axiom, project-life trade-off) — accept the per-x cohomology vanishing as a named axiom; **the simplest path, forbidden by current hard-constraint set** ("achieve sorry-free axiom-free formalization" per Daniel 05:48Z directive).
