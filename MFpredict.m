function [pred_y,Uerr,Terr] = MFpredict(T,Xtest,U,Markidx,Tidx,Aidx,AUidx,UserProf,WordProf)
% predicts rating for new set of users

% INPUT 
% theta     [k,n]  k feature weights for each track
% Xtest     examples to be predicted 
% U         [m,k] m user profiles with k features each

% pred_y    predicted track rating of user

[m,n] = size(Xtest);

pred_y = zeros(m,1);

% user track combo to predict
predU = Xtest(:,3);
predT = Xtest(:,2);
predA = Xtest(:,1);

[nUser,nFeatures] = size(U);
[~,nTracks] = size(T);

Uerr = -2*ones(nUser,nFeatures);
Terr = -2*ones(nFeatures,nTracks);


count = 0;

% for each example in Xtest
for i = 1:m
    
    i
    m
    uidx = predU(i)+1;
    tidx = predT(i)+1;
    aidx = predA(i)+1;
    
    idx = Markidx{uidx};
    
    if U(uidx,:)*U(uidx,:)' == 0
        if T(:,tidx)'*T(:,tidx) == 0
            %reference
            %find_usertrack_latent(newUserIdx,newTrackIdx, U,T,Tidx,Aidx,userProfile,wordProfile,mode)
            [Ul,Tl,count] = find_usertrack_latent(uidx,aidx,tidx,U,T,Tidx{tidx},Aidx{aidx},AUidx{aidx},UserProf,WordProf,'Mean',count);          
        else

            Ul = find_user_latent(uidx,Tidx{tidx},U,UserProf,'Mean');                
            Tl = T(:,tidx);
        end
    
    else   
        if T(:,tidx)'*T(:,tidx) == 0
            Tl = find_track_latent(Aidx{aidx},T,'average');
            Ul = U(uidx,:);
        else
            Tl = T(:,tidx);
            Ul = U(uidx,:);
        end
    end
    
    % finding constant to rescale prediction by to account for
    % missing features

    renorm = sqrt(Tl'*Tl)/sqrt(Tl(idx)'*Tl(idx));

    pred_y(i) = Ul*Tl*renorm;

    Uerr(i,:) = Ul;
    Terr(:,i) = Tl;
       
    
    if pred_y(i) < 0
        pred_y(i) = 0;
    elseif pred_y(i) > 100
        pred_y(i) = 100;
    else
       class = [10,30,50,70,90];
       [mi,idx] = min(abs(class - pred_y(i)));
       
       pred_y(i) = pred_y(i) + .5*(class(idx)-pred_y(i));
    end
    
end




end