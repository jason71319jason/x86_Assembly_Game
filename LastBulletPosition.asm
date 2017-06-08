INCLUDE lib.inc

.code
LastBulletPosition PROC USES ebx,
		LastBulletPositionX:byte,
		LastBulletPositionY:byte,
		BulletState:DWORD
	mov dl, LastBulletPositionX
	mov dh, LastBulletPositionY
	mov ebx, BulletState
	cmp ebx, bulletStat1
	je OneTwoBullet
	cmp ebx, 3
	je ThreeBulletLeft
	cmp ebx, 2
	je ThreeBulletMid
	cmp ebx, 1
	je ThreeBulletRight
OneTwoBullet:
	inc dh
	jmp Over
ThreeBulletLeft:
	inc dl
	inc dh
	jmp Over
ThreeBulletMid:
	inc dh
	jmp Over
ThreeBulletRight:
	dec dl
	inc dh
	jmp Over
Over:	
	ret
LastBulletPosition endp
end