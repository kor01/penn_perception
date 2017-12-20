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

x1 = intrinsic_inverse(K, x1, false);
x2 = intrinsic_inverse(K, x2, false);

% use the notation convention in projection model
R1 = R1'; R2 = R2';

sz = length(x1);

X = zeros([sz, 3]);

for i = 1:1:sz
    
    pt1 = x1(i, :); pt2 = x2(i, :);
    
    coeff1 = Vec2Skew(pt1) * R1';
    coeff2 = Vec2Skew(pt2) * R2';
    
    b1 = coeff1 * C1; b2 = coeff2 * C2;
    A = [coeff1(1:2, :); coeff2(1:2, :)];
    b = [b1(1:2); b2(1:2)];
    X(i, :) = (A'*A) \ (A' * b);
end
