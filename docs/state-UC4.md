# Union-Closed Compatibility-Geometry — UC4 cumulative state ledger

**Ticket:** mg-0bf7 — UC4, the large-fibre residual + the I1 interlock (fallback F-i, UC3-localized). **Parent:** mg-cfc0 (UC3). **Chain:** mg-f72a (UC1) → mg-a814 (UC2) → mg-cfc0 (UC3) → mg-0bf7 (UC4).
**Branch:** `polecat-cat-mg-0bf7`.
**Deliverables:** `docs/union-closed-UC4-large-fibre-residual.md` (the large-fibre residual attack + the I1 interlock assembly); `docs/state-UC4.md` (this file — cumulative state ledger).
**Type:** Native construction — Walsh/harmonic analysis on the cube. Paper-and-pencil; no new axioms; no Lean; no computation; no engine port. Multi-session-able, 350k cap. This ledger survives session boundaries; a future session re-checks the invariants below before extending.

---

## Verdict (current): GREEN-partial

The UC4 large-fibre residual is **substantially advanced and closed on structured sub-cases**, and the **I1 interlock is assembled** as an explicit linear system. Core: the per-generator target decomposes natively and finitarily as $\sigma(W)=\sum_{x\in W}\beta_x=Q(W)-D(W)$, where $Q(W)\ge 0$ unconditionally (the monotone part — aggregate level-1 weight of the cumulative-fibre profile $q_S=|\widetilde{\mathcal R}_S|$) and $D(W)$ carries the entire residual (the defect part — aggregate level-1 weight of the order-ideal-structured trace-defect profile $d_S=|\widetilde{\mathcal R}_S\setminus\mathcal R_S|$). Residual closes iff $D(W)\le Q(W)$ (sufficient: $D(W)\le 0$); proven $\le 0$ on the $W$-monotone and low-defect sub-classes; named explicitly at the $k=3$ frontier. Phase 2: $\sum_{W\in\mathcal W}\sigma(W)=\sum_x\deg_{\mathcal W}(x)\beta_x$ relaxes the per-generator requirement to the single global inequality $\sum_W D(W)\le\sum_W Q(W)$.

GREEN-partial not GREEN-residual-closed/GREEN-phase1 because neither the per-generator nor the global residual is fully closed (and a single-$W$ closure at $k=3$ would prove Frankl on the open $m(\mathcal F)=3$ frontier). Not AMBER-residual-stalls because the route does not stall: $Q(W)\ge0$ is closed unconditionally and natively, the residual is isolated into one explicitly-structured scalar, two new native sufficient conditions are proven, the frontier residual is named in closed form, and the I1 interlock is assembled with a genuine relaxation (global vs. per-generator).

---

## Session 1 — 2026-05-14 (polecat mg-0bf7) — DONE

**Goal:** Phase 1 — close the large-fibre residual for a fixed minimal generator $W$ ($|W|=m(\mathcal F)=k\ge3$), using UC3's three named structural inputs (graded union law, minimality grading, ideal/filter structure of $\mathcal R_W$). Phase 2 — assemble the UC2 interlock I1: range $W$ over all minimal generators, couple the per-generator inequalities into a linear system. Native construction only (fallback F-i, UC3-localized); no engine port. Produce the residual/interlock doc + this ledger.

| Item | Status | Output |
|---|---|---|
| Carry UC1 + UC2 + UC3 docs into the working branch (foundation) | ✅ | UC1/UC2/UC3 docs + state ledgers present on branch; UC3 §2 toolkit (graded union law, universal fibre inclusion, dual reduction, minimality grading), §3.6 residual + 3 inputs, §5 UC4 target internalized; UC2 §3.4 (I1 mechanism) internalized |
| **§1 — the engine: monotone aggregate-sign lemma** | ✅ | **Lemma 1.1** $g$ monotone non-decreasing $\Rightarrow\langle g,\phi\rangle=\sum_S g(S)(2|S|-k)\ge0$ (one-line telescoping: $\langle g,\phi\rangle=\sum_x\sum_{S\not\ni x}(g(S\cup x)-g(S))$); **Cor 1.2** filters $\Phi\ge0$, ideals $\Phi\le0$; **Ex 1.3** $\Phi([S_0,W])=2^{k-|S_0|}|S_0|$ |
| **§2 — Phase 1 core: the up-closure decomposition** | ✅ | **Lemma 2.1** cumulative fibre $\widetilde{\mathcal R}_S=\bigcup_{S_0\subseteq S}\mathcal R_{S_0}$ is union-closed, $\subseteq\mathcal R_W$, monotone in $S$, $\widetilde{\mathcal R}_\emptyset=\mathcal R_\emptyset$, $\widetilde{\mathcal R}_W=\mathcal R_W$; **Thm 2.2** $q_S=|\widetilde{\mathcal R}_S|=\#\{R:S\in\mathcal S(R)^\uparrow\}$, $Q(W)=\langle q,\phi\rangle=\sum_R\Phi(\mathcal S(R)^\uparrow)\ge0$; **Cor 2.3** $\sigma(W)=Q(W)-D(W)$, $d_S=q_S-p_S=|\widetilde{\mathcal R}_S\setminus\mathcal R_S|\ge0$, $d_\emptyset=d_W=0$; closes iff $D(W)\le Q(W)$, suff. $D(W)\le0$; **Lemma 2.4** $\mathcal R_S$ an order filter of $\widetilde{\mathcal R}_S$, defect $\mathcal D_S$ an order ideal (UC3 input 3) |
| **§3 — closing the residual: structured sub-cases + named residual** | ✅ | **Thm 3.1** $W$-monotone $\mathcal F$ ($A\subseteq A'\subseteq A\cup W\Rightarrow A'\in\mathcal F$) $\Rightarrow d\equiv0$, $\sigma(W)=Q(W)\ge0$; **Thm 3.2** low-defect ($d_S=0$ for $|S|>k/2$) $\Rightarrow D(W)\le0$; **§3.3** named residual $D(W)\le0$ / exact $D(W)\le Q(W)$; **Prop 3.4** $k=3$: $D(W)\le0\iff\sum_{|S|=2}d_S\le\sum_{|S|=1}d_S$, $d_{\{x\}}=|\mathcal R_\emptyset\setminus\mathcal R_{\{x\}}|$; **Ex 3.5** $W$-monotone worked example ($d\equiv0$, $\sigma=7$); **Ex 3.6** $D(W)=2>0<Q(W)=7$ — sufficient $\ne$ necessary; **§3.6** complementary to UC3 per-fibre Thm 3.3 / bounded-spread Thm 3.5 |
| **§4 — Phase 2: the I1 interlock, assembled** | ✅ | **Thm 4.1** interlock identity $\sum_W c_W\sigma(W)=\sum_x(\sum_{W\ni x}c_W)\beta_x$; incidence operator $M:\mathbb R^U\to\mathbb R^{\mathcal W}$; **Thm 4.2** I1 interlock — $\sum_W D(W)\le\sum_W Q(W)$ (suff. $\le0$) $\Rightarrow$ some $\beta_x\ge0$; relaxes per-generator $\to$ global; weighted form; **Lemma 4.3** generator cross-incidence $W'\setminus W\in\mathcal R^W_{W'\cap W}\subseteq\mathcal R_W$, $|W'\setminus W|=k-|W\cap W'|$; **§4.4** Phase-2 residual named; **§4.5** $Q$ = decoupled-visible part, $d$ = coupling-only part — structurally past the Sawin ceiling |
| **§5 — verdict + precise next step** | ✅ **GREEN-partial** | UC4 residual named (per-generator $D(W)\le Q(W)$ + global $\sum_W D(W)\le\sum_W Q(W)$); continuation route = exploit cross-$S$ coupling (graded union law) + cross-generator symmetry (Lemma 4.3); F-ii/F-iii hooks recorded |
| **§6 — references** | ✅ | parent chain (UC1/UC2/UC3), cross-repo dead-route material, Frankl literature, source directives |
| Deliverable 1 — `docs/union-closed-UC4-large-fibre-residual.md` | ✅ | written |
| Deliverable 2 — `docs/state-UC4.md` | ✅ | this file |
| Trust-surface impact | ✅ none | paper-and-pencil; no axioms, no Lean, no computation; no engine port (E1–E3 / C1–C5 untouched); 1/3-2/3 critical path untouched |

**What is proven vs. open.** *Proven:* Lemmas 1.1, 2.1, 2.4; Theorems 2.2 ($Q(W)\ge0$ unconditional), 3.1, 3.2, 4.1, 4.2; Corollaries 1.2, 2.3; Proposition 3.4; Lemma 4.3. *Open (named residuals):* the general per-generator $D(W)\le Q(W)$ (Phase-1 residual) and the global $\sum_W D(W)\le\sum_W Q(W)$ (Phase-2 residual). The 350k cap was not approached — Session 1 used a small fraction.

---

## Invariants (reproduce-on-resume)

Load-bearing facts for any future session. UC1/UC2/UC3 invariants (`docs/state-UC1.md`, `state-UC2.md`, `state-UC3.md`) remain in force; these are the UC4 additions.

- **Setup.** Fix minimal generator $W$, $|W|=m(\mathcal F)=k\ge3$, $U'=U\setminus W$. $A=S\sqcup R$, $\mathcal R_S=\{R:S\sqcup R\in\mathcal F\}$, $p_S=|\mathcal R_S|$, co-fibre $\mathcal S(R)=\{S:S\sqcup R\in\mathcal F\}$. $\Phi(\mathcal G)=\sum_{S\in\mathcal G}(2|S|-k)$, $\langle g,\phi\rangle=\sum_S g(S)(2|S|-k)$. Target $\sigma(W)=\sum_{x\in W}\beta_x=\langle p,\phi\rangle=\sum_R\Phi(\mathcal S(R))$.
- **Monotone aggregate-sign lemma (Lemma 1.1).** $g:2^W\to\mathbb R$ monotone non-decreasing $\Rightarrow\langle g,\phi\rangle\ge0$; non-increasing $\Rightarrow\le0$. Proof: $\langle g,\phi\rangle=\sum_{x\in W}\sum_{S\not\ni x}(g(S\cup x)-g(S))$. Corollary: filters have $\Phi\ge0$, ideals $\Phi\le0$; $\Phi([S_0,W])=2^{k-|S_0|}|S_0|$.
- **Cumulative fibre (Lemma 2.1).** $\widetilde{\mathcal R}_S:=\bigcup_{S_0\subseteq S}\mathcal R_{S_0}$ is union-closed on $U'$, $\widetilde{\mathcal R}_S\subseteq\mathcal R_W$, monotone in $S$, $\widetilde{\mathcal R}_\emptyset=\mathcal R_\emptyset$, $\widetilde{\mathcal R}_W=\mathcal R_W$. Uses graded union law (union-closed) + universal fibre inclusion ($\subseteq\mathcal R_W$).
- **Up-closure decomposition (Thm 2.2 / Cor 2.3).** $q_S:=|\widetilde{\mathcal R}_S|$ is monotone; $q_S=\#\{R\in\mathcal R_W:S\in\mathcal S(R)^\uparrow\}$; $Q(W):=\langle q,\phi\rangle=\sum_R\Phi(\mathcal S(R)^\uparrow)\ge0$ **unconditionally**. $d_S:=q_S-p_S=|\widetilde{\mathcal R}_S\setminus\mathcal R_S|\ge0$, $d_\emptyset=d_W=0$. $D(W):=\langle d,\phi\rangle$. **$\sigma(W)=Q(W)-D(W)$; closes iff $D(W)\le Q(W)$; sufficient $D(W)\le0$.** Dually $D(W)=\sum_R\Phi(\mathcal D(R))$, $\mathcal D(R)=\mathcal S(R)^\uparrow\setminus\mathcal S(R)$ (co-fibre non-monotonicity defect).
- **Relative filter structure (Lemma 2.4).** $\mathcal R_S$ is a semigroup ideal hence order filter of $\widetilde{\mathcal R}_S$; defect $\mathcal D_S=\widetilde{\mathcal R}_S\setminus\mathcal R_S$ is an order ideal of $\widetilde{\mathcal R}_S$. (UC3 structural input 3, sharpened to every cumulative fibre.) From the graded union law $\mathcal R_{S_0}\vee\mathcal R_S\subseteq\mathcal R_S$ for $S_0\subseteq S$.
- **Sufficient conditions (Thms 3.1, 3.2).** $W$-monotone ($A\in\mathcal F,\ A\subseteq A'\subseteq A\cup W\Rightarrow A'\in\mathcal F$) $\Rightarrow d\equiv0\Rightarrow\sigma(W)=Q(W)\ge0$. Low-defect ($d_S=0$ for $|S|>k/2$) $\Rightarrow D(W)\le0\Rightarrow\sigma(W)\ge0$. Both complementary to UC3 bounded-spread Thm 3.5 (which bounds fibre *size*; these bound trace *shape*).
- **$k=3$ residual (Prop 3.4).** $D(W)=\sum_{|S|=2}d_S-\sum_{|S|=1}d_S$; $D(W)\le0\iff\sum_{|S|=2}d_S\le\sum_{|S|=1}d_S$; $d_{\{x\}}=|\mathcal R_\emptyset\setminus\mathcal R_{\{x\}}|$.
- **I1 interlock (Thms 4.1, 4.2; Lemma 4.3).** $\mathcal W=\{W\in\mathcal F:|W|=m(\mathcal F)\}$, $\deg_{\mathcal W}(x)=\#\{W\in\mathcal W:x\in W\}$. Identity: $\sum_W c_W\sigma(W)=\sum_x(\sum_{W\ni x}c_W)\beta_x$ for $c\ge0$. **Interlock:** $\sum_W D(W)\le\sum_W Q(W)$ (suff. $\le0$) $\Rightarrow$ some $\beta_x\ge0$ — Frankl. Relaxes per-generator $D(W)\le Q(W)$ to the single global inequality. Cross-incidence: distinct $W,W'\in\mathcal W$ give $W'\setminus W\in\mathcal R^W_{W'\cap W}\subseteq\mathcal R_W$, $|W'\setminus W|=k-|W\cap W'|$ — generators populate each other's fibres.

---

## Open threads / what a UC5 (or Session 2) would do

UC4's own scope is **discharged** (Phase 1 substantially advanced + Phase 2 assembled), verdict GREEN-partial. The forward work, all converging on the defect profile $d$:

- **UC5 primary — close the per-generator residual.** Show $D(W)\le Q(W)$ (or $D(W)\le0$) in generality. Unexploited: the *cross-$S$* coupling of the graded union law — the defects $\mathcal D_S$ are not independent order ideals, they are cut from the single nested family $\{\widetilde{\mathcal R}_S\}$ by one incidence relation $S\sqcup R\in\mathcal F$; and the minimality grading (UC3 Prop 2.6), which should force the defect *low* (bound $\sum_{|S|>k/2}d_S$ against $\sum_{|S|<k/2}d_S$). Note a single-$W$ closure at $k=3$ would prove Frankl on the open $m(\mathcal F)=3$ frontier — so expect either a structured-sub-case extension or the interlock route.
- **UC5 alternative — close the global interlock residual.** Show $\sum_{W\in\mathcal W}D(W)\le\sum_{W\in\mathcal W}Q(W)$ (strictly weaker than per-generator). Unexploited: the cross-generator symmetry of Lemma 4.3 — $W'\in\mathcal R_W\iff W\in\mathcal R_{W'}$, so the defect a far generator contributes to $W$'s residual is the same incidence datum as the defect $W$ contributes to $W'$'s. Quantify this symmetry into the global bound; use the weighted form with large $c_W$ on $W$-monotone generators ($D(W)=0$).
- **UC5 combination — merge the UC3 and UC4 decompositions.** UC3's per-fibre theorem (primal, by fibre size) and UC4's up-closure decomposition (dual, by trace) are complementary; combine — e.g. use the per-fibre theorem to sign $D(W)$'s positive part on small fibres while the monotone engine handles the rest.
- **Fallbacks F-ii / F-iii — explicit hooks (doc §5).** F-ii: the Hall criterion of UC2 Prop 3.6 applied to the cumulative fibre $\widetilde{\mathcal R}_S$, attaching to the order-ideal structure of the defect (Lemma 2.4). F-iii: the higher-degree square-defect continuation of the graded union law's cross-$S$ coupling.

UC4 does not touch the dead routes (UC1 §8.4: E1–E3 / C1–C5) and is independent of the 1/3-2/3 critical path (`one_third_width_three` — different repo, different polecat).
