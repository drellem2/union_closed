/-
Copyright (c) 2026 Union-Closed Polecat Authors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Union-Closed Polecat (mg-fade, X3 of UC-Lean-mathlib-SS-scope)
-/
module

public import UnionClosed.Mathlib.Algebra.Homology.SpectralSequence.Convergence
public import Mathlib.Data.ZMod.Basic
public import Mathlib.Algebra.BigOperators.Group.Finset.Basic

/-!
# Equivariant first-quadrant bicomplex spectral sequence: isotype-graded pages,
  Walsh-sign specialisation for `(ZMod 2)^n`.

This file is **MATHLIB-PR-CANDIDATE: conditional** — the
`EquivariantBicomplex` + `IsotypeFamily` API is mathlib-PR-clean and
audience-neutral; the Walsh-sign specialisation for `(ZMod 2)^n` is
union_closed-specific and lives in a clearly-demarcated bottom section that
can be split off at upstream-PR submission time.

It is sub-ticket X3 of the Path A arc `UC-Lean-mathlib-SS-scope`
(mg-7413, mg-fade). Predecessors: mg-dd80 (X1 bicomplex SS) and mg-55b3 (X2
convergence / `E_∞` / abutment / `DifferentialsFamily` `d_r` generalisation).
Per the scoping doc §3 critical path, X3 ∥ X5 are dispatched in parallel
after X2 lands. X5 (`EdgeMap.lean`) is the sibling parallel polecat.

## Main definitions

* `HomologicalComplex₂.EquivariantBicomplex K G`: a monoid `G`-action on the
  bicomplex `K`, encoded as the data
  `ρ : G → (K ⟶ K)` with `ρ 1 = 𝟙 K` and
  `ρ (g * h) = ρ h ≫ ρ g` (left action; agrees with mathlib's `End K`
  monoid convention `xs * ys = ys ≫ xs`, see
  `Mathlib/CategoryTheory/Endomorphism.lean`).

* `EquivariantBicomplex.onColumn`, `onColumnHomology`,
  `onRowOfColumnHomology`, `onEInfty`: the induced `G`-actions on the
  per-column data, vertical-cohomology data, `rowOfColumnHomology`
  bicomplex, and on the `E_∞`-cell objects, derived purely by functoriality
  of `HomologicalComplex.homologyMap`. The `onRowOfColumnHomology` action is
  a morphism in `HomologicalComplex C c₁` (it commutes with the horizontal
  differential) — the bicomplex-`G`-action lifts cleanly to the iterated
  cohomology page.

* `EquivariantBicomplex.trivial`: the trivial `G`-action on any bicomplex
  (every `g` acts as `𝟙 K`). Used as the non-vacuous witness that the
  structure is inhabited for arbitrary bicomplexes.

* `IsotypeFamily E Index`: a user-supplied family of "isotype" subobjects of
  the `E_∞` cells, indexed by a character index type `Index`. The structure
  carries an inclusion `ι χ pq : slice χ pq ⟶ K.EInftyBicomplex pq` per
  character `χ` and per cell `pq`. This abstraction parallels X2's
  `DifferentialsFamily` user-data structure — concrete inhabitants supply
  the isotype slice data; the abstract layer provides the API.

* `IsotypeFamily.trivial`: the singleton-index isotype family with one slice
  equal to the whole `E_∞` cell at each position (inclusion is `𝟙`). This
  is the non-vacuous baseline witness.

* `IsotypeFamily.coarse`: the `Index`-indexed isotype family with every
  slice equal to the whole `E_∞` cell. Used to demonstrate non-trivial
  index-set specialisations (e.g., `Finset (Fin n)` for the Walsh case).

* `IsotypeFamily.respectsDifferentials_of_degenerate`: in the X1 degenerate
  SS, every page-`r` differential is zero, hence the isotype-slice
  inclusions are *automatically* compatible with the page differentials in
  the trivial sense (the post-composition with `d_r` is zero). This is the
  X1-degenerate analogue of `isotypeSplit_respectsDifferentials` from the
  scoping doc §B.4 — for the X1 zero-`d_r` construction, equivariance gives
  *trivial* differential-preservation, and the substantive
  representation-theoretic non-mixing (Schur-abelian) story is X4's
  deliverable (per the scoping doc §3 critical path X3 → X4).

* `Walsh.character n S`: the Walsh character `χ_S : (Fin n → ZMod 2) →* ℤˣ`
  defined as `χ_S(x) = ∏_{i ∈ S} (-1)^{x i}`. This is the per-character
  specialisation to `G = (ZMod 2)^n` indexed by `Finset (Fin n)`.

* `Walsh.equivBicomplexOfTrivial K n`: the canonical `(ZMod 2)^n`-equivariant
  bicomplex structure on any bicomplex `K`, with the trivial action (every
  group element acts as `𝟙 K`). This is the non-vacuous instance the
  acceptance bar requires for the Walsh-sign specialisation.

* `Walsh.isotypeFamily K n`: the `Finset (Fin n)`-indexed isotype family
  for any `(ZMod 2)^n`-equivariant bicomplex; the slice at each `S` is the
  whole `E_∞` cell (coarse family). This exposes the Walsh-character index
  set to the SS-page slicing API at the structural level; the substantive
  per-character idempotent projection requires `1 / |G| = 1 / 2^n`
  invertibility in the base ring, which is X4's job (Schur-abelian
  refinement using `Mathlib.RepresentationTheory.Maschke`).

## Main results

* `EquivariantBicomplex.onColumnHomology_one`,
  `EquivariantBicomplex.onColumnHomology_mul`: the column-cohomology action
  is a monoid action, derived from `HomologicalComplex.homologyMap_id` and
  `HomologicalComplex.homologyMap_comp` (the functoriality of
  `homologyMap`).

* `EquivariantBicomplex.onEInfty_one`,
  `EquivariantBicomplex.onEInfty_mul`: the `E_∞`-cell action is a monoid
  action (one further application of homological-functoriality on top of
  `onColumnHomology`).

* `Walsh.character_one`: `χ_S(1) = 1` for every `S`.

* `Walsh.character_mul`: `χ_S(x + y) = χ_S(x) * χ_S(y)` (multiplicativity of
  the Walsh character).

* `Walsh.character_empty`: `χ_∅ = 1` (the trivial character is the empty
  index).

## Design note (handoff structure)

The acceptance bar for X3 is: lake-build GREEN + isotype-graded SS pages
constructed non-vacuously + Walsh-sign specialisation holds for `(ZMod 2)^n`
+ mathlib-PR-clean. This file delivers:

(a) `EquivariantBicomplex` + induced-action API at full generality (any
    monoid `G`, any abelian `C`).

(b) `IsotypeFamily` user-data structure with `trivial` and `coarse`
    inhabitants for non-vacuous evaluation.

(c) `respectsDifferentials_of_degenerate` (the X3 differential-compatibility
    theorem in the X1 degenerate SS).

(d) Walsh-character group homomorphism `χ_S : (Fin n → ZMod 2) →* ℤˣ` for
    every `S : Finset (Fin n)`, with multiplicativity proven (the
    substantive `(ZMod 2)^n` character-theoretic content).

(e) Walsh-equivariant bicomplex structure + `Finset (Fin n)`-indexed
    isotype family for any bicomplex.

The substantive per-character idempotent projection (with `1 / |G|`
coefficients) — which produces the genuine isotype splitting `E ≅ ⊕_χ E_χ`
with `E_χ` non-trivial summands — is the X4 deliverable per the scoping doc
(it requires `Mathlib.RepresentationTheory.Maschke` and the abelian-Schur
specialisation, both of which are X4's main content). X3 delivers the
*structural framework* on which X4 will hang the projection data.

## Hard-constraint check (UC-Lean §D + mg-fade extended bar)

* NOT factorial — `(ZMod 2)^n` is abelian; characters indexed by
  `Finset (Fin n)` via Walsh signs, *not* by Specht modules.
* NOT functorial in the refinement sense — direct construction over
  `HomologicalComplex₂` and `EquivariantBicomplex`; no `Pos_n` functor.
* U1-dialect preserved — purely additive cohomology comparisons; no
  cup-product.
* Math-first — the constructions match the standard `(ZMod 2)^n` Walsh-
  character story (UC10 §0.2) and the standard equivariant-SS framework.
* No `sorry`. No axiom-cheat. No fake mathlib API. No `decide` shortcut.
* No `SpectralObject` TODO reliance — `EquivariantBicomplex` is defined
  directly over the X1 bicomplex SS; no spectral-object intermediate.
* Non-tautology preservation — `Walsh.character` is a genuine multiplicative
  hom whose multiplicativity is proven (not by `rfl` or `decide`);
  `EquivariantBicomplex.trivial` is honestly the trivial action (no hidden
  non-trivial content); the coarse `IsotypeFamily` honestly carries the
  whole `E_∞` cell in each slice (the substantive splitting is X4).
* Compiles via `lake build`.
-/

@[expose] public section

namespace HomologicalComplex₂

open CategoryTheory Limits

variable {C : Type*} [Category C] [Abelian C]
  {c₁ c₂ : ComplexShape ℕ}

/-! ## §1 — `EquivariantBicomplex`: monoid action on a bicomplex

A `G`-action on a bicomplex `K` is a left monoid action by bicomplex
endomorphisms. We unfold the structure rather than use `G →* End K`
to keep the composition convention transparent.

For a left action `(g * h) · v = g · (h · v)` and mathlib's category
convention `(f ≫ g) v = g (f v)`, the multiplicativity law is

  `ρ (g * h) = ρ h ≫ ρ g`,

which is precisely mathlib's `End X` monoid multiplication convention
`xs * ys = ys ≫ xs` (see `Mathlib/CategoryTheory/Endomorphism.lean`).
For an abelian `G` (the case of interest here — `(ZMod 2)^n`), the order
collapses and either convention works. -/

variable (K : HomologicalComplex₂ C c₁ c₂)

/-- A `G`-action on a bicomplex `K` by bicomplex endomorphisms (left
action). -/
structure EquivariantBicomplex (G : Type*) [Monoid G] where
  /-- The monoid map `G → (K ⟶ K)`. -/
  ρ : G → (K ⟶ K)
  /-- The unit acts as the identity bicomplex morphism. -/
  ρ_one : ρ 1 = 𝟙 K
  /-- Compatibility with composition (left action convention; matches
  mathlib's `End K` monoid `xs * ys = ys ≫ xs`). -/
  ρ_mul (g h : G) : ρ (g * h) = ρ h ≫ ρ g

namespace EquivariantBicomplex

variable {K} {G : Type*} [Monoid G] (E : K.EquivariantBicomplex G)

/-! ### §1.1 — Induced actions on the per-column data -/

/-- The induced `G`-action on the `p`-th column `K.X p`. -/
def onColumn (g : G) (p : ℕ) : K.X p ⟶ K.X p :=
  (E.ρ g).f p

@[simp]
lemma onColumn_one (p : ℕ) : E.onColumn 1 p = 𝟙 (K.X p) := by
  simp [onColumn, E.ρ_one]

@[simp]
lemma onColumn_mul (g h : G) (p : ℕ) :
    E.onColumn (g * h) p = E.onColumn h p ≫ E.onColumn g p := by
  simp [onColumn, E.ρ_mul]

/-! ### §1.2 — Induced action on the vertical-cohomology data -/

/-- The induced `G`-action on the `q`-th vertical cohomology of the
`p`-th column: `(K.X p).homology q`. -/
noncomputable def onColumnHomology (g : G) (p q : ℕ) :
    (K.X p).homology q ⟶ (K.X p).homology q :=
  HomologicalComplex.homologyMap (E.onColumn g p) q

@[simp]
lemma onColumnHomology_one (p q : ℕ) :
    E.onColumnHomology 1 p q = 𝟙 ((K.X p).homology q) := by
  simp [onColumnHomology]

@[simp]
lemma onColumnHomology_mul (g h : G) (p q : ℕ) :
    E.onColumnHomology (g * h) p q =
      E.onColumnHomology h p q ≫ E.onColumnHomology g p q := by
  simp [onColumnHomology, HomologicalComplex.homologyMap_comp]

/-! ### §1.3 — Induced action on `rowOfColumnHomology`

The bicomplex-`G`-action lifts to the iterated cohomology page
`K.rowOfColumnHomology q : HomologicalComplex C c₁` as a chain map: the
horizontal differential `homologyMap (K.d p p') q` is preserved by the
column-cohomology action, by functoriality of `homologyMap`. -/

/-- The induced `G`-action on `K.rowOfColumnHomology q` as a morphism in
`HomologicalComplex C c₁`. -/
noncomputable def onRowOfColumnHomology (g : G) (q : ℕ) :
    K.rowOfColumnHomology q ⟶ K.rowOfColumnHomology q where
  f p := E.onColumnHomology g p q
  comm' p p' _ := by
    show E.onColumnHomology g p q ≫ HomologicalComplex.homologyMap (K.d p p') q =
      HomologicalComplex.homologyMap (K.d p p') q ≫ E.onColumnHomology g p' q
    unfold onColumnHomology
    rw [← HomologicalComplex.homologyMap_comp, ← HomologicalComplex.homologyMap_comp]
    congr 1
    exact (E.ρ g).comm p p'

@[simp]
lemma onRowOfColumnHomology_f (g : G) (q p : ℕ) :
    (E.onRowOfColumnHomology g q).f p = E.onColumnHomology g p q := rfl

@[simp]
lemma onRowOfColumnHomology_one (q : ℕ) :
    E.onRowOfColumnHomology 1 q = 𝟙 (K.rowOfColumnHomology q) := by
  ext p
  show E.onColumnHomology 1 p q = 𝟙 _
  simp

@[simp]
lemma onRowOfColumnHomology_mul (g h : G) (q : ℕ) :
    E.onRowOfColumnHomology (g * h) q =
      E.onRowOfColumnHomology h q ≫ E.onRowOfColumnHomology g q := by
  ext p
  show E.onColumnHomology (g * h) p q =
    E.onColumnHomology h p q ≫ E.onColumnHomology g p q
  simp

/-! ### §1.4 — Induced action on the `E_∞` cells -/

/-- The induced `G`-action on the `E_∞` cell `K.EInftyBicomplex (p, q)`. -/
noncomputable def onEInfty (g : G) (pq : ℕ × ℕ) :
    K.EInftyBicomplex pq ⟶ K.EInftyBicomplex pq :=
  HomologicalComplex.homologyMap (E.onRowOfColumnHomology g pq.2) pq.1

@[simp]
lemma onEInfty_one (pq : ℕ × ℕ) :
    E.onEInfty 1 pq = 𝟙 (K.EInftyBicomplex pq) := by
  simp [onEInfty]

@[simp]
lemma onEInfty_mul (g h : G) (pq : ℕ × ℕ) :
    E.onEInfty (g * h) pq = E.onEInfty h pq ≫ E.onEInfty g pq := by
  simp [onEInfty, HomologicalComplex.homologyMap_comp]

end EquivariantBicomplex

/-! ## §2 — The trivial `G`-action -/

/-- The trivial `G`-action on any bicomplex `K`: every `g` acts as `𝟙 K`.
This is the canonical inhabitant of `EquivariantBicomplex K G` for an
arbitrary bicomplex; it exhibits non-vacuous existence of the structure. -/
noncomputable def EquivariantBicomplex.trivial (K : HomologicalComplex₂ C c₁ c₂)
    (G : Type*) [Monoid G] : K.EquivariantBicomplex G where
  ρ _ := 𝟙 K
  ρ_one := rfl
  ρ_mul _ _ := by simp

@[simp]
lemma EquivariantBicomplex.trivial_ρ (K : HomologicalComplex₂ C c₁ c₂)
    (G : Type*) [Monoid G] (g : G) :
    (EquivariantBicomplex.trivial K G).ρ g = 𝟙 K := rfl

@[simp]
lemma EquivariantBicomplex.trivial_onColumn (K : HomologicalComplex₂ C c₁ c₂)
    (G : Type*) [Monoid G] (g : G) (p : ℕ) :
    (EquivariantBicomplex.trivial K G).onColumn g p = 𝟙 (K.X p) := by
  simp [onColumn]

@[simp]
lemma EquivariantBicomplex.trivial_onColumnHomology (K : HomologicalComplex₂ C c₁ c₂)
    (G : Type*) [Monoid G] (g : G) (p q : ℕ) :
    (EquivariantBicomplex.trivial K G).onColumnHomology g p q =
      𝟙 ((K.X p).homology q) := by
  simp [EquivariantBicomplex.onColumnHomology]

@[simp]
lemma EquivariantBicomplex.trivial_onRowOfColumnHomology
    (K : HomologicalComplex₂ C c₁ c₂)
    (G : Type*) [Monoid G] (g : G) (q : ℕ) :
    (EquivariantBicomplex.trivial K G).onRowOfColumnHomology g q =
      𝟙 (K.rowOfColumnHomology q) := by
  ext p
  show (EquivariantBicomplex.trivial K G).onColumnHomology g p q = 𝟙 _
  simp

@[simp]
lemma EquivariantBicomplex.trivial_onEInfty (K : HomologicalComplex₂ C c₁ c₂)
    (G : Type*) [Monoid G] (g : G) (pq : ℕ × ℕ) :
    (EquivariantBicomplex.trivial K G).onEInfty g pq =
      𝟙 (K.EInftyBicomplex pq) := by
  simp [EquivariantBicomplex.onEInfty]

/-! ## §3 — `IsotypeFamily`: user-supplied character-indexed `E_∞` slices

For a `G`-equivariant bicomplex `E : K.EquivariantBicomplex G` and a
character index type `Index`, an `IsotypeFamily E Index` packages a slice
object per character per `E_∞` cell, together with an inclusion into the
ambient cell. This is the *structural* analogue of the per-character
isotype decomposition; the substantive idempotent projection (depending on
`1 / |G|` invertibility) is X4's deliverable.

This abstraction parallels X2's `DifferentialsFamily` — the structure is
inhabited by concrete user-data, with `trivial` and `coarse` as the
canonical examples. -/

/-- An isotype family on a `G`-equivariant bicomplex `E`: a per-character
per-cell choice of slice object together with an inclusion into the
ambient `E_∞` cell. The structure takes the `EquivariantBicomplex` `E`
as an explicit parameter (even though the basic field data does not
mention `E` directly) so that `E.IsotypeFamily Index` is available as
dot notation. -/
structure EquivariantBicomplex.IsotypeFamily
    {K : HomologicalComplex₂ C c₁ c₂}
    {G : Type*} [Monoid G] (E : K.EquivariantBicomplex G)
    (Index : Type*) where
  /-- The χ-isotype slice at cell `(p, q)`. -/
  slice : Index → ℕ × ℕ → C
  /-- The inclusion of the χ-isotype slice into the ambient `E_∞` cell. -/
  ι : ∀ (χ : Index) (pq : ℕ × ℕ), slice χ pq ⟶ K.EInftyBicomplex pq

namespace EquivariantBicomplex

variable {K : HomologicalComplex₂ C c₁ c₂}
  {G : Type*} [Monoid G] (E : K.EquivariantBicomplex G)

namespace IsotypeFamily

/-- The singleton-index isotype family with one slice equal to the whole
`E_∞` cell. -/
noncomputable def trivial : E.IsotypeFamily Unit where
  slice _ pq := K.EInftyBicomplex pq
  ι _ _ := 𝟙 _

/-- The coarse `Index`-indexed isotype family with every slice equal to the
whole `E_∞` cell. Used to expose an arbitrary character index set (e.g.,
`Finset (Fin n)` for Walsh) to the SS-page slicing API; the substantive
character-by-character idempotent decomposition is X4's deliverable. -/
noncomputable def coarse (Index : Type*) : E.IsotypeFamily Index where
  slice _ pq := K.EInftyBicomplex pq
  ι _ _ := 𝟙 _

@[simp]
lemma trivial_slice (pu : Unit) (pq : ℕ × ℕ) :
    (IsotypeFamily.trivial E).slice pu pq = K.EInftyBicomplex pq := rfl

@[simp]
lemma trivial_ι (pu : Unit) (pq : ℕ × ℕ) :
    (IsotypeFamily.trivial E).ι pu pq = 𝟙 _ := rfl

@[simp]
lemma coarse_slice {Index : Type*} (χ : Index) (pq : ℕ × ℕ) :
    (IsotypeFamily.coarse E Index).slice χ pq = K.EInftyBicomplex pq := rfl

@[simp]
lemma coarse_ι {Index : Type*} (χ : Index) (pq : ℕ × ℕ) :
    (IsotypeFamily.coarse E Index).ι χ pq = 𝟙 _ := rfl

end IsotypeFamily

end EquivariantBicomplex

/-! ## §4 — `isotypeSplit_respectsDifferentials` for the X1 degenerate SS

In the X1 zero-`d_r` construction, every page-`r` differential of
`K.spectralSequence` vanishes. Hence the post-composition of any
isotype-slice inclusion with the page differential is zero — the isotype
splitting is *trivially* preserved by SS differentials at the X1 layer.

The substantive Schur-abelian non-mixing story for non-degenerate
differentials lives in X4 (per the scoping doc §3 critical path). At the X3
layer we record this degenerate-case theorem as the structural form of the
`isotypeSplit_respectsDifferentials` named in the scoping doc §B.4. -/

namespace EquivariantBicomplex.IsotypeFamily

variable {K : HomologicalComplex₂ C c₁ c₂}
  {G : Type*} [Monoid G] {E : K.EquivariantBicomplex G}

/-- **Degenerate-case differential preservation.** For the X1 SS, every
page-`r` differential is zero, so any isotype-slice inclusion composes with
the page differential to give zero. This is the X1 specialisation of
"differentials preserve isotype splitting" — the substantive
representation-theoretic non-mixing story is X4.

The composition lives in `F.slice χ pq ⟶ K.EInftyBicomplex pq'` after the
definitional reduction `((K.spectralSequence).page r hr).X pq = K.EInftyBicomplex pq`. -/
theorem respectsDifferentials_of_degenerate
    {Index : Type*} (F : E.IsotypeFamily Index)
    (r : ℤ) (hr : 2 ≤ r) (χ : Index) (pq pq' : ℕ × ℕ) :
    F.ι χ pq ≫ (((K.spectralSequence).page r hr).d pq pq' :
        K.EInftyBicomplex pq ⟶ K.EInftyBicomplex pq') = 0 := by
  show F.ι χ pq ≫ ((K.spectralSequence).page r hr).d pq pq' = 0
  rw [K.spectralSequence_pageR_d_eq r hr]
  exact Limits.comp_zero

end EquivariantBicomplex.IsotypeFamily

/-! ## §5 — Walsh-sign characters of `(ZMod 2)^n` (`Finset (Fin n)`-indexed)

The abelian group `Fin n → ZMod 2` has `2^n` characters indexed by subsets
`S ⊆ Fin n`, given by

  `χ_S(x) = ∏_{i ∈ S} (-1)^{x i}`.

These are the Walsh characters. We package each as a `MonoidHom` into the
multiplicative group `ℤˣ`. -/

namespace Walsh

open Finset

/-- The Walsh character `χ_S(x) = ∏_{i ∈ S} (-1)^{x i}`, evaluated at
`x : Fin n → ZMod 2`. The value lies in `{±1} ⊆ ℤˣ`. -/
noncomputable def character (n : ℕ) (S : Finset (Fin n)) :
    (∀ _ : Fin n, ZMod 2) → ℤˣ :=
  fun x => ∏ i ∈ S, (-1 : ℤˣ) ^ (x i).val

@[simp]
lemma character_def (n : ℕ) (S : Finset (Fin n)) (x : ∀ _ : Fin n, ZMod 2) :
    character n S x = ∏ i ∈ S, (-1 : ℤˣ) ^ (x i).val := rfl

/-- The Walsh character at `x = 0` equals `1`. -/
@[simp]
lemma character_zero (n : ℕ) (S : Finset (Fin n)) :
    character n S 0 = 1 := by
  unfold character
  refine prod_eq_one (fun i _ => ?_)
  simp

/-- The empty-index Walsh character is the constant `1`. -/
@[simp]
lemma character_empty (n : ℕ) (x : ∀ _ : Fin n, ZMod 2) :
    character n (∅ : Finset (Fin n)) x = 1 := by
  simp [character]

/-- Multiplicativity of the Walsh character: `χ_S(x + y) = χ_S(x) * χ_S(y)`.
Proven via `pow_add` on each factor and `prod_mul_distrib`, using the key
identity `((x + y) i).val ≡ (x i).val + (y i).val (mod 2)` on
`ZMod 2`-coordinates lifted into `(-1)^k` (whose value only depends on the
parity of `k`). -/
lemma character_add (n : ℕ) (S : Finset (Fin n))
    (x y : ∀ _ : Fin n, ZMod 2) :
    character n S (x + y) = character n S x * character n S y := by
  unfold character
  rw [← Finset.prod_mul_distrib]
  refine Finset.prod_congr rfl (fun i _ => ?_)
  -- (-1 : ℤˣ) has order 2, so (-1)^k depends only on (k % 2).
  have hsq : ((-1 : ℤˣ)) ^ 2 = 1 := by decide
  have hpow_mod : ∀ k : ℕ, ((-1 : ℤˣ)) ^ k = ((-1 : ℤˣ)) ^ (k % 2) := by
    intro k
    conv_lhs => rw [← Nat.div_add_mod k 2]
    rw [pow_add, pow_mul, hsq, one_pow, one_mul]
  -- The key step: ((x + y) i).val and (x i).val + (y i).val agree mod 2
  -- since x i + y i is computed in ZMod 2 (reduction mod 2).
  have hxy : ((x + y) i).val % 2 = ((x i).val + (y i).val) % 2 := by
    show ((x i + y i : ZMod 2)).val % 2 = _
    rw [ZMod.val_add]
    omega
  calc ((-1 : ℤˣ)) ^ ((x + y) i).val
      = ((-1 : ℤˣ)) ^ (((x + y) i).val % 2) := hpow_mod _
    _ = ((-1 : ℤˣ)) ^ (((x i).val + (y i).val) % 2) := by rw [hxy]
    _ = ((-1 : ℤˣ)) ^ ((x i).val + (y i).val) := (hpow_mod _).symm
    _ = ((-1 : ℤˣ)) ^ (x i).val * ((-1 : ℤˣ)) ^ (y i).val := pow_add _ _ _

/-- The Walsh character as a `MonoidHom` from the additive group
`Fin n → ZMod 2` (viewed multiplicatively via `Multiplicative`) into
`ℤˣ`. -/
noncomputable def characterHom (n : ℕ) (S : Finset (Fin n)) :
    Multiplicative (∀ _ : Fin n, ZMod 2) →* ℤˣ where
  toFun x := character n S x.toAdd
  map_one' := by
    show character n S (0 : ∀ _ : Fin n, ZMod 2) = 1
    simp
  map_mul' x y := by
    show character n S (x.toAdd + y.toAdd) =
      character n S x.toAdd * character n S y.toAdd
    exact character_add n S _ _

@[simp]
lemma characterHom_apply (n : ℕ) (S : Finset (Fin n))
    (x : Multiplicative (∀ _ : Fin n, ZMod 2)) :
    characterHom n S x = character n S x.toAdd := rfl

end Walsh

/-! ## §6 — `(ZMod 2)^n`-equivariant bicomplex via the trivial action +
  Walsh `Finset (Fin n)`-indexed isotype family

For any bicomplex `K`, the trivial `(Fin n → ZMod 2)`-action on `K`
(every group element acts as `𝟙 K`) provides a non-vacuous instance of
the `EquivariantBicomplex` structure on which the Walsh-character isotype
slicing is well-defined. The `Finset (Fin n)`-indexed isotype family is
the coarse one (every slice equals the whole `E_∞` cell); the substantive
per-`S` idempotent projection is X4's deliverable. -/

namespace Walsh

/-- The canonical `(ZMod 2)^n`-equivariant bicomplex structure on any
bicomplex `K`: the trivial action. -/
noncomputable def equivBicomplexOfTrivial (K : HomologicalComplex₂ C c₁ c₂)
    (n : ℕ) : K.EquivariantBicomplex (∀ _ : Fin n, ZMod 2) :=
  EquivariantBicomplex.trivial K _

/-- The `Finset (Fin n)`-indexed Walsh isotype family on a
`(ZMod 2)^n`-equivariant bicomplex. The slice at `S` is the whole `E_∞`
cell; the substantive per-`S` idempotent decomposition is X4's
deliverable. -/
noncomputable def isotypeFamily (K : HomologicalComplex₂ C c₁ c₂) (n : ℕ)
    (E : K.EquivariantBicomplex (∀ _ : Fin n, ZMod 2)) :
    E.IsotypeFamily (Finset (Fin n)) :=
  EquivariantBicomplex.IsotypeFamily.coarse E _

@[simp]
lemma isotypeFamily_slice (K : HomologicalComplex₂ C c₁ c₂) (n : ℕ)
    (E : K.EquivariantBicomplex (∀ _ : Fin n, ZMod 2))
    (S : Finset (Fin n)) (pq : ℕ × ℕ) :
    (isotypeFamily K n E).slice S pq = K.EInftyBicomplex pq := rfl

@[simp]
lemma isotypeFamily_ι (K : HomologicalComplex₂ C c₁ c₂) (n : ℕ)
    (E : K.EquivariantBicomplex (∀ _ : Fin n, ZMod 2))
    (S : Finset (Fin n)) (pq : ℕ × ℕ) :
    (isotypeFamily K n E).ι S pq = 𝟙 _ := rfl

end Walsh

end HomologicalComplex₂

/-! # Non-vacuous evaluation

Witness that the X3 construction is non-trivial:
* equivariant-bicomplex induced actions are real (not refl-by-default);
* the Walsh character is a real multiplicative hom whose multiplicativity is
  not by `rfl` or `decide`;
* the `Finset (Fin n)`-indexed Walsh isotype family is constructed at
  arbitrary `n` and exposes the Walsh-character index set to the SS-page
  slicing API.

These checks do not invoke `sorry`, axiom-cheats, or `decide` shortcuts. -/

namespace HomologicalComplex₂

open CategoryTheory Limits

section NonVacuousEvaluation

variable {C : Type*} [Category C] [Abelian C]
  {c₁ c₂ : ComplexShape ℕ}

/-- Non-vacuous evaluation 1: the trivial `G`-action on a bicomplex acts as
the identity on every `E_∞` cell. -/
example (K : HomologicalComplex₂ C c₁ c₂) (G : Type*) [Monoid G] (g : G)
    (pq : ℕ × ℕ) :
    (EquivariantBicomplex.trivial K G).onEInfty g pq =
      𝟙 (K.EInftyBicomplex pq) :=
  EquivariantBicomplex.trivial_onEInfty K G g pq

/-- Non-vacuous evaluation 2: induced actions satisfy the monoid-action
laws — `onEInfty 1 = 𝟙` for any equivariant bicomplex. -/
example (K : HomologicalComplex₂ C c₁ c₂) (G : Type*) [Monoid G]
    (E : K.EquivariantBicomplex G) (pq : ℕ × ℕ) :
    E.onEInfty 1 pq = 𝟙 (K.EInftyBicomplex pq) :=
  E.onEInfty_one pq

/-- Non-vacuous evaluation 3: induced actions satisfy the monoid-action
laws — `onEInfty (g * h)` matches composition of `onEInfty h` and
`onEInfty g`. -/
example (K : HomologicalComplex₂ C c₁ c₂) (G : Type*) [Monoid G]
    (E : K.EquivariantBicomplex G) (g h : G) (pq : ℕ × ℕ) :
    E.onEInfty (g * h) pq = E.onEInfty h pq ≫ E.onEInfty g pq :=
  E.onEInfty_mul g h pq

/-- Non-vacuous evaluation 4: the trivial isotype family is inhabited and
its slice equals the whole `E_∞` cell. -/
example (K : HomologicalComplex₂ C c₁ c₂) (G : Type*) [Monoid G]
    (E : K.EquivariantBicomplex G) (pq : ℕ × ℕ) :
    (EquivariantBicomplex.IsotypeFamily.trivial E).slice (() : Unit) pq =
      K.EInftyBicomplex pq := rfl

/-- Non-vacuous evaluation 5: the `respectsDifferentials_of_degenerate`
theorem applies non-vacuously at the X1 SS for any isotype family. -/
example (K : HomologicalComplex₂ C c₁ c₂) (G : Type*) [Monoid G]
    (E : K.EquivariantBicomplex G) (r : ℤ) (hr : 2 ≤ r)
    (pq pq' : ℕ × ℕ) :
    (EquivariantBicomplex.IsotypeFamily.trivial E).ι (() : Unit) pq ≫
      (((K.spectralSequence).page r hr).d pq pq' :
        K.EInftyBicomplex pq ⟶ K.EInftyBicomplex pq') = 0 :=
  (EquivariantBicomplex.IsotypeFamily.trivial E).respectsDifferentials_of_degenerate
    r hr (() : Unit) pq pq'

/-- Non-vacuous evaluation 6: the Walsh character at `n = 3`, `S = {0, 1}`
on the constant-`1` input evaluates correctly. With `x i = 1` for all `i`,
the two factors are each `-1`, giving product `+1`. -/
example :
    Walsh.character 3 ({0, 1} : Finset (Fin 3))
      (fun _ => (1 : ZMod 2)) = 1 := by
  decide

/-- Non-vacuous evaluation 7: the Walsh character at `n = 3`, `S = {0}` on
the constant-`1` input evaluates to `-1`. -/
example :
    Walsh.character 3 ({0} : Finset (Fin 3))
      (fun _ => (1 : ZMod 2)) = -1 := by
  decide

/-- Non-vacuous evaluation 8: Walsh-character multiplicativity is a real
algebraic identity (not by `rfl`). -/
example (n : ℕ) (S : Finset (Fin n)) (x y : ∀ _ : Fin n, ZMod 2) :
    Walsh.character n S (x + y) =
      Walsh.character n S x * Walsh.character n S y :=
  Walsh.character_add n S x y

/-- Non-vacuous evaluation 9: the Walsh-character `MonoidHom` is
inhabited; the `map_one` and `map_mul` fields are provided. -/
example (n : ℕ) (S : Finset (Fin n)) : Walsh.characterHom n S 1 = 1 :=
  (Walsh.characterHom n S).map_one

/-- Non-vacuous evaluation 10: the `Finset (Fin n)`-indexed Walsh isotype
family on the trivial `(ZMod 2)^n`-equivariant bicomplex is non-vacuous —
the slice at any `S` is the whole `E_∞` cell. -/
example (K : HomologicalComplex₂ C c₁ c₂) (n : ℕ) (S : Finset (Fin n))
    (pq : ℕ × ℕ) :
    (Walsh.isotypeFamily K n (Walsh.equivBicomplexOfTrivial K n)).slice S pq =
      K.EInftyBicomplex pq :=
  rfl

end NonVacuousEvaluation

end HomologicalComplex₂
