Draw PROC USES eax edi ecx edx esi,
		bulletLocationX: PTR DWORD,
		bulletLocationY: PTR DWORD,
		playerX3: byte,
		playerY3: byte,
		playerPosition2: word,
		BulletLength2: DWORD,
		bulletPosition: word
		
	mov edi, bulletLocationY
	mov esi, bulletLocationX
	call Clrscr
	mov dh, playerY3
	mov dl, playerX3
	call Gotoxy
	mov ax, playerPosition2
	call WriteChar
	mov ecx, BulletLength2	

	BulletDrawCheck:
		cmp BYTE PTR[edi], 0
		jne DrawBullet
		inc edi
		inc esi
		loop BulletDrawCheck
		jmp BREAK1
	DrawBullet:
		mov dh, BYTE PTR[edi]
		mov dl, BYTE PTR[esi]
		call Gotoxy
		mov ax, bulletPosition
		call WriteChar
		dec BYTE PTR[edi]
		inc edi
		inc esi
		loop BulletDrawCheck
BREAK1:
	ret
Draw endp