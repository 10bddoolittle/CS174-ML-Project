function [error,pred_y,correct_y,T,U,train,test,err,err2,count,Tempty,userlatent] = TrainTest()
data_train = load('data_train.mat');
% data_users = load('data_users.mat');
% data_words = load('data_words.mat');
% 
% 
Xtrain = data_train.train;
% user_profile = data_users.data_users;
% words_profile = data_words.data_words;
% 
% %ratings in time period 1-6
idx_T1 = find(Xtrain(:,5)<= 20);
idx_T2 = find(Xtrain(:,5) > 20);
% %idx_T3 = find(Xtrain(:,5) < 18);
% %idx_T4 = find(Xtrain(:,5) < 24);
% 
train = Xtrain(idx_T1,:);
test = Xtrain(idx_T2,:);
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
Aidx = load('Aidx.mat');
Tidx = load('Tidx.mat');
AUidx = load('AUidx.mat');

WordProf = WordProf.WordProf;
UserProf = UserProf.UserProf;
M = M.M;
Aidx = Aidx.Aidx;
Tidx = Tidx.Tidx;
AUidx = AUidx.AUidx;




fprintf('loaded files')

[T,U,Markidx] = MFtrain(M,UserProf,.01,.01);



%predict the ratings for the next 12 months
%pred_y = MFpredict_latent(T,test,U,Aidx);
[pred_y, err,err2,count,Tempty,userlatent] = MFpredict(T,test,U,Markidx,Tidx,Aidx,AUidx,UserProf,WordProf);

correct_y = test(:,4);
error = rmse(pred_y,correct_y);
end
