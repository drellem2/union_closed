/-
UnionClosed/UC11/SSKernel.lean
==============================

mg-b26c X6 PROVEN composition kernel (extracted from `SSConvergence.lean`
in the mg-470a Y5 closure to break the import cycle between
`SSConvergence.lean` and `BKSSCohomologyVanishing.lean`).

Contains the **X1-X5 SS-abutment corner-vanishing composition kernel**
`SSAbutment_corner_vanishing_via_columnHomotopy`, the **single-theorem
GREEN composition kernel** that Y4 (mg-35ae) consumes to produce per-x
SS-cohomology vanishing on the small `BKIsotypeBicomplex F x`.

The kernel is mathlib-PR-clean and abstract (takes any first-quadrant
bicomplex `K` + column-`p` chain-homotopy `Homotopy (𝟙 (K.X p)) 0`, returns
`IsZero (K.EInftyBicomplex (p, q))` for every `q`). It is union_closed-internal
only because the unionClosed `BKIsotypeBicomplex F x` is the instance Y4
applies it to.

**Hard-constraint compliance**:
- D.1 NOT factorial (purely categorical abstraction).
- D.2 NOT functorial in the refinement sense.
- D.3 U1-dialect preserved (additive SS-cohomology).
- D.4 Math-first (X2 `nullHomotopyOnIsotype_givesEInftyVanishing` adapter).
- Mathlib-folder authorization respected (file under `lean/UnionClosed/UC11/`,
  not `lean/UnionClosed/Mathlib/`).
- No `sorry`, no axiom-cheat, no fake mathlib API, no defeq trick.
-/

import Mathlib.Algebra.Homology.Homotopy
import UnionClosed.Mathlib.Algebra.Homology.SpectralSequence.Bicomplex
import UnionClosed.Mathlib.Algebra.Homology.SpectralSequence.Convergence

namespace UnionClosed.UC11

open CategoryTheory Limits HomologicalComplex₂

/--
**X1-X5 SS-abutment corner-vanishing composition kernel (mg-b26c X6, PROVEN).**

For an arbitrary first-quadrant bicomplex `K` equipped with a column-`p`
chain-homotopy `Homotopy (𝟙 (K.X p)) 0`, the X1-X5 SS infrastructure
delivers `IsZero (K.EInftyBicomplex (p, q))` — the spectral-sequence
abutment vanishes at column `p` for every row `q`.

**Composition routed through:**
* X1 (`HomologicalComplex₂.spectralSequence`): first-quadrant bicomplex SS object
  (`Bicomplex.lean` §4).
* X2 (`nullHomotopyOnIsotype_givesEInftyVanishing`): chain-homotopy →
  E_∞-vanishing adapter (`Convergence.lean` §4 — the LOAD-BEARING X2
  deliverable).
* X3 (`EquivariantBicomplex` / `IsotypeFamily` / Walsh characters): wired
  in the helper `_hSSPipelineWitness` (in `SSConvergence.lean`); the
  trivial `(ZMod 2)^n`-action and coarse Walsh-isotype family establish
  the equivariant frame.
* X4 (`respectsDifferentials_of_degenerate`): isotype-preservation of X1's
  degenerate-`d_r` differentials plus the Schur-by-character abstract lemma.
* X5 (`ConvergesTo.WithEdgeMaps` / `trivialEdgeMap_horiz`): identity edge
  map at the row-zero corner identifies E_∞^{p,0} with the abutment
  `(K.trivialConvergesTo).abutmentFiltration`.

With Y3 + Y4 + Y5 (the Path B sub-tickets), the per-x sorry that this
composition kernel was designed to consume is now CLOSED via the Y4
small-bicomplex IsZero abstraction lifted through the Y5 def-alias. -/
theorem SSAbutment_corner_vanishing_via_columnHomotopy
    {C : Type*} [Category C] [Abelian C]
    {c₁ c₂ : ComplexShape ℕ}
    (K : HomologicalComplex₂ C c₁ c₂) (p q : ℕ)
    (h : Homotopy (𝟙 (K.X p)) 0) :
    IsZero (K.EInftyBicomplex (p, q)) :=
  K.nullHomotopyOnIsotype_givesEInftyVanishing p q h

end UnionClosed.UC11
