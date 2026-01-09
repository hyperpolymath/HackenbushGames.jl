module HackenbushGames

export EdgeColor, Edge, HackenbushGraph
export Blue, Red, Green
export prune_disconnected, cut_edge, moves
export simplest_dyadic_between, stalk_value
export mex, nim_sum, green_stalk_nimber, green_grundy

@enum EdgeColor Blue Red Green

"""
Represents a colored edge between two nodes.
"""
struct Edge
    u::Int
    v::Int
    color::EdgeColor
end

"""
Represents a Hackenbush position as an edge list and a ground node.
"""
struct HackenbushGraph
    edges::Vector{Edge}
    ground::Int
end

function _neighbors(edges::Vector{Edge})
    neighbors = Dict{Int, Vector{Int}}()
    for e in edges
        push!(get!(neighbors, e.u, Int[]), e.v)
        push!(get!(neighbors, e.v, Int[]), e.u)
    end
    neighbors
end

"""
Remove edges disconnected from the ground node.
"""
function prune_disconnected(graph::HackenbushGraph)
    neighbors = _neighbors(graph.edges)
    reachable = Set{Int}()
    stack = [graph.ground]
    while !isempty(stack)
        node = pop!(stack)
        if node in reachable
            continue
        end
        push!(reachable, node)
        for n in get(neighbors, node, Int[])
            if !(n in reachable)
                push!(stack, n)
            end
        end
    end

    edges = Edge[]
    for e in graph.edges
        if (e.u in reachable) && (e.v in reachable)
            push!(edges, e)
        end
    end
    HackenbushGraph(edges, graph.ground)
end

"""
Cut a specific edge and prune disconnected components.
"""
function cut_edge(graph::HackenbushGraph, index::Int)
    kept = Edge[]
    for (i, e) in enumerate(graph.edges)
        if i != index
            push!(kept, e)
        end
    end
    prune_disconnected(HackenbushGraph(kept, graph.ground))
end

function _edge_allowed(edge::Edge, player::Symbol)
    if edge.color == Green
        return true
    end
    if player == :left
        return edge.color == Blue
    elseif player == :right
        return edge.color == Red
    else
        error("player must be :left or :right")
    end
end

"""
Generate all legal moves for a given player (:left or :right).
"""
function moves(graph::HackenbushGraph, player::Symbol)
    options = HackenbushGraph[]
    for (i, e) in enumerate(graph.edges)
        if _edge_allowed(e, player)
            push!(options, cut_edge(graph, i))
        end
    end
    options
end

"""
Return the simplest dyadic rational strictly between l and r.
"""
function simplest_dyadic_between(l::Rational{Int}, r::Rational{Int}; max_pow::Int=30)
    if !(l < r)
        error("l must be less than r")
    end
    for k in 0:max_pow
        denom = 1 << k
        n = fld(l * denom, 1) + 1
        candidate = n // denom
        if candidate < r
            return candidate
        end
    end
    return (l + r) // 2
end

"""
Compute the value of a Red-Blue stalk (ground -> top).
"""
function stalk_value(colors::Vector{EdgeColor})
    values = Vector{Rational{Int}}(undef, length(colors) + 1)
    values[1] = 0//1

    for i in 1:length(colors)
        left_opts = Rational{Int}[]
        right_opts = Rational{Int}[]
        for j in 1:i
            if colors[j] == Blue
                push!(left_opts, values[j])
            elseif colors[j] == Red
                push!(right_opts, values[j])
            end
        end

        if isempty(left_opts) && isempty(right_opts)
            values[i + 1] = 0//1
        elseif isempty(right_opts)
            values[i + 1] = maximum(left_opts) + 1
        elseif isempty(left_opts)
            values[i + 1] = minimum(right_opts) - 1
        else
            lmax = maximum(left_opts)
            rmin = minimum(right_opts)
            values[i + 1] = simplest_dyadic_between(lmax, rmin)
        end
    end

    values[end]
end

"""
Minimal excluded nonnegative integer.
"""
mex(values::Vector{Int}) = isempty(values) ? 0 : first(setdiff(0:maximum(values) + 1, values))

"""
Nim-sum (xor) of integer nimbers.
"""
function nim_sum(values::Vector{Int})
    result = 0
    for v in values
        result ⊻= v
    end
    result
end

"""
Nimber for a green stalk of given height.
"""
green_stalk_nimber(height::Int) = height

function _graph_key(graph::HackenbushGraph)
    edges = sort([(min(e.u, e.v), max(e.u, e.v)) for e in graph.edges])
    (graph.ground, edges)
end

"""
Compute the Grundy number for a small green Hackenbush graph.
"""
function green_grundy(graph::HackenbushGraph)
    for e in graph.edges
        if e.color != Green
            error("green_grundy expects only Green edges")
        end
    end

    memo = Dict{Any, Int}()

    function _grundy(g::HackenbushGraph)
        key = _graph_key(g)
        if haskey(memo, key)
            return memo[key]
        end
        if isempty(g.edges)
            memo[key] = 0
            return 0
        end

        options = Int[]
        for i in 1:length(g.edges)
            value = _grundy(cut_edge(g, i))
            push!(options, value)
        end
        gval = mex(options)
        memo[key] = gval
        gval
    end

    _grundy(graph)
end

end # module
