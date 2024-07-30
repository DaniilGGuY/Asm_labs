StkSeg SEGMENT para stack 'stack'
  db 100h dup (?)
StkSeg ENDS

DataSeg SEGMENT para public 'data'
  RowsReadMsg db 'Enter rows count:$'
  ColumnsReadMsg db 'Enter columns count:$'
  ReadMatrixMsg db 'Enter matrix:$'
  WriteMatrixMsg db 'Answer matrix:$'
  Index db ?
  CountArr db 9 dup (0)
  MatrixSizeN db ?
  MatrixSizeM db ?
  Matrix db 81 dup (0)
DataSeg ENDS

CodeSeg SEGMENT para public 'code'
  assume CS:CodeSeg, DS:DataSeg

clearinf:
  xor AX, AX
  xor BX, BX
  xor DX, DX
  xor SI, SI
  xor DI, DI
  ret

readsymb:
  mov AH, 1
  int 21h
  sub AL, 30h
  ret

printsymb:
  mov AH, 2
  add DL, 30h
  int 21h
  ret

newline:
  mov AH, 2
  mov DL, 10
  int 21h
  mov DL, 13
  int 21h
  ret

printspace:
   mov AH, 2
   mov DL, ' '
   int 21h
   ret

printmsg:
  mov AH, 9
  int 21h
  call newline
  ret

readmatrix:
  mov CL, MatrixSizeN
  inputmatrix:
    push CX
    mov CL, MatrixSizeM
    inputstring:
      call readsymb
      mov [Matrix + BX], AL
      call printspace
      inc BX
      loop inputstring
    call newline
    add BX, 9
    sub BL, MatrixSizeM
    pop CX
    loop inputmatrix
  call clearinf
  ret

printmatrix:
  mov CL, 9
  outputmatrix:
    push CX
    mov CL, 9
    outputstring:
      mov DL, [Matrix + BX]
      call printsymb
      call printspace
      inc BX
      loop outputstring
    pop CX
    call newline
    loop outputmatrix
  call clearinf
  ret

calcarrofnums:
  mov CL, MatrixSizeN
  checkrow:
    push CX
    mov CL, MatrixSizeM
    xor DX, DX
    checkcolumn:
      mov AL, [Matrix + BX]
      test AL, 1h
      jnz next
      inc DL
      next:
      inc BX
      loop checkcolumn
    mov [CountArr + SI], DL
    add BX, 9
    sub BL, MatrixSizeM
    inc SI
    pop CX
    loop checkrow
  call clearinf
  ret

zerolining:
  mov CL, MatrixSizeM
  mov AL, MatrixSizeN
  mov DX, 9
  mul DX
  mov BX, AX
  xor AX, AX
  deleting:
    mov [Matrix + BX], AL
    inc BX
    loop deleting
  call clearinf
  ret

deleterow:
  mov CL, MatrixSizeN
  sub CL, Index
  dec CL
  jz del
  mov BL, Index
  rowreplace:
    push CX
    mov CL, MatrixSizeM
    mov AX, BX
    mov DX, 9
    mul DX
    mov SI, AX
    mov DI, AX
    add DI, 9
    columnreplace:
      mov AL, [Matrix + DI]
      mov [Matrix + SI], AL
      inc SI
      inc DI
      loop columnreplace
    pop CX
    inc BX
    loop rowreplace
  del:
  call clearinf
  dec MatrixSizeN
  call zerolining
  ret

findindex:
  mov AL, [CountArr]
  mov Index, 0
  mov CL, MatrixSizeN
  checkarray:
    mov DL, [CountArr + BX]
    cmp AX, DX
    jnl lower
    mov AX, DX
    mov Index, BL
    lower:
    inc BX
    loop checkarray
  call clearinf
  ret

main:
  mov AX, DataSeg
  mov DS, AX
  xor AX, AX

;считываем количество строк
  lea DX, RowsReadMsg
  call printmsg
  call readsymb
  mov MatrixSizeN, AL
  call newline

;считываем количество столбцов
  lea DX, ColumnsReadMsg
  call printmsg
  call readsymb
  mov MatrixSizeM, AL
  call newline

;считываем саму матрицу
  lea DX, ReadMatrixMsg
  call printmsg
  call readmatrix

;заполняем массив количеством четных элементов в соответствующих строках
  call calcarrofnums

;ищем строку с максимальным количеством четных и записываем в переменную индекса
  call findindex

;затираем строку с найденным индексом
  call deleterow

;вывод матрицы
  lea DX, WriteMatrixMsg
  call printmsg
  call printmatrix

  mov AH, 4Ch
  int 21h
CodeSeg ENDS
END main
