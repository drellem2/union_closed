# pm-onethird product roadmap (1/3-2/3 + Union-Closed compatibility-geometry program)

*Updated by pm-onethird 2026-07-21 00:20 BST — evening sweep for 07-20, run ~7h late as a sleep catch-up (host slept 13:50→00:14; pogod replayed the schedule on wake, replay=once so exactly one catch-up sweep). **Canonical current doc = STATE.md in github.com/drellem2/onethird_program (onethird_program repo, in scope).** This roadmap is the thin operational summary; STATE.md holds the full attempt index + proofs. CI clean (one_third's April red is stale/superseded — latest main run is green). Frankl shelved. Manual edits overwritten next sweep.*

**Scope.** Repos: onethird_program (canonical), union_closed, one_third_width_three, one_third. Tags: onethird, one-third, lean, audit, union-closed, frankl.

**Headline.** After a full-day 2026-07-19 research push (11 arcs, every one adversarially audited before touching STATE.md or Daniel), the wall is precisely triangulated and the record is honest. No forward progress on the crux, but a much sharper map + several corrected claims.

- **The wall is ONE object, reached by three independent routes.** The open crux is a joint / between-window-location / `ρ_s ≈ 1` term = mg-dcae's wrong-signed same-side **`(B-cov)` covariance**. The Stanley-stability route (mg-0ed7), the variance/covariance route (mg-dcae), and the spectral-implications route (mg-8f56) all land there. `(B) ⟺ ρ_s ≤ ρ < 1` (L1b core lemma, an iff) — cannot be sidestepped.
- **Standard dominance is CONDITIONAL on all-pairs-frozen, not universal or false** (mg-4a86, audit-corrected from an overstated "FALSE" headline). The BK gap `λ₂^BK` (dynamical) and `λ_std` (static) are not equal in general; the real control conjecture survives + is supported in-regime.
- **Mixing ⊥ balance, now theorem-backed.** LLO 2025 (arXiv:2503.01005) proves spectral independence / poly mixing for linear extensions of every poset — so fast mixing is universal and blind to δ; the δ obstruction lives purely in the stationary marginal.
- **Corrected record:** mg-0ed7 Finding 7.5 (the `Φ→Var` reduction) is **REFUTED** (inequality-direction error, caught by mg-8f56); a prior pm-onethird audit had missed it.

Two human-action items pending on Daniel (mg-344a, mg-b8f9). No URGENT signals.

---

## Now — counterexample search LIVE (computation authorized, scoped)
- **mg-0eac IN FLIGHT** (high prio, polecat `0eacb`). Daniel filed it 2026-07-20 12:04Z and **lifted the no-computation hold for the counterexample search specifically**. Coherence-guided perturbation search for a **primitive** poset with `δ < β ≈ 0.3488`, seeded from the β-extremal families (ladders / Chen / Sah). Primary deliverable is the **min-δ-per-size profile** at `n ≥ 12`; a counterexample is unlikely and is not what success is indexed to.
  - Novel path = the proven "`δ<1/3` ⟹ coherent distinguished `e`" structure, which Peczarski did not use. Exhaustive-search ≤ n=11 is done in the literature and is explicitly out of scope.
  - **This ticket is on its second attempt.** The first polecat died in the 2026-07-20 fleet restart; its work survived on branch `polecat-0eac` (`c583212`) plus three newer *uncommitted* files in the stale worktree. The RESUME preamble directs recovery-before-restart, and `0eacb` respawned on the 00:14 wake carrying it.
- **The lift is scoped.** It covers the counterexample search only — it does **not** unblock the n=7 overlap test below. Treating it as a general lift would be inferring an instruction Daniel didn't give.
- **L1b crux still ball-with-Daniel.** Productive target unchanged: break the wrong-signed `(B-cov)` covariance / equivalently prove `ρ_s < 1` under freezing.
- **Two pending Daniel research calls** (offered, awaiting his word):
  1. **n=7 overlap test** — the one decisive check of the conditional-standard-dominance picture (overlap `c` at 3 known n=7 off-regime posets). **Still blocked**; needs its own narrow exception. Dataset-revert of the mg-4a86 over-run is held pending this call.
  2. **`O(1)` locality probe** — prove `Σ_{y∥x} Pr[{x,y} inverts] = O(1)` under freezing (mg-0ed7's residual; the `(B-bias)` lemma). Natural next swing at the crux.
- **STATE.md maintained on every verdict** (canonical; through @e1b8fb2, incl. Appendix A audit-stage process).

## Process (now live)
- **Independent pre-PM-review audit stage — LIVE** (mg-3a3a; template in STATE.md Appendix A). Every research deliverable with a math/[PROVEN] claim gets an independent audit polecat (mayor-dispatched) before pm-onethird's second-line review. Formalized after a pm-onethird audit missed an in-prose [PROVEN] reduction (mg-0ed7 7.5); mg-8f56 was this stage run manually and caught it.

## Next (contingent on Daniel)
- Either of the two calls above lifts the hold and dispatches a polecat.
- Reserve routes unchanged: the `(B-bias)` locality lemma (elementary, no Stanley/AF); Residual (R) frozen-density ceiling (mg-210d); the (B-cov) covariance break (the sharp edge).

## Later (contingent)
- **If the `(B-cov)`/`ρ_s < 1` crux closes:** L1b closes at any width → M1 close-out audit + Lean follow-on.
- **Frankl, pending mg-38ba fork:** pre-scoped, unfiled until Daniel unshelves.

## Backlog / pending on Daniel (human-action)
- **Frankl track SHELVED** (Daniel directive 2026-07-15).
- **mg-344a** — Daniel-only obstruction review (bespoke finite/rigid combinatorics on the quotient-to-chain frame). Awaits Daniel.
- **mg-b8f9** — Hopkins (#2) outreach email; drafted. Send = Daniel's call.

## Recently shipped (2026-07-19, all audited)
- **mg-210d** — best constant `λ_std` bound = 0 (route collapses onto incomparability density); Residual (R) = frozen density ceiling; frozen ⟹ majority relation is a linear extension.
- **mg-0ed7** — Ma-Shenfeld frozen-conditional Stanley-stability; durable win = geometric explanation of why unconditional stability is refuted (deficit = hazard increment); Finding 7.5 later refuted.
- **mg-4a86** — standard-dominance comparison route; headline corrected to conditional-on-frozen; deformation route proven dead; Cayley-vs-BK evidence catch.
- **mg-8f56** — spectral implications of the stability theorems (vacuous reach); refuted mg-0ed7 7.5; re-diagnosed §6.5 (relocation, not reopening).
- **mg-3a3a** — durable audit-stage process + reusable audit template (STATE.md Appendix A).
- Earlier 07-19: entropy-discontinuity arcs (mg-a1ec/48ab/dcae) + 4 entropy probes (A-D) + State-of-the-Wall doc & repo.

## Trajectory / gaps I'm watching
- **Converging, not stalling.** No forward progress on the crux this cycle — the fleet was down ~10h overnight and the day's only research motion is mg-0eac's first attempt dying and being resumed. The wall remains a single named object reached from three sides; the bottleneck is the `(B-cov)` covariance sign, unchanged.
- **mg-0eac is on attempt 2 — watch that recovery actually happened.** The value at risk is the three uncommitted files in the stale `0eac` worktree. The success signal is the polecat's deliverable explicitly reporting how far attempt 1 got vs. what it added; a deliverable that silently rewrites from scratch means the recovery step was skipped and the prior work was lost, not superseded. Checking on the next sweep.
- **Consolidation pending:** STATE.md (onethird_program) is canonical; this roadmap + the stale one_third_width_three/docs/roadmap.md (~65d old) are redundant. Consolidate to STATE.md + a thin roadmap.
- **No-computation directive vs the decisive test:** the n=7 overlap test that would settle conditional standard dominance remains blocked — mg-0eac's lift is scoped to the counterexample search and does not reach it. Still Daniel's call.
- **Stale checkout hazard in one_third_width_three** (mg-2ed2, low prio, filed this sweep; not touched). The main working copy sits on abandoned May branch `mayor-a5-g2-status`, 99 behind origin/main, with 83 staged adds. Verified non-destructive to fix: every one of the 83 staged paths already exists on origin/main (`git cat-file -e origin/main:<path>` for all 83), so nothing is unpublished. The risk is a human or agent working in that directory against 2-month-stale files without noticing.
