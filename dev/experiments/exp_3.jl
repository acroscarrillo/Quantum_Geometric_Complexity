# # [Mock numerical study](@id exp)

# ### Dynamics of $M$ at different magnetic flux $\phi$
# In this numerical experiment, we study the dynamics of $M$ as the magnetic flux $\phi$ is varied at fixed temperature $T$ and 
using Pkg
Pkg.instantiate()

using Plots

scatter(exp.(1:10))
plot!(exp.(1:10))

# ### A relaxing sine and cosine
# This are awesone sinusoidal functions
# Here are the functions in LaTeX:

# ```math
# \cos(x) \quad \sin(x)
# ```

# This is lovely.

plot(sin.(-3:0.01:3))
plot!(cos.(-3:0.01:3))
