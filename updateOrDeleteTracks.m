function tracks = updateOrDeleteTracks(tracks, tracksWithoutObjects)
        
        for i = 1:length(tracksWithoutObjects)
            lonelyTrackId = tracksWithoutObjects(i);
            tracks(lonelyTrackId).age = tracks(lonelyTrackId).age + 1;
        end
        
        ageThreshold = 5;
            
        ages = [tracks(:).age];
        
        deleteIds = (ages > ageThreshold);
        
        tracks = tracks(~deleteIds);
        
end