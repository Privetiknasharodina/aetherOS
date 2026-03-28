pub fn outb(port: u16, val: u8) void {
    asm volatile ("outb %[val], %[port]" : : [val] "{al}" (val), [port] "{dx}" (port));
}

pub fn inb(port: u16) u8 {
    return asm volatile ("inb %[port], %[ret]" : [ret] "={al}" (-> u8) : [port] "{dx}" (port));
}

pub fn streql(a: []const u8, b: []const u8) bool {
    if (a.len != b.len) return false;
    for (a, 0..) |char, i| { if (char != b[i]) return false; }
    return true;
}
