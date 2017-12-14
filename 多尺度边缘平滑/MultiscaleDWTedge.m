clear all;
% load wbarb;
% imshow(X);
% I = ind2gray(X,map);

 I=imread('lena.bmp'); 
 imshow(I);
 [d1,d2,d3]=size(I);
 if(d3)>1;
     I=rgb2gray(I);
 end
 I=double(I)/255;%�޶�������ת����255���Ҷȼ���ͼ��
%  I1 = uint8(255*I*0.5+0.5);
%  imshow(I1);


imshow(I);
I1 = imadjust(I,stretchlim(I),[0,1]);   %����ͼ��Աȶ�
figure;imshow(I1);
[N,M] = size(I);

h = [0.125,0.375,0.375,0.125];  %С���˲���ϵ��
g = [0.5,-0.5];    
delta = [1,0,0];

J = 3;

%��ʼ��
a(1:N,1:M,1,1:J+1) = 0;
dx(1:N,1:M,1,1:J+1) = 0;
dy(1:N,1:M,1,1:J+1) = 0;
d(1:N,1:M,1,1:J+1) = 0;


a(:,:,1,1) = conv2(h,h,I,'same'); 
dx(:,:,1,1) = conv2(delta,g,I,'same');
dy(:,:,1,1) = conv2(g,delta,I,'same');  

x = dx(:,:,1,1);
y = dy(:,:,1,1);
d(:,:,1,1) = sqrt(x.^2+y.^2);
I1 = imadjust(d(:,:,1,1),stretchlim(d(:,:,1,1)),[0 1]);%��Ե��ȡ 
figure;imshow(I1);

lh = length(h);
lg = length(g);

%��߶�ͼ���Ե���
for j = 1:J+1
  lhj = 2^j*(lh-1)+1;
  lgj = 2^j*(lg-1)+1;
  hj(1:lhj)=0;
  gj(1:lgj)=0;
  for n = 1:lh
    hj(2^j*(n-1)+1)=h(n);
  end

  for n = 1:lg
    gj(2^j*(n-1)+1)=g(n);
  end
  
  a(:,:,1,j+1) = conv2(hj,hj,a(:,:,1,j),'same');
  dx(:,:,1,j+1) = conv2(delta,gj,a(:,:,1,j),'same');
  dy(:,:,1,j+1) = conv2(gj,delta,a(:,:,1,j),'same');

  x = dx(:,:,1,j+1);
  y = dy(:,:,1,j+1);
  dj(:,:,1,j+1) = sqrt(x.^2+y.^2);

  I1 = imadjust(dj(:,:,1,j+1),stretchlim(dj(:,:,1,j+1)),[0 1]);figure;imshow(I1);
end  


