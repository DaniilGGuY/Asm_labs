#ifndef MULTS_H__
#define MULTS_H__

#include <iostream>

#define N    10
#define M    10

void CMultMatrix(size_t n, size_t l, size_t m, int mat1[][M], int mat2[][M], int mult[][M]);

void AsmMultMatrix(size_t n, size_t l, size_t m, int mat1[][M], int mat2[][M], int mult[][M]);

#endif