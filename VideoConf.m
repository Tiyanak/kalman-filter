function systemObj = VideoConf(videoPath)

    % video file reader
    systemObj.videoReader = vision.VideoFileReader(videoPath);
    
    % video player za prikazivanje maske (crno-pozadina, bijelo-objekti)
    % video player za prikazivanje pravog videa
    
    % videoPlayer = vision.VideoPlayer(Name,Value) configures the video 
    % player properties, specified as one or more name-value pair arguments. 
    % Unspecified properties have default values
    systemObj.maskPlayer = vision.VideoPlayer('Position', [0, 100, 1690, 576]);
    systemObj.videoPlayer = vision.VideoPlayer('Position', [0, 100, 1690, 576]);
    
    % objekt za detekciju objekata, detektira krecuce objekte od
    % pozadine, za izlaz daje masku gdje je 1 objekt a 0 pozadina
    
%     detector = vision.ForegroundDetector(Name,Value) returns a foreground
%     detector System object, detector, with each specified property name set 
%     to the specified value. Name can also be a property name and Value is the
%     corresponding value. You can specify several name-value pair arguments in 
%     any order as Name1,Value1,…,NameN,ValueN.
% Number of Gaussian modes in the mixture model
% Number of initial video frames for training background model, specified as 
% the comma-separated pair consisting of 'NumTrainingFrames' and an integer. 
% Threshold to determine background model, specified as the comma-separated
% pair consisting of 'MinimumBackgroundRatio' and a numeric scalar
    systemObj.detector = vision.ForegroundDetector('NumGaussians', 3, ...
    'NumTrainingFrames', 40, 'MinimumBackgroundRatio', 0.7);
    
    % sluzi za detekciju grupa pixela, kad se nadu micuci objekti
    % vjerojatno se objekt sastoji od grupe pixela 
    % racuna podrucje, centroid, i bounding box
%     H = vision.BlobAnalysis(Name,Value) returns a blob analysis object, H,
%     with each specified property set to the specified value. You can specify
%     additional name-value pair arguments in any order as (Name1, Value1,...,NameN,ValueN).
    systemObj.blobAnalyser = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
            'AreaOutputPort', true, 'CentroidOutputPort', true, ...
            'MinimumBlobArea', 400);

end

