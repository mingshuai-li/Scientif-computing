function y = newtonMethod(y_0, G, dG)
% This method is already extended to vector valued functions. 
maxIter = 100;
tol = 1e-8;
y = y_0;

for i=1:maxIter
    dTmp = dG(y);
% Stop newton method when determinant of dG is 0 
    if abs(det(dTmp)) <= 1e-8
        y = NaN;
        return        
    end
    y_tmp = y - dTmp \ G(y_0, y);
    % return the approximate root when the max norm of the difference between 
    % two adjacent steps is smaller than tol
    if max(abs(y_tmp-y)) < tol
        y = y_tmp;
        return
    end
    y = y_tmp;
end
% didn't find the fullfiled root within set maxIter
y = NaN;
end

