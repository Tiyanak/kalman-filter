 function [tracks, nextId] = createTracks(centroids, bboxes, nextId, tracks, objectsWithoutTracks)
        
        centroids = centroids(objectsWithoutTracks, :);
        bboxes = bboxes(objectsWithoutTracks, :);
        
        for i = 1:size(centroids, 1)

            centroid = centroids(i,:);
            bbox = bboxes(i, :);
            
%        The Kalman filter object is designed for tracking. You can use
%        it to predict a physical object's future location, to reduce noise 
%        in the detected location, or to help associate multiple physical 
%        objects with their corresponding tracks. A Kalman filter object 
%        can be configured for each physical object for multiple object tracking.
%        To use the Kalman filter, the object must be moving at constant velocity 
%        or constant acceleration.

%         obj = vision.KalmanFilter(StateTransitionModel,MeasurementModel,ControlModel,Name,Value) 
%         configures the Kalman filter object properties, specified as one or more Name,Value 
%         pair arguments. Unspecified properties have default values.

%         StateTransitionModel - Model describing state transition between time steps (A)
%         Specify the transition of state between times as an M-by-M matrix. After the object 
%         is constructed, this property cannot be changed. This property relates to the A variable in the State-Space System.
%         Default: [1 1 0 0; 0 1 0 0; 0 0 1 1; 0 0 0 1]
% 
%         MeasurementModel - Model describing state to measurement transformation (H)
%         Specify the transition from state to measurement as an N-by-M matrix. 
%         After the object is constructed, this property cannot be changed. This property relates to the H variable in the State-Space System.
%         Default: [1 0 0 0; 0 0 1 0]
% 
%         ControlModel - Model describing control input to state transformation (B)
%         Specify the transition from control input to state as an M-by-L matrix. After the object is constructed, this property cannot be changed. This property relates to the B variable in the State-Space System.
%         Default: []
%         
%         State - State (x)
%         Specify the state as a scalar or an M-element vector. If you specify it as a scalar it 
%         will be extended to an M-element vector. This property relates to the x variable in the State-Space System.
%         Default: [0]
% 
%         StateCovariance - State estimation error covariance (P)
%         Specify the covariance of the state estimation error as a scalar or an M-by-M matrix.
%         If you specify it as a scalar it will be extended to an M-by-M diagonal matrix. This property relates to the P variable in the State-Space System.
%         Default: [1]
% 
%         ProcessNoise - Process noise covariance (Q)
%         Specify the covariance of process noise as a scalar or an M-by-M matrix.
%         If you specify it as a scalar it will be extended to an M-by-M diagonal matrix.
%         This property relates to the Q variable in the State-Space System.
%         Default: [1]
% 
%         MeasurementNoise - Measurement noise covariance (R)
%         Specify the covariance of measurement noise as a scalar or an N-by-N matrix. If
%         you specify it as a scalar it will be extended to an N-by-N diagonal matrix. This 
%         property relates to the R variable in the State-Space System.
%         efault: [1]
% 
%       correct	Correction of measurement, state, and state estimation error covariance
%       distance	Confidence value of measurement
%       predict	Prediction of measurement

            % Create a Kalman filter object.
            kalmanFilter = configureKalmanFilter('ConstantVelocity', centroid, [1000 1000], [25, 10], 25);

            % Create a new track.
            newTrack = struct(...
                'id', nextId, ...
                'bbox', bbox, ...
                'kalmanFilter', kalmanFilter, ...
                'age', 1 ...
                );

            % Add it to the array of tracks.
            tracks(end + 1) = newTrack;

            % Increment the next id.
            nextId = nextId + 1;
        end
end