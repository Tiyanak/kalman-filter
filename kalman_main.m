videoPath = 'C:\Users\Igor Farszky\Desktop\kalman_videi\t8.mp4';

% objekt za citanje videa, detekciju objekata u kretanju i prikaza
% rezultata
video = VideoConf(videoPath);

% prazno polje tragova objekata
tracks = initializeTracks(); 

% id sljedeceg traga
nextId = 1; 

% inicijaliziraj pocetne tragove objekata
frame = video.videoReader.step();
[centroids, bboxes, mask] = detectObjects(frame, video);
[tracks, nextId] = createTracks(centroids, bboxes, nextId, tracks, []);

videoWriter = VideoWriter('C:\Users\Igor Farszky\Desktop\soccer_kalman_final_velocity_mask.avi');
open(videoWriter);

% citaj frame po frame i radi predikcije
count = 0;
while ~isDone(video.videoReader)
    
    % procitaj jedan frame
    frame = video.videoReader.step();
    
    % polje sa centroidima objekata, boxovima oko njih i maskama
    [centroids, bboxes, mask] = detectObjects(frame, video);
    
    % predikcija novih lokacija objekata
    tracks = predictTracks(tracks);
    
    % find tracks that have objects in frame, dont have objects, and
    % objects that dont have tracks
    [objectsWithTracks, tracksWithoutObjects, objectsWithoutTracks] = pairObjectsWithTracks(tracks, centroids);
    
    % ispravi bboxove novih tragova i neka kalman popravi svoju predikciju
    tracks = correctTracks(objectsWithTracks, centroids, bboxes, tracks);
    
    % update the age of tracks or delete it from tracks if its too old
    % old means its too long without detected object
    tracks = updateOrDeleteTracks(tracks, tracksWithoutObjects);
    
    % create new tracks according to the objects without tracks
    [tracks, nextId] = createTracks(centroids, bboxes, nextId, tracks, objectsWithoutTracks);
   
    % prikazi rezultate kalmana
    % displayTracks(frame, mask, tracks, video);
    
    % write video to disc
    video_write(mask, videoWriter, tracks);
    fprintf('wrote frame: %i\n', count);
    
    count = count + 1;
    
end

close(videoWriter);
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    