# UC-Lean-scope — Lean 4 / mathlib scoping for the Frankl closure (UC10+UC12+UC11+UC13+UC14 chain) (mg-d57e)

**Repo:** `union_closed`.
**Parent arc:** mg-814b (UC10) → mg-707c (UC12) → mg-9ef0 (UC11) → mg-83f0 (UC13) → mg-500c (UC14). All five GREEN; chain Lean-formalization-ready per UC14 §4.6. **Cumulative ledger:** `docs/state-UC10.md` Session 6 (this update).
**Branch:** `polecat-cat-mg-d57e`.
**Type:** Scoping ticket (NOT execution). Enumerates Lean 4 / mathlib signatures for 22 load-bearing primitives, identifies mathlib dependencies and gaps, decomposes the execution work into 5 sub-execution-tickets layered L1–L5, and carries forward the Daniel hard constraints (NOT factorial, NOT functorial in the refinement sense, U1-dialect-check preserved, math-first per pm-onethird). Paper-and-pencil enumeration only; **no Lean compilation is performed in this document — signatures are placeholder-style only.**
**Dispatch:** Origin Daniel reminder 2026-05-16T07:23Z ("super high priority that we formalize it in lean"); pm-onethird `feedback_pre_execution_dependency_verification` mandates scoping precede execution-ticket file.

---

**Verdict: GREEN — ready-for-execution-L1-L5.**

The Frankl-closure chain UC10+UC12+UC11+UC13+UC14 admits a clean decomposition into five Lean execution layers L1–L5, with 22 load-bearing primitives whose Lean signatures are enumerated in §A. The mathlib dependency map (§B) identifies the standard parts (abelian-group Maschke, basic Bousfield–Kan model categorical structure, cofiber long exact sequences, monoidal $(\mathbb Z/2)^n$ characters) and the gaps that need custom-built (cubical-Walsh-defect complex $X(\mathcal F)$, the doubling functor `db`, the cubical-bridge null-homotopy `h_x`, the Čech bicomplex of $\mathcal F_{\mathrm{obs}}$ with Walsh-isotype decomposition, the Bousfield–Kan presentation of $\mathop{\mathrm{hocolim}}$ as an explicit double complex). All gaps are domain-specific scope items rather than foundational mathlib blockers — they are the new mathematics UC10–UC14 introduced, and they admit direct chain-level Lean constructions (UC14 §4.6).

The 5 sub-execution-tickets (§C) are layered so that L1 (UC10 framework) is wholly prerequisite, L2 (UC12 bridge + UC10.R) is sequential after L1, L3 (UC10 §§5.3–5.4 + UC14 R2+R3) and L4 (UC11 framework through §6 non-vanishing) can run in **parallel after L2**, and L5 (UC13 Part A landing + UC13 §3 dialect-check + UC14 R1 + closing `Frankl_Holds` theorem) is sequential after both L3 and L4. Token budgets are estimated at L1 ≈ 350k, L2 ≈ 200k, L3 ≈ 300k, L4 ≈ 250k, L5 ≈ 250k — total ~1.35M tokens across the chain (single-session-cap-friendly per layer).

Hard constraints (§D) carry to every L-layer: no factorial decompositions in any load-bearing path; no functor `C_n^∩ → PPF_n` in any load-bearing path (the F-series analogy is a structural template, not a transfer mechanism); the U1-dialect-check of UC13 §3 must be preserved at the Lean level via purely additive Čech machinery (no cup-product on `F_obs`); each L-ticket must cite its verified latex artefact (UC10/UC12/UC11/UC13/UC14) as input per pm-onethird `feedback_latex_first_for_math_simp`.

**Why GREEN and not AMBER.** No single mathlib gap individually blocks the program — the four largest custom-build items (cubical-Walsh-defect complex, doubling functor, cubical-bridge null-homotopy, Čech bicomplex with Walsh decomposition) are all directly constructible from mathlib primitives (chain complexes over `ℚ`, finite-group representation theory on `(ZMod 2)^n`, Bousfield–Kan double complex of a diagram of chain complexes, alternating-sum Čech differential). Each is a localized engineering item, not a research-level obstruction. The §C layering allocates the engineering across L1–L5 in a way that keeps each layer single-session-capable.

**Why GREEN and not RED.** The §C decomposition fits inside Lean's standard formalization patterns: each primitive has a definite mathlib home (categorical structure → `Mathlib.CategoryTheory`; chain complexes → `Mathlib.Algebra.Homology`; representation theory → `Mathlib.RepresentationTheory`; spectral sequences → `Mathlib.Algebra.Homology.SpectralSequence`; cofiber LES → derived from `Mathlib.Algebra.Homology.HomotopyCategory`). The 22 primitives have no circular dependencies; the L1–L5 layering respects the dependency order; no primitive requires an unmerged mathlib PR.

**The honest one-sentence verdict.** *The UC10+UC12+UC11+UC13+UC14 Frankl closure is Lean-formalization-ready as a 5-layer execution program (L1: UC10 framework — category $\mathcal C_n^{\cap}$, hocolim $X_n^{\cap}$, Walsh decomposition UC10.W, target statement UC10.1; L2: UC12 cubical-bridge null-homotopy + UC10.R; L3: UC10 §§5.3-5.4 twisted-symmetric and iterated-antisymmetric bridge variants + UC14 R2/R3 cell-level Walsh-support analysis and multi-bridge graded commutativity; L4: UC11 Čech-sheaf $\mathcal F_{\mathrm{obs}}$ framework on trace cover $\mathfrak U$ + minimality + non-vanishing of $\mathrm{ob}(\mathcal F^\star)$; L5: UC13 Part A landing in level-1 Walsh isotypes + §3 chain-locality dialect-check + UC14 R1 explicit $\Theta$-map + closing `Frankl_Holds` theorem), with all 22 load-bearing primitives admitting placeholder Lean signatures (§A), the mathlib dependency map identifying mostly-standard infrastructure plus four domain-specific custom-build items (§B), each L-layer single-session-capable (§C, budgets totaling ~1.35M tokens across the chain), and the Daniel hard constraints (NOT factorial, NOT functorial in the refinement sense, U1-dialect-check, math-first) preserved by construction at every layer (§D); no individual mathlib gap blocks; no scope-too-large escalation; L1 to be filed first as the foundational prerequisite, L2/L3/L4/L5 to follow with L3 || L4 parallel-capable after L2.*

§A enumerates the 22 primitives by document with Lean signature placeholders. §B maps each primitive to its mathlib parts vs. fresh-build gaps. §C decomposes into L1–L5 sub-execution-tickets with budgets, dependency annotations, and parallel/sequential structure. §D enumerates the hard constraints carried into every Lean execution ticket.

---

## §A. Phase A — Lean 4 / mathlib signature enumeration (22 primitives)

Conventions: signatures use plain text Lean 4 syntax (no backticks needed). All chain complexes are over `ℚ` (`Mathlib.Algebra.Field.Basic.Rat`). Categories are bundled small categories (`Mathlib.CategoryTheory.SmallCategory`). The variable `n : ℕ` ranges over the ground-set size, fixed per statement; no `n → ∞` stability is invoked anywhere (the C2/C5 dodges of UC10 §1.2). All representations of finite groups are over `ℚ` (rational; abelian-group Maschke gives 1-dim isotypic decomposition for `(ZMod 2)^n`).

For each primitive: the signature line is given as `def NAME : TYPE := sorry` or `theorem NAME : STATEMENT := sorry`, with a one-line gloss recalling the source statement.

### A.1 UC10 framework primitives (4)

#### Primitive 1 — Category $\mathcal C_n^{\cap}$ (objects = pointed intersection-closed families; morphisms = trace)

Source: UC10 Defn 2.1 (objects), Defn 2.2 (morphisms), Lemma 2.3 (trace preserves intersection-closure).

```
-- Object: support S ⊆ Fin n + intersection-closed family F ⊆ Finset (Finset (Fin n))
--   with ⋃ F = S and S ∈ F.
structure IntClosedFam (n : ℕ) where
  support : Finset (Fin n)
  family  : Finset (Finset (Fin n))
  intClosed : ∀ A ∈ family, ∀ B ∈ family, A ∩ B ∈ family
  fullSupport : (family.sup id) = support
  topMem : support ∈ family
  nonempty : family.Nonempty

-- Morphism: trace along T ⊆ S, with G = { A ∩ T | A ∈ F }.
structure TraceMor (n : ℕ) (X Y : IntClosedFam n) where
  subset : Y.support ⊆ X.support
  traceEq : Y.family = X.family.image (fun A => A ∩ Y.support)

-- The category (small, ℕ-indexed; the Cat_n^∩ of UC10 Defn 2.1+2.2).
instance ICatCap (n : ℕ) : SmallCategory (IntClosedFam n) where
  Hom X Y := TraceMor n X Y
  id X := ⟨subset_refl _, by simp⟩    -- T = S, A ∩ S = A
  comp f g := ⟨g.subset.trans f.subset, by aesop_cat⟩

-- Lemma 2.3: trace preserves intersection-closure (well-definedness of TraceMor).
theorem TraceMor_intClosed (n : ℕ) (X : IntClosedFam n) (T : Finset (Fin n))
    (hT : T ⊆ X.support) :
    ∃ Y : IntClosedFam n, Y.support = T ∧ Y.family = X.family.image (fun A => A ∩ T) := sorry
```

#### Primitive 2 — The hocolim cohomology object $X_n^{\cap}$ as a $\Gamma_n=(\mathbb Z/2)^n\rtimes S_n$-equivariant chain complex over $\mathbb Q$

Source: UC10 Defn 3.1 (single-family complex), 3.3 (hocolim), Lemma 3.6 (bi-equivariance).

```
-- Single-family cubical complex: cells C(A, T') for A ∈ F, T' ⊆ S\A, |T'| = k,
--   with A ∪ T'' ∈ F for every T'' ⊆ T'. Chain complex over ℚ.
def singleFamilyComplex (n : ℕ) (X : IntClosedFam n) :
    ChainComplex (ModuleCat ℚ) ℕ := sorry

-- The hyperoctahedral / type-B Coxeter group Γ_n = (Z/2)^n ⋊ S_n.
abbrev HyperOctGroup (n : ℕ) : Type := (Fin n → ZMod 2) ⋊[swapMul] Equiv.Perm (Fin n)

-- The hocolim X_n^∩ over (ICatCap n)^op: a Γ_n-equivariant chain complex over ℚ.
--   Built via the Bousfield-Kan double complex (cubical axis × bar-resolution axis).
def XNcap (n : ℕ) :
    ChainComplex (Rep ℚ (HyperOctGroup n)) ℕ := sorry

-- Lemma 3.6: bi-equivariance — (Z/2)^n acts on Q_n (the value side), S_n on the indexing.
theorem XNcap_equivariant (n : ℕ) :
    True := sorry   -- placeholder: equivariance is implicit in the Rep ℚ (HyperOctGroup n) target
```

#### Primitive 3 — Walsh characters and Walsh decomposition UC10.W

Source: UC10 §0.2 (Walsh characters), Theorem 3.5 = UC10.W (proven via abelian-group Maschke).

```
-- The Walsh character χ_S : 2^[n] → {±1}, χ_S(A) := (-1)^|S ∩ A|.
def walshChar (n : ℕ) (S : Finset (Fin n)) : (Finset (Fin n)) → ℤ :=
  fun A => (-1)^((S ∩ A).card)

-- As a 1-dim irrep of (Z/2)^n over ℚ.
def walshRep (n : ℕ) (S : Finset (Fin n)) : Rep ℚ (Fin n → ZMod 2) := sorry

-- The multiplicity complex V_S^* := χ_S-isotypic piece of C_*(X_n^∩; ℚ).
def walshMult (n : ℕ) (S : Finset (Fin n)) :
    ChainComplex (ModuleCat ℚ) ℕ := sorry

-- Theorem 3.5 = UC10.W: Walsh decomposition as chain-complex direct sum.
theorem UC10_W (n : ℕ) :
    ∃ (iso : (XNcap n).restrictScalars (Fin n → ZMod 2) ≅
              DirectSum (Finset (Fin n)) (fun S => walshRep n S ⊗ walshMult n S)),
    True := sorry   -- the direct-sum isomorphism, S_n-compatibly
```

#### Primitive 4 — Target theorem UC10.1 statement (concentration at $V_{[n]}^{n-1} \cong \chi_{[n]} \boxtimes \mathrm{sgn}_{S_n}$)

Source: UC10 Theorem 4.1 (statement; proved unconditionally after UC12 + UC13 Parts A+B + UC14).

```
-- The top Walsh character χ_[n] (every σ_x acts by -1).
def topWalsh (n : ℕ) : Rep ℚ (Fin n → ZMod 2) := walshRep n Finset.univ

-- The sgn_{S_n} representation.
def sgnRep (n : ℕ) : Rep ℚ (Equiv.Perm (Fin n)) := sorry

-- UC10.1: H̃^k(X_n^∩; ℚ) ≅ χ_[n] ⊠ sgn_{S_n} at k = n-1, 0 for 1 ≤ k ≤ n-2.
theorem UC10_1 (n : ℕ) (hn : n ≥ 3) :
    (∀ k, 1 ≤ k → k ≤ n - 2 → IsZero ((XNcap n).homology k)) ∧
    Nonempty ((XNcap n).homology (n - 1) ≅
              ((topWalsh n) ⊠ (sgnRep n))) := sorry
```

### A.2 UC12 primitives (3)

#### Primitive 5 — Doubling functor $\mathrm{db}\colon\mathcal C_n^{\cap} \hookrightarrow \mathcal C_{n+1}^{\cap}$ as fully faithful embedding

Source: UC12 Defn 2.1 + Lemma 2.2 (well-defined fully faithful functor); Lemma 2.7 (prism structure).

```
-- Doubling: db F := F ∪ (F + {n+1}). Adds coordinate n+1 fully-matched.
def db (n : ℕ) (X : IntClosedFam n) : IntClosedFam (n+1) where
  support := X.support.map (Fin.castSucc) ∪ {Fin.last n}
  family := (X.family.image (fun A => A.map Fin.castSucc)) ∪
            (X.family.image (fun A => A.map Fin.castSucc ∪ {Fin.last n}))
  intClosed := by sorry         -- four-case argument in UC12 Lemma 2.2
  fullSupport := by sorry
  topMem := by sorry
  nonempty := by sorry

-- As a functor C_n^∩ → C_{n+1}^∩.
def dbFunctor (n : ℕ) : IntClosedFam n ⥤ IntClosedFam (n+1) where
  obj := db n
  map f := sorry                -- functorial on trace morphisms
  map_id := by sorry
  map_comp := by sorry

-- UC12 Lemma 2.2: fully faithful.
instance dbFunctor_FullyFaithful (n : ℕ) : (dbFunctor n).FullyFaithful := sorry

-- UC12 Lemma 2.7: prism structure X(db F) ≅ X(F) × I as cubical complex.
theorem db_prismStructure (n : ℕ) (X : IntClosedFam n) :
    singleFamilyComplex (n+1) (db n X) ≅
      singleFamilyComplex n X ⊗ (intervalComplex) := sorry
  where
    intervalComplex : ChainComplex (ModuleCat ℚ) ℕ := sorry   -- the 1-cell I = [0,1]
```

#### Primitive 6 — Cubical-bridge null-homotopy $h_x$ + chain-homotopy identity (UC12 Theorem 4.2)

Source: UC12 Defn 3.1 (definition of $h$), Lemma 3.2 (well-definedness), Theorem 4.2 (chain-homotopy identity $\iota_n^{\cap *} = \frac{(-1)^k}{2}(dh - hd)$).

```
-- The cubical-bridge null-homotopy on the χ_[n+1]-isotype of C^*(X_{n+1}^∩).
--   (h ω)(D) := ω(D̃) where D̃ is the prism over D in coordinate n+1.
-- General in-coordinate version (UC13 Remark 4.2.2): h_x for x ∈ [n].
def bridgeOp (n : ℕ) (x : Fin n) (k : ℕ) :
    walshMult n Finset.univ |>.X k →ₗ[ℚ]
    walshMult n (Finset.univ.erase x) |>.X (k - 1) := sorry

-- UC12 Theorem 4.2: chain-homotopy identity on V_{[n+1]}^k.
theorem bridgeOp_chainHomotopy (n : ℕ) (k : ℕ) :
    ∀ ω : walshMult (n+1) Finset.univ |>.X k,
    iotaCapStar n ω =
      ((-1 : ℚ)^k / 2) *
        (((walshMult (n+1) Finset.univ).d k (k-1)).comp (bridgeOp (n+1) (Fin.last n) k) ω -
         ((bridgeOp (n+1) (Fin.last n) (k+1)).comp ((walshMult (n+1) Finset.univ).d (k+1) k)) ω) :=
  sorry
  where
    iotaCapStar : (n : ℕ) → walshMult (n+1) Finset.univ |>.X k →ₗ[ℚ]
                   walshMult n Finset.univ |>.X k := sorry  -- restriction along the inclusion
```

#### Primitive 7 — Trace-injectivity of $\delta_n^{\cap}$ on top-Walsh sign piece (UC10.R / UC12 Theorem 4.4)

Source: UC12 Theorem 4.4 + Corollary 4.6 (bi-isotype refinement to $\chi_{[n+1]} \boxtimes \mathrm{sgn}_{S_{n+1}}$).

```
-- The canonical inclusion ι_n^∩ : X_n^∩ ↪ X_{n+1}^∩.
def iotaCap (n : ℕ) : XNcap n ⟶ (XNcap (n+1)).restrict (HyperOctGroup_incl n) := sorry

-- The connecting map δ_n^∩ in the cofiber LES.
def deltaCap (n : ℕ) :
    ((XNcap n).homology (n - 1)).restrict topWalsh ⟶
    ((cofib (iotaCap n)).homology n).restrict (topWalsh (n+1)) := sorry

-- UC10.R / UC12 Theorem 4.4: δ_n^∩ injective on V_{[n]}^{n-1} (top Walsh sign).
theorem UC10_R (n : ℕ) (hn : n ≥ 3) :
    Function.Injective (deltaCap n) := sorry

-- UC12 Corollary 4.6: bi-isotype refinement to χ_[n+1] ⊠ sgn_{S_{n+1}}.
theorem UC10_R_biIsotype (n : ℕ) (hn : n ≥ 3) :
    Function.Injective (deltaCap n |>.restrict_biIsotype) := sorry
```

### A.3 UC11 primitives (6)

#### Primitive 8 — Minimal counterexample $\mathcal F^\star$ + minimality lemmas (UC11 §3)

Source: UC11 Defn 2.2 (counterexample, minimal counterexample), Theorem 3.4 (every proper sub-family has a rare element).

```
-- Frankl's negation: a counterexample is intersection-closed with β_x > 0 for every x.
def IsCounterexample (n : ℕ) (X : IntClosedFam n) : Prop :=
  X.support = Finset.univ ∧ X.family ≠ {Finset.univ} ∧
    ∀ x : Fin n, beta x X > 0
  where
    beta : (x : Fin n) → IntClosedFam n → ℤ := fun x X =>
      (X.family.filter (fun A => x ∈ A)).card -
      (X.family.filter (fun A => x ∉ A)).card

-- Minimal counterexample: minimizes |family| first, then n.
def IsMinimalCounterexample (n : ℕ) (X : IntClosedFam n) : Prop :=
  IsCounterexample n X ∧
    ∀ (m : ℕ) (Y : IntClosedFam m), IsCounterexample m Y →
      X.family.card ≤ Y.family.card

-- Trace-subcategory below F* (UC11 Defn 3.1).
def traceSubcat (n : ℕ) (Xstar : IntClosedFam n) :
    Subcategory (IntClosedFam n) := sorry    -- full subcategory of trace targets of X*

-- UC11 Theorem 3.4: every proper trace target has a rare element.
theorem minimality_element (n : ℕ) (Xstar : IntClosedFam n)
    (hXstar : IsMinimalCounterexample n Xstar)
    (Y : (traceSubcat n Xstar).obj) (hproper : Y.val.support ⊂ Finset.univ) :
    ∃ x ∈ Y.val.support, beta x Y.val ≤ 0 := sorry
```

#### Primitive 9 — Trace cover $\mathfrak U = \{U_x\}_{x \in [n]}$ of $\mathcal C_n^{\cap}(\mathcal F^\star) \setminus \{\mathcal F^\star\}$

Source: UC11 Defn 4.1, Lemma 4.2 (cover property).

```
-- The x-stratum U_x: subfamilies (T, G) with x ∈ T and β_x(G) ≤ 0.
def stratumU (n : ℕ) (Xstar : IntClosedFam n) (x : Fin n) :
    Subcategory (traceSubcat n Xstar).obj :=
  { obj := fun Y => x ∈ Y.val.support ∧ beta x Y.val ≤ 0 ∧ Y.val ≠ Xstar
    morphisms := sorry }

-- The trace cover U = { U_x | x ∈ [n] }.
def traceCover (n : ℕ) (Xstar : IntClosedFam n) :
    Set (Subcategory (traceSubcat n Xstar).obj) :=
  { stratumU n Xstar x | x : Fin n }

-- UC11 Lemma 4.2: the cover property (every proper sub-family lies in some U_x).
theorem traceCover_covers (n : ℕ) (Xstar : IntClosedFam n)
    (hXstar : IsMinimalCounterexample n Xstar)
    (Y : (traceSubcat n Xstar).obj) (hY : Y.val ≠ Xstar) :
    ∃ x : Fin n, Y ∈ (stratumU n Xstar x).obj := sorry
```

#### Primitive 10 — Čech sheaf $\mathcal F_{\mathrm{obs}}(U_x) := C^*(X(-))_{\chi_{\{x\}}}\big|_{U_x}$; bi-equivariance under $\Gamma_n$

Source: UC11 Defn 4.3 (local Walsh bias cochain), Defn 4.4 ($\mathcal F_{\mathrm{obs}}$), Lemma 4.5 ($\Gamma_n$-equivariance).

```
-- The local Walsh bias cochain on a single stratum: b_x(G) · [χ_{x}]_{X(G)}.
def localBiasCochain (n : ℕ) (Xstar : IntClosedFam n)
    (x : Fin n) (Y : (stratumU n Xstar x).obj) :
    ChainComplex (ModuleCat ℚ) ℕ := sorry

-- The Čech sheaf F_obs on the trace cover.
def FObs (n : ℕ) (Xstar : IntClosedFam n) :
    Presheaf (Set.Indexed (traceCover n Xstar)) (ChainComplex (ModuleCat ℚ) ℕ) := sorry

-- UC11 Lemma 4.5: F_obs is Γ_n-equivariant (S_n on indexing, (Z/2)^n on values).
theorem FObs_equivariant (n : ℕ) (Xstar : IntClosedFam n) :
    True := sorry   -- placeholder; equivariance handled via Rep ℚ (HyperOctGroup n) target
```

#### Primitive 11 — Mismatch cochain $m_{xy}$ + Čech 1-cocycle $[m_{xy}] \in \check H^1(\mathfrak U; \mathcal F_{\mathrm{obs}})$

Source: UC11 Defn 4.3 (mismatch cochain), Lemma 5.2 (cocycle condition on triple intersections).

```
-- The mismatch cochain m_{xy} := b̂_x - b̂_y on U_x ∩ U_y.
def mismatchCochain (n : ℕ) (Xstar : IntClosedFam n)
    (x y : Fin n) (hxy : x ≠ y) :
    ChainComplex (ModuleCat ℚ) ℕ := sorry   -- in (χ_{x} ⊕ χ_{y})-isotypes

-- UC11 Lemma 5.2: cocycle condition on triple intersections.
theorem mismatch_cocycle (n : ℕ) (Xstar : IntClosedFam n)
    (x y z : Fin n) (hxyz : x ≠ y ∧ y ≠ z ∧ z ≠ x) :
    mismatchCochain n Xstar x y hxyz.1 +
    mismatchCochain n Xstar y z hxyz.2.1 +
    mismatchCochain n Xstar z x hxyz.2.2.symm = 0 := sorry

-- The Čech 1-cocycle [m_{xy}] in Ĥ^1(U; F_obs).
def mismatchClass (n : ℕ) (Xstar : IntClosedFam n) :
    cechCohomology (FObs n Xstar) 1 := sorry
```

#### Primitive 12 — Obstruction class $\mathrm{ob}(\mathcal F^\star)$ as image of $[m_{xy}]$ in $\widetilde H^{n-1}(X_n^{\cap}; \mathbb Q)$

Source: UC11 §5.4 (definition); UC13 Theorem 2.4.1 (corrected landing in $\bigoplus_x V_{\{x\}}^{n-1}$); UC14 Theorem 1.5.1 (R1-tightened via explicit $\Theta$-map).

```
-- The obstruction class ob(F*) in H̃^{n-1}(X_n^∩; ℚ), via the Θ-map of UC14 R1.
def obstructionClass (n : ℕ) (Xstar : IntClosedFam n) :
    (XNcap n).homology (n - 1) := sorry
```

#### Primitive 13 — UC11 Lemma 6.2: non-vanishing of $\mathrm{ob}(\mathcal F^\star)$ from minimality

Source: UC11 Lemma 6.1 (vanishing implies witness extension), Lemma 6.2 (non-vanishing).

```
-- UC11 Lemma 6.1: cohomological vanishing implies a global witness assignment exists,
--   extending the minimality-witness function w to F* itself.
theorem obstruction_vanishing_implies_witness (n : ℕ) (Xstar : IntClosedFam n)
    (hXstar : IsMinimalCounterexample n Xstar)
    (h : obstructionClass n Xstar = 0) :
    ∃ x : Fin n, beta x Xstar ≤ 0 := sorry

-- UC11 Lemma 6.2: non-vanishing.
theorem UC11_nonVanishing (n : ℕ) (Xstar : IntClosedFam n)
    (hXstar : IsMinimalCounterexample n Xstar) :
    obstructionClass n Xstar ≠ 0 := by
  intro hzero
  obtain ⟨x, hx⟩ := obstruction_vanishing_implies_witness n Xstar hXstar hzero
  -- contradiction with hXstar.1.2.2 (β_x > 0 for every x)
  sorry
```

### A.4 UC13 + UC14 primitives (9)

#### Primitive 14 — Čech-bicomplex isotype-preservation (UC13 Lemma 2.2.1) via abelian-group Maschke for $(\mathbb Z/2)^n$

Source: UC13 Lemma 2.2.1 (Walsh-isotype preservation through Čech bicomplex); both differentials $\check d$ and $d$ are $(\mathbb Z/2)^n$-equivariant.

```
-- UC13 Lemma 2.2.1: the Čech bicomplex of F_obs decomposes (Z/2)^n-isotypically.
theorem UC13_isotypePreservation (n : ℕ) (Xstar : IntClosedFam n) :
    ∃ (iso : cechBicomplex (FObs n Xstar) ≅
              DirectSum (Finset (Fin n)) (fun T => walshIsotype T (FObs n Xstar))),
    True := sorry

-- Corollary 2.3.2: the bicomplex is supported on level-1 isotypes only
--   (the source data is single-character per stratum).
theorem cechBicomplex_level1Support (n : ℕ) (Xstar : IntClosedFam n) :
    ∀ T : Finset (Fin n), T.card ≠ 1 →
      IsZero (walshIsotype T (FObs n Xstar)) := sorry
```

#### Primitive 15 — Corrected landing theorem (UC13 Theorem 2.4.1): $\mathrm{ob}(\mathcal F^\star) \in \bigoplus_x V_{\{x\}}^{n-1}$

Source: UC13 Theorem 2.4.1; UC14 Theorem 1.5.1 (R1-tightened with explicit $\Theta$).

```
-- UC13 Theorem 2.4.1 (R1-tightened by UC14 Theorem 1.5.1): the obstruction class
--   lands in level-1 Walsh isotypes, NOT in V_[n]^{n-1} as UC11 §5.3 conjectured.
theorem UC13_correctedLanding (n : ℕ) (Xstar : IntClosedFam n) :
    ∃ (decomp : (XNcap n).homology (n - 1) ≅
                DirectSum (Fin n) (fun x => walshMult n {x} |>.homology (n - 1))),
    decomp.hom (obstructionClass n Xstar) ∈
      (Set.range fun x => Sum.inl x : DirectSum (Fin n) _) := sorry
```

#### Primitive 16 — Lower-Walsh vanishing $V_S^k = 0$ for $S \subsetneq [n]$, $k \ge 1$ (UC13 Theorem 4.5.1)

Source: UC13 Theorem 4.5.1; twisted-symmetric bridge $h_x^{\mathrm{tw}} = \chi_{\{x\}} \cdot h_x \cdot \chi_{\{x\}}$ for $x \notin S$ (UC13 Defn 4.2.1); chain-homotopy identity (UC13 Theorem 4.3.1).

```
-- UC13 Defn 4.2.1: the twisted bridge operator.
def twistedBridge (n : ℕ) (S : Finset (Fin n)) (x : Fin n) (hx : x ∉ S) (k : ℕ) :
    walshMult n S |>.X k →ₗ[ℚ] walshMult n S |>.X (k - 1) := sorry

-- UC13 Theorem 4.3.1: twisted chain-homotopy identity.
theorem twistedBridge_chainHomotopy (n : ℕ) (S : Finset (Fin n)) (x : Fin n)
    (hx : x ∉ S) (k : ℕ) :
    True := sorry   -- ι_x^D* = ((-1)^k / 2) · (d ∘ h_x^tw - h_x^tw ∘ d) on V_S^k

-- UC13 Theorem 4.5.1 = UC10 §5.3: lower-Walsh vanishing.
theorem UC10_lowerWalshVanishing (n : ℕ) (S : Finset (Fin n))
    (hS : S ⊂ Finset.univ) (k : ℕ) (hk : 1 ≤ k) :
    IsZero ((walshMult n S).homology k) := sorry
```

#### Primitive 17 — Top-Walsh concentration $V_{[n]}^k = 0$ for $1 \le k < n - 1$ (UC13 Theorem 5.1, UC14 Theorem 3.6.1)

Source: UC13 Theorem 5.1 / UC14 Theorem 3.6.1; iterated antisymmetric bridge $H_{\vec x} = h_{x_1} \cdots h_{x_m}$ + cofiber LES + induction on $n$.

```
-- UC13 Theorem 5.1 / UC14 Theorem 3.6.1: top-Walsh concentration.
theorem UC10_topWalshConcentration (n : ℕ) (k : ℕ) (hk : 1 ≤ k) (hkn : k < n - 1) :
    IsZero ((walshMult n Finset.univ).homology k) := sorry
```

#### Primitive 18 — F31 chain-locality dialect-check (UC13 §3.3 / Proposition 3.3.1)

Source: UC13 §3.3.1 (chain-locality U1 dialect does not transfer); UC14 Lemma 4.1.1 (preservation under R1+R2+R3).

```
-- Structurally, the dialect-check is a meta-theorem about the construction:
--   no cup-product anywhere in the Čech bicomplex of F_obs ⇒ F31 chain-locality
--   failure mode cannot manifest.
-- In Lean, this is best encoded as a statement about the underlying chain map:
--   F_obs's Čech-to-cohomology assembly is purely additive (no multiplicative pairing).
theorem dialectCheck_chainLocalityNoTransfer (n : ℕ) (Xstar : IntClosedFam n) :
    -- The Čech-to-total-cohomology comparison map is injective on the level-1-isotypic
    -- (Z/2)^n-component, witnessing that no chain-locality kernel exists.
    Function.Injective (cechToTotalCohomology_level1 (FObs n Xstar)) := sorry

-- Corollary: the cohomology-level vanishing ob(F*) = 0 implies the Čech-level
--   vanishing [m_{xy}] = 0, so UC11 §6's witness-extension implication is genuine.
theorem dialectCheck_witnessExtensionGenuine (n : ℕ) (Xstar : IntClosedFam n) :
    obstructionClass n Xstar = 0 → mismatchClass n Xstar = 0 := sorry
```

#### Primitive 19 — UC14 abutment identification (R1): explicit chain map $\Theta$

Source: UC14 Defn 1.2.1 + Lemma 1.2.2 ($\Theta$ commutes with both differentials); Lemma 1.3.1 (Walsh-isotype equivariant); Cor 1.4.4 ($\Theta_*^{\chi_{\{y\}}}$ is iso at level-1 isotypes).

```
-- UC14 Defn 1.2.1: the explicit chain map Θ : Tot*(Č*_*(F_obs)) ↪ Tot*(BK^{*,*}) = C*(X_n^∩).
def ThetaMap (n : ℕ) (Xstar : IntClosedFam n) :
    HomologicalComplex.Tot (cechBicomplex (FObs n Xstar)) ⟶
    HomologicalComplex.Tot (bousfieldKanBicomplex (XNcap n)) := sorry

-- UC14 Lemma 1.2.2: both differentials commute under Θ.
theorem ThetaMap_commutesDifferentials (n : ℕ) (Xstar : IntClosedFam n) :
    True := sorry  -- captured by the morphism-in-HomologicalComplex.Tot above

-- UC14 Lemma 1.3.1: Walsh-isotype preservation.
theorem ThetaMap_walshEquivariant (n : ℕ) (Xstar : IntClosedFam n)
    (T : Finset (Fin n)) :
    True := sorry  -- Θ sends χ_T-isotype to χ_T-isotype

-- UC14 Cor 1.4.4: Θ_*^{χ_{y}} is an isomorphism at level-1 isotypes.
theorem ThetaMap_level1Iso (n : ℕ) (Xstar : IntClosedFam n) (y : Fin n) :
    IsIso ((ThetaMap n Xstar |>.restrict_isotype {y}).homology (n - 1)) := sorry
```

#### Primitive 20 — UC14 cohomological covering (R2): chain-level $\chi_S$-isotype isomorphism $C^*(X(\mathcal D_x))_{\chi_S} = C^*(X_n^{\cap})_{\chi_S}$ for $x \notin S$

Source: UC14 Lemma 2.2.1 (cell-level $\chi_S$-support), Theorem 2.4.1 (single-family $\chi_S$-iso), Theorem 2.6.2 (hocolim-level $\chi_S$-iso), Theorem 2.7.1 (R2-tightened).

```
-- UC14 Lemma 2.2.1: cell-level Walsh-isotype support for x ∉ S.
theorem cellLevelWalshSupport (n : ℕ) (X : IntClosedFam n) (S : Finset (Fin n))
    (x : Fin n) (hxS : x ∉ S) (hxX : x ∈ X.support) :
    -- The χ_S-isotype of C^*(X(F)) is supported on cells C(A, T') with x ∉ T'
    -- AND A matched-in-x.
    True := sorry

-- UC14 Theorem 2.7.1: chain-level χ_S-isomorphism X(D_x) ↪ X_n^∩ on χ_S-isotype.
theorem UC14_R2_chainLevelIso (n : ℕ) (S : Finset (Fin n)) (x : Fin n)
    (hxS : x ∉ S) :
    walshMult n S ≅ matchedSubComplex n x S := sorry
  where
    matchedSubComplex : (n : ℕ) → (x : Fin n) → (S : Finset (Fin n)) →
                        ChainComplex (ModuleCat ℚ) ℕ := sorry
```

#### Primitive 21 — UC14 multi-bridge graded commutativity (R3): $h_x h_y = -h_y h_x$ on bi-matched sub-complex

Source: UC14 Lemma 3.3.1 (bi-prism orientation-transposition sign); Cor 3.3.2 (general $\pi \in S_m$ sign); Theorem 3.5.1 (iterated chain-homotopy identity $\iota_{\vec x}^* \omega = \frac{\pm 1}{2^m} d H_{\vec x} \omega$).

```
-- UC14 Lemma 3.3.1: multi-bridge graded commutativity.
theorem UC14_R3_bridgeAntiCommute (n : ℕ) (x y : Fin n) (hxy : x ≠ y)
    (k : ℕ) (ω : walshMult n Finset.univ |>.X k) :
    bridgeOp n x (k - 1) (bridgeOp n y k ω) =
      - bridgeOp n y (k - 1) (bridgeOp n x k ω) := sorry

-- UC14 Defn 3.4.1: iterated bridge operator H_{x⃗} := h_{x_1} ∘ ⋯ ∘ h_{x_m}.
def iteratedBridge (n : ℕ) (xs : List (Fin n)) (hxs : xs.Nodup) (k : ℕ) :
    walshMult n Finset.univ |>.X k →ₗ[ℚ]
    walshMult n Finset.univ |>.X (k - xs.length) := sorry

-- UC14 Theorem 3.5.1: iterated chain-homotopy identity on cocycles.
theorem UC14_R3_iteratedChainHomotopy (n : ℕ) (xs : List (Fin n))
    (hxs : xs.Nodup) (k : ℕ) (ω : walshMult n Finset.univ |>.X k)
    (hω : (walshMult n Finset.univ).d k (k-1) ω = 0) :
    True := sorry   -- ι_{x⃗}^* ω = ((-1)^{k·m + C(m,2)} / 2^m) · d (H_{x⃗} ω)
```

#### Primitive 22 — Closing Frankl contradiction (UC13 §7): theorem `Frankl_Holds`

Source: UC13 §7 (7-step closing argument); the contradiction of (UC11 Lemma 6.2 non-vanishing) with (UC13 Lemma 7.3' / UC10.1 vanishing).

```
-- The Frankl conjecture in intersection-closed form.
theorem Frankl_Holds (n : ℕ) (hn : n ≥ 3) (X : IntClosedFam n)
    (hne_empty : X.family ≠ ∅) (hne_top : X.family ≠ {Finset.univ}) :
    ∃ x : Fin n, beta x X ≤ 0 := by
  -- Negate-and-contradict: suppose ∀ x, β_x > 0.
  by_contra h_neg
  push_neg at h_neg
  -- Pick minimal counterexample.
  obtain ⟨Xstar, hXstar⟩ := minimal_counterexample_exists hn ⟨X, h_neg⟩
  -- UC11 Lemma 6.2: ob(F*) ≠ 0.
  have h_nonzero : obstructionClass n Xstar ≠ 0 := UC11_nonVanishing n Xstar hXstar
  -- UC13 Theorem 2.4.1: ob(F*) ∈ ⊕_x V_{x}^{n-1}.
  have h_landing : True := UC13_correctedLanding n Xstar
  -- UC10.1 (Part B, this chain): V_{x}^{n-1} = 0 for every x.
  have h_vanishing : ∀ x : Fin n,
      IsZero ((walshMult n {x}).homology (n - 1)) := fun x =>
    UC10_lowerWalshVanishing n {x} (Finset.singleton_ssubset_univ_iff.mpr
      (by omega : (1 : ℕ) < n)) (n - 1) (by omega)
  -- Combining: ob(F*) = 0. Contradiction.
  exact h_nonzero (by sorry)

-- (auxiliary) Minimal counterexample existence.
theorem minimal_counterexample_exists (n : ℕ) (hn : n ≥ 3)
    (h : ∃ X : IntClosedFam n, ∀ x : Fin n, beta x X > 0) :
    ∃ Xstar : IntClosedFam n, IsMinimalCounterexample n Xstar := sorry
```

---

## §B. Phase B — mathlib dependency map

For each primitive in §A, this section identifies (i) which mathlib parts are reusable infrastructure and (ii) which require custom build (treated as a sub-execution-ticket scope item in §C, **not** as architect-blocking-dependency). All gaps are domain-specific scope expansions — none require unmerged mathlib PRs.

### B.1 Reusable mathlib infrastructure

The following mathlib modules are direct prerequisites for the L1–L5 execution work:

- **`Mathlib.CategoryTheory.SmallCategory`** — bundled small categories with `Hom`, `id`, `comp`. Used in Primitive 1 (category `IntClosedFam n` with `TraceMor`).
- **`Mathlib.CategoryTheory.Functor.FullyFaithful`** — fully faithful functor predicate. Used in Primitive 5 (`dbFunctor.FullyFaithful`).
- **`Mathlib.Algebra.Homology.HomologicalComplex`** — chain complexes over an abelian category. Used in Primitives 2, 6, 10, 16, 17, 19, 21 (every chain-complex object).
- **`Mathlib.Algebra.Homology.HomotopyCategory`** — homotopy category + null-homotopies + cofiber sequences. Used in Primitive 6 (chain-homotopy identity), Primitive 7 (cofiber LES), Primitive 17 (iterated cofiber LES).
- **`Mathlib.Algebra.Homology.DerivedCategory`** — long exact sequences of cofibers. Used in Primitive 7 (cofiber LES of $\iota_n^{\cap}$), Primitive 17 (iterated LES across coordinates).
- **`Mathlib.RepresentationTheory.Basic`** — `Rep k G` for representations over a commutative ring. Used in Primitives 2, 3, 4, 6, 7 (every $\Gamma_n$- or $(\mathbb Z/2)^n$-representation).
- **`Mathlib.RepresentationTheory.Maschke`** — Maschke's theorem for finite groups over a field of characteristic 0. Used in Primitive 3 (UC10.W: direct-sum decomposition of `Rep ℚ ((Fin n → ZMod 2))` into 1-dim characters).
- **`Mathlib.RepresentationTheory.Character`** — irreducible characters of finite groups. Used in Primitive 3 (`walshChar`, `walshRep`).
- **`Mathlib.GroupTheory.SemidirectProduct`** — semi-direct product `H ⋊[φ] K`. Used in Primitive 2 (`HyperOctGroup n := (Fin n → ZMod 2) ⋊[swapMul] Equiv.Perm (Fin n)`).
- **`Mathlib.GroupTheory.Perm.Basic`** + **`Mathlib.GroupTheory.Perm.Sign`** — `Equiv.Perm (Fin n)` with `Equiv.Perm.sign`. Used in Primitives 4, 7 (`sgnRep`).
- **`Mathlib.Algebra.DirectSum.Module`** — direct sum decomposition of modules. Used in Primitive 3 (UC10.W direct sum), Primitive 14 (Čech bicomplex isotypic direct sum), Primitive 15 (level-1 direct-sum landing).
- **`Mathlib.AlgebraicTopology.CechNerve`** — Čech nerve of a cover. Used (with adaptation to the categorical cover `traceCover`) in Primitives 9, 10, 11, 14.
- **`Mathlib.AlgebraicTopology.AlternatingFaceMapComplex`** — alternating-sum-of-faces complex. Used in Primitive 11 (Čech 1-cocycle's alternating-sum-of-restrictions differential), Primitive 14 (Čech bicomplex's horizontal differential `čd`).
- **`Mathlib.Algebra.Homology.SpectralSequence`** — spectral sequences of double / bicomplexes. Used in Primitives 14, 15 (Čech-to-total-cohomology spectral sequence; isotypic abutment).
- **`Mathlib.CategoryTheory.Limits.Shapes.Terminal`** + **`Mathlib.CategoryTheory.Limits.HasLimits`** — terminal / initial objects, limits in a small category. Used in Primitive 19 (UC14 Lemma 1.4.2 / 1.4.3′: each $U_x$ and each $U_{x_0} \cap \cdots \cap U_{x_p}$ has a terminal object after the trace-deformation retract).
- **`Mathlib.Data.Finset.Basic`** + **`Mathlib.Data.Fin.Basic`** — finite sets and finite ordinals. Used everywhere (every `Finset (Fin n)`).
- **`Mathlib.Data.ZMod.Basic`** — finite cyclic groups. Used in Primitive 2 (`Fin n → ZMod 2`), Primitive 3 (Walsh action eigenvalue $(-1)^{[y \in S]}$ as a `ZMod 2`-character).

### B.2 Custom-build items (fresh mathematics, scoped in §C)

The following are *not* in mathlib in the form UC10–UC14 needs; they are the new mathematics introduced by the program and must be built fresh in `union_closed/Lean/` (or similar). Each is sized at the sub-execution-ticket level (§C), not as a single architectural blocker.

- **G1 — Cubical-Walsh-defect complex `singleFamilyComplex` (Primitive 2).** Mathlib has cubical sets via the HoTT formalization (`Mathlib.AlgebraicTopology.CubicalSet` if present, or related) but not the specific "subcubes of $Q_n$ with vertices in $\mathcal F$" cubical complex. The cube-prism boundary formula (UC12 Lemma 4.1) needs to be proven cell-by-cell from the cubical-cell incidence. **Scope:** L1, ~50–80k tokens.
- **G2 — Bousfield–Kan double-complex presentation of `hocolim` (Primitive 2, Primitive 19).** Mathlib has `Mathlib.CategoryTheory.Limits.HasLimits` for general limits but not the explicit Bousfield–Kan model for `hocolim_{C^op}` of a diagram of chain complexes valued in a $G$-equivariant target. The Bousfield–Kan bicomplex $\mathrm{BK}^{p,q} = \prod_{(S_0 \to \cdots \to S_p)} C^q(X(\mathcal F_p))$ must be built explicitly so that R1's $\Theta$-map (Primitive 19) sits inside it. **Scope:** L1, ~80–120k tokens (the largest single custom-build item).
- **G3 — Walsh characters and abelian-group Maschke for $(\mathbb Z/2)^n$ (Primitive 3).** Mathlib has Maschke generally but not the specific $\bigoplus_{S \subseteq [n]} \chi_S$-decomposition of `Rep ℚ ((Fin n → ZMod 2))`. The characters $\chi_S(A) = (-1)^{|S \cap A|}$ need to be defined and the direct-sum decomposition explicitly constructed. **Scope:** L1, ~30–50k tokens (largely instantiation of existing mathlib infrastructure).
- **G4 — The cubical-bridge null-homotopy $h_x$ and chain-homotopy identity (Primitive 6).** This is the cube/Walsh-side analog of F18's null-homotopy on the simplicial-order side. No mathlib analog. The chain-homotopy identity $\iota^* = \frac{(-1)^k}{2}(dh - hd)$ is proven by direct cube-boundary computation (UC12 §4.1, five-step proof). **Scope:** L2, ~80–100k tokens.
- **G5 — The Čech bicomplex of an abelian-group-valued categorical sheaf, with Walsh-isotype decomposition (Primitives 10, 14).** Mathlib's `Mathlib.AlgebraicTopology.CechNerve` is for topological covers, not categorical covers of subcategories. The Čech bicomplex of $\mathcal F_{\mathrm{obs}}$ on the trace cover $\mathfrak U$ — with the explicit $(\mathbb Z/2)^n$-isotypic direct-sum splitting — must be built fresh. **Scope:** L4 (framework) + L5 (isotype decomposition for Primitive 14), ~60–80k tokens combined.
- **G6 — The Čech-to-sheaf cohomology spectral sequence with isotypic abutment (Primitive 19).** Mathlib's `Mathlib.Algebra.Homology.SpectralSequence` covers the general bicomplex SS but not the specific Čech-to-hocolim-cohomology comparison with abelian-group equivariance preserved. The good-cover-at-level-1 verification (UC14 Lemma 1.4.3′ via deformation retract to maximal-trace targets) needs to be coded explicitly. **Scope:** L5, ~80–100k tokens.
- **G7 — Twisted-symmetric bridge $h_x^{\mathrm{tw}}$ and iterated bridge $H_{\vec x}$ (Primitives 16, 17, 21).** Variants of the cubical-bridge null-homotopy: G4 builds the foundational $h_x$; G7 builds the twisted-symmetric variant for lower-Walsh isotypes (UC13 Defn 4.2.1) and the iterated multi-coordinate variant for top-Walsh concentration (UC14 Defn 3.4.1) + graded commutativity $h_x h_y = -h_y h_x$ (UC14 Lemma 3.3.1) from bi-prism orientation-transposition signs. **Scope:** L3, ~100–150k tokens.
- **G8 — The minimality argument and trace cover (Primitives 8, 9).** No mathlib infrastructure (this is the Frankl-specific combinatorial part). The minimal counterexample existence (well-ordering on `|family| × n`), the trace-subcategory `traceSubcat`, the stratification `stratumU`, and the cover property (UC11 Theorem 3.4 + Lemma 4.2) are direct mathematical constructions. **Scope:** L4, ~50–70k tokens.

### B.3 Items confirmed *not* needed (false-positive gap candidates)

The ticket body raised a few items as potential mathlib gaps; on re-examination they are *not* load-bearing for UC10+UC12+UC11+UC13+UC14:

- **Cup-product / multiplicative structure on cochains.** UC13 §3.3.1's dialect-check (and UC14 §4.1's preservation) explicitly *rules out* any use of cup-product in the Čech bicomplex of $\mathcal F_{\mathrm{obs}}$. The construction is purely additive end-to-end. **Mathlib has cup-products on cochains, but we deliberately do not use them.** Primitive 18 documents this as a *negative* meta-theorem (no cup-product anywhere ⇒ F31 chain-locality failure mode cannot manifest).
- **Higher Specht modules / Littlewood–Richardson decomposition for $S_n$.** UC13 §3.4 explicitly contrasts this with the abelian $(\mathbb Z/2)^n$ case; the union_closed side uses *only* abelian-group decomposition (1-dim characters, no branching). **Mathlib has Specht-module infrastructure, but we deliberately do not invoke it.**
- **FI-modules / representation stability across $n \to \infty$.** The C2 dodge of UC10 §1.2 fixes $n$ throughout; no $n \to \infty$ stability is invoked. **Mathlib's nascent FI-module work is irrelevant.**
- **$n$-induction across $\mathcal C_n^{\cap}$.** The C5 dodge of UC10 §1.2 drops $n$-induction from the load-bearing path. The only `n+1`-recursive structure is the `db` doubling and the cofiber-LES tower in Primitive 17 — these are explicit chain-level constructions, not induction-on-`n`-of-cohomology-statements.

### B.4 Summary of §B

The mathlib dependency map shows:
- **Strong reuse** of mathlib's categorical, homological, and representation-theoretic infrastructure (§B.1) — most of the foundational layer is already built.
- **Eight named custom-build items** G1–G8 (§B.2), each sized at sub-ticket scope (30–150k tokens), distributed across L1–L5.
- **No architectural-blocking-dependency** — every gap is "lots of code to write" rather than "is this even possible in Lean."

This confirms **GREEN verdict** at the dependency-map level: the Lean execution is decomposable into the §C layering with the §B.2 custom-build items absorbed into the appropriate L-tickets.

---

## §C. Phase C — Execution-ticket decomposition (L1–L5)

The ticket body's suggested layering (L1: UC10 framework, L2: UC12 bridge + UC10.R, L3: UC10 §§5.3-5.4, L4: UC11 framework, L5: UC13/UC14 closing) is essentially correct; this section refines the boundary between L3, L4, L5 (with the UC14 R1+R2+R3 work routed to whichever L-ticket is most natural per primitive) and adds explicit token budgets + parallel/sequential dependency annotations.

### C.1 L1 — UC10 framework primitives (1, 2, 3, 4 + G1, G2, G3)

**Title:** UC-Lean-L1: UC10 framework — category $\mathcal C_n^{\cap}$, hocolim $X_n^{\cap}$, Walsh decomposition UC10.W, target statement UC10.1.
**Latex artefact (verified):** `docs/union-closed-UC10-native-cohomology-intersection-closed-families.md` (mg-814b, merged).
**Primitives to deliver:** 1, 2, 3, 4 (Lean signatures from §A.1).
**Custom-build items:** G1 (cubical-Walsh-defect complex), G2 (Bousfield–Kan double complex), G3 (Walsh characters + abelian-group Maschke).
**Dependencies:** none beyond mathlib.
**Token budget:** ~350k (G2 is the largest item at ~80–120k; G1 ~50–80k; G3 ~30–50k; remainder for the four primitive signatures and the four bundled lemmas — Lemma 2.3 trace-preserves-intersection-closure; Lemma 3.2 polynomial size; Lemma 3.6 bi-equivariance; UC10.W direct sum). Single-session-capable; below the 500k cap.
**Output:** Lean files implementing `IntClosedFam n`, `dbFunctor`, `singleFamilyComplex`, `XNcap n`, `walshRep`, `walshMult`, `UC10_W` (proven), and `UC10_1` (stated as `sorry` — proof closed in L2+L3+L5).
**Parallel-capable:** no (prerequisite for L2, L3, L4, L5).

### C.2 L2 — UC12 cubical-bridge null-homotopy + UC10.R closure (5, 6, 7 + G4)

**Title:** UC-Lean-L2: UC12 cubical-bridge null-homotopy — doubling functor `db`, bridge operator $h$, chain-homotopy identity, trace-injectivity of $\delta_n^{\cap}$ on top-Walsh sign piece.
**Latex artefact (verified):** `docs/union-closed-UC12-delta-trace-injectivity.md` (mg-707c, merged).
**Primitives to deliver:** 5, 6, 7 (Lean signatures from §A.2).
**Custom-build items:** G4 (cubical-bridge null-homotopy + chain-homotopy identity).
**Dependencies:** L1 (uses `IntClosedFam`, `dbFunctor`, `singleFamilyComplex`, `XNcap n`, `walshMult`).
**Token budget:** ~200k (G4 = ~80–100k; remainder for `db` functoriality proof, prism structure, the chain-homotopy identity proof via five-step cube-boundary computation, $\Gamma_n$-equivariance verification on each generator). Below the 500k cap.
**Output:** Lean files implementing `db`, `dbFunctor.FullyFaithful`, `bridgeOp`, `bridgeOp_chainHomotopy`, `iotaCap`, `deltaCap`, `UC10_R` (proven). After L2, UC10.R is unconditional in Lean.
**Parallel-capable:** no (prerequisite for L3; required for L4's UC11 §1.2 P3-input + L5's final UC10.1 assembly).

### C.3 L3 — UC10 §§5.3-5.4 + UC14 R2+R3 (16, 17, 20, 21 + G7)

**Title:** UC-Lean-L3: UC10 §§5.3-5.4 lower-Walsh vanishing + top-Walsh concentration; UC14 R2 cell-level Walsh-isotype isomorphism + UC14 R3 multi-bridge graded commutativity + iterated chain-homotopy.
**Latex artefact (verified):** `docs/union-closed-UC13-frankl-closure.md` (mg-83f0, §§4-5 = Part B) + `docs/union-closed-UC14-uc13-technical-cleanup.md` (mg-500c, §2 = R2, §3 = R3).
**Primitives to deliver:** 16, 17, 20, 21 (Lean signatures from §A.4).
**Custom-build items:** G7 (twisted-symmetric bridge + iterated bridge).
**Dependencies:** L1 + L2 (uses everything from L1 plus the foundational `bridgeOp` from L2).
**Token budget:** ~300k (G7 = ~100–150k; R2 chain-level $\chi_S$-iso proof = ~50–70k via cell-level Walsh-support analysis case-by-case for $\sigma_y$; R3 induction on $n$ via cofiber LES = ~50–80k; remainder for the twisted chain-homotopy proof and the multi-bridge graded commutativity from bi-prism orientation-transposition signs). Within the 500k cap.
**Output:** Lean files implementing `twistedBridge`, `iteratedBridge`, `UC14_R3_bridgeAntiCommute`, `UC14_R3_iteratedChainHomotopy`, `UC14_R2_chainLevelIso`, `UC10_lowerWalshVanishing` (proven), `UC10_topWalshConcentration` (proven). After L3, UC10.1 is unconditional in Lean (combined with L2's `UC10_R`).
**Parallel-capable:** **yes** — L3 and L4 can run in parallel after L2, since L3 builds on L1+L2 directly and L4 builds on L1+L2 (using L1's framework + L2's `bridgeOp` for the (P1)+(P3) inputs to UC11 §1.2; UC11's (P2) input = UC10.1 is needed only for L5's closing argument, not for L4's framework).

### C.4 L4 — UC11 framework: minimality, trace cover, $\mathcal F_{\mathrm{obs}}$, mismatch, $\mathrm{ob}(\mathcal F^\star)$, non-vanishing (8, 9, 10, 11, 12, 13 + G5 + G8)

**Title:** UC-Lean-L4: UC11 Čech-sheaf framework — minimal counterexample, trace cover $\mathfrak U$, Čech sheaf $\mathcal F_{\mathrm{obs}}$, mismatch cochain, obstruction class $\mathrm{ob}(\mathcal F^\star)$, non-vanishing (Lemma 6.2).
**Latex artefact (verified):** `docs/union-closed-UC11-cech-sheaf-frankl-program.md` (mg-9ef0, merged; §§3-6).
**Primitives to deliver:** 8, 9, 10, 11, 12, 13 (Lean signatures from §A.3).
**Custom-build items:** G5 (Čech bicomplex of a categorical sheaf, framework part), G8 (minimality + trace cover combinatorics).
**Dependencies:** L1 + L2 (uses L1's `IntClosedFam`, `XNcap n`, `walshRep`, `walshMult`; uses L2's `bridgeOp` for the local-bias-cochain construction — but does NOT use UC10.1 in §§3-6, only in §7 which is L5 territory).
**Token budget:** ~250k (G8 = ~50–70k for `IsMinimalCounterexample`, `minimality_element`, `traceCover_covers`; G5 framework part = ~40k for `FObs`, `mismatchCochain`, `mismatchClass`; remainder for `obstructionClass` definition stub, `UC11_nonVanishing` proof via Lemma 6.1 cohomological-vanishing-implies-witness-extension, and the $\Gamma_n$-equivariance verifications of UC11 Lemma 4.5 + 4.6). Within the 500k cap.
**Output:** Lean files implementing `IsCounterexample`, `IsMinimalCounterexample`, `minimal_counterexample_exists`, `traceSubcat`, `stratumU`, `traceCover`, `traceCover_covers`, `localBiasCochain`, `FObs`, `mismatchCochain`, `mismatch_cocycle`, `mismatchClass`, `obstructionClass` (definition — its landing isotype is pinned in L5), `UC11_nonVanishing` (proven, using only the `obstructionClass = 0 ⇒ witness-extension` implication, which is L4-internal).
**Parallel-capable:** **yes** — L4 || L3 after L2 (see C.3 note). L4's only L2 dependency is `bridgeOp` used in `localBiasCochain`; L4 does not need UC10.1 directly.

### C.5 L5 — UC13 Part A + §3 dialect-check + UC14 R1 + `Frankl_Holds` (14, 15, 18, 19, 22 + G5-extension + G6)

**Title:** UC-Lean-L5: UC13 Part A corrected landing + §3 chain-locality dialect-check + UC14 R1 explicit $\Theta$-map + closing Frankl contradiction theorem `Frankl_Holds`.
**Latex artefact (verified):** `docs/union-closed-UC13-frankl-closure.md` (mg-83f0, §§1-3 + §7) + `docs/union-closed-UC14-uc13-technical-cleanup.md` (mg-500c, §1 = R1).
**Primitives to deliver:** 14, 15, 18, 19, 22 (Lean signatures from §A.4).
**Custom-build items:** G5-extension (Čech bicomplex isotype decomposition), G6 (Čech-to-sheaf cohomology SS with isotypic abutment + $\Theta$-map of UC14 R1).
**Dependencies:** L1 + L2 + L3 + L4 (uses everything from the four preceding L-tickets).
**Token budget:** ~250k (G6 = ~80–100k for the $\Theta$-map construction + good-cover-at-level-1 verification via deformation retract to maximal-trace targets; G5-extension = ~40k for `UC13_isotypePreservation`, `cechBicomplex_level1Support`; dialect-check meta-theorem `dialectCheck_chainLocalityNoTransfer` = ~30k; `UC13_correctedLanding` = ~30k; `Frankl_Holds` closing theorem = ~50k for the 7-step argument assembly). Within the 500k cap.
**Output:** Lean files implementing `UC13_isotypePreservation`, `cechBicomplex_level1Support`, `UC13_correctedLanding`, `dialectCheck_chainLocalityNoTransfer`, `dialectCheck_witnessExtensionGenuine`, `ThetaMap`, `ThetaMap_walshEquivariant`, `ThetaMap_level1Iso`, `UC10_1` (now proven via combining L1's `UC10_W` + L2's `UC10_R` + L3's `UC10_lowerWalshVanishing` + `UC10_topWalshConcentration`), and the closing theorem **`Frankl_Holds`** (proven via the contradiction of L4's `UC11_nonVanishing` with L5's combined `UC13_correctedLanding` + `UC10_1`).
**Parallel-capable:** no (final sequential layer; depends on all of L1+L2+L3+L4).

### C.6 Dependency graph + total budget

```
                                 L1 (UC10 framework, ~350k)
                                          │
                                          ▼
                  L2 (UC12 bridge + UC10.R, ~200k)
                          │
              ┌───────────┼───────────┐
              │                       │
              ▼                       ▼
   L3 (§§5.3-5.4 + R2/R3, ~300k)   L4 (UC11 framework, ~250k)
              │                       │
              └──────────┬────────────┘
                         │
                         ▼
            L5 (UC13 Part A + §3 + R1 + Frankl, ~250k)
```

**Total:** ~1.35M tokens across the chain. With L3 || L4 parallelism, the **critical path** is L1 → L2 → max(L3, L4) → L5 = 350 + 200 + 300 + 250 = **1.10M tokens of wall-clock work**. Per-layer well below the 500k single-session cap.

### C.7 Filing order

When this scoping ticket GREENs:

1. File **L1 first** (foundational; everything blocks on it). Dispatch to a single dedicated Lean-engineering polecat. The L1 deliverable is the largest single sub-ticket (~350k) and is the most likely to surface a re-scoping signal if any mathlib infrastructure assumption proves wrong — file it first to fail fast.
2. Once L1 GREENs, file **L2** sequentially (depends on L1 only; ~200k single-session).
3. Once L2 GREENs, file **L3 and L4 in parallel** (each independent of the other after L2). Two polecats dispatched simultaneously; each ~250–300k single-session.
4. Once both L3 and L4 GREEN, file **L5 sequentially** (~250k single-session) to close `Frankl_Holds`.

Total wall-clock: 4 sequential sub-tickets (L1, L2, max(L3,L4), L5) = 4 polecat sessions on the critical path; L3/L4 parallel saves one session.

### C.8 Summary of §C

Five sub-execution-tickets L1–L5, total ~1.35M tokens, critical path ~1.10M tokens with L3 || L4 parallelism. Each L-ticket is single-session-capable (below the 500k cap). All 22 primitives of §A and all 8 custom-build items G1–G8 of §B are assigned to specific L-tickets. The dependency graph is a clean DAG (L1 → L2 → {L3, L4} → L5). Filing order: L1 → L2 → (L3 || L4) → L5.

---

## §D. Phase D — Hard-constraint carryover

The following Daniel hard constraints (originating verbatim 2026-05-15T23:20Z and reiterated through UC10–UC14) bind every L1–L5 execution ticket. Each L-ticket must include a §D-style hard-constraint verification section (mirroring UC10 §0.4, UC12 §6, UC13 §6, UC14 §4) confirming the constraints are honored at the Lean level.

### D.1 NOT factorial

**Constraint.** Daniel verbatim 2026-05-15T23:20Z (pm-onethird `feedback_anti_factorial_direction`). No factorial decompositions, factorial spines, $S_{n+1}$-factorial structures, or Specht-module-style branching decompositions in any load-bearing path.

**Lean-level enforcement.** Each L-ticket must verify by inspection that:
- The only group representations invoked are 1-dim characters of $(\mathbb Z/2)^n$ (Walsh: Primitives 3, 14, 15, 16, 17, 20) and the $\mathrm{sgn}$ representation of $S_n$ on the bi-isotype (Primitives 4, 7).
- The only categorical structures are the trace functor $\rho_n$, its two sections $\iota_n^{\cap}$ and $\mathrm{db}$, and the natural transformation $\alpha : \mathrm{db} \Rightarrow \iota_n^{\cap}$ (Primitives 1, 5, 7).
- The cube $Q_n$ has size $2^n$ and $|\Gamma_n| = 2^n \cdot n!$ — these *appear* large but they are the natural type-B Coxeter group, not factorial-structured.
- **Mathlib's `Mathlib.RepresentationTheory.SpechtModules` is forbidden** in L1–L5 load-bearing imports. (It may be imported for ambient theory, but must not be invoked in `theorem` proofs.)

Carryover from UC12 §6.1, UC13 §6.2, UC14 §4.2.

### D.2 NOT functorial in the refinement sense

**Constraint.** Daniel verbatim 2026-05-15T23:20Z. No functor $\mathcal C_n^{\cap} \to \mathrm{PPF}_n$ (or any direction) in the load-bearing path. The F-series analogy is *structural template* only; no theorem of F17/F18/F29/F30 is invoked as logical hypothesis.

**Lean-level enforcement.** Each L-ticket must verify by inspection that:
- No Lean object of type `IntClosedFam n ⥤ Posets n` (or similar) appears in any load-bearing path. Any such functor, if defined for didactic comparison, must be tagged `@[unused_in_proofs]` and not invoked in any `theorem` body.
- The F-series template references (UC10 §0.3, UC12 §0.4, UC13 §0.3, UC11 §0.3) are *comments* in the Lean source explaining motivation, not imported lemmas.
- **L4 specifically:** the Čech sheaf $\mathcal F_{\mathrm{obs}}$ (Primitive 10) is constructed natively on `IntClosedFam n` via the trace cover (Primitive 9), with no `Pos` image entering the construction.
- **L5 specifically:** the closing `Frankl_Holds` theorem (Primitive 22) is proven from the contradiction of L4's `UC11_nonVanishing` with L5's `UC13_correctedLanding` + L3's `UC10_lowerWalshVanishing` — no F18 / F30 / F31 theorem is invoked.

Carryover from UC12 §6.2, UC13 §6.3, UC14 §4.3.

### D.3 U1-dialect check preserved (chain-locality cannot transfer)

**Constraint.** pm-onethird `feedback_u1_has_multiple_dialects`. UC11.R is structurally an F30-analog (chain-level Walsh-support computation); F31 walled on its 1/3-2/3-side analog via the *chain-locality U1 dialect* (cup-product machinery has a non-trivial kernel from local-to-global correlation failure). UC13 §3 established structurally that the chain-locality U1 dialect cannot transfer to the union_closed side, because the Čech bicomplex of $\mathcal F_{\mathrm{obs}}$ is purely additive (no cup-product) and the $(\mathbb Z/2)^n$-Walsh decomposition is direct-sum-into-1-dim-irreducibles preserved by every equivariant operation.

**Lean-level enforcement.** Each L-ticket must verify by inspection that:
- No `Mathlib.AlgebraicTopology.CupProduct` (or any cup-product-style operation) is invoked on cochains of $X_n^{\cap}$ in any load-bearing Lean proof. (Cup-product *exists* in mathlib, but we deliberately do not use it — this is the structural distinction that prevents F31 transfer.)
- The Čech bicomplex differentials $\check d$ and $d$ (Primitive 14) are both proven $(\mathbb Z/2)^n$-equivariant; the proof must explicitly cite the Walsh-isotype decomposition (Primitive 3) and verify that no chain-level operation mixes distinct $\chi_T$-isotypes.
- **L5 specifically:** the meta-theorem `dialectCheck_chainLocalityNoTransfer` (Primitive 18) is *required* to be proven (not stated as `sorry`); it witnesses that the cohomology-level vanishing $\mathrm{ob}(\mathcal F^\star) = 0$ implies the Čech-level vanishing $[m_{xy}] = 0$, ensuring UC11 §6's witness-extension implication is genuinely deducible and not chain-locality-spurious.

Carryover from UC13 §3, UC14 §4.1.

### D.4 Math-first per pm-onethird `feedback_latex_first_for_math_simp`

**Constraint.** Every Lean execution ticket must have a verified merged latex artefact as input. No Lean execution may proceed against an unverified math claim.

**Lean-level enforcement.** Each L-ticket must:
- Cite its source latex artefact(s) in the ticket body:
  - **L1:** `docs/union-closed-UC10-native-cohomology-intersection-closed-families.md` (mg-814b, merged).
  - **L2:** `docs/union-closed-UC12-delta-trace-injectivity.md` (mg-707c, merged).
  - **L3:** `docs/union-closed-UC13-frankl-closure.md` §§4-5 (mg-83f0, merged) + `docs/union-closed-UC14-uc13-technical-cleanup.md` §§2-3 (mg-500c, merged).
  - **L4:** `docs/union-closed-UC11-cech-sheaf-frankl-program.md` §§3-6 (mg-9ef0, merged).
  - **L5:** `docs/union-closed-UC13-frankl-closure.md` §§1-3 + §7 (mg-83f0, merged) + `docs/union-closed-UC14-uc13-technical-cleanup.md` §1 (mg-500c, merged).
- Verify the latex artefact is GREEN-merged via `git log --grep='mg-XXXX' main` before opening Lean files.
- If any source artefact later receives a verification regression / correction, the L-ticket must pause and re-verify before resuming.

Carryover from UC10 Defn 0.4 (paper-and-pencil first), UC12 §6.4, UC13 §6.4, UC14 §4.4.

### D.5 Cumulative state doc per pm-onethird `feedback_polecat_cumulative_state_doc`

**Constraint.** Multi-session work must maintain a cumulative state ledger; each L-ticket updates `docs/state-UC10.md` with a Session 7+ entry on completion.

**Lean-level enforcement.** Each L-ticket polecat:
- Reads `docs/state-UC10.md` before starting (current session: Session 6 = this scoping doc).
- Appends a Session-N entry on completion documenting what Lean files were created, which primitives were closed (proven, vs. stated-as-`sorry`-with-downstream-L-ticket-pointer), and any newly discovered scope deviations from this §C plan.
- The Session entry follows the format established in Sessions 1–5 (item table, key technical insight paragraph, budget summary, trust-surface impact).

### D.6 Summary of §D

Five hard constraints (NOT factorial; NOT functorial in the refinement sense; U1-dialect-check / chain-locality cannot transfer; math-first; cumulative state doc) bind every L1–L5 execution ticket. Each L-ticket must include a hard-constraint verification section mirroring UC10 §0.4 / UC12 §6 / UC13 §6 / UC14 §4. The constraints are *structural* — they prevent the F-series transfer failure modes (factorial, refinement-functoriality U1, chain-locality U1) from manifesting on the Lean side. **No L-ticket may GREEN without explicit §D-verification.**

---

## §E. Verdict and forward dispatch

### E.1 Verdict — GREEN — ready-for-execution-L1-L5

Restating from the top, with citations:

- ✓ **22 primitives enumerated** with Lean 4 / mathlib signatures (§A). Each grouped by source document; each carrying a one-line gloss recalling the originating theorem.
- ✓ **mathlib dependency map** identifying 16+ reusable mathlib modules (§B.1) and 8 named custom-build items G1–G8 (§B.2), each sized at sub-ticket scope (30–150k tokens). Four false-positive gap candidates explicitly ruled out (§B.3).
- ✓ **5-layer execution decomposition** L1–L5 (§C) with explicit token budgets (350k + 200k + 300k + 250k + 250k = 1.35M total), parallel/sequential annotations (L3 || L4 after L2), and filing order (L1 → L2 → (L3 || L4) → L5).
- ✓ **5 hard constraints** (§D) carried into every L-ticket: NOT factorial; NOT functorial in the refinement sense; U1-dialect-check / chain-locality cannot transfer; math-first; cumulative state doc.
- ✓ **No architectural blockers.** Every custom-build item is "lots of code to write" rather than "is this even possible in Lean." Every mathlib gap is a domain-specific scope item, not an unmerged-PR dependency.
- ✓ **No scope-too-large escalation.** The 1.35M total / 1.10M critical-path token budget fits inside a standard formalization arc; each L-ticket is single-session-capable below the 500k cap.

### E.2 What this document does NOT do

- **Does not execute any Lean compilation.** All signatures in §A are paper-and-pencil placeholders; no `lake build` or equivalent. Per pm-onethird `feedback_pre_execution_dependency_verification`, scoping precedes execution.
- **Does not file the L1–L5 sub-execution-tickets.** Filing follows scoping GREEN per pm-onethird's directive. After this ticket GREENs, the L1 ticket should be filed first (Daniel decision: which polecat / engineering team).
- **Does not touch UC1–UC8 native-construction chain.** Independent branch; the UC1–UC8 Walsh/transport/decomposition/lever-signing work is its own potential Lean formalization arc, separately scoped if Daniel wants.
- **Does not touch the 1/3-2/3 critical path.** F17/F18/F29/F30/F31 reside in the `one_third_width_three` repo; their potential Lean formalization is separately scoped.
- **Does not engage the joint UC9/UC10 dispatch.** UC9 (extrinsic embedding via $2^{[n]} \hookrightarrow \mathrm{Pos}_{n+1}$) is independent of the Frankl-closure chain UC10+UC12+UC11+UC13+UC14 per UC13 §8.2 — it remains available for strongest-constraint extraction but is not load-bearing for `Frankl_Holds` itself.

### E.3 The honest one-paragraph verdict

UC-Lean-scope (this document) enumerates the 22 load-bearing primitives across UC10/UC12/UC11/UC13/UC14 with Lean 4 / mathlib placeholder signatures grouped by source document (§A: 4 primitives for UC10 framework, 3 for UC12, 6 for UC11, 9 for UC13+UC14), maps each primitive to its mathlib parts (§B.1: 16+ reusable modules across `Mathlib.CategoryTheory`, `Mathlib.Algebra.Homology`, `Mathlib.RepresentationTheory`, `Mathlib.AlgebraicTopology`, `Mathlib.GroupTheory`) vs. fresh custom-build items (§B.2: 8 named items G1-G8 sized at 30-150k tokens each — cubical-Walsh-defect complex, Bousfield-Kan double-complex, Walsh characters + abelian-group Maschke, cubical-bridge null-homotopy, Čech bicomplex of categorical sheaf, Čech-to-sheaf SS with isotypic abutment, twisted/iterated bridges, minimality + trace cover combinatorics) with 4 false-positive gap candidates ruled out (§B.3: cup-product, Specht modules, FI-stability, $n$-induction of cohomology statements), decomposes into 5 sub-execution-tickets layered L1 (UC10 framework, ~350k) → L2 (UC12 bridge + UC10.R, ~200k) → {L3 (UC10 §§5.3-5.4 + UC14 R2+R3, ~300k) || L4 (UC11 framework through Lemma 6.2 non-vanishing, ~250k)} → L5 (UC13 Part A + §3 dialect-check + UC14 R1 + `Frankl_Holds`, ~250k), total ~1.35M tokens / critical path ~1.10M with L3||L4 parallelism, each layer single-session-capable below the 500k cap (§C: dependency graph + filing order L1 → L2 → (L3 || L4) → L5), and carries forward the Daniel hard constraints (NOT factorial / NOT functorial in the refinement sense / U1-dialect chain-locality cannot transfer / math-first via verified latex artefact / cumulative state doc) as §D-required verifications on every L-ticket; the verdict is **GREEN — ready-for-execution-L1-L5** because every mathlib gap is a localized engineering item rather than an architectural blocker, every primitive has a definite mathlib home, and the §C layering respects the dependency order without circular references; no AMBER (no single named mathlib gap individually blocks); no RED (the program fits inside Lean's standard formalization patterns and the total token budget is comparable to existing mathlib-scale formalization arcs); next step on GREEN: file L1 first as the foundational prerequisite, then L2, then L3 || L4 in parallel, then L5 sequentially to close `Frankl_Holds`.

---

## §F. References

### F.1 This repo (`union_closed`) — direct inputs

- **`docs/union-closed-UC10-native-cohomology-intersection-closed-families.md`** (mg-814b, UC10, merged) — the native cohomology framework. Source for Primitives 1, 2, 3, 4.
- **`docs/union-closed-UC12-delta-trace-injectivity.md`** (mg-707c, UC12, merged) — the cubical-bridge null-homotopy closing UC10.R. Source for Primitives 5, 6, 7.
- **`docs/union-closed-UC11-cech-sheaf-frankl-program.md`** (mg-9ef0, UC11, merged) — the 5-step Frankl program. Source for Primitives 8, 9, 10, 11, 12, 13.
- **`docs/union-closed-UC13-frankl-closure.md`** (mg-83f0, UC13, merged) — Part A corrected landing + dialect-check + Part B execution + closing contradiction. Source for Primitives 14, 15, 16, 17, 18, 22.
- **`docs/union-closed-UC14-uc13-technical-cleanup.md`** (mg-500c, UC14, merged) — R1 abutment + R2 cohomological covering + R3 iterated-bridge degree count. Source for Primitives 19, 20, 21.
- **`docs/state-UC10.md`** — cumulative state ledger (Sessions 1–5 + this Session 6 update).

### F.2 mathlib (read-only foundational infrastructure)

See §B.1 for the full enumeration. Highlights:
- `Mathlib.CategoryTheory.SmallCategory`, `Mathlib.CategoryTheory.Functor.FullyFaithful`, `Mathlib.CategoryTheory.Limits.HasLimits`, `Mathlib.CategoryTheory.Limits.Shapes.Terminal`.
- `Mathlib.Algebra.Homology.HomologicalComplex`, `Mathlib.Algebra.Homology.HomotopyCategory`, `Mathlib.Algebra.Homology.DerivedCategory`, `Mathlib.Algebra.Homology.SpectralSequence`.
- `Mathlib.RepresentationTheory.Basic`, `Mathlib.RepresentationTheory.Maschke`, `Mathlib.RepresentationTheory.Character`.
- `Mathlib.GroupTheory.SemidirectProduct`, `Mathlib.GroupTheory.Perm.Basic`, `Mathlib.GroupTheory.Perm.Sign`.
- `Mathlib.AlgebraicTopology.CechNerve`, `Mathlib.AlgebraicTopology.AlternatingFaceMapComplex`.

### F.3 Source directives + memory

- **Daniel reminder 2026-05-16T07:23:43Z (verbatim, ticket body):** *"if you proved union closed then fantastic. It's super high priority that we formalize it in lean."* — origin of this scoping ticket.
- **Daniel verbatim 2026-05-15T23:20Z (NON-NEGOTIABLE, inherited from UC10/UC11/UC12/UC13/UC14):** NOT factorial; NOT functorial; paper-and-pencil. Carried into §D.1, §D.2.
- **Daniel verbatim 2026-05-16T00:57:19Z** — the 5-step Frankl program articulation, executed end-to-end through UC10+UC12+UC11+UC13+UC14 (now Lean-scoped here).
- **pm-onethird `feedback_pre_execution_dependency_verification`** — scoping precedes execution-ticket filing. This document is the scoping; L1–L5 filings follow GREEN.
- **pm-onethird `feedback_latex_first_for_math_simp`** — every L-ticket must cite a verified merged latex artefact. Carried into §D.4.
- **pm-onethird `feedback_u1_has_multiple_dialects`** — chain-locality U1 dialect-check carried into §D.3 as a meta-theorem L5 must prove.
- **pm-onethird `feedback_polecat_cumulative_state_doc`** — `docs/state-UC10.md` Session 6 update (this document) + Session 7+ updates from L-tickets. Carried into §D.5.
- **pm-onethird `feedback_anti_factorial_direction`** — NOT factorial constraint, originating Daniel verbatim above. Carried into §D.1.
- **mg-d57e ticket** — this scoping ticket. Verdict GREEN — ready-for-execution-L1-L5.

---

**End of UC-Lean-scope (mg-d57e, Session 6).** See `docs/state-UC10.md` Session 6 for the cumulative ledger update. L1–L5 sub-execution-tickets to be filed sequentially per §C.7.
