clc
%******************����ͼƬ***********************************
g = im2double(imread('Invoice_distortion1.jpg'));
[hei,wid,~] = size(g);
g=rgb2gray(g);
%imshow(g);

%*******************ͼƬ���ƶ��Ƕ�*************************************
img_fft=fftshift(fft2(g));  %��fft��Ƶ��DC�����Ƶ�Ƶ���м�
N=abs(img_fft);         %����ֵ
P=(N-min(min(N)))/(max(max(N))-min(min(N)))*225;   %�Ƕ�Ϊy+�н�
%figure;imshow(P);
%******************�ƶ�����***************************************
h=fspecial('sobel');
img_double=double(g);
J=conv2(img_double,h,'same');
IP=abs(fft2(J));
S=fftshift(real(ifft2(IP)));
%figure;plot(S);
%********************����motion��ͼƬ��img3*****************************
%PSF = fspecial('motion',10,5);     
%img2=deconvlucy(g,PSF,10);     
PSF = fspecial('motion',15,5);      %������ɢ�ӣ�����len��ģ�����ȣ�ang��ģ���Ƕ�
img3=deconvlucy(g,PSF,10);          %��lucy-richardson������ԭͼ������img���˶�ģ��ͼ��PSF����ɢ�ӣ�n�ǵ���������img2�Ǹ�ԭͼ��
subplot(1,2,1);imshow(g);
title('ԭͼ');
%subplot(1,2,1);imshow(img3);
%title('ȥ���ƶ�ģ��');



%********************1ƽ���˲�*****************************

% K1=filter2(fspecial('average',3),img3); %ģ��ߴ�Ϊ3
% subplot(1,2,2);imshow(K1);
% title('�Ľ����ͼ��-average');
% ********************2����Ӧ�˲�***************************
 K3=wiener2(img3,[3 3]); %�Լ���ͼ����ж�ά����Ӧά���˲�
%  subplot(1,2,1);imshow(K3);
%  title('�ָ�ͼ��-wiener');
 %*******************3��ֵ�˲�****************************
%  K4=medfilt2(img3);
%  subplot(1,2,2);imshow(K4);
%  title('recover image-middle');
 %******************4�м�λҶ�����**********************
%hist_im=imhist(K4);           %����ֱ��ͼ
%bar(hist_im);                 %���Ҷ�ֱ��ͼ
% K5p=imadjust(K4,[80/255 100/255],[70/255 80/255]);
% K5=K4+K5p;
% subplot(1,2,2);imshow(K5);
% 
% img_fft2=fftshift(fft2(K4));  %��fft��Ƶ��DC�����Ƶ�Ƶ���м�
% N2=abs(img_fft2);         %����ֵ
% P2=(N-min(min(N2)))/(max(max(N2))-min(min(N2)))*225;   %�Ƕ�Ϊy+�н�
% figure;imshow(P2);
%********************ȡһС�����ͼ���ж���������**********************
% s=imread('S.jpg');
% s=rgb2gray(s);
% sim=imhist(s);           %����ֱ��ͼ
% bar(sim);                 %���Ҷ�ֱ��ͼ
%********************ȥ����˹����******************************

%���Ҷ�ͼ��Ķ�ά������Frourier�任����Ƶ�ʳɷ��Ƶ�Ƶ�׵�����
s=fftshift(fft2(K3));
[M,N]=size(s);                     %�ֱ𷵻�s��������M�У�������N��
n=2;                                  %��n����ֵ�� 
d0=100;                                %��ʼ��d0
n1=floor(M/2);                          %��M/2����ȡ��
n2=floor(N/2);                           %��N/2����ȡ��
for i=1:M 
    for j=1:N
        d=sqrt((i-n1)^2+(j-n2)^2);         %�㣨i,j��������Ҷ�任���ĵľ���
               h=1*exp(-1/2*(d^2/d0^2));  %GLPF�˲�����
        s(i,j)=h*s(i,j);                   %GLPF�˲����Ƶ���ʾ
    end
end
s=ifftshift(s);                           %��s���з�FFT�ƶ�

s=real(ifft2(s));                                    
 subplot(1,2,2);imshow(s);
title('d0=100');                %Ϊ��GLPF�˲����ͼ����ӱ���










