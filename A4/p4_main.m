% A4 Q4

mu = 0.012277471;
mu_hat = 1 - mu;

fy_1 = @(t, u1, u2, y1, y2, z1, z2) z1; 
fz_1 = @(t, u1, u2, y1, y2, z1, z2) u1 + 2*y2 - mu_hat*(u1 + mu)/(((u1 + mu)^2 + u2^2)^(3/2)) - mu*(u1 - mu_hat)/(((u1 - mu_hat)^2 + u2^2)^(3/2));
fy_2 = @(t, u1, u2, y1, y2, z1, z2) z2;
fz_2 = @(t, u1, u2, y1, y2, z1, z2) u2 - 2*y1 - mu_hat*u2/(((u1 + mu)^2 + u2^2)^(3/2)) - mu*u2/(((u1 - mu_hat)^2 + u2^2)^(3/2));

steps_vec = [100 1000 10000 20000];
for i = 1:length(steps_vec)
    steps = steps_vec(i);
    h = 17.1/steps;
    t = 0:h:17.1;
    
    u1 = zeros(1,length(t));
    u2 = zeros(1,length(t));
    y1 = zeros(1,length(t));
    y2 = zeros(1,length(t));
    z1 = zeros(1,length(t));
    z2 = zeros(1,length(t));
    u1(1) = 0.994;
    u2(1) = 0;
    y1(1) = 0;
    y2(1) = -2.0015851063790825224205378622;
    
    for j = 1:(length(t)-1)
        k1_y1 = fy_1(t(j), u1(j), u2(j), y1(j), y2(j), z1(j), z2(j));
        k1_z1 = fz_1(t(j), u1(j), u2(j), y1(j), y2(j), z1(j), z2(j));
        k1_y2 = fy_2(t(j), u1(j), u2(j), y1(j), y2(j), z1(j), z2(j));
        k1_z2 = fz_2(t(j), u1(j), u2(j), y1(j), y2(j), z1(j), z2(j));

        k2_y1 = fy_1(t(j) + h/2, y1(j) + h/2*k1_y1, z1(j) + h/2*k1_z1);
        k2_z1 = fz_1(t(j) + h/2, y1(j) + h/2*k1_y1, z1(j) + h/2*k1_z1);
        k2_y2 = fy_2(t(j) + h/2, y1(j) + h/2*k1_y1, z1(j) + h/2*k1_z1);
        k2_z2 = fz_2(t(j) + h/2, y1(j) + h/2*k1_y1, z1(j) + h/2*k1_z1);


        k3_y = fy_1(t(j) + h/2, y1(j) + h/2*k2_y1, z1(j) + h/2*k2_z1);
        k3_z = fz_1(t(j) + h/2, y1(j) + h/2*k2_y1, z1(j) + h/2*k2_z1);
        k4_y = fy_1(t(j) + h, y1(j) + h*k3_y, z1(j) + h*k3_z);
        k4_z = fz_1(t(j) + h, y1(j) + h*k3_y, z1(j) + h*k3_z);
        y1(j + 1) = y1(j) + h/6*(k1_y1 + 2*k2_y1 + 2*k3_y + k4_y);
        z1(j + 1) = z1(j) + h/6*(k1_z1 + 2*k2_z1 + 2*k3_z + k4_z);
    end
end

%fy_2=@(x,y,z) z;
fz=@(x,y,z) 0.1*(1-x^2)*z-x;
t(1)=0;
z1(1)=1;
y1(1)=t;
h=0.1;
xfinal=10;
N=ceil((xfinal-t(1))/h);
for j=1:N
    k1_y1 = fy_1(t(j), y1(j), z1(j));
    k1_z1 = fz_1(t(j), y1(j), z1(j));
    k2_y1 = fy_1(t(j) + h/2, y1(j) + h/2*k1_y1, z1(j) + h/2*k1_z1);
    k2_z1 = fz_1(t(j) + h/2, y1(j) + h/2*k1_y1, z1(j) + h/2*k1_z1);
    k3_y = fy_1(t(j) + h/2, y1(j) + h/2*k2_y1, z1(j) + h/2*k2_z1);
    k3_z = fz_1(t(j) + h/2, y1(j) + h/2*k2_y1, z1(j) + h/2*k2_z1);
    k4_y = fy_1(t(j) + h, y1(j) + h*k3_y, z1(j) + h*k3_z);
    k4_z = fz_1(t(j) + h, y1(j) + h*k3_y, z1(j) + h*k3_z);
    y1(j + 1) = y1(j) + h/6*(k1_y1 + 2*k2_y1 + 2*k3_y + k4_y);
    z1(j + 1) = z1(j) + h/6*(k1_z1 + 2*k2_z1 + 2*k3_z + k4_z);
end
