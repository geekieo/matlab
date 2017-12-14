close all;
clear all;

Img = imread('src.jpg');
%���һ��ͼ���������ͨ�������,�����������
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
%Ԥ����
J=rgb2gray(Img); 
%�Ҷȴ��� ��ʾ�Ҷ�ͼ 
figure,
imshow(J);
title('�ҶȻ�');

%figure, imhist(J); %J ֱ��ͼ
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
title('�˹���ֵ��ֵͼ');



BW=edge(M,'canny');
figure;
imshow(BW);
title('��Ե���');

%��Ե���
X=strel('line',3,90);
Y=strel('line',3,0);
N=imdilate(BW,[X Y]);
%���϶;
% L=bwlabel(N,8); %�����ͨ
% stats=regionprops(L);
% for i=1:length(stats)
% area(i)=stats(i).Area;
% end
% area_max=area(1); %�����ͨ����
% for i=1:length(stats)
% if area_max<=area(i)
% area_max=area(i);
% k=i; %�ؼ�ȡ�õڼ�����ͨ�����������ͨ����
% end
% end
% [m,n]=size(N);
% %ȥ��������ͨ����
% for i=1:m
% for j=1:n
% if L(i,j)==k
% N(i,j)=0;
% end
% end
% end
figure,imshow(N);title('ȥ��������ߵ���ͨ')
M=bwareaopen(N,100); %ȥ����С����ͨ����ֻʣ������Ŀ�꣬500��ͳ��ֵ
figure,imshow(M);title('ȥ����С����ͨ����');
M1=imfill(M,'holes');
figure,imshow(M1);title('�����ͼ��');
%��һ�α��
L=bwlabel(M1,8); %�����ͨ
stats=regionprops(L,'Centroid','BoundingBox','MajorAxisLength','MinorAxisLength' );
%���� regionprops �� BoundingBox �����뾶����ȡ��*��������ͨ��
max_index = 1;
max_area = 0;
for i = 1 : length(stats)
    area = stats(i).MajorAxisLength * stats(i).MinorAxisLength
    if area > max_area
        max_area =  area
        max_index = i
    end
end    

figure,imshow(M);title('�����ͨ��궨');
hold on ; %��������

%����Բ��
plot(stats(max_index).Centroid(1), stats(max_index).Centroid(2), 'r.', 'MarkerSize', 18)

t=0:pi/50:2*pi;
%�������Բ
x1=stats(max_index).Centroid(1)+stats(max_index).MajorAxisLength/2*sin(t);
y1=stats(max_index).Centroid(2)+stats(max_index).MajorAxisLength/2*cos(t);
plot(x1,y1,'r');
%�������Բ��С�뾶��ͬ��Բ
x=stats(max_index).Centroid(1)+(stats(max_index).MinorAxisLength/2-20)*sin(t);
y=stats(max_index).Centroid(2)+(stats(max_index).MinorAxisLength/2-20)*cos(t);
plot(x,y);

hold off;

%[L,num] = bwlabel(N,4);
%stats = regionprops(L,'all');
%stats(4)
%���ѱ�ǿ�ĵ����
%O=imfill(N,'holes')
%���
%figure
%imshow(O)
%title('���ͼ.bmp')
%[x,y] = getpts ȡ��
%area=bwarea(O)
%d=sqrt(4*area/pi)
%L=bwlabel(N);
%STATS = regionprops(L,'area');%�˴���area�����滻��properties��centroid����������ȱ���ܳ������ģ�
%w=[STATS.Area];
%w
%STATS(4)
