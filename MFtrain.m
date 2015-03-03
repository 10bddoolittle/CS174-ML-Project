function [T,Uidx] = MFtrain(M,U,lambda,gamma)
% learns weights for each track

% Input
%M  : [m x n] m users, n tracks
%U  : [m x k] m users, k features

% Output
%theta :[1 x k]
tic;
%lambda = 0.001;
%gamma = 0.001;

[nUsers,nTracks] = size(M); 
[~,nFeatures] = size(U);
%initialize theta randomly
%thetaInit = rand(nFeatures,1);
thetaInit = ones(nFeatures,1);
%assign the initialized theta
T = zeros(nFeatures,nTracks);

% taking care of missing data (-1's)
for iterUser = 1:nUsers
    userProfile = U(iterUser,:);
    
    % finding -1's
    markidx = find(userProfile == -1);
    
    % store indexes of -1's in cell Uidx
    Uidx{iterUser} =  setdiff([1:nFeatures],markidx);
    
    
end



iter = 0;

%gradient descent implementation
for iterTrack = 1:nTracks
    T(:,iterTrack) = thetaInit;
    while (iter < 1000)
    for iterUser = 1:nUsers
        actualRating = M(iterUser,iterTrack);
        %for each track a user has rated, 
        if (actualRating > 0)
            userProfile = U(iterUser,:);
    
            idx = Uidx{iterUser};
            % finding constant to rescale prediction by to account for
            % missing features
            renorm = sqrt(T(:,iterTrack)'*T(:,iterTrack))/sqrt(T(idx,iterTrack)'*T(idx,iterTrack));
            
            predictedRating = userProfile(idx)*T(idx,iterTrack)*renorm;
            diff = actualRating - predictedRating;
            %update theta
            T(idx,iterTrack) = T(idx,iterTrack)...
                                + gamma*(diff*userProfile(idx)' - lambda*T(idx,iterTrack));
            idx = 0;
        end
    end
    iter =  iter + 1; 
    end
    
end
toc;
end