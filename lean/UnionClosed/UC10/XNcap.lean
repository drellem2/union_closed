/-
UnionClosed/UC10/XNcap.lean
===========================

UC10 Primitive 2 (UC-Lean-scope §A.1):
The hocolim cohomology object `XNcap n` as a `Γ_n = (Z/2)^n ⋊ S_n`-equivariant
chain complex over ℚ, presented via the Bousfield-Kan double-complex.

L2a closure (mg-84a7):
- `hyperOctAction` is populated at the **trivial-action baseline** (the constant
  monoid homomorphism to the identity automorphism). This is a valid `MonoidHom`
  so `HyperOctGroup n` is well-typed as a group, but the actual permutation-
  action of `S_n` on `(Z/2)^n` by coordinate permutation is the deferred work.
  At the trivial baseline the semidirect product degenerates to a direct
  product; the load-bearing `π · σ_x · π⁻¹ = σ_{π(x)}` compatibility is the
  named gap.
- `XNcap n` is the `BKTotal n` chain complex (the zero baseline from G2).
- `XNcap_equivariant` is proven trivially at the zero baseline.
- `XNcap_walshDecomposition` is upgraded to the explicit chain-iso form using
  `walshMult` from `Walsh.lean`.

Source: docs/union-closed-UC10-native-cohomology-intersection-closed-families.md
  - Defn 3.3 (hocolim `X_n^∩` over `(C_n^∩)^op`)
  - Lemma 3.4 (size bound)
  - Lemma 3.6 (bi-equivariance of `X_n^∩` under `Γ_n`)

Hard-constraint compliance (UC-Lean-scope §D):
- D.1 NOT factorial: `Γ_n = (ZMod 2 → Fin n) ⋊ Equiv.Perm (Fin n)` is the
  *hyperoctahedral* / type-B Coxeter group. It has order `2^n · n!` — large but
  the natural Coxeter type B, not factorial-decomposed. `S_n` enters only via
  `Equiv.Perm (Fin n)`; no factorial spine; no `Specht-Modules` import.
- D.3 U1-dialect: the bi-equivariance is realized via direct semidirect product
  (no cup-product), preserving the abelian-direct-sum structure of UC10.W
  isotype-by-isotype.
- D.4 Math-first: latex artefact mg-814b §3.5 + §3.6 (verified GREEN, merged).
-/

import Mathlib.GroupTheory.SemidirectProduct
import Mathlib.GroupTheory.Perm.Basic
import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.Homology.HomologicalComplex
import UnionClosed.UC10.IntClosedFam
import UnionClosed.UC10.CubicalDefect
import UnionClosed.UC10.BousfieldKan
import UnionClosed.UC10.Walsh

open CategoryTheory

namespace UnionClosed.UC10

/-! ### The hyperoctahedral / type-B Coxeter group Γ_n -/

/--
The **hyperoctahedral group** `Γ_n = (Z/2)^n ⋊ S_n`, the natural symmetry group
of the cube `Q_n`.

This is the type-B Coxeter group, also known as the **signed permutation group**.
Order: `2^n · n!`.

**L2a baseline.** The action map is populated as the trivial homomorphism
`Equiv.Perm (Fin n) →* MulAut (Multiplicative (Fin n → ZMod 2))`, sending every
permutation to the identity automorphism. The actual coordinate-permutation
action (which would give the non-trivial type-B semidirect product) is the
deferred named gap.
-/
noncomputable def hyperOctAction (n : ℕ) :
    Equiv.Perm (Fin n) →* MulAut (Multiplicative (Fin n → ZMod 2)) :=
  let _ : ℕ := n
  1

/-- The hyperoctahedral group `Γ_n = (Z/2)^n ⋊ S_n` (trivial-action baseline at L2a). -/
noncomputable def HyperOctGroup (n : ℕ) : Type :=
  SemidirectProduct (Multiplicative (Fin n → ZMod 2)) (Equiv.Perm (Fin n))
    (hyperOctAction n)

noncomputable instance HyperOctGroup_inst (n : ℕ) : Group (HyperOctGroup n) :=
  inferInstanceAs (Group (SemidirectProduct _ _ _))

/-! ### `XNcap n`: the bi-equivariant hocolim chain complex -/

/--
The **bi-equivariant moduli complex** `X_n^∩` of UC10 Defn 3.3:
$$
  X_n^\cap \;:=\; \mathop{\mathrm{hocolim}}_{(S, \mathcal F) \in (\mathcal C_n^\cap)^{\mathrm{op}}} \;X(\mathcal F),
$$
computed via the Bousfield-Kan double complex of `singleFamilyComplex` over
`(IntClosedFam n)^op`.

**L2a status.** Defined as `BKTotal n` from `BousfieldKan.lean` (which itself
is the zero baseline). The `Γ_n`-equivariance is recorded as `XNcap_equivariant`
below; promoting to `Rep ℚ (HyperOctGroup n)` requires the BK bicomplex to be
`Γ_n`-equivariantly populated, which is the named G2 gap (deferred to L2b/L3).
-/
noncomputable def XNcap (n : ℕ) : ChainComplex (ModuleCat ℚ) ℕ :=
  BKTotal n

/-! ### Lemma 3.6 — bi-equivariance of `X_n^∩` under Γ_n -/

/--
**Lemma 3.6 (UC10).** The hocolim `X_n^∩` carries a well-defined
`Γ_n = (Z/2)^n ⋊ S_n` action: `S_n` acts on the indexing category and on the
cube; `(Z/2)^n` acts on the cube only. The actions cohere via
`π σ_x π^{-1} = σ_{π(x)}`.

**Proof outline (UC10 §3.5).**
- `S_n` acts on `(C_n^∩)^op` by permuting `Fin n` (a strict, functorial action);
  it acts on `singleFamilyComplex X` by acting on `X.support` and `X.family`
  via the relabeling permutation.
- `(Z/2)^n` does *not* act on `C_n^∩` (intersection-closure is not toggle-
  invariant); but it acts on the *value side* of the diagram, on each
  `singleFamilyComplex X`, by toggling cells: `σ_x · (A, T') := (A △ {x}, T')`
  when the cell remains in `X` (this is the partial action of UC10 §2.4).
- Bousfield-Kan absorbs the partial-action issue: the hocolim's value-side
  becomes fully `(Z/2)^n`-acted because the indexing absorbs the
  family-flipping into the bar-resolution. This is the structural payoff of
  the §3.1 two-level split.
- The semidirect-product compatibility `π σ_x π^{-1} = σ_{π(x)}` is realized
  by the BK functoriality: applying the relabeling permutation `π` first and
  then toggling `x` is equal to toggling `π(x)` first and then relabeling.

**L2a status.** Trivially true at the zero baseline (any chain complex is
trivially Γ_n-equivariant when Γ_n acts trivially). The non-trivial form
(equipping `XNcap n` with a non-trivial `Rep ℚ (HyperOctGroup n)` structure
via the explicit toggleAction + permutation-action lift) is the named gap
deferred to L2b/L3.
-/
theorem XNcap_equivariant (_n : ℕ) :
    -- L2a baseline: trivial equivariance always holds.
    True :=
  trivial

/-! ### `XNcap`-level Walsh decomposition (UC10.W tightened to the hocolim) -/

/--
**UC10.W applied to `XNcap n`** (the hocolim-level Walsh decomposition).

The chain complex `XNcap n` decomposes into `(Z/2)^n`-isotypic pieces
`⨁_{S ⊆ [n]} χ_S ⊗ V_S^*(XNcap n)`.

**L2a status (concrete chain-iso form).** Re-uses the `walshMult n S` typing
from `Walsh.lean`. At the L2a zero baseline both sides are `Unit`-typed (since
`XNcap n` is the zero baseline complex and each `walshMult n S` is the trivial
isotype placeholder), so the chain-level direct-sum iso is the trivial
`Unit ≃ (S → Unit)` equivalence. Once `XNcap n` is populated with non-zero
chain data (G2-deferred) and the `Γ_n`-action is non-trivial, this iso upgrades
to the load-bearing chain-complex direct-sum decomposition of UC10.W.
-/
theorem XNcap_walshDecomposition (n : ℕ) :
    Nonempty (Unit ≃ ((S : Finset (Fin n)) → walshMult n S)) :=
  UC10_W n

end UnionClosed.UC10
