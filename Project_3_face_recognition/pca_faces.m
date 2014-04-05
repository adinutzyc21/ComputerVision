%be in correct folder to start with
cd('/Users/user/Documents/Courses/Courses/CSE 559A Computer Vision/Project 3')

%%
numComp = 9;
%%
% read data
[dataIm subjNos] = readData;

% process data for PCA
[dataMatrices testMatrices dataSubjNos testSubjNos]=processData1(dataIm, subjNos);
clear subjNos;

% FOR ANY IMAGES
%-------------------
% do PCA processing
[dataMat, testMat, u, v, testCoeff] = pcaProcess(numComp,dataMatrices,testMatrices);
clear testMatrices dataMatrices;
%%
% find the matches and the match rate
rate = faceRecognition(testMat,dataMat,testSubjNos, dataSubjNos, v, testCoeff, numComp, '_all');

%% FOR MEAN IMAGES
%--------------------
% get the mean image for the data subjects
[meanIm, meanCoeff, meanSubjNos] = getMeans(dataMat,dataSubjNos,u);

% minimize error for mean images and display results
rate2 = faceRecognition(testMat,meanIm,testSubjNos, meanSubjNos, meanCoeff, testCoeff, numComp, '_mean');

%% extension 1 using the edges of the image

% read data
[dataIm subjNos] = readData;

% process data for PCA
[dataMatrices2 testMatrices2 dataSubjNos2 testSubjNos2]=processData2(dataIm, subjNos);
clear subjNos;

% do PCA processing
[dataMat2, testMat2, u2, v2, testCoeff2] = pcaProcess(numComp,dataMatrices2,testMatrices2);
clear testMatrices2 dataMatrices2;
%%
% find the matches and the match rate
rate_edges = faceRecognition(testMat2,dataMat2,testSubjNos2, dataSubjNos2, v2, testCoeff2, numComp, '_all_edges');

%% FOR MEAN IMAGES
%--------------------
% get the mean image for the data subjects
[meanIm2,meanCoeff2, meanSubjNos2] = getMeans(dataMat2,dataSubjNos2,u2);

% minimize error for mean images and display results
rate_edges2 = faceRecognition(testMat2,meanIm2,testSubjNos2, meanSubjNos2, meanCoeff2, testCoeff2, numComp, '_mean_edges');
