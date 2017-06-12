
INCLUDE lib.inc
playerCollision proto, newCoord:coord
playerPrint proto, newCoord:coord, oldCoord:coord
.code
playerMove PROC USES eax ebx ecx edx esi edi,
		playerPos:coord
		
	local tmpCoord:coord
		
	call Readkey
	
	mov bx, playerPos.x
	mov dx, playerPos.y
	
	cmp al, right
	je WRIGHT
	
	cmp al, left
	je WLEFT
	
	cmp al, up
	je WUP
	
	cmp al, down
	je WDOWN
	
	cmp al, shoot
	je shooting
	
	cmp al, 1bh
	je Quit
	jmp L
	
Quit:
	invoke setState, StartState
	jmp L
	
WRIGHT:
	inc bx
	mov tmpCoord.x, bx
	mov tmpCoord.y, dx
	invoke playerPrint, tmpCoord, playerPos
	jmp L 
	
WLEFT:
	dec bx
	mov tmpCoord.x, bx
	mov tmpCoord.y, dx
	invoke playerPrint, tmpCoord, playerPos
	jmp L
	
WUP:
	dec dx
	mov tmpCoord.x, bx
	mov tmpCoord.y, dx
	invoke playerPrint, tmpCoord, playerPos
	jmp L
	
WDOWN:
	inc dx
	mov tmpCoord.x, bx
	mov tmpCoord.y, dx
	invoke playerPrint, tmpCoord, playerPos
	jmp L
	
shooting:
	invoke setShootState, 1
L:	
	ret
	
playerMove endp

playerPrint proc USES eax ebx ecx edx esi edi,
	newCoord:coord,
	oldCoord:coord
	
	invoke getToolPos
	cmp ax, newCoord.x
	jne posCheck
	cmp bx, newCoord.y
	jne posCheck
	call writeChar
	invoke toolUse	
posCheck:
	mov ax, newCoord.x
	mov bx, newCoord.y
	
	.IF ax > Rbound || ax < Lbound 
	jmp exitLabel
	.ENDIF
	.IF bx < Ubound || bx > Dbound
	jmp exitLabel
	.ENDIF
	
	invoke playerCollision, newCoord

	mov dl, byte ptr oldCoord.x
	mov dh, byte ptr oldCoord.y
	call gotoxy
	mov al, 32
	call writechar
	mov dl, byte ptr newCoord.x
	mov dh, byte ptr newCoord.y
	call gotoxy
	mov al, playerIcon
	call writechar
	invoke setPlayerPos, newCoord.x, newCoord.y
	
exitLabel:
	ret
playerPrint endp

playerCollision proc USES eax ecx edx esi edi,
	newCoord:coord

enemyCheck:
	invoke getEnemySet
	invoke getEnemyNum
	mov ecx, eax
	mov bx, newCoord.x
	mov dx, newCoord.y
check:
	cmp bx, (enemy ptr [esi]).co.x
	je check2
	jmp postDo
check2:
	cmp dx, (enemy ptr [esi]).co.y
	je collision
	jmp postDo
post:
	inc ecx
postDo:
	add esi, type Enemy
	loop check
	jmp exitL
	
collision:
	mov ebx, 1
	mov (Enemy ptr [esi]).isExist, 0
	invoke deltaOfHeart, -1
	invoke deltaOfEnemyNum, -1
	mov dl, byte ptr (enemy ptr [esi]).co.x
	mov dh, byte ptr (enemy ptr [esi]).co.y
	call gotoxy
	mov al, playerIcon
	call writechar
exitL:
	ret
playerCollision endp
end