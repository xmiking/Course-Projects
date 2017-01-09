clear, clc
 
f = imread('Girl_noise.jpg');
subplot(2,2,1), imshow(f)
 
fs = rgb2gray(f);
 
g = medfilt2(fs,[3 3]);
subplot(2,2,2), imshow(g)
 
gms = ordfilt2(g, 1, ones(3,3));  %��Сֵ���
subplot(2,2,3), imshow(gms)

gm = medfilt2(gms,[5 5]); %��Сֵ���֮������5*5�˲�����ֵ�˲�
subplot(2,2,4), imshow(gm)
