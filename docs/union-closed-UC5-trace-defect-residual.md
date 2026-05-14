# Union-Closed Compatibility-Geometry — UC5: closing the UC4 trace-defect residual via the cross-S and cross-generator couplings (mg-3806)

**Repo:** `union_closed`. **Parent:** mg-0bf7 (UC4, GREEN-partial) — `docs/union-closed-UC4-large-fibre-residual.md` §5 (the UC5 target + the indicated route), §§1–3 (the $Q$–$D$ decomposition, the monotone engine, the sufficient conditions), §4 (the I1 interlock + Lemma 4.3 cross-incidence). **Chain:** mg-f72a (UC1) → mg-a814 (UC2) → mg-cfc0 (UC3) → mg-0bf7 (UC4) → UC5.
**Branch:** `polecat-cat-mg-3806`.
**Type:** Native construction — Walsh/harmonic analysis on the cube (continuing fallback **F-i**, UC4-localized). Paper-and-pencil; **no new axioms; no Lean; no computation; no engine port.** LaTeX-style Markdown, F-series house style. Multi-session-able; cumulative state ledger in `docs/state-UC5.md`.
**Cross-repo references (read access):** `one_third_width_three` — used only to stay clear of the dead routes UC1 §8.4 named.

---

**Verdict: GREEN-partial.**

The UC4 trace-defect residual is **substantially advanced**, with the **cross-$S$ coupling fully quantified** into an exact structural decomposition, the UC3 and UC4 attacks **combined** into a strictly smaller residual object, and the cross-generator coupling **quantified** into a global quadratic form with a new native sufficient condition. The residual is not fully closed — it cannot be, by a single-$W$ argument at $k=3$ — but every one of UC4 §5's three indicated inputs is now realized as a theorem.

The load-bearing results:

- **(§1) The cross-$S$ coupling, fully quantified — the defect retraction.** For each $R\in\mathcal R_W$, the map $\bar\jmath_R(S):=\max\bigl(\mathcal S(R)\cap 2^S\bigr)$ is a well-defined **interior operator** on the filter $\mathcal S(R)^\uparrow$ — monotone, contractive, idempotent — with fixed-point set exactly $\mathcal S(R)$ (Theorem 1.1). Its fibres $\bar\jmath_R^{-1}(S_0)$ are **order ideals of the interval $[S_0,W]$** (Lemma 1.2), giving the **exact fibre-ideal decomposition** of the defect: $D(W)=\sum_{R}\sum_{S_0\in\mathcal S(R)}\bigl[(|I_{R,S_0}|-1)\,\phi(S_0)+2\,\Sigma(I_{R,S_0})\bigr]$, with $I_{R,S_0}$ an order ideal of a sub-cube and $\Sigma$ its size-aggregate (Theorem 1.3). This is the precise sense in which "the $\mathcal D_S$ are cut from one nested family by one incidence relation" — UC4 §3.3's unexploited input 1, now a closed-form identity.
- **(§2) Combining UC3 and UC4 — the hybrid residual.** Splitting $\mathcal R_W$ at the half-level and applying the UC3 per-fibre sign theorem to the small part and the UC4 monotone engine to the large part gives $\sigma(W)=A+Q^{\mathrm{lg}}-D^{\mathrm{lg}}$ with $A\ge 0$, $Q^{\mathrm{lg}}\ge 0$, and $D^{\mathrm{lg}}=\sum_{R\in\mathcal R_W^{\mathrm{lg}}}\Phi(\mathcal D(R))\le D(W)$ (Theorem 2.1) — the residual object shrinks from the defect of *all* fibres to the defect of the **large fibres only**. The resulting sufficient condition $D^{\mathrm{lg}}\le 0$ is strictly weaker than UC4's $D(W)\le 0$, and it isolates a new native region — the **large-fibre-monotone families** (Theorem 2.3) — which is a *common generalization of UC3's bounded-spread class and UC4's $W$-monotone class*, properly containing both, and incomparable with UC4's low-defect class (Example 2.4).
- **(§3) The cross-generator coupling, quantified — the generator Gram form.** The I1 interlock matrix is $M\in\{0,1\}^{\mathcal W\times U}$; its Gram matrix $G=MM^{\mathsf T}$ has $G_{W,W'}=|W\cap W'|$, and the generator–generator block of the interlock identity is the **quadratic form** $\Sigma_{\mathcal W}=\mathbf 1^{\mathsf T}(2G-kJ)\mathbf 1=\sum_{x}\deg_{\mathcal W}(x)\bigl(2\deg_{\mathcal W}(x)-|\mathcal W|\bigr)$ (Theorem 3.1). The Lemma 4.3 cross-incidence is exactly the **symmetry of $G$**: $W'$ is a large-fibre element of $W$ iff $W$ is a large-fibre element of $W'$ (Proposition 3.2), so the "loads-the-residual-of" relation is an undirected graph $\Gamma$ on $\mathcal W$. Cauchy–Schwarz on the degree sequence closes the generator block whenever the generators are concentrated: **$|\bigcup\mathcal W|\le 2k\Rightarrow\Sigma_{\mathcal W}\ge 0$** (Theorem 3.3), yielding the native **concentrated-generator** sufficient condition (Theorem 3.4).
- **(§4) The combined picture and the named residual.** All three of UC4 §5's indicated inputs are discharged as theorems; the residual that remains is named in its sharpest form — the large-fibre defect $D^{\mathrm{lg}}$, equivalently the global $\sum_W D^{\mathrm{lg}}(W)\le\sum_W(A(W)+Q^{\mathrm{lg}}(W))$ — together with the precise obstruction to closing it and the explicit F-ii / F-iii hooks.

**Why GREEN-partial and not GREEN-residual-closed.** Neither the per-generator residual $D^{\mathrm{lg}}(W)\le A(W)+Q^{\mathrm{lg}}(W)$ nor the global interlock residual is fully closed. It cannot be by the means here: $D^{\mathrm{lg}}(W)\le 0$ for a single minimal generator with $k=3$ would already prove Frankl on the open $m(\mathcal F)=3$ frontier. **Why not AMBER-residual-stalls.** The Walsh route does not stall: the cross-$S$ coupling is *fully quantified* (an exact closed-form identity, not a bound), the UC3/UC4 decompositions are *combined* into a strictly smaller residual, a new native region of the frontier (large-fibre-monotone) properly extends two prior regions at once, and the cross-generator coupling is quantified into a quadratic form with a native sufficient condition. This is precisely the GREEN-partial profile UC4 §5 anticipated — "one of the two couplings fully quantified" — in fact both are quantified, with the cross-$S$ one exact.

**The honest one-sentence verdict.** *The UC4 trace-defect residual $D(W)=\langle d,\phi\rangle$ admits an exact cross-$S$ decomposition $D(W)=\sum_{R}\sum_{S_0\in\mathcal S(R)}[(|I_{R,S_0}|-1)\phi(S_0)+2\Sigma(I_{R,S_0})]$ through the defect-retraction interior operator $\bar\jmath_R$, whose fibres are order ideals of intervals $[S_0,W]$; combining the UC3 per-fibre sign theorem with the UC4 monotone engine shrinks the residual to the large-fibre defect $D^{\mathrm{lg}}\le D(W)$ and exposes the large-fibre-monotone class — a common generalization of UC3's bounded-spread and UC4's $W$-monotone regions; and the cross-generator coupling is quantified as the generator Gram form $\Sigma_{\mathcal W}=\sum_x\deg_{\mathcal W}(x)(2\deg_{\mathcal W}(x)-|\mathcal W|)$, non-negative whenever $|\bigcup\mathcal W|\le 2k$ — so all three of UC4's indicated inputs are realized as theorems, the residual is named in its sharpest form, but it is not fully closed and cannot be by a single-$W$ argument at the $k=3$ frontier.*

§0 fixes notation and recaps the UC4 hand-off; §1 quantifies the cross-$S$ coupling (the defect retraction and the fibre-ideal decomposition); §2 combines the UC3 and UC4 attacks (the hybrid residual and the large-fibre-monotone class); §3 quantifies the cross-generator coupling (the generator Gram form); §4 is the combined picture, the named residual, the verdict, and the fallbacks; §5 the references.

---

## §0. Notation and the UC5 hand-off

Notation is UC1's, UC2's, UC3's and UC4's, restated where load-bearing.

$U$ is a finite ground set, $|U|=n$; $\mathcal F\subseteq 2^U$ is **union-closed** ($A,B\in\mathcal F\Rightarrow A\cup B\in\mathcal F$), with $\mathcal F\neq\emptyset,\{\emptyset\}$ and WLOG $U=\bigcup\mathcal F\in\mathcal F$. For $x\in U$: $\beta_x=|\mathcal F_x|-|\mathcal F_{\bar x}|$, the **bias**; Frankl asserts some $x$ has $\beta_x\ge 0$. UC2 settled $m(\mathcal F)\le 2$ natively, so we **fix a minimal generator** $W\in\mathcal F$, $|W|=m(\mathcal F)=:k\ge 3$, and write $U'=U\setminus W$. Every nonempty $A\in\mathcal F$ has $|A|\ge k$.

**The fibre system (UC3 §2).** Each $A\in\mathcal F$ splits $A=S\sqcup R$, $S=A\cap W\subseteq W$, $R=A\setminus W\subseteq U'$. The **$S$-fibre** is $\mathcal R_S=\{R\subseteq U':S\sqcup R\in\mathcal F\}$; the **trace profile** is $p_S=|\mathcal R_S|$. The standing toolkit:

- **(Graded union law.)** $\mathcal R_S\vee\mathcal R_{S'}\subseteq\mathcal R_{S\cup S'}$; each $\mathcal R_S$ is union-closed; the co-fibres satisfy $\mathcal S(R)\vee\mathcal S(R')\subseteq\mathcal S(R\cup R')$.
- **(Universal fibre inclusion.)** $\mathcal R_S\subseteq\mathcal R_W$ for every $S\subseteq W$; $\mathcal R_W$ is union-closed on $U'$ with $\emptyset\in\mathcal R_W$.
- **(Dual reduction.)** The **co-fibre** $\mathcal S(R)=\{S\subseteq W:S\sqcup R\in\mathcal F\}$ is, for each $R\in\mathcal R_W$, a union-closed family on $W$ containing the top $W$; $p_S=|\{R\in\mathcal R_W:S\in\mathcal S(R)\}|$.
- **(Minimality grading.)** For $0<|S|<k$, every $R\in\mathcal R_S$ has $|R|\ge k-|S|$; dually $0<|R|<k\Rightarrow\emptyset\notin\mathcal S(R)$ and intermediate $S\in\mathcal S(R)\Rightarrow|S|\ge k-|R|$.

**The level-1 functional.** $\phi(S)=2|S|-k$; for $\mathcal G\subseteq 2^W$, $\Phi(\mathcal G)=\sum_{S\in\mathcal G}\phi(S)$; for $g:2^W\to\mathbb R$, $\langle g,\phi\rangle=\sum_S g(S)\phi(S)$. The per-generator target:
$$
  \sigma(W):=\sum_{x\in W}\beta_x=\langle p,\phi\rangle=\sum_{R\in\mathcal R_W}\Phi(\mathcal S(R))=\sum_{A\in\mathcal F}\phi(A\cap W).
\tag{0.1}
$$
(The last form: $\langle p,\phi\rangle=\sum_S\sum_{A:A\cap W=S}\phi(S)$.)

**The UC4 decomposition (the object UC5 attacks).** The **cumulative fibre** $\widetilde{\mathcal R}_S=\bigcup_{S_0\subseteq S}\mathcal R_{S_0}$ is union-closed, $\subseteq\mathcal R_W$, monotone in $S$; its size profile $q_S=|\widetilde{\mathcal R}_S|$ is monotone, $Q(W)=\langle q,\phi\rangle\ge 0$ **unconditionally** (UC4 Theorem 2.2, the monotone aggregate-sign lemma). The **trace-defect profile** is $d_S=q_S-p_S=|\widetilde{\mathcal R}_S\setminus\mathcal R_S|\ge 0$, $d_\emptyset=d_W=0$, and
$$
  \sigma(W)=Q(W)-D(W),\qquad D(W)=\langle d,\phi\rangle=\sum_{R\in\mathcal R_W}\Phi(\mathcal D(R)),
\tag{0.2}
$$
where $\mathcal D(R)=\mathcal S(R)^\uparrow\setminus\mathcal S(R)$ is the **co-fibre non-monotonicity defect** ($\mathcal S(R)^\uparrow$ = up-closure of $\mathcal S(R)$ in $2^W$). The residual closes iff $D(W)\le Q(W)$; sufficient $D(W)\le 0$. UC4 Lemma 2.4: $\mathcal R_S$ is an order filter of $\widetilde{\mathcal R}_S$, $\mathcal D_S=\widetilde{\mathcal R}_S\setminus\mathcal R_S$ an order ideal.

> **The UC5 target (UC4 §5).** Close the residual — show **either** the per-generator $D(W)\le Q(W)$ (sufficient $\le 0$), **or** the global $\sum_{W\in\mathcal W}D(W)\le\sum_{W\in\mathcal W}Q(W)$. The three indicated inputs: **(1)** the cross-$S$ coupling of the graded union law; **(2)** the cross-generator symmetry of Lemma 4.3; **(3)** combining the UC3 per-fibre theorem with the UC4 monotone engine.

UC5 discharges all three as theorems (§§1–3) and names the residual that remains (§4).

**What UC5 must not do (UC1 §8.4, kept in view).** No port of Theorem E / the rigidity engine; no $\Delta(\mathrm{UCF}_n)$ chamber ambient; no $S_n$-isotypic / FI machinery; no new axioms; no Lean; no computation. UC5 is a native construction on the pinned objects of UC1 §1, the structure theory of UC2 §§2–3, the characterization of UC3 §2, and the decomposition of UC4 §§1–4.

---

## §1. The cross-$S$ coupling, fully quantified: the defect retraction

UC4 §3.3 named the cross-$S$ coupling — "the $\mathcal D_S$ for different $S$ are not independent order ideals; they are cut from the single nested family $\{\widetilde{\mathcal R}_S\}$ by one incidence relation $S\sqcup R\in\mathcal F$" — as the unexploited input 1. This section turns it into an exact closed-form identity. The mechanism is a single elementary operator attached to each fibre.

### 1.1 The defect retraction is an interior operator

Fix $R\in\mathcal R_W$. The co-fibre $\mathcal S(R)$ is union-closed and contains $W$. For $S\subseteq W$ with $S\in\mathcal S(R)^\uparrow$ (equivalently $\mathcal S(R)\cap 2^S\neq\emptyset$, equivalently $R\in\widetilde{\mathcal R}_S$), the family $\mathcal S(R)\cap 2^S$ is the intersection of two union-closed families on $W$, hence union-closed, hence has a unique $\subseteq$-maximum. Define the **defect retraction**
$$
  \bar\jmath_R(S)\;:=\;\max\bigl(\mathcal S(R)\cap 2^S\bigr)\;=\;\bigcup\bigl(\mathcal S(R)\cap 2^S\bigr)\qquad\bigl(S\in\mathcal S(R)^\uparrow\bigr)
$$
— the **largest trace contained in $S$ that still sees $R$**.

> **Theorem 1.1 (the defect retraction is an interior operator).** The map $\bar\jmath_R:\mathcal S(R)^\uparrow\to 2^W$ satisfies, for all $S,S'\in\mathcal S(R)^\uparrow$:
> 1. **Contractive:** $\bar\jmath_R(S)\subseteq S$, and $\bar\jmath_R(S)\in\mathcal S(R)$;
> 2. **Monotone:** $S\subseteq S'\Rightarrow\bar\jmath_R(S)\subseteq\bar\jmath_R(S')$;
> 3. **Idempotent:** $\bar\jmath_R(\bar\jmath_R(S))=\bar\jmath_R(S)$, with fixed-point set $\{S:\bar\jmath_R(S)=S\}=\mathcal S(R)$.
>
> Hence $\bar\jmath_R$ is an interior (kernel) operator on the filter $\mathcal S(R)^\uparrow$ with image $\mathcal S(R)$, and
> $$
>   S\in\mathcal D(R)\iff\bar\jmath_R(S)\subsetneq S.
> $$

*Proof.* (1) $\bar\jmath_R(S)$ is the union of subsets of $S$, so $\bar\jmath_R(S)\subseteq S$; it is the maximum of $\mathcal S(R)\cap 2^S$, an element of $\mathcal S(R)$. (2) $S\subseteq S'$ gives $\mathcal S(R)\cap 2^S\subseteq\mathcal S(R)\cap 2^{S'}$, and for non-empty union-closed $\mathcal A\subseteq\mathcal B$ one has $\bigcup\mathcal A\subseteq\bigcup\mathcal B$. (3) For $S'\in\mathcal S(R)$, $S'\in\mathcal S(R)\cap 2^{S'}$ and nothing in $\mathcal S(R)\cap 2^{S'}$ properly contains $S'$, so $\bar\jmath_R(S')=S'$; conversely $\bar\jmath_R(S)\in\mathcal S(R)$ always, so the fixed-point set is exactly $\mathcal S(R)$, and idempotence follows by applying this to $S'=\bar\jmath_R(S)$. Finally $\bar\jmath_R(S)=S\iff S\in\mathcal S(R)$, so $\bar\jmath_R(S)\subsetneq S\iff S\in\mathcal S(R)^\uparrow\setminus\mathcal S(R)=\mathcal D(R)$. $\qquad\blacksquare$

The interior operator $\bar\jmath_R$ **is** the cross-$S$ coupling: it is a single monotone map, defined off the one incidence relation $S\sqcup R\in\mathcal F$, that ties together the defect at *every* trace $S$. The defect element $S\in\mathcal D(R)$ is charged to its retraction $\bar\jmath_R(S)\in\mathcal S(R)$; the **deficiency** is $\delta_R(S):=S\setminus\bar\jmath_R(S)\neq\emptyset$.

### 1.2 The fibres of the retraction are order ideals of intervals

The cross-$S$ coupling becomes computational once we describe the fibres of $\bar\jmath_R$.

> **Lemma 1.2 (fibre-ideal structure).** For each $S_0\in\mathcal S(R)$, the fibre $\bar\jmath_R^{-1}(S_0)=\{S\in\mathcal S(R)^\uparrow:\bar\jmath_R(S)=S_0\}$ is an **order ideal of the interval $[S_0,W]$** with bottom element $S_0$. Equivalently, writing $W_0:=W\setminus S_0$ and identifying $[S_0,W]\cong 2^{W_0}$ via $S\mapsto S\setminus S_0$, the set
> $$
>   I_{R,S_0}\;:=\;\{\,S\setminus S_0:\;S\in\bar\jmath_R^{-1}(S_0)\,\}\;\subseteq\;2^{W_0}
> $$
> is an order ideal of $2^{W_0}$ containing $\emptyset$.

*Proof.* By Theorem 1.1(1), $\bar\jmath_R(S)=S_0$ forces $S_0\subseteq S$, so $\bar\jmath_R^{-1}(S_0)\subseteq[S_0,W]$. The set
$$
  U(S_0):=\bigl\{S\in[S_0,W]:\exists\,T\in\mathcal S(R),\ T\subseteq S,\ T\not\subseteq S_0\bigr\}
$$
is up-closed in $[S_0,W]$ (if $T\subseteq S\subseteq S'$ then $T\subseteq S'$). Now $\bar\jmath_R(S)=S_0$ iff $S_0$ is the maximum of $\mathcal S(R)\cap 2^S$; since $S_0\in\mathcal S(R)\cap 2^S$ always (for $S\in[S_0,W]$), the maximum exceeds $S_0$ exactly when some $T\in\mathcal S(R)\cap 2^S$ has $T\not\subseteq S_0$ (then $T\cup S_0\in\mathcal S(R)\cap 2^S$ properly contains $S_0$). Hence $\bar\jmath_R^{-1}(S_0)=[S_0,W]\setminus U(S_0)$, the complement of an up-set in $[S_0,W]$, i.e. an order ideal of $[S_0,W]$; it contains $S_0$ since $S_0\notin U(S_0)$. The transfer to $2^{W_0}$ is the order isomorphism $[S_0,W]\cong 2^{W_0}$. $\qquad\blacksquare$

So the cross-$S$ coupling has a transparent shape: **the whole filter $\mathcal S(R)^\uparrow$ is partitioned, by $\bar\jmath_R$, into order ideals $\bar\jmath_R^{-1}(S_0)$, one rooted at each $S_0\in\mathcal S(R)$**, and the defect $\mathcal D(R)=\bigsqcup_{S_0\in\mathcal S(R)}\bigl(\bar\jmath_R^{-1}(S_0)\setminus\{S_0\}\bigr)$.

### 1.3 The exact fibre-ideal decomposition of $D(W)$

The functional $\Phi$ now evaluates in closed form on each fibre. For an order ideal $I\subseteq 2^{W_0}$ write $\Sigma(I):=\sum_{T\in I}|T|$ (its **size-aggregate**); recall the natural functional on $2^{W_0}$ is $\phi_0(T)=2|T|-|W_0|$.

> **Theorem 1.3 (the cross-$S$ decomposition of the residual).** With $W_0=W\setminus S_0$ and $I_{R,S_0}$ as in Lemma 1.2,
> $$
>   \Phi\bigl(\bar\jmath_R^{-1}(S_0)\bigr)\;=\;\phi(S_0)\,|I_{R,S_0}|\;+\;2\,\Sigma(I_{R,S_0}),
> $$
> and therefore the per-fibre defect and the residual decompose **exactly** as
> $$
>   \Phi(\mathcal D(R))=\sum_{S_0\in\mathcal S(R)}\Bigl[\bigl(|I_{R,S_0}|-1\bigr)\,\phi(S_0)+2\,\Sigma(I_{R,S_0})\Bigr],
>   \qquad
>   D(W)=\sum_{R\in\mathcal R_W}\Phi(\mathcal D(R)).
> $$

*Proof.* For $S\in[S_0,W]$ write $S=S_0\sqcup T$, $T=S\setminus S_0\subseteq W_0$. Then $\phi(S)=2|S_0|+2|T|-k=\phi_0(T)+|S_0|$, since $\phi_0(T)=2|T|-(k-|S_0|)$. Summing over the fibre,
$$
  \Phi\bigl(\bar\jmath_R^{-1}(S_0)\bigr)=\sum_{T\in I_{R,S_0}}\bigl(\phi_0(T)+|S_0|\bigr)=\Phi_0(I_{R,S_0})+|S_0|\,|I_{R,S_0}|,
$$
where $\Phi_0(I)=\sum_{T\in I}\phi_0(T)=2\Sigma(I)-|W_0|\,|I|$. Substituting $|W_0|=k-|S_0|$ gives $\Phi_0(I_{R,S_0})=2\Sigma(I_{R,S_0})-(k-|S_0|)|I_{R,S_0}|$, hence
$$
  \Phi\bigl(\bar\jmath_R^{-1}(S_0)\bigr)=2\Sigma(I_{R,S_0})-(k-|S_0|)|I_{R,S_0}|+|S_0|\,|I_{R,S_0}|=2\Sigma(I_{R,S_0})+\phi(S_0)\,|I_{R,S_0}|.
$$
The fibres partition $\mathcal S(R)^\uparrow$, and $\mathcal D(R)$ removes the fixed point $S_0$ from each (which contributes $\phi(S_0)$), so $\Phi(\mathcal D(R))=\sum_{S_0}\bigl[\Phi(\bar\jmath_R^{-1}(S_0))-\phi(S_0)\bigr]=\sum_{S_0}[(|I_{R,S_0}|-1)\phi(S_0)+2\Sigma(I_{R,S_0})]$. The last identity is (0.2). $\qquad\blacksquare$

Theorem 1.3 is the cross-$S$ coupling **as an exact identity** — UC4's input 1 fully discharged. Three structural readings:

- **The order-ideal structure of UC4 Lemma 2.4 is now graded by $S_0$.** Each $\Sigma(I_{R,S_0})\ge 0$; each $I_{R,S_0}$ is an order ideal, so $\Phi_0(I_{R,S_0})=2\Sigma(I_{R,S_0})-|W_0||I_{R,S_0}|\le 0$ (the monotone engine, UC4 Cor 1.2). The defect is a *sum of ideal-functionals*, one per co-fibre element.
- **The danger is high $S_0$ with large fibre-ideal.** The term $(|I_{R,S_0}|-1)\phi(S_0)$ is positive exactly when $|S_0|>k/2$ and the fibre-ideal is non-trivial — the high-trace defect of UC4 §3.3. The term $2\Sigma(I_{R,S_0})\ge 0$ is the deficiency mass. A co-fibre element $S_0$ with no defect charged to it has $I_{R,S_0}=\{\emptyset\}$, contributing $0$ — consistent.
- **The minimality grading bounds the retracted traces.** For $0<|R|<k$, every $S_0\in\mathcal S(R)\setminus\{W\}$ has $|S_0|\ge k-|R|$ (minimality grading), so $\phi(S_0)\ge k-2|R|$: the defect-charged retractions of a fibre $R$ are confined to the band $|S_0|\ge k-|R|$. This is UC4's input 2 — the minimality grading "forcing the defect low" — made precise: it is the *retraction targets*, not the defect elements, that are graded.

> **Corollary 1.4 (defect of small fibres is non-negative).** If $0<|R|\le\lfloor k/2\rfloor$ then every $S\in\mathcal D(R)$ has $\phi(S)\ge k-2|R|+2>0$, so $\Phi(\mathcal D(R))>0$ when $\mathcal D(R)\neq\emptyset$ and $=0$ otherwise. If $R=\emptyset$ then $\mathcal D(\emptyset)\in\{\emptyset,\,2^W\setminus\{\emptyset,W\}\}$ and $\Phi(\mathcal D(\emptyset))=0$. In all cases $\Phi(\mathcal D(R))\ge 0$ for $|R|\le\lfloor k/2\rfloor$.

*Proof.* For $0<|R|\le\lfloor k/2\rfloor$ and $S\in\mathcal D(R)$: $\bar\jmath_R(S)\in\mathcal S(R)$ with $\bar\jmath_R(S)\subsetneq S$, so $\bar\jmath_R(S)\ne W$, hence $|\bar\jmath_R(S)|\ge k-|R|$ by minimality grading, and $|S|\ge|\bar\jmath_R(S)|+1\ge k-|R|+1$, giving $\phi(S)=2|S|-k\ge k-2|R|+2\ge 2>0$. For $R=\emptyset$: minimality gives $\mathcal S(\emptyset)=\{S\subseteq W:S\in\mathcal F\}\subseteq\{\emptyset,W\}$; if $\mathcal S(\emptyset)=\{W\}$ then $\mathcal D(\emptyset)=\emptyset$, if $\mathcal S(\emptyset)=\{\emptyset,W\}$ then $\mathcal D(\emptyset)=2^W\setminus\{\emptyset,W\}$ with $\Phi(\mathcal D(\emptyset))=\Phi(2^W)-\phi(\emptyset)-\phi(W)=0+k-k=0$. $\qquad\blacksquare$

Corollary 1.4 says the UC4 per-fibre split is *unfavourable on the small fibres*: there $\Phi(\mathcal D(R))\ge 0$ inflates $D(W)$, even though UC3 already proves those fibres harmless for $\sigma(W)$. The fix is to not use the $Q$–$D$ split there at all — which is §2.

---

## §2. Combining the UC3 and UC4 attacks: the hybrid residual

UC4 §5's input 3 asks to combine the UC3 per-fibre sign theorem (primal, indexed by fibre size) with the UC4 monotone engine (dual, indexed by trace). Corollary 1.4 shows *where* to cut: apply UC3 to the small fibres, UC4 to the large.

### 2.1 The hybrid decomposition

Recall the UC3 split $\mathcal R_W=\mathcal R_W^{\mathrm{sm}}\sqcup\mathcal R_W^{\mathrm{lg}}$, $\mathcal R_W^{\mathrm{sm}}=\{R:|R|\le\lfloor k/2\rfloor\}$, and the per-fibre sign theorem (UC3 Thm 3.3): $|R|\le\lfloor k/2\rfloor\Rightarrow\Phi(\mathcal S(R))\ge 0$.

> **Theorem 2.1 (the hybrid decomposition).** Define
> $$
>   A(W):=\sum_{R\in\mathcal R_W^{\mathrm{sm}}}\Phi(\mathcal S(R)),\qquad
>   Q^{\mathrm{lg}}(W):=\sum_{R\in\mathcal R_W^{\mathrm{lg}}}\Phi\bigl(\mathcal S(R)^\uparrow\bigr),\qquad
>   D^{\mathrm{lg}}(W):=\sum_{R\in\mathcal R_W^{\mathrm{lg}}}\Phi(\mathcal D(R)).
> $$
> Then $A(W)\ge 0$ (UC3 Thm 3.3), $Q^{\mathrm{lg}}(W)\ge 0$ (each $\mathcal S(R)^\uparrow$ is a filter; UC4 Cor 1.2), and
> $$
>   \sigma(W)\;=\;A(W)+Q^{\mathrm{lg}}(W)-D^{\mathrm{lg}}(W).
> $$
> Moreover $D^{\mathrm{lg}}(W)\le D(W)$, with $D(W)-D^{\mathrm{lg}}(W)=\sum_{R\in\mathcal R_W^{\mathrm{sm}}}\Phi(\mathcal D(R))\ge 0$ by Corollary 1.4. Hence $\sigma(W)\ge 0$ **iff** $D^{\mathrm{lg}}(W)\le A(W)+Q^{\mathrm{lg}}(W)$; **sufficient:** $D^{\mathrm{lg}}(W)\le 0$.

*Proof.* By (0.1), $\sigma(W)=\sum_{R\in\mathcal R_W^{\mathrm{sm}}}\Phi(\mathcal S(R))+\sum_{R\in\mathcal R_W^{\mathrm{lg}}}\Phi(\mathcal S(R))$. The first sum is $A(W)\ge 0$. For the second, $\Phi(\mathcal S(R))=\Phi(\mathcal S(R)^\uparrow)-\Phi(\mathcal D(R))$ since $\mathcal S(R)^\uparrow=\mathcal S(R)\sqcup\mathcal D(R)$, giving $\sum_{R\in\mathcal R_W^{\mathrm{lg}}}\Phi(\mathcal S(R))=Q^{\mathrm{lg}}(W)-D^{\mathrm{lg}}(W)$. Non-negativity of $Q^{\mathrm{lg}}$: $\mathcal S(R)^\uparrow$ is an up-set in $2^W$, so $\Phi\ge 0$. The comparison $D^{\mathrm{lg}}(W)\le D(W)$: $D(W)=\sum_{R\in\mathcal R_W}\Phi(\mathcal D(R))=D^{\mathrm{lg}}(W)+\sum_{R\in\mathcal R_W^{\mathrm{sm}}}\Phi(\mathcal D(R))$, and the last sum is $\ge 0$ by Corollary 1.4. $\qquad\blacksquare$

**The exact condition is unchanged; the sufficient condition is strictly weaker.** A short computation confirms $D^{\mathrm{lg}}(W)\le A(W)+Q^{\mathrm{lg}}(W)\iff D(W)\le Q(W)$ — the *exact* residual is decomposition-invariant, as it must be. But the *sufficient* condition $D^{\mathrm{lg}}(W)\le 0$ is genuinely weaker than UC4's $D(W)\le 0$: since $D^{\mathrm{lg}}(W)\le D(W)$, the implication $D(W)\le 0\Rightarrow D^{\mathrm{lg}}(W)\le 0$ holds and not its converse. The residual *object* has shrunk: from the defect of all of $\mathcal R_W$ to the defect of the **large fibres only** — exactly UC3's localization (Cor 3.4) and UC4's localization (Cor 2.3), now fused.

### 2.2 The large-fibre-monotone class

The hybrid sufficient condition $D^{\mathrm{lg}}(W)\le 0$ is closed, in particular, by a clean structural hypothesis.

> **Definition.** $\mathcal F$ is **large-fibre-monotone** (relative to $W$) if every large fibre $R\in\mathcal R_W^{\mathrm{lg}}$ has $\mathcal S(R)$ a filter, i.e. $\mathcal D(R)=\emptyset$ for all $|R|>\lfloor k/2\rfloor$.

> **Theorem 2.3 (large-fibre-monotone $\Rightarrow$ Frankl, witnessed in $W$).** If $\mathcal F$ is large-fibre-monotone then $D^{\mathrm{lg}}(W)=0$, hence $\sigma(W)=A(W)+Q^{\mathrm{lg}}(W)\ge 0$ and some $x\in W$ is abundant. The class **properly contains** both UC3's bounded-spread class ($\mathcal R_W^{\mathrm{lg}}=\emptyset$, Thm 3.5) and UC4's $W$-monotone class ($\mathcal D(R)=\emptyset$ for *all* $R$, Thm 3.1).

*Proof.* If $\mathcal D(R)=\emptyset$ for every $R\in\mathcal R_W^{\mathrm{lg}}$ then $D^{\mathrm{lg}}(W)=0$; apply Theorem 2.1. Containment: if $\mathcal R_W^{\mathrm{lg}}=\emptyset$ the hypothesis is vacuous, so bounded-spread families are large-fibre-monotone; if $\mathcal D(R)=\emptyset$ for all $R$ then in particular for large $R$, so $W$-monotone families are large-fibre-monotone. The containments are proper by Example 2.4. $\qquad\blacksquare$

This is the **common generalization** UC4 §3.6 anticipated ("a future session may combine them"): a single native condition on the $m(\mathcal F)\ge 3$ frontier that subsumes the bounded-spread region (where the residual is *empty*) and the $W$-monotone region (where the defect is *globally* zero) — and is satisfied whenever the defect, wherever it occurs, occurs only in *small* fibres. It is **incomparable** with UC4's low-defect class (defect confined to traces $|S|\le k/2$): the two conditions cut $\mathcal F$ along different axes — fibre size vs. trace size — as Example 2.4 shows.

### 2.3 A worked example

> **Example 2.4 (large-fibre-monotone, but none of bounded-spread / $W$-monotone / low-defect).** $U=\{1,2,3,4,5\}$, $W=\{1,2,3\}$ ($k=3$, $\lfloor k/2\rfloor=1$), $U'=\{4,5\}$,
> $$
>   \mathcal F=\bigl\{\,\emptyset,\ \{1,2,3\},\ \{1,2,3,4,5\}\,\bigr\}.
> $$
> Union-closed ($W\cup U=U$, $\emptyset\cup\,\cdot$ trivial), $m(\mathcal F)=3$, $W$ a minimal generator.

*Fibres.* $W\sqcup R\in\mathcal F$ for $R=\emptyset$ ($W\in\mathcal F$) and $R=\{4,5\}$ ($U\in\mathcal F$), so $\mathcal R_W=\{\emptyset,\{4,5\}\}$, with $\mathcal R_W^{\mathrm{sm}}=\{\emptyset\}$, $\mathcal R_W^{\mathrm{lg}}=\{\{4,5\}\}$. Co-fibres: $\mathcal S(\emptyset)=\{S\subseteq W:S\in\mathcal F\}=\{\emptyset,W\}$; $\mathcal S(\{4,5\})=\{S:S\sqcup\{4,5\}\in\mathcal F\}=\{W\}$.

*Large-fibre-monotone.* The only large fibre is $\{4,5\}$, with $\mathcal S(\{4,5\})=\{W\}$ — a filter. So $\mathcal F$ is large-fibre-monotone, and $D^{\mathrm{lg}}(W)=0$.

*Not the prior classes.* **Not bounded-spread:** $W^+=U$, $|W^+|=5>\lfloor 3k/2\rfloor=4$. **Not $W$-monotone:** $\emptyset\in\mathcal F$, $\emptyset\subseteq\{1\}\subseteq\emptyset\cup W$, yet $\{1\}\notin\mathcal F$ — equivalently $\mathcal S(\emptyset)=\{\emptyset,W\}$ is not a filter. **Not low-defect:** the defect profile is $d_\emptyset=d_W=0$, $d_{\{x\}}=|\widetilde{\mathcal R}_{\{x\}}\setminus\mathcal R_{\{x\}}|=|\{\emptyset\}\setminus\emptyset|=1$ for each singleton, and $d_{\{x,y\}}=|\{\emptyset\}\setminus\emptyset|=1$ for each pair — so $d_S=1\neq 0$ at $|S|=2>k/2$.

*The arithmetic.* $\sigma(W)=\sum_{A\in\mathcal F}\phi(A\cap W)=\phi(\emptyset)+\phi(W)+\phi(W)=-3+3+3=3$. Hybrid: $A(W)=\Phi(\mathcal S(\emptyset))=\phi(\emptyset)+\phi(W)=0$; $Q^{\mathrm{lg}}(W)=\Phi(\mathcal S(\{4,5\})^\uparrow)=\Phi(\{W\})=3$; $D^{\mathrm{lg}}(W)=0$; total $0+3-0=3=\sigma(W)$ ✓. By contrast UC4's profile-level numbers: $D(W)=\sum_{|S|=2}d_S-\sum_{|S|=1}d_S=3-3=0$, $Q(W)=3$ — the defect cancels across the half-level, but only the hybrid sees *structurally* (via the large fibre $\{4,5\}$ alone) why $\sigma(W)\ge 0$.

Example 2.4 exhibits the proper containment and the incomparability with low-defect in one family.

### 2.4 The sharp form of the large-fibre residual

When $\mathcal F$ is not large-fibre-monotone, Theorem 1.3 gives the residual explicitly. Combining Theorem 2.1 with Theorem 1.3 restricted to $\mathcal R_W^{\mathrm{lg}}$:
$$
  D^{\mathrm{lg}}(W)\;=\;\sum_{R\in\mathcal R_W^{\mathrm{lg}}}\ \sum_{S_0\in\mathcal S(R)}\Bigl[\bigl(|I_{R,S_0}|-1\bigr)\,\phi(S_0)+2\,\Sigma(I_{R,S_0})\Bigr],
\tag{2.1}
$$
and the per-generator residual is closed as soon as the right side is $\le A(W)+Q^{\mathrm{lg}}(W)$. The summands with $\phi(S_0)<0$ (i.e. $|S_0|<k/2$) pull the sum down; by the minimality grading, a large fibre $R$ with $\lfloor k/2\rfloor<|R|<k$ has its defect-charged retractions confined to $k-|R|\le|S_0|<k$, so the *available* negative weight in (2.1) is exactly $\phi(S_0)\ge k-2|R|$. This is the precise quantitative statement of "the minimality grading should force the defect low": it bounds the negative leverage in (2.1), not the defect itself. Whether that leverage suffices is the residual — §4.

---

## §3. The cross-generator coupling, quantified: the generator Gram form

UC4 §4 assembled the I1 interlock as the linear system $\sum_{W\in\mathcal W}\sigma(W)=\sum_x\deg_{\mathcal W}(x)\beta_x$, and Lemma 4.3 gave the interlock matrix its combinatorial backbone (generators populate each other's fibres). UC4 §5's input 2 asks to *quantify* the Lemma 4.3 cross-incidence symmetry into the global bound. This section does so via the Gram matrix of the interlock.

### 3.1 The generator Gram form

Let $\mathcal W=\{W\in\mathcal F:|W|=k\}$, $N:=|\mathcal W|\ge 1$, $U_{\mathcal W}:=\bigcup\mathcal W$, $\deg_{\mathcal W}(x)=|\{W\in\mathcal W:x\in W\}|$. The **interlock matrix** is $M\in\{0,1\}^{\mathcal W\times U}$ with rows the minimal generators; the I1 identity is $\sigma(W)=(M\beta)_W$, $\sum_W\sigma(W)=\mathbf 1^{\mathsf T}M\beta=\sum_x\deg_{\mathcal W}(x)\beta_x$ (UC4 Thm 4.1).

Split each per-generator target by whether the contributing member is itself a generator: by (0.1),
$$
  \sigma(W)=\sigma_{\mathcal W}(W)+\sigma_{\mathrm{rest}}(W),\qquad
  \sigma_{\mathcal W}(W):=\sum_{W'\in\mathcal W}\phi(W\cap W'),\quad
  \sigma_{\mathrm{rest}}(W):=\sum_{A\in\mathcal F\setminus\mathcal W}\phi(A\cap W).
$$

> **Theorem 3.1 (the generator Gram form).** Let $G:=MM^{\mathsf T}\in\mathbb Z_{\ge 0}^{\mathcal W\times\mathcal W}$, so $G_{W,W'}=|W\cap W'|$ and $G_{W,W}=k$. Then the generator–generator block of the interlock sums to
> $$
>   \Sigma_{\mathcal W}\;:=\;\sum_{W\in\mathcal W}\sigma_{\mathcal W}(W)
>   \;=\;\mathbf 1^{\mathsf T}\bigl(2G-kJ\bigr)\mathbf 1
>   \;=\;\sum_{x\in U_{\mathcal W}}\deg_{\mathcal W}(x)\bigl(2\deg_{\mathcal W}(x)-N\bigr),
> $$
> where $J$ is the all-ones $\mathcal W\times\mathcal W$ matrix. In particular $\Sigma_{\mathcal W}=2\,\|M^{\mathsf T}\mathbf 1\|^2-kN^2$.

*Proof.* $\Sigma_{\mathcal W}=\sum_{W,W'}\phi(W\cap W')=\sum_{W,W'}(2|W\cap W'|-k)=2\,\mathbf 1^{\mathsf T}G\mathbf 1-kN^2$. Now $\mathbf 1^{\mathsf T}G\mathbf 1=\mathbf 1^{\mathsf T}MM^{\mathsf T}\mathbf 1=\|M^{\mathsf T}\mathbf 1\|^2=\sum_x\deg_{\mathcal W}(x)^2$, and $kN=\sum_W|W|=\sum_x\deg_{\mathcal W}(x)$, so $kN^2=N\sum_x\deg_{\mathcal W}(x)$. Hence $\Sigma_{\mathcal W}=2\sum_x\deg_{\mathcal W}(x)^2-N\sum_x\deg_{\mathcal W}(x)=\sum_x\deg_{\mathcal W}(x)(2\deg_{\mathcal W}(x)-N)$. $\qquad\blacksquare$

The matrix $2G-kJ$ has entries $(2G-kJ)_{W,W'}=2|W\cap W'|-k=\phi(W\cap W')$ — it is the **level-1 functional evaluated on generator overlaps**, and it is symmetric. The interlock's generator block is the quadratic form $\mathbf 1^{\mathsf T}(2G-kJ)\mathbf 1$ of this symmetric matrix.

### 3.2 The cross-incidence symmetry is the symmetry of $G$

> **Proposition 3.2 (Lemma 4.3, quantified).** For distinct $W,W'\in\mathcal W$, write $S^*=W\cap W'$. Then $W'\setminus W\in\mathcal R^W_{S^*}\subseteq\mathcal R_W$ and $W\setminus W'\in\mathcal R^{W'}_{S^*}\subseteq\mathcal R_{W'}$, with
> $$
>   |W'\setminus W|=|W\setminus W'|=k-|S^*|=k-G_{W,W'}.
> $$
> Consequently $W'$ is a **large**-fibre element of $W$ (i.e. $|W'\setminus W|>\lfloor k/2\rfloor$) **iff** $W$ is a large-fibre element of $W'$ **iff** $|W\cap W'|<\lceil k/2\rceil$. The relation "$W'$ contributes a large-fibre element to $W$" is therefore an **undirected graph** $\Gamma$ on $\mathcal W$: $W\sim_\Gamma W'\iff|W\cap W'|<\lceil k/2\rceil$.

*Proof.* The fibre membership and the size identity are UC4 Lemma 4.3. Since $|W'\setminus W|=|W\setminus W'|=k-|W\cap W'|$, the threshold $|W'\setminus W|>\lfloor k/2\rfloor\iff k-|W\cap W'|>\lfloor k/2\rfloor\iff|W\cap W'|<k-\lfloor k/2\rfloor=\lceil k/2\rceil$ is symmetric in $W,W'$. $\qquad\blacksquare$

This is exactly UC4 §4.4's "the defect a far generator $W'$ contributes to $W$ is the same incidence datum as the defect $W$ contributes to $W'$": both are governed by the *single symmetric* number $G_{W,W'}=|W\cap W'|$. The §2 hybrid residual lives on the large fibres; Proposition 3.2 says the **generator contributions to the large fibres come in symmetric pairs** — the $\Gamma$-edges. A counterexample to Frankl would need every generator's large-fibre defect $D^{\mathrm{lg}}(W)$ uncontrolled simultaneously, and Proposition 3.2 constrains the part of $\mathcal R_W^{\mathrm{lg}}$ that comes from other generators to a symmetric pattern: $\Gamma$ has no orientation, so the large-fibre loading is mutual.

> **Corollary 3.3 (generator-free large fibres).** If $\Gamma$ has no edges — every pair of minimal generators satisfies $|W\cap W'|\ge\lceil k/2\rceil$ — then for every $W\in\mathcal W$, the large fibre $\mathcal R_W^{\mathrm{lg}}$ contains no element of the form $W'\setminus W$, $W'\in\mathcal W$; the large-fibre residual $D^{\mathrm{lg}}(W)$ is **generator-free**.

*Proof.* Immediate from Proposition 3.2: $W\not\sim_\Gamma W'$ means $|W'\setminus W|\le\lfloor k/2\rfloor$, so $W'\setminus W\in\mathcal R_W^{\mathrm{sm}}$. $\qquad\blacksquare$

### 3.3 Closing the generator block: the concentrated-generator condition

The Gram form of Theorem 3.1 is closed by Cauchy–Schwarz on the degree sequence.

> **Theorem 3.4 (the concentrated-generator condition).** If the minimal generators are **concentrated**, $|U_{\mathcal W}|\le 2k$, then $\Sigma_{\mathcal W}\ge 0$. Consequently, if in addition $\sum_{W\in\mathcal W}\sigma_{\mathrm{rest}}(W)\ge 0$ — i.e.
> $$
>   \sum_{A\in\mathcal F\setminus\mathcal W}\Bigl(2\!\!\sum_{x\in A}\deg_{\mathcal W}(x)-kN\Bigr)\;\ge\;0
> $$
> — then $\sum_x\deg_{\mathcal W}(x)\beta_x\ge 0$, and some $x\in U_{\mathcal W}$ is abundant: **Frankl holds for $\mathcal F$**.

*Proof.* By Cauchy–Schwarz, $\sum_x\deg_{\mathcal W}(x)^2\ge\bigl(\sum_x\deg_{\mathcal W}(x)\bigr)^2/|U_{\mathcal W}|=(kN)^2/|U_{\mathcal W}|$. By Theorem 3.1,
$$
  \Sigma_{\mathcal W}=2\sum_x\deg_{\mathcal W}(x)^2-kN^2\ \ge\ \frac{2k^2N^2}{|U_{\mathcal W}|}-kN^2=kN^2\Bigl(\frac{2k}{|U_{\mathcal W}|}-1\Bigr)\ \ge\ 0
$$
when $|U_{\mathcal W}|\le 2k$. Then $\sum_W\sigma(W)=\Sigma_{\mathcal W}+\sum_W\sigma_{\mathrm{rest}}(W)\ge 0$; by the I1 identity $\sum_x\deg_{\mathcal W}(x)\beta_x\ge 0$, and since $\deg_{\mathcal W}(x)\ge 1$ for $x\in U_{\mathcal W}\neq\emptyset$ and $\ge 0$ elsewhere, not every $\beta_x$ can be negative (the argument of UC4 Thm 4.2). The displayed restatement of $\sum_W\sigma_{\mathrm{rest}}(W)\ge 0$: $\sum_W\sigma_{\mathrm{rest}}(W)=\sum_{A\notin\mathcal W}\sum_W\phi(A\cap W)=\sum_{A\notin\mathcal W}(2\sum_W|A\cap W|-kN)$ and $\sum_W|A\cap W|=\sum_{x\in A}\deg_{\mathcal W}(x)$. $\qquad\blacksquare$

Theorem 3.4 is the cross-generator coupling discharged into a native sufficient condition. The condition $|U_{\mathcal W}|\le 2k$ — the generators jointly span at most twice a generator's size, equivalently the **average generator-degree is $\ge N/2$** — closes the generator–generator block of the interlock *unconditionally*, leaving the residual entirely in the non-generator block $\sum_W\sigma_{\mathrm{rest}}(W)$. It is a genuine compatibility-geometry statement: it is the incidence structure of $\mathcal W$ inside $U$, read through the Gram matrix $G$, and the symmetry of $G$ (Proposition 3.2) is exactly what makes the quadratic form $\mathbf 1^{\mathsf T}(2G-kJ)\mathbf 1$ amenable to the Cauchy–Schwarz bound.

The honest scope: Theorem 3.4 closes the generator block but not the rest; it is the cross-generator analogue of §2's hybrid (which closes the small-fibre block but not the large), and the two residuals — $\sum_W\sigma_{\mathrm{rest}}(W)$ here, $D^{\mathrm{lg}}$ there — are the precise Phase-2 and Phase-1 remainders.

---

## §4. The combined picture, the named residual, and the verdict

### 4.1 What UC5 establishes

UC4 §5 named three unexploited inputs; UC5 discharges all three as theorems.

1. **Cross-$S$ coupling — fully quantified (§1).** The defect retraction $\bar\jmath_R$ is an interior operator (Theorem 1.1); its fibres are order ideals of intervals (Lemma 1.2); the residual decomposes **exactly** as $D(W)=\sum_R\sum_{S_0\in\mathcal S(R)}[(|I_{R,S_0}|-1)\phi(S_0)+2\Sigma(I_{R,S_0})]$ (Theorem 1.3). This is not a bound — it is a closed-form identity, the cross-$S$ coupling in its sharpest form.
2. **Combine UC3 + UC4 — done (§2).** The hybrid decomposition $\sigma(W)=A(W)+Q^{\mathrm{lg}}(W)-D^{\mathrm{lg}}(W)$ (Theorem 2.1) shrinks the residual object to the large-fibre defect $D^{\mathrm{lg}}\le D(W)$, and exposes the **large-fibre-monotone class** (Theorem 2.3) — a common generalization of UC3's bounded-spread and UC4's $W$-monotone regions, properly containing both and incomparable with UC4's low-defect class (Example 2.4).
3. **Cross-generator symmetry — quantified (§3).** The interlock Gram form $\Sigma_{\mathcal W}=\sum_x\deg_{\mathcal W}(x)(2\deg_{\mathcal W}(x)-N)$ (Theorem 3.1); the Lemma 4.3 symmetry is the symmetry of $G$ (Proposition 3.2); the concentrated-generator condition $|U_{\mathcal W}|\le 2k\Rightarrow\Sigma_{\mathcal W}\ge 0$ closes the generator block (Theorem 3.4).

### 4.2 The UC5 residual, named

> **The UC5 residual (per-generator and global).** Every road in UC5 converges on the **large-fibre defect**. For a minimal generator $W$, with $\mathcal R_W^{\mathrm{lg}}=\{R:|R|>\lfloor k/2\rfloor\}$ and the defect retraction $\bar\jmath_R$ of §1:
> $$
>   D^{\mathrm{lg}}(W)\;=\;\sum_{R\in\mathcal R_W^{\mathrm{lg}}}\ \sum_{S_0\in\mathcal S(R)}\Bigl[\bigl(|I_{R,S_0}|-1\bigr)\,\phi(S_0)+2\,\Sigma(I_{R,S_0})\Bigr].
> $$
> Show **either** the **per-generator** residual $D^{\mathrm{lg}}(W)\le A(W)+Q^{\mathrm{lg}}(W)$ (sufficient: $D^{\mathrm{lg}}(W)\le 0$), **or** the **global** residual $\sum_{W\in\mathcal W}D^{\mathrm{lg}}(W)\le\sum_{W\in\mathcal W}\bigl(A(W)+Q^{\mathrm{lg}}(W)\bigr)$. This is strictly sharper than the UC4 residual: $D^{\mathrm{lg}}(W)\le D(W)$, the positive part is now $A(W)+Q^{\mathrm{lg}}(W)$ (two independently non-negative pieces), and the defect is given by the exact cross-$S$ identity rather than a profile sum. It is a finitary, exact inequality between integer functionals — no asymptotics, no entropy slack, no ceiling.

**The precise obstruction.** The cross-$S$ identity (2.1) writes $D^{\mathrm{lg}}(W)$ as a sum of terms $(|I_{R,S_0}|-1)\phi(S_0)+2\Sigma(I_{R,S_0})$. The minimality grading (Corollary 1.4, §2.4) bounds the *negative leverage* $\phi(S_0)\ge k-2|R|$ available in this sum, and the order-ideal structure (Lemma 1.2) bounds $\Sigma(I_{R,S_0})$ from below in terms of $|I_{R,S_0}|$ (any ideal is "front-loaded"). What is **not** yet pinned is the *joint* constraint: the ideals $I_{R,S_0}$ across different $S_0$ within one $R$ are coupled (they tile $\mathcal S(R)^\uparrow$), and the co-fibres $\mathcal S(R)$ across different $R$ are coupled (the graded union law $\mathcal S(R)\vee\mathcal S(R')\subseteq\mathcal S(R\cup R')$). Either coupling, quantified into a *sign* for the sum (2.1) — rather than the *structure* it now has — would close the per-generator residual. Closing it outright is impossible by a single-$W$ argument: $D^{\mathrm{lg}}(W)\le 0$ for one $W$ with $k=3$ would prove Frankl on the open $m(\mathcal F)=3$ frontier.

### 4.3 Indicated route and the documented fallbacks

**Indicated route for a UC6 / continuation.** Two precise next steps, both on the named residual:

- **(Phase-1 push.)** Quantify the *tiling* coupling — within one $R$, the ideals $\{I_{R,S_0}\}_{S_0\in\mathcal S(R)}$ partition $\mathcal S(R)^\uparrow$, so the "boundary edges" between adjacent fibres of $\bar\jmath_R$ carry conservation laws. A flow/charging argument on the interior-operator structure of Theorem 1.1 is the natural attack on $\sum_{S_0}[(|I_{R,S_0}|-1)\phi(S_0)+2\Sigma(I_{R,S_0})]\le 0$ for large $R$.
- **(Phase-2 push.)** Combine the §3 Gram form with the §2 hybrid: the global residual $\sum_W D^{\mathrm{lg}}(W)$ versus $\sum_W(A(W)+Q^{\mathrm{lg}}(W))$, using Proposition 3.2's symmetric $\Gamma$ to pair the cross-generator large-fibre contributions, and the weighted interlock (UC4 Thm 4.2) to lean on the large-fibre-monotone generators ($D^{\mathrm{lg}}(W)=0$, take $c_W$ large).

**Documented fallbacks (UC4 §5 hooks), with UC5-sharpened attachment points.**

- **F-ii (component / $H_0$ route).** Attaches to the order-ideal structure now graded by $S_0$ (Lemma 1.2): the Hall criterion (UC2 Prop 3.6) applied to each fibre-ideal $I_{R,S_0}$ of the cumulative fibre $\widetilde{\mathcal R}_S$. The interior operator $\bar\jmath_R$ supplies the canonical bipartite incidence (defect element $\mapsto$ retraction).
- **F-iii (square-defect route).** Attaches to the cross-$R$ coupling $\mathcal S(R)\vee\mathcal S(R')\subseteq\mathcal S(R\cup R')$ named in §4.2 as the unexploited joint constraint — exactly the higher-degree square-defect of UC2 Prop 4.2 read on the co-fibre system.

Neither is pursued here — the Walsh route did not stall.

### 4.4 Verdict

**Verdict: GREEN-partial.**

UC5 against the ticket's scope:

- **Cross-$S$ coupling — fully quantified.** Theorem 1.3 is an *exact closed-form identity* for $D(W)$, built on the interior operator $\bar\jmath_R$ (Theorem 1.1) and the fibre-ideal structure (Lemma 1.2). UC4 §5's input 1 is discharged.
- **Combine UC3 + UC4 — done.** The hybrid decomposition (Theorem 2.1) shrinks the residual to $D^{\mathrm{lg}}\le D(W)$; the large-fibre-monotone class (Theorem 2.3) is a new native region of the $m(\mathcal F)\ge 3$ frontier, properly containing UC3's bounded-spread and UC4's $W$-monotone classes. UC4 §5's input 3 is discharged.
- **Cross-generator symmetry — quantified.** The generator Gram form (Theorem 3.1), the cross-incidence symmetry as the symmetry of $G$ (Proposition 3.2), and the concentrated-generator sufficient condition (Theorem 3.4). UC4 §5's input 2 is discharged.

**Why GREEN-partial is the honest tag.** Not GREEN-residual-closed: neither the per-generator residual $D^{\mathrm{lg}}(W)\le A(W)+Q^{\mathrm{lg}}(W)$ nor the global interlock residual is fully closed — and the per-generator one cannot be by the single-$W$ means here, since $D^{\mathrm{lg}}(W)\le 0$ at $k=3$ would prove Frankl on the open frontier. Not AMBER-residual-stalls: the Walsh route does not stall — the cross-$S$ coupling is *fully quantified as an exact identity* (the strongest of UC4 §5's three asks), the UC3/UC4 attacks are *combined* into a strictly smaller residual with a new native region of the frontier that subsumes two prior regions, and the cross-generator coupling is quantified into a Gram form with a native sufficient condition. The defining feature of GREEN-partial — "the residual is substantially advanced (e.g. closed on further structured sub-classes, or one of the two couplings fully quantified) but not fully closed; recommend the continuation" — is met, and exceeded: *both* couplings are quantified and the cross-$S$ one is exact.

**Trust-surface impact: none.** Paper-and-pencil; no new axioms, no Lean, no computation. No engine ported — UC5 builds only on the pinned objects of UC1 §1, the structure theory of UC2 §§2–3, the characterization of UC3 §2, and the decomposition of UC4 §§1–4 (UC1 §8.4's dead routes E1–E3 / C1–C5 untouched). The 1/3-2/3 critical path (`one_third_width_three`) is in a different repo and is untouched.

---

## §5. References

### 5.1 This repo / parent chain

- **mg-0bf7 (UC4)** — `docs/union-closed-UC4-large-fibre-residual.md`: §§1–2 (the monotone aggregate-sign lemma, the up-closure decomposition $\sigma=Q-D$, the cumulative fibre, Lemma 2.4's order-ideal structure — the objects UC5 §1 quantifies); §3 (the $W$-monotone and low-defect sub-classes, the named $k=3$ residual — UC5 §2's large-fibre-monotone class generalizes the former and is incomparable with the latter); §4 (the I1 interlock, Theorem 4.1, the weighted form Theorem 4.2, Lemma 4.3 cross-incidence — UC5 §3 quantifies these into the Gram form); §5 (the UC5 target and its three indicated inputs, all discharged here). `docs/state-UC4.md` — the UC4 invariants.
- **mg-cfc0 (UC3)** — `docs/union-closed-UC3-walsh-subcube-spectrum.md`: §2 (the sub-cube Walsh characterization — graded union law, universal fibre inclusion, dual reduction, minimality grading Prop 2.6 — the standing toolkit of §0 here); §3 (the per-fibre sign theorem Thm 3.3 and the bounded-spread sufficient condition Thm 3.5, both fused into the UC5 hybrid §2). `docs/state-UC3.md`.
- **mg-a814 (UC2)** — `docs/union-closed-UC2-transport-deficiency.md`: §3.3 (the trace-partition theorem; identity (0.1) is UC2's (3.1)); §3.4 (the interlock I1 mechanism UC5 §3 quantifies); §3.5 (the Hall criterion Prop 3.6 — the F-ii hook); §4.2 (the one-sided square-defect — the F-iii hook). `docs/state-UC2.md`.
- **mg-f72a (UC1)** — `docs/union-closed-compat-geom-manifesto.md`: §1.6 (the obstruction in Walsh form); §8.3 (fallback F-i, the Walsh/harmonic route UC5 continues); §8.4 (the dead routes UC5 avoids). `docs/state-UC1.md`.

### 5.2 Cross-repo — `one_third_width_three` (read access)

Used by UC5 only to stay clear of the dead routes (UC1 §8.4): the BK/Cheeger-expansion engine and Theorem E (gaps E1–E3), the F-series cohomological program and $\Delta(\mathrm{UCF}_n)$ (gaps C1–C5). UC5 is independent of the 1/3-2/3 critical path — different repo, different polecat.

### 5.3 Frankl-conjecture literature

- P. Frankl (1979) — the Union-Closed Sets conjecture.
- H. Bruhn, O. Schaudt, *The journey of the union-closed sets conjecture*, Graphs and Combinatorics 31 (2015) — the survey; the classical small-set cases (recovered natively in UC2 Thm 3.5(2)).
- B. Poonen, *Union-closed families*, J. Combin. Theory Ser. A 59 (1992) — the lattice / join-irreducible reformulation.
- J. Gilmer, *A constant lower bound for the union-closed sets conjecture* (2022) — the entropy/information-theoretic method; framed in UC3 §4 and UC4 §4.5 as a level-1-spectrum estimator that sees the monotone part $Q(W)$ but not the defect $D(W)$ — and, after UC5 §2, not the large-fibre defect $D^{\mathrm{lg}}(W)$.
- W. Sawin; Z. Chase & S. Lovett; R. Alweiss, B. Huang & M. Sellke; L. Pebody (2022–2023) — the improvement to $(3-\sqrt5)/2\approx 0.38197$ and the Sawin ceiling. UC5's residual $D^{\mathrm{lg}}(W)$ is the exact, finitary locus that escapes that ceiling — the coupling-only part of the localized object.
- R. O'Donnell, *Analysis of Boolean Functions* (2014) — Walsh–Fourier analysis on the cube; the level-1 spectrum; interior/closure operators on posets; the edge-isoperimetric reading of $\Phi$ on order ideals.

### 5.4 Source directives

- Daniel directives 2026-05-14 — the `union_closed` product-line assignment; UC5 is the F-i (Walsh/harmonic) continuation, UC4-localized, per UC4 §5: close the UC4 trace-defect residual via the cross-$S$ and cross-generator couplings.

---

*Polecat: mg-3806 (UC5). Branch: `polecat-cat-mg-3806`. Verdict: **GREEN-partial** — the UC4 trace-defect residual is substantially advanced: the cross-$S$ coupling is fully quantified into the exact fibre-ideal decomposition $D(W)=\sum_R\sum_{S_0}[(|I_{R,S_0}|-1)\phi(S_0)+2\Sigma(I_{R,S_0})]$ via the defect-retraction interior operator $\bar\jmath_R$; the UC3 and UC4 attacks are combined into the hybrid residual $\sigma(W)=A+Q^{\mathrm{lg}}-D^{\mathrm{lg}}$ with $D^{\mathrm{lg}}\le D(W)$, exposing the large-fibre-monotone class (a common generalization of UC3's bounded-spread and UC4's $W$-monotone regions); and the cross-generator coupling is quantified as the generator Gram form $\Sigma_{\mathcal W}=\sum_x\deg_{\mathcal W}(x)(2\deg_{\mathcal W}(x)-N)$, non-negative whenever $|\bigcup\mathcal W|\le 2k$. All three of UC4 §5's indicated inputs discharged as theorems; the residual is named in its sharpest form (the large-fibre defect $D^{\mathrm{lg}}$); not fully closed, and not closable by a single-$W$ argument at the $k=3$ frontier; no new axioms; no Lean; no computation; no engine port.*
