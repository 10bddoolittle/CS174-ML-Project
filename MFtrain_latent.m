function [T,U] = MFtrain_latent(M,lambda,gamma,latent)
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

%initialize theta randomly

%assign the initialized theta

U = ones(nUsers,latent);

T = zeros(latent,nTracks);



%thetaInit = rand(nFeatures,1);
thetaInit = ones(latent,1);

Ttrainidx = [];
Utrainidx = [];

% taking care of missing data (-1's)
for iterUser = 1:nUsers

    Mrow = M(iterUser,:);
    
    markidx = find(Mrow == -1);
    
    % indices of rows of M that are rated
    MUidx{iterUser} = setdiff([1:nTracks],markidx);
    
    if ~isempty(MUidx{iterUser})
        UTrainidx = cat(2,Utrainidx,iterUser);
    else
    end
        
        
    
end

for iterTrack = 1:nTracks
    Mcol = M(:,iterTrack);
    
    markidx = find(Mcol == -1);
    
    % indices of cols of M that are rated
    MTidx{iterTrack} = setdiff([1:nUsers],markidx);
    
    if ~isempty(MTidx{iterTrack})
        Ttrainidx = cat(2,Ttrainidx,iterTrack);
    else
    end
end

iter = 0;

%gradient descent implementation
while (iter < 10)
tic;
% looping through the rated tracks
for iterTrack = Ttrainidx
    T(:,iterTrack) = thetaInit;
    
    
    % Looping through the users who rated the track
    for iterUser = MTidx{iterTrack}
        actualRating = M(iterUser,iterTrack);
        %for each track a user has rated, 
        
        userProfile = U(iterUser,:);


        
        % learning weights for track
        predictedRating = userProfile*T(:,iterTrack);
        diff = actualRating - predictedRating;
        
        %update T
        T(:,iterTrack) = T(:,iterTrack)...
                            + gamma*(diff*userProfile' - lambda*T(:,iterTrack));
                        
        % learning latent features for users
        predictedRating = userProfile*T(:,iterTrack);
        diff = actualRating - predictedRating;
        
        U(iterUser,:) = userProfile+gamma*(diff*T(:,iterTrack)' - lambda*userProfile);
        idx = 0;
        
    end
    
end
iter =  iter + 1;   
toc;
end
toc;
end