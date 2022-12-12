% A4 Q5

y0 = [2; 1];
tspan = [0 100];
y1_100 = exp(-10) + exp(-20000);
y2_100 = exp(-20000);
table = cell(13, 5);
table(1, :) = {'tol', 'nfevals', 'err_y1', 'err_y2', 'avg stepsize'};

for i = 1:12
    tol = 10^-i;
    options = odeset('AbsTol', tol);
    sol = ode45(@ivp, tspan, y0, options);
    err1 = abs(y(end, 1) - y1_100);
    err2 = abs(y(end, 2) - y2_100);
    row = {tol, sol.stats.nfevals, err1, err2, 100/sol.stats.nsteps};
    table(i+1, :) = row;
end
disp(table)

options = odeset('AbsTol', 1e-7);
sol = ode45(@ivp, tspan, y0, options);
stepsize = zeros(1, length(sol.x)-1);
for i = 1:length(sol.x)-1
    stepsize(i) = sol.x(i + 1) - sol.x(i);
end
t = sol.x(1:length(sol.x)-1);

figure(1)
plot(t, stepsize)
title('stepsize vs t for tolerance 10^-^7');
xlabel('Time t');
ylabel('Stepsize');

figure(2)
options = odeset('AbsTol', 1e-7, 'OutputFcn', @odeplot);
sol = ode23s(@ivp, tspan, y0, options);
disp(sol.stats.nfevals)

function dydt = ivp(t, y)
    dydt = [-0.1*y(1) - 199.9*y(2); -200*y(2)];
end