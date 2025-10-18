; Interpret as 32 bits code
[bits 32]

%include "../include/io.mac"

section .text

; int check_parantheses(char *str)
global check_parantheses

check_parantheses:
    push ebp
    mov ebp, esp

    ; string of parantheses
    mov esi, [ebp + 8]
    ; current number of parantheses in stack
    xor ecx, ecx
    ; current position in the string
    xor edx, edx

    movzx edi, byte [esi]

check_loop:
    ; Moving onto the next character in the string
    movzx edi, byte [esi + edx]
    inc edx

    ; Checking if we reached the end of the string
    cmp edi, 0
    jz exit_check

    ; Checking for open parantheses
    cmp edi, '('
    jz add_to_stack
    cmp edi, '['
    jz add_to_stack
    cmp edi, '{'
    jz add_to_stack

    ; Checking for closed parantheses
    cmp edi, ')'
    jz check_round
    cmp edi, ']'
    jz check_square
    cmp edi, '}'
    jz check_curly

    ; When reading a closed paranthese, we check if the stack is empty
    ; If it is, we return 1 and clean the stack
    ; If it is not, we check if the top of the stack is the corresponding open parantheses
check_round:
    ; If the stack is empty that means we have a closed parantheses without an open one
    cmp ecx, 0
    jz exit_not_ok
    pop eax
    cmp eax, '('
    jnz exit_not_ok
    dec ecx
    jmp check_loop

check_square:
    ; If the stack is empty that means we have a closed parantheses without an open one
    cmp ecx, 0
    jz exit_not_ok
    pop eax
    cmp eax, '['
    jnz exit_not_ok
    dec ecx
    jmp check_loop

check_curly:
    ; If the stack is empty that means we have a closed parantheses without an open one
    cmp ecx, 0
    jz exit_not_ok
    pop eax
    cmp eax, '{'
    jnz exit_not_ok
    dec ecx
    jmp check_loop

    ; Adding the open paranthese to the stack
add_to_stack:
    push edi
    inc ecx
    jmp check_loop

exit_check:
    ; If the stack is not empty, there are open parantheses without the closed correspondents
    cmp ecx, 0
    jz exit_ok
    jmp exit_not_ok

exit_ok:
    ; Returning 0 if the string is valid
    mov eax, 0
    jmp exit

clean_stack:
    pop eax
    dec ecx
    ; Cleaning the stack
    cmp ecx, 1
    jnz clean_stack
    jmp continue

exit_not_ok:
    ; If the stack is not empty, we need to clean it
    cmp ecx, 0
    jnz clean_stack
    continue:
    ; Returning 1 if the string is not valid
    mov eax, 1
    jmp exit

exit:
    leave
    ret
