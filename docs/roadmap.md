# pm-onethird product roadmap (1/3-2/3 + Union-Closed compatibility-geometry program)

*Updated by pm-onethird on 2026-07-19 17:00 BST — evening sweep (digest SILENT: Daniel was live in a full-day conceptual session, so a status mail would be pure noise). **Canonical current doc is STATE.md in github.com/drellem2/onethird_program (in config; the roadmap will consolidate there on restart).** Today: 7 arcs filed+merged+archived — entropy-discontinuity (mg-a1ec diagnostic; mg-48ab folklore-endpoint proof; mg-dcae REFUTED the external k=1-stability residual + gave the variance/bias (B) split) and 4 isolated entropy probes (A frozen-constraint INERT, B position-matrix proven bound, C direct-count proves conj for s≤2 + 5/18 on part of s=3, D incomparability-graph inert+insufficient). Every one adversarially audited before it touched the canonical doc or Daniel. Frankl stays shelved. Fleet idle by directive. Manual edits will be overwritten next sweep.*

**Scope.** Repos: union_closed, one_third_width_three, one_third — **plus the new `onethird_program`** (canonical state, pending config add). Tags: onethird, one-third, lean, audit, union-closed, frankl.

**Headline (2026-07-19).** The L1b crux is now cleanly mapped and the whole program is one document.

- **Canonical State of the Wall — built and in a repo.** github.com/drellem2/onethird_program (STATE.md) + interactive artifact (claude.ai/code/artifact/ab5fcd05-...). Two axes (near-ordinal-sumness vs the balance constant delta), the proof chain (proven links vs the one open link, L1b), the single lemma, and an attempt index so nothing gets re-walked. This is the new READ-FIRST canonical picture; roadmap.md here stays the operational sweep artifact until `onethird_program` is in my config.
- **The wall converges to ONE open theorem.** Everything — the (B)/LIB anti-concentration, the convexity route, the entropy-discontinuity idea, and Brightwell's open "can delta -> 1/3?" — reduces to: *a real poset's uniform / connected / order-polytope structure forces the slot probabilities to decay (rho_s < 1).* Convexity dispenses the two-atom witness but is silent on the flat slot law (the real LIB-violator); the untried tool is Aleksandrov-Fenchel / the combinatorial atlas (Chan-Pak-Panova), never aimed at the 1/3 gap.
- **Elementary "why 1/3" anchor — PROVEN.** Pr[x<y]+Pr[y<z]+Pr[z<x] <= 2 forbids any strong 3-cycle, so at delta<1/3 every pair-orientation coheres into one total order (the distinguished e); 2/3 is exactly that 3-cycle threshold = delta = 1/3. This is the elementary reason the conjecture's number is 1/3, and it anchors Daniel's entropy-discontinuity angle — which a 4-way literature search confirmed is NOVEL. The gap above 1/3 is proven only for width-2 (Sah, arXiv:1811.01500) by opaque casework with no reason given.

Two human-action items pending on Daniel (mg-344a, mg-b8f9). No URGENT signals. No CI failures (one_third's April red is stale, superseded; one_third_width_three main green 05-21). No releases (research repos).

---

## Now — Daniel attempting the crux, now fully characterized
- **Ball with Daniel, sharper target than before.** The L1b core lemma (mg-69be, handed off 07-15) is unchanged as Daniel's to prove, but the overnight session located it precisely: it IS the poset-LE displacement anti-concentration (no heavy tail / linear inversions), and the productive attack is real-poset **convexity / order-polytope** structure forcing the decay — the same statement in every dialect we tried (convexity, entropy-discontinuity, Brightwell). No polecat dispatched; Daniel's no-new-computation directive stands.
- **State doc maintained on every verdict** (STATE.md). This morning's regen folds in the elementary anchor + Sah width-2 gap + novelty.

## Next (queued, contingent on Daniel)
- **Config add:** Daniel adds `onethird_program` to pm-onethird `repos` so I maintain STATE.md in sweeps automatically (offered in this morning's update mail).
- **Daniel's call on the convergent theorem:** attempt the convexity/AF anti-concentration himself, or signal a polecat arc (would lift the no-computation hold). Reserve routes unchanged: BK-transport L1; dedicated anti-concentration arc.

## Later (contingent)
- **If the anti-concentration theorem closes:** L1b closes at any width -> M1 close-out audit + Lean follow-on (two-milestones plan).
- **Entropy-discontinuity as a Brightwell attack:** if the coherence-forces-discontinuity mechanism can be made precise (the open step: coherence + realizability => the gap), it is a novel angle on a named open problem — potentially bigger than L1b alone.
- **Frankl, pending mg-38ba fork:** RELAXED -> file (O3)+(O4); STRICT -> pivot proposal. Both pre-scoped, unfiled until Daniel unshelves.

## Backlog / pending on Daniel (human-action)
- **Frankl track SHELVED** (Daniel directive 2026-07-15). mg-38ba shelved; mg-1131 shelved (resolved).
- **mg-344a** — Daniel-only conceptual scratch-space (Option-alpha bridge theorem). Awaits Daniel.
- **mg-b8f9** — Hopkins (#2) outreach email; drafted. Send = Daniel's call.

## Recently shipped
- **State of the Wall doc + `onethird_program` repo** — 2026-07-19, committed public (2 commits: initial + elementary-anchor update). The canonical program map.
- (No mg tickets merged since 07-15; overnight work was research/conceptual, captured in STATE.md + PM memory.)

## Hygiene / gaps I'm watching
- **Two roadmap/state artifacts now:** STATE.md (onethird_program, canonical, maintained) supersedes both this union_closed roadmap.md (operational sweep artifact) and the stale one_third_width_three/docs/roadmap.md (~64 days old). Once `onethird_program` is in config, consolidate: STATE.md canonical, retire the width-3 one, keep a thin roadmap for Now/Next.
- **one_third_width_three local checkout still off-main/dirty** (branch mayor-a5-g2-status, behind origin/main). origin/main healthy, refinery green — a stale worktree, not a content problem. Not touched.
- **Lean residuals steady** — the load-bearing sorries are the expected M2-formalization gaps, gated behind the open L1b math. No new sorry; no CI regression.

## Trajectory
- **One-third:** a big conceptual night. The wall went from "one named residual" to a fully-mapped single open theorem with three convergent windows (convexity, entropy-discontinuity, Brightwell), an elementary proven anchor for why 1/3, a named untried tool (AF/combinatorial atlas), and a canonical doc in a repo. No tokens spent on polecats (Daniel-driven + no-compute posture) — pure characterization progress.
- **Frankl:** unchanged, shelved at its reserved canonicity fork.
- **Health:** no CI failures on any repo; sorry/admit steady; no releases (research repos). Fleet idle by directive.
