#include <iostream>

using namespace std;

extern "C"
{
    void strcopy_asm(char *dst, const char *src, int size); 
}


int strlen_asm(const char* s)
{
    int len = 0;

    __asm {
        mov edi, s;
        mov ecx, -1;
        xor al, al;
        repne scasb;
        not ecx;
        dec ecx;
        mov len, ecx;
    }

    return len;
}


void strprint(const char* s)
{
    for (int i = 0; i < strlen_asm(s); ++i)
        cout << s[i];

    cout << endl;
}


void check_test(char* dst, const char* src, int len)
{
    static int i = 1;

    cout << "Test number " << i << ":" << endl;
    cout << "Dst prev: ";
    strprint(dst);
    cout << "Src prev: ";
    strprint(src);

    strcopy_asm(dst, src, len);

    cout << "Dst: ";
    strprint(dst);
    cout << "Src: ";
    strprint(src);

    cout << endl << endl;
    ++i;
}

int main()
{
    /*char dst_1[] = "Mama, i am on TV";
    char src_1[] = "Hello";
    check_test(dst_1, src_1, strlen_asm(src_1));

    char dst_2[] = "Mama, i am on TV";
    char* src_2 = dst_2 + 5;
    check_test(dst_2, src_2, 5);

    char src_3[] = "Mama, i am on TV";
    char* dst_3 = src_3 + 5;
    check_test(dst_3, src_3, 4);

    char src_4[] = "Mama, i am on TV";
    char* dst_4 = src_4 + 5;
    check_test(dst_4, src_4, 5);*/

    char src_5[100] = "Mama, i am on TV";
    char* dst_5 = src_5 + 4;
    check_test(dst_5, src_5, strlen_asm(src_5));

    return 0;
}
