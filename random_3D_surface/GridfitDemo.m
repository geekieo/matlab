%���������ά����

clf;clear,clc
p=rand(30,3);
x=p(:,1);y=p(:,2);z=p(:,3);%30������
[xi,yi]=meshgrid(linspace(min(x),max(x),100),linspace(min(y),max(y),100));
zi=griddata(x,y,z,xi,yi,'v4');
surf(xi,yi,zi);
shading interp %ȥ������