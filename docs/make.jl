# docs/make.jl
push!(LOAD_PATH,"../src/")
using Documenter, QuantumGeometricComplexity, Literate

# literate the tutorial
Literate.markdown(
    joinpath(@__DIR__, "src/experiments/", "exp_1.jl"), joinpath(@__DIR__, "src");
    credit = false
)

# literate the tutorial
Literate.markdown(
    joinpath(@__DIR__, "src/experiments/", "exp_2.jl"), joinpath(@__DIR__, "src");
    credit = false
)

# literate the tutorial
Literate.markdown(
    joinpath(@__DIR__, "src/experiments/", "exp_3.jl"), joinpath(@__DIR__, "src");
    credit = false
)

makedocs(sitename="Minimal Documentation",
# format = Documenter.HTML(
#     prettyurls = get(ENV, "CI", nothing) == "true"
# ),
    pages = [
        "How to make a page like this" => "index.md",
        "Numerical Experiments" => ["exp_1.md",
                            "exp_2.md",
                            "exp_3.md",],
        "Citing this work" => "citing.md"
    ]
)

#https://github.com/JuliaDynamics/GoodScientificCodeWorkshop/blob/main/block5_documentation/Documenter_GitHub_deploy.yaml
deploydocs(
    repo = "https://github.com/acroscarrillo/Quantum_Geometric_Complexity"
)

