#include <stdlib.h>
#include <stdio.h>

#include "convolution.cuh"

__global__ void kernel_init_noyau(
	/* IN */
	int R,
	float coeff,
	/* OUT */
	int *indi,
	int *indj,
	float *C
	)
{
    // A ECRIRE
}

noyau_t *init_noyau(noyau_t *h_noyau, int R)
{
    // A ECRIRE
}

void free_noyau(noyau_t *h_noyau, noyau_t *d_noyau)
{
    // A ECRIRE
}

__device__ float &elt_ref(void *base_addr, size_t pitch, int i, int j)
{
    float *p_elt = (float*)((char*)base_addr + i*pitch) + j;
    return *p_elt;
}

__global__ void convol_gl(
	noyau_t *d_noyau,
	/* IN */
	float *d_buf_A,
	size_t pitchA,
	int Ni,
	int Nj,
	/* OUT */
	float *d_buf_B,
	size_t pitchB /* IN */
	)
{
    int i = d_noyau->R + blockIdx.x * blockDim.x + threadIdx.x;
    int j = d_noyau->R + blockIdx.y * blockDim.y + threadIdx.y;

    if (i < Ni+d_noyau->R && j < Nj+d_noyau->R)
    {
	float tmp_B = 0;

	for(int k = 0 ; k < d_noyau->KMAX ; k++)
	{
	    const float val_A =
		elt_ref(d_buf_A, pitchA, i+d_noyau->indi[k], j+d_noyau->indj[k]);

	    tmp_B += d_noyau->C[k] * val_A;
	}
	elt_ref(d_buf_B, pitchB, i, j) = tmp_B;
    }
}

__global__ void convol_sh(
	noyau_t *d_noyau,
	/* IN */
	float *d_buf_A,
	size_t pitchA,
	int Ni,
	int Nj,
	/* OUT */
	float *d_buf_B,
	size_t pitchB /* IN */
	)
{
    // A ECRIRE
}

