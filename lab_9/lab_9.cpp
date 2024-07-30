#include <iostream>

#include "time.h"
#include "mults.h"

static void PrintMatrix(size_t n, size_t m, int mat[N][M])
{
    for (size_t i = 0; i < n; ++i)
    {
        for (size_t j = 0; j < m; ++j)
            std::cout << mat[i][j] << " ";
        
        std::cout << std::endl;
    }
}

int main()
{
    setlocale(LC_ALL, "Russian");

    std::cout << "Введите размеры матриц: \n";
    size_t row_first, column_first, row_second, column_second;
    std::cin >> row_first >> column_first >> row_second >> column_second;
    if (column_first != row_second || !row_first || !row_second || !column_first || !column_second ||
        row_first > N || row_second > N || column_first > N || column_second > N)
        return 1;

    int mat1[N][M] = { 0 }, mat2[N][M] = { 0 }, c_mult[N][M] = { 0 };
    std::cout << "Введите первую матрицу: \n";
    for (size_t i = 0; i < row_first; ++i)
        for (size_t j = 0; j < column_first; ++j)
            std::cin >> mat1[i][j];

    std::cout << "Введите вторую матрицу: \n";
    for (size_t i = 0; i < row_second; ++i)
        for (size_t j = 0; j < column_second; ++j)
            std::cin >> mat2[i][j];

    clock_t beg =  clock();
    CMultMatrix(row_first, column_first, column_second, mat1, mat2, c_mult);
    clock_t end = clock();
    std::cout << "Матрица произведение:\n";
    PrintMatrix(row_first, column_second, c_mult);
    std::cout << "Время работы: " << double(end - beg) / CLOCKS_PER_SEC * 1000.0 << std::endl;

    beg = clock();
    AsmMultMatrix(row_first, column_first, column_second, mat1, mat2, c_mult);
    end = clock();
    std::cout << "Матрица произведение:\n";
    PrintMatrix(row_first, column_second, c_mult);
    std::cout << "Время работы: " << double(end - beg) / CLOCKS_PER_SEC * 1000.0 << std::endl;

    return 0;
}
