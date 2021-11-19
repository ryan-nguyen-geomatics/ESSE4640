img = imread('DEM.tif');
imshow(img)
% xcell = 0.000208333333333334;
% ycell = 0.000208333333333336;
% 
% % 4 neighbours
% 
% for i = 1:3
%     for j = 1:3
%         z(i,j) = img(i,j);
%     end
% end
% 
% %4 neighbours
% 
% dZdX4 = double((z(2,3) - z(2,1)) / (2*xcell));
% dZdY4 = double((z(1,2) - z(3,2)) / (2*ycell));
% 
% slope4 = atand(sqrt(dZdX4^2 + dZdY4^2));
% aspect = atand((dZdX4/dZdY4));
% 
% if aspect < 0
%     aspect4 = 360 + aspect;
% else
%     aspect4 = aspect;
% end
% 
% %8 neighbours
% dZdX8 = double(((z(1,3) - z(1,1)) + 2*(z(2,3) - z(2,1)) + (z(3,3) - z(3,1))) / (8*xcell));
% dZdY8 = double(((z(1,1) - z(3,1)) + 2*(z(1,2) - z(3,2)) + (z(1,3) - z(3,3))) / (8*ycell));
% 
% slope8 = atand(sqrt(dZdX8.^2+dZdY8.^2));
% aspect = atand((dZdX8/dZdY8));
% 
% if aspect < 0
%     aspect8 = 360 + aspect;
% else
%     aspect8 = aspect;
% end
% 
% 
% %A-4
% % 4 neighbours
% for i = 1:length(img(:,1))-2
%     for j = 1:length(img(1,:))-2
%         dZdX4 = double((img(i+1,i+2) - img(i+1,i)) / (2*xcell));
%         dZdY4 = double((img(i,i+1) - img(i+2,i+1)) / (2*ycell));
% 
%         slope4 = atand(sqrt(dZdX4^2 + dZdY4^2));
%         aspect = atand((dZdX4/dZdY4));
%        
%         if aspect < 0
%             aspect4 = 360 + aspect;
%         else
%             aspect4 = aspect;
%         end
% 
%         array_slope4(i,j) = slope4;
%         array_aspect4(i,j) = aspect4;
%     end
% end
% 
% % 8 neighbours
% for i = 1:length(img(:,1))-2
%     for j = 1:length(img(1,:))-2
%         dZdX8 = double(((img(1,3) - img(1,1)) + 2*(img(2,3) - img(2,1)) + (img(3,3) - img(3,1))) / (8*xcell));
%         dZdY8 = double(((img(1,1) - img(3,1)) + 2*(img(1,2) - img(3,2)) + (img(1,3) - img(3,3))) / (8*ycell));
% 
%         slope8 = atand(sqrt(dZdX8.^2+dZdY8.^2));
%         aspect = atand((dZdX8/dZdY8));
%         
%         if aspect < 0
%             aspect8 = 360 + aspect;
%         else
%             aspect8 = aspect;
%         end
%         
%         array_slope8(i,j) = slope8;
%         array_aspect8(i,j) = aspect8;
%     end
% end

% max = max(max(img)) %392
% min = min(min(img)) %74
% countour = (max + min) / 2 


