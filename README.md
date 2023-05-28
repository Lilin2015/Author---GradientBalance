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
For algorithm, run the "mainX_XXX.m".
main1_gradient_balance_and_vanishing_power: cross points and their vanishing power map.

<img src="https://github.com/Lilin2015/Author---GradientBalance/assets/17568542/1e9d4ead-4cf1-4039-8b10-59f5d6e15375" width="400">

main2_examples_of_different_images_and_response_maps: images and their vanishing power map.

<img src="https://github.com/Lilin2015/Author---GradientBalance/assets/17568542/64b875f8-03b7-4130-98a5-db672af61760" width="600">

main3_different_detectors_with_tiling: the results of different cross point (corner) detectors. The top 45 pixels
are marked

<img src="https://github.com/Lilin2015/Author---GradientBalance/assets/17568542/167f0a2f-dd13-4fa8-a738-40615d3b4453" width="600">

main4 ~ main6: the accuracy comparison of differnet subpixel refinement methods with simulated images

<img src="https://github.com/Lilin2015/Author---GradientBalance/assets/17568542/ef40c711-a93c-41a7-a723-7ab8d49bb70b" width="400">

main7_reprojectionRrror: the accuracy comparison of differnet subpixel refinement methods with real images


<img src="https://github.com/Lilin2015/Author---GradientBalance/assets/17568542/99023b3e-b8e2-49a0-984d-690539eb7cad" width="250">
<img src="https://github.com/Lilin2015/Author---GradientBalance/assets/17568542/b5ed1105-3de9-4840-9eb3-734d3d6d49cf" width="250">
