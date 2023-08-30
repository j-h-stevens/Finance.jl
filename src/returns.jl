"""
    choln(c, s, n, m, its; seed = 1234)

Generate a normal distribution of correlated asset class returns using the 
Cholesky decomposition method. The function returns a 3d array of
returns with dimensions 'n' x 'm' x 'p'.
...
    # Arguments
    - `c::Matrix{Float64}`: correlation matrix
    - `s::Vector{Float64}`: the vector of standard deviations
    - `n::Integer`: the number of sequences
    - `m::Vector{Float64}`: the vector of means
    - `p::Integer`: the number of iterations
    - `n::Float64`: the periodic fee rate
... 
"""
function choln(c::Matrix{Float64}, s::Vector{Float64},
    n::Int64, m::Vector{Float64}, p::Int64; seed=1234)
    seed!(seed)
    chol = cholesky(cor2cov(c, s)).U
    r = randn(n, length(m), p)
    @views @Threads.threads for i in axes(r, 3)
        rmul!(r[:, :, i], chol)
    end
    return r .+ m'
end

"""
    weighted_returns!(wr, r, s, n, w, f)

Compute the weighted returns matrix from the asset class returns. 
...
    # Arguments
    - `r::Array{Float64,3}`: the 3 dimensional array of asset class returns.
    - `wr::Matrix{Float64}`: the Matrix storing the the weighted returns. 
    - `s::Integer`: the first index. 
    - `n::Integer`: the final index.
    - `ws::Vector{Float64}`: the allocation weight vector.
    - `n::Float64`: the periodic fee rate
...
"""
function weighted_returns!(wr::Matrix{Float64}, r::Array{Float64,3}, s::Int64, 
    n::Int64, w::Vector{Float64}, f::Float64)
    @views @Threads.threads for i in axes(r, 3)
        mul!(wr[s:n, i], r[s:n, :, i], w)
    end
    wr .-= f
end

export choln, weighted_returns!