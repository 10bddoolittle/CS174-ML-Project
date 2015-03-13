function [error,pred_y,correct_y,T,U,rmse1,rmse2] = TrainTest(lambda1,lambda2,gamma,niter)

% data_users = load('data_users.mat');
% data_words = load('data_words.mat');
% 
% 

% user_profile = data_users.data_users;
% words_profile = data_words.data_words;
% 
% %ratings in time period 1-6

% %idx_T3 = find(Xtrain(:,5) < 18);
% %idx_T4 = find(Xtrain(:,5) < 24);
% 

% 
% % finding maximum values of Xtrain
% maxArtist = max(Xtrain(:,1));
% maxTrack = max(Xtrain(:,2));
% maxUser = max(Xtrain(:,3));
% 
% fprintf('finding M')
% % creating M matrix with Xtrain filled in and dimensions MaxUser+1 x
% % MaxTrack+1
% [M,Aidx,Tidx,Uidx,A] = MFratings(train,maxArtist,maxTrack,maxUser);
% %function [T,U] = MFtrain_latent(M,lambda,gamma,latent)
% %function pred_y = MFpredict_latent(T,Xtest,U)
% 
% fprintf('finding UserProf')
% % making matrix of user profiles
% UserProf = MFusers(M,user_profile);
% 
% fprintf('finding WordProf')
% 
% [WordProf,AUidx,UAidx] = MFartists(M,A,words_profile);
% %train the model on ratings for first 12 months
% %[T,U] = MFtrain_latent(M,0.01,0.01,150);

WordProf = load('WordProf.mat');
UserProf = load('UserProf.mat');
M = load('M.mat');
Uidx = load('Uidx.mat');
Aidx = load('Aidx.mat');
Tidx = load('Tidx.mat');
UAidx = load('UAidx.mat');
AUidx = load('AUidx.mat');
train = load('train.mat');
test = load('test.mat');

WordProf = WordProf.WordProf;
UserProf = UserProf.UserProf;
M = M.M;
Aidx = Aidx.Aidx;
Tidx = Tidx.Tidx;
Uidx = Uidx.Uidx;
UAidx = UAidx.UAidx;
AUidx = AUidx.AUidx;
test = test.test(:,:);
train = train.train;



fprintf('loaded files')

[T,U,rmse1,rmse2] = MFtrain(M,UserProf,Uidx,Tidx,lambda1,lambda2,gamma,niter);



%predict the ratings for the next 12 months
%pred_y = MFpredict_latent(T,test,U,Aidx);
[pred_y,coldStart_idx,newUser_idx,newTrack_idx,warmStart_idx] = MFpredict(T,test,U,Tidx,Aidx,AUidx,UserProf,WordProf);

correct_y = test(:,4);
error = rmse(pred_y,correct_y);
end
