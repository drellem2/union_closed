# Frankl-ForkA-Phase2-Revalidation — independent re-validation of the revised refoundation.tex

**Work item:** `mg-5221` (Frankl-ForkA-Phase2-Revalidation). Per the
`mg-365e` (Frankl-ForkA-Phase2-Revision) GREEN. `mg-365e` revised
`paper/forkA/refoundation.tex` per the `mg-d300` AMBER validation's
§6.2 spec. This is the **independent re-validation** — the final check
before the residual-closing work and Phase 3 (Lean).

**Deliverable validated:** `paper/forkA/refoundation.tex` (the revised
document, commit `2de18da`).

**READ-FIRST consumed:** `paper/forkA/refoundation.tex` (the revised
deliverable); `docs/Frankl-ForkA-Phase2-Revision.md` (`mg-365e` — the
revision ledger); `docs/Frankl-ForkA-Phase2-validation.md` (`mg-d300` —
the prior validation, §6.2 the revision spec). Cross-checked against
`docs/Frankl-Y1-reprove.md` (`mg-56b8` — the pre-Fork-A cofiber-LES
reduction, §3.2 + §8.1 the twisted bridge) and the `mg-c15b`→`mg-365e`
diff of `refoundation.tex`.

**Stance.** Fresh, independent, default-skeptical reviewer — not the
`mg-365e` or `mg-c15b` polecat. The explicit charge: confirm the
revision is complete and honest, and hunt for surviving over-claims the
way `mg-d300` did (it caught two the `mg-c15b` self-audit missed). This
report does the construction-level verification independently and
reports **one surviving over-claim** that the revision did not address.

---

## §0 — Verdict (top of page)

### 0.1 Headline

> **AMBER — THE THREE SPEC'D FIXES LANDED AND THE SPINE IS SOUND, BUT A
> THIRD OVER-CLAIM OF THE SAME SHAPE SURVIVES.**
>
> The `mg-365e` revision **correctly executed the `mg-d300` §6.2
> revision spec**: `thm:y1-reduction` now claims only
> `Stab(x) ≅ S_{n-1}`-equivariance; `R1b`, the `S_{n-1}→S_n` branching
> step, is a genuine and correctly-stated new sub-residual;
> `thm:contradiction` honestly enumerates all five inputs and the
> "exactly three" framing is gone; `prop:sphere-sgn`'s hypothesis is
> correctly strengthened. The **GREEN spine** — `π_T` a covariant
> functor (`thm:projection`), `H*(C_n;X)` genuinely defined with
> `D²=0` (`thm:welldefined`), the Maschke `S_n`-decomposition
> (`thm:maschke`), the `Y2`-A structural mechanism (`prop:y2a-mech`) —
> is independently re-confirmed sound and is undisturbed by the
> revision. The re-foundation is **not refuted** — RED is not the
> verdict.
>
> But the document is **not GREEN**, because a **third over-claim of
> the identical "Walsh-graded fact treated as portable" shape**
> survives into the revised draft:
>
> - **The twisted-bridge null-homotopy `ι_x* ≃ 0` is presented as an
>   established, ported input (Construction `constr:bridge`) when it is
>   not.** The pre-Fork-A bridge (`mg-56b8` §3.2, §8.1) supplies
>   `ι_x* ≃ 0` **only as a map of `χ_S`-isotype sub-complexes
>   `V_S^*`** — its defining identity `ι_x* = ±½(dh − hd)` has a step,
>   "`d` commutes with `χ_x·`," that `mg-56b8` §8.1 states is "valid
>   only on `χ_S`-supported cells." Fork A drops the Walsh grading as a
>   grading of the complex (`refoundation.tex`'s own
>   `rem:walsh-role2`: "`d` does not preserve harmonic level … Walsh
>   level grades cochains, not cohomology"). So in Fork A there is no
>   `V_S^*` sub-complex for `ι_x* ≃ 0` to live on, and the twisted
>   bridge does **not** deliver it. `constr:bridge` nonetheless asserts
>   "the twisted bridge identity `ι_x* = ±½(dh − hd)` also ports …
>   gives `ι_x* ≃ 0`," justified only by the (irrelevant) observation
>   that the `χ_x`-twist "is a cochain operation, not a group action."
>   `thm:y1-reduction` then **substitutes `ι_x* ≃ 0` into an
>   `S_{n-1}`-isotype-projected LES** — the identical grading-mismatch
>   error `mg-d300` caught for `S_n`, now repeated for `S_{n-1}`.
>
> This is precisely the **"second, compounding prong" of `mg-d300`'s
> Finding A** (`mg-d300` §3.3): `mg-d300` flagged it in prose but did
> **not** include a fix for it in its §6.2 spec, so `mg-365e` — which
> faithfully executed §6.2 — carried `constr:bridge` through
> **verbatim, unchanged** (confirmed by the `mg-c15b`→`mg-365e` diff).
> The consequence: `thm:y1-reduction`'s reduction of `Y1`-A is **not**
> the clean "`Y1`-A reduces to `R1a` + `R1b`" the document claims — it
> also rests on establishing `ι_x* ≃ 0` in the Fork A setting, which is
> open work, not the discharged `Construction` the document presents.
> The conditional theorem does not rest on exactly the five
> cleanly-named inputs.

### 0.2 The scorecard, re-scored against the re-validation targets

| Re-validation target | `mg-365e` self-score | Re-validation verdict |
|---|---|---|
| `thm:y1-reduction` equivariance now `Stab(x) ≅ S_{n-1}` only | fixed | **GREEN — confirmed.** Statement, proof sketch, and `rem:y1-branching` all correctly say `S_{n-1}` only (§2.3). |
| `R1b` (the `S_{n-1}→S_n` branching step) a genuine, correctly-stated sub-residual | fixed | **GREEN — confirmed.** Genuinely new under Fork A; the branching-rule lossiness is correctly described (§2.3). |
| `thm:contradiction` honestly enumerates all five inputs; "exactly three" dropped | fixed | **GREEN — confirmed.** Five inputs (i)–(v); proof uses each exactly; "exactly three / removes the fourth" framing gone (§2.4). |
| `prop:sphere-sgn` strengthened hypothesis correct | fixed | **GREEN — confirmed.** The added "transposition acts by `−1`" hypothesis is exactly what the proof needs; not load-bearing (§2.5). |
| GREEN spine: `thm:projection`, `thm:welldefined` (`D²=0`), `thm:maschke`, `prop:y2a-mech` | GREEN | **GREEN — confirmed.** Independently re-checked; undisturbed by the revision (§2.1–§2.2, §2.6). |
| The conditional theorem rests on **exactly** the five named inputs — no sixth gap | (implicit) | **AMBER — a further gap.** The twisted-bridge null-homotopy `ι_x* ≃ 0`, substituted in `thm:y1-reduction`, is presented as established (`constr:bridge`) but is a `χ_S`-graded fact that does not port (§3). |
| Construction `constr:bridge` | (delivered content) | **AMBER — over-claim, unchanged from Phase 1.** Asserts the twisted-bridge identity "ports … gives `ι_x* ≃ 0`"; the actual obstruction is un-addressed (§3). |

### 0.3 What AMBER means here, precisely

AMBER is **not** RED. Nothing in the re-foundation is refuted; the Fork A
object is genuinely defined, the spine is sound, the conditional theorem
is a valid conditional, and `Y1`-A may well be true. AMBER means: the
revision is **incomplete**. It fixed the two over-claims `mg-d300`
formally spec'd in §6.2 and the minor `prop:sphere-sgn` point — all
three correctly — but a **third over-claim of the same shape**, which
`mg-d300` itself raised as the "compounding prong" of Finding A but
omitted from its §6.2 fix-list, survives untouched in `constr:bridge`.
The fix is again an **honest re-statement** (§5.2): acknowledge that
`ι_x* ≃ 0` is not ported as an established whole-complex fact, and
record establishing it in the Fork A setting as open work — a residual,
or a part of `R1`. With that edit the document would honestly describe
what Phase 1 delivered and a further re-validation could return GREEN.
But the document **as submitted** cannot be validated GREEN, because the
re-validator's core charge — confirm the conditional theorem rests on
*exactly* the five named inputs, no hidden gap — returns *no*: a
load-bearing lemma (`ι_x* ≃ 0`) is presented as discharged when it is
not.

---

## §1 — Scope and method

The brief fixes three verification targets:

1. **The three `mg-365e` fixes are genuinely correct** — `thm:y1-reduction`
   equivariance is `Stab(x) ≅ S_{n-1}` only; `R1b` is a genuine,
   correctly-stated sub-residual; `thm:contradiction` enumerates all
   five inputs; `prop:sphere-sgn`'s strengthened hypothesis is correct.
   → §2.3–§2.5. **Confirmed correct** — but the `thm:y1-reduction` fix
   is **incomplete** (§3).
2. **The conditional theorem rests on EXACTLY the five named inputs —
   no sixth hidden gap, no further over-claim.** → §3. **Not
   confirmed** — there is a further gap (§3).
3. **The GREEN spine remains intact** (`H*(C_n;X)` with `X`
   well-defined, `D²=0`). → §2.1–§2.2, §2.6. **Confirmed sound.**

Method: every theorem with mathematical content was re-checked
independently from the definitions; the `mg-d300`→`mg-365e` transition
was cross-checked against the `mg-d300` §6.2 revision spec and against
the `mg-c15b`→`mg-365e` diff of `refoundation.tex`; the twisted-bridge
claim was cross-checked against the pre-Fork-A source `mg-56b8` (§3.2
the bridge, §8.1 its `χ_S`-support soft spot).

---

## §2 — What is sound (independently confirmed)

### 2.1 The GREEN spine, structural core — confirmed

The four spine items `mg-d300` confirmed sound were re-checked
independently and are **undisturbed by the revision** (the
`mg-c15b`→`mg-365e` diff touches none of their statements or proofs):

- **`thm:projection`** — `π_T(C(A,T')) = C(A∩T,T')` for `T' ⊆ T`, `0`
  otherwise, is a chain map `X(F) → X(F|_T)`, functorial and
  `S_n`-equivariant. The cell well-definedness (`(A∩T)∪T'' =
  (A∪T'')∩T ∈ F|_T`), the chain-map property (faces in a dropped
  direction cancel in pairs), functoriality, and equivariance all check
  out. ✓
- **`thm:welldefined`** — `D² = 0` for the total complex `Tot BK`.
  `d²=0` (cubical), `δ_BK²=0` (bar identity, reducing at the `d_0*d_0*`
  term to functoriality `π_{T'}∘π_T = π_{T'}`), and `d`/`δ_BK`
  anticommuting all hold. ✓

### 2.2 The Fork A object `H*(C_n;X)` — confirmed well-defined

Definition `def:bk` builds the cochain Bousfield–Kan double complex with
the cochain value at the **first** bar-string object — the correct
convention for the homotopy colimit of a *covariant* functor. With
`thm:welldefined` (`D²=0`), `H*(C_n;X)` is a genuinely defined graded
`Q`-vector space, where the pre-Fork-A `X_n^∩` was undefined. The
load-bearing positive content of the re-foundation holds. ✓

### 2.3 Fix 1 — `thm:y1-reduction` equivariance — correct (but see §3)

`mg-d300` Finding A, prong 1: the Phase-1 `thm:y1-reduction` falsely
claimed an `S_n`-equivariant cofiber LES. The revision **correctly
fixes this**:

- Statement (1) now reads: the pair `(X_n, X_{n-1,x})` has a cohomology
  LES "equivariant for the point stabiliser `Stab(x) ≅ S_{n-1}` — and
  *only* for that subgroup, not for all of `S_n`." ✓
- Statement (2) projects to `S_{n-1}`-isotypes `[μ]` via "Maschke for
  `S_{n-1}`," and the collapsed relation correctly expresses the
  `[μ]`-isotype of `Res^{S_n}_{S_{n-1}} H̃^k(C_n;X)` (restriction, not
  the whole `S_n`-module). ✓
- The proof sketch explicitly states "It does *not* split into
  `S_n`-isotypes: `S_n` does not act on the pair." ✓
- `rem:y1-branching` correctly explains the `(Z/2)^n`-vs-`S_n`
  asymmetry: `(Z/2)^n` is abelian, factors as
  `(Z/2)^{[n]∖x} × (Z/2)_x`, and so has a *quotient* acting on the
  smaller cube; `Stab(x) ≅ S_{n-1}` is a *subgroup* of `S_n`, not a
  quotient, and there is no surjection `S_n ↠ S_{n-1}`. ✓

This part of Finding A is genuinely repaired.

**`R1b` is a genuine, correctly-stated sub-residual.** Open residual
`res:y1` splits `R1` into `R1a` (the cofiber, a target object unchanged
from the pre-Fork-A state) and `R1b` (the `S_{n-1}→S_n` branching
step). `R1b` did not exist in the pre-Fork-A development — there the
cofiber LES split directly into Walsh isotypes via the abelian-quotient
structure of `(Z/2)^n`. The branching-step lossiness is correctly
stated: `sgn_{S_{n-1}} = Res^{S_n}_{S_{n-1}} sgn_{S_n}`, but by the
branching rule `sgn_{S_{n-1}}` is *also* a constituent of the
restriction of `S^{(2,1^{n-2})}`, so an `S_{n-1}`-isotype computation
does not determine the `S_n`-isotype decomposition. The mathematics is
correct and `R1b` is honestly recorded. ✓

> **However — the `thm:y1-reduction` fix is incomplete.** It repairs
> prong 1 of `mg-d300` Finding A (the LES equivariance) but not prong 2
> (the twisted-bridge null-homotopy `ι_x* ≃ 0`, which `thm:y1-reduction`
> step (2) substitutes to collapse the LES). See §3.

### 2.4 Fix 2 — `thm:contradiction` enumerates all five inputs — correct

`thm:contradiction` now lists five inputs: (i) `R3a` edge-map
existence, (ii) `R3b` degree-`(n-1)` landing, (iii) `R3c` edge-map
injectivity, (iv) `R2` landing, (v) `R1` vanishing. The proof was
re-checked line by line: (i)+(ii) make `ob(F⋆)` a well-defined element
of `H̃^{n-1}(C_n;X)`; Fact One with (iii) gives `ob(F⋆) ≠ 0`; (v) makes
`H̃^{n-1}(C_n;X) ≅ sgn_{S_n}`; (iv) gives `ob` no `sgn`-component, so
`ob = 0`; contradiction. **Each of the five inputs is used exactly
once, and no sixth input appears in `thm:contradiction`'s own proof.**
The "exactly three / Fork A removes the fourth" framing is dropped
throughout (`rem:honest-shape`: "Phase 1 makes *no* claim that this is
a count of 'exactly three'"). `R3` is correctly re-stated as the
three-part debt `debt:faithful-localized` (R3a/R3b/R3c). ✓

The five-input enumeration is honest **for `thm:contradiction` itself**.
The gap is one level down: input (v) is `conj:y1a`, and the document
asserts `conj:y1a` reduces (via `thm:y1-reduction`) to just `R1a` +
`R1b` — that assertion is the over-claim (§3).

### 2.5 Fix 3 (minor) — `prop:sphere-sgn` — correct

`prop:sphere-sgn`'s hypothesis is correctly strengthened: it now
additionally assumes the top class is realised `S_n`-equivariantly as
the orientation class of a coordinate `(n-1)`-sphere — "equivalently,
that some transposition acts on `H̃^{n-1}(C_n;X)` by `−1`." That added
hypothesis is exactly what the proof uses (a 1-dimensional `Q[S_n]`-
module is trivial or sign, distinguished by the transposition action).
`rem:sphere-sgn-hyp` honestly records why. The proposition is correctly
flagged as not load-bearing — `thm:contradiction` uses `conj:y1a`
directly. ✓

### 2.6 The `Y2`-A structural mechanism and the honest `R2` — confirmed

`prop:y2a-mech` (`ob` factors through bias *differences*; the
obstruction *cochain* is level-1 harmonic) was re-checked and is
correct, with both properties honestly labelled as *all* that is
proved. `R2` (`res:y2`) remains honestly localized as a
representation-theoretic question about `F_obs`; the withdrawn
"standard-isotypic" over-claim stays withdrawn. ✓

---

## §3 — The finding: the twisted-bridge null-homotopy over-claim survives

### 3.1 The claim under test

Construction `constr:bridge` ("The matched-cylinder bridge") asserts,
verbatim:

> "The harmonic twist by `χ_x` used in the pre-Fork-A bridge is, in
> Fork A, simply pointwise multiplication by the fixed function `χ_x`
> (Role 2, Remark `rem:walsh-role2`) — a cochain operation, not a group
> action — so the twisted bridge identity `ι_x* = ±½(dh − hd)` also
> ports without a `(Z/2)^n`-action. **It gives `ι_x* ≃ 0`, the input
> the reduction uses.**"

`thm:y1-reduction` step (2) then **substitutes this null-homotopy**:
"substituting the null-homotopy `ι_x* ≃ 0` (Construction
`constr:bridge`) collapses [the LES], in each degree, to a relation
…"; the proof sketch: "The bridge (Construction `constr:bridge`) gives
`ι_x* = 0` on cohomology in the relevant degrees; substituting the zero
map makes the restriction `j*` surjective … and `δ` injective."

So `ι_x* ≃ 0` is **load-bearing**: it is what collapses the cofiber LES
to the clean reduction `Y1`-A ⟸ (`R1a` + `R1b`). The document presents
it as **established**, inside a `Construction` environment, with no
hedge and no residual flag.

### 3.2 The twisted-bridge identity does not port — it is a `χ_S`-graded fact

The pre-Fork-A source `mg-56b8` is explicit about what the twisted
bridge delivers. `mg-56b8` §3.2, verbatim:

> "UC13 Theorem 4.3.1 (the twisted-bridge chain-homotopy identity)
> provides, **on the `χ_S`-isotype with `x ∉ S`**, a degree `−1`
> operator `h_x^tw` with `ι_x^{𝒟*} ω = ±½(d h_x^tw − h_x^tw d) ω`
> (`k ≥ 1`). The honest content: **`ι_x*` is null-homotopic on
> `V_S^*`**, hence induces the zero map
> `ι_x* = 0 : V_S^k(X_n∩) → V_S^k(X_{n-1,x}∩)` on cohomology …"

And `mg-56b8` §8.1, on the identity's own soft spot:

> "its step '`d` commutes with `χ_x·`' **is valid only on
> `χ_S`-supported cells** … the honest reading used here is that the
> identity asserts `ι_x*` is null-homotopic *as a map of `χ_S`-isotype
> cochain complexes* `V_S^*(X_n∩) → V_S^*(X_{n-1,x}∩)*` — which is the
> only reading the LES needs …"

So in the pre-Fork-A development the bridge null-homotopy `ι_x* ≃ 0`
is — by the source's own careful statement — **intrinsically a fact
about the `χ_S`-isotype sub-complexes `V_S^*`**. Its defining identity
`ι_x* = ±½(dh − hd)` requires the step "`d` commutes with `χ_x·`,"
which holds **only on `χ_S`-supported cells**. In the pre-Fork-A
setting that was fine: `V_S^*` was a genuine *sub-complex* of the
hocolim (the `χ_S`-isotype of the `(Z/2)^n`-action on the hocolim), so
"`ι_x* ≃ 0` as a map of `V_S^*` sub-complexes" was well-typed and the
LES was split into `V_S`-isotypes throughout.

**Fork A removes exactly the structure this relied on.** Fork A drops
the `(Z/2)^n`-action; there is no `(Z/2)^n`-action on the Fork A
hocolim, hence **no `V_S^*` sub-complex**. The document is itself
emphatic on the underlying fact — `rem:walsh-role2`, verbatim:

> "the *harmonic level* of a cochain is well-defined, but it is *not*
> preserved by the cubical coboundary `d` on the defect complex `X(F)`
> … So Walsh level grades *cochains*, not *cohomology*."

"`d` does not preserve harmonic level" is precisely "`d` does not
commute with `χ_x`-multiplication" (multiplying by `χ_x` shifts Walsh
level). So in Fork A:

1. The `χ_S`-graded pieces are **not sub-complexes** (`d` does not
   preserve them) — `rem:walsh-role2`'s own conclusion.
2. The twisted-bridge identity `ι_x* = ±½(dh − hd)`, whose validity
   needs "`d` commutes with `χ_x·`," therefore **does not hold as a
   whole-complex identity** — it holds only on `χ_S`-supported cells,
   which form no sub-complex.
3. Hence the *only* honest pre-Fork-A form of `ι_x* ≃ 0` — "a map of
   `χ_S`-isotype sub-complexes `V_S^*`" — **has no referent in Fork A**.

`constr:bridge`'s stated justification — the twist "is a cochain
operation, not a group action, so the … identity also ports without a
`(Z/2)^n`-action" — is a **non sequitur**. Whether the `χ_x`-twist is a
group action or a cochain operation is irrelevant; what the identity
needs is that `d` *commute* with the twist, and `rem:walsh-role2`
(which `constr:bridge` cites in the very same sentence) says it does
not. The revision rebutted the wrong concern.

### 3.3 The consequence: a grading mismatch, identical in shape to `mg-d300`'s Finding A

`thm:y1-reduction` step (2), as revised, projects the cofiber LES to
`S_{n-1}`-isotypes `[μ]` and **substitutes `ι_x* ≃ 0`** there. But
`ι_x* ≃ 0`, at honest strength, is a `χ_S`-graded fact. Substituting a
`χ_S`-graded fact into an `S_{n-1}`-isotype-projected LES is the
**identical grading-mismatch error** `mg-d300` caught for `S_n` — the
document's own `rem:maschke-analogue` warns that distinct gradings
"are different decompositions of the cohomology … not nested." The
revision moved the LES from an `S_n`-grading to the correct
`S_{n-1}`-grading but left the *other* ingredient, `ι_x* ≃ 0`, still
silently `χ_S`-graded — and the two still do not match.

This is exactly **`mg-d300`'s "second, compounding prong" of Finding A**
(`mg-d300` §3.3): "`ι_x* ≃ 0` is, at honest strength, a fact about
Walsh-`χ_S`-graded cochains, not a whole-complex fact. … A fact
established on Walsh isotypes cannot be substituted into `S_n`-isotypes."
`mg-d300` raised it in prose and said "Both prongs say the same thing,"
but its §6.2 revision spec — recommendation 2, the `thm:y1-reduction`
bullet — listed only the equivariance fix (prong 1) and the branching
step. **Prong 2 was never put in the fix-list.** `mg-365e` faithfully
executed §6.2, and the `mg-c15b`→`mg-365e` diff confirms `constr:bridge`
was carried through **verbatim, unchanged** — the twisted-bridge text is
the Phase-1 draft's, untouched. So the third over-claim survives.

### 3.4 Why this is an over-claim, not a refutation

`Y1`-A is not refuted, and `ι_x* ≃ 0` may well be *true* in the Fork A
setting — it simply is not *established* by the ported twisted bridge,
because the bridge's defining identity is intrinsically `χ_S`-graded and
Fork A has no `χ_S` sub-complex grading. Establishing `ι_x* ≃ 0` in
Fork A is **genuine open work**: either re-derive the null-homotopy by
some Fork-A-native means, or carry the `χ_S`-grading explicitly and
reconcile it with the `S_{n-1}`-grading of the LES (a second
representation-theoretic reconciliation, beside `R1b`).

The precise defects:

1. **`constr:bridge` presents a non-closing step as closed.** It is a
   `Construction` environment asserting "`ι_x* ≃ 0`, the input the
   reduction uses," with no hedge. The document's own stated discipline
   (`ssec:owed`: "where a step closes, it is stated as a theorem with
   proof; where it does not, it is isolated as a precisely named
   residual") is violated here.
2. **`thm:y1-reduction`'s reduction is incomplete as stated.** It claims
   "`Y1`-A reduces to *two* steps, `R1a` and `R1b`." It in fact also
   rests on establishing `ι_x* ≃ 0` in the Fork A setting. The honest
   statement is that `Y1`-A reduces to `R1a`, `R1b`, **and** the
   Fork-A bridge null-homotopy.
3. **The "exactly five inputs" accounting is therefore not airtight.**
   `thm:contradiction`'s input (v) is presented as `conj:y1a`, reducible
   to `R1a` + `R1b`. With the bridge gap, the conditional theorem
   effectively rests on `R3a`, `R3b`, `R3c`, `R2`, `R1a`, `R1b`, **and**
   the bridge null-homotopy — a further open item, disclosed nowhere,
   hidden inside a `Construction` that presents it as discharged.

This is a **third instance of the exact over-claim shape** the arc has
now seen three times: the `mg-c15b` polecat caught it for `Y2` (the
withdrawn "standard-isotypic" theorem — a Walsh-level fact treated as an
`S_n` fact); `mg-d300` caught it for the `Y1` LES equivariance (prong 1);
and it survives here for the `Y1` bridge null-homotopy (prong 2). Each
time it is the same mistake — a Walsh/`χ_S`-graded fact silently used
where the Fork A grading is `S_n` or `S_{n-1}`.

---

## §4 — Minor points (not load-bearing, recorded for completeness)

### 4.1 `prop:fact-one`: "global section ⟹ rare coordinate at `F⋆`"

`prop:fact-one`'s proof reads: `ob = 0` ⟹ (injectivity) "`{m_xy}` … a
Čech coboundary of a global section … A global section is a single
rare-coordinate datum valid on all of `C_n(F⋆)` — *including the top
object `F⋆`*." But the cover `{U_x}` and the sheaf `F_obs` are defined
on the **punctured** poset `C_n(F⋆)∖{F⋆}` (`def:obs-sheaf`); a global
section of `F_obs` is a section over the punctured poset, and the
extension "valid at `F⋆`" is a further step. The document does flag the
punctured-vs-whole-category mismatch in `rem:promotion` and folds it
into `R3a`, so this is mostly within the named `R3` debt — but the
specific punctured-poset-to-`F⋆` extension inside `prop:fact-one`'s
proof is under-flagged. Minor; it should be made explicit that this
step, too, is conditional on the `R3` faithfulness package. Not
verdict-changing — `prop:fact-one` is already labelled conditional on
`R3` (`status:fact-one`).

### 4.2 The base case of the simultaneous induction is still un-stated

`mg-d300` §5.2 noted that `thm:y1-reduction` invokes "the simultaneous
induction on `n`" without ever stating the base case (`n = 2` or
`n = 3`). `mg-d300` called this minor and "folds into the §6.2
re-statement of `thm:y1-reduction`"; the §6.2 spec did not in fact
include it, and the revision did not add it. Since the induction is
internal to the (RED-open) residual `R1a`, an un-stated base case is
not an over-claim — but if `thm:y1-reduction` presents a reduction, the
inductive frame it reduces into should be stated. Minor; recommend
folding into the §5.2 re-statement below.

---

## §5 — Verdict and recommendations

### 5.1 Verdict

**AMBER — THE THREE SPEC'D FIXES LANDED AND THE SPINE IS SOUND, BUT A
THIRD OVER-CLAIM OF THE SAME SHAPE SURVIVES.**

The `mg-365e` revision correctly executed the `mg-d300` §6.2 spec: the
`thm:y1-reduction` equivariance is now `Stab(x) ≅ S_{n-1}` only; `R1b`
is a genuine, correctly-stated branching sub-residual;
`thm:contradiction` honestly enumerates all five inputs and the
"exactly three" framing is gone; `prop:sphere-sgn`'s hypothesis is
correctly strengthened. The GREEN spine — `thm:projection`,
`thm:welldefined` (`D²=0`), `thm:maschke`, `prop:y2a-mech` — is
independently re-confirmed sound and undisturbed. The re-foundation is
**not refuted**; RED is not warranted.

It is **not GREEN**, because the re-validator's core charge — confirm
the conditional theorem rests on *exactly* the five named inputs, no
hidden gap — fails on one count. The twisted-bridge null-homotopy
`ι_x* ≃ 0`, which `thm:y1-reduction` substitutes to collapse the
cofiber LES, is presented as an established, ported input
(`Construction constr:bridge`) when it is not: by the pre-Fork-A
source's own careful statement (`mg-56b8` §3.2, §8.1), `ι_x* ≃ 0` is a
fact about `χ_S`-isotype sub-complexes `V_S^*`, and Fork A — which
drops the Walsh grading as a grading of the complex (`rem:walsh-role2`)
— has no `V_S^*` sub-complex for it to live on. This is the "second,
compounding prong" of `mg-d300`'s Finding A: `mg-d300` flagged it in
prose but omitted it from its §6.2 fix-list, so the revision carried
`constr:bridge` through verbatim. The fix is again an honest
re-statement (§5.2); the issue is not a wall.

### 5.2 Recommendations (routed to Daniel via pm-onethird)

1. **Do not yet proceed to Phase 3 (Lean).** Phase 3 is gated on the
   re-validation returning GREEN; this re-validation is AMBER. The
   formalization-ready core (`thm:projection`, `thm:welldefined`,
   `thm:maschke`, `prop:y2a-mech`) is sound and would formalize
   cleanly — but `thm:y1-reduction` / `constr:bridge` carry the
   surviving over-claim and should be corrected first.

2. **Revise `paper/forkA/refoundation.tex` — one further honest
   re-statement.** Concretely:
   - **Construction `constr:bridge`.** Drop the claim that the twisted
     bridge "ports … gives `ι_x* ≃ 0`." State honestly that the
     twisted-bridge identity `ι_x* = ±½(dh − hd)` has a step ("`d`
     commutes with `χ_x·`") valid only on `χ_S`-supported cells
     (`mg-56b8` §8.1), that in the pre-Fork-A development `ι_x* ≃ 0`
     was a map of the `χ_S`-isotype sub-complexes `V_S^*`, and that
     Fork A — having dropped the Walsh grading as a grading of the
     complex (`rem:walsh-role2`) — does **not** inherit that
     sub-complex, so the bridge does not deliver `ι_x* ≃ 0` as an
     established Fork A input.
   - **Theorem `thm:y1-reduction`.** Record establishing `ι_x* ≃ 0` in
     the Fork A setting as **open work** — either a third sub-residual
     of `R1` (a Fork-A-native re-derivation of the bridge
     null-homotopy, or an explicit `χ_S`-to-`S_{n-1}` grading
     reconciliation beside `R1b`), or an explicit further hypothesis of
     the reduction. State `Y1`-A ⟸ `R1a` + `R1b` + (bridge
     null-homotopy), not `Y1`-A ⟸ `R1a` + `R1b`.
   - While there: state the base case of the simultaneous induction
     (§4.2), and make explicit in `prop:fact-one` that the
     punctured-poset-to-`F⋆` extension is part of the `R3` package
     (§4.1).
   With those edits the document would honestly describe what Phase 1
   delivered, and a further re-validation could return GREEN.

3. **The residual-closing work can still be scoped now**, with the
   corrected picture: `R1` carries, besides `R1a` (cofiber) and `R1b`
   (the `S_{n-1}→S_n` branching step), the Fork-A bridge null-homotopy
   as a third open piece. This is a genuine extra item, not a
   re-labelling — it is the `Y1`-side analogue of the `χ_S`-vs-`S_n`
   grading reconciliations the re-grading forces throughout.

4. **`paper/main.tex` stays as-is** (it honestly records the pre-Fork-A
   state) — unchanged from the Phase-1 and `mg-365e` recommendation.

### 5.3 The honest one-paragraph verdict

Independent re-validation confirms that the `mg-365e` revision correctly
executed the `mg-d300` §6.2 spec — `thm:y1-reduction`'s equivariance is
now `Stab(x) ≅ S_{n-1}` only, `R1b` the branching step is a genuine and
correctly-stated sub-residual, `thm:contradiction` honestly enumerates
all five inputs with the "exactly three" framing gone, and
`prop:sphere-sgn`'s hypothesis is correctly strengthened — and that the
GREEN spine (`π_T` a covariant functor, `H*(C_n;X)` genuinely defined
with `D²=0`, the Maschke `S_n`-decomposition, the `Y2`-A structural
mechanism) is sound and undisturbed. But the document is not GREEN: a
third over-claim of the identical "Walsh-graded fact treated as
portable" shape survives. The twisted-bridge null-homotopy `ι_x* ≃ 0`,
which `thm:y1-reduction` substitutes to collapse the cofiber LES, is
presented as an established, ported input in Construction
`constr:bridge`, but the pre-Fork-A source `mg-56b8` (§3.2, §8.1)
states plainly that it is a fact about the `χ_S`-isotype sub-complexes
`V_S^*` — its defining identity needs "`d` commutes with `χ_x·`," valid
only on `χ_S`-supported cells — and Fork A, having dropped the Walsh
grading as a grading of the complex (the document's own
`rem:walsh-role2`), has no such sub-complex; `constr:bridge`'s
justification rebuts only the irrelevant "group action" concern. This
is precisely the "second, compounding prong" of `mg-d300`'s Finding A,
which `mg-d300` raised in prose but omitted from its §6.2 fix-list, so
`mg-365e` carried `constr:bridge` through verbatim. The consequence is
that `thm:y1-reduction`'s reduction of `Y1`-A is not the clean
`R1a` + `R1b` the document claims, and the conditional theorem does not
rest on exactly the five cleanly-named inputs. The finding is fixable by
one further honest re-statement and is not a wall; the verdict is
**AMBER** — the Fork A strategy and its core constructions are sound,
the revision is a genuine improvement, but it is incomplete and must be
corrected before Phase 3.

### 5.4 Cross-references

- **Brief:** `mg-5221` (Frankl-ForkA-Phase2-Revalidation). **Routes
  to:** Daniel, via `pm-onethird`.
- **Deliverable re-validated:** `paper/forkA/refoundation.tex` (the
  `mg-365e`-revised document, commit `2de18da`).
- **The revision ledger:** `docs/Frankl-ForkA-Phase2-Revision.md`
  (`mg-365e`).
- **The prior validation (the two findings the revision corrected; §3.3
  the un-spec'd second prong; §6.2 the revision spec):**
  `docs/Frankl-ForkA-Phase2-validation.md` (`mg-d300`).
- **The Phase-1 ledger:** `docs/Frankl-ForkA-Refound-LaTeX.md`
  (`mg-c15b`).
- **The pre-Fork-A cofiber-LES reduction — the source for the
  twisted-bridge null-homotopy (§3.2 the bridge gives `ι_x* ≃ 0` on
  `V_S^*`; §8.1 the "`d` commutes with `χ_x·`" / `χ_S`-support soft
  spot):** `docs/Frankl-Y1-reprove.md` (`mg-56b8`).
- **Fork A endorsement / the two debts:**
  `docs/Frankl-ForkD-Probe-n3.md` (`mg-565a`).
- **Onboarding:** `docs/PROOF-STRUCTURE-ONBOARDING.md`.

---

*Phase-2 independent re-validation by polecat `cat-mg-5221`. Deliverable
on `main`: this document. Verdict: **AMBER — THE THREE SPEC'D FIXES
LANDED AND THE SPINE IS SOUND, BUT A THIRD OVER-CLAIM OF THE SAME SHAPE
SURVIVES.** The `mg-365e` revision correctly executed the `mg-d300` §6.2
spec — `thm:y1-reduction` equivariance now `Stab(x) ≅ S_{n-1}` only,
`R1b` a genuine branching sub-residual, `thm:contradiction` enumerating
all five inputs, `prop:sphere-sgn` hypothesis strengthened — and the
GREEN spine (`thm:projection`, `thm:welldefined` `D²=0`, `thm:maschke`,
`prop:y2a-mech`) is independently re-confirmed sound and undisturbed.
But the document is not GREEN: the twisted-bridge null-homotopy
`ι_x* ≃ 0`, substituted in `thm:y1-reduction` to collapse the cofiber
LES, is presented as an established, ported input (`Construction
constr:bridge`) when it is intrinsically a `χ_S`-isotype-sub-complex
fact (`mg-56b8` §3.2, §8.1) with no referent in Fork A, which drops the
Walsh grading as a grading of the complex (`rem:walsh-role2`). This is
the "second, compounding prong" of `mg-d300`'s Finding A — raised in
`mg-d300` §3.3 but omitted from its §6.2 fix-list, so `constr:bridge`
was carried through the revision verbatim. The conditional theorem
therefore does not rest on exactly the five named inputs:
`thm:y1-reduction`'s reduction of `Y1`-A also depends on a bridge
null-homotopy presented as discharged. Fixable by one further honest
re-statement (re-state `constr:bridge`; record the bridge
null-homotopy as open work in `R1`); not a wall. Recommended next:
revise `refoundation.tex` per §5.2, then a further re-validation before
Phase 3 (Lean).*
