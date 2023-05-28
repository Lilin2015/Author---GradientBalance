clear
close all
%% generator image prototypes  (I1 is a 2-B&W, I2 is a 4-B&W)
gnt=ImageGenerator();

halfImageSize=100;
I1=gnt.generateImgPrototype(1,halfImageSize);
[I2,p_init,p_true]=gnt.generateImgPrototype(2,halfImageSize);


%% generate image
%imgNumbers=1000;
imgNumbers=100;% you can use 100 instead of 1000 to get results quickly
zenithList=eps:10:50;
zenithNumbers=size(zenithList,2);

I1_cell=gnt.generateImgWithFixedZenith(I1,imgNumbers,zenithList);
I2_cell=gnt.generateImgWithFixedZenith(I2,imgNumbers,zenithList);


%% run
num_iters=5;

error_mat_pattern1=zeros(imgNumbers,zenithNumbers,5);
error_mat_pattern2=zeros(imgNumbers,zenithNumbers,3);

for idx_zenith=1:zenithNumbers
    for idx_img=1:imgNumbers
        I1=I1_cell{idx_img,idx_zenith};
        I2=I2_cell{idx_img,idx_zenith};
        fprintf('process images [%d/%d] with zenith [%d/%d]\n',idx_img,imgNumbers,idx_zenith,zenithNumbers)

        %2-B&W
        M7 = @()refine_Matlab(I1,p_init,3,num_iters);
        M11 = @()refine_Matlab(I1,p_init,5,num_iters);
        O7 = @()refine_OpenCV(I1,p_init,3,num_iters);
        O11 = @()refine_OpenCV(I1,p_init,5,num_iters);
        V = @()refine_VanishingPower(I1,p_init,1,num_iters);
        methodCell={M7,M11,O7,O11,V};
        err=runAllmethod(methodCell,p_true);

        error_mat_pattern1(idx_img,idx_zenith,:)=err;        

        %4-B&W
        O7= @()refine_OpenCV(I2,p_init,3,num_iters);
        O11 = @()refine_OpenCV(I2,p_init,5,num_iters);
        V = @()refine_VanishingPower(I2,p_init,1,num_iters);
        methodCell={O7,O11,V};
        err=runAllmethod(methodCell,p_true);

        error_mat_pattern2(idx_img,idx_zenith,:)=err;
    end
end

%%
zenithList=eps:10:50;
zenithNumbers=size(zenithList,2);

error1_mean=mean(error_mat_pattern1,1);
error2_mean=mean(error_mat_pattern2,1);


error1=reshape(error1_mean,[zenithNumbers 5]);
error2=reshape(error2_mean,[zenithNumbers 3]);

figure('Name','2-B&W zenith')
plot(zenithList, error1(:,1), 'gs-','MarkerSize',10, 'LineWidth', 1.5);  hold on;
plot(zenithList, error1(:,2), 'gs-','MarkerSize',10, 'LineWidth', 1.5);
plot(zenithList, error1(:,3), 'bs-','MarkerSize',10, 'LineWidth', 1.5);
plot(zenithList, error1(:,4), 'bo-','MarkerSize',10, 'LineWidth', 1.5);
plot(zenithList, error1(:,5), 'rs-','MarkerSize',10, 'LineWidth', 1.5);
axis([0 inf 0.0 0.2]);
xlabel('Zenith Angle \phi');
ylabel('Mean Localization Error');
set(gca, 'FontSize', 20,'Box','off');
grid on; grid minor;


figure('Name','4-B&W zenith')
plot(zenithList, error2(:,1), 'bs-','MarkerSize',10, 'LineWidth', 1.5); hold on
plot(zenithList, error1(:,2), 'bo-','MarkerSize',10, 'LineWidth', 1.5);
plot(zenithList, error2(:,3), 'rs-','MarkerSize',10, 'LineWidth', 1.5);
axis([0 inf 0.0 1.0]);
xlabel('Zenith Angle \phi');
ylabel('Mean Localization Error');
set(gca, 'FontSize', 20,'Box','off');
grid on; grid minor;

%%
function errorList=runAllmethod(methodCell,p_true)
errorList=zeros(1,size(methodCell,2));
for i=1:size(methodCell,2)
    f=methodCell{i};
    p_refined=f();
    err = getError(p_refined,p_true);
    errorList(i)=err;
end
end
