function UserProf = MFusers(M,data_users)

num_user = size(M,1);
[m,n] = size(data_users);

UserProf = zeros(num_user,n-1);




for i = 1:m
   uidx = data_users(i,1) + 1;
   
   UserProf(uidx,:) = data_users(i,2:n);
    
end

% finding users who did not fill in survey and giving them average
coldidx = find(sum(abs(UserProf),2) == 0);

avgU = sum(abs(UserProf))/m;



for i = coldidx'
    UserProf(i,:) = avgU;
    
end


end