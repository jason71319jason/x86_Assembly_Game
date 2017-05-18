TITLE Final_Project_Main           

INCLUDE lib.inc

main          EQU start@0

.data

enemyNum dword 0
enemySet Enemy 20 dup(<>)

.code

main proc 
	mov ecx, 10
L:
	invoke productEnemy, addr enemySet, enemyNum
	invoke printEnemy, addr enemySet, enemyNum
	mov eax, 100
	call delay
	loop L
	call crlf
	call waitmsg
main endp

printEnemy proc uses eax ebx ecx,
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

productEnemy proc uses eax ebx ecx,
	enemySetPtr:ptr Enemy,
	num:dword

	mov esi, enemySetPtr
	mov eax, num
	mov ebx, type Enemy
	mul ebx
	add esi, eax
	call Randomize
	mov eax, 100
	call RandomRange
	mov byte ptr (Enemy ptr [esi]).co.y, al
	add enemyNum, 1
	
	ret
	
productEnemy endp

END main