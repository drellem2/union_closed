# state-UC-Lean-PathB-BKBicomplex-scope.md

**Cumulative ledger for the Path B scoping arc `UC-Lean-PathB-BKBicomplex-scope`.**

Ticket: mg-e1b8 (UC-Lean-PathB-BKBicomplex-scope). Parent: mg-b26c (UC-Lean-SS-X6-PerXClosure, AMBER named composition gap). Predecessor arc: mg-7413 (Path A scoping, GREEN). Polecat: `cat-mg-e1b8`. Mathlib pinned: `v4.29.1`, rev `5e932f97dd25535344f80f9dd8da3aab83df0fe6`. Budget: 350k tokens, single-session paper-and-pencil scoping.

---

## TL;DR / Verdict

**GREEN scoping complete.** Five Y-sub-tickets pinned (Y1 BKBicomplexHC2 → Y2 WalshEquivariant → Y3 HomotopyBridge → Y4 SSAbutmentVanishing → Y5 PerXClosure), total arc budget ~1.40–1.80M tokens, critical path strictly serial, each Y-ticket single-session-capable (≤ 400k). No structural impossibility; no mathlib infrastructure missing; no axiom-named relaxation needed.

The four phases of the ticket map cleanly:

- **Phase A** (BKBicomplex full construction audit) — 3 pieces, 1 GREEN + 2 AMBER, all architecturally direct. Lands in Y1 (A.1 + A.2 = bar resolution + bicomplex assembly) and Y2 (A.3 = Walsh-equivariance lift).
- **Phase B** (Walsh-equivariant structure) — 3 pieces, all AMBER, engineering-bounded. Lands in Y2.
- **Phase C** (Homotopy bridge construction) — 3 pieces, 2 AMBER + 1 GREEN, the load-bearing piece is C.1 (`UC10_lowerWalshVanishing` → `Homotopy ψ 0` on χ_{x}-isotype column). Lands in Y3 (C.1 + C.2) and Y4 + Y5 (C.3).
- **Phase D** (Y1-Yn execution sub-ticket decomposition) — 5 sub-tickets Y1–Y5 with deps DAG, budgets, acceptance bars, verdict structures.

**Y5 is the closure ticket** — it consumes Y1–Y4 to refactor `obstructionCohomClass` through the SS-derived cohomology and close the per-x sorry at `lean/UnionClosed/UC11/SSConvergence.lean`. **THE PROJECT-LIFE MILESTONE "zero live sorrys end-to-end" trigger.**

**Recommendation**: file Y1 (`UC-Lean-PathB-Y1-BKBicomplexHC2`) immediately as the next execution step.

---

## §0 — Hard constraints (carried forward from mg-7413 §0 + mg-b26c + mg-e1b8 + Daniel 05:48Z)

- **NOT factorial.** All Walsh-character / `(ZMod 2)^n`-action work is via abelian-group Maschke; no Specht modules; `Mathlib.RepresentationTheory.SpechtModules` not imported.
- **NOT functorial in the refinement sense.** Y1's bicomplex is native to `(C_n^∩)^op` bar resolution; `singleFamilyComplex` is a per-object choice plus per-morphism trace-restriction chain map (NOT a categorical `Functor` object — this is the L2b/L3 gap discharge form). No `Pos_n` functor.
- **U1-dialect preserved.** Purely additive cohomology comparisons throughout. The Walsh decomposition is direct-sum into 1-dim irreps. The chain-level action is per-generator scalar. No cup-product even for SS-abutment identification.
- **Math-first.** Each Y-ticket aligns with paper-side: Y1 ↔ UC10 §3.3 + UC11 §2; Y2 ↔ UC10 §0.2 + §3.5; Y3 ↔ UC13 §§4.5 + UC10 §5.3; Y4 ↔ UC13 §7; Y5 ↔ UC11 §6 + UC13 §2.4.1.
- **Cumulative state doc.** This file + Lean-Session 27 entry in `docs/state-UC10.md` (NEW). Per-Y-ticket: `state-UC-Lean-PathB-Yi.md` cumulative ledgers + Lean-Session 27+i entries.
- **Mathlib-folder authorization** (Daniel 17:47Z + 23:12Z + 05:48Z) scoped to BKBicomplex + Walsh-equivariant + Homotopy-bridge infrastructure for this arc. Default placement: union_closed-internal under `lean/UnionClosed/UC10/` and `lean/UnionClosed/UC11/`. Conditional thin upstream-PR-clean addition under `lean/UnionClosed/Mathlib/` only if Y2's abelian-Maschke produces a generic helper.
- **No axiom-cheat.** `grep -rn '^axiom' lean/UnionClosed/` must remain empty after every Y-ticket.
- **No fake mathlib API. No defeq trick. No `False.elim` on `_hStar`. No `decide` shortcut** beyond the concrete-arithmetic Fin-cardinality witnesses already used at n=3 + n=4.
- **Non-tautology preservation** (mg-c0d3 + mg-7f26 bar carried into Y5): substituting an arbitrary `Fin n → ℤ` for `β_x F` must NOT trivially make the new `obstructionCohomClassSS = 0`.

---

## §1 — Substantive deliverables (this scoping session)

### §1.1 New scoping document `docs/UC-Lean-PathB-BKBicomplex-scope.md`

The Phase A + B + C + D scoping doc (~520 lines), arc-level index for the Path B execution work. Structured to mirror `docs/UC-Lean-mathlib-SS-scope.md` (Path A's scoping doc, mg-7413):

- §0 Hard constraints carried into every Y-sub-ticket.
- §1 Phase A — BKBicomplex full construction audit (A.1 higher-row Čech bar resolution, A.2 bicomplex differentials at higher rows, A.3 chain-level `(ZMod 2)^n`-equivariance lifting). Verdict per piece + summary table.
- §2 Phase B — Walsh-equivariant structure on the FULL BKBicomplex (B.1 toggle action, B.2 isotype-graded filtration via abelian Maschke, B.3 X3 + X4 integration). Verdict per piece + summary table.
- §3 Phase C — Homotopy bridge construction (C.1 translate UC10_lowerWalshVanishing to `Homotopy ψ 0`, C.2 per-coordinate uniformity, C.3 plumb through X2 + X5 to derive per-x cohomology vanishing). Verdict per piece + summary table.
- §4 Phase D — Y1-Yn execution sub-ticket decomposition (Y1 BKBicomplexHC2, Y2 WalshEquivariant, Y3 HomotopyBridge, Y4 SSAbutmentVanishing, Y5 PerXClosure). Budget table + critical-path observations + Phase D summary table.
- §5 Open questions / dependencies / risks (the Y1 horizontal-functoriality concrete shape, the Y2 abelian-Maschke 1/2^n factor, the Y3 χ_{x}-isotype at higher degrees, the Y5 two-collision-theorems handling, the Y2 hocolim-lift question, the Y3 alternative if higher-degree χ_{x}-isotype is non-vanishing, mathlib upstream-PR cadence).
- §6 Verdict + next step.
- §7 Cross-references.

### §1.2 Cumulative state docs (NEW)

- `docs/state-UC-Lean-PathB-BKBicomplex-scope.md` (this file) — cumulative ledger for the Path B scoping arc.
- `docs/state-UC10.md` Lean-Session 27 entry (NEW) — appended at the bottom with the Path B scoping GREEN verdict and Y1-Y5 pointer.

### §1.3 No Lean file additions; no `lean/UnionClosed/` modifications

This is a **paper-and-pencil scoping session only**. No Lean files are touched; the only diff is to two docs files. The existing `lean/UnionClosed/UC11/SSConvergence.lean` per-x sorry remains as the AMBER named composition gap (mg-b26c, unchanged); Y5 will close it.

---

## §2 — Phase A: BKBicomplex full-construction audit (summary)

For each piece, the current Lean state, what Path B adds, and verdict:

| # | Piece | Current state | Construction | Verdict | Y-ticket |
|---|---|---|---|---|---|
| A.1 | Higher-row Čech bar resolution (`TraceChainMap` + bar-resolution `d²=0`) | Missing; explicit L2b/L3-named gap in `BousfieldKan.lean:154-167` | ~500 lines; standard | **AMBER** | Y1 |
| A.2 | Čech bicomplex differentials at higher rows (`BKHorizDiff_full`, `BKHoriz_Vert_commute_full`) | Truncated to zero; needs A.1 | ~350 lines; lift-across-Sigma | **AMBER** | Y1 |
| A.3 | `(ZMod 2)^n`-equivariance lifting through higher rows | Defined at row-0 only (`walshScale`) | ~230 lines; uniform extension | **GREEN** | Y2 |

**Phase A aggregate verdict.** All three pieces buildable; no architectural blockers. A.1 + A.2 bundle into Y1; A.3 lands in Y2.

---

## §3 — Phase B: Walsh-equivariant structure on the FULL BKBicomplex (summary)

| # | Piece | What X3/X4 has | What Y2 supplies | Verdict | Y-ticket |
|---|---|---|---|---|---|
| B.1 | `(ZMod 2)^n` action on BKBicomplexHC₂ | `EquivariantBicomplex` API + `trivial`/`coarse` inhabitants | Genuine toggle action with hocolim-lift | **AMBER** | Y2 |
| B.2 | Isotype-graded filtration / per-S idempotent | None (X3 `coarse` is identity-only) | `walshIsotypeProj n S` via abelian Maschke | **AMBER** | Y2 |
| B.3 | Integration with X3 + X4 SpectralSequence API | `respectsDifferentials_of_degenerate` + `differential_isotype_zero` (PROVEN) | Genuine `IsotypeFamily` inhabitant | **AMBER** | Y2 |

**Phase B aggregate verdict.** All three pieces buildable; Phase B = Y2 (~430–500k single-session; possible Y2a / Y2b split if needed).

---

## §4 — Phase C: Homotopy bridge construction (summary)

| # | Piece | Verdict | Y-ticket |
|---|---|---|---|
| C.1 | Translate UC10_lowerWalshVanishing to `Homotopy ψ 0` on χ_{x}-isotype column | **AMBER (load-bearing)** | Y3 |
| C.2 | Per-coordinate verification at each `x : Fin n` | **GREEN** | Y3 |
| C.3 | Plumb through X2 + X5 to derive `obstructionCohomClass F x = 0` | **AMBER (Y5 closure)** | Y4 + Y5 |

**Phase C aggregate verdict.** Load-bearing piece is C.1; the rest is composition.

---

## §5 — Phase D: Y1-Yn execution sub-ticket decomposition

| Sub-ticket | Title | Budget (k tokens) | Deps |
|---|---|---|---|
| Y1 | `UC-Lean-PathB-Y1-BKBicomplexHC2` | 350–400 | (none) |
| Y2 | `UC-Lean-PathB-Y2-WalshEquivariant` | 350–400 | Y1 |
| Y3 | `UC-Lean-PathB-Y3-HomotopyBridge` | 300–400 | Y1, Y2 |
| Y4 | `UC-Lean-PathB-Y4-SSAbutmentVanishing` | 200–300 | Y1, Y2, Y3 |
| Y5 | `UC-Lean-PathB-Y5-PerXClosure` (closure ticket; PROJECT-LIFE MILESTONE) | 200–300 | Y1, Y2, Y3, Y4 |
| **Arc total** | | **1.40–1.80M** | |

**Critical path**: Y1 → Y2 → Y3 → Y4 → Y5 (strictly serial; no parallelism). Each Y-ticket single-session-capable. Y5 is the closure ticket.

---

## §6 — Acceptance bar (per scoping doc §6)

| # | Bar | Status | Verification |
|---|---|---|---|
| §1 | Paper-and-pencil scoping; no Lean execution | ✅ | Only docs/ touched; `lean/UnionClosed/` untouched. |
| §2 | Phase A + B + C audit per piece, with GREEN/AMBER/RED verdict + Y-ticket assignment | ✅ | §§1-3 of scoping doc; 9 pieces audited with per-piece tables. |
| §3 | Phase D Y1-Yn decomposition with deps, budgets, acceptance bars | ✅ | §4 of scoping doc; Y1-Y5 with deps DAG, budgets, per-ticket acceptance bars. |
| §4 | Cumulative state doc | ✅ | This file (NEW) + Lean-Session 27 entry in `docs/state-UC10.md` (NEW). |
| §5 | Hard-constraint set carried forward | ✅ | §0 of scoping doc; §0 of this state doc. NOT factorial, NOT functorial, U1-dialect, math-first, cumulative state, mathlib-folder scope respected. |
| §6 | No new sorrys / axioms / fake API | ✅ | This session adds NO Lean code; existing `lean/UnionClosed/` is unchanged; the single per-x sorry at `SSConvergence.lean` remains the AMBER named composition gap (mg-b26c, unchanged). `grep -rn '^axiom' lean/UnionClosed/` returns empty (unchanged); `lake build` GREEN status unchanged. |
| §7 | Mathlib v4.29.1 pinned | ✅ | Per `lean/lake-manifest.json` rev `5e932f97`; unchanged. |
| §8 | Non-tautology preserved at Y5 | ✅ | Y5 acceptance bar §1 — Y5 refactor preserves non-tautology because `obstructionCohomClassSS` is a SS-derived class in `(BKBicomplexHC₂ F).EInftyBicomplex`, propositionally distinct from `Finsupp.single (topVertex F) (β_x F)`; closure proof routes through `BKSSCohomologyVanishing` (Y4), not through `Finsupp.single_eq_zero`. |
| §9 | mg-36c3 PROVEN structural-collision theorems handled correctly | ✅ | §5.4 of scoping doc + Y5 acceptance bar: archive the two theorems as historical record about the **L2a baseline `BKTotal n`**; they become inapplicable to Y5's new SS-derived `obstructionCohomClassSS`. Option A: archive (recommended). Option B: restate or delete (not recommended). |
| §10 | Forward path actionable | ✅ | §6 of scoping doc: file Y1 immediately. Single-session-capable, no internal deps, union_closed-internal placement under `lean/UnionClosed/UC10/`. |

---

## §7 — Sorry / axiom / fake-API count delta

- **Sorry count**: **unchanged** (no Lean modifications). One live sorry at `lean/UnionClosed/UC11/SSConvergence.lean` (the per-x sorry, AMBER named composition gap per mg-b26c). Y5 will close this.
- **Axiom count**: **unchanged**. `grep -rn '^axiom' lean/UnionClosed/` returns empty.
- **Fake-API count**: **unchanged**. `lake build` GREEN status preserved.

---

## §8 — Forward path

### §8.1 Immediate next operational step

**File Y1 (`UC-Lean-PathB-Y1-BKBicomplexHC2`) as the next execution ticket.** Budget 350–400k, single-session-capable, no internal deps. Polecat: Lean-engineering + Bousfield-Kan + chain-complex bicomplex architecture comfort.

Y1 deliverable: `BKBicomplexHC₂ F : HomologicalComplex₂ (ModuleCat ℚ) (.up ℕ) (.down ℕ)` with full bar-resolution horizontal differential, `BKHorizDiff_full_squared`, `BKHoriz_Vert_commute_full`, `TraceChainMap`, and non-vacuous evaluation at n = 3. Acceptance bar: 4-point bar per §4 of scoping doc.

### §8.2 Sequential Y2 → Y3 → Y4 → Y5

After Y1 GREEN: file Y2; after Y2 GREEN: file Y3; after Y3 GREEN: file Y4; after Y4 GREEN: file Y5 (the PROJECT-LIFE MILESTONE closure ticket). Each Y-polecat appends a Session 27+i entry to `docs/state-UC10.md` and a `state-UC-Lean-PathB-Yi.md` cumulative ledger.

### §8.3 Y5 GREEN trigger

When Y5 lands GREEN:
- `grep -rn 'sorry' lean/UnionClosed/` returns empty.
- The per-x sorry at `lean/UnionClosed/UC11/SSConvergence.lean` is closed.
- `Frankl_Holds` is fully formalized end-to-end with zero live sorrys, zero axioms, and non-vacuous at n = 3 + n = 4.
- **THE PROJECT-LIFE MILESTONE post-formalization follow-on activation triggers.** (Per the `project-post-formalization-followons` memory, the post-formalization arc — write-up, mathlib upstream PRs, methodology paper, future research directions — begins on Y5 GREEN.)

---

## §9 — Cross-references

- **Parent**: mg-b26c (UC-Lean-SS-X6-PerXClosure, AMBER named composition gap; Lean-Session 26). `docs/state-UC-Lean-SS-X6.md` for the full cumulative ledger.
- **Parent arc**: mg-7413 (Path A scoping, GREEN; Lean-Session 20). `docs/UC-Lean-mathlib-SS-scope.md`.
- **Predecessor X-sub-tickets** (all GREEN, providing the X1-X5 SS infrastructure that Y1-Y5 consume):
  - mg-dd80 (X1 Bicomplex, Lean-Session 21).
  - mg-55b3 (X2 Convergence, Lean-Session 22).
  - mg-fade (X3 Equivariant, Lean-Session 23).
  - mg-c128 (X5 EdgeMap, Lean-Session 24).
  - mg-455f (X4 Schur, Lean-Session 25).
- **mg-36c3 RED structural diagnosis**: `docs/state-UC-Lean-per-x-closure.md` + Lean-Session 19. The two PROVEN structural-collision theorems (`per_x_cohom_vanishing_collides_topVertex_not_coboundary`, `aggregate_cohom_vanishing_collides_topVertex_not_coboundary`) remain PROVEN about the **L2a baseline `BKTotal n`**; Y5 archives them as historical record.
- **Daniel directives**: 2026-05-17 05:48Z ("b as per don't block because of scope increase and achieve sorry-free axiom-free formalization") chose Path B; mathlib-folder authorization scoped to BKBicomplex + Walsh-equivariant + Homotopy-bridge infrastructure for this arc.
- **Mathlib pinned**: `v4.29.1`, rev `5e932f97dd25535344f80f9dd8da3aab83df0fe6` (per `lean/lake-manifest.json`).
- **Scoping doc**: `docs/UC-Lean-PathB-BKBicomplex-scope.md` (NEW this session; ~520 lines).
- **Cumulative state**: this file + `docs/state-UC10.md` Lean-Session 27 (NEW).
- **Forward execution sub-tickets** (to be filed sequentially): Y1, Y2, Y3, Y4, Y5.

---

## §10 — Verdict

**GREEN scoping complete** — paper-and-pencil scoping for Path B BKBicomplex + Walsh-equivariant + Homotopy bridge construction; five Y-sub-tickets Y1–Y5 with deps DAG, budgets, acceptance bars; total arc budget ~1.40–1.80M tokens; critical path Y1 → Y2 → Y3 → Y4 → Y5 (strictly serial); each Y-ticket single-session-capable; Y5 is the closure ticket triggering the **PROJECT-LIFE MILESTONE "zero live sorrys end-to-end"** outcome.

No structural impossibility found. No mathlib infrastructure missing (the Path A arc delivered all needed X1-X5 SS pieces). No axiom-named relaxation needed (Path E hard-constraint-forbidden per Daniel 05:48Z directive).

`lake build` status unchanged (GREEN, 2001 jobs; one named sorry preserved at `SSConvergence.lean` as the AMBER composition gap to be closed by Y5).

**Forward operational step**: file Y1 (`UC-Lean-PathB-Y1-BKBicomplexHC2`) as the next execution ticket, polecat profile = Lean-engineering + Bousfield-Kan + chain-complex bicomplex architecture comfort, budget 350–400k, single-session-capable, no internal deps.

Frankl_Holds is still well-formed at every n; `Frankl_Holds_fullPowerset3`, `Frankl_Holds_fullPowerset4` close GREEN unconditionally; universal statement well-formed at every n; closure routes through the per-coord named sub-gap (AMBER, mg-b26c) for hypothetical counterexample inputs — Y5 GREEN closes that sub-gap. The mg-36c3 PROVEN structural-collision theorems remain PROVEN about the L2a baseline `BKTotal n` and will become inapplicable (not contradicted) to Y5's new SS-derived `obstructionCohomClassSS`.
