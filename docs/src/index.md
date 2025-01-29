# What is this?
Here you will learn how to make a documentation website just like this one using exclusively Julia thanks to Documenter.jl. From scratch for absolute beginners.

It took me a while to figure this one out so I thought I might as well share it! Enjoy!


# Welcome!
This toy documentation is ment to serve as a minimal working template for your scientific work. In particular, it is well suited for basic repositories which are structured around a `/src` folder containing all the heavy lifting code which numerical experiments (inside, say `/experiments`) use. Of course, you may do something else and still find these docs useful. Ideally, all scientific papers should be accompanied by a documentation page (like this one) for faster communication/understanding and reproduction/usage.  

It is always a good idea to back-up your code before embarking on this project or even starting with just a toy version and later on expand to your needs.

# How it all works
### What you should already have
So you did all the hard work and have a functioning and hopefully well documented code somewhere in your machine doing all the science. Now you wish to share it to the outside world in a professional and respectable manner. You are in the right place, however I dont want to know how you organised your code. 

I believe respectable *scientific* code should be organised like so:
```
── Manifest.toml        # Your enviroment's contents
── Project.toml 
── src/                 # Your source code with your module/package
│── MinimalScientificDocs.jl  
│── aux.jl
── experiments/
│── exp_1/              # Experiment named "exp_1" 
│  │── exp_1.jl         # "exp_1" Julia code
│  │── exp_1_data.csv   # "exp_1" data
│  │── exp_1_fig.svg    # "exp_1" figure
│── exp_2/ 
│  │── exp_2.jl  
│  │── exp_2_data.csv  
│  │── exp_2_fig.svg  
...
```
If you dont recognise the `.toml` files, you need to learn what Julia enviroments are and how to use them. It's easy, it's useful and **you wont be able to create a page like this without it**. 

So go ahead and fix your code until it follows the structure above.

For reproduction purposes, this very page contains the following code inside `/src`:
```
# src/MinimalScientificDocs.jl
module Test_Module

export mul_by_2, mul_by_4

include("aux.jl")

end # end of module
```
```
# src/aux.jl
""" 
    mul_by_2(x)

Multiplies x by 2.
"""
function mul_by_2(x) 
    return 2*x 
end

""" 
    mul_by_4(x)

Multiplies x by 4.
"""
function mul_by_4(x) 
    return 4*x 
end
```
For this minimal toy example, we dont even have an `/experiments` folder since we will add those to the documentation exclusively. Dont worry if you do have it, that's good, we will relocate it soon.

Finally, the top level enviroment inside `Project.toml` (and `Manifest.toml`) contains in my case:
```
name = "MinimalScientificDocs"
uuid = "123e4567-e89b-12d3-a456-426614174000"
authors = ["Alejandro Cros Carrillo de Albornoz"]
version = "0.1.0"

[deps]
ColorSchemes = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
Documenter = "e30172f5-a6a5-5a46-863b-614d45cd2de4"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Literate = "98b081ad-f1c9-55d3-8b20-4c87d4299306"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"

[compat]
ColorSchemes = "3.27.1"
Documenter = "1.8.0"
LaTeXStrings = "1.4.0"
Literate = "2.20.1"
Plots = "1.40.9"
```
**Okay, this is important, you need to match the `[name]` with that of your module/package which in turn needs to be inside a file named the same way.** With this we mean that our toy module `MinimalScientificDocs` is inside a file `/src/MinimalScientificDocs.jl` and in the `Project.toml` above `name = "MinimalScientificDocs"`.

### What we need to do
This documentation is entirely hosted in GitHub (although you can also view it locally on your machine) and it is updated automatically everytime you push an update on your code to it. Pretty neat! However, for all of that to work, we need to set things up correctly so follow closely because it can be *very* finicky. 

We will create a new folder on the top level called `/docs` to host our new documentation machinery. Inside `/docs` we need to do 3 things: 
1. Create a folder `/docs/src` with a markdown file `/docs/src/index.md` which will become our first page.
2. Create a `/docs/make.jl` julia file which will be the engine driving your documentation page.
3. Create a new `(docs)` enviroment which we will set up for your GitHub page.

As a recap, your code should look like: 
```
── Manifest.toml        
── Project.toml 
── src/                 
│── MinimalScientificDocs.jl  
│── aux.jl
── experiments/
│── exp_1/              
│  │── exp_1.jl         
│  │── exp_1_data.csv   
│  │── exp_1_fig.svg    
│── exp_2/ 
│  │── exp_2.jl  
│  │── exp_2_data.csv  
│  │── exp_2_fig.svg  
...
── docs/
│── src/              
│  │── index.md      # this will become your first page  
│── make.jl          # this will drive your ocs
│── Manifest.toml    # your docs enviroment
│── Project.toml 
```
Let's start with the contents of `/docs/make.jl`, arguably the most important file of this project. 

Blab lbalb a


### Hosting it in GitHub
So you have commited everything to your brand new GitHub repository but nothing happended. That's normal, we need to tell GitHub that it actually needs to do something with your code. Fortunately, it takes literally 3 clicks to do that. So we enter to your repo and click `Settings` on the top bar. Inside `Settings`, look for `Pages` in the sidebar and click it. Next, we sure that `Build and deployment`'s Source is set to `Deploy from a branch` and right underneath, in `Branch`, select `gh-pages` (for GitHub pages) and leave the `Select folder` to be `/(root)`. And that's it! Do not touch anything else. 

So how do you update your GitHub documentation page? You simply commit new changes to your local code on your machine to GitHub and it will automatically update it (it does take a few mins for changes to reflect though). 

To monitor and debug whatever you will inevitably mess up, you can keep track of what GitHub does in the background everytime you update your repo. For that, you need to head to `Actions` right in the same top bar as `Settings` were. Inside `Actions`, you can see all the commits/workflows-runs you have done. If there's a green tick, all should be good. If there's a red cross something went wrong: simply click on it and investigate what happened by reading the steps GitHub did and what went wrong.

With this, either you have a running page or you are *very* close to one, a few debugs away. **Remember that you can always clone this very repo and try running it yourself.** This way not only you will learn fast but also you will start from something that (hopufully) works and take incremental steps towards modifying it for your code. 

# Typos? Bugs? Let me know!
If you see any typos or experience any bugs let me know by creating an issue in this page's GitHub. 

Your feedback is very welcomed!

# Buy me a coffee? 
Thanks for reading! If you think that you owe me a drink now, buy me a coffee at:

[https://buymeacoffee.com/acroscarrillo](https://buymeacoffee.com/acroscarrillo)

It's super quick and easy, no account needed. :)