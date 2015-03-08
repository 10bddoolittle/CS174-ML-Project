function newUserIdx = findLatentUser(newUserIdx,Tidx,userProfile,mode)
%INPUT
% newUser    index of the new user
% Tidx{i}    cell contains the indices of users who have rated track {i}
% U[m x n]   user latent feature or profile
% mode       string, mean, median or some other statistical parameter
% state      binary value, on = 

%OUTPUT
%userLatentProfile: estimated latent profile for the new user based on the
%profile of the nearest neighbor who has rated the same track. 
    
    if strcmp(mode,'mean')    
    userLatentProfile = 0;
        for i = 1:length(Tidx)
            %find the crossproduct of user
            
            userLatentProfile = userLatentProfile + U(i,:); 
        end
            userLatentProfile = userLatentProfile./(length(userLatentProfile);
            %update label of the new user
            U(newUserIdx) = userLatentProfile;
    end
    elseif strcmp(mode,'NearestNeighbor')
        %profile of new user
        newUser = userProfile(newUserIdx);
        %users who have rated the same track
        neighbors = userProfile(Tidx);
        [neighborsRow,neighborsCol] = size(neighbors);
        
        %elements in neighbors that is -1
        invalidElements = find(neighbors == -1);
        neighbors(invalidElements) = 0;
        %dot product between the user and neighbors 
        neighborDistance = neighbors*newUser';
        [~,idx] = min(neighborDistance);
        %index of the user's selected latent feature
        latentUserIdx = Tidx{idx}; 
        %update the label of the new user in U
        U(newUserIdx) = U(latentUserIdx);
    end    
end
