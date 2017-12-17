function X = LinearTriangulation(K, C1, R1, C2, R2, x1, x2)
%% LinearTriangulation
% Find 3D positions of the point correspondences using the relative
% position of one camera from another
% Inputs:
%     C1 - size (3 x 1) translation of the first camera pose
%     R1 - size (3 x 3) rotation of the first camera pose
%     C2 - size (3 x 1) translation of the second camera
%     R2 - size (3 x 3) rotation of the second camera pose
%     x1 - size (N x 2) matrix of points in image 1
%     x2 - size (N x 2) matrix of points in image 2, each row corresponding
%       to x1
% Outputs: 
%     X - size (N x 3) matrix whos rows represent the 3D triangulated
%       points

inv_kt = inv(K');

x1 = x1 * inv_kt; x2 = x2 * inv_kt;

coeff1 = Vec2Skew(x1) * R1'; coeff1 = coeff1(1:2, :);
coeff2 = Vec2Skew(x2) * R2'; coeff2 = coeff2(1:2, :);

b1 = R1'*C1; b2 = R2'*C2;

A = [coeff1; coeff2];

X = (A'*A) \ (A' * [b1; b2]);

