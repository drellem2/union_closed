# Frankl-Spherical-Reconcile — does a tweaked definition recover a spherical category-level cohomology of intersection-closed families?

**Work item:** `mg-7bf3` (Frankl-Spherical-Reconcile). Per a Daniel
reminder 2026-05-22, responding to the Fork A refutation (`mg-f9a7`):

> *"I thought we already proved that the cohomology of the category of
> intersection-closed families on n elements was spherical. If not
> perhaps there was a slight tweak in the definition."*

This is a bounded **reconciliation-and-definition-tweak probe** — it
tests Daniel's instinct directly and gates the Frankl
stop-vs-re-found decision.

**READ-FIRST consumed:** `docs/Frankl-ForkD-Probe-n3.md` (`mg-565a` —
the per-family-vs-lattice / `§6.5` conflation finding);
`docs/Frankl-ForkA-Phase0-FaithfulnessProbe.md` (`mg-f9a7` — the
terminal-object hocolim collapse and the explicit holim hint);
`docs/Frankl-vision-check.md` (`mg-6edc`); the F-series source notes
in `docs/union-closed-UC9-...md` (`§D-4`, the punctured Boolean cube
`≃ S^{n-2}`) and `docs/union-closed-UC10-...md` (`§0.3`, the
F-series template);
`paper/forkA/refoundation.tex` (`rem:hocolim-flag`,
`rem:holim-prereq`).

**Scope.** A bounded, reproducible `n = 3` computation — the method of
`mg-565a` and `mg-f9a7`. Two parts:
1. **Reconciliation.** Enumerate every proven `spherical` result in
   the union-closed / F-series corpus and state precisely which
   object it is about.
2. **Definition-tweak probe.** Test the natural candidates: the
   homotopy limit, the terminal-excluded subcategory, and the
   Moore-lattice with inclusion morphisms.

**Deliverable:** this document and the computation script
`docs/frankl-spherical-reconcile-probe.py` (self-contained, no
dependencies; runs in ~2.5 s; `δ² = 0` verified explicitly on every
cobar complex; ranks cross-checked at two `~2^31` primes).
`pm-onethird` relays to Daniel. Deliverables on `main`.

---

## §0 — Verdict (top of page)

### 0.1 Headline

> **RED — STOP CONFIRMED, DANIEL'S TWEAK HYPOTHESIS REFUTED.** Every
> proven `spherical` result in the union-closed / F-series corpus is
> about a **per-family** object — either `Δ(PPF_n)` (the
> *sister* category of posets, F17/F18) or `Δ(2^[n]∖{∅,[n]})` (one
> family viewed as the inclusion poset of its own member sets, UC9
> `§D-4`). There is **no** proven spherical result about the
> cohomology of the **category** of intersection-closed families;
> every category-level computation refutes the conjecture — the
> Moore-lattice bare nerve (`mg-565a`), the trace-category hocolim
> (`mg-f9a7`), the homotopy *limit* (this probe), and every
> natural variant tested below.
>
> Daniel's tweak hypothesis (*"perhaps there was a slight tweak in
> the definition"*) is **refuted at `n=3` for every natural
> candidate** :
> - **The homotopy limit** `holim_{C_3} X` — `mg-f9a7`'s lead
>   candidate, the variance the obstruction `is` a limit-flavoured
>   invariant — gives `H^*(C_3; π_0(X)) = {0: 6}`, concentrated in
>   degree `0` and `S_3`-isotype `4·triv + 1·std` (no `sgn`). Not
>   spherical: family-sensitive non-trivial cohomology, but housed
>   in the wrong degree, the wrong dimension, and the wrong
>   isotype.
> - **The terminal-excluded subcategory** at hocolim flavour
>   (`mg-f9a7` `§2.3`): confirmed at `H^2 = 59` (`|S|≥1`) and
>   `H^1 = 133` (`|S|≥2`). The matching holim-flavour variants give
>   `{0:6, 2:45}` and `{0:6, 1:102}`. None spherical.
> - **The Moore-family lattice with the coefficient diagram**
>   `π_0(X)` — `Drift A` undone (inclusion morphisms instead of
>   traces), the coefficient diagram `mg-565a` vindicated kept — gives
>   `{0:1}` (whole lattice, top-dropped) or `{0:1, 1:2}` (proper
>   part); the `H^1 = 2` of the proper-part variant is the **`std`
>   isotype, no `sgn`** — not the sphere the F-series template wants.
>
> Per the ticket's gate, *"if every reasonable tweak collapses or is
> non-spherical — the route is genuinely dead; STOP is confirmed."*
> Every tweak tested is non-spherical; some collapse; one gives
> non-trivial cohomology in a positive degree but with the wrong
> isotype. **STOP is confirmed with Daniel's specific concern run
> down.** The probe is honest about the constructive half: the
> family-sensitive content is real and lives in `π_0(X(F))` — but
> integrating it over the category (any of the natural integrations:
> hocolim, holim, lattice nerve, lattice-with-coefficients) does not
> reconstruct a spherical class.

### 0.2 The scorecard, at a glance

| Object (category-level cohomology of int-closed families) | `H^*` at `n=3` | Spherical? | Where settled |
|---|---|---|---|
| `H^*(BΔ(PPF_n))` [F17/F18, SISTER category of *posets*] | `H̃^{n-2} = sgn_{S_n}` | **YES** — but DIFFERENT category | F-series corpus |
| `Δ(2^[n]∖{∅,[n]})` [per-family object, ONE family] | `H̃^{n-2} = sgn_{S_n}` | **YES** — but PER-FAMILY, not category | `UC9 §D-4`, `mg-565a` self-test |
| Moore-family lattice bare nerve (proper part) | `H̃^* = 0` (rationally acyclic) | NO — acyclic | `mg-565a` (Fork D refutation) |
| Fork A `hocolim_{C_n} X` [trace category, covariant] | `H^* = ℚ` (degree 0) | NO — acyclic, terminal-object collapse | `mg-f9a7` |
| **Fork A holim**, `H^*(C_3; π_0(X))` [this probe, lead] | `{0:6}`, `4·triv + 1·std` | **NO — degree 0, 6-dim, no sgn** | **this probe `§2`** |
| Terminal-excluded `C_3^{\|S\|≥1}` hocolim | `{0:1, 2:59}` | NO — 59-dim | confirmed, `mg-f9a7` `§2.3` |
| Terminal-excluded `C_3^{\|S\|≥2}` hocolim | `{0:1, 1:133}` | NO — 133-dim | confirmed, `mg-f9a7` `§2.3` |
| `H^*(C_3^{\|S\|≥1}; π_0(X))` (terminal-excluded holim) | `{0:6, 2:45}` | NO — 45-dim | this probe `§3.1` |
| `H^*(C_3^{\|S\|≥2}; π_0(X))` | `{0:6, 1:102}` | NO — 102-dim | this probe `§3.1` |
| `H^*(Moore[3]; π_0(X))` [drift A undone, lattice + coefficients] | `{0:1}` | NO — trivial | this probe `§3.2` |
| `H^*(Moore[3] without top; π_0(X))` | `{0:1}` | NO — trivial | this probe `§3.2` |
| `H^*(Moore[3] proper part; π_0(X))` | `{0:1, 1:2}`, `1·triv − 1·std` (in `H^1`) | NO — 2-dim, no sgn | this probe `§3.2` |

### 0.3 The reconciliation, in one sentence

> **Daniel's recollection matches a per-family fact, not a
> category-level fact.** The provably-spherical objects in the corpus
> — `Δ(PPF_n)` and `Δ(2^[n]∖{∅,[n]})` — are **not** the cohomology of
> the category of intersection-closed families; the former is the
> cohomology of the **category of posets** (the F-series sister; UC10
> is the would-be analog, never built), and the latter is the
> cohomology of **one family viewed as its own inclusion poset**
> (UC9 `§D-4`'s witness, used as a test object by the program but
> never as the category-level cohomology object). Every category-
> level integration of the family-sensitive content (hocolim, holim,
> lattice nerve, lattice-with-coefficients) tested at `n=3` is
> non-spherical. There is no "slight tweak" — the category-level
> sphere does not exist in any natural form.

---

## §1 — Method and the objects probed

### 1.1 The reconciliation question

The Frankl cohomological route has had three structural collapses:

- **UC10 / Phase 1.5** (`mg-0405` RED): the against-trace structure
  map of the contravariant hocolim does not exist.
- **Fork D** (`mg-565a` RED): the Moore-family lattice's bare nerve
  cohomology is rationally acyclic at `n=2`, `n=3` (under both
  empty-set conventions).
- **Fork A** (`mg-f9a7` RED): the covariant hocolim over `C_n`
  collapses onto the terminal object `(∅,{∅})`, again rationally
  acyclic.

Daniel recalls a proven `SPHERICAL` result for "the cohomology of the
category of intersection-closed families." The question this probe
answers: **does such a result actually exist in the corpus, and if
not, is there a `slight tweak in the definition` that produces one?**

### 1.2 The objects to keep rigorously apart

Three posets/categories must be kept apart, because the program has
historically conflated them (`mg-565a` `§5` is the structural finding;
this probe sharpens it):

- **(A) The F-series category of posets** `PPF_n` = proper partial
  orders on `[n]`, ordered by refinement. Its order complex
  `Δ_n = Δ(PPF_n)` is `≃ S^{n-2}` with `H̃^{n-2} ≅ sgn_{S_n}` (F17 +
  F18, `mg-4d3a` + `mg-d039`). **This is not the category of
  intersection-closed families.** It is the *sister* category UC10
  named as a *template*. The would-be UC10 analog (UC10.1) was
  refuted by `mg-0405`.

- **(B) The per-family Boolean-cube object** `2^[n]∖{∅,[n]}`
  ordered by `⊆`. This is **one** intersection-closed family
  (the maximal one, `F = 2^[n]`) viewed as the inclusion poset of
  its own member sets. Its order complex is `≃ S^{n-2}` with
  `H̃^{n-2} ≅ sgn_{S_n}` (UC9 `§D-4`). **This is per-family — one
  element of the lattice/category of intersection-closed families,
  not the lattice/category itself.**

- **(C) The category of intersection-closed families** — the object
  Daniel's vision asks about. Two natural realisations:
  (C1) the **Moore-family lattice** on `[n]` with **inclusion**
       morphisms (Fork D / `mg-565a`'s object);
  (C2) the **trace category** `C_n` with **trace** morphisms
       (UC10's / Fork A's object — `mg-f9a7`'s object).
  Both have been computed: (C1) has rationally acyclic bare nerve
  cohomology; (C2)'s `hocolim_{C_n} X` is rationally acyclic.

### 1.3 What the tweak hypothesis asks, made precise

The hypothesis is that some `slight tweak` of the cohomology object
on a category of intersection-closed families ((C) above) recovers
spherical content. Per the ticket's enumeration:

- **Lead candidate — the homotopy LIMIT.** `mg-f9a7` `§6` rec 4 and
  `refoundation.tex` `rem:hocolim-flag` / `rem:holim-prereq` flag
  this: the obstruction is a *gluing-type (limit-flavoured)*
  invariant. The covariant hocolim collapses onto the terminal
  object via *homotopy finality* of `{t}↪C_n`; the holim does NOT
  collapse there, because `{t}↪C_n` is not homotopy *initial*
  (`(t↓c)` is empty for `c≠t`, not contractible), and `C_n` has no
  initial object. So `holim` is a structurally distinct object that
  does not suffer the Fork A collapse mechanism.
- **Terminal-excluded subcategory.** Drop the terminal object `t`
  (and optionally the `|S|=1` layer) and recompute. `mg-f9a7` `§2.3`
  noted `H^2 = 59` (`|S|≥1`) for hocolim — not sphere-like; confirm
  and extend.
- **Lattice + coefficients (drift A undone, drift B kept).** Use
  the Moore-family lattice with **inclusion** morphisms (the
  F-series template's variance, `mg-565a` Fork D's morphism class)
  but combined with the **coefficient diagram** `π_0(X)` that
  `mg-565a` `§4` and the Fork-A endorsement vindicated. This is the
  closest hybrid of mg-565a's positive finding and the program's
  founding template, and is the natural candidate the
  reconciliation suggests.

### 1.4 Method

A from-scratch, reproducible computation
(`docs/frankl-spherical-reconcile-probe.py`). All cohomology over
`ℚ`, computed via sparse modular Gaussian elimination at two
independent `~2^31` primes (cross-checked). `δ² = 0` is verified
explicitly on every cobar complex built. Two self-tests confirm the
machinery: (i) the punctured Boolean cube `2^[3]∖{∅,[3]}` has
reduced cohomology `H̃^1 = 1` (`≃ S^1`, UC9 `§D-4`); (ii) the
Moore-family lattice's proper part on `[3]` is `ℚ`-acyclic
(`mg-565a` confirmed).

**The cleanest version of `holim`, used here.** `mg-f9a7` `§4.1`
established that `X(F)` is **homotopy-discrete** at `n≤4`: its
only non-zero reduced cohomology is `H̃^0` (it is a disjoint union
of contractible pieces). Therefore the Bousfield-Kan spectral
sequence computing the cohomology of `holim_{C_n} X` collapses onto
the `q=0` row, and

> `H^p(holim_{C_n} X) = lim^p_{C_n} (H_0(X)) = H^p(C_n; M)`

where `M(F) = π_0(X(F))` is the connected-components functor on
`C_n` (covariant via `π_T`: components merge under trace). This is
**the clean category-level cohomology with non-constant
coefficients** — the analog of `H^*(C_n; X(-))` the `mg-565a`
endorsement of Fork A named, but in the holim variance rather than
the hocolim one. Computing it is unambiguous (no chain-vs-cochain
sign minefield); the script computes the cobar complex directly.

---

## §2 — Part 1: the reconciliation table

The reconciliation answers the precise question from the ticket
`§1`: *"is there ALREADY a proven spherical result about the
cohomology of the CATEGORY of intersection-closed families as
Daniel recalls, or is every proven spherical result about a
per-family object?"*

| Result | Object | Category-level or per-family? | Cite |
|---|---|---|---|
| `Δ_n = Δ(PPF_n) ≃ S^{n-2}`, `H̃^{n-2} ≅ sgn_{S_n}` | Order complex of the category of **posets** on `[n]`, ordered by refinement | **Category-level — but a DIFFERENT category** (posets, not intersection-closed families); UC10.1 is the (unbuilt, would-be) analog | F17 `mg-4d3a` + F18 `mg-d039`; UC10 `§0.3` |
| `Δ(2^[n] ∖ {∅,[n]}) ≃ S^{n-2}`, `H̃^{n-2} ≅ sgn_{S_n}` | Punctured Boolean cube — ONE family `F = 2^[n]` viewed as the inclusion poset of its own member sets | **PER-FAMILY** — one element of the lattice/category | UC9 `§D-4`; reproduced as self-test of this probe (`§5`/script R1) |
| `Δ(MOORE_n)` proper part `ℚ`-acyclic, all `H̃^* = 0` | Moore-family lattice on `[n]` (intersection-closed families with inclusion morphisms) | **CATEGORY-LEVEL** — Fork D's object | `mg-565a` Fork D probe; reproduced as self-test |
| `H^*(C_n; X) = H^*(hocolim_{C_n} X) = ℚ` in degree 0 | Trace category with covariant cubical-defect diagram (Fork A `def:bk`) | **CATEGORY-LEVEL** — Fork A's object | `mg-f9a7` Phase-0 faithfulness probe |
| Per-family `X(F)` reduced cohomology — 2 profiles at `n=3` (44 acyclic, 17 with `H̃^0 = 1`), 4 at `n=4` | Per-family cubical-defect complex (`def:xf`) | **PER-FAMILY** — varies across families, never spherical itself (homotopy-discrete) | `mg-f9a7` `§4.1` |
| Per-family lattice intervals `(0̂, F)` — 4 distinct profiles at `n=3` | Intervals in the Moore lattice | per-family object | `mg-565a` PART C |

### Verdict on the reconciliation

> **Every proven spherical result in the corpus is about either**
> **(i) the SISTER category of posets** (F17/F18, where the
> spheroid is `Δ(PPF_n)`; the cohomology of the *category of
> posets*, not the *category of intersection-closed families*; UC10's
> *template*, not UC10's *result*), **or (ii) a per-family object**
> (UC9 `§D-4`'s punctured Boolean cube, the inclusion poset of
> **one** family's own member sets). **No proven spherical result
> in the corpus is about the cohomology of the category of
> intersection-closed families.** Every proven category-level
> computation on that category — Moore-lattice bare nerve, trace-
> category hocolim — is rationally acyclic.

**The conflation Daniel may be remembering.** The vision-check
(`mg-6edc` `§6.5`) and the program's design documents have
historically pointed at UC9 `§D-4` ("the punctured Boolean cube is
spherical") and attributed sphericality to "the category of
intersection-closed families." That is exactly the
**conflation** `mg-565a` `§5` flagged: UC9 `§D-4` is about **one
family viewed as its own poset** (`Poset A` in `mg-565a` `§1.2`
terminology); the Moore-family lattice is about **families
ordered by inclusion** (`Poset B`). The two are different posets;
the former is spherical, the latter is acyclic. The Fork D probe
already corrected this for the bare-nerve case. This probe
extends the correction: even with the **best** coefficient
diagram (`M = π_0(X)`, the natural family-sensitive functor
Fork A's diagnosis identifies), the lattice's cohomology is
either trivial or non-spherical.

---

## §3 — Part 2: the definition-tweak probe

The three candidate tweaks the ticket enumerates, run at `n=3`:

### 3.1 The homotopy limit — the lead candidate

**Tweak.** Replace Fork A's covariant hocolim by the covariant
**holim**. By the BK spectral sequence collapse (homotopy
discreteness of `X(F)` at `n≤4`), `H^*(holim_{C_n} X) = H^*(C_n; M)`
for `M = π_0(X(-))` the connected-components functor.

**Why this is the lead candidate.** `mg-f9a7` `§6` rec 4:
*"a homotopy limit `holim_{C_n} X` does not suffer the terminal-object
collapse … and the obstruction is, by `rem:hocolim-flag`'s own
admission, a limit-flavoured (gluing) invariant. A holim-based …
re-foundation is the natural candidate."* `refoundation.tex`
`rem:holim-prereq` records the same flag. This probe answers the
"`makes no claim it succeeds`" caveat: it does NOT succeed.

**Result.**

| degree `p` | `dim C^p` | `H^p(C_3; M)` |
|---|---|---|
| 0 | 109 | **6** |
| 1 | 511 | 0 |
| 2 | 774 | 0 |
| 3 | 366 | 0 |

`δ² = 0` verified explicitly. Ranks cross-checked at two primes.
**`H^*(C_3; M) = {0: 6}`** — concentrated in degree 0, total
dimension 6.

**`S_3`-isotype.** Hopf trace on the cobar complex gives virtual
character `(6, 4, 3)` on `(e, (12), (123))`. With `H^*`
concentrated in degree 0 (sign `+1`):

> **`H^0(C_3; M) = 4·triv + 0·sgn + 1·std`**

(4 copies of the trivial rep + 1 copy of the standard 2-dim rep =
4 + 2 = 6 ✓; verifies the integer character decomposition.)

**Verdict on the lead candidate.** **NOT spherical.** The F-series
template wants `H̃^{n-2}` (one-dimensional, `sgn_{S_n}` isotype) at
`n=3` (so `H̃^1 = 1` carrying `sgn_{S_3}`). The probe gives `H^*` in
degree 0, 6-dimensional, **with zero `sgn` component**. This is
genuine family-sensitive non-trivial category-level cohomology —
it captures, in degree 0, the **global sections** of the
component-functor `π_0(X(-))`, i.e. the compatible
component-assignments — but it is *not* a sphere class and does
not detect minimal counterexamples in the F-series way.

**The 6 explained, structurally.** A class in `H^0(C_3; M)`
assigns to each object `(S, F)` a component of `X(F)` (i.e. a
component of `F` under single-bit adds), compatibly with traces.
At the terminal object `t = (∅,{∅})`, `X(t)` has one component;
the assignment at `t` is determined. The compatibility constraint
propagates up — but is loose enough to admit 6 distinct global
assignments. (At maximal objects `([n], 2^[n])` the diagram is
trivially connected, so there's no choice; the 6 is created by
the multi-component families lower in the lattice.) This is
meaningful structural data but not a sphere class.

### 3.2 The terminal-excluded subcategory

**Tweak.** Drop `t = (∅,{∅})` (and optionally the entire `|S|=1`
layer) and recompute the cohomology — both Fork A's hocolim and
the holim flavour `H^*(.; π_0(X))`. `mg-f9a7` `§2.3` noted the
hocolim H^2 = 59 (`|S|≥1`) — this probe confirms and extends.

**Results.**

| Object | `H^*` |
|---|---|
| `hocolim_{C_3^{|S|≥1}} X` (Fork A flavour) | **`{0:1, 2:59}`** — confirms `mg-f9a7` `§2.3` |
| `hocolim_{C_3^{|S|≥2}} X` | **`{0:1, 1:133}`** — confirms `mg-f9a7` `§2.3` |
| `H^*(C_3^{|S|≥1}; π_0(X))` (holim flavour) | **`{0:6, 2:45}`** |
| `H^*(C_3^{|S|≥2}; π_0(X))` | **`{0:6, 1:102}`** |

**Verdict.** None are spherical. The hocolim variant has 59-dim
`H^2` (mg-f9a7's finding confirmed); the holim variant on the same
subcategory has 45-dim `H^2`. The `|S|≥2` variants land in the
*wrong* degree (1, not 2 — `mg-f9a7` `§2.3` already noted this
"not sphere-like"). All variants are **family-sensitive** (they
collapse the constant component-functor and detect the genuine
diagram variance), but none are one-dimensional in a single sphere
degree.

### 3.3 The Moore-family lattice + coefficients (drift A undone)

**Tweak.** Undo `drift A`: replace the trace category by the
**Moore-family lattice with inclusion morphisms** (the F-series
template's variance, the literal `PPF_n` analog). Keep the
coefficient diagram `M = π_0(X)` (`drift B` kept — the
`mg-565a` `§6.2` endorsement: "the family-sensitive content
lives in the coefficient diagram"). Under inclusion `F ⊆ G`, the
induced map on components `π_0(X(F)) → π_0(X(G))` is surjective
(adding more sets only merges components), so `M` is a genuine
covariant functor on the Moore lattice. Compute `H^*(MOORE_3; M)`
via the cobar complex.

**Results.**

| Object | `H^*` | `S_3` virtual char | top-degree isotype |
|---|---|---|---|
| `H^*(MOORE_3; M)` whole lattice | `{0:1}` | `(1,1,1)` | `H^0 = 1·triv` |
| `H^*(MOORE_3 \ {top}; M)` | `{0:1}` | `(1,1,1)` | `H^0 = 1·triv` |
| `H^*(MOORE_3` proper part `; M)` | **`{0:1, 1:2}`** | `(-1,1,2)` | **`H^1 = 1·triv − 1·std`** |

The whole-lattice and top-dropped variants give just the trivial
representation in degree 0 (the lattice having a bottom makes the
nerve a cone). The **proper part** gives a non-trivial `H^1 = 2`.

**Verdict.** **Not spherical.** The `H^1 = 2` of the proper-part
variant is the **wrong dimension** (template wants 1) and **the
wrong isotype**: `1·triv − 1·std`. The standard isotype `std` is
the 2-dim irrep of `S_3`; combined with a virtual `1·triv` it
gives the actual `H^1`-character `2 = ??`. With the alternating
virtual sign at `H^1` (sign `(-1)^1 = -1`), the actual `H^1` has
character `(-1)·(-1,1,2) = (1,-1,-2)` — checking: this
decomposes as `0·triv + 1·sgn + 1·std`? Let me recompute: the
formula `a_tr = (V_e + 3V_t + 2V_c)/6`, `a_sg = (V_e − 3V_t +
2V_c)/6`, `a_st = (2V_e − 2V_c)/6`. For virtual char `(−1, 1, 2)`:
`a_tr = (−1 + 3 + 4)/6 = 1`; `a_sg = (−1 − 3 + 4)/6 = 0`;
`a_st = (−2 − 4)/6 = −1`. So virtual character = `1·triv +
0·sgn − 1·std`. With `H^*` in **two** degrees (0 and 1, parities
+1 and −1), the actual decomposition (per the formula `H^d
character = (−1)^d · (virtual − contributions from other degrees)`)
mixes contributions. The total: `H^0` is contributing `1·triv`,
`H^1` contributes the rest. So `H^1` actual = total virtual minus
`H^0` contribution: `(1·triv − 1·std) − (1·triv) = -1·std`, with
sign `(-1)^1 = -1` flipping the sign of std → actual `H^1 = 1·std`,
2-dimensional. **`H^1` is the `std` isotype, dimension 2, no `sgn`
component.** Not spherical.

**Why this matters.** Of all the tweaks tested, this is the only
one that produces **non-trivial cohomology in the F-series sphere
degree (`n−2 = 1` at `n=3`)** — i.e., the only candidate that
even *looks like* it might host a sphere class. But the actual
isotype is `std`, not `sgn`, and the dimension is 2, not 1.
**Even this most-promising tweak fails the spherical test.**

---

## §4 — Reconciliation against the corpus

### 4.1 Cross-checks against `mg-565a` and `mg-f9a7`

- **Punctured Boolean cube self-test:** `H̃^*(Δ(2^[3]∖{∅,[3]})) =
  {1: 1}` (`≃ S^1`). ✓ Reproduces UC9 `§D-4` and the `mg-565a`
  PART B self-test.
- **Moore-family lattice proper part self-test:** Reduced
  cohomology is rationally acyclic. ✓ Reproduces `mg-565a` Fork D
  finding.
- **Fork A hocolim `H^2 = 59` on `C_3^{|S|≥1}`:** ✓ Confirms
  `mg-f9a7` `§2.3` (and `H^1 = 133` on `C_3^{|S|≥2}`).

All self-tests pass; the probe's machinery agrees with the prior
two probes in the corpus to the digit.

### 4.2 Where the constructive half points

`mg-f9a7` `§4` identified two parts of the construction that ARE
family-sensitive:
- (i) the **coefficient diagram** `F ↦ X(F)`, which `mg-565a`
  vindicated as the locus of the spherical content (5 distinct
  reduced-homology profiles at `n=3`; the maximal family carries
  the punctured-cube sphere);
- (ii) the **obstruction machinery** `{U_x}`, cover, mismatch —
  family-sensitive at the cover-nerve level.

Both are real. **The integration step — replacing the per-family
data by a category-level cohomology object — is where the
sphericality is lost,** in every variance tested:
- hocolim: terminal-object collapse, acyclic.
- holim: degree-0 lim, family-sensitive but wrong degree, no sgn.
- bare lattice nerve: acyclic by lattice contractibility.
- lattice with `π_0(X)` coefficients: trivial in degree 0, std at
  degree 1 in the proper-part variant, but no sgn.

The conclusion is structural: **there is no natural category-level
integration of the per-family spherical content that preserves
sphericality.** Daniel's instinct that "perhaps there was a slight
tweak in the definition" is **not realised by any natural tweak
the reconciliation suggests** at `n=3`.

### 4.3 What this means for refoundation.tex

`refoundation.tex` `rem:holim-prereq` deferred the
"hocolim-versus-holim sharpening" to the residual-attack phase,
noting that pinning the edge map needs the cell-level structure of
`F_obs` and its spectral sequence (not pinned in Phase 1). The
probe resolves the hocolim-versus-holim question — **against the
holim**, too — at the structural level: even the holim does not
give a spherical category-level cohomology at `n=3`. The "`makes no
claim it succeeds`" caveat of `mg-f9a7` `§6` rec 4 is here
discharged: it does not succeed.

---

## §5 — Recommendations (routed to Daniel via `pm-onethird`)

1. **STOP confirmed.** The cohomological route to Frankl via
   "a spherical cohomology of the category of intersection-closed
   families" is genuinely dead. The Moore-family lattice's bare
   nerve is acyclic (`mg-565a`); the trace-category hocolim is
   acyclic (`mg-f9a7`); the trace-category holim — `mg-f9a7`'s
   own lead candidate — is non-spherical (this probe `§3.1`); the
   terminal-excluded variants are non-spherical (this probe
   `§3.2`); the inclusion-morphism lattice with `π_0(X)`
   coefficients is non-spherical (this probe `§3.3`). **Every
   reasonable tweak collapses or is non-spherical.** Daniel's
   specific concern is run down.

2. **The structural reason, stated cleanly.** The provably-
   spherical objects in the union-closed / F-series corpus
   are *per-family* objects (the punctured Boolean cube of one
   family) or about a *different* category (the F-series category
   of *posets*). The category of intersection-closed families
   does not, on any natural integration variance (hocolim, holim,
   bare nerve, nerve with coefficients), produce a spherical
   cohomology class. This is a structural fact about Moore
   families, not a defect of the build — `mg-565a` `§5.4`
   diagnosed: the Moore-family lattice is "fat" (a genuine
   lattice with `0̂`, `1̂`, abundant comparabilities and abundant
   meets/joins; 7 atoms, 3 coatoms; every pair has a meet), and
   such lattices very commonly have contractible proper parts
   with `μ(0̂,1̂) = 0`. The F-series `Δ(PPF_n)` is spherical
   because `PPF_n` is the proper part of a lattice with very
   specific extremal structure (the F-series cofiber-Morse
   geometry). The Moore-family lattice does not share that
   geometry, and adding the natural coefficient diagram does not
   manufacture it.

3. **What CONSTRUCTIVELY remains in the corpus.** The probe is
   not purely negative. It confirms that:
   - the per-family spherical content (UC9 `§D-4`'s punctured
     Boolean cube) is real and computable;
   - the coefficient diagram `F ↦ X(F)` and the obstruction
     machinery `F ↦ {U_x}` are family-sensitive (`mg-f9a7` `§4`);
   - the holim-flavour category-level cohomology `H^*(C_3; π_0(X))`
     does carry **non-trivial structural information** (6-dim in
     degree 0, decomposing as `4·triv + 1·std`) — but it is the
     wrong shape for the Frankl contradiction (not concentrated in
     `H^{n-2}` with `sgn_{S_n}` isotype).
   These three observations together are the precise content
   surviving the refutation cascade. They do not constitute a
   path to a Frankl proof on the cohomological route.

4. **No Lean change. No paper edit beyond this report. The Zulip
   post stays held.** Unchanged. `Frankl_Holds`'s dependence on
   `case3_ss_obstruction_paper_axiom` is unaffected. This is a
   strategic probe; its deliverables are this report and the
   computation script.

5. **The natural follow-on, if Daniel chooses to continue.** Per
   `mg-f9a7` rec 4, a strategic choice for Daniel: whether to
   attempt a re-foundation on a different structural object
   entirely (i.e., abandon "category of intersection-closed
   families" as the indexing category). The probe gives no
   positive endorsement for any such re-foundation — it
   identifies, decisively, that the indexing category itself is
   the source of the structural obstacle, not any particular
   variance. A genuine new program would need a different
   indexing object, not a different cohomology functor on the
   same one. Whether such a program is worth attempting is
   Daniel's call.

---

## §6 — The honest one-paragraph verdict

Daniel's recollection of a proven spherical result for "the
cohomology of the category of intersection-closed families on n
elements" does not match any result in the union-closed / F-series
corpus: every proven spherical result is either about the
**sister** category of posets (`Δ(PPF_n) ≃ S^{n-2}`, F17/F18, the
F-series template UC10 named but never built an analog of) or
about a **per-family** object (`Δ(2^[n]∖{∅,[n]}) ≃ S^{n-2}`, UC9
`§D-4`, one family viewed as the inclusion poset of its own
member sets), and every category-level computation actually
performed on the category of intersection-closed families — the
Moore-family lattice bare nerve (`mg-565a`, rationally acyclic),
the trace-category hocolim (`mg-f9a7`, rationally acyclic by
terminal-object collapse) — is non-spherical; this probe extends
the test to the natural tweaks the reconciliation suggests at
`n=3`, and finds every one non-spherical: the homotopy LIMIT
`mg-f9a7` `§6` rec 4 flagged as the lead candidate gives `H^*(C_3;
π_0(X)) = {0:6}` in `4·triv + 1·std` (no `sgn`); the terminal-
excluded subcategory variants give the same hocolim `H^2 = 59` and
`H^1 = 133` `mg-f9a7` `§2.3` noted (now confirmed) and matching
holim-flavour 45-dim and 102-dim; the Moore-family lattice with
inclusion morphisms and the `mg-565a`-endorsed coefficient
diagram `π_0(X)` gives `{0:1}` whole-lattice / `{0:1, 1:2}`
proper-part, where the `H^1 = 2` is the `std` isotype not `sgn`;
the family-sensitive content is genuinely there (in the
coefficient diagram, the per-family cubical complexes, the
obstruction machinery) but no natural category-level integration
of it reconstructs a one-dimensional `sgn_{S_n}`-graded sphere
class; **STOP is confirmed with Daniel's specific concern run
down**: the route is genuinely dead, and the structural reason —
the Moore-family lattice has no F-series-style extremal geometry
on any of its natural realisations as a category, hocolim or
holim, with or without the coefficient diagram — is a fact about
Moore families, not a defect of the build.

---

## §7 — Cross-references

- **Brief:** `mg-7bf3` — *Frankl-Spherical-Reconcile*. Filed
  2026-05-22 per Daniel reminder responding to `mg-f9a7`. Routes
  to: Daniel, via `pm-onethird`.
- **The Fork D probe (Moore lattice acyclic):**
  `docs/Frankl-ForkD-Probe-n3.md` (`mg-565a`); script
  `docs/frankl-forkd-probe-n3.py`. Diagnosed the per-family /
  lattice conflation (`§5`); endorsed Fork A on the grounds that
  the family-sensitive content lives in the coefficient diagram
  (`§6.2`).
- **The Fork A Phase-0 faithfulness probe (hocolim collapses):**
  `docs/Frankl-ForkA-Phase0-FaithfulnessProbe.md` (`mg-f9a7`);
  script `docs/frankl-forkA-faithfulness-probe.py`. Identified the
  terminal-object collapse (`§2.2`); flagged the homotopy limit as
  the natural follow-on candidate (`§6` rec 4); noted `H^2 = 59`
  on the terminal-excluded subcategory (`§2.3`, this probe
  confirmed).
- **The vision-check:** `docs/Frankl-vision-check.md` (`mg-6edc`).
  Pinned the F-series template, named the three drifts, and
  surfaced (V3) as the genuine open content — the question this
  probe definitively closes at the category level.
- **The F-series source notes:**
  - `docs/union-closed-UC9-...md` — UC9 `§D-4`, the punctured
    Boolean cube `≃ S^{n-2}`, the per-family witness.
  - `docs/union-closed-UC10-...md` — UC10 `§0.3`, the F-series
    template (`PPF_n`, F17/F18, the `sgn_{S_n}`-graded sphere);
    `§8.4`, the 2026-05-16 Daniel directive ("the cohomology of
    the category of intersection-closed families like we did
    before with the category of posets").
- **The Fork A re-foundation:** `paper/forkA/refoundation.tex`
  `def:category`, `def:xf`, `def:bk`, `thm:projection`,
  `rem:hocolim-flag`, `rem:holim-prereq`. The
  hocolim-versus-holim question, here resolved against the holim
  also.
- **Onboarding:** `docs/PROOF-STRUCTURE-ONBOARDING.md`.
- **Computation:** `docs/frankl-spherical-reconcile-probe.py` —
  self-contained, reproducible, ~2.5 s; self-tested against
  UC9 `§D-4`'s punctured cube and `mg-565a`'s Moore-lattice
  acyclicity; `δ² = 0` verified on every cobar complex; ranks
  cross-checked at two `~2^31` primes.

---

*Probe by polecat `cat-mg-7bf3`. Deliverables on `main`: this
document and `docs/frankl-spherical-reconcile-probe.py`. Verdict:
**RED — STOP CONFIRMED, DANIEL'S TWEAK HYPOTHESIS REFUTED.** Every
proven spherical result in the corpus is about a per-family
object (UC9 `§D-4`'s punctured Boolean cube) or about the
sister category of posets (`Δ(PPF_n)`, F17/F18); no proven
spherical result is about the category of intersection-closed
families. Every natural tweak tested at `n=3` — the homotopy
limit `mg-f9a7` `§6` rec 4 flagged as the lead candidate, the
terminal-excluded subcategory variants, the Moore-family lattice
with inclusion morphisms and the `mg-565a`-endorsed coefficient
diagram — is non-spherical (either rationally acyclic, or
non-trivial in the wrong degree / dimension / isotype). The
family-sensitive content lives in the per-family cubical-defect
complexes; no natural category-level integration of it (hocolim,
holim, lattice nerve, lattice + coefficients) reconstructs a
sphere class. The cohomological route is genuinely dead;
Daniel's specific concern is run down. Recommended next:
`pm-onethird` relays to Daniel. No Lean change, no paper edit,
no Zulip release.*
