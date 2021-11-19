% Importing Data
t = ESSE4640Lab5XYZF2021;
t = table2array(t);

x = t(:, 2);
y = t(:, 3);
z = t(:, 4);

% Q111
dist = [];

%distance between all points, 20 points so there should be 190 unique pairs
for i=1:length(x)-1
    for j=2:length(x)-1
       dist(i,j) = distance(x(i),x(j),y(i),y(j),z(i),z(j)); 
    end
    j = j+1;
end

%reorganizing matrix so that we get 1 side of distance and replacing 0s
%with nan
dist = triu(dist,1);
dist(dist == 0) = NaN;

distmat = [];
zmat = [];
o = 1;
p = 2;
%FINDING Z ASSOCIATED TO DIST
for i=1:length(x)-1
    for j=2:length(x)-1
       if ~all(isnan(dist(i,j)))
           distmat(o) = dist(i,j);
           distmat(p) = dist(i,j);
           zmat(o) = z(i);
           zmat(p) = z(j);
           
           o = o+2;
           p = p+2;
       end
    end
    j = j+1;
end

% sorting from least to greatest dist while keeping same z elevation for
% distance computation, but distance is recorded twice
[distmat,idx]=sort(distmat);
zmat=zmat(idx);

%reordered so that now we have values from 1 to 380 (380/2 is 190)
distmat(2:2:end) = []; 

% HISTOGRAM
% histogram(distmat, 5)
% 5 bins: [0-5], [5-10], [10-15], [15-20], [20-25] 

bin1 = zmat(1:20); %10 values in this bin
bin2 = zmat(21:146); %63
bin3 = zmat(147:278); %66
bin4 = zmat(279:364); %43
bin5 = zmat(365:380); %8

semi1 = semi(bin1, 10);
semi2 = semi(bin2, 63);
semi3 = semi(bin3, 66);
semi4 = semi(bin4, 43);
semi5 = semi(bin5, 8);


col = [0, 5, 10, 15, 20];
semimat1 = [semi1;semi2;semi3;semi4;semi5];

% figure(1)
% plot(col, semimat1)
% title('1.1.1) Semi-Variogram')
% ylabel('Semi-Variance')
% xlabel('Distance')

% Q112
coefficients = polyfit(col, semimat1, 1);
slope = coefficients(1); 
nugget = 1.4555;
semi15 = slope.*[5 10 15]' + nugget; %no nugget

bin = zmat(279:380);

semi20 = semi(bin, 61);

col = [0; 5; 10; 15; 20];
semimat2 = [semi15; semi20; semi20];

% figure(2)
% plot(col, semimat2)
% title('1.1.2) Semi-Variogram')
% ylabel('Semi-Variance')
% xlabel('Distance')

resid = semimat1-semimat2;

% figure(3)
% plot(col, resid)
% title('1.1.2) Residuals')
% ylabel('Semi-Variance')
% xlabel('Distance')

% Q113
for i=1:length(x)-1
    for j=1:length(x)-1
       dist(i,j) = distance2(x(i),x(j),y(i),y(j)); 
       model(i,j) = semivariance2(dist(i,j),bin,61,nugget);
    end
end

for i=1:length(x)-1
    distp(i) = distance2(x(i),x(21),y(i),y(21));
    semip(i) = semivariance2(dist(i), bin, 61, nugget);
end
semip = semip';

weight = model^-1*semip;

% Q114
elevp = 0;
for i = 1:length(x)-1
    s = weight(i)*z(i);
    elevp = elevp + s; %ELEVATION IS 322.8
end

% Q115
std = 0;
for i = 1:length(x)-1
    s = weight(i)*distp(i);
    std = std + s;
end

var = sqrt(std);

function semivariance = semi(bin, numofp)
semivariance = 0;
    for i = 1:length(bin)/2
        counter = (1 / (2*numofp))*(bin(i*2-1) - bin(i*2))^2;
        semivariance = counter + semivariance;
    end
end

function semivariance = semivariance2(d,b,n,nugget)
semivariance = 0;
if d >= 0 && d < 15
    semivariance = 0.5589*d+nugget;
else
    for i = 1:length(b)/2
        counter = (1 / (2*n))*(b(i*2-1) - b(i*2))^2;
        semivariance = counter + semivariance;
    end
end
end

function distance = distance(x1,x2,y1,y2,z1,z2)
distance = sqrt((x2-x1)^2+(y2-y1)^2+(z2-z1)^2);
end

function distance2 = distance2(x1,x2,y1,y2)
distance2 = sqrt((x2-x1)^2+(y2-y1)^2);
end