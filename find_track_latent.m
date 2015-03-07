function Tl = find_track_latent(Aidx,T,mode)

% INPUTS:
% Aidx       vector that contains the indices of tracks by the artist
% T          indexed latent features for tracks
% mode       string can be 'average' or 'recent'


% OUTPUT:
% Tl         latent feature for the new track



Tset = T(:,Aidx);

[m,n] = size(Tset);

if strcmp(mode,'average')
    Tl = sum(T,2)/n;
elseif strcmp(mode,'recent')
    Tl = Tset(:,n);
else 
    fprintf('input must be "average" or "recent"');
end



end