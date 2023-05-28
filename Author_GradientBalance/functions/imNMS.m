function I=imNMS(I,filterSize)
D=imdilate(I,strel('square',filterSize));
I(D~=I)=0;
end