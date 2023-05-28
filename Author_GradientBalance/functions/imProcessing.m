function I_output = imProcessing(I_input,azimuth_deg,zenith_deg,noise_sigma,blur_sigma,black_white_level)
    %warp, blur and add noise to the image
    %-I_output: output image
    %-I_input: input image
    %-a:azimuth angle (degree)
    %-z:zenith angle (degree)
    %-n:noise degree
    %-b:blur degree

    a=azimuth_deg;
    z=zenith_deg;
    n=noise_sigma;
    b=blur_sigma;

    %adjust image contrast
    if (exist('black_white_level','var'))
        validateattributes(black_white_level,{'numeric'},{'numel',2})
        black_level = black_white_level(1);
        white_level = black_white_level(2);
        I_input = I_input*(white_level - black_level) + black_level;
    end
  
    %split the zenith to the angle along two directions
    z1=rand(1)*z;
    z2=atand(sqrt(tand(z)^2-tand(z1)^2));

    %construct the rotation matrix
    R = angle2dcm(a*pi/180,z1*pi/180,z2*pi/180);
    R(3,:) = [0,0,1];
    M=size(I_input,1);
    N=size(I_input,2);

    %warp image by projective
    I = imwarp(I_input,imref2d([M,N],[-1, 1],[-1, 1]),projective2d(R),...
        'OutputView',imref2d([M,N],[-1, 1],[-1, 1]),'FillValues',0.5,'interp','cubic');

    %image blur
    if b > 0
        bsize = 2*ceil(2*b)+1;
        kernal = fspecial('gaussian', [bsize bsize], b);
        I = imfilter(I, kernal);
    end

    %image noise
    if n > 0
        I = imnoise(I, 'gaussian', 0, n^2);
    end
    I_output=I;
end