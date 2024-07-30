#include "mults.h"

void CMultMatrix(size_t n, size_t l, size_t m, int mat1[][M], int mat2[][M], int mult[][M])
{
    int el;
    for (size_t i = 0; i < n; ++i)
        for (size_t j = 0; j < m; ++j)
        {
            el = 0;
            for (size_t k = 0; k < l; ++k)
                el += mat1[i][k] * mat2[k][j];

            mult[i][j] = el;
        }
}

static void TransponeMatrix(size_t n, size_t m, int mat[][M])
{
    for (size_t i = 0; i < n; ++i)
        for (size_t j = i + 1; j < m; ++j)
        {
            int tmp = mat[i][j];
            mat[i][j] = mat[j][i];
            mat[j][i] = tmp;
        }
}

void AsmMultMatrix(size_t n, size_t l, size_t m, int mat1[][M], int mat2[][M], int mult[][M])
{
    TransponeMatrix(l, m, mat2);
    for (size_t i = 0; i < n; ++i)
        for (size_t j = 0; j < m; ++j)
        {
            int el = 10;
            _asm {
                movdqu xmm0, oword ptr el
                movd el, xmm0
            }

            mult[i][j] = el;
        }
}
