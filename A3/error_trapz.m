function [c, k] = error_trapz(f, a, b)
    n1 = 2^10; 
    n2 = 2^20; % use 2 n values for comparison
    h1 = (b-a)/n1; 
    h2 = (b-a)/n2; % calculating h for each n

    x1 = a:h1:b; % creating the x1 vector of n1 evenly spaced points from a to b
    x2 = a:h2:b; % creating the x2 vector of n2 evenly spaced points from a to b
    
    q = integral(f, a, b); % using integral function to obtain actual value of q
    Q1 = trapz(x1, f(x1));
    Q2 = trapz(x2, f(x2));  % calculating trapz value for each n
    err1 = abs(Q1 - q);
    err2 = abs(Q2 - q); % calculating error for each n

    k = log(err2/err1)/log(h2/h1); % calculate k by finding the slope when plotted logarithmically
    c = err1/h1^k; % calculate c by substituting in k
end