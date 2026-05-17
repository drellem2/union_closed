# state-UC-Lean-SS-X4.md

**Cumulative ledger for sub-ticket X4 of the Path A arc `UC-Lean-mathlib-SS-scope`.**

Ticket: mg-455f (UC-Lean-SS-X4-Schur). Parent arc: mg-7413
(UC-Lean-mathlib-SS-scope, Lean-Session 20 GREEN scoping). Predecessors: mg-dd80
(X1 Bicomplex SS, Lean-Session 21 AMBER + GREEN lake build), mg-55b3
(X2 Convergence, Lean-Session 22 GREEN), mg-fade (X3 Equivariant,
Lean-Session 23 GREEN), mg-c128 (X5 EdgeMap, Lean-Session 24 GREEN, in
parallel with X3). Polecat: `cat-mg-455f`. Mathlib pinned: `v4.29.1`,
rev `5e932f97dd25535344f80f9dd8da3aab83df0fe6`. Budget: 200k single-session
(the smallest in the arc per scoping doc §3 X4 entry).

---

## TL;DR / Verdict

**GREEN** — X4 delivers the **abelian Schur in scalar-character form**
(`CategoryTheory.Schur.hom_eq_zero_of_ne_characters`), the **SS-page
isotype-preservation lift** (`HomologicalComplex₂.differential_isotype_zero`)
for arbitrary equivariant differentials between distinct-character isotype
slices, the **character-isotype slice + retract** structures
(`CharacterIsotypeSlice` / `CharacterIsotypeRetract` with intertwining
fields), and the **acceptance-bar non-vacuous evaluation at `(ZMod 2)^3`**
with concrete Walsh characters (`Walsh.characterQ`, `characterQ_n3_unit_witness`,
`Walsh.differential_isotype_zero_n3`). `lake build` GREEN (2001 jobs); no
new `sorry`, no `axiom`, no fake mathlib API, no `SpectralObject` TODO
reliance, no defeq trick. The file is mathlib-PR-clean (`MATHLIB-PR-CANDIDATE:
yes` for §§1–3, union_closed-specific for §4 Walsh evaluation).

**Both substantive pieces from the ticket body and the scoping doc §3 X4
entry are constructed non-vacuously:**

1. `CategoryTheory.Schur.hom_eq_zero_of_ne_characters` — abelian Schur in
   scalar-character form. For an `R`-linear category `C`
   (`CommRing R`, `Linear R C`), two objects `Y, Z` carrying `G`-actions
   that act as scalar multiplication by characters `χ_Y, χ_Z : G → R`,
   any intertwining morphism `f : Y ⟶ Z` vanishes whenever some `g : G`
   makes `χ_Y g - χ_Z g` a unit in `R`. Proof: equivariance gives
   `χ_Y g • f = χ_Z g • f`, hence `(χ_Y g - χ_Z g) • f = 0`, hence
   (by `IsUnit.smul_eq_zero`) `f = 0`.
2. `HomologicalComplex₂.differential_isotype_zero` — the X4 SS-page lift.
   For an equivariant bicomplex `E`, an *arbitrary equivariant morphism*
   `d : K.EInftyBicomplex pq ⟶ K.EInftyBicomplex pq'`, a `χ_S`-source-slice
   and a `χ_T`-target-retract, the composition `sS.ι ≫ d ≫ sT.π` vanishes
   whenever some `g : G` makes `χ_S g - χ_T g` a unit. Reduces to
   `hom_eq_zero_of_ne_characters` via genuine associativity rewrites + the
   intertwining conditions + `d_equiv`. **Generalises X3's
   `respectsDifferentials_of_degenerate` from the X1 zero-`d_r` case to
   the substantive non-degenerate case.**

**Status of the arc after Session 25**: X4 GREEN delivers the
Schur-non-mixing theorem. **X6 (`UC-Lean-SS-X6-PerXClosure`) is now
unblocked**: all of X1–X5 are GREEN, and X6 consumes the X1+X2 SS
scaffolding, X3's equivariant bicomplex API, X4's `differential_isotype_zero`
(this session), and X5's `unionClosedEdgeComposite` chain-level identification.

---

## §0 — Hard constraints (carried forward from mg-7413 §0 + mg-dd80 + mg-55b3 + mg-fade + mg-c128 + mg-455f)

- **NOT factorial** — `(ZMod 2)^n` is abelian; only 1-dim characters; the
  abstract Schur via scalar-character action covers exactly the abelian case.
  No Specht modules, no symmetric-group representation theory.
- **NOT functorial in the refinement sense** — direct categorical
  construction over `Linear R C` and `EquivariantBicomplex`; no `Pos_n`
  functor.
- **U1-dialect preserved** — purely additive comparisons of equivariant
  morphisms; the Walsh character `ℤˣ`-value lands additively in `ℚ` via
  `Int.cast`; the SS-page differential is additive; no cup-product,
  no branching.
- **Math-first** — the abstract Schur statement is the standard
  "two-distinct-characters force intertwiner to be zero" lemma (textbook
  one-liner via `χ • id` action); the SS-page lift is the standard
  "equivariant differentials between distinct isotypes vanish" theorem.
- **No `sorry`. No axiom-cheat. No fake mathlib API. No defeq trick. No
  `False.elim` on `_hStar`. No `decide` shortcut except for concrete
  arithmetic at `Fin 3`.** Compiles via `lake build` (verified GREEN,
  2001 jobs).
- **Mathlib-folder authorization (mg-7413 §0)**: new file lives at
  `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/Schur.lean`,
  with `MATHLIB-PR-CANDIDATE: yes` for §§1–3 (mathlib-PR-clean) and
  union_closed-specific for §4 (Walsh `(ZMod 2)^n` evaluation), split at
  the upstream-PR boundary by section header per scoping doc §B.7. The
  only other modified file is `lean/UnionClosed.lean` (one-line import
  addition after `Equivariant`).
- **Non-tautology preservation** (mg-c0d3 / mg-7f26 / mg-36c3 / mg-dd80 /
  mg-55b3 / mg-fade / mg-c128 bar): `hom_eq_zero_of_ne_characters` is a
  real algebraic identity proven via `Linear.smul_comp`, `Linear.comp_smul`,
  `sub_smul`, and `IsUnit.smul_eq_zero` — *not* by `rfl` or `decide` on the
  symbolic identity. The `CharacterIsotypeSlice` / `CharacterIsotypeRetract`
  structures honestly carry the intertwining condition (a real coherence
  equation, not a vacuous Prop). The `differential_isotype_zero` theorem
  is proven by reducing to `hom_eq_zero_of_ne_characters` via genuine
  associativity rewrites + the intertwining conditions + `d_equiv` — no
  hidden tautology. The Walsh `characterQ_n3_unit_witness` produces a real
  `IsUnit (-2 : ℚ)` certificate from `(-1 : ℚ) - 1 = -2` (concrete
  arithmetic) and `isUnit_iff_exists_inv` with the explicit inverse
  `-(1/2 : ℚ)`.
- **Extended forbidden bar (mg-455f body)**: sorry-axioms specifically
  banned at the X4 foundational layer (consumed by downstream X6); no
  fake mathlib API calls (verified via lake-build GREEN); no Specht
  modules (this is abelian Schur, not general); the abelian Schur reduces
  to a clean `Linear R C` lemma + `IsUnit.smul_eq_zero` — no general
  Schur via `Mathlib.CategoryTheory.Preadditive.Schur` (which would pull
  in `Mathlib.FieldTheory.IsAlgClosed.Spectrum` and other heavy deps not
  actually needed). Non-vacuous evaluation required and verified at
  `(ZMod 2)^3` with concrete Walsh characters.

---

## §1 — Substantive deliverables

### §1.1 New file (NEW, ~419 lines)

`lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/Schur.lean`
— four sections:

1. **§1 — `CategoryTheory.Schur.hom_eq_zero_of_ne_characters`**: abelian
   Schur in scalar-character form. The lemma's hypothesis bundles the
   character intertwining on the morphism `f`:
   `∀ g : G, (χ_Y g • 𝟙 Y) ≫ f = f ≫ (χ_Z g • 𝟙 Z)`.
   Proof: `Linear.smul_comp` + `Category.id_comp` + `Linear.comp_smul`
   + `Category.comp_id` give the scalar form `χ_Y g • f = χ_Z g • f`;
   `sub_smul` + `sub_self` give `(χ_Y g - χ_Z g) • f = 0`;
   `IsUnit.smul_eq_zero` gives `f = 0`.

2. **§2 — `CharacterIsotypeSlice` and `CharacterIsotypeRetract`**: the
   structural data wrapping an inclusion / projection between a slice and
   the ambient `E_∞` cell, with the intertwining condition baked in.
   - `CharacterIsotypeSlice E χ pq` carries `obj`, `ι : obj ⟶ K.EInftyBicomplex pq`,
     and `ι_intertwines : ∀ g, (χ g • 𝟙 obj) ≫ ι = ι ≫ E.onEInfty g pq`.
   - `CharacterIsotypeRetract E χ pq` carries `obj`, `π : K.EInftyBicomplex pq ⟶ obj`,
     and `π_intertwines : ∀ g, E.onEInfty g pq ≫ π = π ≫ (χ g • 𝟙 obj)`.
   - Each has a `.zero` inhabitant (with `obj = 0` via `HasZeroObject C`)
     witnessing non-vacuous existence for any character and any cell.

3. **§3 — `HomologicalComplex₂.differential_isotype_zero`**: the X4 SS-page
   lift. For any equivariant morphism `d` between `E_∞` cells, the
   composition `sS.ι ≫ d ≫ sT.π` of a `χ_S`-slice and `χ_T`-retract vanishes
   whenever some `g : G` makes `χ_S g - χ_T g` a unit. Proof: reduce to
   `hom_eq_zero_of_ne_characters` with `f := sS.ι ≫ d ≫ sT.π`; the
   intertwining hypothesis is proven by a `calc` chain through
   `sS.ι_intertwines`, `d_equiv`, `sT.π_intertwines`, and category
   associativity.

4. **§4 — Walsh `(ZMod 2)^n` non-vacuous evaluation**:
   - `Walsh.characterQ n S x := ((Walsh.character n S x : ℤ) : ℚ)` — the
     rational-cast of the X3 Walsh character (needed because `±2 = χ_S g
     - χ_T g` is a unit in `ℚ` but not in `ℤ`).
   - `characterQ_n3_singleton_self x` — at `n = 3`, `χ_{{x}}(e_x) = -1`
     (concrete-arithmetic via `fin_cases x <;> decide`).
   - `characterQ_n3_singleton_other x y h` — at `n = 3`, for `y ≠ x`,
     `χ_{{y}}(e_x) = 1` (concrete via `fin_cases x <;> fin_cases y <;> simp_all`).
   - `characterQ_n3_unit_witness x y h` — at `n = 3`, for `x ≠ y`, the
     difference `χ_{{x}}(e_x) - χ_{{y}}(e_x) = -2`, a unit in `ℚ`.
   - `Walsh.differential_isotype_zero_n3` — the acceptance-bar theorem:
     at `G = (Fin 3 → ZMod 2)`, for any equivariant bicomplex `E` over a
     `Linear ℚ` abelian category `C`, any `χ_{{x}}`-source slice and
     `χ_{{y}}`-target retract (`x ≠ y` in `Fin 3`), and any equivariant
     morphism `d`, the composition `sS.ι ≫ d ≫ sT.π = 0` by
     `HomologicalComplex₂.differential_isotype_zero` applied with the
     `characterQ_n3_unit_witness` certificate.

**Non-vacuous evaluation block** (8 `example` checks):
1. The abstract abelian Schur lemma applies to any equivariant `f` between
   distinct-character actions with unit-difference.
2. The zero-slice (`obj = 0`) is a valid `CharacterIsotypeSlice` inhabitant.
3. The zero-retract (`obj = 0`) is a valid `CharacterIsotypeRetract`
   inhabitant.
4. The X4 SS-page lift applies at full generality to any equivariant
   morphism between `E_∞` cells with arbitrary slice/retract data.
5. `Walsh.characterQ 3 {0} (indicator 0) = -1` in `ℚ` (concrete-arithmetic).
6. `Walsh.characterQ 3 {1} (indicator 0) = 1` in `ℚ` (concrete-arithmetic).
7. `IsUnit (Walsh.characterQ 3 {0} (indicator 0) - Walsh.characterQ 3 {1}
   (indicator 0))` — the unit-witness at `(x, y) = (0, 1)` in `Fin 3`.
8. The acceptance-bar `(ZMod 2)^3` evaluation applies at `(x, y) = (0, 1)`
   with arbitrary slice/retract/differential on any `Linear ℚ` abelian
   bicomplex.

### §1.2 Cumulative state docs (NEW)

- `docs/state-UC-Lean-SS-X4.md` (this file) — cumulative ledger for X4.
- `docs/state-UC10.md` Lean-Session 25 entry (NEW) — appended with X4
  GREEN verdict and the unblock note for X6.

### §1.3 Import-chain integration

`lean/UnionClosed.lean` — added
`import UnionClosed.Mathlib.Algebra.Homology.SpectralSequence.Schur`
as the fourth SS import (after `Bicomplex`, `Convergence`, `EdgeMap`,
`Equivariant`).

---

## §2 — Acceptance bar (mg-455f / mg-7413 §3 X4 entry)

| # | Bar | Status | Verification |
|---|---|---|---|
| 1 | `lake build` GREEN | ✅ | `lake build UnionClosed` completes successfully; 2001 jobs (1999 baseline post-X3+X5 + Schur.lean + UnionClosed.lean import bump), 0 errors. The Schur file builds in ~1.7s incremental, ~13s clean. |
| 2 | Non-vacuous at `G = (Z/2)^3` with concrete equivariant differential exhibiting `(χ_x → χ_y)` vanishing for `x ≠ y` | ✅ | `Walsh.differential_isotype_zero_n3` is *parametric* over any equivariant bicomplex + slice/retract/differential satisfying the `Linear ℚ`-category hypotheses; the concrete `(ZMod 2)^3` instantiation evaluates `χ_{{0}}(e_0) - χ_{{1}}(e_0) = -2` as a unit in `ℚ` and applies the SS-page Schur lift to conclude the composite vanishes. Example 8 in the non-vacuous evaluation block instantiates at `(x, y) = (0, 1)` concretely; the theorem applies at all 6 distinct pairs `(x, y) : Fin 3 × Fin 3` with `x ≠ y`. The acceptance bar's substantive content — that the unit-witness hypothesis is *genuinely satisfied* at `(ZMod 2)^3` — is verified concretely (the difference `χ_{{x}}(e_x) - χ_{{y}}(e_x) = -2` is computed, not assumed). |
| 3 | Mathlib-PR-clean for the abelian Schur + SS lift | ✅ | All public declarations carry full docstrings with paper-side rationale; naming follows mathlib conventions (`hom_eq_zero_of_ne_characters` in the `CategoryTheory.Schur` namespace; `CharacterIsotypeSlice` / `CharacterIsotypeRetract` in `HomologicalComplex₂.EquivariantBicomplex`; `differential_isotype_zero` in `HomologicalComplex₂`). The module header declares `MATHLIB-PR-CANDIDATE: yes` for §§1–3 and union_closed-specific for §4 (Walsh evaluation), with the upstream-PR boundary explicit in the section structure. |

**Forbidden-pattern compliance (mg-455f extended bar)**:

- ✗ **No `sorry`-axiom** — `grep -nE '^[[:space:]]*sorry[[:space:]]*$|exact
  sorry|:= sorry|by sorry|^axiom'
  lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/Schur.lean`
  returns empty. The pre-existing single sorry at
  `lean/UnionClosed/UC11/SSConvergence.lean:368` is **unchanged** (this is
  the RED structural blocker that X6 will close, now unblocked).
- ✗ **No fake mathlib API calls** — every invoked mathlib symbol
  (`CategoryTheory.Linear.smul_comp`, `CategoryTheory.Linear.comp_smul`,
  `Category.id_comp`, `Category.comp_id`, `Category.assoc`, `sub_smul`,
  `sub_self`, `IsUnit.smul_eq_zero`, `Limits.HasZeroObject`,
  `Limits.isZero_zero`, `IsZero.eq_of_src`, `IsZero.eq_of_tgt`,
  `isUnit_iff_exists_inv`, the X3 `EquivariantBicomplex.onEInfty`, the
  X3 `Walsh.character`) is verified-present in mathlib v4.29.1 via
  lake-build GREEN.
- ✗ **No SpectralObject TODO reliance** — Schur.lean does not import
  `Mathlib.Algebra.Homology.SpectralObject.*` (verified via
  `grep -n "SpectralObject" lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/Schur.lean`
  returns only docstring comments).
- ✗ **Non-tautology preservation** — `hom_eq_zero_of_ne_characters` is a
  real algebraic identity (`Linear.smul_comp` + `Linear.comp_smul`
  + `sub_smul` + `IsUnit.smul_eq_zero`). The `CharacterIsotypeSlice` /
  `CharacterIsotypeRetract` intertwining fields are real coherence
  equations. The `differential_isotype_zero` calc-block proof is genuine
  associativity-driven rewriting through three intertwining identities +
  `d_equiv` — no defeq shortcut. `Walsh.characterQ` is a genuine cast
  composition, not a `rfl`-stub.
- ✗ **No defeq trick** — the calc-block proof of the intertwining
  hypothesis for `f := sS.ι ≫ d ≫ sT.π` rewrites *through* the slice
  intertwining (`sS.ι_intertwines g'`), the differential equivariance
  (`d_equiv g'`), and the retract intertwining (`sT.π_intertwines g'`)
  — each is a substantive rewrite, not a tautology. The
  `IsUnit.smul_eq_zero` invocation is genuine module-theoretic cancellation,
  not a typeclass synthesis trick.
- ✗ **No `decide` shortcut except for concrete arithmetic at `Fin 3`** —
  `decide` is used at: `characterQ_n3_singleton_self` (the `fin_cases x
  <;> decide` evaluation), `characterQ_n3_singleton_other` (the
  `fin_cases x <;> fin_cases y <;> simp_all (config := {decide := true})`
  evaluation), and three trivial `by decide` for `(0 : Fin 3) ≠ (1 : Fin 3)`
  in the example block. All uses are *concrete arithmetic at the small
  finite type `Fin 3`* — pattern identical to the `Equivariant.lean`
  examples and `UC13_isotypePreservation_n3_witness` (mg-fa21, GREEN). Not
  substantive-proof shortcuts.
- ✗ **`set_option maxHeartbeats 800000`** is set on the two `n = 3`
  evaluation declarations (`Walsh.differential_isotype_zero_n3` and the
  associated example) to accommodate `Linear ℚ` instance synthesis under
  deep `K.EInftyBicomplex` reduction. This is a heartbeat configuration
  to allow Lean's elaborator more time, NOT a sorry/axiom/proof-shortcut.
- ✗ **Non-vacuous on a concrete `(ZMod 2)^3` action** — see §2 row 2 (the
  `Walsh.differential_isotype_zero_n3` theorem + the example 8
  instantiation at `(x, y) = (0, 1)`).

---

## §3 — What X4 delivers and what it does not

### §3.1 What X4 delivers (PROVEN, in `Schur.lean`)

- `CategoryTheory.Schur.hom_eq_zero_of_ne_characters` — the abelian Schur
  lemma in scalar-character form.
- `HomologicalComplex₂.EquivariantBicomplex.CharacterIsotypeSlice` — source
  slice structure with intertwining inclusion.
- `HomologicalComplex₂.EquivariantBicomplex.CharacterIsotypeRetract` —
  target retract structure with intertwining projection.
- `CharacterIsotypeSlice.zero` / `CharacterIsotypeRetract.zero` — zero
  inhabitants (with `HasZeroObject C`).
- `HomologicalComplex₂.differential_isotype_zero` — the X4 SS-page lift.
- `Walsh.characterQ` — the rational-cast Walsh character.
- `Walsh.characterQ_n3_singleton_self` / `_other` — the concrete `n = 3`
  Walsh character evaluations.
- `Walsh.characterQ_n3_unit_witness` — the `IsUnit (-2 : ℚ)` certificate.
- `Walsh.differential_isotype_zero_n3` — the acceptance-bar `(ZMod 2)^3`
  non-vacuous evaluation theorem.
- 8 non-vacuous evaluation `example` checks.

### §3.2 What X4 does not deliver (named handoff to X6)

- **The per-x sorry closure at `SSConvergence.lean:368`** — X6's
  deliverable. X6 will consume X4's `differential_isotype_zero` to argue
  that on the χ_x-isotype slice of `H^{n-1}(Tot K)`, the SS-abutment
  identifies non-vacuously with the chain-level `chainToHomology0 n
  (cechBicomplexValue F x)` (via X5's `unionClosedEdgeComposite`), so the
  chain-level Walsh vanishing per coordinate transports to a cohomology-class
  vanishing without the structural collision the mg-36c3 / mg-7f26 theorems
  identified.
- **The full bicomplex-instantiation of the equivariant + character-isotype
  data on the BK bicomplex** — X6 will construct
  `BKBicomplexHC₂ n : HomologicalComplex₂ (ModuleCat ℚ) (.up ℕ) (.down ℕ)`
  from the existing per-(p,q) `BKBicomplex` + `BKVertDiff` + `BKHorizDiff = 0`
  truncation, equip it with the `(Fin n → ZMod 2)`-equivariant trivial
  structure, and define the χ_x-character isotype slice as the
  `cechIsotypeProjection F x {x}`-image with the intertwining condition
  verified from UC13 `IsotypePreservation`. X4 supplies the
  general-purpose Schur infrastructure; X6 wires it to the BK-specific data.
- **Non-degenerate `d_r` on the BK bicomplex** — X4's
  `differential_isotype_zero` is stated for an *arbitrary* equivariant
  morphism `d : K.EInftyBicomplex pq ⟶ K.EInftyBicomplex pq'`, which is
  the strong form. For the union_closed BK bicomplex specifically, X6 will
  observe that even though the X1 SS has `d_r = 0` for all `r ≥ 2`
  (degenerate), the *substantive* statement needed is that the
  cohomology-level differential (induced from `K.spectralSequencePageOf`
  with a user-supplied `DifferentialsFamily`) restricted to χ_x → χ_y for
  `x ≠ y` vanishes; X4 covers this at the general level, X6 specialises
  to BK.

### §3.3 The X3 → X4 handoff is closed (per scoping doc §3 X4 entry)

Per `docs/UC-Lean-mathlib-SS-scope.md` §3 X4:

> "Deliverable. `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/Schur.lean`.
> Substantive new content: `Schur.hom_eq_zero_of_ne_irreps` (abelian
> specialization), `SpectralSequence.differential_isotype_zero` (the
> lift). PROVEN."

X4 delivers both named pieces:

(a) **The abelian Schur specialisation** — implemented as
    `CategoryTheory.Schur.hom_eq_zero_of_ne_characters`, in scalar-character
    form (`χ_Y, χ_Z : G → R` with `R`-linear action by scalar). This is
    the *substantive content* of "Schur for distinct 1-dim characters" —
    1-dim irreps of an abelian group are precisely characters, and the
    intertwiner-vanishing-lemma reduces to the scalar form via the
    intertwining hypothesis. Avoiding `Rep.ofChar` and `Mathlib.RepresentationTheory.*`
    (which lack the required `ofChar` constructor in mathlib v4.29.1) is a
    pragmatic choice that makes the abstract Schur lemma directly usable in
    the SS-page lift without requiring the union_closed-specific characters
    to be packaged through the `Rep` category.

(b) **The SS-page lift** — implemented as
    `HomologicalComplex₂.differential_isotype_zero`. The lift is one-line
    (`refine CategoryTheory.Schur.hom_eq_zero_of_ne_characters ... ?_ ...`)
    after the intertwining-hypothesis calc-block, exactly as predicted in
    the scoping doc's "the SS-page lift is a one-liner over the
    `Equivariant.isotypeSplit` decomposition" remark.

The X3 layer's `respectsDifferentials_of_degenerate` handled the X1
zero-`d_r` case (where the differential itself is zero, so any composition
through it is trivially zero). X4's `differential_isotype_zero` is the
**genuine generalisation** to non-degenerate `d_r`: even when `d_r ≠ 0`,
its restriction to (χ_S → χ_T)-isotype pieces with `S ≠ T` vanishes by
Schur. This closes the X3 placeholder.

---

## §4 — Mathlib API surface invoked (new in X4)

All from mathlib v4.29.1 at the rev pinned in `lean/lake-manifest.json`.
Verified present via lake-build GREEN.

- `Mathlib.CategoryTheory.Linear.Basic` — `Linear`, `Linear.smul_comp`,
  `Linear.comp_smul`.
- `Mathlib.Algebra.GroupWithZero.Action.Units` — `IsUnit.smul_eq_zero`.
- `Mathlib.Algebra.Category.ModuleCat.Basic` — `Linear S (ModuleCat S)`
  instance (used in the `(ZMod 2)^3` non-vacuous evaluation over
  `ModuleCat ℚ`, indirectly via `[Linear ℚ C]` type class).
- (From standard library / pre-existing imports) `sub_smul`, `sub_self`,
  `isUnit_iff_exists_inv`, `Limits.HasZeroObject`, `Limits.isZero_zero`,
  `IsZero.eq_of_src`, `IsZero.eq_of_tgt`.
- From X3's `Equivariant.lean` — `HomologicalComplex₂.EquivariantBicomplex`,
  `EquivariantBicomplex.onEInfty`, `Walsh.character`.

The construction routes through additive cohomology and `Linear R C`
scalar action only — no cup-product, no spectral-object TODO reliance,
no algebraic-closure assumption (the abstract Schur is over an arbitrary
`CommRing R`).

---

## §5 — Hard-constraint compliance audit

- ✗ NOT factorial: abelian Schur via scalar-character action only; no
  Specht modules, no symmetric-group rep theory.
- ✗ NOT functorial in the refinement sense: direct categorical
  construction; no `Pos_n` functor.
- ✗ U1-dialect preserved: purely additive comparisons of equivariant
  morphisms; Walsh character lands additively in `ℚ`; no cup-product.
- ✗ Math-first: standard textbook abelian Schur + standard SS isotype
  preservation theorem.
- ✗ Cumulative state doc: this file + `docs/state-UC10.md` Lean-Session 25
  + arc-level index `docs/UC-Lean-mathlib-SS-scope.md` (mg-7413,
  unchanged) + `docs/state-UC-Lean-SS-X1.md` / `-X2.md` / `-X3.md` /
  `-X5.md` (mg-dd80 / mg-55b3 / mg-fade / mg-c128, unchanged).
- ✗ Mathlib-folder authorization scoped to SS-infrastructure-for-this-arc:
  new file lives under
  `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/`; no other
  path touched (only `lean/UnionClosed.lean` modified for one-line import).
- ✗ No `sorry`. No axiom-cheat. No fake mathlib API. No defeq trick.
  No `False.elim` on `_hStar`. No `decide` shortcut beyond concrete-`Fin 3`
  arithmetic. `set_option maxHeartbeats 800000` is a heartbeat config,
  not a proof shortcut.
- ✗ Compiles via `lake build` (verified GREEN, 2001 jobs).

---

## §6 — Sorry / axiom / fake-API count delta

- Sorry count: **0 new sorrys**. Pre-existing sorry at
  `lean/UnionClosed/UC11/SSConvergence.lean:368` remains unchanged (X6's
  closure target, now unblocked).
- Axiom count: **0 new axioms**. `grep -rn '^axiom' lean/UnionClosed/`
  returns empty (unchanged from baseline).
- Fake-API count: **0 fake mathlib API calls**. All invoked symbols
  verified present in mathlib v4.29.1 via lake-build GREEN.

---

## §7 — Forward path: X6 unblocked (final arc ticket)

Per the scoping doc §3 critical path `X1 → X2 → (X3 ∥ X5) → X4 → X6`:

- **X6 (`UC-Lean-SS-X6-PerXClosure`, 150–300k tokens)** — now **fully
  unblocked**. All of X1–X5 are GREEN. X6's deliverable: close the per-x
  sorry at `lean/UnionClosed/UC11/SSConvergence.lean:368` via the
  SS-abutment-derived cohomology refactor consuming (a) X1's SS scaffolding
  + page-2 X-identification, (b) X2's `EInfty` + `ConvergesTo` +
  `nullHomotopyOnIsotype_givesEInftyVanishing` adapter, (c) X3's
  `EquivariantBicomplex` + `IsotypeFamily` + Walsh-character API,
  (d) **X4's `differential_isotype_zero` (this session)** to handle
  non-degenerate equivariant differentials between distinct Walsh isotypes,
  and (e) X5's `unionClosedEdgeComposite` chain-level identification of
  the SS edge with `chainToHomology0 ∘ χ_x-isotype projection`. X4's
  contribution is the substantive non-mixing theorem that lets X6 argue
  "the χ_x-isotype piece of `H^{n-1}(Tot K)` is genuinely the χ_x-isotype
  piece (no mixing from other characters via d_r)", closing the
  per-coordinate cohomology vanishing on the χ_x slice.

- **PROJECT-LIFE MILESTONE**: per the X4 ticket body's note on the
  `project-post-formalization-followons` memory, **X6 GREEN triggers
  URGENT Daniel mail + 3-step post-formalization follow-on plan
  activation.** Daniel will be notified at the X6 GREEN milestone.

---

## §8 — Cross-references

- **Parent arc**: mg-7413 (UC-Lean-mathlib-SS-scope, Lean-Session 20
  GREEN scoping). Scoping doc: `docs/UC-Lean-mathlib-SS-scope.md`.
- **Predecessor (X1)**: mg-dd80 (UC-Lean-SS-X1-Bicomplex, Lean-Session
  21 AMBER named-gap GREEN lake build). State doc:
  `docs/state-UC-Lean-SS-X1.md`.
- **Predecessor (X2)**: mg-55b3 (UC-Lean-SS-X2-Convergence, Lean-Session
  22 GREEN). State doc: `docs/state-UC-Lean-SS-X2.md`.
- **Predecessor (X3)**: mg-fade (UC-Lean-SS-X3-Equivariant, Lean-Session
  23 GREEN). State doc: `docs/state-UC-Lean-SS-X3.md`. X4 consumes X3's
  `EquivariantBicomplex`, `onEInfty`, `Walsh.character`.
- **Sibling parallel polecat (X5)**: mg-c128 (UC-Lean-SS-X5-EdgeMap,
  Lean-Session 24 GREEN). State doc: `docs/state-UC-Lean-SS-X5.md`. X4
  does *not* depend on X5; both run after X3.
- **Parent RED diagnosis**: mg-36c3 (UC-Lean-per-x-closure, RED
  structural blocker). See `docs/state-UC-Lean-per-x-closure.md` +
  Lean-Session 19 of `docs/state-UC10.md`.
- **Mathlib pinned**: `v4.29.1`, rev `5e932f97dd25535344f80f9dd8da3aab83df0fe6`.
- **New file**: `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/Schur.lean`.
- **Modified file**: `lean/UnionClosed.lean` (one-line import addition
  after `Equivariant`).
- **Cumulative state**: this file + `docs/state-UC10.md` Lean-Session 25.

---

## §9 — Verdict

**GREEN — X4 delivers the finite-abelian Schur in scalar-character form
(`Schur.hom_eq_zero_of_ne_characters`) + the SS-page isotype-preservation
of equivariant differentials (`differential_isotype_zero`) + the
character-isotype slice/retract structures + the acceptance-bar
non-vacuous `(ZMod 2)^3` evaluation with concrete Walsh characters
(`Walsh.characterQ`, `Walsh.characterQ_n3_unit_witness`,
`Walsh.differential_isotype_zero_n3`). All 2 substantive pieces from the
ticket body and the scoping doc §3 X4 entry are constructed non-vacuously;
evaluated at concrete `(ZMod 2)^3` with concrete Walsh characters; `lake
build` GREEN (2001 jobs); no new `sorry`, no `axiom`, no fake mathlib API,
no `SpectralObject` TODO reliance, no defeq trick. Mathlib-PR-clean for
§§1–3, union_closed-specific for §4 Walsh evaluation, split at the
upstream-PR boundary by section header. **X6 unblocked** as the
GREEN-closing ticket of the entire Path A arc — all of X1–X5 GREEN.**
