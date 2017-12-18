%����׵׺���ͼƬ���������������ĵ�ƫ����
%created by �̾��� 
%Email:wengjingyu@gmail.com
%����ͼƬ��Ϊsrc.jpg���������Ϊoffset������Ϊoffset_x,offset_y
%offsetΪ����ͼƬ���ĵ�ƫ������ͼƬ����ԭ��Ϊ���Ͻ�
%ƫ�ƽ��������һ������������Ϊ[-1,1]
%ͼƬ����ǰ׺Ϊ'i_'
%����
clc;clear all;clear memory;
%��ɫԤ����--------------------------
i_src=imread('src.bmp');
i_gray=rgb2gray(i_src);
i_bright = imadjust(i_gray,[0 0.5],[0 1]);%���ȱ任
level =graythresh(i_bright);%������ֵ
i_segment=im2bw(i_bright,level);%��ֵ������ֵ�ָ�

%��̬Ԥ����-----------------------
i_segment=im2double(i_segment);
h=fspecial('gaussian',25,15);
i_medfilt=medfilt2(i_segment,[3 3]);%������ֵ�˲�
i_gaussian=imfilter(i_medfilt,h,'replicate');%��˹ģ����sig=15
i_binary=im2bw(i_gaussian,1.5*graythresh(i_gaussian));%��ֵ�����ն����

%��ͨ����ȡ-----------------------
[bin_y,bin_x]=size(i_binary);
i_inverse=ones(bin_y,bin_x)-i_binary;%�ڱ�ף����к���ֻ��ɫ����ͳ��
[img_y,img_x]=size(i_inverse);%ԭͼ�ߴ�
mid_x=img_x/2;mid_y=img_y/2;%ԭͼ��������
i_connected=bwlabel(i_inverse);%��ͨ������ͨ����
stats = regionprops(i_connected);%ͳ�Ʊ���ǵ����������ֲ�����ʾ��������
Ar = cat(1, stats.Area);%�������Ӿ���������ͬ��
ind = find(Ar == max(Ar));%�����ͨ��������
i_maxcon = ismember(i_connected,ind);%ɾ��С�������
Volume = bwarea(i_maxcon)/(img_y*img_x)%����Ŀ�������ռ�ȣ�

if Volume<0.005
    offset=[0,0]
%    retrun;
else
stat = regionprops(i_maxcon, 'centroid');%��ÿ����ͨ������ģ������һ��
centroids = cat(1, stat.Centroid);%1��ʾ������ȡ�������Խṹ��������ȡ����
x=centroids(:,1);%�����1�У�Ŀ��x����
y=centroids(:,2);%�����2�У�Ŀ��y����
offset=[(x-mid_x)/mid_x,(y-mid_y)/mid_y]
end;

% figure(3);
% subplot(1,2,1);imshow(i_src);title('ԭͼ');
% subplot(1,2,2);imshow(i_maxcon);title('�������');
% hold on %��������ͼ����ͼ
% plot(centroids(:,1),centroids(:,2),'r+');



