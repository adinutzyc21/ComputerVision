function rate = faceRecognition(testMat,dataMat,testSubjNos, dataSubjNos, v, testCoeff, numComp, what)
    % minimize error for all images and display results
    counter = 0; %number of faces that are of the same subject
    for i=1:40
        minErr = Inf;
        bestInd = -1;
        for j=1:size(v,2)
            err = norm(testCoeff(1:numComp,i)-v(:,j),2);
            if err < minErr
                bestInd = j;
                minErr = err;
            end
        end
        %indices(1,i) = bestInd; 
        if strcmp(testSubjNos{i},dataSubjNos{bestInd})
            counter = counter+1;
        end
        %figure(numComp);
        %colormap gray;
        %subplot(1,2,1);
        %imagesc(reshape(testMat(:,i),112,92));
        %axis image off;
        %title([num2str(numComp) ' Test  ' testSubjNos{i}])
        %subplot(1,2,2); 
        %imagesc(reshape(dataMat(:,bestInd),112,92));
        %axis image off;
        %title(['Data   ' dataSubjNos{bestInd}]);
        %saveas(gcf,strcat('results/',num2str(numComp),what,'_',testSubjNos{i}),'jpg');
        %pause;
    end
    rate = counter/40;
end