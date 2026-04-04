# SPDX-License-Identifier: MPL-2.0
# (PMPL-1.0-or-later preferred; MPL-2.0 required for Julia ecosystem)
# E2E pipeline tests for HackenbushGames.jl
# Tests full game analysis workflows: graph construction → value/nimber computation →
# move generation → visualisation → game sum.

using Test
using HackenbushGames

@testset "E2E Pipeline Tests" begin

    @testset "Full pipeline: Blue-Red Hackenbush stalk analysis" begin
        # 1. Build a stalk (Blue, Red, Blue) — value should be 3/4
        stalk = simple_stalk([Blue, Red, Blue])
        @test stalk isa HackenbushGraph
        @test length(stalk.edges) == 3

        # 2. Compute game value
        val = game_value(stalk)
        @test val == 3//4

        # 3. Check moves available to each player
        left_moves  = moves(stalk, :left)
        right_moves = moves(stalk, :right)
        @test length(left_moves)  >= 1
        @test length(right_moves) >= 1

        # 4. Canonical form
        form = canonical_game(stalk)
        @test form isa CanonicalGame

        # 5. GraphViz export
        dot = to_graphviz(stalk)
        @test occursin("graph Hackenbush", dot)

        # 6. ASCII export
        ascii = to_ascii(stalk)
        @test occursin("HackenbushGraph", ascii)
    end

    @testset "Full pipeline: Green Hackenbush (impartial game)" begin
        # Green Hackenbush: two edges above ground = Grundy number 2
        edges = [Edge(0, 1, Green), Edge(1, 2, Green)]
        g = HackenbushGraph(edges, [0])

        # 1. Grundy number (nimber) calculation
        nimber = green_grundy(g)
        @test nimber == 2

        # 2. Both players have the same moves (impartial)
        left_moves  = moves(g, :left)
        right_moves = moves(g, :right)
        @test length(left_moves)  == length(right_moves)

        # 3. Nim-value composition
        # Two separate single-edge green graphs → nim sum = 1 XOR 1 = 0
        @test nim_sum([1, 1]) == 0

        # 4. Three green edges: Grundy 3 = winning position for next player
        edges3 = [Edge(0, i, Green) for i in 1:3]
        g3 = HackenbushGraph(edges3, [0])
        @test green_grundy(g3) == 3

        # 5. GraphViz export of green graph
        dot = to_graphviz(g)
        @test occursin("graph Hackenbush", dot)
    end

    @testset "Full pipeline: game sum and pruning" begin
        # Build two separate stalks and combine them
        stalk_a = simple_stalk([Blue])        # value = 1
        stalk_b = simple_stalk([Red])         # value = -1
        combined = game_sum(stalk_a, stalk_b)

        @test length(combined.edges) == length(stalk_a.edges) + length(stalk_b.edges)

        # Build graph with disconnected (floating) edge and prune it
        edges = [
            Edge(0, 1, Blue),  # connected to ground node 0
            Edge(5, 6, Red),   # floating — not reachable from ground
        ]
        g_with_float = HackenbushGraph(edges, [0])
        pruned = prune_disconnected(g_with_float)
        @test length(pruned.edges) == 1
        @test pruned.edges[1].color == Blue
    end

    @testset "Error handling: invalid dyadic query" begin
        # l >= r should throw
        @test_throws ErrorException simplest_dyadic_between(1//1, 0//1)
        @test_throws ErrorException simplest_dyadic_between(3//4, 3//4)
    end

    @testset "Round-trip consistency: stalk_value vs game_value" begin
        # For a Blue-only stalk of length n, both methods should agree
        for n in 1:5
            stalk = simple_stalk([Blue for _ in 1:n])
            sv = stalk_value([Blue for _ in 1:n])
            gv = game_value(stalk)
            @test sv == gv
        end

        # For a Red-only stalk of length n
        for n in 1:4
            stalk = simple_stalk([Red for _ in 1:n])
            sv = stalk_value([Red for _ in 1:n])
            gv = game_value(stalk)
            @test sv == gv
        end
    end

end
