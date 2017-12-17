function [ fn ] = linear_pnp_equation()
% deduce linear pnp equation by symbolic

persistent ret;

if ~isempty(ret)
    fn = ret;
    return;
end

syms x y z u v;

p3d = [x y z 1]; p2d = [u v 1];

p = sym('P', [3 4]); vars = p(:);

equation = cross(p2d, p * p3d');

[coeffs1, vars1] = coeffs(equation(1), vars);
coeffs1 = sym_sp2dense(coeffs1, vars1, vars);

[coeffs2, vars2] = coeffs(equation(2), vars);
coeffs2 = sym_sp2dense(coeffs2, vars2, vars);

coeff = [coeffs1'; coeffs2'];

fn = matlabFunction(coeff, 'Vars', [x y z u v]);

fn = @(p2d, p3d) fn(p3d(1), p3d(2), p3d(3), p2d(1), p2d(2));

ret = fn;

end

