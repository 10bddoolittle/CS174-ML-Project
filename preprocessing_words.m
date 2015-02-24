
fileID_words = fopen('words.csv');
formatSpec = '%s';
N = 88;

%read the first row
eof_status = feof(fileID_words);


mark = -1;

i = 0;
data = cell(1,118302);

tic;
%empty cell initialization
while eof_status ~= 1
    i = i + 1;
    data{i} = textscan(fileID_words,formatSpec,N,'delimiter',','); 
    eof_status = feof(fileID_words);
    if i == 120000
        break
    end
end
toc;
%close
fclose(fileID_words);


num_examples = size(data,2)-1;  % subtract 1 because top row is labels

num_cols = 94;

data_words = zeros(num_examples,num_cols);
fprintf( 'converting cell to matrix');

tic;

wrong_heard_of = 0;
wrong_own_artist_music = 0;
wrong_word = 0;

for i = 1:num_examples
    % Artits_id
    data_words(i,1) = str2double(cell2mat(data{i+1}{1}(1)));
    % user_id
    data_words(i,2) = str2double(cell2mat(data{i+1}{1}(2)));
    
    
    %Heard_of
    %(i,3) = 'Heard of'
    %(i,4) = 'Never Heard of'
    %(i,5) = 'Heard of and listened to music EVER'
    %(i,6) = 'Heard of and listened to music RECENTLY'
    %else = -1
    if strcmp(data{i+1}{1}(3),'Heard of') == 1
        data_words(i,3) = 1;
    elseif strcmp(data{i+1}{1}(3),'Never heard of')||strcmp(data{i+1}{1}(3),'Ever heard of') == 1
        data_words(i,4) = 1;
    elseif strcmp(data{i+1}{1}(3),'Heard of and listened to music EVER') == 1
        data_words(i,5) = 1;
    elseif strcmp(data{i+1}{1}(3),'Heard of and listened to music RECENTLY') == 1
        data_words(i,6) = 1;
    elseif strcmp(data{i+1}{1}(3), '') == 1
        data_words(i,3:6) = mark;
    else
        data_words(i,3:6) = mark;
        wrong_heard_of = wrong_heard_of + 1;
    end
    
    % Own_artist_music
    % (i,7) = 'DonÍt know'
    % (i,8) = 'Own none of their music'
    % (i,9) = 'Own a little of their music'
    % (i,10) = 'Own a lot of their music'
    % (i,11) = 'Own all or most of their music'
    % else -1
    if strcmp(data{i+1}{1}(4),'DonÍt know') == 1
        data_words(i,7) = 1;
    elseif strcmp(data{i+1}{1}(4),'Own none of their music') == 1
        data_words(i,8) = 1;
    elseif strcmp(data{i+1}{1}(4),'Own a little of their music') == 1
        data_words(i,9) = 1;
    elseif strcmp(data{i+1}{1}(4),'Own a lot of their music') == 1
        data_words(i,10) = 1;
    elseif strcmp(data{i+1}{1}(4),'Own all or most of their music') == 1
        data_words(i,11) = 1;
    elseif strcmp(data{i+1}{1}(4),'') == 1
        data_words(i,7:11) = mark;
    else 
        data_words(i,7:11) = mark;
        wrong_own_artist_music = wrong_own_artist_music + 1;   
    end
    
    % retrieving normalized values for like_artist
    % (i,12) = artist rating
    if strcmp(data{i+1}{1}(5),'') == 1
        data_words(i,12) = mark;
    else
        data_words(i,12) = str2double(cell2mat(data{i+1}{1}(5)));
    end
    
    





% 82 words {1 if used, 0 if unused, -1 if blank}
% (i,13:94)
    for j = 13:num_cols
        if strcmp(data{1+i}{1}(j-7),'1') == 1
            data_words(i,j) = 1;
        elseif strcmp(data{1+i}{1}(j-7),'0') == 1
            data_words(i,j) = 0;
        elseif strcmp(data{1+i}{1}(j-7),'') == 1
            data_words(i,j) = mark;
        else
            data_words(i,j) = mark;
            wrong_word = wrong_word + 1;
        end
        
    end
    
    
end




toc;

 
       
wrong_word
wrong_heard_of
wrong_own_artist_music

save('data_words','data_words')
