using Finance
using Test
using SafeTestsets

@time begin
    @time @safetestset "Cashflows" begin
        include("cashflows_test.jl")
    end
    @time @safetestset "Ratios" begin
        include("ratios_test.jl")
    end
    @time @safetestset "Returns" begin
        include("returns_test.jl")
    end
end