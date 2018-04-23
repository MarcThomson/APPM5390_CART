% Run a simulation for CAR-T cell treatment
% By Marc Thomson & Kevin Sun
clear;clc;close all;

% define time range (hours)
tend = 100;
tspan = [0 tend];

% define initial conditions (healthy, cancer, CAR, suppressor)
y0 = [1;1;0;1];

% define parameters for simulation
specifyParams;

% solve the ODE
dydt  = @(t,y) systemDerivative(t,y,params);
[t,y] = ode23s(dydt,tspan,y0);

% plot the results
plot(t,y,'LineWidth',3);legend('Healthy Cells','Cancer Cells','CAR-T Cells','Regulatory T Cells','Location','East');
xlabel('Time (hours)');
ylabel('Concentration of Cells');
set(gca,'FontSize',20);