
data_train = load('data_train.mat');
data_users = load('data_users.mat');
data_words = load('data_words.mat');


Xtrain = data_train.train;
user_profile = data_users.data_users;
words_profile = data_words.data_words;

%ratings in time period 1-6
idx_T1 = find(Xtrain(:,5)<= 20);
idx_T2 = find(Xtrain(:,5) > 20);
%idx_T3 = find(Xtrain(:,5) < 18);
%idx_T4 = find(Xtrain(:,5) < 24);

train = Xtrain(idx_T1,:);
test = Xtrain(idx_T2,:);

% finding maximum values of Xtrain
maxArtist = max(Xtrain(:,1));
maxTrack = max(Xtrain(:,2));
maxUser = max(Xtrain(:,3));

fprintf('finding M')
% creating M matrix with Xtrain filled in and dimensions MaxUser+1 x
% MaxTrack+1
[M,Uidx,Tidx,Aidx,A] = MFratings(train,maxArtist,maxTrack,maxUser);
%function [T,U] = MFtrain_latent(M,lambda,gamma,latent)
%function pred_y = MFpredict_latent(T,Xtest,U)

fprintf('finding UserProf')
% making matrix of user profiles
UserProf = MFusers(M,user_profile);

fprintf('finding WordProf')

[WordProf,AUidx,UAidx] = MFartists(M,A,words_profile);
%train the model on ratings for first 12 months
%[T,U] = MFtrain_latent(M,0.01,0.01,150);



save('WordProf','WordProf')
save('UserProf','UserProf')
save('M','M')
save('A','A')
save('Aidx','Aidx')
save('Tidx','Tidx')
save('Uidx','Uidx')
save('AUidx','AUidx')
save('UAidx','UAidx')
save('test','test')
save('train','train')

fprintf('saved files')




