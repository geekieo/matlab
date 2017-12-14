%输入图片，返回最大人脸坐标
clear all;clc;clear memory;
faceDetector = vision.CascadeObjectDetector();
%src=imread('src.bmp');
src=imread('twoface.jpg');
bbox = step(faceDetector, src);
[Y_col,Ind_row]=max(bbox);%每列的最大值及行号

figure, imshow(src), title('Detected face');

if isempty(Ind_row)
    offset=[0,0];
%    return;
else
    maxbbox=bbox(Ind_row(1,3),:);% 最大脸位置
    face_midpoint = [maxbbox(1,1)+maxbbox(1,3)/2, maxbbox(1,2)+maxbbox(1,4)/2];%最大脸中心坐标
    [img_y,img_x]=size(src);%原图尺寸
    mid_x=img_x/2;mid_y=img_y/2;%原图中心坐标
    offset=[(face_midpoint(1,1)-mid_x)/mid_x,(face_midpoint(1,2)-mid_y)/mid_y];
    
    hold on %继续在上图中作图
    plot(face_midpoint(1,1),face_midpoint(1,2),'r+');
    
end;

