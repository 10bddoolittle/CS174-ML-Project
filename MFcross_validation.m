function [error,lambda,gamma,pred_y,correct_y] = MFcross_validation(Xtrain,data_users,N,lambda,gamma)

% INPUTS
% Xtrain       training data of user ratings
% data_users   data of user profiles
% N            number of cross validation folds

% OUTPUT     
% error     RMS error


l = length(lambda);
g = length(gamma);

itmax = l*g

[m,n] = size(Xtrain);

maxArtist = max(Xtrain(:,1));
maxTrack = max(Xtrain(:,2));
maxUser = max(Xtrain(:,3));

% creating a vector of indices of X
idxperm = 1:m;
% initializing err_sum
err_sum = 0;
% initializing error output
error = zeros(l,g);
iteration = 1;
for i = 1:l
    for k = 1:g
        % looping through folds
        for j = 0:N-1

            tic;
            iteration
            itmax
            % creating fold from permuted data set    
            test = idxperm([floor(m / N * j + 1) : floor(m / N * (j + 1))]);


            % creating the set of indices used for validation
            train = setdiff(idxperm,test); 

            

            Xtest = Xtrain(test,:);
            Xt = Xtrain(train,:);
            
           
            
            M = MFratings(Xtrain, maxArtist,maxTrack,maxUser);
            U = MFusers(M,data_users.data_users);

            [T,U,Uidx] = MFtrain(M,U,lambda(i),gamma(k));
            %[T,U] = MFtrain_latent(M,lambda(i),gamma(i),latent);

            size(T)
           
            pred_y = MFpredict(T,Xtest,U,Uidx);
            %pred_y = MFpredict_latent(T,Xtest,U);

            correct_y = Xtrain(test,4);

            err_sum = err_sum + rmse(pred_y,correct_y);

            toc;
        end
        iteration = iteration +1;
        error(i,k) = err_sum/N;
    end
end




end