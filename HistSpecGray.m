function [Y] = HistSpecGray(I,T)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    H = HistGray(I);
    Histspec = zeros(256,1);
    Invhist = zeros(256,1);
    for i = 1:256
        jum = 0;
        for j = 1:i
            jum = jum + T(j);
        end
        Histspec(i) = round(255*jum);
    end
    for i = 0:255
        minval = abs(i-Histspec(1));
        minj = 0;
        for j = 0:255
            if (abs(i-Histspec(j+1)) < minval)
                minval = abs(i-Histspec(j+1));
                minj = j;
            end
            Invhist(i+1) = minj;
        end
    end
    for x = 1:size(I,1)
        for y = 1:size(I,2)
            I(i,j) = Invhist(I(i,j)+1);
        end
    end
    Y = uint8(I);
end

