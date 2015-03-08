function [T,U,Uidx] = MFtrain(M,UserProf,lambda,gamma)
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
[~,nFeatures] = size(UserProf);
%initialize theta randomly

%assign the initialized theta



T = zeros(nFeatures ,nTracks);
U = zeros(nUsers, nFeatures);



%thetaInit = rand(nFeatures,1);
thetaInit = ones(nFeatures,1);

Ttrainidx = [];
Utrainidx = [];

% taking care of missing data (-1's)
for iterUser = 1:nUsers
    userProfile = UserProf(iterUser,:);
    
    % finding -1's
    markidx = find(userProfile == -1);
    
    % store indexes of -1's in cell Uidx
    Uidx{iterUser} =  setdiff([1:nFeatures],markidx);
    
    
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
while (iter < 5)
tic;
% looping through the rated tracks
for iterTrack = Ttrainidx
    T(:,iterTrack) = thetaInit;
    
    
    % Looping through the users who rated the track
    for iterUser = MTidx{iterTrack}
        actualRating = M(iterUser,iterTrack);
        %for each track a user has rated, 
        
        userProfile = UserProf(iterUser,:);

        idx = Uidx{iterUser};
        % finding constant to rescale prediction by to account for
        % missing features
        renorm = sqrt(T(:,iterTrack)'*T(:,iterTrack))/sqrt(T(idx,iterTrack)'*T(idx,iterTrack));
        
        % learning weights for track
        predictedRating = userProfile(idx)*T(idx,iterTrack)*renorm;
        diff = actualRating - predictedRating;
        %update T
        T(idx,iterTrack) = T(idx,iterTrack)...
                            + gamma*(diff*userProfile(idx)' - lambda*T(idx,iterTrack));
                        
        % learning latent features for users
        predictedRating = userProfile(idx)*T(idx,iterTrack)*renorm;
        diff = actualRating - predictedRating;
        
        U(iterUser,idx) = userProfile(idx)+gamma*(diff*T(idx,iterTrack)' - lambda*userProfile(idx));
        idx = 0;
        
    end
    
end
iter =  iter + 1;   
toc;
end
toc;
end