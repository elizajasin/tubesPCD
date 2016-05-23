function [OUT] = HistRGB(I)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    for i = 1:3
        I(:,:,i) = HistGray(I(:,:,i));
    end
    OUT = uint8(I);
end

