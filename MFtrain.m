function [T,U,Utrainidx,Ttrainidx,rmse1,rmse2] = MFtrain(M,UserProf,Uidx,Tidx,lambda1,lambda2,gamma,niter)
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
         
    if ~isempty(Uidx{iterUser})
        Utrainidx = cat(2,Utrainidx,iterUser);
    else
    end
       
end

for iterTrack = 1:nTracks
    
    if ~isempty(Tidx{iterTrack})
        Ttrainidx = cat(2,Ttrainidx,iterTrack);
    else
    end
end

iter = 0;
rmse1 = zeros(1,niter);
rmse2 = zeros(1,niter);


%gradient descent implementation
while (iter < niter)
lit_it = 1;
tic;
% looping through the rated tracks
%for j = 1:nFeatures
    for iterTrack = Ttrainidx
        if iter == 0
            % initializing T
            T(:,iterTrack) = thetaInit;
        end

        % Looping through the users who rated the track
        for iterUser = Tidx{iterTrack}
        
            actualRating = M(iterUser,iterTrack); 
            %for each track a user has rated, 
            correct(lit_it) = actualRating;
            
            
            if iter == 0
                % initializing U with UserProfile
                userProfile = UserProf(iterUser,:);
                %userProfile = Uinit;
            else 
                userProfile = U(iterUser,:);
            end


            % making a prediction
            predictedRating = userProfile*T(:,iterTrack);
            
            pred1(lit_it) = max(0,min(predictedRating,100));
           
            
            diff = actualRating - predictedRating;
           
            
            %updating T
            T(:,iterTrack) = T(:,iterTrack)...
                                + gamma*(diff*userProfile' - lambda1*T(:,iterTrack));
                            
           

            % learning latent features for users
            predictedRating = userProfile*T(:,iterTrack);
            
            pred2(lit_it) = max(0,min(predictedRating,100));
            
           
            diff = actualRating - predictedRating;
            
            % updating U
            U(iterUser,:) = userProfile+gamma*(diff*T(:,iterTrack)' - lambda2*userProfile);
            
            lit_it = lit_it + 1;
        end
        
    end



%end
iter =  iter + 1;  
rmse1(iter) = rmse(pred1',correct');
rmse2(iter) = rmse(pred2',correct');
pred1 = 0;
pred2 = 0;
toc;
end
toc;

clf
figure(1)
plot([1:niter],rmse1,'bo')
hold on
plot([1:niter],rmse2,'rx')
hold off
end