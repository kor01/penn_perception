function [ dense_coeff ] = sym_sp2dense( coeffs, vars, allvars )
%SYM_SP2DENSE Summary of this function goes here
%   Detailed explanation goes here

dense_coeff = sym(zeros(size(allvars)));

for i=1:length(vars)
    var = vars(i);
    coeff = coeffs(i);
    idx = sym_indexof(var, allvars);
    if length(idx) == 1
        dense_coeff(idx) = coeff;
    end    
end

end
