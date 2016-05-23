function HighPassFiltering(I)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    Gray = rgb2gray(I);
%     Gray = im2bw(I);
    figure,
    subplot(3,2,1); imshow(I); title('Original');
    subplot(3,2,2); imshow(Gray); title('Grayscale');
    subplot(3,2,3); imshow(edge(Gray,'Roberts')); title('Roberts');
    subplot(3,2,4); imshow(edge(Gray,'Prewitt')); title('Prewitt');
    subplot(3,2,5); imshow(edge(Gray,'Sobel')); title('Sobel');
    subplot(3,2,6); imshow(edge(Gray,'log')); title('Laplace');

end

