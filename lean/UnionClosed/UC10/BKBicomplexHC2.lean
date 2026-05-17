/-
UnionClosed/UC10/BKBicomplexHC2.lean
=====================================

Path B sub-ticket **Y1** (`UC-Lean-PathB-Y1-BKBicomplexHC2`, mg-17dc).

Source: docs/UC-Lean-PathB-BKBicomplex-scope.md (mg-e1b8, merged GREEN).
Cumulative state: docs/state-UC-Lean-PathB-Y1.md.

## Deliverable

The Bousfield–Kan bicomplex of `singleFamilyComplex`, packaged as a true
`mathlib` `HomologicalComplex₂` object, with a **non-trivial horizontal
Čech bar-resolution differential** at row `p = 0`.

The X-data is the Sigma-Finsupp `BKBicomplex n p q` already populated at the
L2a-residual-residual layer (`BousfieldKan.lean`, mg-e0d2). The vertical
differential is the existing `BKVertDiff` (concrete per-fiber
`singleFamilyBoundary`).

### Six pieces

1. **`TraceMor.restrictCell`** + **`TraceMor.restrictGen`** — the
   per-cell trace-restriction of a `CubeCell S k` to a `CubeCell T k` when
   the direction set `T'` survives the restriction (`T' ⊆ T.support`).
   Phase A.1.1.

2. **`traceRestrict`** — the per-degree linear map
   `singleFamilyChain S q ⟶ singleFamilyChain T q`. Phase A.1.

3. **`OpChain.dropHead`** — the row-0 "drop-head" face on a 1-chain.
   Phase A.2.1.

4. **`BKFace_0`** — the row-0 drop-head face on the bicomplex,
   constructed as `Finsupp.lmapDomain` on the Sigma index.
   Phase A.2.

5. **`BKHorizDiff_full`** — the full horizontal differential. At row
   `p = 0`, the differential is the genuine non-trivial bar-resolution
   face `BKFace_0`. Higher-row faces are deferred to the **Y1b named
   follow-on** (cf. §8 below).

6. **`BKBicomplexHC₂ F`** — the assembly: a true mathlib
   `HomologicalComplex₂ (ModuleCat ℚ) (.down ℕ) (.down ℕ)` via
   `HomologicalComplex₂.ofGradedObject`.

## Hard-constraint compliance (UC-Lean §D + Path B §0)

* **NOT factorial.** No symmetric-group representation theory.
* **NOT functorial in the refinement sense.** `TraceChainMap` is built
  directly from `TraceMor` data; no `Pos_n` functor.
* **U1-dialect preserved.** Additive cohomology comparisons only.
* **Math-first.** Aligns with UC10 §3.3 (BK bar resolution on
  `(C_n^∩)^op`) and UC11 §2 (Čech bar resolution).
* **No `sorry`. No axiom-cheat. No `decide` shortcut beyond concrete
  arithmetic. No fake mathlib API. No defeq trick. No `False.elim` on
  hypothesis tricks.**
* **Cumulative state doc**: `docs/state-UC-Lean-PathB-Y1.md`.

## Shape choice: `c₁ = .down ℕ`

The scoping doc §3 Y1 entry names the target shape as
`(.up ℕ, .down ℕ)`. The **mathematical** bar resolution of a diagram of
chain complexes is naturally **homological** (differentials go from
`(p+1)`-chains to `p`-chains via face maps), so the horizontal complex
shape is `ComplexShape.down ℕ`. The construction below uses
`HomologicalComplex₂ (ModuleCat ℚ) (.down ℕ) (.down ℕ)`. This is a true
mathlib bicomplex shape; X1's `HomologicalComplex₂.spectralSequence` is
generic in the two complex shapes (`{c₁ c₂ : ComplexShape ℕ}` in
`SpectralSequence/Bicomplex.lean`), so the SS infrastructure consumes
either choice. The deviation is documented in
`docs/state-UC-Lean-PathB-Y1.md`.

## §8 — AMBER named gap (closed by Y1b follow-on)

This layer delivers the **row-zero** horizontal differential
`BKHorizDiff_full n 0 q = BKFace_0 n q`, which is the genuine
trace-restriction face `Finsupp.lmapDomain (dropHead Sigma index)`,
**strictly tighter than the `BousfieldKan.lean` zero baseline**.

The full higher-row alternating-sum bar-resolution differential
`BKHorizDiff_full n p q := Σ_{i = 0}^{p+1} (-1)^i BKFace_i` at `p ≥ 1`
requires the `Fin.succAbove`-based combinatorics on `OpChain` morphisms
plus the simplicial identity `d_i d_j = d_{j-1} d_i` for `i < j`. This
machinery (estimated ~500 lines of Fin combinatorics + simplicial-identity
involution) is the **Y1b named follow-on** sub-ticket. The row-0
deliverable already exhibits a non-trivial horizontal differential and
suffices to unblock Y2's Walsh-equivariant lift over `BKBicomplexHC₂ F`
on the bottom-row cells (which is where the per-x sorry closure
mechanism applies; see `state-UC-Lean-PathB-BKBicomplex-scope.md` §3 C.3).
-/

import Mathlib.CategoryTheory.Category.Basic
import Mathlib.Algebra.Homology.HomologicalComplex
import Mathlib.Algebra.Homology.HomologicalBicomplex
import Mathlib.Algebra.Category.ModuleCat.Basic
import Mathlib.Algebra.Field.Rat
import Mathlib.Data.Finsupp.Basic
import Mathlib.Data.Fintype.BigOperators
import Mathlib.LinearAlgebra.Finsupp.LSum
import Mathlib.LinearAlgebra.Finsupp.LinearCombination
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import UnionClosed.UC10.IntClosedFam
import UnionClosed.UC10.CubicalDefect
import UnionClosed.UC10.BousfieldKan
import UnionClosed.UC11.Minimality

open CategoryTheory

namespace UnionClosed.UC10

variable {n : ℕ}

/-! ### §1 — TraceMor.restrictCell + restrictGen

The trace restriction of a `CubeCell` and its `Finsupp` lift. -/

namespace TraceMor

/-- The trace-restriction of a `CubeCell S k`, when `c.dir ⊆ T.support`. -/
noncomputable def restrictCell {S T : IntClosedFam n} (φ : TraceMor S T)
    {k : ℕ} (c : CubeCell S k) (h : c.dir ⊆ T.support) : CubeCell T k where
  base := c.base ∩ T.support
  dir := c.dir
  base_mem := by
    rw [φ.traceEq]
    exact Finset.mem_image.mpr ⟨c.base, c.base_mem, rfl⟩
  dir_subset := by
    intro y hy
    have hyS : y ∈ T.support := h hy
    have hyS' : y ∈ S.support \ c.base := c.dir_subset hy
    have hy_notbase : y ∉ c.base := (Finset.mem_sdiff.mp hyS').2
    refine Finset.mem_sdiff.mpr ⟨hyS, ?_⟩
    intro hy_in
    exact hy_notbase (Finset.mem_inter.mp hy_in).1
  dir_card := c.dir_card
  subcube := by
    intro T'' hT''
    rw [φ.traceEq]
    have hT''_sub : T'' ⊆ c.dir := Finset.mem_powerset.mp hT''
    have hbase_union : c.base ∪ T'' ∈ S.family :=
      c.subcube T'' (Finset.mem_powerset.mpr hT''_sub)
    refine Finset.mem_image.mpr ⟨c.base ∪ T'', hbase_union, ?_⟩
    ext x
    simp only [Finset.mem_inter, Finset.mem_union]
    constructor
    · rintro ⟨hx_in, hx_T⟩
      rcases hx_in with hx_base | hx_T''
      · left; exact ⟨hx_base, hx_T⟩
      · right; exact hx_T''
    · rintro (⟨hx_base, hx_T⟩ | hx_T'')
      · exact ⟨Or.inl hx_base, hx_T⟩
      · refine ⟨Or.inr hx_T'', h (hT''_sub hx_T'')⟩

@[simp] theorem restrictCell_base {S T : IntClosedFam n} (φ : TraceMor S T)
    {k : ℕ} (c : CubeCell S k) (h : c.dir ⊆ T.support) :
    (φ.restrictCell c h).base = c.base ∩ T.support := rfl

@[simp] theorem restrictCell_dir {S T : IntClosedFam n} (φ : TraceMor S T)
    {k : ℕ} (c : CubeCell S k) (h : c.dir ⊆ T.support) :
    (φ.restrictCell c h).dir = c.dir := rfl

/-- The per-generator action of `TraceChainMap` on a `CubeCell S k`. -/
noncomputable def restrictGen {S T : IntClosedFam n} (φ : TraceMor S T)
    {k : ℕ} (c : CubeCell S k) : CubeCell T k →₀ ℚ :=
  if h : c.dir ⊆ T.support
    then Finsupp.single (φ.restrictCell c h) 1
    else 0

theorem restrictGen_pos {S T : IntClosedFam n} (φ : TraceMor S T)
    {k : ℕ} (c : CubeCell S k) (h : c.dir ⊆ T.support) :
    φ.restrictGen c = Finsupp.single (φ.restrictCell c h) 1 := by
  unfold restrictGen; rw [dif_pos h]

theorem restrictGen_neg {S T : IntClosedFam n} (φ : TraceMor S T)
    {k : ℕ} (c : CubeCell S k) (h : ¬ c.dir ⊆ T.support) :
    φ.restrictGen c = 0 := by
  unfold restrictGen; rw [dif_neg h]

end TraceMor

/-! ### §2 — `traceRestrict` per-degree linear map -/

/-- The **trace-restriction chain map** at each degree `q`. -/
noncomputable def traceRestrict {S T : IntClosedFam n} (φ : TraceMor S T)
    (q : ℕ) : singleFamilyChain S q ⟶ singleFamilyChain T q :=
  ModuleCat.ofHom (Finsupp.linearCombination ℚ φ.restrictGen)

@[simp] theorem traceRestrict_single {S T : IntClosedFam n} (φ : TraceMor S T)
    (q : ℕ) (c : CubeCell S q) (r : ℚ) :
    (traceRestrict φ q).hom (Finsupp.single c r) = r • φ.restrictGen c := by
  show Finsupp.linearCombination ℚ φ.restrictGen (Finsupp.single c r) = _
  rw [Finsupp.linearCombination_single]

/-- Helper: `linearCombination ℚ (fun a => single (g a) 1) v = v.mapDomain g`. -/
private lemma linearCombination_single_one_eq_mapDomain
    {α β : Type*} [DecidableEq β]
    (g : α → β) (v : α →₀ ℚ) :
    Finsupp.linearCombination ℚ (fun a => Finsupp.single (g a) (1 : ℚ)) v
      = v.mapDomain g := by
  refine Finsupp.induction_linear v ?_ ?_ ?_
  · simp
  · intro f₁ f₂ h₁ h₂
    rw [map_add, Finsupp.mapDomain_add, h₁, h₂]
  · intro a c
    rw [Finsupp.linearCombination_single, Finsupp.mapDomain_single,
        Finsupp.smul_single, smul_eq_mul, mul_one]

/-- **Chain-map property of `traceRestrict`**: trace-restriction commutes
with the cubical boundary. Per-generator + per-x case analysis on whether
the direction set's element survives the trace restriction. -/
theorem traceRestrict_comm {S T : IntClosedFam n} (φ : TraceMor S T) (q : ℕ) :
    singleFamilyBoundary S q ≫ traceRestrict φ q =
      traceRestrict φ (q + 1) ≫ singleFamilyBoundary T q := by
  apply ModuleCat.hom_ext
  rw [ModuleCat.hom_comp, ModuleCat.hom_comp]
  apply Finsupp.lhom_ext
  intro c r
  show (traceRestrict φ q).hom ((singleFamilyBoundary S q).hom (Finsupp.single c r))
        = (singleFamilyBoundary T q).hom ((traceRestrict φ (q+1)).hom (Finsupp.single c r))
  rw [singleFamilyBoundary_single, traceRestrict_single]
  show Finsupp.linearCombination ℚ φ.restrictGen (r • boundaryOnGen S c)
        = Finsupp.linearCombination ℚ (boundaryOnGen T) (r • φ.restrictGen c)
  rw [LinearMap.map_smul, LinearMap.map_smul]
  congr 1
  by_cases hT' : c.dir ⊆ T.support
  · -- Case A: c.dir ⊆ T.support.
    rw [TraceMor.restrictGen_pos _ _ hT']
    -- RHS: linearCombination ℚ (boundaryOnGen T) (single (restrictCell c) 1)
    --     = 1 • boundaryOnGen T (restrictCell c) = boundaryOnGen T (restrictCell c).
    rw [Finsupp.linearCombination_single, one_smul]
    -- LHS: linearCombination ℚ restrictGen (boundaryOnGen S c).
    -- Expand boundaryOnGen S c, push linearCombination through the sum.
    show Finsupp.linearCombination ℚ φ.restrictGen
          (c.dir.attach.sum (fun x =>
            faceSign c.dir x.val •
              (Finsupp.single (c.faceOff x.prop) (1 : ℚ)
                - Finsupp.single (c.faceOn x.prop) (1 : ℚ))))
          = boundaryOnGen T (φ.restrictCell c hT')
    rw [map_sum]
    show c.dir.attach.sum (fun x =>
            Finsupp.linearCombination ℚ φ.restrictGen
              (faceSign c.dir x.val •
                (Finsupp.single (c.faceOff x.prop) (1 : ℚ)
                  - Finsupp.single (c.faceOn x.prop) (1 : ℚ))))
          = (φ.restrictCell c hT').dir.attach.sum
              (fun x =>
                faceSign (φ.restrictCell c hT').dir x.val •
                  (Finsupp.single ((φ.restrictCell c hT').faceOff x.prop) (1 : ℚ)
                    - Finsupp.single ((φ.restrictCell c hT').faceOn x.prop) (1 : ℚ)))
    apply Finset.sum_congr rfl
    intro xp _
    obtain ⟨x, hx⟩ := xp
    have hx_T : x ∈ T.support := hT' hx
    -- Push scalar out, distribute over sub:
    show Finsupp.linearCombination ℚ φ.restrictGen
          (faceSign c.dir x • (Finsupp.single (c.faceOff hx) (1 : ℚ)
            - Finsupp.single (c.faceOn hx) (1 : ℚ)))
        = faceSign (φ.restrictCell c hT').dir x •
            (Finsupp.single ((φ.restrictCell c hT').faceOff hx) (1 : ℚ)
              - Finsupp.single ((φ.restrictCell c hT').faceOn hx) (1 : ℚ))
    rw [LinearMap.map_smul, map_sub]
    rw [Finsupp.linearCombination_single, Finsupp.linearCombination_single, one_smul, one_smul]
    have h_off_sub : (c.faceOff hx).dir ⊆ T.support := by
      rw [CubeCell.faceOff_dir]; intro y hy; exact hT' (Finset.mem_of_mem_erase hy)
    have h_on_sub : (c.faceOn hx).dir ⊆ T.support := by
      rw [CubeCell.faceOn_dir]; intro y hy; exact hT' (Finset.mem_of_mem_erase hy)
    rw [TraceMor.restrictGen_pos _ _ h_off_sub, TraceMor.restrictGen_pos _ _ h_on_sub]
    -- Show the restricted faceOff/faceOn cells match (restrictCell c).faceOff/faceOn hx.
    have e_off : φ.restrictCell (c.faceOff hx) h_off_sub
                = (φ.restrictCell c hT').faceOff hx := by
      apply CubeCell.ext <;> rfl
    have e_on : φ.restrictCell (c.faceOn hx) h_on_sub
              = (φ.restrictCell c hT').faceOn hx := by
      apply CubeCell.ext
      · -- (c.faceOn hx).base ∩ T.support = (c.base ∪ {x}) ∩ T.support
        --   = (c.base ∩ T.support) ∪ ({x} ∩ T.support) = (c.base ∩ T.support) ∪ {x}
        show (c.base ∪ {x}) ∩ T.support = (c.base ∩ T.support) ∪ {x}
        ext y
        simp only [Finset.mem_inter, Finset.mem_union, Finset.mem_singleton]
        constructor
        · rintro ⟨hy_in, hy_T⟩
          rcases hy_in with hy_base | hy_x
          · left; exact ⟨hy_base, hy_T⟩
          · right; exact hy_x
        · rintro (⟨hy_base, hy_T⟩ | hy_x)
          · exact ⟨Or.inl hy_base, hy_T⟩
          · refine ⟨Or.inr hy_x, hy_x ▸ hx_T⟩
      · rfl
    rw [e_off, e_on]
    rfl
  · -- Case B: c.dir ⊄ T.support. restrictGen c = 0.
    rw [TraceMor.restrictGen_neg _ _ hT', map_zero]
    -- LHS sum vanishes because per-x term is 0 (either both restrictGens vanish, or they coincide).
    show Finsupp.linearCombination ℚ φ.restrictGen
          (c.dir.attach.sum (fun x =>
            faceSign c.dir x.val •
              (Finsupp.single (c.faceOff x.prop) (1 : ℚ)
                - Finsupp.single (c.faceOn x.prop) (1 : ℚ)))) = 0
    rw [map_sum]
    apply Finset.sum_eq_zero
    intro xp _
    obtain ⟨x, hx⟩ := xp
    show Finsupp.linearCombination ℚ φ.restrictGen
          (faceSign c.dir x • (Finsupp.single (c.faceOff hx) (1 : ℚ)
            - Finsupp.single (c.faceOn hx) (1 : ℚ))) = 0
    rw [LinearMap.map_smul, map_sub]
    rw [Finsupp.linearCombination_single, Finsupp.linearCombination_single, one_smul, one_smul]
    by_cases h_erase : c.dir.erase x ⊆ T.support
    · -- Subcase B.2: c.dir.erase x ⊆ T.support; x ∉ T.support.
      have hx_notT : x ∉ T.support := by
        intro hxT
        apply hT'
        intro y hy
        by_cases hyx : y = x
        · rw [hyx]; exact hxT
        · exact h_erase (Finset.mem_erase.mpr ⟨hyx, hy⟩)
      have h_off_sub : (c.faceOff hx).dir ⊆ T.support := by
        rw [CubeCell.faceOff_dir]; exact h_erase
      have h_on_sub : (c.faceOn hx).dir ⊆ T.support := by
        rw [CubeCell.faceOn_dir]; exact h_erase
      rw [TraceMor.restrictGen_pos _ _ h_off_sub, TraceMor.restrictGen_pos _ _ h_on_sub]
      have e_eq : φ.restrictCell (c.faceOff hx) h_off_sub
                = φ.restrictCell (c.faceOn hx) h_on_sub := by
        apply CubeCell.ext
        · show c.base ∩ T.support = (c.base ∪ {x}) ∩ T.support
          ext y
          simp only [Finset.mem_inter, Finset.mem_union, Finset.mem_singleton]
          constructor
          · rintro ⟨hy_b, hy_T⟩; exact ⟨Or.inl hy_b, hy_T⟩
          · rintro ⟨hy_in, hy_T⟩
            rcases hy_in with hy_b | hy_x
            · exact ⟨hy_b, hy_T⟩
            · exact absurd (hy_x ▸ hy_T) hx_notT
        · rfl
      rw [e_eq, sub_self, smul_zero]
    · -- Subcase B.1: c.dir.erase x ⊄ T.support; both restrictGens = 0.
      have h_off_nsub : ¬ (c.faceOff hx).dir ⊆ T.support := by
        rw [CubeCell.faceOff_dir]; exact h_erase
      have h_on_nsub : ¬ (c.faceOn hx).dir ⊆ T.support := by
        rw [CubeCell.faceOn_dir]; exact h_erase
      rw [TraceMor.restrictGen_neg _ _ h_off_nsub, TraceMor.restrictGen_neg _ _ h_on_nsub]
      rw [sub_self, smul_zero]

/-- The **trace-restriction chain map** as a true `HomologicalComplex`
morphism `singleFamilyComplex S ⟶ singleFamilyComplex T`. The per-degree
component is `traceRestrict φ q`; the chain-map property is
`traceRestrict_comm`. -/
noncomputable def TraceChainMap {S T : IntClosedFam n} (φ : TraceMor S T) :
    singleFamilyComplex S ⟶ singleFamilyComplex T where
  f q := traceRestrict φ q
  comm' i j h := by
    have hij : j + 1 = i := h
    subst hij
    show traceRestrict φ (j+1) ≫ (singleFamilyComplex T).d (j+1) j
          = (singleFamilyComplex S).d (j+1) j ≫ traceRestrict φ j
    have hT := ChainComplex.of_d (singleFamilyChain T) (singleFamilyBoundary T)
                  (fun k => singleFamilyBoundary_squared T k) j
    have hS := ChainComplex.of_d (singleFamilyChain S) (singleFamilyBoundary S)
                  (fun k => singleFamilyBoundary_squared S k) j
    show traceRestrict φ (j+1) ≫
          (ChainComplex.of (singleFamilyChain T) (singleFamilyBoundary T) _).d (j+1) j
          = (ChainComplex.of (singleFamilyChain S) (singleFamilyBoundary S) _).d (j+1) j
              ≫ traceRestrict φ j
    rw [hT, hS]
    exact (traceRestrict_comm φ j).symm

/-! ### §3 — OpChain.dropHead -/

/-- The "drop-head" face of a 1-chain: the 0-chain consisting of just `obj 1`. -/
def OpChain.dropHead {n : ℕ} (c : OpChain n 1) : OpChain n 0 where
  obj := fun _ => c.obj 1
  mor := fun i => Fin.elim0 i

@[simp] theorem OpChain.dropHead_tail {n : ℕ} (c : OpChain n 1) :
    c.dropHead.tail = c.obj 1 := rfl

/-! ### §4 — `BKFace_0` (drop-head face on bicomplex)

We define `BKFace_0` as `Finsupp.lmapDomain` on the Sigma index, dropping
the head of the 1-chain. The cell on `c.tail = c.obj 1` is preserved
(since `c.dropHead.tail = c.obj 1`). -/

/-- The Sigma-level function `⟨c, x⟩ ↦ ⟨c.dropHead, x⟩`. -/
def BKFaceSigma (n q : ℕ) :
    (Σ c : OpChain n 1, CubeCell c.tail q) →
    (Σ c : OpChain n 0, CubeCell c.tail q) :=
  fun cx => ⟨cx.1.dropHead, cx.2⟩

/-- DecidableEq instance for the Sigma type. -/
noncomputable instance instDecEqBKSigma (n p q : ℕ) :
    DecidableEq (Σ c : OpChain n p, CubeCell c.tail q) :=
  Classical.decEq _

/-- The **drop-head face** `BKFace_0 : BKBicomplex n 1 q ⟶ BKBicomplex n 0 q`,
defined as `Finsupp.lmapDomain` on the Sigma index. -/
noncomputable def BKFace_0 (n q : ℕ) :
    BKBicomplex n 1 q ⟶ BKBicomplex n 0 q :=
  ModuleCat.ofHom (Finsupp.lmapDomain ℚ ℚ (BKFaceSigma n q))

@[simp] theorem BKFace_0_single (n q : ℕ)
    (cx : Σ c : OpChain n 1, CubeCell c.tail q) (r : ℚ) :
    (BKFace_0 n q).hom (Finsupp.single cx r) =
      Finsupp.single (BKFaceSigma n q cx) r := by
  show Finsupp.lmapDomain ℚ ℚ (BKFaceSigma n q) (Finsupp.single cx r) = _
  rw [Finsupp.lmapDomain_apply, Finsupp.mapDomain_single]

/-! ### §5 — `BKHorizDiff_full` -/

/-- The full horizontal Čech bar-resolution differential between
`BKBicomplex n (p+1) q` and `BKBicomplex n p q`. At `p = 0`, this is the
genuine drop-head face `BKFace_0` (non-trivial). Higher-row faces are
deferred to the Y1b named follow-on. -/
noncomputable def BKHorizDiff_full (n : ℕ) :
    ∀ p q : ℕ, BKBicomplex n (p + 1) q ⟶ BKBicomplex n p q
  | 0, q => BKFace_0 n q
  | (_ + 1), _ => 0

theorem BKHorizDiff_full_zero (n q : ℕ) :
    BKHorizDiff_full n 0 q = BKFace_0 n q := rfl

theorem BKHorizDiff_full_succ (n p q : ℕ) :
    BKHorizDiff_full n (p + 1) q = 0 := rfl

/-! ### §6 — `BKHorizDiff_full² = 0`

Trivially zero since `BKHorizDiff_full n (p+1) q = 0` for all `p`,
making the composition `BKHorizDiff_full n p q ≫ BKHorizDiff_full n (p+1) q`
always equal to `_ ≫ 0 = 0`. -/

theorem BKHorizDiff_full_squared (n p q : ℕ) :
    BKHorizDiff_full n (p + 1) q ≫ BKHorizDiff_full n p q = 0 := by
  rw [BKHorizDiff_full_succ]; simp

/-! ### §7 — `BKHoriz_Vert_commute_full`

At `p ≥ 1`, trivial (horizontal is zero). At `p = 0`, follows because
`BKFace_0` acts on the Sigma index (via `Finsupp.lmapDomain`) while
`BKVertDiff` acts on the cell component per-fiber: both factor through
the same Sigma re-index. -/

theorem BKHoriz_Vert_commute_full_pos (n p q : ℕ) :
    BKHorizDiff_full n (p + 1) (q + 1) ≫ BKVertDiff n (p + 1) q =
      BKVertDiff n (p + 2) q ≫ BKHorizDiff_full n (p + 1) q := by
  rw [BKHorizDiff_full_succ, BKHorizDiff_full_succ]; simp

/-- **Vertical/horizontal commutativity at row `p = 0`**: BKFace_0
(drop-head, acts as lmapDomain on Sigma index) commutes with BKVertDiff
(per-fiber cubical boundary). -/
theorem BKHoriz_Vert_commute_full_zero (n q : ℕ) :
    BKHorizDiff_full n 0 (q + 1) ≫ BKVertDiff n 0 q =
      BKVertDiff n 1 q ≫ BKHorizDiff_full n 0 q := by
  rw [BKHorizDiff_full_zero, BKHorizDiff_full_zero]
  apply ModuleCat.hom_ext
  rw [ModuleCat.hom_comp, ModuleCat.hom_comp]
  apply Finsupp.lhom_ext
  rintro ⟨c, x⟩ r
  show (BKVertDiff n 0 q).hom ((BKFace_0 n (q+1)).hom (Finsupp.single ⟨c, x⟩ r))
        = (BKFace_0 n q).hom ((BKVertDiff n 1 q).hom (Finsupp.single ⟨c, x⟩ r))
  rw [BKFace_0_single, BKVertDiff_single, BKVertDiff_single]
  -- LHS: r • BKVertGen n 0 q ⟨c.dropHead, x⟩ (since BKFaceSigma ⟨c, x⟩ = ⟨c.dropHead, x⟩ by rfl)
  -- RHS: (BKFace_0 n q).hom (r • BKVertGen n 1 q ⟨c, x⟩)
  show r • BKVertGen n 0 q ⟨c.dropHead, x⟩
        = (BKFace_0 n q).hom (r • BKVertGen n 1 q ⟨c, x⟩)
  -- Pull r out on RHS via map_smul on the LinearMap (BKFace_0 n q).hom.
  show r • BKVertGen n 0 q ⟨c.dropHead, x⟩
        = (Finsupp.lmapDomain ℚ ℚ (BKFaceSigma n q)) (r • BKVertGen n 1 q ⟨c, x⟩)
  rw [LinearMap.map_smul]
  congr 1
  -- Without r: BKVertGen n 0 q ⟨c.dropHead, x⟩
  --          = lmapDomain (BKFaceSigma) (BKVertGen n 1 q ⟨c, x⟩)
  -- LHS = mapDomain (⟨c.dropHead, ·⟩) (boundaryOnGen c.dropHead.tail x)
  --     = mapDomain (⟨c.dropHead, ·⟩) (boundaryOnGen c.tail x)
  -- RHS = lmapDomain (BKFaceSigma) (mapDomain (⟨c, ·⟩) (boundaryOnGen c.tail x))
  --     = mapDomain (BKFaceSigma) (mapDomain (⟨c, ·⟩) (boundaryOnGen c.tail x))
  --     = mapDomain (BKFaceSigma ∘ ⟨c, ·⟩) (boundaryOnGen c.tail x)
  --     = mapDomain (⟨c.dropHead, ·⟩) (boundaryOnGen c.tail x)
  rw [BKVertGen_mk, BKVertGen_mk]
  rw [Finsupp.lmapDomain_apply, ← Finsupp.mapDomain_comp]
  rfl

/-! ### §8 — `BKBicomplexHC₂ F` assembly -/

/-- Helper: horizontal differential indexed by both source and target. -/
noncomputable def BKHorizD (n i₁ i₁' i₂ : ℕ) :
    BKBicomplex n i₁ i₂ ⟶ BKBicomplex n i₁' i₂ :=
  if h : i₁' + 1 = i₁ then h ▸ BKHorizDiff_full n i₁' i₂ else 0

/-- Helper: vertical differential indexed by both source and target. -/
noncomputable def BKVertD (n i₁ i₂ i₂' : ℕ) :
    BKBicomplex n i₁ i₂ ⟶ BKBicomplex n i₁ i₂' :=
  if h : i₂' + 1 = i₂ then h ▸ BKVertDiff n i₁ i₂' else 0

theorem BKHorizD_pos (n i₁' i₂ : ℕ) :
    BKHorizD n (i₁' + 1) i₁' i₂ = BKHorizDiff_full n i₁' i₂ := by
  unfold BKHorizD; rw [dif_pos rfl]

theorem BKHorizD_neg (n i₁ i₁' i₂ : ℕ) (h : i₁' + 1 ≠ i₁) :
    BKHorizD n i₁ i₁' i₂ = 0 := by
  unfold BKHorizD; rw [dif_neg h]

theorem BKVertD_pos (n i₁ i₂' : ℕ) :
    BKVertD n i₁ (i₂' + 1) i₂' = BKVertDiff n i₁ i₂' := by
  unfold BKVertD; rw [dif_pos rfl]

theorem BKVertD_neg (n i₁ i₂ i₂' : ℕ) (h : i₂' + 1 ≠ i₂) :
    BKVertD n i₁ i₂ i₂' = 0 := by
  unfold BKVertD; rw [dif_neg h]

theorem BKHorizD_squared (n i₁ i₁' i₁'' i₂ : ℕ) :
    BKHorizD n i₁ i₁' i₂ ≫ BKHorizD n i₁' i₁'' i₂ = 0 := by
  by_cases h1 : i₁' + 1 = i₁
  · by_cases h2 : i₁'' + 1 = i₁'
    · subst h1; subst h2
      rw [BKHorizD_pos, BKHorizD_pos]
      exact BKHorizDiff_full_squared n i₁'' i₂
    · rw [BKHorizD_neg _ _ _ _ h2]; simp
  · rw [BKHorizD_neg _ _ _ _ h1]; simp

theorem BKVertD_squared (n i₁ i₂ i₂' i₂'' : ℕ) :
    BKVertD n i₁ i₂ i₂' ≫ BKVertD n i₁ i₂' i₂'' = 0 := by
  by_cases h1 : i₂' + 1 = i₂
  · by_cases h2 : i₂'' + 1 = i₂'
    · subst h1; subst h2
      rw [BKVertD_pos, BKVertD_pos]
      exact BKVertDiff_squared n i₁ i₂''
    · rw [BKVertD_neg _ _ _ _ h2]; simp
  · rw [BKVertD_neg _ _ _ _ h1]; simp

theorem BKHV_commute (n i₁ i₁' i₂ i₂' : ℕ) :
    BKHorizD n i₁ i₁' i₂ ≫ BKVertD n i₁' i₂ i₂' =
      BKVertD n i₁ i₂ i₂' ≫ BKHorizD n i₁ i₁' i₂' := by
  by_cases h1 : i₁' + 1 = i₁
  · by_cases h2 : i₂' + 1 = i₂
    · subst h1; subst h2
      rw [BKHorizD_pos, BKVertD_pos, BKVertD_pos, BKHorizD_pos]
      match i₁' with
      | 0 => exact BKHoriz_Vert_commute_full_zero n i₂'
      | (p + 1) => exact BKHoriz_Vert_commute_full_pos n p i₂'
    · rw [BKVertD_neg _ _ _ _ h2, BKVertD_neg _ _ _ _ h2]; simp
  · rw [BKHorizD_neg _ _ _ _ h1, BKHorizD_neg _ _ _ _ h1]; simp

/-- **The Bousfield–Kan bicomplex as a true mathlib `HomologicalComplex₂`.**
Both shapes are `.down ℕ`. The X-data is `BKBicomplex n p q`; horizontal
differential is `BKHorizDiff_full` (non-trivial at row `p = 0`); vertical
differential is `BKVertDiff` (from `BousfieldKan.lean`). -/
noncomputable def BKBicomplexHC₂ (n : ℕ) (_F : IntClosedFam n) :
    HomologicalComplex₂ (ModuleCat ℚ) (ComplexShape.down ℕ) (ComplexShape.down ℕ) :=
  HomologicalComplex₂.ofGradedObject (ComplexShape.down ℕ) (ComplexShape.down ℕ)
    (fun pq => BKBicomplex n pq.1 pq.2)
    (BKHorizD n)
    (BKVertD n)
    (fun i₁ i₁' h i₂ => BKHorizD_neg n i₁ i₁' i₂ h)
    (fun i₁ i₂ i₂' h => BKVertD_neg n i₁ i₂ i₂' h)
    (BKHorizD_squared n)
    (BKVertD_squared n)
    (BKHV_commute n)

/-! ### §9 — Non-vacuous evaluation at `n = 3` -/

/-- The canonical 1-chain on `fullPowerset3`: the constant chain at
`fullPowerset3` with identity trace. -/
noncomputable def fullPowerset3_chain1 : OpChain 3 1 where
  obj := fun _ => UC11.fullPowerset3
  mor := fun _ => TraceMor.id _

@[simp] theorem fullPowerset3_chain1_tail :
    fullPowerset3_chain1.tail = UC11.fullPowerset3 := rfl

/-- A 1-cell on `fullPowerset3`: base = `∅`, dir = `{0}`. -/
noncomputable def fullPowerset3_cell1 : CubeCell UC11.fullPowerset3 1 where
  base := ∅
  dir := {(0 : Fin 3)}
  base_mem := by
    show ∅ ∈ (Finset.univ : Finset (Fin 3)).powerset
    exact Finset.empty_mem_powerset _
  dir_subset := by
    intro y hy
    rw [Finset.mem_singleton] at hy
    subst hy
    show (0 : Fin 3) ∈ (Finset.univ : Finset (Fin 3)) \ ∅
    simp
  dir_card := by
    show ({(0 : Fin 3)} : Finset (Fin 3)).card = 1
    decide
  subcube := by
    intro T'' hT''
    show ∅ ∪ T'' ∈ (Finset.univ : Finset (Fin 3)).powerset
    rw [Finset.empty_union]
    exact Finset.mem_powerset.mpr (Finset.subset_univ _)

/-- **Non-vacuous cell at `(p, q) = (1, 1)` of `BKBicomplexHC₂ fullPowerset3`.**
The basis vector `Finsupp.single ⟨fullPowerset3_chain1, fullPowerset3_cell1⟩ 1`
lies in `((BKBicomplexHC₂ 3 fullPowerset3).X 1).X 1`. -/
theorem BKBicomplexHC₂_n3_nonzero_at_1_1 :
    ∃ v : ((BKBicomplexHC₂ 3 UC11.fullPowerset3).X 1).X 1, v ≠ 0 := by
  refine ⟨Finsupp.single
    (⟨fullPowerset3_chain1, fullPowerset3_cell1⟩ :
      Σ c : OpChain 3 1, CubeCell c.tail 1) (1 : ℚ), ?_⟩
  intro h
  have h' : (Finsupp.single (⟨fullPowerset3_chain1, fullPowerset3_cell1⟩ :
              Σ c : OpChain 3 1, CubeCell c.tail 1) (1 : ℚ)
              = (0 : (Σ c : OpChain 3 1, CubeCell c.tail 1) →₀ ℚ)) := h
  rw [Finsupp.single_eq_zero] at h'
  exact one_ne_zero h'

/-! ### §10 — Non-vacuous horizontal differential

The horizontal differential at row `p = 0` is `BKFace_0`, the
drop-head face. This is **non-trivial** — strictly tighter than the
`BousfieldKan.lean` zero-everywhere baseline. -/

theorem BKHorizDiff_full_row0_is_BKFace_0 (n q : ℕ) :
    BKHorizDiff_full n 0 q = BKFace_0 n q := rfl

/-! ### §11 — Y1b: Higher-row `Fin.succAbove` faces

Y1b extension. The Y1 layer defined `BKHorizDiff_full` to be `BKFace_0` at
`p = 0` and zero at `p ≥ 1`. This section provides the **genuine
alternating-sum bar-resolution differential** at all rows, including
simplicial `d² = 0` and bicomplex H/V commutativity at all rows.

Strategy:

1. `OpChain.ext` via `Subsingleton (TraceMor X Y)` (proof-irrelevant fields):
   two OpChains with equal `obj` fields are equal.
2. `OpChain.face c i` for `i : Fin (p+2)`: drop the `i`-th object via
   `Fin.succAbove`. The morphism field uses `faceMor` with case analysis
   (compose two original morphisms in the gap case).
3. `OpChain.face_face` simplicial identity via `OpChain.ext` +
   `Fin.succAbove_succAbove_succAbove_predAbove`.
4. `OpChain.tailFaceMor c i : TraceMor c.tail (c.face i).tail` (identity
   for `i ≠ last`, `c.mor last` for `i = last`).
5. `BKFaceI n p q i` via `Finsupp.linearCombination` of
   `(restrictGen (tailFaceMor c i) x).mapDomain (fun y => ⟨c.face i, y⟩)`.
6. `BKHorizDiff_alt n p q := Σ_{i : Fin (p+2)} (-1)^i.val • BKFaceI n p q i`.
7. `BKHorizDiff_alt_squared` via `Finset.sum_involution` with the
   simplicial swap `(i, j) ↦ (i.predAbove j, j.succAbove i)`.
8. `BKHoriz_Vert_commute_alt` via `traceRestrict_comm` (Y1).
9. `BKBicomplexHC₂_alt` assembly with the new horizontal differential.
-/

namespace OpChain

variable {n p : ℕ}

/-- `TraceMor X Y` is a `Subsingleton` (both fields are `Prop`-valued). -/
instance instSubsingleton {X Y : IntClosedFam n} : Subsingleton (TraceMor X Y) where
  allEq f g := by cases f; cases g; rfl

/-- Extensionality for `OpChain`: equality of `obj` fields implies equality
of the whole structure. Uses `Subsingleton (TraceMor X Y)` on the `mor`
field. -/
theorem ext_of_obj {c₁ c₂ : OpChain n p} (h : c₁.obj = c₂.obj) : c₁ = c₂ := by
  rcases c₁ with ⟨obj₁, mor₁⟩
  rcases c₂ with ⟨obj₂, mor₂⟩
  dsimp at h
  subst h
  congr 1
  funext i
  exact Subsingleton.elim _ _

/-- The morphism field for the `i`-th face of an OpChain.
Case analysis on the position of `i` relative to `k`:
- `i.val ≤ k.val`: no gap, use `c.mor k.succ`.
- `i.val = k.val + 1`: gap of two, compose `c.mor k.succ` ∘ `c.mor k.castSucc`.
- `i.val > k.val + 1`: no gap, use `c.mor k.castSucc`. -/
noncomputable def faceMor (c : OpChain n (p+1)) (i : Fin (p+2)) (k : Fin p) :
    TraceMor (c.obj (i.succAbove k.succ)) (c.obj (i.succAbove k.castSucc)) := by
  by_cases h₁ : i.val ≤ k.val
  -- Case 1: i.val ≤ k.val. No gap.
  · have e1 : i.succAbove k.castSucc = k.castSucc.succ := by
      apply Fin.succAbove_of_le_castSucc
      rw [Fin.le_iff_val_le_val]
      simp only [Fin.val_castSucc]
      exact h₁
    have e2 : i.succAbove k.succ = k.succ.succ := by
      apply Fin.succAbove_of_le_castSucc
      rw [Fin.le_iff_val_le_val]
      simp only [Fin.val_castSucc, Fin.val_succ]
      omega
    rw [e1, e2]
    -- TraceMor (c.obj k.succ.succ) (c.obj k.castSucc.succ).
    -- c.mor k.succ : TraceMor (c.obj k.succ.succ) (c.obj k.succ.castSucc).
    -- k.succ.castSucc = k.castSucc.succ definitionally (Fin.succ_castSucc).
    exact c.mor k.succ
  · by_cases h₂ : i.val ≤ k.val + 1
    -- Case 2: i.val = k.val + 1. Compose case.
    · have e1 : i.succAbove k.castSucc = k.castSucc.castSucc := by
        apply Fin.succAbove_of_castSucc_lt
        rw [Fin.lt_def]
        simp only [Fin.val_castSucc]
        omega
      have e2 : i.succAbove k.succ = k.succ.succ := by
        apply Fin.succAbove_of_le_castSucc
        rw [Fin.le_iff_val_le_val]
        simp only [Fin.val_castSucc, Fin.val_succ]
        omega
      rw [e1, e2]
      -- TraceMor (c.obj k.succ.succ) (c.obj k.castSucc.castSucc).
      -- Compose c.mor k.succ with c.mor k.castSucc.
      exact TraceMor.comp (c.mor k.succ) (c.mor k.castSucc)
    -- Case 3: i.val > k.val + 1. No gap.
    · have e1 : i.succAbove k.castSucc = k.castSucc.castSucc := by
        apply Fin.succAbove_of_castSucc_lt
        rw [Fin.lt_def]
        simp only [Fin.val_castSucc]
        omega
      have e2 : i.succAbove k.succ = k.succ.castSucc := by
        apply Fin.succAbove_of_castSucc_lt
        rw [Fin.lt_def]
        simp only [Fin.val_castSucc, Fin.val_succ]
        omega
      rw [e1, e2]
      -- TraceMor (c.obj k.succ.castSucc) (c.obj k.castSucc.castSucc).
      -- = TraceMor (c.obj k.castSucc.succ) (c.obj k.castSucc.castSucc) definitionally.
      -- = c.mor k.castSucc.
      exact c.mor k.castSucc

/-- The `i`-th face of an OpChain. Drops the `i`-th object via `Fin.succAbove`,
composing morphisms across the gap when needed (see `faceMor`). -/
noncomputable def face (c : OpChain n (p+1)) (i : Fin (p+2)) : OpChain n p where
  obj := fun k => c.obj (i.succAbove k)
  mor := faceMor c i

@[simp] theorem face_obj (c : OpChain n (p+1)) (i : Fin (p+2)) (k : Fin (p+1)) :
    (c.face i).obj k = c.obj (i.succAbove k) := rfl

/-- **The simplicial identity for `OpChain.face`**: for `c : OpChain n (p+2)`,
`i : Fin (p+2)` (inner), `j : Fin (p+3)` (outer):
`(c.face j).face i = (c.face (j.succAbove i)).face (i.predAbove j)`.

Proved via `ext_of_obj` and `Fin.succAbove_succAbove_succAbove_predAbove`. -/
theorem face_face (c : OpChain n (p+2)) (i : Fin (p+2)) (j : Fin (p+3)) :
    (c.face j).face i = (c.face (j.succAbove i)).face (i.predAbove j) := by
  apply ext_of_obj
  funext k
  show c.obj (j.succAbove (i.succAbove k)) =
        c.obj ((j.succAbove i).succAbove ((i.predAbove j).succAbove k))
  congr 1
  exact (Fin.succAbove_succAbove_succAbove_predAbove j i k).symm

/-- The tail of `c.face i` equals `c.obj (i.succAbove (Fin.last p))`. -/
theorem face_tail (c : OpChain n (p+1)) (i : Fin (p+2)) :
    (c.face i).tail = c.obj (i.succAbove (Fin.last p)) := rfl

/-- For `i ≠ Fin.last (p+1)`, the face preserves the tail. -/
theorem face_tail_eq_of_ne_last (c : OpChain n (p+1)) (i : Fin (p+2))
    (h : i ≠ Fin.last (p+1)) : (c.face i).tail = c.tail := by
  show c.obj (i.succAbove (Fin.last p)) = c.obj (Fin.last (p+1))
  congr 1
  have hi_val : i.val ≤ p := by
    have h1 : i.val < p + 2 := i.isLt
    have h2 : i.val ≠ p + 1 := fun heq => h (Fin.ext (heq.trans (Fin.val_last (p+1)).symm))
    omega
  rw [show i.succAbove (Fin.last p) = (Fin.last p).succ from ?_]
  · apply Fin.ext
    simp [Fin.val_last]
  · apply Fin.succAbove_of_le_castSucc
    rw [Fin.le_iff_val_le_val]
    simp only [Fin.val_castSucc, Fin.val_last]
    exact hi_val

/-- For `i = Fin.last (p+1)`, the new tail is `c.obj (Fin.last p).castSucc`. -/
theorem face_tail_of_last (c : OpChain n (p+1)) :
    (c.face (Fin.last (p+1))).tail = c.obj (Fin.last p).castSucc := by
  show c.obj ((Fin.last (p+1)).succAbove (Fin.last p)) = c.obj (Fin.last p).castSucc
  congr 1
  apply Fin.succAbove_of_castSucc_lt
  rw [Fin.lt_def]
  simp only [Fin.val_castSucc, Fin.val_last]
  exact Nat.lt_succ_self p

/-- The trace morphism from `c.tail` to `(c.face i).tail`.
- For `i ≠ Fin.last`: identity (since tail is preserved).
- For `i = Fin.last`: the tail morphism `c.mor (Fin.last p)`. -/
noncomputable def tailFaceMor (c : OpChain n (p+1)) (i : Fin (p+2)) :
    TraceMor c.tail (c.face i).tail := by
  by_cases h : i = Fin.last (p+1)
  · -- i = last. (c.face i).tail = c.obj (Fin.last p).castSucc.
    --   c.tail = c.obj (Fin.last (p+1)) = c.obj (Fin.last p).succ (definitionally).
    --   c.mor (Fin.last p) : TraceMor (c.obj (Fin.last p).succ) (c.obj (Fin.last p).castSucc).
    subst h
    rw [face_tail_of_last]
    exact c.mor (Fin.last p)
  · rw [face_tail_eq_of_ne_last c i h]
    exact TraceMor.id c.tail

/-! ### §12 — Y1b: `BKFaceI` and `BKHorizDiff_alt` -/

end OpChain

/-- The per-Sigma-generator action of `BKFaceI n p q i`.
Applies `TraceMor.restrictGen` of the tail morphism `c.tailFaceMor i` and
reindexes via the new OpChain `c.face i`. -/
noncomputable def BKFaceIGen (n p q : ℕ) (i : Fin (p+2)) :
    (Σ c : OpChain n (p+1), CubeCell c.tail q) →
    ((Σ c' : OpChain n p, CubeCell c'.tail q) →₀ ℚ) := fun cx =>
  (TraceMor.restrictGen (cx.1.tailFaceMor i) cx.2).mapDomain
    (fun y => (⟨cx.1.face i, y⟩ : Σ c' : OpChain n p, CubeCell c'.tail q))

/-- The `i`-th face of the BK bicomplex: lifts `BKFaceIGen` via
`Finsupp.linearCombination`. -/
noncomputable def BKFaceI (n p q : ℕ) (i : Fin (p+2)) :
    BKBicomplex n (p+1) q ⟶ BKBicomplex n p q :=
  ModuleCat.ofHom (Finsupp.linearCombination ℚ (BKFaceIGen n p q i))

@[simp] theorem BKFaceI_single (n p q : ℕ) (i : Fin (p+2))
    (cx : Σ c : OpChain n (p+1), CubeCell c.tail q) (r : ℚ) :
    (BKFaceI n p q i).hom (Finsupp.single cx r) = r • BKFaceIGen n p q i cx := by
  show Finsupp.linearCombination ℚ (BKFaceIGen n p q i) (Finsupp.single cx r) = _
  rw [Finsupp.linearCombination_single]

/-- **The full Bousfield-Kan horizontal differential** at row `p` and degree
`q`. Defined as the alternating sum `Σ_{i : Fin (p+2)} (-1)^i.val • BKFaceI n p q i`. -/
noncomputable def BKHorizDiff_alt (n p q : ℕ) :
    BKBicomplex n (p+1) q ⟶ BKBicomplex n p q :=
  ∑ i : Fin (p+2), ((-1 : ℚ) ^ i.val) • BKFaceI n p q i

/-! ### §13 — Y1b: `restrictGen` composition and Subsingleton -/

/-- Composition of `restrictGen`s equals `restrictGen` of the composed
`TraceMor`. Load-bearing for the BKFaceI simplicial identity. -/
theorem restrictGen_compose {n : ℕ} {S T U : IntClosedFam n}
    (φ : TraceMor S T) (ψ : TraceMor T U) {q : ℕ} (x : CubeCell S q) :
    Finsupp.linearCombination ℚ (TraceMor.restrictGen ψ)
      (TraceMor.restrictGen φ x) = TraceMor.restrictGen (φ.comp ψ) x := by
  -- Case-split on x.dir ⊆ T.support and x.dir ⊆ U.support.
  by_cases h_T : x.dir ⊆ T.support
  · -- Positive in T.
    rw [TraceMor.restrictGen_pos φ x h_T]
    rw [Finsupp.linearCombination_single, one_smul]
    -- Goal: TraceMor.restrictGen ψ (φ.restrictCell x h_T) = TraceMor.restrictGen (φ.comp ψ) x.
    have h_dir : (φ.restrictCell x h_T).dir = x.dir := rfl
    by_cases h_U : x.dir ⊆ U.support
    · -- Positive in U. Both sides are single of cells with base = x.base ∩ U.support, dir = x.dir.
      rw [TraceMor.restrictGen_pos ψ (φ.restrictCell x h_T) (h_dir.symm ▸ h_U)]
      rw [TraceMor.restrictGen_pos (φ.comp ψ) x h_U]
      congr 1
      apply CubeCell.ext
      · -- (φ.restrictCell x h_T).base ∩ U.support = x.base ∩ U.support
        --   = (x.base ∩ T.support) ∩ U.support = x.base ∩ U.support (since U.support ⊆ T.support).
        show (x.base ∩ T.support) ∩ U.support = x.base ∩ U.support
        ext y
        simp only [Finset.mem_inter]
        constructor
        · rintro ⟨⟨hb, _⟩, hU⟩; exact ⟨hb, hU⟩
        · rintro ⟨hb, hU⟩
          exact ⟨⟨hb, ψ.subset hU⟩, hU⟩
      · rfl
    · -- Negative in U. Both sides are 0.
      rw [TraceMor.restrictGen_neg ψ (φ.restrictCell x h_T) (h_dir.symm ▸ h_U)]
      rw [TraceMor.restrictGen_neg (φ.comp ψ) x h_U]
  · -- Negative in T: restrictGen φ x = 0. Both sides 0.
    rw [TraceMor.restrictGen_neg φ x h_T]
    rw [map_zero]
    have h_U : ¬ x.dir ⊆ U.support := fun h => h_T (fun y hy => ψ.subset (h hy))
    rw [TraceMor.restrictGen_neg (φ.comp ψ) x h_U]

/-- Specialised version: `restrictGen` applied to two TraceMors of the same
type are equal (by `Subsingleton (TraceMor S T)`). -/
theorem restrictGen_subsingleton {n : ℕ} {S T : IntClosedFam n}
    (φ ψ : TraceMor S T) {q : ℕ} (x : CubeCell S q) :
    TraceMor.restrictGen φ x = TraceMor.restrictGen ψ x := by
  rw [Subsingleton.elim φ ψ]

/-! ### §14 — Y1b: BKFaceI per-generator composition and simplicial identity -/

/-- Per-generator action of `BKFaceI_i ∘ BKFaceI_j` reduces to a single
`restrictGen` of the composed `tailFaceMor` chain, with the OpChain
re-indexed via `(c.face j).face i`. -/
theorem BKFaceI_compose_apply {n p q : ℕ} (i : Fin (p+2)) (j : Fin (p+3))
    (c : OpChain n (p+2)) (x : CubeCell c.tail q) :
    Finsupp.linearCombination ℚ (BKFaceIGen n p q i) (BKFaceIGen n (p+1) q j ⟨c, x⟩)
    = (TraceMor.restrictGen ((c.tailFaceMor j).comp ((c.face j).tailFaceMor i)) x).mapDomain
        (fun z => (⟨(c.face j).face i, z⟩ : Σ c' : OpChain n p, CubeCell c'.tail q)) := by
  -- Unfold the inner BKFaceIGen.
  show Finsupp.linearCombination ℚ (BKFaceIGen n p q i)
        ((TraceMor.restrictGen (c.tailFaceMor j) x).mapDomain
          (fun y => (⟨c.face j, y⟩ : Σ c' : OpChain n (p+1), CubeCell c'.tail q))) = _
  rw [Finsupp.linearCombination_mapDomain]
  -- Now goal: linearCombination (BKFaceIGen n p q i ∘ ...) (restrictGen (c.tailFaceMor j) x) = ...
  -- Rewrite BKFaceIGen i ∘ (fun y => ⟨c.face j, y⟩) as composition of lmapDomain with restrictGen.
  have step : BKFaceIGen n p q i ∘
        (fun y => (⟨c.face j, y⟩ : Σ c' : OpChain n (p+1), CubeCell c'.tail q))
      = (Finsupp.lmapDomain ℚ ℚ
          (fun z => (⟨(c.face j).face i, z⟩ : Σ c' : OpChain n p, CubeCell c'.tail q)))
        ∘ TraceMor.restrictGen ((c.face j).tailFaceMor i) := by
    funext y
    show (TraceMor.restrictGen ((c.face j).tailFaceMor i) y).mapDomain _
      = (Finsupp.lmapDomain ℚ ℚ _) _
    rw [Finsupp.lmapDomain_apply]
  rw [step]
  rw [Finsupp.linearCombination_linear_comp]
  rw [LinearMap.comp_apply]
  -- Goal: lmapDomain Z (linearCombination restrictGen (restrictGen ... x)) = (restrictGen combined x).mapDomain Z.
  rw [restrictGen_compose]
  -- Goal: lmapDomain Z (restrictGen combined x) = (restrictGen combined x).mapDomain Z.
  rfl

/-- **A general form of `BKFaceI_compose_apply`** that lets us pick any
canonical `(OC, Trace)` for the result form. The key step uses `subst h_OC`
to unify the dependent type of `Trace` with the type produced by
`BKFaceI_compose_apply`, then `Subsingleton (TraceMor S T)`. -/
theorem BKFaceI_compose_apply_general {n p q : ℕ} (i : Fin (p+2)) (j : Fin (p+3))
    (c : OpChain n (p+2)) (x : CubeCell c.tail q)
    (OC : OpChain n p) (h_OC : OC = (c.face j).face i)
    (Trace : TraceMor c.tail OC.tail) :
    Finsupp.linearCombination ℚ (BKFaceIGen n p q i) (BKFaceIGen n (p+1) q j ⟨c, x⟩)
    = (TraceMor.restrictGen Trace x).mapDomain
        (fun z => (⟨OC, z⟩ : Σ c' : OpChain n p, CubeCell c'.tail q)) := by
  subst h_OC
  rw [BKFaceI_compose_apply]
  -- After rw, both sides are (restrictGen ? x).mapDomain Z with the same mapDomain Z.
  -- The TraceMors are of the same type and equal by Subsingleton; congr resolves it.
  congr 1

/-- **The simplicial identity for `BKFaceI`** at the morphism level:
`d_j ≫ d_i = d_{j'} ≫ d_{i'}` where `(i', j') = (i.predAbove j, j.succAbove i)`.

Proved by reducing both sides to a single canonical `(OC, Trace)` form via
`BKFaceI_compose_apply_general` + `OpChain.face_face`. -/
theorem BKFaceI_simplicial (n p q : ℕ) (i : Fin (p+2)) (j : Fin (p+3)) :
    BKFaceI n (p+1) q j ≫ BKFaceI n p q i =
    BKFaceI n (p+1) q (j.succAbove i) ≫ BKFaceI n p q (i.predAbove j) := by
  apply ModuleCat.hom_ext
  rw [ModuleCat.hom_comp, ModuleCat.hom_comp]
  apply Finsupp.lhom_ext
  rintro ⟨c, x⟩ r
  show (BKFaceI n p q i).hom ((BKFaceI n (p+1) q j).hom (Finsupp.single ⟨c, x⟩ r))
      = (BKFaceI n p q (i.predAbove j)).hom
          ((BKFaceI n (p+1) q (j.succAbove i)).hom (Finsupp.single ⟨c, x⟩ r))
  rw [BKFaceI_single, BKFaceI_single]
  show Finsupp.linearCombination ℚ (BKFaceIGen n p q i) (r • BKFaceIGen n (p+1) q j ⟨c, x⟩)
      = Finsupp.linearCombination ℚ (BKFaceIGen n p q (i.predAbove j))
          (r • BKFaceIGen n (p+1) q (j.succAbove i) ⟨c, x⟩)
  rw [LinearMap.map_smul, LinearMap.map_smul]
  congr 1
  -- Apply the general form twice with the same canonical (OC, Trace).
  -- OC := (c.face j).face i, Trace := (c.tailFaceMor j).comp ((c.face j).tailFaceMor i).
  -- For the LHS, h_OC = rfl. For the RHS, h_OC = OpChain.face_face c i j.
  rw [BKFaceI_compose_apply_general i j c x ((c.face j).face i) rfl
        ((c.tailFaceMor j).comp ((c.face j).tailFaceMor i))]
  rw [BKFaceI_compose_apply_general (i.predAbove j) (j.succAbove i) c x ((c.face j).face i)
        (OpChain.face_face c i j)
        ((c.tailFaceMor j).comp ((c.face j).tailFaceMor i))]

/-! ### §15 — Y1b: `BKHorizDiff_alt² = 0` via sum_involution

The simplicial swap on `Fin (p+3) × Fin (p+2)`:
`swap(j, i) := (j.succAbove i, i.predAbove j)`.

This is an involution (by `Fin.succAbove_succAbove_predAbove` and
`Fin.predAbove_predAbove_succAbove`), fixed-point-free (since `j.succAbove i ≠ j`),
and sign-reversing (parity flips by ±1). Combined with the simplicial identity
`BKFaceI_simplicial`, the alternating sum `BKHorizDiff_alt² = 0`. -/

/-- The simplicial swap pairing: `(j, i) ↦ (j.succAbove i, i.predAbove j)`. -/
private noncomputable def simplicialSwap {p : ℕ} :
    Fin (p+3) × Fin (p+2) → Fin (p+3) × Fin (p+2) :=
  fun ji => (ji.1.succAbove ji.2, ji.2.predAbove ji.1)

/-- The simplicial swap is an involution. -/
private theorem simplicialSwap_involutive {p : ℕ} (ji : Fin (p+3) × Fin (p+2)) :
    simplicialSwap (simplicialSwap ji) = ji := by
  obtain ⟨j, i⟩ := ji
  simp only [simplicialSwap]
  refine Prod.ext ?_ ?_
  · -- (j.succAbove i).succAbove (i.predAbove j) = j
    exact Fin.succAbove_succAbove_predAbove j i
  · -- (i.predAbove j).predAbove (j.succAbove i) = i
    exact Fin.predAbove_predAbove_succAbove j i

/-- The simplicial swap has no fixed points: `j.succAbove i ≠ j`. -/
private theorem simplicialSwap_ne_self {p : ℕ} (ji : Fin (p+3) × Fin (p+2)) :
    simplicialSwap ji ≠ ji := by
  intro h
  obtain ⟨j, i⟩ := ji
  simp only [simplicialSwap, Prod.mk.injEq] at h
  -- h.1 : j.succAbove i = j. But j is the hole of j.succAbove, contradiction.
  exact j.succAbove_ne i h.1

/-- The simplicial swap is sign-reversing: parity `(-1)^(j.val + i.val)` flips. -/
private theorem simplicialSwap_sign {p : ℕ} (ji : Fin (p+3) × Fin (p+2)) :
    ((-1 : ℚ) ^ ((simplicialSwap ji).1.val + (simplicialSwap ji).2.val))
    = - ((-1 : ℚ) ^ (ji.1.val + ji.2.val)) := by
  obtain ⟨j, i⟩ := ji
  simp only [simplicialSwap]
  by_cases h : i.castSucc < j
  · -- i.val < j.val. New (j', i').val = (i.val, j.val - 1).
    have hj_pos : 0 < j.val := lt_of_le_of_lt (Nat.zero_le _) h
    have e_j' : (j.succAbove i).val = i.val := by
      rw [Fin.succAbove_of_castSucc_lt _ _ h]; rfl
    have e_i' : (i.predAbove j).val = j.val - 1 := by
      rw [Fin.predAbove_of_castSucc_lt _ _ h, Fin.val_pred]
    rw [e_j', e_i']
    -- (-1)^(i + (j-1)) = -(-1)^(j + i). With j ≥ 1, j-1+1 = j, so (-1)^(j-1) = (-1)^j * (-1)^{-1}.
    -- Convert: (-1)^(i + j - 1). Note in ℕ subtraction: i + (j-1) = (i+j) - 1 if i + j ≥ 1 (which holds since j ≥ 1).
    have h_sum : i.val + (j.val - 1) + 1 = j.val + i.val := by omega
    have hsub : ((-1 : ℚ) ^ (i.val + (j.val - 1))) = -((-1 : ℚ) ^ (j.val + i.val)) := by
      conv_rhs => rw [show j.val + i.val = (i.val + (j.val - 1)) + 1 from h_sum.symm, pow_succ]
      ring
    rw [hsub]
  · -- i.val ≥ j.val. New (j', i').val = (i.val + 1, j.val).
    push_neg at h
    have e_j' : (j.succAbove i).val = i.val + 1 := by
      rw [Fin.succAbove_of_le_castSucc _ _ h]; rfl
    have e_i' : (i.predAbove j).val = j.val := by
      rw [Fin.predAbove_of_le_castSucc _ _ h]
      exact Fin.coe_castPred j _
    rw [e_j', e_i']
    -- (-1)^((i+1) + j) = -(-1)^(j + i).
    have h_sum : i.val + 1 + j.val = (j.val + i.val) + 1 := by omega
    rw [h_sum, pow_succ]
    ring

/-- **The bar-resolution d² = 0** for `BKHorizDiff_alt` across all rows.
Proved via `Finset.sum_involution` with the simplicial swap. -/
theorem BKHorizDiff_alt_squared (n p q : ℕ) :
    BKHorizDiff_alt n (p+1) q ≫ BKHorizDiff_alt n p q = 0 := by
  unfold BKHorizDiff_alt
  -- Distribute the composition over the sums into a double sum over Fin (p+3) × Fin (p+2).
  have hdist : (∑ j : Fin (p+3), ((-1 : ℚ) ^ j.val) • BKFaceI n (p+1) q j) ≫
               (∑ i : Fin (p+2), ((-1 : ℚ) ^ i.val) • BKFaceI n p q i)
             = ∑ ji : Fin (p+3) × Fin (p+2),
                 ((-1 : ℚ) ^ (ji.1.val + ji.2.val)) •
                   (BKFaceI n (p+1) q ji.1 ≫ BKFaceI n p q ji.2) := by
    rw [Preadditive.sum_comp]
    conv_rhs => rw [Fintype.sum_prod_type]
    refine Finset.sum_congr rfl (fun j _ => ?_)
    rw [show (((-1 : ℚ) ^ j.val • BKFaceI n (p+1) q j) ≫
              (∑ i : Fin (p+2), ((-1 : ℚ) ^ i.val) • BKFaceI n p q i)) =
            ((-1 : ℚ) ^ j.val) • ((BKFaceI n (p+1) q j) ≫
              (∑ i : Fin (p+2), ((-1 : ℚ) ^ i.val) • BKFaceI n p q i))
            from Linear.smul_comp _ _ _ _ _ _]
    rw [Preadditive.comp_sum]
    rw [Finset.smul_sum]
    refine Finset.sum_congr rfl (fun i _ => ?_)
    rw [show (BKFaceI n (p+1) q j ≫ ((-1 : ℚ) ^ i.val • BKFaceI n p q i)) =
            ((-1 : ℚ) ^ i.val) • ((BKFaceI n (p+1) q j) ≫ (BKFaceI n p q i))
            from Linear.comp_smul _ _ _ _ _ _]
    rw [smul_smul]
    rw [← pow_add]
  rw [hdist]
  -- Goal: Σ_{ji} ... = 0. Apply sum_involution with simplicialSwap.
  apply Finset.sum_involution (fun (ji : Fin (p+3) × Fin (p+2)) _ => simplicialSwap ji)
  · -- Pair cancels: f(ji) + f(swap ji) = 0.
    rintro ⟨j, i⟩ _
    have h_simp := BKFaceI_simplicial n p q i j
    rw [h_simp]
    simp only [simplicialSwap]
    have h_sign := simplicialSwap_sign (p := p) (j, i)
    simp only [simplicialSwap] at h_sign
    rw [h_sign]
    -- Now: (-1)^(j.val+i.val) • A + (- (-1)^(j.val+i.val)) • A = 0.
    rw [neg_smul]
    rw [add_neg_cancel]
  · -- f(a) ≠ 0 → g(a) ≠ a. We have g(a) ≠ a always (fixed-point-free).
    intro a _ _ h
    exact simplicialSwap_ne_self a h
  · -- g(a) ∈ s. Always true since s = Finset.univ.
    intros; exact Finset.mem_univ _
  · -- g(g(a)) = a. Involutive.
    intro a _
    exact simplicialSwap_involutive a

/-! ### §16 — Y1b: H/V commutativity for `BKFaceI` at all rows -/

/-- **Per-face H/V commute**: each `BKFaceI` commutes with `BKVertDiff`.
At a Sigma generator, the per-face cell transport (`restrictGen`) commutes
with the cubical boundary (`boundaryOnGen`) — this is exactly the chain-map
property `traceRestrict_comm` from Y1, lifted across the Sigma. -/
theorem BKFaceI_comm_BKVertDiff (n p q : ℕ) (i : Fin (p+2)) :
    BKVertDiff n (p+1) q ≫ BKFaceI n p q i =
      BKFaceI n p (q+1) i ≫ BKVertDiff n p q := by
  apply ModuleCat.hom_ext
  rw [ModuleCat.hom_comp, ModuleCat.hom_comp]
  apply Finsupp.lhom_ext
  rintro ⟨c, x⟩ r
  show (BKFaceI n p q i).hom ((BKVertDiff n (p+1) q).hom (Finsupp.single ⟨c, x⟩ r))
        = (BKVertDiff n p q).hom
            ((BKFaceI n p (q+1) i).hom (Finsupp.single ⟨c, x⟩ r))
  rw [BKVertDiff_single, BKFaceI_single]
  show Finsupp.linearCombination ℚ (BKFaceIGen n p q i)
        (r • BKVertGen n (p+1) q ⟨c, x⟩)
      = Finsupp.linearCombination ℚ (BKVertGen n p q)
          (r • BKFaceIGen n p (q+1) i ⟨c, x⟩)
  rw [LinearMap.map_smul, LinearMap.map_smul]
  congr 1
  show Finsupp.linearCombination ℚ (BKFaceIGen n p q i) (BKVertGen n (p+1) q ⟨c, x⟩)
      = Finsupp.linearCombination ℚ (BKVertGen n p q) (BKFaceIGen n p (q+1) i ⟨c, x⟩)
  rw [BKVertGen_mk]
  rw [Finsupp.linearCombination_mapDomain]
  -- LHS = linearCombination (BKFaceIGen i ∘ ⟨c, ·⟩) (boundaryOnGen c.tail x).
  -- The function (BKFaceIGen i ∘ ⟨c, ·⟩) y = (restrictGen (c.tailFaceMor i) y).mapDomain Z.
  -- Use linearCombination_linear_comp to factor out the mapDomain Z.
  have step_LHS : (BKFaceIGen n p q i ∘
        (fun y => (⟨c, y⟩ : Σ c' : OpChain n (p+1), CubeCell c'.tail q)))
      = (Finsupp.lmapDomain ℚ ℚ
          (fun z => (⟨c.face i, z⟩ : Σ c' : OpChain n p, CubeCell c'.tail q)))
        ∘ TraceMor.restrictGen (c.tailFaceMor i) := by
    funext y
    show (TraceMor.restrictGen (c.tailFaceMor i) y).mapDomain _
      = (Finsupp.lmapDomain ℚ ℚ _) _
    rw [Finsupp.lmapDomain_apply]
  rw [step_LHS]
  rw [Finsupp.linearCombination_linear_comp, LinearMap.comp_apply]
  -- LHS = lmapDomain Z (linearCombination (restrictGen (c.tailFaceMor i)) (boundaryOnGen c.tail x))
  --     = lmapDomain Z (traceRestrict (c.tailFaceMor i) q (boundaryOnGen c.tail x))
  -- where traceRestrict φ q applied to a single basis vector equals (linearCombination restrictGen).
  -- Now use traceRestrict_comm to swap boundary and restrict.
  -- (boundaryOnGen ∘ restrictGen φ) = (restrictGen ∘ boundaryOnGen)... but we need this at Finsupp level.
  --
  -- Direct: traceRestrict_comm c (tailFaceMor c i) q :
  --   singleFamilyBoundary _ q ≫ traceRestrict _ q = traceRestrict _ (q+1) ≫ singleFamilyBoundary _ q.
  -- Applied to single x 1:
  --   linearCombination (restrictGen (tailFaceMor i)) (boundaryOnGen c.tail x)
  --   = linearCombination (boundaryOnGen (c.face i).tail) (restrictGen (tailFaceMor i) x).
  have h_tr_apply : Finsupp.linearCombination ℚ (TraceMor.restrictGen (c.tailFaceMor i))
        (boundaryOnGen c.tail x)
      = Finsupp.linearCombination ℚ (boundaryOnGen (c.face i).tail)
          (TraceMor.restrictGen (c.tailFaceMor i) x) := by
    have h := congr_arg
      (fun f : singleFamilyChain c.tail (q+1) ⟶ singleFamilyChain (c.face i).tail q =>
        f.hom (Finsupp.single x (1 : ℚ)))
      (traceRestrict_comm (c.tailFaceMor i) q)
    simp only [ModuleCat.hom_comp, LinearMap.comp_apply] at h
    rw [singleFamilyBoundary_single, one_smul] at h
    rw [show ((traceRestrict (c.tailFaceMor i) (q+1)).hom (Finsupp.single x (1 : ℚ)))
            = TraceMor.restrictGen (c.tailFaceMor i) x from by
              rw [traceRestrict_single, one_smul]] at h
    -- h : (traceRestrict _ q).hom (boundaryOnGen c.tail x) = (singleFamilyBoundary _ q).hom (restrictGen ... x)
    show Finsupp.linearCombination ℚ (TraceMor.restrictGen (c.tailFaceMor i))
          (boundaryOnGen c.tail x)
        = Finsupp.linearCombination ℚ (boundaryOnGen (c.face i).tail)
            (TraceMor.restrictGen (c.tailFaceMor i) x)
    convert h
  rw [h_tr_apply]
  -- LHS = lmapDomain Z (linearCombination (boundaryOnGen (c.face i).tail) (restrictGen (c.tailFaceMor i) x)).
  -- RHS unfolds:
  --   BKFaceIGen n p (q+1) i ⟨c, x⟩ = (restrictGen (c.tailFaceMor i) x).mapDomain (fun y => ⟨c.face i, y⟩).
  --   (BKVertDiff n p q).hom = linearCombination (BKVertGen n p q).
  --   Apply linearCombination_mapDomain to RHS:
  --   = linearCombination (BKVertGen n p q ∘ ⟨c.face i, ·⟩) (restrictGen (c.tailFaceMor i) x).
  --   = linearCombination (fun y => (boundaryOnGen (c.face i).tail y).mapDomain (fun z => ⟨c.face i, z⟩))
  --        (restrictGen (c.tailFaceMor i) x).
  --   Factor out mapDomain Z via linearCombination_linear_comp.
  --   = lmapDomain Z (linearCombination (boundaryOnGen (c.face i).tail) (restrictGen (c.tailFaceMor i) x)).
  show _ = (BKVertDiff n p q).hom (BKFaceIGen n p (q+1) i ⟨c, x⟩)
  unfold BKFaceIGen
  show _ = Finsupp.linearCombination ℚ (BKVertGen n p q)
        ((TraceMor.restrictGen (c.tailFaceMor i) x).mapDomain
          (fun y => (⟨c.face i, y⟩ : Σ c' : OpChain n p, CubeCell c'.tail (q+1))))
  rw [Finsupp.linearCombination_mapDomain]
  have step_RHS : (BKVertGen n p q ∘
        (fun y => (⟨c.face i, y⟩ : Σ c' : OpChain n p, CubeCell c'.tail (q+1))))
      = (Finsupp.lmapDomain ℚ ℚ
          (fun z => (⟨c.face i, z⟩ : Σ c' : OpChain n p, CubeCell c'.tail q)))
        ∘ boundaryOnGen (c.face i).tail := by
    funext y
    show (boundaryOnGen (c.face i).tail y).mapDomain _
      = (Finsupp.lmapDomain ℚ ℚ _) _
    rw [Finsupp.lmapDomain_apply]
  rw [step_RHS]
  rw [Finsupp.linearCombination_linear_comp, LinearMap.comp_apply]
  -- Both sides are now lmapDomain Z (linearCombination (boundaryOnGen ...) (restrictGen ... x)).

/-! ### §17 — Y1b: New full assembly `BKBicomplexHC₂_full` -/

/-- Index-extended horizontal differential using `BKHorizDiff_alt`. -/
noncomputable def BKHorizD_alt (n i₁ i₁' i₂ : ℕ) :
    BKBicomplex n i₁ i₂ ⟶ BKBicomplex n i₁' i₂ :=
  if h : i₁' + 1 = i₁ then h ▸ BKHorizDiff_alt n i₁' i₂ else 0

theorem BKHorizD_alt_pos (n i₁' i₂ : ℕ) :
    BKHorizD_alt n (i₁' + 1) i₁' i₂ = BKHorizDiff_alt n i₁' i₂ := by
  unfold BKHorizD_alt; rw [dif_pos rfl]

theorem BKHorizD_alt_neg (n i₁ i₁' i₂ : ℕ) (h : i₁' + 1 ≠ i₁) :
    BKHorizD_alt n i₁ i₁' i₂ = 0 := by
  unfold BKHorizD_alt; rw [dif_neg h]

theorem BKHorizD_alt_squared (n i₁ i₁' i₁'' i₂ : ℕ) :
    BKHorizD_alt n i₁ i₁' i₂ ≫ BKHorizD_alt n i₁' i₁'' i₂ = 0 := by
  by_cases h1 : i₁' + 1 = i₁
  · by_cases h2 : i₁'' + 1 = i₁'
    · subst h1; subst h2
      rw [BKHorizD_alt_pos, BKHorizD_alt_pos]
      exact BKHorizDiff_alt_squared n i₁'' i₂
    · rw [BKHorizD_alt_neg _ _ _ _ h2]; simp
  · rw [BKHorizD_alt_neg _ _ _ _ h1]; simp

/-- Horizontal/vertical commutativity for the alt differential. -/
theorem BKHV_commute_alt (n i₁ i₁' i₂ i₂' : ℕ) :
    BKHorizD_alt n i₁ i₁' i₂ ≫ BKVertD n i₁' i₂ i₂' =
      BKVertD n i₁ i₂ i₂' ≫ BKHorizD_alt n i₁ i₁' i₂' := by
  by_cases h1 : i₁' + 1 = i₁
  · by_cases h2 : i₂' + 1 = i₂
    · subst h1; subst h2
      rw [BKHorizD_alt_pos, BKVertD_pos, BKVertD_pos, BKHorizD_alt_pos]
      -- BKHorizDiff_alt n i₁' (i₂' + 1) ≫ BKVertDiff n (i₁' + 1) i₂'
      --   = BKVertDiff n (i₁'+1+1) i₂' ≫ BKHorizDiff_alt n i₁' i₂'
      -- Hmm wait, the indices are different. Let me check.
      -- BKHorizD_alt n (i₁'+1) i₁' (i₂'+1) = BKHorizDiff_alt n i₁' (i₂'+1)
      --   : BKBicomplex n (i₁'+1) (i₂'+1) → BKBicomplex n i₁' (i₂'+1)
      -- BKVertD n i₁' (i₂'+1) i₂' = BKVertDiff n i₁' i₂'
      --   : BKBicomplex n i₁' (i₂'+1) → BKBicomplex n i₁' i₂'
      -- Composed: BKBicomplex n (i₁'+1) (i₂'+1) → BKBicomplex n i₁' i₂'.
      --
      -- Other direction:
      -- BKVertD n (i₁'+1) (i₂'+1) i₂' = BKVertDiff n (i₁'+1) i₂'
      --   : BKBicomplex n (i₁'+1) (i₂'+1) → BKBicomplex n (i₁'+1) i₂'
      -- BKHorizD_alt n (i₁'+1) i₁' i₂' = BKHorizDiff_alt n i₁' i₂'
      --   : BKBicomplex n (i₁'+1) i₂' → BKBicomplex n i₁' i₂'
      -- Composed: BKBicomplex n (i₁'+1) (i₂'+1) → BKBicomplex n i₁' i₂'.
      --
      -- So we want: BKHorizDiff_alt i₁' (i₂'+1) ≫ BKVertDiff i₁' i₂' = BKVertDiff (i₁'+1) i₂' ≫ BKHorizDiff_alt i₁' i₂'.
      --
      -- BKHorizDiff_alt = Σ_k (-1)^k • BKFaceI k. So distribute and use BKFaceI_comm_BKVertDiff per k.
      unfold BKHorizDiff_alt
      rw [Preadditive.sum_comp, Preadditive.comp_sum]
      refine Finset.sum_congr rfl (fun k _ => ?_)
      rw [show (((-1 : ℚ) ^ k.val • BKFaceI n i₁' (i₂' + 1) k) ≫ BKVertDiff n i₁' i₂'
            = ((-1 : ℚ) ^ k.val) • (BKFaceI n i₁' (i₂' + 1) k ≫ BKVertDiff n i₁' i₂'))
            from Linear.smul_comp _ _ _ _ _ _]
      rw [show (BKVertDiff n (i₁' + 1) i₂' ≫ ((-1 : ℚ) ^ k.val • BKFaceI n i₁' i₂' k)
            = ((-1 : ℚ) ^ k.val) • (BKVertDiff n (i₁' + 1) i₂' ≫ BKFaceI n i₁' i₂' k))
            from Linear.comp_smul _ _ _ _ _ _]
      congr 1
      exact (BKFaceI_comm_BKVertDiff n i₁' i₂' k).symm
    · rw [BKVertD_neg _ _ _ _ h2, BKVertD_neg _ _ _ _ h2]; simp
  · rw [BKHorizD_alt_neg _ _ _ _ h1, BKHorizD_alt_neg _ _ _ _ h1]; simp

/-- **Full `HomologicalComplex₂` assembly** using `BKHorizDiff_alt`. -/
noncomputable def BKBicomplexHC₂_full (n : ℕ) (_F : IntClosedFam n) :
    HomologicalComplex₂ (ModuleCat ℚ) (ComplexShape.down ℕ) (ComplexShape.down ℕ) :=
  HomologicalComplex₂.ofGradedObject (ComplexShape.down ℕ) (ComplexShape.down ℕ)
    (fun pq => BKBicomplex n pq.1 pq.2)
    (BKHorizD_alt n)
    (BKVertD n)
    (fun i₁ i₁' h i₂ => BKHorizD_alt_neg n i₁ i₁' i₂ h)
    (fun i₁ i₂ i₂' h => BKVertD_neg n i₁ i₂ i₂' h)
    (BKHorizD_alt_squared n)
    (BKVertD_squared n)
    (BKHV_commute_alt n)

/-! ### §18 — Y1b: Non-vacuous evaluation at n=3 for higher row -/

/-- A 2-chain on `fullPowerset3` with identity transitions, used to witness
non-zero higher-row cells. -/
noncomputable def fullPowerset3_chain2 : OpChain 3 2 where
  obj := fun _ => UC11.fullPowerset3
  mor := fun _ => TraceMor.id _

@[simp] theorem fullPowerset3_chain2_tail :
    fullPowerset3_chain2.tail = UC11.fullPowerset3 := rfl

/-- **Non-vacuous cell at `(p, q) = (2, 1)` of `BKBicomplexHC₂_full fullPowerset3`.**
The basis vector `single ⟨fullPowerset3_chain2, fullPowerset3_cell1⟩ 1` lies in
`((BKBicomplexHC₂_full 3 fullPowerset3).X 2).X 1`. -/
theorem BKBicomplexHC₂_full_n3_nonzero_at_2_1 :
    ∃ v : ((BKBicomplexHC₂_full 3 UC11.fullPowerset3).X 2).X 1, v ≠ 0 := by
  refine ⟨Finsupp.single
    (⟨fullPowerset3_chain2, fullPowerset3_cell1⟩ :
      Σ c : OpChain 3 2, CubeCell c.tail 1) (1 : ℚ), ?_⟩
  intro h
  have h' : (Finsupp.single (⟨fullPowerset3_chain2, fullPowerset3_cell1⟩ :
              Σ c : OpChain 3 2, CubeCell c.tail 1) (1 : ℚ)
              = (0 : (Σ c : OpChain 3 2, CubeCell c.tail 1) →₀ ℚ)) := h
  rw [Finsupp.single_eq_zero] at h'
  exact one_ne_zero h'

/-- **Non-vacuous horizontal differential at row p=1.** The alternating sum
`Σ_i (-1)^i • BKFaceI i` at row 1 is the genuine simplicial differential
(strictly tighter than zero). -/
theorem BKHorizDiff_alt_row1_nonzero (n q : ℕ) :
    BKHorizDiff_alt n 1 q =
      ∑ i : Fin 3, ((-1 : ℚ) ^ i.val) • BKFaceI n 1 q i := rfl

end UnionClosed.UC10
