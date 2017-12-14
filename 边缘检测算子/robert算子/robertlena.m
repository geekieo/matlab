I=imread('lena.bmp');
% I=imnoise(I, 'gaussian', 0, 0.001);%高斯噪声
I=im2double(I);
figure(1);
imshow(I);title('org img');
[height width R]=size(I);
for i=2:height-1
    for j=2:width-1
        R(i,j)=abs(I(i+1,j+1)-I(i,j))+abs(I(i+1,j)-I(i,j+1));
        Z(i,j)=abs(I(i+1,j+1)-I(i,j));
        X(i,j)=abs(I(i+1,j)-I(i,j+1));
    end
end
%figure;
%imshow(R,[]);


for i=1:height-1
    for j=1:width-1
        if (R(i,j)<0.25)
            R(i,j)=0;
        else R(i,j)=1;
        end
        if (Z(i,j)<0.25)
            Z(i,j)=0;
        else Z(i,j)=1;
        end
        if (X(i,j)<0.25)
            X(i,j)=0;
        else X(i,j)=1;
        end
    end
end
figure(2);
imshow(Z,[]);%主对角

figure(3);
imshow(X,[]);%次对角

figure(4);
imshow(R,[]);%全梯度