%% Setup

% Change Directory
cd('/Users/Derek/Documents/School/Washington University/Classes/CSE559A (Computer Vision)/Project 3/')

% Image Options
imageDirectory = 'att_faces'; imageScale = 0.5; precropImageSize = imageScale .* [112, 92]; crop = floor([0, 0, precropImageSize(2), precropImageSize(1)]); imageSize = [crop(4), crop(3)];
%imageDirectory = 'lftw_faces'; imageScale = 0.5; precropImageSize = imageScale .* [250, 250]; crop = floor([0, 0, precropImageSize(2), precropImageSize(1)]); imageSize = [crop(4), crop(3)];
%imageDirectory = 'lftw_faces'; imageScale = 0.5; precropImageSize = imageScale .* [250, 250]; crop = floor([0.25*precropImageSize(2), 0.25*precropImageSize(1), 0.5*precropImageSize(1), 0.5*precropImageSize(2)]); imageSize = [crop(4)+1, crop(3)+1];

% Number of Components
numComponents = 9;

% Output Figures Flag
outputFigures = 0;
%outputFigures = 1;

% Comparison Method
comparison = 'training';
%comparison = 'mean';

% Calculate Number of Pixels
numPixels = imageSize(1) * imageSize(2);

%% Read Images

% Clear Image Matrices
clear trainingImages;
clear testImages;
clear classMeanImages;
clear trainingLabels;
clear testLabels;
clear classMeanLabels;    

% Read Images
directories    = dir(imageDirectory);
numDirectories = length(directories);
for directoryIndex = 1:numDirectories    
    directory = directories(directoryIndex).name;
    label     = directory;
    if(strcmp(directory, '.') ||  strcmp(directory , '..') || strcmp(directory, 'README') || strcmp(directory, '.DS_Store'))
        continue
    end
    directory = fullfile(imageDirectory, directory);    

    files          = dir(directory);
    numFiles       = length(files);
    classImageSum  = zeros(numPixels, 1);
    classNumImages = 0;
    for fileIndex = 1:numFiles-1
        file = files(fileIndex).name;
        if(strcmp(file , '.') ||  strcmp(file, '..'))
            continue
        end
        file = fullfile(directory, file);
        
        image = double(reshape(imcrop(imresize(imread(file), precropImageSize), crop), numPixels, 1));
        
        classImageSum  = classImageSum + image;
        classNumImages = classNumImages + 1;
        
        if exist('trainingImages', 'var')
            trainingImages = cat(2, trainingImages, image);
        else
            trainingImages = image;
        end
        
        if exist('trainingLabels', 'var')
            trainingLabels = cat(2, trainingLabels, label);
        else
            trainingLabels = {label};
        end
    end

    classMeanImage = classImageSum ./ classNumImages;
    if exist('classMeanImages', 'var')
        classMeanImages = cat(2, classMeanImages, classMeanImage);
    else
        classMeanImages = classMeanImage;
    end
    
    if exist('classMeanLabels', 'var')
        classMeanLabels = cat(2, classMeanLabels, label);
    else
        classMeanLabels = {label};
    end
        
    file = fullfile(directory, files(numFiles).name);
    image = double(reshape(imcrop(imresize(imread(file), precropImageSize), crop), numPixels, 1));
    if exist('testImages', 'var')
        testImages = cat(2, testImages, image);
    else
        testImages = image;
    end
    
    if exist('testLabels', 'var')
        testLabels = cat(2, testLabels, label);
    else
        testLabels = {label};
    end
end

% Compute Number of Images
numTestImages      = size(testImages, 2);
numTrainingImages  = size(trainingImages, 2);
numClassMeanImages = size(classMeanImages, 2);

%% Calculate Eigen Faces

method = 'eigenfaces';

globalMean = mean(trainingImages, 2);

trainingImagesVariance  = trainingImages  - repmat(globalMean, 1, numTrainingImages);
testImagesVariance      = testImages      - repmat(globalMean, 1, numTestImages);
classMeanImagesVariance = classMeanImages - repmat(globalMean, 1, numClassMeanImages);

%% 

[trainingComponents, trainingValues, trainingCoefficients] = svds(trainingImagesVariance, numComponents);
trainingCoefficients  = transpose(trainingCoefficients);

testCoefficients      = transpose(trainingComponents) * testImagesVariance;
classMeanCoefficients = transpose(trainingComponents) * classMeanImagesVariance;

%% Calculate Fisher Faces

method = 'fisherfaces';

classSize = 9;

Sw = zeros(numPixels);
Sb = zeros(numPixels);

globalMeanImage = mean(classMeanImages, 2);

stop = 0;
rr =0;
for classMeanImageIndex = 1:numClassMeanImages
    classMeanImage = classMeanImages(:, classMeanImageIndex);
    
    start = stop + 1;
    stop  = stop + classSize;
    for trainingImageIndex = start:stop
        trainingImage = trainingImages(:, trainingImageIndex);
                
        intraClassVariance = trainingImage - classMeanImage;
        Sw = Sw + (intraClassVariance * transpose(intraClassVariance));
    end
    
    interClassVariance = classMeanImage - globalMeanImage;
    Sb = Sb + (interClassVariance * transpose(interClassVariance));
end

[trainingComponents trainingValues] = eigs(Sb, Sw + 0.01*eye(numPixels), numComponents);

trainingCoefficients  = transpose(trainingComponents) * (trainingImages  - repmat(globalMeanImage, 1, numTrainingImages));
testCoefficients      = transpose(trainingComponents) * (testImages      - repmat(globalMeanImage, 1, numTestImages));
classMeanCoefficients = transpose(trainingComponents) * (classMeanImages - repmat(globalMeanImage, 1, numClassMeanImages));

%% Calculate Best Match

numCorrect = 0;
for testImageIndex = 1:numTestImages
    if (strcmp(comparison, 'training'))
        numComparisonImages    = numTrainingImages;
        comparisonCoefficients = trainingCoefficients;
        comparisonLabels       = trainingLabels;
        comparisonImages       = trainingImages;
    elseif (strcmp(comparison, 'mean'))
        numComparisonImages    = numClassMeanImages;
        comparisonCoefficients = classMeanCoefficients;
        comparisonLabels       = classMeanLabels;
        comparisonImages       = classMeanImages;
    end
    
    bestError = Inf;
    bestIndex = 0;

    for comparisonImageIndex = 1:numComparisonImages
        error = norm(testCoefficients(:, testImageIndex) - comparisonCoefficients(:, comparisonImageIndex), 2);
        
        if (error < bestError)
            bestError = error;
            bestIndex = comparisonImageIndex;
        end
    end
    
    testLabel       = testLabels{testImageIndex};
    comparisonLabel = comparisonLabels{bestIndex};
    
    if (strcmp(testLabel, comparisonLabel))
        numCorrect = numCorrect + 1;
    end
    
    if (outputFigures)
        figure(1);

        subplot(1, 2, 1);
        imagesc(reshape(testImages(:, testImageIndex), imageSize));
        title(testLabel, 'interpreter', 'none');
        axis image off;
        colormap gray;

        subplot(1, 2, 2);
        imagesc(reshape(comparisonImages(:, bestIndex), imageSize));  
        title(comparisonLabel, 'interpreter', 'none');
        axis image off;
        colormap gray;
        
        saveas(1, fullfile('results', imageDirectory, strcat(int2str(numComponents), '_', comparison, '_', method, '_', testLabel)), 'jpg');
    end
end

successRate = numCorrect / numTestImages

%% Component Viewing

figure(1); 

numViewComponents = 4;
for componentIndex = 1:numViewComponents
    subplot(1, numViewComponents, componentIndex);
    imagesc(reshape(real(trainingComponents(:, componentIndex)), imageSize));
    colormap gray;
end