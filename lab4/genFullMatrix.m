function A = genFullMatrix(Nx, Ny)
% Input:
% Nx: number of interior mesh points in x direction
% Ny: number of interior mesh points in y direction
%
% Output:
% A: coefficient matrix of linear system of equations Ax = b(general format)

hx = 1 / (Nx + 1);
hy = 1 / (Ny + 1);
hx_2 = 1 / hx^2;
hy_2 = 1 / hy^2;

A = zeros(Nx * Ny);

% Scan along all the nodes column by column from left-bottom corner
for i = 1: Nx * Ny
    % assign values to the diagonal entries
    A(i, i) = -2 * (hx_2 + hy_2);
    
    % Check whether the node is near bottom boundary
    if (mod(i-1, Ny) ~=0)
        A(i,i-1) = hy_2;
    end
    % Check whether the node is near top boundary
    if (mod(i, Ny) ~=0)
        A(i, i+1) = hy_2;
    end
    % Check whether the node is near left boundary
    if (i > Ny)
        A(i, i-Ny) = hx_2;
    end
    % Check whether the node is near right boundary
    if (i <= Nx*Ny-Ny)
        A(i, i+Ny) = hx_2;
    end
end
end


