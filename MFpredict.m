function [pred_y, err,err2,Unan,Tnan,Rnan,count,Tempty,userlatent] = MFpredict(T,Xtest,U,Markidx,Tidx,Aidx,AUidx,UserProf,WordProf)
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

k = 1;
l = 1;
err = 0;
err2 = 0;
Tempty = 0;
count = 0;
userlatent = 0;
% for each example in Xtest
for i = 1:m
    uidx = predU(i)+1;
    tidx = predT(i)+1;
    aidx = predA(i)+1;
    
    idx = Markidx{uidx};
    
    if U(uidx,:)*U(uidx,:)' == 0
        if T(:,tidx)'*T(:,tidx) == 0
            %reference
            %find_usertrack_latent(newUserIdx,newTrackIdx, U,T,Tidx,Aidx,userProfile,wordProfile,mode)
            [Ul,Tl,count] = find_usertrack_latent(uidx,tidx,U,T,Tidx{tidx},Aidx{aidx},AUidx{aidx},UserProf,WordProf,'Mean',count);
            if isnan(Ul)
                userlatent = userlatent + 1;
            end
        else
            if isempty(Tidx{tidx})
                Tempty = Tempty +1;
                
            else
                Ul = find_user_latent(uidx,Tidx{tidx},U,UserProf,'Mean');

            end
            Tl = T(:,tidx);
        end
    
    else   
        if T(:,tidx)'*T(:,tidx) == 0
            err2(l) = i;
            l = l+1;
            Tl = find_track_latent(Aidx{aidx},T,'average');
            Ul = U(uidx,:);
        else
            Tl = T(:,tidx);
            Ul = U(uidx,:);
        end
    end
    
    % finding constant to rescale prediction by to account for
    % missing features
    if Tl'*Tl == 0
        
        
    else
        renorm = sqrt(Tl'*Tl)/sqrt(Tl(idx)'*Tl(idx));
        if isnan(renorm)
            err(k) = i;
            k = k +1;
            pred_y(i) = 30;
            
        else
        
            pred_y(i) = Ul*Tl*renorm;
            
            if isnan(pred_y(i))
                pred_y(i) = 30;
                err(k) = i;
                k = k+1;
                Unan = Ul;
                Tnan = Tl;
                Rnan = renorm;
            end
        end
    end
    
    if pred_y(i) < 0
        pred_y(i) = 0;
    elseif pred_y(i) > 100
        pred_y(i) = 100;
    end
    
end




end