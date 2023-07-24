clear all
clc

%% Worksheet 2 Exercise a)

% Plot the exact function. 
t = 0:0.05:5;
x_exact = exp(-t);

figure('Name', 'Analytical Solution');
grid on; hold on;
plot(t,x_exact);
xlabel('t')
ylabel('x(t)')
legend('x(t)')
title('Graph of $x(t)={e^{-t}}$', 'interpreter', 'latex');


%% Worksheet 2 Exercise b) & c) 

delta_t = [1 1/2 1/4 1/8];

% Plot the reference solution.
t = 0:0.05:5;
x_t = exp(-t);
figure('Name', 'Explicit Euler Method');
grid on; hold on;
plot(t,x_t);
xlabel('t')
ylabel('x(t)')
hold on

% Explicit Euler Method Initialization.
x_0 = 1;
dt = 1;
t_end = 5;
f = @Utilities.Dahlquist;

% Error Vector Initialization
E = zeros(1,4);
E_red = ones(1,4);

for i = 1:4
    % Compute the approximated solutions and plot. 
    t = 0:dt:t_end;
    x_exact = exp(-t);
    x_t = expl_euler(x_0, dt, t_end, f);
    plot(t, x_t);
    % Error and error reduction computation
    E(i) = Utilities.approx_error(dt, t_end, x_exact, x_t(:, 1).');
    if i >= 2
        E_red(i) = E(i-1) / E(i);
    end
    dt = dt/2;
end
legend('Analytical Solution', '\delta t = 1', '\delta t = 1/2', '\delta t = 1/4', '\delta t = 1/8')
title('Explicit Euler with time steps $\delta (t)=\{1,\frac{1}{2},\frac{1}{4},\frac{1}{8}\}$', ...
  'interpreter', 'latex');

% Print the error and error reduction as a table. 
table([delta_t; E; E_red], 'VariableNames', {'explicit_Euler_method_q_1'}, 'RowNames', {'delta_t' 'error' 'error red.'})

% Plot the reference solution.
t = 0:0.05:5;
x_t = exp(-t);
figure('Name', 'Heun Method');
grid on; hold on;
plot(t,x_t);
xlabel('t')
ylabel('x(t)')
hold on

% Heun Method Initialization.
x_0 = 1;
dt = 1;
t_end = 5;
f = @Utilities.Dahlquist;

% Error vector initialization
E = zeros(1,4);
E_red = ones(1,4);
for i = 1:4
    % Compute the approximated solutions and plot.
    t = 0:dt:t_end;
    x_exact = exp(-t);
    x_t = heun(x_0, dt, t_end, f);
    plot(t, x_t);
    % Error and error reduction computation
    E(i) = Utilities.approx_error(dt, t_end, x_exact, x_t(:, 1).');
    if i >= 2
        E_red(i) = E(i-1) / E(i);
    end
    dt = dt/2;
end
legend('Analytical Solution', '\delta t = 1', '\delta t = 1/2', '\delta t = 1/4', '\delta t = 1/8')
title('Heun Method with time steps $\delta (t)=\{1,\frac{1}{2},\frac{1}{4},\frac{1}{8}\}$', ...
  'interpreter', 'latex');

% Print the error and error reduction as a table. 
table([delta_t; E; E_red], 'VariableNames', {'Heun_method_q_2'}, 'RowNames', {'delta_t' 'error' 'error red.'})

% Plot the reference solution.
t = 0:0.05:5;
x_t = exp(-t);
figure('Name', 'Runge-Kutta Method (Fourth Order) ');
grid on; hold on;
plot(t,x_t);
xlabel('t')
ylabel('x(t)')
hold on

% Runge-Kutta Method (Fourth Order) initialization 
x_0 = 1;
dt = 1;
t_end = 5;
f = @Utilities.Dahlquist;

% Error vector initialization
E = zeros(1,4);
E_red = ones(1,4);

for i = 1:4
    % Compute the approximated solutions and plot.
    t = 0:dt:t_end;
    x_exact = exp(-t);
    x_t = runge_kutta4(x_0, dt, t_end, f);
    plot(t, x_t);
    % Error and error reduction computation
    E(i) = Utilities.approx_error(dt, t_end, x_exact, x_t(:, 1).');
    if i >= 2
        E_red(i) = E(i-1) / E(i);
    end
    dt = dt/2;
end
legend('Analytical Solution', '\delta t = 1', '\delta t = 1/2', '\delta t = 1/4', '\delta t = 1/8')
title('Runge-Kutta Method (Fourth Order) with time steps $\delta (t)=\{1,\frac{1}{2},\frac{1}{4},\frac{1}{8}\}$', ...
  'interpreter', 'latex');

% Print the error and error reduction as a table. 
table([delta_t; E; E_red], 'VariableNames', {'Runge_Kutta_method_q_4'}, 'RowNames', {'delta_t' 'error' 'error red.'})


%% Worksheet 2 Exercise e)
% Initialization
t = 0:0.1:20;
Fun = @Utilities.VdP_Oscillator;
x_0 = [1, 1];
dt = 0.1;
t_end = 20;

% Ultilize the extended Heun Method.
x = heun(x_0, dt, t_end, Fun);

figure('Name', 'Approximate Solutions for Van-der-Pol-Oscillator');
% Subplot x vs. t. 
subplot(3, 1, 1);
grid on; grid minor; hold on;
plot(t, x(:, 1));
xlabel('t')
ylabel('x(t)')
title('x vs. t');

% Subplot y vs. t. 
subplot(3, 1, 2);
grid on; grid minor; hold on;
plot(t,x(:,2));
xlabel('t')
ylabel('y(t)')
title('y vs. t');

% Subplot y vs. x. 
subplot(3, 1, 3);
grid on; grid minor; hold on;
plot(x(:, 1), x(:, 2));
xlabel('x')
ylabel('y')
title('y vs. x');

%% Worksheet 2 Exercise e) Optional
figure('Name', 'Phase Space Visualization');

[x_mesh, y_mesh] = meshgrid(-3:0.3:3, -3:0.3:3);
U = y_mesh;
V = (1 - x_mesh.^2).* y_mesh - x_mesh;

% Normalization of the length of arrows
M = sqrt(U.^2+V.^2);
scaler1=1./M;
U=U.*scaler1;
V=V.*scaler1;

% Generate visualization 
quiver(x_mesh, y_mesh, U, V, 0.5)
title('Phase Space Vector Field Visualization');
xlabel('x')
ylabel('y')








    
