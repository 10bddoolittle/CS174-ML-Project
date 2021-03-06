function [pred_y,coldStart_idx,newUser_idx,newTrack_idx,warmStart_idx] = MFpredict(T,Xtest,U,Tidx,Aidx,AUidx,UserProf,WordProf,ArtistProf,Utrainidx,Ttrainidx)

% predicts rating for new set of users

% INPUT 
% theta     [k,n]  k feature weights for each track
% Xtest     examples to be predicted 
% U         [m,k] m user profiles with k features each

% OUTPUT
% pred_y    predicted track rating of user

[m,n] = size(Xtest);

pred_y = zeros(m,1);

% user track combo to predict
predU = Xtest(:,3);
predT = Xtest(:,2);
predA = Xtest(:,1);

[nUser,nFeatures] = size(U);
[~,nTracks] = size(T);

coldStart_idx = 0;
newUser_idx = 0;
newTrack_idx = 0;
warmStart_idx = 0;


count = 0;
cold_it = 1;
new_track_it = 1;
new_user_it = 1;
warm_it = 1;
% for each example in Xtest
fprintf('in MFpredict now.. \n');
for i = 1:m
    %i
    %m
    % Findig User, Track, and Artist id's
    uidx = predU(i)+1;
    tidx = predT(i)+1;
    aidx = predA(i)+1;
    
    %idx = Markidx{uidx};
    
    % Cold start case logic
    if U(uidx,:)*U(uidx,:)' == 0
        
        %unknown user, unknown track
        if T(:,tidx)'*T(:,tidx) == 0
            coldStart_idx(cold_it) = i;
            cold_it = cold_it + 1;
            %reference
            % fxn call parameters: (uidx,aidx,tidx,U,T,Tidx{tidx},Aidx{aidx},Aidx,AUidx{aidx},AUidx,UserProf,WordProf,ArtistProf,'option2',count);          
            fprintf('U,T = 0, calling find_usertrack_latent \n');
            %[Ul,Tl,count] = find_usertrack_latent(uidx,aidx,tidx,U,T,Aidx,AUidx,Tidx,UserProf,WordProf,ArtistProf,Utrainidx,Ttrainidx,count);
            Ul = find_user_latent(uidx,Tidx,U,UserProf,'correlatedUser',Utrainidx);
            Tl = find_track_latent(aidx, T, 'average',ArtistProf,Aidx);
            correctionFactor = -20;
        
        %unknown user, known track    
        else
            newUser_idx(new_user_it) = i;
            new_user_it = new_user_it + 1;
            fprintf('U =0, T ~= 0, calling find_user_latent \n');
            Ul = find_user_latent(uidx,Tidx{tidx},U,UserProf,'correlatedUser',Utrainidx);                
            Tl = T(:,tidx);
            correctionFactor = 0;
        end
    
    else   
        %known user, unknown track
        if T(:,tidx)'*T(:,tidx) == 0
            newTrack_idx(new_track_it) = i;
            new_track_it = new_track_it + 1;
            fprintf('U ~= 0, T = 0, calling find_track_latent \n');
            Tl = find_track_latent(aidx,T,'average',ArtistProf,Aidx);
            Ul = U(uidx,:);
            correctionFactor = 0;
        %known user, known track
        else
            warmStart_idx(warm_it) = i;
            warm_it = warm_it + 1;
            fprintf('Known U, known T, calculating the rating \n');
            Tl = T(:,tidx);
            Ul = U(uidx,:);
            correctionFactor = 0;
        end
    end
    

    % making prediction
    pred_y(i) = Ul*Tl + correctionFactor; 
 
       
    % Limiting values to 0 to 100
    if pred_y(i) < 0
        pred_y(i) = 0;
    elseif pred_y(i) > 100
        pred_y(i) = 100;

    end
    
end




end