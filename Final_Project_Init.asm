INCLUDE Irvine32.inc
INCLUDE Player.inc
.code
Init PROC USES eax edx,
		playerX2: byte,
		playerY2: byte,
		playerPosition: word
		
	call Clrscr
	mov dh, playerY2
	mov dl, playerX2 
	call Gotoxy
	mov ax, playerPosition
	call WriteChar
	ret
Init endp
end