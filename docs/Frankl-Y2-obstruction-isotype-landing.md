# Frankl-Y2-Resolution — which Walsh isotype does the obstruction class actually land in

**Work item:** `mg-aeee` (honest machine-checked formalization + this report).

**Trigger.** The `mg-39bc` investigation (`docs/frankl-axiom-restructure-investigation.md`)
flagged step **Y2** — UC13 §2.4.1, "the obstruction class `ob(F⋆)` lands
entirely in the level-1 Walsh isotypes" — as **HIGH RISK**, with specific
evidence it may be FALSE: the natural Lean encoding put the obstruction on
`topVertex` and *proved it non-zero* (`topVertex_not_coboundary`), and `mg-36c3`
found the paper-axiom conclusion is propositionally equivalent to
`topVertex_not_coboundary` FAILING. Y2 is also a late reversal — UC13 §2.4.1
reversed UC11 §5.3, which had said the obstruction lands in the *opposite*
isotype.

This ticket resolves Y2 by **honest, machine-checked Lean formalization** — not
by re-deriving the paper argument. The deliverable is the truth about the
landing, whichever way it goes.

**Deliverable Lean:** `lean/UnionClosed/UC13_PartA/ObstructionIsotypeLanding.lean`
(678 lines, no `sorry`, no `axiom`; `lake build` GREEN, 2065 jobs; every theorem
cited below depends only on the mathlib trio `propext / Classical.choice /
Quot.sound` — verified by `#print axioms`).

---

## §0 — Verdict (top of page)

### 0.1 Headline: **Y2-SUPPORTED** — but the current Lean development does *not* honestly formalize Y2 either way.

Two findings, both machine-checked, point the same direction:

1. **Y2's landing *mechanism* is sound.** The genuine content of UC13 §2.4.1 is:
   a `(ℤ/2)ⁿ`-equivariant *additive* linear map preserves the Walsh-isotype
   decomposition (Schur for the finite abelian group). This is
   `equivariant_preserves_InIsotype`, machine-checked. Its converse — UC11
   §5.3's claim that the additive Čech edge map "increments Walsh level by 1 at
   each step" — is machine-checked **representation-theoretically impossible**:
   the *only* operation that shifts isotype level is multiplication by a Walsh
   character (the cup product), `mulWalsh_shifts_isotype`, and an additive Čech
   bicomplex has no cup product. **UC13's reversal of UC11 §5.3 is in the
   mathematically correct direction.**

2. **The mg-39bc "evidence Y2 may be false" is refuted — it was an
   encoding/labelling artifact.** Honestly formalised, the actual Lean
   obstruction encoding `obstructionClass F x = single (topVertex F) (β_x F)`
   lands in **no Walsh isotype at all**: it is a single cube vertex, and a
   single regular-representation basis vector has a non-zero component in
   **every** one of the `2ⁿ` isotypes (`obstruction_lands_in_every_isotype`,
   `single_walsh_decomposition`). It is concentrated neither in level-1 (Y2)
   nor in the top `χ_[n]` (UC11 §5.3). Moreover `topVertex_not_coboundary`
   does **not** detect a top-`χ_[n]` obstruction: it works through the
   augmentation `BKAug`, which is machine-checked to be the **trivial `χ_∅`**
   Walsh coefficient (`walshCoeff_empty_eq_augmentation`) — the `H₀`
   connectedness generator, a different isotype *and* a different degree from
   the `χ_[n]^{n-1}` the contradiction was read into.

So the "the formalisation proved the opposite of Y2" claim does not survive
honest formalisation. It rested on two false identifications (§5).

### 0.2 The non-negotiable caveat — this is a verdict about the *mathematics*, not about the Lean proof.

**"Y2-SUPPORTED" does NOT mean the Frankl Lean development is sound.** Two
things this ticket establishes about the *current Lean code*, both negative:

- **The existing Lean "formalization" of Y2 is answer-steered.**
  `UC13_PartA/IsotypePreservation.lean` defines the "isotype projection" as
  `cechIsotypeProjection F x T := if T = {x} then cechBicomplexValue F x else 0`
  — a hand-coded `if` with **no representation theory in it**. `UC13_correctedLanding`
  proves "ob lands in level-1" *from that definition*. That is circular: the
  encoding asserts the answer (§2). It cannot be used to support Y2.
- **The actual `obstructionClass` encoding is non-faithful.** It is a single
  cube vertex; it lands in no isotype (§4). It faithfully represents neither
  landing claim.

A genuine, faithful Lean formalisation of the *full* Y2 statement — the real
obstruction class landing in level-1 — is **not delivered by this ticket and
does not exist in the repo.** It requires the faithful Walsh-isotype obstruction
encoding (the multi-week refactor `mg-39bc` §6 calls "path (a)"). What this
ticket delivers is the honest machine-checked determination of *where the
current encoding lands* and of *whether Y2's mechanism is sound* — and the
answer to "is there evidence Y2 is false" is **no**.

### 0.3 One-line verdict

> **Y2-SUPPORTED.** The representation-theoretic mechanism Y2 depends on
> (equivariant additive maps preserve Walsh isotype; only the cup product
> shifts level) is machine-checked sound, and UC11 §5.3's competing claim is
> machine-checked impossible. The specific evidence that Y2 "may be false" —
> the formalisation "proving the opposite" — is machine-checked to be an
> artifact of a non-faithful single-vertex obstruction encoding plus an
> isotype-mislabelling of `topVertex_not_coboundary` (it detects the trivial
> `χ_∅` isotype, not the top `χ_[n]`). **Caveat:** the current Lean
> development still does not *honestly formalize* Y2 — its `cechIsotypeProjection`
> is answer-steered and its `obstructionClass` encoding is non-faithful — so
> this verdict supports the mathematics of the landing, not the Lean proof.

---

## §1 — Scope and method

**The question.** Y2 (UC13 §2.4.1) asserts the obstruction class `ob(F⋆)` lands
in the level-1 Walsh isotypes `⊕_x V_{x}^{n-1}`. UC11 §5.3 (abandoned) asserted
it lands in the top `χ_[n]` isotype `V_{[n]}^{n-1}`. The ticket asks which the
mathematics actually forces, by honest formalisation.

**Method.** A Walsh isotype is a representation-theoretic object: the
isotypic-`χ_T` part of a `(ℤ/2)ⁿ`-representation. To answer "which isotype" one
must build the genuine `(ℤ/2)ⁿ` representation theory and *compute*, not assert.
The deliverable file does exactly that, in the regular representation of
`(ℤ/2)ⁿ` on the cube-vertex set.

**Neutrality discipline.** Per the brief, the encoding must not be steered. Every
encoding choice (§3) is one of the standard objects of `(ℤ/2)ⁿ` representation
theory; none is chosen to favour an outcome. The determination (§4) then falls
out by computation. Where the honest answer differs from what the project's
existing files claim, this report says so plainly.

**Sources read.** `docs/frankl-axiom-restructure-investigation.md` (mg-39bc);
`docs/PROOF-STRUCTURE-ONBOARDING.md`; `docs/union-closed-UC11-cech-sheaf-frankl-program.md`
§5.3, §2; `docs/union-closed-UC13-frankl-closure.md` §2.2–2.7; `docs/state-UC-Lean-per-x-closure.md`
(mg-36c3); Lean `UC10/Walsh.lean`, `UC10/CubicalDefect.lean`, `UC10/BousfieldKan.lean`,
`UC11/ObstructionClass.lean`, `UC11/FObs.lean`, `UC11/CohomologyClass.lean`,
`UC13_PartA/IsotypePreservation.lean`, `UC13_PartA/CorrectedLanding.lean`,
`PaperAxioms.lean`.

---

## §2 — The existing Lean "formalization" of Y2 is answer-steered

`UC13_PartA/CorrectedLanding.lean` contains `UC13_correctedLanding`, presented
as the Lean formalisation of UC13 §2.4.1 (Y2). It proves, for the per-coordinate
"isotype projection" `cechIsotypeProjection`, that the projection onto every
non-`{x}` isotype vanishes and the top-`χ_[n]` projection is zero — i.e. "ob
lands in level-1."

But `cechIsotypeProjection` is defined in `UC13_PartA/IsotypePreservation.lean`
as:

```lean
noncomputable def cechIsotypeProjection (F : IntClosedFam n) (x : Fin n)
    (T : Finset (Fin n)) : (BKTotal n).X 0 :=
  if T = {x} then cechBicomplexValue F x else 0
```

This "isotype projection" **applies no toggle action, uses no Walsh character,
computes no projection.** It is a hand-coded `if T = {x}`. It *defines* the
projection onto `χ_T` to be the whole obstruction when `T = {x}` and `0`
otherwise. Proving "the obstruction lands in level-1" from this is circular: the
definition asserts the conclusion. `UC13_correctedLanding` and
`UC13_isotypePreservation` are theorems *about an `if`-statement*, not about
`(ℤ/2)ⁿ` representation theory.

(For the record, `cechBicomplexValue F x = localBiasCochain x F`, which
`UC11/FObs.lean:101` defines as `single ⟨const F, topVertex F⟩ (-β_x F)` — the
same single cube vertex as `obstructionClass`. So even the object being
"projected" is the non-faithful single-vertex placeholder.)

**Consequence.** The existing Lean development cannot adjudicate Y2: its Y2
"formalization" begs the question. A genuine determination must be built from
scratch — which is what `ObstructionIsotypeLanding.lean` does.

---

## §3 — The honest formalization: encoding choices, each justified as faithful

All choices are the standard objects of `(ℤ/2)ⁿ` representation theory; they are
spelled out in the file's header docstring. Summary:

| # | Choice | Faithfulness justification |
|---|---|---|
| E1 | The group `(ℤ/2)ⁿ` is `(Finset (Fin n), ∆, ∅)`. | Exactly UC10's identification: `Walsh.lean`'s `toggleSupport` is the group iso `(Fin n → ZMod 2) ≃ Finset (Fin n)` carrying `+` to `∆` (`toggleSupport_add`). Indexing by subsets *is* indexing by group elements. |
| E2 | The cube-vertex set is `Finset (Fin n) = 2^[n]`; `(ℤ/2)ⁿ` acts regularly by `S · A = A ∆ S`. | This is `Walsh.lean`'s `toggleAction`. The cube `Q_n` has vertex set `2^[n]`; degree-0 chains form the regular representation `ℚ[2^[n]]`. |
| E3 | Walsh characters are `Walsh.lean`'s `walshChar n T A = (-1)^{|T∩A|}`. | The genuine irreducible characters of `(ℤ/2)ⁿ`, used unchanged. |
| E4 | "`v` lands in the `χ_T`-isotype" is `InIsotype n T v`: `∀ S, toggleBy S v = χ_T(S) • v`. | The textbook definition of an isotypic element for a finite abelian group — `v` transforms by the character. NOT a hand-coded `if` (contrast §2). |
| E5 | The obstruction read into the model is `obstructionVertex F x = single (F.support) (β_x F)`. | `obstructionClass F x` is `single` on the cell `⟨const F, topVertex F⟩`; that cell's `.base` field (its cube vertex) is `F.support`. The map `cubeVertexOf` reads it off; `obstruction_cubeVertexRead` proves the bridge. The Walsh question for a degree-0 cube chain is, by definition, the question in `ℚ[2^[n]]`. |

**Why these are not steered.** The toggle action, the Walsh characters, and the
isotype predicate `InIsotype` are forced — they are *the* representation theory
of `(ℤ/2)ⁿ`, the same objects UC10/UC11/UC13 invoke on paper. The only
freedom is E5, the bridge from `obstructionClass` to the model; and E5 is
pinned by the *definition* of `obstructionClass` (it is literally `single` on a
cell whose `.base` is `F.support`). Nothing here is tuned to land the
obstruction anywhere.

**Grounding that the model is genuine** (not a toy):
`walshVec n T` (the alternating Walsh sum `Σ_A χ_T(A)·single A`) is
machine-checked to be a genuine `χ_T`-eigenvector (`toggleBy_walshVec`,
`walshVec_InIsotype`); `walshCoeff n T` is machine-checked to be a genuine
`χ_T`-detector — `χ_T`-equivariant (`walshCoeff_toggleBy`), non-zero on the
`χ_T`-isotype (`walshCoeff_walshVec_self = 2ⁿ`), and zero on every *other*
isotype (`walshCoeff_eq_zero_of_InIsotype`, Schur).

---

## §4 — The determination: what the machine checked

### 4.1 A single cube vertex is in NO Walsh isotype.

`single_not_InIsotype` (`n ≥ 1`, `r ≠ 0`): `single A r` is not an isotypic
element for *any* `χ_T`. A bare regular-representation basis vector is not a
character eigenvector — toggling moves it to a different basis vector.

### 4.2 A single cube vertex spreads UNIFORMLY over all `2ⁿ` isotypes.

`single_walsh_decomposition` (Walsh inversion):
```
single A r  =  Σ_{T ⊆ [n]}  ((r · χ_T(A)) / 2ⁿ) • walshVec n T
```
Every coefficient `(r·χ_T(A))/2ⁿ` is non-zero (`χ_T(A) = ±1`,
`single_walshCoeff_ne_zero`). The single cube vertex has a non-zero component
of equal magnitude `|r|/2ⁿ` in **every one of the `2ⁿ` isotypes**.

### 4.3 Therefore the actual obstruction encoding lands in NO isotype — and in EVERY isotype at once.

`obstructionClass F x = single (topVertex F) (β_x F)`, and `topVertex F`'s cube
vertex is `F.support` (E5). So `obstructionVertex F x = single (F.support) (β_x F)`,
and for `β_x F ≠ 0` (in particular for every coordinate of any counterexample,
where `β_x F > 0`):

- `obstruction_not_InIsotype` — it is in **no** Walsh isotype.
- `obstruction_lands_in_every_isotype` — its `χ_T`-component is non-zero for
  **every** `T`: `walshCoeff n T (obstructionVertex F x) = χ_T(F.support) · β_x F`,
  which is `±β_x F ≠ 0`. The top `χ_[n]`, every level-1 `χ_{x}`, and the
  trivial `χ_∅` all receive a non-zero component, all of magnitude `|β_x F|`.
- `obstruction_walsh_decomposition` — the explicit `2ⁿ`-term decomposition.

The current Lean obstruction encoding is **isotype-blind**. It supports
neither Y2 (level-1) nor UC11 §5.3 (top). It cannot, on its own, decide Y2 —
because it is not a Walsh-isotype-resolved object at all.

### 4.4 The augmentation / `topVertex_not_coboundary` detects the TRIVIAL isotype `χ_∅`.

`walshCoeff_empty_eq_augmentation`: `walshCoeff n ∅ = augmentation n`, because
`χ_∅ ≡ 1` so the `χ_∅`-coefficient functional is the sum-of-coefficients
augmentation. `UC11/CohomologyClass.lean`'s `BKAug` has exactly this shape
(`Finsupp.linearCombination ℚ (fun _ => 1)`), and `topVertex_not_coboundary` is
proved *through* `BKAug`. So `topVertex_not_coboundary` certifies that the
**trivial `χ_∅`** component of `single (topVertex F) r` is `r ≠ 0` — the `H₀`
connectedness generator. It says nothing about the top `χ_[n]` isotype.

### 4.5 The Y2 mechanism is sound; UC11 §5.3's is impossible.

- `equivariant_preserves_InIsotype` — a `(ℤ/2)ⁿ`-equivariant *additive* linear
  map sends `χ_T`-isotypic elements to `χ_T`-isotypic elements. **This is
  exactly UC13 §2.4.1's mechanism**: an additive equivariant transport cannot
  shift the Walsh isotype.
- `mulWalsh_shifts_isotype` — multiplication by a Walsh character `χ_U` (the cup
  product) shifts `χ_T ↦ χ_{T∆U}`. And `toggleBy_mulWalsh` shows `mulWalsh` is
  *not* equivariant (it is only `χ_U`-twisted-equivariant). So the **only**
  operation that changes Walsh level is multiplicative.

UC11 §5.3 claimed the additive Čech-to-cohomology edge map "increments
Walsh-level by 1 at each step." An additive equivariant map cannot do this
(`equivariant_preserves_InIsotype`); a level increment requires a cup product
(`mulWalsh_shifts_isotype`); an additive Čech bicomplex has no cup product
(UC13 §2.3 is explicit on this, and it is a structural fact, not a choice).
**UC11 §5.3 is representation-theoretically wrong; UC13 §2.4.1's reversal of it
is correct.**

### 4.6 `#print axioms`

Every theorem in §4 depends only on `[propext, Classical.choice, Quot.sound]`
— the mathlib trio. No `sorry`, no project axiom (`case3_ss_obstruction_paper_axiom`
does not appear). The determination is genuinely machine-checked.

---

## §5 — Why the mg-39bc "evidence Y2 may be false" does not survive

The mg-39bc investigation §5.3 — its strongest risk evidence — reads: *"the
natural Lean encoding places the obstruction on the topVertex … the χ_[n] top
isotype … and the team then proved it non-zero … the one serious attempt to
machine-verify the load-bearing step produced its negation."* Honest
formalisation shows this rests on **two false identifications**:

1. **`topVertex` is not the `χ_[n]` generator.** `topVertex F` is the single
   cube vertex `F.support`. A single vertex is a regular-representation basis
   vector; it is in *no* isotype and spreads over *all* of them (§4.1–4.2). The
   genuine `χ_[n]` generator is the *alternating Walsh vector*
   `walshVec [n] = Σ_A (-1)^{|A|} · single A` — a sum over all `2ⁿ` vertices,
   a completely different object from `single (F.support)`. The docstring claim
   (in `topVertex_not_coboundary`) that `topVertex` "is the `χ_{[n]} ⊠ sgn`
   isotype generator" is unverified and, machine-checked, false.

2. **`topVertex_not_coboundary` is a `χ_∅` statement, not a `χ_[n]` one.** It
   is proved through `BKAug` = `walshCoeff ∅` = the **trivial-isotype**
   coefficient (§4.4), and it concerns `homology 0` (degree 0, the `H₀`
   connectedness generator) — whereas Y2 / UC11 §5.3 concern `χ_[n]^{n-1}`
   (degree `n−1`). It is a true and unremarkable fact (`H₀` of a connected
   complex is `ℚ`); it has nothing to say about the top isotype at degree
   `n−1`.

So "the formalisation proved the opposite of Y2" is incorrect. What the
formalisation proved (`topVertex_not_coboundary`) is a `χ_∅`/degree-0 statement;
it neither supports UC11 §5.3 nor contradicts Y2. The `mg-36c3` "structural
collision" is real *as a statement about the non-faithful encoding* — in that
encoding the chain-level vanishing is indeed unprovable — but it is a collision
with the *augmentation* (the `χ_∅` component), not with a top-`χ_[n]`
obstruction. It demonstrates the encoding is non-faithful; it is not evidence
that Y2's level-1 landing is false.

---

## §6 — What this does and does not establish

**Establishes (machine-checked):**

- Y2's landing *mechanism* (equivariant additive transport preserves Walsh
  isotype) is sound; UC11 §5.3's competing "level-increment" is impossible.
- The mg-39bc evidence that Y2 "may be false" is an encoding/labelling artifact.
- The current Lean obstruction encoding is non-faithful (lands in no isotype),
  and the existing `cechIsotypeProjection` formalisation of Y2 is answer-steered.

**Does NOT establish:**

- That the Frankl Lean proof is sound. It is not — the headline `Frankl_Holds`
  still rests on `case3_ss_obstruction_paper_axiom`, untouched by this ticket.
- That Y2 *as a complete statement* ("the real `ob(F⋆)` lands in `⊕_x V_x^{n-1}`")
  is fully formalised. It is not. Y2 = mechanism (proven here) **+** the source
  data of the Čech bicomplex of `F_obs` being genuinely level-1 Walsh. The
  latter is a design property of `F_obs`: the bias `β_x` is, up to sign, the
  level-1 `χ_{x}`-Walsh coefficient of the family indicator (`β_x = #{A: x∉A} −
  #{A: x∈A}` over the family `= −Σ_A 1_F(A)·χ_{x}(A)`), which is clean and
  faithful; but a full faithful re-formalisation of `F_obs` and its bicomplex
  is out of scope here. UC13 §2.3's claim "no cup product appears in the Čech
  bicomplex of `F_obs`" is the remaining paper-side load-bearing assumption,
  and §4.5 shows it is exactly the right thing to check.
- That Y1 — the *vanishing* of the level-1 isotypes (UC10 §5.3 / UC13 §4.5) — is
  sound. Y1 is a separate step with its own soft spots (mg-39bc §5.4) and is
  out of scope. Y2 says only *where* the obstruction lands; Y1 says that place
  is zero. This ticket addresses Y2 (the landing) only.

**Net effect on the mg-39bc risk assessment.** mg-39bc rated Y2 **HIGH RISK**,
with the formalisation-contradiction as the dominant evidence. That evidence is
withdrawn (§5). Y2's risk should be **downgraded**: its mechanism is sound and
machine-checked, and the competing UC11 §5.3 picture is refuted. The residual
Y2 risk is now confined to the faithfulness of the `F_obs` construction
("no cup product"), which is a checkable structural property, not a coin-flip
reversal. Y1 and the overall axiom-dependence of `Frankl_Holds` are unchanged.

---

## §7 — Recommendations

1. **Discard `cechIsotypeProjection` / `UC13_correctedLanding` as a
   "formalization of Y2."** They are answer-steered (§2). They should be
   re-documented as placeholders, not cited as evidence for the landing. The
   honest Y2 content is in `ObstructionIsotypeLanding.lean`.

2. **Correct the `topVertex` / `topVertex_not_coboundary` docstrings.** They
   claim `topVertex` is the `χ_[n] ⊠ sgn` top-isotype generator. Machine-checked,
   it is a single cube vertex (in no isotype) and `topVertex_not_coboundary`
   detects the trivial `χ_∅` isotype at degree 0. The docstrings should say so;
   the current wording is the source of the mg-36c3 mislabelling.

3. **Y2 does not need the multi-week refactor to be *trusted*; it needs it to
   be *formalized*.** This ticket shows Y2's mechanism is sound, so the path-(a)
   Walsh-isotype obstruction refactor — if undertaken — is formalising a true
   statement, not risking multi-week work on a false one (this directly answers
   mg-39bc §6 item 4). The faithful encoding would land `obstructionClass` as
   a genuine level-1 `χ_{x}` class (e.g. `walshVec {x}`-supported), at which
   point `equivariant_preserves_InIsotype` discharges the landing.

4. **Do not upgrade the headline.** Y2-SUPPORTED is a statement about the
   mathematics. `Frankl_Holds` remains axiom-dependent; Y1 remains unaudited;
   the Zulip post remains held. This ticket removes one specific
   false-alarm risk; it does not close the proof.

---

## §8 — Lean theorem index (`UC13_PartA/ObstructionIsotypeLanding.lean`)

| Theorem | Statement |
|---|---|
| `toggleBy_walshVec`, `walshVec_InIsotype` | `walshVec n T` is a genuine `χ_T`-eigenvector / isotypic element. |
| `walshCoeff_toggleBy` | `walshCoeff n T` is `χ_T`-equivariant. |
| `walshCoeff_walshVec_self` | `walshCoeff n T (walshVec n T) = 2ⁿ` (non-zero on its isotype). |
| `walshCoeff_eq_zero_of_InIsotype` | Schur: `walshCoeff n T` annihilates every isotype `≠ χ_T`. |
| `walshChar_sum` | `Σ_A χ_U(A) = if U = ∅ then 2ⁿ else 0` (orthogonality). |
| `single_not_InIsotype` | A single cube vertex is in **no** Walsh isotype. |
| `single_walsh_decomposition` | A single cube vertex `= Σ_T (r·χ_T(A)/2ⁿ)•walshVec T` — non-zero in every isotype. |
| `walshCoeff_empty_eq_augmentation` | The augmentation (`BKAug`'s shape) **is** the trivial-`χ_∅` coefficient. |
| `equivariant_preserves_InIsotype` | **UC13 §2.4.1's mechanism**: equivariant additive maps preserve isotype. |
| `mulWalsh_shifts_isotype` | Multiplication by `χ_U` shifts `χ_T ↦ χ_{T∆U}` — the only level-shifter. |
| `obstruction_cubeVertexRead` | Faithful bridge: `obstructionClass F x` reads to `obstructionVertex F x`. |
| `obstruction_lands_in_every_isotype` | The obstruction has a non-zero component in **every** isotype. |
| `obstruction_not_InIsotype` | The obstruction is in **no** isotype. |
| `obstruction_walsh_decomposition` | The explicit `2ⁿ`-term isotype decomposition of the obstruction. |
| `obstruction_landing_n3_witness`, `obstruction_not_InIsotype_n3` | `n = 3` concrete witnesses. |
| `Y2_obstruction_isotype_verdict` | The four findings of §0.3 bundled as one machine-checked theorem. |

---

## §9 — Cross-references

- **Brief:** `mg-aeee`. **Investigation that filed it:** `mg-39bc`
  (`docs/frankl-axiom-restructure-investigation.md`) — Y1/Y2/Y3 decomposition,
  Y2 HIGH RISK rating (the rating §6 here recommends downgrading).
- **The steered existing Y2 "formalization":**
  `lean/UnionClosed/UC13_PartA/IsotypePreservation.lean` (`cechIsotypeProjection`),
  `lean/UnionClosed/UC13_PartA/CorrectedLanding.lean` (`UC13_correctedLanding`).
- **The genuine `(ℤ/2)ⁿ` Walsh machinery consumed:**
  `lean/UnionClosed/UC10/Walsh.lean` (`walshChar`, `toggleAction`,
  `toggleSupport`, `walshChar_mul`, `walshChar_toggle_eigen`).
- **The obstruction encoding:** `lean/UnionClosed/UC11/ObstructionClass.lean`
  (`obstructionClass`), `lean/UnionClosed/UC11/FObs.lean` (`localBiasCochain`),
  `lean/UnionClosed/UC11/CohomologyClass.lean` (`topVertex_not_coboundary`,
  `BKAug`).
- **mg-36c3 structural-collision analysis:** `docs/state-UC-Lean-per-x-closure.md`
  — real about the non-faithful encoding; §5 here explains it collides with the
  `χ_∅` augmentation, not a top-`χ_[n]` obstruction.
- **Paper sources:** `docs/union-closed-UC11-cech-sheaf-frankl-program.md` §5.3
  (abandoned top-isotype claim), `docs/union-closed-UC13-frankl-closure.md`
  §2.2–2.4 (the corrected level-1 landing = Y2; §2.4's own diagnosis that UC11
  §5.3's "level increment" is wrong — which §4.5 here machine-confirms).

---

*Determination by polecat `cat-mg-aeee`. Deliverables on `main`: this report +
`lean/UnionClosed/UC13_PartA/ObstructionIsotypeLanding.lean` (678 lines, no
`sorry`/`axiom`, `lake build` GREEN). Verdict: **Y2-SUPPORTED** — the landing
mechanism is machine-checked sound and the cited contradiction-evidence is
refuted; with the standing caveat that the current Lean development does not
itself honestly formalize Y2 (its `cechIsotypeProjection` is answer-steered and
its `obstructionClass` encoding is non-faithful).*
