classdef Utilities
    methods(Static)
        function E = approx_error(dt, t_end, x_exact, x_approx)
            % Approximation Error Computation
            E = sqrt(dt / t_end * sum((x_exact - x_approx).^2));
        end
        function dy = Dahlquist(t, y)
            % Dahlquist's test equation
            dy = -7 * y;
        end
        function df = dDahlquist(t, y)
            % Derivative of Dahlquist's test equation
            df = -7;
        end 
        function dy = VdP_Oscillator(t, y)
            % Van-der-Pol-Oscillator
            dy = zeros(length(y), 1);
            dy(1) = y(2); % Compute the derivative of x
            dy(2) = 4 * (1 - (y(1))^2) * y(2) - y(1); % Compute the derivative of y
        end
        function df = Jacobian(t, y)
            df = [0, 1; -1 - 8*y(1)*y(2), 4 - 4 * y(1)^2];
        end
        
        function stability = checkStabilityA(dt, choice)
        % If choice is 1, we check for expl_euler, otherwise impl_euler.
            % expl_euler will be stable if |1+dt*lamda|<1 where lambda is -7
            % in this problem. 
            if choice == 1
                if abs(1+dt*(-7)) < 1 
                    stability = "X";
                else
                    stability = "-";
                end
            else
                % impl_euler will be stable if |1/(1-dt*lamda)|<1 where lambda is -7
                % in this problem. 
                if abs(1/((1-dt)*(-7))) < 1 
                    stability = "X";
                else
                    stability = "-";
                end
            end
        end
        
        function stability = checkStabilityB(y_approx, y_exact, tol)
            % Compare the approximation to the exact solution
            % If exact solution is not available, we can compare solutions
            % derived from different time steps
            % We think the result is stable when it is convergent to the
            % analytical solution, which means the error vector is
            % monotonically decreasing and the last term is smaller than
            % the tolerance based on the defination of limitation. 
            loc_err = abs(y_exact - y_approx);
            help = (abs(diff(loc_err))< tol);
            if help(end) == 0
                stability = "-";
            elseif sum(diff(help)) > 1
                stability = "-";
            else
                stability = "X";
            end
        end
        
    end
end