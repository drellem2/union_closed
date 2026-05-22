# Frankl-ForkA-Fobs-SS-Pinning — pinning the `F_obs` cell-level spectral sequence (P0)

**Work item:** `mg-02b5` (Frankl-ForkA-P0). Per the `mg-0882`
residual-closing roadmap (`docs/Frankl-ForkA-Residuals-Roadmap.md`):
**P0 is the shared prerequisite that gates all seven Fork A
residuals** — it pins the cell-level Bousfield–Kan / spectral-sequence
model of the obstruction sheaf `F_obs` that the residual-attack phase
runs on. P0 is the construction the roadmap names as Checkpoint 0
(§1.3), ticket 1 of §6.

**P0 is NOT an eighth hypothesis of the conditional theorem.** The
`mg-bf5c` "exactly seven residuals" certification stands unchanged.
P0 is infrastructure for *closing* the residuals, not a residual.

**READ-FIRST consumed:** `docs/Frankl-ForkA-Residuals-Roadmap.md`
(`mg-0882` — the P0 scope in §1.3 and §6 ticket 1; the dependency
graph in §3 confirming P0 gates everything); `paper/forkA/refoundation.tex`
(the thrice-validated re-foundation — `def:obs-sheaf`, `def:ob`,
`rem:promotion`, `rem:holim-prereq`, `debt:faithful-localized`,
`rem:wrapper`, `def:bk`, `thm:welldefined`, `thm:projection`);
`docs/Frankl-ForkA-Phase2-Revalidation2.md` (`mg-bf5c` — the certified
residual list).

**Deliverable:** `paper/forkA/Fobs-spectral-sequence.tex` — a
standalone LaTeX document pinning the `F_obs` cell-level spectral
sequence — plus this ledger note. Math-before-Lean, the established
Fork A practice. The thrice-validated `refoundation.tex` is **not**
modified: P0 supplies the cell-level pinning that `refoundation.tex`'s
`rem:holim-prereq` explicitly defers ("the cell-level structure of
`F_obs` and its spectral sequence (not pinned here) … left … for the
residual-attack phase"). Deliverable lands on `main` (no branch
override). `pm-onethird` relays to Daniel.

---

## §0 — Verdict (top of page)

> **GREEN — FORK-A-P0-DELIVERED.** The `F_obs` cell-level spectral
> sequence is pinned: construction, convergence, and page structure,
> plus the cell-level `BK` comparison target. The residual-attack
> phase may now proceed on pinned foundations.
>
> P0 closes no residual, adds no hypothesis to `thm:contradiction`,
> and has **no RED-risk** — a construction equips a proof, it cannot
> refute one. The one structural finding it returned (the spectral
> sequence degenerates; the obstruction's non-triviality is carried
> entirely by residual R3) is GREEN news for the roadmap: it confirms
> and sharpens the `mg-0882` §4 make-or-break analysis rather than
> disturbing it.

### The P0 scorecard

| Component | Status | Note |
|---|---|---|
| Punctured trace poset `P` and trace cover `U` pinned | **GREEN** | `P = C_n(F⋆) ∖ {F⋆}` is the Boolean lattice minus its top; the cover `{U_x}` covers `P` by `prop:minimality`. |
| Cell-level obstruction complex `F_obs` pinned | **GREEN** | Supplies the definition `def:obs-sheaf` left implicit — a complex of presheaves, cell-level. |
| Čech double complex `Č^{*,*}(U;F_obs)` a genuine bicomplex | **GREEN** | `d²=0`, `δ²=0`, `dδ=δd` all verified; `D²=0`. |
| First-quadrant, bounded | **GREEN** | Supported in `0≤p≤n−2`, `0≤q≤n−1`. |
| Both spectral sequences; convergence | **GREEN** | Bounded ⟹ both converge strongly, finite-page degeneration. |
| Page structure `E₀,E₁,E₂` and differentials pinned | **GREEN** | Named `E₂^{p,q} = Č H^p(U; ℋ^q(F_obs))`; `d_r` bidegree `(r,1−r)`. |
| Trace cover cell-level acyclic; SS degenerates | **GREEN** | Every local nerve is a full simplex ⟹ `Č H^{>0} = 0`. |
| `H*(Tot Č)` computed | **GREEN** | `≅ ⊕_{(T,G)∈P} H*(X(G))`, an explicit cell-level sum. |
| Obstruction data `b̂_x`, `{m_xy}` located in the bigrading | **GREEN** | `b̂_x` at `(0,0)`; `{m_xy}` at `(1,0)`, a δ-cocycle and δ-exact. |
| Cell-level `BK` model of `H*(C_n;X)` as comparison target | **GREEN** | Pinned, with its own convergent bar-filtration SS. |
| The comparison map (R3a) constructed | **open — R3a** | P0 pins its endpoints, not the map. |
| Its degree-`n−1` behaviour (R3b) | **open — R3b** | Well-posed after P0. |
| Its injectivity (R3c) | **open — R3c** | Well-posed after P0; remains make-or-break. |

---

## §1 — What P0 was asked to do

The `mg-0882` roadmap (§1.3, §6 ticket 1) charges P0 with pinning:

1. the cell-level structure of the obstruction sheaf `F_obs` on the
   punctured trace poset `C_n(F⋆) ∖ {F⋆}`;
2. the Čech double complex `Č^{*,*}(U; F_obs)` and its spectral
   sequence with `E₂^{p,q} = Č H^p(U; ℋ^q(F_obs))`;
3. the cell-level Bousfield–Kan model of `H*(C_n;X)` against which the
   obstruction edge map (residual R3) is to be compared;

"construct it properly, with the convergence and the page structure
the residual-closing work needs." The deliverable
`paper/forkA/Fobs-spectral-sequence.tex` does exactly these three.

---

## §2 — What P0 delivered

### 2.1 The cell-level obstruction complex `F_obs`, pinned

`refoundation.tex`'s `def:obs-sheaf` *names* `F_obs` and writes the
Čech double complex `Č^{p,q} = ⊕ F_obs^q(U_σ)`, but does **not** pin
`F_obs^q(U)` as a complex of presheaves — the data needed to even
write the spectral sequence down. `rem:holim-prereq` is explicit that
this is deferred. P0 supplies it (`Fobs-spectral-sequence.tex`
Def. 3.1):

> `F_obs^q(V) := ⊕_{(T,G)∈V} C^q(X(G); Q)` — the cell-level cubical
> `q`-cochains of the per-family complexes over the objects of `V`,
> with internal differential `d` the cubical coboundary and
> restriction maps the projections.

The document records, honestly, the genuine modelling choice this
involves: the **cell-level presheaf** (above) versus the **genuine
sheaf** (trace-compatible families). The bias data `b̂_x` are sections
of the cell-level presheaf but **not** of the genuine sheaf (the
defect `b_x(G)` is not trace-invariant). The roadmap names the
cell-level model; P0 pins it, keeps the two models cleanly separated,
and locates their difference precisely at the comparison map — i.e. at
residual R3. Recording this choice *is* part of the pinning: blurring
it is what `rem:holim-prereq` warns "would repeat the Phase-1.5
failure mode."

### 2.2 The Čech double complex, a genuine bounded bicomplex

`Č^{*,*}(U; F_obs)` is constructed with both differentials (cubical
`d`, Čech `δ`) and verified a genuine bicomplex — `d²=0`, `δ²=0`,
`dδ=δd`, hence `D²=0` (Thm. 4.2). It is first-quadrant and **bounded**:
supported in `0≤p≤n−2`, `0≤q≤n−1` (Prop. 4.4). This is the
obstruction-side analogue of `thm:welldefined`, and strictly easier —
the Čech `δ` is a pure simplicial coboundary of projections; the trace
structure does *not* enter the bicomplex (it enters only the
comparison map of §8).

### 2.3 Both spectral sequences, with convergence and page structure

Both spectral sequences of the bicomplex are constructed (Def. 5.2).
**Convergence is unconditional** — it follows from boundedness alone
(Thm. 5.4): both abut to `H*(Tot Č)`, strongly, with finite-page
degeneration (`d_r=0` for `r≥n−1`, resp. `r≥n`). The page structure
is pinned explicitly (Thm. 5.6):

- `E₀^{p,q} = Č^{p,q}`, differential the cubical `d`;
- `E₁^{p,q} = Č^p(U; ℋ^q(F_obs))`, differential the Čech `δ`;
- **`E₂^{p,q} = Č H^p(U; ℋ^q(F_obs))`** — the page named by
  `rem:promotion` and the roadmap;
- `d_r` of bidegree `(r,1−r)`.

This is the "convergence and page structure the residual-closing work
needs": the residual phase may invoke `E₂ ⇒ H*(Tot Č)` as an
established, unconditional fact.

### 2.4 The cell-level `BK` comparison target

`H*(C_n;X) = H*(Tot BK)` is pinned as the comparison target (Def. 8.1),
together with its own convergent bar-filtration spectral sequence
`^bar E₂^{p,q} = H^p(C_n; ℋ^q(X)) ⇒ H^{p+q}(C_n;X)` (Prop. 8.2) — the
explicit cell-level structure of the object in which `ob(F⋆)` must
land (R3b) and within which R1/R2 analyse isotypes.

---

## §3 — The one finding: the spectral sequence degenerates

P0 returned one genuine structural finding (`Fobs-spectral-sequence.tex`
§6–7):

**The trace cover is cell-level acyclic.** A proper trace `(T,G)` lies
in the overlap `U_σ` exactly when every coordinate of `σ` is rare in
it, so the simplices of the cover's nerve through a fixed `(T,G)` are
precisely the subsets of the rare set `R(T,G)` — a full simplex, which
is contractible. Hence `Č H^p(U; G) = 0` for `p≥1` and any cell-level
coefficient presheaf (Thm. 6.2). Consequences:

- the `F_obs` spectral sequence **degenerates**: `E₂` is concentrated
  in the column `p=0`, `E₂ = E_∞`;
- `H^k(Tot Č) ≅ ⊕_{(T,G)∈P} H^k(X(G); Q)` (Cor. 6.4) — an explicit,
  completely cell-level object;
- the mismatch cocycle `{m_xy}` (at bidegree `(1,0)`) is **δ-exact
  within `F_obs`** — `{m_xy} = −δ{b̂_x}` — so its class in the `F_obs`
  spectral sequence is **zero**.

This is **not a defect and not a surprise**: it is exactly what
`rem:promotion` already says honestly ("`ob(F⋆)` is, in Phase 1, a
well-defined Čech *cocycle*; its promotion … is conditional on R3a and
R3b") and what `lem:cocycle` already records (`{m_xy} = δ⁰{b̂_x}`).

**The honest consequence (a sharpening of the wrapper-risk, not a
resolution).** Since the `F_obs`-internal Čech cohomology is acyclic,
it contributes **nothing** to the obstruction; the entire
non-triviality of `ob(F⋆)` is carried by the comparison map into
`H*(C_n;X)` — that is, by residual R3 (R3a existence, R3b degree, R3c
injectivity). This *sharpens* `rem:wrapper`: it shows the localization
of the wrapper-risk to R3c is **exhaustive** — there is no second,
`F_obs`-internal source of non-triviality a faithfulness analysis
might miss. Concretely it narrows the R3c attack surface: the residual
phase may take as *given* that the source of the edge map is the
explicit cell-level sum `⊕_{(T,G)∈P} H*(X(G))`, and that the only
question is the map out of it. **P0 does not resolve R3c.** R3c
remains the make-or-break residual with its pre-identified HIGH
RED-risk (`mg-0882` §4.2) fully intact.

---

## §4 — What stays open (and is not P0's to close)

P0 closes nothing on the residual list. It makes the following
well-posed and leaves them open:

- **R3a, R3b, R3c** — the comparison edge map's existence,
  degree-`n−1` landing, injectivity. P0 pins both endpoints of the map
  (the source `Č^{*,*}(U;F_obs)` on the punctured poset `P`, the
  target `BK` on the whole category `C_n`) and makes the object
  mismatch between them explicit; it constructs no map.
- **R2** — whether `ob(F⋆)` avoids the `sgn` isotype. The pinned
  structure equips this representation-theoretic question; it does not
  answer it.
- **R1a, R1b, R1c** — the `Y1`-A vanishing arc. P0 supplies the pinned
  spectral-sequence foundation `rem:holim-prereq` requires ("both
  attacks require first pinning the cell-level spectral sequence of
  `F_obs`"); it computes no cofiber.

Per the roadmap's dependency graph (§3), **Checkpoint 0 is now GREEN**:
with P0 delivered, the residual-attack tickets (R3a → R3b → R3c, R2,
R1c) may be dispatched on pinned foundations.

---

## §5 — P0 is infrastructure, not a hypothesis

P0 does not enlarge the conditional theorem. `thm:contradiction` of
`refoundation.tex` rests on exactly the seven residuals R1a, R1b, R1c,
R2, R3a, R3b, R3c, as certified by `mg-bf5c`; P0 adds no eighth. A
pinned spectral sequence is not an assumption the contradiction
depends on — it is the construction within which the seven residuals
are stated, attacked, and (the roadmap intends) closed. P0 has no
RED-risk: it equips the proof and cannot refute it.

---

## §6 — Cross-references

- **Brief:** `mg-02b5` (Frankl-ForkA-P0). **Routes to:** Daniel, via
  `pm-onethird`.
- **The roadmap that scopes P0:**
  `docs/Frankl-ForkA-Residuals-Roadmap.md` (`mg-0882`) — §1.3
  (Checkpoint 0), §3 (P0 gates everything), §6 ticket 1.
- **The deliverable:** `paper/forkA/Fobs-spectral-sequence.tex`.
- **The re-foundation P0 builds on:** `paper/forkA/refoundation.tex` —
  `def:obs-sheaf`, `def:ob`, `rem:promotion`, `rem:holim-prereq`,
  `debt:faithful-localized`, `rem:wrapper`, `def:bk`,
  `thm:welldefined`, `thm:projection`, `thm:contradiction`.
- **The certified residual list:**
  `docs/Frankl-ForkA-Phase2-Revalidation2.md` (`mg-bf5c`).
- **Onboarding:** `docs/PROOF-STRUCTURE-ONBOARDING.md`.

---

*P0 pinning by polecat `cat-mg-02b5`. Deliverable on `main`:
`paper/forkA/Fobs-spectral-sequence.tex` plus this ledger note. P0
pins the `F_obs` cell-level spectral sequence — construction,
convergence, page structure — and the cell-level `BK` comparison
target, so that R3a, R3b, R3c, R2, and R1 may be attacked on pinned
foundations. It closes no residual and adds no hypothesis to
`thm:contradiction`; the `mg-bf5c` "exactly seven residuals"
certification stands. One finding: the `F_obs` spectral sequence
degenerates and the obstruction's non-triviality is carried entirely
by residual R3 — a sharpening of the wrapper-risk localization, not a
resolution of it. Verdict GREEN for the P0 scope.*
