function [ uvw ] = ipstf( xyzw , r)
%
% PSTF: s-mapping of the unit sphere in projective xyz-space to the 
% projective uv plane. See Cobb, 1988.
%
% Calling Sequences:
% 
%   [ uvw ] = ipstf( xyzw )
% 
% INPUT:
% 
%   xyzw    : 4-by-n-by-m array with points in the projective xyz-space
%   r       : radius of the sphere
%
% OUTPUT:
%
%   uvw     : 3-by-n-by-m array with points in the projective uv-plane
% 

x = xyzw(1,:);
y = xyzw(2,:);
z = xyzw(3,:);
w = xyzw(4,:);

dim = size(xyzw);
dim(1) = 3;

u = 2*r*x;
v = 2*r*y;
w2 = r*w-z;

% u = 2*x;
% v = 2*y;
% w2 = w-z;

uvw = [u;v;w2];

uvw = reshape(uvw,dim);

end

