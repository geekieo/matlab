%%%%canny算子
clear;
clc;
A=imread('1.bmp');
A=imnoise(A, 'gaussian', 0, 0.001);

figure(1)
imshow(A);

% I=filter2(fspecial('average',3),A)/255; %均值滤波模板尺寸为3
% figure(2)
% imshow(I);

%  I=medfilt2(A);%二维中值滤波
%  figure(2)
%  imshow(I);
% 
% I=wiener2(A,[2 2]); %二维自适应维纳滤波 
% figure(2)
% imshow(I);

%利用小波变换对图象进行降噪处理
[thr,sorh,keepapp]=ddencmp('den','wv',A);     %获得除噪的缺省参数
I=wdencmp('gbl',A,'sym4',1,thr,sorh,keepapp);%图象进行降噪处理
I=uint8(round(I));
figure(6)
imshow(I)

gauss_I=I;
Isize=size(I);
ans=zeros(size(I));
dir=zeros(size(I));
I=double(I);
gauss_I=double(gauss_I);
fx=0;
fy=0;
for i=2:Isize(1)-1
    for j=2:Isize(2)-1
        fx(i,j)=(gauss_I(i,j)+gauss_I(i,j+1)-gauss_I(i+1,j)-gauss_I(i+1,j+1));
        fy(i,j)=(gauss_I(i,j)+gauss_I(i+1,j)-gauss_I(i,j+1)-gauss_I(i+1,j+1));
        ans(i,j)=sqrt(fx(i,j)*fx(i,j)+fy(i,j)*fy(i,j));
        dir(i,j)=atan(fy(i,j)/fx(i,j));
%         if(fx(i,j)<25)
%             fx(i,j)=0;
%         else fx(i,j)=255;
%         end
%         if(fy(i,j)<25)
%             fy(i,j)=0;
%         else fy(i,j)=255;
%         end
    end
end

figure(3)
imshow(fx,[]);

figure(4)
imshow(fy,[]);

for i=2:Isize(1)-1
    for j=2:Isize(2)-1
        if dir(i,j)>=-pi/8 & dir(i,j)<pi/8
            if ans(i,j)<=ans(i,j-1) | ans(i,j)<=ans(i,j+1)
                ans(i,j)=0;
            end
        end
        if dir(i,j)>=pi/8 & dir(i,j)<3*pi/8
            if ans(i,j)<=ans(i-1,j+1) | ans(i,j)<=ans(i+1,j-1)
                ans(i,j)=0;
            end
        end
        if dir(i,j)>=3*pi/8 | dir(i,j)<-3*pi/8
            if ans(i,j)<=ans(i-1,j) | ans(i,j)<=ans(i+1,j)
                ans(i,j)=0;
            end
        end
        if dir(i,j)<-pi/8 & dir(i,j)>=3*pi/8
            if ans(i,j)<=ans(i-1,j-1) | ans(i,j)<=ans(i+1,j+1)
                ans(i,j)=0;
            end
        end
        if ans(i,j)<40
            ans(i,j)=0;
        else
            ans(i,j)=255;
        end
    end
end
figure(5)
imshow(ans)