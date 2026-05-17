/-
Copyright (c) 2026 Union-Closed Polecat Authors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Union-Closed Polecat (cat-mg-4165 Z1a + cat-mg-a298 Z1b, of
UC-Lean-MathlibSS-Full-scope).

This file extends `Mathlib.Algebra.Homology.SpectralObject.SpectralSequence`,
authored by Joël Riou, by closing the three TODOs in that file's module-doc:
`Abelian.SpectralObject.SpectralSequence.homologyData`,
`Abelian.SpectralObject.spectralSequenceHomologyData`, and
`Abelian.SpectralObject.spectralSequence`. The constructions here are
local-only (kept in `UnionClosed.Mathlib.*` rather than upstream Mathlib)
per Daniel directive 2026-05-17T13:53Z but follow Joël-Riou style and are
ready for upstream submission.
-/
module

public import Mathlib.Algebra.Homology.SpectralObject.SpectralSequence

/-!
# The spectral sequence of a spectral object — assembly of the three TODOs

This file is **MATHLIB-PR-CANDIDATE: yes (definitive)**. It is execution
sub-ticket Z1 of the proper-mathlib-SS-infrastructure arc
`UC-Lean-MathlibSS-Full-scope` (mg-103f, mg-4165). It closes Joël Riou's
three header-flagged TODOs in `Mathlib/Algebra/Homology/SpectralObject/`
`SpectralSequence.lean`:

* `Abelian.SpectralObject.SpectralSequence.HomologyData.cc` — the
  (limit) cokernel cofork of the differential on the `r`th page, whose
  point identifies to `X.E (i₀ ≤ i₁ ≤ i₂ ≤ i₃')`, dual to the existing
  `kf` whose point identifies to `X.E (i₀' ≤ i₁ ≤ i₂ ≤ i₃)`.

* `Abelian.SpectralObject.SpectralSequence.homologyData` — the
  `ShortComplex.HomologyData` packaging `kf` + `cc` + the epi-mono
  factorisation, so the homology of a page `r` short complex at `pq'`
  identifies to `pageX (r + 1) pq' = X.E (i₀' ≤ i₁ ≤ i₂ ≤ i₃')`.

* `Abelian.SpectralObject.spectralSequenceHomologyData` — the per-`pq`
  assembly into the `iso` field of `SpectralSequence`.

* `Abelian.SpectralObject.spectralSequence` — the final user-facing
  constructor `SpectralSequence C c r₀`.
-/

@[expose] public section

namespace CategoryTheory

open Category Limits ComposableArrows

namespace Abelian

namespace SpectralObject

variable {C ι κ : Type*} [Category* C] [Abelian C] [Preorder ι]
  (X : SpectralObject C ι)
  {c : ℤ → ComplexShape κ} {r₀ : ℤ}

variable (data : SpectralSequenceDataCore ι c r₀)

/-!
## Epi/Mono typeclass instances for the primed `mapFourδ` abbreviations

The unprimed forms `Epi (X.map ... (fourδ₄Toδ₃ ...) ...)` and
`Mono (X.map ... (fourδ₁Toδ₀ ...) ...)` are registered as instances in
`Mathlib.Algebra.Homology.SpectralObject.EpiMono` (lines 79–81 and 110–112),
but Lean's typeclass synthesis does not currently fire on the primed
abbreviations `X.mapFourδ₄Toδ₃'` / `X.mapFourδ₁Toδ₀'` even though they
are `@[reducible]`. The blocker is a unifier quirk: the underscores in
`X.epi_map _ _ _ _ _ _ _ _ _ rfl rfl rfl ...` get conflated when the goal
is in primed form (`?m.f₃ ↦ ?m.f₃'` collision). Spelling out the four
`f` arguments explicitly bypasses this and lets the body delegate to the
unprimed `epi_map` / `mono_map` lemmas.

These are the obvious mathlib-PR-clean fixes — they could be moved to
`SpectralObject/EpiMono.lean` upstream — but per Daniel directive
2026-05-17T13:53Z we keep them local. -/

instance epi_mapFourδ₄Toδ₃' (i₀ i₁ i₂ i₃ i₄ : ι) (hi₀₁ : i₀ ≤ i₁) (hi₁₂ : i₁ ≤ i₂)
    (hi₂₃ : i₂ ≤ i₃) (hi₃₄ : i₃ ≤ i₄)
    (n₀ n₁ n₂ : ℤ) (hn₁ : n₀ + 1 = n₁) (hn₂ : n₁ + 1 = n₂) :
    Epi (X.mapFourδ₄Toδ₃' i₀ i₁ i₂ i₃ i₄ hi₀₁ hi₁₂ hi₂₃ hi₃₄ n₀ n₁ n₂ hn₁ hn₂) :=
  X.epi_map (homOfLE hi₀₁) (homOfLE hi₁₂) (homOfLE hi₂₃) (homOfLE (hi₂₃.trans hi₃₄))
    _ _ _ _ _ rfl rfl rfl hn₁ hn₂ rfl

instance mono_mapFourδ₁Toδ₀' (i₀ i₁ i₂ i₃ i₄ : ι) (hi₀₁ : i₀ ≤ i₁) (hi₁₂ : i₁ ≤ i₂)
    (hi₂₃ : i₂ ≤ i₃) (hi₃₄ : i₃ ≤ i₄)
    (n₀ n₁ n₂ : ℤ) (hn₁ : n₀ + 1 = n₁) (hn₂ : n₁ + 1 = n₂) :
    Mono (X.mapFourδ₁Toδ₀' i₀ i₁ i₂ i₃ i₄ hi₀₁ hi₁₂ hi₂₃ hi₃₄ n₀ n₁ n₂ hn₁ hn₂) :=
  X.mono_map (homOfLE (hi₀₁.trans hi₁₂)) (homOfLE hi₁₂) (homOfLE hi₂₃) (homOfLE hi₃₄)
    _ _ _ _ _ rfl rfl rfl hn₁ hn₂ rfl

namespace SpectralSequence

section

variable (r r' : ℤ) (hrr' : r + 1 = r') (hr : r₀ ≤ r)
  (pq pq' pq'' : κ) (hpq : (c r).prev pq' = pq) (hpq' : (c r).next pq' = pq'')
  (i₀' i₀ i₁ i₂ i₃ i₃' : ι)
  (hi₀' : i₀' = data.i₀ r' pq')
  (hi₀ : i₀ = data.i₀ r pq')
  (hi₁ : i₁ = data.i₁ pq')
  (hi₂ : i₂ = data.i₂ pq')
  (hi₃ : i₃ = data.i₃ r pq')
  (hi₃' : i₃' = data.i₃ r' pq')
  (n₀ n₁ n₂ : ℤ)
  (hn₁' : n₁ = data.deg pq')

namespace HomologyData

set_option backward.isDefEq.respectTransparency false in
/-- Dual of `kf_w`: composing the differential `(page r).d pq pq'` into `pq'`
with the canonical map to `X.E (i₀ ≤ i₁ ≤ i₂ ≤ i₃')` is zero. -/
lemma cc_w (hn₁ : n₀ + 1 = n₁ := by lia) (hn₂ : n₁ + 1 = n₂ := by lia) :
    (page X data r hr).d pq pq' ≫
      ((pageXIso X data _ hr _ _ _ _ _ hi₀ hi₁ hi₂ hi₃ _ _ _ hn₁' _ _).hom ≫
        X.mapFourδ₄Toδ₃' i₀ i₁ i₂ i₃ i₃' (data.le₀₁' r hr pq' hi₀ hi₁)
          (data.le₁₂' pq' hi₁ hi₂) (data.le₂₃' r hr pq' hi₂ hi₃)
          (data.le₃₃' hrr' hr pq' hi₃ hi₃')
          n₀ n₁ n₂ hn₁ hn₂) = 0 := by
  by_cases h : (c r).Rel pq pq'
  · dsimp
    rw [pageD_eq X data r hr pq pq' h
      (homOfLE (data.le₀₁' r hr pq' hi₀ hi₁))
      (homOfLE (data.le₁₂' pq' hi₁ hi₂))
      (homOfLE (data.le₂₃' r hr pq' hi₂ hi₃))
      (homOfLE (data.le₃₃' hrr' hr pq' hi₃ hi₃'))
      (homOfLE (show i₃' ≤ data.i₃ r pq by
        simpa only [hi₃', data.i₃_next r r' _ _ h] using data.le₂₃ r pq))
      hi₀ hi₁ (hi₂.trans (data.hc₀₂ r pq pq' h).symm)
      (hi₃.trans (data.hc₁₃ r pq pq' h).symm)
      (hi₃'.trans (data.i₃_next r r' pq pq' h)) rfl
      (n₀ - 1) n₀ n₁ n₂
      (by have h₂ := data.hc r pq pq' h
          have h₃ : n₀ + 1 = data.deg pq' := hn₁' ▸ hn₁
          omega)
      (by omega) hn₁ hn₂]
    simp
  · rw [HomologicalComplex.shape _ _ _ h, zero_comp]

/-- A (limit) cokernel cofork of the differential `(page r).d pq pq'` whose
point identifies to an object `X.E`. Dual to `kf`. -/
noncomputable abbrev cc (hn₁ : n₀ + 1 = n₁ := by lia) (hn₂ : n₁ + 1 = n₂ := by lia) :
    CokernelCofork ((page X data r hr).d pq pq') :=
  CokernelCofork.ofπ _ (cc_w X data r r' hrr' hr pq pq'
    i₀ i₁ i₂ i₃ i₃' hi₀ hi₁ hi₂ hi₃ hi₃' n₀ n₁ n₂ hn₁')

/-- The (exact) short complex attached to the cokernel cofork `cc`. -/
@[simps!]
noncomputable def ccSc (hn₁ : n₀ + 1 = n₁ := by lia) (hn₂ : n₁ + 1 = n₂ := by lia) :
    ShortComplex C :=
  ShortComplex.mk _ _ (cc_w X data r r' hrr' hr pq pq'
    i₀ i₁ i₂ i₃ i₃' hi₀ hi₁ hi₂ hi₃ hi₃' n₀ n₁ n₂ hn₁')

instance (hn₁ : n₀ + 1 = n₁) (hn₂ : n₁ + 1 = n₂) :
    Epi (ccSc X data r r' hrr' hr pq pq'
      i₀ i₁ i₂ i₃ i₃' hi₀ hi₁ hi₂ hi₃ hi₃' n₀ n₁ n₂ hn₁' hn₁ hn₂).g := by
  dsimp
  infer_instance

variable [X.HasSpectralSequence data] in
include hpq hn₁' in
/-- Dual of `isIso_mapFourδ₁Toδ₀'`: in the unfavourable case where no
differential lands at `pq'`, the canonical map from the page to the dual
`X.E` is an iso. -/
lemma isIso_mapFourδ₄Toδ₃'_of_no_rel (h : ¬ (c r).Rel pq pq')
    (hn₁ : n₀ + 1 = n₁ := by lia) (hn₂ : n₁ + 1 = n₂ := by lia) :
    IsIso (X.mapFourδ₄Toδ₃' i₀ i₁ i₂ i₃ i₃' (data.le₀₁' r hr pq' hi₀ hi₁)
      (data.le₁₂' pq' hi₁ hi₂) (data.le₂₃' r hr pq' hi₂ hi₃)
      (data.le₃₃' hrr' hr pq' hi₃ hi₃') n₀ n₁ n₂ hn₁ hn₂) := by
  have hZ : IsZero ((X.H n₀).obj (mk₁ (homOfLE
      (data.le₃₃' hrr' hr pq' hi₃ hi₃')))) := by
    refine X.isZero_H_obj_mk₁_i₃_le' data r r' hrr' hr pq' (fun k hk ↦ ?_) _
      (by have h₃ : n₀ + 1 = data.deg pq' := hn₁' ▸ hn₁
          omega) _ _ hi₃ hi₃'
    obtain rfl := (c r).prev_eq' hk
    subst hpq
    exact h hk
  exact X.isIso_mapFourδ₄Toδ₃' _ _ _ _ _ _ _ _ _ _ _ _ hZ hn₁ hn₂

variable [X.HasSpectralSequence data] in
include hpq in
/-- Exactness of `ccSc` — dual to `kfSc_exact`. Combined with `epi g`, this
makes `ccSc.g` a cokernel of `(page r).d pq pq'`. -/
lemma ccSc_exact (hn₁ : n₀ + 1 = n₁ := by lia) (hn₂ : n₁ + 1 = n₂ := by lia) :
    (ccSc X data r r' hrr' hr pq pq' i₀ i₁ i₂ i₃ i₃'
      hi₀ hi₁ hi₂ hi₃ hi₃' n₀ n₁ n₂ hn₁' hn₁ hn₂).Exact := by
  by_cases h : (c r).Rel pq pq'
  · refine ShortComplex.exact_of_iso (Iso.symm ?_)
      (X.dCokernelSequence_exact
        (homOfLE (data.le₀₁' r hr pq' hi₀ hi₁))
        (homOfLE (data.le₁₂' pq' hi₁ hi₂))
        (homOfLE (data.le₂₃' r hr pq' hi₂ hi₃))
        (homOfLE (data.le₃₃' hrr' hr pq' hi₃ hi₃'))
        (homOfLE (show i₃' ≤ data.i₃ r pq by
          simpa only [hi₃', data.i₃_next r r' _ _ h] using data.le₂₃ r pq))
        _ rfl
        (n₀ - 1) n₀ n₁ n₂ (by lia) hn₁ hn₂)
    refine ShortComplex.isoMk
      (pageXIso X data _ hr _ _ _ _ _
        (hi₂.trans (data.hc₀₂ r _ _ h).symm)
        (hi₃.trans (data.hc₁₃ r _ _ h).symm)
        (hi₃'.trans (data.i₃_next r r' _ _ h))
        rfl _ _ _
        (by have := data.hc r _ _ h; lia))
      (pageXIso X data _ hr _ _ _ _ _ hi₀ hi₁ hi₂ hi₃ _ _ _ hn₁')
      (Iso.refl _)
      ?_ ?_
    · dsimp
      rw [pageD_eq X data r hr pq pq' h
          (homOfLE (data.le₀₁' r hr pq' hi₀ hi₁))
          (homOfLE (data.le₁₂' pq' hi₁ hi₂))
          (homOfLE (data.le₂₃' r hr pq' hi₂ hi₃))
          (homOfLE (data.le₃₃' hrr' hr pq' hi₃ hi₃'))
          (homOfLE (show i₃' ≤ data.i₃ r pq by
            simpa only [hi₃', data.i₃_next r r' _ _ h] using data.le₂₃ r pq))
          hi₀ hi₁ (hi₂.trans (data.hc₀₂ r pq pq' h).symm)
          (hi₃.trans (data.hc₁₃ r pq pq' h).symm)
          (hi₃'.trans (data.i₃_next r r' pq pq' h)) rfl
          (n₀ - 1) n₀ n₁ n₂
          (by have h₂ := data.hc r pq pq' h
              have h₃ : n₀ + 1 = data.deg pq' := hn₁' ▸ hn₁
              omega)
          (by omega) hn₁ hn₂,
        Category.assoc, Category.assoc, Iso.inv_hom_id, Category.comp_id]
    · simp
  · rw [ShortComplex.exact_iff_mono _ ((page X data r hr).shape _ _ h)]
    have hIso := isIso_mapFourδ₄Toδ₃'_of_no_rel X data r r' hrr' hr pq pq' hpq
      i₀ i₁ i₂ i₃ i₃' hi₀ hi₁ hi₂ hi₃ hi₃' n₀ n₁ n₂ hn₁' h hn₁ hn₂
    dsimp
    infer_instance

variable [X.HasSpectralSequence data] in
include hpq in
/-- The cokernel cofork `cc` is a colimit. -/
noncomputable def isColimitCc (hn₁ : n₀ + 1 = n₁ := by lia) (hn₂ : n₁ + 1 = n₂ := by lia) :
    IsColimit (cc X data r r' hrr' hr pq pq'
      i₀ i₁ i₂ i₃ i₃' hi₀ hi₁ hi₂ hi₃ hi₃' n₀ n₁ n₂ hn₁' hn₁ hn₂) :=
  (ccSc_exact X data r r' hrr' hr pq pq' hpq
    i₀ i₁ i₂ i₃ i₃' hi₀ hi₁ hi₂ hi₃ hi₃' n₀ n₁ n₂ hn₁' hn₁ hn₂).gIsCokernel

end HomologyData

end

/-!
## Local kernel-fork side (verbatim copies of mathlib's kernel-fork half)

Mathlib's `Mathlib.Algebra.Homology.SpectralObject.SpectralSequence` defines
`HomologyData.kf`, `kf_w`, `kfSc`, `isIso_mapFourδ₁Toδ₀'`, `kfSc_exact`, and
`isLimitKf`. These all build perfectly fine inside mathlib's module, but
their signatures embed private auto-generated proofs (e.g. the autoparam
discharge for `data.i₀ r' pq'`, exposed as `_private.…SpectralSequence.0
._proof_27` in the kernel). When another module — like this one — references
those signatures (e.g. `kf.pt` to build a morphism), the kernel needs to
resolve those private proofs but cannot under the new module system.

The workaround used here is to re-introduce verbatim local copies of the six
kernel-fork-side declarations below, suffixed `'`. The bodies are textually
identical to mathlib's. The autoparams now discharge inside this module,
generating local `_proof_n` that the kernel can resolve.

This duplication is purely a module-system bookkeeping requirement; once the
upstream mathlib `SpectralSequence.lean` is updated to expose its auto-
generated proofs (e.g. by replacing `data.i₀ r' pq'` with an explicit
`data.i₀ r' pq' hr'` everywhere), these local copies become redundant. Until
then, they keep this assembly self-contained without modifying upstream
mathlib (per Daniel directive 2026-05-17T13:53Z, local-only).
-/

section

variable (r r' : ℤ) (hrr' : r + 1 = r') (hr : r₀ ≤ r)
  (pq' pq'' : κ) (hpq' : (c r).next pq' = pq'')
  (i₀' i₀ i₁ i₂ i₃ : ι)
  (hi₀' : i₀' = data.i₀ r' pq')
  (hi₀ : i₀ = data.i₀ r pq')
  (hi₁ : i₁ = data.i₁ pq')
  (hi₂ : i₂ = data.i₂ pq')
  (hi₃ : i₃ = data.i₃ r pq')
  (n₀ n₁ n₂ : ℤ)
  (hn₁' : n₁ = data.deg pq')

namespace HomologyData

set_option backward.isDefEq.respectTransparency false in
/-- Local copy of mathlib's `kf_w`, re-elaborated in this module so the
auto-generated proofs in its signature are visible. -/
lemma kf_w' (hn₁ : n₀ + 1 = n₁ := by lia) (hn₂ : n₁ + 1 = n₂ := by lia) :
    (X.mapFourδ₁Toδ₀' i₀' i₀ i₁ i₂ i₃ (data.i₀_le' hrr' hr pq' hi₀' hi₀)
      (data.le₀₁' r hr pq' hi₀ hi₁) (data.le₁₂' pq' hi₁ hi₂) (data.le₂₃' r hr pq' hi₂ hi₃)
        n₀ n₁ n₂ hn₁ hn₂ ≫
      (pageXIso X data _ hr _ _ _ _ _ hi₀ hi₁ hi₂ hi₃ _ _ _ hn₁' _ _ ).inv) ≫
        (page X data r hr).d pq' pq'' = 0 := by
  by_cases h : (c r).Rel pq' pq''
  · dsimp
    rw [pageD_eq X data r hr pq' pq'' h
      (homOfLE (by simpa only [hi₀', data.i₀_prev r r' _ _ h] using data.le₀₁ r pq''))
      (homOfLE (data.i₀_le' hrr' hr pq' hi₀' hi₀)) _ _ _ rfl
      (by rw [hi₀', data.i₀_prev r r' pq' pq'' h]) hi₀ hi₁ hi₂ hi₃ _ _ _ _ hn₁' hn₁ hn₂ rfl,
      Category.assoc, Iso.inv_hom_id_assoc, map_fourδ₁Toδ₀_d_assoc .., zero_comp]
  · rw [HomologicalComplex.shape _ _ _ h, comp_zero]

/-- Local copy of mathlib's `kf`. -/
noncomputable abbrev kf' (hn₁ : n₀ + 1 = n₁ := by lia) (hn₂ : n₁ + 1 = n₂ := by lia) :
    KernelFork ((page X data r hr).d pq' pq'') :=
  KernelFork.ofι _ (kf_w' X data r r' hrr' hr pq' pq''
    i₀' i₀ i₁ i₂ i₃ hi₀' hi₀ hi₁ hi₂ hi₃ n₀ n₁ n₂ hn₁')

/-- Local copy of mathlib's `kfSc`. -/
@[simps!]
noncomputable def kfSc' (hn₁ : n₀ + 1 = n₁ := by lia) (hn₂ : n₁ + 1 = n₂ := by lia) :
    ShortComplex C :=
  ShortComplex.mk _ _ (kf_w' X data r r' hrr' hr pq' pq''
    i₀' i₀ i₁ i₂ i₃ hi₀' hi₀ hi₁ hi₂ hi₃ n₀ n₁ n₂ hn₁' hn₁)

instance (hn₁ : n₀ + 1 = n₁) (hn₂ : n₁ + 1 = n₂) :
    Mono (kfSc' X data r r' hrr' hr pq' pq'' i₀' i₀ i₁ i₂ i₃
      hi₀' hi₀ hi₁ hi₂ hi₃ n₀ n₁ n₂ hn₁' hn₁ hn₂).f := by
  dsimp
  infer_instance

variable [X.HasSpectralSequence data] in
include hpq' hn₁' in
/-- Local copy of mathlib's `isIso_mapFourδ₁Toδ₀'`. -/
lemma isIso_mapFourδ₁Toδ₀'_local (h : ¬ (c r).Rel pq' pq'')
    (hn₁ : n₀ + 1 = n₁ := by lia) (hn₂ : n₁ + 1 = n₂ := by lia) :
    IsIso (X.mapFourδ₁Toδ₀'
      i₀' i₀ i₁ i₂ i₃ (data.i₀_le' hrr' hr pq' hi₀' hi₀) (data.le₀₁' r hr pq' hi₀ hi₁)
        (data.le₁₂' pq' hi₁ hi₂) (data.le₂₃' r hr pq' hi₂ hi₃) n₀ n₁ n₂ hn₁ hn₂) := by
  apply X.isIso_map_fourδ₁Toδ₀_of_isZero ..
  refine X.isZero_H_obj_mk₁_i₀_le' data r r' hrr' hr pq' (fun k hk ↦ ?_) _ (by lia) _ _ hi₀' hi₀
  obtain rfl := (c r).next_eq' hk
  subst hpq'
  exact h hk

variable [X.HasSpectralSequence data] in
include hpq' in
/-- Local copy of mathlib's `kfSc_exact`. -/
lemma kfSc_exact' (hn₁ : n₀ + 1 = n₁ := by lia) (hn₂ : n₁ + 1 = n₂ := by lia) :
    (kfSc' X data r r' hrr' hr pq' pq'' i₀' i₀ i₁ i₂ i₃ hi₀' hi₀ hi₁ hi₂ hi₃
      n₀ n₁ n₂ hn₁' hn₁ hn₂).Exact := by
  by_cases h : (c r).Rel pq' pq''
  · refine ShortComplex.exact_of_iso (Iso.symm ?_)
      (X.dKernelSequence_exact
        (homOfLE (show data.i₀ r pq'' ≤ i₀' by
          simpa only [hi₀', data.i₀_prev r r' _ _ h] using data.le₀₁ r pq''))
        (homOfLE (data.i₀_le' hrr' hr pq' hi₀' hi₀)) (homOfLE (data.le₀₁' r hr pq' hi₀ hi₁))
        (homOfLE (data.le₁₂' pq' hi₁ hi₂)) (homOfLE (data.le₂₃' r hr pq' hi₂ hi₃)) _ rfl
        n₀ n₁ n₂ (n₂ + 1) hn₁ hn₂ rfl)
    refine ShortComplex.isoMk (Iso.refl _)
      (pageXIso X data _ hr _ _ _ _ _ hi₀ hi₁ hi₂ hi₃ _ _ _ hn₁')
      (pageXIso X data _ hr _ _ _ _ _ rfl (by rw [hi₀', data.i₀_prev r r' _ _ h])
      (by rw [hi₀, data.hc₀₂ r _ _ h]) (by rw [hi₁, data.hc₁₃ r _ _ h]) _ _ _
      (by have := data.hc r _ _ h; lia)) ?_ ?_
    · simp
    · dsimp
      rw [pageD_eq X data r hr pq' pq'' h
          (homOfLE (show data.i₀ r pq'' ≤ i₀' by
            simpa only [hi₀', data.i₀_prev r r' _ _ h] using data.le₀₁ r pq''))
          _ _ _ _ rfl _ _ _ _ _ n₀ n₁ n₂ (n₂ + 1),
        Category.assoc, Category.assoc, Iso.inv_hom_id, Category.comp_id]
      rw [hi₀', data.i₀_prev r r' _ _ h]
  · rw [ShortComplex.exact_iff_epi _ ((page X data r hr).shape _ _ h)]
    have := isIso_mapFourδ₁Toδ₀'_local X data r r' hrr' hr pq' pq'' hpq'
      i₀' i₀ i₁ i₂ i₃ hi₀' hi₀ hi₁ hi₂ hi₃ n₀ n₁ n₂ hn₁' h
    dsimp
    infer_instance

variable [X.HasSpectralSequence data] in
include hpq' in
/-- Local copy of mathlib's `isLimitKf`. -/
noncomputable def isLimitKf' (hn₁ : n₀ + 1 = n₁ := by lia) (hn₂ : n₁ + 1 = n₂ := by lia) :
    IsLimit (kf' X data r r' hrr' hr pq' pq''
      i₀' i₀ i₁ i₂ i₃ hi₀' hi₀ hi₁ hi₂ hi₃ n₀ n₁ n₂ hn₁' hn₁ hn₂) :=
  (kfSc_exact' X data r r' hrr' hr pq' pq'' hpq'
    i₀' i₀ i₁ i₂ i₃ hi₀' hi₀ hi₁ hi₂ hi₃ n₀ n₁ n₂ hn₁' hn₁ hn₂).fIsKernel

end HomologyData

end

/-!
## Deliverables 2–5: epi–mono factorisation + `homologyData` +
`spectralSequenceHomologyData` + `Abelian.SpectralObject.spectralSequence`

The construction in steps:

1. The kernel-fork-point `kf.pt = X.E (i₀' ≤ i₁ ≤ i₂ ≤ i₃)` admits an
   epimorphism `π : kf.pt ⟶ pageX r' pq'` built from
   `X.mapFourδ₄Toδ₃' i₀' i₁ i₂ i₃ i₃'` composed with `(pageXIso r' pq').inv`.

2. The next-page object `pageX r' pq'` admits a monomorphism
   `ι : pageX r' pq' ⟶ cc.pt` built from `(pageXIso r' pq').hom` composed
   with `X.mapFourδ₁Toδ₀' i₀' i₀ i₁ i₂ i₃'`.

3. The factorisation `kf.ι ≫ cc.π = π ≫ ι` follows from the iso
   cancellation `(pageXIso r pq').inv ≫ (pageXIso r pq').hom = 𝟙` (resp.
   the same for `r'`) hidden inside `kf.ι` and `cc.π`, reducing both
   sides to the same composite of `mapFourδ₁Toδ₀'` and `mapFourδ₄Toδ₃'`
   primitives, then `mapFourδ₁Toδ₀'_mapFourδ₃Toδ₃'`.

4. Feeding this into `ShortComplex.HomologyData.ofEpiMonoFactorisation`
   produces a `HomologyData` whose `H` field is `pageX r' pq'`, yielding
   `homologyData`. Per-`pq` packaging gives `spectralSequenceHomologyData`,
   and combining the page-`r` short-complex isos `isoSc'` and
   `homologyIsoSc'` with the `HomologyData.left.homologyIso` gives the
   `iso` field of the final `Abelian.SpectralObject.spectralSequence`.
-/

namespace HomologyData

set_option backward.isDefEq.respectTransparency false in
/-- The "epi half" `π : kf.pt ⟶ pageX r' pq'` of the epi-mono factorisation
of `kf.ι ≫ cc.π`. It is `X.mapFourδ₄Toδ₃' i₀' i₁ i₂ i₃ i₃'` composed with
the inverse `pageXIso` identifying `X.E (i₀' ≤ i₁ ≤ i₂ ≤ i₃')` with
`pageX r' pq'`. -/
@[expose] noncomputable def π
    (r r' : ℤ) (hrr' : r + 1 = r') (hr : r₀ ≤ r) (hr' : r₀ ≤ r')
    (pq' pq'' : κ)
    (i₀' i₀ i₁ i₂ i₃ i₃' : ι)
    (hi₀' : i₀' = data.i₀ r' pq')
    (hi₀ : i₀ = data.i₀ r pq')
    (hi₁ : i₁ = data.i₁ pq')
    (hi₂ : i₂ = data.i₂ pq')
    (hi₃ : i₃ = data.i₃ r pq')
    (hi₃' : i₃' = data.i₃ r' pq')
    (n₀ n₁ n₂ : ℤ) (hn₁' : n₁ = data.deg pq')
    (hn₁ : n₀ + 1 = n₁ := by lia) (hn₂ : n₁ + 1 = n₂ := by lia) :
    (kf' X data r r' hrr' hr pq' pq''
      i₀' i₀ i₁ i₂ i₃ hi₀' hi₀ hi₁ hi₂ hi₃ n₀ n₁ n₂ hn₁' hn₁ hn₂).pt ⟶
    pageX X data r' pq' hr' :=
  X.mapFourδ₄Toδ₃' i₀' i₁ i₂ i₃ i₃'
      (data.le₀₁' r' hr' pq' hi₀' hi₁)
      (data.le₁₂' pq' hi₁ hi₂)
      (data.le₂₃' r hr pq' hi₂ hi₃)
      (data.le₃₃' hrr' hr pq' hi₃ hi₃')
      n₀ n₁ n₂ hn₁ hn₂ ≫
    (pageXIso X data r' hr' pq' i₀' i₁ i₂ i₃' hi₀' hi₁ hi₂ hi₃'
      n₀ n₁ n₂ hn₁' hn₁ hn₂).inv

set_option backward.isDefEq.respectTransparency false in
/-- The "mono half" `μ : pageX r' pq' ⟶ cc.pt` of the epi-mono factorisation
of `kf.ι ≫ cc.π`. It is the canonical `pageXIso` identifying `pageX r' pq'`
with `X.E (i₀' ≤ i₁ ≤ i₂ ≤ i₃')` composed with
`X.mapFourδ₁Toδ₀' i₀' i₀ i₁ i₂ i₃'`. -/
@[expose] noncomputable def μ
    (r r' : ℤ) (hrr' : r + 1 = r') (hr : r₀ ≤ r) (hr' : r₀ ≤ r')
    (pq pq' : κ)
    (i₀' i₀ i₁ i₂ i₃ i₃' : ι)
    (hi₀' : i₀' = data.i₀ r' pq')
    (hi₀ : i₀ = data.i₀ r pq')
    (hi₁ : i₁ = data.i₁ pq')
    (hi₂ : i₂ = data.i₂ pq')
    (hi₃ : i₃ = data.i₃ r pq')
    (hi₃' : i₃' = data.i₃ r' pq')
    (n₀ n₁ n₂ : ℤ) (hn₁' : n₁ = data.deg pq')
    (hn₁ : n₀ + 1 = n₁ := by lia) (hn₂ : n₁ + 1 = n₂ := by lia) :
    pageX X data r' pq' hr' ⟶
    (cc X data r r' hrr' hr pq pq'
      i₀ i₁ i₂ i₃ i₃' hi₀ hi₁ hi₂ hi₃ hi₃' n₀ n₁ n₂ hn₁' hn₁ hn₂).pt :=
  (pageXIso X data r' hr' pq' i₀' i₁ i₂ i₃' hi₀' hi₁ hi₂ hi₃'
      n₀ n₁ n₂ hn₁' hn₁ hn₂).hom ≫
    X.mapFourδ₁Toδ₀' i₀' i₀ i₁ i₂ i₃'
      (data.i₀_le' hrr' hr pq' hi₀' hi₀)
      (data.le₀₁' r hr pq' hi₀ hi₁)
      (data.le₁₂' pq' hi₁ hi₂)
      (data.le₂₃' r' hr' pq' hi₂ hi₃')
      n₀ n₁ n₂ hn₁ hn₂

instance (r r' : ℤ) (hrr' : r + 1 = r') (hr : r₀ ≤ r) (hr' : r₀ ≤ r')
    (pq' pq'' : κ) (i₀' i₀ i₁ i₂ i₃ i₃' : ι)
    (hi₀' : i₀' = data.i₀ r' pq') (hi₀ : i₀ = data.i₀ r pq')
    (hi₁ : i₁ = data.i₁ pq') (hi₂ : i₂ = data.i₂ pq')
    (hi₃ : i₃ = data.i₃ r pq') (hi₃' : i₃' = data.i₃ r' pq')
    (n₀ n₁ n₂ : ℤ) (hn₁' : n₁ = data.deg pq')
    (hn₁ : n₀ + 1 = n₁) (hn₂ : n₁ + 1 = n₂) :
    Epi (π X data r r' hrr' hr hr' pq' pq''
      i₀' i₀ i₁ i₂ i₃ i₃' hi₀' hi₀ hi₁ hi₂ hi₃ hi₃' n₀ n₁ n₂ hn₁' hn₁ hn₂) := by
  dsimp [π]
  infer_instance

instance (r r' : ℤ) (hrr' : r + 1 = r') (hr : r₀ ≤ r) (hr' : r₀ ≤ r')
    (pq pq' : κ) (i₀' i₀ i₁ i₂ i₃ i₃' : ι)
    (hi₀' : i₀' = data.i₀ r' pq') (hi₀ : i₀ = data.i₀ r pq')
    (hi₁ : i₁ = data.i₁ pq') (hi₂ : i₂ = data.i₂ pq')
    (hi₃ : i₃ = data.i₃ r pq') (hi₃' : i₃' = data.i₃ r' pq')
    (n₀ n₁ n₂ : ℤ) (hn₁' : n₁ = data.deg pq')
    (hn₁ : n₀ + 1 = n₁) (hn₂ : n₁ + 1 = n₂) :
    Mono (μ X data r r' hrr' hr hr' pq pq'
      i₀' i₀ i₁ i₂ i₃ i₃' hi₀' hi₀ hi₁ hi₂ hi₃ hi₃' n₀ n₁ n₂ hn₁' hn₁ hn₂) := by
  dsimp [μ]
  infer_instance

/-- The epi-mono factorisation equation `kf.ι ≫ cc.π = π ≫ μ`. -/
lemma fac (r r' : ℤ) (hrr' : r + 1 = r') (hr : r₀ ≤ r) (hr' : r₀ ≤ r')
    (pq pq' pq'' : κ) (i₀' i₀ i₁ i₂ i₃ i₃' : ι)
    (hi₀' : i₀' = data.i₀ r' pq') (hi₀ : i₀ = data.i₀ r pq')
    (hi₁ : i₁ = data.i₁ pq') (hi₂ : i₂ = data.i₂ pq')
    (hi₃ : i₃ = data.i₃ r pq') (hi₃' : i₃' = data.i₃ r' pq')
    (n₀ n₁ n₂ : ℤ) (hn₁' : n₁ = data.deg pq')
    (hn₁ : n₀ + 1 = n₁ := by lia) (hn₂ : n₁ + 1 = n₂ := by lia) :
    (kf' X data r r' hrr' hr pq' pq''
        i₀' i₀ i₁ i₂ i₃ hi₀' hi₀ hi₁ hi₂ hi₃ n₀ n₁ n₂ hn₁' hn₁ hn₂).ι ≫
      (cc X data r r' hrr' hr pq pq'
        i₀ i₁ i₂ i₃ i₃' hi₀ hi₁ hi₂ hi₃ hi₃' n₀ n₁ n₂ hn₁' hn₁ hn₂).π =
    π X data r r' hrr' hr hr' pq' pq'' i₀' i₀ i₁ i₂ i₃ i₃'
        hi₀' hi₀ hi₁ hi₂ hi₃ hi₃' n₀ n₁ n₂ hn₁' hn₁ hn₂ ≫
      μ X data r r' hrr' hr hr' pq pq' i₀' i₀ i₁ i₂ i₃ i₃'
        hi₀' hi₀ hi₁ hi₂ hi₃ hi₃' n₀ n₁ n₂ hn₁' hn₁ hn₂ := by
  unfold π μ
  show (X.mapFourδ₁Toδ₀' i₀' i₀ i₁ i₂ i₃ _ _ _ _ n₀ n₁ n₂ hn₁ hn₂ ≫
        (pageXIso X data r hr pq' i₀ i₁ i₂ i₃ hi₀ hi₁ hi₂ hi₃
          n₀ n₁ n₂ hn₁' hn₁ hn₂).inv) ≫
      ((pageXIso X data r hr pq' i₀ i₁ i₂ i₃ hi₀ hi₁ hi₂ hi₃
          n₀ n₁ n₂ hn₁' hn₁ hn₂).hom ≫
        X.mapFourδ₄Toδ₃' i₀ i₁ i₂ i₃ i₃' _ _ _ _ n₀ n₁ n₂ hn₁ hn₂) =
    (X.mapFourδ₄Toδ₃' i₀' i₁ i₂ i₃ i₃' _ _ _ _ n₀ n₁ n₂ hn₁ hn₂ ≫
        (pageXIso X data r' hr' pq' i₀' i₁ i₂ i₃' hi₀' hi₁ hi₂ hi₃'
          n₀ n₁ n₂ hn₁' hn₁ hn₂).inv) ≫
      ((pageXIso X data r' hr' pq' i₀' i₁ i₂ i₃' hi₀' hi₁ hi₂ hi₃'
          n₀ n₁ n₂ hn₁' hn₁ hn₂).hom ≫
        X.mapFourδ₁Toδ₀' i₀' i₀ i₁ i₂ i₃' _ _ _ _ n₀ n₁ n₂ hn₁ hn₂)
  rw [Category.assoc, Iso.inv_hom_id_assoc]
  conv_rhs => rw [Category.assoc, Iso.inv_hom_id_assoc]
  exact X.mapFourδ₁Toδ₀'_mapFourδ₃Toδ₃' i₀' i₀ i₁ i₂ i₃ i₃'
    (data.i₀_le' hrr' hr pq' hi₀' hi₀)
    (data.le₀₁' r hr pq' hi₀ hi₁)
    (data.le₁₂' pq' hi₁ hi₂)
    (data.le₂₃' r hr pq' hi₂ hi₃)
    (data.le₃₃' hrr' hr pq' hi₃ hi₃')
    n₀ n₁ n₂ hn₁ hn₂

/-- The `ShortComplex.HomologyData` for the `r`th page's short complex
at `pq'`. The `H` field is `pageX r' pq'`. This packages `kf`, `cc`, the
epi-mono factorisation `fac`, and the `Epi`/`Mono` instances on `π`/`μ`
into a `HomologyData` via `ShortComplex.HomologyData.ofEpiMonoFactorisation`. -/
noncomputable def homologyData [X.HasSpectralSequence data]
    (r r' : ℤ) (hrr' : r + 1 = r') (hr : r₀ ≤ r) (hr' : r₀ ≤ r')
    (pq pq' pq'' : κ) (hpq : (c r).prev pq' = pq) (hpq' : (c r).next pq' = pq'')
    (i₀' i₀ i₁ i₂ i₃ i₃' : ι)
    (hi₀' : i₀' = data.i₀ r' pq') (hi₀ : i₀ = data.i₀ r pq')
    (hi₁ : i₁ = data.i₁ pq') (hi₂ : i₂ = data.i₂ pq')
    (hi₃ : i₃ = data.i₃ r pq') (hi₃' : i₃' = data.i₃ r' pq')
    (n₀ n₁ n₂ : ℤ) (hn₁' : n₁ = data.deg pq')
    (hn₁ : n₀ + 1 = n₁ := by lia) (hn₂ : n₁ + 1 = n₂ := by lia) :
    ((page X data r hr).sc' pq pq' pq'').HomologyData :=
  ShortComplex.HomologyData.ofEpiMonoFactorisation
    (S := (page X data r hr).sc' pq pq' pq'')
    (kf := kf' X data r r' hrr' hr pq' pq''
      i₀' i₀ i₁ i₂ i₃ hi₀' hi₀ hi₁ hi₂ hi₃ n₀ n₁ n₂ hn₁' hn₁ hn₂)
    (cc := cc X data r r' hrr' hr pq pq'
      i₀ i₁ i₂ i₃ i₃' hi₀ hi₁ hi₂ hi₃ hi₃' n₀ n₁ n₂ hn₁' hn₁ hn₂)
    (isLimitKf' X data r r' hrr' hr pq' pq'' hpq'
      i₀' i₀ i₁ i₂ i₃ hi₀' hi₀ hi₁ hi₂ hi₃ n₀ n₁ n₂ hn₁' hn₁ hn₂)
    (isColimitCc X data r r' hrr' hr pq pq' hpq
      i₀ i₁ i₂ i₃ i₃' hi₀ hi₁ hi₂ hi₃ hi₃' n₀ n₁ n₂ hn₁' hn₁ hn₂)
    (H := pageX X data r' pq' hr')
    (π := π X data r r' hrr' hr hr' pq' pq'' i₀' i₀ i₁ i₂ i₃ i₃'
      hi₀' hi₀ hi₁ hi₂ hi₃ hi₃' n₀ n₁ n₂ hn₁' hn₁ hn₂)
    (ι := μ X data r r' hrr' hr hr' pq pq' i₀' i₀ i₁ i₂ i₃ i₃'
      hi₀' hi₀ hi₁ hi₂ hi₃ hi₃' n₀ n₁ n₂ hn₁' hn₁ hn₂)
    (fac X data r r' hrr' hr hr' pq pq' pq'' i₀' i₀ i₁ i₂ i₃ i₃'
      hi₀' hi₀ hi₁ hi₂ hi₃ hi₃' n₀ n₁ n₂ hn₁' hn₁ hn₂)

end HomologyData

/-- The `ShortComplex.HomologyData` for the canonical short complex
`(page r).sc' ((c r).prev pq') pq' ((c r).next pq')`, with `H = pageX r' pq'`.
This is the per-`pq` packaging of `HomologyData.homologyData`. -/
noncomputable def spectralSequenceHomologyData [X.HasSpectralSequence data]
    (r r' : ℤ) (hrr' : r + 1 = r') (hr : r₀ ≤ r) (pq' : κ) :
    ((page X data r hr).sc' ((c r).prev pq') pq' ((c r).next pq')).HomologyData :=
  HomologyData.homologyData X data r r' hrr' hr (by lia)
    ((c r).prev pq') pq' ((c r).next pq')
    rfl rfl
    (data.i₀ r' pq') (data.i₀ r pq') (data.i₁ pq')
    (data.i₂ pq') (data.i₃ r pq') (data.i₃ r' pq')
    rfl rfl rfl rfl rfl rfl
    (data.deg pq' - 1) (data.deg pq') (data.deg pq' + 1) rfl

/-- The spectral sequence of a spectral object `X : SpectralObject C ι`,
constructed from the data `data : SpectralSequenceDataCore ι c r₀` given
`X.HasSpectralSequence data`. The `r`th page is `page X data r hr` (a
homological complex of shape `c r`); the `iso` field identifies the
homology of the `r`th page at `pq` with the next page's object at `pq`
via `spectralSequenceHomologyData`. -/
noncomputable def _root_.CategoryTheory.Abelian.SpectralObject.spectralSequence
    [X.HasSpectralSequence data] :
    SpectralSequence C c r₀ where
  page r hr := page X data r hr
  iso r r' pq hrr' hr :=
    have : ((page X data r hr).sc' ((c r).prev pq) pq ((c r).next pq)).HasHomology :=
      ShortComplex.HasHomology.mk'
        (spectralSequenceHomologyData X data r r' hrr' hr pq)
    (page X data r hr).homologyIsoSc' _ _ _ rfl rfl ≪≫
      (spectralSequenceHomologyData X data r r' hrr' hr pq).left.homologyIso

end SpectralSequence

end SpectralObject

end Abelian

end CategoryTheory

/-!
## Non-vacuous evaluation

A user-facing sanity check: feed `coreE₂CohomologicalNat` and any
first-quadrant `SpectralObject C EInt` to obtain a non-trivial spectral
sequence. The first-quadrant hypothesis automatically provides the
`HasSpectralSequence` typeclass (see
`Mathlib.Algebra.Homology.SpectralObject.HasSpectralSequence`, line 383).

The evaluation here builds the spectral sequence object as a term and
extracts its page-2 object at `(0, 0)`, which by `pageX` reduces to
`X.E (i₀ 2 (0,0) ≤ i₁ (0,0) ≤ i₂ (0,0) ≤ i₃ 2 (0,0))` at degree
`data.deg (0,0) = 0`. This is a genuine spectral-object cell of `X`,
not a subsingleton placeholder. -/

namespace CategoryTheory.Abelian.SpectralObject.SpectralSequence

noncomputable example {C : Type*} [Category* C] [Abelian C]
    (Y : SpectralObject C EInt) [Y.IsFirstQuadrant] :
    SpectralSequence C (fun r ↦ ComplexShape.spectralSequenceNat (⟨r, 1 - r⟩ : ℤ × ℤ)) 2 :=
  Abelian.SpectralObject.spectralSequence Y coreE₂CohomologicalNat

/-- Non-vacuous: the page-2 object of the SS at `(0, 0)` is the
spectral-object cell `Y.E i₀ i₁ i₂ i₃` with the indices given by
`coreE₂CohomologicalNat`, NOT a subsingleton. -/
example {C : Type*} [Category* C] [Abelian C]
    (Y : SpectralObject C EInt) [Y.IsFirstQuadrant] :
    ((Abelian.SpectralObject.spectralSequence Y coreE₂CohomologicalNat).page 2).X (0, 0) =
      pageX Y coreE₂CohomologicalNat 2 (0, 0) := rfl

end CategoryTheory.Abelian.SpectralObject.SpectralSequence
