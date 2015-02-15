function error = cross_validation(X,N)

% Input:
% X:           [m x n], matrix of data set of which to perform cross
%                      validation
% N:           [1 x 1], scalar, number of folds to use

% Output:
% error:        scalar, average rmse error for all fold

% getting number of rows of x
[m,~] = size(X);
% creating a vector of indices of X
idxperm = 1:m;
% initializing err_sum
err_sum = 0;



% looping through folds
for j = 0:N-1
    
   
    % creating fold from permuted data set    
    test = idxperm([floor(m / N * j + 1) : floor(m / N * (j + 1))]);
    
  
    % creating the set of indices used for validation
    train = setdiff(idxperm,test); 
    
    Xtrain = X(train,:);
    Xtest = X(test,:);
    
    % getting feature matrix B
    fprintf('getting features \n');
    tic;
    B = b_features(Xtrain,Xtest);
    toc;
    
    
    % training theta
    fprintf('training \n');
    tic;
    theta = training(B,Xtest);
    toc;
    
   
   
    % making a prediction of rating
    fprintf('prediction \n');
    tic;
    pred_Y = prediction(B,theta);
    toc;
    
   
    
    correct_Y = Xtest(:,4);
    
    
    
    err_sum = err_sum + rmse(pred_Y, correct_Y);
    

    
    
end

error = err_sum/N;


end
