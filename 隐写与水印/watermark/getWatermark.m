function w = mygetWatermark(length)
w=[]; % 包含水印序列的矢量
for i=1:length
  % 随机序列, 正态(0,1)分布，
  w(i) = round(randn());
  if (w(i) ~= 0)
    w(i) = 1;
  end
end
end
