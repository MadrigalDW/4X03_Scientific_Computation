function C = addC(A, B)
    [n, ~] = size(A);
    for j = 1:n
        C(1:n, j) = A(1:n, j) + B(1:n, j);
    end
end
