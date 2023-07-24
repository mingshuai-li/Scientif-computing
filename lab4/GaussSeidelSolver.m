function T = GaussSeidelSolver(b, Nx, Ny)
% Input:
% Nx: number of interior mesh points in x direction
% Ny: number of interior mesh points in y direction
% b: right hand side of the differential equation
%
% Output:
% T: temperatures at the interior nodes

hx = 1 / (Nx + 1);
hy = 1 / (Ny + 1);
hx_2 = 1 / hx^2;
hy_2 = 1 / hy^2;
% Initialize including boundaries
T = zeros(Nx+2, Ny+2);
maxIter = 1e5;
for k = 1:maxIter
% In each iteration, scan and update the temperatures of interior nodes
    for i = 2:Nx+1
        for j = 2:Ny+1
            T(i,j) = (hx_2*(T(i-1,j)+T(i+1,j)) + hy_2*(T(i,j-1)+T(i,j+1)) - b(j-1+(i-2)*Ny)) / (2*(hx_2+hy_2));
        end
    end
    tmp = 0; % used for residual computation after each iteration
    for i = 2:Nx+1
        for j = 2:Ny+1
            tmp = tmp + (b(j-1+(i-2)*Ny) - hx_2*(T(i-1,j)+T(i+1,j)) - hy_2*(T(i,j-1)+T(i,j+1)) + 2*(hx_2+hy_2)*T(i,j))^2;
        end
    end
    res = sqrt(tmp/(Nx*Ny));
    if(res<1e-4) % termination criteria
        T = T(2:end-1, 2:end-1); % only output the interior temperatures
        return
    end
end
disp('The solution is not convergent within the maxIter!');
end

