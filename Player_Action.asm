
INCLUDE lib.inc
playerPrint proto, newCoord:coord, oldCoord:coord
.code
playerMove PROC USES eax ebx ecx edx esi edi,
		playerPos:coord,
		setPtr:ptr Bullet,
		BulletSize:DWORD,
		num:byte
		
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
	invoke playerShooting, tmpCoord ,setPtr, BulletSize, num
L:	
	ret
	
playerMove endp

playerPrint proc USES eax ebx ecx edx esi edi,
	newCoord:coord,
	oldCoord:coord
	
	mov ax, newCoord.x
	mov bx, newCoord.y
	.IF ax > Rbound || ax < Lbound 
	jmp exitLabel
	.ENDIF
	.IF bx < Ubound || bx > Dbound
	jmp exitLabel
	.ENDIF
	
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
end