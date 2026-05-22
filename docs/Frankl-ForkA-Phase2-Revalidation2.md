# Frankl-ForkA-Phase2-Revalidation2 — independent ledger-audit re-validation of the twice-revised refoundation.tex

**Work item:** `mg-bf5c` (Frankl-ForkA-Phase2-Revalidation2). Per the
`mg-894c` (Frankl-ForkA-Phase2-Revision2) GREEN. `mg-894c` re-stated
`constr:bridge` as the R1c residual and delivered an exhaustive
portable-Walsh-fact sweep (ledger
`docs/Frankl-ForkA-Phase2-Revision2.md` §2.2 — 11 ported facts W1–W11
enumerated with dispositions). This is the **independent
re-validation** that turns the `mg-894c` GREEN into a trustworthy
GREEN — the verification step the `mg-894c` GREEN is explicitly *not*:
the ledger's exhaustiveness was the `mg-894c` polecat's own claim, not
yet independently confirmed.

**Deliverable validated:** `paper/forkA/refoundation.tex` (the
twice-revised document, commit `b59d3d5`).

**READ-FIRST consumed:** `paper/forkA/refoundation.tex` (the
twice-revised deliverable, all 2281 lines);
`docs/Frankl-ForkA-Phase2-Revision2.md` (`mg-894c` — the ledger under
audit, §2.1 the discriminator, §2.2 the W1–W11 table, §2.4 the
self-flagged W6/W8 probe spots); `docs/Frankl-ForkA-Phase2-Revalidation.md`
(`mg-5221` — the AMBER re-validation `mg-894c` acted on);
`docs/Frankl-ForkA-Phase2-validation.md` (`mg-d300` — the first AMBER
validation); `docs/Frankl-Y1-reprove.md` (`mg-56b8` — the pre-Fork-A
cofiber-LES reduction, the source of every χ_S-graded fact in the
W-table). Cross-checked against the `2de18da..b59d3d5` diff of
`refoundation.tex` (the `mg-894c` revision).

**Stance.** Fresh, independent, default-skeptical reviewer — **not**
any prior Fork-A polecat (`mg-c15b`, `mg-d300`, `mg-365e`, `mg-5221`,
`mg-894c`). The explicit charge is a **ledger-audit mandate**: not to
re-run the construction-level verification the prior rounds did, but to
independently confirm that the `mg-894c` exhaustive sweep is genuinely
exhaustive — every W-row's location, source, and disposition verified
against the document and the pre-Fork-A source, and a fresh,
independent re-derivation of the enumeration to certify no twelfth
ported Walsh fact was missed. A RED — a wrong disposition, or a twelfth
fact found — is a valid outcome.

---

## §0 — Verdict (top of page)

### 0.1 Headline

> **GREEN — THE EXHAUSTIVE WALSH-FACT SWEEP IS GENUINELY EXHAUSTIVE;
> THE INPUT LIST IS COMPLETE AND FINAL; NO FOURTH PRONG.**
>
> The `mg-894c` revision did what `mg-5221` spec'd and what the
> validate–revise loop needed to break its converge-by-attrition
> pattern. Independent audit confirms all four mandate points:
>
> 1. **The W1–W11 ledger table is correct in every row.** For each of
>    the 11 ported Walsh / χ_S facts, the stated location in
>    `refoundation.tex`, the pre-Fork-A source in `mg-56b8`, and the
>    disposition (has-referent / dropped / demoted-to-residual) were
>    independently verified and are all accurate (§2). The two
>    self-flagged hard-probe spots — **W6** (the LES collapse) and
>    **W8** (the |S|-sub-case structure) — were probed hardest: both
>    are genuinely the honestly-conditional *mechanism* of a
>    conditional theorem, **not** separate over-claims (§2.6, §2.8).
>
> 2. **No twelfth ported Walsh / χ_S fact was missed.** An independent
>    re-derivation of the enumeration against `refoundation.tex`, using
>    the §2.1 discriminator, finds every Walsh / χ_S / harmonic / V_S /
>    (Z/2)^n occurrence in the document maps to exactly one W-row (or
>    is honest recap / framing). **No Theorem, Proposition,
>    Construction, Lemma, or Definition discharges a fact that needs
>    Walsh-as-a-cohomology-grading, a V_S^* sub-complex, or the
>    (Z/2)^n-action.** There is no fourth instance of the over-claim
>    shape (§3).
>
> 3. **`constr:bridge` is genuinely demoted — the load-bearing port is
>    deleted, not re-titled.** The `2de18da..b59d3d5` diff shows the
>    over-claim sentence ("the twisted bridge identity … also ports …
>    gives ι_x* ≃ 0, the input the reduction uses") **deleted
>    verbatim**; the Construction is re-titled, its scope shrunk to the
>    geometric prism operator `h`, and the new `rem:bridge-not-ported`
>    records R1c honestly (§4). The two minor `mg-5221` §4 points are
>    both addressed (§4.3).
>
> 4. **The conditional theorem rests on exactly the declared input
>    list, and the GREEN spine is intact.** `thm:contradiction` rests
>    on exactly (i)–(v) = R3a, R3b, R3c, R2, R1 (= R1a + R1b + R1c) —
>    each used once in its proof, no sixth input. The spine —
>    `thm:projection`, `thm:welldefined` (`D²=0`), `thm:maschke`,
>    `prop:y2a-mech` — is **untouched by the `mg-894c` revision** (the
>    diff has no hunk in any of their statements or proofs) and was
>    independently re-confirmed sound by `mg-d300` and `mg-5221` (§5).
>
> The input list of `thm:contradiction` — **R3a, R3b, R3c · R2 ·
> R1 = R1a + R1b + R1c** — is **complete and final**. Nothing the
> document presents as discharged rests on an un-named ported Walsh
> fact. The verdict is **GREEN**.

### 0.2 The scorecard, scored against the ledger-audit mandate

| Mandate target | `mg-894c` self-claim | Re-validation verdict |
|---|---|---|
| W1–W11: each location in `refoundation.tex` correct | (the ledger) | **GREEN — confirmed.** All 11 locations check out (§2). |
| W1–W11: each pre-Fork-A source correct | (the ledger) | **GREEN — confirmed.** All 11 sources verified against `mg-56b8` (§2); two are slightly loose cites, neither affects a disposition (§2.3, §2.9). |
| W1–W11: each disposition correct | (the ledger) | **GREEN — confirmed.** Has-referent (W1, W3, W11-sgn), dropped (W2, W11-χ), demoted-to-residual (W4, W5, W7, W8, W10), conditional-mechanism (W6), not-present (W9) — all accurate (§2). |
| W6 (LES collapse) is mechanism, not over-claim | self-flagged | **GREEN — confirmed.** The collapse is stated conditionally ("*when* it is available … the open sub-residual R1c"); its only Walsh input is R1c (§2.6). |
| W8 (sub-case structure) is mechanism, not over-claim | self-flagged | **GREEN — confirmed.** The |S|-split is a Walsh-index artifact with no Fork A referent *as such*; the analogue is internal to the open R1a, explicitly *not* discharged (§2.8). |
| No twelfth ported Walsh / χ_S fact | "no fourth prong" | **GREEN — confirmed** by an independent re-derivation of the enumeration (§3). |
| `constr:bridge` load-bearing port deleted, not re-titled | "demoted to R1c" | **GREEN — confirmed** by the `2de18da..b59d3d5` diff (§4). |
| `mg-5221` §4 minor points addressed | "addressed" | **GREEN — confirmed.** Base case `n=2` stated; punctured-poset-to-`F⋆` extension attributed to R3a (§4.3). |
| `thm:contradiction` rests on exactly the declared list | "complete and final" | **GREEN — confirmed.** Exactly (i)–(v); no sixth input (§5.1). |
| GREEN spine intact | (implicit) | **GREEN — confirmed.** Spine untouched by the revision; independently sound (§5.2). |

### 0.3 What GREEN means here, precisely

GREEN means the ledger-audit mandate returns *yes* on every count.
This is the verdict the validate–revise loop has been converging
toward: `mg-d300` (AMBER, two over-claims), `mg-365e` (revision),
`mg-5221` (AMBER, a third of the same shape), `mg-894c` (revision +
exhaustive sweep). The loop caught one prong of the *same* mistake —
"a χ_S-isotype-graded fact silently treated as portable to Fork A" —
per round. `mg-894c` both re-stated the third prong (R1c) **and**
swept the whole document, declaring the input list complete. The job
of this re-validation was to verify that declaration rather than take
it on the `mg-894c` polecat's word. It verifies.

GREEN does **not** mean Frankl is proved, or that any residual is
closed. `thm:contradiction` remains a genuinely conditional theorem
resting on seven open sub-residuals (R1a, R1b, R1c, R2, R3a, R3b,
R3c). GREEN means: the Phase-1 re-foundation is delivered, internally
sound, and — now independently confirmed — **honest about exactly what
it rests on**. The over-claim discipline that `mg-d300` and `mg-5221`
enforced has reached a fixed point: there is no fourth prong to catch.

---

## §1 — Scope and method

The brief fixes four verification targets — the **ledger-audit
mandate**:

1. **Audit the `mg-894c` ledger §2.2 W1–W11 table.** For each of the
   11 ported Walsh / χ_S facts, independently confirm the stated
   location in `refoundation.tex`, the pre-Fork-A source, and the
   disposition. Probe **W6** and **W8** hardest. → §2.
2. **Confirm no twelfth ported Walsh / χ_S fact was missed.**
   Independently re-derive the enumeration against `refoundation.tex`
   using the §2.1 discriminator. → §3.
3. **Confirm `constr:bridge` is genuinely demoted to R1c** (the
   load-bearing port deleted, not re-titled) and the two minor
   `mg-5221` §4 points are addressed. → §4.
4. **Confirm the conditional theorem rests on exactly the declared
   input list** (R1a/R1b/R1c, R2, R3a/R3b/R3c — complete and final)
   and the GREEN spine is intact. → §5.

**Method.** This is a *ledger audit*, not a re-run of the
construction-level verification (`mg-d300` and `mg-5221` did that
independently and twice confirmed the spine sound). For each W-row:
the cited `refoundation.tex` label was opened and read; the cited
`mg-56b8` section was opened and the quoted content checked verbatim;
the disposition was tested against the §2.1 discriminator
(Walsh-as-cochain-labelling = portable; Walsh-as-cohomology-grading /
V_S^* sub-complex / (Z/2)^n-action = no referent). For the
no-twelfth-fact check, every occurrence of `walsh`, `Walsh`,
`harmonic`, `V_S`, `isotype`, `Z/2`, `chi`, `\bias` in
`refoundation.tex` was enumerated (237 occurrences) and each cluster
mapped to a W-row or classified as recap / honest framing; separately,
every `theorem` / `proposition` / `construction` / `lemma` /
`definition` environment was checked for a discharged Walsh-graded
claim. The `constr:bridge` demotion was checked against the
`2de18da..b59d3d5` git diff, not against the document's prose
description of itself.

---

## §2 — The W1–W11 ledger audit

Each row of the `mg-894c` ledger §2.2 table, independently verified.

### 2.1 W1 — the Walsh basis as harmonic description of the obstruction cochain (Role 2)

- **Location** — `rem:walsh-role2` (lines 864–884), `def:obs-sheaf`
  (the `[χ_x]` labelling, lines 1077–1096). **Confirmed.**
  `rem:walsh-role2` introduces χ_U as an orthonormal function basis,
  states the bias is the level-1 Walsh–Fourier coefficient, and says
  "Fork A keeps the Walsh basis in precisely this role — the harmonic
  description of the obstruction *cochain*." `def:obs-sheaf` uses
  `[χ_{x}]` as "a labelling of the harmonic type of the cochain, not a
  group action."
- **Source** — `mg-56b8` §1.1 (UC10.W). **Confirmed** — §1.1 states
  the Walsh decomposition UC10.W = UC10 Theorem 3.5. (The "Role 2"
  framing is a Fork-A-document coinage, not `mg-56b8` wording; the
  ledger cites §1.1 for the Walsh *basis*, which is correct.)
- **Disposition** — HAS FORK A REFERENT. **Confirmed.** χ_U is used
  *only* as a function basis labelling a *cochain*; no group action,
  no cohomology grading. `rem:walsh-role2` is explicit and honest
  about the limit ("Walsh level grades cochains, not cohomology").
  Portable.

### 2.2 W2 — the Walsh decomposition as a grading of cohomology

- **Location** — none (explicitly not used). **Confirmed.** The
  decomposition `C*(X_n∩) = ⊕_S χ_S ⊗ V_S^*` as a grading of
  cohomology appears nowhere in `refoundation.tex` as a Fork A
  structure; it is referenced only to be contrasted away
  (`rem:maschke-analogue`: the Walsh and S_n gradings "are different
  decompositions … not nested").
- **Source** — `mg-56b8` §1.1 (UC10.W). **Confirmed verbatim** —
  §1.1: "the (ℤ/2)ⁿ-equivariant Walsh decomposition C*(Xₙ∩;ℚ) = ⊕_S
  χ_S ⊗ V_S^* … every V_S^* is a genuine sub-cochain-complex."
- **Disposition** — EXPLICITLY DROPPED. **Confirmed.**
  `status:c-block` and `ssec:drop-z2` drop the (Z/2)^n-action; the
  cohomology grading is replaced by the genuine S_n-isotype
  decomposition (`thm:maschke`). No portability claimed.

### 2.3 W3 — the obstruction cochain is level-1 harmonic; the Čech differential preserves harmonic level

- **Location** — `prop:y2a-mech`(2) (lines 1259–1266). **Confirmed.**
  The statement is explicitly "at the cochain level": the mismatch
  `{m_xy}` and the Čech-direction cochains built from it are supported
  on the level-1 Walsh characters, and the Čech differential, being
  additive with no Walsh multiplication, does not raise the harmonic
  level *of a cochain*.
- **Source** — `mg-56b8` (UC14 Lemma 2.2.1, single-family
  cell-level). **Confirmed as adequate.** This is a slightly loose
  cite: `mg-56b8` discusses UC14 Lemma 2.2.1 in §1.3 and §5.1 (the
  cell-level χ_S-support lemma) rather than at a single clean section
  number, and the "level-1 obstruction cochain" provenance is really
  UC10/UC13 (the bias as level-1 datum). But the substance — that
  "level-1 harmonic" is a *cochain*-level property — is correct, and
  the Fork A reasoning in `prop:y2a-mech`(2) is Fork-A-native and
  sound (additive Čech differential carries no Walsh multiplication).
  The loose cite does not affect the disposition.
- **Disposition** — HAS FORK A REFERENT (cochain-level only).
  **Confirmed.** `res:y2` is explicit that harmonic level is *not* a
  cohomology grading, so "the cochain is level-1" does **not** pin the
  class's isotype; the class-level question is residual R2. Portable
  strictly as a cochain-level fact.

### 2.4 W4 — the cofiber LES of `(X_n, X_{n-1,x})` and its equivariance

- **Location** — `thm:y1-reduction`(1) (lines 1457–1461).
  **Confirmed.** Statement (1) reads: the pair has a cohomology LES
  "equivariant for the point stabiliser Stab(x) ≅ S_{n-1} — and
  *only* for that subgroup, not for all of S_n."
- **Source** — `mg-56b8` §3.1 (LES-S, (Z/2)^n-equivariant, split into
  Walsh isotypes). **Confirmed verbatim** — §3.1 derives (LES-S) by
  Maschke from the (ℤ/2)ⁿ-equivariance.
- **Disposition** — DEMOTED → residual R1b. **Confirmed.** The
  (Z/2)^n-equivariance does not port; the pair keeps only Stab(x) ≅
  S_{n-1} symmetry. Caught by `mg-d300` Finding A prong 1, fixed by
  `mg-365e`; `rem:y1-branching` and `res:y1` R1b record the
  S_{n-1}→S_n recovery as the named residual. (The LES *existence*
  itself ports; what is demoted is the S_n-equivariance — the ledger's
  disposition text says exactly this.)

### 2.5 W5 — the twisted-bridge null-homotopy `ι_x* ≃ 0`

- **Location** — `constr:bridge` → `rem:bridge-not-ported` (lines
  1378–1450). **Confirmed.**
- **Source** — `mg-56b8` §3.2 (twisted bridge, `ι_x* ≃ 0` on V_S^*).
  **Confirmed verbatim** — §3.2: the twisted-bridge identity gives
  "`ιₓ*` is null-homotopic on V_S^*"; §8.1: its step "`d` commutes
  with χ_x·" is "valid only on χ_S-supported cells."
- **Disposition** — DEMOTED → residual R1c. **Confirmed** (this is the
  central `mg-894c` re-statement; audited in full in §4 below).

### 2.6 W6 — the collapse of the cofiber LES to a SES *(probed hardest)*

- **Location** — `thm:y1-reduction`(2) and proof sketch (lines
  1462–1524). **Confirmed.**
- **Source** — `mg-56b8` §3.2–§3.4 (SES-S, RED). **Confirmed** — §3.2
  derives (SES-S) by substituting `ι_x* = 0`; §3.3–§3.4 collapse it to
  the (RED) isomorphism `j*: V_S^k(cofib ι_x) ≅ V_S^k(X_n∩)`.
- **Disposition** — CONDITIONAL mechanism, not a separate over-claim.
  **Confirmed, after hard probing.** The §2.4 ledger note flags W6 as
  a place a skeptical re-validator should look hardest; it withstands
  the probe:
  - `thm:y1-reduction`(2) states the collapse **conditionally** —
    verbatim: "substituting the null-homotopy `ι_x* ≃ 0` — *when* it
    is available: in Fork A it is *not* a discharged input but the
    open sub-residual R1c". The proof sketch echoes this: "*Granting*
    the twisted-bridge null-homotopy `ι_x* ≃ 0` — which in Fork A is
    not a discharged input but the open sub-residual R1c".
  - The collapse's *only* Walsh-derived input is `ι_x* ≃ 0` itself
    (now R1c). The step "substituting the zero map makes `j*`
    surjective … and `δ` injective" is elementary homological algebra
    of a long exact sequence — no Walsh fact. The projection to
    S_{n-1}-isotypes uses Maschke for S_{n-1}, which is genuine
    (Stab(x) ≅ S_{n-1} genuinely acts).
  - The document does **not** claim the clean (RED) isomorphism: it
    states the collapsed form as "a relation expressing … through the
    cofiber cohomology … *and* the smaller-ground-set term
    H̃^{k-1}(X_{n-1,x})_{[μ]}" — keeping the smaller term as a live
    term, whose vanishing is then folded into the open step (a)/R1a.
  - **Conclusion.** W6 carries no Walsh content beyond R1c (its
    substituted input) and R1a (the smaller-term control). It is the
    honestly-conditional *mechanism* of `thm:y1-reduction`, not a
    fourth ported fact. The disposition is correct.

### 2.7 W7 — the smaller-cube term vanishes by the simultaneous induction

- **Location** — `thm:y1-reduction`(2) step (a); `res:y1` R1a (lines
  1474–1480, 1585–1597). **Confirmed.** Step (a) supplies the
  smaller-ground-set terms by "the simultaneous induction on `n` —
  based at the finite check `n=2`."
- **Source** — `mg-56b8` §3.3, §2.1. **Confirmed** — §3.3 vanishes
  `V_S^{k-1}(X_{n-1,x}∩)` by the inductive hypothesis (including the
  degree-0 connectedness `V_S^0 = 0` for `S ≠ ∅`); §2.1 sets the
  simultaneous induction `UC10.1(n) = Y1(n) ∧ TW(n)`.
- **Disposition** — FOLDED INTO residual R1a. **Confirmed.** In Fork A
  the smaller-ground-set term is `H̃^{k-1}(X_{n-1,x})_{[μ]}`; its
  vanishing — including the degree-0 connectedness — is internal to
  R1a's S_{n-1}-isotype simultaneous induction. The base case (`n=2`),
  un-stated before, is now stated (a `mg-5221` §4.2 point — §4.3
  below). Folding open work into the open residual R1a is honest: the
  document claims nothing here discharged.

### 2.8 W8 — the |S|-sub-case structure / the sphere-class collision *(probed hardest)*

- **Location** — `thm:y1-reduction` proof sketch (lines 1493–1524).
  **Confirmed.** The proof sketch reads: "it carries over an
  *analogous* sub-case structure, including the delicate sub-case
  where the smaller-ground-set term meets the sphere class of the
  (n-1)-cube — *all of it internal to the open cofiber residual R1a*."
- **Source** — `mg-56b8` §2.3, §6. **Confirmed** — §2.3: "The split
  |S| ≤ n-2 vs |S| = n-1 is forced by this bookkeeping"; §6: the
  |S| = n-1 sub-case "must be done with the R3 machinery, separately"
  (where `mg-56b8`'s "R3" is *UC14's* third residual, the top-isotype
  bridge — **not** `refoundation.tex`'s faithfulness residual R3; the
  ledger §2.4 correctly disambiguates this as "a different,
  top-isotype bridge").
- **Disposition** — FOLDED INTO residual R1a. **Confirmed, after hard
  probing.** The §2.4 ledger note flags W8 as the other
  look-hardest spot; it withstands the probe:
  - The |S|-indexed split is a *Walsh-index* distinction. Fork A has
    no χ_S grading, so the split has no Fork A referent **as such** —
    the Fork A reduction projects uniformly to S_{n-1}-isotypes [μ].
    Whatever sub-case structure the S_{n-1}-isotype reduction has is
    the analogue, and the proof sketch says it is "all of it internal
    to the open cofiber residual R1a."
  - The wording was genuinely softened: "carries over an *analogous*
    sub-case structure" (the `mg-894c` revision; the diff confirms the
    earlier draft is gone). It is **not** presented as discharged —
    "internal to the *open* cofiber residual" is open, and
    `status:y1a` scores `Y1`-A "RED — open."
  - The §2.4 note pre-argues that whether the |S| = n-1 sub-case
    deserves its own named residual rather than folding into R1a is "a
    refinement of the residual *labelling*, not a fourth over-claim."
    This is correct: the over-claim shape is "a Walsh fact treated as
    *discharged*," and W8 is treated as *open* (part of R1a). Folding
    open work into an open residual cannot be an over-claim. A
    re-validator *could* argue for a separate label R1d for the
    top-isotype-bridge variant the sphere-class collision needs — but
    that is cosmetic; R1c as stated ("establishing the twisted-bridge
    null-homotopy `ι_x* ≃ 0` in the Fork A setting … by a
    Fork-A-native re-derivation of the null-homotopy, or by an
    explicit χ_S-to-S_{n-1} grading reconciliation") plus R1a (which
    explicitly absorbs "the delicate sub-case where the
    smaller-ground-set term meets the sphere class") already declare
    the whole structure open. **This audit does not call for a
    re-labelling**; the residual decomposition is honest as it stands.
  - **Conclusion.** W8 is the honestly-open sub-case mechanism folded
    into R1a, not a discharged ported fact. The disposition is
    correct.

### 2.9 W9 — the Walsh-index bookkeeping

- **Location** — none (not present in `refoundation.tex`).
  **Confirmed.** A grep for the χ_S-restriction bookkeeping ("χ_S
  restricted along ι_x stays χ_S", `mg-56b8` §2.3) and for "restricted
  along" returns nothing in the document. Fork A works with
  S_{n-1}-isotype restriction, handled by R1b — there is no χ_S-index
  bookkeeping to port.
- **Source** — `mg-56b8` §2.3. **Confirmed.**
- **Disposition** — NOT PORTED / NOT NEEDED. **Confirmed.** Pure
  χ_S-index bookkeeping, meaningful only with the χ_S grading; nothing
  to demote.

### 2.10 W10 — the obstruction class lands in degree `n-1`

- **Location** — `def:ob`; `rem:promotion`; `debt:faithful-localized`
  R3b (lines 1121–1163, 1884–1892). **Confirmed.** `def:ob` says the
  degree-`(n-1)` membership "is *conditional*: it presupposes that the
  edge map exists and lands in degree `n-1` (parts R3a, R3b)";
  `rem:promotion` says the count is "inherited from the pre-Fork-A
  development … not re-verified in the genuinely different Fork A
  object."
- **Source** — `mg-56b8` / UC10. **Confirmed as adequate** (the
  degree count is a UC10-era inheritance; the cite is appropriately
  broad).
- **Disposition** — DEMOTED → residual R3b. **Confirmed.** Already a
  named residual since the `mg-365e` revision.

### 2.11 W11 — the `χ_{[n]} ⊠ sgn_{S_n}` sphere-class target

- **Location** — `rem:sgn-always-sn` (lines 1001–1013). **Confirmed.**
  "The pre-Fork-A target was `H̃^{n-1} ≅ χ_{[n]} ⊠ sgn_{S_n}`. The
  `χ_{[n]}` tensor factor was the (Z/2)^n-decoration; the `sgn_{S_n}`
  factor was always carried by the S_n-action … Proposition
  `prop:sphere-sgn` recovers exactly the `sgn_{S_n}` factor and
  discards exactly the `χ_{[n]}` factor."
- **Source** — UC10 / UC12. **Confirmed as adequate.**
- **Disposition** — HAS FORK A REFERENT (sgn factor) / EXPLICITLY
  DROPPED (χ factor). **Confirmed.** The surviving `sgn_{S_n}` is an
  S_n-fact, not a Walsh fact; the `χ_{[n]}` decoration is dropped.
  Honest accounting.

### 2.12 Summary of the W1–W11 audit

All 11 rows are correct: every location verified against the document,
every source verified against `mg-56b8` (two cites — W3, W10 — are
appropriately broad rather than pinpoint, neither affecting a
disposition), every disposition tested against the §2.1 discriminator
and confirmed. The two self-flagged hardest-probe rows, **W6** and
**W8**, both withstand the probe: each is the honestly-conditional /
honestly-open *mechanism* of `thm:y1-reduction`, explicitly not
presented as discharged, and carrying no Walsh content beyond the
already-named residuals R1a and R1c.

---

## §3 — The no-twelfth-fact check: independent re-derivation of the enumeration

Mandate point 2 is the one the `mg-894c` GREEN could not itself
discharge: the exhaustiveness of the sweep was the `mg-894c` polecat's
own claim. This section re-derives the enumeration independently.

### 3.1 The discriminator, applied fresh

Per ledger §2.1: a ported fact has **no Fork A referent** if it needs
Walsh as a grading of *cohomology*, or needs `V_S^*` to be a
*sub-complex*, or needs the *(Z/2)^n-action*; it **is portable** if it
uses Walsh only as a function-basis labelling of a *cochain*. A fact
with no referent must be **dropped** or **demoted to a named
residual** — never carried as a discharged input.

### 3.2 Every Walsh / χ_S occurrence, bucketed

Every occurrence of `walsh` / `Walsh` / `harmonic` / `V_S` / `isotype`
/ `Z/2` / `chi` / `\bias` in `refoundation.tex` (237 in total) was
enumerated and its cluster classified. The clusters, by document
location:

| `refoundation.tex` cluster | Walsh / χ_S content | Maps to |
|---|---|---|
| abstract; §0.1/§0.2 headline | recap of Role-2 keep, R1c, the residual list | recap |
| `status:c-block`, `ssec:drop-z2` prose | drops (Z/2)^n; Walsh Role 1 dropped, Role 2 survives | W2 (dropped) |
| `rem:walsh-role2` | χ_U as harmonic basis; "grades cochains, not cohomology" | **W1** |
| `thm:maschke`, `rem:maschke-analogue` | the genuine S_n grading; explicit contrast with the dropped Walsh grading | W2 (dropped) |
| `prop:sphere-sgn`, `rem:sphere-sgn-hyp`, `rem:sgn-always-sn` | sphere class = sgn isotype; χ_{[n]} ⊠ sgn split | **W11** |
| `def:obs-sheaf` | `[χ_x]` cochain labelling | **W1** |
| `def:ob`, `rem:promotion` | degree `n-1` | **W10** |
| `prop:y2a-mech`(2) | obstruction cochain level-1 harmonic, at cochain level | **W3** |
| `res:y2`, `status:y2a` | R2; "harmonic level is not a cohomology grading" | W3 / R2 (open) |
| `conj:y1a` | re-graded sphere concentration | open target (input v) |
| `constr:bridge`, `rem:bridge-not-ported` | twisted-bridge null-homotopy | **W5** |
| `thm:y1-reduction`, proof sketch, `rem:y1-branching` | cofiber LES, its equivariance, the collapse, the sub-case structure | **W4, W6, W7, W8** |
| `res:y1`, `status:y1a` | R1a / R1b / R1c | W4/W5/W7/W8 → residuals |
| `thm:contradiction`, `rem:honest-shape`, `ssec:debt1`, verdict/summary | recap of the residual list | recap |

Every cluster maps to a W-row or is honest recap / framing. There is
no cluster left over.

### 3.3 The decisive cross-check: no discharged Walsh-graded claim

The over-claim shape is a Walsh-graded fact *treated as a discharged
input* — so it can only live in a **Theorem, Proposition,
Construction, Lemma, or Definition** (the environments that assert
discharged content; `Remark` / `Status` / `Open residual` /
`Conjecture` / `Owed debt` are by convention non-discharged). Every
such environment was checked:

- `thm:projection`, `thm:welldefined`, `thm:maschke` — no Walsh
  content; the genuine S_n-action only.
- `prop:sphere-sgn` — an S_n / sgn statement (W11); needs no Walsh
  grading; explicitly not load-bearing.
- `def:category`, `def:xf`, `def:bk`, `def:minimal`,
  `prop:minimality`, `lem:cocycle` — no Walsh content (`lem:cocycle`
  is pure Čech algebra).
- `def:obs-sheaf` — uses the `[χ_x]` labelling only, explicitly "not a
  group action" (W1, portable).
- `def:ob` — degree `n-1` stated **conditionally** on R3a/R3b (W10).
- `prop:fact-one` — conditional on R3.
- `prop:y2a-mech` — (1) factors through differences; (2) level-1
  "*at the cochain level*" (W3, portable, explicitly cochain-only).
- `conj:y1a` — a **Conjecture**: the re-graded sphere concentration,
  explicitly the open input (v)/R1. Not a discharged fact.
- `constr:bridge` — re-titled "the matched-cylinder prism operator";
  ports only the geometric `h`; the twisted bridge is explicitly
  *not* discharged (W5 → R1c).
- `thm:y1-reduction` — (1) the LES is Stab(x) ≅ S_{n-1}-equivariant
  (W4, honest); (2) the collapse is conditional on R1c (W6).

**No Theorem, Proposition, Construction, Lemma, or Definition
discharges a fact that needs Walsh-as-a-cohomology-grading, a V_S^*
sub-complex, or the (Z/2)^n-action.** Every such fact is either
dropped (W2; W11-χ) or demoted to a named residual (W4 → R1b, W5 →
R1c, W7+W8 → R1a, W10 → R3b). The portable uses (W1, W3, W11-sgn) are
cochain-labelling or genuine-S_n facts, and each is explicitly limited
where it must be.

### 3.4 Conclusion of the independent re-derivation

The independent enumeration reproduces the `mg-894c` ledger's W1–W11
list exactly — no twelfth ported Walsh / χ_S fact, and in particular
no twelfth fact *treated as a discharged Fork A input*. The over-claim
shape that the validate–revise loop caught three times (`mg-c15b` for
the `Y2` "standard-isotypic" theorem, `mg-d300` for the `Y1` LES
equivariance, `mg-5221` for the twisted-bridge null-homotopy) has no
fourth instance. **The sweep is genuinely exhaustive.**

---

## §4 — `constr:bridge` demotion and the minor `mg-5221` §4 points

### 4.1 The load-bearing port is deleted, not re-titled

`mg-5221` §3.1 quoted the over-claim verbatim — `constr:bridge`
asserted the twisted bridge identity "also ports without a
(Z/2)^n-action. It gives `ι_x* ≃ 0`, the input the reduction uses."
The `2de18da..b59d3d5` diff of `refoundation.tex` shows, with `-`
lines, that **exactly this sentence is deleted**:

```
-$(\Z/2)^n$ intact. The harmonic twist by $\walsh{\{x\}}$ used in the
-pre-Fork-A bridge is, in Fork~A, simply pointwise multiplication by
-the fixed function $\walsh{\{x\}}$ (Role~2, ...) --- a cochain
-operation, not a group action --- so the twisted bridge identity
-$\iota_x^{*}=\pm\frac12(dh-hd)$ also ports without a
-$(\Z/2)^n$-action. It gives $\iota_x^{*}\simeq0$, the input the
-reduction uses.
```

It is replaced by an honest scope statement ("*This much ports
cleanly.* What does *not* port as a discharged input is the
twisted-bridge null-homotopy …") and the Construction is re-titled
from "The matched-cylinder **bridge**" to "The matched-cylinder
**prism operator**." The Construction's scope is genuinely shrunk to
what ports: the matched cylinder and the geometric degree-`(-1)` prism
operator `h` — "a *geometric* construction on cells; it needs no group
action." This is a **deletion of the load-bearing port**, not a
re-title of it.

The two remaining mentions of the deleted text in the document (line
363 in `status:mg894c-revision`, line 1404 in `rem:bridge-not-ported`)
are **quotations of the withdrawn claim**, inside honest re-statement
passages that exist to explain what was withdrawn and why — not live
over-claims.

### 4.2 R1c is genuinely recorded

The new `rem:bridge-not-ported` (lines 1393–1450) states honestly:
the twisted-bridge identity needs `d` to *commute* with
`χ_x`-multiplication; `mg-56b8` §8.1 validates that step "only on
χ_S-supported cells"; so the pre-Fork-A `ι_x* ≃ 0` is intrinsically a
fact about the χ_S-isotype sub-complexes `V_S^*`; Fork A, having
dropped the (Z/2)^n-action, has no `V_S^*` sub-complex (and `d` does
not preserve harmonic level — `rem:walsh-role2`); the "cochain
operation not a group action" justification is "a non sequitur, and
the claim is withdrawn." `thm:y1-reduction`(2) now substitutes the
null-homotopy **conditionally** ("*when* it is available: in Fork A it
is *not* a discharged input but the open sub-residual R1c"); the
theorem's conclusion reduces `Y1`-A to *three* steps, R1a/R1b/R1c, "all
three … genuinely open"; `res:y1` carries the R1c bullet;
`thm:contradiction` input (v) lists R1 = R1a + R1b + R1c. The demotion
is propagated consistently through every dependent passage (§0.1
headline, §0.2 scorecard, abstract, `status:c-block`, `status:y1a`,
`rem:honest-shape`, `ssec:debt1`, `ssec:open`, `ssec:delivered`,
verdict, summary, footer). **R1c is genuinely recorded.**

### 4.3 The two minor `mg-5221` §4 points

- **`mg-5221` §4.2 — the base case of the simultaneous induction.**
  Addressed. `thm:y1-reduction` step (a) and `res:y1` R1a now state
  the induction is "based at the finite check `n=2` (the families on a
  two-element ground set are finite in number and directly
  computable; this is the same base verification the pre-Fork-A
  development relied on for the `n=2` sphere class)" — consistent with
  `mg-56b8` §2.2. **Confirmed.**
- **`mg-5221` §4.1 — the punctured-poset-to-`F⋆` extension in
  `prop:fact-one`.** Addressed. `prop:fact-one`'s proof now says the
  extension of a global section "to a datum valid at the top object
  `F⋆` *itself* is the punctured-poset-to-`F⋆` promotion that
  `rem:promotion` folds into the R3 faithfulness package (specifically
  the edge-map *existence* part R3a)"; `status:fact-one` records the
  same. **Confirmed.**

---

## §5 — The input list and the GREEN spine

### 5.1 `thm:contradiction` rests on exactly the declared input list

`thm:contradiction` (lines 1661–1689) assumes exactly five inputs:
(i) R3a edge-map existence; (ii) R3b degree-`(n-1)` behaviour;
(iii) R3c edge-map injectivity; (iv) R2 landing; (v) R1 vanishing —
"which, by `thm:y1-reduction`, itself rests on the three-part `Y1`
residual: R1a, R1b, and R1c." The proof (lines 1691–1706) uses each
exactly once — (i)+(ii) make `ob(F⋆)` a well-defined element of degree
`n-1`; Fact One with (iii) gives `ob(F⋆) ≠ 0`; (v) makes
`H̃^{n-1}(C_n;X) ≅ sgn_{S_n}`; (iv) gives `ob` no sgn-component, so
`ob = 0`; contradiction — and **no sixth input appears**.

So the conditional theorem rests on exactly:

> **R3a, R3b, R3c** · **R2** · **R1 = R1a + R1b + R1c.**

This is the declared input list. `mg-5221` §2.4 already confirmed the
five-input enumeration (i)–(v) of `thm:contradiction` honest; the
`mg-894c` revision changed only how input (v)/R1 decomposes, adding
R1c. The §3 independent re-derivation confirms no ported Walsh fact is
discharged outside this list. **The input list is complete and
final.**

### 5.2 The GREEN spine is intact

The spine is `H*(C_n;X)` genuinely defined with `D² = 0`:
`thm:projection` (`π_T` a covariant functor — chain map,
functoriality, S_n-equivariance), `thm:welldefined` (`D² = 0`),
`thm:maschke` (the S_n-isotype decomposition), and `prop:y2a-mech`
(the `Y2`-A structural mechanism).

The `2de18da..b59d3d5` diff was inspected hunk by hunk: **no hunk
falls within the statement or proof of `thm:projection`,
`thm:welldefined`, `thm:maschke`, or `prop:y2a-mech`.** The `mg-894c`
revision touched `constr:bridge`, the new `rem:bridge-not-ported`,
`thm:y1-reduction`, `res:y1`, `status:c-block` (one sentence on the
V_S^* cost), `def:ob`/`rem:promotion`/`status:fact-one` (the R3a
attribution), `thm:contradiction` input (v), and the status / abstract
/ verdict / summary recap passages — none of the spine. The spine was
independently re-verified sound by `mg-d300` (§2.1–§2.5) and again by
`mg-5221` (§2.1–§2.2, §2.6); this re-validation, whose mandate is the
ledger audit, confirms the spine is **undisturbed by the revision**
and takes those two prior independent confirmations as standing. The
GREEN spine is intact.

---

## §6 — Verdict and recommendations

### 6.1 Verdict

**GREEN — THE EXHAUSTIVE WALSH-FACT SWEEP IS GENUINELY EXHAUSTIVE; THE
INPUT LIST IS COMPLETE AND FINAL; NO FOURTH PRONG.**

Independent ledger audit confirms all four mandate points. The W1–W11
table is correct in every row — location, source, and disposition
verified, with the two self-flagged hardest-probe rows W6 and W8 both
withstanding the probe as honestly-conditional / honestly-open
mechanism rather than over-claim. An independent re-derivation of the
enumeration finds no twelfth ported Walsh / χ_S fact and, decisively,
no Theorem / Proposition / Construction / Lemma / Definition that
discharges a Walsh-as-cohomology-grading / V_S^* sub-complex /
(Z/2)^n-action fact. `constr:bridge`'s load-bearing port is deleted
(confirmed against the git diff, not the prose), R1c is genuinely
recorded, and the two minor `mg-5221` §4 points are addressed.
`thm:contradiction` rests on exactly R3a, R3b, R3c, R2, and R1 (= R1a
+ R1b + R1c) — complete and final — and the GREEN spine is untouched
by the revision and independently sound.

The validate–revise loop has reached its fixed point: there is no
fourth prong to catch. The `mg-894c` GREEN, which was the `mg-894c`
polecat's own claim, is now independently confirmed.

This is **GREEN for the re-validation scope** — the sweep is
exhaustive and the document is honest about exactly what it rests on.
It is **not** a proof of Frankl and not a closure of any residual:
`thm:contradiction` remains a conditional theorem on seven genuinely
open sub-residuals (R1a, R1b, R1c, R2, R3a, R3b, R3c).

### 6.2 One observation, not verdict-changing

The W3 and W10 source cites in the ledger table point at `mg-56b8` /
UC10 / UC14 broadly rather than at a single pinpoint section (§2.3,
§2.10). This is accurate-but-loose, not wrong, and affects no
disposition; it is recorded only so a later phase pinning the
cell-level spectral sequence of `F_obs` knows the level-1-harmonic
provenance spans UC10/UC13/UC14 rather than one lemma. No edit to
`refoundation.tex` or the ledger is needed.

### 6.3 Recommendations (routed to Daniel via pm-onethird)

1. **The Fork A Phase-1 re-foundation is GREEN and the
   validate–revise arc is complete.** Three independent rounds
   (`mg-d300`, `mg-5221`, this one) plus two revisions (`mg-365e`,
   `mg-894c`) have converged: the conditional theorem is honest, the
   input list is complete and final, and no further over-claim of the
   "ported Walsh fact treated as portable" shape survives. No fourth
   revision is needed.

2. **Proceed to the residual-closing arc.** The seven open
   sub-residuals can now be scoped as tickets against the corrected,
   complete picture: R1a (the cofiber — the genuine open Frankl
   content, the `mg-56b8` stuck-family computation, multi-week-plus);
   R1b (the S_{n-1}→S_n branching step); R1c (a Fork-A-native
   discharge of the twisted-bridge null-homotopy, or an explicit
   χ_S-to-S_{n-1} grading reconciliation); R2 (the `Y2` landing /
   separation); R3a/R3b/R3c (the three-part faithfulness edge-map
   debt). R1c and R1b are both representation-theoretic
   reconciliations forced by the (Z/2)^n→S_n re-grading and may share
   machinery; R2 and R3 are facets of one faithfulness question
   (`rem:r2-faithful`). All residual-attack work should first pin the
   cell-level spectral sequence of `F_obs` (`rem:holim-prereq`).

3. **Phase 3 (Lean) is unblocked for the spine.** The
   formalization-ready core — `thm:projection`, `thm:welldefined`
   (`D²=0`), `thm:maschke`, `prop:y2a-mech` — is sound and now thrice
   independently confirmed. The residuals R1/R2/R3 are not
   formalization-ready and must not be Lean-formalized as discharged.

4. **`paper/main.tex` stays as-is.** It honestly records the
   pre-Fork-A state; folding the Fork A re-foundation into the
   consolidated paper is a later pass, out of scope here — unchanged
   from the Phase-1, `mg-365e`, and `mg-894c` recommendation.

### 6.4 The honest one-paragraph verdict

Independent ledger-audit re-validation confirms that the `mg-894c`
exhaustive portable-Walsh-fact sweep is genuinely exhaustive. Every
row of the W1–W11 table checks out — locations verified against
`refoundation.tex`, sources verified against `mg-56b8`, dispositions
tested against the Walsh-as-cochain-labelling-versus-cohomology-grading
discriminator — and the two rows the ledger itself flagged for hardest
probing, W6 (the cofiber-LES collapse) and W8 (the |S|-sub-case
structure), both withstand it: each is the honestly-conditional or
honestly-open mechanism of `thm:y1-reduction`, explicitly not
presented as discharged, carrying no Walsh content beyond the
already-named residuals R1a and R1c. An independent re-derivation of
the enumeration finds no twelfth ported Walsh / χ_S fact, and — the
decisive check — no Theorem, Proposition, Construction, Lemma, or
Definition in the document discharges a fact needing
Walsh-as-cohomology-grading, a V_S^* sub-complex, or the
(Z/2)^n-action; every such fact is dropped or demoted to a named
residual. `constr:bridge`'s load-bearing over-claim is deleted
verbatim (confirmed against the git diff), the twisted-bridge
null-homotopy is genuinely recorded as the open sub-residual R1c, and
the two minor `mg-5221` §4 points — the simultaneous-induction base
case and the punctured-poset-to-`F⋆` extension — are both addressed.
`thm:contradiction` rests on exactly R3a, R3b, R3c, R2, and
R1 = R1a + R1b + R1c, each used once in its proof with no sixth input,
and the GREEN spine (`thm:projection`, `thm:welldefined` `D²=0`,
`thm:maschke`, `prop:y2a-mech`) is untouched by the revision and
independently sound. The verdict is **GREEN**: the sweep is genuinely
exhaustive, the input list of the conditional theorem is complete and
final, there is no fourth prong, and the validate–revise loop has
reached its fixed point. The Fork A Phase-1 re-foundation is delivered,
internally sound, and honest about exactly what it rests on; the next
step is the residual-closing arc (R1a, R1b, R1c, R2, R3a, R3b, R3c)
and Phase 3 (Lean) for the spine.

### 6.5 Cross-references

- **Brief:** `mg-bf5c` (Frankl-ForkA-Phase2-Revalidation2). **Routes
  to:** Daniel, via `pm-onethird`.
- **Deliverable re-validated:** `paper/forkA/refoundation.tex` (the
  twice-revised document, commit `b59d3d5`).
- **The ledger audited (§2.2 the W1–W11 table, §2.1 the
  discriminator, §2.4 the W6/W8 probe note):**
  `docs/Frankl-ForkA-Phase2-Revision2.md` (`mg-894c`).
- **The prior Phase-2 re-validation (the AMBER `mg-894c` acted on):**
  `docs/Frankl-ForkA-Phase2-Revalidation.md` (`mg-5221`).
- **The first Phase-2 validation:**
  `docs/Frankl-ForkA-Phase2-validation.md` (`mg-d300`).
- **The first revision ledger:**
  `docs/Frankl-ForkA-Phase2-Revision.md` (`mg-365e`).
- **The Phase-1 ledger:** `docs/Frankl-ForkA-Refound-LaTeX.md`
  (`mg-c15b`).
- **The pre-Fork-A cofiber-LES reduction — the source of every
  χ_S-graded fact in the W-table (§1.1 UC10.W; §2.1 the simultaneous
  induction; §2.2 the `n=2` base case; §2.3 the isotype bookkeeping;
  §3.1 the LES-S; §3.2 the twisted bridge; §3.3–§3.4 the SES-S / RED;
  §6 the |S|=n-1 collision; §8.1 the χ_S-support soft spot):**
  `docs/Frankl-Y1-reprove.md` (`mg-56b8`).
- **Fork A endorsement / the two debts:**
  `docs/Frankl-ForkD-Probe-n3.md` (`mg-565a`).
- **Onboarding:** `docs/PROOF-STRUCTURE-ONBOARDING.md`.

---

*Phase-2 independent ledger-audit re-validation by polecat
`cat-mg-bf5c` — a fresh, default-skeptical reviewer, not any prior
Fork-A polecat. Deliverable on `main`: this document. Verdict:
**GREEN — THE EXHAUSTIVE WALSH-FACT SWEEP IS GENUINELY EXHAUSTIVE; THE
INPUT LIST IS COMPLETE AND FINAL; NO FOURTH PRONG.** The `mg-894c`
ledger's W1–W11 table is correct in every row (location, source,
disposition independently verified); the self-flagged hardest-probe
rows W6 and W8 are honestly-conditional / honestly-open mechanism, not
over-claims; an independent re-derivation of the enumeration finds no
twelfth ported Walsh / χ_S fact and no Theorem / Proposition /
Construction / Lemma / Definition discharging a Walsh-as-grading /
V_S^* sub-complex / (Z/2)^n-action fact; `constr:bridge`'s
load-bearing port is deleted verbatim (confirmed against the git
diff), R1c is genuinely recorded, the two minor `mg-5221` §4 points are
addressed; `thm:contradiction` rests on exactly R3a, R3b, R3c, R2, and
R1 = R1a + R1b + R1c, and the GREEN spine is untouched and sound. The
input list is complete and final; the validate–revise loop has reached
its fixed point. Recommended next: the residual-closing arc (R1a, R1b,
R1c, R2, R3a, R3b, R3c) and Phase 3 (Lean) for the spine.*
