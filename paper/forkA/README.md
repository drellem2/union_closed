# Fork A re-foundation of the Frankl cohomology

This directory holds the **Fork A re-foundation** of the cohomological
arc of the union-closed (Frankl) program — work item **mg-c15b**
(Frankl-ForkA-Refound-LaTeX), **Phase 1: the LaTeX re-foundation**.

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

## Verdict (Phase 1)

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
contradiction rests on three precisely named open residuals:

- **R1** — the `Y1` cofiber residual (unchanged from pre-Fork-A);
- **R2** — the `Y2` landing / separation of the obstruction from the
  sphere class (Fork A re-opens this: the pre-Fork-A `Y2` mechanism
  rested on the now-dropped `(Z/2)^n`-equivariance);
- **R3** — faithfulness, the injectivity of the Čech-to-cohomology
  edge map (the `V3` / wrapper-risk question).

Owed debt 1 (the re-grading) is **addressed**; owed debt 2
(faithfulness) is **localized** to R3.

See `refoundation.tex` §0 for the full scorecard and
`docs/Frankl-ForkA-Refound-LaTeX.md` for the research-ledger note.

## Next

Phase 2 (independent validation of `refoundation.tex`), then Phase 3
(Lean) — each gated on the previous returning GREEN.
