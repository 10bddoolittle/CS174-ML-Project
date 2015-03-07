function M = MFratings(Xtrain)
% Creates Base matrix of users and tracks

% INPUTS:
% Xtrain     Data set of users tracks and ratings

% M          Matrix of [users,tracks]

[m,n] = size(Xtrain);
mxU = max(Xtrain(:,3));
mxT = max(Xtrain(:,2));

% initializing Matrix
M = -ones(mxU+1,mxT+1);

for i = 1:m
    
    uidx = Xtrain(i,3) + 1;
    tidx = Xtrain(i,2) + 1;
    M(uidx,tidx) = Xtrain(i,4);
    
end

end

