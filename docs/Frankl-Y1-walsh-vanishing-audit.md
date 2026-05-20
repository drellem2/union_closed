# Frankl-Y1-Audit — independent audit of the level-1 Walsh-isotype vanishing (Y1)

**Work item:** `mg-552b` (audit + this report; no Lean re-implementation).

**Trigger.** Per the `mg-aeee` Frankl-Y2-Resolution verdict, **Y2** (the
obstruction-class landing in the level-1 isotypes) came back **Y2-SUPPORTED** —
machine-checked sound mechanism. But Y2 is only *half* of the paper's two-part
contradiction. **Y1** — the level-1 Walsh *vanishing* — was explicitly left
SEPARATE and UNAUDITED (mg-aeee §6: "Y1 … is a separate step with its own soft
spots (mg-39bc §5.4) and is out of scope"). This ticket audits Y1 to the same
standard mg-aeee applied to Y2: check the **mechanism**, not whether it is
cited.

---

## §0 — Verdict (top of page)

### 0.1 Headline: **Y1-HIGH-RISK.** The paper proof of Y1 is not referee-grade. Its load-bearing covering step is logically invalid as written, and the UC14 "tightening" (R2) that the project treats as closing that gap is **provably false** — it contradicts the program's own sphere class.

Two findings, both checked by hand against the program's own committed facts:

1. **UC14 R2 (Theorem 2.7.1 / 2.4.1) is mathematically false.** R2 "upgrades"
   UC13 Lemma 4.4.1 from a cohomological *surjection* to a chain-level
   *isomorphism* `C*(Xₙ∩)_{χ_S} = C*(X(𝒟ₓ))_{χ_S}` for every `S ⊊ [n]`,
   `x ∉ S`. Applied to `S = [n]∖{x}` it forces the *lower* isotype
   `V_{[n]∖{x}}^{n-2}(Xₙ∩)` to be isomorphic to `sgn_{S_{n-1}} ≠ 0` — because
   `X(𝒟ₓ) ≅ X_{n-1,x}∩ × Iₓ` is a cylinder and `χ_{[n]∖{x}}` is the *top*
   character on that `(n-1)`-cube, so it carries the sphere class
   `V_{[n-1]}^{n-2}(X_{n-1}∩) ≅ sgn`. But Y1 / UC10.1 require **every** lower
   isotype to vanish in degree `≥ 1`. A chain isomorphism cannot send a
   nonzero group to a zero group. **R2 is therefore false** — and it is the
   *same sphere class* that UC14 **R3** §3.6 uses as an explicit load-bearing
   input, so UC14 R2 and UC14 R3 are mutually inconsistent within one
   document.

2. **UC13 §4.5 — the proof of Y1 itself — is logically invalid as written.**
   It derives `V_S^k(Xₙ∩) = 0` from "the trace `ι_x^{𝒟*}ω` is exact." But
   exactness of the *trace* of `ω` is the statement that the induced map
   `ι_x^{𝒟*}` is **zero** on cohomology; it says nothing about whether the
   *domain* `V_S^k(Xₙ∩)` is zero. To close the gap one needs `ι_x^{𝒟*}`
   **injective** on cohomology. §4.5's own justification of injectivity ("at
   most isomorphic by the same argument applied to `n-1`") is circular, and
   the only document that claims a non-circular version of it is UC14 R2 —
   which finding (1) shows is false. The gap is real and **unfilled**.

### 0.2 The non-negotiable caveat — this is a verdict about the *proof*, not a refutation of Y1.

**Y1-HIGH-RISK does NOT mean Y1 is false.** This audit shows the *paper proof*
of Y1 is broken; it does **not** exhibit a counterexample to the statement
`V_S^k = 0`. In fact Y1 is *plausibly true*: it is part of UC10.1 (the
sphere-concentration theorem, the F17/F18 analog), and its sibling — the
top-Walsh concentration `V_{[n]}^k = 0` for `k < n-1` — faced the *identical*
"trace-exact ≠ class-exact" obstacle, was honest about it (UC13 §5.2: "We need
a more careful argument"), and was closed by UC14 **R3** via a genuine
**cofiber long-exact-sequence + induction** argument. Y1 should have used the
same method. It did not — §4 used a shortcut (R2's chain isomorphism) that is
wrong. So Y1 is **true-but-currently-unproven**, with a *false* lemma sitting
in the repo where the proof should be.

### 0.3 One-line verdict

> **Y1-HIGH-RISK.** The level-1 Walsh vanishing is plausibly true but is **not
> validly proven**. UC13 §4.5 conflates exactness of the trace map with
> vanishing of the cohomology (a genuine logical error, not a hedge), and the
> UC14 R2 "tightening" cited as closing that gap is **provably false**:
> applied to `S = [n]∖{x}` it transports the program's own sphere class
> `sgn ≅ V_{[n-1]}^{n-2}(X_{n-1}∩)` into a lower isotype that Y1/UC10.1 require
> to vanish — so UC14 R2 contradicts UC14 R3 and UC10.1. A correct proof of Y1
> (modelled on R3's cofiber-LES+induction) is achievable but **does not exist
> in the repo**. The Lean `UC10_lowerWalshVanishing` does not formalize Y1 at
> all — it proves a degree-0 generator round-trip identity.

### 0.4 Net effect on the Frankl two-part contradiction

The paper closes Frankl by: **Y1** (level-1 isotypes vanish) ∧ **Y2**
(obstruction lands in level-1 isotypes) ⟹ `ob(F⋆) = 0`, contradicting
`ob(F⋆) ≠ 0` (UC11 §6). mg-aeee established Y2's *mechanism* is sound. This
audit establishes that **Y1's proof is broken**. Therefore the two-part
contradiction is **not established**: one part (Y2) is mechanism-sound, the
other part (Y1) is not validly proven. The Frankl closure via the UC10–UC14
route is, on the homological side, **unproven** — consistent with (and
sharpening) `Frankl_Holds`'s standing dependence on
`case3_ss_obstruction_paper_axiom`.

---

## §1 — Scope and method

**The question.** Y1 (per the `mg-39bc` decomposition §3.1; paper-side UC10
§5.3 / UC13 **Theorem 4.5.1**) asserts:

> **Y1 (lower-Walsh vanishing).** In the cubical-Walsh-defect complex `Xₙ∩`
> (`n ≥ 3`), `V_S^k(Xₙ∩) = 0` for every `S ⊊ [n]` and every `k ≥ 1`. In
> particular the level-1 isotypes `V_{x}^{n-1} = 0` for every `x ∈ [n]`.

This is the *vanishing* half of the contradiction (Y2 says *where* the
obstruction lands; Y1 says that place is zero).

**Method.** As instructed, the audit checks the **mechanism**. It traces the
proof of Theorem 4.5.1 step by step — the twisted bridge (UC13 §4.1–4.3), the
cohomological-covering lemma (UC13 §4.4 + its UC14 R2 tightening), and the
vanishing argument (UC13 §4.5) — and stress-tests each against the program's
own committed facts (UC10.1, the sphere class, UC14 R3). It also reads the
Lean artefact named after the theorem (`UC13_PartB/LowerWalsh.lean`).

**Sources read.** `docs/Frankl-Y2-obstruction-isotype-landing.md` (mg-aeee);
`docs/frankl-axiom-restructure-investigation.md` (mg-39bc);
`docs/PROOF-STRUCTURE-ONBOARDING.md`;
`docs/union-closed-UC13-frankl-closure.md` §§1–8 in full;
`docs/union-closed-UC14-uc13-technical-cleanup.md` §§1–4 in full;
`docs/union-closed-UC10-native-cohomology-intersection-closed-families.md`
§§4–5; Lean `UC13_PartB/LowerWalsh.lean`, `UC10/Target.lean`,
`UC11/BKSSCohomologyVanishing.lean` (header), `PaperAxioms.lean`.

**Stance.** Default-skeptical, per the brief. Where this audit finds the proof
broken it says so and shows the contradiction explicitly.

---

## §2 — What Y1's proof is, and its chain of custody

Y1's proof is **not** a single argument; it is assembled across three
documents, none of which proves it alone:

| Document | Role for Y1 | Self-declared status |
|---|---|---|
| **UC10 §5.3** (mg-814b) | States "Step 2/3: `V_S^k = 0`, `S ≠ [n]`, `k ≥ 1`." | **Sketch only.** UC10 §4.1: "UC10.1 is the *target*, not yet proven." UC10 §5.3 gives a one-paragraph "Sketch" — *and a different argument* ("induction on `\|S\|` … the relevant sub-category is sufficiently smaller-dimensional that the cohomology truncates") from UC13's twisted bridge. UC10 verdict: **AMBER**. |
| **UC13 §4** (mg-83f0) | "Executes" §5.3 as Theorem 4.5.1 via the *twisted symmetric bridge*. | §4.3 "**Proof sketch**." §4.4 "**Proof sketch** … modulo lower-dimensional corrections." §4.5 the iterated-trace argument. Verdict banner: GREEN. |
| **UC14 §2 = R2** (mg-500c) | "Tightens" UC13 Lemma 4.4.1 (the covering step §4.5 depends on) from a *surjection* to a *chain-level isomorphism*. | Verdict: **GREEN — R2 closed.** |

So the *only* place Y1 is claimed to be a complete, hedge-free proof is
**UC13 §4 + UC14 R2**. §3 and §4 below show that this assembly does not work.

### 2.1 The mechanism, stated plainly

For `S ⊊ [n]`, pick `x ∈ [n]∖S`. The Walsh character `χ_S` is `σ_x`-symmetric
(`x ∉ S`). The **twisted bridge** `h_x^{tw} := χ_{x}·h_x·χ_{x}` conjugates the
`σ_x`-symmetric situation into the `σ_x`-antisymmetric `χ_{S∪{x}}`-isotype,
applies the standard cubical bridge `h_x` there, and conjugates back. The
output (UC13 Theorem 4.3.1) is a **chain-homotopy identity**

```
   ι_x^{𝒟*} ω  =  ±½ (d h_x^{tw} − h_x^{tw} d) ω        (k ≥ 1)
```

where `ι_x^{𝒟*}` is the trace projection `Xₙ∩ → X_{n-1,x}∩` (restricted to
the matched-in-`x` subcategory `𝒟ₓ`). For a **cocycle** `ω` this reads
`ι_x^{𝒟*} ω = ±½ d(h_x^{tw} ω)` — i.e. **the trace of `ω` is exact**.

That is the entire genuine output of the twisted bridge: *the induced map
`ι_x^{𝒟*}` is zero on cohomology.* Y1 needs more.

---

## §3 — Core finding: UC14 R2 is provably false

UC14 R2 is the step the project treats as removing UC13 §4.4's "modulo
lower-dimensional corrections" hedge. Its headline (UC14 Theorem 2.7.1):

> *For `S ⊊ [n]` and `x ∈ [n]∖S`, the inclusion `X(𝒟ₓ) ↪ Xₙ∩` is a
> chain-level **isomorphism** on the `χ_S`-isotype … the induced map
> `H̃^k(X(𝒟ₓ))_{χ_S} ⥲ V_S^k(Xₙ∩)` is an **isomorphism** for all `k ≥ 0` —
> strictly stronger than UC13 Lemma 4.4.1's claimed surjection.*

### 3.1 The contradiction

Take `S = [n]∖{x}` (a proper subset, `|S| = n-1`; legal — R2 is stated for
*every* `S ⊊ [n]`, `x ∉ S`) and `k = n-2` (`≥ 1` for `n ≥ 3`).

**Fact A — the source group is the sphere class `sgn`.** `𝒟ₓ` is the
fully-matched-in-`x` subcategory; by UC14 Lemma 2.3.1 it is the doubling image
`db_x(C_{n-1,x}∩)`, and by UC12 Lemma 2.7
`X(𝒟ₓ) ≅ X_{n-1,x}∩ × Iₓ` — a **cylinder**. Cohomology is homotopy-invariant,
so `H̃^{n-2}(X(𝒟ₓ)) ≅ H̃^{n-2}(X_{n-1,x}∩)`. Now `[n]∖{x}` is the **full
ground set** of `X_{n-1,x}∩`, so `χ_{[n]∖{x}}` is its **top** Walsh character,
and

```
   H̃^{n-2}(X(𝒟ₓ))_{χ_{[n]∖{x}}} ≅ V_{[n]∖{x}}^{n-2}(X_{n-1,x}∩)
                                 = V_{[n-1]}^{n-2}(X_{n-1}∩) ≅ sgn_{S_{n-1}} ≠ 0.
```

This last isomorphism is the program's **own committed fact** — it is exactly
the sphere class that **UC14 R3 §3.6** invokes verbatim as a load-bearing
input ("`V_{[n-1]}^{n-2}(X_{n-1}∩)` … equals `sgn_{S_{n-1}}`, one-dimensional
(**NOT zero — this is the sphere class** of `X_{n-1}∩`)").

**Fact B — the target group must vanish.** `V_{[n]∖{x}}^{n-2}(Xₙ∩)` is a
*lower* isotype (`[n]∖{x} ⊊ [n]`) at degree `n-2`. Y1 / UC10.1 require it to
be **0** (UC10.1: `H̃^k(Xₙ∩) = 0` for `1 ≤ k ≤ n-2`, so *every* isotype
vanishes there). This is also the very conclusion UC13 §4.5 / Theorem 4.5.1 is
trying to prove.

**The contradiction.** R2 asserts `H̃^{n-2}(X(𝒟ₓ))_{χ_S} ≅ V_S^k(Xₙ∩)` is an
isomorphism. With `S = [n]∖{x}`, `k = n-2`, that is an isomorphism
`sgn ≅ 0`. **A chain-level isomorphism cannot carry a nonzero group onto a
zero group.** Hence **UC14 R2's isomorphism claim is false.**

### 3.2 This is an *internal* inconsistency, not an external objection

The contradiction uses no fact outside the program:

- `X(𝒟ₓ) ≅ X_{n-1,x}∩ × Iₓ` is UC14 Lemma 2.3.1 + UC12 Lemma 2.7.
- `V_{[n-1]}^{n-2}(X_{n-1}∩) ≅ sgn ≠ 0` is the sphere class **UC14 R3 §3.6
  itself uses**.
- `V_S^{n-2}(Xₙ∩) = 0` for `S ⊊ [n]` is UC10.1 **and** R2's own sibling
  target (Theorem 4.5.1).

So **UC14 R2 contradicts UC14 R3, and contradicts UC10.1, inside a single
"GREEN — R1+R2+R3 all closed" document.** At the smallest case `n = 3`:
`S` of size 2, `k = 1`, R2 forces `V_{S}^1(X_3∩) ≅ V_{[2]}^1(X_2∩) ≅ sgn_{S_2}
≠ 0` while Y1 requires `V_S^1(X_3∩) = 0`. Concrete and unambiguous.

### 3.3 Where R2's proof goes wrong (diagnosis)

R2's single-family step (UC14 Theorem 2.4.1 — the `σ_y`-eigenvalue cell-support
computation, Lemma 2.2.1) is plausibly *correct*: the `χ_S`-isotype of one
family's cochain complex genuinely is supported on matched-in-`x` cells. (It
carries one repairable imprecision — Lemma 2.2.1 constrains only the *base*
vertex `A`, where it must constrain the *whole cell* `σ_x C(A,T') ∈ X(F)`;
the repaired version still gives the single-family conclusion.)

The false step is the **hocolim lift, UC14 Theorem 2.6.2**: "the Bousfield–Kan
hocolim model commutes with cell-by-cell identifications across functorial maps
(UC12 §3.2 'hocolim coherence')." A per-object identification
`C*(X(F))_{χ_S} = C*(X(𝒟ₓF))_{χ_S}` does **not** lift to a chain isomorphism
of the *hocolims*, because `Xₙ∩` is a hocolim over the **whole** category
`Cₙ∩` — its Bousfield–Kan bicomplex sums over bar strings through *all*
objects, including the non-matched families `𝒢 ∉ 𝒟ₓ` and the trace morphisms
into them. UC14 Lemma 2.6.1 establishes only that `𝒟ₓ` is a **categorical
retraction** of `Cₙ∩|_{x∈S}`; a retraction `r∘i = id` makes `H̃*(X(𝒟ₓ))` a
**direct summand** (split mono / split epi) of `H̃*(Xₙ∩)` — **not** an
isomorphism. An isomorphism would need `i∘r ≃ id` as well (a *deformation*
retraction), which is false: `Cₙ∩` does not deformation-retract onto `𝒟ₓ`.
R2's Theorem 2.6.2 over-reads "retraction" as "isomorphism" behind a vague
"hocolim coherence" citation. The honest statement that survives is exactly
UC13 Lemma 4.4.1's original cautious **surjection** — see §4.2.

---

## §4 — Consequently, UC13 §4.5's proof of Y1 is invalid

### 4.1 The logical gap

UC13 §4.5 proves Theorem 4.5.1 thus (paraphrased): *"By Theorem 4.3.1,
`ι_x^{𝒟*}ω` is exact for every cocycle `ω ∈ V_S^k` supported on `𝒟ₓ`. … `ι_x^{𝒟*}`
is the trace projection onto `V_S^k(X_{n-1,x}∩)` (which is at most isomorphic
by the same argument applied to `n-1`). Iterate … After `n−|S|` iterations the
target ground set is `S` itself … the iterated bridge has exhibited each
cohomology class as a coboundary at each step … Hence `V_S^k(Xₙ∩) = 0`."*

The defect: **"`ι_x^{𝒟*}ω` is exact" means the induced map `ι_x^{𝒟*}` is the
zero map on `V_S^k`-cohomology.** It is a statement about the *image* of
`ι_x^{𝒟*}`, not about its *domain*. The zero map tells you *nothing* about
whether the domain `V_S^k(Xₙ∩)` is zero — a zero map out of a nonzero group is
perfectly possible. Composing zero maps down the iteration
`V_S^k(Xₙ∩) → V_S^k(X_{n-1,x}∩) → ⋯ → V_S^k(X_S∩)` likewise yields nothing.
"The iterated bridge has exhibited each class as a coboundary at each step" is
not true: the bridge exhibits the *trace* `ι_x^{𝒟*}ω` as a coboundary, never
`ω` itself.

To convert "`ι_x^{𝒟*} = 0` on cohomology" into "`V_S^k(Xₙ∩) = 0`" you need
`ι_x^{𝒟*}` **injective** on cohomology (zero + injective ⟹ domain is zero).
§4.5's parenthetical "at most isomorphic by the same argument applied to
`n-1`" is exactly an injectivity claim — but it is **circular** (the argument
at `n-1` needs the same injectivity) and is never discharged.

### 4.2 The gap is not closed by UC14 R2

UC14 R2 is the only document that supplies a non-circular injectivity input:
its chain isomorphism `H̃^k(X(𝒟ₓ))_{χ_S} ≅ V_S^k(Xₙ∩)` would make `ι_x^{𝒟*}`
an isomorphism, hence injective, closing §4.5. But §3 shows **R2 is false.**
What is actually true is UC13 Lemma 4.4.1's original claim: a **surjection**
`H̃^k(X(𝒟ₓ))_{χ_S} ↠ V_S^k(Xₙ∩)`. A surjection `sgn ↠ 0` is fine (the zero
map) — so the surjection is *consistent with* Y1 but does **not prove** it:
proving `V_S^k(Xₙ∩) = 0` from a surjection requires showing the surjection is
the zero map, which neither §4.5 nor R2 does. **Y1's proof has a real,
load-bearing, unfilled gap.**

### 4.3 The honest comparison: §5 / R3 did this correctly; §4 / R2 did not

The sibling statement — top-Walsh concentration `V_{[n]}^k = 0` for `k < n-1`
(UC13 §5) — faces the *identical* obstacle. UC13 §5.2 is **honest about it**:
after deriving `ι_x^*ω = ±½ d(h_x ω)` (trace exact) it writes verbatim *"We
need a more careful argument"* — precisely because trace-exactness does not
give class-vanishing. UC14 **R3** then closes §5 properly: it does **not**
claim `ι_x^*` is injective (it cannot — `V_{[n]}^{n-1} ≅ sgn ≠ 0`, so `ι_x^*`
*is* non-injective on the top isotype). Instead R3 §3.6 uses a genuine
**cofiber long-exact-sequence + induction on `n`**: from `ι_x^* = 0` it feeds
the LES `H^{k-1}(X_{n-1,x}) →^δ H^k(cofib) → H^k(Xₙ) → H^k(X_{n-1,x})`, kills
the connecting-map source by the inductive hypothesis, and computes the
cofiber.

UC13 §4 (Y1) should have used the **same** cofiber-LES+induction method. It did
not. §4 took a shortcut — assert the chain isomorphism R2 — and that shortcut
is false. The asymmetry is the tell: **R3 knew trace-exactness ≠
class-vanishing and worked for it; R2 forgot, and asserted an isomorphism that
its own document's R3 refutes.**

### 4.4 Residual soft spots in Y1's mechanism (independent of the §3 finding)

Even setting the R2 falsity aside, the Y1 mechanism is not referee-grade:

- **Remark 4.2.2 — the in-existing-coordinate bridge `h_x`.** UC12's bridge is
  the *doubling* bridge in a *new* coordinate `n+1`. Y1 needs a bridge in an
  *existing* coordinate `x ∈ [n]`. UC13 Remark 4.2.2 defines it "directly
  analogous" / "mirroring UC12 Definition 3.1" and never re-derives the
  chain-homotopy property. (This is repairable — `𝒟ₓ` genuinely has the prism
  structure `X(𝒟ₓF) ≅ X(ρₓF)×Iₓ` — but it is asserted, not proved.)
- **Theorem 4.3.1 — "Proof sketch."** The twisted chain-homotopy identity. Its
  step "`d` commutes with the multiplication `χ_{x}·`" is valid only on the
  `χ_S`-supported cells (`x ∉ T'`), which needs Lemma 2.2.1 — a *forward*
  dependency on UC14 R2 that UC13 §4.3 does not cite. The typing is murky
  (`ι_x^{𝒟*}ω` and `(dh−hd)ω` live in different complexes; the identity is
  stated "in `C^k(Xₙ∩)_{χ_S}`" without saying which identification glues
  them).
- **Degree-convention drift.** §4.2 fixes `h_x^{tw} : V_S^k → V_S^{k-1}`
  (degree `−1`, matching UC12 Defn 3.1). §5.3 then describes `h_x ω` for
  `ω ∈ V_{[n]}^{n-1}` as "a non-trivial `n`-cochain" (degree `+1`). The two
  sections of the *same* closing document disagree on the bridge's degree.

These are "sketch"-grade exposition issues. The §3 finding (R2 false) is the
disqualifying one.

---

## §5 — The Lean side: `UC10_lowerWalshVanishing` does not formalize Y1

`lean/UnionClosed/UC13_PartB/LowerWalsh.lean` contains `UC10_lowerWalshVanishing`,
presented (docstring + `PROOF-STRUCTURE-ONBOARDING.md` §4 cross-ref table) as
the Lean formalization of "UC13 Theorem 4.5.1 = UC10 §5.3." It is not.

```lean
theorem UC10_lowerWalshVanishing (F : IntClosedFam n) (x : Fin n) :
    walshScale n {x} (bridgeOpAt F (walshScale' n {liftCoord n x}
      (bridgeImg n 0 (Finsupp.single ⟨OpChain.const F, CubeCell.topVertex F⟩ 1)))) =
    Finsupp.single ⟨OpChain.const F, CubeCell.topVertex F⟩ 1
```

What it actually proves, and why it is non-faithful:

1. **It is an IDENTITY, not a VANISHING.** Y1 says cohomology *vanishes*. This
   theorem proves `(operator) generator = generator` — the operator is the
   **identity** on one generator. The file's own
   `UC10_lowerWalshVanishing_nonzero` then proves the result is **non-zero**.
   A *vanishing* theorem whose Lean witness is a *non-zero identity* has
   inverted its own content.
2. **Its entire mathematical content is `χ² = 1`.** The proof is
   `twistedBridge_splitting_topVertex` (bridge round-trip yields the generator
   scaled by `walshChar {x} F.support · walshChar {liftCoord x} (liftFin
   F.support)`) then `twistedBridge_scalars_cancel` (that product `= 1`, via
   `walshChar_lift_singleton` + `walshChar_singleton_sq`, i.e.
   `(-1)^a·(-1)^a = 1`). It is `bridge∘bridgeImg = id` (L2b machinery) composed
   with the Walsh involution `χ∘χ = id`. There is no `d`, no cocycle, no
   `dh − hd`, no homology, no exactness — **zero vanishing content.**
3. **It has no `S`, no `k`.** Y1 is about `V_S^k`, `S ⊊ [n]`, `k ≥ 1`. The
   theorem takes `F` and `x` only — no `S`, no `S ⊊ [n]`, no `x ∉ S`, no
   `k ≥ 1`. The docstring says `x` "plays the role of `x ∈ [n]∖S`," but `S`
   appears nowhere in the statement.
4. **The development admits the gap.** The docstring's "L5 gap (named)"
   paragraph states outright: "full cohomological `IsZero ((walshMult n
   S).homology k)` requires the per-S `(Z/2)ⁿ`-isotype projection … for
   `k ≥ 1`. At L2a-residual-residual the chain group `walshMult n S` is the
   **underlying chain group at degree 0** (no per-S decomposition)." So the
   real Y1 statement is, by the development's own admission, **not
   formalized.**
5. **Even the named operator is wrong.** `twistedBridgeOpAt` (the def labelled
   `h_x^{tw}`) twists by `χ_{insert(last, castSucc x)}` — a **level-2**
   character — while the theorem uses `χ_{liftCoord x}` — a **level-1**
   character. The theorem does not use the development's own "twisted bridge
   operator."

**Does the Lean *contradict* Y1?** No. `UC10_lowerWalshVanishing_nonzero`
proves a non-zero *chain* (a generator in `(BKTotal n).X 0`); a non-zero chain
is fully compatible with vanishing *cohomology*. No Lean theorem proves any
level-1 (or lower) isotype non-zero *in cohomology*. So — unlike the
(ultimately artefactual) Y2 situation mg-39bc worried about — the Lean neither
supports nor contradicts Y1. It is simply a **non-faithful placeholder**,
exactly the pathology mg-aeee found on the Y2 side (`cechIsotypeProjection` =
a hand-coded `if`; here = a `χ²=1` round-trip). It cannot be cited as evidence
for Y1.

---

## §6 — What is genuinely solid (for balance)

The audit should not overstate. The following are real:

- **The twisted-bridge *device* is legitimate.** Conjugating by `χ_{x}·` to
  swap a `σ_x`-symmetric isotype with a `σ_x`-antisymmetric one is a sound
  trick; `χ_{x}·` is an involution and (on the `χ_S`-supported cells)
  commutes with `d`.
- **Theorem 4.3.1's output is plausibly correct** *as a statement about the
  trace*: `ι_x^{𝒟*}ω` is exact for cocycles. This is the standard cylinder
  (prism) chain-homotopy. The error is not here — it is in §4.5's *use* of
  this output.
- **Y1 the statement is plausibly true.** It is UC10.1's content, the F17/F18
  analog. Its sibling (top-Walsh, §5) is closeable by R3's cofiber-LES+
  induction, and the same method should close Y1 — where, additionally, the
  induction *bottoms out at zero* for the Frankl-relevant degree (`k = n-1` at
  the ground set `S` exceeds the `|S|`-cube dimension), which is structurally
  favourable.
- **No reversal, no formalization-contradiction.** Unlike the Y2 history
  (UC11 §5.3 → UC13 §2.4.1 reversal; the alleged Lean contradiction), Y1 has a
  single consistent target across UC10/UC13/UC14 and no Lean theorem against
  it. Y1's problem is a *broken proof*, not a contested statement.

So the verdict is **Y1-HIGH-RISK**, not **Y1-CONTRADICTED**: the proof is
invalid and its key tightening is false, but the statement itself stands
unrefuted and is probably provable by the correct method.

---

## §7 — Comparison to mg-aeee's Y2 verdict; the residual is *not* a confined property

mg-aeee gave **Y2-SUPPORTED** with "residual risk now confined to the
faithfulness of the `F_obs` construction (no cup product) — a checkable
structural property, not a coin-flip reversal." The brief for this ticket asks
whether Y1 is similar.

**It is not.** For Y2 the *mechanism* was machine-checked sound and only an
input hypothesis remained to check. For Y1 the *mechanism itself* is broken:

- A load-bearing step (UC13 §4.5) commits a genuine logical error
  (trace-exactness ⟹ class-vanishing).
- The cited tightening (UC14 R2) is **provably false**, and false in a way
  that contradicts the program's own sphere class and its own sibling lemma
  R3.

The residual is therefore *not* "a checkable structural property" — it is a
**missing proof**. Y1 needs a new, correct argument (cofiber-LES+induction,
modelled on R3), not merely the verification of a hypothesis. This is a
materially weaker position than Y2's.

**Net effect on the two-part contradiction.** Y2 mechanism: sound (mg-aeee).
Y1 mechanism: broken (this audit). The contradiction `Y1 ∧ Y2 ⟹ ob = 0` is
therefore **not established**. This does not make Frankl false; it confirms —
and sharpens — that the homological half of the paper proof is unproven, fully
consistent with `Frankl_Holds` still resting on
`case3_ss_obstruction_paper_axiom`. The specific new fact for the project
record: **the UC14 "GREEN — all residuals closed" verdict is wrong on R2.**

---

## §8 — Recommendations

Routed to Daniel via `pm-onethird` (the polecat does not mail Daniel directly,
per the brief).

1. **Record UC14 R2 as FALSE.** UC14's "GREEN — R1 + R2 + R3 all closed" verdict
   is incorrect: R2's chain-level isomorphism `H̃^k(X(𝒟ₓ))_{χ_S} ≅ V_S^k(Xₙ∩)`
   contradicts UC10.1 and UC14 R3 (§3 above). UC14 §2.7 and the UC14 verdict
   should be re-banded; `PROOF-STRUCTURE-ONBOARDING.md` §4 (which cites R2's
   "Formalized" status) and §3 should carry a correction. The honest statement
   is UC13 Lemma 4.4.1's **surjection**, not an isomorphism.

2. **Treat Y1 (UC13 Theorem 4.5.1) as UNPROVEN, not GREEN.** UC13 §4.5's
   argument is logically invalid as written and is not rescued by R2. The
   downgrade is symmetric with mg-aeee's treatment of the Y2 Lean artefacts.

3. **The correct proof route exists — port R3's method to §4.** Y1 should be
   re-proved by cofiber-LES + induction on `n`, exactly as UC14 R3 closed the
   sibling top-Walsh concentration. This is real work, but it is *bounded*
   work on a *plausibly true* statement — not a coin-flip. Whoever does it
   must **not** re-use R2's chain-isomorphism shortcut.

4. **Do not cite `UC10_lowerWalshVanishing` as a formalization of Y1.** It is
   a degree-0 `χ²=1` round-trip identity (§5). Like mg-aeee's finding on
   `cechIsotypeProjection`, it should be re-documented as a placeholder, not
   evidence.

5. **The Zulip post stays held.** mg-39bc already recommended holding it; this
   audit reinforces that on the Y1 side. The paper's two-part contradiction
   has one mechanism-sound half (Y2) and one broken-proof half (Y1). Until Y1
   has a correct proof, the Frankl closure is not referee-grade.

---

## §9 — Cross-references

- **Brief:** `mg-552b`. **Y2 counterpart audit:** `mg-aeee`
  (`docs/Frankl-Y2-obstruction-isotype-landing.md`) — Y2-SUPPORTED; explicitly
  left Y1 unaudited (§6).
- **Y1/Y2/Y3 decomposition + risk framing:** `mg-39bc`
  (`docs/frankl-axiom-restructure-investigation.md`) §3.1 (Y₁ statement), §5.4
  (Y1 "moderate risk; UC13 §5.2/§4.5 sketches; UC14 tightening unrefereed").
  This audit sharpens "moderate" to **HIGH** — the UC14 R2 tightening is not
  merely unrefereed, it is **false**.
- **The paper proof of Y1:**
  `docs/union-closed-UC13-frankl-closure.md` §4 (twisted bridge; §4.3 "Proof
  sketch", §4.4 "Proof sketch … modulo lower-dimensional corrections", §4.5
  Theorem 4.5.1), §5 (sibling top-Walsh; §5.2 "We need a more careful
  argument"), §7 (the closing two-part contradiction);
  `docs/union-closed-UC14-uc13-technical-cleanup.md` §2 (**R2 — the false
  isomorphism**: Lemma 2.2.1, Theorem 2.4.1, **Theorem 2.6.2 the false hocolim
  lift**, Theorem 2.7.1), §3 (R3 — the *correct* sibling method, §3.6 uses the
  sphere class that refutes R2);
  `docs/union-closed-UC10-native-cohomology-intersection-closed-families.md`
  §4.1 (UC10.1 statement), §5.3 (the AMBER one-paragraph sketch).
- **The non-faithful Lean artefact:**
  `lean/UnionClosed/UC13_PartB/LowerWalsh.lean` (`UC10_lowerWalshVanishing`,
  `UC10_lowerWalshVanishing_nonzero`, `twistedBridgeOpAt`).
- **Onboarding to correct:** `docs/PROOF-STRUCTURE-ONBOARDING.md` §3 (status
  table — Y1/Y1b row + UC14 cross-ref) and §4 (paper↔Lean table, "UC10 §5.3 …
  Formalized" row) both currently over-state Y1's status.

---

*Audit by polecat `cat-mg-552b`. Deliverable on `main`: this report. Verdict:
**Y1-HIGH-RISK** — the level-1 Walsh vanishing is plausibly true but not
validly proven; UC13 §4.5 conflates trace-exactness with cohomology-vanishing,
and the UC14 R2 "tightening" cited as closing that gap is provably false (it
transports the program's own sphere class into a lower isotype that Y1
requires to vanish, contradicting UC14 R3 and UC10.1). A correct proof
(cofiber-LES + induction, per UC14 R3's method) is achievable but absent. The
Lean `UC10_lowerWalshVanishing` is a non-faithful placeholder (a degree-0
`χ²=1` round-trip identity), neither supporting nor contradicting Y1. The
Frankl two-part contradiction therefore has one mechanism-sound half (Y2,
per mg-aeee) and one broken-proof half (Y1).*
