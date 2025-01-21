# docs/make.jl
push!(LOAD_PATH,"../src/")
using Documenter, Test_Module, Literate

# literate the tutorial
Literate.markdown(
    joinpath(@__DIR__, "src/experiments/", "exp.jl"), joinpath(@__DIR__, "src");
    credit = false
)

makedocs(sitename="My Documentation",
format = Documenter.HTML(
    prettyurls = get(ENV, "CI", nothing) == "true"
),
    pages = [
        "Introduction" => "index.md",
        "Tutorial" => "exp.md"
        # "Experiments" => ["experiments/exp_1.md",
                            # "experiments/exp_2.md",
                            # "experiments/exp_3.md",]
    ]
)