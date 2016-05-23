function G = segmen(I,n)

% Load image
I = imread('l.jpg');

% Bikin matriks zero
putih = uint8(zeros(size(I)));
hijau = uint8(zeros(size(I)));
kuning = uint8(zeros(size(I)));
merah = uint8(zeros(size(I)));
ungu = uint8(zeros(size(I)));

% Ambil warnanya
for i = 1:size(I,1)
    for j = 1:size(I,2)
        if ((I(i,j,1) == 204) && (I(i,j,2) == 0) && (I(i,j,3) == 0))
            merah(i,j,:) = I(i,j,:);
        end
        if ((I(i,j,1) == 155) && (I(i,j,2) == 255) && (I(i,j,3) == 5))
            hijau(i,j,:) = I(i,j,:);
        end
        if ((I(i,j,1) == 255) && (I(i,j,2) == 204) && (I(i,j,3) == 0))
            kuning(i,j,:) = I(i,j,:);
        end
        if ((I(i,j,1) == 102) && (I(i,j,2) == 51) && (I(i,j,3) == 153))
            ungu(i,j,:) = I(i,j,:);
        end
        if ((I(i,j,1) >= 210) && (I(i,j,2) >= 210) && (I(i,j,3) >= 210))
            putih(i,j,:) = I(i,j,:);
        end
    end
end

switch n
    case 1
        G = putih;
    case 2
        G = hijau;
    case 3
        G = ungu;
    case 4
        G = kuning;
    otherwise
        G = merah;
end