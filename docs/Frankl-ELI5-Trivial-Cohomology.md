# Frankl-ELI5-Trivial-Cohomology — why trivial cohomology does not help inclusion-exclusion arguments for Frankl

**Work item:** `mg-8886` (Frankl-ELI5-Trivial-Cohomology). Per
Daniel's reminder 2026-05-23:

> *"eli5 why does trivial cohomology not help inclusion exclusion
> arguments in frankl"*

**READ-FIRST consumed:** `docs/Frankl-Cohomology-Synthesis.md`
(`mg-5cc6`); `docs/Frankl-ForkD-Probe-n3.md` (`mg-565a`); the four
other Phase-0 probe reports.

**Scope.** Explanation only. No new computations. Aimed at a research-
mathematician colleague who has not been steeped in the Frankl arc but
knows the standard Möbius / Euler / vanishing toolkit.

---

## §0 — The headline, in one paragraph

> **Trivial cohomology is the wrong shape for Frankl's two-part
> contradiction, even though trivial/acyclic objects are often the
> *right* shape for inclusion-exclusion arguments elsewhere.**
> Möbius inversion and Euler-zero tricks work when you want to
> *transform* one alternating sum into another — they convert
> counting identities, they do not detect existence. Frankl's
> cohomological route is the opposite kind of argument: it wants a
> single non-zero class `ob(F⋆) ∈ H̃^{n-1}` whose existence is forced
> by a counterexample F⋆, and whose isotype simultaneously forces it
> to be zero. That contradiction needs the *ambient* cohomology to be
> a one-dimensional non-zero space (specifically `sgn_{S_n}` in degree
> `n−1`). All eleven natural category-level cohomologies of "the
> category of intersection-closed families" have been computed (`mg-
> 5cc6`); they are either zero or non-zero in the wrong shape. The
> Möbius / Euler / vanishing identities they *do* satisfy are real
> identities, just not identities Frankl cares about.

---

## §1 — What "trivial cohomology" concretely means in the Frankl arc

The Phase-0 probes (`mg-565a`, `mg-f9a7`, `mg-02b5`, `mg-8f74`,
`mg-7bf3`; consolidated in `mg-5cc6` §1) computed the cohomology of
fifteen natural objects built from intersection-closed families on
`[n]`. The summary, in a sentence each:

- **Bare nerve of the Moore-family lattice `MOORE_n`.** Contractible
  (it has `0̂ = {[n]}` and `1̂ = 2^[n]`, so its nerve is a double
  cone). Its **proper part** `MOORE_n ∖ {0̂, 1̂}` — the F-series
  analog of `Δ(PPF_n)` — is **rationally acyclic**:
  `H̃^k(Δ(P̄); ℚ) = 0` for every `k`, reduced Euler characteristic
  `χ̃ = 0`, and equivalently **Möbius function `μ(0̂, 1̂) = 0`**.
- **Fork A's covariant hocolim** `H^*(C_n; X) = H^*(hocolim_{C_n} X)`:
  also acyclic above degree 0, because the trace category has a
  terminal object `(∅, {∅})` and the hocolim drains onto it.
- **Trace-downset variants** (Daniel's reframing — `H^*(C_n(F); X)`
  and `H^*(C_n(F) ∖ {F}; X)`): same terminal-object collapse. Every
  trace-downset contains `(∅, {∅})` at the bottom; the colimit
  drains.
- **Local Čech double complex** for the cell-level `F_obs` spectral
  sequence: cell-level acyclic; the obstruction's mismatch
  1-cocycle is **δ-exact** in the `F_obs`-internal direction.

Concretely "trivial" means: cohomology equal to `ℚ` in degree 0 and
zero elsewhere — a rational homology point. Reduced Euler
characteristic `0`. Möbius `μ(0̂, 1̂) = 0`. **No invariant of any
non-trivial degree.**

---

## §2 — Where trivial/acyclic objects DO help in combinatorics

Daniel's intuition is correct in general. Acyclicity is the engine
of three standard combinatorial moves:

**(a) Möbius inversion → cancellation identities.** A poset with a
clean Möbius function lets you invert: `g(x) = Σ_{y ≤ x} f(y)` is
equivalent to `f(x) = Σ_{y ≤ x} μ(y, x) g(y)`. The Möbius function
*is* a cohomological invariant (`μ(0̂, 1̂) = χ̃(Δ(P̄))`), and a
zero / acyclic value is itself a useful identity: it says the
alternating sum of chain counts vanishes. Inclusion-exclusion on a
Boolean lattice is the most familiar instance.

**(b) Euler-zero → alternating-sum tricks.** If `χ̃(K) = 0`, then
`Σ_k (−1)^k f_k(K) = 1`, which is a numerical constraint between the
face counts. Whenever your counting problem is the face count of a
known-acyclic complex, you get an identity for free.

**(c) Vanishing in a LES → adjacent terms become isomorphic.** A
long exact sequence `… → H^k(A) → H^k(B) → H^k(C) → H^{k+1}(A) → …`
collapses cleanly whenever one of the three rows vanishes: the
remaining two terms become isomorphic. This is how acyclicity of a
quotient or a fibre routinely transports an invariant from one
object to another.

Each of these moves shares a common shape: you have an
*alternating-sum / chain-level / cochain-level identity* and you
want to *rearrange* it. Vanishing is a useful piece of data because
zero is a particularly informative value of an alternating sum.

---

## §3 — Why those tricks do **not** apply to Frankl's contradiction

The Frankl cohomological route (`paper/forkA/refoundation.tex`
`thm:contradiction`, L1661) is a *different shape of argument*. It
does not transform a counting identity. It runs a forced-class
existence game:

1. **Forced existence (Fact One, `prop:fact-one`).** From the
   existence of a minimal counterexample `F⋆`, build an obstruction
   class `ob(F⋆) ∈ H̃^{n-1}(C_n; X)` and show it is **non-zero**.
2. **Forced shape (input (iv), R2).** Show that the same class is
   **`sgn`-free** in the `S_n`-isotype decomposition.
3. **Ambient shape (input (v), `conj:y1a`).** Show that the host
   group `H̃^{n-1}(C_n; X)` is **one-dimensional, of `sgn_{S_n}`
   type**.

Then (1) + (2) + (3) force `ob(F⋆) = 0` (sgn-free in a sgn-only line
is zero) and `ob(F⋆) ≠ 0` (Fact One) simultaneously — contradiction,
hence Frankl.

**Trivial cohomology demolishes (3).** When the host group is `0`,
there are no `sgn` lines, no `triv` lines, no isotypes to be free of
— the constraint "sgn-free" is satisfied by everything (vacuously),
and the constraint "non-zero" is satisfied by nothing. Both inputs
become trivially true / trivially false, and no contradiction
emerges. **The proof strategy needs the ambient to be exactly a
one-dimensional sgn line; it cannot run on the zero space.**

Note what this is *not*: it is not that the proof would work "if
only we had Möbius inversion." Möbius inversion would rearrange
some counting identity into another counting identity. Frankl is
not a counting identity — it is an existence statement (every
intersection-closed family has a rare coordinate). The forced-class
strategy is the natural cohomological translation of an existence
claim; Möbius inversion is the natural cohomological translation of
a counting identity. **The two strategies use cohomology
differently, and "trivial" is a wrong-shape verdict for the
existence-claim strategy even though it is often a right-shape verdict
for the counting-identity strategy.**

### §3.1 — A concrete bank-vault analogy

Picture cohomology as a **bank vault**. The Frankl strategy tries to
prove "no counterexample exists" by showing:

- If a counterexample F⋆ existed, it would be *forced to deposit* a
  certificate `ob(F⋆)` of a specific shape into the vault.
- The vault is *physically incapable* of holding a certificate of
  that shape.
- Therefore no counterexample.

A trivial cohomology = an **empty vault**. The argument now reads:

- F⋆ "deposits" a certificate (which, having nowhere to be, is just
  the zero object).
- The vault holds no certificates of that shape (true — it holds no
  certificates at all).
- Therefore … nothing. Both clauses are vacuously satisfied. F⋆ is
  not ruled out.

In contrast, Möbius inversion is a different kind of business:
it does not care whether the vault is empty. It cares about the
*lattice underneath the vault*, and uses its alternating-sum
structure to rearrange counting identities about families. An empty
vault is consistent with — even sometimes equivalent to — a clean
Möbius identity. So the same finding ("vault is empty / Möbius is
zero") can be *useful for counting* and *useless for the forced-
class contradiction* simultaneously. That is exactly the situation
the Frankl probes have measured.

---

## §4 — What kind of object WOULD help, and the F-series template

The kind of object the contradiction needs is precisely what the
F-series sister category `Δ(PPF_n)` exhibits, and what Daniel's vision
named:

> A one-dimensional `sgn_{S_n}` class in cohomological degree
> `n − 1`, attached as an invariant to the indexing object (so that
> the class can depend on the counterexample F⋆).

The probes located this shape in exactly one place across all
fifteen constructions: the **maximal family** `2^[n]`, viewed as
the inclusion poset of its own member sets. There, the punctured
Boolean cube `2^[n] ∖ {∅, [n]}` is `≃ S^{n-2}`, with `H̃^{n-2} ≅
sgn_{S_n}` — exactly the right shape. But this sphere is attached
to *one element of the Moore-family lattice* (the maximal family),
not to *the lattice itself*; and the maximal family is not a
counterexample candidate (`mg-565a` §4). So the right *shape*
exists in the per-family picture, but at the *wrong family*; and
when you try to "integrate" that per-family content across the
lattice — by any natural variance, covariant or contravariant,
hocolim or holim — the integration destroys the sphericality
(`mg-f9a7` §4.3; `mg-7bf3` §4). This is the structural finding of
the arc.

---

## §5 — Connection back to the Frankl proof structure

Inclusion-exclusion arguments are useful when you have:

- An identity to prove (sum = sum), and
- Möbius-zero / Euler-zero cancellation in the natural underlying
  poset to drive the cancellation.

Frankl needs:

- A class to construct (the obstruction `ob(F⋆)`),
- An *invariant the class lives in* (non-zero `H̃^{n-1}`),
- A *property the class violates* (`sgn`-free in a `sgn` line).

These two argument shapes use opposite features of cohomology. The
first uses *acyclicity* to drive cancellation. The second uses
*non-acyclicity in a controlled shape* to drive contradiction.
Trivial cohomology is therefore *helpful* for the first kind and
*fatal* for the second.

That is the whole answer to Daniel's question. The trivial
cohomology found across the Phase-0 probes is exactly the wrong
material for the Frankl two-part contradiction. It would be the
right material for an inclusion-exclusion identity about Moore
families — except that Frankl is not an inclusion-exclusion
identity, so no such identity is the theorem one wants.

---

## §6 — Honesty check: is there a useful Möbius / inclusion-exclusion
angle the arc has not yet explored?

The ticket asks for this honestly, not as a leading question. The
answer, as best the synthesis allows:

**Probably no, but with one caveat.** The trivial cohomology found
in the Moore-lattice probes is exactly an *equivalent restatement*
of `μ(0̂, 1̂) = 0` for the Moore lattice. So a Möbius-inversion
identity attempting to express `f(2^[n])` as `Σ_F μ(F, 2^[n]) f(F)`
collapses: the boundary contribution `μ(0̂, 1̂) · f(0̂)` is zero, and
the higher-degree cancellations are *also* zero (the higher
cohomology vanishes too). This means there is **no non-trivial
alternating-sum identity over the Moore lattice that an unspecified
"Frankl invariant" `f` is forced to satisfy** — the canonical Möbius
machinery delivers `0 = 0` and nothing more.

The caveat: Möbius inversion over the Moore lattice with respect to
a **non-standard rank function** (e.g. by rare-coordinate count, or
by the cardinality `|F|`) could in principle still generate
content. The Phase-0 probes did not survey graded / weighted
inclusion-exclusion identities on the Moore lattice. Whether any of
them would constrain Frankl is unknown but a priori unlikely,
because the obstruction to Frankl is an *existence* obstruction
(some `x` has `β_x = 0`) and inclusion-exclusion identities
naturally constrain *counts*, not existences. Daniel may want to
flag this as a possible follow-on probe if a fresh angle is wanted;
the cohomology synthesis cannot rule it out, but does not endorse it
either.

The category-level / cohomological route in the form
`thm:contradiction` requires, is dead at the level of the existing
constructions, and the Möbius restatement of the trivial cohomology
adds *no new* inclusion-exclusion angle that would rescue it.

---

## §7 — Conceptual diagram (one image, in ASCII)

The two argument shapes side-by-side:

```
INCLUSION-EXCLUSION / MOEBIUS              FRANKL FORCED-CLASS
  (uses ACYCLICITY positively)              (uses NON-ACYCLICITY)

  Sum_T (-1)^|T| |F_T|  =  0          ob(F*)  ∈  H^{n-1}(C_n; X)
       ^^^^^^^^                                   ^^^^^^^^^^^^^^^
       cancellation we WANT                       1-dim sgn ambient
       (trivial cohom is a feature)               we NEED to host ob

       result: a counting identity              result: ob ≠ 0 (Fact One)
                                                    AND ob is sgn-free
                                                    ⇒ contradiction

WHEN COHOMOLOGY IS TRIVIAL (the Frankl finding):

  Sum_T (-1)^|T| |F_T|  =  0          ob(F*)  ∈  0
       cancellation OBTAINS                      ambient is empty
       (useful — gives identities)               (useless — no
                                                  certificate to forbid)
```

The same finding — "the cohomology is zero" — is **good news on the
left, fatal news on the right**.

---

## §8 — Cross-references

- **Brief:** `mg-8886` (this ticket). **Routes to:** Daniel via
  `pm-onethird`.
- **Cohomology synthesis the answer rests on:**
  `docs/Frankl-Cohomology-Synthesis.md` (`mg-5cc6`).
- **The five Phase-0 probes:**
  `docs/Frankl-ForkD-Probe-n3.md` (`mg-565a`);
  `docs/Frankl-ForkA-Phase0-FaithfulnessProbe.md` (`mg-f9a7`);
  `docs/Frankl-ForkA-Fobs-SS-Pinning.md` (`mg-02b5`);
  `docs/Frankl-Downset-Reframing.md` (`mg-8f74`);
  `docs/Frankl-Spherical-Reconcile.md` (`mg-7bf3`).
- **The conditional theorem the cohomology must feed into:**
  `paper/forkA/refoundation.tex` `thm:contradiction` (L1661),
  inputs (i)–(v) `def:ob` (L1122), `prop:fact-one` (L1181),
  `conj:y1a` (L1361).
- **Onboarding:** `docs/PROOF-STRUCTURE-ONBOARDING.md`.

---

*ELI5 by polecat `cat-mg-8886`. Deliverable on `main`: this
document. One-sentence headline: trivial cohomology is "the empty
vault" — it is the right shape for inclusion-exclusion identities
(which transform counting expressions) and the wrong shape for
Frankl's forced-class contradiction (which needs a one-dimensional
`sgn` line to host a non-zero obstruction class). Möbius `μ(0̂, 1̂) =
0` of the Moore lattice is itself the alternating-sum restatement of
the triviality, so the canonical inclusion-exclusion identities it
generates are `0 = 0` — true but uninformative. A non-standard
graded inclusion-exclusion identity over the Moore lattice has not
been probed; it is a priori unlikely to constrain an existence-claim
like Frankl, but is not strictly ruled out.*
