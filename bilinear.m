%Example��˫�����ڲ巨
clear, clc
I = imread('image1.png');
Ip = imresize(I,5, 'bilinear');
imwrite(Ip, 'image2.jpg', 'quality', 100);
imshow(I)
figure, imshow(Ip)
