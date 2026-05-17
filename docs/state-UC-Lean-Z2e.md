# UC-Lean-Z2e-SpectralObjectRecord — state

**Status:** AMBER (Phase A.1 + Phase B.1 + Phase C landed; SpectralObject
record + IsFirstQuadrant instance deferred to Z2f).

**Lean-Session:** 42.

**Repo:** `/Users/daniel/research/union_closed`.

**File:** `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/Bicomplex.lean`
(extended from ~1868 lines to ~2299 lines, +431 lines of substantive content).

**Build:** `lake build` GREEN at 2043 jobs (baseline unchanged).

## Substantive deliverables landed

### Phase C — Z2d residual cleanup

* **`cutoffColumns_inclusion_le_refl`** — the chain inclusion at `p ≤ p`
  is the identity on `K.cutoffColumns p`. Load-bearing reflexivity for
  the EInt-index variant + the SpectralObject H-functor `map_id` axiom.

* **`cutoffColumnsEInt_le_refl_coe`** — reflexivity at integer EInt
  indices `(p : EInt) ≤ (p : EInt)`, completing the EInt reflexivity
  coverage (alongside the existing `_refl_bot` and `_refl_top`).

* **`cutoffColumnsEInt_le_trans`** — full 9-case general EInt
  transitivity. Case analysis via `induction _ using WithBotTop.rec`
  three times. Impossible orderings (where `i ≤ j` or `j ≤ k` is
  contradicted) discharged via `simp at h`. The four substantive
  cases reduce to either identity composition, zero composition (when
  an endpoint is `⊤`), the `cutoffColumns_inclusion_le_inclusion`
  factorisation (when `i = ⊥` and the remaining indices are integers),
  or the existing `cutoffColumnsEInt_le_trans_coe_coe_coe` for the
  load-bearing integer case.

### Phase A.1 — Bicomplex SES `ShortExact` upgrade

* **`cutoffColumns_succ_singleColumnAt_shortExact (p : ℤ)`** — the Z2b
  GE-side `ShortComplex` packaging is upgraded to `ShortExact`. The proof
  applies `HomologicalComplex.shortExact_of_degreewise_shortExact` twice
  (once at the column shape `ComplexShape.up ℤ`, once at the row shape
  `c₂`) to reduce to cell-level SE in `C`, then constructs explicit
  cell-level `Splitting`s case-by-case on `p'` vs `p`:
    - `p' < p`: all three cells `IsZero` → trivial Splitting with `r = 0`,
      `s = 0`.
    - `p' = p`: `X₁` `IsZero`, `g` is the cell iso composition (via
      `cutoffColumns_to_singleColumnAt_f_at_self`) → Splitting with `r = 0`,
      `s = inv g`.
    - `p' > p`: `X₃` `IsZero`, `f` is the cell iso composition (via
      `cutoffColumns_succ_f_of_le`) → Splitting with `r = inv f`, `s = 0`.

* **`singleColumnAt_to_cutoffColumnsLE_shortExact (p : ℤ)`** — the Z2c
  LE-side `ShortComplex` packaging is upgraded to `ShortExact`. Dual to
  the GE-side, with case analysis on `p'` vs `p + 1`:
    - `p' ≤ p`: `X₁` `IsZero`, `g` is the LE-cell iso composition.
    - `p' = p + 1`: `X₃` `IsZero`, `f` is the LE-cell iso composition
      (via `singleColumnAt_to_cutoffColumnsLE_f_at_self`).
    - `p' > p + 1`: all three cells `IsZero`.

  Cell-level isos are propagated from the bicomplex morphism level to
  the cell level via `Functor.map_isIso (HomologicalComplex.eval _ _ q)`,
  routing through the substantive Z2b/Z2c filtration cell formulas.

* **Helper `Splitting`s** — three reusable private constructors
  (`splittingOfAllIsZero`, `splittingOfIsZeroX₁IsIsoG`,
  `splittingOfIsZeroX₃IsIsoF`) for the three cell-level cases.

### Phase B.1 — `IsFirstQuadrantRows` companion typeclass

* **`IsFirstQuadrantRows`** — the row-side companion to
  `IsFirstQuadrantBicomplex`, capturing `(K.X p).X q = 0` for `q < 0`.
  Single field `isZero_X_X_of_neg_row`.

* **`instance : trivialColumnZeroFirstQuadrant.IsFirstQuadrantRows`** —
  the concrete test bicomplex satisfies the row-side typeclass: its only
  nonzero column is `column 0` which is the `single` chain complex
  supported at row `0`, so all cells at strictly negative row indices
  vanish via `HomologicalComplex.isZero_single_obj_X`.

* Two non-vacuous evaluations at `(0, -2)` and `(3, -1)` on the
  trivialColumnZeroFirstQuadrant test bicomplex.

## Deferred to Z2f (named follow-on)

The final Z2 deliverables — the `SpectralObject (HomologicalComplex C c₁₂) EInt`
**record construction** packaging the H-data, δ-data via the snake lemma,
the three exactness conditions via the LES of cohomology, and the
`IsFirstQuadrant` instance — are sized beyond a single focused session
per the empirical 250k-per-deliverable ceiling.

### Z2f-A scope — SpectralObject record assembly

* H-functor `H n : ComposableArrows EInt 1 ⥤ HomologicalComplex C c₁₂`
  on `mk₁ (homOfLE h)` returns `[totalise + shift n] of cokernel(K.cutoffColumnsEInt_le h)`.
* Functoriality from cokernel universal property + Z2d transitivity
  `cutoffColumnsEInt_le_trans` + Z2e reflexivity
  `cutoffColumnsEInt_le_refl_coe`.
* δ-data via `ShortExact.δ` from `Mathlib.Algebra.Homology.HomologySequence`,
  applied to the triple-filtration s.e.s. constructed from Z2e's
  `cutoffColumns_succ_singleColumnAt_shortExact` and
  `singleColumnAt_to_cutoffColumnsLE_shortExact` upgraded via
  `ShortExact` propagation through totalisation.
* Three exactness conditions via `ShortExact.homology_exact₁/₂/₃`.

### Z2f-B scope — `IsFirstQuadrant` instance

* `isZero₁`: via Z2d `cutoffColumnsEInt_isZero_X_of_neg_col` + totalisation
  IsZero preservation.
* `isZero₂`: via Z2e `IsFirstQuadrantRows.isZero_X_X_of_neg_row` + shift
  + totalisation IsZero preservation.

### Z2f budget

~250-300k tokens per the empirically validated ceiling. After Z2f GREEN
the Z2 scope is fully closed and Z3 (`BicomplexConvergence`) dispatches.

## Acceptance bars

| # | Bar | Status |
|---|-----|--------|
| 1 | `lake build` GREEN (2043 jobs) | ✅ |
| 2 | Non-vacuous SpectralObject H + δ eval + IsFirstQuadrant verifies | ❌ deferred Z2f |
| 3 | Mathlib-PR-clean naming + Joël-Riou-style docstrings | ✅ |
| 4 | Zero new sorrys | ✅ |
| 5 | Zero new axioms | ✅ |
| 6 | No fake mathlib API | ✅ |
| 7 | No defeq bypass on snake-on-triple-filtration | ✅ (not constructed) |
| 8 | No `False.elim` | ✅ |
| 9 | Type-correct | ✅ |
| 10 | Mathlib-folder scope respected | ✅ (only Bicomplex.lean touched) |
| 11 | Feeds-into-Z3 readiness via Z1's `Abelian.SpectralObject.spectralSequence` | ❌ deferred Z2f |
| 12 | No L+X+Y dependencies | ✅ |

## Sub-split history

This is the **sixth** Z2 sub-split (Z2 → Z2a → Z2b → Z2c → Z2d → Z2e →
Z2f). Per ticket `mg-b823` "After Z2e AMBER" guidance:

> Sub-split into Z2f per pattern. Strictly-tighter.

And per the structural-review caveat:

> 5+ sub-splits without closing Z2 would warrant a structural review.

Z2e landed three substantive sub-deliverables (Phase A.1 ShortExact
upgrade + Phase B.1 IsFirstQuadrantRows + Phase C Z2d residuals), and
Z2f is **strictly tighter** in scope: only the SpectralObject record
assembly + IsFirstQuadrant instance remain. The remaining work consumes
the full Z2a-Z2e primitive stack and is the natural single-session
finishing piece for the Z2 arc.

## Forward operational step

File **Z2f** (UC-Lean-Z2f-SpectralObjectRecordAssembly) as next sequential
sub-ticket after Z2e merge. Z2f budget ~250-300k tokens. Z2f GREEN closes
Z2 and unblocks Z3 (BicomplexConvergence, mg-50b7).
