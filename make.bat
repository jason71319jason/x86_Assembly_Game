﻿@echo off
REM make
REM Assembles and links the 32-bit ASM program into .exe which can be used by WinDBG
REM Uses MicroSoft Macro Assembler version 6.11 and 32-bit Incremental Linker version 5.10.7303
REM Created by Huang 
REM delete related files
del Player.obj
del Player_Action.obj
del Player_Draw.obj
del Player_Init.obj
del Player_Shooting.obj
del Enemy.obj
del Enemy_Product.obj
del Enemy_Move.obj
del Enemy_Print.obj
del StartUI.obj
del RuleUI.obj
del GameStateManager.obj
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
ML /c /coff /Zi   GameStateManager.asm
ML /c /coff /Zi   RuleUI.asm
ML /c /coff /Zi   StartUI.asm
ML /c /coff /Zi	  Player.asm
ML /c /coff /Zi   Player_Init.asm
ML /c /coff /Zi   Player_Action.asm
ML /c /coff /Zi   Player_Draw.asm
ML /c /coff /Zi   Player_Shooting.asm
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

LINK /INCREMENTAL:no /debug /subsystem:console /entry:start /out:Main.exe *.obj Kernel32.lib irvine32.lib user32.lib
if errorlevel 1 goto terminate

REM Display all files related to this program:
DIR Main.*
pause
Main.exe
:terminate
pause
endlocal