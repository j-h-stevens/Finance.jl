module Finance

using LoopVectorization: @turbo
using Polynomials: Polynomial, roots
using StatsBase

include("cashflows.jl")
include("ratios.jl")
export irr, rrr
export sharpe, sortino
end
