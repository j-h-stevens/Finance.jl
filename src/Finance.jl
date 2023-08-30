module Finance

using LoopVectorization: @turbo
using Polynomials: Polynomial, roots
using Statistics: mean, std
using StatsBase: cor2cov
using Random: seed!
using LinearAlgebra: rmul!, mul!, cholesky
using Base.Threads

include("cashflows.jl")
include("ratios.jl")
include("returns.jl")
export irr, rrr
export sharpe, sortino
export choln, weighted_returns!
end
