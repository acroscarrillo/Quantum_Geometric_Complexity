var documenterSearchIndex = {"docs":
[{"location":"exp_3/","page":"Exponential and Sinusoidal","title":"Exponential and Sinusoidal","text":"EditURL = \"experiments/exp_3.jl\"","category":"page"},{"location":"exp_3/#exp","page":"Exponential and Sinusoidal","title":"Exponential and Sinusoidal","text":"","category":"section"},{"location":"exp_3/#An-interesting-exponential","page":"Exponential and Sinusoidal","title":"An interesting exponential","text":"","category":"section"},{"location":"exp_3/","page":"Exponential and Sinusoidal","title":"Exponential and Sinusoidal","text":"wow what a growth","category":"page"},{"location":"exp_3/","page":"Exponential and Sinusoidal","title":"Exponential and Sinusoidal","text":"using Pkg\nPkg.instantiate()\n\nusing Plots\n\nscatter(exp.(1:10))\nplot!(exp.(1:10))","category":"page"},{"location":"exp_3/#A-relaxing-sine-and-cosine","page":"Exponential and Sinusoidal","title":"A relaxing sine and cosine","text":"","category":"section"},{"location":"exp_3/","page":"Exponential and Sinusoidal","title":"Exponential and Sinusoidal","text":"This are awesone sinusoidal functions Here are the functions in LaTeX:","category":"page"},{"location":"exp_3/","page":"Exponential and Sinusoidal","title":"Exponential and Sinusoidal","text":"cos(x) quad sin(x)","category":"page"},{"location":"exp_3/","page":"Exponential and Sinusoidal","title":"Exponential and Sinusoidal","text":"This is lovely.","category":"page"},{"location":"exp_3/","page":"Exponential and Sinusoidal","title":"Exponential and Sinusoidal","text":"plot(sin.(-3:0.01:3))\nplot!(cos.(-3:0.01:3))","category":"page"},{"location":"exp_1/","page":"Plot and Histogram","title":"Plot and Histogram","text":"EditURL = \"experiments/exp_1.jl\"","category":"page"},{"location":"exp_1/#exp","page":"Plot and Histogram","title":"Plot and Histogram","text":"","category":"section"},{"location":"exp_1/#An-interesting-plot","page":"Plot and Histogram","title":"An interesting plot","text":"","category":"section"},{"location":"exp_1/","page":"Plot and Histogram","title":"Plot and Histogram","text":"using Pkg\nPkg.instantiate()\n\nusing Plots\n\nplot(rand(100,2))","category":"page"},{"location":"exp_1/#A-rather-boring-normal","page":"Plot and Histogram","title":"A rather boring normal","text":"","category":"section"},{"location":"exp_1/","page":"Plot and Histogram","title":"Plot and Histogram","text":"histogram(randn(10000,1))","category":"page"},{"location":"#Welcome!","page":"Introduction","title":"Welcome!","text":"","category":"section"},{"location":"","page":"Introduction","title":"Introduction","text":"This toy documentation is ment to serve as a minimal working template for your scientific work. In particular, it is well suited for basic repositories which are structured around a /src folder containing all the heavy lifting code which numerical experiments (inside, say /experiments) use. Of course, you may do something else and still find these docs useful. Ideally, all scientific papers should be accompanied by a documentation page (like this one) for faster communication/understanding and reproduction/usage. Enjoy! ","category":"page"},{"location":"","page":"Introduction","title":"Introduction","text":"It took me a while to figure this one out so I thought I might as well share it!","category":"page"},{"location":"#How-it-all-works","page":"Introduction","title":"How it all works","text":"","category":"section"},{"location":"","page":"Introduction","title":"Introduction","text":"So you did all the hard work and have a functioning and hopefully well documented code somewhere in your machine. Now you wish to share it to the outside world in a professional and respectable manner. You are in the right place, however I dont want to know how you organised your code. I beleive respectable code should be organised like so:","category":"page"},{"location":"","page":"Introduction","title":"Introduction","text":"── Manifest.toml\n── Project.toml \n── src/\n│── your_src_module.jl  \n│── other_src_code.jl\n── experiments/\n│── exp_1/ \n│  │── exp_1.jl  \n│  │── exp_1_data.csv  \n│  │── exp_1_fig.svg  \n│── exp_2/ \n│  │── exp_2.jl  \n│  │── exp_2_data.csv  \n│  │── exp_2_fig.svg  \n...","category":"page"},{"location":"#Contents","page":"Introduction","title":"Contents","text":"","category":"section"},{"location":"","page":"Introduction","title":"Introduction","text":"Here's the full list of contents","category":"page"},{"location":"","page":"Introduction","title":"Introduction","text":"","category":"page"},{"location":"#Documentation","page":"Introduction","title":"Documentation","text":"","category":"section"},{"location":"","page":"Introduction","title":"Introduction","text":"CurrentModule = QuantumGeometricComplexity","category":"page"},{"location":"","page":"Introduction","title":"Introduction","text":"Modules = [QuantumGeometricComplexity]","category":"page"},{"location":"#QuantumGeometricComplexity.mul_by_2-Tuple{Any}","page":"Introduction","title":"QuantumGeometricComplexity.mul_by_2","text":"mul_by_2(x)\n\nMultiplies x by 2.\n\n\n\n\n\n","category":"method"},{"location":"#Index","page":"Introduction","title":"Index","text":"","category":"section"},{"location":"","page":"Introduction","title":"Introduction","text":"","category":"page"},{"location":"citing/#Citing-this-work","page":"Citing this work","title":"Citing this work","text":"","category":"section"},{"location":"citing/","page":"Citing this work","title":"Citing this work","text":"Here's how you can cite this amazing work!","category":"page"},{"location":"exp_2/","page":"Scatter and Heatmap","title":"Scatter and Heatmap","text":"EditURL = \"experiments/exp_2.jl\"","category":"page"},{"location":"exp_2/#exp","page":"Scatter and Heatmap","title":"Scatter and Heatmap","text":"","category":"section"},{"location":"exp_2/#An-interesting-scatter","page":"Scatter and Heatmap","title":"An interesting scatter","text":"","category":"section"},{"location":"exp_2/","page":"Scatter and Heatmap","title":"Scatter and Heatmap","text":"wow what a scatter!","category":"page"},{"location":"exp_2/","page":"Scatter and Heatmap","title":"Scatter and Heatmap","text":"using Pkg\nPkg.instantiate()\n\nusing Plots\n\nscatter(rand(100,2))","category":"page"},{"location":"exp_2/#A-rather-puzzling-heatmap","page":"Scatter and Heatmap","title":"A rather puzzling heatmap","text":"","category":"section"},{"location":"exp_2/","page":"Scatter and Heatmap","title":"Scatter and Heatmap","text":"This is a heatmap of a random matrix","category":"page"},{"location":"exp_2/","page":"Scatter and Heatmap","title":"Scatter and Heatmap","text":"heatmap(randn(100,100))","category":"page"}]
}
