# Frankl-Y1 Phase 1.5 — pinning the cell-level Bousfield–Kan structure maps (UC10/UC12): construction, refutation, and BLOCK-AND-REPORT

**Work item:** `mg-0405` (Frankl-Y1-Phase1.5). Per the `mg-59d3` (Frankl-Y1-Close
Phase 1) RED verdict and the Daniel-directed Y1-closure arc. Phase 1.5 is the
bounded foundational prerequisite that `mg-59d3` §5 isolated: the cell-level
Bousfield–Kan structure maps of UC10/UC12 — the trace-induced structure map
`X(𝓕|_T) → X(𝓕)` and the single-family `(ℤ/2)ⁿ`-action — are *asserted but not
constructed*, and the Y1 residual cannot be honestly computed (or formalised)
on un-pinned foundations.

**Brief.** Pin those two structure maps as precise constructions. Per the
Phase-1 report (`mg-59d3` §5.2) they are "pinnable via a canonical
minimal-lift." The brief is explicit that this is a **non-trivial** task and
sanctions a block: *"Block-and-report if the canonical-minimal-lift pinning
does not actually work — do not paper over; the un-pinned-foundations hazard is
exactly what Phase 1 flagged."*

**READ-FIRST cross-checked:** `docs/Frankl-Y1-close-phase1.md` (mg-59d3,
the Phase-1 report — §5 foundational blocker), `docs/Frankl-Y1-reprove.md`
(mg-56b8, the cofiber-LES reduction), `docs/union-closed-UC10-...md` (§3.3 the
trace map, §3.5 the `(ℤ/2)ⁿ`-action), `docs/union-closed-UC12-...md` (§2–§3 the
doubling functor and the prism), `docs/union-closed-UC14-...md` (§2.2 Lemma
2.2.1, §2.6 Lemma 2.6.1), `docs/PROOF-STRUCTURE-ONBOARDING.md`.

---

## §0 — Verdict (top of page)

### 0.1 Headline: **RED — BK-STRUCTURE-MAPS-NOT-PINNED (Phase 1.5).** The canonical minimal-lift is **refuted by an explicit `n = 4` counterexample**; the trace-induced structure map `X(𝓕|_T) → X(𝓕)` asserted by UC10 Definition 3.3 **does not exist** as a canonical cellular chain map in the variance the Bousfield–Kan double complex requires; and the single-family `(ℤ/2)ⁿ`-action does **not** assemble into a genuine `(ℤ/2)ⁿ`-action on `X_n^∩` as asserted by UC10 Lemma 3.6. The structure maps are **not pinned**. Phase 1.5 returns a sanctioned BLOCK.

This is the outcome the brief explicitly anticipated and sanctioned. It is not
a failed ticket: Phase 1.5 *did* the foundational verification Phase 1 only
estimated, and the verification is decisive. Three findings, each derived by
hand and each cross-checked against UC10/UC12/UC14 and the `mg-56b8` /
`mg-59d3` re-derivations.

1. **The canonical minimal-lift is refuted (§3).** Phase-1 §5.2 prescribed:
   for `A ∈ 𝓕|_T`, let `β(A) := ⋂{B ∈ 𝓕 : B∩T = A}`; lift the cell `C(A,T')`
   to `C(β(A),T')`. Phase-1 itself flagged the well-definedness obligation
   "`β(A)∪T'' ∈ 𝓕` for all `T'' ⊆ T'`." Phase 1.5 discharges that obligation —
   **negatively**. Explicit object of `𝒞₄^∩` (Example 3.4): `β` is a perfectly
   good monotone vertex map, but it does **not** extend to a chain map at all —
   the source complex `X(𝓕|_T)` is a solid square while the target `X(𝓕)` is
   four isolated points, so there is no 1-chain to carry the image of any edge.
   The minimal-lift recipe fails.

2. **No canonical against-trace structure map exists (§3.4–§3.7).** The failure
   is not a wrong *recipe*; it is structural. The Bousfield–Kan double complex
   of UC10 §3.3 / `mg-59d3` (3.1) places the cochain value at the **last**
   object of each bar string, which forces the structure map to run
   `X(𝓕|_T) → X(𝓕)` — *against* the trace. Example 3.4 exhibits a trace
   `(S,𝓕) → (T,𝓕|_T)` for which `dim X(𝓕|_T) = 2 > dim X(𝓕) = 0`: no chain
   map in that direction can be canonical, and the diagram functor
   `X : (𝒞_n^∩)^op → \mathrm{Ch}` UC10 Definition 3.3 names **does not
   exist**. The map that *does* exist canonically is the cubical **projection**
   `π_T : X(𝓕) → X(𝓕|_T)` (§3.6) — the *opposite* variance. The genuine
   functor is `X : 𝒞_n^∩ → \mathrm{Ch}` (covariant), and the genuine assembly
   is `\mathrm{hocolim}_{𝒞_n^∩} X`, **not** `\mathrm{hocolim}_{(𝒞_n^∩)^op}`.

3. **The single-family `(ℤ/2)ⁿ`-action does not assemble (§4).** The
   single-family operator `s_y` (extension-by-zero of the partial cube
   reflection `σ_y`) is pinnable as a *graded linear operator* (§4.1–§4.2), and
   that much is genuine positive content. But (i) `s_y` is **not a cochain
   map** — extension-by-zero does not commute with the cubical coboundary at
   `σ_y`-stuck cells with `σ_y`-matched faces (§4.3); (ii) the joint
   eigenspaces of the `s_y` do **not** span `C^*(X(𝓕))`, so the Walsh
   "decomposition" UC10.W is not a decomposition at the single-family level
   (§4.4); and (iii) the genuine `(ℤ/2)ⁿ`-action on `X_n^∩` cannot be obtained
   from UC10 Lemma 3.6's "standard for `G`-categories" argument, because
   `(ℤ/2)ⁿ` acts on neither the indexing category `𝒞_n^∩` (UC10 §2.4 — `σ_y`
   breaks intersection-closure) **nor** the diagram values (`σ_y` sends the
   summand `X(𝓕)` to `X(σ_y𝓕)` with `σ_y𝓕 ∉ 𝒞_n^∩`). The hypothesis of the
   cited machinery is absent (§4.5).

### 0.2 The precise verdict

> **RED — BK-STRUCTURE-MAPS-NOT-PINNED (Phase 1.5).** The cell-level
> Bousfield–Kan structure maps of UC10/UC12 are **not pinnable as asserted**.
> The canonical minimal-lift `C(A,T') ↦ C(β(A),T')` is refuted (Example 3.4);
> the trace-induced structure map `X(𝓕|_T) → X(𝓕)` of UC10 Definition 3.3 does
> not exist in the variance the Bousfield–Kan double complex needs; the
> `(ℤ/2)ⁿ`-action on `X_n^∩` of UC10 Lemma 3.6 is not constructible from the
> single-family operators. **Positive content delivered:** the canonical
> *projection* structure map `π_T : X(𝓕) → X(𝓕|_T)` is pinned (Proposition
> 3.6) — it makes `X` a genuine covariant functor `𝒞_n^∩ → \mathrm{Ch}`; and
> the single-family partial cube reflection `σ_y` and its operator `s_y` are
> pinned as far as they go (§4.1–§4.2). The Y1 residual computation cannot be
> honestly attempted until the foundations are re-pinned — which requires a
> genuine design decision (§6), not a write-up patch, and is therefore **out
> of scope for Phase 1.5** and routed back to Daniel via `pm-onethird`.

### 0.3 What this changes for the project record

- **Y1 stays `RED — open`**, exactly as in `mg-56b8` / `mg-59d3`. Phase 1.5
  does not touch Y1's standing. It hardens the `mg-59d3` §5 finding from
  "asserted but not pinned" to "asserted, attempted, and **refuted as
  stated**."
- **The `mg-59d3` §5.2 pinnability estimate is corrected.** Phase-1 wrote the
  structure maps are "pinnable via a canonical minimal-lift (§5.2)." Phase 1.5
  did the verification Phase-1 deferred and the minimal-lift does not work.
  This is not a contradiction of Phase-1 — Phase-1 explicitly listed the
  well-definedness check as outstanding; Phase 1.5 is that check, and it
  fails.
- **A genuine design fork is surfaced.** The structure maps *are* repairable
  (§6), but the repair is a re-foundation choice — the variance of the
  hocolim, and how/whether `(ℤ/2)ⁿ` is realised — with non-trivial downstream
  cost (it touches UC10.W, UC12's null-homotopy, the `mg-56b8` reduction's
  comma-category presentation, and any Lean model). That decision is Daniel's.
- **The paper.** `paper/sections/06-residual.tex` already carries the
  prerequisite as `rem:y1-prerequisite` and `05-proof-state.tex` carries the
  Y1 residual as `res:y1`. Phase 1.5 does **not** edit the paper: a BLOCK must
  not be written into the paper as if pinned, and the honest paper update
  (sharpening `rem:y1-prerequisite` to record the refutation, or restructuring
  around the corrected variance) depends on the §6 design decision. It is
  recommended as a follow-on once Daniel rules on §6.

### 0.4 Net effect on the Frankl two-part contradiction

Unchanged from `mg-56b8` / `mg-59d3`. The contradiction is
`Y1 ∧ Y2 ⟹ ob(F⋆) = 0`; `Y2` is mechanism-sound (`mg-aeee`); `Y1` is not
validly proven and Phase 1.5 does not rescue it. `Frankl_Holds`'s standing
dependence on `case3_ss_obstruction_paper_axiom` is unaffected. The Zulip post
stays held.

---

## §1 — Scope, method, what Phase 1.5 is

### 1.1 The target — two structure maps

`mg-59d3` §5.1 itemised what a computation of the Y1 residual needs from the
Bousfield–Kan model of `𝒞_n^∩` at cell level. Item (a) — the single-family
cubical cochain complex `C^*(X(𝓕))` — is supplied precisely by UC10 Definition
3.1 and is not in question. The two items `mg-59d3` flagged as *asserted but
not pinned* are the Phase-1.5 target:

- **(b) the trace-induced structure map** `X(𝓕|_T) → X(𝓕)`, used as the
  cochain restriction `C^q(X(𝓕)) → C^q(X(𝓕|_T))` in the Bousfield–Kan bar
  differential `δ_{BK}`. UC10 §3.3 (Definition 3.3) asserts only that
  "`X(𝓕|_T)` sits inside `X(𝓕)` because every subcube of `Q_T` inside `𝓕|_T`
  lifts to a subcube of `Q_S` inside `𝓕`." UC12 §3.3 (Lemma 3.3 proof) says
  "lift the bottom vertex along the trace." Neither gives the cell
  correspondence.
- **(c) the single-family `(ℤ/2)ⁿ`-action** on `C^*(X(𝓕))`, used to split off
  the `χ_S`-isotypes (UC10.W, UC14 Lemma 2.2.1). UC10 §3.5 (Lemma 3.6) asserts
  it is "standard for diagrams over `G`-categories"; UC14 Lemma 2.2.1's proof
  uses a single-family `σ_y`-operator defined by "extension by zero."

### 1.2 Method

Default-skeptical, per the `mg-56b8` / `mg-59d3` brief and the UC13 §4.5 /
UC14 R2 history (a chain-level claim about hocolims that was *false*, caught
only by `mg-552b` / `mg-56b8`). Phase 1.5 does the construction explicitly,
at cell level, and tests every well-definedness obligation on concrete small
objects of `𝒞_n^∩`. Where a construction works it is stated as a pinned
Proposition with proof; where it fails it is refuted by an explicit
counterexample, not waved away.

The discipline is the one `mg-59d3` §5.3 named: a wrong cell correspondence or
a wrong isotype split "would silently produce a wrong cohomology," and the
high-stakes outcomes of the residual computation (a refutation or a
confirmation of the Frankl cohomological route) "cannot be claimed" on
un-pinned foundations. Phase 1.5 is exactly that gate.

### 1.3 Notation, recalled from UC10 §2–§3

- `𝒞_n^∩`: objects `(S,𝓕)`, `S ⊆ [n]`, `𝓕 ⊆ 2^S` intersection-closed,
  `⋃𝓕 = S`, `S ∈ 𝓕`. Morphisms: trace `\mathrm{tr} : (S,𝓕) → (T,𝒢)` for
  `T ⊆ S` with `𝒢 = 𝓕|_T := {A∩T : A ∈ 𝓕}` (UC10 Definition 2.2, Lemma 2.3).
- `X(𝓕)`: the cubical-Walsh-defect complex (UC10 Definition 3.1). A `k`-cell
  is a pair `C(A,T')` with `A ∈ 𝓕`, `T' ⊆ S∖A`, `|T'| = k`, and `A∪T'' ∈ 𝓕`
  for every `T'' ⊆ T'` (the `T'`-subcube of `Q_S` with bottom vertex `A`, all
  `2^k` vertices in `𝓕`). The differential is the standard cubical coboundary.
- `X_n^∩ := \mathrm{hocolim}_{(𝒞_n^∩)^op} X(𝓕)` (UC10 Definition 3.3), with
  the Bousfield–Kan double complex `BK^{p,q}(X_n^∩) = ⊕_{𝓕_0 → ⋯ → 𝓕_p}
  C^q(X(𝓕_p);ℚ)` — the bar sum over trace strings of `𝒞_n^∩`, the cochain
  value at the **last** object `𝓕_p` (`mg-59d3` (3.1)).

---

## §2 — What a structure map must be, made precise

Before constructing anything, fix exactly what object is required, because the
whole Phase-1.5 finding turns on a variance that UC10/UC12 leave implicit.

### 2.1 The functoriality requirement

`X_n^∩ = \mathrm{hocolim}_{(𝒞_n^∩)^op} X(𝓕)` is the homotopy colimit of a
diagram. A diagram over `(𝒞_n^∩)^op` is, by definition, a functor

> `X : (𝒞_n^∩)^op → \mathrm{Ch}_ℚ`,  equivalently  a *contravariant* functor `𝒞_n^∩ → \mathrm{Ch}_ℚ`.

On objects `X(S,𝓕) = C^*(X(𝓕))`. On a trace `\mathrm{tr} : (S,𝓕) → (T,𝓕|_T)`
of `𝒞_n^∩` — which is a morphism `(T,𝓕|_T) → (S,𝓕)` of `(𝒞_n^∩)^op` — the
functor must produce a chain map. On chains the diagram value at `(T,𝓕|_T)` is
`X(𝓕|_T)` and at `(S,𝓕)` is `X(𝓕)`, so the required map is

> **(SM)**  `λ_{\mathrm{tr}} : X(𝓕|_T) → X(𝓕)`,  one for each trace, functorial in composition and identities.

This is item (b). The Bousfield–Kan differential `δ_{BK}` on `BK^{p,q}`
restricts a cochain along exactly these maps: the bar face that drops the last
object `𝓕_{p}` of a string `𝓕_0 → ⋯ → 𝓕_{p}` moves the cochain value from
`C^q(X(𝓕_{p}))` to `C^q(X(𝓕_{p-1}))`, which is the cochain pullback
`λ_{\mathrm{tr}}^* : C^q(X(𝓕_{p-1}|_{T_p})) ← C^q(X(𝓕_{p-1}))` of the
structure map `λ` for the trace `𝓕_{p-1} → 𝓕_{p}`. So `δ_{BK}` is *built from*
(SM); without (SM) the double complex of UC10 §3.3 / `mg-59d3` (3.1) is not
defined.

### 2.2 The variance is load-bearing, and it is fixed by the BK convention

The direction of (SM) — `X(𝓕|_T) → X(𝓕)`, *against* the trace — is not a free
choice. It is forced by the BK convention "cochain value at the **last**
object" (UC10 §3.3; `mg-59d3` (3.1); UC14 §1.2). The opposite convention
(value at the first object) would force the opposite map `X(𝓕) → X(𝓕|_T)` and
the opposite hocolim `\mathrm{hocolim}_{𝒞_n^∩}`.

`mg-59d3` §3.2 ("a variance caution, recorded so it is not mis-used") is
explicit that the hocolim defining `X_n^∩` is over `(𝒞_n^∩)^op` and that this
opposite variance "is the precise reason the residual is hard." Phase 1.5
takes that at face value: the target (b) is the against-trace map (SM), and
§3 tests whether it exists.

### 2.3 What "canonical" means here

UC10 §3.3 and `mg-59d3` §5.2 both promise a *canonical* construction — no
choices, functorial, equivariant. A non-canonical chain map (chosen
cell-by-cell, depending on arbitrary orderings) is not a pinning: it would
have to be checked functorial and `Γ_n`-equivariant by hand for every trace,
which is precisely the un-pinned mess Phase 1.5 is meant to remove. So the
bar for "(b) is pinned" is: a canonical, functorial, cellular chain map (SM).

---

## §3 — (b) The trace-induced structure map: construction attempted, refuted

### 3.1 The minimal lift `β` — what genuinely works

Fix a trace `(S,𝓕) → (T,𝓕|_T)`. For `A ∈ 𝓕|_T` define the **fibre**
`𝓕_A := {B ∈ 𝓕 : B∩T = A}`.

> **Lemma 3.1 (the minimal lift exists).** *For every `A ∈ 𝓕|_T` the fibre
> `𝓕_A` is non-empty and closed under intersection; hence it has a minimum*
> $$β(A) := \bigcap\{B ∈ 𝓕 : B∩T = A\} ∈ 𝓕_A,$$
> *and `β(A)∩T = A`.*

*Proof.* Non-empty: `A ∈ 𝓕|_T` means `A = B∩T` for some `B ∈ 𝓕`.
Intersection-closed: if `B_1,B_2 ∈ 𝓕_A` then `B_1∩B_2 ∈ 𝓕` (`𝓕`
intersection-closed) and `(B_1∩B_2)∩T = (B_1∩T)∩(B_2∩T) = A∩A = A`, so
`B_1∩B_2 ∈ 𝓕_A`. A non-empty finite family closed under intersection has a
minimum, namely the intersection of all its members; it lies in the family.
`β(A)∩T = (⋂_{B∈𝓕_A}B)∩T = ⋂_{B∈𝓕_A}(B∩T) = A`. ∎

> **Lemma 3.2 (`β` is monotone).** *If `A_1 ⊆ A_2` in `𝓕|_T` then
> `β(A_1) ⊆ β(A_2)`.*

*Proof.* Let `B ∈ 𝓕_{A_2}` be arbitrary. Then `β(A_1)∩B ∈ 𝓕` and
`(β(A_1)∩B)∩T = A_1∩A_2 = A_1`, so `β(A_1)∩B ∈ 𝓕_{A_1}`; by minimality
`β(A_1) ⊆ β(A_1)∩B`, i.e. `β(A_1) ⊆ B`. This holds for every `B ∈ 𝓕_{A_2}`,
so `β(A_1) ⊆ ⋂𝓕_{A_2} = β(A_2)`. ∎

So far so good: `β : 𝓕|_T → 𝓕` is a canonical, monotone section of the
set-level trace `(-)∩T : 𝓕 ↠ 𝓕|_T`. This is the genuine positive content
behind the Phase-1 §5.2 sketch. The question is whether `β` *extends to a
chain map* `X(𝓕|_T) → X(𝓕)`.

### 3.2 The well-definedness obligation Phase-1 §5.2 flagged

The minimal-lift recipe of `mg-59d3` §5.2, verbatim, is: *"The canonical lift
of a cell `C(A,T')` of `X(𝓕|_T)` is `C(β(A),T')`; the trace-induced map is
`C(A,T') ↦ C(β(A),T')`. This must be checked well-defined (that `C(β(A),T')`
is a genuine cell of `X(𝓕)` — i.e. `β(A)∪T'' ∈ 𝓕` for all `T'' ⊆ T'`)."*

So the recipe `λ` is the cellular map `C(A,T') ↦ C(β(A),T')`, and Phase-1
itself isolated the obligation:

> **(WD)**  For every cell `C(A,T')` of `X(𝓕|_T)` and every `T'' ⊆ T'`,  `β(A)∪T'' ∈ 𝓕`.

(One sub-condition is free: `T' ⊆ S∖β(A)`, because `T' ⊆ T∖A` gives
`T'∩β(A) = T'∩(β(A)∩T) = T'∩A = ∅` by Lemma 3.1. The content of (WD) is the
membership `β(A)∪T'' ∈ 𝓕`.)

Phase 1.5 discharges (WD). It is **false**.

### 3.3 First refutation — (WD) fails

> **Example 3.3 (`n = 3`).** Take `S = [3] = \{1,2,3\}` and
> $$𝓕 = \{\ ∅,\ \{3\},\ \{1,3\},\ \{2,3\},\ \{1,2,3\}\ \}.$$
> Intersection-closed (the only non-obvious pair: `\{1,3\}∩\{2,3\} = \{3\} ∈ 𝓕`);
> `⋃𝓕 = \{1,2,3\} = S`; `S ∈ 𝓕`. So `([3],𝓕) ∈ 𝒞_3^∩`. Trace to `T = \{1,2\}`:
> `𝓕|_T = \{∅,\{1\},\{2\},\{1,2\}\} = 2^T`. So `X(𝓕|_T)` is the solid square,
> which has the 2-cell `C(∅,\{1,2\})`.
>
> Compute `β` on the bottom vertex: `𝓕_∅ = \{B ∈ 𝓕 : B∩T = ∅\} = \{∅,\{3\}\}`,
> so `β(∅) = ∅∩\{3\} = ∅`. The recipe lifts `C(∅,\{1,2\})` to
> `C(β(∅),\{1,2\}) = C(∅,\{1,2\})`. For this to be a cell of `X(𝓕)` (WD)
> requires `∅∪\{1\} = \{1\} ∈ 𝓕` — but `\{1\} ∉ 𝓕`. **(WD) fails.**

Note the geometric fact behind the failure: `X(𝓕)` *does* have a 2-cell,
`C(\{3\},\{1,2\})` (its four vertices `\{3\},\{1,3\},\{2,3\},\{1,2,3\}` are all
in `𝓕`), and its bottom vertex `\{3\}` is **not** `β(∅) = ∅`. The minimal
lift of the *bottom vertex* and the bottom vertex of the *lifted cell*
disagree. The recipe cannot be repaired by "use a cell-dependent minimum"
either: the vertex `∅` is simultaneously the 0-cell `C(∅,∅)` (whose
cell-minimum is `∅`) and a corner of the 2-cell `C(∅,\{1,2\})` (whose
cell-minimum is `\{3\}`), so no single vertex map is consistent across cells.

### 3.4 Decisive refutation — no chain map exists at all

Example 3.3 might be read as "wrong recipe, right idea": there a cellular
against-trace map *does* exist (`C(A,T') ↦ C(A∪\{3\},T')`), just not the
minimal lift. The next example removes that escape: it exhibits a trace for
which **no** cellular against-trace map exists, and the minimal lift `β` does
not extend to a chain map by *any* convention.

> **Example 3.4 (`n = 4`; the decisive counterexample).** Take `S = [4]` and
> $$𝓕 = \{\ ∅,\ \{1,3\},\ \{2,4\},\ \{1,2,3,4\}\ \}.$$
> *Object check.* Pairwise intersections: `∅` with anything is `∅`;
> `\{1,3\}∩\{2,4\} = ∅`; `\{1,3\}∩\{1,2,3,4\} = \{1,3\}`;
> `\{2,4\}∩\{1,2,3,4\} = \{2,4\}` — all in `𝓕`, so `𝓕` is intersection-closed.
> `⋃𝓕 = \{1,2,3,4\} = S`; `S ∈ 𝓕`. So `([4],𝓕) ∈ 𝒞_4^∩`.
>
> *Trace.* Take `T = \{1,2\}`. Then
> `𝓕|_T = \{∅, \{1,3\}∩T, \{2,4\}∩T, S∩T\} = \{∅,\{1\},\{2\},\{1,2\}\} = 2^T`,
> a valid object `(T,2^T) ∈ 𝒞_4^∩`, and `\mathrm{tr} : ([4],𝓕) → (T,2^T)` is a
> genuine morphism of `𝒞_4^∩`.
>
> *Source complex.* `X(𝓕|_T) = X(2^T)` is the **solid square** `Q_T` — it has
> one 2-cell `C(∅,\{1,2\})`, four edges, four vertices; it is connected and
> contractible.
>
> *Target complex.* `X(𝓕)` has **no edges and no higher cells**: an edge
> `C(A,\{t\})` needs two members of `𝓕` differing by the single element `t`,
> but every two distinct members of `𝓕` differ by `2` or `4` elements
> (`∅`–`\{1,3\}`: 2; `∅`–`\{2,4\}`: 2; `∅`–`S`: 4; `\{1,3\}`–`\{2,4\}`: 4;
> `\{1,3\}`–`S`: 2; `\{2,4\}`–`S`: 2). So
> $$X(𝓕) = \{\ ∅,\ \{1,3\},\ \{2,4\},\ \{1,2,3,4\}\ \}\quad\text{— four isolated vertices.}$$

> **Proposition 3.5 (the against-trace structure map does not exist for the
> trace of Example 3.4).** *There is no canonical cellular chain map
> `X(𝓕|_T) → X(𝓕)`; in particular the minimal lift `β` does not extend to a
> chain map.*

*Proof.* `dim X(𝓕|_T) = 2` while `dim X(𝓕) = 0`. A cellular chain map sends a
2-cell to a `2`-chain, but `X(𝓕)` has no 2-cells, no 1-cells: the only chains
of `X(𝓕)` are 0-chains. The 2-cell `C(∅,\{1,2\})` of `X(𝓕|_T)` therefore has
no cellular image, and a fortiori the recipe `C(A,T') ↦ C(β(A),T')` is
undefined on it. As for the minimal lift `β` itself: on vertices it is the
bijection `∅ ↦ ∅`, `\{1\} ↦ \{1,3\}`, `\{2\} ↦ \{2,4\}`, `\{1,2\} ↦ S`
(`𝓕_{\{1\}} = \{\{1,3\}\}` etc.), a perfectly good monotone vertex map. But an
edge of `X(𝓕|_T)`, say `C(∅,\{1\})`, would have to map to a 1-chain of `X(𝓕)`
joining `β(∅) = ∅` to `β(\{1\}) = \{1,3\}` — and `X(𝓕)` is totally
disconnected, so no such 1-chain exists. `β` does not extend to a chain map by
any convention. ∎

This is decisive. The diagram functor `X : (𝒞_n^∩)^op → \mathrm{Ch}` named by
UC10 Definition 3.3 — the functor whose hocolim *is* `X_n^∩` — does not exist:
one of its required structure maps (SM) cannot be supplied. The "every subcube
of `Q_T` inside `𝓕|_T` lifts to a subcube of `Q_S` inside `𝓕`" of UC10 §3.3
is **false** — in Example 3.4 the 2-subcube `\{∅,\{1\},\{2\},\{1,2\}\}` of
`Q_T` inside `𝓕|_T` does not lift to any 2-subcube of `Q_S` inside `𝓕`,
because `𝓕` contains no 2-subcube at all.

### 3.6 What does exist: the canonical projection (opposite variance)

The construction that *is* canonical runs the other way.

> **Proposition 3.6 (the trace projection, pinned).** *For every trace
> `(S,𝓕) → (T,𝓕|_T)` of `𝒞_n^∩` the assignment*
> $$π_T\bigl(C(A,T')\bigr) := \begin{cases} C(A∩T,\ T') & \text{if } T' ⊆ T,\\[2pt] 0 & \text{if } T' ⊄ T,\end{cases}$$
> *is a well-defined cellular chain map `π_T : X(𝓕) → X(𝓕|_T)`, and it is
> functorial: `π_{T'} ∘ π_T = π_{T'}` for `T' ⊆ T ⊆ S`, and `π_S = \mathrm{id}`.
> Hence `X : 𝒞_n^∩ → \mathrm{Ch}`, `(S,𝓕) ↦ X(𝓕)`, `\mathrm{tr} ↦ π_T`, is a
> genuine covariant functor.*

*Proof.* `π_T` is the cubical projection induced by the coordinate projection
`Q_S → Q_T`, `A ↦ A∩T`, on the level of cubical chains, with the standard
normalised convention that a cell collapsing a coordinate (here `T' ⊄ T`,
i.e. some varying direction lies in `S∖T`) is degenerate and maps to `0`.
*Well-defined.* For a cell `C(A,T')` of `X(𝓕)` with `T' ⊆ T`: `A∩T ∈ 𝓕|_T`;
`T' ⊆ S∖A` and `T' ⊆ T` give `T' ⊆ T∖(A∩T)`; and for `T'' ⊆ T'` one has
`(A∩T)∪T'' = (A∪T'')∩T ∈ 𝓕|_T` since `A∪T'' ∈ 𝓕`. So `C(A∩T,T')` is a genuine
cell of `X(𝓕|_T)`. *Chain map.* The cubical coboundary is natural under
cubical projections (a coordinate projection commutes with face maps; faces in
a collapsed direction produce equal-and-opposite degenerate terms that cancel)
— this is the standard fact that a projection of cubes is a chain map.
*Functorial.* Coordinate projections compose: `(A∩T)∩T' = A∩T'` for
`T' ⊆ T ⊆ S`, and the degenerate-to-zero convention is compatible with
composition; `π_S` is the identity. ∎

`π_T` is everything (b) was supposed to be — canonical, cellular, functorial —
except that it has the **opposite variance**: it makes `X` a *covariant*
functor `𝒞_n^∩ → \mathrm{Ch}`, whose homotopy colimit is
`\mathrm{hocolim}_{𝒞_n^∩} X`, not `\mathrm{hocolim}_{(𝒞_n^∩)^op} X`.

### 3.7 Diagnosis

The honest situation is a **variance defect** in the UC10 foundation:

1. The trace functor of `𝒞_n^∩` induces, canonically, the projection
   `π_T : X(𝓕) → X(𝓕|_T)` (Proposition 3.6) — same direction as the trace.
2. The Bousfield–Kan double complex UC10 §3.3 / `mg-59d3` (3.1) is written
   with the cochain value at the **last** object of each bar string, which
   requires the structure map to run *against* the trace — the map (SM) of §2.
3. The against-trace map (SM) **does not exist** canonically (Proposition
   3.5).

So UC10's `X_n^∩ = \mathrm{hocolim}_{(𝒞_n^∩)^op} X(𝓕)` is, as written, not a
defined object: its diagram functor does not exist. The defined object in the
neighbourhood is `\mathrm{hocolim}_{𝒞_n^∩} X(𝓕)` built from the projections
`π_T` — but that is a *different* complex (the BK value sits at the *first*
object, the bar differential restricts *along* traces), and replacing one with
the other is a re-foundation, not a notation fix: it changes which comma
categories appear in the `mg-56b8` residual presentation
(`V_S^* = ℍ^*(\mathrm{hocolim}\, ρ_x^* G)`), it changes the variance caution
of `mg-59d3` §3.2, and it must be re-checked against UC12's cofiber LES and
null-homotopy. That is the §6 design fork.

A note on UC12. UC12 never actually uses the against-trace map (b): its
load-bearing maps are the doubling `db` and the *projection* `X(db𝓕) ≅
X(𝓕)×I → X(𝓕)` ("evaluate at `n+1 = 0`," UC12 Corollary 2.8) — which is a
projection, the §3.6 variance. UC12's null-homotopy `h` is built on cochains
and is internally consistent *with the projection variance*. This is further
evidence that the projection is the correct structure map and that UC10
Definition 3.3's stated variance is the error.

---

## §4 — (c) The single-family `(ℤ/2)ⁿ`-action: pinned in the small, blocked in the assembly

### 4.1 The single-family partial reflection `σ_y` — what genuinely works

Fix `(S,𝓕) ∈ 𝒞_n^∩` and `y ∈ S`. The cube reflection `σ_y` toggles
coordinate `y`. On a cell `C(A,T')` of `X(𝓕)`:

- if `y ∈ T'`: `σ_y` maps the subcube `C(A,T')` to itself, reversing the
  `y`-direction — same cell, orientation sign `−1`;
- if `y ∉ T'`: `σ_y` maps the subcube `C(A,T')` to the translate
  `C(A△\{y\},T')`, which is a cell of `Q_S` but lies in `X(𝓕)` only when all
  its vertices are in `𝓕`.

Call `C(A,T')` **`σ_y`-matched** when `σ_y C(A,T')` is again a cell of `X(𝓕)`
(automatic if `y ∈ T'`; for `y ∉ T'` it means `(A△\{y\})∪T'' ∈ 𝓕` for all
`T'' ⊆ T'`), and **`σ_y`-stuck** otherwise.

> **Lemma 4.1 (`σ_y` is a partial cellular involution; the matched cells form
> a subcomplex).** *The `σ_y`-matched cells of `X(𝓕)` form a subcomplex
> `M_y(𝓕) ⊆ X(𝓕)` (closed under taking faces), and `σ_y` restricts to a
> cellular involution `σ_y : M_y(𝓕) → M_y(𝓕)`.*

*Proof.* Closed under faces: a face of `C(A,T')` is `C(A,T'∖t)` or
`C(A∪\{t\},T'∖t)` for `t ∈ T'`; if `C(A,T')` is `σ_y`-matched then
`σ_y C(A,T') = C(A△\{y\},T')` (case `y ∉ T'`) or `C(A,T')` itself (case
`y ∈ T'`) is a cell, and the two displayed faces of `C(A,T')` translate under
`σ_y` to faces of `σ_y C(A,T')`, hence to cells. So every face of a matched
cell is matched. `σ_y` is an involution on `M_y(𝓕)` because `σ_y^2 = \mathrm{id}`
on `Q_S` and `M_y(𝓕)` is `σ_y`-stable by construction. ∎

This much is genuine, pinnable positive content: `σ_y` is a well-defined
**partial** cellular involution `X(𝓕) ⇢ X(𝓕)`, defined exactly on the
subcomplex `M_y(𝓕)`.

### 4.2 The operator `s_y` — pinned as a graded operator

UC14 Lemma 2.2.1's proof uses the single-family operator `s_y` ("`σ_y^*`,
extension by zero"). Pinned precisely:

> **Definition 4.2.** `s_y : C^k(X(𝓕);ℚ) → C^k(X(𝓕);ℚ)` is the composite
> $$C^*(X(𝓕)) \xrightarrow{\ \mathrm{res}\ } C^*(M_y(𝓕)) \xrightarrow{\ σ_y^*\ } C^*(M_y(𝓕)) \xrightarrow{\ \mathrm{ext}_0\ } C^*(X(𝓕)),$$
> where `res` is restriction to the subcomplex `M_y(𝓕)`, `σ_y^*` is the
> (invertible) cochain pullback of the involution of Lemma 4.1, and `ext_0`
> extends a cochain by zero on cells outside `M_y(𝓕)`. Explicitly: for a cell
> `C`, `(s_yω)(C) = −ω(C)` if `y ∈ T'`; `(s_yω)(C) = ω(σ_y C)` if `C` is
> `σ_y`-matched with `y ∉ T'`; `(s_yω)(C) = 0` if `C` is `σ_y`-stuck.

`s_y` is a well-defined **graded linear operator**. This matches UC14 Lemma
2.2.1's usage. But it falls short of a `ℤ/2`-action in two precise ways, both
of which UC10/UC14 elide.

### 4.3 `s_y` is not a cochain map

> **Proposition 4.3.** *`s_y` does not commute with the cubical coboundary `d`
> in general: `d s_y ≠ s_y d`.*

*Proof.* `res` and `σ_y^*` are cochain maps; `ext_0` is **not** — extending a
cochain by zero off a subcomplex does not commute with `d`, because `d`
evaluates a cochain on the faces of a cell, and a cell outside `M_y(𝓕)` can
have faces inside `M_y(𝓕)`. Concretely, let `C` be a `σ_y`-stuck cell that has
a `σ_y`-matched face `F` (such configurations exist: `C` stuck means
`σ_y C(A,T')` fails to be a cell because some translated vertex
`(A△\{y\})∪T''` is not in `𝓕`, while a face `F` not involving that `T''` can
still be matched — Lemma 4.1 only gives matched ⟹ faces matched, not the
converse). Then `(s_y dω)(C) = 0` because `C` is stuck, whereas `(d s_yω)(C) =
(s_yω)(∂C) = Σ_F [F:C]\,(s_yω)(F)` contains the term `[F:C]\,ω(σ_y F)`, which
is generically non-zero. So `d s_y ω ≠ s_y d ω`. ∎

UC10.W (UC10 Theorem 3.5) claims the Walsh decomposition holds "at the level
of chain complexes" because "the differential commutes with `(ℤ/2)ⁿ`." At the
single-family level the operators `s_y` are what is available, and Proposition
4.3 shows they do not commute with `d`. So UC10.W is not justified by the
single-family `s_y` — it needs a genuine action (§4.5).

### 4.4 The joint eigenspaces do not span `C^*(X(𝓕))`

> **Proposition 4.4.** *Define, for `S ⊆ [n]`, the joint eigenspace
> `E_S^k := \{ω ∈ C^k(X(𝓕)) : s_yω = (−1)^{[y∈S]}ω\ \text{for all } y ∈ S(𝓕)\}`.
> Then `⊕_S E_S^k ⊊ C^k(X(𝓕))` strictly whenever `X(𝓕)` has a cell that is
> `σ_y`-stuck for some `y ∉ T'`.*

*Proof.* If `C = C(A,T')` is `σ_y`-stuck with `y ∉ T'`, then `(s_yω)(C) = 0`
for every `ω`. For `ω ∈ E_S^k` the eigenvalue equation reads
`0 = (s_yω)(C) = (−1)^{[y∈S]}ω(C)`, forcing `ω(C) = 0` — and this holds in
*every* `E_S^k`, regardless of whether `y ∈ S`. So every joint eigenvector
vanishes on `C`, hence `⊕_S E_S^k` is contained in the proper subspace
`\{ω : ω(C) = 0\}`. ∎

This is the single-family shadow of the UC14 R2 failure (`mg-56b8` §4–§5): the
isotype "decomposition" is really a decomposition of the *matched* part only,
and the stuck cells — which carry the genuine Y1 content — are invisible to it.
A direct-sum Walsh decomposition `C^* = ⊕_S χ_S ⊗ V_S^*` cannot be read off
the single-family `s_y`.

### 4.5 The assembly into a genuine `(ℤ/2)ⁿ`-action on `X_n^∩` does not go through

UC10 Lemma 3.6 asserts `X_n^∩` carries a genuine `(ℤ/2)ⁿ`-action and proves it
by: *"the hocolim of a `Γ_n`-equivariant diagram over a `S_n`-equivariant
indexing … the technical verification is standard for diagrams over
`G`-categories."* The hypothesis of that machinery is absent on the `(ℤ/2)ⁿ`
factor:

- **`(ℤ/2)ⁿ` does not act on the indexing.** UC10 §2.4 is itself explicit:
  `σ_y` does not preserve intersection-closure, so `(ℤ/2)ⁿ` does not act on
  `𝒞_n^∩`. The "diagram over a `G`-category" hypothesis fails for `G = (ℤ/2)ⁿ`.
- **`(ℤ/2)ⁿ` does not preserve the diagram values either.** `σ_y` sends the
  summand `X(𝓕)` to `X(σ_y𝓕)`, and `σ_y𝓕 = \{A△\{y\} : A ∈ 𝓕\}` is *not*
  intersection-closed (it is the union-closed flip) — `σ_y𝓕 ∉ 𝒞_n^∩`. So
  `σ_y` does not even map the diagram `X : 𝒞_n^∩ → \mathrm{Ch}` to itself; it
  maps it to the sibling diagram on `𝒞_n^∪`.

A finite-group action on a hocolim `\mathrm{hocolim}_I D` is produced when `G`
acts on `I` and `D` is `G`-equivariant; here `(ℤ/2)ⁿ` acts on neither `I` nor
the values. UC10 Lemma 3.6's "standard for `G`-categories" therefore does not
apply to `(ℤ/2)ⁿ` — only to the `S_n` factor (which *does* act on `𝒞_n^∩`,
UC10 §2.4). The genuine `(ℤ/2)ⁿ`-action on `X_n^∩`, and hence the Walsh
decomposition UC10.W and every `V_S^*` built on it, is **asserted but not
constructed**.

This is the (c) block. It is, if anything, deeper than the (b) block: (b) is a
fixable variance error; (c) is the absence of the group action that the entire
Walsh-isotype apparatus — UC10.W, UC10.1, the `V_S^*` the Y1 residual is
phrased in — is built on.

---

## §5 — Net effect: what is and is not blocked

### 5.1 Pinned (positive Phase-1.5 content)

- **Lemma 3.1 / 3.2** — the minimal lift `β : 𝓕|_T → 𝓕` exists and is a
  canonical monotone section of the set-level trace. (It just does not extend
  to a chain map — §3.4.)
- **Proposition 3.6** — the canonical cellular **projection**
  `π_T : X(𝓕) → X(𝓕|_T)`, functorial, making `X` a genuine covariant functor
  `𝒞_n^∩ → \mathrm{Ch}`. This *is* a pinned cell-level structure map — in the
  variance UC12 actually uses.
- **Lemma 4.1 / Definition 4.2** — the single-family partial cube reflection
  `σ_y` (a cellular involution of the matched subcomplex `M_y(𝓕)`) and the
  graded operator `s_y`, pinned precisely.

### 5.2 Blocked (the un-pinned-foundations hazard, confirmed)

- **(b) against-trace map** `X(𝓕|_T) → X(𝓕)` — refuted (Example 3.4,
  Proposition 3.5). The UC10 Definition 3.3 diagram functor over `(𝒞_n^∩)^op`
  does not exist.
- **(c) the `(ℤ/2)ⁿ`-action on `X_n^∩`** — not constructible from the
  single-family `s_y` (Propositions 4.3, 4.4) and not obtainable from UC10
  Lemma 3.6's `G`-category argument (§4.5).

### 5.3 Downstream consequences (recorded, not actioned)

These are stated so the §6 decision is made with the cost visible; Phase 1.5
does not re-open them.

- **UC10 §3.3 / Definition 3.3** — the variance of the hocolim is wrong as
  written; `X_n^∩` should be `\mathrm{hocolim}_{𝒞_n^∩} X` via `π_T`.
- **UC10 §3.4 / Theorem 3.5 (UC10.W)** — rests on a `(ℤ/2)ⁿ`-action that is
  not constructed; the Walsh decomposition needs a genuine action (§6).
- **`mg-56b8` §4.3** — the residual presentation
  `V_S^* = ℍ^*(\mathrm{hocolim}_{(𝒞_n^∩)^op} ρ_x^* G)` and the comma-category
  twist `N(ρ_x/−)` are written in the refuted variance; they must be
  re-derived once §6 is decided. The *cofiber-LES reduction itself*
  (`mg-56b8` (RED), re-verified in `mg-59d3` §2) is a statement about the pair
  `(X_n^∩, X_{n-1,x}^∩)` and is not touched by Phase 1.5 — but the object
  `X_n^∩` it speaks about must first be given a defined construction.
- **`mg-59d3` §3.2 (the variance caution)** — correctly insisted the hocolim
  is over `(𝒞_n^∩)^op`; Phase 1.5 finds that variance is exactly what fails.
  The "opposite-variance comma fibre" of `mg-59d3` §3.2 is the comma fibre of
  a hocolim that, as written, does not exist.
- **Lean (Phase 3)** — `mg-59d3` §5.3 already noted there is no faithful Lean
  Bousfield–Kan model. Phase 1.5 sharpens that: there is nothing yet to
  formalise, because the diagram functor itself is undefined.

---

## §6 — The repair path (a design fork — out of scope, routed to Daniel)

The structure maps *are* repairable. But the repair is a re-foundation choice,
not a write-up patch, and it is explicitly **out of scope for Phase 1.5** (the
brief scopes Phase 1.5 to "pin the maps … via a canonical minimal-lift," and
the minimal-lift is refuted). The fork is recorded here, with cost, for
Daniel's decision via `pm-onethird`.

**Fork A — adopt the covariant hocolim.** Define
`X_n^∩ := \mathrm{hocolim}_{𝒞_n^∩} X(𝓕)` with the pinned projections `π_T`
(Proposition 3.6) as structure maps. This is a genuinely defined object with a
genuinely defined Bousfield–Kan double complex (cochain value at the *first*
object of each bar string; `δ_{BK}` restricts *along* traces via `π_T^*`).
Cost: the `mg-56b8` residual presentation, the `mg-59d3` §3.2 comma-category
analysis, and UC12's cofiber LES must all be re-derived in this variance — UC12
is already projection-consistent (§3.7), which is encouraging, but the
re-derivation is real work. Open question Fork A must answer: whether the
covariant hocolim still carries the cofiber LES the Y1 reduction needs, and
whether its comma categories are the "stuck-family fibres" `mg-56b8` /
`mg-59d3` rely on.

**Fork B — enlarge the indexing category so `(ℤ/2)ⁿ` acts.** The `(ℤ/2)ⁿ`
block (§4.5) is independent of the variance block and is not solved by Fork A.
A genuine `(ℤ/2)ⁿ`-action requires an indexing category that `(ℤ/2)ⁿ` acts on
— e.g. the category of *all* families (intersection-closed and their
union-closed flips) on subsets of `[n]`, or the realisation of `X_n^∩` as a
defect subobject inside the genuinely `Γ_n`-equivariant cubical complex of the
ambient `Q_n`. Either route changes what `X_n^∩` *is* and must be reconciled
with UC10.W / UC10.1.

**Both forks are genuine mathematics, plausibly multi-session, and both must be
costed against the alternative** — that the cubical-Walsh-defect model of
UC10, as a foundation for the Y1 residual, has a defect that no local patch
fixes, and the Y1 closure should be re-approached by a different route. That
is a strategic call for Daniel, not a polecat call. Phase 1.5's job was the
foundational verification; the verification is done and it is negative.

---

## §7 — Verdict, recommendations, cross-references

### 7.1 Verdict

**RED — BK-STRUCTURE-MAPS-NOT-PINNED (Phase 1.5).** The cell-level
Bousfield–Kan structure maps of UC10/UC12 cannot be pinned as asserted. The
canonical minimal-lift `C(A,T') ↦ C(β(A),T')` of `mg-59d3` §5.2 is refuted by
an explicit object of `𝒞_4^∩` (Example 3.4); the against-trace structure map
`X(𝓕|_T) → X(𝓕)` of UC10 Definition 3.3 does not exist as a canonical chain
map (Proposition 3.5), so the diagram functor whose hocolim is `X_n^∩` is
undefined; and the `(ℤ/2)ⁿ`-action on `X_n^∩` of UC10 Lemma 3.6 is not
constructible (§4.5). Per the `mg-0405` brief — *"Block-and-report if the
canonical-minimal-lift pinning does not actually work — do not paper over"* —
this is a sanctioned BLOCK, and an important one: it is precisely the
un-pinned-foundations hazard `mg-59d3` §5 flagged, now confirmed to be a real
defect and not merely a write-up debt.

### 7.2 What Phase 1.5 delivered (positive content)

1. The minimal lift `β` exists and is monotone (Lemmas 3.1, 3.2) — the
   salvageable kernel of the Phase-1 §5.2 sketch.
2. The well-definedness obligation (WD) Phase-1 §5.2 itself flagged is
   discharged — **negatively** (Example 3.3, Example 3.4).
3. The canonical **projection** structure map `π_T : X(𝓕) → X(𝓕|_T)` is
   pinned and shown functorial (Proposition 3.6): a genuine, canonical
   cell-level structure map — in the variance UC12 actually uses.
4. The single-family partial reflection `σ_y` and operator `s_y` are pinned
   precisely (Lemma 4.1, Definition 4.2), and their two precise shortfalls —
   not a cochain map (Prop 4.3), eigenspaces do not span (Prop 4.4) — are
   established.
5. The variance defect is diagnosed (§3.7) and the `(ℤ/2)ⁿ`-action gap is
   diagnosed (§4.5); the repair fork is named and costed (§6).

### 7.3 Recommendations (routed to Daniel via `pm-onethird`)

1. **Record Y1 as `RED — open` still**, and record the Bousfield–Kan
   foundation of UC10 as carrying a confirmed variance defect (the hocolim of
   UC10 Definition 3.3 is undefined as written) and a confirmed
   `(ℤ/2)ⁿ`-action gap (UC10 Lemma 3.6).
2. **Do not attempt the Y1 residual computation** (the `n = 3` instance or the
   general coefficient-blindness statement of `mg-59d3` Reformulation 4.2)
   until §6 is decided. There is, today, no defined object `X_n^∩` to compute
   the residual in — computing it now would be exactly the UC13 §4.5 / UC14 R2
   failure mode the brief forbids.
3. **Decide the §6 fork.** This is the gating decision. Fork A (covariant
   hocolim) and Fork B (enlarged indexing for `(ℤ/2)ⁿ`) are both genuine
   re-foundations; the alternative — re-approaching Y1 by a non-UC10 route —
   should be on the table. This is a strategic call for Daniel.
4. **Do not Lean-formalise** — unchanged from `mg-56b8` / `mg-59d3`; §5.3
   above sharpens it: the diagram functor itself is undefined.
5. **The Zulip post stays held.**

### 7.4 Cross-references

- **Brief:** `mg-0405`. **Phase-1 parent:** `mg-59d3`
  (`docs/Frankl-Y1-close-phase1.md`, §5 the foundational blocker).
- **Reduction built on:** `mg-56b8` (`docs/Frankl-Y1-reprove.md`, the
  cofiber-LES reduction — sound as a statement, but about an object whose
  construction Phase 1.5 finds undefined).
- **Foundational sources audited:** UC10 (§2.4 `(ℤ/2)ⁿ` does not act on
  `𝒞_n^∩`; §3.1 Definition 3.1 `X(𝓕)`; §3.3 Definition 3.3 the hocolim and
  the asserted "subcube lift"; §3.4 Theorem 3.5 UC10.W; §3.5 Lemma 3.6 the
  asserted `Γ_n`-action). UC12 (§2 the doubling functor; §2.4 Lemma 2.7 the
  prism; §3.3 Lemma 3.3 "lift the bottom vertex"; Corollary 2.8 the
  projection `X(db𝓕) → X(𝓕)`). UC14 (§2.2 Lemma 2.2.1 cell-level Walsh
  support; §2.6 Lemma 2.6.1; the §2.6+ correction banner).
- **Onboarding:** `docs/PROOF-STRUCTURE-ONBOARDING.md`.
- **Paper:** `paper/sections/06-residual.tex` (`rem:y1-prerequisite`,
  `ssec:next-steps`), `05-proof-state.tex` (`res:y1`). Not edited by Phase 1.5;
  honest update recommended as a follow-on once §6 is decided.

---

*Phase-1.5 by polecat `cat-mg-0405`. Deliverable on `main`: this document.
Verdict: **RED — BK-STRUCTURE-MAPS-NOT-PINNED (Phase 1.5).** The canonical
minimal-lift is refuted by an explicit `n = 4` counterexample; the trace-induced
structure map `X(𝓕|_T) → X(𝓕)` of UC10 Definition 3.3 does not exist in the
variance the Bousfield–Kan double complex requires; the `(ℤ/2)ⁿ`-action on
`X_n^∩` of UC10 Lemma 3.6 is not constructible from the single-family
operators. Positive content: the canonical projection `π_T : X(𝓕) → X(𝓕|_T)`
is pinned, and the single-family partial reflection `σ_y` / operator `s_y` are
pinned as far as they go. The structure maps are not pinned as asserted; the Y1
residual computation cannot be honestly attempted until the §6 design fork is
decided. Per the `mg-0405` brief, a BLOCK of this shape — the canonical
minimal-lift genuinely does not work — is the sanctioned and correct outcome.
Recommended next: Daniel decides the §6 fork before any further Y1 work.*
