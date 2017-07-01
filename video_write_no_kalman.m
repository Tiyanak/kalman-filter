function video_write_no_kalman(frame, videoWriter, bboxes)

        % Convert the frame and the mask to uint8 RGB.
        frame = im2uint8(frame);
        labels = [];
        
        for i = 1:(length(bboxes(:))/4)
            labels(end + 1) = i;
        end
        
        length(labels)
        length(bboxes(:))
        
        if ~isempty(bboxes)

            % nacrtaj boxove oko objekata na pravom videu
            frame = insertObjectAnnotation(frame, 'rectangle', bboxes, labels, 'Color', 'magenta');

        end
       
        writeVideo(videoWriter, frame);
end