classdef Utilities
    methods(Static)
        function E = approx_error(dt, t_end, x_exact, x_approx)
            % Approximation Error Computation
            E = sqrt(dt / t_end * sum((x_exact - x_approx).^2));
        end
        function dy = Dahlquist(t, y)
            % Dahlquist's test equation
            dy = zeros(size(y));
            dy = -y;
        end
        function dy = VdP_Oscillator(t, y)
            % Van-der-Pol-Oscillator
            dy = zeros(size(y));
            dy(1) = y(2);
            dy(2) = (1 - (y(1))^2) * y(2) - y(1);
        end
    end
end