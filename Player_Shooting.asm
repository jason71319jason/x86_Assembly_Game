
INCLUDE lib.inc
.code
playerShooting PROC USES edx eax ecx edi esi,
	playerPos:coord,
	setPtr:ptr bullet,
	BulletSize:DWORD,
	num:byte
		
	mov dh, byte ptr playerPos.y
	mov dl, byte ptr playerPos.x
	cmp num, 1
	je OneBullet
	cmp num, 2
	je TwoBullet
	cmp num, 3
	je ThreeBullet
OneBullet:
	dec dh
	jmp Ready
TwoBullet:
	dec dh
	dec dl
	jmp Ready
ThreeBullet:
	dec dh
	dec dl
	jmp Ready
Ready:
	mov esi, setPtr 
	movzx ecx, num
NextBullet:
	push ecx
	mov ecx, BulletSize
	CheckBlank:
		cmp byte ptr (Bullet ptr [esi]).co.y, 5
		je PutPosition
		add esi, type Bullet
		loop CheckBlank
		jmp BREAK2
	PutPosition:
		mov byte ptr (Bullet ptr [esi]).co.y, dh
		mov byte ptr (Bullet ptr [esi]).co.x, dl
		pop ecx
		cmp num, 3
		je ThreeBulletSet
		inc dl
		inc dl
		mov esi, setPtr 
		loop NextBullet
		jmp BREAK2
ThreeBulletSet:
		inc dl
		mov esi, setPtr 
	loop NextBullet
BREAK2:
	ret	
playerShooting endp
end