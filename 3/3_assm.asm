section .data
    prompt db "Type in N amount of numbers... And then write numbers...", 10, 0
    prompt_len equ $ - prompt
    
    space db " ", 0
    
    error_msg db "N can't be less than 1...", 10, 0
    error_len equ $ - error_msg

section .bss
    buffer resb 16      ; буфер для ввода чисел
    numbers resd 100    ; массив для чисел (макс 100)

section .text
    global _start

; функция проверки, что все цифры одинаковые
; вход: RDI = число
; выход: RAX = 1 (true) или 0 (false)
all_digs_the_same:
    cmp rdi, 10
    jl .false           ; если число < 10, возвращаем false
    
    ; обрабатываем отрицательные числа
    mov rax, rdi
    cmp rax, 0
    jge .positive
    neg rax             ; делаем положительным
.positive:
    
    xor rdx, rdx
    mov rcx, 10
    div rcx             ; делим на 10, остаток в RDX - последняя цифра
    mov rsi, rdx        ; сохраняем последнюю цифру в RSI
    
.loop:
    cmp rax, 0
    je .true            ; если число закончилось - все цифры одинаковые
    
    xor rdx, rdx
    div rcx
    cmp rdx, rsi
    jne .false          ; если цифра не совпадает - false
    jmp .loop
    
.true:
    mov rax, 1
    ret
.false:
    mov rax, 0
    ret

; функция чтения числа из stdin
; вход: RDI = буфер
; выход: RAX = число
read_number:
    push rbx
    push rcx
    push rsi
    
    mov rax, 0          ; sys_read
    mov rsi, rdi        ; буфер (сохраняем переданный адрес)
    mov rdi, 0          ; stdin
    mov rdx, 16         ; размер
    syscall
    
    mov rsi, rsi        ; восстанавливаем указатель на буфер
    xor rax, rax        ; результат
    xor rcx, rcx
    mov rbx, 10
    
.parse_loop:
    mov cl, [rsi]
    cmp cl, 10          ; проверка на Enter
    je .done
    cmp cl, 0
    je .done
    cmp cl, '0'         ; проверка на не-цифру
    jb .done
    cmp cl, '9'
    ja .done
    
    sub cl, '0'         ; преобразуем символ в цифру
    imul rax, rbx       ; умножаем на 10
    add rax, rcx
    inc rsi
    jmp .parse_loop
.done:
    pop rsi
    pop rcx
    pop rbx
    ret

; функция вывода числа
; вход: RAX = число
print_number:
    push rax
    push rbx
    push rcx
    push rdx
    push rsi
    
    mov rcx, buffer + 15
    mov byte [rcx], 0
    mov rbx, 10
    mov rsi, rax        ; сохраняем число для проверки на ноль
    
    cmp rsi, 0
    jne .loop_print
    ; если число 0, выводим '0'
    mov byte [rcx-1], '0'
    dec rcx
    jmp .print_done
    
.loop_print:
    mov rax, rsi        ; восстанавливаем число
    xor rdx, rdx
    div rbx
    mov rsi, rax        ; сохраняем частное
    add dl, '0'
    dec rcx
    mov [rcx], dl
    test rsi, rsi
    jnz .loop_print
    
.print_done:
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, rcx        ; строка для вывода
    mov rdx, buffer + 15
    sub rdx, rcx
    syscall
    
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret

_start:
    ; выводим приглашение
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, prompt_len
    syscall
    
    ; читаем amountN
    mov rdi, buffer
    call read_number
    mov rbp, rax        ; сохраняем amountN в RBP
    
    ; проверяем amountN >= 1
    cmp rbp, 1
    jge .read_numbers
    
    ; ошибка: N меньше 1
    mov rax, 1
    mov rdi, 1
    mov rsi, error_msg
    mov rdx, error_len
    syscall
    jmp .exit

.read_numbers:
    ; читаем числа в массив
    xor rbx, rbx        ; счётчик
    
.read_loop:
    cmp rbx, rbp
    jge .check_loop
    
    mov rdi, buffer
    call read_number
    mov [numbers + rbx*4], eax
    inc rbx
    jmp .read_loop

.check_loop:
    ; проверяем каждое число
    xor rbx, rbx
    
.check_next:
    cmp rbx, rbp
    jge .exit
    
    mov edi, [numbers + rbx*4]
    push rbx
    call all_digs_the_same
    pop rbx
    
    cmp rax, 1
    jne .skip_print
    
    ; выводим число
    mov eax, [numbers + rbx*4]
    push rbx
    call print_number
    
    ; выводим пробел
    push rax
    mov rax, 1
    mov rdi, 1
    mov rsi, space
    mov rdx, 1
    syscall
    pop rax
    pop rbx

.skip_print:
    inc rbx
    jmp .check_next

.exit:
    ; завершаем программу
    mov rax, 60         ; sys_exit
    xor rdi, rdi        ; код возврата 0
    syscall