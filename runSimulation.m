% Run a simulation for CAR-T cell treatment
% By Marc Thomson & Kevin Sun
%clear;clc;close all;


t0 = 90;
t1 = 144;
k0 = 0.5;
% define time range (hours)
tend = 200;
tspan = [0 tend];

% define initial conditions (healthy, cancer, CAR, suppressor)
y0 = [1;.001;0;1];

% define parameters for simulation
specifyParams;

% solve the ODE
dydt  = @(t,y) systemDerivative(t,y,params,t0,t1,k0);
[t,y] = ode23s(dydt,tspan,y0);

% plot the results
figure(1);%clf;
plot(t,y,'LineWidth',3);legend('Healthy Cells','Cancer Cells','CAR-T Cells','Regulatory T Cells','Location','East');
xlabel('Time (hours)');
ylabel('Concentration of Cells');
set(gca,'FontSize',20);