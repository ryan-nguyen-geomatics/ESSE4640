% Importing Data
t = ESSE4640Lab5XYZF2021;
t = table2array(t);

x = t(:, 2);
y = t(:, 3);
z = t(:, 4);

for i=1:length(x)-1
    distp(i) = distance(x(i),x(21),y(i),y(21));
end

for i=1:length(x)-1
    weight(i) = 1 / distp(i)^2;
end
weight = weight';

for i=1:length(x)-1
    matrix(i) = weight(i)*z(i);
end

elevation = sum(matrix) / sum(weight); %322.2055

% TASK C
ybar = [z; 322.8; 322.8; 313.8668; 322.2055];

% bar(ybar)
% title('Bar Graph of Elevations')
% ylabel('Elevation')
% xlabel('Points')

compz = [322.8; 322.8; 313.8668; 322.2055];

for i=1:4
    for j = 1:4
        resid(i,j) = compz(i)-compz(j);
    end
end

names = {'Simple Kriging', 'Ordinary Kriging', 'Universal Kriging', 'IDW Method'};

% SIMPLE KRIGING
% bar(resid(1, :))
% set(gca,'xticklabel',names)
% title('Residuals between Simple Kriging')
% ylabel('Elevation Residual')
% xlabel('Method')

% ORDINARY KRIGING
% bar(resid(2, :))
% set(gca,'xticklabel',names)
% title('Residuals between Ordinary Kriging')
% ylabel('Elevation Residual')
% xlabel('Method')

% UNIVERSAL KRIGING
% bar(resid(3, :))
% set(gca,'xticklabel',names)
% title('Residuals between Universal Kriging')
% ylabel('Elevation Residual')
% xlabel('Method')

% IDW METHOD
bar(resid(4, :))
set(gca,'xticklabel',names)
title('Residuals between IDW Method')
ylabel('Elevation Residual')
xlabel('Method')


function distance = distance(x1,x2,y1,y2)
distance = sqrt((x2-x1)^2+(y2-y1)^2);
end