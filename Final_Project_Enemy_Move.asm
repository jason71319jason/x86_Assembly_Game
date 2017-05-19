TITLE Final_Project_Main           

INCLUDE lib.inc

.code

moveEnemy proc uses eax ebx ecx,
	enemySetPtr:ptr Enemy
	num:dword

	mov ecx, num
	mov esi, enemySetPtr
move:
	add dword ptr (Enemy ptr [esi]).co.x, 1
	loop move
moveEnemy endp

END main