function p_refined = refine_Matlab(img,p_init,r,iter)
%compute the saddle point of a saddle surface by fitting

img=imgaussfilt(img);

p_refined= p_init;
params=CfittingParam(r,iter);
for t = 1 : iter     
    p_refined = fitting(img,p_refined,params);
end
end

