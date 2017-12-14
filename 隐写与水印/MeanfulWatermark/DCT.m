% DCT水印matlab代码
% 加载载体图像，并进行DCT变换
I = im2double(imread('cameraman.tiff')); 
imshow (I);
alpha=0.1;
X = dct2(I);

% 加载水印图像，并嵌入
o=im2double(imread('lena.tif')); 
%figure,imshow (o);
r=dct2(o);
K2=r*alpha; 
X=X+K2;
a = idct2(X);

% 提取水印图像
w1=(a-I)./alpha;
%保存为有损的jpeg格式
%q=input('Quality Factor q = ');
%imwrite(a,'xyz.jpg','jpg','quality',q);
%a=imread('xyz.jpg');
%figure,imshow((a));                  
%title ('Watermarking Image');
%imshow((w1));
%title('detected Embedded Watermark');

%整幅显示
figure, 
subplot(2,2,1), imshow(I),title('载体图像');
subplot(2,2,2), imshow(o),title('水印图像');
subplot(2,2,3), imshow(a,[]),title('嵌入水印图像');
subplot(2,2,4), imshow(w1),title('提取水印图像');




% %SNR 计算峰值信噪比
z1=double(a);
snr_num=0;
snr_den=0;
for  i=1:512
    for j=1:512
       snr_num=snr_num+(z1(i,j)*z1(i,j));
      snr_den=snr_den+((I(i,j)-z1(i,j))*(I(i,j)-z1(i,j)));
    end
end
snr=10*(log10(snr_num/snr_den));