function [ tile ] = SphereLoad (type)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
knots = {[0 0 0 0 0 1 1 1 1 1] [0 0 0 0 0 1 1 1 1 1]};

if nargin == 0
    type = 'num';
end

switch type
    case 'sym'
        
        sqrt3 = sqrt(sym(3));
        sqrt2 = sqrt(sym(2));

    case 'num'
        
        sqrt3 = sqrt(3);
        sqrt2 = sqrt(2);
        
    otherwise
        error('Specify solution type (num or sym)');
        
end

row0 = ...
 [4*(1-sqrt3)   -sqrt2                0                  sqrt2                4*(sqrt3-1); % x
  4*(1-sqrt3)    sqrt2*(sqrt3-4)    4*(1-2*sqrt3)/3  sqrt2*(sqrt3-4)    4*(1-sqrt3); % y
  4*(1-sqrt3)    sqrt2*(sqrt3-4)    4*(1-2*sqrt3)/3  sqrt2*(sqrt3-4)    4*(1-sqrt3); % z
  4*(3-sqrt3)    sqrt2*(3*sqrt3-2)  4*(5-sqrt3)/3    sqrt2*(3*sqrt3-2)  4*(3-sqrt3)];% w

row1 = ...
 [sqrt2*(sqrt3-4)   (2-3*sqrt3)/2   0                       -(2-3*sqrt3)/2  -sqrt2*(sqrt3-4);  % x
 -sqrt2               (2-3*sqrt3)/2   sqrt2*(2*sqrt3-7)/3  (2-3*sqrt3)/2   -sqrt2;           % y
  sqrt2*(sqrt3-4)   -(sqrt3+6)/2    -5/3*sqrt2*sqrt3     -(sqrt3+6)/2    sqrt2*(sqrt3-4);   % z
  sqrt2*(3*sqrt3-2) (sqrt3+6)/2     sqrt2*(sqrt3+6)/3    (sqrt3+6)/2     sqrt2*(3*sqrt3-2)];% w

row2 = ...
 [4*(1-2*sqrt3)/3  sqrt2*(2*sqrt3-7)/3  0               -sqrt2*(2*sqrt3-7)/3  -4*(1-2*sqrt3)/3;% x
  0               0                 0               0                  0;              % y
  4*(1-2*sqrt3)/3  -5*sqrt2*sqrt3/3     4*(sqrt3-5)/3    -5*sqrt2*sqrt3/3      4*(1-2*sqrt3)/3; % z
  4*(5-sqrt3)/3    sqrt2*(sqrt3+6)/3    4*(5*sqrt3-1)/9  sqrt2*(sqrt3+6)/3     4*(5-sqrt3)/3];  % w

row3 = ...
 [sqrt2*(sqrt3-4)   (2-3*sqrt3)/2   0                  -(2-3*sqrt3)/2  -sqrt2*(sqrt3-4);  % x
  sqrt2            -(2-3*sqrt3)/2  -sqrt2*(2*sqrt3-7)/3  -(2-3*sqrt3)/2  sqrt2;            % y
  sqrt2*(sqrt3-4)   -(sqrt3+6)/2    -5/3*sqrt2*sqrt3      -(sqrt3+6)/2    sqrt2*(sqrt3-4);   % z
  sqrt2*(3*sqrt3-2) (sqrt3+6)/2     sqrt2*(sqrt3+6)/3     (sqrt3+6)/2     sqrt2*(3*sqrt3-2)];% w

row4 = ...
 [4*(1-sqrt3)    -sqrt2               0                     sqrt2             4*(sqrt3-1); % x
  -4*(1-sqrt3)   -sqrt2*(sqrt3-4)   -4*(1-2*sqrt3)/3 -sqrt2*(sqrt3-4)   -4*(1-sqrt3);% y
  4*(1-sqrt3)    sqrt2*(sqrt3-4)    4*(1-2*sqrt3)/3  sqrt2*(sqrt3-4)    4*(1-sqrt3); % z
  4*(3-sqrt3)    sqrt2*(3*sqrt3-2)  4*(5-sqrt3)/3    sqrt2*(3*sqrt3-2)  4*(3-sqrt3)];% w


coefs = cat(3, row0, row1, row2, row3, row4);
% coefs(3,:,:) = -coefs(3,:,:);

coefs(2,:,:) = -coefs(2,:,:);
coefs(1,:,:) = -coefs(1,:,:);
coefs = coefs/coefs(4,1,1);

tile = nrbmak(coefs, knots);

end

