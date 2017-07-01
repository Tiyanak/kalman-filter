 function [objectsWithTracks, tracksWithoutObjects, objectsWithoutTracks] = pairObjectsWithTracks(tracks, centroids)

        % Compute the distance between object and track
        dist = zeros(length(tracks), size(centroids, 1));
        for i = 1:length(tracks)
            dist(i, :) = distance(tracks(i).kalmanFilter, centroids);
        end

        % Solve the assignment problem.
        maxDistance = 20;
        
        % assignments - Index pairs of tracks and corresponding detections. This value is
        % returned as an L-by-2 matrix of index pairs, with L number of pairs. 
        % The first column represents the track index and the second column represents the detection index.
        
        % unassignedTracks - Unassigned tracks, returned as a P-element vector. P represents the
        % number of unassigned tracks. Each element represents a track to which no detections are assigned.
        
        % unassignedDetections - Unassigned detections, returned as a Q-element vector, where Q represents the number of unassigned 7
        % detections. Each element represents a detection that was not assigned to any tracks. These detections can begin new tracks.
        
        [objectsWithTracks, tracksWithoutObjects, objectsWithoutTracks] = assignDetectionsToTracks(dist, maxDistance);
    end