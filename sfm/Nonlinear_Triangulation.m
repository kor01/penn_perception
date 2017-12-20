function X = Nonlinear_Triangulation(K, C1, R1, C2, R2, C3, R3, x1, x2, x3, X0)
%% Nonlinear_Triangulation
% Refining the poses of the cameras to get a better estimate of the points
% 3D position
% Inputs: 
%     K - size (3 x 3) camera calibration (intrinsics) matrix
%     x
% Outputs: 
%     X - size (N x 3) matrix of refined point 3D locations 

epsilon = 1e-4;

rs = zeros([size(R1), 3]);
rs(:, :, 1) = R1; rs(:, :, 2) = R2; rs(:, :, 3) = R3;

cs = zeros([3, size(C1)]);
cs(:, 1) = C1; cs(:, 2) = C2; cs(:, 3) = C3;

sz = length(X0); X = zeros(sz, 3);

x1 = intrinsic_inverse(K, x1, true);
x2 = intrinsic_inverse(K, x2, true);
x3 = intrinsic_inverse(K, x3, true);

parfor i = 1:1:length(X0)
    
    x0 = X0(i, :);
    p2ds = zeros(2, 3);
    p2ds(:, 1) = x1(i, :); 
    p2ds(:, 2) = x2(i, :); 
    p2ds(:, 3) = x3(i, :);
    
    x = geometric_triangulation(rs, cs, p2ds, x0, epsilon, 1e-1);
    X(i, :) = x;
    
end

end
