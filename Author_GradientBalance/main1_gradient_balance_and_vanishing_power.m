
clear
close all
%% show different cross points and their vanishing power maps

for i=1:4
    I=imread(strcat("datas\cross patterns\",num2str(i),".png"));

    Img=im2double(rgb2gray(I));
    r=25;
    Img=Img(101-r:100+r,101-r:100+r);
    V=imVanishingPower(Img);

    figure
    %show origin image
    subplot(1,4,1)
    imshow(Img,'border','tight','initialmagnification','fit');
    %show vanishing power map
    subplot(1,4,2)
    imshow(V,[],'border','tight','initialmagnification','fit');
    hold on
    rectangle('Position',[r-4.5 r-4.5 10 10],'EdgeColor','r');
    %show the 3D profile of cross center
    subplot(1,4,[3 4])
    [X,Y]=meshgrid(1:2*r);
    [Xq,Yq]=meshgrid(r-4.5:0.5:r+5.5);
    Vq = interp2(X,Y,V,Xq,Yq);
    Vq=imgaussfilt(Vq,2);
    surf(Xq,Yq,Vq);
    set(gca,'xticklabel',[])
    set(gca,'yticklabel',[])
    set(gca,'zticklabel',[])
    axis off
end