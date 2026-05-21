# Frankl-Vision-Check — does the built Frankl proof match Daniel's original vision?

**Work item:** `mg-6edc` (Frankl-Vision-Check). Per a Daniel reminder
2026-05-21: with the Frankl proof halted (the Y1 cohomological foundations
refuted — `mg-0405` Phase 1.5 RED), check whether the built Frankl proof
matches Daniel's original vision.

**Daniel's original vision (verbatim from the reminder).**

> *"Category of all intersection-closed families, it has spherical
> cohomology, then minimal counterexample differs from these by a factor
> which relates to this cohomology."*

**A second verbatim Daniel directive, on record** (UC10 §8.4, the founding
ticket of the cohomological arc, Daniel 2026-05-16T00:38Z):

> *"for union closed I want a theorem on the cohomology of the category of
> intersection closed families like we did before with the category of
> posets."*

The two are the same vision stated twice. They are read together throughout:
the 2026-05-21 reminder gives the three structural elements; the 2026-05-16
directive fixes the intended *template* — the F-series result that
`Δ(PPF_n)`, the order complex of the **category of posets**, is a rational
homology sphere `≃ S^{n-2}` with `H^{n-2} ≅ sgn_{S_n}`.

**READ-FIRST consumed:** `docs/PROOF-STRUCTURE-ONBOARDING.md`; the
union-closed LaTeX paper (`paper/sections/00`–`07`, the `mg-335b`
deliverable); the UC9/UC10/UC13/UC14 source notes;
`docs/Frankl-Y1-reprove.md` (`mg-56b8`);
`docs/Frankl-Y1-phase1.5-bk-structure-maps.md` (`mg-0405`); the combinatorial
setup `paper/sections/01-setup.tex`; `README.md` ("Intrinsic object").

**Scope.** Paper-and-pencil strategic audit. No Lean change, no new axioms,
no computation. Deliverable: this document. `pm-onethird` relays the verdict
to Daniel; it directly informs the pending `mg-0405` §6 design decision.

---

## §0 — Verdict (top of page)

### 0.1 Headline

> **PARTIAL MATCH WITH STRUCTURAL DRIFT.** The built Frankl proof keeps the
> *shape* of Daniel's three-element vision — there is a category of
> intersection-closed families, a target sphere-concentration theorem, and a
> minimal-counterexample obstruction class in the top cohomological degree —
> but it has **drifted from the vision in three layered, documented ways**,
> and **the `mg-0405` Phase-1.5 RED is a direct consequence of two of those
> three drifts, not of anything intrinsic to the vision.** The vision, read
> as the F-series analog Daniel explicitly named, does **not** require the
> homotopy-colimit-of-a-coefficient-diagram construction whose structure map
> Phase 1.5 refuted, and does **not** require the `(ℤ/2)ⁿ` / Walsh group
> action whose assembly Phase 1.5 refuted. Both refuted objects are build
> additions. The vision indicates a **cleaner foundation than any of the
> three `mg-0405` §6 forks**: re-found on the *category's own* cohomology
> (its nerve / order complex), in the variance and symmetry the F-series
> template actually uses.

### 0.2 The three vision elements, mapped

| Vision element | Built as | Faithful? |
|---|---|---|
| **(1)** Category of *all* intersection-closed families | `𝒞_n^∩`: pointed intersection-closed families, **trace** morphisms only (same-ground-set inclusions deliberately excluded) | **DRIFTED** — wrong morphism class; "all … forming a category" most naturally means the inclusion lattice, which is the literal F-series analog |
| **(2)** It has *spherical* cohomology | `UC10.1` / Conj. `uc10-1`: `H^k(X_n^∩) = sgn` at `k=n-1`, `0` for `1≤k≤n-2` — but the cohomology object `X_n^∩` is the **hocolim of a cubical-Walsh-defect coefficient diagram**, not the cohomology *of the category* | **DRIFTED** — right target (concentration in one degree) but on a different object than "the cohomology of the category"; and the object is currently **undefined** (`mg-0405`) |
| **(3)** Minimal counterexample differs from these *by a factor relating to this cohomology* | The obstruction class `ob(F⋆) ∈ H^{n-1}(X_n^∩)`, forced `≠ 0` by minimality (Fact One) and `= 0` by the sphere concentration (Fact Two) | **ARCHITECTURALLY FAITHFUL, FAITHFULNESS UNVERIFIED** — the class is the "factor", in the sphere degree; but whether it genuinely *relates to the cohomology* (rather than being family-blind) is exactly the open faithfulness risk |

### 0.3 The three drifts, named

- **Drift A — morphism class.** The vision's category (the F-series analog
  of `PPF_n` *ordered by refinement / inclusion*) should have **inclusion /
  refinement** morphisms. UC10 chose **trace** morphisms — UC10 §2.3 itself
  calls this "the most contentious design choice … most likely to be
  challenged", and UC10 §7.2 logged "should `𝒞_n^∩` also include inclusion
  morphisms" as deferred open work.
- **Drift B — the cohomology object.** The vision asks for "the cohomology
  *of the category*" — i.e. its nerve / order complex, the way `Δ(PPF_n)` is
  the order complex of the category of posets. UC10 instead built
  `X_n^∩ = hocolim_{(𝒞_n^∩)^op} X(𝓕)`, the homotopy colimit of a
  **family-indexed coefficient diagram** of cubical-Walsh-defect complexes
  (the explicit "C1 dodge"). This is the cohomology of a *diagram over* the
  category, not the cohomology *of* the category.
- **Drift C — the symmetry group.** The vision's template carries the
  `S_n`-sign (`sgn_{S_n}`, the symmetry of the category). UC10 enlarged the
  group to `Γ_n = (ℤ/2)ⁿ ⋊ S_n` and routed sphericity through a **Walsh
  (`(ℤ/2)ⁿ`) isotype decomposition** (the explicit "C3 dodge").

### 0.4 The Phase-1.5 wall: drift, not intrinsic

`mg-0405` refuted two objects: **(b)** the against-trace structure map
`X(𝓕|_T) → X(𝓕)` does not exist, so the diagram functor whose hocolim is
`X_n^∩` is undefined; **(c)** the `(ℤ/2)ⁿ`-action on `X_n^∩` does not
assemble. **(b) is the failure of Drift B + Drift A; (c) is the failure of
Drift C.** Neither is intrinsic to Daniel's vision: a cohomology *of the
category* (Drift B undone) needs no coefficient-diagram structure map at
all, and a `sgn_{S_n}`-graded sphere (Drift C undone) needs no `(ℤ/2)ⁿ`
action. **The wall is a consequence of the build drifting from the vision.**

### 0.5 What this means for the `mg-0405` §6 fork

The vision **rules out Fork B** (enlarge the indexing to the category of
*all* families, intersection-closed *and* their union-closed flips — this
abandons the vision's clause 1, "intersection-closed families"). It is
**lukewarm on Fork A** (covariant hocolim — fixes the variance but keeps
Drifts B and C, leaves the `(ℤ/2)ⁿ` gap unrepaired). It most strongly
indicates a **fourth option, cleaner than all three**: the "non-UC10 route"
given a definite shape by the vision itself — re-found on the category's own
cohomology, with inclusion/refinement morphisms and the `S_n`-sign,
discharging the Walsh apparatus as a *construction device for the cochain*,
not as a group action on the cohomology object. §6 develops this.

### 0.6 The one caveat that limits the verdict

The cleaner foundation the vision indicates is **not certified viable here.**
The drifts A/B/C were not gratuitous — they were responses to the manifesto
`C1`–`C5` obstacles and the UC9 "U1 wall" (a family-blind, contractible
invariant). The literal vision faces its own open prerequisite: that the
category's intrinsic cohomology is *non-trivial and family-sensitive*. That
prerequisite — clause (3) of the vision, "differs by a factor relating to
this cohomology" — is the genuine mathematical content and is **not free**.
The recommendation (§7) is therefore: settle the viability of the literal
vision *before* choosing among the forks, because if it is viable it
supersedes them, and if it is not, the reason will sharply constrain which
fork can work.

---

## §1 — Method and stance

This is a vision-vs-build comparison, default-skeptical, in the discipline
the `mg-56b8` / `mg-0405` briefs set. The method is:

1. **Unpack the vision** into its three structural elements and fix the
   *template* Daniel named (the F-series cohomology of the category of
   posets). §2.
2. **Map each element** to the as-built development, citing the precise
   construction, and tag each FAITHFUL / DRIFTED with the evidence. §3.
3. **Name the drifts** as a small set of independent design decisions, each
   with its documented rationale, so the drift is diagnosed, not merely
   asserted. §4.
4. **Trace the Phase-1.5 RED** back through the drift map: is each refuted
   object a build addition or a vision necessity? §5.
5. **Read the `mg-0405` §6 fork against the vision.** §6.

Throughout, "the vision" is the conjunction of the two verbatim Daniel
quotes in the header. Where the three-clause reminder is ambiguous, the
2026-05-16 directive ("like we did before with the category of posets") is
the tie-breaker: it pins the template unambiguously.

A note on standing. This audit does not re-open any mathematical verdict.
`Y1` is `RED — open` (`mg-56b8`); the BK structure maps are
`RED — not pinned` (`mg-0405`); UC14 `R2` is FALSE; `Frankl_Holds` rests on
`case3_ss_obstruction_paper_axiom`. None of that changes here. What this
document adds is the *strategic* reading: how far the build is from the
vision, and what the vision says about the repair.

---

## §2 — Daniel's vision, unpacked

### 2.1 The three elements

The reminder has exactly three clauses, in dependency order.

- **(V1) The category.** *"Category of all intersection-closed families."*
  The objects are intersection-closed families; they *form a category*. The
  word "all" is doing work: it is the category of the whole class, not a
  hand-picked subclass with a hand-picked morphism set.

- **(V2) Spherical cohomology.** *"it has spherical cohomology."* The
  subject of "it" is the category. The category — or the canonical
  cohomological object attached to it — carries a **spherical** cohomology:
  concentrated, sphere-like, a single non-zero degree, one-dimensional in
  that degree (a rational homology sphere).

- **(V3) The minimal-counterexample factor.** *"then minimal counterexample
  differs from these by a factor which relates to this cohomology."* "These"
  are the generic (non-counterexample) intersection-closed families. A
  minimal counterexample to Frankl is distinguished from them by a **factor**
  — an extra quantity — and that factor **relates to** the spherical
  cohomology of (V2). The proof exploits that difference for the
  contradiction.

### 2.2 The template Daniel named

The 2026-05-16 directive fixes (V2) precisely: *"like we did before with the
category of posets."* The F-series precedent (UC10 §0.3, UC9 §59):

> `PPF_n` = proper partial orders on `[n]`, **ordered by inclusion
> (refinement)**. `Δ_n = Δ(PPF_n)` is the **order complex of that category**.
> `Δ_n ≃_ℚ S^{n-2}` (rational homology sphere). `H̃^{n-2}(Δ_n;ℚ) ≅ sgn_{S_n}`;
> lower degrees vanish. Symmetry group: `S_n`.

Four template features are load-bearing for this audit, because the build
departs from three of them:

- **(T1)** The category is ordered by **inclusion / refinement**.
- **(T2)** The cohomology is the cohomology of the **order complex of the
  category itself** — its nerve `Δ(PPF_n)`. No coefficient diagram.
- **(T3)** The symmetry group is **`S_n`**; the sphere carries `sgn_{S_n}`.
- **(T4)** The result is **sphere concentration** — one non-zero degree,
  one-dimensional, sign isotype. (The build keeps this one.)

### 2.3 What the vision does *not* say

For the drift assessment it matters what the vision is silent on. The
verbatim vision mentions **no** homotopy colimit, **no** Bousfield–Kan
double complex, **no** cubical-Walsh-defect complex, **no** `(ℤ/2)ⁿ`, **no**
Walsh decomposition, **no** hyperoctahedral group `Γ_n`, **no** trace
functor. Every one of those is a build object. This is not a complaint —
machinery is allowed — but it means that when a build object fails (Phase
1.5), the first question is whether the *vision* needed it, and the verbatim
vision is the place to check.

### 2.4 The README cross-check

`README.md`, "Intrinsic object", independently records the program's prior
expectation: *"The canonical intrinsic object is expected to be the
**inclusion poset** `(F,⊆)` … with order complex `Δ(F)`."* This is the
inclusion-ordered, order-complex picture — (T1)+(T2) — and it predates UC10.
The vision and the program's own founding README agree on the template; UC10
is where the development moved off it.

---

## §3 — Element-by-element: vision vs. build

### 3.1 (V1) The category — **DRIFTED** (morphism class)

**Built as.** `𝒞_n^∩` (UC10 §2, paper Def. `cn-category`): objects are
pointed intersection-closed families `(S,𝓕)` with `S ⊆ [n]`, `⋃𝓕 = S`,
`S ∈ 𝓕`. Morphisms are **trace morphisms** only: `(S,𝓕) → (T,𝓕|_T)` for
`T ⊆ S`, `𝓕|_T = {A∩T : A∈𝓕}`. Same-ground-set inclusions
`(S,𝓕) ↪ (S,𝓕')` are **deliberately excluded** (UC10 §2.3).

**Match.** The objects are faithful: intersection-closed families, the whole
class, with the natural `S_n`-action. Clause (V1) is satisfied at the level
of objects.

**Drift.** The *morphism class* is not the vision's. The template (T1) is
"ordered by inclusion / refinement"; `PPF_n` is the **refinement poset**.
The faithful analog of "the category of posets ordered by refinement" is
"intersection-closed families **ordered by inclusion**" — and that is a
genuine, natural category: intersection-closed families on `[n]` are exactly
the **Moore families / closure systems**, and they form a **lattice** under
inclusion (UC10 §0.1 records this: "the Boolean lattice `2^U` embeds
canonically into the lattice of intersection-closed families on `U`"). UC10
instead picked trace morphisms.

**Why UC10 drifted, and that it knew.** UC10 §2.3 chose traces over
inclusions for two stated reasons — a possible `n`-induction in the
"counterexamples trace to smaller ground sets" direction (the C5 dodge), and
avoiding the doubly-exponential nesting of the inclusion order (a C2
concern). UC10 §2.3 explicitly flags the choice as "the most contentious
design choice in UC10 and the part most likely to be challenged in a future
session"; UC10 §7.2 (UC11 *tertiary*) logged "Should `𝒞_n^∩` also include
inclusion morphisms? … they are the natural Pos analog and deserve a careful
re-examination — possibly leading to a larger category `C̃_n^∩`." The drift
is documented in the source, deferred, and never resolved.

**Verdict on (V1): DRIFTED.** Objects faithful; morphism class is a
contested, self-flagged departure from the F-series template the vision
names. This is **Drift A**.

### 3.2 (V2) Spherical cohomology — **DRIFTED** (the cohomology object)

**Built as.** Two layers.

- *Per family:* `X(𝓕)`, the cubical-Walsh-defect complex (UC10 §3.1, paper
  Def. `cubical-defect-complex`): `k`-cells are the `k`-subcubes of `Q_S`
  all of whose `2^k` vertices lie in `𝓕`.
- *Assembled:* `X_n^∩ := hocolim_{(𝒞_n^∩)^op} X(𝓕)` (UC10 §3.3, paper Def.
  `cubical-defect-complex`), presented by the Bousfield–Kan double complex.

The target theorem is `UC10.1` (paper Conj. `uc10-1`): for `n ≥ 3`,
`H̃^k(X_n^∩;ℚ) ≅ χ_{[n]} ⊠ sgn_{S_n}` at `k = n-1` and `0` for
`1 ≤ k ≤ n-2`. **This *is* spherical cohomology** — concentration in one
degree, one-dimensional, sign isotype. Template feature (T4) is kept.

**Match.** The *target* is faithful to (V2): a rational homology sphere,
single non-zero degree. The program even states it that way — UC10 §3.4:
"`V_{[n]}^* ≃_ℚ S^{n-1}`", "the rational homology sphere of the top Walsh
piece." Clause (V2) is the right target.

**Drift — the object.** The vision (T2) wants "the cohomology *of the
category*": the nerve / order complex of the category itself, the way
`Δ(PPF_n)` *is* `BPPF_n`. The build instead computes the cohomology of a
**coefficient diagram over** the category: `X_n^∩` is the homotopy colimit
of the functor `𝓕 ↦ X(𝓕)`. In homotopy-theoretic terms, `H^*(X_n^∩)` is the
cohomology of the category `𝒞_n^∩` *with coefficients in the
cubical-Walsh-defect local system*, `H^*(𝒞_n^∩; X(−))` — not `H^*(B𝒞_n^∩)`,
the bare cohomology of the category. UC10 §1.2 / §3.1 makes this an explicit
design move, the **"C1 dodge"**: "UC10's cohomology object is *not* an order
complex of `𝓕` or of `𝒞_n^∩` raw."

**Drift — the symmetry.** The vision's template (T3) carries `sgn_{S_n}`.
The build's sphere carries `χ_{[n]} ⊠ sgn_{S_n}` — the **bi-sign of the
hyperoctahedral group `Γ_n = (ℤ/2)ⁿ ⋊ S_n`**. The `(ℤ/2)ⁿ` factor and the
Walsh isotype decomposition it drives are the **"C3 dodge"** (UC10 §1.2,
§3.4–§3.5). The category of intersection-closed families carries `S_n`
natively; it does **not** carry `(ℤ/2)ⁿ` — UC10 §2.4 is explicit: "`σ_x`
does **not** preserve intersection-closure, so `(ℤ/2)ⁿ` does not act on
`𝒞_n^∩`." The `(ℤ/2)ⁿ` is imported from the *ambient cube* `Q_n`, not from
the category.

**Why UC10 drifted, and that it knew.** Both dodges have documented
rationale. C1: the manifesto worried the bare order complex of the family /
the category is "the wrong level" — family-blind or contractible — the same
failure UC9 hit head-on (the "U1 wall": an embedding whose image is
contractible gives a family-independent, useless invariant; paper
§`u1-wall`, Rem. `u1-lesson`). C3: the manifesto argued the obstruction (the
bias) is genuinely Walsh-flavored data, so the load-bearing group "is
`(ℤ/2)ⁿ`/Walsh, not `S_n`/FI". Both are real concerns (§5.4 returns to
them). But both move the build off the template the vision named.

**The compounding fact (`mg-0405`).** `X_n^∩` as written is currently **not
a defined object at all**: the diagram functor `X : (𝒞_n^∩)^op → Ch` whose
hocolim it is does not exist, because its structure map does not exist
(`mg-0405` Prop. 3.5; §5 below). So (V2) is, today, drifted *and* the
drifted object is undefined.

**Verdict on (V2): DRIFTED.** Target faithful (sphere concentration); object
is the cohomology of a coefficient diagram over the category, not of the
category, and is graded by `Γ_n` not `S_n`. This is **Drift B** (the object)
+ **Drift C** (the group).

### 3.3 (V3) The minimal-counterexample factor — **ARCHITECTURALLY FAITHFUL, faithfulness unverified**

**Built as.** Work in the intersection-closed dialect. A minimal
counterexample `F⋆` has `bias_x(F⋆) > 0` for every `x` (no rare coordinate),
minimising `|F⋆|` then `n` (paper Def. `minimal-cex`). The minimality-element
theorem (paper Thm. `minimality-element`): every *proper* trace `F⋆|_T` has a
rare coordinate. These rare-coordinate strata `{U_x}` cover
`𝒞_n^∩(F⋆) ∖ {F⋆}`; the mismatch cochains assemble into the Čech double
complex of the obstruction sheaf `𝔣ₒᵦₛ`, promoting to a class

> `ob(F⋆) ∈ H̃^{n-1}(X_n^∩;ℚ)`.

Fact One (paper Thm. `fact-one`, UC11 Lemmas 6.1–6.2): `ob(F⋆) ≠ 0` — if it
were zero, the local rare-coordinate data would glue to a global section,
giving `F⋆` itself a rare coordinate, contradicting minimality. Fact Two
(paper Prop. `fact-two`): `Y1 ∧ Y2 ⟹ ob(F⋆) = 0`. The collision is the
proof.

**Match.** This is a faithful instantiation of (V3) at the architectural
level:

- The minimal counterexample *is* singled out: `ob(F⋆) ≠ 0` is forced by
  minimality, whereas a generic family has a rare coordinate, its section
  glues, and `ob = 0`. So `F⋆` "differs from these" exactly by the
  obstruction class.
- The "factor" *is* a cohomology class: `ob(F⋆) ∈ H̃^{n-1}(X_n^∩)`.
- It "relates to this cohomology": it lives in degree `n-1` — the **sphere
  degree** of (V2). The whole point of the closing argument (paper
  §`closing`, steps C1–C7) is that the sphere is concentrated so that the
  class `ob(F⋆)` is squeezed into a part that must vanish.

There is even a precise reading of "factor" the build supports literally.
The doubling functor gives `X(db 𝓕) ≅ X(𝓕) × I` — the **matched cylinder**,
a genuine product *with a factor `I`* (paper Def. `doubling`). The matched
subcategory `𝒟_x` makes `X(𝒟_x) ≅ X_{n-1} × I_x` a cylinder; the part of
`X_n^∩` that is *not* this matched cylinder is the **cofiber**
`X_n^∩ / X(𝒟_x)`, and its cohomology is exactly the `Y1` residual (paper
Open residual `res:y1`). Under this reading, "the minimal counterexample
differs from [the matched / generic part] by a factor" maps cleanly: the
matched part is the cylinder (the literal `× I` factor), the *difference* is
the cofiber, and "the factor relates to the cohomology" is the statement
that the cofiber cohomology is what controls sphericity. The build does
realize a factor/cofiber structure.

**Drift — faithfulness is unverified, and at risk.** The vision's clause
(V3) asserts the factor *relates to the cohomology* — i.e. the cohomology
**genuinely sees** the counterexample. The build cannot currently honour
that assertion, and the paper says so plainly:

- *Wrapper risk* (paper Rem. `wrapper-risk`): "The vanishing side of the
  contradiction uses only the shape of the Čech double complex … never the
  counterexample hypothesis. So, if the vanishing argument is correct,
  `ob(F)` is identically zero for *every* family, and all the
  Frankl-specific content is carried by Fact One." If `ob` is
  family-independent, the cohomology does **not** "see" the counterexample —
  the detection collapses into the combinatorial wrapper (the UC11 Lemma 6.1
  equivalence "`ob = 0 ⟺` a global rare-coordinate section exists", itself
  "close to a restatement of Frankl"). That is the **negation** of clause
  (V3).
- *Axiom-is-Frankl* (paper Prop. `axiom-is-frankl`): in the Lean build the
  homological half is the axiom `case3_ss_obstruction_paper_axiom`, which —
  given the proved Fact One — is *propositionally equivalent to Frankl
  itself*. The "factor" there is not a genuine cohomological quantity; it is
  Frankl in disguise.

So (V3) is **architecturally faithful** — the build has a class, in the
sphere degree, distinguishing `F⋆` — but the **faithfulness clause of the
vision is exactly the program's central open risk.** The vision *asserts*
the cohomology relates to the counterexample; the build has not established
it and has a concrete failure mode (family-blindness) in which it does not.

**Verdict on (V3): architecturally faithful; the vision's substantive claim
(the factor *relates to* the cohomology) is unverified and at risk.** This
is not a separate drift so much as the place where Drifts A/B/C come home to
roost: a cohomology object that is not the category's own (Drift B) and a
class whose home group is imported (Drift C) is exactly the kind of object
whose family-sensitivity has to be *proved*, not assumed — and that proof is
the open `Y1` residual.

---

## §4 — The drift assessment

### 4.1 The drift is three independent design decisions

The build is not vaguely "off"; it drifted at three identifiable, mutually
independent decision points, each a manifesto-`C`-dodge with a recorded
rationale.

| | Drift | Vision / template says | Build chose | Documented rationale | Self-flagged? |
|---|---|---|---|---|---|
| **A** | Morphism class | inclusion / refinement (T1) | trace morphisms | C5 (induction direction), C2 (nesting) | Yes — UC10 §2.3, §7.2 |
| **B** | Cohomology object | cohomology *of the category*, its order complex (T2) | hocolim of a cubical-Walsh-defect coefficient diagram | C1 (bare order complex "wrong level" / family-blind) | Yes — UC10 §1.2 "C1 dodge" |
| **C** | Symmetry group | `S_n`, sphere graded `sgn_{S_n}` (T3) | `Γ_n = (ℤ/2)ⁿ ⋊ S_n`, Walsh isotypes | C3 (obstruction is Walsh-flavored) | Yes — UC10 §1.2 "C3 dodge" |

Three observations.

1. **All three drifts are documented in the source.** UC10 did not drift
   silently; it logged each dodge against its `C`-tag and even flagged Drift
   A as its most contestable choice. This audit is, in part, the
   re-examination UC10 §7.2 itself asked for.

2. **The drifts were motivated, not gratuitous.** Each dodges a real
   manifesto obstacle. The honest reading is *not* "UC10 ignored the
   vision"; it is "UC10 believed the literal vision could not survive
   `C1`–`C5` and engineered around them." Whether that belief was correct is
   the §5.4 / §7 question.

3. **The drifts compound.** Drift A (trace morphisms) + Drift B (hocolim of
   a coefficient diagram) together *create* the need for a trace-induced
   structure map between coefficient complexes — the object Phase 1.5
   refuted. Drift C (import `(ℤ/2)ⁿ`) *creates* the need for that imported
   group to act on the hocolim — the object Phase 1.5 also refuted. The wall
   is the compound of the drifts (§5).

### 4.2 Where the build *is* faithful

To keep the assessment honest, the faithful parts:

- **The objects of the category** are exactly intersection-closed families,
  the whole class, with the `S_n`-action. (V1) at object level: faithful.
- **The target is genuine sphere concentration** — one non-zero degree,
  one-dimensional, sign isotype. (V2) target / (T4): faithful. The program
  states it as a rational homology sphere (UC10 §3.4).
- **The closing architecture is a two-part contradiction on a single class
  in the top degree** — must-be-nonzero (minimality) vs. must-be-zero
  (sphere concentration). (V3) architecture: faithful. This is a clean,
  recognisable instantiation of "the counterexample is detected by a class
  in the spherical cohomology."
- **One unconditional theorem is real** — trace-injectivity / the
  matched-cylinder null-homotopy (paper Thm. `trace-injectivity`, UC12).
  It carries the "factor" structure (`X(db 𝓕) ≅ X(𝓕) × I`) honestly and is
  `sorry`-free in Lean.

The drift is in *how the category is presented*, *what object carries the
cohomology*, and *which group grades it* — not in the high-level shape. The
vision's silhouette is intact; the construction underneath it is not the
one the template prescribes.

### 4.3 The drift restated in one sentence

> The build kept the vision's **silhouette** (a category of
> intersection-closed families; a sphere-concentrated cohomology; a
> top-degree class detecting the minimal counterexample) but replaced the
> vision's **construction** (the order complex of the category, `S_n`-graded
> — the F-series analog) with a different one (a homotopy colimit of a
> cubical-Walsh-defect coefficient diagram, `Γ_n`-graded), and it is the
> replacement construction, not the silhouette, that Phase 1.5 refuted.

---

## §5 — Is the Phase-1.5 wall drift, or intrinsic to the vision?

### 5.1 What `mg-0405` refuted

Phase 1.5 returned **RED — BK-STRUCTURE-MAPS-NOT-PINNED**, with two
findings:

- **(b) The against-trace structure map does not exist.** For the hocolim
  `X_n^∩ = hocolim_{(𝒞_n^∩)^op} X(𝓕)` to be defined, the diagram functor
  `X : (𝒞_n^∩)^op → Ch` must supply, for each trace `(S,𝓕) → (T,𝓕|_T)`, a
  chain map `X(𝓕|_T) → X(𝓕)` (against the trace). `mg-0405` Example 3.4
  (an explicit object of `𝒞_4^∩`) and Prop. 3.5 show **no such canonical
  chain map exists** — the source complex can be a solid square while the
  target is four isolated points. The diagram functor, hence `X_n^∩` as
  written, is **undefined**. What *does* exist canonically is the
  **projection** `π_T : X(𝓕) → X(𝓕|_T)` (the trace direction), making `X` a
  *covariant* functor `𝒞_n^∩ → Ch`.

- **(c) The `(ℤ/2)ⁿ`-action does not assemble.** `(ℤ/2)ⁿ` acts on neither
  the indexing category `𝒞_n^∩` (`σ_y` breaks intersection-closure) nor the
  diagram values (`σ_y X(𝓕) = X(σ_y𝓕)` with `σ_y𝓕` union-closed, outside
  `𝒞_n^∩`). UC10 Lemma 3.6's "standard for `G`-categories" argument has its
  hypothesis absent for the `(ℤ/2)ⁿ` factor. The single-family operators
  `s_y` are not cochain maps and their eigenspaces do not span. The Walsh
  decomposition `UC10.W` is **not constructed** at the level it is used.

### 5.2 (b) is the failure of Drift A + Drift B

The against-trace structure map is needed **only because** the build (i)
made the cohomology object a hocolim of a *coefficient diagram* (Drift B)
and (ii) indexed that diagram by *trace* morphisms with the BK convention
"cochain value at the last object" (Drift A + the BK variance). Remove
either drift and (b) does not arise:

- **If Drift B is undone** — the cohomology object is the **order complex of
  the category itself** (the template T2) — there is **no coefficient
  diagram and no structure map at all.** A nerve / order complex is built
  directly from chains of morphisms; it has no "value functor" to equip with
  trace-induced maps. The entire category of object (b) lives in evaporates.
  `mg-0405` itself notes this: §5.3, "there is nothing yet to formalise,
  because the diagram functor itself is undefined" — the diagram functor is
  a Drift-B artifact.
- **If Drift A is undone** — morphisms are inclusions / refinements (T1) —
  the structure map between coefficient complexes runs *along* inclusions
  and is the honest inclusion of subcomplexes, in the variance a hocolim
  wants; the pathology of Example 3.4 (a trace that drops dimension from 2
  to 0) is a *trace* pathology.
- Even staying inside Drift A + B, `mg-0405` §3.6–§3.7 shows the *projection*
  `π_T` exists and is canonical — the build simply chose the wrong variance.
  That is `mg-0405` Fork A.

**Conclusion: (b) is build drift.** It is intrinsic to "hocolim of a
trace-indexed coefficient diagram in the against-trace BK variance." It is
**not** intrinsic to "the category of intersection-closed families has
spherical cohomology" — the vision is variance-agnostic and, read as the
template prescribes, has no coefficient diagram to give a structure map to.

### 5.3 (c) is the failure of Drift C

The `(ℤ/2)ⁿ`-action is needed **only because** the build chose to *prove*
sphericity by a **Walsh isotype decomposition** (Drift C, the C3 dodge):
Maschke-split `C^*(X_n^∩)` under `(ℤ/2)ⁿ`, show only the top isotype
survives. That route *requires* `(ℤ/2)ⁿ` to act on the cohomology object.
It does not (`mg-0405` §4.5) — and it *cannot*, for the structural reason
UC10 §2.4 already stated: `(ℤ/2)ⁿ` does not preserve intersection-closure.

But the vision's template (T3) needs **no `(ℤ/2)ⁿ` at all.** `Δ(PPF_n)` is
a sphere with `sgn_{S_n}`; the F-series proves concentration with cofiber
Morse + induction over the `S_n`-equivariant structure — no `(ℤ/2)ⁿ`, no
Walsh. The category of intersection-closed families carries `S_n` natively.
A `sgn_{S_n}`-graded spherical cohomology is exactly the template, and it
needs only the group the category actually has.

There is a real subtlety, and it must be stated precisely. The `(ℤ/2)ⁿ`
appears in the program in **two distinct roles**:

- **Role 1 — group action on the cohomology object,** so the cochains can be
  Maschke-split into Walsh isotypes. This is the C3 dodge. **This is what
  `mg-0405` (c) refutes.** It is a build choice and it fails.
- **Role 2 — harmonic analysis of the family indicator.** The bias is, up to
  sign, the level-1 Walsh–Fourier coefficient of `𝟙_𝓕`: `bias_x =
  -2^n χ̂_{𝟙_𝓕}({x})` (paper Prop. `four-forms`, form O3). This is just
  Fourier analysis on the cube `2^[n]`; it is genuine, intrinsic, and **does
  not require `(ℤ/2)ⁿ` to act on `X_n^∩`.**

Role 2 is real and is *not* a drift — it is the honest statement that the
obstruction data is built from level-1 Walsh coefficients. Role 1 — needing
`(ℤ/2)ⁿ` to act on the cohomology object — is the C3 dodge, and it is what
the vision does not ask for and what Phase 1.5 refutes. The build conflated
the two: because the obstruction *data* is Walsh-flavored (Role 2, true) it
concluded the *cohomology object* must carry a `(ℤ/2)ⁿ` action it can be
split by (Role 1, false).

**Conclusion: (c) is build drift.** It is intrinsic to the choice to route
sphericity through a Walsh decomposition (Drift C). It is **not** intrinsic
to the vision: a `sgn_{S_n}`-graded sphere — the literal template — needs no
`(ℤ/2)ⁿ` action on the cohomology object, and the genuine Walsh content
(Role 2, the bias is a Fourier coefficient) survives untouched.

### 5.4 The honest counter-consideration

The above would be too clean if it did not state the case *for* the drift.
The drifts B and C were responses to obstacles that are real:

- **The C1 / U1-wall obstacle is genuine.** UC9 tried exactly the
  intrinsic-cohomology route by *embedding* — and hit the U1 wall: the
  embedded image is contractible, the invariant family-independent, useless
  (paper §`u1-wall`). The worry behind Drift B is that the *bare* order
  complex of the category is likewise trivial — e.g. if the trace category
  `𝒞_n^∩` has an initial or terminal object (everything traces down to
  small families), its nerve is **contractible** and its intrinsic
  cohomology is `0`. If so, a coefficient diagram (Drift B) is *forced* —
  you need a non-constant local system to get any content.
- **The C3 obstacle has a kernel of truth.** The obstruction genuinely is
  level-1 Walsh data (Role 2). A development that drops Walsh entirely must
  still explain where the obstruction class lives and why it has the level-1
  character `Y2` needs.

So the drift is not proof of error. It is proof that the build **chose not
to trust the literal vision** and engineered around it. The decisive
question — and it is genuinely open — is whether the literal vision
*survives* C1 / the U1 wall. §6 and §7 turn this into a concrete
recommendation rather than leaving it as a hedge.

### 5.5 Net answer to question 2

> **The Phase-1.5 wall is a consequence of drift FROM the vision.** Both
> refuted objects are build additions: (b) is intrinsic to the
> hocolim-of-a-trace-indexed-coefficient-diagram construction (Drifts A+B),
> (c) is intrinsic to the Walsh-decomposition route to sphericity (Drift C).
> Neither is intrinsic to "the category of intersection-closed families has
> spherical cohomology", read as the F-series analog Daniel named: that
> reading has no coefficient-diagram structure map to refute and no
> `(ℤ/2)ⁿ` action to fail. **However** — the drifts were motivated by the
> genuine `C1` / U1-wall obstacle, and the literal vision's own viability
> (that the category's intrinsic cohomology is non-trivial and
> family-sensitive) is unproven. The wall is not the vision's fault, but
> removing it requires confronting the obstacle the drift was invented to
> dodge.

---

## §6 — The `mg-0405` §6 fork: what the vision indicates

### 6.1 The three forks on the table

`mg-0405` §6 routed a design decision to Daniel:

- **Fork A — covariant hocolim.** Define
  `X_n^∩ := hocolim_{𝒞_n^∩} X(𝓕)` with the pinned **projections** `π_T` as
  structure maps (a genuinely defined object). Fixes the variance defect
  (b). **Does not fix (c)** — `mg-0405` §6 states the `(ℤ/2)ⁿ` block "is
  independent of the variance block and is not solved by Fork A."
- **Fork B — enlarge the indexing so `(ℤ/2)ⁿ` acts.** Index over the
  category of *all* families — intersection-closed *and* their union-closed
  flips — or realise `X_n^∩` as a defect subobject of the genuinely
  `Γ_n`-equivariant cubical complex of `Q_n`. Fixes (c); changes what
  `X_n^∩` is.
- **Non-UC10 route.** Re-approach `Y1` / the cohomological closure by a
  different route entirely.

### 6.2 The vision rules out Fork B

Fork B's defining move is to **leave the world of intersection-closed
families**: it indexes over a category that includes the union-closed flips,
specifically *so that* `(ℤ/2)ⁿ` (which carries intersection-closed to
union-closed) can act. This directly contradicts vision clause (V1),
"category of **intersection-closed** families", and the 2026-05-16 directive,
"the category of **intersection closed** families." Fork B buys the
`(ℤ/2)ⁿ`-action by paying the one price the vision forbids. **The vision
argues against Fork B.**

(Note this is also the deepest of the three repairs — `mg-0405` §4.5 calls
the `(ℤ/2)ⁿ` gap "deeper than the (b) block." Fork B is the most expensive
fork *and* the one furthest from the vision. That alignment is not a
coincidence: the `(ℤ/2)ⁿ`-action is hard to get precisely because it is
foreign to the category the vision names.)

### 6.3 The vision is lukewarm on Fork A

Fork A produces a *defined* object — `hocolim_{𝒞_n^∩} X(𝓕)` via the
projections — and that is a genuine improvement: `mg-0405` §3.6 pins `π_T`,
and the covariant hocolim is honestly "the cohomology of the category with
coefficients in the cubical-defect diagram", `H^*(𝒞_n^∩; X(−))`. That is
closer to "the cohomology of the category" than the broken contravariant
object.

But Fork A **keeps Drift B** (the cubical-defect *coefficient diagram*
rather than the category's own cohomology) and **keeps Drift C** (it is
still phrased to feed a Walsh decomposition, and `mg-0405` is explicit it
"does not solve" the `(ℤ/2)ⁿ` gap). Fork A is a *variance patch*: it makes
the object exist, but it leaves the build two drifts away from the vision
and leaves (c) open. Realistically, **Fork A must be done together with
Fork B** to close the cohomological route as currently architected — and
Fork B is ruled out (§6.2). So Fork A, alone, is a stopgap, not a
foundation.

### 6.4 The vision indicates a fourth option — a disciplined "non-UC10 route"

The vision most strongly indicates the third bullet — "a non-UC10 route" —
and, crucially, **gives it a definite shape** rather than leaving it
open-ended. The shape is: undo the drifts, re-found on the template.

> **Fork D (vision-indicated) — the category's own cohomology.** Take the
> category of intersection-closed families with **inclusion / refinement**
> morphisms (undo Drift A — the Moore-family order, the literal `PPF_n`
> analog). Take its **order complex / nerve** as the cohomology object (undo
> Drift B — no coefficient diagram, no structure maps, hence no object (b)
> to refute). Grade the target sphere by **`sgn_{S_n}`** (undo Drift C — no
> `(ℤ/2)ⁿ` action on the cohomology object, hence no object (c) to fail);
> retain Walsh **only** in Role 2, as the harmonic description of the
> obstruction *cochain*, not as a group action to Maschke-split by. Prove
> sphere concentration by the F-series method (cofiber Morse + induction)
> that the template already supplies and that UC14 `R3` is a (soft-spotted
> but method-sound) port of.

Fork D dodges **both** Phase-1.5 refutations *by construction*: (b)
evaporates with the coefficient diagram, (c) evaporates with the `(ℤ/2)ⁿ`
requirement. It is the only option on the table that does so. And it is the
only option faithful to all three vision clauses simultaneously.

### 6.5 Fork D's own open prerequisite — stated honestly

Fork D is not free, and this audit will not pretend it is. Its viability
rests on a prerequisite the build's Drift B was invented to dodge:

> **(D-prereq)** The category of intersection-closed families, with its own
> cohomology (nerve / order complex), must be **non-trivial and
> family-sensitive** — its cohomology must genuinely *see* a counterexample
> (vision clause V3), not be contractible or family-independent (the U1
> wall).

This is exactly clause (V3) of the vision turned into a checkable
prerequisite — and it is exactly the program's deepest open risk (paper
Rem. `wrapper-risk`; §3.3 above). Two facts make (D-prereq) *plausible* but
not certain:

- **For** Fork D: the **inclusion** order on intersection-closed families is
  a genuine lattice (Moore families), and lattices routinely have
  non-contractible, even spherical, order complexes (the partition lattice,
  the Boolean lattice). The *punctured Boolean cube* `2^[n] ∖ {∅,[n]}` —
  itself the maximal intersection-closed family — has order complex
  `≃ S^{n-2}` already (UC9 §D-4); a sphere is *natively present* in the
  inclusion picture. The trace category, by contrast, plausibly *is*
  contractible (everything traces to small families) — which is precisely
  why Drift A (trace morphisms) made Drift B (coefficient diagram)
  *necessary*. Undoing Drift A may make Drift B unnecessary.
- **Against** Fork D: UC9's U1 wall is a standing warning that intrinsic /
  embedding routes can be family-blind. (D-prereq) is not automatic.

The honest status of Fork D: **it is the foundation the vision indicates,
it provably dodges the Phase-1.5 wall, and its one open prerequisite is the
genuine mathematical content of the vision itself.** That is a far better
position than Forks A/B, which carry the same content-risk *plus* the
structural defects.

### 6.6 Net answer to question 3

> **Daniel's vision indicates a cleaner foundation than any of the three
> `mg-0405` §6 forks.** It rules out **Fork B** (which abandons
> "intersection-closed" to buy the `(ℤ/2)ⁿ`-action). It treats **Fork A** as
> at best a variance stopgap that leaves two drifts and the (c) gap
> standing. It points at **Fork D**: re-found on the *category's own*
> cohomology — inclusion/refinement morphisms, the order complex as the
> cohomology object, `sgn_{S_n}` grading, Walsh retained only as the
> harmonic description of the cochain. Fork D dodges *both* Phase-1.5
> refutations by construction. Its single open prerequisite — that the
> category's intrinsic cohomology is family-sensitive — is clause (V3) of
> the vision itself, and is the work that genuinely has to be done.

---

## §7 — Verdict, recommendations, cross-references

### 7.1 Verdict

**PARTIAL MATCH WITH STRUCTURAL DRIFT.** The built Frankl proof keeps the
silhouette of Daniel's three-element vision but drifted from it at three
documented, motivated, mutually independent decision points: the morphism
class (trace, not inclusion/refinement — Drift A), the cohomology object
(hocolim of a cubical-Walsh-defect coefficient diagram, not the category's
own cohomology — Drift B), and the symmetry group (`Γ_n = (ℤ/2)ⁿ ⋊ S_n`,
not `S_n` — Drift C). The `mg-0405` Phase-1.5 RED is the compound failure of
those drifts: the refuted against-trace structure map is intrinsic to
Drifts A+B, the refuted `(ℤ/2)ⁿ`-action is intrinsic to Drift C, and
**neither is intrinsic to the vision** read as the F-series analog Daniel
named. The vision indicates a foundation — Fork D, the category's own
cohomology in the template's variance and symmetry — cleaner than all three
`mg-0405` §6 forks, and provably free of the Phase-1.5 wall. Its one open
prerequisite is the vision's own substantive claim (V3): that the cohomology
genuinely detects the counterexample.

### 7.2 The three-element scorecard

- **(V1) Category of intersection-closed families** — objects faithful;
  **morphism class DRIFTED** (trace vs. inclusion). Self-flagged by UC10.
- **(V2) Spherical cohomology** — target faithful (sphere concentration);
  **object DRIFTED** (coefficient-diagram hocolim vs. the category's own
  cohomology) and **currently undefined** (`mg-0405`); **grading DRIFTED**
  (`Γ_n` vs. `S_n`).
- **(V3) Minimal-counterexample factor** — **architecturally faithful**
  (a top-degree obstruction class detecting `F⋆`); **the vision's
  substantive claim** — that the factor *relates to* the cohomology —
  **is unverified and at risk** (family-blindness / the wrapper risk /
  axiom-is-Frankl).

### 7.3 Recommendations (routed to Daniel via `pm-onethird`)

1. **Decide the `mg-0405` §6 fork as a choice between Fork D and Fork A — and
   not Fork B.** Fork B abandons the vision's clause (V1); it is the most
   expensive repair and the least faithful. It should be taken off the
   table unless Daniel explicitly wishes to leave the intersection-closed
   world.

2. **Before committing to a fork, settle the prior question Fork D turns
   on:** is the category of intersection-closed families *under inclusion*
   (the Moore-family lattice, or a suitable proper part of it) genuinely
   non-trivial — does its order complex have spherical, family-sensitive
   cohomology? This is a bounded paper-and-pencil probe (start at `n = 3`,
   compute the order complex of intersection-closed families on `[3]` under
   inclusion, with the `S_n`-action). If **yes**, Fork D is the foundation
   and it supersedes Forks A/B entirely. If **no** (the intrinsic cohomology
   is contractible or family-blind — the C1 / U1-wall obstacle realised),
   that result sharply explains *why* Drift B was needed and changes the
   calculus — at which point Fork A (covariant hocolim) becomes the
   live option, with the understanding that it still owes a separate
   resolution of (c).

3. **Treat the `(ℤ/2)ⁿ` / Walsh question explicitly.** The audit's finding
   is that `(ℤ/2)ⁿ` is genuine *only* in Role 2 (the bias is a level-1
   Walsh–Fourier coefficient of the family indicator) and a build artifact
   in Role 1 (a group action on the cohomology object, to Maschke-split).
   Any re-foundation should keep Role 2 and drop the Role-1 requirement; the
   sphere should be graded by `sgn_{S_n}`, the symmetry the category
   actually has. This alone removes the entire `mg-0405` (c) block.

4. **Re-frame `Y1` accordingly.** `Y1` (lower-Walsh vanishing) is a
   Drift-C-shaped statement — it is phrased in Walsh isotypes `V_S^k`. Under
   Fork D it should be re-derived as ordinary degree-wise vanishing of the
   category's intrinsic cohomology below the sphere degree — the literal
   F-series "lower degrees vanish for `1 ≤ k < n-2`" — for which UC14 `R3`'s
   cofiber-LES + induction is the method-sound template. The `mg-56b8`
   cofiber-LES reduction is variance-dependent (it speaks about `X_n^∩`,
   undefined as written) and should be re-derived once the fork is fixed.

5. **The vision's clause (V3) is the real theorem.** Whatever fork is
   chosen, "the minimal counterexample differs by a factor relating to the
   cohomology" is the assertion that the cohomology is *faithful* — that it
   genuinely sees the counterexample. The paper's `wrapper-risk` and
   `axiom-is-Frankl` findings show the build has not established this and
   has a concrete failure mode in which it is false. No re-foundation closes
   Frankl until (V3) is genuinely proved, not assumed. This is the same
   difficulty as the `Y1` residual and the UC11 Lemma 6.1 faithfulness
   check; the vision-check confirms it is *the* difficulty, not an
   incidental one.

6. **Do not Lean-formalise, do not unhold the Zulip post.** Unchanged from
   `mg-56b8` / `mg-0405`. There is no defined cohomology object to formalise
   until the fork is decided; `Frankl_Holds`'s dependence on
   `case3_ss_obstruction_paper_axiom` stands.

### 7.4 The honest one-paragraph verdict

The built Frankl proof matches the *shape* of Daniel's vision — a category
of intersection-closed families, a sphere-concentrated cohomology, a
top-degree obstruction class detecting the minimal counterexample — but
UC10 drifted from the vision's *construction* at three documented decision
points (trace instead of inclusion morphisms; a homotopy colimit of a
cubical-Walsh-defect coefficient diagram instead of the category's own
cohomology; the hyperoctahedral group `Γ_n` and a Walsh decomposition
instead of `S_n`), each a deliberate dodge of a manifesto `C`-obstacle; the
`mg-0405` Phase-1.5 RED is the compound failure of those drifts and not of
anything intrinsic to the vision, because the vision — read as the
F-series analog Daniel explicitly named ("the cohomology of the category of
intersection-closed families like we did before with the category of
posets") — has no coefficient-diagram structure map to refute and needs no
`(ℤ/2)ⁿ` action on its cohomology object; the vision therefore indicates a
foundation cleaner than any of the three `mg-0405` §6 forks (it rules out
Fork B, which abandons intersection-closure; it treats Fork A as a variance
stopgap; it points at Fork D — re-found on the category's own cohomology,
inclusion morphisms, `sgn_{S_n}` grading), and the one open prerequisite of
that cleaner foundation is the vision's own clause (V3), that the cohomology
genuinely detects the counterexample, which is the real Frankl theorem and
is not free.

### 7.5 Cross-references

- **Brief:** `mg-6edc`. **Routes to:** the pending Daniel decision on
  `mg-0405` §6.
- **The Phase-1.5 RED:** `docs/Frankl-Y1-phase1.5-bk-structure-maps.md`
  (`mg-0405`) — the refutation of the against-trace structure map (§3) and
  the `(ℤ/2)ⁿ`-action (§4); the §6 fork.
- **The Y1 reduction:** `docs/Frankl-Y1-reprove.md` (`mg-56b8`) — the valid
  cofiber-LES reduction; UC14 `R2` re-banded FALSE.
- **The paper:** `paper/sections/` — `00` (status summary), `01`
  (setup, the four obstruction forms, Walsh), `03` (UC9 U1 wall, UC10
  category + `X_n^∩` + `UC10.1`, UC12 trace-injectivity), `04` (the Čech
  obstruction, the two-part contradiction, `wrapper-risk`), `05` (the audit,
  `Y1` open, `axiom-is-Frankl`), `06` (the named residuals).
- **The source notes:** `docs/union-closed-UC9-...md` (the extrinsic
  embedding, the U1 wall); `docs/union-closed-UC10-...md` (the native
  cohomology build — §1.2 the C1–C5 dodges, §2.3 the contested morphism
  choice, §3 `X_n^∩`, §4.1 `UC10.1`, §7.2 the deferred inclusion-morphism
  question, §8.4 the verbatim 2026-05-16 Daniel directive);
  `docs/union-closed-UC13-...md`, `docs/union-closed-UC14-...md`.
- **Onboarding:** `docs/PROOF-STRUCTURE-ONBOARDING.md`.
- **README:** the "Intrinsic object" section — the program's own founding
  expectation of the inclusion poset + order complex.

---

*Vision-check by polecat `cat-mg-6edc`. Deliverable on `main`: this
document. Verdict: **PARTIAL MATCH WITH STRUCTURAL DRIFT** — the build keeps
the vision's silhouette but drifted at three documented decision points
(morphism class, cohomology object, symmetry group); the `mg-0405`
Phase-1.5 RED is the compound failure of those drifts, not of the vision;
the vision indicates a foundation (Fork D — the category's own cohomology,
inclusion morphisms, `sgn_{S_n}`) cleaner than any of the three `mg-0405`
§6 forks and provably free of the Phase-1.5 wall, whose single open
prerequisite is the vision's own clause (V3). Recommended next: Daniel
decides the fork — rule out Fork B, probe Fork D's viability at `n = 3`
before committing.*
