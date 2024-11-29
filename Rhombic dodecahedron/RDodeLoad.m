function [ tile ] = RDodeLoad( type )
%
% RDODELOAD: Makes a rhombic dodecahedral tile of the sphere.
%
% 
% INPUT:
%
%   type   : String specifying solution type. 'num' for numeric solution,
%       'sym' for symbolic solution.
%
% OUTPUT:
%
%   tile	: NURBS object representing the tile of the sphere.
% 

addpath('..');

if nargin == 0
    type = 'num';
end

if nargin > 1
    error('Too many input arguments');
end

%% Define vertex points

s2 = sqrt(sym(2));
s3 = sqrt(sym(3));

Q1 = [s2/2;0;-s2/2]; % see en.wikipedia.org/wiki/Regular_icosahedron#Cartesian_coordinates
Q2 = [0;s3/3;-s2/s3];
Q3 = [-s2/2;0;-s2/2];
Q4 = [0;-s3/3;-s2/s3];

R = norm(Q1); % sphere radius

points = [Q1,Q2,Q3,Q4]/R; % rescale to unit sphere

%% Generate tile
        
switch type
    case 'num'
        
        load('rdodetile.mat'); % precomputed sym ctrl pts of sphere tile
        tile = nrbmak(double(hcon3d),{[0 0 0 0 0 1 1 1 1 1] [0 0 0 0 0 1 1 1 1 1]});

%         [tile,~] = MakeTile(points); % make tile

    case 'sym'
        
        load('rdodetile.mat'); % precomputed sym ctrl pts of sphere tile
        tile = nrbmak(hcon3d,{[0 0 0 0 0 1 1 1 1 1] [0 0 0 0 0 1 1 1 1 1]});
       
%         [tile,~] = MakeTile(points,'sym'); % make tile
        
    otherwise 
        error('Specify solution type (num or sym)');
end

%% Supplementary code

% axis equal
% patch(points(1,:),points(2,:),points(3,:),'b')

% axis equal
% nrbplot(tile,[10,10])

end

