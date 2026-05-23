# Frankl-NonNatural-Cochain-Probe — non-F-natural IE construction evades the CE-shape symmetry-vanishing

**Work item:** `mg-e1e2` (Frankl-NonNatural-Cochain-Probe). Per Daniel's
reminder 2026-05-23T05:37Z:

> *"now that we have a specific frankl obstruction let us try out a few
> different things and see if any help."*

This polecat tests one of the bypass angles flagged explicitly by
`mg-e466` (`docs/Frankl-IE-Induction-Probe.md` §4.2):

> *"A NON-F-natural construction. A cochain whose dependence on F is
> not through a function of F's Aut(F)-orbit type might evade the
> symmetry-vanishing argument. Examples of such non-natural data: a
> choice of total ordering on `[n]`, a marking of one element as 'the
> rare witness candidate,' a generic basis chosen relative to F."*

**READ-FIRST consumed:** `docs/Frankl-Vision.md` (the canonical
vision); `docs/Frankl-IE-Induction-Probe.md` (the `mg-e466` deliverable
this builds on); `docs/Frankl-Cohomology-Synthesis.md` (`mg-5cc6`).

**Deliverable:** this document + the self-contained probe script
`docs/frankl-nonnatural-cochain-probe.py` and its raw output
`docs/frankl-nonnatural-cochain-probe.out`.

---

## §0 — Verdict (top of page)

### 0.1 Headline

> **NON-NATURAL WORKS at n=3 on all 12 CE-shape families.** The
> structural escape `mg-e466` flagged is real: non-F-natural cochain
> constructions parameterised by extra data `d` (marked element,
> ordering, external family) can produce non-zero
> `sgn_{S_n}`-isotype cohomology classes in
> `H^{n-2}(2^[n] \ {∅,[n]}; ℚ) ≅ sgn_{S_n}` even on
> counterexample-shape F⋆, including the fully `S_3`-symmetric
> families that no F-natural construction can escape.
>
> The most powerful construction is **`order_sgn_pair`**:
>
>   `c_F^π(σ_0 ⊊ σ_1) := m_F(σ_1) · sgn(π-rank(added) − π-rank(σ_0))`
>
> where `π ∈ S_n` is a chosen total ordering of `[n]` and
> `added = σ_1 ∖ σ_0`. This is 12/12 non-zero across the CE-shape
> families at n=3.
>
> **But the vision-level consequence is subtle**: the induced class
> depends on the non-natural data `d`, so it is **not canonical**.
> Averaging over `d` (to restore canonicity) reintroduces F-natural
> symmetry and kills the class. Vision-step 4's "separate result
> contradicting the class" needs a *canonical* class to contradict;
> a non-canonical multi-class indexed by `d` does not obviously give
> Daniel's contradiction-machinery a target.
>
> Forward action per ticket: file n=4 confirmation + start
> vision-stage-3 (separate-category-result). Flag the canonicity
> obstacle as a **vision-modification candidate** for Daniel input.

### 0.2 The vision, scored (relative to `mg-e466`'s scorecard)

| Vision step | `mg-e466` (F-natural) | `mg-e1e2` (non-F-natural) |
|---|---|---|
| (1) F⋆ exists in concrete form | YES (12 at n=3, 582 at n=4) | YES — unchanged |
| (2) IE construction applied to F⋆ | YES via OP-A LIFT-4-prod | YES via OP-A + non-natural data `d` |
| (3a) Induced class non-trivial on SOME F | YES (24/61 Moore, 48/113 UC at n=3) | YES (per `mg-e466`) |
| (3b) Induced class non-trivial **on F⋆** | **NO** (0/12 at n=3, 84/582 at n=4) | **YES (12/12 at n=3)** via order_sgn_pair |
| (3+) Class is **canonical** | (Class is F-natural by construction) | **NO** — depends on choice of `d` |
| (4) Separate vanishing contradicts | MOOT (no step-3 class on F⋆) | PARTIAL — class exists but not canonical; vision-step 4 mechanism needs reformulation |

### 0.3 The escape mechanism, in one line

> **Aut(F) ⊆ S_n forces F-natural cochains into the aut(F)-equivariant
> isotype. The sgn-component of an aut(F)-equivariant cochain
> vanishes whenever aut(F) contains a transposition. Non-natural data
> `d` with trivial S_n-stabilizer (e.g., a chosen ordering π ∈ S_n)
> sits OUTSIDE aut(F)'s equivariance, providing a sgn-twist factor
> that pairs against F's class function to extract a non-zero
> sgn-component.**

The unevenness across non-natural data types matches the size of
their S_n-stabilisers:

| Non-natural data `d` | Stab(`d`) ⊆ S_n | Escape behaviour |
|---|---|---|
| Marked element `x ∈ [n]` | `S_{n-1}` (contains transpositions) | Escapes only Z_2-symmetric F⋆ (9/12 via `mark_top_only`); STUCK on fully S_3-symmetric F⋆ |
| External family `F_0 ⊆ 2^[n]` | Aut(F_0) | Escapes 11/12 via `ext_symdiff`; STUCK on a F⋆ that's S_3-symmetric exactly when no chosen F_0 has small enough aut |
| Ordering `π ∈ S_n` | `{id}` (trivial) | Escapes 12/12 via `order_sgn_pair` |

---

## §1 — Operationalisation

The setting is identical to `mg-e466` §1:

- `[n]` is the ground set; `2^[n]` the Boolean lattice.
- The "host" cohomology is the punctured Boolean order complex
  `2^[n] \ {∅, [n]}`, homotopy-equivalent to `S^{n-2}`, with
  `H̃^{n-2} ≅ sgn_{S_n}` carrying the only non-trivial top-degree class.
- An "F-Möbius-IE" cochain is a top-dimensional cochain
  `c_F : top-chains → ℚ` whose dependence on F factors through the
  Möbius transform `m_F` (or `χ_F`).
- The sgn-class of `c_F` is the image of `c_F` in
  `H̃^{n-2}(2^[n] \ {∅,[n]}; ℚ)^{sgn}` — at n=3 this is the cycle
  integral around the hexagonal 1-cycle of the punctured Boolean
  lattice.

A **non-F-natural** cochain is `c_F^d : top-chains → ℚ` with explicit
dependence on extra data `d` not derived from F's aut-orbit structure.

### 1.1 The three classes of non-natural data tested

**(a) Marked element `x ∈ [n]`.**  Tested constructions:

- `mark_top`: `c(σ_0,σ_1) = m_F(σ_0)·m_F(σ_1)·[x ∈ σ_1]`
- `mark_bot`: `c(σ_0,σ_1) = m_F(σ_0)·m_F(σ_1)·[x ∈ σ_0]`
- `mark_added`: `c(σ_0,σ_1) = m_F(σ_0)·m_F(σ_1)·[x = σ_1∖σ_0]`
- `mark_chiF`: `c(σ_0,σ_1) = χ_F(σ_0∪{x}) − χ_F(σ_1∪{x})`
- `mark_extension`: `c(σ_0,σ_1) = m_F(σ_0∪{x})·m_F(σ_1)`
- `mark_top_only`: `c(σ_0,σ_1) = m_F(σ_1)·[x ∈ σ_0]`   *(no `m_F(σ_0)` factor)*
- `mark_chiF_top`: `c(σ_0,σ_1) = χ_F(σ_1∪{x}) − χ_F(σ_0∪{x})`

**(b) Ordering `π ∈ S_n`.**  Tested constructions:

- `order_min_added`: `c(σ_0,σ_1) = m_F(σ_0)·m_F(σ_1)·[π-min(σ_1) ∈ σ_0]`
- `order_added_min`: `c(σ_0,σ_1) = m_F(σ_0)·m_F(σ_1)·[added = π-min(σ_1)]`
- `order_sgn_perm`: `c(σ_0,σ_1) = m_F(σ_0)·m_F(σ_1)·sgn(σ_1 numerical vs π)`
- `order_sgn_pair`: **`c(σ_0,σ_1) = m_F(σ_1)·sgn(π-rank(added) − π-rank(σ_0))`** *(load-bearing)*
- `order_chiF_pair`: `c(σ_0,σ_1) = χ_F(σ_1)·sgn(π-rank(added) − π-rank(σ_0))`

**(c) External reference family `F_0 ⊆ 2^[n]`, `F_0 ≠ F`.**
Tested constructions:

- `ext_prod`: `c(σ_0,σ_1) = m_F(σ_0)·m_{F_0}(σ_1)`
- `ext_symdiff`: `c =` LIFT-4-prod of `(F △ F_0)`
- `ext_quot`: `c(σ_0,σ_1) = m_F(σ_0)·(m_F(σ_1) − m_{F_0}(σ_1))`

`F_0` candidates spanned trivial-aut, Z_2-aut, and S_3-aut families.

### 1.2 The 12 CE-shape families at n=3, classified by aut(F)

Verified by enumeration and direct aut-computation:

| size | F | aut(F) ⊆ S_3 |
|---|---|---|
| 3 | `[{3} {1,2} {1,2,3}]`             | `Z_2 = ⟨(1 2)⟩` |
| 3 | `[{2} {1,3} {1,2,3}]`             | `Z_2 = ⟨(1 3)⟩` |
| 3 | `[{1,2} {1,3} {1,2,3}]`           | `Z_2 = ⟨(2 3)⟩` |
| 3 | `[{1} {2,3} {1,2,3}]`             | `Z_2 = ⟨(2 3)⟩` |
| 3 | `[{1,2} {2,3} {1,2,3}]`           | `Z_2 = ⟨(1 3)⟩` |
| 3 | `[{1,3} {2,3} {1,2,3}]`           | `Z_2 = ⟨(1 2)⟩` |
| 4 | `[{1,2} {1,3} {2,3} {1,2,3}]`     | **`S_3` (full)** |
| 5 | `[∅ {1,2} {1,3} {2,3} {1,2,3}]`   | **`S_3` (full)** |
| 5 | `[{1} {1,2} {1,3} {2,3} {1,2,3}]` | `Z_2 = ⟨(2 3)⟩` |
| 5 | `[{2} {1,2} {1,3} {2,3} {1,2,3}]` | `Z_2 = ⟨(1 3)⟩` |
| 5 | `[{3} {1,2} {1,3} {2,3} {1,2,3}]` | `Z_2 = ⟨(1 2)⟩` |
| 7 | `[{1} {2} {3} {1,2} {1,3} {2,3} {1,2,3}]` | **`S_3` (full)** |

Nine families have `aut(F) ≅ Z_2` (a single transposition); three have
`aut(F) = S_3` (full symmetric group).

The F-natural baseline (LIFT-4-prod, `mg-e466`) gives cycle integral
**zero** on all 12 — confirmed by re-running here. The non-natural
probe tests whether the structural escape fires.

---

## §2 — Per-construction results at n=3

For each non-natural construction we compute the cycle integral of the
sgn-projection of `c_F^d` on the hex 1-cycle and report the count of
the 12 CE-shape families where SOME choice of `d` makes this non-zero.

### 2.1 Marked element

| Construction | # CE-shape escaping | Stuck CE-shape (size, aut) |
|---|---|---|
| `mark_top`        | 3/12 | size 3 × 3 + size 4 (S_3) + size 5 × 5 + size 7 (S_3) |
| `mark_bot`        | **0/12** | all 12 — `[x ∈ σ_0]` averaged over `x` is sgn-invariant |
| `mark_added`      | 3/12 | same as `mark_top` |
| `mark_chiF`       | **0/12** | all 12 — `χ_F(σ∪{x})` lies in S_n-equivariant trivial-isotype |
| `mark_extension`  | 6/12 | all 3 fully-S_3-sym + size 3 × 3 |
| `mark_top_only`   | **9/12** | the 3 fully-S_3-symmetric F⋆ |
| `mark_chiF_top`   | **0/12** | all 12 |

The marked-element data has stabilizer `S_{n−1}` in `S_n`, which
contains transpositions; for any fully-S_3-symmetric F⋆ at least one
of those transpositions fixes `x` and the construction inherits its
invariance. So `mark_*` constructions are uniformly STUCK on the 3
fully-S_3-symmetric CE-shape families.

The asymmetric (Z_2-aut) CE-shape families escape via marked element:
`mark_top_only` reaches 9/12 = all Z_2-aut families.

### 2.2 Ordering

| Construction | # CE-shape escaping | Stuck CE-shape |
|---|---|---|
| `order_min_added`  | 5/12 | the size-4 fully-sym + size-7 fully-sym + size 3 × 3 |
| `order_added_min`  | 5/12 | same |
| `order_sgn_perm`   | 3/12 | size-4 fully-sym + size 3 × 3 + size-5 × 4 + size-7 fully-sym |
| `order_sgn_pair`   | **12/12 ✓** | none |
| `order_chiF_pair`  | **12/12 ✓** | none |

The ordering π ∈ S_n has trivial S_n-stabilizer (left-multiplication
acts freely). For aut(F) ⊆ S_n, no non-identity τ ∈ aut(F) fixes π.
Therefore `c_F^π` (with π-dependence that is sgn-equivariant in `S_n`,
the construction's invariant) carries non-vanishing sgn-component for
generic F-data.

The 12/12 winners `order_sgn_pair` and `order_chiF_pair` use the
construction `sgn(π-rank(added) − π-rank(σ_0))` — a sgn-equivariant
phase factor on top chains that pairs against F's class function on
doubletons (via `m_F` or `χ_F`) to extract a non-zero sgn-component.

### 2.3 External reference family F_0

| Construction | # CE-shape escaping | Stuck CE-shape |
|---|---|---|
| `ext_prod`      | 6/12  | all 3 fully-S_3-sym + size 3 × 3 |
| `ext_symdiff`   | **11/12** | only the size-4 fully-S_3-sym F⋆ |
| `ext_quot`      | 6/12  | same as `ext_prod` |

External family data has stabilizer `aut(F_0) ⊆ S_n`. For escape,
`aut(F_0) ∩ aut(F)` should not contain any transposition. Among the
F_0 candidates tested:

- `F_0 = {{1}, {2}}`: aut(F_0) = {id} (trivial). Pairs against any F.
- `F_0 = {{1}, {1,2}}`: aut(F_0) = {id}. Same.
- `F_0 = {{1}, {2}, {1,2,3}}`: aut(F_0) = {id}.

`ext_symdiff` (`c =` LIFT-4-prod of `F △ F_0`) escapes 11/12. The
1/12 stuck under `ext_symdiff` is the size-4 fully-S_3-symmetric
F⋆ = `[{1,2}, {1,3}, {2,3}, {1,2,3}]`. The structural reason: the
`F △ F_0` operation can be made non-symmetric via trivial-aut F_0,
but `F △ F_0`'s Möbius transform still vanishes on singletons for
this particular F (a consequence of the size-4 family's regularity —
`m_F(singleton) = 0` is preserved under several `F_0` perturbations).

Aggregate across non-natural constructions: **12/12 CE-shape
families admit at least one non-natural escape**, with the
ordering-based `order_sgn_pair` doing all 12.

---

## §3 — Why the size-4 fully-S_3-sym F⋆ is hardest, and how ordering breaks through

The CE-shape family **F = `[{1,2}, {1,3}, {2,3}, {1,2,3}]`** is the
hardest target: aut(F) = S_3 *and* its Möbius transform `m_F` vanishes
on singletons (because no singleton is in F and `m_F(∅) = 0` too).
For this F:

- ANY cochain of the form `m_F(σ_0) · g(σ_0, σ_1, d)` vanishes
  identically since `σ_0` is a singleton at top dimension n=3 and
  `m_F(σ_0) = 0`. This kills `mark_top`, `mark_bot`, `mark_added`,
  `mark_extension` (via the `m_F(σ_0)` factor), and all three
  `order_*` constructions of the same form.
- ANY F-natural cochain on doubletons alone is S_3-equivariant (since
  aut(F) = S_3 and the doubleton-orbit is uniform), so its sgn-component
  vanishes.
- The escape uses `m_F(σ_1)` (which is non-vanishing on doubletons:
  `m_F({a,b}) = 1` for all `{a,b}`) multiplied by a sgn-equivariant
  phase factor from the ordering π. The phase factor
  `sgn(π-rank(added) − π-rank(σ_0))` is the unique-up-to-scaling
  sgn-equivariant function on ordered-pair-of-elements in [3], and its
  cycle integral pairs against the constant doubleton value to give
  cycle integral 2 (sgn-projected: 12).

This is the structural insight: **`order_sgn_pair` decouples F's
class function (an aut(F)-equivariant function on doubletons) from the
sgn-equivariant phase factor (a function of the chain orientation
relative to π).** The product factors through the regular S_n-rep,
which contains sgn as a summand, so the cochain has non-zero
sgn-component independent of how symmetric F is.

For the OTHER two fully-S_3-symmetric CE-shape families (size 5 with
`∅`, size 7), `m_F` is non-trivial on singletons too, so multiple
`order_*` constructions escape — but `order_sgn_pair` is uniformly
the strongest.

---

## §4 — Vision-level analysis

### 4.1 The narrow technical result

> Non-F-natural constructions **DO** evade the symmetry-vanishing
> obstacle. All 12 CE-shape F⋆ at n=3 admit at least one non-natural
> cochain `c_F^d` with non-zero sgn-class. The structural escape
> `mg-e466` §4.2 hypothesised is real and uniform.

### 4.2 The canonicity caveat

The non-natural cochain `c_F^d` carries a class
`[c_F^d] ∈ H̃^{n-2}(2^[n] \ {∅,[n]}; ℚ)`. This class depends on `d`:

- For `order_sgn_pair`, different `π ∈ S_n` give different (and
  generally distinct, related by sgn) classes.
- For `mark_top_only`, different `x ∈ [n]` give classes related by
  the S_n-action on `x`.

A "canonical" class assigned to F⋆ alone (no auxiliary data) would
require either:

- (i) Choosing a canonical `d` from F⋆'s structure: but a CE-shape
  F⋆ in general has no canonical marked element (all elements are
  non-rare, and the truly rare-element-free condition is exactly
  what forces symmetry) and no canonical ordering.

- (ii) Averaging over `d`: `c̄_F := |D|^{-1} ∑_d c_F^d`. By
  construction, `c̄_F` is `D`-symmetric. If `D` is an S_n-orbit, then
  `c̄_F` is `S_n`-equivariant relative to F, and the
  `mg-e466` symmetry-vanishing argument applies — **the averaged
  class is zero on CE-shape F⋆**.

So the non-natural escape produces a *non-canonical* class. The
vision-step 4 mechanism ("a separate result on the category's
cohomology contradicts the existence of the non-trivial class")
needs a canonical target. With a non-canonical class, the natural
canonical refinement (averaging) brings us back to F-natural and
the contradiction vanishes.

### 4.3 Two readings of Daniel's vision

The vision says: *"take minimal counterexample, show by inclusion
exclusion it induces non trivial cohomology in the category of
families."*

**Strict reading.** "F⋆ induces" means a canonical class assigned to
F⋆ alone. In this reading: non-natural is moot. The verdict is
still RED at the canonical level — only the existence-with-extra-data
version is GREEN. Vision-step 3 is not actually achieved.

**Relaxed reading.** "F⋆ induces" allows auxiliary data: for any
ordering π (or marked element, or external F_0), the F⋆-induced
class `[c_{F⋆}^d]` is non-zero. The class is "indexed by `d`" but
exists for every `d`. In this reading: vision-step 3 is achieved.

Vision-step 4 in the relaxed reading would need: *for every `d`, a
separate result that `[c_{F⋆}^d] = 0`.* This is a stronger separate
result — uniform in `d` — but at least it's a well-posed target.
A natural candidate would be a "uniform vanishing" theorem that holds
for all `d`-parameterised IE cochains; this needs to be invented.

Recommendation: **flag this as a vision-modification candidate for
Daniel**. The technical answer is unambiguous; the interpretive
question (which reading Daniel intended) is for him.

### 4.4 What this finding rules out and leaves open

**Rules out (additional, beyond `mg-e466`):** any "purely structural"
argument that the symmetry-vanishing is a *fundamental* obstruction.
The obstruction *is* fundamental at the F-natural level but can be
ENTIRELY sidestepped by introducing trivial-stabilizer auxiliary
data (an ordering π is enough).

**Leaves open (the live questions):**

- **(O1) The canonicity question.** Does Daniel's vision *require* a
  canonical class, or does it allow auxiliary data? Daniel-attention.

- **(O2) A uniform-in-d vanishing theorem.** Could a separate
  cohomology result be of the form "for ALL non-natural data `d`,
  `[c_F^d] = 0`"? At n=3 the probe explicitly shows this is FALSE for
  CE-shape F⋆ + ordering π — so any candidate uniform vanishing would
  have to hold for F⋆ specifically (true Frankl counterexamples,
  which don't exist at n ≤ 11). The probe at CE-shape F (not true
  counterexamples) yields non-zero, so a uniform-in-d vanishing
  theorem on true Frankl counterexamples is consistent with the data
  — but cannot be tested directly at small n.

- **(O3) n=4 confirmation.** Per ticket, file an n=4 confirmation if
  WORKS. The 582 CE-shape families at n=4 should be checked under
  `order_sgn_pair` (extended to top chains of length 3); the
  structural argument predicts at least the same fraction escape. The
  86% n=4 non-escape under F-natural OP-A LIFT-4-prod becomes
  presumably "12/12 escape under non-natural ordering", but until
  the explicit computation is done this is a claim — not a
  fact. Filed as forward action.

- **(O4) Genuine vision-stage-3 (the separate-category-result).** Now
  has a target: a uniform-in-d vanishing theorem on
  `H̃^{n-2}(2^[n] \ {∅,[n]}; ℚ)^{sgn}` applied to F⋆-induced cochains
  parametrised by orderings. This is a new mathematical object to
  study; whether it has any chance of contradicting Frankl is open.

---

## §5 — Recommendation for pm-onethird and Daniel

1. **Daniel-attention item.** The technical verdict is NON-NATURAL
   WORKS — non-F-natural constructions DO evade the
   `mg-e466` symmetry-vanishing obstruction on all 12 CE-shape
   families at n=3. The vision-level interpretive question is
   **canonicity**: did Daniel's vision require a canonical class,
   or does it allow auxiliary data? This is for Daniel.

2. **Forward action per ticket — file n=4 confirmation.** Confirm
   `order_sgn_pair` escapes on a sample of the 582 n=4 CE-shape
   families. Predicted: a uniform escape (12/12 fraction at n=3
   should extend). Filed as recommended next ticket.

3. **Forward action per ticket — start vision-stage-3.** With a
   target object now identified (uniform-in-d vanishing of
   F⋆-induced non-natural cochains), a separate-category-result
   ticket is well-posed. Whether such a result exists is open.

4. **Vision-modification candidate flag.** The CANONICITY caveat is
   a genuine obstacle that may require Daniel to refine the vision.
   Recommendation: include this finding in pm-onethird's next
   Daniel-update; do not silently re-interpret.

5. **`mg-1b2b` disclosure-pivot remains the operative Lean state.**
   Unaffected by this probe (programme-level only, not Lean-side
   delivery).

---

## §6 — Cross-references

- **Brief:** `mg-e1e2` (this ticket). **Routes to:** Daniel via
  `pm-onethird`.
- **Probe script:** `docs/frankl-nonnatural-cochain-probe.py`.
- **Raw output:** `docs/frankl-nonnatural-cochain-probe.out`.
- **Direct predecessor:** `docs/Frankl-IE-Induction-Probe.md`
  (`mg-e466`) — the F-natural baseline this builds on.
- **Canonical vision:** `docs/Frankl-Vision.md`.
- **Prior-arc synthesis:** `docs/Frankl-Cohomology-Synthesis.md`
  (`mg-5cc6`).

---

*Probe by polecat `cat-mg-e1e2`. Deliverable on `main`: this document
+ probe script + output. Verdict: **NON-NATURAL WORKS at n=3 on all
12 CE-shape families** via `order_sgn_pair`
`c_F^π(σ_0 ⊊ σ_1) = m_F(σ_1) · sgn(π-rank(added) − π-rank(σ_0))`
parameterised by an ordering π ∈ S_n. The structural escape flagged
by `mg-e466` §4.2 fires. CAVEAT: the induced class is non-canonical
(depends on π); averaging over π reintroduces F-natural symmetry and
kills the class. Vision-step 4 needs reformulation to target a
uniform-in-d vanishing theorem; flagged for Daniel-input as a
**vision-modification candidate**. Forward action: file n=4
confirmation + vision-stage-3 (the separate-category-result) per
ticket spec.*
