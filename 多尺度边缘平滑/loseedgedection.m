%多尺度边缘检测一般是在不同的尺度上先平滑原信号，再由平滑后的信号一阶或二阶导数检测出原信号的剧变点。
%http://www.matlab-download.cn/Code/edge.html
clear all;clc;
%load wbarb;
%I = ind2gray(X,map);imshow(I);
%I1 = imadjust(I,stretchlim(I),[0,1]);figure;imshow(I1);
%I=imread('lena.png');           %读取图像
load wbarb;
I = ind2gray(X,map);
figure,imshow(I);
%I= imnoise(I,'gaussian',0,0.05); %加高斯噪声
%figure,imshow(I);

I1 = imadjust(I,stretchlim(I),[0,1]);figure;imshow(I1);
[N,M] = size(I);

h = [0.125,0.375,0.375,0.125];   %低通
g = [0.5,-0.5];    %高通
delta = [1,0,0];    %dirac滤波器

J =3;  %尺度变换时，可以得到不同分辨率j下的细节信号

a(1:N,1:M,1,1:J+1) = 0;   %初始化矩阵
dx(1:N,1:M,1,1:J+1) = 0;
dy(1:N,1:M,1,1:J+1) = 0;
d(1:N,1:M,1,1:J+1) = 0;

a(:,:,1,1) = conv2(h,h,I,'same');           %尺度
dx(:,:,1,1) = conv2(delta,g,I,'same');
dy(:,:,1,1) = conv2(g,delta,I,'same');      %小波变换的两个分量

x = dx(:,:,1,1);
y = dy(:,:,1,1);
d(:,:,1,1) = sqrt(x.^2+y.^2);          %反映了f*@在点(x,y)的灰度变化的剧烈程度，完全刻画了灰度变化特征。
I1 = imadjust(d(:,:,1,1),stretchlim(d(:,:,1,1)),[0 1]);figure;imshow(I1,[]);   %分辨率级高（小尺度），边缘定位精度高，但对噪声敏感，细化边缘



lh = length(h);
lg = length(g);

for j = 1:J+1                   %不同层的小波变换系数，尺度
  lhj = 2^j*(lh-1)+1;           %hj、gj表示在低通和高通的滤波器系数之间插入2^j-1个0
  lgj = 2^j*(lg-1)+1;
  hj(1:lhj)=0;
  gj(1:lgj)=0;
  for n = 1:lh
    hj(2^j*(n-1)+1)=h(n);
  end

  for n = 1:lg
    gj(2^j*(n-1)+1)=g(n);
  end
  
  a(:,:,1,j+1) = conv2(hj,hj,a(:,:,1,j),'same');
  dx(:,:,1,j+1) = conv2(delta,gj,a(:,:,1,j),'same');
  dy(:,:,1,j+1) = conv2(gj,delta,a(:,:,1,j),'same');

  x = dx(:,:,1,j+1);
  y = dy(:,:,1,j+1);
  dj(:,:,1,j+1) = sqrt(x.^2+y.^2);      %分辨率级低（大尺度），边缘定位精度差，但抗噪声性好，确定边缘
                                       %反映了f*@在点(x,y)的灰度变化的剧烈程度，完全刻画了灰度变化特征
I1 = imadjust(dj(:,:,1,j+1),stretchlim(dj(:,:,1,j+1)),[0 1]);
figure;imshow(I1,[]); 
%output = Qabf(dj(:,:,1,j+1), dj(:,:,1,j), d(:,:,1,1))
%figure;imshow(output);

end 
%fusedImg = FuseImages(dj(:,:,1,4), dj(:,:,1,5), 0.5);
%figure;imshow(fusedImg,[]);
