// AetherOS Color Themes Module
// Allows changing terminal colors on the fly

pub const Color = enum(u8) {
    Black = 0x0,
    Blue = 0x1,
    Green = 0x2,
    Cyan = 0x3,
    Red = 0x4,
    Magenta = 0x5,
    Brown = 0x6,
    LightGray = 0x7,
    DarkGray = 0x8,
    LightBlue = 0x9,
    LightGreen = 0xA,
    LightCyan = 0xB,
    LightRed = 0xC,
    LightMagenta = 0xD,
    Yellow = 0xE,
    White = 0xF,
};

pub var current_theme: u8 = 0x0F; // По умолчанию: Белый текст на черном

pub fn setTheme(text: Color, background: Color) void {
    current_theme = (@as(u8, @intFromEnum(background)) << 4) | @as(u8, @intFromEnum(text));
}

pub fn applyToChar(char: u8) u16 {
    return (@as(u16, current_theme) << 8) | char;
}
fn processCommand(cmd: []const u8) void {
    if (compareStrings(cmd, "color red")) {
        // Устанавливаем: Красный текст (Red), Черный фон (Black)
        clr.setTheme(clr.Color.Red, clr.Color.Black);
        clearScreen(); // Очищаем экран, чтобы весь фон стал черным
        printAt("Theme changed to Red!", 0, 0, clr.current_theme);
    } 
    else if (compareStrings(cmd, "color blue")) {
        clr.setTheme(clr.Color.LightBlue, clr.Color.Black);
        clearScreen();
        printAt("Theme changed to Blue!", 0, 0, clr.current_theme);
    }
    // ... твои старые команды (help, exit)
}

if (compareStrings(cmd, "help")) {
    printAt("Commands: help, clear, exit, neofetch, color [name]", cursor_y, 0, 0x0E);
    cursor_y += 1;
    printAt("Colors: red, blue, green, cyan, white, yellow", cursor_y, 0, 0x07);
}

fn printAt(message: []const u8, row: usize, col: usize, color: u8) void {
    const offset = row * 80 + col;
    // Используем переданный 'color' или 'clr.current_theme'
    for (message, 0..) |char, i| {
        VIDEO_ADDR[offset + i] = (@as(u16, color) << 8) | char;
    }
}
