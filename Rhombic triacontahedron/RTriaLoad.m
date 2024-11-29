function [ tile ] = RTriaLoad( type )
%
% RTRIALOAD: Makes a rhombic triacontahedral tile of the sphere.
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

Q1 = [gr^2;0;-gr^3]; % see http://www.rwgrayprojects.com/rbfnotes/polyhed/PolyhedraData/RhombicTriaconta/RhombicTriaconta.pdf
Q2 = [0;gr;-gr^3];
Q3 = [-gr^2;0;-gr^3];
Q4 = [0;-gr;-gr^3];

R1 = norm(Q1); R2 = norm(Q2); R3 = norm(Q3); R4 = norm(Q4);% sphere radius

points = [Q1/R1,Q2/R2,Q3/R3,Q4/R4]; % rescale to unit sphere

%% Generate tile
        
switch type
    case 'num'
        
        load('rtriatile.mat'); % precomputed sym ctrl pts of sphere tile
        tile = nrbmak(double(hcon3d),{[0 0 0 0 0 1 1 1 1 1] [0 0 0 0 0 1 1 1 1 1]});

%         [tile,~] = MakeTile(points); % make tile

    case 'sym'
        
        load('rtriatile.mat'); % precomputed sym ctrl pts of sphere tile
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

