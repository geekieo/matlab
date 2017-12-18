%����ͼƬ�����������������
clear all;clc;clear memory;
faceDetector = vision.CascadeObjectDetector();
%src=imread('src.bmp');
src=imread('twoface.jpg');
bbox = step(faceDetector, src);
[Y_col,Ind_row]=max(bbox);%ÿ�е����ֵ���к�

figure, imshow(src), title('Detected face');

if isempty(Ind_row)
    offset=[0,0];
%    return;
else
    maxbbox=bbox(Ind_row(1,3),:);% �����λ��
    face_midpoint = [maxbbox(1,1)+maxbbox(1,3)/2, maxbbox(1,2)+maxbbox(1,4)/2];%�������������
    [img_y,img_x]=size(src);%ԭͼ�ߴ�
    mid_x=img_x/2;mid_y=img_y/2;%ԭͼ��������
    offset=[(face_midpoint(1,1)-mid_x)/mid_x,(face_midpoint(1,2)-mid_y)/mid_y];
    
    hold on %��������ͼ����ͼ
    plot(face_midpoint(1,1),face_midpoint(1,2),'r+');
    
end;

