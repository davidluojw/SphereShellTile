function [ tile ] = HemiSphereLoad
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
knots = {[0 0 0 0 0 1 1 1 1 1] [0 0 0 0 0 1 1 1 1 1]};


row0 = ...
 [8 4*sqrt(2) 4 2*sqrt(2) 0; % x
  0 2*sqrt(2) 4 4*sqrt(2) 8; % y
  0 0         0 0         0; % z
  8 4*sqrt(2) 16/3 4*sqrt(2) 8];% w

row1 = ...
 [4*sqrt(2) 4 5*sqrt(2)/3 0 -2*sqrt(2); % x
  -2*sqrt(2) 0 5*sqrt(2)/3 4 4*sqrt(2); % y
  0 -3 -8*sqrt(2)/3 -3 0; % z
  4*sqrt(2) 3 4*sqrt(2)/3 3 4*sqrt(2)];% w

row2 = ...
 [4 5*sqrt(2)/3 0 -5*sqrt(2)/3 -4; % x
  -4 -5*sqrt(2)/3 0 5*sqrt(2)/3 4; % y
  0 -8*sqrt(2)/3 -16/3 -8*sqrt(2)/3 0; % z
  16/3 4*sqrt(2)/3 8/9 4*sqrt(2)/3 16/3];% w

row3 = ...
 [2*sqrt(2) 0 -5*sqrt(2)/3 -4 -4*sqrt(2); % x
  -4*sqrt(2) -4 -5*sqrt(2)/3 0 2*sqrt(2); % y
  0 -3 -8*sqrt(2)/3 -3 0; % z
  4*sqrt(2) 3 4*sqrt(2)/3 3 4*sqrt(2)];% w

row4 = ...
 [ 0 -2*sqrt(2) -4   -4*sqrt(2) -8; % x
  -8 -4*sqrt(2) -4   -2*sqrt(2)  0; % y
   0 0           0    0          0; % z
   8 4*sqrt(2)   16/3 4*sqrt(2)  8];% w



coefs = cat(3, row0, row1, row2, row3, row4);
coefs(3,:,:) = -coefs(3,:,:);

tile = nrbmak(coefs, knots);

end

