function [ fun ] = homography_equation()
% deduce homography coefficients returns a compiled function

persistent generator;

if ~isempty(generator)
    fun = generator;
    return
end

syms x1 x2 y1 y2 real;

x = [x1, x2, 1]; 

y = [y1, y2, 1];

homo = sym('H%d', [3, 3], 'real');

vars = homo(:);

equation = expand(cross(y', homo * x'));

[coeffs1, vars1] = coeffs(equation(1), vars);

coeffs1 = sym_sp2dense(coeffs1, vars1, vars);

[coeffs2, vars2] = coeffs(equation(2), vars);

coeffs2 = sym_sp2dense(coeffs2, vars2, vars);

homo_coeff = [coeffs1'; coeffs2'];
gen = matlabFunction(homo_coeff);

generator = @(x, y) gen(x(1), x(2), y(1), y(2));
fun = generator;

end
