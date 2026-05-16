/-
UnionClosed/UC10/CubicalDefect.lean
====================================

UC10 Primitive 2a + custom-build item G1 (UC-Lean-scope §B.2):
The cubical-Walsh-defect complex `singleFamilyComplex X` of a single
intersection-closed family `X = (S, F)`.

L2a-residual closure (mg-bf3e):
- `CubeCell X k` retains its 5 well-formedness conditions (unchanged).
- The cell enumeration `CubeCell.cells` is **populated concretely** as
  `Finset.univ` over the `Fintype` instance on `CubeCell X k`.
- Face maps `CubeCell.faceOff`, `CubeCell.faceOn` are populated concretely:
  removing `x` from `dir` keeps base (`faceOff`) or adds `x` to base (`faceOn`).
- The boundary `singleFamilyBoundary` is the concrete alternating sum
  `∂(A, T') = Σ_{x ∈ T'} (-1)^{ord(x)} ((A, T' \ {x}) - (A ∪ {x}, T' \ {x}))`
  where `ord(x) = |T' ∩ {z : z < x}|` is the position of `x` in the natural
  Fin-ordering.
- `singleFamilyBoundary_squared` is the **concrete face-pair-cancellation
  proof**: each ordered pair `(x, y)` with `x ≠ y` in `T'` contributes a sign
  whose swap `(y, x)` produces an opposite sign on the same 4-vertex pattern,
  causing the unordered-pair contribution to cancel.

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
import Mathlib.Data.Fintype.Powerset
import Mathlib.Data.Fintype.Prod
import Mathlib.Algebra.Field.Rat
import Mathlib.Data.Finsupp.Basic
import Mathlib.LinearAlgebra.Finsupp.LSum
import Mathlib.LinearAlgebra.Finsupp.LinearCombination
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

/-- Two cells are equal when their data fields `(base, dir)` agree. Proof
fields are propositions and thus proof-irrelevant. -/
@[ext] theorem ext {k : ℕ} {c₁ c₂ : CubeCell X k}
    (hb : c₁.base = c₂.base) (hd : c₁.dir = c₂.dir) : c₁ = c₂ := by
  rcases c₁ with ⟨b₁, d₁, _, _, _, _⟩
  rcases c₂ with ⟨b₂, d₂, _, _, _, _⟩
  cases hb; cases hd; rfl

/-- Injection of `CubeCell X k` into the finite type
`Finset (Fin n) × Finset (Fin n)` via `c ↦ (c.base, c.dir)`. -/
def toPair {k : ℕ} (c : CubeCell X k) : Finset (Fin n) × Finset (Fin n) :=
  (c.base, c.dir)

theorem toPair_injective (X : IntClosedFam n) (k : ℕ) :
    Function.Injective (toPair (X := X) (k := k)) := by
  intro c₁ c₂ h
  have hb : c₁.base = c₂.base := congrArg Prod.fst h
  have hd : c₁.dir = c₂.dir := congrArg Prod.snd h
  exact ext hb hd

/-- `CubeCell X k` is a finite type: it injects into the finite type
`Finset (Fin n) × Finset (Fin n)`. -/
noncomputable instance instFintype (X : IntClosedFam n) (k : ℕ) :
    Fintype (CubeCell X k) :=
  Fintype.ofInjective _ (toPair_injective X k)

noncomputable instance instDecEq (X : IntClosedFam n) (k : ℕ) :
    DecidableEq (CubeCell X k) :=
  Classical.decEq _

/--
The set of all `k`-cells of `singleFamilyComplex X`, populated as
`Finset.univ` over the `Fintype` instance.

L2a-residual closure: this is the concrete enumeration, not the L2a empty
baseline. Non-trivial whenever there exists at least one valid `(base, dir)`
pair — which happens already at `k = 0` (the `dir = ∅` case), since
`base = X.support` satisfies all five conditions trivially.
-/
noncomputable def cells (X : IntClosedFam n) (k : ℕ) : Finset (CubeCell X k) :=
  Finset.univ

@[simp] theorem mem_cells {k : ℕ} (c : CubeCell X k) : c ∈ cells X k :=
  Finset.mem_univ c

end CubeCell

/-! ### §3.1 — Face maps `faceOff` and `faceOn` -/

namespace CubeCell

variable {X : IntClosedFam n}

/-- `faceOff` removes coordinate `x` from `dir`, keeping the base. -/
noncomputable def faceOff {k : ℕ} (c : CubeCell X (k+1)) {x : Fin n}
    (hx : x ∈ c.dir) : CubeCell X k where
  base       := c.base
  dir        := c.dir.erase x
  base_mem   := c.base_mem
  dir_subset := by
    intro y hy
    exact c.dir_subset (Finset.mem_of_mem_erase hy)
  dir_card   := by
    rw [Finset.card_erase_of_mem hx, c.dir_card]; omega
  subcube    := by
    intro T'' hT''
    refine c.subcube T'' (Finset.mem_powerset.mpr ?_)
    exact (Finset.mem_powerset.mp hT'').trans (Finset.erase_subset _ _)

/-- `faceOn` removes coordinate `x` from `dir` and adds it to the base. -/
noncomputable def faceOn {k : ℕ} (c : CubeCell X (k+1)) {x : Fin n}
    (hx : x ∈ c.dir) : CubeCell X k where
  base       := c.base ∪ {x}
  dir        := c.dir.erase x
  base_mem   := by
    have : (c.base ∪ {x} : Finset (Fin n)) = c.base ∪ {x} := rfl
    refine c.subcube {x} (Finset.mem_powerset.mpr ?_)
    intro z hz
    rw [Finset.mem_singleton] at hz
    exact hz ▸ hx
  dir_subset := by
    intro y hy
    have hy' : y ∈ c.dir := Finset.mem_of_mem_erase hy
    have hyx : y ≠ x := Finset.ne_of_mem_erase hy
    have hyS : y ∈ X.support \ c.base := c.dir_subset hy'
    rcases Finset.mem_sdiff.mp hyS with ⟨hySsup, hyNotBase⟩
    refine Finset.mem_sdiff.mpr ⟨hySsup, ?_⟩
    intro hy_in_baseUx
    rcases Finset.mem_union.mp hy_in_baseUx with hb | hxsing
    · exact hyNotBase hb
    · exact hyx (Finset.mem_singleton.mp hxsing)
  dir_card   := by
    rw [Finset.card_erase_of_mem hx, c.dir_card]; omega
  subcube    := by
    intro T'' hT''
    have hT''_sub : T'' ⊆ c.dir.erase x := Finset.mem_powerset.mp hT''
    have step : ({x} ∪ T'' : Finset (Fin n)) ⊆ c.dir := by
      intro y hy
      rcases Finset.mem_union.mp hy with hy | hy
      · rw [Finset.mem_singleton] at hy; subst hy; exact hx
      · exact Finset.mem_of_mem_erase (hT''_sub hy)
    have hrel : c.base ∪ {x} ∪ T'' = c.base ∪ ({x} ∪ T'') := by
      rw [Finset.union_assoc]
    rw [hrel]
    exact c.subcube ({x} ∪ T'') (Finset.mem_powerset.mpr step)

@[simp] theorem faceOff_base {k : ℕ} (c : CubeCell X (k+1)) {x : Fin n}
    (hx : x ∈ c.dir) : (c.faceOff hx).base = c.base := rfl

@[simp] theorem faceOff_dir {k : ℕ} (c : CubeCell X (k+1)) {x : Fin n}
    (hx : x ∈ c.dir) : (c.faceOff hx).dir = c.dir.erase x := rfl

@[simp] theorem faceOn_base {k : ℕ} (c : CubeCell X (k+1)) {x : Fin n}
    (hx : x ∈ c.dir) : (c.faceOn hx).base = c.base ∪ {x} := rfl

@[simp] theorem faceOn_dir {k : ℕ} (c : CubeCell X (k+1)) {x : Fin n}
    (hx : x ∈ c.dir) : (c.faceOn hx).dir = c.dir.erase x := rfl

/-! ### Face composition lemmas

The four 2-iterated face cells for an unordered pair `{x, y} ⊆ c.dir`:

  faceOff_y (faceOff_x c) = faceOff_x (faceOff_y c)        — "remove both, keep base"
  faceOn_y  (faceOff_x c) = faceOff_x (faceOn_y c)         — "remove x, add y"
  faceOff_y (faceOn_x c)  = faceOn_x (faceOff_y c)         — "remove y, add x"
  faceOn_y  (faceOn_x c)  = faceOn_x (faceOn_y c)          — "add both"

These four composition equalities are the four-vertex symmetry that pairs up
ordered pairs `(x, y) ↔ (y, x)` in the `∂² = 0` argument.
-/

theorem faceOff_faceOff_comm {k : ℕ} (c : CubeCell X (k+2)) {x y : Fin n}
    (hx : x ∈ c.dir) (hy : y ∈ c.dir) (hxy : x ≠ y) :
    (c.faceOff hx).faceOff (by rw [faceOff_dir]; exact Finset.mem_erase.mpr ⟨Ne.symm hxy, hy⟩) =
    (c.faceOff hy).faceOff (by rw [faceOff_dir]; exact Finset.mem_erase.mpr ⟨hxy, hx⟩) := by
  refine CubeCell.ext rfl ?_
  simp only [faceOff_dir]
  exact Finset.erase_right_comm

/-- `faceOff_y ∘ faceOn_x = faceOn_x ∘ faceOff_y` for `x ≠ y` in `c.dir`. -/
theorem faceOff_faceOn_swap {k : ℕ} (c : CubeCell X (k+2)) {x y : Fin n}
    (hx : x ∈ c.dir) (hy : y ∈ c.dir) (hxy : x ≠ y) :
    (c.faceOn hx).faceOff (by rw [faceOn_dir]; exact Finset.mem_erase.mpr ⟨Ne.symm hxy, hy⟩) =
    (c.faceOff hy).faceOn (by rw [faceOff_dir]; exact Finset.mem_erase.mpr ⟨hxy, hx⟩) := by
  refine CubeCell.ext ?_ ?_
  · -- base: LHS = (c.faceOn hx).base = c.base ∪ {x}; RHS = (c.faceOff hy).base ∪ {x} = c.base ∪ {x}.
    simp only [faceOn_base, faceOff_base]
  · simp only [faceOn_dir, faceOff_dir]
    exact Finset.erase_right_comm

/-- `faceOn_y ∘ faceOn_x = faceOn_x ∘ faceOn_y` for `x ≠ y` in `c.dir`. -/
theorem faceOn_faceOn_comm {k : ℕ} (c : CubeCell X (k+2)) {x y : Fin n}
    (hx : x ∈ c.dir) (hy : y ∈ c.dir) (hxy : x ≠ y) :
    (c.faceOn hx).faceOn (by rw [faceOn_dir]; exact Finset.mem_erase.mpr ⟨Ne.symm hxy, hy⟩) =
    (c.faceOn hy).faceOn (by rw [faceOn_dir]; exact Finset.mem_erase.mpr ⟨hxy, hx⟩) := by
  refine CubeCell.ext ?_ ?_
  · -- base: (c.base ∪ {x}) ∪ {y} = (c.base ∪ {y}) ∪ {x}.
    simp only [faceOn_base]
    rw [Finset.union_assoc, Finset.union_assoc, Finset.union_comm ({x} : Finset (Fin n)) {y}]
  · simp only [faceOn_dir]
    exact Finset.erase_right_comm

end CubeCell

/-! ### §3.1 — Sign of a coordinate in a direction set -/

/--
The sign `(-1)^{ord(x in T)}` of a coordinate `x` in a direction set `T`,
where `ord(x in T) = |T ∩ {z : z < x}|` is the position of `x` in `T`
under the natural `Fin n`-ordering.
-/
noncomputable def faceSign (T : Finset (Fin n)) (x : Fin n) : ℚ :=
  (-1 : ℚ) ^ ((T.filter (· < x)).card)

/--
**Sign-cancellation identity** — the load-bearing combinatorial step in the
∂² = 0 proof.

For distinct `x, y ∈ T`:
$$
  \mathrm{faceSign}(T, x) \cdot \mathrm{faceSign}(T \setminus \{x\}, y) +
  \mathrm{faceSign}(T, y) \cdot \mathrm{faceSign}(T \setminus \{y\}, x) = 0.
$$

Proof. WLOG `x < y`. Then in `(T \ {x}).filter (· < y)` we remove `x`
(which lies in `T.filter (· < y)` since `x < y` and `x ∈ T`), so the
cardinality drops by 1; in `(T \ {y}).filter (· < x)` we attempt to remove `y`
but `y ∉ T.filter (· < x)` (since `y > x`), so the cardinality is unchanged.
Setting `a := |T.filter (· < x)|` and `b := |T.filter (· < y)|`, the sum
becomes `(-1)^a · (-1)^{b-1} + (-1)^b · (-1)^a = (-1)^a · ((-1)^{b-1} + (-1)^b) = 0`.
-/
theorem faceSign_swap_cancel (T : Finset (Fin n)) {x y : Fin n}
    (hx : x ∈ T) (hy : y ∈ T) (hxy : x ≠ y) :
    faceSign T x * faceSign (T.erase x) y +
      faceSign T y * faceSign (T.erase y) x = 0 := by
  rcases lt_or_gt_of_ne hxy with hxlty | hyltx
  · -- Case: x < y.
    have h_x_in_filt_y : x ∈ T.filter (· < y) := by
      refine Finset.mem_filter.mpr ⟨hx, hxlty⟩
    have h_y_notin_filt_x : y ∉ T.filter (· < x) := by
      intro hyf; exact lt_asymm hxlty (Finset.mem_filter.mp hyf).2
    -- (T.erase x).filter (· < y) = (T.filter (· < y)).erase x
    have h1 : ((T.erase x).filter (· < y)).card = (T.filter (· < y)).card - 1 := by
      rw [Finset.filter_erase, Finset.card_erase_of_mem h_x_in_filt_y]
    -- (T.erase y).filter (· < x) = T.filter (· < x)  (since y ∉ filter)
    have h2 : ((T.erase y).filter (· < x)).card = (T.filter (· < x)).card := by
      rw [Finset.filter_erase, Finset.erase_eq_of_notMem h_y_notin_filt_x]
    have hb1 : (T.filter (· < y)).card ≥ 1 :=
      Finset.card_pos.mpr ⟨x, h_x_in_filt_y⟩
    unfold faceSign
    rw [h1, h2]
    rcases Nat.exists_eq_succ_of_ne_zero (by omega : (T.filter (· < y)).card ≠ 0)
      with ⟨b', hb_eq⟩
    rw [hb_eq]
    simp only [Nat.succ_sub_one, pow_succ]
    ring
  · -- Case: y < x. Symmetric.
    have h_y_in_filt_x : y ∈ T.filter (· < x) := by
      refine Finset.mem_filter.mpr ⟨hy, hyltx⟩
    have h_x_notin_filt_y : x ∉ T.filter (· < y) := by
      intro hxf; exact lt_asymm hyltx (Finset.mem_filter.mp hxf).2
    have h1 : ((T.erase y).filter (· < x)).card = (T.filter (· < x)).card - 1 := by
      rw [Finset.filter_erase, Finset.card_erase_of_mem h_y_in_filt_x]
    have h2 : ((T.erase x).filter (· < y)).card = (T.filter (· < y)).card := by
      rw [Finset.filter_erase, Finset.erase_eq_of_notMem h_x_notin_filt_y]
    have ha1 : (T.filter (· < x)).card ≥ 1 :=
      Finset.card_pos.mpr ⟨y, h_y_in_filt_x⟩
    unfold faceSign
    rw [h1, h2]
    rcases Nat.exists_eq_succ_of_ne_zero (by omega : (T.filter (· < x)).card ≠ 0)
      with ⟨a', ha_eq⟩
    rw [ha_eq]
    simp only [Nat.succ_sub_one, pow_succ]
    ring

/-! ### §3.1 — The cubical chain complex `singleFamilyComplex X` -/

/--
The **rational chain group** in degree `k` of `singleFamilyComplex X`:
the free `ℚ`-module on `CubeCell X k`.
-/
noncomputable def singleFamilyChain (X : IntClosedFam n) (k : ℕ) : ModuleCat ℚ :=
  ModuleCat.of ℚ (CubeCell X k →₀ ℚ)

/--
The cubical boundary on a single generator `c : CubeCell X (k+1)`:
$$
  \partial (A, T') \;=\; \sum_{x \in T'} (-1)^{\mathrm{ord}_{T'}(x)}
    \bigl[(A, T' \setminus \{x\}) \;-\; (A \cup \{x\}, T' \setminus \{x\})\bigr].
$$

L2a-residual closure: this is the concrete alternating-sum boundary, not the
L2a zero baseline.
-/
noncomputable def boundaryOnGen (X : IntClosedFam n) {k : ℕ} (c : CubeCell X (k+1)) :
    CubeCell X k →₀ ℚ :=
  c.dir.attach.sum fun ⟨x, hx⟩ =>
    faceSign c.dir x •
      (Finsupp.single (c.faceOff hx) (1 : ℚ) - Finsupp.single (c.faceOn hx) (1 : ℚ))

/--
The **cubical boundary map** `∂_k : singleFamilyChain X (k+1) ⟶ singleFamilyChain X k`
as a `ModuleCat ℚ`-morphism, obtained as the linear extension of
`boundaryOnGen X` along the basis of `(CubeCell X (k+1) →₀ ℚ)`.

L2a-residual closure: the linear-extension `Finsupp.linearCombination` of the
concrete `boundaryOnGen`.
-/
noncomputable def singleFamilyBoundary (X : IntClosedFam n) (k : ℕ) :
    singleFamilyChain X (k + 1) ⟶ singleFamilyChain X k :=
  ModuleCat.ofHom (Finsupp.linearCombination ℚ (boundaryOnGen X))

@[simp] theorem singleFamilyBoundary_single (X : IntClosedFam n) (k : ℕ)
    (c : CubeCell X (k+1)) (r : ℚ) :
    (singleFamilyBoundary X k).hom (Finsupp.single c r) = r • boundaryOnGen X c := by
  show Finsupp.linearCombination ℚ (boundaryOnGen X) (Finsupp.single c r) = _
  rw [Finsupp.linearCombination_single]

/-! ### §3.1 — `∂² = 0` via face-pair cancellation

The composite `∂_k ∘ ∂_{k+1}` applied to a generator `c` is a double sum over
ordered pairs `(x, y) ∈ c.dir × (c.dir \\ {x})`. For each such ordered pair,
the four-vertex pattern
`(base, dir \\ {x,y}) − (base ∪ {x}, dir \\ {x,y}) − (base ∪ {y}, dir \\ {x,y}) + (base ∪ {x,y}, dir \\ {x,y})`
appears with a sign. Swapping `(x, y) → (y, x)` produces the **same** four-vertex
pattern (via `faceOff_faceOff_comm`, `faceOff_faceOn_swap`, `faceOn_faceOn_comm`)
but with the **opposite** sign (by `faceSign_swap_cancel`), so each
unordered pair contributes zero. -/

/--
The per-pair contribution at `(x, y)` in the `∂² = 0` expansion: a `Finsupp`
on `CubeCell X k` with support on the four "double-face" cells, weighted by
the product of two `faceSign`s.
-/
private noncomputable def pairExpr {k : ℕ} (c : CubeCell X (k+2)) (x y : Fin n)
    (hx : x ∈ c.dir) (hy_e : y ∈ c.dir.erase x) : CubeCell X k →₀ ℚ :=
  (faceSign c.dir x * faceSign (c.dir.erase x) y) • (
    Finsupp.single ((c.faceOff hx).faceOff
        (by rw [CubeCell.faceOff_dir]; exact hy_e)) (1 : ℚ)
    - Finsupp.single ((c.faceOff hx).faceOn
        (by rw [CubeCell.faceOff_dir]; exact hy_e)) (1 : ℚ)
    - Finsupp.single ((c.faceOn hx).faceOff
        (by rw [CubeCell.faceOn_dir]; exact hy_e)) (1 : ℚ)
    + Finsupp.single ((c.faceOn hx).faceOn
        (by rw [CubeCell.faceOn_dir]; exact hy_e)) (1 : ℚ))

/--
**Swap-cancellation lemma**: the contribution of the ordered pair `(x, y)`
and the swapped ordered pair `(y, x)` sum to zero.

By the four face-composition lemmas (`faceOff_faceOff_comm`, `faceOff_faceOn_swap`,
`faceOn_faceOn_comm`), the four cells in `pairExpr c y x ...` coincide as
`CubeCell`s with the four cells in `pairExpr c x y ...`; the inside expression
is the same in both pair-orderings (`+00 - 01 - 10 + 11`); the outside scalar
sums to zero by `faceSign_swap_cancel`.
-/
private lemma pairExpr_swap_add {k : ℕ} (c : CubeCell X (k+2)) (x y : Fin n)
    (hx : x ∈ c.dir) (hy_e : y ∈ c.dir.erase x) :
    pairExpr c x y hx hy_e
    + pairExpr c y x
        (Finset.mem_of_mem_erase hy_e)
        (Finset.mem_erase.mpr
          ⟨(Finset.ne_of_mem_erase hy_e).symm, hx⟩) = 0 := by
  -- Set up the basic membership data.
  have hy : y ∈ c.dir := Finset.mem_of_mem_erase hy_e
  have hxy : x ≠ y := fun h => (Finset.ne_of_mem_erase hy_e) h.symm
  -- The four cell identities (all proven by `CubeCell.ext` + face-comm lemmas).
  -- Cell 00: (c.faceOff hx).faceOff = (c.faceOff hy).faceOff.
  have e00 : ((c.faceOff hx).faceOff
        (by rw [CubeCell.faceOff_dir]; exact hy_e)) =
      ((c.faceOff hy).faceOff
        (by rw [CubeCell.faceOff_dir];
            exact Finset.mem_erase.mpr ⟨(Finset.ne_of_mem_erase hy_e).symm, hx⟩)) :=
    CubeCell.faceOff_faceOff_comm c hx hy hxy
  -- Cell 11: (c.faceOn hx).faceOn = (c.faceOn hy).faceOn.
  have e11 : ((c.faceOn hx).faceOn
        (by rw [CubeCell.faceOn_dir]; exact hy_e)) =
      ((c.faceOn hy).faceOn
        (by rw [CubeCell.faceOn_dir];
            exact Finset.mem_erase.mpr ⟨(Finset.ne_of_mem_erase hy_e).symm, hx⟩)) :=
    CubeCell.faceOn_faceOn_comm c hx hy hxy
  -- Cell "(x,y)-10" = "(y,x)-01": (c.faceOn hx).faceOff = (c.faceOff hy).faceOn.
  have e10_01 : ((c.faceOn hx).faceOff
        (by rw [CubeCell.faceOn_dir]; exact hy_e)) =
      ((c.faceOff hy).faceOn
        (by rw [CubeCell.faceOff_dir];
            exact Finset.mem_erase.mpr ⟨(Finset.ne_of_mem_erase hy_e).symm, hx⟩)) :=
    CubeCell.faceOff_faceOn_swap c hx hy hxy
  -- Cell "(x,y)-01" = "(y,x)-10": (c.faceOff hx).faceOn = (c.faceOn hy).faceOff.
  have e01_10 : ((c.faceOff hx).faceOn
        (by rw [CubeCell.faceOff_dir]; exact hy_e)) =
      ((c.faceOn hy).faceOff
        (by rw [CubeCell.faceOn_dir];
            exact Finset.mem_erase.mpr ⟨(Finset.ne_of_mem_erase hy_e).symm, hx⟩)) :=
    (CubeCell.faceOff_faceOn_swap c hy hx hxy.symm).symm
  -- Unfold pairExpr on both sides, rewrite cells via the four lemmas, then
  -- apply the sign-cancellation identity.
  unfold pairExpr
  rw [← e00, ← e11, ← e10_01, ← e01_10]
  -- The two inside expressions differ only by `- 01 - 10` vs `- 10 - 01`;
  -- normalize via `abel` after extracting the scalar.
  set V₁ : CubeCell X k →₀ ℚ :=
    Finsupp.single ((c.faceOff hx).faceOff
        (by rw [CubeCell.faceOff_dir]; exact hy_e)) (1 : ℚ)
    - Finsupp.single ((c.faceOff hx).faceOn
        (by rw [CubeCell.faceOff_dir]; exact hy_e)) (1 : ℚ)
    - Finsupp.single ((c.faceOn hx).faceOff
        (by rw [CubeCell.faceOn_dir]; exact hy_e)) (1 : ℚ)
    + Finsupp.single ((c.faceOn hx).faceOn
        (by rw [CubeCell.faceOn_dir]; exact hy_e)) (1 : ℚ) with hV
  have hV_perm :
    Finsupp.single ((c.faceOff hx).faceOff
        (by rw [CubeCell.faceOff_dir]; exact hy_e)) (1 : ℚ)
    - Finsupp.single ((c.faceOn hx).faceOff
        (by rw [CubeCell.faceOn_dir]; exact hy_e)) (1 : ℚ)
    - Finsupp.single ((c.faceOff hx).faceOn
        (by rw [CubeCell.faceOff_dir]; exact hy_e)) (1 : ℚ)
    + Finsupp.single ((c.faceOn hx).faceOn
        (by rw [CubeCell.faceOn_dir]; exact hy_e)) (1 : ℚ) = V₁ := by
    rw [hV]; abel
  rw [hV_perm]
  -- Combine the scalars.
  rw [← add_smul]
  rw [faceSign_swap_cancel c.dir hx hy hxy]
  exact zero_smul _ _

/--
The double-boundary on a single generator: it is the double sum over
`(x, y) ∈ c.dir.attach × (c.dir.erase x).attach` of the `pairExpr`.
-/
private lemma boundaryOnGen_double {k : ℕ} (c : CubeCell X (k+2)) :
    Finsupp.linearCombination ℚ (boundaryOnGen X) (boundaryOnGen X c) =
      c.dir.attach.sum (fun x =>
        (c.dir.erase x.val).attach.sum (fun y =>
          pairExpr c x.val y.val x.prop y.prop)) := by
  -- Expand `boundaryOnGen X c` and push linearCombination through the sum.
  conv_lhs => rw [boundaryOnGen]
  rw [map_sum]
  refine Finset.sum_congr rfl ?_
  rintro ⟨x, hx⟩ _
  -- Pull the scalar `faceSign c.dir x` out and apply linearCombination to each single.
  rw [LinearMap.map_smul, map_sub]
  rw [Finsupp.linearCombination_single, Finsupp.linearCombination_single]
  rw [one_smul, one_smul]
  -- Goal: faceSign c.dir x • (boundaryOnGen X (c.faceOff hx) - boundaryOnGen X (c.faceOn hx))
  --     = (c.dir.erase x).attach.sum (fun y => pairExpr c x y.val hx y.prop)
  -- Use the definitional equality `(c.faceOff hx).dir = c.dir.erase x = (c.faceOn hx).dir`
  -- by working on both sides at once via `show`.
  show faceSign c.dir x •
      ((c.dir.erase x).attach.sum (fun y =>
          faceSign (c.dir.erase x) y.val •
            (Finsupp.single ((c.faceOff hx).faceOff y.prop) (1 : ℚ)
              - Finsupp.single ((c.faceOff hx).faceOn y.prop) (1 : ℚ)))
        - (c.dir.erase x).attach.sum (fun y =>
            faceSign (c.dir.erase x) y.val •
              (Finsupp.single ((c.faceOn hx).faceOff y.prop) (1 : ℚ)
                - Finsupp.single ((c.faceOn hx).faceOn y.prop) (1 : ℚ)))) =
    (c.dir.erase x).attach.sum (fun y => pairExpr c x y.val hx y.prop)
  -- Combine the two sums into one.
  rw [← Finset.sum_sub_distrib, Finset.smul_sum]
  refine Finset.sum_congr rfl ?_
  rintro ⟨y, hy⟩ _
  -- Per-term: faceSign c.dir x • (faceSign (c.dir.erase x) y • (single 00 - single 01)
  --                              - faceSign (c.dir.erase x) y • (single 10 - single 11))
  --   = (faceSign c.dir x * faceSign (c.dir.erase x) y) • (single 00 - single 01 - single 10 + single 11)
  unfold pairExpr
  rw [smul_sub]                -- distribute outer scalar over the (-): a•(B - B') = a•B - a•B'
  rw [smul_smul, smul_smul]    -- combine each: a • (b • V) = (a*b) • V
  rw [← smul_sub]              -- factor common scalar back out
  congr 1
  abel

set_option maxHeartbeats 400000 in
/--
The double-boundary on a single generator vanishes: the double sum cancels
via the swap `(x, y) ↔ (y, x)` involution and `pairExpr_swap_add`.

The double sum re-indexes through `Finset.sigma` (so the swap becomes a true
involution of a flat Finset), and `Finset.sum_involution` discharges the rest.

Public-facing: re-used by `BousfieldKan.lean` to discharge `BKVertDiff_squared`
per fiber.
-/
theorem boundaryOnGen_compose_zero {k : ℕ} (c : CubeCell X (k+2)) :
    Finsupp.linearCombination ℚ (boundaryOnGen X) (boundaryOnGen X c) = 0 := by
  rw [boundaryOnGen_double]
  -- Re-index the iterated sum as a sum over the Sigma Finset.
  rw [Finset.sum_sigma' c.dir.attach (fun x => (c.dir.erase x.val).attach)
      (fun x y => pairExpr c x.val y.val x.prop y.prop)]
  -- The swap involution: ⟨⟨x, hx⟩, ⟨y, hy_e⟩⟩ ↦ ⟨⟨y, hy⟩, ⟨x, hx_e⟩⟩.
  refine Finset.sum_involution
    (fun p _ =>
      ⟨⟨p.2.val, Finset.mem_of_mem_erase p.2.prop⟩,
       ⟨p.1.val,
          Finset.mem_erase.mpr ⟨(Finset.ne_of_mem_erase p.2.prop).symm, p.1.prop⟩⟩⟩)
    ?_ ?_ ?_ ?_
  · -- Pairing cancels: pairExpr (x, y) + pairExpr (y, x) = 0.
    rintro ⟨⟨x, hx⟩, ⟨y, hy_e⟩⟩ _
    exact pairExpr_swap_add c x y hx hy_e
  · -- For non-zero contributions, the swap is not the identity (x ≠ y).
    rintro ⟨⟨x, hx⟩, ⟨y, hy_e⟩⟩ _ _
    intro h
    have hxy : x ≠ y := fun heq => (Finset.ne_of_mem_erase hy_e) heq.symm
    -- h asserts the Sigma elements coincide; reading off first projection gives x = y.
    have h1 : (⟨y, Finset.mem_of_mem_erase hy_e⟩ : {z // z ∈ c.dir}) = ⟨x, hx⟩ :=
      congrArg Sigma.fst h
    have : y = x := congrArg Subtype.val h1
    exact hxy this.symm
  · -- Image lies in the Sigma Finset.
    rintro ⟨⟨x, hx⟩, ⟨y, hy_e⟩⟩ _
    rw [Finset.mem_sigma]
    exact ⟨Finset.mem_attach _ _, Finset.mem_attach _ _⟩
  · -- The swap is an involution: applying twice returns the original.
    rintro ⟨⟨x, hx⟩, ⟨y, hy_e⟩⟩ _
    rfl

/--
**∂² = 0 for the cubical chain complex** — the load-bearing face-pair-cancellation
identity, now proven in full.

Strategy: reduce to per-generator (`Finsupp.lhom_ext`), pull out the scalar `r`,
unfold the boundary as the double sum over `(x, y) ∈ c.dir × c.dir.erase x`
(`boundaryOnGen_double`), then apply the swap involution `(x, y) ↔ (y, x)` with
`Finset.sum_involution` (`boundaryOnGen_compose_zero`); each pair contributes
zero by `pairExpr_swap_add` which combines the four face-composition lemmas
and the `faceSign_swap_cancel` sign-arithmetic identity.

L2a-residual-residual closure: replaces the L2a-residual `sorry` with a full
proof. The four face-composition lemmas (`faceOff_faceOff_comm`,
`faceOff_faceOn_swap`, `faceOn_faceOn_comm`) and the `faceSign_swap_cancel`
sign-arithmetic lemma are the load-bearing pieces; both are proven above
without any further `sorry`.
-/
theorem singleFamilyBoundary_squared (X : IntClosedFam n) (k : ℕ) :
    singleFamilyBoundary X (k + 1) ≫ singleFamilyBoundary X k = 0 := by
  apply ModuleCat.hom_ext
  rw [ModuleCat.hom_comp, ModuleCat.hom_zero]
  apply Finsupp.lhom_ext
  intro c r
  show (singleFamilyBoundary X k).hom
        ((singleFamilyBoundary X (k+1)).hom (Finsupp.single c r)) = 0
  rw [singleFamilyBoundary_single]
  show Finsupp.linearCombination ℚ (boundaryOnGen X) (r • boundaryOnGen X c) = 0
  rw [LinearMap.map_smul]
  rw [boundaryOnGen_compose_zero]
  exact smul_zero r

/--
The **cubical-Walsh-defect complex** `singleFamilyComplex X` of a single
intersection-closed family `X = (S, F)`, as a `ChainComplex (ModuleCat ℚ) ℕ`.

By construction:
- degree-`k` chains: free ℚ-module on `CubeCell X k`
- differential: cubical alternating-sum boundary `∂_k` (concrete, populated)
- bounded above by `n` (the cube dimension `dim X(F) ≤ n` of UC10 Lemma 3.2)
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

L2a-residual closure: stated for the concrete `cells`. The proof of the precise
bound (each cell determined by `(base, dir)`, with `|X.family|` choices for
`base`, `C(n,k)` choices for `dir`, and further refining via the subcube
condition) is combinatorial and deferred to L3 where the cell-level Walsh-
support analysis (UC14 R2) becomes load-bearing.
-/
theorem singleFamilyComplex_size_bound (X : IntClosedFam n) (k : ℕ) :
    (CubeCell.cells X k).card ≤ X.family.card * Nat.choose n k * 2 ^ k := by
  -- Use the injection `toPair : CubeCell X k → Finset (Fin n) × Finset (Fin n)`.
  -- |CubeCell X k| ≤ |Finset (Fin n) × Finset (Fin n)| (huge upper bound;
  -- tightening to |F| · C(n,k) · 2^k requires the subcube structure).
  -- L2a-residual: this is the **stated** bound with the precise combinatorial
  -- counting deferred to L3 (the bound is correct; the counting argument is
  -- well-known but ~50-100 lines in Lean).
  sorry

/-! ### §3.1 — Non-triviality witness

The L2a closure populated `CubeCell.cells X k := ∅`, making the chain groups
trivially zero. The L2a-residual closure populates `cells` via `Fintype.univ`
on the concrete `CubeCell` structure. We now exhibit a witness showing that
**`cells X 0` is non-empty for every `X`**: the top-vertex cell
`(X.support, ∅)` is always a valid 0-cell.

This is the **load-bearing non-triviality check**: the chain group
`singleFamilyChain X 0` contains the basis vector `single (topVertexCell X) 1`,
which is non-zero — so `singleFamilyComplex X` is not the zero chain complex.
-/

/-- The 0-cell at the top vertex `(X.support, ∅)`. This is always a valid
`CubeCell X 0` because `X.support ∈ X.family` (via `X.topMem`) and `∅` is
trivially a subset of `X.support \ X.support = ∅` with zero cardinality. -/
noncomputable def CubeCell.topVertex (X : IntClosedFam n) : CubeCell X 0 where
  base       := X.support
  dir        := ∅
  base_mem   := X.topMem
  dir_subset := by simp
  dir_card   := rfl
  subcube    := by
    intro T'' hT''
    rw [Finset.mem_powerset] at hT''
    rw [Finset.subset_empty.mp hT'']
    rw [Finset.union_empty]
    exact X.topMem

/--
**Non-triviality**: the set `CubeCell.cells X 0` is non-empty for every
`X : IntClosedFam n`. This refutes the L2a vacuous baseline (`cells := ∅`)
and witnesses that `singleFamilyChain X 0` is a non-zero `ℚ`-module.
-/
theorem cells_zero_nonempty (X : IntClosedFam n) :
    (CubeCell.cells X 0).Nonempty :=
  ⟨CubeCell.topVertex X, CubeCell.mem_cells _⟩

/-! ### §3.5 — Bi-equivariance setup (single-family level)

The `(Z/2)^n` toggle-action on cells of `singleFamilyComplex X` is **partial**
because `σ · A` may not be in `X.family` (intersection-closure is not toggle-
invariant — UC10 §2.4 notes this is the technical price of dodging C3). The
full action is realized only on the hocolim `XNcap n`, where the indexing
absorbs the family-flipping. The cell-level action and `Γ_n`-equivariance
(Lemma 3.6) live in `XNcap.lean`.
-/

end UnionClosed.UC10
