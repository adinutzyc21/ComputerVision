function transmission = transmissionEstimate(im, A)

omega = 0.95; % the amount of haze we're keeping

im3 = zeros(size(im));
for ind = 1:3 
    im3(:,:,ind) = im(:,:,ind)./A(ind);
end

% imagesc(im3./(max(max(max(im3))))); colormap gray; axis off image

transmission = 1-omega*darkChannel(im3);
