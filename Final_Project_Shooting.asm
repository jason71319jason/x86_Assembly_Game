INCLUDE Irvine32.inc
INCLUDE Player.inc
.code
Shooting PROC USES edx eax ecx edi esi,
	playerX: byte,
	playerY: byte,
	BulletPositionX2: PTR DWORD,
	BulletPositionY2: PTR DWORD,
	BulletLength: DWORD
		
	mov dh, playerY
	mov dl, playerX 
	dec dh
	mov edi, BulletPositionY2
	mov esi, BulletPositionX2
	mov ecx, BulletLength
	CheckBlank:
		cmp BYTE PTR[edi], 0
		je PutPosition
		inc edi
		inc esi
		loop CheckBlank
		jmp BREAK2
	PutPosition:
		mov BYTE PTR[edi], dh
		mov BYTE PTR[esi], dl
BREAK2:
	ret	
Shooting endp
end