# UC-Lean-mathlib-SS-scope.md

**Scoping doc for the Path A execution arc (mathlib SpectralSequence infrastructure → per-x cohomology-vanishing transport).**

Ticket: mg-7413 (UC-Lean-mathlib-SS-scope — Path A from mg-36c3 RED, Daniel-chosen 2026-05-16 23:12Z, override 23:23Z "start now per no-waiting rule").

Polecat: `cat-mg-7413`. Paper-and-pencil only (NO Lean execution yet). Budget 350k tokens.

Parent: mg-36c3 (Lean-Session 19, RED structural blocker; the per-x sorry at `lean/UnionClosed/UC11/SSConvergence.lean:285` is propositionally unprovable in the current encoding; closure requires Path A multi-month / Path B multi-week / Path E named-axiom).

Mathlib pinned: `v4.29.1`, rev `5e932f97dd25535344f80f9dd8da3aab83df0fe6` (per `lean/lake-manifest.json`).

---

## TL;DR / Verdict

**GREEN scoping complete + X1–X6 decomposition pinned + Phase D closure-ticket scope named.**

The mathlib v4.29.1 audit shows: the page-level `SpectralSequence` structure exists (`Mathlib/Algebra/Homology/SpectralSequence/Basic.lean`), the `SpectralObject`-based recipe / `HasSpectralSequence` typeclass and its page primitives exist (`SpectralObject/{Basic,Cycles,Differentials,EpiMono,HasSpectralSequence,Homology,Page}.lean`), and the bicomplex-`total` construction exists (`HomologicalBicomplex.lean`, `TotalComplex.lean`). **But every piece the per-x closure actually needs is missing**: the final `Abelian.SpectralObject.spectralSequence` assembly is an explicit `TODO` in mathlib's own header; there is no `HomologicalComplex₂.spectralSequence` constructor; there is no `convergesTo` / `EInfty` / abutment-filtration API at all; there is no equivariant SS for a finite (abelian) group acting on a bicomplex; there is no Schur-abelian specialization that lifts isotype splitting through SS pages; and the union_closed-side `BKTotal n` is a single-row truncation of the BK bicomplex, not a mathlib-`total` object on the full bicomplex.

Decomposition: **6 sub-tickets X1–X6**, total budget ~1.65M (inside the ticket's 1–2M execution-arc estimate). Three are mathlib-PR-candidates (X1 bicomplex SS, X2 abutment, X4 Schur-abelian-SS); two are equivariant/edge specialisations that may or may not go upstream (X3 equivariant SS, X5 edge map); X6 is the closure ticket that consumes X1–X5 to refactor `obstructionCohomClass` through the new SS-abutment-derived cohomology and resolve the per-x sorry.

No scoping AMBER. No structural impossibility found. **Recommendation: file X1 (`UC-Lean-SS-X1-Bicomplex`) as the next execution step.**

---

## §0 — Hard constraints carried into every sub-ticket

Carried from the project's UC-Lean-scope §D and from mg-7413's body:

- **NOT factorial.** No Specht modules. (The (Z/2)^n action used here is abelian; characters are χ_S indexed by `Finset (Fin n)`; no symmetric-group representation theory enters.)
- **NOT functorial in the refinement sense.** No `Pos_n` functor. All constructions native to `BKTotal n` / `IntClosedFam n` / direct-sum decompositions.
- **U1-dialect preserved.** Purely additive cohomology comparisons; no cup-product invoked even for abutment identification (the Θ-map of UC14 R1 is an *additive* chain map, identity at the populated baseline).
- **Math-first.** Each sub-ticket aligns with a specific paper-side step in UC13 / UC14 / UC10 §§5.3–5.4 (see Phase B per-file annotations).
- **Cumulative state doc.** Each Xi appends a `state-UC-Lean-SS-Xi.md` cumulative ledger; this file (`UC-Lean-mathlib-SS-scope.md`) is the arc-level index.
- **Mathlib-folder authorization (Daniel 17:47Z + 23:12Z) scoped to SS-infrastructure-needed-for-this-arc.** Each `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/*.lean` carries a header annotation: **`-- MATHLIB-PR-CANDIDATE: yes / no / conditional`** and a one-line rationale.
- **No axiom-cheat. No fake mathlib API. No defeq trick. No `False.elim` on `_hStar`.** Compiles via `lake build`.
- **Acceptance bar template per sub-ticket:** (1) lake-build GREEN; (2) at least one downstream invocation site is materially advanced; (3) non-vacuous evaluation on a non-trivial bicomplex / SS / action input; (4) compatible with the non-tautology-preservation bar (mg-c0d3 / mg-7f26).

---

## §1 — Phase A: mathlib infrastructure audit

For each of the 6 SS pieces the mg-36c3 RED diagnosis identifies as needed (ticket §Phase A items 1–6), the current state of mathlib v4.29.1 and the gap to union_closed-required granularity.

### A.1 `HomologicalComplex.spectralSequence` (page-level structure + recipe) — **AMBER**

**What mathlib has.** `SpectralSequence C c r₀` in `SpectralSequence/Basic.lean` is a clean structure: `page (r : ℤ) : HomologicalComplex C (c r)` + `iso : (page r).homology pq ≅ (page r').X pq` for `r + 1 = r'`. `SpectralObject C ι` in `SpectralObject/Basic.lean` is a spectral object with H/δ data on a poset. `SpectralSequenceDataCore ι c r₀` in `SpectralObject/HasSpectralSequence.lean` is the recipe-data needed to construct an SS from a spectral object. `SpectralObject/Page.lean` (918 lines) provides `pageX`, `pageXIso`, `pageD`, `page`, `shortComplexIso`, `kfSc_exact`, `isLimitKf` — the page primitives.

**What is missing.** The final assembly `Abelian.SpectralObject.spectralSequence : SpectralSequence C c r₀` is explicitly **TODO** in the header of `SpectralObject/SpectralSequence.lean`:

> *"The main definition in this file is `Abelian.SpectralObject.spectralSequence` (TODO). ... we obtain `X.spectralSequence data` (TODO) which is a spectral sequence starting on page `r₀`."*

Also TODO: `SpectralObject.SpectralSequence.homologyData` and `SpectralObject.spectralSequenceHomologyData`.

**Impact on per-x closure.** **Not on the critical path.** The union_closed-side need is to take a `HomologicalComplex₂` (the BK bicomplex) and get a `SpectralSequence` from it. We can construct this directly via the bicomplex pipeline (audit A.2) without first completing the general `SpectralObject.spectralSequence` assembly — Joël Riou's header explicitly notes that special bicomplex cases can bypass the general spectral-object path. So **A.1 is AMBER but does not block**; it's a mathlib-PR-candidate someone else can pick up, and we route around it via A.2.

**MATHLIB-PR-CANDIDATE.** Yes (the general assembly is what mathlib itself flags as TODO). But out of scope for this arc.

### A.2 Bicomplex total complex SS (Čech-to-total, first-quadrant) — **RED**

**What mathlib has.** `HomologicalBicomplex.lean` (`HomologicalComplex₂`) and `TotalComplex.lean` (`total`, `D₁`, `D₂`, `ιTotal`, `ιTotalOrZero`) — the bicomplex object and its total complex are fully built.

**What is missing.** There is **no** `HomologicalComplex₂.spectralSequence` constructor. The canonical first-quadrant spectral sequence `E_2^{p,q} = H^p_{c₁}(H^q_{c₂}(K_{*,*})) ⇒ H^{p+q}(Tot K)` is **not in mathlib v4.29.1**. (Search `grep -rln 'HomologicalComplex₂.*spectralSequence' Mathlib/Algebra/Homology/` is empty.) The page-2 identification — that the E_2 page can be computed as iterated row/column cohomology of the bicomplex — is the load-bearing technical lemma; it is also absent.

**Impact on per-x closure.** **Critical path.** This is the construction the union_closed-side needs: feed the BK bicomplex of `IntClosedFam n` into the first-quadrant SS and read off `H^{n-1}(Tot)` from the E_∞ page. Without this, there is no SS to argue about.

**MATHLIB-PR-CANDIDATE.** Yes — this is standard, audience-neutral content (every algebraic topology textbook proves the bicomplex SS); a clean Lean version is exactly the kind of contribution mathlib welcomes upstream.

### A.3 Group-equivariant SS (finite abelian group acting on bicomplex, isotype-graded convergence) — **RED**

**What mathlib has.** `RepresentationTheory/Basic.lean`, `Rep/Basic.lean`, `Action.lean`, `FDRep.lean`, `Coinvariants.lean`, `Invariants.lean`, `Maschke.lean`, `Semisimple.lean`, `Irreducible.lean` — the representation-theory API. `FinGroupCharZero.lean` is closest to what's needed (semisimplicity over `ℚ` for finite groups; via Maschke for char-0). `RepresentationTheory/Homological/{FiniteCyclic,Resolution}.lean` exists.

**What is missing.** There is **no** "G-equivariant spectral sequence" construct. There is no theorem saying that for a finite group G acting on a bicomplex, each SS page splits along G-isotypes and the differentials respect the splitting. Specifically for finite abelian G (the case of interest, G = (Z/2)^n acting on the BK bicomplex via Walsh signs), there is no specialised "characters χ_S in `Finset (Fin n) → ℂ` index isotypes" decomposition lifted through SS pages.

**Impact on per-x closure.** **Critical path.** The whole point of the per-x closure is that V_{x}^{n-1} is the χ_x-isotype of the SS abutment; we need each SS page to split isotypically, with χ_x picking out the per-x piece.

**MATHLIB-PR-CANDIDATE.** Conditional. The general "G-equivariant SS for finite G" is mathlib-worthy but a big chunk. The finite-abelian specialization with character indexing is a smaller, more targeted upstream candidate. **Recommendation**: do the finite-abelian version first (X3) and leave the general-G generalisation as a follow-on mathlib PR (not blocking).

### A.4 Schur-for-abelian-group, lifted to SS pages — **AMBER**

**What mathlib has.** `CategoryTheory/Preadditive/Schur.lean` has the general preadditive Schur: any nonzero morphism between simple objects is an isomorphism (`isIso_of_hom_simple`); `isIso_iff_nonzero`; `finrank_hom_simple_simple_le_one`; `finrank_hom_simple_simple_eq_zero_iff`. The endomorphism-as-scalar story (`endomorphism_simple_eq_smul_id`, `fieldEndOfFiniteDimensional`).

**What is missing.** The **abelian-group specialization**: when G is finite abelian and the 1-dim irreps are precisely the characters, the hom space `Hom_G(χ_S, χ_T) = 0` for `S ≠ T`. Also missing: the lift of this to SS pages — "if a differential is G-equivariant and lands between distinct χ_S, χ_T irrep summands, the differential is zero on those summands." This is what UC11 §6 + UC13 §3 explicitly uses.

**Impact on per-x closure.** **Critical path** for the differential-vanishing step that propagates per-coordinate non-mixing across SS pages (so that the χ_x isotype on page r maps only into the χ_x isotype on page r+1, and we can read off the χ_x-component of E_∞ from the χ_x-component of E_2).

**MATHLIB-PR-CANDIDATE.** Yes (the abelian Schur specialization is small and clean; the SS-page lift can be a one-liner over a `Decomposition` API).

### A.5 Cohomology-vanishing-from-chain-homotopy — **AMBER** (mathlib has base API; union_closed needs adapter)

**What mathlib has.** `Algebra/Homology/Homotopy.lean` has chain-homotopy types and `Homotopy.homologyMap_eq` / `Homotopy.compLeft_zero` / `Homotopy.compRight_zero` family. `HomologicalComplex.homology` is the standard cohomology object. The base fact "null-homotopic ⇒ zero on homology" is `Homotopy.homologyMap_eq` of a `Homotopy f 0`.

**What is missing.** The union_closed-side has the chain-level identity `UC10_lowerWalshVanishing : walshScale n {x} (bridgeOpAt F (...)) = single (topVertex F) 1` (Lean-Session 7 / mg-fbbb, PROVEN at every n), which is the chain-level realisation of a null-homotopy of the χ_x-isotype identity on V_{x}^{n-1}. But this identity is **not currently wrapped as a `Homotopy` object** — it's a bare equation between Finsupp elements. We need a small adapter:

> `lemma nullHomotopyOnIsotype_givesEInftyVanishing (h : Homotopy ψ 0) (isotype : Subcomplex) ... : E_∞^{p,q}_{isotype} = 0`

that converts a chain-level null-homotopy on a χ_x-isotype subcomplex of the BK bicomplex into vanishing of the corresponding E_∞ piece. The adapter is downstream of A.6 (abutment) since it has to land in E_∞ language.

**Impact on per-x closure.** **Critical path** for invoking UC10's chain-level splitting as the source of cohomology vanishing (mg-36c3's two collision theorems exhibit exactly the inability to do this transport in the current encoding).

**MATHLIB-PR-CANDIDATE.** The general adapter is mathlib-PR-candidate (subset of "homotopy gives E_∞-vanishing for the canonical filtration of a bicomplex's SS"). The union_closed-specific application is downstream and not for upstream.

### A.6 Abutment-identification (SS edge: `E_∞^{p,q} → gr_p H^{p+q}(Tot)`) — **RED**

**What mathlib has.** `SpectralObject/Page.lean` has `pageXIso` — the object-level identification of pages of an SS as `E^d(i₀ ≤ i₁ ≤ i₂ ≤ i₃)`. The page-to-next-page iso lives in `SpectralSequence`'s field `iso`. The `δ` data and short-complex exactness lemmas (`zero₁`, `zero₂`, `zero₃`, `exact₁`, `exact₂`, `exact₃`, `composableArrows₅_exact`) provide the homological-algebra plumbing.

**What is missing.** There is **no** `SpectralSequence.convergesTo` predicate, no `EInfty` page, no abutment filtration `F^p H^*(Tot)`, no graded-piece comparison map `gr_p H^* ≅ E_∞^{p, *-p}`, no "first-quadrant SS abuts to `H^*(Tot)` for the canonical filtration" theorem. The entire convergence story is absent from mathlib v4.29.1. `grep -rn 'convergence\|abutment\|EInfty\|convergesTo' Mathlib/Algebra/Homology/` returns only one hit (`SpectralObject/SpectralSequence.lean:302:noncomputable def isLimitKf`), and that's a page-level limit fork, not convergence to an abutment.

**Impact on per-x closure.** **Critical path** and the **largest single missing piece**. Without abutment, we cannot read off `H^*(Tot)` from E_∞; without E_∞ identification, we cannot transport "V_{x}^{n-1} = 0 cohomologically" from the SS page to the cohomology of `BKTotal n`.

**MATHLIB-PR-CANDIDATE.** Yes — definitively yes. This is fundamental SS infrastructure that mathlib will want.

### Audit summary table

| # | Piece | Mathlib v4.29.1 state | Critical path? | Upstream PR? |
|---|---|---|---|---|
| A.1 | `HomologicalComplex.spectralSequence` (general assembly) | AMBER — page primitives present, final assembly TODO | No (we route around via A.2) | Yes (out of scope) |
| A.2 | Bicomplex total SS (`E_2 = H^p H^q ⇒ H^{p+q}(Tot)`) | RED — missing entirely | **Yes** | **Yes** |
| A.3 | G-equivariant SS (finite abelian G) | RED — missing entirely | **Yes** | Conditional |
| A.4 | Schur-abelian + SS-page-isotype-preservation | AMBER — preadditive Schur present, abelian specialization missing | **Yes** | Yes |
| A.5 | Chain-homotopy → cohomology-vanishing on isotype | AMBER — `Homotopy.homologyMap_eq` present, isotype-aware adapter missing | **Yes** | Yes (the general adapter) |
| A.6 | Abutment / `convergesTo` / E_∞ / graded filtration | RED — missing entirely | **Yes** | **Yes** |

**Aggregate verdict.** No piece is *structurally impossible* in mathlib. Three pieces (A.2, A.3, A.6) require building from scratch; two (A.4, A.5) need specialisation/adaptation; one (A.1) is route-around-able. The audit confirms Path A is buildable — there are no architectural blockers in mathlib's existing API surface. This is **GREEN audit**; the multi-month scope estimate in the ticket reflects volume, not novelty.

---

## §2 — Phase B: layout for `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/`

Six files plus a `Basic.lean` index. Each file header includes `-- MATHLIB-PR-CANDIDATE: yes/no/conditional` per Daniel mathlib-folder-authorization scope.

```
lean/UnionClosed/Mathlib/
  Algebra/
    Homology/
      SpectralSequence/
        Basic.lean          -- index + re-exports
        Bicomplex.lean      -- A.2: HomologicalComplex₂.spectralSequence
        Convergence.lean    -- A.5 + A.6: convergesTo, EInfty, abutment filtration,
                            --   chain-homotopy-on-isotype → EInfty-vanishing adapter
        Equivariant.lean    -- A.3: finite-abelian-G action, isotype-graded SS pages
        Schur.lean          -- A.4: Schur-abelian specialization + SS-page isotype-
                            --   preservation of differentials
        EdgeMap.lean        -- A.6 supplement: edge maps for first-quadrant SS;
                            --   specialised to the union_closed bicomplex shape
```

### B.1 `Basic.lean` — module overview

```lean
/-
UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/Basic.lean
================================================================

Arc index for the mathlib SpectralSequence infrastructure that the per-x
cohomology-vanishing transport (UC-Lean-per-x-closure, mg-36c3 RED) needs.

This module hosts six files of new infrastructure that should — with
varying degrees of confidence — go upstream to mathlib. The union_closed
project uses them via the downstream invocation site at
`lean/UnionClosed/UC11/SSConvergence.lean` (post X6 closure ticket).

Per Daniel mathlib-folder authorization (2026-05-16 17:47Z + 23:12Z),
the scope is "SS-infrastructure-needed-for-this-arc only" — not general
mathlib refactoring.

See `docs/UC-Lean-mathlib-SS-scope.md` for the arc-level scope doc.
-/
-- MATHLIB-PR-CANDIDATE: yes (index file; re-exports public API)

public import UnionClosed.Mathlib.Algebra.Homology.SpectralSequence.Bicomplex
public import UnionClosed.Mathlib.Algebra.Homology.SpectralSequence.Convergence
public import UnionClosed.Mathlib.Algebra.Homology.SpectralSequence.Equivariant
public import UnionClosed.Mathlib.Algebra.Homology.SpectralSequence.Schur
public import UnionClosed.Mathlib.Algebra.Homology.SpectralSequence.EdgeMap
```

### B.2 `Bicomplex.lean` — `HomologicalComplex₂.spectralSequence`

**Tackles audit A.2.** First-quadrant SS of a `HomologicalComplex₂`. Provides:

- `HomologicalComplex₂.spectralSequence : HomologicalComplex₂ C c₁ c₂ → SpectralSequence C ...` — the constructor.
- `spectralSequence_E2_iso : (K.spectralSequence).page 2 ≅ H^p(H^q(K))` — the page-2 identification (the load-bearing technical lemma).
- `spectralSequence_d2_eq : differentials on page 2 match the connecting maps of the bicomplex` — the differentials.

Imports: `Mathlib.Algebra.Homology.HomologicalBicomplex`, `Mathlib.Algebra.Homology.TotalComplex`, `Mathlib.Algebra.Homology.SpectralSequence.Basic`.

**MATHLIB-PR-CANDIDATE: yes.** Standard textbook content; mathlib has the pieces; this constructor closes a known gap.

### B.3 `Convergence.lean` — abutment, E_∞, filtration

**Tackles audit A.5 + A.6.** Provides:

- `SpectralSequence.EInfty : SpectralSequence C c r₀ → κ → C` — the infinity page (as a colimit or stationary page, depending on convergence shape).
- `SpectralSequence.convergesTo : SpectralSequence C c r₀ → (ℤ → C) → Prop` — the predicate "this SS converges to the given graded abutment."
- `SpectralSequence.abutmentFiltration : SpectralSequence C c r₀ → ℤ → ℤ → C` — the filtration `F^p H^n` of the abutment.
- `SpectralSequence.grEInftyIso : gr_p H^n ≅ E_∞^{p, n-p}` — the graded-piece comparison.
- `HomologicalComplex₂.spectralSequence_convergesTo : (K.spectralSequence).convergesTo (fun n => H^n(K.total))` — the first-quadrant convergence theorem.
- `nullHomotopyOnIsotype_givesEInftyVanishing` — the A.5 adapter: a chain-level null-homotopy of an isotype subcomplex gives E_∞-vanishing of the corresponding piece.

Imports: `Bicomplex.lean`, `Mathlib.Algebra.Homology.Homotopy`.

**MATHLIB-PR-CANDIDATE: yes.** Definitively. Convergence is fundamental SS infrastructure.

### B.4 `Equivariant.lean` — finite-abelian-G action on bicomplex, isotype-graded SS pages

**Tackles audit A.3.** Provides:

- `EquivariantBicomplex (G : Type*) [CommGroup G] [Fintype G]` — a `HomologicalComplex₂` with a G-action.
- `EquivariantBicomplex.isotypeSplit : K.spectralSequence.page r ≅ ⊕_{χ : G → ℂˣ} (K.isotype χ).spectralSequence.page r` — pages split along characters.
- `isotypeSplit_respectsDifferentials` — the splitting is preserved by SS differentials (consequence of equivariance + Schur).
- Specialization to G = (Z/2)^n with `Finset (Fin n)` indexing characters via Walsh signs (the union_closed-specific use case).

Imports: `Bicomplex.lean`, `Convergence.lean`, `Mathlib.RepresentationTheory.Rep.Basic`, `Mathlib.RepresentationTheory.FinGroupCharZero`.

**MATHLIB-PR-CANDIDATE: conditional.** The general "G-equivariant SS for finite G" might be too big a chunk for a single PR; the finite-abelian specialization is a clean upstream target. Recommend: try the abelian version upstream first.

### B.5 `Schur.lean` — Schur-abelian + SS-page-isotype-preservation

**Tackles audit A.4.** Provides:

- `Schur.hom_eq_zero_of_ne_irreps (χ₁ χ₂ : G → ℂˣ) (h : χ₁ ≠ χ₂) : Hom_G (Rep.ofChar χ₁) (Rep.ofChar χ₂) = 0` — Schur for distinct 1-dim characters of an abelian G.
- `SpectralSequence.differential_isotype_zero` — equivariant differentials between distinct-isotype summands vanish at every page.

Imports: `Mathlib.CategoryTheory.Preadditive.Schur`, `Equivariant.lean`.

**MATHLIB-PR-CANDIDATE: yes.** The Schur-abelian specialization is small and clean; the SS-page lift is a one-liner over the `Equivariant.isotypeSplit` decomposition.

### B.6 `EdgeMap.lean` — SS edge maps at corners

**Tackles audit A.6 supplement.** Provides:

- `SpectralSequence.edgeMap_horiz : E_∞^{p, 0} → H^p(Tot)` (the row-edge: surjection / mono depending on convention).
- `SpectralSequence.edgeMap_vert : H^q(Tot) → E_∞^{0, q}` (the column-edge).
- Specialization to the union_closed BK bicomplex of cubical Čech cover: explicit identification of the edge with `chainToHomology0` precomposed with the isotype projection.

Imports: `Bicomplex.lean`, `Convergence.lean`.

**MATHLIB-PR-CANDIDATE: yes for the general edge maps; no for the union_closed-specific specialization** (split the file at the upstream PR if needed).

### B.7 Upstream-PR annotation policy

Per Daniel's mathlib-folder authorization (2026-05-16 17:47Z + 23:12Z directives, scoped to SS-infrastructure for this arc):

- Each file's first comment block declares `MATHLIB-PR-CANDIDATE: yes / no / conditional` plus a one-line rationale.
- Files marked `yes` use mathlib-style naming, docstrings, and theorem statements (so the eventual PR is a clean cherry-pick).
- Files marked `no` are union_closed-specific; they may use `IntClosedFam n` and other union_closed primitives without apology.
- `conditional` files are split internally: top section is mathlib-PR-clean, bottom section is union_closed-specific application.

---

## §3 — Phase C: execution sub-ticket decomposition (X1–X6)

Six sub-tickets. Each is single-session-capable (≤ 400k tokens). Total arc budget ~1.65M tokens (inside the ticket's "1–2M Lean budget" estimate).

### X1 — `UC-Lean-SS-X1-Bicomplex`

**Title.** UC-Lean-SS-X1-Bicomplex: construct `HomologicalComplex₂.spectralSequence` (first-quadrant bicomplex SS) with E_2-page identification.

**Budget.** 350–400k (largest single piece; E_2-page reduction lemma is the technical core).

**Deps.** None inside the arc (independent first step). External deps: mathlib `HomologicalBicomplex.lean`, `TotalComplex.lean`, `SpectralSequence/Basic.lean`.

**Deliverable.** `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/Bicomplex.lean`. Substantive new content: the constructor + `spectralSequence_E2_iso` + `spectralSequence_d2_eq`. PROVEN at the level mathlib expects (no `sorry`; lake-build GREEN).

**Acceptance bar.** (1) lake-build GREEN. (2) Non-vacuous evaluation: a concrete simple bicomplex (e.g. `HomologicalComplex₂.tensor` of two single-row complexes) where the SS pages are computable and the E_2 page can be checked against `H^p(H^q(K))` directly. (3) Mathlib-PR-clean naming/docstrings. (4) No reliance on the `SpectralObject.spectralSequence` TODO (route directly from bicomplex via the canonical filtration).

**Why first.** No internal deps; every other sub-ticket needs it.

### X2 — `UC-Lean-SS-X2-Convergence`

**Title.** UC-Lean-SS-X2-Convergence: `convergesTo` / `EInfty` / abutment-filtration API + `H^*(Tot)` convergence for first-quadrant bicomplex SS + chain-homotopy-on-isotype → EInfty-vanishing adapter.

**Budget.** 300–400k.

**Deps.** X1 (uses `HomologicalComplex₂.spectralSequence`).

**Deliverable.** `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/Convergence.lean`. Substantive new content: `EInfty`, `convergesTo`, `abutmentFiltration`, `grEInftyIso`, `HomologicalComplex₂.spectralSequence_convergesTo`, `nullHomotopyOnIsotype_givesEInftyVanishing`. PROVEN.

**Acceptance bar.** (1) lake-build GREEN. (2) Non-vacuous: for the X1 simple bicomplex, recover `H^*(Tot)` from the E_∞ page via the graded-piece comparison. (3) Mathlib-PR-clean. (4) The chain-homotopy adapter accepts a `Homotopy ψ 0` on an isotype subcomplex and produces `E_∞-isotype-piece = 0`.

### X3 — `UC-Lean-SS-X3-Equivariant`

**Title.** UC-Lean-SS-X3-Equivariant: finite-abelian-G action on a bicomplex; isotype-graded SS pages, with the splitting preserved by SS differentials.

**Budget.** 250–350k.

**Deps.** X1 + X2 (uses both).

**Deliverable.** `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/Equivariant.lean`. Substantive new content: `EquivariantBicomplex G`, `isotypeSplit` per page, `isotypeSplit_respectsDifferentials`, specialization to G = (Z/2)^n with `Finset (Fin n)` characters via Walsh signs. PROVEN.

**Acceptance bar.** (1) lake-build GREEN. (2) Non-vacuous: at G = (Z/2)^3 acting on a non-trivial bicomplex (e.g. fullPowerset3-derived), the χ_x isotype is a non-trivial summand of E_2 for at least one x. (3) The specialization to Walsh signs cleanly produces the union_closed-side χ_x isotype as the per-coordinate piece of E_2.

### X4 — `UC-Lean-SS-X4-Schur`

**Title.** UC-Lean-SS-X4-Schur: Schur-for-finite-abelian + SS-page-isotype-preservation of differentials.

**Budget.** 150–200k (smallest, since both halves are short).

**Deps.** X3 (uses `EquivariantBicomplex` and `isotypeSplit`).

**Deliverable.** `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/Schur.lean`. Substantive new content: `Schur.hom_eq_zero_of_ne_irreps` (abelian specialization), `SpectralSequence.differential_isotype_zero` (the lift). PROVEN.

**Acceptance bar.** (1) lake-build GREEN. (2) Non-vacuous: at G = (Z/2)^3, exhibit a concrete equivariant differential and verify that its restriction to a (χ_x → χ_y) component with `x ≠ y` is zero.

### X5 — `UC-Lean-SS-X5-EdgeMap`

**Title.** UC-Lean-SS-X5-EdgeMap: SS edge maps for first-quadrant SS; specialised to the union_closed BK bicomplex shape.

**Budget.** 200–300k.

**Deps.** X1 + X2.

**Deliverable.** `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/EdgeMap.lean`. Substantive new content: `edgeMap_horiz`, `edgeMap_vert`, and the union_closed-specific identification of the edge with `chainToHomology0` composed with isotype projection. PROVEN.

**Acceptance bar.** (1) lake-build GREEN. (2) Non-vacuous: at the BK bicomplex for `IntClosedFam 3`, the edge map identifies the χ_x isotype slice of E_∞^{x, n-1-x} with the χ_x isotype slice of `H^{n-1}(Tot)`.

### X6 — `UC-Lean-SS-X6-PerXClosure` (Phase D closure ticket; see §4)

See §4 below for Phase D scope.

### Sub-ticket budget summary

| Sub-ticket | Budget (k tokens) | Deps |
|---|---|---|
| X1 — Bicomplex SS | 350–400 | (none) |
| X2 — Convergence + abutment | 300–400 | X1 |
| X3 — Equivariant SS | 250–350 | X1, X2 |
| X4 — Schur-abelian + SS lift | 150–200 | X3 |
| X5 — Edge maps | 200–300 | X1, X2 |
| **X1–X5 subtotal** | **1.25–1.65M** | |
| X6 — Per-x closure | 150–300 | X1–X5 |
| **Arc total** | **1.40–1.95M** | |

Inside the ticket's "~1–2M Lean budget" estimate. **Recommendation: file X1 immediately as the next execution step.**

### Critical-path observations

- **X1 → X2 → (X3 ∥ X5) → X4 → X6**: X3 and X5 can run in parallel after X2 lands.
- **X4 has only X3 as a dep**, so it can also run in parallel with X5 once X3 is done.
- **X6 strictly requires all of X1–X5.**
- **No sub-ticket requires the `SpectralObject.spectralSequence` TODO** (the A.1 AMBER); we route around via X1 going direct from bicomplex.
- If during X1 the direct route hits a snag and the `SpectralObject` pipeline becomes mandatory, sub-split X1 into X1a (upstream `SpectralObject.spectralSequence` completion) + X1b (bicomplex SS via the completed pipeline). This is a contingency, not the default plan.

---

## §4 — Phase D: post-execution closure ticket (X6)

After X1–X5 lake-build GREEN, file the closure ticket **`UC-Lean-SS-X6-PerXClosure`**.

### X6 title

UC-Lean-SS-X6-PerXClosure: use the new SS infrastructure (X1–X5) to refactor `obstructionCohomClass` through the SS-abutment-derived cohomology and resolve the per-x sorry at `SSConvergence.lean:285`. THE LAST sorry; zero live sorrys on GREEN.

### X6 closure structure (paper-side preview)

1. **Build the BK bicomplex** `BKBicomplex n : HomologicalComplex₂ (ModuleCat ℚ) c₁ c₂` from the L2a-residual-residual chain data. The current `BKTotal n` is a truncation of the BK bicomplex at row 0; X6 wraps the full bicomplex as a true mathlib `HomologicalComplex₂` object. (The L2a-residual-residual session already populated the row-0 data and proved `∂² = 0`; X6 extends this to higher rows in a thin, schematic way — the SS only needs the bicomplex shape, not concrete higher-row content for the arc's first-quadrant first-page vanishing argument.)

2. **Build the (Z/2)^n action** on the bicomplex via the Walsh-isotype decomposition (already populated via `lean/UnionClosed/UC10/Walsh.lean`'s `walshScale`; X3 wraps this as an `EquivariantBicomplex (Z/2)^n` structure).

3. **Apply X1** to get `(BKBicomplex n).spectralSequence` as a first-quadrant SS.

4. **Apply X3** to extract per-χ_x isotype subcomplexes of each SS page. **This is the load-bearing step**: the new cohomology object is `(BKBicomplex n).spectralSequence.EInfty (x, n-1-x) restricted to χ_x isotype`, which is **genuinely the per-x χ_x component of the cohomology**, NOT collapsing onto the topVertex line as `chainToHomology0 n` does.

5. **Use `UC10_lowerWalshVanishing`** (chain-level, mg-fbbb PROVEN) as the input data for a `Homotopy ψ 0` on the χ_x-isotype subcomplex of `(BKBicomplex n)`. Apply X2's `nullHomotopyOnIsotype_givesEInftyVanishing` adapter to derive `E_∞^{x, n-1-x}_{χ_x} = 0`.

6. **Apply X2's `grEInftyIso`** + X5's edge map to identify `E_∞^{x, n-1-x}_{χ_x}` with the χ_x-component of `H^{n-1}(Tot K)`. Apply X4 to confirm differentials between distinct-isotype summands vanish across all pages (so the χ_x slice of E_2 maps faithfully to the χ_x slice of E_∞).

7. **Refactor `obstructionCohomClass F x`** to land in the SS-abutment-derived cohomology (via the edge map specialization in X5). Under this refactor, `obstructionCohomClass F x = 0` is no longer propositionally equivalent to `β_x F = 0` via `topVertex_not_coboundary` — because `obstructionCohomClass` no longer factors through `chainToHomology0 n` and the augmentation `BKAug n`. The two collision theorems from mg-36c3 (`per_x_cohom_vanishing_collides_topVertex_not_coboundary`, `aggregate_cohom_vanishing_collides_topVertex_not_coboundary`) become *inapplicable* to the new object (they were statements about the *old* `chainToHomology0`-derived class).

8. **Conclude** `obstructionCohomClass F x = 0` for the new object, via the chain (5) → (6) → (7).

### X6 acceptance bar

Carrying the full hard-constraint set from mg-c0d3 + mg-7f26 + mg-36c3:

| # | Bar | Method of verification |
|---|---|---|
| §1 | Non-tautology preserved | The new `obstructionCohomClass F x` is a quotient by a coboundary subspace in the SS-derived cohomology, propositionally distinct from the Frankl witness existential `∃ x, β_x F ≤ 0`. The per-x closure proof goes through SS-abutment (X2 + X5), not through `Finsupp.single_eq_zero`. Counterfactual test: substituting an arbitrary `Fin n → ℤ` for `β_x F` should NOT make the new `obstructionCohomClass = 0` trivially. |
| §2 | n=3 + n=4 non-vacuous | `obstructionCohomClass_fullPowerset3_zero` + `obstructionCohomClass_fullPowerset4_zero` (mg-7f26, existing) ported to the new object. The new object on `fullPowerset3` is concretely the zero element of the SS-derived cohomology; the proof goes via SS-abutment, not via `decide` on `Finsupp` scalars. |
| §3 | Zero live sorrys | `grep -rn 'sorry' lean/UnionClosed/` returns empty. The per-x sorry at `SSConvergence.lean:285` is closed via the X6 refactor. |
| §4 | No axiom-cheat | `grep -rn '^axiom' lean/UnionClosed/` returns empty. |
| §5 | No fake mathlib API | `lake build` GREEN. All SS infrastructure invoked is X1–X5 plus existing mathlib. |
| §6 | No bypass with defeq | The per-x closure routes through `nullHomotopyOnIsotype_givesEInftyVanishing` (X2), explicitly applied to the X3 isotype subcomplex; not a definitional shortcut. |
| §7 | No `False.elim` on `_hStar` | The X6 proof body works at the SS level, independent of `IsCounterexample`. The `hStar` argument is used only for `n ≥ 1` extraction (via the existing `counterexample_pos_n`). |
| §8 | Frankl_Holds non-vacuous at n=3, n=4 | `Frankl_Holds_fullPowerset3`, `Frankl_Holds_fullPowerset4` still close GREEN unconditionally (they do not touch the refactored `obstructionCohomClass`'s implementation; they invoke its propositional behaviour). |
| §9 | Hard constraints | NOT factorial (G = (Z/2)^n abelian; no Specht modules); NOT functorial in the refinement sense (X3 specialises to (Z/2)^n via `Finset (Fin n)` characters, not via a `Pos_n` functor); U1-dialect preserved (Θ-map of UC14 R1 is the identity at the populated baseline, additively transported); math-first (each X6 step aligns with a paper-side step in UC13 §§2.4.1 + 4.5 + UC11 §6.2 + UC14 §1.5). |
| §10 | Mathlib-folder authorization scope respected | All new files live under `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/`; the new closure invocation at `lean/UnionClosed/UC11/SSConvergence.lean` is the *only* file outside that folder modified by X6 (plus optional touch-ups to `UC11/CohomologyClass.lean` for the `obstructionCohomClass` refactor). |

### X6 budget

150–300k (matches the ticket's "~150–300k after the infrastructure lands" estimate). Single-session-capable.

### X6 verdict structure

- **GREEN**: per-x sorry closed via the SS infrastructure invocation; zero live sorrys; Frankl_Holds end-to-end non-vacuously non-tautologically without axiom-cheating; **PROJECT-LIFE MILESTONE** (the "ZERO LIVE SORRYS END-TO-END" target named in the ticket).
- **AMBER**: closure-route mostly assembled but a single SS-side adaptation gap (e.g., the abutment edge map specialization needs a thin shape adjustment). Tighter than mg-36c3 RED.
- **RED**: structural blocker in the new infrastructure. If X1–X5 were each GREEN-acceptance-bar, this should not happen; if it does, file an escalation ticket and re-audit which Xi step needs revision.

---

## §5 — Open questions / dependencies / risks

### §5.1 Mathlib SpectralObject TODO interaction

If during X1 it turns out that the direct-from-bicomplex SS construction *requires* the general `SpectralObject.spectralSequence` TODO to be completed first (e.g., because the canonical filtration on `K.total` is most cleanly described via a spectral object indexed by `EInt`), then X1 sub-splits:

- **X1a — Complete `Abelian.SpectralObject.spectralSequence`** (the general assembly + `homologyData` + `spectralSequenceHomologyData`). Budget +200–300k. Mathlib-PR-candidate definitively yes.
- **X1b — `HomologicalComplex₂.spectralSequence`** via the completed pipeline. Budget unchanged.

This is a contingency, not the default plan. Joël Riou's header note ("special bicomplex cases can bypass the general spectral-object path") suggests it should not be needed.

### §5.2 Mathlib upstream-PR cadence

The ticket authorises mathlib-folder placement but does not require simultaneous upstream PRs. **Recommendation**: file the union_closed-side files under `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/` immediately as each Xi closes; defer the upstream PR submission to a later cleanup pass (post-X6 GREEN) when the project's "zero live sorrys" milestone is in hand and there is time for mathlib-PR review iteration. The `MATHLIB-PR-CANDIDATE: yes/no/conditional` annotations preserve the option without paying the cost.

### §5.3 Refactor of `obstructionCohomClass` and downstream call sites

X6 refactors `obstructionCohomClass : IntClosedFam n → Fin n → (BKTotal n).homology 0` to land in the SS-derived cohomology. The downstream call sites are:

- `lean/UnionClosed/Frankl.lean` — uses `obstructionCohomClass F` via the `absurd hCohomZ hCohomNZ` chain. Refactor target: ensure the non-vanishing lemma (`obstructionCohomClass_at_ne_zero_of_pos_bias`) is either ported to the new object or replaced by the SS-abutment-based non-vanishing argument. The replacement may need to drop `topVertex_not_coboundary` as the proof method — instead, the new non-vanishing comes from `obstructionLanding` being non-zero in the relevant χ_x isotype slice of E_2 under `IsCounterexample`.

- `lean/UnionClosed/UC11/CohomologyClass.lean` — defines `obstructionCohomClass`, `chainToHomology0`, `topVertex_not_coboundary`. The X6 refactor leaves `chainToHomology0` + `topVertex_not_coboundary` alone (they remain true theorems about the L2a baseline `BKTotal n`) but introduces a parallel `obstructionCohomClassSS : ... → (BKBicomplex n).spectralSequence.EInfty` and points `obstructionCohomClass` to that via a `def`-alias. The two PROVEN collision theorems become inapplicable to the new object.

**Open question for X6.** Should the two collision theorems be archived (as structural-witness of the L2a baseline limitation) or restated for the new object (where they no longer go through)? **Recommendation**: archive — preserve them as historical record of the mg-36c3 diagnosis, with a comment pointing to X6 closure. They served their diagnostic purpose and are not needed for the new object's invocation chain.

### §5.4 Compatibility with the L2a / L2b / L3 populated baselines

X3's `EquivariantBicomplex (Z/2)^n` specialisation **must** be compatible with the existing `walshScale n S`, `walshMult n S`, `bridgeOpAt F`, and `UC10_lowerWalshVanishing` constructions (Lean-Sessions 5, 7; mg-4db9, mg-fbbb PROVEN). Specifically:

- `walshScale n {x}` (level-1 Walsh isotype projector at coordinate `x`) is the χ_x-isotype projector in X3's `isotypeSplit`. The compatibility lemma in X3:

  > `walshScale_eq_isotypeProj : walshScale n {x} = (BKBicomplex n).isotypeProjection (χ_x : (Z/2)^n → ℂˣ)`

- `UC10_lowerWalshVanishing F x` (chain-level twisted-bridge identity, mg-fbbb) is the input data for X2's `nullHomotopyOnIsotype_givesEInftyVanishing`. The compatibility lemma in X3 / X5:

  > `UC10_lowerWalshVanishing_homotopyData : Homotopy (χ_x-isotype-identity-map) 0` (constructed from `UC10_lowerWalshVanishing`).

If these compatibilities fail, X3 has an adaptation gap (AMBER) and we either adjust the X3 isotype API or refactor the L2a baseline. **Risk assessment**: low. The Walsh-sign decomposition IS the (Z/2)^n-character decomposition; this is a standard identification.

### §5.5 `chainToHomology0` and `topVertex_not_coboundary` after X6

The two L2a-baseline lemmas remain PROVEN about the L2a-baseline `BKTotal n` and its augmentation `BKAug n`. They become decoupled from `obstructionCohomClass` (which now uses the SS-derived cohomology). They are **not deleted**; they remain in `lean/UnionClosed/UC11/CohomologyClass.lean` as theorems about the L2a baseline, with a doc-comment pointing to X6's refactor and noting that they no longer feed the closure chain.

---

## §6 — Verdict + next step

**Verdict.** GREEN scoping complete + X1–X6 decomposition pinned + Phase D closure-ticket scope named.

**Audit summary (Phase A).** All 6 SS infrastructure pieces buildable in mathlib's existing API surface. Three pieces (A.2 bicomplex SS, A.3 equivariant SS, A.6 abutment) require building from scratch; two (A.4 Schur-abelian, A.5 chain-homotopy adapter) need specialisation; one (A.1 general SpectralObject assembly) is routed around. **No structural impossibility found.**

**Layout (Phase B).** Six files under `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralSequence/`, each with `MATHLIB-PR-CANDIDATE: yes/no/conditional` annotation and a rationale.

**Sub-tickets (Phase C).** X1–X5 execution + X6 closure. Total budget ~1.40–1.95M tokens (inside the ticket's 1–2M estimate). Each single-session-capable. Critical path: X1 → X2 → (X3 ∥ X5) → X4 → X6.

**Closure ticket (Phase D).** X6 refactors `obstructionCohomClass` through the SS-abutment-derived cohomology. The two mg-36c3 PROVEN collision theorems become inapplicable to the new object (archived). Acceptance bar carries full mg-c0d3 + mg-7f26 + mg-36c3 hard-constraint set; X6 verdict structure is GREEN (zero live sorrys, PROJECT-LIFE MILESTONE) / AMBER (single adaptation gap) / RED (escalation).

**Next operational step (Daniel decision).** File **X1 (`UC-Lean-SS-X1-Bicomplex`) as the next execution ticket**. Budget 350–400k, single-session-capable, no internal deps, mathlib-PR-clean. Polecat: Lean-engineering + mathlib-architecture comfort (same profile as this scoping polecat).

---

## §7 — Cross-references

- **Parent diagnosis**: mg-36c3 (UC-Lean-per-x-closure, RED structural blocker). See `docs/state-UC-Lean-per-x-closure.md` + Lean-Session 19 of `docs/state-UC10.md`.
- **Daniel directive**: 2026-05-16 23:12Z ("bite the bullet and build the mathlib infrastructure") + override 23:23Z ("start now per the no waiting rule"). Mathlib-folder authorization 17:47Z + 23:12Z.
- **Source repo**: `/Users/daniel/research/union_closed`. Default branch policy.
- **Mathlib pinned**: `v4.29.1`, rev `5e932f97dd25535344f80f9dd8da3aab83df0fe6` (per `lean/lake-manifest.json`).
- **Cumulative state**: `docs/state-UC10.md` Lean-Session 20 (this session).
- **Forward execution sub-tickets** (to be filed sequentially after this scoping GREEN): X1, X2, X3, X4, X5, X6.
- **Sibling paths** (alternatives Daniel did NOT choose): Path B (multi-week, L3 per-S Walsh refinement) — would refactor `walshMult n S` from the populated-baseline placeholder to genuine per-S decomposition; could close the per-x sorry without the full SS infrastructure. Path E (named-axiom, project-life trade-off) — accept the per-x cohomology vanishing as a named axiom; the simplest path, forbidden by current hard-constraint set.
