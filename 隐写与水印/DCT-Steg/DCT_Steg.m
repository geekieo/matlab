%DCT��д,�� srctext.txt �ĵ�����,��д�� Arya,jpg ͼƬ��DCTϵ����
image = imread('Arya.jpg');
OriPicture= image;
imagegoal = 'xDCT.jpg';
msg = 'srctext.txt';
key = 153;
alpha = 1;
[count,msg,result] = hideDCTAdv(image,imagegoal,msg,key,alpha);
count 

 subplot(121);
 imshow(OriPicture);title('����ͼƬ');
 subplot(122);
 imshow(result);title('��д��');


x1=double(OriPicture);
x2=double(result);
[m,n]=size(x1);
[m2,n2]=size(x2);
if m2~=m||n2~=n;
error('ͼ��ѡ�����');
end;
msevalue=0;
for i=1:m;
for j=1:n;
msevalue=msevalue+(x1(i,j)-x2(i,j))^2;
end;
end;
msevalue=msevalue/(m*n);
disp(['�������ݵ�mseΪ:',num2str(msevalue)]);
psnrvalue=255^2/msevalue;
psnrvalue=10*log10(psnrvalue);
disp(['�������ݵ�psnrΪ:',num2str(psnrvalue)]);