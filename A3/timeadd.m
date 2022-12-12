function timeadd()
    N = [1000:500:5000];
    [~, i] = size(N);

    time_R = zeros([1, i]);
    time_C = zeros([1, i]);

    A_mat = zeros([i, 2]);
    R_arr = zeros([i, 1]);
    C_arr = zeros([i, 1]);
    
    for j = 1:i
        n = N(j);
        disp(n)
        A = randn(n);
        B = randn(n);

        t_r = timef(@addR, A, B);
        t_c = timef(@addC, A, B);
        time_R(1, j) = t_r;
        time_C(1, j) = t_c;

        A_mat(j, 1) = 1;
        A_mat(j, 2) = log(n);
        R_arr(j, 1) = log(t_r);
        C_arr(j, 1) = log(t_c);
    end
    
    loglog(N, time_R);
    hold on
    loglog(N, time_C);
    legend("addR", "addC")
    hold off

    y_R = A_mat\R_arr;
    y_C = A_mat\C_arr;
    disp(y_R)
    disp(y_C)
    
    c_row = exp(y_R(1));
    k_row = y_R(2);
    c_col = exp(y_C(1));
    k_col = y_C(2);

    fprintf("c_row = %d\tk_row = %d\nc_col = %d\tk_col = %d\n", c_row, k_row, c_col, k_col);
end