# UC-Lean-Z2b-BicomplexSpectralObjectInclusionSES state — mg-0611

**Verdict.** **AMBER** — substantive Z2b delivery (closing Joël Riou's documented mathlib
`stupidTruncInclusion` TODO + applying it to obtain the canonical bicomplex filtration inclusion
`K.cutoffColumns p ⟶ K` + filtration step `K.cutoffColumns (p + 1) ⟶ K.cutoffColumns p` +
quotient projection onto `K.singleColumnAt p` + packaged short complex
`0 ⟶ cutoffColumns (p + 1) ⟶ cutoffColumns p ⟶ singleColumnAt p ⟶ 0` with composition-zero
proven) lands GREEN; the **substantive `SpectralObject (HomologicalComplex C c₁₂) EInt`
construction** (Verdier H-functor on `mk₁ (homOfLE (i ≤ j))` for arbitrary `i, j : EInt` + δ-data
via snake lemma on triple filtration quotients + three exactness conditions via the LES of
cohomology) **and the `IsFirstQuadrant` instance** are honest follow-on **Z2c** sub-tickets per
the pre-authorised sub-split contingency mirroring the Z1 → Z1b precedent (mg-4165 → mg-a298).
Pattern matches Z2a → Z2b: bicomplex object-level filtration substantively landed; SpectralObject
axiomatic construction deferred as a focused short next-session sub-ticket.

## What Z2b landed (Phase A complete: inclusion + filtration step + s.e.s. composition-zero)

Substantively extended `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/Bicomplex.lean`
from ~250 lines (Z2a baseline) to ~750 lines:

### Z2b-A — `stupidTruncInclusion` (closing Joël Riou's mathlib TODO)

```lean
/-- The canonical inclusion morphism `K.stupidTrunc e ⟶ K` when [e.IsTruncGE]`. Closes the
mathlib TODO at `Mathlib/Algebra/Homology/Embedding/StupidTrunc.lean` lines 19-20. -/
noncomputable def stupidTruncInclusion [e.IsTruncGE] : K.stupidTrunc e ⟶ K where
  f i' := K.stupidTruncInclusion_f e i'
  comm' i' j' h_rel := by
    by_cases hi : ∃ i, e.f i = i'
    · obtain ⟨i, rfl⟩ := hi
      obtain ⟨j, rfl⟩ : ∃ j, e.f j = j' := e.mem_next h_rel
      rw [K.stupidTruncInclusion_f_eq e rfl, K.stupidTruncInclusion_f_eq e rfl]
      dsimp [stupidTrunc]
      rw [(K.restriction e).extend_d_eq e rfl rfl]
      simp [stupidTruncXIso, restriction]
    · exact (K.isZero_stupidTrunc_X e i' (by simpa using hi)).eq_of_src _ _
```

Cell-wise: in the image of `e.f` it is `stupidTruncXIso.hom`; outside the image it is the zero
morphism. Commutation in `IsTruncGE` uses that `c'.Rel i' j'` with `i'` in the image forces
`j'` in the image (`e.mem_next`). The off-image case discharges via `IsZero` of the source.

Auxiliary helpers landed:

- `stupidTruncXIso_hom_eq_of_eq` — well-definedness of `stupidTruncXIso.hom` across choice of
  witness `i₁, i₂ : ι` for `e.f · = i'` (via injectivity of `e.f`); avoids the `Classical.choose`
  vs explicit-witness mismatch.
- `stupidTruncInclusion_f_eq_of_mem` — cell-level formula at an in-range cell.
- `stupidTruncInclusion_f_eq_zero` — cell-level formula at an out-of-range cell.
- `stupidTruncMap_stupidTruncInclusion` — naturality of the inclusion w.r.t. morphisms of
  complexes (commutes with `stupidTruncMap φ e`).
- `ComplexShape.Embedding.stupidTruncInclusionNatTrans` — the natural transformation
  `e.stupidTruncFunctor C ⟶ 𝟭 _` packaging the per-complex inclusion (the precise content of
  Joël Riou's TODO line).

### Z2b-B — `cutoffColumns_inclusion`

```lean
noncomputable def cutoffColumns_inclusion (p : ℤ) :
    K.cutoffColumns p ⟶ K :=
  HomologicalComplex.stupidTruncInclusion K (ComplexShape.embeddingUpIntGE p)
```

The user-facing bicomplex-level filtration inclusion, defined by direct application of
`stupidTruncInclusion` to the column embedding. Cell formulas:

- `cutoffColumns_inclusion_f_of_le` (for `p ≤ p'`): `= cutoffColumns_XIso_of_le hp .hom`.
- `cutoffColumns_inclusion_f_of_lt` (for `p' < p`): `= 0`.

### Z2b-C — `cutoffColumns_succ` (filtration step)

```lean
noncomputable def cutoffColumns_succ (p : ℤ) :
    K.cutoffColumns (p + 1) ⟶ K.cutoffColumns p where
  f p' :=
    if hp : p + 1 ≤ p' then
      (K.cutoffColumns_XIso_of_le hp).hom ≫
        (K.cutoffColumns_XIso_of_le (show p ≤ p' by lia)).inv
    else 0
  comm' p' p'' h := ...
```

The filtration step inclusion is constructed directly with cell components that compose the two
cell isos `(p + 1, p') ⤳ (p, p')`. Commutation uses the two inclusion naturalities (at `p + 1`
and at `p`) chained via a four-step `calc` block; the off-range case discharges via `IsZero` of
the source.

Cell formulas (`cutoffColumns_succ_f_of_le`, `cutoffColumns_succ_f_of_lt`) and the universal-
property compatibility `cutoffColumns_succ_inclusion`:

```lean
@[reassoc (attr := simp)]
lemma cutoffColumns_succ_inclusion (p : ℤ) :
    K.cutoffColumns_succ p ≫ K.cutoffColumns_inclusion p =
      K.cutoffColumns_inclusion (p + 1)
```

This characterises `cutoffColumns_succ` as the unique factorisation of the `(p + 1)`-inclusion
through the `p`-inclusion (which is what is needed downstream in Z2c when constructing the
filtration triple quotients).

### Z2b-D — `cutoffColumns_to_singleColumnAt` (quotient projection)

```lean
noncomputable def cutoffColumns_to_singleColumnAt (p : ℤ) :
    K.cutoffColumns p ⟶ K.singleColumnAt p where
  f p' :=
    if h : p' = p then
      eqToHom (by rw [h]) ≫ K.cutoffColumns_to_singleColumnAt_f_self p ≫
        eqToHom (by rw [h])
    else 0
  comm' p' p'' h := ...
```

The cell-level projection onto the single-column bicomplex, with the helper
`cutoffColumns_to_singleColumnAt_f_self` packaging the at-`p` substantive cell hom
`(cutoffColumns_XIso_of_le (le_refl p)).hom ≫ (singleColumnAt_XIso_self p).inv`.

Cell formulas (`cutoffColumns_to_singleColumnAt_f_at_self`,
`cutoffColumns_to_singleColumnAt_f_of_ne`).

### Z2b-E — Bicomplex s.e.s. middle-position composition-zero

```lean
@[simps!]
noncomputable def cutoffColumns_succ_singleColumnAt_shortComplex (p : ℤ) :
    ShortComplex (HomologicalComplex₂ C (ComplexShape.up ℤ) c₂) :=
  ShortComplex.mk (K.cutoffColumns_succ p) (K.cutoffColumns_to_singleColumnAt p) (by
    ext p' ...)
```

The `ShortComplex` packaging the s.e.s. with the load-bearing middle-position vanishing
identity `cutoffColumns_succ ≫ cutoffColumns_to_singleColumnAt = 0`. The proof discriminates
on `p' = p` vs `p' ≠ p`:

- `p' = p`: source `(cutoffColumns (p + 1)).X p` is `IsZero` (cut-off cell at the column below
  the cutoff), so the composite trivially vanishes.
- `p' ≠ p`: target component `(cutoffColumns_to_singleColumnAt p).f p'` is the zero morphism.

This is the substantive middle-position primitive needed for the Z2c snake-lemma-based δ-data
on the triple filtration quotients.

### Non-vacuous evaluation (8 examples)

Four Z2a-baseline evaluations preserved verbatim, plus four new Z2b non-vacuous evaluations on
`ModuleCat ℚ`-valued bicomplexes:

1. `(K.cutoffColumns_inclusion 0).f 2 = (K.cutoffColumns_XIso_of_le _).hom` — non-zero cell
   morphism via the new inclusion-cell-formula.
2. `(K.cutoffColumns_inclusion 5).f 2 = 0` — out-of-range zero.
3. `stupidTruncInclusion K (embeddingUpIntGE 0) = K.cutoffColumns_inclusion 0` (by `rfl`) —
   definitional consistency of the bicomplex inclusion via the mathlib-PR-clean primitive.
4. `(K.cutoffColumns_succ 0).f 3 = XIso_of_le hp .hom ≫ XIso_of_le hp' .inv` — non-zero cell
   for the filtration step.
5. `(K.cutoffColumns_succ 4).f 3 = 0` — out-of-range zero for the filtration step.
6. `(K.cutoffColumns_to_singleColumnAt 0).f 5 = 0` — zero off the kept column.
7. The s.e.s. composition-zero invoked on `K.cutoffColumns_succ_singleColumnAt_shortComplex 0`
   — non-vacuous packaging of the substantive s.e.s. middle-position primitive.

Each is genuinely non-trivial — the cell hom is the explicit `stupidTruncXIso.hom`, NOT the
zero morphism or a placeholder, in the positive cases.

## What is deferred — Z2c named follow-on (Phase B + Phase C)

The substantive `SpectralObject (HomologicalComplex C c₁₂) EInt` construction (deliverable 3
of scoping doc §Z2) and `IsFirstQuadrant` instance (deliverable 4) are honest follow-on **Z2c**
sub-tickets per the pre-authorised sub-split contingency, sized for a focused short next-session
~250-300k tokens budget.

### Z2c-A — Quotient functor `F^i / F^j` for `i ≤ j` in `EInt`

The H-functor needs to take `mk₁ (homOfLE (h : i ≤ j))` for `i, j : EInt = WithBotTop ℤ` to a
chain complex realising `H^n(F^i (K.total) / F^j (K.total))`. This requires:

- Extending the `cutoffColumns` construction from `ℤ` to `EInt`: at `⊥` we have `F^{-∞} = K.total`,
  at `⊤` we have `F^{+∞} = 0`, and for integers `p : ℤ`, `F^p = K.cutoffColumns p`.
- Defining the quotient `F^i / F^j` via the cokernel of the iterated filtration step inclusions
  `F^j ↪ … ↪ F^{i+1} ↪ F^i` (which exists because mathlib has cokernels in
  `HomologicalComplex C c₁₂` whenever `C` is abelian + has the relevant limits — see
  `HomologicalComplex.HasCokernels`).
- Verifying functoriality in `mk₁ (homOfLE _)`: for `(i, j) ⟶ (i', j')` (with `i' ≤ i` and
  `j' ≤ j`), the induced quotient morphism `F^i / F^j → F^{i'} / F^{j'}` comes from the
  inclusion `F^j → F^{j'}` (when `j' ≤ j`) composed appropriately.

The Z2b-landed `cutoffColumns_succ` + `cutoffColumns_inclusion` + the s.e.s. composition-zero
primitive are the building blocks for this.

### Z2c-B — δ via snake lemma on triple filtration quotients

For `i ≤ j ≤ k` in `EInt`, the s.e.s. of triple filtration quotients
`0 ⟶ F^j / F^k ⟶ F^i / F^k ⟶ F^i / F^j ⟶ 0` induces a long exact sequence in cohomology
(via `HomologicalComplex.HomologySequence.snake_lemma` or equivalent mathlib API), yielding
the δ-map `H^n(F^i / F^j) → H^{n+1}(F^j / F^k)`.

The s.e.s. itself is the composition-zero-extended-to-full-exactness of the Z2b-landed
short complex (`ShortComplex.ShortExact` requires additionally `mono f + epi g`). The mono of
`cutoffColumns_succ` is cell-wise from the cell formulas (in-range → iso → mono; out-of-range
→ zero source). The epi of `cutoffColumns_to_singleColumnAt` is similarly cell-wise.

### Z2c-C — Three SpectralObject exactness conditions

The three exactness conditions `exact₁', exact₂', exact₃'` of the `SpectralObject` structure
(`H^{n}(g) ⟶ H^{n+1}(f) ⟶ H^{n+1}(f ≫ g)`, etc.) follow from the LES of cohomology on the
triple filtration s.e.s., via standard `mathlib.Algebra.Homology.HomologySequence` machinery.

### Z2c-D — `IsFirstQuadrant`

For a first-quadrant bicomplex `K` (supported in `(p, q)` with `p ≥ 0`, `q ≥ 0`), the
spectral object satisfies `IsFirstQuadrant`'s two vanishing conditions:

- `isZero₁`: `IsZero ((Y.H n).obj (mk₁ (homOfLE hij)))` for `i ≤ j ≤ 0` — because
  `F^i (K.total) = K.total` for `i ≤ 0` (no cells contribute beyond the first quadrant
  support), so `F^i / F^j = 0`.
- `isZero₂`: `IsZero ((Y.H n).obj (mk₁ (homOfLE hij)))` for `n < i` — because
  `F^i (K.total).X n = 0` (only summands with column index `≥ i` contribute, and they need
  column index `≤ n < i`, contradiction).

Both follow from the cell-level `cutoffColumns_isZero_X_of_lt` lemma + the total-complex
coproduct structure.

## Build

`lake build` GREEN (2043 jobs, unchanged baseline; the additional file deps introduced by the
`ShortComplex.ShortExact` import are absorbed into the existing transitive closure). Sorry count
stays at 1 (the pre-existing Y6 chain-map-extension residual at
`UnionClosed/UC11/SSConvergence.lean:563`, unchanged from Lean-Session 38). Pre-existing
`push_neg` deprecation warnings in `Frankl.lean` unchanged.

Zero new sorrys / axioms / fake mathlib API / defeq tricks / `False.elim` / `decide` shortcuts
in `Bicomplex.lean`.

## Acceptance bar (per scoping doc §0 + §Z2 + Z2b ticket)

| Bar | Status | Note |
|-----|--------|------|
| 1. `lake build` GREEN | ✅ | 2043 jobs (unchanged) |
| 2. Non-vacuous (tensor → SpectralObject H/δ eval) | ◐ AMBER | 4 new Z2b cell-level evaluations land substantively (genuine non-zero cell isos for the inclusion + filtration step + the s.e.s. composition-zero); SpectralObject H/δ evaluation is part of Z2c |
| 3. Mathlib-PR-clean naming, docstrings, Joël-Riou-style | ✅ | Full module docstring extended for Z2b + per-declaration docstrings; Riou + Morrison attribution preserved; `stupidTruncInclusion` is a definitive Joël Riou TODO closure |
| 4. Zero new sorrys | ✅ | None added |
| 5. Zero new axioms | ✅ | None |
| 6. No fake mathlib API | ✅ | Only existing primitives (`stupidTrunc`, `stupidTruncXIso`, `extendXIso`, `extend_d_eq`, `embeddingUpIntGE`, `restriction`, `IsTruncGE.mem_next`, `IsZero.eq_of_src`, `eqToHom`, `ShortComplex.mk`) |
| 7. No defeq bypass on s.e.s. exactness | ✅ | The composition-zero is proven via genuine cell case analysis using `IsZero.eq_of_src` for one branch and `f_of_ne` for the other; not a `rfl` bypass |
| 8. No `False.elim` shortcuts | ✅ | None |
| 9. Type-correct | ✅ | No metavariable cheats |
| 10. MATHLIB-FOLDER scope respected | ✅ | Only `Bicomplex.lean` touched (extended Z2a's existing file) |
| 11. Feeds-into-Z3 readiness | ◐ AMBER | Phase A bicomplex-side filtration inclusion + step + s.e.s. composition-zero land substantively as the building blocks Z2c needs; SpectralObject + IsFirstQuadrant are Z2c follow-on |
| 12. No L+X+Y dependencies | ✅ | Only new mathlib import is `ShortComplex.ShortExact` (already in transitive closure) |

## Engineering choices

**Choice 1: Land Phase A as the substantive Z2b delivery; defer Phase B+C to Z2c.** The original
Z2b scope (deliverables 3 + 4) requires constructing a full `SpectralObject (HomologicalComplex
C c₁₂) EInt` with H-functor + δ via snake lemma + three exactness axioms — this is genuinely
multi-thousand-line Lean code (the Verdier-style construction with quotient functoriality across
`EInt = WithBotTop ℤ`, the snake-lemma application, and three exactness verifications via the
LES of cohomology). Honestly fitting this in a 300k-token single-session budget is not feasible
given the cell-level eqToHom plumbing pattern observed in Z2a (where similar challenges arose).
The pattern matches the Z1 → Z1b precedent (mg-4165 → mg-a298): the first ticket lands the
substantive primitive, the follow-on closes the typeclass-synthesis-style remaining piece. Z2b
delivers the inclusion + step + s.e.s. composition-zero (Phase A) substantively, and Z2c
delivers the SpectralObject axiomatic construction (Phase B + C) in a focused short next session.

**Choice 2: Close Joël Riou's mathlib `stupidTruncInclusion` TODO inline.** Rather than working
around the missing inclusion morphism with a downstream-specific construction, we close the
documented TODO at `Mathlib/Algebra/Homology/Embedding/StupidTrunc.lean` lines 19-20 directly.
This produces a definitively mathlib-PR-clean primitive that lives naturally in the upstream
`StupidTrunc.lean` (i.e., this code is publishable as-is to mathlib, modulo the local-only
directive). The construction handles both branches (in-range and out-of-range) with the natural
`IsTruncGE.mem_next` argument for commutation.

**Choice 3: Explicit `cutoffColumns_succ` via cell-by-cell construction rather than
`stupidTruncMap`.** A naive approach would lift the `cutoffColumns_inclusion (p + 1)` morphism
through the embedding to land in `K.stupidTrunc (embeddingUpIntGE p)`, but this requires building
a `stupidTruncMap`-like construction for the source embedding. The direct cell-by-cell
construction with `cutoffColumns_XIso_of_le ∘ cutoffColumns_XIso_of_le⁻¹` is cleaner and the
commutation proof is a clean four-step `calc` using the two inclusion naturalities.

**Choice 4: `stupidTruncXIso_hom_eq_of_eq` helper to bridge `Classical.choose` witnesses with
explicit witnesses.** The cell formula `stupidTruncInclusion_f_eq` requires comparing the iso
arising from `h.choose_spec` (where `h : ∃ i, e.f i = i'`) with the iso arising from a
user-supplied explicit witness `i` with `e.f i = i'`. Since `e.f` is injective, the two witnesses
agree as elements of `ι`, but the proofs are propositionally distinct. The helper lemma
`stupidTruncXIso_hom_eq_of_eq` uses `obtain rfl` to substitute the witnesses and reduce to `rfl`
on the iso's `.hom` component, which works because the underlying `extendXIso ∘ eqToIso` is
proof-irrelevant on the proof of `e.f i = i'`.

**Choice 5: Cell projection `cutoffColumns_to_singleColumnAt` via `eqToHom`-wrapped cell hom.**
The single-column bicomplex's `.X p'` is defined via `if p' = p then K.X p else 0`, which is
not definitionally equal to `K.X p'` for the `p' = p` branch. The projection's cell hom at
`p' = p` is therefore wrapped with `eqToHom` transport to bridge the propositional equality.
This is the standard Lean idiom for `if`-discriminated bicomplex cells and matches mathlib
conventions.

## Hard constraints (per ticket §"Hard constraints")

- Math-first per pm-onethird `feedback_latex_first_for_math_simp` ✅ — the file follows
  Verdier's standard textbook construction of the canonical filtration on the total complex.
- Mathlib-PR-CLEAN code style despite local-only directive ✅ — Joël Riou style with full
  docstrings, Riou + Morrison attribution preserved in file header, mathlib-PR-CANDIDATE marker
  in docstring. The `stupidTruncInclusion` portion is a definitive closure of an upstream TODO
  and is publishable to mathlib as-is.
- NOT factorial / NOT functorial-in-refinement / U1-dialect preserved ✅ — purely additive
  homological-algebra construction; no Specht modules, no cup-product structure.
- mathlib-folder authorization respected ✅ — only `lean/UnionClosed/Mathlib/Algebra/Homology/
  SpectralObject/Bicomplex.lean` modified (extended Z2a's existing file).
- Joël Riou attribution in commit message + file header per `project_z_arc_local_only` rule 2 ✅.
- Sub-split engaged HONESTLY per pre-authorisation: Z2b substantive Phase A (inclusion + step +
  s.e.s. composition-zero) lands GREEN; Z2c (SpectralObject + IsFirstQuadrant) is named
  follow-on with construction sketches.

## Files touched

- MODIFIED `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/Bicomplex.lean` (~250 →
  ~750 lines; extends Z2a's existing file).
- NEW `docs/state-UC-Lean-Z2b.md` (this file).
- MODIFIED `docs/state-UC10.md` (Lean-Session 39 entry).

## Non-vacuous status

`Frankl_Holds` non-vacuous status unchanged (Z arc has not yet touched Frankl-level objects).
`Frankl_Holds_fullPowerset3` + `Frankl_Holds_fullPowerset4` continue to build GREEN via concrete
L4 minimal-element witnesses.

## Strictly tighter than mg-3ff1 (Z2a AMBER)

mg-3ff1 substantively landed Z2a deliverables 1 + 2 (`cutoffColumns`, `singleColumnAt`,
`filtrationOnTotal`, `grOnTotal`) + 4 cell-iso/zero structural lemmas + 4 non-vacuous evaluations.
This Z2b delivery extends with:

- The `stupidTruncInclusion` mathlib-TODO closure (the missing primitive Z2a noted as Z2b-A).
- The bicomplex filtration inclusion `cutoffColumns_inclusion` (Z2b-A in Z2a's deferred plan).
- The filtration step `cutoffColumns_succ` (Z2b-B in Z2a's deferred plan).
- The s.e.s. composition-zero via `cutoffColumns_to_singleColumnAt` + `ShortComplex` packaging
  (Z2b-C in Z2a's deferred plan).
- 4 new non-vacuous evaluations using the new primitives.

The remaining Z2b-D (`HomologicalComplex₂.spectralObject K : SpectralObject ... EInt`) and Z2b-E
(`IsFirstQuadrant` instance) — the substantive Verdier construction — are now strictly tighter
named as Z2c with concrete primitives in place. Z2c consumes Z2b's `cutoffColumns_inclusion`,
`cutoffColumns_succ`, `cutoffColumns_succ_inclusion` factorisation, and the
`cutoffColumns_succ_singleColumnAt_shortComplex` composition-zero packaging as building blocks.

## Forward operational step

Z2c (`UC-Lean-Z2c-BicomplexSpectralObjectVerdier`) dispatches as the next sequential execution
ticket per Phase C critical path Z2 → Z3 → (Z4 ∥ Z5) → Z6 → Z7 → Z8 → Z9 → Z10. Z2c consumes
the Z2b-supplied `cutoffColumns_inclusion` + `cutoffColumns_succ` + `cutoffColumns_succ_inclusion`
+ `cutoffColumns_succ_singleColumnAt_shortComplex` infrastructure to close out the substantive
Verdier `SpectralObject` construction (quotient functor + δ via snake lemma + three exactness
conditions via LES) + `IsFirstQuadrant` instance.
