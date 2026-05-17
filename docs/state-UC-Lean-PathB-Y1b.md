# state-UC-Lean-PathB-Y1b.md

**Cumulative state ledger for Path B sub-ticket Y1b** (`UC-Lean-PathB-Y1b-HigherRowBarResolution`, mg-ba0f).

Source: docs/state-UC-Lean-PathB-Y1.md (mg-17dc Y1 AMBER; named follow-on). Extends the Y1 row-0 deliverable to all rows.

---

## Lean-Session 29 — Y1b polecat (cat-mg-ba0f)

### Verdict

**GREEN** — higher-row `Fin.succAbove`-based bar-resolution faces, alternating-sum d² = 0 across all rows, and bicomplex H/V commutativity all proven. Strictly tighter than Y1's row-0-only deliverable.

### What landed

Added ~660 lines (sections §11–§18) to `lean/UnionClosed/UC10/BKBicomplexHC2.lean`.

#### §11 — `OpChain.face` for general `i : Fin (p+2)`

* **`OpChain.instSubsingleton`**: `TraceMor X Y` is a `Subsingleton` (both fields `subset` and `traceEq` are `Prop`-valued). Used to discharge dependent-type equalities between trace morphisms.
* **`OpChain.ext_of_obj`**: two `OpChain`s with equal `obj` fields are equal (via `Subsingleton.elim` on the `mor` field).
* **`OpChain.faceMor`**: the morphism field of `c.face i`, defined by case analysis on `i.val` vs `k.val`:
  * `i.val ≤ k.val`: use `c.mor k.succ` (no gap).
  * `i.val = k.val + 1`: compose `c.mor k.succ` ∘ `c.mor k.castSucc` (gap of 2).
  * `i.val > k.val + 1`: use `c.mor k.castSucc` (no gap).
* **`OpChain.face`**: the `i`-th face, using `Fin.succAbove` on objects and `faceMor` on morphisms.
* **`OpChain.face_face`** — the **simplicial identity at the OpChain level**:
  `(c.face j).face i = (c.face (j.succAbove i)).face (i.predAbove j)`.
  Proved via `ext_of_obj` + `Fin.succAbove_succAbove_succAbove_predAbove`.

#### §12 — `BKFaceI` and `BKHorizDiff_alt`

* **`OpChain.tailFaceMor c i`** — TraceMor `c.tail ⟶ (c.face i).tail`:
  * `i ≠ Fin.last`: identity TraceMor (since `(c.face i).tail = c.tail`).
  * `i = Fin.last`: `c.mor (Fin.last p)` (the tail trace).
* **`BKFaceIGen n p q i`** — per-Sigma-generator action: apply `restrictGen (tailFaceMor c i)` to the cell, then re-index via `c.face i`.
* **`BKFaceI n p q i`** — the `i`-th BK face: `linearCombination` of `BKFaceIGen`.
* **`BKHorizDiff_alt n p q`** — the full alternating sum `Σ_{i : Fin (p+2)} (-1)^i.val • BKFaceI n p q i`.

#### §13 — `restrictGen_compose`

* **`restrictGen_compose`** — composition of `restrictGen`s equals `restrictGen` of the composed `TraceMor`. Proved by case analysis on `x.dir ⊆ T.support` and `x.dir ⊆ U.support`, with cell `ext` (`base = x.base ∩ U.support, dir = x.dir`).
* **`restrictGen_subsingleton`** — two TraceMors of the same type give equal `restrictGen`s (by `Subsingleton.elim` on TraceMor).

#### §14 — BKFaceI simplicial identity

* **`BKFaceI_compose_apply`** — per-generator unfolding: composition `BKFaceI i ∘ BKFaceI j` on `⟨c, x⟩` equals `(restrictGen (combined trace) x).mapDomain (fun z => ⟨(c.face j).face i, z⟩)`.
* **`BKFaceI_compose_apply_general`** — abstracted form: for any `(OC, Trace)` with `OC = (c.face j).face i`, the composition equals the canonical form. Key step: `subst h_OC` unifies the dependent type of `Trace`, then `Subsingleton (TraceMor)` finishes.
* **`BKFaceI_simplicial`** — the simplicial identity at the morphism level:
  `BKFaceI n (p+1) q j ≫ BKFaceI n p q i = BKFaceI n (p+1) q (j.succAbove i) ≫ BKFaceI n p q (i.predAbove j)`.
  Proved by applying `BKFaceI_compose_apply_general` twice with the same canonical `(OC, Trace)`.

#### §15 — `BKHorizDiff_alt² = 0` via sum_involution

* **`simplicialSwap`** — pairing `(j, i) ↦ (j.succAbove i, i.predAbove j)`.
* **`simplicialSwap_involutive`** — `swap ∘ swap = id` via `Fin.succAbove_succAbove_predAbove` and `Fin.predAbove_predAbove_succAbove`.
* **`simplicialSwap_ne_self`** — fixed-point free: `j.succAbove i ≠ j` (j is the hole).
* **`simplicialSwap_sign`** — parity flips: `(-1)^(swap.1 + swap.2) = - (-1)^(j + i)`. Case analysis on `i.castSucc < j` vs `j ≤ i.castSucc`.
* **`BKHorizDiff_alt_squared`** — the d²=0 identity. Distributes the composition over the double sum, then applies `Finset.sum_involution` with `simplicialSwap`. Pair-cancellation uses `BKFaceI_simplicial` (compositions agree) + `simplicialSwap_sign` (signs flip).

#### §16 — H/V commutativity at all rows

* **`BKFaceI_comm_BKVertDiff`** — per-face H/V commute. Reduces (per Sigma generator) to the chain-map property `traceRestrict_comm` from Y1, lifted across the Sigma via `linearCombination_mapDomain` + `linearCombination_linear_comp`.

#### §17 — Full assembly `BKBicomplexHC₂_full`

* **`BKHorizD_alt`**, **`BKHorizD_alt_pos`**, **`BKHorizD_alt_neg`**, **`BKHorizD_alt_squared`** — index-extended differential plumbing.
* **`BKHV_commute_alt`** — H/V commute for the index-extended differential, reduces to `BKFaceI_comm_BKVertDiff` per face.
* **`BKBicomplexHC₂_full`** — `HomologicalComplex₂` assembly with the new horizontal differential.

#### §18 — Non-vacuous evaluation at higher row

* **`fullPowerset3_chain2`** — 2-chain on `fullPowerset3` with identity transitions.
* **`BKBicomplexHC₂_full_n3_nonzero_at_2_1`** — non-zero basis vector at `(p, q) = (2, 1)`.
* **`BKHorizDiff_alt_row1_nonzero`** — defining equation at row 1: `BKHorizDiff_alt n 1 q = Σ_{i : Fin 3} (-1)^i.val • BKFaceI n 1 q i`.

### Acceptance bar

| # | Bar | Status |
|---|---|---|
| 1 | `lake build` GREEN | ✅ (2002 jobs; baseline unchanged) |
| 2 | Non-vacuous evaluation at `n = 3` with non-zero cell at `(p, q) ≥ 1` for higher rows | ✅ `BKBicomplexHC₂_full_n3_nonzero_at_2_1` at `(2, 1)` |
| 3 | d² = 0 proven for each row | ✅ `BKHorizDiff_alt_squared` uniformly across all rows |
| 4 | Higher-row `Fin.succAbove` bar-resolution faces | ✅ `OpChain.face`, `BKFaceI`, `BKHorizDiff_alt`, all using `Fin.succAbove` |
| 5 | Simplicial identity proven | ✅ `OpChain.face_face` + `BKFaceI_simplicial` |
| 6 | Hard-constraint set §0 respected | ✅ no `sorry`, no axiom, no fake API, no defeq tricks, no `False.elim`, no `decide` shortcut |
| 7 | H/V commutativity at all rows | ✅ `BKFaceI_comm_BKVertDiff` + `BKHV_commute_alt` |

### Hard-constraint compliance

| # | Constraint | Status |
|---|---|---|
| D.1 | NOT factorial | ✅ no symmetric-group representation theory; no Specht modules. |
| D.2 | NOT functorial in the refinement sense | ✅ `OpChain.face` built directly via `Fin.succAbove`; no `Pos_n` functor. |
| D.3 | U1-dialect preserved | ✅ additive cohomology comparisons only. |
| D.4 | Math-first | ✅ aligns with UC10 §3.3 (BK bar resolution on `(C_n^∩)^op`). |
| | No sorry-axiom (Y1b forbidden) | ✅ `grep "^axiom\|sorry$" lean/UnionClosed/UC10/BKBicomplexHC2.lean` empty. |
| | No fake mathlib API | ✅ All API surface is mathlib v4.29.1. |
| | No defeq trick | ✅ all `rfl`-finishing steps are for definitional equalities (e.g., `k.succ.castSucc = k.castSucc.succ`). |
| | No `False.elim` on hypothesis tricks | ✅ none. |
| | Non-tautology preserved | ✅ d²=0 proof uses genuine alternating-sum cancellation via `Finset.sum_involution`; not a trivial `0 = 0`. |
| | Mathlib-folder authorization | ✅ only existing file `lean/UnionClosed/UC10/BKBicomplexHC2.lean` modified. |

### What unblocks

Y1b unblocks Y3 fully (chain Homotopy construction on the bottom-row column subcomplex of `BKBicomplexHC₂_full F` can now use the bar-resolution structure).

The new assembly `BKBicomplexHC₂_full` is used by Y2/Y3 (Walsh-equivariant lift + Homotopy bridge) — the genuine simplicial horizontal differential is now available across all rows.

### Files modified

* `lean/UnionClosed/UC10/BKBicomplexHC2.lean` — added ~660 lines (§11–§18), new imports `Mathlib.Data.Fintype.BigOperators` and `Mathlib.Algebra.BigOperators.Group.Finset.Basic`.
* `docs/state-UC-Lean-PathB-Y1b.md` (NEW, this file).
* `docs/state-UC10.md` — Lean-Session 29 entry (pending).

### Build status

* `lake build` GREEN: 2002 jobs (unchanged from baseline).
* One pre-existing `sorry` at `lean/UnionClosed/UC11/SSConvergence.lean:308` (the per-x AMBER from mg-b26c, NOT affected by Y1b).
* Zero new sorrys introduced by Y1b.
* Zero new axioms.
* Pre-existing `push_neg` deprecation warnings in `lean/UnionClosed/UC11/Minimality.lean` and `lean/UnionClosed/Frankl.lean` (not affected by Y1b).

### Cross-references

* Parent: mg-17dc Y1 (`UC-Lean-PathB-Y1-BKBicomplexHC2`, AMBER row-0; Y1b is the named follow-on closing the higher-row gap).
* Sibling: mg-f5b4 Y2 (`UC-Lean-PathB-Y2-WalshEquivariant`, concurrent on `BKWalshEquivariant.lean`).
* Scoping: mg-e1b8 `UC-Lean-PathB-BKBicomplex-scope` Phase A.2.
* `lean/UnionClosed/UC10/BousfieldKan.lean` — base `BKBicomplex`, `BKVertDiff`, `BKVertGen` (consumed).
* `lean/UnionClosed/UC10/CubicalDefect.lean` — `boundaryOnGen`, `singleFamilyBoundary`, `CubeCell.ext`.
* `lean/UnionClosed/UC10/IntClosedFam.lean` — `TraceMor`, `TraceMor.comp` (composition).
* mathlib `Fin.succAbove_succAbove_succAbove_predAbove`, `Fin.succAbove_succAbove_predAbove`, `Fin.predAbove_predAbove_succAbove` (load-bearing simplicial Fin identities).
* mathlib `Finset.sum_involution` (load-bearing pairing argument for d²=0).
