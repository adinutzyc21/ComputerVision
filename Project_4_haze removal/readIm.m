function im = readIm(image, ext)
cd 'Dataset'
im = imread(strcat(image, ext));
cd ..

% normalize
%im=imresize(im,.5);
im = double(im);
im = im./255;