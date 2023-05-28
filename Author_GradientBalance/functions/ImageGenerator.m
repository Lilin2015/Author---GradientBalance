classdef ImageGenerator<handle
    %IMAGEGENERATOR 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        blur = 0.0:0.5:5;
        noise = eps:0.005:0.05+eps;
        azi = 0:360;
        zen = eps:5:60+eps;        
        fixedBlur=1;
        fixedNoise=0.01;
        lessZen=eps:5:30+eps;
        black_white_level=[0.1 0.9];
    end
    
    methods
        function obj = ImageGenerator()
            %IMAGEGENERATOR 构造此类的实例
            %   此处显示详细说明
        end
        
        function [imgPrototype,p_init,p_true] = generateImgPrototype(obj,imgType,halfImgSize)
            %METHOD1 此处显示有关此方法的摘要
            %   此处显示详细说明
            if strcmp('Checkerboard',imgType) || imgType==1
                imgPrototype=zeros(2*halfImgSize,2*halfImgSize);
                imgPrototype(1:halfImgSize,1:halfImgSize)=1;
                imgPrototype(halfImgSize+1:end,halfImgSize+1:end)=1;
            elseif strcmp('Pinwheelblock',imgType) || imgType==2
                imgPrototype=ones(2*halfImgSize,2*halfImgSize);
                imgPrototype=insertShape(imgPrototype,"filled-polygon",...
                    [1 1 1 halfImgSize+1 halfImgSize+1 halfImgSize+1;...
                    halfImgSize 1 2*halfImgSize 1 halfImgSize halfImgSize+1;...
                    1 2*halfImgSize halfImgSize+1 halfImgSize halfImgSize+1 2*halfImgSize;...
                    halfImgSize halfImgSize 2*halfImgSize halfImgSize 2*halfImgSize 2*halfImgSize],...
                    "Color","black","Opacity",1);
                imgPrototype=rgb2gray(imgPrototype);
            end

            p_init=[halfImgSize halfImgSize; halfImgSize+1 halfImgSize;...
                halfImgSize halfImgSize+1;halfImgSize+1 halfImgSize+1];
            p_true=[halfImgSize+.5 halfImgSize+.5];  
        end

        function imgCell=generateImgWithoutBlur(obj,imgPrototype,imgNumbers)
            imgCell=cell(imgNumbers,1);
            for i=1:imgNumbers
                fprintf('generate images [%d/%d]\n',i,imgNumbers)
                z=(rand(1)*(obj.lessZen(end)-obj.lessZen(1))+obj.lessZen(1));
                a=(rand(1)*(obj.azi(end)-obj.azi(1))+obj.azi(1));
                n=obj.fixedNoise;
                b=0;
                bw=obj.black_white_level;
                imgCell{i,1}=imProcessing(imgPrototype,a,z,n,b,bw);
            end
        end

        function imgCell=generateImgWithFixedNoise(obj,imgPrototype,imgNumbers,noise_sigma_List)
            imgCell=cell(imgNumbers,size(noise_sigma_List,2));
            for i=1:size(noise_sigma_List,2)
                for j=1:imgNumbers
                    fprintf('generate images [%d/%d] with noise [%d/%d]\n',j,imgNumbers,i,size(noise_sigma_List,2))
                    z=(rand(1)*(obj.lessZen(end)-obj.lessZen(1))+obj.lessZen(1));
                    a=(rand(1)*(obj.azi(end)-obj.azi(1))+obj.azi(1));
                    n=noise_sigma_List(i);
                    b=obj.fixedBlur;
                    bw=obj.black_white_level;
                    imgCell{j,i}=imProcessing(imgPrototype,a,z,n,b,bw);
                end
            end
        end

        function imgCell=generateImgWithFixedZenith(obj,imgPrototype,imgNumbers,zenith_degree_List)
            imgCell=cell(imgNumbers,size(zenith_degree_List,2));
            for i=1:size(zenith_degree_List,2)
                for j=1:imgNumbers
                    fprintf('generate images [%d/%d] with zenith [%d/%d]\n',j,imgNumbers,i,size(zenith_degree_List,2))
                    z=zenith_degree_List(i);
                    a=(rand(1)*(obj.azi(end)-obj.azi(1))+obj.azi(1));
                    n=obj.fixedNoise;
                    b=obj.fixedBlur;
                    bw=obj.black_white_level;
                    imgCell{j,i}=imProcessing(imgPrototype,a,z,n,b,bw);
                end
            end
        end

        function imgCell=generateImgWithFixedBlur(obj,imgPrototype,imgNumbers,blur_sigma_List)
            imgCell=cell(imgNumbers,size(blur_sigma_List,2));
            for i=1:size(blur_sigma_List,2)
                for j=1:imgNumbers
                    fprintf('generate images [%d/%d] with blur [%d/%d]\n',j,imgNumbers,i,size(blur_sigma_List,2))
                    z=(rand(1)*(obj.lessZen(end)-obj.lessZen(1))+obj.lessZen(1));
                    a=(rand(1)*(obj.azi(end)-obj.azi(1))+obj.azi(1));
                    n=obj.fixedNoise;
                    b=blur_sigma_List(i);
                    bw=obj.black_white_level;
                    imgCell{j,i}=imProcessing(imgPrototype,a,z,n,b,bw);
                end
            end
        end
    end
end

