function [fn] = fundamental_mat_equation()
% deduce coefficient generator for fundamental mat from symbolic computation

x2 = sym('x2_%d', [2, 1], 'real');
x1 = sym('x1_%d', [2, 1], 'real');
fund_mat = sym('F%d', [3, 3], 'real');

vars = fund_mat(:);

size([x2', 1])
size([x1; 1])

x2_homo = [x2; 1];
x1_homo = [x1; 1];

equation = x2_homo' * fund_mat * x1_homo

[coeff, vs] = coeffs(equation, vars);

vs

fn = matlabFunction(coeff, 'Vars', {x1, x2});

eq_fn = matlabFunction(equation, 'Vars', {x1, x2, vars});

end

