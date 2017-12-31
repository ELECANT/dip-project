# digital image processing project  

2017 fall course - digital image processing   

simple `matlab` implementation of some digital image topics  

## topics   
1. histogram equalization  
2. spatial enhancement method  
	- replicate padding, scale, mean, Laplacian, Sobel      
3. filtering in frequency domain   
	- Ideal, Butterworth, Gaussian lowpass/highpass filtering   
4. noise generation and reduction   
	- noise generation: uniform, Gaussian, Rayleigh, Gamma, Exponential, pepper&salt   
	- noise reduction: arithmetic mean, geometric mean, contra-harmonic; max, min, median, alpha-trimmed   
5. image restoration   
	- generation of a specified motion like blurring degradation and Gaussian noise   
	- restoration: Wiener filter and inverse filter   
6. geometric transform    
	- rotation, translation, scaling   
	- interpolation: nearest neighbor, bilinear interpolation   
7. transform image compression   
	- block transform with DCT   
	- zonal mask coding, threshold mask coding   
8. morphological reconstruction   
	- tasks: opening by reconstruction, hole filling, border clearing   
	- transform function: erosion, dilation, geodesic_dilation, dilation_reconstruction, opening_reconstruction   
9. image segmentation    
	- edge detection: Roberts, Prewitt, Sobel, Marr-Hildreth, Canny   
	- thresholding segmentation: basic global thresholding, Otsu's method    
10. image representation and description   
	- border following: basic, resmaple at large grid    
	- principal components description   


## run the code   
Every project is in a single directory, use matlab run the `problem?_main.m`  
The result images will show in the window and also write into the files in the same directory.  
*P.S. The `project 4` has two main: `problem4_main_part1.m`, `problem_main_part2.m`*  
*P.S. The `project 8` is very slow because the `hole filling` task cost about 30mins*     

## implementation    
- What I didn't do   
	- implement fft2 and fftshift (I use built-in toolbox directly)   
	- implement wavelet (I am still trying to understand them and do not finish project 7 part 2 which is about wavelet)   
- What I did    
	- all the other image processing functions are written by myself with naive code    

