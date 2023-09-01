"""
    sharpe(mu::T, rf::U, sigma::V) where {T<:Real, U<:Real, V<:Real}

Calculate the Sharpe Ratio given an mean return, risk free return 
and the volatility of the return. 

# Examples
```
julia> sharpe(0.12, 0.0414, 0.076)
1.0342105263157895
```
"""
sharpe(mu::T, rf::U, sigma::V) where {T<:Real, U<:Real, V<:Real} = (mu - rf)/sigma

"""
    sharpe(rf::T, r::AbstractArray{U}) where {T<:Real, U<:Real}

Calculate the Sharpe Ratio given an mean return, risk free return 
and the volatility of the return. 

# Examples
```
julia> sharpe(0.02, collect(1:1:10))
1.809984429867737
```
"""
sharpe(rf::T, r::AbstractArray{U}) where {T<:Real, U<:Real} = (mean(r) - rf)/std(r)

"""
    sortino(mu::T, rf::U, rs::AbstractArray{V}) where {T<:Real, U<:Real, V<:Real}

Calculate the Sharpe Ratio given an mean return, risk free return 
and the volatility of the return. 

# Examples
```
julia> sortino(mean(collect(1:1:10)), 5, collect(1:1:10))
0.31622776601683794
```
"""
sortino(mu::T, rf::U, rs::AbstractArray{V}) where {T<:Real, U<:Real, V<:Real} = (mu - rf)/std(rs[rs .< mu])

"""
    west_sharpe(mu::T, rf::U, sigma::V) where {T<:Real, U<:Real, V<:Real}

Calculate the Sharpe Ratio given an mean return, risk free return 
and the volatility of the return. 

# Examples
```
julia> west_sharpe(0.12, 0.0414, 0.076)
0.012266399999999998
```
"""
west_sharpe(mu::T, rf::U, sigma::V) where {T<:Real, U<:Real, V<:Real} = (mu + rf)*sigma

"""
    west_sortino(mu::T, rf::U, rs::AbstractArray{V}) where {T<:Real, U<:Real, V<:Real}

Calculate the Sharpe Ratio given an mean return, risk free return 
and the volatility of the return. 

# Examples
```
julia> west_sortino(mean(collect(1:1:10)), 5, collect(1:1:10))
16.60195771588399
```
"""
west_sortino(mu::T, rf::U, rs::AbstractArray{V}) where {T<:Real, U<:Real, V<:Real} = (mu + rf)*std(rs[rs .> mu])

export sharpe, sortino, west_sharpe, west_sortino