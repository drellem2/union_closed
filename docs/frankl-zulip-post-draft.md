# Frankl (union-closed) — prospective Zulip post draft

**Work item:** `mg-f7b9` (Frankl-Zulip-Post-Draft).
**Status:** DRAFT for Daniel's judgement — **nothing has been posted to Zulip.**
**Created:** 2026-05-20.

This document is the committed-for-the-record copy of a prospective Lean
Zulip post about the union-closed (Frankl) formalization, mailed to
Daniel the same day. Daniel decides from here: post now, revise, or
hold. It has three parts:

1. **The prospective Zulip post text** (calibrated for the Lean Zulip
   audience).
2. **The actual `#print axioms` output** — embedded in the post, run
   against a clean `lake build` of the worktree (see "Provenance of
   the `#print axioms` output" at the end).
3. **A cover note to Daniel** — what is honest in the draft, and what
   the main reception risk is.

The honesty constraints that define "aligned with our goals" (per the
`mg-f7b9` ticket) were treated as hard constraints: the post does not
claim Frankl is proved or formalized; it states up front that the one
project axiom is — modulo a proven theorem in the development — equivalent
to the conjecture itself; it is framed as a work-in-progress approach.

---

## Part 1 — Prospective Zulip post

> **Suggested placement:** a new topic in the `general` stream (or
> `Is there code for X?` if framed as a question). Tag it clearly as
> work-in-progress. Final stream/topic is the poster's call.

---

### [WIP — not a proof] A cohomological-obstruction framework for the union-closed sets conjecture

I'd like to share a Lean 4 + Mathlib work-in-progress and ask the
community for an honest read on it.

**The headline first, without varnish: this is not a proof of the
union-closed sets conjecture (Frankl's conjecture).** It is a formalized
*framework* and *reduction*, together with a precise, machine-checkable
account of exactly where the remaining gap is. I am posting it as an
approach to be critiqued, not as a result — and I would rather state its
limitations plainly than have them discovered.

**The single most important disclosure, up front.** A reader running
`#print axioms` on our headline theorem would find this within minutes,
so it leads the post rather than hiding in a footnote.

The general case of our headline theorem `Frankl_Holds` depends on one
project `axiom`, `case3_ss_obstruction_paper_axiom`. In the *same*
development we have a **proven** theorem,
`obstructionCohomClassChain_ne_zero_of_counterexample`. Place them side
by side:

```
axiom  (asserted) :  IsCounterexample F → obstructionCohomClassChain F = 0
theorem (proven)  :  IsCounterexample F → obstructionCohomClassChain F ≠ 0
```

Together they yield `IsCounterexample F → False`, i.e.
`∀ F, ¬ IsCounterexample F` — which *is* the union-closed conjecture.
So the axiom is **not** a weaker lemma that happens to imply the
conjecture: modulo a theorem we have already proven, it is
**propositionally equivalent to the conjecture itself**. The general
`Frankl_Holds` therefore currently *assumes* what it states.

That is the gap. The rest of this post is about what surrounds it, and
whether the approach is worth pursuing.

#### The setting

We work in the intersection-closed dialect of the conjecture (equivalent
to the union-closed form by complementation). For an intersection-closed
family `F` on a ground set `Fin n`, with `F ≠ {univ}`, we want a
coordinate `x` that lies in at most half of the sets — formalized as
`beta x F ≤ 0`, where `beta` is the containment bias of the coordinate.

#### The framework

The approach is cohomological. From an intersection-closed family we
build a `(ZMod 2)^n`-Walsh-equivariant Bousfield–Kan-style bicomplex,
and from a hypothetical counterexample we extract an *obstruction class*
living in the degree-0 homology of its total complex. The strategy is a
collision between two halves:

- **Non-vanishing half — proven.** A counterexample forces the
  obstruction class to be *non-zero*. This half is fully formalized and
  `sorry`-free; it routes through an augmentation-injectivity argument
  (`topVertex_not_coboundary`) and carries no project-axiom dependency.

- **Vanishing half — axiomatized.** The paper-side argument forces the
  *same* class to be *zero*, via spectral-sequence abutment vanishing on
  a Walsh-isotype slice of the bicomplex. This half is the one carried
  by `case3_ss_obstruction_paper_axiom`.

Non-zero and zero collide, so no counterexample exists. The framework,
the reduction down to this collision, and the non-vanishing half are all
formalized and `sorry`-free. The vanishing half — which carries
essentially all of the mathematical depth, and is the part equivalent to
the conjecture — is the axiom.

#### What is genuinely unconditional

To be precise about what carries no project-axiom dependency:

- The combinatorial/cohomological scaffolding and the non-vanishing
  half are `sorry`-free and depend only on the usual Mathlib axioms.

- Two **concrete** intersection-closed families — the full powersets on
  3 and 4 elements — are verified to satisfy the conclusion with **no
  project-axiom dependency** (`Frankl_Holds_fullPowerset3`,
  `Frankl_Holds_fullPowerset4`; the witness in each case is coordinate
  `0`, with `beta = 0`).

I want to be clear these concrete instances are non-vacuity checks on
two specific families — they are *not* the conjecture for `n ≤ 4`, and
not small-case theorems quantified over all families of those sizes.

#### The axiom, honestly

`case3_ss_obstruction_paper_axiom` abstracts two substeps, neither of
which we have delivered in Lean:

1. A spectral-sequence vanishing result on the relevant Walsh-isotype
   slice of the full bicomplex. This is our own paper-side argument; it
   has not been peer-reviewed.
2. A chain-encoding refinement transporting that vanishing to the
   chain-level statement above.

The Lean delivery of (1) currently runs into a concrete Mathlib
obstacle: a typeclass-instance-priority *diamond* at the bicomplex
level. On `HomologicalComplex (HomologicalComplex C c₂) _` there are two
`HasZeroMorphisms` instances in scope — `HomologicalComplex.instHasZeroMorphisms`
(priority 1000) and `preadditiveHasZeroMorphisms` (priority 100) — which
produce the same zero morphism but are not defeq *as instance terms*, so
abelian-category APIs fail to unify two `cokernel` terms at the
bicomplex level. We have not found a workaround (section variables,
`letI`, heartbeat bumps, and a namespace-rename fork were all tried). If
anyone has hit this and knows the right fix, that feedback alone would
be valuable.

We do **not** claim the gap is "merely engineering." Because the axiom
is equivalent to the conjecture, replacing it with a proof *is*
replacing it with a proof of the conjecture. The replacement path is
genuine mathematical work — a multi-week chain-encoding refactor, or a
multi-month spectral-object infrastructure build.

#### `#print axioms`

Run against a clean build, the dependency split is exactly as described
above:

```
'UnionClosed.Frankl_Holds' depends on axioms: [propext, Classical.choice, Quot.sound, case3_ss_obstruction_paper_axiom]
'UnionClosed.Frankl_Holds_general' depends on axioms: [propext, Classical.choice, Quot.sound, case3_ss_obstruction_paper_axiom]
'UnionClosed.Frankl_Holds_concrete' depends on axioms: [propext, Classical.choice, Quot.sound]
'UnionClosed.Frankl_Holds_fullPowerset3' depends on axioms: [propext, Classical.choice, Quot.sound]
'UnionClosed.Frankl_Holds_fullPowerset4' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The headline `Frankl_Holds` (and its general-case alias) carry
`case3_ss_obstruction_paper_axiom` alongside the standard Mathlib trio.
The two concrete full-powerset instances carry only the Mathlib trio —
they are axiom-free.

#### What I'm asking

This is a work-in-progress share, and these are the questions I would
most value answers to:

1. Independent of the axiomatized step, is the cohomological reduction
   itself a sound and interesting way to attack this conjecture?
2. Has anyone run into the bicomplex-level `HasZeroMorphisms` instance
   diamond, and is there a known resolution (a Mathlib-side priority
   rebalance, or a reliable downstream workaround)?
3. Given the disclosure above, is sharing a framework in this state —
   open about an axiom that is equivalent to its own goal — a useful
   contribution to make now, or is it premature?

Thanks for reading, and thanks in advance for honest pushback.

---

## Part 2 — `#print axioms` output (verbatim)

The output below is reproduced for the record exactly as emitted by
Lean. It also appears inline in the post above (under "`#print axioms`").

```
'UnionClosed.Frankl_Holds' depends on axioms: [propext, Classical.choice, Quot.sound, case3_ss_obstruction_paper_axiom]
'UnionClosed.Frankl_Holds_general' depends on axioms: [propext, Classical.choice, Quot.sound, case3_ss_obstruction_paper_axiom]
'UnionClosed.Frankl_Holds_concrete' depends on axioms: [propext, Classical.choice, Quot.sound]
'UnionClosed.Frankl_Holds_fullPowerset3' depends on axioms: [propext, Classical.choice, Quot.sound]
'UnionClosed.Frankl_Holds_fullPowerset4' depends on axioms: [propext, Classical.choice, Quot.sound]
```

**Provenance.** Produced in this worktree (`mg-f7b9`, branch
`polecat-mg-f7b9`, identical to `main` at draft time) by: `lake exe
cache get` (Mathlib `v4.29.1` olean cache), `lake build` (`Build
completed successfully (2061 jobs)`), then `lake env lean` on a scratch
file importing `UnionClosed.Frankl` with the five `#print axioms`
commands. The scratch file was not committed. The split matches what
`lean/AXIOMS.md` (the §"R2 — axiom-dependency map") documents.

---

## Part 3 — Cover note to Daniel

Daniel —

Per your 2026-05-20 reminder, here is a prospective Zulip post for the
Frankl formalization, with the real `#print axioms` output pasted in.
Nothing has been posted; this is for you to judge.

**What is honest in the draft.**

- It never claims Frankl is proved or formalized. The word "proof" is
  explicitly disclaimed in the first sentence.
- It leads — first disclosure, before any description of the framework —
  with the fact that `case3_ss_obstruction_paper_axiom`, combined with
  the proven `obstructionCohomClassChain_ne_zero_of_counterexample`, is
  propositionally equivalent to the conjecture itself. This is the
  finding the mg-ee54 independent audit said a Zulip reader would spot
  within minutes; the draft preempts it by stating it openly and first.
- The `#print axioms` output is real (freshly built, see Part 2
  provenance), not transcribed. It shows the headline carrying the axiom
  and the two concrete instances axiom-free.
- It describes the concrete `n = 3` / `n = 4` results accurately as
  non-vacuity checks on two specific families — not as "Frankl for
  small n", which they are not.
- It flags that the paper-side spectral-sequence argument has not been
  peer-reviewed, and does not claim the gap is "merely engineering."

**The main reception risk.**

Honesty protects against the worst outcome (being caught hiding the
axiom-equals-conjecture fact), but it does not make the contribution
*strong*. The blunt reception risk: a skeptical reader can fairly
summarize the development as "a reduction, plus the easy half of a
collision proven, plus the hard half — which is the whole conjecture —
assumed." Even with full disclosure, posting a framework whose only
non-trivial step is an axiom equivalent to its goal can read as
premature, and may draw "this is just assuming Frankl" replies. The
WIP/feedback framing softens this but does not remove it. A secondary
risk: the post invites scrutiny of our paper-side SS argument, which is
internally reviewed only.

**My read (yours to overrule).** The draft is honest enough not to be
*embarrassing* in the credibility-damaging sense. But as a contribution
it is thin right now, and posting today mostly invites the "you assumed
it" response. The strongest version of this post is one sent *after*
either the axiom is replaced, or there is a genuinely unconditional
result beyond two full-powerset instances. If you want to post now, the
draft is safe to post as-is; if the goal is to build credibility, I'd
lean toward "hold" or "revise" until there is more unconditional
substance to show. Your call.

— polecat `mg-f7b9`
