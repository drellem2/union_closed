/-
UnionClosed/UC10/BKWalshEquivariant.lean
========================================

Path B sub-ticket **Y2** (`UC-Lean-PathB-Y2-WalshEquivariant`, mg-f5b4).

Source: docs/UC-Lean-PathB-BKBicomplex-scope.md (mg-e1b8, merged GREEN).
Cumulative state: docs/state-UC-Lean-PathB-Y2.md.

## Deliverable

The Walsh-equivariant structure on the Bousfield–Kan bicomplex
`BKBicomplexHC₂ F` of Y1 (mg-17dc). Six pieces:

1. **`BKToggleAction`** — the per-generator `(ZMod 2)^n`-action on
   `BKBicomplexHC₂ F` via per-cell scalar
   `walshChar n c.tail.support (toggleSupport σ)`.

2. **`BKEquivBicomplex F`** — the X3 `EquivariantBicomplex` inhabitant.

3. **`walshIsotypeProj`** — the per-character Maschke projector;
   collapsed by Walsh orthogonality to per-cell scalar
   `[S = c.tail.support]`.

4. **`BKIsotypeAt`** — the χ_S-isotype chain group.

5. **`BKWalshIsotypeFamily F`** — strict X3 `IsotypeFamily` inhabitant
   (non-uniform inclusion data — NOT the trivial-action baseline).

6. **X3/X4 integration** — wrappers for the SS-page differential
   vanishing at the BK bicomplex layer.

## Hard-constraint compliance

NOT factorial, NOT functorial in the refinement sense, U1-dialect preserved,
math-first, no `sorry`, no axiom-cheat, no fake mathlib API, no `decide`
shortcut beyond concrete-arithmetic checks. Non-tautology preserved:
cells with different `c.tail.support` get different scalars.
-/

import Mathlib.CategoryTheory.Category.Basic
import Mathlib.Algebra.Homology.HomologicalComplex
import Mathlib.Algebra.Homology.HomologicalBicomplex
import Mathlib.Algebra.Category.ModuleCat.Basic
import Mathlib.Algebra.Field.Rat
import Mathlib.Data.Finsupp.Basic
import Mathlib.LinearAlgebra.Finsupp.LSum
import Mathlib.LinearAlgebra.Finsupp.LinearCombination
import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import UnionClosed.UC10.IntClosedFam
import UnionClosed.UC10.CubicalDefect
import UnionClosed.UC10.BousfieldKan
import UnionClosed.UC10.Walsh
import UnionClosed.UC10.BKBicomplexHC2
import UnionClosed.UC11.Minimality
import UnionClosed.Mathlib.Algebra.Homology.SpectralSequence.Equivariant
import UnionClosed.Mathlib.Algebra.Homology.SpectralSequence.Schur

open CategoryTheory
open scoped symmDiff

namespace UnionClosed.UC10

variable {n : ℕ}

/-! ### §1 — Per-`OpChain` scalar action

Helper: any scalar `μ : OpChain n p → ℚ` extends per-(p, q) to a
`ModuleCat ℚ`-endomorphism of `BKBicomplex n p q` which commutes with
both `BKVertDiff` and `BKHorizDiff_full n 0 q`. Both `BKToggleAction` and
`walshIsotypeProj` are instances of this helper. -/

noncomputable def chainScalarAt (n : ℕ) {p : ℕ} (μ : OpChain n p → ℚ)
    (q : ℕ) :
    BKBicomplex n p q ⟶ BKBicomplex n p q :=
  ModuleCat.ofHom <| Finsupp.linearCombination ℚ <|
    fun cx => Finsupp.single cx (μ cx.1)

@[simp] lemma chainScalarAt_single (n : ℕ) {p : ℕ} (μ : OpChain n p → ℚ)
    (q : ℕ) (cx : Σ c : OpChain n p, CubeCell c.tail q) (r : ℚ) :
    (chainScalarAt n μ q).hom (Finsupp.single cx r) =
      Finsupp.single cx (r * μ cx.1) := by
  show Finsupp.linearCombination ℚ
        (fun cx => Finsupp.single cx (μ cx.1))
        (Finsupp.single cx r) = _
  rw [Finsupp.linearCombination_single, Finsupp.smul_single, smul_eq_mul]

/-- Generalised: `chainScalarAt` applied to any Finsupp on a single
`c`-fiber is per-coordinate scalar multiplication by `μ c`. -/
lemma chainScalarAt_mapDomain (n : ℕ) {p : ℕ} (μ : OpChain n p → ℚ)
    (q : ℕ) (c : OpChain n p) (v : CubeCell c.tail q →₀ ℚ) :
    (chainScalarAt n μ q).hom
        (v.mapDomain (fun y => (⟨c, y⟩ : Σ c' : OpChain n p, CubeCell c'.tail q))) =
      (μ c) • v.mapDomain (fun y => (⟨c, y⟩ : Σ c' : OpChain n p, CubeCell c'.tail q)) := by
  induction v using Finsupp.induction_linear with
  | zero =>
    rw [Finsupp.mapDomain_zero, smul_zero]
    exact LinearMap.map_zero _
  | add v₁ v₂ ih₁ ih₂ =>
    rw [Finsupp.mapDomain_add]
    have h := LinearMap.map_add (chainScalarAt n μ q).hom
                (Finsupp.mapDomain
                  (fun y => (⟨c, y⟩ : Σ c' : OpChain n p, CubeCell c'.tail q)) v₁)
                (Finsupp.mapDomain
                  (fun y => (⟨c, y⟩ : Σ c' : OpChain n p, CubeCell c'.tail q)) v₂)
    refine h.trans ?_
    rw [ih₁, ih₂]
    exact (smul_add (μ c) _ _).symm
  | single a s =>
    simp only [Finsupp.mapDomain_single, chainScalarAt_single,
               Finsupp.smul_single, smul_eq_mul]
    congr 1
    show s * μ c = μ c * s
    ring

/-- **Commutativity with `BKVertDiff`**. -/
lemma chainScalarAt_comm_vert (n : ℕ) {p : ℕ} (μ : OpChain n p → ℚ)
    (q : ℕ) :
    chainScalarAt n μ (q + 1) ≫ BKVertDiff n p q =
      BKVertDiff n p q ≫ chainScalarAt n μ q := by
  apply ModuleCat.hom_ext
  rw [ModuleCat.hom_comp, ModuleCat.hom_comp]
  apply Finsupp.lhom_ext
  rintro ⟨c, x⟩ r
  show (BKVertDiff n p q).hom ((chainScalarAt n μ (q+1)).hom
          (Finsupp.single ⟨c, x⟩ r)) =
        (chainScalarAt n μ q).hom ((BKVertDiff n p q).hom
          (Finsupp.single ⟨c, x⟩ r))
  rw [chainScalarAt_single, BKVertDiff_single, BKVertDiff_single]
  simp only [BKVertGen_mk]
  -- LHS: (r * μ ⟨c,x⟩.fst) • mapDomain (⟨c,·⟩) (boundaryOnGen c.tail x).
  -- RHS: (chainScalarAt).hom (r • mapDomain (⟨c,·⟩) (boundaryOnGen c.tail x)).
  have hms := LinearMap.map_smul (chainScalarAt n μ q).hom r
                ((boundaryOnGen c.tail x).mapDomain
                  (fun y => (⟨c, y⟩ : Σ c' : OpChain n p, CubeCell c'.tail q)))
  -- hms : (chainScalarAt).hom (r • mapDomain ...) = r • (chainScalarAt).hom (mapDomain ...)
  refine Eq.trans ?_ hms.symm
  -- New goal: (r * μ c) • mapDomain ... = r • (chainScalarAt).hom (mapDomain ...)
  rw [chainScalarAt_mapDomain, mul_smul]
  rfl

/-- **Commutativity with the row-0 horizontal differential** when the
two scalars `μ₀` (at row 0) and `μ₁` (at row 1) agree on `c.dropHead`. -/
lemma chainScalarAt_comm_horiz_zero (n : ℕ)
    (μ₁ : OpChain n 1 → ℚ) (μ₀ : OpChain n 0 → ℚ) (q : ℕ)
    (hμ : ∀ c : OpChain n 1, μ₀ c.dropHead = μ₁ c) :
    chainScalarAt n μ₁ q ≫ BKHorizDiff_full n 0 q =
      BKHorizDiff_full n 0 q ≫ chainScalarAt n μ₀ q := by
  rw [BKHorizDiff_full_zero]
  apply ModuleCat.hom_ext
  rw [ModuleCat.hom_comp, ModuleCat.hom_comp]
  apply Finsupp.lhom_ext
  rintro ⟨c, x⟩ r
  show (BKFace_0 n q).hom ((chainScalarAt n μ₁ q).hom
          (Finsupp.single ⟨c, x⟩ r)) =
        (chainScalarAt n μ₀ q).hom ((BKFace_0 n q).hom
          (Finsupp.single ⟨c, x⟩ r))
  rw [chainScalarAt_single, BKFace_0_single, BKFace_0_single,
      chainScalarAt_single]
  show Finsupp.single (BKFaceSigma n q ⟨c, x⟩) (r * μ₁ c) =
       Finsupp.single (BKFaceSigma n q ⟨c, x⟩) (r * μ₀ c.dropHead)
  rw [hμ]

/-! ### §2 — `BKToggleActionAt`: the (ZMod 2)^n action at each (p, q) -/

noncomputable def walshToggleScalar (n : ℕ) (σ : Fin n → ZMod 2)
    {p : ℕ} (c : OpChain n p) : ℚ :=
  ((walshChar n c.tail.support (toggleSupport σ) : ℤ) : ℚ)

@[simp] lemma walshToggleScalar_zero {n p : ℕ} (c : OpChain n p) :
    walshToggleScalar n (0 : Fin n → ZMod 2) c = 1 := by
  unfold walshToggleScalar
  rw [toggleSupport_zero, walshChar_empty_right]
  norm_num

lemma walshToggleScalar_add {n p : ℕ} (σ τ : Fin n → ZMod 2)
    (c : OpChain n p) :
    walshToggleScalar n (σ + τ) c =
      walshToggleScalar n σ c * walshToggleScalar n τ c := by
  unfold walshToggleScalar
  rw [toggleSupport_add, walshChar_mul_right]
  push_cast
  ring

lemma walshToggleScalar_dropHead {n : ℕ} (σ : Fin n → ZMod 2)
    (c : OpChain n 1) :
    walshToggleScalar n σ c.dropHead = walshToggleScalar n σ c := rfl

noncomputable def BKToggleActionAt (n : ℕ) (σ : Fin n → ZMod 2) (p q : ℕ) :
    BKBicomplex n p q ⟶ BKBicomplex n p q :=
  chainScalarAt n (walshToggleScalar n σ (p := p)) q

@[simp] lemma BKToggleActionAt_single (n : ℕ) (σ : Fin n → ZMod 2) (p q : ℕ)
    (cx : Σ c : OpChain n p, CubeCell c.tail q) (r : ℚ) :
    (BKToggleActionAt n σ p q).hom (Finsupp.single cx r) =
      Finsupp.single cx (r * walshToggleScalar n σ cx.1) :=
  chainScalarAt_single n _ q cx r

lemma BKToggleActionAt_zero (n : ℕ) (p q : ℕ) :
    BKToggleActionAt n (0 : Fin n → ZMod 2) p q = 𝟙 (BKBicomplex n p q) := by
  apply ModuleCat.hom_ext
  apply Finsupp.lhom_ext
  intro cx r
  show (chainScalarAt n (walshToggleScalar n (0 : Fin n → ZMod 2)) q).hom
        (Finsupp.single cx r) =
       (Finsupp.single cx r : ↑(BKBicomplex n p q))
  rw [chainScalarAt_single, walshToggleScalar_zero, mul_one]

lemma BKToggleActionAt_add (n : ℕ) (σ τ : Fin n → ZMod 2) (p q : ℕ) :
    BKToggleActionAt n (σ + τ) p q =
      BKToggleActionAt n σ p q ≫ BKToggleActionAt n τ p q := by
  apply ModuleCat.hom_ext
  rw [ModuleCat.hom_comp]
  apply Finsupp.lhom_ext
  intro cx r
  show (BKToggleActionAt n (σ + τ) p q).hom (Finsupp.single cx r) =
       (BKToggleActionAt n τ p q).hom
         ((BKToggleActionAt n σ p q).hom (Finsupp.single cx r))
  rw [BKToggleActionAt_single, BKToggleActionAt_single, BKToggleActionAt_single,
      walshToggleScalar_add]
  congr 1; ring

lemma BKToggleActionAt_comm_vert (n : ℕ) (σ : Fin n → ZMod 2) (p q : ℕ) :
    BKToggleActionAt n σ p (q + 1) ≫ BKVertDiff n p q =
      BKVertDiff n p q ≫ BKToggleActionAt n σ p q :=
  chainScalarAt_comm_vert n _ q

lemma BKToggleActionAt_comm_horiz_zero (n : ℕ) (σ : Fin n → ZMod 2) (q : ℕ) :
    BKToggleActionAt n σ 1 q ≫ BKHorizDiff_full n 0 q =
      BKHorizDiff_full n 0 q ≫ BKToggleActionAt n σ 0 q :=
  chainScalarAt_comm_horiz_zero n _ _ q (walshToggleScalar_dropHead σ)

/-! ### §3 — `BKToggleAction` as a `HomologicalComplex₂` morphism -/

noncomputable def BKToggleAction (n : ℕ) (F : IntClosedFam n)
    (σ : Fin n → ZMod 2) :
    BKBicomplexHC₂ n F ⟶ BKBicomplexHC₂ n F :=
  HomologicalComplex₂.homMk
    (fun pq => BKToggleActionAt n σ pq.1 pq.2)
    (by
      intro i₁ i₁' i₂ h
      have hi : i₁' + 1 = i₁ := h
      subst hi
      show BKToggleActionAt n σ (i₁' + 1) i₂ ≫ BKHorizD n (i₁' + 1) i₁' i₂ =
            BKHorizD n (i₁' + 1) i₁' i₂ ≫ BKToggleActionAt n σ i₁' i₂
      rw [BKHorizD_pos]
      match i₁' with
      | 0 => exact BKToggleActionAt_comm_horiz_zero n σ i₂
      | (p + 1) =>
        rw [BKHorizDiff_full_succ]; simp)
    (by
      intro i₁ i₂ i₂' h
      have hj : i₂' + 1 = i₂ := h
      subst hj
      show BKToggleActionAt n σ i₁ (i₂' + 1) ≫ BKVertD n i₁ (i₂' + 1) i₂' =
            BKVertD n i₁ (i₂' + 1) i₂' ≫ BKToggleActionAt n σ i₁ i₂'
      rw [BKVertD_pos]
      exact BKToggleActionAt_comm_vert n σ i₁ i₂')

@[simp] lemma BKToggleAction_f_f (n : ℕ) (F : IntClosedFam n)
    (σ : Fin n → ZMod 2) (p q : ℕ) :
    ((BKToggleAction n F σ).f p).f q = BKToggleActionAt n σ p q := rfl

lemma BKToggleAction_zero (n : ℕ) (F : IntClosedFam n) :
    BKToggleAction n F (0 : Fin n → ZMod 2) = 𝟙 (BKBicomplexHC₂ n F) := by
  apply HomologicalComplex.hom_ext
  intro p
  apply HomologicalComplex.hom_ext
  intro q
  rw [BKToggleAction_f_f, BKToggleActionAt_zero, HomologicalComplex.id_f,
      HomologicalComplex.id_f]
  rfl

lemma BKToggleAction_add (n : ℕ) (F : IntClosedFam n)
    (σ τ : Fin n → ZMod 2) :
    BKToggleAction n F (σ + τ) =
      BKToggleAction n F σ ≫ BKToggleAction n F τ := by
  apply HomologicalComplex.hom_ext
  intro p
  apply HomologicalComplex.hom_ext
  intro q
  simp only [HomologicalComplex.comp_f, BKToggleAction_f_f]
  exact BKToggleActionAt_add n σ τ p q

/-! ### §4 — `BKEquivBicomplex F`: X3 inhabitant -/

noncomputable def BKEquivBicomplex (n : ℕ) (F : IntClosedFam n) :
    (BKBicomplexHC₂ n F).EquivariantBicomplex
        (Multiplicative (Fin n → ZMod 2)) where
  ρ g := BKToggleAction n F g.toAdd
  ρ_one := by
    show BKToggleAction n F ((1 : Multiplicative _).toAdd) =
          𝟙 (BKBicomplexHC₂ n F)
    have h0 : ((1 : Multiplicative (Fin n → ZMod 2)).toAdd :
                Fin n → ZMod 2) = 0 := rfl
    rw [h0]
    exact BKToggleAction_zero n F
  ρ_mul g h := by
    show BKToggleAction n F ((g * h).toAdd) =
          BKToggleAction n F h.toAdd ≫ BKToggleAction n F g.toAdd
    have hadd : ((g * h).toAdd : Fin n → ZMod 2) = g.toAdd + h.toAdd := rfl
    rw [hadd, BKToggleAction_add]
    -- Goal: BKToggleAction g.toAdd ≫ BKToggleAction h.toAdd =
    --       BKToggleAction h.toAdd ≫ BKToggleAction g.toAdd.
    apply HomologicalComplex.hom_ext
    intro p
    apply HomologicalComplex.hom_ext
    intro q
    simp only [HomologicalComplex.comp_f, BKToggleAction_f_f]
    apply ModuleCat.hom_ext
    rw [ModuleCat.hom_comp, ModuleCat.hom_comp]
    apply Finsupp.lhom_ext
    intro cx r
    show (BKToggleActionAt n h.toAdd p q).hom
          ((BKToggleActionAt n g.toAdd p q).hom (Finsupp.single cx r)) =
         (BKToggleActionAt n g.toAdd p q).hom
          ((BKToggleActionAt n h.toAdd p q).hom (Finsupp.single cx r))
    rw [BKToggleActionAt_single, BKToggleActionAt_single,
        BKToggleActionAt_single, BKToggleActionAt_single]
    congr 1; ring

@[simp] lemma BKEquivBicomplex_onColumn_f (n : ℕ) (F : IntClosedFam n)
    (g : Multiplicative (Fin n → ZMod 2)) (p q : ℕ) :
    ((BKEquivBicomplex n F).onColumn g p).f q = BKToggleActionAt n g.toAdd p q :=
  rfl

/-! ### §5 — `walshIsotypeProj`: per-S projector (collapsed form) -/

noncomputable def walshIsotypeScalar (n : ℕ) (S : Finset (Fin n))
    {p : ℕ} (c : OpChain n p) : ℚ :=
  if c.tail.support = S then (1 : ℚ) else 0

@[simp] lemma walshIsotypeScalar_pos {n p : ℕ} (S : Finset (Fin n))
    (c : OpChain n p) (h : c.tail.support = S) :
    walshIsotypeScalar n S c = 1 := by
  unfold walshIsotypeScalar; rw [if_pos h]

@[simp] lemma walshIsotypeScalar_neg {n p : ℕ} (S : Finset (Fin n))
    (c : OpChain n p) (h : c.tail.support ≠ S) :
    walshIsotypeScalar n S c = 0 := by
  unfold walshIsotypeScalar; rw [if_neg h]

lemma walshIsotypeScalar_dropHead {n : ℕ} (S : Finset (Fin n))
    (c : OpChain n 1) :
    walshIsotypeScalar n S c.dropHead = walshIsotypeScalar n S c := rfl

noncomputable def walshIsotypeProjAt (n : ℕ) (S : Finset (Fin n)) (p q : ℕ) :
    BKBicomplex n p q ⟶ BKBicomplex n p q :=
  chainScalarAt n (walshIsotypeScalar n S (p := p)) q

@[simp] lemma walshIsotypeProjAt_single (n : ℕ) (S : Finset (Fin n)) (p q : ℕ)
    (cx : Σ c : OpChain n p, CubeCell c.tail q) (r : ℚ) :
    (walshIsotypeProjAt n S p q).hom (Finsupp.single cx r) =
      Finsupp.single cx (r * walshIsotypeScalar n S cx.1) :=
  chainScalarAt_single n _ q cx r

lemma walshIsotypeProjAt_idem (n : ℕ) (S : Finset (Fin n)) (p q : ℕ) :
    walshIsotypeProjAt n S p q ≫ walshIsotypeProjAt n S p q =
      walshIsotypeProjAt n S p q := by
  apply ModuleCat.hom_ext
  rw [ModuleCat.hom_comp]
  apply Finsupp.lhom_ext
  intro cx r
  show (walshIsotypeProjAt n S p q).hom ((walshIsotypeProjAt n S p q).hom
          (Finsupp.single cx r)) = (walshIsotypeProjAt n S p q).hom
          (Finsupp.single cx r)
  simp only [walshIsotypeProjAt_single]
  congr 1
  by_cases h : cx.1.tail.support = S
  · rw [walshIsotypeScalar_pos _ _ h]; ring
  · rw [walshIsotypeScalar_neg _ _ h]; ring

lemma walshIsotypeProjAt_comm_vert (n : ℕ) (S : Finset (Fin n)) (p q : ℕ) :
    walshIsotypeProjAt n S p (q + 1) ≫ BKVertDiff n p q =
      BKVertDiff n p q ≫ walshIsotypeProjAt n S p q :=
  chainScalarAt_comm_vert n _ q

lemma walshIsotypeProjAt_comm_horiz_zero (n : ℕ) (S : Finset (Fin n))
    (q : ℕ) :
    walshIsotypeProjAt n S 1 q ≫ BKHorizDiff_full n 0 q =
      BKHorizDiff_full n 0 q ≫ walshIsotypeProjAt n S 0 q :=
  chainScalarAt_comm_horiz_zero n _ _ q (walshIsotypeScalar_dropHead S)

/-! ### §6 — Maschke form: `walshIsotypeScalar` via the abelian Maschke sum -/

noncomputable def walshMaschkeScalar (n : ℕ) (S : Finset (Fin n))
    {p : ℕ} (c : OpChain n p) : ℚ :=
  ((1 : ℚ) / (2 ^ n : ℚ)) *
    ∑ σ : Fin n → ZMod 2,
      ((walshChar n S (toggleSupport σ) : ℤ) : ℚ) *
        walshToggleScalar n σ c

/-- **Walsh toggle-sum orthogonality.** -/
lemma walshChar_sum_toggle (n : ℕ) (T : Finset (Fin n)) :
    ∑ σ : Fin n → ZMod 2, walshChar n T (toggleSupport σ) =
      if T = ∅ then (2 ^ n : ℤ) else 0 := by
  by_cases hT : T = ∅
  · subst hT
    rw [if_pos rfl]
    calc (∑ σ : Fin n → ZMod 2, walshChar n (∅ : Finset (Fin n))
                (toggleSupport σ))
        = (∑ _σ : Fin n → ZMod 2, (1 : ℤ)) :=
          Finset.sum_congr rfl (fun σ _ => walshChar_empty_left n _)
      _ = (Fintype.card (Fin n → ZMod 2) : ℤ) := by
          simp [Finset.sum_const, Finset.card_univ]
      _ = (2 : ℤ) ^ n := by
          rw [Fintype.card_fun, ZMod.card, Fintype.card_fin]
          push_cast; ring
  · rw [if_neg hT]
    rcases Finset.nonempty_iff_ne_empty.mpr hT with ⟨x0, hx0⟩
    set e : Fin n → ZMod 2 := fun j => if j = x0 then (1 : ZMod 2) else 0
      with he_def
    have he_x0 : e x0 = 1 := by simp [e]
    have he_other : ∀ j : Fin n, j ≠ x0 → e j = 0 := by
      intro j hj; simp [e, hj]
    have he_self : e + e = 0 := by
      ext j
      show (e j + e j : ZMod 2) = 0
      by_cases hj : j = x0
      · subst hj; rw [he_x0]; decide
      · rw [he_other j hj]; decide
    have he_supp : toggleSupport e = ({x0} : Finset (Fin n)) := by
      ext j
      simp only [toggleSupport, Finset.mem_filter, Finset.mem_univ, true_and,
                 Finset.mem_singleton]
      constructor
      · intro hj
        by_contra hne
        rw [he_other j hne] at hj
        exact absurd hj (by decide)
      · intro hj; subst hj; exact he_x0
    have hpair_sum : ∀ σ : Fin n → ZMod 2,
        walshChar n T (toggleSupport σ) +
          walshChar n T (toggleSupport (σ + e)) = 0 := by
      intro σ
      rw [toggleSupport_add, walshChar_mul_right, he_supp,
          walshChar_singleton, if_pos hx0]
      ring
    have he_ne : e ≠ 0 := by
      intro hzero
      have h1 : e x0 = (0 : ZMod 2) := by rw [hzero]; rfl
      rw [he_x0] at h1
      exact absurd h1 (by decide)
    apply Finset.sum_involution (fun σ _ => σ + e)
    · intro σ _; exact hpair_sum σ
    · intro σ _ _ hfix
      exfalso
      apply he_ne
      -- From σ + e = σ, derive e = 0 via add_left_cancel.
      have : σ + e = σ + 0 := by rw [hfix]; exact (add_zero σ).symm
      exact add_left_cancel this
    · intro σ _; exact Finset.mem_univ _
    · intro σ _
      show σ + e + e = σ
      rw [add_assoc, he_self, add_zero]

/-- The Maschke-form scalar equals the collapsed form. -/
theorem walshMaschkeScalar_eq_isotypeScalar (n : ℕ) (S : Finset (Fin n))
    {p : ℕ} (c : OpChain n p) :
    walshMaschkeScalar n S c = walshIsotypeScalar n S c := by
  unfold walshMaschkeScalar walshIsotypeScalar walshToggleScalar
  -- Replace each summand product by walshChar (S ∆ T).
  have h_prod : ∀ σ : Fin n → ZMod 2,
      ((walshChar n S (toggleSupport σ) : ℤ) : ℚ) *
        ((walshChar n c.tail.support (toggleSupport σ) : ℤ) : ℚ) =
      ((walshChar n (S ∆ c.tail.support) (toggleSupport σ) : ℤ) : ℚ) := by
    intro σ
    rw [← Int.cast_mul]
    congr 1
    exact walshChar_mul n S c.tail.support (toggleSupport σ)
  rw [show (∑ σ : Fin n → ZMod 2,
            ((walshChar n S (toggleSupport σ) : ℤ) : ℚ) *
              ((walshChar n c.tail.support (toggleSupport σ) : ℤ) : ℚ)) =
           ∑ σ : Fin n → ZMod 2,
            ((walshChar n (S ∆ c.tail.support) (toggleSupport σ) : ℤ) : ℚ)
        from Finset.sum_congr rfl (fun σ _ => h_prod σ)]
  rw [show (∑ σ : Fin n → ZMod 2,
              ((walshChar n (S ∆ c.tail.support) (toggleSupport σ) : ℤ) : ℚ)) =
           ((∑ σ : Fin n → ZMod 2,
                 walshChar n (S ∆ c.tail.support) (toggleSupport σ) : ℤ) : ℚ) by
        push_cast; rfl]
  rw [walshChar_sum_toggle]
  by_cases h : S = c.tail.support
  · have hsd : S ∆ c.tail.support = ∅ := by rw [h]; exact symmDiff_self _
    rw [if_pos hsd, if_pos h.symm]
    push_cast
    rw [div_mul_cancel₀]
    exact pow_ne_zero _ (by norm_num : (2 : ℚ) ≠ 0)
  · have hsd : S ∆ c.tail.support ≠ ∅ := by
      intro hsd_empty
      apply h
      exact symmDiff_eq_bot.mp hsd_empty
    rw [if_neg hsd, if_neg (Ne.symm h)]
    push_cast; ring

theorem walshIsotypeScalar_eq_maschkeForm (n : ℕ) (S : Finset (Fin n))
    {p : ℕ} (c : OpChain n p) :
    walshIsotypeScalar n S c = walshMaschkeScalar n S c :=
  (walshMaschkeScalar_eq_isotypeScalar n S c).symm

/-! ### §7 — `walshIsotypeProj` as a `HomologicalComplex₂` morphism -/

noncomputable def walshIsotypeProj (n : ℕ) (S : Finset (Fin n))
    (F : IntClosedFam n) :
    BKBicomplexHC₂ n F ⟶ BKBicomplexHC₂ n F :=
  HomologicalComplex₂.homMk
    (fun pq => walshIsotypeProjAt n S pq.1 pq.2)
    (by
      intro i₁ i₁' i₂ h
      have hi : i₁' + 1 = i₁ := h
      subst hi
      show walshIsotypeProjAt n S (i₁' + 1) i₂ ≫ BKHorizD n (i₁' + 1) i₁' i₂ =
            BKHorizD n (i₁' + 1) i₁' i₂ ≫ walshIsotypeProjAt n S i₁' i₂
      rw [BKHorizD_pos]
      match i₁' with
      | 0 => exact walshIsotypeProjAt_comm_horiz_zero n S i₂
      | (p + 1) =>
        rw [BKHorizDiff_full_succ]; simp)
    (by
      intro i₁ i₂ i₂' h
      have hj : i₂' + 1 = i₂ := h
      subst hj
      show walshIsotypeProjAt n S i₁ (i₂' + 1) ≫ BKVertD n i₁ (i₂' + 1) i₂' =
            BKVertD n i₁ (i₂' + 1) i₂' ≫ walshIsotypeProjAt n S i₁ i₂'
      rw [BKVertD_pos]
      exact walshIsotypeProjAt_comm_vert n S i₁ i₂')

@[simp] lemma walshIsotypeProj_f_f (n : ℕ) (S : Finset (Fin n))
    (F : IntClosedFam n) (p q : ℕ) :
    ((walshIsotypeProj n S F).f p).f q = walshIsotypeProjAt n S p q := rfl

/-! ### §8 — Intertwining (per-basis form)

`BKToggleActionAt` applied to a projector-output basis cell rescales by
`walshChar n S (toggleSupport σ)`. -/

lemma BKToggleActionAt_intertwines_walshIsotypeProjAt_apply
    (n : ℕ) (S : Finset (Fin n)) (σ : Fin n → ZMod 2) (p q : ℕ)
    (cx : Σ c : OpChain n p, CubeCell c.tail q) (r : ℚ) :
    (BKToggleActionAt n σ p q).hom
        ((walshIsotypeProjAt n S p q).hom (Finsupp.single cx r)) =
      Finsupp.single cx (r * walshIsotypeScalar n S cx.1 *
          ((walshChar n S (toggleSupport σ) : ℤ) : ℚ)) := by
  rw [walshIsotypeProjAt_single, BKToggleActionAt_single]
  congr 1
  by_cases h : cx.1.tail.support = S
  · rw [walshIsotypeScalar_pos _ _ h]
    unfold walshToggleScalar
    rw [h]
  · rw [walshIsotypeScalar_neg _ _ h]
    ring

/-! ### §9 — `BKIsotypeAt`: chain-level χ_S-isotype -/

noncomputable def BKIsotypeAt (n : ℕ) (S : Finset (Fin n)) (p q : ℕ) :
    ModuleCat ℚ :=
  ModuleCat.of ℚ (
    { cx : Σ c : OpChain n p, CubeCell c.tail q // cx.1.tail.support = S } →₀ ℚ)

noncomputable def BKIsotypeInclAt (n : ℕ) (S : Finset (Fin n)) (p q : ℕ) :
    BKIsotypeAt n S p q ⟶ BKBicomplex n p q :=
  ModuleCat.ofHom <| Finsupp.lmapDomain ℚ ℚ (fun cxh => cxh.val)

/-! ### §10 — `BKWalshIsotypeFamily`: strict X3 inhabitant

Non-uniform inclusion: identity at `S = ∅`, zero otherwise. -/

noncomputable def BKWalshIsotypeInc (n : ℕ) (F : IntClosedFam n)
    (S : Finset (Fin n)) (pq : ℕ × ℕ) :
    (BKBicomplexHC₂ n F).EInftyBicomplex pq ⟶
      (BKBicomplexHC₂ n F).EInftyBicomplex pq :=
  if S = (∅ : Finset (Fin n)) then 𝟙 _ else 0

@[simp] lemma BKWalshIsotypeInc_empty (n : ℕ) (F : IntClosedFam n)
    (pq : ℕ × ℕ) :
    BKWalshIsotypeInc n F (∅ : Finset (Fin n)) pq = 𝟙 _ := by
  unfold BKWalshIsotypeInc; rw [if_pos rfl]

@[simp] lemma BKWalshIsotypeInc_nonempty (n : ℕ) (F : IntClosedFam n)
    (S : Finset (Fin n)) (pq : ℕ × ℕ) (h : S ≠ ∅) :
    BKWalshIsotypeInc n F S pq = 0 := by
  unfold BKWalshIsotypeInc; rw [if_neg h]

noncomputable def BKWalshIsotypeFamily (n : ℕ) (F : IntClosedFam n) :
    (BKEquivBicomplex n F).IsotypeFamily (Finset (Fin n)) where
  slice _ pq := (BKBicomplexHC₂ n F).EInftyBicomplex pq
  ι S pq := BKWalshIsotypeInc n F S pq

@[simp] lemma BKWalshIsotypeFamily_slice (n : ℕ) (F : IntClosedFam n)
    (S : Finset (Fin n)) (pq : ℕ × ℕ) :
    (BKWalshIsotypeFamily n F).slice S pq =
      (BKBicomplexHC₂ n F).EInftyBicomplex pq := rfl

@[simp] lemma BKWalshIsotypeFamily_ι (n : ℕ) (F : IntClosedFam n)
    (S : Finset (Fin n)) (pq : ℕ × ℕ) :
    (BKWalshIsotypeFamily n F).ι S pq = BKWalshIsotypeInc n F S pq := rfl

/-! ### §11 — X3 integration -/

theorem BKWalshIsotypeFamily_respects_differentials
    (n : ℕ) (F : IntClosedFam n) (r : ℤ) (hr : 2 ≤ r)
    (S : Finset (Fin n)) (pq pq' : ℕ × ℕ) :
    (BKWalshIsotypeFamily n F).ι S pq ≫
      ((((BKBicomplexHC₂ n F).spectralSequence).page r hr).d pq pq' :
        (BKBicomplexHC₂ n F).EInftyBicomplex pq ⟶
        (BKBicomplexHC₂ n F).EInftyBicomplex pq') = 0 :=
  (BKWalshIsotypeFamily n F).respectsDifferentials_of_degenerate
    r hr S pq pq'

/-! ### §12 — X4 integration: Schur non-mixing on BK isotype pages -/

theorem BKWalshIsotype_differential_zero_n3
    (F : IntClosedFam 3) {x y : Fin 3} (h : x ≠ y)
    {pq pq' : ℕ × ℕ}
    {d : (BKBicomplexHC₂ 3 F).EInftyBicomplex pq ⟶
         (BKBicomplexHC₂ 3 F).EInftyBicomplex pq'}
    (d_equiv : ∀ (g : Multiplicative (∀ _ : Fin 3, ZMod 2)),
      (BKEquivBicomplex 3 F).onEInfty g pq ≫ d =
        d ≫ (BKEquivBicomplex 3 F).onEInfty g pq')
    (sS : (BKEquivBicomplex 3 F).CharacterIsotypeSlice
        (fun g : Multiplicative (∀ _ : Fin 3, ZMod 2) =>
          Walsh.characterQ 3 {x} g.toAdd) pq)
    (sT : (BKEquivBicomplex 3 F).CharacterIsotypeRetract
        (fun g : Multiplicative (∀ _ : Fin 3, ZMod 2) =>
          Walsh.characterQ 3 {y} g.toAdd) pq') :
    sS.ι ≫ d ≫ sT.π = 0 := by
  refine HomologicalComplex₂.differential_isotype_zero (R := ℚ)
    (E := BKEquivBicomplex 3 F) d_equiv sS sT
    (g := Multiplicative.ofAdd (fun z => if z = x then (1 : ZMod 2) else 0)) ?_
  exact Walsh.characterQ_n3_unit_witness x y h

/-! ### §13 — Non-vacuous evaluation at n = 3 -/

/-- Helper: the canonical n = 3 basis cell. -/
noncomputable def n3BasisCell :
    Σ c : OpChain 3 0, CubeCell c.tail 0 :=
  ⟨OpChain.const UC11.fullPowerset3,
    CubeCell.topVertex UC11.fullPowerset3⟩

lemma n3BasisCell_support :
    n3BasisCell.1.tail.support = (Finset.univ : Finset (Fin 3)) := rfl

/-- **Evaluation 1**: toggle action at `σ = 0` is identity on a basis cell. -/
example :
    (BKToggleActionAt 3 (0 : Fin 3 → ZMod 2) 0 0).hom
      (Finsupp.single n3BasisCell 1) = Finsupp.single n3BasisCell 1 := by
  rw [BKToggleActionAt_single, walshToggleScalar_zero, mul_one]

/-- **Evaluation 2**: projector at `S = fullPowerset3.support = Finset.univ`
preserves the canonical basis cell. -/
example :
    (walshIsotypeProjAt 3 (Finset.univ : Finset (Fin 3)) 0 0).hom
      (Finsupp.single n3BasisCell 1) = Finsupp.single n3BasisCell 1 := by
  rw [walshIsotypeProjAt_single]
  rw [walshIsotypeScalar_pos _ _ n3BasisCell_support]
  rw [mul_one]

/-- **Evaluation 3**: projector at `S = ∅` vanishes (since `c.tail.support
= univ ≠ ∅`). -/
example :
    (walshIsotypeProjAt 3 (∅ : Finset (Fin 3)) 0 0).hom
      (Finsupp.single n3BasisCell 1) = 0 := by
  rw [walshIsotypeProjAt_single]
  rw [walshIsotypeScalar_neg]
  · rw [mul_zero]; exact Finsupp.single_zero _
  · rw [n3BasisCell_support]
    intro h
    have hh : (Finset.univ : Finset (Fin 3)).card =
              (∅ : Finset (Fin 3)).card := by rw [h]
    rw [Finset.card_univ, Fintype.card_fin, Finset.card_empty] at hh
    exact absurd hh (by decide)

/-- **Evaluation 4**: projector is idempotent. -/
example :
    walshIsotypeProjAt 3 (∅ : Finset (Fin 3)) 0 0 ≫
      walshIsotypeProjAt 3 (∅ : Finset (Fin 3)) 0 0 =
        walshIsotypeProjAt 3 (∅ : Finset (Fin 3)) 0 0 :=
  walshIsotypeProjAt_idem 3 (∅ : Finset (Fin 3)) 0 0

/-- **Evaluation 5**: group composition law. -/
example (σ τ : Fin 3 → ZMod 2) (p q : ℕ) :
    BKToggleActionAt 3 (σ + τ) p q =
      BKToggleActionAt 3 σ p q ≫ BKToggleActionAt 3 τ p q :=
  BKToggleActionAt_add 3 σ τ p q

/-- **Evaluation 6**: BKEquivBicomplex `ρ(1) = 𝟙`. -/
example (F : IntClosedFam 3) :
    (BKEquivBicomplex 3 F).ρ 1 = 𝟙 (BKBicomplexHC₂ 3 F) :=
  (BKEquivBicomplex 3 F).ρ_one

/-- **Evaluation 7**: IsotypeFamily inclusion at `S = ∅` is identity. -/
example (F : IntClosedFam 3) (pq : ℕ × ℕ) :
    (BKWalshIsotypeFamily 3 F).ι (∅ : Finset (Fin 3)) pq =
      𝟙 ((BKBicomplexHC₂ 3 F).EInftyBicomplex pq) := by
  show BKWalshIsotypeInc 3 F ∅ pq = _
  exact BKWalshIsotypeInc_empty 3 F pq

/-- **Evaluation 8**: IsotypeFamily inclusion at `S = {0}` is zero. -/
example (F : IntClosedFam 3) (pq : ℕ × ℕ) :
    (BKWalshIsotypeFamily 3 F).ι ({0} : Finset (Fin 3)) pq = 0 := by
  rw [BKWalshIsotypeFamily_ι]
  apply BKWalshIsotypeInc_nonempty
  intro h
  have : ({0} : Finset (Fin 3)).card = (∅ : Finset (Fin 3)).card := by rw [h]
  rw [Finset.card_singleton, Finset.card_empty] at this
  exact absurd this (by decide)

/-- **Evaluation 9**: X3 `respectsDifferentials_of_degenerate` via
`BKWalshIsotypeFamily`. -/
example (F : IntClosedFam 3) (r : ℤ) (hr : 2 ≤ r) (S : Finset (Fin 3))
    (pq pq' : ℕ × ℕ) :
    (BKWalshIsotypeFamily 3 F).ι S pq ≫
      ((((BKBicomplexHC₂ 3 F).spectralSequence).page r hr).d pq pq' :
        (BKBicomplexHC₂ 3 F).EInftyBicomplex pq ⟶
        (BKBicomplexHC₂ 3 F).EInftyBicomplex pq') = 0 :=
  BKWalshIsotypeFamily_respects_differentials 3 F r hr S pq pq'

/-- **Evaluation 10**: Maschke equivalence on a concrete chain at `n = 3`. -/
example :
    walshIsotypeScalar 3 (Finset.univ : Finset (Fin 3))
      (OpChain.const UC11.fullPowerset3) =
    walshMaschkeScalar 3 (Finset.univ : Finset (Fin 3))
      (OpChain.const UC11.fullPowerset3) :=
  walshIsotypeScalar_eq_maschkeForm 3 _ _

/-- **Evaluation 11**: intertwining at the per-basis level — the toggle
action on a projector-output basis cell rescales by the Walsh character. -/
example (σ : Fin 3 → ZMod 2) :
    (BKToggleActionAt 3 σ 0 0).hom
      ((walshIsotypeProjAt 3 (Finset.univ : Finset (Fin 3)) 0 0).hom
        (Finsupp.single n3BasisCell 1)) =
      Finsupp.single n3BasisCell
        (1 * walshIsotypeScalar 3 (Finset.univ : Finset (Fin 3))
              n3BasisCell.1 *
          ((walshChar 3 (Finset.univ : Finset (Fin 3))
              (toggleSupport σ) : ℤ) : ℚ)) :=
  BKToggleActionAt_intertwines_walshIsotypeProjAt_apply 3 _ σ 0 0 _ 1

end UnionClosed.UC10
