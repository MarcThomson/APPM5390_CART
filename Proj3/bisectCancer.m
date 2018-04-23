function [critInput, exitFlag]  = bisectCancer(y0, params)
   % finds the minimum dosage for cancer eradication
   % input:
   % y0 = 4x1 vector of initial conditions. The third entry (CAR-T) does
   % not matter
   % params = 10x1 vector of model parameters
   % output:
   % critInput = minimum CAR concentration
   % exitFlag = convergence information. 0 = converged, 1 = cancer wins for
   % any dosage, -1 = cancer loses with any dosage
   
   % define tolerance for minimum concentration
   tol = 1E-5;
   
   % define time for integration
   tend = 300;
   tspan = [1 , tend];
   
   % define the derivative
   dydt  = @(t,y) systemDerivative(t,y,params);
   
   % initialize the exit flag
   exitFlag = 0;
   
   % test if cancer wins for any dosage
   y0(3) = 1;
   [t,y] = ode23s(dydt,tspan,y0);
   if (y(end,1) - y(end,2)) < 0
       exitFlag = 1;
       critInput = 1;
   end
   
   % test if cancer loses for any dosage
   y0(3) = 0;
   [t,y] = ode23s(dydt,tspan,y0);
   if (y(end,1) - y(end,2)) > 0
       exitFlag = -1;
       critInput = 0;
   end
   
   % perform bisection
   if exitFlag == 0
       a = 0;
       b = 1;
       while b-a > tol
            h = (a+b)/2;
            y0(3) = h;
            [t,y] = ode23s(dydt,tspan,y0);
            if (y(end,1) - y(end,2)) > 0
                b = h;
            else
                a = h;
            end
       end
       critInput = (a+b)/2;
   end
   
end