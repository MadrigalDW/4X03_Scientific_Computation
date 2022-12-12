function C = addR(A, B)
    [n, ~] = size(A);
    for i = 1:n
        C(i, 1:n) = A(i, 1:n) + B(i, 1:n);
    end
end