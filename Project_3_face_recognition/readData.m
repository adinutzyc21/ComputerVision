function [dataIm subjNos] = readData
    %be in correct folder to start with
    cd('/Users/user/Documents/Courses/Courses/CSE 559A Computer Vision/Project 3')

    dataIm = zeros(112,92,360);
    subjNos = cell(1,400); 
    k=1;

    cd att_faces/
    attDir = dir;
    lenAttDir=length(attDir);
    for i=1:lenAttDir
        if(strcmp(attDir(i).name , '.') ||  strcmp(attDir(i).name , '..') || strcmp(attDir(i).name , 'README') || strcmp(attDir(i).name , '.DS_Store'))
            continue
        end
        folderName = attDir(i).name;
        
        cd(folderName)
        imFiles = dir;
        lenImFiles=length(imFiles);
        for j=1:lenImFiles
            if(strcmp(imFiles(j).name , '.') ||  strcmp(imFiles(j).name , '..'))
                continue
            end
            fName=imFiles(j).name;
            dataIm(:,:,k) = imread(fName);
            subjNos{k} = folderName;
            k = k+1;
        end
        cd ..
    end
    cd ..
end