function error = MFcross_validation(Xtrain,data_users,N)

% INPUTS
% Xtrain       training data of user ratings
% data_users   data of user profiles
% N            number of cross validation folds

% OUTPUT     
% error     RMS error

M = MFratings(Xtrain);
U = MFusers(M,data_users);

[m,n] = size(Xtrain);

% creating a vector of indices of X
idxperm = 1:m;
% initializing err_sum
err_sum = 0;


% looping through folds
for j = 0:N-1
    
    tic;
    % creating fold from permuted data set    
    test = idxperm([floor(m / N * j + 1) : floor(m / N * (j + 1))]);
    
  
    % creating the set of indices used for validation
    train = setdiff(idxperm,test); 
    
    
    
    Xtest = Xtrain(test,:);
    Xt = Xtrain(train,:);
    
    T = MFtrain(M,U);
    
    size(T)
    pred_y = MFpredict(T,Xtest,U);
    
    correct_y = Xtrain(test,4);
    
    err_sum = err_sum + rmse(pred_y,correct_y);
    
    toc;
end

error = err_sum/N;
end