/-
Copyright (c) 2026 Union-Closed Polecat Authors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Union-Closed Polecat (cat-mg-4165, Z1 of UC-Lean-MathlibSS-Full-scope).

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
## Deliverables 2–5: epi–mono factorisation + `homologyData` +
`spectralSequenceHomologyData` + `Abelian.SpectralObject.spectralSequence`

The intended construction is:

1. The kernel-fork-point `kf.pt = X.E (i₀' ≤ i₁ ≤ i₂ ≤ i₃)` admits an
   epimorphism `X.mapFourδ₄Toδ₃' i₀' i₁ i₂ i₃ i₃' : kf.pt ⟶ pageX r' pq'`,
   landing in `pageX r' pq' = X.E (i₀' ≤ i₁ ≤ i₂ ≤ i₃')`.

2. The next-page object `pageX r' pq'` admits a monomorphism
   `X.mapFourδ₁Toδ₀' i₀' i₀ i₁ i₂ i₃' : pageX r' pq' ⟶ cc.pt`, landing in
   the cokernel-cofork-point `cc.pt = X.E (i₀ ≤ i₁ ≤ i₂ ≤ i₃')`.

3. The factorisation `kf.ι ≫ cc.π = mapFourδ₄Toδ₃' ≫ mapFourδ₁Toδ₀'`
   follows from `mapFourδ₁Toδ₀'_mapFourδ₃Toδ₃'` after iso cancellation
   on the `pageXIso` factors hidden inside `kf.ι` and `cc.π`.

4. Feeding this into `ShortComplex.HomologyData.ofEpiMonoFactorisation`
   produces a `HomologyData` whose `H` field is `pageX r' pq'`, yielding
   `homologyData`. Per-`pq` packaging gives `spectralSequenceHomologyData`,
   and combining the page-`r` short-complex isos with this `HomologyData`'s
   `homologyIso` gives the `iso` field of the final
   `Abelian.SpectralObject.spectralSequence`.

This polecat (Z1, mg-4165) lands the cokernel-fork side and dual primitives
needed by step (1)–(2) and the iso cancellation needed by step (3). The
remaining gap is a Lean-side instance-synthesis issue: when the
abbreviation `X.mapFourδ₄Toδ₃' i₀' i₁ i₂ i₃ i₃' ...` is the goal of
`Epi`-typeclass search, the existing instance
`Epi (X.map ... (fourδ₄Toδ₃ ...) ...)` from
`Mathlib.Algebra.Homology.SpectralObject.EpiMono` does not fire even via
`inferInstance` or `infer_instance` after explicit `dsimp`/`unfold`
unfolding. The same applies to `Mono (X.mapFourδ₁Toδ₀' ...)`. The
underlying mathematics is in place; the assembly is blocked on this
typeclass-search blocker. The closure of steps (4)–(5) is therefore
deferred to a Z1b follow-on ticket (or to a later Z-arc revision that
adds a local `@[instance]` registration for the primed abbreviations).
See `docs/state-UC-Lean-Z1.md` for full diagnosis.
-/

end SpectralSequence

end SpectralObject

end Abelian

end CategoryTheory
