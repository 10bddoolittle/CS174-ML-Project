function error = rmse(pred_Y, correct_Y)

% Inputs:
% pred_Y:    [m x 1], vector of predicted track ratings
% correct_y: [m x 1], vector of correct track ratings

% Output:
% error:      scalar, root-mean-square-error

m = size(pred_Y,1);

error = sqrt((1/m)*sum((pred_Y - correct_Y).^2));

end