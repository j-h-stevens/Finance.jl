"""
    sharpe(mu::T, rf::U, sigma::T) where {T<:Real, U<:Real}

Calculate the Sharpe Ratio given an mean return, risk free return 
and the volatility of the return. 

# Examples
```
julia> sharpe(0.12, 0.0414, 0.076)
1.0342105263157895
```
"""
sharpe(mu::T, rf::U, sigma::T) where {T<:Real, U<:Real} = (mu - rf)/sigma

"""
    sharpe(rf::T, r::Vector{U}) where {T<:Real, U<:Real}

Calculate the Sharpe Ratio given an mean return, risk free return 
and the volatility of the return. 

# Examples
```
julia> sharpe(0.02, collect(1:1:10))
1.809984429867737
```
"""
sharpe(rf::T, r::Vector{U}) where {T<:Real, U<:Real} = (mean(r) - rf)/std(r)

"""
    sortino(μ::T, r::T, θ::VectorT) where {T<:Real}

Calculate the Sharpe Ratio given an mean return, risk free return 
and the volatility of the return. 

# Examples
```
julia> sortino(mean(collect(1:1:10)), 5, collect(1:1:10))
0.31622776601683794
```
"""
sortino(mu::T, rf::U, rs::Vector{V}) where {T<:Real, U<:Real, V<:Real} = (mu - rf)/std(rs[rs .< mu])

export sharpe, sortino