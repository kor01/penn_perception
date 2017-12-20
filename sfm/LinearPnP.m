function [C, R] = LinearPnP(X, x, K)
%% LinearPnP
% Getting pose from 2D-3D correspondences
% Inputs:
%     X - size (N x 3) matrix of 3D points
%     x - size (N x 2) matrix of 2D points whose rows correspond with X
%     K - size (3 x 3) camera calibration (intrinsics) matrix
% Outputs:
%     C - size (3 x 1) pose transation
%     R - size (3 x 1) pose rotation
%
% IMPORTANT NOTE: While theoretically you can use the x directly when solving
% for the P = [R t] matrix then use the K matrix to correct the error, this is
% more numeically unstable, and thus it is better to calibrate the x values
% before the computation of P then extract R and t directly

gen = linear_pnp_equation();

p = zeros(length(x) * 2, 12);

x = intrinsic_inverse(K, x, true);

for i = 1:1:length(x)
    p(2*i - 1: 2*i, :) = gen(X(i, :), x(i, :));
end

[~, ~, vt] = svd(p); rc = reshape(vt(:, end), [3, 4]);

R = rc(:, 1:3); C = rc(:, end);

[u, d, vt] = svd(R); max_val = d(1, 1);

R = u * vt'; sign = det(R);

R = R * sign; C = (C / max_val) * sign;


end