using LinearAlgebra

#######################
#######################
## Spin 1/2 register ##
#######################
#######################

σ_0 = I(2)
σ_1 = [[0, 1] [1, 0]]
σ_2 = [[0, im] [-im, 0]]
σ_3 = [[1, 0] [0, -1]]

σ_vec = [σ_0,σ_1,σ_2,σ_3]

"""
σ_n(n)

Returns the Pauli matrix corresponding to the index `n`.

# Arguments
- `n`: Index of the Pauli matrix (0, 1, 2, 3 for I, X, Y, Z).

# Returns
- The corresponding Pauli matrix.
"""
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