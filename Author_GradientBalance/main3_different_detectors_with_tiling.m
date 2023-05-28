
clear
close all
%% using different cross point detectors to detect the tilings_1
I1=im2double(rgb2gray(imread('datas\tilings\1.jpg')));

crosses = detectHarrisFeatures(I1);
showResult(I1,crosses,'Harris');

crosses = detectMinEigenFeatures(I1);
showResult(I1,crosses,'minEigen');

crosses = detectFASTFeatures(I1);
showResult(I1,crosses,'FAST');

crosses = detectGBFeatures(I1);
showResult(I1,crosses,'GradientBalance');

%% using different cross point detectors to detect the tilings_2
I2=imread('datas\tilings\2.jpg');
I2=im2double(rgb2gray(I2));

crosses = detectHarrisFeatures(I2);
showResult(I2,crosses,'Harris');

crosses = detectMinEigenFeatures(I2);
showResult(I2,crosses,'minEigen');

crosses = detectFASTFeatures(I2);
showResult(I2,crosses,'FAST');

crosses = detectGBFeatures(I2);
showResult(I2,crosses,'GradientBalance');
















%%
function points=detectGBFeatures(img)

V=imVanishingPower(img);

V_nms=imNMS(V,7);
[m,n]= ind2sub(size(V_nms),find(V_nms>0));
Location=[n m];
    
metricValues=V(sub2ind(size(V),Location(:,2),Location(:,1)));
points = cornerPoints(Location, 'Metric', metricValues(:));
end


function showResult(I,crosses,figName)
showNumber=45;
strongest=crosses.selectStrongest(showNumber);
figure('Name',figName,'Position',[500 500 473 638])
imshow(I,'Border','tight','Interpolation','bilinear');
hold on
j=jet;
gap=floor(size(j,1)/showNumber);
c=j(1:gap:end,:);%color
c=c(1:showNumber,:);
c=flip(c,1);
if(isempty(strongest))
    return;
end
scatter(strongest.Location(:,1),strongest.Location(:,2),300,c,'o','LineWidth',3);
end



