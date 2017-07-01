function tracks = correctTracks(objectWithTracks, centroids, bboxes, tracks)
        
        numOfTracks = size(objectWithTracks, 1);
        
        for i = 1:numOfTracks
        
            trackId = objectWithTracks(i, 1); % tu je predikcija
            detectionId = objectWithTracks(i, 2); % tu je mjerenje
            
            centroid = centroids(detectionId, :); % centoridi mjerenja
            bbox = bboxes(detectionId, :); % od mjerenja
        
            % Correct the estimate of the object's location using the new detection.
            [correctedLocation, ~, ~] = correct(tracks(trackId).kalmanFilter, centroid); %predikcija, mjerenje == ispravljenu lokaciju
            
            
            % dodano
            correctedCentroid = int32(correctedLocation) - bbox(3:4) / 2;
            tracks(trackId).bbox = [correctedCentroid, bbox(3:4)];
          
            % Update track's age.
            tracks(trackId).age = 1;

        end
      
end