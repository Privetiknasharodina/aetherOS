[bits 16]
[org 0x7c00]

KERNEL_OFFSET equ 0x1000 ; Куда мы загружаем ядро

start:
    mov [BOOT_DRIVE], dl ; Сохраняем номер диска

    ; Настройка стека
    mov bp, 0x9000
    mov sp, bp

    call load_kernel      ; Читаем ядро с диска
    call switch_to_pm     ; Переходим в 32-битный защищенный режим
    jmp $

%include "src/gdt.asm"    ; Подключаем таблицу дескрипторов

[bits 16]
load_kernel:
    mov bx, KERNEL_OFFSET ; Буфер в памяти
    mov dh, 30            ; Сколько секторов читать (увеличили для Zig ядра)
    mov dl, [BOOT_DRIVE]
    
    mov ah, 0x02
    mov al, dh
    mov ch, 0x00
    mov dh, 0x00
    mov cl, 0x02          ; Начинаем со 2-го сектора (сразу после бутлоадера)
    int 0x13
    ret

[bits 16]
switch_to_pm:
    cli                   ; Выключаем прерывания
    lgdt [gdt_descriptor]  ; Загружаем GDT
    mov eax, cr0
    or eax, 0x1           ; Устанавливаем бит защищенного режима
    mov cr0, eax
    jmp CODE_SEG:init_pm  ; Прыжок в 32-битный сегмент

[bits 32]
init_pm:
    mov ax, DATA_SEG      ; Обновляем регистры сегментов
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000      ; Обновляем стек для 32 бит
    mov esp, ebp

    call KERNEL_OFFSET    ; ВЫЗОВ ТВОЕГО ЯДРА НА ZIG!
    jmp $

BOOT_DRIVE db 0
times 510-($-$$) db 0
dw 0xaa55                 ; Магическая подпись загрузчика
