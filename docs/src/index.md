# What is this?
Here you will learn how to make a documentation website like this one using exclusively Julia thanks to Documenter.jl from scratch for absolute beginners.

It took me a while to figure this one out so I thought I might as well share it! Enjoy!


# Welcome!
This toy documentation is ment to serve as a minimal working template for your scientific work. In particular, it is well suited for basic repositories which are structured around a `/src` folder containing all the heavy lifting code which numerical experiments (inside, say `/experiments`) use. Of course, you may do something else and still find these docs useful. Ideally, all scientific papers should be accompanied by a documentation page (like this one) for faster communication/understanding and reproduction/usage.  

It is always a good idea to back-up your code before embarking in this project and even starting with just a toy version and later on expand.

# How it all works
### What you already have
So you did all the hard work and have a functioning and hopefully well documented code somewhere in your machine doing all the science. Now you wish to share it to the outside world in a professional and respectable manner. You are in the right place, however I dont want to know how you organised your code. 

I believe respectable *scientific* code should be organised like so:
```
── Manifest.toml        # Your enviroment's contents
── Project.toml 
── src/                 # Your source code with your module/package
│── your_src_module.jl  
│── other_src_code.jl
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
# src/Test_Module.jl
module Test_Module

export mul_by_2

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
```
For this minimal toy example, we dont even have an `/experiments` folder since we will add those to the documentation exclusively. Dont worry if you do have, that's good, we will relocate it soon.

### What we need to do
This documentation is entirely hosted in GitHub (although you can also view it locally on your machine) and it is updated automatically everytime you push an update on your code to it. Pretty neat! However, for all of that to work, we need to set things up correctly so follow closely because it is *very* finicky. 

We will create a new folder on the top level called `/docs` to host our new documentation machinery. Inside `/docs` we need to do 3 things: 
1. Create a folder `/docs/src` with a markdown file `/docs/src/index.md` which will become our first page.
2. Create a `/docs/make.jl` julia file which will be the engine driving your documentation page.
3. Create a new `(docs)` enviroment which we will set up for your GitHub page.

All in all, your code should look like 
```
── Manifest.toml        
── Project.toml 
── src/                 
│── your_src_module.jl  
│── other_src_code.jl
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

Let's take a look at the content of 

### Hosting it in GitHub
Bla Bla Bla


# Contents
Here's the full list of contents
```@contents
```

## Documentation
```@meta
CurrentModule = QuantumGeometricComplexity
```

```@autodocs
Modules = [QuantumGeometricComplexity]
```


## Index
```@index
```