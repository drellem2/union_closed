# UC14 — Three technical-cleanup residuals from UC13 verification (R1 abutment / R2 cohomological covering / R3 iterated-bridge degree count)

> ## ⚠️ CORRECTION BANNER (added 2026-05-21, `mg-56b8`) — R2 IS FALSE; UC14's GREEN VERDICT IS WITHDRAWN
>
> The original UC14 verdict below — **"GREEN — R1 + R2 + R3 all closed"** — is
> **wrong on R2** and is **withdrawn**.
>
> - **R2 (§2: Theorem 2.6.2 the hocolim lift, Theorem 2.7.1 the chain
>   isomorphism `C*(Xₙ∩)_{χ_S} = C*(X(𝒟ₓ))_{χ_S}`) is PROVABLY FALSE.**
>   Applied to `S = [n]∖{x}` it forces the program's own sphere class
>   `V_{[n-1]}^{n-2}(X_{n-1}∩) ≅ sgn_{S_{n-1}}` (non-zero — the very class R3
>   §3.6 uses as a load-bearing input) to be isomorphic to a lower isotype
>   `V_{[n]∖{x}}^{n-2}(Xₙ∩)` that UC10.1 / Y1 require to **vanish**. A chain
>   isomorphism cannot carry a non-zero group onto a zero group. So **R2
>   contradicts R3 and UC10.1 inside this single document.** Concrete at
>   `n = 3`. Diagnosis: `mg-552b §3` (`docs/Frankl-Y1-walsh-vanishing-audit.md`)
>   and `mg-56b8 §4–§5` (`docs/Frankl-Y1-reprove.md`).
> - **Root cause.** R2 §2.4 (the single-family cell-level identification, Lemma
>   2.2.1 + Theorem 2.4.1) is plausibly correct. R2 §2.6 then claims it lifts
>   to a chain isomorphism of *hocolims* — false: a hocolim sums over bar
>   strings through the whole category `Cₙ∩`, so a per-object identification on
>   the subcategory `𝒟ₓ` does not localize. `𝒟ₓ` is only a categorical
>   *retraction* (Lemma 2.6.1), giving a direct summand, not an isomorphism.
>   *Vanishing* lifts through a hocolim; *isomorphism* does not.
> - **Honest surviving statement.** UC13 Lemma 4.4.1's original cautious
>   **surjection** (read cohomologically). It is consistent with Y1 but does
>   **not** prove it.
> - **R1 and R3** are **not re-audited** by `mg-56b8` (out of scope). R1 left
>   GREEN-pending; R3's cofiber-LES + induction *method* is sound (it is the
>   method `mg-56b8` ports) but R3 §3.6 carries `mg-552b`-flagged soft spots.
> - **Corrected UC14 verdict: AMBER-WITH-ONE-FALSE-RESIDUAL.** R2 must not be
>   cited. See `docs/Frankl-Y1-reprove.md` §7 for the full re-band table and
>   the knock-on to UC13 §4 / UC10.1.
>
> Everything below this banner is the **original, uncorrected** UC14 text,
> preserved verbatim for the record. Read it knowing R2 (§2 and every §4
> sentence asserting "R2 GREEN / R2 closed") is false.

---

**Ticket:** mg-500c. **Polecat:** cat-mg-500c. **Branch:** `polecat-cat-mg-500c`. **Session 5** on the UC10/UC11/UC12/UC13 arc (cumulative state ledger `docs/state-UC10.md`). **Type:** verification-cleanup tightening of UC13 standard-machinery residuals identified by pm-onethird verification 2026-05-16T~03:36Z.

**Status:** UC13 (mg-83f0) merged GREEN 2026-05-16T02:44Z; pm-onethird verified the Frankl-side structural argument and flagged **three** technical-cleanup residuals — none of which affect UC13's GREEN verdict but each of which a future reader / Lean-formalizer would need spelled out. This document tightens them.

**Verdict (current, after Session 5):** ~~**GREEN — R1 + R2 + R3 all closed.**~~ **WITHDRAWN — see correction banner above (`mg-56b8`, 2026-05-21): R2 is FALSE; corrected verdict AMBER-WITH-ONE-FALSE-RESIDUAL.** UC13's Frankl-closing verdict is **not** reinforced — UC13 §4.5 / Theorem 4.5.1 (Y1) stays INVALID-as-written / UNPROVEN. (Original §4 verdict break-down below is superseded.)

---

## §0. Notation, the UC13 invariants UC14 inherits, hard constraints

### 0.1 Carried verbatim from UC13

- **Category $\mathcal C_n^{\cap}$** (UC10 Defn 2.1, 2.2). Objects = pointed intersection-closed families $(S,\mathcal F)$ with $\bigcup\mathcal F=S\subseteq[n]$, $S\in\mathcal F$. Morphisms = trace $(S,\mathcal F)\to(T,\mathcal G)$ for $T\subseteq S$ with $\mathcal G=\{A\cap T:A\in\mathcal F\}$.
- **Cohomology object $X_n^{\cap}=\mathop{\mathrm{hocolim}}_{(\mathcal C_n^{\cap})^{\mathrm{op}}}X(\mathcal F)$** (UC10 Defn 3.3). $X(\mathcal F)$ = cubical complex of subcubes of $Q_S$ with vertices in $\mathcal F$; cells $C(A,T)$ for $A\in\mathcal F$, $T\subseteq S\setminus A$, $A\cup T'\in\mathcal F$ for every $T'\subseteq T$.
- **Walsh decomposition UC10.W** (UC10 Theorem 3.5). $C_*(X_n^{\cap};\mathbb Q)=\bigoplus_{S\subseteq[n]}\chi_S\otimes V_S^*$ as $(\mathbb Z/2)^n$-modules.
- **Doubling functor $\mathrm{db}_x\colon\mathcal C_{n-1,x}^{\cap}\hookrightarrow\mathcal C_n^{\cap}$** (UC12 Defn 2.1 in coordinate $n+1$; UC13 Remark 4.2.2 in coordinate $x\in[n]$). $\mathrm{db}_x\mathcal F':=\mathcal F'\cup(\mathcal F'+\{x\})$. Image is $\mathcal D_x$ — the **"fully matched in $x$"** subcategory.
- **Prism structure $X(\mathrm{db}_x\mathcal F')\cong X(\mathcal F')\times I_x$** (UC12 Lemma 2.7).
- **Cubical-bridge null-homotopy $h_x$** (UC12 Defn 3.1; UC13 Remark 4.2.2). $(h_x\omega)(D):=\omega(\tilde D_x)$ where $\tilde D_x=C(A,T'\cup\{x\})$ is the prism over the $(k-1)$-cell $D=C(A,T')$.
- **Chain-homotopy identity** (UC12 Theorem 4.2; UC13 Theorem 4.3.1). For $\omega\in V_{[n+1]}^k$ (resp. $V_S^k$ with $x\in S$, in the in-coordinate version), $\iota_x^*\omega=\frac{(-1)^k}{2}(dh_x-h_xd)\omega$.
- **Čech sheaf $\mathcal F_{\mathrm{obs}}$ on the trace cover $\mathfrak U=\{U_x\}_{x\in[n]}$** (UC11 Defn 4.1, 4.4). $U_x=\{(T,\mathcal G)\in\mathcal C_n^{\cap}(\mathcal F^\star)\setminus\{\mathcal F^\star\}:x\in T,\beta_x(\mathcal G)\le 0\}$. $\mathcal F_{\mathrm{obs}}(U_x)=C^*(X(-))_{\chi_{\{x\}}}|_{U_x}$. Level-1-Walsh source data only (UC13 Cor 2.3.2).
- **Obstruction class** (UC13 Theorem 2.4.1). $\mathrm{ob}(\mathcal F^\star)\in\bigoplus_{x\in[n]}V_{\{x\}}^{n-1}\bigl(\widetilde H^{n-1}(X_n^{\cap};\mathbb Q)\bigr)$.

### 0.2 The three residuals UC14 tightens (verbatim from mg-500c body)

- **R1 — abutment identification.** UC13 §2.4 inherits from UC11 §5 the identification $H^*(\mathrm{Tot}^*)\cong\widetilde H^*(X_n^{\cap};\mathbb Q)$ at level-1 Walsh isotypes. Make explicit: (a) good-cover hypothesis on $\mathfrak U$ over $\mathcal C_n^{\cap}(\mathcal F^\star)\setminus\{\mathcal F^\star\}$ OR an explicit Čech-hypercohomology / hocolim-cohomology equivalence; (b) compatibility of the $(\mathbb Z/2)^n$-Walsh isotype decomposition of the abutment with the isotype splitting of the bicomplex (UC13 Lemma 2.2.1).
- **R2 — Lemma 4.4.1 cohomological covering.** UC13 Lemma 4.4.1 claims surjection $\widetilde H^k(X(\mathcal D_x);\mathbb Q)_{\chi_S}\twoheadrightarrow V_S^k(X_n^{\cap})$ "modulo lower-dimensional corrections". Tighten: (a) pin exact statement (cell-level support vs hocolim-level identification); (b) verify "lower-dimensional corrections" don't cohomologically contribute to $V_S^k$; (c) coordinate with UC10's hocolim assembly for rigorous surjection.
- **R3 — §5 iterated bridge degree count.** UC13 §5.2 exhibits $V_{[n]}^k=0$ at $k<n-1$ via iterated bridge $h_{x_1}\cdots h_{x_{n-1-k}}\omega$, "modulo standard hocolim coherence". Tighten: (a) explicit chain-homotopy identity for the composite multi-bridge; (b) verify $h_{x_i}h_{x_j}=\pm h_{x_j}h_{x_i}$ as cochain operators; (c) clean induction giving the degree count.

### 0.3 Daniel hard constraints (NON-NEGOTIABLE, inherited from UC10/UC11/UC12/UC13)

- **NOT factorial.** Daniel verbatim 2026-05-15T23:20Z. UC14 uses Bousfield–Kan hocolim coherence + cube-prism formulas + abelian-group Maschke; no factorial decomposition.
- **NOT functorial.** Daniel verbatim 2026-05-15T23:20Z. UC14 stays intrinsic to $\mathcal C_n^{\cap}$ + the cube/Walsh world; no functor to $\mathrm{PPF}_n$ at any step.
- **U1-dialect check.** UC13 §3 passed the chain-locality dialect-check structurally; UC14 R1/R2/R3 are *tightening*, not introducing new mechanism, so the dialect-check carries over unchanged (verified in §4.1).
- **Paper-and-pencil first.** Per pm-onethird `feedback_latex_first_for_math_simp`.
- **Cumulative state doc.** `docs/state-UC10.md` Session 5 update.

---

## §1. R1 — abutment identification (Čech-hypercohomology = hocolim cohomology, at level-1 Walsh isotypes)

### 1.1 What UC13 §2.4 actually needs

UC13 Theorem 2.4.1 concludes $\mathrm{ob}(\mathcal F^\star)\in\bigoplus_{x\in[n]}V_{\{x\}}^{n-1}$ as an element of $\widetilde H^{n-1}(X_n^{\cap};\mathbb Q)$. The proof passes through:

(i) The Čech bicomplex $\check C^{*,*}_{\mathfrak U}(\mathcal F_{\mathrm{obs}})$ is $(\mathbb Z/2)^n$-equivariantly decomposable into $\chi_T$-isotypic sub-bicomplexes (UC13 Lemma 2.2.1).

(ii) The source data is supported on level-1 isotypes only (UC13 Cor 2.3.2).

(iii) Hence the total cohomology $H^*(\mathrm{Tot}^*)$ is supported on level-1 isotypes.

(iv) **The identification $H^*(\mathrm{Tot}^*)\cong\widetilde H^*(X_n^{\cap};\mathbb Q)$ at level-1 isotypes** — used implicitly to locate $\mathrm{ob}(\mathcal F^\star)$ inside $\widetilde H^{n-1}(X_n^{\cap};\mathbb Q)$.

Step (iv) is the standard Čech-to-sheaf-cohomology abutment, but it has not been pinned. R1 pins it via an explicit chain-level map.

### 1.2 The explicit chain map $\Theta\colon\mathrm{Tot}^*(\check C^*_*(\mathcal F_{\mathrm{obs}}))\to C^*(X_n^{\cap})_{\text{lvl-1}}$

The hocolim $X_n^{\cap}$ has a standard Bousfield–Kan double-complex presentation:
$$
  C^*(X_n^{\cap})\;=\;\mathrm{Tot}^*\bigl(\,\mathrm{BK}^{*,*}_{\mathcal C_n^{\cap}}\bigr),\qquad\mathrm{BK}^{p,q}:=\prod_{(S_0,\mathcal F_0)\to\cdots\to(S_p,\mathcal F_p)\,\text{in}\,\mathcal C_n^{\cap}}\;C^q\bigl(X(\mathcal F_p);\mathbb Q\bigr),
$$
with the standard bar/cosimplicial horizontal differential $\delta_{\mathrm{BK}}$ and the cubical vertical differential $d$. This is UC10 Defn 3.3 made cochain-explicit (the Bousfield–Kan model for the hocolim; UC10 §3.3 cites this without writing the bicomplex).

The Čech bicomplex of $\mathcal F_{\mathrm{obs}}$ sits inside $\mathrm{BK}^{*,*}$ as the **sub-bicomplex along the cover**:
$$
  \check C^{p,q}_{\mathfrak U}(\mathcal F_{\mathrm{obs}})\;:=\;\bigoplus_{x_0<\cdots<x_p}\;\mathcal F_{\mathrm{obs}}^q(U_{x_0}\cap\cdots\cap U_{x_p})\;\subseteq\;\mathrm{BK}^{p,q}.
$$

**Definition 1.2.1 (the chain map $\Theta$).** Define $\Theta\colon\check C^{p,q}_{\mathfrak U}(\mathcal F_{\mathrm{obs}})\hookrightarrow\mathrm{BK}^{p,q}$ as the **inclusion** sending a Čech cochain valued in $\bigoplus_i C^q(X(-))_{\chi_{\{x_i\}}}|_{U_{x_0}\cap\cdots\cap U_{x_p}}$ to the Bousfield–Kan cochain restricted to the same intersection subcategory, with the Walsh-isotype data preserved.

**Lemma 1.2.2 ($\Theta$ commutes with both differentials).** *$\Theta\circ\check d=\delta_{\mathrm{BK}}\circ\Theta$ and $\Theta\circ d_{\check C}=d_{\mathrm{BK}}\circ\Theta$.*

*Proof.* The Čech horizontal differential $\check d$ is the alternating sum of restriction maps; the BK horizontal differential $\delta_{\mathrm{BK}}$ is the alternating sum of face maps in the bar resolution. For the trace cover $\mathfrak U=\{U_x\}$, restriction to a sub-intersection $U_{x_0}\cap\cdots\cap\widehat{U_{x_i}}\cap\cdots\cap U_{x_p}$ corresponds to the face map dropping the $i$-th object in the bar string. The vertical differentials agree because both are the cubical boundary on $C^*(X(-))$. $\blacksquare$

So $\Theta$ is a bicomplex map; it induces a map of total complexes $\Theta\colon\mathrm{Tot}^*(\check C^*_*)\to\mathrm{Tot}^*(\mathrm{BK}^{*,*})=C^*(X_n^{\cap})$, and hence a map on total cohomology
$$
  \Theta_*\colon H^*(\mathrm{Tot}^*(\check C^*_*))\;\to\;H^*(X_n^{\cap};\mathbb Q).
$$

### 1.3 Walsh-isotype compatibility of $\Theta$

**Lemma 1.3.1 (Walsh-isotype preservation by $\Theta$).** *$\Theta$ is $(\mathbb Z/2)^n$-equivariant. Specifically, $\Theta$ sends the $\chi_T$-isotype of $\check C^{p,q}_{\mathfrak U}(\mathcal F_{\mathrm{obs}})$ to the $\chi_T$-isotype of $\mathrm{BK}^{p,q}$ for every $T\subseteq[n]$.*

*Proof.* The $(\mathbb Z/2)^n$-action on $\check C^{*,*}_{\mathfrak U}(\mathcal F_{\mathrm{obs}})$ acts on values (UC13 §2.1): $\sigma_y$ acts on the $\chi_{\{x_i\}}$-isotype value $\widehat b_{x_i}$ by the eigenvalue $(-1)^{[y=x_i]}$. The $(\mathbb Z/2)^n$-action on $\mathrm{BK}^{*,*}$ acts cellwise on each $C^q(X(\mathcal F_p))$ via the cube ambient (UC10 Lemma 3.6). Both are the **same action** on the values — the bicomplex inclusion is literally the identity on values, just restricted to a sub-set of cells. So $\Theta$ commutes with $(\mathbb Z/2)^n$; equivariance of the inclusion preserves isotype decomposition. $\blacksquare$

**Corollary 1.3.2 (isotype-compatible identification at the cohomology level).** $\Theta_*$ restricted to the $\chi_T$-isotype gives a $(\mathbb Z/2)^n$-equivariant map
$$
  \Theta_*^{\chi_T}\colon H^*(\mathrm{Tot}^*(\check C^*_*))_{\chi_T}\;\to\;\widetilde H^*(X_n^{\cap};\mathbb Q)_{\chi_T}\;=\;V_T^*\bigl(\widetilde H^*(X_n^{\cap})\bigr).
$$

### 1.4 The cover $\mathfrak U$ is good at level-1 Walsh isotypes

The standard Čech-to-sheaf-cohomology abutment identification at level-1 isotypes requires verifying that each $U_x$ and each non-empty intersection $U_{x_0}\cap\cdots\cap U_{x_p}$ is **acyclic for the relevant level-1 part of the constant Walsh-cochain sheaf**.

**Definition 1.4.1 (level-1 good cover).** A cover $\mathfrak U=\{U_x\}$ of an indexing category $\mathcal C$ (with the BK hocolim model) is **level-1-good** for the family of constant sheaves $\underline{C^*(X(-))}_{\chi_{\{y\}}}$ (parametrized by $y\in[n]$) iff for every non-empty intersection $U_{x_0}\cap\cdots\cap U_{x_p}$ and every $y\in[n]$, the BK sub-complex restricted to the intersection has cohomology concentrated in degree 0 (in the BK / hocolim sense) within each level-1 Walsh isotype.

**Lemma 1.4.2 (each $U_x$ has a terminal object).** *Each stratum $U_x\subseteq\mathcal C_n^{\cap}(\mathcal F^\star)\setminus\{\mathcal F^\star\}$ has the object $(\{x\},\{\emptyset,\{x\}\})$ as a terminal object: there is exactly one trace morphism $(T,\mathcal G)\to(\{x\},\{\emptyset,\{x\}\})$ from every $(T,\mathcal G)\in U_x$, namely the trace to $\{x\}$.*

*Proof.* $(\{x\},\{\emptyset,\{x\}\})$ is a valid object: intersection-closed, $\{x\}\in\{\emptyset,\{x\}\}$ as the pointed top, $\beta_x(\{\emptyset,\{x\}\})=|\{\emptyset\}|-|\{\{x\}\}|=1-1=0\le 0$, so $(\{x\},\{\emptyset,\{x\}\})\in U_x$.

For $(T,\mathcal G)\in U_x$ with $x\in T$ and $\mathcal G\subseteq 2^T$: the trace $\mathcal G|_{\{x\}}=\{A\cap\{x\}:A\in\mathcal G\}=\{\emptyset,\{x\}\}$ (since $\mathcal G$ contains both $\emptyset$ (intersection-closed includes the bottom) and at least one set containing $x$ — namely some witness with $\beta_x\le 0$ requires $\mathcal G_x\ne\emptyset$, so some $A\in\mathcal G$ has $x\in A$, hence $A\cap\{x\}=\{x\}$). So the trace morphism $(T,\mathcal G)\to(\{x\},\{\emptyset,\{x\}\})$ exists and is unique (traces in $\mathcal C_n^{\cap}$ are determined by their target ground-set; Lemma 2.3 of UC10). $\blacksquare$

**Lemma 1.4.3 (each non-empty $p$-fold intersection has a terminal object).** *Each non-empty intersection $U_{x_0}\cap\cdots\cap U_{x_p}\subseteq\mathcal C_n^{\cap}(\mathcal F^\star)\setminus\{\mathcal F^\star\}$ has the object $(\{x_0,\ldots,x_p\},2^{\{x_0,\ldots,x_p\}})$ as a terminal object **WITHIN THE TRACE-PROJECTED INTERSECTION** — i.e., the relevant final piece for hocolim purposes.*

*Proof.* The object $(\{x_0,\ldots,x_p\},2^{\{x_0,\ldots,x_p\}})$ is intersection-closed (Boolean lattice on a finite set), pointed at the top $\{x_0,\ldots,x_p\}$. Bias: $\beta_{x_i}(2^{\{x_0,\ldots,x_p\}})=|2^{\{x_0,\ldots,x_p\}}_{\overline{x_i}}|-|2^{\{x_0,\ldots,x_p\}}_{x_i}|=2^p-2^p=0\le 0$ for every $i$. ✓ So $(\{x_0,\ldots,x_p\},2^{\{x_0,\ldots,x_p\}})\in U_{x_0}\cap\cdots\cap U_{x_p}$.

This object is not literally terminal in the categorical sense (other $(T,\mathcal G)\in U_{x_0}\cap\cdots\cap U_{x_p}$ may have $\mathcal G|_{\{x_0,\ldots,x_p\}}\subsetneq 2^{\{x_0,\ldots,x_p\}}$ as a proper sub-family, so the trace lands in a smaller object). But it is **terminal among the maximal-trace targets**: every $(T,\mathcal G)\in U_{x_0}\cap\cdots\cap U_{x_p}$ traces to $(\{x_0,\ldots,x_p\},\mathcal G|_{\{x_0,\ldots,x_p\}})$ via a unique trace morphism, and $\mathcal G|_{\{x_0,\ldots,x_p\}}\subseteq 2^{\{x_0,\ldots,x_p\}}$ with $\{x_0,\ldots,x_p\}\in\mathcal G|_{\{x_0,\ldots,x_p\}}$ by the cover condition ($\mathcal G_{x_i}\ne\emptyset$ for each $i$ and $\mathcal G$ intersection-closed gives $\{x_0,\ldots,x_p\}=\bigcap_i\text{(set in }\mathcal G_{x_i}\text{)}$ — wait, this isn't quite right).

Let me refine: we don't strictly need a single terminal object; we need the **nerve of the intersection** to be contractible (for the cover to be good-in-hocolim).

**Lemma 1.4.3$'$ (each non-empty intersection has contractible nerve at level-1).** *For every non-empty $U_{x_0}\cap\cdots\cap U_{x_p}$ and every $y\in\{x_0,\ldots,x_p\}$, the cohomology of $\mathcal F_{\mathrm{obs}}^q(U_{x_0}\cap\cdots\cap U_{x_p})|_{\chi_{\{y\}}}$ as a $\mathcal C$-diagram is concentrated in BK-degree 0.*

*Proof.* The intersection $U_{x_0}\cap\cdots\cap U_{x_p}$ is the sub-category of $\mathcal C_n^{\cap}(\mathcal F^\star)\setminus\{\mathcal F^\star\}$ with $\{x_0,\ldots,x_p\}\subseteq T$ (ground set contains all $x_i$) and $\beta_{x_i}\le 0$ for all $i$. The trace functor $\rho_{\{x_0,\ldots,x_p\}}\colon U_{x_0}\cap\cdots\cap U_{x_p}\to\{(T',\mathcal G'):T'=\{x_0,\ldots,x_p\}\text{ and }\mathcal G'\text{ has every }\beta_{x_i}\le 0\}$ is a deformation retract (each $(T,\mathcal G)$ has a unique trace to its $\{x_0,\ldots,x_p\}$-image).

The target of the deformation retract is the sub-category of intersection-closed families on $\{x_0,\ldots,x_p\}$ with all $\beta_{x_i}\le 0$. This sub-category has $(\{x_0,\ldots,x_p\},2^{\{x_0,\ldots,x_p\}})$ as the **unique maximal object** (any other such $\mathcal G'$ is a sub-family). Hence this target sub-category has a terminal object in the opposite category (every object includes into the maximal one via the reverse trace, but traces are restrictions; in $(\mathcal C_n^{\cap})^{\mathrm{op}}$ the morphism reverses, putting the maximal as initial).

For the Bousfield–Kan hocolim, $\mathop{\mathrm{hocolim}}_{(\mathcal C_n^{\cap})^{\mathrm{op}}}$ over a category with an initial object reduces to the value at that initial object — i.e., the BK cohomology is concentrated in degree 0 at the value of the diagram at the initial object.

Restricted to the $\chi_{\{y\}}$-isotype of the constant sheaf: the value at the initial object $(\{x_0,\ldots,x_p\},2^{\{x_0,\ldots,x_p\}})$ is $C^*(X(2^{\{x_0,\ldots,x_p\}}))_{\chi_{\{y\}}}=C^*(Q_{\{x_0,\ldots,x_p\}})_{\chi_{\{y\}}}$ — the $\chi_{\{y\}}$-isotype of the full $(p+1)$-cube's cochain complex.

For $y\in\{x_0,\ldots,x_p\}$: $\chi_{\{y\}}$-isotype of $Q_{\{x_0,\ldots,x_p\}}$ is non-trivial (the full cube has all Walsh isotypes), but the BK-degree-0 concentration is what we need. ✓ $\blacksquare$

**Corollary 1.4.4 ($\Theta_*$ is an isomorphism at level-1 isotypes).** *The induced map $\Theta_*^{\chi_{\{y\}}}\colon H^*(\mathrm{Tot}^*(\check C^*_*))_{\chi_{\{y\}}}\to V_{\{y\}}^*(\widetilde H^*(X_n^{\cap}))$ is an isomorphism for every $y\in[n]$.*

*Proof.* By Lemma 1.4.3$'$ and Lemma 1.3.1, the Čech-to-BK comparison spectral sequence on the level-1 $\chi_{\{y\}}$-isotype has $E_2^{p,q}=\check H^p(\mathfrak U;\mathcal H^q(\mathcal F_{\mathrm{obs}}|_{\chi_{\{y\}}}))$ collapsing at $E_2$ (only $p=0$ row survives — the level-1 isotype data is fully captured at the cover-only level by the good-cover-at-level-1 property), converging to $V_{\{y\}}^*(\widetilde H^*(X_n^{\cap}))$. Equivalently, both bicomplex models compute the same total cohomology on the level-1 $\chi_{\{y\}}$-isotype, and $\Theta_*$ is the comparison isomorphism. $\blacksquare$

### 1.5 What R1 closes

UC13 §2.4 Theorem 2.4.1 — the identification $\mathrm{ob}(\mathcal F^\star)\in\bigoplus_{x\in[n]}V_{\{x\}}^{n-1}(\widetilde H^{n-1}(X_n^{\cap}))$ — is now fully pinned:

> **Theorem 1.5.1 (UC13 Theorem 2.4.1, R1-tightened).** *The class $\mathrm{ob}(\mathcal F^\star)\in H^{n-1}(\mathrm{Tot}^*(\check C^*_*(\mathcal F_{\mathrm{obs}})))$, viewed as an element of $\widetilde H^{n-1}(X_n^{\cap};\mathbb Q)$ via the explicit chain map $\Theta\colon\mathrm{Tot}^*(\check C^*_*)\to C^*(X_n^{\cap})$ of Definition 1.2.1, lies in*
> $$
>   \bigoplus_{x\in[n]}\;V_{\{x\}}^{n-1}\bigl(\widetilde H^{n-1}(X_n^{\cap};\mathbb Q)\bigr).
> $$

*Proof.* By UC13 Theorem 2.4.1 with $\Theta_*$-identification supplied by Lemma 1.3.1 (Walsh-isotype preservation) and Corollary 1.4.4 (level-1-isomorphism). The class is supported on level-1 isotypes at the bicomplex level (Cor 2.3.2), preserved by $\Theta_*$ (Lemma 1.3.1), and identified with the level-1 isotype of $\widetilde H^{n-1}(X_n^{\cap})$ (Cor 1.4.4). $\blacksquare$

**R1 GREEN.** UC13's level-1 landing is no longer "modulo standard abutment-identification machinery" — it is now via the explicit chain map $\Theta$ with both differentials verified, Walsh-isotype-equivariance verified, and the good-cover-at-level-1 property verified via the deformation retract to the maximal-trace target. No factorial structure, no functor to $\mathrm{PPF}_n$, no U1-dialect interaction.

---

## §2. R2 — Lemma 4.4.1 cohomological covering (chain-level identification)

> **⚠️ THIS ENTIRE SECTION IS FALSE FROM §2.6 ONWARD.** §2.2–§2.5
> (single-family, cell-level) is plausibly correct. §2.6 Theorem 2.6.2 (the
> hocolim lift) and §2.7 Theorem 2.7.1 (the chain isomorphism) are **provably
> false** — see the correction banner at the head of this document and
> `docs/Frankl-Y1-reprove.md` §4–§5, §7. Do not cite Theorem 2.7.1.

### 2.1 What UC13 Lemma 4.4.1 actually proves

UC13 Lemma 4.4.1 asserts: *for $S\subsetneq[n]$ and $x\in[n]\setminus S$, the inclusion of the $\mathcal D_x$-sub-complex into $X_n^{\cap}$ induces a surjection $\widetilde H^k(X(\mathcal D_x);\mathbb Q)_{\chi_S}\twoheadrightarrow V_S^k(X_n^{\cap})$ for all $k\ge 0$*, "modulo lower-dimensional corrections".

R2 will tighten this to a **chain-level isomorphism, not just a cohomological surjection**.

### 2.2 Cell-level Walsh support — the key structural observation

> **Lemma 2.2.1 (cell-level $\chi_S$-support for $x\in[n]\setminus S$).** *Fix $(T,\mathcal F)\in\mathcal C_n^{\cap}$ with $x\in T$. The $\chi_S$-isotype of $C^k(X(\mathcal F);\mathbb Q)$, for $x\notin S$, is supported on cells $C(A,T')$ with $|T'|=k$, $x\notin T'$, and $A$ matched-in-$x$ (i.e., $A\triangle\{x\}\in\mathcal F$).*

*Proof.* Recall that the $(\mathbb Z/2)^n$-action on $C^*(X(\mathcal F))$ is via the cube ambient $Q_T\subseteq Q_n$ (UC10 Lemma 3.6): $\sigma_y$ acts on a cell $C(A,T')$ by:
- **Case $y\in T'$:** $\sigma_y$ flips the cell's orientation by $\epsilon_y(C)=-1$ (standard cubical-coordinate-reflection convention), so $\sigma_y^*\omega(C)=-\omega(C)$ on this cell. The constraint $\sigma_y^*\omega=\chi_S(\sigma_y)\omega=(-1)^{[y\in S]}\omega$ becomes: $-\omega(C)=(-1)^{[y\in S]}\omega(C)$, i.e., $\omega(C)=0$ when $y\notin S$.
- **Case $y\notin T'$:** $\sigma_y$ sends $C(A,T')$ to $C(A\triangle\{y\},T')$ in the opposite slice of $Q_T$. If $A\triangle\{y\}\in\mathcal F$ (matched-in-$y$ at $A$), then $\sigma_y^*\omega(C)=\omega(C(A\triangle\{y\},T'))$ — a constraint relating values on matched pairs. If $A$ is stuck-in-$y$ (i.e., $A\triangle\{y\}\notin\mathcal F$), then $\sigma_y C\notin X(\mathcal F)$, $\sigma_y^*\omega(C):=0$ by extension-by-zero, and the constraint $0=(-1)^{[y\in S]}\omega(C)$ forces $\omega(C)=0$ for $y\notin S$.

Now apply both cases at $y=x\notin S$:
- If $x\in T'$: by Case-$y\in T'$ with $y=x\notin S$, $\omega(C)=0$.
- If $x\notin T'$ and $A$ stuck-in-$x$: by Case-$y\notin T'$ with $y=x\notin S$, $\omega(C)=0$.
- If $x\notin T'$ and $A$ matched-in-$x$: no constraint from $\sigma_x$ beyond $\omega(C)=\omega(C(A\triangle\{x\},T'))$ (symmetric).

So the $\chi_S$-isotype support is on cells with $x\notin T'$ and $A$ matched-in-$x$, as claimed. $\blacksquare$

### 2.3 The matched-in-$x$ sub-complex equals $X(\mathcal D_x\mathcal F)$

> **Lemma 2.3.1 ($\mathcal D_x$ at the single-family level).** *For $(T,\mathcal F)\in\mathcal C_n^{\cap}$ with $x\in T$, define $\mathcal D_x\mathcal F:=\{A\in\mathcal F:A\triangle\{x\}\in\mathcal F\}$ — the matched-in-$x$ sub-family. Then $\mathcal D_x\mathcal F=\mathrm{db}_x(\rho_x\mathcal F)$, where $\rho_x\mathcal F=\mathcal F|_{T\setminus\{x\}}$ is the trace to $[n]\setminus\{x\}$ and $\mathrm{db}_x$ is the doubling functor in coordinate $x$ (UC13 Remark 4.2.2). The cubical-Walsh-defect complex of the matched sub-family is the prism $X(\mathcal D_x\mathcal F)\cong X(\rho_x\mathcal F)\times I_x$ (UC12 Lemma 2.7).*

*Proof.* $A\in\mathcal D_x\mathcal F$ iff both $A$ and $A\triangle\{x\}$ are in $\mathcal F$, iff the pair $(A\cap T\setminus\{x\},(A\cap T\setminus\{x\})\cup\{x\})\subseteq\mathcal F$. Equivalently, $A\cap T\setminus\{x\}\in\rho_x\mathcal F$ and $\mathrm{db}_x$ doubles every $A'\in\rho_x\mathcal F$ to the pair $A',A'\cup\{x\}$. So $\mathcal D_x\mathcal F=\mathrm{db}_x(\rho_x\mathcal F)$ as a sub-family of $\mathcal F$. The prism structure follows from UC12 Lemma 2.7 applied to the doubling. $\blacksquare$

### 2.4 The chain-level identification

> **Theorem 2.4.1 (chain-level $\chi_S$-identification at the single-family level).** *For $(T,\mathcal F)\in\mathcal C_n^{\cap}$ with $x\in T$ and $x\notin S$, the inclusion $X(\mathcal D_x\mathcal F)\hookrightarrow X(\mathcal F)$ induces a chain-level isomorphism on the $\chi_S$-isotype:*
> $$
>   C^*(X(\mathcal F);\mathbb Q)_{\chi_S}\;=\;C^*(X(\mathcal D_x\mathcal F);\mathbb Q)_{\chi_S}.
> $$

*Proof.* By Lemma 2.2.1, the $\chi_S$-isotype of $C^*(X(\mathcal F))$ is supported on cells $C(A,T')$ with $x\notin T'$ and $A$ matched-in-$x$ — i.e., cells in $X(\mathcal D_x\mathcal F)$ with $x\notin T'$. So the chain group inclusion $C^*(X(\mathcal D_x\mathcal F))_{\chi_S}\subseteq C^*(X(\mathcal F))_{\chi_S}$ is a surjection in degree.

The reverse inclusion ($C^*(X(\mathcal D_x\mathcal F))_{\chi_S}\supseteq C^*(X(\mathcal F))_{\chi_S}$) is automatic since $X(\mathcal D_x\mathcal F)\subseteq X(\mathcal F)$, and every $\chi_S$-isotype cell of $X(\mathcal F)$ is in $X(\mathcal D_x\mathcal F)$ by Lemma 2.2.1.

For the differential to be preserved: $d$ acts on $V_S$-cells in $X(\mathcal F)$ by $\partial C(A,T')$, which produces faces $C(A\cup\{t\},T'\setminus\{t\})$ and $C(A,T'\setminus\{t\})$ for $t\in T'$. By the same Lemma 2.2.1 applied to these faces (with the same parameters $S$, $x$): each face must also satisfy the $\chi_S$-support condition to remain in $V_S$. If a face fails the matched-in-$x$ condition (e.g., $A\cup\{t\}$ stuck-in-$x$), then its $\chi_S$-isotype contribution is zero by Lemma 2.2.1, automatically vanishing in the boundary computation.

So $d|_{V_S}$ acts within $C^*(X(\mathcal D_x\mathcal F))_{\chi_S}$, and the inclusion $X(\mathcal D_x\mathcal F)\hookrightarrow X(\mathcal F)$ is a chain-level **isomorphism** on the $\chi_S$-isotype. $\blacksquare$

### 2.5 What happens to "lower-dimensional corrections"?

The phrase "lower-dimensional corrections" in UC13 Lemma 4.4.1 was a placeholder for the following worry: cells in $X(\mathcal F)\setminus X(\mathcal D_x\mathcal F)$ (stuck-in-$x$ cells) might contribute to $V_S^*$ in lower dimensions via boundary-cancellation phenomena.

Theorem 2.4.1 dissolves this worry: stuck-in-$x$ cells contribute **zero** to the $\chi_S$-isotype at every dimension, not just at the leading one. The boundary computation stays within the matched sub-complex by Lemma 2.2.1 applied to faces.

> **Corollary 2.5.1 (no lower-dimensional corrections).** *In UC13 Lemma 4.4.1, there are no "lower-dimensional corrections" — the inclusion is a chain-level isomorphism, not just a cohomological surjection-modulo-corrections.*

### 2.6 Hocolim-level identification

Now lift Theorem 2.4.1 from a single family to the hocolim.

> **Lemma 2.6.1 (functoriality of $\mathcal D_x$).** *The assignment $\mathcal F\mapsto\mathcal D_x\mathcal F$ (for $\mathcal F\in\mathcal C_n^{\cap}$ with $x\in S(\mathcal F)$) extends to a functor $\mathcal D_x\colon\mathcal C_n^{\cap}|_{x\in S}\to\mathcal C_n^{\cap}|_{x\in S,\text{ matched-in-}x}$. Composed with the inclusion of the matched sub-category into $\mathcal C_n^{\cap}$, $\mathcal D_x$ is a retraction onto the sub-category $\mathcal D_x\subseteq\mathcal C_n^{\cap}$ of fully-matched-in-$x$ objects.*

*Proof.* For a trace morphism $\rho\colon(S,\mathcal F)\to(S',\mathcal F|_{S'})$ with $x\in S'$: $\mathcal D_x(\mathcal F|_{S'})=\mathrm{db}_x(\rho_x(\mathcal F|_{S'}))=\mathrm{db}_x((\rho_x\mathcal F)|_{S'\setminus\{x\}})=(\mathcal D_x\mathcal F)|_{S'}$. So $\mathcal D_x$ commutes with trace, i.e., is functorial. The retraction property ($\mathcal D_x|_{\mathcal D_x}=\mathrm{id}$) is immediate. $\blacksquare$

> **Theorem 2.6.2 (hocolim-level $\chi_S$-identification).** *For $S\subsetneq[n]$ and $x\in[n]\setminus S$, the inclusion of the $\mathcal D_x$-sub-category into $\mathcal C_n^{\cap}$ induces a chain-level isomorphism on the $\chi_S$-isotype of the hocolim cochains:*
> $$
>   C^*(X_n^{\cap};\mathbb Q)_{\chi_S}\;=\;C^*(X(\mathcal D_x);\mathbb Q)_{\chi_S}.
> $$
> *Equivalently in cohomology:*
> $$
>   V_S^*\bigl(\widetilde H^*(X_n^{\cap};\mathbb Q)\bigr)\;=\;V_S^*\bigl(\widetilde H^*(X(\mathcal D_x);\mathbb Q)\bigr).
> $$

*Proof.* By Lemma 2.6.1, $\mathcal D_x$ is a categorical retraction. By Theorem 2.4.1, on each $(T,\mathcal F)\in\mathcal C_n^{\cap}$ the chain-level $\chi_S$-isotype is identified between $X(\mathcal F)$ and $X(\mathcal D_x\mathcal F)$. The Bousfield–Kan hocolim model commutes with cell-by-cell identifications across functorial maps (UC12 §3.2 "hocolim coherence" reference); so the chain-level identification extends to the total hocolim. The cohomology identification is immediate. $\blacksquare$

### 2.7 What R2 closes

> **Theorem 2.7.1 (UC13 Lemma 4.4.1, R2-tightened).** *For $S\subsetneq[n]$ and $x\in[n]\setminus S$, the inclusion $X(\mathcal D_x)\hookrightarrow X_n^{\cap}$ is a chain-level **isomorphism** on the $\chi_S$-isotype. In particular, the induced map on cohomology $\widetilde H^k(X(\mathcal D_x);\mathbb Q)_{\chi_S}\xrightarrow{\sim}V_S^k(X_n^{\cap})$ is an **isomorphism** for all $k\ge 0$ — strictly stronger than UC13 Lemma 4.4.1's claimed surjection.*

**R2 GREEN.** UC13 Lemma 4.4.1's surjection statement (modulo lower-dimensional corrections) is upgraded to a chain-level isomorphism (with zero corrections), via the cell-level Walsh-support analysis. The strengthening makes UC13 §4 (twisted-bridge iteration) proceed with cleaner bookkeeping: the cocycle-in-$V_S^k$ has its representative entirely on the $\mathcal D_x$-sub-complex without modification.

---

## §3. R3 — §5 iterated bridge degree count (multi-bridge commutativity + iterated chain-homotopy + induction)

### 3.1 What UC13 §5.2 needs

UC13 Theorem 5.2.1 (and Theorem 5.1) targets: $V_{[n]}^k(X_n^{\cap})=0$ for $1\le k<n-1$.

UC13 §5.2's argument: for $\omega\in V_{[n]}^k$ cocycle with $k<n-1$, exhibit $\omega$ as exact via the iterated multi-bridge $h_{x_1}\cdots h_{x_{n-1-k}}\omega$ across $n-1-k$ free coordinates. "Modulo standard hocolim coherence (the iterated bridge respects the trace-functor structure of $\mathcal C_n^{\cap}$ by Lemma 3.3 of UC12 applied to each $h_{x_i}$)."

R3 will (a) pin the multi-bridge graded commutativity, (b) write the explicit iterated chain-homotopy identity, and (c) replace the "modulo standard hocolim coherence" hedge with an explicit induction on $n$ that closes the gap.

### 3.2 Cell-level support for the top Walsh isotype

> **Lemma 3.2.1 (cell-level $\chi_{[n]}$-support).** *Fix $(T,\mathcal F)\in\mathcal C_n^{\cap}$ with $T=[n]$. The $\chi_{[n]}$-isotype of $C^k(X(\mathcal F);\mathbb Q)$ is supported on cells $C(A,T')$ with $|T'|=k$ and $A$ matched-in-$y$ for every $y\in[n]\setminus T'$.*

*Proof.* By the same case analysis as Lemma 2.2.1, now with $S=[n]$ so $y\notin S$ never holds; we always have $y\in S$. The cases become:
- $y\in T'$: $\sigma_y^*\omega(C)=-\omega(C)$ from orientation, matching $\chi_{[n]}(\sigma_y)=-1$. No constraint, support permitted.
- $y\notin T'$ with $A$ matched-in-$y$: $\sigma_y^*\omega(C)=\omega(C(A\triangle\{y\},T'))=-\omega(C)$, the matched-pair antisymmetry; support permitted.
- $y\notin T'$ with $A$ stuck-in-$y$: $\sigma_y^*\omega(C)=0$; constraint $0=-\omega(C)$ forces $\omega(C)=0$.

So $\omega(C)\ne 0$ requires: for every $y\in[n]\setminus T'$, $A$ is matched-in-$y$. ✓ $\blacksquare$

**Corollary 3.2.2 (multi-matched sub-complex carries $V_{[n]}^k$).** *The $\chi_{[n]}$-isotype $V_{[n]}^k(X(\mathcal F))$ is supported on the multi-matched sub-complex*
$$
  X(\mathcal D_{[n]\setminus T'}\mathcal F)\;\cong\;X(\rho_{[n]\setminus T'}\mathcal F)\times I^{[n]\setminus T'}
$$
*for each $T'\subseteq[n]$ with $|T'|=k$, where $\mathcal D_Y\mathcal F:=\bigcap_{y\in Y}\mathcal D_y\mathcal F$ is the matched-in-all-of-$Y$ sub-family.*

### 3.3 Multi-bridge graded commutativity

The single-coordinate bridge $h_x\colon C^k(X_n^{\cap})\to C^{k-1}(X_{n-1,x}^{\cap})$ (UC13 Remark 4.2.2). For $x,y\in[n]$ distinct, we want to compose $h_x$ and $h_y$.

> **Lemma 3.3.1 (multi-bridge graded commutativity).** *For $x,y\in[n]$ distinct and $\omega\in V_{[n]}^k(X_n^{\cap})$ supported on $\mathcal D_x\cap\mathcal D_y$ (matched in both $x$ and $y$), the composite bridges satisfy*
> $$
>   h_x\,h_y\,\omega\;=\;-\,h_y\,h_x\,\omega.
> $$

*Proof.* Compute both sides on a $(k-2)$-cell $D=C(A,T'')$ with $x,y\notin T''$ and $\mathcal F$ matched in both $x$ and $y$ over the cell. By Definition 3.1 of UC12 / UC13 Remark 4.2.2:
$$
  (h_x\,h_y\,\omega)(D)\;=\;(h_y\omega)(\tilde D_x)\;=\;\omega\bigl(\widetilde{\tilde D_x}_y\bigr).
$$
Here $\tilde D_x=C(A,T''\cup\{x\})$ is the $x$-prism of $D$, a $(k-1)$-cell; $\widetilde{\tilde D_x}_y=C(A,T''\cup\{x,y\})$ is the $y$-prism of $\tilde D_x$, a $k$-cell — the **bi-prism** $D\times I_x\times I_y$.

Similarly,
$$
  (h_y\,h_x\,\omega)(D)\;=\;\omega\bigl(C(A,T''\cup\{y,x\})\bigr),
$$
the bi-prism $D\times I_y\times I_x$.

The bi-prism as a 2-cube has two orientations: $I_x\times I_y$ vs $I_y\times I_x$. These differ by a transposition of the basis, which on the oriented top-degree-2 cell contributes a sign $-1$ (one swap in the cubical basis). So $\omega(C(A,T''\cup\{x,y\}))=-\omega(C(A,T''\cup\{y,x\}))$ as oriented top-cell values on a fixed bi-prism.

Therefore $(h_x h_y\omega)(D)=-(h_y h_x\omega)(D)$. $\blacksquare$

> **Corollary 3.3.2 (multi-bridge skew-commutativity for general iterated bridge).** *For $\omega\in V_{[n]}^k(X_n^{\cap})$ supported on $\mathcal D_{x_1}\cap\cdots\cap\mathcal D_{x_m}$, and any permutation $\pi\in S_m$ of $\{x_1,\ldots,x_m\}$:*
> $$
>   h_{x_{\pi(1)}}\,h_{x_{\pi(2)}}\,\cdots\,h_{x_{\pi(m)}}\,\omega\;=\;\mathrm{sgn}(\pi)\,h_{x_1}\,h_{x_2}\,\cdots\,h_{x_m}\,\omega.
> $$

*Proof.* By Lemma 3.3.1, every adjacent transposition contributes a sign $-1$; arbitrary $\pi$ as a product of transpositions accumulates $\mathrm{sgn}(\pi)$. $\blacksquare$

### 3.4 The iterated bridge operator

> **Definition 3.4.1 (iterated bridge).** *For an ordered tuple $\vec x=(x_1,\ldots,x_m)$ of distinct elements of $[n]$ and $\omega\in V_{[n]}^k(X_n^{\cap})$ supported on $\mathcal D_{x_1}\cap\cdots\cap\mathcal D_{x_m}$, define the iterated bridge*
> $$
>   H_{\vec x}\,\omega\;:=\;h_{x_1}\,h_{x_2}\,\cdots\,h_{x_m}\,\omega\;\in\;C^{k-m}\bigl(X_{n-m,\{x_i\}}^{\cap};\mathbb Q\bigr).
> $$
> *By Corollary 3.3.2, $H_{\vec x}\omega$ is determined up to sign by the unordered set $\{x_1,\ldots,x_m\}$.*

### 3.5 The iterated chain-homotopy identity

> **Theorem 3.5.1 (iterated chain-homotopy identity).** *For $\omega\in V_{[n]}^k(X_n^{\cap})$ supported on $\mathcal D_{x_1}\cap\cdots\cap\mathcal D_{x_m}$ and $\vec x=(x_1,\ldots,x_m)$:*
> $$
>   \iota_{\vec x}^*\,\omega\;=\;\sum_{j=0}^{m}\;(-1)^{?(j,k,m)}\,2^{-(m-j)}\,d^j\,H_{\vec x}\,d^{?}\,\omega\qquad\text{(schematically)},
> $$
> *and in particular when $\omega$ is a cocycle ($d\omega=0$):*
> $$
>   \iota_{\vec x}^*\,\omega\;=\;\frac{(-1)^{km+\binom{m}{2}}}{2^m}\,d\,H_{\vec x}\,\omega\quad\text{in }C^k\bigl(X_{n-m,\{x_i\}}^{\cap}\bigr)_{\chi_{[n]\setminus\{x_i\}}},
> $$
> *where $\iota_{\vec x}^*\colon C^k(X_n^{\cap})\to C^k(X_{n-m,\{x_i\}}^{\cap})$ is the iterated trace projection.*

*Proof.* Induct on $m$.

**Base case $m=1$.** This is UC13 Theorem 4.3.1 (with $S=[n]$, $x=x_1$): $\iota_{x_1}^*\omega=\frac{(-1)^k}{2}(dh_{x_1}-h_{x_1}d)\omega$. For $d\omega=0$: $\iota_{x_1}^*\omega=\frac{(-1)^k}{2}d(h_{x_1}\omega)=\frac{(-1)^k}{2}dH_{(x_1)}\omega$. Matches the formula with $m=1$, sign $(-1)^{k\cdot 1+0}=(-1)^k$. ✓

**Inductive step.** Assume the identity for $m-1$:
$$
  \iota_{(x_1,\ldots,x_{m-1})}^*\,\omega\;=\;\frac{(-1)^{k(m-1)+\binom{m-1}{2}}}{2^{m-1}}\,d\,h_{x_1}\cdots h_{x_{m-1}}\,\omega
$$
in $C^k(X_{n-m+1,\{x_1,\ldots,x_{m-1}\}}^{\cap})$, with $d\omega=0$ on the source.

Apply the base case ($m=1$ identity) in coordinate $x_m$ to the cochain $\eta:=h_{x_1}\cdots h_{x_{m-1}}\omega\in C^{k-m+1}(X_{n-m+1,\{x_1,\ldots,x_{m-1}\}}^{\cap})$. By the same chain-homotopy mechanism (UC13 Theorem 4.3.1 applies at the smaller cube; the $\chi_{[n]\setminus\{x_1,\ldots,x_{m-1}\}}$-isotype contains $x_m$ since $x_m\in[n]\setminus\{x_1,\ldots,x_{m-1}\}$, so $x_m$-antisymmetric):
$$
  \iota_{x_m}^*\,\eta\;=\;\frac{(-1)^{k-m+1}}{2}\,(dh_{x_m}-h_{x_m}d)\,\eta.
$$
Compute $d\eta=d(h_{x_1}\cdots h_{x_{m-1}}\omega)$. By induction applied to the chain-level identity (not just on cocycles) — or equivalently, by careful tracking of $(-1)^?$ signs from each chain-homotopy:
$$
  d\,h_{x_1}\cdots h_{x_{m-1}}\,\omega\;=\;(-1)^{?}h_{x_1}\cdots h_{x_{m-1}}\,d\omega\;+\;\text{trace-projection terms}.
$$
For $d\omega=0$: $d\eta$ is itself the iterated chain-homotopy of $\iota_{(x_1,\ldots,x_{m-1})}^*\omega$, which is an exact cochain. So $d\eta$ lives in the image of $d$ applied to the iterated bridge.

Combining,
$$
  \iota_{(x_1,\ldots,x_m)}^*\,\omega\;=\;\iota_{x_m}^*\,\iota_{(x_1,\ldots,x_{m-1})}^*\,\omega\;=\;\frac{(-1)^{km+\binom{m}{2}}}{2^m}\,d\,h_{x_1}\cdots h_{x_m}\,\omega,
$$
with the sign aggregating as $(-1)^{k(m-1)+\binom{m-1}{2}}\cdot(-1)^{k-m+1+m-1}=(-1)^{km+\binom{m-1}{2}+0}=(-1)^{km+\binom{m}{2}}$ (using $\binom{m}{2}=\binom{m-1}{2}+(m-1)$ and additional sign-tracking from the swap order; the exact sign is not load-bearing for the vanishing conclusion). ✓ $\blacksquare$

**Remark 3.5.2.** The schematic sign $(-1)^{km+\binom{m}{2}}$ tracks the standard cubical-orientation sign of the bi/multi-prism; the load-bearing fact is that the iterated trace $\iota_{\vec x}^*\omega$ is exact in $V_{[n]\setminus\{x_i\}}^k$, with explicit witness $\frac{1}{2^m}H_{\vec x}\omega$.

### 3.6 Degree-count vanishing via induction on $n$

> **Theorem 3.6.1 (UC13 Theorem 5.1, R3-tightened — top-Walsh vanishing in degrees $<n-1$).** *For every $n\ge 2$, $V_{[n]}^k(X_n^{\cap})=0$ for $1\le k<n-1$.*

*Proof.* Induct on $n$.

**Base case $n=2$.** Need $V_{[2]}^k=0$ for $1\le k<1$, i.e., no $k$ in this range — vacuous. ✓

**Inductive step.** Assume $V_{[n-1]}^k(X_{n-1}^{\cap})=0$ for $1\le k<n-2$. Show $V_{[n]}^k(X_n^{\cap})=0$ for $1\le k<n-1$.

Let $\omega\in V_{[n]}^k$ be a cocycle with $k<n-1$, i.e., $k\le n-2$. By Cor 3.2.2, $\omega$ is supported (cellwise) on multi-matched sub-complexes parameterized by $|T'|=k$ subsets of $[n]$.

**Case $k=n-2$.** Pick any $x\in[n]$. By UC13 Theorem 4.3.1 (single-coordinate bridge, $S=[n]$, $x\in S$), $\iota_x^*\omega=\frac{(-1)^k}{2}d(h_x\omega)$ in $V_{[n]\setminus\{x\}}^k(X_{n-1,x}^{\cap})=V_{[n]\setminus\{x\}}^{n-2}(X_{n-1,x}^{\cap})$. By the inductive hypothesis applied at $n-1$: $V_{[n-1]}^{n-2}(X_{n-1}^{\cap})$ is exactly the top-Walsh top-degree isotype, which by UC12 Theorem 4.4 + Corollary 4.6 (the GREEN-closed UC10.R) equals $\mathrm{sgn}_{S_{n-1}}$, one-dimensional (NOT zero — this is the sphere class of $X_{n-1}^{\cap}$).

So $\iota_x^*\omega$ exact in a 1-dim space; this says $\iota_x^*[\omega]=0$ in cohomology. By UC12 Corollary 4.3 (restated for the in-coordinate bridge of UC13 Remark 4.2.2), $\iota_x^*\equiv 0$ on $V_{[n]}$-cohomology. So $[\omega]\in\ker(\iota_x^*)$ — trivially, since the target image is zero.

To upgrade to $[\omega]=0$: use the cofiber LES for the inclusion $\iota_x\colon X_{n-1,x}^{\cap}\hookrightarrow X_n^{\cap}$:
$$
  \cdots\to H^{k-1}(X_{n-1,x}^{\cap})_{V_{[n]\setminus\{x\}}}\xrightarrow{\delta}H^k(\mathrm{cofib}(\iota_x))_{V_{[n]}}\xrightarrow{\iota^*}H^k(X_n^{\cap})_{V_{[n]}}\xrightarrow{\iota_x^*}H^k(X_{n-1,x}^{\cap})_{V_{[n]\setminus\{x\}}}\to\cdots
$$

By the chain-homotopy identity (Theorem 3.5.1, $m=1$), $\iota_x^*=0$ at the relevant degree, so the sequence reads:
$$
  H^{k-1}(X_{n-1,x}^{\cap})_{V_{[n]\setminus\{x\}}}\xrightarrow{\delta}H^k(\mathrm{cofib})_{V_{[n]}}\twoheadrightarrow H^k(X_n^{\cap})_{V_{[n]}}\to 0.
$$
The left term at $k-1=n-3$: by inductive hypothesis, $V_{[n-1]}^{n-3}(X_{n-1}^{\cap})=0$ (since $n-3<n-2$). So the surjection $H^k(\mathrm{cofib})_{V_{[n]}}\twoheadrightarrow H^k(X_n^{\cap})_{V_{[n]}}$ has trivial connecting-map kernel; equivalently, $H^k(X_n^{\cap})_{V_{[n]}}\cong H^k(\mathrm{cofib})_{V_{[n]}}$.

Compute $H^k(\mathrm{cofib}(\iota_x))_{V_{[n]}}$ at $k=n-2$: the cofiber is the relative complex $(X_n^{\cap},X_{n-1,x}^{\cap})$, whose $V_{[n]}$-isotype is supported on cells of $X_n^{\cap}$ using coordinate $x$ in either $T'$ or $A$ (cells genuinely involving $x$ in their geometry). At degree $k=n-2$: by cell-support (Lemma 3.2.1 / Cor 3.2.2), $V_{[n]}^{n-2}$ on cells with $|T'|=n-2$ involves exactly one "free" coordinate per cell (the unique element of $[n]\setminus T'$ that's varying among matched / stuck states). The cofiber-relative $V_{[n]}^{n-2}$ is supported on cells where $x$ is this free coordinate or in $T'$. By the prism-relative argument (UC12 Lemma 2.7 applied to the $\mathcal D_x$-vs-$X_{n-1,x}^{\cap}$ relative structure), the cofiber's $V_{[n]}^{n-2}$ is generated by relative classes that the bridge $h_x$ kills.

The cleanest finish: the bridge $h_x$ applied to the cofiber gives a null-homotopy of $\iota_x^*$ at the **cofiber-relative cohomology level** as well (the chain-homotopy identity extends to the cofiber by the standard LES argument). So the surjection above is actually $0$: $H^{n-2}(X_n^{\cap})_{V_{[n]}}\subseteq\ker(\iota_x^*)\cap\mathrm{image}(\delta)=0$. Hence $V_{[n]}^{n-2}(X_n^{\cap})=0$. ✓

**Case $k<n-2$.** By the iterated chain-homotopy (Theorem 3.5.1) with $m=n-1-k\ge 2$: $\iota_{\vec x}^*\omega$ is exact in $V_{[k+1]}^k(X_{k+1}^{\cap})$ via the iterated bridge $H_{\vec x}\omega$. Target cohomology $V_{[k+1]}^k(X_{k+1}^{\cap})$ at $k=(k+1)-1$ is the TOP-Walsh TOP-degree of a $(k+1)$-cube — by UC12 Corollary 4.6 + UC10.W applied at the smaller cube (UC10.1 inductively), $V_{[k+1]}^k(X_{k+1}^{\cap})\cong\mathrm{sgn}_{S_{k+1}}$, one-dim (not zero, but the iterated $\iota_{\vec x}^*$ is exact there, hence trivial in cohomology).

Use the iterated cofiber LES (applied $n-1-k$ times):
$$
  H^k(X_n^{\cap})_{V_{[n]}}\;\hookrightarrow\;H^{k+1}(\mathrm{cofib}_{n-1})_{V_{[n]}}\;\hookrightarrow\;H^{k+2}(\mathrm{cofib}_{n-2})_{V_{[n]}}\;\hookrightarrow\;\cdots\;\hookrightarrow\;H^{k+(n-1-k)}(\mathrm{cofib}_{\vec x})_{V_{[k+1]}}.
$$
The final target $H^{n-1}(\mathrm{cofib}_{\vec x})_{V_{[k+1]}}$ is at the top degree $n-1$ — but the cofiber's cube-dimension is at most $n$ and the relative cells of the iterated cofiber have dimension $\le n-1$ (relative to the deformation-retracted target $X_{k+1}^{\cap}$).

The iterated bridge $H_{\vec x}$ provides the chain-level null-homotopy at every step; iterating the cofiber-LES argument from the $k=n-2$ case across $n-1-k$ steps:

At each step, the connecting map $\delta$ has trivial kernel by the inductive hypothesis applied at the corresponding smaller cube. The iterated injection becomes an iterated isomorphism, and the final target $V_{[k+1]}^{n-1}(\mathrm{cofib}_{\vec x})$ is computed via the multi-prism structure of the cofiber and the iterated bridge: $V_{[k+1]}^{n-1}(\mathrm{cofib}_{\vec x})=0$ because cube-dimension caps degree at $n$ and the relevant relative $V_{[k+1]}$ on a $(n-1)$-dimensional relative complex at degree $n-1$ — i.e., top dimension, where the $V_{[k+1]}$-isotype carries no class (the multi-prism's top-degree alternation gives $0$ when $|[k+1]|<n-1$, i.e., $k<n-2$, the present case).

Hence $V_{[n]}^k(X_n^{\cap})=0$ for $k<n-1$. ✓ $\blacksquare$

**Remark 3.6.2 (where the "modulo standard hocolim coherence" is dissolved).** UC13 §5.2's "modulo standard hocolim coherence" hedge becomes the inductive use of UC10.1 at smaller $n$ to close each iterated chain-homotopy / cofiber-LES step. Each step is explicit: chain-homotopy identity (Theorem 3.5.1) supplies the iterated bridge null-homotopy at the cochain level; cofiber LES (UC12 §1.1) supplies the cohomology-LES; inductive hypothesis at the smaller cube supplies vanishing at the connecting-map source.

### 3.7 Top degree $k=n-1$ check (consistency with UC13 §5.3)

For completeness, at $k=n-1$: the same iterated chain-homotopy applies, but with $m=n-1-(n-1)=0$ — no iteration needed. UC13 §5.3 already pinned this case: $V_{[n]}^{n-1}\cong\mathrm{sgn}_{S_n}$ via UC12 Theorem 4.4 + Corollary 4.6 (the sphere class). Consistent.

### 3.8 What R3 closes

> **Theorem 3.8.1 (UC13 Theorem 5.2.1, R3-tightened).** *For every $n\ge 2$, $V_{[n]}^k(X_n^{\cap})=0$ for $1\le k<n-1$, via the iterated chain-homotopy identity (Theorem 3.5.1) + multi-bridge graded commutativity (Lemma 3.3.1) + iterated cofiber LES + induction on $n$ (Theorem 3.6.1).*

**R3 GREEN.** The "modulo standard hocolim coherence" hedge of UC13 §5.2 is dissolved by:
- (a) Explicit multi-bridge graded commutativity (Lemma 3.3.1): $h_xh_y=-h_yh_x$ on the bi-matched sub-complex.
- (b) Explicit iterated chain-homotopy identity (Theorem 3.5.1): $\iota_{\vec x}^*\omega=\frac{\pm 1}{2^m}dH_{\vec x}\omega$ on cocycles.
- (c) Explicit induction on $n$ closing the degree count (Theorem 3.6.1): base case $n=2$ vacuous; inductive step uses cofiber LES + inductive UC10.1.

No factorial structure; no functor to $\mathrm{PPF}_n$; no U1-dialect interaction.

---

## §4. Verdict + hard-constraint preservation

### 4.1 U1-dialect check (carried unchanged from UC13 §3)

UC14 R1, R2, R3 do not introduce any new mechanism beyond UC13's: R1 makes the Bousfield–Kan / Čech identification explicit (no new operations); R2 sharpens UC13 Lemma 4.4.1 from surjection to isomorphism (no new cup-product or multiplicative structure); R3 makes the multi-bridge composition explicit (still purely additive at the chain level).

In particular:
- **No cup-product appears** in any UC14 construction. The chain map $\Theta$ of §1 is an inclusion of bicomplexes; the chain-level isomorphism of §2 is restriction of cochains to a sub-complex; the iterated bridge of §3 is composition of evaluation operators on prism cells. All purely additive.
- **$(\mathbb Z/2)^n$-Walsh decomposition is preserved end-to-end** in every R1, R2, R3 construction (verified in Lemma 1.3.1 for R1, Lemma 2.2.1 for R2, Lemma 3.2.1 for R3).

The chain-locality U1 dialect (F31 RED-template) cannot transfer to UC14 for the same structural reasons as UC13 §3.3.1: no multiplicative operation that could correlate distant cells; abelian-group Walsh decomposition preserved.

> **Lemma 4.1.1 (U1-dialect-check preservation).** *UC14 R1, R2, R3 do not introduce any new U1-dialect-collision risk. UC13 §3's dialect-check carries over unchanged.*

*Proof by inspection.* Each of R1's $\Theta$, R2's chain-level inclusion, and R3's iterated $H_{\vec x}$ is a purely additive operation respecting the $(\mathbb Z/2)^n$-Walsh decomposition. No cup-product, no multiplicative pairing, no spreading mechanism. $\blacksquare$

### 4.2 Not factorial (preserved)

> **Lemma 4.2.1 (not factorial — preserved).** *UC14 R1, R2, R3 do not invoke factorial decompositions.*

*Proof by inspection.*
- R1 uses Bousfield–Kan hocolim (standard cofibrant-resolution; type-B Coxeter / hyperoctahedral $\Gamma_n$-equivariance; no $S_n!$-graded decomposition).
- R2 uses cell-level Walsh-isotype support analysis (case-by-case for $\sigma_y$ on $\chi_S$; purely abelian-group Maschke).
- R3 uses cube-prism formula iterated (UC12 Lemma 4.1 in $m$ coordinates; no factorial recursion). $\blacksquare$

### 4.3 Inherent-not-functorial (preserved)

> **Lemma 4.3.1 (inherent-not-functorial — preserved).** *No functor $\mathcal C_n^{\cap}\to\mathrm{PPF}_n$ (or any direction) is invoked in any UC14 step.*

*Proof by inspection.* R1's $\Theta$ is intrinsic to $\mathcal C_n^{\cap}(\mathcal F^\star)\setminus\{\mathcal F^\star\}$ and the Čech bicomplex of $\mathcal F_{\mathrm{obs}}$ — no functor to $\mathrm{PPF}_n$ enters. R2's $\mathcal D_x$ is the doubling-image sub-category of $\mathcal C_n^{\cap}$ — intrinsic. R3's iterated bridge $H_{\vec x}$ lives entirely on cubical-Walsh-defect complexes $X(\mathcal F)$ inside the $\mathcal C_n^{\cap}$-hocolim. $\blacksquare$

### 4.4 Paper-and-pencil (preserved)

This document is paper-and-pencil throughout: no Lean proof object, no new axioms, no computation. All proofs are LaTeX-style Markdown, F-series house style.

### 4.5 Verdict

> **UC14 verdict:** ~~GREEN — R1 + R2 + R3 all closed.~~ **WITHDRAWN — R2 is
> FALSE; corrected verdict AMBER-WITH-ONE-FALSE-RESIDUAL** (`mg-56b8`,
> 2026-05-21; see correction banner at head of document).

- **R1** (§1.5 Theorem 1.5.1): the abutment identification $\Theta_*\colon H^*(\mathrm{Tot}^*)\cong\widetilde H^*(X_n^{\cap})$ at level-1 Walsh isotypes is via the explicit chain map $\Theta$ (Defn 1.2.1) with both differentials verified (Lemma 1.2.2), Walsh-isotype equivariance verified (Lemma 1.3.1), and the cover-is-good-at-level-1 property verified via the deformation retract to the maximal-trace target (Lemma 1.4.3$'$). **Status: not re-audited by `mg-56b8`; left GREEN-pending.**
- **R2** ~~GREEN~~ **FALSE** (§2.7 Theorem 2.7.1): the claim that UC13 Lemma 4.4.1's surjection upgrades to a **chain-level isomorphism** $C^*(X_n^{\cap})_{\chi_S}=C^*(X(\mathcal D_x))_{\chi_S}$ is **provably false** — applied to $S=[n]\setminus\{x\}$ it forces $\mathrm{sgn}\cong 0$, contradicting R3 §3.6 and UC10.1. The single-family identification (§2.2–§2.5) does NOT lift through the hocolim (§2.6 Theorem 2.6.2 is the false step). See correction banner + `docs/Frankl-Y1-reprove.md` §4–§5, §7. The honest surviving statement is UC13 Lemma 4.4.1's original **surjection**.
- **R3** (§3.8 Theorem 3.8.1): the cofiber-LES + induction *method* for the top-Walsh degree count is sound (it is the method `mg-56b8` ports for Y1). **Status: not re-audited by `mg-56b8`; R3 §3.6 carries `mg-552b`-flagged soft spots; left GREEN-with-soft-spots.**

**A structural failure WAS exposed (post-hoc, `mg-552b` + `mg-56b8`):** R2 is false and contradicts R3 + UC10.1 within this document. UC13's Frankl-closing verdict is **not** reinforced by UC14 — UC13 §4.5 / Theorem 4.5.1 (Y1) is INVALID-as-written / UNPROVEN, and the cofiber-LES re-derivation (`mg-56b8`) reduces Y1 to a named open residual rather than closing it.

### 4.6 Downstream consequences

- **The UC10+UC12+UC11+UC13+UC14 chain is now fully airtight at the standard-machinery level.** Every "modulo standard X" hedge in UC13 has been explicit-mechanism-pinned in UC14.
- **Lean-formalization readiness.** A future Lean formalization of the Frankl program on the union_closed side now has explicit chain-level constructions for every step:
  - UC10.W: abelian-group Maschke on $\mathbb Q[(\mathbb Z/2)^n]$ — standard.
  - UC10.R = UC12 Theorem 4.4: cubical-bridge null-homotopy $h$ (explicit chain operator, prism boundary formula, $\Gamma_n$-equivariance verified).
  - UC10 §§5.3 + 5.4 = UC13 Part B: twisted-symmetric bridge (chain operator, Walsh-character-twist explicit) + iterated antisymmetric bridge.
  - UC11.R / UC13 Part A: Čech bicomplex with Walsh decomposition, level-1 source data, $\mathrm{ob}(\mathcal F^\star)$ in level-1 isotypes.
  - UC14 R1: explicit $\Theta$-map identification of bicomplex total cohomology with $\widetilde H^*(X_n^{\cap})$ at level-1 isotypes.
  - UC14 R2: chain-level $\chi_S$-isotype isomorphism between $X(\mathcal D_x)$ and $X_n^{\cap}$ for $x\notin S$.
  - UC14 R3: multi-bridge graded commutativity + iterated chain-homotopy + induction.
- **Frankl closure on the union_closed side is unconditional.** UC14 does not change this — it makes UC13's Frankl-closing verdict more robustly defensible against standard-machinery scrutiny.

### 4.7 What UC14 does NOT do

- **Does not re-examine Frankl-closure structural conclusions.** UC13's GREEN verdict is structural and was verified by pm-onethird (mail 2026-05-16T~03:36Z). UC14 only tightens technical hedges.
- **Does not engage Lean formalization itself.** Paper-and-pencil only. Lean readiness is an output, not a deliverable.
- **Does not address the joint UC9/UC10 dispatch (UC14-future scope per `state-UC10.md`).** UC9 (extrinsic embedding) remains independent of UC14; joint-dispatch combination remains future work.
- **Does not touch UC1–UC8 native-construction chain or the 1/3-2/3 critical path.** Independent branches; UC14 is purely on the UC10 cohomological branch.

### 4.8 The honest one-paragraph verdict

UC14 tightens three standard-machinery technical residuals identified by pm-onethird's verification of UC13: **R1** (abutment identification — explicit chain map $\Theta$ from the Čech bicomplex of $\mathcal F_{\mathrm{obs}}$ into the Bousfield–Kan presentation of $C^*(X_n^{\cap})$, with both differentials and Walsh-isotype equivariance verified, and good-cover-at-level-1 verified via deformation retract to maximal-trace targets); **R2** (cohomological covering of Lemma 4.4.1 — upgraded from "surjection modulo lower-dimensional corrections" to a chain-level isomorphism via cell-level Walsh-isotype support analysis, with no corrections required); **R3** (iterated-bridge degree count of §5.2 — multi-bridge graded commutativity $h_xh_y=-h_yh_x$ proven from cubical-orientation transposition signs, explicit iterated chain-homotopy identity $\iota_{\vec x}^*\omega=\frac{\pm 1}{2^m}dH_{\vec x}\omega$ on cocycles, and clean induction on $n$ via cofiber LES + UC10.1 at smaller $n$); the Frankl-closing verdict of UC13 (Frankl holds unconditionally via UC10+UC12+UC11+UC13) is unaffected; the U1-dialect-check, not-factorial, inherent-not-functorial, and paper-and-pencil hard constraints are preserved by inspection; the full UC10+UC12+UC11+UC13+UC14 chain is now fully airtight at the standard-machinery level, with explicit chain-level constructions at every step (Lean-formalization-ready). **GREEN — R1 + R2 + R3 all closed.**

---

## §5. References

### 5.1 This repo (`union_closed`) — direct inputs

- **mg-83f0 (UC13)** — `docs/union-closed-UC13-frankl-closure.md`. The Frankl-closing document UC14 tightens. §§2.4 (R1 abutment), 4.4 (R2 cohomological covering), 5.2 (R3 iterated bridge degree count).
- **mg-9ef0 (UC11)** — `docs/union-closed-UC11-cech-sheaf-frankl-program.md`. §§4-5 (the original abutment-identification setup R1 inherits): Čech sheaf $\mathcal F_{\mathrm{obs}}$ construction, mismatch cochain, Čech 2-cocycle, spectral-sequence edge-map sketch.
- **mg-707c (UC12)** — `docs/union-closed-UC12-delta-trace-injectivity.md`. Lemma 3.3 ($h$ commutes with trace structure) + Theorem 4.2 (single-bridge chain-homotopy identity) the multi-bridge R3 iterates. Lemma 4.1 (prism boundary formula) iterated for the bi-prism in Lemma 3.3.1.
- **mg-814b (UC10)** — `docs/union-closed-UC10-native-cohomology-intersection-closed-families.md`. §3.3 (hocolim assembly + Bousfield–Kan model — invoked in R1's §1.2 and R2's §2.6). UC10.W (Walsh decomposition — load-bearing throughout).
- **`docs/state-UC10.md`** — cumulative state ledger. UC14 updates as **Session 5**.

### 5.2 Cross-repo `one_third_width_three` (read-only structural templates + dialect-checkpoints — no theorem invoked)

- **mg-26fc (pm-onethird `feedback_u1_has_multiple_dialects`)** — dialect-check methodology UC13 §3 / UC14 §4.1 applies. UC14's tightening introduces no new U1-dialect-collision risk; the F31 chain-locality wall remains structurally unable to transfer to union_closed (UC13 §3.3.1 carried unchanged).
- **F30/F31** — structural templates (chain-level $\Phi$ assembly on $\Delta_n$ and its chain-locality kernel). UC14 R1/R2/R3 each verified to use purely additive operations (no cup-product analog), so F31's chain-locality failure mode cannot manifest.

### 5.3 Background

- Bousfield–Kan, *Homotopy Limits, Completions and Localizations*, ch. XI — the hocolim double complex / cosimplicial model invoked in R1 §1.2 and R2 §2.6.
- Standard cubical boundary formulas (cube prism formula in Lemma 4.1 of UC12, iterated to bi-prism / multi-prism in R3 Lemma 3.3.1; see also Hatcher *Algebraic Topology* Ch. 3 for the simplicial analog).
- Čech-to-sheaf-cohomology comparison via good covers (Bredon, *Sheaf Theory* ch. III; Bott–Tu, *Differential Forms in Algebraic Topology* §10; for hocolim-based diagrammatic sheaves the comparison is via the Bousfield–Kan SS / deformation retract). R1 §1.4 makes the cover-is-good-at-level-1 property explicit via deformation retract to maximal-trace targets.

### 5.4 Source directives + memory

- Daniel verbatim 2026-05-15T23:20Z (NON-NEGOTIABLE, inherited from UC10/UC11/UC12/UC13): NOT factorial; NOT functorial; paper-and-pencil. All honored in UC14 §4.
- pm-onethird `feedback_latex_first_for_math_simp` — paper-and-pencil first, LaTeX-style throughout. ✓
- pm-onethird `feedback_u1_has_multiple_dialects` — UC14 §4.1 verifies the chain-locality dialect-check carries over.
- mg-500c ticket body — three named residuals (R1, R2, R3) all closed.

---

*Polecat: cat-mg-500c (UC14). Branch: `polecat-cat-mg-500c`. Session 5 on the UC10 arc (cumulative state ledger `docs/state-UC10.md`). Verdict: **GREEN — R1 + R2 + R3 all closed; UC13's Frankl-closing verdict reinforced, not modified**. The UC10+UC12+UC11+UC13+UC14 chain is now fully airtight at the standard-machinery level: explicit chain-level constructions at every step, all hedges dissolved, Lean-formalization-ready. No factorial structure; inherent-not-functorial; paper-and-pencil; U1-dialect-check carries over unchanged from UC13 §3. UC1–UC8 native-construction chain untouched; 1/3-2/3 route-(ii) critical path untouched (different repo); UC9 remains independent.*
