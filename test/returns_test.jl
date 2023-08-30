using Finance
using Test
using Statistics: mean, std
using StatsBase: cor, issymmetric

##Test Return Generator
#n = number of periods
n = 5
#sims = simulations
sims = 10
mus = collect(0.01:0.01:0.1)
vols = zeros(length(mus)) .+ 0.05
cors = zeros(length(mus), length(vols)) .+ 0.02
for i in 1:size(cors, 1)
    cors[i, i] = 1.0
end
#2 Create Returns
r = choln(cors, vols, n, mus, sims)
r2 = choln(cors, vols, n, mus, sims)
#Calc mus and vols for all each asset classes in all simulations
mu = mean(r) #Calc Mean
vol = std(r) #Calc Vol
#Check vols and means are within 1% of inputs
@test vol - mean(vols) <= 0.01
@test mu - mean(mus) <= 0.01
#check correlation symmetry
@test sum([issymmetric(cor(r[:, :, i])) for i in axes(r, 3)]) == sims
#check each set of returns is reproducible
@test r == r2

##Test Return Weighter
n = 2
r = .05
returns = zeros(n, n, n) .+ r
weight = zeros(size(returns, 2)) .+ 1 / size(returns, 2)
f = 0.01
wr = Matrix{Float64}(undef, size(returns,1), size(returns,3))
netwr = Matrix{Float64}(undef, size(returns,1), size(returns,3))
weighted_returns!(wr, returns, 1, n, weight, 0.0)
weighted_returns!(netwr, returns, 1, n, weight, f)
@test wr == zeros(n, n) .+ 0.05
@test netwr == zeros(n, n) .+ 0.04
