function theta = MFtrain(M,U)
% learns weights for each track

% Input
%M  : [m x n] m users, n tracks
%U  : [m x k] m users, k features

% Output
%theta :[1 x k]
tic;
lambda = 0.001;
gamma = -0.001;

[nUsers,nTracks] = size(M); 
[~,nFeatures] = size(U);
%initialize theta randomly
thetaInit = rand(nFeatures,1);
%assign the initialized theta
theta = zeros(nFeatures,nTracks);

iter = 0;

%gradient descent implementation
for iterTrack = 1:nTracks
    theta(:,iterTrack) = thetaInit;
    while (iter < 5)
    for iterUser = 1:nUsers
        actualRating = M(iterUser,iterTrack);
        %for each track a user has rated, 
        if (actualRating > 0)
            userProfile = U(iterUser,:);
            predictedRating = userProfile*theta(:,iterTrack);
            diff = actualRating - predictedRating;
            %update theta
            theta(:,iterTrack) = theta(:,iterTrack)...
                                + gamma*(diff*userProfile' - lambda*theta(:,iterTrack));      
        end
    end
    iter =  iter + 1; 
    end
    
end
toc;
end