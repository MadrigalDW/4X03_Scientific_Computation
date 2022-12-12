clear all;
n = 700;
m = 4;
time = zeros(1, m);
error = zeros(1, m);
N = zeros(1, m);
for i = 1:m
    A = rand(n,n);
    tic;
    B = inverse(A);
    time(i) = toc;
    Ainv = inv(A);
    error(i) = norm(B-Ainv,inf)/norm(Ainv,inf);
    N(i) = n;
    n = 2*n;
    if (i==1)
        fprintf('n= %4d time=% .1e error=%.2e\n', ...
        N(i), time(i), error(i));
    else
        fprintf('n= %4d time=% .1e ratio=%5.1f error=%.2e\n', ...
        N(i), time(i), time(i)/time(i-1),error(i));
    end
end

A = [0.1 0.3 0.7; 0.3 0.6 0.9; 0.6 1.5 3];
svd(A)
cond(A)
temp = A(1,:);
A(1,:) = A(3,:);
A(3,:) = temp;
disp(A)
A(2,:) = A(2,:) - A(1,:)/2;
disp(A)
A(3,:) = A(3,:) - A(1,:)/6;
disp(A)
A(3,:) = A(3,:) + A(2,:)/3;
disp(A)

A = [0.1 0.3 0.7; 0.3 0.6 0.9; 0.6 1.5 3];
b = [1.4; 1.8; 6];
x = A\b;
disp(x)
actual_x = [0; 0; 2];
error = norm(x-actual_x,inf)/norm(actual_x,inf);
disp(error)

X = [1 0.5 0.25; 1 0.75 0.5625; 1 1 1];
Y = [sqrt(pi); sqrt(pi/2); 1];
C = X\Y;
disp(C)
Y_three_halves = [1.5];
X_three_halves = C\Y_three_halves;
disp(X_three_halves)

X = [1 -1 1; 1 0 0; 1 1 1];
Y = [1; 0; 1];
C = X\Y;
disp(C)

f = @(x) (sqrt(x));
x_15 = linspace(0,2,15);
f_15 = f(x_15);

x_100 = linspace(0,2,100);
f_100 = f(x_100);
s = spline(x_15, f_15, x_100);

plot(x_100, f_100, "Color", 'k', 'LineWidth', 1.5)
hold on
plot(x_100, s, "Color", 'c', 'LineWidth', 1)
legend('f(x)', 'p(x)','Location','best')
title('Plotting f(x) & p(x)')
hold off

figure
semilogy(abs(f_100-s))
hold on
title('Error')
hold off

f = @(x) (sqrt(x));
i = linspace(0,14,15);
c_x_15 = (0+2)/2 + ((2-0)/2)*cos(((2*i+1)/(2*14+2)*pi));

x_15 = linspace(0,2,15);
f_15 = f(c_x_15);
p = polyfit(c_x_15, f_15, 14);

x_100 = linspace(0,2,100);
f_100 = f(x_100);
p_100 = polyval(p, x_100);

plot(x_100, f_100, "Color", 'k', 'LineWidth', 1.5)
hold on
plot(x_100, p_100, "Color", 'c', 'LineWidth', 1)
legend('f(x)', 'p(x)','Location','best')
title('Plotting f(x) & p(x)')
hold off

figure
semilogy(abs(f_100-p_100))
hold on
title('Error')
hold off
