function [error,pred_y,correct_y,T,U,train,test] = timeTrainTest()
data_train = load('data_train.mat');
data_users = load('data_users.mat');

Xtrain = data_train.train;
user_profile = data_users.data_users;

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


% creating M matrix with Xtrain filled in and dimensions MaxUser+1 x
% MaxTrack+1
[M,Aidx,Tidx,Uidx] = MFratings(train,maxArtist,maxTrack,maxUser);
%function [T,U] = MFtrain_latent(M,lambda,gamma,latent)
%function pred_y = MFpredict_latent(T,Xtest,U)

% making matrix of user profiles
UserProf = MFusers(M,user_profile);

%train the model on ratings for first 12 months
%[T,U] = MFtrain_latent(M,0.01,0.01,150);
[T,U,Uidx] = MFtrain(M,UserProf,.01,.01);


%predict the ratings for the next 12 months
%pred_y = MFpredict_latent(T,test,U,Aidx);
pred_y = MFpredict(T,test,U,Uidx);

correct_y = test(:,4);
error = rmse(pred_y,correct_y);
end


