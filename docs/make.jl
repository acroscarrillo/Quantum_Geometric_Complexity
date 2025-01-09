using Documenter
using Markdown

makedocs(
    sitename = "My Project",
    # modules = [],
    format = Documenter.HTML(),
    pages = [
        "Home" => "index.md",
        "Experiments" => [
            "Overview" => "experiments/index.md",
            "Experiment 1" => "experiments/exp_1.md",
            "Experiment 2" => "experiments/exp_2.md"
        ]
    ]
)