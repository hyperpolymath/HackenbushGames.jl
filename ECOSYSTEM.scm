;; SPDX-License-Identifier: PMPL-1.0-or-later
;; ECOSYSTEM.scm - HackenbushGames.jl
;; Describes how HackenbushGames.jl relates to other hyperpolymath projects
;; Media type: application/vnd.ecosystem+scm

(ecosystem
 (version "0.1.0")
 (name "HackenbushGames.jl")
 (type "library")
 (purpose "Combinatorial game theory toolkit for Hackenbush graphs and positions")

 (position-in-ecosystem
  "HackenbushGames.jl provides tools for analyzing partisan and impartial combinatorial games
   through the lens of Hackenbush graph positions. It implements surreal number arithmetic,
   nimber computation, and canonical game forms. The library emphasizes educational transparency
   and serves as a reference implementation of Padraic Bartlett's Hackenbush concepts.

   While focused on a specific game (Hackenbush), the techniques generalize to broader
   combinatorial game theory, strategic reasoning, and graph-based decision problems.")

 (related-projects
  (
   (name "KnotTheory.jl")
   (relationship "sibling-standard")
   (rationale
    "Both projects explore combinatorial structures with deep mathematical properties.
     KnotTheory analyzes topological invariants; HackenbushGames analyzes game-theoretic values.
     Both use graph representations and combinatorial algorithms. Potential integration:
     analyzing knot diagrams as game positions or using game values as knot invariants.")

   (name "Exnovation.jl")
   (relationship "inspiration")
   (rationale
    "Exnovation focuses on strategic removal and creative destruction. Hackenbush is fundamentally
     about strategic edge removal from graphs. The philosophy of 'progress through removal'
     connects both projects. Game-theoretic analysis of removal strategies could inform
     exnovation metrics.")

   (name "Causals.jl")
   (relationship "potential-consumer")
   (rationale
    "Causals could use game-theoretic analysis for causal intervention strategies. Hackenbush
     games model sequential decision-making under perfect information. Causal DAGs could be
     analyzed as game positions where interventions are moves. Grundy numbers might characterize
     causal complexity.")

   (name "BowtieRisk.jl")
   (relationship "potential-consumer")
   (rationale
    "Risk mitigation can be framed as a game between attacker and defender. Bowtie diagrams
     represent threat/consequence pathways that could be modeled as Hackenbush positions.
     Game values could quantify defensive position strength. Nimber sums could aggregate
     independent risk scenarios.")

   (name "PolyglotFormalisms.jl")
   (relationship "potential-consumer")
   (rationale
    "Game-theoretic semantics could be formalized using polyglot approaches. Hackenbush positions
     represent formal games with precise winning/losing semantics. Could provide game semantics
     for verification or interactive proof tactics.")))

 (what-this-is
  "A Julia library implementing Hackenbush combinatorial game theory including:
   - Red-Blue (partisan) and Green (impartial) Hackenbush games
   - Dyadic rational evaluation via {L|R} canonical forms
   - Grundy number computation for impartial positions
   - Nimber arithmetic (nim-sum, mex, game sums)
   - Graph operations (edge cutting, pruning, composition)
   - Visualization (GraphViz DOT, ASCII)

   Educational focus with transparent algorithms suitable for teaching combinatorial game theory.")

 (what-this-is-not
  "NOT a general combinatorial game theory library (focused on Hackenbush specifically).
   NOT optimized for large-scale games (Grundy evaluation is exponential).
   NOT a game-playing AI or strategy engine (analysis tools only).
   NOT a graph theory library (specialized for game positions).
   NOT a visualization framework (minimal export capabilities).
   NOT a formal verification tool (informal game analysis)."))
