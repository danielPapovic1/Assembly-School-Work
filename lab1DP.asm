; Q1: What should be the final value of the EAX register?  
; Since we are adding two unsigned values:  
; Var1 = 10000h (65536 in decimal)  
; Var2 = 20000h (131072 in decimal)  
; The expected sum is:  
; 65536 + 131072 = 196608, which is 30000h in hexadecimal.  
; So, after executing ADD EAX, Var2, we expect EAX = 30000h (196608 in decimal).  

; Q2: What should happen when adding signed values (+3 and -5)?  
; Since we are working with signed numbers, the CPU will use Two’s Complement for negatives.  
; Var3 = 3 (00000003h in binary), Var4 = -5 (FFFFFFFBh in Two’s Complement).  
; If the CPU correctly follows signed addition rules:  
; 3 + (-5) should give -2, which is stored as FFFFFFFEh in EAX.  
; After executing ADD EAX, Var4, we expect EAX = FFFFFFFEh (-2 in decimal).  



TITLE Adding in MASM Lab 1 - Daniel Papovic

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; these two lines are only necessary if you're not using Visual Studio
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
    
	Var1 DWORD 10000h   ; 65536 in decimal
    Var2 DWORD 20000h   ; 131072 in decimal

    ; Signed variables
    Var3 SDWORD 3       ; +3
    Var4 SDWORD -5      ; -5

.code
main proc
	
	mov eax, Var1       ; Load Var1 (10000h = 65536)
    add eax, Var2       ; Add Var2 (20000h = 131072)
    ; Expected EAX = 30000h (196608)

    call DumpRegs       ; Display register values

    mov eax, Var3       ; Load Var3 (+3)
    add eax, Var4       ; Add Var4 (-5)
    ; Expected EAX = -2 (FFFFFFFE in two's complement)

    call DumpRegs 




	exit

main ENDP
END main

