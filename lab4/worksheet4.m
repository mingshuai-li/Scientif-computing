clc
clear all
close all

%% Worksheet 4
% 1st to last entries in solution vector corresponds to 
% nodes from left-bottom corner to right-top corner column by columnn

% initialization
N = [3 7 15 31 63 127];
f = @(x,y) -2*pi^2*sin(pi*x)*sin(pi*y);
t_exact = @(x,y) sin(pi*x)*sin(pi*y);
sto = zeros(3,6);
runtime = zeros(3,6);
counter = 0;
error = zeros(1,6);
errorRed = ones(1,6);

% consider different mesh sizes
for n = N
    b = zeros(n*n, 1);
    T_exact = zeros(n);
    counter = counter + 1;
    % analytical solution of temperature
    for i = 1:n
        for j = 1:n
            b((i-1)*n+j) = f(i/(n+1), j/(n+1));
            T_exact(i,j) = t_exact(i/(n+1),j/(n+1));
        end
    end
    
    if n ~= 127
       %% Full matrix solver and visualization
        % timing
        timehandle = @() Utilities.timeCalFull(n, n, b);
        runtime(1,counter) = timeit(timehandle);
        
        % generate the full matrix and reshape the solution vector
        A = genFullMatrix(n, n);
        T1 = A\b;
        T1 = reshape(T1, [n, n]).';
        T1 = Utilities.padArray(T1);
        
        % visualization
        [X, Y] = meshgrid((0:n+1)/(n+1), (0:n+1)/(n+1));
        figure('Name', strcat('Visualization for Nx = Ny = ', num2str(n)))
        subplot(3, 2, 1);
        surf(X, Y, T1);
        colorbar
        title('Coloured surface full matrix solver');
        subplot(3, 2, 2);
        contour(X, Y, T1,'ShowText','on');
        title('Contour plot full matrix solver');
       
        % storage calculation
        sto(1,counter) = sto(1,counter)+Utilities.storage(A);
        sto(1,counter) = sto(1,counter)+Utilities.storage(b);
        sto(1,counter) = sto(1,counter)+Utilities.storage(T1);

       %% Sparse matrix solver and visualization
        % timing
        timehandle = @() Utilities.timeCalSparse(n, n, b);
        runtime(2,counter) = timeit(timehandle);
        
        % generate the sparse matrix and reshape the solution vector
        T2 = genSparseMatrix(n, n)\b;
        T2 = reshape(T2, [n, n]).';
        T2 = Utilities.padArray(T2);
        
        % visualization
        [X, Y] = meshgrid((0:n+1)/(n+1), (0:n+1)/(n+1));
        subplot(3, 2, 3);
        surf(X, Y, T2);
        colorbar
        title('Coloured surface sparse matrix solver');
        subplot(3, 2, 4);
        contour(X, Y, T2,'ShowText','on');
        title('Contour plot sparse matrix solver');

        % storage calculation
        sto(2,counter) = sto(2,counter)+Utilities.storage(genSparseMatrix(n, n));
        sto(2,counter) = sto(2,counter)+Utilities.storage(b);
        sto(2,counter) = sto(2,counter)+Utilities.storage(T2);
    end
   %% Gauss-Seidel solver and visualization
    % timing    
    timehandle = @() Utilities.timeCalGS(n, n, b);
    runtime(3,counter) = timeit(timehandle);
    
    % call Gauss-Seidel solver and pad
    T3 = GaussSeidelSolver(b, n, n);
    error(counter) = Utilities.errorComp(T_exact, T3);
    if(counter > 2)
        errorRed(counter) = error(counter-1)/error(counter);
    end
    T3 = Utilities.padArray(T3);
    
    % visualization
    [X, Y] = meshgrid((0:n+1)/(n+1), (0:n+1)/(n+1));
    if n ~= 127
        subplot(3, 2, 5);
        surf(X, Y, T3.');
        colorbar
        title('Coloured surface GS solver');
        subplot(3, 2, 6);
        contour(X, Y, T3.','ShowText','on');
        title('Contour plot GS solver');
    end
    
    % storage calculation
    sto(3,counter) = sto(3,counter)+Utilities.storage(b);
    sto(3,counter) = sto(3,counter)+Utilities.storage(T3);
end

table([N(2:5); runtime(1,2:5); sto(1,2:5)], 'VariableNames', {'direct_solution_with_full_matrix'}, 'RowNames', {'Nx,Ny' 'runtime' 'storage'})
table([N(2:5); runtime(2,2:5); sto(2,2:5)], 'VariableNames', {'direct_solution_with_sparse_matrix'}, 'RowNames', {'Nx,Ny' 'runtime' 'storage'})
table([N(2:5); runtime(3,2:5); sto(3,2:5)], 'VariableNames', {'iterative_solution_with_Gauss_Seidel'}, 'RowNames', {'Nx,Ny' 'runtime' 'storage'})
table([N(2:6); error(1,2:6); errorRed(1,2:6)], 'VariableNames', {'Gauss_Seidel'}, 'RowNames', {'Nx,Ny' 'error' 'error red.'})
