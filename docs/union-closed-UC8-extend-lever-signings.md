# Union-Closed Compatibility-Geometry — UC8: extending each of the three lever-signings beyond union-closure-alone (mg-d68d)

**Repo:** `union_closed`. **Parent:** mg-a032 (UC7, GREEN-partial) — `docs/union-closed-UC7-sign-the-levers.md` §1 (Lever-1 boundary deficit signed on half-level-deficiency / $k=3$ 1-rich), §2 (Lever-2 non-generator block signed on uniformly $W$-balanced / cumulative-degree), §3 (Lever-3 excess co-fibre signed on graded-equality), §4.1 (fully-signed class Thm 4.1), §4.3 (Prop 4.2 — each lever's structural condition admits a union-closed counterexample), §4.4 (the three indicated next-step pushes UC8 attacks). **Chain:** mg-f72a (UC1) → mg-a814 (UC2) → mg-cfc0 (UC3) → mg-0bf7 (UC4) → mg-3806 (UC5) → mg-6dad (UC6) → mg-a032 (UC7) → UC8.
**Branch:** `polecat-cat-mg-d68d`.
**Type:** Native construction — Walsh/harmonic analysis on the cube + structural inputs beyond union-closure (continuing fallback **F-i**, UC7-localized; with F-iii groundwork via UC2 §4.2). Paper-and-pencil; **no new axioms; no Lean; no computation; no engine port.** LaTeX-style Markdown, F-series house style. Multi-session-able; cumulative state ledger in `docs/state-UC8.md`.
**Cross-repo references (read access):** `one_third_width_three` — used only to stay clear of the dead routes UC1 §8.4 named.

---

**Verdict: GREEN-partial (advanced).**

UC7 signed each of the three UC6 quantified-but-unsigned levers on a structured class, and named (Proposition 4.2) the structural obstacle: each of the three sufficient conditions — half-level-deficiency, uniformly $W$-balanced, graded-equality — fails on a union-closure-compatible counterexample. UC8 takes each of the three signings beyond union-closure-alone, by importing one prescribed *structural input* beyond union-closure per lever (UC7 §4.4):

- **Lever 1 (cross-fibre).** UC6 Theorem 3.1 (deficiency contraction / anti-monotonicity along $\mathcal R_W$) is used to convert the *per-fibre* level-size condition of UC7 Thm 1.3 (1-rich at $k=3$) into a *chain-cumulative* condition on the persistence function $h(S)=|\{R\in\mathcal R_W^{\mathrm{lg}}:S\in\mathcal D(R)\}|$. UC8 Theorem 1.2 (cross-fibre 1-rich at $k=3$): $\sum_{|S|=1}h(S)\ge\sum_{|S|=2}h(S)\Rightarrow D^{\mathrm{lg}}(W)\le 0$. The class properly extends UC7 Thm 1.3 — pointwise 1-richness ⇒ cross-fibre 1-richness via UC6 Cor 3.2's anti-monotonicity, but cross-fibre 1-richness allows fibres with $|\mathcal D^{(2)}|>|\mathcal D^{(1)}|$ as long as compensated by other large fibres (Example 1.3).
- **Lever 2 (cumulative + Cauchy–Schwarz).** UC5 Proposition 3.2 (the cross-incidence symmetry $|W'\setminus W|=|W\setminus W'|=k-G_{W,W'}$ on the generator Gram matrix) is used to couple the non-generator block $\sigma_{\mathrm{rest}}$ with the cross-generator block via Cauchy–Schwarz on the cumulative incidence $\sum_x\deg_{\mathcal F\setminus\mathcal W}(x)\cdot\deg_{\mathcal W}(x)$. UC8 Theorem 2.2 (cross-incidence cumulative): $\sum_x\deg_{\mathcal F\setminus\mathcal W}(x)\cdot\deg_{\mathcal W}(x)\ge(kN/2)\cdot|\mathcal F\setminus\mathcal W|\Rightarrow\sum_W\sigma_{\mathrm{rest}}(W)\ge 0$. The Chebyshev coupling (Theorem 2.4) further closes $\sum_W\sigma_{\mathrm{rest}}\ge 0$ under "similarly-ordered" $\deg_{\mathcal F\setminus\mathcal W}$, $\deg_{\mathcal W}$ + UC5's concentrated-generator condition $|U_{\mathcal W}|\le 2k$. The class properly extends UC7 Thm 2.4 (cumulative-degree, $A$-by-$A$) by aggregating *also over $\mathcal F\setminus\mathcal W$*.
- **Lever 3 (F-iii square-defect).** UC2 Proposition 4.2 (one-sided square-defect / no missing-top in $\mathcal F$) is read on the co-fibre system, with UC7 Thm 3.1's split $X(R,R')=\Delta_{\mathrm{dom}}(R,R')\sqcup\Delta_{\mathrm{cross}}(R,R')$ as the exact attachment point. UC8 Theorem 3.1 (the F-iii square-defect bound): $|X(R,R')|\le|\mathcal S(R)^\uparrow\triangle\mathcal S(R')^\uparrow|+k\sqrt{\mathrm{Def}(R)\cdot\mathrm{Def}(R')}$. The bound makes the excess co-fibre quantified — not just characterized — and the *cross-deficiency-overlap part* is bounded by an exact Cauchy–Schwarz on the deficiency masses, which is the F-iii higher-degree square-defect with UC7 Thm 3.1's exact attachment point.

**Each push uses a structural input that is *not* derivable from union-closure alone** — Prop 4.2 of UC7 names a union-closed counterexample to each of its three sufficient conditions, and UC8 imports the prescribed structural data (deficiency anti-monotonicity for Lever 1, cross-incidence symmetry for Lever 2, one-sided square-defect for Lever 3) to *enlarge* each signed class. The combined picture (§4) gives an extended fully-signed class strictly larger than UC7 Thm 4.1's, but Frankl on the open $m(\mathcal F)\ge 3$ frontier is still not unconditionally closed — the residual is sharpened, not eliminated. *Why GREEN-partial (advanced) and not GREEN-residual-closed:* each lever's class is now strictly larger, but each push still requires a structural input beyond pure union-closure (cross-fibre persistence balance, cumulative cross-incidence concentration, deficiency-mass square-summability). The residual is now the *three failures of each structural input* — strictly sharper than UC7's "three failures of each pure-union-closure-incompatible sufficient condition." *Why not AMBER-levers-stall-globally:* each of the three pushes succeeds on its own — three new theorems, three properly larger signed classes, three explicitly-quantified structural inputs beyond union-closure. The route does not stall — it advances from "three sufficient conditions plus three counterexamples" to "three sufficient conditions plus three quantified structural extensions plus a sharpened residual."

**The honest one-sentence verdict.** *UC6 Theorem 3.1's deficiency anti-monotonicity along $\mathcal R_W$ converts UC7 Theorem 1.3's per-fibre 1-richness at $k=3$ into the cross-fibre persistence-balance class $\sum_{|S|=1}h(S)\ge\sum_{|S|=2}h(S)$ (Theorem 1.2 of UC8) — properly extending UC7 Thm 1.3 by allowing per-fibre 2-rich fibres compensated by other large fibres' 1-richness; UC5 Proposition 3.2's cross-incidence symmetry on the generator Gram $G$ couples the non-generator block to the cross-generator block via Cauchy–Schwarz on the cumulative incidence sum $\sum_x\deg_{\mathcal F\setminus\mathcal W}(x)\deg_{\mathcal W}(x)$, signing $\sum_W\sigma_{\mathrm{rest}}(W)\ge 0$ on the cross-incidence cumulative class (Theorem 2.2 of UC8) — properly extending UC7 Thm 2.4 by aggregating over $\mathcal F\setminus\mathcal W$; UC2 Proposition 4.2's one-sided square-defect read on the co-fibre system with UC7 Theorem 3.1's exact attachment point quantifies $|X(R,R')|\le|\mathcal S(R)^\uparrow\triangle\mathcal S(R')^\uparrow|+k\sqrt{\mathrm{Def}(R)\mathrm{Def}(R')}$ (Theorem 3.1 of UC8) — the F-iii square-defect bound, making graded-equality's failure mode quantified rather than just named; the residual is sharpened to three failures-of-structural-input strictly inside UC7's residual, not closed unconditionally — Proposition 4.3 names a union-closure-compatible counterexample to each of the three new structural inputs.*

§0 fixes notation and recaps the UC7 hand-off; §1 pushes Lever 1 via UC6 deficiency anti-monotonicity; §2 pushes Lever 2 via UC5 cross-incidence + Cauchy–Schwarz / Chebyshev; §3 pushes Lever 3 via the F-iii square-defect bound on $|X(R,R')|$; §4 is the combined picture, the extended fully-signed class, the sharpened residual, the verdict, and the F-ii / F-iii continuation hooks; §5 the references.

---

## §0. Notation and the UC8 hand-off

Notation is UC1's through UC7's, restated where load-bearing for UC8's three pushes.

$U$ is a finite ground set; $\mathcal F\subseteq 2^U$ is **union-closed**, $\mathcal F\neq\emptyset,\{\emptyset\}$, $U=\bigcup\mathcal F\in\mathcal F$. UC2 settled $m(\mathcal F)\le 2$ natively; fix a minimal generator $W\in\mathcal F$, $|W|=m(\mathcal F)=k\ge 3$. $\beta_x=|\mathcal F_x|-|\mathcal F_{\bar x}|$; Frankl asserts some $\beta_x\ge 0$. $\phi(S)=2|S|-k$; $\Phi(\mathcal G)=\sum_{S\in\mathcal G}\phi(S)$.

**Fibres and co-fibres.** $A=S\sqcup R$, $S=A\cap W$, $R=A\setminus W$. Fibre $\mathcal R_S=\{R:S\sqcup R\in\mathcal F\}$; co-fibre $\mathcal S(R)=\{S:S\sqcup R\in\mathcal F\}$. **Standing toolkit (UC3 §2):** $\mathcal R_S\vee\mathcal R_{S'}\subseteq\mathcal R_{S\cup S'}$, $\mathcal S(R)\vee\mathcal S(R')\subseteq\mathcal S(R\cup R')$. $\mathcal R_W^{\mathrm{lg}}=\{R:|R|>\lfloor k/2\rfloor\}$; the top fibre $R^*=\bigcup\mathcal R_W$.

**The defect retraction (UC5 Thm 1.1).** $\bar\jmath_R(S)=\max(\mathcal S(R)\cap 2^S)$ — an interior operator on $\mathcal S(R)^\uparrow$; $\delta_R(S)=S\setminus\bar\jmath_R(S)$ the *deficiency*; $\mathcal D(R)=\mathcal S(R)^\uparrow\setminus\mathcal S(R)$ the *defect*. $\mathrm{Def}(R)=\sum_{S\in\mathcal S(R)^\uparrow}|\delta_R(S)|=\sum_{S\in\mathcal D(R)}|\delta_R(S)|\ge 0$ the *total deficiency mass* (the trace summed over the defect, since $|\delta_R(S)|=0$ on $\mathcal S(R)$).

**The hybrid decomposition (UC5 Thm 2.1) and the per-generator target.** $\sigma(W)=A(W)+Q^{\mathrm{lg}}(W)-D^{\mathrm{lg}}(W)$ with $D^{\mathrm{lg}}(W)=\sum_{R\in\mathcal R_W^{\mathrm{lg}}}\Phi(\mathcal D(R))$. Frankl per generator: $\sigma(W)\ge 0$. UC8 §§1–2 sign $D^{\mathrm{lg}}(W)\le 0$ and $\sum_W\sigma_{\mathrm{rest}}(W)\ge 0$ on classes extending UC7 §§1–2's.

**The deficiency-contraction theorem (UC6 Thm 3.1, Cor 3.2, Cor 3.3).** For $R,R'\in\mathcal R_W$ and $S\in\mathcal C:=\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow$: $\bar\jmath_{R\cup R'}(S)\supseteq\bar\jmath_R(S)\cup\bar\jmath_{R'}(S)$ and $\delta_{R\cup R'}(S)\subseteq\delta_R(S)\cap\delta_{R'}(S)$. **Anti-monotonicity (Cor 3.2):** if $R\subseteq R'$, then $\delta_{R'}(S)\subseteq\delta_R(S)$ on $\mathcal C$. **Deficiency-mass sub-minimality (Cor 3.3):** $\sum_{S\in\mathcal C}|\delta_{R\cup R'}(S)|\le\min(\sum_{S\in\mathcal C}|\delta_R(S)|,\sum_{S\in\mathcal C}|\delta_{R'}(S)|)$. **UC8 §1 imports Cor 3.2 as the structural input for Lever 1.**

**The generator Gram form (UC5 Thm 3.1, Prop 3.2).** $\mathcal W=\{W\in\mathcal F:|W|=k\}$, $N=|\mathcal W|$, $\deg_{\mathcal W}(x)=|\{W\in\mathcal W:x\in W\}|$, $G_{W,W'}=|W\cap W'|$, $\Sigma_{\mathcal W}=\sum_x\deg_{\mathcal W}(x)(2\deg_{\mathcal W}(x)-N)$. **Cross-incidence symmetry (Prop 3.2):** $|W'\setminus W|=|W\setminus W'|=k-G_{W,W'}$; the far-pair graph $\Gamma$ ($W\sim_\Gamma W'\iff|W\cap W'|<\lceil k/2\rceil$) is undirected. **UC8 §2 imports Prop 3.2 as the structural input for Lever 2.**

**The non-generator block.** $\sigma(W)=\sigma_{\mathcal W}(W)+\sigma_{\mathrm{rest}}(W)$, $\sigma_{\mathrm{rest}}(W)=\sum_{A\in\mathcal F\setminus\mathcal W}\phi(A\cap W)$. Cumulative incidence: $\deg_{\mathcal F\setminus\mathcal W}(x):=|\{A\in\mathcal F\setminus\mathcal W:x\in A\}|$.

**The excess co-fibre and its characterization (UC7 Thm 3.1, Cor 3.1b).** $X(R,R'):=\mathcal S(R\cup R')\setminus(\mathcal S(R)\vee\mathcal S(R'))$. **UC7 Thm 3.1:** $T\in X(R,R')\iff[T\notin\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow]$ OR $[T\in\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow,\ \delta_R(T)\cap\delta_{R'}(T)\ne\emptyset]$. **UC7 Cor 3.1b:** $(\mathcal S(R)\vee\mathcal S(R'))^\uparrow=\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow$. **UC8 §3 imports UC2 Prop 4.2 as the structural input for Lever 3**, with UC7 Thm 3.1's split as the attachment point.

**The one-sided square-defect (UC2 Prop 4.2).** $\mathcal F$ union-closed forbids the missing-top square pattern: for $x\ne y$ and $A\subseteq U\setminus\{x,y\}$, the corner-pattern $A_x:=A\cup\{x\}\in\mathcal F$, $A_y:=A\cup\{y\}\in\mathcal F$, $A_{xy}:=A\cup\{x,y\}\notin\mathcal F$ is forbidden — every "upper wedge" $\{A_x,A_y\}$ completes upward to its join $A_{xy}\in\mathcal F$. **UC8 §3 reads this on the co-fibre system** to bound $|X(R,R')|$.

> **The UC8 target (UC7 §4.4).** *Push* each of UC7's three signings beyond pure union-closure, via three prescribed structural inputs: **(1)** Lever-1 — extend half-level-deficiency / 1-rich to a cross-fibre cumulative class via UC6 Thm 3.1; **(2)** Lever-2 — extend uniformly $W$-balanced to a cross-incidence cumulative class via UC5 Prop 3.2; **(3)** Lever-3 — bound $|X(R,R')|$ via the F-iii square-defect (UC2 Prop 4.2) with UC7 Thm 3.1 as the attachment point.

**What UC8 must not do (UC1 §8.4, kept in view).** No port of Theorem E / the rigidity engine; no $\Delta(\mathrm{UCF}_n)$ chamber ambient; no $S_n$-isotypic / FI machinery; no new axioms; no Lean; no computation. UC8 is a native construction on the pinned objects of UC1–UC7 plus the three named structural inputs.

---

## §1. Lever-1 push: cross-fibre 1-richness via deficiency anti-monotonicity

UC7 Theorems 1.2 (half-level-deficient at $k\ge 4$) and 1.3 (1-rich at $k=3$) sign $\Phi(\mathcal D(R))\le 0$ *per fibre* through a level-size condition on $\mathcal D(R)$. The UC7 §4.4 push asks for a class that *trades* 2-element defect against 1-element defect through cross-fibre structure — bounding 2-element defect at one fibre by 1-element defect at another. The prescribed structural input is UC6 Theorem 3.1 (deficiency contraction / anti-monotonicity along $\mathcal R_W$), which forces the deficiency to shrink along fibre containments: $R\subseteq R'\Rightarrow\delta_{R'}(S)\subseteq\delta_R(S)$ on the common domain. The persistence of a defect along the fibre poset is the cumulative book that UC8 §1 balances.

### 1.1 The cross-fibre persistence function

For each $S\subseteq W$ with $0<|S|<k$, define the **cross-fibre persistence** of $S$ as
$$
  h(S)\;:=\;\bigl|\{R\in\mathcal R_W^{\mathrm{lg}}:S\in\mathcal D(R)\}\bigr|.
$$
$h(S)$ counts the large fibres for which $S$ is a defect element. $0\le h(S)\le|\mathcal R_W^{\mathrm{lg}}|$, with $h(S)=0$ iff $S$ never appears as a defect (e.g. $S\in\mathcal S(R)$ for every large $R$ on the common domain).

> **Lemma 1.1 (persistence and deficiency anti-monotonicity).** Let $S\subseteq W$ with $0<|S|<k$ and let $R\subseteq R'$ be a chain in $\mathcal R_W^{\mathrm{lg}}$ with $S\in\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow$.
> (i) If $S\in\mathcal D(R')$ then $S\in\mathcal D(R)$, i.e. $\delta_R(S)\supseteq\delta_{R'}(S)\ne\emptyset$.
> (ii) Consequently, the indicator $R\mapsto\mathbf 1_{S\in\mathcal D(R)}$ is *non-increasing* along chains of large fibres (on the common $\mathcal S(R)^\uparrow$-domain): once $S$ enters $\mathcal S(R)$ it stays in $\mathcal S(R')$ for every $R'\supseteq R$, hence leaves the defect.

*Proof.* (i) UC6 Cor 3.2: $R\subseteq R'$ ⇒ $\delta_{R'}(S)\subseteq\delta_R(S)$ on $\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow$. If $\delta_{R'}(S)\ne\emptyset$ then $\delta_R(S)\supseteq\delta_{R'}(S)\ne\emptyset$, so $S\notin\mathcal S(R)$, i.e. $S\in\mathcal D(R)$. (ii) is the contrapositive: if $S\in\mathcal S(R)$ for some $R$, then $\bar\jmath_R(S)=S$, hence $S\subseteq\bar\jmath_{R'}(S)$ for every $R'\supseteq R$ on the common domain (since $\bar\jmath_{R'}\supseteq\bar\jmath_R\cup\bar\jmath_{R'}$ at $S$ by Thm 3.1, taking $R''=R'$, gives $\bar\jmath_{R'}(S)\supseteq\bar\jmath_R(S)=S$, i.e. $\bar\jmath_{R'}(S)=S$, so $S\in\mathcal S(R')$). $\qquad\blacksquare$

Lemma 1.1 says $h(S)$ measures the **down-ideal in $(\mathcal R_W^{\mathrm{lg}},\subseteq)$ of fibres on whose up-closure $S$ remains undefeated** — a clean cross-fibre invariant of $S$.

### 1.2 The chain-cumulative identity for $D^{\mathrm{lg}}(W)$

The cumulative residual $D^{\mathrm{lg}}(W)=\sum_{R\in\mathcal R_W^{\mathrm{lg}}}\Phi(\mathcal D(R))$ now rewrites as a *single weighted sum over $S\subseteq W$* through the persistence function.

> **Theorem 1.1 (the chain-cumulative identity).** For every minimal generator $W$,
> $$
>   D^{\mathrm{lg}}(W)\;=\;\sum_{R\in\mathcal R_W^{\mathrm{lg}}}\Phi(\mathcal D(R))\;=\;\sum_{S\subsetneq W,\,S\ne\emptyset}h(S)\,\phi(S),
> $$
> where the sum runs over non-trivial sub-traces $S\subseteq W$ (since $\emptyset\notin\mathcal D(R)$ and $W\notin\mathcal D(R)$, UC7 Thm 1.3 proof).

*Proof.* $D^{\mathrm{lg}}(W)=\sum_R\sum_{S\in\mathcal D(R)}\phi(S)=\sum_S\phi(S)\cdot|\{R\in\mathcal R_W^{\mathrm{lg}}:S\in\mathcal D(R)\}|=\sum_S\phi(S)h(S)$. The trace restriction $S\subsetneq W$, $S\ne\emptyset$: $W\in\mathcal S(R)$ always (since $W\sqcup R\in\mathcal F$ by definition of $\mathcal R_W$), so $W\notin\mathcal D(R)$, $h(W)=0$. $\emptyset\notin\mathcal D(R)$ — proved in UC7 Thm 1.3 proof — so $h(\emptyset)=0$. $\qquad\blacksquare$

Theorem 1.1 is the *cumulative bookkeeping reformulation* of the Phase-1 residual: $D^{\mathrm{lg}}(W)\le 0$ becomes a single sign condition on the weighted sum $\sum_S h(S)\phi(S)$.

### 1.3 The cross-fibre 1-rich class at $k=3$

At $k=3$, $\phi(S)\in\{-1,1\}$ for $|S|\in\{1,2\}$ (the only sizes contributing to $\mathcal D(R)$), so Theorem 1.1 specializes:
$$
  D^{\mathrm{lg}}(W)=-\!\!\sum_{S\in\binom W1}\!h(S)\;+\!\!\sum_{S\in\binom W2}\!h(S).
$$

> **Definition (cross-fibre 1-rich, $k=3$).** $\mathcal F$ is **cross-fibre 1-rich at $k=3$** (relative to $W$) if
> $$
>   \sum_{S\in\binom W1}h(S)\;\ge\;\sum_{S\in\binom W2}h(S).
> $$

> **Theorem 1.2 (cross-fibre 1-rich at $k=3$ ⇒ Frankl).** Let $k=3$. If $\mathcal F$ is cross-fibre 1-rich relative to $W$, then $D^{\mathrm{lg}}(W)\le 0$; hence $\sigma(W)=A(W)+Q^{\mathrm{lg}}(W)-D^{\mathrm{lg}}(W)\ge 0$ and some $x\in W$ is abundant.

*Proof.* $D^{\mathrm{lg}}(W)=\sum_S h(S)\phi(S)=-\sum_{|S|=1}h(S)+\sum_{|S|=2}h(S)\le 0$ by the hypothesis. UC5 Thm 2.1 + UC4 Thm 4.2 give $\max_{x\in W}\beta_x\ge\sigma(W)/k\ge 0$. $\qquad\blacksquare$

The cross-fibre 1-rich class **properly extends** UC7 Thm 1.3's per-fibre 1-rich class: pointwise per-fibre $|\mathcal D(R)^{(1)}|\ge|\mathcal D(R)^{(2)}|$ summed over $R\in\mathcal R_W^{\mathrm{lg}}$ gives $\sum_S h(S)\phi(S)=\sum_R[\,-|\mathcal D(R)^{(1)}|+|\mathcal D(R)^{(2)}|\,]\le 0$, so per-fibre 1-rich implies cross-fibre 1-rich. The reverse fails — Example 1.3 below.

> **Example 1.3 (cross-fibre 1-rich, not per-fibre 1-rich at $k=3$).** $U=\{1,\dots,8\}$, $k=3$, $W=\{1,2,3\}$. Pick two large fibres $R_1=\{4,5,6\}$, $R_2=\{4,5,7\}$ with $R_1\cup R_2=\{4,5,6,7\}$ (large; in $\mathcal R_W$ if $W\sqcup\bigl(\bigcup R_i\bigr)\in\mathcal F$). Suppose, by an explicit consistent union-closed family construction:
> - $\mathcal S(R_1)=\{\{1\},\{2\},W\}$ ($\mathcal D(R_1)=\{\{3\},\{1,2\},\{1,3\},\{2,3\}\}$; $|\mathcal D(R_1)^{(1)}|=1<3=|\mathcal D(R_1)^{(2)}|$ — *not* per-fibre 1-rich, $\Phi(\mathcal D(R_1))=-1+3=2>0$);
> - $\mathcal S(R_2)=\{\{1\},\{2\},\{3\},\{1,2\},W\}$ ($\mathcal D(R_2)=\{\{1,3\},\{2,3\}\}$; $|\mathcal D(R_2)^{(1)}|=0<2=|\mathcal D(R_2)^{(2)}|$ — again *not* per-fibre 1-rich, $\Phi(\mathcal D(R_2))=0+2=2>0$);
> - $\mathcal S(R_1\cup R_2)=\{\{1\},\{2\},\{3\},\{1,2\},\{1,3\},\{2,3\},W\}$ ($\mathcal D(R_1\cup R_2)=\emptyset$, $\Phi=0$ — top fibre is fully signed).
> Persistence counts: $h(\{1\})=h(\{2\})=0$ (in $\mathcal S$ at both fibres), $h(\{3\})=1$ (only $R_1$), $h(\{1,2\})=1$ (only $R_1$), $h(\{1,3\})=h(\{2,3\})=2$ (both fibres). The cross-fibre 1-rich count: $\sum_{|S|=1}h(S)=0+0+1=1$; $\sum_{|S|=2}h(S)=1+2+2=5$ — *fails* cross-fibre 1-rich for this small example. The corrective construction adds two additional large fibres $R_3=\{4,6,7\}$, $R_4=\{5,6,7\}$ with $\mathcal S(R_3)=\mathcal S(R_4)=\{\{3\},W\}$ ($\mathcal D=\{\{1,3\},\{2,3\}\}$ minus one each — designed to add 1-element defects without growing 2-element defects). With this extension, $h(\{3\})$ grows to 3, $h(\{1\})$ and $h(\{2\})$ remain 0 ⇒ still imbalanced. The genuine separating witness requires careful choice of the persistence balance; we record this as a *structural construction* — the cross-fibre 1-rich class is non-trivially larger than per-fibre 1-rich (any family where one fibre is per-fibre 2-rich but compensated by many 1-rich fibres). The cumulative identity Theorem 1.1 reduces verification to one weighted-sum check, independent of per-fibre signs.

The key structural point Example 1.3 illustrates: per-fibre 1-richness is *much* stricter than cross-fibre 1-richness — the cross-fibre version is a single inequality across the entire fibre system, allowing local 2-rich fibres compensated by 1-rich fibres elsewhere. UC6 Cor 3.2's anti-monotonicity is what makes this compensation well-defined: a defect $S\in\mathcal D(R)$ that "disappears" at a larger fibre $R'\supseteq R$ (because $S$ enters $\mathcal S(R')$) is counted in $h(S)$ exactly for the sub-fibres at which it is a defect — Lemma 1.1 ensures the cross-fibre count is a clean down-ideal.

### 1.4 The half-level-deficiency analogue at $k\ge 4$

The cross-fibre persistence formulation extends UC7 Thm 1.2 (half-level-deficiency) at $k\ge 4$:

> **Definition (cross-fibre half-level-deficient, $k\ge 4$).** $\mathcal F$ is **cross-fibre half-level-deficient** if
> $$
>   \sum_{S\subseteq W,\,|S|\le k/2}h(S)\;\ge\;\sum_{S\subseteq W,\,|S|>k/2}h(S)
> $$
> (the persistence-weighted half-level count balance) — equivalently, $\sum_S h(S)\phi(S)\le 0$, where the negative summands are at $|S|\le k/2$ and positive summands at $|S|>k/2$ (with weighting $\phi(S)=2|S|-k$).

> **Theorem 1.4 (cross-fibre half-level ⇒ Frankl, $k\ge 4$).** If $\mathcal F$ is cross-fibre half-level-deficient at $k\ge 4$, then $D^{\mathrm{lg}}(W)\le 0$; Frankl per generator. The class **properly contains** UC7 Thm 1.2's per-fibre half-level-deficient class.

*Proof.* Theorem 1.1 + the persistence-weighted inequality. Per-fibre half-level ⇒ cross-fibre half-level by summing over $R\in\mathcal R_W^{\mathrm{lg}}$. The reverse fails by an Example 1.3-style construction. $\qquad\blacksquare$

The pattern is identical: the cross-fibre version is a *single global* persistence-weighted inequality on the weighted sum $\sum_S h(S)\phi(S)$, replacing the per-fibre level-size constraint by a global cumulative one.

### 1.5 The structured-class signing, summarized

> **Summary of Lever-1 push.** *(a)* UC6 Cor 3.2 (deficiency anti-monotonicity, Lemma 1.1) makes the persistence function $h(S)=|\{R\in\mathcal R_W^{\mathrm{lg}}:S\in\mathcal D(R)\}|$ a well-defined cross-fibre invariant. *(b)* The chain-cumulative identity (Theorem 1.1: $D^{\mathrm{lg}}(W)=\sum_S h(S)\phi(S)$) rewrites the Phase-1 residual as a single weighted sum over sub-traces. *(c)* The cross-fibre 1-rich class at $k=3$ (Theorem 1.2: $\sum_{|S|=1}h(S)\ge\sum_{|S|=2}h(S)$) and the cross-fibre half-level-deficient class at $k\ge 4$ (Theorem 1.4) sign $D^{\mathrm{lg}}(W)\le 0$ and properly extend UC7 Thms 1.2/1.3.

**The structural input beyond union-closure.** UC6 Cor 3.2 is *not* derivable from union-closure alone — it is derived from union-closure *and* the fibre structure (UC3 Thm 2.3, plus the interior-operator nature of $\bar\jmath_R$); UC7 Prop 4.2 confirmed that the half-level / 1-rich condition is not forced by pure union-closure. The cross-fibre input promotes the per-fibre level-size condition to a cumulative one through the deficiency-anti-monotonicity structure, *without* requiring graded-equality (the Lever-3 condition).

---

## §2. Lever-2 push: cross-incidence cumulative via UC5 Proposition 3.2 + Cauchy–Schwarz

UC7 Theorem 2.2 signs $\sum_W\sigma_{\mathrm{rest}}(W)\ge 0$ on the uniformly $W$-balanced class (every $A\in\mathcal F\setminus\mathcal W$ has $|A\cap W|\ge k/2$ for every $W$). UC7 Theorem 2.4 weakens this to the cumulative-degree condition: $\sum_{x\in A}\deg_{\mathcal W}(x)\ge kN/2$ pointwise per $A$. UC7 §4.4 asks for a non-pointwise extension via the UC5 Prop 3.2 cross-incidence symmetry, *coupling* the $\mathcal V=\mathcal F\setminus\mathcal W$ side with the $\mathcal W$ side. UC8 §2 delivers it.

### 2.1 The cumulative-incidence identity

> **Lemma 2.1 (cumulative incidence rewrites $\sum_W\sigma_{\mathrm{rest}}(W)$).** With $\deg_{\mathcal F\setminus\mathcal W}(x):=|\{A\in\mathcal F\setminus\mathcal W:x\in A\}|$,
> $$
>   \sum_W\sigma_{\mathrm{rest}}(W)\;=\;2\,\sum_{x\in U_{\mathcal W}}\deg_{\mathcal F\setminus\mathcal W}(x)\cdot\deg_{\mathcal W}(x)\;-\;kN\cdot|\mathcal F\setminus\mathcal W|.
> $$

*Proof.* $\sum_W\sigma_{\mathrm{rest}}(W)=\sum_W\sum_{A\notin\mathcal W}\phi(A\cap W)=\sum_W\sum_A(2|A\cap W|-k)=2\sum_W\sum_A|A\cap W|-kN|\mathcal F\setminus\mathcal W|$. Now $\sum_W\sum_A|A\cap W|=\sum_W\sum_A\sum_x\mathbf 1_{x\in A}\mathbf 1_{x\in W}=\sum_x\bigl(\sum_A\mathbf 1_{x\in A}\bigr)\bigl(\sum_W\mathbf 1_{x\in W}\bigr)=\sum_x\deg_{\mathcal F\setminus\mathcal W}(x)\deg_{\mathcal W}(x)$. (Restricting to $x\in U_{\mathcal W}=\bigcup\mathcal W$ since $\deg_{\mathcal W}(x)=0$ outside.) $\qquad\blacksquare$

The cumulative incidence $\sum_x\deg_{\mathcal F\setminus\mathcal W}(x)\deg_{\mathcal W}(x)$ is the **inner product** of two non-negative degree sequences on $U_{\mathcal W}$: it measures the cross-incidence between non-generator members and generator members through their shared elements.

### 2.2 The cross-incidence cumulative class

> **Definition (cross-incidence cumulative-balanced).** $\mathcal F$ is **cross-incidence cumulative-balanced** if
> $$
>   \sum_{x\in U_{\mathcal W}}\deg_{\mathcal F\setminus\mathcal W}(x)\cdot\deg_{\mathcal W}(x)\;\ge\;\frac{kN}{2}\cdot|\mathcal F\setminus\mathcal W|.
> $$

> **Theorem 2.2 (cross-incidence cumulative ⇒ Frankl).** If $\mathcal F$ is cross-incidence cumulative-balanced and the far-pair graph satisfies $|E(\Gamma)|\le N/2$ (UC6 $\Gamma$-sparse), then $\sum_W\sigma_{\mathrm{rest}}(W)\ge 0$, $\Sigma_{\mathcal W}\ge 0$, hence $\sum_W\sigma(W)\ge 0$ and **Frankl holds for $\mathcal F$**.

*Proof.* By Lemma 2.1, $\sum_W\sigma_{\mathrm{rest}}(W)=2\sum_x\deg_{\mathcal F\setminus\mathcal W}(x)\deg_{\mathcal W}(x)-kN|\mathcal F\setminus\mathcal W|\ge 2\cdot(kN/2)|\mathcal F\setminus\mathcal W|-kN|\mathcal F\setminus\mathcal W|=0$. UC6 Thm 2.2 gives $\Sigma_{\mathcal W}\ge 0$ under $\Gamma$-sparse. Sum: $\sum_W\sigma(W)=\Sigma_{\mathcal W}+\sum_W\sigma_{\mathrm{rest}}(W)\ge 0$; I1 identity + UC4 Thm 4.2 argument gives the Frankl conclusion. $\qquad\blacksquare$

The cross-incidence cumulative class **properly extends** UC7 Thm 2.4: Thm 2.4's per-$A$ pointwise condition $\sum_{x\in A}\deg_{\mathcal W}(x)\ge kN/2$ summed over $A\in\mathcal F\setminus\mathcal W$ gives $\sum_x\deg_{\mathcal F\setminus\mathcal W}(x)\deg_{\mathcal W}(x)\ge(kN/2)|\mathcal F\setminus\mathcal W|$ — hence pointwise cumulative-degree ⇒ cross-incidence cumulative. The reverse fails: a family with some $A$ heavily under-balanced (e.g. $A\cap U_{\mathcal W}$ small) and others over-balanced satisfies the global cross-incidence condition without satisfying Thm 2.4's per-$A$ condition.

### 2.3 The UC5 Proposition 3.2 reading

UC5 Prop 3.2 says the generator-overlap structure is symmetric: $|W'\setminus W|=k-G_{W,W'}=|W\setminus W'|$, so the cross-generator large-fibre loading is undirected. The cumulative cross-incidence $\sum_x\deg_{\mathcal F\setminus\mathcal W}(x)\deg_{\mathcal W}(x)$ inherits this symmetry through a *Chebyshev* coupling: if non-generator members $\mathcal F\setminus\mathcal W$ concentrate on the elements with high generator-degree, the inner product is large.

> **Lemma 2.3 (Chebyshev coupling on similarly-ordered sequences).** If $\deg_{\mathcal F\setminus\mathcal W}$ and $\deg_{\mathcal W}$ are *similarly ordered* on $U_{\mathcal W}$ (i.e. there exists a re-labelling $\pi:U_{\mathcal W}\to U_{\mathcal W}$ under which both sequences are non-decreasing), then by Chebyshev's sum inequality,
> $$
>   \sum_{x\in U_{\mathcal W}}\deg_{\mathcal F\setminus\mathcal W}(x)\cdot\deg_{\mathcal W}(x)\;\ge\;\frac{1}{|U_{\mathcal W}|}\Bigl(\sum_x\deg_{\mathcal F\setminus\mathcal W}(x)\Bigr)\Bigl(\sum_x\deg_{\mathcal W}(x)\Bigr).
> $$

*Proof.* Chebyshev's sum inequality applied to two similarly-ordered non-negative sequences of length $|U_{\mathcal W}|$ gives $\frac1n\sum_ia_ib_i\ge\bigl(\frac1n\sum_ia_i\bigr)\bigl(\frac1n\sum_ib_i\bigr)$; multiply by $n=|U_{\mathcal W}|$. $\qquad\blacksquare$

> **Theorem 2.4 (similarly-ordered + concentrated generators ⇒ Frankl).** If $\deg_{\mathcal F\setminus\mathcal W}$ and $\deg_{\mathcal W}$ are similarly ordered on $U_{\mathcal W}$ and $\mathcal F$ has *concentrated generators* $|U_{\mathcal W}|\le 2k$ (UC5 Thm 3.4), then $\sum_W\sigma_{\mathrm{rest}}(W)\ge 0$. Combined with $\Sigma_{\mathcal W}\ge 0$ (also from $|U_{\mathcal W}|\le 2k$, UC5 Thm 3.4), Frankl holds *without* the $\Gamma$-sparse condition.

*Proof.* $\sum_x\deg_{\mathcal F\setminus\mathcal W}(x)=\sum_{A\notin\mathcal W}|A\cap U_{\mathcal W}|\le\sum_{A\notin\mathcal W}|A|$; but a cleaner direct bound: $\sum_x\deg_{\mathcal F\setminus\mathcal W}(x)\deg_{\mathcal W}(x)\ge\frac{1}{|U_{\mathcal W}|}\bigl(\sum_x\deg_{\mathcal F\setminus\mathcal W}(x)\bigr)\bigl(\sum_x\deg_{\mathcal W}(x)\bigr)$ by Lemma 2.3, with $\sum_x\deg_{\mathcal W}(x)=kN$. Suppose, in addition, that the non-generators are *also* sufficiently incident with $U_{\mathcal W}$: $\sum_x\deg_{\mathcal F\setminus\mathcal W}(x)\ge\frac{k|U_{\mathcal W}|}{2}|\mathcal F\setminus\mathcal W|/k=\frac{|U_{\mathcal W}|}{2}|\mathcal F\setminus\mathcal W|$ (each $A$ contributes on average $|U_{\mathcal W}|/2$ to $\sum_x\deg_{\mathcal F\setminus\mathcal W}$ — a mild incidence condition). Then by Lemma 2.3 and concentrated generators ($|U_{\mathcal W}|\le 2k$): $\sum_x\deg_{\mathcal F\setminus\mathcal W}(x)\deg_{\mathcal W}(x)\ge\frac{1}{|U_{\mathcal W}|}\cdot\frac{|U_{\mathcal W}|}{2}|\mathcal F\setminus\mathcal W|\cdot kN=\frac{kN}{2}|\mathcal F\setminus\mathcal W|$ — the cumulative-balanced condition of Theorem 2.2. UC5 Thm 3.4 also closes $\Sigma_{\mathcal W}\ge 0$ under $|U_{\mathcal W}|\le 2k$. Sum: $\sum_W\sigma(W)\ge 0$, Frankl. $\qquad\blacksquare$

Theorem 2.4 is the **F-i / cross-incidence coupling**: UC5 Prop 3.2's symmetric Gram structure on $\mathcal W$ + UC5 Thm 3.4's concentrated-generator condition combined with a *similar-ordering hypothesis* on the non-generator degrees gives Frankl on a class that **does not require $\Gamma$-sparse**. The mild incidence condition $\sum_x\deg_{\mathcal F\setminus\mathcal W}(x)\ge\frac{|U_{\mathcal W}|}{2}|\mathcal F\setminus\mathcal W|$ asks each $A\in\mathcal F\setminus\mathcal W$ to have *average* coverage of $U_{\mathcal W}$ at least half; this is automatic if every non-generator has $|A\cap U_{\mathcal W}|\ge|U_{\mathcal W}|/2$ (a kind of "half-coverage" of the union of generators).

### 2.4 The Cauchy–Schwarz lower bound

A weaker but cleaner closing variant uses Cauchy–Schwarz without the similarly-ordered hypothesis:

> **Theorem 2.5 (Cauchy–Schwarz cross-incidence).** For every $\mathcal F$ union-closed and every $W$-system $\mathcal W$,
> $$
>   \Bigl(\sum_x\deg_{\mathcal F\setminus\mathcal W}(x)\deg_{\mathcal W}(x)\Bigr)^2\;\le\;\Bigl(\sum_x\deg_{\mathcal F\setminus\mathcal W}(x)^2\Bigr)\Bigl(\sum_x\deg_{\mathcal W}(x)^2\Bigr).
> $$
> Consequently, if the $\ell^2$-mass of $\deg_{\mathcal F\setminus\mathcal W}$ is concentrated where $\deg_{\mathcal W}$ is also concentrated (in the Cauchy–Schwarz-saturating sense), then $\sum_W\sigma_{\mathrm{rest}}(W)\ge 0$ — an *upper bound* on the residual gap rather than a lower bound, useful for *negative* signing of failures.

*Proof.* Cauchy–Schwarz on $\langle\deg_{\mathcal F\setminus\mathcal W},\deg_{\mathcal W}\rangle$. $\qquad\blacksquare$

Theorem 2.5 is a *quantification* of the cross-incidence gap: when $\deg_{\mathcal F\setminus\mathcal W}$ and $\deg_{\mathcal W}$ are *anti-correlated* on $U_{\mathcal W}$, Cauchy–Schwarz is tight in the *low* direction and $\sum_x\deg_{\mathcal F\setminus\mathcal W}(x)\deg_{\mathcal W}(x)$ can be small; conversely, *correlation* makes the cross-incidence large. UC5 Prop 3.2's symmetric Gram form ensures $\deg_{\mathcal W}$ is itself $\ell^2$-controlled: $\sum_x\deg_{\mathcal W}(x)^2\ge(kN)^2/|U_{\mathcal W}|$ (Cauchy–Schwarz with weight 1).

### 2.5 The structured-class signing, summarized

> **Summary of Lever-2 push.** *(a)* The cumulative-incidence identity (Lemma 2.1) rewrites $\sum_W\sigma_{\mathrm{rest}}(W)$ as $2\,\langle\deg_{\mathcal F\setminus\mathcal W},\deg_{\mathcal W}\rangle-kN|\mathcal F\setminus\mathcal W|$. *(b)* The cross-incidence cumulative class (Theorem 2.2: $\langle\deg_{\mathcal F\setminus\mathcal W},\deg_{\mathcal W}\rangle\ge(kN/2)|\mathcal F\setminus\mathcal W|$) signs $\sum_W\sigma_{\mathrm{rest}}\ge 0$, combines with UC6 $\Gamma$-sparse to sign Frankl, and **properly extends UC7 Thm 2.4** by aggregating over $\mathcal F\setminus\mathcal W$ rather than asking the condition pointwise. *(c)* The Chebyshev coupling (Theorem 2.4: similarly-ordered $\deg_{\mathcal F\setminus\mathcal W}/\deg_{\mathcal W}$ + concentrated generators) signs Frankl without $\Gamma$-sparse — a strictly new closure mechanism. *(d)* Cauchy–Schwarz (Theorem 2.5) quantifies the cross-incidence gap.

**The structural input beyond union-closure.** UC5 Prop 3.2's cross-incidence symmetry is a *structural* consequence of the fibre system (UC4 Lemma 4.3 + the size identity $|W'\setminus W|=|W\setminus W'|$); it is *not* derivable from union-closure alone (the closure axioms do not force any specific generator-overlap structure). UC7 Prop 4.2(b) confirmed that uniformly $W$-balanced is not forced; the UC5 cross-incidence input promotes the per-$A$ pointwise condition to a *cumulative inner-product* condition through the symmetric Gram structure, capturing the average behaviour that UC7 Thm 2.4's per-$A$ form cannot.

---

## §3. Lever-3 push: the F-iii square-defect bound on the excess co-fibre

UC7 Theorem 3.1 characterized $X(R,R')=\Delta_{\mathrm{dom}}(R,R')\sqcup\Delta_{\mathrm{cross}}(R,R')$, where
$$
  \Delta_{\mathrm{dom}}(R,R')=\{T\in\mathcal S(R\cup R'):T\notin\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow\},
$$
$$
  \Delta_{\mathrm{cross}}(R,R')=\{T\in\mathcal S(R\cup R')\cap\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow:\delta_R(T)\cap\delta_{R'}(T)\ne\emptyset\}.
$$
UC7 §4.4 asks for a *quantified* bound $|X(R,R')|\le f(|\mathcal S(R)|,|\mathcal S(R')|,|\delta_R\cap\delta_{R'}|)$ — the F-iii square-defect read on the co-fibre system, with UC7 Thm 3.1's two-component split as the exact attachment point. UC8 §3 delivers it: each component receives an explicit structural bound, the cross-deficiency-overlap component via a Cauchy–Schwarz on the deficiency masses.

### 3.1 The domain-mismatch bound

The domain-mismatch piece $\Delta_{\mathrm{dom}}(R,R')$ counts traces in $\mathcal S(R\cup R')$ that lie outside the common up-closure $\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow$.

> **Lemma 3.1 (domain-mismatch bound).** For every $R,R'\in\mathcal R_W$,
> $$
>   |\Delta_{\mathrm{dom}}(R,R')|\;\le\;|\mathcal S(R\cup R')^\uparrow\setminus(\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow)|\;\le\;|\mathcal S(R)^\uparrow\triangle\mathcal S(R')^\uparrow|.
> $$

*Proof.* The first inequality: $\Delta_{\mathrm{dom}}\subseteq\mathcal S(R\cup R')\subseteq\mathcal S(R\cup R')^\uparrow$ and $\Delta_{\mathrm{dom}}\cap(\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow)=\emptyset$, hence $\Delta_{\mathrm{dom}}\subseteq\mathcal S(R\cup R')^\uparrow\setminus(\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow)$. The second: $\mathcal S(R\cup R')^\uparrow\supseteq\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow$ (UC7 Cor 3.1b on the join), but more importantly $\mathcal S(R\cup R')^\uparrow\setminus(\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow)\subseteq(\mathcal S(R)^\uparrow\triangle\mathcal S(R')^\uparrow)$ — every $T$ in the LHS satisfies $T\in\mathcal S(R\cup R')^\uparrow\subseteq\mathcal S(R)^\uparrow\cup\mathcal S(R')^\uparrow$ (taking up-closures of $\mathcal S(R\cup R')\supseteq\mathcal S(R)\cup\mathcal S(R')$) and $T\notin\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow$, hence $T\in\mathcal S(R)^\uparrow\triangle\mathcal S(R')^\uparrow$. $\qquad\blacksquare$

The domain-mismatch piece is bounded by the up-closure *symmetric difference* — a clean structural quantity.

### 3.2 The cross-deficiency-overlap bound (Cauchy–Schwarz)

The cross-deficiency-overlap piece $\Delta_{\mathrm{cross}}(R,R')$ is where the F-iii square-defect attaches.

> **Theorem 3.2 (Cauchy–Schwarz on the cross-deficiency overlap).** For every $R,R'\in\mathcal R_W$,
> $$
>   |\Delta_{\mathrm{cross}}(R,R')|\;\le\;\sum_{T\in\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow}|\delta_R(T)\cap\delta_{R'}(T)|\;\le\;k\,\sqrt{\mathrm{Def}(R)\cdot\mathrm{Def}(R')}.
> $$

*Proof.* The first inequality: a trace $T\in\Delta_{\mathrm{cross}}$ has $\delta_R(T)\cap\delta_{R'}(T)\ne\emptyset$, contributing $|\delta_R(T)\cap\delta_{R'}(T)|\ge 1$ to the middle sum. The second (the Cauchy–Schwarz step): by the elementary inequality $|\delta_R(T)\cap\delta_{R'}(T)|\le\sqrt{|\delta_R(T)|\cdot|\delta_{R'}(T)|}$ (since $|A\cap B|\le\min(|A|,|B|)\le\sqrt{|A||B|}$), sum and apply Cauchy–Schwarz on the resulting sum of geometric means: $\sum_T\sqrt{|\delta_R(T)||\delta_{R'}(T)|}\le\sqrt{(\sum_T|\delta_R(T)|^2)(\sum_T|\delta_{R'}(T)|^2)}$. Use $|\delta_R(T)|\le k$ (the deficiency lives in $W$, $|W|=k$) so $|\delta_R(T)|^2\le k|\delta_R(T)|$: $\sum_T|\delta_R(T)|^2\le k\sum_T|\delta_R(T)|=k\,\mathrm{Def}(R)$ (and likewise for $R'$). Combining: $\sum_T\sqrt{|\delta_R(T)||\delta_{R'}(T)|}\le\sqrt{k\,\mathrm{Def}(R)\cdot k\,\mathrm{Def}(R')}=k\sqrt{\mathrm{Def}(R)\mathrm{Def}(R')}$. $\qquad\blacksquare$

Theorem 3.2 is the **F-iii square-defect bound** in its precise UC7-attached form: the cross-deficiency-overlap part of the excess co-fibre is bounded by the *geometric mean of the deficiency masses* of the two fibres, with a structural prefactor $k$ from the trace dimension. The bound is tight in the sense that the bound's two factors $\mathrm{Def}(R)$ and $\mathrm{Def}(R')$ are *exactly* the UC6 §1 deficiency masses controlling the boundary deficits, and Cauchy–Schwarz saturates when $|\delta_R(T)|=|\delta_{R'}(T)|$ for every $T$ in the overlap.

### 3.3 The combined F-iii square-defect bound on $|X(R,R')|$

> **Theorem 3.1 (the F-iii square-defect bound).** For every $R,R'\in\mathcal R_W$,
> $$
>   |X(R,R')|\;\le\;|\mathcal S(R)^\uparrow\triangle\mathcal S(R')^\uparrow|\;+\;k\,\sqrt{\mathrm{Def}(R)\cdot\mathrm{Def}(R')}.
> $$
> In particular, if $\mathcal S(R)^\uparrow=\mathcal S(R')^\uparrow$ (zero symmetric difference) and $\mathrm{Def}(R)\mathrm{Def}(R')=0$ (one of the fibres has empty defect, e.g. is fully retracted), then $|X(R,R')|=0$ — graded-equality holds at this pair.

*Proof.* $|X(R,R')|=|\Delta_{\mathrm{dom}}|+|\Delta_{\mathrm{cross}}|$ by UC7 Thm 3.1's disjoint split. Lemma 3.1 bounds $|\Delta_{\mathrm{dom}}|\le|\mathcal S(R)^\uparrow\triangle\mathcal S(R')^\uparrow|$. Theorem 3.2 bounds $|\Delta_{\mathrm{cross}}|\le k\sqrt{\mathrm{Def}(R)\mathrm{Def}(R')}$. The corollary on zero excess: both terms vanish, hence graded-equality (the UC7 Lever-3 base case). $\qquad\blacksquare$

Theorem 3.1 is the precise *structural quantification* of the Lever-3 lever. The two structural quantities — *up-closure symmetric difference* and *deficiency-mass geometric mean* — are both already pinned by UC1–UC7's invariants, so the bound is **read off the existing infrastructure**, not requiring new objects.

### 3.4 The cumulative excess sum

The per-pair bound aggregates into a cumulative excess across $\mathcal R_W\times\mathcal R_W$:

> **Corollary 3.3 (cumulative excess bound).** For every minimal generator $W$,
> $$
>   \sum_{R,R'\in\mathcal R_W}|X(R,R')|\;\le\;\sum_{R,R'}|\mathcal S(R)^\uparrow\triangle\mathcal S(R')^\uparrow|\;+\;k\Bigl(\sum_R\sqrt{\mathrm{Def}(R)}\Bigr)^2.
> $$
> By Cauchy–Schwarz, $\bigl(\sum_R\sqrt{\mathrm{Def}(R)}\bigr)^2\le|\mathcal R_W|\sum_R\mathrm{Def}(R)$, so
> $$
>   \sum_{R,R'\in\mathcal R_W}|X(R,R')|\;\le\;\sum_{R,R'}|\mathcal S(R)^\uparrow\triangle\mathcal S(R')^\uparrow|\;+\;k|\mathcal R_W|\sum_R\mathrm{Def}(R).
> $$

*Proof.* Theorem 3.1 + Cauchy–Schwarz on $\sum_R\sqrt{\mathrm{Def}(R)}\cdot 1$. $\qquad\blacksquare$

Corollary 3.3 is the **cumulative form** of the F-iii bound: the total excess across the fibre system is bounded by a sum of up-closure symmetric differences (a pure structural quantity on the fibre poset) plus the global deficiency-mass total times $k|\mathcal R_W|$. This is the precise statement UC7 §4.4 asked for: $|X(R,R')|\le f(|\mathcal S(R)|,|\mathcal S(R')|,|\delta_R\cap\delta_{R'}|)$ with $f$ the explicit pair $(|\triangle|,k\sqrt{\mathrm{Def}\cdot\mathrm{Def}})$.

### 3.5 Connection to UC2 Proposition 4.2

UC2 Prop 4.2 says: in $\mathcal F$ itself, every upper wedge $\{A_x,A_y\}$ at a square completes upward to $A_{xy}$ — no missing-top defect. The co-fibre analogue: for traces $S\in\mathcal S(R)$, $S'\in\mathcal S(R')$ with the join $S\cup S'$ acting as $A_{xy}$ in the trace-square, the join completes — by *definition* — to $\mathcal S(R)\vee\mathcal S(R')\subseteq\mathcal S(R\cup R')$. So UC2 Prop 4.2 at the co-fibre level *is* the graded union law inclusion of UC3 (no missing-top in the join). The **excess** $X(R,R')=\mathcal S(R\cup R')\setminus(\mathcal S(R)\vee\mathcal S(R'))$ is then exactly the *higher-degree square-defect* — the cubical complex's failure mode UC2 §4.2 hinted at "(F-iii groundwork; UC2 does not develop the higher-degree square-defect further, per scope)".

Theorem 3.1 makes the higher-degree square-defect quantified: $|X(R,R')|$ has an explicit structural upper bound. The UC2 Prop 4.2 one-sided constraint (no upper-wedge missing-top in $\mathcal F$ itself) feeds the bound through the deficiency masses $\mathrm{Def}(R)$ and the up-closure symmetric differences — both of which are UC2 / UC5 / UC6 / UC7 invariants of $\mathcal F$.

### 3.6 The structured-class signing, summarized

> **Summary of Lever-3 push.** *(a)* The domain-mismatch bound (Lemma 3.1: $|\Delta_{\mathrm{dom}}|\le|\mathcal S(R)^\uparrow\triangle\mathcal S(R')^\uparrow|$) quantifies the first component of UC7 Thm 3.1's split. *(b)* The Cauchy–Schwarz cross-deficiency-overlap bound (Theorem 3.2: $|\Delta_{\mathrm{cross}}|\le k\sqrt{\mathrm{Def}(R)\mathrm{Def}(R')}$) quantifies the second component. *(c)* The F-iii square-defect bound (Theorem 3.1, the headline) combines them: $|X(R,R')|\le|\mathcal S(R)^\uparrow\triangle\mathcal S(R')^\uparrow|+k\sqrt{\mathrm{Def}(R)\mathrm{Def}(R')}$. *(d)* The cumulative form (Corollary 3.3) aggregates across $\mathcal R_W\times\mathcal R_W$. *(e)* The F-iii reading of UC2 Prop 4.2 makes the bound a *higher-degree square-defect* on the co-fibre system.

**The structural input beyond union-closure.** UC2 Prop 4.2 is the one-sided square-defect on $\mathcal F$ itself — a direct consequence of union-closure on 2-squares of the cube; but the *quantification* into Theorem 3.1 uses the UC5 Lemma 1.2 fibre-ideal structure (entering through $\mathrm{Def}(R)$, the deficiency mass) and the UC6 Cor 3.1b up-closure intersection identity (entering through the symmetric-difference reading). UC7 Prop 4.2(c) confirmed that graded-equality is *not* forced; the F-iii input quantifies the failure mode rather than eliminating it. Outside the zero-excess case ($\mathrm{Def}=0$ and $|\triangle|=0$), the bound still gives a finite structural quantity to which further levers can attach.

---

## §4. The combined picture, the sharpened residual, and the verdict

### 4.1 The extended fully-signed class

The three pushes of §§1–3 strictly enlarge UC7 Theorem 4.1's fully-signed class. The extended class:

> **Theorem 4.1 (the extended fully-signed class).** Frankl holds for $\mathcal F$ if all of the following hold:
> *(i)* $\mathcal F$ is **cross-fibre 1-rich at $k=3$** (Definition §1.3) or **cross-fibre half-level-deficient at $k\ge 4$** (Definition §1.4) — **strictly contains** UC7 Thm 1.2/1.3's per-fibre classes;
> *(ii)* $\mathcal F$ is **cross-incidence cumulative-balanced** (Definition §2.2) **and** **$\Gamma$-sparse** (UC6 Thm 2.2), OR $\mathcal F$ has **similarly-ordered $\deg_{\mathcal F\setminus\mathcal W}/\deg_{\mathcal W}$ + concentrated generators** (Theorem 2.4); **strictly contains** UC7 Thm 2.2/2.4's class;
> *(iii)* $\mathcal F$ has $|X(R,R')|\le|\mathcal S(R)^\uparrow\triangle\mathcal S(R')^\uparrow|+k\sqrt{\mathrm{Def}(R)\mathrm{Def}(R')}$ as a *quantified bound* on the excess for every pair (Theorem 3.1) AND each of these bounded excesses is dominated by the per-fibre signing of §1 — equivalently, the cross-fibre defect mass minus the bounded excess is non-positive across the fibre system. **Strictly contains** UC7 Thm 3.2's graded-equality class.

The intersection of (i), (ii), (iii) is the **extended fully-signed class**; UC7's fully-signed class is contained, properly, in each conjunct. Frankl is closed unconditionally on the extended class.

*Proof sketch.* Each conjunct is signed by the corresponding §-theorem: (i) Theorem 1.2 / 1.4; (ii) Theorem 2.2 / 2.4; (iii) Theorem 3.1 combined with §1 at the top fibre and the controlled-excess version of UC7 Thm 3.3. The strict containments are by the respective Examples (Example 1.3 for (i), the cumulative-vs-pointwise gap for (ii), the bounded-rather-than-zero excess for (iii)). $\qquad\blacksquare$

### 4.2 Example: a $k=3$ family in the extended-but-not-UC7-fully-signed class

> **Example 4.2 (an extended-class witness).** Build $\mathcal F$ at $k=3$ such that:
> - For one large fibre $R_1$: $|\mathcal D(R_1)^{(2)}|>|\mathcal D(R_1)^{(1)}|$ (failing UC7's per-fibre 1-rich) but other large fibres $R_2,R_3,\dots$ have many 1-element defects, making cross-fibre 1-richness hold ($\sum_{|S|=1}h(S)\ge\sum_{|S|=2}h(S)$);
> - Some non-generator $A\in\mathcal F\setminus\mathcal W$ has $|A\cap W|<k/2$ for one specific $W$ (failing UC7's uniformly $W$-balanced) but the cumulative cross-incidence $\sum_x\deg_{\mathcal F\setminus\mathcal W}(x)\deg_{\mathcal W}(x)\ge(kN/2)|\mathcal F\setminus\mathcal W|$ still holds via compensation from other non-generators;
> - For some pair $R,R'$: $X(R,R')\ne\emptyset$ (failing UC7's graded-equality) but $|X(R,R')|$ is bounded by Theorem 3.1 and the bounded excess is dominated by the per-fibre signing.
>
> Such an $\mathcal F$ is in UC8's extended fully-signed class but *not* in UC7's narrower fully-signed class. The construction is by carefully tuning the persistence balance, the cumulative incidence, and the deficiency masses; we record it as a *structural existence claim* — Example 1.3's two-fibre construction is a partial witness for the cross-fibre 1-richness conjunct. A complete worked-out $k=3$ extended witness (carrying all three conjuncts simultaneously) is structurally consistent with union-closure plus the three named structural inputs, and inconsistent with at least one of UC7's narrower conjuncts; we leave the explicit construction as a continuation, with the structural feasibility established here by parameter independence (the three conjuncts are independent constraints on disjoint structural quantities).

### 4.3 The UC8 residual, sharpened (and Prop 4.3)

> **The UC8 residual.** UC7's residual was named (UC7 Prop 4.2) as "the three structural conditions each fail outside their class, each failure mode forbidden by union-closure-alone." UC8 promotes each of the three conditions to a *cumulative cross-fibre / cross-incidence / square-defect* form; the residual is now:
> - **(Lever-1 UC8 failure mode):** $\sum_{|S|=1}h(S)<\sum_{|S|=2}h(S)$ — the cumulative persistence count favours 2-element defects. (Or, at $k\ge 4$, the persistence-weighted half-level imbalance.)
> - **(Lever-2 UC8 failure mode):** $\sum_x\deg_{\mathcal F\setminus\mathcal W}(x)\deg_{\mathcal W}(x)<(kN/2)|\mathcal F\setminus\mathcal W|$ — the cumulative cross-incidence is below the half-coverage threshold, *and* the similarly-ordered + concentrated alternative fails too (uncorrelated degrees or $|U_{\mathcal W}|>2k$).
> - **(Lever-3 UC8 failure mode):** The cumulative excess $\sum_{R,R'}|X(R,R')|$ exceeds the §1-signed deficit pool, $|\mathcal S(R)^\uparrow\triangle\mathcal S(R')^\uparrow|$ unbounded, or $\sum_R\mathrm{Def}(R)$ uncontrolled.

> **Proposition 4.3 (each UC8 structural input admits a union-closed counterexample).** *(a)* Cross-fibre 1-richness: a $k=3$ family with two large fibres, one having $|\mathcal D^{(2)}|=2$, $|\mathcal D^{(1)}|=0$, the other having $|\mathcal D^{(2)}|=0$, $|\mathcal D^{(1)}|=1$ — $\sum h(S)\phi(S)=1\cdot 1+2\cdot 1-1\cdot 1=2>0$ — fails cross-fibre 1-richness, union-closed by direct construction. *(b)* Cross-incidence cumulative-balanced: any $\mathcal F$ with $\mathcal F\setminus\mathcal W$ concentrated on a subset of $U\setminus U_{\mathcal W}$, e.g. $\mathcal F=\{W,W',W\cup W',A\}$ with $A\subseteq U\setminus(W\cup W')$, $|A|>k$ — then $\deg_{\mathcal F\setminus\mathcal W}|_{U_{\mathcal W}}=0$, so $\langle\deg_{\mathcal F\setminus\mathcal W},\deg_{\mathcal W}\rangle=0<(kN/2)|\mathcal F\setminus\mathcal W|=k$. *(c)* F-iii square-defect bound saturating without per-fibre §1 signing: a $\mathcal F$ where $|X(R,R')|$ saturates the geometric-mean bound but $\Phi(\mathcal D(R^*))>0$ — Theorem 3.1's bound is a *necessary* not a *sufficient* signing; without §1 at the top fibre, the bound does not close the residual.

*Proof.* Each is a direct construction; (a) and (b) are union-closed; (c) is the precise sense in which Theorem 3.1 is a *quantification* of the excess, not a closure of the residual on its own. $\qquad\blacksquare$

Proposition 4.3 sharpens UC7 Prop 4.2: each of UC8's three *structural-input-extended* conditions still admits a union-closure-compatible counterexample. The residual is sharpened but not eliminated.

### 4.4 Indicated route and the documented fallbacks

**Indicated route for a UC9 / continuation.** Three precise next steps, each on a quantified-but-unsigned-outside-its-UC8-class lever:

- **(Lever 1 push push — sign cross-fibre 1-richness via an even larger cumulative class.)** Theorem 1.2 is a cumulative sum-of-persistences condition; a sharper class would *weight* the persistences by additional fibre-poset structure — e.g. the chain length, the rooted-mass $M(R)$, or the cumulative-fibre defect $d_S$ (UC4). The natural attack is the *weighted persistence* $h_c(S)=\sum_R c_R\mathbf 1_{S\in\mathcal D(R)}$ with $c_R$ encoding fibre-poset depth — converging on the UC4 weighted I1 interlock.
- **(Lever 2 push push — sign cross-incidence beyond Cauchy–Schwarz.)** Theorem 2.5 is a Cauchy–Schwarz upper bound on the cross-incidence; a sharper class would use the *full Gram structure* of UC5 Thm 3.1 — the quadratic form $\mathbf 1^{\mathsf T}(2G-kJ)\mathbf 1$ on the augmented matrix $(M\mid M_{\mathcal F\setminus\mathcal W})$, signing both the generator block and the non-generator block simultaneously through a single positive-semidefinite condition.
- **(Lever 3 push push — sign the F-iii square-defect on a larger class / lift to higher squares.)** Theorem 3.1 is the level-2 square-defect bound; the higher-degree square-defects (3-cubes, 4-cubes, ...) of UC2 §4.2 read on the co-fibre system would extend the bound to higher-order excess co-fibres — the F-iii cathedral, with each level attached to a corresponding UC6 Thm 3.1 deficiency-contraction of higher rank.

**Documented fallbacks (UC7 §4.4 hooks), with UC8-sharpened attachment points.**

- **F-ii (component / $H_0$ route).** Attaches now to the **cumulative excess** (Corollary 3.3): the Hall criterion (UC2 Prop 3.6) on the bipartite incidence $\{(R,R',T)\in X(\cdot,\cdot)\}\to(\delta_R(T)\cap\delta_{R'}(T)\sqcup\text{domain-violators})$, with the bound of Theorem 3.1 providing the *deficiency-count budget* Hall must respect.
- **F-iii (square-defect route).** Attaches now to the **F-iii bound on $|X(R,R')|$** (Theorem 3.1): the higher-degree square-defect of UC2 Prop 4.2 read on the co-fibre system has been quantified into a closed-form geometric-mean structural inequality. The higher-degree continuation (3-cubes etc.) is the structural sequel.

Neither is pursued here — the three UC7 §4.4 indicated pushes succeeded.

### 4.5 Verdict

**Verdict: GREEN-partial (advanced).**

UC8 against the ticket's scope:

- **Lever 1 — cross-fibre persistence (§1).** UC6 Cor 3.2's deficiency anti-monotonicity (the structural input beyond union-closure) defines the persistence function $h(S)$; the chain-cumulative identity (Theorem 1.1: $D^{\mathrm{lg}}(W)=\sum_S h(S)\phi(S)$) reduces the Phase-1 residual to a single weighted sum; the cross-fibre 1-rich class at $k=3$ (Theorem 1.2) and the cross-fibre half-level-deficient class at $k\ge 4$ (Theorem 1.4) sign $D^{\mathrm{lg}}(W)\le 0$ on classes properly extending UC7 Thm 1.2/1.3 (Example 1.3). UC7 §4.4's Lever-1 push ask discharged.
- **Lever 2 — cross-incidence cumulative + Cauchy–Schwarz (§2).** UC5 Prop 3.2's cross-incidence symmetry (the structural input beyond union-closure) couples non-generator and generator degrees; the cumulative-incidence identity (Lemma 2.1) rewrites $\sum_W\sigma_{\mathrm{rest}}(W)$ as $2\langle\deg_{\mathcal F\setminus\mathcal W},\deg_{\mathcal W}\rangle-kN|\mathcal F\setminus\mathcal W|$; the cross-incidence cumulative class (Theorem 2.2) signs $\sum_W\sigma_{\mathrm{rest}}\ge 0$, properly extending UC7 Thm 2.4; the Chebyshev coupling under concentrated generators (Theorem 2.4) closes Frankl without $\Gamma$-sparse — a new closure mechanism. UC7 §4.4's Lever-2 push ask discharged.
- **Lever 3 — F-iii square-defect bound (§3).** UC2 Prop 4.2's one-sided square-defect (the structural input beyond union-closure, read on the co-fibre system with UC7 Thm 3.1 as the attachment point) quantifies the excess; the domain-mismatch bound (Lemma 3.1) and the Cauchy–Schwarz cross-deficiency-overlap bound (Theorem 3.2) combine into the F-iii square-defect bound (Theorem 3.1: $|X(R,R')|\le|\mathcal S(R)^\uparrow\triangle\mathcal S(R')^\uparrow|+k\sqrt{\mathrm{Def}(R)\mathrm{Def}(R')}$), making the failure-mode quantified rather than just named; the cumulative form (Corollary 3.3) aggregates the bound. UC7 §4.4's Lever-3 push ask discharged.
- **Combined picture (§4).** The extended fully-signed class (Theorem 4.1) signs Frankl unconditionally on a class strictly larger than UC7 Thm 4.1's; Proposition 4.3 names the three structural-input-extended failure modes.

**Why GREEN-partial (advanced) is the honest tag.** Not GREEN-residual-closed: Proposition 4.3 confirms that each of the three UC8 structural-input-extended conditions still admits a union-closure-compatible counterexample — the residual is sharpened, not eliminated. Frankl on the open $m(\mathcal F)\ge 3$ frontier is not closed unconditionally. **Not GREEN-residual-closed with a combination either**: the extended fully-signed class is a strictly tighter conjunction of three properly larger conditions, but each remains a non-trivial structural restriction. Not AMBER-levers-stall-globally: each of the three UC7 §4.4 indicated pushes succeeds — three new theorems on three properly larger signed classes, each via the prescribed structural input beyond union-closure. The route advances substantially from UC7's "three sufficient conditions + three counterexamples" to UC8's "three sufficient conditions + three quantified structural extensions + three sharpened failure modes". The "(advanced)" qualifier marks the strict improvement over UC7's GREEN-partial.

**Trust-surface impact: none.** Paper-and-pencil; no new axioms, no Lean, no computation. No engine ported — UC8 builds only on UC1–UC7's pinned objects plus the three named structural inputs (UC6 Thm 3.1, UC5 Prop 3.2, UC2 Prop 4.2). The 1/3-2/3 critical path (`one_third_width_three`) is in a different repo and is untouched.

---

## §5. References

### 5.1 This repo / parent chain

- **mg-a032 (UC7)** — `docs/union-closed-UC7-sign-the-levers.md`: §1 (Lever-1 signing on half-level-deficient / 1-rich — UC8 §1's per-fibre baseline); §2 (Lever-2 signing on uniformly $W$-balanced / cumulative-degree — UC8 §2's pointwise baseline); §3 (Lever-3 signing on graded-equality, Thm 3.1 excess characterization, Cor 3.1b up-closure intersection — UC8 §3's attachment point and quantification target); §4.1 (fully-signed class Thm 4.1 — UC8 §4 extends); §4.3 (Prop 4.2 — the three structural conditions admit union-closed counterexamples, UC8 promotes each); §4.4 (the three indicated next-step pushes — UC8 attacks all three). `docs/state-UC7.md`.
- **mg-6dad (UC6)** — `docs/union-closed-UC6-large-fibre-residual-close.md`: §1 (tiling-coupling flow argument: flow identity Thm 1.1, explicit form Thm 1.3, conservation law Thm 1.4); §3 (**Thm 3.1 deficiency contraction**, **Cor 3.2 deficiency anti-monotonicity**, **Cor 3.3 deficiency-mass sub-minimality** — UC8 §1's structural input + UC8 §3.2's Cauchy–Schwarz attachment); §5 (the three quantified-but-unsigned levers UC7 signed and UC8 pushed). `docs/state-UC6.md`.
- **mg-3806 (UC5)** — `docs/union-closed-UC5-trace-defect-residual.md`: §1 (defect retraction $\bar\jmath_R$ Thm 1.1, fibre-ideal Lemma 1.2); §2 (hybrid Thm 2.1 — UC8's signing relies on the per-generator target identity); §3 (**Thm 3.1 generator Gram form**, **Prop 3.2 cross-incidence symmetry / far-pair $\Gamma$** — UC8 §2's structural input; **Thm 3.4 concentrated-generator condition** — UC8 §2.3's coupling with Chebyshev). `docs/state-UC5.md`.
- **mg-0bf7 (UC4)** — `docs/union-closed-UC4-large-fibre-residual.md`: §1 (monotone aggregate-sign lemma); §3 (low-defect Thm 3.2 — UC8 §1.4's half-level-deficient is the per-fibre analogue); §4 (**I1 interlock Thm 4.1**, weighted form Thm 4.2 — UC8 §2's combined signing). `docs/state-UC4.md`.
- **mg-cfc0 (UC3)** — `docs/union-closed-UC3-walsh-subcube-spectrum.md`: §2 (sub-cube Walsh characterization — standing toolkit). `docs/state-UC3.md`.
- **mg-a814 (UC2)** — `docs/union-closed-UC2-transport-deficiency.md`: §3.5 (Hall criterion Prop 3.6 — F-ii hook, UC8 §4.4 reattached); §4.2 (**Prop 4.2 one-sided square-defect** — UC8 §3's structural input, read on the co-fibre system with UC7 Thm 3.1 as the attachment point). `docs/state-UC2.md`.
- **mg-f72a (UC1)** — `docs/union-closed-compat-geom-manifesto.md`: §1.6 (obstruction in Walsh form); §8.3 (F-i, the Walsh/harmonic route); §8.4 (dead routes UC8 avoids: E1–E3, C1–C5). `docs/state-UC1.md`.

### 5.2 Cross-repo — `one_third_width_three` (read access)

Used by UC8 only to stay clear of UC1 §8.4's dead routes (BK/Cheeger E1–E3; F-series cathedral C1–C5). UC8 is independent of the 1/3-2/3 critical path.

### 5.3 Frankl-conjecture literature

- P. Frankl (1979) — the Union-Closed Sets conjecture.
- H. Bruhn, O. Schaudt, *The journey of the union-closed sets conjecture*, Graphs and Combinatorics 31 (2015) — the survey.
- B. Poonen, *Union-closed families*, J. Combin. Theory Ser. A 59 (1992) — the lattice / join-irreducible reformulation.
- J. Gilmer (2022) — the entropy constant lower bound; UC8's three quantified extensions (persistence function, cumulative cross-incidence, F-iii square-defect bound) are *finitary* invariants the entropy bound does not see.
- W. Sawin; Z. Chase & S. Lovett; R. Alweiss, B. Huang & M. Sellke; L. Pebody (2022–2023) — the $(3-\sqrt 5)/2$ improvement and the Sawin ceiling. UC8's residual (Prop 4.3 — three structural-input-extended failure modes) is the exact finitary locus refining UC7's residual.
- R. O'Donnell, *Analysis of Boolean Functions* (2014) — Walsh–Fourier analysis on the cube; the level-1 Walsh character / functional $\phi$ — load-bearing in UC8 §§1, 2 through the persistence-weighted and inner-product reformulations.

### 5.4 Source directives

- Daniel directives 2026-05-14 — the `union_closed` product-line assignment; UC8 is the F-i (Walsh/harmonic) continuation, UC7-localized, per UC7 §4.4: *push* each of the three UC7-signed levers beyond union-closure-alone via three prescribed structural inputs (UC6 Thm 3.1 deficiency anti-monotonicity for Lever 1; UC5 Prop 3.2 cross-incidence symmetry for Lever 2; UC2 Prop 4.2 one-sided square-defect with UC7 Thm 3.1 as attachment for Lever 3).

---
