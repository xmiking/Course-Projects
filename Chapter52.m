clc
%******************读入图片***********************************
g = im2double(imread('Invoice_distortion1.jpg'));
[hei,wid,~] = size(g);
g=rgb2gray(g);
%imshow(g);

%*******************图片的移动角度*************************************
img_fft=fftshift(fft2(g));  %将fft后频域DC分量移到频谱中间
N=abs(img_fft);         %绝对值
P=(N-min(min(N)))/(max(max(N))-min(min(N)))*225;   %角度为y+夹角
%figure;imshow(P);
%******************移动长度***************************************
h=fspecial('sobel');
img_double=double(g);
J=conv2(img_double,h,'same');
IP=abs(fft2(J));
S=fftshift(real(ifft2(IP)));
%figure;plot(S);
%********************做完motion的图片叫img3*****************************
%PSF = fspecial('motion',10,5);     
%img2=deconvlucy(g,PSF,10);     
PSF = fspecial('motion',15,5);      %建立扩散子，其中len是模糊长度，ang是模糊角度
img3=deconvlucy(g,PSF,10);          %用lucy-richardson方法复原图像，其中img是运动模糊图像，PSF是扩散子，n是迭代次数，img2是复原图像
subplot(1,2,1);imshow(g);
title('原图');
%subplot(1,2,1);imshow(img3);
%title('去除移动模糊');



%********************1平均滤波*****************************

% K1=filter2(fspecial('average',3),img3); %模板尺寸为3
% subplot(1,2,2);imshow(K1);
% title('改进后的图像-average');
% ********************2自适应滤波***************************
 K3=wiener2(img3,[3 3]); %对加噪图像进行二维自适应维纳滤波
%  subplot(1,2,1);imshow(K3);
%  title('恢复图像-wiener');
 %*******************3中值滤波****************************
%  K4=medfilt2(img3);
%  subplot(1,2,2);imshow(K4);
%  title('recover image-middle');
 %******************4中间段灰度拉伸**********************
%hist_im=imhist(K4);           %计算直方图
%bar(hist_im);                 %画灰度直方图
% K5p=imadjust(K4,[80/255 100/255],[70/255 80/255]);
% K5=K4+K5p;
% subplot(1,2,2);imshow(K5);
% 
% img_fft2=fftshift(fft2(K4));  %将fft后频域DC分量移到频谱中间
% N2=abs(img_fft2);         %绝对值
% P2=(N-min(min(N2)))/(max(max(N2))-min(min(N2)))*225;   %角度为y+夹角
% figure;imshow(P2);
%********************取一小块均匀图，判断噪声类型**********************
% s=imread('S.jpg');
% s=rgb2gray(s);
% sim=imhist(s);           %计算直方图
% bar(sim);                 %画灰度直方图
%********************去除高斯噪声******************************

%将灰度图像的二维不连续Frourier变换的零频率成分移到频谱的中心
s=fftshift(fft2(K3));
[M,N]=size(s);                     %分别返回s的行数到M中，列数到N中
n=2;                                  %对n赋初值） 
d0=100;                                %初始化d0
n1=floor(M/2);                          %对M/2进行取整
n2=floor(N/2);                           %对N/2进行取整
for i=1:M 
    for j=1:N
        d=sqrt((i-n1)^2+(j-n2)^2);         %点（i,j）到傅立叶变换中心的距离
               h=1*exp(-1/2*(d^2/d0^2));  %GLPF滤波函数
        s(i,j)=h*s(i,j);                   %GLPF滤波后的频域表示
    end
end
s=ifftshift(s);                           %对s进行反FFT移动

s=real(ifft2(s));                                    
 subplot(1,2,2);imshow(s);
title('d0=100');                %为经GLPF滤波后的图像添加标题










