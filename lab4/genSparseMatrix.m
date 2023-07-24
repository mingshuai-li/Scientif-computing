function A = genSparseMatrix(Nx, Ny)
% Input:
% Nx: number of interior mesh points in x direction
% Ny: number of interior mesh points in y direction
%
% Output:
% A: coefficient matrix of linear system of equations Ax = b(sparse format)

N = Nx * Ny;
hx = 1 / (Nx + 1);
hy = 1 / (Ny + 1);
hx_2 = 1 / hx^2;
hy_2 = 1 / hy^2;

% generate sparse matrix only including the diagonal entries
diaEntries = ones(1, N) * (-2) * (hx_2 + hy_2);
D = sparse(1:N, 1:N, diaEntries, N, N);

% generate sparse matrix only including entries above and near digonals
triDiaEntries = ones(1, N-Nx) * hy_2;
% compute row indices of these entries
tmp = rot90(reshape(1:N, [Ny, Nx]).');
tmp(1, :) = [];
rowIndices = reshape(tmp, 1, N-Nx);
% compute row indices of these entries
columnIndices = rowIndices+1;
T = sparse(rowIndices, columnIndices, triDiaEntries, N, N);

% generate sparse matrix only including entries above and far from digonals
penDiaEntries = ones(1, N-Ny) * hx_2;
P = sparse(1:N-Ny, Ny+1:N, penDiaEntries, N, N);

% compose ultimate sparse matrix with five sub-matrices
A = D + P + P.' + T + T.';
end

