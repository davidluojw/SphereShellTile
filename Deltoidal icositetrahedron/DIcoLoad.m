function [ tile ] = DIcoLoad( type )
%
% RTRIALOAD: Makes a deltoidal icositetrahedral tile of the sphere.
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

s3 = sqrt(sym(3));

Q1 = [0;0;-1]; % quadrisected cube tile
Q2 = [s3/3;0;-s3/3];
Q3 = [s3/3;s3/3;-s3/3];
Q4 = [0;s3/3;-s3/3];

R1 = norm(Q1); R2 = norm(Q2); R3 = norm(Q3); R4 = norm(Q4);% sphere radius

points = [Q1/R1,Q2/R2,Q3/R3,Q4/R4]; % rescale to unit sphere

%% Generate tile
        
switch type
    case 'num'
        
        load('dicotile.mat'); % precomputed sym ctrl pts of sphere tile
        tile = nrbmak(double(hcon3d),{[0 0 0 0 0 1 1 1 1 1] [0 0 0 0 0 1 1 1 1 1]});

%         [tile,~] = MakeTile(points); % make tile

    case 'sym'
        
        load('dicotile.mat'); % precomputed sym ctrl pts of sphere tile
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

