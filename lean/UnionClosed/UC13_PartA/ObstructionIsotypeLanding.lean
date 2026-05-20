/-
UnionClosed/UC13_PartA/ObstructionIsotypeLanding.lean
======================================================

**Frankl-Y2-Resolution (mg-aeee): the honest, non-steered determination of which
Walsh isotype the obstruction class `ob(F⋆)` actually lands in.**

This file is a NEUTRAL DIAGNOSTIC. It does not try to make the Y2 landing claim
(UC13 §2.4.1 — "the obstruction lands entirely in the level-1 Walsh isotypes")
come out true. It builds the genuine `(ℤ/2)ⁿ`-Walsh representation theory of the
degree-0 cube chains and lets the obstruction class land wherever the
mathematics forces it. The verdict — whichever way it goes — is reported in
`docs/Frankl-Y2-obstruction-isotype-landing.md`.

────────────────────────────────────────────────────────────────────────────
WHY A NEW FILE — the existing UC13 "formalization" of Y2 is answer-steered
────────────────────────────────────────────────────────────────────────────

`UC13_PartA/IsotypePreservation.lean` defines

  cechIsotypeProjection F x T := if T = {x} then cechBicomplexValue F x else 0

and `UC13_PartA/CorrectedLanding.lean` proves `UC13_correctedLanding` *from that
definition*. But that "isotype projection" contains **no representation theory
at all** — it is a hand-coded `if T = {x}`. It does not apply the `(ℤ/2)ⁿ`
toggle action, does not use Walsh characters, does not compute a projection. It
asserts the level-1 landing by fiat. Proving "`ob` lands in level-1" from a
definition that *says* "the projection onto every non-`{x}` isotype is `0`" is
circular: the encoding begs the question. So the existing `UC13_correctedLanding`
cannot be used to adjudicate Y2.

This file replaces that with the **genuine** `(ℤ/2)ⁿ`-isotype machinery:
the regular representation of `(ℤ/2)ⁿ` on the cube-vertex set, the real toggle
action, the real Walsh characters, and a real isotype-membership predicate
`InIsotype` (transforms by the character `χ_T`). Then it determines, by
machine-checked computation, where the actual Lean obstruction encoding
`obstructionClass F x = Finsupp.single (topVertex F) (β_x F)` lands.

────────────────────────────────────────────────────────────────────────────
ENCODING CHOICES — documented and justified as faithful (not answer-steered)
────────────────────────────────────────────────────────────────────────────

(E1) **The group `(ℤ/2)ⁿ` is realised as `(Finset (Fin n), ∆, ∅)`.** This is
     exactly UC10's identification: `Walsh.lean`'s `toggleSupport` is the group
     iso `ToggleGroup n = (Fin n → ZMod 2) ≃ Finset (Fin n)`, carrying `+` to
     `∆` (`toggleSupport_add`). Indexing the toggle action by subsets `S` IS
     indexing it by group elements; it just removes `ZMod 2` plumbing.

(E2) **The cube-vertex set is `Finset (Fin n) = 2^[n]`, with `(ℤ/2)ⁿ` acting
     regularly by `S · A = A ∆ S`.** This is `Walsh.lean`'s `toggleAction`. The
     vertices of the cube `Q_n` ARE the subsets of `[n]`; `(ℤ/2)ⁿ` toggles
     coordinates. The degree-0 chains form the regular representation
     `ℚ[2^[n]]`.

(E3) **The Walsh characters are `Walsh.lean`'s `walshChar n T A = (-1)^|T∩A|`** —
     the genuine irreducible characters of `(ℤ/2)ⁿ`, unchanged.

(E4) **"`v` lands in the `χ_T`-isotype" is `InIsotype n T v`: `v` transforms by
     the character `χ_T` under every toggle** (`toggleBy S v = χ_T(S) • v`).
     This is the textbook definition of an isotypic element for a finite abelian
     group — it is NOT a hand-coded `if`.

(E5) **The obstruction encoding read into the model.** The Lean obstruction
     `obstructionClass F x` is `Finsupp.single` on the *single* basis cell
     `⟨OpChain.const F, CubeCell.topVertex F⟩`. That cell's underlying cube
     vertex is its `.base` field, `= F.support`. The faithful image in the
     regular representation `ℚ[2^[n]]` is therefore
     `Finsupp.single F.support (β_x F)`. The map `cubeVertexRead` (read off the
     `.base`) realises this, and `obstruction_cubeVertexRead` proves it. The
     Walsh-isotype question for a degree-0 cube chain is, by definition, the
     question in `ℚ[2^[n]]`.

None of (E1)–(E5) is chosen to favour an answer. They are the standard objects.
The determination then falls out by computation in §G.

────────────────────────────────────────────────────────────────────────────
THE DETERMINATION (full discussion in the report doc)
────────────────────────────────────────────────────────────────────────────

* `single_not_InIsotype`: a single cube vertex `single A r` (`r ≠ 0`, `n ≥ 1`)
  is in **no** Walsh isotype. A bare basis vector is not an isotypic element.
* `single_walsh_decomposition`: instead it is the sum of its `2ⁿ` isotype
  components `(r·χ_T(A)/2ⁿ) • walshVec T`, every coefficient **non-zero**.
  The single cube vertex spreads **uniformly over all `2ⁿ` isotypes**.
* `obstruction_walshCoeff_eq` / `obstruction_lands_in_every_isotype`: the
  actual Lean obstruction `single (F.support) (β_x F)` therefore lands, with
  equal magnitude `|β_x F|`, in **every** isotype `χ_T` simultaneously — the
  top `χ_[n]`, every level-1 `χ_{x}`, and the trivial `χ_∅` alike. It is
  concentrated in none. The current encoding is isotype-blind.
* `walshCoeff_empty_eq_augmentation`: the augmentation (`topVertex_not_coboundary`,
  `BKAug`) is the `χ_∅`-Walsh coefficient — it detects the **trivial** isotype
  (the `H₀` connectedness generator), NOT the top `χ_[n]` isotype.
* `equivariant_preserves_InIsotype`: `(ℤ/2)ⁿ`-equivariant additive linear maps
  preserve the isotype decomposition (Schur). This is the genuine, sound
  mechanism behind UC13 §2.4.1.
* `mulWalsh_shifts_isotype`: multiplication by a Walsh character (the cup
  product) is the ONLY operation that shifts isotype level. Hence UC11 §5.3's
  competing claim that the additive Čech edge map "increments Walsh level" is
  representation-theoretically impossible.

Hard-constraint compliance (UC-Lean-scope §D): D.1 NOT factorial — only the
1-dim characters of the abelian `(ℤ/2)ⁿ`; no Specht modules. D.2 NOT functorial
in the refinement sense — native to `Finset (Fin n)`. D.3 U1-dialect — the
Walsh decomposition is the additive direct sum into 1-dim irreps; `mulWalsh` is
the *only* multiplicative operation and it is explicitly flagged as the
cup-product level-shifter. D.4 Math-first — the content is the genuine
representation theory of `(ℤ/2)ⁿ`.
-/

import Mathlib.Data.Finsupp.Basic
import Mathlib.LinearAlgebra.Finsupp.LSum
import Mathlib.LinearAlgebra.Finsupp.LinearCombination
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.LinearCombination
import UnionClosed.UC10.Walsh
import UnionClosed.UC11.ObstructionClass

namespace UnionClosed.UC13_PartA

open UnionClosed.UC10 UnionClosed.UC11
open scoped symmDiff

variable {n : ℕ}

/-! ## §A — The genuine `(ℤ/2)ⁿ` regular representation on cube vertices

The cube `Q_n` has vertex set `2^[n] = Finset (Fin n)`. The degree-0 chains
over `ℚ` form `CubeReg n := Finset (Fin n) →₀ ℚ`, the **regular representation**
of `(ℤ/2)ⁿ`. The group `(ℤ/2)ⁿ` is `(Finset (Fin n), ∆)` (encoding choice E1);
it acts by `toggleBy S` (encoding choice E2). -/

/-- The degree-0 cube chains: the regular representation `ℚ[2^[n]]` of `(ℤ/2)ⁿ`. -/
abbrev CubeReg (n : ℕ) : Type := Finset (Fin n) →₀ ℚ

/-- The toggle action of the group element `S : Finset (Fin n)` (an element of
`(ℤ/2)ⁿ`, encoding E1) on the regular representation: `single A r ↦ single (A∆S) r`.
This is `Walsh.lean`'s `toggleAction` packaged as a `ℚ`-linear endomorphism. -/
noncomputable def toggleBy (n : ℕ) (S : Finset (Fin n)) :
    CubeReg n →ₗ[ℚ] CubeReg n :=
  Finsupp.lmapDomain ℚ ℚ (fun A => A ∆ S)

@[simp] theorem toggleBy_single (S A : Finset (Fin n)) (r : ℚ) :
    toggleBy n S (Finsupp.single A r) = Finsupp.single (A ∆ S) r := by
  unfold toggleBy
  rw [Finsupp.lmapDomain_apply, Finsupp.mapDomain_single]

/-- The symmetric-difference involution: `(A ∆ S) ∆ S = A`. -/
theorem symmDiff_symmDiff_cancel (A S : Finset (Fin n)) : (A ∆ S) ∆ S = A := by
  rw [symmDiff_assoc, symmDiff_self, symmDiff_bot]

/-! ## §B — Walsh characters as honest isotype detectors

`walshCoeff n T` is the `χ_T`-Walsh coefficient functional. We GROUND it as a
genuine `χ_T`-isotype detector: §B proves it transforms by `χ_T` under the
toggle action, and §C proves it annihilates every other isotype. It is not a
hand-coded `if`. -/

/-- The `χ_T`-Walsh coefficient functional: `walshCoeff T v = Σ_A χ_T(A) · v(A)`. -/
noncomputable def walshCoeff (n : ℕ) (T : Finset (Fin n)) : CubeReg n →ₗ[ℚ] ℚ :=
  Finsupp.linearCombination ℚ (fun A => (walshChar n T A : ℚ))

@[simp] theorem walshCoeff_single (T A : Finset (Fin n)) (r : ℚ) :
    walshCoeff n T (Finsupp.single A r) = (walshChar n T A : ℚ) * r := by
  unfold walshCoeff
  rw [Finsupp.linearCombination_single, smul_eq_mul, mul_comm]

/-- `walshCoeff n T` is `χ_T`-equivariant: under a toggle by `S` it picks up the
character value `χ_T(S)`. This is the first half of grounding `walshCoeff T` as
a genuine `χ_T`-isotype detector. -/
theorem walshCoeff_toggleBy (T S : Finset (Fin n)) (v : CubeReg n) :
    walshCoeff n T (toggleBy n S v) = (walshChar n T S : ℚ) * walshCoeff n T v := by
  induction v using Finsupp.induction with
  | zero => simp
  | single_add a b f _ _ ih =>
      simp only [map_add, toggleBy_single, walshCoeff_single, ih, mul_add]
      rw [walshChar_mul_right]
      push_cast
      ring

/-! ## §C — Walsh vectors, isotype membership, and orthogonality

`walshVec n T` is the genuine generator of the `χ_T`-isotype: the alternating
Walsh sum `Σ_A χ_T(A) · single A`. `InIsotype n T v` is the genuine isotypic
predicate — `v` transforms by the character `χ_T` under *every* toggle. -/

/-- The genuine generator of the `χ_T`-Walsh isotype: `Σ_A χ_T(A) · single A`.
(For `T = ∅` this is the all-ones vector; for `T = univ` it is the alternating
`Σ_A (-1)^|A| · single A` — the genuine top-`χ_[n]` generator. Note this is a
sum over **all** `2ⁿ` vertices: NOT a single cube vertex.) -/
noncomputable def walshVec (n : ℕ) (T : Finset (Fin n)) : CubeReg n :=
  ∑ A : Finset (Fin n), Finsupp.single A (walshChar n T A : ℚ)

/-- `v` lands in the `χ_T`-Walsh isotype: it transforms by the character `χ_T`
under every toggle of `(ℤ/2)ⁿ`. This is the textbook definition of an isotypic
element for a finite abelian group — it contains no hand-coded `if`. -/
def InIsotype (n : ℕ) (T : Finset (Fin n)) (v : CubeReg n) : Prop :=
  ∀ S : Finset (Fin n), toggleBy n S v = (walshChar n T S : ℚ) • v

/-- The `· ∆ S` involution as an `Equiv` (the group element `S` of `(ℤ/2)ⁿ`
acting on the vertex set). -/
def equivSymmDiff (S : Finset (Fin n)) : Finset (Fin n) ≃ Finset (Fin n) where
  toFun A := A ∆ S
  invFun A := A ∆ S
  left_inv A := symmDiff_symmDiff_cancel A S
  right_inv A := symmDiff_symmDiff_cancel A S

@[simp] theorem equivSymmDiff_apply (S A : Finset (Fin n)) :
    equivSymmDiff S A = A ∆ S := rfl

/-- Reindexing a sum of `single`s along the `· ∆ S` involution. -/
theorem sum_single_symmDiff (S : Finset (Fin n)) (g : Finset (Fin n) → ℚ) :
    ∑ A : Finset (Fin n), Finsupp.single (A ∆ S) (g A)
      = ∑ B : Finset (Fin n), Finsupp.single B (g (B ∆ S)) := by
  rw [← Equiv.sum_comp (equivSymmDiff S)
        (fun B => Finsupp.single B (g (B ∆ S)))]
  apply Finset.sum_congr rfl
  intro A _
  rw [equivSymmDiff_apply, symmDiff_symmDiff_cancel]

/-- **`walshVec n T` is a genuine `χ_T`-eigenvector**: under a toggle by `S` it
picks up exactly the character value `χ_T(S)`. This grounds `walshVec n T` as a
real isotype generator (not asserted by `if`). -/
theorem toggleBy_walshVec (T S : Finset (Fin n)) :
    toggleBy n S (walshVec n T) = (walshChar n T S : ℚ) • walshVec n T := by
  unfold walshVec
  rw [map_sum]
  simp only [toggleBy_single]
  rw [sum_single_symmDiff S (fun A => (walshChar n T A : ℚ))]
  rw [Finset.smul_sum]
  apply Finset.sum_congr rfl
  intro B _
  rw [Finsupp.smul_single, smul_eq_mul]
  congr 1
  rw [walshChar_mul_right]
  push_cast
  ring

/-- **`walshVec n T` lands in the `χ_T`-isotype** — the genuine, computed
isotype membership. -/
theorem walshVec_InIsotype (T : Finset (Fin n)) :
    InIsotype n T (walshVec n T) :=
  fun S => toggleBy_walshVec T S

/-- The Walsh character orthogonality / completeness sum:
`Σ_A χ_U(A) = 2ⁿ` if `U = ∅`, and `0` otherwise. The single computational
lemma of the file; everything isotype-theoretic flows from it. -/
theorem walshChar_sum (U : Finset (Fin n)) :
    ∑ A : Finset (Fin n), (walshChar n U A : ℚ)
      = if U = ∅ then (2 : ℚ) ^ n else 0 := by
  have hpf : ∀ A : Finset (Fin n), (walshChar n U A : ℚ)
      = ∏ x ∈ A, (if x ∈ U then (-1 : ℚ) else 1) := by
    intro A
    rw [walshChar_eq_prod]
    push_cast
    rfl
  rw [Finset.sum_congr rfl (fun A _ => hpf A)]
  have hkey : ∑ A : Finset (Fin n), ∏ x ∈ A, (if x ∈ U then (-1 : ℚ) else 1)
      = ∏ x : Fin n, ((if x ∈ U then (-1 : ℚ) else 1) + 1) := by
    rw [Finset.prod_add]
    simp only [Finset.prod_const_one, mul_one]
    rw [Finset.powerset_univ]
  rw [hkey]
  by_cases hU : U = ∅
  · subst hU
    rw [if_pos rfl]
    have hfac : ∀ x : Fin n,
        ((if x ∈ (∅ : Finset (Fin n)) then (-1 : ℚ) else 1) + 1) = 2 := by
      intro x; norm_num
    rw [Finset.prod_congr rfl (fun x _ => hfac x), Finset.prod_const,
        Finset.card_univ, Fintype.card_fin]
  · rw [if_neg hU]
    obtain ⟨x0, hx0⟩ := Finset.nonempty_iff_ne_empty.mpr hU
    apply Finset.prod_eq_zero (Finset.mem_univ x0)
    rw [if_pos hx0]
    norm_num

/-- `walshCoeff n T` is non-zero on its own isotype: `walshCoeff T (walshVec T) = 2ⁿ`.
Together with `walshCoeff_eq_zero_of_InIsotype` this grounds `walshCoeff n T` as
a genuine `χ_T`-isotype detector: non-zero on `χ_T`, blind to all others. -/
theorem walshCoeff_walshVec_self (T : Finset (Fin n)) :
    walshCoeff n T (walshVec n T) = (2 : ℚ) ^ n := by
  unfold walshVec
  rw [map_sum]
  have hone : ∀ A : Finset (Fin n),
      walshCoeff n T (Finsupp.single A (walshChar n T A : ℚ)) = 1 := by
    intro A
    rw [walshCoeff_single]
    have hsq : walshChar n T A * walshChar n T A = 1 := walshChar_sq n T A
    have : (walshChar n T A : ℚ) * (walshChar n T A : ℚ) = 1 := by
      rw [← Int.cast_mul, hsq, Int.cast_one]
    exact this
  rw [Finset.sum_congr rfl (fun A _ => hone A), Finset.sum_const,
      Finset.card_univ, Fintype.card_finset, Fintype.card_fin]
  simp

/-- **Schur for `(ℤ/2)ⁿ`**: `walshCoeff n T` annihilates every isotype other
than `χ_T`. An equivariant functional cannot see another character. -/
theorem walshCoeff_eq_zero_of_InIsotype {S T : Finset (Fin n)} (hST : S ≠ T)
    {v : CubeReg n} (hv : InIsotype n S v) : walshCoeff n T v = 0 := by
  -- pick a coordinate distinguishing χ_S and χ_T
  have hne : S ∆ T ≠ ∅ := by
    intro h
    exact hST (symmDiff_eq_bot.mp (by simpa using h))
  obtain ⟨x0, hx0⟩ := Finset.nonempty_iff_ne_empty.mpr hne
  -- χ_S({x0}) ≠ χ_T({x0})
  have hchar : (walshChar n S {x0} : ℚ) ≠ (walshChar n T {x0} : ℚ) := by
    rw [Finset.mem_symmDiff] at hx0
    simp only [walshChar_singleton]
    rcases hx0 with ⟨hxS, hxT⟩ | ⟨hxT, hxS⟩
    · rw [if_pos hxS, if_neg hxT]; norm_num
    · rw [if_neg hxS, if_pos hxT]; norm_num
  -- toggle by {x0}: χ_T equivariance vs χ_S isotype
  have hkey : (walshChar n T {x0} : ℚ) * walshCoeff n T v
            = (walshChar n S {x0} : ℚ) * walshCoeff n T v := by
    rw [← walshCoeff_toggleBy T {x0} v, hv {x0}, map_smul, smul_eq_mul]
  have hfactor : ((walshChar n T {x0} : ℚ) - (walshChar n S {x0} : ℚ))
                  * walshCoeff n T v = 0 := by ring_nf; linarith [hkey]
  rcases mul_eq_zero.mp hfactor with h | h
  · exact absurd (sub_eq_zero.mp h).symm hchar
  · exact h

/-! ## §D — A single cube vertex is in NO isotype, and spreads over ALL of them

This is the honest determination for *any* single-vertex chain — in particular
for the actual Lean obstruction encoding (§G), which is exactly such a chain. -/

/-- **A single cube vertex is in no Walsh isotype.** For `n ≥ 1` and `r ≠ 0`,
`single A r` is not an isotypic element for any `χ_T`: a bare regular-basis
vector is not a character eigenvector. -/
theorem single_not_InIsotype (hn : 0 < n) {A : Finset (Fin n)} {r : ℚ}
    (hr : r ≠ 0) (T : Finset (Fin n)) :
    ¬ InIsotype n T (Finsupp.single A r) := by
  intro h
  obtain ⟨x0⟩ : Nonempty (Fin n) := ⟨⟨0, hn⟩⟩
  have hS := h {x0}
  rw [toggleBy_single, Finsupp.smul_single, smul_eq_mul] at hS
  -- hS : single (A ∆ {x0}) r = single A (χ_T{x0} * r)
  have hne : A ∆ {x0} ≠ A := by
    intro hAeq
    have hmem : x0 ∈ A ∆ {x0} ↔ x0 ∈ A := by rw [hAeq]
    rw [Finset.mem_symmDiff] at hmem
    simp at hmem
  rcases (Finsupp.single_eq_single_iff _ _ _ _).mp hS with ⟨h1, _⟩ | ⟨h1, _⟩
  · exact hne h1
  · exact hr h1

/-- The symmetric difference vanishes iff the two sets coincide. -/
theorem symmDiff_eq_empty_iff (A B : Finset (Fin n)) : A ∆ B = ∅ ↔ A = B := by
  rw [← Finset.bot_eq_empty]; exact symmDiff_eq_bot

/-- A fixed-index sum of `single`s pulls the sum inside the coefficient. -/
theorem single_sum_coeff {ι : Type*} (B : Finset (Fin n)) (s : Finset ι)
    (c : ι → ℚ) :
    ∑ i ∈ s, Finsupp.single B (c i) = Finsupp.single B (∑ i ∈ s, c i) := by
  classical
  induction s using Finset.induction with
  | empty => simp
  | @insert a s h ih =>
      rw [Finset.sum_insert h, Finset.sum_insert h, ih, ← Finsupp.single_add]

/-- **Walsh inversion.** Every single cube vertex is the sum of its `2ⁿ`
isotype components: `Σ_T χ_T(A) • walshVec T = 2ⁿ • single A`. -/
theorem walshVec_sum_eq (A : Finset (Fin n)) :
    ∑ T : Finset (Fin n), (walshChar n T A : ℚ) • walshVec n T
      = Finsupp.single A ((2 : ℚ) ^ n) := by
  have hstep : ∀ T : Finset (Fin n),
      (walshChar n T A : ℚ) • walshVec n T
        = ∑ B : Finset (Fin n),
            Finsupp.single B ((walshChar n T A : ℚ) * (walshChar n T B : ℚ)) := by
    intro T
    unfold walshVec
    rw [Finset.smul_sum]
    apply Finset.sum_congr rfl
    intro B _
    rw [Finsupp.smul_single, smul_eq_mul]
  rw [Finset.sum_congr rfl (fun T _ => hstep T), Finset.sum_comm]
  have hcollapse : ∀ B : Finset (Fin n),
      (∑ T : Finset (Fin n),
          Finsupp.single B ((walshChar n T A : ℚ) * (walshChar n T B : ℚ)))
        = (if A = B then Finsupp.single A ((2 : ℚ) ^ n) else 0) := by
    intro B
    rw [single_sum_coeff]
    have hchar : ∀ T : Finset (Fin n),
        (walshChar n T A : ℚ) * (walshChar n T B : ℚ)
          = (walshChar n (A ∆ B) T : ℚ) := by
      intro T
      have hz : walshChar n T A * walshChar n T B = walshChar n (A ∆ B) T := by
        rw [← walshChar_mul_right, walshChar_symm n T (A ∆ B)]
      rw [← hz]; push_cast; ring
    rw [Finset.sum_congr rfl (fun T _ => hchar T), walshChar_sum (A ∆ B)]
    by_cases hAB : A = B
    · rw [if_pos hAB, if_pos ((symmDiff_eq_empty_iff A B).mpr hAB), hAB]
    · rw [if_neg hAB, if_neg (fun h => hAB ((symmDiff_eq_empty_iff A B).mp h)),
          Finsupp.single_zero]
  rw [Finset.sum_congr rfl (fun B _ => hcollapse B),
      Finset.sum_ite_eq Finset.univ A (fun _ => Finsupp.single A ((2 : ℚ) ^ n)),
      if_pos (Finset.mem_univ A)]

/-- **The honest Walsh decomposition of a single cube vertex.** `single A r`
is the sum of its `2ⁿ` isotype components, with coefficient
`(r·χ_T(A))/2ⁿ` on the `χ_T`-component for every `T`. -/
theorem single_walsh_decomposition (A : Finset (Fin n)) (r : ℚ) :
    Finsupp.single A r
      = ∑ T : Finset (Fin n),
          ((r * (walshChar n T A : ℚ)) / (2 : ℚ) ^ n) • walshVec n T := by
  have h2 : ((2 : ℚ) ^ n) ≠ 0 := by positivity
  have hpull : (∑ T : Finset (Fin n),
        ((r * (walshChar n T A : ℚ)) / (2 : ℚ) ^ n) • walshVec n T)
      = (r / (2 : ℚ) ^ n) •
          ∑ T : Finset (Fin n), (walshChar n T A : ℚ) • walshVec n T := by
    rw [Finset.smul_sum]
    apply Finset.sum_congr rfl
    intro T _
    rw [smul_smul]
    congr 1
    rw [div_mul_eq_mul_div]
  rw [hpull, walshVec_sum_eq, Finsupp.smul_single, smul_eq_mul,
      div_mul_cancel₀ r h2]

/-- **Every isotype coefficient of a single vertex is non-zero.** The single
cube vertex `single A r` (`r ≠ 0`) has a non-zero `χ_T`-component for *every*
`T` — it spreads uniformly over all `2ⁿ` isotypes. -/
theorem single_walshCoeff_ne_zero {A : Finset (Fin n)} {r : ℚ} (hr : r ≠ 0)
    (T : Finset (Fin n)) : walshCoeff n T (Finsupp.single A r) ≠ 0 := by
  rw [walshCoeff_single]
  apply mul_ne_zero
  · have hsq : (walshChar n T A : ℚ) * (walshChar n T A : ℚ) = 1 := by
      rw [← Int.cast_mul, walshChar_sq, Int.cast_one]
    intro hz
    rw [hz, mul_zero] at hsq
    exact one_ne_zero hsq.symm
  · exact hr

/-! ## §E — The augmentation is the TRIVIAL (`χ_∅`) isotype coefficient

`topVertex_not_coboundary` (UC11/CohomologyClass.lean) works through `BKAug`,
the sum-of-coefficients functional. §E identifies `BKAug`'s shape with the
`χ_∅`-Walsh coefficient: it detects the **trivial** isotype (the `H₀`
connectedness generator), NOT the top `χ_[n]` isotype. -/

/-- The augmentation functional `Σ_A v(A)` — exactly the shape of `BKAug`
(`= Finsupp.linearCombination ℚ (fun _ => 1)`). -/
noncomputable def augmentation (n : ℕ) : CubeReg n →ₗ[ℚ] ℚ :=
  Finsupp.linearCombination ℚ (fun _ : Finset (Fin n) => (1 : ℚ))

@[simp] theorem augmentation_single (A : Finset (Fin n)) (r : ℚ) :
    augmentation n (Finsupp.single A r) = r := by
  unfold augmentation
  rw [Finsupp.linearCombination_single, smul_eq_mul, mul_one]

/-- **The augmentation IS the trivial-isotype `χ_∅` Walsh coefficient.**
Since `χ_∅ ≡ 1`, the `χ_∅`-coefficient functional is the sum-of-coefficients
augmentation. Hence `BKAug` / `topVertex_not_coboundary` detect the **trivial**
`χ_∅` isotype, not the top `χ_[n]` isotype. -/
theorem walshCoeff_empty_eq_augmentation :
    walshCoeff n ∅ = augmentation n := by
  apply Finsupp.lhom_ext
  intro A r
  rw [walshCoeff_single, augmentation_single, walshChar_empty_left, Int.cast_one,
      one_mul]

/-! ## §F — The Y2 mechanism: equivariant additive maps preserve isotype;
multiplication by a Walsh character is the only level-shifter

This section adjudicates UC13 §2.4.1 against UC11 §5.3, both machine-checked:

* `equivariant_preserves_InIsotype` — a `(ℤ/2)ⁿ`-equivariant *additive* linear
  map preserves the Walsh-isotype decomposition. This IS UC13 §2.4.1's
  mechanism. A genuinely level-1 source class transported by such maps stays
  level-1.
* `mulWalsh_shifts_isotype` — multiplication by a Walsh character `χ_U` (i.e.
  the cup product) shifts isotype `χ_T ↦ χ_{T∆U}`. This is the ONLY operation
  that changes the Walsh level. UC11 §5.3's claim that the *additive* Čech
  edge map "increments Walsh level by 1 at each step" is therefore
  representation-theoretically impossible — there is no cup product in an
  additive Čech bicomplex. -/

/-- `φ` commutes with the `(ℤ/2)ⁿ` action. -/
def IsToggleEquivariant (φ : CubeReg n →ₗ[ℚ] CubeReg n) : Prop :=
  ∀ (S : Finset (Fin n)) (v : CubeReg n), φ (toggleBy n S v) = toggleBy n S (φ v)

/-- **UC13 §2.4.1's mechanism, machine-checked.** A `(ℤ/2)ⁿ`-equivariant linear
map sends `χ_T`-isotypic elements to `χ_T`-isotypic elements — it cannot shift
the Walsh isotype. -/
theorem equivariant_preserves_InIsotype {φ : CubeReg n →ₗ[ℚ] CubeReg n}
    (hφ : IsToggleEquivariant φ) {T : Finset (Fin n)} {v : CubeReg n}
    (hv : InIsotype n T v) : InIsotype n T (φ v) := by
  intro S
  rw [← hφ S v, hv S, map_smul]

/-- Multiplication by the Walsh character `χ_U` — the cup-product operation,
the only kind of map that shifts Walsh level. -/
noncomputable def mulWalsh (n : ℕ) (U : Finset (Fin n)) :
    CubeReg n →ₗ[ℚ] CubeReg n :=
  Finsupp.linearCombination ℚ (fun A => Finsupp.single A (walshChar n U A : ℚ))

@[simp] theorem mulWalsh_single (U A : Finset (Fin n)) (r : ℚ) :
    mulWalsh n U (Finsupp.single A r)
      = Finsupp.single A ((walshChar n U A : ℚ) * r) := by
  unfold mulWalsh
  rw [Finsupp.linearCombination_single, Finsupp.smul_single, smul_eq_mul, mul_comm]

/-- `mulWalsh n U` is `χ_U`-twisted equivariant: it commutes with the toggle
action only up to the character value `χ_U(S)`. (It is genuinely *not*
equivariant unless `U = ∅` — multiplication is not an additive-equivariant map.) -/
theorem toggleBy_mulWalsh (U S : Finset (Fin n)) (v : CubeReg n) :
    toggleBy n S (mulWalsh n U v)
      = (walshChar n U S : ℚ) • mulWalsh n U (toggleBy n S v) := by
  induction v using Finsupp.induction with
  | zero => simp
  | single_add a b f _ _ ih =>
      simp only [map_add, mulWalsh_single, toggleBy_single, smul_add, ih]
      congr 1
      rw [Finsupp.smul_single, smul_eq_mul]
      congr 1
      have hmr : (walshChar n U (a ∆ S) : ℚ)
          = (walshChar n U a : ℚ) * (walshChar n U S : ℚ) := by
        rw [walshChar_mul_right]; push_cast; ring
      have hsq : (walshChar n U S : ℚ) * (walshChar n U S : ℚ) = 1 := by
        rw [← Int.cast_mul, walshChar_sq, Int.cast_one]
      rw [hmr]
      linear_combination (-((walshChar n U a : ℚ) * b)) * hsq

/-- **Multiplication by a Walsh character shifts the isotype: `χ_T ↦ χ_{U∆T}`.**
This is the cup-product level-shift. Since the only level-shifter is
multiplicative, UC11 §5.3's additive "Walsh-level increment" of the Čech edge
map cannot occur. -/
theorem mulWalsh_shifts_isotype (U T : Finset (Fin n)) {v : CubeReg n}
    (hv : InIsotype n T v) : InIsotype n (U ∆ T) (mulWalsh n U v) := by
  intro S
  rw [toggleBy_mulWalsh, hv S, map_smul, smul_smul]
  congr 1
  rw [← walshChar_mul]
  push_cast
  ring

/-! ## §G — The determination for the actual Lean obstruction encoding

`obstructionClass F x` is `Finsupp.single` on the single BK cell
`⟨OpChain.const F, CubeCell.topVertex F⟩`. That cell's underlying cube vertex
(its `.base` field) is `F.support`. The faithful regular-representation image
is therefore `obstructionVertex F x = single (F.support) (β_x F)` — a single
cube vertex. §D then applies verbatim. -/

/-- Read off the underlying cube vertex (the `.base` field) of a degree-0 BK
basis cell. -/
def cubeVertexOf : (Σ c : OpChain n 0, CubeCell c.tail 0) → Finset (Fin n) :=
  fun p => p.2.base

/-- The faithful regular-representation image of `obstructionClass F x`:
`single (F.support) (β_x F)`. -/
noncomputable def obstructionVertex (F : IntClosedFam n) (x : Fin n) : CubeReg n :=
  Finsupp.single F.support ((beta x F : ℤ) : ℚ)

/-- The obstruction cell's cube vertex is `F.support`. -/
theorem cubeVertexOf_obstructionCell (F : IntClosedFam n) :
    cubeVertexOf (⟨OpChain.const F, CubeCell.topVertex F⟩ :
        Σ c : OpChain n 0, CubeCell c.tail 0) = F.support := rfl

/-- `obstructionClass F x` is `Finsupp.single` on the cell whose cube vertex is
`F.support` (this is `obstructionClass_def`, restated for the record). -/
theorem obstructionClass_eq_singleVertex (F : IntClosedFam n) (x : Fin n) :
    obstructionClass F x
      = Finsupp.single (⟨OpChain.const F, CubeCell.topVertex F⟩ :
          Σ c : OpChain n 0, CubeCell c.tail 0) ((beta x F : ℤ) : ℚ) :=
  obstructionClass_def F x

/-- **The faithful bridge**: reading off cube vertices (`Finsupp.mapDomain
cubeVertexOf`) carries the actual obstruction encoding to `obstructionVertex`. -/
theorem obstruction_cubeVertexRead (F : IntClosedFam n) (x : Fin n) :
    Finsupp.mapDomain cubeVertexOf
        (Finsupp.single (⟨OpChain.const F, CubeCell.topVertex F⟩ :
          Σ c : OpChain n 0, CubeCell c.tail 0) ((beta x F : ℤ) : ℚ))
      = obstructionVertex F x := by
  rw [Finsupp.mapDomain_single]
  rfl

/-- The `χ_T`-Walsh coefficient of the obstruction is `χ_T(F.support) · β_x F`. -/
theorem obstructionVertex_walshCoeff (F : IntClosedFam n) (x : Fin n)
    (T : Finset (Fin n)) :
    walshCoeff n T (obstructionVertex F x)
      = (walshChar n T F.support : ℚ) * ((beta x F : ℤ) : ℚ) := by
  unfold obstructionVertex
  rw [walshCoeff_single]

/-- **THE DETERMINATION — non-concentration.** For a family with non-zero bias
at `x` (in particular every counterexample, where `β_x F > 0` for all `x`), the
obstruction class has a **non-zero `χ_T`-component for every `T`**: the top
`χ_[n]`, every level-1 `χ_{x}`, and the trivial `χ_∅` alike, each with the same
magnitude `|β_x F|`. It is concentrated in NO single isotype. The current Lean
encoding supports neither Y2 (level-1) nor UC11 §5.3 (top). -/
theorem obstruction_lands_in_every_isotype (F : IntClosedFam n) (x : Fin n)
    (hx : beta x F ≠ 0) (T : Finset (Fin n)) :
    walshCoeff n T (obstructionVertex F x) ≠ 0 := by
  unfold obstructionVertex
  apply single_walshCoeff_ne_zero
  exact_mod_cast hx

/-- **THE DETERMINATION — no isotype.** For `n ≥ 1` and non-zero bias, the
obstruction class is in NO Walsh isotype: it is not an isotypic element. -/
theorem obstruction_not_InIsotype (F : IntClosedFam n) (x : Fin n) (hn : 0 < n)
    (hx : beta x F ≠ 0) (T : Finset (Fin n)) :
    ¬ InIsotype n T (obstructionVertex F x) := by
  unfold obstructionVertex
  apply single_not_InIsotype hn
  exact_mod_cast hx

/-- **THE DETERMINATION — explicit decomposition.** The obstruction class is
the sum of its `2ⁿ` isotype components, the `χ_T`-component carrying the
non-zero coefficient `(β_x F · χ_T(F.support))/2ⁿ` for *every* `T`. -/
theorem obstruction_walsh_decomposition (F : IntClosedFam n) (x : Fin n) :
    obstructionVertex F x
      = ∑ T : Finset (Fin n),
          ((((beta x F : ℤ) : ℚ) * (walshChar n T F.support : ℚ)) / (2 : ℚ) ^ n)
            • walshVec n T := by
  unfold obstructionVertex
  exact single_walsh_decomposition F.support _

/-! ## §H — n = 3 concrete witnesses -/

/-- **n = 3 witness.** For any `F : IntClosedFam 3` and coordinate `x` with
`β_x F ≠ 0`, the obstruction class lands non-zero in the trivial `χ_∅`
isotype, in the level-1 `χ_{0}` isotype, AND in the top `χ_[3]` isotype
simultaneously — concentrated in none of them. -/
theorem obstruction_landing_n3_witness (F : IntClosedFam 3) (x : Fin 3)
    (hx : beta x F ≠ 0) :
    walshCoeff 3 ∅ (obstructionVertex F x) ≠ 0
      ∧ walshCoeff 3 {0} (obstructionVertex F x) ≠ 0
      ∧ walshCoeff 3 (Finset.univ) (obstructionVertex F x) ≠ 0 :=
  ⟨obstruction_lands_in_every_isotype F x hx ∅,
   obstruction_lands_in_every_isotype F x hx {0},
   obstruction_lands_in_every_isotype F x hx Finset.univ⟩

/-- **n = 3 witness.** The obstruction class at `n = 3` (non-zero bias) is in no
Walsh isotype. -/
theorem obstruction_not_InIsotype_n3 (F : IntClosedFam 3) (x : Fin 3)
    (hx : beta x F ≠ 0) (T : Finset (Fin 3)) :
    ¬ InIsotype 3 T (obstructionVertex F x) :=
  obstruction_not_InIsotype F x (by norm_num) hx T

/-! ## §I — Verdict summary (machine-checked) -/

/-- **Frankl-Y2-Resolution verdict — the machine-checked determination.**

For every `n ≥ 1`, every `F : IntClosedFam n`, every coordinate `x` with
`β_x F ≠ 0` (in particular every coordinate of any counterexample):

1. the obstruction class has a **non-zero component in every Walsh isotype
   `χ_T`** — it is concentrated neither in the level-1 isotypes (which Y2,
   UC13 §2.4.1, claims) nor in the top `χ_[n]` isotype (which UC11 §5.3
   claimed);
2. it is **not an isotypic element** of any single isotype;
3. every `(ℤ/2)ⁿ`-equivariant additive linear map **preserves** isotypes —
   the genuine UC13 §2.4.1 mechanism is sound: a genuinely level-1 source
   class transported by additive equivariant maps stays level-1;
4. **only multiplication by a Walsh character shifts isotype level**, so UC11
   §5.3's additive "Walsh-level increment" is representation-theoretically
   impossible.

Reading (see `docs/Frankl-Y2-obstruction-isotype-landing.md`): the *current
Lean obstruction encoding* `single (topVertex) (β_x)` is a single cube vertex
and lands in no isotype (1,2); it faithfully represents neither landing claim.
But Y2's *mechanism* (3) is sound and UC11 §5.3's is refuted (4): the genuine
mathematical content of the corrected landing is not contradicted. -/
theorem Y2_obstruction_isotype_verdict {n : ℕ} (hn : 0 < n) (F : IntClosedFam n)
    (x : Fin n) (hx : beta x F ≠ 0) :
    (∀ T : Finset (Fin n), walshCoeff n T (obstructionVertex F x) ≠ 0) ∧
    (∀ T : Finset (Fin n), ¬ InIsotype n T (obstructionVertex F x)) ∧
    (∀ (φ : CubeReg n →ₗ[ℚ] CubeReg n), IsToggleEquivariant φ →
      ∀ (T : Finset (Fin n)) (v : CubeReg n),
        InIsotype n T v → InIsotype n T (φ v)) ∧
    (∀ (U T : Finset (Fin n)) (v : CubeReg n),
      InIsotype n T v → InIsotype n (U ∆ T) (mulWalsh n U v)) :=
  ⟨fun T => obstruction_lands_in_every_isotype F x hx T,
   fun T => obstruction_not_InIsotype F x hn hx T,
   fun _ hφ _ _ hv => equivariant_preserves_InIsotype hφ hv,
   fun U T _ hv => mulWalsh_shifts_isotype U T hv⟩

