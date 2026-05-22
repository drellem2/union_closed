# Frankl-ForkA-Phase2 — independent validation of the Fork A re-foundation

**Work item:** `mg-d300` (Frankl-ForkA-Phase2). Per the `mg-c15b` Fork A
Phase-1 GREEN, Daniel's commit-to-Fork-A directive, and the usual process
(LaTeX → independent validation → Lean). This is **Phase 2**: independent,
default-skeptical validation of the Phase-1 deliverable.

**Deliverable validated:** `paper/forkA/refoundation.tex` (the `mg-c15b`
Phase-1 LaTeX re-foundation).

**READ-FIRST consumed:** `paper/forkA/refoundation.tex` (the deliverable);
`docs/Frankl-ForkA-Refound-LaTeX.md` (`mg-c15b` ledger note);
`docs/Frankl-ForkD-Probe-n3.md` (`mg-565a`); `docs/Frankl-vision-check.md`
(`mg-6edc`); `docs/Frankl-Y1-reprove.md` (`mg-56b8`);
`docs/Frankl-Y1-phase1.5-bk-structure-maps.md` (`mg-0405`).

**Stance.** Independent reviewer, default-skeptical, per the brief: the
`mg-c15b` polecat already caught and withdrew one over-claim in its own
draft (the clean "`ob` is standard-isotypic, hence `sgn`-free" landing
theorem); the explicit job of Phase 2 is to check for **others it did not
catch**. This report does the construction-level verification independently
and reports two it did not catch.

---

## §0 — Verdict (top of page)

### 0.1 Headline

> **AMBER — FORK-A CORE SOUND; THE `Y1` REDUCTION DOES NOT PORT CLEANLY,
> AND THE RESIDUAL SET IS NOT EXACTLY THREE.**
>
> The **spine** of the re-foundation is sound and is independently
> confirmed: the trace projection `π_T` is a genuine covariant functor
> (chain-map, functoriality, `S_n`-equivariance all check out); the Fork A
> object `H*(C_n;X)` is genuinely defined (`D² = 0` verified line-by-line);
> dropping the `(Z/2)^n`-action genuinely *dissolves* Phase-1.5 refutation
> (b); the Maschke `S_n`-re-grading is correct; and the conditional
> contradiction theorem is a **valid conditional** given its stated
> hypotheses. The re-foundation is **not refuted** — RED is not the
> verdict.
>
> But the document is **not GREEN**, because two further over-claims
> survive into the submitted draft, neither caught by the `mg-c15b`
> self-audit:
>
> - **Finding A (substantive).** The `Y1`-A cofiber-LES reduction
>   (Theorem `thm:y1-reduction`) asserts that the cofiber long exact
>   sequence of the pair `(X_n, X_{n-1,x})` is **`S_n`-equivariant** and
>   splits into `S_n`-isotypes `[λ]`. **It is not.** The smaller object
>   `X_{n-1,x}` is stable only under `Stab(x) ≅ S_{n-1}`, so the pair and
>   its LES are `S_{n-1}`-equivariant. The pre-Fork-A `Y1` reduction got
>   `(Z/2)^n`-equivariance *for free* because `(Z/2)^n` is abelian and
>   factors as `(Z/2)^{[n]∖x} × (Z/2)_x` — it has a **quotient** acting on
>   the smaller cube. `S_n` has **no such quotient**. The claim "`R1` is
>   unchanged from the pre-Fork-A state" and "the cofiber-LES reduction
>   ports" are therefore **over-claims**: dropping `(Z/2)^n` does not only
>   re-open `Y2` (which the document honestly records as `R2`); it *also*
>   damages the `Y1` reduction machinery, and that is not recorded.
>
> - **Finding B (accounting).** The obstruction class `ob(F⋆) ∈
>   H̃^{n-1}(C_n;X)` is defined (Definition `def:ob`) through an edge map
>   whose **existence** and **degree behaviour** the document itself
>   admits (Remark `rem:promotion`) are "not discharged here." But the
>   *formally stated* residual `R3` (Owed debt `debt:faithful-localized`)
>   and the *formally stated* hypothesis (i) of the conditional theorem
>   (Theorem `thm:contradiction`) cover only **injectivity**. So
>   edge-map existence and degree-behaviour — both load-bearing for
>   `ob(F⋆)` to be a well-defined element of degree `n-1` — are a genuine
>   **fourth open item**, disclosed in one remark but absent from the
>   formal three-residual accounting. The headline claim "rests on exactly
>   three precisely named residuals, no hidden assumption, no fourth gap"
>   is not airtight.

### 0.2 The scorecard, re-scored

| Phase-1 claim | Phase-1 self-score | Phase-2 verdict |
|---|---|---|
| `π_T` is a covariant functor (chain-map, functorial, equivariant) | GREEN | **GREEN — confirmed.** Verified §2.1. |
| `H*(C_n;X)` genuinely defined; `D² = 0` | GREEN | **GREEN — confirmed.** Verified §2.2. |
| Dropping `(Z/2)^n` dissolves refutation (b) | GREEN | **GREEN — confirmed** *as a dissolution* (§2.3); but see Finding A for an un-recorded cost. |
| `S_n`-grading by Maschke | GREEN | **GREEN — confirmed.** Verified §2.4. |
| Sphere class `= sgn_{S_n}` (Prop. `prop:sphere-sgn`) | GREEN | **GREEN with a minor caveat** — the *proof* assumes more than the stated hypothesis; not load-bearing (§5.1). |
| Obstruction class re-founded | GREEN (as a construction) | **AMBER** — the Čech *cocycle* is constructed; its *promotion* into `H*(C_n;X)` is not (Finding B, §4). |
| `Y1`-A cofiber-LES reduction "ports" (Thm. `thm:y1-reduction`) | (delivered content) | **AMBER — over-claim.** The reduction does **not** port cleanly (Finding A, §3). |
| `R1` "unchanged from the pre-Fork-A state" | RED — open (unchanged) | **AMBER — over-claim.** `R1`'s *reduction machinery* is damaged by dropping `(Z/2)^n` (Finding A, §3). |
| Conditional contradiction theorem (Thm. `thm:contradiction`) | GREEN (as a conditional) | **GREEN as a conditional** *given* its three hypotheses — but the hypothesis list is incomplete (Finding B, §4). |
| "Exactly three residuals `R1/R2/R3`, no fourth gap" | GREEN | **AMBER — not exactly three** (Finding B, §4). |
| `Y2`-A: structural mechanism only; "standard-isotypic" over-claim withdrawn | self-corrected | **GREEN — confirmed.** The withdrawal is correct and `R2` is honestly localized (§2.5). |

### 0.3 What AMBER means here, precisely

AMBER is **not** RED. Nothing in the re-foundation is refuted; the Fork A
object exists, the framework is internally coherent, and the conditional
theorem is a valid conditional. AMBER means: the document **over-states
what Phase 1 delivered** in two specific, fixable places, and the
headline claim that the contradiction reduces to *exactly* three residuals
is inaccurate. Both findings are **repairable by an honest re-statement**
(see §6.2) — no new wall is hit. A corrected Phase-1 document is on a
clear path to GREEN. But the document **as submitted** cannot be validated
GREEN, because a Phase-2 reviewer's core job — confirm `R1/R2/R3` are the
genuine and *complete* residual set with no hidden assumption — returns
*no*: the set is incomplete (Finding B) and one of its members is
mis-described as "unchanged / ported" (Finding A).

---

## §1 — Scope and method

The brief fixes four verification targets. This report takes them in turn:

1. **`H*(C_n;X)` with `X` genuinely well-defined** — the structure map
   exists and is functorial; `D² = 0` genuinely holds. → §2.1–§2.2.
   **Confirmed sound.**
2. **Dropping `(Z/2)^n` genuinely dissolves the Phase-1.5 refutation.**
   → §2.3. **Confirmed sound as a dissolution** — with an un-recorded
   downstream cost surfaced in §3.
3. **The Maschke re-grading and sphere-class `= sgn_{S_n}` are correct.**
   → §2.4–§2.5, §5.1. **Confirmed sound** (one non-load-bearing caveat).
4. **The conditional theorem reduces to EXACTLY the three named residuals
   `R1/R2/R3`, no hidden assumption, no fourth gap.** → §3, §4.
   **Not confirmed** — §3 (Finding A) and §4 (Finding B).

Method: every theorem with mathematical content was re-proved or
re-checked independently from the definitions, not taken on the
document's word; the `(Z/2)^n`-to-`S_n` transition was cross-checked
against the pre-Fork-A `Y1` machinery (`mg-56b8`) and the Phase-1.5
refutations (`mg-0405`) to test the "ports unchanged" claims.

---

## §2 — What is sound (independently confirmed)

### 2.1 The trace projection `π_T` — GREEN, confirmed

Theorem `thm:projection` claims `π_T(C(A,T')) = C(A∩T,T')` for `T' ⊆ T`,
`0` otherwise, is a chain map `X(F) → X(F|_T)`, functorial and
`S_n`-equivariant. Verified independently:

- **Well-defined on cells.** For `C(A,T')` a `k`-cell of `X(F)` with
  `T' ⊆ T`: `A∩T ∈ F|_T`; `T' ⊆ S∖A` and `T' ⊆ T` give `T' ⊆ T∖(A∩T)`;
  and for every `T'' ⊆ T'`, `(A∩T)∪T'' = (A∪T'')∩T ∈ F|_T` because
  `A∪T'' ∈ F` and `T'' ⊆ T' ⊆ T` (so `(A∪T'')∩T = (A∩T)∪(T''∩T) =
  (A∩T)∪T''`). So `C(A∩T,T')` is a genuine cell of `X(F|_T)`. ✓
- **Chain map.** For `C(A,T')` with `T' ⊆ T`, every face has direction
  set `T'∖{t} ⊆ T`, and `π_T` sends faces to the corresponding faces of
  `C(A∩T,T')` (using `(A∪{t})∩T = (A∩T)∪{t}` for `t ∈ T`). For
  `T' ⊄ T`, `π_T(C(A,T')) = 0`; the only faces of `C(A,T')` that survive
  `π_T` are the two faces in the *unique* dropped direction `t₀` when
  `|T'∖T| = 1` — and those two map to the **same** cell with opposite
  incidence sign and cancel. So `π_T∂ = ∂π_T`. ✓
- **Functorial.** `(A∩T)∩T' = A∩T'` for `T' ⊆ T ⊆ S`; the
  degenerate-to-zero convention composes; `π_S = id`. ✓
- **`S_n`-equivariant.** `π_T` is built from the coordinate projection
  `A ↦ A∩T` and the relation `T' ⊆ T`, both carried by relabelling. ✓

This is `mg-0405` Proposition 3.6, already the validated positive content
of the Phase-1.5 audit. **Sound.**

### 2.2 The Fork A object `H*(C_n;X)` — GREEN, confirmed

Definition `def:bk` builds the cochain Bousfield–Kan double complex with
the cochain value at the **first** object `F_0` of each bar string — the
correct convention for the homotopy colimit of a *covariant* functor (the
`mg-0405` §6 Fork A prescription). The horizontal differential `δ_BK` is
the cosimplicial bar differential; its only diagram-value-dependent face,
`d_0^*`, is `π_{T_1}^*`.

Theorem `thm:welldefined` (`D² = 0`) verified independently:

- `d² = 0` — cubical cochain identity. ✓
- `δ_BK² = 0` — the cochain bar construction of a covariant functor into
  an abelian category is a genuine cosimplicial object; the `d_0^*d_0^*`
  term of `δ_BK²` reduces to `π_{T'}∘π_T = π_{T'}`, supplied by §2.1. ✓
- `d` and `δ_BK` commute — each `π_T^*` is a cochain map (dual of a chain
  map), and the faces `d_j^*` (`j ≥ 1`) do not touch the cochain value.
  With the total differential `D = d + (-1)^q δ_BK` the cross-terms
  anticommute, so `D² = 0`. ✓ (The total-complex sign computation was
  carried out explicitly and checks out.)
- Finiteness: for each fixed `p`, `BK^{p,q}` is a finite sum (`C_n` is a
  finite thin category, so finitely many bar strings of length exactly
  `p`); each total degree `⊕_{p+q=k}BK^{p,q}` is finite-dimensional. ✓

**Sound.** The Fork A object is genuinely defined where the pre-Fork-A
`X_n^∩` was undefined. This is the load-bearing positive content of the
re-foundation and it holds.

### 2.3 Dropping `(Z/2)^n` dissolves refutation (b) — GREEN, confirmed *as a dissolution*

Phase-1.5 refutation (b) (`mg-0405` §4): the `(Z/2)^n`-action on the
cohomology object does not assemble. Fork A drops the action entirely and
grades by `S_n`. **As a dissolution this is correct**: with no
`(Z/2)^n`-action anywhere in the construction, there is no object for
refutation (b) to refute. The document is also correct that the genuine
content of Walsh survives in Role 2 (the harmonic basis, used to label
the obstruction *cochain*), and Remark `rem:walsh-role2` is honest that
harmonic level grades cochains, not cohomology.

The document is **honest about the cost to `Y2`**: Status `status:c-block`
records that the pre-Fork-A `Y2` mechanism used `(Z/2)^n`-equivariance and
must be re-derived — this is `R2`. **However**, the document does **not**
record that dropping `(Z/2)^n` *also* costs something on the `Y1` side.
That omission is Finding A (§3). The dissolution is genuine; the
accounting of its downstream cost is incomplete.

### 2.4 The Maschke `S_n`-decomposition — GREEN, confirmed

Theorem `thm:maschke`: `S_n` acts on `Tot BK` by cochain automorphisms
(`S_n` relabels bar strings and acts on `C^q(X(F_0))` via the
equivariance `π·X(F_0) = X(πF_0)`; both differentials are
`S_n`-equivariant); `Q[S_n]` is semisimple (Maschke, char `0`), so each
`H^k(C_n;X)` splits canonically into `S_n`-isotypes and the total complex
splits as a complex. Verified — the `S_n`-action is **genuine**
(Notation `not:sn`: relabelling preserves intersection-closure and
commutes with trace), unlike the refuted `(Z/2)^n`-action. **Sound.**

### 2.5 The withdrawn `Y2` over-claim — GREEN, the withdrawal is correct

Status `status:y2a` withdraws the earlier-draft theorem "`ob` is
standard-isotypic, hence `sgn`-free," correctly diagnosing that it
tacitly assumed the coefficient `F_obs^q` is `S_n`-trivial. Proposition
`prop:y2a-mech` (the surviving structural mechanism: `ob` factors through
bias *differences*; the obstruction cochain is level-1 harmonic) is
correct and honestly labelled as *all* that is proved. `R2` (Open
residual `res:y2`) is honestly localized as a representation-theoretic
question about `F_obs`. **This self-correction is sound and is exactly
the discipline the brief asks for** — it is simply not the *only*
over-claim in the draft.

---

## §3 — Finding A: the `Y1`-A cofiber-LES reduction does not port cleanly

### 3.1 The claim under test

Theorem `thm:y1-reduction` ("Cofiber-LES reduction of `Y1`-A") and
Construction `constr:bridge` together assert that the pre-Fork-A
cofiber-LES reduction of `Y1` (`mg-56b8`) **ports to Fork A**. The
document scores this as delivered positive content: the §0.2 scorecard
row "`Y1`-A … the cofiber-LES reduction ports to Fork A"; delivered-content
item 5 "the cofiber-LES reduction ported (Theorem `thm:y1-reduction`)";
and crucially the repeated claim that **`R1` is "unchanged from the
pre-Fork-A state"** (§0.1 R1; Open residual `res:y1`; Remark
`rem:honest-shape` bullet 2; the final summary).

The verbatim statement of Theorem `thm:y1-reduction`:

> "The pair has an **`S_n`-equivariant** cohomology long exact sequence;
> projecting to any isotype `[λ]` (Maschke, Theorem `thm:maschke`) and
> substituting the null-homotopy `ι_x* ≃ 0` … collapses it, in each
> degree, to a relation expressing `H̃^k(C_n;X)_{[λ]}` through the isotype
> cohomology of the cofiber."

and the proof sketch: "every map is `S_n`-equivariant (the inclusion
`C_{n-1,x} ↪ C_n` and the cofiber are natural in `[n]`), so by Theorem
`thm:maschke` the LES splits into isotypes."

Both the **`S_n`-equivariance of the LES** and the **projection to
`S_n`-isotypes `[λ]`** are load-bearing steps of the reduction.

### 3.2 The `S_n`-equivariance claim is false

`X_{n-1,x}` is the Fork A complex of the subcategory `C_{n-1,x} ⊆ C_n`
of pointed families whose ground set is contained in `[n]∖{x}`. For
`π ∈ S_n` and an object `(S,F)` with `S ⊆ [n]∖{x}`, the relabelling
`π·(S,F) = (πS,πF)` has ground set `πS ⊆ [n]∖{π(x)}`. Hence:

> `π` preserves the subcategory `C_{n-1,x}` **iff `π(x) = x`**.

So `C_{n-1,x}` — and therefore `X_{n-1,x}`, the inclusion `ι_x`, the pair
`(X_n, X_{n-1,x})`, the relative complex `X_n/X_{n-1,x}`, and the whole
cofiber long exact sequence — is stable exactly under the **point
stabiliser `Stab(x) ≅ S_{n-1}`**, not under `S_n`.

The proof sketch's parenthetical defence — "the inclusion `C_{n-1,x} ↪
C_n` … natural in `[n]`" — is a category error of exactly the kind
`mg-565a` §5 flagged in a different guise. The *family*
`{ι_x}_{x∈[n]}` is `S_n`-equivariant (a permutation carries `ι_x` to
`ι_{π(x)}`); the *individual* `ι_x` for fixed `x` is only
`Stab(x)`-equivariant. Theorem `thm:y1-reduction` fixes `x` and uses
`ι_x` for that `x`. Its LES is **`S_{n-1}`-equivariant**. The claim "the
pair has an `S_n`-equivariant cohomology long exact sequence" is wrong,
and the step "projecting to any isotype `[λ]`" — meaning an `S_n`-isotype,
via Theorem `thm:maschke`, which is an `S_n`-Maschke theorem — is
therefore unjustified.

### 3.3 Why the pre-Fork-A reduction did not have this problem — and why Fork A does

This is not a slip that the pre-Fork-A development also made. The
pre-Fork-A `Y1` reduction (`mg-56b8` §3) split the cofiber-LES into
**Walsh isotypes** `V_S`, i.e. isotypes of the `(Z/2)^n`-action. And the
`(Z/2)^n`-action genuinely *does* descend to the smaller cube:
`mg-56b8` §2.3 records, precisely, "the `(Z/2)^n`-action on `X_{n-1,x}∩`
factors through `(Z/2)^{[n]∖{x}}` (the `σ_x` toggle acts trivially —
there is no `x`-coordinate)."

The mechanism is special to `(Z/2)^n`: it is **abelian** and factors as a
direct product `(Z/2)^n = (Z/2)^{[n]∖{x}} × (Z/2)_x`, so it has a
**quotient** `(Z/2)^n ↠ (Z/2)^{[n]∖{x}}` that acts on `X_{n-1,x}`. With
`σ_x` acting trivially on the smaller cube, the cofiber-LES is genuinely
`(Z/2)^n`-equivariant and splits into Walsh isotypes.

`S_n` has **no analogous quotient**. `Stab(x) ≅ S_{n-1}` is a *subgroup*
of `S_n`, not a quotient; there is no surjection `S_n ↠ S_{n-1}` through
which `S_n` could act on `X_{n-1,x}`. The structural feature that made the
pre-Fork-A cofiber-LES reduction work isotype-by-isotype — the abelian
product structure of `(Z/2)^n` — is **exactly what Fork A throws away**
when it drops the `(Z/2)^n`-action.

There is a second, compounding prong. The bridge that supplies
`ι_x* ≃ 0` is the *twisted* bridge (Construction `constr:bridge`, twist
by `χ_{x}`). `mg-56b8` §8.1 explicitly flags that the twisted-bridge
identity `ι_x* = ±½(dh − hd)` has a step — "`d` commutes with `χ_x·`" —
that "is valid only on `χ_S`-supported cells." Refoundation.tex's own
Remark `rem:walsh-role2` confirms the underlying fact: the cubical
coboundary `d` does **not** preserve harmonic level. So `ι_x* ≃ 0` is, at
honest strength, a fact about **Walsh-`χ_S`-graded cochains**, not a
whole-complex fact. Theorem `thm:y1-reduction` substitutes `ι_x* ≃ 0`
into an **`S_n`-isotype-projected** LES — and the document's own Remark
`rem:maschke-analogue` warns that "the two gradings are different
decompositions of the cohomology … not nested." A fact established on
Walsh isotypes cannot be substituted into `S_n`-isotypes.

Both prongs say the same thing: the `(Z/2)^n` → `S_n` change of grading,
which the document correctly treats as genuine work *for `Y2`* (§7.2,
honestly localized as `R2`), is **also** genuine work *for `Y1`* — and
Theorem `thm:y1-reduction` skips it.

### 3.4 What is actually true, and why this is an over-claim not a refutation

`Y1`-A is not refuted. The cofiber-LES of `(X_n, X_{n-1,x})` exists; it
is `S_{n-1,x}`-equivariant; one can still split it into
`S_{n-1}`-isotypes and run an induction on `n`. The *spirit* of the
reduction — "`Y1`-A reduces to control of the cohomology of `cofib ι_x`"
— very plausibly survives. What does **not** survive is the **clean
statement actually written**:

- "the pair has an `S_n`-equivariant cohomology long exact sequence" —
  false; it is `S_{n-1}`-equivariant;
- "projecting to any isotype `[λ]`" (an `S_n`-isotype) — unjustified;
- the conclusion expresses `H̃^k(C_n;X)_{[λ]}` per `S_n`-isotype — but
  recovering `S_n`-isotype information (needed for the target
  `H̃^{n-1}(C_n;X) ≅ sgn_{S_n}`) from an `S_{n-1}`-equivariant LES
  requires the branching relation between `S_{n-1}`-restriction and
  `S_n`-isotypes (Frobenius reciprocity / induction–restriction). That is
  real, non-trivial representation theory. `sgn_{S_{n-1}}` is the
  restriction of `sgn_{S_n}` — but it is *also* a constituent of the
  restriction of other `S_n`-irreducibles (branching rule), so an
  `S_{n-1}`-isotype computation does **not** determine the `S_n`-isotype
  content. The `S_{n-1} → S_n` step is genuinely lossy and must be done.

So the precise defects:

1. **Theorem `thm:y1-reduction` is stated with a false hypothesis-step**
   (`S_n`-equivariance of the LES) and an unjustified core step
   (`S_n`-isotype projection). It does not, as written, port.
2. **"`R1` is unchanged from the pre-Fork-A state" is an over-claim.**
   `R1` as a *target object* (the cofiber cohomology) may be morally the
   same; but `R1`'s *reduction machinery* acquires, under Fork A, a new
   representation-theoretic obstruction — the `S_{n-1}`-vs-`S_n`
   mismatch — that simply did not exist in the `(Z/2)^n` setting. The
   honest statement is the mirror image of the document's honest
   statement about `R2`: just as dropping `(Z/2)^n` re-opens the `Y2`
   landing, it *also* complicates the `Y1` reduction. The document
   records the first and misses the second.
3. **The §0.2 scorecard and delivered-content list over-state Phase 1.**
   "The cofiber-LES reduction ports to Fork A" is not delivered; what is
   delivered is "the cofiber-LES reduction *plausibly* ports, modulo a
   genuine `S_{n-1} → S_n` representation-theory step that Phase 1 did
   not carry out."

This is an over-claim of the *same shape* as the one the `mg-c15b`
polecat caught and withdrew for `Y2` (a Walsh-graded fact silently
treated as an `S_n`-graded fact). The polecat applied that skepticism to
`Y2`. It did not apply it to `Y1`. Finding A is that missed second
instance.

---

## §4 — Finding B: the residual set is not exactly three

### 4.1 The claim under test

The headline (§0.1, §0.3, Verdict `ssec:verdict`, the final summary)
states that the conditional contradiction rests on **exactly three
precisely named residuals `R1/R2/R3`**, with Remark `rem:honest-shape`
asserting Fork A "rests on *three* named open inputs … where the
pre-Fork-A closing argument rested on the same three *plus* the
unconstructed `(Z/2)^n`-action. Fork A removes the fourth." The brief's
Phase-2 question is exactly whether this is true: "no hidden assumption
and no fourth gap."

### 4.2 The obstruction class is defined through an un-pinned edge map

Definition `def:ob` defines `ob(F⋆) ∈ H̃^{n-1}(C_n;X)` as the mismatch
cocycle `{m_xy}` "promoted through the edge map of the Čech-to-cohomology
spectral sequence of the double complex `Č^{*,*}(U;F_obs)`."

Remark `rem:promotion` is then candid that this promotion has **three**
un-discharged components, not one:

> "The precise pinning of this edge map — **its existence, its degree
> behaviour, and (crucially) its injectivity** — is *not* discharged
> here; it is the content of Owed debt 2."

There are genuinely two stages folded into "the edge map," and the
**existence** of the second is the issue. Stage 1 — the spectral sequence
of the Čech double complex `Č^{*,*}(U;F_obs)` and a class in *its own*
total cohomology — is standard and fine. Stage 2 — a map from that total
cohomology **into `H*(C_n;X)`** — is a comparison between two different
cohomology theories (Čech cohomology of the sheaf `F_obs` on the
*punctured trace poset* `C_n(F⋆)∖{F⋆}`, versus the Fork A `X`-coefficient
cohomology of the *whole category* `C_n`). That comparison map is **not
constructed** anywhere in the document; Remark `rem:promotion` admits its
existence is "not discharged here." Note also the object mismatch the
edge map must bridge: the Čech complex lives on `C_n(F⋆)∖{F⋆}` (a
punctured subcategory), while `ob(F⋆)` is asserted to land in
`H̃^{n-1}(C_n;X)` (the whole category) — `H*(C_n(F⋆);X)` is never even
defined. The edge map therefore has to cross *two* gaps at once.

Consequence: `ob(F⋆)` as an **element of `H̃^{n-1}(C_n;X)`** is not
genuinely constructed. The §0.2 scorecard's "GREEN (as a construction)"
is generous: the obstruction *cocycle* is constructed; its *promotion
into the Fork A cohomology object, in degree `n-1`*, is not.

### 4.3 Existence and degree-behaviour are load-bearing and not in the formal accounting

The formal statement of `R3` — Owed debt `debt:faithful-localized` — is:

> "The edge map `Č^1(U;F_obs) → H̃^{n-1}(C_n;X)` of Definition `def:ob`
> is **injective** on the class of the mismatch cocycle."

Injectivity only. And the conditional theorem (Theorem `thm:contradiction`)
hypothesis (i) is, verbatim, "(R3, faithfulness) the Čech-to-cohomology
edge map of Definition `def:ob` is **injective** on the mismatch class."
Injectivity only.

So the document says two different things about `R3`:

- **Remark `rem:promotion`:** `R3` = {existence, degree behaviour,
  injectivity}.
- **Owed debt `debt:faithful-localized` and Theorem `thm:contradiction`(i):**
  `R3` = {injectivity}.

These are not the same residual. And the gap is load-bearing:

- **Existence** of the edge map is needed for `ob(F⋆)` to be an element
  of `H̃^{n-1}(C_n;X)` at all — i.e. for Proposition `prop:fact-one`
  (Fact One) and Theorem `thm:contradiction` to *have a subject*.
- **Degree behaviour** — that `ob(F⋆)` lands in degree `n-1`
  *specifically* — is what makes the sphere-concentration residual `R1`
  (`H̃^{n-1}(C_n;X) ≅ sgn_{S_n}`) apply to it. Remark `rem:promotion`
  says the degree `n-1` is "the cube-side dimension count *inherited from
  the pre-Fork-A development*." But the pre-Fork-A object `X_n^∩` was
  *undefined* (the entire content of the Phase-1.5 RED, `mg-0405`); a
  degree count performed in a now-defunct object is not automatically
  valid in the genuinely different Fork A object (covariant hocolim,
  cochain value at the *first* bar-string object). The document itself
  concedes this is "not discharged here."

Therefore Theorem `thm:contradiction`, as literally stated with
hypotheses (i),(ii),(iii), is **missing hypotheses**: its proof presupposes
that `ob(F⋆)` is a well-defined element of `H̃^{n-1}(C_n;X)` (edge-map
existence) sitting in degree `n-1` (degree behaviour), and neither is in
(i)–(iii) nor established unconditionally.

### 4.4 Verdict on the "exactly three" claim

The claim "rests on exactly three precisely named residuals, no hidden
assumption, no fourth gap" holds **only** if `R3` is read in the expanded
Remark-`rem:promotion` sense {existence, degree, injectivity} — in which
case `R3` is not one residual but a *bundle of three sub-problems*, and
the formal statements (`debt:faithful-localized`, Theorem
`thm:contradiction`(i)) under-state it by naming only injectivity. Read
in the formal sense {injectivity}, edge-map existence and degree-behaviour
are a genuine **fourth open item**, disclosed in a remark but absent from
the conditional theorem's hypothesis list.

Either way the precise headline is inaccurate. The honest statement is:
**the contradiction rests on `R1`, `R2`, and a faithfulness debt `R3`
that is itself three sub-residuals — edge-map existence, degree-`n-1`
landing, and injectivity — of which only injectivity is formally named.**
Relatedly, Remark `rem:honest-shape`'s "Fork A removes the fourth"
(the `(Z/2)^n`-action) is offset: Fork A trades the `(Z/2)^n` input for
the edge-map existence/degree input, so the "one fewer than the
pre-Fork-A argument" (delivered-content item 6) is not a clean reduction
in the count.

---

## §5 — Minor points (not load-bearing, recorded for completeness)

### 5.1 Proposition `prop:sphere-sgn` — the proof assumes more than the hypothesis

Proposition `prop:sphere-sgn` ("the sphere class is the sign isotype")
has hypothesis "`H*(C_n;X)` is rationally a homotopy `(n-1)`-sphere" —
which, as stated, is only a *dimension count* (`H̃^{n-1}`
one-dimensional, lower reduced cohomology zero). The proof then concludes
`≅ sgn_{S_n}` by treating the `1`-dimensional space as "the orientation
class of a sphere built `S_n`-symmetrically from `n` coordinate
directions." But the bare dimension-count hypothesis does **not** supply
that coordinate-sphere structure; a `1`-dimensional `Q[S_n]`-module is *a
priori* trivial or sign, and ruling out trivial needs the actual action,
not an analogy. The proof smuggles in the coordinate-sphere structure.

This is **not load-bearing**: Theorem `thm:contradiction` does not use
Proposition `prop:sphere-sgn`; it uses hypothesis (iii) = `Y1`-A
(Conjecture `conj:y1a`), which *directly* asserts `H̃^{n-1}(C_n;X) ≅
sgn_{S_n}`. Proposition `prop:sphere-sgn` is decorative. But its proof
should be tightened (or its hypothesis strengthened to include the
`S_n`-equivariant cell structure) so it is not mistaken for an
unconditional input. Recorded as minor.

### 5.2 The base of the induction is not addressed

Theorem `thm:y1-reduction` reduces `Y1`-A "with the smaller-ground-set
terms supplied by the simultaneous induction on `n`." Independently of
Finding A, the document never states the base case (`n = 3`, or `n = 2`)
of that induction. The pre-Fork-A treatment (`mg-56b8` §2.2) did flag the
base case as a finite check. Phase 1 is a re-foundation, not a proof, so
an un-stated base case is forgivable — but if the cofiber-LES reduction
is presented as "ported," the inductive frame it ports into should be
stated. Minor; folds into the §6.2 re-statement of Theorem
`thm:y1-reduction`.

---

## §6 — Verdict and recommendations

### 6.1 Verdict

**AMBER — FORK-A CORE SOUND; THE `Y1` REDUCTION DOES NOT PORT CLEANLY,
AND THE RESIDUAL SET IS NOT EXACTLY THREE.**

The re-foundation's spine is independently confirmed sound: `π_T` is a
genuine covariant functor (§2.1); `H*(C_n;X)` is genuinely defined with
`D² = 0` (§2.2); dropping `(Z/2)^n` genuinely dissolves Phase-1.5
refutation (b) (§2.3); the Maschke `S_n`-re-grading is correct (§2.4);
the `Y2` "standard-isotypic" over-claim was correctly caught and
withdrawn, and `R2` is honestly localized (§2.5); and the conditional
contradiction theorem is a valid conditional *given* its hypotheses. The
re-foundation is **not refuted** — RED is not warranted.

It is **not GREEN**, because the Phase-2 reviewer's core charge — confirm
`R1/R2/R3` are the genuine *and complete* residual set with no hidden
assumption and no fourth gap — fails on two counts:

- **Finding A (§3):** the `Y1`-A cofiber-LES reduction (Theorem
  `thm:y1-reduction`) is stated with a false `S_n`-equivariance claim and
  an unjustified `S_n`-isotype projection. The pre-Fork-A reduction
  worked isotype-by-isotype only because `(Z/2)^n` is abelian and has a
  quotient acting on the smaller cube `X_{n-1,x}`; `S_n` has no such
  quotient — `X_{n-1,x}` keeps only `S_{n-1} = Stab(x)` symmetry.
  Dropping `(Z/2)^n` damages the `Y1` reduction machinery, so "the
  cofiber-LES reduction ports" and "`R1` is unchanged from the
  pre-Fork-A state" are over-claims. This is a second instance of the
  exact over-claim shape the `mg-c15b` polecat caught for `Y2` — a
  Walsh-graded fact silently used as an `S_n`-graded fact — applied this
  time to `Y1` and missed.

- **Finding B (§4):** `ob(F⋆)` is defined through an edge map whose
  *existence* and *degree behaviour* the document itself (Remark
  `rem:promotion`) admits are not discharged — yet the formally stated
  residual `R3` and the conditional theorem's hypothesis (i) cover only
  *injectivity*. Edge-map existence and degree-`n-1` landing are
  load-bearing and constitute a genuine fourth open item. The
  contradiction does not rest on exactly three residuals; it rests on
  `R1`, `R2`, and an `R3` that is really three sub-residuals.

Both findings are **fixable by honest re-statement** (§6.2); neither is a
wall. The Fork A *strategy* remains the live, sound foundation `mg-565a`
endorsed — Phase 2 does not disturb that. What Phase 2 disturbs is the
Phase-1 *document's* claim to have delivered a clean three-residual
reduction.

### 6.2 Recommendations (routed to Daniel via pm-onethird)

1. **Do not yet proceed to Phase 3 (Lean).** Phase 3 is gated on Phase 2
   GREEN; Phase 2 is AMBER. The formalization-ready core named by the
   Phase-1 document (Theorems `thm:projection`, `thm:welldefined`,
   `thm:maschke`, Proposition `prop:y2a-mech`) **is** sound and would
   formalize cleanly — but Theorem `thm:y1-reduction` is in that list's
   neighbourhood and is not, and the document should be corrected before
   the Lean phase to avoid formalizing an over-claim.

2. **Revise `paper/forkA/refoundation.tex` for a Phase-1′ → Phase-2
   re-validation.** Two concrete edits, both honesty re-statements:
   - **Theorem `thm:y1-reduction`.** Replace "`S_n`-equivariant
     cohomology long exact sequence" with the correct
     "`S_{n-1,x}`-equivariant"; drop the direct `S_n`-isotype projection;
     state honestly that recovering the `S_n`-isotype structure of
     `H̃^{n-1}(C_n;X)` (needed for the `sgn_{S_n}` target) from the
     `S_{n-1}`-equivariant LES requires an induction–restriction
     (Frobenius reciprocity / branching) step that Phase 1 does not
     carry out. Record this as a genuine *new* sub-residual of `R1`
     created by the `(Z/2)^n → S_n` re-grading — the `Y1`-side mirror of
     what §7.2 already does honestly for `R2`. Correct the scorecard and
     delivered-content list accordingly ("`R1` unchanged" → "`R1`'s
     target object unchanged; its reduction acquires an `S_{n-1}→S_n`
     step").
   - **Residual `R3`.** Re-state Owed debt `debt:faithful-localized` and
     Theorem `thm:contradiction` hypothesis (i) to match Remark
     `rem:promotion`: `R3` = edge-map *existence* + *degree-`n-1`
     landing* + *injectivity* (three sub-points). Either re-label the
     residual set as "`R1`, `R2`, `R3a/R3b/R3c`" or state plainly that
     `R3` is a three-part faithfulness debt. Drop or qualify the "exactly
     three / Fork A removes the fourth" framing.
   With those two edits the document would honestly describe what Phase 1
   delivered, and a re-validation could return GREEN.

3. **The `R1`/`R2`/`R3` residual-closing work can still be scoped now**,
   but with the corrected picture: `R1` carries an added `S_{n-1}→S_n`
   representation-theory step; `R3` is three sub-problems. The
   recommendation in the Phase-1 document to attack `R2` and `R3`
   together (both faithfulness-flavoured) stands and is reinforced by
   Finding B — edge-map existence/degree is genuinely upstream of
   injectivity.

4. **`paper/main.tex` stays as-is** (it honestly records the pre-Fork-A
   state) — unchanged from the Phase-1 recommendation.

### 6.3 The honest one-paragraph verdict

Independent Phase-2 validation confirms the spine of the Fork A
re-foundation: the trace projection `π_T` is a genuine covariant functor,
the covariant homotopy colimit `H*(C_n;X)` is genuinely defined with
`D² = 0`, dropping the `(Z/2)^n`-action genuinely dissolves the Phase-1.5
`(Z/2)^n` refutation, the Maschke `S_n`-re-grading is correct, and the
conditional contradiction theorem is a valid conditional — so the
re-foundation is sound as a framework and is not refuted. But the
document is not GREEN: two over-claims survive into the submitted draft
that the `mg-c15b` self-audit did not catch. First, the `Y1`-A
cofiber-LES reduction is asserted to "port" to Fork A and `R1` to be
"unchanged," when in fact the reduction is stated with a false
`S_n`-equivariance claim — the smaller object `X_{n-1,x}` keeps only
`S_{n-1} = Stab(x)` symmetry, and the pre-Fork-A reduction split
isotype-by-isotype only because the *abelian* `(Z/2)^n` has a quotient
acting on the smaller cube, a feature `S_n` lacks, so dropping `(Z/2)^n`
damages the `Y1` reduction exactly as it re-opens `Y2`, and only the
latter is recorded. Second, the obstruction class `ob(F⋆)` is defined
through an edge map whose existence and degree-`n-1` behaviour the
document itself admits are not discharged, yet the formal residual `R3`
and the conditional theorem's hypotheses name only injectivity — so the
contradiction does not rest on exactly three residuals but on `R1`, `R2`,
and a three-part `R3`. Both findings are fixable by honest re-statement
and neither is a wall; the verdict is **AMBER** — the Fork A strategy and
its core constructions are sound, but the Phase-1 document over-states
what it delivered and must be corrected before Phase 3.

### 6.4 Cross-references

- **Brief:** `mg-d300` (Frankl-ForkA-Phase2). **Routes to:** Daniel, via
  `pm-onethird`.
- **Deliverable validated:** `paper/forkA/refoundation.tex` (`mg-c15b`,
  Phase 1).
- **Phase-1 ledger note:** `docs/Frankl-ForkA-Refound-LaTeX.md` (`mg-c15b`).
- **Fork A endorsement / the two debts:** `docs/Frankl-ForkD-Probe-n3.md`
  (`mg-565a`).
- **The drift diagnosis / fork menu:** `docs/Frankl-vision-check.md`
  (`mg-6edc`).
- **The Phase-1.5 refutations / the pinned projection `π_T` / the
  `(Z/2)^n`-on-`X_{n-1,x}` factoring:**
  `docs/Frankl-Y1-phase1.5-bk-structure-maps.md` (`mg-0405`).
- **The pre-Fork-A cofiber-LES reduction of `Y1` — the
  `(Z/2)^n`-equivariant LES split (§3.1) and the twisted-bridge
  `χ_S`-support restriction (§8.1):** `docs/Frankl-Y1-reprove.md`
  (`mg-56b8`).
- **Onboarding:** `docs/PROOF-STRUCTURE-ONBOARDING.md`.

---

*Phase-2 independent validation by polecat `cat-mg-d300`. Deliverable on
`main`: this document. Verdict: **AMBER — FORK-A CORE SOUND; THE `Y1`
REDUCTION DOES NOT PORT CLEANLY, AND THE RESIDUAL SET IS NOT EXACTLY
THREE.** The Fork A re-foundation's spine is independently confirmed
sound — `π_T` a genuine covariant functor, `H*(C_n;X)` genuinely defined
with `D²=0`, the `(Z/2)^n` dissolution genuine, the Maschke `S_n`
re-grading correct, the conditional theorem a valid conditional — and the
re-foundation is not refuted. But two over-claims survive that the
`mg-c15b` self-audit did not catch: (A) the `Y1`-A cofiber-LES reduction
(Theorem `thm:y1-reduction`) falsely claims `S_n`-equivariance of the
pair `(X_n,X_{n-1,x})` — the smaller object keeps only `S_{n-1}=Stab(x)`
symmetry, the pre-Fork-A reduction split isotype-by-isotype only via the
abelian-quotient structure of `(Z/2)^n` that `S_n` lacks, so "`R1`
unchanged / the reduction ports" is an over-claim; (B) `ob(F⋆)` is
defined through an edge map whose existence and degree-`n-1` behaviour the
document admits are un-discharged, but the formal `R3` and the conditional
theorem name only injectivity, so the contradiction rests not on exactly
three residuals but on `R1`, `R2`, and a three-part `R3`. Both are fixable
by honest re-statement; recommended next: revise `refoundation.tex` per
§6.2, then re-validate before Phase 3 (Lean).*
