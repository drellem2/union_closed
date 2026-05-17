# UC-Lean-MathlibSS-Full-scope.md

**Scoping doc for the Path Z execution arc** — complete the mathlib `SpectralObject` infrastructure (the genuine `Abelian.SpectralObject.spectralSequence` TODO + bicomplex→SpectralObject bridge) **and** refactor the union_closed-internal X1–X5 + Y1–Y6 SS pieces to use it.

Ticket: **mg-103f** (`UC-Lean-MathlibSS-Full-scope`, polecat `cat-mg-103f`, Daniel directive 2026-05-17 12:47Z: *"full mathlib infrastructure imo. I don't want to hit yet another roadblock because we put off doing things the right way and kept pursuing shortcuts."*).

Paper-and-pencil only. Budget 400k. Default branch `main`. Mathlib pinned `v4.29.1`, rev `5e932f97dd25535344f80f9dd8da3aab83df0fe6` (per `lean/lake-manifest.json`).

Parent diagnoses:
- **mg-7413** (`UC-Lean-mathlib-SS-scope`, GREEN). Path A scoping; X1–X6 decomposition; §5.1 contingency entry explicitly named the SpectralObject TODO Z arc tackles ("If during X1 it turns out the direct-from-bicomplex SS construction requires the general `SpectralObject.spectralSequence` TODO to be completed first ..."). The contingency was avoided in X1 by routing direct-from-bicomplex via iterated-cohomology functoriality; Z arc reverses that choice.
- **mg-e1b8** (`UC-Lean-PathB-BKBicomplex-scope`, GREEN). Path B scoping; Y1–Y5 decomposition for the workaround chain on top of X1–X5.
- **mg-e75c** (`UC-Lean-PathB-Y6-ChainToSSTransport`, AMBER). Y6 verdict 12:28Z: the chain-to-SS transport bridge is **propositionally false** under `hStar` in the current chain-group encoding — the Y4 degree-0 lift `BKIsotypeColumn_lift_to_BKBicomplexHC2 F x` (sending `r : ℚ ↦ Finsupp.single ⟨const F, topVertex F⟩ r`) admits no chain-map extension at degree 1 (would require `single (topVertex F) r ∈ image of (BK col 0).d 1 0` for all `r ≠ 0`, contradicting `topVertex_not_coboundary`). This is the **deepest layer** of the L+X+Y asymptotic-AMBER pattern.

---

## TL;DR / Verdict

**GREEN scoping complete + Z1–Z10 decomposition pinned + Phase D mathlib-PR coordination plan named.**

The Z arc is the **proper-infrastructure replacement** for the workaround chain X1+Y1+...+Y6. Its top-line shape:

1. **Z1–Z3 close mathlib's `SpectralObject.spectralSequence` TODO** — the three explicit TODOs (`Abelian.SpectralObject.spectralSequence`, `SpectralObject.SpectralSequence.homologyData`, `SpectralObject.spectralSequenceHomologyData`) plus the new `HomologicalComplex₂ → SpectralObject` bridge construction (which mathlib does **not** have — the only `SpectralObject` constructor in mathlib is `HomotopyCategory/SpectralObject.lean` for filtered objects in the derived category, not for bicomplexes). Z1–Z3 land **upstream-quality mathlib** infrastructure.

2. **Z4–Z5 generalise the equivariant + edge-map pieces (X3+X4+X5)** to the proper `SpectralObject`-derived pages instead of the X1 degenerate-page workaround. The X1–X5 already-clean files survive as **standalone mathlib-PR candidates** (no rewrite; their content stays valid as facts about the X1-style direct bicomplex SS), but the BK-bicomplex refactor switches to using Z3 as the canonical bicomplex SS.

3. **Z6–Z9 refactor the union_closed-side BK bicomplex, Walsh-equivariant action, chain-Homotopy bridge, and obstructionCohomClass** to the proper `SpectralObject`-derived path. The **chain-map-extension structural blocker** (the Y6 RED diagnosis) is sidestepped: in the proper Walsh-isotype-graded `SpectralObject` the χ_x-isotype piece of `H^{n-1}(Tot)` is **genuinely** zero (the `topVertex` generator lives in the χ_[n]-isotype, not χ_x^{n-1}, so the augmentation collision does not hit the χ_x slice).

4. **Z10 is the PROJECT-LIFE MILESTONE closure ticket** — Frankl_Holds end-to-end via proper mathlib SS infrastructure, zero live sorrys, non-vacuous non-tautological.

Estimated total **3.4–4.6M Lean budget**, multi-month, three-stage critical path:

- **Stage 1 (Z1–Z3)** = upstream-mathlib `SpectralObject.spectralSequence` infrastructure (1.05–1.45M, three-step strict-serial mathlib PRs).
- **Stage 2 (Z4–Z5)** = SpectralObject-equivariant + edge map (0.55–0.85M, parallelisable after Z3).
- **Stage 3 (Z6–Z9 → Z10)** = union_closed-side refactor onto proper path; Z10 milestone close (1.80–2.30M, partially parallelisable; Z9→Z10 strictly serial).

No structural impossibility found. No mathlib infrastructure gap beyond the three named TODOs + the bicomplex→SpectralObject bridge. **Recommendation: file Z1 (`UC-Lean-Z1-SpectralObjectAssembly`) as the next execution step**, mathlib-PR-coordination decisions deferred to Daniel (see Phase D).

The structural-blocker analysis at Y6 mg-e75c is **load-bearing input** for Z9's encoding choice: the new `obstructionCohomClass` lives in the SpectralObject-derived abutment filtration `F^x H^{n-1}(Tot)`, with the χ_x-isotype projection at the SS level, **not** at the chain level — so `topVertex_not_coboundary` becomes a non-issue (it is a statement about the chain-level cohomology of `(BKTotal n).X 0` which the new object no longer factors through).

---

## §0 — Hard constraints carried into every Z sub-ticket

Carried from project's UC-Lean-scope §D + mg-103f body:

- **NOT factorial.** No Specht modules. The (Z/2)^n action used in Z7+Z8 is abelian; characters are χ_S indexed by `Finset (Fin n)`; no symmetric-group representation theory enters.
- **NOT functorial in the refinement sense.** No `Pos_n` functor. All constructions native to `BKTotal n` / `IntClosedFam n` / SpectralObject-derived direct-sum decompositions.
- **U1-dialect preserved.** Purely additive cohomology comparisons; no cup-product invoked.
- **Math-first.** Each Z sub-ticket aligns with a specific paper-side step (UC10 §§5.3–5.4 / UC11 §§5–6 / UC13 §§2.4 + 4.5 + 7 / UC14 §§1.5 + 4.6).
- **Cumulative state doc.** Each Zi appends a `state-UC-Lean-Z<i>-<slug>.md` cumulative ledger; this file is the arc-level index.
- **Mathlib-folder authorization (Daniel 17:47Z + 23:12Z + 12:47Z) broadened** to the full SpectralObject pipeline + bicomplex bridge + abutment filtration. Each `lean/UnionClosed/Mathlib/Algebra/Homology/{SpectralObject,SpectralSequence}/*.lean` file carries `-- MATHLIB-PR-CANDIDATE: yes / no / conditional` plus a one-line rationale.
- **"Don't pursue shortcuts" per Daniel directive.** Z-tickets must avoid the workaround-then-discover-it-doesn't-work pattern of L+X+Y. Specifically:
  - **No degenerate-page workaround.** X1's `IsDegenerate` predicate + `EInfty := (E.page r₀).X pq` shortcut is replaced by the proper `EInfty` via the SpectralObject canonical stationary-page colimit.
  - **No `trivialConvergesTo` workaround.** X2's `trivialConvergesTo` with `abutmentFiltration p q := 0` (a placeholder that uses the SS-IsZero to derive ConvergesTo trivially) is replaced by the proper `convergesTo` via the SpectralObject abutment filtration on `H^n(Tot)`.
  - **No chain-side lift workaround.** Y4's `BKIsotypeColumn_lift_to_BKBicomplexHC2` (the degree-0-only ℚ-linear map onto `topVertex` whose chain-map extension is propositionally false) is replaced by an SS-level isotype projection on the SpectralObject-derived abutment filtration.
- **No axiom-cheat. No fake mathlib API. No defeq trick. No `False.elim` on `_hStar`.** Compiles via `lake build` GREEN.
- **Acceptance bar template per sub-ticket (12 bars; expanded from X+Y):** the 10-bar set from Y5/Y6 + two new Z-specific bars:
  - **(11) No `IsDegenerate` workaround invoked** for the BK bicomplex SS (degenerate SSs are fine in general; the BK bicomplex SS is NOT a priori degenerate at higher rows and must be carried with proper d_r data).
  - **(12) No chain-side encoding of cohomology vanishing**. All cohomology vanishing arguments at the BK bicomplex's χ_x slice must live in the SS-derived abutment filtration, not in `(BKTotal n).homology 0`.

---

## §1 — Phase A: SpectralObject TODO audit

Audit of mathlib v4.29.1 `Mathlib/Algebra/Homology/SpectralObject/`, with classification GREEN (mathlib has it) / AMBER (partial) / RED (missing).

### A.1 `SpectralObject` base structure (`SpectralObject/Basic.lean`) — **GREEN**

A `SpectralObject C ι` is data `(H : ι → C, δ : ...)` on a poset (or category) `ι` with axioms for filtration-style behaviour. Mathlib has this in `SpectralObject/Basic.lean` (~430 lines). Fully populated: short complexes from triples, exactness, functoriality.

**Verdict.** GREEN, no work needed. Foundation for Z arc.

### A.2 `SpectralObject` page primitives (`SpectralObject/Page.lean`) — **GREEN**

`pageX`, `pageXIso`, `pageD`, `page`, `shortComplexIso` (918 lines). The full per-page object + per-page differential machinery is there.

**Verdict.** GREEN, no work needed.

### A.3 `SpectralObject` page-to-page kernel-fork limit (`SpectralObject/SpectralSequence.lean` 300+ lines) — **GREEN for `kfSc` + `isLimitKf`; AMBER for completion**

The file `SpectralObject/SpectralSequence.lean` has substantial content (~318 lines): `pageX`, `pageXIso`, `pageD`, `page`, `shortComplexIso`, `kfSc`, `kfSc_exact`, `isLimitKf` are all built. The kernel-fork limit `IsLimit (kf X data r r' ...)` is constructed — the key technical step in showing "homology of page r = page r+1" at the limit level.

**What is missing.**
- (i) The dual cokernel-fork colimit `IsColimit (cc X data ...)`. The kernel side is built; the cokernel side is referenced in the header documentation but not yet constructed.
- (ii) The epi-mono factorization `fac` linking kernel fork + cokernel cofork.
- (iii) The wrap-up `SpectralObject.SpectralSequence.homologyData` — a `ShortComplex.HomologyData` packaging (i) + (ii) so the homology of a page r identifies with page r+1.
- (iv) The structural assembly `SpectralObject.spectralSequenceHomologyData` — assembling all per-pq homologyData into the per-page homology data needed for the spectral-sequence iso field.
- (v) The final `Abelian.SpectralObject.spectralSequence : SpectralSequence C c r₀` — the user-facing constructor producing a `SpectralSequence`.

**Verdict.** AMBER. The kernel-fork half + ~half the structural plumbing is there. Z1 finishes the cokernel-fork half + assembles `homologyData` + assembles the SS. Estimated work: this is the largest single mathlib piece — ~500–700 lines of new content, plus careful integration with `SpectralSequenceDataCore`'s constraints.

**Direct mathlib-TODO citations** (Joël Riou, `SpectralObject/SpectralSequence.lean` header):
- "*The main definition in this file is `Abelian.SpectralObject.spectralSequence` (TODO).*" (line 16)
- "*`SpectralObject.SpectralSequence.homologyData` (TODO) and `SpectralObject.spectralSequenceHomologyData` (TODO)*" (lines 62–63)

### A.4 `HasSpectralSequence` typeclass + `SpectralSequenceDataCore` recipe (`SpectralObject/HasSpectralSequence.lean` ~440 lines) — **GREEN**

The `SpectralSequenceDataCore ι c r₀` recipe structure exists with 13 fields (`deg`, `i₀`, `i₁`, `i₂`, `i₃`, `le₀₁`, `le₁₂`, `le₂₃`, `hc`, `hc₀₂`, `hc₁₃`, `antitone_i₀`, `monotone_i₃`, `i₀_prev`, `i₃_next`). Three concrete recipe instances built:
- `coreE₂Cohomological : SpectralSequenceDataCore EInt (ComplexShape.up' ⟨r, 1-r⟩) 2` — `E_2`-cohomological indexed by `ℤ × ℤ` for spectral objects on `EInt`.
- `coreE₂CohomologicalNat : SpectralSequenceDataCore EInt (ComplexShape.spectralSequenceNat ⟨r, 1-r⟩) 2` — `E_2`-cohomological indexed by `ℕ × ℕ` for first-quadrant SSs.
- `coreE₂CohomologicalFin (l : ℕ)` — finite-bottom case.

The `HasSpectralSequence` typeclass exists with `IsFirstQuadrant`-style instance hooks.

**Verdict.** GREEN, no work needed. Z arc uses `coreE₂CohomologicalNat` directly.

### A.5 `SpectralSequence` page-level structure (`SpectralSequence/Basic.lean` ~200 lines) — **GREEN**

`SpectralSequence C c r₀` structure (pages + iso fields) and its category (morphisms + composition + ext lemmas) and `pageXIsoOfEq` helpers are there.

**Verdict.** GREEN, no work needed.

### A.6 `SpectralSequence/ComplexShape.lean` — **GREEN**

`ComplexShape.spectralSequenceNat` (the `ℕ × ℕ` first-quadrant page shape) and `up'` variants and `spectralSequenceFin` (finite variant) exist.

**Verdict.** GREEN, no work needed.

### A.7 `HomologicalComplex₂ → SpectralObject` bridge — **RED**

This is the **single biggest missing piece outside `SpectralObject/SpectralSequence.lean`'s TODO**. The setup mathlib has:
- `HomologicalComplex₂ C c₁ c₂` (`HomologicalBicomplex.lean`).
- `HomologicalComplex₂.total : HomologicalComplex₂ C c₁ c₂ → HomologicalComplex C c` (`TotalComplex.lean`), with `D₁`, `D₂`, `ιTotal`, `ιTotalOrZero` populated.
- `HomotopyCategory/SpectralObject.lean` — a `SpectralObject` construction, but **for a filtered object in the derived category**, not for a bicomplex directly.

What is missing: a constructor

```
HomologicalComplex₂.spectralObject :
    HomologicalComplex₂ C c₁ c₂ → SpectralObject (HomologicalComplex C c) ι
```

(or, more precisely, a `SpectralObject C EInt` realising the canonical filtration `F^p (Tot K) := ⊕_{p' ≥ p} K_{p', q}` on the total complex, with `H`-data `H^n (F^p / F^{p+1})`, `δ`-connecting maps from the s.e.s. of filtration quotients).

This is the **bridge** that lets the SS of a bicomplex go via the SpectralObject route (via Z3) instead of the X1 direct-iterated-cohomology route.

**Verdict.** RED, missing entirely from mathlib v4.29.1. Z2 builds it. Estimated ~400–550 lines.

**MATHLIB-PR-CANDIDATE: yes.** This is textbook content (every algebraic topology textbook proves that the canonical filtration on the total complex of a first-quadrant bicomplex gives a spectral object whose SS is the standard bicomplex SS). Cleanest split: build it in `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/Bicomplex.lean` (new file).

### A.8 Equivariant SpectralObject / isotype splitting on SS pages — **RED**

What X3 + X4 currently provide (mg-fade / mg-9822) at the **X1-degenerate-SS level**: `EquivariantBicomplex G` (G acting on `HomologicalComplex₂`), `IsotypeFamily E Index` user-data, `respectsDifferentials_of_degenerate` (zero-d_r differentials trivially respect any isotype splitting), Schur-abelian + Walsh character ad hoc.

What is missing for the **proper `SpectralObject`-derived SS**: the natural-G-action lift through pageX / pageXIso / pageD / homologyData / spectralSequence, so the per-page isotype splitting is preserved across the kernel-fork limit + cokernel-cofork colimit + homologyData assembly.

**Verdict.** RED, missing entirely. Z4 builds the SpectralObject-level equivariant lift; the X3 + X4 result on the X1 degenerate page becomes a special case (the degenerate-d_r restriction trivialises the Schur-zero check).

**MATHLIB-PR-CANDIDATE: conditional.** The general "G-equivariant SpectralObject" is a substantial chunk; mathlib will want it but might prefer a smaller initial PR. **Recommendation:** finite-abelian-G specialisation first (the Z arc's actual need), broader generalisation as separate follow-on.

### A.9 SpectralObject edge maps (corner identification of E_∞ with H^* abutment) — **RED**

What X5 (mg-c128) provides at the **X1-degenerate level**: `WithEdgeMaps` extension of `trivialConvergesTo`, identity horizontal edge at row 0, zero vertical edges at q ≥ 1, union_closed-specific `unionClosedEdgeComposite` identification.

What is missing for the **proper SpectralObject-derived SS**: edge maps `E_∞^{p, 0} → H^p(Tot)` (row edge) and `H^q(Tot) → E_∞^{0, q}` (column edge) via the SpectralObject's abutment filtration on `H^*(Tot)`, not via the degenerate-page identity trick.

**Verdict.** RED for the proper edge maps; AMBER for the X5 union_closed-specific composite, which can be ported with thin changes once Z2+Z3 land.

**MATHLIB-PR-CANDIDATE: yes** for the general edge maps; **no** for the union_closed-specific specialisation (split at upstream PR boundary).

### A.10 chain-Homotopy → SS-abutment vanishing (proper version) — **AMBER**

What Y4 (mg-35ae) + X2 (mg-55b3) provide at the **X1-degenerate / `trivialConvergesTo` level**: `nullHomotopyOnIsotype_givesEInftyVanishing` adapter — given `Homotopy ψ 0` on the χ-isotype subcomplex, derives `IsZero (E.EInftyBicomplex (p, q))` via the X1 degenerate-page identification.

What is missing for the **proper SpectralObject-derived SS**: a `Homotopy ψ 0` on the χ_x-isotype slice of `(K.total)` should derive `IsZero (gr_x H^{n-1}(K.total))` via the canonical filtration's interaction with chain homotopies (standard result: chain homotopies preserve the canonical filtration; null-homotopic chain maps restrict to null-homotopic chain maps on each filtration piece; hence the induced map on `gr_p H^n` is zero). The adapter for the SpectralObject-derived `gr_p H^n` does not exist.

**Verdict.** AMBER. The base homotopy → homology fact is in `Algebra/Homology/Homotopy.lean`. The filtration-respecting adapter is a small new piece (~80–120 lines).

**MATHLIB-PR-CANDIDATE: yes** (a standard adapter; small and clean).

### A.11 `HomologicalComplex.total`'s `homology` API — **GREEN**

The standard `HomologicalComplex.homology` API exists in `Algebra/Homology/HomologicalComplex.lean`; the total of a bicomplex has its `homology p` accessible directly. This is what `obstructionCohomClass`'s **post-Z9 landing object** factors through (via the SpectralObject abutment filtration).

**Verdict.** GREEN, no work needed.

### A.12 `HomologicalComplex.total` interaction with SpectralObject — **RED** (consequence of A.7)

Once A.7's `HomologicalComplex₂.spectralObject` exists, the abutment filtration on `H^n(Tot)` is canonical from the SpectralObject data. Currently there is no such thing because A.7 is missing.

**Verdict.** RED, follows from A.7.

### Audit summary table

| # | Piece | mathlib v4.29.1 state | Critical path? | Z-ticket | Upstream PR? |
|---|---|---|---|---|---|
| A.1 | `SpectralObject` base | GREEN | (foundation) | — | — |
| A.2 | Page primitives (`pageX`, `pageD`, `page`, `shortComplexIso`, ...) | GREEN | (used by Z1) | — | — |
| A.3 | Kernel-fork limit + homologyData + SS assembly | AMBER (kernel half done; cokernel half + assembly TODO) | **Yes** | **Z1** | **Yes (definitive)** |
| A.4 | `SpectralSequenceDataCore` + `HasSpectralSequence` | GREEN | (used by Z1) | — | — |
| A.5 | `SpectralSequence` structure + category | GREEN | (used by Z1) | — | — |
| A.6 | `ComplexShape.spectralSequenceNat` | GREEN | (used by Z3) | — | — |
| A.7 | `HomologicalComplex₂ → SpectralObject` bridge | RED | **Yes** | **Z2** | **Yes (definitive)** |
| A.8 | Equivariant SpectralObject + isotype splitting | RED | **Yes** | **Z4** | Conditional (finite-abelian first) |
| A.9 | SpectralObject edge maps | RED | **Yes** | **Z5** | Yes (general); No (union_closed-specific) |
| A.10 | chain-Homotopy → SpectralObject abutment vanishing | AMBER (base in Homotopy.lean; adapter missing) | **Yes** | **Z3** (final piece) | Yes |
| A.11 | `HomologicalComplex.homology` | GREEN | (used by Z9) | — | — |
| A.12 | Total interaction with SpectralObject | RED (follows A.7) | (consequence) | **Z2** + **Z3** | — |

**Aggregate verdict.** No structural impossibility. **Three** RED pieces (A.7 bicomplex bridge, A.8 equivariant lift, A.9 edge maps); **two** AMBER pieces (A.3 SS assembly, A.10 chain-homotopy adapter); **everything else GREEN**. The multi-month estimate reflects volume (closing A.3 alone is multi-week-grade mathlib work).

**This is GREEN Phase A audit.** No hidden architectural issues. Z arc is **buildable** entirely within mathlib's existing SpectralObject design.

---

## §2 — Phase B: refactor plan for X1–X5 + Y1–Y6

### B.1 What survives, what gets replaced

| File | mg-ticket | Verdict, X+Y → Z |
|---|---|---|
| `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/Bicomplex.lean` | mg-dd80 (X1) | **SURVIVES standalone** as mathlib-PR candidate. X1's `HomologicalComplex₂.rowOfColumnHomology` + `spectralSequencePage K r` + `spectralSequence_E2_iso` remain true facts about the X1-style direct-iterated-cohomology SS; they are an **alternative construction** to the SpectralObject-derived SS that Z3 produces. The X1 SS is degenerate by construction (d_r = 0 for all r ≥ 2); the Z3 SS carries the genuine d_r data. They are linked by a comparison iso (Z3's `spectralSequence_iso_X1_spectralSequence_of_degenerate` — a thin comparison lemma at the level mathlib expects). |
| `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/Convergence.lean` | mg-55b3 (X2) | **PARTIALLY SURVIVES.** §1 (`IsDegenerate`) and §6 (`DifferentialsFamily`) are independent abstractions and survive. §2 (`EInfty` via degenerate-page shortcut) and §3 (`ConvergesTo` + `trivialConvergesTo`) are **replaced** by Z3's SpectralObject-derived `EInfty` + `convergesTo`. §5 (`nullHomotopyOnIsotype_givesEInftyVanishing`) is replaced by Z3's chain-Homotopy adapter at the SpectralObject level (the A.10 piece). The file gets a §7 with the Z3 cross-link and a header `MATHLIB-PR-CANDIDATE: conditional` (the `IsDegenerate` + `DifferentialsFamily` halves PR upstream cleanly; the rest is shadowed by Z3). |
| `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/Equivariant.lean` | mg-fade (X3) | **SURVIVES standalone** as mathlib-PR candidate (general `EquivariantBicomplex G` + `IsotypeFamily` + degenerate-`respectsDifferentials` are true facts and useful in their own right). Z4 reuses the `EquivariantBicomplex` structure as input data. |
| `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/Schur.lean` | mg-9822 (X4) | **SURVIVES standalone** as mathlib-PR candidate (Schur-abelian + degenerate-page differential vanishing are true facts). Z4 reuses the Schur-abelian half; the degenerate-page half is shadowed by Z4's general result on SpectralObject-derived pages. |
| `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/EdgeMap.lean` | mg-c128 (X5) | **PARTIALLY SURVIVES.** The generic `WithEdgeMaps` structure + `trivialWithEdgeMaps` witness survive. The union_closed-specific composite (`unionClosedEdgeComposite`) is replaced by Z5's SpectralObject-derived edge maps + Z9's SpectralObject-aware version. |
| `lean/UnionClosed/UC10/BKBicomplexHC2.lean` | mg-17dc (Y1) + mg-ba0f (Y1b) | **SURVIVES as bicomplex object**; the bicomplex `BKBicomplexHC₂ F` is the input data that the Z arc feeds into Z2 (bicomplex→SpectralObject bridge). Y1's `TraceChainMap` + `BKHorizDiff_full` + `BKVertD` + `BKFace_0` (and Y1b's higher-row content) remain valid and become inputs to Z2. The shape choice `(.down ℕ, .down ℕ)` may need a minor restatement to align with `ComplexShape.spectralSequenceNat` (an internal `.up ℕ` for cohomological grading) but the substance is intact. |
| `lean/UnionClosed/UC10/BKWalshEquivariant.lean` | mg-f5b4 (Y2) | **SURVIVES** as input data for Z7. The `BKToggleAction n F σ` per-cell scalar action + `BKEquivBicomplex n F` X3-`EquivariantBicomplex` inhabitant + `walshIsotypeProj n S F` Maschke isotype projector + `BKIsotypeAt n S p q` chain-level isotype + `BKWalshIsotypeFamily n F` X3-`IsotypeFamily` inhabitant all stay; Z7 lifts them through the SpectralObject pipeline. |
| `lean/UnionClosed/UC11/BKWalshHomotopyBridge.lean` | mg-3fdc (Y3) | **PARTIALLY SURVIVES.** Y3's `lowerWalshScalar F x` extraction + `lowerWalshScalar_eq_one` chain identity + `BKIsotypeColumn F x` 2-term chain complex + `BKIsotypeColumn_nullHomotopy F x` survive **as Y3's chain-level form**. The 1-dim ℚ-line abstraction is **load-bearing input** to Z8 (it carries the UC10_lowerWalshVanishing chain identity in chain-Homotopy form); Z8 lifts this through the proper SpectralObject path with the χ_x-isotype slice of the total bicomplex (not of the small 1-dim line). |
| `lean/UnionClosed/UC11/BKSSCohomologyVanishing.lean` | mg-35ae (Y4) + mg-e75c (Y6) | **REPLACED.** Y4's `BKIsotypeBicomplex F x` (small isotype-column bicomplex) and `BKEInftyVanishing_at_x F x q` and `BKEdgeMap F x` (`WithEdgeMaps` extension of `trivialConvergesTo`) and `BKSSCohomologyVanishing F x` and `BKIsotypeColumn_lift_to_BKBicomplexHC2 F x` + Y6's `_injective` are all **shadowed** by Z8's SpectralObject-derived abutment vanishing on the **actual** `BKBicomplexHC₂ F`'s χ_x-isotype slice. They remain in-file with a header annotation pointing to Z8 as the genuine replacement, in the spirit of the X5 archival policy. |
| `lean/UnionClosed/UC11/CohomologyClass.lean` | mg-470a (Y5) | **REPLACED.** Y5's def-aliased `obstructionCohomClass F x := 0 : Fin n → (BKTotal n).homology 0` is propositionally true but vacuous. Z9 introduces a parallel `obstructionCohomClassZ F : Fin n → (BKBicomplexHC₂ F).total.gr ((BKBicomplexHC₂ F).spectralObject.abutmentFiltration) x ((n-1) - x)` (the SpectralObject-derived per-x χ_x-graded piece of `H^{n-1}(Tot)`). The Y5 `obstructionCohomClass` is then **re-pointed via a new def-alias** to `obstructionCohomClassZ` (where the latter type lives), with the type signature changed to land in the SpectralObject-derived cohomology. Old `obstructionCohomClassChain F` (the chain-level form) is preserved as historical record of the Y5+Y6 RED diagnosis. |
| `lean/UnionClosed/UC11/SSConvergence.lean` | mg-c0d3 (L5) + mg-b26c (X6) + mg-470a (Y5) + mg-e75c (Y6) | **REPLACED.** The whole `obstructionClass_cohomology_vanishing` chain re-routes through Z10 closing via the SpectralObject SS abutment. The Y6 bridge `obstructionCohomClassChain_eq_zero_via_y6_transport_residual` with its named chain-map-extension structural-blocker sorry is **deleted** (the sorry is closed by Z9+Z10 routing to a different cohomology object where it is propositionally true). |
| `lean/UnionClosed/UC11/SSKernel.lean` | mg-470a (Y5) | **SURVIVES** as mg-b26c's `SSAbutment_corner_vanishing_via_columnHomotopy` composition kernel (general lemma about X1-style abutment vanishing; remains valid; Z8 uses the SpectralObject-level analogue). |
| `lean/UnionClosed/UC11/SSEdgeIdentification.lean` | mg-c128 (X5) | **REPLACED.** The union_closed-specific edge composite is rewritten through Z5's SpectralObject-derived edge maps. |
| `lean/UnionClosed/Frankl.lean` | base | **MINIMAL TOUCH.** `obstructionClass_cohomology_vanishing` proof body re-targets the new `obstructionCohomClassZ`; the `absurd hChainCohomZ hChainCohomNZ` chain is replaced by `absurd hZCohomZ hZCohomNZ` (analogous shape, different object). One-liner-or-near edits. |

### B.2 Why this refactor closes the Y6 chain-map-extension blocker

The Y6 RED diagnosis (mg-e75c structural-blocker analysis):
- Y4's chain-level lift `BKIsotypeColumn_lift_to_BKBicomplexHC2 F x : ℚ →ₗ ((BKBicomplexHC₂ n F).X 0).X 0` sends `r ↦ Finsupp.single ⟨const F, topVertex F⟩ r`.
- Y4's SS-IsZero on the SMALL Y3-derived bicomplex's SS-abutment requires the lift to extend to a chain map at degree 1, which would require `single (topVertex F) r ∈ image of (BK col 0).d 1 0` for all `r ∈ ℚ`, contradicting `topVertex_not_coboundary F`.
- Hence no chain-map extension exists. **`(BKTotal n).homology 0` IsZero on the `topVertex` line is propositionally FALSE under `hStar` in the current chain encoding.**

The Z arc sidesteps the blocker:
- Z9's `obstructionCohomClassZ F x` does **not** factor through `chainToHomology0 n` or through `Finsupp.single ⟨const F, topVertex F⟩`. It is the χ_x-graded piece of `H^{n-1}(Tot (BKBicomplexHC₂ F))` via the SpectralObject abutment filtration.
- The `topVertex` chain-level generator sits in the **augmentation direction** of the L2a baseline, not in the χ_x-isotype direction. The Walsh decomposition (Y2's `walshIsotypeProj n S F`) shows: at chain-level, `single ⟨const F, topVertex F⟩` lies in the χ_∅-isotype (the trivial Walsh character, fixed by the whole (Z/2)^n action), **not** in the χ_x-isotype (which is the level-1 Walsh character at coordinate x). So projecting onto the χ_x-isotype kills the `topVertex` generator at chain level *before* taking cohomology.
- At the SpectralObject SS level, the χ_x-isotype graded piece of `H^{n-1}(Tot)` is **genuinely** zero because the χ_x-isotype null-homotopy from Y3 (`BKIsotypeColumn_nullHomotopy F x`, the chain-level form of UC10_lowerWalshVanishing) restricts to a null-homotopy of identity on the χ_x-isotype slice of `(BKBicomplexHC₂ F).total` — and chain homotopies preserve the canonical filtration → `gr_x H^{n-1}(Tot) = 0`.
- `topVertex_not_coboundary F` remains a true statement about the **χ_∅-isotype piece**, which is **not** what `obstructionCohomClassZ F x` lives in.

The Y6 mg-e75c structural blocker analysis is preserved verbatim as a paper-side mathematical observation. What changes is the encoding: at the Z9 encoding, the chain class lives in a different graded piece, and the `topVertex_not_coboundary` collision is decoupled from the per-x vanishing.

### B.3 Refactor target — the new closure invocation chain

The new chain (replacing the X6 + Y5 + Y6 chain):

1. **Z3 SpectralObject SS:** `(BKBicomplexHC₂ F).spectralObject.spectralSequence` (via Z1+Z2 infrastructure).
2. **Z3 abutment filtration:** `(BKBicomplexHC₂ F).spectralObject.abutmentFiltration : ℤ → ℤ → C` giving `F^p H^n(Tot)`.
3. **Z3 graded-piece iso:** `(BKBicomplexHC₂ F).spectralObject.grEInftyIso : gr_p H^n ≅ E_∞^{p, n-p}` for `(p, q)` first-quadrant.
4. **Z4 equivariant SpectralObject lift:** the (Z/2)^n action on `(BKBicomplexHC₂ F)` lifts through the SpectralObject pipeline, giving per-page (Z/2)^n action commuting with all differentials.
5. **Z4 isotype splitting on pages:** each SS page splits along Walsh characters χ_S indexed by `Finset (Fin n)`; the splitting is preserved by SS differentials (Schur-abelian via X4 + page-wise lift).
6. **Z5 edge-map identification:** the χ_x-isotype slice of `E_∞^{x, n-1-x}` identifies with the χ_x-isotype slice of `gr_x H^{n-1}(Tot)` via the SpectralObject's edge map.
7. **Z8 chain-Homotopy → χ_x-slice vanishing:** Y3's `BKIsotypeColumn_nullHomotopy F x` (chain-level form of UC10_lowerWalshVanishing) lifts to a `Homotopy` on the χ_x-isotype slice of the total complex; the SpectralObject canonical filtration preserves this `Homotopy`, hence `IsZero (gr_x H^{n-1}(Tot))`.
8. **Z9 obstruction class:** `obstructionCohomClassZ F x : (BKBicomplexHC₂ F).total.homology (n-1) → gr_x H^{n-1}(Tot)` is the canonical projection onto the χ_x-graded piece, post-composed with Z4's χ_x-isotype splitting.
9. **Z10 closure:** under `hStar : IsCounterexample F`, the chain `Z3 grEInftyIso → Z5 edge identification → Z8 χ_x-slice vanishing → Z9 χ_x-isotype projection` gives `obstructionCohomClassZ F x = 0` substantively. Combined with the existing UC11 §6.2 non-vanishing argument re-targeted to `obstructionCohomClassZ`, derive `False`, hence `¬ IsCounterexample F`, hence `Frankl_Holds F`.

### B.4 Compatibility with L2a / L2b / L3 baselines

All existing chain-level constructions (Walsh decomposition Y2 / chain-Homotopy bridge Y3 / Y1 BK bicomplex / mg-fbbb `UC10_lowerWalshVanishing` / mg-6acd `topVertex_not_coboundary` / mg-7f26 per-coord refactor) **survive** as chain-level inputs to the Z arc's SS-level reasoning. No chain-side primitive is invalidated. The Z arc adds a new layer (SpectralObject-derived SS infrastructure) **on top of** the chain-level baseline, and re-routes the cohomology closure through it.

### B.5 What about `obstructionClass`, `obstructionLanding`, `obstructionCohomClassChain`?

These remain as **historical records of the X+Y RED diagnosis**:

- `obstructionClass F : Fin n → (BKTotal n).X 0` — the chain-level Fin n family at the per-coord baseline. Stays in `UC11/ObstructionClass.lean` unchanged.
- `obstructionLanding` — landing inside `⊕_x V_x^{n-1}` per UC13 §2.4.1. Stays in `UC11/ObstructionClass.lean` unchanged.
- `obstructionCohomClassChain F : Fin n → (BKTotal n).homology 0` — pre-Y5 chain-level cohomology projection via `chainToHomology0 n`. Stays in `UC11/CohomologyClass.lean` unchanged. mg-36c3 PROVEN structural-collision theorems remain PROVEN about it.

Z9's `obstructionCohomClassZ F : Fin n → (BKBicomplexHC₂ F).spectralObject.gr_x H^{n-1}` is a **parallel object in a different cohomology**, not a replacement-by-deletion.

### B.6 Mathlib-folder layout (post-Z arc)

```
lean/UnionClosed/Mathlib/
  Algebra/
    Homology/
      SpectralObject/
        Bicomplex.lean              -- Z2: HomologicalComplex₂ → SpectralObject (NEW)
        SpectralSequenceAssembly.lean -- Z1: SpectralObject.spectralSequence + homologyData (NEW; mirror of mathlib's TODO file)
        Convergence.lean            -- Z3: abutmentFiltration + grEInftyIso + chain-Homotopy → gr_p vanishing adapter (NEW)
        Equivariant.lean            -- Z4: equivariant SpectralObject + isotype splitting (NEW)
        EdgeMap.lean                -- Z5: SpectralObject edge maps (NEW)
      SpectralSequence/             -- preserved from X arc (mathlib-PR-clean, X1-style direct construction)
        Bicomplex.lean              -- X1 (mg-dd80, SURVIVES, comparison lemma added)
        Convergence.lean            -- X2 (mg-55b3, PARTIALLY SURVIVES with §7 Z3 cross-link)
        Equivariant.lean            -- X3 (mg-fade, SURVIVES standalone)
        Schur.lean                  -- X4 (mg-9822, SURVIVES standalone)
        EdgeMap.lean                -- X5 (mg-c128, PARTIALLY SURVIVES)
```

Six new files under `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/`; the existing five `SpectralSequence/*.lean` files survive with thin updates.

---

## §3 — Phase C: Z1–Z10 execution sub-ticket decomposition

Ten sub-tickets. Z1–Z5 are mathlib-PR-clean SpectralObject infrastructure; Z6–Z9 are union_closed-side refactor; Z10 is the PROJECT-LIFE MILESTONE closure.

Each is single-session-capable when the predecessor is GREEN (per the prior X+Y discipline). Larger Z-tickets (Z1, Z2, Z8) may sub-split mid-execution if they walk past their budget — the polecat at execution time has authorisation to file `Z<i>a` / `Z<i>b` per the X1a/X1b precedent named in the Path A scoping §5.1.

### Z1 — `UC-Lean-Z1-SpectralObjectAssembly`

**Title.** UC-Lean-Z1-SpectralObjectAssembly: complete `Abelian.SpectralObject.spectralSequence` + `homologyData` + `spectralSequenceHomologyData` — mathlib's three explicit TODOs in `SpectralObject/SpectralSequence.lean`.

**Budget.** 450–600k (largest single piece; multi-week-grade work even in single-session-capable form).

**Deps.** None internal. External: mathlib `SpectralObject/Basic.lean`, `Page.lean`, `EpiMono.lean`, `Cycles.lean`, `Differentials.lean`, `Homology.lean`, `HasSpectralSequence.lean`, `SpectralObject/SpectralSequence.lean` (partial).

**Deliverable.** `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/SpectralSequenceAssembly.lean` (NEW). Substantive new content:
1. Cokernel cofork colimit `IsColimit (cc X data r r' ...)` (the dual of mathlib's existing `isLimitKf`).
2. Epi-mono factorisation `fac` linking the kernel-fork limit + cokernel-cofork colimit at a fixed page-pq position.
3. `SpectralObject.SpectralSequence.homologyData` — a `ShortComplex.HomologyData` packaging the kernel-fork + cokernel-cofork data so that the `S := pageX (r+1) pq`-positioned homology of the page-r differential pair `(pageD r pqPrev pq, pageD r pq pqNext)` identifies with `pageX (r+1) pq`.
4. `SpectralObject.spectralSequenceHomologyData` — the assembly of (3) into per-page homology data needed for the SS iso field.
5. `Abelian.SpectralObject.spectralSequence X data : SpectralSequence C c r₀` — the final user-facing constructor.

**Acceptance bar (12 bars).** Per §0 12-bar template. Specifically:
- (1) `lake build` GREEN.
- (2) Non-vacuous: feed `coreE₂CohomologicalNat` and a concrete spectral object (e.g. `unit : SpectralObject C EInt` from the trivial filtration on a single-object complex) → recover a non-trivial first-quadrant SS with page-2 differentials matching `coreE₂CohomologicalNat`'s recipe.
- (3) Mathlib-PR-clean naming, docstrings, Joël-Riou-style; reuses the existing `SpectralObject/SpectralSequence.lean` setup verbatim (kernel-fork side stays; cokernel-fork side mirrors structure).
- (4)–(12) standard.

**MATHLIB-PR-CANDIDATE: yes (definitive).** Closes mathlib's own header-flagged TODO; ready for upstream review immediately.

**Sub-split contingency.** If the cokernel-cofork colimit construction proves too large in a single session, split as:
- **Z1a** — Cokernel cofork colimit + epi-mono fac (~300k).
- **Z1b** — `homologyData` + `spectralSequenceHomologyData` + SS assembly (~300k).

### Z2 — `UC-Lean-Z2-BicomplexSpectralObject`

**Title.** UC-Lean-Z2-BicomplexSpectralObject: build `HomologicalComplex₂.spectralObject` — the bicomplex→SpectralObject bridge via the canonical filtration on `total`.

**Budget.** 400–550k.

**Deps.** Z1 (uses `SpectralObject` API + `spectralSequence` constructor). External: mathlib `HomologicalBicomplex.lean`, `TotalComplex.lean`.

**Deliverable.** `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/Bicomplex.lean` (NEW). Substantive new content:
1. `HomologicalComplex₂.filtrationOnTotal K p : HomologicalComplex C c` — the `p`-th piece of the canonical filtration on `K.total`, given by `⊕_{p' ≥ p} K_{p', q}`. Including:
   - `filtrationOnTotal_mono : F^{p+1} ⊆ F^p`.
   - `filtrationOnTotal_exhaustive : ⋃_p F^p = K.total`.
   - `filtrationOnTotal_separated : ⋂_p F^p = 0` (first-quadrant).
2. `HomologicalComplex₂.grOnTotal K p : HomologicalComplex C c` — the `p`-th graded piece, with `(K.grOnTotal p).X (p+q) ≅ (K.X p).X q` (the q-th object of column p).
3. `HomologicalComplex₂.spectralObject K : SpectralObject (HomologicalComplex C c) EInt` — the spectral object packaging the H-data `H^n (F^p / F^{p+1})` and δ-data from the s.e.s. of filtration quotients. Proves the SpectralObject axioms via standard homological algebra on the s.e.s.
4. `HomologicalComplex₂.spectralObject_isFirstQuadrant : (K.spectralObject).IsFirstQuadrant` — instance.

**Acceptance bar.** Per §0 12-bar template. Specifically:
- (2) Non-vacuous: a concrete tensor-product bicomplex (e.g. `tensor` of two single-row complexes) → recover the standard `F^p` filtration on its total.
- (10) `MATHLIB-PR-CANDIDATE: yes (definitive)`; new file `Mathlib/Algebra/Homology/SpectralObject/Bicomplex.lean` mirrors structure (in mathlib upstream, would live in `Mathlib/Algebra/Homology/SpectralObject/`).

**MATHLIB-PR-CANDIDATE: yes (definitive).** Standard textbook content; cleanest bridge between two well-tested mathlib infrastructure pieces.

**Sub-split contingency.** Filtration construction (1) + (2) + grading isos = Z2a (~250k); SpectralObject axioms + IsFirstQuadrant instance = Z2b (~250k).

### Z3 — `UC-Lean-Z3-BicomplexConvergence`

**Title.** UC-Lean-Z3-BicomplexConvergence: assemble the genuine bicomplex spectral sequence + abutment filtration + grEInftyIso + chain-Homotopy → gr_p vanishing adapter.

**Budget.** 350–450k.

**Deps.** Z1 + Z2.

**Deliverable.** `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/Convergence.lean` (NEW). Substantive new content:
1. `HomologicalComplex₂.spectralSequenceProper K : SpectralSequence C (fun r ↦ ComplexShape.spectralSequenceNat ⟨r, 1-r⟩) 2` — composition `(K.spectralObject).spectralSequence coreE₂CohomologicalNat` packaged at the bicomplex level.
2. `HomologicalComplex₂.spectralSequence_iso_X1_spectralSequence_of_degenerate K [Degenerate K]` — the comparison iso linking Z3's proper SS with X1's direct-construction SS when both are degenerate (the case Y4 dealt with via `trivialConvergesTo`).
3. `HomologicalComplex₂.abutmentFiltration K p n : C` — `F^p H^n(K.total)`, induced from `K.spectralObject.H`.
4. `HomologicalComplex₂.grEInftyIso K (p q : ℕ) : gr_p H^{p+q}(K.total) ≅ ((K.spectralSequenceProper).page ∞).X (p, q)` — graded-piece iso.
5. `HomologicalComplex₂.nullHomotopyOnFiltrationPiece K (p q : ℕ) (h : Homotopy (...) 0) : IsZero (gr_p H^{p+q}(K.total))` — the A.10 chain-homotopy adapter, lifted to the SpectralObject canonical filtration.

**Acceptance bar.** Per §0 12-bar template. Specifically:
- (2) Non-vacuous: at the X1 tensor-product bicomplex example, recover `H^*(Tot)` from the abutment filtration via `grEInftyIso`.
- (11) the chain-Homotopy adapter accepts a `Homotopy` on the filtration-piece chain complex and produces `IsZero` on the corresponding `gr_p H^n`, NOT on the X1 degenerate-page shortcut.

**MATHLIB-PR-CANDIDATE: yes (definitive).** Fundamental SS infrastructure.

**Sub-split contingency.** Items (1)+(2) = Z3a; items (3)+(4)+(5) = Z3b. Z3a is the "construction" piece; Z3b is the "API" piece.

### Z4 — `UC-Lean-Z4-EquivariantSpectralObject`

**Title.** UC-Lean-Z4-EquivariantSpectralObject: equivariant SpectralObject for a finite (abelian) group G; isotype splitting preserved across `homologyData` + SS assembly.

**Budget.** 300–400k.

**Deps.** Z1, Z2, Z3, X3 (mg-fade, the `EquivariantBicomplex G` structure), X4 (mg-9822, abelian-Schur + degenerate-page differential vanishing).

**Deliverable.** `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/Equivariant.lean` (NEW). Substantive new content:
1. `EquivariantSpectralObject (G : Type*) [Group G] [Fintype G]` — a `SpectralObject` with a G-action on H-data + δ-data + composability with the SpectralObject axioms.
2. `HomologicalComplex₂.spectralObject_of_equivariant K [EquivariantBicomplex G] : EquivariantSpectralObject G ...` — the equivariant lift through Z2's bicomplex bridge.
3. `EquivariantSpectralObject.isotypeSplit_page (G abelian) : (X.spectralSequence).page r .X pq ≅ ⊕_{χ : G → ℂˣ} (X.isotype χ.spectralSequence).page r .X pq` — pages split along characters.
4. `EquivariantSpectralObject.isotypeSplit_homologyData_compat` — the splitting is preserved by `homologyData` (kernel-fork limit + cokernel-cofork colimit + epi-mono fac all commute with finite direct sums in an abelian category).
5. `EquivariantSpectralObject.isotypeSplit_d_compat` — SS differentials respect the splitting (Schur-abelian via X4: distinct-isotype differentials vanish at every page).
6. Specialisation to G = (Z/2)^n with `Finset (Fin n)` indexing characters via Walsh signs (the union_closed-specific use case; transition lemmas linking to X3's existing Walsh structure).

**Acceptance bar.** Per §0 12-bar template. Specifically:
- (2) Non-vacuous: at G = (Z/2)^3 acting on a tensor-product bicomplex (or directly on Y1's `BKBicomplexHC₂` via Y2's `BKEquivBicomplex`), recover the χ_x-isotype graded SS pages.
- (11) `respectsDifferentials` extends from the X1 degenerate case (X4 mg-9822) to the non-degenerate SpectralObject-derived case.

**MATHLIB-PR-CANDIDATE: conditional.** General `EquivariantSpectralObject` is mathlib-worthy but possibly larger than a clean upstream PR. **Recommendation:** finite-abelian-G specialisation first; broader generalisation as separate follow-on.

### Z5 — `UC-Lean-Z5-SpectralObjectEdgeMap`

**Title.** UC-Lean-Z5-SpectralObjectEdgeMap: SS edge maps via SpectralObject abutment filtration; specialisation to union_closed BK bicomplex shape.

**Budget.** 250–300k.

**Deps.** Z1, Z2, Z3.

**Deliverable.** `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/EdgeMap.lean` (NEW). Substantive new content:
1. `SpectralSequence.edgeMap_horiz K p : E_∞^{p, 0} → H^p(K.total)` — the row-edge map; mono in the first-quadrant convergent case.
2. `SpectralSequence.edgeMap_vert K q : H^q(K.total) → E_∞^{0, q}` — the column-edge map; epi in the first-quadrant convergent case.
3. `SpectralSequence.edgeMap_horiz_mono K p [FirstQuadrant]` — instance.
4. `SpectralSequence.edgeMap_horiz_compat_grEInftyIso K p : edgeMap_horiz K p ≫ (mono_in_F^p H^p) = grEInftyIso K p 0` — compatibility with Z3's graded-piece iso.
5. Union_closed-specific: `BKBicomplexHC₂_edgeMap_chi_x_isotype F x : (gr_x H^{n-1}(Tot)).chi_x_isotype → ((BKTotal n).homology 0).chi_x_isotype` — the χ_x-isotype slice of the edge map, packaged at the level Z9 needs for `obstructionCohomClassZ` projection.

**Acceptance bar.** Per §0 12-bar template. Specifically:
- (2) Non-vacuous: at the BK bicomplex for `IntClosedFam 3`, the χ_x-isotype slice of E_∞^{x, n-1-x} identifies with the χ_x-isotype slice of `gr_x H^{n-1}(Tot)`.

**MATHLIB-PR-CANDIDATE: yes** for the general edge maps; **no** for the union_closed-specific specialisation (split at the upstream PR boundary).

### Z6 — `UC-Lean-Z6-BKBicomplexProperPath`

**Title.** UC-Lean-Z6-BKBicomplexProperPath: refactor Y1+Y1b's `BKBicomplexHC₂ F` to consume Z2's bicomplex→SpectralObject bridge cleanly; align shape if needed.

**Budget.** 200–300k.

**Deps.** Z1, Z2, Z3, Y1 (mg-17dc), Y1b (mg-ba0f).

**Deliverable.** `lean/UnionClosed/UC10/BKBicomplexHC2.lean` (MODIFY) + possibly `lean/UnionClosed/UC10/BKBicomplexProperPath.lean` (NEW companion file). Substantive content:
1. Shape alignment: Y1+Y1b chose `(.down ℕ, .down ℕ)` per scoping doc §3.3.1 mathematical justification (bar resolution is homological, cosimplicial cobar degenerates). `ComplexShape.spectralSequenceNat` uses `.up ℕ` internally (cohomological grading). Z6 establishes the comparison: `BKBicomplexHC₂_to_spectralSequence : (BKBicomplexHC₂ F).spectralObject.spectralSequenceProper` via cohomological-shape transport.
2. Verify Y1b's higher-row Fin.succAbove-based bar-resolution faces + simplicial d²=0 give a proper bicomplex consumable by Z2 (the Y1 `lake build` GREEN on `(.down ℕ, .down ℕ)` should transport cleanly to the SpectralObject expected shape).
3. Cross-link annotations: `BKBicomplexHC₂ F`'s in-file header gets a §"Z6 cross-link" pointing to the proper SpectralObject pipeline.

**Acceptance bar.** Per §0 12-bar template. Specifically:
- (2) Non-vacuous: `(BKBicomplexHC₂ F).spectralObject_spectralSequence` produces a non-trivial first-quadrant SS at n=3 fullPowerset3; the E_2 page identifies with iterated cohomology.
- (11) NO `IsDegenerate` workaround: the BK bicomplex SS may carry non-trivial d_r for r ≥ 2 (cf. Y4's `BKEInftyVanishing_at_x` was about the small isotype slice's E_∞ vanishing under the X1-degenerate framing; Z6+Z8 handle the genuine d_r case where the χ_x-slice null-homotopy gives gr_x = 0 even if the un-projected SS is non-degenerate).

**MATHLIB-PR-CANDIDATE: no** (union_closed-specific bicomplex).

### Z7 — `UC-Lean-Z7-WalshEquivariantProperPath`

**Title.** UC-Lean-Z7-WalshEquivariantProperPath: refactor Y2's `BKEquivBicomplex` + `walshIsotypeProj` to consume Z4's equivariant SpectralObject pipeline.

**Budget.** 250–350k.

**Deps.** Z4, Z6, Y2 (mg-f5b4).

**Deliverable.** `lean/UnionClosed/UC10/BKWalshEquivariant.lean` (MODIFY) + possibly `lean/UnionClosed/UC10/BKWalshEquivariantProperPath.lean` (NEW companion). Substantive content:
1. Lift Y2's `BKEquivBicomplex n F : EquivariantBicomplex (Multiplicative (Fin n → ZMod 2))` through Z2's bicomplex→SpectralObject bridge, producing `EquivariantSpectralObject (Multiplicative (Fin n → ZMod 2))` for the BK bicomplex.
2. Lift Y2's `walshIsotypeProj n S F` (Maschke isotype projector at chain level) through Z4's per-page isotype splitting, producing `BKChiSpectralSequence n S F` (the χ_S-isotype sub-SS).
3. Verify Y2's Schur-abelian X4 invocation (`BKWalshIsotype_differential_zero_n3`) extends from the X1 degenerate case to the Z4 non-degenerate SpectralObject-derived case.
4. Cross-link annotations.

**Acceptance bar.** Per §0 12-bar template. Specifically:
- (2) Non-vacuous: at n=3 fullPowerset3, the χ_{1}-isotype slice of the SpectralObject-derived SS is non-trivial at E_2 with the expected Walsh-sign structure.

**MATHLIB-PR-CANDIDATE: no** (union_closed-specific Walsh structure).

### Z8 — `UC-Lean-Z8-HomotopyBridgeProperPath`

**Title.** UC-Lean-Z8-HomotopyBridgeProperPath: lift Y3's `BKIsotypeColumn_nullHomotopy F x` to a `Homotopy` on the χ_x-isotype slice of `(BKBicomplexHC₂ F).total`; apply Z3's chain-Homotopy → gr_x adapter; derive `IsZero (gr_x H^{n-1}(Tot))`.

**Budget.** 350–450k (load-bearing piece; tighter than Y3+Y4 sum because Z8 replaces the chain-side lift workaround that produced Y6's structural blocker).

**Deps.** Z3, Z4, Z7, Y3 (mg-3fdc).

**Deliverable.** `lean/UnionClosed/UC11/BKWalshHomotopyBridgeProperPath.lean` (NEW) + possibly modify `BKWalshHomotopyBridge.lean` for cross-links. Substantive content:
1. `BKBicomplexHC2_chi_x_isotype_slice F x : HomologicalComplex (ModuleCat ℚ) (.down ℕ)` — the χ_x-isotype subcomplex of `(BKBicomplexHC₂ F).total`, via Z7's per-page χ_x splitting applied to the total complex (NOT the small 1-dim Y3 abstraction).
2. `BKBicomplexHC2_chi_x_homotopy F x : Homotopy (𝟙 (BKBicomplexHC2_chi_x_isotype_slice F x)) 0` — the χ_x-isotype null-homotopy, built by extending Y3's `BKIsotypeColumn_nullHomotopy F x` via the χ_x-isotype splitting (per Z7). The extension is NOT a chain-map lift on the topVertex generator (which is the Y6 blocker); it is a chain-Homotopy lift on the χ_x-isotype slice, which exists because UC10_lowerWalshVanishing chain identity restricts to identity on the χ_x-isotype (the χ_∅-isotype `topVertex` generator is in a DIFFERENT slice and is NOT touched by the χ_x lift).
3. `BKSpectralObjectAbutmentVanishing F x : IsZero ((BKBicomplexHC₂ F).abutmentFiltration_gr (x : ℕ) ((n-1) - x))` — application of Z3's `nullHomotopyOnFiltrationPiece` adapter to (2). This is the SpectralObject-derived form of Y4's `BKSSCohomologyVanishing F x`, without the chain-map-extension blocker.

**Acceptance bar.** Per §0 12-bar template + a specific bar 13:
- (13) **No chain-map-extension on `topVertex` invoked**. The Y6 blocker was that the Y4 lift to `topVertex` is degree-0-only with no chain-map extension. Z8 must NOT invoke any analogue of that lift — the χ_x-isotype piece is a different graded piece of the BK bicomplex, and the `topVertex` chain generator never enters Z8's argument.

**MATHLIB-PR-CANDIDATE: no** (union_closed-specific application).

### Z9 — `UC-Lean-Z9-ObstructionCohomClassRefactor`

**Title.** UC-Lean-Z9-ObstructionCohomClassRefactor: define `obstructionCohomClassZ F x : (BKBicomplexHC₂ F).abutmentFiltration_gr x ((n-1) - x)` via Z3+Z4+Z5 chain; close per-x vanishing via Z8 substantively; re-point Y5's def-aliased `obstructionCohomClass` through `obstructionCohomClassZ`.

**Budget.** 250–350k.

**Deps.** Z3, Z4, Z5, Z8.

**Deliverable.** `lean/UnionClosed/UC11/CohomologyClass.lean` (MODIFY); `lean/UnionClosed/UC11/SSConvergence.lean` (MODIFY, delete Y6 bridge); `lean/UnionClosed/UC11/ObstructionClassProperPath.lean` (NEW companion). Substantive content:
1. `obstructionCohomClassZ F : Fin n → (BKBicomplexHC₂ F).abutmentFiltration_gr ...` — the SpectralObject-derived per-x χ_x-graded piece of `H^{n-1}(Tot)`.
2. `obstructionCohomClassZ_eq_zero F hStar x : obstructionCohomClassZ F x = 0` — closure via Z8's `BKSpectralObjectAbutmentVanishing F x` + Subsingleton.elim (IsZero gives Subsingleton at the underlying module level).
3. Re-point Y5's `obstructionCohomClass F` def-alias to factor through `obstructionCohomClassZ` (with an explicit type-coercion via Z5's χ_x-isotype edge map).
4. Delete Y6 bridge `obstructionCohomClassChain_eq_zero_via_y6_transport_residual` and the named `sorry` at `SSConvergence.lean:596`. The Y6 lift injectivity primitive `BKIsotypeColumn_lift_to_BKBicomplexHC2_injective` survives as a chain-level fact unused by Z9.

**Acceptance bar.** Per §0 12-bar template + bar 13 from Z8. Specifically:
- (3) **Zero live sorrys at `SSConvergence.lean`**: the Y6 bridge sorry at `SSConvergence.lean:596` is GONE.
- (12) `obstructionCohomClassZ F x` lives in `(BKBicomplexHC₂ F).abutmentFiltration_gr x ((n-1)-x)`, NOT in `(BKTotal n).homology 0`.
- (11)+(13): no IsDegenerate workaround invoked at the BK bicomplex level; no chain-map-extension on `topVertex` invoked.

**MATHLIB-PR-CANDIDATE: no** (union_closed-specific obstruction class).

### Z10 — `UC-Lean-Z10-FranklHoldsClosure`

**Title.** UC-Lean-Z10-FranklHoldsClosure: PROJECT-LIFE MILESTONE — close `Frankl_Holds` end-to-end via Z9's `obstructionCohomClassZ` substantively; zero live sorrys; non-vacuous; non-tautological.

**Budget.** 200–300k.

**Deps.** Z1–Z9 all GREEN.

**Deliverable.** `lean/UnionClosed/Frankl.lean` (MODIFY); cumulative `docs/state-UC-Lean-Z10-FranklHoldsClosure.md` + `state-UC10.md` Session N entry.

Substantive content:
1. Rewrite `obstructionClass_cohomology_vanishing` body to invoke `obstructionCohomClassZ_eq_zero F hStar x` (Z9) directly; produce `absurd hZCohomZ hZCohomNZ` chain.
2. Re-target the non-vanishing argument `obstructionCohomClassZ_at_ne_zero_of_pos_bias` via the SpectralObject SS — the chain comes via UC11 §6.2 lifted to the SS abutment edge map.
3. Verify Frankl_Holds builds GREEN end-to-end; verify Frankl_Holds_fullPowerset3 + Frankl_Holds_fullPowerset4 build GREEN non-vacuously (the existing concrete L4 minimal-element witnesses survive unchanged; the universal Frankl_Holds now closes via Z9+Z10 substantively).

**Acceptance bar (12 bars + bar 13 + bar 14).** Per §0 + Z8 + new bar:
- (14) **Frankl_Holds end-to-end GREEN with zero live sorrys**: `grep -rn 'sorry' lean/UnionClosed/` returns empty. This is the PROJECT-LIFE MILESTONE trigger.

**MATHLIB-PR-CANDIDATE: no** (union_closed-specific closure).

**Z10 verdict structure.**
- **GREEN**: closure complete; **PROJECT-LIFE MILESTONE TRIGGERED**; 3-step post-formalization plan activates per `project-post-formalization-followons` memory.
- **AMBER**: closure mostly assembled but a single edge-map shape adjustment or filtration-piece identification needs a thin re-proof. Strictly tighter than Y6 AMBER.
- **RED**: structural blocker discovered in the Z9 encoding. If Z1–Z9 each pass acceptance, this should not happen; if it does, file an escalation ticket and re-audit Phase B refactor choices.

### Sub-ticket budget summary

| Sub-ticket | Budget (k tokens) | Deps | mathlib-PR? |
|---|---|---|---|
| Z1 — SpectralObject SS assembly | 450–600 | (none) | **Yes (definitive)** |
| Z2 — Bicomplex → SpectralObject | 400–550 | Z1 | **Yes (definitive)** |
| Z3 — Bicomplex convergence + chain-Homotopy adapter | 350–450 | Z1, Z2 | **Yes (definitive)** |
| Z4 — Equivariant SpectralObject | 300–400 | Z1, Z2, Z3 + X3/X4 | Conditional |
| Z5 — SpectralObject edge maps | 250–300 | Z1, Z2, Z3 | Yes (general); No (UC-specific) |
| **Stage 1+2 subtotal (Z1–Z5)** | **1.75–2.30M** | | |
| Z6 — BK bicomplex proper path | 200–300 | Z1, Z2, Z3 + Y1, Y1b | No |
| Z7 — Walsh-equivariant proper path | 250–350 | Z4, Z6 + Y2 | No |
| Z8 — Homotopy bridge proper path | 350–450 | Z3, Z4, Z7 + Y3 | No |
| Z9 — obstructionCohomClass refactor | 250–350 | Z3, Z4, Z5, Z8 | No |
| Z10 — Frankl_Holds end-to-end closure | 200–300 | Z1–Z9 | No |
| **Stage 3 subtotal (Z6–Z10)** | **1.25–1.75M** | | |
| **Arc total** | **3.00–4.05M** | | |

Plus 10–20% margin for sub-splits → **3.40–4.60M Lean budget for the full arc**.

### Critical-path observations

- **Z1 → Z2 → Z3 → (Z4 ∥ Z5)** is the upstream-mathlib critical path; Z4 and Z5 can run in parallel once Z3 lands.
- **Z6 can start in parallel with Z3** (Z6 only needs Z1+Z2 — bicomplex bridge + SpectralObject — but uses Z3's convergence for downstream; the Z6 file can be drafted in parallel and finalised after Z3).
- **Z7 needs Z4 and Z6**.
- **Z8 needs Z3, Z4, Z7**.
- **Z9 needs Z3, Z4, Z5, Z8** — Z9 is the closure ticket assembling everything for the per-x vanishing.
- **Z10 strictly requires Z1–Z9** — the PROJECT-LIFE MILESTONE.
- **No sub-ticket requires a workaround chain** (no degenerate-page shortcut; no chain-side `topVertex` lift; no `False.elim` on `_hStar`).
- **Sub-split fallbacks** are pre-authorised for Z1, Z2, Z3, Z8 (the largest tickets). The polecat at execution time files `Z<i>a` / `Z<i>b` per the X1a/X1b precedent.

### Cadence + parallelisation

Per the Path B precedent (Y1 + Y1b filed in parallel via mg-17dc + mg-ba0f), the Z arc supports moderate parallelism:

- **Cohort 1 (sequential mathlib infrastructure):** Z1 → Z2 → Z3 strict-serial.
- **Cohort 2 (parallel-after-Z3 mathlib):** Z4 ∥ Z5 once Z3 lands.
- **Cohort 3 (parallel-with-mathlib union_closed):** Z6 can be drafted in parallel with Z2 (only needs Z1+Z2 substantively); Z7 can be drafted in parallel with Z4 (only needs Z4's structural inputs).
- **Cohort 4 (serial closure):** Z8 → Z9 → Z10 strict-serial.

Realistic wall-clock: at ~1 single-session-capable execution per polecat per session (allowing one session per ticket), **~10 polecat-sessions for the strict-serial path; potentially 7–8 polecat-sessions if Cohort 2 and 3 run in parallel**. At Daniel's typical cadence this maps to a multi-week wall-clock per the directive's "multi-month" estimate (which allows for mathlib-PR review cycles + AMBER follow-ons).

---

## §4 — Phase D: mathlib-PR coordination + Daniel decisions

### D.1 PR cadence question

The three Z-tickets with **MATHLIB-PR-CANDIDATE: yes (definitive)** (Z1, Z2, Z3) are upstream-quality content; the conditional ones (Z4, Z5) require additional design decisions about scope.

**Daniel decisions needed:**

**D.1.a — When to PR Z1 upstream?**
- **Option A (eager):** PR Z1 upstream as soon as `lake build` GREEN on its mathlib-folder copy. Pro: closes mathlib's own TODO promptly; Joël Riou likely receptive; community visibility helps the rest of the Z arc. Con: mathlib-PR review cycle adds latency; if upstream review iterates the structure, Z2 may need rework.
- **Option B (deferred):** PR Z1, Z2, Z3 as a bundle after all three close GREEN in union_closed-folder copies. Pro: review-stable; mathlib reviewers see complete pipeline; less rework risk. Con: longer time-to-upstream; delays community feedback.
- **Option C (per-Z-i):** PR each Z-i upstream as it lands GREEN, in order Z1→Z2→Z3→...→Z5. Pro: incremental review; each piece reviewed in isolation. Con: 5 separate mathlib-PR cycles; coordination overhead.

**Recommendation (polecat default if Daniel does not override):** **Option B (deferred bundle)**. Reasoning: the Z1+Z2+Z3 design is interdependent (Z1's homologyData signature affects Z2's bicomplex bridge, which affects Z3's convergence form); a unified PR is review-stable and avoids the X1-style "we built it, then realised it needed restructuring" risk. The bundled PR also lets Joël Riou see the complete bicomplex SS pipeline at once.

**D.1.b — When to PR Z4 and Z5 upstream?**
- After Z4's finite-abelian-G specialisation is solid, PR upstream separately from Z1+Z2+Z3. Z4's general-G generalisation is a separate (post-Frankl) follow-on.
- Z5's general edge maps PR alongside Z3 (they share the convergence + abutment infrastructure).

**D.1.c — Should existing X1–X5 PR upstream NOW (before the Z arc lands)?**

X1 (mg-dd80), X3 (mg-fade), X4 (mg-9822), X5 (mg-c128) are **already mathlib-PR-clean** with explicit `MATHLIB-PR-CANDIDATE: yes` header annotations. They are valid standalone facts about the X1-style direct-construction SS; their content does not depend on the Z arc.

- **Option A:** PR X1–X5 upstream now (separate from Z arc). Pro: low-risk early upstreaming; mathlib gets value immediately; signals project momentum on Zulip. Con: review may surface design feedback that ideally would be incorporated alongside Z1–Z5; possible duplicate content with Z1+Z2+Z3 in mathlib's eventual surface.
- **Option B:** Wait for Z arc. PR X1–X5 alongside Z1–Z5 as a coherent "bicomplex SS infrastructure" bundle. Pro: review-stable; mathlib reviewers see the complete picture. Con: longer time-to-upstream.
- **Option C:** PR X1–X5 now AS the bicomplex SS, treating Z1–Z3 as a separate "general SpectralObject completion" PR. Pro: X1's direct-bicomplex construction is genuinely independent of and complementary to Z2+Z3; mathlib could carry both (a "fast direct route for degenerate-or-special SSs" alongside a "general route via SpectralObject"). Con: requires Daniel coordination with mathlib reviewers about which API to canonicalise.

**Recommendation (polecat default):** **Option B (wait for Z arc)**. Reasoning: X1's degenerate-SS construction is shadowed by Z3's proper construction when the bicomplex is non-degenerate; mathlib reviewers will likely prefer one canonical bicomplex-SS API. Bundling X1–X5 + Z1–Z5 lets reviewers choose. *However*, if Daniel wants early Zulip visibility (his 23:12Z framing about "publishing on Zulip"), Option A could be done as a "preview PR" with explicit `awaiting Z arc for canonicalisation` annotation.

**D.1.d — Zulip community engagement.**

Daniel's 23:12Z framing explicitly mentioned "publishing on Zulip". Three engagement points:
- **Pre-Z1:** post a Zulip RFC describing the planned `Abelian.SpectralObject.spectralSequence` completion + bicomplex bridge approach; solicit early feedback from Joël Riou + mathlib homological-algebra reviewers BEFORE coding. Pro: catches design issues before 450–600k tokens go into Z1; aligns with mathlib idioms.
- **Mid-Z arc:** post Z1's PR draft + design notes; cross-link the union_closed Frankl context lightly (so reviewers understand why this is being built).
- **Post-Z10:** announce the PROJECT-LIFE MILESTONE on Zulip; cross-link the published paper + this scoping doc; thank Joël Riou + reviewers.

**Recommendation (polecat default):** **all three engagement points**. Daniel may want to take the lead on the Zulip posts personally given his "publishing on Zulip" framing.

### D.2 Cross-repo author attribution

The Z arc's Z1–Z3 mathlib content effectively co-authors with Joël Riou (Riou architected SpectralObject; we close the TODO). Author lines on `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/SpectralSequenceAssembly.lean` should credit both:

```
Authors: Union-Closed Polecat (mg-103f's Z arc); follows the design of Joël Riou's
  SpectralObject infrastructure (Mathlib/Algebra/Homology/SpectralObject/*).
```

On upstream PR, primary authorship is the executing polecat (Daniel ultimately); Joël Riou is acknowledged in the PR description.

### D.3 Daniel direction-setting decisions for the scoping ticket

**Daniel decisions blocked on this scoping verdict:**

1. **Accept the Z1–Z10 decomposition** as the next execution plan (vs file additional sub-arcs, vs revise budget, vs accept the alternative path Z6b/Walsh-isotype-chain-refactor named as a sub-week alternative in Y6 mg-e75c).
2. **Choose PR cadence (D.1.a–D.1.c).**
3. **Choose Zulip engagement plan (D.1.d).**
4. **Authorise the broadened mathlib-folder scope** (Z arc touches both `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/` and (preserved) `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/`).
5. **Authorise multi-month arc.** Per the ticket's "multi-month per Daniel directive" framing, this is implicit, but explicit GREEN-light-the-Z-arc-as-a-multi-month-investment is desirable before filing Z1.

### D.4 Risk: Joël Riou drops a TODO closure himself

Joël Riou maintains the SpectralObject infrastructure actively. There is a non-zero risk he closes the `Abelian.SpectralObject.spectralSequence` TODO independently during the Z arc's execution window. Mitigation:

- **Pre-Z1 Zulip RFC** (D.1.d) explicitly asks Joël if he has near-term plans for the TODO; if yes, Daniel decides whether to wait or proceed in parallel.
- **If Riou ships first:** Z1 work pivots to consuming his version; Z2 onwards proceeds unchanged. The polecat-side work is preserved as **alternative-implementation review notes** in `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/Z1NotesAfterRiouUpstream.md`.
- **If parallel:** the union_closed branch's Z1 work cleanly merges with Joël's version (both target the same TODO with the same signature; mathlib-PR-clean naming is preserved).

### D.5 Risk: SpectralObject design constraint hits Z2 mid-execution

The `SpectralObject` axioms may interact badly with the canonical bicomplex filtration in a way that requires additional structural choices (e.g. which `EInt` indexing convention; how `ι`-typed indices interact with `ℕ × ℕ` page positions). If Z2 hits a snag, the contingency:

- Z2a sub-split (filtration construction) first; pause; assess; choose between continuing Z2b (SpectralObject axioms verbatim) vs filing a separate Z2c (alternative `SpectralObject` construction via a different filtration). The latter is **out of scope** for the Z arc's initial filing; if needed, escalate to Daniel.

---

## §5 — Verdict + next step

**Verdict.** **GREEN scoping complete + Z1–Z10 decomposition pinned + Phase D mathlib-PR coordination plan named.**

**Audit summary (Phase A).** All 12 audit items mapped. Three RED pieces (A.7 bicomplex bridge, A.8 equivariant lift, A.9 edge maps); two AMBER pieces (A.3 SS assembly, A.10 chain-homotopy adapter); everything else GREEN. **No structural impossibility found.** The multi-month estimate reflects volume.

**Refactor plan (Phase B).** X1–X5 SURVIVE as standalone mathlib-PR candidates (no rewrite). Y1+Y1b BK bicomplex + Y2 Walsh-equivariant + Y3 chain-Homotopy survive as chain-level inputs. Y4+Y5+Y6 are REPLACED by Z6–Z9 SpectralObject-derived path. The Y6 chain-map-extension structural blocker is sidestepped because the new `obstructionCohomClassZ F x` lives in `(BKBicomplexHC₂ F).abutmentFiltration_gr x ((n-1)-x)`, not in `(BKTotal n).homology 0`; the χ_x-isotype graded piece of `H^{n-1}(Tot)` is genuinely zero (the `topVertex` chain generator is in the χ_∅-isotype, not the χ_x-isotype, so projection kills it at chain level before cohomology).

**Sub-tickets (Phase C).** Z1–Z5 mathlib-PR infrastructure (1.75–2.30M); Z6–Z10 union_closed-side refactor + PROJECT-LIFE MILESTONE closure (1.25–1.75M). Critical path Z1 → Z2 → Z3 → (Z4 ∥ Z5) → Z6 → Z7 → Z8 → Z9 → Z10 with parallelisation opportunities at Cohort 2 and Cohort 3 (Z6 ∥ Z2; Z7 ∥ Z4). Each single-session-capable per the X+Y discipline; sub-split fallbacks pre-authorised for Z1, Z2, Z3, Z8. **Total: 3.40–4.60M tokens, multi-month per Daniel directive.**

**PR coordination (Phase D).** Recommended cadence: Option B (deferred bundle PR for Z1+Z2+Z3); separate PRs for Z4 (finite-abelian first) and Z5 (general edge maps). X1–X5 wait for Z arc bundle. Three-touchpoint Zulip engagement (pre-Z1 RFC, mid-arc PR, post-Z10 announcement). Daniel may want to take the Zulip lead personally.

**Next operational step (Daniel decisions blocked on this verdict, see D.3):**

1. Accept Z1–Z10 decomposition + budget envelope.
2. Choose PR cadence (D.1.a–D.1.c).
3. Choose Zulip engagement plan (D.1.d).
4. Authorise broadened mathlib-folder scope.
5. Authorise multi-month arc.

After Daniel GREENs the above, **file Z1 (`UC-Lean-Z1-SpectralObjectAssembly`) as the next execution ticket**, budget 450–600k (with Z1a/Z1b sub-split contingency authorised in advance). Polecat profile: Lean-engineering + mathlib homological-algebra architecture (Joël Riou's SpectralObject style) + mathlib-PR-coordination comfort.

---

## §6 — Open questions / dependencies / risks

### §6.1 Walsh-isotype chain refactor alternative (Y6b path)

Y6 mg-e75c named a **Y6b alternative**: refactor `(BKTotal n).X 0` to faithfully realise the per-S (Z/2)^n-Walsh-isotype decomposition at chain level, sidestepping `topVertex_not_coboundary` chain-wise. Estimated multi-week (sub-month) vs the Z arc's multi-month.

**Trade-off analysis:**
- **Y6b pros:** faster wall-clock; chain-side refactor stays in union_closed-internal scope; no mathlib-PR coordination needed.
- **Y6b cons:** still a workaround (Daniel's "don't pursue shortcuts" directive applies — this is the path Daniel rejected in the 12:47Z directive); does not produce upstream-quality mathlib content; the underlying issue (mathlib has incomplete SpectralObject infrastructure) is not addressed.
- **Z arc pros:** addresses the root cause; produces upstream-quality mathlib content; eliminates the X+Y workaround pattern; positions union_closed for the post-Frankl 3-step follow-on plan (UC-Lean-audit + UC-paper-draft + UC-publishing-doc).
- **Z arc cons:** longer wall-clock (multi-month vs sub-month); requires Daniel coordination with mathlib reviewers; risks Joël Riou shipping competing TODO closure (D.4).

**Polecat recommendation (per Daniel directive):** **Z arc**. The 12:47Z directive is explicit: "I don't want to hit yet another roadblock because we put off doing things the right way and kept pursuing shortcuts." Y6b is exactly the kind of shortcut Daniel just rejected. Filed for completeness.

### §6.2 PROJECT-LIFE MILESTONE deferred to Z10

The "zero live sorrys end-to-end" + `Frankl_Holds` end-to-end-non-vacuous + non-tautological milestone has been **deferred** at every L+X+Y ticket since L5. It is now Z10's responsibility. With the Z arc's "don't pursue shortcuts" framing and the chain-map-extension blocker sidestepped by encoding choice, Z10 is the **structurally-clean closure path**.

If Z10 hits a residual gap, the diagnosis structure should match X6→Y4→Y5→Y6 (strictly-narrowing AMBER with substantive primitive deliveries). The only known structural concern is: does the χ_x-isotype null-homotopy on the **full** `(BKBicomplexHC₂ F).total` actually exist? Y3 built it on the **small** 1-dim ℚ-line abstraction; Z8 must build the genuine version on the full bicomplex's χ_x slice. The Walsh decomposition Y2 + Walsh chain identity mg-fbbb provide the substantive inputs; the lift should work IF the χ_x-isotype splitting of `(BKBicomplexHC₂ F).total` is faithful at every degree (which it is, per Y2's `walshIsotypeProj` Maschke construction in char 0 over ℚ).

### §6.3 Compatibility risk: Z6 shape transport

Y1+Y1b's `(.down ℕ, .down ℕ)` shape vs `ComplexShape.spectralSequenceNat`'s `.up ℕ` cohomological grading. The transport is a thin lemma (`HomologicalComplex` is symmetric in the shape via `op`), but should be verified at Z6 execution time. **Risk: low**; **mitigation: thin comparison lemma** at the bicomplex level. If transport reveals a deeper issue, file Z6b as a separate shape-alignment sub-ticket.

### §6.4 mathlib pin drift

The Z arc spans multi-month wall-clock; mathlib may bump from v4.29.1 to v4.30+ during execution. **Mitigation:**
- **Lock mathlib pin at Z1 start.** Bump only between Z-tickets (never mid-execution).
- **Test pin-bump after each Z-i merge.** Track via existing `pm-onethird`-style sweep.
- **If mathlib's SpectralObject infrastructure evolves substantially** (e.g., Joël Riou closes the TODO independently per D.4), pause Z arc at next Z-i boundary and re-align.

### §6.5 `chainToHomology0`, `topVertex_not_coboundary`, mg-36c3 collision theorems

These all **remain PROVEN** about the L2a baseline `BKTotal n` post-Z arc. They are decoupled from `obstructionCohomClassZ` (which lives in a different cohomology object). They serve as **historical record of the X+Y RED diagnosis** and as **alternative-baseline facts** about `(BKTotal n).homology 0`. Per Path A scoping doc §5.3 + §5.5 precedent, they are preserved verbatim with doc-comment cross-links pointing to Z9.

### §6.6 Frankl_Holds non-vacuous status across Z arc

`Frankl_Holds_fullPowerset3` + `Frankl_Holds_fullPowerset4` build GREEN via concrete L4 minimal-element witnesses across the X+Y arc; they bypass the bridge. They should continue to build GREEN throughout the Z arc; Z10 verifies that the **universal** `Frankl_Holds F` (without the L4 witness shortcut) closes end-to-end.

### §6.7 Acceptance bar 11+12+13+14 — the Z-specific bars

These bars are introduced in this scoping per §0 + per-Z-ticket sections. Their motivation:
- **(11) No IsDegenerate workaround** — prevents Z6+ from accidentally re-introducing the X1 degenerate-page shortcut on the BK bicomplex.
- **(12) No chain-side encoding of cohomology vanishing for the BK bicomplex's χ_x slice** — prevents Z9 from accidentally re-introducing the Y5 def-aliased chain-class shortcut.
- **(13) No chain-map-extension on `topVertex` invoked** — prevents Z8 from accidentally re-introducing the Y4 lift workaround that produced Y6's blocker.
- **(14) Frankl_Holds end-to-end with zero live sorrys** — the PROJECT-LIFE MILESTONE trigger.

All four are checkable mechanically post-execution. (11)–(13) are reviewable via grep + manual inspection; (14) is `grep -rn 'sorry' lean/UnionClosed/` returns empty.

---

## §7 — Cross-references

- **Parent diagnosis 1**: mg-7413 (`UC-Lean-mathlib-SS-scope`, GREEN). Path A scoping doc; §5.1 contingency explicitly named the SpectralObject TODO this Z arc tackles.
- **Parent diagnosis 2**: mg-e1b8 (`UC-Lean-PathB-BKBicomplex-scope`, GREEN). Path B scoping doc.
- **Parent diagnosis 3**: mg-e75c (`UC-Lean-PathB-Y6-ChainToSSTransport`, AMBER 12:28Z). Y6 chain-map-extension structural blocker named; this Z arc sidesteps it via encoding-level refactor.
- **Daniel directive 1**: 2026-05-16 17:47Z (mathlib-folder authorization initial).
- **Daniel directive 2**: 2026-05-16 23:12Z (mathlib-folder authorization scope-doc; "publishing on Zulip" framing).
- **Daniel directive 3**: 2026-05-17 12:47Z (full mathlib infrastructure; "don't pursue shortcuts"); the Z arc's framing motivator.
- **Source repo**: `/Users/daniel/research/union_closed`. Default branch `main`.
- **Mathlib pinned**: `v4.29.1`, rev `5e932f97dd25535344f80f9dd8da3aab83df0fe6` (per `lean/lake-manifest.json`). Re-pin allowed only at Z-i boundaries.
- **Cumulative state**: `docs/state-UC10.md` Lean-Session 35 (this session, scoping); Sessions 36+ will be Z-i execution.
- **Forward execution sub-tickets**: Z1, Z2, Z3, Z4, Z5, Z6, Z7, Z8, Z9, Z10 (filed sequentially per critical path after each predecessor GREEN; Cohort 2 and 3 parallel filings authorised).

---

## §8 — Polecat scoping notes (self-audit)

**What this scoping did NOT do** (out of scope per the ticket's paper-and-pencil framing):
- Did NOT modify any Lean files. `lake build` status preserved (GREEN at 2006 jobs per Lean-Session 34).
- Did NOT execute any Z-ticket's content. Each Z-i requires its own execution polecat.
- Did NOT pre-write the Z-ticket bodies. Z1 onwards will be filed as separate tickets, with this scoping doc + state-UC10.md Lean-Session 35 entry as their starting context.
- Did NOT relitigate the Y6 RED diagnosis. It is taken as factually correct per mg-e75c verdict; the Z arc's design specifically routes around its blocker.
- Did NOT enumerate every detailed SpectralObject API decision. The Z1+Z2+Z3 polecats will make those at execution time; this scoping pins the structural target and the budget envelope.

**What this scoping DID do:**
- Phase A: classified every relevant mathlib piece as GREEN/AMBER/RED with explicit `SpectralObject/SpectralSequence.lean` line-number TODO citations.
- Phase B: enumerated every existing X1–X5 + Y1–Y6 file with explicit SURVIVES/PARTIALLY-SURVIVES/REPLACED verdict.
- Phase C: pinned Z1–Z10 decomposition with budgets, deps, acceptance bars, mathlib-PR labels, sub-split contingencies.
- Phase D: enumerated Daniel decisions and PR cadence options.
- Hard-constraint preservation: all §0 constraints carried into every Z-i acceptance bar; specifically named the "no shortcuts" extension bars (11)–(13)–(14) to prevent the Z arc from re-introducing the X+Y workaround chain.

**Polecat verdict for the scoping itself:** GREEN. Ready for Daniel review + Z1 filing.
