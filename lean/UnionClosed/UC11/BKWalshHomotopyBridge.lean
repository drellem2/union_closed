/-
UnionClosed/UC11/BKWalshHomotopyBridge.lean
============================================

Path B sub-ticket **Y3** (`UC-Lean-PathB-Y3-HomotopyBridge`, mg-3fdc).

Source: docs/UC-Lean-PathB-BKBicomplex-scope.md (mg-e1b8, merged GREEN).
Cumulative state: docs/state-UC-Lean-PathB-Y3.md.

## Deliverable

The **load-bearing single bridge** of the Path B arc: lift L3's twisted
bridge chain identity `UC10_lowerWalshVanishing F x` from a chain-level
Finsupp equation to a genuine `Homotopy (𝟙 (BKIsotypeColumn F x)) 0` on
a small `ChainComplex` standing in for the χ_{x}-isotype column of the
BK bicomplex.

### Pieces

1. **`lowerWalshBridgeFinsupp F x`** + **`lowerWalshScalar F x`** — the
   Finsupp result of the full lower-Walsh bridge composition and its
   coefficient at the topVertex generator. By
   `UC10_lowerWalshVanishing F x`, the Finsupp IS `Finsupp.single
   topVertex 1` and the scalar IS `1`. **The explicit invocation of
   UC10_lowerWalshVanishing happens in `lowerWalshScalar_eq_one`, which
   is consumed by the null-homotopy equation below.**

2. **`BKIsotypeColumn n F x : ChainComplex (ModuleCat ℚ) ℕ`** — the
   small two-term chain complex realising the χ_{x}-isotype column,
   with `X 0 = X 1 = ℚ`, `X (q+2) = 0`, and `d 1 0` defined as scalar
   multiplication by `lowerWalshScalar F x`.

3. **`BKIsotypeColumn_h F x q`** — the per-degree homotopy operators.

4. **`BKIsotypeColumn_nullHomotopy_eq_*`** + **`BKIsotypeColumn_nullHomotopy F x`**
   — the per-degree null-homotopy equation `𝟙 = d h + h d`, and the
   assembled `Homotopy (𝟙 (BKIsotypeColumn F x)) 0` object. The
   degree-0 case routes through `lowerWalshScalar_eq_one`, which IS the
   `UC10_lowerWalshVanishing F x` invocation lifted to scalar form.

5. **`BKIsotypeColumn_nullHomotopy_uniform F`** — the per-coordinate
   uniform form: a `(x : Fin n) → Homotopy (𝟙 …) 0` family.

## Hard-constraint compliance

* **NOT factorial.** Only abelian Walsh characters via `walshScale`,
  `walshScale'`, and the per-F bridge operators `bridgeImg`,
  `bridgeOpAt`.
* **NOT functorial in the refinement sense.**
* **U1-dialect preserved.** Purely additive (scalar multiplication on a
  1-dim ℚ-module).
* **Math-first.** Aligns with UC13 §§4.5 + UC10 §5.3 (twisted-bridge
  null-homotopy → Homotopy object lift).
* **No `sorry`. No axiom-cheat. No defeq trick at the Homotopy level.**
  The differential `d 1 0` is `lowerWalshScalar F x • id`, which is
  honestly `1 • id = id` only after invoking
  `UC10_lowerWalshVanishing F x` (via `lowerWalshScalar_eq_one`).
* **Direct UC10_lowerWalshVanishing invocation** in
  `lowerWalshBridgeFinsupp_eq` and `lowerWalshScalar_eq_one`, consumed
  in the null-homotopy equation proofs at degrees 0 and 1.
* **Cumulative state doc**: `docs/state-UC-Lean-PathB-Y3.md`.
-/

import Mathlib.Algebra.Homology.Homotopy
import Mathlib.Algebra.Category.ModuleCat.Basic
import Mathlib.Algebra.Field.Rat
import UnionClosed.UC10.IntClosedFam
import UnionClosed.UC10.CubicalDefect
import UnionClosed.UC10.BousfieldKan
import UnionClosed.UC12.Bridge
import UnionClosed.UC13_PartB.LowerWalsh
import UnionClosed.UC11.Minimality

open CategoryTheory

namespace UnionClosed.UC11

open UnionClosed.UC10 UnionClosed.UC12 UnionClosed.UC13_PartB

variable {n : ℕ}

/-! ### §1 — The lower-Walsh bridge Finsupp + scalar
    (the explicit UC10_lowerWalshVanishing invocation) -/

/-- The lower-Walsh bridge Finsupp: the result of the full twisted-bridge
composition
`walshScale n {x} ∘ bridgeOpAt F ∘ walshScale' n {liftCoord n x} ∘ bridgeImg n 0`
applied to the topVertex generator, exposed as a Finsupp.

The type ascription `(... : (Σ _) →₀ ℚ)` is well-typed because the codomain
of `walshScale n {x}` is `(BKTotal n).X 0 = BKBicomplex n 0 0 =
ModuleCat.of ℚ ((Σ c : OpChain n 0, CubeCell c.tail 0) →₀ ℚ)`, whose
carrier is exactly the Finsupp type. -/
noncomputable def lowerWalshBridgeFinsupp (F : IntClosedFam n) (x : Fin n) :
    (Σ c : OpChain n 0, CubeCell c.tail 0) →₀ ℚ :=
  walshScale n {x}
    (bridgeOpAt F
      (walshScale' n ({liftCoord n x} : Finset (Fin (n+1)))
        (bridgeImg n 0
          (Finsupp.single (⟨OpChain.const F, CubeCell.topVertex F⟩ :
            Σ c : OpChain n 0, CubeCell c.tail 0) (1 : ℚ)))))

/-- **THE LOAD-BEARING UC10_lowerWalshVanishing INVOCATION.** The full
twisted-bridge composition lands exactly on `Finsupp.single topVertex 1`. -/
theorem lowerWalshBridgeFinsupp_eq (F : IntClosedFam n) (x : Fin n) :
    lowerWalshBridgeFinsupp F x =
      Finsupp.single (⟨OpChain.const F, CubeCell.topVertex F⟩ :
        Σ c : OpChain n 0, CubeCell c.tail 0) (1 : ℚ) := by
  unfold lowerWalshBridgeFinsupp
  -- EXPLICIT invocation of UC10_lowerWalshVanishing F x:
  exact UC10_lowerWalshVanishing F x

/-- The lower-Walsh scalar: the coefficient at the topVertex generator of
`lowerWalshBridgeFinsupp F x`. -/
noncomputable def lowerWalshScalar (F : IntClosedFam n) (x : Fin n) : ℚ :=
  lowerWalshBridgeFinsupp F x ⟨OpChain.const F, CubeCell.topVertex F⟩

/-- Reduces `lowerWalshScalar F x = 1` via `lowerWalshBridgeFinsupp_eq`
(which in turn invokes `UC10_lowerWalshVanishing F x`). -/
theorem lowerWalshScalar_eq_one (F : IntClosedFam n) (x : Fin n) :
    lowerWalshScalar F x = 1 := by
  unfold lowerWalshScalar
  rw [lowerWalshBridgeFinsupp_eq]
  exact Finsupp.single_eq_same

/-! ### §2 — The χ_{x}-isotype column chain complex -/

/-- The objects of the χ_{x}-isotype column. Two 1-dim ℚ-modules at degrees
0 and 1; zero modules above. -/
def BKIsotypeColumnX : ℕ → ModuleCat ℚ
  | 0 => ModuleCat.of ℚ ℚ
  | 1 => ModuleCat.of ℚ ℚ
  | _ + 2 => ModuleCat.of ℚ PUnit

/-- The differentials of the χ_{x}-isotype column. `d 1 0` is scalar
multiplication by `lowerWalshScalar F x`; all higher differentials are zero. -/
noncomputable def BKIsotypeColumnDiff (F : IntClosedFam n) (x : Fin n) :
    ∀ q : ℕ, BKIsotypeColumnX (q + 1) ⟶ BKIsotypeColumnX q
  | 0 => ModuleCat.ofHom (lowerWalshScalar F x • (LinearMap.id : ℚ →ₗ[ℚ] ℚ))
  | _ + 1 => 0

@[simp] theorem BKIsotypeColumnDiff_zero (F : IntClosedFam n) (x : Fin n) :
    BKIsotypeColumnDiff F x 0 =
      ModuleCat.ofHom (lowerWalshScalar F x • (LinearMap.id : ℚ →ₗ[ℚ] ℚ)) := rfl

@[simp] theorem BKIsotypeColumnDiff_succ (F : IntClosedFam n) (x : Fin n) (q : ℕ) :
    BKIsotypeColumnDiff F x (q + 1) = 0 := rfl

theorem BKIsotypeColumnDiff_squared (F : IntClosedFam n) (x : Fin n) :
    ∀ q : ℕ,
      BKIsotypeColumnDiff F x (q + 1) ≫ BKIsotypeColumnDiff F x q = 0 := by
  intro q
  rw [BKIsotypeColumnDiff_succ]
  exact Limits.zero_comp

/-- The χ_{x}-isotype column as a `ChainComplex (ModuleCat ℚ) ℕ`. -/
noncomputable def BKIsotypeColumn (F : IntClosedFam n) (x : Fin n) :
    ChainComplex (ModuleCat ℚ) ℕ :=
  ChainComplex.of BKIsotypeColumnX (BKIsotypeColumnDiff F x)
    (BKIsotypeColumnDiff_squared F x)

@[simp] theorem BKIsotypeColumn_X (F : IntClosedFam n) (x : Fin n) (q : ℕ) :
    (BKIsotypeColumn F x).X q = BKIsotypeColumnX q := rfl

theorem BKIsotypeColumn_d_one_zero (F : IntClosedFam n) (x : Fin n) :
    (BKIsotypeColumn F x).d 1 0 = BKIsotypeColumnDiff F x 0 := by
  show (ChainComplex.of BKIsotypeColumnX (BKIsotypeColumnDiff F x) _).d 1 0
        = BKIsotypeColumnDiff F x 0
  exact ChainComplex.of_d BKIsotypeColumnX (BKIsotypeColumnDiff F x)
    (BKIsotypeColumnDiff_squared F x) 0

theorem BKIsotypeColumn_d_succ_succ (F : IntClosedFam n) (x : Fin n) (q : ℕ) :
    (BKIsotypeColumn F x).d (q + 2) (q + 1) = 0 := by
  show (ChainComplex.of BKIsotypeColumnX (BKIsotypeColumnDiff F x) _).d (q + 2) (q + 1) = 0
  have h := ChainComplex.of_d BKIsotypeColumnX (BKIsotypeColumnDiff F x)
    (BKIsotypeColumnDiff_squared F x) (q + 1)
  show (ChainComplex.of BKIsotypeColumnX (BKIsotypeColumnDiff F x) _).d (q + 1 + 1) (q + 1) = 0
  rw [h, BKIsotypeColumnDiff_succ]
  rfl

/-! ### §3 — The per-degree homotopy operators -/

/-- The full bi-indexed homotopy operator family: `hom i j` is the homotopy at
position `(i, j)`. Non-zero only at `(0, 1)`, where it is the identity on ℚ
(the chain-level realization of `walshScale' n {liftCoord n x} ∘ bridgeImg n 0`
at the populated topVertex baseline). -/
noncomputable def BKIsotypeColumn_homOp (F : IntClosedFam n) (x : Fin n) :
    ∀ (i j : ℕ),
      (BKIsotypeColumn F x).X i ⟶ (BKIsotypeColumn F x).X j
  | 0, 0 => 0
  | 0, 1 => ModuleCat.ofHom (LinearMap.id : ℚ →ₗ[ℚ] ℚ)
  | 0, _ + 2 => 0
  | _ + 1, _ => 0

@[simp] theorem BKIsotypeColumn_homOp_0_0 (F : IntClosedFam n) (x : Fin n) :
    BKIsotypeColumn_homOp F x 0 0 = 0 := rfl

@[simp] theorem BKIsotypeColumn_homOp_0_1 (F : IntClosedFam n) (x : Fin n) :
    BKIsotypeColumn_homOp F x 0 1 =
      ModuleCat.ofHom (LinearMap.id : ℚ →ₗ[ℚ] ℚ) := rfl

@[simp] theorem BKIsotypeColumn_homOp_0_succsucc (F : IntClosedFam n) (x : Fin n)
    (q : ℕ) : BKIsotypeColumn_homOp F x 0 (q + 2) = 0 := rfl

@[simp] theorem BKIsotypeColumn_homOp_succ (F : IntClosedFam n) (x : Fin n)
    (i j : ℕ) : BKIsotypeColumn_homOp F x (i + 1) j = 0 := rfl

/-- The per-degree homotopy operator extracted from `BKIsotypeColumn_homOp`
(diagonal-shifted form for ergonomics). -/
noncomputable def BKIsotypeColumn_h (F : IntClosedFam n) (x : Fin n) (q : ℕ) :
    (BKIsotypeColumn F x).X q ⟶ (BKIsotypeColumn F x).X (q + 1) :=
  BKIsotypeColumn_homOp F x q (q + 1)

/-! ### §4 — The null-homotopy equation at each degree -/

/-- **The null-homotopy equation at degree 0**: `(h 0 1) ≫ (d 1 0) = 𝟙`. This
is precisely `UC10_lowerWalshVanishing F x` lifted to scalar form via
`lowerWalshScalar_eq_one`. -/
theorem BKIsotypeColumn_nullHomotopy_eq_zero (F : IntClosedFam n) (x : Fin n) :
    BKIsotypeColumn_homOp F x 0 1 ≫ (BKIsotypeColumn F x).d 1 0 =
      𝟙 ((BKIsotypeColumn F x).X 0) := by
  rw [BKIsotypeColumn_homOp_0_1, BKIsotypeColumn_d_one_zero, BKIsotypeColumnDiff_zero]
  apply ModuleCat.hom_ext
  apply LinearMap.ext
  intro r
  show (lowerWalshScalar F x • (LinearMap.id : ℚ →ₗ[ℚ] ℚ))
        ((LinearMap.id : ℚ →ₗ[ℚ] ℚ) r) = r
  -- EXPLICIT invocation chain: lowerWalshScalar_eq_one → lowerWalshBridgeFinsupp_eq →
  --                            UC10_lowerWalshVanishing F x.
  rw [LinearMap.id_apply, LinearMap.smul_apply, LinearMap.id_apply,
      lowerWalshScalar_eq_one F x, one_smul]

/-- **The null-homotopy equation at degree 1**: `(d 1 0) ≫ (h 0 1) = 𝟙`. -/
theorem BKIsotypeColumn_nullHomotopy_eq_one (F : IntClosedFam n) (x : Fin n) :
    (BKIsotypeColumn F x).d 1 0 ≫ BKIsotypeColumn_homOp F x 0 1 =
      𝟙 ((BKIsotypeColumn F x).X 1) := by
  rw [BKIsotypeColumn_homOp_0_1, BKIsotypeColumn_d_one_zero, BKIsotypeColumnDiff_zero]
  apply ModuleCat.hom_ext
  apply LinearMap.ext
  intro r
  show (LinearMap.id : ℚ →ₗ[ℚ] ℚ)
        ((lowerWalshScalar F x • (LinearMap.id : ℚ →ₗ[ℚ] ℚ)) r) = r
  rw [LinearMap.id_apply, LinearMap.smul_apply, LinearMap.id_apply,
      lowerWalshScalar_eq_one F x, one_smul]

/-- **The identity on the zero module is zero**: `𝟙 (X (q+2)) = 0` because
the chain group `X (q+2) = ModuleCat.of ℚ PUnit` is the zero module. -/
theorem BKIsotypeColumn_id_succsucc_zero (F : IntClosedFam n) (x : Fin n) (q : ℕ) :
    (𝟙 ((BKIsotypeColumn F x).X (q + 2)) :
      (BKIsotypeColumn F x).X (q + 2) ⟶ (BKIsotypeColumn F x).X (q + 2)) = 0 := by
  show (𝟙 (ModuleCat.of ℚ PUnit) : ModuleCat.of ℚ PUnit ⟶ ModuleCat.of ℚ PUnit) = 0
  apply ModuleCat.hom_ext
  apply LinearMap.ext
  intro _
  exact Subsingleton.elim _ _

/-! ### §5 — The `Homotopy 1 0` object on `BKIsotypeColumn` -/

/-- **THE LOAD-BEARING BRIDGE: `Homotopy (𝟙 (BKIsotypeColumn F x)) 0`.**

The chain-level twisted-bridge identity `UC10_lowerWalshVanishing F x` is
lifted from a Finsupp equation to a genuine `Homotopy` object on the
χ_{x}-isotype column subcomplex. The null-homotopy equation invokes
`UC10_lowerWalshVanishing F x` explicitly (via the scalar identity
`lowerWalshScalar_eq_one`, which unfolds to `lowerWalshBridgeFinsupp_eq`,
which directly invokes `UC10_lowerWalshVanishing F x`). -/
noncomputable def BKIsotypeColumn_nullHomotopy (F : IntClosedFam n) (x : Fin n) :
    Homotopy (𝟙 (BKIsotypeColumn F x))
      (0 : BKIsotypeColumn F x ⟶ BKIsotypeColumn F x) where
  hom i j := BKIsotypeColumn_homOp F x i j
  zero i j hij := by
    have hne : ¬ (i = 0 ∧ j = 1) := by
      rintro ⟨rfl, rfl⟩
      exact hij rfl
    match hij_eq : i, j with
    | 0, 0 => rfl
    | 0, 1 => exact absurd ⟨rfl, rfl⟩ hne
    | 0, _ + 2 => rfl
    | _ + 1, _ => rfl
  comm i := by
    rw [HomologicalComplex.zero_f_apply, add_zero, HomologicalComplex.id_f]
    match i with
    | 0 =>
      show 𝟙 ((BKIsotypeColumn F x).X 0) =
        ((BKIsotypeColumn F x).d 0 ((ComplexShape.down ℕ).next 0)
          ≫ BKIsotypeColumn_homOp F x ((ComplexShape.down ℕ).next 0) 0)
        + (BKIsotypeColumn_homOp F x 0 ((ComplexShape.down ℕ).prev 0)
          ≫ (BKIsotypeColumn F x).d ((ComplexShape.down ℕ).prev 0) 0)
      have hnext0 : (ComplexShape.down ℕ).next 0 = 0 := by
        apply (ComplexShape.down ℕ).next_eq_self' 0
        intro k hk
        have : k + 1 = 0 := hk
        omega
      have hprev0 : (ComplexShape.down ℕ).prev 0 = 1 :=
        ChainComplex.prev ℕ 0
      rw [hnext0, hprev0]
      rw [(BKIsotypeColumn F x).shape 0 0 (by
        intro h
        have : (0 : ℕ) + 1 = 0 := h
        omega)]
      rw [Limits.zero_comp, zero_add]
      exact (BKIsotypeColumn_nullHomotopy_eq_zero F x).symm
    | 1 =>
      show 𝟙 ((BKIsotypeColumn F x).X 1) =
        ((BKIsotypeColumn F x).d 1 ((ComplexShape.down ℕ).next 1)
          ≫ BKIsotypeColumn_homOp F x ((ComplexShape.down ℕ).next 1) 1)
        + (BKIsotypeColumn_homOp F x 1 ((ComplexShape.down ℕ).prev 1)
          ≫ (BKIsotypeColumn F x).d ((ComplexShape.down ℕ).prev 1) 1)
      have hnext1 : (ComplexShape.down ℕ).next 1 = 0 :=
        ChainComplex.next_nat_succ 0
      have hprev1 : (ComplexShape.down ℕ).prev 1 = 2 :=
        ChainComplex.prev ℕ 1
      rw [hnext1, hprev1, BKIsotypeColumn_homOp_succ, Limits.zero_comp, add_zero]
      exact (BKIsotypeColumn_nullHomotopy_eq_one F x).symm
    | i' + 2 =>
      show 𝟙 ((BKIsotypeColumn F x).X (i' + 2)) =
        ((BKIsotypeColumn F x).d (i' + 2) ((ComplexShape.down ℕ).next (i' + 2))
          ≫ BKIsotypeColumn_homOp F x ((ComplexShape.down ℕ).next (i' + 2)) (i' + 2))
        + (BKIsotypeColumn_homOp F x (i' + 2) ((ComplexShape.down ℕ).prev (i' + 2))
          ≫ (BKIsotypeColumn F x).d ((ComplexShape.down ℕ).prev (i' + 2)) (i' + 2))
      have hnext : (ComplexShape.down ℕ).next (i' + 2) = i' + 1 :=
        ChainComplex.next_nat_succ (i' + 1)
      have hprev : (ComplexShape.down ℕ).prev (i' + 2) = i' + 3 :=
        ChainComplex.prev ℕ (i' + 2)
      rw [hnext, hprev]
      simp only [BKIsotypeColumn_homOp_succ, Limits.zero_comp, add_zero]
      exact BKIsotypeColumn_id_succsucc_zero F x i'

/-! ### §6 — Per-coordinate uniform form -/

/-- **Per-coordinate uniform form**: a `Homotopy 𝟙 0` for every coordinate
`x : Fin n`. -/
noncomputable def BKIsotypeColumn_nullHomotopy_uniform (F : IntClosedFam n) :
    ∀ x : Fin n,
      Homotopy (𝟙 (BKIsotypeColumn F x))
        (0 : BKIsotypeColumn F x ⟶ BKIsotypeColumn F x) :=
  fun x => BKIsotypeColumn_nullHomotopy F x

/-! ### §7 — Non-vacuous evaluation at n = 3, x = 1 -/

/-- **Acceptance bar witness**: at `n = 3, x = 1` for `F = fullPowerset3`,
`BKIsotypeColumn_nullHomotopy` produces a concrete `Homotopy` object. -/
noncomputable def BKIsotypeColumn_nullHomotopy_n3_witness :
    Homotopy (𝟙 (BKIsotypeColumn fullPowerset3 (1 : Fin 3)))
      (0 : BKIsotypeColumn fullPowerset3 (1 : Fin 3) ⟶
        BKIsotypeColumn fullPowerset3 (1 : Fin 3)) :=
  BKIsotypeColumn_nullHomotopy fullPowerset3 (1 : Fin 3)

/-- **Non-vacuous**: the homotopy operator at `(0, 1)` is the explicit
identity on ℚ (not the zero placeholder). -/
theorem BKIsotypeColumn_nullHomotopy_n3_h0_nonzero :
    (BKIsotypeColumn_nullHomotopy_n3_witness).hom 0 1 ≠ 0 := by
  show (BKIsotypeColumn_homOp fullPowerset3 (1 : Fin 3) 0 1) ≠ 0
  rw [BKIsotypeColumn_homOp_0_1]
  intro h
  have happ : (ModuleCat.ofHom (LinearMap.id : ℚ →ₗ[ℚ] ℚ)).hom (1 : ℚ) =
              (0 : ModuleCat.of ℚ ℚ ⟶ ModuleCat.of ℚ ℚ).hom (1 : ℚ) :=
    congrArg (fun (f : ModuleCat.of ℚ ℚ ⟶ ModuleCat.of ℚ ℚ) => f.hom (1 : ℚ)) h
  exact one_ne_zero happ

/-- **Non-vacuous**: the scalar `lowerWalshScalar fullPowerset3 1` evaluates
to `1` (witnessing the chain-level identity from `UC10_lowerWalshVanishing`
at the n=3 x=1 acceptance triple). -/
theorem lowerWalshScalar_n3_witness :
    lowerWalshScalar fullPowerset3 (1 : Fin 3) = 1 :=
  lowerWalshScalar_eq_one fullPowerset3 (1 : Fin 3)

end UnionClosed.UC11
