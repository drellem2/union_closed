# Frankl-Axiom-Restructure-Investigation — can `case3_ss_obstruction_paper_axiom` become a genuine sub-lemma, and how risky is the paper proof

**Work item:** `mg-39bc` (investigation + report; no Lean re-implementation — the
restructure, if pursued, is a separate follow-on).

**Trigger (Daniel verbatim, 2026-05-20, after reviewing the prospective Frankl
Zulip-post draft mg-f7b9; decision: the Zulip post should NOT go):**

> "I am not clear on why the axiom is not a meaningful sub-theorem or
> sub-lemma. If we structured things correctly this should be the case, and we
> should be able to point at our own proof and say we proved X and Y, which
> together prove the theorem. But we ran into a gap formalizing Y so we
> represented it here as an axiom — and we should check how risky the proof
> is."

This supersedes the `mg-980f` "keep B2+B3 as-is" conclusion: Daniel now
prioritises *the axiom being a genuine sub-lemma* over the mg-980f
defensibility ranking.

---

## §0 — Verdict (top of page)

### 0.1 Can the development be restructured so the axiom is a genuine sub-lemma? — **NO, not by re-stating the axiom; and not at all with today's Lean objects.**

The current axiom is not Frankl-equivalent because someone *chose a bad axiom
statement*. It is Frankl-equivalent because of a **structural feature of how
the Lean proof is built**, and that feature cannot be undone by editing the
axiom. Specifically:

- The Lean proof of `Frankl_Holds` is a proof by contradiction. It routes
  **both** the proved half and the axiomatised half through the **same
  cohomology object** `obstructionCohomClassChain F : Fin n → (BKTotal n).homology 0`.
- In that one object, the development **proves** `obstructionCohomClassChain F ≠ 0`
  for a counterexample (`obstructionCohomClassChain_ne_zero_of_counterexample`),
  and the axiom **asserts** `obstructionCohomClassChain F = 0` for a
  counterexample. These are exact negations of each other.
- In any proof by contradiction `A ∧ ¬A ⇒ goal`, if you *prove* one conjunct
  and *axiomatise* the other, you have axiomatised the goal. That is what
  happened. It is mechanical, not a framing accident.

To make the axiomatised half a genuine sub-lemma `Y` that is *strictly weaker
than Frankl*, `Y` must be a statement about a **different object** than the one
the proved half `X` lives in — the spectral-sequence abutment, or a
Walsh-isotype-refined chain group. **That object does not exist in Lean
today**, and cannot be written down without either (a) the multi-week
Walsh-isotype chain-encoding refactor or (b) the multi-month mathlib
SpectralObject infrastructure (TC-diamond-blocked). `mg-980f`'s finding on this
point is correct and is re-confirmed here. Stubbing the object does not help —
it just relocates the Frankl-equivalent content into a transport axiom (§4.3).

So: **the restructure Daniel wants is genuinely achievable, but it is not a
re-statement task. It requires building new Lean objects (path (a) or (b)).**
Until that is done, the honest description of the current artefact is *not*
"we proved X and Y, together they prove Frankl" — it is "we proved X, and we
assumed something that, given X, is Frankl itself."

### 0.2 What is `Y` — the genuine mathematical content that is paper-proven but Lean-deferred?

`Y` is the **homological half** of the paper's two-part proof by contradiction.
Stated cleanly and standalone (§3):

> **Y (lower-Walsh cohomology vanishing).** For the bi-`(ℤ/2)ⁿ`-equivariant
> cubical-Walsh-defect complex `Xₙ∩`, every level-1 Walsh isotype of the
> degree-`(n−1)` reduced cohomology vanishes: `V_{x}^{n-1}(Xₙ∩) = 0` for every
> `x ∈ [n]` (`n ≥ 3`). Equivalently, in BK-bicomplex terms: the per-`x`
> `χ_x`-isotype graded piece of `Hⁿ⁻¹(Tot(BKBicomplexHC₂ n F))` is zero.

`Y` is genuinely **strictly weaker than Frankl**: it is a statement purely
about the cohomology of a fixed complex — it never mentions families, bias
`β_x`, or rare coordinates. A referee could assess `Y` without knowing what
Frankl's conjecture is. This is exactly the property the *current* axiom lacks.

The current axiom is **not** `Y`. It is the chain-level *transported* form of
`Y`, fused with a second deferred substep (the chain-encoding refinement), and
that fused chain-level statement — in the object where `X` is proved — collapses
to Frankl. `Y` itself does not.

### 0.3 Risk verdict on the paper proof of `Y` — **HIGH RISK. Not referee-grade. There is specific evidence the load-bearing step may be wrong.**

This is the "check how risky the proof is" Daniel asked for, probed genuinely
(§5). The headline findings:

1. **Meta-risk.** The "paper" is a chain of agent-generated `docs/*.md`
   research notes (UC1–UC14) with an internal GREEN/AMBER/RED verdict scaffold.
   It claims a **complete proof of the Frankl union-closed conjecture** — a
   famous open problem of ~45 years. It has never been refereed, published, or
   read by a human mathematician. The prior probability that such an artefact
   is a correct proof of Frankl is very low.

2. **The load-bearing step is a late "correction" that reverses an earlier
   draft.** The whole closure depends on UC13 §2.4.1, the "corrected landing":
   it asserts the obstruction class lands in **level-1** Walsh isotypes (which
   vanish). UC11 §5.3 — the earlier draft — had said it lands in the **top**
   isotype `V_{[n]}^{n-1}` (which does *not* vanish). UC13's verdict openly
   says "UC11 §5.3 was incorrect." A proof whose decisive step is a
   late-stage reversal of the opposite earlier claim is fragile.

3. **The Lean formalisation actively contradicts the corrected landing.**
   When the obstruction class was formalised, the natural encoding
   `obstructionClass F x := Finsupp.single (topVertex F) (β_x F)` places it on
   the **topVertex** — which the project's own Lean docstrings identify as the
   `χ_{[n]}` *top*-Walsh / `sgn` generator, **not** a level-1 isotype — and the
   team then **proved it non-zero** for a counterexample
   (`topVertex_not_coboundary`). The Lean encoding sides with the *abandoned*
   UC11 §5.3 picture and contradicts UC13 §2.4.1. The project's own per-x
   closure analysis states the axiom's conclusion is "propositionally
   equivalent to `topVertex_not_coboundary` FAILING" — i.e. **provably false
   in the encoding that was actually built.** The one serious attempt to
   machine-verify the load-bearing step produced its negation.

4. **Soft spots in the paper proof of `Y` itself.** UC13 §5.2 (top-Walsh
   concentration, part of UC10.1) says verbatim "We need a more careful
   argument," builds a "composite bridge" that "is not itself a single
   chain-level operator," and closes "modulo the standard hocolim coherence."
   UC13 §4.5 / Lemma 4.4.1 is a "Proof sketch … modulo lower-dimensional
   corrections." A whole follow-up note (UC14) exists solely to "tighten"
   three such residuals — confirming they were real gaps; UC14's "GREEN"
   closure of them is itself unrefereed agent output.

**Bottom line for Daniel.** We cannot be "EXTREMELY confident" in the proof of
`Y`. The honest status is: `Y`'s paper proof is an unrefereed, agent-generated
argument whose single load-bearing step the formalisation effort could not
reproduce and in fact contradicted. Not posting the Zulip draft was the correct
call. Before any external claim, `Y` (specifically UC13 §2.4.1, the corrected
landing) must be independently verified by a competent human, or formalised —
and the formalisation must be *allowed to land in whatever isotype the maths
actually forces*, not steered to the desired answer.

---

## §1 — Scope and method

This is an investigation and report. It does not change Lean code. It answers
the four questions in the `mg-39bc` brief:

1. Can the Frankl Lean development be re-structured so the axiom is a genuine
   sub-lemma `Y`, strictly weaker than Frankl, with the development decomposing
   as `X` (genuinely proved) + `Y` (axiomatised because of a formalisation
   gap), `X ∧ Y ⇒ Frankl`?
2. Identify precisely what `Y` is; state it as a clean standalone proposition.
3. Can the axiom be re-stated at the level of `Y` (the SS-level "B1" form) rather
   than the chain-level "B2+B3" form? If yes, describe the restructured shape;
   if no, explain rigorously why.
4. Risk-assess the proof of `Y`.

**Sources actually read for this report** (not just cited): the four
READ-FIRST docs (`PROOF-STRUCTURE-ONBOARDING.md`, `PaperAxioms.lean`,
`Frankl-disclosure-pivot-independent-audit.md` = mg-ee54,
`Frankl-axiom-optimization-research.md` = mg-980f); the Lean source
`Frankl.lean`, `UC11/SSConvergence.lean`, `UC11/CohomologyClass.lean`
(incl. `topVertex_not_coboundary`), `lean/AXIOMS.md`; the paper-side
`union-closed-UC13-frankl-closure.md` in full, `union-closed-UC14-*.md` head,
`union-closed-UC10-*.md` verdict/structure; and the
`state-UC-Lean-per-x-closure.md` (mg-36c3) RED structural-blocker analysis.

**Stance.** Default-skeptical, per Daniel's explicit instruction to "probe it
genuinely — do not just confirm it is cited." Where this report disagrees with
mg-980f's conclusion it says so and gives the reason.

---

## §2 — Why the current axiom is not a meaningful sub-lemma (the structural diagnosis)

This section answers Daniel's "I am not clear on *why* the axiom is not a
meaningful sub-lemma."

### 2.1 The proof-by-contradiction shape

`Frankl_Holds` (general case) is closed by deriving `False` from a hypothetical
counterexample `F`. The relevant fragment, from `Frankl.lean:267-318`
(`obstructionClass_cohomology_vanishing`) via
`SSConvergence.lean`, is:

```
X  (PROVED)  :  IsCounterexample F → obstructionCohomClassChain F ≠ 0
                  -- obstructionCohomClassChain_ne_zero_of_counterexample
Y' (AXIOM)   :  IsCounterexample F → obstructionCohomClassChain F = 0
                  -- case3_ss_obstruction_paper_axiom, via the y6 transport bridge
absurd       :  IsCounterexample F → False
hence        :  ∀ F, ¬ IsCounterexample F   =  Frankl
```

`X` and `Y'` are statements about the **same object**
`obstructionCohomClassChain F` and are **exact negations** of each other under
the same hypothesis.

### 2.2 The mechanical reason this is Frankl-in-disguise

Take any proof by contradiction of the form: prove `A`, assume `¬A`, conclude
`goal` from `A ∧ ¬A`. If `A` is a genuine theorem and you *axiomatise* `¬A`,
then your axiom `¬A` combined with the proved `A` yields `goal` directly — and
conversely `goal` makes the axiom hold vacuously. Your axiom is **equivalent to
`goal`**.

That is exactly the Frankl situation. `X` is genuinely proved. The axiom `Y'`
is `¬X` (under the counterexample hypothesis). Therefore:

```
axiom Y'  +  proved X   ⊢   ∀ F ¬IsCounterexample F   =   Frankl
Frankl                  ⊢   Y'   (vacuously: hypothesis never met)
```

The project already discloses this honestly: `AXIOMS.md` and the axiom
docstring carry the four-line Lean `example` that derives `False` from
`Y' + X`. The disclosure is good. But disclosure does not change the fact that
**the axiom is Frankl, not a sub-lemma.** "We proved `X` and `Y'`, together
they give Frankl" is not an honest description when `Y'` *is* Frankl.

### 2.3 The deeper point — and why this is not unique to the chain level

It is worth being precise, because it bears on whether *any* re-statement can
fix it. **In a proof by contradiction, the axiomatised horn is *always*
equivalent-to-the-goal-modulo-the-proved-horn.** That is true even at the paper
level: the paper proves `ob(F⋆) ≠ 0` (UC11 Lemma 6.2) and `ob(F⋆) = 0` (UC13).
Modulo Lemma 6.2, "`ob(F⋆) = 0`" is equivalent to Frankl too.

So "is the axiom propositionally equivalent to Frankl" is, on its own, the
**wrong test** — every contradiction-style proof has this property. What
actually distinguishes a *genuine sub-lemma* from *Frankl-in-disguise* is two
things the current axiom fails and a real sub-lemma passes:

- **(i) Independent justification.** A genuine sub-lemma `Y` has its own proof
  that does not route through Frankl. The paper's `ob = 0` has the UC13
  spectral-sequence argument. The current Lean axiom has *nothing* — it is a
  bare `axiom`. A reader cannot check it; there is no `Y`-proof to point at.
- **(ii) Statement in an object where its negation is *not* a repo theorem.**
  A genuine sub-lemma is not *visibly, in two lines,* equal to the goal. The
  current axiom is: its negation `X` is a proved theorem **in the very same
  object**, so the equivalence is immediate. The paper's `ob = 0` is stated at
  the spectral-sequence-abutment level; its negation is *not* a theorem sitting
  right next to it — the non-vanishing `ob(F⋆) ≠ 0` is a separate minimality
  argument the reader has to bring in deliberately.

The current axiom fails both. To fix it you must give it (i) a real proof
(formalise `Y` — paths (a)/(b)), or at minimum (ii) re-home it in an object
whose negation is not a neighbouring theorem. §4 shows (ii) alone is not
possible today either, because the only such object does not exist in Lean.

---

## §3 — What `Y` actually is (clean standalone statement)

The genuine, paper-proven, Lean-deferred mathematical content has **two
substeps**. The axiom currently fuses both; they should be separated, because
they have very different risk profiles.

### 3.1 Substep Y₁ — the cohomology computation (the genuine sub-lemma)

> **Y₁ (lower-Walsh vanishing).** In the bi-`(ℤ/2)ⁿ⋊Sₙ`-equivariant
> cubical-Walsh-defect complex `Xₙ∩` (`n ≥ 3`), every *lower* Walsh isotype
> vanishes in positive degree: `V_S^k(Xₙ∩) = 0` for all `S ⊊ [n]` and `k ≥ 1`.
> In particular the level-1 isotypes `V_{x}^{n-1}` vanish for every `x ∈ [n]`.

This is paper-side UC10 §5.3 / UC13 Theorem 4.5.1. It is **strictly weaker than
Frankl**: a pure statement about the cohomology of one fixed complex, with no
mention of families, bias, or rare coordinates. It is a legitimate sub-lemma in
exactly Daniel's sense — you can "point at it" as a self-contained claim.

The Lean development *already has a proven proxy* for Y₁: `BKSSCohomologyVanishing`
(`UC11/BKSSCohomologyVanishing.lean:228`) proves SS-vanishing on the **narrow
single-column `BKIsotypeBicomplex F x`**. But — per onboarding pitfall #6 — that
narrow proxy is *not* Y₁: it is a degenerate single-column abstraction whose SS
collapses at E₁, not the full-`BKBicomplexHC₂` statement. Y₁ proper is not
expressible in Lean today (the graded cohomology object does not exist).

### 3.2 Substep Y₂ — the landing (the actually-load-bearing claim)

> **Y₂ (corrected landing).** The obstruction class `ob(F⋆)`, promoted to
> `Hⁿ⁻¹` of the total complex, lands entirely in the level-1 Walsh isotypes:
> `ob(F⋆) ∈ ⊕_{x∈[n]} V_{x}^{n-1}`.

This is UC13 §2.4.1. It is the step that *connects* the obstruction to Y₁'s
vanishing. Without Y₂, Y₁ is irrelevant — the obstruction could sit in the
non-zero top isotype `V_{[n]}^{n-1}`. **Y₂ is the genuine load-bearing claim**,
and it is the one with the serious risk (§5).

### 3.3 Substep Y₃ — the chain-encoding transport (a Lean-engineering artefact)

> **Y₃ (transport).** The SS-abutment vanishing of `ob(F⋆)` (from Y₁ + Y₂)
> equals the chain-level statement `obstructionCohomClassChain F = 0` in the
> current Lean encoding.

Y₃ is **not paper content at all** — the paper never uses the Lean encoding. Y₃
is a pure Lean-formalisation obligation, and the project's own analysis
(`state-UC-Lean-per-x-closure.md`, mg-36c3) proved that in the *current*
encoding Y₃ is **false**: the encoding puts `ob` on `topVertex` where
`topVertex_not_coboundary` forces non-vanishing. Y₃ becomes true only after the
Walsh-isotype chain refactor (path (a)).

### 3.4 The honest decomposition

The development *should* read:

```
X   (PROVED in Lean)     :  combinatorial non-vanishing of the obstruction
Y₁  (sub-lemma, paper)   :  lower-Walsh cohomology vanishing            -- UC10 §5.3
Y₂  (sub-lemma, paper)   :  obstruction lands in level-1 isotypes       -- UC13 §2.4.1
Y₃  (Lean transport)     :  encoding transport                          -- path (a)
X ∧ Y₁ ∧ Y₂ ∧ Y₃  ⇒  Frankl
```

The current single axiom `case3_ss_obstruction_paper_axiom` is `Y₁ ∧ Y₂ ∧ Y₃`
collapsed into one chain-level statement — which, collapsed, equals Frankl. Kept
separate, **Y₁ and Y₂ are genuine sub-lemmas**; Y₃ is a Lean chore. The collapse
is the problem.

---

## §4 — Can the axiom be re-stated at the level of `Y`? (Q1 + Q3)

### 4.1 The SS-level "B1" form — what it would be

mg-ee54 §2b and mg-980f C2 already named the candidate: an axiom whose
*conclusion* is the SS-level statement, e.g.

```lean
axiom case3_ss_vanishing :
  ∀ {n} (F : IntClosedFam n) (x : Fin n),
    IsCounterexample F →
    IsZero ((BKBicomplexHC₂ n F).spectralObject.abutmentFiltration_gr x ((n-1)-x))
```

This *is* a genuine sub-lemma in the sense Daniel wants: its negation is **not**
a theorem in the repo (there is no proven "the SS-abutment graded piece is
non-zero"), so it is not visibly Frankl-in-disguise. It is essentially Y₁∧Y₂.

### 4.2 Why B1 cannot be done today — rigorously

The conclusion type
`(BKBicomplexHC₂ n F).spectralObject.abutmentFiltration_gr x q` **does not exist
in Lean**. Constructing `.spectralObject` on the full BK bicomplex requires the
mathlib `SpectralObject` infrastructure on a *second-level* homological complex
(a bicomplex). That is blocked by the **TC-instance-priority diamond** between
`HomologicalComplex.instHasZeroMorphisms` and `preadditiveHasZeroMorphisms` at
the bicomplex type — independently corroborated across 11 `Z2` sub-splits, five
named workarounds, and the `mg-d079` namespace-rename cascade-fork (which RED'd
at the bicomplex-level proxy probe). This is a real mathlib-infrastructure
blocker, not a framing choice. mg-980f's finding here is correct and is
re-confirmed.

You **cannot fake the object with a stub.** If you `def` the abutment object as
`0`, then `IsZero 0` is trivially true, the B1 axiom becomes *vacuous* (carries
no content), and the real content moves into a separate transport axiom
`(∀x IsZero stub) → obstructionCohomClassChain F = 0` — whose hypothesis is
trivially satisfied, so it reduces to the current chain-level B2 = Frankl. The
stub buys nothing. (mg-980f §2.4 reached the same conclusion.)

### 4.3 The two-axiom split — genuine, but still blocked on the same object

The cleanest *honest* shape is the two-axiom split (mg-980f C3):

```
axiom Y₁₂ :  IsCounterexample F → SS-abutment graded piece IsZero        -- genuine sub-lemma
axiom Y₃  :  IsCounterexample F → (SS IsZero) → obstructionCohomClassChain F = 0   -- transport
```

Here each axiom *individually* is genuinely weaker than Frankl: `Y₁₂` is a
homological fact whose negation is not in the repo; `Y₃` is a transport whose
negation is not in the repo either. Only the *pair*, combined with the proved
`X`, is Frankl-equivalent — and that is exactly the honest "we proved X, we
assumed Y₁₂ and Y₃" structure Daniel wants. **This is the right shape.**

But `Y₁₂`'s conclusion is the same non-existent SS-abutment type as B1. So the
two-axiom split is **also blocked on path (a)/(b)**. It is the correct target,
not a currently-available option.

### 4.4 The narrow-Y4 variant collapses

One might hope to use the *narrow* `BKIsotypeBicomplex` SS object (which *does*
exist, and `BKSSCohomologyVanishing` proves vanishing there). But then `Y₁₂` is
an **already-proven theorem**, not an axiom — so the only remaining axiom is the
transport `Y₃` with a trivially-satisfied hypothesis, which reduces straight
back to the current chain-level axiom = Frankl. (mg-980f C4; re-confirmed.) The
narrow object is too weak to carry a genuine sub-lemma.

### 4.5 Answer to Q1 + Q3

- **Q3 (re-state at the SS level?): No, not today.** The SS-level B1 form, and
  the honest two-axiom split, both require a Lean object that does not exist and
  cannot be built without resolving the TC-diamond (path b) or doing the
  Walsh-isotype chain-encoding refactor (path a). This is a rigorous infrastructure
  blocker, verified by mg-d079 and the Z2a–Z2j cascade. It is not a framing
  problem and cannot be re-stated away.

- **Q1 (can it be restructured into X + genuine Y?): Yes — but only by
  executing path (a) or (b) first.** Path (a) — the multi-week Walsh-isotype
  refactor of `(BKTotal n).X 0` — is the lighter route. After it, `obstructionClass`
  would decompose by Walsh isotype; the proved non-vanishing `X` would attach to
  the `χ_{[n]}` summand and the axiom `Y` to the `χ_x` summand — **different
  objects, no collision** — and at that point the axiom genuinely becomes Y₁∧Y₂
  (or, better, Y₁ alone, with Y₂ proved). That *is* the "we proved X, we
  assumed Y" structure. It is reachable. It is just not a re-statement; it is a
  construction project.

**The bottom line that supersedes mg-980f:** mg-980f asked "what is the best
axiom form that keeps Lean GREEN today" and correctly answered "the current
B2+B3, because every genuine-sub-lemma form is blocked." Daniel's revised
question is different: "can the axiom be a genuine sub-lemma." The answer is
**not with a today-shippable axiom** — the genuine-sub-lemma form is gated on
path (a)/(b). mg-980f's keep-B2+B3 recommendation optimised a constraint Daniel
has now relaxed; under the new priority, the honest recommendation is §6.

---

## §5 — Risk assessment of the proof of `Y` (Q4)

Daniel asked specifically: "How confident are we in the paper proof of the
Lean-deferred content? Is it fully rigorous and referee-grade, or does it have
soft spots? Probe it genuinely." This section does that. **Verdict: HIGH RISK;
not referee-grade.**

### 5.1 Meta-risk — what this "paper" actually is

The proof of `Y` lives in `docs/union-closed-UC10..UC14-*.md`: a chain of
agent-generated research notes in a house style with GREEN/AMBER/RED verdict
banners, "dialect-checks", and `pm-onethird feedback` cross-references. UC13's
banner reads "**GREEN — Frankl closes unconditionally.**"

This is a claimed **complete proof of the Frankl union-closed conjecture**, an
open problem since 1979, on which the first substantial progress
(Gilmer's `≈0.38`) is from 2022. A correct proof would be a major result. It
currently exists only as unrefereed Markdown in a research repo. The base rate
for "a chain of agent notes has actually proved a famous open conjecture" is
very low. This alone means we **cannot** be "EXTREMELY confident", independent
of any line-by-line check. Daniel's worry — "the new axiom being incorrect or
unproven" — is well founded and is the dominant risk.

### 5.2 The load-bearing step is a reversal of an earlier draft

The closing contradiction (UC13 §7) is: `ob(F⋆) ≠ 0` (minimality) versus
`ob(F⋆) = 0` (it lands in vanishing isotypes). The `= 0` half depends entirely
on **UC13 §2.4.1**, the "corrected landing":

- **UC11 §5.3** (earlier) said `ob(F⋆)` lands in the **top** isotype
  `V_{[n]}^{n-1}` — which is **non-zero** (`≅ sgn_{Sₙ}`). With that landing
  there is *no contradiction* and *no proof*; UC11 was AMBER precisely here.
- **UC13 §2.4.1** "corrects" this: it lands in **level-1** isotypes
  `⊕_x V_{x}^{n-1}` — which are **zero**. UC13 explicitly writes "This is
  incorrect" of UC11 §5.3.

The entire proof closes *because of this one reversal*. The reversal is a
delicate isotype-tracking argument (the Čech bicomplex of `𝓕_obs` is
`(ℤ/2)ⁿ`-equivariant; source data is level-1; differentials preserve isotype;
"no cup product appears"). The argument is not obviously wrong — but it is not
obviously right either, and **a proof whose decisive step is a late-stage
reversal of the previous draft's opposite claim is structurally fragile.** The
question "does `ob` land in level-1 or in the top isotype?" is the whole ball
game, and the program has answered it both ways.

### 5.3 The Lean formalisation contradicts the corrected landing — direct evidence

This is the strongest single piece of risk evidence, and it comes from the
project's own Lean work.

When the obstruction class was formalised, the encoding chosen was
`obstructionClass F x := Finsupp.single (topVertex F) (β_x F)`. The project's
own docstring for `topVertex_not_coboundary` (`CohomologyClass.lean:380`) states
the `topVertex` 0-cell "represents the unique non-coboundary generator of
`H⁰(Xₙ∩;ℚ) ≅ ℚ`" and "is also the **`sgn_{Sₙ}`-isotype generator at top degree**
of UC10.1." `sgn_{Sₙ}` at top degree is the `χ_{[n]} ⊗ sgn` **top** isotype.

So the Lean encoding places the obstruction on the **top** Walsh isotype — the
**UC11 §5.3 picture**, the one UC13 §2.4.1 says is wrong. And the team then
**proved** (`topVertex_not_coboundary`, hence
`obstructionCohomClassChain_ne_zero_of_counterexample`) that this class is
**non-zero** whenever `β_x ≠ 0`.

The project's own per-x closure analysis (`state-UC-Lean-per-x-closure.md`,
mg-36c3) draws the explicit conclusion: the axiom's target
`obstructionCohomClassChain F = 0` is "**logically equivalent to
`topVertex_not_coboundary` FAILING**" — i.e. it is **provably false in the
encoding that was actually built.** mg-36c3 calls this a "RED structural
blocker."

The project's interpretation is generous: "our encoding is a non-faithful
placeholder; the *real* obstruction is in `χ_x`; after the Walsh-isotype
refactor the vanishing would hold." That is *possible*. But the alternative
interpretation has at least equal standing: **the natural Lean encoding
faithfully captured where the obstruction actually lands (the top isotype, on
`topVertex`), proved it non-zero, and thereby exhibited that UC13 §2.4.1's
corrected landing is the wishful step.** Nobody has done the refactor; nobody
has verified, mechanically, that the obstruction lands in `χ_x`. The one
serious attempt to formalise the load-bearing step instead produced, and
proved, its negation. That is not reassuring — it is a red flag.

### 5.4 Soft spots inside the paper proof of `Y` itself

Reading UC13's actual proofs (not just its banners):

- **UC13 §5.2 (top-Walsh concentration `V_{[n]}^k = 0`, `k<n-1`)** — part of
  UC10.1, which Y₁ depends on. The text literally says: *"We need a more
  careful argument."* It then introduces a "composite bridge"
  `H ω := Σ_x (−1)^{[x]} h_x ω` and immediately concedes *"The composite `H`
  is not itself a single chain-level operator."* It closes with
  *"`∎` (modulo the standard hocolim coherence …)"* and a "Direct degree-count"
  that asserts rather than proves exactness (`h_{x₁}⋯h_{x_{n-1-k}}ω` "exhibits
  `ω` as exact").

- **UC13 §4.5 / Lemma 4.4.1 (cohomological covering)** — "Proof sketch …
  modulo lower-dimensional corrections," with `𝓓_x`-subcomplex cells that
  "assemble … up to boundary."

- **UC13 §4.5 Theorem 4.5.1** (this is Y₁) — the iterated-trace argument
  asserts "the iterated bridge … has exhibited each cohomology class as a
  coboundary at each step" without a clean induction; surjectivity of the
  iterated trace on cohomology rests on the §4.4.1 sketch.

These are the hedge-phrases ("modulo", "up to boundary", "more careful
argument", "sketch") that, in real mathematics, are exactly where errors hide.

**UC14 is itself evidence.** UC14 exists *solely* to "tighten three
technical-cleanup residuals" that a verification pass flagged in UC13: R1 (the
abutment identification `H*(Tot) ≅ H̃*(Xₙ∩)` — the very identification Y₂
depends on), R2 (the §4.4.1 covering sketch), R3 (the §5.2 degree count). So
the soft spots were real enough to be flagged and to need a follow-up note.
UC14 declares all three "GREEN — closed" — but UC14 is the same kind of
unrefereed agent artefact, and "closed by a follow-up note from the same
process that wrote the original" is not independent verification.

### 5.5 A structural concern about the proof's shape

The vanishing side of the contradiction (`ob` lands level-1 ⇒ `ob = 0`) is
**structural**: UC13 §2.4.1's landing argument uses only the shape of `𝓕_obs`'s
Čech bicomplex, never the counterexample's `β_x > 0`. So *if the paper is
right*, `ob(F)` is identically zero for **every** family. The obstruction class
then carries no information by itself; **all** the Frankl content is forced into
UC11 Lemma 6.2 (the minimality non-vanishing) and Lemma 6.1 (`ob = 0 ⇔ a global
witness assignment exists`). The cohomological apparatus is then a wrapper, and
the real proof is whether Lemma 6.1's equivalence genuinely holds — a claim that
is itself essentially "the obstruction theory is correct," i.e. very close to
Frankl. This is the classic failure mode of cohomological-obstruction attacks
on hard combinatorial conjectures: the obstruction is *defined*, *asserted* to
be a faithful obstruction, and *asserted* to live in a zero group; if any of
those has slack, nothing is proved. UC13 does not pin Lemma 6.1 down to
referee standard.

Relatedly: the Lean `ThetaMap` (UC14 R1, the chain↔abutment identification) is
formalised as **literally the identity map** (`ThetaMap F ω = ω`). An "abutment
equivalence" that is the identity is not doing mathematical work — it indicates
the formalisation collapsed a substantive identification into a triviality, or
defined the two sides to be equal. Either way the Lean does not *witness* the
abutment identification that Y₂ needs.

### 5.6 What is genuinely solid (for balance)

The report should not overstate. The following are real and Lean-verified:

- The combinatorial L-arc (`UC11_nonVanishing`, the bias arithmetic, L4
  minimal-element witnesses) is genuinely formalised and `lake build` is GREEN.
- `topVertex_not_coboundary` is a genuine, proved theorem.
- `Frankl_Holds_concrete`, `Frankl_Holds_fullPowerset3/4` are genuinely
  unconditional — the concrete small-`n` cases do not touch the axiom.
- The narrow `BKSSCohomologyVanishing` is a genuine proved theorem (of the
  narrow single-column statement, not Y₁).

So the development is not worthless. But the **headline** `Frankl_Holds` rests
on the axiom; the axiom is `Y₁∧Y₂∧Y₃`; and Y₂ (the corrected landing) is the
unverified, formalisation-contradicted, load-bearing claim.

### 5.7 Risk verdict

`Y`'s paper proof is **not referee-grade and carries high risk of being
wrong.** Concretely:

- Y₁ (lower-Walsh vanishing): *moderate* risk. Plausible in outline, but the
  UC13 §5.2/§4.5 proofs are sketches with explicit "modulo" hedges; UC14's
  tightening is unrefereed.
- Y₂ (corrected landing): **high** risk. It is a late reversal of UC11 §5.3;
  the Lean formalisation's natural encoding contradicts it and proved the
  opposite; it has never been independently verified.
- Y₃ (transport): not a maths claim; a Lean chore, currently provably false in
  the existing encoding, contingent on path (a).

We should **not** be "EXTREMELY confident." The Zulip post must not go until Y₂
in particular is checked by a competent human or formalised honestly. Daniel's
decision to hold the post is correct.

---

## §6 — Recommendations

Routed to Daniel via pm-onethird (the polecat does not mail Daniel directly per
the `mg-39bc` brief).

1. **Do not post the Zulip draft.** Confirmed correct. The headline result is
   axiom-dependent and the axiom is, today, Frankl-in-disguise resting on an
   unverified, formalisation-contradicted step.

2. **Stop describing the development as "X + Y ⇒ Frankl."** Until path (a)/(b)
   lands, the honest description is: *"the combinatorial half is formalised; the
   homological half is assumed, and as assumed it is — given the formalised
   half — equivalent to Frankl itself."* The current `AXIOMS.md` disclosure is
   honest about the *equivalence*; it should additionally stop implying the
   axiom is a *sub-lemma*.

3. **The genuine-sub-lemma restructure is a real project, not a re-statement.**
   If Daniel wants the "point at our own proof, we proved X and Y" structure,
   the path is: execute **path (a)** (the Walsh-isotype chain-encoding refactor
   of `(BKTotal n).X 0`), then state the axiom as Y₁∧Y₂ in the refactored
   `χ_x` summand — distinct from the `χ_{[n]}` summand where `X` is proved.
   This is the honest two-axiom split of §4.3. Estimate: multi-week. It is the
   only route that delivers what Daniel asked for.

4. **Before *any* of that, get `Y₂` (UC13 §2.4.1) independently checked.** The
   refactor in (3) is only worth doing if the corrected landing is actually
   true. Given §5.3 — the natural formalisation contradicted it — the priority
   order should be: **first** verify Y₂ (a competent human reads UC13 §2 +
   §2.4.1 against UC11 §5.3 and decides which landing is correct; or a
   formalisation is done that is *not* steered to the desired isotype),
   **then** decide whether to invest in path (a). Doing the refactor first
   risks multi-week work to formalise a false statement.

5. **Reframe the milestone.** The project has treated "Frankl_Holds GREEN with
   one axiom" as near-complete. Given this investigation, the accurate status
   is: a substantial combinatorial formalisation exists; the homological core
   that would actually prove Frankl is unverified and at material risk of being
   wrong. The milestone is *not* "one axiom away from a formalised Frankl
   proof" — it is "one **unverified, possibly false, Frankl-equivalent**
   assumption away," which is a different and much weaker thing.

---

## §7 — Cross-references

- **Brief:** `mg-39bc` (this investigation).
- **Superseded recommendation:** `mg-980f`
  (`docs/Frankl-axiom-optimization-research.md`) — keep B2+B3. Its candidate
  analysis (C0–C6) is sound *under the GREEN-today constraint*; Daniel's revised
  priority (genuine sub-lemma over defensibility) changes the conclusion, not
  the analysis.
- **Independent audit:** `mg-ee54`
  (`docs/Frankl-disclosure-pivot-independent-audit.md`) — first flagged the
  propositional-equivalence-to-Frankl (§2c) and the (B1) vs (B2) distinction
  (§2b/§2d). This report extends §2c into the "why it is not a sub-lemma"
  structural diagnosis and the §5 risk probe.
- **Strategic audit / TC-diamond:** `mg-8510`
  (`docs/Z-arc-architecture-audit.md`); cascade-fork RED `mg-d079` (commit
  468a348).
- **The axiom + bridge + collision theorems:**
  `lean/UnionClosed/PaperAxioms.lean`;
  `lean/UnionClosed/UC11/SSConvergence.lean`
  (`obstructionCohomClassChain_ne_zero_of_counterexample`,
  `..._collides_topVertex_not_coboundary`,
  `obstructionCohomClassChain_eq_zero_via_y6_transport_residual`);
  `lean/UnionClosed/UC11/CohomologyClass.lean:388` (`topVertex_not_coboundary`);
  `lean/UnionClosed/Frankl.lean` (`obstructionClass_cohomology_vanishing`,
  `Frankl_Holds*`); `lean/AXIOMS.md`.
- **The RED structural-blocker analysis (key risk evidence):**
  `docs/state-UC-Lean-per-x-closure.md` (mg-36c3) — the encoding puts the
  obstruction on `topVertex`; the axiom's conclusion is "propositionally
  equivalent to `topVertex_not_coboundary` FAILING."
- **The paper proof of `Y`:**
  `docs/union-closed-UC10-native-cohomology-intersection-closed-families.md`
  (UC10.1, AMBER — UC10.1 stated not proven);
  `docs/union-closed-UC13-frankl-closure.md` (§2.4.1 corrected landing = Y₂;
  §4.5 = Y₁; §5.2 top-Walsh concentration; §7 closing contradiction);
  `docs/union-closed-UC14-uc13-technical-cleanup.md` (R1/R2/R3 "tightening" of
  the UC13 soft spots);
  `docs/union-closed-UC11-cech-sheaf-frankl-program.md` (§5.3 original landing
  claim, §6 non-vanishing Lemma 6.1/6.2).

---

*Investigation by polecat `cat-mg-39bc`. Deliverable: this report on `main`.
Verdict: (1) the axiom cannot be made a genuine sub-lemma by re-statement —
only by executing path (a)/(b) to build the object a genuine `Y` needs; (2) `Y`
is the homological half of the paper's contradiction, cleanly Y₁ (lower-Walsh
vanishing) + Y₂ (corrected landing) + Y₃ (encoding transport); (3) re-stating
at the SS level is rigorously blocked today by the TC-diamond; (4) the paper
proof of `Y` is HIGH RISK — unrefereed agent output, load-bearing step Y₂ is a
reversal of an earlier draft that the formalisation effort actively
contradicted. Not EXTREMELY confident. Hold the Zulip post.*
