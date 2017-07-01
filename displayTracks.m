function displayTracks(frame, mask, tracks, video)
        
        % Convert the frame and the mask to uint8 RGB.
        frame = im2uint8(frame);
        mask = uint8(repmat(mask, [1, 1, 3])) .* 255;

        if ~isempty(tracks)

            % dohvati boxove
            bboxes = cat(1, tracks.bbox);

            % dohvati id tragova
            ids = int32([tracks(:).id]);

            % napravi labele za prikaz
            labels = cellstr(int2str(ids'));

            % nacrtaj boxove oko objekata na pravom videu
            frame = insertObjectAnnotation(frame, 'rectangle', bboxes, labels, 'Color', 'magenta');

           % nacrtaj boxove oko objekata na maski
            mask = insertObjectAnnotation(mask, 'rectangle', bboxes, labels, 'Color', 'magenta');
         end
       
        % Display the mask and the frame.
        video.maskPlayer.step(mask);
        video.videoPlayer.step(frame);
end