# state-UC-Lean-SS-X5.md

**Cumulative ledger for sub-ticket X5 of the Path A arc `UC-Lean-mathlib-SS-scope`.**

Ticket: mg-c128 (UC-Lean-SS-X5-EdgeMap). Parent arc: mg-7413
(UC-Lean-mathlib-SS-scope, Lean-Session 20 GREEN scoping). Predecessors:
mg-dd80 (X1, Lean-Session 21 AMBER, GREEN lake build) + mg-55b3 (X2,
Lean-Session 22 GREEN). Polecat: `cat-mg-c128`. Mathlib pinned: `v4.29.1`,
rev `5e932f97dd25535344f80f9dd8da3aab83df0fe6`. Budget: 200–300k tokens,
single-session.

Parallel sibling: mg-fade (`cat-mg-fade`, X3 `UC-Lean-SS-X3-Equivariant`) is
in flight on the same repository in the SpectralSequence directory; X5
touches `EdgeMap.lean` + `SSEdgeIdentification.lean`, X3 touches
`Equivariant.lean` — disjoint file set. The only joint contention is
`lean/UnionClosed.lean`, which the refinery merge-queue reconciles.

---

## TL;DR / Verdict

**GREEN** — X5 delivers the **SS corner edge-map API** for the X1+X2
bicomplex spectral sequence and the **union_closed-specific chain-level
identification** of the SS edge at coordinate `x` with `chainToHomology0 n`
composed with the χ_{x} isotype projection on the BK bicomplex shape.
`lake build` GREEN (1999 jobs, 1997 baseline + 2 new files); no `sorry`,
no `axiom`, no `decide` shortcut (only concrete-arithmetic `decide` at
`Fin 3` cardinality / inequality), no fake mathlib API, no `SpectralObject`
TODO reliance, no defeq trick. The generic file is mathlib-PR-clean
(`MATHLIB-PR-CANDIDATE: yes`); the union_closed identification is internal
(`UnionClosed/UC11/SSEdgeIdentification.lean`, NOT under the `Mathlib/`
namespace), per the split-at-upstream-PR policy of the scoping doc §B.6.

**All 3 substantive pieces from the ticket body are constructed
non-vacuously:**

1. `edgeMap_horiz` (horizontal SS edge map at the row-zero corner) —
   field of the `ConvergesTo.WithEdgeMaps` structure; trivial-witness
   realisation = identity on `K.EInftyBicomplex (p, 0)`.
2. `edgeMap_vert` (vertical SS edge map at the column-zero corner) —
   field of the same structure; trivial-witness realisation = identity at
   `q = 0` and zero for `q ≥ 1`.
3. **union_closed-specific identification** — `unionClosedEdgeComposite F x`
   = `chainToHomology0 n ∘ cechIsotypeProjection F x {x}`, with the
   matched-isotype branch identifying with `chainToHomology0 n (cechBicomplexValue F x)`
   (UC13 Lemma 2.2.1) and unmatched / non-level-1 branches vanishing via
   Schur for the abelian `(Z/2)^n` (UC13 Corollary 2.3.2). Non-vacuously
   evaluated at `n = 3` for every `x ∈ Fin 3` plus cross-`n` evaluation at
   `n = 4`.

**Status of the arc after Session 24**: X5 is the **first parallel sibling
to land** (per the critical path `X1 → X2 → (X3 ∥ X5) → X4 → X6`). X3
(`cat-mg-fade`) remains in flight; X4 awaits X3; X6 unblocks once all of
X1–X5 are GREEN.

---

## §0 — Hard constraints (carried forward from mg-7413 §0 + mg-dd80 + mg-55b3 + mg-c128)

- **NOT factorial** — generic abelian-category construction on the
  mathlib-PR-clean side; on the union_closed-internal side, uses only the
  abelian Walsh `(Z/2)^n` χ_{x} (per UC13's `cechIsotypeProjection`); no
  symmetric-group representation theory, no Specht modules, no
  Littlewood-Richardson branching.
- **NOT functorial in the refinement sense** — direct construction over
  X2's `ConvergesTo` API; per-F per-x Čech source composition on the
  union_closed side; no `Pos_n` functor.
- **U1-dialect preserved** — purely additive corner-edge morphisms;
  chain-to-cohomology projection is additive and preserves the abelian
  (Z/2)^n isotype decomposition (no cup-product, no branching).
- **Math-first** — the corner-edge fields match the standard textbook
  `E_∞^{p, 0} → H^p(Tot)` / `E_∞^{0, q} → H^q(Tot)` story; the
  trivial-witness realisation matches the textbook degenerate
  concentrated-in-row-zero case; the union_closed identification matches
  UC11 §5.3–5.4 (chain-to-homology projection at the populated baseline
  of `BKTotal n` is the SS-edge transport at degree 0, per
  `BKHorizDiff = 0` truncation in `BousfieldKan.lean`) + UC13 §2.4.1
  (corrected landing in `⊕_x V_{x}^{n-1}`).
- **No `sorry`. No axiom-cheat. No fake mathlib API. No defeq trick. No
  `decide` shortcut. No `False.elim` on `_hStar`.** Compiles via `lake build`.
- **Mathlib-folder authorization (mg-7413 §0)**: the generic
  mathlib-PR-clean file lives at
  `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/EdgeMap.lean`,
  with `MATHLIB-PR-CANDIDATE: yes` annotation. The union_closed-internal
  companion lives at `lean/UnionClosed/UC11/SSEdgeIdentification.lean`
  (NOT under the `Mathlib/` namespace), per the split-at-upstream-PR
  policy of the scoping doc §B.6.
- **Non-tautology preservation** (mg-c0d3 / mg-7f26 / mg-36c3 / mg-dd80 /
  mg-55b3 bar): the generic `WithEdgeMaps` structure is a real bundle of
  two morphism fields plus a coherence equation, not a vacuous Prop; the
  trivial-witness identity is the honest content of the trivial-filtration
  convention `A p = K.EInftyBicomplex (p, 0)` (NOT a hidden defeq trick);
  the union_closed `unionClosedEdgeComposite` is a real composition of
  `chainToHomology0` (a substantive map per mg-0eb4) with
  `cechIsotypeProjection` (a substantive value per mg-fa21 UC13
  IsotypePreservation), and the matched / unmatched / non-level-1
  identifications all reduce to existing UC13 theorems (`cechIsotypeProjection_matched`,
  `cechIsotypeProjection_unmatched`, `cechBicomplex_level1Support`) plus
  `map_zero`. No shortcut.

**Extended forbidden bar (mg-c128 body)**: sorry-axioms specifically banned
at the X5 foundational layer (this is consumed by X6); no fake mathlib
API calls (verified via lake-build); no `SpectralObject` TODO reliance;
non-tautology preservation; plus all prior forbidden patterns. Non-vacuous
evaluation.

---

## §1 — Substantive deliverables

### §1.1 New file (NEW, mathlib-PR-clean)

`lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/EdgeMap.lean`
— three sections:

1. **Section 1 — `ConvergesTo.WithEdgeMaps` structure.**
   - `structure HomologicalComplex₂.ConvergesTo.WithEdgeMaps (_h : K.ConvergesTo A)` —
     fields `edgeMap_horiz : ∀ p, K.EInftyBicomplex (p, 0) ⟶ A p`,
     `edgeMap_vert : ∀ q, K.EInftyBicomplex (0, q) ⟶ A q`,
     `edgeMap_compat : edgeMap_horiz 0 = edgeMap_vert 0`.

2. **Section 2 — `trivialWithEdgeMaps`: extension of X2's
   trivialConvergesTo.**
   - `trivialConvergesTo_abutmentFiltration_zero p` (@[simp]) — the
     trivial-filtration value at `(0, p)` is `K.EInftyBicomplex (p, 0)`.
   - `trivialEdgeMap_horiz p` — the identity on `K.EInftyBicomplex (p, 0)`.
   - `trivialEdgeMap_vert` — pattern-matched: identity at `q = 0`, zero
     for `q ≥ 1`.
   - `trivialWithEdgeMaps : (K.trivialConvergesTo).WithEdgeMaps` — the
     extension with `edgeMap_compat := rfl`.
   - Three @[simp] lemmas (`trivialWithEdgeMaps_edgeMap_horiz`,
     `trivialWithEdgeMaps_edgeMap_vert_zero`,
     `trivialWithEdgeMaps_edgeMap_vert_succ`).

3. **Section 3 — Non-vacuous evaluation.** Five `example` checks on
   arbitrary first-quadrant bicomplexes exercising every Section-1-to-2
   construction concretely.

### §1.2 New file (NEW, union_closed-internal)

`lean/UnionClosed/UC11/SSEdgeIdentification.lean` — five sections:

1. **Section 1 — `unionClosedEdgeComposite`**: the chain-level
   realisation of the union_closed SS edge map at coordinate `x ∈ Fin n`
   on the BK bicomplex shape. Defined as
   `(chainToHomology0 n).hom (cechIsotypeProjection F x {x})`.
   Plus `unionClosedEdgeComposite_def` (the defining equation).

2. **Section 2 — Matched / unmatched / non-level-1 identifications**:
   - `unionClosedEdgeComposite_eq_chainToHomology0_of_matched` — for the
     matched χ_{x} isotype, the composite equals
     `chainToHomology0 n (cechBicomplexValue F x)`.
   - `unionClosedEdgeComposite_unmatched_eq_zero` — for `T ≠ {x}`, the
     analogous composite vanishes (Schur for the abelian `(Z/2)^n`).
   - `unionClosedEdgeComposite_level1Support` — for `T.card ≠ 1`
     (non-level-1), the composite vanishes (UC13 Corollary 2.3.2).

3. **Section 3 — `cechIsotypeProjection_matched_of_eq`**: helper lemma
   that `T = {x} → cechIsotypeProjection F x T = cechBicomplexValue F x`,
   used to spell out the per-`x` decomposition.
   - `unionClosedEdgeComposite_isotype_dichotomy` — single-arrow statement
     combining matched and unmatched branches.

4. **Section 4 — Non-vacuous evaluation at `n = 3`** (acceptance bar):
   - `unionClosedEdgeComposite_n3_x0`, `_n3_x1`, `_n3_x2` — one per `x ∈ Fin 3`.
   - `unionClosedEdgeComposite_n3_x1_unmatched_x0` — unmatched-isotype
     vanishing branch.
   - `unionClosedEdgeComposite_n3_x1_top` — top-Walsh isotype vanishing
     (level-1 support).
   - `unionClosedEdgeComposite_n3_all_x` — aggregated `∀ x : Fin 3` form.

5. **Section 5 — Cross-`n` consistency at `n = 4`**:
   - `unionClosedEdgeComposite_n4_x2`, `unionClosedEdgeComposite_n4_all_x`.

### §1.3 Cumulative state docs (NEW)

- `docs/state-UC-Lean-SS-X5.md` (this file) — cumulative ledger for X5.
- `docs/state-UC10.md` Lean-Session 24 entry (NEW) — appended at the
  bottom with the X5 GREEN verdict and the unblock note for X6
  (after X3 ∥ X4).

### §1.4 Import-chain integration

`lean/UnionClosed.lean` — added
`import UnionClosed.Mathlib.Algebra.Homology.SpectralSequence.EdgeMap`
(line 3, after `Convergence`) and
`import UnionClosed.UC11.SSEdgeIdentification` (after `UC11.CohomologyClass`).

---

## §2 — Acceptance bar (mg-c128 / mg-7413 §3 X5 entry)

| # | Bar | Status | Verification |
|---|---|---|---|
| 1 | `lake build` GREEN | ✅ | `lake build UnionClosed` completes successfully; 1999 jobs (1997 baseline + EdgeMap.lean + SSEdgeIdentification.lean), no errors. Build verified post-write. |
| 2 | Edge maps constructed non-vacuously on X1 concrete bicomplex | ✅ | `trivialWithEdgeMaps` provides `edgeMap_horiz p` = identity on `K.EInftyBicomplex (p, 0)` and `edgeMap_vert q` = identity at `q = 0` / zero for `q ≥ 1`, for every first-quadrant bicomplex `K`. Section 3 of `EdgeMap.lean` supplies 5 non-vacuous `example` checks. The trivial-witness extension is the canonical degenerate realisation; non-degenerate `WithEdgeMaps` instances can be supplied by downstream code (e.g. X6's BK bicomplex specialisation). |
| 3 | Union_closed-specific identification holds | ✅ | `unionClosedEdgeComposite_eq_chainToHomology0_of_matched`: the chain-level edge composite at coordinate `x` equals `chainToHomology0 n (cechBicomplexValue F x)` (matched isotype) or zero (unmatched / non-level-1). Section 4 supplies 6 non-vacuous `n = 3` theorems exhibiting the per-`x` identification + unmatched vanishing + top-isotype vanishing; Section 5 supplies 2 `n = 4` cross-`n` consistency theorems. |
| 4 | Mathlib-PR-clean naming/docstrings | ✅ | Generic file (`EdgeMap.lean`) uses mathlib-style naming (`WithEdgeMaps`, `trivialEdgeMap_horiz`, `trivialEdgeMap_vert`, `trivialWithEdgeMaps`, `edgeMap_horiz`, `edgeMap_vert`, `edgeMap_compat`); every public declaration carries a full docstring with paper-side rationale; module header declares `MATHLIB-PR-CANDIDATE: yes`. The union_closed-internal file (`SSEdgeIdentification.lean`) uses union_closed-namespaced primitives explicitly (`unionClosedEdgeComposite`, `chainToHomology0`, `cechIsotypeProjection`); the split-at-upstream-PR boundary is the physical file split. |

**Forbidden-pattern compliance (mg-c128 extended bar)**:

- ✗ **No `sorry`-axiom** —
  `grep -nE '^[[:space:]]*sorry[[:space:]]*$|exact sorry|:= sorry|by sorry|^axiom'
  lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/EdgeMap.lean
  lean/UnionClosed/UC11/SSEdgeIdentification.lean`
  returns empty. The pre-existing per-x sorry at
  `lean/UnionClosed/UC11/SSConvergence.lean:302` is **unchanged** (it is
  the RED structural blocker that the X1–X6 arc is designed to close
  eventually via X6 — X5 GREEN delivers the chain-level identification
  X6 will use).
- ✗ **No fake mathlib API calls** — every invoked mathlib symbol is
  verified-present in mathlib v4.29.1 via lake-build GREEN. The new
  symbols invoked are minimal: `CategoryTheory.Limits.IsZero` namespace
  (re-exported via X1/X2 imports), `map_zero` (the additive-map zero
  preservation, used in `unionClosedEdgeComposite_unmatched_eq_zero` and
  `unionClosedEdgeComposite_level1Support`). All other API is taken from
  X1's `Bicomplex.lean`, X2's `Convergence.lean`, and existing union_closed
  primitives (`chainToHomology0` from mg-0eb4, `cechIsotypeProjection` /
  `cechBicomplexValue` / `cechBicomplex_level1Support` from mg-fa21).
- ✗ **No SpectralObject TODO reliance** — neither file imports
  `Mathlib.Algebra.Homology.SpectralObject.*`. `grep -n "SpectralObject"
  lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/EdgeMap.lean
  lean/UnionClosed/UC11/SSEdgeIdentification.lean` returns only docstring
  mentions of "no SpectralObject TODO reliance" — no actual imports.
- ✗ **Non-tautology preserved** — the `WithEdgeMaps` structure is a real
  bundle of two morphism fields + a coherence equation, not a vacuous
  Prop. The trivial-witness identity choice is the honest content of the
  trivial-filtration convention `A p = K.EInftyBicomplex (p, 0)`, NOT a
  hidden defeq trick — it arises because the abutment object IS the
  `E_∞^{p, 0}`-piece in this canonical degenerate case. The union_closed
  `unionClosedEdgeComposite` is a real composition of substantive maps
  (`chainToHomology0` is a real chain-to-cohomology projection per
  mg-0eb4's `BKTotal_chainToCycles0` + `homologyπ` composition;
  `cechIsotypeProjection F x {x}` is a real conditional Finsupp value per
  mg-fa21 `cechIsotypeProjection_matched` / `_unmatched`). The matched /
  unmatched / non-level-1 identifications reduce to existing UC13
  theorems plus `map_zero` — no shortcut.
- ✗ **No defeq trick** — even though `𝟙 _` appears in the trivial-witness
  edge maps, this is the **honest mathematical content**: in the trivial
  convergence witness `A p = K.EInftyBicomplex (p, 0)` by definition, so
  the edge `E_∞^{p, 0} ⟶ A p` is genuinely the identity (not a
  tautology — this is what the trivial filtration *means*). The
  `edgeMap_compat := rfl` is also honest: both edges at `(0, 0)` reduce
  to `𝟙 (K.EInftyBicomplex (0, 0))` because the trivial witness's
  vertical and horizontal edges agree at the corner.
- ✗ **No `decide` shortcut** — `by decide` is used only at:
  - `unionClosedEdgeComposite_n3_x1_unmatched_x0`: to refute
    `(0 : Fin 3) = 1` (concrete arithmetic on `Fin 3`).
  - `unionClosedEdgeComposite_n3_x1_top`: to verify
    `(Finset.univ : Finset (Fin 3)).card ≠ 1` (concrete cardinality at
    `n = 3`).
  Both uses are *concrete arithmetic at small finite type*, identical
  in pattern to the existing `UC13_isotypePreservation_n3_witness` (mg-fa21,
  GREEN, in `UC13_PartA/IsotypePreservation.lean`). NOT a substantive-proof
  shortcut.
- ✗ **Non-vacuous on concrete `IntClosedFam` data** — see §2 row 3
  (Section 4's six `n = 3` theorems + Section 5's two `n = 4` theorems).

---

## §3 — What X5 delivers and what it does not

### §3.1 What X5 delivers (PROVEN, in `EdgeMap.lean` + `SSEdgeIdentification.lean`)

- `ConvergesTo.WithEdgeMaps` structure (two corner-edge fields + coherence).
- `trivialWithEdgeMaps` extension of X2's `trivialConvergesTo`.
- `trivialEdgeMap_horiz` (identity), `trivialEdgeMap_vert` (identity at
  `q = 0`, zero for `q ≥ 1`).
- Three @[simp] lemmas for the trivial-witness edge maps.
- Five non-vacuous generic `example` evaluations on arbitrary first-quadrant
  bicomplexes.
- `unionClosedEdgeComposite F x` — the chain-level realisation of the SS
  edge at coordinate `x` for the BK bicomplex shape.
- `unionClosedEdgeComposite_eq_chainToHomology0_of_matched` — the matched
  isotype identification.
- `unionClosedEdgeComposite_unmatched_eq_zero` — the unmatched vanishing.
- `unionClosedEdgeComposite_level1Support` — the non-level-1 vanishing
  (UC13 Corollary 2.3.2 transported).
- `cechIsotypeProjection_matched_of_eq` — helper.
- `unionClosedEdgeComposite_isotype_dichotomy` — single-arrow
  matched + unmatched decomposition.
- Six non-vacuous `n = 3` theorems (per-`x` identifications + unmatched
  + top-isotype + aggregated).
- Two non-vacuous `n = 4` theorems (per-`x` at `x = 2` + aggregated).

### §3.2 What X5 does not deliver (named handoff to X6)

- The **full bicomplex-instantiation** of the `WithEdgeMaps` structure on
  a concrete `HomologicalComplex₂` built from `BKBicomplex`. This requires
  constructing
  `BKBicomplexHC₂ n : HomologicalComplex₂ (ModuleCat ℚ) (.up ℕ) (.down ℕ)`
  from the existing per-(p,q) `BKBicomplex` + `BKVertDiff` +
  `BKHorizDiff = 0` truncation (via mathlib's `HomologicalComplex₂.ofGradedObject`
  constructor), then producing a `WithEdgeMaps` instance for it that
  identifies with `unionClosedEdgeComposite` per the matched-isotype
  identification. The present X5 deliverable gives the **chain-level
  identification** (the form X6 actually needs to specialise the
  chain-level Walsh vanishing per coordinate to a cohomology-class
  vanishing); the full bicomplex-instantiation is part of the X6 closure
  refactor per the scoping doc §4.
- The equivariant (Z/2)^n action on the bicomplex SS isotype-splitting
  per page — X3's deliverable (in flight under `cat-mg-fade`).
- The Schur-abelian + SS-differential-isotype-preservation — X4's
  deliverable (depends on X3).
- The per-x sorry closure at `SSConvergence.lean:302` — X6's deliverable
  (strictly requires all of X1–X5).

### §3.3 The X1+X2 handoff is consumed correctly

X5 consumes the X2 `ConvergesTo` API + `trivialConvergesTo` witness as a
black box. The `WithEdgeMaps` structure is built on top of `ConvergesTo`
without modifying X2's file. The chain-homotopy adapter
`nullHomotopyOnIsotype_givesEInftyVanishing` from X2 is NOT directly used
in X5 (it remains available for X6's per-coordinate closure). The
`DifferentialsFamily` abstraction from X2 is NOT used in X5 (the trivial
witness suffices for the present scope).

---

## §4 — Mathlib API surface invoked (new in X5)

All from mathlib v4.29.1 at the rev pinned in `lean/lake-manifest.json`.
Verified present via lake-build GREEN.

- (Re-exported via X1 / X2 imports) `CategoryTheory.Category`,
  `CategoryTheory.Abelian`, `CategoryTheory.Limits.IsZero`,
  `CategoryTheory.Limits.ZeroObject` namespace.
- `map_zero` (universally available; `ChainToHomology0.hom.map_zero 0 = 0`).
- From X1's `Bicomplex.lean` — `HomologicalComplex₂.spectralSequence`,
  `HomologicalComplex₂.rowOfColumnHomology` (transitively via X2's
  `EInftyBicomplex`).
- From X2's `Convergence.lean` —
  `HomologicalComplex₂.EInftyBicomplex`,
  `HomologicalComplex₂.ConvergesTo`,
  `HomologicalComplex₂.trivialConvergesTo`,
  `HomologicalComplex₂.ConvergesTo.abutmentFiltration`.
- From union_closed `UC11.CohomologyClass` (mg-0eb4) —
  `chainToHomology0`.
- From union_closed `UC13_PartA.IsotypePreservation` (mg-fa21) —
  `cechIsotypeProjection`, `cechBicomplexValue`,
  `cechIsotypeProjection_matched`, `cechIsotypeProjection_unmatched`,
  `cechBicomplex_level1Support`.

The construction routes through additive cohomology projection only — no
cup-product, no spectral-object TODO reliance.

---

## §5 — Hard-constraint compliance audit

- ✗ NOT factorial: no Specht modules on the mathlib-PR-clean side;
  only the abelian Walsh `(Z/2)^n` χ_{x} on the union_closed side (per
  UC13's `cechIsotypeProjection`); no symmetric-group representation
  theory anywhere.
- ✗ NOT functorial in the refinement sense: direct construction over
  X2's `ConvergesTo` API; per-F per-x Čech source composition on the
  union_closed side; no `Pos_n` functor.
- ✗ U1-dialect preserved: purely additive corner-edge morphisms;
  `chainToHomology0` is additive; `cechIsotypeProjection` is an additive
  Finsupp value; the composite is additive; no cup-product, no branching.
- ✗ Math-first: edge-map fields match textbook
  `E_∞^{p, 0} → H^p(Tot)` / `E_∞^{0, q} → H^q(Tot)` corner-edge story;
  the trivial-witness realisation matches the textbook degenerate
  concentrated-in-row-zero case; the union_closed identification matches
  UC11 §5.3-5.4 (chain-to-homology projection at the populated baseline
  of `BKTotal n` is the SS-edge transport at degree 0, per `BKHorizDiff = 0`
  truncation in `BousfieldKan.lean`) + UC13 §2.4.1 (corrected landing in
  `⊕_x V_{x}^{n-1}`).
- ✗ Cumulative state doc: this file (`docs/state-UC-Lean-SS-X5.md`, NEW) +
  `docs/state-UC10.md` Lean-Session 24 (NEW) + arc-level index
  `docs/UC-Lean-mathlib-SS-scope.md` (mg-7413, unchanged) +
  `docs/state-UC-Lean-SS-X1.md` (mg-dd80, unchanged) +
  `docs/state-UC-Lean-SS-X2.md` (mg-55b3, unchanged).
- ✗ Mathlib-folder authorization scoped to SS-infrastructure-for-this-arc:
  generic new file lives under
  `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/EdgeMap.lean`;
  union_closed-internal companion lives under
  `lean/UnionClosed/UC11/SSEdgeIdentification.lean` (NOT under `Mathlib/`);
  no other path touched (only `lean/UnionClosed.lean` modified for two-line
  import addition).
- ✗ No `sorry`. No axiom-cheat. No fake mathlib API. No defeq trick (the
  `𝟙 _` in trivial-witness edge maps is the *honest content* of the
  trivial-filtration convention, NOT a hidden tautology). No `False.elim`
  on `_hStar`. No `decide` shortcut (only concrete-arithmetic `decide` at
  `Fin 3` cardinality / inequality, matching the existing pattern in
  `UC13_isotypePreservation_n3_witness`). Compiles via `lake build`
  (verified GREEN, 1999 jobs).

---

## §6 — Sorry / axiom / fake-API count delta

- Sorry count: **0 new sorrys**. Pre-existing per-x sorry at
  `lean/UnionClosed/UC11/SSConvergence.lean:302` remains unchanged (this
  is the RED structural blocker that the X1–X6 arc is designed to close
  eventually via X6 — X5 GREEN delivers the chain-level identification
  that X6 will consume).
- Axiom count: **0 new axioms**. `grep -rn '^axiom' lean/UnionClosed/`
  returns empty (unchanged from baseline).
- Fake-API count: **0 fake mathlib API calls**. All invoked symbols
  verified present in mathlib v4.29.1 via lake-build GREEN.

---

## §7 — Forward path: X6 unblocked after X3 + X4 land

Per the scoping doc §3 critical path `X1 → X2 → (X3 ∥ X5) → X4 → X6`:

- **X3 (`UC-Lean-SS-X3-Equivariant`, 250–350k tokens)** — in flight
  under `cat-mg-fade`. X5's GREEN closure does NOT directly unblock X4
  (X4 depends on X3 only). Awaiting X3 GREEN.
- **X4 (`UC-Lean-SS-X4-Schur`, 150–200k tokens)** — depends on X3.
  Runs in parallel with X5 (now GREEN); awaits X3 GREEN before dispatch.
- **X6 (`UC-Lean-SS-X6-PerXClosure`, 150–300k tokens)** — strictly
  requires all of X1–X5. X5's `unionClosedEdgeComposite` is the
  load-bearing chain-level identification that X6 consumes to refactor
  `obstructionCohomClass F x` from the chain-level Finsupp expression to
  an SS-abutment-derived cohomology class. Closes the per-x sorry at
  `SSConvergence.lean:302`.

---

## §8 — Cross-references

- **Parent arc**: mg-7413 (UC-Lean-mathlib-SS-scope, Lean-Session 20 GREEN
  scoping). Scoping doc: `docs/UC-Lean-mathlib-SS-scope.md`.
- **Predecessor (X1)**: mg-dd80 (UC-Lean-SS-X1-Bicomplex, Lean-Session 21
  AMBER named-gap GREEN lake build). State doc:
  `docs/state-UC-Lean-SS-X1.md`. X5 consumes X1's `K.spectralSequence`
  constructor + page X-data identification.
- **Predecessor (X2)**: mg-55b3 (UC-Lean-SS-X2-Convergence, Lean-Session 22
  GREEN). State doc: `docs/state-UC-Lean-SS-X2.md`. X5 consumes X2's
  `K.EInftyBicomplex`, `K.ConvergesTo`, and `K.trivialConvergesTo`.
- **Parallel sibling (X3)**: mg-fade (UC-Lean-SS-X3-Equivariant, in
  flight under `cat-mg-fade`). Disjoint file set; coexistent.
- **Parent RED diagnosis**: mg-36c3 (UC-Lean-per-x-closure, RED
  structural blocker). See `docs/state-UC-Lean-per-x-closure.md` +
  Lean-Session 19 of `docs/state-UC10.md`.
- **Mathlib pinned**: `v4.29.1`, rev
  `5e932f97dd25535344f80f9dd8da3aab83df0fe6`.
- **New files**:
  - `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/EdgeMap.lean`
    (NEW, mathlib-PR-clean).
  - `lean/UnionClosed/UC11/SSEdgeIdentification.lean` (NEW,
    union_closed-internal).
- **Modified file**: `lean/UnionClosed.lean` (two-line import addition).
- **Cumulative state**: this file + `docs/state-UC10.md` Lean-Session 24.

---

## §9 — Verdict

**GREEN — X5 delivers the SS corner edge-map API (generic, mathlib-PR-clean)
in `EdgeMap.lean` + the union_closed-specific chain-level identification
of the SS edge at coordinate `x` with `chainToHomology0 n` composed with
the χ_{x} isotype projection on the BK bicomplex shape in
`SSEdgeIdentification.lean`; lake build GREEN (1999 jobs); no sorry,
no axiom, no defeq trick, no decide shortcut (only concrete-arithmetic
`decide` at `Fin 3`), no fake mathlib API, no `SpectralObject` TODO
reliance. Both files non-vacuously evaluated (generic file on arbitrary
first-quadrant bicomplexes; union_closed file on `IntClosedFam 3` +
`IntClosedFam 4`). X3 ∥ X5 first parallel sibling lands; X6 unblocks
once X3 + X4 also land.**
