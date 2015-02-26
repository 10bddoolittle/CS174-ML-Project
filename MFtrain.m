function theta = MFtrain(M,U)
% learns weights for each track

% Input
%M  : [m x n] m users, n tracks
%U  : [m x k] m users, k features

% Output
%theta :[1 x k]

lambda = 1;
gamma = -1;

[nUsers,nTracks] = size(M); 
[~,nFeatures] = size(U);
%initialize theta randomly
thetaInit = rand(nFeatures,1);
%assign the initialized theta
theta = thetaInit;


%gradient descent implementation
for iterUser = 1:nUsers
    for iterTrack = 1:nTracks
        
        actualRating = M(iterUser,iterTrack);
        userProfile = U(iterUser,:);
        predictedRating = userProfile*thetaInit;
        
        diff = actualRating - predictedRating;
        theta = theta + gamma*(diff*userProfile' - lambda*theta);
    end
end

end