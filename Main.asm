TITLE Final_Project_Main           

INCLUDE lib.inc

main          EQU start@0

.data

titleStr byte "Shoot Game", 0

.code
main proc 

	invoke setConsoleTitle, addr titleStr
	invoke threadOfEnemy
	exit
	
main endp

END main