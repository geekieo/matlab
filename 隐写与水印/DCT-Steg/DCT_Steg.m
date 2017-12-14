%DCT隐写,将 srctext.txt 文档内容,隐写进 Arya,jpg 图片的DCT系数中
image = imread('Arya.jpg');
OriPicture= image;
imagegoal = 'xDCT.jpg';
msg = 'srctext.txt';
key = 153;
alpha = 1;
[count,msg,result] = hideDCTAdv(image,imagegoal,msg,key,alpha);
count 

 subplot(121);
 imshow(OriPicture);title('载体图片');
 subplot(122);
 imshow(result);title('隐写后');


x1=double(OriPicture);
x2=double(result);
[m,n]=size(x1);
[m2,n2]=size(x2);
if m2~=m||n2~=n;
error('图像选择错误');
end;
msevalue=0;
for i=1:m;
for j=1:n;
msevalue=msevalue+(x1(i,j)-x2(i,j))^2;
end;
end;
msevalue=msevalue/(m*n);
disp(['输入数据的mse为:',num2str(msevalue)]);
psnrvalue=255^2/msevalue;
psnrvalue=10*log10(psnrvalue);
disp(['输入数据的psnr为:',num2str(psnrvalue)]);