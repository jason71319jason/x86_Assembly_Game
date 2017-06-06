INCLUDE Irvine32.inc
INCLUDE Player.inc
.code
Draw PROC USES eax edi ecx edx esi ebx,
		bulletLocationX: PTR DWORD,
		bulletLocationY: PTR DWORD,
		playerX3: byte,
		playerY3: byte,
		playerPosition2: word,
		BulletLength2: DWORD,
		bulletPosition: word,
		BulletNum3:byte
		
	mov edi, bulletLocationY
	mov esi, bulletLocationX
	;call Clrscr
	mov dh, playerY3
	mov dl, playerX3
	call Gotoxy
	mov ax, playerPosition2
	call WriteChar
	mov ecx, BulletLength2
	mov ebx, 4
	cmp BulletNum3, 3
	jne BulletDrawCheck
	movzx ebx, BulletNum3
	
	BulletDrawCheck:
		cmp BYTE PTR[edi], 0
		jne DrawBullet
		inc edi
		inc esi
		loop BulletDrawCheck
		jmp BREAK1
	DrawBullet:
		cmp ebx, 4
		jne DrawThreeBullet
		mov dh, BYTE PTR[edi]
		inc dh
		mov dl, BYTE PTR[esi]
		call Gotoxy
		mov ax, ' '
		call WriteChar
		mov dh, BYTE PTR[edi]
		mov dl, BYTE PTR[esi]
		call Gotoxy
		mov ax, bulletPosition
		call WriteChar
		dec BYTE PTR[edi]
		cmp BYTE PTR[edi], 0
		jne Ignore
		mov dh, BYTE PTR[edi]
		mov dl, BYTE PTR[esi]
		inc dh
		call Gotoxy
		mov ax, ' '
		call WriteChar
	Ignore:
		inc edi
		inc esi
		loop BulletDrawCheck
		jmp BREAK1
	TooFar:
		loop BulletDrawCheck
		jmp BREAK1
	DrawThreeBullet:
		cmp ebx, 2
		je DrawThreeBullet2
		cmp ebx, 1
		je DrawThreeBullet3
		cmp ebx, 0
		mov ebx, 3
		mov dh, BYTE PTR[edi]
		mov dl, BYTE PTR[esi]
		inc dh
		inc dl
		call Gotoxy
		mov ax, ' '
		call WriteChar
		mov dh, BYTE PTR[edi]
		mov dl, BYTE PTR[esi]
		call Gotoxy
		mov ax, bulletPosition
		call WriteChar
		dec BYTE PTR[edi]
		dec BYTE PTR[esi]
		cmp BYTE PTR[edi], 0
		jne Ignore2
		mov dh, BYTE PTR[edi]
		mov dl, BYTE PTR[esi]
		inc dl
		inc dh
		call Gotoxy
		mov ax, ' '
		call WriteChar
	Ignore2:
		inc edi
		inc esi
		dec ebx
		jmp TooFar
	DrawThreeBullet2:
		mov dh, BYTE PTR[edi]
		mov dl, BYTE PTR[esi]
		inc dh
		call Gotoxy
		mov ax, ' '
		call WriteChar
		mov dh, BYTE PTR[edi]
		mov dl, BYTE PTR[esi]
		call Gotoxy
		mov ax, bulletPosition
		call WriteChar
		dec BYTE PTR[edi]
		cmp BYTE PTR[edi], 0
		jne Ignore3
		mov dh, BYTE PTR[edi]
		mov dl, BYTE PTR[esi]
		inc dh
		call Gotoxy
		mov ax, ' '
		call WriteChar
	Ignore3:
		inc edi
		inc esi
		dec ebx
		jmp TooFar
	DrawThreeBullet3:
		mov dh, BYTE PTR[edi]
		mov dl, BYTE PTR[esi]
		inc dh
		dec dl
		call Gotoxy
		mov ax, ' '
		call WriteChar
		mov dh, BYTE PTR[edi]
		mov dl, BYTE PTR[esi]
		call Gotoxy
		mov ax, bulletPosition
		call WriteChar
		dec BYTE PTR[edi]
		inc BYTE PTR[esi]
		cmp BYTE PTR[edi], 0
		jne Ignore4
		mov dh, BYTE PTR[edi]
		mov dl, BYTE PTR[esi]
		inc dh
		dec dl
		call Gotoxy
		mov ax, ' '
		call WriteChar
	Ignore4:
		inc edi
		inc esi
		dec ebx
		jmp TooFar
BREAK1:
	ret
Draw endp
end