function theta = training(B,Xtest)


[l,n] = size(B);

theta_temp = zeros(l,4);


for i = 1:l
    
    
    theta_temp(i,:) = (Xtest(i,4)+eps)./B(i,:);
   
    
    theta_temp(i,:) = theta_temp(i,:)/sum(theta_temp(i,:));
    
end

theta = sum(theta_temp)/100;

end