# Frankl-ForkA-Refound-LaTeX — re-founding the Frankl cohomology on Fork A (Phase 1, LaTeX)

**Work item:** `mg-c15b` (Frankl-ForkA-Refound-LaTeX). Per a Daniel
reminder 2026-05-22: *'frankl - commit'* — Daniel committed to the
Fork A re-foundation, the route the vision-check (`mg-6edc`) and the
`n=3` Fork-D probe (`mg-565a`) resolved to. This is **Phase 1**, the
LaTeX re-foundation (math-before-Lean: LaTeX, then independent
validation, then Lean).

**READ-FIRST consumed:** `docs/Frankl-ForkD-Probe-n3.md` (`mg-565a` —
the Fork A endorsement and its two owed debts); `docs/Frankl-vision-check.md`
(`mg-6edc`); `docs/Frankl-Y1-phase1.5-bk-structure-maps.md` (`mg-0405`
— the two refutations and the pinned projection `π_T`);
`docs/Frankl-Y1-reprove.md` (`mg-56b8` — the cofiber-LES reduction of
`Y1`); the union-closed LaTeX paper (`paper/sections/00`–`07`);
`docs/PROOF-STRUCTURE-ONBOARDING.md`.

**Deliverable:** `paper/forkA/refoundation.tex` — the standalone Fork A
re-foundation LaTeX document (Phase 1) — plus `paper/forkA/README.md`
and this ledger note. The consolidated paper (`paper/main.tex`) is
**not** edited: it honestly records the pre-Fork-A state.

---

## §0 — Verdict (top of page)

> **GREEN — FORK-A-REFOUNDATION-DELIVERED (Phase 1).** The Frankl
> cohomology is re-founded on Fork A in LaTeX. The covariant homotopy
> colimit `H*(C_n;X)` is a **genuinely defined** cohomology object
> (its structure map is the trace projection `π_T`, which exists and
> is functorial) — this dodges the Phase-1.5 against-trace refutation
> *by construction*. The `(Z/2)^n`-action is **dropped** — this
> *dissolves* the Phase-1.5 `(Z/2)^n` refutation outright (there is no
> group action left to fail). The grading is re-established by Maschke
> for the genuine `S_n`-action, with the sphere class identified as the
> `sgn_{S_n}` isotype. The obstruction class and the two-part
> contradiction are re-established as a **conditional theorem**.
> **Frankl is NOT proved, and Phase 1 was never meant to prove it.**
> The verdict GREEN is for the Phase-1 scope — the re-foundation is
> delivered and internally sound. The contradiction rests on **three
> precisely named open residuals**: R1 (`Y1` cofiber, unchanged from
> pre-Fork-A), R2 (`Y2` landing — Fork A re-opens it), R3
> (faithfulness / the Čech-to-cohomology edge map). Owed debt 1 (the
> re-grading) is **addressed**; owed debt 2 (faithfulness) is
> **localized** to R3.

### The scorecard

| Component | Status | Note |
|---|---|---|
| Covariant cohomology object `H*(C_n;X)` | **GREEN** | Genuinely defined; `D²=0` verified. Phase-1.5 refutation (a) dodged by construction. |
| Dropping the `(Z/2)^n`-action | **GREEN** | Phase-1.5 refutation (b) dissolved, not repaired. |
| `S_n`-grading by isotype (Maschke) | **GREEN** | Genuine `S_n`-action; sphere class = `sgn_{S_n}`. |
| Obstruction class re-founded | **GREEN** | As a construction, on the well-defined object. |
| `Y1`-A (the vanishing) — residual R1 | **RED — open** | Cofiber-LES reduction ports; the residual is unchanged. |
| `Y2`-A (the landing) — residual R2 | **AMBER — open** | Structural mechanism re-derives; the separation from the sphere class is localized. |
| Owed debt 1 — the re-grading | **ADDRESSED** | Structural re-grading discharged; residue = R2. |
| Owed debt 2 — faithfulness (`V3`) — R3 | **LOCALIZED** | One named object: injectivity of the edge map. |

---

## §1 — What Fork A is, and what Phase 1 did

**Fork A** (per `mg-0405` §6, `mg-6edc` §§6–7, `mg-565a` §§6–7): keep
the trace category `C_n` and the per-family cubical-defect complexes
`X(F)`; **fix the variance** — replace the undefined contravariant
hocolim with the **covariant** `hocolim_{C_n} X` whose structure map is
the canonical trace **projection** `π_T : X(F) → X(F|_T)`; **drop** the
`(Z/2)^n`-action and grade by `sgn_{S_n}`; keep Walsh only as the
harmonic description of the obstruction cochain.

Phase 1 carried this out in `paper/forkA/refoundation.tex`:

1. **The construction.** `π_T` is pinned as a covariant functor
   `X : C_n → Ch` (ported from `mg-0405` Prop. 3.6, with full proof).
   The covariant homotopy colimit and its Bousfield–Kan cochain double
   complex are constructed, and `D² = 0` is verified explicitly. The
   object `H*(C_n;X)` is **genuinely defined** — where the pre-Fork-A
   `X^∩_n` was undefined.

2. **The re-grading.** The `(Z/2)^n`-action is dropped. The genuine
   `S_n`-action on `C_n` and on the diagram `X` induces an `S_n`-action
   on the total complex; by Maschke, `H*(C_n;X)` decomposes into
   `S_n`-isotypes — the genuine analogue of the old Walsh
   decomposition, for the group that genuinely acts. The sphere class
   (if the cohomology is spherical) is forced to be the `sgn_{S_n}`
   isotype — the orientation character; the old target's `χ_{[n]}`
   tensor factor was redundant `(Z/2)^n`-decoration.

3. **The obstruction class and the contradiction.** The Čech double
   complex of the obstruction sheaf `F_obs` is re-founded verbatim on
   the new object; `ob(F⋆) ∈ H^{n-1}(C_n;X)`. The two-part
   contradiction is re-established as a **conditional theorem** resting
   on three open inputs (R1, R2, R3).

---

## §2 — The two owed debts

### Owed debt 1 — the re-grading: ADDRESSED

The **structural** re-grading is fully discharged: `(Z/2)^n` dropped,
Maschke `S_n`-decomposition established, sphere class = `sgn_{S_n}`,
`Y1` re-stated as re-graded sphere concentration, the cofiber-LES
reduction ported. The **one open part** is residual R2 (see below): the
re-grading correctly *surfaces* that the pre-Fork-A `Y2` landing
mechanism rested on the now-dropped `(Z/2)^n`-equivariance and must be
genuinely re-derived — it is not a free re-labelling.

### Owed debt 2 — faithfulness (`V3` / wrapper-risk): LOCALIZED

Reduced to a single named object — **residual R3**: the injectivity of
the Čech-to-cohomology edge map. If injective, the equivalence
`ob = 0 ⟺ a global rare-coordinate section exists` is genuine and the
cohomology genuinely detects the counterexample (`V3` satisfied); if
not, `ob` is family-blind and the contradiction is hollow. The
hocolim-vs-holim question is a sharpening of R3, not a separate debt.

---

## §3 — The three open residuals

- **R1 — `Y1`-A (the vanishing).** The isotype cohomology of the
  cofiber of the matched-cylinder inclusion — the homotopy type of the
  stuck-family fibres. **Unchanged** from the pre-Fork-A residual
  (`mg-56b8`); the genuine open Frankl content; multi-week-plus.

- **R2 — `Y2`-A (the landing).** Whether the obstruction class
  `ob(F⋆)` avoids the `sgn` sphere-class isotype of `H^{n-1}`. The
  pre-Fork-A `Y2` got this for free from the Walsh-level grading
  (`ob` at level 1, sphere at level `n`); Fork A drops Walsh level as
  a grading of cohomology, so the separation must be re-established.
  Phase 1 establishes the structural mechanism (the obstruction
  factors through bias *differences*; the obstruction cochain is
  level-1 harmonic) but localizes the separation: it reduces to a
  representation-theoretic property of the obstruction sheaf `F_obs`.
  It is faithfulness-flavoured (if `ob` had a `sgn`-component it would
  be partly the family-blind orientation class).

- **R3 — faithfulness.** Owed debt 2 (above).

**Honesty note.** An earlier draft of `refoundation.tex` asserted a
clean theorem — *`ob(F⋆)` is standard-isotypic, hence `sgn`-free*. On
re-examination that proof tacitly assumed the coefficient sheaf
`F_obs^q` is `S_n`-trivial, which is not justified. The over-claim was
**caught and withdrawn** before submission; R2 is the honest residual
in its place. Recording this is deliberate — the same over-claim
discipline that caught the invalid `Y1` proof (UC13 §4.5) and the
false `R2` lemma (UC14) applies here.

---

## §4 — What this changes for the project record

- The cohomological arc has a **sound foundation** again: `H*(C_n;X)`
  is a genuinely defined object, where the pre-Fork-A `X^∩_n` was
  undefined (`mg-0405`). Both Phase-1.5 refutations are cleared — (a)
  by construction, (b) by dissolution.
- `Y1` stays `RED — open`: the residual is unchanged, now correctly
  housed on a well-defined object.
- `Y2` is **re-opened** honestly: the pre-Fork-A "mechanism-sound"
  status rested partly on the `(Z/2)^n`-equivariance that `mg-0405`
  refuted; Fork A re-states the landing in `S_n` terms and localizes
  the genuine open part (R2).
- No Lean change, no edit to `paper/main.tex`, no new axiom. The Lean
  headline `Frankl_Holds`'s dependence on
  `case3_ss_obstruction_paper_axiom` is unaffected. The Zulip post
  stays held.

---

## §5 — Recommendations (routed to Daniel via pm-onethird)

1. **Proceed to Phase 2** — independent validation of
   `paper/forkA/refoundation.tex`. The Phase-1 gate is GREEN. Phase 2
   should default-skeptically check the construction theorems
   (`π_T` a functor; `D²=0`; the `S_n`-equivariance of `D`) and — with
   special care, given the withdrawn over-claim — the honesty of the
   `Y2`-A section (that only the structural mechanism is proved and R2
   is genuinely open).
2. **R1 (`Y1` cofiber) and R3 (faithfulness edge map)** are
   independent and can be attacked in parallel as separate tickets,
   after first pinning the cell-level spectral sequence of `F_obs`.
3. **R2 (`Y2` separation)** should be attacked together with R3 — they
   are facets of one faithfulness question; a representation-theoretic
   analysis of `F_obs` feeds both.
4. **Do not Lean-formalize yet** (Phase 3 is gated on Phase 2 GREEN).
5. **`paper/main.tex` stays as-is.** Once Phase 2 validates the
   re-foundation, a later pass may fold it into the paper, superseding
   §§3–4.

---

## §6 — Cross-references

- **Brief:** `mg-c15b`. **Routes to:** Daniel, via `pm-onethird`.
- **Deliverable:** `paper/forkA/refoundation.tex` (+ `paper/forkA/README.md`).
- **Fork A endorsement / the two debts:** `docs/Frankl-ForkD-Probe-n3.md`
  (`mg-565a`).
- **The drift diagnosis / fork menu:** `docs/Frankl-vision-check.md`
  (`mg-6edc`).
- **The Phase-1.5 refutations / the pinned projection `π_T`:**
  `docs/Frankl-Y1-phase1.5-bk-structure-maps.md` (`mg-0405`).
- **The cofiber-LES reduction of `Y1`:** `docs/Frankl-Y1-reprove.md`
  (`mg-56b8`).
- **Onboarding:** `docs/PROOF-STRUCTURE-ONBOARDING.md`.

---

*Phase-1 re-foundation by polecat `cat-mg-c15b`. Deliverables on
`main`: `paper/forkA/refoundation.tex`, `paper/forkA/README.md`, and
this note. Verdict: **GREEN — FORK-A-REFOUNDATION-DELIVERED (Phase 1).**
The Frankl cohomology is re-founded on Fork A: the covariant homotopy
colimit `H*(C_n;X)` is genuinely defined (dodging Phase-1.5 refutation
(a) by construction), the `(Z/2)^n`-action is dropped (dissolving
refutation (b)), the `sgn_{S_n}` re-grading is carried out, and the
obstruction class and two-part contradiction are re-established as a
conditional theorem resting on three precisely named open residuals —
R1 (`Y1` cofiber, unchanged), R2 (`Y2` landing, re-opened and
localized), R3 (faithfulness / edge map). Owed debt 1 (re-grading) is
addressed; owed debt 2 (faithfulness) is localized. Frankl is not
proved; Phase 1 was not meant to prove it. An over-claim in an earlier
draft (a clean "standard-isotypic" landing theorem) was caught and
withdrawn. Recommended next: Phase 2, independent validation.*
