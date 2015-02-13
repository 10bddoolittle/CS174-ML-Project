clear all

S = load('data_train.mat');


% artist, track, user, rating, time
X = S.train;

% 50 artists, 163 to 14295 ratings per artist
% 50928 users, users rate from 1 to 15 tracks
% 184 tracks, 138 to 2795 ratings per track
% 24 times, (two years of data), some months have no ratings, some have
% thousands
% rating from 0 to 100

[m,n] = size(X);


% finding minimum and maximum number of ratings per song
j = 1;
for k = 0:23
    clearvars idx
    idx = zeros(1);
    for i = 1:m
        if X(i,5) == 3
            idx(j) = i;
            j = j + 1;
        end
    end
    num_rating(k+1) = length(idx);
    j = 1;
end
% max num_rating is 2795, min is 138

%Xsub = X(idx,:);

figure(1)
plot(num_rating)
