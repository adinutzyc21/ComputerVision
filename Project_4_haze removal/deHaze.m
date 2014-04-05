function J = deHaze(im)

JDark = darkChannel(im);
A = atmLight(im, JDark);
transmission = transmissionEstimate(im, A);
tMat = transmission;
J = getRadiance(A,im,tMat);