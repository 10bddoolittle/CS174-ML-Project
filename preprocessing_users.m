%Brian Doolittle, Pratap Luitel
%2/11/2015
%COSC 174 - Machine Learning and Statistical Analysis

%This file parses through users.csv, processes data and stores them in a
%matrix data_users.mat. Processing includes quantization/discretization of
%fields of type string. 


fileID_words = fopen('users.csv');
formatSpec = '%s';
N = 28; %# of columns including and additional column added for parsing


%empty cell initialization
data = cell(1,48646);
%end of file status
eof_status = feof(fileID_words);
%index variable 
i = 0;
while eof_status ~= 1
    i = i + 1;
    data{i} = textscan(fileID_words,formatSpec,N,'delimiter',','); 
    eof_status = feof(fileID_words);
    if i == 100
        %break
    end
end

%close
fclose(fileID_words);


num_examples = size(data,2)-1;  % subtract 1 because top row is labels
data_users = zeros(num_examples,N-1);
fprintf( 'converting cell to matrix');

importance_of_music_1 = 'Music means a lot to me and is a passion of mine';
importance_of_music_2 = 'Music is important to me but not necessarily more important';
importance_of_music_3 = 'Music is important to me but not necessarily more important than other hobbies or interests';
importance_of_music_4 = 'I like music but it does not feature heavily in my life';
importance_of_music_5 = 'Music has no particular interest for me';

working_1 = 'Employed 30+ hours a week';
working_3 = 'Employed 8-29 hours per week';
working_2 = 'Full-time housewife / househusband';
working_4 = 'Full-time student';
working_5 = 'Retired from full-time employment (30+ hours per week)';
working_6 = 'Temporarily unemployed';
working_7 = 'Prefer not to state'; %not used so far
working_8 = 'In unpaid employment (e.g. voluntary work)'; %not used so far
working_9 = 'Other';%not implemented so far

% filling in the data_users matrix
for i = 1:num_examples
    
    % user_id
    data_users(i,1) = str2double(cell2mat(data{i+1}{1}(1)));
    
    %gender: 1 for male, 2 for female, 0 for empty,  -1 for anything else
    if strcmp((data{i+1}{1}(2)),'Male')
        data_users(i,2) = 1;
    elseif strcmp((data{i+1}{1}(2)),'Female')
        data_users(i,2) = 2;
    elseif strcmp((data{i+1}{1}(2)),'')
        data_users(i,2) = 0;
    else
        data_users(i,2) = -1;
    end
    
    % age
    if strcmp((data{i+1}{1}(3)),'') ~= 1
        data_users(i,3) = str2double(cell2mat(data{i+1}{1}(3)));
    elseif strcmp((data{i+1}{1}(3)),'')
        data_users(i,3) = 0;
    else
        data_users(i,3) = -1;
    end
       
    %working
    nf = 10; %normalizing factor
    if strcmp((data{i+1}{1}(4)),working_1)
        data_users(i,4) = 10/nf;
    elseif strcmp((data{i+1}{1}(4)),working_2)
        data_users(i,4) = 8/nf;
    elseif (strcmp((data{i+1}{1}(4)),working_3) |...
            strcmp((data{i+1}{1}(4)),working_4))
        data_users(i,4) = 5/nf;
    elseif strcmp((data{i+1}{1}(4)),working_5) 
        data_users(i,4) = 2/nf;
    elseif strcmp((data{i+1}{1}(4)),working_6) 
        data_users(i,4) = 1/nf;
    elseif strcmp((data{i+1}{1}(4)),'')
        data_users(i,4) = 0;
    else
        data_users(i,4) = -1/nf;
    end
    
    %region
    if strcmp((data{i+1}{1}(5)),'North')
        data_users(i,5) = 4;
    elseif strcmp((data{i+1}{1}(5)),'Centre')
        data_users(i,5) = 3;
    elseif strcmp((data{i+1}{1}(5)),'Midlands')
        data_users(i,5) = 2;
    elseif strcmp((data{i+1}{1}(5)),'South')
        data_users(i,5) = 1;
    elseif strcmp((data{i+1}{1}(5)),'')
        data_users(i,5) = 0;
    else
        data_users(i,5) = -1;
    end
    
    %importance of music
    nf = 10; %normalizing factor
    if strcmp((data{i+1}{1}(6)),importance_of_music_1)
        data_users(i,6) = 10/nf;
    elseif (strcmp((data{i+1}{1}(6)),importance_of_music_2)||...
           strcmp((data{i+1}{1}(6)),importance_of_music_3))
        data_users(i,6) = 6/nf;
    elseif strcmp((data{i+1}{1}(6)),importance_of_music_4)
        data_users(i,6) = 2/nf;
    elseif strcmp((data{i+1}{1}(6)),importance_of_music_5)
        data_users(i,6) = 1/nf;
    elseif strcmp((data{i+1}{1}(6)),'')
        data_users(i,6) = 0;
    else
        data_users(i,6) = -1/nf;
    end
    
    
    %normalizing factor
    nf = 18; 
    
    %list_own
    if strcmp((data{i+1}{1}(7)),'Less than an hour')
        data_users(i,7) = 0.5/nf;
    elseif strcmp((data{i+1}{1}(7)),'1 hour') ||... 
            strcmp((data{i+1}{1}(7)),'1')
        data_users(i,7) = 1/nf;
    elseif strcmp((data{i+1}{1}(7)),'2 hours') ||... 
            strcmp((data{i+1}{1}(7)),'2')
        data_users(i,7) = 2/nf;        
    elseif strcmp((data{i+1}{1}(7)),'3 hours') ||... 
            strcmp((data{i+1}{1}(7)),'3')
        data_users(i,7) = 3/nf;   
    elseif strcmp((data{i+1}{1}(7)),'4 hours') ||... 
            strcmp((data{i+1}{1}(7)),'4')
        data_users(i,7) = 4/nf;   
    elseif strcmp((data{i+1}{1}(7)),'5 hours') ||... 
            strcmp((data{i+1}{1}(7)),'5')
        data_users(i,7) = 5/nf;   
    elseif strcmp((data{i+1}{1}(7)),'6 hours') ||... 
            strcmp((data{i+1}{1}(7)),'6')
        data_users(i,7) = 6/nf;   
    elseif strcmp((data{i+1}{1}(7)),'7 hours') ||... 
            strcmp((data{i+1}{1}(7)),'7')
        data_users(i,7) = 7/nf;   
    elseif strcmp((data{i+1}{1}(7)),'8 hours') ||... 
            strcmp((data{i+1}{1}(7)),'8')
        data_users(i,7) = 8/nf;   
    elseif strcmp((data{i+1}{1}(7)),'9 hours') ||... 
            strcmp((data{i+1}{1}(7)),'9')
        data_users(i,7) = 9/nf;   
    elseif strcmp((data{i+1}{1}(7)),'10 hours') ||... 
            strcmp((data{i+1}{1}(7)),'10')
        data_users(i,7) = 10/18;   
    elseif strcmp((data{i+1}{1}(7)),'11 hours') ||... 
            strcmp((data{i+1}{1}(7)),'11')
        data_users(i,7) = 11/nf;   
    elseif strcmp((data{i+1}{1}(7)),'12 hours') ||... 
            strcmp((data{i+1}{1}(7)),'12')
        data_users(i,7) = 12/nf;  
    elseif strcmp((data{i+1}{1}(7)),'13 hours') ||... 
            strcmp((data{i+1}{1}(7)),'13')
        data_users(i,7) = 13/nf;   
    elseif strcmp((data{i+1}{1}(7)),'14 hours') ||... 
            strcmp((data{i+1}{1}(7)),'14')
        data_users(i,7) = 14/nf;   
    elseif strcmp((data{i+1}{1}(7)),'15 hours') ||... 
            strcmp((data{i+1}{1}(7)),'15')
        data_users(i,7) = 15/nf;   
    elseif strcmp((data{i+1}{1}(7)),'16 hours') ||... 
            strcmp((data{i+1}{1}(7)),'16')
        data_users(i,7) = 16/nf;   
    elseif strcmp((data{i+1}{1}(7)),'More than 16 hours') ||... 
            strcmp((data{i+1}{1}(7)),'16+')
        data_users(i,7) = nf/nf;   
    elseif strcmp((data{i+1}{1}(7)),'') 
        data_users(i,7) = 0;  
    else
        data_users(i,7) = -1;
    end
    
    %list_back
    
    %normalizing factor
    nf = 18; 
    
    %list_own
    if strcmp((data{i+1}{1}(8)),'Less than an hour')
        data_users(i,8) = 0.5/nf;
    elseif strcmp((data{i+1}{1}(8)),'1 hour') ||... 
            strcmp((data{i+1}{1}(8)),'1')
        data_users(i,8) = 1/nf;
    elseif strcmp((data{i+1}{1}(8)),'2 hours') ||... 
            strcmp((data{i+1}{1}(8)),'2')
        data_users(i,8) = 2/nf;        
    elseif strcmp((data{i+1}{1}(8)),'3 hours') ||... 
            strcmp((data{i+1}{1}(8)),'3')
        data_users(i,8) = 3/nf;   
    elseif strcmp((data{i+1}{1}(8)),'4 hours') ||... 
            strcmp((data{i+1}{1}(8)),'4')
        data_users(i,8) = 4/nf;   
    elseif strcmp((data{i+1}{1}(8)),'5 hours') ||... 
            strcmp((data{i+1}{1}(8)),'5')
        data_users(i,8) = 5/nf;   
    elseif strcmp((data{i+1}{1}(8)),'6 hours') ||... 
            strcmp((data{i+1}{1}(8)),'6')
        data_users(i,8) = 6/nf;   
    elseif strcmp((data{i+1}{1}(8)),'7 hours') ||... 
            strcmp((data{i+1}{1}(8)),'7')
        data_users(i,8) = 7/nf;   
    elseif strcmp((data{i+1}{1}(8)),'8 hours') ||... 
            strcmp((data{i+1}{1}(8)),'8')
        data_users(i,8) = 8/nf;   
    elseif strcmp((data{i+1}{1}(8)),'9 hours') ||... 
            strcmp((data{i+1}{1}(8)),'9')
        data_users(i,8) = 9/nf;   
    elseif strcmp((data{i+1}{1}(8)),'10 hours') ||... 
            strcmp((data{i+1}{1}(8)),'10')
        data_users(i,8) = 10/18;   
    elseif strcmp((data{i+1}{1}(8)),'11 hours') ||... 
            strcmp((data{i+1}{1}(8)),'11')
        data_users(i,8) = 11/nf;   
    elseif strcmp((data{i+1}{1}(8)),'12 hours') ||... 
            strcmp((data{i+1}{1}(8)),'12')
        data_users(i,8) = 12/nf;  
    elseif strcmp((data{i+1}{1}(8)),'13 hours') ||... 
            strcmp((data{i+1}{1}(8)),'13')
        data_users(i,8) = 13/nf;   
    elseif strcmp((data{i+1}{1}(8)),'14 hours') ||... 
            strcmp((data{i+1}{1}(8)),'14')
        data_users(i,8) = 14/nf;   
    elseif strcmp((data{i+1}{1}(8)),'15 hours') ||... 
            strcmp((data{i+1}{1}(8)),'15')
        data_users(i,8) = 15/nf;   
    elseif strcmp((data{i+1}{1}(8)),'16 hours') ||... 
            strcmp((data{i+1}{1}(8)),'16')
        data_users(i,8) = 16/nf;   
    elseif strcmp((data{i+1}{1}(8)),'More than 16 hours') ||... 
            strcmp((data{i+1}{1}(8)),'16+')
        data_users(i,8) = nf/nf;    
    elseif strcmp((data{i+1}{1}(8)),'') 
        data_users(i,8) = 0;  
    else
        data_users(i,8) = -1;
    end
    
    nf = 100; %normalizing factor
    for j = 9 : N -1
        if ~strcmp((data{i+1}{1}(j)),'')
            data_users(i,j) = (str2double(cell2mat(data{i+1}{1}(j))))/nf;
        elseif strcmp((data{i+1}{1}(j)),'')
            data_users(i,j) = 0;
        else
            data_users(i,j) = -1/nf;
        end
    end
    
end



save('data_users','data_users')

