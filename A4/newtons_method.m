function [x1, n] = newtons_method(x0, f, df, tol)
    flag = 0;
    n = 1;
    while n < 10000
        y = zeros(1, length(f));
        dy = zeros(size(df, 1), size(df, 2));
        for i = 1:length(f)
            y(i) = f{i}(x0{:});
        end
        for i = 1:size(df, 1)
            for j = 1:size(df, 2)
                dy(i, j) = df{i, j}(x0{:});
            end
        end
        dx = dy\y';
        for i = 1:length(dx)
            j = dx(i);
            if isnan(j)
                fprintf('Warning: dx contains NaN elements. Program cannot continue.\n');
                x1 = Inf(1, length(x0));
                flag = 1;
                break
            end
        end
        if flag
            break
        end
        if max(abs(dx)) < tol
            x1 = cellfun(@minus, x0, num2cell(dx'), 'Un', 1);
            break
        else
            x0 = num2cell(cellfun(@minus, x0, num2cell(dx'), 'Un', 1));
        end
        n = n + 1;
    end
    if n == 10000
        disp(dx)
        fprintf("Reached max number of iterations. Current tolerance is %f, with x values of:", max(abs(dx)));
        x1 = x0;
        disp(x1)
    end
end