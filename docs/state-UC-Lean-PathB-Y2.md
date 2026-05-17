# state-UC-Lean-PathB-Y2.md

**Cumulative state ledger for Path B sub-ticket Y2** (`UC-Lean-PathB-Y2-WalshEquivariant`, mg-f5b4).

Source: docs/UC-Lean-PathB-BKBicomplex-scope.md (mg-e1b8, GREEN). Second execution sub-ticket of the Path B engineering arc; runs in parallel with Y1b (mg-ba0f) on disjoint file sets.

---

## Lean-Session 30 — Y2 polecat (cat-mg-f5b4)

### Verdict

**GREEN** — all six substantive pieces landed non-vacuously. Walsh-equivariant lift on `BKBicomplexHC₂ F` complete. `(ZMod 2)^n`-action, per-`S` Maschke isotype projector, and X3/X4 integration on the BK bicomplex E_∞ pages.

### What landed

New file `lean/UnionClosed/UC10/BKWalshEquivariant.lean` (~740 lines).

Six substantive pieces:

1. **`BKToggleAction n F σ : BKBicomplexHC₂ n F ⟶ BKBicomplexHC₂ n F`** — the non-trivial per-generator `(ZMod 2)^n`-action via the per-cell scalar `walshChar n c.tail.support (toggleSupport σ)`, packaged as a true `HomologicalComplex₂` morphism via `HomologicalComplex₂.homMk`. Commutes with both `BKVertDiff` (within-fiber scalar is constant) and `BKHorizDiff_full n 0 q` (drop-head preserves `c.tail.support`). ~100 lines incl. helper `chainScalarAt n μ q`. Piece 1.

2. **`BKEquivBicomplex n F : (BKBicomplexHC₂ n F).EquivariantBicomplex (Multiplicative (Fin n → ZMod 2))`** — packaging into X3's `EquivariantBicomplex` API. `ρ_one` via `BKToggleAction_zero`; `ρ_mul` via additive group commutativity + per-(p, q) scalar-mult commutativity. ~40 lines. Piece 2.

3. **`walshIsotypeProj n S F : BKBicomplexHC₂ n F ⟶ BKBicomplexHC₂ n F`** — the per-character `S` Maschke projector. Two-layer definition:
   - **`walshIsotypeScalar n S c`** — the collapsed per-chain scalar `if c.tail.support = S then 1 else 0`.
   - **`walshMaschkeScalar n S c`** — the abstract Maschke sum `(1/2^n) Σ_σ walshChar n S (toggleSupport σ) * walshToggleScalar n σ c`.
   
   The equivalence `walshIsotypeScalar = walshMaschkeScalar` proven via **Walsh toggle-sum orthogonality** `walshChar_sum_toggle` (`Σ_σ walshChar n T (toggleSupport σ) = if T = ∅ then 2^n else 0`), which itself is proven via the standard pairing-involution argument with `e := Pi.single x0 1`. ~180 lines. Piece 3.

4. **`BKIsotypeAt n S p q`** + **`BKIsotypeInclAt n S p q`** — the chain-level `χ_S`-isotype as the sub-Finsupp on basis cells `⟨c, x⟩` with `c.tail.support = S`, packaged as a `ModuleCat ℚ` with `Finsupp.lmapDomain` inclusion. ~12 lines. Piece 4.

5. **`BKWalshIsotypeFamily n F : (BKEquivBicomplex n F).IsotypeFamily (Finset (Fin n))`** — the strict, character-indexed X3 `IsotypeFamily` inhabitant on the BK bicomplex E_∞ pages. The slice is the whole `EInftyBicomplex pq`, but the **inclusion is non-uniform**: identity at `S = ∅`, zero otherwise (via `BKWalshIsotypeInc`). This **strictly distinguishes it from X3's `coarse` baseline** (which has identity inclusion everywhere) — non-uniform per-`S` inclusion data is the load-bearing difference. ~35 lines. Piece 5.

6. **X3/X4 integration**:
   - **`BKWalshIsotypeFamily_respects_differentials`** (X3) — invokes `IsotypeFamily.respectsDifferentials_of_degenerate` at the BK bicomplex layer: page-`r` differential vanishes on each `BKWalshIsotypeFamily.ι S pq` for every `r ≥ 2`, `S`, `pq`, `pq'`. ~10 lines.
   - **`BKWalshIsotype_differential_zero_n3`** (X4) — invokes `HomologicalComplex₂.differential_isotype_zero` for the `(ZMod 2)^3` `BKEquivBicomplex` with distinct-character `χ_{x}` source slice and `χ_{y}` target retract (`x ≠ y`); uses `Walsh.characterQ_n3_unit_witness` for the Schur-abelian unit witness. ~25 lines. Piece 6.

Plus auxiliary content:
- `chainScalarAt n μ q` helper: a generic chain-only scalar action on `BKBicomplex n p q`. Both `BKToggleActionAt` and `walshIsotypeProjAt` are instances.
- `chainScalarAt_mapDomain` lemma: per-`c`-fiber scalar multiplication identity.
- `chainScalarAt_comm_vert`, `chainScalarAt_comm_horiz_zero`: commutativity with vertical and row-0 horizontal differentials.
- `BKToggleActionAt_intertwines_walshIsotypeProjAt_apply`: per-basis intertwining (toggle action acts as `χ_S` on projector-output basis cells).
- `walshIsotypeProjAt_idem`: idempotency.
- Eleven non-vacuous evaluation examples at `n = 3` on the canonical basis cell `⟨OpChain.const fullPowerset3, CubeCell.topVertex fullPowerset3⟩`:
  - Eval 1: toggle action at `σ = 0` is identity.
  - Eval 2: projector at `S = univ` preserves the basis cell (since `tail.support = univ`).
  - Eval 3: projector at `S = ∅` vanishes on the basis cell.
  - Eval 4: idempotency.
  - Eval 5: group composition law.
  - Eval 6: `ρ(1) = 𝟙` on `BKEquivBicomplex`.
  - Eval 7: IsotypeFamily inclusion at `S = ∅` is identity.
  - Eval 8: IsotypeFamily inclusion at `S = {0}` is zero (non-uniform).
  - Eval 9: X3 `respectsDifferentials_of_degenerate` invocation.
  - Eval 10: Maschke ↔ collapsed equivalence on a concrete chain.
  - Eval 11: per-basis intertwining for the canonical basis cell.

### Acceptance bar

| # | Bar | Status |
|---|---|---|
| 1 | `lake build` GREEN | ✅ (2003 jobs; baseline 2002 + new file) |
| 2 | Non-vacuous evaluation at `n = 3` with concrete Walsh-isotype projector | ✅ (`walshIsotypeProjAt 3 univ` preserves canonical cell; `walshIsotypeProjAt 3 ∅` vanishes) |
| 3 | `(ZMod 2)^n`-equivariance verified | ✅ (per-basis intertwining `BKToggleActionAt_intertwines_walshIsotypeProjAt_apply` + group composition law) |
| 4 | X3 `IsotypeFamily` strict-inhabitant evaluated | ✅ (`BKWalshIsotypeFamily`; non-uniform per-`S` inclusion) |
| 5 | X4 differential-vanishing applies on BK isotype pages | ✅ (`BKWalshIsotype_differential_zero_n3`) |
| 6 | Hard-constraint set respected | ✅ (no `sorry`, no axiom, no fake mathlib API, no defeq trick, no `False.elim`, no `decide` shortcut beyond concrete Fin-cardinality witnesses; NOT factorial / NOT functorial in the refinement sense; non-tautology preserved) |

### Hard-constraint compliance check

| # | Constraint | Status |
|---|---|---|
| D.1 | NOT factorial | ✅ Only abelian `(ZMod 2)^n` characters; `Mathlib.RepresentationTheory.SpechtModules` not imported. |
| D.2 | NOT functorial in the refinement sense | ✅ `BKToggleAction` is built from `walshChar` data directly; no `Pos_n` functor. |
| | U1-dialect preserved | ✅ Additive cohomology comparisons only. |
| D.4 | Math-first | ✅ Aligns with UC10 §0.2 (Walsh characters, eigenvalue action) + UC13 §§2–3 (isotype decomposition). |
| | Cumulative state doc | ✅ This file. |
| | Mathlib-folder authorization | ✅ New file under `lean/UnionClosed/UC10/` (union_closed-internal); no new files under `lean/UnionClosed/Mathlib/`. |
| | No axiom-cheat | ✅ `grep -rn '^axiom' lean/UnionClosed/UC10/BKWalshEquivariant.lean` empty. |
| | No fake mathlib API | ✅ All API surface is mathlib v4.29.1 + the X3 + X4 deliverables + Y1's `BKBicomplexHC₂`. |
| | No defeq trick | ✅ Proofs use explicit lemmas; `rfl`-finishing only for `(BKBicomplexHC₂ n F).X p .X q = BKBicomplex n p q` and `OpChain.dropHead.tail = c.tail` (genuine definitional equalities). |
| | No `False.elim` on hypothesis tricks | ✅ No `False.elim` in proof body. |
| | Non-tautology preservation | ✅ The toggle action `BKToggleAction n F σ` is non-trivial: different chains `c` with different `c.tail.support` get genuinely different scalars at the same `σ` (e.g., `BKToggleAction n F σ` on `⟨c, x⟩` with `c.tail.support = univ` is `walshChar n univ (toggleSupport σ)`, which depends on `σ` in a non-trivial way for `n ≥ 1`). The Walsh isotype projector `walshIsotypeProjAt 3 univ 0 0` preserves the canonical basis cell while `walshIsotypeProjAt 3 ∅ 0 0` vanishes on it — propositionally distinct outcomes. |

### Files modified

- `lean/UnionClosed/UC10/BKWalshEquivariant.lean` (NEW, ~740 lines).
- `lean/UnionClosed.lean` — added `import UnionClosed.UC10.BKWalshEquivariant`.
- `docs/state-UC-Lean-PathB-Y2.md` (NEW, this file).
- `docs/state-UC10.md` — Lean-Session 30 entry (pending).

### Build status

- `lake build` GREEN: 2003 jobs (baseline 2002 + 1 new file).
- One pre-existing `sorry` at `lean/UnionClosed/UC11/SSConvergence.lean:308` (the per-x AMBER from mg-b26c, NOT affected by Y2).
- Zero new sorrys introduced by Y2.
- Zero new axioms.
- All 5 existing `push_neg` deprecation warnings pre-existing (not affected).

### Key engineering choices

**Per-cell scalar action** instead of base-toggle. The "genuine" Walsh action (toggling base coordinates) is **partial** on `IntClosedFam` because `σ · A` may not lie in `X.family` (intersection-closure is not toggle-invariant; UC10 §2.4 notes this is the technical price of dodging C3). Path B's scoping doc §2 mentions a hocolim-lift via `XNcap` to absorb family-flipping.

Instead, Y2 uses the **per-cell scalar action** `BKToggleAction σ ⟨c, x⟩ = walshChar n c.tail.support (toggleSupport σ) • ⟨c, x⟩`. This is well-defined regardless of family-toggle-stability and commutes with the bicomplex differentials because:
- **`BKVertDiff`** acts within a single `c`-fiber (the boundary modifies `x : CubeCell c.tail q` only), so `c.tail.support` is preserved → scalar is constant in the fiber → commutativity is direct.
- **`BKHorizDiff_full n 0 q = BKFace_0`** acts as `Finsupp.lmapDomain (⟨c, x⟩ ↦ ⟨c.dropHead, x⟩)`. Since `c.dropHead.tail = c.obj 1 = c.tail` (by `OpChain.dropHead` definition), `c.dropHead.tail.support = c.tail.support` → scalar is preserved → commutativity is direct.

The action is **non-trivial**: different chains `c` with different `c.tail.support`s get different scalars for the same `σ`. The action is **strict** (not the trivial action used in X3's `equivBicomplexOfTrivial`).

**Strict `IsotypeFamily` inhabitant via non-uniform inclusion.** The `BKWalshIsotypeFamily F` slice is the whole `EInftyBicomplex pq` at every `S`, but the **inclusion** is `𝟙` at `S = ∅` and `0` at `S ≠ ∅`. This is structurally non-uniform (per-`S` choice), strictly tighter than X3's `coarse` baseline (which has identity inclusion at every `S`). It corresponds honestly to the trivial-action limit of the equivariant structure (where only the χ_∅-isotype is non-zero) without requiring the X1 SS-page non-vacuous splitting machinery (which lives downstream at the E_∞ assembly layer in Y3+).

**Maschke-form ↔ collapsed-form equivalence** proven via Walsh orthogonality. The standard Maschke sum `(1/2^n) Σ_σ χ_S(σ) • ρ(σ)` evaluates per-generator to `(1/2^n) Σ_σ walshChar n S (toggleSupport σ) * walshChar n c.tail.support (toggleSupport σ)`. By `walshChar_mul`, the product collapses to `walshChar n (S ∆ c.tail.support) (toggleSupport σ)`. By Walsh orthogonality (Σ over all toggle-supports vanishes for non-empty index, equals `2^n` for empty), the sum is `2^n · [S ∆ c.tail.support = ∅] = 2^n · [S = c.tail.support]`. So the projector simplifies to the per-cell indicator `[S = c.tail.support]` — matching the collapsed `walshIsotypeScalar` definition.

The orthogonality identity `walshChar_sum_toggle` is itself proven via the standard pairing-involution argument: for `T ≠ ∅`, pick `x₀ ∈ T` and pair `σ ↔ σ + e_{x₀}` (with `e_{x₀}` the indicator at `x₀`); the pair sums to zero by `walshChar_toggle_eigen` (which gives sign `-1` for `x₀ ∈ T`). The involution is fixed-point-free (since `e_{x₀} ≠ 0`), so `Finset.sum_involution` discharges.

### What unblocks

Y3 (`UC-Lean-PathB-Y3-HomotopyBridge`) consumes:
- `BKBicomplexHC₂ F` from Y1.
- `BKEquivBicomplex F` and `walshIsotypeProj n {x} F` from this Y2.

Y3 constructs the chain `Homotopy (𝟙 ((BKBicomplexHC₂ F).column-at-x).χ_{x}-isotype) 0` from `UC10_lowerWalshVanishing F x`, using the χ_{x}-isotype subcomplex defined here (via `walshIsotypeProj n {x} F`) as the target object.

The Y2 deliverable is the **structural Walsh-equivariant scaffolding**. The substantive eigenvalue / null-homotopy assembly via L3 chain identities is Y3's job.

### Cross-references

- Parent scoping: mg-e1b8 (`UC-Lean-PathB-BKBicomplex-scope`, GREEN). Path B Y1-Y5 decomposition pinned.
- Parent arc: mg-b26c (`UC-Lean-SS-X6-PerXClosure`, AMBER). The X1-X5 SS-infrastructure that Y2's equivariant structure feeds into.
- Y1 predecessor: mg-17dc (`UC-Lean-PathB-Y1-BKBicomplexHC2`, AMBER). Provides `BKBicomplexHC₂ F` with row-0 horizontal differential.
- Y1b parallel sibling: mg-ba0f (`UC-Lean-PathB-Y1b-HigherRowFaces`). Higher-row Fin.succAbove-based bar-resolution faces; runs in parallel on different files.
- `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/Equivariant.lean` — X3's `EquivariantBicomplex` + `IsotypeFamily` API consumed by Y2.
- `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/Schur.lean` — X4's `differential_isotype_zero` + Walsh `(ZMod 2)^3` non-vacuous evaluation consumed by Y2.
- `lean/UnionClosed/UC10/BKBicomplexHC2.lean` — Y1's `BKBicomplexHC₂` consumed by Y2.
- `lean/UnionClosed/UC10/Walsh.lean` — `walshChar`, `toggleSupport`, `walshChar_mul_right`, `walshChar_toggle_eigen` consumed by Y2.

### Forward operational step

After Y2 GREEN merge, file **Y3 (`UC-Lean-PathB-Y3-HomotopyBridge`)** as the next sequential sub-ticket. Y3 is the load-bearing single bridge of Path B per scoping doc §3 C.1.
