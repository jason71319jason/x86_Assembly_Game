
INCLUDE lib.inc

.data

startPos coord <10,10>
bulletSet Bullet 1000 DUP(<>)
bulletNum byte 3

.code

threadOfPlayer proc
	call Clrscr
	INVOKE playerInit,
		startPos

	INVOKE playerMove,
		startPos

	call WaitMsg
	ret
threadOfPlayer	endp

playerInit PROC USES eax edx ecx,
		cord:coord,

	mov dh, byte ptr cord.y
	mov dl, byte ptr cord.x
	call Gotoxy
	mov ax, playerIcon
	call WriteChar
	ret
playerInit endp

end
