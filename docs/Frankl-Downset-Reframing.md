# Frankl-Downset-Reframing — does the obstruction live in the downset of a fixed family, not the global category?

**Work item:** `mg-8f74` (Frankl-Downset-Reframing). Per a Daniel
reminder 2026-05-22 (the second of two responding to the Fork A
refutation): *"so I do not follow why this obstruction matters for our
proof. To be a little more precise: choose one intersection closed
family. We care about all the sub-families, which is basically the
downset in the category of all families. Now if the cohomology of the
category suddenly becomes trivial or something at the very maximal step
this does not matter."*

This document runs down Daniel's downset reframing — a conceptual
challenge to whether the `mg-f9a7` Fork A refutation is even about the
right object.

**READ-FIRST consumed:** `docs/Frankl-ForkA-Phase0-FaithfulnessProbe.md`
(`mg-f9a7` — the terminal-object collapse and its exact root cause);
`paper/forkA/refoundation.tex` (`def:category`, `def:xf`, `def:bk`,
`def:obs-sheaf`, `def:ob`, `rem:promotion`, `conj:y1a`,
`thm:contradiction`, `prop:fact-one`, `debt:faithful-localized`);
`docs/Frankl-Y1-reprove.md` (`mg-56b8`); `docs/Frankl-ForkD-Probe-n3.md`
(`mg-565a` — per-family vs lattice).

**Scope.** A conceptual reconciliation + bounded `n = 3` computation,
not the multi-week residual. Deliverable: this document and the
computation script `docs/frankl-forkA-downset-reframing.py`
(self-contained, no dependencies; runs in ~1.2 s; ranks cross-checked
at two `~2^31` primes). `pm-onethird` relays the verdict to Daniel.
Deliverable lands on `main` (no branch override).

---

## §0 — Verdict (top of page)

### 0.1 Headline

> **NO — THE DOWNSET REFRAMING DOES NOT RESCUE THE PROOF; THE
> `mg-f9a7` FORK-A REFUTATION STANDS.**
>
> Daniel's reframing identifies a real conceptual distinction (the
> Frankl obstruction is constructed LOCALLY, on the punctured trace
> poset of a fixed F⋆; the Fork A integration is GLOBAL, over the whole
> category C_n), but the structural mechanism that killed the global
> object — the **covariant homotopy colimit of X collapses onto the
> terminal object** — fires identically on every natural localization
> to the downset of a fixed F. **The terminal object `t = (∅, {∅})` is
> a trace of every family**: it sits at the bottom of every
> trace-direction downset, the punctured trace poset included. Direct
> computation at `n = 3` confirms: for every one of the 61 Moore
> families F, the BK cohomology of the trace-downset
> `H^*(C_3(F); X) = H^*(C_3(F) \ {F}; X) = {0:1}` — exactly the same
> collapse profile as the global object. The downset is family-blind in
> precisely the way the global object is, by precisely the same
> mechanism.
>
> The doubly-punctured `C_3(F) \ {F, t}` does break the collapse and
> carries family-sensitive cohomology, but **only in degree 1** (three
> profiles: `H^1 ∈ {1, 2, 4}`), never the degree `n - 1 = 2` the
> contradiction needs. And the **inclusion-direction** downset — the
> Fork-D variance Daniel's prose intuition actually fits — collapses
> covariantly onto `X(F)` itself (F is now the maximum), which at
> `n = 3` is contractible (44/61) or disconnected with `H^0 = 1`
> (17/61) — no `H^{n-1}` class anywhere.
>
> **Across all 61 families and all four natural downset variants, ZERO
> families have a sphere-shaped `H^{n-1} = 1` cohomology.** The
> structural obstacle — the proof needs a class in degree `n - 1` —
> survives every localization. The Fork A refutation is not specific
> to globality.

### 0.2 The reframing, scored

| Question | Result | Evidence |
|---|---|---|
| Is the obstruction constructed LOCALLY (on the downset of F⋆) or GLOBALLY (on C_n)? | **LOCALLY.** Constructed as a Čech 1-cocycle on the punctured trace poset `C_n(F⋆) \ {F⋆}`. | §1.2; `refoundation.tex` `def:obs-sheaf`, `def:ob`, `rem:promotion`. |
| Does the proof PROMOTE the local class to the global object? | **YES — that is the R3 owed debt.** | §1.3; `rem:promotion`; `debt:faithful-localized`. |
| Is the promotion logically necessary, or could the proof stay local? | **The two-part contradiction is STATED in terms of the global `H̃^{n-1}(C_n;X)`.** A local restatement is not impossible in principle but is not what `refoundation.tex` builds. | §1.4. |
| Does the trace-downset `C_n(F)` evade the terminal-object collapse? | **NO.** `t = (∅,{∅})` is a trace of every F; it sits in every `C_n(F)` (and `C_n(F) \ {F}`); the covariant hocolim still drains onto `X(t) = point`. All 61 families give `H^* = {0:1}`. | §2.1. |
| Does the inclusion-direction downset `↓F` (sub-families ⊆ F) evade collapse? | **NO — it gives a DIFFERENT collapse:** F is the maximum, covariant hocolim collapses onto `X(F)`. Non-trivial as a coefficient, but at `n = 3` has only `H^0` (no `H^{n-1}`). | §2.2. |
| Does any natural localization carry a sphere class `H^{n-1} = 1`? | **NO — 0/61 families in all 4 variants tested.** | §2.3. |

### 0.3 The root cause, in one line

> **The terminal object of the trace category that kills the Fork A
> hocolim is `t = (∅, {∅})` — the empty-ground trace, which is a trace
> of every intersection-closed family.** Daniel's intuition that "the
> downset of F has F itself as top" is correct, but it identifies the
> wrong directional structure for the obstruction. F is the top in the
> **inclusion** direction; the empty-ground trace `t` is the bottom in
> the **trace** direction. The obstruction sheaf is defined in the
> trace direction (`def:obs-sheaf` lives on the punctured trace poset),
> so the relevant terminal is `t`, not the absent inclusion-direction
> maximum. The trace-downset's collapse onto `X(t) = point` is
> identical to the global category's, family-by-family.

---

## §1 — Conceptual reconciliation: what object does the proof actually need?

### 1.1 The two-part contradiction, restated

`refoundation.tex` `thm:contradiction` is a conditional theorem: assume
inputs (i)–(v), then no minimal counterexample F⋆ to Frankl exists.
Inputs (iv) and (v) — Fact One and Fact Two — collide on the
**obstruction class**

```
ob(F⋆)  ∈  H̃^{n-1}(C_n; X)
```

a class in the (n-1)-degree reduced cohomology of the **global** Fork A
object (`def:bk`). Fact One forces `ob(F⋆) ≠ 0` (Prop. `fact-one`,
conditional on R3 — the edge-map debt). Fact Two — input (v) =
`conj:y1a` = the `Y_1`-A vanishing — asserts
`H̃^{n-1}(C_n; X) ≅ sgn_{S_n}`, a *one-dimensional* sign isotype.
Combining: `ob(F⋆) ≠ 0` lands in a one-dimensional `sgn` line, then
Fact Two's R2 sub-clause asserts `ob` avoids the `sgn` isotype, so
`ob = 0`. Contradiction.

The class **as written** is a class in the **global** `H̃^{n-1}(C_n; X)`.
That is the object Fork A built and `mg-f9a7` refuted.

### 1.2 Where the obstruction is actually constructed

`refoundation.tex` `def:obs-sheaf` and `def:ob` construct the
obstruction **not** on C_n but on a much smaller object:

> *the punctured trace poset* `C_n(F⋆) \ {F⋆}`, *where `C_n(F⋆)` is
> the full subcategory of `C_n` on the **traces** of `F⋆`*.

That is: fix F⋆; consider `C_n(F⋆) = {(T, F⋆|_T) : T ⊆ [n]}`, the
sub-poset of `C_n` consisting of all ground-set restrictions of F⋆;
puncture by removing F⋆ itself. This is **the downset Daniel's prose
points at** — "all the sub-families" of F⋆. (Strictly, "sub-families in
the trace direction" — there are also inclusion-direction sub-families
F' ⊆ F⋆, a different object; §2.2.)

On this punctured trace poset, the obstruction sheaf `F_obs` carries:

- *local bias cochains* `b̂_x = b_x · [W_{{x}}]` on the strata
  `U_x = {(T, G) : x ∈ T, β_x(G) ≤ 0}`,
- *mismatch cochains* `m_{xy} = b̂_x - b̂_y` on the overlaps `U_x ∩ U_y`.

The cover `{U_x}_{x ∈ [n]}` is a Čech cover of the punctured trace
poset (Prop. `minimality` guarantees that the strata cover it — every
proper trace has a rare coordinate, by minimality of F⋆).

The mismatch is **automatically** a Čech 1-cocycle (Lemma `cocycle`).
It is a class in `Č H^1(𝔘; F_obs)` — a *local* Čech cohomology group
attached to the punctured trace poset.

### 1.3 The promotion — the R3 owed debt

`def:ob` and `rem:promotion` are explicit and honest about the gap:

> *"Promoting the mismatch class from there into `H^*(C_n; X)` requires
> a further comparison map, and that comparison crosses a genuine
> object mismatch: the Čech double complex lives on the punctured trace
> poset `C_n(F⋆) \ {F⋆}`, whereas `H^*(C_n; X)` is the cohomology of
> the **whole** category `C_n`."*

The "R3 owed debt" — `debt:faithful-localized`, parts R3a / R3b / R3c —
is the package of (R3a) **existence** of an edge map from the local
Čech cohomology to the global `H^*(C_n; X)`, (R3b) the edge map landing
in **degree `n - 1`**, and (R3c) the edge map being **injective** on
the mismatch class.

This is the bridge `refoundation.tex` builds **only conditionally**.
`mg-f9a7` showed that whatever edge map is built, **its target —
`H̃^{n-1}(C_n; X)` — is the zero group**, so R3c is moot and Fact One
is unattainable.

### 1.4 Daniel's reframing, as a precise question

> *Can the obstruction live in the **local** ambient — the cohomology
> of the punctured trace poset of F⋆ with X coefficients — and avoid
> the global promotion entirely? Would that make the proof
> independent of the `H^*(C_n; X) = 0` collapse?*

The reframing is well-posed and substantive. If a viable local ambient
exists — one that carries a non-trivial degree-`(n-1)` cohomology class
hosting the obstruction — then the global collapse is irrelevant; the
proof could be re-stated to use the local object directly, dropping R3
entirely.

§2 computes the candidate local ambients at `n = 3` and reports the
verdict.

---

## §2 — The downset construction at `n = 3`: four natural variants

### 2.1 Variant (T): the full trace-downset `C_n(F)`

Fix `F`. The trace-downset

```
C_n(F)  =  { (T, F|_T) : T ⊆ [n] }
```

is the full subcategory of `C_n` on the traces of F, with the inherited
trace morphisms `(S, F|_S) → (T, F|_T)` for `T ⊆ S`. Compute the BK
total complex of X on this subcategory (the exact construction of
`def:bk`, but indexed by chains *within* `C_n(F)` rather than within
all of `C_n`).

**Direct computation at `n = 3`** (`frankl-forkA-downset-reframing.py`,
PART 2):

> *For all 61 Moore families `F` on `[3]`,*
>
> `H^*(C_3(F); X) = {0 : 1}`.
>
> *(a single profile — 61/61 families have rationally acyclic
> trace-downset cohomology.)*

**Diagnosis.** The trace-downset `C_n(F)` has the empty-ground trace
`(∅, {∅}) = t` as one of its objects (the trace of F to `T = ∅` is
always the trivial family `{∅}` on the empty ground set). Inside
`C_n(F)`, t is a **terminal object** — every object `(T, F|_T)` has the
trace to `∅` as its unique morphism to t. The terminal-object collapse
of `mg-f9a7` §2.2 fires identically: covariant hocolim → `X(t)` =
point, so `H^* = {0:1}`.

This is the most decisive single finding of the probe: **the collapse
is not a global-category artefact**. Localizing to the trace-downset of
any fixed F does not change the picture — t is in every downset, the
collapse fires every time.

### 2.2 Variant (T-): the punctured trace-downset `C_n(F) \ {F}`

This is the actual ambient `refoundation.tex` `def:obs-sheaf` uses
(the obstruction sheaf is defined on the punctured trace poset). Remove
F itself from `C_n(F)`; keep everything else.

**Direct computation at `n = 3`** (PART 2):

> *For all 61 Moore families `F` on `[3]`,*
>
> `H^*(C_3(F) \ {F}; X) = {0 : 1}`.
>
> *(again, a single profile.)*

**Diagnosis.** Removing F from the *top* does not remove t from the
*bottom*. The empty-ground trace is still present, still terminal in
`C_n(F) \ {F}`, still kills the hocolim. The puncture-at-the-top that
`def:obs-sheaf` performs is the wrong puncture for fixing the collapse;
the collapse is about the puncture at the bottom.

### 2.3 Variant (T=): the doubly-punctured `C_n(F) \ {F, t}`

Remove **both** F (at the top) and t (at the bottom). This is the
per-family analog of the `mg-f9a7` §2.3 controlled experiment, which
deleted t globally from C_3 and got `H^2 = 59` instead of zero.

**Direct computation at `n = 3`** (PART 2 of the probe):

| profile | # families |
|---|---|
| `H^0 = 1, H^1 = 1` | 48 |
| `H^0 = 1, H^1 = 2` | 12 |
| `H^0 = 1, H^1 = 4` | 1 |

**Reading.** Removing t breaks the collapse — `H^1` becomes non-zero
and **genuinely family-sensitive** (three distinct profiles across the
61 families, with the spread tracking the family structure). This
confirms the diagnostic: **t is, on the downset just as on the global
category, the exact cause of the acyclicity.**

But — and this is the crucial point — the family-sensitivity is in
**degree 1**, not in the degree `n - 1 = 2` the contradiction needs.
`Y_1`-A wants `H^{n-1}` to be one-dimensional (`sgn_{S_n}`); the
doubly-punctured downset has `H^{n-1} = H^2 = 0` for every family.
Breaking the collapse is necessary, but it does not put a class in the
right degree.

### 2.4 Variant (I): the inclusion-direction downset `↓F = {F' ⊆ F : F' int-closed}`

This is the downset Daniel's prose most naturally fits — *"all the
sub-families"* of F, ordered by inclusion of families. **Different
poset from (T):** the morphisms are inclusions of families, not traces.
This is the Fork-D variance (`mg-565a`).

For F' ⊆ F, every subcube of F' is a subcube of F, so the cubical-
defect complex has a natural inclusion `X(F') ↪ X(F)`, **covariant** in
the `F' → F` direction. The downset `↓F` has F as its **maximum**
(unique terminal), so the covariant hocolim collapses to `X(F)`:

```
H^*(↓F; X)  ≃  H^*(X(F)).
```

This is exactly Daniel's intuition: the collapse lands on `X(F)`, not
on a trivial point. So far so good.

**Direct computation at `n = 3`** (PART 2):

| profile of `H^*(X(F))` | # families |
|---|---|
| `{}` (acyclic, X(F) contractible) | 44 |
| `{0 : 1}` (X(F) two-component) | 17 |

So the inclusion-downset cohomology *is* family-sensitive, with two
distinct profiles. But again, at `n = 3` **no family** has a non-zero
`H^{n-1} = H^2`: `X(F)` is at most `H^0`-non-trivial across all 61
families (this is `mg-f9a7` §4.1's finding for `X(F)` too).

### 2.5 The four variants, side by side

| F | (T): `C_3(F)` | (T-): `\{F}` | (T=): `\{F, t}` | (I) ≃ X(F) |
|---|---|---|---|---|
| `{[3]}` (trivial) | `{0:1}` | `{0:1}` | `{0:1, 1:1}` | `{}` |
| `2^[3]` (full) | `{0:1}` | `{0:1}` | `{0:1, 1:1}` | `{}` |
| `{∅, [3]}` | `{0:1}` | `{0:1}` | `{0:1, 1:4}` | `{0:1}` |
| `{{0}, [3]}` | `{0:1}` | `{0:1}` | `{0:1, 1:2}` | `{0:1}` |
| `{{0,1}, [3]}` | `{0:1}` | `{0:1}` | `{0:1, 1:1}` | `{}` |

(Full table for all 61 families is in the script output; the profiles
are exhaustive.)

**Sphere-shaped families** (i.e., `H^{n-1} = H^2 = 1` with all other
reduced cohomology zero or only `H^0`):

| variant | # sphere families / 61 |
|---|---|
| (T) | **0** |
| (T-) | **0** |
| (T=) | **0** |
| (I) | **0** |

> *Across all 61 families and all four natural downset-of-F variants
> of the Fork-A ambient at `n = 3`, **zero** carry a sphere-shaped
> `H^{n-1} = 1` cohomology class. The class the two-part contradiction
> needs has nowhere to live in any localization.*

---

## §3 — Why Daniel's intuition is right about the structure but wrong about the rescue

Daniel's intuition has two parts and they pull apart:

### 3.1 The correct half — the obstruction IS constructed locally

`refoundation.tex` `def:obs-sheaf` does build `F_obs` on the punctured
trace poset of F⋆, not on the global C_n. The Čech double complex
*lives there*. The Čech mismatch cocycle is a class in `Č H^1` of a
*local* Čech double complex. Daniel is right that the natural ambient
is local — the proof on its own admits this in `rem:promotion`.

This is a real conceptual point that `mg-f9a7`'s presentation does not
emphasize. `mg-f9a7` reported the global collapse without re-tracing
the global / local mismatch the obstruction construction encodes. The
present probe makes the local structure explicit.

### 3.2 The incorrect half — "the maximal step is F, not t"

Daniel's prose: *"the cohomology of the category suddenly becomes
trivial or something at the very maximal step this does not matter."*
The implicit claim is that the global collapse onto the trivial empty
family is a structurally irrelevant artefact of C_n's globality —
because in the downset of F⋆, F⋆ itself is the "maximal step", not the
trivial family.

This conflates **two directional structures** of the inclusion /
trace-of-families lattice:

| direction | morphisms | maximum of `↓F` | minimum of `↓F` |
|---|---|---|---|
| **inclusion** (Fork D) | `F' ⊆ F` is a morphism `F' → F` | F | `{[n]}` |
| **trace** (Fork A) | `T ⊆ S` gives `(S,F) → (T, F|_T)` | F (initial) | `t = (∅,{∅})` (terminal) |

In the inclusion direction, F is the unique maximum of `↓F` — and a
covariant hocolim there does collapse onto `X(F)` (Daniel's intuition,
variant (I)). In the trace direction — *the direction `def:obs-sheaf`
actually uses* — F is **initial** (everything else is a strict trace of
F, with a morphism out of F), and `t = (∅, {∅})` is **terminal**
(every object has a unique trace to it). The covariant hocolim
collapses onto the **terminal** object, which is t, not F.

So Daniel's "the maximal step is F" is true in inclusion variance and
false in trace variance. The obstruction `def:obs-sheaf` builds is in
trace variance. The "very maximal step" the hocolim drains onto is
**not the trivial global family** — it is the **empty-ground trace** of
F⋆, which is the same trivial family `t = (∅, {∅})` regardless of F⋆.

### 3.3 Could the obstruction be rebuilt in inclusion variance?

In principle, yes — the Fork D probe (`mg-565a`) studied that
category. But:

1. The covariant hocolim of X over `↓F` collapses to `X(F)` (since F is
   the inclusion-maximum). At `n = 3`, `X(F)` is contractible (44/61)
   or has `H^0 = 1` (17/61); **no `H^{n-1}` ever**. So even in the
   "good" variance for Daniel's prose, the sphere class is not in X(F).

2. The obstruction sheaf `F_obs` as currently defined uses traces and
   biases that are functorial in the trace direction (`b_x(F|_T)` is
   defined per-trace, not per-sub-family). Re-founding `F_obs` over
   inclusion variance is a substantively different construction — not
   a relabelling.

3. The Fork D probe found the *bare nerve* of the inclusion-direction
   lattice is acyclic. Any inclusion-variance re-foundation would need
   a non-constant coefficient diagram over that lattice. The natural
   candidate is X again, and as just noted, X(F) carries no
   `H^{n-1}` at `n = 3`.

---

## §4 — Where this leaves the proof

### 4.1 The verdict for `thm:contradiction`

The two-part contradiction needs the obstruction `ob(F⋆)` to live in
a one-dimensional `sgn_{S_n}` line — somewhere. `mg-f9a7` showed that
"somewhere" cannot be the global `H̃^{n-1}(C_n; X)` (which is zero).
This probe shows that "somewhere" cannot be any of:

- `H^{n-1}(C_n(F⋆); X)` — the trace-downset (zero by terminal-object
  collapse onto `X(t)`);
- `H^{n-1}(C_n(F⋆) \ {F⋆}; X)` — the punctured trace poset (zero by
  the same collapse);
- `H^{n-1}(C_n(F⋆) \ {F⋆, t}; X)` — the doubly-punctured object
  (non-trivial cohomology, but in degree 1 only, not n-1);
- `H^{n-1}(X(F⋆)) = H^{n-1}(↓F⋆; X)` — the inclusion downset (no
  `H^{n-1}` at `n = 3` for any family).

The list above exhausts the structural variants of "the cohomology of
the downset of F⋆ with X coefficients" that are natural from the
Fork-A construction.

> **No localization of the Fork A object to the downset of a fixed F⋆
> carries a class in the required degree `n - 1`.** Daniel's reframing
> is conceptually correct (the obstruction is locally constructed) but
> does not yield a viable rescue.

### 4.2 What the probe DID positively contribute

The probe is not purely negative:

1. **The local Čech double complex IS the right ambient for the
   *unpromoted* mismatch class.** It carries the `S_n`-equivariant
   Čech 1-cocycle structure. Sharpens `rem:promotion`'s honesty: the
   class is a Čech cocycle natively, not a global cohomology class
   natively.

2. **The terminal-object collapse is local-and-global identical.** The
   collapse mechanism is not an artefact of the global category's
   "wide" structure — it fires identically on every trace-downset. The
   `mg-f9a7` verdict is structurally robust under any natural
   localization.

3. **Family-sensitivity does exist in the doubly-punctured downset
   `C_n(F) \ {F, t}`**, in `H^1`. This is mathematically interesting
   (a per-family analog of the `mg-f9a7` §2.3 controlled experiment)
   but lives in the wrong degree for `Y_1`-A.

4. **The inclusion-variance downset cleanly identifies what would
   collapse to:** `X(F)`. At `n = 3` `X(F)` is contractible or
   `H^0`-only — no sphere. This rules out a clean
   inclusion-variance re-foundation of the obstruction on the same
   coefficient X.

### 4.3 Relationship to `mg-7bf3`

The ticket body identifies `mg-7bf3` as the complementary
category-level fork (holim, terminal-object-excluded). The two tickets
are independent and address different questions:

- **mg-7bf3** (category-LEVEL tweaks): replace `hocolim` with
  `holim`, or exclude `t` globally, in the **global** Fork-A
  construction. Asks whether a different variance / different category
  cohomology kills the collapse.
- **mg-8f74** (this ticket — F⋆-LOCAL): keep the construction, restrict
  the **ambient** to the downset of F⋆. Asks whether the local ambient
  evades the global collapse.

This ticket settles the mg-8f74 question: localization to the F⋆
downset does **not** evade the collapse. Whether some other category-
level fix (mg-7bf3) does is a separate matter.

The two findings together suggest: any rescue of the Fork-A
cohomological route to Frankl needs **either** a structurally different
ambient (not a localization of `def:bk` to a sub-poset; mg-7bf3's
domain) **or** a structurally different coefficient (X is the wrong
diagram — the per-family complex has no `H^{n-1}` at `n = 3` in any
incarnation; new work).

---

## §5 — The honest one-paragraph verdict

The Fork A obstruction class is constructed locally — as a Čech
1-cocycle on the punctured trace poset of a hypothetical minimal
counterexample F⋆, exactly as Daniel's reframing observes — and then
*promoted* (via the R3 owed debt) into the global `H̃^{n-1}(C_n; X)`,
which `mg-f9a7` showed is the zero group. Daniel's challenge — does the
local object also collapse, and is the proof necessarily tied to the
collapsing global object — has a precise answer at `n = 3`: the
trace-direction downset of every fixed F (`C_n(F)`, and its puncture
`C_n(F) \ {F}` which is the natural Čech-double-complex ambient) is
**identically** rationally acyclic, by **identically** the same
terminal-object collapse — because the empty-ground trace `t = (∅,
{∅})` is a trace of *every* intersection-closed family and so sits in
every downset; the doubly-punctured object `C_n(F) \ {F, t}` does
break the collapse but only in degree 1, never the degree `n - 1` the
contradiction needs; the inclusion-direction downset `{F' ⊆ F}` (the
variance Daniel's prose actually fits) collapses cleanly onto `X(F)`,
which at `n = 3` is contractible (44/61) or `H^0`-only (17/61) — no
`H^{n-1}` either; **across all 61 families and all four natural
downset variants, exactly zero carry the sphere-shaped `H^{n-1} = 1`
class the two-part contradiction needs**. Daniel's intuition that "the
maximal step is F, not the trivial family" is correct in
**inclusion** variance — where F is the unique maximum — but the
obstruction sheaf `F_obs` is constructed in **trace** variance, where
the relevant terminal is the empty-ground trace `t`, and `t` is in
every downset. The verdict is **NO — the downset reframing does not
rescue the proof**; the Fork A refutation of `mg-f9a7` is structurally
robust under any natural localization to the downset of a fixed F⋆;
whether a different variance / category-level fix (the complementary
`mg-7bf3` ticket) rescues anything is a separate question this probe
does not settle and does not need to.

---

## §6 — Recommendations (routed to Daniel via `pm-onethird`)

1. **The Fork A refutation stands.** Localizing the construction to the
   downset of a fixed (minimal counterexample) F⋆ — in either the
   trace-direction (the actual `def:obs-sheaf` ambient) or the
   inclusion-direction (the variance Daniel's prose fits) — does not
   evade the terminal-object collapse or the absence of an `H^{n-1}`
   class. `pm-onethird` should record this alongside the `mg-f9a7`
   verdict.

2. **The reframing IS a real conceptual sharpening.** Daniel correctly
   identifies that the obstruction is constructed locally (a Čech
   cocycle on the punctured trace poset, not a class natively in
   global `H^*(C_n; X)`). This is honest in `refoundation.tex`'s own
   `rem:promotion`, but `mg-f9a7`'s presentation under-emphasizes it.
   This probe makes the local structure explicit and confirms that the
   global / local distinction is real — it just does not save the
   proof, because the local object collapses too.

3. **The complementary ticket `mg-7bf3` is still live.** This probe
   settles the F⋆-local-ambient question; the category-level-fix
   question (holim, terminal-object-excluded) is separate and unfilled
   here. The two together will settle the Frankl Fork-A
   stop-vs-re-found decision.

4. **No Lean, no paper edit.** Like `mg-f9a7`, this is a strategic
   probe; its deliverables are this report and the script. The
   `refoundation.tex` paper is untouched.

5. **The probe's bounded scope, stated honestly.** All findings are at
   `n = 3`. The terminal-object collapse on the trace-downset is
   **n-independent** by the same general categorical argument as
   `mg-f9a7` §2.2 (the empty-ground trace t is terminal in every
   `C_n(F)` for every F and every n); so variants (T) and (T-) are
   acyclic at every n. Variants (T=) and (I) depend on per-family
   cohomology that grows with n, and the n=3 absence-of-sphere finding
   is not by itself a structural theorem at higher n. However: `X(F)`
   is homotopy-discrete at `n ≤ 4` (`mg-f9a7` §4.1), so variant (I)
   has no `H^{n-1}` at `n ≤ 4` either; and the doubly-punctured (T=)'s
   degree-1-only structure is consistent with general spectral-sequence
   facts about double-puncturing of bounded posets.

---

## §7 — Cross-references

- **Brief:** `mg-8f74` (Frankl-Downset-Reframing).
  **Routes to:** Daniel, via `pm-onethird`.
- **The Fork A refutation this probe answers Daniel's challenge to:**
  `docs/Frankl-ForkA-Phase0-FaithfulnessProbe.md` (`mg-f9a7`).
- **The object probed — the Fork A re-foundation:**
  `paper/forkA/refoundation.tex` (`def:category`, `def:xf`, `def:bk`,
  `def:obs-sheaf`, `def:ob`, `rem:promotion`, `conj:y1a`,
  `thm:contradiction`, `prop:fact-one`, `debt:faithful-localized`).
- **The complementary category-level fork ticket:** `mg-7bf3`
  (Frankl-ForkA-CategoryLevel-Tweaks — holim, terminal-object-excluded
  variants; runs in parallel).
- **Method reference, the prior bounded n=3 probes:**
  `docs/Frankl-ForkD-Probe-n3.md` (`mg-565a`) and
  `docs/Frankl-ForkA-Phase0-FaithfulnessProbe.md` (`mg-f9a7`).
- **Y1 reprove (for context on the open Y1 residual):**
  `docs/Frankl-Y1-reprove.md` (`mg-56b8`).
- **Onboarding:** `docs/PROOF-STRUCTURE-ONBOARDING.md`.
- **Computation:** `docs/frankl-forkA-downset-reframing.py` —
  self-contained, reproducible, ~1.2 s; ranks cross-checked at two
  `~2^31` primes; uses the same `defect_cells` / cubical-boundary /
  BK total complex infrastructure as the `mg-f9a7` probe (the BK
  construction is the standard Bousfield–Kan totalisation of `def:bk`,
  restricted to the trace-downset sub-poset of a fixed F).

---

*Probe by polecat `cat-mg-8f74`. Deliverables on `main`: this document
and `docs/frankl-forkA-downset-reframing.py`. Verdict: **NO — the
downset reframing does not rescue the proof; the `mg-f9a7` Fork A
refutation is structurally robust under any natural localization to
the downset of a fixed F⋆.** The Frankl obstruction IS constructed
locally (a Čech 1-cocycle on the punctured trace poset of F⋆), exactly
as Daniel's reframing observes, but the local trace-direction ambient
suffers identically the same terminal-object collapse as the global
category — because the empty-ground trace `t = (∅, {∅})` is a trace of
every family and is therefore terminal in every trace-downset; the
doubly-punctured ambient breaks the collapse but in the wrong degree;
the inclusion-direction downset (Fork-D variance, where Daniel's
"maximal step is F" actually applies) collapses cleanly onto X(F),
which has no `H^{n-1}` at n=3 in any family. Across all 61 families
and all four natural downset variants of the Fork-A ambient at n=3,
zero carry the sphere-shaped `H^{n-1} = 1` class the two-part
contradiction needs. Daniel's intuition that "F is the maximum, not
the trivial family" is correct in inclusion variance and wrong in
trace variance, and the obstruction sheaf is built in trace variance.
The complementary `mg-7bf3` ticket (category-level tweaks: holim,
terminal-excluded) is unaffected by this probe and runs in parallel;
together the two will settle the Frankl Fork-A stop-vs-re-found
decision.*
