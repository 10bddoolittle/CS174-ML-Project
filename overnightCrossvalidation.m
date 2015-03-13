function error = overnightCrossvalidation(lambda1,lambda2,gamma,niter)
%INPUT
%lambda1: [nLambda1 x 1]
%lambda2: [nLambda2 x 1]
%gamma: [nGamma x 1]
%niter: [iter x 1]

%OUTPUT
%error: [nLambda1 x nLambda2 x nGamma] contains error for each iteration

    WordProf = load('WordProf.mat');
    UserProf = load('UserProf.mat');
    M = load('M.mat');
    Aidx = load('Aidx.mat');
    Tidx = load('Tidx.mat');
    AUidx = load('AUidx.mat');
    train = load('train.mat');
    test = load('test.mat');

    WordProf = WordProf.WordProf;
    UserProf = UserProf.UserProf;
    M = M.M;
    Aidx = Aidx.Aidx;
    Tidx = Tidx.Tidx;
    AUidx = AUidx.AUidx;
    test = test.test;
    train = train.train;

    fprintf('loaded files \n')
    fprintf('starting cross-validation steps.. \n');

    for iterLambda1 = 1:length(lambda1)
        for iterLambda2 = 1:length(lambda2)
            for iterGamma = 1:length(gamma)
                for iter = 1:length(niter)
                    %train the model    
                    [T,U,rmse1,rmse2] = MFtrain(M,UserProf,lambda1(iterLambda1),...
                                            lambda2(iterLambda2),gamma(iterGamma),niter(iter));

                    %predict the ratings for the next 12 months
                    %pred_y = MFpredict_latent(T,test,U,Aidx);
                    [pred_y] = MFpredict(T,test,U,Tidx,Aidx,AUidx,UserProf,WordProf);

                    correct_y = test(:,4);
                    error(iterLambda1,iterLambda2,iterGamma,iter) = rmse(pred_y,correct_y);
                    train_err(iterLambda1,iterLambda2,iterGamma,iter) = rmse2(niter);
                    
                    %save after each iteration
                    save('cross_val_test_error','error');
                    save('cross_val_train_error','train_err');
                end
            end
        end
    end
end
