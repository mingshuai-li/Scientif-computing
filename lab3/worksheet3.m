clear all
clc

%% Worksheet 3 Exercise a

delta_t = [1/2 1/4 1/8 1/16 1/32];

% Plot the reference solution.
t = 0:0.05:5;
x_t = exp(-7*t);
figure('Name', 'Explicit Euler Method');
grid on; hold on;
plot(t,x_t);
xlabel('t')
ylabel('x(t)')
ylim([-1 1])
hold on

% Explicit Euler Method Initialization.
x_0 = 1;
dt = 1/2;
t_end = 5;
f = @Utilities.Dahlquist;

% Error Vector Initialization
E = zeros(1,5);
E_red = ones(1,5);
% Stability Vector Initialization (expl_euler)
% We consider two types of stability definition, 
% The one is von Neumann stability, 
% The other one is defined by ourselves. 
explStabilityA = strings(1,5);
explStabilityB = strings(1,5);
for i = 1:5
    % Compute the approximate solutions and plot. 
    t = 0:dt:t_end;
    x_exact = exp(-7*t);
    x_t = expl_euler(x_0, dt, t_end, f);
    plot(t, x_t);
    % Error and error reduction computation
    E(i) = Utilities.approx_error(dt, t_end, x_exact, x_t(1, :));
    if i >= 2
        E_red(i) = E(i-1) / E(i);
    end
    % check stability
    explStabilityA(i) = Utilities.checkStabilityA(dt, 1);
    explStabilityB(i) = Utilities.checkStabilityB(x_exact, x_t, 1e-2);
    dt = dt/2;
end
legend('Analytical Solution', '\delta t = 1/2', '\delta t = 1/4', '\delta t = 1/8', '\delta t = 1/16','\delta t = 1/32')
title('Explicit Euler with time steps $\delta (t)=\{\frac{1}{2},\frac{1}{4},\frac{1}{8},\frac{1}{16},\frac{1}{32}\}$', ...
  'interpreter', 'latex');

% Print the error and error reduction with expl_euler as a table. 
table([delta_t; E; E_red], 'VariableNames', {'explicit_Euler_method_q_1'}, 'RowNames', {'delta_t' 'error' 'error red.'})

%% Worksheet 3 Exercise b-f)
% Plot the reference solution.
t = 0:0.05:5;
x_t = exp(-7*t);
figure('Name', 'Implicit Euler Method');
grid on; hold on;
plot(t,x_t);
xlabel('t')
ylabel('x(t)')
ylim([-1 1])
hold on

% Implicit Euler Method Initialization.
x_0 = 1;
dt = 1/2;
t_end = 5;
f = @Utilities.Dahlquist;
df = @Utilities.dDahlquist;

% Error Vector Initialization
E = zeros(1,5);
E_red = ones(1,5);
% Stability Vector Initialization (impl_euler)
implStabilityA = strings(1,5);
implStabilityB = strings(1,5);
for i = 1:5
    % Compute the approximated solutions and plot. 
    t = 0:dt:t_end;
    x_exact = exp(-7*t);
    x_t = impl_euler(x_0, dt, t_end, f, df);
    plot(t, x_t);
    % Error and error reduction computation
    E(i) = Utilities.approx_error(dt, t_end, x_exact, x_t(1, :));
    if i >= 2
        E_red(i) = E(i-1) / E(i);
    end
    implStabilityA(i) = Utilities.checkStabilityA(dt, 2);
    implStabilityB(i) = Utilities.checkStabilityB(x_exact, x_t, 1e-2);
    dt = dt/2;
end
legend('Analytical Solution', '\delta t = 1/2', '\delta t = 1/4', '\delta t = 1/8', '\delta t = 1/16','\delta t = 1/32')
title('Implicit Euler with time steps $\delta (t)=\{\frac{1}{2},\frac{1}{4},\frac{1}{8},\frac{1}{16},\frac{1}{32}\}$', ...
  'interpreter', 'latex');
% Print the error and error reduction with impl_euler as a table. 
table([delta_t; E; E_red], 'VariableNames', {'implicit_Euler_method_q_1'}, 'RowNames', {'delta_t' 'error' 'error red.'})
% Print stable cases as a table. 
table([delta_t; explStabilityA; implStabilityA], 'VariableNames', {'Stable cases A'}, 'RowNames', {'delta_t' 'Explicit Euler' 'Implicit Euler'})
table([delta_t; explStabilityB; implStabilityB], 'VariableNames', {'Stable cases B'}, 'RowNames', {'delta_t' 'Explicit Euler' 'Implicit Euler'})

%% Worksheet 3 Exercise g)
% Initialization
t = 0:0.1:20;
Fun = @Utilities.VdP_Oscillator;
x_0 = [1; 1];
dt = 0.1;
t_end = 20;

x = expl_euler(x_0, dt, t_end, Fun);
figure('Name', 'Approximate Solutions with Explicit Euler method for Van-der-Pol-Oscillator');
%Subplot u vs. t (function value). 
subplot(3, 1, 1);
grid on; grid minor; hold on;
plot(t, x(1, :));
xlabel('t')
ylabel('u(t)')
title('u vs. t');

%Subplot v vs. t (derivative). 
subplot(3, 1, 2);
grid on; grid minor; hold on;
plot(t,x(2, :));
xlabel('t')
ylabel('v(t)')
title('v vs. t');

%Subplot v vs. u. 
subplot(3, 1, 3);
grid on; grid minor; hold on;
plot(x(1, :), x(2, :));
xlabel('u')
ylabel('v')
title('v vs. u');

%% Worksheet 3 Exercise h)&i)

df = @Utilities.Jacobian;

x = impl_euler(x_0, dt, t_end, Fun, df);

figure('Name', 'Approximate Solutions with Implicit Euler method for Van-der-Pol-Oscillator');
%Subplot u vs. t. 
subplot(3, 1, 1);
grid on; grid minor; hold on;
plot(t, x(1, :));
xlabel('t')
ylabel('u(t)')
title('u vs. t');

%Subplot v vs. t. 
subplot(3, 1, 2);
grid on; grid minor; hold on;
plot(t,x(2, :));
xlabel('t')
ylabel('v(t)')
title('v vs. t');

%Subplot v vs.u. 
subplot(3, 1, 3);
grid on; grid minor; hold on;
plot(x(1, :), x(2, :));
xlabel('u')
ylabel('v')
title('v vs. u');









    
