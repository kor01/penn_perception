function [ fn ] = fundamental_mat_equation()
% deduce coefficient generator for fundamental mat from symbolic computation

persistent ret;

if ~isempty(ret)
    fn = ret;
    return
end

syms x11 x12 x21 x22;

x1 = [x11 x12 1]; x2 = [x21 x22 1];

fund_mat = sym('F%d', [3, 3]);

vars = fund_mat(:);

equation = x2 * fund_mat * x1';

coeff = coeffs(equation, vars);

fn = matlabFunction(coeff, 'Vars', [x11, x12, x21, x22]);

fn = @ (v1, v2) fn(v1(1), v1(2), v2(1), v2(2));

ret = fn;

end

