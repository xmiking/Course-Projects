
%function PicOut=Lap_edge(PicInput,thresh)           
ii=imread('Premier Zhou.jpg');
f=rgb2gray(img);            
PicInput=im2double(f);
imshow(PicInput);

 
% һ��ԭͼ��Ԥ��������ڰ�ͼƬ��ȷ�����Ϳ�
[m,n]=size(PicInput);                            %ȷ��ͼƬ�ĳ��Ϳ�

% ����������˹�任Ԥ�������徵�������������
r=m+2;                                           %��ͼƬ�ĳ��Ϳ����2
c=n+2;
PicFrame=zeros(r,c);                             %�����ά���顰PicFrame����������ȡ�Input������2����Ϊ����ĳߴ�
b=zeros(m,n);                                    %�����˲��������

% ����������˹�������������
Temp=zeros(3);                                   %�������׷���Temp����Ϊ��ʱ����
op=[0 -1 0;-1 4 -1;0 -1 0];                      %����������˹����
Result=zeros(3);                                 %�������׷���Result����Ϊ����������

% �ģ�ԭͼ���������һ�������                                   
                                                  %��ԭͼ�ľ���ŵ��µľ���PicFrame�����ģ����ĵ�һ�С����һ�С���һ�С�
 PicFrame(2:m+1,2:n+1)=PicInput;                  %���һ�ж��ǡ�0������ԭͼ������Χ��һȦ��0���ı�Ե�������ͼ���һ�����

PicFrame(1,:)=PicFrame(2,:);                     %�ѵڶ��е�ֵ������һ��
PicFrame(r,:)=PicFrame(r-1,:);                   %�ѵ����ڶ��е�ֵ�������һ��
PicFrame(:,1)=PicFrame(:,2);                     %�ѵڶ��е�ֵ������һ��
PicFrame(:,c)=PicFrame(:,c-1);                   %�ѵ����ڶ��е�ֵ�������һ��
%figure,imshow(PicFrame,[]);
% �壬��������˹���ӽ����˲�
for i=1:m
    for j=1:n
        Temp=PicFrame(i:i+2,j:j+2);             %�ӡ�PicFrame������������ȡ�����׷��󣬸�ֵ����ʱ����Temp��
        Result=Temp.*op;                        %��ʱ������������˹���ӡ���ˡ�����ֵ���������Result��
        b(i,j)=sum(sum(Result));   
                                                %��������С�ʮ��������Ԫ����ӣ���ֵ�������������Ӧ��λ�ã�
                                                %����ʱ��������Ԫ������Ӧ��λ
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
