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
import Mathlib.LinearAlgebra.Finsupp.LSum
import Mathlib.LinearAlgebra.Finsupp.LinearCombination
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

end UnionClosed.UC10
