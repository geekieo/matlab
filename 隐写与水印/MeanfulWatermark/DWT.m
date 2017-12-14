% DWTˮӡ����
% ��������ͼ�񣬲�����С���ֽ�
X=imread('cameraman.tif');
X=im2double(X);
[F1,F2]= wfilters('db1', 'd');
[LL,LH,HL,HH] = dwt2(X,'db1','d');

%ˮӡͼ�񣬶�ֵ��
b=imread('lena.tif'); 
level=graythresh(b);
w=im2bw(b,level);
w=double(w);

%Ƕ��ˮӡͼ��
alpha=1;
k=w*alpha; 
LL_1=LL+k;
Y = idwt2(LL_1,LH,HL,HH,'db1','d');

% �洢ͼ��Ϊjpeg��ʽ
q=input('Quality Factor q = ');
imwrite(Y,'kang.jpg','jpg','quality',q);
Y=imread('kang.jpg');
imshow((Y));    % ��ˮӡͼ��
title ('��ˮӡͼ��');

% ��ȡˮӡͼ��
w1= (LL_1-LL)./alpha ; 
level1=graythresh(w1);
w2=im2bw(w1,level1);
w2=im2double(w2);
%figure,imshow((w2));
%title ('��ȡ��ˮӡͼ��');


%������ʾ
figure, 
subplot(2,2,1), imshow(X),title('����ͼ��');
subplot(2,2,2), imshow(w),title('ˮӡͼ��');
subplot(2,2,3), imshow(Y),title('Ƕ��ˮӡͼ��');
subplot(2,2,4), imshow(w2),title('��ȡˮӡͼ��');

%SNR����ȶ���
z1=double(Y);
snr_num=0;
snr_den=0;
for  i=1:256
    for j=1:256
        snr_num=snr_num+(z1(i,j)*z1(i,j));
        snr_den=snr_den+((X(i,j)-z1(i,j))*(X(i,j)-z1(i,j)));
    end
end
snr=10*log10(snr_num/snr_den)
%Similarity Factor (SF) ����ϵ������ 
sf_num=0; sf_den=0;a=0; b=0;
for  i=1:128
    for j=1:128
        sf_num=sf_num+(w1(i,j)*w(i,j));
        a=a+(w(i,j)*w(i,j));
        b=b+(w1(i,j)*w1(i,j));
        sf_den=sqrt(sf_den+a*b);    
    end
end
 
sf=(sf_num/sf_den)