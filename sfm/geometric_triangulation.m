function [p3d] = geometric_triangulation(rs, cs, p2ds, initial, epsilon)
% solve geometric triangulation by levenberg_marquardt

p3d = initial;

res, jacob, cur_loss = estimate_jacob(rs, cs, p2ds, p3d);

while true
    delta_x = (jacob' * jacob) \ (jacob * res);
    p3d = p3d - delta_x;
    res, jacob, new_loss = estimate_jacob(rs, cs, p2ds, p3d);
    if abs(new_loss - cur_loss) < epsilon
        break;
    end
    cur_loss = new_loss;
end

end

function [res, jacob, total_loss] = estimate_jacob(Rs, Cs, p2ds, p3d)

fn = geometric_res_loss_grad();

sz = length(Rs);
residues = zeros(sz, 1);
jacob = zeros(sz, 3);
total_loss = 0;

for i=1:1:sz
    R = Rs(i, :, :); C = Cs(i, :); p2d = p2ds(i, :);
    [res, loss, grad] = fn(p3d, p2d, R, C);
    residues(i) = res;
    total_loss = total_loss + loss;
    jacob(i, :) = grad;
end

end

function [fn] = geometric_res_loss_grad()

persistent ret;

if ~isempty(ret)
    fn = ret;
    return;
end

p3d = sym('p3d_%d', [3, 1], 'real');
p2d = sym('p2d_%d', [2, 1], 'real');
R = sym('R%d', [3, 3], 'real');
C = sym('C%d', [3, 1], 'real');

proj = R * p3d + C; proj = proj(1:2) /proj(3);

residue = proj - p2d;
loss = sum(residue' * residue);
grad = gradient(loss, p3d);

fn = matlabFunction(residue, loss, grad, 'Vars', {p3d, p2d, R, C});

ret = fn;

end
