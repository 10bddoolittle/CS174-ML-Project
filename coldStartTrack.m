function latentFeatures_track = coldStartTrack(WordProf, AUidx,Aidx, T)
%INPUT
% WordProf: word profile of all users and artist
% AUidx   :   indices of users who have rated artist {i}
% UAidx{i}:   indices of artists who have been rated by user {i}
% Aidx{i}    cell contains the indices of tracks composed by artist {i}
% Uidx{i}    cell contains the track indices rated by user {i} 
% Tidx{i}    cell contains the indices of users who have rated track {i}

%OUTPUT
%latentFeatures_track: latent features of the track to be predicted

    %in word profile, find profile for artists that have been rated
    users_rated_sameArtist = WordProf(AUidx,:);
    
    if (~isempty(users_rated_sameArtist))
        %words used to describe the artist
        artist_profile = sum(user_rated_sameArtist(:,13:94));
        
        %find other artists(that have already been rated)
            for i = 1:length(Aidx)
                %if there is a track by artist(i) that has been rated
                if (~ isempty(Aidx{i}))
                     %find users who have rated this artist
                     users_rated_artistI = AUidx{i};
                     
                     %description of this artist by users who have rated 
                     temp_artists_profile = WordProf(users_rated_artistI,i,13:94);
                     %best_wordFor_tempArtist = 12 + max(sum(temp_artist_profile));
                     
                     artist_neighbor(i,:) = sum(temp_artist_profile);
                else
                    %no tracks by the artist have been rated before
                    %fprintf('No tracks by artist i have been rated');
                end
            end
            
            %find the most similar artist
            similar_Artist_Idx = max(artist_neighbor * artist_profile');
            
            %find the average latent feature of the a track by the artist
            tracks_by_artist = Aidx{similar_Artist_Idx};
            latentFeatures_track = mean(T(:,tracks_by_artist),2); 
            
    else
        fprintf('No user has filled out information about this artist yet/n');    
    end
    
end
