
#######################
#######################
## Spin 3/2 register ##
#######################
#######################

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