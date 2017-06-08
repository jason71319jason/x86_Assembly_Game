
INCLUDE lib.inc
playerPrint proto, newCoord:coord, oldCoord:ptr coord
.code
playerMove PROC USES eax ebx ecx edx esi edi,
		playerPos:coord,
		
	local tmpCoord:coord
L:
		
	mov eax, 20
	call Delay
	call Readkey

	cmp al, right
	je WRIGHT
	
	cmp al, left
	je WLEFT
	
	cmp al, up
	je WUP
	
	cmp al, down
	je WDOWN
	
	jmp L
	
WRIGHT:
	mov bx, playerPos.x
	mov dx, playerPos.y
	inc bx
	mov tmpCoord.x, bx
	mov tmpCoord.y, dx
	invoke playerPrint, tmpCoord, addr playerPos
	jmp L 
WLEFT:
	mov bx, playerPos.x
	mov dx, playerPos.y
	dec bx
	mov tmpCoord.x, bx
	mov tmpCoord.y, dx
	invoke playerPrint, tmpCoord, addr playerPos
	jmp L
WUP:
	mov bx, playerPos.x
	mov dx, playerPos.y
	dec dx
	mov tmpCoord.x, bx
	mov tmpCoord.y, dx
	invoke playerPrint, tmpCoord, addr playerPos
	jmp L
WDOWN:
	mov bx, playerPos.x
	mov dx, playerPos.y
	inc dx
	mov tmpCoord.x, bx
	mov tmpCoord.y, dx
	invoke playerPrint, tmpCoord, addr playerPos
	jmp L
	jmp L
	ret
playerMove endp

playerPrint proc,
	newCoord:coord,
	oldCoord:ptr coord
	.IF newCoord.x > Rbound || newCoord.x < Lbound 
	jmp exitLabel
	.ENDIF
	.IF newCoord.y < Ubound || newCoord.y > Dbound
	jmp exitLabel
	.ENDIF
	mov esi, oldCoord
	mov dl, byte ptr (Coord ptr [esi]).x
	mov dh, byte ptr (Coord ptr [esi]).y
	call gotoxy
	mov al, 32
	call writechar
	mov dl, byte ptr newCoord.x
	mov dh, byte ptr newCoord.y
	call gotoxy
	mov al, playerIcon
	call writechar
	mov byte ptr (Coord ptr [esi]).x, dl
	mov byte ptr (Coord ptr [esi]).y, dh
exitLabel:
	ret
playerPrint endp
end