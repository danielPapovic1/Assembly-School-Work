TITLE Program to push even numbers from arr1 onto the stack, pop them into arr3 in reverse order, and print the result

; Name: Daniel Papovic
; Date: March 16, 2025
; ID:   110134022

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib


.data
    arr1 DWORD 10, 21, 30, 41, 50, 61, 70, 81, 90, 101    
    arr3 DWORD 10 DUP(?)                                  
    evenCount DWORD 0                                     ; Tracks the number of even numbers

.code

ReverseEven PROC
    push esi                    
    push edi                   
    push ecx                   
    push ebx                   
    push edx                    

    ; --- Push even numbers from arr1 onto the stack ---
    mov esi, OFFSET arr1        ; ESI points to start of arr1
    mov ecx, 10                 ; Number of elements in arr1
    xor ebx, ebx                ; EBX as index (start at 0)
    xor edx, edx                ; EDX counts even numbers

check_even:
    mov eax, [esi + ebx*4]      ; Load arr1[EBX] into EAX
    test eax, 1                 ; Test if number is even LSB = 0 mean even LSB = 1 mean odd 
    jnz skip_push               ; Jump if not 0, so, If odd (LSB = 1), skip to next
    push eax                    ; Push even number onto stack
    inc edx                     ; Increment even number counter
skip_push:
    inc ebx                     ; Move to next index
    loop check_even             ; Repeat until all elements checked

    ; --- Pop from stack into arr3 in reverse order ---
    mov edi, OFFSET arr3        ; EDI points to start of arr3
    xor ebx, ebx                ; Reset EBX for arr3 indexing
    mov evenCount, edx          ; Store the count of even numbers

pop_loop:
    cmp ebx, evenCount          ; Check if all even numbers have been popped
    je done_popping             ; If yes, exit loop
    pop eax                     ; Pop even number from stack
    mov [edi + ebx*4], eax      ; Store in arr3[EBX]
    inc ebx                     ; Move to next position in arr3
    jmp pop_loop               

done_popping:
    pop edx                     
    pop ebx                     
    pop ecx                     
    pop edi                    
    pop esi                     
    ret                         
ReverseEven ENDP


PrintArray PROC
    push esi                    
    push ecx                   
    push eax                 

    mov esi, OFFSET arr3        ; ESI points to arr3
    mov ecx, evenCount          ; Number of elements to print (even numbers only)
    xor ebx, ebx                ; EBX as index

print_loop:
    cmp ebx, ecx                ; Check if all elements have been printed
    je done_printing            ; If yes, exit loop. This is needed since this is not really a formal loop and we do not want it going on forever
    mov eax, [esi + ebx*4]      ; Load arr3[EBX] into EAX
    call WriteDec               ; Print the number 
    mov al, ' '                 
    call WriteChar              
    inc ebx                     ; Next index
    jmp print_loop              ; Continue printing

done_printing:
    call Crlf                   
    pop ebx                     
    pop eax                     
    pop ecx                     
    pop esi                     
    ret                        
PrintArray ENDP

; Main procedure
main PROC
    call ReverseEven            ; Process arr1 and fill arr3 with reversed even numbers
    call PrintArray             ; Print the contents of arr3

    exit      
main ENDP
END main