function errors(tol)
    f2 = @(x) exp(2*x).*(3*sin(x)+4*cos(x));
    f4 = @(x) exp(2*x).*(-7*sin(x)+24*cos(x));
    f2_max = max(f2(0:pi/2));
    f4_max = max(f4(0:pi/2));
    
    n_trap = 1;
    n_simp = 1;
    n_mid = 1;

    err_trap = inf;
    err_simp = inf;
    err_mid = inf;

    while (err_trap > tol)
        err_trap = abs(f2_max*pi^3/(96*n_trap^2));
        n_trap = n_trap + 1;
    end

    while (err_simp > tol)
        err_simp = abs(f4_max*pi^5/(5760*n_simp^4));
        n_simp = n_simp + 1;
    end

    while (err_mid > tol)
        err_mid = abs(f2_max*pi^3/(192*n_mid^2));
        n_mid = n_mid + 1;
    end

    fprintf("tol = %e\ntrapezoid\tn = %8.f,\terror = %e\nmidpoint\tn = %8.f,\terror = %e\nSimpson\t\tn = %8.f,\terror = %e\n\n", tol, n_trap, err_trap, n_mid, err_mid, n_simp, err_simp);
end
