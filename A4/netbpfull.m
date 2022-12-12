function netbpfull
%NETBP_FULL
%   Extended version of netbp, with more graphics
%
%   Set up data for neural net test
%   Use backpropagation to train 
%   Visualize results
%
% C F Higham and D J Higham, Aug 2017
%
%%%%%%% DATA %%%%%%%%%%%
% xcoords, ycoords, targets
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

%print -dpng pic_xy.png

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize weights and biases 
rng(5000);
W2 = 0.5*randn(10,2);
W3 = 0.5*randn(8,10);
W4 = 0.5*randn(2,8);
b2 = 0.5*randn(10,1);
b3 = 0.5*randn(8,1);
b4 = 0.5*randn(2,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Forward and Back propagate 
% Pick a training point at random
eta = 0.25;
Niter = 1e6;
savecost = zeros(Niter,1);
saveaccuracy = zeros(Niter, 1);
for counter = 1:Niter
    k = randi(xlen);
    l = randi(xlen);
    m = randi(xlen);
    n = randi(xlen);
    x = [x1(k) x1(l) x1(m) x1(n); x2(k) x2(l) x2(m) x2(n)]; % increase batch size to 4
    % Forward pass
    a2 = activate(x,W2,b2);
    a3 = activate(a2,W3,b3);
    a4 = activate(a3,W4,b4);
    % Backward pass
    delta4 = a4.*(1-a4).*(a4-y(:,k));
    delta3 = a3.*(1-a3).*(W4'*delta4);
    delta2 = a2.*(1-a2).*(W3'*delta3);
    % Gradient step
    W2 = W2 - eta*delta2*x';
    W3 = W3 - eta*delta3*a2';
    W4 = W4 - eta*delta4*a3';
    b2 = b2 - eta*delta2;
    b3 = b3 - eta*delta3;
    b4 = b4 - eta*delta4;
    % Monitor progress
    [newcost, accuracy] = cost(W2,W3,W4,b2,b3,b4);   % display cost to screen
    savecost(counter) = newcost;
    saveaccuracy(counter) = accuracy;   % adds each accuracy to vector for plotting
    if accuracy == 1    % if all points are 97% accurate, exit loop to stop training
        fprintf('number of iterations: %d\n', Niter);
        break
    end
end
fprintf('Final accuracy: %f\n', accuracy);

figure(2)
clf
semilogy([1:1e4:Niter],savecost(1:1e4:Niter),'b-','LineWidth',2)
xlabel('Iteration Number')
ylabel('Value of cost function')
set(gca,'FontWeight','Bold','FontSize',18)
print -dpng pic_cost.png

%%%%%%%%%%% Display shaded and unshaded regions 
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
        a2 = activate(xy,W2,b2);
        a3 = activate(a2,W3,b3);
        a4 = activate(a3,W4,b4);
        Aval(k2,k1) = a4(1);
        Bval(k2,k1) = a4(2);
     end
end
[X,Y] = meshgrid(xvals,yvals);

figure(3)
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

print -dpng pic_bdy_bp.png

% adding in accuracy plot. follows same specs as other figures, especially
% fig 2 (since both have iteration number on the x axis)
figure(4)
clf
plot([1:1e4:Niter], saveaccuracy(1:1e4:Niter),'b-','LineWidth',2)
xlabel('Iteration Number')
ylabel('Accuracy')
set(gca,'FontWeight','Bold','FontSize',18)
ylim([0,1])


  function [costval, accuracy] = cost(W2,W3,W4,b2,b3,b4)
     accuracy = 0;
     costvec = zeros(xlen,1); 
     for i = 1:xlen
         x =[x1(i);x2(i)];
         a2 = activate(x,W2,b2);
         a3 = activate(a2,W3,b3);
         a4 = activate(a3,W4,b4);
         costvec(i) = norm(y(:,i) - a4,2);

         for j = 1:length(y(:,i))
            if y(j,i) == 1
                if a4(j) >= 0.97 % checks if each point is 97% accurate; if it is, it counts as accurate 
                    accuracy = accuracy + 1; % accuracy equals the number of 97% accurate points at the end of the outer loop
                end
            end
         end
     end
     costval = norm(costvec,2)^2;
     accuracy = accuracy/xlen; % divides accuracy by total number of points to get percentage of accurate points
   end % of nested function
end