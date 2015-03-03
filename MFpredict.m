function pred_y = MFpredict(T,Xtest,U,Uidx)
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

% for each example in Xtest
for i = 1:m
    uidx = predU(i)+1;
    tidx = predT(i)+1;
    
    idx = Uidx{uidx};
    % finding constant to rescale prediction by to account for
    % missing features
    renorm = sqrt(T(:,tidx)'*T(:,tidx))/sqrt(T(idx,tidx)'*T(idx,tidx));

    pred_y(i) = U(uidx,idx)*T(idx,tidx)*renorm + 20;
    
    if pred_y(i) < 0
        pred_y(i) = 0;
    elseif pred_y(i) > 100
        pred_y(i) = 100;
    end
    
end




end