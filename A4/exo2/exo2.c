#include <math.h>
#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

double f( double x ) {
	float y = 2.17 * log( x ) * cos( x );
	return y;
}

int main( int argc, char **argv ) {
	if ( argc != 3 ) {
		printf( "Need 2 arguments, got %d\n", argc - 1 );
		return EXIT_FAILURE;
	}
	int N = atoi( argv[1] );
	int nthreads = atoi( argv[2] );

	srand( time( NULL ) );

	omp_set_num_threads( nthreads );
#pragma omp parallel master
	{
		int num_threads = omp_get_num_threads();
		printf( "num_threads = %d\n", num_threads );
	}

	double *tab;
	tab = (double *)malloc( sizeof( double ) * N );
	unsigned int i;
	for ( i = 0; i < N; ++i ) {
		tab[i] = rand() / (double)RAND_MAX;
	}

	double start = omp_get_wtime();
#pragma omp parallel for
	for ( i = 0; i < N; ++i ) {
		tab[i] = f( tab[i] );
	}
	double end = omp_get_wtime();

	printf( "duration = %fms\n", ( end - start ) * 1000 );
	return EXIT_SUCCESS;
}
