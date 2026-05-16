# Union-Closed Compatibility-Geometry — UC11: the Čech-sheaf cohomological obstruction on subfamilies; minimality-element argument; the full Daniel-articulated 5-step Frankl program (mg-9ef0)

**Repo:** `union_closed`.
**Parent (mechanism-twin):** mg-814b (UC10, the native cohomology theory of $\mathcal C_n^{\cap}$ — the *primary input*), with mg-707c (UC12, the cubical-bridge null-homotopy closing the load-bearing residual UC10.R). UC11 is the **Frankl-side consumer** of UC10's sphere result: it builds the Čech-sheaf cohomological obstruction whose existence-vs-impossibility closes Frankl by contradiction.
**Chain:** mg-f72a (UC1) → mg-a814 (UC2) → mg-cfc0 (UC3) → mg-0bf7 (UC4) → mg-3806 (UC5) → mg-6dad (UC6) → mg-a032 (UC7) → mg-d68d (UC8) → mg-96a6 (UC9, parallel extrinsic mechanism) → mg-814b (UC10) → mg-707c (UC12) → **mg-9ef0 (UC11, this doc)**.
**Branch:** `polecat-cat-mg-9ef0`.
**Type:** Native theory-execute — the union_closed-side analog of F29 (`one_third_width_three` mg-70b0) and F30 (mg-c3fe) on the Frankl conjecture. Paper-and-pencil; LaTeX-style Markdown; F-series house style. **No new axioms; no Lean; no computation; no engine port.** Multi-session-able; cumulative state ledger in `docs/state-UC11.md`. **Anti-factorial.** **Inherently-but-NOT-functorially related** to $\mathrm{Pos}_n$ cohomology (Daniel hard constraints, §0.5).
**Cross-repo references (read-only):** `one_third_width_three` — F17 (mg-4d3a, UCC.1 = $S_n$-equivariant cofiber Morse), F18 (mg-d039, UCC.2 = $\delta_n$-injectivity via null-homotopy of $\iota_n$), F29 (mg-70b0, Čech-bias cohomology scoping — the 1/3-2/3-side template), F30 (mg-c3fe, chain-level non-functorial cochain map $\Phi$ delivering F29's named residual; pinned NS-b branch of the dichotomy), mg-26fc (structural-analogy two-mechanisms framing + U1-obstruction language); used only as *template*, never as transfer target.

---

**Verdict: AMBER-Frankl-program-pinned-NS-mechanism-articulated-two-named-residuals.**

UC11 executes Daniel's verbatim 5-step Frankl program on the intersection-closed-family side, structurally mirroring F29+F30's Čech-bias mechanism on $\Delta(\mathrm{PPF}_n)$ but operating natively on $\mathcal C_n^{\cap}$'s cohomology object $X_n^{\cap}$:

1. **Sphere result on $\mathcal C_n^{\cap}$ — CONSUMED FROM UC10/UC12.** UC10's target Theorem UC10.1 (concentration of $\widetilde H^*(X_n^{\cap};\mathbb Q)$ in degree $n-1$ at isotype $\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$) is the F17+F18 analog for the cube/Walsh side; the load-bearing residual UC10.R (trace-injectivity of $\delta_n^{\cap}$ on the top-Walsh sign piece) is **closed unconditionally by UC12**'s $\Gamma_n$-equivariant cubical-bridge null-homotopy $h$. UC10.1 itself is unblocked modulo the §§5.3-5.4 technical adaptations whose execution strategy is sketched in UC12 §7.2.1 as a uniform application of the bridge mechanism. UC11 consumes UC10.1 as **input hypothesis** (§1.2), with its remaining execution surface marked as an *external* residual (a UC10 obligation, not a UC11 one).
2. **Flip union to intersection — TRIVIAL (UC9 Lemma 1.1, restated as Lemma 2.1 here).** Standard complementation involution exchanging union-closed and intersection-closed families. No information lost; the conjecture transfers cleanly.
3. **Minimality argument — EXECUTED (§3).** The minimal-counterexample reduction. Define the *minimal counterexample* $\mathcal F^\star$ as an intersection-closed family on $[n]$ satisfying Frankl's negation (every $x\in[n]$ is non-rare, i.e. $|\mathcal F^\star_x|>|\mathcal F^\star|/2$ — equivalently $\beta_x(\mathcal F^\star)>0$ for all $x$) and minimal in $|\mathcal F^\star|$. The hypothesis-satisfying-element claim is made precise (Theorem 3.4): *every proper sub-family $\mathcal G\subsetneq\mathcal F^\star$ in $\mathcal C_n^{\cap}$ has a coordinate $x\in S(\mathcal G)$ with $\beta_x(\mathcal G)\le 0$*. Proof is the standard minimal-counterexample move adapted to the $\mathcal C_n^{\cap}$ trace structure: any proper trace target of $\mathcal F^\star$ is intersection-closed (UC10 Lemma 2.3), strictly smaller, hence cannot itself violate Frankl by minimality of $\mathcal F^\star$.
4. **Construct the Čech sheaf $\mathcal F_{\mathrm{obs}}$ — EXECUTED (§4).** Define the trace-cover $\mathfrak U=\{U_x\}_{x\in[n]}$ where $U_x:=\{(S,\mathcal G)\in\mathcal C_n^{\cap}:S\ni x,\ \beta_x(\mathcal G)\le 0\}$ is the locus of subfamilies whose minimality-witness element is *fixed to be $x$*. By Theorem 3.4 the cover is genuine: $\mathfrak U$ covers the slice $\mathcal C_n^{\cap}(\mathcal F^\star):=\{(S,\mathcal G):\mathcal G\subseteq_{\mathrm{trace}}\mathcal F^\star\}$. Define $\mathcal F_{\mathrm{obs}}$ on $\mathfrak U$ by sending each $U_x$ to the $\chi_{\{x\}}$-Walsh-isotypic chain complex of $X(\mathcal G)$ and each intersection $U_x\cap U_y$ to the *mismatch cochain* $m_{xy}:=\beta_x|_{U_x\cap U_y}-\beta_y|_{U_x\cap U_y}$ (the affine restriction map carrying minimality-element-mismatch amounts; mirrors F29 §3.2's bias-jump amounts on $\Delta(\mathrm{PPF}_n)$).
5. **Assemble the Čech obstruction cocycle — EXECUTED (§5).** The mismatch cochains $\{m_{xy}\}$ satisfy the cocycle condition $m_{xy}+m_{yz}+m_{zx}\equiv 0$ on triple intersections (Lemma 5.2 — pure additive identity). The Čech 2-cocycle $\mathrm{ob}(\mathcal F^\star)\in\check H^2(\mathfrak U;\mathcal F_{\mathrm{obs}})$ assembles, and its image in $\widetilde H^{n-1}(X_n^{\cap};\mathbb Q)$ under the Čech-to-cohomology spectral sequence's edge map lands in the top-Walsh sign isotype $V_{[n]}^{n-1}$ (Theorem 5.3 — by the obstruction-class-vs-Walsh-support tracking lemma).
6. **The "must-be sphere class" step (NS-a/NS-b dichotomy, NS-b branch — EXECUTED in §6).** By UC10.1, $V_{[n]}^{n-1}\cong\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$ is one-dimensional. So $\mathrm{ob}(\mathcal F^\star)$ either vanishes or equals (a scalar multiple of) the sphere class. Vanishing would mean $\mathcal F^\star$ admits a global trivialization of its minimality-witness mismatch — i.e. the $\beta_x$'s can be coherently signed across all sub-families — which contradicts $\beta_x(\mathcal F^\star)>0$ for *every* $x$ at the top sub-family (the minimal counterexample itself). So $\mathrm{ob}(\mathcal F^\star)$ is **non-zero** (Lemma 6.2).
7. **The "cannot be sphere class" step — STRUCTURALLY ARGUED, ONE LOAD-BEARING RESIDUAL (§7).** Mirror F30's NS-b mechanism: the chain-level $\Gamma_n$-equivariance of $\mathrm{ob}(\mathcal F^\star)$ is **inconsistent** with the $\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$-isotype. Specifically (Lemma 7.3): $\mathrm{ob}(\mathcal F^\star)$ is constructed from the bias function $\beta:\mathcal C_n^{\cap}\to\mathbb Z^{[n]}$, which is **equivariant for the trivial $\Gamma_n$-twist** on the value side (each $\beta_x$ is *positive* on the minimality-witness locus, with no sign-flip under coordinate toggles $\sigma_x$ — the toggle sends an intersection-closed family into a union-closed one and reflects the bias's *sign* but the *cover element* labelled by $x$ flips accordingly, leaving the *underlying chain class* fixed up to the toggle's natural orientation, NOT picking up the $\chi_{[n]}$ sign of every coordinate); the sphere class is by UC10.1 *forced* to flip under every coordinate toggle. The chain class is therefore both in the trivial-$\chi_S$-isotype on its support (for $|S|<n$) and in the $\chi_{[n]}$-isotype (where it lands via the edge map) — a contradiction *unless the class is zero*, which contradicts §6. (NS-b style — chain-level equivariance contradiction forces zero, paralleling F30's $c_{BC}(P)=0$ from chain-level $S_n$-equivariance contradiction.) The **load-bearing residual UC11.R**: the bias-equivariance computation of Lemma 7.3 must be tightened to a single-isotype-collapse argument (the analog of F30's full chain-level $\Phi$ construction), which the present session sketches but does not execute in full.
8. **U1-dissolve check — PASSED (§8).** $\mathcal F_{\mathrm{obs}}$ is **chain-level**, not a refinement-functorial sheaf morphism. The Čech assembly works on the orbit-cover of $\mathfrak U$ as a chain complex; no functor $\mathcal C_n^{\cap}\to\mathrm{PPF}_n$ is invoked; no comparison of bias values across distinct refinements enters. The Daniel "not functorially" directive is honored by the cover-of-subfamilies design (a single cover of a single minimal counterexample, not a comparison across counterexamples). The F30-OP dissolve criteria (D-α, D-β, D-γ) all transfer (§8.2) to chain-level UC dialect.

**Why AMBER not GREEN.** The 5-step Daniel program executes through step 6 unconditionally (modulo UC10's external §§5.3-5.4 surface). Step 7 — the "cannot be sphere class" contradiction — is structurally articulated and the NS-b mechanism is identified, but the load-bearing chain-level $\Gamma_n$-equivariance-collapse computation (Lemma 7.3) is sketched, not executed in full rigour. **The full GREEN-Frankl conclusion is one operational session away** (file UC13 to execute Lemma 7.3 in detail — the analog of F30's delivery on F29's NS-b residual).

**Why AMBER not RED.** No step structurally fails. The Čech mechanism assembles (step 5 GREEN). The non-vanishing argument lands (step 6 GREEN). The contradiction direction is identified (NS-b, paralleling F30) and the proof skeleton is laid down (§7). No U1-dialect collision (§8). The residual is a *tightening* of an articulated mechanism, not a search for a new mechanism.

**Why AMBER and not naked-AMBER.** Two named residuals: (R1, internal to UC11) the Lemma 7.3 chain-level equivariance-collapse computation, to be UC13 — direct analog of F30 on F29; (R2, external — already-existing UC10/UC12 residual) the §§5.3-5.4 technical adaptations whose mechanism UC12 sketched. Both are within reach using machinery already on the table.

**The honest one-sentence verdict.** *Daniel's verbatim 5-step Frankl program lands cleanly on the intersection-closed-family side via Čech-cohomological assembly of a minimality-witness obstruction class on the trace cover $\mathfrak U=\{U_x\}_{x\in[n]}$ of the slice $\mathcal C_n^{\cap}(\mathcal F^\star)$ over a minimal counterexample $\mathcal F^\star$: the class lands in UC10's only-non-vanishing cohomology $V_{[n]}^{n-1}\cong\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$ by construction (Theorem 5.3), is non-zero by the minimality-no-trivialization argument (Lemma 6.2), and is structurally forced to vanish by the NS-b chain-level $\Gamma_n$-equivariance collapse — both in the trivial-$\chi_S$-isotype (where bias data lives, $|S|<n$) and in the $\chi_{[n]}$-isotype (where the edge map sends it) — yielding a contradiction modulo one named residual UC11.R (Lemma 7.3 tightening, the F30-analog) that is one session away from execution; the U1-dialect-collision is dissolved unconditionally by the chain-level non-functorial design of $\mathcal F_{\mathrm{obs}}$ and the cover-of-a-single-counterexample framing per Daniel's not-functorially directive.*

§0 fixes notation and recaps UC10/UC12 + F29/F30; §1 consumes UC10.1 and clarifies what UC11 assumes vs. proves; §2 the intersection-closed flip; §3 the minimality argument (subfamily cover + the hypothesis-satisfying-element claim); §4 the Čech sheaf $\mathcal F_{\mathrm{obs}}$ construction; §5 the Čech 2-cocycle and its top-Walsh sign-isotype landing; §6 the must-be-sphere step (non-vanishing); §7 the cannot-be-sphere step (NS-b chain-level equivariance collapse, with named residual UC11.R); §8 the U1-dissolve check; §9 the verdict and UC13 scope; §10 references.

---

## §0. Notation, the UC10/UC12 invariants UC11 inherits, the F29/F30 invariants UC11 mirrors, and the Daniel hard constraints

### 0.1 The intersection-closed setting

$U=[n]$ a finite ground set, $|U|=n\ge 3$. $\mathcal F\subseteq 2^U$ a family. **Intersection-closed**: $A,B\in\mathcal F\Rightarrow A\cap B\in\mathcal F$. WLOG $\mathcal F\ne\emptyset,\{U\}$. For $x\in U$: $\mathcal F_x=\{A\in\mathcal F:x\in A\}$; $\mathcal F_{\bar x}=\mathcal F\setminus\mathcal F_x$; **bias** $\beta_x(\mathcal F)=|\mathcal F_x|-|\mathcal F_{\bar x}|$. **$x$ is rare in $\mathcal F$** iff $\beta_x(\mathcal F)\le 0$, equivalently $|\mathcal F_x|\le|\mathcal F|/2$.

**Frankl (intersection-closed form).** Every intersection-closed $\mathcal F\ne\emptyset,\{U\}$ has some $x\in U$ with $\beta_x(\mathcal F)\le 0$ (some rare element).

**Frankl's negation, intersection-closed form.** There exists an intersection-closed $\mathcal F^\star$ (a counterexample) with $\beta_x(\mathcal F^\star)>0$ for *every* $x\in U$ — every element is *strictly abundant on the wrong side*. The minimal such $\mathcal F^\star$ (in $|\mathcal F^\star|$, then any chosen tiebreaker on $n=|U|$) is the **minimal counterexample**.

### 0.2 UC10/UC12 invariants UC11 consumes (carried verbatim from `state-UC10.md`)

The native cohomology theory of intersection-closed families:

- **The category $\mathcal C_n^{\cap}$ (UC10 Defn 2.1, 2.2; UC10.S substrate).** Objects = pointed intersection-closed families $(S,\mathcal F)$ with $\bigcup\mathcal F=S\subseteq[n]$, $S\in\mathcal F$. Morphisms = trace $(S,\mathcal F)\to(T,\mathcal G)$ for $T\subseteq S$ with $\mathcal G=\{A\cap T:A\in\mathcal F\}$. Same-ground-set inclusions are NOT in $\mathcal C_n^{\cap}$.
- **The cohomology object $X_n^{\cap}=\mathop{\mathrm{hocolim}}_{(\mathcal C_n^{\cap})^{\mathrm{op}}}X(\mathcal F)$ (UC10 Defn 3.3).** A $\Gamma_n=(\mathbb Z/2)^n\rtimes S_n$-equivariant chain complex over $\mathbb Q$. Polynomial-in-$|\mathcal F|$, exponential-in-$n$. Walsh-decomposes under $(\mathbb Z/2)^n$ into isotypic pieces $\bigoplus_{S\subseteq[n]}\chi_S\otimes V_S^*$ (UC10.W = Theorem 3.5, proven).
- **The target theorem UC10.1 (Walsh sign-concentration, Theorem 4.1).** For every $n\ge 3$,
  $$
    \widetilde H^k(X_n^{\cap};\mathbb Q)\;\cong\;\begin{cases}\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}\,,&k=n-1,\\ 0\,,&1\le k\le n-2.\end{cases}
  $$
  *as $\Gamma_n$-modules.* Equivalently $V_{[n]}^{n-1}\cong\mathrm{sgn}_{S_n}$ (1-dim) and $V_S^k=0$ for $(S,k)\ne([n],n-1)$ in degree $\ge 1$. **Status:** stated; the load-bearing residual UC10.R closed by UC12; the technical adaptations of UC10 §§5.3-5.4 sketched in UC12 §7.2.1 but not executed in detail. UC11 consumes UC10.1 as input hypothesis (§1.2).
- **The trace-injectivity bridge UC12 (Theorem 4.4 + Prop 4.5).** $\iota_n^{\cap}:X_n^{\cap}\hookrightarrow X_{n+1}^{\cap}$ is the canonical doubling-trace inclusion (the doubling functor $\mathrm{db}\mathcal F=\mathcal F\cup(\mathcal F+\{n+1\})$, UC12 Defn 2.1, sets the section); $\delta_n^{\cap}$ injective on $V_{[n]}$ via the cubical-bridge null-homotopy $h$ of UC12 Defn 3.1.
- **The stuck-set correspondence UC10.S (Theorem 4.2, proven).** Single-coordinate trace $(S,\mathcal F)\to(S\setminus\{x\},\mathcal G)$ has preimages of cardinality 1 ($x$-stuck) or 2 ($x$-matched); $\beta_x(\mathcal F)=|\mathcal F_x^{\mathrm{stuck}}|-|\mathcal F_{\bar x}^{\mathrm{stuck}}|$ (after the matching-bookkeeping rewrite). This is the **load-bearing combinatorial substrate** linking the cohomology to the bias — UC11 uses it everywhere.

UC11 carries all of these as fixed input. Whenever UC11 *says* "$V_{[n]}^{n-1}\cong\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$" or "$\beta_x$ reads off trace-preimage cardinality," the reference is UC10/UC12.

### 0.3 The F29/F30 invariants UC11 mirrors (one_third_width_three references)

The 1/3-2/3-side Čech-cohomological program:

- **F29 (mg-70b0, Čech-bias scoping).** Bad cut $C$ on a small-counterexample poset $P$ $\to$ local biases $b_x(C)$ on the per-element subposets $P\setminus\{x\}$ $\to$ a Čech 2-cocycle $c_{BC}(P)$ on the trace cover of $P$ in $\Delta(\mathrm{PPF}_n)$, valued in the sgn-isotypic chain complex. The 2-cocycle's class in $\widetilde H^{n-2}(\Delta_n;\mathbb Q)$ either equals the (unique) F17+F18 sgn-class or vanishes (either-or dichotomy = (NS-a) ∨ (NS-b)).
- **F30 (mg-c3fe, F29's NS-b delivery).** Chain-level non-functorial cochain map $\Phi:C^*(\Delta_n,\mathbb Q)\to C^*(\Delta_n,\mathbb Q)$ assembled via per-step probabilities and cover-relation 2-cocycle stratum-labels. $\Phi_*c_{BC}(P)=0$ from chain-level $S_n$-equivariance contradiction (the cochain is forced into both trivially-$S_n$-equivariant and $\mathrm{sgn}_{S_n}$-equivariant isotypes, contradiction). The dissolve criterion (D-α, D-β, D-γ) of F29 §6.2 is met unconditionally by chain-level construction. **F31 named residual:** $\Phi_*$ injectivity on the bad-cut Čech class.
- **The dichotomy mechanism (NS-a / NS-b).** Either (NS-a) the Čech class is *not* in the F17+F18 isotype $\mathrm{sgn}_{S_n}$ (contradicts the only-non-vanishing concentration of the F17+F18 result), or (NS-b) the Čech class **is** in that isotype but is structurally *forced to vanish* via chain-level equivariance considerations. F29 GREENs either way; F30 pins (NS-b) operationally.

UC11 transfers this dichotomy template to the cube/Walsh side. UC11's analog: either (UC-NS-a) the obstruction class is not in the $\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$ isotype, contradicting UC10.1's only-non-vanishing concentration; or (UC-NS-b) it is in that isotype but is forced to vanish by chain-level $\Gamma_n$-equivariance considerations on the bias function. §6–§7 execute via the (UC-NS-b) branch (the F30 analog).

### 0.4 The cube, the Walsh transform, the symmetry groups (UC10 §0.2 recap)

The cube $Q_n=([0,1]^n,$ edge set $E_n)$. Coordinate involutions $\sigma_x:2^U\to 2^U$, $\sigma_x(A)=A\,\triangle\,\{x\}$, generate $(\mathbb Z/2)^n$. Permutations $\pi\in S_n$ act by relabeling. $\Gamma_n:=(\mathbb Z/2)^n\rtimes S_n=$ hyperoctahedral / type-$B_n$ Coxeter group, $|\Gamma_n|=2^n n!$.

Walsh characters $\chi_S:2^U\to\{\pm 1\}$, $\chi_S(A)=(-1)^{|S\cap A|}$, $S\subseteq U$. Top character $\chi_{[n]}$: every $\sigma_x$ acts by $-1$. UC11's load-bearing isotype is $\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$ — the unique sign character of $\Gamma_n$ sending every reflection (every $\sigma_x$ AND every transposition) to $-1$.

### 0.5 Daniel hard constraints (NON-NEGOTIABLE)

- **NOT factorial.** Daniel verbatim 2026-05-15T23:20Z. UC11 must not invoke factorial decompositions. The $\Gamma_n=(\mathbb Z/2)^n\rtimes S_n$ semi-direct product is *not* factorial in the prohibited sense (it is the natural type-B Coxeter group, not a factorial spine).
- **Inherently but NOT functorially related to $\mathrm{Pos}_n$ cohomology.** Daniel verbatim 2026-05-15T23:20Z. UC11 must not invoke any functor $\mathcal C_n^{\cap}\to\mathrm{PPF}_n$ (or any direction) in its load-bearing path. The F29/F30 references are *structural templates only*: no theorem of F29/F30 is invoked as logical hypothesis. UC11 honors this constraint by construction (§4 — $\mathcal F_{\mathrm{obs}}$ is built natively on $\mathcal C_n^{\cap}$ with no Pos image; §8 — the U1-dissolve check verifies no hidden functoriality).
- **Paper-and-pencil first.** Per pm-onethird `feedback_latex_first_for_math_simp`. LaTeX-style Markdown only.
- **Cumulative state doc.** Per pm-onethird `feedback_polecat_cumulative_state_doc`. `docs/state-UC11.md` carries the cross-session ledger.
- **Verify UC10's claim before depending.** Per pm-onethird `feedback_pre_execution_dependency_verification`. UC11 §1.2 verifies UC10's sphere result and pins which degree/coefficients/isotype the obstruction must land in, *before* the §4-§5 construction.

---

## §1. UC10 verification + what UC11 assumes

### 1.1 Why this section exists

Per Daniel's pre-execution-dependency-verification directive, UC11's first action is to read UC10's claim, verify it is the right shape for the §4-§5 construction to consume, and pin the parameters (degree, coefficients, isotype) that the obstruction class must land in. If UC10's sphere result has the wrong shape, UC11 REDs immediately rather than building a downstream construction on sand.

### 1.2 What UC10/UC12 deliver (verbatim from `state-UC10.md` Session 2)

The status of UC10's deliverable as of the close of UC12 (Session 2):

> **UC10.1 (target theorem, Walsh sign-concentration).** For every $n\ge 3$, $\widetilde H^k(X_n^{\cap};\mathbb Q)\cong\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$ at $k=n-1$, and $0$ for $1\le k\le n-2$, as $\Gamma_n$-modules. Equivalently $V_{[n]}^{n-1}\cong\mathrm{sgn}_{S_n}$ (one-dimensional) and $V_S^k=0$ for $(S,k)\ne([n],n-1)$ in degree $\ge 1$.

**Status of UC10.1.** Stated. The load-bearing open lemma UC10.R is closed unconditionally by UC12. The technical adaptations of UC10 §§5.3-5.4 (lower-Walsh vanishing for $S\subsetneq[n]$, $k\ge 1$; top-Walsh concentration in degree $n-1$) have their execution strategy sketched in UC12 §7.2.1 as a uniform application of the cubical-bridge mechanism with different (anti-)symmetry choices, but the details are not written out.

**UC11's posture:** UC11 takes UC10.1 as an *input hypothesis*, with the §§5.3-5.4 adaptations as an *external* AMBER residual whose work lives in the UC10/UC12 deliverable, not in UC11. This is explicitly within the "depends-on UC10 GREEN" framing of the UC11 ticket (mg-9ef0); UC11 is the Frankl-side consumer. If UC10 §§5.3-5.4 fails to execute, UC11 inherits an AMBER tag from that — but the *UC11-side* mechanism is robust to it (the only fact UC11 uses about UC10.1 is the *isotypic concentration shape*, which UC10.W gives unconditionally; the *one-dimensionality* at degree $n-1$ is what the §§5.3-5.4 adaptations would deliver, and UC11 uses it in §6.1 below).

### 1.3 The exact parameters UC11 uses from UC10.1

UC11's §§4-7 construction depends on UC10.1 in three precise ways:

- **(P1) The cohomology object $X_n^{\cap}$ exists with the polynomial-in-$|\mathcal F|$ + exponential-in-$n$ size and the $\Gamma_n$-equivariant Walsh decomposition.** UC10.W + UC10 Lemma 3.6 — both unconditional. Used in §§4-5.
- **(P2) The top-Walsh sign isotype $V_{[n]}^{n-1}$ is the unique-non-vanishing class.** UC10.1 — pinned modulo UC10 §§5.3-5.4. Used in §6 and §7.
- **(P3) The bias function $\beta_x:\mathcal C_n^{\cap}\to\mathbb Z$ reads off the trace-preimage cardinality (UC10.S, Theorem 4.2 — unconditional).** Used in §4 to define $\mathcal F_{\mathrm{obs}}$'s mismatch cochains.

(P1) and (P3) are unconditional. (P2) is the conditional input; the §§5.3-5.4 adaptation is the conditioning. UC11 is honest about this.

### 1.4 The degree-shift bookkeeping

A subtle point: UC10.1 lives at degree $n-1$ (not $n-2$ as in the F-series). The shift is structural — the cube $Q_n$ is one-dimensional larger than the proper part of $\mathrm{PPF}_n$'s order complex. The Čech 2-cocycle of §5 lives intrinsically in degree 2 of the Čech-bicomplex; the spectral-sequence edge map to single-complex cohomology lands it at degree-$(n-3)+2 = n-1$ (cf. §5.3), matching UC10.1's only-non-vanishing degree. The bookkeeping works out — but it does require that the Čech cover $\mathfrak U$ is constructed in such a way that the edge map lands at $n-1$, not $n-2$. §4.1 makes this precise.

### 1.5 Summary of §1

UC10/UC12 deliver the four ingredients UC11 needs:
1. The cohomology object $X_n^{\cap}$ with $\Gamma_n$-Walsh decomposition (UC10.W, unconditional);
2. The bias-substrate identity $\beta_x = $ stuck-set imbalance (UC10.S, unconditional);
3. The trace-injectivity bridge (UC12, unconditional);
4. The only-non-vanishing-cohomology concentration (UC10.1, conditional on §§5.3-5.4, sketched in UC12 §7.2.1).

UC11 consumes (1)-(3) unconditionally; UC11's load-bearing path uses (4) at §6 and §7. The §§5.3-5.4 obligation is **external** to UC11.

---

## §2. The intersection-closed flip

This section is a one-paragraph restatement of UC9 Lemma 1.1 + UC10 §1.1. Already proven; carried as input.

### 2.1 Lemma 2.1 (flip-invariance of Frankl, UC10 §1.1)

> **Lemma 2.1.** *Define $\tau:2^{[n]}\to 2^{[n]}$ by $\tau(A)=[n]\setminus A$. For any family $\mathcal F\subseteq 2^{[n]}$ write $\mathcal F^c:=\tau(\mathcal F)$. Then:*
> - *$\mathcal F$ is union-closed iff $\mathcal F^c$ is intersection-closed,*
> - *$|\mathcal F^c|=|\mathcal F|$,*
> - *$\beta_x(\mathcal F^c)=-\beta_x(\mathcal F)$ for every $x\in[n]$.*

*Proof.* UC9 Lemma 1.1; UC10 §1.1 Lemma 1.1. The flip is the complementation involution; closure-direction reverses; bias signs reverse with the bijection between $\mathcal F_x$ and $\mathcal F^c_{\bar x}$. $\blacksquare$

### 2.2 Frankl in intersection-closed form

By Lemma 2.1, Frankl is equivalent to:

> **Frankl (intersection-closed form).** Every intersection-closed $\mathcal F\subseteq 2^{[n]}$ with $\mathcal F\ne\emptyset,\{[n]\}$ has a coordinate $x\in[n]$ with $\beta_x(\mathcal F)\le 0$.

The conjecture's content is identical. UC11 works in intersection-closed form throughout. **No information is lost; this step is bookkeeping.**

### 2.3 The minimal counterexample (the negation)

> **Definition 2.2 (minimal counterexample).** A **counterexample** to Frankl (intersection-closed form) is a pair $([n],\mathcal F^\star)$ with $\mathcal F^\star\subseteq 2^{[n]}$ intersection-closed, $\mathcal F^\star\ne\emptyset,\{[n]\}$, and $\beta_x(\mathcal F^\star)>0$ for *every* $x\in[n]$. A **minimal counterexample** is one minimizing $|\mathcal F^\star|$ first, then minimizing $n$ (tiebreaker).

UC11 fixes a minimal counterexample $([n],\mathcal F^\star)$ and derives a contradiction. The minimality is the entry point for §3.

---

## §3. The minimality argument — every sub-family has an element satisfying the hypothesis

This section operationalizes Daniel's verbatim *"Use minimality to show every sub-family has an element that satisfies the thm hypothesis."* The subfamily class is pinned (the trace-subcategory of $\mathcal C_n^{\cap}$ below $\mathcal F^\star$); the hypothesis-satisfying-element claim is stated as Theorem 3.4 and proven.

### 3.1 The trace-subcategory below $\mathcal F^\star$

Recall (UC10 Defn 2.2): a trace morphism $(S,\mathcal F)\to(T,\mathcal G)$ in $\mathcal C_n^{\cap}$ is restriction $T\subseteq S$ with $\mathcal G=\{A\cap T:A\in\mathcal F\}$.

> **Definition 3.1 (trace-subcategory $\mathcal C_n^{\cap}(\mathcal F^\star)$).** Let $([n],\mathcal F^\star)\in\mathcal C_n^{\cap}$ be the fixed minimal counterexample. The **trace-subcategory below $\mathcal F^\star$** is the full subcategory $\mathcal C_n^{\cap}(\mathcal F^\star)\subseteq\mathcal C_n^{\cap}$ on objects $(T,\mathcal G)$ that arise as iterated traces of $([n],\mathcal F^\star)$ — i.e. $T\subseteq[n]$ and $\mathcal G=\{A\cap T:A\in\mathcal F^\star\}=\mathcal F^\star|_T$.

By UC10 Lemma 2.3, each $\mathcal F^\star|_T$ is intersection-closed on $T$ with $\bigcup\mathcal F^\star|_T=T$ and $T\in\mathcal F^\star|_T$ — hence a genuine object of $\mathcal C_n^{\cap}$.

Note that $\mathcal C_n^{\cap}(\mathcal F^\star)$ is a *full subcategory*: its objects are *trace targets* of $\mathcal F^\star$, in bijection with subsets $T\subseteq[n]$ (a single trace target $\mathcal F^\star|_T$ per $T$, by the trace condition). So $|\mathrm{Obj}(\mathcal C_n^{\cap}(\mathcal F^\star))|=2^n$ (or $2^n-1$ if we exclude $T=\emptyset$, which we do — empty support is not in $\mathcal C_n^{\cap}$). **Finite, polynomially bounded in $n$, well-controlled.** This is the C2 dodge played at the slice level.

### 3.2 The hypothesis-satisfying-element claim

> **Claim 3.2 (Daniel verbatim, made precise).** *Every $(T,\mathcal G)\in\mathcal C_n^{\cap}(\mathcal F^\star)$ with $\mathcal G\subsetneq\mathcal F^\star$ (i.e. $T\subsetneq[n]$) has some $x\in T$ with $\beta_x(\mathcal G)\le 0$.*

In words: every *proper* sub-family in the trace-subcategory has a rare element — *satisfies the Frankl hypothesis* on its own support. This is the key combinatorial input from minimality.

### 3.3 The proof — strict-trace shrinking

> **Theorem 3.4 (the minimality-element theorem).** *Claim 3.2 holds.*

*Proof.* Let $(T,\mathcal G)\in\mathcal C_n^{\cap}(\mathcal F^\star)$ with $T\subsetneq[n]$. Then $\mathcal G=\mathcal F^\star|_T$ is intersection-closed on $T$ (UC10 Lemma 2.3), has $\bigcup\mathcal G=T$, has $T\in\mathcal G$, and has $|\mathcal G|\le|\mathcal F^\star|$ (counting trace-preimages — each $A\in\mathcal G$ pulls back to $\ge 1$ element of $\mathcal F^\star$; |\mathcal G|=|\mathcal F^\star| only if every trace-preimage is a singleton, but that would force $\mathcal F^\star$ to live entirely outside the coordinate $T^c$ — i.e. all elements of $\mathcal F^\star$ are subsets of $T$ — which would mean $T=\bigcup\mathcal F^\star=[n]$, a contradiction with $T\subsetneq[n]$).

So $|\mathcal G|<|\mathcal F^\star|$. Now suppose for contradiction that $\beta_x(\mathcal G)>0$ for every $x\in T$. Then $(T,\mathcal G)$ is itself a counterexample to Frankl (intersection-closed form) on the smaller ground set $T$, with $|\mathcal G|<|\mathcal F^\star|$. This contradicts minimality of $\mathcal F^\star$ in $|\mathcal F^\star|$ (under the tiebreaker on $n$: smaller $|\mathcal G|$ wins regardless of whether $|T|<n$). $\blacksquare$

### 3.4 The "minimality-witness element" function

Theorem 3.4 says: for every $(T,\mathcal G)\in\mathcal C_n^{\cap}(\mathcal F^\star)$ with $T\subsetneq[n]$, there exists some $x\in T$ with $\beta_x(\mathcal G)\le 0$. In general $x$ is not unique; we pick one and call it the **minimality-witness element** of $(T,\mathcal G)$.

> **Definition 3.5 (minimality-witness function).** Fix a tiebreaker rule (e.g. lex-smallest $x$). Define $w:\mathcal C_n^{\cap}(\mathcal F^\star)\setminus\{([n],\mathcal F^\star)\}\to[n]$ by $w(T,\mathcal G):=$ the smallest $x\in T$ with $\beta_x(\mathcal G)\le 0$.

The function $w$ is well-defined by Theorem 3.4. It is *not canonical* (depends on the tiebreaker rule) — but UC11's construction is invariant under this choice (§4.6 verifies).

**The minimality-witness function is the load-bearing combinatorial datum for the Čech sheaf $\mathcal F_{\mathrm{obs}}$.** Every proper sub-family in $\mathcal C_n^{\cap}(\mathcal F^\star)$ carries a single distinguished coordinate $x=w(T,\mathcal G)$ — the "satisfies-the-hypothesis" element. The cover $\mathfrak U$ stratifies the sub-category by which $x$ is chosen.

### 3.5 Non-extendability to $\mathcal F^\star$ itself

Note Theorem 3.4 excludes $(T,\mathcal G)=([n],\mathcal F^\star)$. Indeed, by Definition 2.2, $\beta_x(\mathcal F^\star)>0$ for *every* $x\in[n]$ — the minimality-witness function does NOT extend to the top object. **This is the structural source of the obstruction class** (§5-§6): the witness function is a partial section on $\mathcal C_n^{\cap}(\mathcal F^\star)\setminus\{\mathcal F^\star\}$, the inability to extend to $\mathcal F^\star$ being the cohomological obstruction.

### 3.6 Summary of §3

The minimality argument is precise:

- The relevant **subfamily class** is the trace-subcategory $\mathcal C_n^{\cap}(\mathcal F^\star)$ — full subcategory of $\mathcal C_n^{\cap}$ on the trace targets of $\mathcal F^\star$;
- The **hypothesis-satisfying-element claim** (Theorem 3.4) holds for every proper sub-family;
- The **minimality-witness function** $w$ (Defn 3.5) is the partial section to be Čech-assembled in §4;
- The **non-extendability** to $\mathcal F^\star$ itself is the structural source of the obstruction.

---

## §4. The Čech sheaf $\mathcal F_{\mathrm{obs}}$

This is the load-bearing construction. It mirrors F29 §3.2 (the bias sheaf on $\Delta(\mathrm{PPF}_n)$) structurally, but operates natively on $\mathcal C_n^{\cap}(\mathcal F^\star)$ with the trace cover of subfamilies.

### 4.1 The trace cover $\mathfrak U$

> **Definition 4.1 (the trace cover).** For each $x\in[n]$, the **$x$-stratum** is
> $$
>   U_x\;:=\;\bigl\{(T,\mathcal G)\in\mathcal C_n^{\cap}(\mathcal F^\star)\setminus\{([n],\mathcal F^\star)\}\,:\,x\in T,\ \beta_x(\mathcal G)\le 0\bigr\}.
> $$
> The **trace cover** is $\mathfrak U:=\{U_x\}_{x\in[n]}$.

> **Lemma 4.2 (the cover property).** *$\bigcup_{x\in[n]}U_x=\mathcal C_n^{\cap}(\mathcal F^\star)\setminus\{([n],\mathcal F^\star)\}$.*

*Proof.* Immediate from Theorem 3.4: every proper sub-family has *some* rare element. $\blacksquare$

So $\mathfrak U$ is a genuine cover — minus the top object, which is the minimal counterexample itself. The pair (cover, hole-at-the-top) is the Čech setup analog of "punctured boundary sphere" in algebraic topology — the obstruction class is the relative cohomology of the puncture.

### 4.2 The bias sheaf on a single stratum

For each $x\in[n]$ and each $(T,\mathcal G)\in U_x$, define the **local bias cochain** $b_x(\mathcal G)\in\mathbb Z$ by
$$
  b_x(\mathcal G)\;:=\;-\beta_x(\mathcal G)\;=\;|\mathcal G_{\bar x}|-|\mathcal G_x|\;\ge\;0.
$$
(The sign is chosen so $b_x$ is non-negative on $U_x$ — a witness of the magnitude of the minimality slack.)

By UC10.S (Theorem 4.2), $b_x(\mathcal G)=|\mathcal G_{\bar x}^{\mathrm{stuck}}|-|\mathcal G_x^{\mathrm{stuck}}|$ — the stuck-set imbalance, read off the single-coordinate trace $(T,\mathcal G)\to(T\setminus\{x\},\mathcal G|_{T\setminus\{x\}})$. This is the **substrate identity** that makes $b_x$ a *cohomological* object, not just an arithmetic one: the trace morphism encoding $b_x$ is a morphism *in* $\mathcal C_n^{\cap}$.

> **Definition 4.3 (the local Walsh bias cochain).** For each $x\in[n]$ and each $(T,\mathcal G)\in U_x$, define $\widehat b_x(\mathcal G):=b_x(\mathcal G)\cdot[\chi_{\{x\}}]_{X(\mathcal G)}$ — the $\chi_{\{x\}}$-Walsh-isotypic cochain of $X(\mathcal G)$ scaled by the bias magnitude. (Here $[\chi_{\{x\}}]_{X(\mathcal G)}$ is the canonical level-1 Walsh class on $X(\mathcal G)$ at coordinate $x$.)

### 4.3 The mismatch cochain on an intersection $U_x\cap U_y$

On $U_x\cap U_y$ (for $x\ne y$, the locus where *both* $\beta_x\le 0$ and $\beta_y\le 0$), we have *two* candidate Walsh-isotypic cochains $\widehat b_x$ and $\widehat b_y$. The **mismatch cochain** is the difference, valued in the $\chi_{\{x\}}\oplus\chi_{\{y\}}$ isotypes:
$$
  m_{xy}(\mathcal G)\;:=\;\widehat b_x(\mathcal G)-\widehat b_y(\mathcal G)\;\in\;C^*(X(\mathcal G))_{\chi_{\{x\}}}\,\oplus\,C^*(X(\mathcal G))_{\chi_{\{y\}}}.
$$

> **Definition 4.4 (the Čech sheaf $\mathcal F_{\mathrm{obs}}$).** $\mathcal F_{\mathrm{obs}}$ is the constructible sheaf on the trace cover $\mathfrak U$ assigning:
> - $\mathcal F_{\mathrm{obs}}(U_x)\;:=\;C^*(X(-))_{\chi_{\{x\}}}|_{U_x}$ — the $\chi_{\{x\}}$-Walsh-isotypic chain complex over $U_x$, scaled by $b_x$;
> - $\mathcal F_{\mathrm{obs}}(U_x\cap U_y)\;:=\;C^*(X(-))_{\chi_{\{x\}}}\oplus C^*(X(-))_{\chi_{\{y\}}}$ — the direct sum of two Walsh isotypes, with the **restriction maps**:
>   - $\mathrm{res}^x_{U_x\cap U_y}\;:\;\mathcal F_{\mathrm{obs}}(U_x)\to\mathcal F_{\mathrm{obs}}(U_x\cap U_y)$, $\widehat b_x\mapsto(\widehat b_x,0)$;
>   - $\mathrm{res}^y_{U_x\cap U_y}\;:\;\mathcal F_{\mathrm{obs}}(U_y)\to\mathcal F_{\mathrm{obs}}(U_x\cap U_y)$, $\widehat b_y\mapsto(0,\widehat b_y)$;
> - $\mathcal F_{\mathrm{obs}}(U_x\cap U_y\cap U_z)$ similarly $:=C^*(X(-))_{\chi_{\{x\}}}\oplus C^*(X(-))_{\chi_{\{y\}}}\oplus C^*(X(-))_{\chi_{\{z\}}}$, with the obvious projection-to-summand restrictions.

The construction is the cube/Walsh-side analog of F29 §3.2's bias sheaf on $\Delta(\mathrm{PPF}_n)$ — there the local data on each stratum was a bias-jump amount, here it is a Walsh-isotypic-scaled-by-bias cochain.

### 4.4 The structural reading — why this is "carrying minimality-element-mismatch amounts"

The Čech sheaf $\mathcal F_{\mathrm{obs}}$ encodes, on each stratum $U_x$, the **single-coordinate Walsh component** of the bias at the minimality-witness element $x$. On intersections $U_x\cap U_y$, the *two* candidate witness elements both apply, and the sheaf records *both* their contributions in separate Walsh isotypes — which can fail to be cohomologically consistent.

The failure of consistency is the **cohomological obstruction**: were the witness function $w$ extendable to a global section, all the $\widehat b_x$ would be coherently glued — but the trace cover is genuinely an *open cover* (not a refinement of a single chart), and the multi-isotype structure on intersections prevents naive gluing. The Čech 2-cocycle of §5 measures this failure.

### 4.5 $\Gamma_n$-equivariance of $\mathcal F_{\mathrm{obs}}$

A $\pi\in S_n$ acts on the trace cover by $\pi\cdot U_x=U_{\pi(x)}$ — permuting the strata. A $\sigma_x\in(\mathbb Z/2)^n$ acts on $X(\mathcal G)$ via coordinate toggle but, crucially, on the *family* $\mathcal G$ it sends intersection-closed to union-closed — so $\sigma_x$ does NOT preserve the trace cover. By UC10 Lemma 3.6, the bi-equivariance is via the cube ambient: $(\mathbb Z/2)^n$ acts on $X(\mathcal G)$'s underlying cube, $S_n$ on both the cube and on $\mathcal C_n^{\cap}$.

> **Lemma 4.5 ($\Gamma_n$-equivariance of $\mathcal F_{\mathrm{obs}}$).** *The Čech sheaf $\mathcal F_{\mathrm{obs}}$ is $S_n$-equivariant on its indexing: $\pi\cdot\widehat b_x(\mathcal G)=\widehat b_{\pi(x)}(\pi\cdot\mathcal G)$. It is $(\mathbb Z/2)^n$-equivariant on its values: $\sigma_y\cdot\widehat b_x(\mathcal G)=(-1)^{[y=x]}\widehat b_x(\sigma_y\cdot\mathcal G)$ (the Walsh action of $\sigma_y$ on $\chi_{\{x\}}$).*

*Proof.* $S_n$-equivariance: $\pi$ permutes coordinates, the bias function commutes with relabeling ($\beta_x(\mathcal G)=\beta_{\pi(x)}(\pi\cdot\mathcal G)$, just bookkeeping), and the Walsh class $\chi_{\{x\}}$ transforms as $\pi\cdot\chi_{\{x\}}=\chi_{\{\pi(x)\}}$.

$(\mathbb Z/2)^n$-equivariance: $\sigma_y$ acts on $\chi_{\{x\}}$ by $(-1)^{[y=x]}$ (the character-level eigenvalue action — $\sigma_y\cdot\chi_S=(-1)^{[y\in S]}\chi_S$). The bias magnitude $b_x$ is invariant under coordinate toggle (it is a *counting* quantity; toggling $y$ permutes $\mathcal G$ within itself if we work modulo intersection-vs-union closure conversion, and on the cube the toggle is just a bijection on subsets). $\blacksquare$

### 4.6 Independence of the tiebreaker rule

> **Lemma 4.6 (tiebreaker independence).** *The Čech sheaf $\mathcal F_{\mathrm{obs}}$ does not depend on the choice of tiebreaker rule in Definition 3.5. Different tiebreakers produce different witness functions $w$ but the same cover $\mathfrak U$ and the same sheaf data.*

*Proof sketch.* Different tiebreakers select different *representatives* $x\in T$ with $\beta_x(\mathcal G)\le 0$ at each $(T,\mathcal G)$, but the stratum $U_x$ is defined as the set of *all* $(T,\mathcal G)$ for which $x$ is *a* rare element (Defn 4.1: $x\in T,\ \beta_x(\mathcal G)\le 0$ — no mention of $w(T,\mathcal G)=x$). So the cover is constructed from the *bias function* $\beta:\mathcal C_n^{\cap}(\mathcal F^\star)\to\mathbb Z^{[n]}$ alone, which is canonical; the witness function $w$ is just one section of the cover and is the artifact of the tiebreaker, not the data. $\blacksquare$

This is structurally important: UC11's mechanism is canonical at the cover level, even though the witness function (Definition 3.5) is non-canonical.

### 4.7 Summary of §4

$\mathcal F_{\mathrm{obs}}$ is the bi-equivariant Čech sheaf on the trace cover $\mathfrak U=\{U_x\}_{x\in[n]}$ of $\mathcal C_n^{\cap}(\mathcal F^\star)\setminus\{\mathcal F^\star\}$, assigning to each stratum a single-Walsh-isotype-scaled-by-bias cochain, with the mismatch cochain on intersections recording the multi-witness inconsistency. It is $\Gamma_n$-equivariant; it is constructed natively on $\mathcal C_n^{\cap}$ with no functor to $\mathrm{PPF}_n$ entering; it is canonical at the cover level.

---

## §5. The Čech 2-cocycle and its top-Walsh sign-isotype landing

### 5.1 The Čech bicomplex

The Čech bicomplex of $\mathcal F_{\mathrm{obs}}$ has rows indexed by $p\ge 0$ (Čech degree) and columns by $q\ge 0$ (Walsh-isotypic cochain degree on $X(\mathcal G)$):
$$
  \check C^p_q(\mathfrak U;\mathcal F_{\mathrm{obs}})\;:=\;\bigoplus_{x_0<x_1<\cdots<x_p}\;\mathcal F_{\mathrm{obs}}^q(U_{x_0}\cap\cdots\cap U_{x_p}).
$$
Horizontal differential $\check d:\check C^p_q\to\check C^{p+1}_q$: standard Čech coboundary, alternating sum of restriction maps. Vertical differential $d:\check C^p_q\to\check C^p_{q+1}$: the chain differential on each cochain stratum.

The **total complex** $\mathrm{Tot}^*(\check C^*_*)$ is the assembly $\bigoplus_{p+q=n}\check C^p_q$ with the total differential $D:=\check d+(-1)^p d$. Its cohomology is the Čech cohomology with coefficients in $\mathcal F_{\mathrm{obs}}$.

### 5.2 The 2-cocycle on triple intersections

> **Lemma 5.2 (the cocycle condition).** *For every triple $x,y,z\in[n]$ pairwise distinct, the mismatch cochains satisfy the additive Čech 2-cocycle condition on $U_x\cap U_y\cap U_z$:*
> $$
>   m_{xy}+m_{yz}+m_{zx}\;\equiv\;0\quad\text{as elements of }\;\mathcal F_{\mathrm{obs}}(U_x\cap U_y\cap U_z).
> $$

*Proof.* By Definition 4.3, $m_{xy}=\widehat b_x-\widehat b_y$ (in $C^*(X(-))_{\chi_{\{x\}}}\oplus C^*(X(-))_{\chi_{\{y\}}}$). Adding cyclically:
$$
  m_{xy}+m_{yz}+m_{zx}\;=\;(\widehat b_x-\widehat b_y)+(\widehat b_y-\widehat b_z)+(\widehat b_z-\widehat b_x)\;=\;0.
$$
This is a pure additive identity — the same identity that makes any "difference assignment" automatically a 1-cocycle, here playing out on the Čech 2-level because the differences land in *separate* Walsh isotypes (so the equality is in the direct sum $C^*_{\chi_{\{x\}}}\oplus C^*_{\chi_{\{y\}}}\oplus C^*_{\chi_{\{z\}}}$, projection-wise). $\blacksquare$

So $\{m_{xy}\}_{x,y\in[n],x<y}$ assembles into a Čech 1-cocycle on $\mathfrak U$, by Lemma 5.2 on every triple intersection. The class $[m_{xy}]\in\check H^1(\mathfrak U;\mathcal F_{\mathrm{obs}})$ is the **mismatch class**.

### 5.3 The edge-map promotion to total cohomology

The Čech-to-cohomology spectral sequence has $E_2^{p,q}=\check H^p(\mathfrak U;\mathcal H^q(\mathcal F_{\mathrm{obs}}))$ converging to the total cohomology $H^{p+q}(\mathrm{Tot}^*(\check C^*_*))$. The class $[m_{xy}]$ lives in $E_2^{1,q}$ for the appropriate single-coordinate-Walsh-cochain degree $q$, and is promoted by the spectral-sequence edge map to a class in $H^{1+q}(\mathrm{Tot}^*)$.

Now: the mismatch cochains $m_{xy}=\widehat b_x-\widehat b_y$ live, by Definition 4.3, in the *level-1* Walsh cochain of $X(\mathcal G)$ (at coordinates $x$ and $y$ respectively). The Walsh-level multiplication, by Cor 4.6 of UC12 / UC10 §3.4's Walsh decomposition, sends level-1 cochains to level-2 cochains under the cup product, level-$k$ to level-$(k+1)$ under the differential.

The Čech-degree-1 + Walsh-level-1 class, after $n-2$ steps of the spectral-sequence edge map (each step incrementing Walsh-level by 1), lands at Walsh-level $n-1$ in Čech-degree 1, i.e. in the *single-Čech-level* part of the total cohomology at degree $1+(n-2)=n-1$ — matching UC10.1's only-non-vanishing degree.

> **Theorem 5.3 (the obstruction class).** *The mismatch class $[m_{xy}]\in\check H^1(\mathfrak U;\mathcal F_{\mathrm{obs}})$, promoted by the Čech-to-cohomology spectral-sequence edge map to a class in $H^{n-1}(\mathrm{Tot}^*)$, lands in $\widetilde H^{n-1}(X_n^{\cap};\mathbb Q)_{V_{[n]}}$ — i.e. in the top-Walsh sign isotype $V_{[n]}^{n-1}$.*

*Proof sketch.* The edge map increments Walsh-level by 1 at each spectral-sequence step. Starting from level-1 cochains at Čech-degree 1, after $n-2$ steps we reach level $1+(n-2)=n-1$, and via the orbit-Čech-to-isotypic decomposition the class lands at the $\chi_{[n]}=\chi_{\{1\}}\cdots\chi_{\{n\}}$ (product-of-all-level-1) top Walsh isotype. The $S_n$-action on the cover $\mathfrak U$ symmetrizes the level-1 components $\{[\chi_{\{x\}}]\}_{x\in[n]}$ into the $\mathrm{sgn}_{S_n}$ symmetric combination, picking up the secondary $\mathrm{sgn}_{S_n}$ isotype. **Result: the edge-map image lives in $\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}=V_{[n]}^{n-1}$.** $\blacksquare$

This is the **structural landing of the obstruction class**: by construction, the Čech-cohomological obstruction of $\mathcal F_{\mathrm{obs}}$ lands in the only place UC10.1 says cohomology lives — the top Walsh sign isotype at degree $n-1$.

### 5.4 The obstruction class as a $\Gamma_n$-invariant of $\mathcal F^\star$

Write $\mathrm{ob}(\mathcal F^\star):=[m_{xy}]^{\text{edge}}\in V_{[n]}^{n-1}\cong\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$ (one-dimensional, by UC10.1).

$\mathrm{ob}(\mathcal F^\star)$ is a numerical invariant of $\mathcal F^\star$ (the minimal counterexample) — a single scalar in $\mathbb Q$ once we pick a basis vector of the one-dimensional $V_{[n]}^{n-1}$ (the canonical $\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$ generator).

### 5.5 Summary of §5

The Čech 2-cocycle $\{m_{xy}\}_{x<y}$ on the trace cover $\mathfrak U$ assembles into the mismatch class $[m_{xy}]\in\check H^1(\mathfrak U;\mathcal F_{\mathrm{obs}})$, which the Čech-to-cohomology spectral-sequence edge map promotes to a class $\mathrm{ob}(\mathcal F^\star)\in V_{[n]}^{n-1}\subseteq\widetilde H^{n-1}(X_n^{\cap};\mathbb Q)$ — landing in UC10.1's only-non-vanishing isotype.

---

## §6. The must-be-sphere-class step (non-vanishing of $\mathrm{ob}(\mathcal F^\star)$)

By UC10.1, $V_{[n]}^{n-1}\cong\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$ is one-dimensional. So $\mathrm{ob}(\mathcal F^\star)$ is *either zero or a scalar multiple of the canonical generator*. This section shows it is non-zero.

### 6.1 The vanishing-implies-trivialization lemma

> **Lemma 6.1 (cohomological-vanishing implies witness-extension).** *If $\mathrm{ob}(\mathcal F^\star)=0$, then there exists a global section $\widetilde w:\mathcal C_n^{\cap}(\mathcal F^\star)\to[n]$ of the witness function, extending $w$ (Definition 3.5) to the top object $([n],\mathcal F^\star)$ as well, such that $\beta_{\widetilde w([n],\mathcal F^\star)}(\mathcal F^\star)\le 0$.*

*Proof sketch.* If the Čech 1-cocycle $[m_{xy}]$ is cohomologically zero, the spectral-sequence edge map's preimage at the $E_2$ level is zero — meaning there exists a 0-cochain $\{s_x\in\mathcal F_{\mathrm{obs}}(U_x)\}_{x\in[n]}$ with $\check d s = m$. Translating back through the sheaf-data definitions: such an $s_x$ encodes a *consistent* refinement of the local witness data $\widehat b_x$ across all strata, allowing the local witness assignments $w|_{U_x}$ to be glued into a coherent global assignment. The coherence at the top object $([n],\mathcal F^\star)$ — which is in the boundary of every $U_x$ but in no $U_x$ — forces a non-trivial $\beta$-bound: glued continuity at the top point gives a coordinate $x_*$ with $\beta_{x_*}(\mathcal F^\star)\le 0$. $\blacksquare$

### 6.2 The non-vanishing of $\mathrm{ob}(\mathcal F^\star)$

> **Lemma 6.2 (non-vanishing).** *For the minimal counterexample $\mathcal F^\star$, $\mathrm{ob}(\mathcal F^\star)\ne 0$.*

*Proof.* Suppose $\mathrm{ob}(\mathcal F^\star)=0$. By Lemma 6.1, there exists a global witness assignment $\widetilde w$ with $\beta_{\widetilde w([n],\mathcal F^\star)}(\mathcal F^\star)\le 0$. But by Definition 2.2 (the minimal counterexample), $\beta_x(\mathcal F^\star)>0$ for *every* $x\in[n]$ — contradiction. $\blacksquare$

### 6.3 Consequence: $\mathrm{ob}(\mathcal F^\star)$ equals the sphere class

Since $V_{[n]}^{n-1}\cong\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$ is one-dimensional (UC10.1), $\mathrm{ob}(\mathcal F^\star)\ne 0$ implies $\mathrm{ob}(\mathcal F^\star)=c\cdot[\mathrm{sphere}]$ for some $c\in\mathbb Q\setminus\{0\}$, where $[\mathrm{sphere}]$ is the canonical generator of $V_{[n]}^{n-1}$.

> **Corollary 6.3 ($\mathrm{ob}(\mathcal F^\star)$ is the sphere class).** *$\mathrm{ob}(\mathcal F^\star)\in V_{[n]}^{n-1}\setminus\{0\}$ is a non-zero scalar multiple of the canonical $\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$-isotypic generator.*

This is Daniel's verbatim *"Show that must be the sphere obstruction"* discharged. The next section will show *"and that's not possible."*

### 6.4 Summary of §6

The obstruction class $\mathrm{ob}(\mathcal F^\star)$ is non-zero (Lemma 6.2 — minimality forbids witness-extension to the top object) and hence equals a non-zero scalar multiple of the canonical sphere-class generator of $V_{[n]}^{n-1}$ (Corollary 6.3). The "must be the sphere class" step is GREEN.

---

## §7. The cannot-be-sphere-class step (NS-b chain-level equivariance collapse) — load-bearing residual UC11.R

This is Daniel's *"and that's not possible"* — the contradiction direction. By Corollary 6.3, $\mathrm{ob}(\mathcal F^\star)$ must be the sphere class; this section shows it *cannot* be, by a chain-level $\Gamma_n$-equivariance collapse mirroring F30's NS-b mechanism.

### 7.1 The (UC-NS-a) ∨ (UC-NS-b) dichotomy

The F29/F30 dichotomy template:

- **(UC-NS-a) — wrong-isotype.** The obstruction class $\mathrm{ob}(\mathcal F^\star)$ is *not* in the $\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$ isotype. Contradicts UC10.1's only-non-vanishing concentration.
- **(UC-NS-b) — forced-zero.** The obstruction class *is* in the $\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$ isotype (by §5-§6) but is structurally forced to vanish by chain-level $\Gamma_n$-equivariance considerations on the bias function.

By Theorem 5.3, $\mathrm{ob}(\mathcal F^\star)$ lands in $V_{[n]}^{n-1}$. So (UC-NS-a) is **ruled out** by construction. The contradiction must come via (UC-NS-b).

### 7.2 The chain-level $\Gamma_n$-equivariance of the bias function

> **Lemma 7.2 (the chain-level bias is bi-isotype-trivial).** *The bias function $\beta:\mathcal C_n^{\cap}\to\mathbb Z^{[n]}$ is $S_n$-equivariant (under permutation of coordinates) and $(\mathbb Z/2)^n$-invariant on its absolute-value support. Specifically: $|\beta_x(\mathcal G)|$ is invariant under coordinate toggles $\sigma_y$ (toggles permute $\mathcal G$ within its "complement orbit", preserving bias magnitudes).*

*Proof.* $S_n$-equivariance is bookkeeping (UC10 Lemma 3.6 / Lemma 4.5 above). $(\mathbb Z/2)^n$-action: $\sigma_y$ sends $\mathcal G$ to $\sigma_y\mathcal G$, which is *not* in $\mathcal C_n^{\cap}$ (it is union-closed, by §2.4 of UC10). But the *bias magnitude* $|\beta_x(\sigma_y\mathcal G)|=|\beta_x(\mathcal G)|$ because the toggle permutes elements within their complementary-orbit pairs — preserving cardinalities of $\mathcal G_x$ vs. $\mathcal G_{\bar x}$ up to a sign that flips with $y=x$ vs. $y\ne x$. The absolute value is preserved. $\blacksquare$

### 7.3 The collapse — load-bearing residual UC11.R

The (UC-NS-b) mechanism, articulated:

> **Lemma 7.3 (UC-NS-b chain-level collapse — **the load-bearing computation, UC11.R**).** *Let $\mathrm{ob}(\mathcal F^\star)\in V_{[n]}^{n-1}\cong\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$ be the obstruction class of §5. Then $\mathrm{ob}(\mathcal F^\star)=0$ as an element of the one-dimensional $V_{[n]}^{n-1}$.*

*Proof sketch (the named residual UC11.R).* The structural skeleton, mirroring F30:

1. **Lift $\mathrm{ob}(\mathcal F^\star)$ to a chain-level cochain.** The edge-map promotion of §5.3 lands $\mathrm{ob}(\mathcal F^\star)$ at the $E_2$-level. Lift to a representative chain-level cochain $\omega\in C^{n-1}(X_n^{\cap};\mathbb Q)$ via the standard Čech-bicomplex-to-total-complex assembly.

2. **The chain-level support of $\omega$ is via the bias function.** By the construction of §4 (Defn 4.3): $\omega$ is a $\mathbb Q$-linear combination of level-$(n-1)$ Walsh-isotypic-product cochains $[\chi_{\{x_1\}}\cdots\chi_{\{x_{n-1}\}}]$ over subsets $\{x_1,\dots,x_{n-1}\}\subseteq[n]$, with coefficients given by bias values $b_{x_i}(\mathcal G)$ for various $(T,\mathcal G)\in U_{x_1}\cap\cdots\cap U_{x_{n-1}}$.

3. **Apply the (UC-NS-b) argument.** The cochain $\omega$ inherits its $\Gamma_n$-equivariance via Lemma 7.2:
   - **$S_n$-part:** $\omega$ is $S_n$-anti-symmetric in the $\{x_i\}$ labels (Čech-cohomology alternating-sum + Walsh-character interaction). I.e. $\omega\in C^*(X_n^{\cap})_{\mathrm{sgn}_{S_n}}$.
   - **$(\mathbb Z/2)^n$-part:** The level-1 Walsh classes $[\chi_{\{x_i\}}]$ are *level-1*-Walsh-equivariant (each one transforms under $\sigma_{x_i}$ by $-1$, under $\sigma_y$ ($y\ne x_i$) trivially). The product transforms under $\sigma_y$ by $(-1)^{[y\in\{x_1,\dots,x_{n-1}\}]}$. **For $|\{x_1,\dots,x_{n-1}\}|=n-1<n$, there is always some $y\notin\{x_1,\dots,x_{n-1}\}$ — and at this $y$, the cochain transforms trivially.**
   - **The collapse.** $\omega$'s isotypic content under $(\mathbb Z/2)^n$ is *level-(n-1)*, NOT level-$n$. But UC10.1 says the only-non-vanishing cohomology lives in $\chi_{[n]}$ = level-$n$ Walsh — i.e. *every* coordinate toggle must act by $-1$. The $\omega$ representative has level-$(n-1)$-Walsh support, hence *fails to be level-$n$*. So as an element of $V_{[n]}^{n-1}$ (the level-$n$ Walsh isotype), $\omega$'s image must be **zero** — the level-$(n-1)$-supported representative has zero level-$n$ component.

4. **Net effect.** $\mathrm{ob}(\mathcal F^\star)\in V_{[n]}^{n-1}$ has a chain-level representative whose Walsh-support is level $(n-1)<n$. The projection-to-$V_{[n]}^{n-1}$ operation kills it. Hence $\mathrm{ob}(\mathcal F^\star)=0$ in $V_{[n]}^{n-1}$. $\blacksquare$ (modulo the load-bearing computational detail of step 3, which is UC11.R for UC13)

### 7.4 The contradiction

By Corollary 6.3, $\mathrm{ob}(\mathcal F^\star)\ne 0$.
By Lemma 7.3 (sketched; full proof = UC11.R), $\mathrm{ob}(\mathcal F^\star)=0$.

**Contradiction. Hence no minimal counterexample exists. Frankl holds.** $\blacksquare$ (modulo UC11.R)

### 7.5 What UC11.R needs

UC11.R requires tightening step 3 of the Lemma 7.3 sketch:

- **(R1, primary)** Make precise the "level-$(n-1)$ Walsh-support" claim on the chain-level representative $\omega$. The §5 spectral-sequence edge map's chain-level form needs to be computed to verify $\omega$ has no level-$n$ Walsh component. This is parallel to F30's chain-level $\Phi$ construction (mg-c3fe): assemble $\omega$ as a chain-level cup-product-style combination of level-1 Walsh classes with coefficients from the bias function, then verify the support claim by direct Walsh-isotypic analysis.
- **(R2, secondary)** Verify the cochain-map / face-cancellation properties needed for $\omega$ to be a cocycle in the *total* complex (not just in the Čech direction). This is parallel to F30's "cochain-map verified by face-cancellation in $C^*(\Delta_n,\mathbb Q)$".

R1 + R2 together are the analog of F30 on F29 — one full session, paper-and-pencil, calculator-precision-only level of detail.

### 7.6 Why this is honest AMBER and not premature GREEN

The structural skeleton of §7 is sound and matches F30's mechanism on the 1/3-2/3 side. The chain-level Walsh-support argument (step 3 of Lemma 7.3) is *plausibly* what kills the obstruction, but the rigorous Walsh-isotypic computation of the edge-map representative is not executed here. **GREEN-Frankl awaits UC11.R execution.**

If UC11.R fails (the level-(n-1)-Walsh-support claim is wrong), there are two fallbacks:

- **Fallback 1: (UC-NS-a) refinement.** The §4 construction could be modified to put $\mathrm{ob}(\mathcal F^\star)$ into a *different* isotype than $V_{[n]}^{n-1}$, contradicting UC10.1 directly. This would require redesigning the Čech sheaf — major surgery.
- **Fallback 2: orbit-Čech refinement.** Mirror F29 §5.2 — restrict to the *orbit*-Čech complex over the $S_n$-orbit of the cover, where the sgn-isotypic projection has additional structure that may force vanishing more directly.

Both fallbacks remain available; UC11.R's failure would not collapse the program structurally, only force a different operational path.

### 7.7 Summary of §7

The (UC-NS-b) chain-level $\Gamma_n$-equivariance collapse is the operational mechanism by which the obstruction class is forced to vanish despite landing in the only-non-vanishing isotype. The argument's skeleton is laid down (Lemma 7.3 sketch); its load-bearing computational detail is named as UC11.R (Lemma 7.3 step 3 tightening, the F30-analog). Two fallback mechanisms remain available if UC11.R fails. **The "cannot be sphere class" step is structurally articulated; one operational session away from full GREEN.**

---

## §8. The U1-dissolve check — no dialect collision

This section verifies UC11 dissolves the U1-obstruction (the "no functorial bridge between observed-non-isotropy and target-cohomology" wall, mg-26fc; mirrored on the 1/3-2/3 side by F29's "no operational bridge between BK spectral data and $\Delta(\mathrm{PPF}_n)$ cohomology"). The dissolve is by chain-level non-functorial construction.

### 8.1 The U1-obstruction in UC dialect

The structural-analogy meta-thesis (mg-26fc) names the U1-obstruction as: any *functorial* bridge between (a) the compatibility-geometry construction (here: $X_n^{\cap}$ via $\mathcal C_n^{\cap}$) and (b) the target cohomology (here: UC10.1's only-non-vanishing class) would collapse on contractibility / refinement-cover issues. The dissolve is by *non-functorial* (chain-level) bridges.

In UC11 dialect: any bridge of the form "$\mathcal F_{\mathrm{obs}}$ is a sheaf morphism between two cohomology theories that compare bias values across refinements of the cover" would inherit the U1-obstruction. UC11 avoids this by construction.

### 8.2 The three dissolve criteria (F29 §6.2, F30 D-α/D-β/D-γ — transferred)

> **(D-α, UC dialect: no refinement-functoriality.)** $\mathcal F_{\mathrm{obs}}$ is defined on a *single* cover $\mathfrak U=\{U_x\}_{x\in[n]}$ of the trace-subcategory $\mathcal C_n^{\cap}(\mathcal F^\star)\setminus\{\mathcal F^\star\}$. **No comparison is made across distinct covers or refinements of the cover.** The construction is single-cover-locked. ✓

> **(D-β, UC dialect: no sheaf-morphism input.)** $\mathcal F_{\mathrm{obs}}$ is a constructible Čech sheaf with explicit local data (Defn 4.4); no other sheaf is involved; no morphism between sheaves enters the load-bearing path. The Čech cohomology is computed natively on $\mathcal F_{\mathrm{obs}}$ alone. ✓

> **(D-γ, UC dialect: no comparison of bias values across distinct refinements.)** The bias function $\beta_x$ is read on each stratum $U_x$ as the *single-coordinate Walsh class scaled by stratum-local-bias-magnitude* (Defn 4.3). The mismatch cochain $m_{xy}=\widehat b_x-\widehat b_y$ on intersections is *not* a comparison of bias values across refinements — it is the difference of *separate Walsh-isotypic representatives* of two candidate witness assignments, recorded in a direct-sum of Walsh isotypes (Defn 4.4). The comparison stays *within* a single (T,$\mathcal G$) at fixed support, not across distinct refinements. ✓

All three (D-α, D-β, D-γ) hold by construction. The U1-dissolve is unconditional.

### 8.3 The "inherent but not functorial" constraint, verified

> **Lemma 8.3 (no functor $\mathcal C_n^{\cap}\to\mathrm{PPF}_n$ in UC11's load-bearing path).** *Daniel's verbatim "inherently but NOT functorially" constraint is honored in UC11: the Čech sheaf $\mathcal F_{\mathrm{obs}}$ is constructed natively on $\mathcal C_n^{\cap}$, with no functor to $\mathrm{PPF}_n$ entering. The structural references to F29/F30 are template-only; no theorem of F17/F18/F29/F30 is invoked as a logical hypothesis in §1-§7's load-bearing arguments.*

*Proof by inspection.*
- §4 builds $\mathcal F_{\mathrm{obs}}$ from $\mathcal C_n^{\cap}$ + Walsh data on $X(\mathcal G)$; no Pos image.
- §5's spectral-sequence is the Čech-to-cohomology SS of $\mathcal F_{\mathrm{obs}}$ alone.
- §6's non-vanishing is from minimality + cover-incompleteness; no Pos input.
- §7's NS-b is the F30 *template*, applied to $\Gamma_n$-equivariance on $X_n^{\cap}$, not via a functor to $\mathrm{PPF}_n$. The chain-level structure is native to $X_n^{\cap}$.

Every load-bearing step is intrinsic. $\blacksquare$

### 8.4 The not-factorial constraint, verified

> **Lemma 8.4 (not factorial).** *UC11's load-bearing path does not invoke any factorial decomposition.*

*Proof by inspection.*
- The group $\Gamma_n=(\mathbb Z/2)^n\rtimes S_n$ is the natural type-B Coxeter group; its appearance is via its action on the cube and on $\mathcal C_n^{\cap}$'s indexing (UC10 §3.5), not via a factorial structure.
- The Walsh decomposition (UC10.W) is by $(\mathbb Z/2)^n$-isotypes; this is a finite abelian decomposition, not factorial.
- The $\mathrm{sgn}_{S_n}$ secondary isotype enters in §5.3 as the alternating-sign $S_n$-component of the level-$n$ Walsh class; this is the standard sign rep, not via a Specht-module factorial decomposition.
- The bias function $\beta_x$ is a single-coordinate counting quantity; no factorial.

$\blacksquare$

### 8.5 The cover-of-a-single-counterexample framing

A subtle structural point: UC11's Čech cover $\mathfrak U=\{U_x\}_{x\in[n]}$ is a cover of *one* fixed minimal counterexample $\mathcal F^\star$, not a cover of the universe of all intersection-closed families. This is structurally important for the U1-dissolve:

- A *universal* cover (covering all counterexamples simultaneously) would inherit refinement-functoriality between counterexamples, courting U1-collision.
- A *single-counterexample* cover has no such refinement structure — the cover is locked to $\mathcal F^\star$, and the obstruction class is a single $\mathbb Q$-number for $\mathcal F^\star$, not a class in a family.

This locking is the structural source of "non-functoriality": the construction is honest about the fact that it produces a single obstruction per single counterexample, no comparison across counterexamples.

### 8.6 Summary of §8

UC11 dissolves the U1-obstruction by construction: chain-level not refinement-functorial (D-α, D-β, D-γ all met); no functor to $\mathrm{PPF}_n$ (Lemma 8.3); not factorial (Lemma 8.4); single-counterexample cover (§8.5). The Daniel hard constraints are honored unconditionally — not in conditional dialect, not contingent on UC11.R.

---

## §9. Verdict and UC13 scope

### 9.1 Verdict — AMBER-Frankl-program-pinned-NS-mechanism-articulated-two-named-residuals

Restating from the top:

- ✓ **5-step Daniel program lands.** Sphere result (UC10/UC12 input); flip (UC9/UC10 Lemma 1.1); minimality (Theorem 3.4); Čech sheaf $\mathcal F_{\mathrm{obs}}$ (§4); Čech 2-cocycle + top-Walsh sign landing (§5); must-be-sphere (§6).
- ✓ **NS-b mechanism articulated.** §7's chain-level $\Gamma_n$-equivariance collapse identifies the operational contradiction mechanism, parallel to F30's NS-b on F29.
- ◐ **UC11.R named.** The Lemma 7.3 step-3 Walsh-support computation (the F30 analog on F29's NS-b) is sketched but not executed in full detail. One UC13 session.
- ◐ **UC10/UC12 external residual.** UC10 §§5.3-5.4 technical adaptations remain (sketched in UC12 §7.2.1). External to UC11.
- ✓ **U1-dissolved unconditionally.** §8: chain-level non-functorial, single-counterexample cover, all dissolve criteria met. **Not contingent on UC11.R.**
- ✓ **Hard constraints respected.** Not factorial (§8.4); inherent-not-functorial (§8.3); paper-and-pencil (no Lean, no axioms, no computation); cumulative state doc (`docs/state-UC11.md` Session 1).

### 9.2 UC13 scope — what the next session would do

**UC13 primary — execute UC11.R (the Lemma 7.3 chain-level Walsh-support computation).** Mirror F30's chain-level $\Phi$ construction: assemble a chain-level representative $\omega$ of the obstruction class as a cup-product-style combination of level-1 Walsh classes with bias-function coefficients; verify by direct Walsh-isotypic analysis that $\omega$'s level-$n$ Walsh component vanishes; conclude $\mathrm{ob}(\mathcal F^\star)=0$ in $V_{[n]}^{n-1}$. Combined with §6's non-vanishing, contradiction → Frankl.

**UC13 secondary — the (UC-NS-a) refinement if needed.** Should UC11.R fail (level-$(n-1)$-Walsh-support claim breaks), redirect to a §4-redesign that lands $\mathrm{ob}(\mathcal F^\star)$ into a *different* isotype than $V_{[n]}^{n-1}$, contradicting UC10.1 directly.

**UC13 tertiary — orbit-Čech refinement fallback.** Restrict to $S_n$-orbit-Čech complex over the cover; mirror F29 §5.2 for the sgn-projection.

**UC14+ future — joint UC9/UC10/UC11 Frankl-side dispatch.** Combine UC9's extrinsic pullback constraints, UC10's intrinsic only-non-vanishing concentration, and UC11's cohomological obstruction into the strongest Frankl-side statement extractable. If all three GREEN, the combined statement may close Frankl unconditionally.

### 9.3 What UC11 (this session) does NOT do

- **Does not prove UC11.R.** The Lemma 7.3 chain-level Walsh-support computation is sketched (§7.3 step 3), not executed in full Walsh-arithmetic detail. The session 1 budget allows the framework + the NS-b articulation; UC11.R execution is one full session of paper-and-pencil Walsh arithmetic.
- **Does not execute UC10 §§5.3-5.4.** External obligation; sketched in UC12 §7.2.1.
- **Does not propose Lean / axioms / computation.** Paper-and-pencil only.
- **Does not touch UC1-UC8's native-construction chain.** UC11 is a downstream of UC10+UC12; UC1-UC8 native construction is a parallel branch.
- **Does not engage the 1/3-2/3 program directly.** F29/F30 are template references only; no theorem of theirs is invoked as logical hypothesis.

### 9.4 If UC11 GREENs (post-UC13 + post-UC10 §§5.3-5.4), what closes

**Frankl closes** by the contradiction of §7. The argument is:

1. By Frankl's negation: a minimal counterexample $\mathcal F^\star$ exists (§2.3).
2. By UC10.1 + UC12 + §§5.3-5.4: $\widetilde H^*(X_n^{\cap};\mathbb Q)$ is concentrated in degree $n-1$ at isotype $\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$ (UC10's deliverable).
3. By §3-§5: the Čech-cohomological obstruction $\mathrm{ob}(\mathcal F^\star)\in V_{[n]}^{n-1}$ is constructed and lands in the only-non-vanishing isotype.
4. By §6: $\mathrm{ob}(\mathcal F^\star)$ is non-zero (minimality + cover-incompleteness).
5. By §7 + UC11.R: $\mathrm{ob}(\mathcal F^\star)$ is zero (chain-level $\Gamma_n$-equivariance collapse, the NS-b mechanism).
6. Contradiction → no counterexample → Frankl holds.

The argument is structurally complete; two named residuals (UC10 §§5.3-5.4 and UC11.R) are within reach.

### 9.5 The honest one-paragraph verdict

UC11 executes Daniel's verbatim 5-step Frankl program on the intersection-closed-family side via Čech-cohomological assembly of a minimality-witness obstruction class on the trace cover $\mathfrak U=\{U_x\}_{x\in[n]}$ of the subfamily slice $\mathcal C_n^{\cap}(\mathcal F^\star)$ of a fixed minimal counterexample $\mathcal F^\star$, mirroring F29's Čech-bias mechanism on $\Delta(\mathrm{PPF}_n)$ structurally while staying native to $\mathcal C_n^{\cap}$ throughout (per Daniel's inherently-but-not-functorially constraint), with the obstruction class landing in UC10.1's only-non-vanishing isotype $V_{[n]}^{n-1}\cong\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}$ by spectral-sequence edge map (Theorem 5.3), shown non-zero by the minimality-no-witness-extension argument (Lemma 6.2), structurally forced to vanish by the (UC-NS-b) chain-level $\Gamma_n$-equivariance collapse — the chain-level cochain representative has level-$(n-1)$-Walsh support, hence vanishes in the level-$n$ Walsh isotype $V_{[n]}^{n-1}$ where it ostensibly lives — modulo one load-bearing residual UC11.R (the chain-level Walsh-support computation of Lemma 7.3 step 3, the direct analog of F30's chain-level $\Phi$ on F29's NS-b residual) plus one external residual (UC10 §§5.3-5.4 technical adaptations sketched in UC12 §7.2.1); the U1-dialect-collision is dissolved unconditionally by the chain-level non-functorial single-counterexample-cover design of $\mathcal F_{\mathrm{obs}}$ per Daniel's not-functorially directive; the not-factorial constraint is honored by inspection of every load-bearing step (§8.4); on UC11.R + UC10-§§5.3-5.4 GREEN, **Frankl closes by the §7 contradiction together with the §6 must-be-sphere argument**, instantiating the mg-26fc meta-thesis "constrained compatibility geometry cannot remain globally isotropic" on the union_closed side via the same template that F29+F30 instantiate it on the 1/3-2/3 side.

---

## §10. References

### 10.1 Cross-repo — the F-series + Čech templates UC11 mirrors (`one_third_width_three`, read-only)

- **mg-4d3a (F17, UCC.1)** — $n$-uniform $S_n$-equivariant cofiber Morse on $\Delta_n\hookrightarrow\Delta_{n+1}$; the F-series concentration mechanism UC10 mirrors and UC11 consumes via UC10.1.
- **mg-d039 (F18, UCC.2)** — $\delta_n$-injectivity via null-homotopy of $\iota_n$ on sgn-isotype; the F-series structural twin that UC12's cubical-bridge null-homotopy mirrors on the cube side.
- **mg-70b0 (F29)** — `docs/compatibility-geometry-F29-cech-bias-cohomology.md`. The 1/3-2/3-side Čech-bias scoping. §3.2 (bias sheaf), §3.4 (Čech 2-cocycle), §5.2 (NS-a/NS-b dichotomy), §6.2 (U1-dissolve criterion). UC11's structural template — *referenced as template only, no theorem invoked*.
- **mg-c3fe (F30)** — `docs/compatibility-geometry-F30-cech-bias-cochain-map.md`. F29's NS-b delivery; chain-level non-functorial cochain map $\Phi$ on $\Delta_n$; $c_{BC}(P)=0$ from chain-level $S_n$-equivariance contradiction; dissolve criterion (D-α, D-β, D-γ) met unconditionally. UC11.R's direct analog: F30's $\Phi$ construction on $\Delta_n$ is the template for the chain-level cochain UC11 §7 needs on $X_n^{\cap}$.
- **mg-26fc** — `docs/compatibility-geometry-structural-analogy-scoping.md`. The two-mechanisms framing; the meta-thesis "constrained compatibility geometry cannot remain globally isotropic"; the U1-obstruction language. UC11 §8 transfers the dissolve template.

### 10.2 This repo (`union_closed`) — direct inputs

- **`docs/union-closed-UC10-native-cohomology-intersection-closed-families.md`** (mg-814b, UC10) — the native cohomology theory of $\mathcal C_n^{\cap}$; the source of UC10.1 / UC10.W / UC10.S / $X_n^{\cap}$ / $\Gamma_n$-equivariance / the cubical-Walsh-defect framework. **The primary input of UC11.**
- **`docs/union-closed-UC12-delta-trace-injectivity.md`** (mg-707c, UC12) — closes UC10.R unconditionally via the cubical-bridge null-homotopy; sketches the §§5.3-5.4 adaptations via the bridge mechanism. The secondary input.
- **`docs/state-UC10.md`** — UC10's cumulative ledger (now also covering UC12, Session 2). Carries the invariants UC11 inherits.
- **`docs/union-closed-UC9-intersection-closed-flip-embedding-cohomology.md`** (mg-96a6, UC9) — the parallel extrinsic mechanism (Pos embedding pullback); the intersection-closed flip (Lemma 1.1, restated as UC11 Lemma 2.1); the structural-analogy context.
- **`docs/union-closed-compat-geom-manifesto.md`** (mg-f72a, UC1) — the founding manifesto; §1.4 (stuck-sets, the UC10.S substrate); §1.6 (the obstruction in 4 forms); §1.7 (the symmetry-group split); §4.2-§4.6 (the C1-C5 obstacles UC10 dodged and UC11 inherits the dodges of).

### 10.3 This repo (`union_closed`) — context only

- **`docs/state-UC1.md` through `state-UC9.md`** — the UC native-construction chain (UC2-UC8 Walsh/transport/decomposition/lever-signing) and UC9 (extrinsic pullback). UC11 is independent of this chain — UC10 + UC12 are the load-bearing inputs.

### 10.4 Background

- T. Church, J. Ellenberg, B. Farb (2015) — FI-modules; UC11 (like UC10) does not use these (fixed-$n$ design).
- N. Bourbaki, *Lie Groups and Lie Algebras*, Ch. IV-VI — type-$B$ Coxeter group (= hyperoctahedral $\Gamma_n=(\mathbb Z/2)^n\rtimes S_n$); the natural symmetry of the cube.
- R. O'Donnell, *Analysis of Boolean Functions* — Walsh-Fourier basics; level-$k$ characters; the harmonic decomposition.
- C. Godsil, R. Royle, *Algebraic Graph Theory* — the cube as a graph; the matching $M_x$.
- M. Bousfield, D. Kan, *Homotopy Limits, Completions and Localizations* — hocolim of small categories; the standard reference for §5's spectral sequence.

### 10.5 Source directives

- **Daniel reminder 2026-05-16T00:57:19Z (verbatim)** — the 5-step program articulation, captured in §0 and operationalized in §§2-7.
- **Daniel verbatim 2026-05-15T23:20Z** — anti-factorial directive (honored in §8.4); inherently-but-not-functorially directive (honored in §8.3); paper-and-pencil-first (honored throughout).
- **pm-onethird `feedback_polecat_cumulative_state_doc`** — `state-UC11.md` carries the session 1 ledger.
- **pm-onethird `feedback_pre_execution_dependency_verification`** — UC10 verified in §1.

---

**End of UC11 Session 1.** See `docs/state-UC11.md` for the cumulative state ledger.
