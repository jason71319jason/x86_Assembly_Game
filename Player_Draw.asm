
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
	mov ebx, bulletStat1
	cmp num, 3
	jne BulletDrawCheck
	movzx ebx, num
	
	BulletDrawCheck:
		cmp byte ptr (Bullet ptr [esi]).co.y, BUBound
		ja DrawBullet
		add esi, type Bullet
		loop BulletDrawCheck
		jmp BREAK1
	TooFar:
		loop BulletDrawCheck
		jmp BREAK1
	DrawBullet:
		mov dh, byte ptr (Bullet ptr [esi]).co.y
		mov dl, byte ptr (Bullet ptr [esi]).co.x
		INVOKE LastBulletPosition,
			dl,
			dh,
			ebx
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
		INVOKE BulletMove,
			ebx,
			esi
		cmp byte ptr (Bullet ptr [esi]).co.y, 5
		jne Ignore
		mov dh, byte ptr (Bullet ptr [esi]).co.y
		mov dl, byte ptr (Bullet ptr [esi]).co.x
		INVOKE LastBulletPosition,
			dl,
			dh,
			ebx
		call Gotoxy
		mov ax, ' '
		call WriteChar
	Ignore:
		add esi, type Bullet
		cmp ebx, bulletStat1
		je StayState
		dec ebx
		.if ebx==0
		mov ebx, 3
		.endif
	StayState:
		jmp TooFar
BREAK1:
	ret
playerDraw endp
end