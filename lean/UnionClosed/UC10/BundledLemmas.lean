/-
UnionClosed/UC10/BundledLemmas.lean
====================================

UC10 bundled-lemmas index (UC-Lean-scope §C.1 Output spec):
- Lemma 2.3 (trace preserves intersection-closure) — see `IntClosedFam.lean`:
  `traceMor_exists` (proven; provides the codomain object for trace morphisms).
- Lemma 3.2 (polynomial-in-|F| size bound on X(F)) — see `CubicalDefect.lean`:
  `singleFamilyComplex_size_bound` (**proven via `toPair` Finset.card injection;
  UC-Lean-size-bound mg-8ce5**).
- Lemma 3.6 (bi-equivariance of X_n^∩ under Γ_n) — see `XNcap.lean`:
  `XNcap_equivariant` (stated as placeholder; Γ_n-Rep structure upgrade in L2/L3).

This file re-exports the three lemmas by name for the L1 deliverable summary.

Source: docs/union-closed-UC10-native-cohomology-intersection-closed-families.md
  §§2.3 (Lemma 2.3), 3.1+3.2 (Lemma 3.2), 3.5 (Lemma 3.6).

Hard-constraint compliance — see individual module headers; this file is a
re-export only and adds no new logic.
-/

import UnionClosed.UC10.IntClosedFam
import UnionClosed.UC10.CubicalDefect
import UnionClosed.UC10.XNcap

namespace UnionClosed.UC10

/--
**UC10 Lemma 2.3 (re-export)** — trace preserves intersection-closure.

See `UnionClosed.UC10.traceMor_exists` in `IntClosedFam.lean` for the proof.
This re-export packages the result as a named L1 deliverable.
-/
theorem UC10_Lemma_2_3 {n : ℕ} (X : IntClosedFam n) (T : Finset (Fin n))
    (hT : T ⊆ X.support) :
    ∃ Y : IntClosedFam n,
      Y.support = T ∧ Y.family = X.family.image (fun A => A ∩ T) :=
  traceMor_exists X T hT

/--
**UC10 Lemma 3.2 (re-export)** — polynomial-in-|F| size bound on `X(F)`.

See `UnionClosed.UC10.singleFamilyComplex_size_bound` in `CubicalDefect.lean`.
**Status:** proven via the `CubeCell.toPair` injection into
`X.family ×ˢ (Finset.univ : Finset (Fin n)).powersetCard k`
(UC-Lean-size-bound, mg-8ce5). Non-vacuity witnessed at n=3 / n=4 (k=0, k=1).
-/
theorem UC10_Lemma_3_2 {n : ℕ} (X : IntClosedFam n) (k : ℕ) :
    (CubeCell.cells X k).card ≤ X.family.card * Nat.choose n k * 2 ^ k :=
  singleFamilyComplex_size_bound X k

/--
**UC10 Lemma 3.6 (re-export)** — bi-equivariance of `X_n^∩` under
`Γ_n = (Z/2)^n ⋊ S_n`.

See `UnionClosed.UC10.XNcap_equivariant` in `XNcap.lean`. **Status:** stated
as `True` placeholder; the actual `Rep ℚ (HyperOctGroup n)` typing requires
the BK bicomplex to be `Γ_n`-equivariantly populated (second half of G2), to
be carried out in L2/L3 once the bicomplex is concrete.
-/
theorem UC10_Lemma_3_6 (n : ℕ) :
    -- Placeholder statement (UC10 §3.5 bi-equivariance), upgraded in L2/L3.
    True :=
  XNcap_equivariant n

end UnionClosed.UC10
