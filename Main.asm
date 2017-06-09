TITLE Final_Project_Main           

INCLUDE lib.inc

main          EQU start@0

.data

startPos coord <10,10>
outHandle dword ?
titleStr byte "Shoot Game", 0
_coord Coord <80, 45>
_small_rect SMALL_RECT <0, 0, 79, 44>

.code
main proc 
	
	invoke getStdHandle, STD_OUTPUT_HANDLE
	mov outHandle, eax
	invoke setConsoleScreenBufferSize, outHandle, _coord
	invoke setConsoleWindowInfo, outHandle, 1, addr _small_rect
	invoke setConsoleTitle, addr titleStr	
	call clrscr
	invoke gameStateManage

	exit
main endp

END main