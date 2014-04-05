function [ refinedTransmission ] = matte( imageRGB, transmission )

epsilon = 10^-8;
lambda  = 10^-4;

windowSize      = [3 3];
numWindowPixels = windowSize(1) * windowSize(2);

imageSize          = size(imageRGB);
numImagePixels     = imageSize(1) * imageSize(2);
numImageDimensions = imageSize(3);

mattingLaplacian = sparse(numImagePixels, numImagePixels);
for imageRow = 2:imageSize(1)-1
    for imageCol = 2:imageSize(2)-1
        windowIndices = [imageRow-1 imageCol-1 imageRow+1 imageCol+1];
        
        window     = imageRGB(windowIndices(1):windowIndices(3), windowIndices(2):windowIndices(4), :);
        windowFlat = reshape(window, numWindowPixels, numImageDimensions);

        windowMean       = transpose(mean(windowFlat));
        windowCovariance = cov(windowFlat, 1);
        
        windowInvNumPixels          = 1 / numWindowPixels;
        windowInvCovarianceIdentity = windowCovariance + (epsilon / numWindowPixels) * speye(numImageDimensions);
        
        for firstRow = windowIndices(1):windowIndices(3)
            for firstCol = windowIndices(2):windowIndices(4)
                mattingLaplacianRow = ((firstRow - 1) * imageSize(2)) + firstCol;
                
                for secondRow = windowIndices(1):windowIndices(3)
                    %if secondRow < firstRow
                    %    continue
                    %end
                    
                    for secondCol = windowIndices(2):windowIndices(4)
                        %if secondCol < firstCol
                        %    continue
                        %end
                        
                        mattingLaplacianCol = ((secondRow - 1) * imageSize(2)) + secondCol;
                        
                        if (mattingLaplacianRow == mattingLaplacianCol)
                            kroneckerDelta = 1;
                        else
                            kroneckerDelta = 0;
                        end
                        
                        rowPixelVariance = reshape(imageRGB(firstRow,  firstCol,  :), numImageDimensions, 1) - windowMean;
                        colPixelVariance = reshape(imageRGB(secondRow, secondCol, :), numImageDimensions, 1) - windowMean;
                        
                        mattingLaplacian(mattingLaplacianRow, mattingLaplacianCol) = mattingLaplacian(mattingLaplacianRow, mattingLaplacianCol) + (kroneckerDelta - windowInvNumPixels * (1 + transpose(rowPixelVariance) / windowInvCovarianceIdentity * colPixelVariance));
                        %if kroneckerDelta == 0
                        %    mattingLaplacian(mattingLaplacianCol, mattingLaplacianRow) = mattingLaplacian(mattingLaplacianCol, mattingLaplacianRow) + (kroneckerDelta - windowInvNumPixels * (1 + transpose(colPixelVariance) / windowInvCovarianceIdentity * rowPixelVariance));
                        %end
                    end
                end
            end
        end
    end
end

transmissionFlat = reshape(transpose(transmission), numImagePixels, 1);

refinedTransmissionFlat = (mattingLaplacian + (lambda * speye(numImagePixels))) \ (lambda * transmissionFlat);

refinedTransmission = transpose(reshape(refinedTransmissionFlat, imageSize(2), imageSize(1)));

end

