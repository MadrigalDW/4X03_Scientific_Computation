function B = inverse(A)
    [m,n] = size(A);
    [L, U, P] = lu(A);
    L_I = eye(n);
    U_I = eye(n);
    U_diag = true;
    L_diag = true;
    for i = 1:n
        U_I(n-i+1,:) = U_I(n-i+1,:)./U(n-i+1,n-i+1);
        U(n-i+1,:) = U(n-i+1,:)./U(n-i+1,n-i+1);
        if i < n
            for j = i+1:n
                U_I(n-j+1,:) = U_I(n-j+1,:) - U(n-j+1,n-i+1).*U_I(n-i+1,:);
                U(n-j+1,:) = U(n-j+1,:) - U(n-j+1,n-i+1).*U(n-i+1,:);
            end
        end
    end
    for i = 1:n
        L_I(i,:) = L_I(i,:)./L(i,i);
        L(i,:) = L(i,:)./L(i,i);
        %disp(L_I)
        if i < n
            for j = i+1:n
                L_I(j,:) = L_I(j,:) - L(j,i).*L_I(i,:);
                L(j,:) = L(j,:) - L(j,i).*L(i,:);
                %disp(L_I)
            end
        end
    end
    B = U_I*L_I*P;
end