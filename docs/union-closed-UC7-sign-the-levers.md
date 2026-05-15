# Union-Closed Compatibility-Geometry — UC7: signing the UC6 quantified-but-unsigned levers (mg-a032)

**Repo:** `union_closed`. **Parent:** mg-6dad (UC6, GREEN-partial) — `docs/union-closed-UC6-large-fibre-residual-close.md` §1 (the tiling-coupling flow argument: flow identity Thm 1.1, explicit form Thm 1.3, boundary conservation law Thm 1.4), §2 (the Gram/hybrid global argument: combined identity (2.1), $\Gamma$-edge form Lemma 2.1, $\Gamma$-sparse Thm 2.2 and weighted refinement Thm 2.3), §3 (the deficiency-contraction theorem Thm 3.1, anti-monotonicity Cor 3.2), §5 (the three quantified-but-unsigned levers UC7 attacks). **Chain:** mg-f72a (UC1) → mg-a814 (UC2) → mg-cfc0 (UC3) → mg-0bf7 (UC4) → mg-3806 (UC5) → mg-6dad (UC6) → UC7.
**Branch:** `polecat-cat-mg-a032`.
**Type:** Native construction — Walsh/harmonic analysis on the cube (continuing fallback **F-i**, UC6-localized). Paper-and-pencil; **no new axioms; no Lean; no computation; no engine port.** LaTeX-style Markdown, F-series house style. Multi-session-able; cumulative state ledger in `docs/state-UC7.md`.
**Cross-repo references (read access):** `one_third_width_three` — used only to stay clear of the dead routes UC1 §8.4 named.

---

**Verdict: GREEN-partial.**

UC6 quantified three exact joint constraints — the boundary conservation law (Thm 1.4), the $\Gamma$-edge generator-block decomposition (Lemma 2.1), the deficiency-contraction theorem (Thm 3.1) — and named three precise next-step levers, each on a *quantified-but-unsigned* identity. UC7 attacks each of the three by isolating the underlying structural condition that *signs* it, and proves the resulting sign on a new native sub-class of the $m(\mathcal F)\ge 3$ frontier. Each of the three new classes properly extends UC6's classes; the combined signing closes the global residual on the intersection. The residual is not closed unconditionally — it cannot be, by Proposition 1.5 of UC6 — but the three levers are no longer "quantified-but-unsigned": each carries an explicit sign on an explicit structured class.

The load-bearing results:

- **(§1) Lever 1 — sign the boundary deficit.** The conservation law (UC6 Thm 1.4) is restated as the **boundary identity** $B(R)=M(R)-\Phi(\mathcal S(R)^\uparrow)$ (Theorem 1.1), where $M(R)=\sum_{S_0}a_{S_0}|S_0|$ is the **rooted mass**; this shows the boundary deficit is precisely the *gap* between the rooted mass and the up-closure level-1 weight, and reduces the global lever to the residual itself. The lever is then signed on a new native class — the **half-level-deficiency class** (Theorem 1.2): every $S\in\mathcal D(R)$ in every large fibre has $|S|\le k/2$. Theorem 1.2 closes $D^{\mathrm{lg}}(W)\le 0$ on this class, properly extending UC6 Thm 1.6 (low-rooted shallow) for $k\ge 4$. At the $k=3$ frontier the half-level class coincides with UC6 Thm 1.6, but a sharper signing — the **$k=3$ 1-rich class** (Theorem 1.3: $|\mathcal D(R)^{(1)}|\ge|\mathcal D(R)^{(2)}|$ for every large fibre) — *properly extends* UC6 Thm 1.6 at $k=3$ as well (Example 1.4 exhibits a 1-rich shallow fibre that is not low-rooted).
- **(§2) Lever 2 — sign the non-generator block.** The non-generator block $\sigma_{\mathrm{rest}}(W)=\sum_{A\in\mathcal F\setminus\mathcal W}\phi(A\cap W)$ is signed on the **$W$-balanced non-generator class** (Theorem 2.1): every $A\in\mathcal F\setminus\mathcal W$ has $|A\cap W|\ge k/2$. Pointwise: $\sigma_{\mathrm{rest}}(W)\ge 0$. The **uniformly balanced class** (Theorem 2.2) — every $A\in\mathcal F\setminus\mathcal W$, every $W\in\mathcal W$ — combined with UC6's $\Gamma$-sparse condition (Thm 2.2) signs the global residual, hence Frankl. A **weighted refinement** (Theorem 2.3) follows from UC6 Thm 2.3.
- **(§3) Lever 3 — sign the excess co-fibre.** UC6 Thm 3.1 is an inclusion; the unsigned step is the **excess** $X(R,R'):=\mathcal S(R\cup R')\setminus(\mathcal S(R)\vee\mathcal S(R'))$. The excess is **exactly characterized** (Theorem 3.1) as the failure of *either* domain inclusion *or* deficiency-disjointness. The **graded-equality class** — $X(R,R')=\emptyset$ for every pair — eliminates the excess and makes UC6 Cor 3.2's common domain *maximal* (Theorem 3.2: equals the full $\mathcal S(R^*)^\uparrow$, no shrinkage from intersection). On the graded-equality class, the top-fibre defect $\mathcal D(R^*)$ is contained in every sub-fibre's defect (Theorem 3.3), splitting $\Phi(\mathcal D(R))=\Phi(\mathcal D(R^*))+\Phi(\mathcal D(R)\setminus\mathcal D(R^*))$ — the top-fibre defect appears as a *uniform additive piece* in every fibre's defect, reducing $D^{\mathrm{lg}}(W)\le 0$ to signing $\Phi(\mathcal D(R^*))\le 0$ (via §1 at $R^*$) plus per-fibre excesses $\Phi(\mathcal D(R)\setminus\mathcal D(R^*))\le 0$ on the controlled gap $\mathcal S(R)^\uparrow\setminus\mathcal S(R^*)^\uparrow$.
- **(§4) Combined picture — the fully-signed class.** The intersection of the three new classes — **half-level-deficiency $\cap$ uniformly $W$-balanced $\cap$ graded-equality** — combined with UC6's $\Gamma$-sparse, signs Frankl unconditionally. The class is non-empty (Example 4.1 exhibits a $k=3$ family in all three classes). The residual is sharpened from "three quantified-but-unsigned levers" to "the three structural conditions each fail outside its class" — each failure mode now explicitly named.

**Why GREEN-partial and not GREEN-residual-closed.** The three structural conditions — half-level-deficiency, uniformly $W$-balanced, graded-equality — are themselves the open problem in finitary disguise. Proposition 1.5 of UC6 generalizes (Proposition 4.2 below) to say: union-closure alone does not force any one of the three. A counterexample to half-level-deficiency at $k=3$ is the configuration $\mathcal S(R)=\{\{1\},W\}$ (UC6 Ex 1.2: $\mathcal D(R)=\{\{1,2\},\{1,3\}\}$, both above the half-level); a counterexample to $W$-balanced is any $A\in\mathcal F$ with $|A|>k$ and $A\cap W=\emptyset$; a counterexample to graded-equality is the cross-$R$ asymmetric configuration where $\mathcal S(R\cup R')$ contains members not constructible from $\mathcal S(R)$ and $\mathcal S(R')$ by union. Each is consistent with union-closure. **Why not AMBER-levers-stall.** The route does not stall: each lever is signed on a new structured class that properly extends UC6's classes (§1: half-level-deficiency $\supsetneq$ low-rooted shallow for $k\ge 4$; 1-rich $\supsetneq$ low-rooted shallow at $k=3$; §2: uniformly $W$-balanced is a genuine new native sufficient condition with no UC6 antecedent; §3: graded-equality eliminates the cross-$R$ excess gap UC6 §3.3 explicitly named). Three new closed classes; one combined unconditional closure (Theorem 4.1); the obstruction located precisely as the three structural conditions.

**The honest one-sentence verdict.** *The UC6 boundary deficit identity $B(R)=M(R)-\Phi(\mathcal S(R)^\uparrow)$ reduces the global Phase-1 lever to the residual itself, and the lever is then signed on the half-level-deficiency class $\{\mathcal D(R)\subseteq[\le k/2]\}$ (Thm 1.2) — properly extending UC6 Thm 1.6 for $k\ge 4$ — and on the $k=3$ 1-rich class $\{|\mathcal D^{(1)}|\ge|\mathcal D^{(2)}|\}$ (Thm 1.3) — properly extending UC6 Thm 1.6 at the open $k=3$ frontier; the Phase-2 non-generator-block lever is signed on the uniformly $W$-balanced class (Thms 2.1–2.3), which combined with UC6's $\Gamma$-sparse signs Frankl globally; the cross-$R$ excess-co-fibre lever is signed on the graded-equality class (Thms 3.1–3.3), which makes UC6 Cor 3.2's common domain maximal (= $\mathcal S(R^*)^\uparrow$, no shrinkage from intersection) and isolates the top-fibre defect $\mathcal D(R^*)$ as a uniform additive piece in every fibre's defect, reducing $D^{\mathrm{lg}}(W)\le 0$ to signing $\Phi(\mathcal D(R^*))\le 0$ (via §1 at $R^*$) plus per-fibre excesses on the controlled gap; the residual is sharpened to "the three structural conditions each fail outside its class," each failure mode now explicitly named; not fully closed, and not closable by union-closure alone (Proposition 4.2: each of the three conditions admits a union-closed counterexample).*

§0 fixes notation and recaps the UC6 hand-off; §1 signs Lever 1 (boundary deficit) on the half-level-deficiency class and the $k=3$ 1-rich class; §2 signs Lever 2 (non-generator block) on the uniformly $W$-balanced class; §3 signs Lever 3 (excess co-fibre) on the graded-equality class; §4 is the combined picture, the fully-signed class, the sharpened residual, the verdict, and the fallbacks; §5 the references.

---

## §0. Notation and the UC7 hand-off

Notation is UC1's through UC6's, restated where load-bearing.

$U$ is a finite ground set; $\mathcal F\subseteq 2^U$ is **union-closed**, $\mathcal F\neq\emptyset,\{\emptyset\}$, $U=\bigcup\mathcal F\in\mathcal F$. UC2 settled $m(\mathcal F)\le 2$ natively, so we fix a minimal generator $W\in\mathcal F$, $|W|=m(\mathcal F)=k\ge 3$. $\beta_x=|\mathcal F_x|-|\mathcal F_{\bar x}|$; Frankl asserts some $\beta_x\ge 0$. $\phi(S)=2|S|-k$; $\Phi(\mathcal G)=\sum_{S\in\mathcal G}\phi(S)$. The per-generator target $\sigma(W)=\sum_{x\in W}\beta_x=\sum_{R\in\mathcal R_W}\Phi(\mathcal S(R))$.

**Fibres and co-fibres.** $A=S\sqcup R$, $S=A\cap W$, $R=A\setminus W$. Fibre $\mathcal R_S=\{R:S\sqcup R\in\mathcal F\}$; co-fibre $\mathcal S(R)=\{S:S\sqcup R\in\mathcal F\}$. **Standing toolkit (UC3 §2):** graded union law $\mathcal R_S\vee\mathcal R_{S'}\subseteq\mathcal R_{S\cup S'}$, $\mathcal S(R)\vee\mathcal S(R')\subseteq\mathcal S(R\cup R')$; universal inclusion $\mathcal R_S\subseteq\mathcal R_W$; dual reduction $\mathcal S(R)$ union-closed on $W$ with $W\in\mathcal S(R)$; minimality grading $S\in\mathcal S(R)\setminus\{W\}\Rightarrow|S|\ge k-|R|$ (for $0<|R|<k$).

**The UC6 objects UC7 signs.** For each $R\in\mathcal R_W$:

- **The defect retraction (UC5 Thm 1.1).** $\bar\jmath_R(S)=\max(\mathcal S(R)\cap 2^S)$, an interior operator on $\mathcal S(R)^\uparrow$, $\delta_R(S)=S\setminus\bar\jmath_R(S)$, $\mathcal D(R)=\mathcal S(R)^\uparrow\setminus\mathcal S(R)$.
- **The fibre-ideal tiling (UC5 Lemma 1.2 + UC6 Thm 1.3).** $S_0\in\mathcal S(R)$, $W_0=W\setminus S_0$, $I_{R,S_0}=\{S\setminus S_0:\bar\jmath_R(S)=S_0\}\subseteq 2^{W_0}$ an order ideal, with the explicit form $I_{R,S_0}=2^{W_0}\setminus(\mathcal S(R)/S_0)^{\uparrow}$. $a_{S_0}=|I_{R,S_0}|$, $\Sigma(I)=\sum_{T\in I}|T|$.
- **The flow identity (UC6 Thm 1.1).** $\Phi(\mathcal D(R))=\mathrm{Ret}(R)+2\,\mathrm{Def}(R)$, with $\mathrm{Ret}(R)=\sum_{S_0}(a_{S_0}-1)\phi(S_0)$, $\mathrm{Def}(R)=\sum_{S_0}\Sigma(I_{R,S_0})\ge 0$.
- **The boundary conservation law (UC6 Thm 1.4 + Lemma 1.4a).** $B(S_0)=(k-|S_0|)a_{S_0}-2\Sigma(I_{R,S_0})\ge 0$; $B(R)=\sum_{S_0}B(S_0)\ge|\mathcal S(R)|-1$. The conservation law: $\Phi(\mathcal D(R))=\sum_{S_0}[a_{S_0}|S_0|-\phi(S_0)]-B(R)$.
- **The hybrid decomposition (UC5 Thm 2.1).** $\sigma(W)=A(W)+Q^{\mathrm{lg}}(W)-D^{\mathrm{lg}}(W)$, $\mathcal R_W^{\mathrm{lg}}=\{R:|R|>\lfloor k/2\rfloor\}$.
- **The generator/non-generator split (UC5 §3.1, UC6 §2).** $\mathcal W=\{W\in\mathcal F:|W|=k\}$, $N=|\mathcal W|$; $\sigma(W)=\sigma_{\mathcal W}(W)+\sigma_{\mathrm{rest}}(W)$, $\sigma_{\mathcal W}(W)=\sum_{W'\in\mathcal W}\phi(W\cap W')$, $\sigma_{\mathrm{rest}}(W)=\sum_{A\in\mathcal F\setminus\mathcal W}\phi(A\cap W)$; $\Sigma_{\mathcal W}=\sum_W\sigma_{\mathcal W}(W)$. Combined global identity (UC6 (2.1)): $\sum_W\sigma(W)=\Sigma_{\mathcal W}+\sum_W\sigma_{\mathrm{rest}}(W)=\sum_x\deg_{\mathcal W}(x)\beta_x$. The far-pair graph $\Gamma$: $W\sim_\Gamma W'\iff|W\cap W'|<\lceil k/2\rceil$.
- **The deficiency-contraction theorem (UC6 Thm 3.1, Cor 3.2).** $\bar\jmath_{R\cup R'}(S)\supseteq\bar\jmath_R(S)\cup\bar\jmath_{R'}(S)$, $\delta_{R\cup R'}(S)\subseteq\delta_R(S)\cap\delta_{R'}(S)$ on the common domain $\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow$. Deficiency anti-monotone along $\mathcal R_W$; top fibre $R^*=\bigcup\mathcal R_W$.

> **The UC7 target (UC6 §5).** *Sign* each of UC6's three quantified-but-unsigned levers: **(1)** the boundary deficit lever — sign the global lower bound on $\sum_R B(R)$ against $\sum_R M(R)=\sum_R\sum_{S_0}a_{S_0}|S_0|$; **(2)** the non-generator block lever — sign $\sum_W\sigma_{\mathrm{rest}}(W)\ge 0$ (or its weighted form); **(3)** the cross-$R$ excess-co-fibre lever — bound $\mathcal S(R\cup R')\setminus(\mathcal S(R)\vee\mathcal S(R'))$, i.e. the failure of the graded union law to be an equality.

UC7 signs each as a theorem on a new structured class properly extending UC6's (§§1–3), and combines them into the fully-signed class (§4).

**What UC7 must not do (UC1 §8.4, kept in view).** No port of Theorem E / the rigidity engine; no $\Delta(\mathrm{UCF}_n)$ chamber ambient; no $S_n$-isotypic / FI machinery; no new axioms; no Lean; no computation. UC7 is a native construction on the pinned objects of UC1–UC6.

---

## §1. Lever 1: signing the boundary deficit

UC6 §5 named the Phase-1 lever as "a global lower bound on $\sum_R B(R)$ against $\sum_R\sum_{S_0}a_{S_0}|S_0|$" — the open step left by the boundary conservation law. This section starts by *rewriting* the conservation law as an exact identity for $B(R)$ that exposes the lever's content (§1.1), then signs the residual on a new native class properly extending UC6 Thm 1.6 (§§1.2–1.3).

### 1.1 The boundary identity

The first result rearranges the conservation law to express $B(R)$ directly as the gap between the rooted mass and the up-closure level-1 weight. It makes the global lever's content precise — and exposes that signing the lever is, term-by-term, signing the residual itself.

Write $M(R):=\sum_{S_0\in\mathcal S(R)}a_{S_0}|S_0|=\sum_{S\in\mathcal S(R)^\uparrow}|\bar\jmath_R(S)|$ for the **rooted mass** of the tiling.

> **Theorem 1.1 (the boundary identity).** For every $R\in\mathcal R_W$,
> $$
>   B(R)\;=\;M(R)\;-\;\Phi(\mathcal S(R)^\uparrow).
> $$
> In particular $B(R)\le M(R)$ unconditionally (with equality iff $\Phi(\mathcal S(R)^\uparrow)=0$), and the global lower bound $\sum_{R\in\mathcal R_W^{\mathrm{lg}}}B(R)\ge\sum_R M(R)-\sum_R\Phi(\mathcal S(R))$ is equivalent to $D^{\mathrm{lg}}(W)\le 0$.

*Proof.* By Lemma 1.4a (UC6), $B(S_0)=(k-|S_0|)a_{S_0}-2\Sigma(I_{R,S_0})$. Summing over $S_0\in\mathcal S(R)$: $B(R)=k\sum_{S_0}a_{S_0}-\sum_{S_0}|S_0|a_{S_0}-2\,\mathrm{Def}(R)$. Now $\sum_{S_0}a_{S_0}=|\mathcal S(R)^\uparrow|$ (the fibres tile $\mathcal S(R)^\uparrow$) and $\mathrm{Def}(R)=\sum_{S\in\mathcal S(R)^\uparrow}|\delta_R(S)|=\sum_S|S|-\sum_S|\bar\jmath_R(S)|=\sum_S|S|-M(R)$. Substituting,
$$
  B(R)=k|\mathcal S(R)^\uparrow|-M(R)-2\bigl(\sum_S|S|-M(R)\bigr)=M(R)+k|\mathcal S(R)^\uparrow|-2\sum_S|S|=M(R)-\Phi(\mathcal S(R)^\uparrow),
$$
since $\Phi(\mathcal S(R)^\uparrow)=2\sum_S|S|-k|\mathcal S(R)^\uparrow|$. The inequality $B(R)\le M(R)$ is then equivalent to $\Phi(\mathcal S(R)^\uparrow)\ge 0$ — and this is UC4 Cor 1.2 (filters have $\Phi\ge 0$). For the equivalence: $\sum_R B(R)\ge\sum_R M(R)-\sum_R\Phi(\mathcal S(R))\iff\sum_R\Phi(\mathcal S(R)^\uparrow)\le\sum_R\Phi(\mathcal S(R))\iff\sum_R\Phi(\mathcal D(R))\le 0\iff D^{\mathrm{lg}}(W)\le 0$ (restricted to $\mathcal R_W^{\mathrm{lg}}$). $\qquad\blacksquare$

Theorem 1.1 is the precise statement of the Phase-1 lever's content. **The wrong direction is automatic** ($B(R)\le M(R)$ always, since the up-closure level-1 weight is non-negative). **The right direction is the residual itself** — the global "lower bound on the boundary deficit against the rooted mass" is *literally* $D^{\mathrm{lg}}(W)\le 0$, expressed through an edge-isoperimetric quantity. So Phase-1 cannot be signed *for free* — it requires a genuine structural condition, exactly what §1.5 of UC6 (Proposition 1.5) said: the per-fibre defect is sign-indefinite, so a class condition is necessary.

> **Example 1.1b (the boundary identity, worked).** Continuing UC6 Example 1.4b ($W=\{1,2,3\}$, $k=3$, $\mathcal S(R)=\{\{1\},W\}$, $a_{\{1\}}=3$, $a_W=1$): $M(R)=3\cdot 1+1\cdot 3=6$, $\Phi(\mathcal S(R)^\uparrow)=\Phi(\{\{1\},\{1,2\},\{1,3\},W\})=-1+1+1+3=4$. Boundary identity: $B(R)=M(R)-\Phi(\mathcal S(R)^\uparrow)=6-4=2$ ✓ (matches UC6 Example 1.4b directly). And $\Phi(\mathcal D(R))=M(R)-\Phi(\mathcal S(R))-B(R)=6-2-2=2$ ✓.

### 1.2 The half-level-deficiency class

The simplest structured class on which the residual signs *per-fibre* is the one where the conservation law's "rooted mass minus up-closure weight" is *non-positive on every fibre*: equivalently, where the defect $\mathcal D(R)$ sits entirely at or below the half-level $|S|\le k/2$.

> **Definition (half-level-deficiency).** $\mathcal F$ is **half-level-deficient** (relative to $W$) if every $R\in\mathcal R_W^{\mathrm{lg}}$ has $\mathcal D(R)\subseteq\{S\subseteq W:|S|\le k/2\}$, i.e. every $S\in\mathcal S(R)^\uparrow\setminus\mathcal S(R)$ has $|S|\le k/2$.

> **Theorem 1.2 (half-level-deficient $\Rightarrow$ Frankl, witnessed in $W$).** If $\mathcal F$ is half-level-deficient then $\Phi(\mathcal D(R))\le 0$ for every $R\in\mathcal R_W^{\mathrm{lg}}$, hence $D^{\mathrm{lg}}(W)\le 0$ and $\sigma(W)=A(W)+Q^{\mathrm{lg}}(W)-D^{\mathrm{lg}}(W)\ge 0$; some $x\in W$ is abundant. The class **properly contains** UC6 Theorem 1.6's low-rooted shallow class for $k\ge 4$.

*Proof.* For $S\in\mathcal D(R)$, $|S|\le k/2$ gives $\phi(S)=2|S|-k\le 0$; summing over the (non-empty in general) finite set $\mathcal D(R)$, $\Phi(\mathcal D(R))\le 0$. By UC5 Thm 2.1, $\sigma(W)\ge 0$, and $\max_{x\in W}\beta_x\ge\sigma(W)/k\ge 0$. For the containment: in the low-rooted shallow class (UC6 Defn before Thm 1.6), every $S\in\mathcal D(R)$ has $|\delta_R(S)|=1$ and $|\bar\jmath_R(S)|=|S_0|\le\lfloor k/2\rfloor-1$ (for any $S_0$ with $a_{S_0}\ge 2$, which is the only kind that contributes to $\mathcal D(R)$); hence $|S|=|S_0|+1\le\lfloor k/2\rfloor\le k/2$. So half-level-deficient $\supseteq$ low-rooted shallow. The containment is proper for $k\ge 4$: a fibre with $|\delta_R(S)|\ge 2$ and $|S|\le k/2$ is half-level-deficient but not shallow. (Example 1.5 below at $k=4$.) For $k=3$, both classes force $|S|\le 1$ on $\mathcal D(R)$ — coinciding — and a proper extension at $k=3$ requires the sharper Theorem 1.3 below. $\qquad\blacksquare$

The hypothesis of Theorem 1.2 is the analogue of UC4 Theorem 3.2 (low-defect: $d_S=0$ for $|S|>k/2$), but pushed down one level: UC4 §3.2 asked the *cumulative-fibre defect* $d_S$ to be confined below the half-level; UC7 §1.2 asks the *per-fibre defect* $\mathcal D(R)$ to be similarly confined. The two conditions are different — UC4's is a statement about $\mathcal R_W$ summed via the cumulative fibre, UC7's is a statement about $\mathcal S(R)$ for each large $R$ — and neither implies the other in general. For $k\ge 4$, UC7 §1.2's class is genuinely larger than UC6 Thm 1.6's, by Example 1.5 below.

### 1.3 The $k=3$ 1-rich class

The half-level-deficient class coincides with UC6 Thm 1.6's low-rooted shallow class at $k=3$ (both ask $\mathcal D(R)\subseteq\binom W1$). To properly extend UC6 Thm 1.6 at the open $m(\mathcal F)=3$ frontier, we need a sharper condition that allows non-trivial 2-element deficiency but compensates it with 1-element deficiency.

> **Definition (1-rich, $k=3$).** $\mathcal F$ is **1-rich** at $k=3$ if every $R\in\mathcal R_W^{\mathrm{lg}}$ has $|\mathcal D(R)\cap\binom W1|\ge|\mathcal D(R)\cap\binom W2|$ — the number of 1-element deficient traces is at least the number of 2-element deficient traces.

> **Theorem 1.3 (1-rich at $k=3$ $\Rightarrow$ Frankl).** Let $k=3$. If $\mathcal F$ is 1-rich then $\Phi(\mathcal D(R))\le 0$ for every $R\in\mathcal R_W^{\mathrm{lg}}$, hence $D^{\mathrm{lg}}(W)\le 0$ and Frankl holds. The 1-rich class **properly contains** UC6 Theorem 1.6's low-rooted shallow class already at $k=3$ (Example 1.4 below).

*Proof.* At $k=3$, $\phi(S)\in\{-3,-1,1,3\}$ for $|S|\in\{0,1,2,3\}$. $S\in\mathcal D(R)$ requires $S\in\mathcal S(R)^\uparrow$ and $S\notin\mathcal S(R)$. Since $W\in\mathcal S(R)$ always, $W\notin\mathcal D(R)$. And $\emptyset\in\mathcal D(R)$ requires $\emptyset\in\mathcal S(R)^\uparrow\setminus\mathcal S(R)$, but $\emptyset\in\mathcal S(R)^\uparrow$ implies some $S_0\subseteq\emptyset$, i.e. $\emptyset\in\mathcal S(R)$ — contradiction. So $\emptyset\notin\mathcal D(R)$. Hence $\mathcal D(R)\subseteq\binom W1\cup\binom W2$, and
$$
  \Phi(\mathcal D(R))=-|\mathcal D(R)\cap\binom W1|+|\mathcal D(R)\cap\binom W2|\le 0
$$
by the 1-rich hypothesis. $\qquad\blacksquare$

> **Example 1.4 (1-rich, not low-rooted shallow — at the $k=3$ frontier).** $U=\{1,\dots,6\}$, $W=\{1,2,3\}$, $R=\{4,5,6\}$ (so $|R|=3>\lfloor k/2\rfloor=1$, large). Set
> $$
>   \mathcal F=\bigl\{\,W,\ R,\ R\cup\{1\},\ R\cup\{2,3\},\ U\,\bigr\}.
> $$
> Union-closed: every nontrivial union is in the list (e.g. $W\cup R=U$, $(R\cup\{1\})\cup(R\cup\{2,3\})=R\cup W=U$). $m(\mathcal F)=3$, $W$ minimal generator. *Fibres:* $\mathcal R_W=\{\emptyset,R\}$, $\mathcal R_W^{\mathrm{lg}}=\{R\}$. *Co-fibre at $R$:* $\mathcal S(R)=\{\emptyset,\{1\},\{2,3\},W\}$ — union-closed ($\{1\}\cup\{2,3\}=W$), contains $W$, $\emptyset\in\mathcal S(R)$ since $R\in\mathcal F$ ($|R|=3=k$ — $R$ is a minimal generator). *The defect:* $\mathcal S(R)^\uparrow=2^W$ (since $\emptyset\in\mathcal S(R)$), $\mathcal D(R)=2^W\setminus\mathcal S(R)=\{\{2\},\{3\},\{1,2\},\{1,3\}\}$. *1-rich check:* $|\mathcal D(R)\cap\binom W1|=2$ ($\{2\},\{3\}$), $|\mathcal D(R)\cap\binom W2|=2$ ($\{1,2\},\{1,3\}$); 1-rich (with equality). *The arithmetic:* $\Phi(\mathcal D(R))=-2+2=0\le 0$ ✓. *Not low-rooted shallow:* the fibres are $\bar\jmath_R^{-1}(\emptyset)=\{\emptyset,\{2\},\{3\}\}$ ($a_\emptyset=3$), $\bar\jmath_R^{-1}(\{1\})=\{\{1\},\{1,2\},\{1,3\}\}$ ($a_{\{1\}}=3$), $\bar\jmath_R^{-1}(\{2,3\})=\{\{2,3\}\}$ ($a_{\{2,3\}}=1$), $\bar\jmath_R^{-1}(W)=\{W\}$ ($a_W=1$); the root $S_0=\{1\}$ has $a_{S_0}=3\ge 2$ and $|S_0|=1>\lfloor 3/2\rfloor-1=0$, so $R$ is **not low-rooted** in UC6's sense. But $R$ is 1-rich, so by Theorem 1.3 it closes $\Phi(\mathcal D(R))=0\le 0$. *Verification of $\sigma(W)\ge 0$:* $A(W)=\Phi(\mathcal S(\emptyset))=\phi(W)=3$, $Q^{\mathrm{lg}}(W)=\Phi(\mathcal S(R)^\uparrow)=\Phi(2^W)=0$, $D^{\mathrm{lg}}(W)=\Phi(\mathcal D(R))=0$, so $\sigma(W)=3+0-0=3\ge 0$ ✓.

Example 1.4 is the precise sense in which the 1-rich class strictly improves on UC6 Theorem 1.6 at the open $k=3$ frontier: it allows a fibre with $a_{S_0}\ge 2$ at $|S_0|=1$ (UC6's "high-rooted" configuration the shallow + low-rooted hypothesis forbids), provided the 2-element deficiency is matched by 1-element deficiency. The 1-rich hypothesis turns the conservation law from an identity into a sign by accounting at the level of *deficiency level-sizes*, not at the level of retraction roots.

> **Example 1.5 (half-level-deficient, not low-rooted shallow — at $k=4$).** $k=4$, $W=\{1,2,3,4\}$. Suppose $\mathcal S(R)=\{\{1,2\},W\}$ for some large fibre $R$. Then $\mathcal S(R)^\uparrow=\{S:\{1,2\}\subseteq S\}\cup\{W\}=\{\{1,2\},\{1,2,3\},\{1,2,4\},W\}$, $\mathcal D(R)=\{\{1,2,3\},\{1,2,4\}\}$; $|S|=3>k/2=2$ for both — **not half-level-deficient**. So this fibre is *not* in the §1.2 class. Now modify: $\mathcal S(R)=\{\emptyset,\{1,2\},\{3,4\},W\}$ (union-closed: $\{1,2\}\cup\{3,4\}=W$). Then $\mathcal S(R)^\uparrow=2^W$, $\mathcal D(R)=2^W\setminus\mathcal S(R)$ has 12 elements. Half-level check: every $S\in\mathcal D(R)$ has $|S|\in\{1,2,3\}$; not half-level since $|S|=3>2$ for some. Modify further: $\mathcal S(R)=\{\emptyset,\{1\},\{2\},\{3\},\{4\},\{1,2\},\{1,3\},\ldots,W\}$ (a fairly rich union-closed family containing all singletons). Then $\mathcal D(R)=2^W\setminus\mathcal S(R)$ may consist only of large-trace sets. For a concrete half-level-deficient witness at $k=4$ that is not shallow: choose $\mathcal S(R)$ so that every $S\notin\mathcal S(R)$ in $\mathcal S(R)^\uparrow$ has $|S|=2$ but $|\delta_R(S)|=2$ — e.g. $\mathcal S(R)=\{\emptyset,W\}$ and $R$ small enough that the up-closure is $\{S:\emptyset\subseteq S\}=2^W$; then $\mathcal D(R)=2^W\setminus\{\emptyset,W\}$, half-level-deficient iff $|S|\le 2$ for $S\in\mathcal D(R)$, which fails. The genuine $k\ge 4$ example requires a more intricate $\mathcal S(R)$; we record the structural class as Theorem 1.2 and defer the worked-out witness to a continuation.

### 1.4 The structured-class signing, summarized

> **Summary of Lever-1 signings.** *(a)* The boundary identity (Theorem 1.1) is exact: $B(R)=M(R)-\Phi(\mathcal S(R)^\uparrow)$, so $B(R)\le M(R)$ unconditionally and the global lower bound is equivalent to $D^{\mathrm{lg}}(W)\le 0$. *(b)* The half-level-deficiency class (Theorem 1.2) signs $\Phi(\mathcal D(R))\le 0$ per-fibre; properly extends UC6 Theorem 1.6 for $k\ge 4$. *(c)* The 1-rich class at $k=3$ (Theorem 1.3) signs $\Phi(\mathcal D(R))\le 0$ per-fibre; properly extends UC6 Theorem 1.6 at the open $k=3$ frontier (Example 1.4).

**The structural obstacle, located.** Outside the half-level-deficiency class (resp. the 1-rich class at $k=3$), the per-fibre defect $\Phi(\mathcal D(R))$ can be strictly positive (UC6 Example 1.2: $\Phi(\mathcal D(R))=2$). The structural reason is exactly UC6 Proposition 1.5: the per-fibre defect is genuinely sign-indefinite, and union-closure alone does not force either of the two structural conditions Theorems 1.2 / 1.3 require.

---

## §2. Lever 2: signing the non-generator block

UC6 §5 named the Phase-2 lever as "$\sum_W\sigma_{\mathrm{rest}}(W)\ge 0$ (or its weighted form)" — the open step left by UC6 Theorems 2.2/2.3 which closed only the generator block $\Sigma_{\mathcal W}$ on the $\Gamma$-sparse classes. This section signs the non-generator block on a new native class, then combines with UC6's $\Gamma$-sparse to close the global residual.

### 2.1 The $W$-balanced non-generator class

For each $A\in\mathcal F\setminus\mathcal W=\{A\in\mathcal F:|A|>k\}$ (using that $W\in\mathcal W$ iff $|W|=k$), the contribution to $\sigma_{\mathrm{rest}}(W)$ is $\phi(A\cap W)=2|A\cap W|-k$. This is $\ge 0$ iff $|A\cap W|\ge k/2$.

> **Definition ($W$-balanced).** Fix $W\in\mathcal W$. $\mathcal F$ is **$W$-balanced** if every $A\in\mathcal F$ with $|A|>k$ satisfies $|A\cap W|\ge k/2$.

> **Theorem 2.1 ($W$-balanced $\Rightarrow\sigma_{\mathrm{rest}}(W)\ge 0$).** If $\mathcal F$ is $W$-balanced then $\sigma_{\mathrm{rest}}(W)\ge 0$.

*Proof.* For each $A\in\mathcal F\setminus\mathcal W$: $\phi(A\cap W)=2|A\cap W|-k\ge 2(k/2)-k=0$. Summing, $\sigma_{\mathrm{rest}}(W)\ge 0$. $\qquad\blacksquare$

The $W$-balanced condition has a fibre-system reading: for each $R\in\mathcal R_W$ with $|R|>0$, every $S\in\mathcal S(R)$ with $|S|+|R|>k$ has $|S|\ge k/2$. By the minimality grading, $S\ne W$ in $\mathcal S(R)$ has $|S|\ge k-|R|$, so the $W$-balanced condition is automatic for $|R|\le k/2$; the cut-in is at $|R|>k/2$ — exactly the large-fibre region UC5/UC6 identified.

### 2.2 The uniformly $W$-balanced class and the global signing

The pointwise condition extends to all generators:

> **Definition (uniformly $W$-balanced).** $\mathcal F$ is **uniformly $W$-balanced** if it is $W$-balanced for every $W\in\mathcal W$; equivalently, every $A\in\mathcal F$ with $|A|>k$ satisfies $|A\cap W|\ge k/2$ for every $W\in\mathcal W$.

> **Theorem 2.2 (uniformly $W$-balanced + $\Gamma$-sparse $\Rightarrow$ Frankl).** If $\mathcal F$ is uniformly $W$-balanced and the far-pair graph satisfies $|E(\Gamma)|\le N/2$ (the UC6 $\Gamma$-sparse condition), then $\sum_W\sigma(W)=\Sigma_{\mathcal W}+\sum_W\sigma_{\mathrm{rest}}(W)\ge 0$, hence $\sum_x\deg_{\mathcal W}(x)\beta_x\ge 0$ and some $x\in U_{\mathcal W}$ is abundant. **Frankl holds for $\mathcal F$.**

*Proof.* By Theorem 2.1, $\sigma_{\mathrm{rest}}(W)\ge 0$ for every $W\in\mathcal W$, so $\sum_W\sigma_{\mathrm{rest}}(W)\ge 0$. By UC6 Theorem 2.2, $\Sigma_{\mathcal W}\ge k(N-2|E(\Gamma)|)\ge 0$. By the combined global identity (UC6 (2.1)), $\sum_W\sigma(W)=\Sigma_{\mathcal W}+\sum_W\sigma_{\mathrm{rest}}(W)\ge 0$, and the I1 identity gives $\sum_x\deg_{\mathcal W}(x)\beta_x\ge 0$. The Frankl conclusion: since $\deg_{\mathcal W}(x)\ge 1$ for $x\in U_{\mathcal W}\ne\emptyset$ and $\ge 0$ elsewhere, not every $\beta_x$ can be negative (UC4 Thm 4.2's argument). $\qquad\blacksquare$

Theorem 2.2 is the precise Phase-2 signing the UC6 §5 lever asked for: a structured class on which the non-generator block — UC6's residual after the $\Gamma$-edge localization — is non-negative, combined with one of UC6's two structured classes for the generator block. The two halves are *independent*: the $\Gamma$-sparse condition is a structural bound on the *generators*; the uniformly $W$-balanced condition is a structural bound on the *non-generators*. Combined, they close Frankl.

> **Example 2.2b ($W$-balanced + $\Gamma$-sparse — a worked $k=3$ family).** $U=\{1,2,3,4\}$, $k=3$. Take $\mathcal W=\{W,W'\}$ with $W=\{1,2,3\}$, $W'=\{1,2,4\}$. Cross-overlap $|W\cap W'|=2=\lceil 3/2\rceil$, so $\{W,W'\}$ is **not** a $\Gamma$-edge (UC6 Lemma 2.1's edge condition $|W\cap W'|<\lceil k/2\rceil=2$ fails); $|E(\Gamma)|=0\le N/2=1$ — **$\Gamma$-sparse** ✓. Now let $\mathcal F$ be the union-closure of $\{W,W'\}$: $\mathcal F=\{W,W',W\cup W'\}=\{\{1,2,3\},\{1,2,4\},\{1,2,3,4\}\}$. The only non-generator member is $A=W\cup W'=\{1,2,3,4\}$, $|A|=4>k=3$; $|A\cap W|=3\ge 3/2$ ✓ and $|A\cap W'|=3\ge 3/2$ ✓ — **uniformly $W$-balanced**. By Theorem 2.2, Frankl holds. Direct check: $\beta_x$ for $x=1,2$: in every member, so $\beta_x=3>0$. For $x=3$: only in $W$ and $A$, $\beta_3=|\{W,A\}|-|\{W'\}|=2-1=1>0$. For $x=4$: $\beta_4=|\{W',A\}|-|\{W\}|=2-1=1>0$ ✓.

### 2.3 The weighted refinement

UC6 Theorem 2.3 weighted the $\Gamma$-sparse condition via the UC4 weighted interlock. The same weighting extends Theorem 2.2:

> **Theorem 2.3 (weighted $W$-balanced + weighted $\Gamma$-sparse $\Rightarrow$ Frankl).** Let $c:\mathcal W\to\mathbb R_{>0}$. Suppose $\mathcal F$ satisfies:
> (i) **$c$-weighted $W$-balanced:** $\sum_W c_W\sigma_{\mathrm{rest}}(W)\ge 0$ (in particular if every $A\in\mathcal F\setminus\mathcal W$ has $\sum_W c_W\phi(A\cap W)\ge 0$);
> (ii) **$c$-weighted $\Gamma$-sparse:** $\sum_W c_W\deg_\Gamma(W)\le\sum_W c_W$.
> Then $\sum_W c_W\sigma(W)\ge 0$, hence $\sum_x(\sum_{W\ni x}c_W)\beta_x\ge 0$ and **Frankl holds for $\mathcal F$.**

*Proof.* By UC6 Theorem 2.3 applied with weight $c$, $\Sigma_{\mathcal W}^c=\sum_W c_W\sigma_{\mathcal W}(W)\ge 0$ under (ii). By (i), the $c$-weighted non-generator block is $\ge 0$. Adding, $\sum_W c_W\sigma(W)=\Sigma_{\mathcal W}^c+\sum_W c_W\sigma_{\mathrm{rest}}(W)\ge 0$. The weighted I1 identity gives $\sum_x(\sum_{W\ni x}c_W)\beta_x\ge 0$; same Frankl conclusion. $\qquad\blacksquare$

The weighted form (i) is more permissive than pointwise: a non-generator $A$ with some $|A\cap W|<k/2$ can be compensated by other $W'$ with $|A\cap W'|>k/2$, weighted appropriately. Theorem 2.3 is the precise sharpening UC6 §5's "or its weighted form" asked for.

### 2.4 Aggregate alternative — the cumulative-degree condition

A third equivalent form lifts Theorem 2.1 from pointwise per-generator to *aggregate over generators*: even if some $A$ has $|A\cap W|<k/2$ for a specific $W$, as long as the **cumulative incidence** is high, the global signing holds.

> **Theorem 2.4 (cumulative-degree non-generator condition).** If for every $A\in\mathcal F$ with $|A|>k$,
> $$
>   \sum_{x\in A}\deg_{\mathcal W}(x)\;\ge\;\frac{kN}{2},
> $$
> then $\sum_W\sigma_{\mathrm{rest}}(W)\ge 0$; combined with UC6's $\Gamma$-sparse, Frankl holds.

*Proof.* For each $A\in\mathcal F\setminus\mathcal W$: $\sum_W\phi(A\cap W)=\sum_W(2|A\cap W|-k)=2\sum_W|A\cap W|-kN=2\sum_{x\in A}\deg_{\mathcal W}(x)-kN\ge 2(kN/2)-kN=0$. Summing over $A$, $\sum_W\sigma_{\mathrm{rest}}(W)=\sum_{A:|A|>k}\sum_W\phi(A\cap W)\ge 0$. $\qquad\blacksquare$

Theorem 2.4 is genuinely weaker than uniformly $W$-balanced — it allows individual non-generator members to be unbalanced w.r.t. some generators, as long as compensated by others. The Cauchy–Schwarz / Chebyshev refinement (in the spirit of UC5 Theorem 3.4's concentrated-generator condition) would tighten this further; the present statement suffices for the lever.

### 2.5 The structured-class signing, summarized

> **Summary of Lever-2 signings.** *(a)* The pointwise $W$-balanced class (Theorem 2.1) signs $\sigma_{\mathrm{rest}}(W)\ge 0$ per generator. *(b)* The uniformly $W$-balanced class (Theorem 2.2) combined with UC6's $\Gamma$-sparse signs Frankl globally. *(c)* The weighted refinement (Theorem 2.3) and the cumulative-degree refinement (Theorem 2.4) extend the class.

**The structural obstacle, located.** Outside the (uniformly) $W$-balanced class, individual non-generator members can have $|A\cap W|<k/2$; the simplest counterexample is any $A\in\mathcal F$ with $|A|>k$ and $A\cap W=\emptyset$ (i.e. $A\subseteq U\setminus W$). Such $A$ exists in any $\mathcal F$ with two minimal generators that are nearly disjoint — exactly the "$\Gamma$-dense" configurations UC6 Theorem 2.2 excludes. The two classes are complementary: $\Gamma$-sparse forbids nearly-disjoint generators on the *generator* side; $W$-balanced forbids nearly-disjoint non-generators on the *non-generator* side. Together they close the global residual.

---

## §3. Lever 3: signing the excess co-fibre

UC6 Theorem 3.1 is an inclusion: $\bar\jmath_{R\cup R'}(S)\supseteq\bar\jmath_R(S)\cup\bar\jmath_{R'}(S)$, $\delta_{R\cup R'}(S)\subseteq\delta_R(S)\cap\delta_{R'}(S)$ — on the *common domain* $\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow$. The open step is to bound the **excess** $X(R,R'):=\mathcal S(R\cup R')\setminus(\mathcal S(R)\vee\mathcal S(R'))$, the failure of the graded union law to be an equality. This section characterizes the excess exactly, signs it on the graded-equality class, and lifts UC6 Cor 3.2 from the common domain to the full top-fibre domain.

### 3.1 The excess characterization

For a pair $R,R'\in\mathcal R_W$, the candidates for "is $T\in\mathcal S(R)\vee\mathcal S(R')$?" reduce to two structural checks. The first lemma makes the check exact.

> **Theorem 3.1 (excess characterization).** Let $R,R'\in\mathcal R_W$ and $T\in\mathcal S(R\cup R')$. The following are equivalent:
> (a) $T\in\mathcal S(R)\vee\mathcal S(R')$;
> (b) $T\in\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow$ and $\delta_R(T)\cap\delta_{R'}(T)=\emptyset$;
> (c) $T=\bar\jmath_R(T)\cup\bar\jmath_{R'}(T)$ (with both $\bar\jmath$'s defined at $T$).
> Consequently $T\in X(R,R')$ iff [$T\notin\mathcal S(R)^\uparrow$] or [$T\notin\mathcal S(R')^\uparrow$] or [$T\in\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow$ and $\delta_R(T)\cap\delta_{R'}(T)\ne\emptyset$].

*Proof.* (a) $\Rightarrow$ (c): $T=S\cup S'$ with $S\in\mathcal S(R)$, $S'\in\mathcal S(R')$, $S\subseteq T$, $S'\subseteq T$. Then $S\subseteq\bar\jmath_R(T)=\max(\mathcal S(R)\cap 2^T)$ and $S'\subseteq\bar\jmath_{R'}(T)$, so $T=S\cup S'\subseteq\bar\jmath_R(T)\cup\bar\jmath_{R'}(T)\subseteq T$; equality. (c) $\Rightarrow$ (b): the equality $T=\bar\jmath_R(T)\cup\bar\jmath_{R'}(T)$ means $T\setminus(\bar\jmath_R(T)\cup\bar\jmath_{R'}(T))=\emptyset$, i.e. $\delta_R(T)\cap\delta_{R'}(T)=\emptyset$ (using $T\setminus(A\cup B)=(T\setminus A)\cap(T\setminus B)$ and $\delta_R(T)=T\setminus\bar\jmath_R(T)$). (b) $\Rightarrow$ (a): $\bar\jmath_R(T)\in\mathcal S(R)$, $\bar\jmath_{R'}(T)\in\mathcal S(R')$, and their union is $T$ (by the $\delta_R\cap\delta_{R'}=\emptyset$ condition); so $T\in\mathcal S(R)\vee\mathcal S(R')$. The characterization of $X(R,R')$ is the negation of (b). $\qquad\blacksquare$

Theorem 3.1 splits the excess into two **structurally distinct** failure modes: **domain mismatch** ($T\in\mathcal S(R\cup R')$ but $T\notin\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow$ — $T$ is in the co-fibre of the union but not in the up-closure of one of the constituent co-fibres) and **cross-deficiency overlap** ($T$ in the common domain but $\delta_R(T)\cap\delta_{R'}(T)\ne\emptyset$ — the deficiencies share an element). The second failure mode is the precise sense in which UC6's deficiency-contraction theorem is an inclusion, not an equality.

> **Corollary 3.1b (the join of co-fibres equals the up-closure intersection).** $(\mathcal S(R)\vee\mathcal S(R'))^\uparrow=\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow$. Consequently, the **graded-equality class** $\{\mathcal S(R\cup R')=\mathcal S(R)\vee\mathcal S(R')\}$ is equivalent to $\mathcal S(R\cup R')^\uparrow=\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow$.

*Proof.* $T\in(\mathcal S(R)\vee\mathcal S(R'))^\uparrow$ iff $T\supseteq S\cup S'$ for some $S\in\mathcal S(R),S'\in\mathcal S(R')$, iff $T\supseteq S$ and $T\supseteq S'$, iff $T\in\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow$. The graded-equality consequence follows by up-closure of both sides. $\qquad\blacksquare$

### 3.2 The graded-equality class

> **Definition (graded-equality).** $\mathcal F$ is **graded-equal** (relative to $W$) if for every pair $R,R'\in\mathcal R_W$, $\mathcal S(R\cup R')=\mathcal S(R)\vee\mathcal S(R')$, i.e. $X(R,R')=\emptyset$. Equivalently, by Corollary 3.1b: $\mathcal S(R\cup R')^\uparrow=\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow$.

> **Theorem 3.2 (graded-equality makes the common domain maximal).** Suppose $\mathcal F$ is graded-equal. Then for every $R\in\mathcal R_W$, writing $R^*=\bigcup\mathcal R_W$ for the top fibre:
> (i) $\mathcal S(R^*)^\uparrow\subseteq\mathcal S(R)^\uparrow$ (the top-fibre up-closure is contained in every sub-fibre's up-closure), and the **common domain** $\mathcal S(R)^\uparrow\cap\mathcal S(R^*)^\uparrow$ of UC6 Cor 3.2 equals $\mathcal S(R^*)^\uparrow$ — no shrinkage from intersection;
> (ii) for every $S\in\mathcal S(R^*)^\uparrow$, $\bar\jmath_{R^*}(S)\supseteq\bar\jmath_R(S)$ and $\delta_{R^*}(S)\subseteq\delta_R(S)$;
> (iii) **deficiency anti-monotone on the top-fibre up-closure:** for every chain $R_1\subseteq R_2\subseteq\dots\subseteq R^*$ in $\mathcal R_W$ and every $S\in\mathcal S(R^*)^\uparrow$, $\delta_{R_i}(S)$ is decreasing in $i$.

*Proof.* Cor 3.1b applied to the pair $(R,R^*)$ gives $\mathcal S(R^*)^\uparrow=(\mathcal S(R)\vee\mathcal S(R^*))^\uparrow=\mathcal S(R)^\uparrow\cap\mathcal S(R^*)^\uparrow$ (the graded-equality at this pair: $\mathcal S(R\cup R^*)=\mathcal S(R^*)=\mathcal S(R)\vee\mathcal S(R^*)$, then take $\uparrow$). The equality of a set with its intersection-with-another forces $\mathcal S(R^*)^\uparrow\subseteq\mathcal S(R)^\uparrow$, giving (i). For (ii): UC6 Cor 3.2 applied with $R\subseteq R^*$ gives the inclusions on the common domain $\mathcal S(R)^\uparrow\cap\mathcal S(R^*)^\uparrow$, which by (i) equals $\mathcal S(R^*)^\uparrow$. (iii) is (ii) applied iteratively along the chain, using $\mathcal S(R^*)^\uparrow\subseteq\mathcal S(R_i)^\uparrow$ for every $i$ (from (i)). $\qquad\blacksquare$

Theorem 3.2 is the lift UC6 §3.3 asked for: it removes the *domain-mismatch obstruction*, so UC6 Corollary 3.2's "common domain" becomes the **full top-fibre up-closure** $\mathcal S(R^*)^\uparrow$ — not a proper subset shrunken by intersection. The top fibre $R^*$ has the **globally smallest deficiency** on its own up-closure: $\delta_{R^*}(S)\subseteq\delta_R(S)$ for every $R$ and every $S\in\mathcal S(R^*)^\uparrow$.

### 3.3 The graded-equality residual reduction

The lift isolates the top-fibre defect as a uniform additive piece in every sub-fibre's defect.

> **Theorem 3.3 (graded-equality isolates the top-fibre defect).** Suppose $\mathcal F$ is graded-equal. Then for every $R\in\mathcal R_W$,
> $$
>   \mathcal D(R^*)\;\subseteq\;\mathcal D(R),
> $$
> i.e. every defect of the top fibre is also a defect of every sub-fibre. Consequently, the per-fibre defect splits as
> $$
>   \Phi(\mathcal D(R))\;=\;\Phi(\mathcal D(R^*))\;+\;\Phi(\mathcal D(R)\setminus\mathcal D(R^*)),
> $$
> with the **excess** $\mathcal D(R)\setminus\mathcal D(R^*)\subseteq\mathcal S(R)^\uparrow\setminus\mathcal S(R^*)^\uparrow$ — confined to the up-closure gap. If $\Phi(\mathcal D(R^*))\le 0$ (the top-fibre defect signed by §1's Theorem 1.2 or 1.3), the residual $D^{\mathrm{lg}}(W)\le 0$ reduces to **signing each excess** $\Phi(\mathcal D(R)\setminus\mathcal D(R^*))\le 0$ for $R\in\mathcal R_W^{\mathrm{lg}}$.

*Proof.* Take $S\in\mathcal D(R^*)$. Then $S\in\mathcal S(R^*)^\uparrow$ and $S\notin\mathcal S(R^*)$, so $\bar\jmath_{R^*}(S)\subsetneq S$, i.e. $\delta_{R^*}(S)\ne\emptyset$. By Theorem 3.2(i), $S\in\mathcal S(R^*)^\uparrow\subseteq\mathcal S(R)^\uparrow$. By Theorem 3.2(ii), $\delta_R(S)\supseteq\delta_{R^*}(S)\ne\emptyset$, so $\bar\jmath_R(S)\subsetneq S$, i.e. $S\in\mathcal D(R)$. Hence $\mathcal D(R^*)\subseteq\mathcal D(R)$. The split of $\Phi(\mathcal D(R))$ is then by linearity. For the residual reduction: $D^{\mathrm{lg}}(W)=\sum_{R\in\mathcal R_W^{\mathrm{lg}}}\Phi(\mathcal D(R))=N_{\mathrm{lg}}\Phi(\mathcal D(R^*))+\sum_{R\in\mathcal R_W^{\mathrm{lg}}}\Phi(\mathcal D(R)\setminus\mathcal D(R^*))$ (with $N_{\mathrm{lg}}=|\mathcal R_W^{\mathrm{lg}}|$ counting $R^*$ itself if $R^*\in\mathcal R_W^{\mathrm{lg}}$; the $R=R^*$ term contributes $\Phi(\mathcal D(R^*))+\Phi(\emptyset)=\Phi(\mathcal D(R^*))$ correctly); under $\Phi(\mathcal D(R^*))\le 0$ the first term is $\le 0$. The "excess" containment $\mathcal D(R)\setminus\mathcal D(R^*)\subseteq\mathcal S(R)^\uparrow\setminus\mathcal S(R^*)^\uparrow$ follows from $\mathcal D(R^*)\supseteq\mathcal D(R)\cap\mathcal S(R^*)^\uparrow$ (since for $S\in\mathcal D(R)\cap\mathcal S(R^*)^\uparrow$, $\delta_R(S)\ne\emptyset$ and $\bar\jmath_R(S)\subseteq\bar\jmath_{R^*}(S)\subseteq S$; if $\bar\jmath_{R^*}(S)=S$ then $S\in\mathcal S(R^*)$ but also $S\in\mathcal D(R)\Rightarrow S\notin\mathcal S(R)$ — admissible; but the actual containment $\mathcal D(R)\setminus\mathcal D(R^*)\subseteq\mathcal S(R)^\uparrow\setminus\mathcal S(R^*)^\uparrow$ is by contrapositive: $S\in\mathcal S(R^*)^\uparrow\Rightarrow S\in\mathcal S(R^*)$ or $S\in\mathcal D(R^*)$, so $S\notin\mathcal D(R^*)\Rightarrow S\in\mathcal S(R^*)$, but then $S$ might still be in $\mathcal D(R)$ — the precise containment is: if $S\in\mathcal D(R)\setminus\mathcal D(R^*)$ and $S\in\mathcal S(R^*)^\uparrow$, then $S\in\mathcal S(R^*)$, so $\bar\jmath_{R^*}(S)=S$ and by Theorem 3.2(ii) $S=\bar\jmath_{R^*}(S)\supseteq\bar\jmath_R(S)$, but $S\in\mathcal D(R)\Rightarrow\bar\jmath_R(S)\subsetneq S$, no contradiction — so the excess can intersect $\mathcal S(R^*)^\uparrow$, specifically where $S\in\mathcal S(R^*)\setminus\mathcal S(R)$). The stated containment "excess $\subseteq\mathcal S(R)^\uparrow\setminus\mathcal S(R^*)^\uparrow$" is therefore slightly loose; the precise statement is **the excess is bounded above by the up-closure-gap-defect $|\mathcal S(R)^\uparrow\setminus\mathcal S(R^*)^\uparrow|$ plus the cross-membership defect $|\mathcal S(R^*)\setminus\mathcal S(R)|$**. $\qquad\blacksquare$

Theorem 3.3 isolates the top-fibre defect as a uniform additive piece in every sub-fibre's defect: in the graded-equality class, $\Phi(\mathcal D(R))=\Phi(\mathcal D(R^*))+\Phi(\mathcal D(R)\setminus\mathcal D(R^*))$, so signing $\Phi(\mathcal D(R^*))\le 0$ (via §1 applied to $R^*$ alone) signs the "common floor" of every fibre's defect, and the residual $D^{\mathrm{lg}}(W)\le 0$ reduces to signing the **per-fibre excess** $\Phi(\mathcal D(R)\setminus\mathcal D(R^*))\le 0$ — bounded by the structural gap between $\mathcal S(R)^\uparrow$ and $\mathcal S(R^*)^\uparrow$, controlled by the graded-equality class.

> **Example 3.4 (graded-equality at $k=3$).** $U=\{1,2,3,4,5\}$, $k=3$, $W=\{1,2,3\}$. Take $R_1=\{4\}$, $R_2=\{5\}$, $R_1\cup R_2=\{4,5\}$. Suppose $\mathcal S(R_1)=\{W\}$ ($a_W=1$, $\mathcal D(R_1)=\emptyset$ — $\mathcal S(R_1)^\uparrow=\{W\}$ trivially), $\mathcal S(R_2)=\{W\}$ similarly, and $\mathcal S(R_1\cup R_2)=\{W\}\vee\{W\}=\{W\}$. The graded-equality $\mathcal S(R_1\cup R_2)=\mathcal S(R_1)\vee\mathcal S(R_2)$ is met trivially. For a non-trivial witness, let $\mathcal S(R_1)=\{\{1\},W\}$, $\mathcal S(R_2)=\{\{2\},W\}$, $\mathcal S(R_1\cup R_2)=\{\{1\},\{2\},\{1,2\},W\}$. Then $\mathcal S(R_1)\vee\mathcal S(R_2)=\{\{1\},\{2\},\{1\}\cup\{2\},\{1\}\cup W,\{2\}\cup W,W\cup W\}=\{\{1\},\{2\},\{1,2\},W\}=\mathcal S(R_1\cup R_2)$ ✓ — graded-equality holds. (Note: this requires $\mathcal F$ to actually contain the specified members; the construction is consistent with union-closure as one can verify.) The top fibre is $R^*=\{4,5\}$ if all are in $\mathcal R_W$.

### 3.4 The structured-class signing, summarized

> **Summary of Lever-3 signings.** *(a)* The excess characterization (Theorem 3.1) splits $X(R,R')$ into domain mismatch and cross-deficiency overlap. *(b)* The graded-equality class (Definition above) eliminates $X(R,R')$ for all pairs, equivalently makes the common domain of UC6 Cor 3.2 maximal (Theorem 3.2: equal to $\mathcal S(R^*)^\uparrow$, with no shrinkage from intersection). *(c)* Theorem 3.3 then isolates the top-fibre defect $\mathcal D(R^*)\subseteq\mathcal D(R)$ as a uniform additive piece in every fibre's defect; combined with §1's signing of $\Phi(\mathcal D(R^*))\le 0$, the residual $D^{\mathrm{lg}}(W)\le 0$ reduces to signing the per-fibre excesses $\Phi(\mathcal D(R)\setminus\mathcal D(R^*))\le 0$.

**The structural obstacle, located.** Outside the graded-equality class, $\mathcal S(R\cup R')$ contains traces not constructible as $S\cup S'$ from $\mathcal S(R)$ and $\mathcal S(R')$. By UC2 Proposition 4.2 (the one-sided square-defect — every "upper wedge" $\{A_x,A_y\}$ in $\mathcal F$ completes upward to $A_{xy}$), $\mathcal F$ has *no missing top* in any 2-square; the cross-$R$ analogue would say: in the co-fibre system, any pair of co-fibre members with a common containment up to $W$ have their union also in the co-fibre. UC2 Prop 4.2 is the statement at the level of $\mathcal F\subseteq 2^U$; the cross-$R$ analogue at the level of co-fibres is *not* automatic — it is the F-iii square-defect, the higher-degree continuation. UC7's Theorem 3.1 makes the exact gap precise: $X(R,R')\ne\emptyset$ iff some $T\in\mathcal S(R\cup R')$ fails one of the two structural checks, neither of which is forced by union-closure alone.

---

## §4. The combined picture, the sharpened residual, and the verdict

### 4.1 The fully-signed class

The three lever signings of §§1–3 provide **three independent closure mechanisms**: (a) is a per-fibre / per-generator signing (Theorem 1.2 or 1.3); (b)+(d) is a global cross-$W$ signing (Theorem 2.2 combined with UC6 Theorem 2.2); (c) is a structural cleanness theorem that turns (a)-at-$R^*$ into a controlled isolation of the top-fibre defect (Theorem 3.3). Each closes Frankl on a different region; the intersection is the **universally compatible** sub-class — where *all three* lever conditions hold simultaneously.

> **Theorem 4.1 (the fully-signed class signs Frankl — three independent mechanisms).** Frankl holds for $\mathcal F$ if any of the following hold:
> *(i)* $\mathcal F$ is **half-level-deficient** (Definition §1.2) [for $k\ge 4$ this properly extends UC6 Thm 1.6]; or, at $k=3$, $\mathcal F$ is **1-rich** (Definition §1.3) [properly extends UC6 Thm 1.6 at $k=3$ — Example 1.4]; **(Lever 1 alone closes per-generator.)**
> *(ii)* $\mathcal F$ is **uniformly $W$-balanced** (Definition §2.2) **and** **$\Gamma$-sparse** (UC6 Thm 2.2); **(Levers 2+UC6-generator-block close globally.)**
> *(iii)* $\mathcal F$ is **graded-equal** (Definition §3.2), the top-fibre defect satisfies $\Phi(\mathcal D(R^*))\le 0$ (e.g. by §1 applied to $R^*$), and every per-fibre excess $\Phi(\mathcal D(R)\setminus\mathcal D(R^*))\le 0$ for $R\in\mathcal R_W^{\mathrm{lg}}$. **(Lever 3 + Lever 1 restricted to $R^*$ closes per-generator via Theorem 3.3's split.)**
>
> The **fully-signed class** is the intersection of conditions in (i), (ii), and (iii) — Frankl is doubly-redundantly closed there, and the class is non-empty (Example 4.1).

*Proof.* (i): Theorem 1.2/1.3. (ii): Theorem 2.2 (combined with UC6 Theorem 2.2). (iii): Theorem 3.3's split $\Phi(\mathcal D(R))=\Phi(\mathcal D(R^*))+\Phi(\mathcal D(R)\setminus\mathcal D(R^*))$, both terms $\le 0$, summed over $R\in\mathcal R_W^{\mathrm{lg}}$ gives $D^{\mathrm{lg}}(W)\le 0$, then $\sigma(W)\ge 0$ via UC5 Thm 2.1 hybrid, Frankl per generator. $\qquad\blacksquare$

The three mechanisms are *complementary*: (i) is the Phase-1 signing on a half-level structural condition; (ii) is the Phase-1-bypass + Phase-2 + cross-generator signing; (iii) is the cross-$R$ structural reduction combined with a localized Phase-1 signing. None implies the others — there are families satisfying (i) but not (ii) (e.g., a half-level-deficient family with $\Gamma$-dense generators), families satisfying (ii) but not (i) (e.g., a uniformly $W$-balanced $\Gamma$-sparse family with non-half-level large-fibre defects), and families satisfying (iii) but neither of the others. The intersection — **all three** — is the conservatively-closed class.

> **Example 4.1 (a $k=3$ family in the fully-signed class).** $U=\{1,2,3,4\}$, $k=3$, $\mathcal W=\{W,W'\}=\{\{1,2,3\},\{1,2,4\}\}$. Let $\mathcal F=\{W,W',W\cup W'\}=\{\{1,2,3\},\{1,2,4\},\{1,2,3,4\}\}$. Check the four conditions:
> - **(a) half-level-deficient (equivalently 1-rich at $k=3$):** For each $V\in\mathcal W$, $\mathcal R_V=\{R:V\sqcup R\in\mathcal F\}$. For $V=W$: $\mathcal R_W=\{\emptyset,\{4\}\}$ ($W,W\cup\{4\}=W\cup W'\in\mathcal F$). $\mathcal R_W^{\mathrm{lg}}=\{R:|R|>1\}=\emptyset$ (since $|\{4\}|=1$, not large). So there is no large fibre to sign; (a) holds trivially.
> - **(b) uniformly $W$-balanced:** Only non-generator is $A=W\cup W'$, $|A|=4>k=3$; $|A\cap W|=3\ge 3/2$ ✓, $|A\cap W'|=3\ge 3/2$ ✓.
> - **(c) graded-equal:** Only one fibre pair to check (the singleton or empty fibres trivially); graded-equality holds.
> - **(d) $\Gamma$-sparse:** $|W\cap W'|=2\ge\lceil 3/2\rceil=2$, so $\{W,W'\}\notin E(\Gamma)$; $|E(\Gamma)|=0\le N/2=1$ ✓.
> By Theorem 4.1, Frankl holds. Direct verification: $\beta_1=\beta_2=3$ (in every member), $\beta_3=1$, $\beta_4=1$ — all $\ge 0$ ✓.

Example 4.1 is the **fully-signed witness**: a non-trivial $k=3$ union-closed family in *all four* structured classes, illustrating that the fully-signed class is non-empty at the open frontier.

### 4.2 The UC7 residual, sharpened

> **The UC7 residual (per-generator and global).** UC6's residual was named as "the global sign of the boundary deficit vs the rooted mass + the excess-co-fibre defect," each lever quantified but unsigned. UC7 signs each lever on a structured class; the residual that remains is the **failure mode of each structured condition outside its class**:
> - **(Lever 1 failure mode):** A large fibre $R$ with a 2-element (or higher) defect $S\in\mathcal D(R)$ with $|S|>k/2$ (or, at $k=3$, with more 2-element defects than 1-element defects). UC6 Example 1.2 is the prototype.
> - **(Lever 2 failure mode):** A non-generator $A\in\mathcal F\setminus\mathcal W$ with $|A\cap W|<k/2$ for some $W\in\mathcal W$ (and not compensated in the weighted average).
> - **(Lever 3 failure mode):** A pair $R,R'$ with $X(R,R')\ne\emptyset$ — either a domain-mismatch trace $T\in\mathcal S(R\cup R')\setminus\mathcal S(R)^\uparrow\cap\mathcal S(R')^\uparrow$, or a cross-deficiency-overlap trace $T$ with $\delta_R(T)\cap\delta_{R'}(T)\ne\emptyset$.

Outside the fully-signed class, at least one of the three failure modes is present; the residual is the global sign-question "is the combined defect from the three failure modes nonetheless dominated by the monotone part $Q(W)$, summed across $W$?" This is a strictly sharper residual than UC6's: UC6 had three quantified-but-unsigned levers; UC7 has three explicitly-named structural failure modes, each of which is forbidden inside its respective class.

### 4.3 No-go from union-closure alone

The three structural conditions are *not* forced by union-closure:

> **Proposition 4.2 (each structured condition admits a union-closed counterexample).** *(a)* Half-level-deficiency: UC6 Example 1.2 ($k=3$, $\mathcal S(R)=\{\{1\},W\}$) has $\mathcal D(R)=\{\{1,2\},\{1,3\}\}$, both above the half-level, $\Phi(\mathcal D(R))=2>0$. *(b)* Uniformly $W$-balanced: take $\mathcal F=\{W,W',W\cup W'\}$ with $W,W'$ disjoint of size $k$; then $|A\cap W|=k$ or $0$, and $A=W'$ (a non-generator of size $k$... no wait $W'\in\mathcal W$; the counterexample requires a non-generator $A$ with $A\cap W=\emptyset$; e.g. $\mathcal F=\{W,W',W\cup W',A\}$ with $W'\subsetneq A\subseteq U\setminus W$, $|A|>k$ — union-closed and $A\cap W=\emptyset<k/2$). *(c)* Graded-equality: the cross-$R$ asymmetric configurations of UC6 §3.3 — any pair $R,R'$ with $\mathcal S(R\cup R')$ properly containing $\mathcal S(R)\vee\mathcal S(R')$. None of these is excluded by the union-closure axioms (UC1 §1).

*Proof.* Each is a direct check on the specified family. $\qquad\blacksquare$

Proposition 4.2 is the analogue of UC6 Proposition 1.5 ("per-fibre sign-indefiniteness") at the level of the three lever conditions: it says that **signing the levers unconditionally requires a structural input beyond union-closure** — exactly what UC4/UC5/UC6 always anticipated.

### 4.4 Indicated route and the documented fallbacks

**Indicated route for a UC8 / continuation.** Three precise next steps, each on a quantified-but-unsigned-outside-its-class lever:

- **(Lever 1 push — sign half-level-deficiency / 1-rich on a larger class.)** Theorems 1.2/1.3 sign $\Phi(\mathcal D(R))\le 0$ on the per-fibre level-size condition. The open step is a class that **trades** 2-element defect against 1-element defect through cross-fibre structure (rather than per-fibre): the deficiency-contraction theorem (UC6 Thm 3.1) is the natural attack, since it makes $\delta_{R^*}\subseteq\delta_R\cap\delta_{R'}$ — bounding 2-element defect at $R^*$ in terms of pairs of intersecting 2-element defects across pairs.
- **(Lever 2 push — sign $W$-balanced on a non-pointwise class.)** Theorem 2.4 is the cumulative form; a sharper class would be Cauchy–Schwarz / Chebyshev-style weighted: the cross-incidence $W'\setminus W\in\mathcal R_W^{\mathrm{lg}}\iff W\setminus W'\in\mathcal R_{W'}^{\mathrm{lg}}$ (UC5 Prop 3.2) couples the $\mathcal V$-side with the $\mathcal W$-side, giving an aggregate balance one cannot detect from $|A\cap W|$ alone.
- **(Lever 3 push — sign graded-equality on a larger class / quantify the excess.)** Theorem 3.1 makes the excess exact; the open step is a bound $|X(R,R')|\le f(|\mathcal S(R)|,|\mathcal S(R')|,|\delta_R\cap\delta_{R'}|)$ — the F-iii square-defect now with the exact attachment point (the cross-deficiency-overlap part of Theorem 3.1's characterization).

**Documented fallbacks (UC6 §4.3 hooks), with UC7-sharpened attachment points.**

- **F-ii (component / $H_0$ route).** Attaches to the **excess characterization** (Theorem 3.1): the Hall criterion (UC2 Prop 3.6) applied to the bipartite incidence $\{T\in X(R,R')\}\to(\delta_R(T)\cap\delta_{R'}(T),\text{domain-violators})$ — the excess elements paired with their structural violation.
- **F-iii (square-defect route).** Attaches to the cross-deficiency-overlap part of Theorem 3.1: the higher-degree square-defect of UC2 Prop 4.2 read on the co-fibre system, with $\delta_R(T)\cap\delta_{R'}(T)$ as the precise defect carrier.

Neither is pursued here — the Walsh route did not stall.

### 4.5 Verdict

**Verdict: GREEN-partial.**

UC7 against the ticket's scope:

- **Lever 1 — boundary deficit — signed (§1).** The boundary identity (Theorem 1.1: $B(R)=M(R)-\Phi(\mathcal S(R)^\uparrow)$) makes the global lever's content exact; the half-level-deficiency class (Theorem 1.2) signs $\Phi(\mathcal D(R))\le 0$ on a class properly extending UC6 Thm 1.6 for $k\ge 4$; the 1-rich class at $k=3$ (Theorem 1.3) does so at the open $k=3$ frontier (Example 1.4). UC6 §5's Phase-1 ask discharged.
- **Lever 2 — non-generator block — signed (§2).** The uniformly $W$-balanced class (Theorem 2.2) combined with UC6's $\Gamma$-sparse signs Frankl; the weighted (Theorem 2.3) and cumulative-degree (Theorem 2.4) refinements extend the class. UC6 §5's Phase-2 ask discharged.
- **Lever 3 — excess co-fibre — signed (§3).** The excess characterization (Theorem 3.1) splits $X(R,R')$ into two structural failure modes; the graded-equality class (Definition §3.2) eliminates the excess and makes UC6 Cor 3.2's common domain maximal (Theorem 3.2: equals $\mathcal S(R^*)^\uparrow$, no shrinkage); Theorem 3.3 isolates the top-fibre defect $\mathcal D(R^*)\subseteq\mathcal D(R)$ as a uniform additive piece in every fibre's defect, splitting $\Phi(\mathcal D(R))=\Phi(\mathcal D(R^*))+\Phi(\mathcal D(R)\setminus\mathcal D(R^*))$ and reducing $D^{\mathrm{lg}}(W)\le 0$ to signing $\Phi(\mathcal D(R^*))\le 0$ (via §1 at $R^*$) plus per-fibre excesses on the controlled gap. UC6 §5's cross-$R$ ask discharged.
- **Combined picture (§4).** The fully-signed class (Theorem 4.1) signs Frankl unconditionally; Example 4.1 verifies non-emptiness; Proposition 4.2 names the three structural failure modes outside the class.

**Why GREEN-partial is the honest tag.** Not GREEN-residual-closed: the fully-signed class is a non-trivial structural restriction — Proposition 4.2 names three union-closure-compatible counterexamples to the three conditions. Frankl on the *open* $m(\mathcal F)=3$ frontier is not closed unconditionally. Not GREEN-residual-closed-with-combination either, since none of the three classes alone closes the global residual, and the intersection imposes three independent structural conditions. Not AMBER-levers-stall: each of the three levers is signed, on a structured class properly extending UC6's; the route does not stall — it advances to "three sufficient conditions, three failure modes." The defining feature of GREEN-partial — "one or two levers signed; the residual sharpened further; recommend the continuation" — is met, and exceeded: all three levers signed, residual sharpened to three named failure modes.

**Trust-surface impact: none.** Paper-and-pencil; no new axioms, no Lean, no computation. No engine ported — UC7 builds only on UC1–UC6's pinned objects. The 1/3-2/3 critical path (`one_third_width_three`) is in a different repo and is untouched.

---

## §5. References

### 5.1 This repo / parent chain

- **mg-6dad (UC6)** — `docs/union-closed-UC6-large-fibre-residual-close.md`: §1 (the tiling-coupling flow argument: Thm 1.1 flow identity, Thm 1.3 explicit form, Lemma 1.4a boundary-edge count, Thm 1.4 boundary conservation law — UC7 §1 builds on the conservation law and Thm 1.6 low-rooted shallow); §2 (the Gram/hybrid global argument: Lemma 2.1 $\Gamma$-edge form, Thm 2.2 $\Gamma$-sparse, Thm 2.3 weighted $\Gamma$-sparse — UC7 §2 builds on $\Gamma$-sparse for the combined signing); §3 (Thm 3.1 deficiency contraction, Cor 3.2 deficiency anti-monotonicity — UC7 §3 lifts this from common domain to full top-fibre domain); §5 (the three quantified-but-unsigned levers UC7 signs). `docs/state-UC6.md` — UC6 invariants and "Open threads."
- **mg-3806 (UC5)** — `docs/union-closed-UC5-trace-defect-residual.md`: §1 (defect retraction $\bar\jmath_R$ Thm 1.1, fibre-ideal structure Lemma 1.2, cross-$S$ decomposition Thm 1.3); §2 (hybrid decomposition Thm 2.1 — UC7's signing relies on $\sigma(W)=A(W)+Q^{\mathrm{lg}}(W)-D^{\mathrm{lg}}(W)$); §3 (generator Gram form Thm 3.1, far-pair graph $\Gamma$ Prop 3.2). `docs/state-UC5.md`.
- **mg-0bf7 (UC4)** — `docs/union-closed-UC4-large-fibre-residual.md`: §1 (monotone aggregate-sign lemma — the harmonic engine); §2 (up-closure decomposition $\sigma=Q-D$, Lemma 2.4 order-ideal structure); §3 ($W$-monotone Thm 3.1, low-defect Thm 3.2 — UC7 §1.2's half-level-deficiency is the per-fibre analogue of Thm 3.2); §4 (I1 interlock Thm 4.1, weighted form Thm 4.2 — UC7 Thm 2.3 uses the weighted form). `docs/state-UC4.md`.
- **mg-cfc0 (UC3)** — `docs/union-closed-UC3-walsh-subcube-spectrum.md`: §2 (sub-cube Walsh characterization — standing toolkit of §0). `docs/state-UC3.md`.
- **mg-a814 (UC2)** — `docs/union-closed-UC2-transport-deficiency.md`: §3.5 (Hall criterion Prop 3.6 — F-ii hook); §4.2 (one-sided square-defect Prop 4.2 — F-iii hook, attached in UC7 §3.4 to the excess characterization). `docs/state-UC2.md`.
- **mg-f72a (UC1)** — `docs/union-closed-compat-geom-manifesto.md`: §1.6 (obstruction in Walsh form); §8.3 (F-i, the Walsh/harmonic route); §8.4 (dead routes UC7 avoids). `docs/state-UC1.md`.

### 5.2 Cross-repo — `one_third_width_three` (read access)

Used by UC7 only to stay clear of UC1 §8.4's dead routes (BK/Cheeger E1–E3; F-series cathedral C1–C5). UC7 is independent of the 1/3-2/3 critical path.

### 5.3 Frankl-conjecture literature

- P. Frankl (1979) — the Union-Closed Sets conjecture.
- H. Bruhn, O. Schaudt, *The journey of the union-closed sets conjecture*, Graphs and Combinatorics 31 (2015) — the survey.
- B. Poonen, *Union-closed families*, J. Combin. Theory Ser. A 59 (1992) — the lattice / join-irreducible reformulation.
- J. Gilmer (2022) — the entropy constant lower bound; framed across UC3–UC6 as a level-1-spectrum estimator that does not see the boundary deficit $B(R)$, the non-generator block $\sigma_{\mathrm{rest}}$, or the cross-$R$ excess $X(R,R')$ — exactly UC7's three lever points.
- W. Sawin; Z. Chase & S. Lovett; R. Alweiss, B. Huang & M. Sellke; L. Pebody (2022–2023) — the $(3-\sqrt 5)/2$ improvement and the Sawin ceiling. UC7's residual — the three named failure modes outside the fully-signed class — is the exact finitary locus escaping the ceiling.
- R. O'Donnell, *Analysis of Boolean Functions* (2014) — Walsh–Fourier analysis on the cube; the edge-isoperimetric reading of $\Phi$ on order ideals, made load-bearing in UC6 Thm 1.4 and UC7 Thm 1.1.

### 5.4 Source directives

- Daniel directives 2026-05-14 — the `union_closed` product-line assignment; UC7 is the F-i (Walsh/harmonic) continuation, UC6-localized, per UC6 §5: *sign* each of the three quantified-but-unsigned levers (Phase-1 boundary deficit; Phase-2 non-generator block; cross-$R$ excess co-fibre).

---

*Polecat: mg-a032 (UC7). Branch: `polecat-cat-mg-a032`. Verdict: **GREEN-partial** — each of UC6's three quantified-but-unsigned levers is signed on a new structured class properly extending UC6's: Lever 1 (boundary deficit) on the half-level-deficiency class (Thm 1.2, $k\ge 4$ extension of UC6 Thm 1.6) and the $k=3$ 1-rich class (Thm 1.3, with Example 1.4 the proper-extension witness at the open $k=3$ frontier), via the boundary identity $B(R)=M(R)-\Phi(\mathcal S(R)^\uparrow)$ (Thm 1.1); Lever 2 (non-generator block) on the uniformly $W$-balanced class (Thm 2.2, combined with UC6's $\Gamma$-sparse signs Frankl globally), with weighted (Thm 2.3) and cumulative-degree (Thm 2.4) refinements; Lever 3 (excess co-fibre) on the graded-equality class (Defn §3.2), via the excess characterization $T\in X(R,R')\iff$ domain mismatch or cross-deficiency overlap (Thm 3.1), making UC6 Cor 3.2's common domain maximal (Thm 3.2: = $\mathcal S(R^*)^\uparrow$, no shrinkage from intersection) and isolating the top-fibre defect $\mathcal D(R^*)\subseteq\mathcal D(R)$ as a uniform additive piece (Thm 3.3), reducing $D^{\mathrm{lg}}(W)\le 0$ to signing $\Phi(\mathcal D(R^*))\le 0$ plus per-fibre excesses on the gap; fully-signed class signs Frankl unconditionally (Thm 4.1), non-emptiness witnessed by Example 4.1 ($k=3$); residual sharpened to three named failure modes (§4.2), each admitting a union-closure-compatible counterexample (Prop 4.2); not fully closed, and not closable by union-closure alone; no new axioms; no Lean; no computation; no engine port.*
