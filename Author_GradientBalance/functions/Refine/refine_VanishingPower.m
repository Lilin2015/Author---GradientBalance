function p_refined = refine_VanishingPower(img,p_init,r,iter)
%refine the subpixel locations by gradient balance prior

%1.compute vanishing power
% ksize=4*sigma+1;
% kernel=fspecial('gaussian',ksize,sigma);
%kernel=fspecial('average',ksize);
V=imVanishingPower(img);

% sigma=2;
% [Gx,Gy] = imgradientxy(img,'central');
% Gm = imgaussfilt((Gx.^2+Gy.^2).^0.5,sigma);
% Gv = (imgaussfilt(Gx,sigma).^2 + imgaussfilt(Gy,sigma).^2).^0.5;
% V = Gm-Gv;
% if sigma>=3
%     figure
%     imshow(V,[]);
% end
%2.refinement
p_refined= p_init;
params=CfittingParam(r,iter);
for t = 1 : iter     
    p_refined = fitting(V,p_refined,params);
end
end




