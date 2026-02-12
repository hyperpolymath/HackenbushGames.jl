;; SPDX-License-Identifier: PMPL-1.0-or-later
;; STATE.scm for HackenbushGames.jl
;; Format: https://github.com/hyperpolymath/elegant-STATE

(define state
  '((metadata
     (project . "HackenbushGames.jl")
     (version . "1.0.0")
     (updated . "2026-02-12")
     (maintainers . ("Jonathan D.A. Jewell <jonathan.jewell@open.ac.uk>")))

    (project-context
     (description . "Combinatorial game theory toolkit for Hackenbush positions")
     (domain . "mathematics-game-theory")
     (languages . ("Julia"))
     (primary-purpose . "Analyze and evaluate Hackenbush graphs with dyadic rational values"))

    (current-position
     (phase . "implementation")
     (overall-completion . 62)
     (working-features
       "Edge and HackenbushGraph types"
       "EdgeColor enum (Blue, Red, Green)"
       "Pruning disconnected components"
       "Cutting edges"
       "Valid move enumeration"
       "Game sum operations"
       "Dyadic rational arithmetic"
       "Stalk value calculation"
       "Mex and nim_sum for nimbers"
       "Green stalk nimber computation"
       "Green Grundy number evaluation"))

    (route-to-mvp
     (completed-milestones
       "Core data structures"
       "Graph manipulation primitives"
       "Blue/Red evaluation via dyadic rationals"
       "Green edge handling via Grundy nimbers"
       "Basic test suite")
     (next-milestones
       "Complete RSR template cleanup"
       "Add comprehensive API documentation"
       "Create example notebooks"
       "Add performance benchmarks"))

    (blockers-and-issues
     (technical-debt
       "Template placeholders in CONTRIBUTING.md, CODE_OF_CONDUCT.md, SECURITY.md"
       "Missing docs/src/api.md for Documenter.jl"
       "Incomplete docs/src/index.md (says 'examples coming soon')"
       "CITATIONS.adoc references wrong repo/author"
       "AI.a2ml has wrong SCM path"
       "ABI/FFI layer is non-functional template code"
       "Unrelated example files from RSR template"
       "ROADMAP.adoc is generic template"
       "License headers need SPDX-Identifier fixes")
     (known-issues
       "None - core Julia functionality is solid"))

    (critical-next-actions
     (immediate
       "Complete all 17 SONNET-TASKS"
       "Create .machine_readable/ with SCM files (this task)"
       "Replace template placeholders in docs"
       "Create API documentation"
       "Fix AI.a2ml paths")
     (short-term
       "Add Jupyter notebook examples"
       "Performance benchmarks for large graphs"
       "Expand test coverage for edge cases")
     (long-term
       "Integrate with BowtieRisk.jl for decision analysis"
       "Add visualization export (DOT format)"
       "Research GPU acceleration for large graphs"
       "Create interactive web playground"))

    (session-history
     (sessions
       ((date . "2026-02-12")
        (agent . "Claude Sonnet 4.5")
        (summary . "Fixed Manifest.toml version, started .machine_readable/ directory creation")
        (completion-delta . +1))))))

;; Helper functions for querying state

(define (get-completion-percentage state)
  (cdr (assoc 'overall-completion (assoc 'current-position state))))

(define (get-blockers state)
  (cdr (assoc 'blockers-and-issues state)))

(define (get-next-actions state)
  (cdr (assoc 'critical-next-actions state)))
