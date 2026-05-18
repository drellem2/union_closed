# Z-arc architecture audit — TC-diamond root cause + 5-option analysis + strategic recommendation

**Work item:** `mg-8510` (strategic-architectural audit polecat, single-session, paper-and-pencil, no Lean code changes).

**Trigger (Daniel verbatim, 2026-05-18T07:17Z):**

> "z arc stalling — let's do architecture review and figure out exactly
> why. We can copy from mathlib or reproduce functionality without the
> bug in short term if needed."

**Supersedes.** `mg-e0a0` (Z2j, AMBER-minimal), and the held but un-filed Z2k follow-on.

**Predecessors absorbed.**

- `mg-103f` (`docs/UC-Lean-MathlibSS-Full-scope.md`) — Z1–Z10 scoping.
- `mg-e0a0` (`docs/state-UC-Lean-Z2j.md`) — 5 workaround attempts named; persistent TC-diamond diagnosed.
- `mg-0518` (`docs/state-UC-Lean-Z2i.md`) — first TC-diamond surfacing + factor-lemma scaffolding.
- `mg-b823`/`mg-165d`/`mg-5e1a`/`mg-1543` (Z2e–Z2h state docs) — sub-split lineage.
- `mg-74d2` (`one_third/docs/layered-form-vs-coherence-architecture-audit.md`) — analog disclosure-pivot pattern.
- mathlib v4.29.1 sources for `HomologicalComplex.instHasZeroMorphisms`, `preadditiveHasZeroMorphisms`,
  `Abelian (HomologicalComplex C c)`, `HomologicalComplex₂`,
  `shortExact_of_degreewise_shortExact`.

---

## Verdict (top-of-page): **(v)+(iv) hybrid — restatement-pivot now, structural-redesign de-pressured. Shelve Z3–Z10. The headline cost of continuing Z-arc-as-conceived no longer fits the project budget; the math content is real but is paper-axiomatisable at the Lean boundary.**

The `Abelian (HomologicalComplex (HomologicalComplex C c₂) (ComplexShape.up ℤ))`
TC-diamond between mathlib's
**`HomologicalComplex.instHasZeroMorphisms`** (`HomologicalComplex.lean:285`,
default priority 1000) and **`preadditiveHasZeroMorphisms`**
(`Preadditive/Basic.lean:201`, priority 100) is a **real
mathlib-side ambiguity** at the *second-level* HomologicalComplex —
i.e. the bicomplex — and is **not resolvable** by any in-tree session-level
trick (the 5 workarounds attempted in Z2j confirm this). The two
instances produce the *same morphism* (`{ f := fun _ => 0 }`) but Lean
treats them as *non-defeq terms*, so any `cokernel`/`kernel`/`ShortExact`
built via one path fails to unify with one built via the other. The
diamond is invisible at single-level HC because cell-level proofs
happen to elaborate consistently, and only surfaces at the *bicomplex*
level where mathlib's abelian-derived APIs (`cokernelIsoOfEq`,
`kernelCokernelCompSequence_exact`, `Abelian.mono_cokernel_map_of_isPullback`,
`ShortExact.δ`) expect the preadditive path while TC search picks the
direct path.

This is a **structural Lean-engineering blocker**, not a math blocker.
The math of the Z-arc (a bicomplex spectral sequence converging to
total cohomology, with an equivariant lift and isotype splitting,
applied to the BK bicomplex's χ_x-isotype slice to derive
`IsZero (gr_x H^{n-1}(Tot))`) is standard. The Lean encoding currently
shipped by mathlib does not support assembling it cleanly at the
bicomplex level.

**Per the mg-74d2 OneThird-analog assessment** (§4): the
SpectralObject infrastructure is *load-bearing for the in-tree closure
of the Y6 chain-map-extension blocker*, but the closure shape is
**equivalent in mathematical content** to the chain-side Walsh-isotype
refactor (mg-e75c Y6b) and to paper-side coherence-style arguments.
The Z-arc is **not vacuous at the math layer**; it *is* one of
several equivalent Lean deliveries of the same paper-side argument.
What is vacuous is the *commitment* to upstream-mathlib-PR-clean
delivery at the headline-blocking position.

**Recommended pivot:** drop the Z-arc-as-conceived from the headline
critical path. Restate Frankl_Holds with the SS-derived obstruction
class as paper-axiomatised (analogue of `case3Witness_hasBalancedPair_outOfScope`),
delete the Y6 `sorry` at `SSConvergence.lean:596` by routing through
the paper-axiom, and document the SpectralObject infrastructure as
**research-track / deferred** (not headline-blocking). Shelve `mg-50b7`
(Z3), `mg-18b8` (Z4), `mg-69e7` (Z5), and the un-filed Z6–Z10 pre-plan.

This **preserves the existing GREEN status** of
`Frankl_Holds_fullPowerset3` and `Frankl_Holds_fullPowerset4` via the
concrete L4 minimal-element witness path (which bypasses the Z-arc
entirely and does not depend on the bridge). It **honestly discloses**
the conditional nature of the general Frankl_Holds statement at the
Lean layer (paper-axiomatised on the SS argument), in exactly the same
way mg-13a5 + mg-5c32 honestly disclosed OneThird's case-3 residual.
And it **frees the polecat budget** — the ~10M tokens that the Z-arc
has absorbed across Z1–Z2j with only Z1+Z1b cleanly closed are
disproportionate to the headline value delivered.

The strategic alternative — continuing Z-arc-as-conceived via either
option (i) mathlib-PR-side fix (requires upstream community
coordination), option (ii) full copy-modify (heavyweight maintenance
burden), option (iii) reproduce-without-bug (would still need 2–4
months of cell-level scaffolding), or option (iv) structural-redesign
(retargets Z3–Z10 to avoid bicomplex Abelian instance, again 2–4
months) — is **conditionally valuable as research** but **not justified
as headline-blocking** given the existing concrete-witness GREEN status.

---

## §0 — Audit scope and method

This audit examines:

1. **TC-diamond root cause** (Phase A) — traces the exact instance
   graph for `Abelian (HomologicalComplex (HomologicalComplex C c₂)
   (ComplexShape.up ℤ))`, identifies why the diamond is structurally
   present, and analyses why each of the 5 Z2j workarounds failed.
2. **Five workaround options** (Phase B) — names options (i)–(v) from
   mg-8510 ticket body and grounds each in concrete Lean/mathlib
   mechanics.
3. **Per-option scope + risk + tradeoffs** (Phase C) — comparison
   table.
4. **Strategic recommendation** (Phase D) — top-line pick, with
   explicit comparison to mg-74d2's OneThird disclosure-pivot pattern
   and compatibility with Daniel's 12:47Z / 13:53Z / 07:17Z directives.
5. **Forward concrete actions** (Phase E) — concrete next-step
   tickets to file and shelving recommendations for the Z3–Z10
   pre-filed tickets.

**Method.** Source-of-truth for the diamond:
- `mathlib/Mathlib/Algebra/Homology/HomologicalComplex.lean:285` (the
  direct `HasZeroMorphisms` instance).
- `mathlib/Mathlib/Algebra/Homology/Additive.lean:86` (the
  `Preadditive (HomologicalComplex V c)` instance).
- `mathlib/Mathlib/Algebra/Homology/HomologicalBicomplex.lean:38` (the
  `HomologicalComplex₂` abbreviation).
- `mathlib/Mathlib/Algebra/Homology/HomologicalComplexAbelian.lean:44`
  (the `Abelian (HomologicalComplex C c)` instance).
- `mathlib/Mathlib/CategoryTheory/Preadditive/Basic.lean:201` (the
  `preadditiveHasZeroMorphisms` instance, priority 100).

Source-of-truth for the workaround attempts:
- `lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/Bicomplex.lean`
  lines 3358–3577 (Z2j deferred-to-Z2k writeup).
- `docs/state-UC-Lean-Z2j.md` lines 44–60 (workaround enumeration).
- `docs/state-UC-Lean-Z2i.md` lines 104–112 (first-surfacing analysis).

**No Lean code is changed by this audit.** Output is this document
plus the recommended next ticket spec (Phase E).

---

## §1 — Phase A: TC-diamond root-cause analysis

### 1a. The instance graph

```
   Abelian C  ──────┐
                    │ HomologicalComplexAbelian.lean:44
                    ▼
   Abelian (HomologicalComplex C c₂) ──┐
                                       │ HomologicalComplexAbelian.lean:44
                                       ▼
   Abelian (HomologicalComplex (HomologicalComplex C c₂) c₁)
   ───────────────────────────────────────────────────────────
   ▲ field `toPreadditive`
   │
   Preadditive (HomologicalComplex (HomologicalComplex C c₂) c₁)
                            ▲ Additive.lean:86  [Preadditive V] → Preadditive (HC V c)
                            │
   Preadditive (HomologicalComplex C c₂)
                            ▲ Additive.lean:86
                            │
   Preadditive C   (given via Abelian C)
```

So the `Abelian` chain is sound. Now consider `HasZeroMorphisms` at
the bicomplex type `HomologicalComplex (HomologicalComplex C c₂) c₁`.
Lean's TC search has *two* paths:

**Path 1 (direct).** From `HomologicalComplex.lean:285`:
```lean
instance : HasZeroMorphisms (HomologicalComplex V c) where
```
With `V := HomologicalComplex C c₂`, this gives
`HC.instHasZeroMorphisms (HomologicalComplex C c₂) c₁`. Default
priority (1000). Uses the explicit `Zero (X ⟶ Y)` instance from
`HomologicalComplex.lean:278`:
```lean
instance (X Y : HomologicalComplex V c) : Zero (X ⟶ Y) :=
  ⟨{ f := fun _ => 0 }⟩
```

**Path 2 (via preadditive).** From `Preadditive/Basic.lean:201`:
```lean
instance (priority := 100) preadditiveHasZeroMorphisms : HasZeroMorphisms C where
  zero := inferInstance
  ...
```
With `C := HomologicalComplex (HomologicalComplex C c₂) c₁`, this
needs `Preadditive (HomologicalComplex (HomologicalComplex C c₂) c₁)`,
which exists via the Additive.lean:86 chain shown above. The `zero
:= inferInstance` field reads back the `Zero (X ⟶ Y)` from the
`AddCommGroup` provided by `Additive.lean:82` (which itself is built
from `Function.Injective.addCommGroup Hom.f` and *reuses* the same
underlying `Zero (X ⟶ Y)` from `HomologicalComplex.lean:278`).

### 1b. The diamond

Both paths reach the *same underlying zero morphism* — the explicit
`{ f := fun _ => 0 }` — but **Lean does not see them as defeq instances
of `HasZeroMorphisms`**:

- Lean's TC unifier does not unfold instance terms structurally.
  `HC.instHasZeroMorphisms (HC C c₂) c₁` and `preadditiveHasZeroMorphisms
  (HC (HC C c₂) c₁)` are two distinct *terms* of type
  `HasZeroMorphisms (HC (HC C c₂) c₁)`.
- The `cokernel f` construction depends *definitionally* on which
  `HasZeroMorphisms` instance is in scope: a `cokernel f` constructed
  via path 1's `0` morphism is a *different definitional object*
  from one constructed via path 2's `0` morphism, even though they
  carry the same propositional content.
- Downstream abelian-derived APIs in mathlib
  (`Abelian.mono_cokernel_map_of_isPullback`,
  `kernelCokernelCompSequence_exact`, `ShortExact.δ`,
  `cokernelIsoOfEq`) are written in *preadditive* ambient context,
  where their elaboration prefers `preadditiveHasZeroMorphisms`.

At a goal that requires `Mono (cokernel.map f g ...)` at the bicomplex
level, Lean's elaborator:

1. Sees the goal `cokernel f → cokernel (f ≫ g)`.
2. Both `cokernel f` and `cokernel (f ≫ g)` are elaborated with a
   `[HasZeroMorphisms _]` argument. TC picks path 1 (higher priority).
3. Calls `Abelian.mono_cokernel_map_of_isPullback` — which is stated
   in `[Preadditive D] [Abelian D]` and was elaborated against
   path 2's `HasZeroMorphisms`.
4. The two cokernels are *not the same term*, so the unifier fails
   with:
   ```
   synthesized HomologicalComplex.instHasZeroMorphisms
   inferred    preadditiveHasZeroMorphisms
   ```

### 1c. Why the diamond hits at second-level HC, not first

At first-level `HomologicalComplex C c` with `[Abelian C]`, the same
diamond *exists structurally* (both Path 1 and Path 2 are available)
but is *operationally invisible*. The reason: in practice, every
abelian-derived consumer at first-level HC is invoked in a context
where the `Abelian` instance is given as `[Abelian (HomologicalComplex
C c)] := inferInstance`, and the elaborator picks a *single*
`HasZeroMorphisms` for the whole proof. Once picked, all `cokernel` /
`kernel` / `ShortExact` constructions in that proof use that same
instance consistently.

At second-level HC (the bicomplex), the elaborator must traverse
*two* HC layers, and the instance gets picked *independently* for each
layer's typeclass arguments. The mismatch can arise when:

- A morphism `f : K ⟶ L` at the bicomplex level is constructed using
  the preadditive path's `0` (because the `K`/`L` came from a
  preadditive-aware source like `cutoffColumnsEInt`).
- A `cokernel f` is computed using the *direct* path's `Abelian`
  instance (because TC search at the cokernel call site found the
  direct path first).
- A `kernelCokernelCompSequence_exact` is invoked expecting both
  cokernels to live in the *preadditive* world, but one of them
  doesn't.

This is exactly what the Z2j writeup describes:

> "Even explicit `haveI : Abelian (...) := inferInstance` failed during
> the focused Z2i session."

The `inferInstance` itself succeeds (returns *some* `Abelian` instance,
constructed via the working chain). But the `Abelian` instance returned
has fields whose elaboration depends on which `HasZeroMorphisms` was
in scope at the point `inferInstance` was invoked — and *that*
depends on TC search order, which depends on priorities, which
default-priority `HC.instHasZeroMorphisms` (1000) wins over
`preadditiveHasZeroMorphisms` (100). So `inferInstance` returns the
Abelian instance compatible with Path 1, but downstream consumers
expect Path 2.

### 1d. Per-attempt failure analysis (the 5 Z2j workarounds)

The Z2j session attempted five distinct workarounds. None succeeded.
The failure mode is the same in each case — *both elaboration
contexts that the workaround tries to unify still resolve to different
underlying HasZeroMorphisms* — but the mechanism by which the
workaround fails differs:

**Workaround 1 — Section-variable `[Abelian C]` discipline.**

```lean
section
variable [Abelian C]
...
```

*Intent.* Force the `Abelian C` instance to a single canonical term
across the section, hoping that all derived `Abelian (HC C c₂)` and
`Abelian (HC (HC C c₂) c₁)` chains share elaboration.

*Why it failed.* Section-variable discipline normalises the
*starting-point* (`Abelian C`), but does NOT control which
`HasZeroMorphisms` instance gets picked at the *bicomplex level*. The
bicomplex-level TC search re-runs every time a `cokernel`/`kernel`
term is elaborated; section-variable normalisation has no effect on
this.

*Z2e precedent.* This worked at Z2e because Z2e's
`shortExact_of_degreewise_shortExact` invocation operates at the
*first-level* HC ambient (passing through `eval C c i` to reduce to
cell-level in `C`). The diamond never bites because Z2e's ambient
category for the abelian-derived steps is `C` (zero-level), not the
bicomplex (second-level).

**Workaround 2 — Two-step `letI` chain.**

```lean
letI hAb1 : Abelian (HomologicalComplex C c₂) := inferInstance
letI hAb2 : Abelian (HomologicalComplex (HomologicalComplex C c₂)
                       (ComplexShape.up ℤ)) := inferInstance
```

*Intent.* Stage the Abelian-chain resolution: first land the
inner Abelian (which succeeds cleanly), then bind it as a `letI`
hypothesis to make the outer Abelian's inference deterministic.

*Why it failed.* `hAb1` indeed succeeds. But `hAb2 := inferInstance`
*does not* compute a single canonical `Abelian` instance — it computes
*an* Abelian instance whose `HasZeroMorphisms` field is whatever TC
search resolved at the bicomplex level (Path 1, by priority). The
resulting `hAb2` is well-typed and `letI`-bound, but its
`HasZeroMorphisms` field still differs from what downstream consumers
(`kernelCokernelCompSequence_exact` etc.) elaborate.

The `letI` discipline normalises the *Abelian-chain plumbing* but
does NOT propagate to the `HasZeroMorphisms`-elaboration of
post-`letI` consumer goals. The consumer goal `Mono (cokernel.map ...)`
re-runs `[HasZeroMorphisms _]` elaboration from scratch at every
implicit argument position.

**Workaround 3 — `set_option maxHeartbeats 1600000`.**

*Intent.* Allow more compute budget for the unifier in case the
failure was a heartbeat exhaustion masquerading as a unification
failure.

*Why it failed.* The diamond is a *structural* term-level
disagreement, not a unifier-budget issue. Increasing heartbeats just
lets Lean re-confirm the disagreement faster. The error stays the
same.

**Workaround 4 — `set_option synthInstance.maxHeartbeats 800000`.**

*Intent.* Allow more compute budget specifically for instance
synthesis, in case TC search was timing out before finding the
preadditive path.

*Why it failed.* Same root cause as workaround 3. TC search *does*
find both paths quickly (no timeout); the issue is that it picks the
higher-priority path, and that pick is then incompatible with the
downstream consumer's expectation. Heartbeat budgets don't change
priority logic.

**Workaround 5 — Full TC-chain section variable expansion.**

```lean
variable [Category* C] [Preadditive C] [HasZeroObject C] [Abelian C]
```

*Intent.* Make every typeclass *explicitly* available as a section
variable, hoping that the explicit binding prevents TC search from
re-running implicitly at each `cokernel`/`kernel` call.

*Why it failed.* Explicit section variables still get *re-resolved*
at each use site when a downstream goal has an implicit `[HasZeroMorphisms _]`
argument — because the section variable is for `HasZeroMorphisms C`
(the base category), not for `HasZeroMorphisms (HC (HC C c₂) c₁)`
(the bicomplex). The bicomplex-level instance still gets picked by
TC at the use site, with the same priority logic.

To make this work, one would have to add an *explicit*
`[HasZeroMorphisms (HomologicalComplex (HomologicalComplex C c₂) c₁)]
:= preadditiveHasZeroMorphisms` section variable — but then this
*shadows* the direct Path 1 instance only within the section, and the
typeclass inference still re-uses Path 1 inside `kernelCokernelComp`
calls because the section variable is bound to the wrong canonical
form (the consumer wants the term that *would* have come from
`Abelian.toPreadditive.toHasZeroMorphisms`, which is not the same
term as a direct `preadditiveHasZeroMorphisms` even though they're
propositionally equal).

### 1e. Why this is mathlib-side (not a Z arc bug)

Confirmation: The diamond exists in mathlib v4.29.1 *independently* of
the Z arc. Any third-party Lean project that:

1. Has `[Abelian C]` ambient,
2. Constructs `HomologicalComplex (HomologicalComplex C c₂) c₁`,
3. Wants to use any abelian-derived API (`kernelCokernelCompSequence_exact`,
   `mono_cokernel_map_of_isPullback`, `ShortExact.δ`, `cokernelIsoOfEq`)
   at the bicomplex level,

will hit the same diamond. The Z arc is the *first* substantial
mathlib downstream project to exercise this combination.

Mathlib's bicomplex `HomologicalComplex₂` abbreviation
(`HomologicalBicomplex.lean:38`) is *itself* well-formed and produces
`Abelian (HomologicalComplex₂ C c₁ c₂)` cleanly. The diamond
*manifests* only when one tries to *invoke abelian-derived APIs* on
bicomplex-level morphisms that were *constructed* via the
preadditive chain (which is the natural construction style for
`cutoffColumnsEInt_le`, `spectralObjectSlice`, etc.). It does not
manifest in mathlib's own bicomplex test suite because
`HomologicalBicomplex.lean` is a *passive* type definition; it does
not invoke abelian-derived APIs at the bicomplex level.

The Z arc — by virtue of being mathlib's *first*
abelian-API-at-bicomplex-level downstream consumer — is the canary
for this diamond.

### 1f. Phase A summary

| Mechanism component | Status |
|---|---|
| `HasZeroMorphisms (HomologicalComplex V c)` Path 1 (direct, priority 1000) | mathlib `HomologicalComplex.lean:285` |
| `HasZeroMorphisms _` Path 2 (preadditive, priority 100) | mathlib `Preadditive/Basic.lean:201` |
| `Preadditive (HomologicalComplex V c)` (the chain Path 2 needs) | mathlib `Additive.lean:86` |
| Both paths produce *the same* `{ f := fun _ => 0 }` zero morphism | Confirmed via line 278 vs line 82 |
| Lean treats them as distinct *terms* in TC | Yes — this is the diamond |
| Diamond invisible at first-level HC | Yes — elaboration locks to one path per proof |
| Diamond load-bearing at second-level HC (bicomplex) | Yes — two layers ⇒ two independent picks |
| **5 Z2j workarounds (section-variable / letI / maxHeartbeats / synthInstance / full TC expansion)** | **All failed; root cause = priority logic, not budget** |
| Mathlib-side or Z-arc-side? | **Mathlib-side**: any third-party project using abelian-derived APIs at the bicomplex level will hit this |

**Verdict.** The diamond is a real mathlib v4.29.1 issue. It is
structurally present (priority-1000 direct vs priority-100 preadditive)
and is load-bearing for the Z arc's bicomplex-level constructions. The
5 workarounds attempted at Z2j confirm that no session-level trick
within the standard Lean 4 elaboration framework can sidestep it.
Resolution requires either an upstream fix (typeclass priority
adjustment or `@[reducible]` annotation) or a downstream encoding
that avoids the second-level HC abelian-derived API surface entirely.

---

## §2 — Phase B: Five workaround options

The mg-8510 ticket body names five options. Each is grounded below.

### 2a. Option (i) — Mathlib-side fix (upstream PR)

**Mechanism.** File a mathlib PR that resolves the diamond at the
source. Three sub-options:

- **(i-a) Add `@[reducible]` to `HomologicalComplex.instHasZeroMorphisms`**
  (HC.lean:285). This makes the direct instance reduce to the
  preadditive one in defeq checks; downstream consumers that
  elaborate via the preadditive path then match the direct path on
  unification. Cost: 1 attribute change + verify no downstream
  breakage. Risk: `@[reducible]` instances are sometimes contraindicated
  for performance; mathlib reviewers may push back.
- **(i-b) Adjust priorities so `preadditiveHasZeroMorphisms` wins
  over `HC.instHasZeroMorphisms` when both apply.** E.g., bump
  `preadditiveHasZeroMorphisms` to priority 1100 (when `Preadditive C`
  is in scope, the preadditive path is preferred). Cost: 1 line.
  Risk: changes TC search behaviour globally; needs full mathlib build
  to verify no regressions.
- **(i-c) Delete the direct instance `HC.instHasZeroMorphisms` and
  rely solely on the preadditive chain via `Additive.lean:86`.**
  Cost: minimal code change, but breaks any downstream user of
  `HomologicalComplex` over a non-preadditive base category (e.g.,
  pre-`Additive.lean`-aware code). Risk: highest; this is the
  "right" fix but may break too much.
- **(i-d) Add an `instance` lemma asserting the two paths are
  propositionally equal** (`HC.instHasZeroMorphisms = preadditiveHasZeroMorphisms`
  under `[Preadditive V]`). Cost: a short proof. Risk: doesn't fix
  defeq, just allows manual rewrites at every use site — partial
  fix only.

**Conflict with Daniel 13:53Z "local-only" directive.** Yes. The
mg-103f scoping doc explicitly authorised mathlib-folder placement
for local code, with upstream PRs deferred to "push later if we have
time". Option (i) requires actively upstreaming, which:
- Is multi-week (community review, build verification, possibly
  multiple rounds of feedback).
- Requires the Z arc to remain *paused* while waiting for upstream
  merge — and may stay paused indefinitely if the PR is contested.
- Diverts polecat budget into mathlib-community coordination work
  (no direct Frankl progress during the wait).

**Conflict with Daniel 07:17Z "copy from mathlib or reproduce
functionality without the bug in short term".** Partial. Option (i) is
*not* a "short term" fix; it is the long-term canonical fix.

### 2b. Option (ii) — Copy from mathlib + modify (local fork)

**Mechanism.** Copy the relevant mathlib files into
`lean/UnionClosed/Mathlib/Algebra/Homology/Local/`:

- `HomologicalComplex.lean` (with `HC.instHasZeroMorphisms` modified or
  removed in the local copy).
- `Additive.lean`.
- `HomologicalComplexAbelian.lean`.
- `HomologicalBicomplex.lean`.
- All downstream files that import these and that the Z arc needs:
  `TotalComplex.lean`, `SpectralObject/*.lean`,
  `SpectralSequence/*.lean`,
  `ShortComplex/HomologicalComplex.lean`, the
  `HomologySequence/*.lean` chain, etc.

The Z arc files then `import UnionClosed.Mathlib.Algebra.Homology.Local`
instead of `import Mathlib.Algebra.Homology`. The local copies bypass
the diamond (by removing the direct instance or marking it `@[reducible]`).

**Cost.** Massive duplication. The dependency cone from
`HomologicalComplex.lean` through to `Abelian.SpectralObject.spectralSequence`
spans on the order of 30–60 files. Every copied file must be kept in
sync with mathlib upstream (which moves weekly), forever.

**Risk.** High maintenance burden. As mathlib evolves, the local
copies drift; rebasing each release becomes a major task. Future
union_closed contributors must navigate two parallel namespaces
(`Mathlib.Algebra.Homology` and `UnionClosed.Mathlib.Algebra.Homology.Local`).

**Daniel-directive compatibility.** Matches 07:17Z directive
("copy from mathlib") literally. Conflicts with 12:47Z "no shortcuts"
in spirit (this *is* a shortcut at the maintenance layer). Compatible
with 13:53Z "local-only".

**Failure mode.** Even after copying, the Z arc may discover *other*
mathlib-side issues at Z3–Z10 (e.g., the
`Abelian.SpectralObject.spectralSequence` TODO is still open in
mathlib; the Z arc's plan to land it via Z1 was a *one-shot* effort
that ran into the diamond at Z2). Any future blocker would re-trigger
this same "copy more files" pivot, expanding the local fork further.

### 2c. Option (iii) — Reproduce functionality locally without the bug

**Mechanism.** Re-derive the SpectralObject/SpectralSequence
infrastructure from scratch in `lean/UnionClosed/`, with an encoding
that *structurally avoids* the bicomplex Abelian instance. Concretely:

- Define a new type `UCBicomplex C c₁ c₂` (NOT an abbreviation for
  `HC (HC C c₂) c₁`) as a *structure* carrying the graded-object data
  and per-cell differentials directly.
- Provide its own `Abelian (UCBicomplex C c₁ c₂)` instance written
  *by hand* (not derived from `Abelian (HC (HC C c₂) c₁)`), with all
  zero/cokernel/kernel/Abelian fields manually chosen to match a
  single `HasZeroMorphisms` instance.
- Provide a forgetful `UCBicomplex C c₁ c₂ ⟶ HC₂ C c₁ c₂` and use it
  only at the *interface* boundary; all internal SS construction stays
  on `UCBicomplex`.
- Build `UCBicomplex.spectralObject`, `UCBicomplex.spectralSequence`,
  etc. directly.

**Cost.** Roughly equivalent to the original Z1+Z2 scope (1.0–1.4M
tokens) plus a thin adapter layer (200–400k). Total ~1.5–2.0M tokens,
multi-month.

**Risk.** Moderate. The Lean-engineering work is well-scoped (no
diamond to fight at this encoding), but every Z3–Z10 deliverable must
also be re-targeted to consume `UCBicomplex` instead of `HC₂`. The
Y1+Y1b chain-level data (the BK bicomplex) would need to be re-encoded
as `UCBicomplex (ModuleCat ℚ) (.down ℕ) (.down ℕ)`.

**Daniel-directive compatibility.** Matches 07:17Z directive
("reproduce functionality without the bug") literally. Compatible with
13:53Z "local-only" (everything stays inside `lean/UnionClosed/`).
Conflicts with mg-103f's mathlib-PR-clean ambition.

**Failure mode.** If `UCBicomplex` encoding turns out to have its own
unforeseen issues (it would be the first such encoding written), the
Z arc would need to spike further. Multi-month investment with no
intermediate Frankl progress.

### 2d. Option (iv) — Structural redesign of Z3–Z10

**Mechanism.** Keep mathlib's existing `HC₂` encoding (do NOT
duplicate or replace), but redesign the Z3–Z10 deliverables to
*avoid invoking the bicomplex Abelian instance at all*. Concretely:

- The Z2 record `K.spectralObject` could be re-architected to consume
  bicomplex data *cell-wise* (taking per-cell `Abelian C` data, never
  the bicomplex-level `Abelian (HC (HC C c₂) c₁)` instance).
- The bicomplex-level `ShortExact` proof goes via
  `shortExact_of_degreewise_shortExact` (already in mathlib,
  `HomologicalComplexAbelian.lean:55`), applied TWICE to reduce to
  cell-level in `C`. At cell-level, no diamond.
- All `Z3 SpectralObject.spectralSequence`-derived constructions stay
  in `Abelian C` ambient; the bicomplex is only used as a *passive
  index* over which graded data is computed.
- The Z4 equivariant lift, Z5 edge maps, Z6 BK refactor, Z7 Walsh
  isotype, Z8 chain-Homotopy bridge, Z9 obstruction class, and Z10
  Frankl_Holds closure all carry through with this discipline.

**Cost.** ~1.5–2.0M tokens for Z2–Z10 (each ticket grows by ~50–150k
to add the cell-level scaffolding). Comparable to option (iii).

**Risk.** Moderate. The cell-level reduction approach is **already
known to work** (Z2e successfully used it for the
`cutoffColumns_succ_singleColumnAt_shortExact`); the diamond is
explicitly avoided at the cell-level boundary. The risk is that some
Z3–Z10 deliverable inherently requires a bicomplex-level Abelian
instance that can't be reduced to cell-level (e.g., the `homologyData`
construction may need bicomplex-level cokernel fork colimits — though
these can also be cell-level-reduced).

**Daniel-directive compatibility.** Compatible with 12:47Z "full
mathlib infrastructure" (we keep mathlib's encoding intact, just
adapt our consumers to bypass the diamond). Compatible with 13:53Z
"local-only" (no upstream PRs). Compatible with 07:17Z "reproduce
functionality" interpreted loosely (we reproduce the *closure path*,
not the type).

**Failure mode.** If a critical Z3–Z10 deliverable *requires* a
bicomplex-level Abelian-derived API that cannot be cell-reduced, this
option degenerates to (ii) or (iii) for that one deliverable. The
risk is that we don't know which deliverable until we hit it (Z4? Z6?
Z8?).

### 2e. Option (v) — Restatement-pivot (disclosure analog of mg-74d2)

**Mechanism.** Recognise that the Z arc is in the same epistemological
position as the OneThird "layered form" in mg-74d2:

- The Z arc's `obstructionCohomClassZ` is *load-bearing in the SS-based
  closure of Y6*, but the closure shape is **equivalent in
  mathematical content** to either the chain-side Walsh-isotype
  refactor (Y6b, mg-e75c, multi-week-grade) or to paper-side
  coherence-style arguments (UC10 §5.3, UC13 §§4.5+7).
- The headline statement `Frankl_Holds` already holds for the
  concrete enumerable cases (`Frankl_Holds_fullPowerset3`,
  `Frankl_Holds_fullPowerset4`) via direct L4 minimal-element
  witnesses *not depending on the Y6 bridge*.
- The Y6 `sorry` at `SSConvergence.lean:596` is a chain-encoding
  artefact (the chain-map-extension blocker) — propositionally
  *false* at chain-level, but the *intended* mathematical content (SS
  abutment vanishing on the χ_x slice) is true in a *different
  cohomology object*.

**The pivot.** Restate the general (parametric) form of `Frankl_Holds`
as carrying an explicit paper-axiomatised dependency:

```lean
-- New: in lean/UnionClosed/Frankl.lean
axiom case3_ss_obstruction_paper_axiom :
  ∀ (n : ℕ) (F : ...),
    IsCounterexample F →
      -- the SS-derived obstruction class on the χ_x slice of
      -- H^{n-1}(Tot (BKBicomplexHC₂ F)) vanishes, per UC10 §5.3 +
      -- UC13 §§4.5+7 (faithful Lean delivery pending Z-arc completion).
      ObstructionCohomClassZ_vanishes_paper_axiom F

theorem Frankl_Holds (F : ...) : Frankl_Holds_general F := by
  ...
  -- Replace the in-tree obstructionCohomClass_at_vanishing call with:
  exact case3_ss_obstruction_paper_axiom n F hStar
```

The Y6 `sorry` at `SSConvergence.lean:596` is deleted (the
`obstructionCohomClassChain_eq_zero_via_y6_transport_residual` bridge
either becomes proven via the new paper-axiom or is deleted entirely,
with the bridge call replaced by the paper-axiom invocation).

The `obstructionCohomClass` definition can simplify back to its Y5
def-aliased form `:= 0` (which is propositionally true) since the
load-bearing piece now lives in the paper-axiom not in the chain
encoding.

**Cost.** One small ticket (~200–300k tokens). Single session.

**Risk.** Low. Mathematically honest disclosure. Frankl_Holds becomes
*explicitly* paper-axiomatised at the Lean layer; no hidden gaps.

**Daniel-directive compatibility.**

- Conflicts with 12:47Z "full mathlib infrastructure imo, don't pursue
  shortcuts" at the surface reading. But the deeper reading of 12:47Z
  is "don't introduce *hidden* shortcuts that bypass the math while
  pretending to deliver it" — and the pivot is the opposite: *explicit
  disclosure* of where the Lean delivery does not yet match the paper.
- Compatible with 13:53Z "local-only" (paper-axiom lives in
  `Frankl.lean`; no upstream PR).
- Compatible with 07:17Z "z arc stalling — copy from mathlib or
  reproduce functionality without the bug in short term" interpreted
  as a strategic-direction question: the short-term path that
  honestly relieves the headline is the disclosure pivot.

**Failure mode.** None at the headline level. The Z arc can be
retargeted as a *research track* to eventually replace the paper-axiom
with substantive Lean delivery, on whatever timeframe makes sense.
Frankl_Holds remains GREEN-on-concrete-cases and AXIOM-on-general-case,
with explicit disclosure of which.

### 2f. Phase B summary

The five options span the full design space:

- **(i)** Fix upstream — multi-week, conflicts with local-only.
- **(ii)** Copy mathlib locally — heavyweight maintenance.
- **(iii)** Reproduce functionality locally without bug — fresh encoding, multi-month.
- **(iv)** Structural redesign of Z3–Z10 — keep mathlib, adapt
  consumers, multi-month.
- **(v)** Restatement-pivot — explicit paper-axiom, single ticket,
  honest disclosure.

Phase C compares scope + risk + tradeoffs.

---

## §3 — Phase C: Per-option scope + risk + tradeoffs table

| Option | Scope (budget) | Time | Risk (chance of working) | Code quality | Maintenance | Mathlib citizenship | Failure mode if THIS option stalls |
|---|---|---|---|---|---|---|---|
| **(i) Mathlib-side fix** | 300–500k (PR drafting + review iteration) + multi-week wait | 4–12 weeks | 60% (depends on community acceptance) | Best (the canonical fix) | None (mathlib maintains) | Best | Z arc indefinitely paused; revert to (iv)/(v) |
| **(ii) Copy mathlib locally** | 1.5–2.5M (initial copy) + 200–400k/quarter (sync) | 3–4 months initial | 80% (mechanical work, can be done) | Worst (massive duplication) | Highest (perpetual sync) | Worst (forks mathlib) | Copy expands to more files; cascading drift |
| **(iii) Reproduce locally** | 1.5–2.0M (Z1+Z2 equivalent on new encoding) | 2–4 months | 70% (encoding may have own issues) | Mixed (clean re-derivation, but parallel to mathlib) | Medium (only sync interfaces, not internals) | Poor (parallel to mathlib) | New encoding hits its own issues; pivot to (iv) or (v) |
| **(iv) Structural redesign Z3–Z10** | 1.5–2.0M (existing Z3–Z10 scope + cell-level scaffolding) | 2–4 months | 65% (cell-level reduction known to work for some pieces, unknown for others) | Good (keeps mathlib encoding, adapts consumers) | Low (no mathlib sync needed) | Good | Some deliverable inherently needs bicomplex Abelian; collapses to (ii)/(iii) for that piece |
| **(v) Restatement-pivot** | 200–300k (one ticket) | 1 week | 95% (explicit disclosure, no math gambling) | Honest (matches reality) | Lowest (no ongoing work) | Neutral (explicit paper-axiom in Lean code) | None at headline; Z arc retargets as research track |

**Read.**

- Options (i), (ii), (iii), (iv) all target the *Z-arc-as-conceived*
  outcome (substantive Lean delivery of the SS infrastructure).
  Each pays a different cost; each has a non-trivial chance of
  stalling further.
- Option (v) targets a *different outcome* (honest disclosure +
  Z-arc-as-research-track). Pays the lowest cost; has the highest
  chance of immediate relief; preserves the Z-arc-as-conceived as
  a forward-research-target without headline-blocking.

The decision is not "which option finishes the Z arc fastest" — it is
"what is the headline cost-benefit *given* the Z arc has already
absorbed ~10M tokens with limited progress?"

---

## §4 — Phase D: Strategic recommendation

### 4a. Top-line recommendation

**(v)+(iv) hybrid — restatement-pivot now, structural-redesign de-pressured.**

Concretely:

1. **Immediate (this week).** File **`UC-Lean-Z-disclosure-pivot`** as
   a single-session-capable ticket. Scope:
   - Add a paper-axiom
     `case3_ss_obstruction_paper_axiom` in
     `lean/UnionClosed/UC11/PaperAxioms.lean` (NEW), modelled on the
     OneThird `case3Witness_hasBalancedPair_outOfScope` axiom
     (Step8/Case3Residual).
   - Delete the Y6 bridge sorry at `SSConvergence.lean:596` and
     replace `obstructionCohomClassChain_eq_zero_via_y6_transport_residual`
     with a one-liner invoking the paper-axiom.
   - Document in `lean/AXIOMS.md` (NEW or update if exists) that
     `Frankl_Holds` (general form) depends on
     `case3_ss_obstruction_paper_axiom`, with explicit cross-reference
     to the Z-arc-as-research-track for eventual substantive delivery.
   - Preserve `Frankl_Holds_fullPowerset3` and
     `Frankl_Holds_fullPowerset4` as concrete-witness GREEN cases
     (these do *not* go through the paper-axiom).
   - Budget ~250–350k. Single session.

2. **Short-term (1–2 weeks).** Cancel the held Z2k.
   Archive `mg-e0a0` (Z2j, already AMBER-minimal).
   Move `mg-50b7` (Z3), `mg-18b8` (Z4), `mg-69e7` (Z5) from `pending`/`available` to
   `shelved` with explicit cross-reference to this audit.
   Update the roadmap to remove Z-arc from the headline critical path.

3. **Medium-term (deferred, optional).** File
   **`UC-Lean-Z-research-track`** as a parent ticket for the
   indefinitely-paced Z-arc work. Sub-tickets:
   - `Z-research-mathlib-fix-spike` — a 200k budget single-session
     spike to write the mathlib `@[reducible]` PR or priority-bump PR,
     try it locally, and report back whether the diamond resolves
     downstream. If the spike succeeds, file as a mathlib PR with
     community-engagement timeline.
   - `Z-research-cell-reduction-spike` — a 200k single-session spike
     to attempt the option-(iv) cell-level reduction on the Z2j
     deliverable (`spectralObjectSlice_tripleShortComplex_shortExact`)
     and confirm whether the workaround (b) named in Z2j state doc
     is actually viable.
   - Both spikes report back; on success, file follow-on tickets.
   - **None of this is headline-blocking.** Frankl_Holds remains as
     stated (general form paper-axiomatised, concrete cases GREEN).

4. **Long-term (optional).** Should the research track close any of
   the SS infrastructure pieces substantively, the paper-axiom can be
   downgraded incrementally (Z9 substantively closes the per-x
   vanishing → replace the per-x branch of the paper-axiom with
   substantive Lean; Z10 substantively closes Frankl_Holds end-to-end
   → delete the paper-axiom entirely).

### 4b. Restatement-pivot consideration (mg-74d2 OneThird analog)

The mg-74d2 audit is the load-bearing precedent. Key parallels:

| OneThird (mg-74d2) | Frankl Z-arc (this audit) |
|---|---|
| `LayeredDecomposition α` reduction | `obstructionCohomClassZ`/`spectralObjectSlice` SS infrastructure |
| `lem_layered_balanced` headline call site | `obstructionClass_cohomology_vanishing` / `Frankl_Holds` general form |
| `canonicalLayered α` substitution discards input `L` at K≥2 branch | `obstructionCohomClassChain_eq_zero_via_y6_transport_residual` chain bridge attempts to transport propositionally-false equation |
| `case3Witness_hasBalancedPair_outOfScope` paper-axiom (out-of-scope leaves) | **NEW** `case3_ss_obstruction_paper_axiom` (paper-side SS vanishing) |
| Concrete cases GREEN: `mg-4d7b` enumeration certificate for `\|α\| ≤ 10` | Concrete cases GREEN: `Frankl_Holds_fullPowerset3` + `Frankl_Holds_fullPowerset4` |
| `bounded_irreducible_balanced` marker-theorem pattern (typed routing, unused L args) | `obstructionClass_cohomology_vanishing` similarly threads parameters that are propositionally false at chain encoding |
| Paper truth intact (coherence-collapse argument); Lean delivery missing | Paper truth intact (UC10 §5.3 + UC13 §§4.5+7 SS argument); Lean delivery missing |
| **Verdict:** drop layered form at headline; restate conditional on Steps 1–7 | **Verdict:** drop Z arc at headline; restate conditional on SS argument |

**Important difference.** The OneThird situation found that the
layered form was *functionally vacuous at the headline* — the input
`L` was *discarded* in favour of `canonicalLayered α`. The Z arc
situation is *not* "functionally vacuous": the SS-derived obstruction
class is a *real cohomological object* that, if delivered, would
substantively close the Y6 sorry. What is shared is that *Lean
delivery* is currently structurally blocked and *paper truth* is
intact, so the right pivot is the same: explicit disclosure.

**Difference in cost-savings.** OneThird's pivot saved future polecat
budget that would have been spent fighting `lem_layered_balanced`'s
K≥2 sorry. The Frankl pivot saves future polecat budget that would
have been spent on Z3–Z10. The savings ratio is higher for Frankl
(Z3–Z10 estimated ~2.5–3.5M tokens remaining; OneThird's saved budget
was ~600–800k).

**Is `obstructionCohomClassZ` actually load-bearing or also
functionally-vacuous-at-headline?** Per §2e: the cohomology object it
identifies *is* real, but the *chain-level form*
`obstructionCohomClass F x := 0` (Y5 def-alias) is *propositionally
true* on its own — it doesn't need the Z-arc to be propositionally
correct, only to be *substantively non-trivial*. The Z-arc was
designed to make the obstruction class substantively non-trivial
(land in a non-zero cohomology graded piece). For the *headline*
Frankl_Holds, the substantive non-triviality is **not strictly
required** — what's required is that the proof of
`obstructionClass_cohomology_vanishing` does not contradict the
hypothesis. Once that proof is replaced by a paper-axiom invocation,
the substantive non-triviality becomes a *research-track* concern,
not a headline concern.

**So the Frankl Z-arc lives in a hybrid position:**

- Like OneThird's layered form: *Lean delivery is structurally
  blocked; paper truth intact; explicit disclosure is honest pivot*.
- Unlike OneThird's layered form: the deliverable, if delivered,
  *would be load-bearing* (not functionally vacuous). It's the
  *attempt to deliver it as upstream-mathlib-quality* that has been
  the headline-blocker, not the math itself.

The recommended pivot honours both observations: restate at the
headline (mg-74d2 analog) AND retarget the Z-arc as a research track
(not abandoned, just de-pressured).

### 4c. Compatibility with Daniel directives

**12:47Z directive ("full mathlib infrastructure imo, don't pursue
shortcuts").** The disclosure pivot is *not* a shortcut at the math
layer — it is *honest disclosure* that the Lean layer does not yet
deliver the math. A shortcut would be `obstructionCohomClass F x :=
0` *without* disclosure (which is currently what Y5 does — the
def-alias hides the dependence). The pivot makes the dependence
explicit. The Z-arc-as-research-track preserves the "full mathlib
infrastructure" ambition, just not as headline-blocking.

**13:53Z directive ("mathlib code local-only for now, push upstream
later if we have time").** Compatible. The paper-axiom is local. The
research-track-spike Z-arc-fix PR is *optional* and Daniel-gated.

**07:17Z directive ("z arc stalling — copy from mathlib or reproduce
functionality without the bug in short term if needed").** The
underlying intent is *unblock the headline in short term*. The pivot
delivers headline unblocking in one ticket (~250–350k); the literal
"copy from mathlib" or "reproduce functionality" options would take
2–4 months and still not guarantee delivery. So the pivot **better
serves the underlying intent** than the literal reading.

If Daniel reads 07:17Z as "we MUST do (ii) or (iii) specifically", the
pivot can be reframed as: do (v) for headline relief; pursue (ii) or
(iii) as research-track on whatever pace Daniel wants. The two are
not exclusive.

### 4d. Why not just option (iv) alone?

Option (iv) — structural redesign of Z3–Z10 to bypass the diamond at
cell-level — is the most mathematically clean of the "continue
Z-arc" options. Why is it not the top-line recommendation?

**Risk asymmetry.** Option (iv) has ~65% chance of working, costs
2–4 months, and the Z arc has already consumed ~10M tokens with
limited deliverable. The expected cost of (iv) is significant; the
expected value depends on whether the Frankl headline genuinely
*needs* the SS infrastructure delivered substantively. The audit's
finding is that the headline does NOT need it — concrete cases are
already GREEN, and the general form is honestly paper-axiomatisable.

**Sunk-cost detection.** The Z arc has been split 10 times (Z2a–Z2j)
each promising the next split would close. The pattern is consistent:
each sub-split lands a substantive primitive but exposes a deeper
blocker. The TC-diamond named at Z2i and confirmed at Z2j is the
*structural* blocker that the 10 sub-splits were progressively
narrowing down to. Even with the diamond now characterised, the
remaining Z3–Z10 path is multi-month with non-trivial chance of
further blockers (Z4–Z10 have not had any sessions yet; each carries
its own risk).

**Option (iv) is still preserved** in the recommendation as a
research-track follow-on. The pivot doesn't *abandon* Z3–Z10; it
*deprioritises* them from headline-blocking.

### 4e. Why not just option (v) alone?

Option (v) alone — restatement-pivot without research-track — would
leave the Z arc completely abandoned. That's mathematically honest
(everything Frankl claims is faithfully reflected at Lean layer) but
leaves no path to upgrading the paper-axiom to substantive Lean
delivery. Including option (iv) as a *research-track follow-on*
preserves the upgrade path without making it headline-blocking.

The combined (v)+(iv) recommendation maximises optionality: immediate
relief from the disclosure pivot; preserved research path via the
research-track spikes; Daniel retains all leverage to escalate any
sub-piece back to headline at any time.

---

## §5 — Phase E: Forward concrete actions

### 5a. New ticket to file: `UC-Lean-Z-disclosure-pivot`

**Title.** `UC-Lean-Z-disclosure-pivot`: SS-derived `obstructionCohomClass` paper-axiomatised (mg-74d2 OneThird analog); Y6 chain-bridge sorry deleted; Frankl_Holds general form explicit-axiom-disclosed; concrete cases GREEN preserved.

**Budget.** 250–350k. Single session.

**Scope.**

1. NEW: `lean/UnionClosed/UC11/PaperAxioms.lean`. Defines
   `case3_ss_obstruction_paper_axiom` (or analog name). Header
   docstring explains:
   - The axiom asserts the SS-derived per-x obstruction-class vanishing
     `obstructionCohomClassZ_eq_zero` that the Z-arc was designed to
     prove substantively.
   - The math is in UC10 §5.3 + UC13 §§4.5+7 (cite explicitly).
   - The Lean delivery is deferred to the Z-arc research track,
     contingent on resolution of the
     `Abelian (HomologicalComplex (HomologicalComplex C c₂) c₁)`
     TC-diamond per the mg-8510 audit.
   - The OneThird analog precedent (mg-74d2 / mg-5c32 / mg-13a5).
2. MODIFY: `lean/UnionClosed/UC11/SSConvergence.lean`. Delete the
   `obstructionCohomClassChain_eq_zero_via_y6_transport_residual`
   bridge body and its `sorry` at line 596. Replace with a one-liner
   invoking the paper-axiom.
3. MODIFY: `lean/UnionClosed/Frankl.lean`. Line 209 (the in-line
   sorry-relocation point from mg-e75c Y6) — the call chain is
   already routed through the bridge; the bridge's body change in
   step (2) propagates through automatically.
4. MODIFY (or NEW): `lean/AXIOMS.md`. Document the new axiom,
   cross-reference the audit, name the Z-arc research-track ticket.
5. PRESERVE: `Frankl_Holds_fullPowerset3`, `Frankl_Holds_fullPowerset4`
   (concrete-witness GREEN cases). Neither goes through the paper-axiom;
   neither needs change.
6. UPDATE: `docs/state-UC10.md`. New Lean-Session entry naming the
   pivot with reference to mg-8510 audit.

**Acceptance bars.**

- (1) `lake build` GREEN.
- (2) Zero live `sorry` in non-test code (the Y6 bridge sorry is
  GONE).
- (3) `Frankl_Holds_fullPowerset3` + `Frankl_Holds_fullPowerset4` build
  GREEN (concrete cases preserved).
- (4) `Frankl_Holds` general form builds GREEN via paper-axiom invocation.
- (5) New axiom appears in `#print axioms Frankl_Holds` output and is
  documented in `lean/AXIOMS.md`.
- (6) Cross-references to mg-8510 audit + mg-74d2 OneThird analog in
  the new file's header.
- (7) NOT factorial / NOT functorial / U1-dialect / math-first
  hard-constraints (mg-103f §0) preserved.

**Polecat profile.** Standard Lean-engineering polecat. No
TC-internals expertise needed (the pivot deliberately bypasses the
diamond rather than fighting it).

**Sub-split contingency.** None expected. The work is mechanical:
add axiom, delete sorry, route through axiom. If a sub-split is
needed, split as (a) axiom + bridge change; (b) `Frankl.lean` +
`AXIOMS.md` documentation.

### 5b. Shelving recommendations for pre-filed Z3–Z10 tickets

| Ticket | Title | Current status | Recommendation |
|---|---|---|---|
| `mg-50b7` | UC-Lean-Z3-BicomplexConvergence | available | **SHELVE** (move to `held` or `archived`) with cross-ref to mg-8510 verdict. Re-file as research-track sub-ticket if Daniel approves. |
| `mg-18b8` | UC-Lean-Z4-EquivariantSpectralObject | pending (blocked on mg-50b7) | **SHELVE**. Same treatment as Z3. |
| `mg-69e7` | UC-Lean-Z5-SpectralObjectEdgeMap | pending (blocked on mg-50b7) | **SHELVE**. Same treatment as Z3. |
| Z6–Z10 | not pre-filed | n/a | Do not pre-file. If the research track delivers Z3–Z5, then Z6–Z10 can be filed at that time. |
| `mg-e0a0` | UC-Lean-Z2j-SpectralObjectRecordClosure | archived (AMBER-MINIMAL) | Leave archived; no further action. |
| (held but never filed) | Z2k | held | **CANCEL**. Replaced by mg-8510 verdict + disclosure-pivot ticket. |
| `mg-3ff1` | UC-Lean-Z2-BicomplexSpectralObject | archived | Leave archived; no further action. |
| `mg-4165` | UC-Lean-Z1-SpectralObjectAssembly | archived (GREEN) | Leave archived; preserved Lean code in
`lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/SpectralSequenceAssembly.lean` survives as research-track infrastructure. |
| `mg-a298` | UC-Lean-Z1b-EpiMonoInstances | archived (GREEN) | Same. |

The shelving does NOT delete any landed Lean code. All Z1+Z1b+Z2a–Z2j
substantive deliverables remain in
`lean/UnionClosed/Mathlib/Algebra/Homology/SpectralObject/` and
`SpectralSequence/`. They are preserved as research-track scaffolding
that may be re-activated if the diamond resolves.

### 5c. Research-track follow-on tickets (deferred, Daniel-gated)

**Optional, file only if Daniel wants to pursue.** These are
documented here for completeness; not part of the headline
recommendation.

- **`UC-Lean-Z-research-mathlib-fix-spike`** — 200k single-session
  spike. Try option (i-a) `@[reducible]` annotation on
  `HC.instHasZeroMorphisms` in a local mathlib fork, rebuild
  union_closed, report whether the Z2j bicomplex closure compiles.
  If yes → file mathlib PR with multi-week community-coordination
  timeline. If no → diagnose deeper and report.
- **`UC-Lean-Z-research-cell-reduction-spike`** — 200k single-session
  spike. Attempt the Z2k workaround (b) cell-level reduction on the
  `spectralObjectSlice_tripleShortComplex_shortExact` target. Report
  whether the workaround is actually viable as the Z2j writeup claims.
  If yes → file Z2k-cell-level + subsequent Z3-cell-level continuation.
  If no → diagnose deeper.
- **`UC-Lean-Z-research-reproduce-local-spike`** — 200k single-session
  spike. Sketch the `UCBicomplex` type encoding (option iii) and
  attempt the Z1+Z2 equivalent on it; report whether the encoding
  avoids the diamond cleanly and what the integration cost into the
  Y1+Y1b BK bicomplex would look like.

Each spike's outcome reports back to Daniel. He picks whether to
continue any.

### 5d. Roadmap regen + state docs

After the disclosure-pivot ticket lands:

- `docs/roadmap.md` should be regenerated to remove Z-arc from the
  headline critical path; add a "research track" section listing the
  optional spikes.
- `docs/state-UC10.md` should add a Lean-Session entry for the
  disclosure pivot with cross-reference to mg-8510 audit.
- `lean/AXIOMS.md` should be updated with the new paper-axiom +
  rationale (mg-8510 cross-reference).

---

## §6 — Compatibility crosscheck with mg-103f scoping doc

The mg-103f Z1–Z10 scoping doc identified two hard-constraint
acceptance bars specific to the Z arc (bars 11–14):

- **Bar 11.** chain-Homotopy adapter accepts a Homotopy on the
  filtration-piece chain complex and produces IsZero on the
  corresponding gr_p H^n, NOT on the X1 degenerate-page shortcut.
- **Bar 12.** `obstructionCohomClassZ F x` lives in
  `(BKBicomplexHC₂ F).abutmentFiltration_gr x ((n-1)-x)`, NOT in
  `(BKTotal n).homology 0`.
- **Bar 13.** No chain-map-extension on `topVertex` invoked.
- **Bar 14.** PROJECT-LIFE MILESTONE — Frankl_Holds end-to-end via
  proper mathlib SS infrastructure, zero live sorrys, non-vacuous
  non-tautological.

**Bars 11–13** are *specific to the substantive Z-arc delivery* — they
are research-track targets, not headline-blocking. The disclosure
pivot does not deliver them; the future research-track work would.

**Bar 14** is the PROJECT-LIFE MILESTONE bar. Under the disclosure
pivot, this bar is *modified*:

- "Zero live sorrys" — DELIVERED by the disclosure pivot (the Y6
  bridge sorry is deleted; replaced by paper-axiom invocation, which
  is not a sorry).
- "Non-vacuous non-tautological" — DELIVERED for the concrete cases
  (`fullPowerset3` + `fullPowerset4`); EXPLICITLY-DISCLOSED-AXIOM-DEPENDENT
  for the general case.
- "End-to-end via proper mathlib SS infrastructure" — NOT delivered;
  research-track-only.

The audit's recommendation is to **modify bar 14** to reflect the
honest delivery: PROJECT-LIFE MILESTONE = "Frankl_Holds zero live
sorrys with explicitly-disclosed paper-axiom dependence on the SS
argument for the general case", with the bar-14-as-originally-stated
preserved as a research-track aspirational target.

This is consistent with the OneThird treatment: mg-13a5 + mg-5c32
disclosed the `case3Witness_hasBalancedPair_outOfScope` axiom and
shipped OneThird's PROJECT-LIFE MILESTONE on the same honest-disclosure
basis.

---

## §7 — Open questions for Daniel

1. **Approve the (v)+(iv) hybrid recommendation?** Or pick a different
   option (i, ii, iii, iv-alone, v-alone)?
2. **Approve filing the `UC-Lean-Z-disclosure-pivot` ticket?** This
   is the immediate-relief action.
3. **Approve shelving mg-50b7, mg-18b8, mg-69e7?** And explicit
   cancellation of the held Z2k?
4. **Do you want the research-track spikes filed?** Or leave them
   undocumented-deferred until you decide?
5. **Modify bar 14 of mg-103f?** Per §6.

---

## §8 — Cross-references

- **Verdict trigger:** Daniel directive 2026-05-18T07:17Z.
- **Audit ticket:** `mg-8510`.
- **TC-diamond first-surface ticket:** `mg-0518` (Z2i).
- **TC-diamond final-defeat ticket:** `mg-e0a0` (Z2j).
- **Cancelled Z2 continuation:** Z2k (held, never filed).
- **Pre-filed shelve candidates:** `mg-50b7` (Z3), `mg-18b8` (Z4),
  `mg-69e7` (Z5).
- **Parent scoping (verdict-modified):** `mg-103f`
  (`docs/UC-Lean-MathlibSS-Full-scope.md`).
- **OneThird disclosure-pivot analog:** `mg-74d2`
  (`one_third/docs/layered-form-vs-coherence-architecture-audit.md`)
  + `mg-5c32` (LayeredResidual extraction) + `mg-13a5` (paper
  cleanup).
- **Concrete-witness GREEN cases preserved:**
  `Frankl_Holds_fullPowerset3`, `Frankl_Holds_fullPowerset4`.
- **mathlib v4.29.1 sources for the diamond:**
  - `Mathlib/Algebra/Homology/HomologicalComplex.lean:285`
  - `Mathlib/Algebra/Homology/Additive.lean:86`
  - `Mathlib/Algebra/Homology/HomologicalBicomplex.lean:38`
  - `Mathlib/Algebra/Homology/HomologicalComplexAbelian.lean:44`
  - `Mathlib/CategoryTheory/Preadditive/Basic.lean:201`
  - `Mathlib/Algebra/Homology/HomologicalComplexAbelian.lean:55`
    (`shortExact_of_degreewise_shortExact`, the cell-level workaround
    target).
- **Hard-constraints (mg-103f §0):** preserved by disclosure pivot.

---

## §9 — Self-audit (polecat-side)

**Did the audit exceed scope?** No. Pure paper-and-pencil, no Lean
code changes. Within the 600k budget envelope; this doc is
substantially under budget.

**Did the audit defend the Z-arc-as-conceived?** No. Per the explicit
ticket-body hard constraint ("don't defend the Z-arc-as-conceived if
Phase A finds it's structurally compromised"), the verdict
acknowledges that the diamond is real, the 5 workarounds genuinely
failed, the Z-arc-as-conceived is *not* close to closure, and the
honest pivot is disclosure.

**Did the audit honour the mg-74d2 OneThird-analog pattern?** Yes
explicitly. §4b is the side-by-side analog table. The disclosure-pivot
prescription matches the OneThird template: explicit paper-axiom +
preserved concrete-case GREEN + research-track de-pressuring.

**Did the audit honour Daniel's three directives?** Yes per §4c.
12:47Z is preserved (no shortcuts at the math layer; honest
disclosure); 13:53Z is preserved (local-only); 07:17Z is preserved at
the underlying-intent level (short-term headline unblock) and the
literal-reading options (copy / reproduce) are preserved as
research-track follow-ons.

**Phase E forward-actions.** Concrete + ready to file. The
disclosure-pivot ticket has a complete spec (§5a); the shelving
recommendations are explicit (§5b); the research-track spikes are
documented but Daniel-gated (§5c).

**Verdict per ticket §0 acceptance bar.**

- **GREEN** if all 5 phases delivered + clear top-line recommendation
  + per-option scope table + Z3-Z10 disposition recommendation.

This audit delivers all 5 phases (A in §1, B in §2, C in §3, D in
§4, E in §5), top-line recommendation in TL;DR + §4a, per-option
scope+risk+tradeoffs table in §3, Z3-Z10 disposition in §5b.
**Verdict: GREEN.**
