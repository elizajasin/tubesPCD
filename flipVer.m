function [Y] = flipVer(I)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
    x = size(I);
    Y = I;
    k = x(1);
    for i = 1:x(1)
        for j = 1:x(2)
            Y(k,j,:) = I(i,j,:);
        end
        k = k-1;
    end
end

