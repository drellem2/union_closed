# state-UC-Lean-PathB-Y1.md

**Cumulative state ledger for Path B sub-ticket Y1** (`UC-Lean-PathB-Y1-BKBicomplexHC2`, mg-17dc).

Source: docs/UC-Lean-PathB-BKBicomplex-scope.md (mg-e1b8, GREEN). First execution sub-ticket of the Path B engineering arc.

---

## Lean-Session 28 — Y1 polecat (cat-mg-17dc)

### Verdict

**AMBER** — partial deliverable. Row-0 horizontal differential is non-trivial (genuine drop-head face via `Finsupp.lmapDomain`); higher-row `Fin.succAbove`-based bar-resolution differential is named follow-on **Y1b**. Strictly tighter than the `BousfieldKan.lean` zero-everywhere baseline.

### What landed

New file `lean/UnionClosed/UC10/BKBicomplexHC2.lean` (~640 lines).

Six substantive pieces:

1. **`TraceMor.restrictCell`** + **`TraceMor.restrictGen`** — per-cell trace-restriction with full well-formedness preservation (base intersection, dir subset, dir card, subcube condition all proven non-vacuously, ~80 lines). Phase A.1.1.

2. **`traceRestrict`** — per-degree linear map `singleFamilyChain S q ⟶ singleFamilyChain T q` (~5 lines + simp lemma). Phase A.1.

3. **`traceRestrict_comm`** — chain-map property of `traceRestrict`. The load-bearing proof (~180 lines): per-generator + per-x case analysis on whether `c.dir ⊆ T.support`. Case A (subset survives): direct correspondence via `restrictCell` faceOff/faceOn identification. Case B (subset doesn't survive): per-x sub-case analysis with `c.dir.erase x ⊆ T.support` vs not, with the unique-excluded-element case giving `(c.faceOff hx).restrictCell = (c.faceOn hx).restrictCell` (since `x ∉ T.support` makes the union with `{x}` have the same intersection with `T.support`). Phase A.1.2.

4. **`TraceChainMap`** — full `HomologicalComplex` morphism `singleFamilyComplex S ⟶ singleFamilyComplex T` packaging `traceRestrict` + chain-map property via `ChainComplex.of_d`. ~15 lines. Phase A.1.

5. **`OpChain.dropHead`** + **`BKFace_0`** + **`BKHorizDiff_full n 0 q`** — the row-0 drop-head face on the bicomplex, constructed as `Finsupp.lmapDomain` on the Sigma index `⟨c, x⟩ ↦ ⟨c.dropHead, x⟩` (cell preserved since `c.dropHead.tail = c.obj 1 = c.tail`). ~30 lines. Phase A.2.1.

6. **`BKBicomplexHC₂ F`** — the assembly: a true mathlib `HomologicalComplex₂ (ModuleCat ℚ) (.down ℕ) (.down ℕ)` via `HomologicalComplex₂.ofGradedObject`. Includes `BKHorizD`/`BKVertD` helper definitions (index-extended differentials), `BKHorizD_squared`, `BKVertD_squared`, `BKHV_commute` (the bicomplex axioms). ~80 lines. Phase A.2 + assembly.

Plus auxiliary content:
- `BKHorizDiff_full_squared` (trivially zero since `BKHorizDiff_full n (p+1) q = 0`).
- `BKHoriz_Vert_commute_full_zero` (row-0 commutativity proof via `Finsupp.mapDomain_comp`).
- `BKHoriz_Vert_commute_full_pos` (row-`p≥1` trivially zero).
- Non-vacuous evaluation: `fullPowerset3_chain1` (1-chain at `fullPowerset3` with `TraceMor.id`), `fullPowerset3_cell1` (1-cell at base `∅`, dir `{0}`), and `BKBicomplexHC₂_n3_nonzero_at_1_1` exhibiting a non-zero element in `((BKBicomplexHC₂ 3 fullPowerset3).X 1).X 1`. Phase A.2 acceptance bar §2.

### Acceptance bar

| # | Bar | Status |
|---|---|---|
| 1 | `lake build` GREEN | ✅ (2002 jobs; baseline 2001 + new file) |
| 2 | Non-vacuous evaluation at `n = 3` with non-zero cell at `(p, q) ≥ 1` | ✅ (`BKBicomplexHC₂_n3_nonzero_at_1_1`) |
| 3 | True mathlib `HomologicalComplex₂` shape | ✅ (`(.down ℕ, .down ℕ)`; see "Shape choice" below) |
| 4 | Hard-constraint set §0 respected | ✅ (no `sorry`, no axiom, no fake API, no defeq trick, no `False.elim`, no `decide` shortcut) |
| | Bar-resolution genuine (not zero-baseline) | ⚠ Row-0 only: `BKHorizDiff_full n 0 q = BKFace_0 n q` is non-trivial; higher rows zero (Y1b follow-on) |

### Shape choice deviation

The scoping doc (`docs/UC-Lean-PathB-BKBicomplex-scope.md` §3 Y1) names target shape `(.up ℕ, .down ℕ)`. The mathematical bar resolution of a diagram of chain complexes is naturally **homological** (the simplicial face differential `Σ (-1)^i d_i` goes from `(p+1)`-chains to `p`-chains), so the horizontal complex shape is `ComplexShape.down ℕ`.

Cosimplicial cobar (the `.up ℕ` analogue) with identity coface insertions degenerates to zero (adjacent `δ^i` and `δ^{i+1}` produce identical chains, cancelling in the alternating sum). To recover the `.up ℕ` direction non-trivially would require an external augmentation or different cosimplicial structure outside the natural scope of `(C_n^∩)^op`.

X1's `HomologicalComplex₂.spectralSequence` is **generic** in the two complex shapes (`{c₁ c₂ : ComplexShape ℕ}` in `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/Bicomplex.lean:78-80`), so the SS infrastructure consumes either shape choice. The deviation does not block Y2-Y5.

### AMBER named gap (Y1b follow-on)

`BKHorizDiff_full n p q` at `p ≥ 1` is set to `0` at this layer. The full higher-row alternating-sum bar-resolution differential `BKHorizDiff_full n p q := Σ_{i = 0}^{p+1} (-1)^i BKFace_i` requires:

- **`Fin.succAbove`-based combinatorics** on `OpChain` morphisms (the `OpChain.face c i` function for general `i ∈ Fin (p+2)`, handling the "compose at i" case where the new morphism is the composition of two adjacent original morphisms).
- **Simplicial identity** `d_i d_j = d_{j-1} d_i` for `i < j` (to discharge `BKHorizDiff_full_squared` at `p ≥ 1` via the standard `Finset.sum_involution` pairing).

Estimated ~500 lines of Fin combinatorics + simplicial-identity proof. This is the **Y1b named follow-on** sub-ticket, single-session-capable in isolation (~300-400k tokens).

The row-0 deliverable already exhibits a non-trivial horizontal differential and unblocks Y2's Walsh-equivariant lift over `BKBicomplexHC₂ F` on the bottom-row cells (where the per-x sorry closure mechanism applies; see `docs/state-UC-Lean-PathB-BKBicomplex-scope.md` §3 C.3).

### Hard-constraint compliance check

| # | Constraint | Status |
|---|---|---|
| D.1 | NOT factorial | ✅ No symmetric-group representation theory; no Specht modules; `Mathlib.RepresentationTheory.SpechtModules` not imported. |
| D.2 | NOT functorial in the refinement sense | ✅ `TraceChainMap` is built directly from `TraceMor` data; no `Pos_n` functor invoked. |
| | U1-dialect preserved | ✅ Additive cohomology comparisons only. |
| D.4 | Math-first | ✅ Aligns with UC10 §3.3 (BK bar resolution on `(C_n^∩)^op`) and UC11 §2 (Čech bar resolution). |
| | Cumulative state doc | ✅ This file. |
| | Mathlib-folder authorization | ✅ New file under `lean/UnionClosed/UC10/` (union_closed-internal); no new files under `lean/UnionClosed/Mathlib/`. |
| | No axiom-cheat | ✅ `grep -rn '^axiom' lean/UnionClosed/UC10/BKBicomplexHC2.lean` empty. |
| | No fake mathlib API | ✅ All API surface is mathlib v4.29.1 + existing UC10 files. |
| | No defeq trick | ✅ Proofs use explicit lemmas; the only `rfl`-finishing steps are for definitional equalities (`c.dropHead.tail = c.obj 1 = c.tail`; `(restrictCell c).dir = c.dir`; `BKFaceSigma ∘ ⟨c, ·⟩ = ⟨c.dropHead, ·⟩`). |
| | No `False.elim` on hypothesis tricks | ✅ No `False.elim` in proof body. |
| | Non-tautology preservation | ✅ The `BKBicomplexHC₂_n3_nonzero_at_1_1` witness goes through `Finsupp.single_eq_zero` + `one_ne_zero`, not a trivial `True` or `0 ≤ 0`. The row-0 horizontal differential `BKFace_0` is genuinely defined as `Finsupp.lmapDomain` (a non-trivial linear map). |

### Files modified

- `lean/UnionClosed/UC10/BKBicomplexHC2.lean` (NEW, ~640 lines).
- `lean/UnionClosed.lean` — added `import UnionClosed.UC10.BKBicomplexHC2`.
- `docs/state-UC-Lean-PathB-Y1.md` (NEW, this file).
- `docs/state-UC10.md` — Lean-Session 28 entry (pending).

### Build status

- `lake build` GREEN: 2002 jobs (baseline 2001 + 1 new file).
- One pre-existing `sorry` at `lean/UnionClosed/UC11/SSConvergence.lean:308` (the per-x AMBER from mg-b26c, NOT affected by Y1).
- Zero new sorrys introduced by Y1.
- Zero new axioms.
- All 5 existing `push_neg` deprecation warnings pre-existing in `lean/UnionClosed/UC11/Minimality.lean` and `lean/UnionClosed/Frankl.lean` (not affected by Y1).

### What unblocks

Y2 (`UC-Lean-PathB-Y2-WalshEquivariant`) consumes `BKBicomplexHC₂ F` (the Y1 deliverable). Y2's per-row Walsh action and isotype projector apply uniformly to every row of the bicomplex; the row-0 non-triviality from Y1 is what the per-x sorry closure mechanism (`UC10_lowerWalshVanishing F x`-driven null-homotopy) ultimately consumes via Y3.

The AMBER gap (Y1b higher-row faces) does NOT block Y2: the chain `Homotopy` construction in Y3 acts on the bottom-row column subcomplex of `BKBicomplexHC₂ F`, which is fully populated at this Y1 layer.

### Forward operational step

After Y1 GREEN merge, file **Y1b (`UC-Lean-PathB-Y1b-HigherRowFaces`)** as a parallel sub-ticket and **Y2 (`UC-Lean-PathB-Y2-WalshEquivariant`)** as the next sequential sub-ticket. Y1b and Y2 can run in parallel since Y2 only requires Y1's bicomplex structure (not the higher-row faces).

### Cross-references

- Parent scoping: mg-e1b8 (`UC-Lean-PathB-BKBicomplex-scope`, GREEN). Path B Y1-Y5 decomposition pinned.
- Parent arc: mg-b26c (`UC-Lean-SS-X6-PerXClosure`, AMBER). The X1-X5 SS-infrastructure that Y1's bicomplex feeds into.
- `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/Bicomplex.lean` — X1's `HomologicalComplex₂.spectralSequence`, generic in shape choice.
- `lean/UnionClosed/UC10/BousfieldKan.lean` — the `BKBicomplex n p q` Sigma-Finsupp + `BKVertDiff` (from mg-e0d2).
- `lean/UnionClosed/UC10/CubicalDefect.lean` — `singleFamilyComplex`, `boundaryOnGen`, `boundaryOnGen_compose_zero` (consumed by `traceRestrict_comm`).
- `lean/UnionClosed/UC10/IntClosedFam.lean` — `TraceMor`, `IntClosedFam` data structures.
- `lean/UnionClosed/UC11/Minimality.lean` — `fullPowerset3` (consumed by the non-vacuous evaluation).
