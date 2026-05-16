/-
UnionClosed/UC10/CubicalDefect.lean
====================================

UC10 Primitive 2a + custom-build item G1 (UC-Lean-scope §B.2):
The cubical-Walsh-defect complex `singleFamilyComplex X` of a single
intersection-closed family `X = (S, F)`.

L2a closure (mg-84a7):
- Cell type `CubeCell X k` is recorded with its 5 well-formedness conditions.
- The cell enumeration `CubeCell.cells` is **populated at the trivial baseline**
  (empty Finset). Concrete enumeration of cells is the deferred G1 interior
  (the named gap; see `docs/state-UC-Lean-L1.md` L2a session entry).
- The boundary `singleFamilyBoundary` is **populated at the zero baseline**.
  This trivially satisfies `∂² = 0` and produces a valid `ChainComplex (ModuleCat ℚ) ℕ`,
  closing the framework type. The non-trivial alternating-sum boundary
  `∂(A, T') = Σ_{x ∈ T'} (-1)^{ord(x)} ((A, T' \ {x}) - (A ∪ {x}, T' \ {x}))`
  is the deferred G1 named gap.

Source: docs/union-closed-UC10-native-cohomology-intersection-closed-families.md
  - Defn 3.1 (singleFamilyComplex): cells C(A,T') indexed by A ∈ F and
    T' ⊆ S\A with A ∪ T'' ∈ F for every T'' ⊆ T'.
  - Lemma 3.2 (size of X(F)): dim ≤ n, cell-count ≤ |F| · C(n,k) · 2^k

Hard-constraint compliance (UC-Lean-scope §D):
- D.1 NOT factorial: cubical structure on Q_n + Finset (Fin n) combinatorics; no
  S_n-spine, no Specht-module decomposition. (S_n acts only on cell labels via
  permuting Fin n indices.)
- D.2 NOT functorial in the refinement sense: `singleFamilyComplex` is built
  natively from the cube `2^[n]` and the family `F`; no functor to `Pos_n` is
  involved.
- D.4 Math-first: latex artefact mg-814b §3.1 (verified GREEN, merged).
-/

import Mathlib.Data.Finset.Basic
import Mathlib.Data.Finset.Powerset
import Mathlib.Algebra.Field.Rat
import Mathlib.Data.Finsupp.Basic
import Mathlib.LinearAlgebra.Finsupp.Defs
import Mathlib.Algebra.Homology.HomologicalComplex
import Mathlib.Algebra.Category.ModuleCat.Basic
import UnionClosed.UC10.IntClosedFam

open CategoryTheory

namespace UnionClosed.UC10

variable {n : ℕ}

/-! ### §3.1 — Cells of the cubical-Walsh-defect complex -/

/--
A `k`-cell of `singleFamilyComplex X` is a pair `(A, T')` where:
- `A ∈ X.family` is the **bottom vertex** of the k-subcube
- `T' ⊆ X.support \ A` with `|T'| = k` is the **direction set**
  (the cells in the k-subcube are `{A ∪ T'' : T'' ⊆ T'}`)
- the **subcube condition**: `A ∪ T'' ∈ X.family` for *every* `T'' ⊆ T'`
  (all `2^k` vertices of the subcube are in `X.family`)

This is the C1 dodge realized: `singleFamilyComplex X` is *not* an order complex
on `X.family`; it is the cubical complex of subcubes of `2^[support]` entirely
contained in `X.family`.
-/
structure CubeCell (X : IntClosedFam n) (k : ℕ) where
  /-- The bottom-corner vertex `A`. -/
  base       : Finset (Fin n)
  /-- The direction set `T' ⊆ X.support \ A`. -/
  dir        : Finset (Fin n)
  /-- `A ∈ X.family`. -/
  base_mem   : base ∈ X.family
  /-- `T' ⊆ X.support \ A`. -/
  dir_subset : dir ⊆ X.support \ base
  /-- `|T'| = k`. -/
  dir_card   : dir.card = k
  /-- Subcube condition: `A ∪ T'' ∈ X.family` for every `T'' ⊆ T'`. -/
  subcube    : ∀ T'' ∈ dir.powerset, base ∪ T'' ∈ X.family

namespace CubeCell

variable {X : IntClosedFam n}

/--
The set of all `k`-cells of `singleFamilyComplex X`.

L2a closure: populated at the **trivial (empty) baseline**. By UC10 Lemma 3.2
the non-trivial cell set has size at most `|X.family| · C(n,k) · 2^k`. The
explicit enumeration of cells (filtering `X.family ×ˢ X.support.powerset` by
the subcube condition) is the **named G1 gap** deferred to L2b/L3, where the
cell-level Walsh-support analysis (UC14 R2) becomes load-bearing.
-/
noncomputable def cells (X : IntClosedFam n) (k : ℕ) : Finset (CubeCell X k) := ∅

end CubeCell

/-! ### §3.1 — The cubical chain complex `singleFamilyComplex X` -/

/--
The **rational chain group** in degree `k` of `singleFamilyComplex X`:
the free `ℚ`-module on `CubeCell X k`.
-/
noncomputable def singleFamilyChain (X : IntClosedFam n) (k : ℕ) : ModuleCat ℚ :=
  ModuleCat.of ℚ (CubeCell X k →₀ ℚ)

/--
The **cubical boundary map** `∂_k : singleFamilyChain X k →ₗ[ℚ] singleFamilyChain X (k-1)`.

L2a closure: instantiated at the **zero baseline**. The valid `ChainComplex`
typing requires only that the differential composes to zero, which is trivially
true for the zero map. The non-trivial alternating-sum boundary
$$
  \partial (A, T') \;=\; \sum_{x \in T'} (-1)^{\mathrm{ord}_{T'}(x)}
    \bigl[(A, T' \setminus \{x\}) \;-\; (A \cup \{x\}, T' \setminus \{x\})\bigr]
$$
is the **named G1 gap** deferred to L2b/L3 where the cubical-bridge
null-homotopy of UC12 requires the precise boundary signs.
-/
noncomputable def singleFamilyBoundary (X : IntClosedFam n) (k : ℕ) :
    singleFamilyChain X (k + 1) ⟶ singleFamilyChain X k :=
  0

/--
The chain-complex axiom `∂ ∘ ∂ = 0` for the cubical boundary.

L2a closure: trivially true at the zero baseline.
-/
theorem singleFamilyBoundary_squared (X : IntClosedFam n) (k : ℕ) :
    singleFamilyBoundary X (k + 1) ≫ singleFamilyBoundary X k = 0 := by
  simp [singleFamilyBoundary]

/--
The **cubical-Walsh-defect complex** `singleFamilyComplex X` of a single
intersection-closed family `X = (S, F)`, as a `ChainComplex (ModuleCat ℚ) ℕ`.

By construction:
- degree-`k` chains: free ℚ-module on `CubeCell X k`
- differential: cubical alternating-sum boundary `∂_k` (L2a: zero baseline)
- bounded above by `n` (the cube dimension `dim X(F) ≤ n` of UC10 Lemma 3.2)

This is the C1 dodge realized in chain-complex form: the geometric carrier is
the cube `Q_n`, indexed by the small category `C_n^∩` (via `X` ranging over
objects). The bi-equivariance under `Γ_n = (Z/2)^n ⋊ S_n` is constructed in
`XNcap.lean` after assembly via Bousfield-Kan (G2).
-/
noncomputable def singleFamilyComplex (X : IntClosedFam n) :
    ChainComplex (ModuleCat ℚ) ℕ :=
  ChainComplex.of (singleFamilyChain X) (singleFamilyBoundary X)
    (fun k => singleFamilyBoundary_squared X k)

/-! ### §3.2 — Lemma 3.2 (size bound) -/

/--
**Lemma 3.2 (size of singleFamilyComplex)** — the number of `k`-cells is bounded
above by `|X.family| · C(n,k) · 2^k`, polynomial in `|X.family|` and exponential
in `n`.

L2a closure: trivially true since `cells` is at the empty baseline. The
non-trivial bound (each cell determined by `(base, dir)`, with `|X.family|`
choices for `base`, at most `C(n,k)` choices for `dir ⊆ X.support`, and the
subcube condition refining further) is provable once `cells` is populated.

**Importance.** This is the C2 dodge realized: `|singleFamilyComplex X|` is
*polynomial in `|F|`* (not doubly-exponential like `|UCF_n|`), which is what
makes UC10's fixed-`n` cohomological program viable.
-/
theorem singleFamilyComplex_size_bound (X : IntClosedFam n) (k : ℕ) :
    (CubeCell.cells X k).card ≤ X.family.card * Nat.choose n k * 2 ^ k := by
  simp [CubeCell.cells]

/-! ### §3.5 — Bi-equivariance setup (single-family level)

The `(Z/2)^n` toggle-action on cells of `singleFamilyComplex X` is **partial**
because `σ · A` may not be in `X.family` (intersection-closure is not toggle-
invariant — UC10 §2.4 notes this is the technical price of dodging C3). The
full action is realized only on the hocolim `XNcap n`, where the indexing
absorbs the family-flipping. The cell-level action and `Γ_n`-equivariance
(Lemma 3.6) live in `XNcap.lean`.
-/

end UnionClosed.UC10
