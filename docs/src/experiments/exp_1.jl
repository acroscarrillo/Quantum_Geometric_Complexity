# # [Plot and Histogram](@id exp)

# The following page has been generated entirely within a single Julia file (`/docs/src/experiments/exp_1.jl`), see its source code to see how easy it was done. 

# As a show case, here's some random plots using in this case `Plots.jl`. Dont forget to add any necessary packages to the enviroment and to import them!

# ### A familiar normal histogram
using Pkg
Pkg.instantiate() # fixes an error where GitHub forgets to instantiate the enviroment.

using Plots, LaTeXStrings

histogram(randn(100000,1),legend=false,xlabel=L"X",ylabel="counts")

# From now onwards, no need to import anything again, it was imported above (remember this runs in the same Julia file).

# ### A friendly Wiener process plot

# A Wiener Process $W_t$ (also called standard Brownian motion) is a stochastic process with the following properties:

# 1. The process starts at zero: $W_0 = 0$: .
# 2. Independent increments: The change $W_t - W_s$ for $t > s$ is independent of past values.
# 3. Stationary increments: $W_t - W_s \sim \mathcal{N}(0, t-s)$, meaning the increments are normally distributed with mean 0 and variance $t - s$.
# 4. Continuous paths: The function $W_t$ is continuous with probability 1.
# 5. No drift: The expected value is $\mathbb{E}[W_t] = 0$.
# 6. Variance grows linearly: $\text{Var}(W_t) = t$.

# Mathematical Definition:
#  ```math
# dW_t \sim \mathcal{N}(0, dt)
# ```
# where $dW_t$ represents a small random movement over an infinitesimal time step $dt$.

# The Wiener process is fundamental in stochastic calculus and financial modeling, forming the basis for Geometric Brownian Motion (GBM) used in stock price modeling.

function Wiener_process(T, N, σ, W_0; N_processes=1)
    dt = T / N  # Time step size
    t = range(0, T, length=N+1)  # Time points
    dW = sqrt(dt) .* randn(N, N_processes)  # Wiener increments for all processes
    W = σ .* cumsum([zeros(1, N_processes); dW], dims=1)  # Compute Wiener process paths
    return t, W
end

plot(Wiener_process(10, 1000, 1, 0, N_processes=10),ylabel=L"W",xlabel=L"t",legend=false)