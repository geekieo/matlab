clc;clear all;

%%%%%%%%%%%%%%%��ȡ����ʾ%%%%%%%%%%%%%%
fid=fopen('data3D_.txt');       %���������ļ�
B=textscan(fid,'%f %f %f %f');  %��ÿһ�е����ݶ��뵽���뵽��Ԫ����B��
C=[B{1} B{2} B{3} B{4}];        %�ӵ�Ԫ����B����ȡÿ�����ݸ�ֵ������C

% xx=C(:,1);yy=C(:,2);zz=C(:,3);  %��ֵ,����
vv=C(:,4);                      %��ֵ,������
%figure(1);scatter3(xx,yy,zz,100,vv,'filled');%������ά���ƣ�����(x,y,z),���СΪ100,��ɫΪp��ʵ�ĵ�

%%%%%%%%%%%%%%%����׼��%%%%%%%%%%%%%%%
%Դ���ݹ��������Ϊ����interp3()��������
x=-100:10:100;              %xȡֵ��-100��100������Ϊ10
y=-100:10:100;
z=0:10:100;
[x,y,z]=meshgrid(x,y,z);	%ɾ������ֵ
v=ones(21,21,11);           %�������v��������
n=1;
for k=1:11          %��ά������������Ϊ���������߼�ֵ������Ĭ��Ϊ1
    for j=1:21
        for i=1:21
            v(i,j,k)=vv(n);
            n=n+1;
        end;
    end;
end;

%��ֵ����׼��
xi=-100:1:100;
yi=-100:1:100;
zi=0:1:100;
[xi,yi,zi]=meshgrid(xi,yi,zi);              %�������ʮ����ɾ��
%interp3Ҫ��(X,Y,Z)�������ϸ񵥵��Ĳ����ǵȼ��ģ����(X,Y,Z)���ǵȼ��ģ�
%�Ὣ��任Ϊ�ȼ����ʽ�������֪�ǵȼ��ģ�����method����ǰ���Ǻţ��磺'*cubic'��

%%%%%%%%%%%%%%%��ά��ֵ%%%%%%%%%%%%%%%
vi1=interp3(x,y,z,v,xi,yi,zi,'*linear');    %���Բ�ֵ(Ĭ��)
vi2=interp3(x,y,z,v,xi,yi,zi,'*cubic');     %���β�ֵ
vi3=interp3(x,y,z,v,xi,yi,zi,'*spline');    %����������ֵ
vi4=interp3(x,y,z,v,xi,yi,zi,'*nearest');   %����ڲ�ֵ��Ч�����

%%%%%%%%%%%%%%%���չʾ%%%%%%%%%%%%%%%
figure(2);slice(xi,yi,zi,vi1,82,47,88), shading flat  %��ֵͼ��Ƭ,����ɫ��Ч��
%figure(3);slice(xi,yi,zi,vi2,82,47,88), shading flat  %��ֵͼ��Ƭ
%figure(4);slice(xi,yi,zi,vi3,82,47,88), shading flat  %��ֵͼ��Ƭ
%figure(5);slice(xi,yi,zi,vi4,82,47,88), shading flat  %��ֵͼ��Ƭ



