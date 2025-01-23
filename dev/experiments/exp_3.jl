# # [exp.jl exp](@id exp)


# ### An interesting exponential
# wow what a growth
using Pkg
Pkg.instantiate()

using Plots

scatter(exp.(1:10))
plot!(exp.(1:10))




# ### A relaxing sine and cosine
# This are awesone sinusoidal functions

plot(sin.(-3:0.01:3))
plot!(cos.(-3:0.01:3))
