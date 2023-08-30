using Finance
using Documenter

DocMeta.setdocmeta!(Finance, :DocTestSetup, :(using Finance); recursive=true)

makedocs(;
    modules=[Finance],
    authors="John Stevens",
    repo="https://github.com/J-h-stevens/Finance.jl/blob/{commit}{path}#{line}",
    sitename="Finance.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://J-h-stevens.github.io/Finance.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/J-h-stevens/Finance.jl",
    devbranch="main",
)
