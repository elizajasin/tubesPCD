function [Y] = sampling2(I,x)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    Y = I;
    for i = 1:size(I,1)
        for j = 1:x:size(I,2)
            for l = 0:x-1
                Y(i+l,j+l,:) = I(i,j,:);
                Y(i+l,j+l+1,:) = I(i,j,:);
                Y(i+l+1,j+l,:) = I(i,j,:);
                Y(i+l+1,j+l+1,:) = I(i,j,:);
            end
        end
    end
end