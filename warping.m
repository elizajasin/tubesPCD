function [A] = warping(I)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    tform = maketform('affine', [1 0 0; .5 1 0; 0 0 1]);
    A = imtransform(I, tform);

end

