function pred_y = MFpredict(T,Xtest,U)
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


for i = 1:m
    uidx = predU(i)+1;
    tidx = predT(i)+1;
    
    pred_y(i) = U(uidx,:)*T(:,tidx);
    
    
    
end



end