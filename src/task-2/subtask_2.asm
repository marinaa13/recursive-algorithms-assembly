; subtask 2 - bsearch

section .text
    global binary_search
    ;; no extern functions allowed

; int32_t __attribute__((fastcall))
; binary_search(int32_t *buff, uint32_t needle, uint32_t start, uint32_t end);

; On the Intel 386, the fastcall attribute causes the compiler to pass the first argument
; (if of integral type) in the register ECX and the second argument (if of integral type)
; in the register EDX. Subsequent and other typed arguments are passed on the stack.
; The called function will pop the arguments off the stack.
binary_search:
    ;; create the new stack frame
    enter 0, 0

    ;; save the preserved registers
    push ebx
    push ecx
    push edx
    push esi
    push edi

    ;; recursive bsearch implementation goes here

    ; ecx => buff; edx =>needle
    ; eax = start
    mov eax, [ebp + 8]
    ; ebx = end
    mov ebx, [ebp + 12]

    ; If the start is greater than the end, exit
    cmp eax, ebx
    jg exit_recursion_notok

    ; Temporarily free registers
    push edx
    push eax
    add eax, ebx
    ; equivalent to div 2
    shr eax, 1
    ; esi => middle
    mov esi, eax

    ; Restore registers
    pop eax
    pop edx

    ; Checking if we found the element
    mov edi, dword [ecx + 4 * esi]
    cmp edi, edx
    jz found_needle

    ; Still searching...
    cmp edi, edx
    jg move_left
    jmp move_right

; Recursively call the function on the left side
move_left:
    mov ebx, esi
    dec ebx
    push ebx
    push eax
    call binary_search
    jmp exit_recursion

; Recursively call the function on the right side
move_right:
    mov eax, esi
    inc eax
    push ebx
    push eax
    call binary_search
    jmp exit_recursion

found_needle:
    mov eax, esi
    jmp exit_recursion

exit_recursion_notok:
    ; Return -1 if not found
    mov eax, -1

exit_recursion:
    ;; restore the preserved registers
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx

    leave
    ; Return and clean the stack
    ret 8
