using Test
using HackenbushGames

@testset "HackenbushGames" begin
    @testset "Stalk Values" begin
        @test stalk_value([Blue]) == 1//1
        @test stalk_value([Red]) == -1//1
        @test stalk_value([Blue, Red]) == 1//2
        @test stalk_value([Blue, Red, Blue]) == 3//4
        @test stalk_value([Red, Blue, Red]) == -3//4
    end

    @testset "Green Grundy" begin
        edges = [
            Edge(0, 1, Green),
            Edge(1, 2, Green),
        ]
        g = HackenbushGraph(edges, [0])
        @test green_grundy(g) == 2
    end

    @testset "Moves" begin
        edges = [
            Edge(0, 1, Blue),
            Edge(1, 2, Red),
        ]
        g = HackenbushGraph(edges, [0])
        @test length(moves(g, :left)) == 1
        @test length(moves(g, :right)) == 1
    end

    @testset "Graph Sum" begin
        a = simple_stalk([Blue, Red])
        b = simple_stalk([Green])
        s = game_sum(a, b)
        @test length(s.edges) == length(a.edges) + length(b.edges)
    end

    @testset "GraphViz" begin
        g = simple_stalk([Green])
        dot = to_graphviz(g)
        @test occursin("graph Hackenbush", dot)
    end

    @testset "Canonical Form" begin
        g = simple_stalk([Blue])
        value = game_value(g)
        @test value == 1//1
        form = canonical_game(g)
        @test isempty(form.right)
    end

    @testset "ASCII" begin
        g = simple_stalk([Red, Blue])
        ascii = to_ascii(g)
        @test occursin("HackenbushGraph", ascii)
    end
end
