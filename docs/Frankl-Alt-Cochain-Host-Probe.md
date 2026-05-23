# Frankl-Alt-Cochain-Host-Probe — the symmetry-vanishing **is** evaded by sgn-equivariant cochains

**Work item:** `mg-1b24` (Frankl-Alternative-Cochain-Host-Probe). Per
Daniel's reminder 2026-05-23T05:37Z ('try out a few different things');
second of three Frankl bypass angles. Vision-aligned per
`docs/Frankl-Vision.md` part-3.

This document records the **GREEN-PARTIAL** verdict on the probe:
every strictly-F-natural cochain (entropy, log-Möbius, pair-difference,
member-count, cumulant) inherits the CE-shape symmetry-vanishing per
`mg-e466`, but the **sgn-twisted F-natural** class of cochains —
explicitly opened by the ticket as "equivariant rather than invariant" —
**produces a non-zero `sgn_{S_n}`-isotype class on every CE-shape F⋆**
tested (12/12 at n=3, 582/582 at n=4 for the two constructions
**`C-SGN-DEFICIT`** and **`C-SGN-COUNT`**). The mechanism that evades the
obstruction is structurally clean and proven robust to all `n` via an
elementary orbit-average computation. The cohomological layer is
nonetheless **degenerate** (the class on the 1-dim `H̃^{n-2}(PB) ≅ sgn`
host reduces to a scalar invariant of F⋆); vision-step 4 becomes a
purely scalar combinatorial question, NOT a separate cohomology
vanishing.

**Deliverable:** this document + probe script
`docs/frankl-alt-cochain-host-probe.py` (n=3, exhaustive)
+ `docs/frankl-alt-cochain-host-probe-n4.py` (n=4 confirmation across
all 582 CE-shape F's) + raw outputs (`*.out`). Reproducible at two
~2^31 primes.

**READ-FIRST consumed:** `docs/Frankl-Vision.md` (the canonical
vision); `docs/Frankl-IE-Induction-Probe.md` (mg-e466 RED verdict and
the symmetry obstruction);
`docs/Frankl-Cohomology-Synthesis.md` (mg-5cc6 11-construction
synthesis).

---

## §0 — Verdict (top of page)

### 0.1 Headline

> **GREEN-PARTIAL.** The CE-shape symmetry-vanishing obstruction
> identified in `mg-e466` is **NOT robust** across the F-natural class
> in the broad sense the brief opens. Relaxing strict F-naturality to
> the *sgn-twisted* F-naturality the brief flags as legitimate —
> "F-natural cochains equivariant (rather than invariant) in
> non-trivial ways" — yields multiple explicit constructions that
> produce **non-zero `sgn_{S_n}`-isotype classes on every
> counterexample-shape F⋆ tested**:
>
> | Construction | n=3 (of 12) | n=4 (of 582) |
> |---|---|---|
> | C-SGN-MOB-TOP   | 12/12 | 560/582 |
> | **C-SGN-DEFICIT** | **12/12** | **582/582** |
> | **C-SGN-COUNT**   | **12/12** | **582/582** |
> | C-SGN-MOB-BOT   |  8/12 | 409/582 |
> | C-SGN-MOB-PROD  |  5/12 | 358/582 |
> | C-INV-MOB-TOP   | 10/12 | (not run) |
>
> The two universally-non-zero constructions, **C-SGN-DEFICIT**
> (`sgn(π_chain) · ψ_{x_new}`, `ψ_x := 2a_F(x) − |F|`) and **C-SGN-COUNT**
> (`sgn(π_chain) · |F ∩ σ_{top}|`), are provably non-zero on **any**
> Frankl counterexample F⋆ at **any** n by an elementary
> orbit-average argument (§2.4).
>
> The **structural property that evades the obstruction** is the
> sgn-twist: when c_F(chain) = `sgn(π_chain) · h_F(chain)` with h_F
> strictly F-natural, the cochain transforms under any σ ∈ S_n as
> `c_{σ.F}(σ.chain) = sgn(σ) · c_F(chain)` — i.e., c_F is an
> sgn-twisted F-natural cochain. For σ ∈ Stab(F⋆) (including the
> transpositions CE-shape F⋆ structurally carries), this gives
> `c_F(σ.chain) = sgn(σ) · c_F(chain)`, so c_F already lives in the
> sgn-isotype and the sgn-projection is non-zero.
>
> Per the ticket gate, this verdict warrants **filing an n=4 follow-on**;
> the n=4 confirmation in §2.3 demonstrates the construction is robust
> across the larger CE-shape class but ALSO reveals the unavoidable
> structural caveat: the host `H̃^{n-2}(PB) ≅ sgn` is one-dimensional,
> so the F-induced class is **just a scalar multiple of the canonical
> sgn class generator**. The cohomological layer is degenerate. **Vision-
> step 4** ("separate result about category cohomology contradicts the
> class") reduces to "prove the scalar invariant g_F vanishes for all
> Frankl counterexamples F⋆" — and the structural argument (§2.4)
> proves that g_F > 0 strictly for any F⋆, so any such separate
> vanishing result would itself contradict the explicit positivity.
> The contradictive layer **doesn't fire** in any obvious way; the
> follow-on must address whether a non-degenerate cohomology layer
> can be built (e.g. by enriching the host with extra structure that
> makes the class more than a scalar).

### 0.2 The vision, re-scored after the probe

| Vision-step | mg-e466 (LIFT-4-prod) | This probe (SGN-DEFICIT/COUNT) |
|---|---|---|
| (1) F⋆ exists | YES (CE-shape) | YES (CE-shape) |
| (2) IE applied to F⋆ | Möbius transform lifted to top-dim cochain | Möbius (via deficit ψ_x) or member-count, multiplied by host's sgn cocycle |
| (3) Induced class non-trivial | **FAILS** on F⋆ (0/12 n=3, 14% n=4) | **HOLDS** on F⋆ (12/12 n=3, 582/582 n=4 for SGN-DEFICIT and SGN-COUNT) |
| (3+) Class lives in `sgn_{S_n}`-isotype of `H̃^{n-2}(PB)` | YES (host is sgn, but class is 0 on F⋆) | YES (class is non-zero scalar multiple of sgn generator) |
| (4) Separate cohomology result contradicts | MOOT (step 3 already 0) | **DOES NOT FIRE NATURALLY** — the class is a scalar g_F > 0 strictly on F⋆, so no vanishing-of-host result would force the class to 0. The natural separate result "g_F⋆ = 0 for Frankl counterexamples" is FALSE (explicit positivity). |

### 0.3 The structural property in one line

> **A cochain `c_F(chain) = sgn(π_chain) · h_F(chain)`** with `h_F`
> strictly F-natural is **`sgn`-equivariant under Stab(F⋆)**, not
> `S_n`-invariant. CE-shape F⋆'s transposition symmetry then *places*
> c_F into the sgn-isotype rather than killing the sgn-projection,
> and the class is non-zero whenever the orbit-average of h_F is
> non-zero.

---

## §1 — Setup and cochain candidates

The host is the punctured Boolean order complex
`PB_n = 2^[n] \ {∅, [n]}` (the same OP-A host that `mg-e466` used),
homotopy-equivalent to `S^{n-2}` with `H̃^{n-2}(PB_n) ≅ sgn_{S_n}`.

Top-dim chains in `PB_n` correspond bijectively to permutations of
`[n]`: a chain `σ_0 ⊊ σ_1 ⊊ ⋯ ⊊ σ_{n-2}` records adding one element
of `[n]` at each step (extended canonically to `∅ ⊊ σ_0 ⊊ ⋯ ⊊ σ_{n-2} ⊊ [n]`),
giving a permutation `π_chain ∈ S_n`. The map chain ↦ `sgn(π_chain)` is
the canonical generator of `H̃^{n-2}(PB_n) ≅ sgn` (the "Pascal-cocycle").

### 1.1 Strictly F-natural cochains (control class)

A cochain `c_F` is **strictly F-natural** if `c_{σ.F}(σ.chain) = c_F(chain)`
for all σ ∈ S_n. The five candidates probed:

| Name | Formula | F-natural source |
|---|---|---|
| C-ENT-prod    | `∏_i H_F(σ_i)`                                | per-vertex entropy of F's element distribution restricted to σ_i |
| C-LOG-prod    | `∏_i log(1 + \|m_F(σ_i)\|)`                  | log-magnitude of Möbius |
| C-PAIR-DIFF   | `∏_i (m_F(σ_{i+1}) − m_F(σ_i))`              | alternating Möbius differences |
| C-COUNT-prod  | `∏_i \|F ∩ σ_i\|`                            | member-count product |
| C-CUMUL       | cross-cumulant of `m_F` along the chain       | Möbius-style cumulant of m_F values |

`mg-e466`'s symmetry obstruction (§2.4) predicts these all yield zero
sgn-class for CE-shape F⋆.

### 1.2 Sgn-twisted F-natural cochains (the alternative class)

A cochain `c_F` is **sgn-twisted F-natural** if
`c_{σ.F}(σ.chain) = sgn(σ) · c_F(chain)` for all σ ∈ S_n. Concretely:
take any strictly F-natural h_F and multiply by `sgn(π_chain)` (which is
S_n-equivariant with character sgn). Candidates:

| Name | Formula |
|---|---|
| C-SGN-MOB-TOP   | `sgn(π_chain) · m_F(σ_{n-2})`        |
| C-SGN-MOB-BOT   | `sgn(π_chain) · m_F(σ_0)`            |
| C-SGN-MOB-PROD  | `sgn(π_chain) · ∏_i m_F(σ_i)`        |
| **C-SGN-DEFICIT** | `sgn(π_chain) · ψ_{x_new}` where `x_new := σ_{n-2} \ σ_{n-3}` (or `σ_0` if n=3) and `ψ_x := 2 a_F(x) − \|F\|` |
| **C-SGN-COUNT** | `sgn(π_chain) · \|F ∩ σ_{n-2}\|`     |
| C-INV-MOB-TOP   | `inv(π_chain) · m_F(σ_{n-2})` (inversion-count weighting; not character-pure) |

### 1.3 Alternative hosts

The ticket also opens "alternative hosts." Three were probed:

| Host | Cohomology | Outcome |
|---|---|---|
| `HOST-SUSP-PB` simplicial suspension of `PB_n` | `H^{n-1}(susp) ≅ sgn_{S_n}` (shifted PB cohomology) | Sgn-twisted cochains all FAIL (sgn-projection is 0 for all 12 CE-shape F at n=3). Suspension doesn't shift the obstruction shape in a useful way. |
| `HOST-COUNT-GRD` count-graded sheaf `S(T) = ℚ[F ∩ T]` on `PB_n` | as in mg-e466 OP-C | Raw cochain (without sgn) gives 0/12. Sgn-twisted variant gives 8/12 (worse than SGN-COUNT — the sheaf grading dilutes the F-information). |
| `HOST-A_n-EQUIV` A_n-equivariant cohomology (project onto trivial-A_n isotype) | A_n-orbits of `H^{n-2}(PB)` | All 0/12. A_n-trivial projection of an F-natural cochain is still F-natural; the obstruction still applies under the embedding A_n ↪ S_n composed with transpositions in S_n. |

Bottom line on hosts: **the work is being done by the cochain, not by
the host.** No host change in the natural range helps; what helps is
relaxing F-naturality to sgn-equivariance.

---

## §2 — Probe results

### 2.1 Exhaustive n=3 results (script: `frankl-alt-cochain-host-probe.py`)

All 12 CE-shape F at n=3 (the same set listed in `mg-e466` Table §2.3):

```
F (CE-shape)                                        ENT  LOG PAIR  CNT  CML S-MT S-MB S-MP  S-D  S-C I-MT
[{3} {1,2} {1,2,3}]                                   0    0    0    0    0    1    1    1    1    1    1
[{2} {1,3} {1,2,3}]                                   0    0    0    0    0    1    1    1    1    1    1
[{1,2} {1,3} {1,2,3}]                                 0    0    0    0    0    1    0    0    1    1    0
[{1} {2,3} {1,2,3}]                                   0    0    0    0    0    1    1    1    1    1    1
[{1,2} {2,3} {1,2,3}]                                 0    0    0    0    0    1    0    0    1    1    1
[{1,3} {2,3} {1,2,3}]                                 0    0    0    0    0    1    0    0    1    1    0
[{1,2} {1,3} {2,3} {1,2,3}]                           0    0    0    0    0    1    0    0    1    1    1
[0 {1,2} {1,3} {2,3} {1,2,3}]                         0    0    0    0    0    1    1    1    1    1    1
[{1} {1,2} {1,3} {2,3} {1,2,3}]                       0    0    0    0    0    1    1    0    1    1    1
[{2} {1,2} {1,3} {2,3} {1,2,3}]                       0    0    0    0    0    1    1    0    1    1    1
[{3} {1,2} {1,3} {2,3} {1,2,3}]                       0    0    0    0    0    1    1    0    1    1    1
[{1} {2} {3} {1,2} {1,3} {2,3} {1,2,3}]               0    0    0    0    0    1    1    1    1    1    1
```

Aggregated:

```
C-ENT-prod         (strict   ) : raw  0/12, sgn-proj  0/12  -> fails
C-LOG-prod         (strict   ) : raw  0/12, sgn-proj  0/12  -> fails
C-PAIR-DIFF        (strict   ) : raw  0/12, sgn-proj  0/12  -> fails
C-COUNT-prod       (strict   ) : raw  0/12, sgn-proj  0/12  -> fails
C-CUMUL            (strict   ) : raw  0/12, sgn-proj  0/12  -> fails
C-SGN-MOB-TOP      (sgn-TWIST) : raw 12/12, sgn-proj 12/12  -> WORKS
C-SGN-MOB-BOT      (sgn-TWIST) : raw  8/12, sgn-proj  8/12  -> WORKS
C-SGN-MOB-PROD     (sgn-TWIST) : raw  5/12, sgn-proj  5/12  -> WORKS
C-SGN-DEFICIT      (sgn-TWIST) : raw 12/12, sgn-proj 12/12  -> WORKS
C-SGN-COUNT        (sgn-TWIST) : raw 12/12, sgn-proj 12/12  -> WORKS
C-INV-MOB-TOP      (sgn-TWIST) : raw 10/12, sgn-proj 10/12  -> WORKS
```

The five strictly-F-natural candidates uniformly fail; six sgn-twisted
variants produce non-zero classes for at least some CE-shape F.
**Three** of them — SGN-MOB-TOP, SGN-DEFICIT, SGN-COUNT — give non-zero
class for *every* CE-shape F at n=3.

### 2.2 The structural diagnostic

The sgn-projection of `c_F(chain) = sgn(π_chain) · h_F(chain)` simplifies
to `sgn(π_chain) · g_F` where
`g_F = (1/n!) Σ_{σ ∈ S_n} h_F(σ^{-1}·chain) = orbit-average of h_F`.

For the three universally-non-zero constructions at n=3:

| Construction | Underlying scalar g_F at n=3 |
|---|---|
| SGN-MOB-TOP | `(1/3) Σ_{T:|T|=n-1} m_F(T)` (orbit avg of m_F at (n-1)-sets) |
| SGN-DEFICIT | `(2/n) Σ_x a_F(x) − |F|` = the `Σψ`-average element-deficit |
| SGN-COUNT   | `(1/n) Σ_{A∈F, |A|<n} (n − |A|)` |

For all 12 CE-shape F at n=3 the probe directly recorded
`Σ_top m_F`, `Σ_bot m_F`, `Σ_mid m_F`:

```
[{3} {1,2} {1,2,3}]                                 Σ_top m_F = -1  Σ_bot m_F = +1
[{2} {1,3} {1,2,3}]                                 Σ_top m_F = -1  Σ_bot m_F = +1
[{1,2} {1,3} {1,2,3}]                               Σ_top m_F = +2  Σ_bot m_F = +0
[{1} {2,3} {1,2,3}]                                 Σ_top m_F = -1  Σ_bot m_F = +1
[{1,2} {2,3} {1,2,3}]                               Σ_top m_F = +2  Σ_bot m_F = +0
[{1,3} {2,3} {1,2,3}]                               Σ_top m_F = +2  Σ_bot m_F = +0
[{1,2} {1,3} {2,3} {1,2,3}]                         Σ_top m_F = +3  Σ_bot m_F = +0
[0 {1,2} {1,3} {2,3} {1,2,3}]                       Σ_top m_F = +6  Σ_bot m_F = -3
[{1} {1,2} {1,3} {2,3} {1,2,3}]                     Σ_top m_F = +1  Σ_bot m_F = +1
[{2} {1,2} {1,3} {2,3} {1,2,3}]                     Σ_top m_F = +1  Σ_bot m_F = +1
[{3} {1,2} {1,3} {2,3} {1,2,3}]                     Σ_top m_F = +1  Σ_bot m_F = +1
[{1} {2} {3} {1,2} {1,3} {2,3} {1,2,3}]             Σ_top m_F = -3  Σ_bot m_F = +3
```

`Σ_top m_F` is non-zero for **all 12** CE-shape F's at n=3 (confirming
SGN-MOB-TOP works uniformly); `Σ_bot m_F` is zero for 4 of the 12 (those
without singletons in F⋆, matching the SGN-MOB-BOT 8/12 result).

### 2.3 n=4 confirmation (script: `frankl-alt-cochain-host-probe-n4.py`)

Across **all 582** CE-shape F at n=4:

```
C-SGN-MOB-TOP      : non-zero sgn-class 560/582 CE-shape F's  (96.2%)
C-SGN-DEFICIT      : non-zero sgn-class 582/582 CE-shape F's  (100.0%)
C-SGN-COUNT        : non-zero sgn-class 582/582 CE-shape F's  (100.0%)
C-SGN-MOB-BOT      : non-zero sgn-class 409/582 CE-shape F's  (70.3%)
C-SGN-MOB-PROD     : non-zero sgn-class 358/582 CE-shape F's  (61.5%)
```

**SGN-DEFICIT and SGN-COUNT remain at 100% at n=4.** The structural
argument in §2.4 explains why.

### 2.4 The structural argument — non-zero for all n

**Claim.** For any union-closed F with `|F| ≥ 2` whose every element is
in *strictly more* than `|F|/2` members of F (the strict
Frankl-counterexample condition), and any `n`:

  (a) `g_DEF(F) := (2/n) Σ_{x ∈ [n]} a_F(x) − |F|` is strictly **positive**.

  (b) `g_CNT(F) := (1/n) Σ_{A ∈ F, |A| < n} (n − |A|)` is strictly **positive**
      whenever F has any member of size `< n`.

Hence the sgn-classes of C-SGN-DEFICIT and C-SGN-COUNT are non-zero
for every actual Frankl counterexample at every n.

*Proof.* 

(a) For each x ∈ [n], by the no-rare condition `2 a_F(x) > |F|`, hence
`2 a_F(x) − |F| ≥ 1`. Summing: `Σ_x (2 a_F(x) − |F|) ≥ n`. Dividing by n:
`g_DEF(F) ≥ 1 > 0`. 

(b) For each non-`[n]` member A ∈ F, `n − |A| ≥ 1`. F has at least one
such member (else F = {[n]} which has `|F| = 1`, ruling out
counterexample candidacy). Hence the sum is `≥ 1`, so `g_CNT(F) ≥ 1/n > 0`.

The sgn-projected cochain class of C-SGN-DEFICIT is
`g_DEF(F) · [ω]` ∈ `H̃^{n-2}(PB_n) ≅ sgn`, where `[ω]` is the canonical
sgn class generator. By (a), this is non-zero. Same for SGN-COUNT. ∎

This argument is elementary and **completely rules out the n=4 follow-on
needing to investigate vision-step 3** further on this construction:
vision-step 3 is **proven** non-zero on all Frankl counterexamples at
all n by the argument above. The remaining question is vision-step 4
(§3).

### 2.5 Why strict F-natural cochains uniformly fail

The mg-e466 argument carries through verbatim for any strictly
F-natural cochain — every transposition `σ ∈ Stab(F⋆)` gives
`c_F(σ.chain) = c_F(chain)` (invariance), so the sgn-projection vanishes.
The five strict-F-natural candidates in §1.1 satisfy this, hence the
uniform 0/12 outcome.

The structural reason `mg-e466` flagged is correct AS STATED ("any
F-natural cochain inherits F's symmetry") but the unspoken precondition
is *strict* F-naturality. The brief's "F-natural cochains equivariant
in non-trivial ways" relaxes that precondition.

### 2.6 Why no alternative HOST in the natural range helps

The suspension `Σ PB_n` has `H^{n-1}(Σ PB_n) ≅ H^{n-2}(PB_n) ≅ sgn`. A
top-dim cochain on `Σ PB_n` is (formally) a pair of top-dim cochains on
`PB_n` (one per pole), and the cohomology of the suspension is
identified with the cohomology of `PB_n` via the reduced-suspension
isomorphism. The S_n-action on `Σ PB_n` fixes the poles and acts on the
base; the same transposition-invariance argument applies to any
strictly-F-natural top-dim cochain on `Σ PB_n`. The probe confirms
all 12 CE-shape F give zero sgn class for every sgn-twist attempt on
`Σ PB_n` — the suspension construction doesn't combine well with the
pole-fixed S_n-action because the canonical "sgn cocycle" of the
suspension involves the pole-direction sign, not the base sgn cocycle.

The count-graded host (`OP-C` analogue) and A_n-equivariant host
similarly fail to produce non-zero classes by themselves; what works
is the sgn-cocycle factor on the base `PB_n` host, applied to the
strictly-F-natural information.

---

## §3 — What the alternative does NOT solve (the contradictive layer)

### 3.1 The cohomological layer is degenerate

`H̃^{n-2}(PB_n) ≅ sgn_{S_n}` is **one-dimensional**. Any class is a scalar
multiple of the canonical sgn class generator `[ω]`. Hence the F-induced
class is determined by a single scalar `g_F`.

For C-SGN-DEFICIT, `g_F = g_DEF(F) ≥ 1` strictly for any Frankl
counterexample.

For C-SGN-COUNT, `g_F = g_CNT(F) ≥ 1/n` strictly.

These are **explicit positivity bounds** — no separate cohomology result
about `H̃^{n-2}(PB_n)` (which IS the sgn line, non-zero) can force
g_F to be zero. The contradiction `thm:contradiction` requires would
need a separate result of the form "g_F = 0 for all Frankl
counterexamples" — but this is FALSE by §2.4 (g_F is a strictly
positive scalar combinatorial invariant).

### 3.2 Vision-step 4 cannot fire on this host

The four candidate shapes of "separate result" from `mg-e466` §1.4:

| Shape | Status on this construction |
|---|---|
| (S1) `H̃^{n-2}(host) = 0` | FALSE — host has `H̃^{n-2} ≅ sgn ≠ 0` |
| (S2) `H̃^{n-2}(host)^{sgn} = 0` | FALSE — the host IS the sgn-isotype |
| (S3) Functorial collapse onto a zero target | NO natural target — the construction lives in a 1-dim host |
| (S4 - new) g_F = 0 for Frankl counterexamples | FALSE — explicit positivity (§2.4) |

The contradictive layer thus **doesn't fire**. The mechanism gives a
positive scalar `g_F⋆ ≥ 1` for any Frankl counterexample, with no
separate-cohomology-vanishing result that could contradict it.

### 3.3 What the alternative reduces Frankl to

Reframing: **the sgn-twisted F-natural construction reduces "Frankl
holds" to "the scalar invariant `g_F = 0` for every union-closed F
with |F| ≥ 2"** — which is provably FALSE (every union-closed F has
some pair member or singleton or other proper member, so g_DEF and
g_CNT are positive on every F with proper members).

So this is in fact a *converse* to Daniel's intent: the
sgn-twist gives a positive scalar `g_F⋆ ≥ 1` for Frankl counterexamples
(via the rare-elementlessness condition), and the *non-counterexample*
F's (Frankl-shaped) ALSO have `g_F ≥ 0` (no separation). The scalar
does not Frankl-discriminate; vision-step 4 cannot route through it.

The cohomology layer is a *passenger*, not a load-bearing component of
any contradiction.

### 3.4 The mg-e1e2 angle still stands

The brief lists three Frankl bypass angles. This probe (the second)
shows that the symmetry obstruction CAN be evaded by sgn-twisting, but
the contradictive layer is degenerate on the resulting 1-dim host. The
third angle, mg-e1e2's F-non-natural route, remains as the only
remaining angle that could plausibly produce a non-degenerate
contradictive layer — by breaking F-naturality at the cochain level
rather than at the equivariance level (where the host's 1-dim sgn
structure already pins down the cohomology to a scalar).

---

## §4 — Recommendation

### 4.1 File n=4 follow-on (per ticket gate)

The ticket explicitly directs: **"ANY ALTERNATIVE WORKS — file an n=4
follow-on."** A working alternative is found at n=3 *and* confirmed
across all 582 CE-shape F at n=4. The follow-on
(`Frankl-Alt-Cochain-Followup-VisionStep4`, **filed as `mg-4052`** with
`depends: mg-1b24`) focuses on vision-step 4 — explicitly, the question of whether
a non-degenerate cohomology layer can be constructed by enriching
the host so that the F-induced class is more than a scalar. Concrete
candidates for follow-on investigation:

- **Multi-component host.** Replace `PB_n` with a `k`-fold product
  `(PB_n)^k` and lift the cochain to a chain-level Künneth product.
  The host's `H^{k(n-2)} ≅ sgn^{\otimes k}` (or its symmetrization)
  carries an `S_n`-rep richer than 1-dim. The F-induced class can
  encode rank-`k` information, breaking the 1-dim degeneracy.
- **Filtered host with non-trivial associated graded.** A filtration
  of `PB_n` (e.g., by chain-length, by the cardinality-grading of
  chain endpoints) whose associated graded `H^*` carries higher-dim
  S_n-reps. The F-induced class projects to a vector, not just a
  scalar.
- **Module-valued host.** Coefficient sheaf with non-trivial S_n-action
  beyond sgn (e.g., the standard rep `std_{S_n}` of dim `n-1` at degree
  `n-2`). The F-induced class lives in a non-1-dim S_n-rep, allowing
  vision-step 4 to fire via "the std-component vanishes" or similar.

For each candidate, the n=3 / n=4 probe pattern from this ticket
extends directly.

### 4.2 Re-emphasize that mg-e466's structural finding survives

The exact statement of `mg-e466`'s finding — *"any strictly F-natural
cochain inherits the CE-shape transposition symmetry, killing the
sgn-isotype component"* — is unchanged by this probe. The
strictly-F-natural class is still vanishing-uniform.

What this probe adds: the broader "F-natural-equivariant" class (the
brief's relaxation) contains constructions that **do** survive the
symmetry-killing. The cost is that the resulting class is a scalar
on a 1-dim host — the contradictive layer becomes trivial, not the
inducing layer.

### 4.3 Vision check

This ticket addresses **vision-part-3** ("the IE-induced invariant IS
a non-trivial cohomology class"): the answer is **YES**, in a
non-strict-F-natural reading. The structural property that makes it
work is the sgn-twist (a host-side feature, not an F-side feature),
applied on top of any strictly-F-natural information functional
(deficit ψ_x, member-count, Möbius).

The follow-on (vision-step-4 focused) addresses **vision-part-4**
("separate result about the category cohomology contradicts").
The natural separate result on the 1-dim sgn host is unavailable
(the scalar is explicitly positive); the follow-on must enrich the
host to carry a non-degenerate cohomology layer.

The F-non-natural route (mg-e1e2) remains the alternative path to
break F-naturality at the cochain level rather than at the
equivariance level.

---

## §5 — Cross-references

- **Ticket:** `mg-1b24` (this document).
- **Canonical vision:** `docs/Frankl-Vision.md`.
- **Prior probe (mg-e466):** `docs/Frankl-IE-Induction-Probe.md` —
  RED on strict F-natural cochains; this probe relaxes to sgn-twist.
- **Synthesis (mg-5cc6):** `docs/Frankl-Cohomology-Synthesis.md`.
- **Probe scripts (this ticket):**
  - `docs/frankl-alt-cochain-host-probe.py` (n=3 exhaustive)
  - `docs/frankl-alt-cochain-host-probe-n4.py` (n=4 confirmation across 582 CE-shape F's)
- **Raw outputs:**
  - `docs/frankl-alt-cochain-host-probe.out`
  - `docs/frankl-alt-cochain-host-probe-n4.out`
- **F-non-natural route (the remaining angle):** mg-e1e2.
- **N=4 / enriched-host follow-on (filed by this ticket):** `mg-4052`
  (`Frankl-Alt-Cochain-Followup-VisionStep4`).

---

*Probe by polecat `cat-mg-1b24`. Deliverable on `main`: this document
+ two probe scripts + raw outputs. Verdict: **GREEN-PARTIAL — the
CE-shape symmetry obstruction is evaded by sgn-twisted F-natural
cochains; the cohomological layer on the 1-dim sgn host is degenerate
(class = scalar); vision-step 4 needs an enriched-host follow-on.** Per
ticket gate, file the n=4 follow-on (`Frankl-Alt-Cochain-Followup-
VisionStep4`).*
