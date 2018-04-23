% Specify Model Parameters
% By Marc Thomson & Kevin Sun

% define parameters
alpha1 = 0.2;
alpha2 = 0.5;
alpha3 = 1;
alpha4 = 1;
beta1 = 0.5;
beta2 = 0.55;
beta3 = 2;
beta4 = 0.8;
beta5 = beta4;
eps = 0.1;

% pack parameters
params = zeros(10,1);
params(1) = alpha1;
params(2) = alpha2;
params(3) = alpha3;
params(4) = alpha4;
params(5) = beta1;
params(6) = beta2;
params(7) = beta3;
params(8) = beta4;
params(9) = beta5;
params(10) = eps;


% test condiitions for stability
% cancer lose w/o CAR
cond1 = (alpha2 - beta2) < 0;
cond2 = (alpha3 - beta4) < 0;
% cancer lose w/ CAR
cond3 = alpha3>beta4;
cond4 = (alpha2*alpha3 - alpha1*beta2 - alpha3*beta3 + beta3*beta4)<0;
% cancer win 
cond5 = alpha3*sqrt(beta5) - beta4*sqrt(alpha4 + beta5)<0;
cond6 = beta1 > alpha1;

% display stable steady states
if cond1 && cond2
    disp('Steady state 1 is stable')
end
if cond3 && cond4
    disp('Steady state 2 is stable')
end
if cond5 && cond6
    disp('Steady state 3 is stable')
end