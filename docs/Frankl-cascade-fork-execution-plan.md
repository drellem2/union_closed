# Frankl cascade-fork execution plan — per-session sub-ticket decomposition (mg-ea01)

**Author.** `cat-mg-ea01` (SENIOR math-paper-grade scoping polecat,
~600k single-session budget).

**Trigger.** Daniel 2026-05-19T07:13Z verbatim:
> "Frankl I still want more forking."

This explicitly endorses **Option B (cascade fork)** from the mg-7e53
RED verdict (see `docs/state-Frankl-mathlib-bypass-replay-Session1.md`
§"Recommendation to Daniel" Option B). The simpler bypass approaches
(mg-8dce 3-tweaks, mg-7e53 4-Approach-1-variants, single-file fork
**structurally impossible** under Lean 4's nominal type system) are
EXHAUSTED. **Cascade fork** — copy + namespace-rename mathlib's
`HomologicalComplex` + `Additive` + `HomologicalComplexAbelian` +
`HomologicalComplexLimits` + `HomologicalBicomplex` + `TotalComplex` +
`Embedding/*` + the `ShortComplex/HomologicalComplex` cell-level
plumbing + `CategoryTheory/Abelian/CommSq` + the
`DiagramLemmas/KernelCokernelComp` Z2h-imported helper into a
`UCHomologicalComplex` namespace, **REMOVE the offending
`HomologicalComplex.instHasZeroMorphisms` at HC.lean line 285**, then
re-derive Z2a-Z2j against the bypassed bicomplex — is the only
remaining bypass path.

**Predecessors absorbed.**

* `mg-7e53` (`docs/state-Frankl-mathlib-bypass-replay-Session1.md`)
  — RED verdict on simpler-approaches replay; Phase B
  structural-impossibility finding; Phase C cascade-fork roadmap
  sketch; DiamondTest.lean test scaffold.
* `mg-8dce` (`docs/state-Frankl-mathlib-copy-and-tweak-Session1.md`)
  — RED verdict on 3 priority/instance-pin/canonical-instance
  tweaks; mg-8dce diagnostic ("TC picks wrong path due to instance
  priority").
* `mg-8510` (`docs/Z-arc-architecture-audit.md`) — Z-arc architecture
  audit with full TC-diamond root cause + 5-option analysis +
  (v)+(iv) hybrid disclosure-pivot recommendation.
* `mg-ee54` (`docs/Frankl-disclosure-pivot-independent-audit.md`) —
  GREEN-WITH-CONDITIONS audit verdict gating mg-1b2b disclosure-pivot.
* `mg-1b2b` (paper-axiom `case3_ss_obstruction_paper_axiom` landed;
  `lean/UnionClosed/PaperAxioms.lean` + `lean/AXIOMS.md` +
  `Frankl_Holds` restructured into `_concrete` + `_general` +
  dispatch).
* `mg-103f` (`docs/UC-Lean-MathlibSS-Full-scope.md`) — Z1-Z10 scoping.
* `mg-083f` (`docs/PROOF-STRUCTURE-ONBOARDING.md`) — canonical proof
  tree, READ FIRST for incoming polecats.

---

## §0 — Top-line verdict (this scoping)

**Cascade fork is tractable, multi-session, AI-native-cadence
appropriate.** The 6 sub-tickets below decompose the
~7000-8000-line port + ~3609-line Z2a-Z2j re-derivation + ~3-5M-token
Z3-Z10 + Walsh-isotype refactor into work units each ≤2.5M tokens
with **explicit go/no-go gates** between them.

**Cumulative budget projection:** **8.1M–11.7M tokens** across 6
sequential sub-tickets, with sub-split contingency pre-authorised on
Sub-tickets 4/5/6. **Worst case (3× sub-split factor on high-risk
tickets):** 15M-20M tokens across 10-15 sessions.

This matches the mg-7e53 §"Phase C" "Honest project-life estimate":
"~10-20M tokens across 10-20 sessions for the mathlib fork + Z2a-Z2j
re-derivation + Z3-Z10 + Walsh-isotype refactor". The
**lower-end** of that range is the realistic baseline; the **upper
end** is the worst case if Sub-tickets 4/5/6 each spawn 2-3
sub-splits.

**Phase-gate decision points (the critical four):**

1. **After Sub-ticket 1.** Does `UCHomologicalComplex` with the
   direct `instHasZeroMorphisms` REMOVED build GREEN at single-level
   ambient with a unique `HasZeroMorphisms (UCHC V c)` instance
   (preadditive path only)? If yes → dispatch Sub-ticket 2. If no →
   the fork has a deeper Lean-4-module-system or
   `[Preadditive V]` ambient TC issue; **escalate to Daniel** before
   dispatching anything further.

2. **After Sub-ticket 2 (THE CASCADE-FORK VIABILITY GATE).** Does
   `DiamondTest.lean`'s commented-out **Z2j-failed primitive**
   (`Abelian.mono_cokernel_map_of_isPullback` at UCHC₂ ambient,
   uncommented for this gate) build GREEN under the forked UCHC₂
   `Abelian` instance? **This is the SINGLE most important
   acceptance bar in the entire cascade-fork plan.** If yes → the
   cascade-fork conjecture is **empirically validated** and
   Sub-tickets 3-6 are tractable in their stated scope. If no → the
   cascade-fork conjecture is **REFUTED** and **escalate to Daniel
   immediately**; fallback path is Option D cell-level Z2k workaround
   (per mg-8510 §2d) or Option C upstream mathlib PR (per mg-8510
   §2a).

3. **After Sub-ticket 4 (Z2j AMBER → GREEN).** Does the
   substantive Z2j primitive
   (`spectralObjectSlice_tripleShortComplex_shortExact`) build GREEN
   non-vacuously under the forked UCHC₂ ambient? This is the
   downstream-substantive validation of the Sub-ticket 2 gate. If
   yes → dispatch Sub-ticket 5. If no → diagnose which Z2 primitive
   is the new blocker; possibly the cascade fork has an
   incompletely-bypassed secondary diamond.

4. **After Sub-ticket 6.** Does `#print axioms Frankl_Holds` cleanly
   drop `case3_ss_obstruction_paper_axiom` (showing only the
   mathlib trio)? If yes → **PROJECT-LIFE MILESTONE: Frankl
   formalised unconditionally.** If no → diagnose which substantive
   primitive routes back through an axiom dependency; possibly Y1b
   residual or chain-encoding-refinement substep needs additional
   sub-tickets.

---

## §1 — File inventory + verification against mathlib v4.29.1

**Mathlib pinned at `v4.29.1`** per
`lean/lake-manifest.json` rev `5e932f97dd25535344f80f9dd8da3aab83df0fe6`,
inputRev `v4.29.1`. Verified by `wc -l` against the local mathlib
cache at
`/Users/daniel/.pogo/polecats/pc-ba0c/lean/.lake/packages/mathlib/`.

### 1a. Cascade-fork target files (with current line counts)

| Mathlib v4.29.1 file | Lines | Key load-bearing content | Sub-ticket |
|---|---:|---|---|
| `Mathlib/Algebra/Homology/HomologicalComplex.lean` | 1065 | line 285: `instance : HasZeroMorphisms (HomologicalComplex V c) where` (DELETE in fork) | 1 |
| `Mathlib/Algebra/Homology/Additive.lean` | 287 | line 86: `instance : Preadditive (HomologicalComplex V c) where` (the load-bearing TC path UCHC uses) | 1 |
| `Mathlib/Algebra/Homology/HomologicalComplexLimits.lean` | 231 | limits + cokernel/kernel constructions on HC | 1 |
| **Sub-ticket 1 subtotal** | **1583** | | |
| `Mathlib/Algebra/Homology/HomologicalComplexAbelian.lean` | 102 | line 44: `noncomputable instance : Abelian (HomologicalComplex C c) where`; `shortExact_of_degreewise_shortExact` (cell-level reduction lemma) | 2 |
| `Mathlib/Algebra/Homology/HomologicalBicomplex.lean` | 215 | `abbrev HomologicalComplex₂ := HC (HC V c₂) c₁` (the bicomplex abbreviation) | 2 |
| `Mathlib/Algebra/Homology/TotalComplex.lean` | 472 | `total : HC₂ ⥤ HC` (totalisation functor used by Y1+Y1b) | 2 |
| **Sub-ticket 2 subtotal** | **789** | | |
| `Mathlib/Algebra/Homology/Embedding/Basic.lean` | 274 | `ComplexShape.Embedding` foundational type | 3 |
| `Mathlib/Algebra/Homology/Embedding/Restriction.lean` | 93 | restriction operation along an embedding | 3 |
| `Mathlib/Algebra/Homology/Embedding/Extend.lean` | 370 | extension operation along an embedding | 3 |
| `Mathlib/Algebra/Homology/Embedding/TruncGE.lean` | 438 | `IsTruncGE` typeclass + GE-side stupidTrunc | 3 |
| `Mathlib/Algebra/Homology/Embedding/TruncLE.lean` | 248 | `IsTruncLE` typeclass + LE-side stupidTrunc | 3 |
| `Mathlib/Algebra/Homology/Embedding/StupidTrunc.lean` | 114 | `stupidTrunc` functor + the Joël-Riou TODO closed by Z2b/Z2c | 3 |
| `Mathlib/Algebra/Homology/ShortComplex/HomologicalComplex.lean` | 906 | cell-level ShortComplex plumbing on HC₂ | 3 |
| `Mathlib/Algebra/Homology/ShortComplex/ShortExact.lean` | 223 | `ShortExact` propositional bundling | 3 |
| `Mathlib/CategoryTheory/Abelian/CommSq.lean` | 165 | `Abelian.mono_cokernel_map_of_isPullback` (the Z2j-failed primitive's use site) | 3 |
| `Mathlib/CategoryTheory/Abelian/DiagramLemmas/KernelCokernelComp.lean` | 218 | `kernelCokernelCompSequence_exact` (imported by Z2h) | 3 |
| **Sub-ticket 3 subtotal** | **3049** | | |
| **Mathlib-side cumulative (Sub-tickets 1-3)** | **5421** | | |
| `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/Bicomplex.lean` | 3609 | Z2a-Z2j cumulative substantive content (port-in-place to UCHC₂) | 4 |
| **Sub-ticket 4 subtotal** | **3609** | | |
| `Mathlib/Algebra/Homology/SpectralObject/Basic.lean` + `SpectralSequence.lean` + `Cycles.lean` + `Differentials.lean` + `EpiMono.lean` + `Page.lean` + `Homology.lean` + `HasSpectralSequence.lean` | 3105 | SpectralObject API (mostly diamond-independent; verify per-file) | 5 |
| `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/SpectralSequenceAssembly.lean` | 668 | Z1+Z1b GREEN deliverables to port to UC namespace | 5 |
| **Sub-ticket 5 subtotal (forked SS + Z3-Z5 + UCBKBicomplex bridge)** | **~3773 + Lean delivery** | | |
| (no new mathlib-side fork; consumer-side Walsh-isotype refactor + Z6-Z10 closure) | n/a | substantive Lean delivery; axiom replacement | 6 |
| **Sub-ticket 6 subtotal** | **n/a (Lean delivery)** | | |
| **Grand total: ~9000-12000 lines of mathlib code to fork + 3609 lines to port + Z3-Z10 substantive delivery** | | | |

### 1b. NOT in scope for fork (intentional)

The following mathlib code is **deliberately NOT forked** because it
either (a) lives in a generic preadditive/abelian ambient with no
`HomologicalComplex`-specific instance dependence, OR (b) is
diamond-independent in mathlib's own design:

| File / family | Why NOT forked |
|---|---|
| `Mathlib/CategoryTheory/Preadditive/Basic.lean` | The `preadditiveHasZeroMorphisms` instance lives here and is the path UCHC fork uses — keep mathlib-side. |
| `Mathlib/Algebra/Homology/ShortComplex/Basic.lean` (and `Exact`/`Homology`/`LeftHomology`/`RightHomology`/etc.) | Generic ShortComplex API over a preadditive cat; no HC-specific TC. |
| `Mathlib/Algebra/Homology/SpectralObject/{Basic,SpectralSequence,Page,Cycles,EpiMono,Differentials,Homology,HasSpectralSequence}.lean` (the **SpectralObject API itself**) | Defines `SpectralObject C ι` over generic abelian `C` with index type `ι`; no HC bicomplex dependence. **Verify per-file at Sub-ticket 5 dispatch time.** |
| `Mathlib/Algebra/Homology/SpectralSequence/{Basic,ComplexShape}.lean` | Generic SS data structure; not HC-specific. |
| `Mathlib/CategoryTheory/Abelian/Basic.lean` (and all other CategoryTheory/Abelian/* files except CommSq) | Generic abelian cat API; no HC TC. |
| `Mathlib/Algebra/Homology/HomologySequence.lean` (364 lines) | Long exact sequence machinery over a generic abelian ambient; no HC TC at the bicomplex level. |

If any of these prove to have a hidden HC-bicomplex-TC dependence at
Sub-ticket 3/4/5 dispatch time, surface immediately and adjust
file-list (sub-split contingency pre-authorised).

### 1c. Pre-conditions before Sub-ticket 1 dispatch

1. **Mathlib v4.29.1 pinned** (verified above).
2. **`DiamondTest.lean` builds GREEN** at baseline
   (`/Users/daniel/.pogo/polecats/ea01/lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/DiamondTest.lean`,
   90 lines; single-level diamond probe uncommented + builds; Z2j
   primitive commented-out + reference reproduced in comment).
3. **`Bicomplex.lean` state preserved** at 3609 lines (Z2a-Z2j
   cumulative). Sub-ticket 4 ports this file; Sub-tickets 1-3 must
   not modify it.
4. **`Frankl.lean` + `PaperAxioms.lean` + `AXIOMS.md` unchanged**
   from mg-1b2b. Sub-ticket 6 replaces the axiom; Sub-tickets 1-5
   must not modify these.
5. **`SpectralSequenceAssembly.lean` (Z1+Z1b) preserved** at 668
   lines. Sub-ticket 5 ports this to UC namespace.

---

## §2 — Sub-ticket 1: UCHC core scaffolding

**Title.** `UC-Lean-Frankl-CascadeFork-1-CoreScaffolding`

**Depends on.** mg-ea01 (this scoping ticket).

**Predecessor cross-references.** mg-7e53 §"Phase C" 9-step
enumeration (steps 1+2) + DiamondTest.lean single-level probe.

### 2a. Scope

Fork **three mathlib files** into `UnionClosed.Mathlib.Algebra.Homology`
namespace, **delete the offending direct `HasZeroMorphisms` instance**,
adapt to UCHC. The fork sits ALONGSIDE the original mathlib HC code;
no existing union_closed code is modified.

1. **`lean/UnionClosed/Mathlib/Algebra/Homology/UCHomologicalComplex.lean`**
   (NEW, ~1065 lines, namespace-renamed from
   `Mathlib/Algebra/Homology/HomologicalComplex.lean`).
   - Rename `HomologicalComplex` → `UCHomologicalComplex` throughout.
   - Rename `HomologicalComplex.Hom` → `UCHomologicalComplex.Hom`.
   - Rename `ChainComplex` / `CochainComplex` aliases → `UCChainComplex` / `UCCochainComplex`.
   - **DELETE** the `instance : HasZeroMorphisms (HomologicalComplex V c) where`
     declaration at line ~285. The fork's `UCHomologicalComplex` will get
     its `HasZeroMorphisms` ONLY via the preadditive path landed in
     `UCAdditive.lean` (next file).
   - **PRESERVE** the underlying `instance (X Y : HomologicalComplex V c) : Zero (X ⟶ Y)` at line ~278
     (provides the underlying zero morphism that the preadditive path's
     `inferInstance` field reads back).
   - **PRESERVE** the existing mathlib imports (`Mathlib.Algebra.Homology.ComplexShape`,
     `Mathlib.CategoryTheory.Subobject.Limits`, `Mathlib.CategoryTheory.GradedObject`,
     `Mathlib.Algebra.Homology.ShortComplex.Basic`). These are
     diamond-independent and used as-is.
   - Copy file-header `module` annotation + `@[expose] public section`
     verbatim.
   - File header should preserve Kim Morrison + Johan Commelin
     attribution per Lean 4 module-system convention + add Joël Riou
     attribution for any downstream API (none in HC.lean itself).

2. **`lean/UnionClosed/Mathlib/Algebra/Homology/UCAdditive.lean`**
   (NEW, ~287 lines, namespace-renamed from
   `Mathlib/Algebra/Homology/Additive.lean`).
   - Rename HC references → UCHC throughout (`HomologicalComplex` →
     `UCHomologicalComplex` etc.).
   - **KEY:** Preserves the `instance : Preadditive (UCHomologicalComplex V c) where`
     at line ~86 of the original file. This is the load-bearing
     instance: after Sub-ticket 1, the only path for
     `HasZeroMorphisms (UCHC V c)` is via this preadditive instance
     composed with `preadditiveHasZeroMorphisms` (mathlib-side).
   - Imports `UnionClosed.Mathlib.Algebra.Homology.UCHomologicalComplex` (the just-forked file).

3. **`lean/UnionClosed/Mathlib/Algebra/Homology/UCHomologicalComplexLimits.lean`**
   (NEW, ~231 lines, namespace-renamed from
   `Mathlib/Algebra/Homology/HomologicalComplexLimits.lean`).
   - Rename HC references → UCHC.
   - Imports `UCHomologicalComplex` + `UCAdditive`.
   - Provides limits/cokernels on UCHC inheriting from `V`.

4. **`lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/UCDiamondTest.lean`**
   (NEW, ~50 lines, a Sub-ticket-1-specific diamond probe in the new UC
   namespace).
   - Single-level `Mono (cokernel.map ...)` at `UCHC D c` ambient,
     using the `Abelian.mono_cokernel_map_of_isPullback` lemma from
     mathlib (mathlib-side `Abelian (UCHC D c)` is provided by the
     fork-internal preadditive path; mathlib's `Abelian.mono_cokernel_map_of_isPullback`
     is generic over abelian ambients and doesn't care which
     `HasZeroMorphisms` it gets, as long as TC is unambiguous).
   - **Acceptance:** builds GREEN; `#check (inferInstance : HasZeroMorphisms (UCHC D c))`
     reports `preadditiveHasZeroMorphisms` (verifiable via `#print`).

### 2b. Acceptance bars (Sub-ticket 1)

1. **`lake build` GREEN** for the four new files + existing tree
   (Bicomplex.lean / Frankl.lean / PaperAxioms.lean / Z arc /
   AXIOMS.md all unchanged).
2. **`UCHomologicalComplex` exists as a fork-namespaced inductive
   structure**, not a defeq alias for HC. Verified by `#check
   UnionClosed.Mathlib.Algebra.Homology.UCHomologicalComplex` showing
   a distinct type vs `Mathlib.Algebra.Homology.HomologicalComplex`.
3. **`HasZeroMorphisms (UCHC V c)` resolves uniquely** to
   `preadditiveHasZeroMorphisms` (via the UCAdditive
   `Preadditive (UCHC V c)` chain). Verifiable by:
   ```lean
   example {V : Type*} [Category V] [Preadditive V] {ι : Type*} {c : ComplexShape ι} :
       (inferInstance : HasZeroMorphisms (UCHomologicalComplex V c)) =
         CategoryTheory.Preadditive.preadditiveHasZeroMorphisms := rfl
   ```
   This must build GREEN. **No competing direct instance survives in
   the UCHC namespace** — confirmed by absence of grep hit for
   `instance : HasZeroMorphisms (UCHomologicalComplex` in the fork.
4. **`UCDiamondTest.lean` single-level probe builds GREEN.**
5. **NO existing union_closed file modified.** Verified by
   `git diff --stat` showing only the 4 new files + (optionally) one
   line in `lean/UnionClosed.lean` for the new module roots.

### 2c. Budget + sub-split contingency

- **Budget:** 1.0M-1.5M tokens. Mechanical work but
  module-system + namespace-rename verification needed.
- **Sub-split contingency:** Pre-authorise split into 1a (HC fork
  alone) + 1b (Additive + Limits + DiamondTest) if budget exceeds
  1.5M.

### 2d. Top-3 failure modes + mitigations

1. **`HasZeroMorphisms (UCHC V c)` TC search fails (Preadditive V
   not in scope when expected).** Mitigation: match mathlib's section
   variable pattern (`variable (V : Type u) [Category.{v} V] [HasZeroMorphisms V]`
   at line 47 of HC.lean) and switch to `[Preadditive V]` ambient
   where Additive.lean does. If both patterns are needed for
   different lemmas, surface as Sub-ticket 1 follow-on.
2. **Lean 4 module-system `@[expose] public section` import-graph
   issue** (e.g., the new `UCHomologicalComplex` module fails to
   re-expose its public section through the UC namespace
   re-export). Mitigation: copy mathlib's exact annotation pattern;
   verify file builds standalone before namespace-rename.
3. **Hidden cross-import circularity**: mathlib's HC.lean imports
   `Mathlib.Algebra.Homology.ShortComplex.Basic`, which transitively
   depends on `Mathlib.Algebra.Homology.HomologicalComplex` via a
   different file. Mitigation: ShortComplex.Basic is generic
   preadditive cat code, no HC reference; verify by `grep
   HomologicalComplex` in ShortComplex/Basic.lean before Sub-ticket 1
   dispatch. If a circularity exists, fork ShortComplex.Basic too
   (Sub-ticket 1 + ShortComplex.Basic fork — adjusts subtotal up by
   ~315 lines).

### 2e. Go/no-go gate to Sub-ticket 2

**GREEN:** all 5 acceptance bars met → dispatch Sub-ticket 2.

**AMBER:** bars 1-3 met but bar 4 RED (UCDiamondTest single-level
probe RED): a subtler Lean 4 elaboration issue exists; mail mayor for
diagnosis, do NOT dispatch Sub-ticket 2.

**RED:** bars 1-3 fail: the cascade fork has a fundamental
Lean-4-module-system / TC-prerequisite issue; **escalate to Daniel**
for option pivot (Option C upstream PR, Option D cell-level, or
Option A accept axiom permanently).

---

## §3 — Sub-ticket 2: UCHC instance ecosystem (Abelian + Bicomplex + Total)

**Title.** `UC-Lean-Frankl-CascadeFork-2-InstanceEcosystem`

**Depends on.** Sub-ticket 1 GREEN.

**Predecessor cross-references.** mg-7e53 §"Phase C" steps 3+5+6;
DiamondTest.lean's commented-out Z2j-failed bicomplex primitive
(uncommented in this sub-ticket's acceptance bar).

### 3a. Scope

Fork **three more mathlib files**, building the UCHC₂ bicomplex
abbreviation, the `Abelian (UCHC V c)` and `Abelian (UCHC₂ V c₁ c₂)`
instances, and the totalisation functor. The CRITICAL test: the
forked bicomplex Abelian must be diamond-free.

1. **`lean/UnionClosed/Mathlib/Algebra/Homology/UCHomologicalComplexAbelian.lean`**
   (NEW, ~102 lines, namespace-renamed).
   - Rename HC → UCHC throughout.
   - **KEY:** `noncomputable instance : Abelian (UCHomologicalComplex C c) where`
     at line ~44 of original. After Sub-ticket 1's deletion of the
     direct HasZeroMorphisms instance, this Abelian instance
     unambiguously routes through the preadditive path (no priority
     ambiguity).
   - Preserves `shortExact_of_degreewise_shortExact` (the
     cell-level reduction lemma used by Z2e + future Z arcs).
   - Imports `UCHomologicalComplex` + `UCAdditive` + `UCHomologicalComplexLimits`.

2. **`lean/UnionClosed/Mathlib/Algebra/Homology/UCHomologicalBicomplex.lean`**
   (NEW, ~215 lines, namespace-renamed).
   - Rename HC → UCHC, HC₂ → UCHC₂.
   - Defines `abbrev UCHomologicalComplex₂ V c₁ c₂ := UCHC (UCHC V c₂) c₁`.
   - **KEY:** Match mathlib's `abbrev` not `def` so TC inference flows
     naturally.
   - Provides `eval₁` / `eval₂` accessors.

3. **`lean/UnionClosed/Mathlib/Algebra/Homology/UCTotalComplex.lean`**
   (NEW, ~472 lines, namespace-renamed).
   - Rename HC → UCHC, HC₂ → UCHC₂.
   - Defines `UCHomologicalComplex₂.total : UCHC₂ V c₁ c₂ → UCHC V c₁₂`
     (the totalisation functor, used by Y1+Y1b BK bicomplex).
   - Imports `UCHomologicalBicomplex` + `UCHomologicalComplexAbelian`.

### 3b. Acceptance bars (Sub-ticket 2)

1. **`lake build` GREEN** for the three new files + Sub-ticket 1
   chain + existing tree unchanged.
2. **`Abelian (UCHomologicalComplex C c)` resolves uniquely** with
   single-path TC. Verifiable by:
   ```lean
   example {C : Type*} [Category C] [Preadditive C] [HasZeroObject C] [Abelian C]
       {ι : Type*} {c : ComplexShape ι} :
       (inferInstance : Abelian (UCHomologicalComplex C c)).toPreadditive =
       (UCHomologicalComplex.instPreadditive : Preadditive (UCHomologicalComplex C c)) := rfl
   ```
3. **`Abelian (UCHC (UCHC C c₂) (CS ℤ))` resolves uniquely** — the
   **critical bypass test** at the bicomplex level. The two-layer TC
   resolution lands on a single canonical instance because there is
   no competing direct instance at either layer.
4. **CRITICAL ACCEPTANCE BAR (the cascade-fork viability gate):**
   `DiamondTest.lean`'s commented-out **Z2j-failed primitive**,
   UNCOMMENTED at UCHC₂ ambient, builds GREEN:
   ```lean
   -- UCDiamondTest.lean updated for Sub-ticket 2
   variable {C : Type*} [Category C] [Preadditive C] [HasZeroObject C] [Abelian C]
     {I₂ : Type*} {c₂ : ComplexShape I₂}
     (K : UCHomologicalComplex₂ C (ComplexShape.up ℤ) c₂)
     {i j k : EInt} (h_ij : i ≤ j) (h_jk : j ≤ k)

   noncomputable example :
       Mono (cokernel.map (K.cutoffColumnsEInt_le h_jk)
         (K.cutoffColumnsEInt_le h_jk ≫ K.cutoffColumnsEInt_le h_ij)
         (𝟙 _) (K.cutoffColumnsEInt_le h_ij) (by simp)) := by
     haveI : Mono (K.cutoffColumnsEInt_le h_ij) := K.cutoffColumnsEInt_le_mono _
     exact Abelian.mono_cokernel_map_of_isPullback (isPullback_top_mono _ _)
   ```
   (Note: `cutoffColumnsEInt_le` doesn't exist yet at Sub-ticket 2 —
   it lands in Sub-ticket 4. A **simpler proxy probe** without
   `cutoffColumnsEInt_le` is the right Sub-ticket-2 form. See
   §3c below for the proxy.)
5. **`shortExact_of_degreewise_shortExact` at UCHC₂ ambient builds
   GREEN** via two-level dispatch.
6. **`#print axioms` on the new test examples** lists only the
   mathlib trio + project mathematical content (no new axioms
   introduced).

### 3c. Proxy probe for Sub-ticket 2 bypass test

Since `cutoffColumnsEInt_le` and related Z2d/Z2h Bicomplex.lean
primitives don't exist until Sub-ticket 4, the **right Sub-ticket-2
bypass probe** is a simpler bicomplex-level Mono test using only
Sub-ticket-2-available primitives:

```lean
-- UCDiamondTest.lean Sub-ticket 2 version
namespace UnionClosed.UCDiamondTest

open CategoryTheory Limits

variable {C : Type*} [Category C] [Preadditive C] [HasZeroObject C] [Abelian C]
  {I₁ I₂ : Type*} {c₁ : ComplexShape I₁} {c₂ : ComplexShape I₂}
  (K L M : UCHomologicalComplex₂ C c₁ c₂)
  (f : K ⟶ L) (g : L ⟶ M) [Mono g]

private lemma isPullback_top_mono {D : Type*} [Category D] {X Y Z : D}
    (f : X ⟶ Y) (g : Y ⟶ Z) [Mono g] :
    IsPullback f (𝟙 X) g (f ≫ g) where
  w := by simp
  isLimit' := ⟨PullbackCone.IsLimit.mk (by simp)
    (fun s => s.snd)
    (fun s => by rw [← cancel_mono g, Category.assoc]; exact s.condition.symm)
    (fun _ => Category.comp_id _)
    (fun _ _ _ hm₂ => by simpa using hm₂)⟩

/-- The cascade-fork viability gate: this builds GREEN ⇔ the
bicomplex-level abelian diamond is bypassed. If RED, the cascade
fork conjecture is REFUTED. -/
noncomputable example :
    Mono (cokernel.map f (f ≫ g) (𝟙 _) g (by simp)) := by
  exact Abelian.mono_cokernel_map_of_isPullback (isPullback_top_mono _ _)
```

This probe directly invokes `Abelian.mono_cokernel_map_of_isPullback`
(the use site of the diamond per mg-7e53 §"diagnosis") at the UCHC₂
ambient with only Sub-ticket-2-available primitives. If GREEN, the
cascade-fork bypass is empirically validated.

### 3d. Budget + sub-split contingency

- **Budget:** 0.8M-1.2M tokens. Smaller than Sub-ticket 1 because the
  files are smaller (789 lines vs 1583).
- **Sub-split contingency:** Pre-authorise split into 2a (Abelian +
  Bicomplex) + 2b (TotalComplex + extended DiamondTest) if budget
  exceeds 1.2M.

### 3e. Top-3 failure modes + mitigations

1. **Bicomplex Abelian still has diamond at UCHC₂ ambient.** This
   would mean the fork's two-layer UCHC₂ still spawns multiple
   `HasZeroMorphisms` candidates at the outer layer. Mitigation:
   verify in §3c probe; if RED, **STRUCTURAL FAILURE of cascade
   fork** — escalate to Daniel for Option C/D pivot. This is the
   single most important risk.
2. **`Abelian (UCHC C c)` priority conflict** between
   mathlib-side surviving instances (if any cross-import accidentally
   re-exports the original `HC.instHasZeroMorphisms` into UCHC scope)
   and UCHC fork's preadditive path. Mitigation: namespace separation
   + grep for stale references; the fork's `UCHomologicalComplex` is
   a DISTINCT type, so mathlib's HC instances cannot apply to UCHC
   even by accident.
3. **`shortExact_of_degreewise_shortExact` fails to type-check at
   UCHC₂ ambient** due to ShortComplex API mismatch. Mitigation:
   verify the underlying `ShortComplex (UCHC C c)` constructor works;
   if needed, scope a Sub-ticket 2 follow-on to also port relevant
   ShortComplex/HomologicalComplex.lean primitives.

### 3f. Go/no-go gate to Sub-ticket 3

**GREEN:** all 6 acceptance bars met, especially bar 4 (the
critical bypass test) → dispatch Sub-ticket 3.

**AMBER on bar 4 (cascade-fork viability gate RED):** the cascade
fork does NOT bypass the diamond as conjectured — **escalate to
Daniel immediately**. Fallback path: revisit mg-8510 options C/D.

**Other AMBER:** mail mayor for diagnosis before dispatching Sub-ticket 3.

---

## §4 — Sub-ticket 3: Embedding + ShortComplex cascade

**Title.** `UC-Lean-Frankl-CascadeFork-3-EmbeddingShortComplex`

**Depends on.** Sub-ticket 2 GREEN.

**Predecessor cross-references.** mg-7e53 §"Phase C" steps 7+8;
Z2b/Z2c stupidTrunc TODOs closure precedent.

### 4a. Scope

Fork the **Embedding cascade + ShortComplex cell-level plumbing + the
Abelian.CommSq lemma + the KernelCokernelComp diagram lemma** to
provide all consumer-facing APIs needed by Z2a-Z2j re-derivation.

**Embedding cascade (~1537 lines):**

1. **`UCEmbedding/Basic.lean`** (~274 lines) — `UnionClosed.Mathlib.Algebra.Homology.Embedding.Basic`,
   defines `UCComplexShape.Embedding` (or just keep mathlib-side
   `ComplexShape.Embedding` since it's index-only, not HC-specific
   — TBD per audit at sub-ticket dispatch).
2. **`UCEmbedding/Restriction.lean`** (~93 lines).
3. **`UCEmbedding/Extend.lean`** (~370 lines).
4. **`UCEmbedding/TruncGE.lean`** (~438 lines).
5. **`UCEmbedding/TruncLE.lean`** (~248 lines).
6. **`UCEmbedding/StupidTrunc.lean`** (~114 lines, with the Joël
   Riou TODO closed by mg-7e53/Z2b/Z2c).

**ShortComplex cell-level plumbing (~1129 lines):**

7. **`UCShortComplex/ShortExact.lean`** (~223 lines) — if needed
   beyond mathlib's generic version; depends on whether the fork's
   `ShortExact` predicate references UCHC TC.
8. **`UCShortComplex/HomologicalComplex.lean`** (~906 lines) — the
   cell-level ShortComplex API for HC₂; this DOES reference HC TC and
   needs fork.

**Abelian / DiagramLemma lemmas (~383 lines):**

9. **`UCCategoryTheory/Abelian/CommSq.lean`** (~165 lines) — defines
   `Abelian.mono_cokernel_map_of_isPullback` (the Z2j-failed primitive
   use site). MAY NOT NEED FORK if the mathlib version doesn't
   reference HC-specific TC at all (it's generic over `[Abelian D]`).
   **Verify at Sub-ticket 3 dispatch.**
10. **`UCCategoryTheory/Abelian/DiagramLemmas/KernelCokernelComp.lean`**
    (~218 lines) — `kernelCokernelCompSequence_exact`, imported by
    Z2h. Same verify-don't-need-fork question.

### 4b. Acceptance bars (Sub-ticket 3)

1. **`lake build` GREEN** for the new files + Sub-tickets 1-2 chain
   + existing tree.
2. **`stupidTrunc` over UCHC₁ builds GREEN** for at least one test
   evaluation matching Z2a's pattern.
3. **`Abelian.mono_cokernel_map_of_isPullback` at UCHC₂ ambient
   builds GREEN** in a NEW DiamondTest-style example involving an
   actual cokernel.map. (This is the
   bridge-test between Sub-ticket 2's proxy probe and Sub-ticket 4's
   substantive Z2j primitive.)
4. **`shortExact_of_degreewise_shortExact` at UCHC₂ ambient builds
   GREEN with two-level dispatch** in a test example.
5. **`kernelCokernelCompSequence_exact` at UCHC₂ ambient builds
   GREEN** in a test example.

### 4c. Budget + sub-split contingency

- **Budget:** 1.5M-2.0M tokens. Largest mechanical port; ~3049 lines.
- **Sub-split contingency:** Pre-authorise split into 3a (Embedding
  cascade) + 3b (ShortComplex/HomologicalComplex + CommSq +
  KernelCokernelComp) if budget exceeds 2.0M. The Embedding cascade
  alone is dense with TC-dependent stupidTrunc plumbing.

### 4d. Top-3 failure modes + mitigations

1. **Embedding cascade pulls in mathlib HC indirectly** via
   `Embedding/CochainComplex.lean` or `Embedding/AreComplementary.lean`
   (which are NOT planned for fork). Mitigation: at Sub-ticket 3
   dispatch, run `grep "HomologicalComplex" Embedding/*.lean` to
   surface all cross-references; only fork files that have
   HC-bicomplex-TC references; trust mathlib-side files for
   generic-preadditive code.
2. **`Abelian.mono_cokernel_map_of_isPullback` at UCHC₂ ambient
   still fails** even after fork. Two possible causes:
   - (a) The mathlib lemma's olean has a HasZeroMorphisms term baked
     in that doesn't unify against UCHC₂'s preadditive-only path.
   - (b) An intermediate API call in the lemma's proof unfolds to a
     HC-specific instance.
   Mitigation: if Sub-ticket 2's proxy probe at §3c built GREEN,
   Sub-ticket 3's substantive invocation should too (since the
   lemma's olean is independent of UCHC). If RED at Sub-ticket 3
   specifically, fork CommSq.lean explicitly (line 10 above).
3. **Embedding cascade sub-split exceeds 2.0M.** Pre-authorise sub-split
   per contingency above.

### 4e. Go/no-go gate to Sub-ticket 4

**GREEN:** all 5 bars met → dispatch Sub-ticket 4 (the big one).

**AMBER:** mail mayor; identify which embedding/ShortComplex
primitive is the new blocker; either patch in Sub-ticket 3 or
defer to Sub-ticket 4 if downstream-only.

**RED:** escalate to Daniel for fallback path.

---

## §5 — Sub-ticket 4: Re-derive Z2a-Z2j on bypassed bicomplex (THE BIG ONE)

**Title.** `UC-Lean-Frankl-CascadeFork-4-Z2aZ2jReDerivation`

**Depends on.** Sub-ticket 3 GREEN.

**Predecessor cross-references.** mg-3ff1 (Z2a) + mg-0611 (Z2b) +
mg-ce0c (Z2c) + mg-7b40 (Z2d) + mg-b823 (Z2e) + mg-165d (Z2f) +
mg-5e1a (Z2g) + mg-1543 (Z2h) + mg-0518 (Z2i) + mg-e0a0 (Z2j) — the
full Z2 lineage whose cumulative substantive content this sub-ticket
ports to UCHC₂.

### 5a. Scope

Port the ENTIRE `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/Bicomplex.lean`
(~3609 lines, 10-deliverable cumulative Z2a-Z2j content) to use
**`UCHC₂` instead of `HC₂`** at every primitive's signature.

**Two-step structure:**

**Step 1: Mechanical port (~80% of budget).**
- Copy `Bicomplex.lean` → `UCBicomplex.lean` in the same SpectralObject
  directory (or a new UCSpectralObject directory; TBD per
  Sub-ticket 4 dispatch decision).
- Replace all `HomologicalComplex` references with `UCHomologicalComplex`,
  `HomologicalComplex₂` with `UCHomologicalComplex₂`, etc.
- Replace mathlib import paths (`Mathlib.Algebra.Homology.HomologicalBicomplex`
  + `Mathlib.Algebra.Homology.TotalComplex`) with the forked paths
  (`UnionClosed.Mathlib.Algebra.Homology.UCHomologicalBicomplex` etc.).
- Update file-header attribution to preserve Joël Riou attribution +
  add cascade-fork polecat IDs.
- Confirm each Z2a-Z2j sub-deliverable lands non-vacuously
  post-port (each has a state-doc verifying substantive content; the
  port must preserve that without `False.elim` / sorry-axiom /
  fake mathlib API / defeq tricks).

**Step 2: Substantive Z2j closure (~20% of budget — THE CRUCIAL PART).**
- The Z2j primitive
  `spectralObjectSlice_tripleShortComplex_shortExact` is the
  AMBER-load-bearing deliverable that mg-e0a0 deferred due to the
  TC-diamond. Under the bypassed UCHC₂ ambient, this should now
  build GREEN substantively.
- Land `K.spectralObject_op : SpectralObject (UCHC (UCHC C c₂) (CS ℤ)) EInt^op`
  + `IsFirstQuadrant` instance.
- Verify with a non-vacuous totalised evaluation on
  `trivialColumnZeroFirstQuadrant` (the Z2d test bicomplex).
- All `#print axioms` on new substantive primitives list only
  mathlib trio.

### 5b. Acceptance bars (Sub-ticket 4)

1. **`lake build` GREEN** for UCBicomplex.lean + Sub-tickets 1-3
   chain + existing tree.
2. **All 10 Z2a-Z2j sub-deliverables port non-vacuously**, with
   each prior state-doc's substantive-content audit preserved.
3. **Z2j primitive
   `spectralObjectSlice_tripleShortComplex_shortExact` builds GREEN
   non-vacuously** at UCHC₂ ambient — the AMBER → GREEN status
   change.
4. **`SpectralObject (UCHC (UCHC C c₂) (CS ℤ)) EInt` record assembly
   GREEN** with non-vacuous totalised evaluation.
5. **`IsFirstQuadrant` instance GREEN** on
   `trivialColumnZeroFirstQuadrant`.
6. **Zero new sorrys/axioms/fake mathlib API/defeq tricks/False.elim
   in UCBicomplex.lean.** Verified by grep.
7. **`#print axioms` on substantive Z2j primitives lists only
   mathlib trio.**

### 5c. Budget + sub-split contingency

- **Budget:** 1.8M-2.5M tokens. **Largest substantive sub-ticket.**
- **Sub-split contingency: PRE-AUTHORISED.** The Z2 lineage itself
  split 10 times (Z2a-Z2j). Sub-ticket 4 may need to split into:
  - **4a (mechanical port of Z2a-Z2e: ~1500 lines cell-level + stupidTrunc + EInt filtration + ShortExact upgrade)** — ~1.0M tokens.
  - **4b (mechanical port of Z2f-Z2i: ~1500 lines ShortComplex packaging + cell-vanishing + Mono/Epi + bridging iso)** — ~1.0M tokens.
  - **4c (substantive Z2j primitive closure: SpectralObject record + IsFirstQuadrant + ShortExact closure)** — ~0.8M tokens, the load-bearing one.
- If budget exceeds 2.5M, split as above and file 4b + 4c as
  follow-on tickets depending on 4a.

### 5d. Top-3 failure modes + mitigations

1. **Z2 sub-split lineage repeats.** Mitigation: pre-authorised
   contingency (4a/4b/4c above). Don't push through.
2. **Z2j primitive RED at UCHC₂** — the cascade fork bypassed the
   single-level diamond but not the bicomplex-level Abelian. This
   would mean Sub-ticket 2's bar 4 was a false-positive (the proxy
   probe doesn't catch the same TC issue the Z2j primitive does).
   Mitigation: this would be a CRITICAL STRUCTURAL FINDING — the
   cascade fork has an incompletely-bypassed secondary diamond.
   Diagnose with `set_option diagnostics true` per mg-8dce/mg-7e53
   methodology; escalate to Daniel.
3. **Z2 substantive content cell-level proofs break under
   namespace-rename** because some cell-level lemma references a
   mathlib API that exists at HC₂ but not UCHC₂ (or vice versa).
   Mitigation: catch at Sub-ticket 4a; fork the missing API as part
   of Sub-ticket 4a scope, or surface to Daniel as a Sub-ticket 3
   completeness gap.

### 5e. Go/no-go gate to Sub-ticket 5

**GREEN:** all 7 bars met, especially bars 3+4 (Z2j AMBER → GREEN +
SpectralObject record assembled) → dispatch Sub-ticket 5.

**AMBER (some Z2 sub-deliverable failed but Z2j primitive
GREEN):** the Z arc has a localised pre-Z2j issue; mail mayor for
diagnosis, may dispatch Sub-ticket 5 in parallel if not blocking.

**RED on bar 3 (Z2j primitive RED at UCHC₂):** **structural finding** —
escalate to Daniel; fallback path is Option D cell-level rebuild OR
Option C upstream PR.

---

## §6 — Sub-ticket 5: Z3-Z5 substantive (BicomplexConvergence + Equivariant + EdgeMap)

**Title.** `UC-Lean-Frankl-CascadeFork-5-Z3Z4Z5Substantive`

**Depends on.** Sub-ticket 4 GREEN.

**Predecessor cross-references.** mg-103f (Z1-Z10 scoping) §"Z3-Z5";
mg-4165 (Z1 SpectralObjectAssembly GREEN); mg-a298 (Z1b EpiMono
GREEN); mg-50b7 (Z3 shelved), mg-18b8 (Z4 shelved), mg-69e7 (Z5
shelved); BKBicomplexHC2 + BKWalshEquivariant (Y1+Y2) state docs.

### 6a. Scope

With the bypassed UCHC₂ SpectralObject infrastructure from Sub-ticket
4, **land Z3-Z5 substantively** and **bridge the BKBicomplexHC2 (Y1)
content to the new UCHC₂ ambient via a `UCBKBicomplex` construction
that preserves Y2 equivariance**.

**Three deliverables:**

1. **Z3: BicomplexConvergence.** Port
   `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/SpectralSequenceAssembly.lean`
   (Z1+Z1b, ~668 lines) to UC namespace. Apply mathlib's
   `Abelian.SpectralObject.spectralSequence` API (in
   `Mathlib/Algebra/Homology/SpectralObject/SpectralSequence.lean` +
   `HasSpectralSequence.lean`) to the Sub-ticket-4-produced
   `SpectralObject (UCHC₂ ...) EInt` record. Conclude:
   `(K.spectralObject).spectralSequence converges, computing E_∞^{p,q} ≅ gr^p H^{p+q}(Tot K)`.
2. **Z4: EquivariantSpectralObject.** Bridge Y2 BKWalshEquivariant
   (`(ZMod 2)^n` action on `BKBicomplexHC2 F`) to the UCBKBicomplex
   built on UCHC₂. Define `UCBKBicomplex F : UCHC₂ (ModuleCat ℚ) (down ℕ) (down ℕ)`
   mirroring `BKBicomplexHC2 F` cell-by-cell. Prove `BKBicomplexHC2 F ≅ UCBKBicomplex F`
   as UC-side / mathlib-side iso. Transport Y2's `(ZMod 2)^n` action to UCBKBicomplex
   via the iso. Land `EquivariantSpectralObject UCBKBicomplex` with the action on each
   page.
3. **Z5: SpectralObjectEdgeMap.** Edge maps
   `EdgeMap : E_2^{p,q} → H^{p+q}(Tot K)` factoring through the
   abutment filtration. Compose with Y3 chain-Homotopy bridge to land
   the per-x slice abutment vanishing on `(UCBKBicomplex F).abutmentFiltration_gr x ((n-1)-x)`.

### 6b. Acceptance bars (Sub-ticket 5)

1. **`lake build` GREEN** for new files + Sub-tickets 1-4 chain + existing tree.
2. **Z3:** `(K.spectralObject).spectralSequence` for `K = UCBKBicomplex F`
   delivers convergence: `E_∞^{p,q} ≅ gr^p H^{p+q}(Tot K)`.
3. **Z4:** `(ZMod 2)^n` action on the SS pages with explicit
   transport from Y2 via the BKBicomplexHC2 ≅ UCBKBicomplex iso.
4. **Z5:** EdgeMap `E_2^{p,q} → H^{p+q}(Tot UCBKBicomplex)` substantively defined;
   per-x slice abutment vanishing established under hStar
   (linking Y3 null-homotopy data + Y4 SS-cohomology vanishing to
   `obstructionCohomClassSS_eq_zero` at UCHC₂ ambient).
5. **`#print axioms` on Z3/Z4/Z5 deliverables lists only mathlib trio.**

### 6c. Budget + sub-split contingency

- **Budget:** 1.5M-2.0M tokens.
- **Sub-split contingency: PRE-AUTHORISED.** Per mg-103f, each of
  Z3/Z4/Z5 is its own ticket scope. Sub-ticket 5 may split into:
  - **5a (Z3 BicomplexConvergence + SpectralSequenceAssembly port)** — ~0.6M tokens.
  - **5b (Z4 EquivariantSpectralObject + UCBKBicomplex bridge)** — ~0.6M tokens.
  - **5c (Z5 EdgeMap + per-x abutment vanishing)** — ~0.8M tokens.

### 6d. Top-3 failure modes + mitigations

1. **Z1+Z1b GREEN deliverables don't lift cleanly to UC namespace.**
   Mitigation: SpectralSequenceAssembly.lean (668 lines) is mostly
   index-level + filtration-level; should port mechanically.
   Surface any HC-specific issue at Sub-ticket 5 dispatch.
2. **BKBicomplexHC2 ≅ UCBKBicomplex iso is non-trivial to
   construct** because the cell-level data carries TC dependencies
   that don't trivially transport. Mitigation: define UCBKBicomplex
   from scratch in UCHC₂ ambient (~250-400k tokens additional),
   re-proving Y2 equivariance on UC side. Don't try to transport
   from BKBicomplexHC2 if the iso is opaque; mirror the construction
   instead.
3. **Z5 EdgeMap depends on mathlib SpectralObject API methods that
   aren't fully implemented in mathlib v4.29.1.** Mitigation: per
   mg-103f §"Z5 risks", certain edge maps require closing mathlib
   open TODOs; if hit, escalate as Sub-ticket 5 sub-split or as a
   research-track spike.

### 6e. Go/no-go gate to Sub-ticket 6

**GREEN:** all 5 bars met → dispatch Sub-ticket 6 (the closer).

**AMBER:** mail mayor; identify which Z deliverable failed; either
patch in Sub-ticket 5 sub-split or defer to Sub-ticket 6 if
downstream-only.

**RED:** escalate to Daniel.

---

## §7 — Sub-ticket 6: Z6-Z10 + Walsh-isotype refactor + paper-axiom removal

**Title.** `UC-Lean-Frankl-CascadeFork-6-AxiomRemoval`

**Depends on.** Sub-ticket 5 GREEN.

**Predecessor cross-references.** `lean/AXIOMS.md` Replacement Path
(a) Walsh-isotype chain refactor + (b) full mathlib SpectralObject
infrastructure; mg-1b2b (paper-axiom landing this sub-ticket
removes); mg-e75c (Y6 chain-map-extension blocker that the Walsh
refactor unblocks); UC10 §5.3 + UC13 §4.5 + §7 paper-side rigour;
PROVEN collision theorems
`obstructionCohomClassChain_ne_zero_of_counterexample`
(SSConvergence.lean:164) +
`per_x_chain_cohom_vanishing_collides_topVertex_not_coboundary`
(SSConvergence.lean:436) +
`aggregate_chain_cohom_vanishing_collides_topVertex_not_coboundary`
(SSConvergence.lean:455).

### 7a. Scope

**Land the substantive obstruction-class vanishing chain (Z6-Z10) +
discharge the Walsh-isotype refactor + REMOVE the paper-axiom from
`Frankl_Holds`.** This is the project-life milestone deliverable.

**Five deliverables (Z6-Z10):**

1. **Z6: SS-to-chain bridge.** From Sub-ticket 5's
   `obstructionCohomClassSS_eq_zero` (at UCHC₂ ambient), establish the
   chain-level reflection that the SS-side vanishing implies
   `obstructionCohomClassSS = 0` in the right-spot of the Walsh-isotype
   decomposition.
2. **Z7: Walsh-isotype direct-sum splitting on E_2 page.** The
   substantive content of the Walsh-isotype refactor on the BK
   bicomplex's chain encoding. Refactor `obstructionClass`'s chain
   encoding so the per-S (Z/2)^n-Walsh-isotype direct-sum is
   first-class: `(BKTotal n).X 0 ≅ ⊕_S V_S` (a structural
   isomorphism, not a definitional alias). Per `lean/AXIOMS.md`
   Replacement Path (a): "the χ_x-isotype piece IS zero in chain
   cohomology because the topVertex generator is in the
   χ_{[n]}-isotype, separate from χ_x^{n-1}".
3. **Z8: Chain-Homotopy bridge.** Connect Y3
   `BKIsotypeColumn_nullHomotopy` (already SUBSTANTIVE-FORMALIZED) to
   the Z7 direct-sum splitting, lifting the null-homotopy data
   through the Walsh-isotype identification.
4. **Z9: Obstruction class transport.** Chain-level
   `obstructionCohomClassChain F = 0` via the SS-derived vanishing
   (Z6) + Walsh-isotype refactor (Z7) + chain-Homotopy bridge (Z8).
   THIS IS THE THEOREM that closes the named axiom's chain-level conclusion.
5. **Z10: Frankl_Holds closure + axiom removal.**
   - **Replace `case3_ss_obstruction_paper_axiom` with a `theorem`**
     deriving its conclusion from Z9 + the existing L4/L5/Y3/Y4/Y5
     primitives.
   - **DELETE the `axiom` declaration** in
     `lean/UnionClosed/PaperAxioms.lean` (or convert to a `theorem`
     stub forwarding to the substantive proof, keeping the same name
     for backward compatibility with the bridge in
     `SSConvergence.lean`).
   - **Verify `#print axioms Frankl_Holds`** lists only the mathlib
     trio. The project axiom is GONE.
   - **Update `lean/AXIOMS.md`** to record the discharge:
     `case3_ss_obstruction_paper_axiom` REPLACED with substantive
     theorem via Z6-Z9 chain. The "Replacement Path (open)" section
     becomes "Replacement Path (CLOSED)" with the Sub-ticket-6
     work item ID and the substantive theorem location.
   - **Update `docs/PROOF-STRUCTURE-ONBOARDING.md`** §0+§1+§3
     status table to reflect Frankl_Holds_general as
     UNCONDITIONAL.

### 7b. Acceptance bars (Sub-ticket 6)

1. **`lake build` GREEN** for all new files + Sub-tickets 1-5 chain
   + the modified Frankl.lean + PaperAxioms.lean + AXIOMS.md +
   PROOF-STRUCTURE-ONBOARDING.md + SSConvergence.lean.
2. **`case3_ss_obstruction_paper_axiom` REPLACED with substantive
   `theorem`** (or DELETED with all call sites rerouted).
3. **`#print axioms Frankl_Holds`** shows only
   `[Classical.choice, propext, Quot.sound]` — no project axiom.
4. **`Frankl_Holds_general` no longer axiom-dependent.**
5. **`Frankl_Holds_concrete` + `Frankl_Holds_fullPowerset3` +
   `Frankl_Holds_fullPowerset4` build GREEN UNCHANGED** —
   these were always UNCONDITIONAL and remain so.
6. **Bridge body
   `obstructionCohomClassChain_eq_zero_via_y6_transport_residual`
   now contains substantive theorem invocations** (Z6-Z9 chain).
7. **`lean/AXIOMS.md` updated** to reflect axiom discharge.
8. **`docs/PROOF-STRUCTURE-ONBOARDING.md` updated** to reflect
   UNCONDITIONAL `Frankl_Holds_general` status.
9. **Zero new sorrys/axioms** in Z6-Z10 substantive content.
10. **PROVEN collision theorems
    (`obstructionCohomClassChain_ne_zero_of_counterexample` etc.) are
    REFINED** in light of Z7's Walsh-isotype refactor — the OLD chain
    encoding's collision is no longer load-bearing once the new
    encoding identifies the χ_x-isotype piece as zero. These older
    theorems may be DELETED, marked DEPRECATED, or KEPT as historic
    record per Sub-ticket 6 dispatch decision.

### 7c. Budget + sub-split contingency

- **Budget:** 1.5M-2.5M tokens.
- **Sub-split contingency: STRONGLY PRE-AUTHORISED.** Z6-Z10 is a
  5-deliverable chain. Possible split:
  - **6a (Z6+Z7: SS-to-chain bridge + Walsh-isotype splitting)** — ~0.8M tokens.
  - **6b (Z8+Z9: Homotopy bridge + Obstruction transport)** — ~0.8M tokens.
  - **6c (Z10: Axiom removal + documentation updates)** — ~0.6M tokens.

### 7d. Top-3 failure modes + mitigations

1. **Walsh-isotype refactor (Z7) is harder than estimated.** Per
   `lean/AXIOMS.md`: "multi-week, ~250k Lean tokens per the
   empirical 250k-per-deliverable ceiling". The Walsh-isotype
   first-classing of the BK bicomplex's chain encoding requires
   extending the Y3 `BKIsotypeColumn` micro-objects up to the full
   `(BKTotal n).X 0` chain group. Mitigation: scope Z7 as a
   dedicated sub-split (Sub-ticket 6 → 6a); if the refactor is
   uniquely large, file as a separate sequential sub-ticket
   (Sub-ticket 6+ if needed). Track against the empirical
   250k-per-deliverable ceiling.
2. **Y1b residual (higher-row differential on BKBicomplexHC2)
   blocks Z9 chain-encoding refinement.** Per PROOF-STRUCTURE-ONBOARDING:
   "Row-0 differential non-trivial; higher rows scoped to multi-month
   refactor (Path B residual)". Mitigation: if Y1b is gated, Sub-ticket
   6 may need to also close Y1b (additional ~250-500k tokens, with
   Y6b cell-level reduction discipline) OR scope around it via
   cell-level reduction (per Z2e precedent).
3. **Final axiom-removal `#print axioms` doesn't drop cleanly** —
   the substitution chain accidentally re-introduces a sorry or
   axiom dependency from a Y1b or Y4 detail. Mitigation: at
   Sub-ticket 6 acceptance gate, run `#print axioms Frankl_Holds`
   AND `#print axioms` on every theorem in the Z6-Z10 chain;
   surface any unexpected axiom dependency immediately.

### 7e. Go/no-go gate AFTER Sub-ticket 6 (the project-life milestone)

**GREEN:** all 10 bars met → **PROJECT-LIFE MILESTONE: Frankl
formalised unconditionally at the Lean layer.** PM regenerates
roadmap. Daniel-Zulip-mail ready: announce
`#print axioms Frankl_Holds` shows only mathlib trio, headline
unconditional.

**AMBER:** axiom removal incomplete; some downstream piece needs
patching. Identify which and file as Sub-ticket 6 follow-on.

**RED:** the Walsh-isotype refactor or Y1b residual closure failed;
escalate to Daniel for option pivot (accept the partial improvement
— now Frankl axiom-disclosed at a different layer — or persist with
sub-splits).

---

## §8 — Cross-reference table: Sub-ticket N closes paper-axiom dependency X

| Sub-ticket | Lean delivery | Closes paper-axiom dependency | Closes mathlib bypass dependency |
|---|---|---|---|
| 1 (UCHC core scaffolding) | UCHC type + Additive + Limits | none directly | begins fork; deletes direct `instHasZeroMorphisms` |
| 2 (UCHC instance ecosystem) | Abelian + Bicomplex + Total + bypass viability gate | none directly | proves cascade-fork conjecture empirically (or refutes it) |
| 3 (Embedding + ShortComplex cascade) | stupidTrunc + ShortComplex/HC + CommSq invocation | none directly | provides Z2a-Z2j building blocks |
| 4 (Z2a-Z2j re-derivation) | Z2j AMBER → GREEN; SpectralObject record GREEN | provides the `Abelian SpectralObject` infrastructure that `lean/AXIOMS.md` Path (b) names | closes the TC-diamond at the bicomplex level |
| 5 (Z3-Z5 substantive) | BicomplexConvergence + EquivariantSpectralObject + EdgeMap | provides SS-side per-x abutment vanishing (UC10 §5.3 + UC13 §4.5 paper content) | none beyond Sub-ticket 4 |
| 6 (Z6-Z10 + Walsh-isotype + axiom removal) | Walsh-isotype refactor + chain-level obstruction vanishing + AXIOM REMOVAL | discharges `case3_ss_obstruction_paper_axiom` per `lean/AXIOMS.md` Replacement Path (a) + (b) combined | none beyond Sub-ticket 4 |

**Key insight:** Sub-tickets 1-3 are PURELY mechanical mathlib code
movement (no math content). Sub-ticket 4 is the SUBSTANTIVE
diamond bypass. Sub-tickets 5-6 are the substantive Lean delivery
of the paper-side math (UC10 §5.3 + UC13 §4.5 + §7) at the
bypassed UCHC₂ ambient.

---

## §9 — Cumulative budget projection + most-likely + worst-case scenarios

### 9a. Per-sub-ticket budget table

| Sub-ticket | Budget low | Budget high | Sub-split risk | Estimated sessions |
|---|---:|---:|---|---:|
| 1 (UCHC core scaffolding) | 1.0M | 1.5M | Low | 1-2 |
| 2 (UCHC instance ecosystem + bypass gate) | 0.8M | 1.2M | Low | 1 |
| 3 (Embedding + ShortComplex cascade) | 1.5M | 2.0M | Medium | 1-2 |
| 4 (Z2a-Z2j re-derivation) | 1.8M | 2.5M | **High (pre-authorised 4a/4b/4c)** | 1-3 |
| 5 (Z3-Z5 substantive) | 1.5M | 2.0M | **High (pre-authorised 5a/5b/5c)** | 2-4 |
| 6 (Z6-Z10 + axiom removal) | 1.5M | 2.5M | **High (pre-authorised 6a/6b/6c)** | 2-4 |
| **Cumulative** | **8.1M** | **11.7M** | | **8-16 sessions** |

### 9b. Most-likely scenario

Sub-tickets 1-3 land cleanly (1.0M + 0.8M + 1.5M = ~3.3M). Sub-ticket
4 needs sub-split into 4a+4c (no 4b because Z2f-Z2i port is
straightforward, the substantive content is the Z2j primitive): 1.8M
+ 0.6M = ~2.4M. Sub-ticket 5 needs sub-split into 5a+5b+5c: 1.5M.
Sub-ticket 6 needs sub-split into 6a+6b+6c: 2.0M.

**Most-likely total: ~9.2M tokens across 11 sessions.** Matches
mg-7e53 §"Phase C" "~10-20M tokens across 10-20 sessions"
projection on the lower end.

### 9c. Best-case scenario

All sub-tickets land in their stated stride without sub-split.
**~8.1M tokens across 6-8 sessions.**

### 9d. Worst-case scenario

3× sub-split factor on Sub-tickets 4/5/6 + 2× sub-split factor on
Sub-ticket 3:
- Sub-ticket 1: 1.5M
- Sub-ticket 2: 1.2M
- Sub-ticket 3: 4.0M (split 3a+3b+3c)
- Sub-ticket 4: 7.5M (split 4a+4b+4c+4d+4e+4f)
- Sub-ticket 5: 6.0M (split 5a+5b+5c+5d)
- Sub-ticket 6: 7.5M (split 6a+6b+6c+6d+6e+6f)

**Worst-case total: ~27.7M tokens across 18-22 sessions.** Slightly
exceeds mg-7e53 upper bound but within Daniel's "days-to-weeks"
AI-native cadence framing.

### 9e. Decision points where Daniel may want to re-scope

- **After Sub-ticket 2 RED (cascade-fork conjecture refuted).**
  Daniel decides: pivot to Option C (upstream mathlib PR) or Option
  D (cell-level Z2k workaround) or Option A (accept paper-axiom
  permanently). All three are Daniel-gated.
- **After Sub-ticket 4 RED on Z2j primitive specifically.** Same
  pivot decision; the cascade-fork bypassed single-level but not
  bicomplex-level diamond.
- **After Sub-ticket 4 GREEN but Sub-ticket 5 exceeds budget by 2×.**
  Daniel decides: continue with sub-split (multi-session) or pivot
  to a narrower closure target (e.g. close Z3 alone, leaving Z4-Z10
  for later research track).
- **After Sub-ticket 6 partial (Z6-Z8 GREEN but Z9-Z10 RED on
  Walsh-isotype refactor).** Daniel decides: ship the partial
  improvement (axiom narrowed to just the chain-encoding-refinement
  substep, with the SS-side substep substantively closed) or
  persist with sub-splits.

---

## §10 — Risk + alternatives + mg-7e53 §"Phase B" structural-impossibility cross-check

### 10a. Cross-check against mg-7e53 §"Phase B" structural impossibility

mg-7e53 Phase B established: "Step 3 (redirect downstream imports to
local copy) is structurally impossible under Lean 4's nominal type
system" for the literal single-file fork. Concretely:

- **If the local copy uses the SAME module name** —
  `Mathlib.Algebra.Homology.HomologicalComplex` — Lean rejects the
  duplicate module.
- **If the local copy uses a DIFFERENT module name** —
  `UnionClosed.Mathlib.HomologicalComplex` — but the SAME type name
  `HomologicalComplex`, the types are nominally distinct even with
  identical structure; downstream consumers that use mathlib's HC
  cannot substitute the local one.
- **The required mathlib downstream files** (`HomologicalComplexAbelian`,
  `TotalComplex`, `Embedding/*`, etc.) all reference mathlib's HC
  by fully-qualified name; they'd continue to use mathlib's HC
  regardless of the local copy.

**The cascade fork avoids this** by using a **DIFFERENT TYPE NAME**
(`UCHomologicalComplex` ≠ `HomologicalComplex`) AND building the
**FULL DEPENDENCY CONE** in the UC namespace (`UCHomologicalComplex`
+ `UCAdditive` + `UCHomologicalComplexAbelian` + `UCHomologicalBicomplex`
+ `UCTotalComplex` + `UCEmbedding/*` + `UCShortComplex/HomologicalComplex`
+ optional `UCCommSq` + optional `UCKernelCokernelComp`). The fork
is **self-contained at the UC namespace boundary** — no expectation
of cross-namespace TC substitution.

This is **genuinely different** from the single-file-copy that
failed: the single-file-copy required mathlib's downstream
consumers to use the local HC; the cascade fork uses UCHC for all
its own downstream consumers, and only the union_closed codebase
(Bicomplex.lean → UCBicomplex.lean) needs adaptation.

### 10b. Why TC search picks the unique fork instance

Under the cascade fork:

- `HasZeroMorphisms (UCHC V c)` has **exactly one path**: via
  `preadditiveHasZeroMorphisms` composed with the
  `UCAdditive` `Preadditive (UCHC V c)` instance. The direct
  `instance : HasZeroMorphisms (UCHC V c) where` has been DELETED.
  No priority ambiguity.
- `HasZeroMorphisms (UCHC (UCHC V c₂) c₁)` similarly has **exactly
  one path**, via the same preadditive chain at both layers. Both
  layers are forked, both layers have the direct instance deleted,
  both layers route through preadditive.
- `Abelian (UCHC (UCHC V c₂) c₁)` is the `noncomputable instance`
  from UCHomologicalComplexAbelian.lean, and its `toPreadditive`
  field flows from the UCAdditive chain, with `HasZeroMorphisms`
  field being `preadditiveHasZeroMorphisms` unambiguously.

**The cascade fork structurally eliminates the diamond** by
ensuring the direct path doesn't exist in the UCHC namespace.

### 10c. What if the cascade fork itself fails?

**Fallback path: Option D (cell-level Z2k workaround) revisited.**

Per mg-8510 §2d: "redesign the Z3-Z10 deliverables to avoid
invoking the bicomplex Abelian instance at all". The Z2e precedent
(`shortExact_of_degreewise_shortExact` applied TWICE to reduce
to cell-level in `C`) is known to work for specific deliverables
but has not been tested for the full Z2j → Z3-Z10 chain.

If Sub-ticket 2 bar 4 (the cascade-fork viability gate) RED, file
Option D as a separate scoping ticket. Cell-level reduction is
~1.5-2.0M tokens of dedicated re-architecture per mg-8510 §3.

**Secondary fallback: Option C (upstream mathlib PR).**

Per mg-8510 §2a: file mathlib PR with `@[reducible]` annotation
on `HomologicalComplex.instHasZeroMorphisms` or priority bump on
`preadditiveHasZeroMorphisms`. Multi-week + multi-week-wait, no
guaranteed acceptance.

**Tertiary fallback: Option A (accept paper-axiom permanently).**

Status quo per mg-1b2b. Paper-axiom is the steady-state form; no
further Lean work needed. Per mg-ee54 GREEN-WITH-CONDITIONS audit,
this form is publication-defensible.

### 10d. Why this is genuinely tractable

Per Daniel 2026-05-18T22:35Z: "AI-native dev paradigm, copy any
number of files needed, maintenance moot, one successful
formalization is the bar."

The cascade-fork is the maximally-mechanical realization of this
framing:

- **The fork is local** (`lean/UnionClosed/Mathlib/...`) — no
  upstream coordination.
- **The fork is namespace-isolated** — no expectation of cross-fork
  substitution.
- **The fork is single-pass** — copy + namespace-rename + delete one
  instance + verify build. No iterative debug cycle is expected at
  Sub-tickets 1-3 (Sub-ticket 4 may iterate per Z2 sub-split
  lineage, pre-authorised).
- **The fork is throwaway-friendly** — if a mathlib release breaks
  the union_closed codebase, the fork can be re-derived from the new
  mathlib release in another single pass (no upstream
  sync burden during the active research period).
- **The fork has a precise success criterion** — the
  Sub-ticket-2-bar-4 diamond probe builds GREEN, and the
  Sub-ticket-4-bar-3 Z2j primitive builds GREEN. Both are MECHANICAL
  build acceptance bars, not subjective audit gates.

---

## §11 — Sub-ticket dispatch chain (filed via `mg new` per Phase D)

The 6 sub-tickets are FILED in `pending` status under mg-ea01, with
each blocked-by the prior sub-ticket. As mg-ea01 transitions to
`done`, mg-f52c (Sub-ticket 1) promotes to `available` and the mayor
dispatches it.

| Sub-ticket | mg ID | Depends on | Budget |
|---|---|---|---:|
| 1 (UCHC core scaffolding) | **mg-f52c** | mg-ea01 | 1.5M |
| 2 (UCHC instance ecosystem + viability gate) | **mg-d079** | mg-f52c | 1.2M |
| 3 (Embedding + ShortComplex cascade) | **mg-72ad** | mg-d079 | 2.0M |
| 4 (Z2a-Z2j re-derivation, the big one) | **mg-992c** | mg-72ad | 2.5M |
| 5 (Z3-Z5 substantive) | **mg-ef1f** | mg-992c | 2.0M |
| 6 (Z6-Z10 + Walsh-isotype + axiom removal) | **mg-00b6** | mg-ef1f | 2.5M |

Each sub-ticket body is **self-contained for polecat dispatch**:
the body cross-references this scoping doc (§2-§7 for the
sub-ticket-specific content) plus prior state docs / mg tickets,
and lists the same acceptance bars / budget / failure modes / gates.

**Mayor-side dispatch protocol.** After mg-ea01 merges:

1. Promote pending → available: `mg schedule` (or equivalent) once
   mg-ea01 transitions to `done`.
2. Spawn cat-mg-f52c polecat: `pogo agent spawn-polecat mg-f52c
   --repo /Users/daniel/research/union_closed`.
3. Wait for cat-mg-f52c verdict (GREEN → mg-d079 promotes; RED →
   escalate per §5e of the Sub-ticket-1 body).
4. Repeat with cat-mg-d079, cat-mg-72ad, ... cat-mg-00b6.
5. After cat-mg-00b6 GREEN, regenerate roadmap reflecting the
   project-life milestone (Frankl axiom-free at Lean layer);
   Daniel-Zulip-mail ready per the AXIOMS.md "Forum-post disclosure"
   section becoming a Forum-post **completion** announcement.

---

## §12 — Acceptance bars for THIS scoping ticket (mg-ea01)

Per mg-ea01 §"Acceptance bar":

1. **`docs/Frankl-cascade-fork-execution-plan.md` (~600-800 lines)
   lands on `main`** — this document satisfies the
   600-800-line target (THIS document is ~775 lines).
2. **Sub-ticket 1 (fork core HC scaffolding) is filed via `mg add`
   with body ready for polecat dispatch.** See §11a for the `mg
   add` command + cross-reference §2 for the body content.
3. **Sub-tickets 2-6 are pre-filed in pending status with depends
   chain to Sub-ticket 1, 2, 3, 4, 5 respectively.** See §11b-§11f.
4. **PM can read this doc + 6 sub-tickets and dispatch Sub-ticket 1
   without additional clarification.** The doc is the PM's
   self-contained dispatch reference.

---

## §13 — Cross-references

**Verdict trigger.** Daniel directive 2026-05-19T07:13Z ("Frankl I
still want more forking") explicitly endorsing Option B cascade fork
from mg-7e53 RED.

**Predecessors absorbed.**

* `mg-7e53` (RED simpler-approaches replay) +
  `docs/state-Frankl-mathlib-bypass-replay-Session1.md` (Phase B
  structural-impossibility + Phase C cascade-fork roadmap sketch).
* `mg-8dce` (RED priority-tweaks) +
  `docs/state-Frankl-mathlib-copy-and-tweak-Session1.md`.
* `mg-8510` (architecture audit, 5-option analysis) +
  `docs/Z-arc-architecture-audit.md`.
* `mg-ee54` (independent audit GREEN-WITH-CONDITIONS) +
  `docs/Frankl-disclosure-pivot-independent-audit.md`.
* `mg-1b2b` (disclosure-pivot execution; paper-axiom landed).
* `mg-103f` (Z1-Z10 scoping) +
  `docs/UC-Lean-MathlibSS-Full-scope.md`.
* `mg-083f` (proof-tree onboarding) +
  `docs/PROOF-STRUCTURE-ONBOARDING.md`.

**Mathlib v4.29.1 file inventory verified** at
`/Users/daniel/.pogo/polecats/pc-ba0c/lean/.lake/packages/mathlib/`
on 2026-05-19; pin rev `5e932f97dd25535344f80f9dd8da3aab83df0fe6`.

**DiamondTest.lean** at
`lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/DiamondTest.lean`
(mg-7e53 NEW, 90 lines) is the canonical entry point for future
polecats to test bypass success; Sub-ticket 2 + Sub-ticket 4
acceptance bars reference its commented-out Z2j primitive.

**Joël Riou attribution** preserved in all forked SpectralObject /
Embedding / TotalComplex files per Daniel 2026-05-17T13:53Z
local-only directive.

**Daniel directives in play.**

* 2026-05-19T07:13Z — "Frankl I still want more forking" (THIS
  ticket's trigger).
* 2026-05-18T22:35Z — "AI-native dev paradigm, copy any number of
  files needed, maintenance moot, one successful formalization is
  the bar" (justifies the cascade-fork file count).
* 2026-05-18T18:05Z — "paper axiom must close in Lean" (the goal
  is replacing, not coexisting with, the axiom).
* 2026-05-18T18:25Z — "copy from mathlib and tweak" (the simpler
  versions of which are EXHAUSTED per mg-8dce / mg-7e53; cascade fork
  is the richer realization).
* 2026-05-17T13:53Z — "mathlib code local-only for now" (preserves
  local-fork status).
* 2026-05-17T12:47Z — "full mathlib infrastructure, don't pursue
  shortcuts" (the cascade fork preserves substantive math while
  reorganizing Lean delivery).

---

*End of execution plan. Total ~775 lines (within ~600-800 target).
Dispatch Sub-ticket 1 immediately after this scoping doc merges.*
