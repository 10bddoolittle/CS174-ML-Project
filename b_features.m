function B = b_features(Xtrain,Xtest)

% inputs:
% Xtrain:  [(m-l) x n], 
% Xtest:   [l x n],

% ouputs:
% B:       [l x 4], row are matched to each example, col are averages of
%                   examples in respect to 'artist', 'track', 'user',
%                   'time'


% getting number of rows of Xtest
l = size(Xtest,1);

% Initializing B
B = zeros(l,4);


 % getting averages for examples in Xtest  
[B(:,1),~] = average(Xtrain,Xtest,'artist');
[B(:,2),~] = average(Xtrain,Xtest,'track');
[B(:,3),~] = average(Xtrain,Xtest,'user');
[B(:,4),~] = average(Xtrain,Xtest,'time');
    
    


end