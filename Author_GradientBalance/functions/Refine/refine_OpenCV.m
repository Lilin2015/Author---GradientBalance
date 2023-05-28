function p_refined = refine_OpenCV(img,p_init,r,iter)
%the gradient at each pixel is orthogonal to its vector pointing to the center

[Gx,Gy] = imgradientxy(img,'central');

p_refined=p_init;
for t = 1 : iter
    p_refined = getOrthogonalCenter(Gx,Gy,p_refined,r);
end
end

function p_output = getOrthogonalCenter(Gx,Gy,p_input,r)
p_output=p_input;
numPoints = size(p_input,1);
x=p_input(:,1)';
y=p_input(:,2)';

[mx,my] = meshgrid(1:size(Gx,2),1:size(Gx,1));
[qx,qy] = meshgrid(-r:r,-r:r);
qx=x+qx(:);qy=y+qy(:);

%the patch of gradient image
%each column represent the patch around a point
Gx_patch = interp2(mx,my,Gx,qx,qy);
Gy_patch = interp2(mx,my,Gy,qx,qy);

p = Gx_patch.*qx+Gy_patch.*qy;% (Gx * x) +(Gy * y)

for it=1:numPoints
    %[x y]=[Gx Gy]\[Gx*x Gy*y]
    q = [Gx_patch(:,it),Gy_patch(:,it)]\p(:,it);
    p_output(it,:)=q;
end
end
