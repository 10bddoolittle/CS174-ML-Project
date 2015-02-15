function theta = training(B,Xtest)

% Inputs:
% B:          [l x 4], matrix of average features
% Xtest:      [l x 5], matrix of test examples

% Output:
% theta:      [l x 4], matrix of optimized weights theta


% getting number of examples l
[l,~] = size(B);

% initialiing temporary matrix
theta = zeros(l,4);


% looping through examples
for i = 1:l
    
    % cheating, shouldn't be using the known ratings
    % learning the optimal weight for example  (theta = Yi/Bi)
    theta_temp = (Xtest(i,4)+eps)./B(i,:);
    theta(i,:) = theta_temp/sum(theta_temp);
   
 
end

% adding columns of theta_temp to normalizing
%theta = sum(theta_temp,1);

% normalizing weights so that sum(Wi) = 1
%theta = theta/sum(theta);

end