function [ xyzw ] = pstf( uvw, r )
%
% PSTF: s-mapping of the projective uv plane to the unit sphere in 
% projective xyz-space. See Cobb, 1988
%
% Calling Sequences:
% 
%   [ xyzw ] = pstf( uvw )
% 
% INPUT:
% 
%   uvw     : 3-by-n-by-m array with points in the projective uv-plane
%   r       : radius of the sphere
%
% OUTPUT:
%
%   xyzw    : 4-by-n-by-m array with points in the projective xyz-space
% 

u = uvw(1,:);
v = uvw(2,:);
w = uvw(end,:);

dim = size(uvw);
dim(1) = 4;

% x = 2*r*r*u.*(w+1);
% y = 2*r*r*v.*(w+1);
% z = r*(u.*u+v.*v-r*r*(w+1).*(w+1));
% w2 = u.*u+v.*v+r*r*(w+1).*(w+1);

x = 4*r*r*u.*w.*w;
y = 4*r*r*v.*w.*w;
z = r*w.*(u.*u+v.*v-4*r*r*w.*w);
w2 = u.*u+v.*v+4*r*r*w.*w;

% x = 4*u.*w;
% y = 4*v.*w;
% z = u.*u+v.*v-4*w.*w;
% w2 = u.*u+v.*v+4*w.*w;

xyzw = [x;y;z;w2];

xyzw = reshape(xyzw,dim);

end

