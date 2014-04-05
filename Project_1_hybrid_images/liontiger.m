%%
im1 = imread('lion.jpg');
im2 = imread('tiger.jpg');

% Grayscale
s1 = 2; s2 = 1;

finIm = hybridIm(im1,im2,s1,s2);
finIm = finIm-min(finIm(:));
finIm = finIm./max(finIm(:));
%imwrite(finIm,'images/results/lion_tiger_gray.jpg');

showHyb(finIm);
%%
%Color both:

s1 = 4; s2 = 2;

fin_r = hybridIm(im1(:,:,1),im2(:,:,1),s1,s2);
fin_g = hybridIm(im1(:,:,2),im2(:,:,2),s1,s2);
fin_b = hybridIm(im1(:,:,3),im2(:,:,3),s1,s2);

finIm(:,:,1) = fin_r;
finIm(:,:,2) = fin_g;
finIm(:,:,3) = fin_b;

finIm = finIm-min(finIm(:));
finIm = finIm./max(finIm(:));
%imwrite(finIm,'images/results/lion_tiger_color_both.jpg');

showHyb(finIm)

%%
%First:

s1 = 4; s2 = 2;

fin_r = hybridIm(im1(:,:,1),im2,s1,s2);
fin_g = hybridIm(im1(:,:,2),im2,s1,s2);
fin_b = hybridIm(im1(:,:,3),im2,s1,s2);

finIm(:,:,1) = fin_r;
finIm(:,:,2) = fin_g;
finIm(:,:,3) = fin_b;

finIm = finIm-min(finIm(:));
finIm = finIm./max(finIm(:));
%imwrite(finIm,'images/results/lion_tiger_color_lion.jpg');

showHyb(finIm)

%%
%Second:
s1 = .1; s2 = 3;

fin_r = hybridIm(im1,im2(:,:,1),s1,s2);
fin_g = hybridIm(im1,im2(:,:,2),s1,s2);
fin_b = hybridIm(im1,im2(:,:,3),s1,s2);

finIm(:,:,1) = fin_r;
finIm(:,:,2) = fin_g;
finIm(:,:,3) = fin_b;

finIm = finIm-min(finIm(:));
finIm = finIm./max(finIm(:));
%imwrite(finIm,'images/results/lion_tiger_color_tiger.jpg');

showHyb(finIm)
