# SPDX-License-Identifier: MPL-2.0
# (PMPL-1.0-or-later preferred; MPL-2.0 required for Julia ecosystem)
# BenchmarkTools benchmarks for HackenbushGames.jl
# Measures stalk value computation, Grundy number, move generation, and game sum
# at small/medium/large positions.

using BenchmarkTools
using HackenbushGames

# ── Stalk benchmarks ──────────────────────────────────────────────────────────

# Small stalk: 4 edges
small_colors  = [Blue, Red, Blue, Red]
# Medium stalk: 12 edges (alternating)
medium_colors = repeat([Blue, Red], 6)
# Large stalk: 30 edges
large_colors  = [iseven(i) ? Blue : Red for i in 1:30]

println("=== stalk_value (small: 4 edges) ===")
@benchmark stalk_value($small_colors)

println("=== stalk_value (medium: 12 edges) ===")
@benchmark stalk_value($medium_colors)

println("=== stalk_value (large: 30 edges) ===")
@benchmark stalk_value($large_colors)

# ── game_value benchmarks ─────────────────────────────────────────────────────

stalk_small  = simple_stalk(small_colors)
stalk_medium = simple_stalk(medium_colors)
stalk_large  = simple_stalk(large_colors)

println("=== game_value (small: 4-edge stalk) ===")
@benchmark game_value($stalk_small)

println("=== game_value (medium: 12-edge stalk) ===")
@benchmark game_value($stalk_medium)

println("=== game_value (large: 30-edge stalk) ===")
@benchmark game_value($stalk_large)

# ── Green Grundy benchmarks ───────────────────────────────────────────────────

# Small: single chain of 5 green edges
edges_5  = [Edge(i-1, i, Green) for i in 1:5]
g_5      = HackenbushGraph(edges_5,  [0])
# Medium: chain of 15 green edges
edges_15 = [Edge(i-1, i, Green) for i in 1:15]
g_15     = HackenbushGraph(edges_15, [0])
# Large: chain of 30 green edges
edges_30 = [Edge(i-1, i, Green) for i in 1:30]
g_30     = HackenbushGraph(edges_30, [0])

println("=== green_grundy (small: 5-edge chain) ===")
@benchmark green_grundy($g_5)

println("=== green_grundy (medium: 15-edge chain) ===")
@benchmark green_grundy($g_15)

println("=== green_grundy (large: 30-edge chain) ===")
@benchmark green_grundy($g_30)

# ── Nim sum benchmarks ────────────────────────────────────────────────────────

nim_small  = rand(1:15, 5)
nim_medium = rand(1:63, 20)
nim_large  = rand(1:255, 100)

println("=== nim_sum (small: 5 values) ===")
@benchmark nim_sum($nim_small)

println("=== nim_sum (medium: 20 values) ===")
@benchmark nim_sum($nim_medium)

println("=== nim_sum (large: 100 values) ===")
@benchmark nim_sum($nim_large)
