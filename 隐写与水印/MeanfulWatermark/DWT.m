% DWT水印代码
% 加载载体图像，并进行小波分解
X=imread('cameraman.tif');
X=im2double(X);
[F1,F2]= wfilters('db1', 'd');
[LL,LH,HL,HH] = dwt2(X,'db1','d');

%水印图像，二值化
b=imread('lena.tif'); 
level=graythresh(b);
w=im2bw(b,level);
w=double(w);

%嵌入水印图像
alpha=1;
k=w*alpha; 
LL_1=LL+k;
Y = idwt2(LL_1,LH,HL,HH,'db1','d');

% 存储图像为jpeg格式
q=input('Quality Factor q = ');
imwrite(Y,'kang.jpg','jpg','quality',q);
Y=imread('kang.jpg');
imshow((Y));    % 含水印图像
title ('含水印图像');

% 提取水印图像
w1= (LL_1-LL)./alpha ; 
level1=graythresh(w1);
w2=im2bw(w1,level1);
w2=im2double(w2);
%figure,imshow((w2));
%title ('提取的水印图像');


%整幅显示
figure, 
subplot(2,2,1), imshow(X),title('载体图像');
subplot(2,2,2), imshow(w),title('水印图像');
subplot(2,2,3), imshow(Y),title('嵌入水印图像');
subplot(2,2,4), imshow(w2),title('提取水印图像');

%SNR信噪比度量
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
%Similarity Factor (SF) 相似系数度量 
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