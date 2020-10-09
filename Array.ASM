format PE console

entry start

include 'win32a.inc'

section '.data' data readable writeable

        formatNum db '%d', 0
        formatNumWithSpace db '%d ', 0
        formatStr db '%s', 0

        arraySizeStr db 'Input array size: ' ,0
        arrayStr db 'Input array elements (split with space): ', 10, 13, 0
        numberStr db 'Input number X: ', 0
        wrongInputStr db 'Wrong input', 10, 13, 0
        yourArrayStr db 'Your array:', 10, 13, 0
        newArrayStr db 'Your new array:', 10, 13, 0
        emptyArrayStr db 'Empty array', 10, 13, 0
        endlStr db 10, 13, 0

        A dd ?
        B dd ?
        BN dd ?
        AN dd ?
        X dd ?

        TmpStack dd ?
        i dd 0
        tmp dd ?

        ArrayCur dd ?
        SizeCur dd ?

        NULL = 0

section '.code' code readable executable

        start:
                ;ввод длины массива
                cinvoke printf, formatStr, arraySizeStr
                cinvoke scanf, formatNum, AN

                ;проверем корректность длины массива
                mov eax, 0
                cmp eax, [AN]
                ;если некорректно, выводим информцию об ошибке и просим повторный ввод
                jge wrongInp

                ;выдел€ем пам€ть
                invoke  VirtualAlloc, NULL, [AN], MEM_COMMIT+MEM_RESERVE, PAGE_READWRITE
                mov [A], eax
                invoke  VirtualAlloc, NULL, [AN], MEM_COMMIT+MEM_RESERVE, PAGE_READWRITE
                mov [B], eax

                ;ввод массива
                call inputArray

                ;ввод числа X
                cinvoke printf, formatStr, numberStr
                cinvoke scanf, formatNum, X

                cinvoke printf, formatStr, endlStr

                ;вывод старого массива
                mov ecx, [A]
                mov [ArrayCur], ecx
                mov ecx, [AN]
                mov [SizeCur], ecx
                cinvoke printf, formatStr, yourArrayStr
                call outputArray

                ;основна€ задача программы
                call createNewArray

                cinvoke printf, formatStr, endlStr

                ;вывод нового массива
                mov ecx, [B]
                mov [ArrayCur], ecx
                mov ecx, [BN]
                mov [SizeCur], ecx
                cinvoke printf, formatStr, newArrayStr
                call outputArray

                ;освобождение пам€ти
                invoke  VirtualFree, [A], [AN], MEM_DECOMMIT
                invoke  VirtualFree, [B], [AN], MEM_DECOMMIT


                call [getch]

                push NULL
                call [ExitProcess]

        wrongInp:
                cinvoke printf, formatStr, wrongInputStr
                jmp start

        inputArray:
                ;сохран€ем стэк дл€ адреса возврата
                mov [TmpStack], esp
                mov ecx, 0
                mov [i], ecx

                cinvoke printf, formatStr, arrayStr

                lp:
                        cinvoke scanf, formatNum, tmp

                        ;вычисл€ем адрес новой €чейки
                        mov ecx, [i]
                        imul ecx, dword 4
                        mov eax, [A]
                        add eax, ecx

                        ;записываем в массив
                        mov ecx, [tmp]
                        mov [eax], ecx

                        ;зацикливаем
                        inc[i]
                        mov ecx, [i]
                        cmp ecx, [AN]
                        jne lp

                mov esp, [TmpStack]
                ret

        outputArray:
                ;сохран€ем стэк дл€ адреса возврата
                mov [TmpStack], esp
                mov ecx, 0
                mov [i], ecx

                cmp [SizeCur], ecx
                je emptyArr

                lp2:
                        ;вычисл€ем адрес новой €чейки
                        mov ecx, [i]
                        imul ecx, dword 4
                        mov eax, [ArrayCur]
                        add eax, ecx

                        ;вычисл€ем и выводим значение
                        mov ecx, [eax]
                        cinvoke printf, formatNumWithSpace, ecx

                        ;зацикливаем
                        inc[i]
                        mov ecx, [i]
                        cmp ecx, [SizeCur]
                        jne lp2

                skipLoop:


                mov esp, [TmpStack]
                ret

        emptyArr:
                cinvoke printf, formatStr, emptyArrayStr
                jmp skipLoop

        createNewArray:
                ;сохран€ем стэк дл€ адреса возврата
                mov [TmpStack], esp
                mov ecx, 0
                mov [i], ecx

                lp3:
                        ;вычисл€ем адрес новой €чейки
                        mov ecx, [i]
                        imul ecx, dword 4
                        mov eax, [A]
                        add eax, ecx

                        ;вычисл€ем значение
                        mov ebx, [eax]
                        cmp ebx, [X]
                        jne copyToNewArray

                        returnFromCopy:

                        ;зацикливаем
                        inc[i]
                        mov ecx, [i]
                        cmp ecx, [AN]
                        jne lp3

                mov esp, [TmpStack]
                ret

        copyToNewArray:
                ;вычисл€ем адрес новой €чейки дл€ записи
                mov ecx, [BN]
                imul ecx, dword 4
                mov eax, [B]
                add eax, ecx

                ;записываем значение в массив
                mov [eax], ebx
                inc [BN]

                jmp returnFromCopy


section '.idata' import data readable

        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel,\
               ExitProcess, 'ExitProcess',\
               VirtualAlloc, 'VirtualAlloc',\
               VirtualFree, 'VirtualFree'

        import msvcrt,\
               printf, 'printf',\
               getch, '_getch',\
               scanf, 'scanf'
