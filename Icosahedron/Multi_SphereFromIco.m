function [icosphere] = Multi_SphereFromIco(NB)

addpath(genpath('../../../../Toolboxes/NURBS Toolbox/nurbs-1.3.10'));

icosphere = struct([]);
icosphere(1).nurbs = NB;


%rotate the different patches
rot1 = vecrot(2*pi/5,[0;(1+sqrt(5))/2/2;-1/2]);
icosphere(2).nurbs = nrbtform(icosphere(1).nurbs,rot1);
icosphere(3).nurbs = nrbtform(icosphere(2).nurbs,rot1);
icosphere(4).nurbs = nrbtform(icosphere(3).nurbs,rot1);
icosphere(5).nurbs = nrbtform(icosphere(4).nurbs,rot1);

rot2 = vecrotx(pi);
icosphere(6).nurbs = nrbtform(icosphere(1).nurbs,rot2);
icosphere(7).nurbs = nrbtform(icosphere(6).nurbs,rot1);
icosphere(8).nurbs = nrbtform(icosphere(7).nurbs,rot1);
icosphere(9).nurbs = nrbtform(icosphere(8).nurbs,rot1);
icosphere(10).nurbs = nrbtform(icosphere(9).nurbs,rot1);

end
