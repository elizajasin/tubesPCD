function [Y] = sampling(I)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    x = size(I);
    Y = I;
    for i = 1:x(1)
        for j = 6:4:x(2)
            if (mod(j,2) == 0)
                Y(i,j,1) = I(i,j-4,1);
                Y(i,j,2) = I(i,j-4,2);
                Y(i,j,3) = I(i,j-4,3);
            else
                Y(i,j,1) = I(i,j-5,1);
                Y(i,j,2) = I(i,j-5,2);
                Y(i,j,3) = I(i,j-5,3);
            end
        end
    end
end

