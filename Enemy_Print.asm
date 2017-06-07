TITLE Final_Project_Main           

INCLUDE lib.inc

.code

printEnemy proc uses eax ebx ecx edx esi,
	enemySetPtr:ptr Enemy,
	num:dword
	mov eax, 0
	call setTextColor
	call Clrscr
	mov ecx, num
	mov esi, enemySetPtr
	
printLoop:
	
	mov dl, byte ptr (Enemy ptr [esi]).co.y
	mov dh, byte ptr (Enemy ptr [esi]).co.x
	call Gotoxy
	mov eax, 248
	call SetTextColor
	mov al, byte ptr (Enemy ptr [esi]).typ
	call WriteChar
	add esi, type Enemy
	loop printLoop

	ret
	
printEnemy endp

END 