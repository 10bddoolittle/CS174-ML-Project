function pred_y = prediction(B,theta)

% Input:
% B:            [l x 4], feature matrix
% theta:        [l x 4], scalar of optimized weights

% for vector theta
%pred_y = B*theta';

% for matrix theta
pred_y = sum(B.*theta,2);

end