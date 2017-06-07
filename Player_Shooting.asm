INCLUDE Irvine32.inc
INCLUDE Player.inc
.code
Shooting PROC USES edx eax ecx edi esi,
	playerX: byte,
	playerY: byte,
	BulletPositionX2: PTR DWORD,
	BulletPositionY2: PTR DWORD,
	BulletLength: DWORD,
	BulletNum4:byte
		
	mov dh, playerY
	mov dl, playerX
	cmp BulletNum4, 1
	je OneBullet
	cmp BulletNum4, 2
	je TwoBullet
	cmp BulletNum4, 3
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
	mov edi, BulletPositionY2
	mov esi, BulletPositionX2
	movzx ecx, BulletNum4
NextBullet:
	push ecx
	mov ecx, BulletLength
	CheckBlank:
		cmp byte PTR[edi], 5
		je PutPosition
		inc edi
		inc esi
		loop CheckBlank
		jmp BREAK2
	PutPosition:
		mov byte PTR[edi], dh
		mov byte PTR[esi], dl
		pop ecx
		cmp BulletNum4, 3
		je ThreeBulletSet
		inc dl
		inc dl
		mov edi, BulletPositionY2
		mov esi, BulletPositionX2
		loop NextBullet
		jmp BREAK2
ThreeBulletSet:
		inc dl
		mov edi, BulletPositionY2
		mov esi, BulletPositionX2
	loop NextBullet
BREAK2:
	ret	
Shooting endp
end