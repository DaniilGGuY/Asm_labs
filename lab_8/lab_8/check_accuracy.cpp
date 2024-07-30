#include "check_accuracy.h"

double sin_asm(double phi)
{
    double res = 0.0;

    __asm {
        fld phi
        fsin
        fst res
    }

    return res;
}

double pi_asm()
{
    double res = 0.0;

    __asm  {
        fldpi
        fstp res
    }

    return res;
}
