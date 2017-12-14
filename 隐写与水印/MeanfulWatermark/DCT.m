% DCTˮӡmatlab����
% ��������ͼ�񣬲�����DCT�任
I = im2double(imread('cameraman.tiff')); 
imshow (I);
alpha=0.1;
X = dct2(I);

% ����ˮӡͼ�񣬲�Ƕ��
o=im2double(imread('lena.tif')); 
%figure,imshow (o);
r=dct2(o);
K2=r*alpha; 
X=X+K2;
a = idct2(X);

% ��ȡˮӡͼ��
w1=(a-I)./alpha;
%����Ϊ�����jpeg��ʽ
%q=input('Quality Factor q = ');
%imwrite(a,'xyz.jpg','jpg','quality',q);
%a=imread('xyz.jpg');
%figure,imshow((a));                  
%title ('Watermarking Image');
%imshow((w1));
%title('detected Embedded Watermark');

%������ʾ
figure, 
subplot(2,2,1), imshow(I),title('����ͼ��');
subplot(2,2,2), imshow(o),title('ˮӡͼ��');
subplot(2,2,3), imshow(a,[]),title('Ƕ��ˮӡͼ��');
subplot(2,2,4), imshow(w1),title('��ȡˮӡͼ��');




% %SNR �����ֵ�����
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