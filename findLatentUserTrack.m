function [latentFeatures_User,latentFeatures_Track] = find_usertrack_latent(newUserIdx,newTrackIdx, U,T,Tidx,Aidx,userProfile,words,mode)
%INPUT
% newUserIdx  :    index of the new user
% newTrackIdx :    index of the new track
% U           :    matrix containing the latent user feature
% T           :    matrix containing the latent track feature
% Uidx{i}     :    cell contains the track indices rated by user {i} 
% Tidx{i}     :    cell contains the indices of users who have rated track {i}
% Aidx{i}     :    cell contains the indices of tracks composed by artist {i}
% userProfile :    matrix containing the profiles of all the users
% words       :    matrix corresponding to words.csv
% mode        :    string, 'Mean' or 'NearestNeighbor' 

%OUTPUT
% latentFeatures_User: the estimated latent features of the new user
% latentFeatures_Track: estimated latent track for the new user 

    %other tracks of the same artist
    artist_tracks_idx = cell2mat(Aidx);
    artist_tracks = T(:,artist_tracks_idx);
    
    %other users who have rated the same track
    user_tracks_idx = cell2mat(Tidx);
    user_tracks = U(user_tracks_idx,:);
    
    [artistTracksRow, artistTracksCol] = size(artist_tracks_idx);
    [userTrackRow, userTrackCol] = size(user_tracks_idx);
    
    if(~isEmpty(artist_tracks_idx))
        if strcmp(mode,'Mean')
            
            %average latent feature of these tracks
            latentFeatures_Track = mean(artist_tracks,2);

            %averge of users who have rated other tracks by same artist 
            latentFeatures_User = mean(user_tracks);

        elseif strcmp(mode,'NearestNeighbor')
            %artist id
                %find a way to pass the artist id
                
            % find users who have rated the artist(in words.csv)
                % similar_users = [];
            
            % find the most similar user among those who have rated the artist
                %dot product of users profile in words
                %chose the minimum of the dot product
                %find the corresponding userID
                %latentFeatures_User = U(userID)
                
            %artistId = 0; %find a way to pass artistID
            %common_user_idx = 1 + find(words(:,2) == artistId);
            
            %find 
        elseif strcmp(mode, 'Recent')
            latentFeatures_Track = find_track_latent(Aidx, T, mode);
            
            %find users who have rated other tracks by the same artist
                
            %find the most similar user to those users
            
            
        end
    else
        fprint('No other tracks by this artist have been rated yet.');
    end





