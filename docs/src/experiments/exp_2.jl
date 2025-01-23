# # [Scatter and Heatmap](@id exp)


# ### An interesting scatter
# wow what a scatter!
using Pkg
Pkg.instantiate()

using Plots

scatter(rand(100,2))



# ### A rather puzzling heatmap
# This is a heatmap of a random matrix
heatmap(randn(100,100))