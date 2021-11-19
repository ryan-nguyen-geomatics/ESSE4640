% Importing Data
t = DTMLab4XYZF2021;
t = table2array(t);

x = t(:, 1);
y = t(:, 2);
z = t(:, 3);

% Q1
gridx = 2000:100:7000;
gridy = 1000:100:4000;

grid = meshgrid(gridx, gridy);

% Q2i
sumf = [];
elevi = [];
w = 0;

A = [];
B = [];

for i = 1:length(gridx)
    for j = 1:length(gridy)
        for k = 1:length(x)
            refX = gridx(i);
            refY = gridy(j);
        
            dist = sqrt((refX-x(k))^2+(refY-y(k))^2);
             
            A(k) = dist;
            B(k) = z(k);
        end
        
        [A, idx] = sort(A); %least to greatest distance
        B = B(idx);  %matches the distance to associated z value
        
        newdist = A(1:15); 

        for c = 1:15
            w = 1 / newdist(c);
            sumf(c) = (w*B(c));
        end
        
        elevi(j,i) = sum(sumf) / (1/sum(newdist));
    end
end

% Q2ii
for i = 1:length(gridx)
    for j = 1:length(gridy)
        for k = 1:length(x)
            refX = gridx(i);
            refY = gridy(j);
        
            dist = sqrt((refX-x(k))^2+(refY-y(k))^2);
             
            A(k) = dist;
            B(k) = z(k);
        end
        
        [A, idx] = sort(A); %least to greatest distance
        B = B(idx);  %matches the distance to associated z value
        
        newdist = A(1:15); 

        for c = 1:15
            w = 1 / newdist(c)^2;
            sumf(c) = (w*B(c)); 
        end
        
        for c2 = 1:15
            sumdist(c2) = 1 / newdist(c2)^2; 
        end
        
        elevii(j,i) = sum(sumf) / (sum(sumdist));
    end
end

% Q2iii
for i = 1:length(gridx)
    for j = 1:length(gridy)
        for k = 1:length(x)
            refX = gridx(i);
            refY = gridy(j);
        
            dist = sqrt((refX-x(k))^2+(refY-y(k))^2);
             
            A(k) = dist;
            B(k) = z(k);
        end
        
        [A, idx] = sort(A); %least to greatest distance
        B = B(idx);  %matches the distance to associated z value
        
        newdist = A(1:15); 

        
        for c = 1:15
            w = 1 / newdist(c)^5;
            sumf(c) = (w*B(c));
        end
        
        for c2 = 1:15
            sumdist(c2) = 1 / newdist(c2)^5; 
        end
        
        eleviii(j,i) = sum(sumf) / (sum(sumdist));
    end
end

% Q3
for i = 1:length(gridx)
    for j = 1:length(gridy)
        for k = 1:length(x)
            refX = gridx(i);
            refY = gridy(j);
        
            dist = sqrt((refX-x(k))^2+(refY-y(k))^2);
             
            A(k) = dist;
            B(k) = z(k);
        end
        
        [A, idx] = sort(A); %least to greatest distance
        B = B(idx);  %matches the distance to associated z value

        elevNN(j,i) = B(1);
    end
end

% Q4
% NN and i
elevNNi_diff = elevNN - elevi;
[meanNNi, stdNNi, rmseNNi, miniNNi, maxiNNi, rangeNNi] = stats(elevNNi_diff);

% NN and ii
elevNNii_diff = elevNN - elevii;
[meanNNii, stdNNii, rmseNNii, miniNNii, maxiNNii, rangeNNii] = stats(elevNNii_diff);

%NN and iii
elevNNiii_diff = elevNN - eleviii;
[meanNNiii, stdNNiii, rmseNNiii, miniNNiii, maxiNNiii, rangeNNiii] = stats(elevNNiii_diff);

%i and ii
eleviXii_diff = elevi - elevii;
[meaniXii, stdiXii, rmseiXii, miniiXii, maxiiXii, rangeiXii] = stats(eleviXii_diff);

%i and iii
eleviXiii_diff = elevi - eleviii;
[meaniXiii, stdiXiii, rmseiXiii, miniiXiii, maxiiXiii, rangeiXiii] = stats(eleviXiii_diff);

%ii and iii
eleviiXiii_diff = elevii - eleviii;
[meaniiXiii, stdiiXiii, rmseiiXiii, miniiiXiii, maxiiiXiii, rangeiiXiii] = stats(eleviiXiii_diff);

% Q5
figure(1)
scatter(x,y)
grid on
xlim([2000 7000])
ylim([1000 4000])
xticks(2000:100:7000)
yticks(1000:100:4000)
title('Input Data vs. Grid Points')

figure(2)
heatmap(elevi)
colormap cool
title('Elevation Heatmap of IDW Method i)')

figure(3)
heatmap(elevii)
colormap cool
title('Elevation Heatmap of IDW Method ii)')

figure(4)
heatmap(eleviii)
colormap cool
title('Elevation Heatmap of IDW Method iii)')

figure(5)
heatmap(elevNN)
colormap cool
title('Elevation Heatmap of NN Method')

figure(6)
heatmap(elevNNi_diff)
colormap cool
title('Elevation Difference between NN and IDW Method i)')

figure(7)
heatmap(elevNNii_diff)
colormap cool
title('Elevation Difference between NN and IDW Method ii)')

figure(8)
heatmap(elevNNiii_diff)
colormap cool
title('Elevation Difference between NN and IDW Method iii)')

figure(9)
heatmap(eleviXii_diff)
colormap cool
title('Elevation Difference between IDW Method i) and IDW Method ii)')

figure(10)
heatmap(eleviXiii_diff)
colormap cool
title('Elevation Difference between IDW Method i) and IDW Method iii)')

figure(11)
heatmap(eleviiXiii_diff)
colormap cool
title('Elevation Difference between IDW Method ii) and IDW Method iii)')

function [mn, stand, rmse, mini, maxi, range] = stats(elevation_diff)
mn = mean(mean(elevation_diff));
stand = std(std(elevation_diff));
rmse = sqrt(mean(mean(elevation_diff.^2)));
mini = min(min(elevation_diff));
maxi = max(max(elevation_diff));
range = maxi - mini;
end