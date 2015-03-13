function [error,pred_y,correct_y] = coldStart_CrossVal(Case,lambda1,lambda2,gamma,niter,N)
% Performs a cross validation on a set containing specified cold start case

% INPUTS
% Case:       str describing cold Case, 'newArtist', 'newTrack', 'newUser'



% OUTPUTS


% loading data
fprintf('Loading Data...');
tic;
data_train = load('data_train.mat');
data_users = load('data_users.mat');
data_words = load('data_words.mat');


% getting initial sets
Xtrain = data_train.train;
user_profile = data_users.data_users;
words_profile = data_words.data_words;
toc;

[m,n] = size(Xtrain);

maxArtist = max(Xtrain(:,1));
maxTrack = max(Xtrain(:,2));
maxUser = max(Xtrain(:,3));

fprintf('Sorting Data...');
tic;
if strcmp('newArtist',Case)
    itA = ones(1,maxArtist + 1);
    Atrain = cell(1,maxArtist + 1);

    for i = 1:m
        At = Xtrain(i,1) + 1;
        Atrain{At}(itA(At)) = i;
        itA(At) = itA(At) + 1;   
    end

    [~,len] = size(Atrain);
    
elseif strcmp('newTrack',Case)
    itT = ones(1,maxTrack+1);
    Atrain = cell(1,maxTrack + 1);
    
    for i = 1:m
       Tt = Xtrain(i,2) + 1;
       Atrain{Tt}(itT(Tt)) = i;
       itT(Tt) = itT(Tt) + 1;
    end
    
    [~,len] = size(Atrain);

elseif strcmp('newUser',Case)
    itU = ones(1,maxUser+1);
    Atrain = cell(1,maxUser + 1);
    
    for i = 1:m
        Ut = Xtrain(i,3) + 1;
        Atrain{Ut}(itU(Ut)) = i;
        itU(Ut) = itU(Ut) + 1;
    end
    
    [~,len] = size(Atrain);
    
else 
    fprintf('Not a vaild Case');
    
end

toc;

rand('twister', 0);
idxperm = randperm(len);

err_sum = 0;

fprintf('Running Cross Validation Test...');
for j = 0:(N-1)
    
    
    Atest_idx = idxperm([floor(len / N * j + 1) : floor(len / N * (j + 1))]);
    
    % creating the set of indices used for validation
    Atrain_idx = setdiff(idxperm,Atest_idx); 
    
    train_idx = [];
    test_idx = [];
    
    for k = Atrain_idx
       train_idx = cat(2,train_idx,Atrain{k}); 
    end
    
    for k = Atest_idx
       test_idx = cat(2,test_idx,Atrain{k}); 
    end
    
    test = Xtrain(test_idx,:);
    train = Xtrain(train_idx,:);
    
    fprintf('Initialization...');
    tic;
    % initializing M
    [M,Uidx,Tidx,Aidx,A] = MFratings(train,maxArtist,maxTrack,maxUser);

    % Initializing UserProf
    UserProf = MFusers(M,user_profile);
    
    % Initializing WordProf
    [WordProf,AUidx,UAidx] = MFartists(M,A,words_profile);
    toc;
    
    fprintf('Training...');
    tic;
    % Finding latent features of training set
    [T,U,rmse1,rmse2] = MFtrain(M,UserProf,lambda1,lambda2,gamma,niter);
    toc;
    
    fprintf('Testing...');
    tic;
    % making prediction
    [pred_y,coldStart_idx,newUser_idx,newTrack_idx,warmStart_idx] = MFpredict(T,test,U,Tidx,Aidx,AUidx,UserProf,WordProf);
    toc;
    
    % finding error
    correct_y = test(:,4);
    err = rmse(pred_y,correct_y);
    
    err_sum = err_sum + err;
end

error = err_sum/N;




end