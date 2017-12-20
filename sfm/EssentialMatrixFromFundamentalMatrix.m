function [E] = EssentialMatrixFromFundamentalMatrix(F, K)
%% EssentialMatrixFromFundamentalMatrix
% Use the camera calibration matrix to esimate the Essential matrix
% Inputs:
%     K - size (3 x 3) camera calibration (intrinsics) matrix
%     F - size (3 x 3) fundamental matrix from EstimateFundamentalMatrix
% Outputs:
%     E - size (3 x 3) Essential matrix with singular values (1,1,0)


E = K' * F * K;

[u, d, vt] = svd(E);

d(1,1) = 1; d(2, 2) = 1; d(3, 3) = 0;

E = u * d * vt';


end
