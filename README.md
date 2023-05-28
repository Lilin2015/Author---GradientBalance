# Author---GradientBalance
This is the code of the paper, "Detecting Cross Points with Subpixel Accuracy based on Gradient Balance Prior and Vanishing Power Transform"
## Introduction
In this paper, we propose gradient balance prior to centrosymmetric cross patterns. Using this prior, we develop vanishing power transform to convert grayscale images into response maps, highlighting every cross point satisfying centrosymmetry condition as humps.

## Centrosymmetric cross point
Examples of centrosymmetric and non-centrosymmetric cross points.

![image](https://github.com/Lilin2015/Author---GradientBalance/assets/17568542/b5b4c371-361d-410e-b233-30f279b76e7a)

## Gradient balance prior and Vanishing power map
Gradient balance prior: the vector sum of the gradients surrounding a centrosymmetric cross point is zero.

Vanishing power transform: convert grayscale images into response maps.

The whole Vanishing power map V can be calculated by the tranform

![image](https://user-images.githubusercontent.com/17568542/201604838-ff0e3855-953f-48ef-a400-cc292c80582c.png)

where Gx, Gy is the gradients, k is a isotropix low-pass sampling kernel.   

![image](https://user-images.githubusercontent.com/17568542/201600973-15d49af0-f23b-4c0c-a457-6af49e3cd324.png)

a) A checkerboard cross point and its gradient vectors; 
b,c) Its vanishing power map.

## How to use
For algorithm, run the "example_detection_and_localization.m".

For comparsions in our paper, run the "comparsion_XXX.m"

The rest of the experiment codes will be uploaded within a week (in 2022/11/21).
