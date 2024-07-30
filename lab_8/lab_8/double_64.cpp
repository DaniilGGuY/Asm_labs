#include <intrin.h>

#include "double_64.h"

double comp_sum_64_c()
{
    double a = FIRST, b = SECOND, c;

    auto begin = __rdtsc();
    for (int i = 0; i < TIMES; ++i)
        c = a + b;
    auto end = __rdtsc();

    return double(end - begin) / TIMES; // в тактах
}

double comp_mul_64_c()
{
    double a = FIRST, b = SECOND, c;

    auto begin = __rdtsc();
    for (int i = 0; i < TIMES; ++i)
        c = a * b;
    auto end = __rdtsc();

    return double(end - begin) / TIMES; // в тактах
}

double comp_sum_64_asm()
{
    double a = FIRST, b = SECOND, c;

    auto begin = __rdtsc();
    for (int i = 0; i < TIMES; ++i)
        __asm {
            fld a
            fld b
            fadd
            fstp c
        }
    auto end = __rdtsc();

    return double(end - begin) / TIMES; // в тактах
}

double comp_mul_64_asm()
{
    double a = FIRST, b = SECOND, c;

    auto begin = __rdtsc();
    for (int i = 0; i < TIMES; ++i)
        __asm {
            fld a
            fld b
            fmul
            fstp c
        }
    auto end = __rdtsc();

    return double(end - begin) / TIMES; // в тактах
}
