function binaryImage = cellsBinaryMask(imageSize, cellstats)
    % imageSize: [height, width] of the output image
    % circleCoordinates: Nx2 matrix of [x, y] coordinates of circles
    % circleRadii: Nx1 vector of radii for each circle
    
    % Create an empty binary image
    binaryImage = false(imageSize(1), imageSize(2));
    
    % Create circles in the binary image
    for i = 1:numel(cellstats)
        xpix = cellstats{i}.xpix;
        ypix = cellstats{i}.ypix;
        
        % Ensure the pixel coordinates are within the image bounds
        validPixels = xpix >= 1 & xpix <= imageSize(2) & ...
                      ypix >= 1 & ypix <= imageSize(1);
        
        xpix = xpix(validPixels);
        ypix = ypix(validPixels);
        
        % Convert pixel coordinates to linear indices
        indices = sub2ind(size(binaryImage), ypix, xpix);
        
        % Mark the selected pixels as true in the binary image
        binaryImage(indices) = true;
    end