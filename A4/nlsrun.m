function nlsrun
%NLSRUN
%
% Set up data for neural net test
% Call nonlinear least squares optimization code to minimze the error
% Visualize results
%
% C F Higham and D J Higham, August 2017
%
%%%%%%% DATA %%%%%%%%%%%
% coordinates and targets
% x1 = [0.1,0.3,0.1,0.6,0.4,0.6,0.5,0.9,0.4,0.7];
% x2 = [0.1,0.4,0.5,0.9,0.2,0.3,0.6,0.2,0.4,0.6];
% y = [ones(1,5) zeros(1,5); zeros(1,5) ones(1,5)];

dataset = load('dataset.mat');
x1 = dataset.X(:,1)';
x2 = dataset.X(:,2)';
y = dataset.Y';
xlen = length(x1);
halflen = fix(xlen/2);

figure(1)
clf
a1 = subplot(1,1,1);
plot(x1(1:halflen),x2(1:halflen),'ro','MarkerSize',12,'LineWidth',4)
hold on
plot(x1(halflen+1:xlen),x2(halflen+1:xlen),'bx','MarkerSize',12,'LineWidth',4)
a1.XTick = [0 1];
a1.YTick = [0 1];
a1.FontWeight = 'Bold';
a1.FontSize = 16;
xlim([0,1])
ylim([0,1])

print -dpng pic_xy.png

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize weights/biases and call optimizer
rng(5000);
Pzero = 0.5*randn(135,1);

global finalW2;
global finalW3;
global finalW4;
global finalb2;
global finalb3;
global finalb4;

options = optimoptions('lsqnonlin','MaxFunctionEvaluations', 1e6, 'MaxIterations', 1e4);
lb = -1.*Inf(size(Pzero));
ub = Inf(size(Pzero));
[finalP,finalerr] = lsqnonlin(@neterr,Pzero, lb, ub, options);

% grid plot
N = 500;
Dx = 1/N;
Dy = 1/N;
xvals = [0:Dx:1];
yvals = [0:Dy:1];
for k1 = 1:N+1
    xk = xvals(k1);
    for k2 = 1:N+1
        yk = yvals(k2);
        xy = [xk;yk];
        a2 = activate(xy,finalW2,finalb2);
        a3 = activate(a2,finalW3,finalb3);
        a4 = activate(a3,finalW4,finalb4);
        Aval(k2,k1) = a4(1);
        Bval(k2,k1) = a4(2);
     end
end
[X,Y] = meshgrid(xvals,yvals);


figure(2)
clf
a2 = subplot(1,1,1);
Mval = Aval>Bval;
contourf(X,Y,Mval,[0.5 0.5])
hold on
colormap([1 1 1; 0.8 0.8 0.8])
plot(x1(1:halflen),x2(1:halflen),'ro','MarkerSize',12,'LineWidth',4)
plot(x1(halflen+1:xlen),x2(halflen+1:xlen),'bx','MarkerSize',12,'LineWidth',4)
a2.XTick = [0 1];
a2.YTick = [0 1];
a2.FontWeight = 'Bold';
a2.FontSize = 16;
xlim([0,1])
ylim([0,1])

print -dpng pic_bdy.png

    function [costvec] = neterr(Pval)
    % return a vector whose two-norm squared is the cost function

     % changed values to match those in netbpfull
     W2 = zeros(10,2);
     W3 = zeros(8,10);
     W4 = zeros(2,8);
     W2(:) = Pval(1:20);
     W3(:) = Pval(21:100);
     W4(:) = Pval(101:116);
     b2 = Pval(117:126);
     b3 = Pval(127:134);
     b4 = Pval(134:135);

     costvec = zeros(xlen,1); 
     for i = 1:xlen
         x = [x1(i);x2(i)];
         a2 = activate(x,W2,b2);
         a3 = activate(a2,W3,b3);
         a4 = activate(a3,W4,b4);
         costvec(i) = norm(y(:,i) - a4,2);
     end
     finalW2 = W2;
     finalW3 = W3;
     finalW4 = W4;
     finalb2 = b2;
     finalb3 = b3;
     finalb4 = b4;
     end % of nested function
end

