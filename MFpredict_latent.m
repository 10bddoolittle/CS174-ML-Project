function pred_y = MFpredict_latent(T,Xtest,U,Aidx)
% predicts rating for new set of users

% INPUT 
% theta     [k,n]  k feature weights for each track
% Xtest     examples to be predicted 
% U         [m,k] m user profiles with k features each

% pred_y    predicted track rating of user

[m,n] = size(Xtest);
[nFeatures,~] = size(T);

pred_y = zeros(m,1);

% user track combo to predict
predU = Xtest(:,3);
predT = Xtest(:,2);

% for each example in Xtest
for i = 1:m
    uidx = predU(i)+1;
    tidx = predT(i)+1;
    
    if sum(T(:,tidx)) == 0
        if isempty(Aidx{tidx}) 
            Tl = .5*ones(1:nFeatures,1);
        else
        Tl = find_track_latent(Aidx{tidx},T,'average');
        end
    else
        Tl = T(:,tidx);
    end
    pred_y(i) = U(uidx,:)*Tl;
    
    if pred_y(i) < 0
        pred_y(i) = 0;
    elseif pred_y(i) > 100
        pred_y(i) = 100;
    end
    
end




end