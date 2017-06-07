INCLUDE Irvine32.inc
INCLUDE Player.inc
.data
Rbound byte 187
Lbound byte 2
Ubound byte 7
Dbound byte 43
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
		cmp BYTE PTR[edi], 5
		ja DrawBullet
		;cmp byte PTR[esi], 0
		;je NoLast
		;mov dh, byte PTR[edi]
		;mov dl, byte PTR[esi]
		;cmp ebx, 4
		;je NotThree
		;cmp ebx, 3
		;jne NextCheck
		;inc dh
		;inc dl
		;dec ebx
		;jmp ContinueDraw
	;NextCheck:
		;cmp ebx, 2
		;jne NextCheck2
		;inc dh
		;dec ebx
		;jmp ContinueDraw
	;NextCheck2:
		;inc dh
		;dec dl
		;dec ebx
		;mov ebx, 3
		;jmp ContinueDraw
	;NotThree:
		;inc dh
	;ContinueDraw:
		;call Gotoxy
		;mov ax, ' '
		;call WriteChar
		;mov byte PTR[esi], 0
	;NoLast:
		inc edi
		inc esi
		loop BulletDrawCheck
		jmp BREAK1
	TooFar:
		loop BulletDrawCheck
		jmp BREAK1
	DrawBullet:
		cmp ebx, 4
		jne DrawThreeBullet
		mov dh, byte PTR[edi]
		mov dl, byte PTR[esi]
		inc dh
		call Gotoxy
		.if dl!=playerX3||dh!=playerY3
		mov ax, ' '
		call WriteChar
		.endif
		mov dh, byte PTR[edi]
		mov dl, byte PTR[esi]
		cmp dl, Rbound
		jna Print
	NotPrint:
		mov dh, byte PTR[edi]
		mov dl, byte PTR[esi]
		call Gotoxy
		mov ax, ' '
		call WriteChar
		dec byte PTR[edi]
		jmp Ignore
	Print:
		cmp dl, Lbound
		jb NotPrint
		call Gotoxy
		mov ax, bulletPosition
		call WriteChar
		dec byte PTR[edi]
		cmp byte PTR[edi], 5
		jne Ignore
		mov dh, byte PTR[edi]
		mov dl, byte PTR[esi]
		inc dh
		call Gotoxy
		mov ax, ' '
		call WriteChar
	Ignore:
		inc edi
		inc esi
		jmp TooFar
	DrawThreeBullet:
		cmp ebx, 2
		je DrawThreeBullet2
		cmp ebx, 1
		je DrawThreeBullet3
		cmp ebx, 0
		mov ebx, 3
		mov dh, byte PTR[edi]
		mov dl, byte PTR[esi]
		inc dh
		inc dl
		call Gotoxy
		.if dl!=playerX3||dh!=playerY3
		mov ax, ' '
		call WriteChar
		.endif
		mov dh, byte PTR[edi]
		mov dl, byte PTR[esi]
		cmp dl, Rbound
		jna Print2
	NotPrint2:
		mov dh, byte PTR[edi]
		mov dl, byte PTR[esi]
		call Gotoxy
		mov ax, ' '
		call WriteChar
		dec byte PTR[edi]
		dec byte PTR[esi]
		jmp Ignore2
	Print2:
		cmp dl, Lbound
		jb NotPrint2
		call Gotoxy
		mov ax, bulletPosition
		call WriteChar
		dec byte PTR[edi]
		dec byte PTR[esi]
		cmp byte PTR[edi], 5
		jne Ignore2
		mov dh, byte PTR[edi]
		mov dl, byte PTR[esi]
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
		mov dh, byte PTR[edi]
		mov dl, byte PTR[esi]
		inc dh
		call Gotoxy
		.if dl!=playerX3||dh!=playerY3
		mov ax, ' '
		call WriteChar
		.endif
		mov dh, byte PTR[edi]
		mov dl, byte PTR[esi]
		cmp dl, Rbound
		jna Print3
	NotPrint3:
		mov dh, byte PTR[edi]
		mov dl, byte PTR[esi]
		call Gotoxy
		mov ax, ' '
		call WriteChar
		dec byte PTR[edi]
		jmp Ignore3
	Print3:
		cmp dl, Lbound
		jb NotPrint3
		call Gotoxy
		mov ax, bulletPosition
		call WriteChar
		dec byte PTR[edi]
		cmp byte PTR[edi], 5
		jne Ignore3
		mov dh, byte PTR[edi]
		mov dl, byte PTR[esi]
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
		mov dh, byte PTR[edi]
		mov dl, byte PTR[esi]
		inc dh
		dec dl
		call Gotoxy
		.if dl!=playerX3||dh!=playerY3
		mov ax, ' '
		call WriteChar
		.endif
		mov dh, byte PTR[edi]
		mov dl, byte PTR[esi]
		cmp dl, Rbound
		jna Print4
	NotPrint4:
		mov dh, byte PTR[edi]
		mov dl, byte PTR[esi]
		call Gotoxy
		mov ax, ' '
		call WriteChar
		dec byte PTR[edi]
		inc byte PTR[esi]
		jmp Ignore4
	Print4:
		cmp dl, Lbound
		jb NotPrint4
		call Gotoxy
		mov ax, bulletPosition
		call WriteChar
		dec byte PTR[edi]
		inc byte PTR[esi]
		cmp byte PTR[edi], 5
		jne Ignore4
		mov dh, byte PTR[edi]
		mov dl, byte PTR[esi]
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