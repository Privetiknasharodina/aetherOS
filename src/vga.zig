pub const VIDEO_ADDR: [*]volatile u16 = @ptrFromInt(0xB8000);
pub const ROWS = 25;
pub const COLS = 80;

pub fn clear(color: u8) void {
    var i: usize = 0;
    while (i < ROWS * COLS) : (i += 1) {
        VIDEO_ADDR[i] = (@as(u16, color) << 8) | ' ';
    }
}

pub fn print(msg: []const u8, row: usize, col: usize, color: u8) void {
    const offset = row * COLS + col;
    for (msg, 0..) |char, i| {
        VIDEO_ADDR[offset + i] = (@as(u16, color) << 8) | char;
    }
}
