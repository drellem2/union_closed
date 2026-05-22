# Frankl-ForkA-Phase0-FaithfulnessProbe — bounded n=3/4 faithfulness probe

**Work item:** `mg-f9a7` (Frankl-ForkA-Phase0-FaithfulnessProbe). Per the
`mg-0882` Frankl-ForkA-Residuals-Roadmap, §5.2 — the Phase-0 bounded
faithfulness probe: the one permitted exception to the "no computation
before P0" rule, a deliberately bounded, from-scratch direct computation
at small `n`, the way `mg-565a` probed Fork D viability.

**READ-FIRST consumed:** `docs/Frankl-ForkA-Residuals-Roadmap.md`
(`mg-0882` — the Phase-0 probe spec, the R3c and R2 sections);
`paper/forkA/refoundation.tex` (the twice-revised, thrice-validated
Fork A re-foundation — `def:category`, `def:xf`, `def:bk`,
`def:obs-sheaf`, `def:ob`, `conj:y1a`, `thm:contradiction`,
`debt:faithful-localized`, `rem:wrapper`, `rem:r2-faithful`,
`rem:hocolim-flag`, `rem:holim-prereq`); `docs/Frankl-ForkD-Probe-n3.md`
(`mg-565a` — the prior bounded `n=3` probe, for method reference).

**Scope.** A bounded, reproducible direct computation at `n=3` and `n=4`:
does the Fork A obstruction cohomology genuinely **detect** the family
structure — is it faithful, **not** family-blind — in the way the
two-part contradiction `thm:contradiction` needs? This is the early,
cheap viability read on R3c (the make-or-break edge-map injectivity
wall) and R2 (the second viability risk). It is **not** a full proof of
either.

**Deliverable:** this document and the computation script
`docs/frankl-forkA-faithfulness-probe.py` (self-contained, no
dependencies; runs in ~2.2 s; self-tested; ranks cross-checked at two
`~2^31` primes). `pm-onethird` relays the verdict to Daniel. Deliverable
lands on `main` (no branch override).

---

## §0 — Verdict (top of page)

### 0.1 Headline

> **RED — FORK-A-NOT-VIABLE; THE WRAPPER-RISK IS REALIZED.**
>
> The Fork A cohomology object `H^*(C_n;X)` — the covariant homotopy
> colimit of the per-family cubical-defect diagram over the trace
> category, the object `refoundation.tex` `def:bk` constructs and on
> which the entire two-part contradiction is built — is **rationally
> acyclic for every `n`**. Direct computation gives
> `H^*(C_3;X) = ℚ` concentrated in degree `0` (every reduced cohomology
> group zero); and `H^*(C_n;X) = H^*(point)` for **all** `n` by an
> n-independent structural collapse. The Fork A cohomology is a
> **homology point**.
>
> The cause is exact and unhedged. The trace category `C_n`
> (`def:category`) has a **terminal object** `t = (∅,{∅})` — the
> pointed family on the empty ground set, to which every object has a
> unique morphism (the trace to `∅`). The homotopy colimit of *any*
> covariant functor over a category with a terminal object collapses,
> up to homotopy, to the value at that object; and `X(t) = X({∅})` is a
> single point. Hence `hocolim_{C_n} X ≃ X(t) = point`, and
> `H^{n-1}(C_n;X) = 0` for every `n`.
>
> **The obstruction class `ob(F⋆)` has no non-trivial home.** It is
> forced to `0`. `conj:y1a` (`thm:contradiction` input (v)) is
> **false** — `H̃^{n-1}(C_n;X) = 0`, not `sgn_{S_n}`. The edge-map
> debt R3a/R3b/R3c is **moot**: any edge map lands in the zero group.
> Fact One (`ob ≠ 0`) is unattainable. **The two-part contradiction is
> hollow.** This is family-blindness in the strongest possible form —
> exactly the wrapper-risk `rem:wrapper` named, realized.
>
> Per the `mg-f9a7` brief and the `mg-0882` roadmap §5.2: a RED here is
> **decisive and important** — a sanctioned, pre-identified outcome,
> and a **STOP-and-escalate** finding. The roadmap's fail-fast design
> worked exactly as intended: Fork A's cohomological route to Frankl is
> shown non-viable **early and cheap**, before the multi-month R1a
> budget was committed.

### 0.2 The faithfulness question, scored

| Question | Result | Evidence |
|---|---|---|
| Is the **coefficient diagram** `F ↦ X(F)` family-sensitive? | **YES** | §4.1. `X(F)` varies across families (2 cohomology profiles at `n=3`, 4 at `n=4`). Fork A's premise — "the content lives in the coefficient diagram" (`mg-565a`) — is sound. |
| Is the **obstruction machinery** (cover `{U_x}`, strata, mismatch) family-sensitive? | **YES** | §4.2. The rare-coordinate cover genuinely varies (7 cover-nerve profiles at `n=3`, 20 at `n=4`). The raw material is sound. |
| Is the **integrated Fork A cohomology** `H^*(C_n;X)` non-trivial? | **NO — `ℚ`-acyclic** | §2. `H^*(C_3;X) = {0:ℚ}` by direct computation; `H^*(C_n;X) = H^*(point)` for all `n` by the terminal-object collapse (§2.2). |
| Does `ob(F⋆)` have a non-trivial home in `H̃^{n-1}(C_n;X)`? | **NO** | §3. `H̃^{n-1}(C_n;X) = 0`; `ob(F⋆)` is forced to `0`. |
| **R3c** — is the Čech-to-cohomology edge map injective (faithfulness)? | **FAILS / MOOT** | §3. The edge map targets the **zero group**; if `Č H^1 ≠ 0` it is non-injective, and either way `ob(F⋆) = 0`. |
| **R2** — does `ob` avoid the `sgn` sphere isotype? | **vacuously true** | §3. `H̃^{n-1}(C_n;X) = 0` carries no `sgn` isotype (nor any other); `ob = 0` trivially avoids it — vacuously. |
| **`conj:y1a` / Y1-A** — is `H̃^{n-1}(C_n;X) ≅ sgn_{S_n}`? | **FALSE** | §2, §3. `H̃^{n-1}(C_n;X) = 0` for all `n`. |

### 0.3 The root cause, in one line

> **`C_n` has a terminal object `(∅,{∅})`; the covariant homotopy
> colimit — Fork A prescription (A2) — collapses onto it; and the
> value there is a point. The family-sensitive content of the
> coefficient diagram is real, but the hocolim integration destroys
> it.** This is precisely the hocolim-versus-holim concern the
> re-foundation itself flagged (`rem:hocolim-flag`, `rem:holim-prereq`),
> here **resolved against the hocolim**.

---

## §1 — Scope, method, the objects probed

### 1.1 What the probe asks

The `mg-0882` roadmap localizes the long-standing **wrapper-risk** —
the risk that the Fork A obstruction cohomology is *family-blind*, so
that the two-part contradiction is hollow — at the residual cluster
{R3a, R3b, R3c, R2}, with **R3c** (edge-map injectivity) the
make-or-break wall (roadmap §4.2) and **R2** (the `Y2` landing) the
second viability risk (§4.3). The roadmap's Phase-0 probe (§5.2) is the
earliest, cheapest read on that: study `F_obs`, its `S_n`-isotype
structure, and the edge map **structurally** at `n=3` and `n=4`. This
document is that probe.

A RED — Fork A hitting a genuine wall — is a **sanctioned,
pre-identified outcome** (`mg-0882` §7.3, §0.3; the `mg-f9a7` brief).
The probe reports the actual computation whichever way it comes out.

### 1.2 The objects, fixed precisely (from `refoundation.tex`)

- **The trace category `C_n`** (`def:category`). Objects: pointed
  intersection-closed families `(S,F)`, `S ⊆ [n]`, `F ⊆ 2^S`
  intersection-closed, `S ∈ F` (so `⋃F = S` automatically). Morphisms:
  the traces `(S,F) → (T, F|_T)`, `T ⊆ S`, `F|_T = {A∩T : A∈F}`.
- **The per-family cubical-defect complex `X(F)`** (`def:xf`). The
  `k`-cells are the pairs `C(A,T')` with `A∈F`, `T' ⊆ S∖A`, `|T'|=k`,
  and the whole `k`-subcube `{A∪T'' : T''⊆T'} ⊆ F` — the `k`-subcubes
  of the cube `Q_S` fully contained in `F`. The differential is the
  standard cubical boundary.
- **The Fork A cohomology `H^*(C_n;X)`** (`def:bk`). The cohomology of
  the covariant homotopy colimit `hocolim_{C_n} X`, computed as the
  cohomology of the total complex of the Bousfield–Kan double complex
  `BK^{p,q} = ⊕_{F_0→…→F_p} C^q(X(F_0))` — the cochain value taken at
  the **first** object of each bar string, with the horizontal
  differential's `d_0` face pulling back along the trace projection
  `π_T^*`.
- **The obstruction sheaf `F_obs`** (`def:obs-sheaf`), the
  rare-coordinate strata `U_x`, and the mismatch cocycle `{m_xy}`
  (`def:ob`) on the punctured trace poset of a minimal counterexample.

### 1.3 Method

A from-scratch, reproducible computation
(`docs/frankl-forkA-faithfulness-probe.py`). All cohomology is over
`ℚ`, computed by sparse Gaussian elimination of the (co)boundary
matrices modulo a large prime, **cross-checked at two independent
`~2^31` primes**. The machinery is self-tested: `X(2^[n])` is verified
contractible, `X({S})` a point, the cubical `d² = 0`, and — crucially —
the Bousfield–Kan total differential `D² = 0` is verified directly on
the entire 13 997-dimensional `n=3` total complex (a wrong sign
convention would break it; it holds). The bare-nerve cohomology
`H^*(C_n;ℚ)` is computed as a control. The `S_n`-action is read off via
the Hopf trace formula. `n=3` is computed in full; the `n=4` cohomology
verdict rests on an n-independent structural theorem (§2.4) whose
hypothesis is verified directly for `C_4` (all 2 775 objects), together
with the direct `n=4` per-family and obstruction-machinery computations.

---

## §2 — The decisive computation: `H^*(C_n;X)` is rationally acyclic

### 2.1 The result

The Fork A cohomology object `H^*(C_3;X)`, computed directly from the
Bousfield–Kan total complex of `def:bk`:

| total degree `m` | `dim Tot^m` | `H^m(C_3;X)` |
|---|---|---|
| 0 | 320 | **1** |
| 1 | 2 227 | 0 |
| 2 | 4 878 | 0  ← degree `n−1 = 2`: the asserted home of `ob(F⋆)` |
| 3 | 4 525 | 0 |
| 4 | 1 795 | 0 |
| 5 | 246 | 0 |
| 6 | 6 | 0 |

> **`H^*(C_3;X) = ℚ` in degree 0, and `0` in every other degree.** The
> Fork A cohomology object is a **rational homology point**:
> `H̃^*(C_3;X) = 0` (reduced cohomology vanishes in every degree).

The `S_3`-virtual character is `(1,1,1)` on `(e,(12),(123))` — the
trivial isotype, one copy, in degree 0; no `sgn`, no `std`, nothing in
any positive degree. The **control** — the bare nerve `H^*(C_3;ℚ)` with
constant coefficients — is also `{0:ℚ}` (the nerve of `C_3` is
contractible). `H^*(C_3;X)` **equals** the bare-nerve cohomology: the
coefficient system `X(-)` contributes nothing beyond the constant.

This is the same shape of verdict `mg-565a` returned for Fork D — *the
cohomology object is `ℚ`-acyclic, hence family-blind* — now for Fork A.

### 2.2 The diagnosis: the terminal object of `C_n`

The acyclicity is not an accident of `n=3`. It is forced, for every
`n`, by a structural feature of `C_n`.

> **`C_n` has a terminal object** `t = (∅,{∅})` — the pointed family on
> the empty ground set. For every object `(S,F)`, the trace to `T = ∅`
> is `F|_∅ = {∅}`, so there is exactly one morphism `(S,F) → t`.
> (Verified directly: in `C_3`, all 89 objects; in `C_4`, all 2 775.)

**The terminal-object collapse.** For any small category `C` with a
terminal object `t` and any covariant functor `X : C → Ch_ℚ`, the
inclusion `{t} ↪ C` is *homotopy final*: for every object `c`, the
comma category `(c ↓ t)` is the set of morphisms `c → t`, a single
point, hence contractible. A homotopy-final functor induces an
equivalence on homotopy colimits, so

> `hocolim_{C_n} X  ≃  X(t)`.

And `X(t) = X({∅})` is the cubical-defect complex of the one-set family
`{∅}` on the empty ground set: a single `0`-cell — **a point**.
Therefore `hocolim_{C_n} X ≃ point` and `H^*(C_n;X) = H^*(point) = ℚ`
in degree 0, **for every `n ≥ 1`**.

The `n=3` direct computation (§2.1) confirms this exactly: theory
predicts `{0:ℚ}`, computation returns `{0:ℚ}`.

This is the precise mechanism of the family-blindness. The homotopy
colimit is a colimit-flavoured construction; over a category with a
terminal object it "drains" onto that object, and the trivial family
`(∅,{∅})` — which carries no Frankl data whatsoever — is exactly that
drain. Every family-sensitive cell of every `X(F)` is washed out.

### 2.3 The controlled experiment

To confirm beyond doubt that the terminal object `t` is the cause — and
not some unrelated degeneracy — the probe deletes `t` (and the
`|S|=1` layer) and recomputes the cohomology of the full subcategory:

| object restriction | `H^*(·;X)` | reading |
|---|---|---|
| `C_3` (the whole category) | `{0:1}` | acyclic — the terminal object `t` present |
| `C_3` with `|S| ≥ 1` (drop `t`) | `{0:1, 2:59}` | **non-trivial** — `H^2` jumps `0 → 59` |
| `C_3` with `|S| ≥ 2` | `{0:1, 1:133}` | **non-trivial** — `H^1 = 133` |

> Removing the single terminal object `t` changes the cohomology from
> `ℚ`-acyclic to a 59-dimensional `H^2`. This **isolates `t` as the
> cause** of the collapse: the family-sensitive content is genuinely
> *there* — the hocolim's terminal-object collapse is what destroys it.

Two honest caveats on the controlled experiment. First, the subcategory
cohomologies `{0:1,2:59}` and `{0:1,1:133}` are **not** the Fork A
object and are **not** sphere-like (`conj:y1a` wants a *one*-dimensional
top class; 59 and 133 are neither one nor zero). So deleting `t` does
**not** rescue Fork A — it only proves the diagnosis. Second, the
finding is therefore robust in both directions: neither `C_n` as written
(`ℚ`-acyclic) nor the natural `S ≠ ∅` truncation (`H̃^{n-1}` of
dimension 59, not 1) yields the sphere `conj:y1a` requires.

### 2.4 `n=4`

A brute-force Bousfield–Kan total complex for `C_4` is `~10^6`-
dimensional — out of bounded-probe scope, and it would only re-confirm
an n-independent theorem. The `n=4` verdict instead rests on:

1. the terminal-object collapse theorem (§2.2), which is
   **n-independent**;
2. a **direct `n=4` verification of its hypothesis**: `t = (∅,{∅})` is
   an object of `C_4` and every one of the 2 775 objects has its unique
   trace to it (computed); and `X(t)` is a point (computed);
3. the `n=3` direct computation (§2.1) confirming the theorem's
   prediction exactly.

Hence `H^*(C_4;X) = H^*(point) = ℚ` in degree 0, `H̃^{n-1}(C_4;X) = 0`.
The direct `n=4` computations the probe *does* perform — the per-family
complexes `X(F)` for all 2 480 families on `[4]` (§4.1) and the
obstruction machinery for all 2 479 non-trivial families (§4.2) — are
reported below; they corroborate the structural picture.

---

## §3 — What this means for `thm:contradiction`

`thm:contradiction` is a conditional theorem: assume inputs (i)–(v),
then no minimal counterexample to Frankl on `[n]` exists. The probe's
finding strikes the inputs as follows.

- **`conj:y1a` (input (v), the `Y1`-A vanishing) is FALSE.** It asserts
  `H̃^{n-1}(C_n;X) ≅ sgn_{S_n}` (one-dimensional). The probe computes
  `H̃^{n-1}(C_n;X) = 0` for all `n`. The `H̃^k = 0` for `1 ≤ k ≤ n−2`
  half of `conj:y1a` holds (vacuously — everything vanishes); the
  `H̃^{n-1} ≅ sgn` half fails outright. `Y1`-A is therefore not
  "true-but-unproven hard content" (the roadmap §2.1 estimate, RED-risk
  *low*) — it is **false**.

- **The obstruction class `ob(F⋆)` has no non-trivial home.** `def:ob`
  places `ob(F⋆) ∈ H̃^{n-1}(C_n;X)`. That group is `0`. Whatever the
  Čech-to-cohomology edge map is, its target is the zero vector space,
  so `ob(F⋆) = 0` necessarily.

- **Fact One (`ob(F⋆) ≠ 0`) is unattainable.** `prop:fact-one` derives
  `ob(F⋆) ≠ 0` from minimality *via* the edge-map injectivity. With the
  target group zero, `ob(F⋆) ≠ 0` is impossible regardless of
  minimality. The "nonzero" half of the two-part contradiction cannot
  be established.

- **R3a / R3b / R3c are moot.** R3a (edge-map *existence*): the only map
  into the zero group is the zero map — it "exists" trivially and
  carries no information. R3b (*degree-`n−1`*): degree `n−1` is the
  zero group. R3c (*injectivity* — the roadmap's make-or-break wall):
  the edge map `Č H^1(𝔘;F_obs) → H̃^{n-1}(C_n;X) = 0` is injective iff
  `Č H^1 = 0`; whenever the Čech `H^1` is non-trivial the edge map is
  **non-injective** — R3c fails — and when it is trivial the edge map
  is vacuously injective but `ob` is still `0`. **Either way `ob` is
  family-blind.** The roadmap correctly identified the faithfulness
  cluster as where Fork A dies; the probe pinpoints the mechanism one
  step *upstream* of R3c — the target cohomology is itself zero.

- **R2 is vacuously true.** It asks that `ob(F⋆)` have no `sgn_{S_n}`
  component in `H̃^{n-1}(C_n;X)`. That group is `0`; it has no `sgn`
  component (nor any other); `ob = 0` trivially avoids it. R2 "holds" —
  vacuously, because there is nothing there to land in.

- **The two-part contradiction is hollow.** With `ob(F⋆) = 0` forced
  and Fact One unattainable, `thm:contradiction` cannot be discharged.
  The conditional theorem remains honestly *stated* — the three prior
  validations (`mg-d300`, `mg-5221`, `mg-bf5c`) certified its honesty,
  not its closure — but it can never be made unconditional, because
  input (v) is false and inputs (i)–(iv) are moot.

This is the **wrapper-risk realized** (`rem:wrapper`: "if it fails,
`ob` is family-blind and the contradiction is hollow"). Not as the
subtle non-injectivity of a delicate edge map — as the total collapse
of the cohomology object the edge map was supposed to land in.

---

## §4 — The constructive half: where the content is, and where it dies

The probe is not purely negative. It locates precisely where the
family-sensitive content lives — and where it is destroyed.

### 4.1 The coefficient diagram `X(-)` IS family-sensitive

The per-family cubical-defect complex `X(F)` (`def:xf`), computed for
every family:

| `n` | families | distinct `X(F)`-cohomology profiles |
|---|---|---|
| 3 | 61 | **2** — 44 acyclic (contractible), 17 with `H̃^0 = 1` |
| 4 | 2 480 | **4** — 1750 acyclic, 685 `H̃^0=1`, 42 `H̃^0=2`, 3 `H̃^0=3` |

`X(F)` genuinely varies across families — Fork A's premise, that "the
content lives in the coefficient diagram `F ↦ X(F)`" (`mg-565a` §6.2),
is **sound**. One structural observation: at `n ≤ 4` every `X(F)` is
**homotopy-discrete** — its only non-zero reduced cohomology is `H̃^0`
(a disjoint union of contractible pieces). So the coefficient diagram's
family-sensitivity is carried entirely by `π_0 X(F)`, the
component count. It is real sensitivity, but homotopically thin.

### 4.2 The obstruction machinery IS family-sensitive

The probe builds, for every non-trivial family `F` treated as the apex,
its punctured trace poset, the rare-coordinate strata
`U_x = {(T,G) : x∈T, β_x(G) ≤ 0}`, and the mismatch cocycle:

- **Frankl holds at `n=3` and `n=4`** — 0 minimal counterexamples among
  all 60 / 2 479 non-trivial families (every family has a global rare
  coordinate). So **no genuine `F⋆` exists at `n=3` or `n=4`** to test
  `ob` on directly — the probe is necessarily structural, which is
  exactly the roadmap §5.2 "study … structurally" remit.
- The rare-coordinate **cover nerve genuinely varies** with the family:
  7 distinct incidence profiles among the 60 families at `n=3`, 20 among
  the 2 479 at `n=4`. The mismatch strata depend on the actual biases,
  not merely on the cover's combinatorial shape (verified for all
  60 / 2 479 families).

So the obstruction *raw material* — `F_obs`, the cover `{U_x}`, the
mismatch — is family-sensitive. (Minor note: for 15/60 families at
`n=3` and 208/2 479 at `n=4` the strata fail to cover the punctured
poset, because those families have a *trivial* proper trace `{T}`;
`prop:minimality` rules this out for a genuine minimal counterexample,
so it is not itself a Fork A flaw — only a confirmation that those
families are not counterexamples.)

### 4.3 …but the hocolim integration destroys it

The decisive point. The coefficient diagram is family-sensitive (§4.1).
The obstruction machinery is family-sensitive (§4.2). Yet the
**integrated** object `H^*(C_n;X) = H^*(hocolim_{C_n} X)` is
`ℚ`-acyclic (§2). The integration step — Fork A prescription **(A2)**,
"replace the contravariant hocolim with the *covariant* homotopy
colimit" — is what destroys the content, because `C_n` has a terminal
object and the covariant hocolim collapses onto it.

`mg-565a` eliminated Fork D because the *bare nerve* of the category is
acyclic, and endorsed Fork A on the grounds that "a non-constant
coefficient system is forced" and Fork A integrates exactly that
system. The probe shows the endorsement was **half right and half
wrong**: the coefficient system *is* the right place for the content
(half right), but **integrating it by the covariant hocolim recreates
the Fork-D acyclicity** (half wrong) — because the trace category, like
the Moore-family lattice, has an extremal object that the homotopy
colimit drains onto. `mg-565a` checked that Fork D's bare nerve is
acyclic; it did not check that Fork A's hocolim integration is too. It
is.

---

## §5 — The viability verdict for the residual-closing arc

The `mg-0882` roadmap gated the multi-month R1a budget behind a
make-or-break faithfulness checkpoint (Checkpoint 1), precisely so that
"if the Frankl proof is going to die on a residual, it dies on R3c or
R2, and the arc is built to find that out early and cheap." The Phase-0
probe is the earliest read on that checkpoint. Its verdict:

> **The faithfulness checkpoint FAILS. Fork A, as founded in
> `refoundation.tex`, is not viable.** The cohomology object
> `H^*(C_n;X)` is `ℚ`-acyclic for every `n`; `ob(F⋆)` is family-blind
> by total target collapse; `conj:y1a` is false; the two-part
> contradiction is hollow.

This is **stronger and more decisive than the roadmap anticipated**.
The roadmap rated R3c HIGH-RED-risk but treated it as "a definite
yes/no question about one map" needing P0 + R3a + R3b first, and rated
the `Y1`-A vanishing arc (R1) as a *budget* wall, not a *viability*
wall ("RED-risk: low … plausibly true … true-but-unproven"). The probe
finds:

- the make-or-break failure is real, and located not at R3c
  specifically but at the **cohomology object itself** — one step
  upstream of the edge map;
- it is **n-independent and structural** (a terminal-object collapse),
  not a delicate computation contingent on P0;
- it takes down **both** sides of the contradiction at once — the
  faithfulness cluster {R3a,R3b,R3c,R2} *and* the vanishing `conj:y1a`
  (R1's target) — because both rest on `H^*(C_n;X)`.

The roadmap's central recommendation — attack the cheap faithfulness
cluster first, gate the R1a budget behind it — is **vindicated**: the
probe is the cheapest possible check (~2.2 s) and it has surfaced a
decisive RED before any P0, R3, or R1 attack ticket was dispatched.
**No R1a budget should be committed.** This is the fail-fast design
working exactly as `mg-0882` §7.3 intended.

---

## §6 — Recommendations (routed to Daniel via `pm-onethird`)

1. **Treat Fork A, as founded, as refuted.** The covariant homotopy
   colimit `H^*(C_n;X)` of `def:bk` is rationally acyclic for every
   `n`; it cannot host a non-trivial obstruction class; the two-part
   contradiction `thm:contradiction` is hollow. The residual-closing
   arc {P0, R3a, R3b, R3c, R2, R1a, R1b, R1c} should **not** be
   dispatched against the current Fork A object — every one of those
   residuals presupposes `H^*(C_n;X)` is the sphere-like object
   `conj:y1a` describes, and it is not.

2. **This is a STOP-and-escalate finding.** Per the `mg-f9a7` brief and
   `mg-0882` §7.3 rec 4, a RED on the faithfulness probe is a
   sanctioned, pre-identified outcome and must be reported to Daniel
   directly. `pm-onethird` relays.

3. **The honest record on the diagnosis.** The re-foundation **itself**
   flagged this exact risk: `rem:hocolim-flag` records that "the
   obstruction is a gluing-type (limit-flavoured) invariant" while
   `H^*(C_n;X)` is the cohomology of a homotopy *colimit*, and folds
   "the hocolim-versus-holim question" into the faithfulness debt;
   `rem:holim-prereq` sharpens it. The probe **resolves that flagged
   question — against the hocolim.** The covariant hocolim is the wrong
   object: it is well-defined (Phase-1.5 wall (a) genuinely cleared)
   but vacuous.

4. **The indicated direction, if the cohomological route is continued
   (a re-foundation, beyond this probe's scope — a strategic call for
   Daniel).** The collapse is caused specifically by the terminal
   object and the *colimit* variance. A homotopy *limit*
   `holim_{C_n} X` does **not** suffer the terminal-object collapse
   (the inclusion `{t} ↪ C_n` is homotopy *final*, not homotopy
   *initial*, so `holim` is not forced onto `X(t)`); and the obstruction
   is, by `rem:hocolim-flag`'s own admission, a limit-flavoured (gluing)
   invariant. A holim-based, or relative/reduced, or
   terminal-object-excluding re-foundation is the natural candidate.
   **The probe does not compute the holim and makes no claim it
   succeeds** — the controlled experiment (§2.3) shows even the
   terminal-object-excluded subcategory is not sphere-like, so a
   re-foundation is genuine new work, not a relabelling. Whether to
   attempt it is Daniel's call.

5. **No Lean, no paper edit beyond this probe.** `refoundation.tex` is
   a standalone Phase-1 document; the probe does not edit it. The
   consolidated paper is untouched. This is a strategic probe; its
   deliverables are this report and the script.

6. **The probe's bounded scope, stated honestly.** `n=3` is computed in
   full directly. `n=4`'s `H^*(C_4;X) = 0` rests on the n-independent
   terminal-object theorem (§2.2), whose hypothesis is verified directly
   for all 2 775 objects of `C_4`, plus the direct `n=4` per-family and
   obstruction-machinery computations. The finding is **not** a
   probabilistic small-`n` read — it is a structural theorem confirmed
   by direct computation. The RED is as decisive as a Phase-0 probe can
   deliver.

---

## §7 — The honest one-paragraph verdict

The Fork A cohomology object `H^*(C_n;X)` — the covariant homotopy
colimit of the per-family cubical-defect diagram over the trace
category, the object `refoundation.tex` `def:bk` builds and on which
the whole two-part contradiction stands — is rationally acyclic for
every `n`: direct computation gives `H^*(C_3;X) = ℚ` in degree 0 and
zero in every other degree, and the same holds for all `n` because the
trace category `C_n` has a terminal object `(∅,{∅})` onto which the
covariant homotopy colimit collapses, the value there being a single
point; a controlled experiment (delete the terminal object and `H^2`
jumps from `0` to `59`) isolates that terminal object as the exact
cause. Consequently `conj:y1a` is false (`H̃^{n-1}(C_n;X) = 0`, not
`sgn_{S_n}`), the obstruction class `ob(F⋆)` is forced to zero for
want of any non-trivial home, the edge-map debt R3a/R3b/R3c is moot
(its target is the zero group) and R2 is vacuously true, so Fact One
(`ob ≠ 0`) is unattainable and the two-part contradiction is hollow —
the wrapper-risk `rem:wrapper` named is realized, not as a subtle
non-injectivity of a delicate edge map but as the total collapse of the
cohomology that edge map was to land in; the family-sensitive content
is genuinely present in the coefficient diagram `X(-)` and in the
obstruction machinery `{U_x}` (the probe confirms both vary with the
family), but the covariant-hocolim integration — Fork A prescription
(A2) — destroys it, exactly the hocolim-versus-holim concern the
re-foundation itself flagged in `rem:hocolim-flag` and `rem:holim-prereq`
and here resolved against the hocolim; the verdict is **RED —
FORK-A-NOT-VIABLE**, a sanctioned and important STOP-and-escalate
outcome, the `mg-0882` fail-fast roadmap working exactly as designed —
the cohomological route to Frankl via Fork A is shown non-viable early
and cheap, before the multi-month R1a budget was committed.

---

## §8 — Cross-references

- **Brief:** `mg-f9a7` (Frankl-ForkA-Phase0-FaithfulnessProbe).
  **Routes to:** Daniel, via `pm-onethird`.
- **The roadmap that commissioned this probe:**
  `docs/Frankl-ForkA-Residuals-Roadmap.md` (`mg-0882` — §5.2 the
  Phase-0 probe spec, §2.7 R3c, §2.4 R2, §4 the make-or-break analysis).
- **The object probed — the Fork A re-foundation:**
  `paper/forkA/refoundation.tex` (`def:category`, `def:xf`, `def:bk`,
  `def:obs-sheaf`, `def:ob`, `conj:y1a`, `thm:contradiction`,
  `debt:faithful-localized`, `rem:wrapper`, `rem:r2-faithful`,
  `rem:hocolim-flag`, `rem:holim-prereq`).
- **The prior bounded `n=3` probe (method reference, the analogous
  Fork-D `ℚ`-acyclicity verdict):** `docs/Frankl-ForkD-Probe-n3.md`
  and `docs/frankl-forkd-probe-n3.py` (`mg-565a`).
- **The three Phase-2 validations (which certified the re-foundation's
  honesty, not its closure):**
  `docs/Frankl-ForkA-Phase2-validation.md` (`mg-d300`),
  `docs/Frankl-ForkA-Phase2-Revalidation.md` (`mg-5221`),
  `docs/Frankl-ForkA-Phase2-Revalidation2.md` (`mg-bf5c`).
- **Onboarding:** `docs/PROOF-STRUCTURE-ONBOARDING.md`.
- **Computation:** `docs/frankl-forkA-faithfulness-probe.py` —
  self-contained, reproducible, ~2.2 s; self-tested (`X(2^[n])`
  contractible, `X({S})` a point, `d²=0`, `D²=0` on the full `n=3`
  total complex); ranks cross-checked at two `~2^31` primes.

---

*Probe by polecat `cat-mg-f9a7`. Deliverables on `main`: this document
and `docs/frankl-forkA-faithfulness-probe.py`. Verdict: **RED —
FORK-A-NOT-VIABLE; THE WRAPPER-RISK IS REALIZED.** The Fork A
cohomology object `H^*(C_n;X)` is rationally acyclic for every `n` (a
homology point), because the trace category `C_n` has a terminal object
`(∅,{∅})` onto which the covariant homotopy colimit collapses; hence
`conj:y1a` is false, `ob(F⋆)` is family-blind by total target collapse,
the edge-map debt R3a/R3b/R3c is moot, and the two-part contradiction
`thm:contradiction` is hollow. The family-sensitive content is real in
the coefficient diagram and in the obstruction machinery, but the
covariant-hocolim integration destroys it — the hocolim-versus-holim
concern the re-foundation itself flagged, resolved against the hocolim.
A RED is a sanctioned, pre-identified, STOP-and-escalate outcome; the
`mg-0882` fail-fast roadmap worked as designed. Recommended next:
`pm-onethird` relays to Daniel; do not dispatch the residual-closing
arc against the current Fork A object; whether to attempt a holim-based
or terminal-object-excluding re-foundation is a strategic call for
Daniel.*
