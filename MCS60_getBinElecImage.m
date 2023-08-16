%% Create binary Mask to identify electrodes in the Ca images
MCS60_getCoords

% Define image size
imageSize = [1024, 1024];

% Define circle coordinates and radii
circleCoordinates = coords.*500+250;

circleRadii = [0.01 , 0.01].*500;
replicatedrad = repmat(circleRadii, 59, 1);
%%
%create the mask
electrode_mask = createBinaryElectrodeMask(imageSize, circleCoordinates, replicatedrad );
