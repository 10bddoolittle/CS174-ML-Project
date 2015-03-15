function [error,pred_y,correct_y,T,U,train,test,coldStart_idx,newUser_idx,newTrack_idx,warmStart_idx,rmse1,rmse2] ...
        = TrainTest(lambda1,lambda2,gamma,niter, test_idx)

WordProf = load('WordProf.mat');
UserProf = load('UserProf.mat');
ArtistProf = load('ArtistProf.mat');
M = load('M.mat');
Aidx = load('Aidx.mat');
Tidx = load('Tidx.mat');
Uidx = load('Uidx.mat');
AUidx = load('AUidx.mat');
train = load('train.mat');
test = load('test.mat');

WordProf = WordProf.WordProf;
UserProf = UserProf.UserProf;
ArtistProf = ArtistProf.ArtistProf;
M = M.M;
Aidx = Aidx.Aidx;
Tidx = Tidx.Tidx;
Uidx = Uidx.Uidx;
AUidx = AUidx.AUidx;
test = test.test(:,:);
train = train.train;
test = test(1:1000,:);


fprintf('loaded files \n')
%training
fprintf('Training.. \n')
    [T,U,Utrainidx,Ttrainidx,rmse1,rmse2] = MFtrain(M,UserProf,Uidx,Tidx,lambda1,lambda2,gamma,niter);
    
%prediction
fprintf('Testing.. \n')
    [pred_y,coldStart_idx,newUser_idx,newTrack_idx,warmStart_idx] =...
         MFpredict(T,test,U,Tidx,Aidx,AUidx,UserProf,WordProf,ArtistProf,Utrainidx,Ttrainidx);
%error
    correct_y = test(:,4);
    error = rmse(pred_y,correct_y);
    
end
