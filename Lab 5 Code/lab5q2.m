% Importing Data
t = ESSE4640Lab5XYZF2021;
t = table2array(t);

x = t(:, 2);
y = t(:, 3);
z = t(:, 4);

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

nugget = 1.4555;
bin = zmat(279:380);

% Q121
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

row = ones(1, 20);
col = ones(20, 1);
col = [col; 0];

model = [model; row];
model = [model col];
semip = [semip; 1];

weight = model^-1*semip;

% Q122
elevp = 0;
for i = 1:length(x)-1
    s = weight(i)*z(i);
    elevp = elevp + s; %ELEVATION IS 322.8
end

% Q123
std = 0;
for i = 1:length(x)-1
    s = weight(i)*distp(i);
    std = std + s;
end

std = std + weight(21);
var = sqrt(std);

% Q124
sumweight = sum(weight);

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