%A3
clear all;
%Q1
%errors(1e-4);
%errors(1e-12);

%Q2
a = 10;
b = 5;
n = 2^10;
h = (b-a)/n; % set up values
f = @(x) 10./(-x.*sqrt(x)); % set up function

i1 = 1:n/2;
i2 = 1:n/2 - 1;
t_2i = a + (2.*i2).*h;
t_2i_1 = a +(2.*i1 -1).*h;

Q = (h/3)*(f(a) + 2*sum(f(t_2i)) + 4*sum(f(t_2i_1)) + f(b)); % Simpson's approximation
q = integral(f, 10, 5); % actual value
fprintf("approximation:\t%1.10f\texact:\t%1.10f\nabsolute error:\t%e\trelative error:\t%e\n", Q, q, abs(Q-q), abs(Q-q)/q);


%Q6
% A = [8.3 1; 11.3 1; 14.4 1; 15.9 1];
% B = A'*A;
% f = [3; 5; 8; 10];
% g = A'*f;
% disp(B)
% disp(g)
% disp(B\g)
% 
% A = [288.65 28.7; 28.7 3];
% f = [125.4; 12];
% disp(inv(A))
% disp(inv(A)*f)
% disp(A\f);

% A = [656.75 49.9; 49.9 4];
% f = [355.6; 26];
% disp(inv(A))
% disp(inv(A)*f)
% disp(A\f);
% 
% f_a = @(x) 0.7525*x - 3.1988;
% f_b = @(x) 0.9125*x - 4.8831;
% x = [7 9.4 12.3 8.3 11.3 14.4 15.9];
% y = [2 4 6 2 5 8 10];

% fprintf("values:\n")
% disp(f_a(x))
% disp(f_b(x))
% fprintf("diff:\n")
% disp(abs(y-f_a(x)))
% disp(abs(y-f_b(x)))
% 
% a_avg = mean(abs(y-f_a(x)));
% b_avg = mean(abs(y-f_b(x)));
% a_max = max(abs(y-f_a(x)));
% b_max = max(abs(y-f_b(x)));
% fprintf("a: avg = %f\tmax = %f\n", a_avg, a_max);
% fprintf("b: avg = %f\tmax = %f\n", b_avg, b_max);