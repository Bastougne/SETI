#include "mylib.h"
#include "mylib.cuh"


__global__ void kernel_seuillageGPU(unsigned char *d_image_in, unsigned char *d_image_out,int size_j)
{
	float Csum;
	int i, j, k, iFirst, jFirst;

	iFirst = blockIdx.x*BLOCK_SIZE; // num de block dans la grille de block
	jFirst = blockIdx.y*BLOCK_SIZE;

	i = iFirst + threadIdx.x;// recuperer l'identifiant d'un thread dans les blocs
	j = jFirst + threadIdx.y;

	float nr = 0;

	nr=d_image_in[2+j*3+i*3*size_j]/sqrtf(d_image_in[0+j*3+i*3*size_j]*d_image_in[0+j*3+i*3*size_j]+d_image_in[1+j*3+i*3*size_j]*d_image_in[1+j*3+i*3*size_j]			+d_image_in[2+j*3+i*3*size_j]*d_image_in[2+j*3+i*3*size_j]);

	if(nr > 0.7)
		d_image_out[1+j*3+i*3*size_j] = d_image_in[2+j*3+i*3*size_j];
	else
		d_image_out[1+j*3+i*3*size_j] = d_image_in[1+j*3+i*3*size_j]; 

	d_image_out[0+j*3+i*3*size_j] = d_image_in[0+j*3+i*3*size_j];
	d_image_out[2+j*3+i*3*size_j] = d_image_in[2+j*3+i*3*size_j];


}

int sobel_x[] = {-1, 0, 1};
int sobel_y[] = { 1, 2, 1};

__global__ void kernel_sobelGPU(unsigned char *d_image_in, unsigned char *d_buffer_gx, unsigned char *d_buffer_gy, unsigned char *d_image_out, int w, int h)
{
	int idx = threadIdx.x + blockIdx.x*blockDim.x;
	int idy = threadIdx.y + blockIdx.y*blockDim.y;
	const int posr = 3*(idx + w * idy), posg = posr + 1, posb = posg + 1;
	const int pas = 3;
	const int image_width = pas * w;
	int3 sobel;
	if(idx > 0 && idx < w-1 && idy > 0 && idy < h-1) 
	{
		//GY part 1//
		sobel.x = ((int)d_image_in[posr - pas] + (int)d_image_in[posr + pas] + 2*(int)d_image_in[posr]);
		sobel.y = ((int)d_image_in[posg - pas] + (int)d_image_in[posg + pas] + 2*(int)d_image_in[posg]);
		sobel.z = ((int)d_image_in[posb - pas] + (int)d_image_in[posb + pas] + 2*(int)d_image_in[posb]);
		
		d_buffer_gy[posr] = (unsigned char)sobel.x;
		d_buffer_gy[posg] = (unsigned char)sobel.y;
		d_buffer_gy[posb] = (unsigned char)sobel.z;
		
		__syncthreads();
		
		//GY part 2//
		sobel.x = (int)d_buffer_gy[posr + image_width] - (int)d_buffer_gy[posr - image_width];
		sobel.y = (int)d_buffer_gy[posg + image_width] - (int)d_buffer_gy[posg - image_width];
		sobel.z = (int)d_buffer_gy[posb + image_width] - (int)d_buffer_gy[posb - image_width];
		
		d_buffer_gy[posr] = (unsigned char)sobel.x;
		d_buffer_gy[posg] = (unsigned char)sobel.y;
		d_buffer_gy[posb] = (unsigned char)sobel.z;
		
		//GX part 1//
		sobel.x = (int)d_image_in[posr + pas] - (int)d_image_in[posr - pas];
		sobel.y = (int)d_image_in[posg + pas] - (int)d_image_in[posg - pas];
		sobel.z = (int)d_image_in[posb + pas] - (int)d_image_in[posb - pas];
		
		d_buffer_gx[posr] = (unsigned char)sobel.x;
		d_buffer_gx[posg] = (unsigned char)sobel.y;
		d_buffer_gx[posb] = (unsigned char)sobel.z;
		
		__syncthreads();
		
		//GX part 2//
		sobel.x = (int)d_buffer_gx[posr - image_width] + (int)d_buffer_gx[posr + image_width] + 2*(int)d_buffer_gx[posr];
		sobel.y = (int)d_buffer_gx[posg - image_width] + (int)d_buffer_gx[posg + image_width] + 2*(int)d_buffer_gx[posg];
		sobel.z = (int)d_buffer_gx[posb - image_width] + (int)d_buffer_gx[posb + image_width] + 2*(int)d_buffer_gx[posb];
		
		d_buffer_gx[posr] = (unsigned char)sobel.x;
		d_buffer_gx[posg] = (unsigned char)sobel.y;
		d_buffer_gx[posb] = (unsigned char)sobel.z;
		
		__syncthreads();
		
		d_image_out[posr] = (unsigned char)sqrt( ((float) d_buffer_gx[posr] * (float) d_buffer_gx[posr]) + ( (float) d_buffer_gy[posr] * (float) d_buffer_gy[posr]) );
		d_image_out[posg] = (unsigned char)sqrt( ((float) d_buffer_gx[posg] * (float) d_buffer_gx[posg]) + ( (float) d_buffer_gy[posg] * (float) d_buffer_gy[posg]) );
		d_image_out[posb] = (unsigned char)sqrt( ((float) d_buffer_gx[posb] * (float) d_buffer_gx[posb]) + ( (float) d_buffer_gy[posb] * (float) d_buffer_gy[posb]) );
	}
}


Mat seuillageGPU( Mat in)
{
	cudaError_t error;
	Mat out;
	out.create(in.rows,in.cols,CV_8UC3);
	
	// allocate host memory
	unsigned char *h_image_in_GPU ;
	h_image_in_GPU=in.data;
	
	/*cudaEvent_t start,stop,start_mem,stop_mem;
	error = cudaEventCreate(&start_mem);
	error = cudaEventCreate(&stop_mem);
	
	error = cudaEventRecord(start, NULL);
	error = cudaEventSynchronize(start);*/
	
	// images on device memoryÍÍÍ
	unsigned char *d_image_in_GPU;
	unsigned char *d_image_out_GPU;
	
	const unsigned long int mem_size=in.cols*in.rows*3*sizeof(unsigned char);
	
	// Alocation mémoire de d_image_in et d_image_out sur la carte GPU
	cudaMalloc((void**) &d_image_in_GPU,mem_size );
	cudaMalloc((void**) &d_image_out_GPU, mem_size);
	
	// copy host memory to device
	cudaMemcpy(d_image_in_GPU, h_image_in_GPU,mem_size ,cudaMemcpyHostToDevice);
	
	//error = cudaEventRecord(stop_mem, NULL);
	
	// Wait for the stop event to complete
	//error = cudaEventSynchronize(stop_mem);
	//float msecMem = 0.0f;
	//error = cudaEventElapsedTime(&msecMem, start, stop_mem);
	
	// setup execution parameters -> découpage en threads
	dim3 threads(BLOCK_SIZE,BLOCK_SIZE);
	dim3 grid(in.rows/BLOCK_SIZE,in.cols/BLOCK_SIZE);
	
	// lancement des threads executé sur la carte GPU
	
	kernel_seuillageGPU<<< grid, threads >>>(d_image_in_GPU, d_image_out_GPU,in.cols);
	
	// Record the start event
	//error = cudaEventRecord(start_mem, NULL);
	//error = cudaEventSynchronize(start_mem);
	
	// copy result from device to host
	cudaMemcpy(out.data, d_image_out_GPU, mem_size,cudaMemcpyDeviceToHost);
	cudaFree(d_image_in_GPU);
	cudaFree(d_image_out_GPU);
	/*
	float msecTotal,msecMem2;
	error = cudaEventRecord(stop, NULL);
	error = cudaEventSynchronize(stop);
	error = cudaEventElapsedTime(&msecTotal, start, stop);
	error = cudaEventElapsedTime(&msecMem2, start_mem, stop);
	*/
	return out;
}

Mat sobel_GPU(Mat in)
{
	cudaError_t error;
	Mat out;
	out.create(in.rows,in.cols,CV_8UC3);
	
	// allocate host memory
	unsigned char *h_image_in_GPU ;
	h_image_in_GPU=in.data;
	
	/*cudaEvent_t start,stop,start_mem,stop_mem;
	error = cudaEventCreate(&start_mem);
	error = cudaEventCreate(&stop_mem);
	
	error = cudaEventRecord(start, NULL);
	error = cudaEventSynchronize(start);*/
	
	// images on device memoryÍÍÍ
	unsigned char *d_image_in_GPU;
	unsigned char *d_image_out_GPU;
	unsigned char *d_buffer_gx, *d_buffer_gy;
	
	const unsigned long int mem_size=in.cols*in.rows*3*sizeof(unsigned char);
	
	// Alocation mémoire de d_image_in et d_image_out sur la carte GPU
	cudaMalloc((void**) &d_image_in_GPU,mem_size );
	cudaMalloc((void**) &d_image_out_GPU, mem_size);
	cudaMalloc((void**) &d_buffer_gx, mem_size); cudaMalloc((void**) &d_buffer_gy, mem_size);
	
	// copy host memory to device
	cudaMemcpy(d_image_in_GPU, h_image_in_GPU, mem_size, cudaMemcpyHostToDevice);
	
	//error = cudaEventRecord(stop_mem, NULL);
	
	// Wait for the stop event to complete
	//error = cudaEventSynchronize(stop_mem);
	//float msecMem = 0.0f;
	//error = cudaEventElapsedTime(&msecMem, start, stop_mem);
	
	// setup execution parameters -> découpage en threads
	dim3 threads(BLOCK_SIZE,BLOCK_SIZE);
	dim3 grid(in.cols/BLOCK_SIZE,in.rows/BLOCK_SIZE);
	
	// lancement des threads executé sur la carte GPU
	//printf("cols = %i | rows = %i\n", in.cols, in.rows);
	kernel_sobelGPU<<< grid, threads >>>(d_image_in_GPU, d_buffer_gx, d_buffer_gy, d_image_out_GPU, in.cols, in.rows);
	
	// Record the start event
	//error = cudaEventRecord(start_mem, NULL);
	//error = cudaEventSynchronize(start_mem);
	
	// copy result from device to host
	cudaMemcpy(out.data, d_buffer_gx, mem_size,cudaMemcpyDeviceToHost);
	cudaFree(d_image_in_GPU);
	cudaFree(d_image_out_GPU);
	cudaFree(d_buffer_gx);
	cudaFree(d_buffer_gy);
	/*
	float msecTotal,msecMem2;
	error = cudaEventRecord(stop, NULL);
	error = cudaEventSynchronize(stop);
	error = cudaEventElapsedTime(&msecTotal, start, stop);
	error = cudaEventElapsedTime(&msecMem2, start_mem, stop);
	*/
		
	return out;
}

