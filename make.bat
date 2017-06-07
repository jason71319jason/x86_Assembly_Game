@echo off
REM make
REM Assembles and links the 32-bit ASM program into .exe which can be used by WinDBG
REM Uses MicroSoft Macro Assembler version 6.11 and 32-bit Incremental Linker version 5.10.7303
REM Created by Huang 
REM delete related files
del Enemy.obj
del Enemy_Product.obj
del Enemy_Move.obj
del Enemy_Print.obj
del PrintUI.obj
del Main.lst	
del Main.obj
del Main.ilk
del Main.pdb
del Main.exe

setlocal 
set INCLUDE=D:\tool\folder\WINdbgFolder;	REM 這裡要設成WINdbgFolder的路徑
set LIB=D:\tool\folder\WINdbgFolder;
set PATH=D:\tool\folder\WINdbgFolder;

REM /c          assemble without linking
REM /coff       generate object code to be linked into flat memory model 
REM /Zi         generate symbolic debugging information for WinDBG
REM /Fl		Generate a listing file

ML /c /coff /Zi   PrintUI.asm
ML /c /coff /Zi   Enemy.asm
ML /c /coff /Zi   Enemy_Move.asm
ML /c /coff /Zi   Enemy_Product.asm
ML /c /coff /Zi   Enemy_Print.asm
ML /c /coff /Zi   Main.asm
if errorlevel 1 goto terminate

REM /debug              generate symbolic debugging information
REM /subsystem:console  generate console application code
REM /entry:start        entry point from WinDBG to the program 
REM                           the entry point of the program must be _start

REM /out:%1.exe         output %1.exe code
REM %1.obj              input %1.obj
REM Kernel32.lib        library procedures to be invoked from the program
REM irvine32.lib
REM user32.lib

LINK /INCREMENTAL:no /debug /subsystem:console /entry:start /out:Main.exe Main.obj PrintUI.obj Enemy_Move.obj Enemy_Print.obj Enemy_Product.obj Enemy.obj Kernel32.lib irvine32.lib user32.lib
if errorlevel 1 goto terminate

REM Display all files related to this program:
DIR Main.*

Main.exe
:terminate
pause
endlocal