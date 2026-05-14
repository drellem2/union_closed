# union_closed

Compatibility-geometry approach to the **Union-Closed Sets (Frankl) conjecture**.

This repository pursues the Union-Closed conjecture through the compatibility-geometry
program — the same structural lens applied to the 1/3–2/3 (Kahn–Saks) conjecture in the
sibling repositories `one_third` and `one_third_width_three`.

## The structural analogy

| 1/3–2/3 (Kahn–Saks)        | Union-Closed (Frankl)                  |
|----------------------------|----------------------------------------|
| Linear extensions `L(P)`   | Sets `A ∈ F`                           |
| Adjacent swaps             | Coordinate transports / involutions    |
| BK graph                   | Involution / transport graph           |
| Bruhat geometry            | Cubical geometry (Boolean cube)        |
| Order constraints          | Union closure                          |
| Pair-balance               | Coordinate-frequency balance           |
| Conductance obstruction    | Pairing obstruction                    |

In both settings: the ambient geometry is highly symmetric, admissible moves preserve
only part of that symmetry, local cancellation looks possible, but global cancellation
is conjecturally obstructed — plausibly a cohomological / curvature phenomenon arising
from the failure of local symmetries to globalize coherently.

**Moral:** compatibility constraints + local symmetry ⇒ forced global bias.

## Intrinsic object

The canonical intrinsic object is expected to be the inclusion poset `(F, ⊆)`, viewed as
a join-semilattice with order complex `Δ(F)`. Coordinate regions `U_x = {A : x ∈ A}` form
structured upsets / subsemilattices; a hypothetical counterexample would require a
globally compatible family of coordinatewise transport involutions
`φ_x : F_x ↪ F_x̄` — and the expectation is that these local transports fail to commute /
mix globally, producing curvature-like or cohomological defects.

## Status

Repository initialized 2026-05-14. First scoping work item (manifesto + framework setup)
to be filed by pm-onethird.

Owner: pm-onethird.
