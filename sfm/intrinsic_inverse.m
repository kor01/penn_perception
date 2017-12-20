function [xout] = intrinsic_inverse(k, xin, homo)
% apply inverse intrinsic transform of a camera

xin = [xin, ones(length(xin), 1)];

xout = k \ xin';

xout = xout'; 

if homo
    xout = xout ./ xout(:, 3);
    xout = xout(:, 1:2);
end

end
