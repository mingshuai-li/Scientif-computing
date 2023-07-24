classdef Utilities
    methods(Static)
        function doublesNum = storage(M)
            % input matrix/vector and output number of stored doubles
            tmp = whos('M');
            doublesNum = tmp.bytes/8;
        end
        function error = errorComp(T_exact, T_approx)
            % calculate the discrete L2-Norm of error 
            error = sqrt(sum((T_exact - T_approx).^2, 'all')/(size(T_exact, 1)*size(T_exact, 2)));
        end
        
        function num = nonzerosNum(Nx, Ny)
            % calculate the number of non-zero entries
            num = 3*4 + (Nx-2)*4*2 + (Ny-2)*4*2 + (Nx-2)*(Ny-2)*5;
        end
        
        function A = padArray(M)
            % pad around the matrix with zeros(boundary values)
            padArrayColumn = zeros(size(M, 1), 1);
            padArrayRow = zeros(1, size(M, 2) + 2);
            A = [padArrayRow ; 
                padArrayColumn , M, padArrayColumn ; 
                padArrayRow];
        end
        
        % Functions for timing
        function T = timeCalFull(Nx, Ny, b)
            T = genFullMatrix(Nx, Ny)\b;
        end
        
        function T = timeCalSparse(Nx, Ny, b)
            T = genSparseMatrix(Nx, Ny)\b;
        end
        
        function T = timeCalGS(Nx, Ny, b)
            T = GaussSeidelSolver(b, Nx, Ny);
        end
    end
end