clear all;
a = 0.1;
b = 1;
global  xpoints;
f = @(x) sin(1./x); % set up function
q = integral(f, a, b); % actual value of the integral

n_comp = 2;
err_comp = inf; % set up values for composite

while err_comp > 10^-4
    h = (b-a)/n_comp; 
    i1 = 1:n_comp/2;
    i2 = 1:n_comp/2 - 1; % creating arrays of i values for obtaining sums
    t_2i = a + (2.*i2).*h;
    t_2i_1 = a + (2.*i1 - 1).*h; % creating arrays of t values for obtaining sums
    
    Q = (h/3)*(f(a) + 2*sum(f(t_2i)) + 4*sum(f(t_2i_1)) + f(b)); % composite approximation
    err_comp = abs(Q-q);
    n_comp = n_comp + 2;
end

xpoints = [a, b];
[answer, err_ad] = adaptive_simpson(f, a, b, 10^-4);
n_ad = length(xpoints) - 1;
fprintf("composite n = %d\terror = %e\tadaptive n = %d\terror = %e\n", n_comp, err_comp, n_ad, err_ad);

x1 = 0.1:2^-10:1;
z = zeros(length(xpoints),1);
plot(x1, f(x1),"Color", [0.25 0 1])
hold on
plot(xpoints, f(xpoints), '.r')
plot(xpoints, z, 'xr')
title('Adaptive Simpson for sin(1/x)')





