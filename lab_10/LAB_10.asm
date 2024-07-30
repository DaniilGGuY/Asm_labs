.386

.model flat, stdcall
option casemap:none

include D:\masm32\include\windows.inc
include D:\masm32\macros\macros.asm
uselib kernel32, user32, masm32, comctl32, msvcrt
 
WndProc PROTO :DWORD,:DWORD,:DWORD,:DWORD
hord_asm PROTO :REAL8, :REAL8, :DWORD

TEST_DIALOG = 1000
TEST_START_NUM_EDIT = 1001
TEST_END_NUM_EDIT = 1004
TEST_STEP_NUM_EDIT = 1006
RUN_BTN = 1007

.data
  seven REAL8 7.0
  five REAL8 5.0
  two REAL8 2.0
  
.data?
  hInstance dd ?
  hWnd dd ?
  icce INITCOMMONCONTROLSEX <>
  buf_a db 128 dup(?)
  buf_b db 128 dup(?)
  buf_n db 128 dup(?)
  float_result REAL8 ?
  res REAL8 ?
  global_x0 REAL8 ?
  global_x1 REAL8 ?
  global_n dd ?

.code
start:
    mov icce.dwSize, SIZEOF INITCOMMONCONTROLSEX
    mov icce.dwICC, ICC_DATE_CLASSES or \
                    ICC_INTERNET_CLASSES or \
                    ICC_PAGESCROLLER_CLASS or \
                    ICC_COOL_CLASSES

    invoke InitCommonControlsEx, offset icce

    invoke GetModuleHandle, NULL
    mov hInstance, eax

    invoke DialogBoxParam, hInstance, TEST_DIALOG, 0, offset WndProc, 0

    invoke ExitProcess, eax

hord_asm PROC param_x0:REAL8, param_x1:REAL8, param_n:DWORD
    LOCAL x0:REAL8
    LOCAL x1:REAL8
    LOCAL f0:REAL8
    mov ecx, param_n
    fld param_x0
    fstp x0
    fld param_x1
    fstp x1

    fld x1  

cycle:
    fld x0
    fld seven
    faddp st(1), st(0)

    fstp f0

    fld x1
    fld seven
    faddp st(1), st(0)

    fld st(0)
    fld x0
    fsub x1
    fmulp st(1), st(0)
    fxch
    fld f0
    fxch
    fsubp st(1), st(0)
    fdivp st(1), st(0)
    fld x1
    fxch
    fsubp st(1), st(0)

    fstp x1
    loop cycle

    fld x1
    fstp res

    ret
hord_asm ENDP

WndProc proc hWin:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD
    LOCAL float_start:REAL4
    LOCAL float_end:REAL4
    LOCAL float_step:REAL4

    switch uMsg
        case WM_INITDIALOG
            invoke SendMessage, hWin, WM_SETICON, 1, FUNC(LoadIcon, NULL, IDI_ASTERISK)

        case WM_COMMAND
            switch wParam
                case RUN_BTN
                    invoke GetDlgItemText, hWin, TEST_START_NUM_EDIT, addr buf_a, 16
                    invoke GetDlgItemText, hWin, TEST_END_NUM_EDIT, addr buf_b, 16
                    invoke GetDlgItemText, hWin, TEST_STEP_NUM_EDIT, addr buf_n, 16

                    invoke crt_atof, addr buf_a
                    fstp float_start
                    invoke crt_atof, addr buf_b
                    fstp float_end
                    invoke crt_atof, addr buf_n
                    fstp float_step

                    fld float_start
                    fstp qword ptr [global_x0]
                    fld float_end
                    fstp qword ptr [global_x1]
                    mov eax, float_step
                    mov [global_n], eax

                    invoke hord_asm, qword ptr [global_x0], qword ptr [global_x1], [global_n]

                    fld qword ptr [res]
                    fstp qword ptr [float_result]

                    invoke crt_sprintf, addr buf_a, chr$("Sum: %lf"), float_result
                    invoke MessageBox, hWin, addr buf_a, chr$("Sum"), 0

            endsw
        case WM_CLOSE
        exit_program:
            invoke EndDialog, hWin, 0

    endsw

    xor eax, eax
    ret
WndProc ENDP

end start