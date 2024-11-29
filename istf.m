function [ uv ] = istf( xyz, r )
%
% ISTF: s-mapping of the unit sphere in xyz-space to the uv plane. See
% Cobb, 1988
%
% Calling Sequences:
% 
%   [ xyz ] = istf( uv )
% 
% INPUT:
% 
%   xyz    : 3-by-n-by-m array with points in the xyz-space
%   r      : radius of the sphere
%
% OUTPUT:
%
%   uv     : 2-by-n-by-m array with points in the uv-plane
% 

x = xyz(1,:);
y = xyz(2,:);
z = xyz(3,:);

dim = size(xyz);
dim(1) = 2;

u = 2*r*x./(-z+r);
v = 2*r*y./(-z+r);

% u = 2*x./(-z+1);
% v = 2*y./(-z+1);

uv = [u;v];

uv = reshape(uv,dim);

end

