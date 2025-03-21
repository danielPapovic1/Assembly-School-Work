TITLE Array Copy and Print

; Name: Daniel Papovic
; Date: March 16, 2025
; ID:   110134022


INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
    arr1 DWORD 10, 21, 30, 41, 50, 61, 70, 81, 90, 101    
    arr2 DWORD 10 DUP(?)                                  ; Destination array, uninitialized, same size as arr1


.code

COMMENT !
PUSH and POP save and restore register values to prevent interference with the caller's state in main, though it doesn't 
mess up main here since main resets ESI and ECX before use, but it's best 
practice for reusability in larger programs.

!

CopyArray PROC
    push esi                   
    push edi                    
    push ebx                    
    push ecx                    

    mov esi, OFFSET arr1        ; ESI points to start of arr1 (source)
    mov edi, OFFSET arr2        ; EDI points to start of arr2 (destination)
    mov ecx, 10                 ; Set loop counter to 10 (number of elements)
    xor ebx, ebx                ; Clear EBX to 0 means our index starts at 0

copy_loop:
    mov eax, [esi + ebx*4]      ; Load arr1[EBX] into EAX (source element, *4 so we can move to next 
    mov [edi + ebx*4], eax      ; Store the value of array1 in array2
    inc ebx                     ; Increment index
    loop copy_loop              ; Decrease ECX and repeat until ECX = 0

    pop ecx                     
    pop ebx                     
    pop edi                     
    pop esi                     
    ret                         
CopyArray ENDP

PrintArray PROC
    push esi                    
    push ecx                   
    push eax                    

    mov ecx, 10                 ; Set loop counter to number of elements (10)
    xor ebx, ebx                ; Clear our index (EBX) to 0

print_loop:
    mov eax, [esi + ebx*4]      ; Load array[EBX] into EAX
    call WriteDec               ; Print the number
    mov al, ' '                 ; Load space character
    call WriteChar              ; Print a space after the number
    inc ebx                     ; Increment index
    loop print_loop             ; Decrease ECX and repeat until ECX = 0

    call Crlf                   ; Print new line after
    pop eax                     
    pop ecx                     
    pop esi    

    ret                         
PrintArray ENDP

main PROC
    ; Copy arr1 to arr2
    call CopyArray              

    ; Print original array (arr1)
    mov esi, OFFSET arr1        ; Point ESI to arr1
    call PrintArray             

    ; Print copied array (arr2)
    mov esi, OFFSET arr2        ; Point ESI to arr2
    call PrintArray             

    exit                        
main ENDP
END main