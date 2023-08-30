using Finance
using Test

@test sharpe(0.02, collect(1:1:10)) == 1.809984429867737
@test sharpe(0.12, 0.0414, 0.076) == 1.0342105263157895
@test sortino(5.5, 5, collect(1:1:10)) == 0.31622776601683794