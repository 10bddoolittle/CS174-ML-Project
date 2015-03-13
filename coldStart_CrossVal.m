function Atrain = coldStart_CrossVal()
% Performs a cross validation on a set containing specified cold start case

% INPUTS
% case:       str  represents cold case to test 'newUser', 'newTrack',
%                     'newArtist', 'cold' 



% OUTPUTS


% loading data
data_train = load('data_train.mat');
data_users = load('data_users.mat');
data_words = load('data_words.mat');

% getting initial sets
Xtrain = data_train.train;
UserProf = data_users.data_users;
WordProf = data_words.data_words;

[m,n] = size(Xtrain);

mxA = max(Xtrain(:,1));
mxT = max(Xtrain(:,2));
mxU = max(Xtrain(:,3));

itA = ones(1,mxA + 1);
Atrain = cell(1,mxA + 1);

for i = 1:m
    At = Xtrain(i,1) + 1;
    Atrain{At}(itA(At)) = i;
    itA(At) = itA(At) + 1;   
end
    


% TODO: Split each artist set into folds of tracks. Grouping by time may be
% easiest. 

% TODO: Split into sets of each user










end