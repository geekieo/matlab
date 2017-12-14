function DWT_embed
% DWT嵌入数字水印源码
clear crl;
clear all;

blocksize=8; %图像分块大小
A=4;B=1;b=0.318; %水印嵌入程度的调制参数

% 读入载体图像
file_name='lena.bmp';
cover_object0=imread(file_name);
[r_cover,l_cover]=size(cover_object0);

% 读入水印
I=imread('best.bmp');imshow(I);
file_name='best.bmp';
message=imread(file_name);
[r_message,l_message]=size(message);
message_vector=reshape(message,1,r_message*l_message);

if r_message*l_message > r_cover*l_cover/(blocksize^2)
    error('水印太大');
end;

cover_object=double(cover_object0);
watermarked_image=cover_object;

% 图像分块，嵌入水印信息
h=waitbar(0,'嵌入水印，请等待');
x=1;y=1;
for kk=1:length(message_vector);
    w=cover_object(x:x+blocksize-1,y:y+blocksize-1);
    [cA1,cH1,cV1,cD1]=dwt2(w,'haar');  %二级haar小波变换
    [cA2,cH2,cV2,cD2]=dwt2(cA1,'haar');
    a=[cA2,cH2,cV2,cD2];
    ca=reshape(a,1,(blocksize^2)/4);
    ca2=reshape(cA2,1,(blocksize^2)/16);
    ch2=reshape(cH2,1,(blocksize^2)/16);
    cv2=reshape(cV2,1,(blocksize^2)/16);
    cd2=reshape(cD2,1,(blocksize^2)/16);
    E=(sum(ca)-sum(ca2))/(16-4);   % 二级细节子图的小波系数的平均值
    c=[ch2,cv2,cd2]-E;s=0;
    for nn=1:length(c)
        s=s+c(nn)^2;
    end;
    s=sqrt(s);
    t=s^b;
    p=A+t*B;   % 调制参数
    if message_vector(kk)==0
        C=c+p;
    end;
    if message_vector(kk)==1
        C=c;
    end;
    cH2=reshape(C(1:4),2,2);
    cV2=reshape(C(5:8),2,2);
    cD2=reshape(C(9:12),2,2);
    cA1=idwt2(cA2,cH2,cV2,cD2,'haar',[blocksize/2,blocksize/2]); %二级haar小波逆变换
    watermarked_image(x:x+blocksize-1,y:y+blocksize-1)= idwt2(cA1,cH1,cV1,cD1,'haar',[blocksize,blocksize]);
    if (x+blocksize) >= r_cover
        x=1;
        y=y+blocksize;
    else
        x=x+blocksize;
    end;
    waitbar(kk/length(message_vector),h);
end;
close(h);

% 计算PSNR
PSNR=psnr(cover_object,watermarked_image)

% 将嵌入水印的图像转换成uint8，写入DWT_watermarked_lena.bmp
watermarked_image_uint=uint8(watermarked_image);
imwrite(watermarked_image_uint,'DWT_watermarked_lena.bmp','bmp');

% 显示嵌入水印的图像
figure
subplot(1,2,1);
imshow(watermarked_image,[]);
title('嵌入水印的图像');
subplot(1,2,2);
imshow(cover_object,[]);
title('原载体图像');
end