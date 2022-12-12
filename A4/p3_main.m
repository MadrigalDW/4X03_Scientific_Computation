% A4 Q3
% a)
warning('off', 'all')
funA = @partA;
funB = @partB;
funC = @partC;
funD = @partD;

x0 = {15 -2};
f = {@(x1, x2) x1 + x2.*(x2.*(5 - x2) - 2) - 13; @(x1, x2) x1 + x2.*(x2.*(1 + x2) - 14) - 29};                              % initializing each function to equal zero
df = {@(x1, x2) 1 @(x1, x2) -x2.*(x2.*2 - 5) - x2.*(x2 - 5)-2; @(x1, x2) 1 @(x1, x2) x2.*(x2.*2 + 1) + x2.*(x2 + 1) - 14};  % initializing each partial derivative

[x_ans, n] = newtons_method(x0, f, df, 10^-6);
x1 = 15;
x2 = -2;
x0 = [x1 x2];
[x_fsolve, ~] = fsolve(@(x) partA(x1, x2), x0);
fprintf("Newton's Method:\tx1: %d  x2: %d   n: %d\nfsolve:\t\t\t\tx1: %d x2: %d\n\n", x_ans(1), x_ans(2), n, x_fsolve(1, 1), x_fsolve(1, 2));

% b)
x0 = {(1 + sqrt(3))/2 (1 - sqrt(3))/2 sqrt(3)};
f = {@(x1, x2, x3) x1.^2 + x2.^2 + x3.^2 - 5; @(x1, x2, x3) x1 + x2 - 1; @(x1, x2, x3) x1 + x3 - 3};
df = {@(x1, x2, x3) 2.*x1 @(x1, x2, x3) 2.*x2 @(x1, x2, x3) 2.*x3; @(x1, x2, x3) 1 @(x1, x2, x3) 1 @(x1, x2, x3) 0; @(x1, x2, x3) 1 @(x1, x2, x3) 0 @(x1, x2, x3) 1};

[x_ans, n] = newtons_method(x0, f, df, 10^-6);
x1 = (1 + sqrt(3))/2;
x2 = (1 - sqrt(3))/2;
x3 = sqrt(3);
x0 = [x1 x2 x3];
[x_fsolve, ~] = fsolve(@(x) partB(x1, x2, x3), x0);
fprintf("Newton's Method:\tx1: %f  x2: %f  x3: %f  n: %d\nfsolve:\t\t\t\tx1: %f  x2: %f  x3: %f\n\n", x_ans(1), x_ans(2), x_ans(3), n, x_fsolve(1, 1), x_fsolve(1, 2), x_fsolve(1, 3));

% c)
x0 = {1 2 1 1};
f = {@(x1, x2, x3, x4) x1 + 10.*x2; @(x1, x2, x3, x4) sqrt(5).*(x3 - x4); @(x1, x2, x3, x4) (x2 - x3).^2; @(x1, x2, x3, x4) sqrt(10)*(x1 - x4).^2};
df = {@(x1, x2, x3, x4) 1 @(x1, x2, x3, x4) 10 @(x1, x2, x3, x4) 0 @(x1, x2, x3, x4) 0; @(x1, x2, x3, x4) 0 @(x1, x2, x3, x4) 0 @(x1, x2, x3, x4) sqrt(5) @(x1, x2, x3, x4) -sqrt(5); @(x1, x2, x3, x4) 0 @(x1, x2, x3, x4) 2.*(x2 - x3) @(x1, x2, x3, x4) 2.*(x3 - x2) @(x1, x2, x3, x4) 0; @(x1, x2, x3, x4) 2*sqrt(10).*(x1 - x4) @(x1, x2, x3, x4) 0 @(x1, x2, x3, x4) 0 @(x1, x2, x3, x4) 2*sqrt(10).*(x4 - x1)};

[x_ans, n] = newtons_method(x0, f, df, 10^-6);
x1 = 1;
x2 = 2;
x3 = 1;
x4 = 1;
x0 = [x1 x2 x3 x4];
[x_fsolve, ~] = fsolve(@(x) partC(x1, x2, x3, x4), x0);
fprintf("Newton's Method:\tx1: %f  x2: %f  x3: %f  x4: %f  n: %d\nfsolve:\t\t\t\tx1: %f  x2: %f  x3: %f  x4: %f\n\n", x_ans(1), x_ans(2), x_ans(3), x_ans(4), n, x_fsolve(1, 1), x_fsolve(1, 2), x_fsolve(1, 3), x_fsolve(1, 4));

% d)
x0 = {1.8 0};
f = {@(x1, x2) x1; @(x1, x2) 10.*x1./(x1 + 0.1) + 2.*x2.^2};
df = {@(x1, x2) 1 @(x1, x2) 0; @(x1, x2) 100./(10.*x1 + 1).^2 @(x1, x2) 4.*x2};

[x_ans, n] = newtons_method(x0, f, df, 10^-6);
x1 = 1.8;
x2 = 0;
x0 = [x1 x2];
[x_fsolve, ~] = fsolve(@(x) partD(x1, x2), x0);
fprintf("Newton's Method:\tx1: %d  x2: %d   n: %d\nfsolve:\t\t\t\tx1: %d x2: %d\n\n", x_ans(1), x_ans(2), n, x_fsolve(1, 1), x_fsolve(1, 2));


fprintf('Done\n');

function F = partA(x1, x2)
    F(1) = x1 + x2*(x2*(5 - x2) - 2) - 13;
    F(2) = x1 + x2*(x2*(1 + x2) - 14) - 29;
end

function F = partB(x1, x2, x3)
    F(1) = x1.^2 + x2.^2 + x3.^2 - 5;
    F(2) = x1 + x2 - 1;
    F(3) = x1 + x3 - 3;
end

function F = partC(x1, x2, x3, x4)
    F(1) = x1 + 10*x2;
    F(2) = sqrt(5)*(x3 - x4);
    F(3) = (x2 - x3).^2;
    F(4) = sqrt(10)*(x1 - x4).^2;
end

function F = partD(x1, x2)
    F(1) = x1;
    F(2) = 10*x1/(x1 + 0.1) + 2*x2.^2;
end


