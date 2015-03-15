function [latentFeatures_User,latentFeatures_Track,count] ...
        = find_usertrack_latent(newUserIdx,aidx,newTrackIdx,U,T,Aidx,AUidx, Tidx,UserProf,WordProf,ArtistProf,Utrainidx,Ttrainidx,count)

    %old calls for reference
% find_usertrack_latent(newUserIdx,aidx,newTrackIdx, U,T,Tidx,Aidx,Aidx_cell,AUidx,AUidx_cell, userProfile,wordProfile,artistProfile,mode,count)
% passed before: (uidx,aidx,tidx,U,T,Tidx{tidx},Aidx{aidx},Aidx,AUidx{aidx},AUidx,UserProf,WordProf,ArtistProf,'option2',count);          


            
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
    
    Aidx_cell = Aidx;
    Aidx = Aidx{aidx};
    Tidx = Tidx{newTrackIdx};
    AUidx_cell = AUidx;
    
    %other tracks of the same artist
    artist_tracks_idx = Aidx;
    
    artistIdx = aidx;
    userIdx = newUserIdx;
    
    %unknown user, known artist
    if(~isempty(artist_tracks_idx))
            %average latent feature of these tracks
            latentFeatures_Track = find_track_latent(aidx, T, 'average',ArtistProf,Aidx_cell);
            latentFeatures_User = find_user_latent(newUserIdx,Tidx,U,UserProf,'correlatedUser',Utrainidx);
            fprintf('unknown user,known artist : %d \n',count);
            
    %unknown user, unknown artist(no other tracks by the artist)
    else
        %new user, new artist
        fprintf ('unknown user,unknown artist : %d \n',count);
        [latentFeatures_User,latentFeatures_Track] = ...
            find_usertrackartist_latent(artistIdx,userIdx,UserProf,ArtistProf,AUidx_cell,Aidx_cell,U,T,Utrainidx,Ttrainidx);
        
    end
    count = count + 1;

end






