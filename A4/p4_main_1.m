mu = 0.012277471;
mu_hat = 0.987722529;
%fprintf('%.12f\n', mu_hat);

% a = u1, b = u2
fa1 = @(a1, a2, b1, b2) a2;
fa2 = @(a1, a2, b1, b2) a1 + 2*b2 - mu_hat*(a1 + mu)/(((a1 + mu)^2 + b1^2)^(3/2)) - mu*(a1 - mu_hat)/(((a1 - mu_hat)^2 + b1^2)^(3/2));

fb1 = @(a1, a2, b1, b2) b2;
fb2 = @(a1, a2, b1, b2) b1 - 2*a2 - mu_hat*b1/(((a1 + mu)^2 + b1^2)^(3/2)) - mu*b1/(((a1 - mu_hat)^2 + b1^2)^(3/2));

steps_vec = [100 1000 10000 20000];
for i = 1:length(steps_vec)
    steps = steps_vec(i);
    h = 17.1/steps;
    t = 0:h:17.1;
    
    a1 = zeros(1,length(t));
    a2 = zeros(1,length(t));
    b1 = zeros(1,length(t));
    b2 = zeros(1,length(t));
    a1(1) = 0.994;
    a2(1) = 0;
    b1(1) = 0;
    b2(1) = -2.0015851063790825224205378622;
    
    for j = 1:(length(t) - 1)
        k1_a1 = fa1(a1(j), a2(j), b1(j), b2(j));
        k1_a2 = fa2(a1(j), a2(j), b1(j), b2(j));
        k1_b1 = fb1(a1(j), a2(j), b1(j), b2(j));
        k1_b2 = fb2(a1(j), a2(j), b1(j), b2(j));

        k2_a1 = fa1(a1(j) + h/2*k1_a1, a2(j) + h/2*k1_a2, b1(j) + h/2*k1_b1, b2(j) + h/2*k1_b2);
        k2_a2 = fa2(a1(j) + h/2*k1_a1, a2(j) + h/2*k1_a2, b1(j) + h/2*k1_b1, b2(j) + h/2*k1_b2);
        k2_b1 = fb1(a1(j) + h/2*k1_a1, a2(j) + h/2*k1_a2, b1(j) + h/2*k1_b1, b2(j) + h/2*k1_b2);
        k2_b2 = fb2(a1(j) + h/2*k1_a1, a2(j) + h/2*k1_a2, b1(j) + h/2*k1_b1, b2(j) + h/2*k1_b2);

        k3_a1 = fa1(a1(j) + h/2*k2_a1, a2(j) + h/2*k2_a2, b1(j) + h/2*k2_b1, b2(j) + h/2*k2_b2);
        k3_a2 = fa2(a1(j) + h/2*k2_a1, a2(j) + h/2*k2_a2, b1(j) + h/2*k2_b1, b2(j) + h/2*k2_b2);
        k3_b1 = fb1(a1(j) + h/2*k2_a1, a2(j) + h/2*k2_a2, b1(j) + h/2*k2_b1, b2(j) + h/2*k2_b2);
        k3_b2 = fb2(a1(j) + h/2*k2_a1, a2(j) + h/2*k2_a2, b1(j) + h/2*k2_b1, b2(j) + h/2*k2_b2);

        k4_a1 = fa1(a1(j) + h*k3_a1, a2(j) + h*k3_a2, b1(j) + h*k3_b1, b2(j) + h*k3_b2);
        k4_a2 = fa2(a1(j) + h*k3_a1, a2(j) + h*k3_a2, b1(j) + h*k3_b1, b2(j) + h*k3_b2);
        k4_b1 = fb1(a1(j) + h*k3_a1, a2(j) + h*k3_a2, b1(j) + h*k3_b1, b2(j) + h*k3_b2);
        k4_b2 = fb2(a1(j) + h*k3_a1, a2(j) + h*k3_a2, b1(j) + h*k3_b1, b2(j) + h*k3_b2);

        a1(j+1) = a1(j) + h/6*(k1_a1 + 2*k2_a1 + 2*k3_a1 + k4_a1);
        a2(j+1) = a2(j) + h/6*(k1_a2 + 2*k2_a2 + 2*k3_a2 + k4_a2);
        b1(j+1) = b1(j) + h/6*(k1_b1 + 2*k2_b1 + 2*k3_b1 + k4_b1);
        b2(j+1) = b2(j) + h/6*(k1_b2 + 2*k2_b2 + 2*k3_b2 + k4_b2);
    end

    figure
    plot(a1, b1, 'LineWidth', 2, 'Color', [0.5 0 0.75])
    plot_title = sprintf('4^t^h order Runge-Kutta method with %d steps', steps);
    title(plot_title)
end




