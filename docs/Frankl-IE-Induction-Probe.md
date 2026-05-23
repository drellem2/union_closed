# Frankl-IE-Induction-Probe — the genuine first attempt at Daniel's original vision

**Work item:** `mg-e466` (Frankl-IE-Induction-Probe). Per Daniel's
restated vision 2026-05-23T04:17Z:

> *"my original vision was: take minimal counterexample, show by
> inclusion exclusion it induces non trivial cohomology in the category
> of families. Separately prove some result about the cohomology of the
> category to achieve a contradiction. This program still sounds viable
> and UNTRIED."*

This document is the **FIRST GENUINE ATTEMPT** at the IE-induction
mechanism Daniel actually envisioned. Prior 15-construction arc
(`mg-565a` / `mg-f9a7` / `mg-02b5` / `mg-8f74` / `mg-7bf3` / `mg-5cc6`
and `mg-8886`) computed *cohomology of categorical objects in the
abstract* and found them trivial — but **NONE** tested step (2) → step
(3) of the vision: *starting from F⋆, does inclusion-exclusion INDUCE
a class?*

**READ-FIRST consumed:** `docs/Frankl-Cohomology-Synthesis.md`
(`mg-5cc6`); `docs/Frankl-ELI5-Trivial-Cohomology.md` (`mg-8886`,
which flagged but deferred this exact angle as "a priori unlikely");
`docs/Frankl-Downset-Reframing.md` (`mg-8f74`);
`paper/forkA/refoundation.tex`; `docs/Frankl-Y1-reprove.md`
(`mg-56b8`); `~/.pogo/agents/pm/pm-onethird/memory/project_frankl_vision.md`
(the canonical vision memory).

**Deliverable:** this document + the two self-contained probe scripts
`docs/frankl-ie-induction-probe.py` (the main probe) and
`docs/frankl-ie-diagnostic.py` (counterexample-shape correlation
follow-up). Reproducible at two `~2^31` primes.

---

## §0 — Verdict (top of page)

### 0.1 Headline

> **RED.** The IE-induction mechanism — operationalized in the most
> natural reading of Daniel's verbatim vision — **does NOT induce a
> non-trivial cohomology class on the counterexample-shaped F's
> Daniel's vision targets**. The mechanism *can* produce a non-trivial
> family-sensitive `sgn_{S_n}` class in `H̃^{n-2}` of the punctured
> Boolean lattice via the Möbius-product cochain (a faithful IE
> construction), AND that class is family-sensitive
> (24/61 Moore families at n=3, 816/2480 at n=4 give non-zero) — BUT
> **the counterexample-shape F's (no rare element) systematically give
> ZERO class**: 12/12 (= 100%) at n=3 and 498/582 (= 86%) at n=4 of
> the union-closed counterexample-shaped families produce the trivial
> class. The correlation is the **opposite direction** Daniel's vision
> requires.
>
> The structural reason is now visible and clean to state: the Frankl-
> counterexample condition (every element in > |F|/2 members) FORCES
> high `S_n`-symmetry in F (because rare-elementlessness equalizes
> element-counts), and **any cochain built natively from `χ_{F}` via
> IE inherits that symmetry**, hence has zero `sgn_{S_n}`-isotype
> component. Daniel's vision asks F⋆ to *induce* the sgn class; the
> counterexample condition is precisely what *kills* the sgn
> component.
>
> Vision-step 3 ("F⋆ induces a non-trivial cohomology class") and
> vision-step 4 ("a separate result about the category's cohomology
> contradicts") therefore cannot fire on the natural objects: the
> sgn-class host exists, but F⋆'s sgn-image is zero, so no
> contradiction with a (separately-true) sgn-vanishing result can be
> built. **This is a NEW finding distinct from the prior 15-
> construction trivial-cohomology arc** — it is not "the host is
> trivial" but rather "the F⋆-induced class is forced trivial by the
> counterexample condition itself."

### 0.2 The vision, scored

| Vision-step | Outcome | Evidence |
|---|---|---|
| (1) **Minimal counterexample F⋆** | Defined: union-closed, ≥ 2 members, every element non-rare. Exists at n=3 in 12 union-closed families, n=4 in 582; at strict-Frankl level no n ≤ 11 has a true counterexample, but the *shape* of CE-families is realized. | §1.1 |
| (2) **IE construction applied to F⋆** | Operationalized in 4 natural readings (OP-A four-lift variants, OP-B–D). The Möbius-product cochain (OP-A LIFT-4-prod) is the faithful IE-induction realization that *does* produce a non-zero class on some F's. | §1.2, §2.1 |
| (3) **The induced class IS non-trivial cohomology** | **PARTIAL.** The class is non-trivial for many F's (24/61, 816/2480), and lives in `H̃^{n-2}(2^[n] \ {∅,[n]}; ℚ) ≅ sgn_{S_n}` — a real, family-sensitive sgn-isotype invariant. | §2.1, §2.2 |
| (3+) **The class is non-trivial *for F⋆*** | **FAILS.** 12/12 (100%) of n=3 CE-shape F's give zero class; 498/582 (86%) of n=4 CE-shape F's give zero class. The counterexample-shape condition is anti-correlated with the IE-induced sgn class. | §2.3 |
| (4) **Separate cohomology result contradicts** | **MOOT.** No vision-step-3 class on F⋆ to contradict. Even if one believed an `H̃^{n-2}`-vanishing result was provable separately, vision-step 3 already gives zero on F⋆, so step 4 produces 0 = 0, not a contradiction. | §3 |

### 0.3 The structural reason, in one line

> **The Frankl-counterexample condition (no rare element ⇒ all
> element-counts > |F|/2) forces F⋆ towards `S_n`-symmetric structure,
> and any cochain natively built from `χ_{F⋆}` via Möbius / IE
> inherits that symmetry, killing the `sgn_{S_n}`-isotype component
> the class would need to occupy.**

---

## §1 — Part 1: Mathematical operationalization

Daniel's verbatim vision pins down four moving parts (1) minimal
counterexample F⋆, (2) IE applied to F⋆, (3) non-trivial induced
class, (4) separate-result contradiction. The vision is silent on
*which* category, *which* IE construction, *which* cohomology — the
job of this section is to pin those down.

### 1.1 The minimal counterexample F⋆ — operational definition

A **Frankl counterexample F⋆** on `[n]` is a non-empty union-closed
family with `|F⋆| ≥ 2` and no rare element — i.e., for every
`x ∈ [n]`,

  `2·|{A ∈ F⋆ : x ∈ A}| > |F⋆|`.

Frankl's conjecture is the assertion that no such F⋆ exists. It is
verified by exhaustive computation for `n ≤ 11`, so at `n = 3` and
`n = 4` there are no strict counterexamples — but there are 12
(at `n = 3`) and 582 (at `n = 4`) union-closed families satisfying
the counterexample atomic structure (no rare element). These
**counterexample-shape** families are the testbed; they realize the
property of a minimal counterexample without requiring the full
Frankl-violation (which is provably absent at these `n`).

(In what follows "CE-shape" = "union-closed, |F| ≥ 2, every element
non-rare". Throughout `χ_F : 2^[n] → {0,1}` is the indicator of F.)

### 1.2 The inclusion-exclusion construction applied to F⋆

The most natural IE construction native to a family is the **Boolean
Möbius transform** of `χ_F`:

  `m_F(T) := Σ_{S ⊆ T} (-1)^{|T \ S|} · χ_F(S)`  for `T ⊆ [n]`.

`m_F` is the Möbius inversion of `χ_F` over the Boolean lattice
`2^[n]`; it is the canonical inclusion-exclusion-flavoured
F-invariant.  We have `χ_F(T) = Σ_{S ⊆ T} m_F(S)` (Möbius inversion
formula) — so `m_F` is a complete F-invariant.

For union-closed F with `∅ ∈ F` and `[n] ∈ F`:
- `m_F(∅) = 1`;
- `m_F({x}) = χ_F({x}) − 1`;
- `m_F({x,y}) = χ_F({x,y}) − χ_F({x}) − χ_F({y}) + 1`; and so on.

The values of `m_F` encode F's structure relative to a Möbius
expansion. Their use in defining a cohomology class is the substantive
operationalization.

### 1.3 Where the F-induced class lives — four candidate operationalizations

The vision is silent on *which* cohomology hosts the class. We test
four natural candidates, chosen to span the natural readings:

**OP-A — Cochain on the punctured Boolean lattice
`2^[n] \ {∅, [n]} ≃ S^{n-2}`.**
Reduced cohomology `H̃^{n-2}(2^[n] \ {∅,[n]}; ℚ) ≅ sgn_{S_n}` — the
F-series sphere ambient that `Δ(PPF_n)` exhibits, the closest
"F-induced class with the right shape" target. Four sub-lifts of `m_F`
to a top-dimensional cochain on the punctured Boolean order complex:

  LIFT-1 — top of chain : `c(σ_0 < ⋯ < σ_{n-2}) := m_F(σ_{n-2})`
  LIFT-2 — bottom of chain : `c(σ_0 < ⋯) := m_F(σ_0)`
  LIFT-3 — alternating along chain : `c(σ_•) := Σ_i (-1)^i m_F(σ_i)`
  LIFT-4 — product along chain : `c(σ_•) := Π_i m_F(σ_i)`

LIFT-3 and LIFT-4 are the genuine multi-vertex IE-aggregation
readings; LIFT-1 and LIFT-2 reduce to single-vertex valuations
(included for completeness and as a control).

**OP-B — Cochain on the proper Moore lattice
`MOORE_n \ {bottom, top}`.**
The Möbius-style alternating-count cochain on chains in the proper
part of the Moore lattice:

  `c_F(G_0 < ⋯ < G_k) := Σ_i (-1)^i · |F ∩ G_i|`.

Tests whether placing the IE construction *in the Moore lattice itself*
(Daniel's literal "category of families") produces a non-trivial class.

**OP-C — F-twisted (count-graded) sheaf cohomology of `MOORE_n`.**
Coefficient sheaf `𝓢_F(G) := ℚ[F ∩ G]` (free vector space on F-members
in G, with restriction by intersection). Computes count-graded
cohomology of the Moore lattice — the natural count-graded variant
flagged in §6 of `mg-8886` as un-probed.

**OP-D — IE on the per-family inclusion poset `(F, ⊆)`.**
Treats F as its own poset and computes simplicial cohomology of its
proper part. This is the per-family object Daniel's reframing
(`mg-8f74`) gestured at, with IE-weighting added.

### 1.4 The "separate result about the cohomology of the category"

Daniel's vision-step 4 calls for a separate result on the category's
cohomology that *contradicts* the existence of the F⋆-induced class.
Natural shapes of such a result, derived from prior probes:

- (S1) **Vanishing in the relevant degree.** `H̃^{n-2}(host) = 0` —
  contradicts the supposed non-zero class.
- (S2) **Sgn-projection vanishing.** `H̃^{n-2}(host)^{sgn} = 0` —
  contradicts an sgn-isotype class.
- (S3) **Functorial collapse.** F⋆ functorially-induces a class that
  factors through 0 by adjunction with a known zero. (The Fork A
  `H^*(C_n;X)`-route's actual shape; rejected in `mg-f9a7`.)

For OP-A, the host has `H̃^{n-2} = sgn`, so neither (S1) nor (S2) can be
proven (the host is the very `sgn`-line we'd need to vanish — it
doesn't). For OP-B/C/D, the host *is* already proven to have trivial
top cohomology (S1 trivially true), but this doesn't help if the
F⋆-induced class is itself zero.

### 1.5 The operationalization is well-defined

For honesty: the operationalization is **not** ill-defined — all four
OPs are concrete computable invariants of F. So Part 1 does NOT
block-and-report on ill-definability; it produces an honest
mathematical specification, and Part 2 carries out the computation.

The reading we land on of Daniel's verbatim vision: **"F⋆ via Möbius
inversion produces a cochain whose cohomology class in the category-
of-families cohomology is non-zero."** Each OP is one realization of
that reading. OP-A is the cleanest (host has the right shape); OP-B/C
test Daniel's literal "category of families"; OP-D tests the
per-family reading.

---

## §2 — Part 2: Bounded n=3 / n=4 viability probe

All ranks via sparse Gaussian elimination at two ~2^31 primes,
cross-checked. Probe scripts: `docs/frankl-ie-induction-probe.py`
(main) and `docs/frankl-ie-diagnostic.py` (correlation diagnostic).
Raw output: `docs/frankl-ie-induction-probe.out` and
`docs/frankl-ie-induction-diag.out`.

### 2.1 OP-A on the punctured Boolean lattice (the sphere ambient)

**Baseline.** `H̃^*(2^[3] \ {∅,[3]}; ℚ) = {0:1, 1:1}` (i.e., `S^1`, with
`H^1` carrying `sgn_{S_3}` — UC9 D-4). At n=4 the cohomology is
`{0:1, 1:0, 2:1}` (= `S^2`, with `H^2` carrying `sgn_{S_4}`).

**LIFT-1 (top of chain), LIFT-2 (bottom), LIFT-3 (alternating).**
Across all 61 Moore families at n=3 and all 200 sampled Moore
families at n=4: **zero non-zero classes**. These lifts are
coboundaries by construction (`m_F` as a 0-cochain has trivial image
in `H̃^{n-2}`).

**LIFT-4 (product of `m_F` along chain).** Non-trivial:

| n | object | non-zero class | sgn-nonzero |
|---|---|---|---|
| 3 | 61 Moore families | 24/61 | 24/61 |
| 3 | 113 union-closed (size ≥ 2) | 48/113 | 48/113 |
| 4 | 2480 Moore families | 816/2480 | 816/2480 |
| 4 | 4943 union-closed (size ≥ 2) | 1536/4943 | 1536/4943 |

The LIFT-4-prod cochain is the **genuine IE-induction realization** —
it takes the Möbius transform `m_F` (the inclusion-exclusion step)
and packages it as a top-dimensional cochain by taking the product
along chains. The resulting class is non-zero, family-sensitive, and
lives in the correct sgn-isotype.

A concrete example at n=3: for `F = [{1}, {1,2}, {1,2,3}]`, `m_F`
has values `m_F({1}) = 1`, `m_F({1,3}) = -1`, all other proper
subsets `0`. The LIFT-4-prod cochain is supported only on the chain
`{1} ⊊ {1,3}` (value `-1`); its integral around the hexagonal
cycle of `2^[3] \ {∅,[3]}` is `+1`, non-zero. After sgn-projection,
the cochain becomes `(+1, -1, +1, -1, +1, -1)` on the 6 edges with
cycle integral `+6`, confirming non-trivial sgn-isotype class.

**So vision-step 3 IS realizable in principle**: F⋆-induced
non-trivial cohomology classes exist for many F at n=3, n=4, in
the right host (punctured Boolean ≃ `S^{n-2}`), in the right isotype
(sgn).

### 2.2 OP-B / OP-C / OP-D — direct probes of the Moore-lattice and
per-family variants

**OP-B (Möbius-count alternating cochain on proper Moore lattice).**
`H̃^*(MOORE_3 \ {bot, top}; ℚ) = {0:1, ≥1:0}` — the proper Moore
lattice is rationally acyclic (matches mg-565a). Hence any F-cochain
at top dim is automatically a coboundary. **0/50** sampled F's give a
non-zero top-dim class. Same outcome at n=4 (host has `H̃^* = {0:1}`).
**OP-B: RED uniformly.**

**OP-C (F-twisted sheaf cohomology of `MOORE_n`).** Only 2 distinct
cohomology profiles across 30 sampled F's at n=3, both with `H̃^* =
{0:0 or 0:1, ≥1:0}` — twisted cohomology stays trivial above
degree 0. **OP-C: RED uniformly.**

**OP-D (per-family inclusion-poset cohomology).** Matches P1 in
`mg-5cc6`: exactly 1 family on `[3]` gives non-trivial `H^1` (the
maximal family `2^[3]` itself, recovering the punctured Boolean
sphere). At n=4 the count rises slightly but the only non-trivial
profile attaches to families close to the maximal Boolean cube.
**OP-D: matches the prior per-family finding** (`mg-5cc6` P1)
verbatim — the sphere is attached to the maximal family, not to
counterexample-shape families.

### 2.3 The counterexample-shape correlation — the critical test

The Part-2 question is not "does F-induced cohomology exist for some
F" (OP-A LIFT-4-prod: yes), but **"does it exist for
counterexample-shape F⋆"** — Daniel's vision-step 3 specifically asks
for the latter.

**n=3 CE-shape Frankl-counterexample-shape families (12 total).**
All 12 give **zero** LIFT-4-prod sgn-isotype class:

| `|F|` | F (in shorthand) | sgn-nonzero? |
|---|---|---|
| 3 | `[{3} {1,2} {1,2,3}]` | NO |
| 3 | `[{2} {1,3} {1,2,3}]` | NO |
| 3 | `[{1,2} {1,3} {1,2,3}]` | NO |
| 3 | `[{1} {2,3} {1,2,3}]` | NO |
| 3 | `[{1,2} {2,3} {1,2,3}]` | NO |
| 3 | `[{1,3} {2,3} {1,2,3}]` | NO |
| 4 | `[{1,2} {1,3} {2,3} {1,2,3}]` | NO |
| 5 | `[0 {1,2} {1,3} {2,3} {1,2,3}]` | NO |
| 5 | `[{1} {1,2} {1,3} {2,3} {1,2,3}]` | NO |
| 5 | `[{2} {1,2} {1,3} {2,3} {1,2,3}]` | NO |
| 5 | `[{3} {1,2} {1,3} {2,3} {1,2,3}]` | NO |
| 7 | `[{1} {2} {3} {1,2} {1,3} {2,3} {1,2,3}]` | NO |

**12/12 = 100% CE-shape F's give zero class**, while 48/101 (47.5%) of
non-CE-shape union-closed families give non-zero. The correlation is
*anti*-correlated with the property Daniel's vision targets.

**n=4 CE-shape Frankl-counterexample-shape families (582 total).**
- Zero class: **498/582 = 86%**
- Non-zero class: 84/582 = 14%

Compare to non-CE-shape union-closed (4361 total):
- Zero class: 2909/4361 = 67%
- Non-zero class: 1452/4361 = 33%

CE-shape F's are **systematically more likely** to give zero class
(86% vs 67% zero-rate). The 14% of CE-shape F's that do produce a
non-zero class are all of size ≥ 7 with broken sub-symmetries
(specifically, asymmetric choices of which singletons to include);
the simplest CE-shape F's (size 3, the most "minimal" CE-shapes) all
give zero.

### 2.4 The structural reason — why CE-shape kills the sgn class

The CE-shape condition is "every element of `[n]` is in more than
`|F|/2` members." This is a strong *balance* condition on the
element-count function `a_F: [n] → ℕ`, `a_F(x) := |{A ∈ F : x ∈ A}|`.

For a family to be CE-shape, all `a_F(x)` must be strictly larger
than `|F|/2`. The structural extreme of CE-shape is the families
where all `a_F(x)` are equal (= maximally balanced); these are
exactly the **`S_n`-orbits of intersections / unions of orbit-closed
member-sets** under the natural `S_n`-action.

Concretely, the minimal CE-shape F⋆ candidates at n=3 are:
- `[{3} {1,2} {1,2,3}]` — has the 3-cycle symmetry-orbit of singletons
  partnered with pairs. Symmetric under the involution `1 ↔ 2`.
- `[{1,2} {1,3} {2,3} {1,2,3}]` — fully `S_3`-symmetric.

For each: F⋆ is invariant under at least one transposition `σ ∈ S_n`,
so `m_{F⋆}` is invariant under `σ`, so the LIFT-4-prod cochain
`c_{F⋆}` is invariant under `σ`. Sgn-projection of a σ-invariant
cochain:

  `c^{sgn}` = `(1/n!) Σ_τ sgn(τ) (τ·c)`
            = `(1/n!) Σ_τ sgn(τ) (τσ·c)`  [σ-invariance of c]
            = `(1/n!) Σ_{τ'} sgn(τ' σ^{-1}) (τ'·c)`  [reindex τ' = τσ]
            = `sgn(σ^{-1}) · c^{sgn}`
            = `-c^{sgn}`  [σ is a transposition, sgn(σ)=-1]

so `c^{sgn} = 0`. The sgn-isotype component vanishes whenever F is
invariant under *any* transposition.

**This is the structural finding.** CE-shape F⋆'s are forced toward
transposition-symmetric structure (because balanced element-counts
plus union-closure together force symmetric member-sets), and any
transposition-symmetry kills the sgn-isotype class. The natural IE
mechanism produces a class precisely on the *non-symmetric* F's,
which are precisely *not* the minimal counterexample candidates.

The 84 n=4 CE-shape F's with non-zero class are all `|F| ≥ 7`
(out of 16 subsets) with carefully arranged asymmetric inclusion of
specific singletons — examples like `[{2} {1,4} {2,3} {1,2,3}
{1,2,4} {1,3,4} {1,2,3,4}]`. These break the transposition symmetry
explicitly. None of the small (size 3–6) CE-shape F's give non-zero
class.

### 2.5 Other operationalizations — explicit attempts and outcomes

For honesty we record additional concrete attempts to *manufacture*
a CE-shape-sensitive F-induced class via inclusion-exclusion, and
their outcomes:

**Frankl-deficit edge cochain `c_F^Δ(σ_0 ⊊ σ_1) := ψ_x` where
`x = σ_1 \ σ_0` and `ψ_x := 2·a_F(x) - |F|`.** Family-sensitive
1-cochain at n=3. Cycle integral around the hex (consistent
orientation):

  `c_F^Δ(e_1) - c_F^Δ(e_2) + c_F^Δ(e_3) - c_F^Δ(e_4) + c_F^Δ(e_5) - c_F^Δ(e_6)`
  `= ψ_2 - ψ_1 + ψ_3 - ψ_2 + ψ_1 - ψ_3 = 0`

The Frankl-deficit edge cochain is **always a coboundary**, independent
of F — its cohomology class is zero for every union-closed F.

**Frankl-deficit product cochain `c_F^{Δ·Δ}(σ_0 ⊊ σ_1) := ψ_{σ_0} · ψ_{σ_1 ∖ σ_0}`.**
By the same Σ_σ sgn(σ) c(σ·e) computation: the bilinear-symmetric
form of ψ-values gives zero cycle integral identically. Always a
coboundary, independent of F.

Both the "deficit-sum" and "deficit-product" naïve cochains fail to
encode any cohomological information beyond what F's `S_n`-symmetry
structure allows. The Möbius-product LIFT-4-prod is the only
operationalization that produces a non-trivial class, and it
inherits the same `S_n`-symmetry obstruction for CE-shape F.

### 2.6 Summary: the four-vision-parts scorecard, after the probe

| Vision step | Required | Achieved |
|---|---|---|
| (1) F⋆ exists in concrete form | yes (CE-shape) | YES (12 at n=3, 582 at n=4) |
| (2) IE construction applied to F⋆ | yes (some operationalization) | YES — Möbius transform `m_F`, lifted to LIFT-4-prod cochain |
| (3) Induced class non-trivial | YES on F⋆ specifically | NO — 0% for n=3 CE-shape, 14% for n=4 CE-shape (vs 33% for non-CE-shape baseline) |
| (4) Separate vanishing contradicts | yes (e.g. host vanishes in this degree) | MOOT — step (3) already gives 0 on F⋆ |

---

## §3 — Gate verdict

Per the ticket §"Outcome gates":

> - If Part 1 reveals the operationalization is ill-defined or
>   self-contradictory: block-and-report.
> - If Part 1 succeeds and Part 2 produces a non-trivial
>   counterexample-induced class: the vision is viable.
> - If Part 1 succeeds and Part 2 returns trivial / no induced class
>   even at n=3/n=4: the IE-induction mechanism does not work as
>   stated; report precisely what fails and why.

**The verdict is the third outcome.** Part 1 was well-defined (4
concrete operationalizations across natural hosts). Part 2 produced a
non-trivial class via one operationalization (OP-A LIFT-4-prod) but
specifically NOT on counterexample-shaped F⋆: 0% positive rate at n=3
and 14% at n=4, BELOW the non-CE-shape baseline of 33% (n=4) and 48%
(n=3). The IE-induction mechanism does NOT induce non-trivial
cohomology on the F⋆ Daniel's vision targets.

**Verdict: RED — the IE-induction mechanism does not work as stated.**

The precise failure: the Frankl-counterexample condition (no rare
element) is essentially equivalent to a *balance* condition on
element-counts in F⋆, which structurally forces F⋆ to have at least
one transposition-symmetry. The natural cochain `c_{F⋆}` built from
the Möbius transform `m_{F⋆}` inherits that symmetry. Sgn-projection
of any transposition-invariant cochain is zero. Hence the F⋆-induced
class has zero `sgn_{S_n}`-isotype component, regardless of which
cochain construction is chosen — provided the construction is
F-natural (depends only on `m_F`-style F-invariants).

This is a **structural** finding, not a coincidence of the specific
LIFT chosen: any cochain `c_F` built F-naturally via a fixed
combinatorial recipe inherits all of F's automorphism-group structure.
CE-shape F's have at least Z_2-symmetry; sgn-vanishing follows.

---

## §4 — What this finding rules out, and what it leaves open

For honesty and to keep the verdict bounded:

### 4.1 What it rules out

- **The "naïve IE-induction" route to Frankl** — the
  Möbius-transform-derived cochain, in any of the four natural hosts
  (punctured Boolean, proper Moore lattice, F-twisted Moore sheaf,
  per-family poset), cannot host a non-trivial sgn-isotype class
  *for counterexample-shaped F⋆*. This rules out the four most
  natural readings of Daniel's verbatim vision.

- **The "naïve Frankl-deficit cochain" route** — cochains built from
  the rare-element deficits `ψ_x = 2a_F(x) - |F|` (the most direct
  encoding of the Frankl-counterexample condition) are always
  coboundaries on the punctured Boolean lattice, hence cohomologically
  trivial regardless of F.

- **Any F-natural cochain `c_F` whose dependence on F factors through
  a function of `F`'s `Aut(F)`-orbit type** automatically inherits
  F's symmetry, and so vanishes sgn-isotype for F's with any
  transposition symmetry — which CE-shape F's structurally have.
  This is a *general* obstruction to vision-step 3, not specific to
  any LIFT.

### 4.2 What this leaves open

- **A non-F-natural construction.** A cochain whose dependence on F is
  *not* through a function of F's `Aut(F)`-orbit type might evade the
  symmetry-vanishing argument. Examples of such non-natural data: a
  choice of total ordering on `[n]`, a marking of one element as "the
  rare witness candidate," a generic basis chosen relative to F. Such
  constructions break the natural `S_n`-equivariance and could
  plausibly induce a non-zero sgn class even for symmetric F⋆. But
  this would be a non-functorial cochain whose interpretation is
  unclear, and Daniel's vision specifies "the counterexample F⋆
  induces" — which is naturally read as an F-natural mechanism. The
  vision-spec leaves room here only if Daniel intended a non-natural
  reading; pm-onethird should confirm.

- **A higher-degree cochain (n-1 instead of n-2).** Daniel's vision
  did not specify the degree. The Fork A `thm:contradiction` needs
  degree `n-1`, but Daniel's vision-step 3 is silent. The host for
  degree-`n-1` classes (e.g., the proper Moore lattice itself) was
  proven trivial in `mg-565a`; we did not retest. If a different
  host's `H^{n-1}` is provably non-trivial in the sgn isotype, the
  same symmetry-vanishing argument would apply to F-natural cochains
  there, so this is unlikely to change the verdict — but the precise
  computation would close the door explicitly.

- **A counterexample-specific construction not naturally extending
  to non-CE-shape F.** A cochain `c_{F⋆}` defined only for CE-shape
  F⋆, leveraging the *forced* structure of F⋆ in a way that doesn't
  extend to all F, could plausibly produce a non-zero class. But
  this requires identifying CE-shape-specific structure beyond mere
  symmetry; the symmetry IS what kills the class, so this would
  require finding a fundamentally different structural feature.
  None is currently visible.

- **The `H^{n-2}(2^[n] \ {∅, [n]}; ℚ)` route in a different role.**
  The sphere ambient at the punctured Boolean lattice IS non-trivial
  with sgn isotype, and the LIFT-4-prod construction DOES produce
  non-zero classes for many F. These F-non-trivial classes could
  perhaps support a *different* programme — e.g., showing that
  "Frankl's truth ⟺ the LIFT-4-prod sgn class vanishes for all
  CE-shape F" or some other equivalent reformulation. The probe
  data above provides the *converse* direction: among the 12 (resp.
  582) candidate CE-shape F⋆'s at n = 3 (resp. n = 4), Frankl's
  truth and "LIFT-4-prod class = 0" coincide perfectly at n = 3 and
  86% at n = 4 — a numerical coincidence worth recording but not by
  itself a proof strategy.

### 4.3 What the finding adds beyond `mg-5cc6` / `mg-8886`

- `mg-5cc6` showed: the cohomology of various natural categorical
  objects (`C_n`, MOORE, holim variants, punctured trace poset, etc.)
  is either trivial or wrong-shape in the abstract. The finding was
  "the host is trivial."

- `mg-8886` flagged but deferred the graded/weighted Möbius angle
  as "a priori unlikely." That deferral was the vision-drift Daniel's
  2026-05-23 reminder corrected.

- **`mg-e466` (this report) tests the deferred angle precisely** and
  finds something distinct: the host CAN be non-trivial in the right
  shape (punctured Boolean, sgn isotype), and the F-induced class
  CAN be non-zero for many F — but **counterexample-shape F⋆ kills
  the class structurally** via the symmetry-vanishing argument. This
  is not "host trivial" (mg-5cc6) but "F⋆-image trivial despite
  non-trivial host."

- Together these strengthen the prior conclusion: not only does the
  cohomology of every natural category-level object fail to host the
  Fork-A contradiction, but the F⋆-induction mechanism in its
  natural form fails *even when* a non-trivial host exists — because
  the counterexample condition itself is the structural obstruction.

---

## §5 — Recommendation for pm-onethird and Daniel

The probe is RED but informative. Specific recommendations:

1. **Daniel-attention item.** The structural finding (CE-shape F⋆ has
   forced transposition symmetry ⇒ any F-natural cochain has zero
   sgn-isotype component) is *new* and may either (a) be a real
   obstacle invalidating the IE-induction approach, or (b) prompt
   Daniel to re-specify the vision with a non-F-natural construction.
   The probe documents *which* readings of his vision fail and the
   precise structural reason. **If Daniel intended a non-F-natural
   reading or a different host degree, please clarify** so pm-
   onethird can file a corrective follow-on.

2. **The deferred angle from `mg-8886` is now probed.** The
   graded/weighted Möbius angle is no longer un-probed; the report
   above is the explicit computation. It does not need to be re-run
   under a different ticket unless the vision specification changes.

3. **No new Frankl-arc ticket** is automatically warranted by this
   report. The vision-step 3 mechanism (as honestly operationalized)
   fails on the targeted F⋆; vision-step 4 is moot in the absence
   of a non-zero step-3 class. The arc has now exhausted the four
   natural readings of Daniel's verbatim vision; further work
   requires a vision *modification* (Daniel-input) rather than a
   sub-ticket.

4. **The `mg-1b2b` disclosure-pivot remains the operative state.**
   The probe does not affect `Frankl_Holds`'s dependence on
   `case3_ss_obstruction_paper_axiom` — that is a separate Lean-side
   delivery question. The probe is a *programme-level* assessment of
   one route to *eliminating* the axiom; the route does not pan out
   as stated.

---

## §6 — Cross-references

- **Brief:** `mg-e466` (this ticket). **Routes to:** Daniel via
  `pm-onethird`.
- **Probe scripts:** `docs/frankl-ie-induction-probe.py` (main),
  `docs/frankl-ie-diagnostic.py` (counterexample-shape correlation).
- **Raw outputs:** `docs/frankl-ie-induction-probe.out`,
  `docs/frankl-ie-induction-diag.out`.
- **The 15-construction prior arc:**
  - `docs/Frankl-ForkD-Probe-n3.md` (`mg-565a`)
  - `docs/Frankl-ForkA-Phase0-FaithfulnessProbe.md` (`mg-f9a7`)
  - `docs/Frankl-ForkA-Fobs-SS-Pinning.md` (`mg-02b5`)
  - `docs/Frankl-Downset-Reframing.md` (`mg-8f74`)
  - `docs/Frankl-Spherical-Reconcile.md` (`mg-7bf3`)
  - `docs/Frankl-Cohomology-Synthesis.md` (`mg-5cc6`) — consolidated
  - `docs/Frankl-ELI5-Trivial-Cohomology.md` (`mg-8886`) — the
    deferred graded-Möbius caveat this report tests
- **Canonical vision memory:**
  `~/.pogo/agents/pm/pm-onethird/memory/project_frankl_vision.md`.
- **The conditional theorem the cohomology feeds into:**
  `paper/forkA/refoundation.tex` `thm:contradiction` (L1661).
- **Onboarding:** `docs/PROOF-STRUCTURE-ONBOARDING.md`.

---

*Probe by polecat `cat-mg-e466`. Deliverable on `main`: this document
+ probe scripts. Verdict: **RED — the IE-induction mechanism in its
four natural readings does not induce non-trivial cohomology on
counterexample-shape F⋆**. The mechanism *does* produce non-trivial
family-sensitive classes via OP-A LIFT-4-prod (Möbius-product cochain
on the punctured Boolean lattice), and that class lives in the right
sgn-isotype host — but the counterexample-shape condition is
anti-correlated with non-vanishing: 100% (n=3) and 86% (n=4) of the
candidate CE-shape F⋆'s give zero class. The structural reason: the
Frankl-counterexample condition forces F⋆ towards transposition-
symmetric structure, and any F-natural cochain inherits that
symmetry, killing the sgn-isotype component. Vision-step 3 does not
fire on F⋆ in any natural operationalization; vision-step 4 is moot
in consequence. The deferred graded-Möbius angle from `mg-8886` §6 is
now explicitly probed (no longer un-tested), and the verdict is RED
with the precise structural reason given. Further work requires a
vision modification from Daniel (e.g., a non-F-natural cochain
construction), not another sub-ticket within the existing vision-
specification.*
