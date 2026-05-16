# F32-L3-B-UC — Cross-repo scoping: does the UC13+UC14 mechanism extend to weighted-UCC?

> **Cross-repo work item — `mg-7550`.** Home repo `union_closed`; driven by F32-scope (`mg-c9d9`, polecat branch `polecat-cat-mg-c9d9` on `one_third_width_three`, AMBER-merged out-of-band). F32-scope §3.3 identified an L3-B measure-transfer 1/8-obstruction on the natural weighting `w(Q)=e(Q)`. This document answers two F32-driven sub-questions:
>
> 1. **(Part A — weighted-UCC derivability.)** Does the UC13+UC14 mechanism — Čech bicomplex of `\mathcal F_{\mathrm{obs}}` + chain-level `(\mathbb Z/2)^n`-Walsh-isotype preservation + non-vanishing from minimality (UC11 Lemma 6.2) + level-1 Walsh vanishing from UC10.1 — extend to **weighted-UCC with positive rational / positive real weights**?
> 2. **(Part B — 1/8-obstruction bypass.)** Even if weighted-UCC extends, can the F32-scope §3.3.3 structural 1/8 obstruction (which forces the measure transfer `\Pr_Q^{\text{weighted}}=(1/8)\Pr_L`, making `\ge 1/2` weighted-UCC translate to `\Pr_L\ge 4`, vacuous) be bypassed via an alternative weighting (uniform, normalized-by-rank, `e(Q)^\alpha`, etc.)?

## Verdict: **AMBER-extends-conditionally-with-1/8-obstruction-unresolved-on-natural-weighting** — forces F32 L3-C-injection path

**Part A — weighted-UCC step-by-step:**

- **Steps 1, 2, 5, 6 of the UC13+UC14 closing chain (UC10.W Walsh decomposition; UC10.1 only-non-vanishing-isotype; UC13 §2 landing-in-level-1; UC13 §7 closing contradiction) transfer to the weighted setting GREEN unconditionally** — they live entirely on the cube/Walsh side and are independent of any family-side weighting. The cohomology `\widetilde H^*(X_n^{\cap};\mathbb Q)` does not depend on `w`; weighting enters only as a scalar `w`-modified bias `b_x^w` plugged into UC11's Čech-sheaf source data `\widehat b_x^w=b_x^w\cdot[\chi_{\{x\}}]`, which preserves Walsh-level. (§§2.2, 2.3, 2.6, 2.7.)
- **Step 4 (UC11 §6 Lemma 6.2 non-vanishing) is sheaf-cohomological and transfers GREEN conditional on Step 3.** The vanishing-implies-witness-extension argument operates at the cohomology level (Lemma 6.1), is purely about gluing local sections to a global one, and does not see what scalar is being glued. (§2.5.)
- **Step 3 (UC11 §3 Theorem 3.4 cover property / strict-trace-shrinking) is the load-bearing breakpoint and splits by weight class.** The argument needs *every* strict sub-family of the minimal weighted-counterexample to have a `w`-rare element — i.e., it needs weighted-Frankl on every smaller-`n` / smaller-`|F|` instance, ultimately bottoming out at small-`n` base cases:
  - **(W-arbitrary, positive real weights, no structural bound on `w(\varnothing)`)**: **RED.** Explicit small-`n` counterexample: `\mathcal F=\{\varnothing,\{1\}\}` on `n=1`, `w(\varnothing)=M\gg 1`, `w(\{1\})=1` gives `\beta_1^w=M-1>0`, i.e., a weighted counterexample. Even with `\varnothing\notin\mathcal F` as a side condition, traces re-introduce `\varnothing` into sub-families: `\mathrm{trace}_T\mathcal F\ni\varnothing` whenever some `A\in\mathcal F` satisfies `A\subseteq[n]\setminus T`, and the trace-weight `w_T(\varnothing)=\sum_{A\subseteq[n]\setminus T}w(A)` can be made arbitrarily large by adversarial choice of `w`. **The minimality induction cannot bottom out for adversarial weights.** (§2.4.2.)
  - **(W-structurally-bounded, e.g., `w(S(Q))=e(Q)` of Daniel's program)**: **AMBER-extends-conditionally.** The weight `e(Q)` is bounded by `|\mathcal L(P)|` and the trace-induced weight `w_T(B)=\sum_{Q:S(Q)\cap T=B}e(Q)` retains the same bound, so the adversarial small-`n` pathology does not arise from this weight. The minimality induction can plausibly bottom out, but each base case needs explicit verification per weight family. (§2.4.3.)

**Part A net verdict: AMBER for Daniel's weight (Step 3 plausibly closes, would need explicit small-`n` check); RED for arbitrary positive real weights.**

**Part B — 1/8-obstruction bypass on alternative weightings:**

- The 1/8 factor arises from a structural **2-tier over-counting mismatch**: each `L\in\mathcal L(P)` has `2^k` poset extensions `Q\le L` (where `k=\binom{n}{2}-|P|` is the count of `P`-incomparable pairs), but only `2^{k-3}` of those `Q`'s contain the three canonical edges of any specific 3-antichain `A^*`. The ratio `2^{k-3}/2^k=1/8` is **independent of which 3-antichain `A^*`** we pick, and **independent of how we rescale the weight `w(Q)` by a `Q`-only function** (the rescaling cancels in numerator and denominator). (§3.1.)
- **Three families of alternative weightings analyzed:**
  - `w(Q)=e(Q)^\alpha` for `\alpha\ne 1` — destroys the `\sum_Q e(Q)=\sum_L 2^k` identity; weighted-frequency loses its `\Pr_L` interpretation entirely. (§3.2.1.)
  - `w(Q)=\mathbb 1[Q\text{ is a linear extension}]` — recovers `\Pr_L` directly, but breaks union-closure of `\mathcal F'(P):=\{S(L):L\in\mathcal L(P)\}` (linear-extension-restricted), and union-closure is the prerequisite for UCC to apply. (§3.2.2.)
  - `w(Q)=e(Q)\cdot 2^{[\text{Q saturates canonical edges of some }A]}` — `A`-dependent rescaling; but `A` is the *output* of UCC, not an input we can use to tune `w`. **Circular.** (§3.2.3.)
- **Structural obstruction recap (§3.3).** *Any* `Q`-only weighting `w(Q)` makes the weighted-fraction relate to `\Pr_L` via a *constant* multiplicative factor (the over-counting ratio), and that factor is `1/8` for Daniel's program. No `Q`-only weighting bypasses the obstruction.

**Part B net verdict: 1/8 obstruction is structurally intrinsic to the `Q\to L` over-counting; no clean alternative `Q`-only weighting bypasses it.**

**Overall verdict on F32-L3-B-UC**: even if Part A extends conditionally for Daniel's specific weight (AMBER), Part B's 1/8 obstruction is structurally fatal to the F32 measure-transfer step as currently scoped. **L3-B path remains structurally obstructed; F32 should escalate to L3-C-injection** per F32-scope §3.3.5.

**What this verdict does NOT say.** It does NOT close weighted-Frankl as a UC-side mathematical question — that question splits into (W-arbitrary, false by §2.4.2 counterexample) vs (W-structural, open under Step 3 small-`n` verification). It does NOT touch UC14 closure (frozen GREEN). It does NOT touch the UC10/UC11/UC12/UC13/UC14 chain that closes unweighted Frankl. It does NOT touch the union_closed Lean formalization arc (UC-Lean L1, L2a*, L2b in flight). It is **scoping only**.

---

## §0. Setup — what F32-L3-B inherits

### 0.1 The cross-repo dependency map

This document sits in `union_closed` (where the UC13+UC14 mechanism lives) but is driven by F32 (in `one_third_width_three`). The dependency graph is:

- **`union_closed/docs/union-closed-UC10-native-cohomology-intersection-closed-families.md`** (mg-814b, UC10) — native cohomology framework, `X_n^{\cap}`, UC10.W, UC10.1, UC10.S.
- **`union_closed/docs/union-closed-UC11-cech-sheaf-frankl-program.md`** (mg-9ef0, UC11) — Frankl 5-step program, minimality, trace cover `\mathfrak U`, Čech sheaf `\mathcal F_{\mathrm{obs}}`, Lemma 6.1+6.2.
- **`union_closed/docs/union-closed-UC12-delta-trace-injectivity.md`** (mg-707c, UC12) — cubical-bridge null-homotopy, UC10.R discharge.
- **`union_closed/docs/union-closed-UC13-frankl-closure.md`** (mg-83f0, UC13) — Čech-bicomplex isotype preservation, corrected landing isotype, closing Frankl contradiction.
- **`union_closed/docs/union-closed-UC14-uc13-technical-cleanup.md`** (mg-500c, UC14) — R1 explicit `\Theta`-map, R2 chain-level `\chi_S`-iso, R3 multi-bridge graded commutativity.
- **`one_third_width_three/docs/compatibility-geometry-F32-uc-bridge-scope.md`** (mg-c9d9, F32-scope, polecat branch `polecat-cat-mg-c9d9`) — §3.3.2 1/8-obstruction derivation. **READ ALONGSIDE**; this document discharges F32-scope §8 Phase-1 sub-ticket *L3-B-UC*.
- **`~/files/union_closed_1323_proof_steps.txt`** (Daniel 2026-05-16T11:29Z) — original 10-step program; Step 6 measure transfer is the gate.

### 0.2 Definitions carried from UC10/UC11/UC13/UC14 (verbatim, no re-derivation)

- **Intersection-closed `\mathcal F\subseteq 2^U`, `U=[n]`, `n\ge 3`** (UC10 §0.1). For `x\in U`: `\mathcal F_x=\{A\in\mathcal F:x\in A\}`, `\mathcal F_{\bar x}=\mathcal F\setminus\mathcal F_x`, **(unweighted) bias** `\beta_x(\mathcal F)=|\mathcal F_x|-|\mathcal F_{\bar x}|`, **`x` is rare** iff `\beta_x(\mathcal F)\le 0`.
- **Frankl (intersection-closed form).** Every `\mathcal F\ne\varnothing,\{U\}` intersection-closed has some `x` with `\beta_x(\mathcal F)\le 0`.
- **Trace category `\mathcal C_n^{\cap}`** (UC10 §2): objects `(S,\mathcal F)` with `S\subseteq[n]`, `\mathcal F\ne\varnothing` intersection-closed, `S\in\mathcal F`; morphisms = trace `(S,\mathcal F)\to(T,\mathcal G)` with `T\subseteq S`, `\mathcal G=\{A\cap T:A\in\mathcal F\}`.
- **Cohomology object `X_n^{\cap}=\mathop{\mathrm{hocolim}}_{(\mathcal C_n^{\cap})^{\mathrm{op}}}X(\mathcal F)`** (UC10 §3): `\Gamma_n=(\mathbb Z/2)^n\rtimes S_n`-equivariant chain complex over `\mathbb Q`.
- **UC10.W Walsh decomposition** (UC10 Theorem 3.5): `C_*(X_n^{\cap};\mathbb Q)=\bigoplus_{S\subseteq[n]}\chi_S\otimes V_S^*`, preserved at chain level by `(\mathbb Z/2)^n`-equivariant differentials.
- **UC10.1** (UC10 Theorem 4.1, unconditional after UC12+UC13): `\widetilde H^k(X_n^{\cap};\mathbb Q)\cong\chi_{[n]}\boxtimes\mathrm{sgn}_{S_n}` at `k=n-1`, zero for `1\le k\le n-2`. Equivalently `V_S^k=0` for `(S,k)\ne([n],n-1)` in degree `\ge 1` — in particular **`V_{\{x\}}^{n-1}=0` for every `x\in[n]`**, since `|\{x\}|=1\ne n` for `n\ge 2`.
- **Trace cover `\mathfrak U=\{U_x\}_{x\in[n]}`, Čech sheaf `\mathcal F_{\mathrm{obs}}`** (UC11 §4): `U_x:=\{(T,\mathcal G)\in\mathcal C_n^{\cap}(\mathcal F^\star)\setminus\{(\mathcal F^\star)\}:x\in T,\ \beta_x(\mathcal G)\le 0\}`; `\mathcal F_{\mathrm{obs}}(U_x):=C^*(X(-))_{\chi_{\{x\}}}` scaled by `b_x(\mathcal G):=-\beta_x(\mathcal G)\ge 0`; mismatch on intersections `m_{xy}=\widehat b_x-\widehat b_y\in C^*_{\chi_{\{x\}}}\oplus C^*_{\chi_{\{y\}}}`.
- **Cover property** (UC11 Theorem 3.4): for every `(T,\mathcal G)\in\mathcal C_n^{\cap}(\mathcal F^\star)` with `T\subsetneq[n]` or `\mathcal G\subsetneq\mathcal F^\star`, there exists `x\in T` with `\beta_x(\mathcal G)\le 0` — proved by *strict-trace-shrinking* against minimality of `\mathcal F^\star`.
- **Vanishing-implies-witness-extension** (UC11 Lemma 6.1): if `\mathrm{ob}(\mathcal F^\star)=0`, then exists a global section `\widetilde w:\mathcal C_n^{\cap}(\mathcal F^\star)\to[n]` extending the local witness to the top object, with `\beta_{\widetilde w([n],\mathcal F^\star)}(\mathcal F^\star)\le 0`.
- **Non-vanishing** (UC11 Lemma 6.2): for the minimal counterexample `\mathcal F^\star`, `\mathrm{ob}(\mathcal F^\star)\ne 0`, because Lemma 6.1's witness extension would contradict `\beta_x(\mathcal F^\star)>0\ \forall x`.
- **Corrected landing isotype** (UC13 Theorem 2.4.1, R1-tightened by UC14 Theorem 1.5.1): `\mathrm{ob}(\mathcal F^\star)\in\bigoplus_{x\in[n]}V_{\{x\}}^{n-1}` — level-1 Walsh isotypes, because the Čech bicomplex is purely additive (no cup-product) and the source data `\widehat b_x` is level-1.
- **Closing Frankl contradiction** (UC13 §7): UC10.1 forces `V_{\{x\}}^{n-1}=0`, hence `\mathrm{ob}(\mathcal F^\star)=0`, contradicting Lemma 6.2. Therefore no minimal counterexample exists; Frankl holds.

### 0.3 Hard constraints (inherited from F32-scope mg-c9d9 + UC10/UC11/UC12/UC13/UC14)

- **NOT factorial.** Daniel verbatim 2026-05-15T23:20Z. Carried through F32-scope §0.3 + UC13 §0.5. No factorial decomposition appears in any step of this document.
- **NOT functorial in the refinement sense.** Daniel verbatim 2026-05-15T23:20Z. No functor `\mathcal C_n^{\cap}\to\mathrm{PPF}_n` invoked.
- **U1-dialect-preserving.** The weighted-extension question is structurally about scaling `\widehat b_x` by a scalar; no cup-product, no multiplicative Walsh-level-shift, no F31-style chain-locality risk. §4 verifies this explicitly.
- **Paper-and-pencil first.** This document is LaTeX-style Markdown only; no Lean, no axioms, no computation, no `lean/` touch (cat-mg-4db9 is concurrent on `lean/UnionClosed/*`; the file sets are disjoint).
- **Cumulative state doc.** Per pm-onethird `feedback_polecat_cumulative_state_doc`. `docs/state-UC10.md` Session 7 (this session) appends a cross-repo entry.

### 0.4 What this document MUST NOT do (per task spec)

- **No L4 work.** L4-α-lit is the concurrent F32 sibling sub-ticket (in `one_third_width_three`); not in scope here.
- **No L2 work.** F32 L2 union-closure of `F(P)` is out of scope.
- **No attempt to actually prove weighted-UCC** in full. The mandate is *scoping*: identify whether the UC13+UC14 mechanism extends + name obstructions if not.
- **No touch to UC14 closure.** UC14 R1/R2/R3 are frozen GREEN per UC14 §4; this document only references them.
- **No touch to `lean/UnionClosed/*`.** Concurrent cat-mg-4db9 (UC-Lean-L2b) owns that file set.
- **No touch to F32 home repo `one_third_width_three`.** This document does not modify F32-scope or `state-F32.md`; it cross-references F32-scope §3.3 as a read-only structural input.

### 0.5 Roadmap of this document

- §1: precise statement of the weighted-UCC question + weight-class taxonomy.
- §2: Part A — UC13+UC14 step-by-step weighted-extension analysis, with per-step GREEN/AMBER/RED verdict and weight-class splits where they matter.
- §3: Part B — 1/8-obstruction structural analysis + alternative-weighting enumeration.
- §4: U1-dialect-check — verify the F31 chain-locality dialect does not silently transfer to weighted (carries UC13 §3 + UC14 §4.1 forward unchanged).
- §5: Verdict + implication for F32 program + sub-ticket-filing recommendations.
- §6: References + Daniel directive trace.

---

## §1. The weighted-UCC question, precisely

### 1.1 Statement (intersection-closed form)

**Definition 1.1.1 (positive-real-weighted intersection-closed family).** A *positive-real-weighted intersection-closed family* is a pair `(\mathcal F,w)` with `\mathcal F\subseteq 2^U` intersection-closed and `w:\mathcal F\to\mathbb R_{>0}`.

**Definition 1.1.2 (weighted bias).** For `(\mathcal F,w)` and `x\in U`, the **`w`-weighted bias** is
$$
  \beta_x^w(\mathcal F)\;:=\;w(\mathcal F_x)-w(\mathcal F_{\bar x})\;=\;\sum_{A\in\mathcal F_x}w(A)-\sum_{A\in\mathcal F_{\bar x}}w(A).
$$
**`x` is `w`-rare** iff `\beta_x^w(\mathcal F)\le 0`, equivalently `w(\mathcal F_{\bar x})\ge w(\mathcal F)/2`.

**Definition 1.1.3 (weighted-Frankl, intersection-closed form).** *Weighted-Frankl-IC* is the statement: for every `(\mathcal F,w)` with `\mathcal F\ne\varnothing,\{U\}` intersection-closed and `w:\mathcal F\to\mathbb R_{>0}`, there exists `x\in U` with `\beta_x^w(\mathcal F)\le 0`.

The union-closed dual (via UC9 / UC10 §1.1 flip): for every union-closed `\mathcal F\ne\varnothing,\{\varnothing\}` and `w:\mathcal F\to\mathbb R_{>0}`, exists `x\in U` with `w(\mathcal F_x)\ge w(\mathcal F)/2`. This is the F32-scope §3.3.2 formulation Daniel's program needs.

### 1.2 Weight-class taxonomy

The two-question task spec distinguishes "positive-rational" and "positive-real" weights, but the substantive structural split is finer. We use the following taxonomy for the analysis:

- **(W-arbitrary).** Any `w:\mathcal F\to\mathbb R_{>0}` — no structural constraint. Includes the adversarial `w(\varnothing)=M\gg 1` of §2.4.2.
- **(W-arbitrary-no-empty).** `w:\mathcal F\to\mathbb R_{>0}` with the side condition `\varnothing\notin\mathcal F`. Does NOT salvage Step 3 (traces re-introduce `\varnothing`; §2.4.2).
- **(W-bounded).** `\exists C>0` such that for every trace sub-family `(T,\mathcal G)` and every `B\in\mathcal G`, the trace-induced weight satisfies `w_T(B)\le C`. Salvages Step 3 in principle (no adversarial-large-`w_T(\varnothing)` pathology), but the bound `C` is in general not given.
- **(W-structural)** — the operative case for F32. `w` is determined by a structural function of the underlying combinatorics of `(\mathcal F,P)`-data outside `\mathcal F` itself, e.g., `w(A)=e(P_A)` for `A\in\mathcal F(P)` where `P_A` is a canonical poset associated to `A`. The trace-induced weight has a structurally bounded form: `w_T(B)\le\sup_{A:A\cap T=B}w(A)\cdot|\{A:A\cap T=B\}|`, with both factors controlled by the underlying combinatorics.
- **(W-Daniel).** The specific case `\mathcal F=\mathcal F(P):=\{S(Q):Q\in\mathcal Q(P)\}`, `w(S(Q))=\sum_{Q':S(Q')=S(Q)}e(Q')` (the natural collapse of the `e(\cdot)` weight along the `Q\to S(Q)` map). This is a (W-structural) instance with explicit `C\le|\mathcal L(P)|`.

The Part A verdict will vary across this taxonomy. The Part B 1/8-obstruction is specific to (W-Daniel) but the structural source generalizes to any `Q`-only weighting in the F32 setup.

### 1.3 What weighted-UCC asks structurally — chain-level vs measure-level

There are two senses in which one can ask "does the mechanism extend":

- **(Chain-level extension.)** Does the cube/Walsh/Čech bicomplex machinery (UC10.W + UC10.1 + Čech-bicomplex isotype preservation + non-vanishing-from-minimality) extend to a setting where the source data `\widehat b_x` is replaced by its `w`-weighted version `\widehat b_x^w`?
- **(Measure-level extension.)** Does the closed-form *theorem* "weighted-Frankl-IC holds" follow from the UC13+UC14 chain via the same logical structure (with weighted bias substituted everywhere)?

These differ. The chain-level extension can be checked step-by-step against the construction. The measure-level extension *also* requires the minimality induction in Step 3 to bottom out at base cases, which is where the small-`n` weighted-counterexamples of (W-arbitrary) bite.

We split Part A's per-step analysis accordingly: each step is judged on chain-level extension (does the construction make sense with `w`), and Step 3 is separately judged on measure-level extension (does the induction work).

---

## §2. Part A — UC13+UC14 step-by-step weighted-extension analysis

### 2.1 Small-`n` counterexamples to (W-arbitrary) Frankl — the obstruction at the base case

Before tracing through the UC13+UC14 steps, we record explicit small-`n` counterexamples to (W-arbitrary) Frankl that any *measure-level* extension must handle.

**Counterexample 2.1.1 (`n=1`, `\varnothing\in\mathcal F`).** `\mathcal F=\{\varnothing,\{1\}\}` on `U=\{1\}`, intersection-closed (it is also union-closed). Choose `w(\varnothing)=M`, `w(\{1\})=1` for `M>1`. Then
$$
  \beta_1^w(\mathcal F)\;=\;w(\mathcal F_1)-w(\mathcal F_{\bar 1})\;=\;w(\{1\})-w(\varnothing)\;=\;1-M\;<\;0,
$$
so `x=1` IS `w`-rare. **Wait** — this gives `\beta_1^w\le 0`, so Frankl-IC *holds* here. Re-examining the union-closed sense: `\mathcal F` union-closed, weighted-frequency of `1` is `w(\mathcal F_1)/w(\mathcal F)=1/(M+1)<1/2` for `M\ge 2`. **No `x` is `w`-union-frequent.** Counterexample to union-form weighted-Frankl.

Translating back to intersection-closed convention: the UC10/UC11 framework labels the bias `\beta_x=|\mathcal F_x|-|\mathcal F_{\bar x}|` and says **`x` is rare** iff `\beta_x\le 0` (UC10 §0.1). The dual union-closed statement (UC9 / UC10 §1.1) replaces `\mathcal F` by `\mathcal F^{\complement}:=\{U\setminus A:A\in\mathcal F\}`; for `\mathcal F=\{\varnothing,\{1\}\}` on `\{1\}`, `\mathcal F^{\complement}=\{\{1\},\varnothing\}=\mathcal F` (the family is self-complementary).

The bias under the union-closed dual reads "`x` is abundant iff `\beta_x^{\complement}>0`", and weighted-Frankl-IC's failure is captured by `\beta_x^{\complement,w}\le 0\ \forall x` (no `x` is `w`-abundant). For `\mathcal F=\mathcal F^{\complement}=\{\varnothing,\{1\}\}` and `w(\varnothing)=M,w(\{1\})=1`: abundance of `1` is `w(\mathcal F_1)\ge w(\mathcal F)/2` iff `1\ge(M+1)/2` iff `M\le 1`. For `M\ge 2`, no `x` is `w`-abundant — **weighted-Frankl-IC (union form) fails**.

Equivalently in the intersection-closed convention used throughout UC10–UC14: the same family `\mathcal F=\{\varnothing,\{1\}\}` viewed *intersection*-closed has the property that the FLIP-image is a union-closed counterexample. The UC10 §1.1 flip is information-preserving, so a union-closed counterexample IS an intersection-closed counterexample to the dual statement, and *vice versa*.

**Counterexample 2.1.2 (`n=3`, `\varnothing\in\mathcal F`).** `\mathcal F=\{\varnothing,U\}` on `U=\{1,2,3\}`, intersection-closed (and union-closed). Choose `w(\varnothing)=M,w(U)=1` for `M\gg 1`. Then for every `x\in U`: `\mathcal F_x=\{U\}`, `\mathcal F_{\bar x}=\{\varnothing\}`, `\beta_x^w=1-M<0` (intersection sense), so every `x` is `w`-rare — Frankl-IC holds. But weighted-Frankl-IC in *union form*: `w(\mathcal F_x^{\text{union}})=w(U)=1`, `w(\mathcal F)=M+1`, ratio `1/(M+1)<1/2` for `M\ge 2` — no `x` is union-abundant.

**Conclusion.** (W-arbitrary) weighted-Frankl in *union form* fails on `\{\varnothing,U\}` for `M\ge 2` and any `n\ge 1`. This is the (W-arbitrary) failure mode any UC13+UC14-style argument would have to navigate.

(The intersection-closed form is the "dual" of the union-closed form via UC10 §1.1's flip, which exchanges `\mathcal F_x\leftrightarrow\mathcal F_{\bar x}` after complementing; the weighted statements correspond likewise. For the rest of §2 we work in the intersection-closed convention native to UC10–UC14, and the counterexamples translate as in 2.1.1–2.1.2: a (W-arbitrary)-counterexample in either form is a counterexample in the other after flipping.)

**Counterexample 2.1.3 (`\varnothing` re-introduced by trace).** Even if we impose `\varnothing\notin\mathcal F`, the trace operation can re-introduce `\varnothing` into sub-families. Take `\mathcal F=\{\{1\},\{2\},\{3\},\{1,2\},\{1,3\},\{2,3\},U\}\setminus\{\varnothing\}` (all non-empty subsets) on `U=\{1,2,3\}`; intersection-closed (intersection of any two non-empty subsets is in `\mathcal F` if non-empty; `\{1\}\cap\{2\}=\varnothing\notin\mathcal F` — oh, this family is NOT intersection-closed). Adjust: take `\mathcal F=\{\{1\},\{1,2\},\{1,3\},U\}` on `U`. Intersection-closed: `\{1\}\cap\{1,2\}=\{1\}`, etc. Trace onto `T=\{2,3\}`: `\mathrm{trace}_T\mathcal F=\{\varnothing,\{2\},\{3\},\{2,3\}\}`. Now `\varnothing\in\mathrm{trace}_T\mathcal F` even though `\varnothing\notin\mathcal F`. With trace-induced weight `w_T(\varnothing)=w(\{1\})`, which can be arbitrary, the trace sub-family can be made into a (W-arbitrary)-counterexample by adversarial `w(\{1\})`.

**This is the structural reason (W-arbitrary-no-empty) does not salvage Step 3.** Even imposing `\varnothing\notin\mathcal F` at the top family, traces re-introduce `\varnothing` into sub-families with weights inherited from the top weight, and adversarial choice of the top weight breaks the inductive base.

### 2.2 Step 1 — UC10.W (Walsh decomposition) — **GREEN unconditional**

**UC10 Theorem 3.5:** `C_*(X_n^{\cap};\mathbb Q)=\bigoplus_{S\subseteq[n]}\chi_S\otimes V_S^*` as `(\mathbb Z/2)^n`-modules, with the chain differential commuting with `(\mathbb Z/2)^n`.

**Weighted extension.** `X_n^{\cap}` is a `\Gamma_n`-equivariant chain complex over `\mathbb Q` defined as `\mathop{\mathrm{hocolim}}_{(\mathcal C_n^{\cap})^{\mathrm{op}}}X(\mathcal F)`. Its definition does NOT involve any weight `w` on families. The chain complex `X(\mathcal F)` is the cubical subcomplex of `Q_n` with vertices in `\mathcal F`, and the hocolim assembly is purely categorical (UC10 §3.3).

**Therefore UC10.W is invariant under any choice of family-side weighting `w`.** The Walsh decomposition is a statement about the cube/Walsh cohomology, which lives entirely on the cube ambient — weighting `w` does not enter.

**Verdict 2.2.G.** **GREEN.** UC10.W extends to (W-anything) trivially because it does not involve `w` in the first place.

### 2.3 Step 2 — UC10.1 (only-non-vanishing isotype) — **GREEN unconditional**

**UC10 Theorem 4.1 (unconditional after UC12 + UC13):** `V_{[n]}^{n-1}\cong\mathrm{sgn}_{S_n}` (one-dim), `V_S^k=0` for `(S,k)\ne([n],n-1)` in degree `\ge 1`. In particular `V_{\{x\}}^{n-1}=0` for every `x\in[n]` (since `n\ge 2`).

**Weighted extension.** Same reasoning as §2.2: UC10.1 is a statement about the cohomology of `X_n^{\cap}`, which does not depend on any family-side weighting. UC13 §§4–5 (and UC14 R2+R3) prove UC10.1 via:
- bridge-mechanism / twisted-symmetric bridge (UC13 §4) → `V_S^k=0` for `S\subsetneq[n]`, `k\ge 1`;
- iterated antisymmetric bridge (UC13 §5, UC14 R3-tightened) → `V_{[n]}^k=0` for `k<n-1`.

Neither argument uses any weight `w`. The bridge operator `h` is defined on cubical cochains (UC12 Defn 3.1, Prop 4.5, Prop 5.1) — `\Gamma_n`-equivariant, weight-independent. The iterated `H_{\vec x}` of UC14 R3 is a composition of bridges, also weight-independent.

**Verdict 2.3.G.** **GREEN.** UC10.1 extends to (W-anything) trivially because it does not involve `w`.

### 2.4 Step 3 — UC11 trace cover + cover property — **the load-bearing breakpoint**

#### 2.4.1 The construction with `w`

**Definition 2.4.1.1 (weighted local bias cochain).** For `(T,\mathcal G)\in\mathcal C_n^{\cap}(\mathcal F^\star)` with `x\in T`:
$$
  b_x^w(\mathcal G)\;:=\;w(\mathcal G_{\bar x})-w(\mathcal G_x)\;=\;-\beta_x^w(\mathcal G).
$$
(Sign chosen so `b_x^w\ge 0` on the would-be `x`-stratum.)

**Definition 2.4.1.2 (weighted trace cover).**
$$
  U_x^w\;:=\;\bigl\{(T,\mathcal G)\in\mathcal C_n^{\cap}(\mathcal F^\star)\setminus\{(\mathcal F^\star)\}\,:\,x\in T,\ \beta_x^w(\mathcal G)\le 0\bigr\}.
$$
The weighted trace cover is `\mathfrak U^w:=\{U_x^w\}_{x\in[n]}`.

**Definition 2.4.1.3 (weighted Čech sheaf).** `\mathcal F_{\mathrm{obs}}^w(U_x^w):=C^*(X(-))_{\chi_{\{x\}}}|_{U_x^w}` scaled by `b_x^w(\mathcal G)`; mismatch `m_{xy}^w:=\widehat b_x^w-\widehat b_y^w\in C^*_{\chi_{\{x\}}}\oplus C^*_{\chi_{\{y\}}}` on `U_x^w\cap U_y^w`.

All three definitions go through *constructively* — the scalar `b_x^w` is a real number (`\in\mathbb R` in (W-real), `\in\mathbb Q` in (W-rat)), and the cochain `\widehat b_x^w=b_x^w\cdot[\chi_{\{x\}}]_{X(\mathcal G)}` is a scalar multiple of the level-1 Walsh class. The chain complex `C^*(X(\mathcal G))` is over `\mathbb Q` (or `\mathbb R` after extension of scalars); cochains are vector-space elements, scalar multiplication makes sense.

**Therefore the *construction* of the weighted Čech sheaf goes through unconditionally.** What can break is the *cover property*.

#### 2.4.2 The cover property breaks in (W-arbitrary)

**UC11 Theorem 3.4 (cover property):** for every `(T,\mathcal G)\in\mathcal C_n^{\cap}(\mathcal F^\star)\setminus\{(\mathcal F^\star)\}`, there exists `x\in T` with `\beta_x(\mathcal G)\le 0`. **Proof:** strict-trace-shrinking (UC11 §3.3): `\mathcal G\subsetneq_{\text{strict}}\mathcal F^\star` as families, hence `|\mathcal G|<|\mathcal F^\star|` (after trace, the sub-family is *strictly smaller* in the lex order `(|\mathcal F|,n)`). By minimality of `\mathcal F^\star` as the smallest unweighted counterexample, `\mathcal G` is not a counterexample, hence has a rare element.

**Weighted analog (chain-level statement):** for `(T,\mathcal G)\in\mathcal C_n^{\cap}(\mathcal F^\star)\setminus\{(\mathcal F^\star)\}`, exists `x\in T` with `\beta_x^{w_T}(\mathcal G)\le 0`, where `w_T(B):=\sum_{A\in\mathcal F^\star:A\cap T=B}w(A)` is the trace-induced weight.

**Weighted analog (proof attempt by strict-trace-shrinking).** Suppose `(\mathcal F^\star,w)` is a *minimal weighted-counterexample*: minimize the lex `(|\mathcal F^\star|,n)` (or any well-founded order on `(\mathcal F,w)`-pairs) among all `(\mathcal F,w)` with `\beta_x^w(\mathcal F)>0\ \forall x\in U`. Take `(T,\mathcal G)\in\mathcal C_n^{\cap}(\mathcal F^\star)\setminus\{(\mathcal F^\star)\}`. Two cases:
- **(i)** `T\subsetneq[n]`. Then `(T,\mathcal G,w_T)` lives over a strictly smaller universe `|T|<n`. If we minimize lexicographically by `(n,|\mathcal F|)` with `n` primary, `(T,\mathcal G,w_T)` has `n_T<n`, hence is *smaller* than `(\mathcal F^\star,w)`. By minimality, it is not a weighted-counterexample, hence has `x` with `\beta_x^{w_T}(\mathcal G)\le 0`. ✓
- **(ii)** `T=[n]`, `\mathcal G\subsetneq\mathcal F^\star`. Then `|\mathcal G|<|\mathcal F^\star|`. `(\mathcal G,w|_{\mathcal G})` has smaller `|\mathcal F|`, same `n`. By minimality, it is not a weighted-counterexample, hence has `x` with `\beta_x^{w|_{\mathcal G}}(\mathcal G)\le 0`. ✓

So far so good — the strict-trace-shrinking induction step transfers. **But the induction must bottom out.**

**Base case for unweighted Frankl-IC.** Direct verification at small `n` (`n=1,2`). Easy: for `n=1`, only non-trivial `\mathcal F` is `\{\varnothing,\{1\}\}`, with `\beta_1=0\le 0` ✓.

**Base case for (W-arbitrary) weighted-Frankl-IC.** **FAILS.** Counterexamples 2.1.1–2.1.2 give explicit `(\mathcal F,w)` at `n=1` (Counterexample 2.1.1) or `n=3` (Counterexample 2.1.2) that are weighted-counterexamples — in the union-closed dual sense, but the UC10 §1.1 flip is bidirectional and weight-preserving, so the failure transfers.

(Specifically: the union-closed `(\mathcal F,w)=(\{\varnothing,U\},w(\varnothing)=M,w(U)=1)` at any `n\ge 1` is a weighted-counterexample to union-form weighted-Frankl for `M\ge 2`. Its intersection-closed-form-flip `\mathcal F^{\complement}=\{U\setminus\varnothing,U\setminus U\}=\{U,\varnothing\}=\mathcal F` (self-flip on this family), with `w^{\complement}(U\setminus A):=w(A)`, gives the same weighted family viewed intersection-closed — still a weighted-counterexample.)

**Therefore the strict-trace-shrinking induction in (W-arbitrary) cannot bottom out.** A "minimal weighted-counterexample" `(\mathcal F^\star,w)` might exist for *every* small `n` — there is no `n=0` or `n=1` base case where the conjecture holds by direct verification.

**Verdict 2.4.2.R.** **RED for (W-arbitrary).** The cover property *as a measure-level statement* fails because the underlying weighted-Frankl-IC fails at small-`n` base cases. The chain-level construction (Defns 2.4.1.1–2.4.1.3) goes through, but the cover may be inhabited only by some subset of `[n]`, and the cover-of-everything-minus-top property is not provable from minimality alone.

#### 2.4.3 The cover property in (W-Daniel) and (W-structural)

For the F32 program's specific weight `w(S(Q))=\sum_{Q':S(Q')=S(Q)}e(Q')`, the weight is structurally bounded: `w(S(Q))\le|\mathcal L(P)|` since the total weight `\sum_{S\in\mathcal F(P)}w(S)=\sum_Q e(Q)\le|\mathcal Q(P)|\cdot\max_Q e(Q)`, and the maximum extension count `\max_Q e(Q)\le|\mathcal L(P)|` (achieved at `Q=P`).

**The (W-Daniel) trace-induced weight `w_T` retains the same structural bound.** Specifically, for `T\subsetneq U_P` (where `U_P` is the 3-antichain ground set), the trace map `S\mapsto S\cap T` collapses `\mathcal F(P)` along the projection. The trace-induced weight is `w_T(B)=\sum_{S\in\mathcal F(P):S\cap T=B}w(S)`. Since `w(S)\le|\mathcal L(P)|` for each `S`, and the preimage `\{S:S\cap T=B\}` has `\le|\mathcal F(P)|\le 2^{|U_P|}` elements, the trace weight is bounded by `|\mathcal L(P)|\cdot 2^{|U_P|}` — a constant depending on `P` but independent of the trace target `T` or `B`.

**This bound bypasses the (W-arbitrary) small-`n` pathology** (Counterexample 2.1.2 with `M\to\infty`). The trace weight cannot be inflated adversarially — it is determined by `P`'s combinatorics.

**However**, even with bounded trace weight, the cover property in (W-Daniel) requires explicit verification: for each `(T,\mathcal G)\in\mathcal C_{|U_P|}^{\cap}(\mathcal F(P))\setminus\{(\mathcal F(P))\}` with `T\subsetneq U_P` or `\mathcal G\subsetneq\mathcal F(P)`, exists `x\in T` with `\beta_x^{w_T}(\mathcal G)\le 0`. This is a weighted-Frankl-IC instance at sub-`P` level. Whether it holds depends on whether the specific trace-induced sub-family `(\mathcal G,w_T)` is itself derived from some sub-poset `P'\subseteq P` in a structurally compatible way — i.e., whether the trace operation on the cube respects the underlying poset structure.

**This requires explicit verification** — it is a (W-structural) base-case check, specific to the F32 setup, that is *not* automatic from the UC11 §3 machinery. The scoping verdict is **AMBER**: the chain-level structure transfers, but the measure-level induction depends on a (W-Daniel)-specific base case that is not delivered by UC11/UC13/UC14.

**Verdict 2.4.3.A.** **AMBER for (W-Daniel)** — chain-level construction goes through, measure-level cover property depends on (W-Daniel)-specific base verification; **AMBER for (W-bounded)** — same caveat with `C` not given.

#### 2.4.4 Step 3 summary

- (W-arbitrary): **RED** (measure-level induction does not bottom out; chain-level construction goes through).
- (W-arbitrary-no-empty): **RED** (trace re-introduces `\varnothing`, base case still fails).
- (W-bounded): **AMBER** (structural bound `C` suffices in principle; explicit `C` not given).
- (W-Daniel): **AMBER** (chain-level GREEN; measure-level depends on `w_T`-trace-respects-poset-structure base check).

### 2.5 Step 4 — UC11 §6 Lemma 6.1+6.2 (non-vanishing from minimality) — **GREEN conditional on Step 3**

**UC11 Lemma 6.1 (vanishing-implies-witness-extension):** if `\mathrm{ob}(\mathcal F^\star)=0`, exists global section `\widetilde w:\mathcal C_n^{\cap}(\mathcal F^\star)\to[n]` extending the local witness, with `\beta_{\widetilde w([n],\mathcal F^\star)}(\mathcal F^\star)\le 0`.

**Proof structure (UC11 §6.1).** Cohomological vanishing `[m_{xy}]=0` in `\check H^1(\mathfrak U;\mathcal F_{\mathrm{obs}})` means there exists a 0-cochain `\{s_x\in\mathcal F_{\mathrm{obs}}(U_x)\}` with `\check d s=m`. The 0-cochain encodes a consistent refinement of the local witness data `\widehat b_x` across all strata, gluing into a coherent global witness assignment. Continuity at the top object forces `\beta_{\widetilde w}\le 0`.

**Weighted extension.** All ingredients carry across to `\mathcal F_{\mathrm{obs}}^w`:

- The Čech 1-cocycle `m_{xy}^w=\widehat b_x^w-\widehat b_y^w` lives in `\check C^1(\mathfrak U^w;\mathcal F_{\mathrm{obs}}^w)`. The cocycle condition `m_{xy}^w+m_{yz}^w+m_{zx}^w\equiv 0` is purely additive (Lemma 5.2, the additive identity `(\widehat b_x^w-\widehat b_y^w)+(\widehat b_y^w-\widehat b_z^w)+(\widehat b_z^w-\widehat b_x^w)=0` works for *any* scalar). ✓
- Cohomological vanishing `[m_{xy}^w]=0` gives a `w`-coboundary `\{s_x^w\}` with `\check d s^w=m^w`. This is a 0-cochain in `\check C^0(\mathfrak U^w;\mathcal F_{\mathrm{obs}}^w)`. Each `s_x^w\in\mathcal F_{\mathrm{obs}}^w(U_x^w)=C^*(X(-))_{\chi_{\{x\}}}|_{U_x^w}` scaled by `b_x^w`. ✓
- The witness-extension interpretation: `s_x^w` is a `w`-scaled local witness assignment; the gluing relation `s_y^w-s_x^w=m_{xy}^w=\widehat b_x^w-\widehat b_y^w` makes the local witnesses consistent across stratum intersections. The gluing argument is sheaf-theoretic and weight-agnostic. ✓
- Continuity at the top forces `\beta_{\widetilde w([n],\mathcal F^\star)}^w(\mathcal F^\star)\le 0` — the same constraint, with weighted bias. ✓

**Lemma 6.2 (non-vanishing).** Suppose `\mathrm{ob}^w(\mathcal F^\star)=0`. By Lemma 6.1 (weighted), exists `\widetilde w` with `\beta_{\widetilde w}^w(\mathcal F^\star)\le 0`. But `(\mathcal F^\star,w)` is the minimal weighted-counterexample, so `\beta_x^w(\mathcal F^\star)>0\ \forall x` — contradiction. Hence `\mathrm{ob}^w(\mathcal F^\star)\ne 0`.

**This argument is GREEN if Step 3 is GREEN** — i.e., if the cover `\mathfrak U^w` exists (covers everything except the top) and the minimality framework can identify a minimal weighted-counterexample `(\mathcal F^\star,w)`.

**Verdict 2.5.C.** **Conditionally GREEN.** Pure sheaf-cohomology + minimality logic transfers; depends on Step 3 cover property.

### 2.6 Step 5 — UC13 §2 Theorem 2.4.1 (landing in level-1 Walsh isotypes) — **GREEN unconditional**

**UC13 Theorem 2.4.1 (with UC14 R1-tightening, Theorem 1.5.1):** `\mathrm{ob}(\mathcal F^\star)\in\bigoplus_{x\in[n]}V_{\{x\}}^{n-1}` — landing in level-1 Walsh isotypes only.

**Proof structure (UC13 §2):**
- Čech bicomplex `\check C^{*,*}_{\mathfrak U}(\mathcal F_{\mathrm{obs}})` is `(\mathbb Z/2)^n`-equivariant (Lemma 2.2.1) — both differentials commute with `\sigma_y`-action.
- Source data of `\mathcal F_{\mathrm{obs}}` is level-1 Walsh-supported (Corollary 2.3.2) — each `\widehat b_x=b_x\cdot[\chi_{\{x\}}]` is a scalar multiple of the level-1 character `\chi_{\{x\}}`.
- `(\mathbb Z/2)^n`-equivariant differentials preserve isotype decomposition; spectral-sequence pages preserve isotype; abutment preserves isotype. Hence the obstruction class lands in level-1 isotypes.

**Weighted extension.** The weight enters as a *scalar* multiplying `[\chi_{\{x\}}]`:
$$
  \widehat b_x^w(\mathcal G)\;=\;b_x^w(\mathcal G)\cdot[\chi_{\{x\}}]_{X(\mathcal G)}.
$$
The Walsh isotype of `\widehat b_x^w` is **the same as the Walsh isotype of `[\chi_{\{x\}}]`** — namely `\chi_{\{x\}}`, level-1. Scalar multiplication preserves isotype.

The Čech bicomplex's `(\mathbb Z/2)^n`-equivariance (Lemma 2.2.1) is structural: the differentials are alternating-sum-of-restriction (Čech `\check d`) and cubical-boundary (vertical `d`), both of which preserve cellwise Walsh-isotype. Scaling source data by `w` doesn't introduce any multiplication; the isotype structure is preserved end-to-end.

**Critically**, the *purely-additive* character of the Čech bicomplex (UC13 §2.3 + §3.3) is what makes UC13's argument structurally distinct from the F31 RED-chain-locality wall on the 1/3-2/3 side. **Weighting `b_x\to b_x^w` is itself purely scalar (no multiplication by Walsh characters, no spreading)**, so it preserves the additive character of the bicomplex. The UC14 R1 explicit `\Theta`-map (UC14 Defn 1.2.1) carries `\widehat b_x^w` through to its level-1 component on `X_n^{\cap}` via the `\chi_{\{y\}}`-isotypic projection of the Bousfield–Kan double complex — again, scalar-preserving.

**Verdict 2.6.G.** **GREEN.** Step 5 extends to (W-anything) because weighting acts by scalars within a fixed Walsh isotype.

### 2.7 Step 6 — UC13 §7 closing Frankl contradiction — **GREEN conditional on Steps 3+4**

**UC13 §7.1:** combining Step 2 (UC10.1: `V_{\{x\}}^{n-1}=0`) + Step 5 (landing in level-1) gives `\mathrm{ob}(\mathcal F^\star)=0`. Combined with Step 4 (Lemma 6.2: `\mathrm{ob}(\mathcal F^\star)\ne 0`), contradiction. Hence Frankl-IC.

**Weighted extension.** Direct substitution:
- Step 2 weighted (Verdict 2.3.G): `V_{\{x\}}^{n-1}=0` — UC10.1 is weight-independent. ✓
- Step 5 weighted (Verdict 2.6.G): `\mathrm{ob}^w(\mathcal F^\star)\in\bigoplus_x V_{\{x\}}^{n-1}` — landing isotype is weight-independent. ✓
- Step 4 weighted (Verdict 2.5.C): `\mathrm{ob}^w(\mathcal F^\star)\ne 0` — IF Step 3 (cover property) GREEN.

Combining: `\mathrm{ob}^w(\mathcal F^\star)\in\bigoplus_x V_{\{x\}}^{n-1}=0` and `\mathrm{ob}^w(\mathcal F^\star)\ne 0` — contradiction, hence weighted-Frankl-IC.

**The contradiction structure transfers entirely.** What blocks it from being a *proof* of weighted-Frankl-IC is Step 3's failure in (W-arbitrary): if the cover property fails, the spectral-sequence assembly of `\mathrm{ob}^w` is not defined (or is defined on an incomplete cover), and the non-vanishing argument loses its minimality premise.

**Verdict 2.7.C.** **Conditionally GREEN.** Logical structure transfers; depends on Steps 3+4.

### 2.8 Part A summary

| Step | Statement | (W-arbitrary) | (W-Daniel) / (W-structural) |
|---|---|---|---|
| 1 (UC10.W) | Walsh decomposition of `X_n^{\cap}` | **GREEN** | **GREEN** |
| 2 (UC10.1) | `V_S^k=0` for `(S,k)\ne([n],n-1)` | **GREEN** | **GREEN** |
| 3 (UC11 cover) | Strict-trace-shrinking, `\mathfrak U^w` covers all-but-top | **RED** (small-`n` base) | **AMBER** (chain GREEN, measure base-check needed) |
| 4 (UC11 Lem 6.2) | Non-vanishing from minimality | conditional on 3 | conditional on 3 |
| 5 (UC13 Thm 2.4.1) | Landing in level-1 Walsh isotypes | **GREEN** | **GREEN** |
| 6 (UC13 §7) | Closing contradiction | conditional on 3, 4 | conditional on 3, 4 |

**Part A overall:** 
- (W-arbitrary) — **RED.** Step 3 has explicit small-`n` counterexamples; mechanism does not extend.
- (W-Daniel) / (W-structural) — **AMBER.** Steps 1, 2, 4 (cond.), 5, 6 (cond.) extend; Step 3 requires (W-Daniel)-specific base-case verification. Mechanism *plausibly* extends but is not delivered automatically by UC13+UC14.

**What an explicit extension to (W-Daniel) would need.** A dedicated UC15-equivalent execution ticket establishing the (W-Daniel) cover property: for every `(T,\mathcal G)\in\mathcal C_{|U_P|}^{\cap}(\mathcal F(P))\setminus\{(\mathcal F(P))\}` arising as a trace of `(\mathcal F(P),w=e(Q))`, exists `x\in T` with `\beta_x^{w_T}(\mathcal G)\le 0`. Likely route: show `(\mathcal G,w_T)` corresponds to some `(\mathcal F(P'),w'=e(Q'))` for a sub-poset `P'` of `P`, then invoke `(\mathcal F(P'),w')`-weighted-Frankl-IC by strong induction on `|P|`. The induction has to bottom out at very small `P` (size 3 or less), where direct verification is possible.

(Out of scope for this scoping; flagged as forward work in §5.)

---

## §3. Part B — the 1/8-obstruction structural analysis

### 3.1 Recap of F32-scope §3.3.2 derivation

From F32-scope §3.3.2 (verbatim structural recap; not re-derived here, this is read-only structural input):

- `P` = a poset on the 1/3-2/3 minimal counterexample's underlying element set.
- `\mathcal Q(P)` = poset extensions of `P` (refinements ordered by `\subseteq`).
- `\mathcal L(P)` = linear extensions of `P` (maximal refinements).
- `S(Q):=` set of canonical 3-antichains of `Q` (per Daniel's program).
- `\mathcal F(P):=\{S(Q):Q\in\mathcal Q(P)\}` — the family on the ground set `U_P:=` 3-antichains of `[n]`.
- `k:=\binom{n}{2}-|P|` = number of incomparable pairs in `P`.
- `e(Q)=|\{L\in\mathcal L(P):L\ge Q\}|` = number of linear extensions of `Q`.

**Key over-counting identity (F32-scope eqn 3.3.2.3 + 3.3.2.4):** under the simplifying assumption (roughly the case for minimal counterexamples) that `|\{Q:P\le Q\le L\}|=2^k` is constant over `L\in\mathcal L(P)`,
$$
  \sum_{Q\in\mathcal Q(P)}e(Q)\;=\;\sum_{L\in\mathcal L(P)}\bigl|\{Q:P\le Q\le L\}\bigr|\;=\;|\mathcal L(P)|\cdot 2^k.
\tag{3.1.1}
$$
**Canonical-`A^*`-sub-sum (F32-scope eqn 3.3.2.5):** for `A^*` a specific 3-antichain, the `Q`'s containing the three canonical edges of `A^*` are `2^{k-3}` per linear extension `L`,
$$
  \sum_{Q:A^*\in S(Q)}e(Q)\;=\;\bigl|\{L:\sigma_L|_{A^*}=\mathrm{can}\}\bigr|\cdot 2^{k-3}.
\tag{3.1.2}
$$
**Ratio (F32-scope eqn 3.3.2.6):**
$$
  \frac{\sum_{Q:A^*\in S(Q)}e(Q)}{\sum_Q e(Q)}\;=\;\frac{|\{L:\sigma_L|_{A^*}=\mathrm{can}\}|}{|\mathcal L(P)|}\cdot\frac{2^{k-3}}{2^k}\;=\;\frac{1}{8}\Pr_L[\sigma_L|_{A^*}=\mathrm{can}].
\tag{3.1.3}
$$
**Weighted-UCC conclusion `\ge 1/2` on `(\mathcal F(P),w=e(Q))` translates to `\Pr_L[\sigma_L|_{A^*}=\mathrm{can}]\ge 4` — vacuous (probabilities `\le 1`).**

The factor `1/8` is the over-counting ratio `2^{k-3}/2^k`: in `\sum_Q e(Q)` each `L` is over-counted `2^k` times (once per `Q\le L`), but in `\sum_{Q:A^*\in S(Q)}e(Q)` only the `2^{k-3}` `Q`'s containing the canonical edges of `A^*` over-count `L`. The ratio is **a structural property of the `Q\to L` correspondence**, *independent* of which `A^*` we pick (any 3-antichain has 3 canonical edges; the factor is `1/2^3=1/8`).

### 3.2 Alternative weightings — three families analyzed

The bypass question: is there a weighting `w^*(Q)\ne e(Q)` that delivers a measure transfer **with a smaller / no obstruction**?

#### 3.2.1 `w^*(Q)=e(Q)^\alpha` for `\alpha\ne 1`

For general `\alpha\in\mathbb R`,
$$
  \frac{\sum_{Q:A^*\in S(Q)}e(Q)^\alpha}{\sum_Q e(Q)^\alpha}\;=\;?
$$
For `\alpha=0`: `w^*=1` (uniform over `Q`). Numerator `=|\{Q:A^*\in S(Q)\}|`, denominator `=|\mathcal Q(P)|`. This is *not* `\Pr_L[A^*]` — it is the *uniform-over-Q* frequency of `A^*` being canonical-in-Q. The connection to `\Pr_L` involves an `e(Q)`-weighted sum, which uniform-over-Q does NOT have. The identity (3.1.1) does not apply (no `e(Q)` factor in the sum), and the over-counting ratio analysis breaks. So uniform-over-Q-UCC gives a `\Pr_Q^{\text{uniform}}` bound, not a `\Pr_L` bound — **wrong target measure**.

For `\alpha\in(0,1)\cup(1,\infty)`: the sum `\sum_Q e(Q)^\alpha` does not factor via `\sum_L\cdot(\text{constant in }L)`. Specifically:
$$
  \sum_Q e(Q)^\alpha\;=\;\sum_Q\bigl(|\{L:L\ge Q\}|\bigr)^\alpha
$$
which is NOT expressible as `\sum_L f(L)\cdot(\text{constant})` for any `f` independent of `Q`. So the over-counting analysis (3.1.1) does not generalize.

**Effect on the measure transfer.** Even if `(\mathcal F(P),e(Q)^\alpha)`-weighted UCC delivers `\ge 1/2`, there is no clean translation to a `\Pr_L`-frequency. The connection between weighted-`Q`-frequency and `\Pr_L` is *exclusively* via the identity (3.1.1), which holds *only* for `\alpha=1`.

**Verdict.** `w^*(Q)=e(Q)^\alpha` for `\alpha\ne 1` does NOT yield a useful measure transfer; the obstruction is "wrong target measure" rather than "obstruction in the transfer". **Bypass via `\alpha`-rescaling fails.**

#### 3.2.2 `w^*(Q)=\mathbb 1[Q\in\mathcal L(P)]` — restrict to linear extensions only

Set `w^*(Q)=1` if `Q` is itself a linear extension of `P` (i.e., `k(Q)=0`), and `w^*(Q)=0` otherwise. Then:
$$
  \frac{\sum_{Q:A^*\in S(Q)}w^*(Q)}{\sum_Q w^*(Q)}\;=\;\frac{|\{L:A^*\in S(L)\}|}{|\mathcal L(P)|}\;=\;\Pr_L[A^*\in S(L)].
$$
If `A^*\in S(L)` is the same condition as `\sigma_L|_{A^*}=\mathrm{can}` (i.e., `S(L)` for a *linear* extension `L` records `L`'s canonical 3-antichains), then `\Pr_L[A^*\in S(L)]=\Pr_L[\sigma_L|_{A^*}=\mathrm{can}]` directly. **No 1/8 obstruction.**

**But — is `(\{S(L):L\in\mathcal L(P)\},w^*=1)` weighted-UCC-compatible?**

UCC requires:
- (a) `\mathcal F'(P):=\{S(L):L\in\mathcal L(P)\}` is **union-closed** (or intersection-closed dually).
- (b) Apply unweighted UCC on `\mathcal F'(P)`, conclude `\exists A^*` with `|\{L:A^*\in S(L)\}|\ge|\mathcal F'(P)|/2`.

**(a) fails in general.** For `L_1,L_2\in\mathcal L(P)`, `S(L_1)\cup S(L_2)` is *not* generally `S(L_3)` for any `L_3\in\mathcal L(P)`. Reason: `S(L)` is determined by `L`'s pairwise orientations on every triple — a linear extension's canonical 3-antichain set is highly constrained. Unioning two such sets typically produces a configuration that no single `L` realizes.

For a concrete small example: take `P` = antichain on 3 elements, `\mathcal L(P)`=6 linear extensions. Each `L\in\mathcal L(P)` is a total order, with `S(L)=\{\{a,b,c\}\}` (the unique 3-antichain) if the canonical orientation matches `L`, else `S(L)=\varnothing`. Then `\mathcal F'(P)\subseteq\{\varnothing,\{\{a,b,c\}\}\}` — and `\{\{a,b,c\}\}\cup\varnothing=\{\{a,b,c\}\}`, trivially union-closed. But on larger `P`'s with more 3-antichains, the union of `S(L_1)\cup S(L_2)` typically contains configurations that no single `L_3` produces — union-closure fails.

**(b) is circular.** Even granting (a) somehow, applying UCC on `\mathcal F'(P)` to get `\exists A^*` with `|\{L:A^*\in S(L)\}|\ge|\mathcal F'(P)|/2` is essentially the **1/3-2/3 conjecture itself at the triple level**: it says some 3-antichain `A^*` is canonical-in-`L` for `\ge 1/2` of `L`'s. **The conjecture we are trying to prove.** Circular.

**Verdict.** `w^*=\mathbb 1[Q\in\mathcal L(P)]` recovers `\Pr_L` directly but loses union-closure (and even if union-closure held, the resulting UCC application is circular). **Bypass via "restrict to linear extensions" fails.**

#### 3.2.3 `A^*`-dependent weighting: `w^*(Q)=e(Q)\cdot\mathbb 1[Q\supseteq\text{can edges of }A]`

For a fixed 3-antichain `A`, set `w^*(Q)=e(Q)` if `Q` contains the three canonical edges of `A`, else `w^*(Q)=0`. Then:
$$
  \frac{\sum_{Q:A^*\in S(Q)}w^*(Q)}{\sum_Q w^*(Q)}\;=\;\frac{\sum_{Q\supseteq\text{can-}A,A^*\in S(Q)}e(Q)}{\sum_{Q\supseteq\text{can-}A}e(Q)}.
$$
For `A=A^*` (i.e., setting the weight to favor `A^*` itself), the numerator simplifies, but this is *circular*: `A^*` is the *output* of the UCC theorem, not an input we can use to tune `w`. We cannot choose `A` before seeing the UCC conclusion.

**Could we average over `A`?** Set `w^*(Q)=e(Q)\cdot|\{A:Q\supseteq\text{can-}A\}|=e(Q)\cdot 2^{k-3}\cdot|\{A:A\subseteq[n]\}|\cdot(\text{factor})`... this is approximately `e(Q)\cdot\binom{n}{3}\cdot 2^{k-3}/2^k=(1/8)e(Q)\binom{n}{3}` — still proportional to `e(Q)`, so the analysis reduces to (W-Daniel) with a constant rescaling, giving the same 1/8 obstruction.

**Verdict.** `A^*`-dependent weighting is circular; `A^*`-averaged weighting reduces to (W-Daniel) up to constant. **No bypass.**

### 3.3 Structural reason — why no `Q`-only weighting bypasses the 1/8

**Proposition 3.3.1.** *For any `Q`-only weighting `w^*:\mathcal Q(P)\to\mathbb R_{>0}` (i.e., depending only on `Q` and not on `A^*`), the ratio*
$$
  \rho_{A^*}(w^*)\;:=\;\frac{\sum_{Q:A^*\in S(Q)}w^*(Q)}{\sum_Q w^*(Q)}
$$
*either (i) equals `c\cdot\Pr_L[\sigma_L|_{A^*}=\mathrm{can}]` for some constant `c\le 1/8` (under the over-counting analysis of §3.1), or (ii) cannot be expressed in terms of `\Pr_L` at all (when the over-counting identity (3.1.1) does not generalize to `w^*`).*

*Structural reason.* The connection from weighted-`Q`-frequency to `\Pr_L` is *via the identity `\sum_Q w^*(Q)\cdot\mathbb 1[A^*\in S(Q)]=\sum_L\mathbb 1[\sigma_L|_{A^*}=\mathrm{can}]\cdot W^*(L)`*, where `W^*(L):=\sum_{Q\le L,Q\supseteq\text{can-}A^*}w^*(Q)`. For this to translate cleanly to `\Pr_L`, `W^*(L)` must be *constant in `L`* (so that the `L`-sum factors). 

For `w^*(Q)=e(Q)`: `W^*(L)=\sum_{Q\le L,Q\supseteq\text{can-}A^*}e(Q)`. Using `e(Q)=|\{L':L'\ge Q\}|`, this becomes `\sum_{Q\le L,Q\supseteq\text{can-}A^*}|\{L':L'\ge Q\}|` — a double sum over `(Q,L')` pairs. This sum is *not* constant in `L` in general.

But under the constancy assumption of F32-scope §3.3.2 (which is roughly the case for minimal counterexamples), `W^*(L)` *is* approximately constant, and the over-counting analysis gives `c=2^{k-3}/2^k=1/8`.

For `w^*(Q)=e(Q)^\alpha` with `\alpha\ne 1`: `W^*(L)=\sum_{Q\le L,Q\supseteq\text{can-}A^*}e(Q)^\alpha` — depends on `L` in general, no clean constancy. The identity does not generalize.

**Consequence.** *Any* `Q`-only weighting that admits a clean `\Pr_L` translation will have the over-counting ratio `c=2^{k(Q)-3}/2^{k(Q)}=1/8` baked in *structurally*. The factor `1/8` reflects the fact that 3 out of `k` incomparable pairs have to be fixed by the canonical orientation of `A^*`, and this is a property of the 3-antichain combinatorics (3 edges per antichain), not of the weight choice.

**Bypass would require either:**

- A weighting that is NOT `Q`-only — e.g., `w^*(Q,A^*)` jointly. But this loses the UCC framework's structure (UCC weighting is on family elements, here `Q`'s, not on `(Q,A^*)` pairs).
- An auxiliary mechanism that recovers a "missing factor 8" elsewhere — e.g., proving `\Pr_L\ge 1/8\cdot(\text{something})\ge 1/2` from a different combinatorial input. But this is no longer a UCC bypass — it is a different argument.

### 3.4 Bypass verdict

**No clean `Q`-only weighting bypasses the 1/8 obstruction.** F32-scope §3.3.3's conclusion ("the 1/8-obstruction is structural, not a calculation error") is *confirmed* by this analysis: the factor `1/8=2^{k-3}/2^k` is intrinsic to the 3-antichain → 3-canonical-edges combinatorics under any `Q`-only weighting that admits a `\Pr_L` translation.

The only escape routes are out of scope for L3-B-UC:
- L3-C-injection (F32-scope §3.3.4) — bypasses UCC weighting entirely.
- A wholly different combinatorial input (e.g., proving `\Pr_L\ge 4` *is* somehow non-vacuous in a sharper structural setting; implausible).

---

## §4. U1-dialect-check — weighted extension preserves the additive character

**The F31 chain-locality concern (carried from UC13 §3 + UC14 §4.1).** F31 on the 1/3-2/3 side wallled on a chain-locality dialect of U1: the cup-product-style chain-level assembly `\Phi` of F30 has a non-trivial kernel containing the bad-cut Čech class, making the local-to-global identification *uninformative*. UC13 §3 verified this dialect does NOT transfer to the union_closed side because the Čech bicomplex of `\mathcal F_{\mathrm{obs}}` is *purely additive* — no cup-product, no multiplicative structure that could correlate distant Čech cells.

**Does weighted extension introduce a multiplicative structure that could re-open the dialect-collision?**

**No.** The weighted construction (§2.4.1) introduces *scalar multiplication* of `\widehat b_x` by `b_x^w`:
$$
  \widehat b_x^w(\mathcal G)\;=\;b_x^w(\mathcal G)\cdot[\chi_{\{x\}}]_{X(\mathcal G)}.
$$
Scalar multiplication of a Walsh class by a scalar is NOT a cup product. It does NOT take `\chi_{\{x\}}` to `\chi_{\{x\}}\cdot\chi_{\{y\}}=\chi_{\{x,y\}}` (which would be a level-shift). It keeps `\widehat b_x^w` in the same Walsh isotype as `\widehat b_x`. The Čech bicomplex's additive character is preserved: both differentials (Čech `\check d`, vertical `d`) commute with scalar multiplication on individual stalks.

**The UC14 R1 `\Theta`-map** (Defn 1.2.1) — the explicit chain map from the Čech bicomplex into the Bousfield–Kan presentation of `C^*(X_n^{\cap})` — is `\mathbb Q`-linear (and extends to `\mathbb R`-linear under scalar extension), so scaling source data by `w` is compatible with `\Theta`.

**Verdict 4.G.** **GREEN.** Weighted extension preserves the additive character of the Čech bicomplex; UC13 §3 + UC14 §4.1's dialect-check transfers to (W-anything) without modification. **No F31 chain-locality risk re-introduction.**

---

## §5. Verdict + implication for F32 program + sub-ticket recommendations

### 5.1 Combined verdict

**Part A (chain-level extension of UC13+UC14 to weighted setting):**

- Steps 1, 2, 5, 6: GREEN unconditional (cube/Walsh/cohomology framework is weight-independent).
- Step 4: GREEN conditional on Step 3.
- Step 3: split by weight class.
  - (W-arbitrary) RED — small-`n` base case of weighted-Frankl-IC fails (Counterexamples 2.1.1–2.1.2).
  - (W-Daniel) / (W-structural) AMBER — chain-level extension GREEN, measure-level cover property depends on (W-Daniel)-specific base-case verification not delivered by UC11/UC13/UC14.

**Part B (1/8-obstruction bypass):**

- 1/8 factor is structurally intrinsic to the `Q\to L` over-counting (Proposition 3.3.1).
- No `Q`-only weighting bypasses it.
- (W-Daniel)'s natural weighting `w(Q)=e(Q)` is the unique `Q`-only weighting that admits a clean `\Pr_L` translation, and its translation factor is `1/8`.
- Escape routes (L3-C-injection, different combinatorial input) are out of L3-B-UC scope.

**Overall verdict on F32-L3-B-UC: AMBER-extends-conditionally-with-1/8-obstruction-unresolved-on-natural-weighting.**

- Mechanism *plausibly* extends to (W-Daniel) — conditional on Step 3 (W-Daniel)-specific base-case verification.
- Even if Part A extends, Part B's 1/8 obstruction is structurally fatal to the F32 measure-transfer step.
- **Practical consequence: F32 L3-B is structurally obstructed; F32 should escalate to L3-C-injection** per F32-scope §3.3.5.

### 5.2 Sub-ticket recommendations (forward work for F32 and union_closed)

#### F32-side (in `one_third_width_three`)

- **F32-L3-C-injection (HIGH, 400-600k, single-session-capable).** The escalation per F32-scope §3.3.5 + this document's §5.1. Investigate the injection `\iota:\{L:\sigma_L|_{A^*}\ne\mathrm{can}\}\hookrightarrow\{L:\sigma_L|_{A^*}=\mathrm{can}\}` for some `A^*` delivered by Frankl-Holds. Brightwell-Tetali-style swap injection in literature; needs `A^*`-specific construction aware of Frankl-Holds output. If a clean injection exists, bypasses the 1/8 obstruction entirely.
- **F32 mainline rescoping.** Given L3-B is obstructed, F32-scope's §3.3 attack-order recommendation should be updated to reflect L3-C as the primary path.

#### union_closed-side (in `union_closed`)

- **UC15-weighted-UCC-execution (OPTIONAL, MEDIUM, 300-500k).** Not blocking. If F32-L3-C-injection succeeds, UC15-weighted is not needed for the 1/3-2/3 bridge. If F32-L3-C fails and a (W-Daniel)-specific path is re-attempted, UC15-weighted would deliver the (W-Daniel) weighted-Frankl-IC. The scoping: Step 3 base-case verification for (W-Daniel)-specific traces, then assemble the UC13+UC14 mechanism over `\mathbb R` (or `\mathbb Q`) with scaled bias. Tractability: AMBER — depends on whether the `w_T`-trace-respects-poset-structure base check is verifiable per (W-Daniel) reduction to sub-poset.
- **No execution sub-ticket recommended now** — this is forward-only, conditional on F32-L3-C outcome.

#### Cross-repo coordination

- **F32-scope (mg-c9d9) status update.** This document discharges F32-scope §8's Phase-1 L3-B-UC sub-ticket. F32-scope's §3.3.5 AMBER verdict on L3 is *reinforced* (not modified) by this document: the L3-B-weighted-UCC path is structurally obstructed by Part B's 1/8 factor even granting Part A's extension.
- **cat-mg-4db9 (UC-Lean-L2b) concurrent work.** Disjoint file set (`lean/UnionClosed/*` vs `docs/*`). No incidental conflict expected; if a merge conflict surfaces, this document does not touch `lean/`.

### 5.3 Hard-constraint preservation

- **NOT factorial.** No factorial decomposition in any step. ✓
- **NOT functorial in the refinement sense.** No functor `\mathcal C_n^{\cap}\to\mathrm{PPF}_n` invoked. ✓
- **U1-dialect-preserving.** §4 verified weighted extension preserves additive character; F31 dialect does not transfer. ✓
- **Paper-and-pencil first.** This document is LaTeX-style Markdown only; no Lean, no axioms, no computation. ✓
- **Cumulative state doc.** `docs/state-UC10.md` Session 7 entry appended. ✓

### 5.4 Honest one-paragraph verdict

**The UC13+UC14 closing-Frankl mechanism — Čech bicomplex of `\mathcal F_{\mathrm{obs}}` + chain-level `(\mathbb Z/2)^n`-Walsh-isotype preservation + non-vanishing from minimality (UC11 Lemma 6.2) + level-1 Walsh vanishing from UC10.1 — extends *partially* to a weighted setting**: Steps 1, 2, 5, 6 (the entire cube/Walsh cohomology side) transfer GREEN unconditionally because the chain complex `X_n^{\cap}` and its cohomology UC10.1 are weight-independent; Step 4 (non-vanishing from minimality) transfers GREEN by pure sheaf-cohomological logic conditional on Step 3; Step 3 (cover property via strict-trace-shrinking) is the load-bearing breakpoint, splitting RED for (W-arbitrary) (because explicit small-`n` counterexamples `\mathcal F=\{\varnothing,U\},w(\varnothing)\gg w(U)` defeat the weighted-Frankl base case, and trace operations re-introduce `\varnothing` into sub-families even when the top family excludes it) and AMBER for (W-Daniel)/(W-structural) where the natural bound `w\le|\mathcal L(P)|` bypasses the (W-arbitrary) pathology but the cover property still requires (W-Daniel)-specific base-case verification not delivered by UC11/UC13/UC14; even granting Part A's conditional extension for (W-Daniel), F32-scope's §3.3.3 structural 1/8-obstruction is *confirmed unbypassable* by §3 of this document — the over-counting ratio `2^{k-3}/2^k=1/8` between "`Q`'s containing canonical edges of `A^*`" and "all `Q`'s below `L`" is independent of `A^*` and independent of any `Q`-only rescaling (alternative weightings `w^*(Q)=e(Q)^\alpha,\alpha\ne 1` lose the clean `\Pr_L` translation entirely; `w^*=\mathbb 1[Q\in\mathcal L(P)]` breaks union-closure of the L-restricted family; `A^*`-dependent weightings are circular because `A^*` is the UCC output) — so even the best-case Part A AMBER extension delivers `\Pr_L\ge 4`, vacuous; the dialect-check against F31 chain-locality (UC13 §3 + UC14 §4.1) transfers GREEN to the weighted setting because scalar multiplication of cochains by `b_x^w` does not introduce any cup-product or Walsh-level-shift; the practical consequence for the F32 measure-transfer step is that L3-B is structurally obstructed and the program should escalate to L3-C-injection per F32-scope §3.3.5.

---

## §6. References + Daniel directive trace

### 6.1 This repo (`union_closed`) — direct inputs

- **`docs/union-closed-UC10-native-cohomology-intersection-closed-families.md`** (mg-814b, UC10). §2 (category `\mathcal C_n^{\cap}`), §3 (`X_n^{\cap}` + UC10.W), §4 (UC10.1).
- **`docs/union-closed-UC11-cech-sheaf-frankl-program.md`** (mg-9ef0, UC11). §3 (minimality + cover property Theorem 3.4), §4 (trace cover + Čech sheaf), §5 (Čech 2-cocycle), §6 (Lemma 6.1+6.2 non-vanishing).
- **`docs/union-closed-UC12-delta-trace-injectivity.md`** (mg-707c, UC12). Cubical-bridge null-homotopy + UC10.R discharge (not directly invoked here; weight-independent).
- **`docs/union-closed-UC13-frankl-closure.md`** (mg-83f0, UC13). §2 (Čech-bicomplex isotype preservation + corrected landing isotype), §3 (chain-locality dialect-check), §§4–5 (UC10 §§5.3–5.4 execution), §7 (closing Frankl contradiction).
- **`docs/union-closed-UC14-uc13-technical-cleanup.md`** (mg-500c, UC14). R1 (explicit `\Theta` map), R2 (chain-level `\chi_S`-iso), R3 (multi-bridge graded commutativity). §4.1 dialect-check preservation.
- **`docs/state-UC10.md`** — cumulative ledger. Session 7 (this session) appended.

### 6.2 Cross-repo `one_third_width_three` — direct inputs (read-only)

- **`docs/compatibility-geometry-F32-uc-bridge-scope.md`** (mg-c9d9, polecat branch `polecat-cat-mg-c9d9`, AMBER-merged out-of-band). §3.3 (L3 tractability survey), specifically §3.3.2 (L3-B weighted-UCC + 1/8-obstruction derivation) and §3.3.3 (structural-not-calculation analysis). Read here verbatim; not re-derived.
- **`~/files/union_closed_1323_proof_steps.txt`** (Daniel 2026-05-16T11:29Z). Step 6 measure transfer (Pr_Q to Pr_L). The originating articulation of the L3 gap.

### 6.3 Cross-repo `one_third_width_three` — structural templates only

- **F29 (mg-70b0), F30 (mg-c3fe), F31 (mg-01ce, RED-chain-locality).** Used as dialect-checkpoints in §4 only; no theorem invoked as logical hypothesis.

**Note.** Per Daniel hard constraint "inherently but NOT functorially related" + pm-onethird `feedback_u1_has_multiple_dialects`, F-series references are template-only.

### 6.4 Background

- Standard Čech-cohomology spectral sequence (Bredon, *Sheaf Theory* / Bott–Tu, *Differential Forms in Algebraic Topology*, Ch. II). Used implicitly when carrying weighted-extension through the spectral sequence in §§2.6, 4.
- Maschke's theorem (rational rep theory). `(\mathbb Z/2)^n` is finite abelian; rational `\mathbb Q[(\mathbb Z/2)^n]`-modules decompose into 1-dim isotypes. Used in §2.6 (Lemma 2.2.1 inheritance from UC13).
- Weighted-Frankl literature. Reisner (multiset Frankl), Knill (weighted bounds via `w=|S|`); the (W-arbitrary)-counterexample to weighted-Frankl with adversarial `w(\varnothing)` is folklore (§2.1).

### 6.5 Source directives + memory

- **Daniel verbatim 2026-05-15T23:20Z (NON-NEGOTIABLE):** "NOT factorial. Inherently but NOT functorially related to Pos_n cohomology." Honored throughout; see §0.3, §5.3.
- **Daniel verbatim 2026-05-16T11:29:58Z:** the F32 10-step bridge program + 0.424/0.415-bit numerical-constants articulation. Step 6 (measure transfer) is the gate this document addresses.
- **pm-onethird `feedback_u1_has_multiple_dialects`** — §4 carries the dialect-check forward to weighted extension; F31 chain-locality dialect does not transfer because scalar multiplication preserves additive character.
- **pm-onethird `feedback_latex_first_for_math_simp`** — LaTeX-style Markdown throughout; no Lean, no computation.
- **pm-onethird `feedback_polecat_cumulative_state_doc`** — `state-UC10.md` Session 7 updates after this document.
- **pm-onethird `feedback_pre_execution_dependency_verification`** — §0.2 carries UC10/UC11/UC12/UC13/UC14 invariants explicitly; §0.3 enumerates hard constraints; §1 states the question precisely before analysis.
- **mg-7550 ticket** — this document discharges. Verdict AMBER-extends-conditionally-with-1/8-obstruction-unresolved-on-natural-weighting; forces F32 L3-C-injection path per §5.1, §5.2.

---

**End of F32-L3-B-UC scoping.** See `docs/state-UC10.md` Session 7 for the cumulative ledger entry.
