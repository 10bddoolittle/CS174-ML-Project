function theta = train(B,Xtest)


[l,n] = size(B);

theta = zeros(l,4);


%for i = 1:l
    
    
theta(1,:) = Xtest(1,4)./B(1,:);
   
    
theta(1,:) = theta(1,:)/sum(theta(1,:));
    
%end

end