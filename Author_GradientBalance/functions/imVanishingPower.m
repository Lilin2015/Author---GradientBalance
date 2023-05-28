function V=imVanishingPower(img)
    %compute the vanishing power map of the input image 
    %-V: vanishing power map
    %-img: input image
    
    %get gradiant maps
    [Gx,Gy] = imgradientxy(img,'central');
    
    %box filter size
    fsize=7;  

    %calculate vanishing power
    fxy = (Gx.^2+Gy.^2).^0.5;
    fx=Gx;
    fy=Gy;  
    for i=1:3
        fxy=imboxfilt(fxy,fsize);
        fx=imboxfilt(fx,fsize);
        fy=imboxfilt(fy,fsize);
    end
    V=fxy-(fx.^2+fy.^2).^0.5;  
end