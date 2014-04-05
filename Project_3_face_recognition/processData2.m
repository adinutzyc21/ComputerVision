function [dataMatrices2 testMatrices2 dataSubjNos testSubjNos]=processData2(dataIm, subjNos)
    dataMatrices2 = zeros(112*92,360);%make sure this is correct, 40 subjects of 9 images each
    dataSubjNos = cell(1,360);
    testMatrices2 = zeros(112*92,40);% one test image for each of 40 subjects
    testSubjNos = cell(1,40);
    k=1; t=1; 
    for i=1:400
        if mod(i,10)~=0 %if it's not the tenth image in a subject
            dataSubjNos{k} = subjNos{i};
            dataMatrices2(:,k) = reshape(edge(dataIm(:,:,i),'canny'),112*92,1);
            k=k+1;
        else
            testSubjNos{t} = subjNos{i};
            testMatrices2(:,t) = reshape(edge(dataIm(:,:,i),'canny'),112*92,1);
            t=t+1;
        end
    end
end