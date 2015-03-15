function userLatentProfile = find_user_latent(newUserIdx,Tidx,U,UserProf,mode,Utrainidx)
%INPUT
% newUserIdx  :    index of the new user
% Tidx{i}     :    cell contains the indices of users who have rated track {i}
% userProfile :    matrix containing the profiles of all the users
% mode        :    string, 'Mean' or 'NearestNeighbor' 


%OUTPUT
%latentUserIdx : (latent) index of the user who is estimated as the best
%representation for the new user. 
    
    %average latent features of users who have rated the track
    if strcmp(mode,'Mean')    
        userLatentProfile = sum(U(Tidx,:))/length(Tidx);
    
    %latent features of the most similar user
    elseif strcmp(mode,'correlatedUser')
       %find the latent feature of the user
        %user profile
        user_profile = UserProf(newUserIdx,:);
        if norm(user_profile) ~= 0
            user_profile = user_profile/norm(user_profile);
        else
            fprintf('userprofile for user %d is empty /n',newUserIDx);
        end
        %possible neighbors of the unknown user, i.e users who are in U
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
            fprintf('user neighbor is empty in find_userlatent \n');
        end
        
        [~,correlatedUser] = max(user_neighbor*user_profile');
        latentUserIdx = Utrainidx(correlatedUser);
        userLatentProfile = U(latentUserIdx,:);

    end     
end     
