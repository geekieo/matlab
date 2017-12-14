% DWT数字水印提取源码
clear crl;
clear all;

blocksize=8; %图像分块大小
Th=55;

% 读入嵌入数字水印的图像
file_name='DWT_watermarked_lena.bmp'; 
watermarked_image0=imread(file_name);
[r_watermarked,l_watermarked]=size(watermarked_image0);
watermarked_image=double(watermarked_image0);

% 读入原始水印
file_name='best.bmp';
message=imread(file_name);
[r_message,l_message]=size(message);
message_vector=reshape(message,1,r_message*l_message);
watermark=zeros(size(message_vector));

% 将图像分块,提取水印
h=waitbar(0,'提取水印，请等待');
x=1;y=1;
for kk=1:length(message_vector);
    w=watermarked_image(x:x+blocksize-1,y:y+blocksize-1);
    [cA1,cH1,cV1,cD1]=dwt2(w,'haar');
    [cA2,cH2,cV2,cD2]=dwt2(cA1,'haar');
    ch2=reshape(cH2,1,(blocksize^2)/16); %二级haar小波变换
    cv2=reshape(cV2,1,(blocksize^2)/16);
    cd2=reshape(cD2,1,(blocksize^2)/16);
    c=[ch2,cv2,cd2];
    s=sum(c); %二级细节子图的小波系数的和
    if s<Th  %当二级细节子图的小波系数的和小于阀值,水印信息判定为1
        watermark(kk)=1;
    elseif s>=Th %当二级细节子图的小波系数的和大于或等于阀值,水印信息判定为0
        watermark(kk)=0;
    end;
    if (x+blocksize) >= r_watermarked
        x=1;
        y=y+blocksize;
    else
        x=x+blocksize;
    end;
    waitbar(kk/length(message_vector),h);
end;
close(h);

% watermark0表示提取的水印
watermark0=reshape(watermark,r_message,l_message);

%计算归一化相关系数Nc
Nc=nc(message,watermark0)

figure
subplot(1,2,1)
imshow(watermark0,[]);
title('提取的水印');
subplot(1,2,2)
imshow(message,[]);
title('原始水印');
