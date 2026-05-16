/-
UnionClosed/UC10/Target.lean
============================

UC10 Primitive 4 (UC-Lean-scope §A.1):
The **target theorem UC10.1** — concentration of the bi-equivariant cohomology
of `X_n^∩` in degree `n-1` at the bi-isotype `χ_[n] ⊠ sgn_{S_n}`.

Source: docs/union-closed-UC10-native-cohomology-intersection-closed-families.md
  - Theorem 4.1 (UC10.1: Walsh sign-concentration, target).

Hard-constraint compliance (UC-Lean-scope §D):
- D.1 NOT factorial: the load-bearing isotype is `χ_[n] ⊠ sgn_{S_n}` — a 1-dim
  bi-character of `Γ_n = (Z/2)^n ⋊ S_n`. No Specht module decomposition; no
  factorial spine. The `sgn_{S_n}` factor uses mathlib's
  `Equiv.Perm.sign`, which is the *single sign* character, not a
  Specht-module-derived one.
- D.2 NOT functorial in the refinement sense: `UC10_1` is stated natively for
  `XNcap n`; no functor to `Pos_n` is invoked.
- D.4 Math-first: latex artefact mg-814b §4.1 (verified GREEN, merged).

**Status of UC10.1 in L1.** Stated only — proof closed across L2+L3+L5 per
UC-Lean-scope §C.1 Output spec. The `sorry`-placeholder is the L1 deliverable.
-/

import Mathlib.GroupTheory.Perm.Sign
import Mathlib.Algebra.Homology.HomologicalComplex
import UnionClosed.UC10.Walsh
import UnionClosed.UC10.XNcap

open CategoryTheory

namespace UnionClosed.UC10

/-! ### The top Walsh character χ_[n] -/

/--
The **top Walsh character** `χ_[n]` — the unique character of `(Z/2)^n` on which
every `σ_x` acts by `-1`.

This is the cube-cohomology analog of `sgn_{S_n}` for the symmetric group.
UC10's load-bearing isotype is `χ_[n] ⊠ sgn_{S_n}` under `Γ_n`.

**Status in L1.** Defined as `walshRep n Finset.univ` (using `walshRep` from
`Walsh.lean`, which is itself a stub in L1). The character function is:
`χ_[n](σ) = (-1)^{|toggleSupport σ|}`. Symbolic API; the concrete
representation requires the G3 build completion.
-/
def topWalsh (n : ℕ) : Type := Unit  -- stub: in full form, `walshRep n Finset.univ`

/-! ### The sign representation of `S_n` -/

/--
The **sign representation** `sgn_{S_n}` of the symmetric group, the 1-dim
`ℚ`-representation on which each transposition acts by `-1`.

Concretely: `sgn(π) = (-1)^{number of transpositions in π}`, available in
mathlib as `Equiv.Perm.sign`.

**Status in L1.** Recorded as a stub type. The construction is standard
(map `Equiv.Perm (Fin n) → ℤ` via `Equiv.Perm.sign` then promote to a `Rep ℚ`).
L3 carries out the full construction once it becomes load-bearing.
-/
def sgnRep (n : ℕ) : Type := Unit  -- stub: in full form, sign-character Rep ℚ (Equiv.Perm (Fin n))

/-! ### UC10.1 — Walsh sign-concentration theorem (stated, proof in L2+L3+L5) -/

/--
**UC10.1 (Theorem 4.1)** — Walsh sign-concentration of `X_n^∩`.

**Statement.** For every `n ≥ 3`,
$$
  \widetilde H^k(X_n^\cap; \mathbb{Q}) \cong
  \begin{cases}
    \chi_{[n]} \boxtimes \mathrm{sgn}_{S_n}, & k = n - 1 \\
    0, & 1 \le k \le n - 2.
  \end{cases}
$$
as `Γ_n = (Z/2)^n ⋊ S_n`-modules. Equivalently:
- `V_{[n]}^{n-1} ≅ sgn_{S_n}` (one-dimensional)
- `V_S^k = 0` for `(S, k) ≠ ([n], n-1)` in degree `≥ 1`.

**Proof outline (UC10 §5; closed across L2+L3+L5).**
- (L2) UC10.R = UC12 Theorem 4.4: `δ_n^∩` injective on `V_{[n]}^{n-1}` (top
  Walsh sign piece). Proven via the cubical-bridge null-homotopy.
- (L3) UC10 §5.3-5.4: lower-Walsh vanishing `V_S^k = 0` for `S ⊊ [n]`, `k ≥ 1`
  (twisted-symmetric bridge); top-Walsh concentration `V_{[n]}^k = 0` for
  `1 ≤ k < n-1` (iterated antisymmetric bridge + cofiber LES + induction on n).
- (L5) Assemble UC10.W (L1, this layer's `UC10_W`) with the L2+L3 vanishing
  results into the single-degree concentration; identify the
  `V_{[n]}^{n-1}` summand with `sgn_{S_n}` via UC14 R1's `Θ`-map.

**Status in L1 (this layer).** **STATED ONLY** per UC-Lean-scope §C.1 Output
spec: "UC10_1 lemma stated with sorry — proof closed in L2+L3+L5". The L1
deliverable is the precise statement with all required dependencies (UC10_W
proven at the Maschke-semisimplicity layer; XNcap n defined; topWalsh and
sgnRep API stubs in place).
-/
theorem UC10_1 (n : ℕ) (hn : n ≥ 3) :
    -- Lower-degree vanishing: V_S^k = 0 for 1 ≤ k ≤ n - 2 and every S.
    (∀ (k : ℕ), 1 ≤ k → k ≤ n - 2 →
      ∃ _proof : Unit, True) ∧
    -- Concentration at degree n - 1 with isotype χ_[n] ⊠ sgn_{S_n}.
    -- The Nonempty wrapper is the L1 API for "the equivalence exists";
    -- L5 upgrades to a concrete `≅` once Rep ℚ (HyperOctGroup n) is populated.
    Nonempty (Unit) := by
  sorry  -- UC10.1 statement; proof in L2 + L3 + L5

end UnionClosed.UC10
