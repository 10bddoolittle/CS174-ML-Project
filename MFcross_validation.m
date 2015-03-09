function [error,lambda,gamma] = MFcross_validation(Xtrain,N,lambda,gamma)

% INPUTS
% Xtrain       training data of user ratings
% data_users   data of user profiles
% N            number of cross validation folds

% OUTPUT     
% error     RMS error

data_train = load('data_train.mat');
data_users = load('data_users.mat');
data_words = load('data_words.mat');


Xtrain = data_train.train;
user_profile = data_users.data_users;
words_profile = data_words.data_words;


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
        for j = 1

            tic;
            iteration
            itmax
            % creating fold from permuted data set    
            Xtest = idxperm([floor(m / N * j + 1) : floor(m / N * (j + 1))]);


            % creating the set of indices used for validation
            Xt = setdiff(idxperm,Xtest); 

            

            test = Xtrain(Xtest,:);
            train = Xtrain(Xt,:);
            
           
            [M,Uidx,Tidx,Aidx,A] = MFratings(train,maxArtist,maxTrack,maxUser);
            
            
            UserProf = MFusers(M,user_profile);
            
            [WordProf,AUidx,UAidx] = MFartists(M,A,words_profile);
            
            
            save('WordProf','WordProf')
            save('UserProf','UserProf')
            save('M','M')
            save('A','A')
            save('Aidx','Aidx')
            save('Tidx','Tidx')
            save('Uidx','Uidx')
            save('AUidx','AUidx')
            save('UAidx','UAidx')
            save('test','test')
            save('train','train')

            fprintf('saved files')

%             [T,U,Uidx] = MFtrain(M,U,lambda(i),gamma(k));
%             %[T,U] = MFtrain_latent(M,lambda(i),gamma(i),latent);
% 
%             size(T)
%            
%             pred_y = MFpredict(T,Xtest,U,Uidx);
%             %pred_y = MFpredict_latent(T,Xtest,U);
% 
%             correct_y = Xtrain(test,4);
% 
%             err_sum = err_sum + rmse(pred_y,correct_y);

            toc;
        end
        iteration = iteration +1;
        error(i,k) = err_sum/N;
    end
end




end