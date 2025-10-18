; subtask 1 - qsort
section .data
    ; Initialize the poz which will be used to store the pivot position
    poz dd -1

section .text


; void quick_sort(int32_t *buff, uint32_t start, uint32_t end)
global quick_sort
    ;; no extern functions allowed

quick_sort:
    ;; create the new stack frame
    enter 0, 0

    ;; save the preserved registers
    pusha

    ; esi = buff
    mov esi, [ebp + 8]
    ; eax = start
    mov eax, [ebp + 12]
    ; ebx = end
    mov ebx, [ebp + 16]

    cmp eax, ebx
    jge exit_recursion

    ; Loop to partition the array using the last element as pivot
partition:
    ; edx = pivot = rightmost element
    mov edx, dword [esi + 4 * ebx]
    dec eax
    mov dword [poz], eax
    inc eax
    ; ecx = j
    mov ecx, eax

    pivot_loop:
    cmp ecx, ebx
    jz exit_pivot_loop

    ; edi = arry[j]
    mov edi, dword [esi + 4 * ecx]
    cmp edi, edx
    jle swap
    inc ecx
    jmp pivot_loop

    swap:
    push eax
    push ebx
    push edx

    ; poz++
    mov eax, dword [poz]
    inc eax
    mov dword [poz], eax

    ; swap arr[poz] with arr[ecx]
    ; edx = arr[poz]
    mov edx, dword [esi + 4 * eax]
    ; ebx = arr[ecx]
    mov ebx, dword [esi + 4 * ecx]
    ; arr[poz] = arr[ecx]
    mov dword [esi + 4 * eax], ebx
    ; arr[ecx] = arr[poz]
    mov dword [esi + 4 * ecx], edx

    pop edx
    pop ebx
    pop eax

    inc ecx
    jmp pivot_loop

    exit_pivot_loop:
    mov edx, dword [poz]
    inc edx
    mov dword [poz], edx

    ; swap arr[poz + 1], arr[end]
    ; ecx = arr[poz + 1]
    mov ecx, dword [esi + 4 * edx]
    ; edi = arr[end]
    mov edi, dword [esi + 4 * ebx]
    ; arr[poz + 1] = arr[end]
    mov dword [esi + 4 * edx], edi
    ; arr[end] = arr[poz + 1]
    mov dword [esi + 4 * ebx], ecx

    ; recursive call on the left of the pivot
    mov edx, dword [poz]
    dec edx
    push edx
    push eax
    push esi
    call quick_sort
    ; restore the stack
    add esp, 12

    ; recursive call on the right of the pivot
    mov edx, dword [poz]
    inc edx
    push ebx
    push edx
    push esi
    call quick_sort
    ; restore the stack
    add esp, 12

exit_recursion:
    ;; restore the preserved registers
    popa
    leave
    ret
