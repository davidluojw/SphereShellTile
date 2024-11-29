function [rdodesphere] = Multi_HemiSphereFromCube(NB)

addpath(genpath('../../../../Toolboxes/NURBS Toolbox/nurbs-1.3.10'));

[~,NBCutted]=NURBSCutSurf(NB,0.5,1);
NBCutted.knots{1}=NBCutted.knots{1}*2-1;
%multipatch structure
rdodesphere = struct([]);
rdodesphere(1).nurbs = NB;

%rotate the different patches
rot1 = vecroty(-pi/2);
rdodesphere(2).nurbs = nrbtform(NBCutted,rot1);

rot2 = vecrotz(-pi/2);
rdodesphere(3).nurbs = nrbtform(rdodesphere(2).nurbs,rot1);
rdodesphere(4).nurbs = nrbtform(rdodesphere(3).nurbs,rot1);
rdodesphere(5).nurbs = nrbtform(rdodesphere(6).nurbs,rot2);
end
