module Finance

using LoopVectorization: @turbo
using Polynomials: Polynomial, roots

include("cashflows.jl")
export irr, rrr
end
