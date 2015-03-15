function [Artist_Prof, AU,AUidx, UAidx] = MFartists(M,A,ArtistProf)


% OUTPUTS
% ArtistRatings Cell
% AUidx{i}   indices of users who have rated artist {i}
% UAidx{i}   indices of artists who have been rated by user {i}


[m,n] = size(ArtistProf);
[nUsers,nTracks] = size(M);
[nArtists,~] = size(A);

AU = -2*ones(nUsers,nArtists,n - 2);


for i = 1:m
    aidx = ArtistProf(i,1) + 1;
    uidx = ArtistProf(i,2) + 1;
    AU(uidx,aidx,:) = ArtistProf(i,3:n);
end

for iterArtist = 1:nArtists
    
   idx = find(AU(:,iterArtist,1) == -2);
   
   AUidx{iterArtist} = setdiff(1:nUsers,idx);
   
end
    
for iterUser = 1:nUsers
    
    idx = find(AU(iterUser,:,1) == -2);
    UAidx{iterUser} = setdiff(1:nArtists,idx);
    
end

        for iterArtist = 1:nArtists
            %users who have rated artist{i}
            userIdx = AUidx{iterArtist};
            nUser = length(userIdx);
            tempProfile = zeros(nUser,92);
            
            if (nUser ~= 0)
                for iterUser = 1:nUser
                    tempProfile(iterUser,:) = reshape(AU(userIdx(iterUser),iterArtist,:),[1,92]);
                end
            end
            
            Artist_Prof(iterArtist,:) = mean(tempProfile);
            
        end
        
        save('Artist_Prof','Artist_Prof');

end
