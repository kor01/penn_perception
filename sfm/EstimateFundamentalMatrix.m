function [F, FA] = EstimateFundamentalMatrix(x1, x2)
%% EstimateFundamentalMatrix
% Estimate the fundamental matrix from two image point correspondences 
% Inputs:
%     x1 - size (N x 2) matrix of points in image 1
%     x2 - size (N x 2) matrix of points in image 2, each row corresponding
%       to x1
% Output:
%    F - size (3 x 3) fundamental matrix with rank 2

gen = fundamental_mat_equation();

p = zeros(length(x1), 9);

for i = 1:1:length(x1)
    p(i, :) = gen(x1(i, :)', x2(i,:)');
end

p_size = size(p);

first = p(1, :)

[~, d, vt] = svd(p);

FA = vt(:, end); F = reshape(FA, [3 3]);

end