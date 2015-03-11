function [T,U] = MFtrain(M,UserProf,lambda1,lambda2,gamma,niter)
% uses matrix factorization to learn weights for users and tracks

% Input
%M  : [m x n] m users, n tracks
%U  : [m x k] m users, k features

% Output
%T :[k x n]

tic;


[nUsers,nTracks] = size(M); 
[~,nFeatures] = size(UserProf);




%nFeatures = 5;
%idx = [74:91];
%nFeatures = length(idx);

T = zeros(nFeatures ,nTracks);
U = zeros(nUsers, nFeatures);


% initial conditions for U and T
%thetaInit = rand(nFeatures,1);
thetaInit = ones(nFeatures,1);
Uinit = ones(1,nFeatures);

Ttrainidx = [];
Utrainidx = [];


for iterUser = 1:nUsers
     
    % already have this information, get from MFratings
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
    
    %Already have this information, get it from MFratings
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
while (iter < niter)
tic;
% looping through the rated tracks
%for j = 1:nFeatures
    for iterTrack = Ttrainidx
        
        % initializing T
        T(:,iterTrack) = thetaInit;

        % Looping through the users who rated the track
        for iterUser = MTidx{iterTrack}
        
            actualRating = M(iterUser,iterTrack);
            %for each track a user has rated, 
            
            % initializing U with UserProfile
            userProfile = UserProf(iterUser,:);
            %userProfile = Uinit;


            % making a prediction
            predictedRating = userProfile*T(:,iterTrack);
            
            diff = actualRating - predictedRating;
            
            %updating T
            T(:,iterTrack) = T(:,iterTrack)...
                                + gamma*(diff*userProfile' - lambda1*T(:,iterTrack));

            % learning latent features for users
            predictedRating = userProfile*T(:,iterTrack);
            diff = actualRating - predictedRating;
            
            % updating U
            U(iterUser,:) = userProfile+gamma*(diff*T(:,iterTrack)' - lambda2*userProfile);
        end
        
    end
    
%end
iter =  iter + 1;   
toc;
end
toc;
end