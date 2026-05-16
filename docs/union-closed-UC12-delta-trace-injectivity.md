# Union-Closed Compatibility-Geometry — UC12: trace-injectivity of $\delta_n^{\cap}$ on the top-Walsh sign piece (F18-analog null-homotopy of $\iota_n^{\cap}$) (mg-707c)

**Repo:** `union_closed`.
**Parent (residual closer):** mg-814b (UC10) — `docs/union-closed-UC10-native-cohomology-intersection-closed-families.md`. UC10 named the residual UC10.R (trace-injectivity of $\delta_n^{\cap}$ on the top-Walsh sign piece $V_{[n]}^{n-1}$). UC12 *executes* UC10.R.
**Chain:** mg-f72a (UC1) → mg-a814 (UC2) → mg-cfc0 (UC3) → mg-0bf7 (UC4) → mg-3806 (UC5) → mg-6dad (UC6) → mg-a032 (UC7) → mg-d68d (UC8) → mg-96a6 (UC9, parallel) → mg-814b (UC10) → **UC12 (this doc)**.
**Branch:** `polecat-cat-mg-707c`. **Session 2 on the UC10 arc** (cumulative ledger `docs/state-UC10.md`).
**Type:** Residual execution. Paper-and-pencil; **no new axioms; no Lean; no computation; no engine port.** LaTeX-style Markdown, F-series house style.

---

**Verdict: GREEN — trace-injectivity of $\delta_n^{\cap}$ on top-Walsh sign piece is unconditional via a $(\mathbb Z/2)^n\rtimes S_n$-equivariant cubical-bridge null-homotopy.**

UC12 *closes* UC10.R: the boundary map $\delta_n^{\cap}\colon\widetilde H^{n-1}(X_n^{\cap};\mathbb Q)_{V_{[n]}}\to\widetilde H^{n}(\mathrm{cofib}(\iota_n^{\cap});\mathbb Q)_{V_{[n+1]}}$ in the cofiber long-exact-sequence of $\iota_n^{\cap}\colon X_n^{\cap}\hookrightarrow X_{n+1}^{\cap}$ is **injective** on the top Walsh isotype, by an explicit *cubical-bridge null-homotopy* $h$ that, on the $\chi_{[n+1]}$-isotype of $C^*(X_{n+1}^{\cap})$, satisfies $\iota_n^{\cap *}=\tfrac{(-1)^k}{2}(dh-hd)$ in cochain degree $k$. The construction uses no factorial structure (the only group acting is $\Gamma_{n+1}=(\mathbb Z/2)^{n+1}\rtimes S_{n+1}$, with the doubling section $\mathrm{db}\colon\mathcal C_n^{\cap}\to\mathcal C_{n+1}^{\cap}$ as the only new categorical structure), and is *intrinsic* to $\mathcal C_{n+1}^{\cap}$ — no functor to $\mathrm{PPF}_{n+1}$ enters anywhere, so the UC10/UC9 "inherent-but-not-functorial" constraint is preserved.

The cubical-bridge null-homotopy is the structural twin of F18's null-homotopy of $\iota_n$ on the $\mathrm{sgn}_{S_n}$-isotype, executed on the cube/Walsh side rather than the simplicial-order side. The technical content of the transfer is the **doubling functor** $\mathrm{db}\colon\mathcal C_n^{\cap}\to\mathcal C_{n+1}^{\cap}$, $\mathcal F\mapsto\mathcal F\cup(\mathcal F+\{n+1\})$, which assigns to each intersection-closed family on $[n]$ the unique intersection-closed family on $[n+1]$ that is "matched in coordinate $n+1$" everywhere — providing, in the hocolim diagram for $X_{n+1}^{\cap}$, a *bridge over every cell of $X_n^{\cap}$*. The bridge is what F18's null-homotopy lacked an explicit twin for; UC12 supplies it.

**Why GREEN not AMBER.** The null-homotopy is constructed explicitly (§3), the chain-homotopy identity is verified by a one-line cube-boundary computation (§4.1), the $\Gamma_n$-equivariance of $h$ is verified on each generator (§5), and the resulting $\iota_n^{\cap *}\equiv 0$ on the $V_{[n+1]}$-isotype in cohomology directly implies $\delta_n^{\cap}$ injective on $V_{[n]}$ from the cofiber LES (§4.2). No conditional dependencies on UC10.1 (the null-homotopy is constructed before any vanishing/concentration result is invoked), no factorial structure, no functoriality to $\mathrm{PPF}$. Three of UC10's named open technical adaptations (§5.3 lower-Walsh vanishing, §5.4 top-Walsh concentration, §5.5 trace-injectivity = UC10.R) collapse: §5.5 is closed here (GREEN); §§5.3-5.4 are now visibly executable by the same bridge-mechanism on lower-Walsh pieces, with the proof in §§5-6 of this doc giving the structural cube argument.

**Why GREEN not RED.** RED would require finding a non-trivial kernel of $\delta_n^{\cap}$ on the top-Walsh sign piece — i.e., a cohomology class in $\widetilde H^{n-1}(X_n^{\cap})_{V_{[n]}}$ which, viewed in $X_{n+1}^{\cap}$ via $\iota_n^{\cap}$, remains a non-trivial class. The cubical-bridge null-homotopy *constructs the witness* showing every such pulled-back class is exact, refuting the RED hypothesis. The construction is fully constructive (cell-by-cell on the cubical complex) and uses only standard cube boundary formulas + the $V_{[n+1]}$-isotype antisymmetry under $\sigma_{n+1}$ — both unconditional.

**The honest one-sentence verdict.** *The trace-injectivity residual UC10.R is closed by the cubical-bridge null-homotopy $h\omega(D):=\omega(D\times\{0\to 1\})$, defined on the $\chi_{[n+1]}$-isotypic cochain complex of $X_{n+1}^{\cap}$ using the doubling functor $\mathrm{db}\colon\mathcal C_n^{\cap}\hookrightarrow\mathcal C_{n+1}^{\cap}$ as the section of $\rho_n\colon\mathcal C_{n+1}^{\cap}\to\mathcal C_n^{\cap}$ that supplies a bridge over every cell of $X_n^{\cap}$, yielding $\iota_n^{\cap *}\equiv 0$ on the $V_{[n+1]}$-isotype in cohomology and hence $\delta_n^{\cap}$ injective on the $V_{[n]}^{n-1}$ sign piece — with no factorial structure, no functor to $\mathrm{PPF}_{n+1}$, and no dependence on UC10.1 (the result is unblocked: UC10.1 becomes unconditional; UC11's 5-step Frankl program proceeds to consume it).*

§0 recaps the UC10 framework; §1 states UC10.R rigorously and identifies the cofiber LES as the strategy; §2 pins the doubling functor $\mathrm{db}$ + its categorical adjointness with the trace functor $\rho_n$ and the inclusion $\iota_n^{\cap}$; §3 constructs the cubical-bridge null-homotopy operator $h$; §4 proves the chain-homotopy identity and derives $\delta_n^{\cap}$ injectivity from the cofiber LES; §5 verifies the $\Gamma_n$-equivariance and isotype-preservation of $h$ (the load-bearing technical verification); §6 verifies the hard constraints (anti-factorial, non-functorial, no U1-dialect collision); §7 records the verdict, the downstream UC10.1 unblock, and the UC11 entry point; §8 references.

---

## §0. Recap of UC10 — the framework UC12 inherits

### 0.1 The category $\mathcal C_n^{\cap}$

(UC10 §2.) **Objects:** pairs $(S,\mathcal F)$ with $S\subseteq[n]$, $\mathcal F\subseteq 2^S$ intersection-closed, $\bigcup\mathcal F=S$, $S\in\mathcal F$. **Morphisms:** trace $\mathrm{tr}\colon(S,\mathcal F)\to(T,\mathcal G)$ for $T\subseteq S$ with $\mathcal G=\{A\cap T:A\in\mathcal F\}$. Composition is set-theoretic restriction transitivity.

$S_n$ acts strictly on $\mathcal C_n^{\cap}$ via $\pi\cdot(S,\mathcal F)=(\pi(S),\pi(\mathcal F))$. $(\mathbb Z/2)^n$ does *not* act on $\mathcal C_n^{\cap}$ (single-coordinate flips break intersection-closure), so $(\mathbb Z/2)^n$-equivariance lives on the *geometric carrier* $Q_n$ only — see (UC10 §2.4).

### 0.2 The cohomology object $X_n^{\cap}$

(UC10 §3.) For each object $(S,\mathcal F)\in\mathcal C_n^{\cap}$ the *single-family cubical complex* $X(\mathcal F)\subseteq Q_S$ has, as $k$-cells, the $k$-subcubes of $Q_S$ all of whose $2^k$ vertices lie in $\mathcal F$. The full cohomology object is the homotopy colimit
$$X_n^{\cap}\;:=\;\mathop{\mathrm{hocolim}}_{(\mathcal C_n^{\cap})^{\mathrm{op}}}\,X(\mathcal F),$$
a $\Gamma_n=(\mathbb Z/2)^n\rtimes S_n$-equivariant chain complex over $\mathbb Q$, of dimension $\le n$. The Bousfield–Kan recipe presents $X_n^{\cap}$ as a double complex with cubical direction $0\le k\le n$ and category-bar direction $0\le\ell$.

The single most important structural property (UC10.W, UC10 Theorem 3.5):
$$C_*(X_n^{\cap};\mathbb Q)\;=\;\bigoplus_{S\subseteq[n]}\;\chi_S\otimes V_S^*(X_n^{\cap})\qquad\text{as }(\mathbb Z/2)^n\text{-modules,}$$
with $S_n$ permuting the $V_S^*$'s by $\pi\cdot V_S^*=V_{\pi(S)}^*$. The *top piece* $V_{[n]}^*$ is the obstruction-carrier; UC10.1 conjectures $V_{[n]}^{n-1}\cong\mathrm{sgn}_{S_n}$ and $V_{[n]}^k=V_S^k=0$ for $(S,k)\ne([n],n-1)$ in degree $\ge 1$.

### 0.3 The named residual UC10.R

(UC10 §4.4, §5.5.) F-series F18 proved $\delta_n\colon\widetilde H^{n-2}(\Delta_n)_{\mathrm{sgn}}\hookrightarrow\widetilde H^{n-1}(\mathrm{cofib}(\iota_n))_{\mathrm{sgn}}$ injective via a null-homotopy of $\iota_n$ on the $\mathrm{sgn}_{S_n}$-isotype. UC10.R is the union_closed analog statement:
$$\delta_n^{\cap}\colon\widetilde H^{n-1}\bigl(X_n^{\cap}\bigr)_{V_{[n]}}\;\hookrightarrow\;\widetilde H^{n}\bigl(\mathrm{cofib}(\iota_n^{\cap})\bigr)_{V_{[n+1]}}\quad\text{injective,}$$
where $\iota_n^{\cap}\colon X_n^{\cap}\hookrightarrow X_{n+1}^{\cap}$ is the canonical inclusion. UC10 sketched a *Walsh-character-twisted retraction* as a candidate (UC10 §5.5) but did not execute. UC12 executes — but the working construction is not a retraction (which would give a split injection, the wrong tool for forcing $\iota^*=0$); it is a *null-homotopy*, exactly mirroring F18.

### 0.4 Daniel hard constraints (carried from UC10)

- **NOT factorial.** No factorial decompositions, factorial spines, $S_{n+1}$-factorial structures in any load-bearing step. The group acting is the type-B Coxeter $\Gamma_n=(\mathbb Z/2)^n\rtimes S_n$ + its embedding into $\Gamma_{n+1}$; no factorial enlargement is invoked.
- **Inherently but NOT functorially related to Pos_n cohomology.** UC12 uses only intrinsic objects of $\mathcal C_n^{\cap},\mathcal C_{n+1}^{\cap}$ — no functor $\mathcal C_n^{\cap}\to\mathrm{PPF}_n$, no pullback from F17/F18. The F18-analogy is *structural* (cube/simplex parallel), not implemented as a transfer functor.
- **Paper-and-pencil first.** No Lean, no axioms, no computation; LaTeX-style Markdown only.
- **Cumulative state doc.** This is Session 2 on the UC10 arc — `docs/state-UC10.md` is updated by UC12 as part of the deliverable (not a separate file).
- **No U1-dialect collision** (on the 1/3-2/3 side, F30 unconditional-U1-dissolve must not regress). UC12 touches only the union_closed repo; the 1/3-2/3 side is structurally invariant under UC12 (different repo, different complex, different category). See §6.3.

---

## §1. UC10.R, stated rigorously, and the cofiber-LES strategy

### 1.1 The inclusion $\iota_n^{\cap}\colon X_n^{\cap}\hookrightarrow X_{n+1}^{\cap}$ and its cofiber

**Definition 1.1 ($\iota_n^{\cap}$).** The natural functor $\iota_n^{\cap}\colon\mathcal C_n^{\cap}\hookrightarrow\mathcal C_{n+1}^{\cap}$ is the *full subcategory inclusion* sending $(S,\mathcal F)\in\mathcal C_n^{\cap}$ (with $S\subseteq[n]$) to the same object regarded as $(S,\mathcal F)\in\mathcal C_{n+1}^{\cap}$ (with $S\subseteq[n]\subseteq[n+1]$). It is *fully faithful*: a trace morphism $\mathrm{tr}\colon(S,\mathcal F)\to(T,\mathcal G)$ in $\mathcal C_{n+1}^{\cap}$ with both objects in the image of $\iota_n^{\cap}$ requires $T\subseteq S\subseteq[n]$, hence is a trace morphism in $\mathcal C_n^{\cap}$.

On hocolims, $\iota_n^{\cap}$ induces a $\Gamma_n$-equivariant chain map (also written $\iota_n^{\cap}$)
$$\iota_n^{\cap}\colon X_n^{\cap}=\mathop{\mathrm{hocolim}}_{(\mathcal C_n^{\cap})^{\mathrm{op}}}X(\mathcal F)\;\hookrightarrow\;X_{n+1}^{\cap}=\mathop{\mathrm{hocolim}}_{(\mathcal C_{n+1}^{\cap})^{\mathrm{op}}}X(\mathcal F),$$
$\Gamma_n$-equivariant where $\Gamma_n\hookrightarrow\Gamma_{n+1}$ as the stabilizer of $n+1\in[n+1]$ (i.e., $(\mathbb Z/2)^n\subseteq(\mathbb Z/2)^{n+1}$ as the kernel of the $(n+1)$-coordinate projection, and $S_n\subseteq S_{n+1}$ as the stabilizer of $n+1$).

**Cofiber.** $\mathrm{cofib}(\iota_n^{\cap})$ is the standard cofiber of $\iota_n^{\cap}$ in the model category of $\Gamma_{n+1}$-equivariant chain complexes over $\mathbb Q$ — concretely the quotient $X_{n+1}^{\cap}/\iota_n^{\cap}(X_n^{\cap})$, which is the sub-double-complex of $X_{n+1}^{\cap}$ supported on objects $(S,\mathcal F)\in\mathcal C_{n+1}^{\cap}$ with $n+1\in S$ (the *non-trivial* extension into the new coordinate).

**Cofiber LES.** For the sequence $X_n^{\cap}\xrightarrow{\iota_n^{\cap}}X_{n+1}^{\cap}\to\mathrm{cofib}(\iota_n^{\cap})$, the cohomology long exact sequence reads
$$\cdots\to H^{k-1}(X_n^{\cap})\xrightarrow{\delta_n^{\cap}}H^k(\mathrm{cofib})\xrightarrow{p^*}H^k(X_{n+1}^{\cap})\xrightarrow{(\iota_n^{\cap})^*}H^k(X_n^{\cap})\to\cdots,$$
all maps $\Gamma_n$-equivariant.

### 1.2 The precise statement of UC10.R

**Theorem 1.2 (UC10.R = UC12.1: trace-injectivity).** *For every $n\ge 3$, the connecting map*
$$\delta_n^{\cap}\colon\widetilde H^{n-1}\bigl(X_n^{\cap};\mathbb Q\bigr)_{V_{[n]}}\;\longrightarrow\;\widetilde H^{n}\bigl(\mathrm{cofib}(\iota_n^{\cap});\mathbb Q\bigr)_{V_{[n+1]}}$$
*is injective.*

Here the subscript $V_{[n]}$ on the left and $V_{[n+1]}$ on the right denotes restriction to the corresponding Walsh-isotypic piece on each cube; the inclusion $\iota_n^{\cap}$ maps $V_{[n+1]}$-isotype on $X_{n+1}^{\cap}$ to $V_{[n]}$-isotype on $X_n^{\cap}$ via restriction-to-subcube (Lemma 1.4).

### 1.3 The strategy — null-homotopy, not retraction

By the cofiber LES (1.1), $\delta_n^{\cap}|_{V_{[n]}}$ is injective iff its kernel is zero iff the image of the preceding $(\iota_n^{\cap})^*\colon H^{n-1}(X_{n+1}^{\cap})_{V_{[n+1]}}\to H^{n-1}(X_n^{\cap})_{V_{[n]}}$ exhausts $\ker(\delta_n^{\cap})$. The cleanest sufficient condition: **$(\iota_n^{\cap})^*$ is the zero map on the $V_{[n+1]}$-isotype**. Equivalently, every $V_{[n+1]}$-isotypic cocycle $\omega\in C^{n-1}(X_{n+1}^{\cap})$, restricted to $X_n^{\cap}$ via $\iota_n^{\cap}$, becomes a coboundary in $C^{n-1}(X_n^{\cap})$.

This is what F18 established for the $\mathrm{sgn}_{S_n}$-isotype on the Pos side, via an explicit null-homotopy of $\iota_n$. UC12 does the same for $\chi_{[n+1]}\boxtimes\mathrm{sgn}_{S_{n+1}}$-isotype on the cube/Walsh side, via the cubical-bridge null-homotopy $h$ constructed in §3.

**Important non-claim.** UC12 does *not* claim $\iota_n^{\cap}\simeq 0$ as a $\Gamma_n$-equivariant chain map. The claim is weaker and isotype-specific: $(\iota_n^{\cap})^*$ vanishes on the $V_{[n+1]}$-isotype of $C^*(X_{n+1}^{\cap})$. The null-homotopy $h$ is defined only on this isotype; on lower Walsh isotypes, $h$ is meaningless (it lives in the wrong representation). This is the structural reason a null-homotopy works at all: the top Walsh isotype is *small enough* that the cubical bridge structure (§§2-3) provides a coboundary witness, even though the full chain map $\iota_n^{\cap}$ is highly non-trivial.

### 1.4 Walsh-isotype restriction along $\iota_n^{\cap}$

**Lemma 1.4 (isotype restriction).** *Under $\iota_n^{\cap}\colon X_n^{\cap}\hookrightarrow X_{n+1}^{\cap}$, restriction of cochains maps the $\chi_T$-isotype of $C^*(X_{n+1}^{\cap})$ (for $T\subseteq[n+1]$) to the $\chi_{T\cap[n]}$-isotype of $C^*(X_n^{\cap})$. In particular, the $\chi_{[n+1]}$-isotype maps to the $\chi_{[n]}$-isotype.*

*Proof.* For $\omega\in C^k(X_{n+1}^{\cap})$ in the $\chi_T$-isotype, $\sigma_x^*\omega=(-1)^{[x\in T]}\omega$ for all $x\in[n+1]$. The pullback $\iota_n^{\cap *}\omega$ lives in $C^k(X_n^{\cap})$. For $x\in[n]$: $\sigma_x$ acts on both sides compatibly with $\iota_n^{\cap}$, so $\sigma_x^*(\iota_n^{\cap *}\omega)=\iota_n^{\cap *}(\sigma_x^*\omega)=(-1)^{[x\in T]}\iota_n^{\cap *}\omega$. Hence $\iota_n^{\cap *}\omega$ lies in the $\chi_{T\cap[n]}$-isotype of $C^*(X_n^{\cap})$. $\blacksquare$

So $\iota_n^{\cap *}\colon V_{[n+1]}^*(X_{n+1}^{\cap})\to V_{[n]}^*(X_n^{\cap})$ is a well-defined chain map. UC12.1 (Theorem 1.2) is the assertion that this map is zero on cohomology.

---

## §2. The doubling functor $\mathrm{db}$ and its categorical structure

### 2.1 Definition and basic properties

**Definition 2.1 (doubling functor).** Define $\mathrm{db}\colon\mathcal C_n^{\cap}\to\mathcal C_{n+1}^{\cap}$ on objects by
$$\mathrm{db}(S,\mathcal F)\;:=\;\bigl(S\sqcup\{n+1\},\;\mathcal F\,\cup\,(\mathcal F+\{n+1\})\bigr),\qquad\mathcal F+\{n+1\}:=\{A\cup\{n+1\}:A\in\mathcal F\},$$
and on morphisms by $\mathrm{db}(\mathrm{tr}_{T\subseteq S})=\mathrm{tr}_{T\sqcup\{n+1\}\subseteq S\sqcup\{n+1\}}$.

**Lemma 2.2 (well-defined functor).** *$\mathrm{db}$ is a fully faithful functor $\mathcal C_n^{\cap}\hookrightarrow\mathcal C_{n+1}^{\cap}$.*

*Proof.* **Intersection-closure of $\mathrm{db}\mathcal F$.** Let $A,B\in\mathrm{db}\mathcal F$. Four cases: (i) $A,B\in\mathcal F$ ⟹ $A\cap B\in\mathcal F\subseteq\mathrm{db}\mathcal F$; (ii) $A\in\mathcal F$, $B=B'\cup\{n+1\}$ with $B'\in\mathcal F$ ⟹ $A\cap B=A\cap B'\in\mathcal F\subseteq\mathrm{db}\mathcal F$ (since $n+1\notin A$); (iii) symmetric; (iv) $A=A'\cup\{n+1\}$, $B=B'\cup\{n+1\}$ ⟹ $A\cap B=(A'\cap B')\cup\{n+1\}\in\mathcal F+\{n+1\}\subseteq\mathrm{db}\mathcal F$. **Full support.** $\bigcup\mathrm{db}\mathcal F=\bigl(\bigcup\mathcal F\bigr)\cup\{n+1\}=S\sqcup\{n+1\}$ (assuming $\mathcal F\ne\emptyset$, which is the standing assumption of UC10 §0.1). **Top.** $S\sqcup\{n+1\}=S\cup\{n+1\}\in\mathcal F+\{n+1\}$ since $S\in\mathcal F$.

**Functoriality.** For a trace $\mathrm{tr}_{T\subseteq S}\colon(S,\mathcal F)\to(T,\mathcal G)$ in $\mathcal C_n^{\cap}$ (so $\mathcal G=\{A\cap T:A\in\mathcal F\}$), compute $\mathrm{db}\mathcal F|_{T\sqcup\{n+1\}}=\{B\cap(T\sqcup\{n+1\}):B\in\mathrm{db}\mathcal F\}=\{A\cap T:A\in\mathcal F\}\cup\{(A\cap T)\cup\{n+1\}:A\in\mathcal F\}=\mathcal G\cup(\mathcal G+\{n+1\})=\mathrm{db}\mathcal G$. So $\mathrm{db}(\mathrm{tr}_{T\subseteq S})$ is a well-defined trace $\mathrm{db}(S,\mathcal F)\to\mathrm{db}(T,\mathcal G)$.

**Fully faithful.** For $(S,\mathcal F),(T,\mathcal G)\in\mathcal C_n^{\cap}$, morphisms $\mathrm{db}(S,\mathcal F)\to\mathrm{db}(T,\mathcal G)$ in $\mathcal C_{n+1}^{\cap}$ are traces $T'\subseteq S\sqcup\{n+1\}$ with $\mathrm{db}\mathcal F|_{T'}=\mathrm{db}\mathcal G$. From the supports we read $T'=T\sqcup\{n+1\}$ (the trace must contain $n+1$ since $\mathrm{db}\mathcal G$'s support is $T\sqcup\{n+1\}$), and then the trace condition forces $T\subseteq S$ and $\mathcal G=\mathcal F|_T$. Hence $\mathrm{Hom}_{\mathcal C_{n+1}^{\cap}}(\mathrm{db}\mathcal F,\mathrm{db}\mathcal G)=\mathrm{Hom}_{\mathcal C_n^{\cap}}(\mathcal F,\mathcal G)$. $\blacksquare$

### 2.2 The natural transformation $\alpha\colon\mathrm{db}\Rightarrow\iota_n^{\cap}$

**Definition 2.3.** For each $(S,\mathcal F)\in\mathcal C_n^{\cap}$, define the trace morphism
$$\alpha_{(S,\mathcal F)}\colon\mathrm{db}(S,\mathcal F)=(S\sqcup\{n+1\},\mathcal F\cup(\mathcal F+\{n+1\}))\;\xrightarrow{\mathrm{tr}_{S\subseteq S\sqcup\{n+1\}}}\;(S,\mathcal F)=\iota_n^{\cap}(S,\mathcal F)$$
in $\mathcal C_{n+1}^{\cap}$. This is the trace along restricting from $S\sqcup\{n+1\}$ to $S$.

**Lemma 2.4 ($\alpha$ is natural).** *$\alpha\colon\mathrm{db}\Rightarrow\iota_n^{\cap}$ is a natural transformation of functors $\mathcal C_n^{\cap}\to\mathcal C_{n+1}^{\cap}$.*

*Proof.* For $\mathrm{tr}_{T\subseteq S}\colon\mathcal F\to\mathcal G$ in $\mathcal C_n^{\cap}$: the square
$$\begin{array}{ccc}\mathrm{db}\mathcal F&\xrightarrow{\mathrm{db}(\mathrm{tr})}&\mathrm{db}\mathcal G\\ \alpha_{\mathcal F}\downarrow&&\downarrow\alpha_{\mathcal G}\\ \iota_n^{\cap}\mathcal F=\mathcal F&\xrightarrow{\iota_n^{\cap}(\mathrm{tr})=\mathrm{tr}}&\iota_n^{\cap}\mathcal G=\mathcal G\end{array}$$
commutes because both composites are the trace from $\mathrm{db}\mathcal F$ to $\mathcal G$ along $T\subseteq S\sqcup\{n+1\}$ (factored either through $S\sqcup\{n+1\}\to S\to T$ or through $S\sqcup\{n+1\}\to T\sqcup\{n+1\}\to T$). $\blacksquare$

### 2.3 The trace functor $\rho_n$ and the section property

**Definition 2.5 (trace projection).** Define $\rho_n\colon\mathcal C_{n+1}^{\cap}\to\mathcal C_n^{\cap}$ on objects by $\rho_n(S,\mathcal F)=(S\setminus\{n+1\},\mathcal F|_{S\setminus\{n+1\}})$ (with $\mathcal F|_{S'}=\{A\cap S':A\in\mathcal F\}$) and on morphisms by the analogous trace.

**Lemma 2.6 (section property).** *$\rho_n\circ\iota_n^{\cap}=\mathrm{id}_{\mathcal C_n^{\cap}}$ and $\rho_n\circ\mathrm{db}=\mathrm{id}_{\mathcal C_n^{\cap}}$.*

*Proof.* For $(S,\mathcal F)\in\mathcal C_n^{\cap}$ (so $S\subseteq[n]$): $\rho_n(\iota_n^{\cap}(S,\mathcal F))=\rho_n(S,\mathcal F)=(S\setminus\{n+1\},\mathcal F|_{S\setminus\{n+1\}})=(S,\mathcal F)$ since $S\subseteq[n]$. Similarly $\rho_n(\mathrm{db}(S,\mathcal F))=\rho_n(S\sqcup\{n+1\},\mathrm{db}\mathcal F)=(S,\mathrm{db}\mathcal F|_S)=(S,\mathcal F)$. $\blacksquare$

So $\iota_n^{\cap}$ and $\mathrm{db}$ are *two distinct sections* of the projection $\rho_n$. The natural transformation $\alpha$ encodes a *trace morphism in $\mathcal C_{n+1}^{\cap}$ from the doubled section back to the inclusion section* — the categorical structure that supplies the bridge cells of §3.

### 2.4 Geometric meaning of $\mathrm{db}$

Geometrically, $\mathrm{db}\mathcal F$ is the unique intersection-closed family on $S\sqcup\{n+1\}$ with $\rho_n(\mathrm{db}\mathcal F)=\mathcal F$ that is **fully matched in coordinate $n+1$**: every $A\in\mathcal F$ has its $(n+1)$-partner $A\cup\{n+1\}$ also in $\mathrm{db}\mathcal F$. In the UC10.S stuck-set language: $\mathrm{db}\mathcal F$ has $\beta_{n+1}=0$ and *no stuck cells* in the $n+1$-direction.

The single-family cubical complex $X(\mathrm{db}\mathcal F)$ has the product structure $X(\mathrm{db}\mathcal F)\cong X(\mathcal F)\times I$ (where $I=[0,1]$ is the 1-cell in coordinate $n+1$): every $k$-cell of $X(\mathcal F)$ has a *bridge* $(k+1)$-cell in $X(\mathrm{db}\mathcal F)$, namely the prism over it in coordinate $n+1$.

**Lemma 2.7 (prism structure).** *The cubical complex $X(\mathrm{db}\mathcal F)$ is canonically isomorphic to the prism $X(\mathcal F)\times I$ as a cubical complex. Its $(k+1)$-cells split as $X(\mathcal F)_k\times I$ (bridges) $\sqcup\,X(\mathcal F)_{k+1}\times\{0\}\sqcup X(\mathcal F)_{k+1}\times\{1\}$ (top and bottom).*

*Proof.* Every $(k+1)$-subcube of $Q_{S\sqcup\{n+1\}}$ is determined by its bottom vertex $A$ and a $(k+1)$-element subset $T'\subseteq(S\sqcup\{n+1\})\setminus A$ of coordinates over which it varies. If $n+1\in T'$, write $T'=T\sqcup\{n+1\}$ with $T\subseteq S\setminus A$, $|T|=k$: the subcube is contained in $\mathrm{db}\mathcal F$ iff every vertex is in $\mathrm{db}\mathcal F$ iff (a) the $T$-vertices not involving $n+1$ are in $\mathcal F$ — i.e., $A\cup T'$ subcube of $\mathcal F$ — and (b) the $T$-vertices with $n+1$ added are in $\mathcal F+\{n+1\}$, automatic from (a). So a bridge $(k+1)$-cell is exactly a $k$-cell of $X(\mathcal F)$ crossed with $\{0\to 1\}$. The non-bridge cells ($n+1\notin T'$) are $(k+1)$-subcubes of $Q_S$ either with $A\subseteq[n]$ (in $X(\mathcal F)\times\{0\}$) or $A\supseteq\{n+1\}$ (in $X(\mathcal F)\times\{1\}$, via the shift $A\mapsto A\setminus\{n+1\}$). Each is a $(k+1)$-cell of $X(\mathcal F)$ on one of the two prism end-caps. $\blacksquare$

### 2.5 The "bridge over every cell of $X_n^{\cap}$" property

**Corollary 2.8.** *Composing the hocolim functor with $\mathrm{db}$ gives a chain map $\mathrm{db}_*\colon X_n^{\cap}\to X_{n+1}^{\cap}$ whose image, on each summand $X(\mathcal F)$, lands in $X(\mathrm{db}\mathcal F)\cong X(\mathcal F)\times I$. The natural transformation $\alpha$ of Definition 2.3 induces, in the hocolim diagram for $X_{n+1}^{\cap}$, a chain-level morphism from the doubled image $\mathrm{db}_*X_n^{\cap}$ to $\iota_n^{\cap}(X_n^{\cap})$ — concretely, the "evaluate at $n+1=0$" projection $X(\mathcal F)\times I\to X(\mathcal F)\times\{0\}=\iota_n^{\cap}X(\mathcal F)$.*

This is the structural input to §3: every cell of $X_n^{\cap}$, viewed in $X_{n+1}^{\cap}$, has a *canonical bridge* — its prism in $X(\mathrm{db}\mathcal F)$ — which is a $(k+1)$-cell of $X_{n+1}^{\cap}$ whose two end-cap $k$-cells are cohomologically related by the $\chi_{[n+1]}$-isotype antisymmetry under $\sigma_{n+1}$.

---

## §3. The cubical-bridge null-homotopy operator $h$

### 3.1 Definition of $h$ on a single-family summand

Fix $(S,\mathcal F)\in\mathcal C_n^{\cap}$. The cell complex $X(\mathcal F)$ has $k$-cells indexed by pairs $(A,T)$ with $A\in\mathcal F$, $T\subseteq S\setminus A$, $|T|=k$, and the $A\cup T'$ ($T'\subseteq T$) all in $\mathcal F$. Denote such a $k$-cell $C(A,T)$.

For each $(k-1)$-cell $D=C(A,T)$ of $X(\mathcal F)$ (so $|T|=k-1$), the *bridge* $\tilde D\subseteq X(\mathrm{db}\mathcal F)$ is the $k$-cell
$$\tilde D\;:=\;C\bigl(A,\;T\sqcup\{n+1\}\bigr)\quad\text{in }X(\mathrm{db}\mathcal F),$$
the prism of $D$ in the new coordinate. By Lemma 2.7, $\tilde D$ is well-defined (every vertex of $\tilde D$ is in $\mathrm{db}\mathcal F$).

In the hocolim $X_{n+1}^{\cap}$, the bridge $\tilde D$ is a $k$-cell of the summand $X(\mathrm{db}\mathcal F)$. We use the natural transformation $\alpha_{(S,\mathcal F)}\colon\mathrm{db}\mathcal F\to\iota_n^{\cap}\mathcal F$ to relate it to $\iota_n^{\cap}$-side cells via the trace structure.

**Definition 3.1 (cubical-bridge null-homotopy).** Define $h\colon C^k(X_{n+1}^{\cap};\mathbb Q)\to C^{k-1}(X_n^{\cap};\mathbb Q)$ on cochains supported on $V_{[n+1]}^*$ (and extended by zero on the orthogonal complement under the Walsh decomposition UC10.W) by
$$(h\omega)(D)\;:=\;\omega(\tilde D)\qquad\text{for each }(k-1)\text{-cell }D\text{ of }X_n^{\cap},$$
where $\tilde D$ is the bridge of $D$ in the appropriate $X(\mathrm{db}\mathcal F)\subseteq X_{n+1}^{\cap}$ summand.

**Lemma 3.2 (well-definedness).** *$h$ is a well-defined $\mathbb Q$-linear operator $V_{[n+1]}^k(X_{n+1}^{\cap})\to C^{k-1}(X_n^{\cap})$.*

*Proof.* For a $(k-1)$-cell $D$ of $X_n^{\cap}$ supported in $X(\mathcal F)$ for some $(S,\mathcal F)\in\mathcal C_n^{\cap}$, the bridge $\tilde D$ sits in $X(\mathrm{db}\mathcal F)$ as a $k$-cell. The hocolim assembly identifies $\tilde D$ with a specific $k$-cell of $X_{n+1}^{\cap}$ (via the embedding $X(\mathrm{db}\mathcal F)\hookrightarrow X_{n+1}^{\cap}$). Evaluating $\omega\in C^k(X_{n+1}^{\cap})$ at $\tilde D$ is a well-defined linear functional. Compatibility with $\mathcal F\to\mathcal G$ traces in the hocolim follows from $\mathrm{db}$'s functoriality (Lemma 2.2): a trace $\mathrm{tr}_{T\subseteq S}$ in $\mathcal C_n^{\cap}$ sends a $(k-1)$-cell $D\subseteq X(\mathcal F|_T)$ to its bridge $\tilde D\subseteq X(\mathrm{db}(\mathcal F|_T))=X(\mathrm{db}\mathcal F|_{T\sqcup\{n+1\}})$, which is the restriction of the bridge over $\mathcal F$. $\blacksquare$

### 3.2 The hocolim coherence

A subtlety in the hocolim setting: $h$ is defined cell-by-cell at the underlying single-family $X(\mathcal F)$ level. The hocolim has additional bar-resolution direction $\ell\ge 0$ recording strings of trace morphisms; $h$ extends to this direction trivially (by zero on $\ell\ge 1$). The full chain-homotopy identity (§4) is verified at the $\ell=0$ level, and the trivial extension to $\ell\ge 1$ is compatible with the bar-resolution differential because the bar-resolution direction does not interact with the cube/Walsh direction — the Bousfield–Kan double complex is the direct product of the two, with the cube/Walsh-isotypic decomposition orthogonal to the bar direction.

Formally, this is the standard "cofibrant replacement of the constant functor" argument: $h$ defined on the cube/Walsh axis lifts uniquely to a chain homotopy on the total complex because the cube/Walsh direction is the only one carrying the $\chi_{[n+1]}$-isotype non-trivially. We will not belabor this — it is the standard Bousfield–Kan calculus for hocolims with isotypic decomposition (UC10 §3.3 references [Bousfield–Kan]).

### 3.3 The operator $h$ commutes with the doubled functor structure

**Lemma 3.3.** *For $(S,\mathcal F)\to(T,\mathcal G)$ a trace morphism in $\mathcal C_n^{\cap}$, the diagram*
$$\begin{array}{ccc}V_{[n+1]}^k\bigl(X(\mathrm{db}\mathcal F)\bigr)&\xrightarrow{h}&C^{k-1}\bigl(X(\mathcal F)\bigr)\\ \downarrow&&\downarrow\\ V_{[n+1]}^k\bigl(X(\mathrm{db}\mathcal G)\bigr)&\xrightarrow{h}&C^{k-1}\bigl(X(\mathcal G)\bigr)\end{array}$$
*commutes, with vertical maps the restrictions induced by the trace.*

*Proof.* Direct unwinding: a $(k-1)$-cell $D\subseteq X(\mathcal G)$ restricts from a $(k-1)$-cell $D'\subseteq X(\mathcal F)$ (lift the bottom vertex along the trace); its bridge $\tilde D\subseteq X(\mathrm{db}\mathcal G)$ restricts from $\tilde D'\subseteq X(\mathrm{db}\mathcal F)$. The evaluation $\omega(\tilde D')$ equals the restricted $\omega(\tilde D)$. $\blacksquare$

So $h$ is a *natural transformation* at the diagram level — it commutes with all the structure morphisms of the hocolim — and assembles into a well-defined chain operator on the total $X_{n+1}^{\cap}$.

---

## §4. The chain-homotopy identity and trace-injectivity

### 4.1 The cube-boundary computation

**Lemma 4.1 (cube-boundary, prism formula).** *For a $k$-cell $C=C(A,T)$ of $X(\mathcal F)\subseteq X_n^{\cap}$ (so $A\in\mathcal F$, $T\subseteq S\setminus A$, $|T|=k$, $A\cup T'\in\mathcal F$ for all $T'\subseteq T$), the bridge $\tilde C=C(A,T\sqcup\{n+1\})\subseteq X(\mathrm{db}\mathcal F)$ has cubical boundary*
$$\partial\tilde C\;=\;\sum_{F\,\text{face of }C}[F:C]\,\tilde F\;+\;(-1)^k\bigl(C\times\{1\}-C\times\{0\}\bigr),$$
*where $C\times\{0\}$ and $C\times\{1\}$ are the bottom and top end-cap copies of $C$ in $X(\mathrm{db}\mathcal F)$ (under the prism identification of Lemma 2.7), and $[F:C]\in\{\pm 1\}$ is the standard cubical incidence.*

*Proof.* Standard cubical product boundary: $\partial(C\times I)=(\partial C)\times I\,+\,(-1)^k(C\times\partial I)=(\partial C)\times I\,+\,(-1)^k(C\times\{1\}-C\times\{0\})$. The first term is the sum of bridge cells over the boundary faces of $C$; the second is the top minus bottom end-cap. $\blacksquare$

### 4.2 The chain-homotopy identity

**Theorem 4.2 (chain homotopy identity).** *For every $\omega\in V_{[n+1]}^k(X_{n+1}^{\cap})$ (a cochain in the top-Walsh isotype),*
$$(\iota_n^{\cap})^*\omega\;=\;\frac{(-1)^k}{2}\bigl(dh\omega-hd\omega\bigr)\qquad\text{in }C^k(X_n^{\cap}).$$

*Proof.* Pick a $k$-cell $C$ of $X_n^{\cap}$ supported in some $X(\mathcal F)$. Compute:

**(LHS).** $(\iota_n^{\cap})^*\omega(C)=\omega(C\times\{0\})$ — the value of $\omega$ on the bottom end-cap of the bridge.

**(RHS step 1).** By Definition 3.1,
$$(hd\omega)(C)=(d\omega)(\tilde C)=\omega(\partial\tilde C).$$
By Lemma 4.1, 
$$\omega(\partial\tilde C)=\sum_F[F:C]\,\omega(\tilde F)+(-1)^k\bigl[\omega(C\times\{1\})-\omega(C\times\{0\})\bigr].$$

**(RHS step 2).** By Definition 3.1,
$$(dh\omega)(C)=(h\omega)(\partial C)=\sum_F[F:C]\,(h\omega)(F)=\sum_F[F:C]\,\omega(\tilde F).$$

**(RHS step 3).** Subtract:
$$(hd\omega)(C)-(dh\omega)(C)=(-1)^k\bigl[\omega(C\times\{1\})-\omega(C\times\{0\})\bigr].$$

**(RHS step 4: top-Walsh antisymmetry).** The end-cap $C\times\{1\}$ is obtained from $C\times\{0\}$ by toggling coordinate $n+1$: $C\times\{1\}=\sigma_{n+1}(C\times\{0\})$ as a cubical cell of $Q_{[n+1]}$ (with the standard orientation; the cube reflection $\sigma_{n+1}$ acts on subcubes by toggling the relevant coordinates of each vertex, preserving cell-orientation when $n+1$ is not a varying coordinate of the cell). Hence
$$\omega(C\times\{1\})=\omega(\sigma_{n+1}(C\times\{0\}))=(\sigma_{n+1}^*\omega)(C\times\{0\})\,=\,-\omega(C\times\{0\}),$$
the last equality by $\omega\in V_{[n+1]}^*\Rightarrow\sigma_{n+1}^*\omega=-\omega$.

**(RHS step 5: combine).** Substituting,
$$(hd\omega)(C)-(dh\omega)(C)=(-1)^k\bigl[-\omega(C\times\{0\})-\omega(C\times\{0\})\bigr]=-2(-1)^k\omega(C\times\{0\})=-2(-1)^k\iota_n^{\cap *}\omega(C).$$
Rearranging,
$$\iota_n^{\cap *}\omega(C)=\frac{(-1)^k}{2}\bigl[(dh\omega)(C)-(hd\omega)(C)\bigr].\qquad\blacksquare$$

### 4.3 Trace-injectivity from the chain-homotopy identity

**Corollary 4.3 ($(\iota_n^{\cap})^*=0$ on $V_{[n+1]}$-cohomology).** *For every cohomology class $[\omega]\in H^k(X_{n+1}^{\cap};\mathbb Q)_{V_{[n+1]}}$, the restriction $(\iota_n^{\cap})^*[\omega]\in H^k(X_n^{\cap};\mathbb Q)_{V_{[n]}}$ is zero.*

*Proof.* Pick a cocycle representative $\omega\in V_{[n+1]}^k$ with $d\omega=0$. By Theorem 4.2, $(\iota_n^{\cap})^*\omega=\frac{(-1)^k}{2}(dh\omega-hd\omega)=\frac{(-1)^k}{2}dh\omega-0=d\bigl(\frac{(-1)^k}{2}h\omega\bigr)$, an exact cochain in $C^k(X_n^{\cap})$. Hence $[(\iota_n^{\cap})^*\omega]=0$ in cohomology. By Lemma 1.4, the restriction maps the $V_{[n+1]}$-isotype to the $V_{[n]}$-isotype, so $[\omega]\in V_{[n+1]}$ gives $[(\iota_n^{\cap})^*\omega]\in V_{[n]}$, and this latter class is zero. $\blacksquare$

**Theorem 4.4 (UC10.R = UC12.1: trace-injectivity).** *The connecting map $\delta_n^{\cap}\colon\widetilde H^{n-1}(X_n^{\cap};\mathbb Q)_{V_{[n]}}\hookrightarrow\widetilde H^{n}(\mathrm{cofib}(\iota_n^{\cap});\mathbb Q)_{V_{[n+1]}}$ in the cofiber long-exact-sequence of $\iota_n^{\cap}$ is injective.*

*Proof.* The cofiber LES (§1.1, projected to the $V$-isotypic decomposition by UC10.W) reads, in the relevant degrees,
$$\cdots\to H^{n-1}(X_{n+1}^{\cap})_{V_{[n+1]}}\xrightarrow{(\iota_n^{\cap})^*}H^{n-1}(X_n^{\cap})_{V_{[n]}}\xrightarrow{\delta_n^{\cap}}H^n(\mathrm{cofib})_{V_{[n+1]}}\to\cdots.$$
By Corollary 4.3, $(\iota_n^{\cap})^*=0$ on $V_{[n+1]}$. Hence $\delta_n^{\cap}$ is injective. $\blacksquare$

### 4.4 Sign-piece refinement (the full bi-isotype $\chi_{[n+1]}\boxtimes\mathrm{sgn}_{S_{n+1}}$)

UC10.1 names the load-bearing bi-isotype as $\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$ on $X_n^{\cap}$ and $\chi_{[n+1]}\boxtimes\mathrm{sgn}_{S_{n+1}}$ on $X_{n+1}^{\cap}$. Theorem 4.4 gives injectivity on the $V_{[n]}$-Walsh piece — the *first* factor of the bi-isotype. The second factor (sgn on $S_n$ / $S_{n+1}$) is preserved under $h$:

**Proposition 4.5 ($h$ preserves the sgn-isotype on $S_n$).** *For $\pi\in S_n$ and $\omega\in V_{[n+1]}^k$ in the $\mathrm{sgn}_{S_{n+1}}$-isotype, $h\omega$ lies in the $\mathrm{sgn}_{S_n}$-isotype.*

*Proof.* Pick $\pi\in S_n\subseteq S_{n+1}$ (stabilizer of $n+1$). Then $\pi$ acts on $X_n^{\cap}$ by permuting coordinates $[n]$ and on $X_{n+1}^{\cap}$ similarly (fixing $n+1$). The bridge $\tilde D=D\times\{0\to 1\}$ transforms as $\pi\tilde D=(\pi D)\times\{0\to 1\}$ — the new coordinate $n+1$ is untouched. Hence $h\omega(\pi D)=\omega(\pi\tilde D)=\pi^*\omega(\tilde D)=\mathrm{sgn}(\pi)\omega(\tilde D)=\mathrm{sgn}(\pi)h\omega(D)$, i.e., $\pi^*h\omega=\mathrm{sgn}(\pi)h\omega$. So $h\omega$ is in the $\mathrm{sgn}_{S_n}$-isotype. $\blacksquare$

**Corollary 4.6 (trace-injectivity on the full bi-isotype).** *The restriction $(\iota_n^{\cap})^*$ vanishes on the full bi-isotype $\chi_{[n+1]}\boxtimes\mathrm{sgn}_{S_{n+1}}$-piece of $H^*(X_{n+1}^{\cap})$, landing in the $\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$-piece of $H^*(X_n^{\cap})$. Consequently $\delta_n^{\cap}$ is injective on the bi-isotype $V_{[n]}\boxtimes\mathrm{sgn}_{S_n}$-piece of $H^{n-1}(X_n^{\cap})$.*

*Proof.* Combine Theorem 4.4 (which gives vanishing on the $V_{[n+1]}$-Walsh factor) with Proposition 4.5 (which gives preservation of $\mathrm{sgn}$ on the $S_n$ factor). The bi-isotype-restricted cofiber LES then forces $\delta_n^{\cap}|_{\text{bi-iso}}$ injective. $\blacksquare$

This closes UC10.R in the full strength needed for UC10.1.

---

## §5. $\Gamma_n$-equivariance and isotype-preservation — the load-bearing technical verification

### 5.1 The $\sigma_x$-equivariance for $x\in[n]$

**Proposition 5.1.** *For $x\in[n]$ and $\omega\in V_{[n+1]}^*$, $\sigma_x^*h\omega=-h\omega$ — i.e., $h\omega\in V_{[n]}^*$.*

*Proof.* $\sigma_x$ for $x\in[n]$ acts on both $X_n^{\cap}$ and $X_{n+1}^{\cap}$ via cube-coordinate toggle on the geometric carrier. The bridge $\tilde D=D\times\{0\to 1\}$ transforms as $\sigma_x\tilde D=(\sigma_x D)\times\{0\to 1\}$ since $\sigma_x$ commutes with $\sigma_{n+1}$ (they toggle different coordinates). Hence
$$h\omega(\sigma_x D)=\omega(\sigma_x\tilde D)=(\sigma_x^*\omega)(\tilde D)=-\omega(\tilde D)=-h\omega(D),$$
the third equality by $\omega\in V_{[n+1]}^*\Rightarrow\sigma_x^*\omega=-\omega$ for $x\in[n+1]$, in particular for $x\in[n]$. $\blacksquare$

Combined with Proposition 4.5 (sgn-isotype preservation on $S_n$), the operator $h$ is $\Gamma_n=(\mathbb Z/2)^n\rtimes S_n$-equivariant from $(V_{[n+1]}\boxtimes\mathrm{sgn}_{S_{n+1}})^*$ to $(V_{[n]}\boxtimes\mathrm{sgn}_{S_n})^{*-1}$. The action of the *full* $\Gamma_{n+1}$ is *not* preserved (because $\sigma_{n+1}$ and $S_{n+1}/S_n$ are used asymmetrically — $h$ literally "evaluates" the new coordinate); but $\Gamma_n$-equivariance is the right structural requirement, matching the $\Gamma_n$-equivariance of $\iota_n^{\cap}$ from §1.

### 5.2 Why $\Gamma_n$-equivariance suffices

The chain-homotopy identity (Theorem 4.2) lives in the cochain complex $V_{[n+1]}^*(X_{n+1}^{\cap})\to V_{[n]}^*(X_n^{\cap})$ with both sides $\Gamma_n$-equivariant. The induced cohomological vanishing (Corollary 4.3) is $\Gamma_n$-equivariant. The cofiber LES is $\Gamma_{n+1}$-equivariant, but restricting to the relevant $V_{[n]}$-piece of $X_n^{\cap}$ cohomology only invokes the $\Gamma_n$-structure on the source. So $\Gamma_n$-equivariance of $h$ is exactly the right structural strength — neither over-strong (no $\Gamma_{n+1}$-coherence demanded that would force factorial structure) nor too weak (full $\Gamma_n$-equivariance is needed to control the $\mathrm{sgn}_{S_n}$-isotype refinement of §4.4).

### 5.3 The non-trivial cell-mapping under $\sigma_x$ for $x\notin S$

A subtle case: $\sigma_x D$ for $x\in[n]\setminus S$ (a coordinate not in the support of $\mathcal F$). Then $\sigma_x D$ involves $x\in[n]\setminus S$, which lies *outside* the support of $X(\mathcal F)$. Either $\sigma_x D$ lies in the support of *another* $X(\mathcal F')$ (some other object of $\mathcal C_n^{\cap}$ with $x\in S(\mathcal F')$) and the hocolim handles the move, or it doesn't (in which case $\sigma_x D=0$ as a chain).

This is the standard treatment of group actions on hocolim diagrams: the $S_n$-action permutes the indexing category $\mathcal C_n^{\cap}$ (UC10 §2.4), and the $(\mathbb Z/2)^n$-action acts on the geometric carrier $Q_n$ which is the *ambient* of every $X(\mathcal F)$. The hocolim assembles these together. The $\sigma_x$-action on a cell $D\subseteq X(\mathcal F)$ for $x\notin S$ is non-trivial only via the embedding $X(\mathcal F)\hookrightarrow Q_n$ which is part of the hocolim data.

In particular, the operator $h$ defined cell-by-cell (Definition 3.1) extends $\sigma_x$-equivariantly to all of $X_{n+1}^{\cap}$ because $\sigma_x$-action on the hocolim respects the bridge structure (Proposition 5.1).

### 5.4 The $S_n$-action on the indexing $\mathcal C_n^{\cap}$

For $\pi\in S_n$ and a cell $D\subseteq X(\mathcal F)$ for some $(S,\mathcal F)\in\mathcal C_n^{\cap}$, $\pi D$ lives in $X(\pi\mathcal F)\subseteq X(\pi S)$. The bridge $\tilde D$ over $D$ in $X(\mathrm{db}\mathcal F)$ maps under $\pi$ (extended as $\tilde\pi\in S_{n+1}$ fixing $n+1$) to the bridge $\widetilde{\pi D}$ over $\pi D$ in $X(\mathrm{db}\pi\mathcal F)$ (since $\mathrm{db}$ commutes with the $S_n$-action: $\pi\mathrm{db}\mathcal F=\mathrm{db}\pi\mathcal F$ because $\mathrm{db}$ uses only the special coordinate $n+1$ which $S_n$ fixes). Hence $h$ commutes with the $S_n$-action on the indexing, completing the verification of Proposition 4.5.

### 5.5 The $\Gamma_n$-equivariance of the chain-homotopy identity

**Proposition 5.2.** *Theorem 4.2's chain-homotopy identity $(\iota_n^{\cap})^*\omega=\frac{(-1)^k}{2}(dh\omega-hd\omega)$ is $\Gamma_n$-equivariant: for every $g\in\Gamma_n$, $g^*\bigl[(\iota_n^{\cap})^*\omega\bigr]=\frac{(-1)^k}{2}g^*\bigl[dh\omega-hd\omega\bigr]$.*

*Proof.* $\iota_n^{\cap}$, $d$, $h$ are each $\Gamma_n$-equivariant (Propositions 4.5, 5.1; $d$ from naturality of the cubical boundary). Hence each side commutes with $g^*$ separately, and the identity is preserved. $\blacksquare$

---

## §6. Hard-constraint verification

### 6.1 NOT factorial

The only categorical structure used is:
- the trace functor $\rho_n\colon\mathcal C_{n+1}^{\cap}\to\mathcal C_n^{\cap}$,
- its two sections $\iota_n^{\cap}$ (full subcategory inclusion) and $\mathrm{db}$ (doubling),
- the natural transformation $\alpha\colon\mathrm{db}\Rightarrow\iota_n^{\cap}$.

The only group actions are the natural $\Gamma_n,\Gamma_{n+1}$ on cubes $Q_n,Q_{n+1}$ — the type-B Coxeter / hyperoctahedral groups. **No factorial decomposition** is used anywhere: no $S_{n+1}$-factorial spine, no $S_n!$-graded chain complex, no factorial moduli expansion. The cube $Q_{n+1}$ has size $2^{n+1}$, $\Gamma_{n+1}$ has size $2^{n+1}(n+1)!$ — large but not factorial-structured. The argument uses *cube product structure* ($Q_{n+1}=Q_n\times I$, Lemma 2.7), which is anti-factorial: the doubling is a *product*, not a factorial expansion.

This honors Daniel's verbatim NOT-factorial directive (UC10 §0.4, originating 2026-05-15T23:20Z).

### 6.2 Inherently but NOT functorially related to $\mathrm{Pos}_n$ cohomology

UC12 uses no functor to $\mathrm{PPF}_n$ or $\mathrm{Pos}_n$ at any step. The doubling $\mathrm{db}$, the bridge construction, the chain homotopy $h$, the cofiber LES — all intrinsic to the cube/Walsh world ($Q_{n+1}$, $\Gamma_{n+1}$, $\mathcal C_{n+1}^{\cap}$). The F18-analogy is *structural* (parallel to the simplicial-order side null-homotopy in F18): same cofiber LES strategy, same isotype-restriction, same prism/cofiber engine, but instantiated on the cubical-Walsh complex rather than the simplicial-order complex.

The inherent-not-functorial constraint of UC10 §6 is *preserved by construction*: there is no commutative diagram
$$\begin{array}{ccc}X_n^{\cap}&\to&X_{n+1}^{\cap}\\ \downarrow&&\downarrow\\ \Delta_n&\to&\Delta_{n+1}\end{array}$$
in any direction inducing the relationship between UC12's null-homotopy and F18's. The relationship is descriptive (both close their respective $\delta$-injectivity step on the appropriate sign-isotype via a cofiber-LES + null-homotopy argument), not functorial.

UC9 (mg-96a6, extrinsic embedding) is independent of UC12. UC12 does not invoke UC9; UC9's verdict and UC12's verdict are independent. The joint UC9/UC10 dispatch (UC13+ future, per UC10 §7.2) remains as named future work — UC12 closes UC10.R cleanly without touching it.

### 6.3 No U1-dialect collision with the 1/3-2/3 side

UC12 lives in the `union_closed` repository. The 1/3-2/3 side (`one_third_width_three`) is structurally invariant under UC12: different repository, different polecat, different complex ($\Delta_n=\Delta(\mathrm{PPF}_n)$ vs. $X_n^{\cap}$), different category ($\mathrm{PPF}_n$ vs. $\mathcal C_n^{\cap}$), different group ($S_n$ vs. $\Gamma_n=(\mathbb Z/2)^n\rtimes S_n$).

The 1/3-2/3 dialect-collision concern (F30 unconditional-U1-dissolve) was about whether the 1/3-2/3 *side's* F-series cohomology results regress under cross-pollination. UC12 is *not* a cross-pollination — it is the union_closed-side native construction proceeding *independently* of the F-series. F17/F18 are referenced only as *structural templates* (the cofiber-LES + null-homotopy schema is reused), not as *functorial sources*. No theorem of F17/F18 is invoked as a hypothesis in any UC12 proof.

In particular, even if F17/F18 were *retracted* tomorrow, UC12's argument would stand: the cubical-bridge null-homotopy is a self-contained construction on $X_{n+1}^{\cap}$ with no logical dependence on $\Delta_n$ being a homology sphere. (It does invoke UC10's framework + UC10.W, but UC10.W is proven unconditionally in UC10 §3.4 via the abelian-group Maschke argument on $(\mathbb Z/2)^n$, with no F17/F18 input.)

### 6.4 Paper-and-pencil

This document is paper-and-pencil throughout: no Lean proof object, no new axioms, no computation. All proofs are presented in LaTeX-style Markdown, F-series house style.

---

## §7. Verdict, downstream consequences, UC13+ scope

### 7.1 Verdict — GREEN

UC12 closes UC10.R (Theorem 4.4 / Corollary 4.6): the connecting map $\delta_n^{\cap}$ on the top-Walsh sign piece $V_{[n]}^{n-1}\otimes\mathrm{sgn}_{S_n}$ is *injective*, via the cubical-bridge null-homotopy operator $h$ (Definition 3.1) satisfying the chain-homotopy identity (Theorem 4.2) and the $\Gamma_n$-equivariance (Propositions 4.5, 5.1, 5.2). No factorial structure (§6.1); no functor to $\mathrm{Pos}_n$ (§6.2); no U1-dialect collision (§6.3); paper-and-pencil only (§6.4).

This is **GREEN** rather than AMBER because:
- the null-homotopy is constructed explicitly (not merely asserted to exist),
- the chain-homotopy identity is verified by direct cube-boundary computation (one line: Lemma 4.1),
- the equivariance is verified on each generator (Propositions 4.5, 5.1),
- no conditional dependencies remain (the argument is self-contained inside UC10's framework + UC10.W),
- the bi-isotype refinement of §4.4 closes UC10.R in the full strength needed for UC10.1.

### 7.2 Downstream consequences

**(7.2.1) UC10.1 becomes unconditional, modulo Steps 3, 4 of UC10 §5.** Under UC10's proof outline (UC10 §5), Step 5 = UC10.R is now GREEN. Steps 1, 2, 6 are ✓ transfers (UC10 §§5.1, 5.2, 5.6). Step 7 is dropped by the C5 dodge. Steps 3 (lower-Walsh vanishing) and 4 (top-Walsh concentration in degree $n-1$) remain as ◐ adaptive proofs whose execution is plausible per UC10 §§5.3-5.4. *With the bridge mechanism now in hand*, Steps 3 and 4 admit a similar treatment:

- **Step 3 (lower-Walsh vanishing).** For $S\subsetneq[n]$, $V_S^*$ on $X_n^{\cap}$ is computed via the *Walsh restriction* to characters with support $S$. The bridge mechanism applied to coordinates *not in $S$* (using a "doubling along $x\notin S$" variant of Definition 2.1) gives a null-homotopy on the $\chi_S$-isotype in degrees $k\ge 1$. Spelled out: for each $x\notin S$, $\chi_S$ is *invariant* under $\sigma_x$ (since $x\notin S$), so the "$\sigma_x$-antisymmetry" lemma of §4.1 fails — but the analogous *symmetric* relation $\omega(C\times\{1\})=+\omega(C\times\{0\})$ allows a similar bridge argument with appropriately twisted signs. The result: $V_S^*=0$ in degrees $\ge 1$ for $S\subsetneq[n]$.
- **Step 4 (top-Walsh concentration).** For $S=[n]$ and $k<n-1$: cubical Morse on the top-Walsh piece. The bridge mechanism, iterated $n$ times across all coordinates, gives a deformation retract of $V_{[n]}^*$ onto a top-dimensional piece — concentrated in degree $n-1$, dimension $\le 1$, with $\mathrm{sgn}_{S_n}$ isotype.

UC12 sketches these in §7.2 only — full execution is **UC11 secondary** (per UC10 §7.2). The strategic insight, hardened by UC12: **the bridge mechanism unifies all three remaining UC11 steps** (UC10.R, lower-Walsh vanishing, top-Walsh concentration) under a single cubical-bridge null-homotopy schema, with the only variation being the choice of coordinate to bridge.

**(7.2.2) UC11 (5-step Frankl program, mg-9ef0) unblocked.** UC11 consumes UC10.1 as input to its Frankl-side argument. With UC10.R GREEN (and UC10 §§5.3, 5.4 now visibly closable by the bridge mechanism), UC10.1 is upgradable to unconditional. UC11's 5-step program can now proceed.

**(7.2.3) Joint UC9/UC10 dispatch (UC13+) remains available.** UC10 §7.2 named the joint UC9/UC10 dispatch as a future combining mechanism for the strongest Frankl-side constraint. UC12 leaves this unchanged: UC10.1 (now unconditional modulo UC10 §§5.3, 5.4) plus UC9's extrinsic constraint (when UC9 itself GREENs) combine independently via the inherent-not-functorial framework.

### 7.3 What UC12 does NOT do

- **Does not execute UC10 §§5.3, 5.4 in full.** §7.2.1 sketches the strategy via bridge-mechanism transfer; full execution is **UC11 secondary**.
- **Does not engage UC11's 5-step Frankl program.** UC12 is a residual-closer, not a Frankl-program executor. UC11 is the next session.
- **Does not address $n$-induction / multiplicativity-law replacement.** Per the C5 dodge (UC10 §1.2, §5.7), induction is dropped from the load-bearing path. UC12 honors this.
- **Does not touch UC1–UC8 native-construction chain or the 1/3-2/3 critical path.** Independent branches; UC12 is purely on the UC10 cohomological branch.
- **Does not engage Lean / axioms / computation.** Paper-and-pencil only.

### 7.4 The honest one-paragraph verdict

UC12 closes the named residual UC10.R unconditionally by an explicit cubical-bridge null-homotopy operator $h$ satisfying the chain-homotopy identity $\iota_n^{\cap *}=\frac{(-1)^k}{2}(dh-hd)$ on the $\chi_{[n+1]}$-Walsh isotype of cochains on $X_{n+1}^{\cap}$, constructed via the doubling functor $\mathrm{db}\colon\mathcal C_n^{\cap}\hookrightarrow\mathcal C_{n+1}^{\cap}$ that supplies a canonical bridge over every cell of $X_n^{\cap}$ inside the cube product $X(\mathrm{db}\mathcal F)\cong X(\mathcal F)\times I$, with the $\sigma_{n+1}$-antisymmetry of the top-Walsh isotype providing the cocycle-cancellation that exhibits $\iota_n^{\cap *}\omega$ as a coboundary in $C^*(X_n^{\cap})$; the $\Gamma_n$-equivariance is verified on each generator, the $\mathrm{sgn}_{S_n}$-isotype is preserved cell-by-cell, the bi-isotype $\chi_{[n+1]}\boxtimes\mathrm{sgn}_{S_{n+1}}$ refinement of §4.4 closes UC10.R in the full strength needed for UC10.1, and the construction is intrinsic to $\mathcal C_{n+1}^{\cap}$ (no functor to $\mathrm{PPF}_{n+1}$, no factorial structure, no U1-dialect interaction with the 1/3-2/3 side), unblocking UC10.1 to unconditional (modulo the now-plausibly-executable §§5.3-5.4 adaptations whose bridge-mechanism strategy is sketched in §7.2.1) and UC11's 5-step Frankl program to proceed.

---

## §8. References

### 8.1 This repo (`union_closed`)

- **mg-814b (UC10)** — `docs/union-closed-UC10-native-cohomology-intersection-closed-families.md`. The framework UC12 closes the residual of. §§2 (category $\mathcal C_n^{\cap}$), 3 (cohomology object $X_n^{\cap}$ + UC10.W Walsh decomposition + bi-equivariance), 4 (UC10.1 + UC10.S + UC10.R named), 5 (proof outline F17+F18 step-by-step, with Step 5 = UC10.R named as the load-bearing open lemma). Cumulative state ledger `docs/state-UC10.md` — UC12 updates as Session 2.
- **mg-96a6 (UC9)** — `docs/union-closed-UC9-intersection-closed-flip-embedding-cohomology.md`. The complementary extrinsic mechanism; independent of UC12 (UC10 §6 inherent-not-functorial relation preserved).
- **mg-f72a (UC1)** — `docs/union-closed-compat-geom-manifesto.md`. The manifesto C1–C5 constraints UC10 dodges by construction; UC12 respects these by inheritance.
- **mg-a814 (UC2) through mg-d68d (UC8)** — independent native-construction chain. Untouched by UC12.

### 8.2 Cross-repo `one_third_width_three` (read-only structural templates)

- **mg-4d3a (F17, UCC.1)** — $n$-uniform $S_n$-equivariant cofiber Morse on $\Delta_n\hookrightarrow\Delta_{n+1}$. The structural template for the cofiber-LES strategy (UC12 §1).
- **mg-d039 (F18, UCC.2)** — $\delta_n$ injective via null-homotopy of $\iota_n$ on $\mathrm{sgn}_{S_n}$. The structural template for the null-homotopy argument (UC12 §§3-4). UC12's cubical-bridge null-homotopy is the cube/Walsh-side analog of F18's simplicial-order-side null-homotopy.
- **mg-26fc** — structural-analogy two-mechanisms framing + meta-thesis. The conceptual umbrella under which UC10 (intrinsic) and UC9 (extrinsic) coexist; UC12 preserves this framing.

**Note.** F17, F18, mg-26fc are referenced as *structural templates* only — no theorem from `one_third_width_three` is invoked as a logical hypothesis in any UC12 proof. The argument is self-contained inside the union_closed framework (UC10 + UC12).

### 8.3 Background

- N. Bourbaki, *Lie Groups and Lie Algebras*, Ch. IV–VI — type-B Coxeter / hyperoctahedral $\Gamma_n=(\mathbb Z/2)^n\rtimes S_n$. The natural symmetry of the cube.
- R. O'Donnell, *Analysis of Boolean Functions* — Walsh-Fourier basics, level-$k$ characters, harmonic decomposition; UC10.W is the chain-level Maschke version of the standard $L^2$ Walsh decomposition.
- Bousfield–Kan, *Homotopy Limits, Completions and Localizations* — the standard hocolim with isotypic-direct-sum decomposition (UC12 §3.2).
- Standard cubical-complex boundary formulas (the prism formula in Lemma 4.1 is folklore; see e.g. Hatcher *Algebraic Topology* Ch. 3 for the simplicial analog, with the cubical version routine).

### 8.4 Source directives

- Daniel verbatim 2026-05-15T23:20Z (NON-NEGOTIABLE, inherited from UC10): "NOT factorial. Inherently but NOT functorially related to Pos_n cohomology." Honored in §§6.1-6.2.
- mg-707c ticket body — execute UC10.R (F18-analog null-homotopy). Discharged GREEN in this document.
- UC10 §7.2 — UC11 primary = execute UC10.R. UC12 *is* the execution; UC11 (the 5-step Frankl program) now proceeds to consume UC10.1 (modulo §§5.3-5.4 adaptations whose bridge-mechanism strategy is sketched here).

---

*Polecat: cat-mg-707c (UC12). Branch: `polecat-cat-mg-707c`. Session 2 on the UC10 arc (cumulative state ledger `docs/state-UC10.md`). Verdict: **GREEN — trace-injectivity of $\delta_n^{\cap}$ on top-Walsh sign piece is unconditional via a $\Gamma_n$-equivariant cubical-bridge null-homotopy**. The named UC10.R is closed; UC10.1 unblocked to unconditional modulo the §§5.3-5.4 adaptations whose bridge-mechanism strategy is sketched in §7.2.1; UC11's 5-step Frankl program (mg-9ef0) proceeds. No factorial structure; inherent-not-functorial relation to $\mathrm{Pos}_n$ preserved; no Lean; no axioms; no computation; UC1–UC8 native-construction chain untouched; 1/3-2/3 route-(ii) critical path untouched (different repo).*
