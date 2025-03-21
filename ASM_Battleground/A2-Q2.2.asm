TITLE Matrix Initialization and Printing

; Name: Daniel Papovic
; Date: March 16, 2025
; ID: 110134022


INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
    matrix DWORD 4 DUP(4 DUP(?))    ; 4x4 matrix of uninitialized DWORDs (16 elements total)

.code

MatrixInit PROC

    ; Would be a good idea to use push and pop here to save the current value of the registers and then use pop to return
    ; Them back to original state in case we try and use their value in main so we do not get an error.      
    ; In our case though we re-initialize with mov in PROC main

    mov edi, OFFSET matrix      ; EDI points to the start of the matrix
    mov ecx, 16                 ; Total elements: 4x4 = 16
    mov eax, 1                  ; Start with value 1

init_loop:
    mov [edi], eax              ; Store current value in matrix
    add edi, 4                  ; Move to next DWORD (4 bytes)
    inc eax                     ; Next value (2, 3, ..., 16)
    loop init_loop              ; Decrement ECX and loop until 0

    ret                         ; Return to caller, without ret our program fails
MatrixInit ENDP

main PROC
    ; Initialize the matrix with values 1-16
    call MatrixInit

    ; Print the matrix in a 4x4 format
    mov esi, OFFSET matrix      
    mov ecx, 4                  ; Outer loop counter: 4 rows

print_rows:
    mov edx, 4                  ; Inner loop counter: 4 columns

print_cols:
    mov eax, [esi]              ; Load current element into EAX
    call WriteDec               ; Print the number
    mov al, ' '                 ; Space character
    call WriteChar              ; Print space after number
    add esi, 4                  ; Move to next DWORD
    dec edx                     ; Decrement column counter so that we can print correct amount of columns before we hit zero flag
    jnz print_cols              ; Loop until all columns printed, will jump as long as zero flag is not set, ie.. edx >= 1

    call Crlf                   ; Newline after each row
    loop print_rows             ; Decrement ECX and loop until all rows printed

    exit                        
main ENDP
END main