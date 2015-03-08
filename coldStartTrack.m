function latentFeatures_track = coldStartTrack(WordProf, AUidx, UAidx)
%INPUT
% WordProf: word profile of all users and artist
% AUidx{i}:   indices of users who have rated artist {i}
% UAidx{i}:   indices of artists who have been rated by user {i}

%OUTPUT
%latentFeatures_track: latent features of the track to be predicted

    
%in word profile, find users(and the features) who have rated this artist
    users_rated_sameArtist = WordProf(AUidx,:);
    if (~isempty(users_rated_sameArtist))
        %words used to describe the artist
        words_for_artist = user_rated_sameArtist(:,13:94);
        
        %find other artists(who have been rated) similar to this artist
        %loop through Auidx
            for i = 1:length(Auidx)
                %other track by the artist(i) thats been already rated
                artist_rated_tracks = Auidx{i};
                
                if (~ isempty(artist_rated_tracks))
                    
                    %find words used to describe these already rated artist
                    neighbor_artist(i,:) = ;
                else
                    %no tracks by the artist have been rated before
                end
            end
           

            %find a rated artist thats most similar as described by users
            idx = max(neighbor_artist * words_for_artist');
            
            %find the average latent features for the tracks of that artist
            %return latentFeatures_track; 
            
    else
        fprintf('No user has filled out information about this artist yet/n');    
    end
    
end
