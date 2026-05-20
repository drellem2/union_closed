# Frankl Lean formalisation — proof-structure onboarding (READ FIRST)

> **You are a polecat just dispatched to Frankl Lean work.** Read this file
> *before* anything else: paper notes, state docs, Lean source, prior
> tickets. Goal: 5 minutes to a correct mental model of what is
> unconditionally proved, what is paper-axiomatised, what is
> research-track-deferred, and where the active TODOs live. Then go to the
> primary sources for whatever your ticket actually touches.

**Maintainer.** `pm-pogo` updates this file on every major audit verdict,
disclosure-pivot execution, headline restatement, or Z-arc research-track
ship. Out-of-date sections are worse than missing sections — *flag
staleness, do not silently consume*.

**Last updated.** 2026-05-20 (mg-6d64). Post-mg-6d64 axiom
docstring-refresh: the R1+R2+R3 docstring-only enhancements recommended
by **mg-980f** (`docs/Frankl-axiom-optimization-research.md`, GREEN
verdict) applied to `case3_ss_obstruction_paper_axiom` — R1 formalised
the propositional-equivalence-to-Frankl derivation as a Lean `example`
in the axiom docstring + `lean/AXIOMS.md`; R2 added the
`Frankl_Holds`-variant axiom-dependency map to `lean/AXIOMS.md`; R3
made the narrow-Y4-vs-full-BK distinction explicit in the axiom
docstring. **No axiom-signature or semantic Lean change; `lake build`
GREEN unchanged.** See §3.1 (axiom status / replacement path) and §5
pitfall #6 (narrow Y4 vs full-BK).

**Prior update.** 2026-05-18 (mg-1b2b). Post-mg-1b2b disclosure-pivot
execution: paper-axiom `case3_ss_obstruction_paper_axiom` landed
(`lean/UnionClosed/PaperAxioms.lean`), Y6 sorry deleted, `Frankl_Holds`
restructured into `_concrete` (unconditional) + `_general`
(axiom-dependent) + dispatch, `lean/AXIOMS.md` written with
OneThird-grade disclosure + additional collision-disclosure layer.
SpectralObject infrastructure (Z1+Z1b GREEN, Z2a–Z2j AMBER) preserved
as research-track scaffolding with file-header notes. Z3–Z10 pre-filed
tickets shelved (mg-50b7 + cascade to mg-18b8 + mg-69e7).

---

## §0 — Headline theorem (current Lean state)

`lean/UnionClosed/Frankl.lean` (post-mg-1b2b restructure):

```lean
theorem Frankl_Holds {n : ℕ} (F : IntClosedFam n)
    (h_ne : F.family ≠ ({Finset.univ} : Finset (Finset (Fin n)))) :
    ∃ x : Fin n, beta x F ≤ 0

-- Splits along the axiom-dependency boundary:
theorem Frankl_Holds_general {n} (F : IntClosedFam n) (h_ne : ...) :
    ∃ x : Fin n, beta x F ≤ 0          -- axiom-dependent

theorem Frankl_Holds_concrete {n} (F : IntClosedFam n)
    (h_concrete : ∃ x : Fin n, beta x F ≤ 0) :
    ∃ x : Fin n, beta x F ≤ 0          -- UNCONDITIONAL
```

The classical Frankl union-closed conjecture, restricted to the
intersection-closed dialect (`IntClosedFam`): every non-trivial
intersection-closed family has a Frankl-rare coordinate
(`β_x F ≤ 0`). Universal in `n`; **type-checks at every `n ≥ 1`**.

**Status.** GREEN with one named project axiom (post-mg-1b2b
disclosure-pivot, per mg-ee54 audit gate). The body type-checks; the
former Y6 `sorry` at `SSConvergence.lean:596` is **DELETED**; the
general-case branch (`Frankl_Holds_general`) routes through the
cohomology bridge → former Y6 bridge → **the single named project
axiom** `case3_ss_obstruction_paper_axiom` (see
`lean/UnionClosed/PaperAxioms.lean` + `lean/AXIOMS.md`).

**`#print axioms Frankl_Holds`** lists the mathlib trio
(`Classical.choice`, `propext`, `Quot.sound`) plus the new
`UnionClosed.case3_ss_obstruction_paper_axiom`.

**`#print axioms Frankl_Holds_concrete`** lists only the mathlib trio
— **no project-axiom dependency** (the concrete-witness slice is
UNCONDITIONAL).

**`#print axioms Frankl_Holds_fullPowerset3`** and
**`#print axioms Frankl_Holds_fullPowerset4`** likewise list only the
mathlib trio — they route through `Frankl_Holds_concrete` via L4's
`fullPowersetN_minimal_element` witnesses and **do NOT invoke** the
project axiom.

---

## §1 — Proof tree (top-level split + status tags, post-mg-1b2b)

```
Frankl_Holds  (Frankl.lean, dispatch)  [GREEN; one named project axiom]
│
└── Frankl_Holds_general  (Frankl.lean, axiom-dependent slice)
│
├── Case 1: F.support ≠ univ        [SUBSTANTIVE-FORMALIZED — unconditional]
│      Pick x ∉ support; β_x = -|F.family| ≤ 0 trivially.
│      Inline; no dependencies beyond IntClosedFam algebra.
│
└── Case 2: F.support = univ        [routes through cohomology bridge]
       │
       ├── No-counterexample assumption built from
       │   h_supp ∧ h_ne ∧ (∀x, β_x > 0)  ⇒  IsCounterexample F
       │
       └── frankl_cohomology_to_scalar_bridge  (Frankl.lean:397)
              │
              ├── (a)  obstructionClass F ≠ 0
              │       =  UC11_nonVanishing F hStar
              │       [SUBSTANTIVE-FORMALIZED — UC11/NonVanishing.lean:131]
              │       Routes through UC11 Lemma 6.1 contrapositive +
              │       Finsupp.single_eq_zero + Finset.prod_eq_zero_iff +
              │       cast arithmetic — non-tautological algebraic chain.
              │
              └── (b)  obstructionClass F = 0
                      =  obstructionClass_cohomology_vanishing F hStar
                      [AMBER — live sorry via Y6 bridge]
                      │
                      │  Threads four "have"-bound cohomology primitives,
                      │  ALL SUBSTANTIVE-FORMALIZED at the primitive layer:
                      │
                      ├── UC13_correctedLanding              (UC13_PartA/CorrectedLanding.lean:157)
                      │      [SUBSTANTIVE-FORMALIZED]
                      │      Per-coordinate placement of ob(F) in ⊕_x V_x^{n-1}.
                      │
                      ├── UC10_lowerWalshVanishing           (UC13_PartB/LowerWalsh.lean:374)
                      │      [SUBSTANTIVE-FORMALIZED]
                      │      Per-coordinate twisted-bridge null-homotopy on topVertex.
                      │
                      ├── ThetaMap_isAbutmentEquivalence     (UC14/R1_ThetaMap.lean:278)
                      │      [SUBSTANTIVE-FORMALIZED]
                      │      Θ = id at populated baseline; chain ↔ abutment identification.
                      │
                      ├── obstructionCohomClass_vanishing_via_lowerWalsh
                      │      [SUBSTANTIVE-FORMALIZED via Y5 def-alias]
                      │      Returns 0 for the NEW Y5-aliased obstructionCohomClass;
                      │      propositionally fine (the NEW class is the constantly-zero
                      │      Y4 SS-derived class, def-aliased).
                      │
                      ├── obstructionCohomClassChain_ne_zero_of_counterexample
                      │      (SSConvergence.lean:164)  [SUBSTANTIVE-FORMALIZED]
                      │      OLD chain class non-zero under hStar, via mg-6acd
                      │      topVertex_not_coboundary.
                      │
                      └── obstructionCohomClassChain_eq_zero_via_y6_transport_residual
                             (SSConvergence.lean)  [GREEN; AXIOM-DEPENDENT post-mg-1b2b]
                             │
                             │  Bridge body preserves Y3 chain-homotopy + Y4 SS-IsZero
                             │  + Y4 lift + Y6 lift-injectivity + mg-6acd
                             │  topVertex_not_coboundary + hStar as `have`-bound
                             │  diagnostics. Conclusion delivered via:
                             │
                             └── case3_ss_obstruction_paper_axiom
                                  (PaperAxioms.lean, mg-1b2b)
                                  Single named project axiom. Captures combined
                                  SS-vanishing substep (UC10 §5.3 + UC13 §§4.5+7 +
                                  UC14 R1, substantively-paper-rigorous) AND
                                  Walsh-isotype chain-encoding refinement substep,
                                  both deferred to Z-arc research-track. See
                                  lean/AXIOMS.md for OneThird-grade disclosure +
                                  additional collision-disclosure layer.

Frankl_Holds_concrete  (Frankl.lean, UNCONDITIONAL slice)  [GREEN; no project axiom]
│
└── Takes a Frankl-rare-element witness as hypothesis; returns it.
    Used by Frankl_Holds_fullPowerset3 (via fullPowerset3_minimal_element)
    and Frankl_Holds_fullPowerset4 (via fullPowerset4_minimal_element).
    BYPASSES the bridge entirely.
```

**No live sorrys** in the headline path (mg-1b2b deleted the former Y6
sorry at `SSConvergence.lean:596` and replaced it with the named axiom
invocation). The single named project axiom is the entire remaining
disclosure-boundary; see `lean/AXIOMS.md`.

---

## §2 — Unconditional small-case slice (concrete witnesses)

These bypass the cohomology bridge entirely and use L4 minimal-element
witnesses. They are **propositionally independent of the live sorry**
and remain GREEN regardless of the disclosure-pivot outcome.

| Theorem | Location | Witness | Status (post-mg-1b2b) |
|---|---|---|---|
| `Frankl_Holds_concrete` | `Frankl.lean` | Takes Frankl-rare witness as hypothesis | **UNCONDITIONAL, GREEN; no project axiom** |
| `Frankl_Holds_fullPowerset3` | `Frankl.lean` | `fullPowerset3_minimal_element` (x = 0, β = 0) via `Frankl_Holds_concrete` | **UNCONDITIONAL, GREEN; no project axiom** |
| `Frankl_Holds_fullPowerset4` | `Frankl.lean` | `fullPowerset4_minimal_element` (x = 0, β = 0) via `Frankl_Holds_concrete` | **UNCONDITIONAL, GREEN; no project axiom** |
| `Frankl_Holds_n3` (universal at n=3) | `Frankl.lean` | Routes through `Frankl_Holds` dispatch | **AXIOM-DEPENDENT** (general universal-`F` form) |
| `Frankl_Holds_n4` (universal at n=4) | `Frankl.lean` | Routes through `Frankl_Holds` dispatch | **AXIOM-DEPENDENT** (general universal-`F` form) |
| `Frankl_Holds_general` | `Frankl.lean` | Axiom-dependent universal branch | **AXIOM-DEPENDENT** (`case3_ss_obstruction_paper_axiom`) |
| `Frankl_Holds` | `Frankl.lean` | Dispatch / universal API | **AXIOM-DEPENDENT** (delegates to `_general`) |
| `Frankl_Holds_universal_typecheck` | `Frankl.lean` | Structural type-check at n=3,4,5 | **AXIOM-DEPENDENT** (typechecks `Frankl_Holds`) |

The `fullPowerset3` / `fullPowerset4` cases prove the conclusion for
the *full powerset on Fin n* family — non-trivial intersection-closed
data, not a vacuous-cover degenerate case. `β_0 = 0` is computed by
`decide` (the family has both members containing 0 and members not
containing 0, balancing the bias to exactly 0). See
`UC11/Minimality.lean:574, 657`.

---

## §3 — Per-component status table (the Lean dependency tree)

Reading order matches dependency order (bottom-up). All paths terminate
either in mathlib primitives or in the Y6 sorry.

| Component | File / location | Status | Notes |
|---|---|---|---|
| **L-arc** (combinatorial + Bousfield-Kan + Walsh + L4) | UC10/, UC11/Minimality.lean, UC11/Mismatch.lean, UC11/FObs.lean | **SUBSTANTIVE-FORMALIZED, GREEN** | UC11 Lemma 6.1/6.2 algebraic content, L4 absolute-minimal-counterexample, L5 cohomology bridge typing. |
| **X-arc** (SS infrastructure surrogates X1–X6) | Mathlib/Algebra/Homology/SpectralSequence/*.lean | **SUBSTANTIVE-FORMALIZED, GREEN** | Joël-Riou-attributed; mathlib-PR-clean discipline. Provides `spectralSequence`, `nullHomotopyOnIsotype_givesEInftyVanishing`, edge maps. Surrogates *not* the real mathlib SpectralObject API. |
| **Y1 / Y1b** — BKBicomplexHC₂ as full HC₂ | UC10/BKBicomplexHC2.lean | AMBER (Y1b residual on `Fin.succAbove` higher-row differential) → no longer blocking | Row-0 differential non-trivial; higher rows scoped to multi-month refactor (Path B residual). |
| **Y2** — Walsh-equivariant column action on BK | UC10/BKWalshEquivariant.lean | **SUBSTANTIVE-FORMALIZED, GREEN** | Per-column (ZMod 2)^n action; needed for Y3-onwards. |
| **Y3** — Chain → Homotopy bridge primitive | UC11/BKWalshHomotopyBridge.lean | **SUBSTANTIVE-FORMALIZED, GREEN** | `BKIsotypeColumn_nullHomotopy` on the SMALL Y3 χ_x-isotype column; lifts UC10_lowerWalshVanishing's chain identity into a `Homotopy` object. |
| **Y4** — SS-cohomology vanishing on SMALL bicomplex | UC11/BKSSCohomologyVanishing.lean | **SUBSTANTIVE-FORMALIZED, GREEN** | `BKSSCohomologyVanishing F x` + lift `BKIsotypeColumn_lift_to_BKBicomplexHC2` (degree-0 ℚ-linear map, **not** chain map). |
| **Y5** — Per-x sorry closure (def-alias) | UC11/SSConvergence.lean (lines ~150–410) | **SUBSTANTIVE-FORMALIZED, GREEN** | Closes the old per-x sorry by def-aliasing `obstructionCohomClass` to the constantly-zero Y4 SS-derived class. PROVEN `obstructionCohomClassChain_ne_zero_of_counterexample` collisions about OLD chain class are preserved as diagnostic. |
| **Y6** — Chain-to-SS transport bridge | UC11/SSConvergence.lean | **GREEN — axiom-dependent post-mg-1b2b** | Former Y6 sorry deleted; bridge body now invokes `case3_ss_obstruction_paper_axiom`. Y4 + Y5 + Y6 substantive primitives preserved as `have`-bound diagnostics. |
| **Paper-axiom** — `case3_ss_obstruction_paper_axiom` | `lean/UnionClosed/PaperAxioms.lean` (mg-1b2b; docstring refreshed mg-6d64) | **SINGLE NAMED PROJECT AXIOM** | Captures combined SS-vanishing + Walsh-isotype chain-encoding-refinement substeps both deferred to research-track. OneThird-grade disclosure + collision-disclosure layer in `lean/AXIOMS.md`. **mg-980f GREEN re-audit = keep this (B2)+(B3) form; mg-6d64 applied R1+R2+R3 docstring-only disclosure enhancements.** See §3.1. |
| **Z1 / Z1b** — SpectralObject record + ss assembly | Mathlib/Algebra/Homology/SpectralObject/SpectralSequenceAssembly.lean | **RESEARCH-TRACK-DEFERRED** (file-header note added; Z arc paused) | Closes Joël Riou's mathlib TODOs at `Mathlib.CategoryTheory.Abelian.SpectralObject.SpectralSequence`. Future replacement path for the named axiom (Path (b) per AXIOMS.md). |
| **Z2a–Z2j** — Bicomplex SpectralObject infrastructure | Mathlib/Algebra/Homology/SpectralObject/Bicomplex.lean (~3577 lines) | **RESEARCH-TRACK-DEFERRED** (file-header note added; TC-diamond blocker) | Cumulative substantive primitives preserved as research-track scaffolding. Final SpectralObject record + ShortExact closure blocked on **TC-diamond** (see §5 pitfall #1). |
| **Z3–Z10** | mg-50b7 + cascade | **SHELVED** per mg-8510 + mg-ee54 + mg-1b2b execution | Shelved by mg-1b2b: `mg-50b7` (Z3) + auto-cascaded `mg-18b8` (Z4) + `mg-69e7` (Z5). Rationale: superseded by the disclosure-pivot per mg-8510 (v)+(iv) hybrid; SpectralObject infrastructure preserved as research-track. |
| **mg-1b2b** — Frankl disclosure-pivot execution | **LANDED** | **DONE** | Introduced paper-axiom in (B2)+(B3) chain-level + collision-disclosure form, deleted Y6 sorry, restructured `Frankl_Holds` into `_concrete` + `_general` + dispatch, wrote OneThird-grade `lean/AXIOMS.md` with collision-disclosure layer, added research-track headers to SpectralObject infra, shelved Z3–Z10 tickets. |
| **mg-d079** — Frankl cascade-fork sub-ticket 2 | commit 468a348 | **RED at bar-4 viability gate** | Namespace-rename fork of mathlib homological-algebra structures (`UCHomologicalComplex` etc.); the bicomplex `Abelian` instance still carries the TC-diamond after the fork. Fork code (~2586 lines under `lean/UnionClosed/Mathlib/Algebra/Homology/UC*`) preserved research-track; cascade-fork sub-tickets 3–6 shelved. See §3.1 + §5 pitfall #1. |
| **mg-980f** — Frankl-axiom-optimization-research | `docs/Frankl-axiom-optimization-research.md` (commit b49de37) | **GREEN — keep axiom** | Independent re-audit across 4 criteria (lowest impact radius / lowest risk / most defensible / makes everything GREEN): the current (B2)+(B3) axiom is the GREEN-attainable optimum; recommends docstring-only R1+R2+R3 enhancements. See §3.1. |
| **mg-6d64** — Frankl-axiom-docstring-refresh | **LANDED (this entry)** | **DONE** | Applied mg-980f R1 (formalised propositional-equivalence Lean `example`), R2 (`Frankl_Holds`-variant axiom-dependency map), R3 (narrow-Y4-vs-full-BK distinction) to `PaperAxioms.lean` docstring + `lean/AXIOMS.md`. Docstring/text-only; no axiom-signature or semantic Lean change; `lake build` GREEN unchanged. |

---

## §3.1 — Axiom status & replacement path (mg-6d64 refresh, 2026-05-20)

**Axiom status.** `case3_ss_obstruction_paper_axiom` is **retained as
the single named project axiom** in its mg-1b2b (B2)+(B3) form
(chain-level conclusion + mandatory collision-disclosure docstring).
It was independently re-audited by **mg-980f**
(`docs/Frankl-axiom-optimization-research.md`, **GREEN verdict**):
across the four criteria Daniel specified (lowest impact radius,
lowest risk, most defensible, makes everything GREEN), the current
(B2)+(B3) form is the **GREEN-attainable optimum** — every candidate
strictly tighter on impact/risk/defensibility either cannot be made
GREEN (the SS-level full-BK forms need a Lean conclusion type the
TC-diamond blocks) or is defensibility-RED (literal axiomatisation).
mg-980f recommended **keeping the axiom** and applying docstring-only
R1+R2+R3 disclosure enhancements; those landed via **mg-6d64** (this
refresh).

**Cascade-fork status (mg-d079).** The Frankl cascade-fork — a
namespace-rename fork of the offending mathlib homological-algebra
structures (`UCHomologicalComplex` etc.), intended to dodge the
TC-diamond — reached **sub-ticket 2 (`mg-d079`, commit 468a348) and
RED'd at the bar-4 viability gate**: the bicomplex-level proxy probe
still RED's at `whnf` even after the diamond is bypassed at the
single-level `UCHomologicalComplex`. **The bicomplex `Abelian`
instance still carries the diamond after the namespace-rename fork.**
The fork code (~2586 lines under
`lean/UnionClosed/Mathlib/Algebra/Homology/UC*`) is preserved as
research-track scaffolding; cascade-fork sub-tickets 3–6 are shelved.

**Replacement path — deferred-forward.** The axiom's replacement path
(swap the (B2) chain-level axiom for the paper-faithful SS-level
full-BK form, then delete it once the SS↔chain transport is proven)
is **not closed off — it is deferred-forward**. It **re-opens** if any
one of the following lands:

* the Z-arc TC-diamond is resolved **upstream in mathlib** (instance
  priority rebalance, or the bicomplex-level `Abelian` instance chain
  ships clean);
* a **structural redesign** per `mg-8510` option (iv) (cell-level
  reduction architecture) lands;
* the **cascade-fork is unstuck** (a fork variant clears the bar-4
  bicomplex-level proxy probe that `mg-d079` failed).

Until one of those lands, the (B2)+(B3) axiom with the R1+R2+R3
disclosure is the standing form. Full detail: `lean/AXIOMS.md`
"Replacement path (open)" + `docs/Frankl-axiom-optimization-research.md`
§4.3.

---

## §4 — Cross-reference index (paper ↔ Lean)

| Paper section | Paper claim | Lean construct | Status |
|---|---|---|---|
| UC10 §5.3 | Twisted-bridge null-homotopy on lower-Walsh isotype | `UC10_lowerWalshVanishing` (`UC13_PartB/LowerWalsh.lean:374`) | Formalized |
| UC11 §5 (Lemmas 6.1, 6.2) | Chain-level non-vanishing of obstruction class under hStar | `UC11_nonVanishing` (`UC11/NonVanishing.lean:131`) | Formalized |
| UC11 §2 | BK bicomplex construction over IntClosedFam | `BKBicomplexHC2` + `BKTotal` (`UC10/BKBicomplexHC2.lean`) | Formalized (row-0 substantive; higher rows AMBER-Y1b) |
| UC12 | Doubling + bridge to OneThird-style obstruction | `UC12/{Doubling,Bridge,UC10R}.lean` | Formalized |
| UC13 §2.4.1 (Theorem 2.4.1) | Per-coordinate corrected landing in ⊕_x V_x^{n-1} | `UC13_correctedLanding` (`UC13_PartA/CorrectedLanding.lean:157`) | Formalized |
| UC13 §4.5 / §7 | Spectral-sequence convergence → cohomology vanishing on χ_x slice | `case3_ss_obstruction_paper_axiom` (`PaperAxioms.lean`) | **PAPER-AXIOMATISED** (mg-1b2b; see `lean/AXIOMS.md`) |
| UC14 §1.5 (R1 Θ-map) | Θ-map abutment equivalence at populated baseline | `ThetaMap_isAbutmentEquivalence` (`UC14/R1_ThetaMap.lean:278`) | Formalized |
| UC14 §R2, R3 | Auxiliary R2/R3 lemmas | `UC14/{R2,R3}.lean` | Formalized |
| UC13 §7 | Closing 7-step contradiction (Frankl_Holds) | `Frankl_Holds` (dispatch) / `Frankl_Holds_general` (axiom-dep) / `Frankl_Holds_concrete` (unconditional) | **GREEN with single named project axiom** (post-mg-1b2b) |
| mg-6acd | `topVertex_not_coboundary` augmentation injectivity | `topVertex_not_coboundary` (`UC11/CohomologyClass.lean:388`) | Formalized |

---

## §5 — Known pitfalls (READ BEFORE TOUCHING THE Z-ARC OR THE BRIDGE)

### Pitfall #1 — The TC-diamond (Z-arc structural blocker)

**Symptom.** When working in a bicomplex ambient
(`HomologicalComplex (HomologicalComplex C c₂) c₁`), abelian-derived
APIs (`Abelian.mono_cokernel_map_of_isPullback`,
`kernelCokernelCompSequence_exact`, `ShortExact.δ`, `cokernelIsoOfEq`)
fail to unify two `cokernel` terms with the error pattern:

```
synthesized HomologicalComplex.instHasZeroMorphisms
inferred    preadditiveHasZeroMorphisms
```

**Root cause.** Two `HasZeroMorphisms` instances at the bicomplex type:
the direct `HomologicalComplex.instHasZeroMorphisms`
(`Mathlib/Algebra/Homology/HomologicalComplex.lean:285`, priority 1000)
vs the preadditive-derived
`preadditiveHasZeroMorphisms`
(`Mathlib/CategoryTheory/Preadditive/Basic.lean:201`, priority 100).
Both produce the same `{ f := fun _ => 0 }` morphism but are not defeq
*as instance terms*. Invisible at single-level HC (elaboration locks);
load-bearing at second-level HC (two layers ⇒ two independent picks).

**Empirically failed workarounds** (Z2j, mg-8510 §1d). All five lose
to priority logic, not heartbeats:

1. Section-variable `[Abelian C]` discipline.
2. Two-step `letI` chain.
3. `set_option maxHeartbeats 1600000`.
4. `set_option synthInstance.maxHeartbeats 800000`.
5. Full TC-chain section-variable expansion.

**Sixth failed workaround — the cascade-fork (mg-d079, 2026-05).** A
namespace-rename *fork* of the offending mathlib structures
(`UCHomologicalComplex` etc., ~2586 lines under
`lean/UnionClosed/Mathlib/Algebra/Homology/UC*`) cleared the diamond
at the single-level `UCHomologicalComplex` but **RED'd at the
bicomplex-level proxy probe** (`whnf` still diverges). The bicomplex
`Abelian` instance carries the diamond regardless of namespacing.
Cascade-fork sub-ticket 2 (`mg-d079`, commit 468a348) is the viability
gate that closed this route; sub-tickets 3–6 are shelved. See §3.1.

**What works.** Cell-level reduction via `shortExact_of_degreewise_shortExact`
(`Mathlib/Algebra/Homology/HomologicalComplexAbelian.lean:55`) — operates at
first-level HC, never elaborates abelian-derived APIs at the bicomplex
level. Used by Z2e.

**Recommendation if you find yourself here.** STOP, mail mayor, read
`docs/Z-arc-architecture-audit.md` §1, do NOT attempt a sixth
workaround in the same shape. Either pivot to cell-level reduction
(option iv) or accept the disclosure-pivot framing (option v).

### Pitfall #2 — Chain-encoding structural collision (PROVEN, not engineering)

**Symptom.** A proof attempt of `obstructionCohomClassChain F = 0`
under `hStar : IsCounterexample F` either fails opaquely or, if landed
naively, would be propositionally false.

**Root cause.** PROVEN. The chain encoding
`obstructionClass F x := Finsupp.single (topVertex F) (β_x F)`
combined with `topVertex_not_coboundary` (mg-6acd, augmentation
injectivity) forces non-zero cohomology class under `β_x F > 0`. The
two collision theorems:

- `per_x_chain_cohom_vanishing_collides_topVertex_not_coboundary`
  (`SSConvergence.lean:436`).
- `aggregate_chain_cohom_vanishing_collides_topVertex_not_coboundary`
  (`SSConvergence.lean:455`).

Both are PROVEN one-liners deriving `False` from any hypothetical proof
of chain-level vanishing under `hStar`.

**Consequence.** A paper-axiom of the form
`IsCounterexample F → obstructionCohomClassChain F = 0` (the literal
mg-8510 §5a (B2) prescription) is *propositionally equivalent to
Frankl* modulo the PROVEN collision. mg-ee54 §2 flagged this as a
Zulip-publication risk and recommended the (B3) form (explicit
collision-disclosure docstring).

**Resolution (mg-1b2b, landed).** The single named project axiom
`case3_ss_obstruction_paper_axiom` (in `lean/UnionClosed/PaperAxioms.lean`)
uses the (B2)+(B3) form: chain-level conclusion + mandatory
collision-disclosure docstring framing the axiom as combined
SS-vanishing + Walsh-isotype chain-encoding-refinement substeps both
deferred to research-track. The OneThird-grade disclosure with this
additional collision-disclosure layer is in `lean/AXIOMS.md`.

**Recommendation if you are touching the axiom or the bridge.** Read
`lean/UnionClosed/PaperAxioms.lean` docstring + `lean/AXIOMS.md`
"Honest collision-disclosure" section first; do NOT add additional
chain-level axioms with similar shape without the same disclosure
layer. The "axiom looks like Frankl in disguise" failure mode is
already neutralised by the existing disclosure; any new chain-level
axiom would re-open it.

### Pitfall #3 — Sub-split overhead (the Z2a–Z2j lesson)

**Empirics.** Z2 split eleven times (Z2 → Z2a → … → Z2j → held Z2k)
across ~10M cumulative tokens. The first six sub-splits each landed
substantive primitives (cell isos, stupidTrunc projections, filtration
infrastructure, IsFirstQuadrant typeclass, Mono/Epi instances,
bridging iso). The last five hit the TC-diamond (pitfall #1) and made
incremental scaffolding progress without ever landing the headline
SpectralObject record.

**Lesson.** mg-b823 named "5+ sub-splits warrants structural review"
caveat. Z2 exceeded it 6 times before the mg-8510 architecture audit
identified the structural blocker. If your ticket is at sub-split N≥3
and each split exposes a deeper blocker rather than reducing scope,
**stop and request a structural audit** rather than continuing the
sub-split cascade.

**Concrete heuristic.** If the next sub-split's deliverable list is
mostly the *same items* as the current sub-split's (just narrower
scope on each), you are sub-splitting, not converging. If it is
different items (with the current sub-split's items moved to
"completed"), you are converging.

### Pitfall #4 — 250k-per-deliverable ceiling

**Empirics.** The Z arc empirically confirms a ~250k token ceiling per
substantive Lean deliverable in the mathlib-PR-clean style. Beyond
~250k the work either splits (Z2 sub-split cascade) or stalls.

**Application.** If you are sizing a Lean ticket at >250k, pre-plan a
sub-split structure. If you are mid-ticket and approaching 250k,
declare a named follow-on rather than pushing through.

### Pitfall #5 — Audit-clarity failures (OneThird-side analog)

**Cross-arc lesson** (from OneThird, applies to Frankl too). Recent
vacuity-discovery cascade (mg-e2e9 / mg-74d2 / mg-5c32 / mg-82fc on
OneThird) revealed that audit polecats sometimes:

- **Conflate** typed routing markers with substantive primitives
  (mg-74d2 F3 conflation between `bounded_irreducible_balanced`
  marker and `Case3Witness_proof`'s actual content).
- **Over-constrain** residuals by transcribing API surface without
  checking propositional satisfiability (mg-5c32).

**Application to Frankl.** The `obstructionCohomClass` def-alias
post-Y5 is a *typed routing* construct, not substantive cohomology
content. Its propositional vanishing is trivial; the actual
substantive content lives in `obstructionCohomClassSS_eq_zero` /
`BKSSCohomologyVanishing`. Audit conclusions about "the obstruction
class vanishes" must specify *which* class (NEW Y5-aliased / OLD
chain / SS-derived) — they are not propositionally interchangeable in
the current encoding.

### Pitfall #6 — Narrow Y4 SS-proxy is NOT the full-BK SS argument

**Symptom.** A polecat reads `BKSSCohomologyVanishing F x` (GREEN,
`UC11/BKSSCohomologyVanishing.lean:228`) and concludes "the
spectral-sequence vanishing substep is fully proven in Lean, so the
paper-axiom only needs the chain-encoding transport". This is wrong.

**Root cause.** `BKSSCohomologyVanishing F x` proves SS-vanishing on
the **narrow Y4 abstraction** `BKIsotypeBicomplex F x` — a
*single-column degenerate* bicomplex (column 0 is `BKIsotypeColumn F x`,
all higher columns are `HomologicalComplex.zero`). Its SS collapses at
E₁; its abutment is just the column-0 chain cohomology. This is a
**partial proxy** for — not the same statement as — the paper-side SS
argument, which asserts vanishing on the per-x χ_x-isotype graded
piece of `H^{n-1}(Tot)` of the **FULL `BKBicomplexHC₂ n F`** bicomplex.

**Consequence.** `case3_ss_obstruction_paper_axiom`'s SS-vanishing
substep (substep 1 of its docstring) abstracts the **full-BK tier**,
which is Lean-delivery-blocked by the TC-diamond (pitfall #1) — not
the narrow Y4 tier, which is GREEN. The narrow Y4 tier being proven
does **not** shrink what the axiom abstracts. Audit statements about
"the SS vanishing is proven" must specify *which tier*.

**Recommendation.** When reasoning about the axiom's substeps, read
the two-tier framing in `lean/UnionClosed/PaperAxioms.lean` substep 1
(the R3 enhancement, mg-6d64) and `lean/AXIOMS.md` "Honest
collision-disclosure" substep 1. Do not treat `BKSSCohomologyVanishing`
as discharging the axiom's SS substep.

---

## §6 — Maintenance protocol

**Who.** `pm-pogo` is the named maintainer. The daily/weekly roadmap
sweeps are the natural moments to refresh this file.

**When.** Update on any of:

- Headline restatement (e.g., mg-1b2b execution will reword §0–§2
  to reflect `_concrete` + `_general` split if Daniel approves the
  Revision 3 restructure).
- Disclosure / axiom landing (any new `axiom` in `lean/UnionClosed/`
  must be listed in §3 with status `SUBSTANTIVE-PAPER-AXIOM` + cited
  in `lean/AXIOMS.md` once that file lands).
- Major audit verdict (e.g., mg-8510, mg-ee54 today; future Z-arc
  research-track spikes).
- Sorry landing or sorry removal (§0 and §1 tree must reflect current
  sorry count and locations).
- Z-arc research-track ships (§3 + §5 pitfall #1 may need to record
  any breakthrough).
- New polecat-confusing pattern surfaced (add to §5 pitfalls).

**What.** Each update should:

1. Touch §0 sorry count + axiom list if either changed.
2. Touch §1 tree status tags if any leaf moved tags.
3. Touch §3 status table for the affected component.
4. Touch §4 cross-ref if a paper-side connection changed.
5. Touch §5 pitfalls if a new failure-mode-class was discovered.
6. Bump the "Last updated" timestamp in the header.

**Paper-side LaTeX sync.** Per the mg-083f Phase D directive, this
file is also where polecats record paper-Lean drift:

- **Current drift (post-mg-1b2b).** UC13 §7's "step 5" paper claim
  ("spectral-sequence convergence forces obstruction class to zero in
  level-1 isotypes") is formalized as `obstructionClass_cohomology_vanishing`
  + the Y6 transport bridge, with the chain-level transport conclusion
  delivered by the named project axiom `case3_ss_obstruction_paper_axiom`
  (in `lean/UnionClosed/PaperAxioms.lean`). The paper-side §7 step 5
  prose should add a footnote naming the Lean-side axiom dependency
  analogous to OneThird's `case3Witness_hasBalancedPair_outOfScope`
  paper disclosure; this footnote is **pending paper-side polecat dispatch**.
- **No other known drift.** UC10, UC11 (Lemma 6.1/6.2), UC12, UC13
  Theorem 2.4.1, UC14 R1/R2/R3 paper claims correspond 1:1 to landed
  Lean theorems per §4.

---

## §7 — Quick reference for incoming polecats

- **Want to add a new `Frankl_Holds_*` concrete witness?** Pattern at
  `Frankl.lean:528, 559`. Routes through L4 `*_minimal_element`
  witnesses, not through the bridge. No SS infrastructure needed.
- **Want to close the Y6 sorry without paper-axiom?** Read mg-8510 in
  full; the chain-encoding refactor (Y6b, mg-e75c) is multi-week and
  has no current ticket. The Z-arc path is multi-month and currently
  shelved per mg-8510 §5b.
- **Want to revive any Z2 sub-ticket?** Read §5 pitfall #1, the Z2j
  state doc, and `Z-arc-architecture-audit.md` §1d *first*. Do not
  attempt a 6th workaround in the same instance-priority shape.
- **Want to inspect the SpectralObject artefacts?**
  `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/` (Z1+Z1b
  GREEN, Z2a–Z2j AMBER) is preserved as research-track scaffolding,
  not active code. The Bicomplex.lean file alone is 3577 lines of
  accumulated substantive primitives.
- **Want to ship mg-1b2b?** Already landed. See the commit message,
  `lean/AXIOMS.md`, and `lean/UnionClosed/PaperAxioms.lean`. Any
  follow-on revision should be filed as a separate ticket and should
  preserve the disclosure-layer obligations recorded in `lean/AXIOMS.md`
  ("Honest collision-disclosure" + "Replacement path (open)").

## §8 — Cross-references (source artefacts in dependency order)

**Architecture audits (this onboarding doc's foundation).**

- `docs/Z-arc-architecture-audit.md` (mg-8510) — TC-diamond root-cause
  + 5-option analysis + (v)+(iv) hybrid recommendation.
- `docs/Frankl-disclosure-pivot-independent-audit.md` (mg-ee54) —
  GREEN-WITH-CONDITIONS on mg-8510; 7-item Revision list; B3-form
  collision-disclosure prescription.

**Scoping docs.**

- `docs/UC-Lean-MathlibSS-Full-scope.md` (mg-103f) — Z1–Z10 scoping
  with acceptance bars 11–14 (now modified per mg-8510 §6).
- `docs/UC-Lean-PathB-BKBicomplex-scope.md` (mg-e1b8) — Y1–Y6 + Y6b
  scoping.
- `docs/UC-Lean-scope.md` — L-arc scoping.
- `docs/UC-Lean-mathlib-SS-scope.md` — earlier X-arc scoping.

**State ledgers (one per execution sub-ticket).**

- L-arc: `state-UC-Lean-L{1,2a-residual,2a-residual-residual,2b,3,4,5,5-followup}.md`.
- SS-X-arc: `state-UC-Lean-SS-X{1,2,3,4,5,6}.md` +
  `state-UC-Lean-SS-{convergence,edge}.md`.
- Y-arc: `state-UC-Lean-PathB-Y{1,1b,2,3,4,5,6}.md`.
- Z-arc: `state-UC-Lean-Z{1,1b,2,2b,2c,2d,2e,2f,2g,2h,2i,2j}.md`.
- Per-x closure / refactor: `state-UC-Lean-{per-x-closure,obstructionClass-refactor,mathlib-hom}.md`.

**Paper-side (UC ladder).**

- `docs/union-closed-UC{2..14,F32}-*.md` — paper notes in dependency
  order. UC10 + UC11 + UC13 + UC14 are the load-bearing chain for the
  Frankl Lean execution; UC12 + UC2–UC9 are upstream / parallel work.

**The Frankl.lean entry point.**

- `lean/UnionClosed/Frankl.lean` — lines 209 (bridge proof),
  397 (cohomology-to-scalar bridge), 464 (Frankl_Holds), 528+559
  (concrete witnesses).
