function tracks = initializeTracks()
        
        % prazno polje tragova objekata
        tracks = struct(...
            'id', {}, ... % id traga
            'bbox', {}, ... % box nad tragom
            'kalmanFilter', {}, ... % objekt kalmanovog filtra za taj trag
            'age', {} ... % koliko frameova je star trag, prestar se postavlja invisible
        );
end

