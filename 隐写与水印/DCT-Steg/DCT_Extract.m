%��ȡ xDCT,jpg �е���д��Ϣ, ���ɲ�����Ϊ xDCT,txt
%����ͼ�� xDCT,jpg Ϊ DCT_Steg ��д�����ɵ�ͼ��
image = imread('xDCT.jpg');
msg = 'xDCT.txt';
key = 153;
count =  9184;
result=extractDCTAdv(image,msg,key,count);