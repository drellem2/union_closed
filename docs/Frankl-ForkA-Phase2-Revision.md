# Frankl-ForkA-Phase2-Revision — revising refoundation.tex per the mg-d300 validation

**Work item:** `mg-365e` (Frankl-ForkA-Phase2-Revision). Per the
`mg-d300` (Frankl-ForkA-Phase2) **AMBER** independent validation of the
Fork A re-foundation. This is the honest-re-statement revision that
clears the two over-claims `mg-d300` caught, before an independent
re-validation and Phase 3 (Lean).

**READ-FIRST consumed:** `docs/Frankl-ForkA-Phase2-validation.md`
(`mg-d300` — the validation report; §6.2 is the precise revision spec);
`paper/forkA/refoundation.tex` (the deliverable being revised);
`docs/Frankl-ForkA-Refound-LaTeX.md` (`mg-c15b` — the Phase-1 ledger
note).

**Deliverable:** the revised `paper/forkA/refoundation.tex`, plus
`paper/forkA/README.md` brought into line, plus this ledger note. The
consolidated paper (`paper/main.tex`) is **not** edited.

---

## §0 — What this revision is

`mg-d300` independently validated the Phase-1 Fork A re-foundation and
returned **AMBER — FORK-A CORE SOUND; THE Y1 REDUCTION DOES NOT PORT
CLEANLY, AND THE RESIDUAL SET IS NOT EXACTLY THREE.** The GREEN spine
was independently confirmed (the trace projection `π_T` a genuine
covariant functor; `H*(C_n;X)` genuinely defined with `D²=0`; the
`(Z/2)^n` dissolution genuine; the Maschke `S_n` re-grading correct;
the conditional contradiction a valid conditional). But two over-claims
survived into the submitted draft that the `mg-c15b` self-audit had not
caught.

`mg-d300` was explicit that **both findings are fixable by honest
re-statement, not refutations** — the Fork A strategy stays sound. This
revision is exactly that re-statement. **No new mathematics; no change
to the construction; no change to the strategy.** The Fork A object,
the re-grading, and the conditional contradiction are all unchanged in
substance — what changes is the *accounting* of what the contradiction
rests on.

---

## §1 — Finding A: the Y1-A reduction does not port unchanged

**The over-claim.** Theorem `thm:y1-reduction` asserted that the
cofiber long exact sequence of the pair `(X_n, X_{n-1,x})` is
**`S_n`-equivariant**, and split it into `S_n`-isotypes via the
`S_n`-Maschke theorem `thm:maschke`. The scorecard, the
delivered-content list, and the residual `R1` all carried the claim
"`R1` unchanged from the pre-Fork-A state / the reduction ports."

**Why it is wrong.** The smaller object `X_{n-1,x}` is the Fork A
complex of the subcategory `C_{n-1,x}` of pointed families with ground
set inside `[n]\{x}`. A relabelling `π ∈ S_n` carries ground set
`S ⊆ [n]\{x}` to `πS ⊆ [n]\{π(x)}`, so `π` preserves `C_{n-1,x}` iff
`π(x) = x`. The pair, the inclusion `ι_x`, and the whole cofiber LES
are stable exactly under the point stabiliser `Stab(x) ≅ S_{n-1}` —
**not** under `S_n`. The pre-Fork-A reduction split isotype-by-isotype
only because the *abelian* `(Z/2)^n` factors as a direct product
`(Z/2)^{[n]\{x}} × (Z/2)_x` and therefore has a **quotient** acting on
the smaller cube; `S_n` has no analogous quotient (`Stab(x)` is a
*subgroup*, not a quotient). The abelian product structure that made
the pre-Fork-A reduction work is exactly what Fork A discards when it
drops `(Z/2)^n`.

**The re-statement.** Theorem `thm:y1-reduction` now states the LES as
`Stab(x) ≅ S_{n-1}`-equivariant only, and reduces `Y1`-A to **two**
steps: (a) control of the `S_{n-1}`-isotype cohomology of the cofiber,
and (b) an induction–restriction (branching) step recovering the
`S_n`-isotype structure of `H̃^{n-1}(C_n;X)` — in particular its
`sgn_{S_n}`-content — from the `S_{n-1}`-equivariant data. The
branching step is genuinely lossy: `sgn_{S_{n-1}}` is the restriction
of `sgn_{S_n}` but is *also* a constituent of the restriction of other
`S_n`-irreducibles, so an `S_{n-1}`-isotype computation does not
determine the `S_n`-isotype decomposition. `R1` is now **two-part**:

- **R1a** — the cofiber cohomology. As a *target object* unchanged
  from the pre-Fork-A state.
- **R1b** — the `S_{n-1}→S_n` branching step. A genuinely **new**
  sub-residual created by the `(Z/2)^n→S_n` re-grading; it did not
  exist in the pre-Fork-A development. It is the `Y1`-side mirror of
  the way dropping `(Z/2)^n` re-opens the `Y2` landing as `R2`.

New material in `refoundation.tex`: the two-part statement of
`thm:y1-reduction`; a new Remark `rem:y1-branching` (why only
`Stab(x)`-equivariance, the `(Z/2)^n`-vs-`S_n` quotient asymmetry, and
the branching step); the rewritten Open residual `res:y1` (R1a + R1b);
and a re-stated `status:y1a` and `status:c-block` (the latter now
records the cost on *both* halves of the contradiction).

---

## §2 — Finding B: the residual set is not exactly three

**The over-claim.** The headline claimed the conditional contradiction
"rests on exactly three precisely named residuals R1/R2/R3, no hidden
assumption, no fourth gap." But the obstruction class `ob(F⋆)` is
defined (Definition `def:ob`) by promoting the mismatch cocycle through
an **edge map** whose existence and degree behaviour Remark
`rem:promotion` itself admits are "not discharged here." The formally
stated `R3` (Owed debt `debt:faithful-localized`) and the conditional
theorem `thm:contradiction` hypothesis (i) named only **injectivity**.

**Why it is a gap.** Edge-map **existence** is needed for `ob(F⋆)` to
be an element of `H̃^{n-1}(C_n;X)` at all — for Fact One and the
conditional theorem to *have a subject*. Edge-map **degree behaviour**
(that `ob(F⋆)` lands in degree `n-1` specifically) is what makes the
sphere-concentration residual `R1` apply to it; the document inherits
the degree count `n-1` from the now-defunct pre-Fork-A object
`X^∩_n`, never re-verifying it in the genuinely different Fork A
object. The edge map also crosses a genuine object mismatch: the Čech
complex lives on the *punctured* trace poset `C_n(F⋆)\{F⋆}` while
`ob(F⋆)` is asserted to land in the cohomology of the *whole* category.

**The re-statement.** `R3` is now an explicit **three-part** edge-map
debt:

- **R3a** — edge-map *existence* (the promotion is a defined map);
- **R3b** — *degree-`n-1`* landing;
- **R3c** — *injectivity* (the original faithfulness statement).

R3c is the original `R3`; R3a and R3b are its logical prerequisites.
The conditional theorem `thm:contradiction` now lists **all five**
inputs in full — (i) R3a, (ii) R3b, (iii) R3c, (iv) R2, (v) R1 — and
the "exactly three / Fork A removes the fourth" framing is dropped
throughout. Fork A trades the unconstructed `(Z/2)^n`-action for the
edge-map existence/degree debt, so it is **not** a clean reduction in
the count of open inputs, and the revised document no longer claims
one.

New / re-stated material: the three-part `debt:faithful-localized`; the
rewritten `thm:contradiction` (five enumerated inputs) and its proof;
`prop:fact-one` and `status:fact-one` (now conditional on existence +
degree + injectivity); `def:ob` (membership flagged conditional);
`rem:promotion` (the object mismatch made explicit); the §0.2 scorecard
rows for the obstruction cocycle and Owed debt 2.

---

## §3 — Minor point: prop:sphere-sgn

`mg-d300` §5.1 (non-load-bearing): Proposition `prop:sphere-sgn` had
hypothesis "`H*(C_n;X)` is rationally a homotopy `(n-1)`-sphere" — a
bare dimension count — but its proof concluded `≅ sgn_{S_n}` by
treating the 1-dimensional space as the orientation class of a sphere
"built `S_n`-symmetrically from `n` coordinate directions." The bare
dimension count does not supply that structure: a 1-dimensional
`Q[S_n]`-module may a priori be trivial. The hypothesis is now
strengthened to include the `S_n`-equivariant coordinate-sphere
structure the proof uses (equivalently: that one transposition acts by
`−1`), and a new Remark `rem:sphere-sgn-hyp` records why. `prop:sphere-sgn`
is not load-bearing — `thm:contradiction` uses `conj:y1a` directly —
so this is a tidy-up, not a correction to the contradiction.

---

## §4 — What this revision leaves untouched

- The **construction** — `π_T` as a covariant functor
  (`thm:projection`), the Bousfield–Kan double complex and `D²=0`
  (`thm:welldefined`), the Maschke `S_n`-decomposition (`thm:maschke`),
  the `Y2`-A structural mechanism (`prop:y2a-mech`). `mg-d300`
  independently confirmed all of these sound; the revision does not
  touch them.
- The **Fork A strategy** — the covariant hocolim re-foundation, the
  `(Z/2)^n` drop, the `sgn_{S_n}` re-grading. Unchanged and endorsed.
- The Phase-1 self-correction — the withdrawn "standard-isotypic"
  landing over-claim — stays withdrawn; `R2` stays as the honest
  residual. `mg-d300` confirmed that self-correction was correct.
- No Lean change; no edit to `paper/main.tex`; no new axiom. The Lean
  headline `Frankl_Holds`'s dependence on
  `case3_ss_obstruction_paper_axiom` is unaffected.

After this revision the conditional theorem `thm:contradiction` rests
on, and explicitly lists: **R1** (now two-part — R1a the cofiber, R1b
the `S_{n-1}→S_n` branching step), **R2** (the landing), and **R3**
(three-part — R3a existence, R3b degree, R3c injectivity of the edge
map).

---

## §5 — Recommendations (routed to Daniel via pm-onethird)

1. **Independent re-validation** of the revised `refoundation.tex`. The
   re-validation should default-skeptically confirm the correction is
   complete and honest — that `thm:y1-reduction` now claims only
   `S_{n-1}`-equivariance and R1b is genuinely recorded; that
   `thm:contradiction` lists every input including the three-part R3;
   and that the GREEN spine (`thm:projection`, `thm:welldefined`,
   `thm:maschke`, `prop:y2a-mech`) is undisturbed.
2. **Then Phase 3 (Lean)**, gated on the re-validation returning GREEN.
3. **The residual-closing work** can be scoped now with the corrected
   picture: R1 carries the added `S_{n-1}→S_n` branching step R1b
   beside the cofiber R1a; R3 is three sub-problems (existence and
   degree upstream of injectivity). The recommendation to attack R2 and
   R3 together (both faithfulness-flavoured) stands and is reinforced.
4. **`paper/main.tex` stays as-is** (it honestly records the
   pre-Fork-A state) — unchanged from the Phase-1 recommendation.

---

## §6 — Cross-references

- **Brief:** `mg-365e` (Frankl-ForkA-Phase2-Revision). **Routes to:**
  Daniel, via `pm-onethird`.
- **The Phase-2 validation being acted on:**
  `docs/Frankl-ForkA-Phase2-validation.md` (`mg-d300`; §3 Finding A,
  §4 Finding B, §5.1 the minor point, §6.2 the revision spec).
- **The deliverable revised:** `paper/forkA/refoundation.tex`
  (+ `paper/forkA/README.md`).
- **The Phase-1 ledger note:** `docs/Frankl-ForkA-Refound-LaTeX.md`
  (`mg-c15b`).
- **Fork A endorsement / the two debts:**
  `docs/Frankl-ForkD-Probe-n3.md` (`mg-565a`).
- **The pre-Fork-A cofiber-LES reduction of `Y1`:**
  `docs/Frankl-Y1-reprove.md` (`mg-56b8`).
- **The Phase-1.5 refutations:**
  `docs/Frankl-Y1-phase1.5-bk-structure-maps.md` (`mg-0405`).
- **Onboarding:** `docs/PROOF-STRUCTURE-ONBOARDING.md`.

---

*Phase-2-validation revision by polecat `cat-mg-365e`. Deliverables on
`main`: the revised `paper/forkA/refoundation.tex`, the updated
`paper/forkA/README.md`, and this ledger note. The revision is an
honest re-statement of two over-claims the `mg-d300` independent
validation caught — (A) the `Y1`-A cofiber-LES reduction is only
`Stab(x) ≅ S_{n-1}`-equivariant, not `S_n`-equivariant, so `R1`
acquires the `S_{n-1}→S_n` branching sub-residual `R1b`; (B) the
residual set is not "exactly three" — `R3` is a three-part edge-map
debt (existence, degree, injectivity), and `thm:contradiction` now
lists every input in full — plus a minor `prop:sphere-sgn` hypothesis
tidy-up. No new mathematics: the Fork A construction, the re-grading,
and the conditional contradiction are unchanged in substance; the Fork
A strategy stays sound. Recommended next: independent re-validation of
the revised document, then Phase 3 (Lean).*
