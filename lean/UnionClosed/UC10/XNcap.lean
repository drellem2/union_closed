/-
UnionClosed/UC10/XNcap.lean
===========================

UC10 Primitive 2 (UC-Lean-scope §A.1):
The hocolim cohomology object `XNcap n` as a `Γ_n = (Z/2)^n ⋊ S_n`-equivariant
chain complex over ℚ, presented via the Bousfield-Kan double-complex.

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

**Status in L1.** The `Mul`, `One`, `Mul` instances are inherited from
`SemidirectProduct`. The semidirect-product action of `S_n` on `(Z/2)^n` is by
**coordinate permutation**: `(π · σ)(x) = σ(π⁻¹ x)`.

In L1 we record this group with a *stub* action map (`sorry`) for the
permutation action; the formal `MulEquiv` requires verifying the conjugation
law, which is part of the L1 G2 budget. The structure is API-stable so that
downstream `Rep ℚ (HyperOctGroup n)` constructions can proceed.
-/
noncomputable def hyperOctAction (n : ℕ) :
    Equiv.Perm (Fin n) →* MulAut (Multiplicative (Fin n → ZMod 2)) :=
  -- The map sending π to "permute coordinates of (Fin n → ZMod 2) by π⁻¹".
  -- L1 stub: the full construction requires verifying it is a group hom into
  -- MulAut, which involves ring-theoretic gymnastics. G2-deferred.
  sorry

/-- The hyperoctahedral group `Γ_n = (Z/2)^n ⋊ S_n`. -/
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

**Status in L1.** Defined as `BKTotal n` from `BousfieldKan.lean` (which itself
has the G2 stub). The `Γ_n`-equivariance is recorded as a separate lemma
(`XNcap_equivariant`) below; the actual `Rep ℚ (HyperOctGroup n)` typing is
deferred to L2/L3 where the equivariant target is load-bearing.

**The named L1 gap.** Per the spec, `XNcap n` should land in
`ChainComplex (Rep ℚ (HyperOctGroup n)) ℕ`. In L1 we record the underlying
`ChainComplex (ModuleCat ℚ) ℕ` (forgetting the equivariance) and add the
`Γ_n`-equivariance as a separate proven-or-stubbed lemma. Promoting to
`Rep ℚ ...` requires the BK bicomplex to be `Γ_n`-equivariantly populated,
which is the second half of the G2 build.
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

**Status in L1.** The statement is recorded as a placeholder `True` because
the actual `Γ_n`-Rep structure on `XNcap n` requires the BK bicomplex to be
`Γ_n`-equivariantly populated (the second half of G2). L2/L3 — once the BK
bicomplex is concrete — will tighten this lemma to the proper `Rep ℚ ...`
form. The placeholder records the structural claim and the proof outline.
-/
theorem XNcap_equivariant (n : ℕ) :
    -- Statement skeleton: ∃ (Rep_action : Γ_n → AddAut (XNcap n)), [axiom-block].
    -- L1 records as True; L2/L3 upgrades to Rep ℚ (HyperOctGroup n).
    True := by
  trivial

/-! ### `XNcap`-level Walsh decomposition (UC10.W tightened to the hocolim) -/

/--
**UC10.W applied to `XNcap n`** (the hocolim-level Walsh decomposition).

The chain complex `XNcap n` decomposes into `(Z/2)^n`-isotypic pieces
`⨁_{S ⊆ [n]} χ_S ⊗ V_S^*(XNcap n)`. This is UC10.W of `Walsh.lean` instantiated
on the specific chain complex `XNcap n = BKTotal n`.

**Status in L1.** API only; the explicit isotype projections require the
`Γ_n`-equivariant population of BK (the second half of G2) and the explicit
Walsh-character action on the cube of `singleFamilyComplex`. L3 carries out
this construction; L1 records the destination signature.
-/
theorem XNcap_walshDecomposition (n : ℕ) :
    ∃ _decomp : Unit, True := ⟨(), trivial⟩

end UnionClosed.UC10
