# Frankl-Y1-Reprove — re-derivation attempt of the level-1 Walsh vanishing (Y1) by cofiber-LES + induction

**Work item:** `mg-56b8` (re-prove Y1 by the correct method; re-band UC14). Step 1
of the Daniel 2026-05-20 directive ("real honest formalization of our Frankl
proof") — Y1 cannot be honestly formalized until it has a valid proof, and the
`mg-552b` audit (`docs/Frankl-Y1-walsh-vanishing-audit.md`) found the current
one broken.

**Trigger.** `mg-552b` returned **Y1-HIGH-RISK**: UC13 §4.5 (the proof of Y1)
is logically invalid as written (it conflates exactness of the *trace* with
vanishing of the *cohomology*), and the UC14 R2 "tightening" cited as closing
that gap is **provably false**. The audit recommended re-proving Y1 by the
cofiber-LES + induction method UC14 R3 used correctly for the sibling
top-Walsh concentration. This document is that attempt.

---

## §0 — Verdict (top of page)

### 0.1 Headline: **RED — Y1-NOT-REPROVEN.** The cofiber-LES + induction method, executed honestly, **reduces** Y1 to a single precisely-isolated residual — a homotopy-colimit-of-a-pair computation — that this session does **not** discharge and that has no free vanishing. Y1 remains true-but-unproven.

This is **not** a refutation of Y1. The statement `V_S^k(Xₙ∩) = 0`
(`S ⊊ [n]`, `k ≥ 1`) is still plausibly true — it is UC10.1 content. What this
document establishes is sharper and more useful than the `mg-552b` audit's
"achievable but absent":

1. **The honest part of the method works.** The cofiber long-exact sequence
   for `ιₓ : X_{n-1,x}∩ ↪ Xₙ∩`, combined with the twisted-bridge
   chain-homotopy identity (UC13 Theorem 4.3.1, which gives `ιₓ* ≃ 0` on the
   `χ_S`-isotype — *not* `V_S^k = 0`), validly reduces Y1 to a short exact
   sequence (§3). The reduction is correct; it does not route through UC14 R2
   and it does not commit the trace-exactness error.

2. **The reduction terminates at a genuine residual.** The SES expresses
   `V_S^k(Xₙ∩)` as a quotient of `V_S^k(cofib ιₓ)` — the `χ_S`-isotype
   cohomology of the **cofiber** `Xₙ∩ / X_{n-1,x}∩`. That cofiber cohomology
   is, after stripping the matched cylinder, a **hocolim-of-a-pair** indexed
   by the bar strings of `Cₙ∩` that *exit* the matched subcategory `𝒟ₓ`
   (§4). It is not zero for any free reason, and it is exactly the
   stuck-family obstruction the program has never computed.

3. **Both tempting shortcuts past that residual are false — by one mechanism.**
   UC14 R2's chain-isomorphism and the naïve "relative cochains vanish
   family-by-family" argument **both** collapse the residual to zero, and
   **both** are wrong for the *same* reason: a hocolim sums over bar strings
   through *all* of `Cₙ∩`, so a per-object identification on the subcategory
   `𝒟ₓ` does not localize. §5 makes this concrete at `n = 3` and shows the
   naïve relative-vanishing reproduces R2's false `sgn ≅ 0` exactly.

### 0.2 The precise verdict

> **RED — Y1-NOT-REPROVEN (residual isolated).** Y1 (level-1 / lower Walsh
> vanishing) is **not** reproven in this session. The cofiber-LES + induction
> method is set up correctly and validly reduces Y1, for `|S| ≤ n-2`, to the
> vanishing of `V_S^k(cofib ιₓ)` — equivalently the `χ_S`-isotype cohomology
> of the homotopy cofiber of the matched-cylinder inclusion
> `X(𝒟ₓ) ↪ Xₙ∩`, a hocolim indexed by `𝒟ₓ`-exiting bar strings. That
> residual is **not discharged here** and admits no degree/dimension
> truncation, no inductive kill, and no cofinality collapse (cofinality of
> `ρₓ` would itself reproduce UC14 R2's false conclusion — §5.3). The
> `|S| = n-1` sub-case additionally collides with the genuine sphere class
> `V_{[n-1]}^{n-2}(X_{n-1}∩) ≅ sgn` and needs a strictly separate argument
> (§6). **Y1 is true-but-unproven; the method's hard core is now named and
> localized but open.**

### 0.3 What this changes for the project record

- **UC14 R2 is FALSE and is re-banded here.** §7 + the correction banner added
  to `docs/union-closed-UC14-uc13-technical-cleanup.md`. The `mg-552b` audit
  established this; this document confirms it independently (the naïve
  relative-vanishing argument, which is the *honest* shadow of R2, reproduces
  R2's `sgn ≅ 0` — §5.2) and records the corrected status.

- **UC13 §4.5 stays INVALID; UC13 §4 stays UNPROVEN.** No change to `mg-552b`'s
  finding. This document does not rescue it.

- **The `mg-552b` "achievable" estimate is sharpened.** The audit called a
  correct proof "bounded work on a plausibly true statement." This document
  shows the bound is *not* small: the residual is a homotopy-colimit-of-a-pair
  / comma-category computation (§4.3), the genuine stuck-family core of the
  Frankl homological program. It is not a one-session closure and not a
  "verify a hypothesis" residual.

### 0.4 Net effect on the Frankl two-part contradiction

Unchanged from `mg-552b` and *sharpened*. The contradiction is
`Y1 ∧ Y2 ⟹ ob(F⋆) = 0`. `Y2` is mechanism-sound (`mg-aeee`). `Y1` is
**still not validly proven** — the broken UC13 §4.5 is not replaced by a valid
argument here; it is replaced by a *correct reduction to a named open
residual*. The homological half of the paper proof remains unproven, fully
consistent with `Frankl_Holds`'s standing dependence on
`case3_ss_obstruction_paper_axiom`.

---

## §1 — Scope, method, and what "cofiber-LES + induction" means here

### 1.1 The target

> **Y1 (lower / level-1 Walsh vanishing).** For the cubical-Walsh-defect
> complex `Xₙ∩` (`n ≥ 3`): `V_S^k(Xₙ∩) = 0` for every `S ⊊ [n]` and every
> `k ≥ 1`. In particular `V_{x}^{n-1}(Xₙ∩) = 0` for every `x ∈ [n]` (the
> level-1 isotypes that carry `ob(F⋆)` by UC13 Theorem 2.4.1 / Y2).

`V_S^k` is the multiplicity complex of the Walsh character `χ_S` in the
`(ℤ/2)ⁿ`-equivariant Walsh decomposition `C*(Xₙ∩;ℚ) = ⊕_S χ_S ⊗ V_S^*`
(UC10.W = UC10 Theorem 3.5). The differential is `(ℤ/2)ⁿ`-equivariant, so the
decomposition is at the level of chain complexes and every `V_S^*` is a
genuine sub-cochain-complex.

### 1.2 The method, stated honestly

The instruction is to port the method UC14 **R3** used for the sibling
top-Walsh concentration `V_{[n]}^k = 0` (`k < n-1`): a **cofiber long-exact
sequence** for a cube-shrinking inclusion, plus **induction on `n`**. The two
ingredients, and the one thing the method does *not* do:

- **Ingredient A — the cofiber LES.** For the inclusion of a smaller cube
  `ιₓ : X_{n-1,x}∩ ↪ Xₙ∩`, the pair `(Xₙ∩, X_{n-1,x}∩)` has a long exact
  sequence in cohomology. Because every map in sight is `(ℤ/2)ⁿ`-equivariant
  and `(ℤ/2)ⁿ` is finite (Maschke), the LES **splits into Walsh isotypes** —
  there is a LES of the `V_S^*` pieces alone. This is rigorous and is used in
  §3.

- **Ingredient B — induction on `n`.** Y1 at `n` is reduced to facts about
  `X_{n-1,x}∩` (ground set `[n]∖{x}`, size `n-1`); those are supplied by the
  inductive hypothesis. Because the proof of the *sibling* (top-Walsh, R3)
  consumes Y1 at smaller cubes and vice-versa, the honest inductive object is
  the **whole of UC10.1** — `Y1(n) ∧ TW(n)` — proven simultaneously
  (§2.1). This is a correction to the UC13/UC14 presentation, which proved §4
  (Y1) and §5 (TW) as if independent.

- **What the method does NOT do — the trace-exactness non-step.** The
  twisted-bridge chain-homotopy identity (UC13 Theorem 4.3.1) says the trace
  map `ιₓ*` is **null-homotopic on the `χ_S`-isotype**, hence induces the
  **zero map** on `V_S^*`-cohomology. UC13 §4.5's error was to read "`ιₓ* = 0`
  on cohomology" as "`V_S^k = 0`." It is not: a zero map out of a group says
  nothing about that group. The honest use of `ιₓ* ≃ 0` is to feed it *into
  the LES* — where it makes the LES degenerate into short exact sequences
  (§3.2) — not to conclude vanishing directly. This document never takes the
  §4.5 non-step.

### 1.3 The dependency on UC14: what is reused and what is discarded

- **Reused — UC14 R2 §2.2 Lemma 2.2.1 (cell-level `χ_S`-support), single
  family.** For `(T,𝓕) ∈ Cₙ∩` with `x ∈ T`, `x ∉ S`, the `χ_S`-isotype of
  `C*(X(𝓕))` is supported on cells `C(A,T')` with `x ∉ T'` and `A`
  matched-in-`x`. `mg-552b §3.3` judged this "plausibly correct" with one
  repairable imprecision (it must constrain the whole cell, not just the base
  vertex `A`); §5.1 below records the repair. This is a **single-family**,
  cell-level fact and is sound.

- **Discarded — UC14 R2 §2.6 Theorem 2.6.2 (the hocolim lift) and §2.7
  Theorem 2.7.1 (the chain isomorphism).** These claim the single-family
  identification lifts to a chain isomorphism
  `C*(Xₙ∩)_{χ_S} = C*(X(𝒟ₓ))_{χ_S}` of *hocolims*. That is **false**
  (`mg-552b §3`; re-confirmed §5.2 here). This document does not use them; the
  re-band in §7 records them as false.

- **Reused — UC14 R3's cofiber-LES + induction *method* and its top-Walsh
  output `TW`.** R3's degree-count for `V_{[n]}^k = 0` (`k < n-1`) is the
  sibling and is taken as the inductive partner; §2.1 notes R3 carries its own
  `mg-552b`-flagged soft spots (§3.6 is loose) but the present document does
  not re-audit R3 — it is scoped to Y1.

### 1.4 Stance

Default-skeptical, per the `mg-56b8` brief ("probe genuinely; do not paper
over with another shortcut"). Where the method closes a step, this document
says so and shows the step. Where it does not, it says so and isolates the
residual precisely rather than hedging. The brief explicitly sanctions a RED
verdict; §0 is that verdict.

---

## §2 — The inductive frame

### 2.1 Simultaneous induction on `n` — the honest object

Define, for `n ≥ 2`:

- **`Y1(n)`** — `V_S^k(Xₙ∩) = 0` for every `S ⊊ [n]`, `k ≥ 1`.
- **`TW(n)`** — `V_{[n]}^k(Xₙ∩) = 0` for `1 ≤ k ≤ n-2`, and
  `V_{[n]}^{n-1}(Xₙ∩) ≅ sgn_{Sₙ}` (one-dimensional).
- **`UC10.1(n)` := `Y1(n) ∧ TW(n)`.**

The cofiber-LES proof of `Y1(n)` will reach, on the smaller cube `X_{n-1,x}∩`,
*both* lower isotypes `V_S` with `S ⊊ [n-1]` (needs `Y1(n-1)`) *and* — in the
sub-case `|S| = n-1` — the top isotype `V_{[n-1]}` (needs `TW(n-1)`).
Symmetrically, R3's proof of `TW(n)` reaches `Y1` and `TW` at smaller cubes.
The two halves are not separable. **The correct inductive statement is
`UC10.1(n)`, proved from `UC10.1(m)` for all `2 ≤ m < n`.** UC13 (§4 then §5)
and UC14 (R2 then R3) both present them as independent; that presentation is
not faithful to the dependency graph and is recorded here as a structural
correction. It is independent of — and prior to — the R2 falsity.

This document discharges the **`Y1(n)` half** of the inductive step as far as
the method allows, takes the **`TW` half** from UC14 R3 as the inductive
partner (R3 is scoped out of this ticket; see §1.3 and the soft-spot note in
§8.4), and reports precisely where the `Y1(n)` half stops.

### 2.2 Base case

`n = 2`: `Y1(2)` asks `V_S^k(X_2∩) = 0` for `S ⊊ [2]` (`|S| ≤ 1`), `k ≥ 1`.
The cube `Q_2` is 2-dimensional; `X_2∩` is a finite `Γ_2`-equivariant complex
over the small category `C_2∩` and its Walsh pieces `V_∅^*`, `V_{1}^*`,
`V_{2}^*` are directly computable (finitely many families on a 2-element
ground set). `TW(2)` is vacuous in the vanishing range (`1 ≤ k ≤ 0` empty) and
`V_{[2]}^1 ≅ sgn_{S_2}` is UC10.R / UC12 Theorem 4.4 at `n = 2`. The base case
is a finite check and is **not** the obstruction; it is granted here as
standard (it is the same finite verification UC10/UC12 already rely on for the
`n = 2` sphere class). The obstruction is entirely in the inductive step.

### 2.3 Isotype bookkeeping for the cube-shrinking inclusion

Fix `n`, `S ⊊ [n]`, and `x ∈ [n]∖S`. The inclusion of indexing categories
`C_{n-1,x}∩ ↪ Cₙ∩` (families whose ground set avoids `x`) induces a
`(ℤ/2)ⁿ`-equivariant cofibration of complexes

```
   ιₓ : X_{n-1,x}∩  ↪  Xₙ∩.
```

The `(ℤ/2)ⁿ`-action on `X_{n-1,x}∩` factors through `(ℤ/2)^{[n]∖{x}}` (the
`σₓ` toggle acts trivially — there is no `x`-coordinate). Hence:

> **Bookkeeping fact.** For `x ∉ S`, the character `χ_S` restricted along `ιₓ`
> stays `χ_S` (it never involved `x`), and the relevant isotype on the smaller
> cube is `V_S(X_{n-1,x}∩)` with the **same index `S`**.

This is the structural advantage of the *lower*-Walsh case over the
top-Walsh case. In R3's top-Walsh argument `S = [n]` involves `x`, so
restriction drops `x` and lands in `V_{[n]∖{x}}` — a *different* index, and
the top index of the smaller cube (the sphere class). For Y1 with `x ∉ S` the
index is preserved, and `S` is a subset of the smaller ground set `[n]∖{x}`:

- if `|S| ≤ n-2` we may pick `x` so that `S ⊊ [n]∖{x}` strictly — the smaller
  term is a *lower* isotype, killed by `Y1(n-1)` (§3);
- if `|S| = n-1` then `[n]∖S = {x}` is forced and `S = [n]∖{x}` is the *top*
  index of the smaller cube — the smaller term is the **sphere class** `sgn`,
  not zero (§6).

The split `|S| ≤ n-2` vs `|S| = n-1` is forced by this bookkeeping and is not
an artifact of the write-up.

---

## §3 — The valid reduction (the part of the method that works)

Fix `n`, `S ⊊ [n]` with `|S| ≤ n-2`, `k ≥ 1`, and choose `x ∈ [n]∖S` (so
`S ⊊ [n]∖{x}` strictly). Assume the inductive hypothesis `UC10.1(m)` for all
`m < n`.

### 3.1 The isotype-split cofiber LES

The pair `(Xₙ∩, X_{n-1,x}∩)` has the cohomology long exact sequence

```
  ⋯ → H^k(Xₙ∩, X_{n-1,x}∩) → H^k(Xₙ∩) --ιₓ*--> H^k(X_{n-1,x}∩) --δ--> H^{k+1}(Xₙ∩, X_{n-1,x}∩) → ⋯
```

with `H^k(Xₙ∩, X_{n-1,x}∩) = H̃^k(cofib ιₓ)`, `cofib ιₓ = Xₙ∩/X_{n-1,x}∩`.
Every object and every map is `(ℤ/2)ⁿ`-equivariant; `(ℤ/2)ⁿ` is finite, so by
Maschke each term splits as a direct sum over Walsh characters and the LES
restricts to each summand. Taking the `χ_S`-summand:

> **(LES-S)** `⋯ → V_S^k(cofib ιₓ) --j*--> V_S^k(Xₙ∩) --ιₓ*--> V_S^k(X_{n-1,x}∩) --δ--> V_S^{k+1}(cofib ιₓ) → ⋯`

This is rigorous: it is the LES of a pair, projected to one isotype of a
finite-group action. No UC14 R2, no chain isomorphism.

### 3.2 The bridge degenerates (LES-S) into a short exact sequence

UC13 Theorem 4.3.1 (the twisted-bridge chain-homotopy identity — see §8.1 for
its own residual soft spots, none of which is the present obstruction)
provides, on the `χ_S`-isotype with `x ∉ S`, a degree `−1` operator
`hₓ^{tw}` with

```
   ιₓ^{𝒟*} ω  =  ±½ (d hₓ^{tw} − hₓ^{tw} d) ω        (k ≥ 1).
```

The honest content: **`ιₓ*` is null-homotopic on `V_S^*`, hence induces the
zero map `ιₓ* = 0 : V_S^k(Xₙ∩) → V_S^k(X_{n-1,x}∩)` on cohomology in every
degree `k ≥ 1`.** (This is *all* the bridge gives. UC13 §4.5 then illegally
concluded `V_S^k = 0`; we do not.) Substituting `ιₓ* = 0` into (LES-S):

> **(SES-S)** for `k ≥ 2`: `0 → V_S^{k-1}(X_{n-1,x}∩) --δ--> V_S^k(cofib ιₓ) --j*--> V_S^k(Xₙ∩) → 0` is short exact.

*Derivation (`k ≥ 2`).* `ιₓ* = 0` at degree `k` makes `j*` surjective (its
cokernel injects via `ιₓ*` into the smaller cube, which is `0`); `ιₓ* = 0` at
degree `k-1 ≥ 1` makes `δ` injective and `im δ = ker j*`. ∎

*Edge case `k = 1`.* The bridge identity (UC13 Theorem 4.3.1) is stated for
`k ≥ 1`, so `ιₓ* = 0` holds at degree `1` but not necessarily at degree `0`;
(SES-S) need not be left-exact at `k = 1`. What survives is still enough: from
(LES-S), `ιₓ* = 0` at degree `1` gives `j* : V_S^1(cofib ιₓ) ↠ V_S^1(Xₙ∩)`
surjective with kernel `im(δ : V_S^0(X_{n-1,x}∩) → V_S^1(cofib ιₓ))`. §3.3
shows `V_S^0(X_{n-1,x}∩) = 0`, so that kernel is `0` and `j*` is an
isomorphism at `k = 1` as well. The reduction (RED) below therefore holds for
all `k ≥ 1`.

### 3.3 The smaller-cube term vanishes by induction

`V_S^{k-1}(X_{n-1,x}∩)`: the ground set of `X_{n-1,x}∩` is `[n]∖{x}` of size
`n-1`, and `S ⊊ [n]∖{x}` strictly (this is the `|S| ≤ n-2` case). For
`k - 1 ≥ 1` this is exactly `Y1(n-1)` at the proper subset `S`, so it is `0` by
the inductive hypothesis. For `k = 1` the term is `V_S^0(X_{n-1,x}∩)` — degree
`0`, *outside* the `k ≥ 1` range of Y1; it is the reduced degree-0 cohomology
of the smaller cube's `χ_S`-isotype. For `S ≠ ∅` this is `0` (the augmentation
/ connectedness statement, UC10.W at degree 0 — `χ_S`-isotype with `S ≠ ∅` has
no degree-0 cohomology because the constants sit in `χ_∅`); for `S = ∅`,
`V_∅^*` is the trivial-isotype part and `V_∅^0` is handled by the standard
reduced-cohomology convention. Either way **`V_S^{k-1}(X_{n-1,x}∩) = 0` for
all `k ≥ 1`** in the `|S| ≤ n-2` case.

### 3.4 The reduction, stated

With the smaller-cube term `0`, (SES-S) collapses to an **isomorphism**

> **(RED)** `j* : V_S^k(cofib ιₓ) --≅--> V_S^k(Xₙ∩)` for every `k ≥ 1`,
> `S ⊊ [n]` with `|S| ≤ n-2`, `x ∈ [n]∖S`.

**This is the entire honest output of the cofiber-LES + induction method for
Y1.** It is correct, it does not use R2, it does not commit the §4.5 error. It
says: *`Y1(n)` for `|S| ≤ n-2` holds if and only if the cofiber `Xₙ∩/X_{n-1,x}∩`
has vanishing `χ_S`-isotype cohomology in every degree `k ≥ 1`.*

Y1 is thus **reduced**, validly, to:

> **(Y1-RESIDUAL)** `V_S^k(cofib ιₓ) = 0` for `k ≥ 1`, `S ⊊ [n]`,
> `|S| ≤ n-2`, some/any `x ∈ [n]∖S`.

§4 shows (Y1-RESIDUAL) is a genuine open computation; §5 shows the two
shortcuts past it are false; §6 handles `|S| = n-1`.

---

## §4 — The residual (Y1-RESIDUAL): why the cofiber term is a genuine open computation

This section shows (Y1-RESIDUAL) — `V_S^k(cofib ιₓ) = 0` — is not closeable by
any free mechanism: not degree truncation, not the inductive hypothesis, not
the bridge again. It is a homotopy-colimit-of-a-pair computation, the genuine
stuck-family core of the program.

### 4.1 Stripping the matched cylinder

Insert the matched-in-`x` subcategory `𝒟ₓ` between the smaller cube and the
whole: `X_{n-1,x}∩ ⊆ X(𝒟ₓ) ⊆ Xₙ∩`, where `X(𝒟ₓ)` is the hocolim over the
fully-matched-in-`x` subcategory `𝒟ₓ = db_x(C_{n-1,x}∩)`. By UC14 Lemma 2.3.1
+ UC12 Lemma 2.7, `X(𝒟ₓ) ≅ X_{n-1,x}∩ × Iₓ` is a **cylinder** over the
smaller cube; the bottom face `X_{n-1,x}∩ × {0}` is the image of `ιₓ`.

The triple `X_{n-1,x}∩ ⊆ X(𝒟ₓ) ⊆ Xₙ∩` gives a LES of the pair-quotients. The
inner pair `(X(𝒟ₓ), X_{n-1,x}∩)` is (cylinder, base): the cylinder
deformation-retracts onto the base, so `H̃^*(X(𝒟ₓ)/X_{n-1,x}∩) = 0` in every
degree. The triple LES then yields a canonical isomorphism

> **(STRIP)** `V_S^k(cofib ιₓ) = V_S^k(Xₙ∩/X_{n-1,x}∩) ≅ V_S^k(Xₙ∩/X(𝒟ₓ))`.

So (Y1-RESIDUAL) is equivalent to `V_S^k(Xₙ∩/X(𝒟ₓ)) = 0` for `k ≥ 1` — the
`χ_S`-cohomology of the cofiber of the **matched-cylinder inclusion**
`X(𝒟ₓ) ↪ Xₙ∩`.

### 4.2 The cofiber `Xₙ∩/X(𝒟ₓ)` does not vanish family-by-family

It is tempting — and it is exactly UC14 R2's mistake in disguise — to argue:
"by UC14 Lemma 2.2.1, the `χ_S`-isotype (with `x ∉ S`) of any single family's
cochains is supported on matched-in-`x` cells; the relative complex
`Xₙ∩/X(𝒟ₓ)` is built from *non-matched* cells; so its `χ_S`-isotype is `0`."

**This is wrong, and the error is structural, not a slip.** `Xₙ∩` is a
**hocolim** — its Bousfield–Kan cochain bicomplex is

```
   BK^{p,q}(Xₙ∩) = ∏_{ 𝓕₀→𝓕₁→⋯→𝓕_p  in Cₙ∩ }  C^q(X(𝓕_p);ℚ),
```

a product over **bar strings of the whole category `Cₙ∩`**. The sub-hocolim
`X(𝒟ₓ)` is the BK bicomplex restricted to bar strings *all of whose objects
lie in the subcategory `𝒟ₓ`*. Therefore the relative (cofiber) bicomplex
`BK^{*,*}(Xₙ∩) / BK^{*,*}(X(𝒟ₓ))` is the product over bar strings with **at
least one object outside `𝒟ₓ`** — and at such a string the relative term is
the **entire** `C^q(X(𝓕_p))`, *not* a within-family relative group.

Its `χ_S`-isotype is `C^q(X(𝓕_p))_{χ_S}`, which by Lemma 2.2.1 equals
`C^q(X(𝒟ₓ𝓕_p))_{χ_S}` — the matched cochains of the *last* family — and that
is **generically non-zero**. The non-matched ("stuck-in-`x`") families enter
the cofiber not through their own cells but through *bar strings that pass
through them*, carrying the matched cochains of neighbouring families along.

So `V_S^*(Xₙ∩/X(𝒟ₓ))` is the cohomology of a genuinely non-zero bicomplex:
the BK bicomplex of `Cₙ∩` indexed by `𝒟ₓ`-exiting bar strings, with the
matched-`χ_S` value functor. **Family-by-family vanishing does not survive the
hocolim.** This is the precise sense in which R2's hocolim lift (Theorem
2.6.2) is false (§5.2).

### 4.3 What the residual actually is — a hocolim-of-a-pair / comma-category computation

By UC14 Lemma 2.6.1 the matched-functor `𝒟ₓ = db_x ρₓ` is a categorical
**retraction** of `Cₙ∩|_{x∈supp}` onto `𝒟ₓ` (`r ∘ i = id`, with `r = 𝒟ₓ(−)`,
`i` the inclusion). The `χ_S`-value functor `𝓕 ↦ C^*(X(𝓕))_{χ_S}` factors
through the trace `ρₓ` to `[n]∖{x}` (Lemma 2.2.1 + the prism structure):

```
   V_S^*(Xₙ∩) = ℍ^*( hocolim_{(Cₙ∩)ᵒᵖ}  ρₓ^* G ),   G := C^*(X(−)×Iₓ)_{χ_S} on C_{n-1,x}∩.
```

`V_S^*(Xₙ∩)` is therefore the hypercohomology of a functor **pulled back along
`ρₓ`**. The standard homotopy-colimit pullback formula expresses it as a
hocolim over the *smaller* category twisted by the **nerves of the comma
categories** of `ρₓ`:

```
   V_S^*(Xₙ∩)  ≅  ℍ^*( hocolim_{C_{n-1,x}∩}  ( G ⊗ N(ρₓ / −) ) ).
```

- If every comma category `ρₓ/(T,𝓖)` had a **contractible nerve**, `ρₓ` would
  be homotopy-cofinal, the twist `N(ρₓ/−)` would disappear, and we would get
  `V_S^*(Xₙ∩) ≅ V_S^*(X_{n-1,x}∩×Iₓ) ≅ V_S^*(X_{n-1,x}∩)` — **exactly UC14
  R2's claimed isomorphism.** R2 is therefore equivalent to the assertion that
  `ρₓ` is homotopy-cofinal.
- `ρₓ` is **not** homotopy-cofinal: §5.2 / §6 exhibit `S = [n]∖{x}` where R2's
  conclusion is `sgn ≅ 0`, false. So the comma nerves `N(ρₓ/−)` are **not**
  contractible, and the residual `V_S^k(cofib ιₓ)` is precisely the
  **reduced** contribution of those non-contractible comma nerves — the
  cohomology measuring how far the stuck families obstruct cofinality.

This is the genuine mathematical content of Y1. It is a real homotopy-colimit
computation over the comma categories of the trace functor — the homotopy type
of the "stuck-family poset fibres." The program has a name for the underlying
combinatorics (UC10.S, the stuck-set correspondence) but **has never computed
the homotopy type of these fibres.** That computation is (Y1-RESIDUAL), and it
is not discharged here.

### 4.4 Why the residual is not closeable by the free mechanisms

- **Not by degree/dimension truncation.** R3 closed the *top*-Walsh sibling
  partly by a cube-dimension cap (`V_{[n]}^k` for `k ≥ n` is zero by
  dimension; the top class sits at `n-1`). Y1's range is `1 ≤ k ≤ n-2` —
  squarely in the middle; no dimension cap touches it. The cofiber
  `Xₙ∩/X(𝒟ₓ)` has cells up to dimension `n` and no degree where `V_S^k` is
  free.
- **Not by the inductive hypothesis on `n`.** `UC10.1(n-1)` controls the
  *smaller cube* `X_{n-1,x}∩` (used in §3.3) and the *cylinder* `X(𝒟ₓ)`. It
  does **not** control the cofiber `Xₙ∩/X(𝒟ₓ)`: the cofiber is indexed by
  `𝒟ₓ`-exiting bar strings of the size-`n` category `Cₙ∩`, with no model as
  a size-`(n-1)` cube. There is no smaller-`n` object for the IH to bite on.
- **Not by the bridge again.** The twisted bridge already gave `ιₓ* ≃ 0`; that
  is fully used in §3.2 to get (SES-S). Re-applying it inside the cofiber
  yields `ιₓ^{𝒟*} = 0` *as a map out of the cofiber* (the cofiber kills
  `X_{n-1,x}∩`), so the chain-homotopy identity reads `d hₓ^{tw} = hₓ^{tw} d`
  there — `hₓ^{tw}` becomes a chain map, **not** a contracting homotopy. A
  contraction would need `d h + h d = id`; the bridge gives `d h − h d =
  ±2 ιₓ^{𝒟*}`, and `ιₓ^{𝒟*}` is not `±½ id`. The bridge cannot contract the
  cofiber.
- **Not by cofinality.** §5.3: assuming `ρₓ` cofinal *is* assuming R2, false.

The residual stands. Y1 is reduced but not closed.

---

## §5 — Why the two shortcuts past the residual are false (concrete at `n = 3`)

There are exactly two tempting ways to collapse (Y1-RESIDUAL) to zero. Both are
false, and — the useful diagnostic — both fail by the *same* mechanism, the one
named in §4.2: a hocolim does not localize to a subcategory.

### 5.1 First, the repair of UC14 Lemma 2.2.1 (so the shortcuts are stated on solid ground)

`mg-552b §3.3` flagged that UC14 Lemma 2.2.1 as written constrains only the
base vertex `A` of a cell, where it must constrain the whole cell. The repair:
the `σ_y`-action sends `C(A,T')` to `C(A△{y}, T')` for `y ∉ T'`, and the
matched-in-`y` condition must hold for the **cell** `σ_x C(A,T')` to lie in
`X(𝓕)` — i.e. every vertex `A ∪ T''` (`T'' ⊆ T'`) toggled by `x` must remain in
`𝓕`, not merely `A`. With "matched-in-`x`" read as "the whole cell `C(A,T')`
and its `x`-translate `C(A△{x},T')` both lie in `X(𝓕)`," the case analysis of
Lemma 2.2.1 goes through unchanged and the conclusion stands: for `x ∉ S`, the
single-family `χ_S`-isotype `C^*(X(𝓕))_{χ_S}` is supported on cells with
`x ∉ T'` whose whole `x`-prism lies in `X(𝓕)`. **This repaired single-family
statement is sound and is the one §3–§4 use.** The falsity is never here; it is
in lifting it to the hocolim.

### 5.2 Shortcut A — UC14 R2's chain isomorphism (and its honest shadow)

R2 (UC14 Theorem 2.6.2 → 2.7.1) claims the single-family identification lifts
to a chain isomorphism of hocolims `C^*(Xₙ∩)_{χ_S} = C^*(X(𝒟ₓ))_{χ_S}`, hence
`V_S^k(Xₙ∩) ≅ V_S^k(X(𝒟ₓ)) ≅ V_S^k(X_{n-1,x}∩)`. Its honest shadow — the
"relative cochains vanish family-by-family" argument of §4.2 — claims
`V_S^k(Xₙ∩/X(𝒟ₓ)) = 0`, which via (STRIP)+(RED) gives the *same*
`V_S^k(Xₙ∩) ≅ V_S^k(X_{n-1,x}∩)`. They are the same false statement.

**The `n = 3` refutation (verbatim from `mg-552b §3.1`, re-derived as a check
on this document's own machinery).** Take `n = 3`, `S = {1,2} = [n]∖{3}`,
`x = 3`, `k = 1 = n-2`. The shortcut gives

```
   V_S^1(X_3∩)  ≅  V_S^1(X_{2,3}∩)  =  V_{[2]}^1(X_2∩)  ≅  sgn_{S_2}  ≠  0,
```

because on the smaller cube `[n]∖{x} = {1,2}` the index `S = {1,2}` is the
**top** Walsh character, and `V_{[2]}^1(X_2∩) ≅ sgn` is the program's own
sphere class (UC10.R / UC12 Theorem 4.4; the very class UC14 R3 §3.6 uses as a
load-bearing input). But Y1 / UC10.1 require `V_S^1(X_3∩) = 0` for the proper
subset `S ⊊ [3]`. **The shortcut forces `sgn ≅ 0`. Contradiction.**

So Shortcut A is false — confirmed independently here. The mechanism: the
shortcut asserts `ρₓ` homotopy-cofinal (§4.3); cofinality would make the
comma-nerve twist vanish; it does not vanish, and `S = [3]∖{3}` is a witness.

### 5.3 Shortcut B — declaring `ρₓ` cofinal / the comma nerves contractible

One might hope to *prove* the comma categories `ρₓ/(T,𝓖)` have contractible
nerve (each stuck fibre is "a cone"). By §4.3 that is logically **equivalent**
to Shortcut A. §5.2 refutes it. Concretely: the comma fibre over the top
family `2^{[2]}` on `{1,2}` controls the discrepancy at `S = {1,2}`, and its
nerve must carry the `sgn` class that obstructs `V_{[2]}^1 ≅ 0` — it is **not**
contractible. Any argument that the stuck fibres are contractible is therefore
false, and equivalent to R2.

### 5.4 The lesson — vanishing lifts, isomorphism does not

The one thing that *does* lift through a hocolim for free is **termwise
vanishing**: if a value functor is `0` on every object, its hocolim is `0`. The
thing that does **not** lift is **isomorphism**: a per-object iso (or per-object
`relative = 0`) does not give a hocolim iso, because the bar strings couple
objects across the subcategory boundary. R2 — and every shortcut shaped like it
— lifts an isomorphism. (Y1-RESIDUAL) cannot be evaded this way; it must be
*computed*.

---

## §6 — The `|S| = n-1` sub-case and the sphere-class collision

§3–§5 handled `|S| ≤ n-2`. The remaining sub-case of Y1 is `|S| = n-1`, i.e.
`S = [n]∖{x}` for a single `x`. This is the sub-case that carries the
**level-1 isotypes after the F17/F18-style duality** is *not* relevant — but
it is structurally the hardest, and it is where R2's falsity bites hardest.

### 6.1 Why `|S| = n-1` cannot use §3's reduction unchanged

For `|S| = n-1` the set `[n]∖S = {x}` is a singleton — `x` is **forced**. In
the cofiber LES (LES-S) the smaller-cube term is

```
   V_S^{k}(X_{n-1,x}∩)  =  V_{[n-1]}^{k}(X_{n-1}∩),
```

the **top** Walsh isotype of the smaller cube. By the inductive hypothesis
`TW(n-1)` this is `0` for `1 ≤ k ≤ n-3` but `≅ sgn_{S_{n-1}}` (one-dimensional,
non-zero) at `k = n-2`. So §3.3's "smaller-cube term `= 0`" **fails at
`k = n-2`**: the SES (SES-S) at `k = n-2` reads

```
   0 → V_S^{n-3}(X_{n-1,x}∩) --δ--> V_S^{n-2}(cofib ιₓ) --j*--> V_S^{n-2}(X_n∩) → 0
```

and one degree up the term `V_S^{n-2}(X_{n-1,x}∩) ≅ sgn` is alive and feeds
`δ : sgn → V_S^{n-1}(cofib ιₓ)`. The reduction (RED) `j* : V_S^k(cofib) ≅
V_S^k(Xₙ∩)` no longer holds at the degrees adjacent to `n-2`; one gets only

```
   V_S^{n-2}(Xₙ∩)  ≅  coker( δ : V_S^{n-3}(X_{n-1,x}∩) → V_S^{n-2}(cofib ιₓ) )
```

with `V_S^{n-3}(X_{n-1,x}∩) = 0` by `TW(n-1)` (since `n-3 < n-2`), so still
`V_S^{n-2}(Xₙ∩) ≅ V_S^{n-2}(cofib ιₓ)` — but now **also** the bridge step needs
re-examination, because `ιₓ* ≃ 0` was derived for the `χ_S`-isotype with the
twisted bridge, and at `|S| = n-1` the twist `χ_{x}·` sends `χ_S` to
`χ_{S∪{x}} = χ_{[n]}` — the *top* character. The twisted bridge for `|S|=n-1`
is the genuine antisymmetric bridge into the top isotype, i.e. it is exactly
R3's setting, not a "twisted-symmetric" one. The `|S| = n-1` sub-case of Y1 is
*not* a twisted variant of the others; it is the R3 mechanism applied to a
*lower* abutment, and it must be done with the R3 machinery, separately.

### 6.2 The collision R2 created here, and why it must be cleanly avoided

This `|S| = n-1` sub-case is the exact locus of the UC14 internal
inconsistency. R2 applied to `S = [n]∖{x}` asserts `V_S^{n-2}(Xₙ∩) ≅
V_{[n-1]}^{n-2}(X_{n-1}∩) ≅ sgn ≠ 0`, contradicting Y1's requirement
`V_S^{n-2}(Xₙ∩) = 0`. Meanwhile R3 §3.6 *uses* `V_{[n-1]}^{n-2}(X_{n-1}∩) ≅
sgn` as a load-bearing non-zero input. So within UC14, R2 and R3 disagree on
the same group. Any valid proof of the `|S| = n-1` sub-case of Y1 must:

1. **never** invoke R2 (it would force `sgn ≅ 0`);
2. show `V_{[n]∖{x}}^{n-2}(Xₙ∩) = 0` **while** `V_{[n-1]}^{n-2}(X_{n-1}∩) ≅
   sgn` stays non-zero — i.e. the cofiber `δ`-map and the cofiber term
   `V_S^{n-2}(cofib ιₓ)` must *exactly* absorb the would-be class. The smaller
   cube's sphere class must die on the way up into `Xₙ∩` through the cofiber,
   not survive.

That is a non-trivial cancellation: the cofiber term `V_S^{n-2}(cofib ιₓ)`
must be **exactly `0`** (so that `j*` forces `V_S^{n-2}(Xₙ∩) = 0`) *and* the
sphere class one degree up must be killed by `δ` landing in
`V_S^{n-1}(cofib ιₓ)`. Both are statements about the same uncomputed cofiber of
§4. **The `|S| = n-1` sub-case is therefore not closed here either** — it
inherits (Y1-RESIDUAL) and adds the constraint that the residual must vanish
*sharply* (not just "be small") to avoid colliding with the sphere class.

### 6.3 Status of the sub-case

`|S| = n-1` is **open**, for the same reason `|S| ≤ n-2` is open (the cofiber
of §4), plus the additional sharpness constraint of §6.2. It cannot be
finessed; it is the structural heart of why the program's own documents (R2
vs R3) contradict each other. A correct Y1 must compute the cofiber and
exhibit the precise cancellation. This document isolates the requirement; it
does not meet it.

---

## §7 — UC14 re-band: R2 is FALSE

Per the `mg-56b8` brief (deliverable item 2) and the `mg-552b` audit
recommendation 1. UC14's standing verdict is **"GREEN — R1 + R2 + R3 all
closed."** That verdict is **wrong on R2**.

### 7.1 The corrected status of UC14's three residuals

| Residual | UC14's claim | Corrected status |
|---|---|---|
| **R1** (abutment identification, `Θ`-map) | GREEN — closed | **Unchanged — not re-audited here.** `mg-552b` did not refute R1. `Θ` is an inclusion of bicomplexes; no isomorphism is lifted through a hocolim. Out of scope for `mg-56b8`; left GREEN pending. |
| **R2** (UC13 Lemma 4.4.1 upgraded to a chain isomorphism `C*(Xₙ∩)_{χ_S} = C*(X(𝒟ₓ))_{χ_S}`) | GREEN — closed | **FALSE — RED.** UC14 Theorem 2.6.2 (the hocolim lift) and Theorem 2.7.1 (the chain isomorphism) are false. Applied to `S = [n]∖{x}` they force `sgn ≅ 0`, contradicting UC10.1 *and* UC14 R3 §3.6, inside one document. Diagnosis: §4.2–§4.3 + §5.2 here; `mg-552b §3`. **The honest surviving statement is UC13 Lemma 4.4.1's original cautious *surjection* — and even that should be read cohomologically and is itself not independently re-verified here.** |
| **R3** (iterated-bridge degree count for top-Walsh `TW`) | GREEN — closed | **Method sound; carries `mg-552b`-flagged soft spots; not re-audited here.** R3's cofiber-LES + induction is the correct method (this document ports it). `mg-552b §4.3` and §8.4 below note R3 §3.6 is loose in places. R3 is out of `mg-56b8` scope; left GREEN-with-noted-soft-spots, *not* relied on beyond `TW` as inductive partner. |

### 7.2 Corrected UC14 verdict

> **UC14 corrected verdict: AMBER-WITH-ONE-FALSE-RESIDUAL.** R2 is **false**
> and must not be cited. R1 and R3 are not re-audited by `mg-56b8` and are left
> at GREEN pending (R1) / GREEN-with-soft-spots (R3). UC14's "R1 + R2 + R3 all
> closed → GREEN" headline is **withdrawn**: a document containing a provably
> false theorem that contradicts its own sibling theorem and the parent
> UC10.1 cannot be GREEN.

### 7.3 Knock-on: UC13 §4 and UC10.1

- **UC13 §4.5 / Theorem 4.5.1 (Y1)** stays **INVALID-as-written / UNPROVEN**
  (`mg-552b` finding 2). This document does not rescue it — it replaces the
  invalid argument with a *valid reduction to an open residual*, which is a
  different and lesser thing than a proof.
- **UC13 §4.4 Lemma 4.4.1**: the "surjection modulo lower-dimensional
  corrections" is the honest statement; R2's upgrade to an isomorphism is
  withdrawn. The surjection itself is *consistent with* Y1 but does not prove
  it (a surjection `sgn ↠ 0` is fine; proving the target is `0` is the whole
  problem).
- **UC10.1** remains **stated, not proven** on its Y1 half. Its TW half rests
  on R3 (method sound, soft spots noted). UC10's own verdict was always AMBER;
  the post-UC13/UC14 "unconditional / GREEN" upgrade is **withdrawn for the Y1
  half**.

The concrete file edits implementing this re-band are applied to
`docs/union-closed-UC14-uc13-technical-cleanup.md` (correction banner at the
head + R2 section markers) and `docs/PROOF-STRUCTURE-ONBOARDING.md` (§3 status
table + §4 cross-ref table) as part of this commit.

---

## §8 — Soft spots from `mg-552b` that bear on the re-derivation

The `mg-56b8` brief asks to flag the `mg-552b`-noted soft spots where they
affect the re-derivation. Assessment:

### 8.1 Theorem 4.3.1 — the twisted chain-homotopy identity ("Proof sketch")

§3.2 of this document *uses* Theorem 4.3.1 (to get `ιₓ* ≃ 0`). `mg-552b §4.4`
flagged: (a) its step "`d` commutes with `χ_{x}·`" is valid only on
`χ_S`-supported cells, a forward dependency on Lemma 2.2.1; (b) the typing is
murky — `ιₓ^{𝒟*}ω` and `(dh−hd)ω` nominally live in different complexes.
**Bearing on this document:** moderate. The repaired Lemma 2.2.1 (§5.1)
supplies (a) cleanly. For (b): the honest reading used here is that the
identity asserts `ιₓ*` is null-homotopic *as a map of `χ_S`-isotype cochain
complexes* `V_S^*(Xₙ∩) → V_S^*(X_{n-1,x}∩)` — which is the only reading the LES
needs, and is well-typed once one fixes the trace `ιₓ*` as that map. This
document's §3.2 is sound **conditional on Theorem 4.3.1 holding in that
well-typed form** — a conditional that should be discharged in any full
write-up but is not the Y1 obstruction (the obstruction is §4's cofiber).

### 8.2 Remark 4.2.2 — the bridge in an existing coordinate

`mg-552b §4.4` flagged that UC13 builds `hₓ` for `x ∈ [n]` "by analogy" with
UC12's doubling bridge in the *new* coordinate `n+1`, never re-deriving the
chain-homotopy property. **Bearing:** low-to-moderate. The prism structure
`X(𝒟ₓ𝓕) ≅ X(ρₓ𝓕) × Iₓ` is genuine (UC14 Lemma 2.3.1), so `hₓ` does exist as
a prism operator; the "by analogy" gap is a write-up debt, not a falsity. It
does not affect the §4 residual.

### 8.3 §4.4 "modulo lower-dimensional corrections"

This hedge is now resolved in the *correct* direction: §5.1's repaired Lemma
2.2.1 shows there are no lower-dimensional corrections **at the single-family
level** (R2 §2.5 got this part right). The error was never here — it was
R2 §2.6's claim that single-family ⟹ hocolim. So this soft spot is **benign**
for the re-derivation; it is the *next* step (2.6) that is fatal.

### 8.4 Degree-convention drift; R3 §3.6 looseness

`mg-552b §4.4` flagged a degree-convention drift between UC13 §4.2 (`hₓ^{tw}`
degree `−1`) and §5.3 (`hₓω` described as degree `+1`), and `mg-552b §4.3`
noted R3 §3.6's iterated-cofiber-LES argument is loose ("the exact sign is not
load-bearing", the `k < n-2` iterated injection is sketchy). **Bearing:** this
document fixes the convention (the bridge is uniformly degree `−1`, §3.2) and
**does not rely on R3 beyond the bare statement `TW`** as inductive partner
(§2.1). If a full Y1 proof is ever assembled, R3's §3.6 should be re-audited in
the same pass, because the simultaneous induction (§2.1) makes `TW` and `Y1`
co-dependent — a soft `TW` weakens `Y1` and vice versa. Flagged, not fixed
here (R3 is out of `mg-56b8` scope).

---

## §9 — Verdict, recommendations, cross-references

### 9.1 Verdict

**RED — Y1-NOT-REPROVEN (residual isolated).** The cofiber-LES + induction
method is the right method and is set up correctly here: it validly reduces
Y1, for `S ⊊ [n]` with `|S| ≤ n-2`, to **(Y1-RESIDUAL)** — the vanishing of
`V_S^k(cofib ιₓ)`, the `χ_S`-cohomology of the homotopy cofiber of the
matched-cylinder inclusion `X(𝒟ₓ) ↪ Xₙ∩` — and exhibits that residual as a
genuine hocolim-of-a-pair / comma-category computation with no free vanishing.
The `|S| = n-1` sub-case inherits the same residual plus a sharp
no-collision-with-`sgn` constraint (§6). Neither sub-case is closed.

This is **not** a refutation of Y1: no counterexample is produced; Y1 is still
plausibly true (UC10.1 content). It is also not a proof that Y1 is *unprovable*
— it is the precise statement that **this method, executed honestly, does not
close Y1 in this session, and the remaining work is a substantial
homotopy-colimit computation, not a hypothesis-check.** Per the `mg-56b8`
brief, a RED of this shape is a valid and important outcome.

### 9.2 What was actually delivered (positive content)

1. The correct inductive frame: simultaneous `UC10.1(n) = Y1(n) ∧ TW(n)`,
   correcting UC13/UC14's independent-sections presentation (§2.1).
2. A *valid* reduction (RED): `Y1(n)` for `|S| ≤ n-2` ⟺ (Y1-RESIDUAL),
   via the isotype-split cofiber LES + the bridge's `ιₓ* ≃ 0` (§3) — no R2,
   no trace-exactness error.
3. Precise identification of the residual as the comma-category twist of the
   trace functor `ρₓ` (§4.3) — the stuck-family homotopy type the program has
   never computed.
4. A single-mechanism account of why both shortcuts past the residual (R2's
   chain iso; naïve relative-vanishing) are false — "vanishing lifts through a
   hocolim, isomorphism does not" (§5).
5. The UC14 re-band: R2 FALSE, UC14 verdict corrected to
   AMBER-with-one-false-residual (§7).
6. Soft-spot triage (§8): 4.3.1 conditional-but-not-the-obstruction; 4.2.2 a
   write-up debt; 4.4 benign; degree drift fixed; R3 §3.6 flagged for a
   co-dependent re-audit.

### 9.3 Recommendations (routed to Daniel via `pm-onethird`)

1. **Record Y1 as `RED — reduced-to-named-residual`,** not "HIGH-RISK-unproven"
   (a strict improvement on `mg-552b`: the gap is now localized to one named
   computation) and not GREEN. Update `PROOF-STRUCTURE-ONBOARDING.md`
   accordingly (done in this commit).
2. **The next ticket is the residual, not another Y1 re-attempt.** File a
   focused ticket: *compute `V_S^*(cofib ιₓ)` = the `χ_S`-cohomology of the
   `𝒟ₓ`-exiting bar-string bicomplex, equivalently the comma-category twist
   `N(ρₓ/−)` of the trace functor.* This is the genuine stuck-family core. It
   is plausibly multi-week; it is the honest bound, replacing `mg-552b`'s
   optimistic "bounded work."
3. **Do not Lean-formalize Y1 yet.** The `mg-56b8` brief already says the
   honest Lean formalization is downstream; this verdict confirms there is
   nothing valid to formalize — `UC10_lowerWalshVanishing`
   (`UC13_PartB/LowerWalsh.lean`) remains the non-faithful `χ²=1` placeholder
   `mg-552b §5` described.
4. **UC14 must not be cited as GREEN.** R2 is false; the re-band (§7) stands.
5. **The Zulip post stays held** — the Frankl two-part contradiction still has
   one mechanism-sound half (Y2) and one half (Y1) that is now *validly
   reduced but not proven*. Reinforces `mg-39bc` + `mg-552b`.

### 9.4 If a future session attacks the residual

The residual `V_S^*(cofib ιₓ)` is, by §4.3, the hypercohomology of
`hocolim_{C_{n-1,x}∩}(G ⊗ N(ρₓ/−))` minus the cofinal part. Concrete entry
points: (a) compute the comma categories `ρₓ/(T,𝓖)` — the fibres of the trace
to `[n]∖{x}` — and their nerves; the stuck families are exactly the
non-contractible-fibre locus; (b) `n = 3`, `S = {1}` is the smallest genuinely
open instance (`|S| = 1 ≤ n-2 = 1`) and should be computed by hand first; (c)
the `|S| = n-1` collision (§6) is the sharpest test — any candidate cofiber
computation must kill the sphere class *exactly*, and that is the fastest way
to falsify a wrong attempt. Do **not** attempt a cofinality argument for `ρₓ`
(§5.3: equivalent to R2, false).

### 9.5 Cross-references

- **Brief:** `mg-56b8`. **Audit this answers:** `mg-552b`
  (`docs/Frankl-Y1-walsh-vanishing-audit.md`, Y1-HIGH-RISK).
- **Y2 counterpart:** `mg-aeee` (`docs/Frankl-Y2-obstruction-isotype-landing.md`,
  Y2-SUPPORTED). **Decomposition / risk framing:** `mg-39bc`
  (`docs/frankl-axiom-restructure-investigation.md`).
- **Paper sources:** `docs/union-closed-UC13-frankl-closure.md` §4 (the broken
  Y1 proof: §4.3 Theorem 4.3.1, §4.4 Lemma 4.4.1, §4.5 Theorem 4.5.1), §5 (the
  sibling top-Walsh, R3's target); `docs/union-closed-UC14-uc13-technical-cleanup.md`
  §2 (R2 — false), §3 (R3 — the correct method, ported here);
  `docs/union-closed-UC10-native-cohomology-intersection-closed-families.md`
  §4.1 (UC10.1), §5.3 (the AMBER sketch).
- **Onboarding:** `docs/PROOF-STRUCTURE-ONBOARDING.md` §3/§4 (updated this
  commit).
- **Non-faithful Lean placeholder:** `lean/UnionClosed/UC13_PartB/LowerWalsh.lean`
  (`UC10_lowerWalshVanishing`) — unchanged; not a formalization of Y1.

---

*Re-derivation attempt by polecat `cat-mg-56b8`. Deliverable on `main`: this
document + the UC14 re-band + the onboarding-doc status correction. Verdict:
**RED — Y1-NOT-REPROVEN (residual isolated).** The cofiber-LES + induction
method validly reduces the level-1 Walsh vanishing to one named open
computation — the `χ_S`-cohomology of the cofiber of the matched-cylinder
inclusion, a comma-category twist of the trace functor — and shows both
shortcuts past it (UC14 R2's chain isomorphism; naïve family-by-family
relative-vanishing) are false by the single mechanism that a hocolim does not
localize to a subcategory. Y1 is true-but-unproven; UC14 R2 is re-banded
FALSE; the residual is the genuine stuck-family core of the Frankl homological
program and is the correct next ticket.*
