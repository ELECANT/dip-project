# Project 2

## Task
(a) original image -> (b) laplacian [to show the image, need rearrange the pix] -> (c)sharpen by adding laplacian 
(a) original image -> (d) sobel gradient -> (e) smoothed by 5x5 average filter -> (f) = (c)\*(e)
(g) = (a) + (f) -> (h) power law on (g)

## Implementation
**(b)** Using Laplacian on (a)
Laplacian for function $f(x,y)$: $\Delta^2f=\frac{\partial^2 f}{\partial x^2} + \frac{\partial^2 f}{\partial y^2}$
Along x: $\frac{\partial^2 f}{\partial x^2}=[f(x+1, y)-f(x,y)]-[f(x,y)-f(x-1,y)]$
Along y: $\frac{\partial^2 f}{\partial y^2}=[f(x, y+1)-f(x,y)]-[f(x,y)-f(x,y-1)]$
Diagonal: $\frac{\partial^2 f}{\partial x^2}=[f(x+1, y+1)-f(x,y)]-[f(x,y)-f(x-1,y-1)]$
Diagonal: $\frac{\partial^2 f}{\partial y^2}=[f(x-1, y+1)-f(x,y)]-[f(x,y)-f(x+1,y-1)]$

$\nabla ^2f=f(x+1, y)+f(x-1, y)+f(x,y+1)+f(x,y-1)+f(x+1,y+1)+f(x-1,y-1)+f(x+1,y-1)+f(x-1,y+1)-8f(x,y)$

**Details** 
Padding. I use duplication for padding.
To visualize (b), we need to scale the result of Laplacian. The scale method used here is:
$f_m=f-\min (f)$, f_s=K[f_m/ \max (f_m)]

**(c)** Add $\Delta^2 f$ to (a)
The way to use Laplacian for sharpening is $g(x,y)=f(x,y)+c\Delta^2 f$. $c$ is determined by the mask we use. Here $c=1$.

**(d)** Using Gradient (Sobel) on (a)
Gradient: $\nabla f \equiv \left[ \frac{\partial f}{\partial x}, \frac{\partial f}{\partial y} \right] ^T \equiv $
Sobel operator(one of the discret forms): 
$\frac{\partial f}{\partial x} = (z_7+2z_8+z_9)-(z_1+2z_2+z_3)$, $\frac{\partial f}{\partial y} = (z_3+2z_6+z_9)-(z_1+2z_4+z_7)$
Sobel masks: TODOTODO


