function [delta_fn] = geometric_triangulation(Rs, Cs, p2ds)

sz = length(Rs);
losses = sym(zeros(sz, 1));

syms real x y z;

for i=1:1:sz
    R = Rs(i, :, :); C = Cs(i, :); p2d = p2ds(i, :);
    proj = R * [x, y, z]' + C;
    proj = proj / proj(3);
    residue = proj - p2d;
    losses(i) = sum(residue' * residue);
end

jacob = jacobian(losses, [x, y, z]);

end

function [grad, residue] = levenberg_marquardt(R, C, p2d, x, y, z)

proj = R * [x y z]' + C;

proj = proj / proj(3);

residue = proj - p2d;

grad = gradient(residue, [x, y, z]);

end