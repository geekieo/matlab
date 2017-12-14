%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����Ҫ�����ͼ��
clear
clc
close all
bw4=imread('1.bmp');
% bw4=imnoise(bw4, 'gaussian', 0, 0.001);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%����ԭʼͼ��
figure(1)
imshow(bw4)
title('ԭʼͼ��')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��ȡͼ���Ե
t=1200 ;                        %�趨��ֵ
%colormap(gray(256));          %�趨��ɫ��
bw5=double(bw4);             %��ͼ��Ϊʮ������
[m,n]=size(bw5);               %�õ�ͼ��Ĵ�С�����Ϳ�
g=zeros(m,n);              %����һ����СΪS�������
%����Sobel���ӽ��б�Ե��ȡ
for i=2:m-1
  for j=2:n-1
       d1 =(5*bw5(i-1,j-1)+5*bw5(i-1,j)+5*bw5(i-1,j+1)-3*bw5(i,j-1)-3*bw5(i,j+1)-3*bw5(i+1,j-1)-3*bw5(i+1,j)-3*bw5(i+1,j+1))^2; %Sobel���ӵ�dx(��ֱ�ݶ�)
       d2 =((-3)*bw5(i-1,j-1)+5*bw5(i-1,j)+5*bw5(i-1,j+1)-3*bw5(i,j-1)+5*bw5(i,j+1)-3*bw5(i+1,j-1)-3*bw5(i+1,j)-3*bw5(i+1,j+1))^2;  %Sobel���ӵ�dy(ˮƽ�ݶ�)
       d3 =((-3)*bw5(i-1,j-1)-3*bw5(i-1,j)+5*bw5(i-1,j+1)-3*bw5(i,j-1)+5*bw5(i,j+1)-3*bw5(i+1,j-1)-3*bw5(i+1,j)+5*bw5(i+1,j+1))^2; 
       d4 =((-3)*bw5(i-1,j-1)-3*bw5(i-1,j)-3*bw5(i-1,j+1)-3*bw5(i,j-1)+5*bw5(i,j+1)-3*bw5(i+1,j-1)+5*bw5(i+1,j)+5*bw5(i+1,j+1))^2; 
       d5 =((-3)*bw5(i-1,j-1)-3*bw5(i-1,j)-3*bw5(i-1,j+1)-3*bw5(i,j-1)-3*bw5(i,j+1)+5*bw5(i+1,j-1)+5*bw5(i+1,j)+5*bw5(i+1,j+1))^2; 
       d6 =((-3)*bw5(i-1,j-1)-3*bw5(i-1,j)-3*bw5(i-1,j+1)+5*bw5(i,j-1)-3*bw5(i,j+1)+5*bw5(i+1,j-1)+5*bw5(i+1,j)-3*bw5(i+1,j+1))^2; 
       d7 =(5*bw5(i-1,j-1)-3*bw5(i-1,j)-3*bw5(i-1,j+1)+5*bw5(i,j-1)-3*bw5(i,j+1)+5*bw5(i+1,j-1)-3*bw5(i+1,j)-3*bw5(i+1,j+1))^2; 
       d8 =(5*bw5(i-1,j-1)+5*bw5(i-1,j)-3*bw5(i-1,j+1)+5*bw5(i,j-1)-3*bw5(i,j+1)-3*bw5(i+1,j-1)-3*bw5(i+1,j)-3*bw5(i+1,j+1))^2; 
       
      g(i,j)=round(sqrt(d1+d2+d3+d4+d5+d6+d7+d8)); %�ݶ�ģȡ��
%        max=d1;
%        if max<d2
%            max=d2;
%        end
%        if max<d3
%            max=d3;
%        end
%        if max<d4
%            max=d4;
%        end
%        if max<d5
%            max=d5;
%        end
%        if max<d6
%            max=d6;
%        end
%        if max<d7
%            max=d7;
%        end
%        if max<d8
%            max=d8;
%        end
%         g(i,j)=max;
    end
end 
figure(4)
imshow(g,[])

for i=1:m
  for j=1:n
  if g(i,j)>t
  bw5(i,j)=255;              %���ݶ�ֵ����ֵ�Ƚ� ������T���ͼ��ĻҶȱ�Ϊ255��С��T���ͼ��ĻҶȱ�Ϊ0
  else
  bw5(i,j)=0;
    end
  end
end
%��ʾ��Ե��ȡ���ͼ��
figure(5)
imshow(bw5)
title('kirsch��Ե���')


