%Log���ӷָ�
f=imread('1.bmp');
f=imnoise(f, 'gaussian', 0, 0.001);
k=double(f);

figure(1)
imshow(f)

[m,n]=size(f);
k=[zeros(m,1) k zeros(m,1)];
k=[zeros(1,n+2);k;zeros(1,n+2)];
T=30;  %T��ʾ��ѡ�����ֵ
for i=2:m+1  %i������
    for j=2:n+1   %j������
        %����[0 1 0;1 -4 1;0 1 0]ģ��
        g(i,j)=k(i-1,j)+k(i+1,j)+k(i,j-1)+k(i,j+1)-4*k(i,j);
    end
end

for i=2:m+1  %i������
    for j=2:n+1   %j������
        if  g(i,j)<T 
            g(i,j)=0;
        else
            g(i,j)=1;
        end
    end
end    
figure(2)
imshow(g)
xlabel('Log���ӷָ�')