; Interpret as 64 bits code
[bits 64]

; nu uitati sa scrieti in feedback ca voiati
; assembly pe 64 de biti

section .text
global map
global reduce
; void map(int64_t *destination_array, int64_t *source_array, int64_t array_size, int64_t(*f)(int64_t));
; int64_t map_func1(int64_t curr_elem);
map:
    ; look at these fancy registers
    push rbp
    mov rbp, rsp

    ; rdi = Destination array
    ; rsi = Source array
    ; rdx = Array size
    ; rcx = Pointer to map_func1

    ; rbx = Pointer to map_func1 so that I can use rcx as counter
    mov rbx, rcx
    ; r8 = Destination array so that I can use rdi for calling the function map_func1
    mov r8, rdi
    xor rcx, rcx
map_loop:
    cmp rcx, rdx
    jz exit_map_loop

    ; rdi = Current element
    mov rdi, [rsi + rcx * 8]
    call rbx
    ; Now I have in rax the result of the function
    mov [r8 + rcx * 8], rax
    inc rcx
    jmp map_loop

exit_map_loop:

    leave
    ret


; int reduce(int *dst, int *src, int n, int acc_init, int(*f)(int, int));
; int f(int acc, int curr_elem);
reduce:
    ; look at these fancy registers
    push rbp
    mov rbp, rsp

    ; rdi = Destination array
    ; rsi = Source array
    ; rdx = Array size
    ; rcx = acc_init
    ; r8 = reduce_func1

    ; ebx = acc_init so that I can use rcx as counter
    mov rbx, rcx
    ; r9 = Destination array so that I can use rdi for calling the function reduce_func1
    mov r9, rdi
    ; r10 = Source array so that I can use rsi for calling the function reduce_func1
    mov r10, rsi
    ; rdi = acc_init
    mov rdi, rcx

    xor rcx, rcx
reduce_loop:
    cmp rcx, rdx
    jz exit_reduce_loop

    ; rsi = Current element
    mov rsi, [r10 + rcx * 8]
    push rdx
    call r8
    pop rdx
    ; Now I have in rax the result of the function = the new accumulator
    mov rdi, rax
    inc ecx
    jmp reduce_loop

exit_reduce_loop:
    leave
    ret

