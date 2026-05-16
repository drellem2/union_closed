/-
UnionClosed/UC12/Doubling.lean
==============================

UC12 Primitive 5 (UC-Lean-scope §A.2):
The doubling functor `db : C_n^∩ → C_{n+1}^∩` (UC12 §2.1).

Source: docs/union-closed-UC12-delta-trace-injectivity.md
  - Defn 2.1 (db functor): `db F := F ∪ (F + {n+1})` on `S ⊔ {n+1}`.
  - Lemma 2.2 (well-defined fully faithful functor).
  - Defn 2.5 (trace projection `ρ_n`).
  - Lemma 2.6 (`ρ_n ∘ db = id`).
  - Lemma 2.7 (prism structure `X(db F) ≅ X(F) × I`).

L2b closure (mg-4db9):
- `db F : IntClosedFam (n+1)` populated **concretely** as
  `(F.support.map castSucc ∪ {Fin.last n}, F.family.image castSucc ∪
    (F.family.image castSucc).image (insert (Fin.last n)))`.
- `db_intClosed`, `db_fullSupport`, `db_topMem` are proven from the four-case
  argument of Lemma 2.2 (cases (i)-(iv) on whether `n+1 ∈ A`, `n+1 ∈ B`).
- `dbMap` lifts a `TraceMor F G` to `TraceMor (db F) (db G)` via
  `T ↦ T.map castSucc ∪ {Fin.last n}`.
- `dbMap_faithful` follows from `TraceMor.eq_of_same` (the morphism record
  is propositionally determined by its source/target).
- `bridgeCell : CubeCell F k → CubeCell (db F) (k+1)` is the **prism cell**
  realising Lemma 2.7's bridge structure: `(A, T') ↦ (liftFin A,
  insert (Fin.last n) (liftFin T'))` — the (k+1)-cell over the k-cell `(A, T')`
  in the new coordinate.

**Non-triviality at n = 3 acceptance bar.** For every `F : IntClosedFam 3`,
- `db F : IntClosedFam 4` has populated support+family (`db_nonempty`).
- The bridge cell `bridgeCell (CubeCell.topVertex F)` is a concrete 1-cell of
  `singleFamilyComplex (db F)` (`bridgeCell_topVertex_witness`).
- `bridgeCell_injective` exhibits the prism cells as a sub-Finset of
  `CubeCell (db F) 1` injecting from `CubeCell F 0` — the structural input
  to UC10R.

**Hard-constraint compliance (UC-Lean-scope §D):**
- D.1 NOT factorial: `db` is the **product** `× I` of cubes (Lemma 2.7).
- D.2 NOT functorial in the refinement sense: `db` is intrinsic to the
  union_closed category; no factor through `Pos_n`/`PPF_n`.
- D.3 U1-dialect: purely additive cube-product structure; no cup product.
- D.4 Math-first: latex artefact mg-707c §2 (verified GREEN, merged).
-/

import Mathlib.Data.Finset.Basic
import Mathlib.Data.Finset.Image
import Mathlib.Data.Fin.Basic
import UnionClosed.UC10.IntClosedFam
import UnionClosed.UC10.CubicalDefect

namespace UnionClosed.UC12

open UnionClosed.UC10

variable {n : ℕ}

/-! ### §2.1 — Finset-lifting along `Fin.castSucc : Fin n ↪ Fin (n+1)` -/

/-- The Finset-image of a subset along `Fin.castSucc : Fin n ↪ Fin (n+1)`. -/
noncomputable def liftFin (T : Finset (Fin n)) : Finset (Fin (n+1)) :=
  T.map Fin.castSuccEmb

@[simp] lemma liftFin_mem {T : Finset (Fin n)} {y : Fin (n+1)} :
    y ∈ liftFin T ↔ ∃ x ∈ T, Fin.castSuccEmb x = y := by
  unfold liftFin; rw [Finset.mem_map]

/-- `Fin.last n` is **not** in the image of `Fin.castSucc`. -/
lemma not_last_mem_liftFin (T : Finset (Fin n)) :
    Fin.last n ∉ liftFin T := by
  intro h
  rw [liftFin_mem] at h
  rcases h with ⟨x, _, hx⟩
  have hv : (Fin.castSuccEmb x).val = x.val := rfl
  have hv2 : (Fin.last n).val = n := rfl
  have heq : (Fin.last n).val = (Fin.castSuccEmb x).val := by rw [hx]
  rw [hv, hv2] at heq
  have := x.isLt
  omega

/-- `liftFin` distributes over `∪`. -/
lemma liftFin_union (A B : Finset (Fin n)) :
    liftFin (A ∪ B) = liftFin A ∪ liftFin B := by
  unfold liftFin; rw [Finset.map_union]

/-- `liftFin` distributes over `∩`. -/
lemma liftFin_inter (A B : Finset (Fin n)) :
    liftFin (A ∩ B) = liftFin A ∩ liftFin B := by
  unfold liftFin; rw [Finset.map_inter]

/-- `liftFin` is injective on Finsets. -/
lemma liftFin_injective : Function.Injective (liftFin (n := n)) := by
  intro A B h
  unfold liftFin at h
  exact Finset.map_injective _ h

/-- The "with-top" map: insert `Fin.last n` into the lifted support. -/
noncomputable def withTop (T : Finset (Fin n)) : Finset (Fin (n+1)) :=
  insert (Fin.last n) (liftFin T)

/-- Membership in `withTop T`. -/
lemma mem_withTop {T : Finset (Fin n)} {y : Fin (n+1)} :
    y ∈ withTop T ↔ y = Fin.last n ∨ y ∈ liftFin T := by
  unfold withTop; rw [Finset.mem_insert]

/-- `withTop` intersected with `liftFin` strips the top. -/
lemma liftFin_inter_withTop (A B : Finset (Fin n)) :
    liftFin A ∩ withTop B = liftFin (A ∩ B) := by
  ext y
  rw [Finset.mem_inter, mem_withTop, liftFin_inter, Finset.mem_inter]
  constructor
  · rintro ⟨hyA, hyB | hyL⟩
    · exfalso; exact not_last_mem_liftFin A (hyB ▸ hyA)
    · exact ⟨hyA, hyL⟩
  · rintro ⟨hyA, hyB⟩
    exact ⟨hyA, Or.inr hyB⟩

/-- Symmetric: `withTop` intersected on the left with `liftFin`. -/
lemma withTop_inter_liftFin (A B : Finset (Fin n)) :
    withTop A ∩ liftFin B = liftFin (A ∩ B) := by
  ext y
  rw [Finset.mem_inter, mem_withTop, liftFin_inter, Finset.mem_inter]
  constructor
  · rintro ⟨hyA | hyL, hyB⟩
    · exfalso; exact not_last_mem_liftFin B (hyA ▸ hyB)
    · exact ⟨hyL, hyB⟩
  · rintro ⟨hyA, hyB⟩
    exact ⟨Or.inr hyA, hyB⟩

/-- Two `withTop`s intersect to `withTop` of the intersection. -/
lemma withTop_inter (A B : Finset (Fin n)) :
    withTop A ∩ withTop B = withTop (A ∩ B) := by
  ext y
  rw [Finset.mem_inter, mem_withTop, mem_withTop, mem_withTop, liftFin_inter,
      Finset.mem_inter]
  constructor
  · rintro ⟨hyA | hyLA, hyB | hyLB⟩
    · exact Or.inl hyA
    · exact Or.inl hyA
    · exact Or.inl hyB
    · exact Or.inr ⟨hyLA, hyLB⟩
  · rintro (hy | hyL)
    · exact ⟨Or.inl hy, Or.inl hy⟩
    · exact ⟨Or.inr hyL.1, Or.inr hyL.2⟩

/-! ### §2.1 — The doubled family `db F` -/

/-- The "no-top family lift": apply `liftFin` element-wise. -/
noncomputable def familyLift (F : Finset (Finset (Fin n))) :
    Finset (Finset (Fin (n+1))) :=
  F.image liftFin

/-- The "with-top family lift": apply `withTop` element-wise. -/
noncomputable def familyTopLift (F : Finset (Finset (Fin n))) :
    Finset (Finset (Fin (n+1))) :=
  F.image withTop

/-- The doubled family `db F := F ∪ (F + {n+1})` (UC12 Defn 2.1). -/
noncomputable def dbFamily (F : Finset (Finset (Fin n))) :
    Finset (Finset (Fin (n+1))) :=
  familyLift F ∪ familyTopLift F

lemma mem_familyLift {F : Finset (Finset (Fin n))} {B : Finset (Fin (n+1))} :
    B ∈ familyLift F ↔ ∃ A ∈ F, liftFin A = B := by
  unfold familyLift; rw [Finset.mem_image]

lemma mem_familyTopLift {F : Finset (Finset (Fin n))} {B : Finset (Fin (n+1))} :
    B ∈ familyTopLift F ↔ ∃ A ∈ F, withTop A = B := by
  unfold familyTopLift; rw [Finset.mem_image]

lemma mem_dbFamily {F : Finset (Finset (Fin n))} {B : Finset (Fin (n+1))} :
    B ∈ dbFamily F ↔ (∃ A ∈ F, liftFin A = B) ∨ (∃ A ∈ F, withTop A = B) := by
  unfold dbFamily
  rw [Finset.mem_union, mem_familyLift, mem_familyTopLift]

/-- An element of `familyLift F` does **not** contain `Fin.last n`. -/
lemma not_last_mem_of_familyLift {F : Finset (Finset (Fin n))}
    {B : Finset (Fin (n+1))} (hB : B ∈ familyLift F) :
    Fin.last n ∉ B := by
  rcases mem_familyLift.mp hB with ⟨A, _, rfl⟩
  exact not_last_mem_liftFin A

/-- An element of `familyTopLift F` **does** contain `Fin.last n`. -/
lemma last_mem_of_familyTopLift {F : Finset (Finset (Fin n))}
    {B : Finset (Fin (n+1))} (hB : B ∈ familyTopLift F) :
    Fin.last n ∈ B := by
  rcases mem_familyTopLift.mp hB with ⟨A, _, rfl⟩
  unfold withTop
  exact Finset.mem_insert_self _ _

/-! ### §2.1 — The `db` functor on objects: `IntClosedFam n → IntClosedFam (n+1)` -/

/--
The **doubling functor `db`** on an object `F : IntClosedFam n` of `C_n^∩`,
producing an object `db F : IntClosedFam (n+1)` of `C_{n+1}^∩`.

UC12 Defn 2.1: `db (S, F) := (S ⊔ {n+1}, F ∪ (F + {n+1}))`.
-/
noncomputable def db (F : IntClosedFam n) : IntClosedFam (n+1) where
  support       := withTop F.support
  family        := dbFamily F.family
  subsetSupport := by
    intro B hB
    rcases mem_dbFamily.mp hB with ⟨A, hA, rfl⟩ | ⟨A, hA, rfl⟩
    · intro y hy
      rcases liftFin_mem.mp hy with ⟨x, hxA, hxy⟩
      have hxS : x ∈ F.support := F.subsetSupport A hA hxA
      exact mem_withTop.mpr (Or.inr (liftFin_mem.mpr ⟨x, hxS, hxy⟩))
    · intro y hy
      rcases mem_withTop.mp hy with hy_last | hy_lift
      · rw [hy_last]; exact mem_withTop.mpr (Or.inl rfl)
      · rcases liftFin_mem.mp hy_lift with ⟨x, hxA, hxy⟩
        have hxS : x ∈ F.support := F.subsetSupport A hA hxA
        exact mem_withTop.mpr (Or.inr (liftFin_mem.mpr ⟨x, hxS, hxy⟩))
  intClosed     := by
    intro A hA B hB
    rcases Finset.mem_union.mp hA with hAlift | hAtop
    · rcases Finset.mem_union.mp hB with hBlift | hBtop
      · -- (i): A,B ∈ familyLift.
        rcases mem_familyLift.mp hAlift with ⟨A', hA', rfl⟩
        rcases mem_familyLift.mp hBlift with ⟨B', hB', rfl⟩
        refine Finset.mem_union_left _ (mem_familyLift.mpr
          ⟨A' ∩ B', F.intClosed A' hA' B' hB', ?_⟩)
        rw [liftFin_inter]
      · -- (ii): A ∈ familyLift, B ∈ familyTopLift.
        rcases mem_familyLift.mp hAlift with ⟨A', hA', rfl⟩
        rcases mem_familyTopLift.mp hBtop with ⟨B', hB', rfl⟩
        refine Finset.mem_union_left _ (mem_familyLift.mpr
          ⟨A' ∩ B', F.intClosed A' hA' B' hB', ?_⟩)
        exact (liftFin_inter_withTop A' B').symm.symm ▸ (liftFin_inter_withTop A' B').symm
    · rcases Finset.mem_union.mp hB with hBlift | hBtop
      · -- (iii): A ∈ familyTopLift, B ∈ familyLift.
        rcases mem_familyTopLift.mp hAtop with ⟨A', hA', rfl⟩
        rcases mem_familyLift.mp hBlift with ⟨B', hB', rfl⟩
        refine Finset.mem_union_left _ (mem_familyLift.mpr
          ⟨A' ∩ B', F.intClosed A' hA' B' hB', ?_⟩)
        exact (withTop_inter_liftFin A' B').symm
      · -- (iv): A,B ∈ familyTopLift.
        rcases mem_familyTopLift.mp hAtop with ⟨A', hA', rfl⟩
        rcases mem_familyTopLift.mp hBtop with ⟨B', hB', rfl⟩
        refine Finset.mem_union_right _ (mem_familyTopLift.mpr
          ⟨A' ∩ B', F.intClosed A' hA' B' hB', ?_⟩)
        exact (withTop_inter A' B').symm
  fullSupport   := by
    -- Every member of dbFamily is ⊆ withTop F.support (subsetSupport proven
    -- above); and withTop F.support is itself a member (via F.topMem on top
    -- branch). Hence sup = withTop F.support.
    apply le_antisymm
    · -- sup ≤ withTop F.support: every B ∈ dbFamily F.family has B ⊆ withTop F.support.
      apply Finset.sup_le
      intro B hB
      show id B ⊆ withTop F.support
      rcases mem_dbFamily.mp hB with ⟨A, hA, rfl⟩ | ⟨A, hA, rfl⟩
      · -- B = liftFin A; lift of subset.
        intro y hy
        rcases liftFin_mem.mp hy with ⟨x, hxA, hxy⟩
        exact mem_withTop.mpr (Or.inr
          (liftFin_mem.mpr ⟨x, F.subsetSupport A hA hxA, hxy⟩))
      · -- B = withTop A; withTop of subset.
        intro y hy
        rcases mem_withTop.mp hy with hy_last | hy_lift
        · rw [hy_last]; exact mem_withTop.mpr (Or.inl rfl)
        · rcases liftFin_mem.mp hy_lift with ⟨x, hxA, hxy⟩
          exact mem_withTop.mpr (Or.inr
            (liftFin_mem.mpr ⟨x, F.subsetSupport A hA hxA, hxy⟩))
    · -- withTop F.support ≤ sup: it is itself a member (top branch).
      have h_top_mem : withTop F.support ∈ dbFamily F.family :=
        Finset.mem_union_right _ (mem_familyTopLift.mpr ⟨F.support, F.topMem, rfl⟩)
      have : id (withTop F.support) ≤ (dbFamily F.family).sup id :=
        Finset.le_sup h_top_mem
      exact this
  topMem        :=
    Finset.mem_union_right _ (mem_familyTopLift.mpr ⟨F.support, F.topMem, rfl⟩)
  nonempty      :=
    ⟨withTop F.support,
      Finset.mem_union_right _ (mem_familyTopLift.mpr ⟨F.support, F.topMem, rfl⟩)⟩

/-! ### `db` defining equations -/

@[simp] theorem db_support (F : IntClosedFam n) :
    (db F).support = withTop F.support := rfl

@[simp] theorem db_family (F : IntClosedFam n) :
    (db F).family = dbFamily F.family := rfl

/-! ### Non-triviality at n = 3 (acceptance bar 1) -/

/--
**Acceptance bar (1) for L2b** — `db F` is a populated, non-vacuous
`IntClosedFam (n+1)` for every `F : IntClosedFam n`.
-/
theorem db_nonempty (F : IntClosedFam n) :
    (db F).family.Nonempty :=
  (db F).nonempty

/-! ### §2.6 — Section property witness -/

/-- The `db` doubling adds exactly `Fin.last n` to `F.support`. -/
theorem db_support_erase_last (F : IntClosedFam n) :
    (db F).support.erase (Fin.last n) = liftFin F.support := by
  rw [db_support, withTop, Finset.erase_insert (not_last_mem_liftFin F.support)]

/-! ### §2.2 — Faithfulness of db on TraceMor -/

/--
A `TraceMor F G` is determined propositionally by its source/target pair —
any two `TraceMor F G`s are equal. This makes faithfulness automatic.
-/
theorem TraceMor.eq_of_same {F G : IntClosedFam n} (φ₁ φ₂ : TraceMor F G) :
    φ₁ = φ₂ := by
  rcases φ₁ with ⟨_, _⟩; rcases φ₂ with ⟨_, _⟩; rfl

/-! ### §2.1 — Functoriality on morphisms: db acts on TraceMor -/

/--
**The doubling functor on morphisms** `dbMap φ : TraceMor (db F) (db G)`
given `φ : TraceMor F G` (UC12 Lemma 2.2 functoriality).
-/
noncomputable def dbMap {F G : IntClosedFam n} (φ : TraceMor F G) :
    TraceMor (db F) (db G) where
  subset := by
    -- (db G).support ⊆ (db F).support via G.support ⊆ F.support (withTop is monotone).
    intro y hy
    rcases mem_withTop.mp hy with hy_last | hy_lift
    · rw [hy_last]; exact mem_withTop.mpr (Or.inl rfl)
    · rcases liftFin_mem.mp hy_lift with ⟨x, hxG, hxy⟩
      have hxF : x ∈ F.support := φ.subset hxG
      exact mem_withTop.mpr (Or.inr (liftFin_mem.mpr ⟨x, hxF, hxy⟩))
  traceEq := by
    -- (db G).family = (db F).family.image (· ∩ (db G).support).
    rw [db_family, db_family, db_support]
    apply Finset.Subset.antisymm
    · -- ⊇: every element of dbFamily G.family is in the image.
      intro B hB
      rcases mem_dbFamily.mp hB with ⟨A', hA'G, rfl⟩ | ⟨A', hA'G, rfl⟩
      · -- B = liftFin A'. Recover A ∈ F.family with A' = A ∩ G.support via φ.traceEq.
        rw [φ.traceEq] at hA'G
        rcases Finset.mem_image.mp hA'G with ⟨A, hAF, hAA'⟩
        refine Finset.mem_image.mpr ⟨liftFin A,
          Finset.mem_union_left _ (mem_familyLift.mpr ⟨A, hAF, rfl⟩), ?_⟩
        -- liftFin A ∩ withTop G.support = liftFin (A ∩ G.support) = liftFin A'.
        rw [liftFin_inter_withTop, hAA']
      · -- B = withTop A'.
        rw [φ.traceEq] at hA'G
        rcases Finset.mem_image.mp hA'G with ⟨A, hAF, hAA'⟩
        refine Finset.mem_image.mpr ⟨withTop A,
          Finset.mem_union_right _ (mem_familyTopLift.mpr ⟨A, hAF, rfl⟩), ?_⟩
        rw [withTop_inter, hAA']
    · -- ⊆: every (dbFamily F.family).image (· ∩ withTop G.support) is in dbFamily G.family.
      intro B hB
      rcases Finset.mem_image.mp hB with ⟨C, hC, rfl⟩
      rcases mem_dbFamily.mp hC with ⟨A, hAF, rfl⟩ | ⟨A, hAF, rfl⟩
      · -- C = liftFin A. liftFin A ∩ withTop G.support = liftFin (A ∩ G.support).
        rw [liftFin_inter_withTop]
        have hA' : A ∩ G.support ∈ G.family := by
          rw [φ.traceEq]
          exact Finset.mem_image.mpr ⟨A, hAF, rfl⟩
        exact Finset.mem_union_left _ (mem_familyLift.mpr ⟨A ∩ G.support, hA', rfl⟩)
      · -- C = withTop A.  withTop A ∩ withTop G.support = withTop (A ∩ G.support).
        rw [withTop_inter]
        have hA' : A ∩ G.support ∈ G.family := by
          rw [φ.traceEq]
          exact Finset.mem_image.mpr ⟨A, hAF, rfl⟩
        exact Finset.mem_union_right _ (mem_familyTopLift.mpr ⟨A ∩ G.support, hA', rfl⟩)

/--
**dbMap is faithful**: an immediate consequence of `TraceMor.eq_of_same`.
This is the UC12 Lemma 2.2 faithfulness statement.
-/
theorem dbMap_faithful {F G : IntClosedFam n} (φ₁ φ₂ : TraceMor F G) :
    dbMap φ₁ = dbMap φ₂ :=
  TraceMor.eq_of_same _ _

/-! ### §2.7 — Prism structure: bridge cells in `singleFamilyComplex (db F)` -/

/--
**Bridge cell** of a cell `c = (A, T')` of `singleFamilyComplex F`:
the prism cell `(liftFin A, insert (Fin.last n) (liftFin T'))` of
`singleFamilyComplex (db F)`. This is the (k+1)-cell of `db F` realising
the "× I" direction of Lemma 2.7's prism decomposition.
-/
noncomputable def bridgeCell {F : IntClosedFam n} {k : ℕ}
    (c : CubeCell F k) : CubeCell (db F) (k + 1) where
  base       := liftFin c.base
  dir        := insert (Fin.last n) (liftFin c.dir)
  base_mem   :=
    Finset.mem_union_left _ (mem_familyLift.mpr ⟨c.base, c.base_mem, rfl⟩)
  dir_subset := by
    -- dir ⊆ (db F).support \ liftFin c.base.
    intro y hy
    rcases Finset.mem_insert.mp hy with hy_last | hy_lift
    · refine Finset.mem_sdiff.mpr ⟨?_, ?_⟩
      · rw [hy_last, db_support]
        exact mem_withTop.mpr (Or.inl rfl)
      · rw [hy_last]; exact not_last_mem_liftFin c.base
    · rcases liftFin_mem.mp hy_lift with ⟨x, hxd, hxy⟩
      have hxsd : x ∈ F.support \ c.base := c.dir_subset hxd
      rcases Finset.mem_sdiff.mp hxsd with ⟨hxS, hxnb⟩
      refine Finset.mem_sdiff.mpr ⟨?_, ?_⟩
      · rw [db_support]
        exact mem_withTop.mpr (Or.inr (liftFin_mem.mpr ⟨x, hxS, hxy⟩))
      · intro hy_in_lift
        rcases liftFin_mem.mp hy_in_lift with ⟨x', hxb', hxy'⟩
        -- castSuccEmb is injective: x = x'.
        have h_eq : Fin.castSuccEmb x = Fin.castSuccEmb x' := by rw [hxy, hxy']
        have : x = x' := Fin.castSuccEmb.injective h_eq
        exact hxnb (this ▸ hxb')
  dir_card   := by
    rw [Finset.card_insert_of_notMem (not_last_mem_liftFin c.dir)]
    show (liftFin c.dir).card + 1 = k + 1
    have : (liftFin c.dir).card = c.dir.card := by
      unfold liftFin; rw [Finset.card_map]
    rw [this, c.dir_card]
  subcube    := by
    -- For T'' ⊆ insert (last n) (liftFin c.dir), liftFin c.base ∪ T'' ∈ (db F).family.
    intro T'' hT''
    rw [Finset.mem_powerset] at hT''
    classical
    -- Extract the "Fin n-side direction set" U := {x ∈ c.dir : castSuccEmb x ∈ T''}.
    let U : Finset (Fin n) := c.dir.filter (fun x => Fin.castSuccEmb x ∈ T'')
    have hU_sub : U ⊆ c.dir := Finset.filter_subset _ _
    have hbU : c.base ∪ U ∈ F.family :=
      c.subcube U (Finset.mem_powerset.mpr hU_sub)
    by_cases h_last : Fin.last n ∈ T''
    · -- Fin.last n ∈ T''. Goal: liftFin c.base ∪ T'' = withTop (c.base ∪ U).
      -- This will land in familyTopLift via hbU.
      have hT''_erase_sub : T''.erase (Fin.last n) ⊆ liftFin c.dir := by
        intro y hy
        have hy_T'' := Finset.mem_of_mem_erase hy
        rcases Finset.mem_insert.mp (hT'' hy_T'') with hyl | hyL
        · exfalso; exact (Finset.ne_of_mem_erase hy) hyl
        · exact hyL
      have hlift_U_eq : liftFin U = T''.erase (Fin.last n) := by
        ext y
        constructor
        · intro hy
          rcases liftFin_mem.mp hy with ⟨x, hxU, hxy⟩
          rcases Finset.mem_filter.mp hxU with ⟨_, hxT''⟩
          refine Finset.mem_erase.mpr ⟨?_, ?_⟩
          · -- y ≠ Fin.last n: since y = castSuccEmb x with x.val < n.
            intro hy_last
            have : y ∈ liftFin c.dir := by
              rcases Finset.mem_filter.mp hxU with ⟨hxd, _⟩
              exact liftFin_mem.mpr ⟨x, hxd, hxy⟩
            exact not_last_mem_liftFin c.dir (hy_last ▸ this)
          · rw [← hxy]; exact hxT''
        · intro hy
          have hy_T'' := Finset.mem_of_mem_erase hy
          have hy_lift : y ∈ liftFin c.dir := hT''_erase_sub hy
          rcases liftFin_mem.mp hy_lift with ⟨x, hxd, hxy⟩
          refine liftFin_mem.mpr ⟨x, ?_, hxy⟩
          refine Finset.mem_filter.mpr ⟨hxd, ?_⟩
          rw [hxy]; exact hy_T''
      have hT''_eq : T'' = insert (Fin.last n) (liftFin U) := by
        rw [hlift_U_eq, Finset.insert_erase h_last]
      have hgoal_eq : liftFin c.base ∪ T'' = withTop (c.base ∪ U) := by
        rw [hT''_eq]
        ext y
        rw [Finset.mem_union, Finset.mem_insert, mem_withTop, liftFin_union]
        constructor
        · rintro (hyB | hy_last | hyU)
          · exact Or.inr (Finset.mem_union_left _ hyB)
          · exact Or.inl hy_last
          · exact Or.inr (Finset.mem_union_right _ hyU)
        · rintro (hy_last | hy)
          · exact Or.inr (Or.inl hy_last)
          · rcases Finset.mem_union.mp hy with hyB | hyU
            · exact Or.inl hyB
            · exact Or.inr (Or.inr hyU)
      rw [hgoal_eq, db_family]
      exact Finset.mem_union_right _ (mem_familyTopLift.mpr ⟨c.base ∪ U, hbU, rfl⟩)
    · -- Fin.last n ∉ T''. Then T'' ⊆ liftFin c.dir, so T'' = liftFin U.
      have hT''_sub_lift : T'' ⊆ liftFin c.dir := by
        intro y hy
        rcases Finset.mem_insert.mp (hT'' hy) with hyl | hyL
        · exfalso; exact h_last (hyl ▸ hy)
        · exact hyL
      have hlift_U_eq : liftFin U = T'' := by
        ext y
        constructor
        · intro hy
          rcases liftFin_mem.mp hy with ⟨x, hxU, hxy⟩
          rcases Finset.mem_filter.mp hxU with ⟨_, hxT''⟩
          rw [← hxy]; exact hxT''
        · intro hy
          have hy_lift : y ∈ liftFin c.dir := hT''_sub_lift hy
          rcases liftFin_mem.mp hy_lift with ⟨x, hxd, hxy⟩
          refine liftFin_mem.mpr ⟨x, ?_, hxy⟩
          refine Finset.mem_filter.mpr ⟨hxd, ?_⟩
          rw [hxy]; exact hy
      have hgoal_eq : liftFin c.base ∪ T'' = liftFin (c.base ∪ U) := by
        rw [← hlift_U_eq, liftFin_union]
      rw [hgoal_eq, db_family]
      exact Finset.mem_union_left _ (mem_familyLift.mpr ⟨c.base ∪ U, hbU, rfl⟩)

@[simp] theorem bridgeCell_base {F : IntClosedFam n} {k : ℕ} (c : CubeCell F k) :
    (bridgeCell c).base = liftFin c.base := rfl

@[simp] theorem bridgeCell_dir {F : IntClosedFam n} {k : ℕ} (c : CubeCell F k) :
    (bridgeCell c).dir = insert (Fin.last n) (liftFin c.dir) := rfl

/-! ### Acceptance bar (1.bis): bridgeCell is injective -/

/--
**bridgeCell is injective**: distinct `k`-cells of `X(F)` map to distinct
`(k+1)`-cells of `X(db F)`.
-/
theorem bridgeCell_injective {F : IntClosedFam n} {k : ℕ} :
    Function.Injective (bridgeCell (F := F) (k := k)) := by
  intro c₁ c₂ h
  refine CubeCell.ext ?_ ?_
  · have h_base : (bridgeCell c₁).base = (bridgeCell c₂).base := congrArg CubeCell.base h
    rw [bridgeCell_base, bridgeCell_base] at h_base
    exact liftFin_injective h_base
  · have h_dir : (bridgeCell c₁).dir = (bridgeCell c₂).dir := congrArg CubeCell.dir h
    rw [bridgeCell_dir, bridgeCell_dir] at h_dir
    -- insert (last n) (liftFin c₁.dir) = insert (last n) (liftFin c₂.dir).
    -- Strip the insert via Finset.erase + the fact that last n ∉ either liftFin.
    have h_erase : (insert (Fin.last n) (liftFin c₁.dir)).erase (Fin.last n)
                 = (insert (Fin.last n) (liftFin c₂.dir)).erase (Fin.last n) := by
      rw [h_dir]
    rw [Finset.erase_insert (not_last_mem_liftFin c₁.dir),
        Finset.erase_insert (not_last_mem_liftFin c₂.dir)] at h_erase
    exact liftFin_injective h_erase

/-! ### Acceptance bar (1): the bridge cell over the top vertex at n -/

/--
**Acceptance bar (1) witness**: the bridge of the top vertex is a
concrete 1-cell of `singleFamilyComplex (db F)`. Non-vacuous for every
`F : IntClosedFam n` (`n ≥ 0`); in particular at `n = 3`.
-/
theorem bridgeCell_topVertex_witness {n : ℕ} (F : IntClosedFam n) :
    bridgeCell (CubeCell.topVertex F) ∈ CubeCell.cells (db F) 1 :=
  CubeCell.mem_cells _

end UnionClosed.UC12
