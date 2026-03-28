// AetherOS Sound Module (PC Speaker Driver)
// Filename: src/sound.zig

const SPEAKER_PORT = 0x61;
const PIT_COMMAND = 0x43;
const PIT_DATA_CH2 = 0x42;

/// Makes a simple beep sound
pub fn beep() void {
    // Включаем динамик (устанавливаем 0 и 1 биты порта 0x61)
    const state = inb(SPEAKER_PORT);
    outb(SPEAKER_PORT, state | 0x03);

    // Очень грубая задержка (около 100мс в эмуляторе)
    var i: u32 = 0;
    while (i < 2000000) : (i += 1) {
        asm volatile ("nop");
    }

    // Выключаем динамик
    outb(SPEAKER_PORT, state & 0xFC);
}

/// Plays a specific frequency (Hz)
pub fn playTone(frequency: u32) void {
    const divisor = 1193180 / frequency;
    
    outb(PIT_COMMAND, 0xB6);
    outb(PIT_DATA_CH2, @intCast(divisor & 0xFF));
    outb(PIT_DATA_CH2, @intCast((divisor >> 8) & 0xFF));

    const state = inb(SPEAKER_PORT);
    outb(SPEAKER_PORT, state | 0x03);
}

fn inb(port: u16) u8 {
    return asm volatile ("inb %[port], %[ret]" : [ret] "={al}" (-> u8) : [port] "{dx}" (port));
}

fn outb(port: u16, val: u8) void {
    asm volatile ("outb %[val], %[port]" : : [val] "{al}" (val), [port] "{dx}" (port));
}
