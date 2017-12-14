function c = vector2matrix(vector,width,height)
[total]=size(vector);
c = zeros(height,width);
for k = 1:height;
  for p =1:width;
    c(k,p)= vector(p+(k-1)*(width));
  end
end