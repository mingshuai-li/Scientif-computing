function approx_sol = impl_euler(y_0, dt, t_end, f, df)
% This function has been extended to account for vector valued functions
% and scalar valued functions. 

% Initialization
t = 0:dt:t_end;
approx_sol = zeros(length(y_0), length(t));
approx_sol(:,1) = y_0;

G = @(y, y1) y1 - dt*f(t, y1) - y;
dG = @(y) eye(length(y_0)) - dt*df(t, y);

for i=1:length(t)-1
    % Find the approximate function value at the next step with Newton
    % Method. 
    approx_sol(:, i+1) = newtonMethod(approx_sol(:, i), G, dG);
    
    if sum(isnan(approx_sol(:, i))) > 0
        approx_sol = NaN;
        break
    end
        
end

end


