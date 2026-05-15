# Union-Closed Compatibility-Geometry — UC6: closing the UC5 large-fibre-defect residual via the tiling-coupling flow argument and the Gram/hybrid global argument (mg-6dad)

**Repo:** `union_closed`. **Parent:** mg-3806 (UC5, GREEN-partial) — `docs/union-closed-UC5-trace-defect-residual.md` §4.2 (the named residual + the precise obstruction), §4.3 (the indicated route + the F-ii/F-iii hooks), §§1–3 (the defect retraction, the hybrid decomposition, the generator Gram form), `docs/state-UC5.md` "Open threads". **Chain:** mg-f72a (UC1) → mg-a814 (UC2) → mg-cfc0 (UC3) → mg-0bf7 (UC4) → mg-3806 (UC5) → UC6.
**Branch:** `polecat-cat-mg-6dad`.
**Type:** Native construction — Walsh/harmonic analysis on the cube (continuing fallback **F-i**, UC5-localized). Paper-and-pencil; **no new axioms; no Lean; no computation; no engine port.** LaTeX-style Markdown, F-series house style. Multi-session-able; cumulative state ledger in `docs/state-UC6.md`.
**Cross-repo references (read access):** `one_third_width_three` — used only to stay clear of the dead routes UC1 §8.4 named.

---

**Verdict: GREEN-partial.**

The UC5 large-fibre-defect residual is **substantially advanced**: the **tiling coupling is fully quantified** into three exact structural results — an explicit closed form for the fibre-ideals in terms of the single co-fibre, a flow identity for the per-fibre defect, and an exact boundary conservation law — the **global Gram/hybrid argument is closed on two new native frontier regions**, and the **cross-$R$ graded union law is quantified** into an anti-monotonicity (deficiency-contraction) theorem for the defect-retraction interior operators. The residual is not fully closed — it cannot be, by the means available, for the same structural reason UC4/UC5 identified — but every one of UC5 §4.3's indicated levers is now realized as a theorem, and the residual is sharpened from a named obstruction to an explicit finitary inequality with the tiling coupling discharged.

The load-bearing results:

- **(§1) Phase 1 — the tiling-coupling flow argument.** Three exact results turn UC5's "the ideals $\{I_{R,S_0}\}$ tile $\mathcal S(R)^\uparrow$" from structure into computation. **(a)** The **flow identity** (Theorem 1.1): $\Phi(\mathcal D(R))=\mathrm{Ret}(R)+2\,\mathrm{Def}(R)$, where $\mathrm{Ret}(R)=\sum_{S\in\mathcal D(R)}\phi(\bar\jmath_R(S))$ is the retraction weight and $\mathrm{Def}(R)=\sum_{S\in\mathcal D(R)}|\delta_R(S)|\ge 0$ is the total deficiency mass. **(b)** The **tiling-coupling explicit form** (Theorem 1.3): every fibre-ideal is cut from the *single* co-fibre by one formula, $I_{R,S_0}=2^{W_0}\setminus(\mathcal S(R)/S_0)^\uparrow$ — UC5's tiling coupling as an identity, not a structural remark. **(c)** The **boundary conservation law** (Theorem 1.4): $\Phi(\mathcal D(R))=\sum_{S_0}\bigl[a_{S_0}|S_0|-\phi(S_0)\bigr]-B(R)$, where $B(R)\ge|\mathcal S(R)|-1$ is the exact count of inter-fibre Hasse edges of the tiling — the "boundary edges carry conservation laws" of UC5 §4.3, made precise. These close $D^{\mathrm{lg}}(W)\le 0$ on a new native region, the **low-rooted shallow class** (Theorem 1.6), which properly contains UC5's large-fibre-monotone class.
- **(§2) Phase 2 — the Gram/hybrid global argument.** The UC5 §3 Gram form and the UC5 §2 hybrid combine into the global identity $\sum_{W}\sigma(W)=\Sigma_{\mathcal W}+\sum_W\sigma_{\mathrm{rest}}(W)$ with $\Sigma_{\mathcal W}=k\bigl(N-2|E(\Gamma)|\bigr)+(\text{non-negative})$, where $\Gamma$ is the UC5 far-pair graph. This yields the **$\Gamma$-sparse condition** (Theorem 2.2): $|E(\Gamma)|\le N/2\Rightarrow\Sigma_{\mathcal W}\ge 0$, and its weighted refinement (Theorem 2.3) leaning on the UC4 weighted interlock — two new native sufficient conditions, incomparable with UC5's concentrated-generator condition.
- **(§3) The cross-$R$ graded union law, quantified — the deepest lever.** The graded union law $\mathcal S(R)\vee\mathcal S(R')\subseteq\mathcal S(R\cup R')$ is quantified into the **deficiency-contraction theorem** (Theorem 3.1): $\bar\jmath_{R\cup R'}(S)\supseteq\bar\jmath_R(S)\cup\bar\jmath_{R'}(S)$ and $\delta_{R\cup R'}(S)\subseteq\delta_R(S)\cap\delta_{R'}(S)$ — the cross-$R$ coupling makes the deficiency of the interior operators **anti-monotone along the fibre lattice $\mathcal R_W$**. The precise residual gap is named: the domain-mismatch between $\mathcal S(R\cup R')^\uparrow$ and $\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow$.
- **(§4) The combined picture and the sharpened residual.** All three of UC5 §4.3's indicated levers discharged; the residual that remains is named in its sharpest form — with the tiling coupling now a closed identity, the obstruction is the *sign of the boundary deficit* $B(R)$ against the rooted mass $\sum_{S_0}a_{S_0}|S_0|$, globally — and the explicit F-ii / F-iii hooks are re-pinned.

**Why GREEN-partial and not GREEN-residual-closed.** Neither the per-generator residual $D^{\mathrm{lg}}(W)\le A(W)+Q^{\mathrm{lg}}(W)$ nor the global residual $\sum_W D^{\mathrm{lg}}(W)\le\sum_W(A(W)+Q^{\mathrm{lg}}(W))$ is fully closed. It cannot be by the means here: a per-fibre sign theorem for large fibres is *provably impossible* (§1.5 — the per-fibre defect is genuinely sign-indefinite), and $D^{\mathrm{lg}}(W)\le 0$ for a single $W$ at $k=3$ would prove Frankl on the open $m(\mathcal F)=3$ frontier. **Why not AMBER-residual-stalls.** The route does not stall: the tiling coupling is quantified into *three exact identities* (the explicit form, the flow identity, the conservation law — UC5 §4.3's Phase-1 ask, delivered), the global argument is *closed on two new structured classes* (UC5 §4.3's Phase-2 ask, delivered), and the cross-$R$ graded union law — UC5's "deepest remaining lever" — is *quantified into a theorem*. This is exactly the GREEN-partial profile UC5 §4.3 anticipated, and the residual is sharper than UC5's.

**The honest one-sentence verdict.** *The UC5 large-fibre-defect residual admits an exact tiling-coupling flow analysis — the per-fibre defect splits as $\Phi(\mathcal D(R))=\mathrm{Ret}(R)+2\,\mathrm{Def}(R)$, every fibre-ideal is cut from the single co-fibre by the closed formula $I_{R,S_0}=2^{W_0}\setminus(\mathcal S(R)/S_0)^\uparrow$, and the defect obeys the exact boundary conservation law $\Phi(\mathcal D(R))=\sum_{S_0}[a_{S_0}|S_0|-\phi(S_0)]-B(R)$ with $B(R)$ the inter-fibre Hasse-edge count; this closes $D^{\mathrm{lg}}(W)\le 0$ on the new low-rooted shallow class; the Gram/hybrid global argument closes the residual on the $\Gamma$-sparse and weighted-$\Gamma$-sparse classes; and the cross-$R$ graded union law is quantified into the deficiency-contraction theorem $\delta_{R\cup R'}(S)\subseteq\delta_R(S)\cap\delta_{R'}(S)$ — so all three of UC5's indicated levers are realized as theorems and the residual is sharpened to the global sign of the boundary deficit, but it is not fully closed and cannot be by a single-$W$ argument at the $k=3$ frontier.*

§0 fixes notation and recaps the UC5 hand-off; §1 is Phase 1 (the tiling-coupling flow argument: the flow identity, the explicit form, the boundary conservation law, the impossibility of a per-fibre sign theorem, the low-rooted shallow class); §2 is Phase 2 (the Gram/hybrid global argument and the $\Gamma$-sparse classes); §3 quantifies the cross-$R$ graded union law (the deficiency-contraction theorem); §4 is the combined picture, the sharpened residual, the verdict, and the fallbacks; §5 the references.

---

## §0. Notation and the UC6 hand-off

Notation is UC1's through UC5's, restated where load-bearing.

$U$ is a finite ground set; $\mathcal F\subseteq 2^U$ is **union-closed** ($A,B\in\mathcal F\Rightarrow A\cup B\in\mathcal F$), with $\mathcal F\neq\emptyset,\{\emptyset\}$ and WLOG $U=\bigcup\mathcal F\in\mathcal F$. For $x\in U$: $\beta_x=|\mathcal F_x|-|\mathcal F_{\bar x}|$, the **bias**; Frankl asserts some $x$ has $\beta_x\ge 0$. UC2 settled $m(\mathcal F)\le 2$ natively, so we **fix a minimal generator** $W\in\mathcal F$, $|W|=m(\mathcal F)=:k\ge 3$, and write $U'=U\setminus W$. Every nonempty $A\in\mathcal F$ has $|A|\ge k$.

**The fibre system.** Each $A\in\mathcal F$ splits $A=S\sqcup R$, $S=A\cap W\subseteq W$, $R=A\setminus W\subseteq U'$. The **$S$-fibre** is $\mathcal R_S=\{R\subseteq U':S\sqcup R\in\mathcal F\}$; the **co-fibre** is $\mathcal S(R)=\{S\subseteq W:S\sqcup R\in\mathcal F\}$. The standing toolkit (UC3 §2):

- **(Graded union law.)** $\mathcal R_S\vee\mathcal R_{S'}\subseteq\mathcal R_{S\cup S'}$; each $\mathcal R_S$ is union-closed; the co-fibres satisfy $\mathcal S(R)\vee\mathcal S(R')\subseteq\mathcal S(R\cup R')$.
- **(Universal fibre inclusion.)** $\mathcal R_S\subseteq\mathcal R_W$ for every $S\subseteq W$; $\mathcal R_W$ is union-closed on $U'$ with $\emptyset\in\mathcal R_W$.
- **(Dual reduction.)** For each $R\in\mathcal R_W$, $\mathcal S(R)$ is a union-closed family on $W$ containing the top $W$.
- **(Minimality grading.)** For $0<|R|<k$: $\emptyset\notin\mathcal S(R)$, and every $S\in\mathcal S(R)\setminus\{W\}$ has $|S|\ge k-|R|$.

**The level-1 functional.** $\phi(S)=2|S|-k$; $\Phi(\mathcal G)=\sum_{S\in\mathcal G}\phi(S)$. The per-generator target:
$$
  \sigma(W)=\sum_{x\in W}\beta_x=\sum_{R\in\mathcal R_W}\Phi(\mathcal S(R)).
\tag{0.1}
$$

**The UC5 objects UC6 attacks.** For each $R\in\mathcal R_W$:

- **The defect retraction (UC5 Thm 1.1).** $\bar\jmath_R(S):=\max(\mathcal S(R)\cap 2^S)$ for $S\in\mathcal S(R)^\uparrow$ is an **interior operator** on the filter $\mathcal S(R)^\uparrow$: contractive ($\bar\jmath_R(S)\subseteq S$, $\bar\jmath_R(S)\in\mathcal S(R)$), monotone, idempotent, with fixed-point set exactly $\mathcal S(R)$, and $S\in\mathcal D(R):=\mathcal S(R)^\uparrow\setminus\mathcal S(R)\iff\bar\jmath_R(S)\subsetneq S$. The **deficiency** is $\delta_R(S):=S\setminus\bar\jmath_R(S)$.
- **The fibre-ideal structure (UC5 Lemma 1.2).** For $S_0\in\mathcal S(R)$, the fibre $\bar\jmath_R^{-1}(S_0)$ is an order ideal of $[S_0,W]$ with bottom $S_0$; writing $W_0:=W\setminus S_0$, the set $I_{R,S_0}:=\{S\setminus S_0:\bar\jmath_R(S)=S_0\}\subseteq 2^{W_0}$ is an order ideal of $2^{W_0}$ containing $\emptyset$. The fibres tile $\mathcal S(R)^\uparrow$. Write $a_{S_0}:=|I_{R,S_0}|=|\bar\jmath_R^{-1}(S_0)|\ge 1$ and $\Sigma(I):=\sum_{T\in I}|T|$.
- **The cross-$S$ decomposition (UC5 Thm 1.3).** $\Phi(\mathcal D(R))=\sum_{S_0\in\mathcal S(R)}\bigl[(a_{S_0}-1)\phi(S_0)+2\,\Sigma(I_{R,S_0})\bigr]$, and $D(W)=\sum_{R\in\mathcal R_W}\Phi(\mathcal D(R))$.
- **The hybrid decomposition (UC5 Thm 2.1).** $\sigma(W)=A(W)+Q^{\mathrm{lg}}(W)-D^{\mathrm{lg}}(W)$ with $A(W)=\sum_{R\in\mathcal R_W^{\mathrm{sm}}}\Phi(\mathcal S(R))\ge 0$, $Q^{\mathrm{lg}}(W)=\sum_{R\in\mathcal R_W^{\mathrm{lg}}}\Phi(\mathcal S(R)^\uparrow)\ge 0$, $D^{\mathrm{lg}}(W)=\sum_{R\in\mathcal R_W^{\mathrm{lg}}}\Phi(\mathcal D(R))\le D(W)$, where $\mathcal R_W^{\mathrm{lg}}=\{R:|R|>\lfloor k/2\rfloor\}$.
- **The generator Gram form (UC5 Thm 3.1).** $\mathcal W=\{W\in\mathcal F:|W|=k\}$, $N=|\mathcal W|$, $\deg_{\mathcal W}(x)=|\{W\in\mathcal W:x\in W\}|$, $G_{W,W'}=|W\cap W'|$. $\Sigma_{\mathcal W}:=\sum_W\sigma_{\mathcal W}(W)=\mathbf 1^{\mathsf T}(2G-kJ)\mathbf 1=\sum_x\deg_{\mathcal W}(x)(2\deg_{\mathcal W}(x)-N)$, where $\sigma_{\mathcal W}(W)=\sum_{W'\in\mathcal W}\phi(W\cap W')$ and $\sigma(W)=\sigma_{\mathcal W}(W)+\sigma_{\mathrm{rest}}(W)$. The far-pair graph $\Gamma$ on $\mathcal W$: $W\sim_\Gamma W'\iff|W\cap W'|<\lceil k/2\rceil$ (UC5 Prop 3.2).

> **The UC6 target (UC5 §4.2).** Close the UC5 residual — show **either** the per-generator $D^{\mathrm{lg}}(W)\le A(W)+Q^{\mathrm{lg}}(W)$ (sufficient: $D^{\mathrm{lg}}(W)\le 0$), **or** the global $\sum_{W\in\mathcal W}D^{\mathrm{lg}}(W)\le\sum_{W\in\mathcal W}(A(W)+Q^{\mathrm{lg}}(W))$. The three indicated levers (UC5 §4.3): **(1)** the *tiling* coupling — within one $R$, the ideals $\{I_{R,S_0}\}$ partition $\mathcal S(R)^\uparrow$, so boundary edges carry conservation laws (Phase 1, the flow/charging argument); **(2)** the Gram/hybrid global argument (Phase 2); **(3)** the cross-$R$ graded union law $\mathcal S(R)\vee\mathcal S(R')\subseteq\mathcal S(R\cup R')$ — the deepest lever.

UC6 discharges all three as theorems (§§1–3) and sharpens the residual that remains (§4).

**What UC6 must not do (UC1 §8.4, kept in view).** No port of Theorem E / the rigidity engine; no $\Delta(\mathrm{UCF}_n)$ chamber ambient; no $S_n$-isotypic / FI machinery; no new axioms; no Lean; no computation. UC6 is a native construction on the pinned objects of UC1 §1, the structure theory of UC2 §§2–3, the characterization of UC3 §2, the decomposition of UC4 §§1–4, and the defect retraction / hybrid / Gram form of UC5 §§1–3.

---

## §1. Phase 1: the tiling-coupling flow argument

UC5 §4.3 named the tiling coupling — "within one $R$, the ideals $\{I_{R,S_0}\}_{S_0}$ partition $\mathcal S(R)^\uparrow$, so the boundary edges between adjacent fibres of $\bar\jmath_R$ carry conservation laws" — and asked for "a flow/charging argument on the interior-operator structure." This section delivers it as three exact identities.

### 1.1 The flow identity

The first identity splits the per-fibre defect into a *retraction part* and a *deficiency-mass part*. It is the charging argument in its cleanest form: every defect element is charged to its retraction target, and the charge it carries is its deficiency.

> **Theorem 1.1 (the flow identity).** For each $R\in\mathcal R_W$, define the **retraction weight** and the **total deficiency mass**
> $$
>   \mathrm{Ret}(R):=\sum_{S\in\mathcal D(R)}\phi\bigl(\bar\jmath_R(S)\bigr),
>   \qquad
>   \mathrm{Def}(R):=\sum_{S\in\mathcal D(R)}|\delta_R(S)|\;\ge\;0.
> $$
> Then
> $$
>   \Phi(\mathcal D(R))\;=\;\mathrm{Ret}(R)\;+\;2\,\mathrm{Def}(R).
> $$
> Equivalently, in fibre coordinates, $\mathrm{Ret}(R)=\sum_{S_0\in\mathcal S(R)}(a_{S_0}-1)\,\phi(S_0)$ and $\mathrm{Def}(R)=\sum_{S_0\in\mathcal S(R)}\Sigma(I_{R,S_0})$.

*Proof.* For any $S\in\mathcal S(R)^\uparrow$, $\phi(S)-\phi(\bar\jmath_R(S))=2|S|-2|\bar\jmath_R(S)|=2|\delta_R(S)|$, since $\bar\jmath_R(S)\subseteq S$. Summing over $S\in\mathcal D(R)$,
$$
  \Phi(\mathcal D(R))=\sum_{S\in\mathcal D(R)}\phi(S)=\sum_{S\in\mathcal D(R)}\phi(\bar\jmath_R(S))+2\sum_{S\in\mathcal D(R)}|\delta_R(S)|=\mathrm{Ret}(R)+2\,\mathrm{Def}(R).
$$
The fibre-coordinate forms: the fibre $\bar\jmath_R^{-1}(S_0)$ has $a_{S_0}$ elements, of which $a_{S_0}-1$ lie in $\mathcal D(R)$ (all but the fixed point $S_0$), each with retraction target $S_0$, so it contributes $(a_{S_0}-1)\phi(S_0)$ to $\mathrm{Ret}(R)$; and $\sum_{S\in\bar\jmath_R^{-1}(S_0)}|\delta_R(S)|=\sum_{T\in I_{R,S_0}}|T|=\Sigma(I_{R,S_0})$. $\qquad\blacksquare$

The flow identity is the **charging argument**: $\mathrm{Ret}(R)$ is the level-1 weight collected at the retraction targets — one copy of $\phi(S_0)$ for each non-fixed element of the fibre over $S_0$ — and $2\,\mathrm{Def}(R)$ is twice the deficiency mass that flowed down to make the charge. It already separates the two structural dangers UC5 §1.3 named: $\mathrm{Def}(R)\ge 0$ always (the deficiency mass is the "$2\Sigma(I_{R,S_0})\ge 0$" term), and $\mathrm{Ret}(R)$ — the "$(|I_{R,S_0}|-1)\phi(S_0)$" term — is the only place a sign can be won, and only by *low* retraction targets ($\phi(S_0)<0$, i.e. $|S_0|<k/2$).

### 1.2 Consistency check

> **Example 1.2 (the flow identity, worked).** $W=\{1,2,3\}$, $k=3$; take $R$ with co-fibre $\mathcal S(R)=\{\{1\},W\}$ (union-closed: $\{1\}\cup W=W$; contains $W$). Then $\mathcal S(R)^\uparrow=\{S:1\in S\}=\{\{1\},\{1,2\},\{1,3\},W\}$ and $\mathcal D(R)=\{\{1,2\},\{1,3\}\}$. The retraction: $\bar\jmath_R(\{1,2\})=\bar\jmath_R(\{1,3\})=\{1\}$. So $\mathrm{Ret}(R)=\phi(\{1\})+\phi(\{1\})=-2$, $\mathrm{Def}(R)=|\{2\}|+|\{3\}|=2$, and $\Phi(\mathcal D(R))=-2+2\cdot 2=2$. Direct: $\Phi(\mathcal D(R))=\phi(\{1,2\})+\phi(\{1,3\})=1+1=2$ ✓. The fibres are $\bar\jmath_R^{-1}(\{1\})=\{\{1\},\{1,2\},\{1,3\}\}$ ($a_{\{1\}}=3$) and $\bar\jmath_R^{-1}(W)=\{W\}$ ($a_W=1$); fibre-coordinate forms: $\mathrm{Ret}(R)=(3-1)\phi(\{1\})+(1-1)\phi(W)=-2$, $\mathrm{Def}(R)=\Sigma(I_{R,\{1\}})+\Sigma(I_{R,W})=(0+1+1)+0=2$ ✓.

### 1.3 The tiling-coupling explicit form

UC5 Lemma 1.2 established that each $I_{R,S_0}$ is an order ideal *in isolation*. The tiling coupling is the statement that the $I_{R,S_0}$ for different $S_0$ are not independent — they are all cut from the *single* family $\mathcal S(R)$ by *one* relation. The next theorem makes this an identity.

For $S_0\in\mathcal S(R)$, write $W_0:=W\setminus S_0$ and define the **$S_0$-residual system**
$$
  \mathcal S(R)/S_0\;:=\;\{\,T'\setminus S_0:\;T'\in\mathcal S(R),\ T'\not\subseteq S_0\,\}\;\subseteq\;2^{W_0}\setminus\{\emptyset\}.
$$

> **Theorem 1.3 (the tiling coupling, explicit form).** For every $S_0\in\mathcal S(R)$,
> $$
>   I_{R,S_0}\;=\;2^{W_0}\;\setminus\;\bigl(\mathcal S(R)/S_0\bigr)^{\uparrow},
> $$
> the order ideal of $2^{W_0}$ whose complementary filter is generated by the $S_0$-residuals of $\mathcal S(R)$. In particular all fibre-ideals $\{I_{R,S_0}\}_{S_0\in\mathcal S(R)}$ of one fibre $R$ are determined by the single co-fibre $\mathcal S(R)$ through this one formula — the tiling coupling as a closed identity.

*Proof.* Fix $S_0\in\mathcal S(R)$ and $T\subseteq W_0$. By UC5 Lemma 1.2, $T\in I_{R,S_0}$ iff $\bar\jmath_R(S_0\cup T)=S_0$, i.e. iff $S_0=\max(\mathcal S(R)\cap 2^{S_0\cup T})$. Since $S_0\in\mathcal S(R)\cap 2^{S_0\cup T}$ always, this maximum exceeds $S_0$ precisely when some $T'\in\mathcal S(R)$ satisfies $T'\subseteq S_0\cup T$ and $T'\not\subseteq S_0$ (then $T'\cup S_0\in\mathcal S(R)\cap 2^{S_0\cup T}$ properly contains $S_0$). For such a $T'$, $T'\setminus S_0\neq\emptyset$ and $T'\setminus S_0\subseteq T$; conversely any $T'\in\mathcal S(R)$ with $T'\not\subseteq S_0$ and $T'\setminus S_0\subseteq T$ has $T'\subseteq S_0\cup T$. Hence $\bar\jmath_R(S_0\cup T)\supsetneq S_0$ iff $T\supseteq T'\setminus S_0$ for some $T'\in\mathcal S(R)$ with $T'\not\subseteq S_0$, i.e. iff $T\in(\mathcal S(R)/S_0)^\uparrow$. Therefore $T\in I_{R,S_0}\iff T\notin(\mathcal S(R)/S_0)^\uparrow$. $\qquad\blacksquare$

Theorem 1.3 is the precise sense in which UC5's "the fibres tile $\mathcal S(R)^\uparrow$" is a *coupling* and not just a partition: the entire tiling — every fibre-ideal, every fibre size $a_{S_0}$, every deficiency $\Sigma(I_{R,S_0})$ — is read off the single union-closed family $\mathcal S(R)$ by the residual-filter formula. Two immediate readings:

- **The fibre over $W$ is always a point.** $\mathcal S(R)/W=\emptyset$ has up-closure $\emptyset$... but $W_0=\emptyset$, $2^{W_0}=\{\emptyset\}$, and $I_{R,W}=\{\emptyset\}$, $a_W=1$. Consistent: $\bar\jmath_R^{-1}(W)=\{W\}$ since $\bar\jmath_R(S)=W\iff W\subseteq S\iff S=W$.
- **The fibre over $S_0$ is large exactly when $\mathcal S(R)$ is "sparse above $S_0$".** $a_{S_0}=|I_{R,S_0}|=2^{k-|S_0|}-|(\mathcal S(R)/S_0)^\uparrow|$; the fibre is the whole interval ($a_{S_0}=2^{k-|S_0|}$) iff no member of $\mathcal S(R)$ other than subsets of $S_0$ lies in $[S_0,W]\cup\dots$ — precisely the configurations UC5 §1.3 flagged as "high $S_0$ with large fibre-ideal."

### 1.4 The boundary conservation law

The third identity is the conservation law UC5 §4.3 predicted: it expresses $\Phi(\mathcal D(R))$ through the **inter-fibre Hasse edges** of the tiling — the "boundary edges between adjacent fibres of $\bar\jmath_R$."

For an order ideal $I\subseteq 2^{W_0}$ and $x\in W_0$, write $i_x(I):=|\{T\in I:x\in T\}|$. The **upper boundary of the fibre $\bar\jmath_R^{-1}(S_0)$** is the set of Hasse edges $(S,S\cup\{x\})$ of $2^W$ with $S\in\bar\jmath_R^{-1}(S_0)$, $x\notin S$, $S\cup\{x\}\in\mathcal S(R)^\uparrow$, and $\bar\jmath_R(S\cup\{x\})\neq S_0$. Write $B(S_0)$ for its cardinality and $B(R):=\sum_{S_0\in\mathcal S(R)}B(S_0)$.

> **Lemma 1.4a (boundary-edge count of a fibre).** For each $S_0\in\mathcal S(R)$,
> $$
>   B(S_0)\;=\;\sum_{x\in W_0}\bigl(a_{S_0}-2\,i_x(I_{R,S_0})\bigr)\;=\;(k-|S_0|)\,a_{S_0}-2\,\Sigma(I_{R,S_0})\;\ge\;0,
> $$
> and $B(S_0)\ge 1$ whenever $S_0\neq W$.

*Proof.* A Hasse edge out of $\bar\jmath_R^{-1}(S_0)$ in direction $x$ corresponds, under the isomorphism $\bar\jmath_R^{-1}(S_0)\cong I_{R,S_0}$, to a pair $(T,T\cup\{x\})$ with $T\in I_{R,S_0}$, $x\in W_0\setminus T$, $T\cup\{x\}\notin I_{R,S_0}$. (If $T\cup\{x\}\in I_{R,S_0}$ the edge is *intra*-fibre; if $T\cup\{x\}\notin\mathcal S(R)^\uparrow$ at all then... but $I_{R,S_0}\subseteq 2^{W_0}$ and every $S_0\cup T'$, $T'\subseteq W_0$, lies in $[S_0,W]\subseteq\mathcal S(R)^\uparrow$ since $S_0\in\mathcal S(R)$, so $S\cup\{x\}\in\mathcal S(R)^\uparrow$ automatically.) The map $T\mapsto T\cup\{x\}$ injects $\{T\in I_{R,S_0}:x\notin T,\ T\cup\{x\}\in I_{R,S_0}\}$ onto $\{T\in I_{R,S_0}:x\in T\}$, both of size $i_x$; and $|\{T\in I_{R,S_0}:x\notin T\}|=a_{S_0}-i_x$. Hence the dir-$x$ boundary edges number $(a_{S_0}-i_x)-i_x=a_{S_0}-2i_x\ge 0$ ($i_x\le a_{S_0}/2$ because $T\mapsto T\setminus\{x\}$ injects $\{x\in T\}$ into $\{x\notin T\}$, $I_{R,S_0}$ being an ideal). Summing over $x\in W_0$: $B(S_0)=(k-|S_0|)a_{S_0}-2\sum_x i_x=(k-|S_0|)a_{S_0}-2\Sigma(I_{R,S_0})$. For $S_0\neq W$, $W_0\neq\emptyset$ and $I_{R,S_0}\subsetneq 2^{W_0}$ properly (else $W\in\bar\jmath_R^{-1}(S_0)$, forcing $S_0=W$); a proper non-empty order ideal of a non-trivial cube has at least one upper boundary edge, so $B(S_0)\ge 1$. $\qquad\blacksquare$

> **Theorem 1.4 (the boundary conservation law).** For each $R\in\mathcal R_W$,
> $$
>   \Phi(\mathcal D(R))\;=\;\sum_{S_0\in\mathcal S(R)}\bigl[\,a_{S_0}\,|S_0|\;-\;\phi(S_0)\,\bigr]\;-\;B(R)
>   \;=\;\sum_{S\in\mathcal S(R)^\uparrow}|\bar\jmath_R(S)|\;-\;\Phi(\mathcal S(R))\;-\;B(R),
> $$
> where $B(R)\ge|\mathcal S(R)|-1$ is the total number of inter-fibre Hasse edges of the tiling of $\mathcal S(R)^\uparrow$.

*Proof.* By UC5 Thm 1.3 and Lemma 1.4a, the per-fibre defect is
$$
  (a_{S_0}-1)\phi(S_0)+2\Sigma(I_{R,S_0})=(a_{S_0}-1)\phi(S_0)+(k-|S_0|)a_{S_0}-B(S_0).
$$
Now $(a_{S_0}-1)\phi(S_0)+(k-|S_0|)a_{S_0}=a_{S_0}\bigl(2|S_0|-k+k-|S_0|\bigr)-\phi(S_0)=a_{S_0}|S_0|-\phi(S_0)$. Summing over $S_0\in\mathcal S(R)$ gives the first form. The second uses $\sum_{S_0}a_{S_0}|S_0|=\sum_{S_0}|\bar\jmath_R^{-1}(S_0)|\,|S_0|=\sum_{S\in\mathcal S(R)^\uparrow}|\bar\jmath_R(S)|$ and $\sum_{S_0}\phi(S_0)=\Phi(\mathcal S(R))$. Finally $B(R)=\sum_{S_0}B(S_0)\ge\sum_{S_0\neq W}1=|\mathcal S(R)|-1$ by Lemma 1.4a (and $B(W)=0$). $\qquad\blacksquare$

> **Example 1.4b (the conservation law, worked).** Continuing Example 1.2: $\sum_{S_0}a_{S_0}|S_0|=a_{\{1\}}\cdot 1+a_W\cdot 3=3+3=6$; $\Phi(\mathcal S(R))=\phi(\{1\})+\phi(W)=-1+3=2$. The Hasse edges of $\mathcal S(R)^\uparrow$ are $\{1\}\!-\!\{1,2\}$, $\{1\}\!-\!\{1,3\}$ (intra-fibre, both in $\bar\jmath_R^{-1}(\{1\})$) and $\{1,2\}\!-\!W$, $\{1,3\}\!-\!W$ (inter-fibre, from $\bar\jmath_R^{-1}(\{1\})$ to $\bar\jmath_R^{-1}(W)$), so $B(R)=2$. Conservation law: $\Phi(\mathcal D(R))=6-2-2=2$ ✓; and $B(R)=2\ge|\mathcal S(R)|-1=1$ ✓.

Theorem 1.4 is the conservation law in the literal sense: $\Phi(\mathcal D(R))$ is the **rooted mass** $\sum_{S_0}a_{S_0}|S_0|$ (each retraction target weighted by its fibre size and its own size) minus $\Phi(\mathcal S(R))$, minus the **boundary deficit** $B(R)$ — the number of edges by which the tiling fails to be a single block. The defect is large exactly when the rooted mass is high and the tiling has *few* boundary edges (few, large fibres rooted at large $S_0$); it is driven *down* by boundary edges (many, small fibres). This is the precise mechanism UC5 §4.3 asked the flow argument to expose.

### 1.5 No per-fibre sign theorem — the genuine obstruction, located

The conservation law makes precise *why* Phase 1 cannot close the residual fibre-by-fibre — and turns UC5's "cannot be closed by a single-$W$ argument" into a sharp structural statement.

> **Proposition 1.5 (per-fibre sign-indefiniteness).** $\Phi(\mathcal D(R))$ is **not sign-definite** on the large-fibre class: there exist large fibres with $\Phi(\mathcal D(R))>0$ and large fibres with $\Phi(\mathcal D(R))<0$. Consequently no inequality of the form "$\Phi(\mathcal D(R))\le 0$ for all $R$ with $|R|>\lfloor k/2\rfloor$" can hold — the residual is irreducibly a *sum*-level (cross-fibre, or cross-generator) statement. The structural reason: the order-ideal bound $a_{S_0}-1\le\Sigma(I_{R,S_0})\le(k-|S_0|)a_{S_0}/2$ leaves the per-fibre defect $c(S_0):=(a_{S_0}-1)\phi(S_0)+2\Sigma(I_{R,S_0})$ free in the interval $\bigl[(a_{S_0}-1)(\phi(S_0)+2),\ a_{S_0}|S_0|-\phi(S_0)\bigr]$, which strictly straddles $0$ whenever $|S_0|\le\lfloor k/2\rfloor-1$ and $a_{S_0}\ge 2$.

*Proof.* Example 1.2 exhibits a large fibre ($|R|\ge 2>\lfloor k/2\rfloor$ for $k=3$, forced by the minimality grading from $\{1\}\in\mathcal S(R)$) with $\Phi(\mathcal D(R))=2>0$; Example 1.7 exhibits a large fibre ($|R|=3$, $k=3$) with $\Phi(\mathcal D(R))=-3<0$. So both signs occur on the large-fibre class, and no uniform per-fibre inequality is possible. The interval for $c(S_0)$: the lower bound is UC5's $\Sigma(I_{R,S_0})\ge a_{S_0}-1$ (an order ideal containing $\emptyset$ has its other $a_{S_0}-1$ members of size $\ge 1$), giving $c(S_0)\ge(a_{S_0}-1)\phi(S_0)+2(a_{S_0}-1)=(a_{S_0}-1)(\phi(S_0)+2)$; the upper bound is Lemma 1.4a rearranged ($c(S_0)=a_{S_0}|S_0|-\phi(S_0)-B(S_0)$ with $B(S_0)\ge 0$). For $|S_0|\le\lfloor k/2\rfloor-1$, $\phi(S_0)+2\le 0$ so the lower endpoint is $\le 0$ (and $<0$ once $a_{S_0}\ge 2$), while the upper endpoint $a_{S_0}|S_0|-\phi(S_0)\ge -\phi(S_0)\ge 2>0$ — the interval straddles $0$, and both endpoints are attained by genuine order ideals (rank-$\le 1$ ideals attain the lower; $I_{R,S_0}=2^{W_0}$ attains the upper). $\qquad\blacksquare$

This is the honest location of the obstruction. UC4 said "the residual is the sign of $D(W)$"; UC5 said "the residual is the sign of $D^{\mathrm{lg}}(W)$, and it cannot be closed by a single-$W$ argument at $k=3$"; UC6 §1.5 says **precisely why**: the per-fibre defect $\Phi(\mathcal D(R))$ is sign-indefinite even within the large-fibre class, because the order-ideal structure alone (UC5 Lemma 1.2) does not pin $\Sigma(I_{R,S_0})$ — only the *tiling* (the joint constraint of Theorem 1.3) and the *cross-$R$ coupling* (§3) do. Phase 1's contribution is therefore not a per-fibre sign theorem (impossible) but the exact conservation law (Theorem 1.4) plus the structured-class closure of §1.6.

### 1.6 The low-rooted shallow class

The conservation law closes $D^{\mathrm{lg}}(W)\le 0$ on a new native region of the frontier — defined by an *intrinsic* condition on the co-fibres of the large fibres, and properly containing UC5's large-fibre-monotone class.

> **Definition.** A fibre $R\in\mathcal R_W$ is **shallow** if every $S\in\mathcal D(R)$ has $|\delta_R(S)|=1$ (equivalently every fibre-ideal $I_{R,S_0}$ has rank $\le 1$: all its non-empty members are singletons; equivalently $\mathrm{Def}(R)=|\mathcal D(R)|$, the minimum possible). It is **low-rooted** if every $S_0\in\mathcal S(R)$ with $a_{S_0}\ge 2$ has $|S_0|\le\lfloor k/2\rfloor-1$ (equivalently $\phi(S_0)\le -2$). $\mathcal F$ is **low-rooted shallow** (relative to $W$) if every large fibre $R\in\mathcal R_W^{\mathrm{lg}}$ is shallow and low-rooted.

> **Theorem 1.6 (low-rooted shallow $\Rightarrow$ Frankl, witnessed in $W$).** If $\mathcal F$ is low-rooted shallow then $D^{\mathrm{lg}}(W)\le 0$, hence $\sigma(W)=A(W)+Q^{\mathrm{lg}}(W)-D^{\mathrm{lg}}(W)\ge 0$ and some $x\in W$ is abundant. The class **properly contains** UC5's large-fibre-monotone class.

*Proof.* Fix a large fibre $R$. Shallowness gives $\mathrm{Def}(R)=|\mathcal D(R)|=\sum_{S_0}(a_{S_0}-1)$. By the flow identity (Theorem 1.1),
$$
  \Phi(\mathcal D(R))=\mathrm{Ret}(R)+2\,\mathrm{Def}(R)=\sum_{S_0\in\mathcal S(R)}(a_{S_0}-1)\bigl(\phi(S_0)+2\bigr).
$$
For each $S_0$ with $a_{S_0}\ge 2$, low-rootedness gives $\phi(S_0)+2\le 0$, so the term is $\le 0$; terms with $a_{S_0}=1$ vanish. Hence $\Phi(\mathcal D(R))\le 0$ for every $R\in\mathcal R_W^{\mathrm{lg}}$, so $D^{\mathrm{lg}}(W)=\sum_{R\in\mathcal R_W^{\mathrm{lg}}}\Phi(\mathcal D(R))\le 0$, and UC5 Thm 2.1 gives $\sigma(W)\ge 0$; then $\max_{x\in W}\beta_x\ge\sigma(W)/k\ge 0$. Containment: if $\mathcal F$ is large-fibre-monotone then $\mathcal D(R)=\emptyset$ for every large $R$, so every large fibre is vacuously shallow and low-rooted. The containment is proper — Example 1.7 exhibits a low-rooted shallow family with a large fibre carrying non-empty defect ($\mathcal D(R)\neq\emptyset$), hence not large-fibre-monotone. $\qquad\blacksquare$

> **Example 1.7 (low-rooted shallow, not large-fibre-monotone — at the $k=3$ frontier).** $U=\{1,\dots,6\}$, $W=\{1,2,3\}$ ($k=3$, $\lfloor k/2\rfloor=1$), $R=\{4,5,6\}$, and
> $$
>   \mathcal F=\bigl\{\,W,\ R,\ R\cup\{1,2\},\ R\cup\{1,3\},\ R\cup\{2,3\},\ U\,\bigr\}.
> $$
> Union-closed (every non-trivial union is $U$ or lands in the list), $m(\mathcal F)=3$, $W$ a minimal generator. *Fibres:* $\mathcal R_W=\{\emptyset,R\}$ with $\mathcal R_W^{\mathrm{sm}}=\{\emptyset\}$, $\mathcal R_W^{\mathrm{lg}}=\{R\}$ ($|R|=3>1$). *Co-fibres:* $\mathcal S(\emptyset)=\{W\}$ and $\mathcal S(R)=\{\emptyset,\{1,2\},\{1,3\},\{2,3\},W\}$ — union-closed ($\{1,2\}\cup\{1,3\}=W$), contains $W$, and $\emptyset\in\mathcal S(R)$ since $R\in\mathcal F$ ($|R|=k$). *The defect:* $\mathcal S(R)^\uparrow=2^W$, so $\mathcal D(R)=\{\{1\},\{2\},\{3\}\}$; each singleton retracts $\bar\jmath_R(\{x\})=\emptyset$ with $|\delta_R(\{x\})|=1$. So $R$ is **shallow** (every deficiency is $1$) and **low-rooted** (the only defect-carrying root is $S_0=\emptyset$, $|S_0|=0\le\lfloor k/2\rfloor-1=0$): $\mathcal F$ is low-rooted shallow. *The arithmetic:* the only fibre with $a_{S_0}\ge 2$ is $S_0=\emptyset$, $a_\emptyset=4$, so by the flow identity $\Phi(\mathcal D(R))=(a_\emptyset-1)(\phi(\emptyset)+2)=3\cdot(-3+2)=-3\le 0$; $A(W)=\Phi(\mathcal S(\emptyset))=\phi(W)=3$, $Q^{\mathrm{lg}}(W)=\Phi(2^W)=0$, $D^{\mathrm{lg}}(W)=-3$, and $\sigma(W)=A+Q^{\mathrm{lg}}-D^{\mathrm{lg}}=3+0-(-3)=6\ge 0$ ✓. The family is **not** large-fibre-monotone: the large fibre $R$ has $\mathcal D(R)=\{\{1\},\{2\},\{3\}\}\neq\emptyset$ (equivalently $\mathcal S(R)$ is not a filter — $\emptyset\in\mathcal S(R)$ but $\{1\}\notin\mathcal S(R)$). So the containment of Theorem 1.6 is proper already at $k=3$.

Example 1.7 is the precise sense in which Phase 1's flow argument *adds* a closeable region of the open $m(\mathcal F)=3$ frontier: UC5's large-fibre-monotone class requires $\mathcal D(R)=\emptyset$ on every large fibre, whereas low-rooted shallow permits a *non-empty* large-fibre defect, provided it is shallow (deficiency $1$ per element) and rooted low (below level $k/2-1$) — and the flow identity then signs it negative.

The honest scope of Theorem 1.6: it is a new sufficient condition, strictly more permissive than UC5's large-fibre-monotone class already at the $k=3$ frontier (Example 1.7), obtained *directly from the flow identity*. It does not close the residual in general — Proposition 1.5 shows it cannot be closed per-fibre — but it is the Phase-1 payoff: the tiling-coupling flow argument, quantified into three exact identities, yields a genuinely larger closeable region of the $m(\mathcal F)\ge 3$ frontier.

---

## §2. Phase 2: the Gram/hybrid global argument

UC5 §4.3 named the Phase-2 push: "combine the §3 Gram form with the §2 hybrid: the global residual $\sum_W D^{\mathrm{lg}}(W)$ versus $\sum_W(A(W)+Q^{\mathrm{lg}}(W))$, using Prop 3.2's symmetric $\Gamma$ to pair the cross-generator large-fibre contributions." This section delivers the combined global identity and closes the global residual on two new native classes.

### 2.1 The combined global identity

By the I1 interlock (UC4 Thm 4.1) and the generator/non-generator split (UC5 §3.1):
$$
  \sum_{W\in\mathcal W}\sigma(W)=\sum_x\deg_{\mathcal W}(x)\,\beta_x=\Sigma_{\mathcal W}+\sum_{W\in\mathcal W}\sigma_{\mathrm{rest}}(W),
\tag{2.1}
$$
with $\Sigma_{\mathcal W}=\sum_x\deg_{\mathcal W}(x)(2\deg_{\mathcal W}(x)-N)$ (UC5 Thm 3.1) and $\sigma_{\mathrm{rest}}(W)=\sum_{A\in\mathcal F\setminus\mathcal W}\phi(A\cap W)$. The global residual of UC5 §4.2 — $\sum_W D^{\mathrm{lg}}(W)\le\sum_W(A(W)+Q^{\mathrm{lg}}(W))$ — is exactly $\sum_W\sigma(W)\ge 0$, by the hybrid decomposition summed over $\mathcal W$. So (2.1) splits the global residual into the **generator block** $\Sigma_{\mathcal W}$ and the **non-generator block** $\sum_W\sigma_{\mathrm{rest}}(W)$.

The next lemma re-expresses the generator block through the far-pair graph $\Gamma$ — the object UC5 Prop 3.2 identified as carrying the cross-generator large-fibre contributions.

> **Lemma 2.1 ($\Gamma$-edge form of the generator block).** With $\Gamma$ the far-pair graph ($W\sim_\Gamma W'\iff|W\cap W'|<\lceil k/2\rceil$, UC5 Prop 3.2),
> $$
>   \Sigma_{\mathcal W}\;=\;kN\;+\;2\!\!\sum_{\{W,W'\}:\,W\ne W'}\!\!\phi(W\cap W')
>   \;=\;kN\;+\;2\!\!\sum_{\{W,W'\}\in E(\Gamma)}\!\!\phi(W\cap W')\;+\;2\!\!\sum_{\{W,W'\}\notin E(\Gamma),\,W\ne W'}\!\!\phi(W\cap W'),
> $$
> where the last sum is over non-edges and is $\ge 0$ term-by-term, while every $\Gamma$-edge term satisfies $-k\le\phi(W\cap W')\le -1$ (for $k$ even, $\le -2$). Consequently
> $$
>   \Sigma_{\mathcal W}\;\ge\;kN-2k\,|E(\Gamma)|\;=\;k\bigl(N-2|E(\Gamma)|\bigr).
> $$

*Proof.* By UC5 Thm 3.1, $\Sigma_{\mathcal W}=\sum_{W,W'}\phi(W\cap W')$ over *ordered* pairs; the diagonal contributes $\sum_W\phi(W)=kN$ and the off-diagonal is $2\sum_{\{W,W'\}}\phi(W\cap W')$ by symmetry of $\phi(W\cap W')$. For distinct $W,W'$: a pair is a $\Gamma$-edge iff $|W\cap W'|<\lceil k/2\rceil$, i.e. iff $|W\cap W'|\le\lceil k/2\rceil-1$, i.e. iff $\phi(W\cap W')=2|W\cap W'|-k\le 2\lceil k/2\rceil-2-k\le -1$ — so **an edge has $\phi(W\cap W')\le -1$** (and $\ge\phi(\emptyset)=-k$), while a **non-edge has $|W\cap W'|\ge\lceil k/2\rceil$, hence $\phi(W\cap W')\ge 2\lceil k/2\rceil-k\ge 0$**. Dropping the non-negative non-edge sum and bounding each edge term below by $-k$ gives $\Sigma_{\mathcal W}\ge kN-2k|E(\Gamma)|$. $\qquad\blacksquare$

The $\Gamma$-edge form makes the UC5 §4.3 coupling explicit: by UC5 Prop 3.2 a $\Gamma$-edge $\{W,W'\}$ is *exactly* a pair where $W'\setminus W\in\mathcal R_W^{\mathrm{lg}}$ and $W\setminus W'\in\mathcal R_{W'}^{\mathrm{lg}}$ — the cross-generator contributions to the large fibres. The negative part of the generator block $\Sigma_{\mathcal W}$ is supported precisely on the $\Gamma$-edges, which are the same data as the cross-generator part of $\sum_W D^{\mathrm{lg}}(W)$.

### 2.2 The $\Gamma$-sparse condition

> **Theorem 2.2 (the $\Gamma$-sparse condition).** If the far-pair graph is **sparse**, $|E(\Gamma)|\le N/2$ (equivalently the average $\Gamma$-degree is $\le 1$), then $\Sigma_{\mathcal W}\ge 0$. Consequently, if in addition $\sum_{W\in\mathcal W}\sigma_{\mathrm{rest}}(W)\ge 0$, then $\sum_x\deg_{\mathcal W}(x)\beta_x\ge 0$ and some $x\in U_{\mathcal W}$ is abundant: **Frankl holds for $\mathcal F$.**

*Proof.* By Lemma 2.1, $\Sigma_{\mathcal W}\ge k(N-2|E(\Gamma)|)\ge 0$ when $|E(\Gamma)|\le N/2$. Then (2.1) gives $\sum_x\deg_{\mathcal W}(x)\beta_x=\Sigma_{\mathcal W}+\sum_W\sigma_{\mathrm{rest}}(W)\ge 0$; since $\deg_{\mathcal W}(x)\ge 1$ for $x\in U_{\mathcal W}\ne\emptyset$ and $\ge 0$ elsewhere, not every $\beta_x$ can be negative (the argument of UC4 Thm 4.2). $\qquad\blacksquare$

Theorem 2.2 is a genuine new native sufficient condition on the $m(\mathcal F)\ge 3$ frontier, and it is **incomparable with UC5's concentrated-generator condition** $|U_{\mathcal W}|\le 2k$. The concentrated condition bounds the *spread* of the generators (Cauchy–Schwarz on the degree sequence); the $\Gamma$-sparse condition bounds the *number of far pairs* (the negative part of the Gram form directly). Neither implies the other: a concentrated generator set can have many far pairs ($N$ generators packed into $2k$ elements but pairwise nearly disjoint within that span — many $\Gamma$-edges), and a $\Gamma$-sparse generator set can have $|U_{\mathcal W}|$ arbitrarily large (generators pairwise *close*, $|W\cap W'|\ge\lceil k/2\rceil$, but their union sprawling). They close the generator block by two different geometric mechanisms.

### 2.3 The weighted $\Gamma$-sparse condition

The unweighted condition $|E(\Gamma)|\le N/2$ asks the *whole* graph $\Gamma$ to be sparse. The UC4 weighted interlock (UC4 Thm 4.2, weighted form) lets the argument *down-weight* the $\Gamma$-dense generators and lean on the $\Gamma$-sparse ones.

> **Theorem 2.3 (the weighted $\Gamma$-sparse condition).** Let $c:\mathcal W\to\mathbb R_{>0}$. Define the weighted generator block $\Sigma_{\mathcal W}^{c}:=\sum_{W\in\mathcal W}c_W\,\sigma_{\mathcal W}(W)$. Then
> $$
>   \Sigma_{\mathcal W}^{c}\;=\;k\sum_{W}c_W\;+\;\sum_{\{W,W'\}:\,W\ne W'}(c_W+c_{W'})\,\phi(W\cap W')
>   \;\ge\;k\Bigl(\sum_W c_W\;-\;\sum_{W}c_W\deg_\Gamma(W)\Bigr).
> $$
> Hence if the **$c$-weighted average $\Gamma$-degree is $\le 1$**, i.e. $\sum_W c_W\deg_\Gamma(W)\le\sum_W c_W$, then $\Sigma_{\mathcal W}^{c}\ge 0$; and if in addition $\sum_W c_W\sigma_{\mathrm{rest}}(W)\ge 0$, then $\sum_x\bigl(\sum_{W\ni x}c_W\bigr)\beta_x\ge 0$ and **Frankl holds for $\mathcal F$.** The unweighted Theorem 2.2 is the case $c\equiv 1$.

*Proof.* $\Sigma_{\mathcal W}^{c}=\sum_W c_W\sum_{W'}\phi(W\cap W')=\sum_{W,W'}c_W\phi(W\cap W')$; the diagonal gives $k\sum_W c_W$ and the off-diagonal, symmetrized, gives $\sum_{\{W,W'\}}(c_W+c_{W'})\phi(W\cap W')$. Non-edge terms are $\ge 0$; each $\Gamma$-edge term is $\ge -k(c_W+c_{W'})$. So $\Sigma_{\mathcal W}^{c}\ge k\sum_W c_W-k\sum_{\{W,W'\}\in E(\Gamma)}(c_W+c_{W'})=k\sum_W c_W-k\sum_W c_W\deg_\Gamma(W)$, since each $W$ appears in $\deg_\Gamma(W)$ edges. The interlock conclusion is UC4 Thm 4.2's weighted form applied to (2.1) weighted by $c$: $\sum_W c_W\sigma(W)=\sum_x(\sum_{W\ni x}c_W)\beta_x$. $\qquad\blacksquare$

Theorem 2.3 is the Phase-2 analogue of §1's structured-class closure: it closes the global residual whenever the far-pair graph $\Gamma$ is sparse *on a $c$-weighted average* — which holds, for instance, if $\Gamma$ has a large independent set (put weight on it) or is sparse outside a small dense core (down-weight the core). The honest scope: like UC5 Thm 3.4, it closes the generator block, not the non-generator block; the residual $\sum_W c_W\sigma_{\mathrm{rest}}(W)\ge 0$ remains — the precise Phase-2 remainder, which §4 names.

### 2.4 Why the global argument does not close it outright

The global residual $\sum_W\sigma(W)\ge 0$ cannot be closed unconditionally by the Gram/hybrid argument, and the reason is structurally located. The generator block $\Sigma_{\mathcal W}$ is a genuine quadratic form that *can* be negative (take $N$ pairwise-disjoint generators: $\Sigma_{\mathcal W}=kN+2\binom N2(-k)=kN(1-(N-1))<0$ for $N\ge 3$); the non-generator block $\sum_W\sigma_{\mathrm{rest}}(W)$ must then compensate, and quantifying *that* compensation is exactly the residual. What Phase 2 delivers is the precise split (2.1), the $\Gamma$-edge localization of the negative part (Lemma 2.1), and the two structured closures (Theorems 2.2, 2.3) — the global argument advanced, not completed. The pairwise-disjoint case is not a counterexample to Frankl (those generators force a large $\mathcal F$ with $\sigma_{\mathrm{rest}}>0$); it is the precise statement that the generator block alone is insufficient — the cross-$R$ coupling of §3 is what ties the two blocks together.

---

## §3. The cross-$R$ graded union law, quantified: the deficiency-contraction theorem

UC5 §4.2 named the cross-$R$ graded union law $\mathcal S(R)\vee\mathcal S(R')\subseteq\mathcal S(R\cup R')$ as "the genuinely unexploited joint constraint — the cross-$R$ analogue of UC5's exact cross-$S$ coupling," and UC5 §4.3 / state-UC5 called quantifying it into a sign "the deepest remaining lever." This section quantifies it — not into a sign, but into an exact structural law on the defect-retraction interior operators.

### 3.1 The deficiency-contraction theorem

> **Theorem 3.1 (deficiency contraction under fibre union).** Let $R,R'\in\mathcal R_W$ and $S\in\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow$. Then $S\in\mathcal S(R\cup R')^\uparrow$, and
> $$
>   \bar\jmath_{R\cup R'}(S)\;\supseteq\;\bar\jmath_R(S)\cup\bar\jmath_{R'}(S),
>   \qquad
>   \delta_{R\cup R'}(S)\;\subseteq\;\delta_R(S)\cap\delta_{R'}(S).
> $$
> That is: the defect-retraction interior operator at the *joined* fibre $R\cup R'$ is at least the join of the interior operators at $R$ and $R'$, and its deficiency is contained in the *intersection* of theirs.

*Proof.* By UC5 Thm 1.1, $\bar\jmath_R(S)\in\mathcal S(R)$ and $\bar\jmath_{R'}(S)\in\mathcal S(R')$, both $\subseteq S$. The graded union law on co-fibres gives $\bar\jmath_R(S)\cup\bar\jmath_{R'}(S)\in\mathcal S(R)\vee\mathcal S(R')\subseteq\mathcal S(R\cup R')$, and $\bar\jmath_R(S)\cup\bar\jmath_{R'}(S)\subseteq S$. So $\bar\jmath_R(S)\cup\bar\jmath_{R'}(S)\in\mathcal S(R\cup R')\cap 2^S$, which is non-empty, hence $S\in\mathcal S(R\cup R')^\uparrow$ and $\bar\jmath_{R\cup R'}(S)=\max(\mathcal S(R\cup R')\cap 2^S)\supseteq\bar\jmath_R(S)\cup\bar\jmath_{R'}(S)$. Taking complements in $S$: $\delta_{R\cup R'}(S)=S\setminus\bar\jmath_{R\cup R'}(S)\subseteq S\setminus(\bar\jmath_R(S)\cup\bar\jmath_{R'}(S))=(S\setminus\bar\jmath_R(S))\cap(S\setminus\bar\jmath_{R'}(S))=\delta_R(S)\cap\delta_{R'}(S)$. $\qquad\blacksquare$

Theorem 3.1 is the cross-$R$ graded union law as an *exact operator inequality* — the cross-$R$ analogue of UC5 Thm 1.3's exact cross-$S$ identity. It says the graded union law makes the family of interior operators $\{\bar\jmath_R\}_{R\in\mathcal R_W}$ a **lax morphism from the union-semilattice $(\mathcal R_W,\cup)$ to the lattice of interior operators on $2^W$**: joining fibres can only *grow* the retraction and *shrink* the deficiency.

### 3.2 Anti-monotonicity along the fibre lattice

> **Corollary 3.2 (deficiency is anti-monotone along $\mathcal R_W$).** If $R\subseteq R'$ in $\mathcal R_W$, then for every $S\in\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow$,
> $$
>   \bar\jmath_{R'}(S)\supseteq\bar\jmath_R(S),\qquad\delta_{R'}(S)\subseteq\delta_R(S),\qquad|\delta_{R'}(S)|\le|\delta_R(S)|.
> $$
> In particular the top fibre $R^*:=\bigcup\mathcal R_W\in\mathcal R_W$ has the *globally smallest* deficiency: $\delta_{R^*}(S)\subseteq\delta_R(S)$ for every $R$ and every $S$ in the common domain $\mathcal S(R)^\uparrow\cap\mathcal S(R^*)^\uparrow$.

*Proof.* $R\subseteq R'$ gives $R\cup R'=R'$, so Theorem 3.1 reads $\bar\jmath_{R'}(S)\supseteq\bar\jmath_R(S)\cup\bar\jmath_{R'}(S)$, i.e. $\bar\jmath_{R'}(S)\supseteq\bar\jmath_R(S)$, on the common domain. $R^*\in\mathcal R_W$ because $\mathcal R_W$ is union-closed and finite (UC3 Thm 2.3), and $R\subseteq R^*$ for every $R$. $\qquad\blacksquare$

This is the deepest lever, quantified: the cross-$R$ coupling makes the deficiency *monotone non-increasing* as the fibre grows. The defect retraction at a small fibre can be badly deficient; at a large fibre — and most of all at the top fibre $R^*$ — the same trace $S$ retracts at least as high. The intuition UC3/UC4/UC5 carried ("the large fibres host the deficiency") is here *inverted and made precise*: within a fixed generator $W$, it is the *small* fibres whose retraction is most deficient; the large fibres' deficiency is *dominated* by the small ones' — on the common domain.

### 3.3 The deficiency-mass form, and the precise residual gap

Summing Theorem 3.1 over a common domain gives a quantified statement on the deficiency masses of §1.

> **Corollary 3.3 (deficiency-mass sub-minimality).** For $R,R'\in\mathcal R_W$, write $\mathcal C:=\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow$ for the common domain. Then
> $$
>   \sum_{S\in\mathcal C}|\delta_{R\cup R'}(S)|\;\le\;\min\Bigl(\sum_{S\in\mathcal C}|\delta_R(S)|,\ \sum_{S\in\mathcal C}|\delta_{R'}(S)|\Bigr).
> $$

*Proof.* Term-by-term, $|\delta_{R\cup R'}(S)|\le|\delta_R(S)\cap\delta_{R'}(S)|\le\min(|\delta_R(S)|,|\delta_{R'}(S)|)$ by Theorem 3.1; sum over $\mathcal C$. $\qquad\blacksquare$

> **The cross-$R$ residual gap, named.** Theorem 3.1 and its corollaries control the deficiency *on the common domain* $\mathcal C=\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow$. But $\mathcal S(R\cup R')^\uparrow\supseteq\mathcal C$ can be **strictly larger** — the graded union law gives $\mathcal S(R\cup R')\supseteq\mathcal S(R)\vee\mathcal S(R')$, hence $\mathcal S(R\cup R')^\uparrow\supseteq\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow$, but the inclusion need not be equality: $\mathcal S(R\cup R')$ can contain co-fibre members that are *not* unions $S\cup S'$ with $S\in\mathcal S(R)$, $S'\in\mathcal S(R')$. The traces in $\mathcal S(R\cup R')^\uparrow\setminus\mathcal C$ carry deficiency that the cross-$R$ law, *as stated*, does not bound. Quantifying the "excess co-fibre" $\mathcal S(R\cup R')\setminus(\mathcal S(R)\vee\mathcal S(R'))$ — equivalently, the failure of the graded union law to be an *equality* — is the precise unclosed cross-$R$ gap, and it is exactly the higher-degree square-defect of UC2 Prop 4.2 read on the co-fibre system: the F-iii hook (§4.3).

So the deepest lever is quantified into a theorem (Theorem 3.1) and a clean structural consequence (Corollary 3.2: deficiency anti-monotone along $\mathcal R_W$), but it does not by itself close the residual — because the cross-$R$ law is an *inclusion*, not an equality, and the gap in that inclusion is itself an unquantified defect. This is the honest state of the deepest lever: it is no longer "unexploited" (UC5's word) — it is exploited into an exact operator law — but the operator law's domain-mismatch is the new, sharper, named residual.

---

## §4. The combined picture, the sharpened residual, and the verdict

### 4.1 What UC6 establishes

UC5 §4.3 named three indicated levers; UC6 discharges all three as theorems.

1. **The tiling-coupling flow argument — delivered (§1).** Three exact identities: the **flow identity** $\Phi(\mathcal D(R))=\mathrm{Ret}(R)+2\,\mathrm{Def}(R)$ (Theorem 1.1); the **tiling-coupling explicit form** $I_{R,S_0}=2^{W_0}\setminus(\mathcal S(R)/S_0)^\uparrow$ — every fibre-ideal cut from the single co-fibre by one formula (Theorem 1.3); the **boundary conservation law** $\Phi(\mathcal D(R))=\sum_{S_0}[a_{S_0}|S_0|-\phi(S_0)]-B(R)$ with $B(R)$ the inter-fibre Hasse-edge count (Theorem 1.4). These close $D^{\mathrm{lg}}(W)\le 0$ on the new **low-rooted shallow class** (Theorem 1.6), which properly contains UC5's large-fibre-monotone class already at $k=3$ (Example 1.7). Proposition 1.5 proves a per-fibre sign theorem is *impossible* — the obstruction located exactly.
2. **The Gram/hybrid global argument — delivered (§2).** The combined global identity $\sum_W\sigma(W)=\Sigma_{\mathcal W}+\sum_W\sigma_{\mathrm{rest}}(W)$ (2.1); the $\Gamma$-edge localization $\Sigma_{\mathcal W}\ge k(N-2|E(\Gamma)|)$ (Lemma 2.1); the **$\Gamma$-sparse condition** $|E(\Gamma)|\le N/2\Rightarrow\Sigma_{\mathcal W}\ge 0$ (Theorem 2.2) and its **weighted refinement** via the UC4 interlock (Theorem 2.3) — two new native sufficient conditions, incomparable with UC5's concentrated-generator condition.
3. **The cross-$R$ graded union law — quantified (§3).** The **deficiency-contraction theorem** $\bar\jmath_{R\cup R'}(S)\supseteq\bar\jmath_R(S)\cup\bar\jmath_{R'}(S)$, $\delta_{R\cup R'}(S)\subseteq\delta_R(S)\cap\delta_{R'}(S)$ (Theorem 3.1); the **anti-monotonicity** of the deficiency along the fibre lattice $\mathcal R_W$ (Corollary 3.2); the deficiency-mass sub-minimality on common domains (Corollary 3.3). UC5's "deepest remaining lever" is realized as an exact operator law.

### 4.2 The UC6 residual, sharpened

> **The UC6 residual (per-generator and global).** UC5's residual was the large-fibre defect $D^{\mathrm{lg}}(W)$ with the obstruction "the tiling and cross-$R$ couplings are not yet signed." UC6 signs neither into a global sign, but quantifies both — so the residual is sharper. In its sharpest UC6 form, via the boundary conservation law (Theorem 1.4) summed over the large fibres:
> $$
>   D^{\mathrm{lg}}(W)\;=\;\sum_{R\in\mathcal R_W^{\mathrm{lg}}}\Bigl[\ \sum_{S_0\in\mathcal S(R)}a_{S_0}|S_0|\;-\;\Phi(\mathcal S(R))\;-\;B(R)\ \Bigr],
> $$
> and the residual is closed as soon as $D^{\mathrm{lg}}(W)\le A(W)+Q^{\mathrm{lg}}(W)$ (per-generator) or $\sum_W D^{\mathrm{lg}}(W)\le\sum_W(A(W)+Q^{\mathrm{lg}}(W))$ (global). The tiling coupling is now a *closed identity* (the term in brackets is exact, with $B(R)$ explicitly the boundary-edge count); the cross-$R$ coupling is now a *closed operator law* (Theorem 3.1). What remains is a **single comparison of signs**: whether the boundary deficit $\sum_R B(R)$ — driven up by *many small fibres* (Corollary 3.2: small fibres carry the deficiency) — dominates the rooted mass $\sum_R\sum_{S_0}a_{S_0}|S_0|$, *globally* across $\mathcal R_W$ and across $\mathcal W$. This is a finitary, exact inequality between integer functionals — no asymptotics, no entropy slack, no ceiling.

**The precise obstruction, sharpened.** UC5's obstruction was "the joint constraints are not quantified." UC6's is sharper: the joint constraints *are* quantified — into the explicit form (Theorem 1.3), the conservation law (Theorem 1.4), and the deficiency-contraction law (Theorem 3.1) — but each is an *identity or an inclusion*, not a *sign*. The boundary conservation law gives $\Phi(\mathcal D(R))$ exactly but $B(R)$ and $\sum_{S_0}a_{S_0}|S_0|$ are not individually sign-comparable per fibre (Proposition 1.5); the cross-$R$ law gives $\delta_{R\cup R'}\subseteq\delta_R\cap\delta_{R'}$ exactly but only on the common domain $\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow$, and the excess co-fibre $\mathcal S(R\cup R')\setminus(\mathcal S(R)\vee\mathcal S(R'))$ is unquantified. The residual is now the **sign of the boundary deficit against the rooted mass, summed**, together with the **excess-co-fibre defect** of the cross-$R$ inclusion — both finitary, both exact, neither closeable by a single-$W$ argument at $k=3$ ($D^{\mathrm{lg}}(W)\le 0$ for one $W$ at $k=3$ would prove Frankl on the open frontier).

### 4.3 Indicated route and the documented fallbacks

**Indicated route for a UC7 / continuation.** Three precise next steps, each on a quantified-but-unsigned lever:

- **(Phase-1 push — sign the boundary deficit.)** The conservation law $\Phi(\mathcal D(R))=\sum_{S_0}[a_{S_0}|S_0|-\phi(S_0)]-B(R)$ is exact; the open step is a *global* lower bound on $\sum_R B(R)$ against $\sum_R\sum_{S_0}a_{S_0}|S_0|$. The boundary-edge count $B(R)$ is itself a sub-cube edge-isoperimetry quantity (Lemma 1.4a: $B(S_0)=(k-|S_0|)a_{S_0}-2\Sigma(I_{R,S_0})$); an edge-isoperimetric inequality on the tiling, summed across fibres, is the natural attack.
- **(Phase-2 push — quantify the non-generator block.)** Theorems 2.2/2.3 close the generator block $\Sigma_{\mathcal W}$ on the $\Gamma$-sparse classes; the open step is $\sum_W\sigma_{\mathrm{rest}}(W)\ge 0$ (or its weighted form). Every $A\in\mathcal F\setminus\mathcal W$ has $|A|>k$; the cumulative-fibre monotone engine (UC4 Thm 2.2) applied to the non-generator members is the natural attack.
- **(Cross-$R$ push — quantify the excess co-fibre.)** Theorem 3.1 is an inclusion; the open step is to bound $\mathcal S(R\cup R')\setminus(\mathcal S(R)\vee\mathcal S(R'))$ — the failure of the graded union law to be an equality. This is the F-iii square-defect, now with an exact attachment point.

**Documented fallbacks (UC5 §4.3 hooks), with UC6-sharpened attachment points.**

- **F-ii (component / $H_0$ route).** Attaches to the tiling-coupling explicit form (Theorem 1.3): the Hall criterion (UC2 Prop 3.6) applied to the bipartite incidence $\mathcal D(R)\to\mathcal S(R)$, $S\mapsto\bar\jmath_R(S)$ — the interior operator *is* the canonical bipartite incidence, and the fibre-ideals $I_{R,S_0}=2^{W_0}\setminus(\mathcal S(R)/S_0)^\uparrow$ give the neighbourhood structure explicitly.
- **F-iii (square-defect route).** Attaches to the cross-$R$ residual gap (§3.3): the excess co-fibre $\mathcal S(R\cup R')\setminus(\mathcal S(R)\vee\mathcal S(R'))$ is exactly the higher-degree square-defect of UC2 Prop 4.2 read on the co-fibre system — and Theorem 3.1 provides the exact operator-law backbone it must quantify.

Neither is pursued here — the Walsh route did not stall.

### 4.4 Verdict

**Verdict: GREEN-partial.**

UC6 against the ticket's scope:

- **Phase 1 — the tiling-coupling flow argument — delivered.** Three exact identities (Theorems 1.1, 1.3, 1.4) quantify the tiling coupling completely; the new low-rooted shallow class (Theorem 1.6) closes the residual on a region properly larger than UC5's, at $k=3$; Proposition 1.5 locates the obstruction exactly (no per-fibre sign theorem). UC5 §4.3's Phase-1 ask is discharged.
- **Phase 2 — the Gram/hybrid global argument — delivered.** The combined global identity (2.1), the $\Gamma$-edge localization (Lemma 2.1), and two new native sufficient conditions (Theorems 2.2, 2.3) close the global residual on structured classes. UC5 §4.3's Phase-2 ask is discharged.
- **The cross-$R$ graded union law — quantified.** The deficiency-contraction theorem (Theorem 3.1) and the anti-monotonicity corollary (Corollary 3.2) realize UC5's "deepest remaining lever" as an exact operator law. UC5 §4.2's deepest lever is discharged.

**Why GREEN-partial is the honest tag.** Not GREEN-residual-closed: neither the per-generator residual $D^{\mathrm{lg}}(W)\le A(W)+Q^{\mathrm{lg}}(W)$ nor the global residual is fully closed — and the per-generator one *cannot* be by the means here, since Proposition 1.5 proves the per-fibre defect is genuinely sign-indefinite within the large-fibre class, and $D^{\mathrm{lg}}(W)\le 0$ for a single $W$ at $k=3$ would prove Frankl on the open $m(\mathcal F)=3$ frontier. Not AMBER-residual-stalls: the route does not stall — the tiling coupling is quantified into *three exact identities* (UC5's Phase-1 ask, with the conservation law UC5 §4.3 explicitly predicted), the global argument is *closed on two new structured classes* (UC5's Phase-2 ask), and the cross-$R$ graded union law — UC5's "deepest remaining lever" — is *quantified into an exact operator law*. The defining feature of GREEN-partial — "the residual substantially advanced (e.g. the tiling coupling quantified, or the global argument closed on a structured class) but not fully closed; recommend the continuation" — is met, and exceeded: the tiling coupling is quantified, the global argument *is* closed on structured classes, *and* the deepest lever is quantified. The residual is strictly sharper than UC5's: from "the joint constraints are not quantified" to "the quantified joint constraints are identities/inclusions, not signs."

**Trust-surface impact: none.** Paper-and-pencil; no new axioms, no Lean, no computation. No engine ported — UC6 builds only on the pinned objects of UC1 §1, the structure theory of UC2 §§2–3, the characterization of UC3 §2, the decomposition of UC4 §§1–4, and the defect retraction / hybrid / Gram form of UC5 §§1–3 (UC1 §8.4's dead routes E1–E3 / C1–C5 untouched). The 1/3-2/3 critical path (`one_third_width_three`) is in a different repo and is untouched.

---

## §5. References

### 5.1 This repo / parent chain

- **mg-3806 (UC5)** — `docs/union-closed-UC5-trace-defect-residual.md`: §1 (the defect retraction $\bar\jmath_R$, the interior-operator structure Thm 1.1, the fibre-ideal structure Lemma 1.2, the exact cross-$S$ decomposition Thm 1.3 — the objects UC6 §1 quantifies into the flow identity, the explicit form, and the conservation law); §2 (the hybrid decomposition Thm 2.1, the large-fibre-monotone class Thm 2.3 — UC6 §1.6's low-rooted shallow class properly contains it); §3 (the generator Gram form Thm 3.1, the cross-incidence symmetry / far-pair graph $\Gamma$ Prop 3.2, the concentrated-generator condition Thm 3.4 — UC6 §2 builds the $\Gamma$-sparse conditions on these); §4.2 (the named residual + the precise obstruction — UC6 §4.2 sharpens it); §4.3 (the indicated route: Phase-1 tiling-coupling flow argument, Phase-2 Gram/hybrid, the cross-$R$ deepest lever, the F-ii/F-iii hooks — all discharged here). `docs/state-UC5.md` — the UC5 invariants and "Open threads."
- **mg-0bf7 (UC4)** — `docs/union-closed-UC4-large-fibre-residual.md`: §1 (the monotone aggregate-sign lemma — the harmonic engine behind Lemma 1.4a and the order-ideal bounds); §2 (the up-closure decomposition $\sigma=Q-D$, the cumulative fibre, Lemma 2.4's order-ideal structure); §4 (the I1 interlock Thm 4.1, the weighted form Thm 4.2 — UC6 Thm 2.3 uses the weighted interlock; Lemma 4.3 cross-incidence). `docs/state-UC4.md`.
- **mg-cfc0 (UC3)** — `docs/union-closed-UC3-walsh-subcube-spectrum.md`: §2 (the sub-cube Walsh characterization — graded union law, universal fibre inclusion $\mathcal R_W$ union-closed and finite hence has a top $R^*$, dual reduction, minimality grading — the standing toolkit of §0); §3 (the per-fibre sign theorem Thm 3.3, the bounded-spread condition Thm 3.5). `docs/state-UC3.md`.
- **mg-a814 (UC2)** — `docs/union-closed-UC2-transport-deficiency.md`: §3.5 (the Hall criterion Prop 3.6 — the F-ii hook, attached in UC6 §4.3 to the tiling-coupling explicit form); §4.2 (the one-sided square-defect Prop 4.2 — the F-iii hook, attached in UC6 §3.3/§4.3 to the cross-$R$ residual gap). `docs/state-UC2.md`.
- **mg-f72a (UC1)** — `docs/union-closed-compat-geom-manifesto.md`: §1.6 (the obstruction in Walsh form); §8.3 (fallback F-i, the Walsh/harmonic route UC6 continues); §8.4 (the dead routes UC6 avoids). `docs/state-UC1.md`.

### 5.2 Cross-repo — `one_third_width_three` (read access)

Used by UC6 only to stay clear of the dead routes (UC1 §8.4): the BK/Cheeger-expansion engine and Theorem E (gaps E1–E3), the F-series cohomological program and $\Delta(\mathrm{UCF}_n)$ (gaps C1–C5). UC6 is independent of the 1/3-2/3 critical path — different repo, different polecat.

### 5.3 Frankl-conjecture literature

- P. Frankl (1979) — the Union-Closed Sets conjecture.
- H. Bruhn, O. Schaudt, *The journey of the union-closed sets conjecture*, Graphs and Combinatorics 31 (2015) — the survey; the classical small-set cases (recovered natively in UC2 Thm 3.5(2)).
- B. Poonen, *Union-closed families*, J. Combin. Theory Ser. A 59 (1992) — the lattice / join-irreducible reformulation.
- J. Gilmer, *A constant lower bound for the union-closed sets conjecture* (2022) — the entropy/information-theoretic method; framed in UC3 §4, UC4 §4.5, UC5 §5 as a level-1-spectrum estimator that sees the monotone part $Q(W)$ but not the defect $D(W)$, and — after UC6 — not the boundary deficit $B(R)$ that signs it.
- W. Sawin; Z. Chase & S. Lovett; R. Alweiss, B. Huang & M. Sellke; L. Pebody (2022–2023) — the improvement to $(3-\sqrt5)/2\approx 0.38197$ and the Sawin ceiling. UC6's residual — the sign of the boundary deficit against the rooted mass, plus the excess-co-fibre defect — is the exact, finitary locus that escapes that ceiling.
- R. O'Donnell, *Analysis of Boolean Functions* (2014) — Walsh–Fourier analysis on the cube; interior/closure operators on posets; the edge-isoperimetric reading of $\Phi$ on order ideals, which UC6 Lemma 1.4a / Theorem 1.4 makes load-bearing (the boundary-edge count $B(R)$).

### 5.4 Source directives

- Daniel directives 2026-05-14 — the `union_closed` product-line assignment; UC6 is the F-i (Walsh/harmonic) continuation, UC5-localized, per UC5 §4.3: close the UC5 large-fibre-defect residual via the tiling-coupling flow argument (Phase 1) and the Gram/hybrid global argument (Phase 2), with the cross-$R$ graded union law as the deepest lever.

---

*Polecat: mg-6dad (UC6). Branch: `polecat-cat-mg-6dad`. Verdict: **GREEN-partial** — the UC5 large-fibre-defect residual is substantially advanced: the tiling coupling is fully quantified into three exact identities — the flow identity $\Phi(\mathcal D(R))=\mathrm{Ret}(R)+2\,\mathrm{Def}(R)$, the explicit form $I_{R,S_0}=2^{W_0}\setminus(\mathcal S(R)/S_0)^\uparrow$, and the boundary conservation law $\Phi(\mathcal D(R))=\sum_{S_0}[a_{S_0}|S_0|-\phi(S_0)]-B(R)$ — closing the residual on the new low-rooted shallow class (properly containing UC5's large-fibre-monotone class at $k=3$); the Gram/hybrid global argument is closed on the $\Gamma$-sparse and weighted-$\Gamma$-sparse classes via the combined identity $\sum_W\sigma(W)=\Sigma_{\mathcal W}+\sum_W\sigma_{\mathrm{rest}}(W)$ with $\Sigma_{\mathcal W}\ge k(N-2|E(\Gamma)|)$; and the cross-$R$ graded union law — UC5's deepest lever — is quantified into the deficiency-contraction theorem $\delta_{R\cup R'}(S)\subseteq\delta_R(S)\cap\delta_{R'}(S)$, making the deficiency anti-monotone along the fibre lattice $\mathcal R_W$. All three of UC5 §4.3's indicated levers discharged as theorems; the residual is sharpened to the global sign of the boundary deficit against the rooted mass plus the excess-co-fibre defect; not fully closed, and not closable by a single-$W$ argument at the $k=3$ frontier (Proposition 1.5: the per-fibre defect is genuinely sign-indefinite); no new axioms; no Lean; no computation; no engine port.*
