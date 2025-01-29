# src/MinimalScientificDocs.jl
module Quantum_Geometric_Complexity

    export mul_by_2, mul_by_4

    include("aux.jl")


    using LinearAlgebra
    using Einsum


    function tensor_list(list_of_ops)
        prod = 1
        for op in list_of_ops
            prod = kron(prod,op)
        end
        return prod
    end

    ###########################
    ###########################
    ## Spin 1/2 register O_μ ##
    ###########################
    ###########################

    σ_0 = I(2)
    σ_1 = [[0, 1] [1, 0]]
    σ_2 = [[0, im] [-im, 0]]
    σ_3 = [[1, 0] [0, -1]]

    σ_vec = [σ_0,σ_1,σ_2,σ_3]

    ⊗(A,B) = kron(A,B)

    function σ_n(n)
        if n == 0
            return σ_0
        elseif n == 1
            return σ_1
        elseif n == 2
            return σ_2
        elseif n == 3
            return σ_3
        elseif n == "+"
            return σ_p 
        elseif n == "-"
            return σ_m
        else
            return 0
        end
    end

    function σ_n_j(N,n,j)
        op_list = []
        for i in range(1,N)
            if i == j
                push!(op_list,σ_n(n))
            else
                push!(op_list,σ_n(0))
            end
        end
        return tensor_list(op_list)
    end

    function spin_combinations(i,N_spins)
        return digits(i, base=4, pad=N_spins)
    end

    function O_basis_spin_half(N_spins)
        O_temp = ComplexF64.( ones(2^N_spins, 2^N_spins, 4^N_spins) )
        for n=1:(4^N_spins)
            indx_array =  spin_combinations(n-1,N_spins)
            element = 1
            for m=1:N_spins
                element = element ⊗ σ_vec[indx_array[m]+1]
            end
            O_temp[:,:,n] = element
        end
        return O_temp
    end


    ###########################
    ###########################
    ## Spin 1/1 register O_μ ##
    ###########################
    ###########################

    S_0 = I(3)
    S_x = [[0, 1, 0] [1, 0, 1] [0, 1, 0]] / √(2)
    S_y = im*[[0, 1, 0] [-1, 0, 1] [0, -1, 0]] / √(2)
    S_z = diagm([1,0,-1])

    # I have checked this is an actual basis by taking its determinant
    basis_1 = [
        S_z,
        S_y,
        S_x,
        S_y*S_z + S_z*S_y,
        S_z*S_x + S_x*S_z,
        S_x*S_y + S_y*S_x,
        S_z^2,
        S_y^2,
        S_x^2
    ]

    ###########################
    ###########################
    ## Spin 3/2 register O_μ ##
    ###########################
    ###########################

    J_0 = I(4)
    J_x = [[0, √(3), 0, 0] [√(3), 0, 2, 0] [0, 2, 0, √(3)] [0, 0, √(3), 0]] / 2
    J_y = im*[[0, √(3), 0, 0] [-√(3), 0, 2, 0] [0, -2, 0, √(3)] [0, 0, -√(3), 0]] / 2
    J_z = diagm([3,1,-1,-3])/2

    # I have checked this is an actual basis by taking its determinant
    basis_3_2 = [
        J_y*J_z + J_z*J_y,
        J_z*J_x + J_x*J_z,
        J_x*J_y + J_y*J_x,
        J_z^2,
        J_y^2,
        J_x^2,
        J_y^2*J_z + J_z*J_y^2,
        J_z^2*J_y + J_y*J_z^2,
        J_z^2*J_x + J_x*J_z^2,
        J_x^2*J_z + J_z*J_x^2,
        J_x^2*J_y + J_y*J_x^2,
        J_y^2*J_x + J_x*J_y^2,
        J_z^3,
        J_y^3,
        J_x^3,
        J_x*J_y*J_z + J_y*J_z*J_x + J_z*J_x*J_y + J_y*J_x*J_z + J_z*J_y*J_x + J_x*J_z*J_y
    ]


    function J_n_j(N,n,j)
        op_list = []
        for i in range(1,N)
            if i == j
                push!(op_list,basis_3_2[n])
            else
                push!(op_list,J_0)
            end
        end
        return tensor_list(op_list)
    end

    function spin_three_halfs_combinations(i,N_spins)
        return digits(i, base=16, pad=N_spins)
    end

    function O_basis_spin_three_half(N_spins)
        O_temp = ComplexF64.( ones(4^N_spins, 4^N_spins, 16^N_spins) )
        for n=1:(16^N_spins)
            indx_array =  spin_three_halfs_combinations(n-1,N_spins)
            element = 1
            for m=1:N_spins
                element = element ⊗ basis_3_2[indx_array[m]+1]
            end
            O_temp[:,:,n] = element
        end
        return O_temp
    end


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
    function O_basis_bosons(N)
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

    function O_basis_dual_bosons(N)
        return O_basis_bosons(N) /√(N)
    end


    ############################
    ############################
    ## general functionalities #
    ############################
    ############################

    """
    ρ_vec(ρ, O_basis)

    Converts density matrix `ρ ∈ H×H` to its vector representation in characteristic space `C` spanned by `O`.
    That is, mathematically, it's a function 
    ```
    ρ_vec : H×H,O → C
    ```

    # Performance comment
    This function used to be written as 
    ```
    function ρ_vec(ρ, O_basis)
        N = size(O_basis)[3]
        ρ_temp = ComplexF64.(zeros(N))
        for n=1:N
            ρ_temp[n] = tr(ρ*O_basis[:,:,n])
        end
        return ρ_temp
    end
    ```

    but it had performance issues:
    ```julia-repl
    julia> ρ = rand_ρ(7) # output ommited
    julia> O_basis = O_basis_spin_half(7) # output ommited
    julia> @btime ρ_vec(ρ,O_basis)
    3.413 s (65540 allocations: 8.00 GiB)
    (further output ommited)
    julia> @btime ρ_vec_einsum(ρ,O_basis)
    346.840 ms (2 allocations: 256.05 KiB)
    (further output ommited)
    ```

    so current default implementation is with `Einsum`.

    # Examples
    ```julia-repl
    julia> O_basis = O_basis_spin_half(1)
    2×2×4 Array{ComplexF64, 3}:
    [:, :, 1] =
    0.707107+0.0im       0.0+0.0im
        0.0+0.0im  0.707107+0.0im

    [:, :, 2] =
        0.0+0.0im  0.707107+0.0im
    0.707107+0.0im       0.0+0.0im

    [:, :, 3] =
    0.0+0.0im       0.0+0.707107im
    0.0-0.707107im  0.0+0.0im

    [:, :, 4] =
    0.707107+0.0im        0.0+0.0im
        0.0+0.0im  -0.707107+0.0im

    julia> ψ = [1, 1]/√(2)
    2-element Vector{Float64}:
    0.7071067811865475
    0.7071067811865475

    julia> ρ_vec(ψ*ψ', O_basis)
    4-element Vector{ComplexF64}:
    0.7071067811865474 + 0.0im
    0.7071067811865474 + 0.0im
                    0.0 + 0.0im
                    0.0 + 0.0im
    ```
    """
    function ρ_vec(ρ, O_basis)
        N = size(ρ)[1]
        @einsum ρ_temp[μ] := (1/N) * ρ[j,k]*conj(O_basis[j,k,μ])
        return ρ_temp
    end

    """
    ρ_mat(ρ, O_basis)

    Inverse of `ρ_mat`, that is, converts vector in characteristic space `C` to its Hilbert space representation in `H×H`. That is, mathematically, it's a function 
    ```
    ρ_vec : C,O → H×H
    ```

    # Performance comment
    This function also suffered from performance issues like `ρ_vec(ρ, O_basis)` which were also solved with `Einsum`. For more details see `ρ_vec(ρ, O_basis)` documentation.

    # Examples
    ```julia-repl
    julia> O_basis = O_basis_spin_half(1)
    2×2×4 Array{ComplexF64, 3}:
    [:, :, 1] =
        0.707107+0.0im       0.0+0.0im
            0.0+0.0im  0.707107+0.0im

    [:, :, 2] =
            0.0+0.0im  0.707107+0.0im
        0.707107+0.0im       0.0+0.0im

    [:, :, 3] =
        0.0+0.0im       0.0+0.707107im
        0.0-0.707107im  0.0+0.0im

    [:, :, 4] =
        0.707107+0.0im        0.0+0.0im
            0.0+0.0im  -0.707107+0.0im

    julia> ψ = [1, 1]/√(2)
    2-element Vector{Float64}:
        0.7071067811865475
        0.7071067811865475

    julia> ρ_μ = ρ_vec(ψ*ψ', O_basis)
    4-element Vector{ComplexF64}:
        0.7071067811865474 + 0.0im
        0.7071067811865474 + 0.0im
                    0.0 + 0.0im
                    0.0 + 0.0im

    julia> ρ_mat(ρ_μ, O_basis)
    2×2 Matrix{ComplexF64}:
        0.5+0.0im  0.5+0.0im
        0.5+0.0im  0.5+0.0im

    julia> ψ*ψ'
    2×2 Matrix{Float64}:
        0.5  0.5
        0.5  0.5
    ```
    """
    function ρ_mat(ρ_vec, O_basis)
        @einsum ρ_temp[j,k] :=  ρ_vec[μ]*O_basis[j,k,μ]
        return ρ_temp
    end

    """
    IPR(v)

    Function for calculating the inverse participation ratio.

    Mathematically, given some vector `v` in some basis, this is defined as 
    ```
    IPR(v) ≐ \\sum_n || v_n ||^4.
    ```

    # Examples
    ```julia-repl
    julia> IPR( [1/√(4), 1/√(4), 1/√(4), 1/√(4)]  )
    0.25

    julia> IPR( [1, 0, 0, 0]  )
    1
    ```
    """
    function IPR(v)
        N = length(v)
        ipr = 0
        for n=1:N
            ipr +=  (v[n]' * v[n] )^2
        end
        return real( ipr )
    end

    """
    purity(ρ_μ::Vector)

    Function for calculating the purity of a vector in characteristic space `C`.

    Mathematically, given some vector `ρ` in characteristic space `C`, this is defined as 
    ```
    γ ≐ \\sum_μ  ρ_μ ρ_μ^* ≡ ||ρ||^2
    ```

    # Examples
    ```julia-repl
    julia> ρ_vec_temp = ρ_vec(rand_ρ_pure(3), O_basis_spin_half(3))
    64-element Vector{ComplexF64}:
    0.35355339059327373 + 0.0im
    -0.19777757955054376 - 4.336808689942018e-19im
    -0.07369283640174634 + 5.204170427930421e-18im
    0.030330980132771558 + 0.0im
    0.052689065818701745 + 1.0408340855860843e-17im
                        ⋮
    -0.01752572646095066 + 0.0im
    -0.23462520253833954 + 0.0im
    0.1193174939662679 - 4.336808689942018e-19im
    0.10279530237835932 - 8.673617379884035e-18im
    -0.10936868240286046 + 0.0im

    julia> purity(ρ_vec_temp)
    0.9999999999999999 + 0.0im

    purity

    julia> ρ_vec_temp = ρ_vec(I(2^3)/2^3, O_basis_spin_half(3))
    64-element Vector{ComplexF64}:
    0.35355339059327373 + 0.0im
                    0.0 + 0.0im
                    0.0 + 0.0im
                    0.0 + 0.0im
                    0.0 + 0.0im
                        ⋮
                    0.0 + 0.0im
                    0.0 + 0.0im
                    0.0 + 0.0im
                    0.0 + 0.0im
                    0.0 + 0.0im

    julia> purity(ρ_vec_temp)
    0.12499999999999997

    julia> 1/(2^3)
    0.125

    julia> ρ_vec_temp = ρ_vec(rand_ρ_pure(3), O_basis_spin_half(3))
    64-element Vector{ComplexF64}:
    0.35355339059327373 + 0.0im
    -0.14065223381828953 + 5.204170427930421e-18im
    0.10474649723834337 + 6.071532165918825e-18im
    0.05213855626731899 + 0.0im
    -0.23021903371920083 + 1.3010426069826053e-18im
                        ⋮
    -0.007396885500585001 + 0.0im
    -0.14963824202038384 + 0.0im
    0.0038745649216279177 + 1.734723475976807e-18im
    0.025673666375129044 + 6.071532165918825e-18im
    0.022366636393981332 + 0.0im

    julia> purity(ρ_vec_temp)
    1.0
    ```
    """
    function purity(ρ_μ::Vector)
        N = length(ρ_μ)
        return real( √(N) * ρ_μ'*ρ_μ )
    end


    """
    M(ρ, O_basis)

    Function for calculating the macroscopicity `M` of a density matrix in Hilbert space `H×H`.

    Mathematically, given some matrix `ρ` in `H×H`, this is defined as 
    ```
    M ≐ -log2( IPR_C[ρ] / γ^2 ).
    ```
    This is non trivial so please refer to the paper.

    # Examples
    ```julia-repl
    julia> M(I(2^3)/(2^3), O_basis_spin_half(3))
    -0.0

    julia> M(rand_ρ_pure(3), O_basis_spin_half(3))
    4.062587703134164
    ```
    """
    function M(ρ, O_basis)
        ρ_vec_temp = ρ_vec(ρ, O_basis)
        N_squared = length(ρ_vec_temp)
        IPR_ρ = IPR(ρ_vec_temp)
        γ = purity(ρ_vec_temp)
        return  -log2( N_squared * IPR_ρ / γ^2 ) 
    end 


    function M_vn(ρ, O_basis)
        ρ_μ = ρ_vec(ρ, O_basis)
        N = length(ρ_μ)
        sum_tot = ρ_μ'*ρ_μ
        ent = 0
        for n=1:N
            if ρ_μ[n] != 0
                ent +=  - (ρ_μ[n]' * ρ_μ[n] /sum_tot) * log2(ρ_μ[n]' * ρ_μ[n] /sum_tot)
            end        
        end
        return real( ent )
    end

end # end of module
