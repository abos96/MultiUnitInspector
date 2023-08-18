% Clear previous variables, close figures, and clear command window
clear all
close all
clc

%% Display the binary image electrodes
% Call a function to get the binary electrode image
MCS60_getBinElecImage

% Create a new figure and display the binary electrode image
f = figure();
imshow(electrode_mask );
title('Binary Image with Circles');

%% Get Ca image to process
% Open a dialog box to select a TIFF file
[file, path] = uigetfile('*.tiff', 'Select a TIFF file');
if isequal(file, 0) || isequal(path, 0)
    disp('No file selected.');
    return;
end

% Construct the full file path
fullFilePath = fullfile(path, file);

% Read the first frame from the TIFF file
try
    info = imfinfo(fullFilePath);
    firstFrame = imread(fullFilePath, 1);
    disp('First frame successfully extracted.');
    
    % Display the first frame
    figure;
    imshow(firstFrame);
    title('First Frame');
catch
    disp('Error reading the TIFF file or extracting the first frame.');
end

%% Threshold first frame
% Define a threshold value to separate dark and light pixels
threshold = 5000;  % Adjust this value based on your image

% Binarize the image based on the threshold
binaryFirstFrame = firstFrame < threshold;

% Display the thresholded first frame
figure;
imshow(binaryFirstFrame);
title('Thresholded First Frame');

%% Register the two images
% Set the fixed and moving images for registration
fixed = binaryFirstFrame;  % Replace with your image
moving = electrode_mask;  % Replace with your image

% Call the registerImages function to align the images
[alignedImage, tform] = registerImages(double(moving), double(fixed));

%% Display the aligned images
% Create a new figure
figure;

% Display the uint16 image
subplot(1, 2, 1);
imshow(firstFrame, []);
title('Uint16 Image');

% Display the double image with a red overlay
subplot(1, 2, 2);
imshow(firstFrame, []);
hold on;
alignedImage(:,:,2) = zeros(size(alignedImage, 1));
alignedImage(:,:,3) = zeros(size(alignedImage, 1));


% Display a blended comparison of the original and aligned images
imshowpair(firstFrame, alignedImage, 'blend');
title('Double Image with Red Overlay');
hold off;

%% Apply transformation to the coords array
[x,y] = transformPointsForward(tform,coords(:,1).*500+250,coords(:,2).*500+250);
%% Load Fluorescence traces
wordToAdd = '_fluo';

% Split the filename into parts
[filePath, baseName, extension] = fileparts(file);

% Create the new filename with the added word
fluoName = [baseName, wordToAdd, '.mat'];

% add the path
fluoName = fullfile(path,fluoName);

%load fluorescence file
fluorescence = load(fluoName);

%get fluorescence traces
allFluorescenceTraces = fluorescence.F;

%exclude non cell traces
iscell = fluorescence.iscell(:,1);
cellFluorescenceTraces = allFluorescenceTraces(find(iscell),:);
cellstats = fluorescence.stat(find(iscell))'; 
for i = 1 : length(cellstats)
cellCenters(i,1) = cellstats{i}.med(2);
cellCenters(i,2) = cellstats{i}.med(1);
end
circleRadii = [0.01 , 0.01].*500;
replicatedrad = repmat(circleRadii, length(cellstats), 1);
cellMask = cellsBinaryMask(imageSize,cellstats);

figure 
% Display the images using imshowpair with custom colors
imshowpair(firstFrame, cellMask);
