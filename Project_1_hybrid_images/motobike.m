%%
im1 = imread('motorcycle.jpg');
im2 = imread('bike.jpg');

% Grayscale
s1 = 5; s2 = 10;

finIm = hybridIm(im1,im2,s1,s2);
finIm = finIm-min(finIm(:));
finIm = finIm./max(finIm(:));
imwrite(finIm,'images/results/motorcycle_bike_gray.jpg');

showHyb(finIm);
%%
%Color both:

s1 = 4; s2 = 25;

fin_r = hybridIm(im1(:,:,1),im2(:,:,1),s1,s2);
fin_g = hybridIm(im1(:,:,2),im2(:,:,2),s1,s2);
fin_b = hybridIm(im1(:,:,3),im2(:,:,3),s1,s2);

finIm(:,:,1) = fin_r;
finIm(:,:,2) = fin_g;
finIm(:,:,3) = fin_b;

finIm = finIm-min(finIm(:));
finIm = finIm./max(finIm(:));
imwrite(finIm,'images/results/motorcycle_bike_color_both.jpg');

showHyb(finIm)

%%
%First:

s1 = 4; s2 = 25;

fin_r = hybridIm(im1(:,:,1),im2,s1,s2);
fin_g = hybridIm(im1(:,:,2),im2,s1,s2);
fin_b = hybridIm(im1(:,:,3),im2,s1,s2);

finIm(:,:,1) = fin_r;
finIm(:,:,2) = fin_g;
finIm(:,:,3) = fin_b;

finIm = finIm-min(finIm(:));
finIm = finIm./max(finIm(:));
imwrite(finIm,'images/results/motorcycle_bike_color_motorcycle.jpg');

showHyb(finIm)

%%
%Second:
s1 = 4; s2 = 25;

fin_r = hybridIm(im1,im2(:,:,1),s1,s2);
fin_g = hybridIm(im1,im2(:,:,2),s1,s2);
fin_b = hybridIm(im1,im2(:,:,3),s1,s2);

finIm(:,:,1) = fin_r;
finIm(:,:,2) = fin_g;
finIm(:,:,3) = fin_b;

finIm = finIm-min(finIm(:));
finIm = finIm./max(finIm(:));
imwrite(finIm,'images/results/motorcycle_bike_color_bike.jpg');

showHyb(finIm)
