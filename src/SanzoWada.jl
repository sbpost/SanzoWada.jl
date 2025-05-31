module SanzoWada
export findcolor, findcolors, findcombination,
    getcolors, getrgb, gethex, getlab

using JLD2
using Colors

const COLORS = load("colors.jld2")["colors"]
const N_COMBINATIONS = 348 # maximum([maximum(d[:combinations]) for d in COLORS])

function findcolor()
    rand(COLORS)
end

function findcolor(name::String)
    filter(d -> name == d[:name], COLORS) |> only
end

function findcolor(name::String, format::Symbol)
    findcolor(name)[format]
end

function findcolor(pattern::Regex)
    return filter(d -> contains(d[:name], pattern), COLORS)
end

function findcolors(combination_id::Int)
    return filter(d -> combination_id ∈ d[:combinations], COLORS)
end

function findcombination()
    findcolors(rand(1:N_COMBINATIONS))
end

function findcombination(combination_id::int)
    findcolors(combination_id)
end

function findcombination(combination_id::Int, format)
    colors = findcolors(combination_id)
    getcolors(colors, format)
end


getcolors(colors::Vector{Dict}, format::Symbol) = [color[format] for color in colors]
getcolors(colors, format) = [color[format] for color in colors]
getrgb(v) = getcolors(v, :rgb)
gethex(v) = getcolors(v, :hex)
getlab(v) = getcolors(v, :lab)
getnames(colors) = [color[:name] for color in colors]
end
