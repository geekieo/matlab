% DWT����ˮӡ��ȡԴ��
clear crl;
clear all;

blocksize=8; %ͼ��ֿ��С
Th=55;

% ����Ƕ������ˮӡ��ͼ��
file_name='DWT_watermarked_lena.bmp'; 
watermarked_image0=imread(file_name);
[r_watermarked,l_watermarked]=size(watermarked_image0);
watermarked_image=double(watermarked_image0);

% ����ԭʼˮӡ
file_name='best.bmp';
message=imread(file_name);
[r_message,l_message]=size(message);
message_vector=reshape(message,1,r_message*l_message);
watermark=zeros(size(message_vector));

% ��ͼ��ֿ�,��ȡˮӡ
h=waitbar(0,'��ȡˮӡ����ȴ�');
x=1;y=1;
for kk=1:length(message_vector);
    w=watermarked_image(x:x+blocksize-1,y:y+blocksize-1);
    [cA1,cH1,cV1,cD1]=dwt2(w,'haar');
    [cA2,cH2,cV2,cD2]=dwt2(cA1,'haar');
    ch2=reshape(cH2,1,(blocksize^2)/16); %����haarС���任
    cv2=reshape(cV2,1,(blocksize^2)/16);
    cd2=reshape(cD2,1,(blocksize^2)/16);
    c=[ch2,cv2,cd2];
    s=sum(c); %����ϸ����ͼ��С��ϵ���ĺ�
    if s<Th  %������ϸ����ͼ��С��ϵ���ĺ�С�ڷ�ֵ,ˮӡ��Ϣ�ж�Ϊ1
        watermark(kk)=1;
    elseif s>=Th %������ϸ����ͼ��С��ϵ���ĺʹ��ڻ���ڷ�ֵ,ˮӡ��Ϣ�ж�Ϊ0
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

% watermark0��ʾ��ȡ��ˮӡ
watermark0=reshape(watermark,r_message,l_message);

%�����һ�����ϵ��Nc
Nc=nc(message,watermark0)

figure
subplot(1,2,1)
imshow(watermark0,[]);
title('��ȡ��ˮӡ');
subplot(1,2,2)
imshow(message,[]);
title('ԭʼˮӡ');
