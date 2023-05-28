
clear
close all
%% show different cross points and their vanishing power maps

%read image and calculate vanishing power map
[I_cell,V_cell]=readandGetMap();

%adjust images with gamma correction
V_cell=adjustMap(V_cell);

%show results
showResults(I_cell,V_cell);




















%%
function [I_cell,V_cell]=readandGetMap()
I1=imread('datas\images\1.jpg');
I1=rot90(I1,1);
I1=imresize(I1,[768 1024]);
if ndims(I1)==3
I1=rgb2gray(I1);
end
I1=im2double(I1);
V1=imVanishingPower(I1);

I2=imread('datas\images\2.jpg');
I2=imresize(I2,[768 1024]);
if ndims(I2)==3
I2=rgb2gray(I2);
end
I2=im2double(I2);
V2=imVanishingPower(I2);

I3=imread('datas\images\3.png');
if ndims(I3)==3
I3=rgb2gray(I3);
end
I3=im2double(I3);
V3=imVanishingPower(I3);

I4=imread('datas\images\4.png');
if ndims(I4)==3
I4=rgb2gray(I4);
end
I4=im2double(I4);
V4=imVanishingPower(I4);

I_cell={I1,I2,I3,I4};
V_cell={V1,V2,V3,V4};
end

function V_cell=adjustMap(V_cell)
maxV=max([max(V_cell{1},[],'all') max(V_cell{2},[],'all') max(V_cell{3},[],'all') max(V_cell{4},[],'all')]);
minV=0;
high=maxV;
low=minV;
top=1;
bottom=0;
gamma=0.4;
V_cell{1} = imadjust(V_cell{1}, [low;high], [bottom; top], gamma);
V_cell{2} = imadjust(V_cell{2}, [low;high], [bottom; top], gamma);
V_cell{3} = imadjust(V_cell{3}, [low;high], [bottom; top], gamma);
V_cell{4} = imadjust(V_cell{4}, [low;high], [bottom; top], gamma);
end

function showResults(I_cell,V_cell)
figure
for i=1:4
subplot(2,4,i)
imshow(I_cell{i});
subplot(2,4,i+4)
imshow(V_cell{i});
end
end