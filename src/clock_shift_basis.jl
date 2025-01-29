using LinearAlgebra

##############################
##############################
## Clock Shift register O_μ ##
##############################
##############################


function Shift(N)
    S_temp = zeros(N,N)
    for n=1:(N-1)
        S_temp[n+1,n] = 1
    end
    S_temp[1,end] = 1
    return S_temp
end

"""
Clock(N)

FINISH!! 

Return the Clock matrix...

# Performance comment
It is much more efficient if returned in `Diagonal` object:
```julia-repl
julia> @btime Clock(1000)^2 # Diagonal object
v  11.125 μs (3 allocations: 39.75 KiB)
1000×1000 Diagonal{ComplexF64, Vector{ComplexF64}}:
    (output ommitted)

julia> @btime Clock_diagm(1000)^2 # Matrix object
37.858 ms (6 allocations: 30.54 MiB)
1000×1000 Matrix{ComplexF64}:
    (output ommitted)
````
"""
function Clock(N)
    n_array = Vector(0:N-1)
    diag = exp.(im * 2 * π .* n_array ./ N)
    return Diagonal(diag)
end

"""
# Performance comment
Some benchmarks:
```julia-repl
julia> @btime O_basis_bosons(20)
885.291 μs (1286 allocations: 11.59 MiB)
20×20×400 Array{ComplexF64, 3}:

julia> @btime O_basis_bosons(100)
1.105 s (51410 allocations: 6.78 GiB)
```
so we seem to be limited by memory unsurprisingly again.
"""
function CS_basis_bosons(N)
    S_temp = Shift(N)
    C_temp = Clock(N)

    O_temp = ComplexF64.( ones(N, N, N^2) )

    counter = 1
    for jj=0:N-1
        j = jj+N÷2
        S_temp_pwred = S_temp^(j)
        for kk=0:N-1
            k = kk-N÷2
            C_temp_pwred = C_temp^(k)
            exponent = exp( -im* 1 * π * j * k / N )
            O_temp[:,:,counter] = exponent * C_temp_pwred * S_temp_pwred
            counter += 1
        end
    end 
    return O_temp
end

function CS_basis_dual_bosons(N)
    return CS_basis_bosons(N) /√(N)
end