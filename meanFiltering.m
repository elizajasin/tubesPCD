function [X] = meanFiltering(I,D)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    A = fspecial('average',D);
    X = zeros(size(I));
    for i = 1:3
        X(:,:,i) = conv2(double(I(:,:,i)),double(A),'same');
    end
    X = uint8(X);
end

