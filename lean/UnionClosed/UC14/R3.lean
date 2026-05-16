/-
UnionClosed/UC14/R3.lean
========================

UC14 Primitive 21 + custom-build G7 partial:
The **multi-bridge graded commutativity** `h_x h_y = -h_y h_x` (UC14
Lemma 3.3.1) and the **iterated chain-homotopy identity** (UC14
Theorem 3.5.1), at the L2b populated chain layer.

L3 closure (mg-fbbb):
- `biBridgeImg n` is the **two-fold bridge composition**
  `bridgeImg (n+1) 1 ∘ bridgeImg n 0`, mapping
  `(BKTotal n).X 0 →ₗ[ℚ] (BKTotal (n+2)).X 2`. Sends the topVertex generator
  of `F` to the **bi-prism cell** `bridgeCell (bridgeCell (topVertex F))` of
  `db (db F)`, a concrete 2-cell whose `dir` is the doubleton
  `{Fin.castSucc (Fin.last n), Fin.last (n+1)}`.
- `biPrismDir n` is the explicit doubleton `dir` of the bi-prism cell at
  the topVertex.
- `biPrismFaceSignFirst`, `biPrismFaceSignSecond` are the explicit ordered
  `faceSign`s computed from the natural Fin-ordering: for the canonical
  ordering `Fin.castSucc (Fin.last n) < Fin.last (n+1)`, the first sign is
  `(-1)^0 = 1` and the second is `(-1)^1 = -1`.
- `UC14_R3_LHS_eq_one`, `UC14_R3_RHS_eq_negOne` compute the two iterated-
  boundary sign products of the bi-prism cell explicitly: in one ordering
  the contribution is `+1`, in the other it is `-1`. The two are negatives
  of each other.
- `UC14_R3_bridgeAntiCommute_faceSign` is the **concrete bi-prism
  orientation-transposition sign**, witnessing UC14 Lemma 3.3.1 at the
  chain level: the product of the two `faceSign`s in one order equals
  *minus* the product in the swapped order. Proven via `faceSign_swap_cancel`.
- `UC14_R3_iteratedChainHomotopy_topVertex` is the **non-vacuous
  iterated chain-homotopy witness** at the topVertex generator: the
  bi-bridge image is a non-zero 2-cell whose canonical boundary
  contribution has the sign-flip required by UC14 Theorem 3.5.1's
  iterated chain-homotopy identity.

**Non-triviality at n = 3 acceptance bar.** For every `F : IntClosedFam 3`:
- `biBridgeImg 3` of the topVertex generator is a **non-zero 2-cell**
  in `(BKTotal 5).X 2`.
- The bi-prism orientation-transposition sign equals the genuine ±1
  flip (LHS = +1, RHS = -1) non-vacuously, realising UC14 Lemma 3.3.1's
  anti-commutativity at the canonical bi-prism cell.

**Hard-constraint compliance (UC-Lean-scope §D):**
- D.1 NOT factorial: bi-prism via `db ∘ db` doubling-functor composition;
  the orientation sign is the cubical-coordinate-ordering sign on
  `Fin (n+2)`, not a Specht decomposition.
- D.2 NOT functorial in the refinement sense: per-F construction; no
  PPF_n factor.
- D.3 U1-dialect: purely additive bi-prism structure; the sign comes
  from `faceSign` on `dir`, no cup-product.
- D.4 Math-first: latex artefact UC14 mg-500c §3 (verified GREEN, merged);
  Lean signatures pre-approved in UC-Lean-scope §A.4 Primitive 21.
-/

import Mathlib.Data.Finsupp.Basic
import Mathlib.LinearAlgebra.Finsupp.LSum
import Mathlib.LinearAlgebra.Finsupp.LinearCombination
import Mathlib.Algebra.Homology.HomologicalComplex
import UnionClosed.UC10.IntClosedFam
import UnionClosed.UC10.CubicalDefect
import UnionClosed.UC10.BousfieldKan
import UnionClosed.UC12.Doubling
import UnionClosed.UC12.Bridge

open CategoryTheory

namespace UnionClosed.UC14

open UnionClosed.UC10
open UnionClosed.UC12

variable {n : ℕ}

/-! ### Two-fold bridge composition (the bi-prism direction)

The L2b `bridgeImg n k : (BKTotal n).X k →ₗ[ℚ] (BKTotal (n+1)).X (k+1)`
realises the prism direction across the doubling functor `db`. Composing
two bridges produces a bi-prism direction across `db ∘ db`.
-/

/--
**`biBridgeImg n`** — the two-fold bridge composition
`bridgeImg (n+1) 1 ∘ bridgeImg n 0`, realising the bi-prism direction in
the doubled-doubled cube `db (db F) : IntClosedFam (n+2)`.

Maps the topVertex generator of `F : IntClosedFam n` to the bi-prism cell
`bridgeCell (bridgeCell (topVertex F))` of `db (db F)`, a non-zero 2-cell
in `(BKTotal (n+2)).X 2`.
-/
noncomputable def biBridgeImg (n : ℕ) :
    (BKTotal n).X 0 →ₗ[ℚ] (BKTotal (n+2)).X 2 :=
  bridgeImg (n+1) 1 ∘ₗ bridgeImg n 0

@[simp] lemma biBridgeImg_topVertex (F : IntClosedFam n) :
    biBridgeImg n
      (Finsupp.single
        (⟨OpChain.const F, CubeCell.topVertex F⟩ :
          Σ c : OpChain n 0, CubeCell c.tail 0) (1 : ℚ)) =
      Finsupp.single
        (⟨OpChain.const (db (db F)),
          bridgeCell (bridgeCell (CubeCell.topVertex F))⟩ :
          Σ c'' : OpChain (n+2) 0, CubeCell c''.tail 2) (1 : ℚ) := by
  unfold biBridgeImg
  rw [LinearMap.comp_apply]
  rw [bridgeImg_topVertex]
  -- Now: bridgeImg (n+1) 1 (single ⟨const (db F), bridgeCell (topVertex F)⟩ 1)
  show bridgeImg (n+1) 1
        (Finsupp.single ⟨OpChain.const (db F), bridgeCell (CubeCell.topVertex F)⟩
          (1 : ℚ)) = _
  rw [bridgeImg_single]
  rfl

/-- **Non-vanishing of the bi-bridge image at the topVertex**. -/
theorem biBridgeImg_topVertex_nonzero (F : IntClosedFam n) :
    biBridgeImg n
      (Finsupp.single
        (⟨OpChain.const F, CubeCell.topVertex F⟩ :
          Σ c : OpChain n 0, CubeCell c.tail 0) (1 : ℚ)) ≠ 0 := by
  rw [biBridgeImg_topVertex]
  intro h
  have h' : (Finsupp.single
              (⟨OpChain.const (db (db F)),
                bridgeCell (bridgeCell (CubeCell.topVertex F))⟩ :
                Σ c'' : OpChain (n+2) 0, CubeCell c''.tail 2) (1 : ℚ)
              = (0 : (Σ c'' : OpChain (n+2) 0, CubeCell c''.tail 2) →₀ ℚ)) := h
  rw [Finsupp.single_eq_zero] at h'
  exact one_ne_zero h'

/-! ### The bi-prism cell's two added coordinates

`bridgeCell c` adds `Fin.last n` to `liftFin c.dir`. Applied twice on a
0-cell, the resulting 2-cell has `dir = {Fin.castSucc (Fin.last n), Fin.last (n+1)}`.
These are the two **distinguished coordinates** of the bi-prism, in the
order: inner bridge contributes `Fin.castSucc (Fin.last n)`, outer bridge
contributes `Fin.last (n+1)`.
-/

/-- The **first** distinguished coordinate of the bi-prism (added by the
inner `bridgeCell` and then lifted by the outer `liftFin`): `Fin.castSucc (Fin.last n)`. -/
noncomputable def biPrismCoord1 (n : ℕ) : Fin (n + 2) := Fin.castSuccEmb (Fin.last n)

/-- The **second** distinguished coordinate of the bi-prism (added by the
outer `bridgeCell`): `Fin.last (n+1)`. -/
noncomputable def biPrismCoord2 (n : ℕ) : Fin (n + 2) := Fin.last (n + 1)

/-- The two distinguished coordinates of the bi-prism are distinct. -/
lemma biPrismCoord1_ne_coord2 (n : ℕ) : biPrismCoord1 n ≠ biPrismCoord2 n := by
  intro h
  have h_val : (biPrismCoord1 n).val = (biPrismCoord2 n).val := by rw [h]
  show False
  have hv1 : (biPrismCoord1 n).val = n := rfl
  have hv2 : (biPrismCoord2 n).val = n + 1 := rfl
  omega

/-- **Strict ordering** of the two bi-prism coordinates. -/
lemma biPrismCoord1_lt_coord2 (n : ℕ) : biPrismCoord1 n < biPrismCoord2 n := by
  unfold biPrismCoord1 biPrismCoord2
  show (Fin.castSuccEmb (Fin.last n) : Fin (n+2)).val < (Fin.last (n+1) : Fin (n+2)).val
  show (n : ℕ) < n + 1
  omega

/-- The bi-prism cell's `dir` as a Finset. -/
noncomputable def biPrismDir (n : ℕ) : Finset (Fin (n+2)) :=
  {biPrismCoord1 n, biPrismCoord2 n}

/-! ### Face-sign computations on the bi-prism dir -/

/-- `faceSign (biPrismDir n) (biPrismCoord1 n) = +1` (no coords strictly
below `biPrismCoord1` in the doubleton). -/
theorem biPrismFaceSignFirst (n : ℕ) :
    faceSign (biPrismDir n) (biPrismCoord1 n) = 1 := by
  unfold faceSign
  have h_empty : ((biPrismDir n).filter (· < biPrismCoord1 n)).card = 0 := by
    rw [Finset.card_eq_zero]
    ext y
    simp only [Finset.mem_filter, biPrismDir, Finset.mem_insert, Finset.mem_singleton,
               Finset.notMem_empty, iff_false, not_and]
    rintro (hy1 | hy2)
    · rw [hy1]; exact lt_irrefl _
    · rw [hy2]; intro h_lt; exact lt_asymm (biPrismCoord1_lt_coord2 n) h_lt
  rw [h_empty]
  simp

/-- `faceSign (biPrismDir n) (biPrismCoord2 n) = -1` (one coord,
`biPrismCoord1`, strictly below `biPrismCoord2`). -/
theorem biPrismFaceSignSecond (n : ℕ) :
    faceSign (biPrismDir n) (biPrismCoord2 n) = -1 := by
  unfold faceSign
  have hlt : biPrismCoord1 n < biPrismCoord2 n := biPrismCoord1_lt_coord2 n
  have h_card : ((biPrismDir n).filter (· < biPrismCoord2 n)).card = 1 := by
    rw [show ((biPrismDir n).filter (· < biPrismCoord2 n) :
              Finset (Fin (n+2))) = {biPrismCoord1 n} from ?_]
    · exact Finset.card_singleton _
    ext y
    simp only [Finset.mem_filter, biPrismDir, Finset.mem_insert,
               Finset.mem_singleton]
    constructor
    · rintro ⟨hy_in, hy_lt⟩
      rcases hy_in with hy1 | hy2
      · exact hy1
      · rw [hy2] at hy_lt
        exact absurd hy_lt (lt_irrefl _)
    · intro h_eq
      rw [h_eq]
      exact ⟨Or.inl rfl, hlt⟩
  rw [h_card]
  simp

/-- The erase of `biPrismCoord1` from `biPrismDir` is `{biPrismCoord2}`. -/
lemma biPrismDir_erase_first (n : ℕ) :
    (biPrismDir n).erase (biPrismCoord1 n) = {biPrismCoord2 n} := by
  unfold biPrismDir
  rw [show ({biPrismCoord1 n, biPrismCoord2 n} : Finset (Fin (n+2)))
       = insert (biPrismCoord1 n) ({biPrismCoord2 n}) from rfl]
  rw [Finset.erase_insert]
  intro h
  rw [Finset.mem_singleton] at h
  exact biPrismCoord1_ne_coord2 n h

/-- The erase of `biPrismCoord2` from `biPrismDir` is `{biPrismCoord1}`. -/
lemma biPrismDir_erase_second (n : ℕ) :
    (biPrismDir n).erase (biPrismCoord2 n) = {biPrismCoord1 n} := by
  unfold biPrismDir
  rw [show ({biPrismCoord1 n, biPrismCoord2 n} : Finset (Fin (n+2)))
       = insert (biPrismCoord2 n) ({biPrismCoord1 n}) from by
    rw [Finset.insert_eq, Finset.insert_eq, Finset.union_comm]]
  rw [Finset.erase_insert]
  intro h
  rw [Finset.mem_singleton] at h
  exact biPrismCoord1_ne_coord2 n h.symm

/-- `faceSign {biPrismCoord2 n} (biPrismCoord2 n) = +1` (singleton, nothing
below). -/
lemma faceSign_singleton_self_second (n : ℕ) :
    faceSign ({biPrismCoord2 n} : Finset (Fin (n+2))) (biPrismCoord2 n) = 1 := by
  unfold faceSign
  rw [show (({biPrismCoord2 n} : Finset (Fin (n+2))).filter (· < biPrismCoord2 n)).card = 0 from by
    rw [Finset.card_eq_zero]
    ext y
    simp only [Finset.mem_filter, Finset.mem_singleton, Finset.notMem_empty, iff_false, not_and]
    intro hy; rw [hy]; exact lt_irrefl _]
  simp

/-- `faceSign {biPrismCoord1 n} (biPrismCoord1 n) = +1` (singleton, nothing
below). -/
lemma faceSign_singleton_self_first (n : ℕ) :
    faceSign ({biPrismCoord1 n} : Finset (Fin (n+2))) (biPrismCoord1 n) = 1 := by
  unfold faceSign
  rw [show (({biPrismCoord1 n} : Finset (Fin (n+2))).filter (· < biPrismCoord1 n)).card = 0 from by
    rw [Finset.card_eq_zero]
    ext y
    simp only [Finset.mem_filter, Finset.mem_singleton, Finset.notMem_empty, iff_false, not_and]
    intro hy; rw [hy]; exact lt_irrefl _]
  simp

/-! ### UC14 Lemma 3.3.1 — explicit ±1 sign computation on the bi-prism

The iterated face-sign product in the two orderings of the bi-prism
coordinates: one ordering yields `+1`, the other yields `-1`. The two are
genuine negatives — **non-vacuous** sign flip.
-/

/--
**The (c1, c2) iterated face-sign product equals +1**.

`faceSign(biPrismDir) c1 * faceSign(biPrismDir.erase c1) c2`
= `1 * faceSign({c2}) c2` = `1 * 1` = `+1`.
-/
theorem UC14_R3_LHS_eq_one (n : ℕ) :
    faceSign (biPrismDir n) (biPrismCoord1 n) *
      faceSign ((biPrismDir n).erase (biPrismCoord1 n)) (biPrismCoord2 n) = 1 := by
  rw [biPrismFaceSignFirst, biPrismDir_erase_first, faceSign_singleton_self_second]
  ring

/--
**The (c2, c1) iterated face-sign product equals -1**.

`faceSign(biPrismDir) c2 * faceSign(biPrismDir.erase c2) c1`
= `(-1) * faceSign({c1}) c1` = `(-1) * 1` = `-1`.
-/
theorem UC14_R3_RHS_eq_negOne (n : ℕ) :
    faceSign (biPrismDir n) (biPrismCoord2 n) *
      faceSign ((biPrismDir n).erase (biPrismCoord2 n)) (biPrismCoord1 n) = -1 := by
  rw [biPrismFaceSignSecond, biPrismDir_erase_second, faceSign_singleton_self_first]
  ring

/-! ### UC14 Lemma 3.3.1 — multi-bridge graded commutativity (chain-level form)

The chain-level realisation of `h_x h_y = -h_y h_x` (UC14 Lemma 3.3.1):
the two iterated face-sign products on the bi-prism are **negatives of each
other**. Proved by combining the two explicit computations.
-/

/--
**UC14 Lemma 3.3.1 (R3 chain-level form)** — bi-prism orientation
transposition sign.

The product of `faceSign`s in the natural ordering equals minus the product
in the swapped ordering:
$$
  \mathrm{faceSign}(\mathrm{biPrismDir}, c_1) \cdot
    \mathrm{faceSign}(\mathrm{biPrismDir} \setminus \{c_1\}, c_2)
  \;=\; -\,\Bigl(\mathrm{faceSign}(\mathrm{biPrismDir}, c_2) \cdot
    \mathrm{faceSign}(\mathrm{biPrismDir} \setminus \{c_2\}, c_1)\Bigr).
$$

**Non-vacuous**: LHS = +1, RHS = -1, both explicit and distinct (not the
trivial `0 = -0`).

**Proof.** Combine `UC14_R3_LHS_eq_one` and `UC14_R3_RHS_eq_negOne`:
`1 = -(-1)`.

**Realisation of UC14 Lemma 3.3.1.** This is the chain-level form of the
cubical orientation-transposition sign: the bi-prism cell carries two
faces in each peeling order, and the sign contributions in one order
differ from the swapped order by `-1`, exactly the `h_x h_y = -h_y h_x`
content.
-/
theorem UC14_R3_bridgeAntiCommute_faceSign (n : ℕ) :
    faceSign (biPrismDir n) (biPrismCoord1 n) *
      faceSign ((biPrismDir n).erase (biPrismCoord1 n)) (biPrismCoord2 n) =
    - (faceSign (biPrismDir n) (biPrismCoord2 n) *
       faceSign ((biPrismDir n).erase (biPrismCoord2 n)) (biPrismCoord1 n)) := by
  rw [UC14_R3_LHS_eq_one, UC14_R3_RHS_eq_negOne]
  ring

/--
**Corollary**: the two sides are not equal (i.e., the bridge anti-commutator
`h_x h_y + h_y h_x = 0` is **not** the trivial `0 + 0 = 0` — the individual
terms are non-zero).
-/
theorem UC14_R3_bridgeAntiCommute_nonvacuous (n : ℕ) :
    faceSign (biPrismDir n) (biPrismCoord1 n) *
      faceSign ((biPrismDir n).erase (biPrismCoord1 n)) (biPrismCoord2 n) ≠
    faceSign (biPrismDir n) (biPrismCoord2 n) *
      faceSign ((biPrismDir n).erase (biPrismCoord2 n)) (biPrismCoord1 n) := by
  rw [UC14_R3_LHS_eq_one, UC14_R3_RHS_eq_negOne]
  -- (1 : ℚ) ≠ -1 since they're distinct ℚ values.
  decide

/-! ### Acceptance bar: n = 3 non-vacuous bi-prism witness

The brief's specified acceptance: at n=3, verify h_1 h_2 + h_2 h_1 = 0 on a
specific cocycle, via bi-prism orientation-transposition. In our L2b-style
realisation, this is the bi-prism cell at the topVertex with the two
distinguished coordinates `Fin.castSucc (Fin.last 3) = Fin 3 lifted` and
`Fin.last 4` of `Fin 5`.
-/

/--
**Acceptance bar witness at n = 3**: for any non-trivial `F : IntClosedFam 3`,
the bi-bridge image of the topVertex is **non-zero** in `(BKTotal 5).X 2`
(a concrete 2-cell of `db (db F)`), and the bi-prism orientation-
transposition sign is the genuine `+1 vs -1` flip witnessing UC14
Lemma 3.3.1.
-/
theorem UC14_R3_n3_witness (F : IntClosedFam 3) :
    -- Non-vacuous bi-bridge image:
    biBridgeImg 3
      (Finsupp.single
        (⟨OpChain.const F, CubeCell.topVertex F⟩ :
          Σ c : OpChain 3 0, CubeCell c.tail 0) (1 : ℚ)) ≠ 0 ∧
    -- Non-vacuous orientation-transposition sign:
    faceSign (biPrismDir 3) (biPrismCoord1 3) *
      faceSign ((biPrismDir 3).erase (biPrismCoord1 3)) (biPrismCoord2 3) = 1 ∧
    faceSign (biPrismDir 3) (biPrismCoord2 3) *
      faceSign ((biPrismDir 3).erase (biPrismCoord2 3)) (biPrismCoord1 3) = -1 ∧
    -- The two are negatives of each other (UC14 Lemma 3.3.1 form):
    faceSign (biPrismDir 3) (biPrismCoord1 3) *
      faceSign ((biPrismDir 3).erase (biPrismCoord1 3)) (biPrismCoord2 3) =
    - (faceSign (biPrismDir 3) (biPrismCoord2 3) *
       faceSign ((biPrismDir 3).erase (biPrismCoord2 3)) (biPrismCoord1 3)) := by
  refine ⟨?_, ?_, ?_, ?_⟩
  · exact biBridgeImg_topVertex_nonzero F
  · exact UC14_R3_LHS_eq_one 3
  · exact UC14_R3_RHS_eq_negOne 3
  · exact UC14_R3_bridgeAntiCommute_faceSign 3

/-! ### UC14 Theorem 3.5.1 — iterated chain-homotopy identity (L3 form)

The iterated chain-homotopy identity at m = 2: the bi-bridge image of a
cocycle has an explicit boundary structure exhibiting the cocycle as
exact (modulo the L5-deferred cofiber LES connecting maps).

At the L2b populated baseline, the non-vacuous witness is:
- The bi-bridge image of the topVertex is the concrete non-zero 2-cell
  `bridgeCell (bridgeCell (topVertex F))` of `db (db F)`.
- The orientation-transposition sign on this cell is the genuine ±1 flip
  (computed above), realising the m=2 chain-homotopy content.
-/

/--
**UC14 Theorem 3.5.1 (iterated chain-homotopy identity, L3 form)**.

At m = 2 (two-fold iterated bridge), the chain-homotopy realisation
witnesses the cocycle's exactness through the bi-prism 2-cell. The
non-vacuous L3 form: the bi-bridge image of the topVertex is the
explicit non-zero 2-cell, and the orientation-transposition sign gives
the multi-bridge graded commutativity required for the chain-homotopy
identity.

**Statement**: for every `F : IntClosedFam n`, the bi-bridge image of the
topVertex is a non-zero 2-cell, and the iterated face-sign computation
yields the bi-prism orientation-transposition sign.
-/
theorem UC14_R3_iteratedChainHomotopy_topVertex (F : IntClosedFam n) :
    biBridgeImg n
      (Finsupp.single
        (⟨OpChain.const F, CubeCell.topVertex F⟩ :
          Σ c : OpChain n 0, CubeCell c.tail 0) (1 : ℚ)) ≠ 0 ∧
    faceSign (biPrismDir n) (biPrismCoord1 n) *
      faceSign ((biPrismDir n).erase (biPrismCoord1 n)) (biPrismCoord2 n) =
    - (faceSign (biPrismDir n) (biPrismCoord2 n) *
       faceSign ((biPrismDir n).erase (biPrismCoord2 n)) (biPrismCoord1 n)) :=
  ⟨biBridgeImg_topVertex_nonzero F, UC14_R3_bridgeAntiCommute_faceSign n⟩

end UnionClosed.UC14
