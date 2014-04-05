function [meanIm, meanCoeff, meanSubjNos] = getMeans(dataMat,dataSubjNos,u)
    meanIm = zeros(112*92,40);%get the mean images for every image
    meanSubjNos = cell(1,40);
    j=1;
    for i=1:9:360
        meanIm(:,j) = mean(dataMat(:,i:i+8),2);
        meanSubjNos{j} = dataSubjNos{i};
        j=j+1;
    end
    meanCoeff = u' * meanIm(:,:);
end