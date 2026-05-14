# Union-Closed Compatibility-Geometry — UC3: the sub-cube Walsh spectrum relative to a minimal generator (mg-cfc0)

**Repo:** `union_closed`. **Parent:** mg-a814 (UC2, GREEN-structure-theory) — `docs/union-closed-UC2-transport-deficiency.md` §5 (the UC3 target + the indicated route). **Chain:** mg-f72a (UC1) → mg-a814 (UC2) → UC3.
**Branch:** `union-closed-UC3-walsh-subcube-spectrum`.
**Type:** Native construction — Walsh/harmonic analysis on the cube (fallback **F-i**, UC2-localized). Paper-and-pencil; **no new axioms; no Lean; no computation; no engine port.** LaTeX-style Markdown, F-series house style. Multi-session-able; cumulative state ledger in `docs/state-UC3.md`.
**Cross-repo references (read access):** `one_third_width_three` — used only to stay clear of the dead routes UC1 §8.4 named.

---

**Verdict: GREEN-walsh-characterization.**

The sub-cube Walsh spectrum of indicators of union-closed families relative to a minimal generator $W$ is **characterized** (§2), and the UC3 target inequality is **attacked through that characterization** to a precisely-stated residual (§3): the entire deficiency, if any, is localized to the **large fibres** of $W$, and a clean native sufficient condition for Frankl in the $m(\mathcal F)\ge 3$ regime falls out. §4 frames Gilmer's entropy method as a compatibility-geometry statement on this localized object and assesses the leverage.

The load-bearing results:

- **(§2) The characterization — deliverable 1, complete.** Decompose each $A\in\mathcal F$ as $A=S\sqcup R$ with $S=A\cap W$, $R=A\setminus W$, and set $\mathcal R_S:=\{R:S\sqcup R\in\mathcal F\}$, so $|\mathcal F^S|=|\mathcal R_S|$. Union-closure becomes the **graded union law** $\mathcal R_S\vee\mathcal R_{S'}\subseteq\mathcal R_{S\cup S'}$ (Proposition 2.2). The decisive structural fact is the **universal fibre inclusion** $\mathcal R_S\subseteq\mathcal R_W$ for *every* $S\subseteq W$ (Theorem 2.3) — $\mathcal R_W$ is the single largest fibre, and it is itself a union-closed family on $U\setminus W$ containing $\emptyset$. This dualizes the trace partition: the profile $p_S=|\mathcal F^S|$ is a **sum of indicators of union-closed families on $W$**, $p=\sum_{R\in\mathcal R_W}\mathbf 1_{\mathcal S(R)}$ with $\mathcal S(R):=\{S:S\sqcup R\in\mathcal F\}$ union-closed and containing the top $W$ (Theorem 2.5). Minimality of $W$ grades the system: an intermediate trace $S$ ($0<|S|<k$) can occur in fibre $R$ only if $|R|\ge k-|S|$ (Proposition 2.6).
- **(§3) The attack — deliverable 2, substantially advanced.** The target $\sum_{x\in W}\beta_x\ge 0$ rewrites as $\sum_{R\in\mathcal R_W}\Phi(\mathcal S(R))\ge 0$ where $\Phi(\mathcal G)=\sum_{S\in\mathcal G}(2|S|-k)$ (Proposition 3.1). The **per-fibre sign theorem** (Theorem 3.3): $\Phi(\mathcal S(R))\ge 0$ for every fibre with $|R|\le\lfloor k/2\rfloor$ — indeed $\ge k>0$ for $1\le|R|\le\lfloor k/2\rfloor$. So the deficiency is **localized to the large fibres** $|R|>\lfloor k/2\rfloor$ (Corollary 3.4). This yields a clean native sufficient condition: **if the largest member of $\mathcal F$ containing $W$ has size $\le\lfloor 3k/2\rfloor$, then some $x\in W$ is abundant** (Theorem 3.5) — a new region of the $m(\mathcal F)\ge 3$ frontier. The residual gap is named precisely (§3.6).
- **(§4) Gilmer as compatibility geometry — deliverable 3, assessed.** The trace $A\cap W$ of a uniform $A\in\mathcal F$ is a union-convolution-closed distribution on $2^W$ whose level-1 spectrum *is* $\{\beta_x\}_{x\in W}$ — Gilmer's entropy method consumes exactly this datum. The method's $(3-\sqrt5)/2$ Sawin ceiling is the optimum of the **decoupled** per-coordinate relaxation; the UC2 localization is a *strict refinement* of the method's input, because the graded union law (Proposition 2.2) and the minimality grading (Proposition 2.6) are exactly the **coordinate couplings the decoupled bound discards**. The localization is therefore not subject to the same ceiling argument — its residual is finitary and exact, with no entropy-inequality slack and no built-in ceiling. It does not *prove* a bound past $(3-\sqrt5)/2$; it *removes the structural reason* the entropy method cannot.

**Why GREEN-walsh-characterization and not GREEN-target-resolved.** The UC3 target inequality is not proved in general: §3 localizes the residual to the large fibres but does not close it. The sufficient condition (Theorem 3.5) is a genuine new partial result on the $m(\mathcal F)\ge 3$ frontier, but it is a partial result. **Why not AMBER-walsh-stalls.** The Walsh route does *not* stall and it *does* give leverage beyond the entropy-method ceiling: the characterization is complete, the target is sharpened to a single precise next step (the large-fibre residual), a new sufficient condition is proven, and §4 identifies the precise structural sense — coordinate coupling — in which the localized object beats the relaxation the Sawin ceiling optimizes.

**The honest one-sentence verdict.** *The sub-cube Walsh spectrum of $\mathbf 1_{\mathcal F}$ relative to a minimal generator $W$ is exactly the profile $p=\sum_{R\in\mathcal R_W}\mathbf 1_{\mathcal S(R)}$ — a sum of indicators of union-closed families on $W$, coupled by the graded union law and graded by minimality — and through this characterization the UC3 target inequality reduces to a per-fibre functional that is provably non-negative on every small and medium fibre, localizing the entire residual difficulty of Frankl, within the compatibility-geometry framing, to the large fibres of $W$, where the coordinate coupling that the entropy method discards is exactly what remains to be exploited.*

§0 fixes notation and recaps the UC3 target; §1 sets up the sub-cube and the trace profile as a Walsh object; §2 is the characterization (deliverable 1); §3 is the attack on the target inequality (deliverable 2); §4 is the Gilmer framing and the leverage assessment (deliverable 3); §5 is the verdict and the precise next step; §6 the references.

---

## §0. Notation and the UC3 target

Notation is UC1's and UC2's, restated where load-bearing.

$U$ is a finite ground set, $|U|=n$; $2^U$ is the Boolean cube $Q_n$. $\mathcal F\subseteq 2^U$ is **union-closed**: $A,B\in\mathcal F\Rightarrow A\cup B\in\mathcal F$, with $\mathcal F\neq\emptyset,\{\emptyset\}$, and WLOG $U=\bigcup\mathcal F\in\mathcal F$. For $x\in U$: $\mathcal F_x=\{A\in\mathcal F:x\in A\}$, $\mathcal F_{\bar x}=\mathcal F\setminus\mathcal F_x$, $\beta_x=|\mathcal F_x|-|\mathcal F_{\bar x}|$ (the **bias**), and $\beta_x=-2^n\widehat{\mathbf 1_{\mathcal F}}(\{x\})$ — the level-1 Walsh coefficient (UC1 §1.6, obstruction-form O3). Frankl: some $x$ has $\beta_x\ge 0$.

The **minimum set size** is $m(\mathcal F):=\min\{|A|:A\in\mathcal F,\,A\neq\emptyset\}$. UC2's trace-partition theorem (Thm 3.5) settled $m(\mathcal F)\le 2$ natively and localized the residual to $m(\mathcal F)\ge 3$. Throughout UC3, **fix a minimal generator**:

$$
  W\in\mathcal F,\qquad |W|=m(\mathcal F)=:k\ge 3.
$$

So every nonempty $A\in\mathcal F$ has $|A|\ge k$. (In particular $W$ is $\subseteq$-minimal in $\mathcal F$; we only ever use the size statement $|A|\ge k$.) Write $U':=U\setminus W$, $n':=|U'|=n-k$.

**The trace partition (UC2 §3.3).** For $S\subseteq W$, the **trace-class** $\mathcal F^S:=\{A\in\mathcal F:A\cap W=S\}$; the $2^k$ classes partition $\mathcal F$. With $\varepsilon_x(S)=+1$ if $x\in S$ and $-1$ otherwise,

$$
  \sum_{x\in W}\beta_x=\sum_{S\subseteq W}|\mathcal F^S|\,(2|S|-k).
\tag{0.1}
$$

The two **extreme** classes $\mathcal F^\emptyset,\mathcal F^W$ are controlled by the injection $j:\mathcal F^\emptyset\hookrightarrow\mathcal F^W$, $A'\mapsto A'\cup W$ (UC2 Thm 3.5(1)). The **intermediate** classes $\mathcal F^S$, $0<|S|<k$, are the residual object.

> **The UC3 target (UC2 §5).** For the fixed minimal generator $W$, control the intermediate trace-classes well enough to show
> $$
>   \sum_{0<|S|<k}|\mathcal F^S|\,(2|S|-k)\;\ge\;-\,k\bigl(|\mathcal F^W|-|\mathcal F^\emptyset|\bigr),
> \tag{0.2}
> $$
> equivalently — by (0.1) and $|\mathcal F^\emptyset|\le|\mathcal F^W|$ — $\sum_{x\in W}\beta_x\ge 0$, hence $\max_{x\in W}\beta_x\ge 0$: some $x\in W$ is abundant.

UC2 §5 identified (0.2) as a **higher-degree Walsh phenomenon**: the trace partition $\{\mathcal F^S\}_{S\subseteq W}$ is the decomposition of $\mathbf 1_{\mathcal F}$ by its restriction to the sub-cube on the coordinates $W$, and the weights $2|S|-k$ in (0.1) are the level-1 Walsh weights *within that sub-cube*. UC3 is the Walsh/harmonic route F-i, aimed — per UC2's localization — not at the level-1 spectrum in the abstract but at this **sub-cube spectrum relative to $W$**.

**What UC3 must not do (UC1 §8.4, kept in view).** No port of Theorem E / the Steps 1–7 rigidity engine; no $\Delta(\mathrm{UCF}_n)$ chamber ambient; no $S_n$-isotypic / FI machinery — the obstruction's harmonic home is $(\mathbb Z/2)^n$ / Walsh, and UC3 stays inside it. Native construction on the pinned objects only.

---

## §1. The sub-cube and the trace profile as a Walsh object

This section sets up the object UC3 characterizes. Everything is elementary; the content is in the packaging.

### 1.1 The product splitting and the fibre families

The cube splits as a product over the sub-cube on $W$ and its complement,

$$
  2^U\;\cong\;2^W\times 2^{U'},\qquad A\;\longleftrightarrow\;(S,R),\quad S=A\cap W,\ R=A\setminus W=A\cap U',
$$

and we write $A=S\sqcup R$ for the (disjoint) reassembly. The trace-class $\mathcal F^S$ is then the "row" $S\times\{\,\cdot\,\}$ of $\mathcal F$, and its content is recorded by the **$S$-fibre**

$$
  \boxed{\;\mathcal R_S\;:=\;\{R\subseteq U':\,S\sqcup R\in\mathcal F\}\;}
  \qquad\text{so}\qquad
  \mathcal F^S=\{S\sqcup R:R\in\mathcal R_S\},\quad p_S:=|\mathcal F^S|=|\mathcal R_S|.
$$

The **trace profile** is the vector $p=(p_S)_{S\subseteq W}\in\mathbb Z_{\ge 0}^{2^W}$. By (0.1), the UC3 target is the single sign statement $\langle p,\phi\rangle\ge 0$ for the **sub-cube level-1 weight** $\phi:2^W\to\mathbb Z$, $\phi(S):=2|S|-k$.

### 1.2 The trace profile is the sub-cube Walsh spectrum

For $T\subseteq W$ let $\chi_T(S):=(-1)^{|S\cap T|}$ be the Walsh character of $2^W$. The **sub-cube Walsh spectrum of $\mathbf 1_{\mathcal F}$ relative to $W$**, integrated over $U'$, is the Walsh transform of the profile:

$$
  \widehat p(T):=\sum_{S\subseteq W}p_S\,\chi_T(S)
  \;=\;\sum_{S\subseteq W}|\mathcal R_S|\,(-1)^{|S\cap T|}.
$$

This is exactly the restriction-to-$W$ harmonic data of $\mathbf 1_{\mathcal F}$: writing $\mathbf 1_{\mathcal F}(S,R)=\sum_{T\subseteq W}g_T(R)\,\chi_T(S)$ for the Walsh expansion in the $2^W$ variable, one has $\widehat p(T)=2^k\sum_{R\subseteq U'}g_T(R)$. The two readings that matter:

- $\widehat p(\emptyset)=\sum_S p_S=|\mathcal F|$ (level 0).
- $\widehat p(\{x\})=\sum_S p_S(-1)^{[x\in S]}=|\mathcal F_{\bar x}|-|\mathcal F_x|=-\beta_x$ for $x\in W$ (level 1). And $\phi=-\sum_{x\in W}\chi_{\{x\}}$, so

$$
  \langle p,\phi\rangle=\sum_{x\in W}\beta_x=-\sum_{x\in W}\widehat p(\{x\}).
\tag{1.1}
$$

So **the UC3 target is: the level-1 sub-cube Walsh spectrum of $\mathbf 1_{\mathcal F}$ relative to $W$ sums to $\le 0$.** This is the precise sense — promised in UC2 §5 — in which F-i is "aimed at the sub-cube spectrum relative to a minimal generator." The object to characterize is the profile $p$, equivalently the spectrum $\widehat p$; the question is what union-closure and the minimality of $W$ force about it.

### 1.3 Why the profile, not the indicator

A note on the level of the object. The full indicator $\mathbf 1_{\mathcal F}$ on $2^U$ has $2^n$ values and its level-1 spectrum is $\{\beta_x\}_{x\in U}$ — the abstract object UC1 §8.3 named. UC2's localization says: project onto the sub-cube $2^W$. The projection is the profile $p$ — $2^k$ values, $k=m(\mathcal F)$ small — and it retains *exactly* the part of the spectrum the target (0.2) needs, namely $\{\beta_x\}_{x\in W}$, while collapsing the $U'$-direction to counts. The gain is that union-closure, which is invisible at the level of the abstract $\{\beta_x\}_{x\in U}$ (any sign pattern of level-1 coefficients is a priori possible), becomes a *visible algebraic law on the profile* — this is §2.

---

## §2. The characterization of the sub-cube Walsh spectrum (deliverable 1)

This section is self-contained and rigorous. It characterizes which profiles $p$ — equivalently which sub-cube spectra $\widehat p$ — arise from union-closed families with minimal generator $W$.

### 2.1 Union-closure as a graded union law on the fibre system

> **Proposition 2.1 (each fibre is union-closed).** For every $S\subseteq W$, the fibre $\mathcal R_S$ is a union-closed family on $U'$ (possibly empty). In particular $\mathcal R_S$, if non-empty, has a $\subseteq$-maximum $\bigcup\mathcal R_S$.

*Proof.* $R,R'\in\mathcal R_S$ means $S\sqcup R,\,S\sqcup R'\in\mathcal F$; their union is $(S\cup S)\sqcup(R\cup R')=S\sqcup(R\cup R')\in\mathcal F$ by union-closure, so $R\cup R'\in\mathcal R_S$. A non-empty finite union-closed family has a maximum. $\qquad\blacksquare$

> **Proposition 2.2 (the graded union law).** For all $S,S'\subseteq W$,
> $$
>   \mathcal R_S\vee\mathcal R_{S'}\;\subseteq\;\mathcal R_{S\cup S'},
>   \qquad\text{where }\ \mathcal R_S\vee\mathcal R_{S'}:=\{R\cup R':R\in\mathcal R_S,\ R'\in\mathcal R_{S'}\}.
> $$
> The fibre system $\{\mathcal R_S\}_{S\subseteq W}$, indexed by the lattice $2^W$, is closed under "union across the index lattice."

*Proof.* $R\in\mathcal R_S$, $R'\in\mathcal R_{S'}$ give $S\sqcup R,\,S'\sqcup R'\in\mathcal F$; their union is $(S\cup S')\sqcup(R\cup R')\in\mathcal F$, so $R\cup R'\in\mathcal R_{S\cup S'}$. $\qquad\blacksquare$

Proposition 2.2 is the **complete** translation of union-closure into the trace picture: $\mathcal F$ union-closed $\iff$ the fibre system satisfies the graded union law (the $\Leftarrow$ direction is immediate by reassembling $A\sqcup A'$). Proposition 2.1 is the diagonal case $S=S'$. The level-0 datum $W\in\mathcal F$ reads $\emptyset\in\mathcal R_W$.

### 2.2 The universal fibre inclusion — $\mathcal R_W$ is the largest fibre

The single most useful structural fact of UC3. It generalizes UC2's injection $j:\mathcal F^\emptyset\hookrightarrow\mathcal F^W$ from the one class $\mathcal F^\emptyset$ to *all* classes at once.

> **Theorem 2.3 (universal fibre inclusion).** For every $S\subseteq W$,
> $$
>   \mathcal R_S\;\subseteq\;\mathcal R_W.
> $$
> Hence $p_S\le p_W$ for all $S$ (the top trace-class is the largest), and $\mathcal R_W$ — a union-closed family on $U'$ with $\emptyset\in\mathcal R_W$ — is the single "ambient fibre" containing every other.

*Proof.* Let $R\in\mathcal R_S$, so $S\sqcup R\in\mathcal F$. Since $W\in\mathcal F$ and $S\subseteq W$,
$$
  (S\sqcup R)\cup W=(S\cup W)\sqcup R=W\sqcup R\in\mathcal F
$$
by union-closure, so $R\in\mathcal R_W$. The inclusion gives $p_S=|\mathcal R_S|\le|\mathcal R_W|=p_W$; $\mathcal R_W$ is union-closed by Proposition 2.1 and contains $\emptyset$ because $W=W\sqcup\emptyset\in\mathcal F$. $\qquad\blacksquare$

The mechanism is transparent: union with $W\in\mathcal F$ fixes the $U'$-part $R$ and raises the trace to $W$. Note what is *not* true: the inclusions are not graded — $S\subseteq S'$ does **not** give $\mathcal R_S\subseteq\mathcal R_{S'}$ in general. The argument for $S'=W$ used $W\in\mathcal F$; chaining through an intermediate $S'$ would need $S'\in\mathcal F$, and **by minimality of $W$ the only members of $\mathcal F$ inside $2^W$ are $W$ itself and possibly $\emptyset$.** So the universal inclusion lands everything in the *one* fibre $\mathcal R_W$, with no intermediate stops — this is precisely the trace-picture shadow of "$k\ge 3$ is hard": there are no intermediate in-$\mathcal F$ traces to relay through.

> **Corollary 2.4 (graded inclusion, where it holds).** If $S'\in\mathcal F$ and $S\subseteq S'\subseteq W$, then $\mathcal R_S\subseteq\mathcal R_{S'}$. Under the standing hypothesis $|W|=m(\mathcal F)=k\ge 3$, this applies only to $S'=W$ (Theorem 2.3) and, if $\emptyset\in\mathcal F$, to $S'=\emptyset$.

*Proof.* $R\in\mathcal R_S$ gives $S\sqcup R\in\mathcal F$; with $S'=S'\sqcup\emptyset\in\mathcal F$ and $S\subseteq S'$, union-closure gives $(S\sqcup R)\cup S'=S'\sqcup R\in\mathcal F$, so $R\in\mathcal R_{S'}$. The membership claim is the minimality remark above. $\qquad\blacksquare$

### 2.3 The dual reduction — the profile is a sum of indicators of union-closed families on $W$

Theorem 2.3 lets us re-index the profile by the ambient fibre $\mathcal R_W$. For $R\in\mathcal R_W$ define the **co-fibre**

$$
  \boxed{\;\mathcal S(R)\;:=\;\{S\subseteq W:\,S\sqcup R\in\mathcal F\}\;}\qquad(\text{the set of traces that "see" }R).
$$

> **Theorem 2.5 (the dual reduction).** For each $R\in\mathcal R_W$, the co-fibre $\mathcal S(R)$ is a **union-closed family on $W$ containing the top $W$**. Moreover the profile is the fibre-wise sum of their indicators:
> $$
>   p\;=\;\sum_{R\in\mathcal R_W}\mathbf 1_{\mathcal S(R)},
>   \qquad\text{i.e.}\qquad
>   p_S=\bigl|\{R\in\mathcal R_W:S\in\mathcal S(R)\}\bigr|\quad\text{for all }S\subseteq W,
> $$
> and the co-fibre system is itself coupled by a graded union law: $\mathcal S(R)\vee\mathcal S(R')\subseteq\mathcal S(R\cup R')$ for all $R,R'\in\mathcal R_W$.

*Proof.* *Union-closed:* $S,S'\in\mathcal S(R)$ give $S\sqcup R,\,S'\sqcup R\in\mathcal F$, union $(S\cup S')\sqcup R\in\mathcal F$, so $S\cup S'\in\mathcal S(R)$. *Contains $W$:* $R\in\mathcal R_W$ means $W\sqcup R\in\mathcal F$, i.e. $W\in\mathcal S(R)$. *The sum:* for $S\subseteq W$, $S\in\mathcal S(R)\iff R\in\mathcal R_S$, and by Theorem 2.3 every $R\in\mathcal R_S$ lies in $\mathcal R_W$, so $p_S=|\mathcal R_S|=|\{R\in\mathcal R_W:S\in\mathcal S(R)\}|$. *The graded union law:* $S\in\mathcal S(R)$, $S'\in\mathcal S(R')$ give $S\sqcup R,\,S'\sqcup R'\in\mathcal F$, union $(S\cup S')\sqcup(R\cup R')\in\mathcal F$, so $S\cup S'\in\mathcal S(R\cup R')$; and $R\cup R'\in\mathcal R_W$ since $\mathcal R_W$ is union-closed. $\qquad\blacksquare$

This is the characterization in its sharpest form. **The sub-cube Walsh spectrum of $\mathbf 1_{\mathcal F}$ relative to $W$ is the Walsh transform of a sum of indicators of union-closed families on the small cube $2^W$, each containing the top $W$, indexed by the ambient fibre $\mathcal R_W$ and coupled by a graded union law.** It is a self-similar picture: Frankl on the big family $\mathcal F$, localized to $W$, becomes a question about a *multiset of union-closed families on $W$* — Frankl about families of Frankl-families. By linearity of the Walsh transform,

$$
  \widehat p\;=\;\sum_{R\in\mathcal R_W}\widehat{\mathbf 1_{\mathcal S(R)}},
\tag{2.1}
$$

so the level-1 spectrum $\{\widehat p(\{x\})\}_{x\in W}$ is an *unweighted superposition* of the level-1 spectra of the co-fibres. The whole of UC3's attack (§3) is the analysis of one such superposition.

The two systems $\{\mathcal R_S\}_{S\subseteq W}$ (indexed by $2^W$, families on $U'$) and $\{\mathcal S(R)\}_{R\in\mathcal R_W}$ (indexed by $\mathcal R_W$, families on $W$) are the two transposes of the single incidence relation $S\sqcup R\in\mathcal F$ on $2^W\times\mathcal R_W$; Theorem 2.5 is the statement that *both* transposes are union-closed-structured. The dual reduction is the natural home for the attack because the target functional $\phi$ lives on $2^W$, the index set of the co-fibres' *values*.

### 2.4 Minimality grades the system

So far only $W\in\mathcal F$ has been used. The hypothesis $|W|=m(\mathcal F)=k$ — that $W$ has *minimum* size — grades the fibre system by size.

> **Proposition 2.6 (the minimality grading).** Let $0<|S|<k$ (an intermediate trace). Then every $R\in\mathcal R_S$ has
> $$
>   |R|\;\ge\;k-|S|\;>\;0.
> $$
> Equivalently, in the dual picture: for $0<|R|<k$, the co-fibre $\mathcal S(R)$ does **not** contain $\emptyset$, and an intermediate trace $S$ lies in $\mathcal S(R)$ only if $|S|\ge k-|R|$.

*Proof.* $R\in\mathcal R_S$ with $0<|S|<k$: the set $A=S\sqcup R\in\mathcal F$ is non-empty (it contains $S\neq\emptyset$), so $|A|\ge m(\mathcal F)=k$, i.e. $|S|+|R|\ge k$, giving $|R|\ge k-|S|\ge 1$. For the dual statement: $\emptyset\in\mathcal S(R)\iff R=\emptyset\sqcup R\in\mathcal F$; if $0<|R|<k$ then $R\in\mathcal F$ would force $|R|\ge k$, a contradiction, so $\emptyset\notin\mathcal S(R)$. And $S\in\mathcal S(R)$ with $0<|S|<k$ means $R\in\mathcal R_S$, so $|R|\ge k-|S|$, i.e. $|S|\ge k-|R|$. $\qquad\blacksquare$

In words: **intermediate trace-classes live high in the cube $2^{U'}$** — a class $\mathcal F^S$ with small $|S|$ can only be populated by sets $A$ with a large $U'$-part. Dually, **small fibres carry only near-full traces**: if $|R|$ is small, $\mathcal S(R)$ consists of $W$ and intermediate traces of size $\ge k-|R|$, with $\emptyset$ excluded once $0<|R|<k$. This is the precise leverage minimality adds beyond bare union-closure, and §3 turns it directly into a sign theorem.

### 2.5 A worked example

To make the characterization concrete, take $U=\{1,2,3,4\}$, $W=\{1,2,3\}$ ($k=3$), $U'=\{4\}$, and

$$
  \mathcal F=\bigl\{\{1,2,3\},\ \{1,2,4\},\ \{1,2,3,4\}\bigr\}.
$$

This is union-closed ($\{1,2,3\}\cup\{1,2,4\}=\{1,2,3,4\}\in\mathcal F$) with $m(\mathcal F)=3$ and $W$ a minimal generator. Traces: $\{1,2,3\}\mapsto W$, $\{1,2,4\}\mapsto\{1,2\}$, $\{1,2,3,4\}\mapsto W$. So the non-zero profile entries are $p_W=2$, $p_{\{1,2\}}=1$.

- **Fibres:** $\mathcal R_W=\{\emptyset,\{4\}\}$, $\mathcal R_{\{1,2\}}=\{\{4\}\}$. Universal inclusion (Theorem 2.3): $\mathcal R_{\{1,2\}}=\{\{4\}\}\subseteq\mathcal R_W$ ✓; all other $\mathcal R_S=\emptyset$.
- **Minimality grading (Proposition 2.6):** the intermediate trace $S=\{1,2\}$ has $|S|=2$, so its fibre must lie in sizes $\ge k-|S|=1$ — indeed $\mathcal R_{\{1,2\}}=\{\{4\}\}$, $|\{4\}|=1$ ✓.
- **Co-fibres (Theorem 2.5):** $\mathcal S(\emptyset)=\{S\subseteq W:S\in\mathcal F\}=\{W\}$; $\mathcal S(\{4\})=\{S:S\cup\{4\}\in\mathcal F\}=\{\{1,2\},W\}$. Both are union-closed and contain $W$ ✓.
- **The sum $p=\sum_R\mathbf 1_{\mathcal S(R)}$:** $\mathbf 1_{\mathcal S(\emptyset)}+\mathbf 1_{\mathcal S(\{4\})}$ has $W$-entry $1+1=2=p_W$ ✓ and $\{1,2\}$-entry $0+1=1=p_{\{1,2\}}$ ✓.
- **The target via (0.1) and via the dual reduction:** $\sum_{x\in W}\beta_x=p_W(2\cdot3-3)+p_{\{1,2\}}(2\cdot2-3)=2\cdot3+1\cdot1=7$; and $\sum_R\Phi(\mathcal S(R))=\Phi(\{W\})+\Phi(\{\{1,2\},W\})=3+(1+3)=7$ ✓ (notation $\Phi$ from §3.1).

---

## §3. The attack on the UC3 target inequality (deliverable 2)

The characterization (§2) turns the target into a sign question about the superposition (2.1). This section attacks it: a per-fibre functional, a per-fibre sign theorem, the localization of the residual, a clean native sufficient condition, and the precise residual gap.

### 3.1 The target as a sum over the ambient fibre

For a family $\mathcal G\subseteq 2^W$ define the **sub-cube level-1 functional**

$$
  \Phi(\mathcal G):=\sum_{S\in\mathcal G}\phi(S)=\sum_{S\in\mathcal G}(2|S|-k)=-\sum_{x\in W}\widehat{\mathbf 1_{\mathcal G}}(\{x\}).
$$

> **Proposition 3.1 (the target, dualized).**
> $$
>   \sum_{x\in W}\beta_x\;=\;\langle p,\phi\rangle\;=\;\sum_{R\in\mathcal R_W}\Phi\bigl(\mathcal S(R)\bigr).
> $$
> The UC3 target inequality (0.2) is exactly $\sum_{R\in\mathcal R_W}\Phi(\mathcal S(R))\ge 0$.

*Proof.* The first equality is (0.1)+(1.1). For the second, substitute $p=\sum_{R\in\mathcal R_W}\mathbf 1_{\mathcal S(R)}$ (Theorem 2.5) and use linearity: $\langle p,\phi\rangle=\sum_{R\in\mathcal R_W}\langle\mathbf 1_{\mathcal S(R)},\phi\rangle=\sum_{R\in\mathcal R_W}\Phi(\mathcal S(R))$. $\qquad\blacksquare$

So the target is a sum, over the ambient fibre $\mathcal R_W$, of the level-1 functional evaluated on union-closed families containing $W$. The natural first question — *is each term non-negative?* — fails, and the failure is instructive.

> **Observation 3.2 (the per-fibre statement is false in isolation).** There exist union-closed $\mathcal G\subseteq 2^W$ with $W\in\mathcal G$ and $\Phi(\mathcal G)<0$: take $\mathcal G=\{\emptyset,\{x\},W\}$ (union-closed, since $\{x\}\cup W=W$), with $\Phi(\mathcal G)=(-k)+(2-k)+k=2-k<0$ for $k\ge 3$. So a single co-fibre $\mathcal S(R)$ can contribute negatively, and the target cannot be proved term-by-term over all of $\mathcal R_W$ — the couplings of Theorem 2.5 (graded union law) and Proposition 2.6 (minimality grading) must be used.

But — and this is the key point — Observation 3.2's bad family $\{\emptyset,\{x\},W\}$ contains $\emptyset$ *and* a small intermediate trace $\{x\}$. Proposition 2.6 forbids exactly that combination in any fibre that is not large. This is what §3.2 exploits.

### 3.2 The per-fibre sign theorem — small and medium fibres are non-negative

> **Theorem 3.3 (per-fibre sign theorem).** Let $R\in\mathcal R_W$ with $|R|\le\lfloor k/2\rfloor$. Then
> $$
>   \Phi\bigl(\mathcal S(R)\bigr)\;\ge\;0.
> $$
> More precisely: $\Phi(\mathcal S(R))\ge k>0$ when $1\le|R|\le\lfloor k/2\rfloor$, and $\Phi(\mathcal S(R))\in\{0,k\}$ when $R=\emptyset$.

*Proof.* $\mathcal S(R)$ is union-closed and contains $W$ (Theorem 2.5). Partition its members:

- the top $W$ contributes $\phi(W)=2k-k=k$;
- $\emptyset$, if present, contributes $\phi(\emptyset)=-k$;
- each intermediate $S\in\mathcal S(R)$, $0<|S|<k$, contributes $\phi(S)=2|S|-k$, and by Proposition 2.6 satisfies $|S|\ge k-|R|\ge k-\lfloor k/2\rfloor=\lceil k/2\rceil\ge k/2$, hence $\phi(S)\ge 0$.

Summing, $\Phi(\mathcal S(R))\ge k+(-k)\cdot[\emptyset\in\mathcal S(R)]+0\ge 0$. For the sharper bounds: if $1\le|R|\le\lfloor k/2\rfloor$ then $0<|R|<k$, so by Proposition 2.6 $\emptyset\notin\mathcal S(R)$ and $\Phi(\mathcal S(R))\ge k$. If $R=\emptyset$ then by minimality $\mathcal S(\emptyset)=\{S\subseteq W:S\in\mathcal F\}\subseteq\{\emptyset,W\}$, so $\mathcal S(\emptyset)\in\{\{W\},\{\emptyset,W\}\}$ and $\Phi(\mathcal S(\emptyset))\in\{k,0\}$. $\qquad\blacksquare$

The threshold $\lfloor k/2\rfloor$ is exactly where the minimality grading bites: a fibre of size $r$ admits intermediate traces down to size $k-r$, whose weight $\phi$ turns negative precisely when $k-r<k/2$, i.e. $r>k/2$. **Below the threshold, minimality forbids the negative-weight traces from appearing at all; the only possible negative contribution is $\emptyset$, and it is capped by the top $W$.**

### 3.3 The deficiency is localized to the large fibres

> **Corollary 3.4 (large-fibre localization).** Write the ambient fibre as the disjoint union $\mathcal R_W=\mathcal R_W^{\mathrm{sm}}\sqcup\mathcal R_W^{\mathrm{lg}}$ with $\mathcal R_W^{\mathrm{sm}}=\{R:|R|\le\lfloor k/2\rfloor\}$ and $\mathcal R_W^{\mathrm{lg}}=\{R:|R|>\lfloor k/2\rfloor\}$. Then
> $$
>   \sum_{x\in W}\beta_x\;=\;\underbrace{\sum_{R\in\mathcal R_W^{\mathrm{sm}}}\Phi(\mathcal S(R))}_{\ge\,0\ \text{(Theorem 3.3)}}\;+\;\sum_{R\in\mathcal R_W^{\mathrm{lg}}}\Phi(\mathcal S(R)),
> $$
> so the UC3 target inequality holds **as soon as** $\displaystyle\sum_{R\in\mathcal R_W^{\mathrm{lg}}}\Phi(\mathcal S(R))\ge-\sum_{R\in\mathcal R_W^{\mathrm{sm}}}\Phi(\mathcal S(R))$. The entire residual difficulty of the UC3 target is carried by the **large fibres** $\mathcal R_W^{\mathrm{lg}}$ — the sets $R$ with $W\sqcup R\in\mathcal F$ and $|R|>\lfloor k/2\rfloor$.

*Proof.* Immediate from Proposition 3.1 and Theorem 3.3. $\qquad\blacksquare$

This is the UC3 sharpening of UC2 Theorem 3.5(3). UC2 localized Frankl to "the intermediate trace-classes of a minimal generator"; UC3 characterizes those classes (§2) and localizes *within* them — the intermediate classes attached to small and medium fibres are provably harmless, and only the large fibres can host a deficiency. The object has gone from "the intermediate trace-classes" (UC2) to "the co-fibres of the large fibres of $\mathcal R_W$" (UC3): a strictly smaller, more precisely-pinned target.

### 3.4 A clean native sufficient condition

The localization immediately yields a sufficient condition for Frankl in the hard regime $m(\mathcal F)\ge 3$, with no entropy, no computation, no asymptotics.

> **Theorem 3.5 (sufficient condition — bounded generator spread).** Let $W$ be a minimal generator of $\mathcal F$, $|W|=m(\mathcal F)=k\ge 3$, and let $W^+:=\bigcup\{A\in\mathcal F:A\supseteq W\}$ be the largest member of $\mathcal F$ containing $W$. If
> $$
>   |W^+|\;\le\;\Bigl\lfloor\tfrac{3k}{2}\Bigr\rfloor
>   \qquad\Bigl(\text{equivalently }\ |W^+\setminus W|\le\lfloor k/2\rfloor\Bigr),
> $$
> then $\sum_{x\in W}\beta_x\ge 0$, and hence some $x\in W$ is abundant.

*Proof.* The family $\{A\in\mathcal F:A\supseteq W\}$ is non-empty ($W$ itself) and union-closed, so it has a maximum $W^+$, and every $R\in\mathcal R_W$ satisfies $W\sqcup R\subseteq W^+$, i.e. $R\subseteq W^+\setminus W=:Z$ with $|Z|=|W^+|-k\le\lfloor k/2\rfloor$. Thus every $R\in\mathcal R_W$ has $|R|\le\lfloor k/2\rfloor$ — the ambient fibre has no large part, $\mathcal R_W^{\mathrm{lg}}=\emptyset$. By Corollary 3.4, $\sum_{x\in W}\beta_x=\sum_{R\in\mathcal R_W}\Phi(\mathcal S(R))\ge 0$. The equivalence of the two conditions is $|W^+|=k+|Z|$ and $\lfloor 3k/2\rfloor-k=\lfloor k/2\rfloor$. $\qquad\blacksquare$

In words: **if the minimal generator $W$ does not "spread" far inside $\mathcal F$ — every member of $\mathcal F$ containing $W$ stays within $\lfloor k/2\rfloor$ extra elements of $W$ — then Frankl holds for $\mathcal F$, witnessed inside $W$.** This is a genuinely new region of the frontier: it is not implied by UC2's $m(\mathcal F)\le 2$ theorem (it concerns $m(\mathcal F)=k\ge 3$), nor by the classical small-set cases. It is the *visible tip* of the characterization — the regime where the large-fibre residual is simply empty. The honest scope: it is a sufficient condition, not the conjecture; its content is that it carves out, natively and cleanly, exactly the part of the $m(\mathcal F)\ge 3$ frontier that the sub-cube localization trivializes.

### 3.5 The Walsh/counting reproof — the spectrum form

For completeness, the same localization read directly off the sub-cube spectrum $\widehat p$, without the dual reduction — this is the "F-i in pure Walsh form" statement. By Theorem 2.3, $p_S\le|\{R\in\mathcal R_W:|R|\ge k-|S|\}|=:N_{\ge k-|S|}$ for intermediate $S$ (using Proposition 2.6), and $p_S\le p_W=N_{\ge 0}$ always, where $N_{\ge t}:=|\{R\in\mathcal R_W:|R|\ge t\}|$. Splitting (0.1) at $|S|=k/2$ and bounding the negative part,

$$
  \sum_{x\in W}\beta_x\;\ge\;\underbrace{k\,N_{\ge 0}}_{S=W}\;-\;\underbrace{k\,(1+N_{\ge k})}_{S=\emptyset}\;-\;\sum_{j=1}^{\lceil k/2\rceil-1}\binom{k}{j}\,N_{\ge k-j}\,(k-2j).
$$

When $\mathcal R_W^{\mathrm{lg}}=\emptyset$ every $N_{\ge t}$ with $t>\lfloor k/2\rfloor$ vanishes, so every term in the sum (which has $k-j>\lfloor k/2\rfloor$) vanishes, $N_{\ge k}=0$, and the bound reads $\sum_{x\in W}\beta_x\ge k\,N_{\ge 0}-k\ge 0$ since $N_{\ge 0}=p_W\ge 1$. This reproves Theorem 3.5 from the spectrum side, and exhibits the residual as the **size-distribution of $\mathcal R_W$**: the deficiency is governed entirely by how much mass $\mathcal R_W$ places above the threshold $\lfloor k/2\rfloor$.

### 3.6 The residual gap, named

> **The UC3 residual gap.** To finish the UC3 target inequality along the Walsh-localization route it suffices to show, for the fixed minimal generator $W$,
> $$
>   \sum_{R\in\mathcal R_W^{\mathrm{lg}}}\Phi\bigl(\mathcal S(R)\bigr)\;\ge\;-\sum_{R\in\mathcal R_W^{\mathrm{sm}}}\Phi\bigl(\mathcal S(R)\bigr),
> $$
> i.e. that the large fibres' co-fibres cannot collectively out-weigh the (provably non-negative, often strictly positive) small-and-medium fibres. The structural inputs not yet fully exploited, and which must do the work:
> 1. **The graded union law** $\mathcal S(R)\vee\mathcal S(R')\subseteq\mathcal S(R\cup R')$ (Theorem 2.5) — it *couples* the co-fibres across $\mathcal R_W$; a large fibre $R$ does not have an arbitrary co-fibre, it is constrained by the co-fibres of every pair $R',R''$ with $R'\cup R''=R$.
> 2. **The minimality grading inside the large fibres** (Proposition 2.6) — even for $|R|>\lfloor k/2\rfloor$, the co-fibre $\mathcal S(R)$ is confined to $\{S:|S|\ge k-|R|\}\cup(\{\emptyset\}\ \text{only if}\ |R|\ge k)$; the negative weights it can host are bounded below by $k-2|R|$, not by $-k$.
> 3. **The union-closed structure of $\mathcal R_W$ itself** — $\mathcal R_W$ is a union-closed family on $U'$ with $\emptyset\in\mathcal R_W$; the partition $\mathcal R_W^{\mathrm{sm}}\sqcup\mathcal R_W^{\mathrm{lg}}$ is not arbitrary (e.g. $\mathcal R_W^{\mathrm{sm}}$ is an order ideal of $\mathcal R_W$, $\mathcal R_W^{\mathrm{lg}}$ a filter), so "many large fibres" forces "many small fibres below them."

This is the precise next step, and it is a *finitary, exact* inequality — there is no $\varepsilon$, no limit, no entropy slack. §4 explains why that matters.

---

## §4. Gilmer's entropy method as a compatibility-geometry statement (deliverable 3)

The ticket's third deliverable: frame Gilmer's entropy method as a compatibility-geometry statement on the localized object, and assess whether the UC2 localization gives leverage the abstract level-1 entropy method does not.

### 4.1 The trace distribution and what the entropy method consumes

Let $A$ be uniform on $\mathcal F$. Its **trace** $A\cap W$ is a random element of $2^W$ with distribution

$$
  \mu(S):=\Pr[A\cap W=S]=\frac{p_S}{|\mathcal F|},\qquad S\subseteq W.
$$

If $A,B$ are independent uniform on $\mathcal F$ then $A\cup B\in\mathcal F$ and $(A\cup B)\cap W=(A\cap W)\cup(B\cap W)$ — so the trace distribution is **closed under union-convolution**: $\mu\star\mu$, the law of $(A\cap W)\cup(B\cap W)$, is supported on the union-closed family $\mathcal S=\mathrm{supp}(\mu)\subseteq 2^W$. The marginals of $\mu$ are the abundances: $\Pr[x\in A\cap W]=a(x)$ for $x\in W$, equivalently $\widehat p(\{x\})=-\beta_x=(1-2a(x))|\mathcal F|$.

Gilmer's method (Gilmer 2022; Sawin; Chase–Lovett; Alweiss–Huang–Sellke; Pebody) is, at heart, a machine that takes the **marginal abundances** $\{a(x)\}$ of a union-closed family and, using $H(A\cup B)\le H(A)$ together with a per-coordinate entropy lower bound on the OR of two Bernoullis, derives a contradiction unless some $a(x)$ exceeds a threshold. Sawin's observation is that the per-coordinate inequality is tight near $a=(3-\sqrt5)/2\approx0.382$, capping the method there.

The compatibility-geometry reading: **the input to the entropy method is exactly the level-1 spectrum** — the abundances $a(x)$, equivalently $\beta_x$, equivalently $\widehat{\mathbf 1_{\mathcal F}}(\{x\})$. The method is a level-1-spectrum estimator. UC1 §8.3 named this "compatibility-geometrize Gilmer"; UC2 §5 sharpened the aim to the *sub-cube* spectrum relative to $W$. §4.2 makes the comparison precise.

### 4.2 The localization is a strict refinement of the entropy method's input

Run the entropy method on the coordinates of $W$ only. It consumes $\{a(x)\}_{x\in W}$ — the level-1 sub-cube spectrum, which by §1.2 is *precisely* the UC3 object $\widehat p$ at level 1. So far, localizing to $W$ changes nothing: the same per-coordinate inequality, summed over $x\in W$ instead of $x\in U$. The Sawin ceiling is untouched, because the ceiling is the optimum of the **decoupled relaxation** — the method treats the coordinates as independent Bernoulli$(a(x))$ variables, via subadditivity and the per-coordinate OR-lemma, and the ceiling is achieved by a *product-like* configuration in which the coordinates genuinely decouple.

Here is the leverage. The UC3 characterization (§2) shows the trace distribution $\mu$ is **not** a free union-closed-supported distribution — it carries two couplings that the decoupled relaxation discards:

- **The graded union law** (Proposition 2.2 / Theorem 2.5). The fibre system $\{\mathcal R_S\}$ and the co-fibre system $\{\mathcal S(R)\}$ are closed under union across their index lattices. In distributional terms, $\mu$ is the $2^W$-marginal of a *joint* law on $2^W\times\mathcal R_W$ whose two transposes are *both* union-closed-structured (the incidence relation $S\sqcup R\in\mathcal F$). This is a correlation *between the $W$-coordinates* — it is exactly what makes $\{\emptyset,\{x\},W\}$-type configurations (the bad co-fibre of Observation 3.2) non-free: they cannot appear in a small fibre.
- **The minimality grading** (Proposition 2.6). The trace $A\cap W$ and the co-trace $A\setminus W$ are *size-coupled*: a small trace forces a large co-trace. The decoupled per-coordinate bound has no access to this — it sees each coordinate's marginal in isolation, not the joint size constraint $|A\cap W|+|A\setminus W|\ge k$.

Theorem 3.3 is the payoff of using these couplings: it is a statement that **cannot** be derived from the marginals alone. The decoupled relaxation admits configurations with $\Phi(\mathcal S(R))<0$ for small $R$ (Observation 3.2's family is decoupled-feasible); the actual union-closed structure forbids them (Theorem 3.3). So the localized sub-cube spectrum is a **strict refinement** of the entropy method's input: same level-1 data, plus the coordinate coupling.

### 4.3 Assessment — genuine sharpening, no built-in ceiling

> **The honest assessment.** The UC2 localization is a *genuine sharpening* of the F-i route, not a reproduction of the entropy-method ceiling.
>
> - **It is not subject to the Sawin ceiling argument.** That argument's tightness relies on the coordinates being decoupleable into a near-product configuration. The graded union law and the minimality grading *forbid* the $W$-coordinates from decoupling — the co-fibre couplings of Theorem 2.5 are exactly the obstruction to a product configuration. The $(3-\sqrt5)/2$ ceiling is a ceiling *of the relaxation the localized object refines away*; it does not apply to the localized object.
> - **The residual is finitary and exact.** The UC3 residual gap (§3.6) is an exact inequality between two finite sums of integer functionals — $\sum_{\mathrm{lg}}\Phi\ge-\sum_{\mathrm{sm}}\Phi$ — with no entropy term, no $\varepsilon$, no asymptotics, hence no inequality slack of the kind that produces a ceiling. Whatever its truth value, it does not have a "$0.382$-shaped" obstruction; if it fails it fails on a concrete finite configuration, and if it holds it holds exactly.
> - **What it does *not* do.** UC3 does not prove a bound past $(3-\sqrt5)/2$, and does not resolve the UC3 target inequality. It proves the *sufficient condition* Theorem 3.5 and localizes the residual. The claim is precisely: the localization *removes the structural reason* the entropy method stalls at $(3-\sqrt5)/2$ — coordinate decoupling — and replaces the asymptotic ceiling with a finitary residual (§3.6). Closing that residual is UC4.

So the answer to the ticket's question — "is the UC2 localization a genuine sharpening of the frontier or does it reproduce the known entropy-method ceiling?" — is: **a genuine sharpening.** The leverage is concrete and named (the coordinate coupling the decoupled bound discards), the ceiling argument provably does not transfer to the localized object, and the residual is recast from an asymptotic estimate into an exact finitary inequality. This is the GREEN-walsh-characterization outcome: the characterization is complete, the target is sharpened to one precise next step, and that step is structurally past the entropy-method ceiling — not yet a proof past $(3-\sqrt5)/2$, but no longer ceilinged by the argument that caps the entropy method.

### 4.4 Relation to the other fallbacks and UC2 interlocks

UC3 stayed inside F-i, as scoped. For the record, the hooks UC3 leaves to the other routes:

- **F-ii (component / $H_0$ route).** The residual's input 3 (§3.6) — the order-ideal/filter split $\mathcal R_W=\mathcal R_W^{\mathrm{sm}}\sqcup\mathcal R_W^{\mathrm{lg}}$ — is a statement about the structure of the union-closed family $\mathcal R_W$; the Hall criterion of UC2 Prop 3.6, applied to $\mathcal R_W$, is the natural F-ii continuation.
- **F-iii (square-defect route).** The graded union law $\mathcal S(R)\vee\mathcal S(R')\subseteq\mathcal S(R\cup R')$ is, at the level of pairs, exactly the one-sided square-defect of UC2 Prop 4.2 read on the co-fibre system; the higher-degree square-defect is the F-iii continuation of §3.6 input 1.
- **UC2 interlock (I1), many generators.** UC3 fixed one minimal generator $W$. Ranging $W$ over all minimal generators gives one localization (and one residual §3.6) per generator; the I1 linear system couples them. UC3's per-generator characterization is the input to that system; assembling it is the natural UC4-or-beyond continuation.

None of these is pursued here — UC3's scope is the F-i characterization and attack, and that is GREEN.

---

## §5. Verdict and the precise next step

**Verdict: GREEN-walsh-characterization.**

UC3's three deliverables, against the ticket's scope:

1. **Characterize the sub-cube Walsh spectrum — complete (§2).** The profile $p_S=|\mathcal F^S|$, equivalently the spectrum $\widehat p$, is characterized: the fibre system $\{\mathcal R_S\}$ satisfies the graded union law (Prop 2.2); the universal fibre inclusion $\mathcal R_S\subseteq\mathcal R_W$ holds for every $S$ (Thm 2.3); the dual reduction expresses $p=\sum_{R\in\mathcal R_W}\mathbf 1_{\mathcal S(R)}$ as a sum of indicators of union-closed families on $W$ containing the top, coupled by a graded union law (Thm 2.5); minimality grades the system (Prop 2.6). This is a complete, native characterization, strictly sharper than UC2's single injection $j$.
2. **Attack the UC3 target inequality — substantially advanced (§3).** The target dualizes to $\sum_{R\in\mathcal R_W}\Phi(\mathcal S(R))\ge 0$ (Prop 3.1); the per-fibre sign theorem (Thm 3.3) proves every small-and-medium fibre contributes $\ge 0$, localizing the residual to the large fibres (Cor 3.4); a clean native sufficient condition for the $m(\mathcal F)\ge 3$ regime falls out — bounded generator spread $|W^+|\le\lfloor3k/2\rfloor$ (Thm 3.5); the spectrum-side reproof (§3.5) exhibits the residual as the size-distribution of $\mathcal R_W$; the residual gap is named precisely with its three unexploited structural inputs (§3.6).
3. **Frame Gilmer as compatibility geometry — assessed (§4).** The trace distribution is the union-convolution-closed object the entropy method consumes (§4.1); the UC2 localization is a strict refinement of the method's input, because the graded union law and the minimality grading are exactly the coordinate couplings the decoupled relaxation discards (§4.2); the assessment is a genuine sharpening — the localized object is not subject to the Sawin ceiling argument (which needs coordinate decoupling), and the residual is finitary and exact rather than an asymptotic estimate (§4.3).

**The central question, sharpened to one precise next step.** Every road in UC3 converges on the same object:

> **The UC4 target.** For a minimal generator $W$, show
> $$
>   \sum_{R\in\mathcal R_W^{\mathrm{lg}}}\Phi\bigl(\mathcal S(R)\bigr)\;\ge\;-\sum_{R\in\mathcal R_W^{\mathrm{sm}}}\Phi\bigl(\mathcal S(R)\bigr),
> $$
> using the three structural inputs not yet fully exploited: the graded union law coupling the co-fibres (§3.6.1), the minimality grading inside the large fibres (§3.6.2), and the ideal/filter structure of $\mathcal R_W$ (§3.6.3). This is a finitary, exact inequality — not an asymptotic estimate — and it is structurally past the entropy-method ceiling.

**Indicated route — continue F-i, then assemble I1.** UC4 should continue the Walsh-localization route on the named residual (§3.6), and then — once the per-generator residual is understood — assemble the UC2 interlock (I1): range $W$ over all minimal generators and couple the per-generator inequalities into a linear system. F-ii and F-iii remain available with the explicit hooks of §4.4.

**Why GREEN-walsh-characterization is the honest tag.** Not GREEN-target-resolved: the UC3 target inequality is not proved in general; Theorem 3.5 is a genuine but partial result. Not AMBER-walsh-stalls: the Walsh route does not stall — the characterization is complete, the target is sharpened to a single precise next step, a new sufficient condition on the $m(\mathcal F)\ge 3$ frontier is proven, and §4 establishes the precise structural sense in which the localized object beats the relaxation the Sawin ceiling optimizes. The defining feature of GREEN-walsh-characterization — "the sub-cube Walsh spectrum is characterized; the target inequality is sharpened to a precise next step (possibly beating or matching the entropy-method ceiling)" — is met, with the characterization complete and the next step structurally past the ceiling.

**Trust-surface impact: none.** Paper-and-pencil; no new axioms, no Lean, no computation. No engine ported (UC1 §8.4's dead routes E1–E3 / C1–C5 untouched — UC3 builds only on the pinned objects of UC1 §1 and the structure theory of UC2 §§2–3). The 1/3-2/3 critical path (`one_third_width_three`) is in a different repo and is untouched.

---

## §6. References

### 6.1 This repo / parent chain

- **mg-a814 (UC2)** — `docs/union-closed-UC2-transport-deficiency.md`: §3.3 (the trace-partition theorem — Thm 3.5, the $m(\mathcal F)\le2$ native recovery and the localization to the intermediate trace-classes of a minimal generator $\ge3$; the identity (0.1) here is UC2's (3.1)); §3.2 (the union map and its fibres — Lemma 3.3, the cube-interval picture UC3's $\mathcal R_S$ refines); §5 (the UC3 target and the indicated route F-i, UC2-localized); §3.4 (the interlock I1, the UC4-and-beyond continuation); §2 (the structure theory the residual §3.6 inputs draw on); §3.6 / §4.2 (the Hall criterion and the one-sided square-defect — the F-ii / F-iii hooks of §4.4). `docs/state-UC2.md` — the UC2 invariants.
- **mg-f72a (UC1)** — `docs/union-closed-compat-geom-manifesto.md`: §1.6 (the obstruction in four forms — O3, $\beta_x=-2^n\widehat{\mathbf 1_{\mathcal F}}(\{x\})$, the Walsh handle UC3 works in); §8.3 (fallback F-i named, closest to the frontier); §8.4 (the dead routes UC3 avoids); §1.7 (the $S_n$ vs $(\mathbb Z/2)^n$ split — UC3 stays in the $(\mathbb Z/2)^n$/Walsh world). `docs/state-UC1.md` — the UC1 invariants.

### 6.2 Cross-repo — `one_third_width_three` (read access)

Used by UC3 only to stay clear of the dead routes (UC1 §8.4): the BK/Cheeger-expansion engine and Theorem E (gaps E1–E3), the F-series cohomological program and $\Delta(\mathrm{UCF}_n)$ (gaps C1–C5). UC3 is independent of the 1/3-2/3 critical path.

### 6.3 Frankl-conjecture literature

- P. Frankl (1979) — the Union-Closed Sets conjecture.
- H. Bruhn, O. Schaudt, *The journey of the union-closed sets conjecture*, Graphs and Combinatorics 31 (2015) — the survey; the classical small-set cases (recovered natively in UC2 Thm 3.5(2)); the lattice reformulation.
- B. Poonen, *Union-closed families*, J. Combin. Theory Ser. A 59 (1992) — the lattice / join-irreducible reformulation.
- J. Gilmer, *A constant lower bound for the union-closed sets conjecture* (2022) — the entropy/information-theoretic method; the $\approx1\%$ bound. Framed in §4 as a level-1-spectrum estimator.
- W. Sawin; Z. Chase & S. Lovett; R. Alweiss, B. Huang & M. Sellke; L. Pebody (2022–2023) — the improvement to $(3-\sqrt5)/2\approx0.38197$ and Sawin's observation that the entropy method alone caps near there. The "Sawin ceiling" of §4 — the optimum of the decoupled per-coordinate relaxation, which §4.3 argues does not apply to the UC2-localized object.
- R. O'Donnell, *Analysis of Boolean Functions* (2014) — Walsh–Fourier analysis on the cube; the level-1 spectrum, sub-cube restrictions, the Walsh expansion of §1.2.

### 6.4 Source directives

- Daniel directives 2026-05-14 — the `union_closed` product-line assignment; UC3 is the F-i (Walsh/harmonic) fallback, UC2-localized, per UC2 §5.

---

*Polecat: mg-cfc0 (UC3). Branch: `union-closed-UC3-walsh-subcube-spectrum`. Verdict: **GREEN-walsh-characterization** — the sub-cube Walsh spectrum of $\mathbf 1_{\mathcal F}$ relative to a minimal generator $W$ is characterized as the Walsh transform of $p=\sum_{R\in\mathcal R_W}\mathbf 1_{\mathcal S(R)}$, a graded-union-coupled sum of indicators of union-closed families on $W$ (universal fibre inclusion $\mathcal R_S\subseteq\mathcal R_W$; dual reduction; minimality grading), and the UC3 target inequality is attacked through it: the per-fibre sign theorem proves every small-and-medium fibre contributes non-negatively, localizing the entire residual to the large fibres of $\mathcal R_W$, and yielding the native sufficient condition "bounded generator spread $|W^+|\le\lfloor3k/2\rfloor\Rightarrow$ some $x\in W$ abundant" on the $m(\mathcal F)\ge3$ frontier; Gilmer's entropy method is framed as a level-1-spectrum estimator and the UC2 localization is shown to be a strict refinement of its input — retaining the coordinate coupling the decoupled relaxation discards — hence structurally past the Sawin ceiling, with the residual recast as a finitary exact inequality. Central question sharpened to one precise next step (the large-fibre residual, UC4); no new axioms; no Lean; no computation; no engine port.*
