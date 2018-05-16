% Find and plot minimum dosages for CAR-T cell treatment
% By Marc Thomson & Kevin Sun

clear;close all;clc

% define model parameters
specifyParams;

% define the resolution of the plot
nsteps = 20;
h = 1/(nsteps+1);

% define the ranges of tested initial concentrations
Can0 = linspace(h,1,nsteps);
Health0 = linspace(h,1,nsteps);
[X,Y] = meshgrid(Health0,Can0);
reg0 = 1; % initial regulatory T-Cell conentration

% get the critical values
critInput = 0*X;
exitFlag = 0*X;
for i = 1:numel(X)
    y0 = [X(i);Y(i);0;reg0];
    [critInput(i), exitFlag(i)]  = bisectCancer(y0, params);
end

% plot the results
surf(X,Y,critInput);
shading interp 
colormap(jet.^0.5)
view(2);
axis square
xlim([h,1]);
ylim([h,1]);
xlabel('Initial Healthy Cell Concentration');
ylabel('Initial Cancer Cell Concentration');
title('Dosage Requirements for Various Cancer States')
cb = colorbar;
ylabel(cb, 'Necesary Initial Car-T Concentration')

set(gca,'FontSize',20);