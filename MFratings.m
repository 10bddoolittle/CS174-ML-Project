function [M, Uidx,Tidx, Aidx] = MFratings(Xtrain)
% Creates Base matrix of users and tracks

% INPUTS:
% Xtrain     Data set of users tracks and ratings

% OUTPUTS:
% M          Matrix of [users,tracks]
% Uidx{i}    cell contains the track indices rated by user {i} 
% Tidx{i}    cell contains the indices of users who have rated track {i}
% Aidx{i}    cell contains the indices of tracks composed by artist {i}

[m,n] = size(Xtrain);
mxU = max(Xtrain(:,3));
mxT = max(Xtrain(:,2));
mxA = max(Xtrain(:,1));

% initializing Matrix
M = -ones(mxU+1,mxT+1);
A = -ones(mxA+1,MxT+1);

for i = 1:m
    
    uidx = Xtrain(i,3) + 1;
    tidx = Xtrain(i,2) + 1;
    aidx = Xtrain(i,1) + 1;
    M(uidx,tidx) = Xtrain(i,4);
    A(aidx,tidx) = 1;
    
end

[nUsers,nTracks] = size(M);
[nArtists,~] = size(A);

for iterUser = 1:nUsers

    Mrow = M(iterUser,:);
    
    markidx = find(Mrow == -1);
    
    % indices of rows of M that are rated
    Uidx{iterUser} = setdiff([1:nTracks],markidx);
 
    
end

for iterTrack = 1:nTracks
    Mcol = M(:,iterTrack);
    
    markidx = find(Mcol == -1);
    
    % indices of cols of M that are rated
    Tidx{iterTrack} = setdiff([1:nUsers],markidx);
    
end

for iterArtist = 1:nArtists
   Arow = A(iterArtist,:);
   
   Aidx = find(Arow == 1);
end

end

