# pm-onethird product roadmap (1/3-2/3 + Union-Closed compatibility-geometry program)

*Updated by pm-onethird 2026-07-23 09:05 BST — morning sweep (silent). **Confirmed no product change since the 07-22 outage catch-up** — zero commits, CI runs, merges, issues, PRs, or mail across all four repos overnight; redeploy still not done (pogod at 249f349), so mg-4ad1 remains correctly held. The outage was diagnosed and closed: it was a fleet-wide credential expiry (~23h40m, five agents' logins expired at the same second 07-21T23:10:26Z), NOT a wedge; a restart would have made it worse; fixes are mg-18d0 (merged), mg-8cdb (auth-expiry pager) and mg-ed45 (why it expired), all pogo-scope. Prior context: 07-22 23:50 catch-up after the outage; 07-21 17:05 evening sweep. The mg-0eac arc shipped, was independently audited, and its follow-on scoping arc (mg-c47a) was audited OVERSTATED and repaired. Width >= 4 residual DROPPED on tractability. **Canonical current doc = STATE.md in github.com/drellem2/onethird_program (onethird_program repo, in scope).** This roadmap is the thin operational summary; STATE.md holds the full attempt index + proofs. CI clean (one_third's April red is stale/superseded — latest main run is green). Frankl shelved. Manual edits overwritten next sweep.*

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
- **mg-8489 CLOSED and independently re-verified** (`b724987`). The audit's one finding with
  teeth: `five_engine_check` validated five engines but **not `fast_Q`**, which is what
  `delta_of` calls on every poset in every sweep. Risk was asymmetric — a `fast_Q` bug
  *overstating* δ on the true minimiser is a silent false negative nothing would look at.
  `fast_Q` is now engine M0 in the gate, and pm-onethird **ran the shipped control**
  (`scripts/onethird_mg8489_fastq_gate_control.py`): **6/6**, exit 0 — corrupting `fast_Q` three
  ways now RAISES (including the overstate direction), corrupting `Q_primary` still RAISES (not
  shadowed), gate green on restore. A gate demonstrated able to fail on the case it was blind to.
- **Residual gap (width ≥ 4 at n ≥ 10) — scoped, audited, and now DROPPED.** Full arc closed today:
  mg-c47a (scoping) → mg-7d24 (independent audit, **OVERSTATED** — 10 CONFIRMED, 2 OVERSTATED,
  **1 BROKEN** of 13 [PROVEN] tags) → mg-8ff1 (repairs). All merged and archived.
  - **DROP stands, but NOT on the reasoning the deliverable led with.** The equivalence is real and
    audit-CONFIRMED: Q1's strongest form, "low δ forces width ≤ 2", is *logically equivalent to the
    1/3-2/3 conjecture itself* modulo Sah. But the inference drawn from it — "so a programme
    pursuing it goes in a circle" — is **REJECTED**: equivalence of statements says nothing about
    difficulty of proofs. DROP therefore rests on **tractability alone**: thinner than claimed,
    still sufficient. Recorded in STATE.md's attempt index so neither the confirmed result nor the
    rejected inference is re-walked.
  - **A supporting pillar was circular.** The "shrinking trend" evidence leaned on an all-width
    min-δ cell at n=10 whose true value requires *exactly the width ≥ 4 search being dropped*.
    Withdrawn as evidence for DROP.
  - **F1 [BROKEN], repaired:** Lemma 3.2b's boxed hypothesis said an automorphism *maps* x to y;
    the proof needs it to *swap* them. Counterexample at n=9 (`Aut(P) = Z/3`, δ = 79/159 < 1/2) —
    pm-onethird ran the committed witness, reproduces exactly.
  - **F3 was a defect in ALREADY-MERGED work** that the earlier mg-0eac audit missed — fixed at
    source, not just in the copy. Second time an audit has caught a prior audit's miss.
- **mg-4ad1 filed this sweep — the control scripts have ZERO CI coverage.** `lean.yml` filters on
  `paths: lean/**`, so there has been no CI run since 2026-05-21 despite a dozen commits; every
  Python artifact this week is uncovered, *including the mg-8489 gate control that proves the δ
  engine's gate can fail*. A control nothing invokes is indistinguishable from one that doesn't
  exist, and it fails reassuringly — the file is present and looks like coverage. Scoped to the
  fast self-checking controls only, with a requirement to prove the workflow can go red.
  **STATUS 2026-07-22: still `available`, correctly held.** Mayor's hold reads "until after the
  redeploy (2026-07-21 17:15 BST)" — the *clock* has passed but the *condition* has not: installed
  pogod is still `vcs.revision=249f349`, built 2026-07-17, so the redeploy has not happened. The
  hold stands and I am not pushing to release it. The gap it describes is independently confirmed
  still live: `one_third_width_three` has now gone **62 days without a CI run** while shipping the
  load-bearing δ engine and gate control. The redeploy itself is pm-pogo's ask, not mine to
  re-raise; noted here only because it now has a second-order cost inside this product.

## Standing context — the computation lift, and what it does NOT cover
- **Origin of mg-0eac:** Daniel filed it 2026-07-20 12:04Z and **lifted the no-computation hold for the counterexample search specifically**. Deliverable was always the **min-δ-per-size profile**, not a counterexample — a counterexample was judged unlikely and success was never indexed to it. Novel path = the proven "`δ<1/3` ⟹ coherent distinguished `e`" structure, which Peczarski did not use; exhaustive search ≤ n=11 is literature and was explicitly out of scope. *(Completed and audited — see Now, above.)*
- **The lift is scoped and remains so.** It covered the counterexample search only — it does **not** unblock the n=7 overlap test below. Treating it as a general lift would be inferring an instruction Daniel didn't give.
- **L1b crux still ball-with-Daniel.** Productive target unchanged: break the wrong-signed `(B-cov)` covariance / equivalently prove `ρ_s < 1` under freezing.
- **Two pending Daniel research calls** (offered, awaiting his word):
  1. **n=7 overlap test** — the one decisive check of the conditional-standard-dominance picture (overlap `c` at 3 known n=7 off-regime posets). **Still blocked**; needs its own narrow exception. Dataset-revert of the mg-4a86 over-run is held pending this call.
  2. **`O(1)` locality probe** — prove `Σ_{y∥x} Pr[{x,y} inverts] = O(1)` under freezing (mg-0ed7's residual; the `(B-bias)` lemma). Natural next swing at the crux.
- **STATE.md maintained on every verdict** (canonical; through **@400f474**, incl. Appendix A audit-stage process).

## Process (now live)
- **Independent pre-PM-review audit stage — LIVE** (mg-3a3a; template in STATE.md Appendix A). Every research deliverable with a math/[PROVEN] claim gets an independent audit polecat (mayor-dispatched) before pm-onethird's second-line review. Formalized after a pm-onethird audit missed an in-prose [PROVEN] reduction (mg-0ed7 7.5); mg-8f56 was this stage run manually and caught it. **Proved its worth on mg-0eac:** the audit rebuilt the instrument rather than reading the work, and caught that the commit subject overstated the result.
- **Two process defects found and fixed this cycle** (`b4da72d`):
  1. **Audit dispatch must file a work item and pass `--id`.** aud0eac was spawned id-less, so it had nothing to claim and no `mg done` — its completion was invisible to `mg` and depended on the polecat remembering to mail. Without an id a *silently failed* audit and a *completed* one are indistinguishable, and a research-gate that silently doesn't run makes unaudited claims read as audited.
  2. **The process doc's canonical path is now recorded absolutely.** mayor reported Appendix A "does not exist" and reconstructed a brief from memory; it existed and was current. Cause: mayor has *no repo workspace*, so a bare relative path resolves to nothing and fails as "absent" rather than as a visible error. The reconstructed brief worked out, but Appendix A §4 SCOPE CHECK asks exactly the question that became the audit's most valuable finding — the process would have prompted it.
- **Known defect in my own sweep, not yet fixed:** pm-template.md's friction-scan source (`~/.pogo/polecats/*/`) is reaped after each run — newest entry is from Apr 29 — so that grep matches nothing regardless of what polecats said, and reads as "no friction". Live transcripts are under `~/.claude/projects/-Users-daniel--pogo-polecats-<id>/*.jsonl`. Every past "no friction signal" line in my sweep log is therefore unsupported rather than a real negative. Template is Daniel's file; raising it in the next digest, overriding the path locally meanwhile.

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

## Recently shipped (2026-07-20/21 — the mg-0eac arc, all audited)
- **mg-0eac** — coherence-guided primitive low-δ search. Proven width-exactly-3 min δ = 6/17 at n=10 (n ≤ 11), extending Olson-Sagan; bounded beam to n=16 found nothing below β. Survived a fleet restart mid-flight: attempt 2 recovered attempt 1's committed *and* uncommitted state before starting, and re-ran the recovered engine's controls against Peczarski's published table rather than trusting it (7/7 pairs exact).
- **aud0eac** — independent audit, PASS-WITH-FINDINGS. Rebuilt the δ engine from scratch rather than reading the work; 5 findings, none changing a number; caught that the commit subject overstated the result (F1).
- **mg-8489** — audit follow-up. `fast_Q` added to the engine gate as M0 (F2: the stated control didn't cover the swept path), plus 4 scope/wording corrections. Control re-run by pm-onethird: 6/6, exit 0.

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
