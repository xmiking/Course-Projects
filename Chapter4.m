
%function PicOut=Lap_edge(PicInput,thresh)           
ii=imread('Premier Zhou.jpg');
f=rgb2gray(img);            
PicInput=im2double(f);
imshow(PicInput);

 
% 一，原图像预处理，读入黑白图片并确定长和宽
[m,n]=size(PicInput);                            %确定图片的长和宽

% 二，拉普拉斯变换预处理，定义镜框矩阵和输出矩阵
r=m+2;                                           %把图片的长和宽各加2
c=n+2;
PicFrame=zeros(r,c);                             %定义二维数组“PicFrame”，长、宽比“Input”各多2，成为镜框的尺寸
b=zeros(m,n);                                    %定义滤波后的数组

% 三，拉普拉斯运算的三个矩阵
Temp=zeros(3);                                   %定义三阶方阵“Temp”，为临时矩阵
op=[0 -1 0;-1 4 -1;0 -1 0];                      %定义拉普拉斯算子
Result=zeros(3);                                 %定义三阶方阵“Result”，为运算结果矩阵

% 四，原图像矩阵处理，做一个“像框”                                   
                                                  %把原图的矩阵放到新的矩阵“PicFrame”中心，它的第一行、最后一行、第一列、
 PicFrame(2:m+1,2:n+1)=PicInput;                  %最后一列都是“0”，即原图矩阵周围有一圈“0”的边缘，好像给图像加一个像框

PicFrame(1,:)=PicFrame(2,:);                     %把第二行的值赋给第一行
PicFrame(r,:)=PicFrame(r-1,:);                   %把倒数第二行的值赋给最后一行
PicFrame(:,1)=PicFrame(:,2);                     %把第二列的值赋给第一列
PicFrame(:,c)=PicFrame(:,c-1);                   %把倒数第二列的值赋给最后一列
%figure,imshow(PicFrame,[]);
% 五，用拉普拉斯算子进行滤波
for i=1:m
    for j=1:n
        Temp=PicFrame(i:i+2,j:j+2);             %从“PicFrame”矩阵中依次取出三阶方阵，赋值给临时矩阵“Temp”
        Result=Temp.*op;                        %临时矩阵与拉普拉斯算子“点乘”，赋值给结果矩阵“Result”
        b(i,j)=sum(sum(Result));   
                                                %结果矩阵中“十”字线上元素相加，赋值给输出矩阵中相应的位置，
                                                %即临时矩阵中心元素所对应的位
    end
end
figure,imshow(b);
PicR=zeros(r,c);  
for i=1:m
    for j=1:n                    
        PicR(i,j)=b(i,j)+ PicInput(i,j);                                      
    end
end
figure,imshow(PicR,[]);
%J=imadjust(PicR,[0.3 0.7],[]);
%figure,imshow(J,[]);
