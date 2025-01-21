using Documenter, Test_Module

include("../src/src.jl")

makedocs(
    modules = [my_module],
    format = :html,
    sitename = "my_module.jl",
    doctest = true
)