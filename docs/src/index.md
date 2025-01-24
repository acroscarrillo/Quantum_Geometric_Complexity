# What is this?
Here you will learn how to make a documentation website like this one using exclusively Julia thanks to Documenter.jl from scratch for absolute beginners.

# Welcome!
This toy documentation is ment to serve as a minimal working template for your scientific work. In particular, it is well suited for basic repositories which are structured around a `/src` folder containing all the heavy lifting code which numerical experiments (inside, say `/experiments`) use. Of course, you may do something else and still find these docs useful. Ideally, all scientific papers should be accompanied by a documentation page (like this one) for faster communication/understanding and reproduction/usage. Enjoy! 

It took me a while to figure this one out so I thought I might as well share it!

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

### What we need to do
Bla bla bla

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