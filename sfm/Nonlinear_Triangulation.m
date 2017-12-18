function X = Nonlinear_Triangulation(K, C1, R1, C2, R2, C3, R3, x1, x2, x3, X0)
%% Nonlinear_Triangulation
% Refining the poses of the cameras to get a better estimate of the points
% 3D position
% Inputs: 
%     K - size (3 x 3) camera calibration (intrinsics) matrix
%     x
% Outputs: 
%     X - size (N x 3) matrix of refined point 3D locations 

[loss1, grad1] = geometric_triangulation_equation(R1, C1);

[loss2, grad2] = geometric_triangulation_equation(R2, C2);

[loss3, grad3] = geometric_triangulation_equation(R3, C3);

epsilon = 1e-4;

for i = 1:1:length(X0)
    
    
    
end


end


function optimize_levenberg_marquardt(
loss1, grad1, loss2, grad2, loss3, grad3, x0, epsilon):
    
loss_value = (loss1(x0) + loss2(x0) + loss3(x0)) / 3;

while true
    
    grad_val = (grad1(x0) + grad2(x0) + grad3(x0)) / 3;
    lr = ()(grad_val' * grad_val)
    
    break;
end


end

function multiple_eval(x, fns, dim):

    for i=1:1:length(fns):
        

end