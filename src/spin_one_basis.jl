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