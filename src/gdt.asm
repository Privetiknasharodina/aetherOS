; Global Descriptor Table
gdt_start:
    dq 0x0          ; Пустой дескриптор (обязательно)

gdt_code:           ; Сегмент кода
    dw 0xffff       ; Limit (0-15 биты)
    dw 0x0          ; Base (0-15 биты)
    db 0x0          ; Base (16-23 биты)
    db 10011010b    ; Flags (P, DPL, S, Type)
    db 11001111b    ; Flags (G, DB, L, AVL, Limit)
    db 0x0          ; Base (24-31 биты)

gdt_data:           ; Сегмент данных
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; Размер GDT
    dd gdt_start               ; Адрес начала GDT

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
