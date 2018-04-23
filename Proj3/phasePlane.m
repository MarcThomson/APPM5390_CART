clear;close all;clc;
Health0 = 0.5;
Reg0 = 1;
tend = 100;
tspan = [0 tend];
specifyParams;
dydt  = @(t,y) systemDerivative(t,y,params);
dydt2 = @(t,y) -systemDerivative(t,y,params);

can = linspace(0.01,1,10);
car = linspace(0.01,0.3,10);
[X,Y] = meshgrid(can,car);

figure(1);hold on;
for i = 1:numel(X)
    y0 = [Health0;X(i);Y(i);Reg0];
    [t,y] = ode23s(dydt,tspan,y0);
    if y(end,2)>y(end,1)
        plot(y(:,2),y(:,3),'r-')
    else
        plot(y(:,2),y(:,3),'b-')
    end
end


% create a vector plot
v1 = linspace(0.01,1,15);
w1 = linspace(0.01,0.3,15);
[V,W] = meshgrid(v1,w1);

u1 = 0*V;
u2 = u1;
for i = 1:numel(V)
    y0 = [Health0;V(i);W(i);Reg0];
    utemp = dydt(0,y0);
    u1(i) = utemp(2); 
    u2(i) = utemp(3);
end

axis([0.01,1,0.01,0.3]);
AxesHandle=findobj(gcf,'Type','axes');
pos = AxesHandle.Position;
xmin = pos(1);
xmax = pos(3);
ymin = pos(2);
ymax = pos(4);
yrange = ymax-ymin;
xrange  = xmax - xmin;
headWidth = 5;
headLength = 5;

% put arrows on the plot one by one
for ii = 1:length(V)
    for ij = 1:length(V)
        dt = 0.05;
        x0 = V(ii,ij);
        y0 = W(ii,ij);
        x = ([x0, x0+u1(ii,ij)*dt]-0.01)/0.86667;
        x  = x*xrange+xmin;
        y = ([y0, y0 + u2(ii,ij)*dt]-0.01)/0.3/0.85;
        y  = y*yrange+ymin;
         ah = annotation('arrow',x,y,...
         'headStyle','cback3','HeadLength',headLength,'HeadWidth',headWidth);
    end
end
xlabel('V');ylabel('W');set(gca,'FontSize',20);
    
