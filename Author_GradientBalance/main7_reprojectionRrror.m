
clear
close all
%% reprojection errors using different methods
% [...     Matlab7 Matlab11 OpenCV7 OpenCV11 Ours
% 2-B&W
% 2-Line
% 4-B&W
% 4-Line                                         ]


%load pixelwise cross points
load('ptCell.mat');

%refine with different methods
ptCell_refined=refineWithDifferentMethods(ptCell);

%get reprojection errors
error=getReprojectionError(ptCell_refined)

























%%
function ptCell_refined=refineWithDifferentMethods(ptCell)
%cells for refined cross points 
ptCell_Matlab7=cell(1,5);% [2-b&W 5poses]
ptCell_Matlab11=cell(1,5);% [2-b&W 5poses]
ptCell_OpenCV7=cell(4,5);% [4boards 5poses]
ptCell_OpenCV11=cell(4,5);% [4boards 5poses]
ptCell_Vanish=cell(4,5);% [4boards 5poses]

patternName={'2-B&W','2-Line','4-B&W','4-Line'};
num_iters=5;
for idx_imgtype=1:4
    filePath=['datas\boards\' num2str(idx_imgtype) '\'];
    imgPathList=dir(strcat(filePath,'*.bmp'));
    numImages=length(imgPathList);

    for idx_imgNumber=1:numImages
        fprintf('process [%s] boards [%d]\n',patternName{idx_imgtype},idx_imgNumber)
        imgName=imgPathList(idx_imgNumber).name;
        imgPath=strcat(filePath,imgName);

        I=im2double(imread(imgPath));

        ptList=ptCell{idx_imgtype,idx_imgNumber};
        p_init=round(ptList);

        if idx_imgtype==1
            p_refined=refine_Matlab(I,p_init,3,num_iters);
            p_refined(isnan(p_refined(:,1)),:)=p_init(isnan(p_refined(:,1)),:);
            ptCell_Matlab7{idx_imgtype,idx_imgNumber}=p_refined;

            p_refined=refine_Matlab(I,p_init,5,num_iters);
            p_refined(isnan(p_refined(:,1)),:)=p_init(isnan(p_refined(:,1)),:);
            ptCell_Matlab11{idx_imgtype,idx_imgNumber}=p_refined;
        end

        p_refined=refine_OpenCV(I,p_init,3,num_iters);
        ptCell_OpenCV7{idx_imgtype,idx_imgNumber}=p_refined;

        p_refined=refine_OpenCV(I,p_init,5,num_iters);
        ptCell_OpenCV11{idx_imgtype,idx_imgNumber}=p_refined;

        p_refined=refine_VanishingPower(I,p_init,1,num_iters);
        p_refined(isnan(p_refined(:,1)),:)=p_init(isnan(p_refined(:,1)),:);
        ptCell_Vanish{idx_imgtype,idx_imgNumber}=p_refined;
    end
end
ptCell_refined={ptCell_Matlab7;ptCell_Matlab11;ptCell_OpenCV7;ptCell_OpenCV11;ptCell_Vanish};
end

function error=getReprojectionError(ptCell_refined)
error=zeros(4,5);
for idx_method=1:5
    ptCell_method=ptCell_refined{idx_method,1};
    for idx_imgType=1:size(ptCell_method,1)
        errorMat=zeros(5,5);
        for i=1:5
            for j=1:5
                if i==j
                    continue
                end
                pts1=ptCell_method{idx_imgType,i};
                pts2=ptCell_method{idx_imgType,j};
                tform=fitgeotform2d(pts1,pts2,"projective");
                pts=tform.transformPointsForward(pts1);
                errorMat(i,j)=mean(vecnorm(pts2-pts,2,2));
            end
        end
        error(idx_imgType,idx_method)=1.25*mean(errorMat,'all');
    end
end
end