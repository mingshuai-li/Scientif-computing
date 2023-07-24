clc; 
clear all; 
close all;

disp('T is 0 anywhere in the region when t tends to infinity. ')
delta_t = [1/64, 1/128, 1/256, 1/512, 1/1024, 1/2048, 1/4096];
N = [3, 7, 15, 31];

%% Explicit Euler

% Create four figures containing the plots in groups, and enlarge them. 
for i = 1:4
    figure('Name', strcat('Explicit Euler at t = ', num2str(i), '/8'));
    set(gcf, 'Position', get(0, 'ScreenSize'));
end

% Initialization
t_end = 4/8;
plotIndex = 1;
stabilityMatrix =zeros(4, 7);
for n = N
    for dt = delta_t
        % for each case, call explicit Euler until t_end
        T = zeros(n+2);
        T(2:end-1, 2:end-1) = 1;
        for t = dt : dt : t_end
            T = explicitEulerStep(n, n, dt, T);
            if (mod(t, 1/8) == 0) % Plot at some times
                figure(8*t); % Open the respective figure
                tmp = subplot(4, 7, plotIndex);
                [X, Y] = meshgrid(linspace(0, 1, n+2), linspace(0, 1, n+2));
                surf(X, Y, T.');
                title(strcat('t=', num2str(8*t), '/8', ', Nx=Ny=', num2str(n), ', dt=', strtrim(rats(dt))));
                % your MATLAB should be newer than R2020a for
                % exportgraphics, which extracts subplots and saves them
                % individually
                exportgraphics(tmp, strcat('Explicit Euler at t=', num2str(8*t), ']8', ' with Nx=Ny=', num2str(n), ', dt=1]', num2str(1/dt), '.jpeg'));
            end
        end
        plotIndex = plotIndex + 1;

        % Check stability manually (1 means stable and 0 means unstable)
        if (all(all(T >= 0 & T <= 1)))
            stabilityMatrix(log2(n+1)-1, -log2(dt)-5) = 1;
        end
    end
end

% Print stability table
stabilityTable = table(["3"; "7"; "15"; "31"], [ stabilityMatrix(:, 1)], [stabilityMatrix(:, 2)], [stabilityMatrix(:, 3)], [stabilityMatrix(:, 4)], [stabilityMatrix(:, 5)], [stabilityMatrix(:, 6)], [stabilityMatrix(:, 7)]);
stabilityTable.Properties.VariableNames = ["Nx = Ny", "dt = 1/64", "dt = 1/128", "dt = 1/256", "dt = 1/512", "dt = 1/1024", "dt = 1/2048", "dt = 1/4096"]

%% Implicit Euler

% Create four figures containing the plots in groups, and enlarge them. 
for i = 1:4
    figure('Name', strcat('Implicit Euler at t = ', num2str(i), '/8'));
    set(gcf, 'Position', get(0, 'ScreenSize'));
end

% Initialization
plotIndex = 1;
dt = 1/64;
for n = N
    T = zeros(n+2);
    T(2:end-1, 2:end-1) = 1;
    % for each case, call explicit Euler until t_end
    for t = dt : dt : t_end
        T = implicitEulerStep(n, n, dt, T);
        if (mod(t, 1/8) == 0) % Plot at some times
            figure(8*t + 4); % Open the respective figure
            subplot(2, 2, plotIndex)
            [X, Y] = meshgrid(linspace(0, 1, n+2), linspace(0, 1, n+2));
            surf(X, Y, T.');
            title(strcat('t=', num2str(8*t), '/8', ', Nx=Ny=', num2str(n), ', dt=', strtrim(rats(dt))));
        end
    end
    plotIndex = plotIndex + 1;
end