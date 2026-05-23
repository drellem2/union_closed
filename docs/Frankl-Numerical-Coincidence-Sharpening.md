# Frankl-Numerical-Coincidence-Sharpening — what distinguishes the 84 non-vanishing CE-shape families at n=4 (and what happens at n=5)

**Work item:** `mg-3978` (Frankl-Numerical-Coincidence-Sharpening). Per
Daniel reminder 2026-05-23T05:37Z ("try a few different things") and the
honest flag in mg-e466 §4.2 last bullet: the LIFT-4-prod sgn-class
coincidence holds 100% at n=3 and 86% at n=4. **This document sharpens
the 14% non-vanish at n=4 (84 families) and tests the coincidence on a
structurally-bounded n=5 subclass (|F| ≤ 7).** *Data-investigation, not
a proof-strategy ticket.*

**READ-FIRST consumed:** `docs/Frankl-Vision.md` (mg-e466 / pm-onethird's
canonical vision); `docs/Frankl-IE-Induction-Probe.md` (mg-e466 numerical-
coincidence section §2.3 + §4.2 last bullet + §2.4 structural reason);
`docs/Frankl-Cohomology-Synthesis.md` (mg-5cc6). Probe code:
`docs/frankl-coincidence-sharpening.py`. Raw output:
`docs/frankl-coincidence-sharpening.out`.

---

## §0 — Verdict (top of page)

### 0.1 Headline

> **The 84 n=4 non-vanishing CE-shape families are characterised
> exactly: they form 4 `S_4`-orbits (24, 24, 24, 12), all with
> `Aut(F)` containing no odd-parity permutation.** Sizes are
> `|F| ∈ {7, 9, 9, 11}`, all odd; stabilisers are trivial or
> the double-transposition Klein-4 generator.
>
> **The sharpened structural hypothesis "CE-shape sgn-class vanishes
> ⇔ `Aut(F)` contains an odd permutation" is the cleanest form of
> the mg-e466 §2.4 argument: necessary (`has odd-stab + sgn_nz = 0`
> at n=4 and at n=5 cap=7 — uniformly tight), but NOT sufficient
> (`no odd-stab + sgn_z = 60` at n=4; `1740` at n=5 cap=7 — i.e.
> a second vanishing mechanism is operative on the no-symmetry side).**
>
> **At n=5 within the bounded regime |F| ≤ 7 (6212 CE-shape families
> enumerated exhaustively), the LIFT-4-prod sgn-class vanishes for
> 100% of them.** No non-vanishing CE-shape exception at n=5 |F| ≤ 7
> at all. This is a **strengthening** of the n=3 100% rate, not a
> break.
>
> **But the n=5 large-|F| regime is UNTESTED, and the n=4 exceptions
> lived at |F| ∈ {7,9,11} ≈ 2^{n-1}: at n=5 the analogous regime
> would be |F| ≥ ~14, well beyond the cap=7 bound.** So the n=5 100%
> rate at cap=7 is consistent with — but does NOT confirm — the
> coincidence persisting at larger n. *Reading the data as evidence
> the coincidence holds at n=5 would be over-claim.*
>
> **What this rules in:** the symmetry obstruction
> (mg-e466 §2.4, sharpened) is a *necessary* condition for
> sgn-non-vanishing under the natural F-natural IE construction. The
> 4 n=4 exception orbits are completely enumerated and structurally
> labelled (Aut, gen-size profile, element-count profile).
>
> **What this leaves open:** (i) a second vanishing mechanism on the
> no-odd-stab side (60 at n=4, 1740 at n=5 cap=7 of vanishers with
> no symmetry obstruction); (ii) whether n=5 large-|F| breaks the
> coincidence as n=4 did. **No refined sub-class of CE-shape emerges
> on which the coincidence is provably uniform.**

### 0.2 Vision-alignment

This realises Frankl-Vision part 4 ("separate result about the
cohomology of the category") **only at the data level**. The clean
4-orbit characterisation of the n=4 exceptions is candidate raw
material for "a categorical sgn-isotype vanishing result conditioned
on odd-stab symmetry"; but the coincidence is *unidirectional* (86%
at n=4, with 14% real exceptions), so the converse — "Frankl's truth
on F⋆ ⇔ vanishing" — does NOT hold uniformly. The mg-e466 RED
verdict on the IE-induction route is **strictly preserved** by this
sharpening: the data tighten the negative picture rather than open a
new positive one.

---

## §1 — n=4 sharpening: structural characterisation of the 84
        non-vanishing CE-shape families

### 1.1 |Aut(F)| cross-tab

For each of the 582 CE-shape UC families on `[4]`, we compute
`|Aut(F)|` (the order of the `S_4`-stabiliser of `F` under
element-permutation) and cross-tab against the LIFT-4-prod sgn-class
label:

| `|Aut(F)|` | sgn-non-zero | sgn-zero | total |
|---:|---:|---:|---:|
| 1 (trivial) | **72** | 24 | 96 |
| 2 | **12** | 336 | 348 |
| 4 | 0 | 66 | 66 |
| 6 | 0 | 52 | 52 |
| 8 | 0 | 15 | 15 |
| 24 (full S_4) | 0 | 5 | 5 |
| **total** | **84** | 498 | 582 |

**Read:** only F's with `|Aut(F)| ∈ {1, 2}` ever give non-zero class.
All higher-symmetry CE-shape families uniformly vanish — the
symmetry-killing argument fires cleanly.

### 1.2 The sharp hypothesis: odd-parity stabiliser ⇒ sgn-vanishing

The mg-e466 §2.4 argument shows that any transposition `τ ∈ Aut(F)`
forces `c^sgn = −c^sgn`, hence `c^sgn = 0`. The argument generalises
to *any odd-parity element*: `sgn(σ) = -1` makes the same identity
fire. Conversely, a double-transposition like `(1,2)(3,4)` is
order-2 but even-parity (`sgn = (-1)(-1) = +1`), so it does NOT
kill the sgn-isotype.

Sharpened cross-tab on "`Aut(F)` contains an odd permutation":

| Aut(F) ∩ {odd perms} | sgn-non-zero | sgn-zero |
|---|---:|---:|
| empty (no odd σ ∈ Aut(F)) | **84** | 60 |
| non-empty | **0** | 438 |

> The "has-odd-stab" predicate is a **necessary** condition for
> sgn-non-vanishing on CE-shape at n=4 (0/438 false negatives —
> tight) but **not sufficient** (60/144 = 42% of no-odd-stab
> CE-shape still vanish). A second vanishing mechanism is operative
> on the no-symmetry side.

The 12 non-vanishing with `|Aut|=2` (1.1) all have an even-parity
order-2 stabiliser (a double-transposition), exactly as predicted by
the sharp hypothesis. The 72 non-vanishing with `|Aut|=1` are the
strictest case: trivial stabiliser, no symmetry obstruction at all,
and the sgn-class genuinely fires.

**At n=4, hypothesis A ("no transposition in Aut(F)") and hypothesis
B ("no odd element in Aut(F)") happen to agree numerically** (both
give 84+60 vs 0+438). This is because in `S_4` the only odd-parity
elements outside transpositions are 4-cycles, and within the 582
CE-shape on [4], no `Aut(F)` contains a 4-cycle without also
containing a transposition. (Empirically observed; not enforced.)
Hypothesis B is the formally sharper statement.

### 1.3 The 4 S_4-orbits of non-vanishing — one representative each

The 84 non-vanishing CE-shape families decompose under the natural
`S_4`-action into exactly **four orbits**. One rep each:

| `|F|` | `|Aut(F)|` | orbit size | element-counts (sorted) | representative |
|---:|---:|---:|---|---|
| 7 | 1 | 24 | (4, 4, 5, 5) | `[{2} {1,4} {2,3} {1,2,3} {1,2,4} {1,3,4} {1,2,3,4}]` |
| 9 | 1 | 24 | (5, 5, 6, 7) | `[{1} {1,2} {1,4} {2,3} {1,2,3} {1,2,4} {1,3,4} {2,3,4} {1,2,3,4}]` |
| 9 | 1 | 24 | (5, 6, 6, 6) | `[{3} {1,2} {1,4} {2,3} {1,2,3} {1,2,4} {1,3,4} {2,3,4} {1,2,3,4}]` |
| 11 | 2 | 12 | (6, 6, 7, 7) | `[{1} {3} {1,3} {1,4} {2,3} {2,4} {1,2,3} {1,2,4} {1,3,4} {2,3,4} {1,2,3,4}]` |

Totals: 24 + 24 + 24 + 12 = 84.  ✓

**Observations:**
- All four orbits have *|F| odd* (7, 9, 9, 11). No even-|F| CE-shape
  on [4] produces a non-vanishing class. (Likely a parity artefact:
  in the LIFT-4-prod cochain, an even product can cancel around the
  sphere by symmetric pairing of chains.)
- All four orbits live at `|F| ≥ 7` (out of the 16 subsets of [4]),
  matching the |F| ≥ 7 size-bound observation in mg-e466 §2.4.
- The single `|Aut|=2` orbit has stabiliser generated by a
  double-transposition (the only even order-2 element type in `S_4`);
  the other three have trivial `Aut`.
- The orbit-decomposition is **completely enumerated**: there are no
  hidden orbits, no border cases. The 84 is 4 orbits.

### 1.4 |F| cross-tab

| `|F|` | sgn-nz | sgn-z | total | % nz |
|---:|---:|---:|---:|---:|
| 3 | 0 | 25 | 25 | 0.0% |
| 4 | 0 | 10 | 10 | 0.0% |
| 5 | 0 | 81 | 81 | 0.0% |
| 6 | 0 | 23 | 23 | 0.0% |
| **7** | **24** | 119 | 143 | **16.8%** |
| 8 | 0 | 43 | 43 | 0.0% |
| **9** | **48** | 81 | 129 | **37.2%** |
| 10 | 0 | 33 | 33 | 0.0% |
| **11** | **12** | 67 | 79 | **15.2%** |
| 12 | 0 | 5 | 5 | 0.0% |
| 13 | 0 | 10 | 10 | 0.0% |
| 15 | 0 | 1 | 1 | 0.0% |

**Read:** non-vanishing concentrates strictly at odd `|F| ∈ {7, 9, 11}`.
Even sizes never produce non-vanishing.

### 1.5 Element-count balance cross-tab

`balance := max a_F(x) − min a_F(x)`:

| balance | sgn-non-zero | sgn-zero |
|---:|---:|---:|
| 0 (uniform) | 0 | 42 |
| 1 | 60 | 304 |
| 2 | 24 | 144 |
| 3 | 0 | 8 |

Non-vanishing concentrates on balance ∈ {1, 2}. Fully balanced
(every element in same number of members) and extreme-balance (=3)
never produce non-vanishing — both extremes are killed.

### 1.6 Generator-count cross-tab

| `#gens` (= join-irreducibles) | sgn-nz | sgn-z |
|---:|---:|---:|
| 2 | 0 | 25 |
| 3 | 0 | 32 |
| 4 | 0 | 129 |
| 5 | 60 | 166 |
| 6 | 24 | 116 |
| 7 | 0 | 26 |
| 8 | 0 | 4 |

Non-vanishing concentrates on `#gens ∈ {5, 6}`. Below 5 and above
6, the class uniformly vanishes.

### 1.7 The four exact gen-size profiles of the 84 non-vanishing

| gen-sizes (sorted multiset) | count | matched orbit |
|---|---:|---|
| (1, 2, 2, 2, 3) | 24 | orbit 1 (`|F|=7`) |
| (1, 2, 2, 2, 3, 3) | 24 | orbit 2 (`|F|=9`) |
| (1, 2, 2, 3, 3) | 24 | orbit 3 (`|F|=9`) |
| (1, 1, 2, 2, 2) | 12 | orbit 4 (`|F|=11`) |

Each non-vanishing orbit has a single gen-size profile, and the
four profiles are pairwise distinct. Together they completely
characterise the non-vanishing 84 by structural type.

### 1.8 Element-count profile cross-tab — non-vanishing is concentrated on 4 profiles only

Across all 582 CE-shape, only **four** sorted element-count profiles
ever produce non-vanishing — exactly matching the four orbits:

| sorted element-counts | sgn-nz | sgn-z | orbit |
|---|---:|---:|---|
| (4, 4, 5, 5) | 24 | 12 | orbit 1 |
| (5, 5, 6, 7) | 24 | 12 | orbit 2 |
| (5, 6, 6, 6) | 24 | 4 | orbit 3 |
| (6, 6, 7, 7) | 12 | 12 | orbit 4 |
| (all other profiles, 31 of them) | 0 | 474 | — |

The element-count profile **alone does not separate** non-vanishing
from vanishing: each of the 4 non-vanishing profiles is shared with
some vanishing CE-shape (12 + 12 + 4 + 12 = 40 vanishers under these
profiles). Within each profile, the odd-stabiliser predicate is the
sharp separator: profile-matching vanishers carry an odd permutation
in `Aut(F)`; the 84 non-vanishers do not.

---

## §2 — n=5 bounded-enumeration probe (|F| ≤ 7)

### 2.1 Setup

Total UC families on `[5]` is intractable (~10¹² by Dedekind), so we
bound by `|F| ≤ K` and enumerate UC families with `[5] ∈ F` by BFS
adding-one-set-and-closing. CE-shape filter then keeps only families
with no rare element. (Closed form: `|F| ≤ 7` is the practical
per-polecat-session ceiling; `|F| ≤ 8` is tractable but would take
tens of minutes more and the additional families only refine the
size regime — they do not reach the "large-|F|-near-2^{n-1}" regime
where the n=4 exceptions live.)

The punctured-Boolean ambient at n=5 is `S^3` (dim 3, `H^3 ≅ sgn_{S_5}`).
Top-dim simplices are 4-chains of proper non-empty subsets: 120
top-dim simplices (`= 5!`), 240 (top-1)-dim simplices (3-chains).
Coboundary basis has rank 119; the missing 1-dim is the `sgn_{S_5}`
class we test against.

### 2.2 Results

| cap K | UC fams with [5]∈F, |F|≤K | of which CE-shape | sgn-non-zero |
|---:|---:|---:|---:|
| 6 | 18,908 | 1,571 | **0 / 1,571** (0.0%) |
| 7 | 47,369 | 6,212 | **0 / 6,212** (0.0%) |

**At n=5, |F| ≤ 7, exhaustively: zero non-vanishing CE-shape UC families.**

### 2.3 Cross-tabs at n=5 cap=7

|  | sgn-nz | sgn-z |
|---|---:|---:|
| no transposition in Aut(F) | 0 | 1,740 |
| has transposition | 0 | 4,472 |

|  | sgn-nz | sgn-z |
|---|---:|---:|
| no odd-parity element in Aut(F) | 0 | 1,740 |
| has odd-parity element | 0 | 4,472 |

|Aut(F)| profile of the 6,212 CE-shape (all vanishing):

| `|Aut(F)|` | sgn-z count |
|---:|---:|
| 1 | 1,320 |
| 2 | 3,120 |
| 4 | 1,230 |
| 6 | 260 |
| 8 | 90 |
| 12 | 160 |
| 24 | 30 |
| 120 (full S_5) | 2 |

### 2.4 Interpretation

**The 14% non-vanishing rate at n=4 was concentrated at `|F| ∈ {7, 9, 11}`
— odd sizes near `2^{n-1} = 8`.** At n=5, the analogous regime would
be `|F| ~ 14-18` (near `2^{n-1} = 16`), well **beyond** our cap=7
bound. So:

- The cap=7 100% rate at n=5 confirms that **small-|F| CE-shape are
  systematically sgn-vanishing at n=5**, matching the n=4 size-bound
  finding (no exceptions below `|F| = 7` at n=4 either).
- It does **NOT** test the analogous large-|F| regime, and so does
  NOT rule out exceptions at n=5 `|F| ≥ ~14`.
- The most we can honestly say: **the coincidence persists in the
  bounded small-|F| regime, but the regime that mattered at n=4 is
  out of reach here.**

The "no-odd-stab + sgn_z" residual at n=5 cap=7 is **1,740** (vs
60 at n=4), a much larger share of total (28% vs 10%). The
**necessary** direction of the sharpened hypothesis still holds
tight (0 non-vanishing on the has-odd-stab side at both n), but the
*sufficient* direction is weaker at n=5: the secondary vanishing
mechanism is more dominant at smaller |F|.

### 2.5 What the n=5 cap=7 data does and does not tell us

| Claim | Status at n=5 cap=7 |
|---|---|
| LIFT-4-prod sgn vanishes for all CE-shape with `|F| ≤ 7` | **TRUE** (0/6212) |
| Symmetry obstruction is necessary for non-vanishing | **TRUE** (0/4472 with odd-stab non-vanish) |
| Symmetry obstruction is sufficient for vanishing | **TRUE** (the 4472 with odd-stab all vanish — sufficient direction trivially OK) |
| Symmetry obstruction is the *only* vanishing reason | **FALSE** (1740 vanish without any odd-stab) |
| Coincidence holds at n=5 large-|F| (analogous to the n=4 exception regime) | **UNTESTED** (cap=7 well below `|F| ~ 14`) |
| Coincidence has no exceptions at any n ≥ 4 | **NOT SUPPORTED** (the n=4 14% rate is the operative datum) |

---

## §3 — Honest framing & limits of the data

### 3.1 What this probe establishes

1. **Exact structural enumeration of the n=4 non-vanishing 84:**
   four `S_4`-orbits of sizes 24, 24, 24, 12, with `|F| ∈ {7, 9, 9,
   11}`, all carrying trivial-or-EVEN-only stabiliser (no odd
   permutation in `Aut(F)`). Representatives are listed in 1.3.
2. **Sharpened symmetry obstruction:** "Aut(F) contains an odd
   permutation ⇒ sgn-vanishing" is the precise form of the mg-e466
   §2.4 argument, tight in the necessary direction at both n=4 and
   n=5 (cap=7) data.
3. **The sharpened obstruction is necessary but not sufficient:**
   60 of 498 vanishing CE-shape at n=4 (and 1,740 of 6,212 at n=5
   cap=7) have no odd-parity stabiliser yet still vanish. A second
   vanishing mechanism is operative.
4. **At n=5 small-|F| (|F| ≤ 7):** coincidence holds 100% (0/6,212
   non-vanishing), strengthening the n=3 100% rate. But this is the
   *small-|F| regime where the n=4 had no exceptions either*; the
   n=4 exceptions were at `|F| ∈ {7, 9, 11}` near `2^{n-1}`. So this
   does NOT extend to a confirmation of the coincidence at n=5.

### 3.2 What this probe does NOT establish

- **The coincidence is not uniform** in any clean sub-class at n=4:
  60 false-positive vanishers (no odd-stab + sgn-zero) and 84
  non-vanishers coexist outside any obvious predicate this probe
  evaluated.
- **The n=5 large-|F| regime (|F| ~ 14-18) is UNTESTED.** A break at
  large-|F| n=5 would be consistent with the cap=7 100% rate and
  with the n=4 pattern.
- **No proof-strategy claim is justified.** The clean 4-orbit
  structure of the n=4 exceptions is informative but the coincidence
  is unidirectional (86% one way at n=4); no "Frankl iff
  sgn-vanishing on refined-CE-shape" reformulation emerges.

### 3.3 What this probe adds beyond mg-e466

mg-e466 reported the headline 100% / 86% rates and the §2.4
symmetry argument; the 14% non-vanishing at n=4 was flagged as a
noted-but-uncharacterised data point. This probe:

1. Enumerates the 84 non-vanishing CE-shape exactly into 4
   `S_4`-orbits with explicit representatives.
2. Sharpens the §2.4 symmetry argument from "transposition ⇒ vanish"
   to "any odd-parity element ⇒ vanish" — the maximal generalisation
   of the sign-cancellation identity, and the formally sharp form.
3. Identifies the 60 residual no-odd-stab-but-vanishing CE-shape at
   n=4 (and the 1,740 analogous residual at n=5 cap=7) as the
   boundary of the symmetry argument's predictive power — they
   require some second mechanism beyond `Aut(F)`-symmetry.
4. Extends the n=5 probe from "intractable" to "100% at cap=7", with
   the explicit caveat that this is the small-|F| regime, NOT the
   large-|F| regime where the n=4 exceptions live.

---

## §4 — Vision-alignment & recommendation

### 4.1 Where this sits in Daniel's verbatim vision

Per `docs/Frankl-Vision.md`, the vision-step-3 → step-4 contradiction
needs F⋆ to induce a non-trivial class. mg-e466 reported RED on the
four natural readings of the IE-induction; this sharpening:

- **Does not re-open the RED verdict.** Vision-step 3 still fails on
  the 86% of CE-shape F⋆ at n=4 that vanish; the 14% non-vanishing
  are exception orbits, not a uniform "refined CE-shape".
- **Strengthens the §2.4 obstruction story.** The cleanest
  statement: any F-natural cochain inherits `Aut(F)`'s symmetry, and
  any odd-parity element in `Aut(F)` forces the sgn-isotype to zero.
  The Frankl-counterexample condition (no rare element ⇒ balanced
  element-counts ⇒ likely odd-stabiliser) systematically *populates*
  `Aut(F)` with odd elements, killing the class. The 84 n=4 orbit
  exceptions are exactly the rare cases where `Aut(F)` happens to be
  `S_4`-poor enough to miss the odd elements — and even those
  vanish on a 4-orbit-exception set, not on a uniformly-non-vanishing
  refined class.

### 4.2 No refined CE-shape gives a uniform coincidence

A natural follow-on question is whether **some refined subclass of
CE-shape** (e.g., CE-shape + extra conditions) gives a uniform
"vanish ⇔ Frankl true" coincidence. The data say no:

- Restricting by `|F|` alone (e.g., `|F| ∈ {7, 9, 11}` at n=4) keeps
  *both* non-vanishers (84) AND vanishers (267) in scope; the
  coincidence is non-uniform within these slabs.
- Restricting by `Aut(F)` profile separates `has-odd-stab` from
  `no-odd-stab` cleanly on the necessary side, but the
  no-odd-stab slab itself splits 84 non-vanishers + 60 vanishers at
  n=4 (and 0 non-vanishers + 1740 vanishers at n=5 cap=7) — not
  uniformly non-vanishing on either side.
- The four explicit n=4 non-vanishing orbits have distinct
  (size, gen-size, element-count) profiles; their union is *not* a
  natural categorical sub-class but a small finite list.

So the data do **not** indicate a refined CE-shape on which the
coincidence is uniform. The coincidence is a low-n numerical
phenomenon with explicitly-enumerated exceptions, not a structural
correspondence.

### 4.3 Recommendation

1. **The mg-e466 RED verdict stands, sharpened:** the data now
   include a clean structural map of the n=4 exceptions and a 100%
   confirmation in the n=5 small-|F| regime. Vision-step-3 → 4
   contradiction remains blocked on the four natural IE-induction
   readings.

2. **The 84-family clean orbit characterisation is candidate raw
   material for a separate-result-about-the-category track** (vision
   part 4) only in the modest sense that "any F-natural cochain
   construction has its sgn-isotype killed by an odd-parity element
   in `Aut(F)`" is now precisely formulated. But this fact alone
   does not produce a Frankl contradiction — it is a generic
   constraint on cochain constructions, satisfied by every F-natural
   probe ever run.

3. **A follow-on probe at n=5 large-|F| (|F| ≥ 14) would close the
   "is it a low-n artefact?" question**, but takes substantial
   compute. The cap=7 ≤8min, cap=8 would take ~30min, cap=10
   probably hours. Not warranted absent a vision modification that
   reads the coincidence as evidentiary.

4. **No new Frankl-arc ticket is automatically warranted** by this
   sharpening. The probe documents the structure of the data; it
   does not surface a new proof path beyond what mg-e466 §4 already
   bounded out.

---

## §5 — Cross-references

- **Brief:** `mg-3978` (this ticket). Routes to Daniel via
  `pm-onethird`.
- **Probe code:** `docs/frankl-coincidence-sharpening.py` (self-
  contained Python, no dependencies; cross-checked at two ~2³¹ primes).
- **Raw output:** `docs/frankl-coincidence-sharpening.out`.
- **The coincidence flag:** `docs/Frankl-IE-Induction-Probe.md`
  (mg-e466), specifically §2.3 (the 14% non-vanish), §2.4 (symmetry
  argument), §4.2 last bullet (the deferred sharpening this probe
  realises).
- **Canonical vision:** `docs/Frankl-Vision.md`.
- **Cohomology synthesis:** `docs/Frankl-Cohomology-Synthesis.md`
  (`mg-5cc6`).

---

*Probe by polecat `cat-mg-3978`. Deliverable on `main`: this document
plus `docs/frankl-coincidence-sharpening.py` and
`docs/frankl-coincidence-sharpening.out`. **Verdict at n=4: SHARP —
84 non-vanishing CE-shape decompose exactly into 4 `S_4`-orbits, all
with trivial-or-EVEN-stabiliser; sharpened symmetry hypothesis
"has odd-stab ⇒ sgn-vanishing" is tight on the necessary side
(0 exceptions in 438 has-odd-stab) but not sufficient
(60 no-odd-stab vanishers remain).** **At n=5 |F|≤7: 0/6212
non-vanishing — coincidence holds 100% in this regime, but the
analogous-to-n=4 large-|F| regime (|F|~14-18) is UNTESTED.** No
proof claim made; mg-e466 RED verdict on the IE-induction route
stands and is *sharpened* by this characterisation.*
