# Fork A re-foundation of the Frankl cohomology

This directory holds the **Fork A re-foundation** of the cohomological
arc of the union-closed (Frankl) program — work item **mg-c15b**
(Frankl-ForkA-Refound-LaTeX), **Phase 1: the LaTeX re-foundation**,
**revised twice**: under **mg-365e** (Frankl-ForkA-Phase2-Revision)
per the **mg-d300** independent Phase-2 validation, and under
**mg-894c** (Frankl-ForkA-Phase2-Revision2) per the **mg-5221**
independent Phase-2 re-validation.

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
| `Fobs-spectral-sequence.tex` | the `F_obs` cell-level spectral sequence, pinned (P0 — `mg-02b5`) |
| `README.md` | this file |

## Building

```
pdflatex refoundation
pdflatex refoundation
```

It is **self-contained**: its own preamble, no bibliography, no
external inputs. It does **not** modify the consolidated paper
(`../main.tex`), which honestly records the pre-Fork-A state.

## Verdict (Phase 1, as corrected by the mg-365e and mg-894c revisions)

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

- **R1** — the `Y1` cofiber residual, **three-part**: **R1a** the
  cofiber cohomology (as a target object, unchanged from pre-Fork-A);
  **R1b** a new `S_{n-1}→S_n` branching step the `(Z/2)^n→S_n`
  re-grading creates (the `Y1` cofiber-LES reduction is only
  `Stab(x)≅S_{n-1}`-equivariant, not `S_n`-equivariant); **R1c** the
  twisted-bridge null-homotopy `ι_x* ≃ 0` — a `χ_S`-isotype-sub-complex
  fact the ported bridge does **not** discharge in Fork A (Fork A
  drops the `(Z/2)^n`-action, so there is no `V_S^*` sub-complex for
  it to live on), also created by the `(Z/2)^n→S_n` re-grading;
- **R2** — the `Y2` landing / separation of the obstruction from the
  sphere class (Fork A re-opens this: the pre-Fork-A `Y2` mechanism
  rested on the now-dropped `(Z/2)^n`-equivariance);
- **R3** — faithfulness, a **three-part** debt on the
  Čech-to-cohomology edge map: **R3a** existence, **R3b** degree-`n-1`
  landing, **R3c** injectivity (the `V3` / wrapper-risk question).

Owed debt 1 (the re-grading) is **addressed**; owed debt 2
(faithfulness) is **localized** to R3. After the mg-894c exhaustive
Walsh-fact sweep the conditional theorem's input list — R3a, R3b, R3c,
R2, and R1 (= R1a + R1b + R1c) — is **complete and final**.

See `refoundation.tex` §0 for the full scorecard and the revision
callouts, `docs/Frankl-ForkA-Refound-LaTeX.md` for the Phase-1 ledger
note, `docs/Frankl-ForkA-Phase2-Revision.md` for the mg-365e revision
ledger note, and `docs/Frankl-ForkA-Phase2-Revision2.md` for the
mg-894c revision ledger note (which also carries the exhaustive
portable-Walsh-fact sweep).

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

## The mg-894c revision

The independent Phase-2 **re-validation** (`mg-5221`,
`docs/Frankl-ForkA-Phase2-Revalidation.md`) returned **AMBER**: the
three mg-365e fixes landed and the spine was re-confirmed sound, but a
**third over-claim of the identical shape** survived — the
twisted-bridge null-homotopy `ι_x* ≃ 0`, presented in Construction
`constr:bridge` as a discharged, ported input. It is a
`χ_S`-isotype-sub-complex fact (`mg-56b8` §3.2, §8.1) with no Fork A
referent, since Fork A drops the `(Z/2)^n`-action and so has no
`V_S^*` sub-complex. This revision corrects it by honest re-statement
(no new math, no refutation):

- **`constr:bridge`** is re-stated — it now ports only the geometric
  prism operator `h`; the twisted-bridge null-homotopy is demoted to
  the open sub-residual **R1c** (new Remark `rem:bridge-not-ported`).
- **`thm:y1-reduction`** now reduces `Y1`-A to **three** steps (R1a,
  R1b, R1c), and the simultaneous-induction base case (`n = 2`) is
  stated.
- An **exhaustive sweep** of every fact in `refoundation.tex` ported
  from the pre-Fork-A Walsh / `χ_S`-isotype-graded framework was
  carried out, certifying there is **no fourth prong** — every ported
  Walsh fact has a genuine Fork A referent, is explicitly dropped, or
  is a named residual. The sweep is the §2 ledger of
  `docs/Frankl-ForkA-Phase2-Revision2.md`.

A minor point (the punctured-poset-to-`F⋆` extension inside
`prop:fact-one`) is also made explicit.

## P0 — the `F_obs` cell-level spectral sequence (`Fobs-spectral-sequence.tex`)

The `mg-0882` residual-closing roadmap
(`docs/Frankl-ForkA-Residuals-Roadmap.md`) names one **prerequisite**,
**P0**, that gates all seven residuals: pin the cell-level
Bousfield–Kan / spectral-sequence model of the obstruction sheaf
`F_obs` — the infrastructure `refoundation.tex`'s `rem:holim-prereq`
explicitly defers ("the cell-level structure of `F_obs` and its
spectral sequence (not pinned here)").

`Fobs-spectral-sequence.tex` (work item `mg-02b5`) is P0. It pins: the
cell-level obstruction complex `F_obs` (supplying the definition
`def:obs-sheaf` left implicit); the Čech double complex of the trace
cover, verified a genuine bounded bicomplex; both spectral sequences,
with full convergence and pinned page structure (the named
`E₂ = Č H^p(U; ℋ^q(F_obs))`); and the cell-level `BK` model of
`H*(C_n;X)` as the comparison target for residual R3. One finding: the
trace cover is cell-level acyclic, so the spectral sequence
degenerates and the obstruction's non-triviality is carried entirely
by the comparison map (residual R3) — a sharpening of the
wrapper-risk, not a resolution.

**P0 is infrastructure, not a residual.** It closes no residual and
adds no hypothesis to `thm:contradiction`; the `mg-bf5c` "exactly
seven residuals" certification stands. See `Fobs-spectral-sequence.tex`
§0 for the scorecard and `docs/Frankl-ForkA-Fobs-SS-Pinning.md` for
the P0 ledger note.

## Next

A further independent **re-validation** of the twice-revised
`refoundation.tex` — carrying an explicit pattern-sweep mandate to
audit the mg-894c Walsh-fact sweep — then the residual-closing work
(now unblocked at Checkpoint 0 by P0) and Phase 3 (Lean), each gated
on the previous returning GREEN.
