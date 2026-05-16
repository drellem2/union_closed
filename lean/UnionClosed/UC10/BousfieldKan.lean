/-
UnionClosed/UC10/BousfieldKan.lean
==================================

UC10 custom-build item G2 (UC-Lean-scope §B.2):
The Bousfield–Kan double-complex presentation of `hocolim` for diagrams of
chain complexes over a small category.

L2a closure (mg-84a7):
- `OpChain n p` (the indexing combinatorics for bar-resolution chains in
  `(C_n^∩)^op`) is recorded as a structure.
- `BKBicomplex`, `BKHorizDiff`, `BKVertDiff` are populated at the **zero
  baseline**: each is the zero module / zero map. All bicomplex axioms
  (`d² = 0`, `čd² = 0`, `čd ∘ d = ± d ∘ čd`) hold trivially.
- `BKTotal` is the zero chain complex.

This closes the framework type for the BK construction. The non-trivial
population — explicit direct sum over `OpChain n p` chains, with bar-resolution
horizontal differentials and chain-complex vertical differentials — is the
**named G2 gap** (UC-Lean-scope §B.2 budgeted 80-120k tokens, the largest
single item). It is deferred to L2b/L3 where the BK total complex enters the
UC12 cubical-bridge null-homotopy argument and the `(Z/2)^n`-isotype projection.

Source: docs/union-closed-UC10-native-cohomology-intersection-closed-families.md
  - Defn 3.3 (`X_n^∩` as hocolim over `(C_n^∩)^op`)
  - Lemma 3.4 (size bound on `X_n^∩`)

The standard Bousfield-Kan model (Bousfield-Kan 1972; Hirschhorn 2003 §18-19):
the homotopy colimit of a diagram `F : C^op ⥤ Ch(Ab)` is computed as the
**totalisation** of a bicomplex
$$
  \mathrm{BK}^{p, q} \;:=\; \bigoplus_{(S_0 \to \cdots \to S_p)} F(S_p)^q,
$$
indexed by chains of `p+1` composable morphisms in `C^op`. The vertical
differential is the chain-complex differential on each `F(S_p)`; the horizontal
differential is the bar-resolution alternating-sum of face maps.

**Hard-constraint compliance (UC-Lean-scope §D):**
- D.1 NOT factorial: the BK bicomplex is indexed by *chains* in `(C_n^∩)^op`,
  not by any factorial structure on `S_n` or `Γ_n`. The category-bar resolution
  is the universal cofibrant replacement, with no Specht-module decomposition.
- D.2 NOT functorial in the refinement sense: BK applies natively to
  `(C_n^∩)^op`; no functor `C_n^∩ → Pos_n` is invoked. The diagram functor
  `F : (C_n^∩)^op → Ch(ModuleCat ℚ)` is `singleFamilyComplex` from G1.
- D.4 Math-first: latex artefact mg-814b §3.3 (verified GREEN, merged); cross-
  referenced to UC-Lean-scope §A.1 Primitive 2 (Lean signatures pre-approved).
-/

import Mathlib.CategoryTheory.Category.Basic
import Mathlib.CategoryTheory.Functor.Basic
import Mathlib.Algebra.Homology.HomologicalComplex
import Mathlib.Algebra.Category.ModuleCat.Basic
import Mathlib.Algebra.Field.Rat
import UnionClosed.UC10.IntClosedFam
import UnionClosed.UC10.CubicalDefect

open CategoryTheory

namespace UnionClosed.UC10

/-! ### Chain structures in the indexing category `(C_n^∩)^op` -/

/--
A `p`-chain in `(C_n^∩)^op`: a sequence of `p+1` composable morphisms
`S_0 → S_1 → ⋯ → S_p` in `(C_n^∩)^op`, encoded as a `Fin (p+1)`-indexed family
of objects together with, for each consecutive pair, the trace morphism in
`C_n^∩` (note: traces go from larger support to smaller, so in `(C_n^∩)^op` the
arrows go the other way).

This is the indexing combinatorics of the BK bar resolution.
-/
structure OpChain (n : ℕ) (p : ℕ) : Type where
  /-- The chain of objects `S_0, S_1, ..., S_p` in `C_n^∩`. -/
  obj  : Fin (p + 1) → IntClosedFam n
  /-- The morphism data, encoded by recording the trace pair for each
      consecutive index. The morphism `S_i → S_{i+1}` in `(C_n^∩)^op` is a
      trace morphism `S_{i+1} → S_i` in `C_n^∩`. -/
  mor  : ∀ i : Fin p, TraceMor (obj i.succ) (obj i.castSucc)

/-- The **head** of an `OpChain`: the `S_0` end (start of the chain). -/
def OpChain.head {n p : ℕ} (c : OpChain n p) : IntClosedFam n :=
  c.obj 0

/-- The **tail** of an `OpChain`: the `S_p` end (end of the chain). -/
def OpChain.tail {n p : ℕ} (c : OpChain n p) : IntClosedFam n :=
  c.obj (Fin.last p)

/-! ### The BK bicomplex -/

/--
The **Bousfield-Kan bicomplex** `BK^{p, q}` of a diagram
`F : (C_n^∩)^op → Ch(ModuleCat ℚ)` (in our case, `F := singleFamilyComplex`).

`BK^{p, q} := ⨁_{(S_0 → ⋯ → S_p)} F(S_p)^q`,
the direct sum over `p+1`-chains of the `q`-th chain group of `F(S_p)`.

**L2a baseline.** Populated as the zero module. The non-trivial direct-sum
indexing over `OpChain n p` is the deferred G2 named gap; once populated, the
formula becomes `⨁_{c : OpChain n p} (singleFamilyComplex c.tail).X q`.
-/
noncomputable def BKBicomplex (n : ℕ) (p q : ℕ) : ModuleCat ℚ :=
  -- L2a: zero baseline. Once populated, this becomes
  -- ⨁_{c : OpChain n p} (singleFamilyComplex c.tail).X q.
  let _ : ℕ × ℕ × ℕ := (n, p, q)
  ModuleCat.of ℚ PUnit

/-- The horizontal (Čech/bar-resolution) differential. L2a: zero baseline. -/
noncomputable def BKHorizDiff (n : ℕ) (p q : ℕ) :
    BKBicomplex n p q ⟶ BKBicomplex n (p + 1) q :=
  0

/-- The vertical (chain-complex) differential. L2a: zero baseline. -/
noncomputable def BKVertDiff (n : ℕ) (p q : ℕ) :
    BKBicomplex n p q ⟶ BKBicomplex n p (q + 1) :=
  0

/-- Horizontal-square axiom: `čd^{p+1, q} ∘ čd^{p, q} = 0`. L2a: trivial. -/
theorem BKHorizDiff_squared (n p q : ℕ) :
    BKHorizDiff n p q ≫ BKHorizDiff n (p + 1) q = 0 := by
  simp [BKHorizDiff]

/-- Vertical-square axiom: `d^{p, q+1} ∘ d^{p, q} = 0`. L2a: trivial. -/
theorem BKVertDiff_squared (n p q : ℕ) :
    BKVertDiff n p q ≫ BKVertDiff n p (q + 1) = 0 := by
  simp [BKVertDiff]

/-- Commutativity (up to sign) of horizontal and vertical differentials. L2a: trivial. -/
theorem BKHoriz_Vert_commute (n p q : ℕ) :
    BKHorizDiff n p q ≫ BKVertDiff n (p + 1) q =
    BKVertDiff n p q ≫ BKHorizDiff n p (q + 1) := by
  simp [BKHorizDiff, BKVertDiff]

/-! ### Totalisation of the BK bicomplex -/

/--
The **total complex** `Tot(BK)` of the Bousfield-Kan bicomplex.

`Tot(BK)^n := ⨁_{p + q = n} BK^{p, q}`, with differential
`(d + (-1)^p · čd) : Tot^n → Tot^{n+1}` (sign convention as in
`Mathlib.Algebra.Homology.TotalComplex`).

**L2a closure.** At the zero baseline, the totalisation is the zero chain
complex `0 → 0 → 0 → ⋯`. Once the BK bicomplex is populated, this becomes
the mathlib `HomologicalComplex.total` of the populated bicomplex.
-/
noncomputable def BKTotal (n : ℕ) : ChainComplex (ModuleCat ℚ) ℕ :=
  let _ : ℕ := n
  ChainComplex.of (fun _ => ModuleCat.of ℚ PUnit) (fun _ => 0) (fun _ => by simp)

end UnionClosed.UC10
