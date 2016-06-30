\mingw\bin\asw -L game.asm
if errorlevel 1 goto norun
\mingw\bin\p2bin -r 0-511 -l 0 game.p
del game.p
..\emulator\elf.exe game.bin
:norun
