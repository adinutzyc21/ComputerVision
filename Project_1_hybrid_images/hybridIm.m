% finIm = hybridIm(im11,im22,sigma1,sigma2) creates a hybrid image of im11
% and im22, by blurring image im11 using sigma1 and im22 using sigma2
% Adina Stoica 2012, CSE 559A Computer Vision, Washington University in St. Louis
function finIm = hybridIm(im11,im22,sigma1,sigma2)
    if(length(size(im11))==3)
        im1 = double(rgb2gray(im11));
    else
        im1 = double(im11);
    end
    
    if(length(size(im22))==3)
        im2 = double(rgb2gray(im22));
    else
        im2 = double(im22);
    end

    G1 = fspecial('gaussian',[25 25],sigma1);
    Ig1 = imfilter(im1,G1,'same');
    im2 = imresize(im2, size(im1));
    
%     G3 = fspecial('laplacian',0.7);
%     Ig3 = imfilter(im2,G3,'same');
    
    G2 = fspecial('gaussian',[25 25],sigma2);
    Ig2 = imfilter(im2,G2,'same');
    Ig3 = im2 - Ig2;

    Ig1 = Ig1-min(Ig1(:));
    Ig1 = Ig1./max(Ig1(:));
    
    Ig3 = Ig3-min(Ig3(:));
    Ig3 = Ig3./max(Ig3(:));
%     
%     imwrite(Ig1,'images/results/now_blur.jpg');
%     imwrite(Ig3,'images/results/then_blur.jpg');
    finIm = Ig1 + Ig3;
    
