%%
im1 = imread('lion2.jpg');
im2 = imread('cat.jpg');

% Grayscale
s1 = 1; s2 = 20;

finIm = hybridIm(im1,im2,s1,s2);
finIm = finIm-min(finIm(:));
finIm = finIm./max(finIm(:));
imwrite(finIm,'images/results/lion2_cat_gray.jpg');

showHyb(finIm);
%%
%Color both:

s1 = 4; s2 = 12;

fin_r = hybridIm(im1(:,:,1),im2(:,:,1),s1,s2);
fin_g = hybridIm(im1(:,:,2),im2(:,:,2),s1,s2);
fin_b = hybridIm(im1(:,:,3),im2(:,:,3),s1,s2);

finIm(:,:,1) = fin_r;
finIm(:,:,2) = fin_g;
finIm(:,:,3) = fin_b;

finIm = finIm-min(finIm(:));
finIm = finIm./max(finIm(:));
imwrite(finIm,'images/results/lion2_cat_color_both.jpg');

showHyb(finIm)

%%
%First:

s1 = 4; s2 = 10;

fin_r = hybridIm(im1(:,:,1),im2,s1,s2);
fin_g = hybridIm(im1(:,:,2),im2,s1,s2);
fin_b = hybridIm(im1(:,:,3),im2,s1,s2);

finIm(:,:,1) = fin_r;
finIm(:,:,2) = fin_g;
finIm(:,:,3) = fin_b;

finIm = finIm-min(finIm(:));
finIm = finIm./max(finIm(:));
imwrite(finIm,'images/results/lion2_cat_color_lion2.jpg');

showHyb(finIm)

%%
%Second:
s1 = 4; s2 = 10;

fin_r = hybridIm(im1,im2(:,:,1),s1,s2);
fin_g = hybridIm(im1,im2(:,:,2),s1,s2);
fin_b = hybridIm(im1,im2(:,:,3),s1,s2);

finIm(:,:,1) = fin_r;
finIm(:,:,2) = fin_g;
finIm(:,:,3) = fin_b;

finIm = finIm-min(finIm(:));
finIm = finIm./max(finIm(:));
imwrite(finIm,'images/results/lion2_cat_color_cat.jpg');

showHyb(finIm)
