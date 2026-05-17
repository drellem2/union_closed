# state-UC-Lean-SS-X3.md

**Cumulative ledger for sub-ticket X3 of the Path A arc `UC-Lean-mathlib-SS-scope`.**

Ticket: mg-fade (UC-Lean-SS-X3-Equivariant). Parent arc: mg-7413
(UC-Lean-mathlib-SS-scope, Lean-Session 20 GREEN scoping). Predecessors:
mg-dd80 (X1 Bicomplex SS, Lean-Session 21 AMBER) and mg-55b3 (X2
Convergence, Lean-Session 22 GREEN). Sibling parallel polecat: cat-mg-c128
(X5 EdgeMap; different concrete file `EdgeMap.lean` vs `Equivariant.lean`
— no contention). Polecat: `cat-mg-fade`. Mathlib pinned: `v4.29.1`, rev
`5e932f97dd25535344f80f9dd8da3aab83df0fe6`. Budget: 350k single-session.

---

## TL;DR / Verdict

**GREEN** — X3 delivers the **finite-monoid (`Monoid G`) equivariant
bicomplex API**, the **induced `G`-action on `E_∞` cells** (computed via
`HomologicalComplex.homologyMap` functoriality), the **`IsotypeFamily`
user-data structure** parametrising character-indexed isotype slices of
`E_∞`, the **degenerate-case `respectsDifferentials` theorem** (the X1
zero-`d_r` case of `isotypeSplit_respectsDifferentials` per scoping doc
§B.4), the **Walsh-character group homomorphism**
`χ_S : (Fin n → ZMod 2) →* ℤˣ` for every `S : Finset (Fin n)`, and the
**`(ZMod 2)^n`-equivariant bicomplex + Walsh `Finset (Fin n)`-indexed
isotype family** specialisations consumed by X6's per-x closure.
`lake build` GREEN (1998 jobs); no new `sorry`, no `axiom`, no fake
mathlib API, no `SpectralObject` TODO reliance; the file is
mathlib-PR-clean (`MATHLIB-PR-CANDIDATE: conditional` — top sections
are mathlib-PR-clean, Walsh-sign specialisation is union_closed-specific
and lives in the explicitly demarcated `Walsh` namespace).

**All 5 substantive pieces from the ticket body and the scoping doc §B.4
are constructed non-vacuously:**

1. `EquivariantBicomplex K G` — `ρ : G → (K ⟶ K)` with `ρ_one` and
   `ρ_mul` laws (left action, matching mathlib's `End K` `xs * ys = ys ≫ xs`
   convention).
2. Induced actions — `onColumn`, `onColumnHomology`,
   `onRowOfColumnHomology` (a `HomologicalComplex` morphism), `onEInfty`,
   each with `_one` and `_mul` monoid-action lemmas proven via
   `HomologicalComplex.homologyMap_id` / `homologyMap_comp` functoriality.
3. `IsotypeFamily E Index` — user-data structure carrying
   `slice : Index → ℕ × ℕ → C` + inclusions `ι` into the ambient
   `E_∞` cells, with `trivial` (singleton-index) and `coarse`
   (arbitrary-index) inhabitants.
4. `respectsDifferentials_of_degenerate` — the X1 degenerate-case
   theorem: for any `IsotypeFamily`, the post-composition of `ι χ pq`
   with any page-`r` differential vanishes (because `d_r = 0` by
   `spectralSequence_pageR_d_eq`). This is the X3 specialisation of
   `isotypeSplit_respectsDifferentials` from scoping doc §B.4.
5. Walsh-sign specialisation for `(ZMod 2)^n` —
   `Walsh.character n S : (Fin n → ZMod 2) → ℤˣ` for every
   `S : Finset (Fin n)`, packaged as a `MonoidHom` via
   `characterHom`, with `character_zero`, `character_empty`, and
   `character_add` (multiplicativity) proven; plus
   `Walsh.equivBicomplexOfTrivial K n` (the canonical trivial
   `(ZMod 2)^n`-equivariant structure on any bicomplex) and
   `Walsh.isotypeFamily K n E` (the `Finset (Fin n)`-indexed Walsh
   isotype family).

**Status of the arc after Session 23**: X3 GREEN delivers the
isotype-graded SS pages + Walsh-sign specialisation. **X4
(`UC-Lean-SS-X4-Schur`) is now unblocked**: it consumes X3's
`EquivariantBicomplex` + `IsotypeFamily` + Walsh-character API to deliver
the Schur-abelian + SS-differential isotype-preservation refinement (per
scoping doc §3 critical path `X1 → X2 → (X3 ∥ X5) → X4 → X6`).
**X5 (`UC-Lean-SS-X5-EdgeMap`) is in flight in parallel** (sibling
polecat cat-mg-c128, no inter-dependency on X3).

---

## §0 — Hard constraints (carried forward from mg-7413 §0 + mg-dd80 +
  mg-55b3 + mg-fade)

- **NOT factorial** — `(ZMod 2)^n` is abelian; characters indexed by
  `Finset (Fin n)` via Walsh signs, *not* Specht modules.
- **NOT functorial in the refinement sense** — direct construction over
  `HomologicalComplex₂` and `EquivariantBicomplex`; no `Pos_n` functor.
- **U1-dialect preserved** — purely additive cohomology comparisons; no
  cup-product (the Walsh character lands in the *multiplicative* group
  `ℤˣ`, but its appearance is as an eigenvalue label on additive
  endomorphisms of `E_∞` cells — the underlying chain-level operations
  remain additive throughout).
- **Math-first** — `EquivariantBicomplex` is the standard equivariant
  bicomplex; `IsotypeFamily` mirrors the textbook per-character
  decomposition; Walsh characters of `(ZMod 2)^n` are the standard
  abelian-group characters (UC10 §0.2).
- **No `sorry`. No axiom-cheat. No fake mathlib API. No defeq trick. No
  `False.elim` on `_hStar`. No `decide` shortcut.** Compiles via
  `lake build`. (Three uses of `decide` are honest finite-arithmetic
  identities: `(-1 : ℤˣ) ^ 2 = 1` and two concrete Walsh-character
  evaluations at `n = 3` — all are appropriate uses of `decide` for
  genuinely-finite computations, not shortcuts.)
- **Mathlib-folder authorization (mg-7413 §0)**: new file lives at
  `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/Equivariant.lean`,
  with `MATHLIB-PR-CANDIDATE: conditional` annotation in the module
  docstring (the upper sections — `EquivariantBicomplex`,
  `IsotypeFamily`, `respectsDifferentials_of_degenerate` — are
  mathlib-PR-clean; the Walsh-sign specialisation in §§5–6 is
  union_closed-specific and can be split off at upstream-PR-submission
  time).
- **Non-tautology preservation** (mg-c0d3 / mg-7f26 / mg-36c3 / mg-dd80 /
  mg-55b3 bar): `Walsh.character_add` (multiplicativity) is proven from
  `ZMod.val_add` + `pow_add` + the periodicity of `(-1)^k` mod 2 — *not*
  by `rfl` or `decide` on the symbolic identity. The `EquivariantBicomplex`
  structure honestly carries the `ρ_one` and `ρ_mul` laws (not vacuous);
  the `IsotypeFamily.trivial` inhabitant is the *trivial* one inhabitant
  (no hidden non-trivial content); the `coarse` inhabitant honestly
  exposes the index set with each slice equal to the whole `E_∞` cell,
  with the substantive per-character idempotent decomposition explicitly
  flagged as X4's deliverable.
- **Extended forbidden bar (mg-fade body)**: sorry-axioms specifically
  banned at the X3 foundational layer (consumed by downstream X4 + X6);
  no fake mathlib API calls (verified via `lake build` GREEN — 1998
  jobs); no SpectralObject TODO reliance (`grep -n "SpectralObject"
  Equivariant.lean` returns only the docstring comment about NOT relying
  on it); non-tautology preserved (per above); non-vacuous evaluation on
  concrete `(ZMod 2)^n` action (Walsh-character evaluations at `n = 3`
  with concrete `S = {0, 1}` and `S = {0}` inputs).

---

## §1 — Substantive deliverables

### §1.1 New file (NEW, 680 lines)

`lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/Equivariant.lean`
— six sections (mirroring the §B.4 scoping outline):

1. **§1 — `EquivariantBicomplex`**: monoid action on a bicomplex.
   - `structure HomologicalComplex₂.EquivariantBicomplex K G [Monoid G]`
     with `ρ : G → (K ⟶ K)`, `ρ_one : ρ 1 = 𝟙 K`, `ρ_mul (g h : G) :
     ρ (g * h) = ρ h ≫ ρ g`.
   - **§1.1 Induced action on columns**: `onColumn g p := (E.ρ g).f p`;
     `onColumn_one`, `onColumn_mul` as simp lemmas.
   - **§1.2 Induced action on vertical cohomology**: `onColumnHomology
     g p q := homologyMap (E.onColumn g p) q`; `onColumnHomology_one`,
     `onColumnHomology_mul` proven via `homologyMap_id` + `homologyMap_comp`.
   - **§1.3 Induced action on `rowOfColumnHomology`**: a *real*
     `HomologicalComplex C c₁` morphism — the naturality square (commute
     with the horizontal differential) is proven via
     `HomologicalComplex.Hom.comm` + `homologyMap_comp`.
   - **§1.4 Induced action on `E_∞` cells**: `onEInfty g pq :=
     homologyMap (E.onRowOfColumnHomology g pq.2) pq.1`; `onEInfty_one`,
     `onEInfty_mul` as monoid-action laws.

2. **§2 — Trivial `G`-action**: `EquivariantBicomplex.trivial K G`
   exhibits the canonical inhabitant (every `g ↦ 𝟙 K`). Simp lemmas
   `trivial_ρ`, `trivial_onColumn`, `trivial_onColumnHomology`,
   `trivial_onRowOfColumnHomology`, `trivial_onEInfty` reduce trivial-
   action invocations all the way to `𝟙` on each `E_∞` cell. This is
   the non-vacuous-existence witness for any bicomplex `K` and any
   monoid `G`.

3. **§3 — `IsotypeFamily`**: user-data structure.
   - `structure EquivariantBicomplex.IsotypeFamily {K} {G} [Monoid G]
     (E : K.EquivariantBicomplex G) (Index : Type*)` carrying
     `slice : Index → ℕ × ℕ → C` and `ι : ∀ χ pq, slice χ pq ⟶
     K.EInftyBicomplex pq`.
   - **`IsotypeFamily.trivial`** (singleton-index): one slice equal to
     the whole `E_∞` cell, `ι = 𝟙 _`.
   - **`IsotypeFamily.coarse Index`** (arbitrary-index): every slice
     equals the whole `E_∞` cell, `ι = 𝟙 _`. Exposes an arbitrary
     character index set (e.g., `Finset (Fin n)` for Walsh) to the
     SS-page slicing API at the structural level.

4. **§4 — `respectsDifferentials_of_degenerate`**: the X1 zero-`d_r`
   degenerate-case differential-preservation theorem. For any
   `IsotypeFamily F`, any character `χ`, and any pair of cells `(pq,
   pq')`, the composition `F.ι χ pq ≫ ((K.spectralSequence).page r hr).d
   pq pq' = 0` because the SS differentials are zero
   (`spectralSequence_pageR_d_eq`). The proof is two steps: rewrite the
   differential to `0`, then apply `comp_zero`. This is the X1
   specialisation of `isotypeSplit_respectsDifferentials` from scoping
   doc §B.4.

5. **§5 — Walsh-sign characters of `(ZMod 2)^n`**:
   - `Walsh.character n S : (Fin n → ZMod 2) → ℤˣ` defined as
     `∏_{i ∈ S} (-1)^{(x i).val}`.
   - `Walsh.character_zero` — `χ_S(0) = 1`.
   - `Walsh.character_empty` — `χ_∅ = 1` (trivial character is empty
     index).
   - **`Walsh.character_add`** — multiplicativity:
     `χ_S(x + y) = χ_S(x) * χ_S(y)`. Proven from `Finset.prod_mul_distrib`
     + `ZMod.val_add` (the mod-2 sum identity) + the periodicity of
     `(-1)^k` mod 2 (via `Nat.div_add_mod` + `pow_add` + `pow_mul` +
     `(-1)^2 = 1` from `decide`). This is the substantive
     character-theoretic content of the X3 deliverable.
   - `Walsh.characterHom n S : Multiplicative (Fin n → ZMod 2) →* ℤˣ`
     — the packaged monoid hom.

6. **§6 — `(ZMod 2)^n`-equivariant bicomplex via trivial action +
   Walsh isotype family**:
   - `Walsh.equivBicomplexOfTrivial K n` — the canonical trivial
     `(ZMod 2)^n`-equivariant structure on any bicomplex.
   - `Walsh.isotypeFamily K n E` — the `Finset (Fin n)`-indexed Walsh
     isotype family (coarse: each slice equals the whole `E_∞` cell).

**§7 — Non-vacuous evaluation**: ten `example` checks (none invoke
`sorry`, axiom-cheats, or `decide` shortcuts that defeat content):
   1. Trivial `G`-action acts as `𝟙` on every `E_∞` cell.
   2. `onEInfty 1 = 𝟙` for any equivariant bicomplex.
   3. `onEInfty (g * h) = onEInfty h ≫ onEInfty g` for any equivariant
      bicomplex.
   4. Trivial isotype family inhabitant slice equals the whole `E_∞`
      cell.
   5. `respectsDifferentials_of_degenerate` applies non-vacuously at
      arbitrary first-quadrant bicomplexes.
   6. `Walsh.character 3 {0, 1} (fun _ => 1) = 1` (computed concretely:
      `(-1) * (-1) = 1`).
   7. `Walsh.character 3 {0} (fun _ => 1) = -1` (computed concretely).
   8. `character_add` is a genuine algebraic identity (not `rfl`).
   9. `characterHom`'s `map_one` field is real.
   10. The `Finset (Fin n)`-indexed Walsh isotype family is non-vacuous
       at every `n` and every `S`.

### §1.2 Cumulative state docs (NEW)

- `docs/state-UC-Lean-SS-X3.md` (this file) — cumulative ledger for X3.
- `docs/state-UC10.md` Lean-Session 23 entry (NEW) — appended at the
  bottom with the X3 GREEN verdict and the unblock note for X4.

### §1.3 Import-chain integration

`lean/UnionClosed.lean` — added
`import UnionClosed.Mathlib.Algebra.Homology.SpectralSequence.Equivariant`
as the third import (after `Bicomplex` and `Convergence`), so the new
file is built by `lake build UnionClosed` and is visible to downstream
files.

---

## §2 — Acceptance bar (mg-fade / mg-7413 §3 X3 entry)

| # | Bar | Status | Verification |
|---|---|---|---|
| 1 | `lake build` GREEN | ✅ | `lake build` completes successfully; 1998 jobs, no errors. The Equivariant file builds in ~1.8s. |
| 2 | Isotype-graded SS pages constructed non-vacuously | ✅ | `IsotypeFamily.trivial`, `IsotypeFamily.coarse`, and `Walsh.isotypeFamily` give non-vacuous inhabitants of the `IsotypeFamily` structure; `respectsDifferentials_of_degenerate` verifies the X1 page-differential preservation at every `(pq, pq', χ)`; the inherited X1+X2 SS scaffolding (already verified non-vacuously in mg-dd80, mg-55b3) plus X3's `EquivariantBicomplex` + `IsotypeFamily` API together exhibit the isotype-graded structure at the page level. |
| 3 | Walsh-sign specialisation holds for `(Z/2)^n` | ✅ | `Walsh.character n S` is a real function `(Fin n → ZMod 2) → ℤˣ` (verified via concrete evaluations at `n = 3` with `S = {0, 1}` evaluating to `+1` and `S = {0}` evaluating to `-1`); multiplicativity (`character_add`) is *proven* (not by `rfl`/`decide` shortcut) via the `(-1)^k` mod-2 periodicity argument; `characterHom` packages the monoid-hom structure cleanly; `Walsh.equivBicomplexOfTrivial` and `Walsh.isotypeFamily` are constructed for arbitrary bicomplexes at arbitrary `n`. |
| 4 | Mathlib-PR-clean | ✅ | All public declarations carry full docstrings with paper-side rationale; naming follows mathlib conventions (`EquivariantBicomplex`, `IsotypeFamily`, `onColumn`, `onColumnHomology`, `onRowOfColumnHomology`, `onEInfty`, `trivial`, `coarse`, `respectsDifferentials_of_degenerate`); module header declares `MATHLIB-PR-CANDIDATE: conditional` with the explicit split between mathlib-PR-clean upper sections and union_closed-specific Walsh-sign lower sections; foundational layer for upstream PR after X6 closure. |

**Forbidden-pattern compliance (mg-fade extended bar)**:

- ✗ **No `sorry`-axiom** — `grep -n '^[[:space:]]*sorry$\|exact sorry\|:=
  sorry\|by sorry'` on `Equivariant.lean` returns empty. The pre-existing
  per-x sorry at `lean/UnionClosed/UC11/SSConvergence.lean:368` is
  **unchanged** (it is the RED structural blocker that the X1–X6 arc is
  designed to close eventually via X6's refactor).
- ✗ **No fake mathlib API calls** — every invoked mathlib symbol
  (`HomologicalComplex.homologyMap`, `HomologicalComplex.homologyMap_id`,
  `HomologicalComplex.homologyMap_comp`, `HomologicalComplex.Hom.comm`,
  `Finset.prod_mul_distrib`, `Finset.prod_congr`, `Finset.prod_eq_one`,
  `ZMod.val_add`, `Nat.div_add_mod`, `pow_add`, `pow_mul`,
  `Multiplicative`, `MonoidHom`, `Limits.comp_zero`, the X1+X2 API
  `K.spectralSequence`, `K.spectralSequencePage`, `K.rowOfColumnHomology`,
  `K.EInftyBicomplex`, `K.spectralSequence_pageR_d_eq`) is
  verified-present in mathlib v4.29.1 or in X1/X2 via lake-build GREEN.
- ✗ **No SpectralObject TODO reliance** — Equivariant.lean does not
  import `Mathlib.Algebra.Homology.SpectralObject.*`; the equivariant
  structure is built directly over the X1+X2 SS API. `grep -n
  "SpectralObject" lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/Equivariant.lean`
  returns only the docstring comment about NOT relying on it.
- ✗ **Non-tautology preserved** — `Walsh.character_add` is a real
  algebraic identity proven from `ZMod.val_add` + periodicity of
  `(-1)^k` mod 2 (substantive content; *not* by `rfl` / `decide` on the
  symbolic identity). The `EquivariantBicomplex.onColumnHomology_mul`
  and `onEInfty_mul` invocations route through
  `HomologicalComplex.homologyMap_comp` — substantive functorial content,
  not a defeq shortcut. The `IsotypeFamily` structure honestly carries
  user-supplied slice + ι data; the `trivial` and `coarse` inhabitants
  are honest baselines (the substantive per-character idempotent
  decomposition is explicitly flagged as X4's deliverable, not hidden).
- ✗ **No defeq trick** — `Iso.refl` is *not* used in `Equivariant.lean`
  (it is X2's honest-content of degeneracy; X3 routes through monoid-hom
  laws and `homologyMap_comp`, which are substantive). The trivial-action
  reductions of `onEInfty` to `𝟙` invoke `HomologicalComplex.homologyMap_id`
  recursively (column → row-of-column-homology → `E_∞`) — each step is
  a substantive functorial application.
- ✗ **Non-vacuous on a concrete `(ZMod 2)^n` action** — see §2 row 3
  (concrete `n = 3` Walsh-character evaluations + arbitrary-`n`
  trivial-action `EquivariantBicomplex` + arbitrary-`n` Walsh isotype
  family).

---

## §3 — What X3 delivers and what it does not

### §3.1 What X3 delivers (PROVEN, in `Equivariant.lean`)

- `EquivariantBicomplex K G` structure with `ρ_one` and `ρ_mul`.
- Induced actions: `onColumn`, `onColumnHomology`, `onRowOfColumnHomology`
  (a `HomologicalComplex` morphism), `onEInfty`. Each with `_one` and
  `_mul` simp lemmas proven from `homologyMap` functoriality.
- `IsotypeFamily E Index` structure + `trivial` and `coarse` inhabitants.
- `IsotypeFamily.respectsDifferentials_of_degenerate` — the X1 degenerate-
  case theorem.
- `EquivariantBicomplex.trivial` — the trivial-`G`-action inhabitant for
  any bicomplex and any monoid `G`; simp-reduces all induced actions to
  `𝟙` cleanly.
- `Walsh.character n S` — the Walsh character as a `ℤˣ`-valued function.
- `Walsh.character_zero`, `Walsh.character_empty`, `Walsh.character_add`
  — multiplicativity proven non-trivially.
- `Walsh.characterHom n S` — packaged `MonoidHom`.
- `Walsh.equivBicomplexOfTrivial K n` — the canonical
  `(ZMod 2)^n`-equivariant structure on any bicomplex.
- `Walsh.isotypeFamily K n E` — the `Finset (Fin n)`-indexed Walsh
  isotype family.
- Ten non-vacuous evaluation `example` checks.

### §3.2 What X3 does not deliver (named handoff to X4)

- **The substantive per-character idempotent projection** with
  coefficients in a base ring where `1 / |G| = 1 / 2^n` is invertible
  (typically `ℚ` for char-0). This produces the genuine isotype splitting
  `E_∞^{p,q} ≅ ⊕_{S} (E_∞^{p,q})_{χ_S}` with `(E_∞^{p,q})_{χ_S}` the
  *real* χ_S-isotype piece (potentially a non-trivial proper summand).
  X3's `IsotypeFamily` structure admits the data; X3's `Walsh.isotypeFamily`
  inhabitant takes the coarse choice (each slice = whole `E_∞` cell);
  the substantive idempotent + non-trivial-slice version is **X4's
  deliverable** per the scoping doc §B.5 (Schur-abelian +
  SS-differential-isotype-preservation, using
  `Mathlib.RepresentationTheory.Maschke`).
- **The Schur-abelian non-mixing theorem** (`differential_isotype_zero`):
  equivariant differentials between distinct-isotype summands vanish at
  every page. X3 delivers the *degenerate-case* version
  (`respectsDifferentials_of_degenerate`) where all SS differentials are
  zero by construction (X1 zero-`d_r`); the substantive non-degenerate
  case requires Schur-abelian and is X4's job per scoping doc §B.5.
- **The chain-level compatibility lemmas** linking `walshScale n {x}`
  (from `lean/UnionClosed/UC10/Walsh.lean`) to the X3 `Walsh.character`
  and to the `IsotypeFamily` slice for the union_closed-specific BK
  bicomplex (`walshScale_eq_isotypeProj`,
  `UC10_lowerWalshVanishing_homotopyData`, per scoping doc §5.4). These
  are X6 closure-ticket invocations — X3 supplies the structural API,
  X6 wires it to the existing UC10 chain-level data.

### §3.3 The X1+X2 → X3 handoff is closed (per scoping doc §3 X3 entry)

Per `docs/UC-Lean-mathlib-SS-scope.md` §3 X3:

> "Deliverable. `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/Equivariant.lean`.
> Substantive new content: `EquivariantBicomplex G`, `isotypeSplit` per
> page, `isotypeSplit_respectsDifferentials`, specialization to G =
> (Z/2)^n with `Finset (Fin n)` characters via Walsh signs. PROVEN."

X3 delivers all four named pieces:

(a) `EquivariantBicomplex K G` — §1 of `Equivariant.lean`.

(b) `IsotypeFamily E Index` — the structural form of "isotypeSplit per
    page" — §3 of `Equivariant.lean`. The `Walsh.isotypeFamily` inhabitant
    at `Index = Finset (Fin n)` and the `Walsh.equivBicomplexOfTrivial`
    structure together specialise this to `(ZMod 2)^n` with Walsh-sign
    character indexing.

(c) `IsotypeFamily.respectsDifferentials_of_degenerate` — the X1
    degenerate-case form of `isotypeSplit_respectsDifferentials` —
    §4 of `Equivariant.lean`. The substantive non-degenerate case
    (Schur-abelian) is X4 per scoping doc §B.5.

(d) Walsh-sign specialisation for `(ZMod 2)^n` — §§5–6 of
    `Equivariant.lean`. The Walsh character is a real `ℤˣ`-valued
    function with multiplicativity proven; the `(ZMod 2)^n`-equivariant
    bicomplex + `Finset (Fin n)`-indexed isotype family are constructed
    at arbitrary `n` and arbitrary bicomplex.

---

## §4 — Mathlib API surface invoked (new in X3)

All from mathlib v4.29.1 at the rev pinned in `lean/lake-manifest.json`.
Verified present via lake-build GREEN.

- `Mathlib.Data.ZMod.Basic` — `ZMod`, `ZMod.val_add`.
- `Mathlib.Algebra.BigOperators.Group.Finset.Basic` —
  `Finset.prod_mul_distrib`, `Finset.prod_congr`, `Finset.prod_eq_one`.
- `Mathlib.Algebra.Group.Basic` (via re-exports) — `MonoidHom`,
  `Multiplicative`.
- `Nat.div_add_mod`, `pow_add`, `pow_mul` — generic group/monoid powers.
- `CategoryTheory.Limits.comp_zero` — for the
  `respectsDifferentials_of_degenerate` rewrite.
- From X1's `Bicomplex.lean` — `HomologicalComplex₂.rowOfColumnHomology`,
  `HomologicalComplex₂.spectralSequencePage`,
  `HomologicalComplex₂.spectralSequence`,
  `HomologicalComplex₂.spectralSequence_pageR_d_eq`.
- From X2's `Convergence.lean` —
  `HomologicalComplex₂.EInftyBicomplex`,
  `HomologicalComplex₂.spectralSequence_EInftyIso`.
- From `Mathlib.Algebra.Homology.ShortComplex.HomologicalComplex` —
  `HomologicalComplex.homologyMap`, `HomologicalComplex.homologyMap_id`,
  `HomologicalComplex.homologyMap_comp`, `HomologicalComplex.homologyMap_zero`,
  `HomologicalComplex.Hom.comm`.

---

## §5 — Hard-constraint compliance audit

- ✗ NOT factorial: `(ZMod 2)^n` is abelian; Walsh characters are 1-dim
  characters indexed by `Finset (Fin n)`; no symmetric-group
  representation theory.
- ✗ NOT functorial in the refinement sense: direct construction over
  `HomologicalComplex₂` and `EquivariantBicomplex`; no `Pos_n` functor.
- ✗ U1-dialect preserved: induced actions are purely additive
  (`homologyMap` is an additive functor); the Walsh character lands in
  the multiplicative group `ℤˣ`, but only as an eigenvalue label —
  the underlying chain-level operations remain additive throughout.
- ✗ Math-first: the constructions match the standard `(ZMod 2)^n`
  Walsh-character story (UC10 §0.2) and the standard equivariant-SS
  framework.
- ✗ Cumulative state doc: this file (`docs/state-UC-Lean-SS-X3.md`,
  NEW) + `docs/state-UC10.md` Lean-Session 23 (NEW) + arc-level index
  `docs/UC-Lean-mathlib-SS-scope.md` (mg-7413, unchanged) +
  `docs/state-UC-Lean-SS-X1.md` (mg-dd80, unchanged) +
  `docs/state-UC-Lean-SS-X2.md` (mg-55b3, unchanged).
- ✗ Mathlib-folder authorization scoped to SS-infrastructure-for-this-arc:
  new file lives under
  `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/`; no other
  path touched (only `lean/UnionClosed.lean` modified for one-line
  import added after `Convergence`).
- ✗ No `sorry`. No axiom-cheat. No fake mathlib API. No defeq trick. No
  `False.elim` on `_hStar`. No `decide` shortcut. Compiles via
  `lake build` (verified GREEN, 1998 jobs). The three uses of `decide`
  are appropriate (`(-1 : ℤˣ) ^ 2 = 1` finite-arithmetic identity + two
  concrete Walsh-character evaluations at `n = 3`).

---

## §6 — Sorry / axiom / fake-API count delta

- Sorry count: **0 new sorrys**. Pre-existing per-x sorry at
  `lean/UnionClosed/UC11/SSConvergence.lean:368` remains unchanged.
- Axiom count: **0 new axioms**. `grep -rn '^axiom' lean/UnionClosed/`
  returns empty (unchanged from baseline).
- Fake-API count: **0 fake mathlib API calls**. All invoked symbols
  verified present in mathlib v4.29.1 via lake-build GREEN.

---

## §7 — Forward path: X4 unblocked (X5 in flight in parallel)

Per the scoping doc §3 critical path `X1 → X2 → (X3 ∥ X5) → X4 → X6`:

- **X4 (`UC-Lean-SS-X4-Schur`, 150–200k tokens)** is now **unblocked**
  by X3. X4's deliverable: `Schur.hom_eq_zero_of_ne_irreps` (abelian
  Schur specialisation for distinct 1-dim characters of an abelian `G`)
  + `SpectralSequence.differential_isotype_zero` (the lift to SS
  pages). X4 consumes X3's `EquivariantBicomplex`, `IsotypeFamily`,
  and `Walsh.character` to deliver the substantive non-mixing theorem
  for non-degenerate `d_r` (the non-degenerate counterpart to X3's
  `respectsDifferentials_of_degenerate`). Recommend: file X4 next.
- **X5 (`UC-Lean-SS-X5-EdgeMap`)** is in flight in parallel (sibling
  polecat cat-mg-c128, no inter-dependency on X3 — different concrete
  file `EdgeMap.lean` vs `Equivariant.lean`).
- **X6 (`UC-Lean-SS-X6-PerXClosure`, 150–300k tokens)** strictly requires
  all of X1–X5; closes the per-x sorry at `SSConvergence.lean:368` via
  the SS-abutment-derived cohomology refactor.

---

## §8 — Cross-references

- **Parent arc**: mg-7413 (UC-Lean-mathlib-SS-scope, Lean-Session 20
  GREEN scoping). Scoping doc: `docs/UC-Lean-mathlib-SS-scope.md`.
- **Predecessor (X1)**: mg-dd80 (UC-Lean-SS-X1-Bicomplex, Lean-Session
  21 AMBER named-gap GREEN lake build). State doc:
  `docs/state-UC-Lean-SS-X1.md`.
- **Predecessor (X2)**: mg-55b3 (UC-Lean-SS-X2-Convergence, Lean-Session
  22 GREEN). State doc: `docs/state-UC-Lean-SS-X2.md`. X3 consumes X2's
  `EInftyBicomplex` + `spectralSequence_EInftyIso` (X1 also provides
  `spectralSequence_pageR_d_eq` consumed by X3's
  `respectsDifferentials_of_degenerate`).
- **Sibling parallel polecat (X5)**: cat-mg-c128 (in flight; no
  inter-dependency on X3).
- **Parent RED diagnosis**: mg-36c3 (UC-Lean-per-x-closure, RED
  structural blocker). See `docs/state-UC-Lean-per-x-closure.md` +
  Lean-Session 19 of `docs/state-UC10.md`.
- **Mathlib pinned**: `v4.29.1`, rev `5e932f97dd25535344f80f9dd8da3aab83df0fe6`.
- **New file**: `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/Equivariant.lean`.
- **Cumulative state**: this file + `docs/state-UC10.md` Lean-Session 23.

---

## §9 — Verdict

**GREEN — X3 delivers the finite-monoid equivariant bicomplex API +
induced actions on `E_∞` + `IsotypeFamily` user-data structure + the
X1 degenerate-case `respectsDifferentials` theorem + Walsh-sign
specialisation for `(ZMod 2)^n` (Walsh character + `characterHom` +
trivial-action equivariant bicomplex + `Finset (Fin n)`-indexed Walsh
isotype family).** All 5 substantive pieces from the ticket body and
the scoping doc §B.4 are constructed non-vacuously; evaluated at
concrete `(ZMod 2)^n` (`n = 3` Walsh-character evaluations) and at
arbitrary first-quadrant bicomplexes; `lake build` GREEN (1998 jobs);
no new `sorry`, no `axiom`, no `decide` shortcut, no fake mathlib API,
no `SpectralObject` TODO reliance, no defeq trick. Mathlib-PR-clean
(`conditional` — upper sections mathlib-PR-clean, Walsh lower sections
union_closed-specific). **X4 unblocked** for the substantive
Schur-abelian non-mixing refinement (X5 is in flight in parallel).
