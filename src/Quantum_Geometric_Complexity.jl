module Quantum_Geometric_Complexity

    export mul_by_2, mul_by_4

    include("spin_half_basis.jl")
    include("spin_one_half_basis.jl")
    include("clock_shift_basis.jl")


    using LinearAlgebra
    using Einsum


    """
    ⊗(A, B)

    Computes the Kronecker product of two matrices A and B.
    """
    ⊗(A,B) = kron(A,B)


    """
    tensor_list(list_of_ops)

    Computes the Kronecker product of a list of matrices.

    # Arguments
    - `list_of_ops`: A list of matrices.

    # Returns
    - The Kronecker product of all matrices in the list.
    """
    function tensor_list(list_of_ops)
        prod = 1
        for op in list_of_ops
            prod = kron(prod,op)
        end
        return prod
    end

    """
    ρ_vec(ρ, O_basis)

    Converts density matrix $ρ \in \mathcal{H} \times \mathcal{H}$ to its vector representation in characteristic space `C` spanned by `O`.
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
                ent +=  - (ρ_μ[n]' * ρ_μ[n] /sum_tot) * log2(ρ_μ[n]' * ρ_μ[n] / sum_tot)
            end        
        end
        return real( ent )
    end

end # end of module