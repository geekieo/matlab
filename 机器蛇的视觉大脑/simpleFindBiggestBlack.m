%输入白底黑球图片，输出黑球相对中心的偏移量
%created by 翁敬喻 
%Email:wengjingyu@gmail.com
%输入图片名为src.jpg，输出坐标为offset，分量为offset_x,offset_y
%offset为距离图片中心的偏移量，图片坐标原点为左上角
%偏移结果已做归一化，分量区间为[-1,1]
%图片变量前缀为'i_'
%精简
clc;clear all;clear memory;
%颜色预处理--------------------------
i_src=imread('src.bmp');
i_gray=rgb2gray(i_src);
i_bright = imadjust(i_gray,[0 0.5],[0 1]);%亮度变换
level =graythresh(i_bright);%计算阈值
i_segment=im2bw(i_bright,level);%二值化，阈值分割

%形态预处理-----------------------
i_segment=im2double(i_segment);
h=fspecial('gaussian',25,15);
i_medfilt=medfilt2(i_segment,[3 3]);%进行中值滤波
i_gaussian=imfilter(i_medfilt,h,'replicate');%高斯模糊，sig=15
i_binary=im2bw(i_gaussian,1.5*graythresh(i_gaussian));%二值化，空洞填充

%连通域提取-----------------------
[bin_y,bin_x]=size(i_binary);
i_inverse=ones(bin_y,bin_x)-i_binary;%黑变白，下列函数只白色进行统计
[img_y,img_x]=size(i_inverse);%原图尺寸
mid_x=img_x/2;mid_y=img_y/2;%原图中心坐标
i_connected=bwlabel(i_inverse);%连通域标记连通分量
stats = regionprops(i_connected);%统计被标记的区域的面积分布，显示区域总数
Ar = cat(1, stats.Area);%按列连接矩阵（列数相同）
ind = find(Ar == max(Ar));%最大连通域标记索引
i_maxcon = ismember(i_connected,ind);%删除小面积区域
Volume = bwarea(i_maxcon)/(img_y*img_x)%计算目标面积（占比）

if Volume<0.005
    offset=[0,0]
%    retrun;
else
stat = regionprops(i_maxcon, 'centroid');%求每个连通域的质心，这里就一个
centroids = cat(1, stat.Centroid);%1表示按列提取，从属性结构数组中提取坐标
x=centroids(:,1);%输出第1列，目标x坐标
y=centroids(:,2);%输出第2列，目标y坐标
offset=[(x-mid_x)/mid_x,(y-mid_y)/mid_y]
end;

% figure(3);
% subplot(1,2,1);imshow(i_src);title('原图');
% subplot(1,2,2);imshow(i_maxcon);title('最大区域');
% hold on %继续在上图中作图
% plot(centroids(:,1),centroids(:,2),'r+');



