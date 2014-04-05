cd('/Users/Derek/Documents/School/Washington University/Classes/CSE559A (Computer Vision)/Project Final Dehaze');

% Input Options
ext           = '.jpg';
filenames     = {'canon' 'city_1' 'city_2' 'cones' 'lake' 'mountain' 'ny_1' 'ny_2' 'pumpkins' 'stadium' 'toys' 'trees'};
scalingFactor = 0.5;

numFiles = size(filenames, 2);
for fileIndex = 1:numFiles
    % Get Filename
    filename = char(filenames(fileIndex));
    disp(strcat('Processing: ', filename));
    
    % Read Image
    imageRGB = imresize(readIm(filename, ext), scalingFactor);
    imwrite(imageRGB, fullfile('Results', strcat(filename, ext)));

    % 3.0 Dark Channel Prior
    dark = darkChannel(imageRGB);
    imwrite(dark, fullfile('Results', strcat(filename, '_dark', ext)));

    % 4.4 Estimating the Atmospheric Light
    atmospheric = atmLight(imageRGB, dark);

    % 4.1 Estimating the Transmission
    transmission = transmissionEstimate(imageRGB, atmospheric);
    imwrite(transmission, fullfile('Results', strcat(filename, '_trans', ext)));

    % 4.3 Recovering the Scene Radiance
    radiance = getRadiance(atmospheric, imageRGB, transmission);
    imwrite(radiance, fullfile('Results', strcat(filename, '_rad', ext)));
    
    % 4.2 Apply Soft Matting
    refinedTransmission = matte(imageRGB, transmission);
    imwrite(refinedTransmission, fullfile('Results', strcat(filename, '_reftrans', ext)));

    % 4.3 Recovering the Scene Radiance
    refinedRadiance = getRadiance(atmospheric, imageRGB, refinedTransmission);
    imwrite(refinedRadiance, fullfile('Results', strcat(filename, '_refrad', ext)));
end