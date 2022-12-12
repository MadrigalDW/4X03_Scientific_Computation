function [answer, E] = adaptive_simpson(f, a, b, tol)
    global xpoints
    h = b - a;
    c = (a + b)/2;
    d = (a + c)/2;
    e = (c + b)/2;
     
    xpoints = unique([xpoints, a, b, c, d, e]);
    S1 = (h/6)*(f(a) + 4*f(c) + f(b));
    S2 = (h/12)*(f(a) + 4*f(d) + 2*f(c) + 4*f(e) + f(b));
    E = (S2 - S1)/15;
    if abs(E) <= tol
        answer = S2 + E;
    else 
       [Q1, E1] = adaptive_simpson(f, a, c, tol/2);
       [Q2, E2] = adaptive_simpson(f, c, b, tol/2);
       answer = Q1 + Q2;
       E = E1 + E2;
    end
end