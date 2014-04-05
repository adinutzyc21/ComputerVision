function [] = showHyb(im)
    figure(1), hold off, 
    imagesc(im), colormap gray,
    axis off, axis image
    title('Final Image')