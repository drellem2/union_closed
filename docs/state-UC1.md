# Union-Closed Compatibility-Geometry — UC1 cumulative state ledger

**Ticket:** mg-f72a — UC1, the founding ticket of the `union_closed` product line.
**Branch:** `union-closed-UC1-manifesto-scoping`.
**Deliverables:** `docs/union-closed-compat-geom-manifesto.md` (the manifesto + feasibility assessment + the 1/3-2/3 ⟷ Union-Closed dictionary rigorized on the UC side); `docs/state-UC1.md` (this file — cumulative state ledger).
**Type:** Manifesto + feasibility scoping. Paper-and-pencil; no new axioms; no Lean; no computation. Multi-session-able, 250k cap. This ledger survives session boundaries; a future session re-checks the invariants below before extending.

---

## Verdict (current): AMBER-partial-transfer

The compatibility-geometry **framework transfers** to Frankl — the intrinsic object, the coordinate-transport involutions, and the balanced obstruction are all pinned (manifesto §1) — but it transfers **decoupled from both 1/3-2/3 proof engines**: mechanism (a) BK/Cheeger-expansion has its *setup* transfer cleanly but its *engine* fail (gaps E1–E3); mechanism (b) F-series cohomological does not transfer (gaps C1–C5). Union-Closed resonates with the *framework* of (a), the *engine* of neither, and has a native harmonic handle ($\beta_x$ = level-1 Walsh coefficient) belonging to neither. UC2 is scoped as a native construction (manifesto §8). AMBER not GREEN because the transfer is decoupled from both mechanisms; AMBER not RED because the framework-level transfer is genuine, load-bearing, and founds the product line.

---

## Session 1 — 2026-05-14 (polecat mg-f72a) — DONE

**Goal:** State the Union-Closed compatibility-geometry framework precisely; assess feasibility against BOTH 1/3-2/3 mechanisms (BK/Cheeger-expansion + F-series cohomological); scope the first concrete attack UC2 or state precisely why the analogy fails. Produce the manifesto + this ledger.

| Item | Status | Output |
|---|---|---|
| Read product-line context: `README.md` | ✅ | structural analogy + intrinsic-object expectation |
| Read cross-repo refs: mg-26fc (1/3-2/3 column rigorized), F10 (cohomological skeleton), F11 (route-(i) closed / triple map), `main.tex` (BK approach) | ✅ | the two reference mechanisms internalized |
| **§1 — framework stated precisely** | ✅ | intrinsic object pinned (cube $Q_n$ + transport graph $G(\mathcal F)$ + level-1 Walsh spectrum); 5 candidate objects enumerated with pros/cons; coordinate-transport involutions $\varphi_x=$ partial matchings $M_x$; transport identity $\beta_x=\lvert\mathcal F_x^{\mathrm{stuck}}\rvert-\lvert\mathcal F_{\bar x}^{\mathrm{stuck}}\rvert$; 4 union-closure structural lemmas; obstruction in 4 equivalent forms incl. the centroidal form; symmetry group split $S_n$ vs $(\mathbb Z/2)^n$ |
| **§3 — feasibility vs mechanism (a), BK/Cheeger-expansion** | ✅ | setup transfers cleanly (§3.1); engine fails — **E1** disconnected transport graph, **E2** no width-3 rigidity knob, **E3** no Theorem-E volume→conductance conversion |
| **§4 — feasibility vs mechanism (b), F-series cohomological** | ✅ | cathedral does not transfer — **C1** $\Delta(\mathcal F)$ wrong level, **C2** $\mathrm{UCF}_n$ doubly-exponential / no homology-sphere, **C3** wrong symmetry group, **C4** no substrate correspondence, **C5** no clean $n$-induction; §4.7 the surviving resonance + the Walsh bonus |
| **§5 — the dictionary, rigorized on the UC side** | ✅ | full table with ✓/◐/✗ per row; setup rows of (a) ✓, engine rows ✗, every (b) row ◐/✗, one new ✓ (the Walsh bonus) |
| **§6 — which mechanism does UC resonate with** | ✅ | three-layered answer: framework of (a) strongly, engine of neither, native harmonic structure belonging to neither; meta-thesis = descriptively faithful but machinery not inherited |
| **§7 — verdict** | ✅ **AMBER-partial-transfer** | with explicit why-not-GREEN and why-not-RED |
| **§8 — UC2 scoped** | ✅ | primary target = the native coordinate-transport deficiency question; fallbacks = Walsh/harmonic, $H^0$/component, square-defect; explicit "what UC2 must NOT do" |
| **§9 — references** | ✅ | cross-repo, this repo, Frankl literature, background, source directives |
| Deliverable 1 — `docs/union-closed-compat-geom-manifesto.md` | ✅ | written |
| Deliverable 2 — `docs/state-UC1.md` | ✅ | this file |
| Trust-surface impact | ✅ none | paper-and-pencil; no axioms, no Lean, no computation; 1/3-2/3 route-(ii) critical path untouched |

**Nothing left undone within UC1's scope.** All three ticket goals are discharged: (1) the framework is stated precisely (§1); (2) feasibility is assessed against *both* mechanisms with a per-gap verdict (§3, §4, §5, §6); (3) the first concrete attack UC2 is scoped (§8). The 250k cap was not approached — Session 1 used a small fraction. UC1 did not need to be multi-session; the ledger is kept per `feedback_polecat_cumulative_state_doc` in case the mayor reopens it.

---

## Invariants (reproduce-on-resume)

Load-bearing facts for any future session or for UC2; re-check against the manifesto before extending.

- **Intrinsic object.** The cube $Q_n$ is the ambient; $\mathcal F\subseteq Q_n$ is the state space; $G(\mathcal F)$ = the subgraph of $Q_n$ induced on $\mathcal F$ = the transport graph (exact analogue of $G_{\mathrm{BK}}(P)\subseteq$ permutahedron skeleton). The level-1 Walsh spectrum carries the obstruction. $\Delta(\mathcal F)$ (the README's pick) is the *internal* object — sibling of $G(\mathcal F)$, NOT the moduli analogue of $\Delta(\mathrm{PPF}_n)$.
- **Coordinate-transport involutions.** $\varphi_x=\sigma_x$ (toggle $x$), globally defined on $Q_n$, *partially* defined on $\mathcal F$ as the matching $M_x$ (the $x$-direction edges of $G(\mathcal F)$). Unmatched: $\mathcal F_x^{\mathrm{stuck}}$ (sets that *need* $x$), $\mathcal F_{\bar x}^{\mathrm{stuck}}$ (sets that *reject* $x$).
- **Transport identity.** $\beta_x=|\mathcal F_x|-|\mathcal F_{\bar x}|=|\mathcal F_x^{\mathrm{stuck}}|-|\mathcal F_{\bar x}^{\mathrm{stuck}}|$ — the matching $M_x$ contributes nothing to the bias; the bias is entirely the stuck-set imbalance.
- **Union-closure gifts (the lemmas that hold).** (1) $\mathcal F_x$ is a filter and union-closed. (2) $\mathcal F_{\bar x}$ is an ideal and is itself a union-closed family, with maximum $T_x=\bigcup\mathcal F_{\bar x}$. (3) the union map $u_W:\mathcal F_{\bar x}\to\mathcal F_x$, $A'\mapsto A'\cup W$ is well-defined but not injective; Frankl $\Leftrightarrow$ some $x$ admits an injection $\mathcal F_{\bar x}\hookrightarrow\mathcal F_x$. (4) if $x$ is in every set, $x$ is abundant — so in a counterexample $\mathcal F_x,\mathcal F_{\bar x}\neq\emptyset$ for all $x$.
- **Obstruction, 4 forms.** (O1) $a(x)<\tfrac12\ \forall x$; (O2) $|\mathcal F_x^{\mathrm{stuck}}|<|\mathcal F_{\bar x}^{\mathrm{stuck}}|\ \forall x$; (O3) every level-1 Walsh coefficient $\widehat{\mathbf 1_{\mathcal F}}(\{x\})>0$, i.e. $\beta_x=-2^n\widehat{\mathbf 1_{\mathcal F}}(\{x\})$; (O4) the centroid $c(\mathcal F)\in[0,\tfrac12)^n$ — Frankl says the centroid of a union-closed family cannot lie strictly in the small corner.
- **Mechanism (a) gaps.** E1: $G(\mathcal F)$ disconnected in general (witness $\mathcal F=\{\emptyset,\{1,2\}\}$) — no irreducible chain; BK-connectivity has no analogue. E2: no width-3 rigidity knob (Frankl is unrestricted); the cube has spectral gap only $2/n$; induced subgraphs arbitrarily worse. E3: no Theorem-E conversion volume-imbalance → conductance bottleneck (no rich-pair 2D-grid fibers).
- **Mechanism (b) gaps.** C1: $\Delta(\mathcal F)$ wrong level. C2: $|\mathrm{UCF}_n|\ge 2^{\binom{n}{\lfloor n/2\rfloor}}$ doubly-exponential — strictly worse than the super-exponential $|\mathrm{PPF}_n|$ that closed F-series route (i) in F11 §3; and no (H-Cox) homology-sphere analogue. C3: load-bearing symmetry is $(\mathbb Z/2)^n$/Walsh for the obstruction, not $S_n$/FI. C4: no refinement-cover↔decision substrate correspondence — the solid hinge of the 1/3-2/3 dictionary (mg-26fc §3.2) has no analogue. C5: no clean $n$-induction — ground-set inclusion acts the wrong way on the obstruction ($\iota\mathcal F$ counterexample iff $\mathcal F$ is), no multiplicativity law.
- **Resonance verdict.** Framework of (a): strong. Engine of (a) or (b): neither. Native structure (Walsh handle $\beta_x=-2^n\widehat{\mathbf 1_{\mathcal F}}(\{x\})$): belongs to neither 1/3-2/3 mechanism — this is where UC2's native engine should be built.

---

## Open threads / what a Session 2 (or UC2) would do

UC1's own scope is **complete** — nothing left undone. The forward work is UC2, scoped in manifesto §8:

- **UC2 primary** — the coordinate-transport deficiency question: structure theory of $(G(\mathcal F),\{M_x\},\text{stuck-sets})$; characterize the stuck-sets via union-closure (relation to join-irreducibles / lower covers); attack the injection $\mathcal F_{\bar x}\hookrightarrow\mathcal F_x$ via the union map $u_W$ and the $\{u_W\}$–$\{M_x\}$ interlock; test whether failure-to-globalize forces $\max_x\beta_x\ge0$.
- **UC2 fallbacks** — (F-i) the Walsh/harmonic route ("compatibility-geometrize Gilmer"); (F-ii) the $H^0(G(\mathcal F))$ component route; (F-iii) the square-defect cubical-complex $X(\mathcal F)$ route.
- **UC2 must NOT** — port Theorem E / Steps 1–7 (E1–E3 fatal); build a $\Delta(\mathrm{UCF}_n)$ chamber ambient (C2 fatal, dead by F11's own logic, sharper); assume $S_n$-isotypic machinery (C3). No new axioms, no Lean, no computation.

UC1 is independent of and does not touch the 1/3-2/3 route-(ii) critical path (`one_third_width_three` F16 / mg-f893).
