using Documenter

makedocs(
    sitename = "My Project Documentation",
    repo = "https://github.com/acroscarrillo/Quantum_Geometric_Complexity",
    pages = [
        "Home" => "index.md",
        "Experiments" => [
            "Overview" => "experiments.md",
            "Experiment 1" => "exp_1.md",
            "Experiment 2" => "exp_2.md"
        ]
    ]
)

deploydocs(
    repo = "github.com/acroscarrillo/Quantum_Geometric_Complexity.git",
    branch = "gh-pages",
    devbranch = "main"
)