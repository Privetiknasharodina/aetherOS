# aetherOS
made by AI GEMINI and COpilot

# 🌌 AetherOS

A custom 32-bit operating system written from scratch using **Zig** and **x86 Assembly**. 
No Linux, no Windows — just pure hardware control.

## ✨ Features
- **Custom 32-bit Kernel**: Written in Zig (freestanding).
- **Hybrid Bootloader**: Legacy BIOS boot with transition to Protected Mode.
- **Real-Time Clock**: Live RTC display in the corner (direct CMOS reading).
- **Interactive Shell**: Support for custom commands.
- **Power Management**: Soft-halt via `exit` command or `ESC` key.
- **Custom ASCII Art**: Brand new startup logo.

## 🛠 Tech Stack
- **Languages**: [Zig](https://ziglang.org), NASM (x86 Assembly)
- **Emulator**: [QEMU](https://www.qemu.org)
- **Build System**: Bash Scripting

## 🚀 Quick Start

1. **Install dependencies** (Ubuntu/Debian):
   ```bash
   sudo apt install nasm qemu-system-x86 zig
2. **Clone and Run**:
 bash
 git clone https://github.com
 cd AetherOS
 chmod +x build.sh
./build.sh

## ⌨️ Available Commands
- Command	Action
- help	Shows the list of available commands
- info	Displays OS version and credits
- clear	Clears the terminal screen
- exit	Safely halts the CPU
  ESC	Emergency shutdown (keyboard shortcut)
  
## 📜 License
This project is licensed under the MIT License - see the LICENSE file for details.

2. How to add the Screenshot to GitHub
Take a screenshot: Run ./build.sh, wait for the AetherOS logo, and capture the QEMU window.
Save it: Name it screenshot.png.
Organize:
Create a folder named assets in your project root.
Move screenshot.png into the assets folder.
Update README.md: Add this line right under your main title:
![AetherOS Screenshot](assets/screenshot.png)
3. Push everything to GitHub
Run these commands in your terminal to sync your latest features and the image:
bash
# Add the new asset and the updated code
git add assets/screenshot.png src/kernel.zig README.md

# Commit the changes
git commit -m "feat: add beep command and project screenshot"

# Push to GitHub
git push

Created with ❤️ as a "Bare Metal" experiment.

