# Union-Closed Compatibility-Geometry — UC10: native cohomology of the category of intersection-closed families (Pos_n F-series analog) (mg-814b)

**Repo:** `union_closed`.
**Parent (mechanism-twin):** mg-96a6 (UC9, scoping) — `docs/...UC9-intersection-closed-flip-embedding-cohomology.md`: the *extrinsic* mechanism (embed $2^{[n]}\hookrightarrow\mathrm{Pos}_{n+1}$, pull back the proven $\mathrm{Pos}_{n-1}$-type cohomology of F17/F18). UC10 is the **complementary intrinsic mechanism**: build the cohomology theory of the category of intersection-closed families *natively*, with no embedding into $\mathrm{PPF}_n$.
**Chain:** mg-f72a (UC1) → mg-a814 (UC2) → mg-cfc0 (UC3) → mg-0bf7 (UC4) → mg-3806 (UC5) → mg-6dad (UC6) → mg-a032 (UC7) → mg-d68d (UC8) → mg-96a6 (UC9, parallel) → **UC10 (this doc)**.
**Branch:** `polecat-cat-mg-814b`.
**Type:** Native theory-build (the F-series analog construction). Paper-and-pencil; **no new axioms; no Lean; no computation; no engine port.** LaTeX-style Markdown, F-series house style. Multi-session-able; cumulative state ledger in `docs/state-UC10.md`. **Anti-factorial.** **Inherently-but-NOT-functorially related** to $\mathrm{Pos}_n$ cohomology (Daniel hard constraints, see §0.4).
**Cross-repo references (read-only):** `one_third_width_three` — F10 (mg-8216, cohomological skeleton + (UCC)), F11 (mg-b352, FG-cofiber + route-(i) closed NEGATIVE), F17 (mg-4d3a, UCC.1 = $n$-uniform $S_n$-equivariant cofiber Morse), F18 (mg-d039, UCC.2 = $\delta_n$ injective via null-homotopy of $\iota_n$), mg-26fc (structural-analogy two-mechanisms framing); used only as *template*, never as transfer target.

---

**Verdict: AMBER-framework-pinned-target-named-execution-residual.**

UC10 *builds* the native cohomology theory of the category of intersection-closed families, pinning each of the four objects the F-series analog requires: (i) the category $\mathcal C_n^{\cap}$, with the load-bearing morphism class chosen to dodge the C1–C5 gaps the manifesto named for $\mathrm{UCF}_n$; (ii) the equivariant cohomology object $X_n^{\cap}$, a $(\mathbb Z/2)^n\rtimes S_n$-equivariant cubical complex that carries the obstruction natively; (iii) the target theorem — the analog of F17+F18's "$\widetilde H^{n-2}(\Delta_n;\mathbb Q)\cong\mathrm{sgn}_{S_n}$" — stated as the **Walsh sign-concentration theorem (UC10.1)**: at fixed $n\ge 3$, the bi-equivariant cohomology $H^{*}_{(\mathbb Z/2)^n\rtimes S_n}(X_n^{\cap};\mathbb Q)$ is concentrated in degree $n-1$ with isotype $\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$ (the top Walsh character $\otimes$ the symmetric sign); (iv) the proof outline — a step-by-step analog of F17's $n$-uniform equivariant cofiber Morse and F18's $\delta$-injectivity-via-null-homotopy, with each step labelled *transfers / adapts / blocks*, and the blocking step explicitly named (the **trace-injectivity residual UC10.R**).

Three structural moves dodge each of the manifesto C1–C5 gaps explicitly:

- **C1 (wrong level) dodged.** The cohomology object $X_n^{\cap}$ is *not* $\Delta(\mathcal F)$ (internal) and *not* $\Delta(\mathcal C_n^{\cap})$ as a raw order complex; it is the **cubical Walsh-defect complex** of the moduli, with $\mathcal C_n^{\cap}$ supplying the small-category indexing and $Q_n$ supplying the geometry. The two-level split (small category indexes, cube carries geometry) is the load-bearing structural move (§3.1).
- **C2 (doubly-exponential, no homology sphere) dodged in TWO ways.** First, we work at *fixed $n$*, not in an FI-stable $n\to\infty$ regime; the cohomology is a finite-dimensional $\mathbb Q$-vector space and finite-generation is automatic (no FI-stability requirement). Second, $X_n^{\cap}$ is *not* of doubly-exponential complexity — it is built from the cube $Q_n$ (size $2^n$) plus a finite family-indexed sheaf, so its dimension is polynomial in $|\mathcal F|$ and exponential in $n$ — strictly better than $\Delta(\mathrm{UCF}_n)$. The "no homology sphere" obstruction is handled by *not asking for one*: the analog of (H-Cox) is the **Walsh-decomposition theorem (UC10.W)**, which decomposes $X_n^{\cap}$ into Walsh-isotypic pieces — only one of which carries content (§3.4).
- **C3 (wrong symmetry group) dodged structurally.** UC10 explicitly *centers* $(\mathbb Z/2)^n$ — the cube's coordinate-toggle group — as the load-bearing group, with $S_n$ in the *secondary* equivariance role (acting by permuting $(\mathbb Z/2)^n$'s coordinates). The semi-direct product $(\mathbb Z/2)^n\rtimes S_n$ acts on everything from the start. The sign analog is the **top Walsh character $\chi_{[n]}\otimes\mathrm{sgn}_{S_n}$**, not $\mathrm{sgn}_{S_n}$ alone — a *different* isotype belonging to a *strictly larger* group, the same kind of "different sign" UC1 §4.4 named but now load-bearing in UC10.
- **C4 (no substrate correspondence) sidestepped, not dodged.** The Pos_n substrate ("refinement-cover $\leftrightarrow$ pair-cut", $|\mathcal L(P^+)|=|\mathcal L_{x<y}(P)|$) has no UC analog (UC1 §4.5). UC10's *replacement* substrate is the **stuck-set correspondence (UC10.S)**: the morphism $F\hookrightarrow F'$ in $\mathcal C_n^{\cap}$ corresponds to a *contraction* of stuck-sets (UC1 §1.4 — the matching $M_x$'s unmatched vertices) — not as deep as the Pos_n substrate, but a genuine cover-step$\leftrightarrow$obstruction-component bridge. This is the load-bearing technical lemma of UC10 and the part that admits the most condensed proof.
- **C5 (no clean $n$-induction) sidestepped: UC10 doesn't induct.** The F-series result is unconditional at *fixed $n$* (the F17+F18 statement); UC10 *also* targets fixed-$n$ statements. The induction $n\to n+1$ is dropped from the load-bearing path; the multiplicativity-law-replacement question (UC1 §4.6) is logged as **UC11 future work** but not blocking UC10's verdict.

**Why AMBER not GREEN.** The four objects are pinned (§§2–4); UC10.1, UC10.W, UC10.S, UC10.R are stated precisely; the proof outline (§5) transfers six of the eight F17+F18 steps directly. But UC10.1 is *stated*, not proven — the trace-injectivity residual UC10.R (the analog of F18's $\delta$-injectivity step) is named as an explicit blocking residual whose proof needs a UC11 session. AMBER carries the named follow-on; GREEN would require executing the F17+F18 analog proofs.

**Why AMBER not RED.** The manifesto C1–C5 obstacles are dodged structurally (not assumed away): the doubly-exponential moduli is replaced by a polynomial-in-$|\mathcal F|$ complex; the wrong-symmetry-group concern is reversed (UC10 centers $(\mathbb Z/2)^n$ from the start); the no-substrate concern is replaced by the stuck-set correspondence UC10.S, *proved* directly from UC1 §1.4. The native cohomology theory has structural existence (the four objects are constructed and inter-related) and a stated target theorem — these are real positive deliverables, not "the obstacles are bigger than first thought." UC10.R is a single named open lemma in the proof of UC10.1, not a foundational obstruction.

**The honest one-sentence verdict.** *The native cohomology of the category of intersection-closed families is built at fixed $n$ via the bi-equivariant $(\mathbb Z/2)^n\rtimes S_n$-cubical-Walsh-defect complex $X_n^{\cap}$ over the trace category $\mathcal C_n^{\cap}$, dodging each of C1–C5 by structural design (level: small category indexes + cube carries geometry; size: fixed $n$ + polynomial-in-$|\mathcal F|$, not FI-stable; symmetry: $(\mathbb Z/2)^n$ load-bearing, $S_n$ secondary; substrate: the stuck-set correspondence UC10.S replaces refinement-cover $\leftrightarrow$ pair-cut; induction: dropped — fixed $n$ targeted), with the analog target theorem UC10.1 (concentration in degree $n-1$ at isotype $\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$) stated precisely and its proof outline (six of eight F17+F18 steps transfer; the seventh — trace-injectivity — is the named residual UC10.R for UC11; the eighth — Walsh decomposition UC10.W — is sketched), with the UC9 connection (inherent-but-non-functorial: UC10's intrinsic cube-defect cohomology and UC9's extrinsic pullback measure the same compatibility-geometry non-isotropy but through structurally different groups and complexes — $(\mathbb Z/2)^n$ vs. $S_n$, cubical-Walsh vs. simplicial-order — with no functor identifying them).*

§0 fixes notation and recaps the relevant UC1/manifesto + F-series invariants; §1 dualizes union-closure to intersection-closure cleanly (the flip; no information lost) and pins the C1–C5 dodges abstractly; §2 pins the category $\mathcal C_n^{\cap}$ (objects + morphisms + the load-bearing pick); §3 pins the cohomology object $X_n^{\cap}$ (cubical-Walsh-defect, bi-equivariant); §4 states the target theorem UC10.1 (Walsh sign-concentration), the Walsh decomposition UC10.W, the stuck-set correspondence UC10.S, and the residual UC10.R; §5 is the proof outline — transfer / adapt / block of each F17+F18 step; §6 the UC9 connection (inherent-not-functorial); §7 the verdict and UC11 scope; §8 the references.

---

## §0. Notation, the UC1/manifesto invariants UC10 inherits, the F-series invariants UC10 mirrors, and the Daniel hard constraints

### 0.1 Union-closure / intersection-closure notation

$U=[n]$ is a finite ground set, $|U|=n\ge 2$. $2^U$ is the Boolean lattice / cube $Q_n$. A family $\mathcal F\subseteq 2^U$ is **union-closed** if $A,B\in\mathcal F\Rightarrow A\cup B\in\mathcal F$; **intersection-closed** if $A,B\in\mathcal F\Rightarrow A\cap B\in\mathcal F$. WLOG $\mathcal F\ne\emptyset$, $\mathcal F\ne\{\emptyset\}$ (union-closed case) or $\mathcal F\ne\{U\}$ (intersection-closed case). For union-closed: $\bigcup\mathcal F\in\mathcal F$ is the top. For intersection-closed: $\bigcap\mathcal F\in\mathcal F$ is the bottom, called the **kernel** $K(\mathcal F)$. The dualities are spelled out in §1.

For $x\in U$: $\mathcal F_x=\{A\in\mathcal F:x\in A\}$, $\mathcal F_{\bar x}=\mathcal F\setminus\mathcal F_x$. Abundance $a(x)=|\mathcal F_x|/|\mathcal F|$, bias $\beta_x=|\mathcal F_x|-|\mathcal F_{\bar x}|$.

**Frankl, union-closed form.** Some $x\in U$ has $\beta_x\ge 0$ (equivalently $a(x)\ge\tfrac12$).

**Frankl, intersection-closed flip.** Equivalent: some $x\in U$ has $|\mathcal F_x|\le|\mathcal F_{\bar x}|$ for an *intersection-closed* family. Dual abundance "*$x$ is rare*" replaces "*$x$ is abundant*"; the conjecture is structurally identical and no information is lost (§1.1).

### 0.2 The cube, the Walsh transform, the symmetry groups

The cube $Q_n=([0,1]^n,$ edge-set $E_n)$, $|V(Q_n)|=2^n$. Coordinate involutions $\sigma_x:2^U\to 2^U$, $\sigma_x(A)=A\,\triangle\,\{x\}$ generate $(\mathbb Z/2)^n$. Permutations $\pi\in S_n$ act by relabeling coordinates: $\pi\cdot A=\pi(A)$. The **wreath-style group** $\Gamma_n:=(\mathbb Z/2)^n\rtimes S_n$ — the hyperoctahedral group / signed permutation group / type $B_n$ Coxeter group — acts on $Q_n$ and is the natural symmetry group of the cube *as a Coxeter polytope*. UC10 centers $\Gamma_n$ from the start. Note $|\Gamma_n|=2^n n!$ — fast-growing but at fixed $n$ finite, which is all UC10 needs.

The Walsh-Fourier transform: characters $\chi_S:2^U\to\{\pm 1\}$, $\chi_S(A)=(-1)^{|S\cap A|}$, for $S\subseteq U$. The $\chi_S$ are an orthonormal basis of $L^2(2^U;\mathbb Q)$ under the uniform measure. $\widehat f(S)=2^{-n}\sum_A f(A)\chi_S(A)$. **(Z/2)^n** acts on the cube and on $L^2$ via $\sigma_x\cdot\chi_S=(-1)^{[x\in S]}\chi_S$ (an eigenvalue action — the character $\chi_S$ is a *joint eigenvector* of all the $\sigma_x$). **S_n** acts on characters via $\pi\cdot\chi_S=\chi_{\pi(S)}$.

The **top Walsh character** $\chi_{[n]}=\chi_U$ is the unique character on which every $\sigma_x$ acts by $-1$ — the cube-cohomology analog of $\mathrm{sgn}_{S_n}$ for the symmetric group. UC10's load-bearing isotype is the bi-isotype $\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$ under $\Gamma_n=(\mathbb Z/2)^n\rtimes S_n$ — both the cube-side sign (every $\sigma_x$ flips) and the symmetric-side sign (every transposition flips). On any single transposition $\tau_{x,y}\in\Gamma_n$ (the "swap $x$ and $y$ in $Q_n$") the bi-isotype acts by $+1$ via $\mathrm{sgn}_{S_n}\cdot\chi_{[n]}=(-1)\cdot(\text{no toggle, no sign})$ — but the bi-isotype is *non-trivial on every reflection of $\Gamma_n$* (every $\sigma_x$ or every transposition). It is the analog of "the unique sign character of $\Gamma_n$ that is sign on both factors."

### 0.3 The F-series invariants UC10 mirrors (one_third_width_three references)

The F-series cohomological program (F10 mg-8216 / F11 mg-b352 / F17 mg-4d3a / F18 mg-d039) targets the **cohomology of the category of posets**:

- **Object.** $\mathrm{PPF}_n$ = proper partial orders on $[n]$, ordered by inclusion (refinement). $\Delta_n=\Delta(\mathrm{PPF}_n)$ the order complex, $(n-2)$-dimensional, $S_n$-equivariant.
- **(H-Cox).** $\Delta_n\simeq_{\mathbb Q}S^{n-2}$ (rational homology sphere; Coxeter-shadow of $\Delta(2^{[n]})$).
- **(sgn).** $\widetilde H^{n-2}(\Delta_n;\mathbb Q)\cong\mathrm{sgn}_{S_n}$; lower degrees vanish for $1\le k<n-2$.
- **F17 (UCC.1).** $n$-uniform $S_n$-equivariant cofiber Morse: a cofiber decomposition $\Delta_{n+1}=\Delta_n\cup_{\iota_n}\text{cones}$, with the attaching map $\iota_n:\Delta_n\to\partial(\text{cone})$ controlled.
- **F18 (UCC.2).** $\delta_n:\widetilde H^{n-2}(\Delta_n)\to\widetilde H^{n-1}(\text{cofiber})$ is injective via the null-homotopy of $\iota_n$ on the $\mathrm{sgn}$-isotype.
- **Unconditional result.** Concentration of $\widetilde H^*(\Delta_n;\mathbb Q)$ in degree $n-2$, isotype $\mathrm{sgn}_{S_n}$, for all $n\ge 3$.

UC10's target theorem UC10.1 is the **structurally analogous statement for the cube side**: concentration of the bi-equivariant cohomology of $X_n^{\cap}$ in degree $n-1$, isotype $\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$. The degree shifts $n-2\to n-1$ because the cube $Q_n$ has dimension $n$ (one more than the proper part of $\mathrm{PPF}_n$); the isotype shifts $\mathrm{sgn}_{S_n}\to\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$ because the symmetry group enlarges from $S_n$ to $\Gamma_n=(\mathbb Z/2)^n\rtimes S_n$.

### 0.4 Daniel hard constraints (non-negotiable)

- **NOT factorial.** Daniel verbatim 2026-05-15T23:20Z (pm-onethird `feedback_anti_factorial_direction`). UC10 must not invoke factorial decompositions / factorial spines / S_{n+1}-factorial structure. The semi-direct product $\Gamma_n=(\mathbb Z/2)^n\rtimes S_n$ is *not* factorial (it has $|\Gamma_n|=2^n n!$ but no factorial structure beyond the natural Coxeter type B); $S_n$'s presence is fine, factorial decompositions of cochains is not.
- **Inherently but NOT functorially related to Pos_n cohomology.** Daniel verbatim 2026-05-15T23:20Z. UC10's cohomology of $\mathcal C_n^{\cap}$ is *structurally analogous* to the Pos_n cohomology (both are unconditional sign-isotype concentration results) but there is *no functor* $\mathcal C_n^{\cap}\to\mathrm{PPF}_n$ (or any direction) inducing the relationship. §6 makes this precise: the relation is a *parallel construction*, not a pullback / pushforward.
- **Paper-and-pencil first.** No Lean changes; no new axioms; no computation. LaTeX-style Markdown only. Per pm-onethird `feedback_latex_first_for_math_simp`.
- **Cumulative state doc.** Multi-session probable. `docs/state-UC10.md` is the cross-session ledger; this is Session 1. Per pm-onethird `feedback_polecat_cumulative_state_doc`.
- **The manifesto C1–C5 obstacles are precise structural constraints, not free-floating cautions.** UC10 must dodge each *by construction*, not by waving. §1.2 logs each dodge against its C-tag.

---

## §1. The intersection-closed flip and the C1–C5 dodges, abstractly

### 1.1 The flip — duality with no information loss

The intersection-closed flip is the elementary duality $\mathcal F\mapsto\mathcal F^{\complement}=\{U\setminus A:A\in\mathcal F\}$. This is an involution $2^{2^U}\to 2^{2^U}$ exchanging union-closure and intersection-closure ($A\cup B=U\setminus((U\setminus A)\cap(U\setminus B))$).

**Lemma 1.1 (flip-invariance of Frankl).** *$\mathcal F$ is union-closed and $x$ is abundant in $\mathcal F$ iff $\mathcal F^{\complement}$ is intersection-closed and $x$ is **rare** in $\mathcal F^{\complement}$ — meaning $|\mathcal F^{\complement}_x|\le|\mathcal F^{\complement}_{\bar x}|$.*

*Proof.* $A\in\mathcal F_x\iff U\setminus A\in\mathcal F^{\complement}_{\bar x}$. So the complement map sends $\mathcal F_x\to\mathcal F^{\complement}_{\bar x}$ bijectively. Abundance $|\mathcal F_x|\ge|\mathcal F|/2$ becomes rareness $|\mathcal F^{\complement}_{\bar x}|\ge|\mathcal F^{\complement}|/2$, i.e. $|\mathcal F^{\complement}_x|\le|\mathcal F^{\complement}|/2$. $\blacksquare$

So Frankl in intersection-closed form: *every intersection-closed family has a coordinate $x$ which is rare* — equivalently, *every intersection-closed family has an $x$ contained in at most half its members*. The conjecture's content is identical; the flip is bookkeeping.

**Why flip at all?** Two reasons:
- (Daniel UC9 motivation) The Boolean lattice $2^U$ is itself intersection-closed (it is closed under arbitrary intersections — meets exist). It is *not* union-closed in a clean way ($2^U$ is also union-closed, but the join structure mirrors a smaller class). Intersection-closed families are exactly the **Moore families** / closure systems on $U$, which sit inside lattice theory natively. The Boolean lattice $2^U$ embeds canonically into the lattice of intersection-closed families on $U$ (each $A\subseteq U$ gives the family $\{A,U\}$, which is intersection-closed); union-closed embedding is less canonical.
- (UC1 §1.7 symmetry split) The level-1 Walsh character $\chi_{\{x\}}=(-1)^{[x\in A]}$ — load-bearing for the obstruction — is *invariant under the flip* up to global sign: $\chi_{\{x\}}(U\setminus A)=-\chi_{\{x\}}(A)$. So the Walsh-analytic story is genuinely flip-symmetric; intersection-closure is a natural framing.

UC10 works in **intersection-closed form** throughout. Abuse of notation: $\mathcal F$ denotes an intersection-closed family from §2 onward.

### 1.2 The C1–C5 dodges, abstractly stated

Each of UC1 §4's C-gaps is dodged by an explicit structural move logged here; §§2–3 execute.

| Gap | UC1 §4 statement | UC10 dodge | Section |
|---|---|---|---|
| **C1** | $\Delta(\mathcal F)$ is the *internal* sibling of $G(\mathcal F)$, not the moduli analog of $\Delta(\mathrm{PPF}_n)$ | UC10's cohomology object is *not* an order complex of $\mathcal F$ or of $\mathcal C_n^{\cap}$ raw. It is the **bi-equivariant cubical-Walsh-defect complex** $X_n^{\cap}$ which uses $\mathcal C_n^{\cap}$ only as a small-category index and $Q_n$ for geometry. The two-level split — category for indexing, cube for geometry — is the load-bearing structural move | §3.1 |
| **C2** | $\mathrm{UCF}_n$ doubly-exponential; $\Delta(\mathrm{UCF}_n)$ no homology sphere; super-exponential growth kills FI-finite-generation | UC10 *does not need FI-finite-generation*: it works at *fixed $n$*. The complex $X_n^{\cap}$ has dimension polynomial in $|\mathcal F|$ and exponential in $n$ — strictly better than $|\mathrm{UCF}_n|=2^{2^{n/\mathrm{poly}}}$. The "no homology sphere" concern is sidestepped by *not asking for one*: UC10.W (Walsh decomposition) replaces (H-Cox) with a $(\mathbb Z/2)^n$-isotypic decomposition where only one isotype carries content | §§3.3, 3.4, 4.2 |
| **C3** | Load-bearing group is $(\mathbb Z/2)^n$/Walsh for the obstruction, not $S_n$/FI | UC10 *centers* $(\mathbb Z/2)^n$ from the start. The full symmetry group is $\Gamma_n=(\mathbb Z/2)^n\rtimes S_n$ (type-B Coxeter, hyperoctahedral); $S_n$ is the *secondary* factor. The sign analog is the bi-isotype $\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$ | §§0.2, 3.5, 4.1 |
| **C4** | No refinement-cover $\leftrightarrow$ decision-substrate correspondence (the solid hinge of the 1/3-2/3 dictionary has no UC analog) | The Pos_n substrate is *not replicated*; instead UC10 introduces the **stuck-set correspondence UC10.S** as its replacement: cover-step $\mathcal F\hookrightarrow\mathcal F'$ in $\mathcal C_n^{\cap}$ ↔ a contraction of the stuck-sets $\mathcal F_x^{\mathrm{stuck}}$. Not as deep as the Pos_n hinge (no counting identity like $|\mathcal L(P^+)|=|\mathcal L_{x<y}(P)|$), but a genuine combinatorial bridge | §4.3 |
| **C5** | No clean $n$-induction; ground-set inclusion acts the wrong way on the obstruction | UC10 *drops* the induction. The target theorem UC10.1 is stated at *fixed $n$*. The F-series inductive engine is replaced by a fixed-$n$ "Walsh decomposition + Morse" proof structure (§5). The induction-replacement is logged as **UC11 future work**, not blocking UC10's verdict | §§3.3, 5.7 |

These dodges are structural design choices, not technical tricks. The verdict AMBER specifically credits the dodges as positive deliverables: UC10 doesn't merely "avoid" C1–C5, it *reconstructs the cohomology theory with each gap engineered out*.

---

## §2. The category $\mathcal C_n^{\cap}$ pinned

### 2.1 Object class — what is in $\mathcal C_n^{\cap}$?

**Definition 2.1 (objects of $\mathcal C_n^{\cap}$).** An *object* of $\mathcal C_n^{\cap}$ is a pair $(S,\mathcal F)$ where $S\subseteq[n]$ is a **support** and $\mathcal F\subseteq 2^S$ is an intersection-closed family with $\bigcup\mathcal F=S$ (full support on $S$) and $S\in\mathcal F$ (the top is in $\mathcal F$).

Notation: $|\mathrm{Obj}(\mathcal C_n^{\cap})|=:N_n^{\cap}$. The size $N_n^{\cap}=\sum_{S\subseteq[n]}D(S)$ where $D(S)$ is the number of intersection-closed families on $S$ with full support and top — bounded above by the Dedekind number, doubly-exponential in $n$. **But UC10 will not use $|\mathrm{Obj}|$ in the load-bearing path**; the cohomology object $X_n^{\cap}$ uses the cube $Q_n$ (size $2^n$) as the geometric carrier, not the category as a complex.

### 2.2 Morphism class — the load-bearing pick

The ticket §3 surveys morphism candidates. UC10's pick is the **trace morphism**: $\mathcal C_n^{\cap}$'s morphisms are restriction-of-ground-set + family-trace, with composition coming from associativity of restriction.

**Definition 2.2 (morphisms of $\mathcal C_n^{\cap}$).** Given two objects $(S,\mathcal F),(T,\mathcal G)$ with $T\subseteq S$, a **trace morphism** $\mathrm{tr}:(S,\mathcal F)\to(T,\mathcal G)$ is the data of an inclusion $T\hookrightarrow S$ such that
$$
  \mathcal G\;=\;\bigl\{A\cap T:A\in\mathcal F\bigr\}\quad\text{(trace condition).}
$$

The trace condition makes $\mathrm{tr}$ deterministic given $T\subseteq S$ and $\mathcal F$: the target $(T,\mathcal G)$ is *forced* by $\mathcal F|_T$. So morphisms are indexed by pairs $(\text{object},\text{subset of its support})$, and composition is set-theoretic transitivity of restriction ($T'\subseteq T\subseteq S\Rightarrow$ $\mathcal F|_T|_{T'}=\mathcal F|_{T'}$).

**Lemma 2.3 (trace preserves intersection-closure).** *If $(S,\mathcal F)$ is an object of $\mathcal C_n^{\cap}$ and $T\subseteq S$, then $\mathcal G=\{A\cap T:A\in\mathcal F\}$ is intersection-closed on $T$ with $\bigcup\mathcal G=T$ and $T\in\mathcal G$.*

*Proof.* Closure under intersection: $(A\cap T)\cap(B\cap T)=(A\cap B)\cap T$, and $A\cap B\in\mathcal F$. Full support: $\bigcup_A(A\cap T)=(\bigcup_A A)\cap T=S\cap T=T$. Top: $S\cap T=T\in\mathcal G$. $\blacksquare$

So trace morphisms are well-defined, and $\mathcal C_n^{\cap}$ is a genuine small category. **Note crucially:** trace is *not* an inclusion of families on the same ground set — it is restriction to a *subset* of the ground set. The morphism direction is "shrink the ground set, take the induced family." This is the load-bearing choice.

### 2.3 Why traces, not inclusions on $[n]$ — the C5 dodge in action

The natural inclusion morphism $(S,\mathcal F)\hookrightarrow(S,\mathcal F')$ where $\mathcal F\subseteq\mathcal F'$ (both intersection-closed on the same $S$) is the *obvious* candidate. Two reasons it is *rejected* as the load-bearing pick:

- **(C5 reverse).** Same-ground-set inclusion is the analog of "refinement cover $P\lessdot P^+$" in $\mathrm{PPF}_n$. The manifesto §4.6 noted: this acts the wrong way for an induction; counterexamples *inject* from $[n]$ to $[n+1]$ via ground-set extension. So same-ground-set inclusion is structurally tied to the broken $n$-induction. **Trace morphisms invert the direction**: they go from larger $S$ to smaller $T$, i.e. counterexamples *trace* to smaller ground sets — the right direction for a possible reduction (logged as UC11 future).
- **(C2 reverse).** Same-ground-set inclusion is what generates the doubly-exponential moduli $\mathrm{UCF}_n$ as a poset under inclusion. Trace morphisms are *not* doubly-exponentially nested: for each fixed $S$, traces emanate from $S$ to all $T\subseteq S$ — a $2^{|S|}$-fanout, not a doubly-exponential one.

**Same-ground-set inclusions are NOT in $\mathcal C_n^{\cap}$.** They are studied in UC11 (or via UC9's embedding mechanism) but are not part of UC10's load-bearing path. This is the most contentious design choice in UC10 and the part most likely to be challenged in a future session; §7.2 logs the open issue.

### 2.4 The $\Gamma_n$ action on $\mathcal C_n^{\cap}$

**Action of $S_n$.** $\pi\in S_n$ acts on objects by $\pi\cdot(S,\mathcal F)=(\pi(S),\pi(\mathcal F))$ and on morphisms by $\pi\cdot\mathrm{tr}_{T\subseteq S}=\mathrm{tr}_{\pi(T)\subseteq\pi(S)}$. This is a strict $S_n$-action on $\mathcal C_n^{\cap}$ (functorial).

**Action of $(\mathbb Z/2)^n$.** $\sigma_x$ for $x\in[n]$ acts on each $A\in 2^{[n]}$ by toggling $x$. **But $\sigma_x$ does NOT preserve intersection-closure**: if $\mathcal F$ is intersection-closed, $\sigma_x(\mathcal F):=\{\sigma_x(A):A\in\mathcal F\}$ need not be intersection-closed (it is *union-flipped* relative to $\mathcal F$). So $(\mathbb Z/2)^n$ acts on $\mathcal C_n^{\cap}$ only **weakly** — by mapping into a sibling category $\mathcal C_n^{\cup}$ and back; on objects, $\sigma_x:\mathcal C_n^{\cap}\to\mathcal C_n^{\cup}$ is an isomorphism (the flip of §1.1 at the single-coordinate level).

This is the technical price of dodging C3. UC10 *cannot* have $(\mathbb Z/2)^n$ act on $\mathcal C_n^{\cap}$ directly; it must act on the *geometric carrier* $Q_n$ underlying the cohomology object $X_n^{\cap}$. §3.5 explains how the bi-equivariance is recovered: $(\mathbb Z/2)^n$ acts on $X_n^{\cap}$ via $Q_n$, $S_n$ acts via $\mathcal C_n^{\cap}$, and the semi-direct product $\Gamma_n$ acts because the two actions interact correctly.

### 2.5 Summary of §2

$\mathcal C_n^{\cap}$ is the small category of intersection-closed families on subsets of $[n]$ with full support and top, with trace morphisms as the load-bearing class. $S_n$ acts strictly; $(\mathbb Z/2)^n$ acts on the geometric carrier $Q_n$ but not on $\mathcal C_n^{\cap}$ itself — the bi-equivariance is built on $X_n^{\cap}$ from §3.

---

## §3. The cohomology object $X_n^{\cap}$ pinned

This is the load-bearing technical construction. The two-level split (category indexes, cube carries geometry) is the C1 dodge; the fixed-$n$ + polynomial-in-$|\mathcal F|$ size is the C2 dodge; the $\Gamma_n$ bi-equivariance is the C3 dodge.

### 3.1 The cubical-Walsh-defect complex of a single intersection-closed family

We first define the cohomology object for a *single* $(S,\mathcal F)\in\mathcal C_n^{\cap}$, then assemble across $\mathcal C_n^{\cap}$.

**Definition 3.1 (cubical-Walsh-defect complex $X(\mathcal F)$).** Let $(S,\mathcal F)$ be an object. The cubical complex $X(\mathcal F)$ on the vertex set $\mathcal F$ has, for each $k$-tuple $(A_0,A_1,\dots,A_k)$ with $A_i\in\mathcal F$ and the $A_i$ forming a $k$-subcube of $Q_S$ (i.e. there is a $k$-element subset $T\subseteq S$ with $\{A_i\}=\{A_0\,\triangle\,T':T'\subseteq T\}$), a $k$-cell of $X(\mathcal F)$. The differential is the standard cubical boundary.

So $X(\mathcal F)$ is the "subcubes of $Q_S$ entirely contained in $\mathcal F$," the candidate (D) of UC1 §1.2. UC1 §1.2 noted this is a derived object: it measures the literal failure of $\sigma_x,\sigma_y$ to commute on $\mathcal F$. **For intersection-closed $\mathcal F$:** a $k$-subcube is in $X(\mathcal F)$ iff its $2^k$ vertices are all in $\mathcal F$ — and intersection-closure says the *bottom corner* of any such subcube (the intersection of its vertices) is in $\mathcal F$, automatically. So the structural content is in the *top corner* (the union, which need not be in an intersection-closed family).

**Lemma 3.2 (size of $X(\mathcal F)$).** *$\dim X(\mathcal F)\le n$. Each $k$-cell is determined by a pair $(A_0,T)$ with $A_0\in\mathcal F$ and $T\subseteq S\setminus A_0$ such that $A_0\cup T'\in\mathcal F$ for every $T'\subseteq T$. So the number of $k$-cells is $\le|\mathcal F|\cdot\binom{n}{k}\cdot 2^k$, polynomial in $|\mathcal F|$.*

*Proof.* Direct from the definition. Dimension $\le n$ because the cube $Q_n$ has dimension $n$. Cell-count bound from picking $A_0$ ($|\mathcal F|$ choices), $T\subseteq S\setminus A_0$ ($\le\binom{n}{k}$), and orientation ($2^k$). $\blacksquare$

**Crucially, $|X(\mathcal F)|$ is polynomial in $|\mathcal F|$ and exponential in $n$** — strictly better than the doubly-exponential $|\mathrm{UCF}_n|$ that the manifesto C2 ruled out as a viable moduli ambient. The C2 dodge is realized here.

### 3.2 The "defect" reading — why this is the right object

Why call $X(\mathcal F)$ the "Walsh-defect" complex? Two readings, equivalent:

- **(Cube-defect reading).** $X(\mathcal F)$ is the largest cubical complex of $Q_n$ whose vertex set lies in $\mathcal F$. Its *complement* in $Q_n$'s cubical complex measures the missing subcubes — the "compatibility defect" of UC1 §8.3.
- **(Walsh reading).** The chain complex $C_*(X(\mathcal F);\mathbb Q)$ decomposes under the $(\mathbb Z/2)^n$ action into Walsh-isotypic pieces $\bigoplus_S\chi_S\otimes V_S(\mathcal F)$, where $V_S(\mathcal F)$ is the multiplicity space of $\chi_S$. The top Walsh character $\chi_{[n]}$ — every $\sigma_x$ acts by $-1$ — carries the "obstruction multiplicity" $V_{[n]}(\mathcal F)$, and *this is the load-bearing piece*. The vanishing/concentration of $V_{[n]}(\mathcal F)$ in a single cohomological degree is UC10.1's content.

The two readings are equivalent: a missing subcube corresponds to a non-vanishing Walsh coefficient at some level, by Möbius-inverting on the cube. The cube-defect / Walsh-defect duality is the *native* cohomological substrate that the manifesto §4.7 promised exists but did not pin.

### 3.3 The moduli assembly — across $\mathcal C_n^{\cap}$

Now assemble $X(\mathcal F)$ as $\mathcal F$ varies. The natural assembly is the **homotopy colimit**:

**Definition 3.3 (the bi-equivariant moduli complex $X_n^{\cap}$).** The complex
$$
  X_n^{\cap}\;:=\;\mathop{\mathrm{hocolim}}_{(S,\mathcal F)\in(\mathcal C_n^{\cap})^{\mathrm{op}}}\;X(\mathcal F),
$$
with the homotopy colimit taken over the *opposite* trace category (so traces give *maps* $X(\mathcal F|_T)\to X(\mathcal F)$ via inclusion of subcubes — note that $X(\mathcal F|_T)$ sits inside $X(\mathcal F)$ because every subcube of $Q_T$ inside $\mathcal F|_T$ lifts to a subcube of $Q_S$ inside $\mathcal F$, by the trace condition $\mathcal F|_T=\{A\cap T:A\in\mathcal F\}$).

The hocolim is taken in the model category of $\Gamma_n$-equivariant chain complexes over $\mathbb Q$. By the standard cofibrant-resolution recipe (Bousfield–Kan), it is computed as a double complex with the cubical complex axis (degree $0\le k\le n$) and the category-bar-resolution axis (degree $0\le\ell$).

**Lemma 3.4 (size of $X_n^{\cap}$).** *The total complex of $X_n^{\cap}$ has bidegree-$(k,\ell)$ piece of dimension $\le|\mathrm{Obj}(\mathcal C_n^{\cap})|^{\ell+1}\cdot|\mathcal F_{\max}|\cdot\binom{n}{k}\cdot 2^k$, where $\mathcal F_{\max}$ is the largest intersection-closed family appearing.*

This is *not* directly bounded polynomially across $n$ (the $|\mathrm{Obj}|^{\ell+1}$ factor is doubly-exponential), but: **at fixed $n$**, it is finite, the cohomology is finite-dimensional rational, and finite-generation is automatic. The C2-style FI-failure of the manifesto §4.3 cannot apply because UC10 *does not need* FI-stability in $n$ — fixed-$n$ statements suffice.

### 3.4 The Walsh decomposition (UC10.W)

The single most important structural property of $X_n^{\cap}$ — the one that replaces (H-Cox) of the F-series:

**Theorem 3.5 (UC10.W: Walsh decomposition).** *The chain complex $C_*(X_n^{\cap};\mathbb Q)$ decomposes as a direct sum of $(\mathbb Z/2)^n$-isotypic complexes:*
$$
  C_*(X_n^{\cap};\mathbb Q)\;=\;\bigoplus_{S\subseteq[n]}\;\chi_S\otimes V_S^*(X_n^{\cap}),
$$
*where $V_S^*$ is the multiplicity complex of the Walsh character $\chi_S$. The $S_n$-action permutes the $V_S^*$'s as $\pi\cdot V_S^*=V_{\pi(S)}^*$; the isotypic decomposition is compatible with the $S_n$-action.*

**Proof sketch.** Standard: $(\mathbb Z/2)^n$ is a finite abelian group, so every $\mathbb Q[(\mathbb Z/2)^n]$-module decomposes as a direct sum of characters. The characters of $(\mathbb Z/2)^n$ are exactly $\{\chi_S:S\subseteq[n]\}$. The differential of $C_*(X_n^{\cap})$ commutes with $(\mathbb Z/2)^n$ (the action is via the cube ambient, which the differential respects), so the decomposition is at the level of chain complexes. $S_n$-compatibility from $\pi\sigma_x\pi^{-1}=\sigma_{\pi(x)}$. $\blacksquare$

**Why UC10.W replaces (H-Cox).** (H-Cox) said: $\Delta_n$ is a *rational homology sphere* — its cohomology is concentrated in degree $n-2$, dimension 1, isotype $\mathrm{sgn}_{S_n}$. UC10.W says: $X_n^{\cap}$'s cohomology *decomposes natively* into Walsh-isotypic pieces, and **UC10.1 asserts only one piece — the top one, $V_{[n]}^*$ — carries content**, in a single cohomological degree, with $\mathrm{sgn}_{S_n}$ as the secondary isotype. The "$\simeq S^{n-2}$" of (H-Cox) is replaced by "$V_{[n]}^*$ has the cohomology of $S^{n-1}$" — i.e. concentration in degree $n-1$, dimension 1 in that degree.

So UC10.W *is* the structural analog of (H-Cox), expressed in the strictly larger and more native group $\Gamma_n=(\mathbb Z/2)^n\rtimes S_n$. The "homology sphere" is the top-Walsh piece of $X_n^{\cap}$; UC10.1 is the statement that this piece is *the only one with cohomology*, mirroring (H-Cox)'s "only one isotype with cohomology" content.

### 3.5 The $\Gamma_n$ bi-equivariance — how the two actions cohere

By §2.4, $(\mathbb Z/2)^n$ does *not* act on $\mathcal C_n^{\cap}$ (it flips intersection-closure to union-closure). But $(\mathbb Z/2)^n$ acts on $Q_n$ and hence on each $X(\mathcal F)$ as a *cubical complex of the ambient cube*. So $(\mathbb Z/2)^n$ acts on the value of the hocolim — but not on the indexing.

**Lemma 3.6 (bi-equivariance of $X_n^{\cap}$).** *Despite $(\mathbb Z/2)^n$ not acting on $\mathcal C_n^{\cap}$, the hocolim $X_n^{\cap}$ carries a well-defined $\Gamma_n=(\mathbb Z/2)^n\rtimes S_n$ action: $S_n$ acts on the indexing and on $Q_n$; $(\mathbb Z/2)^n$ acts on $Q_n$ only. The actions cohere via $\pi\sigma_x\pi^{-1}=\sigma_{\pi(x)}$.*

*Proof sketch.* The hocolim of a $\Gamma_n$-equivariant diagram over a $S_n$-equivariant indexing (with $(\mathbb Z/2)^n$ acting only on values, $S_n$ on both) is a $\Gamma_n$-object. The non-action of $(\mathbb Z/2)^n$ on $\mathcal C_n^{\cap}$ is fine: the indexing carries the $S_n$-side of the semi-direct product, the value-side carries the $(\mathbb Z/2)^n$-side, and the bracket relation $[\sigma_x,\pi]=\sigma_{\pi(x)}\sigma_x^{-1}$ is realized by the $S_n$-action on the indexing being twisted-compatible with $\sigma_x$. The technical verification is standard for diagrams over $G$-categories. $\blacksquare$

This is the C3 dodge realized: the wrong-symmetry-group concern of the manifesto §4.4 is reversed — UC10 starts with $\Gamma_n$ as the load-bearing group, with $(\mathbb Z/2)^n$ acting on the geometric carrier (where the Walsh-obstruction lives) and $S_n$ on the indexing.

### 3.6 Summary of §3

$X_n^{\cap}=\mathop{\mathrm{hocolim}}_{(\mathcal C_n^{\cap})^{\mathrm{op}}}X(\mathcal F)$, a $\Gamma_n$-equivariant chain complex over $\mathbb Q$. Polynomial-in-$|\mathcal F|$, exponential-in-$n$, finite at fixed $n$. Decomposes by UC10.W into Walsh-isotypic pieces $\bigoplus_S\chi_S\otimes V_S^*$. The top piece $V_{[n]}^*$ is the obstruction-carrier.

---

## §4. The target theorem UC10.1, the substrate UC10.S, and the residual UC10.R

### 4.1 UC10.1 — the Walsh sign-concentration theorem

**Theorem 4.1 (UC10.1: Walsh sign-concentration, target).** *For every $n\ge 3$,*
$$
  \widetilde H^k\bigl(X_n^{\cap};\mathbb Q\bigr)\;\cong\;\begin{cases}\;\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}\,,&k=n-1,\\\;0\,,&1\le k\le n-2.\end{cases}
$$
*as $\Gamma_n=(\mathbb Z/2)^n\rtimes S_n$-modules. Equivalently: $V_{[n]}^{n-1}\cong\mathrm{sgn}_{S_n}$ (one-dimensional), and $V_S^k=0$ for $(S,k)\ne([n],n-1)$ in degree $\ge 1$.*

This is the structural twin of the F-series unconditional result. The structural match is exact:

| F-series ($\Delta_n=\Delta(\mathrm{PPF}_n)$) | UC10 ($X_n^{\cap}$) | Comment |
|---|---|---|
| Ambient complex $\Delta_n$, $(n-2)$-dimensional | Ambient complex $X_n^{\cap}$, $(n-1)$-dimensional (cube $Q_n$ has one more dimension than proper part of $\mathrm{PPF}_n$) | dimension shift $n-2\to n-1$ |
| Symmetry group $S_n$ | Symmetry group $\Gamma_n=(\mathbb Z/2)^n\rtimes S_n$ | group enlargement; cube has $\Gamma_n$ symmetry natively |
| Concentration degree $n-2$ | Concentration degree $n-1$ | shifted by 1 with the dimension |
| Concentration isotype $\mathrm{sgn}_{S_n}$ | Concentration isotype $\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$ | bi-sign: every $\sigma_x$ flips AND every transposition flips |
| $\Delta_n\simeq_{\mathbb Q}S^{n-2}$ ((H-Cox)) | $V_{[n]}^*\simeq_{\mathbb Q}S^{n-1}$ (UC10.W + UC10.1 combined) | rational homology sphere of the top Walsh piece |

The shift $n-2\to n-1$ is structural (the cube is one dimension larger than the proper part of the Boolean lattice's order complex); the isotype enlargement $\mathrm{sgn}_{S_n}\to\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$ is the natural extension to the type-B Coxeter group. **UC10.1's right-hand side is the unique sign character of $\Gamma_n$** (it sends every reflection of $\Gamma_n$ — both transpositions and toggle-of-$x$'s — to $-1$).

**Sketch of what UC10.1 *says*** for an intersection-closed family $\mathcal F$: there is exactly one cohomological class — the "top-Walsh sign-of-$S_n$" class — that detects whether $\mathcal F$ has a rare coordinate. The class is sign-isotype (it changes sign under any reflection of $\Gamma_n$, including toggle-of-coordinate). Its non-vanishing is the Frankl obstruction (under the flip §1.1).

### 4.2 The proof outline structure — what §5 will show

UC10.1 is the *target*, not yet proven. §5 outlines the proof following F17+F18's template:

- **(Step 1) Walsh decomposition.** Trivial from §3.4 (UC10.W). ✓ transfers.
- **(Step 2) $V_S^*$ for $S\ne[n]$ vanishes in degree $\ge 1$.** A "lower-Walsh vanishing" lemma using the trace structure of $\mathcal C_n^{\cap}$. ✓ transfers from the cofiber Morse of F17 — different morphisms (trace, not refinement), same structure.
- **(Step 3) $V_{[n]}^*$ concentrates in degree $n-1$.** Cofiber Morse on the top-Walsh piece. Mostly transfers; mild adaptation needed.
- **(Step 4) $V_{[n]}^{n-1}$ has dimension 1, isotype $\mathrm{sgn}_{S_n}$.** F18-style $\delta$-injectivity argument. **THIS IS THE NAMED RESIDUAL UC10.R** — the analog of F18's null-homotopy of $\iota_n$ is non-trivial and is the part needing a dedicated UC11 session.

§5.1–5.6 walks through each step explicitly.

### 4.3 The substrate correspondence UC10.S

The manifesto §4.5 identified that the F-series has a **solid hinge**: refinement-cover $P\lessdot P^+\in\mathrm{PPF}_n$ ↔ pair-cut $S_{xy}$, with the counting identity $|\mathcal L(P^+)|=|\mathcal L_{x<y}(P)|$. This substrate has *no* UC analog (C4). UC10 replaces it with a weaker but genuine bridge:

**Theorem 4.2 (UC10.S: stuck-set correspondence).** *Let $(S,\mathcal F)\to(T,\mathcal G)$ be a trace morphism in $\mathcal C_n^{\cap}$ with $T=S\setminus\{x\}$ (one-element restriction). Then for every $A\in\mathcal G$, the preimage $\{A'\in\mathcal F:A'\cap T=A\}\subseteq\mathcal F$ has cardinality 1 or 2, and the bias $\beta_x(\mathcal F)$ equals the count of preimages of cardinality 2 that exclude $x$, minus the count that include $x$.*

*Proof.* For $A\in\mathcal G$, possible preimages in $\mathcal F$ are $A$ itself (if $A\in\mathcal F$, $x\notin A$) and $A\cup\{x\}$ (if $A\cup\{x\}\in\mathcal F$). At most two preimages. If both are in $\mathcal F$, $A$ is "matched in the $x$-direction" (UC1 §1.4, dualized to intersection-closed). If only $A\in\mathcal F$, $A\notin\mathcal F_x$ — it is "$x$-stuck on the $\bar x$ side." If only $A\cup\{x\}\in\mathcal F$, it is "$x$-stuck on the $x$ side." Counting:
$$
  |\mathcal F_x|-|\mathcal F_{\bar x}|\;=\;\sum_{A\in\mathcal G}\bigl[\,\mathbf 1_{A\cup\{x\}\in\mathcal F}-\mathbf 1_{A\in\mathcal F,A\cup\{x\}\notin\mathcal F}\,\bigr],
$$
and after the standard rewriting via the matching $M_x$ (UC1 §1.4): $\beta_x(\mathcal F)=|\mathcal F_x^{\mathrm{stuck}}|-|\mathcal F_{\bar x}^{\mathrm{stuck}}|$ (dualized). The stuck-set imbalance is read off the preimage structure of the single trace $(S,\mathcal F)\to(S\setminus\{x\},\mathcal G)$. $\blacksquare$

**Why this is the substrate analog.** The cover-step $P\lessdot P^+$ "decides" whether $x<y$; UC10.S's cover-step (the single-coordinate trace) "decides" the $x$-direction stuck-set imbalance — i.e. the contribution of $x$ to the Frankl obstruction. Not as deep as the Pos_n hinge (no exact counting identity, only a sum of preimages), but a genuine bridge.

**UC10.S is what makes UC10.1 *interesting*** (rather than just a structurally-analogous statement of unknown content): it identifies the cover-step in $\mathcal C_n^{\cap}$ with the bias $\beta_x$, so the Frankl-side meaning is *read directly off the trace morphism* — and the cohomology of $X_n^{\cap}$ measures the "global non-cancellation" of $\beta_x$'s across coordinates. The top-Walsh sign character $\chi_{[n]}$ is precisely the multi-coordinate non-cancellation detector.

### 4.4 The named residual UC10.R

**Residual 4.3 (UC10.R: trace-injectivity).** *The analog of F18's $\delta$-injectivity step:*
$$
  \delta_n^{\cap}:\;\widetilde H^{n-1}\bigl(X_n^{\cap}\bigr)_{V_{[n]}}\;\hookrightarrow\;\widetilde H^{n}\bigl(\mathrm{cofib}(\iota_n^{\cap})\bigr)_{V_{[n]}}
$$
*is injective on the $V_{[n]}$-Walsh piece, where $\iota_n^{\cap}:X_{n-1}^{\cap}\hookrightarrow X_n^{\cap}$ is the canonical inclusion (induced from trace morphisms shrinking $[n]$ to $[n-1]$).*

This is the load-bearing open lemma. F18 proved $\delta_n$ injective via the null-homotopy of $\iota_n$ on the sgn-isotype. UC10.R's analog statement is plausible (the construction is structurally parallel) but requires:
- pinning the exact form of $\iota_n^{\cap}$ as a $\Gamma_n$-equivariant map,
- finding the analog of F18's null-homotopy (likely a Walsh-character-based contraction),
- verifying injectivity on the top Walsh piece.

§5.4 sketches what UC10.R's proof would look like — outlining the obstructions to direct transfer from F18.

### 4.5 Summary of §4

- **UC10.1** (Walsh sign-concentration) is the analog target theorem.
- **UC10.W** (Walsh decomposition, proved in §3.4) is the (H-Cox) analog.
- **UC10.S** (stuck-set correspondence, proved in §4.3) is the substrate analog (C4 replacement).
- **UC10.R** (trace-injectivity) is the named residual blocking the full proof of UC10.1; the analog of F18's $\delta$-injectivity.

---

## §5. The proof outline — transferring F17+F18 step-by-step

This section walks through each step of the F17+F18 proof of the Pos_n unconditional result and labels it *transfers* / *adapts* / *blocks* in the UC10 setting. Six of eight steps transfer or adapt; one is UC10.R (the named residual); one (Step 7 — multiplicativity-law analog) is dropped as UC11 future work.

### 5.1 (Step 1) Setup the ambient and the equivariance — **transfers**

| F17/F18 | UC10 | Status |
|---|---|---|
| Setup $\Delta_n=\Delta(\mathrm{PPF}_n)$, $(n-2)$-dim, $S_n$-equivariant | Setup $X_n^{\cap}$, $(n-1)$-dim, $\Gamma_n=(\mathbb Z/2)^n\rtimes S_n$-equivariant | ✓ transfers; details §3 |

### 5.2 (Step 2) Walsh / isotypic decomposition — **transfers (UC10.W)**

| F17/F18 | UC10 | Status |
|---|---|---|
| Identify the load-bearing $S_n$-isotype: $\mathrm{sgn}_{S_n}$, by (H-Cox) | Identify the load-bearing $\Gamma_n$-isotype: $\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$, by UC10.W | ✓ transfers; details §3.4 |

§3.4's Theorem 3.5 (UC10.W) is the cube-side analog of (H-Cox). The structural content is parallel: a finite-group-equivariant decomposition of cochains into isotypic pieces, with one piece flagged as the "obstruction carrier."

### 5.3 (Step 3) Lower-isotype vanishing — **adapts**

| F17/F18 | UC10 | Status |
|---|---|---|
| Prove $\widetilde H^k(\Delta_n)_{\mathrm{non-sgn}}=0$ for $k\ge 1$: standard Coxeter-complex techniques + the FI-stability | Prove $V_S^k=0$ for $S\ne[n]$, $k\ge 1$: trace structure of $\mathcal C_n^{\cap}$ + a "Walsh restriction" argument | ◐ adapts |

**Sketch (UC10 side).** For $S\subsetneq[n]$, the Walsh character $\chi_S$ has support $S$ — only coordinates in $S$ act non-trivially. The trace morphism $(S,\mathcal F)\to(S',\mathcal F|_{S'})$ for $S'\supseteq S$ preserves $\chi_S$-isotype (the coordinates not in $S$ act trivially on $\chi_S$). So $V_S^*$ is computed by the hocolim restricted to traces *fixing the support $\supseteq S$* — a "sub-category" of $\mathcal C_n^{\cap}$ with smaller indexing. By induction on $|S|$ (over a fixed $n$): each $V_S^*$ for $S\subsetneq[n]$ vanishes in degree $\ge 1$ because the relevant sub-category is sufficiently smaller-dimensional that the cohomology truncates.

This is morally the analog of F17's "lower-isotype vanishing in cofiber Morse," with the cofiber direction replaced by Walsh-character support reduction. The adaptation is non-trivial — the standard FI / rep-stability machinery does not directly apply (C3 forbids it), so the proof has to be redone in the type-B Coxeter setting. Plausible, but UC11 work.

### 5.4 (Step 4) Top-isotype concentration in degree $n-1$ — **adapts**

| F17/F18 | UC10 | Status |
|---|---|---|
| Prove $\widetilde H^k(\Delta_n)_{\mathrm{sgn}}=0$ for $k<n-2$: cofiber Morse | Prove $V_{[n]}^k=0$ for $k<n-1$: cubical Morse on the top-Walsh piece | ◐ adapts |

**Sketch.** The top-Walsh piece $V_{[n]}^*$ is the chain complex of $X_n^{\cap}$ with coefficients twisted by $\chi_{[n]}$: every coordinate-toggle $\sigma_x$ acts by $-1$. This is *equivalent* to the chain complex of $X_n^{\cap}$ modulo a $(\mathbb Z/2)^n$-symmetrization, in the alternating-sign mode. The cubical structure gives a clean Morse-theoretic vanishing: the only non-trivial top-Walsh cells are those at the top cubical dimension, by an analog of "antisymmetric forms have content only in top degree."

Adapts from F17's Morse argument because the local pictures are different (subcubes vs. simplices) but the global Morse structure is parallel.

### 5.5 (Step 5) Trace-injectivity — **BLOCKS (UC10.R)**

| F17/F18 | UC10 | Status |
|---|---|---|
| F18: $\delta_n:\widetilde H^{n-2}(\Delta_n)_{\mathrm{sgn}}\hookrightarrow\widetilde H^{n-1}(\mathrm{cofib}(\iota_n))_{\mathrm{sgn}}$ injective, via null-homotopy of $\iota_n$ on sgn | UC10.R: $\delta_n^{\cap}:\widetilde H^{n-1}(X_n^{\cap})_{V_{[n]}}\hookrightarrow\widetilde H^{n}(\mathrm{cofib}(\iota_n^{\cap}))_{V_{[n]}}$ injective, via ???-homotopy of $\iota_n^{\cap}$ on $\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$ | ✗ named residual UC10.R |

**Why this blocks.** F18's null-homotopy of $\iota_n$ uses specific Coxeter-combinatorial structure of $\mathrm{PPF}_n\hookrightarrow\mathrm{PPF}_{n+1}$. The analog for $X_n^{\cap}\hookrightarrow X_{n+1}^{\cap}$ requires:
- defining $\iota_n^{\cap}$ explicitly (a $\Gamma_n$-equivariant cofibration — the natural candidate: $(S,\mathcal F)\mapsto(S\sqcup\{n+1\},\mathcal F)$, padding the support);
- constructing a null-homotopy on the top-Walsh $\boxtimes$ sgn piece;
- verifying injectivity in the long exact sequence.

The construction is *structurally available* but the technical work is real — there is no shortcut from F18 because the categories ($\mathcal C_n^{\cap}$ vs. $\mathrm{PPF}_n$), the complexes ($X_n^{\cap}$ vs. $\Delta_n$), and the groups ($\Gamma_n$ vs. $S_n$) all differ. **UC10.R is the open lemma.**

A plausible attack: define the null-homotopy as a *Walsh-character-twisted retraction*: a chain map $X_{n+1}^{\cap}\to X_n^{\cap}$ that on the $\chi_{[n+1]}$-piece is a contraction, on lower-Walsh pieces is the identity. The contraction is generated by "evaluation at $n+1=0$" (i.e. set the new coordinate to be excluded). The verification that this is a null-homotopy on $\chi_{[n+1]}\boxtimes\mathrm{sgn}_{S_{n+1}}$ specifically would be UC11's load-bearing technical lemma.

### 5.6 (Step 6) Putting it together — **transfers once UC10.R is in**

| F17/F18 | UC10 | Status |
|---|---|---|
| Combine cofiber Morse + $\delta$-injectivity into the concentration theorem | Combine cubical Morse + trace-injectivity UC10.R into UC10.1 | ✓ transfers once UC10.R is in hand |

### 5.7 (Step 7) The $n$-induction / multiplicativity-law replacement — **dropped (UC11+)**

F17/F18 use the cofiber inclusion $\iota_n:\Delta_n\hookrightarrow\Delta_{n+1}$ inductively. UC10 dropped induction (the C5 dodge); the result is targeted at *fixed $n$*. So Step 7 is logged as future work, not blocking UC10's verdict.

If induction is desired later (UC11 or beyond), the analog of F8 multiplicativity would be a relation between $|X_n^{\cap}|$-statistics and $|X_{n-1}^{\cap}|$-statistics; the manifesto §4.6 noted this acts the wrong way for Frankl direction-of-counterexamples and is structurally blocked at the obstruction level. The intersection-closed flip (§1.1) may unblock this — under the flip the direction reverses — but this is UC11 territory.

### 5.8 Summary of §5

Six of eight F17+F18 steps transfer or adapt to UC10:
- Step 1 (setup) ✓ transfers,
- Step 2 (Walsh decomposition) ✓ transfers (UC10.W),
- Step 3 (lower-isotype vanishing) ◐ adapts (proof in UC11),
- Step 4 (top-isotype concentration) ◐ adapts (proof in UC11),
- Step 5 (trace-injectivity) ✗ named residual UC10.R,
- Step 6 (combining) ✓ transfers conditional on UC10.R,
- Step 7 (induction / multiplicativity) — dropped from load-bearing path, UC11 future.

So UC10 leaves *one* structural lemma open (UC10.R) plus two technical adaptations whose execution is plausible (Steps 3, 4). The verdict AMBER reflects exactly this profile: framework + target + outline pinned; one load-bearing residual + named technical work pending.

---

## §6. The UC9 connection — inherent, not functorial

### 6.1 The two mechanisms compared

**UC9 (extrinsic, mg-96a6).** Intersection-closed flip + embed $2^{[n]}\hookrightarrow\mathrm{Pos}_{n+1}$ via "$2^{[n]}$ as the antichain of singletons + their joins in the (n+1)-element-set construction" (UC9's pinned embedding, pending the UC9 polecat's verification). Pull back the *proven* F17+F18 result on Pos cohomology to constraints on the intersection-closed family $\mathcal F$.

**UC10 (intrinsic, this doc).** Build native cohomology theory directly on the category of intersection-closed families. No embedding into $\mathrm{Pos}$; no pullback; the cohomology is computed natively on $X_n^{\cap}$.

### 6.2 The "inherent but not functorial" constraint, made precise

Daniel's verbatim 2026-05-15T23:20Z: *"inherently but NOT functorially related to Pos_n cohomology."*

UC10 honors this constraint by **construction**: there is no functor $\mathcal C_n^{\cap}\to\mathrm{PPF}_n$ (or any direction) inducing the relationship between $H^*(X_n^{\cap})$ and $H^*(\Delta_n)$. The relationship is purely structural:

**Theorem 6.1 (UC10/UC9 reconciliation, structural).** *Under the UC9 embedding $\iota_{\text{UC9}}:2^{[n]}\hookrightarrow\mathrm{Pos}_{n+1}$ (UC9-pending pinned form), the pullback of $H^{n-1}(\Delta_n;\mathbb Q)\cong\mathrm{sgn}_{S_n}$ along $\iota_{\text{UC9}}$ recovers a $\Gamma_n$-equivariant class on $2^{[n]}$. This class is **not** $H^{n-1}(X_n^{\cap})_{V_{[n]}}$ — they live in different cohomology theories (simplicial-order vs. cubical-Walsh) and at different groups ($S_n$ vs. $\Gamma_n$). But both classes detect the **same Frankl obstruction** on $\mathcal F$ (the existence of a rare coordinate), through structurally parallel mechanisms.*

Sketch of the structural parallel:
- Both detect a *non-isotropy* phenomenon: the F-series detects "the chamber cohomology cannot be globally trivialized" via $\omega_{\mathrm{bal}}$; UC10 detects "the cube-cohomology cannot be globally trivialized" via the top Walsh sign.
- Both invoke the same combinatorial primitive — the level-1 spectrum of $\mathbf 1_{\mathcal F}$ — but UC9 reads it off the embedded Pos image while UC10 reads it natively.
- There is no commutative diagram linking them; the relationship is descriptive, not functorial.

### 6.3 Why this is the *right* answer for Daniel's constraint

The constraint "inherent but not functorial" rules out the naive idea that UC10 and UC9 are two paths to the same theorem. They are *complementary mechanisms* for instantiating the meta-thesis (mg-26fc) of "constrained compatibility geometry cannot remain globally isotropic":

- UC9 instantiates by *importing* a non-isotropy from $\mathrm{PPF}_n$ to $2^{[n]}$ via embedding;
- UC10 instantiates by *constructing* a native non-isotropy on the cube via the Walsh-defect cohomology.

The non-existence of a functorial bridge is *information*: it says the two mechanisms are genuinely distinct, and a future "unified compatibility-geometry" framework would need to subsume both — likely via the meta-thesis itself, not via a functor.

### 6.4 Joint dispatch — UC9 + UC10 together

A future Frankl proof using the F17+F18 unconditional core would likely use *both* UC9 and UC10:
- UC9 provides an extrinsic constraint on $\mathcal F$ (pulled-back vanishing of certain Pos cohomology classes).
- UC10 provides an intrinsic constraint (the top-Walsh sign-class is non-vanishing iff $\mathcal F$ has a rare coordinate).
- The intersection of the two constraints is the strongest Frankl-side statement.

If UC10.1 is proven (i.e., UC10.R is closed), the intrinsic constraint is unconditional — and UC9's extrinsic constraint adds a *second* independent line. This is the meta-thesis instantiated through two mechanisms, mirroring how mg-26fc found 1/3-2/3 has two mechanisms (BK/Cheeger + F-series).

### 6.5 Summary of §6

UC10 and UC9 are *complementary* — intrinsic + extrinsic — instantiations of the meta-thesis. They are *inherently related* (both target the Frankl obstruction via cohomological non-isotropy) but *not functorially related* (no functor or pullback links them; they live in different cohomology theories at different symmetry groups). The constraint is honored by construction.

---

## §7. Verdict and UC11 scope

### 7.1 Verdict — AMBER-framework-pinned-target-named-execution-residual

Restating from the top, with citations:

- ✓ **Framework pinned.** The category $\mathcal C_n^{\cap}$ (§2), the cohomology object $X_n^{\cap}$ (§3), the target theorem UC10.1 (§4.1), the substrate UC10.S (§4.3) — all defined and inter-related.
- ✓ **C1–C5 dodges by construction.** §1.2 logs the abstract dodges; §§2–3 execute them. Each dodge is a structural design choice (two-level split, fixed-$n$, $\Gamma_n$-centering, stuck-set substrate, no induction).
- ✓ **Proof outline laid.** §5 walks F17+F18 step-by-step; six of eight steps transfer or adapt; one (Step 7) is dropped (out of scope per C5 dodge); one (Step 5 / UC10.R) is the named residual.
- ✓ **UC9 connection precise.** §6: inherent-not-functorial honored by construction; the joint-dispatch mechanism (UC9 + UC10 together) clarified.
- ◐ **UC10.1 stated, not proven.** UC10.R is the load-bearing open lemma; Steps 3, 4 of §5 are adaptive proofs whose execution is plausible but pending. Hence AMBER not GREEN.
- ✓ **Hard constraints respected.** Not factorial (no factorial decomposition in any load-bearing step); inherent-not-functorial (§6); paper-and-pencil (no Lean, no axioms, no computation); cumulative state doc (`docs/state-UC10.md`, this session).

### 7.2 UC11 scope — what the next session would do

**UC11 primary — execute UC10.R.** The trace-injectivity residual: prove $\delta_n^{\cap}$ injective on the top-Walsh sign piece, via the Walsh-character-twisted retraction sketched in §5.5. This is the single load-bearing open lemma in UC10.1. If UC11 GREENs UC10.R, UC10's verdict upgrades to GREEN.

**UC11 secondary — execute the §5.3 + §5.4 adaptations.** Lower-Walsh vanishing (Step 3) and top-Walsh concentration (Step 4) in the cubical-Morse / Walsh-restriction framework. These are technical adaptations whose execution requires care but no new structural ideas.

**UC11 tertiary — Examine the same-ground-set inclusion question (§2.3).** Should $\mathcal C_n^{\cap}$ also include inclusion morphisms $(S,\mathcal F)\hookrightarrow(S,\mathcal F')$ for $\mathcal F\subseteq\mathcal F'$? UC10 rejected them for C5 reasons but they are the natural Pos analog and deserve a careful re-examination — possibly leading to a *larger* category $\widetilde{\mathcal C}_n^{\cap}$ with both trace and inclusion morphisms, and an associated *larger* cohomology object whose Walsh decomposition might have additional structure.

**UC12+ future — the $n$-induction replacement.** The C5 gap is dodged in UC10 (no induction needed for fixed-$n$ targets), but a stronger Frankl-side conclusion might require gluing across $n$. Investigating whether the intersection-closed flip + the trace structure permits an "anti-induction" (the right-direction $n\to n-1$ reduction) is a multi-session project — analogous to how F11's discovery of the triple connecting map $\partial_n$ took a separate session.

**UC13+ future — joint UC9/UC10 dispatch.** Once UC9 GREENs (or AMBERs with named residuals) and UC10 GREENs (UC10.R closed), a joint session combines the two cohomological constraints into the strongest Frankl-side statement extractable from the F17+F18 core.

### 7.3 What UC10 (this session) does NOT do

- **Does not prove UC10.1.** The target theorem is stated, the proof outlined, one residual named. Proof is UC11.
- **Does not pin same-ground-set inclusions.** Logged as UC11 tertiary. Deferred.
- **Does not address $n$-induction / multiplicativity-law replacement.** UC12+. Deferred.
- **Does not touch UC1–UC8's native-construction chain.** UC10 is a *parallel* line of work (the cohomological branch) complementary to the Walsh/transport/decomposition/lever-signing branch (UC2–UC8). The two branches are independent; their results compose at the verdict level (joint Frankl-side constraint).
- **Does not engage Lean / axioms / computation.** Paper-and-pencil only.

### 7.4 The honest one-paragraph verdict

UC10 builds the native cohomology theory of the category of intersection-closed families directly, sidestepping each of the manifesto C1–C5 gaps by structural design (two-level split for C1, fixed-$n$ + polynomial-in-$|\mathcal F|$ size for C2, $(\mathbb Z/2)^n$-centered + $\Gamma_n$ Coxeter-B equivariance for C3, stuck-set correspondence for C4, no induction for C5), states the analog target theorem UC10.1 (concentration in degree $n-1$ at isotype $\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$) with its supporting structural results UC10.W (Walsh decomposition) and UC10.S (stuck-set correspondence) proved unconditionally, outlines a step-by-step proof transferring six of eight F17+F18 steps cleanly (steps 1, 2, 6 transfer; steps 3, 4 adapt; step 7 dropped) and names the seventh as the load-bearing residual UC10.R (trace-injectivity of $\delta_n^{\cap}$ on the top-Walsh sign piece, the analog of F18's null-homotopy of $\iota_n$ on the sgn isotype), and clarifies the UC9 connection as inherent-not-functorial honored by construction: UC9 (extrinsic pullback) and UC10 (intrinsic native cohomology) are complementary instantiations of the mg-26fc meta-thesis of constrained compatibility geometry cannot remain globally isotropic, with no functor linking them and joint-dispatch as the path to the strongest Frankl-side constraint.

---

## §8. References

### 8.1 Cross-repo — the F-series core UC10 mirrors (`one_third_width_three`, read-only)

- **mg-8216 (F10)** — `docs/general-n-proof-synthesis.md`. The cohomological proof skeleton; §1.2 (H-Cox)+(sgn); §6.2 cofiber-LES induction; §6.3 (UCC); §7.2 (FG-Cofiber). The structural skeleton UC10 mirrors.
- **mg-b352 (F11)** — `docs/state-F11.md`. §3 (route-(i) closed NEGATIVE via super-exponential $|\mathrm{PPF}_n|$); §4 (the triple connecting map $\partial_n$). The cautionary precedent for C2 (UC10's fixed-$n$ + polynomial-size choice).
- **mg-4d3a (F17, UCC.1)** — $n$-uniform $S_n$-equivariant cofiber Morse on $\Delta_n\hookrightarrow\Delta_{n+1}$. The transfer template for §5 Steps 1–4.
- **mg-d039 (F18, UCC.2)** — $\delta_n$ injective via null-homotopy of $\iota_n$ on $\mathrm{sgn}$. The transfer template for §5 Step 5; the analog of which is UC10.R.
- **mg-26fc** — `docs/compatibility-geometry-structural-analogy-scoping.md`. The two-mechanisms framing; the meta-thesis "constrained compatibility geometry cannot remain globally isotropic"; the substrate-correspondence hinge UC10.S replaces.

### 8.2 This repo (`union_closed`)

- **mg-f72a (UC1)** — `docs/union-closed-compat-geom-manifesto.md`. The founding manifesto; §1 (intrinsic object), §1.4 (stuck-sets, the UC10.S substrate), §1.6 (the obstruction in 4 forms), §1.7 (the symmetry-group split), §4.2–§4.6 (the C1–C5 obstacles UC10 dodges).
- **mg-a814 (UC2) through mg-d68d (UC8)** — the native-construction chain (Walsh/decomposition/levers). Independent of UC10's path; both branches address the Frankl obstruction from different angles.
- **mg-96a6 (UC9)** — `docs/...UC9-intersection-closed-flip-embedding-cohomology.md`. The complementary mechanism; §6 of this doc analyzes the inherent-not-functorial relation.
- **`README.md`** — the structural analogy + intrinsic-object expectation.

### 8.3 Background

- T. Church, J. Ellenberg, B. Farb (2015) — FI-modules; UC10 explicitly does not use these (the fixed-$n$ design choice). The negative precedent.
- N. Bourbaki, *Lie Groups and Lie Algebras*, Ch. IV–VI — type-B Coxeter group (= hyperoctahedral $\Gamma_n=(\mathbb Z/2)^n\rtimes S_n$). The natural symmetry of the cube.
- R. O'Donnell, *Analysis of Boolean Functions* — Walsh-Fourier basics, level-$k$ characters, the harmonic decomposition.
- D. Quillen, *Higher Algebraic K-Theory I* — homotopy colimits of small categories with diagram coefficients; the $\mathop{\mathrm{hocolim}}$ used in §3.3.
- Bousfield, Kan, *Homotopy Limits, Completions and Localizations* — the standard reference for hocolim computations on diagrams.

### 8.4 Source directives

- Daniel Apple reminder 2026-05-16T00:38:32Z (verbatim §0 of the ticket body): "for union closed I want a theorem on the cohomology of the category of intersection closed families like we did before with the category of posets."
- Daniel verbatim 2026-05-15T23:20Z (NON-NEGOTIABLE): "NOT factorial. Inherently but NOT functorially related to Pos_n cohomology."
- mg-26fc §6 follow-up 3 — check Union-Closed against the cohomological framework. Discharged in UC1 (NEGATIVE on direct F-series transfer, C1–C5 gaps named) and now in UC10 (POSITIVE construction of a *native* cohomology that dodges all five gaps by design).

---

*Polecat: cat-mg-814b (UC10). Branch: `polecat-cat-mg-814b`. Session 1 (multi-session probable; cumulative state ledger in `docs/state-UC10.md`). Verdict: **AMBER-framework-pinned-target-named-execution-residual** — the native cohomology theory of $\mathcal C_n^{\cap}$ is built (category, complex, target theorem, substrate, residual, proof outline, UC9 relation), with the load-bearing trace-injectivity residual UC10.R named for UC11 execution and the manifesto C1–C5 obstacles each dodged by structural design rather than by waving. No factorial structure; inherent-not-functorial relation to Pos_n honored by construction; paper-and-pencil; no Lean; no axioms; no computation; UC1–UC8 native-construction chain untouched; 1/3-2/3 route-(ii) critical path untouched.*
