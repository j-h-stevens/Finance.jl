"""
    pvdv(r, cashflows, times)
Calculate the present value and its derivative in one pass for Newton's Method
    ...
    # Arguments
    - 'r::Float64': the initial guess and subsequent return rates.
    - 'cashflows::Vector{Float64}': the periodic cashflows. 
    - 'times::UnitRange{Int64})': the unit range for the periods. 
    ...
"""
function pv_div_pvdv(r::Float64, cashflows::AbstractArray{<:Real}, times::UnitRange{Int64})
    n = 0.0
    d = 0.0
    @turbo for i ∈ eachindex(cashflows)
        cf = cashflows[i]
        t = times[i]
        a = cf * exp(-r * t)
        n += a
        d += a * -t
    end
    return n / d
end

"""
    newt_irr(cashflows, times, x, ε, k_max, times)
Algorithms for Optimization, Mykel J. Kochenderfer and Tim A. Wheeler, pg 88
    ...
    # Arguments
    - 'cashflows::Vector{Float64}': the periodic cashflows.
    - 'x::Float64': the initial guess and subsequent return rates.
    - 'ε::Float64': the error tolerance.
    - 'k_max::Int64': the maximum number of iterations.
    ...
"""
function newt_irr(cashflows::AbstractArray{<:Real}, times::UnitRange{Int64}, x::Float64, 
    ε::Float64, k_max::Int64)
    k = 1
    Δ = Inf
    while abs(Δ) > ε && k ≤ k_max
        # @show x,H(x),  ∇f(x)
        Δ = pv_div_pvdv(x, cashflows, times)
        x -= Δ
        k += 1
    end
    return x
end

"""
    newt_irr(cashflows, times; guess::0.001, tol=1e-9, k_max=100)
Algorithms for Optimization, Mykel J. Kochenderfer and Tim A. Wheeler, pg 88
    ...
    # Arguments
    - 'cashflows::Vector{Float64}': the periodic cashflows.
    - 'x::Float64': the initial guess and subsequent return rates.
    - 'ε::Float64': the error tolerance.
    - 'k_max::Int64': the maximum number of iterations.
    ...
"""
function newt_irr(cashflows::AbstractArray{<:Real}, times::UnitRange{Int64}; 
    guess=0.001, tol=1e-9, k_max=100)
    # use newton's method with hand-coded derivative
    return exp(newt_irr(cashflows,times,guess,tol,k_max))-1
end

"""
    poly_irr(values::Vector{Float64}

Calculate internal rate of return given an array of cash flow `values`
(nearest one first)

# Examples
```
julia> poly_irr([-100, 101])
0.010000000000000009
```
"""
function poly_irr(cashflows::AbstractArray{T} where {T<:Real})
    res = roots(Polynomial(cashflows))
    mask = map(x -> isa(x, Complex) ? x.im == 0 && x.re > 0 : x > 0, res)
    if !any(mask)
        return NaN
    end
    res = map(x -> isa(x, Complex) ? x.re : x, res[mask])
    rate = @. 1 / res - 1
    return rate[]
end

"""
    irr(values::AbstractArray{T} where {T<:Real})

Calculate internal rate of return given an array of cashflows.

# Examples
```
irr([-100, 0, 10,2,0,5,-5,10,110])
0.03878283110184433
```
"""
function irr(cashflows::AbstractArray{T} where {T<:Real})
    times=0:length(cashflows)-1
    r = newt_irr(cashflows, times)
    lower, upper = -1.0, 1.0
    if isnan(r) || (r >= upper && r <= lower)
        return poly_irr(cashflows)
    else
        return r
    end    
end

"""
    rrr(values::Vector{Float64}

Calculate required rate of return given an array of cashflows.

# Examples
```
julia> rrr([-100, 0, 10,2,0,5,-5,10])
0.38954249574070055
```
"""
function rrr(cashflows::AbstractArray{T} where {T<:Real})
    cashflows = vcat(cashflows[1], cashflows[end:-1:2])
    res = roots(Polynomial(cashflows))
    mask = map(x -> isa(x, Complex) ? x.im == 0 && x.re > 0 : x > 0, res)
    if !any(mask)
        return NaN
    end
    return map(x -> isa(x, Complex) ? x.re : x, res[mask])[] - 1.0
end

"""
    fv(values::Vector{Float64}

Calculate required rate of return given an array of cashflows.

# Examples
```
julia> fv(10, 0.05, 10)
16.28894626777442
```
"""
fv(pv::T, i::U, n::Int64) where {T<:Real, U<:Real} = pv * (1.0 + i)^n

export irr, rrr, fv
