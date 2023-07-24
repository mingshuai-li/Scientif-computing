function approx_sol = runge_kutta4(y_0, dt, t_end, f)
% This function has been extended to account for vector valued functions
% and scalar valued functions. 

% Initialization
t = 0:dt:t_end;
approx_sol = zeros(length(t), length(y_0));
approx_sol(1, :) = y_0;

t_size = length(t);
for i = 1:t_size - 1
    Y1 = f(t(i), approx_sol(i,:));
    Y2 = f(t(i)+0.5 * dt, approx_sol(i,:) + 0.5 * dt.* Y1);
    Y3 = f(t(i)+0.5 * dt, approx_sol(i,:) + 0.5 * dt.* Y2);
    Y4 = f(t(i)+dt, approx_sol(i,:) + dt.* Y3);
    approx_sol(i+1, :) = approx_sol(i, :) + 1/6 * dt .* (Y1 + 2 * Y2 + 2 * Y3 + Y4);
end
end