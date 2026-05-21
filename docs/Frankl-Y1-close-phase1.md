# Frankl-Y1-Close Phase 1 — computing the named residual: structural sharpening, foundational prerequisite, and RED verdict

**Work item:** `mg-59d3` (Frankl-Y1-Close-LaTeX, Phase 1). Per the Daniel
2026-05-21 directive: invest in closing Y1 — LaTeX first, then independent
validation, then Lean. This document is the Phase-1 (LaTeX / paper-and-pencil)
deliverable. It builds on, and does not redo, the `mg-56b8` cofiber-LES
reduction (`docs/Frankl-Y1-reprove.md`), which is referee-grade and sound.

**Brief.** Compute the named residual the `mg-56b8` reduction localised Y1 to
— the `χ_S`-isotype cohomology of the cofiber of the matched-cylinder
inclusion `X(𝒟ₓ) ↪ Xₙ∩` — and thereby close Y1 (the level-1 / lower Walsh
vanishing), producing a complete valid proof in LaTeX. The brief explicitly
sanctions a RED: "If the residual genuinely does not compute, or computes to a
value that REFUTES Y1, block-and-report — a RED is a valid and important
outcome."

---

## §0 — Verdict (top of page)

### 0.1 Headline: **RED — Y1-NOT-CLOSED (Phase 1).** The named residual is **not computed** in this phase. It does not refute Y1 either: no counterexample is produced. What Phase 1 delivers is a strict *sharpening* of the residual — to a precise **coefficient-blindness** statement over one fixed, `S`-independent diagram — together with the identification of a **foundational prerequisite** (the cell-level trace map and the single-family `(ℤ/2)ⁿ`-action) that must be pinned before the residual can be honestly computed or formalised.

Three findings, each derived by hand and cross-checked against the program's
own committed documents (UC10, UC12, UC14, and the `mg-56b8` re-derivation).

1. **The `mg-56b8` reduction is sound and is the correct floor.** The
   cofiber-LES + induction method validly reduces Y1, for `S ⊊ [n]` with
   `|S| ≤ n-2`, to the vanishing of `V_S^k(cofib ιₓ)` — equivalently
   `V_S^k(Xₙ∩/X(𝒟ₓ))`. This document re-verifies that reduction independently
   (§2) and builds on it. It does **not** re-open it.

2. **The residual sharpens to a coefficient-blindness statement (§3–§4).**
   The cofiber Bousfield–Kan cochain complex, restricted to the `χ_S`-isotype,
   is `⊕_{bar strings exiting 𝒟ₓ} G_S(ρₓ𝓕_p)` — the value at any string
   depends, by UC14 Lemma 2.2.1, only on the trace `ρₓ` of the string's last
   object. The **diagram shape** — which bar strings, the comma categories of
   `ρₓ` — is **independent of the Walsh index `S`**; only the *coefficient
   system* `G_S` depends on `S`. Consequently Y1's `|S|`-stratification
   (vanish for `|S| ≤ n-2`, the sphere class `sgn` for `|S| = n-1`) is **not**
   a statement about the homotopy type of the stuck-family fibres at all —
   that homotopy type is one fixed thing. It is a statement about which
   coefficient systems can *see* it. Y1 is precisely: **the lower-Walsh
   coefficient systems `G_S` (`|S| ≤ n-2`) are blind to the
   non-contractibility of the stuck-family fibres of `ρₓ`** that the
   top-of-the-smaller-cube system `G_{[n]∖x}` does see.

3. **A foundational prerequisite is not pinned (§5).** Computing the residual
   — by hand at `n = 3` or by machine, and a fortiori formalising it — requires
   the cell-level structure maps of the Bousfield–Kan model: the
   trace-induced map `X(𝓕|_T) → X(𝓕)` and the single-family `σ_y`-action on
   `C^*(X(𝓕))`. UC10 §3.3 and UC12 §3.3 *assert* these ("`X(𝓕|_T)` sits
   inside `X(𝓕)`"; "lift the bottom vertex along the trace") and they are
   pinnable — there is a canonical minimal-lift description (§5.2) — but they
   are **not rigorously pinned** in UC10–UC14. Until they are, no honest
   computation of the residual exists, and the high-stakes outcomes (a
   computational *refutation* or *confirmation* of the Frankl cohomological
   route) cannot be claimed. Pinning them is a bounded, self-contained task —
   the recommended Phase-1.5 (§7).

### 0.2 The precise verdict

> **RED — Y1-NOT-CLOSED (Phase 1; residual sharpened, not computed).** Y1
> (level-1 / lower Walsh vanishing) is **not** closed in this LaTeX phase. The
> `mg-56b8` reduction is confirmed; the residual `V_S^k(Xₙ∩/X(𝒟ₓ))` is
> sharpened to the statement that one fixed `S`-independent diagram (the
> `𝒟ₓ`-exiting bar construction of `Cₙ∩`) has vanishing reduced cohomology
> for the lower-Walsh coefficient systems `G_S`, `|S| ≤ n-2`. The residual is
> **not computed**: its computation is a genuine homotopy-colimit /
> comma-category determination (the `mg-56b8` multi-week estimate stands,
> §6), and it is additionally **blocked** on a foundational prerequisite —
> the cell-level Bousfield–Kan structure maps are asserted but not pinned
> (§5). Y1 remains **true-but-unproven**: no counterexample is known, the
> statement is plausibly true (it is `UC10.1` content), but neither the
> reduction nor this sharpening discharges it.

### 0.3 What this phase changes for the project record

- **Y1 stays `RED — open`**, as in `mg-56b8`. This document does **not**
  rescue it and does **not** weaken the standing. It records a sharper
  description of the open object and a blocking prerequisite.
- **The residual is upgraded in the paper.** `docs/`-side: Open
  residual~`res:y1` of the `mg-335b` paper (`paper/sections/06-residual.tex`,
  `05-proof-state.tex`) is refined with the coefficient-blindness reformulation
  and the `S`-independence remark, in LaTeX, as the integrated Phase-1
  deliverable. Y1's status line in the paper stays `RED — open`.
- **A Phase-1.5 prerequisite is identified.** Pinning the Bousfield–Kan
  cell-level structure maps (§5) is now an explicit, bounded blocker upstream
  of any computation, validation (Phase 2) or Lean formalisation (Phase 3) of
  the residual. It should be filed before Phase 2.

### 0.4 Net effect on the Frankl two-part contradiction

Unchanged from `mg-56b8` / `mg-552b`, and sharpened. The contradiction is
`Y1 ∧ Y2 ⟹ ob(F⋆) = 0`. `Y2` is mechanism-sound (`mg-aeee`). `Y1` is still
**not validly proven**. The closing argument of the paper (`§ssec:closing`)
does not close. `Frankl_Holds`'s standing dependence on
`case3_ss_obstruction_paper_axiom` is unaffected. The Zulip post stays held.

---

## §1 — Scope, method, and what "Phase 1" was

### 1.1 The target

> **Y1 (lower / level-1 Walsh vanishing).** For the cubical-Walsh-defect
> complex `Xₙ∩` (`n ≥ 3`): `V_S^k(Xₙ∩) = 0` for every `S ⊊ [n]` and every
> `k ≥ 1`. In particular `V_{x}^{n-1}(Xₙ∩) = 0` for every `x ∈ [n]` — the
> level-1 isotypes that carry `ob(F⋆)` by `Y2`.

`V_S^k` is the multiplicity complex of the Walsh character `χ_S` in the
`(ℤ/2)ⁿ`-equivariant decomposition `C*(Xₙ∩;ℚ) = ⊕_S χ_S ⊗ V_S^*`
(UC10.W = UC10 Theorem 3.5).

### 1.2 The starting point: the `mg-56b8` reduction

`mg-56b8` (`docs/Frankl-Y1-reprove.md`) established, validly, the following.
For `S ⊊ [n]` with `|S| ≤ n-2`, `k ≥ 1`, `x ∈ [n]∖S`, assuming `UC10.1` for
ground sets of size `< n`:

> **(RED)** `j* : V_S^k(cofib ιₓ) --≅--> V_S^k(Xₙ∩)`, where
> `cofib ιₓ = Xₙ∩/X_{n-1,x}∩`; and after stripping the contractible matched
> cylinder (UC14 Lemma 2.3.1, UC12 Lemma 2.7),
> `V_S^k(cofib ιₓ) ≅ V_S^k(Xₙ∩/X(𝒟ₓ))`.

So Y1 (for `|S| ≤ n-2`) **holds iff** `V_S^k(Xₙ∩/X(𝒟ₓ)) = 0` for all `k ≥ 1`
— the **named residual**. The `|S| = n-1` sub-case inherits the same residual
plus a sharp no-collision-with-`sgn` constraint (`mg-56b8` §6).

The reduction is referee-grade. This document treats it as the floor, as the
brief instructs ("Build on the mg-56b8 cofiber-LES reduction (do not redo it —
it is sound)").

### 1.3 What Phase 1 attempted, and the method

Phase 1 attempted to **compute** `V_S^*(Xₙ∩/X(𝒟ₓ))`. The honest method, per
the `mg-56b8` §9.4 entry points: (a) characterise the comma categories of the
trace functor `ρₓ` and their homotopy type; (b) compute the smallest
genuinely open instance (`n = 3`, `S = {1}`, `k = 1`) by hand; (c) use the
`|S| = n-1` collision as the sharpest falsification test.

What Phase 1 **delivers**: the comma-category structure is pinned and a
genuine new structural reduction is obtained (§3–§4); the by-hand `n = 3`
computation and the machine computation are found to be **blocked** on a
foundational prerequisite (§5); the residual is **not** computed. Per the
brief, this is a RED — recorded honestly, with the structural progress and
the prerequisite both stated precisely.

### 1.4 Stance

Default-skeptical, per the `mg-56b8` brief and the UC13 §4.5 / UC14 R2
history. This document does not paper over the gap with a shortcut. Where
Phase 1 advances the problem it says so and shows the step; where it does not
close it, it says so and isolates precisely what remains.

---

## §2 — Independent re-verification of the `mg-56b8` reduction

The brief says to build on `mg-56b8`, not redo it. We nonetheless re-checked
the load-bearing step independently, because the whole Phase-1 sharpening
rests on it.

### 2.1 The isotype-split cofiber LES and the bridge

The pair `(Xₙ∩, X_{n-1,x}∩)` has a `(ℤ/2)ⁿ`-equivariant cohomology LES;
Maschke splits it into Walsh isotypes (UC10.W). On the `χ_S`-summand
(`x ∉ S`):

> `⋯ → V_S^k(cofib ιₓ) --j*--> V_S^k(Xₙ∩) --ιₓ*--> V_S^k(X_{n-1,x}∩) --δ--> V_S^{k+1}(cofib ιₓ) → ⋯`

The twisted bridge (UC13 Theorem 4.3.1; the `χ_{x}`-conjugate of UC12
Construction~\ref{constr:bridge}) gives `ιₓ* = 0` on `V_S`-cohomology in
every degree `k ≥ 1`. This is **all** the bridge gives — the honest output,
fed into the LES, not misread as vanishing (the UC13 §4.5 error). Substituting
`ιₓ* = 0`: for `k ≥ 2`,

> `0 → V_S^{k-1}(X_{n-1,x}∩) --δ--> V_S^k(cofib ιₓ) --j*--> V_S^k(Xₙ∩) → 0` is exact.

For `|S| ≤ n-2` one may pick `x` with `S ⊊ [n]∖{x}` strictly, so
`V_S^{k-1}(X_{n-1,x}∩)` is a **lower** isotype of the size-`(n-1)` cube,
killed by the inductive hypothesis; (RED) follows. **Verified.** (The `k = 1`
edge case and the `S = ∅` degree-0 term are handled exactly as in `mg-56b8`
§3.2–§3.3.)

### 2.2 The matched-cylinder strip

`X_{n-1,x}∩ ⊆ X(𝒟ₓ) ⊆ Xₙ∩` with `X(𝒟ₓ) ≅ X_{n-1,x}∩ × Iₓ` a cylinder
(UC14 Lemma 2.3.1 + UC12 Lemma 2.7). The inner pair `(X(𝒟ₓ), X_{n-1,x}∩)` is
(cylinder, base), so `H̃^*(X(𝒟ₓ)/X_{n-1,x}∩) = 0`; the triple LES gives
`V_S^k(cofib ιₓ) ≅ V_S^k(Xₙ∩/X(𝒟ₓ))`. **Verified.**

### 2.3 Conclusion of §2

The reduction is sound. The named residual is

> **(Y1-RESIDUAL)** `V_S^k(Xₙ∩/X(𝒟ₓ)) = 0` for `k ≥ 1`, `S ⊊ [n]`,
> `|S| ≤ n-2`, some/any `x ∈ [n]∖S`;

and `mg-56b8` §6 shows the `|S| = n-1` case inherits it with the extra
sharpness constraint. Phase 1 takes (Y1-RESIDUAL) as its object.

---

## §3 — The residual as a pulled-back diagram; the comma categories pinned

### 3.1 The cofiber cochain complex, explicitly

Write `BK^{p,q}(Xₙ∩) = ⊕_{𝓕_0 → ⋯ → 𝓕_p}` `C^q(X(𝓕_p);ℚ)` for the
Bousfield–Kan double complex (UC14 §1.2), the sum over bar strings of `Cₙ∩`;
the value sits at the **last** object `𝓕_p`. `Cₙ∩` is a finite poset
(morphisms strictly decrease the ground set; at most one morphism between any
two objects), so the strings are strict chains and the sum is finite.

`X(𝒟ₓ)` is the sub-hocolim over the matched subcategory `𝒟ₓ ⊆ Cₙ∩`. The
cofiber double complex is the quotient:

> `BK^{p,q}(Xₙ∩/X(𝒟ₓ)) = ⊕_{strings with ≥1 object ∉ 𝒟ₓ} C^q(X(𝓕_p);ℚ)`.

Now take the `χ_S`-isotype, `x ∉ S`. By UC14 Lemma 2.2.1 (the cell-level
Walsh-support lemma — single-family, sound; `mg-56b8` §5.1 confirms it with
the whole-cell repair), `C^q(X(𝓕))_{χ_S}` is supported on the matched-in-`x`
cells, and equals `C^q(X(𝒟ₓ𝓕))_{χ_S} = C^q(X(ρₓ𝓕) × Iₓ)_{χ_S}`. The
`χ_S`-cochains of a cylinder `Y × Iₓ` (with `x ∉ S`, so `χ_S` is
`σ_x`-symmetric) are the base cochains: write

> `G_S(𝒢) := C^*(X(𝒢);ℚ)_{χ_S}` for `𝒢 ∈ C_{n-1,x}∩`.

Then `C^q(X(𝓕))_{χ_S} = G_S(ρₓ𝓕)` — the value depends only on the trace
`ρₓ𝓕`. Hence:

> **(3.1)** `BK^{p,q}(Xₙ∩/X(𝒟ₓ))_{χ_S} = ⊕_{strings exiting 𝒟ₓ} G_S(ρₓ𝓕_p)`.

This is a precise, correct description of the residual cochain complex. It is
the pullback `ρₓ^* G_S` of the value functor `G_S` along the trace functor
`ρₓ : Cₙ∩ → C_{n-1,x}∩`, restricted to the `𝒟ₓ`-exiting bar strings.

### 3.2 The comma categories of `ρₓ`

`mg-56b8` §4.3 identifies the residual with the **comma-category twist**
`N(ρₓ/−)` of the trace functor and calls the comma fibres the "stuck-family
fibres". We pin them.

The trace functor `ρₓ : Cₙ∩ → C_{n-1,x}∩` is a **retraction**: it is the
identity on the subcategory `C_{n-1,x}∩ ⊆ Cₙ∩` of `x∉support` families, and
on `x∈support` families it traces away `x`. Its restriction to the matched
subcategory `𝒟ₓ` is the inverse of the doubling iso `db_x` (UC14 Lemma 2.6.1;
UC12 Lemma 2.6). The hocolim is over `(Cₙ∩)^op`; the relevant comma fibre over
`(T,𝒢) ∈ C_{n-1,x}∩` is the family of objects of `Cₙ∩` related to `(T,𝒢)`
through `ρₓ` and the structure morphisms.

**A variance caution, recorded so it is not mis-used.** It is tempting to
argue the comma fibres are contractible because `(T,𝒢)` is a *terminal*
object of `{ (S,𝓕) ∈ Cₙ∩ : trace_T(𝓕) = 𝒢 }` (every such `𝓕` traces onto
`𝒢`). That argument is for the comma category of `ρₓ` **as a colimit over
`Cₙ∩`**. The hocolim defining `Xₙ∩` is over `(Cₙ∩)^op`, and the relevant
comma fibre is the **opposite-variance** one — the lifts of `𝒢` *across* the
`x`-trace, with the structure morphisms reversed. That fibre has **no** free
terminal object: there are in general many incomparable families on `T∪{x}`
whose `x`-trace is `𝒢`, and they are exactly the "stuck-family" choices. This
variance flip is the precise reason the residual is hard: trivial over
`Cₙ∩`, a genuine homotopy-type computation over `(Cₙ∩)^op`. (This corrects a
natural but wrong contractibility argument; it does not contradict `mg-56b8`,
which already states the fibres are non-contractible — `mg-56b8` §4.3, §5.3.)

The honest statement is therefore the one `mg-56b8` gives and we do not
improve here: `V_S^*(cofib)` is the **reduced** `G_S`-twisted cohomology of
the comma categories of `ρₓ`, and those comma categories are non-contractible
(witnessed concretely at `S = [n]∖{x}`, `mg-56b8` §5.2–§5.3).

### 3.3 What §3 fixes

The residual cochain complex (3.1) is `ρₓ^* G_S` on the `𝒟ₓ`-exiting bar
strings. The next section extracts the one genuinely new structural fact from
this presentation.

---

## §4 — The coefficient-blindness reformulation (the Phase-1 sharpening)

### 4.1 The `S`-independence of the diagram

Inspect (3.1). Two pieces of data assemble the residual cochain complex:

- **The diagram shape** — the set of bar strings of `Cₙ∩` that exit `𝒟ₓ`,
  the simplicial/bar differentials among them, and the trace functor `ρₓ`
  (equivalently, the comma categories of `ρₓ`).
- **The coefficient system** — the value functor `G_S = C^*(X(−);ℚ)_{χ_S}`
  on `C_{n-1,x}∩`.

**Observation 4.1 (`S`-independence of the diagram).** *The diagram shape is
independent of the Walsh index `S`. The bar strings, the subcategory `𝒟ₓ`,
the trace functor `ρₓ` and its comma categories are defined purely from `Cₙ∩`
and the choice of `x ∈ [n]∖S`; none of them refers to `S`. Only the
coefficient system `G_S` depends on `S`.*

This is immediate from the construction — `𝒟ₓ`, `ρₓ`, and "exiting `𝒟ₓ`" are
about the categorical/combinatorial structure, while `S` enters solely as the
Walsh character selecting the isotype `G_S = (−)_{χ_S}`. It is nonetheless not
recorded in `mg-56b8`, which treats `N(ρₓ/−)` and the value functor `G`
together as "the residual". Separating them is the Phase-1 sharpening.

### 4.2 Consequence: Y1's `|S|`-stratification is a coefficient phenomenon

The residual must behave very differently across `S`:

- for `|S| ≤ n-2` it must **vanish** (Y1 proper);
- for `|S| = n-1`, i.e. `S = [n]∖{x}`, it must carry **exactly** the sphere
  class — `V_{[n]∖{x}}^{n-2}(X(𝒟ₓ)) ≅ sgn_{S_{n-1}} ≠ 0` is genuine
  (`mg-56b8` §5.2, §6.2; the very class UC14 R3 §3.6 uses), and the residual
  must absorb it sharply so that `V_{[n]∖{x}}^{n-2}(Xₙ∩) = 0` still holds.

By Observation 4.1 this difference is **not** a difference in the homotopy
type of the stuck-family fibres — that homotopy type is **one fixed object**,
the same for every `S`. The difference is entirely in how the coefficient
systems `G_S` see it. Concretely:

> **Reformulation 4.2 (Y1 as coefficient-blindness).** Fix `x`. There is one
> fixed bar-construction-with-comma-twist — the `𝒟ₓ`-exiting diagram `𝔇ₓ` of
> `Cₙ∩` over `(Cₙ∩)^op` — whose reduced cohomology with coefficients in `G_S`
> is `V_S^*(cofib ιₓ) ≅ V_S^*(Xₙ∩)` (for `|S| ≤ n-2`). The top-of-the-
> smaller-cube system `G_{[n]∖x}` is **not blind** to `𝔇ₓ`: it sees the
> sphere class `sgn`. Y1 (`|S| ≤ n-2`) is exactly the assertion that **every
> lower-Walsh coefficient system `G_S`, `|S| ≤ n-2`, is blind to `𝔇ₓ`** — its
> reduced `G_S`-twisted cohomology vanishes. The `|S| = n-1` half of Y1 is
> the dual sharp statement: `G_{[n]∖x}` sees `𝔇ₓ` *only* in the one class
> `sgn`, in the one degree, and that class is exactly cancelled on the way up
> to `Xₙ∩`.*

### 4.3 Why this is progress, and why it is not a proof

This is progress: it tells a Phase-2/3 attacker **what kind of object** the
residual is. It is not "compute a homotopy type" (a single hard
computation); it is "show a fixed homotopy type is invisible to a specified
family of coefficient systems". That is a **representation-theoretic /
coefficient-spectral-sequence** question — one studies the
`G_S`-twisted cohomology of `𝔇ₓ` as `S` varies, and the load-bearing input is
the structure of `G_S` as a coefficient system (how the Walsh character `χ_S`
filters the cubical cochains of the trace families), not the bare nerve of the
comma categories. The `mg-56b8` §9.4 recommendation "compute the comma
categories and their nerves" is necessary but, by Observation 4.1,
*not sufficient by itself*: the nerves are `S`-independent, so they cannot
alone explain the `|S|`-stratification — the coefficient system must be
carried through.

It is **not** a proof. Reformulation 4.2 does not exhibit the blindness; it
isolates it as the precise content of Y1. Nothing here computes
`H̃^*(𝔇ₓ; G_S)`. The residual stands open.

### 4.4 The four free mechanisms remain closed

For completeness, re-confirming `mg-56b8` §4.4 against Reformulation 4.2:

- **Not degree truncation.** `𝔇ₓ` has cells through dimension `n`; Y1's
  range `1 ≤ k ≤ n-2` is the middle range. No dimension cap. Confirmed.
- **Not induction on `n`.** The inductive hypothesis `UC10.1(n-1)` controls
  the smaller cube and the cylinder; `𝔇ₓ` is indexed by `𝒟ₓ`-exiting bar
  strings of the size-`n` category and has no size-`(n-1)` model. Confirmed.
- **Not the bridge again.** The twisted bridge is fully spent producing
  `ιₓ* = 0` (§2.1); inside the cofiber it degenerates to a chain map, not a
  contraction (`mg-56b8` §4.4). Confirmed.
- **Not cofinality.** `ρₓ` homotopy-cofinal is logically equivalent to the
  false UC14 R2 (`mg-56b8` §5.3). And by Observation 4.1 cofinality is an
  `S`-independent statement, so it could not in any case produce the
  `|S|`-stratified answer Y1 needs — an independent confirmation that
  cofinality is the wrong tool. Confirmed.

The residual must be **computed**, as the `G_S`-twisted cohomology of `𝔇ₓ`.

---

## §5 — The foundational prerequisite: the Bousfield–Kan cell-level structure maps

### 5.1 What a computation needs and what the program supplies

To compute `V_S^*(cofib)` — by hand at `n = 3` (`mg-56b8` §9.4(b)
recommends `n = 3`, `S = {1}`, `k = 1` as the smallest open instance), or by
machine, or to formalise it in Phase 3 — one needs the Bousfield–Kan double
complex of `Cₙ∩` **at cell level**:

- (a) the single-family cubical cochain complex `C^*(X(𝓕))` — **supplied**
  precisely (UC10 Definition 3.1: `k`-cells `C(A,T)`, standard cubical
  coboundary);
- (b) the trace-induced structure map `X(𝓕|_T) → X(𝓕)` for each trace
  morphism — used as the restriction `C^q(X(𝓕)) → C^q(X(𝓕|_T))` in the bar
  differential `δ_BK`;
- (c) the single-family `σ_y`-action on `C^*(X(𝓕))` — used to split off the
  `χ_S`-isotype (UC10.W, UC14 Lemma 2.2.1).

Pieces (b) and (c) are **asserted but not pinned**.

- For (b): UC10 §3.3 states only "`X(𝓕|_T)` sits inside `X(𝓕)` because every
  subcube of `Q_T` inside `𝓕|_T` lifts to a subcube of `Q_S` inside `𝓕`."
  UC12 §3.3 (Lemma 3.3 proof) says "lift the bottom vertex along the trace".
  Neither gives the explicit, verified cell correspondence.
- For (c): UC10 §2.4 / §3.5 are explicit that `(ℤ/2)ⁿ` does **not** act on
  `Cₙ∩` (toggles break intersection-closure) — it acts only on the geometric
  carrier `Qₙ`. UC14 Lemma 2.2.1's proof gives a `σ_y`-action on a single
  `C^*(X(𝓕))` by "extension by zero" when the toggle leaves `𝓕`. That makes
  the single-family `σ_y^*` a **non-invertible** operator; the genuine
  `(ℤ/2)ⁿ`-action (needed for Maschke / the Walsh splitting) lives on the
  assembled total complex, and how the partial single-family operators
  assemble into a genuine action is exactly what UC10 §3.5 defers to "the
  technical verification is standard for diagrams over `G`-categories."

### 5.2 The prerequisite is pinnable — a canonical description

Neither gap is a defect of the *theory*; both are write-up debts, and both are
pinnable. For (b): for `A ∈ 𝓕|_T`, the set `{B ∈ 𝓕 : B ∩ T = A}` is closed
under intersection (if `B_1 ∩ T = B_2 ∩ T = A` then `(B_1∩B_2)∩T = A` and
`B_1∩B_2 ∈ 𝓕`), so it has a **minimum** `β(A) := ⋂{B ∈ 𝓕 : B ∩ T = A}`. The
canonical lift of a cell `C(A,T')` of `X(𝓕|_T)` is `C(β(A), T')`; the
trace-induced map is `C(A,T') ↦ C(β(A),T')`. This must be checked
well-defined (that `C(β(A),T')` is a genuine cell of `X(𝓕)` — i.e.
`β(A)∪T'' ∈ 𝓕` for all `T'' ⊆ T'` — and that the assignment is functorial in
`T`). For (c): the single-family `σ_y^*` with extension-by-zero must be shown
to assemble, across the hocolim diagram, into a genuine `(ℤ/2)ⁿ`-action on
the total complex whose isotypes are the `V_S^*` of UC10.W.

### 5.3 Why the prerequisite blocks Phase 1 and matters downstream

Phase 1 declined to compute the `n = 3` instance on **un-pinned** structure
maps. The reason is not difficulty — `n = 3` is finite — but **integrity of
the verdict**. A wrong cell-correspondence (b) or a wrong isotype split (c)
would silently produce a wrong cohomology. The two high-stakes outcomes of a
computation are a *refutation* of Y1 (which the brief notes "would mean the
Frankl cohomological route does not close") and a *confirmation* at `n = 3`.
Reporting either on un-pinned foundations would be precisely the
"paper-over-with-a-shortcut" failure mode the brief forbids — the UC13 §4.5 /
UC14 R2 history is that failure mode. An honest computation requires the
foundations pinned first.

This is also load-bearing for Phase 3 (Lean): a faithful formalisation of the
residual is impossible while (b) and (c) are informal. (It is consistent with
`mg-552b` §5's finding that the existing Lean `UC10_lowerWalshVanishing` is a
non-faithful placeholder — there is, today, no faithful Lean model of the
Bousfield–Kan complex of `Cₙ∩` to compute the residual in.)

---

## §6 — The honest cost estimate

`mg-56b8` §0.3 / §9.1 estimated the residual at "a substantial
homotopy-colimit computation, not a hypothesis-check ... plausibly
multi-week." Phase 1 confirms and slightly refines that estimate:

1. **Phase 1.5 — pin the Bousfield–Kan cell-level structure maps** (§5).
   Bounded and self-contained: write and verify the canonical-lift trace map
   (b) and the assembled `(ℤ/2)ⁿ`-action (c). Prerequisite for everything
   downstream. Estimate: one focused session.
2. **The `n = 3` instance** — `V_{1}^*(X_3∩)`, by hand or by machine, on the
   pinned foundations. Decisive for one instance (refute, or support). Not a
   proof of Y1. Estimate: one to two sessions once Phase 1.5 lands.
3. **The general residual** — `H̃^*(𝔇ₓ; G_S) = 0` for `|S| ≤ n-2`
   (Reformulation 4.2). This is the genuine multi-week research object. By §4
   it is a coefficient-system question (how `G_S` filters the cubical
   cochains of the trace families), not merely a nerve computation.

The Phase-1 sharpening does **not** shorten item 3; it re-describes it in a
form a future attacker can attack (coefficient-blindness over a fixed
diagram, rather than an unstructured "compute a hocolim").

---

## §7 — Verdict, recommendations, cross-references

### 7.1 Verdict

**RED — Y1-NOT-CLOSED (Phase 1).** The named residual `V_S^*(Xₙ∩/X(𝒟ₓ))` is
**not computed**. Phase 1 confirms the `mg-56b8` reduction, sharpens the
residual to a precise `S`-independent **coefficient-blindness** statement
(Reformulation 4.2), and identifies a **foundational prerequisite** (the
Bousfield–Kan cell-level structure maps, §5) that blocks any honest
computation or formalisation until pinned. No counterexample to Y1 is
produced; Y1 is **true-but-unproven**. Per the `mg-56b8` brief, a RED of this
shape — residual genuinely not computed in the phase — is a valid and
recorded outcome, not a failed ticket.

### 7.2 What Phase 1 delivered (positive content)

1. Independent re-verification of the `mg-56b8` cofiber-LES reduction (§2).
2. The explicit cofiber cochain complex (3.1): `ρₓ^* G_S` on the
   `𝒟ₓ`-exiting bar strings.
3. The variance caution (§3.2): the residual is hard precisely because the
   comma fibre is trivial over `Cₙ∩` but a genuine homotopy type over
   `(Cₙ∩)^op` — recorded so the wrong "terminal object" contractibility
   argument is not made.
4. **Observation 4.1 + Reformulation 4.2** — the genuine new structural
   content: the residual diagram is `S`-independent; Y1's `|S|`-stratification
   is a coefficient-blindness phenomenon over one fixed diagram, not a
   homotopy-type phenomenon.
5. **§5** — the identification of the un-pinned Bousfield–Kan cell-level
   structure maps as a bounded, load-bearing prerequisite (Phase 1.5).
6. The integrated LaTeX update to the `mg-335b` paper (`06-residual.tex`,
   `05-proof-state.tex`).

### 7.3 Recommendations (routed to Daniel via `pm-onethird`)

1. **Record Y1 as `RED — open` still**, now with the residual sharpened to
   Reformulation 4.2. No status upgrade; no status downgrade.
2. **File Phase 1.5 before Phase 2.** Pinning the Bousfield–Kan cell-level
   structure maps (§5) is a bounded prerequisite and is upstream of the
   computation, the independent validation (Phase 2), and the Lean
   formalisation (Phase 3). Phase 2 cannot validate a computation that cannot
   yet be honestly performed.
3. **Re-scope Phase 2/3 around Reformulation 4.2.** The residual is a
   coefficient-blindness question over a fixed diagram. An attacker should
   study the coefficient systems `G_S` (the Walsh filtration of the cubical
   cochains of the trace families) as `S` varies — not the bare nerves of the
   comma categories, which are `S`-independent and so cannot alone yield the
   stratified answer.
4. **Do not Lean-formalise Y1 yet** — unchanged from `mg-56b8` §9.3(3); and
   §5.3 above adds that there is no faithful Lean Bousfield–Kan model to
   formalise the residual in until Phase 1.5 lands.
5. **The Zulip post stays held.** The cohomological half of the Frankl proof
   has one mechanism-sound part (`Y2`) and one part (`Y1`) validly reduced,
   now sharpened, but not closed.

### 7.4 Cross-references

- **Brief:** `mg-59d3`. **Built on:** `mg-56b8`
  (`docs/Frankl-Y1-reprove.md`, the cofiber-LES reduction — sound).
- **Audit upstream:** `mg-552b`
  (`docs/Frankl-Y1-walsh-vanishing-audit.md`, Y1-HIGH-RISK).
- **`Y2` counterpart:** `mg-aeee`
  (`docs/Frankl-Y2-obstruction-isotype-landing.md`, Y2-SUPPORTED).
- **Paper:** `paper/main.tex` and `paper/sections/` — the `mg-335b`
  consolidation. Phase 1 refines `05-proof-state.tex` (Open
  residual~`res:y1`, Theorem~`thm:y1-reduction`) and `06-residual.tex`
  (`ssec:two-residuals`, `ssec:next-steps`) in LaTeX.
- **Foundational sources:** UC10 §3 (the Bousfield–Kan model, §3.3 the
  trace map, §3.5 the `(ℤ/2)ⁿ`-action), UC12 §2–§3 (the doubling functor,
  the prism, the cell-level "lift the bottom vertex"), UC14 §2.2–§2.6
  (Lemma 2.2.1 cell-level Walsh support, Lemma 2.6.1 the retraction).

---

*Phase-1 attempt by polecat `cat-mg-59d3`. Deliverable on `main`: this
document + the LaTeX refinement of the `mg-335b` paper's residual section.
Verdict: **RED — Y1-NOT-CLOSED (Phase 1).** The named residual is sharpened
to a precise `S`-independent coefficient-blindness statement and shown to be
blocked, for honest computation, on one bounded foundational prerequisite (the
Bousfield–Kan cell-level structure maps). Y1 remains true-but-unproven; the
residual is not computed; per the brief, a RED of this shape is a valid and
important outcome. Recommended next: Phase 1.5 (pin the foundations), then the
`n = 3` instance, then the general coefficient-blindness computation.*
