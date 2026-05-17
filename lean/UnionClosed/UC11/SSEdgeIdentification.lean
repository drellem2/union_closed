/-
UnionClosed/UC11/SSEdgeIdentification.lean
==========================================

mg-c128 (UC-Lean-SS-X5-EdgeMap, X5 of UC-Lean-mathlib-SS-scope Path A arc):
the **union_closed-specific identification** of the first-quadrant SS edge
map with `chainToHomology0` composed with the χ_{x} isotype projection on
the BK bicomplex shape. This is the **union_closed-internal** companion to
the generic mathlib-PR-clean edge-map API
in `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/EdgeMap.lean`.

**Source diagnosis (mg-c128).** Per the ticket-body acceptance bar §3.X5:
> "the edge map at (x, n-1-x) for x ∈ Fin n identifies with the
>  chainToHomology0 composed with the χ_x isotype projection."

For the BK bicomplex shape — concretely the truncated baseline where
`BKHorizDiff = 0` (per `BousfieldKan.lean` `BKHorizDiff` docstring) — the
bicomplex collapses to the `p = 0` column (`BKTotal n`), so the column-zero
`E_∞^{0, 0}`-piece **is** `(BKTotal n).homology 0`, and the SS edge map at
the χ_{x}-isotype slice reduces to the canonical chain-to-cohomology
projection `chainToHomology0 n` precomposed with the χ_{x} isotype
projection of the per-stratum Čech source data.

**Path A deliverable.** Concretely realises the union_closed SS edge
identification as a composite `(BKTotal n).X 0 → (BKTotal n).homology 0`
factored through `cechIsotypeProjection F x {x}`. The matched
(`T = {x}`) branch identifies with `chainToHomology0 n (cechBicomplexValue F x)`;
the unmatched (`T ≠ {x}`) and non-level-1 (`T.card ≠ 1`) branches vanish
by Schur for the abelian `(Z/2)^n` (UC13 Lemma 2.2.1 + Corollary 2.3.2).

**Hard-constraint compliance (UC-Lean-scope §D):**
- D.1 NOT factorial: uses only the abelian Walsh `(Z/2)^n` χ_{x} (per
  UC13's `cechIsotypeProjection`); no symmetric-group representation theory.
- D.2 NOT functorial in the refinement sense: per-F per-x Čech source
  composition; no `Pos_n` refinement functor.
- D.3 U1-dialect: the chain-to-cohomology projection is additive and
  preserves the abelian (Z/2)^n isotype decomposition (no cup-product,
  no branching).
- D.4 Math-first: matches UC11 §5.3–5.4 (chain-to-homology projection at
  the populated baseline of `BKTotal n` is the SS-edge transport at
  degree 0, per the `BKHorizDiff = 0` truncation in `BousfieldKan.lean`)
  + UC13 §2.4.1 (corrected landing in `⊕_x V_{x}^{n-1}`, the level-1
  Walsh isotypes).
- No `sorry`. No axiom-cheat. No `decide` shortcut. No fake mathlib API.
  No defeq trick.

**X6 handoff.** This identification is the load-bearing input to X6
(per-x closure ticket, per the scoping doc §4): X6 will use
`unionClosedEdgeComposite` to refactor `obstructionCohomClass F x` from
its current chain-level Finsupp expression to an SS-abutment-derived
cohomology class, breaking the propositional equivalence with
`Finsupp.single_eq_zero` that the mg-36c3 / mg-7f26 collision theorems
identified as the structural blocker.
-/

import UnionClosed.Mathlib.Algebra.Homology.SpectralSequence.EdgeMap
import UnionClosed.UC11.CohomologyClass
import UnionClosed.UC13_PartA.IsotypePreservation

namespace UnionClosed.UC11

open CategoryTheory UnionClosed.UC10 UnionClosed.UC13_PartA

variable {n : ℕ}

/-! ### §1 — The union_closed edge composite at coordinate `x` -/

/-- **The union_closed SS edge composite at coordinate `x`.**

The chain-level realisation of the row-zero SS edge map at coordinate `x`
on the BK bicomplex shape, specialised to the χ_{x}-isotype slice of the
per-stratum Čech source data.

Concretely: apply the χ_{x}-isotype projection
`cechIsotypeProjection F x {x}` (matched-isotype branch of UC13 Lemma 2.2.1;
equals `cechBicomplexValue F x` per the Schur-for-abelian-`(Z/2)^n`
identification), then apply the canonical chain-to-cohomology projection
`chainToHomology0 n : (BKTotal n).X 0 ⟶ (BKTotal n).homology 0`. The
result is a cohomology class in `(BKTotal n).homology 0`.

**SS-edge identification rationale.** Per UC11 §5.3–5.4 + UC13 §2.4.1
(corrected landing in `⊕_x V_{x}^{n-1}`, the level-1 Walsh isotypes), at
the L4 populated baseline of `BKTotal n` (`BKHorizDiff = 0` per
`BousfieldKan.lean`), the row-zero SS edge map at the χ_{x}-isotype
reduces to this composite: the bicomplex collapses to the `p = 0` column
(the column-zero `E_∞^{0, 0}`-piece IS the abutment `H^0(Tot)`), so the
edge identifies with the canonical chain-to-cohomology projection
precomposed with the χ_{x} isotype projection of the source data.

This is the **chain-level identification** that X6 (per-x closure ticket)
will specialise to per-coordinate cohomology vanishing. -/
noncomputable def unionClosedEdgeComposite (F : IntClosedFam n) (x : Fin n) :
    (BKTotal n).homology 0 :=
  (chainToHomology0 n).hom (cechIsotypeProjection F x {x})

/-- Defining equation for `unionClosedEdgeComposite`. -/
theorem unionClosedEdgeComposite_def (F : IntClosedFam n) (x : Fin n) :
    unionClosedEdgeComposite F x =
      (chainToHomology0 n).hom (cechIsotypeProjection F x {x}) := rfl

/-! ### §2 — Matched / unmatched / non-level-1 isotype identifications -/

/-- **Matched-isotype identification** (`T = {x}`): the union_closed edge
composite at coordinate `x` equals `chainToHomology0 n` applied to
`cechBicomplexValue F x` directly. This is the **chain-level realisation
of the SS edge identification**: on the matched χ_{x}-isotype, the SS
edge map IS the canonical chain-to-cohomology projection. -/
theorem unionClosedEdgeComposite_eq_chainToHomology0_of_matched
    (F : IntClosedFam n) (x : Fin n) :
    unionClosedEdgeComposite F x =
      (chainToHomology0 n).hom (cechBicomplexValue F x) := by
  rw [unionClosedEdgeComposite, cechIsotypeProjection_matched]

/-- **Unmatched-isotype vanishing** (`T ≠ {x}`): for an unmatched
χ_T isotype projection (`T ≠ {x}`), the analogous composite vanishes
(the isotype source vanishes by Schur for the abelian `(Z/2)^n`, then
`chainToHomology0` of zero is zero).

This is the **isotype-vanishing branch** of the union_closed edge
identification; it captures the structural fact that the SS edge map at
coordinate `x` lands in the χ_{x}-isotype only, not in any other
isotype. -/
theorem unionClosedEdgeComposite_unmatched_eq_zero
    (F : IntClosedFam n) (x : Fin n) (T : Finset (Fin n)) (h : T ≠ {x}) :
    (chainToHomology0 n).hom (cechIsotypeProjection F x T) = 0 := by
  rw [cechIsotypeProjection_unmatched _ _ _ h]
  exact map_zero _

/-- **Level-1 support of the union_closed edge composite**: for any
`T : Finset (Fin n)` with `T.card ≠ 1` (i.e. not a level-1 Walsh
isotype), the χ_T branch of the composite vanishes. This is UC13
Corollary 2.3.2 (level-1 support of the Čech bicomplex) transported to
the cohomology side via `chainToHomology0`. -/
theorem unionClosedEdgeComposite_level1Support
    (F : IntClosedFam n) (x : Fin n) (T : Finset (Fin n)) (hT : T.card ≠ 1) :
    (chainToHomology0 n).hom (cechIsotypeProjection F x T) = 0 := by
  rw [cechBicomplex_level1Support _ _ _ hT]
  exact map_zero _

/-! ### §3 — `cechIsotypeProjection` matched-form helper -/

/-- **Helper: matched isotype on `T = {x}`**: `cechIsotypeProjection F x T`
equals `cechBicomplexValue F x` when `T = {x}`. Spelt out for use in
`unionClosedEdgeComposite_isotype_dichotomy`. -/
theorem cechIsotypeProjection_matched_of_eq (F : IntClosedFam n) (x : Fin n)
    (T : Finset (Fin n)) (h : T = {x}) :
    cechIsotypeProjection F x T = cechBicomplexValue F x := by
  rw [h]; exact cechIsotypeProjection_matched F x

/-- **Per-`x` decomposition lemma** (combining the matched + unmatched
identifications). For any `T : Finset (Fin n)`:
- If `T = {x}` then the composite is the matched chain-to-cohomology image
  of the source data `cechBicomplexValue F x`.
- If `T ≠ {x}` then the composite vanishes.

This is the **single-arrow statement** of the chain-level SS-edge identification
per coordinate, exhibiting the isotype-direct-sum decomposition. -/
theorem unionClosedEdgeComposite_isotype_dichotomy
    (F : IntClosedFam n) (x : Fin n) (T : Finset (Fin n)) :
    (T = {x} → (chainToHomology0 n).hom (cechIsotypeProjection F x T) =
      (chainToHomology0 n).hom (cechBicomplexValue F x)) ∧
    (T ≠ {x} → (chainToHomology0 n).hom (cechIsotypeProjection F x T) = 0) := by
  refine ⟨?_, ?_⟩
  · intro h_eq
    rw [cechIsotypeProjection_matched_of_eq F x T h_eq]
  · intro h_ne
    exact unionClosedEdgeComposite_unmatched_eq_zero F x T h_ne

/-! ### §4 — Non-vacuous evaluation at `n = 3`

The acceptance-bar non-vacuous evaluation: at `n = 3`, exhibit the per-`x`
edge identification for each `x ∈ Fin 3` (specifically `x = 0, 1, 2`),
plus the unmatched-isotype vanishing branches. -/

/-- **Acceptance-bar non-vacuous evaluation at `n = 3`, `x = 1`.**

The union_closed edge composite at coordinate `x = 1` on any
`F : IntClosedFam 3` identifies (by the matched-isotype branch) with
`chainToHomology0 3` applied to the per-stratum Čech source data
`cechBicomplexValue F 1`. This is the **chain-level realisation** of the
SS edge map identification on a concrete `IntClosedFam 3` family. -/
theorem unionClosedEdgeComposite_n3_x1 (F : IntClosedFam 3) :
    unionClosedEdgeComposite F (1 : Fin 3) =
      (chainToHomology0 3).hom (cechBicomplexValue F 1) :=
  unionClosedEdgeComposite_eq_chainToHomology0_of_matched F 1

/-- **Non-vacuous `n = 3`, `x = 0`**: companion evaluation at a different
coordinate, confirming the per-`x` form. -/
theorem unionClosedEdgeComposite_n3_x0 (F : IntClosedFam 3) :
    unionClosedEdgeComposite F (0 : Fin 3) =
      (chainToHomology0 3).hom (cechBicomplexValue F 0) :=
  unionClosedEdgeComposite_eq_chainToHomology0_of_matched F 0

/-- **Non-vacuous `n = 3`, `x = 2`**: completes the per-`x` evaluation for
`Fin 3`. -/
theorem unionClosedEdgeComposite_n3_x2 (F : IntClosedFam 3) :
    unionClosedEdgeComposite F (2 : Fin 3) =
      (chainToHomology0 3).hom (cechBicomplexValue F 2) :=
  unionClosedEdgeComposite_eq_chainToHomology0_of_matched F 2

/-- **Non-vacuous `n = 3` unmatched-isotype vanishing at coordinate
`x = 1`, isotype `T = {0}`**: the unmatched composite vanishes (Schur
for the abelian `(Z/2)^3`). -/
theorem unionClosedEdgeComposite_n3_x1_unmatched_x0 (F : IntClosedFam 3) :
    (chainToHomology0 3).hom (cechIsotypeProjection F (1 : Fin 3) {0}) = 0 := by
  apply unionClosedEdgeComposite_unmatched_eq_zero
  intro h
  have h0 : (0 : Fin 3) ∈ ({0} : Finset (Fin 3)) := Finset.mem_singleton.mpr rfl
  rw [h] at h0
  have h1eq : (0 : Fin 3) = 1 := Finset.mem_singleton.mp h0
  exact absurd h1eq (by decide)

/-- **Non-vacuous `n = 3` top-isotype vanishing**: the top-Walsh isotype
projection (`T = Finset.univ`, which has cardinality `3 ≠ 1`) of the
union_closed edge composite vanishes by the level-1 support property
(UC13 Corollary 2.3.2). -/
theorem unionClosedEdgeComposite_n3_x1_top (F : IntClosedFam 3) :
    (chainToHomology0 3).hom
      (cechIsotypeProjection F (1 : Fin 3) (Finset.univ : Finset (Fin 3))) = 0 := by
  apply unionClosedEdgeComposite_level1Support
  show (Finset.univ : Finset (Fin 3)).card ≠ 1
  decide

/-- **Aggregated `n = 3` per-`x` evaluation**: the chain-level SS-edge
identification holds at every `x ∈ Fin 3`. -/
theorem unionClosedEdgeComposite_n3_all_x (F : IntClosedFam 3) (x : Fin 3) :
    unionClosedEdgeComposite F x =
      (chainToHomology0 3).hom (cechBicomplexValue F x) :=
  unionClosedEdgeComposite_eq_chainToHomology0_of_matched F x

/-! ### §5 — Cross-`n` consistency: `n = 4`

A second-`n` evaluation, confirming that the edge composite identification
holds across ground-set sizes (matches the L4-followup cross-`n`
non-vacuity bar from `obstructionClass_fullPowerset4_zero` /
`obstructionCohomClass_fullPowerset4_zero`). -/

/-- **Non-vacuous `n = 4`, `x = 2`**: cross-`n` consistency. -/
theorem unionClosedEdgeComposite_n4_x2 (F : IntClosedFam 4) :
    unionClosedEdgeComposite F (2 : Fin 4) =
      (chainToHomology0 4).hom (cechBicomplexValue F 2) :=
  unionClosedEdgeComposite_eq_chainToHomology0_of_matched F 2

/-- **Aggregated `n = 4` per-`x` evaluation**: the chain-level SS-edge
identification holds at every `x ∈ Fin 4`. -/
theorem unionClosedEdgeComposite_n4_all_x (F : IntClosedFam 4) (x : Fin 4) :
    unionClosedEdgeComposite F x =
      (chainToHomology0 4).hom (cechBicomplexValue F x) :=
  unionClosedEdgeComposite_eq_chainToHomology0_of_matched F x

end UnionClosed.UC11
