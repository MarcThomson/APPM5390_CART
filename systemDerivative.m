function deriv = systemDerivative(t,y,params,t0,t1,k0)
% input:
% t = time(hours)
% y = current cell populations
% params = 10x1 vector of model parameters
% output:
% deriv = 4x1 vector of the derivatives

% unpack y
x1 = y(1);
x2 = y(2);
x3 = y(3);
x4 = y(4);

% unpack parameters
alp1 = params(1);
alp2 = params(2);
alp3 = params(3);
alp4 = params(4);
beta1 = params(5);
beta2 = params(6);
beta3 = params(7);
beta4 = params(8);
beta5 = params(9);
eps = params(10);

% calculate the derivative
deriv = 0*y;
deriv(1) = alp1*x1*(1-x1) - beta1*x1*x2 - eps*beta3*x3*x2*x1;
deriv(2) = alp2*x2*(1-x2) - beta2*x1*x2 - beta3*x3*x2;
deriv(3) = alp3*x3*(1-x3) - beta4*x3*x4;
deriv(4) = alp4*x2 + beta5*(1-x4);


if t>t0 && t<t1
    deriv(3)  = deriv(3)+k0;
end

end