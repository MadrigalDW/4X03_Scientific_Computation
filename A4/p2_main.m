% A4 Q2
% a)
syms x
x1 = linspace(1.94, 2.07, 100);

f = @(x) (x-2).^9;
direct_y = f(x1);
h_f = horner_binomial(-2, 9, 0);
horner_f = matlabFunction(h_f);
horner_y = horner_f(x1);

% figure
% plot(x1, direct_y, 'Color', [0.5 0 0.75], 'LineWidth', 1.5);
% title("Direct Method");
% figure
% plot(x1, horner_y, 'Color', [0.5 0 0.75], 'LineWidth', 1.5);
% title("Horner's Method");

% b)

root = bisection_method(horner_f, 1.94, 2.07, 10^-6);
disp(root)