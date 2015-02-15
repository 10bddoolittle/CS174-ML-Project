function feat = mode_read(mode)

% determining which feature to group
if strcmp(mode,'artist') == 1
    feat = 1;
elseif strcmp(mode,'track') == 1
    feat = 2;
elseif strcmp(mode,'user') == 1
    feat = 3;
elseif strcmp(mode, 'rating' ) == 1
    feat = 4;
elseif strcmp(mode, 'time' ) == 1
    feat = 5;
else
    fprintf('incorrect mode \n');
    feat = 0;
end

end