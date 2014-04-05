function J = getRadiance(A,im,tMat)
t0 = 0.1;
J = zeros(size(im));
for ind = 1:3
   J(:,:,ind) = A(ind) + (im(:,:,ind) - A(ind))./max(tMat,t0); 
end

J = J./(max(max(max(J))));