# SPDX-License-Identifier: MPL-2.0
# (PMPL-1.0-or-later preferred; MPL-2.0 required for Julia ecosystem)
# Property-based tests for HackenbushGames.jl
# Verifies combinatorial game theory invariants across random positions.

using Test
using HackenbushGames

@testset "Property-Based Tests" begin

    @testset "Invariant: nim_sum of identical values is 0 (XOR)" begin
        for _ in 1:50
            v = rand(1:63)
            @test nim_sum([v, v]) == 0
        end
    end

    @testset "Invariant: nim_sum is associative and commutative" begin
        for _ in 1:50
            a, b, c = rand(0:15), rand(0:15), rand(0:15)
            @test nim_sum([a, b, c]) == nim_sum([c, b, a])
            @test nim_sum([a, b, c]) == nim_sum([nim_sum([a, b]), c])
        end
    end

    @testset "Invariant: mex is always the smallest non-negative excluded integer" begin
        for _ in 1:50
            n = rand(0:15)
            # Take a random subset of {0..n-1}
            full = collect(0:n)
            removed = rand(full)
            subset  = filter(x -> x != removed, full)
            # The mex of subset should be the missing element (removed)
            @test mex(subset) == removed
        end
    end

    @testset "Invariant: green_stalk_nimber(n) == n" begin
        for _ in 1:50
            n = rand(0:30)
            @test green_stalk_nimber(n) == n
        end
    end

    @testset "Invariant: simplest_dyadic_between(l,r) is strictly between l and r" begin
        for _ in 1:50
            # Generate two random distinct rationals with power-of-2 denominators
            den = 2^rand(1:4)
            num_l = rand(0:(den-2))
            num_r = num_l + 1
            l = num_l // den
            r = num_r // den
            if l < r
                mid = simplest_dyadic_between(l, r)
                @test l < mid < r
            end
        end
    end

    @testset "Invariant: prune_disconnected never produces more edges than input" begin
        for _ in 1:50
            n_connected  = rand(1:4)
            n_floating   = rand(0:3)
            connected    = [Edge(0, i, Blue) for i in 1:n_connected]
            # Floating edges use node IDs that don't include 0
            floating = [Edge(100+2*i, 101+2*i, Red) for i in 1:n_floating]
            g = HackenbushGraph(vcat(connected, floating), [0])
            pruned = prune_disconnected(g)
            @test length(pruned.edges) <= length(g.edges)
            @test length(pruned.edges) == n_connected
        end
    end

end
