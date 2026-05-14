# Union-Closed Compatibility-Geometry — UC2 cumulative state ledger

**Ticket:** mg-a814 — UC2, the coordinate-transport deficiency question. **Parent:** mg-f72a (UC1).
**Branch:** `union-closed-UC2-transport-deficiency`.
**Deliverables:** `docs/union-closed-UC2-transport-deficiency.md` (the structure theory + the attack on the deficiency question); `docs/state-UC2.md` (this file — cumulative state ledger).
**Type:** Native structure theory + construction attempt. Paper-and-pencil; no new axioms; no Lean; no computation; no engine port. Multi-session-able, 350k cap. This ledger survives session boundaries; a future session re-checks the invariants below before extending.

---

## Verdict (current): GREEN-structure-theory

The structure theory of the coordinate-transport system $(G(\mathcal F),\{M_x\},\{\mathcal F_x^{\mathrm{stuck}},\mathcal F_{\bar x}^{\mathrm{stuck}}\})$ is **established** (manifesto-doc §2). The deficiency question's two further sub-deliverables — the injection attack (§3) and the meta-thesis forcing mechanism (§4) — are **both substantially advanced**, and the central question is sharpened to a single precise next step (§5). GREEN-structure-theory not GREEN-deficiency-resolved because the deficiency question is not resolved (the native results that resolve it — Theorem 3.5(2), Corollary 3.4 — reproduce the classically-known $m(\mathcal F)\le2$ / singleton cases); not AMBER because the structure theory is fully established and sub-deliverables 2 and 3 are both substantially advanced with named precise gaps, and one convergent next step is identified.

---

## Session 1 — 2026-05-14 (polecat mg-a814) — DONE

**Goal:** Establish the structure theory of the coordinate-transport system rigorously; attack the deficiency question (does union-closure forbid simultaneous transport-deficiency in every coordinate?) along the three sub-deliverables — characterize the stuck-sets, attack the injection, test the meta-thesis mechanism — or state a precise residual gap + which fallback to pursue. Native construction only; no engine port. Produce the structure-theory/attack doc + this ledger.

| Item | Status | Output |
|---|---|---|
| Merge UC1 manifesto into the working branch (foundation) | ✅ | `docs/union-closed-compat-geom-manifesto.md`, `docs/state-UC1.md` carried in; UC1 §1 objects internalized |
| **§2 — structure theory (sub-deliverable 1)** | ✅ | Thm 2.1 matched$=$covered (matched part $=$ axis-aligned single-step covers of $(\mathcal F,\subseteq)$ $=$ edges of $G(\mathcal F)$); Thm 2.2 $\mathcal F_{\bar x}^{\mathrm{stuck}}$ is an order ideal of $\mathcal F_{\bar x}$, $\mathcal F_{\bar x}^{\mathrm{match}}$ a filter, non-empty iff $T_x\cup\{x\}\in\mathcal F$ — $T_x$ controls the reject side; Thm 2.3 $\mathcal F_x^{\mathrm{stuck}}$ is the shapeless complement of a union-closed family (neither up nor down) — UC1's (D2) sharpened; Cor 2.4 join-irreducibles stuck in all-but-$\le1$ coordinates; Thm 2.5 global identity $\sum_x\beta_x=2\sum_A\lvert A\rvert-n\lvert\mathcal F\rvert$ with $G(\mathcal F)$ cancelling; the $v_A\in\{-1,0,+1\}^U$ vector picture |
| **§3 — the injection attack (sub-deliverable 2)** | ✅ | Prop 3.1 reduction to a stuck-to-stuck injection (matched parts cancel exactly); Lemma 3.3 fibres of $u_W$ $=$ $\mathcal F\cap[C\setminus W,C\setminus\{x\}]$, sub-families of cube-intervals of dim $\lvert W\rvert-1$; Cor 3.4 $\{x\}\in\mathcal F\Rightarrow x$ abundant (native); **Thm 3.5 trace-partition theorem** — $\sum_{x\in W}\beta_x=\sum_S\lvert\mathcal F^S\rvert(2\lvert S\rvert-\lvert W\rvert)$, the injection $\mathcal F^\emptyset\hookrightarrow\mathcal F^W$ controls the extremes, $\lvert W\rvert\le2\Rightarrow$ Frankl (native recovery of the classical small-set cases), $\lvert W\rvert\ge3$ leaves the intermediate trace-classes uncontrolled; §3.4 the two interlock mechanisms (I1) many-generators linear system, (I2) routing-through-$M_y$; Prop 3.6 Hall criterion |
| **§4 — the meta-thesis forcing mechanism (sub-deliverable 3)** | ✅ | Prop 4.1 full globalization $\iff\mathcal F=2^U$ ($\Rightarrow$ all $\beta_x=0$) — trivial extreme; Prop 4.2 one-sided square-defect (union-closure forbids missing-top squares); **Thm 4.3 orthogonality** — the unsigned globalization defect $\mathrm{Def}(\mathcal F)=n\lvert\mathcal F\rvert-2\lvert E(G(\mathcal F))\rvert$ cancels identically out of $\sum_x\beta_x$, so failure-to-globalize does NOT force $\max_x\beta_x\ge0$ as stated; §4.4 the forcing mechanism identified — union-closure's orientation of the defect via the §2 filter (reject side, capped by $T_x$) vs. non-filter (need side, shapeless, join-irreducible-supported) asymmetry — identified but not closed |
| **§5 — verdict + precise next step** | ✅ **GREEN-structure-theory** | central question localized to: control the intermediate trace-classes $\{\mathcal F^S:0<\lvert S\rvert<\lvert W\rvert\}$ of a minimal generator $W$, $\lvert W\rvert=m(\mathcal F)\ge3$; recommended UC3 route = fallback F-i (Walsh/harmonic), aimed at the sub-cube Walsh spectrum relative to a minimal generator; F-ii/F-iii remain available, now hooked into §§2–4 |
| **§6 — references** | ✅ | parent ticket / this repo, cross-repo dead-route material, Frankl literature, source directives |
| Deliverable 1 — `docs/union-closed-UC2-transport-deficiency.md` | ✅ | written |
| Deliverable 2 — `docs/state-UC2.md` | ✅ | this file |
| Trust-surface impact | ✅ none | paper-and-pencil; no axioms, no Lean, no computation; no engine port (E1–E3 / C1–C5 untouched); 1/3-2/3 route-(ii) critical path untouched |

**Nothing left undone within UC2's scope.** All three sub-deliverables are discharged: (1) the stuck-set structure theory is established; (2) the injection attack is pushed to the union map's structural ceiling, with the residual gap named precisely; (3) the meta-thesis mechanism is resolved to a precise statement (the naive "forcing" is ruled out by Thm 4.3; the candidate mechanism is identified). The 350k cap was not approached — Session 1 used a small fraction. UC2 did not need to be multi-session; the ledger is kept in case the mayor reopens it or commissions UC3.

---

## Invariants (reproduce-on-resume)

Load-bearing facts for any future session or for UC3; re-check against the manifesto-doc before extending. (UC1's invariants in `docs/state-UC1.md` remain in force; these are the UC2 additions.)

- **Matched $=$ covered (Thm 2.1).** $A\in\mathcal F_x^{\mathrm{match}}\iff A\setminus\{x\}\lessdot A$ in $(\mathcal F,\subseteq)$. So $M_x=$ {direction-$x$ edges of $G(\mathcal F)$} $=$ {axis-aligned single-step covering relations of the lattice}. The lattice can also have *long covers* ($\lvert A\setminus C\rvert\ge2$), which are in no $M_x$.
- **Reject side is an ideal, controlled by $T_x$ (Thm 2.2).** $\mathcal F_{\bar x}^{\mathrm{match}}$ is a filter of $\mathcal F_{\bar x}$ (union-closed); $\mathcal F_{\bar x}^{\mathrm{stuck}}$ is an order ideal of $\mathcal F_{\bar x}$; $\mathcal F_{\bar x}^{\mathrm{match}}\neq\emptyset\iff T_x\cup\{x\}\in\mathcal F$ (single membership test). The filter need not be principal.
- **Need side is shapeless (Thm 2.3).** $\mathcal F_x^{\mathrm{match}}$ is union-closed (has a max) but in general neither up nor down in $\mathcal F_x$; $\mathcal F_x^{\mathrm{stuck}}$ has no order shape. This is UC1's asymmetry (D2) sharpened — union-closure helps *adding* (reject side) but not *deleting* (need side).
- **Join-irreducibles (Cor 2.4).** Every join-irreducible of $\mathcal F$ is matched in at most one coordinate, stuck in all the rest. So $\mathcal F_x^{\mathrm{stuck}}$ always contains the join-irreducibles $j\ni x$ with lower cover $\neq j\setminus\{x\}$ — a union-closure-pinned core.
- **Aggregate identity (Thm 2.5).** $\sum_x\beta_x=2\sum_A\lvert A\rvert-n\lvert\mathcal F\rvert$; the transport-graph edge count $\lvert E(G(\mathcal F))\rvert$ cancels. Pure global counting cannot prove Frankl — confirmed natively.
- **Reduction (Prop 3.1).** Frankl $\iff$ for some $x$, an injection $\mathcal F_{\bar x}^{\mathrm{stuck}}\hookrightarrow\mathcal F_x^{\mathrm{stuck}}$. The matched parts inject for free via $M_x$.
- **Trace-partition theorem (Thm 3.5).** For $W\in\mathcal F$, $\lvert W\rvert=k$: $\sum_{x\in W}\beta_x=\sum_{S\subseteq W}\lvert\mathcal F^S\rvert(2\lvert S\rvert-k)$ with $\mathcal F^S=\{A:A\cap W=S\}$; the injection $j:\mathcal F^\emptyset\hookrightarrow\mathcal F^W$ gives $\lvert\mathcal F^\emptyset\rvert\le\lvert\mathcal F^W\rvert$; $k\le2\Rightarrow\sum_{x\in W}\beta_x\ge0$ (native recovery of the small-set cases); $k\ge3$ leaves $\sum_{0<\lvert S\rvert<k}\lvert\mathcal F^S\rvert(2\lvert S\rvert-k)$ uncontrolled.
- **Orthogonality (Thm 4.3).** The unsigned globalization defect $\mathrm{Def}(\mathcal F)=n\lvert\mathcal F\rvert-2\lvert E(G(\mathcal F))\rvert$ cancels out of $\sum_x\beta_x$. "Failure to globalize" is unsigned and does NOT force the signed $\max_x\beta_x\ge0$. The candidate forcing mechanism is union-closure's orientation of the defect (the §2 filter/ideal asymmetry) — identified, not closed.
- **One-sided square-defect (Prop 4.2).** Union-closure forbids exactly the 2-face patterns "$A_x,A_y\in\mathcal F$, $A_{xy}\notin\mathcal F$" — every upper wedge completes to its join. F-iii groundwork.

---

## Open threads / what a UC3 (or Session 2) would do

UC2's own scope is **complete**. The forward work, all converging on one object:

- **UC3 primary (recommended) — fallback F-i, the Walsh/harmonic route, localized.** Control the intermediate trace-classes $\{\mathcal F^S:0<\lvert S\rvert<\lvert W\rvert\}$ of a minimal generator $W$ with $\lvert W\rvert=m(\mathcal F)\ge3$ — equivalently the sub-cube Walsh spectrum of $\mathbf 1_{\mathcal F}$ relative to $W$. Show $\sum_{0<\lvert S\rvert<\lvert W\rvert}\lvert\mathcal F^S\rvert(2\lvert S\rvert-\lvert W\rvert)\ge-\lvert W\rvert(\lvert\mathcal F^W\rvert-\lvert\mathcal F^\emptyset\rvert)$. Gilmer's entropy method is the tool for the $m(\mathcal F)\ge3$ regime; UC2's contribution is the localization (aim F-i at the generator-relative sub-cube spectrum, not the level-1 spectrum in the abstract).
- **UC3 alternative — the interlock (I1).** Range $W$ over all minimal sets; each gives one linear inequality (3.1) among the trace-classes; ask whether union-closure makes the resulting linear system infeasible for a counterexample. Native partial-cube structure of $G(\mathcal F)$ read through the generators.
- **UC3 alternative — the interlock (I2).** Routing $u_W$-collisions through $M_y$; consistency governed by the Thm 2.3 need-side asymmetry.
- **Fallbacks F-ii / F-iii** — F-ii ($H_0(G(\mathcal F))$/component route) is the home of the Prop 3.6 Hall deficiency; F-iii (square-defect) is the higher-degree continuation of Prop 4.2. Both now have explicit hooks into §§2–4.

UC2 does not touch the dead routes (UC1 §8.4: E1–E3 / C1–C5) and is independent of the 1/3-2/3 route-(ii) critical path (`one_third_width_three` F17 / mg-4d3a — different repo, different polecat).
