@echo off
cd ..\processor
call build
cd ..\emulator
mingw32-make
copy /Y elf.exe ..\build
