function binaryImage = createBinaryElectrodeMask(imageSize, circleCoordinates, circleRadii)
    % imageSize: [height, width] of the output image
    % circleCoordinates: Nx2 matrix of [x, y] coordinates of circles
    % circleRadii: Nx1 vector of radii for each circle
    
    % Create an empty binary image
    binaryImage = false(imageSize(1), imageSize(2));
    
    % Ensure circleCoordinates and circleRadii have the same length
    if size(circleCoordinates, 1) ~= length(circleRadii)
        error('Number of circle coordinates must match the number of radii.');
    end
    
    % Create circles in the binary image
    for i = 1:size(circleCoordinates, 1)
        [X, Y] = meshgrid(1:imageSize(2), 1:imageSize(1));
        distanceFromCenter = sqrt((X - circleCoordinates(i, 1)).^2 + (Y - circleCoordinates(i, 2)).^2);
        circleMask = distanceFromCenter <= circleRadii(i);
        binaryImage = binaryImage | circleMask;
    end
end
