%include "../include/io.mac"

; The `expand` function returns an address to the following type of data
; structure.
struc neighbours_t
    .num_neighs resd 1  ; The number of neighbours returned.
    .neighs resd 1      ; Address of the vector containing the `num_neighs` neighbours.
                        ; A neighbour is represented by an unsigned int (dword).
endstruc

section .bss
; Vector for keeping track of visited nodes.
visited resd 10000
global visited

section .data
; Format string for printf.
fmt_str db "%u", 10, 0

section .text
global dfs
extern printf

; C function signiture:
;   void dfs(uint32_t node, neighbours_t *(*expand)(uint32_t node))
; where:
; - node -> the id of the source node for dfs.
; - expand -> pointer to a function that takes a node id and returns a structure
; populated with the neighbours of the node (see struc neighbours_t above).
;
; note: uint32_t is an unsigned int, stored on 4 bytes (dword).
dfs:

    push ebp
    mov ebp, esp
    pusha

    ; ebx = origin node
    mov ebx, [ebp + 8]
    ; edi = address of the expand function
    mov edi, [ebp + 12]

    ; Print the current node
    push ebx
    push fmt_str
    call printf
    ; Clean the stack
    add esp, 8

    xor eax, eax
    ; Call the expand function to get the neighbours of the current node
    push ebx
    call edi
    ; Clean the stack
    add esp, 4
    ; Now, eax = address of the neighbours_t structure

    ; edx = visited flag
    mov edx, 1
    ; Mark the current node as visited
    mov dword [visited + ebx * 4], edx

    ; For each neighbour, call the dfs function recursively if the node has not been visited
    xor edx, edx
    ; edx = number of neighbours
    mov edx, dword [eax]
    ; esi = address of the neighbours vector
    mov esi, dword [eax + 4]

    xor ecx, ecx
neighbours_loop:
    cmp ecx, edx
    jz exit_neighbours_loop

    ; eax = current neighbour
    mov eax, dword [esi + ecx * 4]
    ; ebx = visited flag
    mov ebx, dword [visited + eax * 4]
    ; If the node has been visited, skip it
    cmp ebx, 1
    jz skip_neighbour

    ; if not visited, call dfs
    push edi
    push eax
    call dfs
    ; Clean the stack
    add esp, 8

skip_neighbour:
    inc ecx
    jmp neighbours_loop

exit_neighbours_loop:
    popa
    leave
    ret
