function userLatentProfile = find_user_latent(newUserIdx,Tidx,U,UserProfile,mode)
%INPUT
% newUserIdx  :    index of the new user
% Tidx{i}     :    cell contains the indices of users who have rated track {i}
% userProfile :    matrix containing the profiles of all the users
% mode        :    string, 'Mean' or 'NearestNeighbor' 


%OUTPUT
%latentUserIdx : (latent) index of the user who is estimated as the best
%representation for the new user. 
    if strcmp(mode,'Mean')    
%        userLatentProfile = 0;
%         for i = 1:length(Tidx)
%             %find the crossproduct of user
%             userLatentProfile = userLatentProfile + U(Tidx(i),:); 
%         end
%             userLatentProfile = userLatentProfile./(length(userLatentProfile));
            
        userLatentProfile = sum(U(Tidx,:))/length(Tidx);

    elseif strcmp(mode,'NearestNeighbor')
        %profile of new user
        newUser = UserProfile(newUserIdx);
        %users who have rated the same track
        neighbors = UserProfile(Tidx,:);
       
        %dot product between the user and neighbors 
        neighborDistance = neighbors*newUser';
        [~,idx] = min(neighborDistance);
        %index of the user's selected latent feature
        latentUserIdx = Tidx{idx};
        %pass the output parameter
        userLatentProfile = U(latentUserIdx);
    end     
end     
