# Frankl Conjecture — Vision

*Canonical vision for the Frankl arc. Authored by pm-onethird, owner of the vision per Daniel's 2026-05-23 directive. Updates require explicit Daniel input; no silent re-interpretation. Mirrored in pm-onethird's agent memory (`project_frankl_vision.md`).*

## Daniel's vision, verbatim

> my original vision was: take minimal counterexample, show by inclusion exclusion it induces non trivial cohomology in the category of families. Separately prove some result about the cohomology of the category to achieve a contradiction. This program still sounds viable and UNTRIED.

— Daniel, 2026-05-23T04:17Z reminder, restating the original vision after observing extensive drift in prior arcs.

## The four load-bearing parts

1. **Minimal counterexample F\*** — a hypothetical Frankl counterexample (union-closed, no element in at least half the members).
2. **Inclusion-exclusion mechanism applied to F\*** — F\*'s specific structure, fed through an IE / Möbius-type construction, generates an invariant.
3. **The generated invariant IS a non-trivial cohomology class** somewhere in the category of families. The class is *induced* by F\* — counterexample-specific, not a generic property of the category.
4. **A separate result about the cohomology of the category** contradicts the existence of that non-trivial class. Contradiction.

## Status — 2026-05-23

**The vision is UNTRIED.** Multiple prior arcs (UC10-UC14, Fork D, Fork A) probed *adjacent* objects — generic category-level cohomology, per-family complexes, downset variants — and found them trivial across 15 natural constructions (mg-5cc6 synthesis). The drift was extreme: none of those 15 constructions tested step 2 → step 3 of the vision. The first genuine attempt at the vision is filed as **mg-e466 (Frankl-IE-Induction-Probe)**.

The 15-construction findings remain valid as facts about adjacent objects — they do **not** refute the vision; they refute drifted approximations of it.

## Update protocol

- Updates to this document require an explicit Daniel restatement (reminder, mail, or direct edit), recorded verbatim with date.
- Prior versions are annotated as superseded, not overwritten silently.
- Every Frankl ticket brief references this document and must state which of the four parts (or which sub-step) it realizes; tickets that cannot cleanly answer that are vision-drifted and need reshaping.
- Polecat verdict relays lead with vision-alignment (does the deliverable's central object match the vision-verbatim?), not just GREEN/RED on the math. A trivial result from a drifted probe carries no weight against the vision; only a vision-matched probe's result does.

## Cross-references

- `paper/forkA/refoundation.tex` — the Fork A re-foundation document (which probed an adjacent object; trivial; does not refute the vision).
- `docs/Frankl-Cohomology-Synthesis.md` — mg-5cc6 consolidated synthesis of the 15 prior constructions.
- `docs/Frankl-ELI5-Trivial-Cohomology.md` — mg-8886 ELI5 of why trivial cohomology is the wrong shape for forced-class arguments; flags the un-probed graded-Möbius angle which converges with this vision.
- `docs/Frankl-Y1-reprove.md` — mg-56b8 Y1 reduction (the unchanged hard core of the prior two-part contradiction).
- pm-onethird agent memory `project_frankl_vision.md` — the mirrored canonical vision.
