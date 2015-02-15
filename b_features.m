function B = b_features(Xtrain,Xtest)

[m,n] = size(Xtest);
B = zeros(m,4);


   
[B(:,1),~] = average(Xtrain,Xtest,'artist');
[B(:,2),~] = average(Xtrain,Xtest,'track');
[B(:,3),~] = average(Xtrain,Xtest,'user');
[B(:,4),~] = average(Xtrain,Xtest,'time');
    
    


end