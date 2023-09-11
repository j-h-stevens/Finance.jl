using Finance
using Test
using SafeTestsets

@time begin
    @time @safetestset "Valuations" begin
        include("valuations_test.jl")
    end
    @time @safetestset "Ratios" begin
        include("ratios_test.jl")
    end
    @time @safetestset "Returns" begin
        include("returns_test.jl")
    end
end