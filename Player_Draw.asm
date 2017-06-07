
INCLUDE lib.inc

.code
playerDraw PROC USES eax edi ecx edx esi ebx,
		setPtr:ptr Bullet,
		playerPos:coord,
		BulletSize:dword,
		num:byte
		
	mov esi, setPtr

	mov dh, byte ptr playerPos.y
	mov dl, byte ptr playerPos.x
	call Gotoxy
	mov ax, playerIcon
	call WriteChar
	mov ecx, BulletSize
	mov ebx, 4
	cmp num, 3
	jne BulletDrawCheck
	movzx ebx, num
	
	BulletDrawCheck:
		cmp byte ptr (Bullet ptr [esi]).co.y, 5
		ja DrawBullet
		add setPtr, type Bullet
		loop BulletDrawCheck
		jmp BREAK1
	TooFar:
		loop BulletDrawCheck
		jmp BREAK1
	DrawBullet:
		cmp ebx, 4
		jne DrawThreeBullet
		mov dh, byte ptr (Bullet ptr [esi]).co.y
		mov dl, byte ptr (Bullet ptr [esi]).co.x
		inc dh
		call Gotoxy
		.if dl!=byte ptr playerPos.x||dh!=byte ptr playerPos.y
		mov ax, ' '
		call WriteChar
		.endif
		mov dh, byte ptr (Bullet ptr [esi]).co.y
		mov dl, byte ptr (Bullet ptr [esi]).co.x
		cmp dl, Rbound
		jna Print
	NotPrint:
		mov dh, byte ptr (Bullet ptr [esi]).co.y
		mov dl, byte ptr (Bullet ptr [esi]).co.x
		call Gotoxy
		mov ax, ' '
		call WriteChar
		dec byte ptr (Bullet ptr [esi]).co.y
		jmp Ignore
	Print:
		cmp dl, Lbound
		jb NotPrint
		call Gotoxy
		mov ax, bulletIcon
		call WriteChar
		dec byte ptr (Bullet ptr [esi]).co.y
		cmp byte ptr (Bullet ptr [esi]).co.y, 5
		jne Ignore
		mov dh, byte ptr (Bullet ptr [esi]).co.y
		mov dl, byte ptr (Bullet ptr [esi]).co.x
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
		mov dh, byte ptr (Bullet ptr [esi]).co.y
		mov dl, byte ptr (Bullet ptr [esi]).co.x
		inc dh
		inc dl
		call Gotoxy
		.if dl!=byte ptr playerPos.x||dh!=byte ptr playerPos.y
		mov ax, ' '
		call WriteChar
		.endif
		mov dh, byte ptr (Bullet ptr [esi]).co.y
		mov dl, byte ptr (Bullet ptr [esi]).co.x
		cmp dl, Rbound
		jna Print2
	NotPrint2:
		mov dh, byte ptr (Bullet ptr [esi]).co.y
		mov dl, byte ptr (Bullet ptr [esi]).co.x
		call Gotoxy
		mov ax, ' '
		call WriteChar
		dec byte ptr (Bullet ptr [esi]).co.y
		dec byte ptr (Bullet ptr [esi]).co.x
		jmp Ignore2
	Print2:
		cmp dl, Lbound
		jb NotPrint2
		call Gotoxy
		mov ax, bulletIcon
		call WriteChar
		dec byte ptr (Bullet ptr [esi]).co.y
		dec byte ptr (Bullet ptr [esi]).co.x
		cmp byte ptr (Bullet ptr [esi]).co.y, 5
		jne Ignore2
		mov dh, byte ptr (Bullet ptr [esi]).co.y
		mov dl, byte ptr (Bullet ptr [esi]).co.x
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
		mov dh, byte ptr (Bullet ptr [esi]).co.y
		mov dl, byte ptr (Bullet ptr [esi]).co.x
		inc dh
		call Gotoxy
		.if dl!=byte ptr playerPos.x||dh!=byte ptr playerPos.y
		mov ax, ' '
		call WriteChar
		.endif
		mov dh, byte ptr (Bullet ptr [esi]).co.y
		mov dl, byte ptr (Bullet ptr [esi]).co.x
		cmp dl, Rbound
		jna Print3
	NotPrint3:
		mov dh, byte ptr (Bullet ptr [esi]).co.y
		mov dl, byte ptr (Bullet ptr [esi]).co.x
		call Gotoxy
		mov ax, ' '
		call WriteChar
		dec byte ptr (Bullet ptr [esi]).co.y
		jmp Ignore3
	Print3:
		cmp dl, Lbound
		jb NotPrint3
		call Gotoxy
		mov ax, bulletIcon
		call WriteChar
		dec byte ptr (Bullet ptr [esi]).co.y
		cmp byte ptr (Bullet ptr [esi]).co.y, 5
		jne Ignore3
		mov dh, byte ptr (Bullet ptr [esi]).co.y
		mov dl, byte ptr (Bullet ptr [esi]).co.x
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
		mov dh, byte ptr (Bullet ptr [esi]).co.y
		mov dl, byte ptr (Bullet ptr [esi]).co.x
		inc dh
		dec dl
		call Gotoxy
		.if dl!=byte ptr playerPos.x||dh!=byte ptr playerPos.y
		mov ax, ' '
		call WriteChar
		.endif
		mov dh, byte ptr (Bullet ptr [esi]).co.y
		mov dl, byte ptr (Bullet ptr [esi]).co.x
		cmp dl, Rbound
		jna Print4
	NotPrint4:
		mov dh, byte ptr (Bullet ptr [esi]).co.y
		mov dl, byte ptr (Bullet ptr [esi]).co.x
		call Gotoxy
		mov ax, ' '
		call WriteChar
		dec byte ptr (Bullet ptr [esi]).co.y
		inc byte ptr (Bullet ptr [esi]).co.x
		jmp Ignore4
	Print4:
		cmp dl, Lbound
		jb NotPrint4
		call Gotoxy
		mov ax, bulletIcon
		call WriteChar
		dec byte ptr (Bullet ptr [esi]).co.y
		inc byte ptr (Bullet ptr [esi]).co.x
		cmp byte ptr (Bullet ptr [esi]).co.y, 5
		jne Ignore4
		mov dh, byte ptr (Bullet ptr [esi]).co.y
		mov dl, byte ptr (Bullet ptr [esi]).co.x
		inc dh
		dec dl
		call Gotoxy
		mov ax, ' '
		call WriteChar
	Ignore4:
		inc esi
		dec ebx
		jmp TooFar
BREAK1:
	ret
playerDraw endp
end