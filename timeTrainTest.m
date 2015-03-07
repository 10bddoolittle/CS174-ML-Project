
data = load('data_train');
Xtrain = data.train;

%ratings in time period 1-6
idx_T1 = find(Xtrain(:,5)<= 12);
idx_T2 = find(Xtrain(:,5) > 12);
%idx_T3 = find(Xtrain(:,5) < 18);
%idx_T4 = find(Xtrain(:,5) < 24);


M_T1 = MFratings(Xtrain(idx_T1,:));
%function [T,U] = MFtrain_latent(M,lambda,gamma,latent)
%function pred_y = MFpredict_latent(T,Xtest,U)

%train the model on ratings for first 12 months
[T,U] = MFtrain_latent(M_T1,0.001,0.001,50);
%predict the ratings for the next 12 months
predY = MFpredict_latent(T,Xtrain(idx_T2,:),U);

error = ((Xtrain(idx_T2,4) - predY).^2);
error = sum(error)/length(error);
