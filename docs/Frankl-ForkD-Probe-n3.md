# Frankl-ForkD-Probe — bounded n=3 probe of the Moore-family-lattice cohomology

**Work item:** `mg-565a` (Frankl-ForkD-Probe). Per the `mg-6edc`
Frankl-Vision-Check verdict (`docs/Frankl-vision-check.md`, §§6–7). The
vision-check found the built Frankl proof PARTIAL-MATCHES Daniel's vision
with structural drift at three points, found that the `mg-0405` Phase-1.5
wall is a consequence of that drift, and identified a **Fork D**: re-found
the cohomology on the category's *own* cohomology — the nerve / order
complex of the category of intersection-closed families under inclusion
(the Moore-family lattice), `sgn`-`S_n`-graded, Walsh kept only as the
harmonic description of the obstruction cochain. The vision-check's §6.5
flagged Fork D's single open prerequisite (`D-prereq`): the category's
intrinsic cohomology must be **non-trivial and family-sensitive**. This
ticket runs that decisive bounded prerequisite probe at `n = 3`.

**READ-FIRST consumed:** `docs/Frankl-vision-check.md` (`mg-6edc`, §§6–7);
`docs/Frankl-Y1-phase1.5-bk-structure-maps.md` (`mg-0405`, the §6 fork);
`docs/PROOF-STRUCTURE-ONBOARDING.md`; `docs/union-closed-UC9-...md` (§D-4,
the punctured Boolean cube `≃ S^{n-2}`); `docs/union-closed-UC10-...md`
(§0.1 the Moore-family / closure-system framing, §2 the category `𝒞_n^∩`).

**Scope.** A bounded, reproducible `n = 3` computation — not the multi-week
Y1 residual. Deliverable: this document plus the computation script
`docs/frankl-forkd-probe-n3.py` (self-contained, no dependencies; runs in
~1.3 s). `pm-onethird` relays the verdict to Daniel; it directly informs
the pending `mg-0405` §6 design decision.

---

## §0 — Verdict (top of page)

### 0.1 Headline

> **NO — FORK-D-NOT-VIABLE; THE C1 / U1-WALL OBSTACLE IS REALISED.** The
> order complex / nerve of the Moore-family lattice on `[3]` — the literal
> Fork-D cohomology object, the F-series `Δ(PPF_n)` analog the vision names
> — is **rationally acyclic**. The whole lattice is contractible (it has a
> top and a bottom, so its nerve is a cone); its **proper part** `P̄`
> (the lattice with `0̂` and `1̂` removed — the genuine analog of
> `Δ(PPF_n)`) has **`H̃^k(Δ(P̄);ℚ) = 0` for every `k`**, reduced Euler
> characteristic `0`, Möbius function `μ(0̂,1̂) = 0`. There is no sphere,
> no `sgn_{S_3}` class, no cohomology of any kind. Gate (a) — *non-trivial*
> — **fails**; gate (b) — *family-sensitive* — fails *a fortiori* (a zero
> cohomology distinguishes nothing and can detect no counterexample). The
> result is robust: it holds at `n = 2` as well, and under both
> `∅`-conventions. **Fork D, as literally specified — the category's bare
> nerve — is not viable.** Per this ticket's own decision rule, **Fork A
> (the covariant hocolim) becomes the live option.**

### 0.2 The two gates, scored

| Gate | Question | Result | Evidence |
|---|---|---|---|
| **(a) non-trivial** | Is `H̃^*(Δ(P̄);ℚ) ≠ 0`? Is it spherical? | **NO — `Q`-acyclic.** Every reduced Betti number is `0`. | §3. `χ̃ = 0`; mod-`p` rank at two `~2^31` primes, agreeing. |
| **(b) family-sensitive** | Does the cohomology distinguish family structure / detect a minimal counterexample? | **NO — for the bare nerve.** A zero cohomology is the strongest form of family-blindness: it carries *no* family-level information, and adding/removing any family (a counterexample included) leaves it zero. | §4. |

### 0.3 The constructive half of the finding — where the content actually is

The probe is not purely negative. It locates, precisely, *where* the
family-sensitive spherical content the vision wants does live — and it is
**not** the bare nerve of the lattice:

- **Per family, the sphere is real.** Each Moore family `𝓕`, viewed as the
  poset of its own member sets, has an order complex whose homotopy type
  **genuinely varies** across the 61 families (5 distinct reduced-homology
  profiles), and **correlates with the Frankl data** (rare-coordinate
  count). The maximal family `2^[3]` gives the punctured Boolean cube
  `≃ S^1` with `H̃^1 ≅ sgn_{S_3}` — exactly the F-series sphere, exactly
  `UC9 §D-4`.
- **But that sphere belongs to a *coefficient system over* the lattice, not
  to the lattice's nerve.** The vision-check's §6.5 plausibility argument
  ("a sphere is natively present in the inclusion picture") was a **category
  error**: it pointed at the per-*family* poset (`2^[n]∖{∅,[n]}`) and
  attributed the sphere to the Moore-family *lattice*. The two are
  different posets (§5). The sphere is in the former; the latter is acyclic.

This is the decisive structural fact: **the family-sensitive cohomological
content can only be carried by a non-constant coefficient diagram over the
Moore-family lattice — never by the lattice's bare nerve.** That is exactly
the object `UC10` built (`Drift B`, the "C1 dodge") and exactly the object
`Fork A` keeps (the covariant `hocolim_{𝒞_n^∩} X(𝓕)`). The probe therefore
**vindicates `UC10`'s `Drift B` as a forced move, not gratuitous drift**,
and **converts the vision-check's §5.4 hedge into a confirmed fact**: the
bare order complex of the category *is* trivial, so a coefficient diagram
*is* mathematically necessary.

### 0.4 What this means for the `mg-0405` §6 fork

The vision-check (`mg-6edc` §6) ranked the forks: rule out **Fork B**
(abandons intersection-closure); treat **Fork A** as a variance stopgap;
re-found on **Fork D** if its prerequisite holds. **This probe settles the
prerequisite: it does not hold.** Therefore:

- **Fork D is off the table** as a *re-foundation*. The category's own
  cohomology — its bare nerve — is `0`. It cannot host an obstruction
  class; it cannot detect a counterexample; it is the U1 wall in new
  clothes.
- **Fork A is the live option**, exactly as this ticket's NO-branch
  decision rule states. And the probe gives Fork A a *positive*
  endorsement, not merely a default one: the family-sensitive content
  provably lives in the coefficient diagram `𝓕 ↦ X(𝓕)`, which is precisely
  what Fork A's covariant hocolim integrates. The cohomology Fork A
  computes — `H^*(𝒞_n^∩; X(−))`, the cohomology of the category *with
  coefficients* — is the right object; the bare `H^*(B𝒞_n^∩)` is not.
- **Fork B stays ruled out** (vision-check §6.2 — unaffected by this
  probe).

Fork A still owes the two debts `mg-0405` §6 and the vision-check §7.3
recorded, and this probe does not discharge them: the `(ℤ/2)ⁿ` / Walsh
gap `(c)` (Fork A "does not solve" it — `mg-0405` §6), and the deeper
clause-`(V3)` faithfulness risk (does the coefficient cohomology genuinely
*see* the counterexample, or is `ob` family-blind — the `wrapper-risk`).
Those remain open; see §7.

---

## §1 — Scope, method, the object probed

### 1.1 What Fork D's prerequisite asks

The vision-check `mg-6edc` §6.4 defines Fork D: take the category of
intersection-closed families with **inclusion** morphisms (the Moore-family
lattice — the literal `PPF_n` analog), take its **order complex / nerve**
as the cohomology object ("no coefficient diagram, no structure maps"),
grade by `sgn_{S_n}`. §6.5 isolates the one open prerequisite:

> **(D-prereq)** The category of intersection-closed families, with its own
> cohomology (nerve / order complex), must be **non-trivial and
> family-sensitive** — its cohomology must genuinely *see* a
> counterexample, not be contractible or family-independent.

The vision-check §7.3 recommendation 2 turns this into the present probe:
*"compute the order complex of intersection-closed families on `[3]` under
inclusion, with the `S_n`-action. If yes, Fork D is the foundation … if no
… the C1 / U1-wall obstacle [is] realised … Fork A becomes the live
option."* This document is that computation.

### 1.2 The object, fixed precisely

The probe object is the **Moore-family lattice on `[3]`** — call it
`Poset B`. Per `UC10 §0.1`, intersection-closed families *are* the **Moore
families / closure systems**: subsets of `2^[n]` closed under intersection.
`UC10`'s category `𝒞_n^∩` fixes the ground set and requires `[n] ∈ 𝓕` and
`⋃𝓕 = S` (`mg-0405` §1.3); with `S = [3]` fixed and `[3] ∈ 𝓕`, the
condition `⋃𝓕 = [3]` is automatic, so the objects on ground set `[3]` are
**exactly the Moore families on `[3]`**. Ordered by family-inclusion
(`𝓕 ⊆ 𝓖` as sets-of-sets — the "inclusion / refinement" morphisms Fork D
prescribes, undoing `Drift A`), they form a lattice.

The "cohomology of the category" is the cohomology of its **nerve**, which
for a poset is the **order complex** `Δ` — the simplicial complex whose
`k`-simplices are the `(k+1)`-chains. This is the F-series convention
exactly: `Δ(PPF_n)` is the order complex of the category of posets.

Two posets must be kept rigorously apart, because the vision-check
conflated them (§5):

- **`Poset B` — the Moore-family lattice.** Elements = Moore families on
  `[3]`; order = family-inclusion. This is the probe object.
- **`Poset A` — a single family as a poset of its own member sets.** For a
  fixed `𝓕`, the elements are the sets `A ∈ 𝓕`, ordered by `⊆`. This is a
  *per-family* object, one per element of `Poset B`.

### 1.3 Method

A from-scratch, reproducible computation (`docs/frankl-forkd-probe-n3.py`).
All homology is **reduced, over `ℚ`**, computed by sparse Gaussian
elimination of the simplicial boundary matrices modulo a large prime.
Rigour note: `dim_ℚ H̃^k ≤ dim_{𝔽_p} H̃^k` for *every* prime `p`, so a
single prime returning `0` already *proves* `ℚ`-acyclicity; the script
nonetheless cross-checks two independent `~2^31` primes, and they agree.
The machinery is **self-tested**: it reproduces the known order complexes
`Δ(2^[3]∖{∅,[3]}) ≃ S^1` and `Δ(2^[4]∖{∅,[4]}) ≃ S^2` exactly (script
block `R1`). The `S_3`-action is read off via the Hopf trace formula:
`Σ_k (−1)^k tr(g | H̃_k) = χ̃(Δ(P̄^g))`, the reduced Euler characteristic
of the order complex of the `g`-fixed subposet.

---

## §2 — The Moore-family lattice on `[3]`

**Enumeration.** There are exactly **61** Moore families on `[3]`
(intersection-closed, containing `[3]`) — the classical count
`1, 2, 7, 61, 2480, …` of closure systems. All 61 have `⋃𝓕 = [3]`.

**Lattice structure.** The poset `(MOORE, ⊆)` is a **bounded lattice**:

- **Bottom `0̂ = {[3]}`** — the trivial one-set family (the family
  `Frankl_Holds` excludes via `h_ne : F.family ≠ {univ}`). Every Moore
  family contains `[3]`, so `{[3]}` sits below all of them, and it is
  itself a valid object.
- **Top `1̂ = 2^[3]`** — the full powerset (the `fullPowerset3` family).
- Meets exist (the intersection of two Moore families is a Moore family —
  verified for all `61·60/2` pairs); with a top, a meet-semilattice is a
  lattice. 7 atoms, 3 coatoms.

Because the lattice has a `0̂` and a `1̂`, its nerve `Δ(MOORE)` is a
**cone** (twice over) — **contractible**, `H̃^* = 0`. Confirmed by direct
computation (script `A1`). *The naive "cohomology of the category" is
trivial for the trivial reason; one must puncture.* This is standard
topological-combinatorics practice — `Δ(PPF_n)`, the partition lattice
`Π_n`, every lattice — one always works with the **proper part**.

**The proper part.** `P̄ := MOORE ∖ {0̂, 1̂}` — **59 elements**. This is
the genuine F-series analog of `Δ(PPF_n)`, and the object `(D-prereq)` is
about.

---

## §3 — Gate (a): is the cohomology non-trivial? — **NO**

The order complex `Δ(P̄)` of the 59-element proper part:

| dim `k` | 0 | 1 | 2 | 3 | 4 | 5 |
|---|---|---|---|---|---|---|
| # `k`-simplices (chains) | 59 | 553 | 1893 | 2970 | 2184 | 612 |

**Reduced cohomology.**

> `H̃^k(Δ(P̄); ℚ) = 0` **for every `k`.**

Reduced Euler characteristic `χ̃(Δ(P̄)) = −1 + 59 − 553 + 1893 − 2970 +
2184 − 612 = 0`, which is the **Möbius function `μ_{MOORE}(0̂,1̂) = 0`**
of the Moore-family lattice. Every reduced Betti number is `0` — verified
by sparse modular rank at two independent `~2^31` primes (agreeing), which
*proves* `ℚ`-acyclicity (§1.3).

`Δ(P̄)` is therefore a **rational homology point**. It is:

- **not a sphere** — the F-series template wants `Δ(P̄) ≃ S^{n-2} = S^1`
  with `H̃^1` one-dimensional; the probe finds `H̃^1 = 0`;
- **not a wedge of spheres**, not concentrated-in-one-degree, not
  non-trivial in *any* degree — it is acyclic outright.

**The `S_3`-grading.** `S_3` permutes `[3]`, hence acts on Moore families,
hence on `P̄`. The virtual character `Σ_k (−1)^k [H̃_k]` is computed from
the fixed subposets:

| `g` | `\|P̄^g\|` | `χ̃(Δ(P̄^g))` |
|---|---|---|
| `e` | 59 | 0 |
| `(12)` | 13 | 0 |
| `(123)` | 2 | 0 |

The virtual character is `(0,0,0)` — the **zero representation**. There is
no trivial isotype, no `sgn_{S_3}` isotype, no standard isotype: the
vision's target `H^{n-2} ≅ sgn_{S_n}` is absent because the cohomology is
absent.

**Robustness (script `R2`/`R3`).** The finding is not an `n=3` accident
nor a convention artefact:

- **`n = 2`:** the Moore-family lattice on `[2]` has 7 elements; its
  proper part (5 elements) is `ℚ`-acyclic, `μ(0̂,1̂) = 0`. The template
  would want `S^{n-2} = S^0` here — it is absent already.
- **`n = 3`, `∅`-variant:** restricting to intersection-closed families
  that contain *both* `∅` and `[3]` (45 families) — proper part again
  `ℚ`-acyclic, `μ = 0`.

The F-series template produces `S^{n-2}` at *every* `n` (`S^0` at `n=2`,
`S^1` at `n=3`, …). The Moore-family lattice produces a `ℚ`-acyclic proper
part at *both* `n` probed, under *both* conventions. **The template does
not transfer.** Gate (a) fails decisively.

---

## §4 — Gate (b): is the cohomology family-sensitive? — **NO** (for the bare nerve)

Gate (b) asks whether the cohomology "genuinely distinguishes the family
structure … the cohomology must be able to detect a minimal
counterexample." For the bare nerve of the lattice this is moot, and in
the worst possible way:

- `H̃^*(Δ(P̄)) = 0` is a **single, family-independent invariant** — the
  same (zero) object for every input. It carries **no** family-level
  information of any kind.
- A "minimal counterexample" at `n = 3` would be a Moore family `F⋆` with
  no rare coordinate (`β_x(F⋆) > 0` for all `x`). The probe confirms
  **Frankl holds at `n = 3`**: all 60 non-trivial Moore families have a
  rare coordinate (`β_x ≤ 0` for some `x`), so no `F⋆` exists. But the
  point is structural: `F⋆` would be *one more element of the same
  61-element lattice*. The nerve of the whole lattice is contractible and
  the nerve of the proper part is acyclic **regardless of which families
  are counterexamples** — there is literally no class that could be
  non-zero on `F⋆`. The cohomology cannot detect a counterexample because
  it cannot detect *anything*.

This is the U1 wall (`UC9`) realised exactly: an intrinsic object whose
invariant is family-independent and therefore useless. Gate (b) fails.

**But the family-sensitive content is real — it just is not here.** The
probe computed two further objects, and both *do* vary with the family:

- **Per-family cohomology (`Poset A`).** For each Moore family `𝓕`, the
  punctured poset of its member sets `(𝓕 ∖ {∅,[3]}, ⊆)` has an order
  complex. Across the 61 families there are **5 distinct reduced-homology
  profiles** (42 acyclic; 15 with `H̃^0=1`; 2 with `H̃^{-1}=1`; 1 with
  `H̃^0=2`; 1 with `H̃^1=1`). And the homotopy type **correlates with the
  Frankl data**:

  | rare-coordinate count of `𝓕` | per-family reduced-homology rank |
  |---|---|
  | 1 rare coord | `0` (acyclic) — all 15 |
  | 2 rare coords | `0`–`1` |
  | 3 rare coords | `1`–`2` |

  The maximal family `𝓕 = 2^[3]` (all three coords rare, `β_x = 0`) gives
  the punctured Boolean cube `≃ S^1`, and its `S_3`-character is
  `(1,−1,1) = sgn_{S_3}` exactly — the F-series sphere, confirming
  `UC9 §D-4`.

- **Lattice intervals (`(0̂, F)`).** The open down-interval below each
  family also varies — 4 distinct interval-homology profiles — though
  most (35/61) are contractible and the non-trivial ones are small.

So the spherical, `sgn`-graded, family-sensitive content the vision wants
**exists** — in the per-family complexes — but it is **not an invariant of
the lattice's nerve**. It is data attached to the *elements* of the
lattice, i.e. a **non-constant coefficient system over the lattice**.

---

## §5 — Why the template does not transfer: two posets, one conflation

The vision-check `mg-6edc` §6.5 gave Fork D its central plausibility
argument:

> *"the **punctured Boolean cube** `2^[n] ∖ {∅,[n]}` — itself the maximal
> intersection-closed family — has order complex `≃ S^{n-2}` already
> (`UC9 §D-4`); a sphere is natively present in the inclusion picture."*

This probe shows that argument **conflates the two posets of §1.2**:

- `2^[n] ∖ {∅,[n]}` ordered by `⊆` is **`Poset A` for the single family
  `𝓕 = 2^[n]`** — one element of the Moore-family lattice, viewed
  internally as a poset of *its own member sets*. Its order complex is
  `≃ S^{n-2}`. **True** — confirmed by the probe's self-test.
- The **Moore-family lattice** is **`Poset B`** — the poset whose
  *elements are entire families*. Fork D's cohomology object is the nerve
  of `Poset B`. Its proper part is `ℚ`-**acyclic**.

"A sphere is natively present in the inclusion picture" is true of
`Poset A` and false of `Poset B`. Fork D's object is `Poset B`. The
vision-check attributed `Poset A`'s sphere to `Poset B` and so
over-rated Fork D's prerequisite. The probe corrects this: the inclusion
order *of member sets within one family* is spherical; the inclusion order
*of families within the lattice* is not.

**Why, structurally.** The Moore-family lattice is "fat": it is a genuine
lattice with `0̂`, `1̂`, abundant comparabilities and abundant meets/joins
(7 atoms, 3 coatoms, every pair has a meet). Such lattices very commonly
have contractible proper parts — `μ(0̂,1̂) = 0` is the homological
signature, and the probe finds exactly `μ = 0`. By contrast `Δ(PPF_n)` is
spherical because `PPF_n` is the proper part of a lattice with a very
specific extremal structure (the F-series cofiber-Morse geometry). The
Moore-family lattice simply does not share that geometry — and `n = 3`,
where the F-series already shows its `S^1`, is enough to see the
difference cleanly.

**Consequence — `UC10`'s `Drift B` was forced.** The vision-check §5.4
stated the honest counter-consideration as a hedge:

> *"if the bare order complex of the category is likewise trivial … a
> coefficient diagram (`Drift B`) is forced — you need a non-constant local
> system to get any content."*

The probe **discharges the hedge as a fact**. The bare order complex *is*
trivial. A non-constant coefficient system *is* forced. `UC10`'s `Drift B`
— replacing the bare nerve with `hocolim X(𝓕)`, the "C1 dodge" — was
**not gratuitous drift; it was a mathematically necessary response to a
real obstacle.** The vision-check was right that `Drift B` moved off the
template; this probe shows the template had nothing to offer at that
point.

---

## §6 — The verdict for the `mg-0405` §6 fork

### 6.1 Decision

This ticket's brief fixes the decision rule:

> *If NO (trivial or family-blind): the C1 / U1-wall obstacle is realised …
> Fork A (the variance stopgap) becomes the live option.*

The probe returns **NO**: the Moore-family lattice's intrinsic nerve
cohomology is `ℚ`-acyclic — trivial, and therefore family-blind. The
C1 / U1-wall obstacle is realised. **Fork A is the live option.**

### 6.2 Fork A, endorsed — not merely defaulted to

The probe does better than eliminate Fork D by elimination. It identifies
*positively* what carries the content:

- The family-sensitive, spherical, `sgn`-graded content **provably lives
  in the per-family complexes** `𝓕 ↦ X(𝓕)` (§4) — a **non-constant
  coefficient diagram over the Moore-family lattice**.
- Integrating that diagram over the category is exactly
  `hocolim_{𝒞_n^∩} X(𝓕)` — **Fork A**'s object — and its cohomology
  `H^*(𝒞_n^∩; X(−))` is "the cohomology of the category *with
  coefficients*". The probe shows this is the **only** place the content
  can be: the bare `H^*(B𝒞_n^∩)` is `0`.
- `mg-0405` §3.6 already pinned the canonical structure maps for Fork A
  (the projections `π_T`, making `X` a genuine covariant functor). Fork A
  is a *defined* object; Fork D is not even non-trivial.

So Fork A is not a reluctant stopgap here — it is the construction the
mathematics points at. The probe's one substantive correction to the
vision-check is to **upgrade Fork A from "lukewarm variance patch" to "the
live foundation"**, precisely because Fork D's prerequisite failed.

### 6.3 What Fork A still owes (unchanged by this probe)

The probe does **not** discharge Fork A's known debts; they must be
carried forward honestly:

1. **The `(c)` / `(ℤ/2)ⁿ` gap.** `mg-0405` §6 is explicit that Fork A
   "does not solve" the `(ℤ/2)ⁿ`-action block. Per the vision-check §7.3
   recommendation 3, the resolution is to **drop the `(ℤ/2)ⁿ` action on
   the cohomology object entirely** (Role 1 — the C3 dodge — refuted by
   `mg-0405` §4.5) and **grade by `sgn_{S_n}`**, keeping Walsh only as the
   harmonic description of the obstruction cochain (Role 2 — genuine).
   This probe is consistent with that: the per-family sphere it found
   carries `sgn_{S_3}` natively (§4), with no `(ℤ/2)ⁿ` needed.
2. **The clause-`(V3)` faithfulness risk.** Whether the coefficient
   cohomology Fork A computes genuinely *sees* the counterexample — rather
   than `ob` being family-blind (the `wrapper-risk`, paper Rem.
   `wrapper-risk`; `axiom-is-Frankl`) — is the deepest open question and
   is **not** settled by this probe. The probe shows the *coefficient
   diagram* is family-sensitive (§4), which is necessary but not
   sufficient for `ob` itself to be faithful.

### 6.4 Status unchanged

`Y1` remains `RED — open`. `Frankl_Holds`'s dependence on
`case3_ss_obstruction_paper_axiom` is unaffected. No Lean change, no paper
edit, no new axiom — this is a strategic probe. The Zulip post stays held.

---

## §7 — Recommendations and cross-references

### 7.1 Recommendations (routed to Daniel via `pm-onethird`)

1. **Take Fork D off the table as a re-foundation.** Its prerequisite
   `(D-prereq)` is computationally refuted: the Moore-family lattice's
   bare nerve cohomology is `ℚ`-acyclic at `n = 2` and `n = 3`, under both
   conventions. The literal vision — "the category's own cohomology (its
   order complex)" — yields the zero object.
2. **Adopt Fork A as the foundation** for the cohomological route: the
   covariant `hocolim_{𝒞_n^∩} X(𝓕)` with the pinned projections `π_T`
   (`mg-0405` §3.6). The probe shows the family-sensitive content lives in
   the coefficient diagram `𝓕 ↦ X(𝓕)`, which is exactly what Fork A
   integrates; the bare nerve has nothing.
3. **Carry the `sgn_{S_n}` re-grading into Fork A.** Drop the `(ℤ/2)ⁿ`
   action on the cohomology object (`mg-0405` (c), refuted); grade the
   target by `sgn_{S_n}`. The probe corroborates this is sound: the
   per-family sphere carries `sgn_{S_3}` with no `(ℤ/2)ⁿ` (§4). This
   closes the `mg-0405` §6 block (c) by removing the requirement rather
   than satisfying it — the vision-check §7.3 rec 3 path.
4. **The honest record on `UC10`.** `Drift B` (the cubical-Walsh-defect
   coefficient diagram, the "C1 dodge") is **vindicated** by this probe as
   a mathematically forced response to a real obstacle — the bare order
   complex of the category genuinely is trivial. `UC10`'s instinct was
   correct; what `mg-0405` refuted was the *variance* of the assembly
   (`Drift A` + the BK convention), not the decision to use a coefficient
   diagram at all. Fork A keeps the (correct) coefficient diagram and
   fixes the (incorrect) variance.
5. **The real theorem is still clause `(V3)`.** Fork A inherits the
   `wrapper-risk` / `axiom-is-Frankl` faithfulness question untouched
   (§6.3). Whatever fork is chosen, "the minimal counterexample differs by
   a factor relating to the cohomology" — that the cohomology genuinely
   detects the counterexample — is the genuine open content. This probe
   narrows the search (it eliminates Fork D and endorses Fork A's object)
   but does not close that question.
6. **No Lean, no paper edit, no Zulip release** — unchanged.

### 7.2 The honest one-paragraph verdict

The Fork-D prerequisite is refuted by direct computation: the order
complex of the Moore-family lattice on `[3]` — the literal F-series
`Δ(PPF_n)` analog the vision names — is rationally acyclic, with every
reduced Betti number zero, reduced Euler characteristic zero, Möbius
function `μ(0̂,1̂) = 0`, and a zero `S_3`-virtual-character; the result is
robust at `n = 2` and under the `∅`-variant; so the category's bare nerve
is both trivial and (a fortiori) family-blind, and Fork D — re-founding on
that bare nerve — is not viable. The probe also locates the content the
vision wants: it lives, family-sensitively and `sgn_{S_3}`-graded, in the
per-family complexes `X(𝓕)` — a non-constant coefficient diagram over the
lattice, never the lattice's nerve — which means `UC10`'s coefficient
diagram (`Drift B`) was a forced move, not gratuitous drift, and Fork A
(the covariant hocolim of that diagram, with the structure maps `mg-0405`
already pinned) is the live foundation, owing still the `(ℤ/2)ⁿ`-to-`sgn`
re-grading and the standing clause-`(V3)` faithfulness question.

### 7.3 Cross-references

- **Brief:** `mg-565a`. **Routes to:** the pending Daniel decision on
  `mg-0405` §6.
- **The vision-check that indicated Fork D:** `docs/Frankl-vision-check.md`
  (`mg-6edc`) — §6.4 defines Fork D, §6.5 isolates `(D-prereq)`, §7.3
  rec 2 commissions this probe.
- **The Phase-1.5 RED:** `docs/Frankl-Y1-phase1.5-bk-structure-maps.md`
  (`mg-0405`) — §3.6 pins the projection `π_T` (Fork A's structure map),
  §6 the three-fork menu.
- **The punctured-Boolean-cube fact:**
  `docs/union-closed-UC9-...md` §D-4 — `2^[n]∖{∅,[n]}` order complex
  `≃ S^{n-2}`, `H̃^{n-2} ≅ sgn_{S_n}` (this probe's `Poset A`,
  reproduced and confirmed by the self-test).
- **The Moore-family framing:** `docs/union-closed-UC10-...md` §0.1
  (intersection-closed families = Moore families / closure systems), §2
  (the category `𝒞_n^∩`).
- **Onboarding:** `docs/PROOF-STRUCTURE-ONBOARDING.md`.
- **Computation:** `docs/frankl-forkd-probe-n3.py` — self-contained,
  reproducible, ~1.3 s; self-tested against `S^1` / `S^2`; rank
  cross-checked at two primes.

---

*Probe by polecat `cat-mg-565a`. Deliverables on `main`: this document and
`docs/frankl-forkd-probe-n3.py`. Verdict: **NO — FORK-D-NOT-VIABLE; THE
C1 / U1-WALL OBSTACLE IS REALISED.** The Moore-family lattice's bare nerve
cohomology is `ℚ`-acyclic (proper part of the 61-element lattice on `[3]`:
all reduced Betti numbers `0`, `μ(0̂,1̂)=0`, robust at `n=2` and under the
`∅`-variant); it is trivial and family-blind; Fork D cannot be re-founded
on it. The family-sensitive spherical content the vision wants lives in
the per-family coefficient diagram `X(𝓕)`, not the nerve — so `UC10`'s
`Drift B` was forced, and **Fork A (the covariant hocolim) is the live
foundation**, owing still the `(ℤ/2)ⁿ`-to-`sgn` re-grading and the
clause-`(V3)` faithfulness question. Recommended next: Daniel adopts
Fork A per `mg-0405` §6.*
