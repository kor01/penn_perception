function [idx] = sym_indexof(x, e)
%find index of symbolic element e in matrix x

idx = find(isAlways(x == e, 'Unknown', 'false'));

end
