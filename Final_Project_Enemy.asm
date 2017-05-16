TITLE Final_Project_Main           

INCLUDE Irvine32.inc

Coord struct
	x dword ?
	y dword ?
Coord ends

Enemy struct
	co Coord <>
	typ byte 1
Enemy ends

printEnemy proto, enemySetPtr:ptr Enemy, enemyNum:dword 
productEnemy proto, enemySetPtr:ptr Enemy

main          EQU start@0

.data

enemyNum dword 0
enemySet Enemy 20 dup(<>)

.code

printEnemy proc uses eax, edx
	enemySetPtr:ptr Enemy,
	enemyNum:dword
	
	call Clrscr
	mov enemyNum, ecx
	
printLoop:
	
	mov dl, (Enemy ptr [enemySetPtr]).y
	mov dh, (Enemy ptr [enemySetPtr]).x
	call Gotoxy
	mov eax, 240
	call SetTextColor
	mov al, (Enemy ptr [enemySetPtr]).typ
	call WriteChar
	
	loop printLoop
printEnemy endp

productEnemy proc uses eax, edx
	enemySetPtr:ptr Enemy
	
	call Randomize
	mov eax, 100
	call RandomRange
	mov (Enemy ptr [enemySetPtr]).x, eax
	mov eax, 100
	call RandomRange
	mov (Enemy ptr [enemySetPtr]).y, eax
	add enemyNum, 1
	
productEnemy endp
END main