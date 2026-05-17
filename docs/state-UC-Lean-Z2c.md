# UC-Lean-Z2c-BicomplexSpectralObjectVerdier state — mg-ce0c

**Verdict.** **AMBER** — substantive Z2c delivery (closing the dual Joël Riou documented mathlib
`stupidTruncProjection` TODO + applying it to obtain the canonical LE-side filtration projection
`K ⟶ K.cutoffColumnsLE p` + LE-side filtration step `K.cutoffColumnsLE (p + 1) ⟶ K.cutoffColumnsLE p` +
inclusion of `K.singleColumnAt (p + 1)` + packaged short complex
`0 ⟶ singleColumnAt (p + 1) ⟶ cutoffColumnsLE (p + 1) ⟶ cutoffColumnsLE p ⟶ 0` with composition-zero
proven) lands GREEN; the **substantive `SpectralObject (HomologicalComplex C c₁₂) EInt`
construction** (Verdier H-functor on `mk₁ (homOfLE (i ≤ j))` for arbitrary `i, j : EInt` + δ-data
via snake lemma on triple filtration quotients + three exactness conditions via the LES of
cohomology) **and the `IsFirstQuadrant` instance** are honest follow-on **Z2d** sub-tickets per
the pre-authorised sub-split contingency mirroring the Z1 → Z1b and Z2 → Z2a → Z2b precedents
(mg-4165 → mg-a298; mg-3ff1 → mg-0611 → this session). Pattern matches Z2a → Z2b → Z2c:
bicomplex-level filtration infrastructure substantively landed (both GE side from Z2a/Z2b AND
LE side from Z2c); SpectralObject axiomatic construction deferred as a focused short next-session
sub-ticket combining both halves.

## What Z2c landed (Phase A LE-side complete: projection + filtration step + s.e.s. composition-zero)

Substantively extended `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/Bicomplex.lean`
from ~750 lines (Z2b baseline) to ~1330 lines:

### Z2c-A — `stupidTruncProjection` (closing the dual Joël Riou mathlib TODO)

```lean
/-- The canonical projection morphism `K ⟶ K.stupidTrunc e` when `[e.IsTruncLE]`. Closes
the dual mathlib TODO at `Mathlib/Algebra/Homology/Embedding/StupidTrunc.lean` line 21. Dual
to Z2b's `stupidTruncInclusion`. -/
noncomputable def stupidTruncProjection [e.IsTruncLE] : K ⟶ K.stupidTrunc e where
  f i' := K.stupidTruncProjection_f e i'
  comm' i' j' h_rel := by
    by_cases hj : ∃ j, e.f j = j'
    · obtain ⟨j, rfl⟩ := hj
      obtain ⟨i, rfl⟩ : ∃ i, e.f i = i' := e.mem_prev h_rel
      ...
    · exact (K.isZero_stupidTrunc_X e j' (by simpa using hj)).eq_of_tgt _ _
```

Cell-wise: in-image cell uses `stupidTruncXIso.inv`; out-of-image cell uses the zero morphism
(well-defined regardless of source because the target is `IsZero`). Commutation in `IsTruncLE`
uses `e.mem_prev` (rel into in-image forces source in-image) for the in-image branch and
`IsZero.eq_of_tgt` for the out-of-image branch. Auxiliary: `stupidTruncProjection_f` (cell
component) + `stupidTruncProjection_f_eq` (cell formula at in-range cell) +
`stupidTruncProjection_f_eq_zero` (cell formula at out-of-range cell) +
`stupidTruncProjection_f_eq_of_mem` (`@[simp]`-tagged variant) + `stupidTruncXIso_inv_eq_of_eq`
(well-definedness of the iso `.inv` across witness choice, used in the cell formula).

### Z2c-B — naturality + nat trans

`HomologicalComplex.stupidTruncProjection_stupidTruncMap : K.stupidTruncProjection e ≫ stupidTruncMap φ e = φ ≫ L.stupidTruncProjection e`
— naturality of `stupidTruncProjection` w.r.t. morphisms of complexes.

`ComplexShape.Embedding.stupidTruncProjectionNatTrans : 𝟭 _ ⟶ e.stupidTruncFunctor C`
— the natural transformation packaging the per-complex projection (the precise content of
Joël Riou's TODO line 21).

### Z2c-C — `HomologicalComplex₂.cutoffColumnsLE` bicomplex (LE side dual to Z2a)

```lean
noncomputable def cutoffColumnsLE (p : ℤ) : HomologicalComplex₂ C (ComplexShape.up ℤ) c₂ :=
  K.stupidTrunc (ComplexShape.embeddingUpIntLE p)
```

Plus structural lemmas dual to Z2a's:
- `cutoffColumnsLE_XIso_of_le : (K.cutoffColumnsLE p).X p' ≅ K.X p'` for `p' ≤ p`.
- `cutoffColumnsLE_isZero_X_of_gt : IsZero ((K.cutoffColumnsLE p).X p')` for `p < p'`.

### Z2c-D — `cutoffColumnsLE_projection` (LE-side filtration projection)

```lean
noncomputable def cutoffColumnsLE_projection (p : ℤ) : K ⟶ K.cutoffColumnsLE p :=
  HomologicalComplex.stupidTruncProjection K (ComplexShape.embeddingUpIntLE p)
```

Cell formulas: `cutoffColumnsLE_projection_f_of_le` (in-range = `cutoffColumnsLE_XIso_of_le hp .inv`)
+ `cutoffColumnsLE_projection_f_of_gt` (out-of-range = `0`).

### Z2c-E — `cutoffColumnsLE_succ` (LE-side filtration step)

```lean
noncomputable def cutoffColumnsLE_succ (p : ℤ) :
    K.cutoffColumnsLE (p + 1) ⟶ K.cutoffColumnsLE p
```

The filtration step in the cokernel-consistent projection direction (going from "more cells kept
≤ p+1" to "fewer cells kept ≤ p", dropping the newly-added column `p + 1`). Cell-wise: at
`p' ≤ p` it is `XIso_of_le hp .hom ≫ XIso_of_le hp' .inv` (the iso composition); at `p' > p` it
is `0`. The commutation proof is a clean four-step `calc` block using the two projection
naturalities (at `p + 1` and at `p`) chained via the standard naturality trick. Cell formulas:
`cutoffColumnsLE_succ_f_of_le` + `cutoffColumnsLE_succ_f_of_gt`. Universal-property compatibility
lemma `cutoffColumnsLE_projection_succ : cutoffColumnsLE_projection (p + 1) ≫ cutoffColumnsLE_succ p = cutoffColumnsLE_projection p`
(dual to Z2b's `cutoffColumns_succ_inclusion`).

### Z2c-F — `singleColumnAt_to_cutoffColumnsLE` (LE-side single-column inclusion)

```lean
noncomputable def singleColumnAt_to_cutoffColumnsLE (p : ℤ) :
    K.singleColumnAt (p + 1) ⟶ K.cutoffColumnsLE (p + 1)
```

For `[DecidableEq ℤ]`, the cell-level inclusion of the single-column bicomplex into the LE-cutoff
bicomplex. At `p' = p + 1` it is the substantive cell hom
`singleColumnAt_to_cutoffColumnsLE_f_self p := singleColumnAt_XIso_self (p + 1) .hom ≫ cutoffColumnsLE_XIso_of_le (le_refl _) .inv`
wrapped with `eqToHom` transport. At `p' ≠ p + 1` it is `0`. Commutation discharges via case
analysis: `p' = p + 1` gives target `(cutoffColumnsLE (p + 1)).X (p + 2)` which is `IsZero`
(via `IsZero.eq_of_tgt`); `p' ≠ p + 1` gives source `(singleColumnAt (p + 1)).X p'` which is
`IsZero` (via `IsZero.eq_of_src`).

### Z2c-G — `singleColumnAt_to_cutoffColumnsLE_shortComplex` (LE-side bicomplex s.e.s. composition-zero)

```lean
@[simps!]
noncomputable def singleColumnAt_to_cutoffColumnsLE_shortComplex (p : ℤ) :
    ShortComplex (HomologicalComplex₂ C (ComplexShape.up ℤ) c₂)
```

The LE-side bicomplex s.e.s. packaging, with the load-bearing middle-position vanishing identity
`singleColumnAt_to_cutoffColumnsLE ≫ cutoffColumnsLE_succ = 0` proven via cell case analysis on
`p' = p + 1` (target IsZero) vs `p' ≠ p + 1` (source component zero). Dual to Z2b's
`cutoffColumns_succ_singleColumnAt_shortComplex` composition-zero.

## Non-vacuous evaluation (9 new Z2c examples + 11 Z2a/Z2b-baseline preserved)

Nine concrete cell-level examples on `ModuleCat ℚ`-valued bicomplexes using the new Z2c primitives:

1. `(K.cutoffColumnsLE 5).X 2 ≅ K.X 2` — non-zero cell at column 2 of LE-cutoff at 5.
2. `IsZero ((K.cutoffColumnsLE 0).X 2)` — out-of-range zero at column 2 of LE-cutoff at 0.
3. `(K.cutoffColumnsLE_projection 5).f 2 = (K.cutoffColumnsLE_XIso_of_le _).inv` — non-zero cell
   for the projection at column 2 of cutoff at 5.
4. `(K.cutoffColumnsLE_projection 0).f 2 = 0` — out-of-range zero at column 2 of cutoff at 0.
5. `stupidTruncProjection K (embeddingUpIntLE 0) = K.cutoffColumnsLE_projection 0` (by `rfl`) —
   definitional consistency of the bicomplex projection via the mathlib-PR-clean primitive.
6. `(K.cutoffColumnsLE_succ 0).f 0 = XIso_of_le hp1 .hom ≫ XIso_of_le hp .inv` — non-zero cell
   for the LE-side filtration step at column 0.
7. `(K.cutoffColumnsLE_succ (-1)).f 2 = 0` — out-of-range zero for the LE-side filtration step.
8. `(K.singleColumnAt_to_cutoffColumnsLE 0).f 5 = 0` — zero off the kept column.
9. The LE-side s.e.s. composition-zero `(K.singleColumnAt_to_cutoffColumnsLE_shortComplex 0).f ≫ .g = 0`
   — non-vacuous packaging.
10. The LE-side projection-succ factorisation
    `(K.cutoffColumnsLE_projection 1 ≫ K.cutoffColumnsLE_succ 0).f 2 = 0` — Z2c-symmetry
    sanity check.

## Z2d named follow-on (deferred deliverables: SpectralObject Verdier construction + IsFirstQuadrant)

With both halves of the filtration infrastructure landed (Z2a + Z2b GE-side + Z2c LE-side),
Z2d combines them to build the SpectralObject:

- **EInt-extension of `cutoffColumns / cutoffColumnsLE`** to `EInt = WithBotTop ℤ`:
  - `cutoffColumnsE K ⊥ := 0` (smallest)
  - `cutoffColumnsE K (k : ℤ) := K.cutoffColumnsLE k` (intermediate, INCREASING in `k`)
  - `cutoffColumnsE K ⊤ := K` (largest)

- **Quotient functor `F^j / F^i` for `i ≤ j : EInt`** as cokernel of inclusion
  `cutoffColumnsE i → cutoffColumnsE j` (cell-by-cell embedding direction). Functoriality in
  `mk₁ (homOfLE _)` via the cokernel universal property.

- **H-functor `H n : ComposableArrows EInt 1 ⥤ HomologicalComplex C c₁₂`** mapping
  `mk₁ (homOfLE (i ≤ j))` to the totalised quotient `(F^j / F^i).total c₁₂` shifted by `n`
  (using `HomologicalComplex.shiftFunctor` when `c₁₂ = ComplexShape.up ℤ`).

- **δ-map via snake lemma on triple filtration quotients** — for `i ≤ j ≤ k`, the s.e.s.
  `0 ⟶ F^j / F^i ⟶ F^k / F^i ⟶ F^k / F^j ⟶ 0` (assembled from Z2b GE-side and Z2c LE-side
  primitives at adjacent steps and chained via cokernel composition) induces the snake-lemma
  δ-map `H^n(F^k / F^j) → H^{n+1}(F^j / F^i)`.

- **Three SpectralObject exactness conditions** — `exact₁', exact₂', exact₃'` from the LES of
  cohomology on the triple filtration s.e.s., via `mathlib.Algebra.Homology.HomologySequence`
  machinery.

- **`HomologicalComplex₂.spectralObject_isFirstQuadrant : (K.spectralObject).IsFirstQuadrant`**
  instance — for first-quadrant bicomplexes (supported in `(p, q)` with `p ≥ 0`, `q ≥ 0`), the
  two vanishing conditions of `IsFirstQuadrant` follow from cell-level
  `cutoffColumns_isZero_X_of_lt` + `cutoffColumnsLE_isZero_X_of_gt` + the total-complex coproduct
  structure.

Z2d is sized for a focused short next session (~250-300k tokens), matching the Z2a / Z2b / Z2c
cadence.

## Build

`lake build` GREEN (2043 jobs unchanged from Z2b baseline; the Z2c additions go into the
existing Bicomplex.lean file with no new module imports). Sorry count stays at 1 (pre-existing
Y6 chain-map-extension residual at `UnionClosed/UC11/SSConvergence.lean:563` unchanged from
Lean-Sessions 34-39). Pre-existing `push_neg` deprecation warnings in `Frankl.lean` unchanged.
Zero new sorrys / axioms / fake mathlib API / defeq tricks / `False.elim` / `decide` shortcuts
in `Bicomplex.lean`.

## Acceptance bar status per scoping doc §0 + §Z2 + Z2c ticket (12 bars)

| Bar | Status | Note |
|-----|--------|------|
| 1. `lake build` GREEN | ✅ | 2043 jobs (unchanged) |
| 2. Non-vacuous (SpectralObject H/δ eval at small (p, q)) | ◐ AMBER | 9 new Z2c cell-level non-vacuous examples land substantively (genuine non-zero cell isos for the projection + filtration step + s.e.s. composition-zero on LE side); SpectralObject H/δ evaluation is Z2d-deferred |
| 3. Mathlib-PR-clean naming, docstrings, Joël-Riou-style | ✅ | Full module docstring extended for Z2c + per-declaration docstrings; Riou + Morrison attribution preserved; `stupidTruncProjection` is a definitive Joël Riou TODO closure dual to Z2b's `stupidTruncInclusion` |
| 4. Zero new sorrys | ✅ | None added |
| 5. Zero new axioms | ✅ | None |
| 6. No fake mathlib API | ✅ | Only existing mathlib primitives (`stupidTrunc`, `stupidTruncXIso`, `extendXIso`, `extend_d_eq`, `embeddingUpIntLE`, `restriction`, `IsTruncLE.mem_prev`, `IsZero.eq_of_tgt`, `IsZero.eq_of_src`, `eqToHom`, `ShortComplex.mk`) |
| 7. No defeq bypass on s.e.s. exactness | ✅ | Composition-zero proven via genuine cell case analysis (IsZero.eq_of_tgt + IsZero.eq_of_src + dif_neg); not a `rfl` bypass |
| 8. No `False.elim` shortcuts | ✅ | None |
| 9. Type-correct | ✅ | No metavariable cheats |
| 10. MATHLIB-FOLDER scope respected | ✅ | Only `Bicomplex.lean` modified (extends Z2a + Z2b's existing file) |
| 11. Feeds-into-Z3 readiness | ◐ AMBER | Phase A bicomplex-side BOTH GE-side (Z2b) AND LE-side (Z2c) filtration infrastructure substantively landed as building blocks Z2d needs; SpectralObject + IsFirstQuadrant are Z2d follow-on |
| 12. No L+X+Y dependencies | ✅ | No new mathlib imports beyond the Z2b transitive closure |

## Hard constraints

NOT factorial / NOT functorial-in-refinement / U1-dialect / math-first / mathlib-folder
authorization respected. Joël Riou attribution preserved in file header docstring + commit
message (formal co-authorship deferred to push-time per Daniel 13:53Z local-only directive).
The `stupidTruncProjection` portion is a definitive closure of an upstream mathlib TODO (line
21 of `StupidTrunc.lean`) and is publishable to mathlib as-is together with Z2b's
`stupidTruncInclusion` (line 20) — both TODOs now closed (modulo the local-only directive).

## Strictly tighter than mg-0611 (Z2b AMBER)

mg-0611 substantively landed Z2b GE-side (`stupidTruncInclusion`, `cutoffColumns_inclusion`,
`cutoffColumns_succ`, `cutoffColumns_succ_inclusion`, `cutoffColumns_to_singleColumnAt`,
`cutoffColumns_succ_singleColumnAt_shortComplex`). This Lean-Session 40 extends with the dual
Z2c LE-side: (1) the `stupidTruncProjection` mathlib-TODO closure (the missing dual primitive
Z2b noted as Z2c-A); (2) the bicomplex LE-cutoff `cutoffColumnsLE` (Z2c-C); (3) the LE-side
filtration projection `cutoffColumnsLE_projection` (Z2c-D); (4) the LE-side filtration step
`cutoffColumnsLE_succ` (Z2c-E); (5) the LE-side single-column inclusion
`singleColumnAt_to_cutoffColumnsLE` (Z2c-F); (6) the LE-side s.e.s. composition-zero
(Z2c-G); (7) 9 new non-vacuous evaluations on the new primitives.

The remaining Z2-deliverable-3 (`HomologicalComplex₂.spectralObject K`) and Z2-deliverable-4
(`IsFirstQuadrant` instance) are strictly tighter named as **Z2d** with all needed building
blocks in place (both GE-side from Z2a+Z2b AND LE-side from Z2c). Z2d's primary work is the
EInt-extension + cokernel-based quotient functor + δ via snake + 3 exactness via LES + first
quadrant verification.

## Files touched

MODIFIED `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/Bicomplex.lean`
(~750 → ~1330 lines; extends Z2b's existing file). NEW `docs/state-UC-Lean-Z2c.md`
(this file). MODIFIED `docs/state-UC10.md` (Lean-Session 40 entry).

## Non-vacuous status

`Frankl_Holds` unchanged at the Frankl-level (Z arc has not yet touched Frankl-level objects;
only the mathlib-folder SpectralObject/Bicomplex infrastructure has expanded). `Frankl_Holds_fullPowerset3`
+ `Frankl_Holds_fullPowerset4` continue to build GREEN via concrete L4 minimal-element witnesses.

## Forward operational step

Z2d (UC-Lean-Z2d-BicomplexSpectralObjectClosure) dispatches as the next sequential execution
ticket per Phase C critical path Z2 → Z3 → (Z4 ∥ Z5) → Z6 → Z7 → Z8 → Z9 → Z10, with Z2d
consuming the Z2b-supplied GE-side infrastructure (`cutoffColumns_inclusion`,
`cutoffColumns_succ`, `cutoffColumns_succ_singleColumnAt_shortComplex`) and the Z2c-supplied
LE-side infrastructure (`cutoffColumnsLE_projection`, `cutoffColumnsLE_succ`,
`singleColumnAt_to_cutoffColumnsLE_shortComplex`) to close out the substantive Verdier
`SpectralObject` construction (EInt-extension + quotient functor via cokernel + H-functor with
shift + δ via snake lemma on triple quotients + three exactness axioms via LES) +
`IsFirstQuadrant` instance. Z3 (BicomplexConvergence) is blocked until Z2d GREEN per scoping
doc §Z3 dependency.
