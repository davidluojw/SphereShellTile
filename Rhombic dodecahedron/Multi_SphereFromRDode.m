function [rdodesphere2] = Multi_SphereFromRDode(NB)

addpath(genpath('../../../../Toolboxes/NURBS Toolbox/nurbs-1.3.10'));

%multipatch structure
rdodesphere = struct([]);
rdodesphere(1).nurbs = NB;

%rotate the different patches
rot1 = vecrot(pi/2,[sqrt(2)/2;0;-sqrt(2)/2]);
rdodesphere(2).nurbs = nrbtform(rdodesphere(1).nurbs,rot1);
rdodesphere(3).nurbs = nrbtform(rdodesphere(2).nurbs,rot1);
rdodesphere(4).nurbs = nrbtform(rdodesphere(3).nurbs,rot1);

rot2 = vecrot(pi/2,[-sqrt(2)/2;0;-sqrt(2)/2]);
rdodesphere(5).nurbs = nrbtform(rdodesphere(1).nurbs,rot2);
rdodesphere(6).nurbs = nrbtform(rdodesphere(5).nurbs,rot2);
rdodesphere(7).nurbs = nrbtform(rdodesphere(6).nurbs,rot2);

rot3 = vecrotx(pi);
rdodesphere(8).nurbs = nrbtform(rdodesphere(1).nurbs,rot3);
rdodesphere(9).nurbs = nrbtform(rdodesphere(2).nurbs,rot3);
rdodesphere(10).nurbs = nrbtform(rdodesphere(4).nurbs,rot3);
rdodesphere(11).nurbs = nrbtform(rdodesphere(5).nurbs,rot3);
rdodesphere(12).nurbs = nrbtform(rdodesphere(7).nurbs,rot3);


rdodesphere2(1).nurbs=rdodesphere(1).nurbs;
rdodesphere2(2).nurbs=rdodesphere(2).nurbs;
rdodesphere2(3).nurbs=rdodesphere(7).nurbs;
rdodesphere2(4).nurbs=rdodesphere(10).nurbs;
rdodesphere2(5).nurbs=rdodesphere(11).nurbs;
rdodesphere2(6).nurbs=rdodesphere(6).nurbs;
rdodesphere2(7).nurbs=rdodesphere(5).nurbs;
rdodesphere2(8).nurbs=rdodesphere(4).nurbs;
rdodesphere2(9).nurbs=rdodesphere(3).nurbs;
rdodesphere2(10).nurbs=rdodesphere(8).nurbs;
rdodesphere2(11).nurbs=rdodesphere(12).nurbs;
rdodesphere2(12).nurbs=rdodesphere(9).nurbs;


end
