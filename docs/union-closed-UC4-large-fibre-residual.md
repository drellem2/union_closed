# Union-Closed Compatibility-Geometry — UC4: the large-fibre residual + the I1 interlock (mg-0bf7)

**Repo:** `union_closed`. **Parent:** mg-cfc0 (UC3, GREEN-walsh-characterization) — `docs/union-closed-UC3-walsh-subcube-spectrum.md` §5 (the UC4 target + the indicated route), §3.6 (the residual + its three unexploited structural inputs). **Chain:** mg-f72a (UC1) → mg-a814 (UC2) → mg-cfc0 (UC3) → UC4.
**Branch:** `polecat-cat-mg-0bf7`.
**Type:** Native construction — Walsh/harmonic analysis on the cube (continuing fallback **F-i**, UC3-localized). Paper-and-pencil; **no new axioms; no Lean; no computation; no engine port.** LaTeX-style Markdown, F-series house style. Multi-session-able; cumulative state ledger in `docs/state-UC4.md`.
**Cross-repo references (read access):** `one_third_width_three` — used only to stay clear of the dead routes UC1 §8.4 named.

---

**Verdict: GREEN-partial.**

The UC4 large-fibre residual is **substantially advanced and closed on structured sub-cases**, and the **I1 interlock is assembled** as an explicit linear system. The core is a single decomposition of the per-generator target into a provably non-negative part and a defect, both native, both finitary:

$$
  \sigma(W)\;:=\;\sum_{x\in W}\beta_x\;=\;Q(W)\;-\;D(W),
  \qquad Q(W)\ge 0\ \text{always},
$$

where $Q(W)$ is the aggregate level-1 weight of the **cumulative fibre profile** — a *monotone* object — and $D(W)$ is the aggregate level-1 weight of the **trace-defect profile**. This isolates the entire residual difficulty into the single scalar $D(W)$, and the residual closes exactly when $D(W)\le Q(W)$ (sufficient: $D(W)\le 0$).

The load-bearing results:

- **(§1) The engine — the monotone aggregate-sign lemma.** For any monotone non-decreasing $g:2^W\to\mathbb R$, $\sum_{S\subseteq W}g(S)(2|S|-k)\ge 0$ (Lemma 1.1) — a one-line telescoping identity. Filters have non-negative level-1 weight, ideals non-positive (Corollary 1.2); the principal filter $[S_0,W]$ has level-1 weight exactly $2^{k-|S_0|}|S_0|$ (Example 1.3). This is the harmonic fact UC3's residual was missing.
- **(§2) Phase 1 core — the up-closure decomposition.** The **cumulative fibre** $\widetilde{\mathcal R}_S:=\bigcup_{S_0\subseteq S}\mathcal R_{S_0}$ is union-closed, satisfies $\widetilde{\mathcal R}_S\subseteq\mathcal R_W$, and is **monotone in $S$** (Lemma 2.1) — so its size profile $q_S:=|\widetilde{\mathcal R}_S|$ is monotone, and $Q(W):=\sum_S q_S(2|S|-k)=\sum_{R}\Phi(\mathcal S(R)^\uparrow)\ge 0$ (Theorem 2.2). The target splits as $\sigma(W)=Q(W)-D(W)$ with $D(W)=\sum_S d_S(2|S|-k)$, $d_S=|\widetilde{\mathcal R}_S\setminus\mathcal R_S|\ge 0$, $d_\emptyset=d_W=0$ (Corollary 2.3). The graded union law forces $\mathcal R_S$ to be an **order filter** of $\widetilde{\mathcal R}_S$, hence the defect $\widetilde{\mathcal R}_S\setminus\mathcal R_S$ is an **order ideal** of $\widetilde{\mathcal R}_S$ (Lemma 2.4) — structural input 3 realized.
- **(§3) Closing the residual — structured sub-cases + the named residual.** Two native sufficient conditions, both on the $m(\mathcal F)\ge 3$ frontier and **complementary** to UC3's bounded-spread Theorem 3.5: **$W$-monotone families** ($d\equiv 0$, Theorem 3.1) and **low-defect families** ($d_S=0$ for $|S|>k/2$, Theorem 3.2). The $k=3$ frontier residual is named explicitly (Proposition 3.4): $D(W)\le 0\iff\sum_{|S|=2}d_S\le\sum_{|S|=1}d_S$. Two worked examples — one with $d\equiv 0$, one with $D(W)=2>0$ but $D(W)<Q(W)=7$ — exhibit precisely why $D(W)\le 0$ is sufficient but not necessary.
- **(§4) Phase 2 — the I1 interlock, assembled.** Ranging $W$ over all minimal generators $\mathcal W$, the per-generator identities couple through the shared biases: $\sum_{W\in\mathcal W}\sigma(W)=\sum_{x}\deg_{\mathcal W}(x)\,\beta_x$ (Theorem 4.1). Since each $Q(W)\ge 0$, the interlock **relaxes** the Phase-1 requirement from per-generator $D(W)\le 0$ to the single **global** inequality $\sum_{W\in\mathcal W}D(W)\le 0$ (Theorem 4.2): bad generators may be carried by good ones. The generators populate each other's fibres concretely — $W'\setminus W\in\mathcal R^W_{W'\cap W}$ for distinct $W,W'\in\mathcal W$ (Lemma 4.3) — giving the interlock matrix its structure.

**Why GREEN-partial and not GREEN-phase1.** Phase 1 is not closed in general: the residual $D(W)\le 0$ (equivalently $D(W)\le Q(W)$) is reduced to a single clean finitary scalar inequality and proven on two structured sub-classes, but the general case is open — and it must be, since $D(W)\le 0$ for a single minimal generator with $k=3$ would already prove Frankl on the open $m(\mathcal F)=3$ frontier. **Why not GREEN-residual-closed.** Neither the per-generator residual nor the global interlock residual is fully closed. **Why not AMBER.** The Walsh route does not stall: the residual is isolated into one scalar $D(W)$, the positive part $Q(W)\ge 0$ is closed *unconditionally and natively*, two new sufficient conditions are proven, the frontier residual is named explicitly, and the I1 interlock is assembled with a genuine relaxation (global vs. per-generator). This is substantial, precisely-bounded progress past the entropy-method ceiling — the GREEN-partial profile.

**The honest one-sentence verdict.** *The per-generator UC4 target $\sigma(W)=\sum_{x\in W}\beta_x$ decomposes natively and finitarily as $Q(W)-D(W)$, where $Q(W)$ — the aggregate level-1 weight of the monotone cumulative-fibre profile $q_S=|\widetilde{\mathcal R}_S|$ — is provably non-negative by a one-line telescoping lemma that uses the universal fibre inclusion and the graded union law in full, and $D(W)$ — the aggregate level-1 weight of the order-ideal-structured trace-defect profile — carries the entire residual; the residual closes when $D(W)\le Q(W)$, is proven $\le 0$ on the $W$-monotone and low-defect sub-classes (new native regions of the $m(\mathcal F)\ge 3$ frontier, complementary to UC3's bounded-spread theorem), is named explicitly at the $k=3$ frontier, and the I1 interlock — ranging $W$ over all minimal generators — relaxes the per-generator requirement to the single global inequality $\sum_{W}D(W)\le 0$, which is the precisely-stated Phase-2 residual.*

§0 fixes notation and recaps the UC3 hand-off; §1 is the engine (the monotone aggregate-sign lemma); §2 is the Phase-1 core (the up-closure decomposition $\sigma=Q-D$); §3 closes the residual on structured sub-cases and names the frontier residual; §4 assembles the I1 interlock (Phase 2); §5 is the verdict and the precise next step; §6 the references.

---

## §0. Notation and the UC4 target

Notation is UC1's, UC2's and UC3's, restated where load-bearing.

$U$ is a finite ground set, $|U|=n$; $\mathcal F\subseteq 2^U$ is **union-closed** ($A,B\in\mathcal F\Rightarrow A\cup B\in\mathcal F$), with $\mathcal F\neq\emptyset,\{\emptyset\}$ and WLOG $U=\bigcup\mathcal F\in\mathcal F$. For $x\in U$: $\beta_x=|\mathcal F_x|-|\mathcal F_{\bar x}|$, the **bias**; Frankl asserts some $x$ has $\beta_x\ge 0$. The **minimum set size** is $m(\mathcal F)=\min\{|A|:A\in\mathcal F,\,A\ne\emptyset\}$; UC2 settled $m(\mathcal F)\le 2$ natively, so throughout UC4 we **fix a minimal generator**

$$
  W\in\mathcal F,\qquad |W|=m(\mathcal F)=:k\ge 3,
$$

and write $U'=U\setminus W$, $n'=|U'|=n-k$. Every nonempty $A\in\mathcal F$ has $|A|\ge k$.

**The fibre system (UC3 §1–2).** Each $A\in\mathcal F$ splits $A=S\sqcup R$, $S=A\cap W\subseteq W$, $R=A\setminus W\subseteq U'$. For $S\subseteq W$ the **$S$-fibre** is $\mathcal R_S=\{R\subseteq U':S\sqcup R\in\mathcal F\}$; the **trace profile** is $p_S=|\mathcal F^S|=|\mathcal R_S|$. The UC3 characterization, restated as the standing toolkit:

- **(Graded union law, UC3 Prop 2.2.)** $\mathcal R_S\vee\mathcal R_{S'}\subseteq\mathcal R_{S\cup S'}$ for all $S,S'\subseteq W$, where $\mathcal R_S\vee\mathcal R_{S'}=\{R\cup R':R\in\mathcal R_S,R'\in\mathcal R_{S'}\}$. Diagonally, each $\mathcal R_S$ is union-closed.
- **(Universal fibre inclusion, UC3 Thm 2.3.)** $\mathcal R_S\subseteq\mathcal R_W$ for *every* $S\subseteq W$. The ambient fibre $\mathcal R_W$ is a union-closed family on $U'$ with $\emptyset\in\mathcal R_W$.
- **(Dual reduction, UC3 Thm 2.5.)** The **co-fibre** $\mathcal S(R)=\{S\subseteq W:S\sqcup R\in\mathcal F\}$ is, for each $R\in\mathcal R_W$, a union-closed family on $W$ containing the top $W$; $p=\sum_{R\in\mathcal R_W}\mathbf 1_{\mathcal S(R)}$; and the co-fibres are coupled by $\mathcal S(R)\vee\mathcal S(R')\subseteq\mathcal S(R\cup R')$.
- **(Minimality grading, UC3 Prop 2.6.)** For an intermediate trace $S$ ($0<|S|<k$): every $R\in\mathcal R_S$ has $|R|\ge k-|S|$. Dually $0<|R|<k\Rightarrow\emptyset\notin\mathcal S(R)$, and $\emptyset\in\mathcal S(R)\iff R\in\mathcal F\iff(R=\emptyset\text{ or }|R|\ge k)$.

**The level-1 functional.** For $\mathcal G\subseteq 2^W$ write $\Phi(\mathcal G)=\sum_{S\in\mathcal G}(2|S|-k)$; for any $g:2^W\to\mathbb R$ write $\langle g,\phi\rangle=\sum_{S\subseteq W}g(S)(2|S|-k)$ with $\phi(S)=2|S|-k$. The per-generator target (UC3 Prop 3.1):

$$
  \sigma(W)\;:=\;\sum_{x\in W}\beta_x\;=\;\langle p,\phi\rangle\;=\;\sum_{S\subseteq W}p_S(2|S|-k)\;=\;\sum_{R\in\mathcal R_W}\Phi(\mathcal S(R)).
\tag{0.1}
$$

> **The UC4 target (UC3 §5).** For the fixed minimal generator $W$, show $\sigma(W)\ge 0$, equivalently — via UC3's per-fibre sign theorem (Thm 3.3), which proves $\Phi(\mathcal S(R))\ge 0$ for every $R$ with $|R|\le\lfloor k/2\rfloor$ — show the **large-fibre residual**
> $$
>   \sum_{R\in\mathcal R_W^{\mathrm{lg}}}\Phi(\mathcal S(R))\;\ge\;-\sum_{R\in\mathcal R_W^{\mathrm{sm}}}\Phi(\mathcal S(R)),
>   \qquad \mathcal R_W^{\mathrm{lg}}=\{R:|R|>\lfloor k/2\rfloor\}.
> $$
> If $\sigma(W)\ge 0$ then $\max_{x\in W}\beta_x\ge 0$: some $x\in W$ is abundant. UC3 §3.6 named the **three structural inputs** the proof must use: (1) the graded union law coupling the co-fibres; (2) the minimality grading inside the large fibres; (3) the ideal/filter structure of $\mathcal R_W$.

**Phase 1** (this document, §§1–3): close the residual for a fixed $W$, using the three inputs. **Phase 2** (§4): range $W$ over all minimal generators and couple the per-generator inequalities into the I1 linear system.

**What UC4 must not do (UC1 §8.4, kept in view).** No port of Theorem E / the Steps 1–7 rigidity engine; no $\Delta(\mathrm{UCF}_n)$ chamber ambient; no $S_n$-isotypic / FI machinery; no new axioms; no Lean; no computation. UC4 is a native construction on the pinned objects of UC1 §1, the structure theory of UC2 §§2–3, and the characterization of UC3 §2.

---

## §1. The engine: the monotone aggregate-sign lemma

UC3 §3.6 named the residual but left it as an inequality between two sums of mixed-sign integer functionals. The missing ingredient is a single elementary harmonic fact about the cube $2^W$, which turns *monotonicity* directly into a *sign*. It is the engine of everything that follows.

> **Lemma 1.1 (monotone aggregate-sign lemma).** Let $g:2^W\to\mathbb R$. If $g$ is monotone non-decreasing (i.e. $S\subseteq S'\Rightarrow g(S)\le g(S')$) then
> $$
>   \langle g,\phi\rangle\;=\;\sum_{S\subseteq W}g(S)\,(2|S|-k)\;\ge\;0.
> $$
> If $g$ is monotone non-increasing, $\langle g,\phi\rangle\le 0$.

*Proof.* Write $2|S|-k=\sum_{x\in W}\varepsilon_x(S)$ with $\varepsilon_x(S)=+1$ if $x\in S$ and $-1$ otherwise. Then
$$
  \langle g,\phi\rangle=\sum_{x\in W}\sum_{S\subseteq W}g(S)\,\varepsilon_x(S)
  =\sum_{x\in W}\Bigl(\sum_{S\ni x}g(S)-\sum_{S\not\ni x}g(S)\Bigr).
$$
For each fixed $x$, the map $S\mapsto S\cup\{x\}$ is a bijection from $\{S:x\notin S\}$ to $\{S:x\in S\}$, so
$$
  \sum_{S\ni x}g(S)-\sum_{S\not\ni x}g(S)=\sum_{S\not\ni x}\bigl(g(S\cup\{x\})-g(S)\bigr).
$$
Each summand is $\ge 0$ when $g$ is non-decreasing (and $\le 0$ when non-increasing), since $S\subseteq S\cup\{x\}$. Summing over $x\in W$ gives the claim. $\qquad\blacksquare$

The lemma is the precise sense in which "the level-1 spectrum is governed by monotonicity": $\langle g,\phi\rangle$ is, up to sign, the sum over coordinates of the total *upward increment* of $g$ along that coordinate. A monotone $g$ has all increments of one sign, so the aggregate cannot cancel against itself.

> **Corollary 1.2 (filters and ideals).** For any filter (up-set) $\mathcal U\subseteq 2^W$, $\Phi(\mathcal U)\ge 0$; for any ideal (down-set) $\mathcal I\subseteq 2^W$, $\Phi(\mathcal I)\le 0$.

*Proof.* $\mathbf 1_{\mathcal U}$ is monotone non-decreasing, $\mathbf 1_{\mathcal I}$ monotone non-increasing; apply Lemma 1.1 with $g=\mathbf 1_{\mathcal U}$ resp. $g=\mathbf 1_{\mathcal I}$, using $\Phi(\mathcal G)=\langle\mathbf 1_{\mathcal G},\phi\rangle$. $\qquad\blacksquare$

Corollary 1.2 already resolves the *shape* obstruction of UC3's Observation 3.2: the bad co-fibre $\{\emptyset,\{x\},W\}$ has $\Phi=2-k<0$ precisely because it is **not** a filter — it has a "thin" low part. The whole of Phase 1 is the statement that union-closure forces the trace structure to be, in aggregate, monotone-dominated.

> **Example 1.3 (the principal filter).** For $S_0\subseteq W$ the interval $[S_0,W]=\{S:S_0\subseteq S\subseteq W\}$ is a filter, and
> $$
>   \Phi\bigl([S_0,W]\bigr)=\sum_{S_0\subseteq S\subseteq W}(2|S|-k)=2^{\,k-|S_0|}\,|S_0|\;\ge\;0,
> $$
> with equality iff $S_0=\emptyset$. *(Compute: with $d=k-|S_0|$, $\sum_{j=0}^d\binom dj(2(|S_0|+j)-k)=2^d(2|S_0|-k)+2\!\cdot\! d2^{d-1}=2^d(2|S_0|-k+d)=2^d|S_0|$.)*

So a co-fibre that happens to be an interval contributes a clean non-negative amount, scaling as $2^{k-|S_0|}|S_0|$ in its minimal generator $S_0$. The danger is entirely in the non-interval, non-filter co-fibres — and §2 shows how to absorb them.

**On the trust surface.** Lemma 1.1 is a two-line counting identity on the finite cube $2^W$; it introduces no axiom, no asymptotics, no entropy term. It is exactly the kind of *finitary, exact* tool UC3 §4.3 promised the residual would admit — there is no $(3-\sqrt 5)/2$-shaped slack anywhere in it.

---

## §2. Phase 1 core: the up-closure decomposition $\sigma(W)=Q(W)-D(W)$

This section reduces the entire per-generator residual to a single scalar $D(W)$, and proves the complementary scalar $Q(W)$ is unconditionally non-negative. It uses all three of UC3's named structural inputs: the universal fibre inclusion and the graded union law build the monotone object (inputs 1 and the $\mathcal R_W$-ambient structure); the graded union law again gives the order-ideal shape of the defect (input 3); the minimality grading is what makes the defect *low* (input 2, §3).

### 2.1 The cumulative fibre

> **Lemma 2.1 (the cumulative fibre).** For $S\subseteq W$ define the **cumulative fibre**
> $$
>   \widetilde{\mathcal R}_S\;:=\;\bigcup_{S_0\subseteq S}\mathcal R_{S_0}\;=\;\{R\subseteq U':S_0\sqcup R\in\mathcal F\text{ for some }S_0\subseteq S\}.
> $$
> Then: (i) $\widetilde{\mathcal R}_S$ is a union-closed family on $U'$; (ii) $\widetilde{\mathcal R}_S\subseteq\mathcal R_W$; (iii) $S\subseteq S'\Rightarrow\widetilde{\mathcal R}_S\subseteq\widetilde{\mathcal R}_{S'}$ — the cumulative fibre is **monotone in $S$**; (iv) $\widetilde{\mathcal R}_\emptyset=\mathcal R_\emptyset$ and $\widetilde{\mathcal R}_W=\mathcal R_W$.

*Proof.* (i) Let $R\in\mathcal R_{S_1}$, $R'\in\mathcal R_{S_2}$ with $S_1,S_2\subseteq S$. By the graded union law, $R\cup R'\in\mathcal R_{S_1\cup S_2}$, and $S_1\cup S_2\subseteq S$, so $R\cup R'\in\widetilde{\mathcal R}_S$. (ii) Each $\mathcal R_{S_0}\subseteq\mathcal R_W$ by the universal fibre inclusion, so the union lies in $\mathcal R_W$. (iii) $S\subseteq S'$ makes $\{S_0:S_0\subseteq S\}\subseteq\{S_0:S_0\subseteq S'\}$, so the defining union only grows. (iv) $\widetilde{\mathcal R}_\emptyset=\mathcal R_\emptyset$ is immediate; $\widetilde{\mathcal R}_W=\bigcup_{S_0\subseteq W}\mathcal R_{S_0}=\mathcal R_W$, since $\mathcal R_W$ is one of the terms and contains every other by the universal inclusion. $\qquad\blacksquare$

The cumulative fibre is the **up-closure of the co-fibre system, read on the $U'$ side**: $R\in\widetilde{\mathcal R}_S$ iff $\mathcal F$ has a member with $U'$-part $R$ and trace contained in $S$. Its size profile

$$
  q_S\;:=\;|\widetilde{\mathcal R}_S|
$$

is therefore monotone non-decreasing on $2^W$, with $q_\emptyset=|\mathcal R_\emptyset|=p_\emptyset$ and $q_W=|\mathcal R_W|=p_W$.

### 2.2 The decomposition

> **Theorem 2.2 (the monotone part $Q(W)$).** For every $S\subseteq W$,
> $$
>   q_S=\bigl|\{R\in\mathcal R_W:S\in\mathcal S(R)^\uparrow\}\bigr|,
> $$
> where $\mathcal S(R)^\uparrow=\{S:S\supseteq S_0\text{ for some }S_0\in\mathcal S(R)\}$ is the up-closure (in $2^W$) of the co-fibre. Consequently
> $$
>   Q(W)\;:=\;\langle q,\phi\rangle\;=\;\sum_{S\subseteq W}q_S(2|S|-k)\;=\;\sum_{R\in\mathcal R_W}\Phi\bigl(\mathcal S(R)^\uparrow\bigr)\;\ge\;0.
> $$

*Proof.* For $R\in\mathcal R_W$ and $S\subseteq W$: $S\in\mathcal S(R)^\uparrow$ iff there is $S_0\subseteq S$ with $S_0\in\mathcal S(R)$, i.e. $S_0\sqcup R\in\mathcal F$, i.e. $R\in\mathcal R_{S_0}$ — which says exactly $R\in\widetilde{\mathcal R}_S$. Since $\widetilde{\mathcal R}_S\subseteq\mathcal R_W$ (Lemma 2.1(ii)), $q_S=|\widetilde{\mathcal R}_S|=|\{R\in\mathcal R_W:S\in\mathcal S(R)^\uparrow\}|=\sum_{R\in\mathcal R_W}\mathbf 1[S\in\mathcal S(R)^\uparrow]$. Summing against $\phi$ and exchanging the order of summation gives $\langle q,\phi\rangle=\sum_R\langle\mathbf 1_{\mathcal S(R)^\uparrow},\phi\rangle=\sum_R\Phi(\mathcal S(R)^\uparrow)$. Non-negativity is Lemma 1.1 applied to the monotone $q$ (Lemma 2.1(iii)). $\qquad\blacksquare$

Theorem 2.2 closes the *positive* half of the residual **unconditionally**: the up-closures $\mathcal S(R)^\uparrow$ are filters, and by Corollary 1.2 each contributes $\ge 0$ — but more is true and more is needed: the sum $\sum_R\Phi(\mathcal S(R)^\uparrow)$ is itself $\langle q,\phi\rangle$ for a *single monotone profile* $q$, which is the form §4 will couple across generators. Note the proof consumes both UC3 inputs structurally: the graded union law (for $\widetilde{\mathcal R}_S$ union-closed) and the universal inclusion (for $\widetilde{\mathcal R}_S\subseteq\mathcal R_W$, hence $q_W=p_W$).

> **Corollary 2.3 (the up-closure decomposition).** Define the **trace-defect profile** $d_S:=q_S-p_S$. Then $d_S=|\widetilde{\mathcal R}_S\setminus\mathcal R_S|\ge 0$, $d_\emptyset=d_W=0$, and
> $$
>   \sigma(W)\;=\;Q(W)\;-\;D(W),\qquad D(W):=\langle d,\phi\rangle=\sum_{S\subseteq W}d_S(2|S|-k).
> $$
> In particular $\sigma(W)\ge 0$ **if** $D(W)\le 0$, and $\sigma(W)\ge 0$ **iff** $D(W)\le Q(W)$.

*Proof.* By UC3 Thm 2.5, $p_S=|\{R\in\mathcal R_W:S\in\mathcal S(R)\}|$; with Theorem 2.2 and $\mathcal S(R)\subseteq\mathcal S(R)^\uparrow$, $d_S=q_S-p_S=|\{R\in\mathcal R_W:S\in\mathcal S(R)^\uparrow\setminus\mathcal S(R)\}|\ge 0$. Equivalently $d_S=|\widetilde{\mathcal R}_S|-|\mathcal R_S|=|\widetilde{\mathcal R}_S\setminus\mathcal R_S|$, using $\mathcal R_S\subseteq\widetilde{\mathcal R}_S$. The boundary values: $\widetilde{\mathcal R}_\emptyset=\mathcal R_\emptyset$ and $\widetilde{\mathcal R}_W=\mathcal R_W$ (Lemma 2.1(iv)) give $d_\emptyset=d_W=0$. Finally $\sigma(W)=\langle p,\phi\rangle=\langle q-d,\phi\rangle=Q(W)-D(W)$ by (0.1) and linearity; the two consequences follow from $Q(W)\ge 0$. $\qquad\blacksquare$

This is the UC4 reduction. Equation (0.1) had $\sigma(W)$ as a sum of mixed-sign terms with no handle; Corollary 2.3 rewrites it as **(provably non-negative monotone part) minus (a single defect scalar)**. The residual difficulty of Frankl, localized by UC2 to the intermediate trace-classes and by UC3 to the large fibres, is localized by UC4 to the sign of $D(W)$.

Dually, in fibre language: $D(W)=\sum_{R\in\mathcal R_W}\Phi(\mathcal D(R))$ where $\mathcal D(R)=\mathcal S(R)^\uparrow\setminus\mathcal S(R)$ is the **non-monotonicity defect** of the co-fibre — the supersets of members of $\mathcal S(R)$ that are themselves not members. So $D(W)\le 0$ asks that the co-fibres' collective failure to be up-closed has non-positive aggregate level-1 weight. A co-fibre that *is* a filter (e.g. an interval, Example 1.3) contributes $\mathcal D(R)=\emptyset$.

### 2.3 The defect is an order ideal — structural input 3

The graded union law constrains not just $q$ but the *shape* of the defect.

> **Lemma 2.4 (relative filter structure of the fibres).** For every $S\subseteq W$, the fibre $\mathcal R_S$ is an **order filter** (up-set) of the union-closed family $\widetilde{\mathcal R}_S$, and therefore the defect $\mathcal D_S:=\widetilde{\mathcal R}_S\setminus\mathcal R_S$ is an **order ideal** (down-set) of $\widetilde{\mathcal R}_S$.

*Proof.* First, $\mathcal R_S$ is a semigroup ideal of $\widetilde{\mathcal R}_S$ under $\cup$: if $R\in\mathcal R_S$ and $R'\in\widetilde{\mathcal R}_S$, say $R'\in\mathcal R_{S_0}$ with $S_0\subseteq S$, then the graded union law gives $R\cup R'\in\mathcal R_{S\cup S_0}=\mathcal R_S$. Hence $\mathcal R_S$ is an up-set in the poset $(\widetilde{\mathcal R}_S,\subseteq)$: if $R\in\mathcal R_S$ and $R\subseteq R''$ with $R''\in\widetilde{\mathcal R}_S$, then $R''=R\cup R''\in\mathcal R_S$. The complement of an up-set is a down-set. $\qquad\blacksquare$

Lemma 2.4 is exactly UC3's structural input 3 ("the ideal/filter structure of $\mathcal R_W$"), now sharpened from a statement about the single split $\mathcal R_W=\mathcal R_W^{\mathrm{sm}}\sqcup\mathcal R_W^{\mathrm{lg}}$ to a statement about *every* cumulative fibre: each $\widetilde{\mathcal R}_S$ splits, canonically, into the filter $\mathcal R_S$ and the ideal $\mathcal D_S$. The defect $d_S=|\mathcal D_S|$ is therefore the size of an order ideal — "defect is a *low* phenomenon within each cumulative fibre." This is the structural reason to expect $D(W)$ controllable: §3 turns it, together with the minimality grading, into the sub-case theorems.

---

## §3. Closing the residual: structured sub-cases and the named frontier residual

Corollary 2.3 reduces Phase 1 to $D(W)\le 0$ (sufficient) or $D(W)\le Q(W)$ (exact). This section proves $D(W)\le 0$ on two structured native sub-classes, names the residual explicitly at the $k=3$ frontier, and places the result against UC3's bounded-spread theorem.

### 3.1 $W$-monotone families: the zero-defect class

> **Definition.** $\mathcal F$ is **$W$-monotone** if for every $A\in\mathcal F$ and every $A'$ with $A\subseteq A'\subseteq A\cup W$, also $A'\in\mathcal F$. Equivalently: in every cube-interval $[A,A\cup W]$, the trace can only be enlarged within $W$ without leaving $\mathcal F$.

> **Theorem 3.1 ($W$-monotone $\Rightarrow$ Frankl, witnessed in $W$).** If $\mathcal F$ is $W$-monotone then $d\equiv 0$, hence $\sigma(W)=Q(W)\ge 0$ and some $x\in W$ is abundant.

*Proof.* Let $S_0\subseteq S\subseteq W$ and $R\in\mathcal R_{S_0}$, so $A:=S_0\sqcup R\in\mathcal F$. Then $A\subseteq S\sqcup R\subseteq A\cup W$, so $W$-monotonicity gives $S\sqcup R\in\mathcal F$, i.e. $R\in\mathcal R_S$. Thus $\mathcal R_{S_0}\subseteq\mathcal R_S$ for all $S_0\subseteq S$, so $\widetilde{\mathcal R}_S=\mathcal R_S$ and $d_S=0$. By Corollary 2.3, $\sigma(W)=Q(W)\ge 0$; $\max_{x\in W}\beta_x\ge\frac1k\sigma(W)\ge 0$. $\qquad\blacksquare$

$W$-monotonicity is the condition "every co-fibre $\mathcal S(R)$ is a filter": the defect $\mathcal D(R)$ vanishes for all $R$, and the residual is closed by the monotone engine alone. It is a genuine new region of the $m(\mathcal F)\ge 3$ frontier — it is not the bounded-spread region of UC3 Theorem 3.5 (which bounds fibre *size*: $\mathcal R_W^{\mathrm{lg}}=\emptyset$), it bounds the *trace shape*. The two are complementary: a $W$-monotone family can have arbitrarily large fibres, and a bounded-spread family need not be $W$-monotone (Example 3.6 below is bounded-spread-free *and* not $W$-monotone). Together they carve out two independent native slices of the frontier the entropy method does not separately see.

### 3.2 Low-defect families: defect confined to the lower half

> **Theorem 3.2 (low-defect $\Rightarrow$ Frankl, witnessed in $W$).** If $d_S=0$ for every $S$ with $|S|>k/2$, then $D(W)\le 0$, hence $\sigma(W)\ge 0$ and some $x\in W$ is abundant.

*Proof.* $D(W)=\sum_{S}d_S(2|S|-k)=\sum_{|S|\le k/2}d_S(2|S|-k)$, and every term has $d_S\ge 0$, $2|S|-k\le 0$. Hence $D(W)\le 0$; apply Corollary 2.3. $\qquad\blacksquare$

The hypothesis "$d_S=0$ for $|S|>k/2$" says: above the half-level, the co-fibres are up-closed — $\mathcal F$ is *$W$-monotone in its upper half*. By Lemma 2.4, $d_S=|\mathcal D_S|$ with $\mathcal D_S$ an order ideal of $\widetilde{\mathcal R}_S$; "low-defect" asks these ideals to be empty for large $S$. This is strictly weaker than $W$-monotonicity (which asks all $\mathcal D_S=\emptyset$) and is the natural "structured sub-case of large fibres" the GREEN-partial tag anticipates: the dangerous configurations of UC3 (large $R$ with thin low co-fibre) are exactly those producing high-$S$ defect, and Theorem 3.2 closes the residual whenever they are absent above the half-level.

### 3.3 The named residual

> **The UC4 Phase-1 residual, named.** To close the per-generator target along the up-closure route it suffices to show, for the fixed minimal generator $W$,
> $$
>   D(W)\;=\;\sum_{S\subseteq W}d_S\,(2|S|-k)\;\le\;0,
>   \qquad d_S=|\widetilde{\mathcal R}_S\setminus\mathcal R_S|,
> $$
> and it is necessary and sufficient that $D(W)\le Q(W)$. Equivalently, splitting at the half-level,
> $$
>   \sum_{|S|>k/2}d_S\,(2|S|-k)\;\le\;\sum_{|S|<k/2}d_S\,(k-2|S|)\qquad\bigl(+\,Q(W)\ \text{for the exact form}\bigr):
> $$
> *the high-trace defect must not out-weigh the low-trace defect* (plus the monotone slack $Q(W)$). The structural inputs that must do the work, now sharpened from UC3 §3.6:
> 1. **The graded union law** — already consumed twice (Lemma 2.1: $\widetilde{\mathcal R}_S$ union-closed; Lemma 2.4: $\mathcal R_S$ a filter of it). What remains unexploited is the *cross-$S$* coupling: $\mathcal D_{S}$ for different $S$ are not independent order ideals — they are cut out of the nested family $\widetilde{\mathcal R}_S$ by the same incidence relation.
> 2. **The minimality grading** (UC3 Prop 2.6) — this is what should force the defect *low*. A defect element $R\in\mathcal D_S$ at a *high* trace $S$ ($|S|>k/2$) has $R\in\widetilde{\mathcal R}_S\setminus\mathcal R_S$: there is $S_0\subsetneq S$ with $S_0\sqcup R\in\mathcal F$, $|S_0|\ge\max(0,k-|R|)$, but $S\sqcup R\notin\mathcal F$. The grading constrains *which* $S_0$ can witness this; making "high-$S$ defect is rare/light" precise is the open core.
> 3. **The order-ideal structure** (Lemma 2.4) — $d_S=|\mathcal D_S|$ counts an order ideal; bounding $\sum_{|S|>k/2}d_S$ against $\sum_{|S|<k/2}d_S$ is a statement comparing the *sizes* of these ideals across the half-level.

This is a strict sharpening of UC3 §3.6: there, the residual was a sum of $\Phi$-values over an un-decomposed object ($\mathcal R_W^{\mathrm{lg}}$); here it is the sign of a *single scalar* $D(W)$, attached to an *explicitly order-ideal-structured* defect profile $d$, with the entire positive part $Q(W)$ already discharged.

### 3.4 The $k=3$ frontier, explicitly

The frontier of Frankl is $m(\mathcal F)=3$. At $k=3$ the residual collapses to a two-line inequality.

> **Proposition 3.4 (the $k=3$ residual).** For $k=3$ the trace weights are $2|S|-3\in\{-3,-1,+1,+3\}$ and $d_\emptyset=d_W=0$, so
> $$
>   D(W)=\sum_{|S|=2}d_S-\sum_{|S|=1}d_S,
>   \qquad\text{hence}\qquad
>   D(W)\le 0\iff\sum_{|S|=2}d_S\le\sum_{|S|=1}d_S.
> $$
> Moreover the singleton defects are explicit: for $|W|=3$ and $x\in W$,
> $$
>   d_{\{x\}}=|\widetilde{\mathcal R}_{\{x\}}\setminus\mathcal R_{\{x\}}|=|\mathcal R_\emptyset\setminus\mathcal R_{\{x\}}|,
> $$
> since $\widetilde{\mathcal R}_{\{x\}}=\mathcal R_\emptyset\cup\mathcal R_{\{x\}}$; and for $\{x,y\}\subsetneq W$, $d_{\{x,y\}}=|\widetilde{\mathcal R}_{\{x,y\}}\setminus\mathcal R_{\{x,y\}}|$ with $\widetilde{\mathcal R}_{\{x,y\}}=\mathcal R_\emptyset\cup\mathcal R_{\{x\}}\cup\mathcal R_{\{y\}}\cup\mathcal R_{\{x,y\}}$.

*Proof.* Direct from $D(W)=\sum_S d_S(2|S|-3)$ with the stated weights and $d_\emptyset=d_W=0$. The singleton formula: $\widetilde{\mathcal R}_{\{x\}}=\mathcal R_\emptyset\cup\mathcal R_{\{x\}}$, so $\widetilde{\mathcal R}_{\{x\}}\setminus\mathcal R_{\{x\}}=\mathcal R_\emptyset\setminus\mathcal R_{\{x\}}$. $\qquad\blacksquare$

That this residual cannot be closed *outright* is the honest content of the frontier: $D(W)\le 0$ for a single minimal generator with $k=3$ would, by Corollary 2.3, prove $\sigma(W)\ge 0$ and hence Frankl for every family with $m(\mathcal F)=3$ — an open case. So Proposition 3.4 is exactly as far as a *per-generator, single-$W$* argument can be pushed: the residual is named, explicit, finitary, and structurally located (a comparison of order-ideal sizes across the half-level). Closing it requires either a genuinely new use of the graded union law's cross-$S$ coupling (input 1, §3.3) — or the I1 interlock of §4, which is the route the chain was designed to take.

### 3.5 Two worked examples

**Example 3.5 (the $W$-monotone case — UC3's example revisited).** $U=\{1,2,3,4\}$, $W=\{1,2,3\}$, $U'=\{4\}$, $\mathcal F=\{W,\{1,2,4\},\{1,2,3,4\}\}$ (union-closed, $m(\mathcal F)=3$). Fibres: $\mathcal R_W=\{\emptyset,\{4\}\}$, $\mathcal R_{\{1,2\}}=\{\{4\}\}$, all other $\mathcal R_S=\emptyset$; so $p_{\{1,2\}}=1$, $p_W=2$. Cumulative fibres: $\widetilde{\mathcal R}_S=\mathcal R_S$ for every $S$ (one checks $\widetilde{\mathcal R}_{\{1,2\}}=\mathcal R_\emptyset\cup\mathcal R_{\{1\}}\cup\mathcal R_{\{2\}}\cup\mathcal R_{\{1,2\}}=\{\{4\}\}=\mathcal R_{\{1,2\}}$, etc.), so $d\equiv 0$ and $\mathcal F$ is $W$-monotone. Then $Q(W)=\langle q,\phi\rangle=1\cdot(2\cdot2-3)+2\cdot(2\cdot3-3)=1+6=7$, $D(W)=0$, $\sigma(W)=7-0=7\ge 0$. Theorem 3.1 applies.

**Example 3.6 (the $D(W)>0$ case — sufficient but not necessary).** $U=\{1,2,3,4,5\}$, $W=\{1,2,3\}$, $U'=\{4,5\}$, $\mathcal F=\{\{1,4,5\},\,\{1,2,3\},\,\{1,2,3,4,5\}\}$. Union-closed (the only non-trivial union is $\{1,4,5\}\cup\{1,2,3\}=\{1,2,3,4,5\}\in\mathcal F$), $m(\mathcal F)=3$, $W$ a minimal generator. Fibres: $\mathcal R_{\{1\}}=\{\{4,5\}\}$, $\mathcal R_W=\{\emptyset,\{4,5\}\}$, all others empty; $p_{\{1\}}=1$, $p_W=2$. Cumulative fibres:
$$
  q_\emptyset=0,\quad q_{\{1\}}=1,\ q_{\{2\}}=q_{\{3\}}=0,\quad
  q_{\{1,2\}}=q_{\{1,3\}}=1,\ q_{\{2,3\}}=0,\quad q_W=2,
$$
($\widetilde{\mathcal R}_{\{1,2\}}=\mathcal R_\emptyset\cup\mathcal R_{\{1\}}\cup\mathcal R_{\{2\}}\cup\mathcal R_{\{1,2\}}=\{\{4,5\}\}$, and likewise $\widetilde{\mathcal R}_{\{1,3\}}$). One verifies $q$ is monotone. The defect: $d=q-p$ gives $d_{\{1,2\}}=d_{\{1,3\}}=1$, all other $d_S=0$. Then
$$
  Q(W)=1\cdot(-1)+1\cdot(1)+1\cdot(1)+2\cdot(3)=7,\qquad
  D(W)=1\cdot(1)+1\cdot(1)=2,\qquad \sigma(W)=7-2=5\ge 0.
$$
(Cross-check via (0.1): $\sigma(W)=p_{\{1\}}(-1)+p_W(3)=-1+6=5$.) Here $D(W)=2>0$, so the *sufficient* condition $D(W)\le 0$ **fails** — yet Frankl holds for $W$ because the *exact* condition $D(W)\le Q(W)$ holds with room to spare ($2\le 7$). And $\mathcal F$ is **not** $W$-monotone ($\{1,4,5\}\in\mathcal F$, $\{1,4,5\}\subseteq\{1,2,4,5\}\subseteq\{1,4,5\}\cup W$, but $\{1,2,4,5\}\notin\mathcal F$). Example 3.6 is the precise illustration that the residual's true content is $D(W)\le Q(W)$, with $D(W)\le 0$ a clean but strictly stronger sufficient condition — and that the monotone part $Q(W)$ carries real, often decisive, slack.

### 3.6 Relation to UC3's per-fibre theorem

UC3's per-fibre sign theorem (Thm 3.3) and UC4's up-closure decomposition are two *different* decompositions of the same $\sigma(W)$, and they are complementary:

- **UC3 (primal, indexed by fibres):** $\sigma(W)=\sum_{R\in\mathcal R_W}\Phi(\mathcal S(R))$, split by *fibre size* — small/medium fibres ($|R|\le\lfloor k/2\rfloor$) contribute $\ge 0$ by the minimality grading, localizing the residual to $\mathcal R_W^{\mathrm{lg}}$.
- **UC4 (dual, indexed by traces):** $\sigma(W)=Q(W)-D(W)$, split by *trace*, after up-closure — the monotone part $Q(W)\ge 0$ unconditionally, localizing the residual to the defect scalar $D(W)$.

Neither subsumes the other: UC3's bounded-spread sufficient condition (Thm 3.5, $\mathcal R_W^{\mathrm{lg}}=\emptyset$) and UC4's $W$-monotone / low-defect conditions (Thms 3.1, 3.2) cut out *different* slices of the $m(\mathcal F)\ge 3$ frontier, as Example 3.6 (bounded-spread-free, non-$W$-monotone, yet $\sigma(W)\ge 0$) shows. A future session may combine them — e.g. apply the per-fibre theorem to bound $D(W)$'s positive part on small fibres while the monotone engine handles the rest — but UC4 keeps them as the two clean, independently-proven tools they are.

---

## §4. Phase 2: the I1 interlock, assembled

Phase 1 produced, for *each* minimal generator $W$, the decomposition $\sigma(W)=Q(W)-D(W)$ with $Q(W)\ge 0$. If Phase 1 closed in general — $D(W)\le Q(W)$ for some single $W$ — Frankl would follow from that one generator and Phase 2 would be vacuous. The point of Phase 2 is precisely the case where *no single generator* is known to satisfy $D(W)\le Q(W)$: the I1 interlock couples the per-generator inequalities so that the generators can *carry each other*.

### 4.1 The interlock identity

Let $\mathcal W:=\{W\in\mathcal F:|W|=m(\mathcal F)=k\}$ be the (non-empty) set of minimal generators, and for $x\in U$ let $\deg_{\mathcal W}(x):=|\{W\in\mathcal W:x\in W\}|$.

> **Theorem 4.1 (the I1 interlock identity).** For any non-negative weights $c:\mathcal W\to\mathbb R_{\ge 0}$,
> $$
>   \sum_{W\in\mathcal W}c_W\,\sigma(W)\;=\;\sum_{x\in U}\Bigl(\sum_{W\in\mathcal W:\,x\in W}c_W\Bigr)\beta_x.
> $$
> In particular, with $c\equiv 1$: $\displaystyle\sum_{W\in\mathcal W}\sigma(W)=\sum_{x\in U}\deg_{\mathcal W}(x)\,\beta_x$.

*Proof.* $\sum_W c_W\sigma(W)=\sum_W c_W\sum_{x\in W}\beta_x=\sum_{x\in U}\beta_x\sum_{W\ni x}c_W$, exchanging the (finite) sums. $\qquad\blacksquare$

This is the linear-system coupling UC2 §3.4 named "I1, many generators": the per-generator scalars $\sigma(W)$ are not independent — they are the image of the bias vector $\beta\in\mathbb R^U$ under the **incidence operator** $M:\mathbb R^U\to\mathbb R^{\mathcal W}$, $(M\beta)_W=\sum_{x\in W}\beta_x=\sigma(W)$. The matrix $M\in\{0,1\}^{\mathcal W\times U}$ has the minimal generators as rows.

### 4.2 The interlock theorem: per-generator $\to$ global

> **Theorem 4.2 (the I1 interlock — global defect suffices).** Suppose
> $$
>   \sum_{W\in\mathcal W}D(W)\;\le\;\sum_{W\in\mathcal W}Q(W)
> $$
> (in particular, suppose $\sum_{W\in\mathcal W}D(W)\le 0$, since each $Q(W)\ge 0$). Then $\sum_{x}\deg_{\mathcal W}(x)\beta_x\ge 0$, and since $\deg_{\mathcal W}\ge 0$ with $\deg_{\mathcal W}(x)\ge 1$ for every $x\in\bigcup\mathcal W\neq\emptyset$, **some coordinate $x$ has $\beta_x\ge 0$: Frankl holds for $\mathcal F$.**

*Proof.* By Corollary 2.3 applied to each $W$ and Theorem 4.1 with $c\equiv 1$,
$$
  \sum_{x}\deg_{\mathcal W}(x)\beta_x=\sum_{W\in\mathcal W}\sigma(W)=\sum_{W\in\mathcal W}Q(W)-\sum_{W\in\mathcal W}D(W)\ge 0
$$
under the hypothesis. If every $\beta_x<0$, then every term $\deg_{\mathcal W}(x)\beta_x\le 0$, and the terms with $x\in\bigcup\mathcal W$ are strictly negative (there $\deg_{\mathcal W}(x)\ge 1$), forcing $\sum_x\deg_{\mathcal W}(x)\beta_x<0$ — a contradiction. So some $\beta_x\ge 0$. $\qquad\blacksquare$

Theorem 4.2 is the **interlock's payoff**: it relaxes the Phase-1 requirement from *per-generator* $D(W)\le Q(W)$ (needed for each $W$ separately) to a *single global* inequality $\sum_W D(W)\le\sum_W Q(W)$. A counterexample to Frankl would need *every* minimal generator to be strictly defect-dominated ($D(W)>Q(W)\ge 0$ for all $W$, since each $\sigma(W)=\sum_{x\in W}\beta_x<0$); the interlock asserts union-closure forbids the *simultaneity*. Bad generators (large $D(W)$) may be carried by good ones (large slack $Q(W)-D(W)$); only the aggregate must balance. This is genuinely a compatibility-geometry statement — it is the partial-cube structure of $\mathcal F$, read through the generators — and it is exactly the I1 mechanism UC2 §3.4 and UC3 §4.4 pointed at.

The weighted form is available too: for any $c:\mathcal W\to\mathbb R_{\ge 0}$, $c\not\equiv 0$, if $\sum_W c_W D(W)\le\sum_W c_W Q(W)$ then $\sum_x(\sum_{W\ni x}c_W)\beta_x\ge 0$, hence some $\beta_x\ge 0$. Non-uniform $c$ lets the interlock down-weight generators whose defect is hard to control and lean on the structurally clean ones (e.g. the $W$-monotone generators of Theorem 3.1, for which $D(W)=0$ and $c_W$ may be taken large).

### 4.3 The generator cross-incidence — structure of the interlock matrix

The interlock matrix $M$ is not arbitrary: union-closure forces the minimal generators to populate each other's fibres.

> **Lemma 4.3 (generator cross-incidence).** Let $W,W'\in\mathcal W$ be distinct. Then $S^*:=W\cap W'$ is a trace of $W$ with $0\le|S^*|<k$, and
> $$
>   W'\setminus W\;\in\;\mathcal R^{W}_{S^*}\;\subseteq\;\mathcal R_W,\qquad |W'\setminus W|=k-|S^*|\ge 1.
> $$
> Symmetrically $W\setminus W'\in\mathcal R^{W'}_{S^*}$. Consequently every minimal generator $W'\neq W$ pins one element of size $k-|W\cap W'|$ into a fibre of $W$; if $|W\cap W'|<k/2$ it is a **large**-fibre element of $W$.

*Proof.* $W'\in\mathcal F$ with $W'\cap W=S^*$ and $W'\setminus W=W'\setminus S^*$, so $W'=S^*\sqcup(W'\setminus W)\in\mathcal F$ exhibits $W'\setminus W\in\mathcal R^W_{S^*}$; the universal fibre inclusion gives $\mathcal R^W_{S^*}\subseteq\mathcal R_W$. Sizes: $|W'\setminus W|=|W'|-|S^*|=k-|S^*|$, and $|S^*|<k$ because $W\ne W'$ with $|W|=|W'|=k$ (if $S^*=W$ then $W\subseteq W'$, forcing $W=W'$). $\ge 1$ since $|S^*|\le k-1$. $\qquad\blacksquare$

So the interlock has a concrete combinatorial backbone: a generator $W$ that is "far" from many others (many $W'$ with $|W\cap W'|$ small) is *forced* to have many large-fibre elements — exactly the configurations that make $D(W)$ hard to sign. But those same co-generators $W'$ each carry $W$ in *their* fibres too (the symmetric statement), so far-apart generators load each other's residuals symmetrically. The I1 linear system is the bookkeeping of this mutual loading: a counterexample would have to make the *whole* incidence pattern $M$ — together with the fibre data it forces — simultaneously defect-dominated, and Theorem 4.2 is the assertion that the aggregate cannot be.

### 4.4 The Phase-2 residual, named

> **The UC4 Phase-2 residual, named.** To complete the I1 interlock it remains to show
> $$
>   \sum_{W\in\mathcal W}D(W)\;\le\;\sum_{W\in\mathcal W}Q(W)
> $$
> (sufficient: $\sum_{W\in\mathcal W}D(W)\le 0$), or the weighted version for some $c:\mathcal W\to\mathbb R_{\ge 0}$. This is *strictly weaker* than the Phase-1 residual ($D(W)\le Q(W)$ for a single $W$): it is an inequality between two sums over *all* generators, and it is feasible to satisfy globally even when no individual generator satisfies it. The unexploited leverage is the cross-incidence of Lemma 4.3 — the fact that $D(W)$ and $D(W')$ are not independent, because $W'$ sits in $\mathcal R_W$ and $W$ sits in $\mathcal R_{W'}$, so the defect a far generator $W'$ contributes to $W$'s residual is the *same incidence datum* as the defect $W$ contributes to $W'$'s. Quantifying that symmetry into the global bound is the Phase-2 next step.

### 4.5 Why this is structurally past the entropy-method ceiling

UC3 §4 established that the localized object retains the coordinate coupling the entropy method's decoupled relaxation discards, and that its residual is finitary and exact rather than asymptotic. UC4 makes the *form* of that statement concrete:

- **The monotone part is the "decoupled-visible" part.** $Q(W)=\langle q,\phi\rangle$ for a *monotone* profile $q$; monotone Boolean structure is exactly what influence/entropy inequalities estimate well, and indeed $Q(W)\ge 0$ falls to the one-line Lemma 1.1 with no slack. The entropy method, run on $W$, can see this part.
- **The defect is the "coupling-only" part.** $D(W)=\langle d,\phi\rangle$ for the *non-monotone* residual $d$ — the order-ideal-structured trace-defect (Lemma 2.4). It is invisible to any decoupled per-coordinate relaxation, because $d_S=|\widetilde{\mathcal R}_S\setminus\mathcal R_S|$ is defined by the *joint* incidence relation $S\sqcup R\in\mathcal F$, not by marginals. This is the precise locus of UC3 §4.2's "coordinate coupling."
- **No ceiling-shaped obstruction.** Both $Q(W)$ and $D(W)$ are finite integer sums of integer functionals on the small cube $2^W$; the residual $D(W)\le Q(W)$ (and its global form) is an exact inequality with no $\varepsilon$, no limit, no entropy term, hence no $(3-\sqrt 5)/2$-shaped ceiling. Whatever its truth value, it is decided by concrete finite configurations — precisely the GREEN-walsh-characterization promise UC3 made, now carried one structural step further.

UC4 does **not** prove a bound past $(3-\sqrt 5)/2$ and does not resolve Frankl. It does isolate the entire residual — per-generator and global — into the sign of an explicitly-structured defect scalar, prove the complementary monotone part unconditionally, close two native sub-classes of the frontier, and assemble the I1 interlock as a genuine relaxation. The structural reason the entropy method stalls (coordinate decoupling) is not merely "removed" as in UC3 — it is *located*: it is the defect profile $d$, and nothing else.

---

## §5. Verdict and the precise next step

**Verdict: GREEN-partial.**

UC4's two phases, against the ticket's scope:

1. **Phase 1 — close the large-fibre residual (per-generator) — substantially advanced (§§1–3).** The engine (Lemma 1.1: monotone $\Rightarrow$ signed aggregate) turns the missing harmonic fact into a one-line identity. The up-closure decomposition (Lemma 2.1, Theorem 2.2, Corollary 2.3) splits $\sigma(W)=Q(W)-D(W)$ with $Q(W)\ge 0$ *unconditionally and natively* — discharging the entire positive half of UC3 §3.6 — and isolates the residual into the single scalar $D(W)$. The defect is order-ideal-structured (Lemma 2.4 — UC3 input 3). Two native sufficient conditions close the residual on structured sub-classes of the $m(\mathcal F)\ge 3$ frontier: $W$-monotone families (Theorem 3.1, $d\equiv 0$) and low-defect families (Theorem 3.2, $d$ confined below the half-level), both complementary to UC3's bounded-spread Theorem 3.5. The frontier residual is named explicitly, including the two-line $k=3$ form (Proposition 3.4), and two worked examples (3.5, 3.6) pin down that $D(W)\le 0$ is sufficient but $D(W)\le Q(W)$ is exact.
2. **Phase 2 — assemble the I1 interlock — assembled (§4).** The per-generator identities couple through the shared biases via the incidence operator $M$ (Theorem 4.1). The interlock theorem (Theorem 4.2) relaxes the Phase-1 requirement from *per-generator* $D(W)\le Q(W)$ to the *single global* inequality $\sum_W D(W)\le\sum_W Q(W)$ — bad generators carried by good ones. The interlock matrix has concrete structure: the generators populate each other's fibres (Lemma 4.3). The Phase-2 residual is named precisely (§4.4) and is strictly weaker than the Phase-1 residual.

**The central question, sharpened to one precise next step.** Every road in UC4 converges on the defect profile:

> **The UC4 residual (per-generator and global).** For a minimal generator $W$, the trace-defect profile $d_S=|\widetilde{\mathcal R}_S\setminus\mathcal R_S|$ is non-negative, vanishes at $\emptyset$ and $W$, and is order-ideal-structured (Lemma 2.4). Show either the **per-generator** residual $D(W)=\langle d,\phi\rangle\le Q(W)$ (sufficient: $\le 0$), or the **global** residual $\sum_{W\in\mathcal W}D(W)\le\sum_{W\in\mathcal W}Q(W)$ (sufficient: $\le 0$). The unexploited inputs: the *cross-$S$* coupling of the graded union law (the $\mathcal D_S$ are cut from one nested family by one incidence relation) and the *cross-generator* symmetry of Lemma 4.3 ($W'\in\mathcal R_W\iff W\in\mathcal R_{W'}$). This is a finitary, exact inequality between integer functionals — no asymptotics, no entropy slack, no ceiling.

**Indicated route for a UC5 / continuation.** Continue F-i on the named residual: (a) exploit the cross-$S$ coupling to bound $\sum_{|S|>k/2}d_S$ against $\sum_{|S|<k/2}d_S$ using minimality grading (UC3 Prop 2.6) — the natural Phase-1 push; (b) quantify the Lemma 4.3 cross-incidence symmetry into the global Phase-2 bound; (c) combine the UC3 per-fibre theorem with the UC4 monotone engine (§3.6). The documented fallbacks remain available with explicit hooks: **F-ii** (component / $H_0$ route) attaches to the order-ideal structure of the defect (Lemma 2.4) via the Hall criterion UC2 Prop 3.6 applied to $\widetilde{\mathcal R}_S$; **F-iii** (square-defect route) attaches to the cross-$S$ coupling of the graded union law. Neither is pursued here — the Walsh route did not stall.

**Why GREEN-partial is the honest tag.** Not GREEN-residual-closed: neither the per-generator nor the global residual is fully closed. Not GREEN-phase1: the per-generator residual is reduced to one clean scalar and closed on two structured sub-classes, but not in general — and it cannot be by a single-$W$ argument, since $D(W)\le 0$ at $k=3$ would prove Frankl on the open $m(\mathcal F)=3$ frontier. Not AMBER-residual-stalls: the Walsh route does not stall — the positive part $Q(W)\ge 0$ is closed unconditionally, the residual is isolated into a single explicitly-structured scalar, two new native sufficient conditions are proven, the frontier residual is named in closed form, and the I1 interlock is assembled with a genuine relaxation. The defining feature of GREEN-partial — "the residual is substantially advanced (e.g. closed for a structured sub-case of large fibres) but not fully; recommend the continuation" — is met exactly.

**Trust-surface impact: none.** Paper-and-pencil; no new axioms, no Lean, no computation. No engine ported (UC1 §8.4's dead routes E1–E3 / C1–C5 untouched — UC4 builds only on the pinned objects of UC1 §1, the structure theory of UC2 §§2–3, and the characterization of UC3 §2). The 1/3-2/3 critical path (`one_third_width_three`) is in a different repo and is untouched.

---

## §6. References

### 6.1 This repo / parent chain

- **mg-cfc0 (UC3)** — `docs/union-closed-UC3-walsh-subcube-spectrum.md`: §2 (the sub-cube Walsh characterization — graded union law Prop 2.2, universal fibre inclusion Thm 2.3, dual reduction Thm 2.5, minimality grading Prop 2.6 — the standing toolkit of §0 here); §3 (the attack — per-fibre sign theorem Thm 3.3, large-fibre localization Cor 3.4, bounded-spread sufficient condition Thm 3.5, complementary to UC4 §3); §3.6 (the residual and its three unexploited structural inputs, which UC4 §§1–3 consume); §4 (the Gilmer framing, sharpened in UC4 §4.5); §5 (the UC4 target and the indicated route). `docs/state-UC3.md` — the UC3 invariants.
- **mg-a814 (UC2)** — `docs/union-closed-UC2-transport-deficiency.md`: §3.3 (the trace-partition theorem Thm 3.5, the identity (0.1) here is UC2's (3.1)); §3.4 (the interlock I1, "many generators" — the Phase-2 mechanism UC4 §4 assembles, and I2 routing-through-$M_y$, not pursued); §3.5 (the Hall criterion Prop 3.6 — the F-ii hook of UC4 §5); §§2–3 (the structure theory). `docs/state-UC2.md` — the UC2 invariants.
- **mg-f72a (UC1)** — `docs/union-closed-compat-geom-manifesto.md`: §1.6 (the obstruction in Walsh form, $\beta_x=-2^n\widehat{\mathbf 1_{\mathcal F}}(\{x\})$); §8.3 (fallback F-i, the Walsh/harmonic route UC4 continues); §8.4 (the dead routes UC4 avoids); §1.7 (the $(\mathbb Z/2)^n$/Walsh world UC4 stays in). `docs/state-UC1.md` — the UC1 invariants.

### 6.2 Cross-repo — `one_third_width_three` (read access)

Used by UC4 only to stay clear of the dead routes (UC1 §8.4): the BK/Cheeger-expansion engine and Theorem E (gaps E1–E3), the F-series cohomological program and $\Delta(\mathrm{UCF}_n)$ (gaps C1–C5). UC4 is independent of the 1/3-2/3 critical path — different repo, different polecat.

### 6.3 Frankl-conjecture literature

- P. Frankl (1979) — the Union-Closed Sets conjecture.
- H. Bruhn, O. Schaudt, *The journey of the union-closed sets conjecture*, Graphs and Combinatorics 31 (2015) — the survey; the classical small-set cases (recovered natively in UC2 Thm 3.5(2)); the lattice reformulation.
- B. Poonen, *Union-closed families*, J. Combin. Theory Ser. A 59 (1992) — the lattice / join-irreducible reformulation.
- J. Gilmer, *A constant lower bound for the union-closed sets conjecture* (2022) — the entropy/information-theoretic method; framed in UC3 §4 and UC4 §4.5 as a level-1-spectrum estimator that sees the monotone part $Q(W)$ but not the defect $D(W)$.
- W. Sawin; Z. Chase & S. Lovett; R. Alweiss, B. Huang & M. Sellke; L. Pebody (2022–2023) — the improvement to $(3-\sqrt5)/2\approx 0.38197$ and Sawin's observation that the entropy method alone caps near there. The "Sawin ceiling" — the optimum of the decoupled per-coordinate relaxation; UC4 §4.5 locates the part of the localized object that escapes it (the defect profile $d$).
- R. O'Donnell, *Analysis of Boolean Functions* (2014) — Walsh–Fourier analysis on the cube; monotone Boolean functions; the level-1 spectrum and sub-cube restrictions; the symmetric chain decomposition behind Example 1.3.

### 6.4 Source directives

- Daniel directives 2026-05-14 — the `union_closed` product-line assignment; UC4 is the F-i (Walsh/harmonic) continuation, UC3-localized, per UC3 §5: close the large-fibre residual (Phase 1) and assemble the I1 interlock (Phase 2).

---

*Polecat: mg-0bf7 (UC4). Branch: `polecat-cat-mg-0bf7`. Verdict: **GREEN-partial** — the per-generator UC4 target decomposes natively as $\sigma(W)=Q(W)-D(W)$ via the cumulative fibre $\widetilde{\mathcal R}_S=\bigcup_{S_0\subseteq S}\mathcal R_{S_0}$ (union-closed, monotone in $S$): the monotone part $Q(W)=\langle q,\phi\rangle\ge 0$ is closed unconditionally by the one-line monotone aggregate-sign lemma, isolating the entire residual into the order-ideal-structured trace-defect scalar $D(W)=\langle d,\phi\rangle$; the residual closes when $D(W)\le Q(W)$, is proven $\le 0$ on the $W$-monotone and low-defect sub-classes (new native regions of the $m(\mathcal F)\ge 3$ frontier, complementary to UC3's bounded-spread theorem), and is named explicitly at the $k=3$ frontier; the I1 interlock is assembled — ranging $W$ over all minimal generators, $\sum_W\sigma(W)=\sum_x\deg_{\mathcal W}(x)\beta_x$, relaxing the per-generator residual to the single global inequality $\sum_W D(W)\le\sum_W Q(W)$, with the generator cross-incidence $W'\setminus W\in\mathcal R^W_{W'\cap W}$ giving the interlock matrix its structure. No new axioms; no Lean; no computation; no engine port. Phase-1 and Phase-2 residuals named precisely; continuation recommended.*
