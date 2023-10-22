#include <omp.h>
#include <stdio.h>
#include <stdlib.h>

int main() {
#pragma omp parallel master
	{
		int nthreads = omp_get_num_threads();
		int maxthreads = omp_get_max_threads();
		int nprocs = omp_get_num_procs();
		
		printf( "num_threads = %d\n", nthreads );
		printf( "max_threads = %d\n", maxthreads );
		printf( "num_procs = %d\n", nprocs );
	}
	
	return EXIT_SUCCESS;
}
