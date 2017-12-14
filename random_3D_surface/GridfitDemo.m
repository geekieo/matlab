%随机生成三维曲面

clf;clear,clc
p=rand(30,3);
x=p(:,1);y=p(:,2);z=p(:,3);%30组坐标
[xi,yi]=meshgrid(linspace(min(x),max(x),100),linspace(min(y),max(y),100));
zi=griddata(x,y,z,xi,yi,'v4');
surf(xi,yi,zi);
shading interp %去除网格