% Q1
t = Lab3XYZF2021;
x = t(:, 1);
x = table2array(x);
y = t(:, 2);
y = table2array(y);
z = t(:, 3);
z = table2array(z);

% Q2 and part of Q4
% GIVEN COORDINATES
% second order
one = ones(92, 1);
A_2 = [one x y x.^2 x.*y y.^2];

xhat_2 = (A_2.'*A_2)^-1*A_2.'*z;
l_2 = A_2*xhat_2; %estimated elevation
lhat_2 = l_2 - z; %residual

Z_2 = 0;
for i=1:6
    adder = xhat_2(i)*A_2(i);
    Z_2 = Z_2 + adder;
end

Z_2 = Z_2 + lhat_2;

% third order
A_3 = [one x y x.^2 x.*y y.^2 x.^3 x.^2.*y x.*y.^2 y.^3];

xhat_3 = (A_3.'*A_3)^-1*A_3.'*z;
l_3 = A_3*xhat_3; %estimated elevation
lhat_3 = l_3 - z; %residual

Z_3 = 0;
for i=1:10
    adder = xhat_3(i)*A_3(i);
    Z_3 = Z_3 + adder;
end

Z_3 = Z_3 + lhat_3;

% NORMALIZED COORDINATES
xn = (x - min(x)) / (max(x)-min(x));
x_n = xn*(max(x)-min(x)) + min(x);
yn = (y - min(y)) / (max(y)-min(y));
y_n = yn*(max(y)-min(y)) + min(y);
zn = (z - min(z)) / (max(z)-min(z));
z_n = zn*(max(z)-min(z)) + min(z);
% coordinates have very minor differences, z coord no differences at all

% second order
An_2 = [one x_n y_n x_n.^2 x_n.*y_n y_n.^2];

xhatn_2 = (An_2.'*An_2)^-1*An_2.'*z_n;
ln_2 = An_2*xhatn_2; %estimated elevation
lhatn_2 = ln_2 - z_n; %residual

Zn_2 = 0;
for i=1:6
    adder = xhatn_2(i)*An_2(i);
    Zn_2 = Zn_2 + adder;
end

Zn_2 = Zn_2 + lhatn_2;

% third order
An_3 = [one x_n y_n x_n.^2 x_n.*y_n y_n.^2 x_n.^3 x_n.^2.*y_n x_n.*y_n.^2 y_n.^3];

xhatn_3 = (An_3.'*An_3)^-1*An_3.'*z_n;
ln_3 = An_3*xhatn_3; %estimated elevation
lhatn_3 = ln_3 - z_n; %residual

Zn_3 = 0;
for i=1:10
    adder = xhatn_3(i)*An_3(i);
    Zn_3 = Zn_3 + adder;
end

Zn_3 = Zn_3 + lhatn_3;

% CENTROID COORDINATES
xc = sum(x) / length(x);
x_c = x - xc;
yc = sum(y) / length(y);
y_c = y - yc;
zc = sum(z) / length(z);
z_c = z - zc;
% coordinates are different here

% second order
Ac_2 = [one x_c y_c x_c.^2 x_c.*y_c y_c.^2];

xhatc_2 = (Ac_2.'*Ac_2)^-1*Ac_2.'*z_c;
lc_2 = Ac_2*xhatc_2; %estimated elevation
lhatc_2 = lc_2 - z_c; %residual

Zc_2 = 0;
for i=1:6
    adder = xhatc_2(i)*Ac_2(i);
    Zc_2 = Zc_2 + adder;
end

Zc_2 = Zc_2 + lhatc_2;

% third order
Ac_3 = [one x_c y_c x_c.^2 x_c.*y_c y_c.^2 x_c.^3 x_c.^2.*y_c x_c.*y_c.^2 y_c.^3];

xhatc_3 = (Ac_3.'*Ac_3)^-1*Ac_3.'*z_c;
lc_3 = Ac_3*xhatc_3; %estimated elevation
lhatc_3 = lc_3 - z_c; %residual

Zc_3 = 0;
for i=1:10
    adder = xhatc_3(i)*Ac_3(i);
    Zc_3 = Zc_3 + adder;
end

Zc_3 = Zc_3 + lhatc_3;

% Q3
score_2 = cdf('Normal', xhat_2, mean(xhat_2), std(xhat_2));
score_3 = cdf('Normal', xhat_3, mean(xhat_3), std(xhat_3));

scoren_2 = cdf('Normal', xhatn_2, mean(xhatn_2), std(xhatn_2));
scoren_3 = cdf('Normal', xhatn_3, mean(xhatn_3), std(xhatn_3));

scorec_2 = cdf('Normal', xhatc_2, mean(xhatc_2), std(xhatc_2));
scorec_3 = cdf('Normal', xhatc_3, mean(xhatc_3), std(xhatc_3));


% Q4
% GIVEN COORDINATES
% second order
l_2mean = mean(l_2);
l_2std = std(l_2);
l_2min = min(l_2);
l_2max = max(l_2);
l_2rmse = 0;

for i=1:length(l_2)
    adder = (Z_2(i)-l_2(i))^2/ length(l_2);
    l_2rmse = l_2rmse + adder;
end

l_2rmse = sqrt(l_2rmse);

% third order
l_3mean = mean(l_3);
l_3std = std(l_3);
l_3min = min(l_3);
l_3max = max(l_3);
l_3rmse = 0;

for i=1:length(l_3)
    adder = (l_3(i)-Z_3(i))^2/ length(l_3);
    l_3rmse = l_3rmse + adder;
end

l_3rmse = sqrt(l_3rmse);

% NORMALIZED COORDINATES
% second order
ln_2mean = mean(ln_2);
ln_2std = std(ln_2);
ln_2min = min(ln_2);
ln_2max = max(ln_2);
ln_2rmse = 0;

for i=1:length(ln_2)
    adder = (ln_2(i)-Zn_2(i))^2/ length(ln_2);
    ln_2rmse = ln_2rmse + adder;
end

ln_2rmse = sqrt(ln_2rmse);

% third order
ln_3mean = mean(ln_3);
ln_3std = std(ln_3);
ln_3min = min(ln_3);
ln_3max = max(ln_3);
ln_3rmse = 0;

for i=1:length(ln_3)
    adder = (ln_3(i)-Zn_3(i))^2/ length(ln_3);
    ln_3rmse = ln_3rmse + adder;
end

ln_3rmse = sqrt(ln_3rmse);

% CENTROID COORDINATES
% second order
lc_2mean = mean(lc_2);
lc_2std = std(lc_2);
lc_2min = min(lc_2);
lc_2max = max(lc_2);
lc_2rmse = 0;

for i=1:length(lc_2)
    adder = (lc_2(i)-Zc_2(i))^2/ length(lc_2);
    lc_2rmse = lc_2rmse + adder;
end

lc_2rmse = sqrt(lc_2rmse);

% third order
lc_3mean = mean(lc_3);
lc_3std = std(lc_3);
lc_3min = min(lc_3);
lc_3max = max(lc_3);
lc_3rmse = 0;

for i=1:length(lc_3)
    adder = (lc_3(i)-Zc_3(i))^2/ length(lc_3);
    lc_3rmse = lc_3rmse + adder;
end

lc_3rmse = sqrt(lc_3rmse);

% Q5
% GIVEN COORDINATES
% second order
Z_2std = std(Z_2);
chi_2 = (l_2std^2 / Z_2std^2)*(length(Z_2)-1);
f_2 = (l_2std^2/length(l_2)) / (Z_2std^2/length(Z_2));

% third order
Z_3std = std(Z_3);
chi_3 = (l_3std^2 / Z_3std^2)*(length(Z_3)-1);
f_3 = (l_3std^2/length(l_3)) / (Z_3std^2/length(Z_3));

% NORMALIZED COORDINATES
% second order
Zn_2std = std(Zn_2);
chin_2 = (ln_2std^2 / Zn_2std^2)*(length(Zn_2)-1);
fn_2 = (ln_2std^2/length(ln_2)) / (Zn_2std^2/length(Zn_2));

% third order
Zn_3std = std(Zn_3);
chin_3 = (ln_3std^2 / Zn_3std^2)*(length(Zn_3)-1);
fn_3 = (ln_3std^2/length(ln_3)) / (Zn_3std^2/length(Zn_3));

% CENTROID COORDINATES
% second order
Zc_2std = std(Zc_2);
chic_2 = (lc_2std^2 / Zc_2std^2)*(length(Zc_2)-1);
fc_2 = (lc_2std^2/length(lc_2)) / (Zc_2std^2/length(Zc_2));

% third order
Zc_3std = std(Zc_3);
chic_3 = (lc_3std^2 / Zc_3std^2)*(length(Zc_3)-1);
fc_3 = (lc_3std^2/length(lc_3)) / (Zc_3std^2/length(Zc_3));

% Q8
figure(1)
scatter3(x,y,z)
title('Planimetric Distribution of the Given Elevation Points')
xlabel('X Axis')
ylabel('Y Axis')
zlabel('Elevation')

figure(2)
scatter3(x_n,y_n,z_n)
title('Planimetric Distribution of the Normalized Elevation Points')
xlabel('X Axis')
ylabel('Y Axis')
zlabel('Elevation')

figure(3)
scatter3(x_c,y_c,z_c)
title('Planimetric Distribution of the Centroid Elevation Points')
xlabel('X Axis')
ylabel('Y Axis')
zlabel('Elevation')

figure(4)
errorbar(z, lhatn_2)
title('2nd Order Elevation Residuals of the Given Elevation Points')
xlabel('Number of Elevations')
ylabel('Elevation and its Residuals')

figure(5)
errorbar(z, lhat_3)
title('3rd Order Elevation Residuals of the Given Elevation Points')
xlabel('Number of Elevations')
ylabel('Elevation and its Residuals')

figure(6)
errorbar(z_n, lhatn_2)
title('2nd Order Elevation Residuals of the Normalized Elevation Points')
xlabel('Number of Elevations')
ylabel('Elevation and its Residuals')

figure(7)
errorbar(z_n, lhatn_3)
title('3rd Order Elevation Residuals of the Normalized Elevation Points')
xlabel('Number of Elevations')
ylabel('Elevation and its Residuals')

figure(8)
errorbar(z_c, lhatc_2)
title('2nd Order Elevation Residuals of the Centroid Elevation Points')
xlabel('Number of Elevations')
ylabel('Elevation and its Residuals')

figure(9)
errorbar(z_c, lhatc_3)
title('3rd Order Elevation Residuals of the Centroid Elevation Points')
xlabel('Number of Elevations')
ylabel('Elevation and its Residuals')
