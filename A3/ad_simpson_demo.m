close all
clear all; close all;
eps = 1e-3;
global  xpoints;

f = @(x)  200./(2*x.^3 - x.^2).*(5*sin(20./x)).^2;
a  = 1.5; b  = 4;

xpoints = [a,b];
q = ad_simpson(f, a, b, eps, 0, 1000, 0 );

plot(xpoints, f(xpoints), '.r')
hold on
fplot(f, [a,b],'b')
z = zeros(length(xpoints),1);
plot(xpoints, z, 'xr')
title('Adaptive simpson on 200./(2*x.^3 - x.^2).*(5*sin(20./x)).^2')



