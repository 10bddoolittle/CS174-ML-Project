function [latentFeatures_User,latentFeatures_Track,count] = find_usertrack_latent(newUserIdx,newTrackIdx, U,T,Tidx,Aidx,AUidx,userProfile,wordProfile,mode,count)
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
    artist_tracks_idx = Aidx;
    artist_tracks = T(:,artist_tracks_idx);
    
    %other users who have rated the same track
    user_tracks_idx = Tidx;
    user_tracks = U(user_tracks_idx,:);
    
    [artistTracksRow, artistTracksCol] = size(artist_tracks_idx);
    [userTrackRow, userTrackCol] = size(user_tracks_idx);
    
    if(~isempty(artist_tracks_idx))
        if strcmp(mode,'Mean')
            
            %average latent feature of these tracks
            latentFeatures_Track = mean(artist_tracks,2);
            if isempty(user_track_idx)
                %vector containing users who have rated the same artist
                neighbors_idx = AUidx; 
                
                U(neighbors_idx
                    
                
            %averge of users who have rated other tracks by same artist     
            latentFeatures_User = mean(user_tracks);

        elseif strcmp(mode, 'option2')
            %latent features from the most recently rated track
            latentFeatures_Track = find_track_latent(Aidx, T, mode);
            
            %vector containing users who have rated the same artist
            neighbors_idx = AUidx; 
            
            user_wordProfile = wordProfile(newUserIdx,:);
            
            neighbors = wordProfile(neighbor_idx,:);
            correlated_neighbors = neighbors*user_wordProfile';
            
            latent_user_idx = neighbor_idx(max(correlated_neighbors));
            latentFeatures_User = U(latent_user_idx,:);
        end
    else
        count = count + 1;
        [m,n] = size(U(1,:));
        latentFeatures_User = zeros(1,n);
        latentFeatures_Track = zeros(n,1);
        latentFeatures_User(1,1) = 30;
        latentFeatures_Track(1,1) = 1;
        
    end





