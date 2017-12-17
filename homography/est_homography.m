function [ H ] = est_homography(video_pts, logo_pts)
% est_homography estimates the homography to transform each of the
% video_pts into the logo_pts
% Inputs:
%     video_pts: a 4x2 matrix of corner points in the video
%     logo_pts: a 4x2 matrix of logo points that correspond to video_pts
% Outputs:
%     H: a 3x3 homography matrix such that logo_pts ~ H*video_pts
% Written for the University of Pennsylvania's Robotics:Perception course

% YOUR CODE HERE

%% generate coefficients

gen = homography_equation();

num_pairs = length(video_pts);
p = zeros(num_pairs * 2, 9);

for i = 1:1:num_pairs
    ret = gen(video_pts(i, :), logo_pts(i, :))';
    p(2 * i - 1, :) = ret(:, 1);
    p(2 * i, :) = ret(:, 2);
end

%% solve homogeneous equation
[~, ~, v] = svd(p);

H = reshape(v(:, end), [3 3]);


end
