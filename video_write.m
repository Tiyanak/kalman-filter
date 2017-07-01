function video_write(frame, videoWriter, tracks)

        % Convert the frame and the mask to uint8 RGB.
        frame = im2uint8(frame);
       
        if ~isempty(tracks)

            % dohvati boxove
            bboxes = cat(1, tracks.bbox);

            % dohvati id tragova
            ids = int32([tracks(:).id]);

            % napravi labele za prikaz
            labels = cellstr(int2str(ids'));

            % nacrtaj boxove oko objekata na pravom videu
            frame = insertObjectAnnotation(frame, 'rectangle', bboxes, labels, 'Color', 'magenta');

          
        end
       
        writeVideo(videoWriter, frame);
end