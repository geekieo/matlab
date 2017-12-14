clc;clear all;

%%%%%%%%%%%%%%%读取并显示%%%%%%%%%%%%%%
fid=fopen('data3D_.txt');       %打开数据总文件
B=textscan(fid,'%f %f %f %f');  %把每一列的数据读入到读入到单元数组B中
C=[B{1} B{2} B{3} B{4}];        %从单元数组B中提取每列数据赋值给矩阵C

% xx=C(:,1);yy=C(:,2);zz=C(:,3);  %赋值,坐标
vv=C(:,4);                      %赋值,电阻率
%figure(1);scatter3(xx,yy,zz,100,vv,'filled');%生成三维点云，坐标(x,y,z),点大小为100,颜色为p，实心点

%%%%%%%%%%%%%%%数据准备%%%%%%%%%%%%%%%
%源数据构造参数，为符合interp3()参数条件
x=-100:10:100;              %x取值从-100到100，步长为10
y=-100:10:100;
z=0:10:100;
[x,y,z]=meshgrid(x,y,z);	%删格化坐标值
v=ones(21,21,11);           %构造参数v，电阻率
n=1;
for k=1:11          %多维数组索引必须为正整数或逻辑值，步长默认为1
    for j=1:21
        for i=1:21
            v(i,j,k)=vv(n);
            n=n+1;
        end;
    end;
end;

%插值坐标准备
xi=-100:1:100;
yi=-100:1:100;
zi=0:1:100;
[xi,yi,zi]=meshgrid(xi,yi,zi);              %坐标加密十倍，删格化
%interp3要求(X,Y,Z)必须是严格单调的并且是等间距的，如果(X,Y,Z)不是等间距的，
%会将其变换为等间距形式，如果已知是等间距的，可在method参数前加星号，如：'*cubic'。

%%%%%%%%%%%%%%%三维插值%%%%%%%%%%%%%%%
vi1=interp3(x,y,z,v,xi,yi,zi,'*linear');    %线性插值(默认)
vi2=interp3(x,y,z,v,xi,yi,zi,'*cubic');     %三次插值
vi3=interp3(x,y,z,v,xi,yi,zi,'*spline');    %三次样条插值
vi4=interp3(x,y,z,v,xi,yi,zi,'*nearest');   %最近邻插值，效果最差

%%%%%%%%%%%%%%%结果展示%%%%%%%%%%%%%%%
figure(2);slice(xi,yi,zi,vi1,82,47,88), shading flat  %插值图切片,渐晕色彩效果
%figure(3);slice(xi,yi,zi,vi2,82,47,88), shading flat  %插值图切片
%figure(4);slice(xi,yi,zi,vi3,82,47,88), shading flat  %插值图切片
%figure(5);slice(xi,yi,zi,vi4,82,47,88), shading flat  %插值图切片



