function [M, Uidx,Tidx, Aidx, A] = MFratings(Xtrain, maxArtist, maxTrack, maxUser)
% Creates Base matrix of users and tracks

% INPUTS:
% Xtrain     Data set of users tracks and ratings

% OUTPUTS:
% M          Matrix of [users,tracks]
% Uidx{i}    cell contains the track indices rated by user {i} 
% Tidx{i}    cell contains the indices of users who have rated track {i}
% Aidx{i}    cell contains the indices of tracks composed by artist {i}
% A          Artist track matrix used to determine which tracks were by a
%            given artist


[m,~] = size(Xtrain);
mxU = maxUser;
mxT = maxTrack;
mxA = maxArtist;

avg = mean(Xtrain(:,4));

% initializing Matrix
M = avg*ones(mxU+1,mxT+1);
A = -ones(mxA+1,mxT+1);

Uit = ones(1,mxU + 1);
Tit = ones(1,mxT + 1);


Uidx = cell(1,mxU + 1);
Tidx = cell(1,mxT + 1);


for i = 1:m
    
    uidx = Xtrain(i,3) + 1;
    tidx = Xtrain(i,2) + 1;
    aidx = Xtrain(i,1) + 1;
    
    Uidx{uidx}(Uit(uidx)) = tidx;
    Tidx{tidx}(Tit(tidx)) = uidx;
    
    
    
    M(uidx,tidx) = Xtrain(i,4);
    A(aidx,tidx) = 1;
    
    Uit(uidx) = Uit(uidx) + 1;
    Tit(tidx) = Tit(tidx) + 1;
end

[nUsers,nTracks] = size(M);
[nArtists,~] = size(A);

% for iterUser = 1:nUsers
% 
%     Mrow = M(iterUser,:);
%     
%     markidx = find(Mrow == -1);
%     
%     % indices of rows of M that are rated
%     Uidx{iterUser} = setdiff([1:nTracks],markidx);
%  
%     
% end

% for iterTrack = 1:nTracks
%     Mcol = M(:,iterTrack);
%     
%     markidx = find(Mcol == -1);
%     
%     % indices of cols of M that are rated
%     Tidx{iterTrack} = setdiff([1:nUsers],markidx);
%     
% end



for iterArtist = 1:nArtists
   Arow = A(iterArtist,:);
   
   Aidx{iterArtist} = find(Arow == 1);
end

end

