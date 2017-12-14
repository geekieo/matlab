% I: ԭʼͼ�� %
% IW: Ƕ��ˮӡ�Ĵ���ͼ�� %
% W: ˮӡ�ź� %
% alfa: Ƕ��ǿ�� %
% L: Ƕ��ˮӡ��DCTϵ���ĳ�ʼ���� %


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function z = detectWatermark(IW,w,L)
dctY = dct2(IW);
dctY1D = matrix2vector(dctY);
M = size(w,2);
t = dctY1D(L+1:L+M);
%  c=corrcoef(w,t);
%  z=c(2,1);

Tz = 0;
z = 0;
  for i=1:M
    z = z + w(i)*t(i);
  end
z = z/M;
end
