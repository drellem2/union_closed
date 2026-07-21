# pm-onethird product roadmap (1/3-2/3 + Union-Closed compatibility-geometry program)

*Updated by pm-onethird 2026-07-21 01:45 BST — inter-sweep update, triggered by the mg-0eac independent-audit verdict landing rather than by the sweep clock. The 07-20 evening sweep ran ~7h late as a sleep catch-up (host slept 13:50→00:14; pogod replayed on wake, replay=once, so exactly one catch-up sweep). **Canonical current doc = STATE.md in github.com/drellem2/onethird_program (onethird_program repo, in scope).** This roadmap is the thin operational summary; STATE.md holds the full attempt index + proofs. CI clean (one_third's April red is stale/superseded — latest main run is green). Frankl shelved. Manual edits overwritten next sweep.*

**Scope.** Repos: onethird_program (canonical), union_closed, one_third_width_three, one_third. Tags: onethird, one-third, lean, audit, union-closed, frankl.

**Headline.** After a full-day 2026-07-19 research push (11 arcs, every one adversarially audited before touching STATE.md or Daniel), the wall is precisely triangulated and the record is honest. No forward progress on the crux, but a much sharper map + several corrected claims.

- **The wall is ONE object, reached by three independent routes.** The open crux is a joint / between-window-location / `ρ_s ≈ 1` term = mg-dcae's wrong-signed same-side **`(B-cov)` covariance**. The Stanley-stability route (mg-0ed7), the variance/covariance route (mg-dcae), and the spectral-implications route (mg-8f56) all land there. `(B) ⟺ ρ_s ≤ ρ < 1` (L1b core lemma, an iff) — cannot be sidestepped.
- **Standard dominance is CONDITIONAL on all-pairs-frozen, not universal or false** (mg-4a86, audit-corrected from an overstated "FALSE" headline). The BK gap `λ₂^BK` (dynamical) and `λ_std` (static) are not equal in general; the real control conjecture survives + is supported in-regime.
- **Mixing ⊥ balance, now theorem-backed.** LLO 2025 (arXiv:2503.01005) proves spectral independence / poly mixing for linear extensions of every poset — so fast mixing is universal and blind to δ; the δ obstruction lives purely in the stationary marginal.
- **Corrected record:** mg-0ed7 Finding 7.5 (the `Φ→Var` reduction) is **REFUTED** (inequality-direction error, caught by mg-8f56); a prior pm-onethird audit had missed it.

Two human-action items pending on Daniel (mg-344a, mg-b8f9). No URGENT signals.

---

## Now — mg-0eac DONE + independently audited (PASS-WITH-FINDINGS)

**The precise proven statement — use this wording, not the commit subject.**

> Over primitive posets of **width exactly 3** with **n ≤ 11**, **min δ = 6/17 ≈ 0.352941**,
> attained at **n = 10**. Proven minimum: exhaustive, prune independently re-certified.
> It is below Olson-Sagan's 14/39 ≈ 0.358974 — which they established only for n ≤ 9, so this
> **extends rather than contradicts** them — and remains **4.10e-3 ABOVE β**.

For 12 ≤ n ≤ 16 at width ≥ 3, nothing below β was found by a **bounded beam that is
demonstrably incomplete** (it misses the true n=10 optimum in its own validation). **Width ≥ 4
received no coverage at any n ≥ 10.** Nothing below 1/3 anywhere.

So "nothing below β" is **proven** only on width-exactly-3 at n ≤ 11, and is a bounded-search
**observation** at 12 ≤ n ≤ 16. **The gap is NARROWED, not closed** — commit a90f0f7's subject
says "close out", the doc (line 396) says "it narrows the gap; it does not close it", and the
doc is right. Ledger records *narrow*.

- **Independent audit (aud0eac) — PASS-WITH-FINDINGS, nothing blocking.** Every headline number
  reproduced, most on a from-scratch δ engine sharing no code with the merged work; all seven
  Peczarski (δ,e) pairs rebuilt from the doc's prose spec; Olson-Sagan checked against
  arXiv:1706.04985 §6 verbatim; β pinned from exact radicals (β ≠ κ *provably*, distinct
  quadratic fields). Controls demonstrated able to fail. Search completeness cross-checked
  against OEIS A000112 and brute force over 19,448 posets — 0 disagreements.
- **mg-8489 filed** for the one finding with teeth: `five_engine_check` validates five engines
  but **not `fast_Q`**, which is what `delta_of` actually calls on every poset in every sweep.
  Risk is asymmetric — a `fast_Q` bug overstating δ on the true minimiser is a silent false
  negative nothing would look at. Auditor closed it empirically (0 disagreements over 9,397
  posets); no bug exists, but the stated control didn't cover the load-bearing path.
- **Residual gap, stated honestly:** width ≥ 4 at n ≥ 10 is uncovered, and that is precisely
  where a wide low-δ poset would have to hide.

## Standing context — the computation lift, and what it does NOT cover
- **Origin of mg-0eac:** Daniel filed it 2026-07-20 12:04Z and **lifted the no-computation hold for the counterexample search specifically**. Deliverable was always the **min-δ-per-size profile**, not a counterexample — a counterexample was judged unlikely and success was never indexed to it. Novel path = the proven "`δ<1/3` ⟹ coherent distinguished `e`" structure, which Peczarski did not use; exhaustive search ≤ n=11 is literature and was explicitly out of scope. *(Completed and audited — see Now, above.)*
- **The lift is scoped and remains so.** It covered the counterexample search only — it does **not** unblock the n=7 overlap test below. Treating it as a general lift would be inferring an instruction Daniel didn't give.
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
- **mg-0eac recovery — CLOSED POSITIVELY**, and satisfied more than I asked for. §9.6 states "§§0–8 are the recovered original; §9 is new"; both the committed (`c583212`) and the uncommitted worktree state were re-committed before any new work began (`3b1f63b`); and the recovered δ engine was **not taken on trust** — the full positive-control gate was re-run against Peczarski's published table, all seven (δ,e) pairs reproduced exactly up to `L₂₅;₁,₅,₈,₉,₁₂,₁₃,₁₆,₂₀` with `e = 256308`. A control on an external reference, which could genuinely have failed.
- **Next watch-item: the residual gap is width ≥ 4 at n ≥ 10** — uncovered by any search so far, and the only place a wide low-δ poset could still hide. Whether to spend further compute there is my call, not a Daniel one; deferring the decision until mg-8489's hardening lands so any follow-on search runs on a gate that covers its own swept path.
- **Consolidation pending:** STATE.md (onethird_program) is canonical; this roadmap + the stale one_third_width_three/docs/roadmap.md (~65d old) are redundant. Consolidate to STATE.md + a thin roadmap.
- **No-computation directive vs the decisive test:** the n=7 overlap test that would settle conditional standard dominance remains blocked — mg-0eac's lift is scoped to the counterexample search and does not reach it. Still Daniel's call.
- **Stale checkout hazard in one_third_width_three** (mg-2ed2, low prio, filed this sweep; not touched). The main working copy sits on abandoned May branch `mayor-a5-g2-status`, 99 behind origin/main, with 83 staged adds. Verified non-destructive to fix: every one of the 83 staged paths already exists on origin/main (`git cat-file -e origin/main:<path>` for all 83), so nothing is unpublished. The risk is a human or agent working in that directory against 2-month-stale files without noticing.
