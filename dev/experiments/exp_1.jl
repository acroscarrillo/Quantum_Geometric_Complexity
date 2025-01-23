# # [Plot and Histogram](@id exp)


# ### An interesting plot
using Pkg
Pkg.instantiate()

using Plots

plot(rand(100,2))



# ### A rather boring normal
histogram(randn(10000,1))