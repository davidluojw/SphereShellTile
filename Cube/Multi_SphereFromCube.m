function [rdodesphere] = Multi_SphereFromCube(NB)

addpath(genpath('../../lib/nurbs-1.3.10'));

%multipatch structure
rdodesphere = struct([]);
rdodesphere(1).nurbs = NB;

%rotate the different patches
rot1 = vecroty(-pi/2);
rdodesphere(2).nurbs = nrbtform(rdodesphere(1).nurbs,rot1);

rot2 = vecrotz(-pi/2);
rdodesphere(3).nurbs = nrbtform(rdodesphere(2).nurbs,rot2);
rdodesphere(4).nurbs = nrbtform(rdodesphere(3).nurbs,rot2);
rdodesphere(5).nurbs = nrbtform(rdodesphere(4).nurbs,rot2);

rot3 = vecroty(pi);
rdodesphere(6).nurbs = nrbtform(rdodesphere(1).nurbs,rot3);

end
