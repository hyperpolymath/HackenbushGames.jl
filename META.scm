;; SPDX-License-Identifier: PMPL-1.0-or-later
;; META.scm - HackenbushGames.jl
;; Meta-level design decisions, philosophy, and architectural documentation
;; Media type: application/meta+scheme

(define meta
  '(
    (project-metadata
     (name "HackenbushGames.jl")
     (version "0.1.0")
     (created "2025-01-15")
     (last-updated "2026-01-28")
     (maintainer "Jonathan D.A. Jewell <jonathan.jewell@open.ac.uk>")
     (license "PMPL-1.0-or-later"))

    (architecture-decisions
     (
      (adr-001
       (status "accepted")
       (date "2025-01-15")
       (title "Educational transparency over performance optimization")
       (context
        "Combinatorial game theory is complex and often taught with opaque algorithms.
         The Grundy number computation for Hackenbush can be optimized with structural
         simplifications, but this obscures the underlying recursive definition.")
       (decision
        "Implement algorithms in their most transparent form, even when exponential.
         Document limitations clearly. Provide references to the underlying theory
         (Bartlett's guide). Optimization can be added later without changing the API.")
       (consequences
        "Positive: Code serves as executable documentation. Easy to verify correctness.
         Suitable for teaching and experimentation.
         Negative: Grundy evaluation limited to small graphs (~10 edges). Not suitable
         for production game-playing systems without optimization."))

      (adr-002
       (status "accepted")
       (date "2025-01-15")
       (title "Separate partisan (Red-Blue) and impartial (Green) evaluation")
       (context
        "Hackenbush has two major variants: partisan Red-Blue games (surreal numbers)
         and impartial Green games (nimbers). They require fundamentally different
         evaluation strategies.")
       (decision
        "Provide distinct functions: stalk_value for Red-Blue, green_grundy for Green.
         Use {L|R} canonical forms for partisan games. Use Grundy numbers for impartial games.
         Allow mixed-color graphs but require explicit player choice.")
       (consequences
        "Positive: Clear separation of concerns. Each evaluation method is simple.
         API matches textbook presentations.
         Negative: Mixed Red-Blue-Green graphs require manual decomposition. No automatic
         strategy selection."))

      (adr-003
       (status "accepted")
       (date "2025-01-15")
       (title "Use dyadic rationals (Rational{Int}) for game values")
       (context
        "Hackenbush game values are surreal numbers, but stalks evaluate to dyadic rationals
         (fractions with power-of-2 denominators). Julia's Rational{Int} type provides exact arithmetic.")
       (decision
        "Represent all numeric game values as Rational{Int}. Use simplest_dyadic_between
         to find canonical representatives. Avoid floating-point approximations.")
       (consequences
        "Positive: Exact arithmetic. Matches game theory conventions. No rounding errors.
         Negative: Limited to dyadic rationals (not all surreals). Rationals can grow large
         for deep games."))

      (adr-004
       (status "accepted")
       (date "2025-01-15")
       (title "Graph representation as edge list with ground nodes")
       (context
        "Hackenbush positions are graphs with distinguished ground nodes. Need to support
         edge cutting, connectivity pruning, and graph sums.")
       (decision
        "Represent graphs as HackenbushGraph(edges::Vector{Edge}, ground::Vector{Int}).
         Nodes are integers. Edges store endpoints and color. Provide prune_disconnected
         after each edge cut.")
       (consequences
        "Positive: Simple representation. Easy to modify. Efficient for small graphs.
         Negative: No adjacency structure (recomputed for each operation). Not optimized
         for large graphs. Node numbering can become sparse after cuts."))

      (adr-005
       (status "accepted")
       (date "2025-01-15")
       (title "Minimal dependencies - pure Julia implementation")
       (context
        "The package could depend on Graphs.jl, GameTheory.jl, or other libraries.
         However, the algorithms are simple enough to implement directly.")
       (decision
        "Implement all core functionality in pure Julia with no dependencies. Use only
         Julia stdlib (Test for testing). Keep the codebase self-contained and auditable.")
       (consequences
        "Positive: No dependency conflicts. Easy to audit. Fast installation. Educational
         transparency (all code visible).
         Negative: Reinventing some graph algorithms. No interop with existing game theory
         or graph libraries."))

      (adr-006
       (status "proposed")
       (date "2026-01-28")
       (title "Add game comparison operators for position ordering")
       (context
        "Combinatorial game theory defines comparison operators: G > H, G || H (confused),
         G = H. These are essential for game analysis but not yet implemented.")
       (decision
        "Extend GameForm with comparison operators based on {L|R} forms. Implement >, <,
         ==, and || (fuzzy/confused) relations. Use these for move selection and
         simplification.")
       (consequences
        "Positive: Complete API for game analysis. Enables strategic reasoning. Matches
         textbook presentations.
         Negative: Comparison is itself a recursive game evaluation. May be expensive for
         deep games. Requires careful handling of infinitesimals and incomparable games."))))

    (development-practices
     (code-style
      (format "JuliaFormatter defaults")
      (naming-conventions
       ("snake_case for functions and variables"
        "CamelCase for types and modules"
        "UPPERCASE for enums (EdgeColor: Blue, Red, Green)"
        "Descriptive names over abbreviations (e.g., stalk_value not sv)"))
      (comments
       ("Docstrings for all exported functions"
        "Inline comments for complex algorithms (e.g., simplest_dyadic_between)"
        "References to Bartlett guide sections where applicable")))
     (security
      (practices
       ("SPDX license headers on all source files"
        "No external dependencies (minimal attack surface)"
        "No network access or file I/O (except explicit GraphViz export)"
        "Integer overflow protection via Julia's arbitrary-precision Rational{Int}")))
     (testing
      (framework "Julia Test stdlib")
      (coverage "~80% line coverage via 21 unit tests")
      (strategy
       ("Unit tests for each exported function"
        "Known examples from Bartlett guide"
        "Edge cases: empty graphs, single edges, disconnected graphs"
        "Future: Property-based testing for game identities (e.g., G + (-G) = 0)"))
      (ci-pipeline
       ("GitHub Actions for Julia 1.9+ on Linux/macOS/Windows"
        "Automated test runs on push/PR"
        "No coverage reporting yet")))
     (versioning
      (scheme "SemVer 0.x.y during alpha")
      (current "0.1.0")
      (stability "Alpha - API may change"))
     (documentation
      (primary "README.adoc with quick start and API overview")
      (docstrings "Present for all exported functions")
      (examples "Inline in README and test suite")
      (tutorial "Planned - Jupyter notebook with Bartlett guide examples")
      (api-reference "Future - Documenter.jl docs"))
     (branching
      (model "GitHub Flow (main + feature branches)")
      (protection "Branch protection on main (requires reviews)")
      (ci-requirements "All tests must pass before merge")))

    (design-rationale
     (why-julia
      "Julia combines mathematical notation, performance, and simplicity. Game theory
       algorithms map naturally to Julia syntax. Rational{Int} type provides exact
       arithmetic. Julia's package system makes distribution easy.")

     (why-hackenbush-specifically
      "Hackenbush is a canonical example in combinatorial game theory education. It
       illustrates surreal numbers, nimbers, game sums, and canonical forms. The game
       is simple to explain but rich enough to demonstrate advanced concepts. Bartlett's
       guide provides an accessible introduction.")

     (why-not-general-cgt-library
      "General combinatorial game theory libraries become complex quickly (infinitesimals,
       temperatures, loopy games, etc.). By focusing on Hackenbush, we can keep the
       implementation simple and educational. Future work could generalize, but starting
       narrow ensures correctness and clarity.")

     (why-explicit-evaluation-not-ai
      "This is a library for analyzing games, not playing them. AI/strategy engines require
       heuristics, search algorithms, and optimization. Those concerns are orthogonal to
       the core game theory. By providing exact evaluation tools, we enable others to
       build strategies on top.")

     (why-no-performance-optimization
      "Premature optimization obscures algorithms. The current implementation is exponential
       but matches textbook definitions exactly. This makes verification easy and serves
       educational goals. Performance optimization (memoization, structural simplification,
       parallelization) can be added incrementally without changing the core API."))

    (cross-cutting-concerns
     (error-handling
      "Errors raise exceptions with descriptive messages (e.g., 'player must be :left or :right').
       No silent failures. Invalid inputs (e.g., l >= r in simplest_dyadic_between) are caught early.")
     (performance
      "Not a priority during alpha. Grundy evaluation is O(2^edges) intentionally.
       Future work: structural simplifications, parallel evaluation, memoization improvements.")
     (extensibility
      "API designed for extension: GameForm can be extended with comparison operators,
       HackenbushGraph can support metadata, visualization can add new formats.
       Core types are simple structs - easy to wrap or extend.")
     (internationalization
      "Not applicable - mathematical notation is universal. Error messages in English.")
     (accessibility
      "ASCII visualization provides text-only output. GraphViz DOT format supports visual tools.
       Future: Consider screen-reader-friendly game descriptions."))

    (future-vision
     (short-term
      ("Add game comparison operators"
       "Implement colon principle and fusion rules"
       "Create tutorial notebook with Bartlett examples"
       "Add property-based tests"))
     (medium-term
      ("Temperature theory basics"
       "Structural simplification rules (dead branches, dominated moves)"
       "Parallel Grundy evaluation"
       "Interactive visualization (Pluto.jl or web UI)"))
     (long-term
      ("Generalize beyond Hackenbush (e.g., domineering, nim, go endgames)"
       "Loopy game support"
       "Infinitesimal game forms"
       "Strategy synthesis / AI player framework"
       "Integration with formal verification tools")))))
