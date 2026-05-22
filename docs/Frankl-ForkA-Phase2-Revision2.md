# Frankl-ForkA-Phase2-Revision2 — re-stating constr:bridge and the exhaustive portable-Walsh-fact sweep

**Work item:** `mg-894c` (Frankl-ForkA-Phase2-Revision2). Per the
`mg-5221` (Frankl-ForkA-Phase2-Revalidation) **AMBER** independent
re-validation of the revised Fork A re-foundation. This ticket
deliberately **breaks the validate–revise loop's converge-by-attrition
pattern**: the loop had caught one over-claim of the same shape per
round (`mg-d300` two, `mg-5221` a third); this revision both does the
`mg-5221` re-statement *and* runs an exhaustive sweep so the next
re-validation can certify there is no fourth.

**READ-FIRST consumed:** `docs/Frankl-ForkA-Phase2-Revalidation.md`
(`mg-5221` — §3 the surviving over-claim, §4 the minor points, §5.2
the re-statement spec); `paper/forkA/refoundation.tex` (the deliverable
being revised); `docs/Frankl-ForkA-Phase2-validation.md` (`mg-d300` —
§3.3 the "second, compounding prong" that this ticket closes);
`docs/Frankl-Y1-reprove.md` (`mg-56b8` — the pre-Fork-A cofiber-LES
reduction, the source of the χ_S-graded facts).

**Deliverable:** the revised `paper/forkA/refoundation.tex`, the
updated `paper/forkA/README.md`, and this ledger note. The
consolidated paper (`paper/main.tex`) is **not** edited; no Lean
change.

---

## §0 — What this revision is

`mg-5221` independently re-validated the `mg-365e`-revised Fork A
re-foundation and returned **AMBER — THE THREE SPEC'D FIXES LANDED AND
THE SPINE IS SOUND, BUT A THIRD OVER-CLAIM OF THE SAME SHAPE
SURVIVES.** It confirmed the three `mg-365e` fixes correct and the
GREEN spine (`thm:projection`, `thm:welldefined` `D²=0`, `thm:maschke`,
`prop:y2a-mech`) independently sound — but caught a **third over-claim
of the identical "Walsh / χ_S-isotype-graded fact silently treated as
portable to Fork A" shape**: the twisted-bridge null-homotopy
`ι_x* ≃ 0`, presented in Construction `constr:bridge` as an
established, ported input.

This is the **third** instance the validate–revise loop has caught of
the *same* mistake:

| Round | Caught by | The ported χ_S-graded fact mistaken for portable | Disposition |
|---|---|---|---|
| Phase-1 self-audit | `mg-c15b` | the `Y2` "standard-isotypic, hence sgn-free" landing theorem | withdrawn → residual **R2** |
| Phase-2 validation | `mg-d300` | the `Y1` cofiber-LES **equivariance** (`S_n` vs `S_{n-1}`) | re-stated → residual **R1b** |
| Phase-2 re-validation | `mg-5221` | the `Y1` twisted-bridge **null-homotopy** `ι_x* ≃ 0` | **this ticket** → residual **R1c** |

`mg-5221` itself observed (§3.3) that the third is precisely
`mg-d300`'s "second, compounding prong" of Finding A — raised by
`mg-d300` in prose but dropped from its §6.2 fix-list, so the
`mg-365e` revision carried `constr:bridge` through verbatim. The loop
was peeling one prong per round. **This ticket ends that pattern**: it
re-states `constr:bridge` *and* enumerates every ported Walsh / χ_S
fact in the document, so the conditional theorem's input list is
complete and final.

As with `mg-365e`, this is an **honest re-statement, not a
refutation**. No new mathematics; no change to the construction; no
change to the strategy. The Fork A object, the re-grading, and the
conditional contradiction are unchanged in substance — what changes is
the *accounting* of what the contradiction rests on. `ι_x* ≃ 0` may
well be true in Fork A; it is simply not *discharged* by the ported
twisted bridge.

---

## §1 — The constr:bridge re-statement (R1c)

### 1.1 The over-claim

Construction `constr:bridge` ("The matched-cylinder bridge") asserted,
verbatim:

> "The harmonic twist by `χ_x` used in the pre-Fork-A bridge is, in
> Fork A, simply pointwise multiplication by the fixed function `χ_x`
> (Role 2, Remark `rem:walsh-role2`) — a cochain operation, not a group
> action — so the twisted bridge identity `ι_x* = ±½(dh − hd)` also
> ports without a `(Z/2)^n`-action. **It gives `ι_x* ≃ 0`, the input
> the reduction uses.**"

`thm:y1-reduction` step (2) then **substitutes** this null-homotopy to
collapse the cofiber LES. So `ι_x* ≃ 0` is load-bearing, and it was
presented as **established** — inside a `Construction` environment,
with no hedge and no residual flag.

### 1.2 Why it is an over-claim

The justification — the `χ_x`-twist "is a cochain operation, not a
group action" — is a **non sequitur**. Whether the twist is a group
action or a cochain operation is irrelevant; what the twisted-bridge
identity `ι_x* = ±½(dh − hd)` needs is that the cubical coboundary `d`
**commute** with multiplication by `χ_x`. The pre-Fork-A source is
explicit (`mg-56b8` §8.1) that this step — "`d` commutes with `χ_x·`"
— is **valid only on `χ_S`-supported cells**. So in the pre-Fork-A
development `ι_x* ≃ 0` is, at honest strength, a fact about the
**`χ_S`-isotype sub-complexes `V_S^*`** (`mg-56b8` §3.2: "`ι_x*` is
null-homotopic on `V_S^*`") — those `V_S^*` being genuine
sub-complexes, the isotypes of the `(Z/2)^n`-action on the hocolim.

Fork A removes exactly that structure. It drops the `(Z/2)^n`-action,
so there is **no `V_S^*` sub-complex**; and the document's own
`rem:walsh-role2` records that `d` does **not** preserve harmonic
level on `X(F)` — equivalently, `d` does not commute with
`χ_x`-multiplication. Hence in Fork A the `χ_S`-graded pieces are not
sub-complexes, the twisted-bridge identity does not hold as a
whole-complex identity, and the only honest pre-Fork-A form of
`ι_x* ≃ 0` — "a map of `χ_S`-isotype sub-complexes `V_S^*`" — has **no
referent in Fork A**.

### 1.3 The re-statement applied to refoundation.tex

Per `mg-5221` §5.2, the twisted-bridge null-homotopy is demoted from a
discharged Construction to **open work — a third `R1` sub-residual,
R1c**. Concretely:

- **`constr:bridge`** is re-titled "The matched-cylinder prism
  operator" and its scope shrunk to what genuinely ports: the matched
  cylinder and the geometric degree-`(-1)` prism operator `h` (a
  geometric construction on cells, needing no group action). The
  sentence claiming the twisted bridge "ports … gives `ι_x* ≃ 0`" is
  **deleted**.
- A new **Remark `rem:bridge-not-ported`** ("The twisted-bridge
  null-homotopy does not port as a discharged input — sub-residual
  R1c") states honestly: the `χ_S`-support soft spot (`mg-56b8` §8.1),
  that the pre-Fork-A `ι_x* ≃ 0` was a map of `V_S^*` sub-complexes,
  that Fork A has no such sub-complex, that the "cochain operation not
  a group action" justification is a non sequitur and is **withdrawn**,
  and that establishing `ι_x* ≃ 0` in Fork A is genuine open work.
- **`thm:y1-reduction`**: statement (2) now flags that the
  null-homotopy is substituted "*when* it is available: in Fork A it
  is *not* a discharged input but the open sub-residual R1c." The
  conclusion is re-stated: `Y1`-A reduces to **three** steps —
  (a) the cofiber R1a, (b) the branching step R1b, **(c) establishing
  the bridge null-homotopy R1c** — not two. The proof sketch's "the
  bridge gives `ι_x* = 0`" is re-stated as "*granting* the bridge
  null-homotopy … which in Fork A is the open sub-residual R1c."
- **`res:y1`** ("The `Y1` residual — R1") is re-titled "in three
  parts" and gains the **R1c** bullet. The honest-statement paragraph
  now records that R1's reduction acquires *two* new sub-residuals
  (R1b and R1c), both created by the `(Z/2)^n→S_n` re-grading.
- **`thm:contradiction`** input (v) now states that `Y1`-A, by
  `thm:y1-reduction`, rests on the **three-part** `R1` residual: R1a,
  R1b, **and R1c**. (The five-input enumeration (i)–(v) of
  `thm:contradiction` itself is unchanged and was confirmed honest by
  `mg-5221` §2.4; the gap was one level down, in how input (v)/`R1`
  decomposes.)
- Propagated through every dependent passage: §0.1 headline R1
  itemization, §0.2 scorecard (the `Y1`-A row and the Owed-debt-1
  row), the abstract, `status:c-block`, `status:y1a`,
  `rem:honest-shape`, `ssec:debt1` (the "Localized" enumeration now
  three items), `ssec:open`, `ssec:delivered`, `ssec:verdict`,
  `ssec:final`, and the footer.

### 1.4 Two minor points from `mg-5221` §4, also addressed

- **§4.2 — the base case of the simultaneous induction.** `mg-5221`
  §4.2 (echoing `mg-d300` §5.2) noted `thm:y1-reduction` invokes "the
  simultaneous induction on `n`" without ever stating the base case.
  The revised `thm:y1-reduction` step (a) and `res:y1` R1a now state
  it: the induction is **based at the finite check `n = 2`** — the
  families on a two-element ground set are finite and directly
  computable, the same base verification the pre-Fork-A development
  relied on for the `n = 2` sphere class (`mg-56b8` §2.2).
- **§4.1 — the punctured-poset-to-`F⋆` extension in `prop:fact-one`.**
  `mg-5221` §4.1 noted that `prop:fact-one`'s proof passes from a
  global section "valid on all of `C_n(F⋆)` — including the top object
  `F⋆`," but `F_obs` is defined on the **punctured** poset
  `C_n(F⋆)∖{F⋆}`, so the extension to `F⋆` is a further step that
  should be attributed to the `R3` package. The revised
  `prop:fact-one` proof now says so explicitly — the
  punctured-poset-to-`F⋆` promotion is part of the edge-map
  **existence** part R3a — and `status:fact-one` records it.

---

## §2 — The exhaustive portable-Walsh-fact sweep

This is the part of the ticket that breaks the converge-by-attrition
pattern. Every fact in `refoundation.tex` ported from the pre-Fork-A
**Walsh / χ_S-isotype-graded framework** (`mg-56b8` and earlier) is
enumerated below, with its location, its pre-Fork-A source, and its
disposition: **has-genuine-Fork-A-referent**, **explicitly-dropped**,
or **demoted-to-named-residual**. The next re-validation audits the
sweep against this table.

### 2.1 The pattern being swept for

The over-claim shape, three times caught: *a fact that in the
pre-Fork-A development is intrinsically about the Walsh / χ_S-isotype
grading of the **cohomology** (or about the `(Z/2)^n`-action that
grading rests on), silently carried into Fork A — which has dropped
that grading — as though it still had a referent.* The discriminator:
Fork A keeps Walsh **only in its "Role 2"** — the harmonic basis as a
labelling of the obstruction **cochain** (`rem:walsh-role2`). Any
ported fact that needs Walsh as a grading of **cohomology**, or needs
`V_S^*` to be a **sub-complex**, or needs the `(Z/2)^n`-action, has no
Fork A referent and must be either dropped or demoted to a residual.

### 2.2 The ledger — every ported Walsh / χ_S fact and its disposition

| # | Ported Walsh / χ_S fact | Location in `refoundation.tex` | Pre-Fork-A source | Disposition |
|---|---|---|---|---|
| **W1** | The Walsh character basis `χ_U` as the **harmonic description of the obstruction cochain** (Role 2) — bias = level-1 Walsh–Fourier coefficient; obstruction cochain built from level-1 data | `rem:walsh-role2`; `def:obs-sheaf` (the `[χ_x]` labelling) | `mg-56b8` §1.1 (UC10.W, Role 2) | **HAS FORK A REFERENT.** Used *only* as a function basis labelling a *cochain* — no group action, no cohomology grading. `rem:walsh-role2` is explicit and honest about the limit ("Walsh level grades cochains, not cohomology"). Portable. |
| **W2** | The Walsh decomposition as a **grading of cohomology**: `C*(X_n∩) = ⊕_S χ_S ⊗ V_S^*`, each `V_S^*` a genuine sub-cochain-complex | — (explicitly **not** used) | `mg-56b8` §1.1 (UC10.W) | **EXPLICITLY DROPPED.** Fork A drops the `(Z/2)^n`-action (`status:c-block`, `ssec:drop-z2`); the cohomology grading is *replaced* by the genuine `S_n`-isotype decomposition (`thm:maschke`). Not ported; no referent claimed. `rem:maschke-analogue` is explicit that the two gradings "are different decompositions … not nested." |
| **W3** | The obstruction cochain is **level-1 harmonic**; the Čech differential preserves harmonic level | `prop:y2a-mech`(2) | `mg-56b8` (UC14 Lemma 2.2.1, single-family cell-level) | **HAS FORK A REFERENT.** Explicitly a *cochain*-level statement (`prop:y2a-mech`(2): "at the cochain level"). `res:y2` is honest that harmonic level is **not** a cohomology grading, so "the cochain is level-1" does **not** pin the class's isotype. Portable as a cochain-level fact only; the class-level question is residual R2. |
| **W4** | The cofiber LES of the pair `(X_n, X_{n-1,x})` and its **equivariance** | `thm:y1-reduction`(1) | `mg-56b8` §3.1 (LES-S, `(Z/2)^n`-equivariant, split into Walsh isotypes) | **DEMOTED → residual R1b.** The `(Z/2)^n`-equivariance does not port; the pair keeps only `Stab(x) ≅ S_{n-1}` symmetry. Caught by `mg-d300` Finding A prong 1; fixed by `mg-365e`. The `S_{n-1}→S_n` recovery is the named residual R1b. |
| **W5** | The **twisted-bridge null-homotopy `ι_x* ≃ 0`** | `constr:bridge` → `rem:bridge-not-ported` | `mg-56b8` §3.2 (twisted bridge, `ι_x* ≃ 0` on `V_S^*`) | **DEMOTED → residual R1c (THIS TICKET).** A `χ_S`-isotype-sub-complex fact (`mg-56b8` §3.2, §8.1); Fork A has no `V_S^*` sub-complex. Caught by `mg-5221`. The named residual R1c. See §1. |
| **W6** | The collapse of the cofiber LES to a short exact sequence → the reduction `j*: V_S^k(cofib ι_x) ≅ V_S^k(X_n∩)` | `thm:y1-reduction`(2) and proof sketch | `mg-56b8` §3.2–§3.4 (SES-S, RED) | **CONDITIONAL — all ingredients are named residuals.** The collapse substitutes `ι_x* ≃ 0` (now R1c) and uses the smaller-cube vanishing (R1a). `thm:y1-reduction` now states the collapse conditionally ("*when* it is available … the open sub-residual R1c"). Not a separate over-claim: the *mechanism* of an honestly-conditional theorem. |
| **W7** | The smaller-cube term vanishes by the **simultaneous induction** (incl. the degree-0 connectedness `V_S^0 = 0` for `S ≠ ∅`) | `thm:y1-reduction`(2) step (a); `res:y1` R1a | `mg-56b8` §3.3, §2.1 | **FOLDED INTO residual R1a.** In Fork A the smaller-ground-set term is `H̃^{k-1}(X_{n-1,x})_{[μ]}`; its vanishing is internal to R1a's `S_{n-1}`-isotype simultaneous induction. The **base case** (`n = 2`), previously un-stated, is now stated (§1.4). |
| **W8** | The `|S| ≤ n-2` vs `|S| = n-1` **sub-case structure** / the sphere-class collision | `thm:y1-reduction` proof sketch | `mg-56b8` §2.3, §6 | **FOLDED INTO residual R1a.** The `|S|`-indexed split is a Walsh-index distinction with no Fork A referent *as such*; the analogous `S_{n-1}`-isotype sub-case structure is internal to R1a's induction. The proof sketch wording was softened — "carries over an **analogous** sub-case structure … **all of it internal to the open cofiber residual R1a**" (was: "the *same* sub-case structure"). Not presented as discharged. |
| **W9** | The Walsh-index **bookkeeping** (for `x ∉ S`, `χ_S` restricted along `ι_x` stays `χ_S`) | — (not present in `refoundation.tex`) | `mg-56b8` §2.3 | **NOT PORTED / NOT NEEDED.** Pure `χ_S`-index bookkeeping, meaningful only with the χ_S grading. In Fork A the analogue is the `S_{n-1}`-restriction — exactly what R1b handles. Not used in the document; nothing to demote. |
| **W10** | The obstruction class lands in **degree `n-1`** (pre-Fork-A: the top degree of the level-1 Walsh isotype `V_x^{n-1}`) | `def:ob`; `rem:promotion`; `debt:faithful-localized` R3b | `mg-56b8` / UC10 | **DEMOTED → residual R3b.** The degree count `n-1` is inherited from the now-defunct `X_n∩`; `rem:promotion` and R3b say so. Already a named residual (the `mg-365e` revision). |
| **W11** | The `χ_{[n]} ⊠ sgn_{S_n}` sphere-class **target** | `rem:sgn-always-sn` | UC10 / UC12 | **HAS FORK A REFERENT (sgn factor) / EXPLICITLY DROPPED (χ factor).** `rem:sgn-always-sn` honestly keeps `sgn_{S_n}` (always carried by the genuine `S_n`-action) and discards the `χ_{[n]}` `(Z/2)^n`-decoration. Honest accounting; the surviving `sgn_{S_n}` is an `S_n`-fact, not a Walsh fact. |

### 2.3 The conclusion of the sweep — no fourth prong

After this revision demotes **W5** to residual R1c, every ported
Walsh / χ_S fact in `refoundation.tex` falls into exactly one of:

1. **Has a genuine Fork A referent** — W1, W3, W11 (sgn part): the
   Walsh basis used in its harmonic **Role 2**, as a labelling of the
   obstruction **cochain**, never as a grading of cohomology.
   `rem:walsh-role2` and `res:y2` are explicit and honest about the
   limit.
2. **Explicitly dropped** — W2, W11 (χ factor): the Walsh grading of
   **cohomology** and the `χ_{[n]}` decoration are dropped, replaced
   by the genuine `S_n`-isotype decomposition. No portability claimed.
3. **A named residual** — W4 (R1b), W5 (R1c), W7 + W8 (R1a), W10
   (R3b); W6 is the honestly-conditional *mechanism* of
   `thm:y1-reduction`, resting on R1a + R1c. W9 is not present in the
   document.

**There is no fourth instance of the over-claim shape.** No ported
Walsh / χ_S-graded fact is treated as a discharged Fork A input
without a genuine referent. The conditional theorem
`thm:contradiction` rests on, and explicitly lists, exactly:

> **R3a, R3b, R3c** (the three-part edge-map debt) · **R2** (the
> landing) · **R1** = **R1a + R1b + R1c** (the three-part `Y1`
> residual).

**This input list is complete and final.** Nothing further is owed
that the document presents as discharged.

### 2.4 Note for the next re-validation

The one place a skeptical re-validator should look hardest is **W8**
(the sub-case structure) and **W6** (the LES collapse). Both are
ported from `mg-56b8`'s χ_S-graded machinery and both are now declared
"internal to R1a" / "conditional on R1c." The claim of this sweep is
that they are *not* separate over-claims because the document no
longer presents either as discharged: `thm:y1-reduction` is honestly
conditional on R1a + R1b + R1c, and R1a explicitly absorbs the cofiber
computation, the simultaneous induction, and the sub-case structure
(including the `|S| = n-1` sphere-class collision of `mg-56b8` §6). If
a re-validator judges that the `|S| = n-1` sub-case — which `mg-56b8`
§6 notes "must be done with the R3 machinery, separately" (a different,
top-isotype bridge) — deserves its own named residual rather than
folding into R1a/R1c, that would be a refinement of the residual
*labelling*, not a fourth over-claim: the document already declares
the whole sub-case structure open. R1c as stated ("establishing the
twisted-bridge null-homotopy `ι_x* ≃ 0` in the Fork A setting")
covers whatever bridge variant the closure ultimately needs.

---

## §3 — What this revision leaves untouched

- The **construction** — `π_T` as a covariant functor
  (`thm:projection`), the Bousfield–Kan double complex and `D²=0`
  (`thm:welldefined`), the Maschke `S_n`-decomposition
  (`thm:maschke`), the `Y2`-A structural mechanism
  (`prop:y2a-mech`). `mg-d300` and `mg-5221` both independently
  confirmed all of these sound; the revision does not touch them.
- The **Fork A strategy** — the covariant hocolim re-foundation, the
  `(Z/2)^n` drop, the `sgn_{S_n}` re-grading. Unchanged and endorsed.
- The three `mg-365e` fixes — `thm:y1-reduction` equivariance
  (`Stab(x) ≅ S_{n-1}` only), `R1b`, the five-input enumeration of
  `thm:contradiction`, the strengthened `prop:sphere-sgn` hypothesis.
  `mg-5221` confirmed all four correct; the revision keeps them and
  builds R1c alongside R1b.
- The Phase-1 self-correction — the withdrawn "standard-isotypic"
  landing over-claim — stays withdrawn; `R2` stays the honest
  residual.
- No Lean change; no edit to `paper/main.tex`; no new axiom. The Lean
  headline `Frankl_Holds`'s dependence on
  `case3_ss_obstruction_paper_axiom` is unaffected.

After this revision the conditional theorem `thm:contradiction` rests
on, and explicitly lists: **R1** (three-part — R1a the cofiber, R1b
the `S_{n-1}→S_n` branching step, R1c the twisted-bridge
null-homotopy), **R2** (the landing), and **R3** (three-part — R3a
existence, R3b degree, R3c injectivity of the edge map).

---

## §4 — Recommendations (routed to Daniel via pm-onethird)

1. **A further independent re-validation** of the twice-revised
   `refoundation.tex`, carrying the explicit **pattern-sweep mandate**:
   confirm that `constr:bridge` no longer claims the twisted bridge
   "ports," that R1c is genuinely recorded, and — auditing against the
   §2.2 ledger table — that the exhaustive sweep is complete and there
   is no fourth ported Walsh / χ_S fact treated as portable. On its
   GREEN, the residual-closing work and Phase 3 (Lean) are unblocked.
2. **Then the residual-closing work**, with the corrected picture: R1
   is now three-part (R1a cofiber, R1b branching, R1c bridge
   null-homotopy); R3 is three-part. R1c may be closed either by a
   Fork-A-native re-derivation of `ι_x* ≃ 0` or by an explicit
   `χ_S`-to-`S_{n-1}` grading reconciliation (a second
   representation-theoretic reconciliation beside R1b).
3. **Then Phase 3 (Lean)**, gated on the re-validation returning GREEN.
4. **`paper/main.tex` stays as-is** (it honestly records the
   pre-Fork-A state) — unchanged from the Phase-1, `mg-365e`, and this
   recommendation.

---

## §5 — Cross-references

- **Brief:** `mg-894c` (Frankl-ForkA-Phase2-Revision2). **Routes to:**
  Daniel, via `pm-onethird`.
- **The Phase-2 re-validation being acted on:**
  `docs/Frankl-ForkA-Phase2-Revalidation.md` (`mg-5221`; §3 the
  surviving twisted-bridge over-claim, §4 the minor points, §5.2 the
  re-statement spec).
- **The prior Phase-2 validation (the un-spec'd "second prong" this
  ticket closes):** `docs/Frankl-ForkA-Phase2-validation.md`
  (`mg-d300`; §3.3).
- **The prior revision ledger:**
  `docs/Frankl-ForkA-Phase2-Revision.md` (`mg-365e`).
- **The deliverable revised:** `paper/forkA/refoundation.tex`
  (+ `paper/forkA/README.md`).
- **The Phase-1 ledger note:** `docs/Frankl-ForkA-Refound-LaTeX.md`
  (`mg-c15b`).
- **The pre-Fork-A cofiber-LES reduction — the source of the χ_S-graded
  facts (§3.2 the twisted bridge `ι_x* ≃ 0` on `V_S^*`; §8.1 the
  "`d` commutes with `χ_x·`" / `χ_S`-support soft spot):**
  `docs/Frankl-Y1-reprove.md` (`mg-56b8`).
- **Fork A endorsement / the two debts:**
  `docs/Frankl-ForkD-Probe-n3.md` (`mg-565a`).
- **Onboarding:** `docs/PROOF-STRUCTURE-ONBOARDING.md`.

---

*Phase-2-re-validation revision by polecat `cat-mg-894c`. Deliverables
on `main`: the revised `paper/forkA/refoundation.tex`, the updated
`paper/forkA/README.md`, and this ledger note. The revision is an
honest re-statement of the third over-claim the `mg-5221` independent
re-validation caught — the twisted-bridge null-homotopy `ι_x* ≃ 0`,
presented in Construction `constr:bridge` as a discharged ported input
when it is a `χ_S`-isotype-sub-complex fact with no Fork A referent,
now demoted to the open sub-residual R1c — plus the two minor `mg-5221`
§4 points (the simultaneous-induction base case, the
punctured-poset-to-`F⋆` extension in `prop:fact-one`), plus an
**exhaustive sweep** of every fact in `refoundation.tex` ported from
the pre-Fork-A Walsh / χ_S-isotype-graded framework (§2.2 ledger
table). The sweep certifies: with R1c demoted, every ported Walsh fact
either has a genuine Fork A referent (the Walsh basis in its harmonic
Role 2, labelling the obstruction cochain), is explicitly dropped (the
Walsh grading of cohomology), or is a named residual — there is no
fourth prong, and the input list of `thm:contradiction` (R3a, R3b,
R3c, R2, R1 = R1a+R1b+R1c) is complete and final. No new mathematics:
the Fork A construction, the re-grading, and the conditional
contradiction are unchanged in substance; the Fork A strategy stays
sound. Recommended next: a further independent re-validation carrying
the pattern-sweep mandate, then the residual-closing work and Phase 3
(Lean).*
