% a = [1 2 3]
% b = a*a.'

a = [260 300 145];
b = [200 200 105];
c = [300 220 125];
p = [250 240];

distab = dist(a(1),a(2),b(1),b(2));
distac = dist(a(1),a(2),c(1),c(2));
distap = dist(a(1),a(2),p(1),p(2));
distbc = dist(b(1),b(2),c(1),c(2));
distbp = dist(b(1),b(2),p(1),p(2));
distcp = dist(c(1),c(2),p(1),p(2));

distmatrix = [0 distab distac; distab 0 distbc; distac distbc 0]
distpmatrix = [distap; distbp; distac]


weight = distmatrix^-1*distpmatrix%sum not equal to 1

row = [1 1 1];
col = [1; 1; 1; 0];

distmatrix = [distmatrix; row];
distmatrix = [distmatrix col];
distpmatrix = [distpmatrix; 1];

newweight = distmatrix^-1*distpmatrix; %first 3 terms add to 1
elevation = newweight(1)*a(3)+newweight(2)*b(2)+newweight(3)*c(3)
%168.3084

function distance = dist(x1,y1,x2,y2)
distance = sqrt((x2-x1)^2+(y2-y1)^2);
end