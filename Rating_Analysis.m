m = load('M.mat');
u = load('Uidx.mat');
M = m.M;
Uidx = u.Uidx;

[nUsers,nTracks] = size(M);

ratingInfo = zeros(nUsers,4);

for iterUser = 1:nUsers
    
    if ~isempty(Uidx{iterUser})

        ratingInfo(iterUser,1) = mean(M(iterUser,Uidx{iterUser}));
        ratingInfo(iterUser,2) = var(M(iterUser,Uidx{iterUser}));
        ratingInfo(iterUser,3) = max(M(iterUser,Uidx{iterUser}));
        ratingInfo(iterUser,4) = min(M(iterUser,Uidx{iterUser}));
    else
    end
    
    
    
    
end