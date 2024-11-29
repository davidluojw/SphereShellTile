function [tile,sgp] = MakeTile(ver3d,r,type,xiet)
%
% MAKETILE: Makes a NURBS tile of the sphere from four vertex points.
%           See Dedoncker et al., 'Bezier tilings of the sphere and
%           applications in benchmarking multipatch isogeometric methods'.
%
% Calling Sequences:
% 
%   [tile,sgp] = MakeTile(ver3d)
%   [tile,sgp] = MakeTile(ver3d,type)
%   [tile,sgp] = MakeTile(ver3d,type,xiet)
% 
% INPUT:
% 
%   ver3d   : 3-by-4 matrix with the coordinates of 4 (ordered) vertices on
%       the sphere. Vertices should be ordered clockwise when viewed from
%       outside the sphere. The tile should be convex for a NURBS
%       representation to exist and should not contain the north pole.
%
%   type   : String specifying solution type. 'num' for numeric solution,
%       'sym' for symbolic solution.
%
%   xiet   : 2-cell array {xi,et} where xi and et are row vectors. These
%       vectors must represent a 5-by-5 collocation grid in parametric
%       space.
%   r      : radius of the sphere
% 
% OUTPUT:
%
%   tile	: NURBS object representing the tile of the sphere.
% 
%   sgp	: NURBS object representing the stereographic projection of the
%       tile on the z=-1 plane.
% 
% COMMENTS: 
%
%   - This code requires the NURBS Toolbox (version 1.3.10) https://octave.sourceforge.io/nurbs/
%   - Symbolic solution might take a very long time depending on the tile

addpath(genpath('../../lib/nurbs-1.3.10')); % load NURBS Toolbox (change depending on you file structure)

%% Complete input

if nargin == 2
    type = 'num';
end

if nargin < 4 && strcmp(type,'num')
    xi = [0:1/4:1]; % collocation points in parametric space
    et = xi;
elseif  nargin < 4 && strcmp(type,'sym')
    xi = sym([0:1/4:1]); % collocation points in parametric space
    et = xi;
elseif  nargin == 4
    xi = cell2mat(xiet(1));
    et = cell2mat(xiet(2));
end

if nargin > 4
    error('Too many input arguments');
end

%% Catch invalid input

if size(ver3d,2) ~= 4 || size(ver3d,1) ~= 3
    error('Give a matrix of four column vectors.');
end

if strcmp(type,'num') && isa(ver3d,'sym')
    ver3d = eval(ver3d);
end

if strcmp(type,'num')
    ver3dnorm = round(sum(ver3d.^2,1),14);
elseif strcmp(type,'sym')
    ver3dnorm = eval(sum(ver3d.^2,1));
else
    error('Specify solution type (num or sym)');
end

% if(any(ver3dnorm ~= ones(1,4)))
%     error('Vertices must lie on the unit sphere.')
% end

%% Initialize variables

if strcmp(type,'num')
    
    planes = zeros(3,4); % matrix of a and b coeffs
    circles = zeros(3,4); % matrix of [Cu;Cv;R]
    hecon = []; % homog coords of the external cntrl pts
    hcon2d = zeros(4,3,3); % homog coords for cntrl pts of the sgp tile
    NM = zeros(25,25); % coeff matrix of the collocation system
    hcon3d = zeros(4,5,5); % % homog coords for cntrl pts of the sphere tile
    
else
    
    planes = sym(zeros(3,4)); % matrix of a and b coeffs
    circles = sym(zeros(3,4)); % matrix of [Cu;Cv;R]
    hecon = []; % homog coords of the external cntrl pts
    hcon2d = sym(zeros(4,3,3)); % homog coords for cntrl pts of the sgp tile
    NM = sym(zeros(25,25)); % coeff matrix of the collocation system
    hcon3d = sym(zeros(4,5,5)); % % homog coords for cntrl pts of the sphere tile
    
end

%% Solve

ver3d = [ver3d,ver3d(:,1),ver3d(:,2)]; % repeat first and second point
ver2d = istf(ver3d, r); % representations of the points in the uv plane

% Find planes through great circle (ax+by+z=0 or ax+by=0)
% planes(:,i) = [ai;bi;1] or [ai;bi;0]
% Planes are defined by their inward (wrt the tile) pointing normal vectors

npchk = [];

for i =1:4
    
%     matrix = [ver3d(1:2,i)';ver3d(1:2,i+1)'];
%     
%     if [-ver3d(2,i),ver3d(1,i)]*(ver3d(1:2,i) - ver3d(1:2,i+1)) == 0 % plane is vertical (ax+by=0)
%         rhs = [0;0];
%     else
%         rhs = -[ver3d(3,i)';ver3d(3,i+1)'];
%     end
%     
%     planes(:,i) = matrix\rhs; 
    
    nvec1 = cross((ver3d(:,i+1)-ver3d(:,i)),ver3d(:,i)); % inward pointing vector normal to the current plane
    nvec1 = nvec1/norm(nvec1);
    
    npchk = [npchk, dot([0; 0; r],nvec1)]; % keeps track of location of north pole wrt the planes
    
    if nvec1(3,1) == 0              % plane is vertical (ax+by=0)
        planes(:,i) = nvec1(1:3,1);
    else                            % plane is not vertical (ax+by+z=0)
        planes(:,i) = nvec1(1:3,1)/nvec1(3,1);
    end
    
    nvec2 = cross((ver3d(:,i+2)-ver3d(:,i+1)),ver3d(:,i+1)); % inward pointing vector normal to the subsequent plane
    nvec2 = nvec2/norm(nvec2);
    
    tvec = cross(ver3d(:,i+1),nvec2); % vector tangential to the next plane and normal to the intersection line
    tvec = tvec/norm(tvec); 
    
    if dot(nvec1,tvec)<=0 || any(isnan([nvec1;tvec]))
        error('Vertices are invalid. Check that: no two vertices are the same, the internal angles are smaller than 180 degrees, the vertices are ordered correctly.');
    end
    
end

if all(npchk >= zeros(1,4))
    error('Tile contains the north pole. Consider rotating the vertices.')
end

% Find circle arcs representing edges in the (u,v) plane. 
% R = 2*r*sqrt(1+a^2+b^2) and C = (-2r*a,-2r*b)

circles(1,:) = -2*r*planes(1,:);
circles(2,:) = -2*r*planes(2,:);
circles(3,:) = 2*r*sqrt(1 + planes(1,:).^2 + planes(2,:).^2);

% Find external control points in the z=-r plane

for i=1:4
    P1 = ver2d(:,i);
    P3 = ver2d(:,i+1);
    Q = (P1+P3)/2;
    C = circles(1:2,i);
    R = circles(3,i);
    
    if planes(3,i) == 0 %[-ver3d(2,i),ver3d(1,i)]*(ver3d(1:2,i) - ver3d(1:2,i+1)) == 0 % plane is vertical (ax+by=0)
        P2 = Q; 
        w2 = 1; 
    else
        P2 = C+(Q-C)*R^2/norm(Q-C)^2; % |CP2| = |CQ|/(cos(alpha)^2)
        w2 = norm(Q-C)/R; % w2 = cos(alpha)
    end
    
    new  = [P1,P2*w2;-r,-r*w2;1,w2]; % in 4D homogenous coordinates! Needed to construct patch properly
    hecon = [hecon,new];
end

% Construct control net in the z=-r plane

hcon2d(:,1,1) = hecon(:,1);
hcon2d(:,2,1) = hecon(:,2);
hcon2d(:,3,1) = hecon(:,3);
hcon2d(:,3,2) = hecon(:,4);
hcon2d(:,3,3) = hecon(:,5);
hcon2d(:,2,3) = hecon(:,6);
hcon2d(:,1,3) = hecon(:,7);
hcon2d(:,1,2) = hecon(:,8);
hcon2d(:,2,2) = [0;0;-r;1]; % central point

% Make patch in the z=-r plane

sgp = nrbmak(hcon2d,{[0 0 0 1 1 1] [0 0 0 1 1 1]});  % Construct a NURBS from control points and knots

% Calculate points corresponding to collocation points

[p,w] = nrbeval(sgp,{xi,et});    % Evalution of NURBS curve or surface.
hcol2d = [p;w];

% Project onto the sphere using the s-mapping

hcol3d = pstf(hcol2d, r);

if strcmp(type,'sym')
    hcol3d = simplify(hcol3d);
end
     
% Evaluate the basis functions for the projective 3 space in the collocation points

bfxi = basisfun (findspan(4,4,xi,[0 0 0 0 0 1 1 1 1 1]),xi,4,[0 0 0 0 0 1 1 1 1 1]);
bfet = basisfun (findspan(4,4,et,[0 0 0 0 0 1 1 1 1 1]),et,4,[0 0 0 0 0 1 1 1 1 1]);

for i = 1:5
    for j = 1:5
       temp = bfxi(i,:)'*bfet(j,:);
       k  = i + (j-1)*5;
       NM(k,:) = temp(:); % equation for collocation point k
    end
end

% Solve for each dimension separately

for i = 1:4
    rhs = hcol3d(i,:,:);
    rhs = rhs(:);   
    temp = NM\rhs;
    hcon3d(i,:,:) = reshape(temp,[1,5,5]);
end

if strcmp(type,'sym')
    hcon3d = simplify(hcon3d);
end

% Make tile

tile = nrbmak(hcon3d,{[0 0 0 0 0 1 1 1 1 1] [0 0 0 0 0 1 1 1 1 1]});

%% Supplementary code

% figure; hold on;
% circleplot(circles(1,1),circles(2,1),circles(3,1))
% circleplot(circles(1,2),circles(2,2),circles(3,2))
% circleplot(circles(1,3),circles(2,3),circles(3,3))
% circleplot(circles(1,4),circles(2,4),circles(3,4))
% hold off

% figure; hold on
%     arc  = nrbmak([P1,w2*P2,P3;-1,-w2,-1;1,w2,1],[0,0,0,1,1,1]); 
%     nrbplot(arc,50)
%     circleplot(C(1),C(2),R)  

% hcon3d = hcon3d/hcon3d(4,1,1);

end

