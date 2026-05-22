# Fork A re-foundation of the Frankl cohomology

This directory holds the **Fork A re-foundation** of the cohomological
arc of the union-closed (Frankl) program — work item **mg-c15b**
(Frankl-ForkA-Refound-LaTeX), **Phase 1: the LaTeX re-foundation**,
**revised** under **mg-365e** (Frankl-ForkA-Phase2-Revision) per the
**mg-d300** independent Phase-2 validation.

## What this is

The cohomological arc was halted by its Phase-1.5 audit (`mg-0405`),
which refuted two load-bearing objects: the against-trace structure
map (so the cohomology object `X^∩_n` was undefined) and the
`(Z/2)^n`-action (so its Walsh grading was unconstructed). A
vision-check (`mg-6edc`) and a bounded `n=3` probe (`mg-565a`)
resolved the re-foundation fork to **Fork A**:

- re-found the cohomology as the **covariant** homotopy colimit of the
  per-family coefficient diagram `F ↦ X(F)` over the trace category
  `C_n`, with the canonical trace **projection** `π_T` as structure
  map (the projection exists and is functorial — `mg-0405` Prop. 3.6);
- **drop** the `(Z/2)^n`-action; grade by `sgn_{S_n}`;
- keep Walsh only as the harmonic description of the obstruction
  cochain.

`refoundation.tex` is the Phase-1 LaTeX carrying this out.

## Files

| File | Contents |
|------|----------|
| `refoundation.tex` | the standalone Fork A re-foundation (Phase 1) |
| `README.md` | this file |

## Building

```
pdflatex refoundation
pdflatex refoundation
```

It is **self-contained**: its own preamble, no bibliography, no
external inputs. It does **not** modify the consolidated paper
(`../main.tex`), which honestly records the pre-Fork-A state.

## Verdict (Phase 1, as corrected by the mg-365e revision)

**GREEN — FORK-A-REFOUNDATION-DELIVERED.** The re-foundation is
delivered and internally sound:

- the covariant cohomology object `H*(C_n;X)` is **genuinely defined**
  (Phase-1.5 refutation (a) dodged by construction);
- the `(Z/2)^n`-action is dropped (Phase-1.5 refutation (b) dissolved);
- the `sgn_{S_n}` re-grading is carried out (Maschke for the genuine
  `S_n`-action; the sphere class is the sign isotype);
- the obstruction class and the two-part contradiction are
  re-established as a **conditional theorem**.

**Frankl is not proved, and Phase 1 was never meant to prove it.** The
contradiction's open inputs are named precisely and **in full**:

- **R1** — the `Y1` cofiber residual, **two-part**: **R1a** the
  cofiber cohomology (as a target object, unchanged from pre-Fork-A);
  **R1b** a new `S_{n-1}→S_n` branching step the `(Z/2)^n→S_n`
  re-grading creates (the `Y1` cofiber-LES reduction is only
  `Stab(x)≅S_{n-1}`-equivariant, not `S_n`-equivariant);
- **R2** — the `Y2` landing / separation of the obstruction from the
  sphere class (Fork A re-opens this: the pre-Fork-A `Y2` mechanism
  rested on the now-dropped `(Z/2)^n`-equivariance);
- **R3** — faithfulness, a **three-part** debt on the
  Čech-to-cohomology edge map: **R3a** existence, **R3b** degree-`n-1`
  landing, **R3c** injectivity (the `V3` / wrapper-risk question).

Owed debt 1 (the re-grading) is **addressed**; owed debt 2
(faithfulness) is **localized** to R3.

See `refoundation.tex` §0 for the full scorecard and the revision
callout, `docs/Frankl-ForkA-Refound-LaTeX.md` for the Phase-1 ledger
note, and `docs/Frankl-ForkA-Phase2-Revision.md` for the mg-365e
revision ledger note.

## The mg-365e revision

The independent Phase-2 validation (`mg-d300`,
`docs/Frankl-ForkA-Phase2-validation.md`) returned **AMBER**: the
Fork A core was independently confirmed sound, but two over-claims
survived into the Phase-1 draft. This revision corrects both by honest
re-statement (no new math, no refutation):

- **Finding A** — the `Y1`-A cofiber-LES reduction was claimed
  `S_n`-equivariant and to "port unchanged"; it is only
  `Stab(x)≅S_{n-1}`-equivariant, so R1 acquires the `S_{n-1}→S_n`
  branching sub-residual R1b.
- **Finding B** — the residual set was claimed to be "exactly three";
  R3 is in fact a three-part edge-map debt (existence, degree,
  injectivity), and the conditional theorem now lists every input.

A minor point (the `prop:sphere-sgn` proof assumed more than its
stated hypothesis) is also corrected.

## Next

Independent **re-validation** of the revised `refoundation.tex`, then
Phase 3 (Lean) — each gated on the previous returning GREEN.
