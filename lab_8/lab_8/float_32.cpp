#include <intrin.h>

#include "float_32.h"

double comp_sum_32_c()
{
    float a = FIRST, b = SECOND, c;

    auto begin = __rdtsc();
    for (int i = 0; i < TIMES; ++i)
        c = a + b;
    auto end = __rdtsc();

    return double(end - begin) / TIMES; // в тактах
}

double comp_mul_32_c()
{
    float a = FIRST, b = SECOND, c;

    auto begin = __rdtsc();
    for (int i = 0; i < TIMES; ++i)
        c = a * b;
    auto end = __rdtsc();

    return double(end - begin) / TIMES; // в тактах
}

double comp_sum_32_asm()
{
    float a = FIRST, b = SECOND, c;

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

double comp_mul_32_asm()
{
    float a = FIRST, b = SECOND, c;

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
