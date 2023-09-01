using Finance
using Test

@test sharpe(0.02, collect(1:1:10)) == 1.809984429867737
@test sharpe(0.12, 0.0414, 0.076) == 1.0342105263157895
@test sortino(5.5, 5, collect(1:1:10)) == 0.31622776601683794
@test west_sharpe(0.12, 0.0414, 0.076) == 0.012266399999999998
@test west_sortino(5.5, 5, collect(1:1:10)) == 16.60195771588399