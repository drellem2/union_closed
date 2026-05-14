# Union-Closed Compatibility-Geometry — UC2: the coordinate-transport deficiency question (mg-a814)

**Repo:** `union_closed`. **Parent:** mg-f72a (UC1, AMBER-partial-transfer) — `docs/union-closed-compat-geom-manifesto.md`, the founding manifesto; UC2 is scoped in UC1 §8.
**Branch:** `union-closed-UC2-transport-deficiency`.
**Type:** Native structure theory + construction attempt. Paper-and-pencil; **no new axioms; no Lean; no computation; no engine port.** LaTeX-style Markdown, F-series house style. Multi-session-able; cumulative state ledger in `docs/state-UC2.md`.
**Cross-repo references (read access):** `one_third_width_three` — mg-26fc, F10, F11, `main.tex`, `step8.tex` (the 1/3-2/3 reference material; UC2 uses it only to stay clear of the dead routes UC1 §8.4 named).

---

**Verdict: GREEN-structure-theory.**

The structure theory of the coordinate-transport system $\bigl(G(\mathcal F),\{M_x\},\{\mathcal F_x^{\mathrm{stuck}},\mathcal F_{\bar x}^{\mathrm{stuck}}\}\bigr)$ is **established** (§2), and the deficiency question's two remaining sub-deliverables — the injection attack (§3) and the meta-thesis forcing mechanism (§4) — are **both substantially advanced**, with the central question sharpened to a single precise next step (§5).

The load-bearing results:

- **(§2) Structure theory — sub-deliverable 1, complete.** The matched part of each coordinate is exactly the covering structure of the lattice $(\mathcal F,\subseteq)$: $A\in\mathcal F_x^{\mathrm{match}}\iff A\setminus\{x\}\lessdot A$ (Theorem 2.1). The reject-side stuck-set $\mathcal F_{\bar x}^{\mathrm{stuck}}$ is an **order ideal** of the union-closed family $\mathcal F_{\bar x}$, and the matched part $\mathcal F_{\bar x}^{\mathrm{match}}$ is a **filter** that is non-empty **iff $T_x\cup\{x\}\in\mathcal F$** — so $\mathcal F_{\bar x}^{\mathrm{stuck}}$ is indeed controlled by $\mathcal F_{\bar x}$'s own maximum $T_x$, decisively for the all-or-nothing question (Theorem 2.2). The need-side stuck-set $\mathcal F_x^{\mathrm{stuck}}$ is the complement of a union-closed family and is, in general, neither up- nor down-closed — the asymmetry (D2) of UC1 §1.1, sharpened (Theorem 2.3). Every join-irreducible of $\mathcal F$ is stuck in **all but at most one** of its coordinates (Corollary 2.4). The global identity $\sum_x\beta_x=2\sum_{A}|A|-n|\mathcal F|$ holds with the **entire transport graph $G(\mathcal F)$ cancelling** (Theorem 2.5).
- **(§3) The injection attack — sub-deliverable 2, substantially advanced.** Frankl reduces to: for some $x$, an injection $\mathcal F_{\bar x}^{\mathrm{stuck}}\hookrightarrow\mathcal F_x^{\mathrm{stuck}}$ (Proposition 3.1 — the matched parts cancel exactly). The union map $u_W$ has fibres equal to $\mathcal F\cap[\,C\setminus W,\;C\setminus\{x\}\,]$, sub-families of $\mathcal F$ inside cube-intervals (Lemma 3.3). The **trace-partition theorem** (Theorem 3.5) recovers the classical small-set cases **natively**: if $\mathcal F$ contains a set $W$ with $|W|\le 2$, then $\sum_{x\in W}\beta_x\ge 0$, hence some $x\in W$ is abundant — and the proof exposes *precisely* why $|W|\le 2$ is the boundary: the trace-class coefficients $2|S|-|W|$ are $\le 0$ off the extremes exactly when $|W|\le 2$, and the union map controls only the two extreme trace-classes. The residual gap is therefore pinned to one object: the **intermediate trace-classes $\mathcal F^S$, $0<|S|<|W|$, of a minimal set $W$ with $|W|\ge 3$**.
- **(§4) The meta-thesis forcing mechanism — sub-deliverable 3, substantially advanced.** Full globalization of $\{M_x\}$ to a $(\mathbb Z/2)^n$-action happens **iff $\mathcal F=2^U$** (all $\beta_x=0$): the trivial extreme (Proposition 4.1). Union-closure makes the square-defect **one-sided** — no 2-face of $Q_n$ can have both mid-corners in $\mathcal F$ and the top corner out (Proposition 4.2). The decisive rigorous finding: the literal measure of *how much $\{M_x\}$ does globalize* — the edge count $|E(G(\mathcal F))|$ — **cancels identically out of $\sum_x\beta_x$** (Theorem 2.5 / §4.3). So "failure to globalize" in *aggregate* is provably **orthogonal** to the bias; the bias is carried entirely by the **signed per-coordinate imbalance** of the stuck-sets. "Failure to globalize" is an *unsigned* defect and cannot, by itself, force the *signed* statement $\max_x\beta_x\ge 0$ — the forcing, if it exists, must come from union-closure **orienting** the defect, and §2's filter-vs-non-filter asymmetry is exactly that orientation. UC2 *identifies* the forcing mechanism but does not *close* it: the orientation is real but not yet shown to dominate quantitatively.

**Why GREEN-structure-theory and not GREEN-deficiency-resolved.** UC2 does not resolve the deficiency question; the native recovery of the $|W|\le 2$ cases (§3) reproduces classically-known results, and the residual gap (§5) is genuine. **Why not AMBER.** The structure theory of sub-deliverable 1 is fully established, not "partly built"; sub-deliverables 2 and 3 are both substantially advanced with named, precise residual gaps — not "resists, nothing to show." The central question is sharpened to a single next step and the indicated route forward is identified (§5: fallback **F-i**, the Walsh/harmonic route, now informed by the trace-class localization).

**The honest one-sentence verdict.** *The coordinate-transport system's structure theory is established — the matched part is the lattice covering structure, the reject-side stuck-set is an order ideal controlled by $T_x$, and the transport graph cancels out of the aggregate bias — and this structure theory localizes the entire residual difficulty of Frankl, within the compatibility-geometry framing, to a single object: the intermediate trace-classes of a minimal set of size $\ge 3$, which is exactly where the Walsh/harmonic fallback F-i should be aimed next.*

§0 fixes notation and recaps UC1's pinned objects; §1 states the deficiency question; §2 is the structure theory (sub-deliverable 1); §3 is the injection attack (sub-deliverable 2); §4 is the meta-thesis forcing mechanism (sub-deliverable 3); §5 is the verdict and the precise next step; §6 the references.

---

## §0. Notation and recap of UC1's pinned objects

Notation is UC1's (manifesto §0), restated where load-bearing.

$U$ is a finite ground set, $|U|=n$; $2^U$ is the Boolean lattice / cube $Q_n$. $\mathcal F\subseteq 2^U$ is a **union-closed family**: $A,B\in\mathcal F\Rightarrow A\cup B\in\mathcal F$, with $\mathcal F\neq\emptyset$ and $\mathcal F\neq\{\emptyset\}$. WLOG $U=\bigcup\mathcal F$, hence $U\in\mathcal F$ (a finite union-closed family has a $\subseteq$-maximum). For $x\in U$:

$$
  \mathcal F_x:=\{A\in\mathcal F:x\in A\},\qquad
  \mathcal F_{\bar x}:=\{A\in\mathcal F:x\notin A\}=\mathcal F\setminus\mathcal F_x,
$$
$$
  a(x):=|\mathcal F_x|/|\mathcal F|\quad\text{(abundance)},\qquad
  \beta_x:=|\mathcal F_x|-|\mathcal F_{\bar x}|\quad\text{(bias)}.
$$

**The pinned objects (UC1 §1, the invariants of `docs/state-UC1.md`).**

- **Intrinsic object.** The cube $Q_n$ is the ambient; $\mathcal F\subseteq Q_n$ is the state space; $G(\mathcal F)$ — the subgraph of $Q_n$ induced on $\mathcal F$ — is the **transport graph**. (Exact structural analogue of $G_{\mathrm{BK}}(P)\subseteq$ permutahedron skeleton.)
- **Coordinate-transport involutions.** $\sigma_x:2^U\to 2^U$, $\sigma_x(A)=A\triangle\{x\}$, generate $(\mathbb Z/2)^n$ on $Q_n$. Restricted to $\mathcal F$, $\sigma_x$ is the **partial matching**
  $$
    M_x:=\bigl\{\{A,A\setminus\{x\}\}:A\in\mathcal F_x,\;A\setminus\{x\}\in\mathcal F\bigr\},
  $$
  the set of direction-$x$ edges of $G(\mathcal F)$. Its unmatched vertices:
  $$
    \mathcal F_x^{\mathrm{stuck}}:=\{A\in\mathcal F_x:A\setminus\{x\}\notin\mathcal F\}\quad\text{(sets that \emph{need} $x$)},
  $$
  $$
    \mathcal F_{\bar x}^{\mathrm{stuck}}:=\{A'\in\mathcal F_{\bar x}:A'\cup\{x\}\notin\mathcal F\}\quad\text{(sets that \emph{reject} $x$)}.
  $$
- **Transport identity.** $|\mathcal F_x|=|M_x|+|\mathcal F_x^{\mathrm{stuck}}|$ and $|\mathcal F_{\bar x}|=|M_x|+|\mathcal F_{\bar x}^{\mathrm{stuck}}|$, hence
  $$
    \boxed{\;\beta_x=|\mathcal F_x^{\mathrm{stuck}}|-|\mathcal F_{\bar x}^{\mathrm{stuck}}|.\;}
  $$
  $M_x$ contributes nothing to the bias.
- **Union-closure gifts (UC-Lemmas 1–4).** (1) $\mathcal F_x$ is a filter and union-closed. (2) $\mathcal F_{\bar x}$ is an order ideal and is itself a union-closed family on $U\setminus\{x\}$, with $\subseteq$-maximum $T_x:=\bigcup\mathcal F_{\bar x}$. (3) the union map $u_W:\mathcal F_{\bar x}\to\mathcal F_x$, $A'\mapsto A'\cup W$ ($W\in\mathcal F_x$ fixed) is well-defined but not injective in general; Frankl $\iff$ some $x$ admits an injection $\mathcal F_{\bar x}\hookrightarrow\mathcal F_x$. (4) if $x$ lies in every set of $\mathcal F$ then $x$ is abundant — so in a counterexample $\mathcal F_x,\mathcal F_{\bar x}\neq\emptyset$ for all $x$.
- **Obstruction (4 forms).** (O1) $a(x)<\tfrac12\ \forall x$; (O2) $|\mathcal F_x^{\mathrm{stuck}}|<|\mathcal F_{\bar x}^{\mathrm{stuck}}|\ \forall x$; (O3) every level-1 Walsh coefficient $\widehat{\mathbf 1_{\mathcal F}}(\{x\})>0$, since $\beta_x=-2^n\widehat{\mathbf 1_{\mathcal F}}(\{x\})$; (O4) the centroid $c(\mathcal F)\in[0,\tfrac12)^n$.

**Lattice conventions.** $(\mathcal F,\subseteq)$ is a finite join-semilattice (join $=$ union) with top $U$. We write $A\lessdot B$ for "$A$ is a lower cover of $B$ in $(\mathcal F,\subseteq)$" — i.e. $A\subsetneq B$, $A,B\in\mathcal F$, and no $C\in\mathcal F$ has $A\subsetneq C\subsetneq B$. Adjoining a bottom $\hat 0$ (used only where flagged) makes $(\mathcal F\cup\{\hat 0\},\subseteq)$ a lattice; $A\in\mathcal F$ is **join-irreducible** if it has a unique lower cover in $\mathcal F\cup\{\hat 0\}$, equivalently $A\neq\bigcup\{C\in\mathcal F:C\subsetneq A\}$. We do **not** assume $\emptyset\in\mathcal F$.

**What UC2 must not do (UC1 §8.4), kept in view.** No port of Theorem E or the Steps 1–7 rigidity engine (gaps E1–E3); no $\Delta(\mathrm{UCF}_n)$ chamber ambient and (H-Cox) hunt (gap C2, dead by F11's own logic, sharper here); no $S_n$-isotypic / FI machinery (gap C3 — the obstruction's harmonic home is $(\mathbb Z/2)^n$/Walsh). UC2 is a native construction on the objects above. The 1/3-2/3 route-(ii) critical path is untouched.

---

## §1. The coordinate-transport deficiency question

The transport identity $\beta_x=|\mathcal F_x^{\mathrm{stuck}}|-|\mathcal F_{\bar x}^{\mathrm{stuck}}|$ reframes Frankl's conjecture exactly.

> **Definition 1.1 (transport-deficiency).** A coordinate $x$ is **transport-deficient** in $\mathcal F$ if $|\mathcal F_x^{\mathrm{stuck}}|<|\mathcal F_{\bar x}^{\mathrm{stuck}}|$, equivalently $\beta_x<0$, equivalently $a(x)<\tfrac12$. It is **transport-sound** otherwise ($\beta_x\ge 0$).

> **Frankl, transport form (UC1 §8.2).** Every union-closed $\mathcal F$ has a transport-sound coordinate. A *counterexample* is a $\mathcal F$ that is **transport-deficient in every coordinate**.

> **The UC2 question.** Does union-closure forbid simultaneous transport-deficiency in every coordinate?

The point of the transport form is that it is *local and signed*. The matching $M_x$ — the part of $\sigma_x$ that *does* survive on $\mathcal F$ — is invisible to $\beta_x$; only the **stuck-sets** carry the bias, and only their **signed imbalance**, coordinate by coordinate. UC2 attacks this on three fronts, exactly as the ticket scopes:

1. **Characterize the stuck-sets** via union-closure (§2): pin $\mathcal F_x^{\mathrm{stuck}}$ against the join-irreducibles and the lower-cover structure of $(\mathcal F,\subseteq)$; determine whether $\mathcal F_{\bar x}^{\mathrm{stuck}}$ is controlled by $T_x$.
2. **Attack the injection** (§3): test whether the union map $u_W$ — or an averaged / per-coordinate-best variant — can be made injective on the stuck part for some $x$, via the interlock between $\{u_W\}$ and $\{M_x\}$.
3. **Test the meta-thesis mechanism** (§4): state precisely whether "the $\{M_x\}$ fail to globalize to a $(\mathbb Z/2)^n$-action" *forces* $\max_x\beta_x\ge 0$.

A note on what "attack" means here, set against UC1's verdict. UC1 established that Frankl inherits no *engine* from either 1/3-2/3 mechanism; UC2 is the first attempt to build a native one. The realistic target — and the one the ticket's GREEN-structure-theory tag describes — is to **establish the structure theory and sharpen the central question to a precise next step**, not to prove Frankl. UC2 meets that target; §5 states exactly what is and is not closed.

---

## §2. Structure theory of the coordinate-transport system (sub-deliverable 1)

This section is self-contained and rigorous. Everything is paper-and-pencil and elementary; the content is in the *packaging* — pinning the stuck-sets to named lattice-theoretic and graph-theoretic objects of the intrinsic structure.

### 2.1 The matched part is the lattice covering structure

> **Theorem 2.1 (matched $=$ covered).** For $A\in\mathcal F_x$:
> $$
>   A\in\mathcal F_x^{\mathrm{match}}\;:=\;\mathcal F_x\setminus\mathcal F_x^{\mathrm{stuck}}
>   \quad\Longleftrightarrow\quad
>   A\setminus\{x\}\;\lessdot\;A\ \text{ in }(\mathcal F,\subseteq).
> $$
> Dually, for $A'\in\mathcal F_{\bar x}$: $\;A'\in\mathcal F_{\bar x}^{\mathrm{match}}\iff A'\lessdot A'\cup\{x\}$.

*Proof.* $A\in\mathcal F_x^{\mathrm{match}}$ means $A\setminus\{x\}\in\mathcal F$. The cube-interval $[A\setminus\{x\},A]$ in $2^U$ has exactly the two elements $A\setminus\{x\}\subsetneq A$, so any $C\in\mathcal F$ with $A\setminus\{x\}\subseteq C\subseteq A$ is one of them: $A\setminus\{x\}$ is a lower cover of $A$. Conversely a lower cover lies in $\mathcal F$. The dual statement is the same argument on $[A',A'\cup\{x\}]$. $\qquad\blacksquare$

So the matched part of coordinate $x$ is *precisely* the set of covering relations of the lattice $(\mathcal F,\subseteq)$ that are **axis-aligned single steps** in direction $x$ — and these are exactly the direction-$x$ edges of the transport graph $G(\mathcal F)$. The matching $M_x$, the lattice's covering relations, and the cube-edges of $G(\mathcal F)$ are the *same data* viewed three ways:

$$
  M_x \;=\; \{\text{direction-}x\text{ edges of }G(\mathcal F)\}
  \;=\; \{\text{covering relations }A\setminus\{x\}\lessdot A\text{ of }(\mathcal F,\subseteq)\}.
$$

Note that $(\mathcal F,\subseteq)$ can also have **long covers** — covering relations $C\lessdot A$ with $|A\setminus C|\ge 2$ — which are *not* edges of $G(\mathcal F)$ and contribute to no $M_x$. The stuck-sets, below, are the shadow of the long covers and the non-covers.

**The degree bookkeeping.** For $A\in\mathcal F$ define the **free coordinates**
$$
  D(A):=\{x\in A:A\setminus\{x\}\in\mathcal F\},\qquad
  U\!p(A):=\{x\notin A:A\cup\{x\}\in\mathcal F\}.
$$
$D(A)$ is the down-degree and $U\!p(A)$ the up-degree of $A$ in $G(\mathcal F)$; $\deg_{G(\mathcal F)}(A)=|D(A)|+|U\!p(A)|$. By Theorem 2.1, $A$ is matched in direction $x$ iff $x\in D(A)$ (for $x\in A$) or $x\in U\!p(A)$ (for $x\notin A$). Hence the **pointwise stuck-membership rule**:
$$
  A\in\mathcal F_x^{\mathrm{stuck}}\iff x\in A\setminus D(A),
  \qquad
  A\in\mathcal F_{\bar x}^{\mathrm{stuck}}\iff x\in(U\setminus A)\setminus U\!p(A).
\tag{2.1}
$$
A set $A$ is stuck in $|A|-|D(A)|$ "need" directions and $(n-|A|)-|U\!p(A)|$ "reject" directions; it is matched (an edge of $G(\mathcal F)$) in the remaining $\deg_{G(\mathcal F)}(A)$ directions.

### 2.2 The reject-side stuck-set is an order ideal, controlled by $T_x$

> **Theorem 2.2 (reject-side structure).** For each $x$:
> 1. $\mathcal F_{\bar x}^{\mathrm{match}}$ is a **filter** (up-set) of the lattice $\mathcal F_{\bar x}$, and is union-closed.
> 2. Consequently $\mathcal F_{\bar x}^{\mathrm{stuck}}=\mathcal F_{\bar x}\setminus\mathcal F_{\bar x}^{\mathrm{match}}$ is an **order ideal** (down-set) of $\mathcal F_{\bar x}$.
> 3. $\mathcal F_{\bar x}^{\mathrm{match}}\neq\emptyset\iff T_x\in\mathcal F_{\bar x}^{\mathrm{match}}\iff T_x\cup\{x\}\in\mathcal F$, where $T_x=\bigcup\mathcal F_{\bar x}$.
>
> In particular: **$T_x\cup\{x\}\notin\mathcal F\iff\mathcal F_{\bar x}^{\mathrm{stuck}}=\mathcal F_{\bar x}$** (every $x$-avoiding set rejects $x$), and then $\beta_x=|\mathcal F_x^{\mathrm{stuck}}|-|\mathcal F_{\bar x}|$.

*Proof.* (1) *Up-set:* let $A'\in\mathcal F_{\bar x}^{\mathrm{match}}$ (so $A'\cup\{x\}\in\mathcal F$) and $A'\subseteq C\in\mathcal F_{\bar x}$. Then $C\cup\{x\}=C\cup(A'\cup\{x\})$ is a union of two members of $\mathcal F$, hence in $\mathcal F$; and $x\in C\cup\{x\}$, so $C\in\mathcal F_{\bar x}^{\mathrm{match}}$. *Union-closed:* if $A',B'\in\mathcal F_{\bar x}^{\mathrm{match}}$ then $(A'\cup B')\cup\{x\}=(A'\cup\{x\})\cup(B'\cup\{x\})\in\mathcal F$. (2) The complement of an up-set is a down-set. (3) A non-empty up-set of a poset with a top element contains the top; $\mathcal F_{\bar x}$ has top $T_x$. And $T_x\in\mathcal F_{\bar x}^{\mathrm{match}}\iff T_x\cup\{x\}\in\mathcal F$ by definition. The final equivalence is the contrapositive. $\qquad\blacksquare$

This answers the ticket's sub-deliverable-1 question "is $\mathcal F_{\bar x}^{\mathrm{stuck}}$ controlled by $\mathcal F_{\bar x}$'s own maximum $T_x$?" — **decisively for the all-or-nothing question**: a single membership test, $T_x\cup\{x\}\in\mathcal F$?, decides whether $\mathcal F_{\bar x}^{\mathrm{stuck}}$ is everything or a proper ideal. And it gives the *shape* of $\mathcal F_{\bar x}^{\mathrm{stuck}}$ even in the proper case: it is always an order ideal of the union-closed family $\mathcal F_{\bar x}$ — the sets that reject $x$ are exactly the *low* sets of $\mathcal F_{\bar x}$, those not large enough to absorb $x$.

**The filter $\mathcal F_{\bar x}^{\mathrm{match}}$ need not be principal.** It is an up-set closed under union, but not in general a sublattice of $\mathcal F_{\bar x}$ (it need not be closed under the meet of $\mathcal F_{\bar x}$). *Witness:* $U=\{1,2,3\}$, $x=1$, $\mathcal F=\{\emptyset,\{2\},\{3\},\{2,3\},\{1,2\},\{1,3\},\{1,2,3\}\}$ (union-closed; $\{1\}\notin\mathcal F$). Then $\mathcal F_{\bar 1}=\{\emptyset,\{2\},\{3\},\{2,3\}\}$, $T_1=\{2,3\}$, and $\mathcal F_{\bar 1}^{\mathrm{match}}=\{\{2\},\{3\},\{2,3\}\}$ — an up-set, but $\{2\}\wedge\{3\}=\emptyset\notin\mathcal F_{\bar 1}^{\mathrm{match}}$. So the reject-side stuck-set $\mathcal F_{\bar 1}^{\mathrm{stuck}}=\{\emptyset\}$ here, and in general $\mathcal F_{\bar x}^{\mathrm{stuck}}$ is an ideal but the *minimal* matched sets are an antichain, not a single element.

### 2.3 The need-side stuck-set: complement of a union-closed family, neither up nor down

> **Theorem 2.3 (need-side structure).** For each $x$:
> 1. $\mathcal F_x^{\mathrm{match}}$ is union-closed; if non-empty it has a $\subseteq$-maximum $\bigcup\mathcal F_x^{\mathrm{match}}$.
> 2. $\mathcal F_x^{\mathrm{match}}$ is in general **neither an up-set nor a down-set** of the filter $\mathcal F_x$; hence $\mathcal F_x^{\mathrm{stuck}}$ is neither.

*Proof.* (1) If $A,B\in\mathcal F_x^{\mathrm{match}}$ then $(A\cup B)\setminus\{x\}=(A\setminus\{x\})\cup(B\setminus\{x\})\in\mathcal F$, so $A\cup B\in\mathcal F_x^{\mathrm{match}}$; a non-empty finite union-closed family has a maximum. (2) *Not an up-set:* $\mathcal F=\{\emptyset,\{1\},\{1,2\}\}$, $x=1$: $\{1\}\in\mathcal F_1^{\mathrm{match}}$ ($\emptyset\in\mathcal F$) but $\{1,2\}\notin\mathcal F_1^{\mathrm{match}}$ ($\{2\}\notin\mathcal F$), and $\{1\}\subsetneq\{1,2\}$. *Not a down-set:* $\mathcal F=\{\emptyset,\{1\},\{1,2\},\{2,3\},\{1,2,3\}\}$, $x=1$: $\{1,2,3\}\in\mathcal F_1^{\mathrm{match}}$ ($\{2,3\}\in\mathcal F$) but $\{1,2\}\notin\mathcal F_1^{\mathrm{match}}$ ($\{2\}\notin\mathcal F$), and $\{1,2\}\subsetneq\{1,2,3\}$. $\qquad\blacksquare$

This is the precise sharpening of UC1's load-bearing asymmetry **(D2)**: "$\mathcal F_x$ and $\mathcal F_{\bar x}$ are structurally different objects." The two stuck-sets are *not* dual:

| | $\mathcal F_{\bar x}^{\mathrm{stuck}}$ (rejects $x$) | $\mathcal F_x^{\mathrm{stuck}}$ (needs $x$) |
|---|---|---|
| ambient | the union-closed family $\mathcal F_{\bar x}$, top $T_x$ | the filter $\mathcal F_x$, top $U$ |
| match part | a **filter** of $\mathcal F_{\bar x}$ (Thm 2.2) | union-closed, **neither up nor down** (Thm 2.3) |
| stuck part | an **order ideal** of $\mathcal F_{\bar x}$ | complement of a union-closed family — no order shape |
| controlled by | $T_x$ (a single membership test) | no single "$x$-summary" element |

The asymmetry is *exactly* the gap between "$\mathcal F_{\bar x}^{\mathrm{match}}$ closed under enlargement" (always, by union-closure of $\mathcal F$) and "$\mathcal F_x^{\mathrm{match}}$ closed under enlargement" (false: enlarging $A$ can re-block the $x$-deletion). The reject-side has clean order structure because *adding* is union-closure-friendly; the need-side does not because *deleting* is not.

### 2.4 The join-irreducible corollary

> **Corollary 2.4 (join-irreducibles are almost-entirely stuck).** Let $A\in\mathcal F$ be join-irreducible with unique lower cover $A_*$ (in $\mathcal F\cup\{\hat 0\}$). Then:
> - if $A_*=A\setminus\{x_0\}$ for some $x_0$ (i.e. $|A\setminus A_*|=1$): $A$ is matched in direction $x_0$ and stuck in direction $x$ for **every** $x\in A\setminus\{x_0\}$;
> - if $|A\setminus A_*|\ge 2$: $A$ is stuck in direction $x$ for **every** $x\in A$.
>
> In every case a join-irreducible is matched in **at most one** of its $|A|$ coordinates.

*Proof.* By Theorem 2.1, $A$ is matched in direction $x$ iff $A\setminus\{x\}$ is a lower cover of $A$. A join-irreducible has only the one lower cover $A_*$, so $A\setminus\{x\}$ is a lower cover iff $A\setminus\{x\}=A_*$, which forces $|A\setminus A_*|=1$ and $x_0$ to be the unique element of $A\setminus A_*$. (When $\emptyset\notin\mathcal F$, a $\subseteq$-minimal set $m\in\mathcal F$ has $A_*=\hat 0\notin\mathcal F$, so no $A\setminus\{x\}$ is a lower cover *in $\mathcal F$* — $m$ is stuck in all $|m|$ coordinates; a singleton $\{x\}\in\mathcal F$ is matched in direction $x$ iff $\emptyset\in\mathcal F$.) $\qquad\blacksquare$

So the join-irreducibles of $\mathcal F$ are the **most stuck** members on the need-side: each is stuck in all but at most one direction. Since every $A\in\mathcal F$ is a union of join-irreducibles, the need-side stuck-set $\mathcal F_x^{\mathrm{stuck}}$ always *contains* the join-irreducibles $j$ with $x\in j$ and $A_*(j)\neq j\setminus\{x\}$ — a concrete, union-closure-pinned core. This is the UC2 form of the Poonen lattice dictionary (UC1 §9.3): not the imperfect $x\leftrightarrow$ join-irreducible *bijection*, but the exact statement *join-irreducibility forces need-side stuckness*. The non-join-irreducible members are where matching can be plentiful (e.g. in $\mathcal F=2^U$ every set is matched in every coordinate and the only join-irreducibles are the singletons, each matched in its one direction).

### 2.5 The global counting identity — the transport graph cancels

> **Theorem 2.5 (the aggregate bias and its cancellation).**
> $$
>   \sum_{x\in U}\beta_x \;=\; 2\sum_{A\in\mathcal F}|A|\;-\;n\,|\mathcal F|.
> $$
> Moreover, in the natural derivation of this identity from the stuck-sets, the **entire transport graph cancels**: writing $|E|:=|E(G(\mathcal F))|$,
> $$
>   \sum_x|\mathcal F_x^{\mathrm{stuck}}|=\sum_{A}|A|-|E|,
>   \qquad
>   \sum_x|\mathcal F_{\bar x}^{\mathrm{stuck}}|=n|\mathcal F|-\sum_{A}|A|-|E|,
> $$
> and the $|E|$ terms cancel in the difference.

*Proof.* Sum the pointwise rule (2.1) over $A$. A set $A$ contributes to $|\mathcal F_x^{\mathrm{stuck}}|$ for each $x\in A\setminus D(A)$, i.e. $|A|-|D(A)|$ times, and to $|\mathcal F_{\bar x}^{\mathrm{stuck}}|$ for each $x\in(U\setminus A)\setminus U\!p(A)$, i.e. $(n-|A|)-|U\!p(A)|$ times. Now $\sum_A|D(A)|$ counts pairs $(A,x)$ with $x\in A$, $A\setminus\{x\}\in\mathcal F$ — that is, the edges of $G(\mathcal F)$ counted from their upper endpoint — so $\sum_A|D(A)|=|E|$; likewise $\sum_A|U\!p(A)|=|E|$ counting from the lower endpoint. Hence the two displayed sums, and
$$
  \sum_x\beta_x=\sum_x|\mathcal F_x^{\mathrm{stuck}}|-\sum_x|\mathcal F_{\bar x}^{\mathrm{stuck}}|
  =\Bigl(\textstyle\sum_A|A|-|E|\Bigr)-\Bigl(n|\mathcal F|-\sum_A|A|-|E|\Bigr)
  =2\sum_A|A|-n|\mathcal F|.\quad\blacksquare
$$

Theorem 2.5 has two readings, and both are load-bearing for §§3–4.

**Reading 1 — the aggregate bias is just average set size.** $\sum_x\beta_x=2\sum_A|A|-n|\mathcal F|=|\mathcal F|\cdot\bigl(2\,\overline{|A|}-n\bigr)$ where $\overline{|A|}$ is the average set size. So $\sum_x\beta_x\ge 0\iff\overline{|A|}\ge n/2\iff\sum_x a(x)\ge n/2$ — this is just obstruction-form (O4) summed: the centroid's coordinate-sum. A counterexample has $\overline{|A|}<n/2$; this is consistent (Frankl is hard) and gives *no contradiction at the aggregate level*. Pure global counting cannot prove Frankl — confirmed, and confirmed *natively*.

**Reading 2 — the transport graph is orthogonal to the bias.** The edge count $|E(G(\mathcal F))|$ — the literal measure of how much the involutions $\{M_x\}$ *do* match, i.e. how much they *do* globalize — appears in *both* aggregate stuck-counts and **cancels exactly** from $\sum_x\beta_x$. The aggregate bias does not see $G(\mathcal F)$ at all. This is the rigorous core of the sub-deliverable-3 finding (developed in §4.3): "how much the $\{M_x\}$ fail to globalize", as an *aggregate unsigned* quantity, is provably **decoupled** from the bias. The bias lives entirely in the **signed, per-coordinate** imbalance of the stuck-sets — a strictly finer invariant than any count of edges or non-edges.

**The vector picture.** For each $A\in\mathcal F$ define $v_A\in\{-1,0,+1\}^U$ by
$$
  v_A(x)=\begin{cases}
    +1 & x\in A\setminus D(A)\quad(\text{$A$ needs $x$, stuck}),\\
    -1 & x\in(U\setminus A)\setminus U\!p(A)\quad(\text{$A$ rejects $x$, stuck}),\\
    \ \,0 & x\in D(A)\cup U\!p(A)\quad(\text{$A$ matched in direction $x$ — an edge of $G(\mathcal F)$}).
  \end{cases}
$$
Then $\beta=\sum_{A\in\mathcal F}v_A$, and Frankl is the assertion that the vector $\beta$ has a non-negative coordinate, i.e. $\beta\notin\mathbb Z_{<0}^U$. Each $v_A$ has $+1$'s on the non-free elements of $A$, $-1$'s on the non-free non-elements, and $0$'s on the $\deg_{G(\mathcal F)}(A)$ matched directions. Theorem 2.5 says $\sum_x\sum_A v_A(x)=2\sum_A|A|-n|\mathcal F|$; the per-$A$ zero-pattern (the transport graph) washes out of the coordinate-sum, but it is exactly the per-$A$ *correlation* between the $+1$-support and the $-1$-support — which sets carry which signs together — that union-closure must constrain to force $\beta\not<0$. §3 attacks that correlation directly.

---

## §3. The injection attack (sub-deliverable 2)

UC-Lemma 3 gives Frankl $\iff$ some $x$ admits an injection $\mathcal F_{\bar x}\hookrightarrow\mathcal F_x$, and hands over the non-injective union map $u_W$. This section (i) reduces the target to the *stuck parts only*, (ii) analyses the fibres of $u_W$, (iii) proves the **trace-partition theorem**, which recovers the classical small-set cases natively *and* localizes the residual difficulty to one named object, and (iv) records a Hall-type criterion and the precise residual gap.

### 3.1 Reduction: it suffices to inject the stuck parts

> **Proposition 3.1 (the matched parts cancel).** For each $x$, $|M_x|$ is the common size of the matched parts $\mathcal F_x^{\mathrm{match}}$ and $\mathcal F_{\bar x}^{\mathrm{match}}$, and
> $$
>   \beta_x\ge 0
>   \iff |\mathcal F_x^{\mathrm{stuck}}|\ge|\mathcal F_{\bar x}^{\mathrm{stuck}}|
>   \iff \text{there is an injection }\ \mathcal F_{\bar x}^{\mathrm{stuck}}\hookrightarrow\mathcal F_x^{\mathrm{stuck}}.
> $$
> Hence **Frankl $\iff$ for some $x$, an injection $\mathcal F_{\bar x}^{\mathrm{stuck}}\hookrightarrow\mathcal F_x^{\mathrm{stuck}}$ exists.**

*Proof.* The edge-set $M_x$ matches $\mathcal F_x^{\mathrm{match}}$ to $\mathcal F_{\bar x}^{\mathrm{match}}$ bijectively (each direction-$x$ edge has one endpoint in each), so $|\mathcal F_x^{\mathrm{match}}|=|\mathcal F_{\bar x}^{\mathrm{match}}|=|M_x|$. The transport identity $\beta_x=|\mathcal F_x^{\mathrm{stuck}}|-|\mathcal F_{\bar x}^{\mathrm{stuck}}|$ then gives the first equivalence; the second is the finite-set fact that an injection between finite sets exists iff the domain is no larger. $\qquad\blacksquare$

This is the right target. The injection $\mathcal F_{\bar x}\hookrightarrow\mathcal F_x$ of UC-Lemma 3 is "too big": its matched parts already inject *for free* via $M_x$ itself (it is a perfect matching between $\mathcal F_x^{\mathrm{match}}$ and $\mathcal F_{\bar x}^{\mathrm{match}}$). The entire difficulty is the **stuck-to-stuck injection**, and that is what the union map must be tested against. Note the two sides are structurally unlike (Theorem 2.3): $\mathcal F_{\bar x}^{\mathrm{stuck}}$ is an order ideal of $\mathcal F_{\bar x}$, $\mathcal F_x^{\mathrm{stuck}}$ has no order shape.

### 3.2 The union map and its fibres

Fix $x$ and $W\in\mathcal F_x$. The union map $u_W:\mathcal F_{\bar x}\to\mathcal F_x$, $A'\mapsto A'\cup W$, is well-defined by union-closure. Its failure to be injective is measured by its fibres.

> **Lemma 3.3 (fibres are sub-families inside cube-intervals).** For $C\in\mathcal F_x$,
> $$
>   u_W^{-1}(C)=\mathcal F\cap[\,C\setminus W,\;C\setminus\{x\}\,]
>   =\{A'\in\mathcal F:C\setminus W\subseteq A'\subseteq C\setminus\{x\}\}.
> $$
> This is a union-closed family inside a cube-interval of dimension $|W|-1$. Consequently
> $$
>   |\mathcal F_x|\ \ge\ |u_W(\mathcal F_{\bar x})|\ =\ |\mathcal F_{\bar x}|-\sum_{C}\bigl(|u_W^{-1}(C)|-1\bigr),
> $$
> the sum over non-empty fibres, so $\beta_x\ge-\sum_C(|u_W^{-1}(C)|-1)$.

*Proof.* $A'\cup W=C$ with $x\notin A'$ iff $A'\subseteq C$, $A'\supseteq C\setminus W$, and $x\notin A'$ — i.e. $C\setminus W\subseteq A'\subseteq C\setminus\{x\}$ (using $x\in W$, so $C\setminus W\subseteq C\setminus\{x\}$). The interval $[C\setminus W,C\setminus\{x\}]$ has dimension $|(C\setminus\{x\})\setminus(C\setminus W)|=|W\setminus\{x\}|=|W|-1$; intersecting the union-closed $\mathcal F$ with the union-closed interval gives a union-closed family. The count is inclusion of the image in $\mathcal F_x$ together with $\sum_C|u_W^{-1}(C)|=|\mathcal F_{\bar x}|$. $\qquad\blacksquare$

Two immediate consequences pin the "small $W$" regime.

> **Corollary 3.4 (small generators give injectivity).** If some coordinate $x$ has a set $W\in\mathcal F_x$ with $|W|=1$ — i.e. $\{x\}\in\mathcal F$ — then $u_{\{x\}}$ is injective, $\mathcal F_{\bar x}^{\mathrm{stuck}}=\emptyset$, and $\beta_x=|\mathcal F_x^{\mathrm{stuck}}|\ge 0$: $x$ is abundant.

*Proof.* $|W|=1$ makes every interval $[C\setminus W,C\setminus\{x\}]$ a single point, so all fibres are singletons and $u_{\{x\}}$ is injective; $u_{\{x\}}(A')=A'\cup\{x\}\in\mathcal F$ exhibits every $A'\in\mathcal F_{\bar x}$ as matched. $\qquad\blacksquare$

This is the native, transport-language form of the classical observation "a family containing a singleton has that element abundant" — and it reads cleanly: $\{x\}\in\mathcal F$ collapses the reject-side filter $\mathcal F_{\bar x}^{\mathrm{match}}$ (Theorem 2.2) all the way to $\mathcal F_{\bar x}$. To go further we need to handle $|W|\ge 2$, where fibres are genuine union-closed families inside positive-dimensional intervals. The union map alone does not bound their sizes — and §3.3 shows *exactly* how far it does reach.

### 3.3 The trace-partition theorem — native recovery of the small-set cases, and the localization

Fix any $W\in\mathcal F$ with $|W|=k$ (not necessarily containing a chosen $x$). Partition $\mathcal F$ by its **trace on $W$**: for $S\subseteq W$,
$$
  \mathcal F^S:=\{A\in\mathcal F:A\cap W=S\}.
$$
The $2^k$ classes $\{\mathcal F^S\}_{S\subseteq W}$ partition $\mathcal F$. For $x\in W$, $\beta_x=\sum_{S\subseteq W}|\mathcal F^S|\cdot\varepsilon_x(S)$ where $\varepsilon_x(S)=+1$ if $x\in S$ and $-1$ if $x\notin S$ (sorting members of $\mathcal F$ by whether they contain $x$, refined through the trace). Summing over $x\in W$:
$$
  \sum_{x\in W}\beta_x=\sum_{S\subseteq W}|\mathcal F^S|\sum_{x\in W}\varepsilon_x(S)
  =\sum_{S\subseteq W}|\mathcal F^S|\,\bigl(2|S|-k\bigr).
\tag{3.1}
$$

> **Theorem 3.5 (trace-partition theorem).** Let $W\in\mathcal F$, $|W|=k$.
> 1. The map $j:\mathcal F^\emptyset\to\mathcal F^W$, $A'\mapsto A'\cup W$, is a well-defined injection; hence $|\mathcal F^\emptyset|\le|\mathcal F^W|$.
> 2. If $k\le 2$ then $\sum_{x\in W}\beta_x\ge 0$, so **some $x\in W$ is abundant**.
> 3. If $k\ge 3$, the only trace-classes the union map controls are the two extremes $S\in\{\emptyset,W\}$; the residual quantity is
> $$
>   \sum_{x\in W}\beta_x \;=\; \underbrace{k\bigl(|\mathcal F^W|-|\mathcal F^\emptyset|\bigr)}_{\ge\,0\ \text{by (1)}}
>   \;+\;\underbrace{\sum_{0<|S|<k}|\mathcal F^S|\,(2|S|-k)}_{\text{intermediate trace-classes — uncontrolled}}.
> $$

*Proof.* (1) $A'\in\mathcal F^\emptyset$ has $A'\cap W=\emptyset$, so $A'\cup W\in\mathcal F$ (union-closure) with $(A'\cup W)\cap W=W$, i.e. $A'\cup W\in\mathcal F^W$; and $A'=(A'\cup W)\setminus W$ recovers $A'$, so $j$ is injective. (2) Substitute into (3.1). For $k=1$: $S\in\{\emptyset,W\}$ with coefficients $-1,+1$, so $\sum_{x\in W}\beta_x=|\mathcal F^W|-|\mathcal F^\emptyset|\ge 0$. For $k=2$: coefficients $2|S|-2$ are $-2$ at $|S|=0$, $\;0$ at $|S|=1$, $\;+2$ at $|S|=2$, so $\sum_{x\in W}\beta_x=2(|\mathcal F^W|-|\mathcal F^\emptyset|)\ge 0$. In both cases $\max_{x\in W}\beta_x\ge\frac1k\sum_{x\in W}\beta_x\ge 0$. (3) Split (3.1) into $S\in\{\emptyset,W\}$ (coefficients $\mp k$) and $0<|S|<k$, then apply (1). $\qquad\blacksquare$

Theorem 3.5 does two things at once.

**It recovers the classical small-set cases as a native compatibility-geometry statement.** "If $\mathcal F$ contains a set of size $\le 2$, Frankl holds for $\mathcal F$" is a known easy case; here it falls out of the union map and the trace partition, with no appeal to anything outside the pinned objects. The mechanism is transparent: the injection $j$ controls the two *extreme* trace-classes $\mathcal F^\emptyset,\mathcal F^W$, and the *intermediate* trace-classes $\mathcal F^S$ ($0<|S|<k$) carry coefficient $2|S|-k$ — which is $\le 0$ off the extremes **exactly when $k\le 2$**. At $k=1$ there are no intermediate classes; at $k=2$ the single intermediate level has coefficient $0$ and drops out; at $k\ge 3$ the intermediate coefficients are non-zero and of *mixed sign* ($2|S|-k<0$ for small $|S|$, $>0$ for large $|S|$).

**It localizes the residual difficulty to one named object.** Define the **minimum set size** $m(\mathcal F):=\min\{|A|:A\in\mathcal F,\,A\neq\emptyset\}$. Theorem 3.5(2) says: $m(\mathcal F)\le 2\Rightarrow$ Frankl holds for $\mathcal F$. The hard case is exactly $m(\mathcal F)\ge 3$, and there the obstruction is *precisely* the failure of the union map to control the intermediate trace-classes of a minimal generator. Applying Theorem 3.5(3) to a $\subseteq$-minimal $W\in\mathcal F$ (so $|W|=m(\mathcal F)\ge 3$):

> **The residual gap, named.** To finish the deficiency question along the union-map route it suffices to show, for some minimal $W\in\mathcal F$,
> $$
>   \sum_{0<|S|<|W|}|\mathcal F^S|\,(2|S|-|W|)\ \ge\ -\,|W|\bigl(|\mathcal F^W|-|\mathcal F^\emptyset|\bigr),
> $$
> i.e. that the **intermediate trace-classes do not pull the sum below zero**. Equivalently: control the *family of cube-interval sub-families* $\{\mathcal F^S:0<|S|<|W|\}$ — the very objects Lemma 3.3 identified as the fibres of $u_W$.

That the boundary sits exactly at $m(\mathcal F)=3$ is not a coincidence of this proof: it is the known frontier of Frankl (the conjecture is classical for families with a small set and open in general), and the trace-partition theorem reproduces that frontier *from inside the compatibility-geometry framework*, with a precise reason. This is the sense in which UC2 "sharpens the central question to a precise next step" (verdict tag GREEN-structure-theory).

### 3.4 The interlock, and why a single $W$ cannot be enough

The ticket asks specifically about the **interlock** between $\{u_W\}$ and $\{M_x\}$ — and about "averaged / per-coordinate-best" variants. Theorem 3.5 already shows why no *single* $W$ closes the gap, and points at what an interlock would have to supply.

**Why one $W$ is structurally insufficient ($k\ge 3$).** The union map $u_W$ has *all* its targets land high: $u_W(A')=A'\cup W\supseteq W$, and $j(\mathcal F^\emptyset)\subseteq\mathcal F^W$ is the *top* trace-class. There is no union-closure map carrying an intermediate class $\mathcal F^S$ ($0<|S|<k$) anywhere other than up into $\mathcal F^W$ — because union with anything $\subseteq W$-flavoured only ever *adds* coordinates of $W$. So a single generator $W$ can never "see" its own intermediate trace-classes; they are a blind spot of $u_W$ by construction. This is the union map's structural ceiling, and it is the same ceiling in fibre language: Lemma 3.3 says the fibres of $u_W$ are sub-families of cube-intervals of dimension $k-1\ge 2$, and union-closure does not bound the size of a union-closed family in a $\ge 2$-dimensional interval (any sub-cube is such a family).

**What an interlock must do.** Breaking the ceiling requires *coupling different coordinates' transport data*. Two concrete couplings are available on the pinned objects, and UC2 records them as the entry points for UC3 rather than closing them:

- **(I1) Many generators.** For each minimal $W$, (3.1) gives one linear inequality among the trace-classes $\{|\mathcal F^S|\}$. Different minimal generators $W,W'$ overlap, and $\mathcal F^S$-classes for $W$ refine into $\mathcal F^{S'}$-classes for $W'$. The interlock is the *linear system* obtained by ranging $W$ over all minimal sets; the question is whether union-closure makes this system infeasible for a counterexample. This is genuinely a compatibility-geometry statement — it is the partial-cube structure of $G(\mathcal F)$ read through the generators — and it is the natural UC3 continuation of §3.
- **(I2) Routing through $M_y$.** A collision of $u_W$ — two sets $A',B'\in\mathcal F_{\bar x}$ with $A'\cup W=B'\cup W$ — has $A'\triangle B'\subseteq W\setminus\{x\}$, so $A'$ and $B'$ differ within a *second* coordinate direction $y\in W\setminus\{x\}$. The matching $M_y$ acts on that difference. The "averaged / per-coordinate-best" variant the ticket names is: when $u_W$ collides in direction $y$, repair the collision by transporting along $M_y$ — but Theorem 2.3 (the need-side match-part is neither up nor down) is exactly the obstruction to this repair being globally consistent, because the repaired image need not stay stuck. So the interlock (I2) is *real* but its consistency is governed by the §2.3 asymmetry; making it work is open.

The honest status of sub-deliverable 2: the union map is analysed to its structural ceiling; the ceiling is named precisely (intermediate trace-classes of a minimal $W$, $|W|\ge 3$); and the two interlock mechanisms that could break the ceiling are identified on the pinned objects. The deficiency question is *not* resolved by the union map; it is **localized**.

### 3.5 A Hall-type restatement

For completeness, the per-coordinate injection target of Proposition 3.1 has the expected Hall form, which records *where* the union-closure structure must be injected.

> **Proposition 3.6 (Hall criterion for transport-soundness).** Fix $x$. Build the bipartite graph $H_x$ on $\mathcal F_{\bar x}^{\mathrm{stuck}}\sqcup\mathcal F_x^{\mathrm{stuck}}$ with $A'\sim A$ iff $A'\subseteq A$. Then $x$ is transport-sound ($\beta_x\ge 0$) **if** Hall's condition holds on $H_x$: $|N_{H_x}(\mathcal A)|\ge|\mathcal A|$ for every $\mathcal A\subseteq\mathcal F_{\bar x}^{\mathrm{stuck}}$.

*Proof.* Hall's theorem gives a perfect matching of $\mathcal F_{\bar x}^{\mathrm{stuck}}$ into $\mathcal F_x^{\mathrm{stuck}}$, i.e. an injection; apply Proposition 3.1. $\qquad\blacksquare$

The relation $A'\subseteq A$ is the *only* union-closure-canonical relation between the two stuck-sides: every $A\in\mathcal F_x$ with $A\supseteq A'$ equals $u_A(A')$, so "$A'\subseteq A$, $A\in\mathcal F_x^{\mathrm{stuck}}$" is exactly "$A$ is a union-map image of $A'$ that needs $x$." The content of Frankl, in this form, is that union-closure forces Hall's condition on *some* $H_x$ — and the trace-partition theorem (§3.3) is the statement that it does so whenever $m(\mathcal F)\le 2$, while the intermediate trace-classes are exactly the sets whose presence or absence decides Hall's condition for $m(\mathcal F)\ge 3$. Proposition 3.6 is a restatement, not a step; it is recorded because it makes the residual gap's *shape* (a Hall deficiency) explicit and matches it to fallback F-ii (the $H_0$/component route, where Hall-type deficiencies on $G(\mathcal F)$ live).

---

## §4. The meta-thesis forcing mechanism (sub-deliverable 3)

Daniel's setup sketch — and UC1 §8.2(3) — asks the sharp question: does "**the $\{M_x\}$ fail to globalize to a $(\mathbb Z/2)^n$-action**" *force* $\max_x\beta_x\ge 0$? If yes, name the forcing mechanism; if no, exhibit the obstruction. This section answers it precisely. The short answer: **failure-to-globalize is an *unsigned* defect and cannot, on its own, force the *signed* statement $\max_x\beta_x\ge 0$** — and we make "cannot" rigorous via Theorem 2.5. The forcing, if it exists, must come from union-closure *orienting* the defect; §2's filter-vs-non-filter asymmetry is exactly that orientation; UC2 identifies the mechanism but does not close it.

### 4.1 Full globalization is the trivial extreme

> **Proposition 4.1.** The following are equivalent: (i) the partial matchings $\{M_x\}$ globalize to a genuine $(\mathbb Z/2)^n$-action on $\mathcal F$ (each $\sigma_x$ restricts to a bijection $\mathcal F\to\mathcal F$); (ii) every $M_x$ is a perfect matching on $\mathcal F$ (no stuck-sets at all); (iii) $\mathcal F=2^U$. In that case $\beta_x=0$ for every $x$.

*Proof.* (i)$\Rightarrow$(ii): if $\sigma_x(\mathcal F)=\mathcal F$ then every $A\in\mathcal F$ is $x$-flippable, so $M_x$ matches all of $\mathcal F$. (ii)$\Rightarrow$(iii): if $M_x$ is perfect for all $x$ then $\sigma_x(\mathcal F)=\mathcal F$ for all $x$, so $\mathcal F$ is a union of $\langle\sigma_x:x\in U\rangle=(\mathbb Z/2)^n$-orbits; but $(\mathbb Z/2)^n$ acts transitively on $2^U$, so $\mathcal F\neq\emptyset$ forces $\mathcal F=2^U$. (iii)$\Rightarrow$(i) and the $\beta_x=0$ claim are immediate. $\qquad\blacksquare$

So "globalizes fully" is the single point $\mathcal F=2^U$ of the whole landscape, and there the bias is *identically zero*, not merely non-negative. Every other union-closed family has stuck-sets — *partial* globalization is the generic state, and the meta-thesis question is really about the **gradient**: does the *degree* and *shape* of the globalization failure control the *sign pattern* of $\beta$? Proposition 4.1 says only that the two endpoints agree (no failure $\Rightarrow$ no bias). The content is in between.

### 4.2 The square-defect is one-sided

The first layer of globalization failure is that the $M_x$ are *partial* (§4.3). The second is that they fail to *commute*: $\sigma_x\sigma_y=\sigma_y\sigma_x$ globally on $Q_n$, but on $\mathcal F$ the partial matchings $M_x,M_y$ need not. The commutation defect is carried by the **2-faces of $Q_n$** — the squares — and union-closure constrains it sharply.

> **Proposition 4.2 (one-sided square-defect).** Let $x\neq y$ and let $A\subseteq U\setminus\{x,y\}$. Of the four corners $A,\;A_x:=A\cup\{x\},\;A_y:=A\cup\{y\},\;A_{xy}:=A\cup\{x,y\}$ of the square, union-closure forbids exactly the patterns with $A_x,A_y\in\mathcal F$ and $A_{xy}\notin\mathcal F$. All other corner-patterns can occur. Equivalently: in $G(\mathcal F)$, **every "upper wedge" $\{A_x,A_y\}$ completes upward to its join $A_{xy}$** — there is no missing-top square.

*Proof.* $A_x,A_y\in\mathcal F\Rightarrow A_x\cup A_y=A_{xy}\in\mathcal F$ by union-closure; this is the only constraint a single square imposes (the base $A$ and the mixed patterns are unconstrained, as one checks on small examples). $\qquad\blacksquare$

This is the cubical-complex $X(\mathcal F)$ of UC1 candidate (D) / fallback F-iii, seen at the 2-face level: the missing squares of $G(\mathcal F)$ always miss *downward* (a mid-corner or the base), never the top. The square-defect is **oriented by union-closure** — it is *not* symmetric between "up" and "down." This is the first concrete appearance of the orientation that §4.4 argues is the whole content of the forcing question. (It is recorded here as the F-iii groundwork; UC2 does not develop the higher-degree square-defect further, per scope.)

### 4.3 The decisive point: the globalization defect is orthogonal to the bias

Here is the rigorous heart of the answer to sub-deliverable 3.

Quantify "how much the $\{M_x\}$ fail to globalize" by the natural *unsigned aggregate* defect — the total number of (set, direction) pairs at which transport is stuck:
$$
  \mathrm{Def}(\mathcal F):=\sum_{x}\bigl(|\mathcal F_x^{\mathrm{stuck}}|+|\mathcal F_{\bar x}^{\mathrm{stuck}}|\bigr)
  =\sum_{A\in\mathcal F}\bigl(n-\deg_{G(\mathcal F)}(A)\bigr)
  =n|\mathcal F|-2|E(G(\mathcal F))|.
$$
($\mathrm{Def}(\mathcal F)\ge 0$, with $\mathrm{Def}(\mathcal F)=0\iff\mathcal F=2^U$, by Proposition 4.1 — it is a faithful measure of globalization failure.) Dually, the complementary quantity $2|E(G(\mathcal F))|$ measures *how much the $\{M_x\}$ do globalize*.

> **Theorem 4.3 (orthogonality).** The aggregate bias $\sum_x\beta_x$ depends on neither $\mathrm{Def}(\mathcal F)$ nor $|E(G(\mathcal F))|$: by Theorem 2.5,
> $$
>   \sum_x\beta_x=2\sum_{A}|A|-n|\mathcal F|,
> $$
> in which $|E(G(\mathcal F))|$ — equivalently $\mathrm{Def}(\mathcal F)$ — has cancelled identically. Two union-closed families with the *same* $\sum_A|A|$ and $|\mathcal F|$ but *wildly different* $\mathrm{Def}$ have the *same* aggregate bias.

*Proof.* This is exactly the cancellation displayed in Theorem 2.5: $\sum_x|\mathcal F_x^{\mathrm{stuck}}|=\sum_A|A|-|E|$ and $\sum_x|\mathcal F_{\bar x}^{\mathrm{stuck}}|=n|\mathcal F|-\sum_A|A|-|E|$, and the $|E|$ terms cancel in the difference $\sum_x\beta_x$. $\qquad\blacksquare$

The interpretation is the precise answer to the meta-thesis question:

> **"Failure to globalize" does not force the bias — and Theorem 4.3 says why, rigorously.** The transport graph $G(\mathcal F)$ — the literal record of *how much the $\{M_x\}$ globalize* — and its complement $\mathrm{Def}(\mathcal F)$ — the literal record of *how much they fail to* — are **orthogonal to the aggregate bias**: they cancel out of $\sum_x\beta_x$ identically. The bias is carried entirely by the **signed, per-coordinate** quantity $|\mathcal F_x^{\mathrm{stuck}}|-|\mathcal F_{\bar x}^{\mathrm{stuck}}|$, which is a strictly finer invariant than any *unsigned aggregate* count of stuck pairs or matched edges.

The structural reason: "$\{M_x\}$ fail to globalize" is an **unsigned** property — it counts stuck pairs without regard to *which side* ("needs $x$" vs. "rejects $x$") they sit on. $\max_x\beta_x\ge 0$ is a **signed** statement — it asserts the existence of a coordinate where the need-side stuck-count *wins*. An unsigned aggregate invariant is, by construction, blind to the signs of the per-coordinate differences it aggregates; Theorem 4.3 promotes this from a slogan to a proof, by showing the unsigned data literally cancels. So the meta-thesis "a constrained compatibility geometry cannot remain globally biased" cannot be instantiated for Union-Closed as *"globalization failure $\Rightarrow$ bias controlled"* — the antecedent is the wrong (unsigned) invariant.

### 4.4 The forcing mechanism, identified: union-closure orients the defect

If failure-to-globalize per se does not force $\max_x\beta_x\ge 0$, what would? The forcing must come from a feature of union-closure that **breaks the up/down symmetry** and *orients* the globalization defect — turning the unsigned defect into a signed one that leans the right way. UC2 identifies that feature precisely; it is the §2 asymmetry.

**The orientation is the filter-vs-non-filter asymmetry of §2.** Union-closure acts asymmetrically on the two sides of every coordinate:

- On the **reject side**, union-closure is *constructive*: enlarging an $x$-avoiding set can only *help* it absorb $x$ (Theorem 2.2 — $\mathcal F_{\bar x}^{\mathrm{match}}$ is a filter). So $\mathcal F_{\bar x}^{\mathrm{stuck}}$ is an order ideal: rejection is a *low* phenomenon, and it is *bounded above* by the single test $T_x\cup\{x\}\in\mathcal F$.
- On the **need side**, union-closure is *not* constructive: enlarging an $x$-containing set can *re-block* the $x$-deletion (Theorem 2.3 — $\mathcal F_x^{\mathrm{match}}$ is neither up nor down). So $\mathcal F_x^{\mathrm{stuck}}$ has no order shape and no single summary element; need-stuckness can occur *anywhere*, and Corollary 2.4 shows it is *forced* on the join-irreducibles — the structural skeleton of $\mathcal F$.

This is a genuine orientation: the two stuck-sets are not merely "different sizes" — they are *different kinds of object*, and union-closure makes them so. The reject-side defect is *tame and capped* (an ideal below $T_x$); the need-side defect is *wild and skeletal* (no shape, but forced onto the join-irreducibles). The meta-thesis forcing, *if it goes through*, must be the statement that the wild-but-skeletal need-side defect *out-counts* the tame-but-capped reject-side defect, for at least one coordinate.

> **The precise status of the forcing mechanism.** UC2 *identifies* the forcing mechanism — it is union-closure's orientation of the globalization defect into a capped order ideal on the reject side (Theorem 2.2) versus a shapeless join-irreducible-supported set on the need side (Theorem 2.3, Corollary 2.4) — and *rules out* the naive mechanism (Theorem 4.3: the unsigned defect cannot force a signed conclusion). UC2 does **not** *close* the forcing: showing that the orientation is quantitatively strong enough — that the need-side wins somewhere — is exactly the residual content of Frankl, and it coincides, via §3, with controlling the intermediate trace-classes of a minimal generator (Theorem 3.5(3)).

So the answer to "does failure-to-globalize force $\max_x\beta_x\ge 0$?" is: **not as stated** — the unsigned globalization defect provably cancels out of the aggregate bias (Theorem 4.3) — **but union-closure supplies an orientation** (the §2 filter/ideal asymmetry) that is the *only* candidate forcing mechanism, and whether that orientation dominates is the precise residual gap. This is the honest, precise statement the ticket asks for: the obstruction to a clean "forcing" is exhibited (Theorem 4.3), and the mechanism that would have to do the forcing instead is identified and pinned to the §2 structure theory.

### 4.5 Why this is consistent with — and sharper than — UC1's verdict

UC1 found that Union-Closed "instantiates the meta-thesis *descriptively faithfully*" (the centroidal obstruction (O4) is the meta-thesis verbatim) "but does not inherit either mechanism's machinery." UC2 §4 sharpens this from a resonance statement to a theorem: the meta-thesis's *naive* mechanism for Union-Closed — globalization-failure forcing the bias — is not merely "not inherited," it is **provably the wrong mechanism** (Theorem 4.3), because the natural globalization-failure invariant is unsigned and cancels. The *correct* mechanism, if there is one, is the signed orientation of §2 — and that is native to Union-Closed, owes nothing to either 1/3-2/3 engine, and is exactly the structure theory UC2 built. The meta-thesis remains a *principle*, not a *transfer theorem* (UC1 §6) — but UC2 has now pinned, for Union-Closed, *which* native structure the principle must run through.

---

## §5. Verdict and the precise next step

**Verdict: GREEN-structure-theory.**

UC2's three sub-deliverables, against the ticket's scope:

1. **Characterize the stuck-sets — complete (§2).** The matched part is the lattice covering structure (Theorem 2.1); $\mathcal F_{\bar x}^{\mathrm{stuck}}$ is an order ideal of $\mathcal F_{\bar x}$ and $\mathcal F_{\bar x}^{\mathrm{match}}$ a filter, non-empty iff $T_x\cup\{x\}\in\mathcal F$ — so $\mathcal F_{\bar x}^{\mathrm{stuck}}$ *is* controlled by $T_x$ (Theorem 2.2); $\mathcal F_x^{\mathrm{stuck}}$ is the shapeless complement of a union-closed family (Theorem 2.3); join-irreducibles are stuck in all-but-$\le1$ coordinates (Corollary 2.4); the transport graph cancels from the aggregate bias (Theorem 2.5). The structure theory is established.
2. **Attack the injection — substantially advanced (§3).** Reduced to a stuck-to-stuck injection (Proposition 3.1); the union map's fibres are sub-families of cube-intervals (Lemma 3.3); the trace-partition theorem (Theorem 3.5) recovers the $m(\mathcal F)\le 2$ cases natively and **localizes the entire residual difficulty to the intermediate trace-classes of a minimal generator of size $\ge 3$**; the two interlock mechanisms (I1) many-generators and (I2) routing-through-$M_y$ are identified on the pinned objects; a Hall criterion (Proposition 3.6) records the residual gap's shape.
3. **Test the meta-thesis mechanism — substantially advanced (§4).** Full globalization is the trivial extreme $\mathcal F=2^U$ (Proposition 4.1); the square-defect is one-sided (Proposition 4.2); and decisively, the unsigned globalization defect is **orthogonal to the bias** (Theorem 4.3) — so failure-to-globalize does *not* force $\max_x\beta_x\ge 0$ as stated; the forcing mechanism, if any, is union-closure's *orientation* of the defect via the §2 filter/ideal asymmetry, which UC2 identifies but does not close.

**The central question, sharpened to one precise next step.** Every road in UC2 — the injection attack's residual gap (§3.3), the Hall criterion's deciding object (§3.5), the meta-thesis's uncloseable orientation (§4.4) — converges on the *same* object:

> **The UC3 target.** For a $\subseteq$-minimal $W\in\mathcal F$ with $|W|=m(\mathcal F)\ge 3$, control the **intermediate trace-classes** $\{\mathcal F^S:0<|S|<|W|\}$ — the union-closed sub-families of $\mathcal F$ lying in the cube-intervals between $\mathcal F^\emptyset$ and $\mathcal F^W$ — well enough to show $\sum_{0<|S|<|W|}|\mathcal F^S|(2|S|-|W|)\ge-|W|(|\mathcal F^W|-|\mathcal F^\emptyset|)$.

**Indicated route — fallback F-i (the Walsh/harmonic route).** The intermediate trace-classes are naturally a *higher-degree* phenomenon: the trace partition $\{\mathcal F^S\}_{S\subseteq W}$ is precisely the decomposition of $\mathbf 1_{\mathcal F}$ by its restriction to the sub-cube on coordinates $W$, and the coefficients $2|S|-|W|$ in (3.1) are the level-1 Walsh weights *within that sub-cube*; controlling the intermediate classes is controlling the *higher Walsh levels* of $\mathbf 1_{\mathcal F}$ relative to $W$. This is exactly the regime Gilmer's entropy method addresses (the $m(\mathcal F)\ge 3$, no-small-set regime), and UC1 §8.3 already named F-i as "closest to the current frontier." UC2's contribution to F-i is the *localization*: F-i should be aimed not at the level-1 spectrum in the abstract, but at the **sub-cube Walsh spectrum relative to a minimal generator** — the intermediate trace-classes. UC3 is recommended to pursue F-i with this target.

**Fallbacks F-ii / F-iii remain available and are now connected.** F-ii (the $H_0(G(\mathcal F))$/component route) is the home of the Hall deficiency of Proposition 3.6; F-iii (the square-defect route) is the higher-degree continuation of Proposition 4.2's one-sided square-defect. Neither was developed in UC2 (scope: the primary target did not stall — it produced a structure theory and a precise localization), but both now have an explicit hook into the §§2–4 results.

**Why GREEN-structure-theory is the honest tag.** Not GREEN-deficiency-resolved: UC2 does not forbid simultaneous transport-deficiency, and the native results that *do* resolve it (Theorem 3.5(2), Corollary 3.4) reproduce classically-known cases ($m(\mathcal F)\le 2$, singletons) — real, clean, native, but not new progress on Frankl itself. Not AMBER-primary-stalls: the structure theory is *established*, not "partly built," and sub-deliverables 2 and 3 are *both* substantially advanced with named precise gaps, not "the question resists." The defining feature of GREEN-structure-theory — "the structure theory is established (sub-deliverable 1, and 2 or 3 substantially advanced); the central question is sharpened to a precise next step" — is met, with all three sub-deliverables advanced and a single convergent next step identified.

**Trust-surface impact: none.** Paper-and-pencil; no new axioms, no Lean, no computation. No engine ported (UC1 §8.4's dead routes E1–E3 / C1–C5 are untouched — UC2 builds only on the pinned objects of UC1 §1). The 1/3-2/3 route-(ii) critical path (`one_third_width_three` F17 / mg-4d3a) is in a different repo and is untouched.

---

## §6. References

### 6.1 This repo / parent ticket

- **mg-f72a (UC1)** — `docs/union-closed-compat-geom-manifesto.md`: §1 (the framework, the intrinsic object, the partial matchings $M_x$, the transport identity, UC-Lemmas 1–4), §8 (the scope of this ticket — the coordinate-transport deficiency question, the fallbacks F-i/F-ii/F-iii, and the "what UC2 must not do" list), §3–§4 (the named gaps E1–E3 / C1–C5 — the dead routes UC2 avoids). `docs/state-UC1.md` — the invariants reproduced in §0 here.
- **`README.md`** — the structural analogy; UC1 refined the README's $\Delta(\mathcal F)$ to the internal object (gap C1).

### 6.2 Cross-repo — the 1/3-2/3 reference material (`one_third_width_three`, read access)

Used by UC2 only to stay clear of the dead routes (UC1 §8.4):

- **mg-26fc** — the two 1/3-2/3 mechanisms; the refinement-cover$\leftrightarrow$pair-cut substrate hinge (gap C4 — no union-closed analogue).
- **F10 / F11** — the F-series cohomological program; F11 §3 closed route (i) NEGATIVE on a super-exponential FI-finite-generation obstruction — the precedent gap C2 sharpens (UCF$_n$ is doubly-exponential).
- **`main.tex` / `step8.tex`** — the BK/Cheeger-expansion engine and Theorem E (gaps E1–E3 — no irreducible transport chain, no width-3 knob, no volume$\to$conductance conversion).

### 6.3 Frankl-conjecture literature

- P. Frankl (1979) — the Union-Closed Sets conjecture.
- H. Bruhn, O. Schaudt, *The journey of the union-closed sets conjecture*, Graphs and Combinatorics 31 (2015) — the survey; the classical small-set cases (a family with a set of size $\le 2$ has an abundant element) that Theorem 3.5(2) recovers natively; the lattice reformulation.
- B. Poonen, *Union-closed families*, J. Combin. Theory Ser. A 59 (1992) — the lattice / join-irreducible reformulation; the imperfect $x\leftrightarrow$ join-irreducible dictionary, against which Corollary 2.4 is the exact transport-language statement.
- J. Gilmer, *A constant lower bound for the union-closed sets conjecture* (2022); W. Sawin; Z. Chase & S. Lovett; R. Alweiss, B. Huang & M. Sellke; L. Pebody (2022–2023) — the entropy/information-theoretic method and the $(3-\sqrt5)/2$ improvements: morally, level-1 Walsh-spectrum estimates for indicators of union-closed families. The home of fallback F-i, the route §5 recommends for UC3, now aimed at the sub-cube spectrum relative to a minimal generator.
- R. O'Donnell, *Analysis of Boolean Functions* (2014) — Walsh–Fourier analysis on the cube; the level-1 spectrum and the obstruction-form (O3).

### 6.4 Source directives

- Daniel directives 2026-05-14 — the setup sketch (coordinate-transport involutions / transport system / union closure forces failure to globalize); UC2 sub-deliverable 3 (§4) is its direct descendant, and the answer is: failure-to-globalize is unsigned and does not force the signed bias (Theorem 4.3), but union-closure's orientation of the defect (§4.4) is the candidate mechanism.

---

*Polecat: mg-a814 (UC2). Branch: `union-closed-UC2-transport-deficiency`. Verdict: **GREEN-structure-theory** — the coordinate-transport system's structure theory is established (matched part = lattice covering structure; $\mathcal F_{\bar x}^{\mathrm{stuck}}$ = order ideal controlled by $T_x$; $\mathcal F_x^{\mathrm{stuck}}$ = shapeless complement of a union-closed family; join-irreducibles stuck in all-but-$\le1$ coordinates; transport graph cancels from the aggregate bias), and the deficiency question's injection attack (§3) and meta-thesis mechanism (§4) are both substantially advanced: the trace-partition theorem recovers the $m(\mathcal F)\le2$ cases natively and localizes the entire residual difficulty to the intermediate trace-classes of a minimal generator of size $\ge3$; the unsigned globalization defect is proved orthogonal to the bias, so failure-to-globalize does not force $\max_x\beta_x\ge0$ as stated, with union-closure's filter/ideal orientation identified as the only candidate forcing mechanism. Central question sharpened to one precise next step; recommended route UC3 = fallback F-i (Walsh/harmonic), aimed at the sub-cube spectrum relative to a minimal generator. No new axioms; no Lean; no computation; no engine port.*
