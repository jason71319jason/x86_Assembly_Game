
INCLUDE lib.inc

.data

bulletSet Bullet 1000 DUP(<>)
bulletCanonNum byte 1
isShoot byte 0
playerPos coord <10,10>

.code

threadOfPlayer proc uses eax,
	
	invoke setShootState, 0
	invoke playerMove, playerPos, addr bulletSet, lengthof bulletSet, bulletCanonNum
	cmp isShoot, 0
	je ExitLabel
	invoke bulletPrint, playerPos, addr bulletSet, lengthof bulletSet, bulletCanonNum
ExitLabel:

	ret
threadOfPlayer	endp

playerInit PROC USES eax edx ecx,
	cord:coord

	mov dh, byte ptr cord.y
	mov dl, byte ptr cord.x
	call Gotoxy
	mov ax, playerIcon
	call WriteChar
	ret
	
playerInit endp

setShootState proc USES eax edx ecx,
	x:byte
	mov al, x
	mov isShoot, al
	ret
setShootState endp

setPlayerPos proc USES eax edx ecx,
	newX:word,
	newY:word
	
	mov ax, newX
	mov bx, newY
	mov playerPos.x, ax
	mov playerPos.y, bx
	ret
setPlayerPos endp
end
