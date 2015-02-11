
fileID_words = fopen('words.csv');
formatSpec = '%s';
N = 88;

%read the first row
eof_status = feof(fileID_words);




i = 0;
data = cell(1,118302);

%empty cell initialization
while eof_status ~= 1
    i = i + 1;
    data{i} = textscan(fileID_words,formatSpec,N,'delimiter',','); 
    eof_status = feof(fileID_words);
    if i == 120000
        break
    end
end

%close
fclose(fileID_words);


num_examples = size(data,2)-1;  % subtract 1 because top row is labels

data_words = zeros(num_examples,N-1);
fprintf( 'converting cell to matrix');

% inputting the artist and user id as integers
for i = 1:num_examples
    % Artis_id
    data_words(i,1) = str2double(cell2mat(data{i+1}{1}(1)));
    % user_id
    data_words(i,2) = str2double(cell2mat(data{i+1}{1}(2)));
    
    % retrieving normalized values for like_artist
    if strcmp(data{i+1}{1}(5),'') == 1
        data_words(i,5) = -1;
    else
        data_words(i,5) = str2double(cell2mat(data{i+1}{1}(5)))/100;
    end
end

wrong_heard_of = 0;
wrong_own_artist_music = 0;

for i = 1:num_examples
    %Heard_of
    if strcmp(data{i+1}{1}(3),'Heard of') == 1
        data_words(i,3) = 1;
    elseif strcmp(data{i+1}{1}(3),'Never heard of')||strcmp(data{i+1}{1}(3),'Ever heard of') == 1
        data_words(i,3) = 2;
    elseif strcmp(data{i+1}{1}(3),'Heard of and listened to music EVER') == 1
        data_words(i,3) = 4;
    elseif strcmp(data{i+1}{1}(3),'Heard of and listened to music RECENTLY') == 1
        data_words(i,3) = 8;
    elseif strcmp(data{i+1}{1}(3), '') == 1
        data_words(i,3) = 0;
    else
        data_words(i,3) = 0;
        wrong_heard_of = wrong_heard_of + 1;
    end
    
    % Own_artist_music
    if strcmp(data{i+1}{1}(4),'DonÍt know') == 1
        data_words(i,4) = 1;
    elseif strcmp(data{i+1}{1}(4),'Own none of their music') == 1
        data_words(i,4) = 2;
    elseif strcmp(data{i+1}{1}(4),'Own a little of their music') == 1
        data_words(i,4) = 4;
    elseif strcmp(data{i+1}{1}(4),'Own a lot of their music') == 1
        data_words(i,4) = 8;
    elseif strcmp(data{i+1}{1}(4),'Own all or most of their music') == 1
        data_words(i,4) = 16;
    elseif strcmp(data{i+1}{1}(4),'') == 1
        data_words(i,4) = 0;
    else 
        data_words(i,4) = 0;
        wrong_own_artist_music = wrong_own_artist_music + 1;   
    end
end

wrong_word = 0;

% words {1 if used, -1 if unused, 0 if blank}
for i = 1:num_examples
    for j = 6:(N-1)
        if strcmp(data{1+i}{1}(j),'1') == 1
            data_words(i,j) = 1;
        elseif strcmp(data{1+i}{1}(j),'0') == 1
            data_words(i,j) = -1;
        elseif strcmp(data{1+i}{1}(j),'') == 1
            data_words(i,j) = 0;
        else
            data_words(i,j) = 0;
            wrong_word = wrong_word + 1;
        end
        
    end
end
 
       
wrong_word
wrong_heard_of
wrong_own_artist_music

save('data_words','data_words')
