function w = mygetWatermark(length)
w=[]; % ����ˮӡ���е�ʸ��
for i=1:length
  % �������, ��̬(0,1)�ֲ���
  w(i) = round(randn());
  if (w(i) ~= 0)
    w(i) = 1;
  end
end
end
