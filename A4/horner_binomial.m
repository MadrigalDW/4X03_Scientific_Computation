function ans = horner_binomial(y, n, m)
    syms x
    if m < n
        ans = (factorial(n)/(factorial(m)*factorial(n-m))).*(y^(n-m)) + x.*horner_binomial(y, n, m+1);
    else
        ans = (factorial(n)/(factorial(m)*factorial(n-m)))*(y^(n-m));
    end
end