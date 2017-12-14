close all;
clear all;

Img = imread('src.jpg');
%标记一个图像中最大连通域的质心,并求出其坐标
% I = rgb2gray(Img);
% I = imcomplement(I);
% I1 = im2bw(I, graythresh(I));
% I1 = ~I1;
% L = bwlabel(I1);
% stats = regionprops(L);
% Cen = []; Err = [];
% center = size(I)/2;
% for i = 1 : length(stats)
% Cen = [Cen; stats(i).Centroid];
% Err = [Err; norm(stats(i).Centroid-center)];
% end
% [minc, ind] = min(Err);
% figure; 
% imshow(I1, []);
% hold on;
% plot(Cen(ind, 1), Cen(ind, 2), 'r.', 'MarkerSize', 18);
% str = sprintf('x=%.2f, y=%.2f', Cen(ind, 1), Cen(ind, 2));
% text(Cen(ind, 1), Cen(ind, 2), str, 'FontSize', 14)


figure,
imshow(Img);
title('Img');

imagesc(Img ,[0 255]); 
%预处理
J=rgb2gray(Img); 
%灰度处理 显示灰度图 
figure,
imshow(J);
title('灰度化');

%figure, imhist(J); %J 直方图
% 
[row,col]=size(J);
M=zeros(row,col);
for i=1:row
for j=1:col
if J(i,j)>153
M(i,j)=1;
else
M(i,j)=0;
end 
end
end
figure;
imshow(M);
title('人工阈值二值图');



BW=edge(M,'canny');
figure;
imshow(BW);
title('边缘检测');

%边缘检测
X=strel('line',3,90);
Y=strel('line',3,0);
N=imdilate(BW,[X Y]);
%填补缝隙;
% L=bwlabel(N,8); %标记连通
% stats=regionprops(L);
% for i=1:length(stats)
% area(i)=stats(i).Area;
% end
% area_max=area(1); %最大连通区域
% for i=1:length(stats)
% if area_max<=area(i)
% area_max=area(i);
% k=i; %关键取得第几个连通区域是最大连通区域
% end
% end
% [m,n]=size(N);
% %去掉最大的连通区域
% for i=1:m
% for j=1:n
% if L(i,j)==k
% N(i,j)=0;
% end
% end
% end
figure,imshow(N);title('去掉了最外边的连通')
M=bwareaopen(N,100); %去掉较小的连通区域，只剩下最大和目标，500是统计值
figure,imshow(M);title('去掉了小的连通区域');
M1=imfill(M,'holes');
figure,imshow(M1);title('填充后的图像');
%再一次标记
L=bwlabel(M1,8); %标记连通
stats=regionprops(L,'Centroid','BoundingBox','MajorAxisLength','MinorAxisLength' );
%根据 regionprops 的 BoundingBox 两个半径，获取长*宽最大的连通域
max_index = 1;
max_area = 0;
for i = 1 : length(stats)
    area = stats(i).MajorAxisLength * stats(i).MinorAxisLength
    if area > max_area
        max_area =  area
        max_index = i
    end
end    

figure,imshow(M);title('最大连通域标定');
hold on ; %继续绘制

%画出圆心
plot(stats(max_index).Centroid(1), stats(max_index).Centroid(2), 'r.', 'MarkerSize', 18)

t=0:pi/50:2*pi;
%画个外接圆
x1=stats(max_index).Centroid(1)+stats(max_index).MajorAxisLength/2*sin(t);
y1=stats(max_index).Centroid(2)+stats(max_index).MajorAxisLength/2*cos(t);
plot(x1,y1,'r');
%画个外接圆缩小半径的同心圆
x=stats(max_index).Centroid(1)+(stats(max_index).MinorAxisLength/2-20)*sin(t);
y=stats(max_index).Centroid(2)+(stats(max_index).MinorAxisLength/2-20)*cos(t);
plot(x,y);

hold off;

%[L,num] = bwlabel(N,4);
%stats = regionprops(L,'all');
%stats(4)
%求已标记快的的面积
%O=imfill(N,'holes')
%填充
%figure
%imshow(O)
%title('填充图.bmp')
%[x,y] = getpts 取点
%area=bwarea(O)
%d=sqrt(4*area/pi)
%L=bwlabel(N);
%STATS = regionprops(L,'area');%此处的area可以替换成properties、centroid（即可以求缺陷周长和形心）
%w=[STATS.Area];
%w
%STATS(4)
