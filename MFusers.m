function U = MFusers(M,data_users)

num_user = size(M,1);
[m,n] = size(data_users);

U = zeros(num_user,n-1);




for i = 1:m
   uidx = data_users(i,1) + 1;
   
   U(uidx,:) = data_users(i,2:n);
    
end

% finding users who did not fill in survey and giving them average
coldidx = find(sum(abs(U),2) == 0);

avgU = sum(abs(U))/m;



for i = coldidx'
    U(i,:) = avgU;
    
end


end