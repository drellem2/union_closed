# Frankl-Enriched-Host-VisionStep4 — enriching the host does **not** rescue vision-step-4

**Work item:** `mg-4052` (`Frankl-Alt-Cochain-Followup-VisionStep4`, `depends: mg-1b24`).
Second-of-three Frankl bypass angles per Daniel's 2026-05-23T05:37Z reminder;
filed by the `mg-1b24` verdict gate ("ANY ALTERNATIVE WORKS → file an n=4 follow-on").
Vision-aligned per `docs/Frankl-Vision.md` **part-4**.

This document records a **RED** verdict: none of the three enriched hosts the
brief names makes the F-induced sgn-twisted class into something a *separate
cohomology-vanishing result* can contradict. Enrichment can make the class
"more than a scalar" (candidate 3 genuinely does), but the extra structure it
exposes is the wrong thing — it is *lost* on exactly the symmetric
counterexamples where the old scalar survives, and no F-independent theorem
forces it to vanish.

**Deliverable:** this document + the self-contained probe
`docs/frankl-enriched-host-probe.py` (n=3 exhaustive over all 12 CE-shape F,
n=4 confirmation over all 582) + raw output `docs/frankl-enriched-host-probe.out`.
Cohomology dimensions cross-checked at two ~2³¹ primes; class vectors are exact
integer arithmetic.

**READ-FIRST consumed:** `docs/Frankl-Vision.md` (canonical vision);
`docs/Frankl-Alt-Cochain-Host-Probe.md` (`mg-1b24`, the GREEN-PARTIAL that this
follows on); `docs/Frankl-IE-Induction-Probe.md` (`mg-e466`, the symmetry
obstruction); `docs/Frankl-Cohomology-Synthesis.md` (`mg-5cc6`).

---

## §0 — Verdict (top of page)

### 0.1 Headline

> **RED.** Enriching the host to break the 1-dimensional degeneracy of
> `H̃^{n-2}(PB_n) ≅ sgn_{S_n}` **does not make vision-step-4 fire.** Concretely,
> across the three enriched hosts named in the `mg-1b24` recommendation:
>
> | Enriched host | Does the class exceed a scalar? | Does a separate result vanish a component F⋆ forces non-zero? | Verdict |
> |---|---|---|---|
> | **(1) product `(PB_n)^k`** | **No** at the top degree (`H^{k(n-2)} ≅ sgn^{⊗k}`, still 1-dim); the degree-`(n-2)` cross-term is rank-2 (`sgn ⊕ sgn` under `Σ_k`) but its non-trivial `Σ_k`-component is **identically 0 for every F** | No | RED |
> | **(2) filtered `PB_n`** (cardinality grading) | **No** — every top chain has `\|σ_0\|=1` and `\|σ_{top}\|=n-1`, so the associated graded is concentrated in one grade ≅ the un-filtered `sgn` line | No | RED |
> | **(3) module-valued `PB_n; std`** | **Yes** — the class is a genuine vector in `sgn⊗std` (dim `n-1`) | **No** — the extra component is the *element-degree-spread*, which (i) is **zero on exactly the symmetric CE-shape F⋆**, so step-3 universality is *lost*, and (ii) has no F-independent vanishing theorem | RED |
>
> The module-valued host (candidate 3) is the only one that genuinely enriches
> the class, and its behaviour is the decisive finding. The `std`-valued class
> vector is **exactly** `(n-1)! · [ψ_x(F)]_{x∈[n]}` where `ψ_x = 2a_F(x) − |F|`
> (verified identically on all 12 CE-shape F at n=3 and all 582 at n=4). Its
> two S_n-isotype pieces are:
>
> - **sgn / mean part** `= (n-1)! · g_DEF(F)` — the *same scalar* the `mg-1b24`
>   probe found, **positive for 100 % of CE-shape F** (universal, per the
>   `mg-1b24` §2.4 positivity bound);
> - **std / spread part** `= (n-1)! · (ψ − mean·𝟙)` — the element-degree spread,
>   **non-zero for only 6/12 (50 %) at n=3 and 540/582 (92.8 %) at n=4**, and
>   **identically zero on every symmetric (degree-regular) CE-shape F⋆.**
>
> So enrichment does *not* strengthen vision-step-3; it *weakens* it (the new
> component vanishes exactly where the counterexample is most symmetric), and it
> offers no separate vanishing theorem for vision-step-4. The contradictive
> layer stays degenerate.

### 0.2 The vision, re-scored after this probe

| Vision-step | `mg-1b24` (1-dim sgn host) | This probe (enriched hosts) |
|---|---|---|
| (1) F⋆ exists | YES (CE-shape) | YES (CE-shape) |
| (2) IE applied to F⋆ | sgn-twist × (deficit / count) | same, lifted to `(PB_n)^k` / filtered / `std`-valued |
| (3) Induced class non-trivial on F⋆ | YES — scalar `g_F ≥ 1` (100 %) | **WEAKER** on the only host that enriches (candidate 3): the *new* std-component is non-zero on **only 50 % (n=3) / 92.8 % (n=4)** of CE-shape F, and 0 on the symmetric ones. The old scalar part survives at 100 %. |
| (4) Separate result contradicts | DOES NOT FIRE — `g_F > 0` explicit, host `sgn ≠ 0` | **DOES NOT FIRE** — candidate 1 collapses to a scalar / an identically-zero component; candidate 2's filtration is trivial; candidate 3's `sgn⊗std` host is **irreducible** (no proper equivariant subspace to vanish) and the only equivariant "separate result", *degree-spread = 0*, is (a) FALSE generically and (b) **satisfied by exactly the symmetric counterexamples** — it is consistent with F⋆, not contradictory. |

### 0.3 The structural wall, in one line

> **Pairing the sgn-twisted lift `c_F(chain) = sgn(π_chain)·h_F(chain)·v(chain)`
> against the sgn fundamental cycle `z_chain = sgn(π_chain)` cancels the
> sgn-twist** (`sgn² = 1`), so the enriched class-vector is
> `V_c(F) = Σ_chain h_F(chain)·v(chain)` — an orbit-sum of **strictly F-natural**
> data. Its coordinates are strictly-F-natural invariants (degree moments).
> Vision-step-4 needs a separate result that vanishes such a coordinate while
> F⋆ forces it non-zero — impossible: a strictly-F-natural invariant a theorem
> kills is killed for F⋆ too (consistency, not contradiction), and the one
> universally-positive coordinate (`g_F`) has no vanishing theorem. The sgn-twist
> that bought non-vanishing on the scalar host is annihilated by the enrichment
> pairing.

---

## §1 — Setup

The base host is the punctured Boolean order complex
`PB_n = Δ(2^{[n]} \ {∅, [n]})`, homotopy-equivalent to `S^{n-2}`, with
`H̃^{n-2}(PB_n; ℚ) ≅ sgn_{S_n}` (one-dimensional). Top-dim chains
`σ_0 ⊊ ⋯ ⊊ σ_{n-2}` correspond bijectively to permutations `π_chain ∈ S_n`, and
the map `chain ↦ sgn(π_chain)` is the canonical generator (the "Pascal cocycle").

**Fundamental cycle.** The probe verifies computationally (`verify_fundamental_cycle`)
that `z_chain := sgn(π_chain)` is a genuine `(n-2)`-cycle (`∂z = 0`) at n=3 and
n=4 — i.e. `sgn(π_chain)` is the fundamental class of the sphere, so the
cohomology class of any top cochain `c` is read off by the pairing
`[c] = Σ_chain z_chain · c(chain)`.

The `mg-1b24` mechanism: for `c_F(chain) = sgn(π_chain)·h_F(chain)` with `h_F`
strictly F-natural, `[c_F] = Σ_chain sgn(π)²·h_F = Σ_chain h_F(chain) = g_F` — a
scalar. The follow-on question: enrich the host so `[c_F]` is a vector, and find
a separate result vanishing part of it.

---

## §2 — Candidate 1: multi-component host `(PB_n)^k`

**Künneth (probe `kunneth_report`, verified dims).** `PB_n` has reduced
cohomology only in degree `n-2` (`≅ sgn`). Hence for the double product:

```
(PB_3)^2 :  H^0=1,  H^1=2 [sgn⊕sgn],  H^2=1 [sgn⊗sgn]
(PB_4)^2 :  H^0=1,  H^2=2 [sgn⊕sgn],  H^4=1 [sgn⊗sgn]
```

- **Top degree `2(n-2)`** carries `H^{n-2}⊗H^{n-2} = sgn⊗sgn`, which is
  **1-dimensional** as an `S_n`-rep (`sgn^{⊗2} = triv`). The F-induced product
  class is `g_F² · (ω⊗ω)` — a scalar again. Degenerate for every `k`:
  `sgn^{⊗k}` is always 1-dimensional (`sgn` for odd `k`, `triv` for even `k`).

- **Cross degree `n-2`** carries `H^0⊗H^{n-2} ⊕ H^{n-2}⊗H^0 = sgn ⊕ sgn`,
  genuinely **rank-2**, with the factor-swap `Σ_2` exchanging the two lines —
  this is the "rank-2" the `mg-1b24` recommendation anticipated. But the natural
  F-induced class puts the sgn-cochain `c_F` on one factor and the unit on the
  other; the probe (`candidate1_discrimination`) confirms **both cross-components
  equal the same scalar `g_F` for all 12 (n=3) / 582 (n=4) CE-shape F**, so the
  `Σ_2`-antisymmetric component is **identically 0 for every F**. A "separate
  result: antisymmetric part = 0" is therefore true for F⋆ *and* every non-F⋆
  alike — no contradiction. The rank-2 module carries no F-information beyond
  `g_F`.

**Verdict: RED.** The product host either collapses to a scalar (top degree) or
exposes only an identically-zero component (cross degree). No discrimination.

---

## §3 — Candidate 2: filtered host (cardinality grading)

Filter the top cochain group of `PB_n` by the cardinality of the chain endpoints.
The probe (`filtered_assoc_graded_report`) records the decisive obstruction:

- Every top chain `σ_0 ⊊ ⋯ ⊊ σ_{n-2}` has `|σ_0| = 1` (bottom is always a
  singleton) and `|σ_{n-2}| = n-1` (top is always an `(n-1)`-set). So a
  filtration by `|σ_0|` or `|σ_{top}|` places the **entire** top cochain group in
  a **single grade**, and the associated graded is `≅` the un-filtered `sgn`
  line — no higher-dimensional `S_n`-rep appears.

Any cardinality-based filtration of the top cochains is trivial for this reason:
the intermediate cardinalities `|σ_i| = i+1` are *forced* along every maximal
chain of the Boolean lattice, so grading by any single `|σ_i|` is constant across
all top chains. The associated graded never splits into higher reps.

**Verdict: RED.** The natural filtrations do not enrich the top cohomology; the
graded pieces reproduce the same 1-dim `sgn` scalar.

*(A filtration that grades the coefficient sheaf rather than the base chains is a
module-valued construction — that is candidate 3, §4.)*

---

## §4 — Candidate 3: module-valued host `H^{n-2}(PB_n; std)` — the decisive case

Take constant coefficients in the standard rep `std_{S_n}` (dim `n-1`), realized
inside the permutation module `M = ℚ^n`. With **constant** coefficients the
cochain complex is `C^*(PB_n)⊗M`, so
`H^{n-2}(PB_n; M) = H^{n-2}(PB_n; ℚ) ⊗ M = sgn ⊗ M`, and the class of a top
`M`-valued cochain `c` is the vector

```
V_c(F) = Σ_chain z_chain · c_F(chain) = Σ_chain sgn(π_chain) · c_F(chain) ∈ M = ℚ^n.
```

Lift the `mg-1b24` cochain to `M` by attaching a natural `M`-vector `v(chain)`:
`c_F(chain) = sgn(π_chain) · h_F(chain) · v(chain)`. The sgn-twist cancels
against `z`:

```
V_c(F) = Σ_chain h_F(chain) · v(chain).
```

### 4.1 The exact identity (proved & verified)

Take `h_F(chain) = ψ_{x_new}(F)` (SGN-DEFICIT's scalar, `x_new = σ_{n-2}\σ_{n-3}`)
and `v(chain) = e_{x_new}`. Grouping permutations by their new-element `x_new`
(each `x` occurs for `(n-1)!` chains):

```
V_c(F) = (n-1)! · Σ_{x∈[n]} ψ_x(F) · e_x  = (n-1)! · [ψ_x(F)]_{x∈[n]}.
```

The probe (`verify_identity`) confirms `V_c(F) == (n-1)! · [ψ_x(F)]_x`
**identically on all 12 CE-shape F at n=3 and all 582 at n=4.** Splitting
`ℚ^n = triv ⊕ std`:

| Component | Formula | Non-zero on CE-shape F⋆ |
|---|---|---|
| **triv / mean** (the sgn-isotype of `sgn⊗ℚ^n`) | `(n-1)! · Σ_x ψ_x(F) = (n-1)!·n·g_DEF(F)` | **100 %** — the `mg-1b24` scalar, `g_DEF ≥ 1` (§2.4 positivity) |
| **std / spread** (the `sgn⊗std` isotype) | `(n-1)! · (ψ − mean·𝟙)` = element-degree spread | **50 % (6/12) n=3, 92.8 % (540/582) n=4** |

### 4.2 The class is "more than a scalar" — but the extra part is the wrong thing

The std-component is `(n-1)!` times the **element-degree spread**
`ψ_x − mean = 2(a_F(x) − ā)`, i.e. it measures how *unequal* the element
frequencies `a_F(x)` are. This is genuinely a vector (candidate 3 does enrich the
class), but it is exactly the quantity the Frankl-counterexample condition
*suppresses*:

> **The rare-elementlessness condition `2a_F(x) > |F|` for all `x` pushes the
> element frequencies together; the *most symmetric* counterexamples are
> degree-regular (`a_F(x) ≡ const`), and there the std-component is identically
> zero** while the old scalar `g_DEF` stays positive.

The probe lists these explicitly. At n=3 the three transitive-stabilizer
CE-shape families

```
[{1,2}{1,3}{2,3}{1,2,3}]           |Stab|=6, std=[0,0,0], g_DEF-sum=6 (>0)
[∅ {1,2}{1,3}{2,3}{1,2,3}]         |Stab|=6, std=[0,0,0], g_DEF-sum=3 (>0)
[{1}{2}{3}{1,2}{1,3}{2,3}{1,2,3}]  |Stab|=6, std=[0,0,0], g_DEF-sum=3 (>0)
```

all have **zero** std-component and **positive** scalar. At n=4 there are 42 such
CE-shape F (582 − 540), including the fully-symmetric families with `|Stab| = 24`.
This is the exact inverse of what vision-step-3 needs on an enriched host: the
enrichment's new direction *dies* precisely on the symmetric F⋆.

### 4.3 Why no separate result fires (vision-step-4)

`H^{n-2}(PB_n; std) = sgn ⊗ std = S^{(2,1^{n-2})}` is **irreducible** (dim `n-1`).
An irreducible `S_n`-module has no proper `S_n`-subrepresentation, so **there is
no equivariant "separate result" that vanishes a proper component** of the class
— the only equivariant linear vanishing conditions are `0` and "the whole class
`= 0`". Concretely the candidate separate results all fail:

| Shape of separate result | Status on candidate 3 |
|---|---|
| `H^{n-2}(PB; std) = 0` | FALSE — it is `sgn⊗std ≠ 0` |
| `sgn⊗std`-isotype `= 0` | FALSE — the host *is* that isotype |
| a proper sub-isotype of the class `= 0` | NONE — the target is irreducible |
| "element-degree spread `= 0` for Frankl F⋆" (the only equivariant scalar condition) | **FALSE, and worse: satisfied by exactly the symmetric F⋆** — it is *consistent with* the counterexample, not contradictory |

Using the reducible module `M = ℚ^n = triv ⊕ std` instead only re-exposes the two
pieces of §4.1: the `triv`-piece is the old universally-positive `g_DEF` (no
vanishing theorem — the host `sgn` line is non-zero), and the `std`-piece is the
degree spread (no vanishing theorem, and not even universally non-zero on F⋆).
Neither routes vision-step-4.

**Verdict: RED.** The module-valued host makes the class a vector, but the vector
is an orbit-sum of strictly-F-natural degree data; its universally-non-zero part
is the old scalar (unvanishable), and its genuinely-new part is the degree spread
(neither universal nor vanishable).

---

## §5 — The general wall

The three candidates fail for a single reason that applies to **any** host
enrichment carrying the class as `(sgn fundamental cocycle) ⊗ (strictly-F-natural
data)`:

1. The host's fundamental cycle transforms by `sgn` (it is the top class of a
   sphere `S^{n-2}` with the reflection `S_n`-action). Pairing the sgn-twisted
   lift against it **cancels the twist** (`sgn² = 1`).
2. Therefore the enriched class-vector `V_c(F) = Σ_chain h_F(chain)·v(chain)` has
   coordinates that are **strictly-F-natural invariants** (orbit sums of
   `h_F·v` — degree moments, member-count moments, Möbius moments).
3. Vision-step-4 needs an F-independent theorem forcing one coordinate to vanish
   while F⋆ forces it non-zero. But a *strictly-F-natural* coordinate that a
   separate theorem sets to zero is set to zero **for F⋆ as well** (F⋆ is one of
   the F's the theorem ranges over) — consistency, not contradiction. The only
   coordinate that is universally non-zero on F⋆ is the mean part `g_F`, and it
   lives in the non-zero `sgn` line — no theorem vanishes it.

The sgn-twist is what evaded `mg-e466`'s symmetry-vanishing on the **scalar**
host (it placed the class in the sgn-isotype). Enrichment pairs it back against
the sgn fundamental cycle and annihilates exactly that gain. **Non-vanishing on
F⋆ and the availability of a separate vanishing theorem are in direct tension for
the whole sgn-twisted *F-natural* family** — independent of which host carries
the coefficients.

The escape hatch is precisely the remaining angle: **break F-naturality at the
cochain level** (`mg-e1e2`), so the class coordinates are *not* strictly-F-natural
invariants and a naturality/cocycle constraint can force a coordinate to vanish
for structural reasons while F⋆ (which violates that constraint) forces it
non-zero. That is a genuinely different mechanism from host enrichment and is not
touched by the wall above.

---

## §6 — Recommendation

**RED on host enrichment.** Candidates 1–3 exhaust the "make the sgn-twisted
F-natural class more than a scalar" program:

- (1) product hosts collapse to a scalar (`sgn^{⊗k}` is 1-dim) or expose an
  identically-zero component;
- (2) cardinality filtrations are trivial on the forced-cardinality Boolean
  chains;
- (3) module-valued hosts do enrich the class, but only into the element-degree
  spread — lost on the symmetric counterexamples and unvanishable by any separate
  result (irreducible target).

Per the `mg-1b24` verdict structure this **closes the sgn-twisted F-natural
angle**: the mechanism gives an explicit positive scalar `g_F⋆ ≥ 1` (great for
vision-step-3) that no host enrichment can convert into a step-4-contradictable
higher class, because enrichment cancels the very twist that made step-3 fire.

**The last remaining angle is `mg-e1e2` (the F-non-natural route)** — break
F-naturality at the cochain level rather than at the host/equivariance level. This
is consistent with the `mg-1b24` §3.4 recommendation and is the only path left
that could produce a non-degenerate contradictive layer.

### Vision check

This follow-on targets **vision-part-4** ("a separate result about the category's
cohomology contradicts the F-induced class"). The finding: on every naturally
enriched host, the F-induced sgn-twisted class decomposes into a
universally-positive scalar (no vanishing theorem) plus strictly-F-natural
coordinates (vanishable only in ways consistent with F⋆). Vision-part-4 **cannot
fire** through host enrichment of a sgn-twisted F-natural cochain. Vision-part-3
remains satisfied (the scalar `g_F⋆ ≥ 1`), unchanged from `mg-1b24`.

---

## §7 — Cross-references

- **Ticket:** `mg-4052` (this document).
- **Canonical vision:** `docs/Frankl-Vision.md`.
- **Predecessor (mg-1b24):** `docs/Frankl-Alt-Cochain-Host-Probe.md` —
  GREEN-PARTIAL; scalar host; this follow-on tests host enrichment.
- **Symmetry obstruction (mg-e466):** `docs/Frankl-IE-Induction-Probe.md`.
- **Synthesis (mg-5cc6):** `docs/Frankl-Cohomology-Synthesis.md`.
- **F-non-natural route (the remaining angle):** `mg-e1e2` /
  `docs/Frankl-NonNatural-Cochain-Probe.md`.
- **Probe (this ticket):** `docs/frankl-enriched-host-probe.py` (n=3 exhaustive,
  n=4 confirmation) + `docs/frankl-enriched-host-probe.out` (raw output).

---

*Probe by polecat `cat-mg-4052`. Deliverable on `main`: this document + probe
script + raw output. Verdict: **RED — host enrichment does not rescue
vision-step-4; the sgn-twist that makes step-3 fire on the scalar host is
annihilated by the enrichment pairing, so the enriched class is an orbit-sum of
strictly-F-natural data with no separately-vanishable component that F⋆ forces
non-zero. The sgn-twisted F-natural angle is closed; the F-non-natural route
(mg-e1e2) is the last remaining angle.***
