function T_out = implicitEulerStep(Nx, Ny, dt, T_in)
% Input:
% Nx: number of interior mesh points in x direction
% Ny: number of interior mesh points in y direction
% dt: time step for implicit Euler method
% T_in: temperature matrix at the current time with boundaries
% 
% Output:
% T_out: temperature matrix at the next time with boundaries

hx = 1 / (Nx + 1); % horizental spacing
hy = 1 / (Ny + 1); % vertical spacing

% initial guess for Gauss-Seidel iterations
T_out = T_in;

maxIter = 1e5;
for k = 1:maxIter
    % In each iteration, update each interior node with implicit Euler
    for i = 2:Nx+1
        for j = 2:Ny+1
            tmpx = dt * (T_out(i-1, j) + T_out(i+1, j)) / hx^2;
            tmpy = dt * (T_out(i, j-1) + T_out(i, j+1)) / hy^2;
            T_out(i, j) = (T_in(i, j) + tmpx + tmpy) / (1 + 2*dt*(1/hx^2 + 1/hy^2));
        end
    end
    % residual computation after each iteration
    res = 0;
    for i = 2:Nx+1
        for j = 2:Ny+1
            tmpx = dt * (T_out(i-1, j) + T_out(i+1, j)) / hx^2;
            tmpy = dt * (T_out(i, j-1) + T_out(i, j+1)) / hy^2;
            res = res + (-T_out(i, j) * (1 + 2*dt*(1/hx^2 + 1/hy^2)) + T_in(i, j) + tmpx + tmpy)^2;
        end
    end
    res = sqrt(res/(Nx*Ny));
    if(res < 1e-6) % termination criterion
        return
    end
end
disp('The solution is not convergent within the maxIter!');
end