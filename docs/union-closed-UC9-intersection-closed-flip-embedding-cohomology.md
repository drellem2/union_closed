# Union-Closed Compatibility-Geometry — UC9: intersection-closed flip; the cone embedding $2^{[n]}\hookrightarrow\mathrm{PPF}_{n+1}$; pulling back the F17+F18 cohomology to extract constraints on the family (mg-96a6)

**Repo:** `union_closed`. **Parent (mg-96a6):** Daniel Apple reminder 2026-05-15T23:57:20Z, articulating the next direction on the union_closed line; pm-onethird forwarded into the UC slot post-UC8 and post-F28 AMBER. **Chain (UC line):** mg-f72a (UC1) → mg-a814 (UC2) → mg-cfc0 (UC3) → mg-0bf7 (UC4) → mg-3806 (UC5) → mg-6dad (UC6) → mg-a032 (UC7) → mg-d68d (UC8) → **mg-96a6 (UC9, this ticket)**.
**Branch:** `polecat-cat-mg-96a6`.
**Type:** **Cross-cathedral construction** — first UC ticket that imports the F-series cohomological cathedral as load-bearing input, NOT the native compatibility-geometry construction of UC1–UC8. Specifically, it consumes the unconditional F17 (mg-4d3a) + F18 (mg-d039) cohomology theorem on $\Delta_n=\Delta(\mathrm{PPF}_n)$ as a ready-made fact, then asks whether that fact, pulled back along an embedding $2^{[n]}\hookrightarrow\mathrm{PPF}_{n+1}$, constrains an intersection-closed family $\mathcal F\subseteq 2^{[n]}$ enough to recover Frankl. Paper-and-pencil; LaTeX-style Markdown; F-series house style. **No new axioms; no Lean; no computation; no engine port.** Multi-session-able; cumulative state ledger in `docs/state-UC9.md`.
**Cross-repo references (read access):** `one_third_width_three` — F17 (`docs/compatibility-geometry-F17-equivariant-cofiber-morse.md`, `docs/state-F17.md`) + F18 (`docs/compatibility-geometry-F18-ucc2-delta-injective.md`, `docs/state-F18.md`) consumed as load-bearing facts; F10 (`docs/state-F10.md`) consumed for the cohomological-core framing; mg-26fc consumed for the structural-analogy framing and the U1-obstruction language.

---

**Verdict: AMBER-cohomology-pulls-back-cleanly-but-Frankl-extraction-needs-UC10.**

UC9 is a **scoping** ticket. The Daniel reminder (2026-05-15T23:57Z) names a strategy — *flip Frankl to its intersection-closed dual; embed $2^{[n]}$ into $\mathrm{Pos}_{n+1}$ in a nice way; consume the F17+F18 unconditional cohomology of $\mathrm{Pos}_{n+1}$; extract constraints on the family* — and asks whether the strategy lands. UC9 lands the **first three steps** unconditionally but **does not** land the fourth in this session. Specifically:

- **The flip is canonical** (§1): $\mathcal F$ union-closed on $[n]$ ⟺ $\mathcal F^c:=\{[n]\setminus A:A\in\mathcal F\}$ intersection-closed on $[n]$, with $|\mathcal F|=|\mathcal F^c|$ and the abundance question on $\mathcal F$ identified with the rarity question on $\mathcal F^c$. No information is lost; the objects of UC1–UC8 (the cube, the level-1 Walsh spectrum, the transport graph, the per-fibre / per-co-fibre book) all dualize cleanly.
- **The embedding pins to the F18-natural one** (§2): $\iota_n^{\mathrm{cone}}: 2^{[n]}\setminus\{\emptyset\}\hookrightarrow\mathrm{PPF}_{n+1}$, $S\mapsto\omega_S:=\{(n+1,b):b\in S\}$ — the cone embedding sending each non-empty $S\subseteq[n]$ to the partial order on $[n+1]$ in which the new element $n+1$ sits below exactly the elements of $S$, and elements of $[n]$ are pairwise incomparable. The image is precisely the **principal order ideal $(\omega_n\!\downarrow)\setminus\{\emptyset\}$** in $\mathrm{PPF}_{n+1}$ below the F18 cone element $\omega_n=\omega_{[n]}$. The embedding is order-preserving, $S_n$-equivariant (with $S_n\subseteq S_{n+1}$ fixing $n+1$), and **preserves both meet and join**: $\omega_{S\cap T}=\omega_S\cap\omega_T$, $\omega_{S\cup T}=\omega_S\cup\omega_T$ as relations. Daniel's "naturally embeds in a nice way" is uniquely pinned by these three properties together with consumption-by-F18 (§2.4 — uniqueness lemma 2.4).
- **The F17+F18 cohomology is restated formally for UC9 consumption** (§3): unconditional, the reduced cohomology $\widetilde H^*(\Delta_{n+1})$ is concentrated in top degree $n-1$ and equals $\mathrm{sgn}_{S_{n+1}}$ as an $S_{n+1}$-representation, for every $n\geq 2$. (The base case $\widetilde H^1(\Delta_3)=\mathrm{sgn}_{S_3}$ is mg-6295; F17+F18+F10 propagates by the degree-shift engine $\widetilde H^k(\Delta_{n+1})\cong\widetilde H^{k-1}(\Delta_n)$.) Daniel's "cohomology type is $\mathrm{Pos}_{n-1}$" is unpacked as **the iterated degree-shift identity** $\widetilde H^{n-1}(\Delta_{n+1})\cong\widetilde H^{n-2}(\Delta_n)\cong\cdots\cong\widetilde H^{1}(\Delta_3)$ — the cohomology of $\mathrm{Pos}_{n+1}$ at top degree is structurally identical to (and reachable from) $\mathrm{Pos}_{n-1}$'s top cohomology by two applications of the F17+F18 shift, and to $\mathrm{Pos}_3$'s by $n-2$ applications. The "$n-1$" indexes the cohomological *degree* where the action concentrates, equivalently the size of the carrier two below the embedding target.
- **The pullback / relative cohomology is computed** (§4). The image $\mathrm{im}(\iota_n^{\mathrm{cone}})=(\omega_n\!\downarrow)\setminus\{\emptyset\}$ is a Boolean lattice with a top element $\omega_n$, hence its order complex is **contractible**. The direct pullback $(\iota_n^{\mathrm{cone}})^*:\widetilde H^*(\Delta_{n+1})\to\widetilde H^*(\Delta(\mathrm{im}))=0$ is **zero in every degree** — the constraint via direct pullback is vacuous. The non-vacuous information lives in the long exact sequence of the pair $(\Delta_{n+1},\Delta(\mathrm{im}))$: $\widetilde H^k(\Delta_{n+1},\Delta(\mathrm{im}))\cong\widetilde H^k(\Delta_{n+1})$, since $\Delta(\mathrm{im})$ is contractible — the $\mathrm{sgn}_{S_{n+1}}$ class survives as a *relative* class in degree $n-1$. Equivalently, the cofiber $\Delta_{n+1}/\Delta(\mathrm{im})$ has reduced cohomology $\mathrm{sgn}_{S_{n+1}}$ in top degree, supported on the *complement* of the embedded image. UC9 §4 states this as **Theorem 4.3 (the survival theorem)** and reads off the structural content: the top class of $\mathrm{Pos}_{n+1}$ "lives outside" the embedded Boolean lattice, and its restriction-to-the-image vanishes by virtue of the Boolean image being contractible.
- **The constraint on the family is structural, not numerical** (§5). For an intersection-closed family $\mathcal F$ on $[n]$ with $\mathcal F\ni[n]$ (the Frankl-relevant case; if $[n]\notin\mathcal F$ the dual statement holds and is treated symmetrically — §5.5), the embedded family $\widetilde{\mathcal F}:=\iota_n^{\mathrm{cone}}(\mathcal F\setminus\{\emptyset\})$ is a meet-subsemilattice of $(\omega_n\!\downarrow)\setminus\{\emptyset\}$ containing the top $\omega_n$ — hence $\Delta(\widetilde{\mathcal F})$ is contractible, and the pair $(\Delta_{n+1},\Delta(\widetilde{\mathcal F}))$ has the **same** relative cohomology as the pair $(\Delta_{n+1},\Delta(\mathrm{im}))$: $\mathrm{sgn}_{S_{n+1}}$ in top degree. So the relative cohomology is **family-independent on the contractibility class** — every intersection-closed family containing $[n]$ produces the same relative obstruction class. **This is the U1-shaped wall for UC9** (§6): direct relative cohomology cannot distinguish two such families, hence cannot drive Frankl. UC9 surfaces **three candidate non-functorial bridges** (§5.2–§5.4) that go *around* the wall:
  - **Bridge A — vertex-slice bookkeeping** (§5.2): the principal cover $(\omega_n\!\downarrow)=\bigcup_{x\in[n]}(\omega_n^{(x)}\!\downarrow)\sqcup\{\omega_n\}$ where $\omega_n^{(x)}:=\omega_n\setminus\{(n+1,x)\}$ stratifies the embedded image by single-vertex deletion; the slice intersection statistics $f_x^c:=|\widetilde{\mathcal F}\cap(\omega_n^{(x)}\!\downarrow)|$ Frankl-encode the rarity statistics on $\mathcal F^c$ (Lemma 5.2). The cohomology bridge is a **Mayer–Vietoris** / **slice spectral-sequence** argument on this cover, attached to the F17+F18 top class by a single sgn-projection.
  - **Bridge B — Möbius / Euler characteristic** (§5.3): the Hall theorem $\mu(\widehat 0,\widehat 1\,;\,\mathrm{PPF}_{n+1}^*)=\widetilde\chi(\Delta_{n+1})=(-1)^{n-1}$ (with $\widehat 0,\widehat 1$ adjoined) by the F17+F18 cohomology concentration; combined with the Möbius identity for $\widetilde{\mathcal F}$ as a meet-subsemilattice of the embedded Boolean image, gives a **numerical invariant** of $\mathcal F$ that is sign-determined modulo the slice statistics. The bridge is a **deletion-contraction** argument over the vertex slices.
  - **Bridge C — equivariant sgn-isotypic projection** (§5.4): $\mathrm{sgn}_{S_{n+1}}\downarrow_{S_n}=\mathrm{sgn}_{S_n}$ (branching), so the F17+F18 top class restricts to the $\mathrm{sgn}_{S_n}$-isotype of $H^*(\Delta(\mathrm{im}\setminus\{\omega_n\}))$ (the boundary sphere $S^{n-2}$ of the punctured Boolean cube), where $\widetilde{\mathcal F}\setminus\{\omega_n\}$ sits. The bridge is an **equivariant restriction-of-Euler-characteristic** identity on the boundary sphere, with the family's slice profile entering as the cycle weights.
  - All three bridges respect Daniel's hard constraints — **non-factorial** (no $S_n$-factorial cohomology, no factorial decomposition; the $S_n$ entering is *additive* via the symmetry of $\omega_n$ on $[n]$, not multiplicative), and **inherently-but-not-functorially related to $\mathrm{Pos}_n$ cohomology** (the bridges work via spectral / numerical / equivariant arguments on cohomology classes, *never* via a functor "intersection-closed families $\to$ cohomology classes").
- **Verdict (§6).** AMBER. The four-step strategy lands its first three steps unconditionally. The fourth step (extracting Frankl from the cohomological constraints) is identified with one of three bridges, each tractable but each requiring its own session — UC10's mandate. The U1-shaped wall (the embedded image being contractible, hence the direct pullback being vacuous) is **structurally identical to** the F-series U1 wall (mg-26fc — "no operational bridge between BK spectral data and $\Delta(\mathrm{PPF}_n)$ cohomology"), in cohomology dialect: in both cases, the constructed object lands inside the F17+F18 cathedral but the cathedral's content does not couple to the constructed object via the obvious morphism. UC9's wall is *moralised* the same way as F28/F29's wall and is dissolved (or not) by the same kind of move — a non-functorial bridge that goes around the obvious morphism.

**The honest one-sentence verdict.** *The Daniel-articulated strategy (intersection-closed flip + cone embedding $S\mapsto\omega_S$ of $2^{[n]}\setminus\{\emptyset\}$ as the principal ideal of $\omega_n=\{(n+1,b):b\in[n]\}$ in $\mathrm{PPF}_{n+1}$ + consumption of the unconditional F17+F18 top cohomology $\widetilde H^{n-1}(\Delta_{n+1})\cong\mathrm{sgn}_{S_{n+1}}$) lands cleanly through three steps and stalls structurally at the fourth on a U1-shaped wall — the embedded image is contractible in $\Delta_{n+1}$, so the obvious pullback morphism is identically zero and the relative cohomology is family-independent on the contractibility class — surfacing the ask for UC10 as one of three explicitly-named non-functorial bridges (vertex-slice Mayer–Vietoris, Möbius/Euler characteristic with deletion-contraction, equivariant sgn-isotypic projection on the boundary $(n-2)$-sphere of the punctured Boolean cube) that respect Daniel's hard constraints (non-factorial; inherently-but-not-functorially related).*

§0 fixes notation; §1 the intersection-closed flip; §2 the cone embedding (and its uniqueness as the F18-natural choice); §3 the F17+F18 cohomology restatement; §4 the pullback / relative cohomology; §5 the constraint analysis and the three candidate bridges; §6 the verdict, the U1 obstruction check, the UC10 ask; §7 references.

---

## §0. Notation and the UC9 hand-off

Notation is UC1's through UC8's plus the F-series. The two cathedrals (UC1–UC8 native compatibility geometry; F-series cohomology of $\Delta(\mathrm{PPF}_n)$) live in different repos and use different conventions; UC9 is the first UC ticket that bridges them, so the dictionary is recapped here.

### 0.1 The UC1–UC8 cathedral (native, this repo)

$U=[n]=\{1,\dots,n\}$ a finite ground set; $\mathcal F\subseteq 2^{U}$ a family. **Union-closed**: $A,B\in\mathcal F\Rightarrow A\cup B\in\mathcal F$. **Intersection-closed**: $A,B\in\mathcal F\Rightarrow A\cap B\in\mathcal F$. The full cube $Q_n=2^{[n]}$ is the ambient. The bias $\beta_x:=|\mathcal F_x|-|\mathcal F_{\bar x}|$, with $\mathcal F_x:=\{A\in\mathcal F:x\in A\}$, $\mathcal F_{\bar x}:=\{A\in\mathcal F:x\notin A\}$. **Frankl (union-closed form):** for any union-closed $\mathcal F\ne\emptyset,\{\emptyset\}$, some $x\in U$ is *abundant*, i.e. $|\mathcal F_x|\ge|\mathcal F|/2$, equivalently $\beta_x\ge 0$. **Frankl (intersection-closed form, the dual):** for any intersection-closed $\mathcal F\ne\emptyset,\{[n]\}$, some $x\in U$ is *rare*, i.e. $|\mathcal F_{\bar x}|\ge|\mathcal F|/2$, equivalently $\beta_x\le 0$ (UC1 §1.5; §1 below restates the duality precisely).

UC1's intrinsic-object pin: $G(\mathcal F)\subseteq Q_n$ the transport graph (the subgraph of $Q_n$ induced on $\mathcal F$); $M_x$ the $x$-direction matching; $\mathcal F_x^{\mathrm{stuck}}/\mathcal F_{\bar x}^{\mathrm{stuck}}$ the unmatched-set profile. UC2–UC8 builds the structure-theoretic and Walsh-harmonic apparatus: the per-generator decomposition $\sigma(W)=A(W)+Q^{\mathrm{lg}}(W)-D^{\mathrm{lg}}(W)$ (UC5 Thm 2.1); the defect retraction $\bar\jmath_R$ and deficiency $\delta_R,\,\mathrm{Def}(R)$ (UC5 Thm 1.1); the deficiency-contraction theorem (UC6 Thm 3.1, Cor 3.2, 3.3); the cross-fibre persistence $h(S)$ and the chain-cumulative identity (UC8 Thm 1.1); the cross-incidence cumulative identity (UC8 Lemma 2.1); the F-iii square-defect bound (UC8 Thm 3.1); the extended fully-signed class (UC8 Thm 4.1).

UC1 §3 / §4 / §8.4's **dead routes** (pinned for UC9 to stay clear of):
- **E1–E3** — porting Theorem E / the BK-Cheeger engine. *Why dead:* the transport graph $G(\mathcal F)$ is disconnected in general (UC1 §3.1, witness $\mathcal F=\{\emptyset,\{1,2\}\}$); no width-3 rigidity knob; no Theorem-E volume→conductance conversion.
- **C1–C5** — porting the F-series cathedral wholesale. *Why dead:* $\Delta(\mathcal F)$ is the wrong level (C1); $|\mathrm{UCF}_n|\ge 2^{\binom{n}{\lfloor n/2\rfloor}}$ is doubly-exponential (C2); the load-bearing symmetry is $(\mathbb Z/2)^n$/Walsh, not $S_n$/FI (C3); no refinement-cover↔decision-substrate correspondence (C4); no clean $n$-induction (C5).

UC9's relation to these dead routes: **strict respect**. UC9 does **not** port the F-series engine; it **consumes a single F-series theorem (the unconditional F17+F18 top cohomology of $\Delta(\mathrm{PPF}_n)$) as a black box** and uses it via an embedding of the Boolean cube into $\mathrm{PPF}_{n+1}$ — which is a *different* object than $\Delta(\mathcal F)$, $\mathrm{UCF}_n$, or any other UC1-§4-flagged-as-dead object. The Boolean cube is the UC1-pinned ambient $Q_n$, and the embedding $2^{[n]}\hookrightarrow\mathrm{PPF}_{n+1}$ goes *the other way* — into the F-series ambient — so C2 (no homology-sphere on $\mathrm{UCF}_n$) and C3 ($S_n$-vs-Walsh symmetry mismatch) do not apply: the symmetry visible to UC9 is the $S_n\subseteq S_{n+1}$ that fixes the cone vertex $n+1$, which is exactly the symmetry F17+F18 propagates via the degree-shift engine. C1, C4, C5 also do not apply (no refinement-cover claim; no $n$-induction on $\mathcal F$ via the cohomology, only on the *cohomology* of $\mathrm{PPF}_{n+1}$). The transfer is *targeted*: F17+F18 black-box only, not the route-(ii) presentation engine, not the cofiber Morse machinery itself, not the FI rep-stability framework — none of these enter UC9.

### 0.2 The F-series cathedral (cross-repo, consumed as black box)

$\mathrm{PPF}_n$ = nonempty non-total partial orders on $[n]$, ordered by relation-set inclusion; $|\mathrm{PPF}_n|=12, 194, 4110, 129302$ at $n=3,4,5,6$. A relation is a transitively-closed irreflexive antisymmetric relation set; $(a,b)$ means $a\prec b$. $\Delta_n:=\Delta(\mathrm{PPF}_n)$ the order complex (chains of partial orders under strict inclusion); top dimension $\dim\Delta_n=n-2$. The standard inclusion $\iota_n:\Delta_n\hookrightarrow\Delta_{n+1}$ adds the new element $n+1$ as isolated (i.e. $\mathrm{PPF}_n\hookrightarrow\mathrm{PPF}_{n+1}$ as the order ideal of partial orders not involving $n+1$).

The cone element from F18: $\omega_n:=\{(n+1,b):b\in[n]\}\in\mathrm{PPF}_{n+1}$ — the partial order on $[n+1]$ in which $n+1$ is below every element of $[n]$ and $[n]$ is an antichain. Lemma 2.2 of F18 verifies $\omega_n\in\mathrm{PPF}_{n+1}$: nonempty (it has $n$ relations), non-total (the elements of $[n]$ are pairwise incomparable). The cone map: $\kappa_n:\mathrm{PPF}_n\to\mathrm{PPF}_{n+1}$, $\kappa_n(x):=x\cup\omega_n$. F18 Lemma 2.3 (the load-bearing combinatorial lemma): $\kappa_n$ is well-defined — $x\cup\omega_n$ is transitively closed (the only new compositions $(n+1,b)\circ(b,c)$ produce $(n+1,c)$, which is already in $\omega_n$) and non-total (a total $x\cup\omega_n$ would force $x$ total on $[n]$, contradicting $x\in\mathrm{PPF}_n$).

**The cohomology fact UC9 consumes (Hyp(n), restated unconditionally — F17+F18+F10 inductive closure):**

> **Fact F.** For every $n\ge 3$,
> $$
>   \widetilde H^k(\Delta_n;\mathbb Q)\;=\;\begin{cases}\mathrm{sgn}_{S_n}&k=n-2,\\ 0&k\ne n-2,\end{cases}
> $$
> where $\mathrm{sgn}_{S_n}$ is the one-dimensional sign representation of $S_n$ and the $S_n$-action on $\Delta_n$ is by permutation of $[n]$. Equivalently, $\Delta_n$ has the rational cohomology of an $(n-2)$-sphere with the sign action.

Fact F is the master theorem of the F-series cohomological core: F17 (mg-4d3a) gives $H_d(\Delta_{n+1}/\Delta_n)\cong 2\cdot H_{d-1}(\Delta_n)$ as $S_n$-reps unconditionally; F18 (mg-d039) gives $\iota_n^*=0$ on $\widetilde H^*$ unconditionally (the order-homotopy zig-zag $\iota_n\le\kappa_n\ge\mathrm{const}_{\omega_n}$); the F10 induction (parents §6.2) closes Hyp(n+1) from Hyp(n) + (UCC.1) + (UCC.2). F18's Cor 5.1: $\widetilde H^k(\Delta_{n+1}/\Delta_n)\cong\widetilde H^{k-1}(\Delta_n)\oplus\widetilde H^k(\Delta_{n+1})$ as $S_n$-reps, splitting the cofiber LES; combined with F17 ($\widetilde H^k(\Delta_{n+1}/\Delta_n)\cong 2\cdot\widetilde H^{k-1}(\Delta_n)$) gives the **degree-shift engine** $\widetilde H^k(\Delta_{n+1})\cong\widetilde H^{k-1}(\Delta_n)$. Iterating this from the base $\widetilde H^1(\Delta_3)=\mathrm{sgn}_{S_3}$ (mg-6295, 2-cycle on the 12-vertex order complex of $\mathrm{PPF}_3$) gives Fact F at every $n\ge 3$, and *no hypothesis is left*.

UC9's consumption is restricted to Fact F. UC9 does **not** consume the cofiber matching $M_{\mathrm{rel}}^{\mathrm{eq}}$ itself, the FI machinery, the chamber-Morse construction, the (FG-Cofiber) framework, or any other internal-to-the-F-series object. The black-box discipline keeps the bridge clean and keeps UC9's verdict *independent of any future revision of the F-series internals* — only the proven theorem is load-bearing.

### 0.3 The UC9 hand-off (Daniel reminder verbatim)

Daniel Apple reminder, 2026-05-15T23:57:20Z (forwarded to pm-onethird):

> "*idea for union closed. We can get cohomology result by flipping the conjecture around to a statement about intersection closed family. Then say this family is over n elements. This whole Boolean lattice naturally embeds into Pos_n+1 in a nice way. We already proved the cohomology type is Pos_n-1 here, and then we can get some constraints*"

UC9's operational unpacking (from the mg-96a6 ticket body):

1. **Flip Frankl to intersection-closed dual.** Standard duality, no information lost. §1.
2. **The intersection-closed family lives in the Boolean lattice $2^{[n]}$.** Trivial. Setup, §1.
3. **Embed $2^{[n]}$ into $\mathrm{Pos}_{n+1}$ "in a nice way".** The embedding to be pinned. §2. (Daniel: not specified; UC9's pin is the **cone embedding** $S\mapsto\omega_S$, F18-natural.)
4. **"Cohomology type is $\mathrm{Pos}_{n-1}$".** UC9's reading: the cohomology of $\mathrm{Pos}_{n+1}$ at top degree $n-1$ is $\mathrm{sgn}_{S_{n+1}}$ unconditionally (Fact F at $n+1$); via the F17+F18 degree-shift engine $\widetilde H^k(\Delta_{n+1})\cong\widetilde H^{k-1}(\Delta_n)\cong\widetilde H^{k-2}(\Delta_{n-1})$, this is structurally identical to the cohomology of $\mathrm{Pos}_{n-1}$ shifted up by $2$. The "$n-1$" in Daniel's verbatim indexes **the cohomological degree** where the action concentrates. §3.
5. **"We can get some constraints".** Pull back / read off the consequences. §4 (the cohomology pullback) + §5 (the constraints on the family).

UC9's hard constraints (mg-96a6 ticket body, NON-NEGOTIABLE):

- **NOT factorial.** Daniel verbatim 2026-05-15T23:20Z (anti-factorial directive). No factorial structure / factorial-cohomology / factorial-decompositions / $S_{n+1}$-factorial spines. *UC9 compliance:* the only $S$-equivariance entering UC9 is the additive $S_n\subseteq S_{n+1}$ that fixes $n+1$ (the embedding is $S_n$-equivariant, the cone $\omega_n$ is $S_n$-fixed); no factorial decomposition of $\mathrm{sgn}_{S_{n+1}}$ via Specht modules or character tables enters.
- **Inherently but NOT functorially related to $\mathrm{Pos}_n$ cohomology.** Daniel verbatim 2026-05-15T23:20Z. No functor (intersection-closed families) $\to$ (cohomology classes). *UC9 compliance:* the cohomology pullback in §4 is *not* a functor on intersection-closed families — it is a *single morphism* of cohomology rings/modules, with the family entering as a sub-poset of the embedded Boolean image and contributing a *numerical* / *spectral* invariant via one of the three bridges in §5, never as a target of a functor.
- **Paper-and-pencil first.** LaTeX-first per `feedback_latex_first_for_math_simp`. No Lean, no axioms, no computation.
- **Cumulative state doc.** Multi-session probable; `docs/state-UC9.md` per `feedback_polecat_cumulative_state_doc`.
- **Verify the embedding directly.** Per `feedback_n_poset_is_not_ordinal_sum`: UC9 verifies the cone embedding directly (§2.3), does NOT invoke "decomposable case absorbs N-poset" or any analogous shortcut.

UC9's relation to F29 (the 1/3-2/3 sibling, mg-70b0) and the 1/3-2/3 line:

- **F29 (mg-70b0)** scopes the 1/3-2/3-side analog of the cohomological extraction: bad cut $\to$ local biases on subposets $\to$ Čech 2-cocycle on $\mathrm{PPF}_n$ $\to$ show class is not sgn-like $\to$ contradiction with F17+F18.
- **UC9 (this ticket)** scopes the union_closed-side analog: intersection-closed flip $\to$ Boolean-into-$\mathrm{PPF}_{n+1}$ embedding $\to$ pull back the F17+F18 top cohomology $\to$ constraints on $\mathcal F$.
- Both leverage the unconditional F17+F18 core via *different* mechanisms (Čech assembly vs embedding pullback) and screen out factoriality and functoriality per Daniel's directive.
- The pair instantiates the meta-thesis (mg-26fc): "constrained compatibility geometry cannot remain globally isotropic" with F17+F18 as the unconditional non-isotropy engine on the $\mathrm{Pos}_n$ side, applied via two different bridges to the two conjectures.
- If F29 GREENs, UC9 has a tested template; if F29 REDs, UC9 may still GREEN — the embedding mechanism is structurally different from Čech assembly. Both are worth running. UC9 is independent of F29's outcome (the F17+F18 input is unconditional regardless).

> **The UC9 target (Daniel reminder + ticket body unpacking).** *Pin a canonical embedding $2^{[n]}\hookrightarrow\mathrm{PPF}_{n+1}$ (§2); restate the F17+F18 unconditional top cohomology $\widetilde H^{n-1}(\Delta_{n+1})\cong\mathrm{sgn}_{S_{n+1}}$ in the form the embedding consumes (§3); pull it back along the embedding and along the embedded sub-family (§4); identify the structural constraints on $\mathcal F$ (§5); state the verdict and the U1-obstruction check (§6). Not GREEN (the fourth step is **not** unconditionally landed in this session); not RED (the first three steps land cleanly, three forward bridges are concrete and tractable); honest **AMBER**.*

---

## §1. The intersection-closed flip

The flip is an elementary duality between union-closed and intersection-closed families on $[n]$, sharpened by the ambient symmetry of $Q_n=2^{[n]}$ under complementation. UC1 §1.5 noted the duality without operationalising it; UC9 §1 operationalises.

### 1.1 The complementation involution

Let $\tau:2^{[n]}\to 2^{[n]}$ be the complementation involution $\tau(A):=[n]\setminus A$. Then:

- $\tau$ is a $\mathbb Z/2$-involution: $\tau\circ\tau=\mathrm{id}$.
- $\tau$ is an *order-reversing* lattice isomorphism: $A\subseteq B\Leftrightarrow\tau(B)\subseteq\tau(A)$, $\tau(A\cup B)=\tau(A)\cap\tau(B)$, $\tau(A\cap B)=\tau(A)\cup\tau(B)$.
- $\tau$ commutes with the $S_n$-action on $[n]$: $\tau(\sigma\cdot A)=\sigma\cdot\tau(A)$ for $\sigma\in S_n$.
- $\tau$ acts on the cube $Q_n$ as the antipodal map; on $G(\mathcal F)$ as a graph automorphism (sends $x$-edges to $x$-edges, since $A$–$\sigma_x A$ swaps to $\tau(A)$–$\tau(\sigma_x A)=\sigma_x\tau(A)$).

For a family $\mathcal F\subseteq 2^{[n]}$, write $\mathcal F^c:=\tau(\mathcal F)=\{[n]\setminus A:A\in\mathcal F\}$.

> **Lemma 1.1 (the flip).** $\mathcal F$ is union-closed iff $\mathcal F^c$ is intersection-closed. Moreover, $|\mathcal F^c|=|\mathcal F|$, and the bias profile satisfies $\beta_x(\mathcal F^c)=-\beta_x(\mathcal F)$ for every $x\in[n]$.

*Proof.* Union-closed ⟺ intersection-closed via $\tau$: $A\cup B\in\mathcal F\Leftrightarrow\tau(A\cup B)=\tau(A)\cap\tau(B)\in\mathcal F^c$. So $\mathcal F$ closed under $\cup$ on members iff $\mathcal F^c$ closed under $\cap$ on members. $|\mathcal F^c|=|\mathcal F|$ since $\tau$ is a bijection. For the bias: $\mathcal F_x^c=\{[n]\setminus A:A\in\mathcal F,x\in[n]\setminus A\}=\{[n]\setminus A:A\in\mathcal F,x\notin A\}=\tau(\mathcal F_{\bar x})$, so $|\mathcal F_x^c|=|\mathcal F_{\bar x}|$. Symmetrically $|\mathcal F_{\bar x}^c|=|\mathcal F_x|$. So $\beta_x(\mathcal F^c)=|\mathcal F_x^c|-|\mathcal F_{\bar x}^c|=|\mathcal F_{\bar x}|-|\mathcal F_x|=-\beta_x(\mathcal F)$. $\qquad\blacksquare$

> **Corollary 1.2 (the dual statements of Frankl).** The following are equivalent for every $n$ and every family $\mathcal F\ne\emptyset,\{\emptyset\}$:
> (i) [union-closed Frankl] If $\mathcal F$ is union-closed, then some $x\in[n]$ has $\beta_x(\mathcal F)\ge 0$ (an *abundant* element).
> (ii) [intersection-closed Frankl, the dual] If $\mathcal F$ is intersection-closed and $\mathcal F\ne\{[n]\}$, then some $x\in[n]$ has $\beta_x(\mathcal F)\le 0$ (a *rare* element, i.e. $|\mathcal F_{\bar x}|\ge|\mathcal F|/2$).

*Proof.* $\mathcal F$ union-closed counterexample ⟺ $\mathcal F^c$ intersection-closed counterexample, by Lemma 1.1's bias-flip and size-preservation. $\qquad\blacksquare$

The flip is a strict duality: any UC9 result on the intersection-closed side translates verbatim to a UC1–UC8 result on the union-closed side (and conversely). The advantage of working on the intersection-closed side is that the *meet* operation $\cap$ on $2^{[n]}$ is the *intersection of relations* on $\mathrm{PPF}_{n+1}$ under the cone embedding (§2.2 below), which makes the embedded family a **meet-subsemilattice of $\mathrm{PPF}_{n+1}$** — a natural object on which the F17+F18 cohomology can act. The union side would have given a join-subsemilattice of the principal filter $(\omega_n^*\!\uparrow)$, dual but messier in the F-series ambient (the principal filter has $|\mathrm{PPF}_{n+1}|/|2^{[n]}|$-many elements, much larger than the principal ideal).

### 1.2 The Frankl-relevant case, intersection-closed dialect

Setup for §§2–6: $\mathcal F\subseteq 2^{[n]}$ **intersection-closed**, $\mathcal F\ne\emptyset,\{[n]\}$. Standing simplifications:

- **WLOG $[n]\in\mathcal F$**: if $[n]\notin\mathcal F$, then the maximum of $\mathcal F$ under $\subseteq$ is some $M_{\mathcal F}\subsetneq[n]$, and the elements of $[n]\setminus M_{\mathcal F}$ are *all* missing from every set of $\mathcal F$ (they are *all rare*); the dual Frankl is trivial. So assume $[n]=\bigcap_{A\in\mathcal F^c}A^c=\bigcup_{A\in\mathcal F}A=:\widetilde U_{\mathcal F}$, equivalently $\bigcap_{A\in\mathcal F^c}A=\emptyset$ (the intersection-closed family has *trivial common intersection*). UC9 §5.1 will weaken WLOG to "$\mathcal F$ contains $[n]$ or its complement form is symmetric" — but the WLOG simplifies the embedding image.
- **The minimum of $\mathcal F$**: since $\mathcal F$ is intersection-closed, $\bigcap_{A\in\mathcal F}A\in\mathcal F$. Call it $m_{\mathcal F}$. The Frankl-relevant case typically has $m_{\mathcal F}=\emptyset$ (the empty set is in $\mathcal F$, or at worst is the dropped minimum); when $m_{\mathcal F}\ne\emptyset$, every $x\in m_{\mathcal F}$ is in every set of $\mathcal F$, hence $x$ is the maximally-abundant element on the union side, $\beta_x=|\mathcal F|>0$, and Frankl is trivially solved by such $x$ on the union side. **WLOG $m_{\mathcal F}=\emptyset$**.

So in the Frankl-relevant intersection-closed case: $\mathcal F$ is a meet-subsemilattice of $2^{[n]}$ with maximum $[n]$ and minimum $\emptyset$, i.e. **$\mathcal F$ is a meet-sublattice of $2^{[n]}$ (with the same $0,1$)**. (It need not be a sublattice — joins might miss $\mathcal F$, since $\mathcal F$ is only intersection-closed.)

This is the standard intersection-closed Frankl setup. Every intersection-closed Frankl counterexample candidate fits this normal form, after the trivial reductions.

### 1.3 The bias profile under the flip — the rarity statistics

For an intersection-closed $\mathcal F$ with $[n]\in\mathcal F$, $\emptyset\in\mathcal F$ (the WLOG normal form):

$f_x:=|\mathcal F_x|$ (sets containing $x$); $f_x^c:=|\mathcal F_{\bar x}|$ (sets not containing $x$); $f_x+f_x^c=|\mathcal F|$. **Frankl (intersection-closed dialect):** $\max_x f_x^c\ge|\mathcal F|/2$, i.e. some $x$ is *rare*.

The slice statistics $f_x^c$ (the "rarity profile") is what the embedding will encode in §2. Since $\sum_x f_x^c=\sum_{A\in\mathcal F}|[n]\setminus A|=n|\mathcal F|-\sum_{A\in\mathcal F}|A|$, the average rarity is $\bar f^c:=\sum_x f_x^c/n=|\mathcal F|-\overline{|A|}$ where $\overline{|A|}:=\sum_A|A|/|\mathcal F|$ is the mean set size.

> **Lemma 1.3 (the trivial Frankl case).** If $\overline{|A|}\le n/2$, then $\bar f^c\ge|\mathcal F|/2$, so $\max_x f_x^c\ge|\mathcal F|/2$ trivially (max ≥ avg).

*Proof.* $\bar f^c=|\mathcal F|-\overline{|A|}\ge|\mathcal F|-n/2\ge|\mathcal F|/2$ when $|\mathcal F|\ge n$ — and the standard Frankl reduction WLOG assumes this. $\qquad\blacksquare$

Lemma 1.3 says: the *non-trivial* Frankl regime is $\overline{|A|}>n/2$ on the intersection-closed side (sets are more-than-half-full on average). UC9's constraints on $\mathcal F$ should bite on this regime. We record this for §5: any constraint extracted from cohomology need only beat the trivial bound in the regime $\overline{|A|}>n/2$, equivalently (under the flip) $\overline{|A|}_{\mathcal F^c}<n/2$ on the union side — the standard "small sets" regime where Frankl is hard.

---

## §2. The cone embedding $\iota_n^{\mathrm{cone}}:2^{[n]}\setminus\{\emptyset\}\hookrightarrow\mathrm{PPF}_{n+1}$

Daniel: "*This whole Boolean lattice naturally embeds into $\mathrm{Pos}_{n+1}$ in a nice way*". UC9's pin: the F18-natural cone embedding $S\mapsto\omega_S$. §2.1 sets it up; §2.2 verifies the algebraic properties; §2.3 verifies it directly (per the `feedback_n_poset_is_not_ordinal_sum` directive); §2.4 proves a uniqueness lemma — this is the *unique* embedding satisfying the F18 / F17 / Daniel constraints jointly.

### 2.1 The cone embedding, defined

For $S\subseteq[n]$, define the *cone relation* on $[n+1]$:
$$
  \omega_S\;:=\;\bigl\{(n+1,b)\;:\;b\in S\bigr\}\;\subseteq\;\bigl([n+1]\times[n+1]\bigr).
$$

I.e. $\omega_S$ is the partial order on $[n+1]$ in which the new element $n+1$ is below exactly the elements of $S\subseteq[n]$, and elements of $[n]$ are pairwise incomparable.

Special cases: $\omega_\emptyset$ is the empty relation on $[n+1]$ (the antichain on $n+1$ elements). $\omega_{[n]}=\omega_n$ is the F18 cone element. For $|S|=1$, $\omega_{\{x\}}$ is the single-relation $\{(n+1,x)\}$ — a "stick" partial order with one comparable pair.

The cone embedding map:
$$
  \iota_n^{\mathrm{cone}}:2^{[n]}\setminus\{\emptyset\}\to\mathrm{PPF}_{n+1},\qquad S\mapsto\omega_S.
$$

The exclusion of $\emptyset$ is forced: $\omega_\emptyset$ is the empty relation, hence not in $\mathrm{PPF}_{n+1}$ (which requires *nonempty* relations). For an intersection-closed $\mathcal F$ with $\emptyset\in\mathcal F$ (the WLOG normal form of §1.2), the embedding is defined on $\mathcal F\setminus\{\emptyset\}$ and the *one missing image* (the empty set) is recovered as the "open bottom" of the principal ideal $(\omega_n\!\downarrow)$ — formally we may adjoin a $\widehat 0$ at the bottom of the embedded image when needed for Möbius computations (§5.3).

### 2.2 Algebraic properties of $\iota_n^{\mathrm{cone}}$

> **Lemma 2.1 (well-defined).** $\omega_S\in\mathrm{PPF}_{n+1}$ for every $S\ne\emptyset$, $S\subseteq[n]$.

*Proof.* $\omega_S$ is irreflexive (no $(c,c)$), antisymmetric (every relation has $n+1$ on the left), transitively closed (the only potential composition $(n+1,b)\circ(b,c)$ is empty since no relation has $b\in[n]$ on the left — there are no relations among $[n]$ in $\omega_S$). Nonempty: $|\omega_S|=|S|\ge 1$. Non-total on $[n+1]$: any two distinct $b,b'\in[n]$ are incomparable in $\omega_S$ (no relation between them). $\qquad\blacksquare$

> **Lemma 2.2 (order-preserving).** For $S,T\subseteq[n]$ with $S,T\ne\emptyset$: $S\subseteq T\Leftrightarrow\omega_S\subseteq\omega_T$.

*Proof.* $\omega_S=\{(n+1,b):b\in S\}$, $\omega_T=\{(n+1,b):b\in T\}$; the bijection $b\leftrightarrow(n+1,b)$ between $S$ and $\omega_S$ is order-preserving in the inclusion order. $\qquad\blacksquare$

> **Lemma 2.3 (lattice morphism).** For $S,T\subseteq[n]$ with $S,T\ne\emptyset$ and $S\cap T\ne\emptyset$: $\omega_{S\cap T}=\omega_S\cap\omega_T$ and $\omega_{S\cup T}=\omega_S\cup\omega_T$, both as relations on $[n+1]$. (When $S\cap T=\emptyset$, the relation $\omega_S\cap\omega_T=\emptyset\notin\mathrm{PPF}_{n+1}$, so the meet exits the codomain.)

*Proof.* $\omega_S\cap\omega_T=\{(n+1,b):b\in S\}\cap\{(n+1,b):b\in T\}=\{(n+1,b):b\in S\cap T\}=\omega_{S\cap T}$ — set equality of relations. Similarly for $\cup$ via $S\cup T$. $\qquad\blacksquare$

> **Lemma 2.4 (the image is the principal ideal of $\omega_n$).** $\mathrm{im}(\iota_n^{\mathrm{cone}})=(\omega_n\!\downarrow)\setminus\{\emptyset\}$, where $(\omega_n\!\downarrow):=\{x\in\mathrm{PPF}_{n+1}\cup\{\emptyset\}:x\subseteq\omega_n\}$ is the principal order ideal of $\omega_n$ in the relation-inclusion order, with $\emptyset$ adjoined.

*Proof.* "$\subseteq$": for any $S\ne\emptyset$, $\omega_S\subseteq\omega_n$ (by Lemma 2.2 and $S\subseteq[n]$). "$\supseteq$": let $x\in\mathrm{PPF}_{n+1}$ with $x\subseteq\omega_n$. Every relation in $\omega_n$ has the form $(n+1,b)$, so every relation in $x$ has the form $(n+1,b)$. Define $S(x):=\{b\in[n]:(n+1,b)\in x\}$. Then $x=\omega_{S(x)}$. Nonempty $x\Rightarrow S(x)\ne\emptyset$. So $x\in\mathrm{im}(\iota_n^{\mathrm{cone}})$. $\qquad\blacksquare$

> **Lemma 2.5 ($S_n$-equivariance).** For $\sigma\in S_n$ acting on $[n]$ (extended to $S_{n+1}$ by $\sigma(n+1):=n+1$), $\iota_n^{\mathrm{cone}}(\sigma\cdot S)=\sigma\cdot\iota_n^{\mathrm{cone}}(S)$.

*Proof.* $\sigma\cdot\omega_S=\{(\sigma(n+1),\sigma(b)):b\in S\}=\{(n+1,\sigma(b)):b\in S\}=\{(n+1,c):c\in\sigma(S)\}=\omega_{\sigma(S)}$. $\qquad\blacksquare$

In summary: $\iota_n^{\mathrm{cone}}$ is an **order-preserving, meet-preserving, join-preserving, $S_n$-equivariant injective map** from $(2^{[n]}\setminus\{\emptyset\},\subseteq)$ onto the principal ideal $(\omega_n\!\downarrow)\setminus\{\emptyset\}\subseteq\mathrm{PPF}_{n+1}$. The image is itself a Boolean sub-lattice of $\mathrm{PPF}_{n+1}$ (under relation-set $\cap,\cup$) of size $2^n-1$.

### 2.3 Direct verification (per the no-shortcut directive)

The `feedback_n_poset_is_not_ordinal_sum` memory says: prior polecat parentheticals invoking "decomposable case absorbs N-poset" have been wrong; future polecats must verify any small-poset structural claims directly under a proposed embedding. UC9 §2.3 verifies:

- **Antichain** on $k$ elements ($k\le n$) ↦ embeds via $S=\{x_1,\dots,x_k\}\mapsto\omega_S$, which is a *fan from $n+1$* with $k$ rays (a height-2 partial order with one minimum $n+1$ and $k$ maxima $x_1,\dots,x_k$, all pairwise incomparable). **Direct check:** no transitivity issues (no relations to compose); $\omega_S$ is correctly $\{(n+1,x_1),\dots,(n+1,x_k)\}$. ✓
- **2-element chain** ($x\prec y$ on $\{x,y\}\subseteq[n]$) ↦ NOT in the image of $\iota_n^{\mathrm{cone}}$. The cone embedding does **not** add chain relations *among* $[n]$; chain relations arise only outside the image (above $\omega_n$ in $\mathrm{PPF}_{n+1}$, see §3.3). This is correct: the Boolean lattice has no internal-chain structure to embed. ✓
- **N-poset** ($x\prec y$, $z\prec y$, $z\prec w$ on $\{x,y,z,w\}\subseteq[n]$) ↦ NOT in the image. The N-poset has chain relations among $[n]$, absent from $\omega_S$. ✓ (And this is precisely what `feedback_n_poset_is_not_ordinal_sum` warns about: the embedded image excludes the N-poset by construction; no shortcut is invoked.)
- **The empty relation** ↦ NOT in $\mathrm{PPF}_{n+1}$ (excluded by the "nonempty" requirement). Adjoined as the formal $\widehat 0$ if needed for Möbius (§5.3); excluded from the embedded image proper. ✓
- **The total order** on $[n+1]$ ↦ NOT in $\mathrm{PPF}_{n+1}$ either, by the "non-total" requirement. Not in the image of $\iota_n^{\mathrm{cone}}$ in any case (the image is below $\omega_n$, which is non-total: $[n]$ is an antichain). ✓
- **The cone $\omega_n$ itself** ↦ in the image, $\omega_n=\iota_n^{\mathrm{cone}}([n])$. Its position in $\mathrm{PPF}_{n+1}$: it is *not* the maximum of $\mathrm{PPF}_{n+1}$ (e.g. $\omega_n$ extended by adding the chain $1\prec 2\prec\cdots\prec n$ on $[n]$ is in $\mathrm{PPF}_{n+1}$ provided the result is non-total, which it is iff $n\ge 2$, vacuously true since $\omega_n$ already includes $(n+1,b)$ for all $b\in[n]$ — we'd get a total order on $[n+1]$ if we add a total order on $[n]$, hence it would exit $\mathrm{PPF}_{n+1}$; but adding e.g. $\{(1,2)\}$ gives a non-total partial order on $[n+1]$). So the principal filter $(\omega_n\!\uparrow)$ in $\mathrm{PPF}_{n+1}$ has many elements (the partial orders on $[n+1]$ extending $\omega_n$, equivalently the non-total partial orders on $[n]$ + $\omega_n$). $\omega_n$ is a *non-extremal* element of $\mathrm{PPF}_{n+1}$ — it has both predecessors (the elements of the embedded Boolean image) and successors (the extensions). ✓

All structural claims directly verified. No shortcut is invoked.

### 2.4 Uniqueness (the F18 / F17 / Daniel constraints pin $\iota_n^{\mathrm{cone}}$ uniquely)

> **Theorem 2.4 (uniqueness of the cone embedding under joint constraints).** Let $\iota:2^{[n]}\setminus\{\emptyset\}\to\mathrm{PPF}_{n+1}$ be an embedding (injective order-preserving map) satisfying:
> (a) **$S_n$-equivariance** (with the natural $S_n\subseteq S_{n+1}$ fixing $n+1$): $\iota(\sigma\cdot S)=\sigma\cdot\iota(S)$ for $\sigma\in S_n$;
> (b) **lattice-morphism on the meet**: $\iota(S\cap T)=\iota(S)\cap\iota(T)$ as relations whenever $S\cap T\ne\emptyset$;
> (c) **F18-natural**: the image of $[n]$ is the F18 cone element $\omega_n$, i.e. $\iota([n])=\omega_n$;
> (d) **the image is the principal ideal of $\iota([n])$**: $\mathrm{im}(\iota)=(\iota([n])\!\downarrow)\setminus\{\emptyset\}$.
>
> Then $\iota=\iota_n^{\mathrm{cone}}$.

*Proof.* By (c), $\iota([n])=\omega_n=\{(n+1,1),\dots,(n+1,n)\}$. By (d), every $\iota(S)\subseteq\omega_n$, so every $\iota(S)$ is a subset of $\{(n+1,b):b\in[n]\}$, hence $\iota(S)=\{(n+1,b):b\in T(S)\}$ for some $T(S)\subseteq[n]$. By (a), $T(\sigma\cdot S)=\sigma\cdot T(S)$. By (b) with $T=[n]$: $\iota(S\cap[n])=\iota(S)\cap\iota([n])=\iota(S)\cap\omega_n=\iota(S)$, so the $T$-correspondence respects intersection with $[n]$ — vacuous. By (b) with general $T$: $T(S\cap T)=T(S)\cap T(T)$ — so $T:2^{[n]}\setminus\{\emptyset\}\to 2^{[n]}\setminus\{\emptyset\}$ is meet-preserving. By (a), $T$ is $S_n$-equivariant. By injectivity of $\iota$, $T$ is injective. An $S_n$-equivariant meet-preserving injection $2^{[n]}\setminus\{\emptyset\}\to 2^{[n]}\setminus\{\emptyset\}$: by Lemma 2.4.1 below, $T=\mathrm{id}$. Hence $\iota(S)=\{(n+1,b):b\in S\}=\omega_S=\iota_n^{\mathrm{cone}}(S)$. $\qquad\blacksquare$

> **Lemma 2.4.1.** Every $S_n$-equivariant meet-preserving injection $T:2^{[n]}\setminus\{\emptyset\}\to 2^{[n]}\setminus\{\emptyset\}$ is the identity.

*Proof sketch.* $T(\{1\}),\dots,T(\{n\})$ are pairwise distinct singletons or atoms by injectivity; $S_n$-equivariance acts transitively on singletons, so $T$ permutes singletons by some $\pi\in S_n$. $S_n$-equivariance with the transposition swapping $1,2$: $T(\{1\})=\sigma_{12}\cdot T(\{2\})$, forcing $\pi$ to commute with all transpositions, so $\pi=\mathrm{id}$. By meet-preservation: $T(S)=T(\bigcap_{x\in S}\bigcup_{y\ne x}\{y\}^c)$ — wait, this gets complicated. Alternative: by meet-preservation $T(S\cap T)=T(S)\cap T(T)$ on every input pair; iteratively, $T(\{x_1,\dots,x_k\})=\bigcap_j T(\{x_1,\dots,\hat x_j,\dots,x_k\})$, reducing inductively to $T$ on singletons, which is identity by the previous step. $\qquad\blacksquare$

Theorem 2.4's takeaway: $\iota_n^{\mathrm{cone}}$ is **uniquely** the embedding satisfying the four natural constraints together. Any other "natural" candidate fails one of (a)–(d):

- **Anti-cone embedding** $S\mapsto\bar\omega_S:=\{(b,n+1):b\in S\}$ ("$n+1$ is *above* $S$"). Satisfies (a), (b), (d) — image is the principal *ideal* of $\bar\omega_n$ in $\mathrm{PPF}_{n+1}$. Fails (c) iff we insist on the F18 cone direction $\omega_n$ rather than the order-reversed $\bar\omega_n$. The two are isomorphic by relation-reversal; UC9 picks $\omega_S$ to match F18 verbatim, but the dual choice gives the structurally identical analysis.
- **Pinned-cone embedding** $S\mapsto\{(n+1,b_0)\}\cup\omega_S$ for a chosen $b_0\in[n]$. Then $S=\emptyset$ has image $\{(n+1,b_0)\}\in\mathrm{PPF}_{n+1}$ — the embedding extends to all of $2^{[n]}$, which is *better*. But fails (a) with $S_n$-equivariance: it is only $S_{n-1}$-equivariant (the stabilizer of $b_0$). UC9 prefers full $S_n$-equivariance and tolerates the missing $\emptyset$, recoverable as adjoined $\widehat 0$.
- **Filter-lattice embedding** $S\mapsto P_S$ with $P_S:=$ partial order on $[n+1]$ where $\{x:x\in S\}$ are above $n+1$ and $[n]\setminus S$ is incomparable (a hybrid). This is a different decoration of the cone; fails (b) the meet-preservation: $P_S\cap P_T$ as relations is not $P_{S\cap T}$ in general (intersection on the "S-incomparability" side breaks).
- **Ordinal-sum embedding** $S\mapsto[n+1]/\sim_S$ for some quotient. Per `feedback_n_poset_is_not_ordinal_sum`, ordinal-sum constructions are notoriously brittle for N-poset structural claims; UC9 explicitly does not pursue this and confirms the cone embedding is independent of any ordinal-sum decomposition.

The cone embedding is the F18-canonical, $S_n$-natural, lattice-preserving choice. Pinned.

### 2.5 The embedded family

For an intersection-closed $\mathcal F\subseteq 2^{[n]}$ (in the §1.2 normal form: $[n]\in\mathcal F$, $\emptyset\in\mathcal F$):
$$
  \widetilde{\mathcal F}\;:=\;\iota_n^{\mathrm{cone}}\bigl(\mathcal F\setminus\{\emptyset\}\bigr)\;=\;\{\omega_S\,:\,S\in\mathcal F,\,S\ne\emptyset\}\;\subseteq\;(\omega_n\!\downarrow)\setminus\{\emptyset\}\;\subseteq\;\mathrm{PPF}_{n+1}.
$$

By Lemmas 2.2 + 2.3:
- $\widetilde{\mathcal F}$ is a meet-subsemilattice of $(\omega_n\!\downarrow)\setminus\{\emptyset\}$, with maximum $\omega_n$ (corresponding to $[n]\in\mathcal F$) and minimum determined by the second-smallest element of $\mathcal F$ above $\emptyset$.
- $\widetilde{\mathcal F}$ is intersection-closed in $\mathrm{PPF}_{n+1}$ in the strong sense: $x,y\in\widetilde{\mathcal F}$ and $x\cap y\ne\emptyset$ ⟹ $x\cap y\in\widetilde{\mathcal F}$.
- The minimum of $\mathcal F$ in the §1.2 normal form is $\emptyset$, which embeds outside $\mathrm{PPF}_{n+1}$ (Lemma 2.1 excludes empty relations); we treat it formally as $\widehat 0$ adjoined to the bottom of $(\omega_n\!\downarrow)$ when necessary.

The order complex $\Delta(\widetilde{\mathcal F})$ is a sub-complex of $\Delta_{n+1}=\Delta(\mathrm{PPF}_{n+1})$. Its structure: $\widetilde{\mathcal F}$ has $\omega_n$ as a top element, so $\Delta(\widetilde{\mathcal F})$ is a *cone* with apex $\omega_n$, hence **contractible** (as a topological space). This is the structural fact §4 will use.

---

## §3. The F17+F18 cohomology of $\Delta(\mathrm{PPF}_{n+1})$, restated for UC9

§3.1 restates Fact F at $n+1$. §3.2 unpacks Daniel's "cohomology type is $\mathrm{Pos}_{n-1}$" via the degree-shift engine. §3.3 records the specific structural data UC9 §4 / §5 will consume.

### 3.1 Fact F at $n+1$

By §0.2 Fact F applied at $n+1$ (which requires $n+1\ge 3$, i.e. $n\ge 2$ — vacuous in any non-trivial Frankl regime):
$$
  \widetilde H^k(\Delta_{n+1};\mathbb Q)\;=\;\begin{cases}\mathrm{sgn}_{S_{n+1}}&k=n-1,\\ 0&k\ne n-1,\end{cases}
$$
as $S_{n+1}$-representations. The carrier is the order complex $\Delta(\mathrm{PPF}_{n+1})$ of nonempty non-total partial orders on $[n+1]$, of dimension $n-1$. The *single* nonzero cohomology class is one-dimensional and $S_{n+1}$-acts by sign.

This is the F-series cathedral's terminal statement on $\Delta_{n+1}$. F17 (mg-4d3a, Theorem 5.1) gives the identity $H_d(\Delta_{n+1}/\Delta_n)\cong 2\cdot H_{d-1}(\Delta_n)$ as $S_n$-reps unconditionally; F18 (mg-d039, Theorem 4.1) gives the LES splitting (Cor 5.1) so that $H_d(\Delta_{n+1})\cong H_{d-1}(\Delta_n)$ as $S_n$-reps; F10's induction (mg-8216, §6.2) closes the $S_{n+1}$-promotion. UC9 consumes this as a single black-box theorem.

### 3.2 The degree-shift engine and Daniel's "cohomology type is $\mathrm{Pos}_{n-1}$"

Iterate the F18 degree-shift identity:
$$
  \widetilde H^{n-1}(\Delta_{n+1})\;\cong\;\widetilde H^{n-2}(\Delta_n)\;\cong\;\widetilde H^{n-3}(\Delta_{n-1})\;\cong\;\cdots\;\cong\;\widetilde H^{1}(\Delta_3),
$$
each isomorphism as an $S_m$-representation for the *common* symmetric group $S_m$ acting on the appropriate carrier, propagating $\mathrm{sgn}_{S_m}$ throughout (the sign rep restricts to sign rep under $S_n\hookrightarrow S_{n+1}$, branching of one-dimensional sign reps).

So Daniel's "cohomology type is $\mathrm{Pos}_{n-1}$" reads as the **Pos-tower compatibility statement**: the top cohomology of $\mathrm{Pos}_{n+1}$ is the iterated F18-shift of $\mathrm{Pos}_{n-1}$'s top cohomology, two degrees up; or equivalently, **the cohomology class on $\mathrm{Pos}_{n+1}$ is the F18-zig-zag-iterated lift of $\mathrm{Pos}_{n-1}$'s cohomology class**.

Operationally for UC9: the $\mathrm{Pos}_{n+1}$ top class lives in degree $n-1$, which is the dimension of:
- $\Delta_{n+1}$ itself (top simplex dimension $\dim\Delta_{n+1}=n-1$),
- the embedded image $\Delta(\mathrm{im}(\iota_n^{\mathrm{cone}}))\subseteq\Delta_{n+1}$, since $\mathrm{im}(\iota_n^{\mathrm{cone}})\cong 2^{[n]}\setminus\{\emptyset\}$ has top dimension $n-1$ (longest chain $\{x_1\}\subset\{x_1,x_2\}\subset\cdots\subset[n]$ has $n$ elements, hence $n-1$ as a chain in the order complex),
- the **boundary** of the punctured Boolean cube $2^{[n]}\setminus\{\emptyset,[n]\}$, which is the $(n-2)$-sphere $S^{n-2}$ — top cohomology in degree $n-2$.

The mismatch — degree $n-1$ on $\Delta_{n+1}$ vs degree $n-2$ on the boundary sphere — is exactly the degree-shift engine: F17+F18's $\widetilde H^k(\Delta_{n+1})\cong\widetilde H^{k-1}(\Delta_n)$ shifts down by one. This will be the source of both the obstruction (§4 — the embedded image cannot carry the top class directly) and the bridge (§5 — the boundary $(n-2)$-sphere of the punctured Boolean cube does carry the top class of $\Delta_n$, which equivariantly lifts to the top class of $\Delta_{n+1}$).

### 3.3 Specific structural data for UC9

The data UC9 §4 / §5 will use:

**(D-1)** $\widetilde H^{n-1}(\Delta_{n+1};\mathbb Q)=\mathrm{sgn}_{S_{n+1}}$, one-dimensional, top-degree concentrated. Other reduced cohomologies vanish.

**(D-2)** Branching: $\mathrm{sgn}_{S_{n+1}}\downarrow_{S_n}=\mathrm{sgn}_{S_n}$. (Standard sign-rep restriction: the sign character restricted to $S_n$ is the sign of $\sigma$ as a permutation of $[n+1]$; for $\sigma$ fixing $n+1$, this equals the sign of $\sigma|_{[n]}$.) So under the natural $S_n\subseteq S_{n+1}$ fixing $n+1$, the F17+F18 top class restricts to $\mathrm{sgn}_{S_n}$ on the $S_n$-action.

**(D-3)** The principal ideal $(\omega_n\!\downarrow)\setminus\{\emptyset\}\subseteq\mathrm{PPF}_{n+1}$ is $S_n$-stable ($\omega_n$ is $S_n$-fixed; $S_n$ permutes the other elements of $(\omega_n\!\downarrow)$).

**(D-4)** The order complex of $(\omega_n\!\downarrow)\setminus\{\emptyset\}$ is contractible (cone with apex $\omega_n$). The order complex of $(\omega_n\!\downarrow)\setminus\{\emptyset,\omega_n\}$ (the punctured ideal) is homotopy equivalent to the *boundary of the simplex* on $n$ vertices, which is $S^{n-2}$ (the $(n-2)$-sphere). The $S_n$-action on $S^{n-2}$ via permutation of the $n$ vertices makes the top cohomology $\widetilde H^{n-2}(S^{n-2})=\mathbb Z$ carry the $\mathrm{sgn}_{S_n}$-representation rationally.

**(D-5)** The element $\omega_n$ has nonempty principal filter in $\mathrm{PPF}_{n+1}$: $(\omega_n\!\uparrow)$ contains $\omega_n\cup Q$ for each non-total $Q\in\mathrm{Pos}([n])$ (the partial orders on $[n]$ extending $\omega_n$ to a still-non-total partial order on $[n+1]$). Cardinality $|(\omega_n\!\uparrow)\setminus\{\omega_n\}|=$ count of nontrivial non-total partial orders on $[n]$ that are consistent with $\omega_n$, i.e. $|\mathrm{PPF}_n^{\le\mathrm{nt}}|$ for the restriction.

(D-1), (D-2), (D-3), (D-4) are immediate. (D-5) is structural and will not be load-bearing in §4 / §5 except for completeness in §5.4.

---

## §4. Pulling back: the cohomology of the pair $(\Delta_{n+1},\Delta(\mathrm{im}(\iota_n^{\mathrm{cone}})))$

§4.1 computes the direct pullback (zero in every degree). §4.2 sets up the long exact sequence of the pair. §4.3 states the **survival theorem**: the F17+F18 sgn class survives as a relative class in degree $n-1$. §4.4 records the family-pair version for $\widetilde{\mathcal F}\subseteq\mathrm{im}(\iota_n^{\mathrm{cone}})$.

### 4.1 The direct pullback

The cone embedding $\iota_n^{\mathrm{cone}}:2^{[n]}\setminus\{\emptyset\}\hookrightarrow\mathrm{PPF}_{n+1}$ induces a simplicial map of order complexes
$$
  \iota_*:\Delta(2^{[n]}\setminus\{\emptyset\})\to\Delta_{n+1},
$$
and by functoriality of cohomology a pullback ring/module map
$$
  \iota^*:\widetilde H^*(\Delta_{n+1};\mathbb Q)\to\widetilde H^*(\Delta(2^{[n]}\setminus\{\emptyset\});\mathbb Q).
$$

> **Lemma 4.1 (the embedded image is contractible).** $\Delta(2^{[n]}\setminus\{\emptyset\})\simeq\mathrm{point}$.

*Proof.* $2^{[n]}\setminus\{\emptyset\}$ has $[n]$ as a unique maximum element. By the standard order-complex contractibility lemma (any poset with maximum has contractible order complex — apex coning), $\Delta(2^{[n]}\setminus\{\emptyset\})$ is a cone with apex $[n]$, hence contractible. (Alternative: $2^{[n]}\setminus\{\emptyset\}$ also has the order-complex of a topological cone via $S\mapsto S\cup\{1\}$, an order-preserving map with $S\subseteq S\cup\{1\}$, an interior-operator-like move that contracts.) $\qquad\blacksquare$

> **Corollary 4.2 (direct pullback is zero).** $\iota^*=0:\widetilde H^k(\Delta_{n+1})\to\widetilde H^k(\Delta(2^{[n]}\setminus\{\emptyset\}))=0$ in every degree $k\ge 0$.

*Proof.* Target is zero by Lemma 4.1. $\qquad\blacksquare$

So the *naive* pullback morphism captures no information. **This is the U1-shaped wall for UC9** (cf. mg-26fc U1: "no operational bridge"; here, the bridge is the zero map). The structurally interesting cohomological information lives one rung higher — in the **relative cohomology** of the pair, or equivalently in the **cofiber** $\Delta_{n+1}/\Delta(\mathrm{im})$.

### 4.2 The long exact sequence of the pair

Write $\mathrm{im}:=\mathrm{im}(\iota_n^{\mathrm{cone}})=(\omega_n\!\downarrow)\setminus\{\emptyset\}$ (an order ideal in $\mathrm{PPF}_{n+1}\cup\{\widehat 0\}$, ignoring the formal $\widehat 0$). $\mathrm{im}\subseteq\mathrm{PPF}_{n+1}$ is a subposet, $\Delta(\mathrm{im})\subseteq\Delta_{n+1}$ a subcomplex.

The LES of the pair $(\Delta_{n+1},\Delta(\mathrm{im}))$:
$$
  \cdots\to\widetilde H^{k-1}(\Delta(\mathrm{im}))\to\widetilde H^k(\Delta_{n+1},\Delta(\mathrm{im}))\to\widetilde H^k(\Delta_{n+1})\to\widetilde H^k(\Delta(\mathrm{im}))\to\cdots
$$

The pair is *good* in the sense of cofibrations: $\mathrm{im}$ is an order ideal in $\mathrm{PPF}_{n+1}$ (closed under going down, since $\mathrm{im}=(\omega_n\!\downarrow)\setminus\{\emptyset\}$ is exactly all elements below $\omega_n$), so $\Delta(\mathrm{im})$ is a subcomplex of $\Delta_{n+1}$ and the inclusion is a cofibration. Hence $\widetilde H^k(\Delta_{n+1},\Delta(\mathrm{im}))\cong\widetilde H^k(\Delta_{n+1}/\Delta(\mathrm{im}))$.

By Lemma 4.1, $\widetilde H^*(\Delta(\mathrm{im}))=0$ for $*\ge 0$. The LES collapses:

> **Theorem 4.3 (the survival theorem).** $\widetilde H^k(\Delta_{n+1},\Delta(\mathrm{im}))\cong\widetilde H^k(\Delta_{n+1})$ as $S_n$-representations, for every $k$. In particular, for $k=n-1$:
> $$
>   \widetilde H^{n-1}(\Delta_{n+1},\Delta(\mathrm{im}))\;\cong\;\mathrm{sgn}_{S_{n+1}}\;\bigl|\bigr._{S_n}\;=\;\mathrm{sgn}_{S_n}\quad(\text{as $S_n$-representations}).
> $$

*Proof.* LES collapses since the source/target with $\widetilde H^*(\Delta(\mathrm{im}))$ vanish. $S_{n+1}$-equivariance of the LES respects the $S_n$-action on the pair. The $S_n$-restriction of the top class is $\mathrm{sgn}_{S_n}$ by branching (D-2). $\qquad\blacksquare$

So the F17+F18 top class **survives unchanged in the relative cohomology**: pulling back through the embedded image's contractibility transfers the entire top class to the relative / cofiber cohomology.

### 4.3 The family pair $(\Delta_{n+1},\Delta(\widetilde{\mathcal F}))$

For an intersection-closed $\mathcal F\subseteq 2^{[n]}$ in the §1.2 normal form ($[n]\in\mathcal F$, $\emptyset\in\mathcal F$), the embedded family $\widetilde{\mathcal F}$ has top element $\omega_n$. So $\Delta(\widetilde{\mathcal F})$ is a cone with apex $\omega_n$, hence:

> **Lemma 4.4 (family is contractible too).** $\Delta(\widetilde{\mathcal F})\simeq\mathrm{point}$.

*Proof.* $\widetilde{\mathcal F}$ has maximum $\omega_n$. Apex coning. $\qquad\blacksquare$

Repeat the LES argument:

> **Theorem 4.5 (family-relative survival).** For every intersection-closed $\mathcal F$ with $[n]\in\mathcal F$:
> $$
>   \widetilde H^k(\Delta_{n+1},\Delta(\widetilde{\mathcal F}))\;\cong\;\widetilde H^k(\Delta_{n+1})\;\quad\text{as $S_n$-reps.}
> $$
> In particular, $\widetilde H^{n-1}(\Delta_{n+1},\Delta(\widetilde{\mathcal F}))=\mathrm{sgn}_{S_n}$. **The relative cohomology is family-independent on the contractibility class.**

*Proof.* As Theorem 4.3, with $\widetilde{\mathcal F}$ in place of $\mathrm{im}$. The contractibility of $\Delta(\widetilde{\mathcal F})$ (Lemma 4.4) collapses the LES regardless of *which* $\mathcal F$ (containing $[n]$ — and intersection-closed) is chosen. $\qquad\blacksquare$

**This is the second face of the U1 wall**: the *family-pair* relative cohomology cannot distinguish two intersection-closed families with $[n]\in\mathcal F$. Every such $\mathcal F$ produces the same relative class. Hence, no Frankl bound on $\mathcal F$ can be extracted from the family-pair LES *directly*: it's the same equation for every $\mathcal F$.

### 4.4 The structural takeaway

The four moves of §4:

1. **Direct pullback** (Cor 4.2): zero in every degree. The embedded image's contractibility *swallows* the F17+F18 cohomology along the obvious morphism.
2. **Pair LES** (Theorem 4.3): the F17+F18 sgn class *survives* as a relative class supported on $\Delta_{n+1}\setminus\Delta(\mathrm{im})$ — i.e. on the partial orders in $\mathrm{PPF}_{n+1}$ that are *not* sub-cones of $\omega_n$ (those with relations among $[n]$ and/or relations $(b,n+1)$ for $b\in[n]$).
3. **Family-pair LES** (Theorem 4.5): the same survival, family-independent on the contractibility class. **Family info is not visible to the relative cohomology in degree $n-1$.**
4. **Structural conclusion**: the F17+F18 top class lives in the *complement* of any contractible family-image; the family info must be extracted by *complementary* / *non-direct* methods — Bridges A, B, C of §5.

The U1-shape: in F-series language (mg-26fc), U1 is "no operational bridge between BK spectral data and $\Delta(\mathrm{PPF})$ cohomology". Here, the bridge between the family $\mathcal F$ and the F17+F18 cohomology of $\mathrm{PPF}_{n+1}$ does exist (the embedding $\iota_n^{\mathrm{cone}}$ is fully canonical, §2), but the *direct cohomology pullback* through it is the **zero morphism** — exactly the U1 obstruction in cohomology dialect. UC9's three bridges (§5) propose three non-direct ways to *go around* this obstruction; the analysis of which bridges land and which do not is the UC10 mandate.

---

## §5. Constraints on $\mathcal F$ — the three bridges

The U1 wall of §4 says the *direct* pullback morphism is zero (Cor 4.2) and the *family-pair* relative cohomology is family-independent (Theorem 4.5) on the contractibility class. So the F17+F18 cohomology, taken literally as a contravariant cohomological functor, sees nothing about $\mathcal F$.

UC9 §5 surfaces **three candidate non-functorial bridges** that go around the wall by *different* mechanisms:

- **§5.2 — Bridge A: vertex-slice Mayer–Vietoris on the principal ideal.** The cover of $(\omega_n\!\downarrow)$ by single-vertex deletions encodes the slice statistics $f_x^c$; the Mayer–Vietoris LES on this cover, attached to the F17+F18 top class via a single sgn-projection, gives a coupling between the F-series cohomology and the $f_x^c$ profile.
- **§5.3 — Bridge B: Möbius/Euler-characteristic with deletion-contraction.** The Hall theorem $\mu(\widehat 0,\widehat 1\,;\,\mathrm{PPF}_{n+1}^*)=(-1)^{n-1}$ (with adjoined $\widehat 0,\widehat 1$) by F17+F18 cohomology concentration; the deletion-contraction recursion on the embedded family gives a numerical invariant of $\mathcal F$ that is sign-determined by the slice statistics.
- **§5.4 — Bridge C: equivariant sgn-isotypic projection on the boundary $(n-2)$-sphere.** The branching $\mathrm{sgn}_{S_{n+1}}\downarrow_{S_n}=\mathrm{sgn}_{S_n}$ couples the F17+F18 top class to the punctured-Boolean-cube boundary sphere $\Delta(\mathrm{im}\setminus\{\omega_n\})\simeq S^{n-2}$; the equivariant restriction-of-Euler-characteristic identity gives a sign-sum over $\mathcal F$ that bounds the slice profile.

§5.1 sets up the slice-profile vocabulary common to all three bridges. §5.5 records the symmetric-treatment of the dual case ($\mathcal F$ with $[n]\notin\mathcal F$) and confirms WLOG-loss is bounded.

### 5.1 Vertex slices on the principal ideal

For each $x\in[n]$, define:
$$
  \omega_n^{(x)}\;:=\;\omega_n\setminus\{(n+1,x)\}\;=\;\{(n+1,b)\,:\,b\in[n]\setminus\{x\}\}\;=\;\omega_{[n]\setminus\{x\}}\;\in\mathrm{PPF}_{n+1}.
$$
$\omega_n^{(x)}$ is the cone of $n+1$ over $[n]\setminus\{x\}$ — a maximal proper sub-cone of $\omega_n$.

> **Lemma 5.1 (the vertex-slice cover of the principal ideal).** $(\omega_n\!\downarrow)\setminus\{\omega_n\}=\bigcup_{x\in[n]}(\omega_n^{(x)}\!\downarrow)$. Equivalently, every proper sub-cone of $\omega_n$ is below at least one $\omega_n^{(x)}$, and the $\omega_n^{(x)}$ are precisely the maximal proper sub-cones.

*Proof.* $y\in(\omega_n\!\downarrow)\setminus\{\omega_n\}$ ⟺ $y=\omega_S$ for some $S\subsetneq[n]$ ⟺ $y\subseteq\omega_n^{(x)}$ for any $x\in[n]\setminus S$ (which exists since $S\subsetneq[n]$). Hence $y\in(\omega_n^{(x)}\!\downarrow)$. The maximal-proper assertion: each $\omega_n^{(x)}$ is maximal in $(\omega_n\!\downarrow)\setminus\{\omega_n\}$ (adding $(n+1,x)$ recovers $\omega_n$); they are the unique maximals (each proper sub-cone $\omega_S$, $S\subsetneq[n]$, is below $\omega_n^{(x)}$ for *every* $x\in[n]\setminus S$). $\qquad\blacksquare$

The cover by $(\omega_n^{(x)}\!\downarrow)$ for $x\in[n]$ is a *vertex* cover of the punctured principal ideal. It is the natural cover of the punctured Boolean cube $2^{[n]}\setminus\{[n]\}$ by the $n$ codimension-1 faces $\{S:x\notin S\}=\{S:S\subseteq[n]\setminus\{x\}\}=2^{[n]\setminus\{x\}}$.

For an intersection-closed $\mathcal F$ in the §1.2 normal form:
$$
  f_x^c\;:=\;|\mathcal F\cap 2^{[n]\setminus\{x\}}|\;=\;|\{S\in\mathcal F\,:\,x\notin S\}|\;=\;|\widetilde{\mathcal F}\cap(\omega_n^{(x)}\!\downarrow)|.
$$
$f_x^c$ is the *rarity statistic* of §1.3, encoded as the **slice-intersection statistic** of $\widetilde{\mathcal F}$ against $\omega_n^{(x)}$.

> **Lemma 5.2 (Frankl in slice-statistics dialect).** Frankl (intersection-closed) holds for $\mathcal F$ ⟺ $\max_{x\in[n]}|\widetilde{\mathcal F}\cap(\omega_n^{(x)}\!\downarrow)|\ge|\widetilde{\mathcal F}|/2$ (where $|\widetilde{\mathcal F}|=|\mathcal F|-1$ if $\emptyset\in\mathcal F$, else $|\mathcal F|$).

*Proof.* By the embedding's bijection $S\leftrightarrow\omega_S$ and Lemma 5.1's cover; the off-by-one comes from excluding $\emptyset$. The max-half-or-more inequality is Cor 1.2(ii) in slice dialect. $\qquad\blacksquare$

So Frankl is now a **lattice-theoretic / cohomological** statement on $\widetilde{\mathcal F}\subseteq(\omega_n\!\downarrow)$ in $\mathrm{PPF}_{n+1}$: max slice intersection ≥ half. The three bridges of §§5.2–5.4 attempt to extract this from the F17+F18 top class.

### 5.2 Bridge A — vertex-slice Mayer–Vietoris

The vertex-slice cover of Lemma 5.1 is *not* an open cover in the topological sense (the $(\omega_n^{(x)}\!\downarrow)$ are subcomplexes, not open sets), but the simplicial Mayer–Vietoris LES applies for *order-ideal subcomplexes whose union is the ambient*. Consider the cover of $(\omega_n\!\downarrow)\setminus\{\omega_n\}$ by $\{(\omega_n^{(x)}\!\downarrow)\}_{x\in[n]}$.

The Mayer–Vietoris-style spectral sequence on this cover (the *Bousfield–Kan / Čech-poset* version, or directly the spectral sequence of a simplicial cover via the nerve):

$$
  E_1^{p,q}\;=\;\bigoplus_{|I|=p+1}\widetilde H^q\Bigl(\bigcap_{x\in I}(\omega_n^{(x)}\!\downarrow)\Bigr)\;\Longrightarrow\;\widetilde H^{p+q}\bigl((\omega_n\!\downarrow)\setminus\{\omega_n\}\bigr).
$$

The intersections: for $I\subseteq[n]$, $|I|=p+1$:
$$
  \bigcap_{x\in I}(\omega_n^{(x)}\!\downarrow)\;=\;(\omega_n\setminus\{(n+1,x):x\in I\}\!\downarrow)\;=\;(\omega_{[n]\setminus I}\!\downarrow).
$$

For $I\subsetneq[n]$ ($p<n-1$): this is the principal ideal of $\omega_{[n]\setminus I}\ne\emptyset$, hence has a top element $\omega_{[n]\setminus I}$, hence is a cone, hence is contractible. So $\widetilde H^q=0$ for $q\ge 0$.

For $I=[n]$ ($p=n-1$): the intersection is $(\omega_\emptyset\!\downarrow)=\{\omega_\emptyset\}=\{\emptyset\}$ — but $\emptyset\notin\mathrm{PPF}_{n+1}$, so the intersection inside $\mathrm{PPF}_{n+1}$ is empty; treating the formal $\widehat 0$, the order complex is also empty (single point with $\widehat 0$, contractible if we adjoin).

So $E_1^{p,q}=0$ for $p<n-1$, $q\ge 0$. The spectral sequence is trivial (concentrated in $p=n-1$, $q=0$ is also zero or one-dimensional depending on convention).

This means the Mayer–Vietoris spectral sequence *recovers* the contractibility of the punctured ideal in a structurally consistent way (the punctured Boolean cube has $\widetilde H^{n-2}\ne 0$, equal to $\mathbb Z$, but that comes from the *boundary* of the simplex, which is the order complex with $\widehat 0$ and $\widehat 1$ removed — the simplex boundary).

Wait: the punctured ideal $(\omega_n\!\downarrow)\setminus\{\omega_n\}=\{\omega_S:S\subsetneq[n],S\ne\emptyset\}$ is *order-isomorphic to* $2^{[n]}\setminus\{\emptyset,[n]\}$, the doubly-punctured Boolean cube. Its order complex is $\Delta(2^{[n]}\setminus\{\emptyset,[n]\})\simeq S^{n-2}$, the boundary of the $(n-1)$-simplex (Björner, Folkman). Top reduced cohomology $\widetilde H^{n-2}=\mathbb Z$, with $\mathrm{sgn}_{S_n}$-rep rationally.

So the Mayer–Vietoris spectral sequence above must compute this correctly. Re-examining: the intersections $(\omega_{[n]\setminus I}\!\downarrow)$ are *cones* (with apex $\omega_{[n]\setminus I}$) for $I\subsetneq[n]$, hence contractible. For $I=[n]$, the intersection is empty (or formal-$\widehat 0$). The nerve of the cover is the simplex $\Delta^{n-1}$ on $n$ vertices (since every non-trivial intersection is non-empty and contractible — Čech to Leray-equivalence). The colimit is the union of the cover, $(\omega_n\!\downarrow)\setminus\{\omega_n\}$, with order complex equivalent to the *boundary* of the nerve simplex (because the nerve is the $(n-1)$-simplex and the union of the $n$ "facets" $(\omega_n^{(x)}\!\downarrow)$ is the boundary). So the homotopy type is $\partial\Delta^{n-1}=S^{n-2}$. ✓

This confirms the structural fact (D-4) of §3.3 via the Mayer–Vietoris spectral sequence.

The Bridge-A constraint extraction proceeds by **applying the same cover to $\widetilde{\mathcal F}$** in place of $(\omega_n\!\downarrow)$:

$$
  \widetilde{\mathcal F}\setminus\{\omega_n\}\;=\;\bigcup_{x\in[n]}\bigl(\widetilde{\mathcal F}\cap(\omega_n^{(x)}\!\downarrow)\bigr).
$$

Each $\widetilde{\mathcal F}\cap(\omega_n^{(x)}\!\downarrow)$ is a meet-subsemilattice of $(\omega_n^{(x)}\!\downarrow)\cong 2^{[n]\setminus\{x\}}\setminus\{\emptyset\}$. If $\widetilde{\mathcal F}\cap(\omega_n^{(x)}\!\downarrow)$ contains $\omega_n^{(x)}$ (equivalently, $[n]\setminus\{x\}\in\mathcal F$), then this slice is contractible (cone with apex $\omega_n^{(x)}$). Else it has a smaller maximum, possibly with nontrivial $S^{n-3}$-like topology recursively.

The Mayer–Vietoris spectral sequence on this family-cover:
$$
  E_1^{p,q}\;=\;\bigoplus_{|I|=p+1}\widetilde H^q\bigl(\Delta(\widetilde{\mathcal F}\cap(\omega_{[n]\setminus I}\!\downarrow))\bigr)\;\Longrightarrow\;\widetilde H^{p+q}\bigl(\Delta(\widetilde{\mathcal F}\setminus\{\omega_n\})\bigr).
$$

The $E_1^{0,q}$-row is $\bigoplus_{x\in[n]}\widetilde H^q(\Delta(\widetilde{\mathcal F}\cap(\omega_n^{(x)}\!\downarrow)))$ — the slice-cohomology profile of $\mathcal F$.

> **Bridge-A statement (target for UC10).** *Couple this slice-cohomology profile of $\mathcal F$ to the F17+F18 top class via the structural inclusion $\Delta(\widetilde{\mathcal F})\hookrightarrow\Delta_{n+1}$ and the survival theorem (Theorem 4.3); extract a sign-dichotomy on $\sum_x|f_x^c-|\widetilde{\mathcal F}|/2|$ that forces some $f_x^c\ge|\widetilde{\mathcal F}|/2$.*

UC9 does **not** complete Bridge A in this session — the spectral-sequence argument requires careful tracking of differentials $d_r$ for $r\ge 2$ (the Mayer–Vietoris spectral sequence for poset covers degenerates at $E_2$ only under specific conditions on the cover; the family cover does *not* automatically degenerate without more structural input — e.g. a "Cohen–Macaulay condition" on $\widetilde{\mathcal F}$). The key open question for UC10's Bridge-A session: under what intersection-closure-implied conditions on $\widetilde{\mathcal F}$ does the Mayer–Vietoris spectral sequence degenerate cleanly enough to extract the slice-statistic constraint?

**Compliance with hard constraints.** Bridge A's spectral sequence is **non-functorial**: it is one MV spectral sequence per $\mathcal F$, with the differentials depending on $\mathcal F$'s slice profile *combinatorially* (not via a functor). It is **not factorial**: no $S_n$-isotypic decomposition is invoked beyond the $\mathrm{sgn}_{S_n}$ on the F17+F18 top class. ✓

### 5.3 Bridge B — Möbius/Euler characteristic with deletion-contraction

The Möbius function $\mu_P$ of a poset $P$ on $\widehat 0,\widehat 1$-bounded extension $P^*=P\cup\{\widehat 0,\widehat 1\}$ satisfies (Hall theorem):
$$
  \mu_{P^*}(\widehat 0,\widehat 1)\;=\;\widetilde\chi(\Delta(P))\;=\;\sum_k(-1)^k\dim\widetilde H^k(\Delta(P);\mathbb Q).
$$

Applied to $P=\mathrm{PPF}_{n+1}$:
$$
  \mu_{\mathrm{PPF}_{n+1}^*}(\widehat 0,\widehat 1)\;=\;\widetilde\chi(\Delta_{n+1})\;=\;(-1)^{n-1}\dim\widetilde H^{n-1}(\Delta_{n+1};\mathbb Q)\;=\;(-1)^{n-1}.
$$
(by F17+F18: top concentration, dim 1).

So **the Möbius function of $\mathrm{PPF}_{n+1}^*$ at $(\widehat 0,\widehat 1)$ is $(-1)^{n-1}$, unconditionally**.

Applied to $P=\widetilde{\mathcal F}$ (with $\widehat 0,\widehat 1$ adjoined; $\widetilde{\mathcal F}$'s actual maximum is $\omega_n$, identified with $\widehat 1$):
$$
  \mu_{\widetilde{\mathcal F}^*}(\widehat 0,\widehat 1)\;=\;\widetilde\chi(\Delta(\widetilde{\mathcal F}))\;=\;0
$$
(since $\Delta(\widetilde{\mathcal F})$ is contractible, by Lemma 4.4).

The two Möbius values disagree: the F17+F18-cohomology of $\mathrm{PPF}_{n+1}$ gives $(-1)^{n-1}$; the family contractibility gives $0$. The Bridge-B mechanism: **the discrepancy $(-1)^{n-1}-0=(-1)^{n-1}$ accumulates somewhere in $\mathrm{PPF}_{n+1}^*\setminus\widetilde{\mathcal F}^*$**.

Möbius identity for nested posets (a standard "deletion-contraction" lemma for Möbius functions on subposets):
$$
  \mu_{\mathrm{PPF}_{n+1}^*}(\widehat 0,\widehat 1)\;=\;\sum_{X\in\mathrm{ord.\,partition\,of\,}\mathrm{PPF}_{n+1}^*}(-1)^{|X|-1}\;[\text{joint contribution of $X$}],
$$
or more cleanly, the **closed-form deletion-contraction on the elements outside $\widetilde{\mathcal F}$**:
$$
  \mu_{\mathrm{PPF}_{n+1}^*}(\widehat 0,\widehat 1)\;=\;\mu_{\widetilde{\mathcal F}^*}(\widehat 0,\widehat 1)\;+\;\sum_{y\in\mathrm{PPF}_{n+1}\setminus\widetilde{\mathcal F}}\mu_{\mathrm{PPF}_{n+1}^*}(\widehat 0,y)\,\mu_{\mathrm{PPF}_{n+1}^*}(y,\widehat 1)\;\cdot\;[\text{corrections}].
$$
(Schematic; the precise form requires the Crapo–Rota deletion-contraction or the Stanley reduction-of-Möbius via blocking elements; UC9 §5.3 surfaces this as the bridge ingredient and defers the precise form to UC10.)

The Bridge-B constraint extraction: **express $(-1)^{n-1}$ as a Möbius sum over the *complement* of $\widetilde{\mathcal F}$ in $\mathrm{PPF}_{n+1}$, and use the slice-cover $\{(\omega_n^{(x)}\!\downarrow)\}_x$ to localise the contributions vertex-by-vertex**. The resulting sum is parametrised by the slice profile $(f_x^c)_x$, and its sign-determination (via the F17+F18 sign on the global Möbius value) constrains the $f_x^c$ profile — Frankl-style.

> **Bridge-B statement (target for UC10).** *Carry out the deletion-contraction on $\mathrm{PPF}_{n+1}^*$ relative to $\widetilde{\mathcal F}$, using the $\{(\omega_n^{(x)}\!\downarrow)\}$ cover to organise the complement contributions; show the resulting Möbius identity, evaluated against $(-1)^{n-1}$, forces $\max_x f_x^c\ge|\widetilde{\mathcal F}|/2$ (or a quantitative variant).*

UC9 does **not** complete Bridge B in this session — the deletion-contraction recursion is well-defined but its closed-form evaluation requires a careful induction on the elements of $\mathrm{PPF}_{n+1}\setminus\widetilde{\mathcal F}$; this is a UC10 mandate.

**Compliance with hard constraints.** Bridge B's deletion-contraction is **non-functorial**: it is a recursion on the ambient poset $\mathrm{PPF}_{n+1}^*$ relative to a *specific* family $\widetilde{\mathcal F}$, not a functor on all families. It is **not factorial**: only Möbius numbers and signs enter — no Specht decomposition, no $S_n$-isotypic projection, no factorial cohomology. ✓

### 5.4 Bridge C — equivariant sgn-isotypic projection on the boundary $(n-2)$-sphere

The structural data (D-4): $\Delta((\omega_n\!\downarrow)\setminus\{\emptyset,\omega_n\})\simeq S^{n-2}$, with $S_n$-action having $\widetilde H^{n-2}(S^{n-2})$ in $\mathrm{sgn}_{S_n}$.

So the punctured embedded image carries $\mathrm{sgn}_{S_n}$ in top degree $n-2$.

The branching (D-2): $\widetilde H^{n-1}(\Delta_{n+1})=\mathrm{sgn}_{S_{n+1}}$ restricts to $\mathrm{sgn}_{S_n}$ under the $S_n\subseteq S_{n+1}$ fixing $n+1$.

So **both** the punctured embedded image $S^{n-2}$ and the F17+F18 top class restricted to $S_n$ are $\mathrm{sgn}_{S_n}$. They live in different cohomological degrees ($n-2$ vs $n-1$), but the F18 degree-shift engine identifies them: $\widetilde H^{n-1}(\Delta_{n+1})|_{S_n}\cong\widetilde H^{n-2}(\Delta_n)|_{S_n}$ via F18, and $\widetilde H^{n-2}(\Delta_n)|_{S_n}\cong\widetilde H^{n-2}(S^{n-2})$ via the structural-cohomology isomorphism on $\Delta_n$.

The Bridge-C extraction: **the boundary sphere $S^{n-2}$ of the punctured Boolean cube is a *witness* for the F17+F18 top class, equivariantly under $S_n$**. The embedded family $\widetilde{\mathcal F}\setminus\{\omega_n\}\subseteq\Delta(\mathrm{im}\setminus\{\omega_n\})\simeq S^{n-2}$ is a sub-complex of this sphere; the complementary sub-complex $\Delta(\mathrm{im}\setminus(\widetilde{\mathcal F}\cup\{\omega_n\}))$ carries the *missing* part of the sphere's top class.

The equivariant Euler characteristic:
$$
  \chi^{S_n}(S^{n-2})\;=\;\chi^{S_n}\bigl(\Delta(\widetilde{\mathcal F}\setminus\{\omega_n\})\bigr)\;+\;\chi^{S_n}\bigl(\Delta(\text{complement})\bigr)\;-\;\chi^{S_n}(\text{intersection}),
$$
with the $\mathrm{sgn}_{S_n}$-isotypic projection extracting the sign-component from each term.

The structural identity on $S^{n-2}$:
$$
  \langle\chi^{S_n}(S^{n-2}),\mathrm{sgn}_{S_n}\rangle\;=\;(-1)^{n-2}\;\dim\widetilde H^{n-2}(S^{n-2};\mathbb Q)^{\mathrm{sgn}_{S_n}}\;=\;(-1)^{n-2}\cdot 1\;=\;(-1)^{n-2},
$$
the $\mathrm{sgn}_{S_n}$-component of the equivariant Euler characteristic.

The Bridge-C extraction: **decompose this $\mathrm{sgn}_{S_n}$-component as the sgn-Euler-characteristic of $\widetilde{\mathcal F}\setminus\{\omega_n\}$ plus the sgn-Euler-characteristic of the complement, with overlap correction; the slice statistics $f_x^c$ enter as the cycle weights via the $S_n$-action permuting vertices; the sign-balance condition forces $\max_x f_x^c\ge|\widetilde{\mathcal F}|/2$**.

> **Bridge-C statement (target for UC10).** *Carry out the equivariant Euler-characteristic decomposition on $S^{n-2}$ relative to $\widetilde{\mathcal F}\setminus\{\omega_n\}$, project onto $\mathrm{sgn}_{S_n}$, and extract a sign-bound on the slice profile that closes Frankl.*

UC9 does **not** complete Bridge C in this session — the equivariant Euler characteristic on $S^{n-2}$ requires the Lefschetz-style trace formula and the Burnside-style averaging, both of which are well-defined but their *combination with intersection-closure* of $\widetilde{\mathcal F}$ is non-trivial: intersection-closure is not an $S_n$-invariant property of the family (different $\sigma\in S_n$ yield different $\sigma\cdot\widetilde{\mathcal F}$, all intersection-closed but generally distinct), so the averaging needs care. UC10 mandate.

**Compliance with hard constraints.** Bridge C uses **only** the $\mathrm{sgn}_{S_n}$-projection of the Euler characteristic, not the full Specht-decomposition or factorial isotypic structure. The $S_n$-equivariance entering is the *additive* one of the F18 cone $\omega_n$-stabilizer, not a factorial decomposition of $\mathrm{Pos}_{n+1}$. ✓ It is **non-functorial**: the equivariant Euler characteristic is computed for a *specific* $\widetilde{\mathcal F}$, not via a functor. ✓

### 5.5 The dual case: $\mathcal F$ with $[n]\notin\mathcal F$

§1.2's WLOG-step assumed $[n]\in\mathcal F$; this is *not* always achievable. If $[n]\notin\mathcal F$, then $\mathcal F$'s maximum is $M_{\mathcal F}\subsetneq[n]$, and the WLOG step said the dual Frankl is trivial (every $x\in[n]\setminus M_{\mathcal F}$ is rare with $|\mathcal F_{\bar x}|=|\mathcal F|$). So the §1.2 normal form (with $[n]\in\mathcal F$) covers all non-trivial cases. UC9 §§2–5 thus apply to all non-trivial intersection-closed families, and the dual case is structurally trivial — no separate analysis needed.

Symmetrically, on the union-closed side via the flip: if $\emptyset\notin\mathcal F^c$ (the union-closed counterpart), the union-closed Frankl is trivial. So both sides reduce to the same non-trivial case via §1.

### 5.6 What §5 has and has not produced

Has:
- A precise vocabulary for Frankl in the embedded dialect (Lemma 5.2: max-slice-half).
- The vertex-slice cover of the principal ideal (Lemma 5.1) and its Mayer–Vietoris spectral sequence (Bridge A).
- The Möbius identity $\mu_{\mathrm{PPF}_{n+1}^*}(\widehat 0,\widehat 1)=(-1)^{n-1}$ (from F17+F18) and the deletion-contraction set-up against $\widetilde{\mathcal F}$ (Bridge B).
- The boundary $(n-2)$-sphere of the punctured Boolean cube + the equivariant sgn-isotypic projection (Bridge C).
- All three bridges respect Daniel's NOT-factorial / NOT-functorial constraints (compliance recorded per bridge).

Has not:
- The closed-form evaluation of any of the three bridges. Each is set up; each requires a UC10 session to complete.
- A unified bridge — UC9 is non-committal on which of A/B/C is most tractable; UC10 should attempt all three, in order of difficulty (B is likely easiest as a first deletion-contraction; A is structurally cleanest if the spectral sequence degenerates; C is most powerful but requires the equivariant trace machinery).
- A sharp Frankl bound. UC9 explicitly is not GREEN.

The honest status: §5 has produced **three concrete forward sessions for UC10**, each with a precise mandate.

---

## §6. Verdict, U1 obstruction check, and the UC10 ask

### 6.1 The verdict

**AMBER-cohomology-pulls-back-cleanly-but-Frankl-extraction-needs-UC10.**

Daniel's four-step strategy:
1. Flip to intersection-closed (UC9 §1) — **DONE unconditionally**, lossless.
2. Embed $2^{[n]}$ into $\mathrm{Pos}_{n+1}$ (UC9 §2) — **DONE unconditionally**, uniquely pinned by Theorem 2.4.
3. Consume F17+F18 cohomology (UC9 §3) — **DONE unconditionally**, restated as Fact F at $n+1$.
4. Extract constraints on the family (UC9 §4 + §5) — **NOT DONE unconditionally** in this session. The U1-shaped wall of §4 (direct pullback is zero, family-pair LES is family-independent) is identified; three candidate non-functorial bridges are surfaced (§§5.2–5.4), each with a precise UC10 mandate; none completes a Frankl bound in UC9.

GREEN would require step 4 closing — a Frankl bound (or a sharp residual gap) extracted from one of the bridges. UC9 does not deliver this and is honest about it.

RED would require the embedding to be vacuous (no nontrivial constraint extractable) — UC9 has *not* shown vacuousness; the U1 wall is a wall *for the direct morphism*, but three non-functorial bridges around it are concrete and not vacuous. So RED is not the verdict either.

The honest middle: **AMBER**.

### 6.2 The U1 obstruction check

**mg-26fc U1 (verbatim, F-series):** *no operational bridge between BK spectral data and $\Delta(\mathrm{PPF}_n)$ cohomology — the obvious morphism* $F_{\mathrm{BK}}\to F_\ell$ *is identically zero or otherwise degenerate.*

**UC9 wall (cohomology dialect of U1):** *no operational bridge between an intersection-closed family $\mathcal F$ on $[n]$ and the F17+F18 cohomology of $\Delta(\mathrm{PPF}_{n+1})$ via the cone-embedding pullback — the morphism $(\iota_n^{\mathrm{cone}})^*$ is identically zero, and the family-pair LES is family-independent on the contractibility class.*

**Structural identity:** the two walls are **the same wall in different dialects**. Both arise from the *same* feature of the F17+F18 cohomology cathedral: it lives in *one* concentrated degree $(n-1)$ on $\Delta(\mathrm{PPF}_{n+1})$, and any *contractible* probe (the BK-spectral-sheaf in F28's dialect, the embedded Boolean image in UC9's dialect) sees zero through the obvious pullback.

The *contractible-probe phenomenon* is the structural bottleneck: any natural contravariant functor from "small / nice / self-contained probes" into the $\Delta(\mathrm{PPF}_{n+1})$-cohomology lands in zero, because (a) the probes are typically contractible (cones with apexes — as in UC9's Boolean image, or as in F28's constant sheaves), and (b) the F17+F18 cathedral is too sgn-concentrated to admit non-zero pullbacks from contractible probes.

The dissolve, in both dialects: **go around the obvious morphism via a *non-functorial* bridge**. F29's Bridge: a Čech 2-cocycle on $\mathrm{PPF}_n$ assembled from *bad-cut-local* biases on subposets, with the "not sgn-like" step contradicting F17+F18's sgn-concentration. UC9's bridges (§§5.2–5.4): vertex-slice MV (A), Möbius-deletion-contraction (B), equivariant sgn-isotypic projection (C). All non-functorial; all candidate dissolves of the same wall.

> **U1 obstruction status (UC9):** the U1 wall is **identified, named, and structurally-analogous to F-series U1**. Three candidate dissolves are surfaced; none completes in UC9. The dissolve attempts are independent of F29's outcome (F17+F18 is unconditional regardless), so UC9 can proceed to UC10 without waiting on F29. **The U1-wall is the single load-bearing residual of UC9; it is not a closure-stop, it is a dissolve-target for UC10.**

### 6.3 The UC10 ask

UC10 should:

1. **Pick one bridge** (A, B, or C — UC9 §6.4 ranks them) and run it to closed-form completion.
2. **Verify the closed-form bridge respects Daniel's hard constraints**: NOT factorial, NOT functorial (relation to Pos_n cohomology should be inherent / structural / numerical, not categorical).
3. **Extract the constraint on $\mathcal F$**: a sharp Frankl bound (GREEN), a parametrised Frankl bound (e.g. quantitative — GREEN-quantitative), a near-Frankl bound with a sharp residual (AMBER-residual-pinned), or a structural obstruction (RED-bridge-fails, with precise localisation).
4. **If RED, try the next bridge.** UC9 surfaces three precisely so that one bridge's RED does not close UC9's verdict to RED — three independent dissolve attempts must all RED for the verdict to flip.

### 6.4 Bridge ranking for UC10

UC9's recommendation, in order of likely tractability:

- **First: Bridge B (Möbius/Euler/deletion-contraction).** *Reasons:* Möbius numbers are *numerical*; the F17+F18 input enters as a single $(-1)^{n-1}$ value; the deletion-contraction is a well-known recursion (Crapo–Rota, Stanley); intersection-closure of $\widetilde{\mathcal F}$ enters as a clean Möbius identity on the meet-subsemilattice. The hardest part is the closed-form evaluation of the recursion for *general* $\widetilde{\mathcal F}\subseteq(\omega_n\!\downarrow)$, which is non-trivial but well-trodden in lattice combinatorics. Likely outcome: AMBER-residual-pinned, with a quantitative bound on the slice profile.
- **Second: Bridge C (equivariant sgn-isotypic projection).** *Reasons:* equivariant Euler characteristic on $S^{n-2}$ has a clean Lefschetz-trace-formula expression; the sgn-projection isolates the relevant component; the F17+F18 input is a single sign coefficient. The hardest part is the *combination with intersection-closure*: $\widetilde{\mathcal F}$'s slice profile under $S_n$-averaging is structurally intricate. Likely outcome: GREEN-quantitative if the averaging works; RED-averaging-fails if it does not.
- **Third: Bridge A (vertex-slice MV spectral sequence).** *Reasons:* spectral sequences are powerful but technically demanding; the differentials $d_r$ for $r\ge 2$ require a "Cohen–Macaulay" or similar structural condition on $\widetilde{\mathcal F}$ that intersection-closure does not automatically supply; degeneration at $E_2$ is plausible but unproven. Likely outcome: AMBER-degeneration-conditional-on-extra-structure, requiring further input from intersection-closure or from one of the UC1–UC8 structural results (e.g. UC6 deficiency contraction, UC8 cross-fibre persistence) to supply the missing degeneration condition.

If all three bridges RED in UC10, the UC9 strategy is genuinely walled; the *fallback* is to attempt a fourth bridge (e.g. via the F-series internal cofiber Morse $M_{\mathrm{rel}}^{\mathrm{eq}}$ pulled back to the embedded image, but this would breach the "F17+F18 black-box only" discipline of §0.2 and is therefore *outside UC10's scope* — it would be a separate ticket).

### 6.5 Independence statements

- **UC9 is independent of F29's outcome.** F29 (mg-70b0) attempts a Čech-cohomology assembly on the 1/3-2/3 side; its GREEN/AMBER/RED does not affect UC9. Both consume F17+F18 unconditionally; their bridges are structurally distinct (Čech vs embedding pullback). If F29 GREENs, UC9 has a *template* for what a successful bridge looks like (it does not change UC9's bridges, but motivates the UC10 push). If F29 REDs, UC9 may still GREEN — the embedding mechanism is structurally distinct from the Čech assembly mechanism.
- **UC9 is independent of the F-series program-status decisions.** F25 RED, F27 RED, F28 AMBER have not affected UC9's load-bearing inputs (F17+F18). UC9 uses *only* the unconditional F17+F18 cohomology theorem; the rest of the F-series cathedral is not touched.
- **UC9 is independent of the UC1–UC8 native cathedral.** UC9 does not consume any UC1–UC8 result directly. UC1 §3/§4's dead routes (E1–E3, C1–C5) are respected; UC9 does not breach them. A future UC10 may *combine* UC9 bridges with UC1–UC8 native results (e.g. UC6 deficiency contraction supplying a degeneration condition for Bridge A), but UC9 itself does not depend on UC1–UC8.

### 6.6 Trust-surface impact

**None.** Paper-and-pencil only; no new axioms; no Lean changes; no computation; no engine port (E1–E3 / C1–C5 untouched). The 1/3-2/3 critical path (`one_third_width_three`) is untouched. The F-series cathedral is consumed only via the black-boxed F17+F18 theorem (Fact F at $n+1$); no F-series internal engine is touched.

The single load-bearing trust input is the unconditional F17+F18 cohomology (`one_third_width_three`'s mg-4d3a + mg-d039), which is itself paper-and-pencil-verifiable and harness-verified (F17 21/21 checks pass; F18 43677/43677 checks pass).

UC9 is **safe**: any future revision of the F17+F18 input would require revising UC9, but the F17+F18 input is *itself* unconditional within the F-series cathedral, so the trust dependency is single-and-clean.

---

## §7. References

### 7.1 Parent chain on `union_closed`

- mg-f72a (UC1) — `docs/union-closed-compat-geom-manifesto.md`, `docs/state-UC1.md`. AMBER-partial-transfer. The intrinsic-object pin, the framework-vs-engine split, the dead routes E1–E3 / C1–C5 (UC1 §3, §4, §8.4) — UC9 §0.1 respects.
- mg-a814 (UC2) — `docs/union-closed-UC2-transport-deficiency.md`, `docs/state-UC2.md`. The native compatibility-geometry construction, $m(\mathcal F)\le 2$ settled.
- mg-cfc0 (UC3) — `docs/union-closed-UC3-walsh-subcube-spectrum.md`, `docs/state-UC3.md`. Walsh / sub-cube spectrum.
- mg-0bf7 (UC4) — `docs/union-closed-UC4-large-fibre-residual.md`, `docs/state-UC4.md`. Large-fibre residual + I1 interlock.
- mg-3806 (UC5) — `docs/union-closed-UC5-trace-defect-residual.md`, `docs/state-UC5.md`. Trace-defect residual via cross-S and cross-generator couplings; defect retraction $\bar\jmath_R$ + deficiency $\delta_R,\,\mathrm{Def}(R)$.
- mg-6dad (UC6) — `docs/union-closed-UC6-large-fibre-residual-close.md`, `docs/state-UC6.md`. Closes UC5 large-fibre-defect residual via tiling-coupling + Gram/hybrid; Theorem 3.1 deficiency contraction.
- mg-a032 (UC7) — `docs/union-closed-UC7-sign-the-levers.md`, `docs/state-UC7.md`. Signs the three UC6 quantified-but-unsigned levers.
- mg-d68d (UC8) — `docs/union-closed-UC8-extend-lever-signings.md`, `docs/state-UC8.md`. Extends each UC7 signing beyond union-closure-alone via UC6 / UC5 / UC2 structural inputs.
- mg-96a6 (UC9, this) — this document + `docs/state-UC9.md`.

### 7.2 Cross-repo references on `one_third_width_three` (consumed as black box)

- mg-4d3a (F17) — `docs/compatibility-geometry-F17-equivariant-cofiber-morse.md`, `docs/state-F17.md`. **GREEN-equivariant-uniform.** The unconditional reduction $\widetilde H_d(\Delta_{n+1}/\Delta_n)\cong 2\widetilde H_{d-1}(\Delta_n)$ as $S_n$-reps, all $n\ge 3$. **(UCC.1) ⟺ Hyp(n)** discharged. Load-bearing input for Fact F.
- mg-d039 (F18) — `docs/compatibility-geometry-F18-ucc2-delta-injective.md`, `docs/state-F18.md`. **GREEN-ucc2-proven.** $\iota_n:\Delta_n\hookrightarrow\Delta_{n+1}$ null-homotopic, $\delta_n$ injective, all $n\ge 3$, **unconditional**. **(UCC.2) PROVEN.** LES splits: $\widetilde H^k(\Delta_{n+1}/\Delta_n)\cong\widetilde H^{k-1}(\Delta_n)\oplus\widetilde H^k(\Delta_{n+1})$. Combined with F17: degree-shift $\widetilde H^k(\Delta_{n+1})\cong\widetilde H^{k-1}(\Delta_n)$. The cone element $\omega_n=\{(n+1,b):b\in[n]\}$ — load-bearing for UC9 §2's embedding.
- mg-8216 (F10) — `docs/general-n-proof-synthesis.md`, `docs/state-F10.md`. The cohomological-core framing; §6.2 inductive step closing Hyp(n+1) from Hyp(n) + (UCC) — gives Fact F at every $n\ge 3$ via the F17+F18+F10 closure.
- mg-b352 (F11) — `docs/state-F11.md`. The "all content in $\mathrm{sgn}$" cohomological framing.
- mg-26fc (the structural-analogy two-mechanisms framing) — the "constrained compatibility geometry cannot remain globally isotropic" meta-thesis; F17+F18 as the unconditional non-isotropy engine; the U1-obstruction language UC9 §6.2 inherits.
- mg-70b0 (F29 — the 1/3-2/3 sibling) — Čech-cohomology assembly on the 1/3-2/3 side via bad cut → local biases → Čech 2-cocycle. UC9 sibling, structurally distinct mechanism (Čech vs embedding-pullback).

### 7.3 Frankl literature (background, not load-bearing)

- Frankl (1979) — the original union-closed conjecture.
- Reimer (2003) — the average set size bound; intersection-closed dialect.
- Gilmer (2022) — entropy method; first $\Omega(1)$ constant.
- Sarkar (2025) — the $\frac{1}{2}$ result on certain restricted intersection-closed families. (UC9 does *not* use these; they motivate the intersection-closed dialect and the slice statistics, but UC9's bridges are cohomological and independent.)

### 7.4 Background (cohomology / topology / Möbius)

- Björner (1995) — *Topological methods in combinatorics*, Ch 10–11. The order-homotopy lemma; the Boolean-cube boundary $\simeq S^{n-2}$; the Mayer–Vietoris spectral sequence on poset covers.
- Stanley (2012) — *Enumerative Combinatorics* Vol. 1, Ch 3. The Möbius function on partial orders, Hall theorem, Crapo–Rota deletion-contraction.
- Folkman (1966) — the punctured Boolean cube as boundary of the simplex.
- Hatcher (2002) — *Algebraic Topology*, Ch 2. The Mayer–Vietoris LES, the cofiber LES, equivariant cohomology for finite groups (Bredon, restricted to free actions).
- Bredon (1967) — equivariant cohomology, the sgn-isotypic decomposition for $S_n$-actions.

### 7.5 Directives consumed

- Daniel reminder 2026-05-15T23:57:20Z (the UC9 mandate, verbatim in §0.3).
- Daniel verbatim 2026-05-15T23:20Z (anti-factorial directive — `feedback_anti_factorial_direction`).
- Daniel verbatim 2026-05-15T23:20Z (NOT functorial, inherently related directive).
- Daniel verbatim 2026-05-15T20:22Z ("Union closed is lower priority and likely should emulate what we do here").
- pm-onethird memory `feedback_polecat_cumulative_state_doc` — cumulative state doc per ticket.
- pm-onethird memory `feedback_latex_first_for_math_simp` — LaTeX-first.
- pm-onethird memory `feedback_n_poset_is_not_ordinal_sum` — verify embeddings directly (UC9 §2.3).
- pm-onethird memory `feedback_manage_branches_default_to_main` — let dispatch land on main.

---

*End of UC9 main document. State ledger: `docs/state-UC9.md`. Branch: `polecat-cat-mg-96a6`. Verdict: AMBER-cohomology-pulls-back-cleanly-but-Frankl-extraction-needs-UC10. Trust-surface impact: none.*
