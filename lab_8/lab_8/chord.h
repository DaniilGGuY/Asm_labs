#ifndef CHORD_H__
#define CHORD_H__

#define EPS     1e-10
#define ITERS    1e2

double calc_root(double (*f)(double), double (*calc)(double, double, double, double), double a, double b);

double calc_x_c(double a, double b, double fa, double fb);

double calc_x_asm(double a, double b, double fa, double fb);

double func_c(double x);

double func_asm(double x);

#endif
