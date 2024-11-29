function [ xyz ] = stf( uv, r )
%
% STF: s-mapping of the uv plane to the unit sphere in xyz-space. See Cobb,
% 1988.
%
% Calling Sequences:
% 
%   [ xyz ] = stf( uv )
% 
% INPUT:
% 
%   uv     : 2-by-n-by-m array with points in the uv-plane
%   r      : radius of the sphere
%
% OUTPUT:
%
%   xyz    : 3-by-n-by-m array with points in the xyz-space
% 

u = uv(1,:);
v = uv(2,:);

dim = size(uv);
dim(1) = 3;

x = 4*r*r*u./(u.*u+v.*v+4*r*r);
y = 4*r*r*v./(u.*u+v.*v+4*r*r);
z = (u.*u+v.*v-4*r*r)./(u.*u+v.*v+4*r*r);

% x = 4*u./(u.*u+v.*v+4);
% y = 4*v./(u.*u+v.*v+4);
% z = (u.*u+v.*v-4)./(u.*u+v.*v+4);

xyz = [x;y;z];

xyz = reshape(xyz,dim);

end

