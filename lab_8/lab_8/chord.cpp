#include <cmath>

#include "chord.h"

double calc_root(double (*f)(double), double (*calc)(double, double, double, double), double a, double b)
{
    double x = a;
    size_t iters = 0;
    while (fabs(b - a) > EPS && iters < ITERS)
    {
        x = calc(a, b, f(a), f(b));

        if (f(a) * f(x) < 0)
            b = x;
        else
            a = x;
        
        ++iters;
    }

    return x;
}

double calc_x_c(double a, double b, double fa, double fb)
{
    return a - (fa * (b - a)) / (fb - fa);
}

double calc_x_asm(double a, double b, double fa, double fb)
{
    double res = 0.0;

    __asm {
        fld a
        fld b
        fld a
        fsub
        fld fa
        fmul
        fld fb
        fld fa
        fsub
        fdiv
        fsub
        fstp res
    }

    return res;
}

double func_c(double x)
{
    return cos(x * x * x + 7);
}

double func_asm(double x)
{
    double res = 0.0, c = 7.0;

    __asm {
        fld x
        fld x
        fmul
        fld x
        fmul
        fld c
        fadd
        fcos
        fstp res
    }

    return res;
}