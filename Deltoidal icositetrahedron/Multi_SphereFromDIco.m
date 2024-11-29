function [dicosphere] = Multi_SphereFromDIco(NB)

addpath(genpath('../../../../Toolboxes/NURBS Toolbox/nurbs-1.3.10'));

%multipatch structure
dicosphere = struct([]);
dicosphere(1).nurbs = NB;

%rotate the different patches

rot1 = vecrotz(pi/2);
dicosphere(2).nurbs = nrbtform(dicosphere(1).nurbs,rot1);
dicosphere(3).nurbs = nrbtform(dicosphere(2).nurbs,rot1);
dicosphere(4).nurbs = nrbtform(dicosphere(3).nurbs,rot1);

rot2 = vecrotx(pi/2);
dicosphere(5).nurbs = nrbtform(dicosphere(1).nurbs,rot2);
dicosphere(6).nurbs = nrbtform(dicosphere(2).nurbs,rot2);
dicosphere(7).nurbs = nrbtform(dicosphere(3).nurbs,rot2);
dicosphere(8).nurbs = nrbtform(dicosphere(4).nurbs,rot2);

dicosphere(9).nurbs = nrbtform(dicosphere(5).nurbs,rot2);
dicosphere(10).nurbs = nrbtform(dicosphere(6).nurbs,rot2);
dicosphere(11).nurbs = nrbtform(dicosphere(7).nurbs,rot2);
dicosphere(12).nurbs = nrbtform(dicosphere(8).nurbs,rot2);

dicosphere(13).nurbs = nrbtform(dicosphere(9).nurbs,rot2);
dicosphere(14).nurbs = nrbtform(dicosphere(10).nurbs,rot2);
dicosphere(15).nurbs = nrbtform(dicosphere(11).nurbs,rot2);
dicosphere(16).nurbs = nrbtform(dicosphere(12).nurbs,rot2);

rot3 = vecroty(pi/2);
dicosphere(17).nurbs = nrbtform(dicosphere(1).nurbs,rot3);
dicosphere(18).nurbs = nrbtform(dicosphere(2).nurbs,rot3);
dicosphere(19).nurbs = nrbtform(dicosphere(3).nurbs,rot3);
dicosphere(20).nurbs = nrbtform(dicosphere(4).nurbs,rot3);
 
rot4 = vecroty(-pi/2);
dicosphere(21).nurbs = nrbtform(dicosphere(1).nurbs,rot4);
dicosphere(22).nurbs = nrbtform(dicosphere(2).nurbs,rot4);
dicosphere(23).nurbs = nrbtform(dicosphere(3).nurbs,rot4);
dicosphere(24).nurbs = nrbtform(dicosphere(4).nurbs,rot4);


end
