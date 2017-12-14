
% I: ����ͼ��
% W: ˮӡ 
% alfa: Ƕ��ˮӡǿ��ϵ��
% L: DCTϵ���ĳ�ʼ���� 
% IW��Ƕ��ˮӡ��ͼ��

function IW = embedWatermark(I,W,alfa,L)
[w,h] = size(I);
% DCT�任
dctI = dct2(I);
dctI1D = matrix2vector(dctI);
dctI1DW = dctI1D;
% Ƕ��ˮӡ from L to M
  for i=L+1:L+size(W,2)
    dctI1DW(i) = dctI1D(i) + alfa*abs(dctI1D(i))*W(i-L);
    
  end
dctIW = vector2matrix(dctI1DW,w,h);
IW = uint8(idct2(dctIW));
end