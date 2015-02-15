function error = cross_validation(X,N)

[m,n] = size(X);
idxperm = 1:m;
err_sum = 0;

for j = 0:N-1
    
   
    % creating fold from permuted data set    
    test = idxperm([floor(m / N * j + 1) : floor(m / N * (j + 1))]);
    
  
    % creating the set of indices used for validation
    train = setdiff(idxperm,test); 
    
    
    
    fprintf('getting features \n');
    tic;
    B = b_features(X(train,:),X(test,:));
    toc;
    
    
    
    fprintf('training \n');
    tic;
    theta = training(B,X(test,:));
    toc;
    
   
    
    fprintf('prediction \n');
    tic;
    pred_Y = prediction(B,theta);
    toc;
    
    pred_Y
    
    correct_Y = X(test,4);
    
    correct_Y
    
    err_sum
    
    rmse(pred_Y,correct_Y)
    
    err_sum = err_sum + rmse(pred_Y, correct_Y);
    
    
    
    err_sum
    
    
end

error = err_sum/N;


end
