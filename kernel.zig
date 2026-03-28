const vga = @import("vga.zig");
const kbd = @import("keyboard.zig");
const utils = @import("utils.zig");
const clr = @import("colors.zig");
const sound = @import("sound.zig");

// Теперь команды выглядят супер-чисто:
if (utils.streql(cmd, "beep")) {
    sound.beep();
    vga.print("BEEP!", row, col, clr.current_theme);
}
