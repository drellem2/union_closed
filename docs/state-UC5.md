# Union-Closed Compatibility-Geometry — UC5 cumulative state ledger

**Ticket:** mg-3806 — UC5, closing the UC4 trace-defect residual via the cross-$S$ and cross-generator couplings (fallback F-i, UC4-localized). **Parent:** mg-0bf7 (UC4). **Chain:** mg-f72a (UC1) → mg-a814 (UC2) → mg-cfc0 (UC3) → mg-0bf7 (UC4) → mg-3806 (UC5).
**Branch:** `polecat-cat-mg-3806`.
**Deliverables:** `docs/union-closed-UC5-trace-defect-residual.md` (the residual attack via the cross-$S$ + cross-generator couplings); `docs/state-UC5.md` (this file — cumulative state ledger).
**Type:** Native construction — Walsh/harmonic analysis on the cube. Paper-and-pencil; no new axioms; no Lean; no computation; no engine port. Multi-session-able, 350k cap. This ledger survives session boundaries; a future session re-checks the invariants below before extending.

---

## Verdict (current): GREEN-partial

The UC4 trace-defect residual is **substantially advanced**. All three of UC4 §5's indicated inputs are discharged as theorems: the **cross-$S$ coupling is fully quantified** into an exact closed-form identity for $D(W)$; the **UC3 and UC4 attacks are combined** into a strictly smaller residual object $D^{\mathrm{lg}}\le D(W)$ with a new native frontier region; the **cross-generator coupling is quantified** into the generator Gram form with a native sufficient condition. The residual is named in its sharpest form (the large-fibre defect $D^{\mathrm{lg}}$) but not fully closed — and it cannot be by a single-$W$ argument at $k=3$.

GREEN-partial not GREEN-residual-closed because neither the per-generator residual $D^{\mathrm{lg}}(W)\le A(W)+Q^{\mathrm{lg}}(W)$ nor the global interlock residual is fully closed. Not AMBER-residual-stalls because the route does not stall: the cross-$S$ coupling is quantified as an *exact identity* (the strongest of the three asks), the UC3/UC4 decompositions are *combined* into a smaller residual, a new native region of the frontier (large-fibre-monotone) properly subsumes two prior regions, and the cross-generator coupling is quantified into a Gram form with a sufficient condition. Both couplings quantified; the cross-$S$ one exact.

---

## Session 1 — 2026-05-14 (polecat mg-3806) — DONE

**Goal:** Close the UC4 trace-defect residual (per-generator $D(W)\le Q(W)$ or global $\sum_W D(W)\le\sum_W Q(W)$) via UC4 §5's three indicated inputs: (1) the cross-$S$ coupling of the graded union law; (2) the cross-generator symmetry of Lemma 4.3; (3) combining the UC3 per-fibre sign theorem with the UC4 monotone engine. Native construction only (fallback F-i, UC4-localized); no engine port. Produce the residual-attack doc + this ledger.

| Item | Status | Output |
|---|---|---|
| Carry UC1–UC4 docs into the working branch (foundation) | ✅ | UC1/UC2/UC3/UC4 docs + state ledgers present on branch; UC4 §0 toolkit, §§1–4 decomposition, §5 target + 3 inputs internalized; UC3 §2/§3, UC2 §3.4/§3.5/§4.2 internalized |
| **§1 — the cross-$S$ coupling, fully quantified** | ✅ | **Thm 1.1** defect retraction $\bar\jmath_R(S)=\max(\mathcal S(R)\cap 2^S)$ is an interior operator on $\mathcal S(R)^\uparrow$ (contractive, monotone, idempotent), fixed-point set $\mathcal S(R)$, $S\in\mathcal D(R)\iff\bar\jmath_R(S)\subsetneq S$; **Lemma 1.2** fibres $\bar\jmath_R^{-1}(S_0)$ are order ideals of $[S_0,W]$, i.e. $I_{R,S_0}\subseteq 2^{W_0}$ ($W_0=W\setminus S_0$) an order ideal $\ni\emptyset$; **Thm 1.3** exact decomposition $D(W)=\sum_R\sum_{S_0\in\mathcal S(R)}[(|I_{R,S_0}|-1)\phi(S_0)+2\Sigma(I_{R,S_0})]$, $\Sigma(I)=\sum_{T\in I}|T|$; **Cor 1.4** $\Phi(\mathcal D(R))\ge0$ for $|R|\le\lfloor k/2\rfloor$ |
| **§2 — combining UC3 + UC4: the hybrid residual** | ✅ | **Thm 2.1** $\sigma(W)=A(W)+Q^{\mathrm{lg}}(W)-D^{\mathrm{lg}}(W)$, $A\ge0$ (UC3 Thm 3.3 on small fibres), $Q^{\mathrm{lg}}\ge0$ (filters), $D^{\mathrm{lg}}=\sum_{R\in\mathcal R_W^{\mathrm{lg}}}\Phi(\mathcal D(R))\le D(W)$; exact condition unchanged but sufficient condition $D^{\mathrm{lg}}\le0$ strictly weaker than UC4's $D\le0$; **Thm 2.3** large-fibre-monotone class ($\mathcal D(R)=\emptyset\ \forall|R|>\lfloor k/2\rfloor$) $\Rightarrow$ Frankl; properly contains UC3 bounded-spread + UC4 $W$-monotone, incomparable with UC4 low-defect; **Ex 2.4** $\mathcal F=\{\emptyset,W,U\}$, $k=3$ — large-fibre-monotone but none of bounded-spread/$W$-monotone/low-defect; **§2.4** sharp form of $D^{\mathrm{lg}}$ |
| **§3 — the cross-generator coupling, quantified** | ✅ | **Thm 3.1** generator Gram form: $G=MM^{\mathsf T}$, $G_{W,W'}=|W\cap W'|$, $\Sigma_{\mathcal W}=\sum_W\sigma_{\mathcal W}(W)=\mathbf 1^{\mathsf T}(2G-kJ)\mathbf 1=\sum_x\deg_{\mathcal W}(x)(2\deg_{\mathcal W}(x)-N)$; **Prop 3.2** Lemma 4.3 cross-incidence = symmetry of $G$, far-pair graph $\Gamma$ ($W\sim_\Gamma W'\iff|W\cap W'|<\lceil k/2\rceil$); **Cor 3.3** $\Gamma$ edgeless $\Rightarrow$ generator-free large fibres; **Thm 3.4** concentrated-generator condition: $|U_{\mathcal W}|\le2k\Rightarrow\Sigma_{\mathcal W}\ge0$ (Cauchy–Schwarz), + $\sum_W\sigma_{\mathrm{rest}}(W)\ge0$ $\Rightarrow$ Frankl |
| **§4 — combined picture + named residual + verdict** | ✅ **GREEN-partial** | all 3 UC4 §5 inputs discharged; UC5 residual named: $D^{\mathrm{lg}}(W)\le A(W)+Q^{\mathrm{lg}}(W)$ (per-generator) or global $\sum_W D^{\mathrm{lg}}(W)\le\sum_W(A(W)+Q^{\mathrm{lg}}(W))$; obstruction = the joint tiling/cross-$R$ couplings not yet signed; continuation route (Phase-1 flow argument on $\bar\jmath_R$ tiling; Phase-2 Gram + hybrid + weighted interlock); F-ii/F-iii hooks sharpened |
| **§5 — references** | ✅ | parent chain UC1–UC4, cross-repo dead-route material, Frankl literature, source directives |
| Deliverable 1 — `docs/union-closed-UC5-trace-defect-residual.md` | ✅ | written |
| Deliverable 2 — `docs/state-UC5.md` | ✅ | this file |
| Trust-surface impact | ✅ none | paper-and-pencil; no axioms, no Lean, no computation; no engine port (E1–E3 / C1–C5 untouched); 1/3-2/3 critical path untouched |

**What is proven vs. open.** *Proven:* Theorems 1.1, 1.3, 2.1, 2.3, 3.1, 3.4; Lemma 1.2; Corollaries 1.4, 3.3; Proposition 3.2; Example 2.4 (worked, verified). *Open (named residuals):* the per-generator $D^{\mathrm{lg}}(W)\le A(W)+Q^{\mathrm{lg}}(W)$ and the global $\sum_W D^{\mathrm{lg}}(W)\le\sum_W(A(W)+Q^{\mathrm{lg}}(W))$. The 350k cap was not approached — Session 1 used a small fraction.

---

## Invariants (reproduce-on-resume)

Load-bearing facts for any future session. UC1–UC4 invariants (`docs/state-UC1.md` … `state-UC4.md`) remain in force; these are the UC5 additions.

- **Setup.** Fix minimal generator $W$, $|W|=m(\mathcal F)=k\ge3$, $U'=U\setminus W$. $A=S\sqcup R$; fibre $\mathcal R_S$, co-fibre $\mathcal S(R)$ (union-closed on $W$, $\ni W$); $\phi(S)=2|S|-k$, $\Phi(\mathcal G)=\sum_{S\in\mathcal G}\phi(S)$. UC4: $\sigma(W)=Q(W)-D(W)$, $D(W)=\sum_R\Phi(\mathcal D(R))$, $\mathcal D(R)=\mathcal S(R)^\uparrow\setminus\mathcal S(R)$.
- **Defect retraction (Thm 1.1).** $\bar\jmath_R(S):=\max(\mathcal S(R)\cap 2^S)$ for $S\in\mathcal S(R)^\uparrow$. Interior operator: contractive ($\bar\jmath_R(S)\subseteq S$, $\in\mathcal S(R)$), monotone, idempotent; fixed points $=\mathcal S(R)$; $S\in\mathcal D(R)\iff\bar\jmath_R(S)\subsetneq S$. Deficiency $\delta_R(S)=S\setminus\bar\jmath_R(S)$.
- **Fibre-ideal structure (Lemma 1.2).** $\bar\jmath_R^{-1}(S_0)$ is an order ideal of $[S_0,W]$, bottom $S_0$; $I_{R,S_0}:=\{S\setminus S_0:\bar\jmath_R(S)=S_0\}$ is an order ideal of $2^{W_0}$ ($W_0=W\setminus S_0$) containing $\emptyset$. The fibres tile $\mathcal S(R)^\uparrow$.
- **Cross-$S$ decomposition (Thm 1.3).** $\Phi(\bar\jmath_R^{-1}(S_0))=\phi(S_0)|I_{R,S_0}|+2\Sigma(I_{R,S_0})$, $\Sigma(I)=\sum_{T\in I}|T|$. Hence **exact identity** $D(W)=\sum_R\sum_{S_0\in\mathcal S(R)}[(|I_{R,S_0}|-1)\phi(S_0)+2\Sigma(I_{R,S_0})]$. Key transfer: $\phi(S)=\phi_0(S\setminus S_0)+|S_0|$ on $[S_0,W]$, $\phi_0$ the functional on $2^{W_0}$.
- **Small-fibre defect sign (Cor 1.4).** $|R|\le\lfloor k/2\rfloor\Rightarrow\Phi(\mathcal D(R))\ge0$ (for $0<|R|\le\lfloor k/2\rfloor$, every $S\in\mathcal D(R)$ has $\phi(S)\ge k-2|R|+2>0$; for $R=\emptyset$, $\Phi(\mathcal D(\emptyset))=0$).
- **Hybrid decomposition (Thm 2.1).** $\sigma(W)=A(W)+Q^{\mathrm{lg}}(W)-D^{\mathrm{lg}}(W)$: $A(W)=\sum_{R\in\mathcal R_W^{\mathrm{sm}}}\Phi(\mathcal S(R))\ge0$ (UC3 Thm 3.3), $Q^{\mathrm{lg}}(W)=\sum_{R\in\mathcal R_W^{\mathrm{lg}}}\Phi(\mathcal S(R)^\uparrow)\ge0$, $D^{\mathrm{lg}}(W)=\sum_{R\in\mathcal R_W^{\mathrm{lg}}}\Phi(\mathcal D(R))\le D(W)$. Exact: $D^{\mathrm{lg}}\le A+Q^{\mathrm{lg}}\iff D\le Q$. Sufficient: $D^{\mathrm{lg}}\le0$ (strictly weaker than UC4's $D\le0$).
- **Large-fibre-monotone class (Thm 2.3).** $\mathcal D(R)=\emptyset\ \forall R\in\mathcal R_W^{\mathrm{lg}}$ $\Rightarrow$ $D^{\mathrm{lg}}=0$ $\Rightarrow$ Frankl witnessed in $W$. Properly contains UC3 bounded-spread ($\mathcal R_W^{\mathrm{lg}}=\emptyset$) and UC4 $W$-monotone ($\mathcal D(R)=\emptyset\ \forall R$); incomparable with UC4 low-defect. Witness: Ex 2.4, $\mathcal F=\{\emptyset,W,U\}$.
- **Generator Gram form (Thm 3.1).** $\mathcal W$ = minimal generators, $N=|\mathcal W|$, $M\in\{0,1\}^{\mathcal W\times U}$, $G=MM^{\mathsf T}$ ($G_{W,W'}=|W\cap W'|$). $\sigma(W)=\sigma_{\mathcal W}(W)+\sigma_{\mathrm{rest}}(W)$ (generator vs non-generator members). $\Sigma_{\mathcal W}=\sum_W\sigma_{\mathcal W}(W)=\mathbf 1^{\mathsf T}(2G-kJ)\mathbf 1=\sum_x\deg_{\mathcal W}(x)(2\deg_{\mathcal W}(x)-N)=2\|M^{\mathsf T}\mathbf 1\|^2-kN^2$.
- **Cross-incidence symmetry (Prop 3.2).** $|W'\setminus W|=|W\setminus W'|=k-|W\cap W'|$; $W'$ large-fibre elt of $W\iff W$ large-fibre elt of $W'\iff|W\cap W'|<\lceil k/2\rceil$. Far-pair graph $\Gamma$ undirected. $\Gamma$ edgeless $\Rightarrow$ generator-free large fibres (Cor 3.3).
- **Concentrated-generator condition (Thm 3.4).** $|U_{\mathcal W}|\le2k\Rightarrow\Sigma_{\mathcal W}\ge0$ (Cauchy–Schwarz on $\deg_{\mathcal W}$). With $\sum_W\sigma_{\mathrm{rest}}(W)\ge0$ also $\Rightarrow$ Frankl.

---

## Open threads / what a UC6 (or Session 2) would do

UC5's own scope is **discharged** (all three UC4 §5 inputs quantified as theorems), verdict GREEN-partial. The forward work, all converging on the large-fibre defect $D^{\mathrm{lg}}$:

- **UC6 primary — close the per-generator residual $D^{\mathrm{lg}}(W)\le A(W)+Q^{\mathrm{lg}}(W)$.** The exact identity (Thm 1.3) gives $D^{\mathrm{lg}}(W)=\sum_{R\in\mathcal R_W^{\mathrm{lg}}}\sum_{S_0}[(|I_{R,S_0}|-1)\phi(S_0)+2\Sigma(I_{R,S_0})]$. Unexploited: the *tiling* coupling — the ideals $\{I_{R,S_0}\}_{S_0}$ partition $\mathcal S(R)^\uparrow$, so boundary edges between adjacent $\bar\jmath_R$-fibres carry conservation laws; a flow/charging argument on the interior-operator structure of Thm 1.1 is the natural attack on signing the sum for large $R$.
- **UC6 alternative — close the global interlock residual.** Combine the §3 Gram form with the §2 hybrid: $\sum_W D^{\mathrm{lg}}(W)$ vs $\sum_W(A(W)+Q^{\mathrm{lg}}(W))$, using Prop 3.2's symmetric $\Gamma$ to pair cross-generator large-fibre contributions, and the weighted interlock (UC4 Thm 4.2) with large $c_W$ on large-fibre-monotone generators ($D^{\mathrm{lg}}(W)=0$).
- **UC6 cross-$R$ — the graded union law on co-fibres.** The genuinely unexploited joint constraint: $\mathcal S(R)\vee\mathcal S(R')\subseteq\mathcal S(R\cup R')$ couples the co-fibres of different fibres. Quantifying this into a sign for (2.1) — the cross-$R$ analogue of the cross-$S$ coupling — is the deepest remaining lever.
- **Fallbacks F-ii / F-iii — sharpened hooks (doc §4.3).** F-ii: Hall criterion (UC2 Prop 3.6) on each fibre-ideal $I_{R,S_0}$, with $\bar\jmath_R$ supplying the canonical bipartite incidence. F-iii: the higher-degree square-defect = the cross-$R$ coupling $\mathcal S(R)\vee\mathcal S(R')\subseteq\mathcal S(R\cup R')$.

UC5 does not touch the dead routes (UC1 §8.4: E1–E3 / C1–C5) and is independent of the 1/3-2/3 critical path (`one_third_width_three` — different repo, different polecat).
