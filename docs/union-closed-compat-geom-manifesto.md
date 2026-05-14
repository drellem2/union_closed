# Union-Closed Compatibility-Geometry — UC1: Manifesto + feasibility scoping (mg-f72a)

**Repo:** `union_closed` — **the founding document of the product line.**
**Branch:** `union-closed-UC1-manifesto-scoping`.
**Type:** Manifesto + feasibility scoping. Paper-and-pencil; **no new axioms; no Lean; no computation.** LaTeX-style Markdown, F-series house style. Multi-session-able; cumulative state ledger in `docs/state-UC1.md`.
**Cross-repo references (read access):** `one_third_width_three` — `docs/compatibility-geometry-structural-analogy-scoping.md` (mg-26fc), `docs/general-n-proof-synthesis.md` (F10), `docs/state-F11.md` (F11), `main.tex`, `step8.tex`.
**Source:** README.md (mayor scaffold, 2026-05-14 — the structural analogy + intrinsic-object expectation); Daniel directives 2026-05-14 (new-repo assignment + the involutions / Markov-chain / cohomological-property setup sketch); mg-26fc §6 follow-up 3 (check Union-Closed against *both* 1/3-2/3 mechanisms).

---

**Verdict: AMBER-partial-transfer.**

The Union-Closed compatibility-geometry **framework transfers cleanly** — arguably *more* cleanly than the 1/3-2/3 framework sits in its own ambient. The intrinsic object is pinned (§1.3): a union-closed family $\mathcal F$ is a vertex subset of the Boolean cube $Q_n$, and the **transport graph** $G(\mathcal F)$ — the subgraph of $Q_n$ induced on $\mathcal F$ — is the exact structural analogue of the Bubley–Karzanov graph as an induced subgraph of the permutahedron skeleton. The coordinate-transport involutions $\varphi_x$ are the cube's coordinate toggles, realised on $\mathcal F$ as **partial matchings** $M_x$ (§1.4). The balanced obstruction has a clean geometric form: **the centroid of a union-closed family cannot lie strictly inside the small corner $[0,\tfrac12)^n$ of the cube** (§1.6). And there is a genuine *bonus* structure with no 1/3-2/3 counterpart: the coordinate bias is exactly a level-1 Walsh–Fourier coefficient, $\beta_x = -2^n\,\widehat{\mathbf 1_{\mathcal F}}(\{x\})$ (§1.6, §4.7).

But the framework transfers **decoupled from both 1/3-2/3 proof engines.** Neither mechanism transfers as a working *engine*, and the failures are precisely named:

- **Mechanism (a) — BK / Cheeger-expansion (§3).** The *setup* transfers (state space, ambient cube, transport graph, coordinate cut). The *engine* fails on three named gaps: **(E1)** $G(\mathcal F)$ is **disconnected in general** — there is no irreducible transport chain, so no spectral gap to bound (the BK graph's connectivity is a *theorem*; $G(\mathcal F)$'s connectivity simply *fails*); **(E2)** there is no "width-3"-type rigidity knob — Frankl is the unrestricted conjecture, and the cube is only a weak expander (spectral gap $2/n$), with induced subgraphs arbitrarily worse; **(E3)** there is no Theorem-E-style conversion of volume-imbalance into a conductance bottleneck, because that conversion is powered by the width-3 *rich-pair 2-dimensional grid fiber* geometry, which has no union-closed analogue.

- **Mechanism (b) — F-series cohomological (§4).** The cathedral does not transfer, on five named gaps: **(C1)** the README's $\Delta(\mathcal F)$ is the *wrong level* — it is the "internal" sibling of $G(\mathcal F)$, not the moduli-space analogue of $\Delta(\mathrm{PPF}_n)$; **(C2)** the correct moduli object $\mathrm{UCF}_n$ (all union-closed families on $[n]$) is a closure lattice of **doubly-exponential** size $\ge 2^{\binom{n}{\lfloor n/2\rfloor}}$ — strictly worse than the super-exponential $|\mathrm{PPF}_n|$ that already killed F-series route (i) — with no reason to be a homology sphere (no (H-Cox) analogue); **(C3)** the load-bearing symmetry is wrong — union-closure is preserved by $S_n$ but the conjecture's natural harmonic home is the cube's $(\mathbb Z/2)^n$ / Walsh world, and the F-series machinery (sgn-isotype, FI rep-stability) is $S_n$-Coxeter-built; **(C4)** there is no refinement-cover $\leftrightarrow$ decision **substrate correspondence** — the *solid hinge* of the 1/3-2/3 dictionary (mg-26fc §3.2) has no union-closed analogue; **(C5)** there is no clean $n$-induction — the ground-set inclusion $\mathrm{UCF}_n\hookrightarrow\mathrm{UCF}_{n+1}$ does not act cleanly on the abundance obstruction (contrast the F8 multiplicativity law).

So Union-Closed **resonates with the *framework* of mechanism (a) and with the *engine* of neither** (§6). This is informative, not disappointing: the cross-product comparison establishes that Union-Closed is "expansion-flavoured in its geometry, neither-flavoured in its proof engine, and *harmonic-analytic* in its native structure." The first concrete attack (UC2, §8) must therefore be a **native construction** exploiting the cube / Walsh / semilattice structure directly — not a port of either 1/3-2/3 engine — and §8 scopes it: the **coordinate-transport deficiency question** built on the partial-matching / stuck-set structure of §1.4–§1.5, with the Walsh-spectrum and $G(\mathcal F)$-component routes as fallbacks.

§7 is the verdict; §8 scopes UC2; §9 the references. The verdict is AMBER not GREEN because the framework transfers *decoupled from both mechanisms* (GREEN's own criterion is "transfers via one or both mechanisms"); it is AMBER not RED because the framework-level transfer is genuine and load-bearing — it founds the product line — and a concrete native first attack *is* scoped.

---

## §0. What this document is and is not

The README frames a `1/3-2/3 ⟷ Union-Closed` structural analogy and expects an "intrinsic object." mg-26fc rigorized the **1/3-2/3 column** of Daniel's structural-analogy avalanche and found it has *two* distinct-but-resonant compatibility-geometry mechanisms — (a) BK/Cheeger-expansion and (b) F-series cohomological — with its §6 follow-up 3 explicitly asking that the Union-Closed framework be checked against **both**.

This document does four things and only four things:

1. **States the Union-Closed compatibility-geometry framework precisely** (§1) — pins the intrinsic object, the symmetry group, the balanced obstruction geometrically, and the coordinate-transport involutions.
2. **Assesses feasibility against mechanism (a)** — BK/Cheeger-expansion (§3).
3. **Assesses feasibility against mechanism (b)** — F-series cohomological (§4).
4. **Builds the dictionary** rigorous on the Union-Closed side (§5), emits the resonance verdict (§6, §7), and **scopes the first concrete attack UC2** (§8).

It is **paper-and-pencil**: no new axioms, no Lean, no computation, no new empirical datapoint. It introduces no objects into any trust surface. It is the *founding* document — independent of, and not touching, the 1/3-2/3 route-(ii) critical path (`one_third_width_three` F16 / mg-f893).

**Notation.** $U$ a finite ground set, $|U|=n$; $2^U$ the Boolean lattice / cube. $\mathcal F\subseteq 2^U$ a **union-closed family**: $A,B\in\mathcal F\Rightarrow A\cup B\in\mathcal F$, and $\mathcal F\neq\{\emptyset\}$, $\mathcal F\neq\emptyset$. WLOG $U=\bigcup\mathcal F$ (every element appears) and hence $U\in\mathcal F$ (finite union-closed families have a $\subseteq$-maximum). For $x\in U$: $\mathcal F_x:=\{A\in\mathcal F:x\in A\}$, $\mathcal F_{\bar x}:=\{A\in\mathcal F:x\notin A\}=\mathcal F\setminus\mathcal F_x$, abundance $a(x):=|\mathcal F_x|/|\mathcal F|$, and bias $\beta_x:=|\mathcal F_x|-|\mathcal F_{\bar x}|$. The 1/3-2/3 notation ($\mathcal L(P)$, $G_{\mathrm{BK}}(P)$, $\mathrm{PPF}_n$, $\Delta_n$, $\omega_{\mathrm{bal}}$, (UCC), (FG-Cofiber)) is as in mg-26fc / F10 / F11; restated where used.

---

## §1. The Union-Closed compatibility-geometry framework, stated precisely

### 1.1 The conjecture and the balanced obstruction

**Frankl's Union-Closed Sets conjecture (1979).** Every finite union-closed family $\mathcal F\neq\{\emptyset\}$ has an **abundant element**: some $x\in U$ with $a(x)\ge\tfrac12$, i.e. $|\mathcal F_x|\ge|\mathcal F|/2$, equivalently $\beta_x\ge 0$.

**The balanced obstruction.** A *counterexample* is a union-closed $\mathcal F$ with $a(x)<\tfrac12$ — equivalently $\beta_x<0$, equivalently $|\mathcal F_x|<|\mathcal F_{\bar x}|$ — for **every** $x\in U$. The conjecture is the assertion that no such $\mathcal F$ exists.

This is the structural twin of the 1/3-2/3 "balanced obstruction" ($p_{xy}\notin[1/3,2/3]$ for every incomparable pair $x\parallel y$; mg-26fc §1.4). Two differences are load-bearing and recur throughout:

- **(D1) The threshold is a single point $\tfrac12$, not an interval $[1/3,2/3]$.** Frankl asks $\max_x a(x)\ge\tfrac12$; 1/3-2/3 asks $\exists$ pair with $p_{xy}\in[1/3,2/3]$. Union-closed is a *one-sided* balance statement.
- **(D2) The two sides of a coordinate are *not symmetric*.** For 1/3-2/3, the pair $(x,y)$ vs $(y,x)$ is symmetric: $p_{xy}+p_{yx}=1$, and "balanced" is a symmetric interval. For Union-Closed, $\mathcal F_x$ and $\mathcal F_{\bar x}$ are *structurally different objects* (§1.5): $\mathcal F_x$ is a **filter**, $\mathcal F_{\bar x}$ is an **ideal**. There is a built-in asymmetry — $\emptyset$ (if present) and the family's $\subseteq$-minimum lie in every $\mathcal F_{\bar x}$; $U$ lies in every $\mathcal F_x$. The conjecture says that despite $\mathcal F_x$ being a filter ("sitting higher, looking smaller"), some $\mathcal F_x$ is still $\ge$ half.

### 1.2 The candidate intrinsic objects, enumerated with pros/cons

The ticket asks: pin the intrinsic object, or enumerate candidates with pros/cons. There are five natural candidates; they are *not* interchangeable, and conflating them is the README's one imprecision (see (C1), §4.2).

| # | Candidate intrinsic object | Pro | Con |
|---|---|---|---|
| (A) | **The Boolean cube $Q_n$ with $\mathcal F$ as a vertex subset; the transport graph $G(\mathcal F)$ = subgraph of $Q_n$ induced on $\mathcal F$.** | Exact structural analogue of "BK graph = induced subgraph of permutahedron skeleton"; the cube is *more* symmetric than the permutahedron (Cayley graph of $(\mathbb Z/2)^n$); the coordinate-transport involutions live here natively. | $G(\mathcal F)$ is **disconnected** in general (§3.2) — no irreducible chain. |
| (B) | **The inclusion poset $(\mathcal F,\subseteq)$ as a join-semilattice; its order complex $\Delta(\mathcal F)$.** | Intrinsic, canonical, coordinate-free; the README's stated expectation. | It is the *internal* topology of the single object $\mathcal F$ — the sibling of (A), **not** the moduli-space analogue of $\Delta(\mathrm{PPF}_n)$ (§4.2); no evident abundance$\leftrightarrow$topology bridge. |
| (C) | **The moduli space $\mathrm{UCF}_n$ = all union-closed families on $[n]$, a closure lattice, $S_n$-equivariant; its order complex $\Delta(\mathrm{UCF}_n)$.** | The *correct* level for a cohomological/inductive (F-series-style) attack — $\mathcal F$ is a vertex, $S_n$ acts. | Doubly-exponential size $\ge 2^{\binom{n}{\lfloor n/2\rfloor}}$ (§4.3); no reason to be a homology sphere; no sgn story. |
| (D) | **The cubical complex $X(\mathcal F)$ = all subcubes of $Q_n$ whose vertices all lie in $\mathcal F$.** | Captures the "which squares/subcubes survive" data — the literal "failure of local symmetries to commute." | Union-closure does not control subcube-presence cleanly; $X(\mathcal F)$ is a derived object, not a primary one. |
| (E) | **The harmonic picture: $\mathbf 1_{\mathcal F}$ as a function on $Q_n$, its Walsh–Fourier (level-1) spectrum.** | $\beta_x$ *is* a level-1 Fourier coefficient (§1.6) — the most direct route to the obstruction; the home of the current frontier (Gilmer's entropy method). | Not a "complex" — harmonic analysis, not topology. But (§4.7) that may be precisely the point. |

### 1.3 The load-bearing pick

**For the geometry: (A), the cube $Q_n$ + the transport graph $G(\mathcal F)$.** This is the object that makes the compatibility-geometry analogy *exact* at the framework level: $\mathcal F$ sits inside the highly-symmetric ambient $Q_n$ exactly as $\mathcal L(P)$ sits inside the permutahedron skeleton, and $G(\mathcal F)$ is the induced subgraph exactly as $G_{\mathrm{BK}}(P)$ is.

**For the obstruction's content: (E), the Walsh picture**, because $\beta_x$ is literally a level-1 Fourier coefficient and the conjecture is literally a sign statement about the level-1 spectrum.

**(B) $\Delta(\mathcal F)$ is the natural "internal topology" object** — it is real and worth study, but it is the sibling of (A), not the F-series analogue. **(C) $\mathrm{UCF}_n$ is the moduli object the cohomological route *would* need** — and §4 shows it does not cooperate. **(D) $X(\mathcal F)$** is the derived object that measures the compatibility *defect* (§8.3).

The honest one-line answer to "pin the intrinsic object": **the intrinsic object is $\mathcal F\subseteq Q_n$ with its induced transport graph $G(\mathcal F)$ and its level-1 Walsh spectrum** — the cube is the ambient, $G(\mathcal F)$ is the geometry, the level-1 spectrum is the obstruction.

### 1.4 The coordinate-transport involutions $\varphi_x$, precisely

The Boolean cube carries $n$ coordinate involutions $\sigma_x:2^U\to 2^U$, $\sigma_x(A)=A\,\triangle\,\{x\}$ (toggle $x$). They generate $(\mathbb Z/2)^n$ acting on $Q_n$; $\sigma_x$ is a perfect involution swapping the half-cube $\{A:x\in A\}$ with $\{A:x\notin A\}$.

**Restricted to $\mathcal F$, $\sigma_x$ is a *partial* involution.** Define the **$x$-transport matching**
$$
  M_x \;:=\; \bigl\{\,\{A,\,A\setminus\{x\}\} \;:\; A\in\mathcal F_x,\ A\setminus\{x\}\in\mathcal F\,\bigr\}.
$$
$M_x$ is a perfect matching on the "$x$-flippable" part of $\mathcal F$ — it is exactly the set of edges of $G(\mathcal F)$ in coordinate direction $x$. The vertices it leaves unmatched split as:
$$
  \mathcal F_x^{\mathrm{stuck}} := \{A\in\mathcal F_x : A\setminus\{x\}\notin\mathcal F\},
  \qquad
  \mathcal F_{\bar x}^{\mathrm{stuck}} := \{A'\in\mathcal F_{\bar x} : A'\cup\{x\}\notin\mathcal F\}.
$$
$\mathcal F_x^{\mathrm{stuck}}$ are the sets that **need** $x$ (deleting $x$ leaves $\mathcal F$); $\mathcal F_{\bar x}^{\mathrm{stuck}}$ are the sets that **reject** $x$ (cannot absorb $x$ within $\mathcal F$). Counting both sides of $M_x$:
$$
  |\mathcal F_x| = |M_x| + |\mathcal F_x^{\mathrm{stuck}}|,
  \qquad
  |\mathcal F_{\bar x}| = |M_x| + |\mathcal F_{\bar x}^{\mathrm{stuck}}|,
$$
and therefore — the **transport identity** —
$$
  \boxed{\;\beta_x \;=\; |\mathcal F_x| - |\mathcal F_{\bar x}| \;=\; |\mathcal F_x^{\mathrm{stuck}}| - |\mathcal F_{\bar x}^{\mathrm{stuck}}|.\;}
$$
So **$M_x$ contributes nothing to the bias** — the bias is *entirely* the difference between the two stuck-sets. Frankl's conjecture, in transport form:

> **(Frankl, transport form).** Every union-closed $\mathcal F$ has an $x$ with $|\mathcal F_x^{\mathrm{stuck}}|\ge|\mathcal F_{\bar x}^{\mathrm{stuck}}|$ — the transport $M_x$ strands at least as many sets on the $x$-side as on the $\bar x$-side.

This is Daniel's "coordinatewise transport involutions $\varphi_x:\mathcal F_x\to\mathcal F_{\bar x}$" made precise: $\varphi_x$ is $\sigma_x$, which is *globally* defined on the cube but only *partially* defined on $\mathcal F$ (it is $M_x$). The "failure of the involutions to globalize" — the README's expectation — is exactly the existence of the stuck-sets, and the bias *is* the stuck-set imbalance. This is the cleanest transfer in the whole framework, and it has no slippage.

### 1.5 The structural gifts of union-closure (the lemmas that *do* hold)

Union-closure is not a vacuous decoration — it gives genuine structure. The load-bearing lemmas, all elementary and all paper-and-pencil:

**(UC-Lemma 1) $\mathcal F_x$ is a filter and is union-closed.** Up-set: $A\in\mathcal F_x$, $A\subseteq C\in\mathcal F\Rightarrow x\in C\Rightarrow C\in\mathcal F_x$. Union-closed: $A,B\ni x\Rightarrow A\cup B\ni x$.

**(UC-Lemma 2) $\mathcal F_{\bar x}$ is an ideal and is itself a union-closed family.** Down-set: $A'\in\mathcal F_{\bar x}$, $C\subseteq A'$, $C\in\mathcal F\Rightarrow x\notin C$. Union-closed: $x\notin A',B'\Rightarrow x\notin A'\cup B'$. So $\mathcal F_{\bar x}$ is a union-closed family in its own right (on ground set $U\setminus\{x\}$), with $\subseteq$-maximum $T_x:=\bigcup\mathcal F_{\bar x}$ = the largest set of $\mathcal F$ avoiding $x$.

**(UC-Lemma 3) The union map.** For any fixed $W\in\mathcal F_x$, $u_W:\mathcal F_{\bar x}\to\mathcal F_x$, $A'\mapsto A'\cup W$, is well-defined (union-closure). It is the natural union-closure-provided map $\mathcal F_{\bar x}\to\mathcal F_x$ — but it is **not injective** in general (distinct $A',A''$ can have $A'\cup W=A''\cup W$). Frankl's conjecture is *exactly* "$\exists x$ with an injection $\mathcal F_{\bar x}\hookrightarrow\mathcal F_x$"; union-closure hands you $u_W$, and the entire difficulty is upgrading some $u_W$ (or a variant) to an injection.

**(UC-Lemma 4) Triviality escapes.** If $x$ lies in *every* set of $\mathcal F$ then $\mathcal F_{\bar x}=\emptyset$, $\beta_x=|\mathcal F|>0$, and $x$ is abundant. So in a counterexample every $x$ is both present in some set and absent from some set; in particular $\mathcal F_x,\mathcal F_{\bar x}\neq\emptyset$ for all $x$.

These four lemmas are the union-closed analogue of the "two standard facts" mg-26fc §1.3 cited for the BK side (connectivity + convexity flavour). They are what UC2 must build on.

### 1.6 The balanced obstruction, geometrically — four equivalent forms

Daniel's "what is the balanced obstruction geometrically" — pinned down, in increasing geometric content:

**(O1) Combinatorial.** $a(x)<\tfrac12$ for all $x$.

**(O2) Transport.** $|\mathcal F_x^{\mathrm{stuck}}|<|\mathcal F_{\bar x}^{\mathrm{stuck}}|$ for all $x$ (§1.4): the partial involution $M_x$ strands strictly more sets on the $\bar x$-side than the $x$-side, for *every* coordinate.

**(O3) Harmonic.** Let $\chi_x(A):=(-1)^{[x\in A]}$ be the level-1 Walsh character. Then $\sum_{A\in\mathcal F}\chi_x(A)=|\mathcal F_{\bar x}|-|\mathcal F_x|=-\beta_x$, so
$$
  \beta_x \;=\; -\,2^n\,\widehat{\mathbf 1_{\mathcal F}}(\{x\}),
$$
where $\widehat{\mathbf 1_{\mathcal F}}(\{x\})=2^{-n}\sum_{A}\mathbf 1_{\mathcal F}(A)\chi_x(A)$ is the level-1 Fourier coefficient. The obstruction $\beta_x<0\ \forall x$ says: **every level-1 Walsh–Fourier coefficient of $\mathbf 1_{\mathcal F}$ is strictly positive** — $\mathbf 1_{\mathcal F}$ "leans toward $\emptyset$" in every coordinate.

**(O4) Centroidal — the cleanest "geometry" form.** Embed $\mathcal F$ as a point cloud in the cube $[0,1]^n$; its centroid $c(\mathcal F)\in[0,1]^n$ has $x$-coordinate $c(\mathcal F)_x=\tfrac1{|\mathcal F|}\sum_{A\in\mathcal F}\mathbf 1_{x\in A}=a(x)$. The obstruction $a(x)<\tfrac12\ \forall x$ is precisely:
$$
  \boxed{\;c(\mathcal F)\in\bigl[0,\tfrac12\bigr)^n\quad\text{— the centroid lies strictly inside the small corner of the cube.}\;}
$$
Frankl's conjecture: **the centroid of a union-closed family cannot lie strictly inside the small corner $[0,\tfrac12)^n$.** This is the literal, faithful instance of mg-26fc's meta-thesis "a constrained compatibility geometry cannot remain globally [biased]": union-closure forces the centroid out of the small corner.

### 1.7 The symmetry group in the load-bearing role

Two groups act on the picture, and the *split* between them is itself a key finding (it drives (C3), §4.4):

- **$S_n$** (relabelling $U=[n]$) **preserves union-closure** and acts on the moduli space $\mathrm{UCF}_n$. It is the symmetry for any equivariant/cohomological (F-series-style) treatment. The obstruction region $[0,\tfrac12)^n$ is $S_n$-invariant.
- **$(\mathbb Z/2)^n$** (the cube's coordinate flips) is the *structure group of the ambient $Q_n$* and powers the Walsh harmonic picture (O3) — but it **does not preserve union-closure** ($\sigma_x$ sends a union-closed family to an intersection-closed-flavoured one). So $(\mathbb Z/2)^n$ is load-bearing for the *ambient* and the *harmonic analysis* but is *not* a symmetry of the conjecture class.

The 1/3-2/3 F-series has a single load-bearing group, $S_n$, in a Coxeter-type role on $\Delta(\mathrm{PPF}_n)$. Union-Closed has a **split**: $S_n$ for the moduli/equivariant story, $(\mathbb Z/2)^n$ for the harmonic story — and the F-series machinery is built for the former while Union-Closed's native obstruction (O3) lives in the latter.

---

## §2. The two 1/3-2/3 reference mechanisms (recap)

Per mg-26fc, the 1/3-2/3 conjecture has **two distinct-but-resonant** compatibility-geometry mechanisms. Recapped only to the depth the feasibility assessment needs; full treatment in the cross-repo docs.

**Mechanism (a) — BK / Cheeger-expansion** (mg-26fc §1; `main.tex` §"Approach: Cheeger-type expansion on the BK graph"; `step8.tex` Theorem E). State space $\mathcal L(P)$; ambient = permutahedron skeleton / weak-order Hasse diagram; $G_{\mathrm{BK}}(P)$ = the induced subgraph on $\mathcal L(P)$, **connected** (Bubley–Karzanov 1998); the pair-cut $S_{xy}$ has volume $p_{xy}$ and edge-boundary = the BK moves swapping $x,y$; "expansion defect" = low conductance / small spectral gap; **Theorem E**: a width-3 $\gamma$-counterexample forces a pair-cut with volume $\ge\gamma$ and conductance $\le 2/(\gamma n)$ — a *bottleneck*; the **engine** (Steps 1–7) refutes the bottleneck via interface rigidity: rich pairs fiber over 2-dimensional grids, grid-stability forces low-conductance cuts to be locally monotone, incoherent interfaces force many boundary crossings. Conditional on Hypothesis A.

**Mechanism (b) — F-series cohomological** (F10, F11; mg-26fc §2). Ambient $\Delta_n=\Delta(\mathrm{PPF}_n)$, the order complex of *all* proper partial orders on $[n]$, $(n{-}2)$-dimensional, $S_n$-equivariant; obstruction = **(H-Cox)** $\Delta_n\simeq_{\mathbb Q}S^{n-2}$ + **(sgn)** $\widetilde H^{n-2}(\Delta_n)\cong\mathrm{sgn}_{S_n}$; $\omega_{\mathrm{bal}}^{(n)}$ the sign-isotypic generator; **ICOP** pairs $\omega_{\mathrm{bal}}$ with a critical chain to read off per-step probabilities in $[3/11,8/11]$; the **engine** is a cofiber-LES induction $\Delta_n\hookrightarrow\Delta_{n+1}$ (F10 §6.2, gap-free given (UCC)); the open gap is **(FG-Cofiber)** — finite generation of the degree-shift-aware cofiber-cohomology object, with F11 identifying the transition map as the triple connecting homomorphism $\partial_n$.

The mg-26fc verdict: these are **distinct mathematical objects** (a $1$-complex on $\mathcal L(P)$, per fixed $P$ — vs. an $(n{-}2)$-complex on the space of all posets), with **distinct machinery and distinct open gaps**, but **resonant** (shared substrate of pair-orientation linear-extension counts; exact refinement-cover $\leftrightarrow$ pair-cut correspondence; linked by the expansion$\leftrightarrow$cohomology meta-principle). §3 and §4 take Union-Closed against (a) and (b) in turn.

---

## §3. Feasibility against Mechanism (a): BK / Cheeger-expansion

### 3.1 What transfers — the setup, cleanly

The *setup* of mechanism (a) transfers to Union-Closed essentially without slippage, and in places *more* cleanly than it sits in 1/3-2/3:

| (a) — 1/3-2/3 BK object | Union-Closed analogue | Transfer |
|---|---|---|
| State space $\mathcal L(P)\subseteq S_n$ | $\mathcal F\subseteq 2^U$ | ✓ clean — the family *is* the state space |
| Ambient: permutahedron skeleton / weak-order Hasse | the Boolean cube $Q_n$ = Cayley graph of $(\mathbb Z/2)^n$ | ✓ clean — and $Q_n$ is *more* symmetric (vertex- and edge-transitive under a larger group; the permutahedron skeleton is only $S_n$-vertex-transitive) |
| $G_{\mathrm{BK}}(P)$ = induced subgraph on $\mathcal L(P)$ | $G(\mathcal F)$ = subgraph of $Q_n$ induced on $\mathcal F$ | ✓ clean — exact structural analogue (§1.3) |
| Local moves: adjacent transpositions of incomparable pairs | cube edges = coordinate toggles staying in $\mathcal F$ = the matchings $M_x$ (§1.4) | ✓ clean |
| Pair-cut $S_{xy}$, volume $p_{xy}$, edge-boundary = swaps of $x,y$ | coordinate-cut $\mathcal F_x$, volume $a(x)$, edge-boundary $=M_x$ | ✓ clean |
| Conjecture = some pair-cut has balanced volume | conjecture = some coordinate-cut has volume $\ge\tfrac12$ | ✓ clean (modulo (D1): point vs interval) |

The setup transfer is genuine and should be celebrated: it is *why* the product line is viable. But the setup is not the engine.

### 3.2 GAP E1 — the transport graph is disconnected; no irreducible chain

The Bubley–Karzanov graph is **connected** (Bubley–Karzanov 1998) — a *theorem*, and the foundation that makes "the BK Markov chain" a single irreducible reversible chain with a spectral gap to bound. mg-26fc §1.3 lists connectivity as one of the "two standard facts that give this ambient its teeth."

**The transport graph $G(\mathcal F)$ is disconnected in general.** Concrete witness: $\mathcal F=\{\emptyset,\{1,2\}\}$ is union-closed; its two vertices differ in two coordinates, so $G(\mathcal F)$ has no edge — two isolated vertices. More generally any union-closed family containing two $\subseteq$-incomparable sets at Hamming distance $\ge 2$ with no $\mathcal F$-member "between" them on a cube geodesic is disconnected, and such families are abundant (e.g. $\{\,\{1,2,3\},\{4,5,6\},\{1,\dots,6\}\,\}$).

So there is **no irreducible transport chain on $\mathcal F$** via the coordinate involutions. The very first object mechanism (a) needs — "the BK Markov chain" — does not exist for Union-Closed. One can run the chain component-by-component, but the conjecture is a statement relating *all* of $\mathcal F$ across the components, and a per-component spectral gap says nothing about the global bias. One can add laziness/teleportation, but then "the conductance of the coordinate cut $\mathcal F_x$" loses the clean meaning it has on the BK side. **E1 breaks mechanism (a) at the starting line.**

*Silver lining (logged for UC2, §8.3).* The disconnection is not noise — it is *structure*. $H_0(G(\mathcal F))$, the component lattice, is itself a "compatibility-geometry defect" forced by how union-closure restricts which cube edges survive. It is a genuinely native object; it is just not a *spectral-gap* object.

### 3.3 GAP E2 — no "width-3" rigidity knob; the cube is only a weak expander

Mechanism (a)'s engine refutes the bottleneck because **width-3 BK graphs are rigid** — width $\le 3$ is the structural restriction that powers Steps 1–7. The honest comparison is therefore *width-3* Kahn–Saks $\leftrightarrow$ *some restricted class of* union-closed families — and Frankl's conjecture has **no such restriction**. It is the *unrestricted* conjecture over *all* union-closed families. (Comparing unrestricted Frankl to width-3 Kahn–Saks is apples-to-oranges; the honest comparison is to *full* 1/3-2/3, which is itself open and hard.)

Worse, there is no "ambient is an expander" fact to lean on. The hypercube $Q_n$ has edge-Cheeger constant $1$ but **spectral gap only $2/n\to 0$** — it is a *weak* expander, with the coordinate cuts themselves as its worst spectral cuts. And induced subgraphs are arbitrarily worse: any subcube (interval) $[S,T]=\{A:S\subseteq A\subseteq T\}$ is itself union-closed and is just a lower-dimensional cube — so $G(\mathcal F)$ ranges over "all induced subgraphs of all cubes" with no expansion floor. There is no structural truth "union-closed families are expanders," and no "width" knob to impose one.

### 3.4 GAP E3 — no Theorem-E conversion from volume-imbalance to a conductance bottleneck

Theorem E (`step8.tex`) is the *conversion step*: it turns "every pair-cut has imbalanced volume" into "there exists a pair-cut with *low conductance*" — moving the problem from a volume statement to a boundary/spectral statement, where the rigidity engine can bite. The conversion is a Dirichlet-form comparison plus an averaging argument that **uses the specific local geometry of width-3 rich pairs** — the 2-dimensional grid fibers of Step 1.

For Union-Closed: a counterexample gives $|\mathcal F_x|<|\mathcal F_{\bar x}|$, i.e. volume $a(x)<\tfrac12$, for all $x$. Does this *convert* to a conductance statement? The boundary of the cut $\mathcal F_x$ is $|M_x|=|\mathcal F_x|-|\mathcal F_x^{\mathrm{stuck}}|$, and the transport identity $\beta_x=|\mathcal F_x^{\mathrm{stuck}}|-|\mathcal F_{\bar x}^{\mathrm{stuck}}|<0$ gives only $|\mathcal F_x^{\mathrm{stuck}}|<|\mathcal F_{\bar x}^{\mathrm{stuck}}|$ — **no bound on $|M_x|$ relative to $|\mathcal F_x|$**. A counterexample can have large $|M_x|$ (high conductance) *or* small $|M_x|$ (low conductance); the volume statement does not pin the boundary statement. There is no union-closed Theorem E, because the machinery that would build it — the rich-pair 2D-grid fiber coordinate system — has *no union-closed analogue* (there are no "rich pairs," no "fibers," no "grid"; the local model of a coordinate cut in $Q_n$ is just a perfect matching, with no internal 2-dimensional structure to stabilise).

### 3.5 Verdict on mechanism (a): framework transfers, engine fails — named gaps E1, E2, E3

The setup of mechanism (a) transfers cleanly (§3.1) and is the spine of the product-line framework. The *engine* does not transfer: **E1** (no irreducible transport chain — $G(\mathcal F)$ disconnected), **E2** (no width-3-type rigidity knob; the cube is only a weak expander and induced subgraphs are unbounded-ly worse), **E3** (no Theorem-E conversion of volume-imbalance into a conductance bottleneck — the conversion is powered by width-3 rich-pair grid fibers with no union-closed counterpart). Mechanism (a) is a faithful *picture* for Union-Closed and a non-functional *proof engine*.

---

## §4. Feasibility against Mechanism (b): F-series cohomological

### 4.1 What the F-series actually uses — the moduli space, not the single object

The decisive observation, and the source of (C1): **the F-series does not work with $\Delta(P)$ for the single poset $P$.** It works with $\Delta(\mathrm{PPF}_n)$ — the order complex of the space of *all* posets on $[n]$ — in which the single $P$ is just one *vertex*. The conjecture about $P$ is extracted from the *global* cohomology of the moduli complex via the ICOP pairing, and the proof inducts on $n$ across the whole moduli tower. (mg-26fc §3.4 makes this explicit: "$\mathrm{PPF}_n$ vs. fixed $P$" — the F-series object is global over all posets at once.)

So the two 1/3-2/3 mechanisms work at **different levels**: mechanism (a) is *internal* — the single object's state space — and mechanism (b) is *modular* — the moduli space of all objects. Any honest port of (b) to Union-Closed must therefore be a port to the **moduli space of all union-closed families**, not to the single $\mathcal F$.

### 4.2 GAP C1 — the README's $\Delta(\mathcal F)$ is the wrong level

The README expects the intrinsic object to be "$(\mathcal F,\subseteq)$ ... with order complex $\Delta(\mathcal F)$." By §4.1, this is the *internal* topology of the single family $\mathcal F$ — it is the cohomological **sibling of $G(\mathcal F)$** (both are "the single object's own geometry"), and it is the analogue of "$\Delta$ of the single poset" or "a complex on $\mathcal L(P)$" — which mechanism (b) **does not use**. The analogue of $\Delta(\mathrm{PPF}_n)$ is $\Delta(\mathrm{UCF}_n)$, candidate (C) of §1.2. This is not a fatal error in the README — $\Delta(\mathcal F)$ is a legitimate object of study (§8.3) — but it is a *level confusion*: $\Delta(\mathcal F)$ cannot play the F-series role, and a cohomological-route attack must be built on $\mathrm{UCF}_n$ instead. §4.3–§4.6 assess that.

### 4.3 GAP C2 — the moduli object $\mathrm{UCF}_n$ is doubly-exponential, with no sphere

$\mathrm{UCF}_n$ = the set of all union-closed families on $[n]$, ordered by inclusion. It *is* a lattice (the union-closed families are exactly the closed sets of the "close under union" closure operator on $2^{2^{[n]}}$, and closed sets of a closure operator form a lattice), $S_n$-equivariant — so structurally it is a candidate moduli object. But:

**(C2.a) Doubly-exponential size.** For each subset $\mathcal S$ of the middle layer $\binom{[n]}{\lfloor n/2\rfloor}$, the generated family $\langle\mathcal S\rangle$ (all unions) satisfies $\langle\mathcal S\rangle\cap\binom{[n]}{\lfloor n/2\rfloor}=\mathcal S$ (a union of two distinct middle-layer sets has size $>\lfloor n/2\rfloor$), so $\mathcal S\mapsto\langle\mathcal S\rangle$ is injective. Hence
$$
  |\mathrm{UCF}_n|\;\ge\;2^{\binom{n}{\lfloor n/2\rfloor}}\;=\;2^{\,2^n/\mathrm{poly}(n)}\qquad\text{— doubly-exponential in }n.
$$
Contrast: $|\mathrm{PPF}_n|=2^{n^2/4+o(n^2)}$ is "merely" super-exponential, and F11 §3 *already* used exactly this growth rate to **close F-series route (i) NEGATIVE** — a finitely generated FI-module over a field has eventually-*polynomial* dimension, so the super-exponential chamber-quotient cochain complex cannot be finitely generated. The union-closed moduli object grows *strictly faster than the object that already broke that route.* Whatever finite-ambient / FI-finite-generation hope mechanism (b) rests on is in a *strictly worse* position for Union-Closed than for 1/3-2/3.

**(C2.b) No (H-Cox) analogue.** Mechanism (b)'s entire obstruction is **(H-Cox)**: $\Delta(\mathrm{PPF}_n)\simeq_{\mathbb Q}S^{n-2}$, a rational homology *sphere*. This is a special, near-miraculous fact about $\mathrm{PPF}_n$ (it is Coxeter-complex-flavoured — the proper part of the Boolean lattice $2^{[n]}$ is genuinely $\simeq S^{n-2}$, and $\mathrm{PPF}_n$ inherits a shadow of that). $\mathrm{UCF}_n$ is a closure lattice with **no reason whatsoever** to have a homology-sphere order complex — "natural" lattices (partition lattice, subgroup lattices) are typically *wedges of many spheres* (Cohen–Macaulay at best), not single spheres. Without (H-Cox) there is no $\omega_{\mathrm{bal}}$, no ICOP, no cofiber concentration — the obstruction does not even get stated. Establishing a (H-Cox) analogue for $\mathrm{UCF}_n$ would be a research programme of its own; the analogy does not *hand* it to you.

### 4.4 GAP C3 — wrong symmetry group: $S_n$ / FI vs $(\mathbb Z/2)^n$ / Walsh

Mechanism (b)'s machinery is **$S_n$-Coxeter-built**: the sgn-isotype $\widetilde H^{n-2}(\Delta_n)\cong\mathrm{sgn}_{S_n}$, the FI-module / representation-stability framework (Church–Ellenberg–Farb), the "$S_n$-orbit-quotient is rationally contractible so the content is forced into the one nontrivial isotype" framing (F11 §3.3) — all of it is the representation theory of the symmetric group acting on a Coxeter-flavoured complex.

Union-Closure *is* $S_n$-equivariant (§1.7), so $S_n$-machinery is not categorically excluded. But the *obstruction itself* — the bias $\beta_x$ — lives in the **$(\mathbb Z/2)^n$ / Walsh** world (O3): $\beta_x$ is a level-1 Walsh character sum. The natural harmonic decomposition of $\mathbf 1_{\mathcal F}$ is the *Fourier–Walsh* expansion (characters of $(\mathbb Z/2)^n$, indexed by subsets), **not** the $S_n$-isotypic decomposition. And $(\mathbb Z/2)^n$ is not even a symmetry of the conjecture class (it does not preserve union-closure, §1.7). So mechanism (b) would have to extract a $(\mathbb Z/2)^n$-flavoured obstruction using $S_n$-flavoured machinery — and there is no F-series component that does $(\mathbb Z/2)^n$ harmonic analysis. The "sign representation" that does the work in (b) is $\mathrm{sgn}_{S_n}$; the "sign" that does the work in Union-Closed is the *level-1 Walsh character* $\chi_x$ — a character of a *different group*, playing a *different role* (a Coxeter-isotype vs. a harmonic mode). Same word, different mathematics — the same kind of false-friend mg-26fc §3.4 flagged between the two 1/3-2/3 signs, but sharper here.

### 4.5 GAP C4 — no refinement-cover $\leftrightarrow$ decision substrate correspondence

mg-26fc §3.2 identified the **single solid, load-bearing hinge** of the 1/3-2/3 dictionary: the refinement cover $P\lessdot P^+$ in $\mathrm{PPF}_n$ (adding the relation $x<y$) corresponds *exactly* to the pair-cut $S_{xy}$, with $|\mathcal L(P^+)|=|\mathcal L_{x<y}(P)|$ — the **shared substrate** of pair-orientation linear-extension counts. mg-26fc called this "the deepest layer of the dictionary, and it is solid."

For Union-Closed there is **no such correspondence.** A cover $\mathcal F\lessdot\mathcal F^+$ in $\mathrm{UCF}_n$ adds one set (and re-closes under union). Adding a *set* to the family does **not** "decide" anything about a *ground element's* abundance — there is no quantity attached to a $\mathrm{UCF}_n$-cover that equals an abundance count, the way $|\mathcal L(P^+)|$ equals a pair-orientation count. The objects of $\mathrm{UCF}_n$ (families) and the carriers of the obstruction (ground elements $x$) are at different levels, with no cover-step bridge between them. The *hinge* of the 1/3-2/3 dictionary — the part mg-26fc certified as solid — is exactly the part with no union-closed analogue.

### 4.6 GAP C5 — no clean $n$-induction

Mechanism (b)'s spine is **induction on $n$** via the inclusion $\iota_n:\mathrm{PPF}_n\hookrightarrow\mathrm{PPF}_{n+1}$ and the cofiber LES, with the F8 *multiplicativity law* ($|\mathcal L(\iota P)|=(n{+}1)|\mathcal L(P)|$) making the induction's arithmetic clean.

The ground-set inclusion $\iota:\mathrm{UCF}_n\hookrightarrow\mathrm{UCF}_{n+1}$ (a family on $[n]$, with $n{+}1$ in no set) acts on the obstruction as follows: $\iota\mathcal F$ has $(\iota\mathcal F)_{n+1}=\emptyset$, so $\beta_{n+1}(\iota\mathcal F)=-|\mathcal F|<0$, while every other $\beta_x$ is unchanged. So **$\iota\mathcal F$ is a counterexample iff $\mathcal F$ is** — counterexamples *inject* from $[n]$ into $[n+1]$. That is the *wrong direction* for an induction (which would need: a counterexample on $[n{+}1]$ produces one on $[n]$, plus a "minimal counterexample" reduction). And there is no multiplicativity law: adding an element does not act on the abundance obstruction by any clean arithmetic rule. The inductive engine of (b) has no union-closed track to run on.

### 4.7 The one genuine resonance — and the Walsh bonus

It is not *all* negative, and the verdict must say why. Two genuine connections survive:

**The expansion$\leftrightarrow$cohomology meta-principle still applies.** mg-26fc §4.2 invoked Cheeger / Garland / topological expansion to link mechanism (a) and (b) for 1/3-2/3 *as resonance, not identity*. The same meta-principle links the Union-Closed expansion picture (§3) and any future Union-Closed cohomological picture: graph expansion and cohomology vanishing are quantitatively tied. In particular the disconnection of $G(\mathcal F)$ (E1) is literally an $H^0$ statement — the lowest-degree shadow of the meta-principle. So a *Union-Closed-native* cohomological story is not excluded; what is excluded is the *F-series* cohomological story (the $\Delta(\mathrm{PPF}_n)$ cathedral).

**The Walsh bonus — a structure 1/3-2/3 does not have.** $\beta_x=-2^n\widehat{\mathbf 1_{\mathcal F}}(\{x\})$ gives Union-Closed a *direct harmonic handle on the obstruction* with no 1/3-2/3 counterpart: there is no clean "$p_{xy}$ is a Fourier coefficient of something" on the 1/3-2/3 side. This is the current research frontier — Gilmer's 2022 entropy method and the $(3-\sqrt5)/2$ improvements are, morally, *level-1-spectrum estimates for indicators of union-closed families*. The harmonic picture (E) is where Union-Closed's *native* engine plausibly lives, and it is genuinely *richer* than anything mechanism (a) or (b) offers — it is just not *either* 1/3-2/3 mechanism.

### 4.8 Verdict on mechanism (b): the cathedral does not transfer — named gaps C1–C5

The F-series cohomological cathedral does not transfer: **C1** ($\Delta(\mathcal F)$ is the wrong level — internal sibling of $G(\mathcal F)$, not the moduli analogue), **C2** ($\mathrm{UCF}_n$ is doubly-exponential — strictly worse than the object that already closed F-series route (i) — with no (H-Cox) homology-sphere analogue), **C3** (wrong symmetry group — $S_n$/FI machinery vs. the $(\mathbb Z/2)^n$/Walsh home of the obstruction), **C4** (no refinement-cover$\leftrightarrow$decision substrate correspondence — the solid hinge of the 1/3-2/3 dictionary has no union-closed analogue), **C5** (no clean $n$-induction — the ground-set inclusion acts the wrong way on the obstruction, with no multiplicativity law). The resonance that *does* survive — the expansion$\leftrightarrow$cohomology meta-principle, and the Walsh bonus — points *away* from the F-series and *toward* a native harmonic engine.

---

## §5. The 1/3-2/3 ⟷ Union-Closed dictionary, rigorized on the Union-Closed side

Status flags: ✓ transfers cleanly · ◐ transfers with a named gap · ✗ breaks.

| 1/3-2/3 object (mechanism) | Union-Closed analogue | Status | Note |
|---|---|---|---|
| State space $\mathcal L(P)$ (a) | the family $\mathcal F$ itself | ✓ | §3.1 — the family *is* the state space |
| Ambient: permutahedron skeleton (a) | the Boolean cube $Q_n$ | ✓ | §3.1 — $Q_n$ is *more* symmetric than the permutahedron |
| $G_{\mathrm{BK}}(P)$ = induced subgraph (a) | $G(\mathcal F)$ = induced subgraph of $Q_n$ | ◐ | §3.1 setup transfers; §3.2 **E1**: $G(\mathcal F)$ disconnected, BK-connectivity has no analogue |
| Local moves: order-preserving adjacent swaps (a) | coordinate toggles $M_x$ = partial cube-involutions (a) | ✓ | §1.4 — the cleanest transfer; Daniel's $\varphi_x$ pinned exactly |
| Pair-cut $S_{xy}$, volume $p_{xy}$ (a) | coordinate-cut $\mathcal F_x$, volume $a(x)$ | ✓ | §3.1 |
| Balanced obstruction $p_{xy}\in[1/3,2/3]$ (a) | $a(x)\ge\tfrac12$; centroid $\notin[0,\tfrac12)^n$ | ◐ | §1.1 (D1) point-vs-interval; (D2) the two sides are asymmetric (filter vs ideal) |
| Connectivity (Bubley–Karzanov theorem) (a) | — | ✗ | §3.2 **E1** — fails outright |
| Theorem E: counterexample $\Rightarrow$ low-conductance cut (a) | — | ✗ | §3.4 **E3** — no volume$\to$conductance conversion |
| Steps 1–7 rigidity engine: rich-pair 2D grid fibers (a) | — | ✗ | §3.3 **E2** — no width-3 knob, no rich pairs, no fibers |
| $\mathrm{PPF}_n$, the moduli space of all posets (b) | $\mathrm{UCF}_n$, the moduli space of all union-closed families | ◐ | §4.3 **C2** — exists, is a lattice, but doubly-exponential |
| $\Delta(\mathrm{PPF}_n)$, the F-series ambient complex (b) | $\Delta(\mathrm{UCF}_n)$ (not $\Delta(\mathcal F)$ — that is the *internal* object) | ✗ | §4.2 **C1** + §4.3 **C2.b** — wrong level if $\Delta(\mathcal F)$; no homology-sphere if $\Delta(\mathrm{UCF}_n)$ |
| (H-Cox)+(sgn): $\Delta_n\simeq_{\mathbb Q}S^{n-2}$, top cohomology $=\mathrm{sgn}_{S_n}$ (b) | — | ✗ | §4.3 **C2.b** — no reason for a sphere; §4.4 **C3** — no sgn |
| $\omega_{\mathrm{bal}}^{(n)}$, the sign-isotypic cocycle (b) | the level-1 Walsh character $\chi_x$ / coefficient $\beta_x$ | ◐ | §4.4 **C3** — both are "signs," but $\mathrm{sgn}_{S_n}$-isotype vs. $(\mathbb Z/2)^n$-harmonic mode: false friends |
| refinement cover $P\lessdot P^+$ $\leftrightarrow$ pair-cut; shared substrate $|\mathcal L(P^+)|=|\mathcal L_{x<y}(P)|$ (b) | — | ✗ | §4.5 **C4** — the *solid hinge* of the 1/3-2/3 dictionary has no analogue |
| cofiber-LES induction $\Delta_n\hookrightarrow\Delta_{n+1}$; F8 multiplicativity (b) | — | ✗ | §4.6 **C5** — ground-set inclusion acts the wrong way; no multiplicativity law |
| ICOP pairing $\langle\omega_{\mathrm{bal}},c^*\rangle\neq0$ (b) | — | ✗ | §4.3/§4.4 — no $\omega_{\mathrm{bal}}$, no critical chain |
| $S_n$-equivariance in the load-bearing role (b) | $S_n$ on $\mathrm{UCF}_n$; **but** $(\mathbb Z/2)^n$ on $Q_n$ for the obstruction | ◐ | §1.7, §4.4 **C3** — the load-bearing symmetry *splits* |
| the expansion$\leftrightarrow$cohomology meta-principle (links a,b) | same meta-principle; $H^0(G(\mathcal F))$ = disconnection = its lowest shadow | ✓ | §4.7 — survives as resonance, not identity |
| — *(no 1/3-2/3 analogue)* — | **the Walsh bonus**: $\beta_x=-2^n\widehat{\mathbf 1_{\mathcal F}}(\{x\})$ | ✓ new | §4.7 — a native harmonic handle 1/3-2/3 lacks; the home of Gilmer's frontier |

**Reading the table.** The *setup rows* of mechanism (a) are ✓; its *engine rows* are ✗. *Every* mechanism-(b) row is ◐ or ✗, and the two structurally most important (b)-rows — the substrate correspondence and the homology sphere — are ✗. The one wholly new ✓ is the Walsh bonus, which belongs to *neither* 1/3-2/3 mechanism.

---

## §6. Which mechanism does Union-Closed resonate with — one, both, or neither?

The ticket's sharp question. The answer is precise and three-layered:

1. **Framework level: Union-Closed resonates with mechanism (a), strongly.** $\mathcal F\subseteq Q_n$ with $G(\mathcal F)$ the induced transport graph is the *cleanest possible* analogue of $\mathcal L(P)\subseteq$ permutahedron with $G_{\mathrm{BK}}(P)$ the induced graph — cleaner, even, since $Q_n$ is more symmetric than the permutahedron skeleton. The coordinate-transport involutions, the coordinate cuts, the centroidal obstruction, the meta-thesis description "constrained geometry cannot remain globally biased" — all are faithful. It resonates with mechanism (b) only *weakly* at the framework level: the moduli object $\mathrm{UCF}_n$ exists and is $S_n$-equivariant, but that is where the resemblance stops.

2. **Engine level: Union-Closed resonates with *neither* mechanism.** Mechanism (a)'s engine fails on E1–E3; mechanism (b)'s cathedral fails on C1–C5. *Neither* 1/3-2/3 proof engine provides a working mechanism for Frankl. This is the central finding of UC1.

3. **Native level: Union-Closed has a structure *neither* 1/3-2/3 mechanism has** — the Walsh harmonic handle $\beta_x=-2^n\widehat{\mathbf 1_{\mathcal F}}(\{x\})$ (§4.7). The cross-product comparison's most valuable output is *negative-with-a-direction*: it rules out porting either engine, and it points at the harmonic / $(\mathbb Z/2)^n$ structure as the place a native engine must be built.

**For the meta-thesis** ("a constrained compatibility geometry cannot remain globally isotropic"): mg-26fc found 1/3-2/3 instantiates the meta-thesis *twice* (two mechanisms) — the *stronger* outcome. Union-Closed instantiates the meta-thesis **descriptively faithfully** (the centroidal obstruction (O4) is the meta-thesis verbatim) but **does not inherit either mechanism's machinery**. So Union-Closed is a *weaker* instance: it confirms the meta-thesis is a real family resemblance, but it also shows the *machinery* does not come for free with the resemblance — each conjecture needs its own engine. That, too, is information: the meta-thesis is a *principle*, not a *transfer theorem*.

---

## §7. Verdict

**AMBER-partial-transfer.**

The Union-Closed compatibility-geometry **framework transfers** — the intrinsic object is pinned (the cube $Q_n$ + the transport graph $G(\mathcal F)$ + the level-1 Walsh spectrum, §1.3), the coordinate-transport involutions are pinned exactly (the partial matchings $M_x$, with the transport identity $\beta_x=|\mathcal F_x^{\mathrm{stuck}}|-|\mathcal F_{\bar x}^{\mathrm{stuck}}|$, §1.4), the balanced obstruction is pinned geometrically (the centroid cannot lie in the small corner $[0,\tfrac12)^n$, §1.6), and the structural gifts of union-closure are stated (§1.5). The framework is genuine and load-bearing: it founds the product line.

But the framework transfers **decoupled from both 1/3-2/3 proof engines.** Mechanism (a)'s *setup* transfers cleanly while its *engine* fails on three named gaps (**E1** disconnected transport graph / no irreducible chain; **E2** no width-3 rigidity knob, cube only a weak expander; **E3** no Theorem-E volume$\to$conductance conversion). Mechanism (b)'s cathedral does not transfer, on five named gaps (**C1** $\Delta(\mathcal F)$ is the wrong level; **C2** $\mathrm{UCF}_n$ is doubly-exponential with no homology-sphere analogue; **C3** wrong symmetry group, $S_n$/FI vs $(\mathbb Z/2)^n$/Walsh; **C4** no substrate correspondence — the solid hinge of the 1/3-2/3 dictionary has no analogue; **C5** no clean $n$-induction). Union-Closed resonates with the *framework* of (a) and the *engine* of neither (§6).

**Why AMBER and not GREEN.** GREEN-framework-transfers requires the framework to transfer "*via one or both mechanisms*." Here the framework transfers but *decoupled from both mechanisms* — and a concrete first attack (UC2) can be scoped, but only as a **native construction**, not as a port of an inherited engine. That is precisely the AMBER profile: "some pieces transfer, named gaps remain; the manifesto is built but the first-attack statement [must be re-grounded natively rather than inherited]."

**Why AMBER and not RED.** RED-analogy-superficial would require the analogy to *fail in a load-bearing way*. It does not: $G(\mathcal F)\subseteq Q_n$ is a genuine, exact, load-bearing analogue of $G_{\mathrm{BK}}(P)\subseteq$ permutahedron; the transport identity is exact; the centroidal obstruction is the meta-thesis verbatim; and there is a *new* native structure (the Walsh handle) that strengthens, not weakens, the case for the product line. The analogy carries — at the framework level — and it carries enough to found the repo and to scope UC2.

**The honest one-sentence verdict.** *The compatibility-geometry framework transfers to Frankl cleanly and even gains a native harmonic handle, but it transfers decoupled from both 1/3-2/3 proof engines — so the product line is viable, and its first concrete attack (UC2) must build a native engine on the cube/Walsh/transport structure rather than port the BK/Cheeger spine or the F-series cohomological cathedral.*

---

## §8. The first concrete attack — UC2 scoped

### 8.1 Why UC2 must be a native construction

§§3–6 establish that *neither* 1/3-2/3 engine ports. Therefore UC2 must **not** be "port Theorem E" or "build $\Delta(\mathrm{UCF}_n)$ and look for (H-Cox)" — those are the dead routes, dead for the precisely-named reasons E1–E3 / C1–C5. UC2 must be a *native* construction on the objects §1 pinned: the transport graph $G(\mathcal F)$, the partial matchings $M_x$, the stuck-sets, and the level-1 Walsh spectrum. The good news from §1: those objects are *real, elementary, and constrained by union-closure* — there is genuine structure to attack.

### 8.2 UC2 primary target — the coordinate-transport deficiency question

The transport identity $\beta_x=|\mathcal F_x^{\mathrm{stuck}}|-|\mathcal F_{\bar x}^{\mathrm{stuck}}|$ (§1.4) reframes Frankl as: **every union-closed $\mathcal F$ has a coordinate $x$ that is not "transport-deficient,"** i.e. $|\mathcal F_x^{\mathrm{stuck}}|\ge|\mathcal F_{\bar x}^{\mathrm{stuck}}|$. A counterexample is *transport-deficient in every coordinate*.

> **UC2 primary deliverable.** Establish the structure theory of the coordinate-transport system $\bigl(G(\mathcal F),\{M_x\},\{\mathcal F_x^{\mathrm{stuck}},\mathcal F_{\bar x}^{\mathrm{stuck}}\}\bigr)$ rigorously, and attack the central question: **does union-closure forbid simultaneous transport-deficiency in every coordinate?** Concretely:
> 1. **Characterize the stuck-sets.** $\mathcal F_x^{\mathrm{stuck}}$ = sets that *need* $x$; $\mathcal F_{\bar x}^{\mathrm{stuck}}$ = sets that *reject* $x$. Pin their structure via union-closure: how does $\mathcal F_x^{\mathrm{stuck}}$ relate to the join-irreducibles of $(\mathcal F,\subseteq)$ and to the lower-cover structure? Is $\mathcal F_{\bar x}^{\mathrm{stuck}}$ (a subset of the union-closed family $\mathcal F_{\bar x}$, UC-Lemma 2) controlled by $\mathcal F_{\bar x}$'s own maximum $T_x$?
> 2. **Attack the injection.** Frankl $\Leftrightarrow$ $\exists x$ with an injection $\mathcal F_{\bar x}\hookrightarrow\mathcal F_x$ (UC-Lemma 3). Union-closure hands you the non-injective union map $u_W$. Test whether $u_W$ — or an averaged / per-coordinate-best variant — can be made injective *on the stuck part* for *some* $x$, using the interlock between $\{u_W\}$ and $\{M_x\}$. The "compatibility geometry" is exactly this interlock: the matchings $M_x$ for different $x$ are the partial cube structure, and union-closure couples them.
> 3. **Test the meta-thesis mechanism.** State precisely whether "the $\{M_x\}$ fail to globalize to a $(\mathbb Z/2)^n$-action" *forces* $\max_x\beta_x\ge0$ — and if so, what the forcing mechanism is; if not, exhibit the obstruction.

This is native (it lives on §1's objects), paper-and-pencil tractable (the lemmas of §1.5 are elementary), and it is the *direct* descendant of Daniel's setup sketch ("coordinate-transport involutions ... a transport system ... union closure should force the transport system to fail to globalize").

### 8.3 UC2 fallback sub-targets

If the primary target stalls, three native fallbacks, in priority order:

- **(F-i) The Walsh / harmonic route.** $\beta_x=-2^n\widehat{\mathbf 1_{\mathcal F}}(\{x\})$ (O3). Characterize the level-1 Walsh spectrum of indicators of union-closed families, and frame Gilmer's entropy method as a *compatibility-geometry* statement (entropy/expansion of $\mathbf 1_{\mathcal F}$ under the coordinate involutions). This is the route closest to the current frontier and may "compatibility-geometrize Gilmer."
- **(F-ii) The component / $H^0$ route.** Study $H_0(G(\mathcal F))$ — the component structure of the transport graph (E1's silver lining) — as the lowest-degree compatibility-geometry defect, and ask whether union-closure's constraint on the component lattice forces abundance. This is the *native* cohomological object (degree 0), as opposed to the dead F-series cathedral.
- **(F-iii) The square-defect route.** The cubical complex $X(\mathcal F)$ (candidate (D), §1.2): the *missing* squares/subcubes of $Q_n$ measure the literal failure of $\sigma_x,\sigma_y$ to commute on $\mathcal F$. Quantify the "compatibility defect" $=$ (missing subcubes) and relate it to the bias.

### 8.4 What UC2 must NOT do

- **Do not port Theorem E or the Steps 1–7 rigidity engine** — E1–E3 are fatal and precisely named; there is no width-3 knob, no rich-pair fiber, no volume$\to$conductance conversion.
- **Do not build a $\Delta(\mathrm{UCF}_n)$ chamber ambient and hunt for (H-Cox)** — C2 is fatal: $\mathrm{UCF}_n$ is doubly-exponential, *strictly worse* than the super-exponential object that already closed F-series route (i) (F11 §3); and there is no homology-sphere analogue. This route is dead by the *same logic* F11 used, only sharper.
- **Do not assume the $S_n$-isotypic machinery applies** — C3: the obstruction's harmonic home is $(\mathbb Z/2)^n$/Walsh, not $S_n$/FI.
- **No new axioms; no Lean; no computation** — UC2, like UC1, is paper-and-pencil scoping + construction, per the product-line constraints.

---

## §9. References

### 9.1 Cross-repo — the 1/3-2/3 reference mechanisms (`one_third_width_three`, read access)

- **mg-26fc** — `docs/compatibility-geometry-structural-analogy-scoping.md`, branch `compat-geom-mg26fc-bruhat-expansion-lens`. The 1/3-2/3 column rigorized; verdict GREEN-distinct-complementary; §1 (BK/Cheeger column), §2 (F-series column), §3.2 (the solid refinement-cover$\leftrightarrow$pair-cut hinge), §4.2 (expansion$\leftrightarrow$cohomology meta-principle), §6 follow-up 3 (check Union-Closed against both mechanisms — *this ticket*).
- **mg-8216 (F10)** — `docs/general-n-proof-synthesis.md`. The F-series cohomological proof skeleton: §1.2 (H-Cox)+(sgn); §6.2 cofiber-LES induction; §6.3 (UCC); §7.2 (FG-Cofiber).
- **mg-b352 (F11)** — `docs/state-F11.md`. §3: F-series route (i) closed NEGATIVE because $|\mathrm{PPF}_n|$ is super-exponential ⟹ not a finitely generated FI-module — the precedent C2 sharpens; §4: the triple connecting map $\partial_n$.
- **`main.tex`** — §"Approach: Cheeger-type expansion on the BK graph"; the 8-step BK-expansion program.
- **`step8.tex`** — Theorem E (counterexample ⟹ low BK conductance); Hypothesis A.

### 9.2 This repo

- **`README.md`** — the structural analogy table + the intrinsic-object expectation (mayor scaffold, 2026-05-14). UC1 refines: the README's $\Delta(\mathcal F)$ is the *internal* object (C1); the load-bearing intrinsic object is the cube $Q_n$ + $G(\mathcal F)$ + the Walsh spectrum.

### 9.3 Frankl-conjecture literature

- P. Frankl (1979) — the original Union-Closed Sets conjecture.
- H. Bruhn, O. Schaudt, *The journey of the union-closed sets conjecture*, Graphs and Combinatorics 31 (2015) — the comprehensive survey; small cases, the lattice reformulation, partial results.
- B. Poonen, *Union-closed families*, J. Combin. Theory Ser. A 59 (1992) — FC-families; the lattice reformulation (every finite lattice has a join-irreducible $j$ with $|{\uparrow}j|\le|L|/2$). The $x\leftrightarrow$ join-irreducible dictionary is *not* a clean bijection — noted here as a known equivalent, not made load-bearing.
- E. Knill (1994); G. Lo Faro; I. Roberts, J. Simpson — small-family and small-ground-set partial results.
- J. Gilmer, *A constant lower bound for the union-closed sets conjecture* (2022) — the entropy/information-theoretic method; $\approx 1\%$ lower bound.
- W. Sawin; Z. Chase, S. Lovett; R. Alweiss, B. Huang, M. Sellke; L. Pebody (2022–2023) — the improvement to $(3-\sqrt5)/2\approx0.38197$, and Sawin's observation that the entropy method alone caps near there. Morally, level-1-spectrum estimates for indicators of union-closed families — the home of UC2 fallback (F-i).

### 9.4 Compatibility-geometry / harmonic / topological background

- A. Bubley, M. Karzanov (1998) — the BK Markov chain on linear extensions; connectivity + spectral gap controls mixing. The connectivity theorem with no union-closed analogue (E1).
- J. Cheeger (1970); H. Garland (1973); N. Linial, R. Meshulam (2006); M. Gromov (2010) — the expansion$\leftrightarrow$cohomology meta-principle (§4.7), via mg-26fc §4.2.
- R. O'Donnell, *Analysis of Boolean Functions* (2014) — Walsh–Fourier analysis on the cube; the level-1 spectrum (O3, §4.7).
- T. Church, J. Ellenberg, B. Farb (2015) — FI-modules; finitely generated ⟹ eventually-polynomial dimension. The criterion C2 invokes.
- D. Kleitman, B. Rothschild (1975) — $a(n)=2^{n^2/4+o(n^2)}$, the super-exponential poset count F11 §3 used and C2 sharpens (the union-closed count is *doubly* exponential).

### 9.5 Source directives

- Daniel directives 2026-05-14 — the `union_closed` new-repo assignment to pm-onethird; the setup sketch (coordinate-transport involutions / Markov-chain spectral bound / "union-closed implies some cohomological property to test").
- mg-26fc §6 follow-up 3 — check the Union-Closed framework against *both* 1/3-2/3 mechanisms. Discharged here: §3 (mechanism a), §4 (mechanism b), §6 (resonance verdict).

---

*Polecat: mg-f72a (UC1). Branch: `union-closed-UC1-manifesto-scoping`. Verdict: **AMBER-partial-transfer** — the compatibility-geometry framework transfers (intrinsic object = the cube $Q_n$ + transport graph $G(\mathcal F)$ + level-1 Walsh spectrum; coordinate-transport involutions = the partial matchings $M_x$ with $\beta_x=|\mathcal F_x^{\mathrm{stuck}}|-|\mathcal F_{\bar x}^{\mathrm{stuck}}|$; obstruction = the centroid cannot lie in $[0,\tfrac12)^n$), but **decoupled from both 1/3-2/3 proof engines**: mechanism (a)'s engine fails on E1–E3, mechanism (b)'s cathedral fails on C1–C5. Union-Closed resonates with the framework of (a), the engine of neither, and has a native harmonic handle ($\beta_x$ = level-1 Walsh coefficient) belonging to neither. UC2 is scoped: the native coordinate-transport deficiency question, with Walsh / $H^0$ / square-defect fallbacks. No new axioms; no Lean; no computation. 1/3-2/3 route-(ii) critical path untouched.*
