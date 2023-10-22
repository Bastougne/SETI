#ifndef MYLIB_CUH
#define MYLIB_CUH

#include "mylib.h"


#include <cuda_runtime.h>


Mat seuillageGPU( Mat in);
Mat sobel_GPU(Mat in);

#endif
