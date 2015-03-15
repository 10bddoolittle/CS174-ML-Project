function [latentFeatures_user,latentFeatures_track] = ...
        find_usertrackartist_latent(artistIdx,userIdx,UserProf,ArtistProf,AUidx,Aidx,U,T,Utrainidx,Ttrainidx)
%INPUT
% artistIdx  : index of the artist whose song is to be rated
% userIdx    : index of the user who is rating the song
% UserProf   : matrix containing user demographic and preference
% ArtistProf : [nArtist x nArtistFeature] matrix containing user's description of artist 
% AUidx      : AUidx{i} contains index of users who have rated artist i
% Aidx       : Aidx{i} contains the indices of tracks composed by artist {i}
% U          : [nUsers x nFeatures] Users latent feature matrix
% T          : [nFeatures x nTracks] Track latent feature matrix
% Utrainidx  :
% Ttrainidx  :
%
%
%OUTPUT
% latentFeatures_user  : latent features of the user who is rating
% latentFeatures_track : latent features of the track to be predicted
    
    %find the latent feature of the track
        %artists profile
        artist_profile = ArtistProf(artistIdx,:);
        artist_profile = artist_profile/norm(artist_profile);
        
        %find index of artists that have been rated by users
        rowCounter = 1;
        for i = 1:length(Aidx)
            if (~ isempty(Aidx{i}))
                artist_neighbor_idx(rowCounter,1) = i;
                rowCounter = rowCounter + 1;
            end
        end
        
        %NEED TO DO
        %normalize the rows of artist_neighbor  
        artist_neighbor = ArtistProf(artist_neighbor_idx,:);
        %a column, each element is the magnitude of corresponding row in
        %artist_neighbor
        normFactor = sqrt(sum(artist_neighbor.^2,2));
        %magnitude matrix of the same size as artist_neighbor
        normFactor = repmat(normFactor,[1,size(artist_neighbor,2)]);
        
        %check if there are any zero vectors
        zeroVectorIdx = find(sum(normFactor,2)== 0);
        if isempty(zeroVectorIdx)
            %normalize artist_neighbor
            artist_neighbor = artist_neighbor./normFactor;
        else
            fprintf('one or more neighbors of artist %d is empty /n',artistIdx);
        end
        [~,similarArtistIdx] = max(artist_neighbor*artist_profile');
        latentArtistIdx = artist_neighbor_idx(similarArtistIdx);
        
        %songs composed by the latentArtistIdx
        trackIdx = Aidx{latentArtistIdx};
        if ~ isempty(trackIdx)
            %average of the latent features of the tracks by the artist
            latentFeatures_track = mean(T(:,trackIdx),2);
        else
            latentFeatures_track = (1/91)*ones(91,1);
            fprintf('estimated artist %d doesnt have any tracks /n ',latentArtistIdx);
        end
        
    %find the latent feature of the user
        %user profile
        user_profile = UserProf(userIdx,:);
        user_profile = user_profile/norm(user_profile);
        
        %neighbors of the unknown user
        user_neighbor = UserProf(Utrainidx,:);
        
        %normalize the neighbor vectors
        normFactor = sqrt(sum(user_neighbor.^2,2));
        %magnitude matrix of the same size as user_neighbor
        normFactor = repmat(normFactor,[1,size(user_neighbor,2)]);
        
        %check if there are any zero vectors
        zeroVectorIdx = find(sum(normFactor,2)== 0);
        if isempty(zeroVectorIdx)
            %normalize artist_neighbor
            user_neighbor = user_neighbor./normFactor;
        else
            fprintf('user neighbor is empty /n');
        end
        
        [~,correlatedUser] = max(user_neighbor*user_profile');
        latentUserIdx = Utrainidx(correlatedUser);
        latentFeatures_user = U(latentUserIdx,:);
    
end
