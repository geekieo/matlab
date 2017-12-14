
% I: 载体图像
% W: 水印 
% alfa: 嵌入水印强度系数
% L: DCT系数的初始索引 
% IW：嵌入水印的图像

function IW = embedWatermark(I,W,alfa,L)
[w,h] = size(I);
% DCT变换
dctI = dct2(I);
dctI1D = matrix2vector(dctI);
dctI1DW = dctI1D;
% 嵌入水印 from L to M
  for i=L+1:L+size(W,2)
    dctI1DW(i) = dctI1D(i) + alfa*abs(dctI1D(i))*W(i-L);
    
  end
dctIW = vector2matrix(dctI1DW,w,h);
IW = uint8(idct2(dctIW));
end