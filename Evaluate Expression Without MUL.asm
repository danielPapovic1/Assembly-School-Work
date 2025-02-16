TITLE Lab 3 – Evaluate Expression Without MUL

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib  ; VS Code includes

.data
A       DWORD 20
B       DWORD 10
CVal    DWORD 5       ; Renamed from 'C' due to a MASM parse conflict , C is treated as a directive in MASM 
D       DWORD 50
E       DWORD 15
Result  DWORD ?        ; Still uninitialized

ptrA    DWORD A
ptrB    DWORD B
ptrCVal DWORD CVal     
ptrD    DWORD D
ptrE    DWORD E

.code
main PROC

    mov esi, OFFSET ptrA
    mov esi, [esi]
    mov eax, [esi]

    mov edi, OFFSET ptrB
    mov edi, [edi]
    mov ebx, [edi]

    add eax, ebx

    mov edi, OFFSET ptrCVal
    mov edi, [edi]
    mov ecx, [edi]         ; ECX now has the integer stored in CVal

    mov ebx, 0
multiply_loop:             ; Label marking the addition loop
    add ebx, eax           ; EBX accumulates (A+B) each time
    loop multiply_loop     ; Repeats until ECX reaches 0, multiplying by CVal

    mov esi, OFFSET ptrD
    mov esi, [esi]
    mov edx, [esi]         ; EDX now holds D

    mov edi, OFFSET ptrE
    mov edi, [edi]
    sub edx, [edi]         ; EDX = D - E

    sub ebx, edx           
    mov [Result], ebx      ; EBX now holds the final result

    mov eax, [Result]      ; Print that final value
    call WriteDec          ; Outputs EAX in decimal form (WriteDec only for EAX)
    call CrLf

    call DumpRegs          ; Shows register contents
    exit
main ENDP
END main


COMMENT $  After the final subtraction (sub ebx, edx), EBX contains the computed result 
(A+B)∗CVal−(D−E) before it’s stored in Result.
$