# Frankl-ForkA-Residuals-Roadmap — scoping the residual-closing arc

**Work item:** `mg-0882` (Frankl-ForkA-Residuals-Scoping). Per the
`mg-bf5c` GREEN: the Fork A Phase-2 hardening arc is **RESOLVED**. The
Fork A re-foundation (`paper/forkA/refoundation.tex`) is certified
sound and honestly stated — the conditional Frankl theorem
`thm:contradiction` rests on exactly **seven named open residuals**,
no hidden assumptions and no further prong. **Closing those seven
residuals is the Frankl proof.** This document scopes that arc before
execution tickets are filed.

**READ-FIRST consumed:** `paper/forkA/refoundation.tex` (the
twice-revised, thrice-validated re-foundation, all 2281 lines);
`docs/Frankl-ForkA-Phase2-Revalidation2.md` (`mg-bf5c` — the certified
residual list); `docs/Frankl-ForkA-Phase2-Revision2.md` (`mg-894c` —
the exhaustive Walsh-fact sweep, §2.2 the W1–W11 ledger);
`docs/Frankl-ForkA-Refound-LaTeX.md` (`mg-c15b` — the Phase-1 ledger);
`docs/Frankl-Y1-reprove.md` (`mg-56b8` — the cofiber-LES reduction,
the source and the difficulty estimate of R1a);
`docs/Frankl-ForkD-Probe-n3.md` (`mg-565a` — the Fork A endorsement,
the two owed debts, the wrapper-risk).

**Deliverable:** this document. `pm-onethird` files the per-residual
execution tickets per §6 and relays to Daniel. Deliverable lands on
`main` (no branch override).

**This is a scoping document, not a validation and not a closure.** It
does not attempt, prove, or refute any residual. It estimates
difficulty, assigns budgets, maps dependencies, identifies the
make-or-break residual(s), proposes a sequencing, and honestly flags
the RED-risk.

---

## §0 — Roadmap summary (top of page)

### 0.1 Headline

> **THE ARC HAS ONE PREREQUISITE, SEVEN RESIDUALS, AND ONE
> MAKE-OR-BREAK GATE. ATTACK THE GATE FIRST.**
>
> The seven residuals are **not** uniform in difficulty or in risk.
> They split cleanly:
>
> - **One shared prerequisite (P0)** — pinning the cell-level spectral
>   sequence of the obstruction sheaf `F_obs` — gates *every* residual
>   and is not itself one of the seven (`rem:holim-prereq`: "a
>   computation reported on un-pinned `F_obs`-foundations would repeat
>   the Phase-1.5 failure mode and must not be attempted before the
>   pinning").
>
> - **A faithfulness cluster {R3a, R3b, R3c, R2}** — bounded
>   homological algebra (R3a, R3b) plus the genuine wrapper-risk
>   (R3c injectivity, R2 landing). **This cluster is where the Frankl
>   proof can die.** If the Čech-to-cohomology edge map is not
>   injective (R3c), or the obstruction class carries a
>   `sgn`-component (R2), the contradiction is hollow and Fork A
>   fails — regardless of how much work goes into R1. It is
>   comparatively cheap to probe. **It must be attacked first
>   (fail-fast).**
>
> - **A vanishing arc {R1c, R1a, R1b}** — the re-graded sphere
>   concentration. R1a is the genuine hard core — the stuck-fibre
>   homotopy-colimit computation, multi-week-**plus**, plausibly
>   multi-month; the single largest budget sink in the entire Frankl
>   program. R1c and R1b are representation-theoretic reconciliations
>   forced by the `(Z/2)^n → S_n` re-grading. **None of the three is
>   expected to refute Fork A** (R1a is "true-but-unproven" UC10.1
>   content); they are a budget wall, not a viability wall.
>
> **The make-or-break residual is R3c** (edge-map injectivity), with
> **R2** (the `Y2` landing) the second viability risk. Both are facets
> of one underlying faithfulness question (`rem:r2-faithful`). The
> roadmap therefore gates the multi-month R1a budget behind a
> faithfulness checkpoint: do the cheap viability-critical work first,
> so that if Fork A is going to die, it dies early and cheap.

### 0.2 The seven residuals at a glance

| Residual | What it is | Difficulty | RED-risk | Budget (tokens / tickets) | Depends on |
|---|---|---|---|---|---|
| **P0** *(prerequisite, not one of the 7)* | pin the cell-level BK / spectral-sequence model of `F_obs` | bounded-substantial | low | ~400–600k · 1–2 tickets | — |
| **R3a** | the Čech-to-cohomology edge map **exists** | bounded | low | ~300–400k · 1 ticket | P0 |
| **R3b** | that edge map lands in **degree `n-1`** | bounded | low–moderate | ~300k · 1 ticket | P0, R3a |
| **R3c** | that edge map is **injective** (faithfulness) | definite question; full proof genuine-open | **HIGH** | ~300k probe + open-ended | P0, R3a, R3b |
| **R2** | `ob(F⋆)` has **no `sgn` component** (the `Y2` landing) | multi-week | **HIGH** | ~700k–1M · 2–3 tickets | P0 |
| **R1c** | the twisted-bridge null-homotopy `ι_x* ≃ 0` | multi-week | low | ~600–700k · 2 tickets | P0 |
| **R1a** | `S_{n-1}`-isotype cohomology of the matched-cylinder cofiber — the stuck-fibre homotopy type | **multi-week-plus / genuine open** | low | multi-month · ≥1.5–2M · ≥4–8 tickets | P0 |
| **R1b** | the `S_{n-1} → S_n` branching step | multi-week | moderate | ~600–900k · 2–3 tickets | R1a, R1c |

*RED-risk* = the probability the residual delivers a verdict that
**kills the Fork A strategy** (not the probability it is merely hard).
"HIGH" means a RED here is a genuine, pre-identified possible outcome.

### 0.3 What "closing the seven residuals" means

`thm:contradiction` is a genuine conditional theorem: *assume the five
inputs (i)–(v) — R3a, R3b, R3c, R2, R1 = R1a+R1b+R1c — then there is no
minimal counterexample to Frankl on `[n]`, hence Frankl holds on
`[n]`.* The proof of the conditional theorem is complete and was
independently re-confirmed sound three times (`mg-d300`, `mg-5221`,
`mg-bf5c`). Therefore:

> **Closing all seven residuals (after P0) discharges every hypothesis
> of `thm:contradiction`, which then proves Frankl unconditionally for
> all `n ≥ 3`.** Phase 3 (Lean formalization of the spine, then of the
> closed residuals) is the separate, downstream, mechanical step.

There is no eighth input and no hidden assumption: the `mg-894c`
exhaustive Walsh-fact sweep and the `mg-bf5c` independent re-derivation
of the enumeration certified the input list complete and final.

---

## §1 — Scope, method, the prerequisite

### 1.1 The charge

`mg-0882` asks for a residual-closing roadmap: (1) per-residual
difficulty, budget, and inter-dependencies; (2) the make-or-break
residual(s), so the arc can attack highest-risk-first; (3) a proposed
sequencing with checkpoints; (4) an honest flag on any residual that
looks like a genuine open research problem unlikely to close. A RED on
a residual down the line is an allowed and important outcome; this
scoping pre-identifies that risk.

**Method.** Each residual was read at its definition site in
`refoundation.tex` (`res:y1` R1a/R1b/R1c, `res:y2` R2,
`debt:faithful-localized` R3a/R3b/R3c, `thm:y1-reduction`,
`thm:contradiction`, and the supporting Remarks `rem:y1-branching`,
`rem:bridge-not-ported`, `rem:promotion`, `rem:wrapper`,
`rem:r2-faithful`, `rem:holim-prereq`). The pre-Fork-A difficulty
evidence for R1a was taken from `mg-56b8` (the cofiber-LES reduction,
which isolated exactly this residual and estimated it "plausibly
multi-week," "the genuine stuck-family core … not a one-session
closure"). The faithfulness / wrapper-risk evidence for R2 and R3c was
taken from `mg-565a` §6.3 ("the deepest open question") and
`rem:wrapper`. Difficulty bands and budgets are estimates, deliberately
conservative; the scoping's job is to be honest about uncertainty, not
precise about it.

### 1.2 The conditional theorem and its seven inputs

`thm:contradiction` assumes, for `n ≥ 3`, five inputs; input (v)/R1 is
itself three-part, giving seven residuals total:

- **(i) R3a** — the Čech-to-cohomology edge map of `def:ob` *exists*,
  so `ob(F⋆)` is a genuine element of `H^*(C_n;X)`.
- **(ii) R3b** — that edge map carries the mismatch class into total
  *degree `n-1`*, so `ob(F⋆) ∈ H̃^{n-1}(C_n;X)` specifically.
- **(iii) R3c** — that edge map is *injective* on the class of the
  mismatch cocycle.
- **(iv) R2** — `ob(F⋆)` has *no `sgn_{S_n}` component* in
  `H̃^{n-1}(C_n;X)`.
- **(v) R1** — `Y1`-A holds (`conj:y1a`: `H̃^{n-1}(C_n;X) ≅ sgn_{S_n}`,
  all other isotypes vanish), which by `thm:y1-reduction` rests on:
  - **R1a** — the cofiber / stuck-fibre homotopy type;
  - **R1b** — the `S_{n-1} → S_n` branching step;
  - **R1c** — the twisted-bridge null-homotopy `ι_x* ≃ 0`.

Each input is used exactly once in the proof of `thm:contradiction`;
the proof is otherwise elementary. The seven residuals are the entire
remaining content of the Frankl proof.

### 1.3 Checkpoint 0 — the `F_obs` cell-level spectral sequence (the shared prerequisite P0)

`rem:holim-prereq` names a foundational prerequisite that is **not one
of the seven residuals** but gates all of them:

> *"Pinning the edge map to the precision R3 needs requires the
> cell-level Bousfield–Kan model of `C_n`: the projection `π_T` at
> cell level (supplied — `thm:projection`) and the cell-level
> structure of `F_obs` and its spectral sequence (not pinned here).
> Fork A discharges the harder half … and leaves the spectral sequence
> of `F_obs` for the residual-attack phase. A computation reported on
> un-pinned `F_obs`-foundations would repeat the Phase-1.5 failure mode
> and **must not** be attempted before the pinning."*

**P0 is therefore a mandatory checkpoint-0 ticket.** It pins:

- the cell-level structure of the obstruction sheaf `F_obs` on the
  punctured trace poset `C_n(F⋆) ∖ {F⋆}` (`def:obs-sheaf`);
- the Čech double complex `Č^{*,*}(𝔘; F_obs)` and its spectral
  sequence `E_2^{p,q} = Č^p(𝔘; ℋ^q(F_obs))`;
- the cell-level Bousfield–Kan model of `H^*(C_n;X)` against which the
  edge map (R3a–R3c) is to be compared.

P0 is bounded-substantial: it is a construction, not an open problem;
it has no RED-risk (it cannot refute Fork A, only equip it). But it is
load-bearing, and **`mg-565a`'s explicit warning means no R1a/R2/R3
attack ticket may be dispatched before P0 returns GREEN.** The one
permitted exception is a deliberately bounded, from-scratch
faithfulness probe (§5.2, Phase 1) computed directly at small `n` —
the same discipline `mg-565a` itself used.

---

## §2 — Per-residual assessment

### 2.1 R1a — the cofiber / stuck-fibre homotopy type

**Statement.** Control the `S_{n-1}`-isotype cohomology of the homotopy
cofiber of the matched-cylinder inclusion `X(D_x) ↪ X_n` — equivalently
(after stripping the contractible cylinder) the cohomology of the bar
strings of `C_n` that *exit* the matched subcategory `D_x`, the
comma-category twist `N(ρ_x / −)` of the trace functor: the homotopy
type of the stuck-family fibres. Includes the simultaneous induction on
`n` (based at the finite check `n = 2`) and the delicate `|S| = n-1`
sub-case where the smaller-ground-set term meets the sphere class.

**Difficulty: multi-week-plus / genuine open content.** This is the
hard core of the entire Frankl homological program. `mg-56b8` —
which isolated exactly this object — is unambiguous: it is *"a real
homotopy-colimit computation over the comma categories of the trace
functor … the program has never computed the homotopy type of these
fibres,"* it admits *"no degree/dimension truncation, no inductive
kill, no cofinality collapse,"* and it is *"plausibly multi-week … not
a one-session closure and not a 'verify a hypothesis' residual."* The
`mg-56b8` §5 analysis showed both tempting shortcuts past it (a
per-object chain isomorphism; naïve family-by-family relative
vanishing) are **false**, by one mechanism — *a hocolim does not
localize to a subcategory*. R1a must be genuinely *computed*.

**RED-risk: low.** R1a is the residual least likely to refute Fork A.
The statement (`V_S^k = 0` for `S ⊊ [n]`, `k ≥ 1`, the re-graded
sphere concentration) is plausibly true — it is UC10.1 content,
`mg-56b8` calls it *"true-but-unproven."* The risk on R1a is **budget
and schedule**, not viability.

**Budget.** The largest in the program: realistically multi-month,
≥ 1.5–2M tokens cumulative, ≥ 4–8 execution tickets. It will need its
own sub-scoping pass once P0 is in hand (concrete entry points per
`mg-56b8` §9.4: compute the comma categories `ρ_x/(T,𝓖)` and their
nerves; do `n = 3, S = {1}` by hand first; use the `|S| = n-1`
sphere-class collision as the falsification test for wrong attempts).

**Dependencies.** Depends on **P0**. *Independent of R1b and R1c* — it
is the standalone cofiber computation. (Note for the `mg-0882` brief's
explicit question "do R1b and R1c feed R1a": **no.** R1a feeds R1b;
R1c is parallel to R1a, neither computing the other — see §3.)

### 2.2 R1b — the `S_{n-1} → S_n` branching step

**Statement.** Recover the `S_n`-isotype structure of
`H̃^{n-1}(C_n;X)` — in particular whether it is the single `sgn_{S_n}`
isotype — from the `S_{n-1}`-equivariant cofiber data that
`thm:y1-reduction` delivers. New under Fork A: `Stab(x) ≅ S_{n-1}` is a
*subgroup* of `S_n`, not a *quotient*, so unlike the abelian
`(Z/2)^n` the re-grading gives no descent and the LES is only
`S_{n-1}`-equivariant.

**Difficulty: multi-week.** Representation theory of the symmetric
group. The genuine subtlety, stated honestly in `rem:y1-branching`:
the branching step is **lossy** — `sgn_{S_{n-1}} = Res^{S_n}_{S_{n-1}}
sgn_{S_n}`, but by the branching rule `sgn_{S_{n-1}}` is *also* a
constituent of the restriction of other `S_n`-irreducibles, so an
`S_{n-1}`-isotype computation does **not** by itself pin the
`S_n`-isotype decomposition. R1b is therefore not "do the branching" —
it is "find enough additional `S_n`-equivariant information to pin the
decomposition." That extra information must come from the
`S_n`-equivariance of the *family* `{ι_x}_{x∈[n]}` (a permutation
carries `ι_x` to `ι_{π(x)}`), assembled across all `x`.

**RED-risk: moderate.** If the cross-`x` assembly genuinely cannot pin
the `sgn_{S_n}`-content, R1a + R1b would fail to deliver `conj:y1a`
even with R1a fully computed. This is a real, if secondary, viability
concern — distinct from the faithfulness cluster's.

**Budget.** ~600–900k tokens, 2–3 execution tickets.

**Dependencies.** Depends on **R1a** (it consumes R1a's
`S_{n-1}`-isotype cofiber cohomology) and, transitively, on **R1c**
(the reduction that produces that data substitutes `ι_x* ≃ 0`). R1b is
the genuine downstream residual of the vanishing arc. May share
representation-theoretic machinery with **R1c** (§3).

### 2.3 R1c — the twisted-bridge null-homotopy

**Statement.** Establish `ι_x* ≃ 0` — the twisted-bridge null-homotopy
that `thm:y1-reduction`(2) substitutes to collapse the cofiber LES into
a short exact sequence — as a genuine Fork A input. The pre-Fork-A
twisted-bridge identity established it only on the `χ_S`-isotype
sub-complexes `V_S^*`; Fork A, having dropped the `(Z/2)^n`-action, has
no `V_S^*` sub-complex, and `d` does not preserve harmonic level, so
the ported bridge does not discharge it (`rem:bridge-not-ported`).

**Difficulty: multi-week.** Two candidate routes, both
representation-theoretic: (a) a Fork-A-native re-derivation of the
null-homotopy directly on the defect complex; (b) an explicit
`χ_S`-to-`S_{n-1}` grading reconciliation — carry the `χ_S`-grading
along and reconcile it with the `S_{n-1}`-grading of the cofiber LES.
Route (b) is a second representation-theoretic reconciliation beside
R1b and is the more likely to succeed cleanly.

**RED-risk: low.** `rem:bridge-not-ported` is explicit: *"This is not a
refutation. `ι_x* ≃ 0` may well be true in the Fork A setting; it is
simply not discharged by the ported twisted bridge."* R1c is a
re-derivation debt, not a viability risk.

**Budget.** ~600–700k tokens, 2 execution tickets.

**Dependencies.** Depends on **P0**. *Independent of R1a* (neither
computes the other; both are inputs to `thm:y1-reduction`). Likely to
**share machinery with R1b** — both are `χ_S ↔ S_{n-1}` reconciliations
forced by the same `(Z/2)^n → S_n` re-grading; a unified
representation-theoretic toolkit ticket may serve both.

### 2.4 R2 — the `Y2` landing

**Statement.** `ob(F⋆)` has no `sgn_{S_n}`-component in
`H̃^{n-1}(C_n;X)` — equivalently, the level-1-harmonic obstruction
class is not cohomologous to a nonzero multiple of the top-harmonic
sphere class. Re-opened by the `(Z/2)^n` drop: the pre-Fork-A `Y2` got
the separation free from the Walsh-level grading of cohomology (`ob` at
level 1, sphere at level `n`); Fork A drops Walsh level as a grading,
so the separation must be re-derived.

**Difficulty: multi-week.** `res:y2` gives a concrete reduction: by
`prop:y2a-mech`(1) and Maschke, `ob(F⋆)` lies in the image of an
`S_n`-equivariant map out of `im Č-δ^0`, so its `S_n`-isotype content
is contained in that of `im Č-δ^0 ⊆ Č^{1,*}`; whether that image
contains the `sgn_{S_n}` isotype is, *by Frobenius reciprocity for the
cover indexed by `[n]`*, the question of whether the coefficient
`F_obs^q(U_x)` carries the relevant sign character of the point
stabiliser `S_{n-1}`. So R2 is a definite representation-theoretic
question about the fine structure of `F_obs^q` — tractable once P0
pins that structure, but a genuine computation.

**RED-risk: HIGH.** R2 is faithfulness-flavoured (`rem:r2-faithful`):
*"if `ob` had a `sgn`-component it would be partly the family-blind
orientation class, which is the precise shape of the wrapper-risk."*
If R2 is **false** — if `ob(F⋆)` genuinely carries a
`sgn`-component — `thm:contradiction` cannot close and Fork A fails.
The over-claim history compounds the concern: the Phase-1 self-audit
(`mg-c15b`) had to *withdraw* a clean "`ob` is standard-isotypic, hence
`sgn`-free" theorem here — the team has already been wrong about R2
once, in the optimistic direction.

**Budget.** ~700k–1M tokens, 2–3 execution tickets. Cheaper than R1a;
should be attacked *before* R1a (§5).

**Dependencies.** Depends on **P0** (the fine structure of
`F_obs^q`). Independent of the R1 arc. **Facet of one faithfulness
question with R3** (`rem:r2-faithful`: *"a later phase may find them
inter-reducible"*) — should be attacked *together with* R3
(`refoundation.tex` recommendation 3); a representation-theoretic
analysis of `F_obs` feeds both.

### 2.5 R3a — the obstruction edge-map existence

**Statement.** The promotion of the mismatch cocycle through the
Čech-to-cohomology spectral sequence into `H^*(C_n;X)` is a *defined
map*. Not automatic: the Čech double complex lives on the punctured
trace poset `C_n(F⋆) ∖ {F⋆}`, while `H^*(C_n;X)` is the cohomology of
the *whole* category `C_n`; the comparison map between the two is not
constructed in Phase 1. R3a also subsumes the punctured-poset-to-`F⋆`
extension that `prop:fact-one`'s proof performs.

**Difficulty: bounded.** A definite, scoped piece of homological
algebra: construct the comparison map once the cell-level models
(P0 + `thm:projection`) are in hand. `rem:wrapper` frames the whole of
R3 as *"a small, checkable package of homological-algebra statements
about one edge map."*

**RED-risk: low.** A construction; it equips the proof, it does not
refute it. (If the map genuinely cannot be constructed, that would be a
problem — but the spectral-sequence edge map is a standard object once
the two complexes are pinned.)

**Budget.** ~300–400k tokens, 1 execution ticket.

**Dependencies.** Depends on **P0**. Independent of R1, R2.

### 2.6 R3b — the obstruction edge-map degree behaviour

**Statement.** The edge map carries the mismatch class — which sits in
Čech degree `p = 1` — into *total degree `n-1`*, so that `ob(F⋆) ∈
H̃^{n-1}(C_n;X)` specifically, the degree where R1 (sphere
concentration) bites. Phase 1 only *inherits* the degree count `n-1`
from the now-defunct pre-Fork-A object `X^∩_n`; it is not re-verified
in the genuinely different Fork A object.

**Difficulty: bounded.** A degree-bookkeeping computation in the pinned
Fork A spectral sequence. Bounded once R3a constructs the map and P0
pins the bigrading.

**RED-risk: low–moderate.** Most likely the degree is indeed `n-1`.
But it is a genuine re-verification, not a re-label: if the Fork A
object places the class in a *different* degree, R1 (which is stated in
degree `n-1`) would not apply to it and the contradiction's geometry
would need re-work. Lower risk than R3c/R2, non-zero.

**Budget.** ~300k tokens, 1 execution ticket.

**Dependencies.** Depends on **P0** and **R3a** (the map must exist
before its degree can be asked).

### 2.7 R3c — the obstruction edge-map injectivity

**Statement.** The edge map `Č H^1(𝔘; F_obs) → H̃^{n-1}(C_n;X)` is
*injective* on the class of the mismatch cocycle: if `ob(F⋆) = 0` in
`H̃^{n-1}(C_n;X)`, then `{m_xy}` is the Čech coboundary of a *global*
section of `F_obs`. This is the original faithfulness statement — the
promotion of the obstruction from Čech `H^1` into the cohomology of the
category loses no information.

**Difficulty: a definite yes/no question; the full proof is
genuine-open.** R3c is not "long" in the way R1a is — it is a definite
property of one map. But the *answer* is genuinely open, and a full
proof of injectivity for all `n` is an open research problem. A bounded
structural probe at small `n` (§5.2) can *falsify* it cheaply; proving
it cannot be estimated until P0 + R3a + R3b are in hand.

**RED-risk: HIGH — this is the make-or-break residual.** `rem:wrapper`
states it without hedge: *"If that injectivity holds, the equivalence
'`ob = 0 ⟺` a global rare-coordinate section exists' is genuine and the
cohomology genuinely detects the counterexample (`V_3` satisfied). **If
it fails, `ob` is family-blind and the contradiction is hollow.**"*
`mg-565a` §6.3 calls faithfulness *"the deepest open question"* of the
whole Fork A program. R3c is the precise localization of the
standing **wrapper-risk** — the risk that the cohomology detects
nothing and the entire two-part contradiction is vacuous. **A RED on
R3c kills Fork A.**

**Budget.** ~300k tokens for the bounded falsification probe and the
post-P0 assessment; the full injectivity proof is open-ended (1+
further tickets, or genuine-open, depending on what the probe and
the pinned spectral sequence reveal).

**Dependencies.** Depends on **P0**, **R3a**, **R3b** (without an edge
map that exists and lands in degree `n-1`, `ob(F⋆)` is not a
well-defined element and R3c has no subject). Facet of one faithfulness
question with **R2**.

---

## §3 — The dependency graph

```
                          ┌─────────────────────────────┐
                          │  P0  — pin F_obs cell-level  │   (Checkpoint 0)
                          │       spectral sequence      │
                          └───────────────┬─────────────┘
                                          │  gates everything below
            ┌─────────────────┬───────────┼───────────────┬─────────────┐
            ▼                 ▼           ▼                ▼             ▼
        ┌───────┐         ┌───────┐   ┌───────┐        ┌───────┐     ┌───────┐
        │  R3a  │────────▶│  R3b  │──▶│  R3c  │        │  R2   │     │  R1c  │
        │ exist │         │ degree│   │ INJ.  │◀┄┄┄┄┄┄▶│landing│     │bridge │
        └───────┘         └───────┘   └───┬───┘ facets └───┬───┘     └───┬───┘
                                          │   of one       │            │
              FAITHFULNESS CLUSTER  ◀──────┴── faithfulness─┘            │
              (Checkpoint 1 — the make-or-break gate)        question    │
                                                                        │
        ┌───────┐                                                       │
        │  R1a  │  (the stuck-fibre cofiber — multi-month)               │
        │ cofib │───────────────┐                                       │
        └───────┘               │  R1a output + R1c null-homotopy       │
                                ▼          feed                         │
                            ┌───────┐                                   │
                            │  R1b  │◀──────────────────────────────────┘
                            │branch │   (shared rep-theory machinery R1c↔R1b)
                            └───┬───┘
                                ▼
                    conj:y1a  (= input (v)/R1)
                                │
        R3a+R3b+R3c, R2, R1 ─────┴────▶  thm:contradiction  ⟹  Frankl
```

**Edges, stated precisely:**

- **P0 → everything.** No residual-attack computation may begin before
  P0 returns GREEN (`rem:holim-prereq`).
- **R3a → R3b → R3c** is a strict chain: the map must *exist* before
  its *degree* can be asked, and must exist and land in degree `n-1`
  before its *injectivity* has a subject.
- **R2 ⇄ R3c** are facets of one faithfulness question
  (`rem:r2-faithful`); not a hard dependency, but they share the
  representation theory of `F_obs` and should be co-attacked.
- **R1c ∥ R1a** — independent; neither computes the other. Both are
  inputs to `thm:y1-reduction`.
- **R1a → R1b** and **R1c → R1b** — R1b consumes the
  `S_{n-1}`-isotype cofiber cohomology that the reduction produces from
  R1a, and that reduction substitutes R1c's null-homotopy. R1b is
  downstream of both.
- **R1c ⋯ R1b** (soft) — likely shared representation-theoretic
  machinery (both are `χ_S ↔ S_{n-1}` reconciliations).
- **R1 arc ∥ faithfulness cluster** — logically independent
  (`refoundation.tex` recommendation 2 confirms R1 and R3 *can* be
  attacked in parallel). The roadmap nonetheless *sequences* them —
  see §4, §5.

**The brief's explicit question — "do R1b and R1c feed R1a; does R2
depend on anything":**

- **R1b and R1c do not feed R1a.** R1a is the standalone cofiber
  computation. The flow is the reverse: R1a feeds R1b. R1c is parallel
  to R1a.
- **R2 depends only on P0** (the fine structure of `F_obs^q`). It is
  independent of the entire R1 arc; it is coupled to R3 only as a
  shared faithfulness question, not as a hard prerequisite.

---

## §4 — Make-or-break: where the proof can die

### 4.1 Two kinds of wall

The seven residuals contain two structurally different kinds of
"wall," and conflating them would mis-sequence the arc:

- **A viability wall** — a residual that can return a verdict killing
  the Fork A strategy outright. A RED here means the conditional
  theorem `thm:contradiction` can never be discharged; Frankl is not
  provable *by this route*.
- **A budget wall** — a residual so large it dominates the schedule
  but is not expected to refute anything. A "RED" here would only ever
  be "we ran out of budget," not "the strategy is wrong."

Fail-fast discipline is about the **viability walls**: find out whether
Fork A can work *before* committing the budget wall's multi-month cost.

### 4.2 R3c — the make-or-break residual

**R3c (edge-map injectivity) is the make-or-break residual.** It is the
precise localization of the **wrapper-risk** — the standing concern,
carried unbroken from the pre-Fork-A development through `mg-565a` and
into `rem:wrapper`, that the obstruction class is *family-blind*: that
`Y1`-A uses only the shape of the Čech double complex and never the
counterexample hypothesis, so that the cohomology detects nothing and
the two-part contradiction is hollow. `rem:wrapper` makes R3c the
single statement on which this hangs: injective ⟹ the cohomology
genuinely detects the counterexample (`V_3` satisfied); not injective
⟹ `ob` is family-blind and the contradiction is hollow. `mg-565a` §6.3
independently names faithfulness *"the deepest open question"* and §7.1
rec 5 *"the real theorem is still clause `(V_3)`."*

A RED on R3c is a genuine, pre-identified possible outcome. It would
not be a failure of the roadmap — it would be the roadmap working: the
cheap discovery that Fork A's obstruction theory is not faithful, made
*before* the multi-month R1a budget was spent.

### 4.3 R2 — the second viability risk

**R2 (the `Y2` landing) is the second make-or-break residual.** It is
faithfulness-flavoured by the same mechanism (`rem:r2-faithful`: a
`sgn`-component of `ob` would be "partly the family-blind orientation
class — a faithfulness failure of exactly the wrapper-risk shape").
If R2 is false, `thm:contradiction` cannot close. And the team has
already over-claimed here once: the Phase-1 self-audit had to withdraw
a clean "`ob` is standard-isotypic, hence `sgn`-free" landing theorem
(`status:y2a`) — meaning the optimistic answer to R2 has been asserted
and retracted before. That history raises, not lowers, the RED-risk.

R2 and R3c together are **the faithfulness cluster** — facets of one
question (does the cohomology separate the family-specific obstruction
from the family-blind orientation class). Treat them as a single
make-or-break gate.

### 4.4 R1a — the budget wall, not a viability wall

**R1a is the budget wall.** It is the largest single piece of work in
the Frankl program — multi-week-plus, plausibly multi-month — but it is
**not** a viability wall: the statement is plausibly true
(`mg-56b8`: "true-but-unproven," UC10.1 content), so R1a is not
expected to refute Fork A. The danger R1a poses is *schedule and
budget*: committing its multi-month cost before the faithfulness
cluster is settled risks discovering, after months of work on R1a,
that R3c was non-injective all along and the whole effort was on a
hollow contradiction.

This is exactly the asymmetry the sequencing in §5 exploits.

### 4.5 The honest RED-risk flag

Per the `mg-0882` brief's point 4 — honestly flag any residual that
looks like a genuine open research problem unlikely to close:

- **R3c is the residual most likely to deliver a strategy-killing
  RED.** The wrapper-risk is real, long-standing, and unresolved by
  three rounds of Fork A validation — every one of which was careful to
  say the validations certify *honesty*, not *closure*
  (`mg-bf5c` §0.3). R3c could genuinely be false. If it is, Fork A is
  dead and the cohomological route to Frankl is closed. This is a
  permitted and important outcome; the arc must be built to surface it
  early.

- **R2 is the second genuine RED candidate**, by the same faithfulness
  mechanism, with the added warning sign that the optimistic answer has
  already been over-claimed and withdrawn once.

- **R1a is a genuine open research problem in the difficulty sense** —
  the stuck-fibre homotopy type has never been computed and admits no
  shortcut — but it is *not* "unlikely to close": it is unlikely to
  *refute*. Its risk is that it does not close *within any bounded
  budget*. The honest flag on R1a is: it may be multi-month, it may
  need its own scoping pass and its own sequence of sub-tickets, and
  the arc should not pretend otherwise.

- **R1b carries a moderate, secondary RED-risk**: the branching step is
  lossy, and if the cross-`x` `S_n`-equivariant assembly cannot pin the
  `sgn_{S_n}`-content, `conj:y1a` would not follow even from a fully
  computed R1a. Lower probability than the faithfulness cluster, but
  pre-identified here.

- **P0, R3a, R3b, R1c** are low-risk: constructions and re-derivations,
  expected to close with bounded effort.

---

## §5 — Sequencing: the residual-closing arc

### 5.1 The fail-fast principle applied

`refoundation.tex` recommendation 2 observes that R1 and R3 *can* be
attacked in parallel (they are logically independent). The fail-fast
mandate of `mg-0882` says they *should not be started* in parallel:
the cheap, viability-critical faithfulness cluster must come first, and
the multi-month R1a budget must be **gated** behind it. The roadmap's
core sequencing recommendation:

> **Do not commit the R1a (and R1b) budget until the faithfulness
> cluster has passed a checkpoint. If Frankl is going to die on a
> residual, it dies in the faithfulness cluster — find that out cheap.**

This deliberately deviates from "attack R1 and R3 in parallel": the
deviation is the value the scoping adds.

### 5.2 The phases and checkpoints

**Phase 0 — the prerequisite. (Checkpoint 0.)**
Ticket: **P0** — pin the `F_obs` cell-level spectral sequence (§1.3).
*Concurrently* (permitted exception — a bounded, from-scratch
computation, not a "report on un-pinned foundations"): a **bounded
faithfulness probe** — study the obstruction sheaf `F_obs`, its
`S_n`-isotype structure, and the edge map structurally at `n = 3` and
`n = 4`, the way `mg-565a` probed Fork D viability. *Checkpoint 0:* P0
GREEN ⟹ residual-attack tickets may be dispatched. The probe's output
feeds straight into Phase 1.

**Phase 1 — the faithfulness gate. (Checkpoint 1 — make-or-break.)**
Tickets, in order: **R3a** (edge-map existence) → **R3b** (degree
`n-1`) → **R3c** (injectivity). **R2** (the landing) runs *alongside*
R3c — they share the representation theory of `F_obs`. *Checkpoint 1:*
do R3c and R2 hold?
  - **If either REDs** — the contradiction is hollow; **stop.** Fork A
    has hit a genuine wall. Found before the R1a budget was spent —
    fail-fast working as designed. Report RED to Daniel; the
    cohomological route is closed or needs re-foundation.
  - **If both pass** (proved, or strongly supported with a residual
    sub-gap) — the proof is *viable*; proceed to Phase 2 with the
    multi-month R1a commitment justified.

**Phase 2 — the vanishing arc. (Gated on Checkpoint 1 GREEN.)**
Tickets: **R1a** (the stuck-fibre cofiber — will need its own
sub-scoping pass and a sequence of sub-tickets) and **R1c** (the
twisted-bridge null-homotopy) run in parallel. R1c is moderate-cost and
viability-low-risk; it may also begin *concurrently with Phase 1* if
spare polecat capacity exists (it is independent of the faithfulness
cluster) — but R1a, the budget wall, is strictly gated.

**Phase 3 — the branching step.**
Ticket: **R1b** — dispatched once R1a delivers `S_{n-1}`-isotype
cofiber cohomology and R1c delivers the null-homotopy. R1b assembles
them, branches `S_{n-1} → S_n`, and closes `conj:y1a`.

**Phase 4 — assembly and formalization.**
With all seven residuals closed, `thm:contradiction` is unconditional;
Frankl is proved for all `n ≥ 3`. Phase 3-Lean (formalize the spine,
then the closed residuals) is the downstream, separate effort.

### 5.3 What runs in parallel

| May run concurrently | Must be sequential |
|---|---|
| P0 ∥ the bounded faithfulness probe | R3a → R3b → R3c (strict chain) |
| R3c ∥ R2 (shared `F_obs` rep-theory) | P0 before every residual-attack ticket |
| R1a ∥ R1c (independent cofiber vs bridge) | Checkpoint 1 before R1a / R1b |
| R1c ∥ Phase 1 (optional, if spare capacity) | R1a, R1c before R1b |

### 5.4 The checkpoint gates, summarized

- **Checkpoint 0** (after P0): foundations pinned — residual-attack
  tickets unblocked.
- **Checkpoint 1** (after R3c + R2): **the make-or-break gate.** Fork A
  viable, or RED. *No R1a budget is committed before this gate.*
- **Checkpoint 2** (after R1a + R1c): the vanishing inputs to the
  reduction are in hand — R1b unblocked.
- **Checkpoint 3** (after R1b): `conj:y1a` closed — all seven
  residuals discharged; `thm:contradiction` is unconditional.

---

## §6 — The execution tickets `pm-onethird` should file

Filed in dependency order. Budgets are estimates; the multi-week / open
residuals will need re-scoping once upstream tickets land.

| # | Ticket (suggested name) | Residual | Phase / gate | Budget | Notes |
|---|---|---|---|---|---|
| 1 | `Frankl-ForkA-Fobs-SS-Pinning` | P0 | Phase 0 / Ckpt 0 | ~400–600k | foundational; may split into 2 |
| 2 | `Frankl-ForkA-Faithfulness-Probe` | (probe) | Phase 0–1 | ~300k | bounded `n=3,4` structural probe, `mg-565a`-style; cheapest fail-fast check |
| 3 | `Frankl-ForkA-R3a-EdgeMap-Existence` | R3a | Phase 1 | ~300–400k | gated on P0 |
| 4 | `Frankl-ForkA-R3b-EdgeMap-Degree` | R3b | Phase 1 | ~300k | gated on R3a |
| 5 | `Frankl-ForkA-R3c-EdgeMap-Injectivity` | R3c | Phase 1 / **Ckpt 1** | ~300k + open | **make-or-break**; gated on R3b |
| 6 | `Frankl-ForkA-R2-Y2-Landing` | R2 | Phase 1 / **Ckpt 1** | ~700k–1M | **make-or-break**; co-attack with R3c |
| 7 | `Frankl-ForkA-R1c-Bridge-NullHomotopy` | R1c | Phase 2 (or ∥ Phase 1) | ~600–700k | gated on P0; may share toolkit with R1b |
| 8 | `Frankl-ForkA-R1a-Cofiber-Scoping` | R1a | Phase 2 | ~300k | a sub-scoping pass — R1a is too large for one ticket |
| 9+ | `Frankl-ForkA-R1a-Cofiber-*` | R1a | Phase 2 | ≥1.5–2M total | per the #8 sub-scoping; gated on **Ckpt 1** |
| — | `Frankl-ForkA-R1b-Branching` | R1b | Phase 3 | ~600–900k | gated on R1a + R1c |

**Total to a complete Frankl proof:** dominated by R1a; order several
million tokens, realistically multi-month. The faithfulness cluster
(tickets 2–6) is a small fraction of that — which is precisely why it
goes first.

**Filing note for `pm-onethird`.** File tickets 1–2 now. File 3–6 with
explicit `depends`-edges (P0 → R3a → R3b → R3c; P0 → R2). **Do not
file the R1a sub-tickets (9+) until Checkpoint 1 is GREEN** — holding
them prevents the budget wall from being dispatched before the
viability gate. Ticket 7 (R1c) may be filed early with a P0 depends-edge
and dispatched concurrently with Phase 1 if capacity allows; ticket 8
(R1a scoping) gated on Checkpoint 1.

---

## §7 — Honest assessment

The Fork A re-foundation is, after three independent validations and
two revisions, exactly what `mg-bf5c` certified: a sound, honestly
conditional theorem resting on seven precisely named open residuals,
with no hidden assumption. Closing them is the Frankl proof. The
roadmap's honest bottom line:

1. **The arc is real but front-loaded with genuine risk.** The seven
   residuals are not seven equal problems. They are: one big
   computation (R1a, multi-month), three rep-theory reconciliations
   (R1b, R1c, R2), two bounded constructions (R3a, R3b), and one
   make-or-break faithfulness question (R3c) — all behind one
   prerequisite (P0).

2. **The cheapest thing that can kill Frankl should be checked first.**
   R3c and R2 — the faithfulness cluster — are comparatively cheap and
   are where Fork A can die. The roadmap gates the multi-month R1a
   budget behind them. This is the single most important sequencing
   decision and it is a deliberate, recommended deviation from
   "attack R1 and R3 in parallel."

3. **A RED is a real possible outcome and is not a failure.** If the
   `n=3/4` faithfulness probe or R3c shows the edge map is not
   injective, or R2 shows `ob` carries a `sgn`-component, Fork A's
   cohomological route to Frankl is closed. The arc is built so that
   this is discovered early and cheap — exactly the fail-fast outcome
   the `mg-0882` brief asks the scoping to pre-identify.

4. **If the faithfulness gate passes, the remaining risk is budget,
   not viability.** R1a is plausibly true and "merely" multi-month;
   R1b/R1c are tractable rep-theory. Past Checkpoint 1, the Frankl
   proof becomes a question of sustained effort rather than of whether
   the strategy can work at all.

**Recommendations (routed to Daniel via `pm-onethird`):**

1. File P0 and the bounded faithfulness probe (tickets 1–2)
   immediately; they are cheap, foundational, and the probe is the
   earliest possible read on whether Fork A is viable.
2. File the faithfulness cluster (tickets 3–6) with explicit
   dependency edges; treat Checkpoint 1 as a **hard gate** — no R1a
   budget before it.
3. Accept that R1a will need its own sub-scoping pass (ticket 8) and a
   multi-month sequence of sub-tickets; do not under-budget it.
4. Treat a RED on R3c or R2 as a sanctioned, reportable outcome — the
   scoping has pre-identified it, and discovering it early is the
   roadmap succeeding, not failing.
5. Phase 3 (Lean) of the spine is already unblocked (`mg-bf5c` §6.3
   rec 3): `thm:projection`, `thm:welldefined` (`D²=0`),
   `thm:maschke`, `prop:y2a-mech` are the formalization-ready core.
   The residuals are not formalization-ready and must not be
   Lean-formalized as discharged.

---

## §8 — Cross-references

- **Brief:** `mg-0882` (Frankl-ForkA-Residuals-Scoping). **Routes
  to:** Daniel, via `pm-onethird` (files the per-residual execution
  tickets per §6).
- **The certified residual list / the resolved Phase-2 arc:**
  `docs/Frankl-ForkA-Phase2-Revalidation2.md` (`mg-bf5c`).
- **The deliverable being scoped — the conditional theorem and the
  seven residuals:** `paper/forkA/refoundation.tex` (`res:y1` R1a/R1b/
  R1c, `res:y2` R2, `debt:faithful-localized` R3a/R3b/R3c,
  `thm:y1-reduction`, `thm:contradiction`; the supporting Remarks
  `rem:y1-branching`, `rem:bridge-not-ported`, `rem:promotion`,
  `rem:wrapper`, `rem:r2-faithful`, `rem:holim-prereq`).
- **The exhaustive Walsh-fact sweep (input list complete and final):**
  `docs/Frankl-ForkA-Phase2-Revision2.md` (`mg-894c`).
- **The Phase-1 ledger / the two owed debts:**
  `docs/Frankl-ForkA-Refound-LaTeX.md` (`mg-c15b`).
- **The R1a difficulty estimate — the cofiber-LES reduction and the
  "genuine stuck-family core" verdict:** `docs/Frankl-Y1-reprove.md`
  (`mg-56b8`).
- **The Fork A endorsement, the wrapper-risk, faithfulness as "the
  deepest open question":** `docs/Frankl-ForkD-Probe-n3.md`
  (`mg-565a`).
- **Onboarding:** `docs/PROOF-STRUCTURE-ONBOARDING.md`.

---

*Residual-closing scoping by polecat `cat-mg-0882`. Deliverable on
`main`: this document. It is a roadmap, not a closure: it attempts,
proves, and refutes nothing. The Fork A conditional theorem
`thm:contradiction` rests on one prerequisite (P0 — pin the `F_obs`
cell-level spectral sequence) and seven open residuals — R3a, R3b
(bounded), R3c (the make-or-break faithfulness gate), R2 (the second
viability risk), R1c (a bounded-to-multi-week bridge re-derivation),
R1a (the multi-month stuck-fibre cofiber computation — the budget
wall), R1b (the lossy `S_{n-1}→S_n` branching step). Closing all
seven, after P0, proves Frankl for all `n ≥ 3`. The roadmap's central
recommendation: attack the cheap faithfulness cluster {R3a, R3b, R3c,
R2} first and gate the multi-month R1a budget behind a make-or-break
checkpoint — if the Frankl proof is going to die on a residual, it dies
on R3c or R2, and the arc is built to find that out early and cheap. A
RED on R3c or R2 is a sanctioned, pre-identified outcome. Recommended
next: `pm-onethird` files tickets per §6, P0 and the faithfulness probe
first.*
