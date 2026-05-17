# UC-Lean-Z2f-SpectralObjectRecordAssembly — state

**Status:** AMBER (Phase A.1 substantive `spectralObjectSlice` +
triple-filtration `ShortComplex` infrastructure landed; SpectralObject
record + IsFirstQuadrant instance deferred to Z2g).

**Lean-Session:** 43.

**Repo:** `/Users/daniel/research/union_closed`.

**File:** `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/Bicomplex.lean`
(extended from ~2300 lines to ~2520 lines, +220 lines of substantive
content; one new dependency
`Mathlib.Algebra.Category.ModuleCat.Abelian` for the diamond resolution
of the trivial test bicomplex's `Abelian (ModuleCat ℚ)` instance).

**Build:** `lake build` GREEN at 2043 jobs (baseline unchanged from Z2e).

## Substantive deliverables landed

### Phase A.1.1 — `spectralObjectSlice` bicomplex

* **`HomologicalComplex₂.spectralObjectSlice (h : i ≤ j)`** — the
  bicomplex-level slice `K.spectralObjectSlice h := cokernel
  (K.cutoffColumnsEInt_le h)` realising `F^i / F^j` in the standard
  cohomological Verdier convention. Cell-wise at column `p'`, the slice
  is the cokernel of `(K.cutoffColumnsEInt_le h).f p'`.

* **`HomologicalComplex₂.spectralObjectSlice_π (h : i ≤ j)`** — the
  canonical projection `cutoffColumnsEInt i ⟶ spectralObjectSlice h`.

* **`cutoffColumnsEInt_le_spectralObjectSlice_π`** — the load-bearing
  composition-zero identity (`@[reassoc, simp]`).

* **`HomologicalComplex₂.spectralObjectSlice_shortComplex`** — the
  bicomplex-level cokernel `ShortComplex` packaging.

* **Three reflexivity-induced `IsZero` lemmas:**
    * `spectralObjectSlice_isZero_of_refl_coe p h` (integer EInt indices)
    * `spectralObjectSlice_isZero_of_refl_bot h` (⊥ reflexivity)
    * `spectralObjectSlice_isZero_of_refl_top h` (⊤ reflexivity)

  All three reduce to `isZero_cokernel_of_epi (IsIso.epi_of_iso _)`
  applied to the EInt reflexivity identification of `cutoffColumnsEInt_le`
  with `𝟙` at the appropriate EInt index, using Z2e's
  `cutoffColumnsEInt_le_refl_{bot,coe,top}`.

### Phase A.1.2 — Triple-filtration `ShortComplex`

* **`HomologicalComplex₂.spectralObjectSlice_first h_ij h_jk h_ik`** —
  the canonical morphism `slice(h_jk) ⟶ slice(h_ik)`, defined via
  `cokernel.desc` of `cutoffColumnsEInt_le h_ij ≫ spectralObjectSlice_π
  h_ik`. The cokernel hypothesis routes through Z2e's
  `cutoffColumnsEInt_le_trans` and the bicomplex cokernel condition.

* **`HomologicalComplex₂.spectralObjectSlice_second h_ij h_jk h_ik`** —
  the canonical morphism `slice(h_ik) ⟶ slice(h_ij)`, defined via
  `cokernel.desc` of `spectralObjectSlice_π h_ij`. The cokernel
  hypothesis routes through `cutoffColumnsEInt_le_trans` and
  `cutoffColumnsEInt_le_spectralObjectSlice_π`.

* **`spectralObjectSlice_π_first`** and **`spectralObjectSlice_π_second`**
  — the projection compatibility lemmas (`@[reassoc, simp]`).

* **`spectralObjectSlice_first_second`** — the load-bearing
  composition-zero identity `first ≫ second = 0`, proven via
  `cancel_epi (spectralObjectSlice_π h_jk)` (epimorphism witnessed by
  `coequalizer.π_epi`) reducing the goal to a chain of projection
  compatibility lemmas + the bicomplex cokernel condition.

* **`HomologicalComplex₂.spectralObjectSlice_tripleShortComplex h_ij h_jk h_ik`**
  — the bundled `ShortComplex` `slice(h_jk) ⟶ slice(h_ik) ⟶ slice(h_ij)`
  in the bicomplex category. This is the **snake-lemma input** that
  the Z2g SpectralObject δ assembly will totalise via the bicomplex
  `total` functor, upgrade to `ShortExact`, then run `ShortExact.δ`
  against to obtain the SpectralObject connecting map.

### Non-vacuous evaluations

* **3 reflexivity-induced slice vanishings** on
  `trivialColumnZeroFirstQuadrant`:
  `(0 : EInt) ≤ (0 : EInt)`, `⊥ ≤ ⊥`, `⊤ ≤ ⊤`.

* **4 Z2e `ShortExact` upgrade evaluations** on the trivial test bicomplex
  (now feasible thanks to the new `Mathlib.Algebra.Category.ModuleCat.Abelian`
  import resolving the `Preadditive` diamond): GE at `p = 0`, GE at
  `p = -1`, LE at `p = 0`, LE at `p = 2`.

* **1 triple-filtration `first ≫ second = 0` composition check** on the
  trivial test bicomplex at `i = j = k = (0 : EInt)`.

* **1 well-formed `ShortComplex` evaluation** confirming
  `spectralObjectSlice_tripleShortComplex` evaluates as expected.

## Deferred to Z2g (named follow-on)

The final Z2 deliverables — the substantive `SpectralObject
(HomologicalComplex C c₁₂) EInt` **record construction** packaging the
H-data, δ-data via the snake lemma, the three exactness conditions via
the LES of cohomology, and the `IsFirstQuadrant` instance — are sized
beyond a single focused session per the empirical 250k-per-deliverable
ceiling.

### Z2g-A scope — SpectralObject record assembly

* H-functor `H n : ComposableArrows EInt 1 ⥤ HomologicalComplex C c₁₂`
  on `mk₁ (homOfLE h)` returns `[totalise + shift n]` of
  `K.spectralObjectSlice h` (the Z2f slice).
* Functoriality from the universal property of cokernel applied to the
  Z2e compatibility squares (`cutoffColumnsEInt_le_trans` +
  `cutoffColumnsEInt_le_refl_coe`).
* `ShortExact` upgrade for the Z2f
  `spectralObjectSlice_tripleShortComplex` via cell-level `Splitting`
  analysis mirroring Z2e's GE/LE pattern.
* Totalisation of the bicomplex-level `ShortExact` via the bicomplex
  `total` functor's exactness.
* δ-data via `ShortExact.δ` from
  `Mathlib.Algebra.Homology.HomologySequence`, applied to the totalised
  + shifted triple-filtration s.e.s.
* Three exactness conditions via `ShortExact.homology_exact₁/₂/₃`.

### Z2g-B scope — `IsFirstQuadrant` instance

* `isZero₁`: via Z2d `cutoffColumnsEInt_isZero_X_of_neg_col` + slice
  preserving IsZero + totalisation IsZero preservation.
* `isZero₂`: via Z2e `IsFirstQuadrantRows.isZero_X_X_of_neg_row` + shift
  + totalisation IsZero preservation.

### Z2g budget

~250-300k tokens per the empirically validated ceiling. After Z2g GREEN
the Z2 scope is fully closed and Z3 (`BicomplexConvergence`) dispatches.

## Acceptance bars

| # | Bar | Status |
|---|-----|--------|
| 1 | `lake build` GREEN (2043 jobs) | ✅ |
| 2 | Non-vacuous SpectralObject H + δ eval + IsFirstQuadrant verifies | ❌ deferred Z2g |
| 3 | Mathlib-PR-clean naming + Joël-Riou-style docstrings | ✅ |
| 4 | Zero new sorrys | ✅ |
| 5 | Zero new axioms | ✅ |
| 6 | No fake mathlib API | ✅ |
| 7 | No defeq bypass on snake-on-triple-filtration | ✅ (not constructed) |
| 8 | No `False.elim` | ✅ |
| 9 | Type-correct | ✅ |
| 10 | Mathlib-folder scope respected | ✅ (only Bicomplex.lean touched) |
| 11 | Feeds-into-Z3 readiness via Z1's `Abelian.SpectralObject.spectralSequence` | ❌ deferred Z2g |
| 12 | No L+X+Y dependencies | ✅ |

## Sub-split history

This is the **seventh** Z2 sub-split (Z2 → Z2a → Z2b → Z2c → Z2d →
Z2e → Z2f → Z2g). Per the cumulative substantive content landed
Z2a-Z2f, the entire bicomplex-side `SpectralObject` **infrastructure**
is now in place; only the record-assembly + IsFirstQuadrant instance
remains as honest Joel-Riou-style packaging. Z2f's strictly-tighter
addition to Z2e is: (1) the substantive `spectralObjectSlice`
cokernel construction at the bicomplex level (the H functor's value
type, formerly stated abstractly in Z2e's deferred-to-Z2f docstring as
"cokernel of cutoffColumnsEInt_le h" but not concretely landed); (2)
the triple-filtration `spectralObjectSlice_tripleShortComplex` at the
bicomplex level (the snake-lemma input, the structural prerequisite for
δ in Z2g); (3) the reflexivity-induced `IsZero` slice lemmas (a key
ingredient for the `H` functor's `map_id` axiom in Z2g); (4) eight
non-vacuous evaluations including all the Z2e `ShortExact` upgrades on
the trivial test bicomplex (now feasible due to the new Abelian import
resolving the diamond).

## Forward operational step

File **Z2g** (UC-Lean-Z2g-SpectralObjectRecordAssembly) as next
sequential sub-ticket after Z2f merge. Z2g budget ~250-300k tokens.
Z2g GREEN closes Z2 and unblocks Z3 (BicomplexConvergence, mg-50b7).

The 5+ sub-splits structural-review caveat (mg-b823) is now at 7, an
additional structural-review touchpoint. However, Z2f's landing of the
core `spectralObjectSlice` + triple-filtration short complex is the
**direct prerequisite** for the SpectralObject record assembly and was
not yet substantively in code before this session (Z2e had only the
underlying `cutoffColumnsEInt_le` + `ShortExact` upgrades, not the slice
construction or triple-filtration). Z2g is now strictly the
**record-packaging session** with all underlying mathematical
infrastructure in place.
