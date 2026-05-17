# UC-Lean-Z1-SpectralObjectAssembly state — mg-4165

**Verdict.** AMBER — substantive cokernel-cofork side delivered + dual primitives + iso-cancellation building block; closure of `homologyData` + `spectralSequenceHomologyData` + `Abelian.SpectralObject.spectralSequence` deferred to Z1b follow-on due to Lean-side typeclass-search issue with the primed `mapFourδ` abbreviations.

## What this polecat landed (deliverable 1: cokernel cofork)

New file `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/SpectralSequenceAssembly.lean` (~ 220 lines) inside
the `CategoryTheory.Abelian.SpectralObject.SpectralSequence.HomologyData` namespace, mirroring the existing kernel-fork side from `Mathlib.Algebra.Homology.SpectralObject.SpectralSequence` (Joël Riou):

* `cc_w X data r r' hrr' hr pq pq' i₀ i₁ i₂ i₃ i₃' hi₀ hi₁ hi₂ hi₃ hi₃' n₀ n₁ n₂ hn₁'` — the
  vanishing equation `(page r).d pq pq' ≫ ((pageXIso ...).hom ≫ mapFourδ₄Toδ₃' i₀ i₁ i₂ i₃ i₃' ...) = 0`.
  Proof: favourable case `(c r).Rel pq pq'` uses `pageD_eq` to expand into spectral-object
  primitives and then `d_map_fourδ₄Toδ₃_assoc` to discharge; unfavourable case uses
  `HomologicalComplex.shape`.

* `cc X data r r' hrr' hr pq pq' i₀ i₁ i₂ i₃ i₃' hi₀ hi₁ hi₂ hi₃ hi₃' n₀ n₁ n₂ hn₁'` —
  a `CokernelCofork ((page r).d pq pq')` whose point identifies to `X.E i₀ i₁ i₂ i₃'`.
  Dual to mathlib's existing `kf` (kernel-fork on the next-differential side).

* `ccSc` — the (exact) short complex packaging `cc_w`, with `@[simps!]` accessors.

* `instance : Epi ccSc.g` — the cokernel-cofork-extension map is an epimorphism (via
  `dsimp` + `infer_instance` on `pageXIso.hom ≫ mapFourδ₄Toδ₃'`).

* `isIso_mapFourδ₄Toδ₃'_of_no_rel` — dual of `isIso_mapFourδ₁Toδ₀'`: when no
  differential lands at `pq'` from `pq`, `mapFourδ₄Toδ₃' i₀ i₁ i₂ i₃ i₃' ...` is an
  iso (via `X.isIso_mapFourδ₄Toδ₃'` from `EpiMono.lean` + the
  `isZero_H_obj_mk₁_i₃_le'` from `HasSpectralSequence`).

* `ccSc_exact` — exactness of `ccSc`. Favourable case uses
  `ShortComplex.exact_of_iso (Iso.symm ...)` and transports
  `dCokernelSequence_exact`. Unfavourable case uses `ShortComplex.exact_iff_mono`
  + the `isIso_mapFourδ₄Toδ₃'_of_no_rel` above.

* `isColimitCc` — the colimit witness for `cc`, via `ShortComplex.Exact.gIsCokernel`.

All zero new sorrys, zero new axioms; everything routes through mathlib
spectral-object primitives.

**Build.** `lake build` GREEN, 1178 jobs (no change in mathlib oleans; one
new local olean for `SpectralSequenceAssembly`).

## What is deferred — the AMBER gap (deliverables 2–5)

The intended construction for the remaining four deliverables is straightforward in
mathematics: 

1. **Epi-mono factorisation `fac`** — the equation
   `kf.ι ≫ cc.π = mapFourδ₄Toδ₃' i₀' i₁ i₂ i₃ i₃' ≫ mapFourδ₁Toδ₀' i₀' i₀ i₁ i₂ i₃'`.
   The LHS expands to `(mapFourδ₁Toδ₀' ≫ pageXIso(r pq').inv) ≫ (pageXIso(r pq').hom ≫ mapFourδ₄Toδ₃')`
   which after iso cancellation is `mapFourδ₁Toδ₀' i₀' i₀ i₁ i₂ i₃ ≫ mapFourδ₄Toδ₃' i₀ i₁ i₂ i₃ i₃'`.
   By `mapFourδ₁Toδ₀'_mapFourδ₃Toδ₃'` (`EpiMono.lean` line 167), this equals
   `mapFourδ₄Toδ₃' i₀' i₁ i₂ i₃ i₃' ≫ mapFourδ₁Toδ₀' i₀' i₀ i₁ i₂ i₃'`.

2. **`SpectralObject.SpectralSequence.homologyData`** — feed `kf`, `cc`,
   `isLimitKf`, `isColimitCc`, the epi `mapFourδ₄Toδ₃' i₀' i₁ i₂ i₃ i₃'`, the mono
   `mapFourδ₁Toδ₀' i₀' i₀ i₁ i₂ i₃'`, and `fac` into
   `ShortComplex.HomologyData.ofEpiMonoFactorisation`. Result: a `HomologyData` for
   `(page r).sc' pq pq' pq''` with `H = pageX r' pq'`.

3. **`spectralSequenceHomologyData`** — instantiate `homologyData` at canonical
   `pq = (c r).prev pq'`, `pq'' = (c r).next pq'`, and canonical
   `i₀' = data.i₀ r' pq'`, ..., `i₃' = data.i₃ r' pq'`, all with `rfl` proofs.

4. **`Abelian.SpectralObject.spectralSequence`** — build the `SpectralSequence C c r₀`
   with `page r hr := page X data r hr` and
   `iso r r' pq hrr' hr := homologyMapIso (isoSc' rfl rfl) ≪≫ (spectralSequenceHomologyData ...).left.homologyIso`.

### The blocker (the AMBER gap)

When attempting `ShortComplex.HomologyData.ofEpiMonoFactorisation` with
`π := X.mapFourδ₄Toδ₃' i₀' i₁ i₂ i₃ i₃' ...` and
`ι := X.mapFourδ₁Toδ₀' i₀' i₀ i₁ i₂ i₃' ...`, Lean's typeclass synthesis
**cannot find** `Epi (X.mapFourδ₄Toδ₃' ...)` or `Mono (X.mapFourδ₁Toδ₀' ...)`,
even though mathlib's `EpiMono.lean` lines 79–81 + 110–112 register the
corresponding instances for the UNPRIMED form
`Epi (X.map ... (fourδ₄Toδ₃ ...) ...)` and the primed `mapFourδ₄Toδ₃'` is just an
abbreviation of the unprimed.

Various unfoldings were tried (`dsimp only [SpectralObject.mapFourδ₄Toδ₃',
ComposableArrows.fourδ₄Toδ₃']`, `unfold SpectralObject.mapFourδ₄Toδ₃'`,
`show Epi (X.map _ _ _ _ _ _ _ _ _ _ _ _)`, `inferInstanceAs`) but none of them
makes `infer_instance` succeed when the goal is stated in the primed-abbreviation
form. Direct construction via `X.epi_map _ _ _ _ _ _ _ _ _ rfl rfl rfl hn₁ hn₂ rfl`
also fails: Lean's unification assigns the same metavariable to `f₃` and `f₃'`
(distinct positions in the `mk₃` morphism), producing a wrong unifier.

The same blocker presumably arose in mathlib itself (which is why these primed-form
instances do NOT appear in `EpiMono.lean`; one has to go through `dsimp` to unfold
the abbreviation before instance synthesis fires). Our usage of
`ofEpiMonoFactorisation` requires the typeclass argument `[Epi π]` to be solved at
the call site, BEFORE we have an opportunity to `dsimp` on the goal — which is
why the same trick that works for our `ccSc.g` instance (a `dsimp; infer_instance`
inside an instance-proof body) does not apply.

The likely root cause is that `SpectralObject.mapFourδ₄Toδ₃'` lives in a section
where `X' : SpectralObject C ι'` is typed with `[Preorder ι']` rather than
`[Category* ι]` (the latter is the context of the unprimed instance). Lean's
instance search does not, in this case, automatically bridge from the Category
instance to the Preorder-derived smallCategory instance under the abbreviation.

### Resolution paths for Z1b

* **Z1b-A**: Add explicit `instance` declarations for
  `Epi (X.mapFourδ₄Toδ₃' ...)` and `Mono (X.mapFourδ₁Toδ₀' ...)` at top level
  of `SpectralObject/EpiMono.lean` (or `SpectralSequenceAssembly.lean`), each
  delegating to `inferInstanceAs` via a `show`. This is upstream-clean and likely
  the right fix for mathlib.

* **Z1b-B**: Define `homologyData` via an alternative path that does not require
  `ofEpiMonoFactorisation`'s typeclass synthesis — e.g. build `LeftHomologyData`
  and `RightHomologyData` directly with explicit `Epi`/`Mono` proofs threaded
  through, then assemble `HomologyData`.

* **Z1b-C**: Bypass the typeclass blocker by constructing the iso
  `(page r).homology pq ≅ pageX r' pq` directly (without going through a
  `HomologyData` with `H = pageX r' pq'`) via the canonical abelian
  `S.homology` + a separate iso `S.homology ≅ pageX r' pq` derived from
  `image.isoStrongEpiMono`.

Recommendation: Z1b-A (~ 50 lines) is the cleanest, most upstream-PR-clean path
and would unblock Z1's GREEN closure in a single short session.

## Acceptance bar (per scoping doc §0 + §Z1)

| Bar | Status | Note |
|-----|--------|------|
| 1. `lake build` GREEN | ✅ | 1178 jobs, no new errors |
| 2. Non-vacuous (feed `coreE₂CohomologicalNat` etc) | ❌ | Deferred with deliverables 3–5 |
| 3. Mathlib-PR-clean naming, docstrings, Joël-Riou-style | ✅ | Matches existing `kf`/`kfSc`/... naming verbatim; full docstrings; Riou attribution in header |
| 4. Zero new sorrys | ✅ | None added |
| 5. Zero new axioms | ✅ | None |
| 6. No fake mathlib API | ✅ | Only existing primitives |
| 7. No defeq bypass | ✅ | Substantive proofs via `pageD_eq` + `d_map_fourδ₄Toδ₃` + `dCokernelSequence_exact` + `isZero_H_obj_mk₁_i₃_le'` |
| 8. No `False.elim` shortcuts | ✅ | None |
| 9. Type-correct | ✅ | No metavariable cheats |
| 10. MATHLIB-FOLDER scope respected | ✅ | Only the new `SpectralObject/SpectralSequenceAssembly.lean` file touched + `UnionClosed.lean` import |
| 11. Bicomplex-feeding readiness | (n/a — deferred) | Z2 cannot consume yet without deliverables 2–5 |
| 12. No L+X+Y dependencies | ✅ | New file imports only `Mathlib.Algebra.Homology.SpectralObject.SpectralSequence` (and transitively) |

## Mathematical contribution (non-vacuous in the dual direction)

The cokernel-cofork side is genuinely new code, not a copy of `kf`. Specifically:
* `cc_w`'s favourable-case proof routes through `d_map_fourδ₄Toδ₃_assoc` — the
  dual of `kf_w`'s `map_fourδ₁Toδ₀_d_assoc` — and crucially exhibits the
  `i₃_next`-trick at `(by simpa only [hi₃', data.i₃_next r r' _ _ h] using
  data.le₂₃ r pq)` to lift `i₃' = data.i₃ r' pq'` to `data.i₂ pq` (the dual of
  kf's `i₀_prev` trick).
* `ccSc_exact`'s favourable case applies `dCokernelSequence_exact` at degrees
  `(n₀ - 1) n₀ n₁ n₂` — note the `(n₀ - 1)` for the lower-degree argument, which
  arises because the cc-cofork is on the INCOMING differential (degree shift one
  below pq' rather than one above as in kf's outgoing case).
* `isIso_mapFourδ₄Toδ₃'_of_no_rel` uses `isZero_H_obj_mk₁_i₃_le'` — the
  `HasSpectralSequence` axiom about the upper bound — vs `kf`'s
  `isZero_H_obj_mk₁_i₀_le'` for the lower bound.

These three primitives ARE the substantive mathematical content of
deliverable 1 + dual-side support for deliverable 2 (the epi-mono fac, blocked
by the AMBER typeclass issue).

## Files touched

* NEW: `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/SpectralSequenceAssembly.lean` (~ 220 lines).
* MODIFIED: `lean/UnionClosed.lean` (one new import).
* NEW: `docs/state-UC-Lean-Z1.md` (this file).
* MODIFIED: `docs/state-UC10.md` (Lean-Session 36 entry).

## Forward operational step

* Daniel reviews this AMBER state and decides:
  - File Z1b (UC-Lean-Z1b-EpiMonoInstances) — short session, ~ 50 lines, registers
    `Epi (X.mapFourδ₄Toδ₃' ...)` and `Mono (X.mapFourδ₁Toδ₀' ...)` instances at top
    level + completes deliverables 2–5.
  - OR continue with deliverable-1-only AMBER and defer deliverables 2–5 to the
    Z2 dispatch (which can absorb the homologyData assembly as part of its own
    bicomplex SpectralObject construction).

The cokernel-cofork side here will be consumed BY deliverable 3
(`homologyData`'s `cc` argument) whenever Z1b lands — no rework needed.
