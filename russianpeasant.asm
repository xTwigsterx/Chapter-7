; Zachariah Alber
;russian peasant multiplication algorithm
;most of this is based on a file online
    section .text

    global mult

mult:
    push rbp
    mov  rbp, rsp
    sub  rsp, 8     ;allocate m

    mov  qword [rbp-8], 0   ; m = 0;
.while:
    test rdi, rdi   ; x == 0?
    je .done
    test rsi, rsi   ; y == 0?
    je .done

    test rdi, 0x01  ; x is odd?
    jz .shifts
    add  [rbp-8], rsi   ; m += y;
.shifts:
    shr  rdi, 1     ; x >>= 1;
    shl  rsi, 1     ; y <<= 1;
    jmp  .while

.done:
    mov  rax, [rbp-8]
    ;mov  rsp, rbp
    ;pop  rbp
    leave
    ret


    global mult128

; Locate the parameters:
%define Pupper64 rdi
%define Plower64 rsi
%define x64 rdx
%define y64 rcx

mult128:
    push rbp
    mov  rbp, rsp
    sub  rsp, 8     ;allocate y128
%define Py128 rbp-8

    mov  qword [Py128], 0   ; y128 = 0;
    mov  qword [Pupper64], 0   ; *upper64 = 0;
    mov  qword [Plower64], 0   ; *lower64 = 0;
.while:
    test x64, x64       ; x64 == 0?
    jz .done            ; x64 is 0?

    test x64, 0x01      ; is x64 odd?
    jz .shifts          ; x64 not odd?

    mov  rax, [Py128]   ; (can't add directly)
    add  [Pupper64], rax
    add  [Plower64], y64
    jnc  .shifts        ; no carry from lower64 to upper64?
    inc  qword [Pupper64]       ; carry from lower64 to upper64!

.shifts:
    shr  x64, 1         ; x64 >>= 1;
    shl  qword[Py128], 1; y128 <<= 1;
    shl  y64, 1         ; y64 <<= 1;
    jnc  .while         ; no carry from y64 to y128?
    inc  qword[Py128]           ; carry from y64 to y128!
    jmp  .while

.done:
    leave
    ret
