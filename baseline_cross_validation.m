function [err_artist,err_track,err_user,err_time ] = baseline_cross_validation(X, N)

[m,n] = size(X);
err_sum_a = 0;
err_sum_t = 0;
err_sum_u = 0;
err_sum_ti = 0;
idxperm = 1:m;

for j = 0:N-1
    
    j
    
    
    
    % creating fold from permuted data set    
    test = idxperm([floor(m / N * j + 1) : floor(m / N * (j + 1))]);

    % creating the set of indices used for validation
    train = setdiff(idxperm,test); 
    
    fprintf('prediction w/ track \n');
    tic;
    pred_Y_track = average(X(train,:),X(test,:),'track');
    toc;
    
    fprintf('prediction w/ artist \n');
    tic;
    pred_Y_artist = average(X(train,:),X(test,:),'artist');
    toc;
    
    fprintf('prediction w/ user \n');
    tic;
    pred_Y_user = average(X(train,:),X(test,:),'user');
    toc;
    
    fprintf('prediction w/ time \n');
    tic;
    pred_Y_time = average(X(train,:),X(test,:),'time');
    toc;
    
    
    correct_Y = X(test,4);
    
    err_sum_a = err_sum_a + rmse(pred_Y_artist, correct_Y);
    err_sum_t = err_sum_t + rmse(pred_Y_track, correct_Y);
    err_sum_u = err_sum_u + rmse(pred_Y_user, correct_Y);
    err_sum_ti = err_sum_ti + rmse(pred_Y_time, correct_Y);
    
    
   
    
    
end

err_artist = err_sum_a/N;
err_track = err_sum_t/N;
err_user = err_sum_u/N;
err_time = err_sum_ti/N;

end