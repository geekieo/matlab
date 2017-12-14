% I: 原始图像 %
% IW: 嵌入水印的待测图像 %
% W: 水印信号 %
% alfa: 嵌入强度 %
% L: 嵌入水印的DCT系数的初始索引 %


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
