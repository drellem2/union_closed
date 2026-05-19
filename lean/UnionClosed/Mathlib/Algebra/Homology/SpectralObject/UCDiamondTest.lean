/-
Copyright (c) 2026 Union-Closed Polecat Authors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Union-Closed Polecat (cat-mg-f52c cascade-fork sub-ticket 1;
extended by cat-mg-d079 cascade-fork sub-ticket 2).

**STATUS (mg-d079, 2026-05-19): CASCADE-FORK SUB-TICKET 2 BICOMPLEX VIABILITY GATE.**

This file is the cumulative acceptance probe for the
`UnionClosed.Mathlib.Algebra.Homology.UCHomologicalComplex` cascade fork.

**Sub-ticket 1 (mg-f52c) probes:** verifies that after deletion of the
direct `HasZeroMorphisms (HomologicalComplex V c)` instance from the
fork's `UCHomologicalComplex.lean`, the residual TC path for
`HasZeroMorphisms (UCHomologicalComplex V c)` resolves *uniquely*
through `UCAdditive`'s `Preadditive (UCHomologicalComplex V c)`
composed with `CategoryTheory.Preadditive.preadditiveHasZeroMorphisms`.

**Sub-ticket 2 (mg-d079) probes:** verifies that the **bicomplex-level**
analogue holds for `UCHomologicalComplex₂ C c₁ c₂`. The critical probe
is bar 4 below — `Abelian.mono_cokernel_map_of_isPullback` at the UCHC₂
ambient, the exact use-site shape of the mathlib lemma which RED'd at
the Z2j-failed primitive (see `state-Frankl-mathlib-bypass-replay-Session1.md`
mg-7e53 §"diagnosis"). If bar 4 builds GREEN, the cascade-fork
conjecture — that two-level fork at UCHC + UCHC₂ uniquely routes through
the preadditive path and therefore admits the same `Mono`/`Epi` reasoning
mathlib admits at the abelian level — is empirically validated, and the
remaining sub-tickets 3–6 are tractable in their scoped form.

If bar 4 RED's, the cascade-fork conjecture is **REFUTED** and the
mayor must escalate to Daniel immediately per mg-d079 ticket §"After
GREEN" / §"Failure modes" instructions. Fallback paths: mg-8510 Option C
upstream PR or Option D cell-level Z2k workaround.

Do not delete or refactor without first reading:
* `docs/Frankl-cascade-fork-execution-plan.md` (cascade-fork scoping);
* `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/DiamondTest.lean`
  (sibling baseline mathlib-side probe with the Z2j-failed primitive
  preserved as commented-out reference);
* `lean/AXIOMS.md` + `lean/UnionClosed/PaperAxioms.lean` (the named
  axiom whose substantive replacement this cascade fork targets).
-/

import UnionClosed.Mathlib.Algebra.Homology.UCHomologicalComplex
import UnionClosed.Mathlib.Algebra.Homology.UCAdditive
import UnionClosed.Mathlib.Algebra.Homology.UCHomologicalComplexLimits
import UnionClosed.Mathlib.Algebra.Homology.UCHomologicalComplexAbelian
import UnionClosed.Mathlib.Algebra.Homology.UCHomologicalBicomplex
import Mathlib.CategoryTheory.Abelian.CommSq
import Mathlib.Algebra.Homology.ShortComplex.ShortExact

set_option maxHeartbeats 1600000
set_option synthInstance.maxHeartbeats 800000

namespace UnionClosed.UCDiamondTest

open CategoryTheory CategoryTheory.Limits

universe v u

/-! ## §1. Sub-ticket 1 probes (single-level UCHC). -/

/-- The fork's `UCHomologicalComplex` lives in the
`UnionClosed.Mathlib.Algebra.Homology` namespace. -/
example {V : Type u} [Category.{v} V] [HasZeroMorphisms V]
    {ι : Type*} (c : ComplexShape ι) :
    UCHomologicalComplex V c = UCHomologicalComplex V c := rfl

/-- The load-bearing fork acceptance test. The TC path for
`HasZeroMorphisms (UCHomologicalComplex V c)` is unambiguously
`preadditiveHasZeroMorphisms` — the deletion of the direct mathlib
`HasZeroMorphisms` instance at `UCHomologicalComplex.lean` (originally
line 285) leaves the preadditive route as the *only* survivor. -/
example {V : Type u} [Category.{v} V] [Preadditive V]
    {ι : Type*} {c : ComplexShape ι} :
    (inferInstance : HasZeroMorphisms (UCHomologicalComplex V c)) =
      CategoryTheory.Preadditive.preadditiveHasZeroMorphisms := rfl

/-- Single-level `HasZeroMorphisms`-driven probe: composing with the
zero morphism at `UCHC V c` ambient gives zero. This exercises the
unique `HasZeroMorphisms` TC path obtained above; if the diamond were
present, this would either fail TC search or land on a different (and
unequal) zero. -/
example {V : Type u} [Category.{v} V] [Preadditive V]
    {ι : Type*} {c : ComplexShape ι}
    (X Y Z : UCHomologicalComplex V c) (f : Y ⟶ Z) :
    (0 : X ⟶ Y) ≫ f = (0 : X ⟶ Z) := by
  simp

/-- Companion single-level probe: pre-composing with zero. -/
example {V : Type u} [Category.{v} V] [Preadditive V]
    {ι : Type*} {c : ComplexShape ι}
    (X Y Z : UCHomologicalComplex V c) (f : X ⟶ Y) :
    f ≫ (0 : Y ⟶ Z) = (0 : X ⟶ Z) := by
  simp

/-! ## §2. Sub-ticket 2 acceptance bar 2: `Abelian (UCHC V c)` resolves uniquely. -/

/-- After sub-ticket 2's `UCHomologicalComplexAbelian` landing, `UCHC V c`
becomes Abelian whenever `V` is. The `toPreadditive` projection of the
Abelian instance recovers the UC fork's `Preadditive` instance — confirmed
by `rfl` defeq. This is the single-level analogue of bar 3 below. -/
example {V : Type*} [Category* V] [Abelian V]
    {ι : Type*} {c : ComplexShape ι} :
    (inferInstance : Abelian (UCHomologicalComplex V c)).toPreadditive =
      (inferInstance : Preadditive (UCHomologicalComplex V c)) := rfl

/-! ## §3. Sub-ticket 2 acceptance bar 3: `Abelian (UCHC₂ V c₁ c₂)` resolves uniquely
(the two-layer diamond bypass). -/

/-- The **critical two-layer bypass test**. The TC chain for
`HasZeroMorphisms (UCHC₂ V c₁ c₂) = HasZeroMorphisms (UCHC (UCHC V c₂) c₁)`
routes via:
- `Preadditive V` ⇝ `Preadditive (UCHC V c₂)` (UCAdditive, outer layer)
- `Preadditive (UCHC V c₂)` ⇝ `Preadditive (UCHC (UCHC V c₂) c₁)` (UCAdditive,
  inner layer applied recursively)
- `Preadditive (UCHC₂ V c₁ c₂)` ⇝ `HasZeroMorphisms (UCHC₂ V c₁ c₂)` UNIQUELY via
  `preadditiveHasZeroMorphisms` (no competing direct instance at either layer).

The diamond bypass is mechanical: at no point in this chain does a
direct `HasZeroMorphisms` instance compete with the preadditive route,
because sub-ticket 1 deleted the direct instance from
`UCHomologicalComplex.lean`. -/
example {V : Type*} [Category* V] [Preadditive V]
    {I₁ I₂ : Type*} (c₁ : ComplexShape I₁) (c₂ : ComplexShape I₂) :
    (inferInstance : HasZeroMorphisms (UCHomologicalComplex₂ V c₁ c₂)) =
      CategoryTheory.Preadditive.preadditiveHasZeroMorphisms := rfl

/-- Bicomplex-level Abelian, sourced uniquely via two applications of
sub-ticket 2's `UCHomologicalComplexAbelian` instance. -/
example {V : Type*} [Category* V] [Abelian V]
    {I₁ I₂ : Type*} (c₁ : ComplexShape I₁) (c₂ : ComplexShape I₂) :
    (inferInstance : Abelian (UCHomologicalComplex₂ V c₁ c₂)).toPreadditive =
      (inferInstance : Preadditive (UCHomologicalComplex₂ V c₁ c₂)) := rfl

/-! ## §4. Sub-ticket 2 acceptance bar 4: **THE CASCADE-FORK VIABILITY GATE**.

This invokes `Abelian.mono_cokernel_map_of_isPullback` at the bicomplex
UCHC₂ ambient — the precise use-site shape of the mathlib lemma which
RED'd in the Z2j-failed primitive at the original mathlib bicomplex
ambient (see sibling `DiamondTest.lean` for the commented-out reference).

GREEN here ⇔ the cascade-fork bypasses the diamond as conjectured.
RED here ⇔ the cascade fork is REFUTED and escalation to Daniel is mandatory.

Adapted from the §3c proxy probe in `docs/Frankl-cascade-fork-execution-plan.md`,
the simpler proxy form not requiring `cutoffColumnsEInt_le` (which lands
in sub-ticket 4). -/

/-- Inlined copy of `Bicomplex.lean`'s private `isPullback_top_mono`
helper, used to produce the `IsPullback` data the Abelian lemma consumes. -/
private lemma isPullback_top_mono {D : Type*} [Category D] {X Y Z : D}
    (f : X ⟶ Y) (g : Y ⟶ Z) [Mono g] :
    IsPullback f (𝟙 X) g (f ≫ g) where
  w := by simp
  isLimit' := ⟨PullbackCone.IsLimit.mk (by simp)
    (fun s => s.snd)
    (fun s => by
      rw [← cancel_mono g, Category.assoc]
      exact s.condition.symm)
    (fun _ => Category.comp_id _)
    (fun _ _ _ hm₂ => by simpa using hm₂)⟩

/-- Baseline single-level UCHC probe — analogue of the GREEN single-level
mathlib-HC probe in `DiamondTest.lean`. This confirms that the cascade
fork's `UCHC` ambient supports `Abelian.mono_cokernel_map_of_isPullback`
at the same level as mathlib's `HC` ambient (sanity check for the fork
operation itself, not yet the diamond bypass at depth-2). -/
noncomputable example
    {D : Type*} [Category D] [Abelian D] [HasZeroObject D]
    {ι : Type*} {c : ComplexShape ι}
    (X Y Z : UCHomologicalComplex D c)
    (f : X ⟶ Y) (g : Y ⟶ Z) [Mono g] :
    Mono (cokernel.map f (f ≫ g) (𝟙 _) g (by simp)) := by
  exact Abelian.mono_cokernel_map_of_isPullback (isPullback_top_mono _ _)

/-- Extra diagnostic test: synthesizes `HasCokernel f` at two-level
UCHC₂ ambient — this DOES build, confirming the issue is not `Abelian → HasCokernels`. -/
example
    {C : Type*} [Category C] [Preadditive C] [HasZeroObject C] [Abelian C]
    {I₁ I₂ : Type*} {c₁ : ComplexShape I₁} {c₂ : ComplexShape I₂}
    (K L : UCHomologicalComplex (UCHomologicalComplex C c₂) c₁)
    (f : K ⟶ L) :
    HasColimit (parallelPair f 0) := inferInstance

/-- Diagnostic: cokernel object type at two-level UCHC₂ — DOES build. -/
noncomputable example
    {C : Type*} [Category C] [Preadditive C] [HasZeroObject C] [Abelian C]
    {I₁ I₂ : Type*} {c₁ : ComplexShape I₁} {c₂ : ComplexShape I₂}
    (K L : UCHomologicalComplex (UCHomologicalComplex C c₂) c₁)
    (f : K ⟶ L) :
    UCHomologicalComplex (UCHomologicalComplex C c₂) c₁ :=
  cokernel f

/-- Diagnostic: type of `cokernel.map` at two-level UCHC₂ — test whether
type elaboration itself completes. If this builds, the whnf is in the
`exact Abelian.mono_cokernel_map_of_isPullback ...` unification step,
not in the goal-type elaboration. -/
noncomputable example
    {C : Type*} [Category C] [Preadditive C] [HasZeroObject C] [Abelian C]
    {I₁ I₂ : Type*} {c₁ : ComplexShape I₁} {c₂ : ComplexShape I₂}
    (K L M : UCHomologicalComplex (UCHomologicalComplex C c₂) c₁)
    (f : K ⟶ L) (g : L ⟶ M) :
    cokernel f ⟶ cokernel (f ≫ g) :=
  cokernel.map f (f ≫ g) (𝟙 _) g (by simp)

/-! ### THE CASCADE-FORK VIABILITY GATE (mg-d079).

The bicomplex-level proxy probes prescribed in
`docs/Frankl-cascade-fork-execution-plan.md` §3c invoke
`Abelian.mono_cokernel_map_of_isPullback` at the UCHC₂ ambient
`UCHomologicalComplex (UCHomologicalComplex C c₂) c₁`.

**Empirical finding (mg-d079, RED on cascade-fork viability gate
bar 4).** Even after sub-ticket 1's diamond-bypass at single-level
UCHC (which the `(inferInstance : HasZeroMorphisms (UCHC V c)) =
preadditiveHasZeroMorphisms := rfl` probe above confirms is clean),
the **two-level** `UCHomologicalComplex (UCHomologicalComplex C c₂) c₁`
ambient still times out at `whnf` with maxHeartbeats 1.6M /
synthInstance.maxHeartbeats 800k, both with and without
`set_option backward.isDefEq.respectTransparency false`, both with
`(by simp)` and with the explicit `IsPullback.w` proof term. The
single-level analogue (`X Y Z : UCHomologicalComplex D c`) at the same
probe shape builds GREEN (the "Baseline single-level UCHC probe" above),
confirming that the cascade fork DID succeed at single level — but the
bicomplex nesting hits a deeper computational obstruction.

**Crucially, the issue is NOT TC synthesis.** The two-layer probes
above directly verify:
1. `(inferInstance : HasZeroMorphisms (UCHC₂ V c₁ c₂)) = preadditiveHasZeroMorphisms`
   resolves UNIQUELY via the preadditive route (the diamond bypass works
   structurally).
2. `(inferInstance : Abelian (UCHC₂ V c₁ c₂)).toPreadditive = inferInstance` —
   `Abelian.toPreadditive` and `UCAdditive`'s `Preadditive` instance
   coincide (no competing Preadditive structure).
3. `HasColimit (parallelPair f 0)` synthesizes at UCHC₂ (`inferInstance`
   works for HasCokernel).
4. `cokernel.map f (f ≫ g) (𝟙 _) g (by simp)` constructs at UCHC₂.

The whnf timeout occurs specifically when **unifying the conclusion of
`Abelian.mono_cokernel_map_of_isPullback`** against the goal. The lemma
is `Mono (cokernel.map _ _ _ _ sq.w)` — Lean must match the implicit
arguments via the `IsPullback` data and verify proof equality between
`sq.w` and `(by simp)` / `(isPullback_top_mono f g).w`. At two-level
UCHC₂, this unification step exhausts heartbeats independently of
heart-beat ceiling and transparency options.

**The Z2j-failed primitive shape, preserved as commented-out reference
below.** Per mg-d079 ticket §"After GREEN" / §"Failure modes" #1
("Bicomplex Abelian still has diamond at UCHC₂ — STRUCTURAL FAILURE
of cascade fork — escalate immediately"), this finding triggers the
cascade-fork viability gate RED verdict. The mayor must mail Daniel
immediately. Fallback paths per `docs/Z-arc-architecture-audit.md`:
mg-8510 Option C (upstream mathlib PR) or Option D (cell-level Z2k
workaround); paper-axiom `case3_ss_obstruction_paper_axiom` remains
in place via mg-1b2b disclosure-pivot.

**Strict improvement over mg-7e53.** mg-7e53 identified "the diamond
is at olean term reference" but conflated single-level and two-level.
mg-d079 confirms that:
* Single-level diamond IS bypassed by the cascade fork.
* Two-level computational obstruction PERSISTS — but it is NOT the
  diamond per se, it is unification depth at the bicomplex Abelian
  elaboration boundary.

Mathlib v4.29.1 elaboration limits are the binding constraint, NOT
the diamond. The fork's removal of the direct HZM instance is necessary
but not sufficient — the two-level Abelian elaboration depth alone
exhausts heartbeats independently of the diamond. This is a sharper
diagnosis than mg-7e53 provided and shapes the fallback path:
mg-8510 Option D (cell-level Z2k workaround) is more likely tractable
than Option C (upstream PR) since the issue is not a missing
instance/lemma but an elaboration-depth boundary that local cell-level
unfolding can sidestep. -/

/-
-- Z2j-failed primitive shape — preserved as commented-out reference
-- (mg-d079 RED verdict; uncomment to reproduce the whnf timeout):
--
-- set_option backward.isDefEq.respectTransparency false in
-- theorem viability_gate_generic
--     {C : Type*} [Category C] [Preadditive C] [HasZeroObject C] [Abelian C]
--     {I₁ I₂ : Type*} {c₁ : ComplexShape I₁} {c₂ : ComplexShape I₂}
--     {K L M : UCHomologicalComplex (UCHomologicalComplex C c₂) c₁}
--     (f : K ⟶ L) (g : L ⟶ M) [Mono g] :
--     Mono (cokernel.map f (f ≫ g) (𝟙 _) g (by simp)) :=
--   Abelian.mono_cokernel_map_of_isPullback (isPullback_top_mono _ _)
--
-- Failure mode at 1.6M heartbeats / 800k synthInstance heartbeats:
--   error: (deterministic) timeout at `whnf`, maximum number of
--   heartbeats (1600000) has been reached
-- The timeout is at type elaboration of the conclusion (line 0 of the
-- theorem), not in the body — synthesizing `HasColimit (parallelPair f 0)`
-- via `Abelian (UCHC₂) → HasCokernels (UCHC₂)` exhausts heartbeats at
-- the two-level unfolding depth.
-/

/-- Probe: at UCHC₂ ambient, `cokernel.map` itself synthesizes without
whnf timeout — i.e. `HasCokernel` is reachable from `Abelian (UCHC₂ ...)`
without exhausting heartbeats. -/
noncomputable example
    {C : Type*} [Category C] [Preadditive C] [HasZeroObject C] [Abelian C]
    {I₁ I₂ : Type*} {c₁ : ComplexShape I₁} {c₂ : ComplexShape I₂}
    (K L M : UCHomologicalComplex (UCHomologicalComplex C c₂) c₁)
    (f : K ⟶ L) (g : L ⟶ M) :
    cokernel f ⟶ cokernel (f ≫ g) :=
  cokernel.map f (f ≫ g) (𝟙 _) g (by simp)

/-! ## §5. Sub-ticket 2 acceptance bar 5: `shortExact_of_degreewise_shortExact`
at UCHC₂ ambient via two-level dispatch. -/

/-- The cell-level reduction lemma `shortExact_of_degreewise_shortExact`
applied at UCHC₂ ambient reduces a bicomplex short-exact-sequence claim
to checking it at every column. Because UCHC₂ = UCHC (UCHC C c₂) c₁, the
lemma applies to the outer layer, reducing to ShortExact in the inner
UCHC C c₂; one further application of the same lemma at the inner layer
would reduce to cell-level claims (this composite invocation is exercised
in actual use in Z2a-Z2j; here we test only the outer-layer dispatch is
type-correct). -/
example
    {C : Type*} [Category* C] [Abelian C]
    {I₁ I₂ : Type*} {c₁ : ComplexShape I₁} {c₂ : ComplexShape I₂}
    (S : ShortComplex (UCHomologicalComplex₂ C c₁ c₂))
    (hS : ∀ (i : I₁), (S.map (UCHomologicalComplex.eval _ _ i)).ShortExact) :
    S.ShortExact :=
  UCHomologicalComplex.shortExact_of_degreewise_shortExact S hS

end UnionClosed.UCDiamondTest
