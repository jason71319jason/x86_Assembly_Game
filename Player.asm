
INCLUDE lib.inc

.data

bulletSet Bullet 1000 DUP(<>)
bulletCanonNum byte 3
bulletNum sdword 0
isShoot byte 0
playerPos coord <38,33>
score dword 0

.code

threadOfPlayer proc uses eax,
	
	invoke playerMove, playerPos
	.IF isShoot == 1
	invoke bulletProductSet, addr bulletSet, bulletCanonNum, playerPos
	mov isShoot, 0
	.ENDIF
	invoke bulletPrint, addr bulletSet, bulletNum, playerPos
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

deltaOfbulletNum proc uses eax,
	delta:sdword
	mov eax, delta
	add bulletNum, eax
	cmp bulletNum, 0
	jnl nonZero
	mov bulletNum, 0

nonZero:	
	ret
deltaOfbulletNum endp

deltaOfScore proc uses eax,
	delta:dword
	mov eax, delta
	add score, eax
	ret
deltaOfScore endp

getBulletSet proc
	mov esi, offset bulletSet
	ret
getBulletSet endp

getBulletNum proc
	mov eax, bulletNum
	ret
getBulletNum endp
end
