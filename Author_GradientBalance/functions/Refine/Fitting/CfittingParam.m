classdef CfittingParam    
    properties
        qx; %meshgrid x for the query pixels
        qy; %meshgrid y for the query pixels
        pinvA;%pinv matrix (only related to its size: r)
        iter;%number of iterations
    end
    
    methods
        function obj = CfittingParam(r,iter)
            %FITTINGPARAM 构造此类的实例
            %-r: radius of the fitting size (2*r+1) 
            [x,y] = meshgrid(-r:r,-r:r);
            x = x(:); y = y(:);
            R=2*r+1;
            A=[x.^2,x.*y,y.^2,x,y,ones(R*R,1)];
            pinvA = (A'*A)\A';
            obj.qx=x;
            obj.qy=y;
            obj.pinvA=pinvA;
            obj.iter=iter;
        end     
    end
end

