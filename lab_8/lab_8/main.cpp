#include <iostream>
#include <iomanip>

#include "check_accuracy.h"
#include "float_32.h"
#include "double_64.h"
#include "chord.h"

#define PI2      3.14
#define PI6  3.141596

using namespace std;


static void task1()
{
    cout << "TASK 1. FLOAT\n";
    cout << "COMPARE TIME OF SUM AND MULT ON C AND ASM---------------\n";
    cout << "Speed of sum in C: " << comp_sum_32_c() << " tics\n";
    cout << "Speed of mult in C: " << comp_mul_32_c() << " tics\n";
    cout << "Speed of sum in ASM: " << comp_sum_32_asm() << " tics\n";
    cout << "Speed of mult in ASM: " << comp_mul_32_asm() << " tics\n";
    cout << "---------------------------------------------END COMPARE\n";

    cout << "TASK 1. DOUBLE\n";
    cout << "COMPARE TIME OF SUM AND MULT ON C AND ASM---------------\n";
    cout << "Speed of sum in C: " << comp_sum_64_c() << " tics\n";
    cout << "Speed of mult in C: " << comp_mul_64_c() << " tics\n";
    cout << "Speed of sum in ASM: " << comp_sum_64_asm() << " tics\n";
    cout << "Speed of mult in ASM: " << comp_mul_64_asm() << " tics\n";
    cout << "---------------------------------------------END COMPARE\n\n\n";
}


static void task2()
{
    cout << "TASK 2. PI\n";
    cout << "CHECK PI IN C AND IN ASM--------------------------------\n";
    cout << "PI in FPU: " << setprecision(7) << pi_asm() << "\n";
    cout << "PI with 2 decimal places: " << PI2 << "\n";
    cout << "PI with 6 decimal places: " << setprecision(8) << PI6 << "\n";
    cout << "--------------------------------------------END CHECKING\n";

    cout << "TASK 2. SIN\n";
    cout << "CHECK PI IN C AND IN ASM--------------------------------\n";
    cout << "Sin PI FPU: " << setprecision(7) << sin_asm(pi_asm()) << "\n";
    cout << "Sin PI / 2 FPU: " << setprecision(7) << sin_asm(pi_asm() / 2) << "\n";
    cout << "Sin PI2: " << setprecision(7) << sin_asm(PI2) << "\n";
    cout << "Sin PI2 / 2: " << setprecision(7) << sin_asm(PI2 / 2) << "\n";
    cout << "Sin PI6: " << setprecision(7) << sin_asm(PI6) << "\n";
    cout << "Sin PI6 / 2: " << setprecision(7) << sin_asm(PI6 / 2) << "\n";
    cout << "--------------------------------------------END CHECKING\n\n\n";
}


static void task3(double a, double b)
{
    cout << "TASK 3. CALC ROOT ASM\n";
    double x_asm = calc_root(func_asm, calc_x_c, a, b);
    cout << "The root found with this data in ASM is: " << x_asm << endl;
    cout << "F(x) with found x is: " << func_asm(x_asm) << endl;

    cout << "TASK 3. CALC ROOT C\n";
    double x_c = calc_root(func_c, calc_x_c, a, b);
    cout << "The root found with this data in C is: " << x_c << endl;
    cout << "F(x) with found x is: " << func_c(x_c) << endl;
}


int main()
{
    task1();
    task2();
    task3(1.5, 1.7);
}