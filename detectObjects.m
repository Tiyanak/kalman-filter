 function [centroids, bboxes, mask] = detectObjects(frame, video)
 
%        foregroundMask = step(H,I) computes the foreground mask for input 
%        image I, and returns a logical mask. When the object returns foregroundMask 
%        set to 1, it represents foreground pixels. Image I can be grayscale or color.
%        When you set the AdaptLearningRate property to true (default), the object permits
%        this form of the step function call.
        mask = video.detector.step(frame);
      

        % Apply morphological operations to remove noise and fill in holes.
        
%         IM2 = imopen(IM,SE) performs morphological opening on the grayscale
% or binary image IM with the structuring element SE. The argument SE must be a 
% single structuring element object, as opposed to an array of objects. The morphological 
% open operation is an erosion followed by a dilation, using the same structuring element for both operations.
        mask = imopen(mask, strel('rectangle', [3,3]));
         
%         performs morphological closing on the grayscale or binary image IM, 
%         returning the closed image, IM2. The structuring element, SE, must be a 
%         single structuring element object, as opposed to an array of objects. The
%         morphological close operation is a dilation followed by an erosion, using
%         the same structuring element for both operations.
%         IM2 = imclose(IM,SE)
        mask = imclose(mask, strel('rectangle', [15, 15]));
        
%         BW2= imfill(BW,locations) performs a flood-fill operation on
%         background pixels of the input binary image BW, starting from the 
%         points specified in locations. If locations is a P-by-1 vector, it contains 
%         the linear indices of the starting locations. If locations is a P-by-ndims(BW) 
%         matrix, each row contains the array indices of one of the starting locations.
        mask = imfill(mask, 'holes');

        % Perform blob analysis to find connected components.
        [~, centroids, bboxes] = video.blobAnalyser.step(mask);
        
end