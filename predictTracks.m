function tracks = predictTracks(tracks)

        for i = 1:length(tracks)
            bbox = tracks(i).bbox;

            % using kalman filtar of track(i) predict new track centroid.
            predictedCentroid = predict(tracks(i).kalmanFilter);

            % Shift the bounding box to predicted centroid
            predictedCentroid = int32(predictedCentroid) - bbox(3:4) / 2;
            tracks(i).bbox = [predictedCentroid, bbox(3:4)];
        end
        
end

