function latentUserIdx = findLatentUser(newUserIdx,Tidx,userProfile,mode)
%INPUT
% newUserIdx  :    index of the new user
% Tidx{i}     :    cell contains the indices of users who have rated track {i}
% userProfile :    matrix containing the profiles of all the users
% mode        :    string, 'Mean' or 'NearestNeighbor' 


%OUTPUT
%latentUserIdx : (latent) index of the user who is estimated as the best
%representation for the new user. 
    if strcmp(mode,'Mean')    
    userLatentProfile = 0;
        for i = 1:length(Tidx)
            %find the crossproduct of user
            
            userLatentProfile = userLatentProfile + U(i,:); 
        end
            userLatentProfile = userLatentProfile./(length(userLatentProfile);
            %update label of the new user
            U(newUserIdx) = userLatentProfile;
    elseif strcmp(mode,'NearestNeighbor')
        %profile of new user
        newUser = userProfile(newUserIdx);
        %users who have rated the same track
        neighbors = userProfile(Tidx);
        
        %elements in neighbors that is -1
        invalidElements = find(neighbors == -1);
        neighbors(invalidElements) = 0;
        %dot product between the user and neighbors 
        neighborDistance = neighbors*newUser';
        [~,idx] = min(neighborDistance);
        %index of the user's selected latent feature
        latentUserIdx = Tidx{idx}; 
    end    
end
