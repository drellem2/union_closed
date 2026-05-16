/-
UnionClosed/UC10/IntClosedFam.lean
==================================

UC10 Primitive 1 — the category C_n^∩ of pointed intersection-closed families.

Source: docs/union-closed-UC10-native-cohomology-intersection-closed-families.md
  - Defn 2.1 (objects of C_n^∩)
  - Defn 2.2 (trace morphisms)
  - Lemma 2.3 (trace preserves intersection-closure)

Hard-constraint compliance (UC-Lean-scope §D):
- D.1 NOT factorial: this file uses only Finset (Fin n) combinatorics; no factorial
  decompositions, no S_{n+1}-spine structures, no Specht-module imports.
- D.2 NOT functorial in the refinement sense: the category C_n^∩ is built natively
  via trace morphisms; no functor C_n^∩ ⥤ PPF_n exists in this file or its dependents.
- D.4 Math-first: the latex artefact mg-814b §2 (verified GREEN, merged) is the input.
-/

import Mathlib.Data.Finset.Basic
import Mathlib.Data.Finset.Lattice.Basic
import Mathlib.Data.Finset.Lattice.Fold
import Mathlib.Data.Finset.Image
import Mathlib.Data.Fin.Basic
import Mathlib.CategoryTheory.Category.Basic
import Mathlib.CategoryTheory.Functor.Basic

open CategoryTheory

namespace UnionClosed.UC10

universe u

/--
An object of `C_n^∩` (`IntClosedFam n`): a pointed intersection-closed family.

Data:
- `support : Finset (Fin n)`
- `family  : Finset (Finset (Fin n))` — the family `F` (subset of `2^support`)

Conditions (UC10 Defn 2.1):
- `intClosed`     — `F` is intersection-closed
- `fullSupport`   — `⋃ F = support`
- `topMem`        — `support ∈ F`
- `nonempty`      — `F ≠ ∅`
- `subsetSupport` — every member of `F` is a subset of `support` (well-formedness)

Note: by `topMem` + `subsetSupport`, `F` is nonempty automatically, but we keep
`nonempty` as an explicit field for convenient destructuring.
-/
structure IntClosedFam (n : ℕ) where
  support       : Finset (Fin n)
  family        : Finset (Finset (Fin n))
  subsetSupport : ∀ A ∈ family, A ⊆ support
  intClosed     : ∀ A ∈ family, ∀ B ∈ family, A ∩ B ∈ family
  fullSupport   : (family.sup id) = support
  topMem        : support ∈ family
  nonempty      : family.Nonempty

namespace IntClosedFam

variable {n : ℕ}

@[ext] theorem ext (X Y : IntClosedFam n)
    (hs : X.support = Y.support) (hf : X.family = Y.family) : X = Y := by
  cases X; cases Y; congr

/-- The trace of a family `F` along a subset `T ⊆ support`.

(The `hT : T ⊆ X.support` hypothesis is not needed at the level of `Finset`-
image — restriction is well-defined for any `T` — but it is required to make
the resulting family a valid `IntClosedFam` codomain; see `traceMor_exists`.)
-/
def trace (X : IntClosedFam n) (T : Finset (Fin n)) (_hT : T ⊆ X.support) :
    Finset (Finset (Fin n)) :=
  X.family.image (fun A => A ∩ T)

end IntClosedFam

/--
Morphisms in `C_n^∩` (UC10 Defn 2.2): trace along `T ⊆ X.support`.

The target `Y` is *forced* by the trace condition `Y.family = {A ∩ T : A ∈ X.family}`,
so a morphism is essentially the data of `T = Y.support` together with the
verification that the trace gives back `Y.family`.
-/
structure TraceMor (X Y : IntClosedFam n) : Type where
  subset  : Y.support ⊆ X.support
  traceEq : Y.family = X.family.image (fun A => A ∩ Y.support)

namespace TraceMor

variable {n : ℕ}

/-- The identity trace morphism (trace along the whole support). -/
def id (X : IntClosedFam n) : TraceMor X X where
  subset := subset_refl _
  traceEq := by
    -- For each A ∈ X.family, A ∩ X.support = A (since A ⊆ X.support).
    ext A
    constructor
    · intro hA
      refine Finset.mem_image.mpr ⟨A, hA, ?_⟩
      exact Finset.inter_eq_left.mpr (X.subsetSupport A hA)
    · intro hA
      rcases Finset.mem_image.mp hA with ⟨B, hB, hBA⟩
      have hBsub : B ⊆ X.support := X.subsetSupport B hB
      rw [Finset.inter_eq_left.mpr hBsub] at hBA
      exact hBA ▸ hB

/-- Composition of trace morphisms.

Given `f : X → Y` (trace along `Y.support ⊆ X.support`) and
`g : Y → Z` (trace along `Z.support ⊆ Y.support`), the composite is the
trace along `Z.support ⊆ X.support`.

The key combinatorial identity is `(A ∩ Y.support) ∩ Z.support = A ∩ Z.support`,
which holds because `Z.support ⊆ Y.support`.
-/
def comp {X Y Z : IntClosedFam n} (f : TraceMor X Y) (g : TraceMor Y Z) :
    TraceMor X Z where
  subset := g.subset.trans f.subset
  traceEq := by
    have hZY : Z.support ⊆ Y.support := g.subset
    -- Z.family = Y.family.image (·∩Z.support) = (X.family.image (·∩Y.support)).image (·∩Z.support)
    --         = X.family.image (·∩Z.support)
    rw [g.traceEq, f.traceEq, Finset.image_image]
    refine Finset.image_congr ?_
    intro A _
    ext x
    by_cases hxZ : x ∈ Z.support
    · simp [hxZ, hZY hxZ]
    · simp [hxZ]

end TraceMor

/--
Lemma 2.3 (UC10): the trace of a `IntClosedFam` along any subset of its support
is again a `IntClosedFam`.

This packages the well-definedness of trace morphisms — i.e., for every
`T ⊆ X.support` there is a target object `Y` for which `TraceMor X Y` is
well-typed.
-/
theorem traceMor_exists (X : IntClosedFam n) (T : Finset (Fin n))
    (hT : T ⊆ X.support) :
    ∃ Y : IntClosedFam n,
      Y.support = T ∧ Y.family = X.family.image (fun A => A ∩ T) := by
  -- Construct Y explicitly.
  refine ⟨{
    support       := T
    family        := X.family.image (fun A => A ∩ T)
    subsetSupport := ?_
    intClosed     := ?_
    fullSupport   := ?_
    topMem        := ?_
    nonempty      := ?_
  }, rfl, rfl⟩
  -- subsetSupport: every (A ∩ T) ⊆ T.
  · intro B hB
    rcases Finset.mem_image.mp hB with ⟨A, _, rfl⟩
    exact Finset.inter_subset_right
  -- intClosed: (A ∩ T) ∩ (B ∩ T) = (A ∩ B) ∩ T, and A ∩ B ∈ X.family.
  · intro B hB B' hB'
    rcases Finset.mem_image.mp hB with ⟨A, hA, rfl⟩
    rcases Finset.mem_image.mp hB' with ⟨A', hA', rfl⟩
    refine Finset.mem_image.mpr ⟨A ∩ A', X.intClosed A hA A' hA', ?_⟩
    ext x
    constructor
    · intro hx
      rcases Finset.mem_inter.mp hx with ⟨hxAA, hxT⟩
      rcases Finset.mem_inter.mp hxAA with ⟨hxA, hxA'⟩
      exact Finset.mem_inter.mpr ⟨Finset.mem_inter.mpr ⟨hxA, hxT⟩,
                                   Finset.mem_inter.mpr ⟨hxA', hxT⟩⟩
    · intro hx
      rcases Finset.mem_inter.mp hx with ⟨hx1, hx2⟩
      rcases Finset.mem_inter.mp hx1 with ⟨hxA, hxT⟩
      rcases Finset.mem_inter.mp hx2 with ⟨hxA', _⟩
      exact Finset.mem_inter.mpr
        ⟨Finset.mem_inter.mpr ⟨hxA, hxA'⟩, hxT⟩
  -- fullSupport: ⋃ (A ∩ T : A ∈ F) = (⋃ A) ∩ T = X.support ∩ T = T.
  · rw [Finset.sup_image]
    -- sup (image (·∩T)) = (sup X.family) ∩ T
    have : ((X.family.sup id : Finset (Fin n))) ∩ T = T := by
      rw [X.fullSupport]; exact Finset.inter_eq_right.mpr hT
    -- Use that sup commutes with intersection on the right.
    -- Actually the cleanest way: use Finset.sup_inter_distribLeft? Not in stdlib at
    -- that signature. Do it pointwise.
    ext x
    simp only [Finset.mem_sup, Function.comp]
    constructor
    · rintro ⟨A, hA, hx⟩
      rcases Finset.mem_inter.mp hx with ⟨_, hxT⟩
      exact hxT
    · intro hxT
      -- Take A = X.support — but X.support is the union, not in F necessarily.
      -- Use that x ∈ T ⊆ X.support = ⋃ X.family, so ∃ A ∈ X.family, x ∈ A.
      have hxS : x ∈ X.support := hT hxT
      rw [← X.fullSupport] at hxS
      rcases Finset.mem_sup.mp hxS with ⟨A, hA, hxA⟩
      exact ⟨A, hA, Finset.mem_inter.mpr ⟨hxA, hxT⟩⟩
  -- topMem: T = X.support ∩ T  ∈  X.family.image (·∩T).
  · refine Finset.mem_image.mpr ⟨X.support, X.topMem, ?_⟩
    exact Finset.inter_eq_right.mpr hT
  -- nonempty: image of a nonempty set under any function is nonempty.
  · exact X.nonempty.image _

/--
The trace of `X` along `T ⊆ X.support` — packaged as an `IntClosedFam`.
This is the *codomain* of a canonical trace morphism out of `X`.
-/
noncomputable def IntClosedFam.traceFam (X : IntClosedFam n) (T : Finset (Fin n))
    (hT : T ⊆ X.support) : IntClosedFam n :=
  (traceMor_exists X T hT).choose

/-- Specification of `IntClosedFam.traceFam`. -/
theorem IntClosedFam.traceFam_spec (X : IntClosedFam n) (T : Finset (Fin n))
    (hT : T ⊆ X.support) :
    (X.traceFam T hT).support = T ∧
    (X.traceFam T hT).family = X.family.image (fun A => A ∩ T) :=
  (traceMor_exists X T hT).choose_spec

/--
**The trivial intersection-closed family on `Fin n`**: support `∅` and family
`{∅}`. This is the canonical singleton-family object of `C_n^∩`, used as the
default summand in framework-completion places where a canonical choice of
`IntClosedFam n` is needed (e.g., `BKBicomplex`'s L2a-residual baseline).
-/
def IntClosedFam.trivial (n : ℕ) : IntClosedFam n where
  support       := ∅
  family        := {∅}
  subsetSupport := by intro A hA; rw [Finset.mem_singleton.mp hA]
  intClosed     := by
    intro A hA B hB
    rw [Finset.mem_singleton.mp hA, Finset.mem_singleton.mp hB, Finset.inter_self]
    exact Finset.mem_singleton.mpr rfl
  fullSupport   := by
    rw [Finset.sup_singleton, id]
  topMem        := Finset.mem_singleton.mpr rfl
  nonempty      := ⟨∅, Finset.mem_singleton.mpr rfl⟩

@[simp] theorem IntClosedFam.trivial_support (n : ℕ) :
    (IntClosedFam.trivial n).support = ∅ := rfl

@[simp] theorem IntClosedFam.trivial_family (n : ℕ) :
    (IntClosedFam.trivial n).family = {∅} := rfl

/--
The `SmallCategory` instance on `IntClosedFam n`.

Objects are pointed intersection-closed families on subsets of `[n]`; morphisms
are trace morphisms. Identity = trace along the whole support; composition =
chained trace.

This is the C_n^∩ of UC10 Defn 2.1+2.2.
-/
instance ICatCap (n : ℕ) : SmallCategory (IntClosedFam n) where
  Hom X Y := TraceMor X Y
  id X := TraceMor.id X
  comp f g := TraceMor.comp f g
  id_comp f := by
    -- f.subset and f.traceEq fully determine f; verify pointwise.
    rcases f with ⟨_, _⟩; rfl
  comp_id f := by
    rcases f with ⟨_, _⟩; rfl
  assoc f g h := by
    rcases f with ⟨_, _⟩; rcases g with ⟨_, _⟩; rcases h with ⟨_, _⟩; rfl

end UnionClosed.UC10
