function T_out = explicitEulerStep(Nx, Ny, dt, T_in)
% Input:
% Nx: number of interior mesh points in x direction
% Ny: number of interior mesh points in y direction
% dt: time step for explicit Euler method
% T_in: temperature matrix at the current time with boundaries
% 
% Output:
% T_out: temperature matrix at the next time with boundaries

hx = 1 / (Nx + 1); % horizental spacing
hy = 1 / (Ny + 1); % vertical spacing

% initialization with boundaries
T_out = zeros(size(T_in));

% update each interior node with explicit Euler method
for i=2:Nx+1
    for j=2:Ny+1
        T_inxx = (T_in(i-1, j) - 2 * T_in(i, j) + T_in(i+1, j)) / hx^2;
        T_inyy = (T_in(i, j-1) - 2 * T_in(i, j) + T_in(i, j+1)) / hy^2;
        T_out(i, j) = dt * (T_inxx + T_inyy) + T_in(i, j);
    end
end

end