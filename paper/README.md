# Union-Closed (Frankl) — consolidated LaTeX paper

This directory holds the referee-grade LaTeX consolidation of the
union-closed (Frankl) development — the UC1–UC14 research ledger plus
the four audit notes — produced under work item **mg-335b**
(Frankl-LaTeX-Paper), following the *math-before-Lean* directive.

## What this paper is

A single coherent paper that consolidates the two arcs of the program:

1. **The combinatorial reduction arc (UC1–UC8)** — the
   compatibility-geometry framework, the transport identity, the
   trace-partition theorem, large-fibre localisation, the trace-defect
   scalar and interlock, and the boundary conservation law. This arc
   reduces Frankl to one explicit finitary inequality and settles it on
   a growing hierarchy of structured sub-families.

2. **The cohomological arc (UC9–UC14)** — the equivariant cohomology of
   intersection-closed families, the trace-injectivity theorem, the
   Čech obstruction class, and the intended two-part contradiction.

## Honesty discipline

The paper is **honest about the current proof state** and does *not*
overclaim. In particular:

- **Frankl is not proved.** Both arcs reduce the conjecture to a named
  open object; neither residual is closed.
- **Y2** (the obstruction-class isotype landing) is *mechanism-sound*
  (machine-checked).
- **Y1** (the level-1 Walsh vanishing) is **open**. The UC13 §4.5 proof
  is invalid (trace-exactness vs cohomology-vanishing conflation); the
  honest re-derivation reduces Y1 to one named homotopy-colimit
  residual.
- **UC14 "R2"** is **false** and is recorded as such.
- The Lean headline `Frankl_Holds` rests on
  `case3_ss_obstruction_paper_axiom`, which is Frankl-in-disguise; the
  genuinely unconditional machine-checked content is the concrete
  full-powerset families at n = 3 and n = 4.

The internal verdict banners of UC13 ("Frankl closes unconditionally")
and UC14 ("R1+R2+R3 all closed") are **withdrawn** by this
consolidation. See §5 (the honest audit) and Appendix B (the status
ledger).

## Files

| File | Contents |
|------|----------|
| `main.tex` | preamble, title, abstract, includes |
| `sections/00-introduction.tex` | introduction, status summary, reader's guide |
| `sections/01-setup.tex` | bias, transport identity, dialects, Walsh decomposition |
| `sections/02-combinatorial.tex` | the combinatorial reduction arc (UC1–UC8) |
| `sections/03-cohomology.tex` | cohomology of intersection-closed families (UC9–UC12) |
| `sections/04-obstruction.tex` | the Čech obstruction and two-part contradiction (UC11, UC13) |
| `sections/05-proof-state.tex` | the honest audit: Y1, Y2, R2, the Lean state |
| `sections/06-residual.tex` | the named open residuals and outlook |
| `sections/07-appendix.tex` | notation index, component status ledger |
| `references.bib` | bibliography |

## Building

```
pdflatex main
bibtex main
pdflatex main
pdflatex main
```

The paper also compiles without `bibtex` (citations degrade to `[?]`).
It uses only standard packages (`amsart`, `amsmath`, `amssymb`,
`amsthm`, `mathtools`, `booktabs`, `longtable`, `enumitem`,
`hyperref`, `geometry`, `stmaryrd`, `xcolor`).

## Fork A re-foundation (in progress — separate document)

`main.tex` honestly records the **pre-Fork-A** state of the
cohomological arc. The arc's foundations were subsequently refuted
(Phase-1.5, `mg-0405`) and the re-foundation resolved to **Fork A**.
The Fork A re-foundation is a **separate, standalone document** in
`forkA/refoundation.tex` (work item `mg-c15b`, Phase 1 — the LaTeX
re-foundation); it does not modify this paper. Once that re-foundation
is independently validated (Phase 2), a later pass may fold it in,
superseding §§3–4 here. See `forkA/README.md`.

## Source notes

The mathematical content comes from `docs/union-closed-UC1..UC14-*.md`
and `docs/compat-geom-manifesto.md`, audited in
`docs/Frankl-Y2-obstruction-isotype-landing.md`,
`docs/Frankl-Y1-walsh-vanishing-audit.md`,
`docs/Frankl-Y1-reprove.md`, and
`docs/frankl-axiom-restructure-investigation.md`. This paper is a
consolidation and correction of that ledger, not new research; it does
not attempt to close either named residual.
