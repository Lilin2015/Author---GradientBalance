clear
close all
%% generator image prototypes (I1 is a 2-B&W, I2 is a 4-B&W)
gnt=ImageGenerator();

halfImageSize=100;
I1=gnt.generateImgPrototype(1,halfImageSize);
[I2,p_init,p_true]=gnt.generateImgPrototype(2,halfImageSize);


%% generate image
%imgNumbers=1000;
imgNumbers=100;% you can use 100 instead of 1000 to get results quickly
blurList=0:1:5;
blurNumbers=size(blurList,2);

I1_cell=gnt.generateImgWithFixedBlur(I1,imgNumbers,blurList);
I2_cell=gnt.generateImgWithFixedBlur(I2,imgNumbers,blurList);


%% run
num_iters=5;

error_mat_pattern1=zeros(imgNumbers,blurNumbers,5);
error_mat_pattern2=zeros(imgNumbers,blurNumbers,3);

for idx_blur=1:blurNumbers
    for idx_img=1:imgNumbers
        I1=I1_cell{idx_img,idx_blur};
        I2=I2_cell{idx_img,idx_blur};
        fprintf('process images [%d/%d] with blur [%d/%d]\n',idx_img,imgNumbers,idx_blur,blurNumbers)

        %2-B&W
        M7 = @()refine_Matlab(I1,p_init,3,num_iters);
        M11 = @()refine_Matlab(I1,p_init,5,num_iters);
        O7 = @()refine_OpenCV(I1,p_init,3,num_iters);
        O11 = @()refine_OpenCV(I1,p_init,5,num_iters);
        V = @()refine_VanishingPower(I1,p_init,1,num_iters);
        methodCell={M7,M11,O7,O11,V};
        err=runAllmethod(methodCell,p_true);

        error_mat_pattern1(idx_img,idx_blur,:)=err;
 
        %4-B&W
        O7= @()refine_OpenCV(I2,p_init,3,num_iters);
        O11 = @()refine_OpenCV(I2,p_init,5,num_iters);
        V = @()refine_VanishingPower(I2,p_init,1,num_iters);
        methodCell={O7,O11,V};
        err=runAllmethod(methodCell,p_true);

        error_mat_pattern2(idx_img,idx_blur,:)=err;      
    end
end

%% show results
blurList=0:1:5;
blurNumbers=size(blurList,2);

error1_mean=mean(error_mat_pattern1,1);
error2_mean=mean(error_mat_pattern2,1);

error1=reshape(error1_mean,[blurNumbers 5]);
error2=reshape(error2_mean,[blurNumbers 3]);

figure('Name','2-B&W blur')
plot(blurList, error1(:,1), 'gs-','MarkerSize',10, 'LineWidth', 1.5);  hold on;
plot(blurList, error1(:,2), 'go-','MarkerSize',10, 'LineWidth', 1.5);
plot(blurList, error1(:,3), 'bs-','MarkerSize',10, 'LineWidth', 1.5);
plot(blurList, error1(:,4), 'bo-','MarkerSize',10, 'LineWidth', 1.5);
plot(blurList, error1(:,5), 'rs-','MarkerSize',10, 'LineWidth', 1.5);
axis([0 inf 0.0 0.2]);
xlabel('Gaussian Blur \sigma');
ylabel('Mean Localization Error');
set(gca, 'FontSize', 20,'Box','off');
grid on; grid minor;
legend('Matlab(7\times7)','Matlab(11\times11)','OpenCV(7\times7)','OpenCV(11\times11)','Ours','Fontsize',16,'Location','northwest')


figure('Name','4-B&W blur')
plot(blurList, error2(:,1), 'bs-','MarkerSize',10, 'LineWidth', 1.5); hold on
plot(blurList, error2(:,2), 'bo-','MarkerSize',10, 'LineWidth', 1.5);
plot(blurList, error2(:,3), 'rs-','MarkerSize',10, 'LineWidth', 1.5);
axis([0 inf 0.0 1.0]);
xlabel('Gaussian Blur \sigma');
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