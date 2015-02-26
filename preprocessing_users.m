%Brian Doolittle, Pratap Luitel
%2/11/2015
%COSC 174 - Machine Learning and Statistical Analysis

%This file parses through users.csv, processes data and stores them in a
%matrix data_users.mat. Processing includes quantization/discretization of
%fields of type string. 


fileID_words = fopen('users.csv');
formatSpec = '%s';
N = 28; %# of columns including and additional column added for parsing

%invalid input counter
invalidCounter = 0;
%constant to be used for marking empty entries in fields
constantMarker = -1;

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


nExamples = size(data,2)-1; 
data_users = zeros(nExamples,N-1);
fprintf( 'converting cell to matrix %n ..');

%variables represeting users response to importance of music in their life


importance_of_music_1 = 'Music means a lot to me and is a passion of mine';
importance_of_music_2 = 'Music is important to me but not necessarily more important';
importance_of_music_3 = 'Music is important to me but not necessarily more important than other hobbies or interests';
importance_of_music_4 = 'I like music but it does not feature heavily in my life';
importance_of_music_5 = 'Music has no particular interest for me';
importance_of_music_6 = 'Music is no longer as important as it used to be to me';

%variables representing employment status of user
working_1 = 'Employed 30+ hours a week';
working_3 = 'Employed 8-29 hours per week';
working_2 = 'Full-time housewife / househusband';
working_4 = 'Full-time student';
working_5 = 'Retired from full-time employment (30+ hours per week)';
working_6 = 'Temporarily unemployed';
working_7 = 'Prefer not to state'; 
working_8 = 'In unpaid employment (e.g. voluntary work)'; 
working_9 = 'Other';
working_10= 'Self-employed';
working_11= 'Part-time student';
working_12= 'Retired from self-employment';
working_13= 'Employed part-time less than 8 hours per week';

% filling in the data_users matrix
for i = 1:nExamples %nExamples

    %---------------------------------------------------------------------
    %Save the numeric version of the user id
    
    %no of classes
    nClasses = 1;
    %starting column for user id
    startColumn = 1;
    %ending column for user id
    endColumn = startColumn + nClasses - 1;
    %store the id
    data_users(i,startColumn) = str2double(cell2mat(data{i+1}{1}(1)));
    
    %---------------------------------------------------------------------
    %Classify Gender to a binary group
    
    %no of classes
    nClasses = 2;
    %starting column
    startColumn = endColumn + 1;
    %ending column
    endColumn = startColumn + nClasses - 1; 
    %initialize cell values to 0
    data_users(i,startColumn:endColumn) = 0;
    if strcmp((data{i+1}{1}(2)),'Male')
        data_users(i,startColumn) = 1;
    elseif strcmp((data{i+1}{1}(2)),'Female')
        data_users(i,startColumn + 1) = 1;
    elseif strcmp((data{i+1}{1}(2)),'')
        data_users(i,startColumn:endColumn) = constantMarker;
    else
        %error('Unexpected input in Gender, row number %d',i+1);
        invalidCounter = invalidCounter + 1;
        fprintf('error in Gender row %d \n',i+1);
    end
    
    %---------------------------------------------------------------------
    % Classify Age from [0,100] to 5 groups at 20 years interval each.
    
    %no of classes
    nClasses = 5;
    %starting column
    startColumn = endColumn + 1;
    %ending column
    endColumn = startColumn + nClasses - 1;
    %initialize cells to 0
    data_users(i,startColumn:endColumn) = 0;
    %users age
    age = str2double(cell2mat(data{i+1}{1}(3)));
    
    if age > 0 && age <= 20 
        data_users(i,startColumn) = 1;
    elseif age > 20 && age <= 40
        data_users(i,startColumn+1) = 1;
    elseif age > 40 && age <= 60
        data_users(i,startColumn+2) = 1;
    elseif age > 60 && age <= 80
        data_users(i,startColumn+3) = 1;    
    elseif age > 80 && age <= 100
        data_users(i,startColumn+4) = 1;    
    elseif strcmp((data{i+1}{1}(3)),'')
        data_users(i,startColumn:endColumn) = constantMarker;
    else
        %error('Unexpected input in Age, row number %d',i+1);
        %fprintf('The age is %s %n',age);
        invalidCounter = invalidCounter + 1;
        fprintf('error in Age %d \n',i+1);
    end
    
    %---------------------------------------------------------------------
    %Classify working status into 5 groups each represented by a 1 in  a
    %5 bit binary
    
    %no of classes
    nClasses = 13;
    %starting column
    startColumn  = endColumn + 1;
    %end column for working status
    endColumn = startColumn + nClasses - 1; 
    %initialize each cell to 0
    data_users(i,startColumn:endColumn) = 0; 
    %input from the user
    workingStatus = data{i+1}{1}(4);
    
    if strcmp(workingStatus,working_1)
        data_users(i,startColumn) = 1;
    elseif strcmp(workingStatus,working_2)
        data_users(i,startColumn+1) = 1;
    elseif (strcmp(workingStatus,working_3))
        data_users(i,startColumn+2) = 1;
    elseif strcmp(workingStatus,working_4) 
        data_users(i,startColumn+3) = 1;
    elseif strcmp(workingStatus,working_5) 
        data_users(i,startColumn+4) = 1;
    elseif strcmp(workingStatus,working_6) 
        data_users(i,startColumn+5) = 1;
    elseif strcmp(workingStatus,working_7) 
        data_users(i,startColumn+6) = 1;
    elseif strcmp(workingStatus,working_8) 
        data_users(i,startColumn+7) = 1;
    elseif strcmp(workingStatus,working_9) 
        data_users(i,startColumn+8) = 1;
    elseif strcmp(workingStatus,working_10) 
        data_users(i,startColumn+9) = 1;
     elseif strcmp(workingStatus,working_11) 
        data_users(i,startColumn+10) = 1;
    elseif strcmp(workingStatus,working_12) 
        data_users(i,startColumn+11) = 1;
    elseif strcmp(workingStatus,working_13) 
        data_users(i,startColumn+12) = 1;      
    elseif strcmp(workingStatus,'')
        data_users(i,startColumn:endColumn) = constantMarker;
    else
        %error('Unexpected input value for Working Status in %d',i+1);
        fprintf('error in working status row %d \n',i+1);
        invalidCounter = invalidCounter + 1;
    end
    
    
    %------------------------------------------------------------------
    %Classify working region into 5 groups
    
    %starting column
    startColumn = endColumn + 1; 
    %no of classes
    nClasses = 5;
    %end column for region
    endColumn = startColumn + nClasses - 1;
    %initialize each cell by a 0
    data_users(i,startColumn:endColumn) = 0; 
    %region where users live
    region = data{i+1}{1}(5); 
    
    if strcmp(region,'North')
        data_users(i,startColumn) = 1;
    elseif strcmp(region,'Centre')
        data_users(i,startColumn+1) = 1;
    elseif strcmp(region,'Midlands')
        data_users(i,startColumn+2) = 1;
    elseif strcmp(region,'South')
        data_users(i,startColumn+3) = 1;
    elseif (strcmp(region,'Northern Ireland') ||...
        strcmp(region,'North Ireland'))
        data_users(i,startColumn+4) = 1;    
    elseif strcmp(region,'')
        data_users(i,startColumn:endColumn) = constantMarker;
    else
        %error('Unexpected input value for Region in %d',i+1);
        invalidCounter = invalidCounter + 1;
        fprintf('error in region row %d \n',i+1);
    end
    
    %--------------------------------------------------------------------
    %Classify user's response to importance of music in their life
    
    %no of classes
    nClasses = 6;
    %starting column
    startColumn = endColumn + 1;
    %end column for region
    endColumn = startColumn + nClasses - 1;
    %initialize each cell by a 0
    data_users(i,startColumn:endColumn) = 0; 
    %user's response
    users_reply = data{i+1}{1}(6);
    
    if strcmp(users_reply,importance_of_music_1)
        data_users(i,startColumn) = 1;
    elseif strcmp(users_reply,importance_of_music_2)
        data_users(i,startColumn+1) = 1;
    elseif strcmp(users_reply,importance_of_music_3)
        data_users(i,startColumn+2) = 1;
    elseif strcmp(users_reply,importance_of_music_4)
        data_users(i,startColumn+3) = 1;
    elseif strcmp(users_reply,importance_of_music_5)
        data_users(i,startColumn+4) = 1;
    elseif strcmp(users_reply,importance_of_music_6)
        data_users(i,startColumn+5) = 1;    
    elseif strcmp(users_reply,'')
        data_users(i,startColumn:endColumn) = -1;
    else
        %error('Unexpected input value for Importance of Music in %d',i+1);
        invalidCounter = invalidCounter + 1;
        fprintf('error in imp of music %d \n',i+1);
    end
    
    %---------------------------------------------------------------------
    %Classify the number of hours a user actively listens to music
    
    %no of classes
    nClasses = 20;
    %starting column
    startColumn = endColumn + 1;
    %end column
    endColumn = startColumn + nClasses - 1;
    %initialize each cell by a 0
    data_users(i,startColumn:endColumn) = 0; 
    %user's response
    activeListeningHours = data{i+1}{1}(7);
    
    %list_own
    if strcmp((activeListeningHours),'Less than an hour')
        data_users(i,startColumn) = 1;
        
    elseif strcmp((activeListeningHours),'1 hour') ||... 
            strcmp(activeListeningHours,'1')
        data_users(i,startColumn+1) = 1;
        
    elseif strcmp(activeListeningHours,'2 hours') ||... 
            strcmp(activeListeningHours,'2')
        data_users(i,startColumn+2) = 1;  
        
    elseif strcmp(activeListeningHours,'3 hours') ||... 
            strcmp(activeListeningHours,'3')
        data_users(i,startColumn+3) = 1;  
        
    elseif strcmp(activeListeningHours,'4 hours') ||... 
            strcmp(activeListeningHours,'4')
        data_users(i,startColumn+4) = 1;
        
    elseif strcmp(activeListeningHours,'5 hours') ||... 
            strcmp(activeListeningHours,'5')
        data_users(i,startColumn+5) = 1;
        
    elseif strcmp(activeListeningHours,'6 hours') ||... 
            strcmp(activeListeningHours,'6')
        data_users(i,startColumn+6) = 1;  
        
    elseif strcmp(activeListeningHours,'7 hours') ||... 
            strcmp(activeListeningHours,'7')
        data_users(i,startColumn+8) = 1;  
        
    elseif strcmp(activeListeningHours,'8 hours') ||... 
            strcmp(activeListeningHours,'8')
        data_users(i,startColumn+9) = 1;  
        
    elseif strcmp(activeListeningHours,'9 hours') ||... 
            strcmp(activeListeningHours,'9')
        data_users(i,startColumn+10) = 1;  
        
    elseif strcmp(activeListeningHours,'10 hours') ||... 
            strcmp(activeListeningHours,'10')
        data_users(i,startColumn+11) = 1;  
        
    elseif strcmp(activeListeningHours,'11 hours') ||... 
            strcmp(activeListeningHours,'11')
        data_users(i,startColumn+12) = 1; 
        
    elseif strcmp(activeListeningHours,'12 hours') ||... 
            strcmp(activeListeningHours,'12')
        data_users(i,startColumn+13) = 1;
        
    elseif strcmp(activeListeningHours,'13 hours') ||... 
            strcmp(activeListeningHours,'13')
        data_users(i,startColumn+14) = 1;
        
    elseif strcmp(activeListeningHours,'14 hours') ||... 
            strcmp(activeListeningHours,'14')
        data_users(i,startColumn+15) = 1;
        
    elseif strcmp(activeListeningHours,'15 hours') ||... 
            strcmp(activeListeningHours,'15')
        data_users(i,startColumn+16) = 1; 
        
    elseif strcmp(activeListeningHours,'16 hours') ||... 
            strcmp(activeListeningHours,'16')
        data_users(i,startColumn+17) = 1;
        
    elseif strcmp(activeListeningHours,'More than 16 hours') ||... 
            strcmp(activeListeningHours,'16+ hours')
        data_users(i,startColumn+18) = 1; 
    
    elseif strcmp(activeListeningHours,'0 Hours') ||... 
            strcmp(activeListeningHours,'0')
        data_users(i,startColumn+19) = 1;
        
    elseif strcmp(activeListeningHours,'') 
        data_users(i,startColumn:endColumn) = constantMarker; 
    else
        %error('Unexpected input value for Number of hours actively spent listenting to music in %d',i+1);
        invalidCounter = invalidCounter + 1;
        fprintf('error in active music listening, row %d',i+1);
        fprintf('replacing cell content with -1 \n');
        %replacing cell values with -1
        data_users(i,startColumn:endColumn) = constantMarker; 
    end
    
    %---------------------------------------------------------------------
    %Classify the number of hours a user listens to music in the background
    
    %no of classes
    nClasses = 21;
    %start column
    startColumn = endColumn+1;
    %end column
    endColumn = startColumn + nClasses - 1;
    %initialize each cell by a 0
    data_users(i,startColumn:endColumn) = 0; 
    %user's response
    passiveListeningHours = data{i+1}{1}(8);
    
    %list_own
    if strcmp(passiveListeningHours,'Less than an hour')
        data_users(i,startColumn) = 1;
            
    elseif strcmp(passiveListeningHours,'1 hour') ||... 
            strcmp(passiveListeningHours,'1')
        data_users(i,startColumn+1) = 1;
        
    elseif strcmp(passiveListeningHours,'2 hours') ||... 
            strcmp(passiveListeningHours,'2')
        data_users(i,startColumn+2) = 1;  
        
    elseif strcmp(passiveListeningHours,'3 hours') ||... 
            strcmp(passiveListeningHours,'3')
        data_users(i,startColumn+3) = 1;  
        
    elseif strcmp(passiveListeningHours,'4 hours') ||... 
            strcmp(passiveListeningHours,'4')
        data_users(i,startColumn+4) = 1;
        
    elseif strcmp(passiveListeningHours,'5 hours') ||... 
            strcmp(passiveListeningHours,'5')
        data_users(i,startColumn+5) = 1;
        
    elseif strcmp(passiveListeningHours,'6 hours') ||... 
            strcmp(passiveListeningHours,'6')
        data_users(i,startColumn+6) = 1;  
        
    elseif strcmp(passiveListeningHours,'7 hours') ||... 
            strcmp(passiveListeningHours,'7')
        data_users(i,startColumn+8) = 1;  
        
    elseif strcmp(passiveListeningHours,'8 hours') ||... 
            strcmp(passiveListeningHours,'8')
        data_users(i,startColumn+9) = 1;  
        
    elseif strcmp(passiveListeningHours,'9 hours') ||... 
            strcmp(passiveListeningHours,'9')
        data_users(i,startColumn+10) = 1;  
        
    elseif strcmp(passiveListeningHours,'10 hours') ||... 
            strcmp(passiveListeningHours,'10')
        data_users(i,startColumn+11) = 1;  
        
    elseif strcmp(passiveListeningHours,'11 hours') ||... 
            strcmp(passiveListeningHours,'11')
        data_users(i,startColumn+12) = 1; 
        
    elseif strcmp(passiveListeningHours,'12 hours') ||... 
            strcmp(passiveListeningHours,'12')
        data_users(i,startColumn+13) = 1;
        
    elseif strcmp(passiveListeningHours,'13 hours') ||... 
            strcmp(passiveListeningHours,'13')
        data_users(i,startColumn+14) = 1;
        
    elseif strcmp(passiveListeningHours,'14 hours') ||... 
            strcmp(passiveListeningHours,'14')
        data_users(i,startColumn+15) = 1;
        
    elseif strcmp(passiveListeningHours,'15 hours') ||... 
            strcmp(passiveListeningHours,'15')
        data_users(i,startColumn+16) = 1; 
        
    elseif strcmp(passiveListeningHours,'16 hours') ||... 
            strcmp(passiveListeningHours,'16')
        data_users(i,startColumn+17) = 1;
        
    elseif strcmp(passiveListeningHours,'More than 16 hours') ||... 
            strcmp(passiveListeningHours,'16+ hours')
        data_users(i,startColumn+18) = 1; 
    
    elseif strcmp(passiveListeningHours,'0 Hours') ||... 
            strcmp(passiveListeningHours,'0')
        data_users(i,startColumn+19) = 1;
    
    elseif strcmp(passiveListeningHours,'20 hours') ||... 
            strcmp(passiveListeningHours,'20')
        data_users(i,startColumn+20) = 1;
        
    elseif strcmp(passiveListeningHours,'') 
        data_users(i,startColumn:endColumn) = constantMarker; 
    else
        %error('Unexpected input value for Number of hours spent listenting to music in %d',i+1);
        invalidCounter = invalidCounter + 1;
        fprintf('error in passive music listening row %d, ',i+1);
        fprintf('replacing cell content with -1 \n')
        %replace cell values with -1
        data_users(i,startColumn:endColumn) = constantMarker; 
    end
    
    %---------------------------------------------------------------------
    %Scale user's response [0,100] t0 [0,1] for 
    
    %no of classes
    nClasses = N - 8 - 1; %N minus first 8 columns, minus the last column
    %starting column
    startColumn = endColumn + 1;
    %ending column
    endColumn = startColumn + nClasses - 1;
    %scaling factor
    sf = 100; 
    for j = startColumn : endColumn %was 9:N-1
        if ~strcmp((data{i+1}{1}(9+j-startColumn)),'')
            data_users(i,j) = (str2double(cell2mat(data{i+1}{1}(9+j-startColumn))))/sf;
        elseif strcmp((data{i+1}{1}(9+j-startColumn)),'')
            data_users(i,j) = constantMarker;
        else
            %error('Unexpected error in user answers in row %d',i+1)
            invalidCounter = invalidCounter + 1;
            fprintf('error in question answers, row %d, ',i+1);
            fprintf('so replacing cell content with -1 \n');
        end
    end
    
end



save('data_users','data_users')

