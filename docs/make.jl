# docs/make.jl
push!(LOAD_PATH,"../src/")
using Documenter, Quantum_Geometric_Complexity, Literate

# literate all files inside /docs/experiments/ into src/experiments/markdown/
experiments_path = "src/experiments/"

for file in readdir(joinpath(@__DIR__, experiments_path))
    Literate.markdown(joinpath(@__DIR__, experiments_path, file), joinpath(@__DIR__, "src/experiments/markdown"); credit = false)
end

# group all generated md files inside src/experiments/markdown"
experiments_md_files = ["experiments/markdown/" * file for file in readdir(joinpath(@__DIR__, "src/experiments/markdown"))]

display("beging makedocs...")
display(@__DIR__)
display(experiments_md_files)

makedocs(sitename="Minimal Scientific Docs",
    pages = [
        "How to make a page like this" => "index.md",
        "Home" => "home.md",
        "Numerical Experiments" => experiments_md_files,
        "Citing this work" => "citing.md"
    ]
)
display("finished makedocs!")


# # literate the tutorial
# Literate.markdown(
#     joinpath(@__DIR__, "src/experiments/", "exp_2.jl"), joinpath(@__DIR__, "src");
#     credit = false
# )

# makedocs(sitename="Minimal Scientific Docs",
#     pages = [
#         "How to make a page like this" => "index.md",
#         "Home" => "home.md",
#         "Numerical Experiments" => ["exp_1.md",
#                             "exp_2.md",
#                             "exp_3.md",],
#         "Citing this work" => "citing.md"
#     ]
# )

deploydocs(
    repo = "https://github.com/acroscarrillo/Quantum_Geometric_Complexity"
)