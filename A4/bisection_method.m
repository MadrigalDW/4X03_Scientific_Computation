function root = bisection_method(f, a, b, tol)
    while(1)
        c = (a + b)/2;                      % start with c as the average of a and b
        if double(f(c)) == 0 || (b - a)/2 < tol     % loop will run until we find c such that f(c) is zero or (b - a)/2 is less than tol
            disp(f(c))
            root = c;                       % when we find such c, it is the root
            break
        end
        if sign(f(a)) == sign(f(c))         % if we haven't found our root, we update a or b, moving closer to the desired value
            a = c;
        else
            b = c;
        end
    end
end