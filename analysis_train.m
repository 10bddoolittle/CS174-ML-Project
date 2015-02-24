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
% j = 1;
% for k = 0:23
%     clearvars idx
%     idx = zeros(1);
%     for i = 1:m
%         if X(i,5) == 3
%             idx(j) = i;
%             j = j + 1;
%         end
%     end
%     num_rating(k+1) = length(idx);
%     j = 1;
% end
% max num_rating is 2795, min is 138

%Xsub = X(idx,:);

% [lik,lik2,lik3,sig,mu,stdev] = likelihood(X, 'artist');
% 
% l = size(lik,1);
% 
% likely1 = sum(lik)/l;
% likely2 = sum(lik2)/l;
% likely3 = sum(lik3)/l;
% 
% likely1
% likely2
% likely3 


figure(1)
histogram(X(:,4),50)
xl = xlabel('Rating');
yl = ylabel('# of Examples');
set([xl,yl],'FontSize',14)
t = title('Distribution of Ratings');
set(t,'FontSize',20)

%figure(2)
%plot([likely1,likely2,likely3])
