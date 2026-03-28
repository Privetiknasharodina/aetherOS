const vga = @import("vga.zig");
const kbd = @import("keyboard.zig");
const utils = @import("utils.zig");
const clr = @import("colors.zig");
const sound = @import("sound.zig");

// Глобальные переменные состояния
var cursor_x: usize = 0;
var cursor_y: usize = 10;
var input_buffer: [64]u8 = undefined;
var input_len: usize = 0;

export fn _start() noreturn {
    // 1. Инициализация экрана
    vga.clear(0x00); // Черный экран
    
    // 2. Приветствие и Лого
    vga.print("--- AetherOS Kernel v0.1.0 ---", 0, 0, 0x0B);
    printLogo();
    
    // 3. Отрисовка строки ввода
    renderPrompt();

    // 4. Главный цикл ядра
    while (true) {
        // Опрос клавиатуры (Polling)
        if ((utils.inb(0x64) & 1) != 0) {
            const scancode = utils.inb(0x60);
            
            // Проверка на ESC (Выход)
            if (scancode == 0x01) {
                exitSystem();
            }

            const char = kbd.getChar(scancode);

            if (char == '\n') {
                processCommand(input_buffer[0..input_len]);
                input_len = 0;
                renderPrompt();
            } else if (char != 0 and input_len < 64) {
                input_buffer[input_len] = char;
                input_len += 1;
                vga.printChar(char, cursor_y, cursor_x, clr.current_theme);
                cursor_x += 1;
            }
        }
    }
}

fn processCommand(cmd: []const u8) void {
    cursor_y += 1;
    cursor_x = 0;

    if (utils.streql(cmd, "help")) {
        vga.print("Commands: help, clear, beep, neofetch, color [red/blue], exit", cursor_y, 0, 0x0E);
    } else if (utils.streql(cmd, "clear")) {
        vga.clear(clr.current_theme >> 4);
        cursor_y = 0;
    } else if (utils.streql(cmd, "beep")) {
        sound.beep();
        vga.print("*BEEP*", cursor_y, 0, 0x0A);
    } else if (utils.streql(cmd, "color red")) {
        clr.setTheme(clr.Color.Red, clr.Color.Black);
        vga.clear(0x00);
    } else if (utils.streql(cmd, "color blue")) {
        clr.setTheme(clr.Color.LightBlue, clr.Color.Black);
        vga.clear(0x00);
    } else if (utils.streql(cmd, "neofetch")) {
        vga.print("AetherOS v0.1", cursor_y, 0, 0x0B);
        vga.print("Kernel: Zig Bare Metal", cursor_y + 1, 0, 0x07);
        cursor_y += 2;
    } else {
        vga.print("Unknown command!", cursor_y, 0, 0x0C);
    }
    
    cursor_y += 1;
}

fn renderPrompt() void {
    vga.print("Aether@user:> ", cursor_y, 0, 0x0A);
    cursor_x = 14;
}

fn printLogo() void {
    vga.print("  ___  _____ _____ _   _ ___________ ", 2, 5, 0x03);
    vga.print(" / _ \\|  ___|_   _| | | |  ___| ___ \\", 3, 5, 0x03);
    vga.print("/ /_\\ \\ |__   | | | |_| | |__ | |_/ /", 4, 5, 0x03);
    vga.print("|  _  |  __|  | | |  _  |  __||    / ", 5, 5, 0x03);
    vga.print("| | | | |___  | | | | | | |___| |\\ \\ ", 6, 5, 0x03);
    vga.print("\\_| |_\\____/  \\_/ \\_| |_\\____/\\_| \\_|", 7, 5, 0x03);
}

fn exitSystem() noreturn {
    vga.clear(0x00);
    vga.print("AetherOS Halted. Safe to turn off.", 10, 20, 0x0F);
    while (true) {
        asm volatile ("cli");
        asm volatile ("hlt");
    }
}
