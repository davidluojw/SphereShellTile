function [ tile ] = DHexeLoad( type )
%
% RTRIALOAD: Makes a deltoidal hexecontahedral tile of the sphere centered on the south pole.
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

gr = (1+sqrt(sym(5)))/2; % golden ratio
gr = eval(gr);

% Icosahedron
A1 = [1;0;-gr]; % see en.wikipedia.org/wiki/Regular_icosahedron#Cartesian_coordinates
A2 = [0;gr;-1];
A3 = [-1;0;-gr];

% Trisection
Q1 = A1;
Q2 = (A1+A2)/2;
Q3 = (A1+A2+A3)/3;
Q4 = (A3+A1)/2;

R1 = norm(Q1); R2 = norm(Q2); R3 = norm(Q3); R4 = norm(Q4);% sphere radius

points = [Q1/R1,Q2/R2,Q3/R3,Q4/R4]; % rescale to unit sphere

% Rotation
rotm = axang2rotm([points(:,1)',-pi/5]);
points = rotm*points;

%% Generate tile
        
switch type
    case 'num'
        
        load('dhexetile.mat'); % precomputed sym ctrl pts of sphere tile
        tile = nrbmak(double(hcon3d),{[0 0 0 0 0 1 1 1 1 1] [0 0 0 0 0 1 1 1 1 1]});

%         [tile,~] = MakeTile(points); % make tile

    case 'sym'
        
        load('dhexetile.mat'); % precomputed sym ctrl pts of sphere tile
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

