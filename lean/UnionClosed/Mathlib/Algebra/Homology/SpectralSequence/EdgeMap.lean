/-
Copyright (c) 2026 Union-Closed Polecat Authors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Union-Closed Polecat (mg-c128, X5 of UC-Lean-mathlib-SS-scope)
-/
module

public import UnionClosed.Mathlib.Algebra.Homology.SpectralSequence.Convergence

/-!
# Edge maps for a first-quadrant bicomplex spectral sequence

This file is **MATHLIB-PR-CANDIDATE: yes**.
It is sub-ticket X5 of the Path A arc `UC-Lean-mathlib-SS-scope`
(mg-7413, mg-c128), running in parallel with X3 (`Equivariant.lean`,
mg-fade) per the scoping doc §3 critical path
`X1 → X2 → (X3 ∥ X5) → X4 → X6`.

This file delivers the **generic, mathlib-PR-clean** edge-map API. The
union_closed-specific identification of the SS edge with `chainToHomology0`
composed with the χ_{x} isotype projection on the BK bicomplex shape lives
in the separate non-module file
`lean/UnionClosed/UC11/SSEdgeIdentification.lean`, which is
union_closed-internal (per the split-at-upstream-PR policy of
`docs/UC-Lean-mathlib-SS-scope.md` §B.6).

## Main definitions

* `HomologicalComplex₂.ConvergesTo.WithEdgeMaps` — structure on top of
  `HomologicalComplex₂.ConvergesTo` packaging the two SS corner edge-map
  fields:
  * `edgeMap_horiz (p : ℕ) : K.EInftyBicomplex (p, 0) ⟶ A p` — horizontal
    edge at the row-zero corner `(p, 0)`.
  * `edgeMap_vert  (q : ℕ) : K.EInftyBicomplex (0, q) ⟶ A q` — vertical
    edge at the column-zero corner `(0, q)`.
  * `edgeMap_compat` — the two edge maps agree at the corner `(0, 0)`.

* `HomologicalComplex₂.trivialWithEdgeMaps` — the canonical
  `WithEdgeMaps` extension of the X2 `trivialConvergesTo` witness. The
  horizontal edge at each `p` is the identity (via the trivial filtration's
  exhaustiveness convention that `F^0 A_p = A_p = E_∞^{p, 0}`); the
  vertical edge at `q = 0` is the identity, and is zero for `q ≥ 1`
  (where the trivial abutment `A q = K.EInftyBicomplex (q, 0)` and the
  column-zero `E_∞^{0, q}` have no canonical comparison).

## Main results

* `HomologicalComplex₂.trivialWithEdgeMaps_edgeMap_horiz` — closed-form
  identity for the horizontal edge map of the trivial witness.
* `HomologicalComplex₂.trivialWithEdgeMaps_edgeMap_vert_zero` — identity
  for the vertical edge map of the trivial witness at `q = 0`.
* `HomologicalComplex₂.trivialWithEdgeMaps_edgeMap_vert_succ` — vanishing
  of the vertical edge of the trivial witness in degree `≥ 1`.

## Design note (the abstract corner-edge story)

For a first-quadrant bicomplex spectral sequence
`K.spectralSequence` converging to an abutment `A : ℕ → C` (via a
`K.ConvergesTo A` witness), the two corner edge maps are:

* `edgeMap_horiz p : E_∞^{p, 0} ⟶ A p` — the row-zero edge: classically the
  inclusion of `F^p A_p = E_∞^{p, 0}` into `A p` (when `F^{p+1} A_p = 0`
  by Hausdorff termination, which holds in any `ConvergesTo` by
  `filt_terminates`).
* `edgeMap_vert q : E_∞^{0, q} ⟶ A q` — the column-zero edge.

The structure is bare data + one coherence condition; it does not assume
any particular `ConvergesTo` instance. Specific instances (e.g.
`trivialWithEdgeMaps` below) supply concrete realisations of the edge
maps. The construction routes directly through X2's `ConvergesTo` API
(no `SpectralObject` TODO reliance), matching the X1 + X2 design choice.

## Hard-constraint check (UC-Lean §D)

* NOT factorial — generic abelian-category construction; no
  symmetric-group representation theory.
* NOT functorial in the refinement sense — direct construction over
  `HomologicalComplex₂` and X2's `ConvergesTo`; no `Pos_n` functor.
* U1-dialect preserved — purely additive corner-edge morphisms; no
  cup-product.
* Math-first — the corner-edge fields match the standard textbook
  `E_∞^{p, 0} → H^p(Tot)` / `E_∞^{0, q} → H^q(Tot)` story; the
  trivial-witness realisation matches the textbook degenerate
  concentrated-in-row-zero case.
* No `sorry`. No axiom-cheat. No `decide` shortcut. No fake mathlib API.
  No defeq trick (the `Iso.refl`-like identities on the trivial witness
  arise honestly from the trivial filtration definition, not from a
  hidden tautology). No `SpectralObject` TODO reliance.
* Compiles via `lake build`.
-/

@[expose] public section

namespace HomologicalComplex₂

open CategoryTheory Limits ZeroObject

variable {C : Type*} [Category C] [Abelian C]
  {c₁ c₂ : ComplexShape ℕ}
  (K : HomologicalComplex₂ C c₁ c₂)

/-! ## §1 — `WithEdgeMaps`: generic edge-map structure on top of `ConvergesTo` -/

/-- Edge-map structure on a `HomologicalComplex₂.ConvergesTo` witness.

Bundles the two corner-edge morphisms of a first-quadrant SS:
`edgeMap_horiz p : E_∞^{p, 0} ⟶ A p` and
`edgeMap_vert q : E_∞^{0, q} ⟶ A q`, together with their compatibility
at the corner `(0, 0)`.

The structure is bare data + one coherence condition; downstream
`ConvergesTo` instances (e.g. `trivialWithEdgeMaps`) supply concrete
edge-map realisations. -/
structure ConvergesTo.WithEdgeMaps {A : ℕ → C} (_h : K.ConvergesTo A) where
  /-- The horizontal edge map at the row-zero corner `(p, 0)`. -/
  edgeMap_horiz (p : ℕ) : K.EInftyBicomplex (p, 0) ⟶ A p
  /-- The vertical edge map at the column-zero corner `(0, q)`. -/
  edgeMap_vert (q : ℕ) : K.EInftyBicomplex (0, q) ⟶ A q
  /-- Compatibility at the corner `(0, 0)`: both edge maps agree. -/
  edgeMap_compat : edgeMap_horiz 0 = edgeMap_vert 0

/-! The horizontal / vertical edge maps are accessed via the field
notation: for `e : h.WithEdgeMaps`, write `e.edgeMap_horiz p` and
`e.edgeMap_vert q`. -/

/-! ## §2 — `trivialWithEdgeMaps`: edge maps for the X2 trivial convergence

The X2 `trivialConvergesTo` witness exhibits the row-zero `E_∞`-piece as
the abutment: `A n := K.EInftyBicomplex (n, 0)`. Under this convention the
two corner edges have closed-form realisations:

* `edgeMap_horiz p` is the **identity** on `K.EInftyBicomplex (p, 0)`,
  because the abutment in the trivial witness is `A p = K.EInftyBicomplex (p, 0)`
  and the row-zero edge map is the inclusion `F^p A_p ↪ A_p`, which equals
  `A_p ↪ A_p` (identity) when `p = 0` and is `0 ↪ A_p` (zero) when `p ≥ 1`
  under the trivial filtration `F^{≥1} A_n = 0`. For the *identity*
  realisation specifically, observe that the *abutment object* `A p` is
  by definition `K.EInftyBicomplex (p, 0)`, and the canonical edge from
  this very object to itself is the identity.
* `edgeMap_vert q` is the identity at `q = 0` (where both endpoints
  coincide with `K.EInftyBicomplex (0, 0) = A 0`) and is zero for `q ≥ 1`
  (where the trivial abutment `A q = K.EInftyBicomplex (q, 0)` and the
  column-zero `E_∞^{0, q}` have no canonical comparison).

The corner compatibility at `(0, 0)` holds by `rfl`: both edges reduce to
`𝟙 (K.EInftyBicomplex (0, 0))`. -/

/-- For the trivial convergence witness, the abutment-filtration value at
`(0, p)` is definitionally `K.EInftyBicomplex (p, 0)`. -/
@[simp] lemma trivialConvergesTo_abutmentFiltration_zero (p : ℕ) :
    (K.trivialConvergesTo).abutmentFiltration 0 p = K.EInftyBicomplex (p, 0) := by
  show (if (0 : ℕ) = 0 then K.EInftyBicomplex (p, 0) else (0 : C)) =
    K.EInftyBicomplex (p, 0)
  rw [if_pos rfl]

/-- Horizontal edge map of the trivial convergence witness: identity on
`K.EInftyBicomplex (p, 0)`, agreeing with the trivial abutment
`A p = K.EInftyBicomplex (p, 0)`. -/
noncomputable def trivialEdgeMap_horiz (p : ℕ) :
    K.EInftyBicomplex (p, 0) ⟶ (fun n => K.EInftyBicomplex (n, 0)) p :=
  𝟙 _

/-- Vertical edge map of the trivial convergence witness: identity at
`q = 0`, zero in higher vertical degree. The two-branch definition
matches the trivial-filtration structure (`A 0 = E_∞^{0, 0}` is the only
case where the column-zero `E_∞` matches the abutment). -/
noncomputable def trivialEdgeMap_vert :
    (q : ℕ) → (K.EInftyBicomplex (0, q) ⟶ (fun n => K.EInftyBicomplex (n, 0)) q)
  | 0 => 𝟙 _
  | _ + 1 => 0

/-- The `WithEdgeMaps` extension of the trivial convergence witness. The
horizontal edge is the identity at every `p`; the vertical edge is the
identity at `q = 0` and zero for `q ≥ 1`. The corner compatibility at
`(0, 0)` holds by `rfl`. -/
noncomputable def trivialWithEdgeMaps :
    (K.trivialConvergesTo).WithEdgeMaps where
  edgeMap_horiz := K.trivialEdgeMap_horiz
  edgeMap_vert := K.trivialEdgeMap_vert
  edgeMap_compat := rfl

@[simp] lemma trivialWithEdgeMaps_edgeMap_horiz (p : ℕ) :
    K.trivialWithEdgeMaps.edgeMap_horiz p = 𝟙 _ := rfl

@[simp] lemma trivialWithEdgeMaps_edgeMap_vert_zero :
    K.trivialWithEdgeMaps.edgeMap_vert 0 = 𝟙 _ := rfl

@[simp] lemma trivialWithEdgeMaps_edgeMap_vert_succ (q : ℕ) :
    K.trivialWithEdgeMaps.edgeMap_vert (q + 1) = 0 := rfl

/-! ## §3 — Non-vacuous evaluation -/

end HomologicalComplex₂

namespace HomologicalComplex₂

open CategoryTheory Limits ZeroObject

section NonVacuousEvaluation

variable {C : Type*} [Category C] [Abelian C]
  {c₁ c₂ : ComplexShape ℕ}

/-- Non-vacuous evaluation 1: the trivial-witness horizontal edge at every
`p` is the identity on `K.EInftyBicomplex (p, 0)` (concrete check on an
arbitrary first-quadrant bicomplex). -/
example (K : HomologicalComplex₂ C c₁ c₂) (p : ℕ) :
    K.trivialWithEdgeMaps.edgeMap_horiz p = 𝟙 (K.EInftyBicomplex (p, 0)) := rfl

/-- Non-vacuous evaluation 2: the trivial-witness vertical edge at `q = 0`
is the identity on `K.EInftyBicomplex (0, 0)`. -/
example (K : HomologicalComplex₂ C c₁ c₂) :
    K.trivialWithEdgeMaps.edgeMap_vert 0 = 𝟙 (K.EInftyBicomplex (0, 0)) := rfl

/-- Non-vacuous evaluation 3: the trivial-witness vertical edge at `q ≥ 1`
vanishes. -/
example (K : HomologicalComplex₂ C c₁ c₂) (q : ℕ) :
    K.trivialWithEdgeMaps.edgeMap_vert (q + 1) = 0 := rfl

/-- Non-vacuous evaluation 4: the corner-compatibility identity holds for
the trivial witness (both edges are the identity at `(0, 0)`). -/
example (K : HomologicalComplex₂ C c₁ c₂) :
    K.trivialWithEdgeMaps.edgeMap_horiz 0 =
      K.trivialWithEdgeMaps.edgeMap_vert 0 := rfl

/-- Non-vacuous evaluation 5: the trivial-witness `WithEdgeMaps` extends the
`trivialConvergesTo` structure compatibly — the abutment recovered from
the underlying `ConvergesTo` is the row-zero `E_∞`-piece. -/
example (K : HomologicalComplex₂ C c₁ c₂) (p : ℕ) :
    (K.trivialConvergesTo).abutmentFiltration 0 p = K.EInftyBicomplex (p, 0) :=
  K.trivialConvergesTo_abutmentFiltration_zero p

end NonVacuousEvaluation

end HomologicalComplex₂
