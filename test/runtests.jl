using Finance
using Test

@testset "Finance.jl" begin
    @test rrr([-100, 0, 10,2,0,5,-5,10]) == 0.38954249574070055
    @test irr([-100, 0, 10,2,0,5,-5,10,110]) == 0.03878283110184433
end
