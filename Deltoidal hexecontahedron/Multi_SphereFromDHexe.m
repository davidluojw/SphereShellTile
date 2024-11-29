function [dhexesphere] = Multi_SphereFromDHexe(NB)

addpath(genpath('../../../../Toolboxes/NURBS Toolbox/nurbs-1.3.10'));

%multipatch structure
dhexesphere = struct([]);
dhexesphere(1).nurbs = NB;


%make a paired ico patch
gr = (1+sqrt(5))/2;
A1 = [1;0;-gr]; % see en.wikipedia.org/wiki/Regular_icosahedron#Cartesian_coordinates
A2 = [0;gr;-1];
A3 = [-1;0;-gr];
A4 = (A1+A2+A3)/3;

rot0 = vecrot(pi/5,A1); %rotate first tile
dhexesphere(1).nurbs = nrbtform(dhexesphere(1).nurbs,rot0);

rot1 = vecrot(2*pi/3,A4);
dhexesphere(2).nurbs = nrbtform(dhexesphere(1).nurbs,rot1);
dhexesphere(3).nurbs = nrbtform(dhexesphere(2).nurbs,rot1);

rot2 = vecrot(-2*pi/5,A1);
dhexesphere(4).nurbs = nrbtform(dhexesphere(1).nurbs,rot2);
dhexesphere(5).nurbs = nrbtform(dhexesphere(2).nurbs,rot2);
dhexesphere(6).nurbs = nrbtform(dhexesphere(3).nurbs,rot2);


%rotate the 10 different patches
rot3 = vecrot(2*pi/5,A2);

dhexesphere(7).nurbs = nrbtform(dhexesphere(1).nurbs,rot3);
dhexesphere(8).nurbs = nrbtform(dhexesphere(2).nurbs,rot3);
dhexesphere(9).nurbs = nrbtform(dhexesphere(3).nurbs,rot3);
dhexesphere(10).nurbs = nrbtform(dhexesphere(4).nurbs,rot3);
dhexesphere(11).nurbs = nrbtform(dhexesphere(5).nurbs,rot3);
dhexesphere(12).nurbs = nrbtform(dhexesphere(6).nurbs,rot3);

dhexesphere(13).nurbs = nrbtform(dhexesphere(7).nurbs,rot3);
dhexesphere(14).nurbs = nrbtform(dhexesphere(8).nurbs,rot3);
dhexesphere(15).nurbs = nrbtform(dhexesphere(9).nurbs,rot3);
dhexesphere(16).nurbs = nrbtform(dhexesphere(10).nurbs,rot3);
dhexesphere(17).nurbs = nrbtform(dhexesphere(11).nurbs,rot3);
dhexesphere(18).nurbs = nrbtform(dhexesphere(12).nurbs,rot3);

dhexesphere(19).nurbs = nrbtform(dhexesphere(13).nurbs,rot3);
dhexesphere(20).nurbs = nrbtform(dhexesphere(14).nurbs,rot3);
dhexesphere(21).nurbs = nrbtform(dhexesphere(15).nurbs,rot3);
dhexesphere(22).nurbs = nrbtform(dhexesphere(16).nurbs,rot3);
dhexesphere(23).nurbs = nrbtform(dhexesphere(17).nurbs,rot3);
dhexesphere(24).nurbs = nrbtform(dhexesphere(18).nurbs,rot3);

dhexesphere(25).nurbs = nrbtform(dhexesphere(19).nurbs,rot3);
dhexesphere(26).nurbs = nrbtform(dhexesphere(20).nurbs,rot3);
dhexesphere(27).nurbs = nrbtform(dhexesphere(21).nurbs,rot3);
dhexesphere(28).nurbs = nrbtform(dhexesphere(22).nurbs,rot3);
dhexesphere(29).nurbs = nrbtform(dhexesphere(23).nurbs,rot3);
dhexesphere(30).nurbs = nrbtform(dhexesphere(24).nurbs,rot3);

rot4 = vecrotx(pi);

dhexesphere(31).nurbs = nrbtform(dhexesphere(1).nurbs,rot4);
dhexesphere(32).nurbs = nrbtform(dhexesphere(2).nurbs,rot4);
dhexesphere(33).nurbs = nrbtform(dhexesphere(3).nurbs,rot4);
dhexesphere(34).nurbs = nrbtform(dhexesphere(4).nurbs,rot4);
dhexesphere(35).nurbs = nrbtform(dhexesphere(5).nurbs,rot4);
dhexesphere(36).nurbs = nrbtform(dhexesphere(6).nurbs,rot4);

dhexesphere(37).nurbs = nrbtform(dhexesphere(7).nurbs,rot4);
dhexesphere(38).nurbs = nrbtform(dhexesphere(8).nurbs,rot4);
dhexesphere(39).nurbs = nrbtform(dhexesphere(9).nurbs,rot4);
dhexesphere(40).nurbs = nrbtform(dhexesphere(10).nurbs,rot4);
dhexesphere(41).nurbs = nrbtform(dhexesphere(11).nurbs,rot4);
dhexesphere(42).nurbs = nrbtform(dhexesphere(12).nurbs,rot4);

dhexesphere(43).nurbs = nrbtform(dhexesphere(13).nurbs,rot4);
dhexesphere(44).nurbs = nrbtform(dhexesphere(14).nurbs,rot4);
dhexesphere(45).nurbs = nrbtform(dhexesphere(15).nurbs,rot4);
dhexesphere(46).nurbs = nrbtform(dhexesphere(16).nurbs,rot4);
dhexesphere(47).nurbs = nrbtform(dhexesphere(17).nurbs,rot4);
dhexesphere(48).nurbs = nrbtform(dhexesphere(18).nurbs,rot4);

dhexesphere(49).nurbs = nrbtform(dhexesphere(19).nurbs,rot4);
dhexesphere(50).nurbs = nrbtform(dhexesphere(20).nurbs,rot4);
dhexesphere(51).nurbs = nrbtform(dhexesphere(21).nurbs,rot4);
dhexesphere(52).nurbs = nrbtform(dhexesphere(22).nurbs,rot4);
dhexesphere(53).nurbs = nrbtform(dhexesphere(23).nurbs,rot4);
dhexesphere(54).nurbs = nrbtform(dhexesphere(24).nurbs,rot4);

dhexesphere(55).nurbs = nrbtform(dhexesphere(25).nurbs,rot4);
dhexesphere(56).nurbs = nrbtform(dhexesphere(26).nurbs,rot4);
dhexesphere(57).nurbs = nrbtform(dhexesphere(27).nurbs,rot4);
dhexesphere(58).nurbs = nrbtform(dhexesphere(28).nurbs,rot4);
dhexesphere(59).nurbs = nrbtform(dhexesphere(29).nurbs,rot4);
dhexesphere(60).nurbs = nrbtform(dhexesphere(30).nurbs,rot4);


end
