# Author---GradientBalance
This is the code of the paper, "Detecting Cross Points with Subpixel Accuracy based on Gradient Balance Prior and Vanishing Power Transform"
## Introduction
In this paper, we propose a brief centrosymmetric cross point detection and localization method based on our gradient balance piror.

## Centrosymmetric cross point
cross points with centrosymmetry.

![image](https://user-images.githubusercontent.com/17568542/201601534-835900a1-c1af-44ee-80ca-5f631b025050.png)

## Gradient balance prior and Vanishing power map
Gradient balance prior: the vector sum of the gradients surrounding a centrosymmetric cross point is zero.

Vanishing power map: the vanishing power of the gradients around each pixel.

The whole map V can be calculated by

![image](https://user-images.githubusercontent.com/17568542/201604838-ff0e3855-953f-48ef-a400-cc292c80582c.png)

where Gx, Gy is the gradients, k is a sampling kernel.   

![image](https://user-images.githubusercontent.com/17568542/201600973-15d49af0-f23b-4c0c-a457-6af49e3cd324.png)

a) A checkerboard cross point and its gradient vectors; 
b,c) The response map of vanishing power.

## How to use
For algorithm, run the "example_detection_and_localization.m".

For comparsions in our paper, run the "comparsion_XXX.m"

The rest of the experiment codes will be uploaded within a week (in 2022/11/21).
