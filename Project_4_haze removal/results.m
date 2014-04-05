% Show results
function results(image) 

im = readIm(image);
J = deHaze(im);
figure;
subplot(1,2,1);
imagesc(im)
title 'Original'
axis image off;
subplot(1,2,2);
imagesc(J)
title 'De-hazed'
axis image off;