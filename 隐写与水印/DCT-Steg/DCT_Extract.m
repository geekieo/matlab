%提取 xDCT,jpg 中的隐写信息, 生成并命名为 xDCT,txt
%输入图像 xDCT,jpg 为 DCT_Steg 隐写后生成的图像
image = imread('xDCT.jpg');
msg = 'xDCT.txt';
key = 153;
count =  9184;
result=extractDCTAdv(image,msg,key,count);