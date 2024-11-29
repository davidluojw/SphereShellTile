function [rtriasphere] = Multi_SphereFromRTria(NB)

addpath(genpath('../../../../Toolboxes/NURBS Toolbox/nurbs-1.3.10'));

%multipatch structure
rtriasphere = struct([]);
rtriasphere(1).nurbs = NB;

%rotate the different patches
gr = (1+sqrt(5))/2;


rot1 = vecrot(2*pi/5,[gr^2;0;-gr^3]);
rtriasphere(2).nurbs = nrbtform(rtriasphere(1).nurbs,rot1);
rtriasphere(3).nurbs = nrbtform(rtriasphere(2).nurbs,rot1);
rtriasphere(4).nurbs = nrbtform(rtriasphere(3).nurbs,rot1);


rot2 = vecrot(2*pi/5,[-gr^2;0;-gr^3]);
rtriasphere(5).nurbs = nrbtform(rtriasphere(1).nurbs,rot2);
rtriasphere(6).nurbs = nrbtform(rtriasphere(2).nurbs,rot2);
rtriasphere(7).nurbs = nrbtform(rtriasphere(3).nurbs,rot2);
rtriasphere(8).nurbs = nrbtform(rtriasphere(4).nurbs,rot2);

rtriasphere(9).nurbs = nrbtform(rtriasphere(5).nurbs,rot2);
rtriasphere(10).nurbs = nrbtform(rtriasphere(6).nurbs,rot2);
rtriasphere(11).nurbs = nrbtform(rtriasphere(7).nurbs,rot2);
rtriasphere(12).nurbs = nrbtform(rtriasphere(8).nurbs,rot2);

rtriasphere(13).nurbs = nrbtform(rtriasphere(9).nurbs,rot2);
rtriasphere(14).nurbs = nrbtform(rtriasphere(10).nurbs,rot2);
rtriasphere(15).nurbs = nrbtform(rtriasphere(11).nurbs,rot2);
rtriasphere(16).nurbs = nrbtform(rtriasphere(12).nurbs,rot2);

rtriasphere(17).nurbs = nrbtform(rtriasphere(13).nurbs,rot2);
rtriasphere(18).nurbs = nrbtform(rtriasphere(14).nurbs,rot2);
rtriasphere(19).nurbs = nrbtform(rtriasphere(15).nurbs,rot2);
rtriasphere(20).nurbs = nrbtform(rtriasphere(16).nurbs,rot2);
 

rot3 = vecroty(pi);
rtriasphere(21).nurbs = nrbtform(rtriasphere(1).nurbs,rot3);
rtriasphere(22).nurbs = nrbtform(rtriasphere(5).nurbs,rot3);
rtriasphere(23).nurbs = nrbtform(rtriasphere(9).nurbs,rot3);
rtriasphere(24).nurbs = nrbtform(rtriasphere(13).nurbs,rot3);
rtriasphere(25).nurbs = nrbtform(rtriasphere(17).nurbs,rot3);

rtriasphere(26).nurbs = nrbtform(rtriasphere(2).nurbs,rot3);
rtriasphere(27).nurbs = nrbtform(rtriasphere(6).nurbs,rot3);
rtriasphere(28).nurbs = nrbtform(rtriasphere(10).nurbs,rot3);
rtriasphere(29).nurbs = nrbtform(rtriasphere(14).nurbs,rot3);
rtriasphere(30).nurbs = nrbtform(rtriasphere(18).nurbs,rot3);


end
