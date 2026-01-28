;; SPDX-License-Identifier: PMPL-1.0-or-later
;; STATE.scm - HackenbushGames.jl
;; Current state snapshot following hyperpolymath/state.scm spec

(define hackenbush-games-state
  '(
    (metadata
     (version "0.1.2")
     (schema-version "0.5.0")
     (created "2025-01-15")
     (updated "2026-01-28")
     (project "HackenbushGames.jl")
     (repo "github.com/hyperpolymath/HackenbushGames.jl"))

    (project-context
     (name "HackenbushGames.jl")
     (tagline "Combinatorial game theory toolkit for Hackenbush positions")
     (description
      "Julia library for experimenting with Hackenbush graphs, surreal numbers, nimbers, and combinatorial game positions. Based on Padraic Bartlett's 'A Short Guide to Hackenbush' (VIGRE REU 2006).")
     (tech-stack
      (languages ("Julia"))
      (core-systems
       ("Julia package" "combinatorial-game-theory" "graph-algorithms"))))

    (current-position
     (phase "alpha")
     (overall-completion 0.75)
     (components
      (red-blue-hackenbush
       (status "working")
       (completion 0.95)
       (notes "Stalk values, dyadic rationals, {L|R} forms all functional"))
      (green-hackenbush
       (status "working")
       (completion 0.85)
       (notes "Grundy numbers, nimbers, mex computation working. Limited to small graphs."))
      (graph-operations
       (status "working")
       (completion 0.80)
       (notes "Graph construction, edge cutting, pruning, sum composition working"))
      (visualization
       (status "working")
       (completion 0.70)
       (notes "GraphViz export and ASCII rendering functional"))
      (documentation
       (status "working")
       (completion 0.65)
       (notes "README and docstrings present. Needs tutorial examples."))
      (tests
       (status "working")
       (completion 0.80)
       (notes "21 tests covering core functionality. Need property-based tests.")))
     (working-features
      ("Red-Blue stalk evaluation"
       "Green Grundy number computation"
       "Graph sum composition"
       "Move generation for both players"
       "Canonical {L|R} game forms"
       "Dyadic rational simplification"
       "Nimber arithmetic (nim-sum, mex)"
       "GraphViz and ASCII export")))

    (route-to-mvp
     (milestones
      (
       (milestone "Core Game Theory"
        (completed? #t)
        (items
         ("Implement Red-Blue stalk values" . #t)
         ("Implement Green Grundy numbers" . #t)
         ("Implement {L|R} canonical forms" . #t)
         ("Add dyadic rational arithmetic" . #t)
         ("Add nimber operations" . #t)))

       (milestone "Graph Operations"
        (completed? #t)
        (items
         ("Graph construction and edge representation" . #t)
         ("Move generation for partisan games" . #t)
         ("Disconnected component pruning" . #t)
         ("Graph sum for disjoint unions" . #t)))

       (milestone "Visualization"
        (completed? #f)
        (items
         ("GraphViz DOT export" . #t)
         ("ASCII rendering" . #t)
         ("Interactive visualization" . #f)
         ("Position diagram generation" . #f)))

       (milestone "Advanced Features"
        (completed? #f)
        (items
         ("Colon principle implementation" . #f)
         ("Fusion rule implementation" . #f)
         ("Flower/jungle game forms" . #f)
         ("Game comparison operators" . #f)
         ("Temperature theory basics" . #f)))

       (milestone "Performance & Scale"
        (completed? #f)
        (items
         ("Optimize Grundy computation" . #f)
         ("Memoization improvements" . #f)
         ("Structural simplification rules" . #f)
         ("Parallel game evaluation" . #f)))

       (milestone "Documentation & Examples"
        (completed? #f)
        (items
         ("Tutorial notebook" . #f)
         ("Bartlett guide examples" . #f)
         ("API reference docs" . #f)
         ("Benchmarking suite" . #f))))))

    (blockers-and-issues
     (critical ())
     (high
      ("Green Grundy is exponential - only works for small graphs"
       "No structural simplification rules for large positions"
       "Missing game comparison and ordering operations"))
     (medium
      ("No interactive visualization"
       "Limited tutorial/example content"
       "No property-based testing"
       "Temperature theory not implemented"
       "Colon/fusion principles not coded"))
     (low
      ("ASCII visualization is basic"
       "No performance benchmarks"
       "Graph export only supports DOT format")))

    (critical-next-actions
     (immediate
      ("Add game comparison operators (<, >, ||, confused)"
       "Expand test coverage for edge cases"))
     (this-week
      ("Create tutorial notebook with examples from Bartlett guide"
       "Add structural simplification rules (dead branches, dominated moves)"
       "Implement game ordering and equivalence"))
     (this-month
      ("Add temperature theory basics"
       "Implement colon principle"
       "Create benchmarking suite"
       "Add property-based tests with QuickCheck patterns")))

    (session-history
     (
      ((date "2026-01-28")
       (focus "SCM file initialization")
       (accomplishments
        ("Created STATE.scm following spec"
         "Created ECOSYSTEM.scm with related projects"
         "Created META.scm with design rationale"))
       (next "Add game comparison operators and tutorial notebook"))))

    (notes
     ("Based on Padraic Bartlett's VIGRE REU 2006 guide"
      "Emphasizes transparency and teaching over heavy automation"
      "Grundy evaluation is intentionally simple/exponential for educational use"
      "Future work: structural simplifications, parallelization, temperature theory"))))

;; Helper: get overall completion percentage
(define (get-completion-percentage)
  (let ((components (assoc 'components (assoc 'current-position hackenbush-games-state))))
    0.75))

;; Helper: get all blockers
(define (get-blockers)
  (let ((blockers (assoc 'blockers-and-issues hackenbush-games-state)))
    blockers))

;; Helper: get specific milestone status
(define (get-milestone name)
  (let ((milestones (assoc 'milestones (assoc 'route-to-mvp hackenbush-games-state))))
    (assoc name milestones)))
