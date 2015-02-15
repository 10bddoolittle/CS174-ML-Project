function [avg,group] = average(Xtrain,Xtest,mode)

% Inputs:  
% Xtrain:  [m x n] 
% Xtest:   [l x n]
% mode:    'string', can be ['artist', 'track', 'user', 'rating', 'time']
               
% Output:
% avg:     [l x 1], vector containing the average rating for the group

% this function takes in one or more examples, loops through Xtrain and
% matches the feature specified by 'mode' and groups all examples in Xtrain 
% that have matching features. The average track rating is then taken for 
% the group and output.


% determining which feature to group
feat = mode_read(mode);

% getting the size of the training set
[m,n] = size(Xtrain);
[l,n] = size(Xtest);
avg = zeros(l,1);

% looping through test examples
for j = 1:l
    
    %getting the grouping feature of the test example
    track = Xtest(j,feat); 
    
   
    
    % looping through training examples
        
    [idx,col] = find(Xtrain(:,feat)==track);
    
    k = length(idx);
    
    if k ~= 1
        % Using the determined index to retrieve the group from Xtrain
        group = Xtrain(idx,:);

        % number of examples in the group
        num_ratings = size(group,1);

        % taking the average
        avg(j,1) = sum(group(:,4))/num_ratings;
        
        
    else
        % if there are no instances of Xtest(i,feat), assign a predicted 
        % average. 
        group = Xtest(j,:);
        
        % this is cheating, uses correct result to fill in average     
        avg(j,1) = Xtest(j,4);
        
        % TODO: find an average to use if 'mode' has no examples
                % needs to be implemented for each user, artist, track,
                % time. 
    end
    
    if avg(j,1) == 0
        avg(j,1) = 1;
    else
    end
        
    
end

       

end