function [proj_points, t, R] = ar_cube(H, render_points, K)
%% ar_cube
% Estimate your position and orientation with respect to a set of 4 points on the ground
% Inputs:
%    H - the computed homography from the corners in the image
%    render_points - size (N x 3) matrix of world points to project
%    K - size (3 x 3) calibration matrix for the camera
% Outputs: 
%    proj_points - size (N x 2) matrix of the projected points in pixel
%      coordinates
%    t - size (3 x 1) vector of the translation of the transformation
%    R - size (3 x 3) matrix of the rotation of the transformation
% Written by Stephen Phillips for the Coursera Robotics:Perception course

% YOUR CODE HERE: Extract the pose from the homography

% YOUR CODE HERE: Project the points using the pose


x1 = H(:, 1);
x_norm = norm(x1);
x1 = x1 / x_norm;

y1 = H(:, 2);
y1 = y1 / x_norm;

z1 = cross(x1, y1);

R1 = [x1, y1, z1];
t1 = H(:, 3) / x_norm;

R2 = [-x1, -y1, z1];
t2 = -t1;

if t1(3) > 0
    R = R1;
    t = t1;
else
    R = R2;
    t = t2;
end

render_pts =  K * (R * render_points' + t);
proj_points = render_pts ./ render_pts(3, :);
proj_points = proj_points(1:2, :)';


end
