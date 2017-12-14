function c=matrix2vector(matrix) 

[y,x]=size(matrix);
c = 1:(y*x);
c = c.*0;
  for k = 1:y;
    for p =1:x;
      c(p+(k-1)*(y))= matrix(k,p);
    end
  end