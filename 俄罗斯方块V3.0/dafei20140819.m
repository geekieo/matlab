function varargout = dafei20140819(varargin)
%����˵����
%W�����ϼ�ͷ��С����5���任��״��
%A�������ͷ��С����1�����ƣ�
%S�����¼�ͷ��С����2���������ƣ�
%D�����Ҽ�ͷ��С����3�����ƣ�
%�ո������ͣ��
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dafei20140819_OpeningFcn, ...
                   'gui_OutputFcn',  @dafei20140819_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function dafei20140819_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
global shapes px py shape_colors nt1 nt nn2 fenshu player_npwz player_ffy mode nn np cg_flag pach  tt
tt=0;
[npwz,Fs1] = audioread('��������.mp3');
[ffy,Fs2] = audioread('�ַ���.mp3');
player_npwz = audioplayer(npwz, Fs1);
player_ffy = audioplayer(ffy, Fs2);
mode = true;
player_npwz.StopFcn = 'global mode player_ffy, if mode,play(player_ffy);end';
player_ffy.StopFcn = 'global mode player_npwz, if mode,play(player_npwz);end';

try
    load('fenshu');
catch
    a1=0;
    a2=0;
    a3=0;
    save('fenshu','a1','a2','a3');
end
str1=sprintf('��һ����%6.0f',a1);
str2=sprintf('�ڶ�����%6.0f',a2);
str3=sprintf('��������%6.0f',a3);
set(handles.fen_shu,'string',{str1;str2;str3})
pach=zeros(1,4);
cg_flag=0;%����ģʽ��־
nn=3000;%ÿ3000�ζ�ʱ��������������
nn2=0;
np=7;%ͼ����ʽ������ѡ��
nt1=0;
nt=16;%���ƿ���
fenshu=0;  %����ֵ
line('parent',handles.axes1,'xdata',[0,10,10,0,0],'ydata',[0,0,18,18,0])%����
shapes=zeros(2,5,20,4);
shapes(:,:,:,1) = reshape([-1  0  0 0 0  1  1  0 0  0   -1  0  0  0  1  0  2  0  0  0   ...
                            0  2  0 1 0  0  1  0 0  0   -1  0  0  0  0  1  1  1  0  0   ...
                            1  1  0 1 0  0  1  0 0  0    0  1  0  0  0 -1 -1 -1  0  0   ...
                           -1  1  0 1 0  0  1  0 0  0    0  1  0  0  0 -1  0  0  0  0   ...
                            0  1  0 0 -1 0  0  0 0  0   -1  1  0  1  0  0  0 -1  1 -1   ...
                            0  1  0 0 0  0  0  0 0  0   -1  1  0  1  0  0  1  0  1  1   ...
                            0  2  0 1 0  0 -1  0 1  0    0  0  0  0  0  0  0  0  0  0   ...
                           -1  1 -1 0 0  0  1  0 1  1   -1  0  0  0  1  0  0  1  0 -1   ...
                            -1 1  0 1 0  0  1  0 2  0   0  2  0  1  0  0  0 -1 -1 -1   ...
                            0  2  0 1 0  0  0 -1 -1 0   0  2  0  1  0  0  1  0  2  0 ],2,5,20);
  %shapes����һ�����������ʾһ�����飨patch����ÿ5�����鹹��һ��ͼ�Ρ�
  %��ĳ��ͼ�ε�5���������Ͻ�����ֱ�Ϊ��(x1,y1),(x2,y2),(x3,y3),(x4,y4),(x5,y5)��
  %��shapes(:,:,1)=reshape([x1 y1 x2 y2 x3 y3 x4 y4 x5 y5],2,5,1)
  %����20��ͼ��
for i=1:20   %20��ͼ����ÿ��ͼ����3�ֱ任ͼ��
    shapes(:,:,i,2) = [0,1;-1,0]*shapes(:,:,i,1);
    shapes(:,:,i,3) = [0,1;-1,0]*shapes(:,:,i,2);
    shapes(:,:,i,4) = [0,1;-1,0]*shapes(:,:,i,3);
end
shapes(:,:,5,4)=shapes(:,:,5,1);%������Ϊ����
shapes(:,:,5,3)=shapes(:,:,5,1);
shapes(:,:,5,2)=shapes(:,:,5,1);
shape_colors = [1 0 0;0.502 0 0;1 1 0;0.502 0.502 0;0 1 0;...
    0.502 0 0.251;0 0 1;0.251 0.502 0.502;0.502 0.502 0.502;0.251 0 0;...
    0.502 0.502 0;0 0.502 0;0.251 0 0.502;0 0 0.251;0.502 0 1;...
    0 0.502 0.7529;0.502 1 0.502;1 0.502 0.251;0 0.502 0.7529;0.502 0.502 0.7529];  %ÿ��ͼ�ε���ɫ
px = [0;-1;-1;0];  %patch��ʼλ��					
py = [0;0;-1;-1];  %patch��ʼλ��
set(handles.look,'label','�����˾͵�5��֣�')

play(player_npwz);

tic;
guidata(hObject, handles);

function p_t(obj,event,handles)
if ~ishandle(handles.figure1)
    return;
end
global shapes px py p_sel pos pach shape_colors map p_n map_x nt1 nt nn tt
global map_y pos4 fenshu p_run nn2 
global p_n2 pos42 p_sel2 p_sel_color2 np cg_flag show_flag
if ~p_run
    return;
end
nn2=nn2+1;
tt=tt+1;
if tt>=50
    tt=0;
    if nn2>nn
        nn2=nn;
    end
    str=sprintf('%2.0f��',floor((nn-nn2)*0.02));
    set(handles.next_two,'string',{'���´��������л�ʣ��';str})
end
nt1=nt1+1;
if cg_flag
    if fenshu<10000
        if show_flag
            show_flag=0;
            set(handles.level_n,'string','��1��','visible','on')
            set(handles.guanshu,'string','��ǰ������1/5')
            nn=6000;%ÿ6000�ζ�ʱ��������������
            np=7;%ͼ����ʽ������ѡ��
            nt=16;%����
            pause(1);
            set(handles.level_n,'visible','off')
        end
    elseif fenshu<20000
        if ~show_flag
            show_flag=1;
            set(handles.level_n,'string','��2��','visible','on')
            set(handles.guanshu,'string','��ǰ������2/5')
            nn=5000;%ÿ5000�ζ�ʱ��������������
            np=10;%ͼ����ʽ������ѡ��
            nt=12;%����
            pause(1);
            set(handles.level_n,'visible','off')
        end
    elseif fenshu<30000
        if show_flag
            show_flag=0;
            set(handles.level_n,'string','��3��','visible','on')
            set(handles.guanshu,'string','��ǰ������3/5')
            nn=4000;%ÿ4000�ζ�ʱ��������������
            np=13;%ͼ����ʽ������ѡ��
            nt=10;%����
            pause(1);
            set(handles.level_n,'visible','off')
        end
    elseif fenshu<40000
        if ~show_flag
            show_flag=1;
            set(handles.level_n,'string','��4��','visible','on')
            set(handles.guanshu,'string','��ǰ������4/5')
            nn=3000;%ÿ3000�ζ�ʱ��������������
            np=13;%ͼ����ʽ������ѡ��
            nt=8;%����
            pause(1);
            set(handles.level_n,'visible','off')
        end
    elseif fenshu<50000
        if show_flag
            show_flag=0;
            set(handles.level_n,'string','��5��','visible','on')
            set(handles.guanshu,'string','��ǰ������5/5')
            nn=2500;%ÿ2500�ζ�ʱ��������������
            np=20;%ͼ����ʽ������ѡ��
            nt=6;%����
            pause(1);
            set(handles.level_n,'visible','off')
        end
    else
        if show_flag
            show_flag=0;
            set(handles.level_n,'string','��ϲͨ��','visible','on')
            set(handles.guanshu,'string','��ͨ��')
            pause(1);
            set(handles.level_n,'visible','off')
        end
    end
end
cmd=get(handles.figure1,'currentkey');
if strcmp(cmd,'s') || strcmp(cmd,'downarrow') || strcmp(cmd,'numpad2')
    if toc<0.2
        nt=1;
    end
else
    if nt==1
        if strcmp(get(handles.beginner,'checked'),'on')
            nt=16;
        elseif strcmp(get(handles.intermediate,'checked'),'on')
            nt=10;
        else
            nt=4;
        end
    end
end
if nt1<nt
    return;
else
    nt1=0;
end
pos_temp = pos + [0;-1];
map_y1 = map_y;
map_x1 = map_x - 1;
if ~min(map_x1) || map(map_x1(1),map_y1(1)) || map(map_x1(2),map_y1(2)) || ...
        map(map_x1(3),map_y1(3)) || map(map_x1(4),map_y1(4)) || map(map_x1(5),map_y1(5))%������ײ���ֹͣ�½�
    if max(map_x1)>=16   %GAME OVER!
        h=findobj(handles.axes1,'type','patch');
        delete(h);
        clear h
        text(0.5,10,'GAME OVER!','parent',handles.axes1,'Color','r','fontsize',30,'fontname','�����п�');
        pach=zeros(1,5);
        stop(obj);
        delete(obj);
        clear obj
        load('fenshu');
        temp=sort([a1 a2 a3 fenshu],'descend');
        a1=temp(1);
        a2=temp(2);
        a3=temp(3);
        str1=sprintf('��һ����%6.0f',a1);
        str2=sprintf('�ڶ�����%6.0f',a2);
        str3=sprintf('��������%6.0f',a3);
        save('fenshu','a1','a2','a3');
        set(handles.fen_shu,'string',{str1;str2;str3})
        return;
    end
    for i = 1:5
        map(map_x(i),map_y(i))=1;
    end
    n=find(all(map,2));     %�Ʒ֣��ҳ�ӳ�������Ԫ��ȫΪ1����
    if ~isempty(n)
        n=sort(n,'descend');
        for k=1:length(n)
            map(n(k):end-1,:)=map(n(k)+1:end,:);
            map(end,:)=0;
        end
        if length(n)==1
            fenshu=fenshu+100;
        else
            fenshu=fenshu+100*2^length(n);%�������
        end
        set(handles.fenshu,'string',sprintf('������%6.0f',fenshu))%��ʾ����
        a=findobj(handles.axes1,'type','patch');
        b=get(a,'ydata');
        c=cell2mat(b');
        for i=1:length(n)   %����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
            line('parent',handles.axes1,'xdata',[0,10,10,0,0],'ydata',[n(i)-1,n(i)-1,n(i),n(i),n(i)-1],...
                 'LineWidth',2.1,'Color','r')%����
        end
        pause(0.2);
        for i=1:length(n)   %����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
            delete(a(find(c(1,:)==n(i))));
        end
        delete(findobj(handles.axes1,'type','line','LineWidth',2.1));
        for i=1:length(n)
            c2=a(find(c(1,:)>n(i)));
            if ~isempty(c2)
                for j=1:length(c2)
                    if ishandle(c2(j))
                        c3=get(c2(j),'ydata');
                        set(c2(j),'ydata',c3-1)
                    end
                end
            end
        end
    end
    drawnow;
    if nn2>=nn
        nn2=0;
        n1=find(any(map,2)==1);
        h=findobj(handles.axes1,'type','patch');
        if max(n1)>=14
            delete(h);
            clear h
            text(0.5,10,'GAME OVER!','parent',handles.axes1,'Color','r','fontsize',30,'fontname','�����п�');
            load('fenshu');
            temp=sort([a1 a2 a3 fenshu],'descend');
            a1=temp(1);
            a2=temp(2);
            a3=temp(3);
            str1=sprintf('��һ����%6.0f',a1);
            str2=sprintf('�ڶ�����%6.0f',a2);
            str3=sprintf('��������%6.0f',a3);
            save('fenshu','a1','a2','a3');
            set(handles.fen_shu,'string',{str1;str2;str3})
            pach=zeros(1,5);
            return;
        else
            map2=randi([0 1],2,10);
            map(3:end,:)=map(1:end-2,:);
            map(1:2,:)=map2;
            if ~isempty(h)
                for kk=1:length(h)
                	set(h(kk),'ydata',get(h(kk),'ydata')+2)
                end
            end
            drawnow;
            for ix=1:2
                for iy=1:10
                    if map2(ix,iy)
                        patch(px + iy,py+ix,[1 0 0],'parent',handles.axes1);
                    end
                end
            end
            drawnow;
        end
    end
    p_n = p_n2;
    pos4 = pos42;
    p_sel = p_sel2;   %�����ȡpatch
    p_sel_color = p_sel_color2;%�����ȡ��ɫ
    pos = [5;16];   %��ʼ��ͼ�γ�ʼλ��
    p_n2=randi([1,np]); 
    pos42=randi([1,4]); 
    p_sel2=shapes(:,:,p_n2,pos42);  
    p_sel_color2=shape_colors(p_n2,:);
    delete(findobj(handles.axes2,'type','patch'));
    pach=zeros(1,5);
    for i = 1:5     %����ӳ�����map��������һ���µ�ͼ��
        pach(i) = patch(px + pos(1) + p_sel(1,i),...
            py + pos(2) + p_sel(2,i),p_sel_color,'parent',handles.axes1);
        patch(px + p_sel2(1,i),py + p_sel2(2,i),p_sel_color2,'parent',handles.axes2);
    end
    map_y = p_sel(1,:) + pos(1);%�²�����ͼ��λ�õ�ӳ��
    map_x = p_sel(2,:) + pos(2);%�²�����ͼ��λ�õ�ӳ��
    pause(0.02);
    drawnow;
else
    if nt==1
        if strcmp(get(handles.beginner,'checked'),'on')
            nt=16;
        elseif strcmp(get(handles.intermediate,'checked'),'on')
            nt=10;
        else
            nt=4;
        end
    end
    pos = pos_temp;
    map_x = map_x1;
    map_y = map_y1;
    for i = 1:5
        set(pach(i),'XData',px+pos(1) + p_sel(1,i),'YData',py+pos(2) + p_sel(2,i),'parent',handles.axes1);
    end
    drawnow;
end

function varargout = dafei20140819_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function figure1_KeyPressFcn(hObject, eventdata, handles)
global shapes px py p_sel pos pach shape_colors map p_n map_x nn nn2
global map_y pos4 fenshu p_run 
cmd=get(hObject,'currentkey');
if strcmp(cmd,'f5')
    restart_Callback(hObject, eventdata, handles);
    return;
end
if ~all(pach)
    return;
end
x_pos=cell2mat(get(pach,'xdata'));
switch cmd
    case {'a','leftarrow','numpad1'}     %����
        p_run=0;
        pos_temp = pos + [-1;0];
        map_y1 = map_y - 1;
        map_x1 = map_x;
        if min(x_pos)>0 && (~map(map_x1(1),map_y1(1))) &&...
                (~map(map_x1(2),map_y1(2))) && (~map(map_x1(3),map_y1(3))) && ...
                (~map(map_x1(4),map_y1(4))) && (~map(map_x1(5),map_y1(5)))
            pos=pos_temp;
            map_y = map_y1;
            map_x = map_x1;
            for i = 1:5
                set(pach(i),'XData',px+pos(1) + p_sel(1,i),'YData',py+pos(2) + p_sel(2,i));
            end
        end
        p_run=1;
    case {'d','rightarrow','numpad3'}    %����
        p_run=0;
        pos_temp = pos + [1;0];
        map_y1 = map_y + 1;
        map_x1 = map_x;
        if max(x_pos)<10 && (~map(map_x1(1),map_y1(1))) && (~map(map_x1(2),map_y1(2))) && ...
                (~map(map_x1(3),map_y1(3))) && (~map(map_x1(4),map_y1(4))) &&(~map(map_x1(5),map_y1(5)))
            pos = pos_temp;
            map_y = map_y1;
            map_x = map_x1;
            for i = 1:5
                set(pach(i),'XData',px+pos(1) + p_sel(1,i),'YData',py+pos(2) + p_sel(2,i));
            end
        end
        p_run=1;
    case {'s','downarrow','numpad2'}
        tic;
    case {'w','uparrow','numpad5'}   %�任
        pos4_temp=pos4;
        if pos4_temp==4
            pos4_temp=1;
        else
            pos4_temp=pos4_temp+1;
        end
        psel_temp=shapes(:,:,p_n,pos4_temp);   
        mapy_temp = psel_temp(1,:) + pos(1);
        mapx_temp = psel_temp(2,:) + pos(2);
        a=zeros(5,4);
        for i = 1:5
            a(i,:)=px + pos(1) + psel_temp(1,i);
        end
        if min(min(a))>=0 && max(max(a))<=10 && all(mapx_temp) && all(mapy_temp) && ...
                (~map(mapx_temp(1),mapy_temp(1))) && ...
                (~map(mapx_temp(2),mapy_temp(2))) && (~map(mapx_temp(3),mapy_temp(3))) &&...
                (~map(mapx_temp(4),mapy_temp(4))) && (~map(mapx_temp(5),mapy_temp(5))) 
            pos4 = pos4_temp;
            p_sel = psel_temp;
            map_y = mapy_temp;
            map_x = mapx_temp;
            for i = 1:5
                set(pach(i),'XData',a(i,:),'YData',py+pos(2) + p_sel(2,i));
            end
        end
    case 'space'      %��ͣ
        p_run=~p_run;
end

function caidan_Callback(hObject, eventdata, handles)

function help_Callback(hObject, eventdata, handles)

function method_Callback(hObject, eventdata, handles)
message={'����˵��:';'W�����ϼ�ͷ��С����5���任��״��';'A�������ͷ��С����1�����ƣ�';...
'S�����¼�ͷ��С����2���������ƣ�';'D�����Ҽ�ͷ��С����3�����ƣ�';'�ո������ͣ��'};
msgbox(message,'��Ϸ�淨','none');

function about_Callback(hObject, eventdata, handles)
msgbox({'�汾��V3.0';'BY �޻���';'2014.8.19'},'����.','none');

function restart_Callback(hObject, eventdata, handles)
global shapes px py p_sel p_sel_color pos pach shape_colors p_run map p_n map_x map_y pos4 fenshu np
global p_n2 pos42 p_sel2 p_sel_color2 nn2 nt1
nn2=0;
nt1=0;
p_run=0;
t=timerfind;
if ~isempty(t)
    stop(t);
    delete(t);
    clear t
end
try
    delete(findobj(handles.axes1,'type','patch','-or','type','text'));
end
set(handles.level_n,'visible','off')
fenshu=0;
pos=[5;16];
set(handles.fenshu,'string','������0')
map=zeros(18,10);     %ӳ�����
%��ÿ�������λ��ӳ�䵽һ��10*18�ľ����У�������ĳ��Ԫ��Ϊ1����Ӧ��λ�ô��ڷ���
%�����ж����к�ͼ���Ƿ񵽴�ײ�
p_n=randi([1,np]);
pos4=randi([1,4]);
p_sel=shapes(:,:,p_n,pos4);   %�����ȡpatch
p_sel_color=shape_colors(p_n,:);
map_y = p_sel(1,:) + pos(1);
map_x = p_sel(2,:) + pos(2);
p_n2=randi([1,np]); 
pos42=randi([1,4]); 
p_sel2=shapes(:,:,p_n2,pos42);  
p_sel_color2=shape_colors(p_n2,:);
delete(findobj(handles.axes2,'type','patch'));
pach=zeros(1,5);
for i = 1:5
    pach(i) = patch(px + pos(1) + p_sel(1,i),py + pos(2) + p_sel(2,i),p_sel_color,'parent',handles.axes1);
    patch(px + p_sel2(1,i),py + p_sel2(2,i),p_sel_color2,'parent',handles.axes2);
end
t=timer('BusyMode','queue','ExecutionMode','fixedSpacing',...
    'Period',0.02,'TimerFcn',{@p_t,handles});
p_run=1;
start(t);

function stop_game_Callback(hObject, eventdata, handles)
global p_run fenshu pach
p_run=0;
t=timerfind;
stop(t);
delete(findobj(handles.axes1,'type','patch'));
text(0.5,10,'GAME OVER!','parent',handles.axes1,'Color','r','fontsize',30,'fontname','�����п�');
load('fenshu');
temp=sort([a1 a2 a3 fenshu],'descend');
a1=temp(1);
a2=temp(2);
a3=temp(3);
str1=sprintf('��һ����%6.0f',a1);
str2=sprintf('�ڶ�����%6.0f',a2);
str3=sprintf('��������%6.0f',a3);
save('fenshu','a1','a2','a3');
set(handles.fen_shu,'string',{str1;str2;str3})
pach=zeros(1,5);

function beginner_Callback(hObject, eventdata, handles)
global nt nn np
set(handles.fenshu,'string','������0')
set(handles.beginner,'checked','on')
set(handles.intermediate,'checked','off')
set(handles.expert,'checked','off')
nt=16;
np=7;
nn=3000;

function intermediate_Callback(hObject, eventdata, handles)
global nt nn np
set(handles.fenshu,'string','������0')
set(handles.beginner,'checked','off')
set(handles.intermediate,'checked','on')
set(handles.expert,'checked','off')
nt=10;
np=14;
nn=2500;

function expert_Callback(hObject, eventdata, handles)
global nt nn np
set(handles.fenshu,'string','������0')
set(handles.beginner,'checked','off')
set(handles.intermediate,'checked','off')
set(handles.expert,'checked','on')
nt=4;
np=20;
nn=2000;

function sound_Callback(hObject, eventdata, handles)

function look_Callback(hObject, eventdata, handles)

function comm_Callback(hObject, eventdata, handles)

function chuangguan_Callback(hObject, eventdata, handles)
global fenshu p_run nn np cg_flag show_flag
cg_flag=~cg_flag;
if cg_flag
    p_run=0;
    t=timerfind;
    if ~isempty(t)
        stop(t);
        delete(t);
        clear t
    end
    try
        delete(findobj(handles.axes1,'type','patch','-or','type','text'));
        delete(findobj(handles.axes2,'type','patch'));
    end
    fenshu=0;
    set(handles.fenshu,'string','������0')
    set(handles.level_n,'visible','on','string','����ģʽ')
    set(hObject,'checked','on')
    set(handles.comm,'enable','off')
    set(handles.guanshu,'string','��ǰ������1/5','visible','on')
    show_flag=1;
    p_run=1;
else
    set(handles.level_n,'visible','off')
    set(hObject,'checked','off')
    set(handles.comm,'enable','on')
    set(handles.guanshu,'visible','off')
    show_flag=0;
end

function no_music_Callback(hObject, eventdata, handles)
global mode player_npwz player_ffy
set(hObject,'checked','on')
set([handles.npwz,handles.ffy],'checked','off');
mode = false;
stop(player_npwz);
stop(player_ffy);

function npwz_Callback(hObject, eventdata, handles)
global mode player_npwz player_ffy
set(hObject,'checked','on')
set(handles.ffy,'checked','off');
mode = false;
stop(player_npwz);
stop(player_ffy);
mode = true;
play(player_npwz);

function ffy_Callback(hObject, eventdata, handles)
global mode player_npwz player_ffy
set(hObject,'checked','on')
set(handles.npwz,'checked','off');
mode = false;
stop(player_npwz);
stop(player_ffy);
mode = true;
play(player_ffy);

function figure1_CloseRequestFcn(hObject, eventdata, handles)
t=timerfind;
if ~isempty(t)
    stop(t);
    delete(t);
    clear t
end
global fenshu p_run
if p_run
    load('fenshu');
    temp=sort([a1 a2 a3 fenshu],'descend');
    a1 = temp(1);
    a2 = temp(2);
    a3 = temp(3);
    save('fenshu', 'a1', 'a2', 'a3');
end
global mode player_npwz player_ffy
mode = false;
stop(player_npwz);
stop(player_ffy);
clear global
delete(hObject);

function sel_music_Callback(hObject, eventdata, handles)
[FileName,PathName,FilterIndex] = uigetfile('*.mp3','ѡ�������ļ�');
if FilterIndex == 1
    global mode player3 player_npwz player_ffy
    mode = false;
    stop(player_npwz);
    stop(player_ffy);
    str = [PathName FileName];
    [y,Fs] = audioread(str);
    player3 = audioplayer(y, Fs);
    player3.StopFcn = 'global mode player3, if mode,play(player3);end';
    
    mode = true;
    play(player3);
end


