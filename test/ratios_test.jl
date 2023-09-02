using Finance
using Test
@test sharpe(0.12, 0.0414, 0.076) == 1.0342105263157895
@test sharpe(0.02, collect(1:1:10)) == 1.809984429867737
@test sortino(5.5, 5, collect(1:1:10)) == 0.3872983346207417
@test sortino(5, collect(1:1:10)) == 0.3872983346207417
@test west_sharpe(0.12, 0.0414, 0.076) == 0.012266399999999998
@test west_sharpe(5, collect(1:1:10)) == 31.790328718023662
@test west_sortino(5.5, 5, collect(1:1:10)) == 16.60195771588399
@test west_sortino(5, collect(1:1:10)) == 16.60195771588399