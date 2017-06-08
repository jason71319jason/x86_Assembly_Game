INCLUDE lib.inc

.code
BulletMove PROC USES eax ebx ecx edx esi edi,
		HowToMove: DWORD,
		BulletPtr: ptr Bullet
	mov esi, BulletPtr
	mov ebx, HowToMove
	cmp ebx, bulletStat1
	je OneTwoBullet
	cmp ebx, 3
	je ThreeBulletLeft
	cmp ebx, 2
	je ThreeBulletMid
	cmp ebx, 1
	je ThreeBulletRight
OneTwoBullet:
	dec byte ptr (Bullet ptr [esi]).co.y
	jmp Over
ThreeBulletLeft:
	dec byte ptr (Bullet ptr [esi]).co.y
	dec byte ptr (Bullet ptr [esi]).co.x
	jmp Over
ThreeBulletMid:
	dec byte ptr (Bullet ptr [esi]).co.y
	jmp Over
ThreeBulletRight:
	dec byte ptr (Bullet ptr [esi]).co.y
	inc byte ptr (Bullet ptr [esi]).co.x
	jmp Over
Over:	
	ret
BulletMove endp
end