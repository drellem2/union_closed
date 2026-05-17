# UC-Lean-Z1b-EpiMonoInstances state — mg-a298

**Verdict.** GREEN — Z1 scope fully closed. Phase A typeclass-synthesis blocker resolved via path A (explicit instance declarations); Phase B deliverables 2–5 (epi-mono `fac`, `homologyData`, `spectralSequenceHomologyData`, `Abelian.SpectralObject.spectralSequence`) all landed substantively with non-vacuous evaluation. `lake build` GREEN (2027 jobs unchanged from Lean-Session 36 baseline). Z2 unblocked.

## What Phase A landed (typeclass synthesis fix)

Two explicit top-level `instance` declarations at namespace `CategoryTheory.Abelian.SpectralObject`:

```lean
instance epi_mapFourδ₄Toδ₃' (X : SpectralObject C ι)
    (i₀ i₁ i₂ i₃ i₄ : ι) (hi₀₁ : i₀ ≤ i₁) (hi₁₂ : i₁ ≤ i₂)
    (hi₂₃ : i₂ ≤ i₃) (hi₃₄ : i₃ ≤ i₄)
    (n₀ n₁ n₂ : ℤ) (hn₁ : n₀ + 1 = n₁) (hn₂ : n₁ + 1 = n₂) :
    Epi (X.mapFourδ₄Toδ₃' i₀ i₁ i₂ i₃ i₄ hi₀₁ hi₁₂ hi₂₃ hi₃₄ n₀ n₁ n₂ hn₁ hn₂) :=
  X.epi_map (homOfLE hi₀₁) (homOfLE hi₁₂) (homOfLE hi₂₃) (homOfLE (hi₂₃.trans hi₃₄))
    _ _ _ _ _ rfl rfl rfl hn₁ hn₂ rfl

instance mono_mapFourδ₁Toδ₀' (X : SpectralObject C ι)
    (i₀ i₁ i₂ i₃ i₄ : ι) (hi₀₁ : i₀ ≤ i₁) (hi₁₂ : i₁ ≤ i₂)
    (hi₂₃ : i₂ ≤ i₃) (hi₃₄ : i₃ ≤ i₄)
    (n₀ n₁ n₂ : ℤ) (hn₁ : n₀ + 1 = n₁) (hn₂ : n₁ + 1 = n₂) :
    Mono (X.mapFourδ₁Toδ₀' i₀ i₁ i₂ i₃ i₄ hi₀₁ hi₁₂ hi₂₃ hi₃₄ n₀ n₁ n₂ hn₁ hn₂) :=
  X.mono_map (homOfLE (hi₀₁.trans hi₁₂)) (homOfLE hi₁₂) (homOfLE hi₂₃) (homOfLE hi₃₄)
    _ _ _ _ _ rfl rfl rfl hn₁ hn₂ rfl
```

The mg-4165 diagnostic established that bare `X.epi_map _ _ _ _ _ _ _ _ _ rfl rfl rfl hn₁ hn₂ rfl` (9 underscores) fails because Lean's unification collapses `f₃` and `f₃'` to the same metavariable. Spelling out the four `f` arguments explicitly via `homOfLE hi₀₁`, `homOfLE hi₁₂`, `homOfLE hi₂₃`, `homOfLE (hi₂₃.trans hi₃₄)` for the epi case (and analogous for mono) breaks the collision and lets Lean's unification proceed cleanly. The body delegates to mathlib's `X.epi_map` / `X.mono_map` lemmas from `Mathlib.Algebra.Homology.SpectralObject.EpiMono` lines 43–58.

Probe sequence: bare `X.epi_map _ _ _ _ _ _ _ _ _ rfl rfl rfl hn₁ hn₂ rfl` fails with "Type mismatch ... `?m.46 ?m.47 ?m.48 ?m.48 ?m.50` has type `Epi (X.map ?m.46 ?m.47 ?m.48 ?m.46 ?m.47 ?m.48 ?m.50 ...)`" (the `?m.48` repeated reveals the f₃/f₃' conflation). Adding the four explicit `homOfLE` args pins f₁, f₂, f₃, f₃' distinctly, and the call type-checks. Wrapping in `instance ...` then enables downstream `infer_instance` for goals of the primed form.

This is the upstream-clean fix; identical instances could be moved to `Mathlib.Algebra.Homology.SpectralObject.EpiMono` upstream if Daniel drops the local-only directive.

## What Phase B landed (deliverables 2–5)

### Deliverable 2 — epi-mono factorisation

The `π` (epi half) and `μ` (mono half) morphisms:

```lean
@[expose] noncomputable def π (..hr' : r₀ ≤ r'..) :
    (kf' X data r r' hrr' hr pq' pq'' ...).pt ⟶ pageX X data r' pq' hr' :=
  X.mapFourδ₄Toδ₃' i₀' i₁ i₂ i₃ i₃' ... n₀ n₁ n₂ hn₁ hn₂ ≫
    (pageXIso X data r' hr' pq' i₀' i₁ i₂ i₃' ...).inv

@[expose] noncomputable def μ (..hr' : r₀ ≤ r'..) :
    pageX X data r' pq' hr' ⟶ (cc X data r r' hrr' hr pq pq' ...).pt :=
  (pageXIso X data r' hr' pq' i₀' i₁ i₂ i₃' ...).hom ≫
    X.mapFourδ₁Toδ₀' i₀' i₀ i₁ i₂ i₃' ... n₀ n₁ n₂ hn₁ hn₂
```

Both have `Epi (π)` and `Mono (μ)` instances proven via `dsimp [π/μ] ; infer_instance` — the dsimp unfolds the abbreviation, then `infer_instance` chains via mathlib's `epi_comp` / `mono_comp` (composition lemma) + the Phase A explicit instance for the primed `mapFourδ₄Toδ₃'` / `mapFourδ₁Toδ₀'` + IsIso instance on the pageXIso's `.inv` / `.hom`.

The `fac` lemma proving `kf'.ι ≫ cc.π = π ≫ μ`:

```lean
lemma fac ... :
    (kf' X data r r' hrr' hr pq' pq'' ...).ι ≫
      (cc X data r r' hrr' hr pq pq' ...).π =
    π X data r r' hrr' hr hr' pq' pq'' ... ≫
      μ X data r r' hrr' hr hr' pq pq' ... := by
  unfold π μ
  show (X.mapFourδ₁Toδ₀' ... ≫ (pageXIso X data r hr pq' ...).inv) ≫
      ((pageXIso X data r hr pq' ...).hom ≫ X.mapFourδ₄Toδ₃' ...) = ...
  rw [Category.assoc, Iso.inv_hom_id_assoc]
  conv_rhs => rw [Category.assoc, Iso.inv_hom_id_assoc]
  exact X.mapFourδ₁Toδ₀'_mapFourδ₃Toδ₃' i₀' i₀ i₁ i₂ i₃ i₃' ... n₀ n₁ n₂ hn₁ hn₂
```

The proof strategy: unfold π and μ to expose the iso compositions, then `show` to manually unfold `kf'.ι` and `cc.π` to their `KernelFork.ofι ι w`-then-`.ι` and `CokernelCofork.ofπ π w`-then-`.π` forms. Two `Category.assoc` + `Iso.inv_hom_id_assoc` rewrites (one on the LHS, one on the RHS via `conv_rhs`) cancel the `pageXIso.inv ≫ pageXIso.hom` factors on both sides, reducing the goal to `mapFourδ₁Toδ₀' i₀' i₀ i₁ i₂ i₃ ≫ mapFourδ₄Toδ₃' i₀ i₁ i₂ i₃ i₃' = mapFourδ₄Toδ₃' i₀' i₁ i₂ i₃ i₃' ≫ mapFourδ₁Toδ₀' i₀' i₀ i₁ i₂ i₃'` — exactly the conclusion of mathlib's `mapFourδ₁Toδ₀'_mapFourδ₃Toδ₃'` swap lemma (`EpiMono.lean` line 167) with appropriate index renaming.

### Deliverable 3 — `homologyData`

```lean
noncomputable def homologyData [X.HasSpectralSequence data]
    (r r' : ℤ) (hrr' : r + 1 = r') (hr : r₀ ≤ r) (hr' : r₀ ≤ r')
    (pq pq' pq'' : κ) (hpq : (c r).prev pq' = pq) (hpq' : (c r).next pq' = pq'')
    ... :
    ((page X data r hr).sc' pq pq' pq'').HomologyData :=
  ShortComplex.HomologyData.ofEpiMonoFactorisation
    (S := (page X data r hr).sc' pq pq' pq'')
    (kf := kf' X data r r' hrr' hr pq' pq'' ...)
    (cc := cc X data r r' hrr' hr pq pq' ...)
    (isLimitKf' X data r r' hrr' hr pq' pq'' hpq' ...)
    (isColimitCc X data r r' hrr' hr pq pq' hpq ...)
    (H := pageX X data r' pq' hr')
    (π := π X data r r' hrr' hr hr' pq' pq'' ...)
    (ι := μ X data r r' hrr' hr hr' pq pq' ...)
    (fac X data r r' hrr' hr hr' pq pq' pq'' ...)
```

Packages `kf'` (local copy of mathlib's `kf`), `cc` (Z1 mg-4165), `isLimitKf'` (local copy), `isColimitCc` (Z1 mg-4165), `H = pageX r' pq'`, `π`, `μ`, and `fac` into `ShortComplex.HomologyData.ofEpiMonoFactorisation` (`Mathlib.Algebra.Homology.ShortComplex.Abelian` line 349). Result: a `HomologyData` for the page-`r` short complex at `pq'` whose `H` field is `pageX r' pq'`.

### Deliverable 4 — `spectralSequenceHomologyData`

```lean
noncomputable def spectralSequenceHomologyData [X.HasSpectralSequence data]
    (r r' : ℤ) (hrr' : r + 1 = r') (hr : r₀ ≤ r) (pq' : κ) :
    ((page X data r hr).sc' ((c r).prev pq') pq' ((c r).next pq')).HomologyData :=
  HomologyData.homologyData X data r r' hrr' hr (by lia)
    ((c r).prev pq') pq' ((c r).next pq')
    rfl rfl (data.i₀ r' pq') (data.i₀ r pq') (data.i₁ pq')
    (data.i₂ pq') (data.i₃ r pq') (data.i₃ r' pq')
    rfl rfl rfl rfl rfl rfl
    (data.deg pq' - 1) (data.deg pq') (data.deg pq' + 1) rfl
```

Per-`pq'` packaging of Deliverable 3 at the canonical `pq = (c r).prev pq'`, `pq'' = (c r).next pq'`, and canonical indices `i₀' = data.i₀ r' pq'`, `i₀ = data.i₀ r pq'`, `i₁ = data.i₁ pq'`, `i₂ = data.i₂ pq'`, `i₃ = data.i₃ r pq'`, `i₃' = data.i₃ r' pq'`, all with `rfl` proofs.

### Deliverable 5 — `Abelian.SpectralObject.spectralSequence`

```lean
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
```

The user-facing constructor `SpectralSequence C c r₀`. The `page` field returns the homological complex `page X data r hr`. The `iso` field identifies the homology of the `r`th page at `pq` with `(page r').X pq = pageX r' pq` via the canonical chain `(page r).homology pq ≅ ((page r).sc' (prev pq) pq (next pq)).homology` (via `homologyIsoSc'`) ≅ `pageX r' pq` (via the `left.homologyIso` field of `spectralSequenceHomologyData`). The `HasHomology` typeclass for the `sc'` is supplied locally via `ShortComplex.HasHomology.mk'` applied to Deliverable 4.

This closes Joël Riou's three header-flagged TODOs in `Mathlib.Algebra.Homology.SpectralObject.SpectralSequence` (`Abelian.SpectralObject.SpectralSequence.homologyData`, `Abelian.SpectralObject.spectralSequenceHomologyData`, `Abelian.SpectralObject.spectralSequence`).

## What had to be replicated locally (kernel-fork side)

Mathlib's `Mathlib.Algebra.Homology.SpectralObject.SpectralSequence` defines the kernel-fork side declarations (`kf_w`, `kf`, `kfSc`, `isIso_mapFourδ₁Toδ₀'`, `kfSc_exact`, `isLimitKf`) inside its own `HomologyData` namespace. These build perfectly fine inside that module, but their signatures embed private auto-generated proofs that the new module system marks as `_private`:

```
data.i₀ r' pq'      with autoparam (hr := by lia)  → _private.…SpectralSequence.0._proof_27
data.i₀ r pq'       with autoparam (hr := by lia)  → _private.…SpectralSequence.0._proof_28
data.i₃ r pq'       with autoparam (hr := by lia)  → _private.…SpectralSequence.0._proof_n
```

When another module references these signatures (e.g. `kf.pt` to derive the source object of the kernel-fork morphism), the kernel needs to resolve these private proofs to compute the morphism's source type, but the new module system blocks the lookup with `(kernel) unknown constant '_private.…SpectralSequence.0._proof_27'`.

The workaround is verbatim local copies suffixed `'` (`kf_w'`, `kf'`, `kfSc'`, `isIso_mapFourδ₁Toδ₀'_local`, `kfSc_exact'`, `isLimitKf'`) — identical bodies, re-elaborated in this module so the `_proof_n` references are local (visible to this module's kernel).

The Z1 mg-4165 cokernel-fork side (`cc`, `cc_w`, `ccSc`, `isIso_mapFourδ₄Toδ₃'_of_no_rel`, `ccSc_exact`, `isColimitCc`) was already in our module and so didn't trigger this issue — only the kernel-fork side needs replication.

This duplication is purely a module-system bookkeeping requirement; once upstream mathlib replaces autoparam-discharged `data.i₀ r' pq'` (etc.) with explicit `data.i₀ r' pq' hr'` in `kf_w`'s signature, these local copies become redundant. Documented in the file header as the rationale for the duplication.

## Non-vacuous evaluation

Per scoping doc §Z1 bar 2: feeding `coreE₂CohomologicalNat` and any first-quadrant `SpectralObject C EInt`:

```lean
noncomputable example {C : Type*} [Category* C] [Abelian C]
    (Y : SpectralObject C EInt) [Y.IsFirstQuadrant] :
    SpectralSequence C (fun r ↦ ComplexShape.spectralSequenceNat (⟨r, 1 - r⟩ : ℤ × ℤ)) 2 :=
  Abelian.SpectralObject.spectralSequence Y coreE₂CohomologicalNat

example {C : Type*} [Category* C] [Abelian C]
    (Y : SpectralObject C EInt) [Y.IsFirstQuadrant] :
    ((Abelian.SpectralObject.spectralSequence Y coreE₂CohomologicalNat).page 2).X (0, 0) =
      pageX Y coreE₂CohomologicalNat 2 (0, 0) := rfl
```

The `[Y.IsFirstQuadrant]` instance auto-provides `[Y.HasSpectralSequence coreE₂CohomologicalNat]` via mathlib's `Mathlib.Algebra.Homology.SpectralObject.HasSpectralSequence` line 383. The page-2 object at `(0, 0)` reduces by `rfl` to `pageX Y coreE₂CohomologicalNat 2 (0, 0) = Y.E (homOfLE (data.le₀₁ 2 (0,0))) (homOfLE (data.le₁₂ (0,0))) (homOfLE (data.le₂₃ 2 (0,0))) (data.deg (0,0) - 1) (data.deg (0,0)) (data.deg (0,0) + 1)` — a genuine spectral-object cell of `Y` (not a subsingleton placeholder), with all four indices determined by `coreE₂CohomologicalNat`'s recipe.

## Acceptance bar (per scoping doc §0 + §Z1b)

| Bar | Status | Note |
|-----|--------|------|
| 1. `lake build` GREEN | ✅ | 2027 jobs unchanged from Lean-Session 36 baseline; same file extended |
| 2. Non-vacuous (feed `coreE₂CohomologicalNat` etc) | ✅ | Two `(noncomputable) example` lemmas at end of file witness the non-trivial first-quadrant SS |
| 3. Mathlib-PR-clean naming, docstrings, Joël-Riou-style | ✅ | Consistent with Z1 mg-4165's 220 lines; full docstrings on every new declaration; Riou attribution in file header |
| 4. Zero new sorrys | ✅ | None added; the existing `Frankl.lean` / `SSConvergence.lean` sorry counts unchanged |
| 5. Zero new axioms | ✅ | None |
| 6. No fake mathlib API | ✅ | Only existing mathlib primitives (`ofEpiMonoFactorisation`, `HasHomology.mk'`, `homologyIsoSc'`, `Iso.inv_hom_id_assoc`, etc.) |
| 7. No defeq bypass on homologyData assembly | ✅ | Substantive via `ofEpiMonoFactorisation` with full `kf` + `cc` + `isLimitKf'` + `isColimitCc` + `π` + `μ` + `fac` arguments; no rfl-bypass on the homology |
| 8. No `False.elim` shortcuts | ✅ | None |
| 9. Type-correct (no metavariable cheats) | ✅ | The Phase A typeclass-synthesis fix is the central concern; resolved with explicit-`f`-args path |
| 10. MATHLIB-FOLDER scope respected | ✅ | Only `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/SpectralSequenceAssembly.lean` modified; no new files |
| 11. Bicomplex-feeding readiness | ✅ | Z2 can consume `Abelian.SpectralObject.spectralSequence` directly; type signature verified compatible |
| 12. No L+X+Y dependencies | ✅ | New file imports only `Mathlib.Algebra.Homology.SpectralObject.SpectralSequence` (and transitively) |

## Files touched

* MODIFIED: `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/SpectralSequenceAssembly.lean` (~220 → ~638 lines).
* NEW: `docs/state-UC-Lean-Z1b.md` (this file).
* MODIFIED: `docs/state-UC10.md` (Lean-Session 37 entry).

## Forward operational step

Z2 (UC-Lean-Z2-BicomplexSpectralObject) dispatches as the next sequential execution ticket per Phase C critical path Z1 → Z2 → Z3 → (Z4 ∥ Z5) → Z6 → Z7 → Z8 → Z9 → Z10. The `Abelian.SpectralObject.spectralSequence` constructor + `spectralSequenceHomologyData` per-`pq` packaging are the user-facing inputs Z2's bicomplex→SpectralObject bridge will consume.
