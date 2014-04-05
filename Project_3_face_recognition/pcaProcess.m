function [dataMat, testMat, u, v, testCoeff] = pcaProcess(numComp,dataMatrices,testMatrices)
    meanIm = mean(dataMatrices,2);

    dataMat = dataMatrices - repmat(meanIm,1,360);
    [u,s,v]=svds(dataMat,numComp);
    v=s*v';

    testMat = testMatrices - repmat(meanIm,1,40);
    testCoeff = u' * testMat(:,:);

end