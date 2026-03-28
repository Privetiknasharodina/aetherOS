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
// Глобальная переменная текущего цвета (Белый на Черном по умолчанию)
pub var current_theme: u8 = 0x0F; // По умолчанию: Белый текст на черном

/// Функция для создания байта атрибута (фон + текст)
pub fn setTheme(text: Color, background: Color) void {
    current_theme = (@as(u8, @intFromEnum(background)) << 4) | @as(u8, @intFromEnum(text));
}

