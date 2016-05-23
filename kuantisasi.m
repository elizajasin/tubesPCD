function [Y] = kuantisasi(I,x)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    Y = I;
    for i = 1:size(I,1)
        for j = 1:size(I,2)
            for k = 1:3
                Y(i,j,k) = I(i,j,k) - mod(256-2^(8-round(x/3)),I(i,j,k));
            end
        end
    end
    Y = uint8(Y);
end

