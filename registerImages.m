function [alignedImage,tform] = registerImages(moving, fixed)
    % Convert the images to grayscale
    if size(moving, 3) == 3
        graymoving = rgb2gray(moving);
    else
        graymoving = moving;
    end

    if size(fixed, 3) == 3
        grayfixed = rgb2gray(fixed);
    else
        grayfixed = fixed;
    end
    
    tform = imregcorr(graymoving, grayfixed);

    % Apply the transformation to the second image
    alignedImage = imwarp(graymoving, tform, 'OutputView', imref2d(size(grayfixed)));

   
end
