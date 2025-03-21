TITLE Lab 4 and 5 | Bubble sort implementation on an array in assembly 

; Name: Daniel Papovic
; Date: March 19, 2025
; ID: 110134022

COMMENT !
Description:
This program sorts an array of 10 signed 32-bit integers using the Bubble Sort algorithm.
It first displays the original array, then sorts the array in ascending order using nested loops
and swap operations, and finally displays the sorted array.
!

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib
INCLUDELIB kernel32.lib
INCLUDELIB user32.lib

.data
    arr SDWORD 5, -3, 8, 12, -7, 6, 4, 10, 2, 0  ; Our 10-element array to sort
    msgOriginal BYTE "Original Array: ", 0        ; Text for unsorted array
    msgSorted BYTE "Sorted Array: ", 0            ; Text for sorted array
    space BYTE " ", 0                             ; Space between numbers
    newline BYTE 0Dh, 0Ah, 0                      ; Newline for clean output



.code

PrintArray PROC
    push esi                    
    push ecx                    ; Save registers
    push eax                    
    
    mov esi, OFFSET arr         ; Point ESI to the array
    mov ecx, 10                 ; Set counter to 10 (array size)
    
print_loop:
    mov eax, [esi]              ; Get array element
    call WriteInt               ; Print it as a signed integer
    mov edx, OFFSET space       ; Add a space after the number
    call WriteString
    add esi, 4                  ; Move to next element (4 bytes per SDWORD)
    loop print_loop             ; Loop until all 10 are printed

    mov edx, OFFSET newline     ; Add a newline at the end
    call WriteString

    pop eax                    
    pop ecx                     ; Restore registers
    pop esi          

    ret                         ; Return to main
PrintArray ENDP


BubbleSort PROC
    push eax                    
    push ebx
    push ecx
    push edx
    push esi
    
    mov ecx, 9                  ; Outer loop: 9 passes needed (n-1)
    
outer_loop:
    mov esi, OFFSET arr         ; Point to start of array
    mov ebx, ecx                ; Inner loop counter = outer loop counter
    
inner_loop:
    mov eax, [esi]              ; Get current element
    cmp eax, [esi+4]            ; Compare with next element
    jle no_swap                 ; If current <= next, no need to swap
    
    
    mov edx, [esi+4]            ; Get next element in EDX

    ; Swap the elements using XCHG so that we do not accidentally use a duplicate
    xchg eax, edx               ; Exchange the values
    ; Swaps the current and next array elements in a single instruction, 
    ; Ensuring no data is lost and avoiding duplicates during the swap


    mov [esi], eax              ; Store smaller value
    mov [esi+4], edx            ; Store larger value
    
no_swap:
    add esi, 4                  ; Move to next pair
    dec ebx                     ; Decrement inner loop counter
    jnz inner_loop              ; Continue inner loop if not zero
    
    loop outer_loop             ; Continue outer loop for all passes
    
    pop esi                     ; Restore registers same as before 
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
BubbleSort ENDP


main PROC

    ; Display the original array
    mov edx, OFFSET msgOriginal
    call WriteString
    call PrintArray
    
    ; Sort the array using bubble sort
    call BubbleSort
    
    ; Display the sorted array
    mov edx, OFFSET msgSorted
    call WriteString
    call PrintArray
    
    exit                        
main ENDP

END main